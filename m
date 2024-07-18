Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4324DC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8858788B54;
	Thu, 18 Jul 2024 19:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FNMayAnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC99488B20; Thu, 18 Jul 2024 19:36:44 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CEB88AFC
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so5308625e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324198; x=1721928998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7W6VRTiC52CR1Q1hFQqYfIxU58dRf/5d0w2T3SZSOk=;
 b=FNMayAnLusXR+44QF19497n+Lu4fpXPLCdMGVReCZ+8NGdNeg3/8jc9MGYnqmEBdX0
 3BJMJSIQzjxn19f+un4uYxBEtY74eNVz3K8kMrt3airvnnzgWe9fwouweNJqKWbsst8V
 pZz3cDyLlFF3gsGMfINAzb/oCM0ZED8bvMjbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324198; x=1721928998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7W6VRTiC52CR1Q1hFQqYfIxU58dRf/5d0w2T3SZSOk=;
 b=tXYOTtWG76nMfw0QVwWMOX+dMMfIzTjS5/N1WsqORjVAuDof2J8LJzATHoYrW2XSfA
 g1MhQy+ofoJJcMlPTEsZ72/pjB2+tUTFi2rsdLlOL3TEsE4q8Gf1a+6npzq0tpuNi2Kg
 R8DVL5SIemTnLdI4v/FjfMyTguO+PpizxZhjypn2fBvlHBW27mf2LUZO6a1j0j5D7LZS
 +OF6cfEx2w6MX3rOK0QEzqqv+3+vY6fPD2ALgcekpwBPiar1TCxO8f5G2ahqTry/BN0Y
 PEDg11Dov/cB52L7mlcPujBJtUAywnczeEpRHFsjiT1RPK9D1IZ+VYqd0vPHsdie7Knh
 7mKA==
X-Gm-Message-State: AOJu0YyOytkb/LqLglUxz4sttxG4mFWNBUKjA8P5O7njcnp86S21c5kP
 5CQCQnSefOzWxG3SJ40du+pfcgMdIM6uuKjrU+C6uqRTTA2nNAjvgMbe4xHLVUcHkByJMbwx/1Y
 =
X-Google-Smtp-Source: AGHT+IEG+lTMREE3P4w3j7IKXMQhKFhF+8w2+rKdrOhjtK+hTYGypvFUMieUctsemdMMyRQ2oVpdfQ==
X-Received: by 2002:a05:600c:138b:b0:426:5c9b:dedf with SMTP id
 5b1f17b1804b1-427c2cb6112mr40158035e9.12.1721324198257; 
 Thu, 18 Jul 2024 10:36:38 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Markus Niebel <Markus.Niebel@tq-group.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Philip Richard Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 04/20] i2c: Remove CFG_I2C_MULTI_BUS
Date: Thu, 18 Jul 2024 18:35:55 +0100
Message-Id: <20240718173611.4014274-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

This is used by a few boards but we are years past the migration date,
so let's drop it now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 README                         |  7 -------
 include/configs/omap3_beagle.h |  3 ---
 include/configs/sniper.h       | 14 --------------
 include/configs/tqma6.h        |  3 ---
 include/i2c.h                  |  2 +-
 5 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/README b/README
index b89768f1791..9fd2aee4b04 100644
--- a/README
+++ b/README
@@ -883,13 +883,6 @@ The following options need to be configured:
 		You should define these to the GPIO value as given directly to
 		the generic GPIO functions.
 
-		CFG_I2C_MULTI_BUS
-
-		This option allows the use of multiple I2C buses, each of which
-		must have a controller.	 At any point in time, only one bus is
-		active.	 To switch to a different bus, use the 'i2c dev' command.
-		Note that bus numbering is zero-based.
-
 		CFG_SYS_I2C_NOPROBES
 
 		This option specifies a list of I2C devices that will be skipped
diff --git a/include/configs/omap3_beagle.h b/include/configs/omap3_beagle.h
index af7cb3513f8..b616dd2608c 100644
--- a/include/configs/omap3_beagle.h
+++ b/include/configs/omap3_beagle.h
@@ -28,9 +28,6 @@
 /* NAND: SPL falcon mode configs */
 #endif /* CONFIG_MTD_RAW_NAND */
 
-/* Enable Multi Bus support for I2C */
-#define CFG_I2C_MULTI_BUS
-
 /* DSS Support */
 
 /* TWL4030 LED Support */
diff --git a/include/configs/sniper.h b/include/configs/sniper.h
index 45a3102aeee..d0ae5e18605 100644
--- a/include/configs/sniper.h
+++ b/include/configs/sniper.h
@@ -34,20 +34,6 @@
 
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
-/*
- * I2C
- */
-
-#define CFG_I2C_MULTI_BUS
-
-/*
- * Input
- */
-
-/*
- * SPL
- */
-
 /*
  * Serial
  */
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 2da76f15431..ceeed174ec5 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -26,9 +26,6 @@
 
 #define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
 
-/* I2C Configs */
-#define CFG_I2C_MULTI_BUS
-
 #if !defined(CONFIG_DM_PMIC)
 #define CFG_POWER_PFUZE100_I2C_ADDR	0x08
 #define TQMA6_PFUZE100_I2C_BUS		2
diff --git a/include/i2c.h b/include/i2c.h
index 1d3be3f6759..622540c8265 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -942,7 +942,7 @@ unsigned int i2c_get_bus_speed(void);
  * only for backwardcompatibility, should go away if we switched
  * completely to new multibus support.
  */
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY) || defined(CFG_I2C_MULTI_BUS)
+#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 # if !defined(CFG_SYS_MAX_I2C_BUS)
 #  define CFG_SYS_MAX_I2C_BUS		2
 # endif
-- 
2.34.1

