Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC1C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CE586F9F;
	Mon,  6 Nov 2023 03:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MH3r5c3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960F386F99; Mon,  6 Nov 2023 03:26:52 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3C186FA5
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7789577b53fso263404785a.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237572; x=1699842372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKu4U7ub0ABJ4eguhwrWwzZxaX2oiC5EIEME3NxkltE=;
 b=MH3r5c3RwurqvsDJQCZth5GVAM2PjvP9GVBlRyZjmvCPOjFWCyzmGWYGM2cPU5mUbe
 AebUKzUiZY/LY09+ZQpJULTD4dMkSzcbRRouKKQ8+BenFx/Er1JU9U5eWRFBbzgogb2x
 n99cykWS5YbzUzxH7Ubb4N/Id1R/q0ceKgdo16XHnvqakwVSTm5TVBd5xFKovDNrqFcl
 e3GDZ2judLWbYqEwbDfYoQ8VzPNNnUIKO9cLGhXma8qgqXXywEUq0B572LSibtleWMOi
 KcahVB2f3ESGuDQYcebGrh9rPSUrYEhZX8ZWxJHQCkrGwiS/dIgdZCAUCkBYxYoLi11M
 6lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237572; x=1699842372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKu4U7ub0ABJ4eguhwrWwzZxaX2oiC5EIEME3NxkltE=;
 b=lLzzyYB14CBi1BZ2elJk8n8E+dWGjCNQtzJZy8JUoGxHog1/9cS/lThcboZMzNPP+s
 /9PVKOBJB4nx8aJp25BPcI1IP1paRg8b5DrSn8C3NQlVN9P503FWVFMTQ0vPYilWU+ZR
 TOr0j+MDo9i+1PUnKzxmoENaKliIu6hnF/gMue8JRy8kUd1DL1mNOA9HTMNWxP6Qu6Xp
 Vu4YTWvKmi16NatamHyXlJTs88I3BUfuqxhNP9nqfI0Xf81ZUcC7Ou/kH2oM0QEmGllO
 jjOPCHc0aY6qz/CbpEroH/6p+cmzfJgz6qgJbgVzcWzJQQUgEXMWRNDvi+CUlGMPg+NR
 eW7Q==
X-Gm-Message-State: AOJu0YyNK+0cGvlvZYft+DN4nNt6b2ggbBFarKlKg2wljabkWoPJQ9/B
 gkwnkukllpk8/mCzGS5X8gOQwp9R+wltgw==
X-Google-Smtp-Source: AGHT+IGLH6aQLroY1LyPa7XYX+vgxvFOxMuTSrQnhFHbBvjZFsoFyRTaEwqZ8/NtUuw3dFhTgV/Wcw==
X-Received: by 2002:a05:620a:319f:b0:779:dbe5:cd84 with SMTP id
 bi31-20020a05620a319f00b00779dbe5cd84mr32086129qkb.36.1699237572228; 
 Sun, 05 Nov 2023 18:26:12 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 p25-20020a05620a22f900b007671cfe8a18sm2931732qki.13.2023.11.05.18.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:12 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 05/25] spl: Remove NULL assignments in spl_load_info
Date: Sun,  5 Nov 2023 21:25:43 -0500
Message-Id: <20231106022603.3405551-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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
---

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

