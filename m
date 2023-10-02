Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7614CE784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 13:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC5287160;
	Mon,  2 Oct 2023 15:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PNJ6jqPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52221870BB; Mon,  2 Oct 2023 14:00:17 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF04870D3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 14:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-692c70bc440so10564089b3a.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696248006; x=1696852806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5rczlOCFgHiVnyNDIc8uqHg+GzKMaoIKovcZov8onfs=;
 b=PNJ6jqPlg/5pJCDNPKfbi3uLIsNr6c4nK31O45HyKzXgbbG3RnUdZM6s7YddZPbGUe
 3vD+AGCBs2zqhTvJ/R1rghpzy436lX43sj7nrJTbZs9TUb1StWu2nV80NwIIq4TJKCTH
 Vuf9TMtn9tH3Xqwr5V1zA2gAdKCqkTmqzyFRXA5jdwfaZ8qqNcwkoicW17TN52jsLMo2
 fTO5cT8nAXFj85HR/bfuRkQoUD5DE/KUI17KrEWDKR8mjZ2Z3BguzLe7/PQBIzucK9Py
 71UuGezV3y+ye1FL4qb5Wc8HXV0+BaiTz2rhcZ18RXF2yjyaRa8Td7Ls5C9zoAWO4Rbn
 6FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696248006; x=1696852806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rczlOCFgHiVnyNDIc8uqHg+GzKMaoIKovcZov8onfs=;
 b=Oi2TqsjoJGia6RJKt6uKIUatrrrdaAM17QuZBlpd1FIaZ9DMsxMPgU+NS2y2e6xO/3
 vvaiqCDgUXy+Y5v5cX5xoHyfeBRQF6sxkFjnkBNJmGd+6SUEVbrY5qVPxGlnhuM2gLez
 7aMsgMJoZpbJwAOXqBLW9yx7L6QU8sxmmN7+R2ThA45nOogUnMkiYQSSvw71uy1p2cZH
 HiPwvCwv6XSQVqwcXy37UNywCPncDZBiWIa5tZMFN+07BjI04et9GTdpyODKpcb95vZV
 q34IwA42eluz9XQpwkp7gyvzzcYYX8WtBQQ9Z9hLlNBdfuIHyE3UMF24+39eK6ilVGAg
 SrVQ==
X-Gm-Message-State: AOJu0YxkMxKJrXcjmsSofE6+2ZNf1p2Hf6dzTGuVCcb/uAPm4/5jM2dG
 OSUCuIMYb9hghkyFxhfy0t0=
X-Google-Smtp-Source: AGHT+IEkUGEhSs146O44oasxgf5+stAvOSsqr5Ila9IunbBHYIrFGnL54FbjKszSOQ/9efeTeuEmVg==
X-Received: by 2002:a05:6a00:1506:b0:693:4143:5145 with SMTP id
 q6-20020a056a00150600b0069341435145mr10978649pfu.31.1696248005736; 
 Mon, 02 Oct 2023 05:00:05 -0700 (PDT)
Received: from debianfranco.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 j14-20020aa78dce000000b006906aaf1e4dsm19307024pfr.150.2023.10.02.05.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 05:00:05 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: u-boot@lists.denx.de,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] toradex: colibri_imx7: Enable nand/emmc detection and set
 boot variant
Date: Mon,  2 Oct 2023 08:57:49 -0300
Message-Id: <20231002115749.15160-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Oct 2023 15:00:05 +0200
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

From: Hiago De Franco <hiago.franco@toradex.com>

Add detection of eMMC vs NAND devices on the Colibri iMX7
board. A GPIO is configured to detect the presence of an on-board resistor
that is configured differently based on the flash memory used. Depending on
the detection result, the 'variant' environment variable is set to '-emmc'
or cleared, indicating the type of storage device.

This enhancement improves variant detection during system initialization
through USB recovery mode, where U-Boot is loaded directly to RAM. This
allows variant detection for an accurate device tree selection.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 board/toradex/colibri_imx7/colibri_imx7.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 119e67b47f..f0356af008 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -53,6 +53,11 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define USB_CDET_GPIO	IMX_GPIO_NR(7, 14)
 
+#define FLASH_DETECTION_CTRL (PAD_CTL_HYS | PAD_CTL_PUE)
+#define FLASH_DET_GPIO IMX_GPIO_NR(6, 11)
+
+static bool is_emmc;
+
 int dram_init(void)
 {
 	gd->ram_size = get_ram_size((void *)PHYS_SDRAM, imx_ddr_size());
@@ -60,6 +65,10 @@ int dram_init(void)
 	return 0;
 }
 
+static iomux_v3_cfg_t const flash_detection_pads[] = {
+	MX7D_PAD_SD3_RESET_B__GPIO6_IO11 | MUX_PAD_CTRL(FLASH_DETECTION_CTRL),
+};
+
 static iomux_v3_cfg_t const uart1_pads[] = {
 	MX7D_PAD_UART1_RX_DATA__UART1_DTE_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
 	MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
@@ -183,6 +192,16 @@ int board_init(void)
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
+	/*
+	 * Enable GPIO on NAND_WE_B/eMMC_RST with 100k pull-down. eMMC_RST
+	 * is pulled high with 4.7k for eMMC devices. This allows to reliably
+	 * detect eMMC/NAND flash
+	 */
+	imx_iomux_v3_setup_multiple_pads(flash_detection_pads, ARRAY_SIZE(flash_detection_pads));
+	gpio_request(FLASH_DET_GPIO, "flash-detection-gpio");
+	is_emmc = gpio_get_value(FLASH_DET_GPIO);
+	gpio_free(FLASH_DET_GPIO);
+
 #ifdef CONFIG_FEC_MXC
 	setup_fec();
 #endif
@@ -348,6 +367,11 @@ int board_late_init(void)
 		env_set("bootcmd", "sdp 0");
 	}
 #endif
+	if (is_emmc)
+		env_set("variant", "-emmc");
+	else
+		env_set("variant", "");
+
 	return 0;
 }
 #endif /* CONFIG_BOARD_LATE_INIT */
-- 
2.40.1

