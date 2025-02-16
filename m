Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A0C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D2880F0B;
	Sun, 16 Feb 2025 12:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AKJkuC0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF3680F18; Sun, 16 Feb 2025 12:12:57 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96FE8056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BA9503FF2E; 
 Sun, 16 Feb 2025 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739704375;
 bh=swOCd6c2NqDtLyc+ojVsKbYghVy3/AqZhERLqUjbobc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AKJkuC0ZXijad6GNAugs7RFR8FopbeTL2zf94TRHmdXSVSrisgpEM1GNsvNwBVGny
 Qn5Sl+YaAYQG/z6cgWD/8RtxZK+h671M7Ka0Zk/riALlXdBaajLOckj4ZbCRNZva+U
 B4AVn6+4bDEEpJ1vRVpWu6kuFaWbDPAbKu/fNh7JsE4nr4eeKtG1dcakllDgujp5DJ
 b2wa3p5z8V1a+fAT7kXrzX4s7m5ccQwox7MfLHqN6XzauDa7wa6AU4PaMU6QxvkDxk
 EzRYY7HAWRBU3/NU6iNc+joGUfwpyigIxXMmNn53aAZ//KzDecqD9YhALyuiLyvALn
 Z/QyP50XA823w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] lmb: move lmb_map_update_notify() to EFI
Date: Sun, 16 Feb 2025 12:12:38 +0100
Message-ID: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

When building with qemu_arm64_defconfig with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
and CONFIG_EFI_LOADER an error undefined reference to efi_add_memory_map_pg
occurs.

Move the EFI dependent part of lmb_map_update_notify() to the EFI
sub-system and clean up a little.

Thanks to Liya for reporting the issue and providing a first patch.

Heinrich Schuchardt (3):
  lmb: avoid superfluous value check in lmb_map_update_notify()
  lmb: move lmb_map_update_notify() to EFI
  efi_loader: make efi_add_memory_map_pg() static

 include/efi_loader.h        | 30 ++++++++++-----------
 include/lmb.h               | 12 +++++++++
 lib/efi_loader/efi_memory.c | 28 ++++++++++++++++++++
 lib/lmb.c                   | 52 +++++++------------------------------
 4 files changed, 64 insertions(+), 58 deletions(-)

-- 
2.47.1

