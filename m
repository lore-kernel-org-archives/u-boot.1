Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF7DC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02711871A0;
	Mon,  6 Nov 2023 03:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOpoYdY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DA586F5C; Mon,  6 Nov 2023 03:30:35 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C2487070
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41e58a33ec9so26145191cf.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237593; x=1699842393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4NDwQIE8ELRnsC4W9fsPRRhduopD2rQOOrv1dEcIYQ=;
 b=VOpoYdY840QRDaCTZ1p/iYh3hJY61rl9cLTh3YsHLSwawNwUnz60UemOcy6SmvNHM8
 VVtjjdlpRNTpMphaUIa//lmdH3fnjteybIjS8uPD0FV2AL4PK734J8NCXl12JG1d2Zhj
 KOgtw19uBFLzBFr0sQT/v/SYizFGmY2x03a0rQtyqjvapx+8bDPqPjKCG4N4+zdwq2Fp
 gBPG3gY5sIjBogib9MRZ2JHUFit/PkJx7W3Z1YNBqO/u7j84oKPZ6Y6IeS6TwI/xlmRa
 p5G/FgyHpmusH385yHEufQk46pyAK1Vi7pNj5P00oS+L7qJQ5SAoy1jbNTiHLAKXh0VJ
 ntSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237593; x=1699842393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4NDwQIE8ELRnsC4W9fsPRRhduopD2rQOOrv1dEcIYQ=;
 b=pvge1YPRo3mTrRg70FcCFXP3WtcPRx1qmr6LbMfq8b+kv5AqpZI/X35R5zV1iuQAhA
 Tzw7AFFD5jxwo0FUGwqwdOYRC9gG/0qYCT+OkolcDte/D+uPfUu2H0UGJ1g9QPXkn28x
 UgH2w3mwplM7b4kyQlvaqA5U1NgjmorN8JHVetrCXaispRnm7YQpGWZkyRmvkNxGEF+X
 Ug9XG9QpoztV1wTyguj1uqM49+fSnp9RgUtKQhKthcOk05RndvAzzzpTr/tXSW2QqutQ
 aJ3kOf0SyVWNODPYrLDalJ6pFS9UDiLBtATWl/2utcUFUJPqyS3PIJKUqoiXBt/2Drd5
 ZGFQ==
X-Gm-Message-State: AOJu0Yy5DG+LV0/ANfp8f9DjUxRsXvYngf3t5RJARt4xtj6DUQMLlwnf
 0HWGVK0ZJ7/UjLqwGf+Zv3w=
X-Google-Smtp-Source: AGHT+IGPjawyn1fwufPgPR/iNkRUsPVenCefVVGxAsXpm4ax/RN0SbTSdJ5j9Ku1dXY/tgG08x75wA==
X-Received: by 2002:a05:622a:82:b0:41c:c066:9c0 with SMTP id
 o2-20020a05622a008200b0041cc06609c0mr36198259qtw.5.1699237592936; 
 Sun, 05 Nov 2023 18:26:32 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 z7-20020ac875c7000000b0041b7f007546sm2985418qtq.82.2023.11.05.18.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:32 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH v6 23/25] spl: Convert spi to spl_load
Date: Sun,  5 Nov 2023 21:26:01 -0500
Message-Id: <20231106022603.3405551-24-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This converts the spi load method to use spl_load. The address used for
LOAD_FIT_FULL may be different, but there are no in-tree users of that
config. Since payload_offs is only used without OS_BOOT, we defer its
initialization.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- Fix soft reset after loading from SPI

Changes in v5:
- Rework to load header in spl_load

 common/spl/spl_spi.c      | 80 +++++++--------------------------------
 include/spl_load.h        |  1 +
 test/image/spl_load_spi.c |  1 +
 3 files changed, 15 insertions(+), 67 deletions(-)

diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 3e08ac7c1a2..f49e534b749 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -12,11 +12,11 @@
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
-#include <mapmem.h>
 #include <spi.h>
 #include <spi_flash.h>
 #include <errno.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/ofnode.h>
@@ -95,9 +95,9 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 	int err = 0;
 	unsigned int payload_offs;
 	struct spi_flash *flash;
-	struct legacy_img_hdr *header;
 	unsigned int sf_bus = spl_spi_boot_bus();
 	unsigned int sf_cs = spl_spi_boot_cs();
+	struct spl_load_info load;
 
 	/*
 	 * Load U-Boot image from SPI flash into RAM
@@ -112,77 +112,23 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 		return -ENODEV;
 	}
 
+#if CONFIG_IS_ENABLED(OS_BOOT)
+	if (!spl_start_uboot() && !spi_load_image_os(spl_image, bootdev, flash, header))
+		return 0;
+#endif
+
 	payload_offs = spl_spi_get_uboot_offs(flash);
-
-	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-
 	if (CONFIG_IS_ENABLED(OF_REAL)) {
 		payload_offs = ofnode_conf_read_int("u-boot,spl-payload-offset",
 						    payload_offs);
 	}
 
-#if CONFIG_IS_ENABLED(OS_BOOT)
-	if (spl_start_uboot() || spi_load_image_os(spl_image, bootdev, flash, header))
-#endif
-	{
-		/* Load u-boot, mkimage header is 64 bytes. */
-		err = spi_flash_read(flash, payload_offs, sizeof(*header),
-				     (void *)header);
-		if (err) {
-			debug("%s: Failed to read from SPI flash (err=%d)\n",
-			      __func__, err);
-			return err;
-		}
-
-		if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL) &&
-		    image_get_magic(header) == FDT_MAGIC) {
-			u32 size = roundup(fdt_totalsize(header), 4);
-
-			err = spi_flash_read(flash, payload_offs,
-					     size,
-					     map_sysmem(CONFIG_SYS_LOAD_ADDR,
-							size));
-			if (err)
-				return err;
-			err = spl_parse_image_header(spl_image, bootdev,
-					phys_to_virt(CONFIG_SYS_LOAD_ADDR));
-		} else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
-			   image_get_magic(header) == FDT_MAGIC) {
-			struct spl_load_info load;
-
-			debug("Found FIT\n");
-			load.priv = flash;
-			spl_set_bl_len(&load, 1);
-			load.read = spl_spi_fit_read;
-			err = spl_load_simple_fit(spl_image, &load,
-						  payload_offs,
-						  header);
-		} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
-			   valid_container_hdr((void *)header)) {
-			struct spl_load_info load;
-
-			load.priv = flash;
-			spl_set_bl_len(&load, 1);
-			load.read = spl_spi_fit_read;
-
-			err = spl_load_imx_container(spl_image, &load,
-						     payload_offs);
-		} else {
-			err = spl_parse_image_header(spl_image, bootdev, header);
-			if (err)
-				return err;
-			err = spi_flash_read(flash, payload_offs + spl_image->offset,
-					     spl_image->size,
-					     map_sysmem(spl_image->load_addr,
-							spl_image->size));
-		}
-		if (IS_ENABLED(CONFIG_SPI_FLASH_SOFT_RESET)) {
-			err = spi_nor_remove(flash);
-			if (err)
-				return err;
-		}
-	}
-
+	load.priv = flash;
+	spl_set_bl_len(&load, 1);
+	load.read = spl_spi_fit_read;
+	err = spl_load(spl_image, bootdev, &load, 0, payload_offs);
+	if (IS_ENABLED(CONFIG_SPI_FLASH_SOFT_RESET))
+		err = spi_nor_remove(flash);
 	return err;
 }
 /* Use priorty 1 so that boards can override this */
diff --git a/include/spl_load.h b/include/spl_load.h
index 2a20e866cd8..1c2b296c0a2 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -103,6 +103,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	IS_ENABLED(CONFIG_SPL_NET) + \
 	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
 	IS_ENABLED(CONFIG_SPL_SEMIHOSTING) + \
+	IS_ENABLED(CONFIG_SPL_SPI_LOAD) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_spi.c b/test/image/spl_load_spi.c
index 8f9b6e0139b..54a95465e23 100644
--- a/test/image/spl_load_spi.c
+++ b/test/image/spl_load_spi.c
@@ -34,6 +34,7 @@ static int spl_test_spi(struct unit_test_state *uts, const char *test_name,
 				spl_test_spi_write_image);
 }
 SPL_IMG_TEST(spl_test_spi, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_spi, LEGACY_LZMA, DM_FLAGS);
 SPL_IMG_TEST(spl_test_spi, IMX8, DM_FLAGS);
 SPL_IMG_TEST(spl_test_spi, FIT_INTERNAL, DM_FLAGS);
 #if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
-- 
2.37.1

