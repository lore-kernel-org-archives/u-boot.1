Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A34C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F6D8774C;
	Wed,  8 Nov 2023 17:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MyeghV46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C143687779; Wed,  8 Nov 2023 17:49:46 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56228775A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77ba6d5123fso85693185a.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462172; x=1700066972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDJpeARA2DJ3ql+iLRwDlROKXAe8WFHY4BlMsBuTzhc=;
 b=MyeghV46/AX1VRqnaqHP5DEd8kcerpJbjYg5xtVkoQ63LOiq5WGVZ//OjTLL47weaO
 Fpi6K7pQ0pQQ8piOdnw63ao1OJOJMcVm7AhZ6JBN0vvTr0E4vShv5OwDQ0kws3cjimRp
 /TLm0hzeC8lj5RFJcPuciJtSpXgx/hcv716DnjsTR+JL+sTZpdGaPNwW45aQvbtHl6yK
 4hNEQv8VOY1UNxYPpPHdfxcZE8ss4T+N9JON1wjyiw/oEeYETJ+MP1kcX4FOX3X5Uf/n
 40RuqWmaaHY9aY7K/fmbaZGFvXl9pOljjpg0QqB8bM5D6mD+ZZBDD2Kt8SnGTP1FP16r
 ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462172; x=1700066972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDJpeARA2DJ3ql+iLRwDlROKXAe8WFHY4BlMsBuTzhc=;
 b=oEAGb8ww8Jsm9bFFzZAB7kfduW4m0xu7CAcFBHPWPFOviuPchTROkDrNHaA70zrz4i
 fHkDTgEdVkzPsolDeHLDZi1AAdq7hU9HAVkKUDmEOyPM8yrlbEWkiR8LELPbv6kpMBmx
 VCLl44pm7GSYqdptc2Su16MkjVz/roOV2i2l+xxa3SJr+CMYJzHsWd+dVRYbY7rV7pAf
 lhIzR+sbqZLGsj2jsweyjM9QTIYeUuRw5R8fhKs3Q0CHpaa8FlmGcKTf5Ri/dOxev7hy
 c4C089+RTyJwtP8QeCpfo0dHax7c/9BmTpmBfA1vEVfqhXW3r7IiG9T+aFQ5oL043Nr3
 3ErQ==
X-Gm-Message-State: AOJu0YyHl1tRZqIs4A7pavRN09zFBuSX1orvhGHzejpBCdQF5one8Rrf
 omGhCi98grIVHf1lsQMnZao=
X-Google-Smtp-Source: AGHT+IHU3v2BOxpLr7VO4RCUekAbNOzQoBCw+n91iX2ru6jfqK1Ed3UsuOGAXjm/c+Ss/+I6MrkJOA==
X-Received: by 2002:a05:6214:1249:b0:66f:b0c0:93bc with SMTP id
 r9-20020a056214124900b0066fb0c093bcmr3595464qvv.22.1699462172591; 
 Wed, 08 Nov 2023 08:49:32 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 w16-20020a0cef90000000b0066d15e2b73fsm1228043qvr.145.2023.11.08.08.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:32 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH v7 25/26] spl: spi: Consolidate spi_load_image_os into
 spl_spi_load_image
Date: Wed,  8 Nov 2023 11:48:57 -0500
Message-Id: <20231108164858.3497420-26-seanga2@gmail.com>
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

spi_load_image_os performs almost the same steps as the non-falcon-boot
path of spl_spi_load_image. The load address is different, and it also
loads a device tree, but that's it. Refactor the boot process so that
they can both use the same load function.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Rework to load header in spl_load

Changes in v2:
- New

 common/spl/spl_spi.c | 54 ++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index f49e534b749..89de73c726c 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -21,41 +21,6 @@
 #include <asm/io.h>
 #include <dm/ofnode.h>
 
-#if CONFIG_IS_ENABLED(OS_BOOT)
-/*
- * Load the kernel, check for a valid header we can parse, and if found load
- * the kernel and then device tree.
- */
-static int spi_load_image_os(struct spl_image_info *spl_image,
-			     struct spl_boot_device *bootdev,
-			     struct spi_flash *flash,
-			     struct legacy_img_hdr *header)
-{
-	int err;
-
-	/* Read for a header, parse or error out. */
-	spi_flash_read(flash, CFG_SYS_SPI_KERNEL_OFFS, sizeof(*header),
-		       (void *)header);
-
-	if (image_get_magic(header) != IH_MAGIC)
-		return -1;
-
-	err = spl_parse_image_header(spl_image, bootdev, header);
-	if (err)
-		return err;
-
-	spi_flash_read(flash, CFG_SYS_SPI_KERNEL_OFFS,
-		       spl_image->size, (void *)spl_image->load_addr);
-
-	/* Read device tree. */
-	spi_flash_read(flash, CFG_SYS_SPI_ARGS_OFFS,
-		       CFG_SYS_SPI_ARGS_SIZE,
-		       (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
-
-	return 0;
-}
-#endif
-
 static ulong spl_spi_fit_read(struct spl_load_info *load, ulong sector,
 			      ulong count, void *buf)
 {
@@ -112,9 +77,21 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		return -ENODEV;
 	}
 
+	load.priv = flash;
+	spl_set_bl_len(&load, 1);
+	load.read = spl_spi_fit_read;
+
 #if CONFIG_IS_ENABLED(OS_BOOT)
-	if (!spl_start_uboot() && !spi_load_image_os(spl_image, bootdev, flash, header))
-		return 0;
+	if (spl_start_uboot()) {
+		int err = spl_load(spl_image, bootdev, &load, 0,
+				   CFG_SYS_SPI_KERNEL_OFFS);
+
+		if (!err)
+			/* Read device tree. */
+			return spi_flash_read(flash, CFG_SYS_SPI_ARGS_OFFS,
+					      CFG_SYS_SPI_ARGS_SIZE,
+					      (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
+	}
 #endif
 
 	payload_offs = spl_spi_get_uboot_offs(flash);
@@ -123,9 +100,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 						    payload_offs);
 	}
 
-	load.priv = flash;
-	spl_set_bl_len(&load, 1);
-	load.read = spl_spi_fit_read;
 	err = spl_load(spl_image, bootdev, &load, 0, payload_offs);
 	if (IS_ENABLED(CONFIG_SPI_FLASH_SOFT_RESET))
 		err = spi_nor_remove(flash);
-- 
2.37.1

