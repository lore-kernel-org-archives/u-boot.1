Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE13C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B826986FDE;
	Mon,  6 Nov 2023 03:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RUsbFoJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA7786A8F; Mon,  6 Nov 2023 03:30:58 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9199787086
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso28171601cf.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237594; x=1699842394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw4ylPHUkbdbR96BkyAVCFjs6KpN1WT+GrvxKU6SxEU=;
 b=RUsbFoJU1Iqyh/E+Sc0Eai8t3EJq7IRbqDbjT/z/5BU/DCjQiBOMPFkjbJyf5CfabE
 KRIATshwFnfjC/3TDjxFXfzmslz+xt26wSA46nD+M6D8RXozDxnF6ZbflKNY0P0OydwV
 ApYV84aoqGERaQQJ9zGrXvkLtDchWzPMwpLYDDSj0LO0qaykf+jqiq8mL1sMc3xyuvFy
 l5+J4Po76IYTuchJ/k788JYVS90icXUrkR/x3zSzxeMDHNKgwSOJluAepW5lpSwbIjf6
 FPZm7S11jQUaUnuhyuW+VxO63sghlVlM+CC1Jt+GDzyhaaGBm4sOnFHRMSAWE0g2yo/h
 a6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237594; x=1699842394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yw4ylPHUkbdbR96BkyAVCFjs6KpN1WT+GrvxKU6SxEU=;
 b=O5JuUYM81UGwbVXfGIK9JCmmJ6LsycYKk6RsHq+zogpOSoNF9cM7NKLcmv8KZ+vfi1
 R5XstFhzBOAARuRqBmcX+wl8zbubJf9FAtlI8M1N4nEZGCzZ5lc6AhpjqKFvJOrAji0K
 CCUUCGUcKRz97rDecD1FqtyBHL6m9ZnZEMijKiJ9u0uu9tGhxXJQSHG1zGxYzOUZHrfi
 q9ynIEW6GScsDUSQil+CpzjYsuj1h/APAyqsbdRCUVlvkwX5wYjXR/mOqDJr2mmcmCXP
 gOSj0feXU684Ww7Yxaqtl7wTUqezXUlULo0knq7i0C1Knn/nhiVzUvDV+mtHx0990002
 C5hA==
X-Gm-Message-State: AOJu0YwYEZ1giScW+B70IRs2KLbY+6KanW68OkQL3tOMJQYHr+TYmUJ6
 +ptChyQRPkN4vDmooIXLYiI=
X-Google-Smtp-Source: AGHT+IGY952zmdHgp+Vo0MmRIYfAEEY5rwH+ZJXOHHY12tfFKrc/kaZA84mK1+Dv3tDfmqC57y+F8A==
X-Received: by 2002:a05:6214:2b97:b0:66f:b847:71b7 with SMTP id
 kr23-20020a0562142b9700b0066fb84771b7mr28104464qvb.25.1699237594136; 
 Sun, 05 Nov 2023 18:26:34 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 mx1-20020a0562142e0100b0066d0ab215b5sm3070785qvb.13.2023.11.05.18.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:33 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH v6 24/25] spl: spi: Consolidate spi_load_image_os into
 spl_spi_load_image
Date: Sun,  5 Nov 2023 21:26:02 -0500
Message-Id: <20231106022603.3405551-25-seanga2@gmail.com>
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

spi_load_image_os performs almost the same steps as the non-falcon-boot
path of spl_spi_load_image. The load address is different, and it also
loads a device tree, but that's it. Refactor the boot process so that
they can both use the same load function.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
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

