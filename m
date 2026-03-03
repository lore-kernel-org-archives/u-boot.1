Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483D6EDEBEB
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 19:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E4083FBD;
	Tue,  3 Mar 2026 20:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eO99w6f5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5555E83FAA; Tue,  3 Mar 2026 20:56:00 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8644883F9A
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 20:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463a0e14b4cso2600985b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772567755; x=1773172555;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rPlPuv+kTa1lRn616AbOEm5DQibTASX0hlhynviKboI=;
 b=eO99w6f5151VC+65lLC4HZb94aNoNBRj8beYmihvrrQfhh3cpgP/5yPvKyV3wwXI5L
 sRcvgAXPCLy33gXK+xm3UewQHW5mJghdcnpq7gkGzUj8sAKOL/1exSK+QQrrEwfMfOFG
 0qlT0za3tzvwq4BdvXNn1mtO19RY9fRVh8TClHZF4Svolvr7RSumjdZrN11lWh7fLPM3
 j33kVeDo8T9S81YY01D/67vcgQ3z/RZJMZcv+8oaMJF3F6ItHmWmZHoHbbsf2RZWooun
 23GMK9IcOBhxdGFoWB9XTPGTh9YNx/HjS2OO98DdwP8e10CkcYaP0/TfrJwpNxy8BVLI
 W5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567755; x=1773172555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rPlPuv+kTa1lRn616AbOEm5DQibTASX0hlhynviKboI=;
 b=H4Dn0gTIvAatai6DNloh3DIZD/sUQBjVPHoJSK5Q6lsjf94Tx5m7FlmP5CMzD74By0
 UAOuXprb1DUueV6plrOEoq7eJJKYQEGzGzRdw9djr5a0VF3ItFquj9qwx5E+YF42kq0g
 gAXf0yU5pdcVgjX3Rqq+C4RZgEmS/ps7cuL4T71X16V/+ulMGbIKr8W9eo7pVQ2x6GI+
 E+ihWQ116Bhi6bZ41Hhhmjoc03cSnJ7o/f3y6qoF+Qi4UfLa6IVTShAIluVlUbuN95SV
 SPwdc78inCrwBrpV+SHIkYi+ylPJjDjzScfea6l0XquEfyHjQdjiC62+K79zjeyeRlk2
 DOdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7OvMgQNdlD1f/R8f5rfu4xZbP0EuEENgraQXPqOhNqpXNlf0hLMdFhACS0MUyyPjlj2V/8XA=@lists.denx.de
X-Gm-Message-State: AOJu0YwGuWvEMCBm8VVqeAF8Z9JSBd5utvVwlsswqf76bzqS8QEeZecw
 3LfKxUAUc+pqm79aC18q6hYV+YliHoKfMIiSon77YEFOOp9ZLEACtAJvPjzLU8ofwa8=
X-Gm-Gg: ATEYQzxLLgo2U4n9weX6dtKUFzQAgV+IjUoLvLLVdHCOC++BnsY19wYCaEBuRa7rf4C
 0JOMjhQFRnhHZjTRxWSkiUbnmcHb8uwTx03XhNB07enGavIdeSeq01GKd8STRsdw2+/k7cNwuLb
 fJ5Jvur2yRsZTNQXa1bYznEeU/yi5vM+mX4Ko9QQ+maNRZ9ITH1p3Eh1zUaSNQZjk8iQP8e4dHw
 THggtdCUvMNd1navaQAhTV1XjshwG5fmqfUIZidRA1F/YaAE+Gx6+inF2XrooqMQ98KvfpXxYt1
 qIGLyAh6ZqYxjrByjFssI4UIrbLMnYBiOyG69XsUFNMJxOd6Acm9AZbm5vAw28vhpWIn+CCnn+i
 IUbDXuhP464HbWH2b+t6gT7d4i4C0S24sBOSzscMQRFHN5lUeRnErXTRZ+XUA/VCRFGpkKMdUtk
 4/crzP7fSlprM2hs07jDorpJeV0kgd
X-Received: by 2002:a05:6808:c3ec:b0:45c:872a:57c with SMTP id
 5614622812f47-464bf0089c3mr10140656b6e.57.1772567754781; 
 Tue, 03 Mar 2026 11:55:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e10b:3ef0:5af1:d180])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb352592sm9995183b6e.1.2026.03.03.11.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:55:54 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Mar 2026 13:54:55 -0600
Subject: [PATCH v4 7/7] clk: mediatek: add clock driver for MT8189
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-mt8189-clocks-v4-7-ee85f8dd2f0d@baylibre.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=68450;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Kj9A9SfGLZ7cJOMHRl500TsDTdZrfgWIOPfZBIVaaT8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBppzy9U+T09dOpvzWbZupGOwY0on4i3IDArx+xW
 Liml8ZygnmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaac8vRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ai7YH/1qYNbijN9sNgl60VD5ixgFbP17M9ziXmiYRUbB
 LLha/hSqdLXu6HCzk3omXkVqbgSlbw7B5+dQ3TcvLiCMJbKhJ/a+MVaHnlOwzBPfU9K+hB0eiX9
 55NvY1cQBK2lxYmmqJWoMmWoo2vR46Plle1vcJXWzNosn1bO/iI4nDLHkbjIJPxnWsH5iAvjEto
 wWaWJdIEJCEINPN44eW96Lk+BS28795zT8T5moc+j9U5SGt39NetkyFF77AyL6pUpFYpirg8b++
 4t/gn2UgX45Xv/TNoNrmh1abGt9OmYMWPXSx1cz+9UixN/sX+HLQowgsiPQ0eh2kdALMN1G9/ho
 pN4E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Chris Chen <chris-qj.chen@mediatek.com>

Add new clock driver for MedaiTek MT8189 and compatible SoCs.

Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/Makefile     |    1 +
 drivers/clk/mediatek/clk-mt8189.c | 1748 +++++++++++++++++++++++++++++++++++++
 2 files changed, 1749 insertions(+)

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 5bede819c0d..d4cac6aaf52 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
 obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
 obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
 obj-$(CONFIG_TARGET_MT8188) += clk-mt8188.o
+obj-$(CONFIG_TARGET_MT8189) += clk-mt8189.o
 obj-$(CONFIG_TARGET_MT8195) += clk-mt8195.o
 obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
 obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
new file mode 100644
index 00000000000..9e48d668db6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -0,0 +1,1748 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Author: Chris Chen <chris-qj.chen@mediatek.com>
+ * Author: David Lechner <dlechner@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+#include <linux/kernel.h>
+
+#include "clk-mtk.h"
+
+/* TOPCK MUX SEL REG */
+#define CLK_CFG_UPDATE				0x0004
+#define CLK_CFG_UPDATE1				0x0008
+#define CLK_CFG_UPDATE2				0x000c
+#define VLP_CLK_CFG_UPDATE			0x0004
+#define CLK_CFG_0				0x0010
+#define CLK_CFG_0_SET				0x0014
+#define CLK_CFG_0_CLR				0x0018
+#define CLK_CFG_1				0x0020
+#define CLK_CFG_1_SET				0x0024
+#define CLK_CFG_1_CLR				0x0028
+#define CLK_CFG_2				0x0030
+#define CLK_CFG_2_SET				0x0034
+#define CLK_CFG_2_CLR				0x0038
+#define CLK_CFG_3				0x0040
+#define CLK_CFG_3_SET				0x0044
+#define CLK_CFG_3_CLR				0x0048
+#define CLK_CFG_4				0x0050
+#define CLK_CFG_4_SET				0x0054
+#define CLK_CFG_4_CLR				0x0058
+#define CLK_CFG_5				0x0060
+#define CLK_CFG_5_SET				0x0064
+#define CLK_CFG_5_CLR				0x0068
+#define CLK_CFG_6				0x0070
+#define CLK_CFG_6_SET				0x0074
+#define CLK_CFG_6_CLR				0x0078
+#define CLK_CFG_7				0x0080
+#define CLK_CFG_7_SET				0x0084
+#define CLK_CFG_7_CLR				0x0088
+#define CLK_CFG_8				0x0090
+#define CLK_CFG_8_SET				0x0094
+#define CLK_CFG_8_CLR				0x0098
+#define CLK_CFG_9				0x00A0
+#define CLK_CFG_9_SET				0x00A4
+#define CLK_CFG_9_CLR				0x00A8
+#define CLK_CFG_10				0x00B0
+#define CLK_CFG_10_SET				0x00B4
+#define CLK_CFG_10_CLR				0x00B8
+#define CLK_CFG_11				0x00C0
+#define CLK_CFG_11_SET				0x00C4
+#define CLK_CFG_11_CLR				0x00C8
+#define CLK_CFG_12				0x00D0
+#define CLK_CFG_12_SET				0x00D4
+#define CLK_CFG_12_CLR				0x00D8
+#define CLK_CFG_13				0x00E0
+#define CLK_CFG_13_SET				0x00E4
+#define CLK_CFG_13_CLR				0x00E8
+#define CLK_CFG_14				0x00F0
+#define CLK_CFG_14_SET				0x00F4
+#define CLK_CFG_14_CLR				0x00F8
+#define CLK_CFG_15				0x0100
+#define CLK_CFG_15_SET				0x0104
+#define CLK_CFG_15_CLR				0x0108
+#define CLK_CFG_16				0x0110
+#define CLK_CFG_16_SET				0x0114
+#define CLK_CFG_16_CLR				0x0118
+#define CLK_CFG_17				0x0180
+#define CLK_CFG_17_SET				0x0184
+#define CLK_CFG_17_CLR				0x0188
+#define CLK_CFG_18				0x0190
+#define CLK_CFG_18_SET				0x0194
+#define CLK_CFG_18_CLR				0x0198
+#define CLK_CFG_19				0x0240
+#define CLK_CFG_19_SET				0x0244
+#define CLK_CFG_19_CLR				0x0248
+#define CLK_AUDDIV_0				0x0320
+#define CLK_MISC_CFG_3				0x0510
+#define CLK_MISC_CFG_3_SET			0x0514
+#define CLK_MISC_CFG_3_CLR			0x0518
+#define VLP_CLK_CFG_0				0x0008
+#define VLP_CLK_CFG_0_SET			0x000C
+#define VLP_CLK_CFG_0_CLR			0x0010
+#define VLP_CLK_CFG_1				0x0014
+#define VLP_CLK_CFG_1_SET			0x0018
+#define VLP_CLK_CFG_1_CLR			0x001C
+#define VLP_CLK_CFG_2				0x0020
+#define VLP_CLK_CFG_2_SET			0x0024
+#define VLP_CLK_CFG_2_CLR			0x0028
+#define VLP_CLK_CFG_3				0x002C
+#define VLP_CLK_CFG_3_SET			0x0030
+#define VLP_CLK_CFG_3_CLR			0x0034
+#define VLP_CLK_CFG_4				0x0038
+#define VLP_CLK_CFG_4_SET			0x003C
+#define VLP_CLK_CFG_4_CLR			0x0040
+#define VLP_CLK_CFG_5				0x0044
+#define VLP_CLK_CFG_5_SET			0x0048
+#define VLP_CLK_CFG_5_CLR			0x004C
+
+/* TOPCK MUX SHIFT */
+#define TOP_MUX_AXI_SHIFT			0
+#define TOP_MUX_AXI_PERI_SHIFT			1
+#define TOP_MUX_AXI_UFS_SHIFT			2
+#define TOP_MUX_BUS_AXIMEM_SHIFT		3
+#define TOP_MUX_DISP0_SHIFT			4
+#define TOP_MUX_MMINFRA_SHIFT			5
+#define TOP_MUX_UART_SHIFT			6
+#define TOP_MUX_SPI0_SHIFT			7
+#define TOP_MUX_SPI1_SHIFT			8
+#define TOP_MUX_SPI2_SHIFT			9
+#define TOP_MUX_SPI3_SHIFT			10
+#define TOP_MUX_SPI4_SHIFT			11
+#define TOP_MUX_SPI5_SHIFT			12
+#define TOP_MUX_MSDC_MACRO_0P_SHIFT		13
+#define TOP_MUX_MSDC50_0_HCLK_SHIFT		14
+#define TOP_MUX_MSDC50_0_SHIFT			15
+#define TOP_MUX_AES_MSDCFDE_SHIFT		16
+#define TOP_MUX_MSDC_MACRO_1P_SHIFT		17
+#define TOP_MUX_MSDC30_1_SHIFT			18
+#define TOP_MUX_MSDC30_1_HCLK_SHIFT		19
+#define TOP_MUX_MSDC_MACRO_2P_SHIFT		20
+#define TOP_MUX_MSDC30_2_SHIFT			21
+#define TOP_MUX_MSDC30_2_HCLK_SHIFT		22
+#define TOP_MUX_AUD_INTBUS_SHIFT		23
+#define TOP_MUX_ATB_SHIFT			24
+#define TOP_MUX_DISP_PWM_SHIFT			25
+#define TOP_MUX_USB_TOP_P0_SHIFT		26
+#define TOP_MUX_SSUSB_XHCI_P0_SHIFT		27
+#define TOP_MUX_USB_TOP_P1_SHIFT		28
+#define TOP_MUX_SSUSB_XHCI_P1_SHIFT		29
+#define TOP_MUX_USB_TOP_P2_SHIFT		30
+#define TOP_MUX_SSUSB_XHCI_P2_SHIFT		0
+#define TOP_MUX_USB_TOP_P3_SHIFT		1
+#define TOP_MUX_SSUSB_XHCI_P3_SHIFT		2
+#define TOP_MUX_USB_TOP_P4_SHIFT		3
+#define TOP_MUX_SSUSB_XHCI_P4_SHIFT		4
+#define TOP_MUX_I2C_SHIFT			5
+#define TOP_MUX_SENINF_SHIFT			6
+#define TOP_MUX_SENINF1_SHIFT			7
+#define TOP_MUX_AUD_ENGEN1_SHIFT		8
+#define TOP_MUX_AUD_ENGEN2_SHIFT		9
+#define TOP_MUX_AES_UFSFDE_SHIFT		10
+#define TOP_MUX_UFS_SHIFT			11
+#define TOP_MUX_UFS_MBIST_SHIFT			12
+#define TOP_MUX_AUD_1_SHIFT			13
+#define TOP_MUX_AUD_2_SHIFT			14
+#define TOP_MUX_VENC_SHIFT			15
+#define TOP_MUX_VDEC_SHIFT			16
+#define TOP_MUX_PWM_SHIFT			17
+#define TOP_MUX_AUDIO_H_SHIFT			18
+#define TOP_MUX_MCUPM_SHIFT			19
+#define TOP_MUX_MEM_SUB_SHIFT			20
+#define TOP_MUX_MEM_SUB_PERI_SHIFT		21
+#define TOP_MUX_MEM_SUB_UFS_SHIFT		22
+#define TOP_MUX_EMI_N_SHIFT			23
+#define TOP_MUX_DSI_OCC_SHIFT			24
+#define TOP_MUX_AP2CONN_HOST_SHIFT		25
+#define TOP_MUX_IMG1_SHIFT			26
+#define TOP_MUX_IPE_SHIFT			27
+#define TOP_MUX_CAM_SHIFT			28
+#define TOP_MUX_CAMTM_SHIFT			29
+#define TOP_MUX_DSP_SHIFT			30
+#define TOP_MUX_SR_PKA_SHIFT			0
+#define TOP_MUX_DXCC_SHIFT			1
+#define TOP_MUX_MFG_REF_SHIFT			2
+#define TOP_MUX_MDP0_SHIFT			3
+#define TOP_MUX_DP_SHIFT			4
+#define TOP_MUX_EDP_SHIFT			5
+#define TOP_MUX_EDP_FAVT_SHIFT			6
+#define TOP_MUX_SNPS_ETH_250M_SHIFT		7
+#define TOP_MUX_SNPS_ETH_62P4M_PTP_SHIFT	8
+#define TOP_MUX_SNPS_ETH_50M_RMII_SHIFT		9
+#define TOP_MUX_SFLASH_SHIFT			10
+#define TOP_MUX_GCPU_SHIFT			11
+#define TOP_MUX_PCIE_MAC_TL_SHIFT		12
+#define TOP_MUX_VDSTX_CLKDIG_CTS_SHIFT		13
+#define TOP_MUX_PLL_DPIX_SHIFT			14
+#define TOP_MUX_ECC_SHIFT			15
+#define TOP_MUX_SCP_SHIFT			0
+#define TOP_MUX_PWRAP_ULPOSC_SHIFT		1
+#define TOP_MUX_SPMI_P_MST_SHIFT		2
+#define TOP_MUX_DVFSRC_SHIFT			3
+#define TOP_MUX_PWM_VLP_SHIFT			4
+#define TOP_MUX_AXI_VLP_SHIFT			5
+#define TOP_MUX_SYSTIMER_26M_SHIFT		6
+#define TOP_MUX_SSPM_SHIFT			7
+#define TOP_MUX_SSPM_F26M_SHIFT			8
+#define TOP_MUX_SRCK_SHIFT			9
+#define TOP_MUX_SCP_SPI_SHIFT			10
+#define TOP_MUX_SCP_IIC_SHIFT			11
+#define TOP_MUX_SCP_SPI_HIGH_SPD_SHIFT		12
+#define TOP_MUX_SCP_IIC_HIGH_SPD_SHIFT		13
+#define TOP_MUX_SSPM_ULPOSC_SHIFT		14
+#define TOP_MUX_APXGPT_26M_SHIFT		15
+#define TOP_MUX_VADSP_SHIFT			16
+#define TOP_MUX_VADSP_VOWPLL_SHIFT		17
+#define TOP_MUX_VADSP_UARTHUB_BCLK_SHIFT	18
+#define TOP_MUX_CAMTG0_SHIFT			19
+#define TOP_MUX_CAMTG1_SHIFT			20
+#define TOP_MUX_CAMTG2_SHIFT			21
+#define TOP_MUX_AUD_ADC_SHIFT			22
+#define TOP_MUX_KP_IRQ_GEN_SHIFT		23
+
+/* TOPCK DIVIDER REG */
+#define CLK_AUDDIV_2				0x0328
+#define CLK_AUDDIV_3				0x0334
+#define CLK_AUDDIV_5				0x033C
+
+/* APMIXED PLL REG */
+#define AP_PLL_CON3				0x00C
+#define APLL1_TUNER_CON0			0x040
+#define APLL2_TUNER_CON0			0x044
+#define ARMPLL_LL_CON0				0x204
+#define ARMPLL_LL_CON1				0x208
+#define ARMPLL_LL_CON2				0x20C
+#define ARMPLL_LL_CON3				0x210
+#define ARMPLL_BL_CON0				0x214
+#define ARMPLL_BL_CON1				0x218
+#define ARMPLL_BL_CON2				0x21C
+#define ARMPLL_BL_CON3				0x220
+#define CCIPLL_CON0				0x224
+#define CCIPLL_CON1				0x228
+#define CCIPLL_CON2				0x22C
+#define CCIPLL_CON3				0x230
+#define MAINPLL_CON0				0x304
+#define MAINPLL_CON1				0x308
+#define MAINPLL_CON2				0x30C
+#define MAINPLL_CON3				0x310
+#define UNIVPLL_CON0				0x314
+#define UNIVPLL_CON1				0x318
+#define UNIVPLL_CON2				0x31C
+#define UNIVPLL_CON3				0x320
+#define MMPLL_CON0				0x324
+#define MMPLL_CON1				0x328
+#define MMPLL_CON2				0x32C
+#define MMPLL_CON3				0x330
+#define MFGPLL_CON0				0x504
+#define MFGPLL_CON1				0x508
+#define MFGPLL_CON2				0x50C
+#define MFGPLL_CON3				0x510
+#define APLL1_CON0				0x404
+#define APLL1_CON1				0x408
+#define APLL1_CON2				0x40C
+#define APLL1_CON3				0x410
+#define APLL1_CON4				0x414
+#define APLL2_CON0				0x418
+#define APLL2_CON1				0x41C
+#define APLL2_CON2				0x420
+#define APLL2_CON3				0x424
+#define APLL2_CON4				0x428
+#define EMIPLL_CON0				0x334
+#define EMIPLL_CON1				0x338
+#define EMIPLL_CON2				0x33C
+#define EMIPLL_CON3				0x340
+#define APUPLL2_CON0				0x614
+#define APUPLL2_CON1				0x618
+#define APUPLL2_CON2				0x61C
+#define APUPLL2_CON3				0x620
+#define APUPLL_CON0				0x604
+#define APUPLL_CON1				0x608
+#define APUPLL_CON2				0x60C
+#define APUPLL_CON3				0x610
+#define TVDPLL1_CON0				0x42C
+#define TVDPLL1_CON1				0x430
+#define TVDPLL1_CON2				0x434
+#define TVDPLL1_CON3				0x438
+#define TVDPLL2_CON0				0x43C
+#define TVDPLL2_CON1				0x440
+#define TVDPLL2_CON2				0x444
+#define TVDPLL2_CON3				0x448
+#define ETHPLL_CON0				0x514
+#define ETHPLL_CON1				0x518
+#define ETHPLL_CON2				0x51C
+#define ETHPLL_CON3				0x520
+#define MSDCPLL_CON0				0x524
+#define MSDCPLL_CON1				0x528
+#define MSDCPLL_CON2				0x52C
+#define MSDCPLL_CON3				0x530
+#define UFSPLL_CON0				0x534
+#define UFSPLL_CON1				0x538
+#define UFSPLL_CON2				0x53C
+#define UFSPLL_CON3				0x540
+
+#define CLK_PAD_CLK32K			0
+#define CLK_PAD_CLK26M			1
+#define CLK_PAD_ULPOSC			2
+
+static ulong pad_clks[] = {
+	[CLK_PAD_CLK32K] = 32000,
+	[CLK_PAD_CLK26M] = 26000000,
+	[CLK_PAD_ULPOSC] = 260000000,
+};
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+
+#define PLL(_id, _reg, _flags, _pd_reg, _pd_shift, _pcw_reg, _pcw_shift, _pcwbits) \
+	{								\
+		.id = _id,						\
+		.reg = _reg,						\
+		.flags = (_flags),					\
+		.fmax = MT8189_PLL_FMAX,				\
+		.fmin = MT8189_PLL_FMIN,				\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = 8,						\
+	}
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL(CLK_APMIXED_ARMPLL_LL, ARMPLL_LL_CON0, 0, ARMPLL_LL_CON1, 24, ARMPLL_LL_CON1, 0, 22),
+	PLL(CLK_APMIXED_ARMPLL_BL, ARMPLL_BL_CON0, 0, ARMPLL_BL_CON1, 24, ARMPLL_BL_CON1, 0, 22),
+	PLL(CLK_APMIXED_CCIPLL, CCIPLL_CON0, 0, CCIPLL_CON1, 24, CCIPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_MAINPLL, MAINPLL_CON0, 0, MAINPLL_CON1, 24, MAINPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_UNIVPLL, UNIVPLL_CON0, 0, UNIVPLL_CON1, 24, UNIVPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_MMPLL, MMPLL_CON0, 0, MMPLL_CON1, 24, MMPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_MFGPLL, MFGPLL_CON0, 0, MFGPLL_CON1, 24, MFGPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_APLL1, APLL1_CON0, 0, APLL1_CON1, 24, APLL1_CON2, 0, 32),
+	PLL(CLK_APMIXED_APLL2, APLL2_CON0, 0, APLL2_CON1, 24, APLL2_CON2, 0, 32),
+	PLL(CLK_APMIXED_EMIPLL, EMIPLL_CON0, 0, EMIPLL_CON1, 24, EMIPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_APUPLL2, APUPLL2_CON0, 0, APUPLL2_CON1, 24, APUPLL2_CON1, 0, 22),
+	PLL(CLK_APMIXED_APUPLL, APUPLL_CON0, 0, APUPLL_CON1, 24, APUPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_TVDPLL1, TVDPLL1_CON0, 0, TVDPLL1_CON1, 24, TVDPLL1_CON1, 0, 22),
+	PLL(CLK_APMIXED_TVDPLL2, TVDPLL2_CON0, 0, TVDPLL2_CON1, 24, TVDPLL2_CON1, 0, 22),
+	PLL(CLK_APMIXED_ETHPLL, ETHPLL_CON0, 0, ETHPLL_CON1, 24, ETHPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_MSDCPLL, MSDCPLL_CON0, 0, MSDCPLL_CON1, 24, MSDCPLL_CON1, 0, 22),
+	PLL(CLK_APMIXED_UFSPLL, UFSPLL_CON0, 0, UFSPLL_CON1, 24, UFSPLL_CON1, 0, 22),
+};
+
+#define FACTOR0(id, parent, mult, div) \
+	FACTOR(id, parent, mult, div, CLK_PARENT_APMIXED)
+
+#define FACTOR1(id, parent, mult, div) \
+	FACTOR(id, parent, mult, div, CLK_PARENT_EXT)
+
+static const struct mtk_fixed_factor top_fixed_divs[] = {
+	FACTOR0(CLK_TOP_MAINPLL_D3, CLK_APMIXED_MAINPLL, 1, 3),
+	FACTOR0(CLK_TOP_MAINPLL_D4, CLK_APMIXED_MAINPLL, 1, 4),
+	FACTOR0(CLK_TOP_MAINPLL_D4_D2, CLK_APMIXED_MAINPLL, 1, 8),
+	FACTOR0(CLK_TOP_MAINPLL_D4_D4, CLK_APMIXED_MAINPLL, 1, 16),
+	FACTOR0(CLK_TOP_MAINPLL_D4_D8, CLK_APMIXED_MAINPLL, 43, 1375),
+	FACTOR0(CLK_TOP_MAINPLL_D5, CLK_APMIXED_MAINPLL, 1, 5),
+	FACTOR0(CLK_TOP_MAINPLL_D5_D2, CLK_APMIXED_MAINPLL, 1, 10),
+	FACTOR0(CLK_TOP_MAINPLL_D5_D4, CLK_APMIXED_MAINPLL, 1, 20),
+	FACTOR0(CLK_TOP_MAINPLL_D5_D8, CLK_APMIXED_MAINPLL, 1, 40),
+	FACTOR0(CLK_TOP_MAINPLL_D6, CLK_APMIXED_MAINPLL, 1, 6),
+	FACTOR0(CLK_TOP_MAINPLL_D6_D2, CLK_APMIXED_MAINPLL, 1, 12),
+	FACTOR0(CLK_TOP_MAINPLL_D6_D4, CLK_APMIXED_MAINPLL, 1, 24),
+	FACTOR0(CLK_TOP_MAINPLL_D6_D8, CLK_APMIXED_MAINPLL, 1, 48),
+	FACTOR0(CLK_TOP_MAINPLL_D7, CLK_APMIXED_MAINPLL, 1, 7),
+	FACTOR0(CLK_TOP_MAINPLL_D7_D2, CLK_APMIXED_MAINPLL, 1, 14),
+	FACTOR0(CLK_TOP_MAINPLL_D7_D4, CLK_APMIXED_MAINPLL, 1, 28),
+	FACTOR0(CLK_TOP_MAINPLL_D7_D8, CLK_APMIXED_MAINPLL, 1, 56),
+	FACTOR0(CLK_TOP_MAINPLL_D9, CLK_APMIXED_MAINPLL, 1, 9),
+	FACTOR0(CLK_TOP_UNIVPLL_D2, CLK_APMIXED_UNIVPLL, 1, 2),
+	FACTOR0(CLK_TOP_UNIVPLL_D3, CLK_APMIXED_UNIVPLL, 1, 3),
+	FACTOR0(CLK_TOP_UNIVPLL_D4, CLK_APMIXED_UNIVPLL, 1, 4),
+	FACTOR0(CLK_TOP_UNIVPLL_D4_D2, CLK_APMIXED_UNIVPLL, 1, 8),
+	FACTOR0(CLK_TOP_UNIVPLL_D4_D4, CLK_APMIXED_UNIVPLL, 1, 16),
+	FACTOR0(CLK_TOP_UNIVPLL_D4_D8, CLK_APMIXED_UNIVPLL, 1, 32),
+	FACTOR0(CLK_TOP_UNIVPLL_D5, CLK_APMIXED_UNIVPLL, 1, 5),
+	FACTOR0(CLK_TOP_UNIVPLL_D5_D2, CLK_APMIXED_UNIVPLL, 1, 10),
+	FACTOR0(CLK_TOP_UNIVPLL_D5_D4, CLK_APMIXED_UNIVPLL, 1, 20),
+	FACTOR0(CLK_TOP_UNIVPLL_D6, CLK_APMIXED_UNIVPLL, 1, 6),
+	FACTOR0(CLK_TOP_UNIVPLL_D6_D2, CLK_APMIXED_UNIVPLL, 1, 12),
+	FACTOR0(CLK_TOP_UNIVPLL_D6_D4, CLK_APMIXED_UNIVPLL, 1, 24),
+	FACTOR0(CLK_TOP_UNIVPLL_D6_D8, CLK_APMIXED_UNIVPLL, 1, 48),
+	FACTOR0(CLK_TOP_UNIVPLL_D6_D16, CLK_APMIXED_UNIVPLL, 1, 96),
+	FACTOR0(CLK_TOP_UNIVPLL_D7, CLK_APMIXED_UNIVPLL, 1, 7),
+	FACTOR0(CLK_TOP_UNIVPLL_D7_D2, CLK_APMIXED_UNIVPLL, 1, 14),
+	FACTOR0(CLK_TOP_UNIVPLL_D7_D3, CLK_APMIXED_UNIVPLL, 1, 21),
+	FACTOR0(CLK_TOP_LVDSTX_DG_CTS, CLK_APMIXED_UNIVPLL, 1, 21),
+	FACTOR0(CLK_TOP_UNIVPLL_192M, CLK_APMIXED_UNIVPLL, 1, 13),
+	FACTOR0(CLK_TOP_UNIVPLL_192M_D2, CLK_APMIXED_UNIVPLL, 1, 26),
+	FACTOR0(CLK_TOP_UNIVPLL_192M_D4, CLK_APMIXED_UNIVPLL, 1, 52),
+	FACTOR0(CLK_TOP_UNIVPLL_192M_D8, CLK_APMIXED_UNIVPLL, 1, 104),
+	FACTOR0(CLK_TOP_UNIVPLL_192M_D10, CLK_APMIXED_UNIVPLL, 1, 130),
+	FACTOR0(CLK_TOP_UNIVPLL_192M_D16, CLK_APMIXED_UNIVPLL, 1, 208),
+	FACTOR0(CLK_TOP_UNIVPLL_192M_D32, CLK_APMIXED_UNIVPLL, 1, 416),
+	FACTOR0(CLK_TOP_APLL1_D2, CLK_APMIXED_APLL1, 1, 2),
+	FACTOR0(CLK_TOP_APLL1_D4, CLK_APMIXED_APLL1, 1, 4),
+	FACTOR0(CLK_TOP_APLL1_D8, CLK_APMIXED_APLL1, 1, 8),
+	FACTOR0(CLK_TOP_APLL1_D3, CLK_APMIXED_APLL1, 1, 3),
+	FACTOR0(CLK_TOP_APLL2_D2, CLK_APMIXED_APLL2, 1, 2),
+	FACTOR0(CLK_TOP_APLL2_D4, CLK_APMIXED_APLL2, 1, 4),
+	FACTOR0(CLK_TOP_APLL2_D8, CLK_APMIXED_APLL2, 1, 8),
+	FACTOR0(CLK_TOP_APLL2_D3, CLK_APMIXED_APLL2, 1, 3),
+	FACTOR0(CLK_TOP_MMPLL_D4, CLK_APMIXED_MMPLL, 1, 4),
+	FACTOR0(CLK_TOP_MMPLL_D4_D2, CLK_APMIXED_MMPLL, 1, 8),
+	FACTOR0(CLK_TOP_MMPLL_D4_D4, CLK_APMIXED_MMPLL, 1, 16),
+	FACTOR0(CLK_TOP_VPLL_DPIX, CLK_APMIXED_MMPLL, 1, 16),
+	FACTOR0(CLK_TOP_MMPLL_D5, CLK_APMIXED_MMPLL, 1, 5),
+	FACTOR0(CLK_TOP_MMPLL_D5_D2, CLK_APMIXED_MMPLL, 1, 10),
+	FACTOR0(CLK_TOP_MMPLL_D5_D4, CLK_APMIXED_MMPLL, 1, 20),
+	FACTOR0(CLK_TOP_MMPLL_D6, CLK_APMIXED_MMPLL, 1, 6),
+	FACTOR0(CLK_TOP_MMPLL_D6_D2, CLK_APMIXED_MMPLL, 1, 12),
+	FACTOR0(CLK_TOP_MMPLL_D7, CLK_APMIXED_MMPLL, 1, 7),
+	FACTOR0(CLK_TOP_MMPLL_D9, CLK_APMIXED_MMPLL, 1, 9),
+	FACTOR0(CLK_TOP_TVDPLL1_D2, CLK_APMIXED_TVDPLL1, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL1_D4, CLK_APMIXED_TVDPLL1, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL1_D8, CLK_APMIXED_TVDPLL1, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL1_D16, CLK_APMIXED_TVDPLL1, 92, 1473),
+	FACTOR0(CLK_TOP_TVDPLL2_D2, CLK_APMIXED_TVDPLL2, 1, 2),
+	FACTOR0(CLK_TOP_TVDPLL2_D4, CLK_APMIXED_TVDPLL2, 1, 4),
+	FACTOR0(CLK_TOP_TVDPLL2_D8, CLK_APMIXED_TVDPLL2, 1, 8),
+	FACTOR0(CLK_TOP_TVDPLL2_D16, CLK_APMIXED_TVDPLL2, 92, 1473),
+	FACTOR0(CLK_TOP_ETHPLL_D2, CLK_APMIXED_ETHPLL, 1, 2),
+	FACTOR0(CLK_TOP_ETHPLL_D8, CLK_APMIXED_ETHPLL, 1, 8),
+	FACTOR0(CLK_TOP_ETHPLL_D10, CLK_APMIXED_ETHPLL, 1, 10),
+	FACTOR0(CLK_TOP_MSDCPLL_D2, CLK_APMIXED_MSDCPLL, 1, 2),
+	FACTOR1(CLK_TOP_VOWPLL, CLK_PAD_CLK26M, 1, 1),
+	FACTOR0(CLK_TOP_UFSPLL_D2, CLK_APMIXED_UFSPLL, 1, 2),
+	FACTOR1(CLK_TOP_F26M_CK_D2, CLK_PAD_CLK26M, 1, 2),
+	FACTOR1(CLK_TOP_OSC_D2, CLK_PAD_ULPOSC, 1, 2),
+	FACTOR1(CLK_TOP_OSC_D4, CLK_PAD_ULPOSC, 1, 4),
+	FACTOR1(CLK_TOP_OSC_D8, CLK_PAD_ULPOSC, 1, 8),
+	FACTOR1(CLK_TOP_OSC_D16, CLK_PAD_ULPOSC, 61, 973),
+	FACTOR1(CLK_TOP_OSC_D3, CLK_PAD_ULPOSC, 1, 3),
+	FACTOR1(CLK_TOP_OSC_D7, CLK_PAD_ULPOSC, 1, 7),
+	FACTOR1(CLK_TOP_OSC_D10, CLK_PAD_ULPOSC, 1, 10),
+	FACTOR1(CLK_TOP_OSC_D20, CLK_PAD_ULPOSC, 1, 20),
+};
+
+#define EXT_PARENT(id) PARENT(id, CLK_PARENT_EXT)
+#define APMIXED_PARENT(id) PARENT(id, CLK_PARENT_APMIXED)
+#define TOP_PARENT(id) PARENT(id, CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_parent axi_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+};
+
+static const struct mtk_parent axi_peri_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+};
+
+static const struct mtk_parent axi_u_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_OSC_D8),
+};
+
+static const struct mtk_parent bus_aximem_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+};
+
+static const struct mtk_parent disp0_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+};
+
+static const struct mtk_parent mminfra_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	APMIXED_PARENT(CLK_APMIXED_EMIPLL),
+};
+
+static const struct mtk_parent uart_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+};
+
+static const struct mtk_parent spi0_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent spi1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent spi2_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent spi3_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent spi4_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent spi5_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent msdc_macro_0p_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent msdc5hclk_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+};
+
+static const struct mtk_parent msdc50_0_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+};
+
+static const struct mtk_parent aes_msdcfde_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
+};
+
+static const struct mtk_parent msdc_macro_1p_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent msdc30_1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent msdc30_1_h_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
+};
+
+static const struct mtk_parent msdc_macro_2p_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_MSDCPLL),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent msdc30_2_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent msdc30_2_h_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
+};
+
+static const struct mtk_parent aud_intbus_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+};
+
+static const struct mtk_parent atb_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+};
+
+static const struct mtk_parent disp_pwm_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+	TOP_PARENT(CLK_TOP_OSC_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+};
+
+static const struct mtk_parent usb_p0_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent ssusb_xhci_p0_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent usb_p1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent ssusb_xhci_p1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent usb_p2_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent ssusb_xhci_p2_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent usb_p3_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent ssusb_xhci_p3_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent usb_p4_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent ssusb_xhci_p4_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent i2c_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+};
+
+static const struct mtk_parent seninf_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent seninf1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent aud_engen1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL1_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL1_D8),
+};
+
+static const struct mtk_parent aud_engen2_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_APLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D8),
+};
+
+static const struct mtk_parent aes_ufsfde_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+};
+
+static const struct mtk_parent ufs_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MSDCPLL_D2),
+};
+
+static const struct mtk_parent ufs_mbist_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UFSPLL_D2),
+};
+
+static const struct mtk_parent aud_1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_APLL1),
+};
+
+static const struct mtk_parent aud_2_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	APMIXED_PARENT(CLK_APMIXED_APLL2),
+};
+
+static const struct mtk_parent venc_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D9),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+};
+
+static const struct mtk_parent vdec_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
+};
+
+static const struct mtk_parent pwm_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D8),
+};
+
+static const struct mtk_parent audio_h_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7_D2),
+	APMIXED_PARENT(CLK_APMIXED_APLL1),
+	APMIXED_PARENT(CLK_APMIXED_APLL2),
+};
+
+static const struct mtk_parent mcupm_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+};
+
+static const struct mtk_parent mem_sub_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+};
+
+static const struct mtk_parent mem_sub_peri_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+};
+
+static const struct mtk_parent mem_sub_u_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+};
+
+static const struct mtk_parent emi_n_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D9),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+	APMIXED_PARENT(CLK_APMIXED_EMIPLL),
+};
+
+static const struct mtk_parent dsi_occ_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+};
+
+static const struct mtk_parent ap2conn_host_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+};
+
+static const struct mtk_parent img1_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
+};
+
+static const struct mtk_parent ipe_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D5_D2),
+};
+
+static const struct mtk_parent cam_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+	TOP_PARENT(CLK_TOP_MMPLL_D7),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MMPLL_D9),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+};
+
+static const struct mtk_parent camtm_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+};
+
+static const struct mtk_parent dsp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+	TOP_PARENT(CLK_TOP_OSC_D3),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5),
+};
+
+static const struct mtk_parent sr_pka_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5),
+};
+
+static const struct mtk_parent dxcc_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+};
+
+static const struct mtk_parent mfg_ref_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+};
+
+static const struct mtk_parent mdp0_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MMPLL_D6),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL1),
+	APMIXED_PARENT(CLK_APMIXED_TVDPLL2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_MMPLL_D4),
+};
+
+static const struct mtk_parent dp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D16),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D2),
+};
+
+static const struct mtk_parent edp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D16),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+};
+
+static const struct mtk_parent edp_favt_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D16),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D8),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D4),
+	TOP_PARENT(CLK_TOP_TVDPLL2_D2),
+	TOP_PARENT(CLK_TOP_APLL1_D4),
+	TOP_PARENT(CLK_TOP_APLL2_D4),
+};
+
+static const struct mtk_parent snps_eth_250m_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D2),
+};
+
+static const struct mtk_parent snps_eth_62p4m_ptp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D8),
+	TOP_PARENT(CLK_TOP_APLL1_D3),
+	TOP_PARENT(CLK_TOP_APLL2_D3),
+};
+
+static const struct mtk_parent snps_eth_50m_rmii_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_ETHPLL_D10),
+};
+
+static const struct mtk_parent sflash_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+};
+
+static const struct mtk_parent gcpu_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+};
+
+static const struct mtk_parent pcie_mac_tl_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D4),
+};
+
+static const struct mtk_parent vdstx_dg_cts_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_LVDSTX_DG_CTS),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D7_D3),
+};
+
+static const struct mtk_parent pll_dpix_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_VPLL_DPIX),
+	TOP_PARENT(CLK_TOP_MMPLL_D4_D4),
+};
+
+static const struct mtk_parent ecc_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+};
+
+#define MUX_CLR_SET_UPD(_id, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,	\
+			_shift, _width,	_upd_ofs, _upd)				\
+	MUX_MIXED_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,	\
+				    _mux_clr_ofs, _shift, _width, -1, _upd_ofs,	\
+				    _upd, CLK_MUX_SETCLR_UPD)
+
+#define MUX_GATE_CLR_SET_UPD(_id, _parents, _mux_ofs, _mux_set_ofs,		\
+			      _mux_clr_ofs, _shift, _width, _gate, _upd_ofs,	\
+			      _upd)						\
+	MUX_MIXED_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,	\
+				   _mux_clr_ofs, _shift, _width, _gate,		\
+				   _upd_ofs, _upd, CLK_MUX_SETCLR_UPD)
+
+const struct mtk_composite top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_SEL, axi_parents, CLK_CFG_0, CLK_CFG_0_SET,
+			CLK_CFG_0_CLR, 0, 3, CLK_CFG_UPDATE, TOP_MUX_AXI_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_PERI_SEL, axi_peri_parents, CLK_CFG_0,
+			CLK_CFG_0_SET, CLK_CFG_0_CLR, 8, 2, CLK_CFG_UPDATE,
+			TOP_MUX_AXI_PERI_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_AXI_U_SEL, axi_u_parents, CLK_CFG_0,
+			CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 2, CLK_CFG_UPDATE,
+			TOP_MUX_AXI_UFS_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_BUS_AXIMEM_SEL, bus_aximem_parents, CLK_CFG_0,
+			CLK_CFG_0_SET, CLK_CFG_0_CLR, 24, 3, CLK_CFG_UPDATE,
+			TOP_MUX_BUS_AXIMEM_SHIFT),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP0_SEL, disp0_parents, CLK_CFG_1,
+			     CLK_CFG_1_SET, CLK_CFG_1_CLR, 0, 4, 7,
+					CLK_CFG_UPDATE, TOP_MUX_DISP0_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MMINFRA_SEL, mminfra_parents, CLK_CFG_1,
+			     CLK_CFG_1_SET, CLK_CFG_1_CLR, 8, 4, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_MMINFRA_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, uart_parents, CLK_CFG_1,
+			     CLK_CFG_1_SET, CLK_CFG_1_CLR, 16, 1, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_UART_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI0_SEL, spi0_parents, CLK_CFG_1,
+			     CLK_CFG_1_SET, CLK_CFG_1_CLR, 24, 3, 31,
+			     CLK_CFG_UPDATE, TOP_MUX_SPI0_SHIFT),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI1_SEL, spi1_parents, CLK_CFG_2,
+			     CLK_CFG_2_SET, CLK_CFG_2_CLR, 0, 3, 7,
+			     CLK_CFG_UPDATE, TOP_MUX_SPI1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI2_SEL, spi2_parents, CLK_CFG_2,
+			     CLK_CFG_2_SET, CLK_CFG_2_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_SPI2_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI3_SEL, spi3_parents, CLK_CFG_2,
+			     CLK_CFG_2_SET, CLK_CFG_2_CLR, 16, 3, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_SPI3_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI4_SEL, spi4_parents, CLK_CFG_2,
+			     CLK_CFG_2_SET, CLK_CFG_2_CLR, 24, 3, 31,
+			     CLK_CFG_UPDATE, TOP_MUX_SPI4_SHIFT),
+	/* CLK_CFG_3 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI5_SEL, spi5_parents, CLK_CFG_3,
+			     CLK_CFG_3_SET, CLK_CFG_3_CLR, 0, 3, 7,
+			     CLK_CFG_UPDATE, TOP_MUX_SPI5_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_0P_SEL, msdc_macro_0p_parents,
+			     CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 8, 2, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC_MACRO_0P_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL, msdc5hclk_parents,
+			     CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC50_0_HCLK_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents, CLK_CFG_3,
+			     CLK_CFG_3_SET, CLK_CFG_3_CLR, 24, 3, 31,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC50_0_SHIFT),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE_SEL, aes_msdcfde_parents,
+			     CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 0, 3, 7,
+			     CLK_CFG_UPDATE, TOP_MUX_AES_MSDCFDE_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_1P_SEL, msdc_macro_1p_parents,
+			     CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 8, 2, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC_MACRO_1P_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, CLK_CFG_4,
+			     CLK_CFG_4_SET, CLK_CFG_4_CLR, 16, 3, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC30_1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_HCLK_SEL, msdc30_1_h_parents,
+			     CLK_CFG_4, CLK_CFG_4_SET, CLK_CFG_4_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC30_1_HCLK_SHIFT),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC_MACRO_2P_SEL, msdc_macro_2p_parents,
+			     CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC_MACRO_2P_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, msdc30_2_parents, CLK_CFG_5,
+			     CLK_CFG_5_SET, CLK_CFG_5_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC30_2_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_HCLK_SEL, msdc30_2_h_parents,
+			     CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_MSDC30_2_HCLK_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
+			     CLK_CFG_5, CLK_CFG_5_SET, CLK_CFG_5_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE, TOP_MUX_AUD_INTBUS_SHIFT),
+	/* CLK_CFG_6 */
+	MUX_CLR_SET_UPD(CLK_TOP_ATB_SEL, atb_parents, CLK_CFG_6, CLK_CFG_6_SET,
+			CLK_CFG_6_CLR, 0, 2, CLK_CFG_UPDATE, TOP_MUX_ATB_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents, CLK_CFG_6,
+			     CLK_CFG_6_SET, CLK_CFG_6_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_DISP_PWM_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P0_SEL, usb_p0_parents, CLK_CFG_6,
+			     CLK_CFG_6_SET, CLK_CFG_6_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_USB_TOP_P0_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P0_SEL, ssusb_xhci_p0_parents,
+			     CLK_CFG_6, CLK_CFG_6_SET, CLK_CFG_6_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE, TOP_MUX_SSUSB_XHCI_P0_SHIFT),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P1_SEL, usb_p1_parents, CLK_CFG_7,
+			     CLK_CFG_7_SET, CLK_CFG_7_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE, TOP_MUX_USB_TOP_P1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P1_SEL, ssusb_xhci_p1_parents,
+			     CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 8, 2, 15,
+			     CLK_CFG_UPDATE, TOP_MUX_SSUSB_XHCI_P1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P2_SEL, usb_p2_parents, CLK_CFG_7,
+			     CLK_CFG_7_SET, CLK_CFG_7_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE, TOP_MUX_USB_TOP_P2_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P2_SEL, ssusb_xhci_p2_parents,
+			     CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_SSUSB_XHCI_P2_SHIFT),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P3_SEL, usb_p3_parents, CLK_CFG_8,
+			     CLK_CFG_8_SET, CLK_CFG_8_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE1, TOP_MUX_USB_TOP_P3_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P3_SEL, ssusb_xhci_p3_parents,
+			     CLK_CFG_8, CLK_CFG_8_SET, CLK_CFG_8_CLR, 8, 2, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_SSUSB_XHCI_P3_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP_P4_SEL, usb_p4_parents, CLK_CFG_8,
+			     CLK_CFG_8_SET, CLK_CFG_8_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE1, TOP_MUX_USB_TOP_P4_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_XHCI_P4_SEL, ssusb_xhci_p4_parents,
+			     CLK_CFG_8, CLK_CFG_8_SET, CLK_CFG_8_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_SSUSB_XHCI_P4_SHIFT),
+	/* CLK_CFG_9 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, i2c_parents, CLK_CFG_9,
+			     CLK_CFG_9_SET, CLK_CFG_9_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE1, TOP_MUX_I2C_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF_SEL, seninf_parents,
+			     CLK_CFG_9, CLK_CFG_9_SET, CLK_CFG_9_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_SENINF_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1_SEL, seninf1_parents, CLK_CFG_9,
+			     CLK_CFG_9_SET, CLK_CFG_9_CLR, 16, 3, 23,
+			     CLK_CFG_UPDATE1, TOP_MUX_SENINF1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents,
+			     CLK_CFG_9, CLK_CFG_9_SET, CLK_CFG_9_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_AUD_ENGEN1_SHIFT),
+	/* CLK_CFG_10 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents,
+			     CLK_CFG_10, CLK_CFG_10_SET, CLK_CFG_10_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE1, TOP_MUX_AUD_ENGEN2_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_UFSFDE_SEL, aes_ufsfde_parents,
+			     CLK_CFG_10, CLK_CFG_10_SET, CLK_CFG_10_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_AES_UFSFDE_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U_SEL, ufs_parents, CLK_CFG_10,
+			     CLK_CFG_10_SET, CLK_CFG_10_CLR, 16, 3, 23,
+			     CLK_CFG_UPDATE1, TOP_MUX_UFS_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U_MBIST_SEL, ufs_mbist_parents, CLK_CFG_10,
+			     CLK_CFG_10_SET, CLK_CFG_10_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_UFS_MBIST_SHIFT),
+	/* CLK_CFG_11 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_1_SEL, aud_1_parents, CLK_CFG_11,
+			     CLK_CFG_11_SET, CLK_CFG_11_CLR, 0, 1, 7,
+			     CLK_CFG_UPDATE1, TOP_MUX_AUD_1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_2_SEL, aud_2_parents, CLK_CFG_11,
+			     CLK_CFG_11_SET, CLK_CFG_11_CLR, 8, 1, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_AUD_2_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VENC_SEL, venc_parents, CLK_CFG_11,
+			     CLK_CFG_11_SET, CLK_CFG_11_CLR, 16, 4, 23,
+			     CLK_CFG_UPDATE1, TOP_MUX_VENC_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC_SEL, vdec_parents, CLK_CFG_11,
+			     CLK_CFG_11_SET, CLK_CFG_11_CLR, 24, 4, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_VDEC_SHIFT),
+	/* CLK_CFG_12 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, pwm_parents, CLK_CFG_12,
+			     CLK_CFG_12_SET, CLK_CFG_12_CLR, 0, 1, 7,
+			     CLK_CFG_UPDATE1, TOP_MUX_PWM_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_H_SEL, audio_h_parents, CLK_CFG_12,
+			     CLK_CFG_12_SET, CLK_CFG_12_CLR, 8, 2, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_AUDIO_H_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_MCUPM_SEL, mcupm_parents, CLK_CFG_12,
+			CLK_CFG_12_SET, CLK_CFG_12_CLR, 16, 2, CLK_CFG_UPDATE1,
+			TOP_MUX_MCUPM_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_SEL, mem_sub_parents, CLK_CFG_12,
+			CLK_CFG_12_SET, CLK_CFG_12_CLR, 24, 4, CLK_CFG_UPDATE1,
+			TOP_MUX_MEM_SUB_SHIFT),
+	/* CLK_CFG_13 */
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_PERI_SEL, mem_sub_peri_parents, CLK_CFG_13,
+			CLK_CFG_13_SET, CLK_CFG_13_CLR, 0, 3, CLK_CFG_UPDATE1,
+			TOP_MUX_MEM_SUB_PERI_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_MEM_SUB_U_SEL, mem_sub_u_parents, CLK_CFG_13,
+			CLK_CFG_13_SET, CLK_CFG_13_CLR, 8, 3, CLK_CFG_UPDATE1,
+			TOP_MUX_MEM_SUB_UFS_SHIFT),
+	MUX_CLR_SET_UPD(CLK_TOP_EMI_N_SEL, emi_n_parents, CLK_CFG_13,
+			CLK_CFG_13_SET, CLK_CFG_13_CLR, 16, 3, CLK_CFG_UPDATE1,
+			TOP_MUX_EMI_N_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC_SEL, dsi_occ_parents, CLK_CFG_13,
+			     CLK_CFG_13_SET, CLK_CFG_13_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_DSI_OCC_SHIFT),
+	/* CLK_CFG_14 */
+	MUX_CLR_SET_UPD(CLK_TOP_AP2CONN_HOST_SEL, ap2conn_host_parents, CLK_CFG_14,
+			CLK_CFG_14_SET, CLK_CFG_14_CLR, 0, 1, CLK_CFG_UPDATE1,
+			TOP_MUX_AP2CONN_HOST_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG1_SEL, img1_parents, CLK_CFG_14,
+			     CLK_CFG_14_SET, CLK_CFG_14_CLR, 8, 4, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_IMG1_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPE_SEL, ipe_parents, CLK_CFG_14,
+			     CLK_CFG_14_SET, CLK_CFG_14_CLR, 16, 4, 23,
+			     CLK_CFG_UPDATE1, TOP_MUX_IPE_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAM_SEL, cam_parents, CLK_CFG_14,
+			     CLK_CFG_14_SET, CLK_CFG_14_CLR, 24, 4, 31,
+			     CLK_CFG_UPDATE1, TOP_MUX_CAM_SHIFT),
+	/* CLK_CFG_15 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM_SEL, camtm_parents, CLK_CFG_15,
+			     CLK_CFG_15_SET, CLK_CFG_15_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE1, TOP_MUX_CAMTM_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP_SEL, dsp_parents, CLK_CFG_15,
+			     CLK_CFG_15_SET, CLK_CFG_15_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE1, TOP_MUX_DSP_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SR_PKA_SEL, sr_pka_parents, CLK_CFG_15,
+			     CLK_CFG_15_SET, CLK_CFG_15_CLR, 16, 3, 23,
+			     CLK_CFG_UPDATE2, TOP_MUX_SR_PKA_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC_SEL, dxcc_parents, CLK_CFG_15,
+			     CLK_CFG_15_SET, CLK_CFG_15_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE2, TOP_MUX_DXCC_SHIFT),
+	/* CLK_CFG_16 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG_REF_SEL, mfg_ref_parents, CLK_CFG_16,
+			     CLK_CFG_16_SET, CLK_CFG_16_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE2, TOP_MUX_MFG_REF_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MDP0_SEL, mdp0_parents, CLK_CFG_16,
+			     CLK_CFG_16_SET, CLK_CFG_16_CLR, 8, 4, 15,
+			     CLK_CFG_UPDATE2, TOP_MUX_MDP0_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP_SEL, dp_parents, CLK_CFG_16,
+			     CLK_CFG_16_SET, CLK_CFG_16_CLR, 16, 3, 23,
+			     CLK_CFG_UPDATE2, TOP_MUX_DP_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP_SEL, edp_parents, CLK_CFG_16,
+			     CLK_CFG_16_SET, CLK_CFG_16_CLR, 24, 3, 31,
+			     CLK_CFG_UPDATE2, TOP_MUX_EDP_SHIFT),
+	/* CLK_CFG_17 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP_FAVT_SEL, edp_favt_parents, CLK_CFG_17,
+			     CLK_CFG_17_SET, CLK_CFG_17_CLR, 0, 3, 7,
+			     CLK_CFG_UPDATE2, TOP_MUX_EDP_FAVT_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_250M_SEL, snps_eth_250m_parents, CLK_CFG_17,
+			     CLK_CFG_17_SET, CLK_CFG_17_CLR, 8, 1, 15,
+			     CLK_CFG_UPDATE2, TOP_MUX_SNPS_ETH_250M_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_62P4M_PTP_SEL,
+			     snps_eth_62p4m_ptp_parents, CLK_CFG_17,
+			     CLK_CFG_17_SET, CLK_CFG_17_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE2, TOP_MUX_SNPS_ETH_62P4M_PTP_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ETH_50M_RMII_SEL,
+			     snps_eth_50m_rmii_parents, CLK_CFG_17,
+			     CLK_CFG_17_SET, CLK_CFG_17_CLR, 24, 1, 31,
+			     CLK_CFG_UPDATE2, TOP_MUX_SNPS_ETH_50M_RMII_SHIFT),
+	/* CLK_CFG_18 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SFLASH_SEL, sflash_parents, CLK_CFG_18,
+			     CLK_CFG_18_SET, CLK_CFG_18_CLR, 0, 3, 7,
+			     CLK_CFG_UPDATE2, TOP_MUX_SFLASH_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_GCPU_SEL, gcpu_parents, CLK_CFG_18,
+			     CLK_CFG_18_SET, CLK_CFG_18_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE2, TOP_MUX_GCPU_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MAC_TL_SEL, pcie_mac_tl_parents, CLK_CFG_18,
+			     CLK_CFG_18_SET, CLK_CFG_18_CLR, 16, 2, 23,
+			     CLK_CFG_UPDATE2, TOP_MUX_PCIE_MAC_TL_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDSTX_DG_CTS_SEL, vdstx_dg_cts_parents, CLK_CFG_18,
+			     CLK_CFG_18_SET, CLK_CFG_18_CLR, 24, 2, 31,
+			     CLK_CFG_UPDATE2, TOP_MUX_VDSTX_CLKDIG_CTS_SHIFT),
+	/* CLK_CFG_19 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PLL_DPIX_SEL, pll_dpix_parents, CLK_CFG_19,
+			     CLK_CFG_19_SET, CLK_CFG_19_CLR, 0, 2, 7,
+			     CLK_CFG_UPDATE2, TOP_MUX_PLL_DPIX_SHIFT),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ECC_SEL, ecc_parents, CLK_CFG_19,
+			     CLK_CFG_19_SET, CLK_CFG_19_CLR, 8, 3, 15,
+			     CLK_CFG_UPDATE2, TOP_MUX_ECC_SHIFT),
+};
+
+static const struct mtk_gate_regs top_cg_regs = {
+	.set_ofs = 0x514,
+	.clr_ofs = 0x518,
+	.sta_ofs = 0x510,
+};
+
+#define GATE_TOP(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &top_cg_regs, _shift, \
+		   CLK_GATE_NO_SETCLR_INV | CLK_PARENT_EXT)
+
+static const struct mtk_gate top_gates[] = {
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P0_EN, CLK_PAD_CLK26M, 7),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P1_EN, CLK_PAD_CLK26M, 10),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P2_EN, CLK_PAD_CLK26M, 11),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P3_EN, CLK_PAD_CLK26M, 12),
+	GATE_TOP(CLK_TOP_USB2_PHY_RF_P4_EN, CLK_PAD_CLK26M, 13),
+};
+
+static const struct mtk_gate_regs perao0_cg_regs = {
+	.set_ofs = 0x24,
+	.clr_ofs = 0x28,
+	.sta_ofs = 0x10,
+};
+
+static const struct mtk_gate_regs perao1_cg_regs = {
+	.set_ofs = 0x2C,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x14,
+};
+
+static const struct mtk_gate_regs perao2_cg_regs = {
+	.set_ofs = 0x34,
+	.clr_ofs = 0x38,
+	.sta_ofs = 0x18,
+};
+
+#define GATE_PERAO0(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &perao0_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_PERAO0P(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &perao0_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_EXT)
+
+#define GATE_PERAO1(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &perao1_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_PERAO1P(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &perao1_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_EXT)
+
+#define GATE_PERAO2(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &perao2_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_PERAO2P(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &perao2_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_EXT)
+
+static const struct mtk_gate perao_clks[] = {
+	/* PERAO0 */
+	GATE_PERAO0(CLK_PERAO_UART0, CLK_TOP_UART_SEL, 0),
+	GATE_PERAO0(CLK_PERAO_UART1, CLK_TOP_UART_SEL, 1),
+	GATE_PERAO0(CLK_PERAO_UART2, CLK_TOP_UART_SEL, 2),
+	GATE_PERAO0(CLK_PERAO_UART3, CLK_TOP_UART_SEL, 3),
+	GATE_PERAO0(CLK_PERAO_PWM_H, CLK_TOP_AXI_PERI_SEL, 4),
+	GATE_PERAO0(CLK_PERAO_PWM_B, CLK_TOP_PWM_SEL, 5),
+	GATE_PERAO0(CLK_PERAO_PWM_FB1, CLK_TOP_PWM_SEL, 6),
+	GATE_PERAO0(CLK_PERAO_PWM_FB2, CLK_TOP_PWM_SEL, 7),
+	GATE_PERAO0(CLK_PERAO_PWM_FB3, CLK_TOP_PWM_SEL, 8),
+	GATE_PERAO0(CLK_PERAO_PWM_FB4, CLK_TOP_PWM_SEL, 9),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM0, CLK_TOP_DISP_PWM_SEL, 10),
+	GATE_PERAO0(CLK_PERAO_DISP_PWM1, CLK_TOP_DISP_PWM_SEL, 11),
+	GATE_PERAO0(CLK_PERAO_SPI0_B, CLK_TOP_SPI0_SEL, 12),
+	GATE_PERAO0(CLK_PERAO_SPI1_B, CLK_TOP_SPI1_SEL, 13),
+	GATE_PERAO0(CLK_PERAO_SPI2_B, CLK_TOP_SPI2_SEL, 14),
+	GATE_PERAO0(CLK_PERAO_SPI3_B, CLK_TOP_SPI3_SEL, 15),
+	GATE_PERAO0(CLK_PERAO_SPI4_B, CLK_TOP_SPI4_SEL, 16),
+	GATE_PERAO0(CLK_PERAO_SPI5_B, CLK_TOP_SPI5_SEL, 17),
+	GATE_PERAO0(CLK_PERAO_SPI0_H, CLK_TOP_AXI_PERI_SEL, 18),
+	GATE_PERAO0(CLK_PERAO_SPI1_H, CLK_TOP_AXI_PERI_SEL, 19),
+	GATE_PERAO0(CLK_PERAO_SPI2_H, CLK_TOP_AXI_PERI_SEL, 20),
+	GATE_PERAO0(CLK_PERAO_SPI3_H, CLK_TOP_AXI_PERI_SEL, 21),
+	GATE_PERAO0(CLK_PERAO_SPI4_H, CLK_TOP_AXI_PERI_SEL, 22),
+	GATE_PERAO0(CLK_PERAO_SPI5_H, CLK_TOP_AXI_PERI_SEL, 23),
+	GATE_PERAO0(CLK_PERAO_AXI, CLK_TOP_MEM_SUB_PERI_SEL, 24),
+	GATE_PERAO0(CLK_PERAO_AHB_APB, CLK_TOP_AXI_PERI_SEL, 25),
+	GATE_PERAO0(CLK_PERAO_TL, CLK_TOP_MAC_TL_SEL, 26),
+	GATE_PERAO0P(CLK_PERAO_REF, CLK_PAD_CLK26M, 27),
+	GATE_PERAO0(CLK_PERAO_I2C, CLK_TOP_AXI_PERI_SEL, 28),
+	GATE_PERAO0(CLK_PERAO_DMA_B, CLK_TOP_AXI_PERI_SEL, 29),
+	/* PERAO1 */
+	GATE_PERAO1P(CLK_PERAO_SSUSB0_REF, CLK_PAD_CLK26M, 1),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_FRMCNT, CLK_TOP_UNIVPLL_192M_D4, 2),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_SYS, CLK_TOP_USB_TOP_P0_SEL, 4),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_XHCI, CLK_TOP_USB_XHCI_P0_SEL, 5),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_F, CLK_TOP_AXI_PERI_SEL, 6),
+	GATE_PERAO1(CLK_PERAO_SSUSB0_H, CLK_TOP_AXI_PERI_SEL, 7),
+	GATE_PERAO1P(CLK_PERAO_SSUSB1_REF, CLK_PAD_CLK26M, 8),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_FRMCNT, CLK_TOP_UNIVPLL_192M_D4, 9),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_SYS, CLK_TOP_USB_TOP_P1_SEL, 11),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_XHCI, CLK_TOP_USB_XHCI_P1_SEL, 12),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_F, CLK_TOP_AXI_PERI_SEL, 13),
+	GATE_PERAO1(CLK_PERAO_SSUSB1_H, CLK_TOP_AXI_PERI_SEL, 14),
+	GATE_PERAO1P(CLK_PERAO_SSUSB2_REF, CLK_PAD_CLK26M, 15),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_FRMCNT, CLK_TOP_UNIVPLL_192M_D4, 16),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_SYS, CLK_TOP_USB_TOP_P2_SEL, 18),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_XHCI, CLK_TOP_USB_XHCI_P2_SEL, 19),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_F, CLK_TOP_AXI_PERI_SEL, 20),
+	GATE_PERAO1(CLK_PERAO_SSUSB2_H, CLK_TOP_AXI_PERI_SEL, 21),
+	GATE_PERAO1P(CLK_PERAO_SSUSB3_REF, CLK_PAD_CLK26M, 23),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_FRMCNT, CLK_TOP_UNIVPLL_192M_D4, 24),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_SYS, CLK_TOP_USB_TOP_P3_SEL, 26),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_XHCI, CLK_TOP_USB_XHCI_P3_SEL, 27),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_F, CLK_TOP_AXI_PERI_SEL, 28),
+	GATE_PERAO1(CLK_PERAO_SSUSB3_H, CLK_TOP_AXI_PERI_SEL, 29),
+	/* PERAO2 */
+	GATE_PERAO2P(CLK_PERAO_SSUSB4_REF, CLK_PAD_CLK26M, 0),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_FRMCNT, CLK_TOP_UNIVPLL_192M_D4, 1),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_SYS, CLK_TOP_USB_TOP_P4_SEL, 3),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_XHCI, CLK_TOP_USB_XHCI_P4_SEL, 4),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_F, CLK_TOP_AXI_PERI_SEL, 5),
+	GATE_PERAO2(CLK_PERAO_SSUSB4_H, CLK_TOP_AXI_PERI_SEL, 6),
+	GATE_PERAO2(CLK_PERAO_MSDC0, CLK_TOP_MSDC50_0_SEL, 7),
+	GATE_PERAO2(CLK_PERAO_MSDC0_H, CLK_TOP_MSDC50_0_HCLK_SEL, 8),
+	GATE_PERAO2(CLK_PERAO_MSDC0_FAES, CLK_TOP_AES_MSDCFDE_SEL, 9),
+	GATE_PERAO2(CLK_PERAO_MSDC0_MST_F, CLK_TOP_AXI_PERI_SEL, 10),
+	GATE_PERAO2(CLK_PERAO_MSDC0_SLV_H, CLK_TOP_AXI_PERI_SEL, 11),
+	GATE_PERAO2(CLK_PERAO_MSDC1, CLK_TOP_MSDC30_1_SEL, 12),
+	GATE_PERAO2(CLK_PERAO_MSDC1_H, CLK_TOP_MSDC30_1_HCLK_SEL, 13),
+	GATE_PERAO2(CLK_PERAO_MSDC1_MST_F, CLK_TOP_AXI_PERI_SEL, 14),
+	GATE_PERAO2(CLK_PERAO_MSDC1_SLV_H, CLK_TOP_AXI_PERI_SEL, 15),
+	GATE_PERAO2(CLK_PERAO_MSDC2, CLK_TOP_MSDC30_2_SEL, 16),
+	GATE_PERAO2(CLK_PERAO_MSDC2_H, CLK_TOP_MSDC30_2_HCLK_SEL, 17),
+	GATE_PERAO2(CLK_PERAO_MSDC2_MST_F, CLK_TOP_AXI_PERI_SEL, 18),
+	GATE_PERAO2(CLK_PERAO_MSDC2_SLV_H, CLK_TOP_AXI_PERI_SEL, 19),
+	GATE_PERAO2(CLK_PERAO_SFLASH, CLK_TOP_SFLASH_SEL, 20),
+	GATE_PERAO2(CLK_PERAO_SFLASH_F, CLK_TOP_AXI_PERI_SEL, 21),
+	GATE_PERAO2(CLK_PERAO_SFLASH_H, CLK_TOP_AXI_PERI_SEL, 22),
+	GATE_PERAO2(CLK_PERAO_SFLASH_P, CLK_TOP_AXI_PERI_SEL, 23),
+	GATE_PERAO2(CLK_PERAO_AUDIO0, CLK_TOP_AXI_PERI_SEL, 24),
+	GATE_PERAO2(CLK_PERAO_AUDIO1, CLK_TOP_AXI_PERI_SEL, 25),
+	GATE_PERAO2(CLK_PERAO_AUDIO2, CLK_TOP_AUD_INTBUS_SEL, 26),
+	GATE_PERAO2P(CLK_PERAO_AUXADC_26M, CLK_PAD_CLK26M, 27),
+};
+
+static const struct mtk_gate_regs imp_cg_regs = {
+	.set_ofs = 0xE08,
+	.clr_ofs = 0xE04,
+	.sta_ofs = 0xE00,
+};
+
+#define GATE_IMP(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &imp_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_gate imp_clks[] = {
+	GATE_IMP(CLK_IMPE_I2C0, CLK_TOP_I2C_SEL, 0),
+	GATE_IMP(CLK_IMPE_I2C1, CLK_TOP_I2C_SEL, 1),
+	GATE_IMP(CLK_IMPWS_I2C2, CLK_TOP_I2C_SEL, 0),
+	GATE_IMP(CLK_IMPS_I2C3, CLK_TOP_I2C_SEL, 0),
+	GATE_IMP(CLK_IMPS_I2C4, CLK_TOP_I2C_SEL, 1),
+	GATE_IMP(CLK_IMPS_I2C5, CLK_TOP_I2C_SEL, 2),
+	GATE_IMP(CLK_IMPS_I2C6, CLK_TOP_I2C_SEL, 3),
+	GATE_IMP(CLK_IMPEN_I2C7, CLK_TOP_I2C_SEL, 0),
+	GATE_IMP(CLK_IMPEN_I2C8, CLK_TOP_I2C_SEL, 1),
+};
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MM0(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &mm0_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_MM1(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &mm1_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_DISP_OVL0_4L, CLK_TOP_DISP0_SEL, 0),
+	GATE_MM0(CLK_MM_DISP_OVL1_4L, CLK_TOP_DISP0_SEL, 1),
+	GATE_MM0(CLK_MM_VPP_RSZ0, CLK_TOP_DISP0_SEL, 2),
+	GATE_MM0(CLK_MM_VPP_RSZ1, CLK_TOP_DISP0_SEL, 3),
+	GATE_MM0(CLK_MM_DISP_RDMA0, CLK_TOP_DISP0_SEL, 4),
+	GATE_MM0(CLK_MM_DISP_RDMA1, CLK_TOP_DISP0_SEL, 5),
+	GATE_MM0(CLK_MM_DISP_COLOR0, CLK_TOP_DISP0_SEL, 6),
+	GATE_MM0(CLK_MM_DISP_COLOR1, CLK_TOP_DISP0_SEL, 7),
+	GATE_MM0(CLK_MM_DISP_CCORR0, CLK_TOP_DISP0_SEL, 8),
+	GATE_MM0(CLK_MM_DISP_CCORR1, CLK_TOP_DISP0_SEL, 9),
+	GATE_MM0(CLK_MM_DISP_CCORR2, CLK_TOP_DISP0_SEL, 10),
+	GATE_MM0(CLK_MM_DISP_CCORR3, CLK_TOP_DISP0_SEL, 11),
+	GATE_MM0(CLK_MM_DISP_AAL0, CLK_TOP_DISP0_SEL, 12),
+	GATE_MM0(CLK_MM_DISP_AAL1, CLK_TOP_DISP0_SEL, 13),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, CLK_TOP_DISP0_SEL, 14),
+	GATE_MM0(CLK_MM_DISP_GAMMA1, CLK_TOP_DISP0_SEL, 15),
+	GATE_MM0(CLK_MM_DISP_DITHER0, CLK_TOP_DISP0_SEL, 16),
+	GATE_MM0(CLK_MM_DISP_DITHER1, CLK_TOP_DISP0_SEL, 17),
+	GATE_MM0(CLK_MM_DISP_DSC_WRAP0, CLK_TOP_DISP0_SEL, 18),
+	GATE_MM0(CLK_MM_VPP_MERGE0, CLK_TOP_DISP0_SEL, 19),
+	GATE_MM0(CLK_MMSYS_0_DISP_DVO, CLK_TOP_DISP0_SEL, 20),
+	GATE_MM0(CLK_MMSYS_0_DISP_DSI0, CLK_TOP_DISP0_SEL, 21),
+	GATE_MM0(CLK_MM_DP_INTF0, CLK_TOP_DISP0_SEL, 22),
+	GATE_MM0(CLK_MM_DPI0, CLK_TOP_DISP0_SEL, 23),
+	GATE_MM0(CLK_MM_DISP_WDMA0, CLK_TOP_DISP0_SEL, 24),
+	GATE_MM0(CLK_MM_DISP_WDMA1, CLK_TOP_DISP0_SEL, 25),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG0, CLK_TOP_DISP0_SEL, 26),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG1, CLK_TOP_DISP0_SEL, 27),
+	GATE_MM0(CLK_MM_SMI_LARB, CLK_TOP_DISP0_SEL, 28),
+	GATE_MM0(CLK_MM_DISP_MUTEX0, CLK_TOP_DISP0_SEL, 29),
+	GATE_MM0(CLK_MM_DIPSYS_CONFIG, CLK_TOP_DISP0_SEL, 30),
+	GATE_MM0(CLK_MM_DUMMY, CLK_TOP_DISP0_SEL, 31),
+	/* MM1 */
+	GATE_MM1(CLK_MMSYS_1_DISP_DSI0, CLK_TOP_DSI_OCC_SEL, 0),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER, CLK_TOP_PLL_DPIX_SEL, 1),
+	GATE_MM1(CLK_MMSYS_1_DPI0, CLK_TOP_PLL_DPIX_SEL, 2),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO, CLK_TOP_EDP_SEL, 3),
+	GATE_MM1(CLK_MM_DP_INTF, CLK_TOP_DP_SEL, 4),
+	GATE_MM1(CLK_MMSYS_1_LVDS_ENCODER_CTS, CLK_TOP_VDSTX_DG_CTS_SEL, 5),
+	GATE_MM1(CLK_MMSYS_1_DISP_DVO_AVT, CLK_TOP_EDP_FAVT_SEL, 6),
+};
+
+static const struct mtk_gate_regs mminfra_config0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mminfra_config1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MMINFRA_CONFIG0(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &mminfra_config0_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+#define GATE_MMINFRA_CONFIG1(_id, _parent, _shift) \
+	GATE_FLAGS(_id, _parent, &mminfra_config1_cg_regs, _shift, \
+		   CLK_GATE_SETCLR | CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_gate mminfra_config_clks[] = {
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_D, CLK_TOP_MMINFRA_SEL, 0),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_GCE_M, CLK_TOP_MMINFRA_SEL, 1),
+	GATE_MMINFRA_CONFIG0(CLK_MMINFRA_SMI, CLK_TOP_MMINFRA_SEL, 2),
+	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, CLK_TOP_MMINFRA_SEL, 17),
+};
+
+static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree = {
+	.xtal_rate = 26 * MHZ,
+	.xtal2_rate = 26 * MHZ,
+	.ext_clk_rates = pad_clks,
+	.num_ext_clks = ARRAY_SIZE(pad_clks),
+	.plls = apmixed_plls,
+	.num_plls = ARRAY_SIZE(apmixed_plls),
+};
+
+static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
+	.xtal_rate = 26 * MHZ,
+	.ext_clk_rates = pad_clks,
+	.num_ext_clks = ARRAY_SIZE(pad_clks),
+	.fdivs_offs = CLK_TOP_MAINPLL_D3,
+	.muxes_offs = CLK_TOP_AXI_SEL,
+	.gates_offs = CLK_TOP_USB2_PHY_RF_P0_EN,
+	.fdivs = top_fixed_divs,
+	.muxes = top_muxes,
+	.gates = top_gates,
+	.num_fdivs = ARRAY_SIZE(top_fixed_divs),
+	.num_muxes = ARRAY_SIZE(top_muxes),
+	.num_gates = ARRAY_SIZE(top_gates),
+};
+
+static const struct udevice_id mt8189_apmixed[] = {
+	{ .compatible = "mediatek,mt8189-apmixedsys", },
+	{ }
+};
+
+static const struct udevice_id mt8189_topckgen_compat[] = {
+	{ .compatible = "mediatek,mt8189-topckgen", },
+	{ }
+};
+
+struct mt8189_gate_clk_data {
+	const struct mtk_gate *gates;
+	int num_gates;
+};
+
+#define GATE_CLK_DATA(name) \
+static const struct mt8189_gate_clk_data name##_data = { \
+	.gates = name, .num_gates = ARRAY_SIZE(name) \
+}
+
+GATE_CLK_DATA(perao_clks);
+GATE_CLK_DATA(imp_clks);
+GATE_CLK_DATA(mm_clks);
+GATE_CLK_DATA(mminfra_config_clks);
+
+static const struct udevice_id of_match_mt8189_clk_gate[] = {
+	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_data },
+	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_data },
+	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_data },
+	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_data },
+	{ }
+};
+
+static int mt8189_apmixedsys_probe(struct udevice *dev)
+{
+	return mtk_common_clk_init(dev, &mt8189_apmixedsys_clk_tree);
+}
+
+static int mt8189_topckgen_probe(struct udevice *dev)
+{
+	return mtk_common_clk_init(dev, &mt8189_topckgen_clk_tree);
+}
+
+static int mt8189_clk_gate_probe(struct udevice *dev)
+{
+	struct mt8189_gate_clk_data *data;
+
+	data = (void *)dev_get_driver_data(dev);
+
+	return mtk_common_clk_gate_init(dev, &mt8189_topckgen_clk_tree,
+					data->gates, data->num_gates,
+					data->gates[0].id);
+}
+
+U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+	.name = "mt8189-apmixedsys",
+	.id = UCLASS_CLK,
+	.of_match = mt8189_apmixed,
+	.probe = mt8189_apmixedsys_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_apmixedsys_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRIVER(mtk_clk_topckgen) = {
+	.name = "mt8189-topckgen",
+	.id = UCLASS_CLK,
+	.of_match = mt8189_topckgen_compat,
+	.probe = mt8189_topckgen_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_topckgen_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRIVER(mtk_clk_gate) = {
+	.name = "mt8189-gate-clk",
+	.id = UCLASS_CLK,
+	.of_match = of_match_mt8189_clk_gate,
+	.probe = mt8189_clk_gate_probe,
+	.priv_auto = sizeof(struct mtk_cg_priv),
+	.ops = &mtk_clk_gate_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.43.0

