Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F82CCFA18
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906D683C62;
	Thu, 13 Nov 2025 07:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fJXNlsYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD0F83DA9; Thu, 13 Nov 2025 07:47:28 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE82483C54
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CE54B40612; 
 Thu, 13 Nov 2025 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016446;
 bh=qp6cA5n6MBdx2gEZzirRcWMLtTgOJKj6KHfcSCYP+l8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fJXNlsYttvb+Bc0CXHGaocuY6T30n/NZVFtRZeekws4ctDk7bxVE02TVeV9gauV8z
 rVEtQtvCcMrCqQW27Bk+W0B9XAO76DybPuag8ClAyTn1kN6gN0grvjQ3GexlvxwhGk
 hjobT/ZIVtGhZU//+NAAFkdf4IZDZF04SHnZMs5VArMxyTkShv+sj/jobvXZFoOVHx
 wP6CpFa/wT4c1/1SehAIAA6Dtnqf2MrgUux/NjNKxm6pqLKft2XnrmxwkIlvnPL7KR
 Pvm+Q9inHUTU3qDGfIaeDajVNQ1NmKALEa7w9J0qZcrZKyM6jB46Hi7zCFXHjQ9R9f
 PHC5UM4gimTj0ksZ5CkWEbnfPe8I6MspFhIPCYUwHWpoyUv2P9tx9FJ3VlcENO/Bxw
 joTfleLI0oZNELISgzNwgtSlXWy5cHWleTqP7Q6uDC+u5PW7oZregbll+nspYxs6IJ
 EuzFvIX1L6wcEzVoyJPQRdhS9cmrPSMk3Mxcth82YEK0IFcjCkyyRZW1BEwHn7rn93
 zwziHDUbzKYbEtm4LTbzNYNjrpbN3f/yEoZNAb1QYpo7xfyXl13OtLHDygNqionPD2
 eY9yP8t0oaAlS4mjLUdcekkvy8CtpSmEf9qIL//yrgs67BKQgaTqt2OjCS7XGiaTvX
 rnQvA51T1AwUCVWyuX/O98zo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/6] fat: Some code improvements
Date: Thu, 13 Nov 2025 07:46:50 +0100
Message-ID: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Simon Glass <simon.glass@canonical.com>

This is an attempt to improve the structure of the FAT code, since it
doesn't fully follow the U-Boot conventions:

- fat_write.c includes fat.c which is odd
- use of __u32 and its ilk
- use of typedef
- old-style struct comments

This series resolves these problems, making it easier to take on other
improvements in future.

Simon Glass (6):
  fat: Create an internal header file
  fat: Separate fat.c from fat_write.c
  fat: Update struct fat_itr to kernel-doc style
  fat: Remove typedefs in fat.h
  fat: Convert fat.h to kernel-doc style
  fat: Use standard types for fixed-size values

 fs/fat/Makefile       |   2 +-
 fs/fat/fat.c          | 316 +++++++++-------------------------
 fs/fat/fat_internal.h | 171 +++++++++++++++++++
 fs/fat/fat_write.c    | 247 ++++++++++++++-------------
 include/fat.h         | 385 +++++++++++++++++++++++++++++++++---------
 5 files changed, 678 insertions(+), 443 deletions(-)
 create mode 100644 fs/fat/fat_internal.h

-- 
2.51.0

