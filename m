Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1003871C0;
	Wed,  8 Nov 2023 17:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d8ZZIdnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5B3876F4; Wed,  8 Nov 2023 17:49:47 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A7287756
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66d0ceba445so40468706d6.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462171; x=1700066971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uew6qvj5K56A/ylRo/rbr0WPj/Np6zUULbJNkW2e9S8=;
 b=d8ZZIdnhpPUaVbHPgUwwNG8L+QMI2JVksheWhLvG4DgRbQOWfghGByq66weMeTp314
 /BzcM2zNW1d2sROVyLyacyhTwQ0mQAB1NbrPfQHf6kFvp/3wBg6tTbr8VRs7WSkmoxKp
 nhUZHPvm52476ejBj6oFDeB3cZ0yllG6pEXLfczLr3K3R0cG+OlixyqUztu0ufnWrpNH
 I9sikSO4PxAdhWrDVkrXWuxgfBStJVgN/0lg0q30pemYAEFF079c3n/awQelqjNKIeT/
 5Phy17eu9fak1KFy+ZJJ0iRcGCdR8JVebUyFsCygQlTDqu8JjIaBE4pnOudIq/FVZSyi
 PKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462171; x=1700066971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uew6qvj5K56A/ylRo/rbr0WPj/Np6zUULbJNkW2e9S8=;
 b=eXC/u7OB96QnbgN36gb/av5G+bwYWgfZ0zmEuHC5M9wrm0Xkhf83pN+GG5+Qgi2rn3
 rD0KZu5bCxgWxv/nIKF4P1HWJkjeQZ3jmQ4DVz1qce39heNlZ7tLdd+K9XAx+8/qeJoy
 raklp0HdFw2IjoEpvB7sHr4WQNIa8Wdfga+TMGAkJO3SZh7+ZW27rfHem+31GZnV49T+
 xDOOUReD2TNk27AYpKLNwy0P8ANCGljx+TA9tOFRqPwVt9S36I89XfyZM/iX7W7VWH4G
 TgK3yuTIu+NzURkjTtw5+sDHdyOJ77kXS084xbZGYmYaOAl48kjX2PB/sc6R9HA7zoB+
 w9bw==
X-Gm-Message-State: AOJu0Yy4PeyrN8Kuu+4qhs7TkFkf8G85/1cO4vO456UfElLJjk2M1iyo
 L0vL5nZDtN+RTYkgJsSeXXyW+Ww8D0Y=
X-Google-Smtp-Source: AGHT+IE5bopBmAp5vJDfUksG9GVyM6lgn/E62FMNjPOm6uC4ieSOnyrMlxcck0oopsEWXTkA3My3cw==
X-Received: by 2002:ad4:5be2:0:b0:66d:a22a:464f with SMTP id
 k2-20020ad45be2000000b0066da22a464fmr2327612qvc.16.1699462171389; 
 Wed, 08 Nov 2023 08:49:31 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 x8-20020ae9f808000000b0077402573fb4sm1212951qkh.124.2023.11.08.08.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:31 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v7 24/26] spl: Convert spi to spl_load
Date: Wed,  8 Nov 2023 11:48:56 -0500
Message-Id: <20231108164858.3497420-25-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

