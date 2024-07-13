Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9614DC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F92888CC;
	Sat, 13 Jul 2024 15:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nuqXd427";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GuNA5NGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74D3888EC; Sat, 13 Jul 2024 15:21:43 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7260C888E7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyY1Klfz9scm;
 Sat, 13 Jul 2024 15:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PG0Gc8W/G2mhuQTPN+BSwWf0xPKm2wJFze4E4mHl41U=;
 b=nuqXd427vltgHfGZ8igu9qFHU2oku8q4iBf2sHDK4bzpVGrQu9nvUMKx6UsNnEGJHo1cFB
 OIKVK4xCdf7NjBCI800tVrk4HCVKu0wMg+JEGjf/ZJfECGJYji/BZkBk09mfsAtB+Pp3pW
 T8iZdF3EKJWJdRw1r4Ujj1Nag11DzzrTlFBnk3SSGYAtZK7v0L+ouQNPhtFurvNeR/3w8/
 0BqTgvdwoUObuhtSSf6Dnrg2qm6Ff1Dqfa0INstI6YJcdJZ2h78/5WJjGcceUOYqu0xgNF
 NTOzQg/hCNTjIG1MzQYwpfD96R2WxBiX3fX/EvW3QIuTFFL/gtFUo9jRXwjQeg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PG0Gc8W/G2mhuQTPN+BSwWf0xPKm2wJFze4E4mHl41U=;
 b=GuNA5NGLxfo/9GKaaw/oiE4PerEjHzQKCHwAm4zPA5MavmTrakgU6VG2VLV5j08VjbOGxa
 ja4GIJJIfCaEW13i1UYgs84u9pJ9Cl0scDERjZ0B/EBEdedT+NCxUCqvKh5LDi9PEt9bFH
 J+qCUDER82anZ27cn17BEGMNwbMHuYWvXCamV1HTMYIS2ndF/m3TIpJxRxjgtSPtg95dYx
 cPOIY5yzqFrVkyPwSX5RTiUuVnKR+RtzjOzY9/Qx+W4MJaDHgG0rXK7xzhXO1n0k1hvhUx
 n8ba6kHCy7R6yY03RjCjwQLCgz+DZjeLfawd4viRTKsUg+BYxjNnusId4WdCWA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 32/45] m68k: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:23 +0200
Message-ID: <20240713132021.57650-32-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c021161fb6e3b012c9f
X-MBO-RS-META: dsnt6hk9es7d4mrccttyfdbhb5tgso6r
X-Rspamd-Queue-Id: 4WLpyY1Klfz9scm
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
 arch/m68k/include/asm/bitops.h     | 1 -
 arch/m68k/include/asm/cache.h      | 1 -
 arch/m68k/include/asm/immap_5271.h | 1 -
 arch/m68k/include/asm/immap_5275.h | 1 -
 arch/m68k/include/asm/m5441x.h     | 1 -
 arch/m68k/lib/traps.c              | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 4a3f6b97adc..c5c84c61690 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -19,7 +19,6 @@ extern int test_and_change_bit(int nr, volatile void *addr);
 
 #ifdef __KERNEL__
 
-
 static inline int test_bit(int nr, __const__ volatile void *addr)
 {
 	__const__ unsigned int *p = (__const__ unsigned int *) addr;
diff --git a/arch/m68k/include/asm/cache.h b/arch/m68k/include/asm/cache.h
index aa8d2edb40b..712b02cd89b 100644
--- a/arch/m68k/include/asm/cache.h
+++ b/arch/m68k/include/asm/cache.h
@@ -136,7 +136,6 @@
 #define CF_ACR_SP		(1 << 3)
 #endif				/* CONFIG_CF_V4 */
 
-
 #ifndef CFG_SYS_CACHE_ICACR
 #define CFG_SYS_CACHE_ICACR	0
 #endif
diff --git a/arch/m68k/include/asm/immap_5271.h b/arch/m68k/include/asm/immap_5271.h
index a5bf18c4b84..5b7db9e027b 100644
--- a/arch/m68k/include/asm/immap_5271.h
+++ b/arch/m68k/include/asm/immap_5271.h
@@ -54,5 +54,4 @@
 #include <asm/coldfire/rng.h>
 #include <asm/coldfire/skha.h>
 
-
 #endif				/* __IMMAP_5271__ */
diff --git a/arch/m68k/include/asm/immap_5275.h b/arch/m68k/include/asm/immap_5275.h
index c4cce3f94f1..e90c870c91d 100644
--- a/arch/m68k/include/asm/immap_5275.h
+++ b/arch/m68k/include/asm/immap_5275.h
@@ -223,7 +223,6 @@ typedef struct	gpio_ctrl {
 	u8 par_res2[3];
 } gpio_t;
 
-
 /* Watchdog registers
  */
 typedef struct wdog_ctrl {
diff --git a/arch/m68k/include/asm/m5441x.h b/arch/m68k/include/asm/m5441x.h
index f2e7e7fff4a..2c9f13030ff 100644
--- a/arch/m68k/include/asm/m5441x.h
+++ b/arch/m68k/include/asm/m5441x.h
@@ -700,7 +700,6 @@
 #define GPIO_PAR_FEC_FEC_MII		(0x01)	/* MDC & MDIO - GPIO */
 #define GPIO_PAR_FEC_FEC_MIIFUL	(0x00)
 
-
 /* TC: Need to edit here.... */
 
 /* Mode Select Control */
diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
index e09f36f2fdd..dafd8a9a635 100644
--- a/arch/m68k/lib/traps.c
+++ b/arch/m68k/lib/traps.c
@@ -15,7 +15,6 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 
-
 extern void _exc_handler(void);
 extern void _int_handler(void);
 
-- 
2.43.0

