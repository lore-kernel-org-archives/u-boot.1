Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA2E6ADD5
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 08:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CFE88E77;
	Sat, 23 Nov 2024 09:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AXlMxw/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D6888EA8; Sat, 23 Nov 2024 09:49:00 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE1F88E77
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 09:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9750E3F77D; 
 Sat, 23 Nov 2024 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732351735;
 bh=C38epuQMVCU/O+hflsEh0BBWDSQBZ1FWJ7TH2VJte/Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AXlMxw/zeAX18+0e/AI6PHOVbkwMFBhNZj4MBClMM00trM87eIc4q8rN3P320zS1C
 akZe+SfdbdEMhw7aBNj/4XqJcZC4LB7t8+tFSwTx/F0SnfgX57uHuFXWOTQhzlf56S
 18ne89SEzGjv2nzoRHoJJFXtrjjWAMsNUjRL6puPAAE0GIFYHQukGOQ46sAJX8ZdiV
 dldRHf4AdvuQdwLK7utGefOm9y895H00KjBzJ259lhpISlY0j+T3F2gpH0IDsBv9df
 Bz/3VcZ/d7VWpscJg4FPgBWsb1k2M3uFblfKtH7aIOHkwnyzxgIQgZMftkcw5upBEj
 aXw+UxDB+b5aQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
Date: Sat, 23 Nov 2024 09:48:53 +0100
Message-ID: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

On many 32-bit ARM boards including QEMU memory starts at 0x40000000.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/examples/api/Makefile b/examples/api/Makefile
index 722c7e45904..f0f107562f1 100644
--- a/examples/api/Makefile
+++ b/examples/api/Makefile
@@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
 LOAD_ADDR = 0x40000
 endif
 ifeq ($(ARCH),arm)
-ifdef CONFIG_64BIT
 LOAD_ADDR = 0x40400000
-else
-LOAD_ADDR = 0x1000000
-endif
 endif
 ifeq ($(ARCH),mips)
 ifdef CONFIG_64BIT
-- 
2.45.2

