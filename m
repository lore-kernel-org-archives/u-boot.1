Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1C1CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 11:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DBC831B4;
	Wed, 27 Aug 2025 13:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNVCjtrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D22B831B4; Wed, 27 Aug 2025 13:52:28 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0D883192
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 13:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3eaff77982eso48736195ab.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756295544; x=1756900344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wkrFMGHd/BJfBmhhdXKc3es6SL8aQ8jDfR4/St7ei2E=;
 b=NNVCjtrgpDG0LJWR9mu6AxZRs+k4SbjqzeARfGsiv0ME8NQV6GWPYqAw4Xepr/uOS6
 ETz9tb5NXANsLejFfVichGBImvsu5S778KyOv2HKaZK4c7N0pgykn86E3pC2Vp9xQoVJ
 S5BhQOnd1THVIi51DstLndufS0imLVfJmh0br36nnNTCWE1tq/lkFKBxSgIQR88/0wej
 NvOtw0Y/Iws4YHHLwOn7VvNvGtV4zjK8WxEFlnkpuSG/LQWfbQPLcZmCd/S5BplYlO6b
 ewgb0BK+dKCT3zcLwPf9B8qvpg0AfjB/Dnpa6ecndDpbhWdnjj+IUWAI8O3hrQMdTf00
 Yhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756295544; x=1756900344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wkrFMGHd/BJfBmhhdXKc3es6SL8aQ8jDfR4/St7ei2E=;
 b=TcIwqS1FNt+joyV9Nnumib7x+lyGhxvLt7AGfrKIzLyiXlmDbVvHE40ZcONx3qGYPD
 6R9jLqmKZ1HqTf0kMe6zkvgQHyh29FS2zzSyepP1TxESayMWQEL9g1HL5/KuUJOsteh8
 f7pPy1p9LMwuBFMD+R0spGPL6AM+UUieusWXTlsxE4RPT14Kb9LFMl7FXBAmxB2doqH8
 7S+66/G4/z1W8dBB6aC0IoAxNYf3MNtHG0VFDYXttwWX2axqFRRvxkYnmPGjn10T8GiV
 bmwC0agJ2y8ghVvlOwgspyBpKl2YzBkNCxyuMo4yxKob6wZDeIpGTlLN2IO3OIivMFA3
 2Rxw==
X-Gm-Message-State: AOJu0YyxpjlFiyIFZFp7oADQbV1Mf5Mc/wRf8zg1WvO8xsMEvVDcGnK/
 RhRwWxVnaisfxmdEOjTuSe9AhqaN4oEL1P21mMsyXaYaj1+jAw8/kV0FhQSjcNY870Q=
X-Gm-Gg: ASbGncvkPdX3wX5It/tAMaTWQo7iRe+euq6s1Gkz5lrtjHBk8fKrNBnHuJDKE8GcpL+
 iTjzuP1a1p84GuErMCbvC4E+bFrIfB8EbLAVtN7ll+KoU8cL4tM+TV0Dt0Ouh+j3C1nuzht1R0M
 zZaHXVmlxbTLbrNosQEuyeY9H3/zML57OfQqD4q446XZJ9dzvEd/kk0NOrsD9vBqHFxDnF/Bjzd
 l37FJP0x7HoSyfFBzS2QW/jO6HgagYgHS8CEJ8sAzsUUFY+rAPjGeiKXtEskSelp3tnEVrdPZi8
 IGmVI9DXh1PvjBmwppZnqsb1Jd4MPvNJRn9Go6JtG5+TZmx83Bv8lnBBNZR7Ta4B2NGCRPasbK4
 nZDi4bih22k0JkJq17KeE9D8jNiWlfZjwXcyPxO2uKmJjH/P9aCkOSQ==
X-Google-Smtp-Source: AGHT+IEpdGNSQ1k8QPHZo/M8iTw21YpzQwXjFWRW1GKEz0o43Si3akPDIdikL8Y2BXs9F5riNNaQYA==
X-Received: by 2002:a05:6e02:e45:b0:3e9:eec4:9af1 with SMTP id
 e9e14a558f8ab-3e9eec49e41mr205553985ab.31.1756295544313; 
 Wed, 27 Aug 2025 04:52:24 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([104.168.88.190])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3f0821080a0sm4409455ab.9.2025.08.27.04.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 04:52:23 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: add support for XMC XM25QH256D/XM25QH512D
Date: Wed, 27 Aug 2025 19:52:05 +0800
Message-Id: <20250827115205.17285-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The XMC XM25QH256D and XM25QH512D share the same JEDEC ID
with their C-version counterparts (XM25QH256C and XM25QH512C).
To properly distinguish them, the BFPT DTR bit needs to be
checked. If DTR is set, the device is identified as the D
version instead of the C version.

This patch:
- Adds CONFIG_SPI_FLASH_XMC to reuse Spansion/Winbond code paths
  for configuration register handling and quad enable logic.
- Extends spi_nor_parse_bfpt() to check DTR and rename the device
  from "C" to "D" when required.
- Ensures spi_nor_init_params() keeps the correct flash name.

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-core.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 76c33b24368..a00d82057da 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -578,7 +578,7 @@ static int read_fsr(struct spi_nor *nor)
  * location. Return the configuration register value.
  * Returns negative if error occurred.
  */
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND) || defined(CONFIG_SPI_FLASH_XMC)
 static int read_cr(struct spi_nor *nor)
 {
 	int ret;
@@ -2204,7 +2204,7 @@ static int spansion_quad_enable_volatile(struct spi_nor *nor, u32 addr_base,
 }
 #endif
 
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND) || defined(CONFIG_SPI_FLASH_XMC)
 /*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
@@ -2630,6 +2630,21 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 	}
 
+	if (strcmp(mtd->name, "XM25QH512C") == 0)
+	{
+		if (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_DTR)
+		{
+			mtd->name = "XM25QH512D";
+		}
+	}
+	if (strcmp(mtd->name, "XM25QH256C") == 0)
+	{
+		if (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_DTR)
+		{
+			mtd->name = "XM25QH256D";
+		}
+	}
+
 	/* Flash Memory Density (in bits). */
 	params->size = bfpt.dwords[BFPT_DWORD(2)];
 	if (params->size & BIT(31)) {
@@ -2710,7 +2725,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	case BFPT_DWORD15_QER_NONE:
 		params->quad_enable = NULL;
 		break;
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND) || defined(CONFIG_SPI_FLASH_XMC)
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
 		params->quad_enable = spansion_no_read_cr_quad_enable;
@@ -2721,7 +2736,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		params->quad_enable = macronix_quad_enable;
 		break;
 #endif
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND) || defined(CONFIG_SPI_FLASH_XMC)
 	case BFPT_DWORD15_QER_SR2_BIT1:
 		params->quad_enable = spansion_read_cr_quad_enable;
 		break;
@@ -3094,6 +3109,11 @@ static int spi_nor_init_params(struct spi_nor *nor,
 #endif
 	}
 
+#ifdef CONFIG_SPI_FLASH_XMC
+	if (JEDEC_MFR(info) == SNOR_MFR_ST) 
+		nor->mtd.name = info->name;
+#endif
+
 	/* (Fast) Read settings. */
 	params->hwcaps.mask |= SNOR_HWCAPS_READ;
 	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ],
@@ -3166,7 +3186,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			break;
 
 		default:
-#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND)
+#if defined(CONFIG_SPI_FLASH_SPANSION) || defined(CONFIG_SPI_FLASH_WINBOND) || defined(CONFIG_SPI_FLASH_XMC)
 			/* Kept only for backward compatibility purpose. */
 			params->quad_enable = spansion_read_cr_quad_enable;
 #endif
-- 
2.34.1

