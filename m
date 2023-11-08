Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F69C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0958771E;
	Wed,  8 Nov 2023 17:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NI7gV6X6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A836871E7; Wed,  8 Nov 2023 17:49:32 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8C38770A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7af52ee31so84721677b3.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462154; x=1700066954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGXrXTEK/aMFR78112awB2nl71ssOSwzBi5kQmcKoTI=;
 b=NI7gV6X6Am7HfRxgKv/3D9zdkig005ECXYetlc1Hff2O2RgYVs70KNnZqjFp6oYbUr
 MYlLB13YMTNv9nwo7bPuPBKC6QqbvCtz6GHGjOIXI1MQ8DL65CR753n3+Cnqskp0uZ0J
 AuYrI5WtEjMYm3cDaWk0I2mfCS5HWNmKuYEhikedvK+FDmFTlx2vrwl0dIF6Ayxqqupz
 Tw1MHV6JZ9PFpXfeF6G7ZSHohgn2Eh46aErc63AaTYKJn3/GYrANuLXi4f5BBaWT2VBl
 XERUtCTHxGbeO3FgMOGTiqBA5vPPhWw45S26pi5esmIWf9zuRy/nrWAKMP+PwS6Y8Ijq
 aCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462154; x=1700066954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGXrXTEK/aMFR78112awB2nl71ssOSwzBi5kQmcKoTI=;
 b=IhfhAqnQQ5Tym+SiZRi1pz4QFdSg4gBsOMJ3vi92yt5xgZkweCD+4TkOj/Ul1ZY11v
 8SsAOHFngcJXI+lHsOSn1L8xI7lA6zDsjCav5EN9BRNYdb48ykAqNICsG+w76nGcMwE6
 YgQlLVVS9ajgGEMD34oWZWr5Lcv060cVSgsaXtZkRdUeiQ6mM415ny1kuJzGnPi0PdYr
 QBDbO+g5TX6SCoh2bK2jZDxYDNMp9Drk4nV5YLpbdqPNohHL8KN/HcTrdTZjsEOR+BP9
 4LghXeeRoVQJgIe40AmyE25qGKxsknlRL2Imcm/ukZ2tYL6eQLsqPQbFB+vcX4sTSG22
 rG6Q==
X-Gm-Message-State: AOJu0Yyg20poJt2SmJPe+baJcp7duh3q33Kq93f1/UkarvHUHwud25xg
 u5owmepumGK3io5QyDbIZUY=
X-Google-Smtp-Source: AGHT+IHC0BKJ97fFE2gUAe/AXYl0eRAOJkRmyNR28lqborEw92oqpkuld+PTt43J5mtLtmkUFIOX5w==
X-Received: by 2002:a0d:d856:0:b0:5a9:27c8:edbc with SMTP id
 a83-20020a0dd856000000b005a927c8edbcmr2518343ywe.28.1699462154148; 
 Wed, 08 Nov 2023 08:49:14 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 mz16-20020a0562142d1000b0066d1540f9ecsm1246208qvb.77.2023.11.08.08.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:13 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 10/26] spl: Remove filename from spl_load_info
Date: Wed,  8 Nov 2023 11:48:42 -0500
Message-Id: <20231108164858.3497420-11-seanga2@gmail.com>
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

For filesystems, filename serves the same purpose as priv. However,
spl_load_fit_image also uses it to determine whether to use a DMA-aligned
buffer. This is beneficial for FAT, which uses a bounce-buffer if the
destination is not DMA-aligned. However, this is unnecessary now that
filesystems set bl_len to ARCH_DMA_MINALIGN instead. With this done, we can
remove filename entirely.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v7:
- Split off setting bl_len to ARCH_DMA_MINALIGN from filename removal

Changes in v6:
- New

 arch/arm/mach-sunxi/spl_spi_sunxi.c | 1 -
 common/spl/spl_blk_fs.c             | 7 ++++---
 common/spl/spl_fat.c                | 4 ++--
 common/spl/spl_mmc.c                | 2 --
 common/spl/spl_nand.c               | 3 ---
 common/spl/spl_semihosting.c        | 1 -
 common/spl/spl_spi.c                | 2 --
 common/spl/spl_ymodem.c             | 1 -
 include/spl.h                       | 2 --
 test/image/spl_load_os.c            | 1 -
 10 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 896aba69c32..5e7fba0c8e4 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -354,7 +354,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT image\n");
-		load.filename = NULL;
 		load.bl_len = 1;
 		load.read = spi_load_read;
 		ret = spl_load_simple_fit(spl_image, &load,
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index c105c55877a..4975ce4d6ec 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -14,6 +14,7 @@
 
 struct blk_dev {
 	const char *ifname;
+	const char *filename;
 	char dev_part_str[8];
 };
 
@@ -31,11 +32,11 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 		return ret;
 	}
 
-	ret = fs_read(load->filename, virt_to_phys(buf), file_offset, size,
+	ret = fs_read(dev->filename, virt_to_phys(buf), file_offset, size,
 		      &actlen);
 	if (ret < 0) {
 		printf("spl: error reading image %s. Err - %d\n",
-		       load->filename, ret);
+		       dev->filename, ret);
 		return ret;
 	}
 
@@ -87,8 +88,8 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
 		load.bl_len = ARCH_DMA_MINALIGN;
-		load.filename = (void *)filename;
 		load.priv = &dev;
+		dev.filename = filename;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
 	}
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 5b723456478..8a2c4e3af49 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -51,7 +51,7 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 {
 	loff_t actread;
 	int ret;
-	char *filename = (char *)load->filename;
+	char *filename = load->priv;
 
 	ret = fat_read_file(filename, buf, file_offset, size, &actread);
 	if (ret)
@@ -98,7 +98,7 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
 		load.bl_len = ARCH_DMA_MINALIGN;
-		load.filename = (void *)filename;
+		load.priv = (void *)filename;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
 	} else {
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 9f41ea648ce..8c4ffe743d5 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -108,7 +108,6 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = bd;
-		load.filename = NULL;
 		load.bl_len = bd->blksz;
 		load.read = h_spl_load_read;
 		ret = spl_load_simple_fit(spl_image, &load,
@@ -118,7 +117,6 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.priv = bd;
-		load.filename = NULL;
 		load.bl_len = bd->blksz;
 		load.read = h_spl_load_read;
 
diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 1fcc89fa660..45d7c5f6cfb 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -90,7 +90,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = &offset;
-		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
 		return spl_load_simple_fit(spl_image, &load, offset, header);
@@ -99,7 +98,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.priv = &offset;
-		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
 		return spl_load_imx_container(spl_image, &load, offset);
@@ -108,7 +106,6 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found legacy image\n");
-		load.filename = NULL;
 		load.bl_len = IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1;
 		load.read = spl_nand_legacy_read;
 
diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
index 8f11c29913f..24a3d9fd1c9 100644
--- a/common/spl/spl_semihosting.c
+++ b/common/spl/spl_semihosting.c
@@ -69,7 +69,6 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.read = smh_fit_read;
 		load.bl_len = 1;
-		load.filename = NULL;
 		load.priv = &fd;
 
 		ret = spl_load_simple_fit(spl_image, &load, 0, header);
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index af7a28e7c25..373caea322a 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -152,7 +152,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 			debug("Found FIT\n");
 			load.priv = flash;
-			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
 			err = spl_load_simple_fit(spl_image, &load,
@@ -163,7 +162,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			struct spl_load_info load;
 
 			load.priv = flash;
-			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
 
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index 8616cb3e915..3f92b9b0036 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -135,7 +135,6 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.priv = (void *)&info;
-		load.filename = NULL;
 		load.bl_len = 1;
 		info.buf = buf;
 		info.image_read = BUF_SIZE;
diff --git a/include/spl.h b/include/spl.h
index 5a355e0a1e0..fec656d3018 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -287,12 +287,10 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
  *
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
- * @filename: Name of the fit image file.
  * @read: Function to call to read from the device
  */
 struct spl_load_info {
 	void *priv;
-	const char *filename;
 	/**
 	 * read() - Read from device
 	 *
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 794cfad4e70..f46df907c63 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -57,7 +57,6 @@ static int spl_test_load(struct unit_test_state *uts)
 	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
 	if (ret)
 		ut_assertf(0, "%s not found, error %d\n", fname, ret);
-	load.filename = fname;
 
 	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
 
-- 
2.37.1

