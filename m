Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47791C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E47E8770E;
	Wed,  8 Nov 2023 17:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Byt/uhLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C623876F1; Wed,  8 Nov 2023 17:49:11 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F168765C
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77897c4ac1fso449494985a.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462148; x=1700066948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQuJSijJ2gUz8WD/omHLN1x7Bo3MifMlX9GtPA9ila8=;
 b=Byt/uhLtMUqhHoe1HK7yuag4HwydU0PlAhwZ3WfdPYBwYekr9bVu/J44gHC7dz00L/
 r7V0APKZdstXs/P+4CyTpXDsXAPQi+GO7JhXEBLK1fb3FeJcvgf3Ebk0BHzcsBH0dGdq
 JaOfq7W29oxFs0U4827SYy33SrfVR7NEH0HuFeEjzc/oRBcTLqkjeV+ig8akDWk4ZwBR
 +WXzi4lxTxUipKR5u4DayeMLSGepueI4qOOjmRuvdvwSTcxbKmzUP5t9lq0iy75aeGAN
 LGsZPmQe26iXlcIi6cUD+dtSffgIsXHtZi1Byg2SNTe9AwjpcXZS2j4iGP/UymgTSMoC
 IMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462148; x=1700066948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQuJSijJ2gUz8WD/omHLN1x7Bo3MifMlX9GtPA9ila8=;
 b=UJik0oUZhYuPgyx/6nBRrWD2zAhXCjB/y5bE4BAd0a5CRHDGVW31KrFdtDwnXolG1q
 d+/UqotdAdq2MS2cy5/zt8SCjiStNEKMm2deavDJWtbDcW1Qgn3DmzECqYNFVBMIRz1K
 XxCcCn6IC9p/6GX8aEHLZHBYvyNF0gtPWd1Ha433sOu83UsnocW6ubFpsGJLBKpuM/Fq
 NeSubtE6WK0SGadSfYp140q87YN2rpFEqy+Nblc1ruETFmaGhxgBq7sWygdW8Gbt7DyX
 5lk9B1ZVi8qRM0gLSBFD0onTLfxo8OqJFQjQlTXFmyHLQpr5AYN4EaqNbG/qDKWW9EZF
 +vLA==
X-Gm-Message-State: AOJu0YwkBGIM0/weZCJ8oPuEtoezYKDOsSNwY/6USObgj9dVRFltTZOu
 U/gG5kRe8IhwkVrEz3WitukvlcpbSV4=
X-Google-Smtp-Source: AGHT+IF896egc6IZxSuV+QvC9B/HJDA9zJhpsdDnSNygmVqq+VIfVvcGegqWNluMvecN7xrnhlPnLg==
X-Received: by 2002:a05:620a:1a0f:b0:774:3540:89ee with SMTP id
 bk15-20020a05620a1a0f00b00774354089eemr2403324qkb.61.1699462147876; 
 Wed, 08 Nov 2023 08:49:07 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 pc37-20020a05620a842500b00765ab6d3e81sm1216196qkn.122.2023.11.08.08.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:07 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 05/26] spl: Remove NULL assignments in spl_load_info
Date: Wed,  8 Nov 2023 11:48:37 -0500
Message-Id: <20231108164858.3497420-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

Remove NULL assignments to fields in spl_load_info when .load doesn't
reference these fields. This can result in more efficient code. filename
must stay even if it is unused, since load_simple_fit uses it.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- New

 arch/arm/mach-sunxi/spl_spi_sunxi.c | 2 --
 common/spl/spl_fat.c                | 1 -
 common/spl/spl_mmc.c                | 2 --
 common/spl/spl_nand.c               | 4 ----
 common/spl/spl_spi.c                | 2 --
 common/spl/spl_ymodem.c             | 1 -
 6 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index c2410dd7bb1..896aba69c32 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -354,8 +354,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT image\n");
-		load.dev = NULL;
-		load.priv = NULL;
 		load.filename = NULL;
 		load.bl_len = 1;
 		load.read = spi_load_read;
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 014074f85be..6172e7bcd48 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -99,7 +99,6 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 		load.read = spl_fit_read;
 		load.bl_len = 1;
 		load.filename = (void *)filename;
-		load.priv = NULL;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 82689da1401..6d9137c32e0 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -106,7 +106,6 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.dev = mmc;
-		load.priv = NULL;
 		load.filename = NULL;
 		load.bl_len = mmc->read_bl_len;
 		load.read = h_spl_load_read;
@@ -116,7 +115,6 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.dev = mmc;
-		load.priv = NULL;
 		load.filename = NULL;
 		load.bl_len = mmc->read_bl_len;
 		load.read = h_spl_load_read;
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index b8cd6403ba4..9a5a5ffa04a 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -91,7 +91,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
-		load.dev = NULL;
 		load.priv = &offset;
 		load.filename = NULL;
 		load.bl_len = bl_len;
@@ -101,7 +100,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
-		load.dev = NULL;
 		load.priv = &offset;
 		load.filename = NULL;
 		load.bl_len = bl_len;
@@ -112,8 +110,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found legacy image\n");
-		load.dev = NULL;
-		load.priv = NULL;
 		load.filename = NULL;
 		load.bl_len = IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1;
 		load.read = spl_nand_legacy_read;
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 3ac4b1b5091..d83d70f2f33 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -152,7 +152,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 			debug("Found FIT\n");
 			load.dev = flash;
-			load.priv = NULL;
 			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
@@ -164,7 +163,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			struct spl_load_info load;
 
 			load.dev = flash;
-			load.priv = NULL;
 			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 038b4438457..8616cb3e915 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -134,7 +134,6 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
 		struct ymodem_fit_info info;
 
 		debug("Found FIT\n");
-		load.dev = NULL;
 		load.priv = (void *)&info;
 		load.filename = NULL;
 		load.bl_len = 1;
-- 
2.37.1

