Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A7FC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A8788852;
	Sat, 13 Jul 2024 15:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZLxxPaTg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="stquchfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C59288850; Sat, 13 Jul 2024 15:21:19 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1A2887E3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpy51Qwgz9sWq;
 Sat, 13 Jul 2024 15:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+4CFGrjU83x4pePq93PNdyax68B3vq1Y3Yxg0A/Y08=;
 b=ZLxxPaTgq3I6JUrcwJBhQpwQuNb4fQzvoaVYfL/KTMQDdfItrp/OycWx5xwFHaq7lUszQn
 LyArzg5pN6jzlp3rt/wxl/FKNfYfgbGr9s7DU4s44khFL5dRI1ufZ4xRJndq3qklTTt0HN
 oxyCktpF31ZkEe89iUScxyQ79VZDQme7MIvnqr81Qqj2gOPkjLLnax26bU1EHLn2u3yo3s
 n0e2018OcL86sA3Qe0EDyaYSKdfB5hc/ZXH2C+DUszhd/ZEu5eG/a6Ksa7PTXomfLsO8st
 A4/9G6QOdBXwlQwnjldtf0UTuXty0F+Ao64DySLvyML1HdchWUTUqT3DNFFybA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+4CFGrjU83x4pePq93PNdyax68B3vq1Y3Yxg0A/Y08=;
 b=stquchfdM3uVU6IOQhz6KzQzY8GT+/M7C7LPkUAovlTrA0+1eBobtJgovVYBxLURcrKkAf
 6aPxiNDiASOX0pBamUZCB0PdPE3riS7MKV32byJQpyTQyhfOkIjJcWzMYktsynlenO3DJk
 +3nRAPTLTAfwvZXHl6BKnJ1y3Byz6LC0VFaZMhlJTjJ4chhJE/KZNPr2lm0qFCqjqqFM45
 GCKPzsjhUmHgIykiqss40k5HafvVdsUMLGCCJs+JoVQCZ/LIPEcUPnORsV1P6oS1ilQaIP
 7+OT9KdSfNA5UGDpFkcQZf6CJESj3oMv5hkJGQ3cmD2oURvZp3PHQeJwEz0iPw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/45] arm: include: ti: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:01 +0200
Message-ID: <20240713132021.57650-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d99e3c3fe068cfadda9
X-MBO-RS-META: urzx13c1r4qwpjt7roaxef1hbsb44xyq
X-Rspamd-Queue-Id: 4WLpy51Qwgz9sWq
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-omap3/mem.h          | 1 -
 arch/arm/include/asm/arch-omap3/mmc_host_def.h | 1 -
 arch/arm/include/asm/arch-omap4/clock.h        | 1 -
 arch/arm/include/asm/arch-omap5/clock.h        | 1 -
 arch/arm/include/asm/arch-omap5/gpio.h         | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/arch-omap3/mem.h
index fce3568eca1..2b6cfde4114 100644
--- a/arch/arm/include/asm/arch-omap3/mem.h
+++ b/arch/arm/include/asm/arch-omap3/mem.h
@@ -463,7 +463,6 @@ enum {
 #define NET_LAN9221_GPMC_CONFIG6    0x87030000
 #define NET_LAN9221_GPMC_CONFIG7    0x00000f6c
 
-
 /* max number of GPMC Chip Selects */
 #define GPMC_MAX_CS	8
 /* max number of GPMC regs */
diff --git a/arch/arm/include/asm/arch-omap3/mmc_host_def.h b/arch/arm/include/asm/arch-omap3/mmc_host_def.h
index 39a7cba0f6b..2e34989ef9f 100644
--- a/arch/arm/include/asm/arch-omap3/mmc_host_def.h
+++ b/arch/arm/include/asm/arch-omap3/mmc_host_def.h
@@ -63,5 +63,4 @@ typedef struct t2 {
 #define OMAP_HSMMC2_BASE	0x480B4000
 #define OMAP_HSMMC3_BASE	0x480AD000
 
-
 #endif /* MMC_HOST_DEF_H */
diff --git a/arch/arm/include/asm/arch-omap4/clock.h b/arch/arm/include/asm/arch-omap4/clock.h
index 4054dd8edcb..50436e828b0 100644
--- a/arch/arm/include/asm/arch-omap4/clock.h
+++ b/arch/arm/include/asm/arch-omap4/clock.h
@@ -100,7 +100,6 @@
 #define CD_CLKCTRL_CLKTRCTRL_SW_WKUP		2
 #define CD_CLKCTRL_CLKTRCTRL_HW_AUTO		3
 
-
 /* CM_<clock_domain>_<module>_CLKCTRL */
 #define MODULE_CLKCTRL_MODULEMODE_SHIFT		0
 #define MODULE_CLKCTRL_MODULEMODE_MASK		3
diff --git a/arch/arm/include/asm/arch-omap5/clock.h b/arch/arm/include/asm/arch-omap5/clock.h
index b18ef459dec..eeb3c6f2a6c 100644
--- a/arch/arm/include/asm/arch-omap5/clock.h
+++ b/arch/arm/include/asm/arch-omap5/clock.h
@@ -111,7 +111,6 @@
 #define CD_CLKCTRL_CLKTRCTRL_SW_WKUP		2
 #define CD_CLKCTRL_CLKTRCTRL_HW_AUTO		3
 
-
 /* CM_<clock_domain>_<module>_CLKCTRL */
 #define MODULE_CLKCTRL_MODULEMODE_SHIFT		0
 #define MODULE_CLKCTRL_MODULEMODE_MASK		3
diff --git a/arch/arm/include/asm/arch-omap5/gpio.h b/arch/arm/include/asm/arch-omap5/gpio.h
index 1e44fb5ae97..efd816be2c6 100644
--- a/arch/arm/include/asm/arch-omap5/gpio.h
+++ b/arch/arm/include/asm/arch-omap5/gpio.h
@@ -33,7 +33,6 @@
 #define OMAP54XX_GPIO7_BASE		0x48051000
 #define OMAP54XX_GPIO8_BASE		0x48053000
 
-
 /* Get the GPIO index from the given bank number and bank gpio */
 #define GPIO_TO_PIN(bank, bank_gpio)	(32 * (bank - 1) + (bank_gpio))
 
-- 
2.43.0

