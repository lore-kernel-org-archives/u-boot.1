Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA398ECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246A583BF1;
	Thu,  5 Feb 2026 23:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hslERtF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEAF83AA9; Thu,  5 Feb 2026 22:13:45 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4416B838FA
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 22:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d1890f7cefso1245529a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770326021; x=1770930821;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2BM0W8mItPmFitDoBYsOdVUmt06yKFbbFzl1RzttYmI=;
 b=hslERtF7TkgijCVv2GeF6xPHqHVxraGMc/5jpEo1v3pwDJ5E3s/4r+m0+ZcBDYjtNb
 4ROYNndAn76lwEoVpy14SPaZblwvBwcxJ1+w7UrcFpd5uGUch4Fr8ReVFVkxxs3r1CNi
 tAjJH6qgmg7gQCeQ8OuMbTxJWrm370EEJYgVeqLJG1MW+2MwLkGG6+D0WCNZKGOHxyc6
 30uLcB3fmo3oxz3xcUoUSdr1JhOc+EZCZj03htM6ny9+fSsp7wfoP0LW0C1dFQj09sSJ
 aczCoQutybl1JhNFcBaREUt0HhC4qF0sjlrbM9KmrZUbUiNrzhER42sOnR8ZMVF1Iv3G
 srug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770326021; x=1770930821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2BM0W8mItPmFitDoBYsOdVUmt06yKFbbFzl1RzttYmI=;
 b=wuGzDEq0sDraxo9A8g+W6Aooy/eYjuFJO8NftkSfKlxuu09QuDvHNHBJDn7YBykBp9
 E5qCpSuAZTqIEFNC13I9pNPaioPGdhZZhsGYcNpbXS5EyuyZjodAlaSyKMl+eYPJBJqb
 biO/bmMBtCLygXeV2dHsGhzlfpyD8C6QdF4ci3Ji5DUNrXflX6hwtIm+MLiH5JD6jlzV
 04Qqn5/2hxME22MSB/pvwYiHJceWUOMIPie1COG+MkteqzXeL70Pga63suXJaDUUmgdW
 M8xe3dpJ3chsBMSkjMTUIy+t0xRzFmJNYtiIx2tMZ5cVP0n+Ep1NJtckHO91/WIM3aRd
 enJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5aQQhfiFHOxQ0H5RghvTYIl5V83r4HYRGsVUmDtNgm0Xvw55fXQ+sw7RLTn1AnhkKAavVQgY=@lists.denx.de
X-Gm-Message-State: AOJu0YyB6STK5YlmgKsyc+FOagYjfzRfHakVbQaQNyjJRx38Qw10qG63
 YfY9yVNw2dzQYyxTFg5DVm0nvSoaZ/VJIHtJ9fNpMTivUGOqVuuwtwkOzKmxyT0dXRU=
X-Gm-Gg: AZuq6aJcSafKOO4jF8DzD5FYpxcm8LmQstPmuRxamMMiY5XDKosihMByX/1QlKHN5Im
 0RAZ67HNqNJbgdnASLYeexANlJfFPrZYKYEylWseyu6KAVTSvgLu/jPQZ9ULoqGtAYPVHpbFJo2
 bPmYLAWMt2D8Pl0qf9IzCXZB03tGb4sCf6WsF6n8KK5GJur7A4peytIvHEzd0lbIUINiPUkx75E
 VDPj871xWkIkA81m2pFTq6dRwTSSbntjNlEhV7pvRgh9EZp1/U8riJcNuNjs+7IXMaAbCMQyc1I
 zDng13i4E5/x7xr4BUof9WF/WBPG/hpZ/485FhbkXBts8G2WaXnIUDDwnd1nI3Mb+v1IH2WdnRS
 Qfyqkb+Z+BPW/pQ7y+XgYNk9DFmx8aZNV9zCZKzbI73iqhkPXTNJALT7NyXKiPFZNMWh1NMPnYk
 i4Uv4YvWanGZJ7O2E=
X-Received: by 2002:a05:6830:83a5:b0:7cf:da7d:6080 with SMTP id
 46e09a7af769-7d464694cd3mr192527a34.32.1770326020947; 
 Thu, 05 Feb 2026 13:13:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4487:26aa:aa87:6ade])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647ab1cesm164313a34.31.2026.02.05.13.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:13:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Feb 2026 15:12:41 -0600
Subject: [PATCH 6/7] dt-bindings: clock: Add MediaTek MT8189 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mtk-mt8189-clocks-v1-6-bbac40932c2a@baylibre.com>
References: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
In-Reply-To: <20260205-mtk-mt8189-clocks-v1-0-bbac40932c2a@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20441;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=6BABYHEafBb2XRqLAdxy+JSeo3hnEr7xg8unMhZRfzM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphQfyDN94exsMQyt1kGmC1McN/52OYsGoYYw3x
 0frX4uJgNCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYUH8hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEZkH/AlvSXO4gOPWdQk9cAGnzXdgJNtb3lkzuIijbG2
 47M3k7RHLSgWez/dSuWMzfct9/hNPPogvJ/oFowFRhF49YOa2+6/LOvIE0gJb6CR1zXAVm822Rz
 4zv1zDSZg42Qd7FG04iFRgwMQAghICu8WQpeiDIMoGQwauB8fWpH+tQv/CR1T7/YUaQIeg9DHaW
 MJ9iAu/vmzxiP5HhPeGSRKEHODhuKIl4MM1UVd4OzREJ0DBlGWHavjKnc3V59cwfwB2LPkwcJBg
 ebwFTY1IOuIfwz+oaCnn9sZSxRMnBnudruqGFBebEMhWW+ZWwed4BVaMBPSER2jFzG1N0+ihMcV
 tjdE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:06:53 +0100
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

From: Irving-CH Lin <irving-ch.lin@mediatek.com>

Add IDs for the clocks of MediaTek MT8189 SoC.

Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

This is just the header file portion of [1] which has been submitted
upstream to the Linux project but is still under review. The intention
is to eventually to switch to CONFIG_OF_UPSTREAM and remove this file
from U-Boot once it is accepted in Linux and gets merged into U-Boot.
This can take a long time and we would like to have it in U-Boot sooner
even if there will be some churn.

[1] https://lore.kernel.org/linux-mediatek/20260202062840.342707-2-irving-ch.lin@mediatek.com/
---
 include/dt-bindings/clock/mediatek,mt8189-clk.h | 580 ++++++++++++++++++++++++
 1 file changed, 580 insertions(+)

diff --git a/include/dt-bindings/clock/mediatek,mt8189-clk.h b/include/dt-bindings/clock/mediatek,mt8189-clk.h
new file mode 100644
index 00000000000..ffbc1814f28
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt8189-clk.h
@@ -0,0 +1,580 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)  */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Qiqi Wang <qiqi.wang@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8189_H
+#define _DT_BINDINGS_CLK_MT8189_H
+
+/* TOPCKGEN */
+#define CLK_TOP_AXI_SEL					0
+#define CLK_TOP_AXI_PERI_SEL				1
+#define CLK_TOP_AXI_U_SEL				2
+#define CLK_TOP_BUS_AXIMEM_SEL				3
+#define CLK_TOP_DISP0_SEL				4
+#define CLK_TOP_MMINFRA_SEL				5
+#define CLK_TOP_UART_SEL				6
+#define CLK_TOP_SPI0_SEL				7
+#define CLK_TOP_SPI1_SEL				8
+#define CLK_TOP_SPI2_SEL				9
+#define CLK_TOP_SPI3_SEL				10
+#define CLK_TOP_SPI4_SEL				11
+#define CLK_TOP_SPI5_SEL				12
+#define CLK_TOP_MSDC_MACRO_0P_SEL			13
+#define CLK_TOP_MSDC50_0_HCLK_SEL			14
+#define CLK_TOP_MSDC50_0_SEL				15
+#define CLK_TOP_AES_MSDCFDE_SEL				16
+#define CLK_TOP_MSDC_MACRO_1P_SEL			17
+#define CLK_TOP_MSDC30_1_SEL				18
+#define CLK_TOP_MSDC30_1_HCLK_SEL			19
+#define CLK_TOP_MSDC_MACRO_2P_SEL			20
+#define CLK_TOP_MSDC30_2_SEL				21
+#define CLK_TOP_MSDC30_2_HCLK_SEL			22
+#define CLK_TOP_AUD_INTBUS_SEL				23
+#define CLK_TOP_ATB_SEL					24
+#define CLK_TOP_DISP_PWM_SEL				25
+#define CLK_TOP_USB_TOP_P0_SEL				26
+#define CLK_TOP_USB_XHCI_P0_SEL				27
+#define CLK_TOP_USB_TOP_P1_SEL				28
+#define CLK_TOP_USB_XHCI_P1_SEL				29
+#define CLK_TOP_USB_TOP_P2_SEL				30
+#define CLK_TOP_USB_XHCI_P2_SEL				31
+#define CLK_TOP_USB_TOP_P3_SEL				32
+#define CLK_TOP_USB_XHCI_P3_SEL				33
+#define CLK_TOP_USB_TOP_P4_SEL				34
+#define CLK_TOP_USB_XHCI_P4_SEL				35
+#define CLK_TOP_I2C_SEL					36
+#define CLK_TOP_SENINF_SEL				37
+#define CLK_TOP_SENINF1_SEL				38
+#define CLK_TOP_AUD_ENGEN1_SEL				39
+#define CLK_TOP_AUD_ENGEN2_SEL				40
+#define CLK_TOP_AES_UFSFDE_SEL				41
+#define CLK_TOP_U_SEL					42
+#define CLK_TOP_U_MBIST_SEL				43
+#define CLK_TOP_AUD_1_SEL				44
+#define CLK_TOP_AUD_2_SEL				45
+#define CLK_TOP_VENC_SEL				46
+#define CLK_TOP_VDEC_SEL				47
+#define CLK_TOP_PWM_SEL					48
+#define CLK_TOP_AUDIO_H_SEL				49
+#define CLK_TOP_MCUPM_SEL				50
+#define CLK_TOP_MEM_SUB_SEL				51
+#define CLK_TOP_MEM_SUB_PERI_SEL			52
+#define CLK_TOP_MEM_SUB_U_SEL				53
+#define CLK_TOP_EMI_N_SEL				54
+#define CLK_TOP_DSI_OCC_SEL				55
+#define CLK_TOP_AP2CONN_HOST_SEL			56
+#define CLK_TOP_IMG1_SEL				57
+#define CLK_TOP_IPE_SEL					58
+#define CLK_TOP_CAM_SEL					59
+#define CLK_TOP_CAMTM_SEL				60
+#define CLK_TOP_DSP_SEL					61
+#define CLK_TOP_SR_PKA_SEL				62
+#define CLK_TOP_DXCC_SEL				63
+#define CLK_TOP_MFG_REF_SEL				64
+#define CLK_TOP_MDP0_SEL				65
+#define CLK_TOP_DP_SEL					66
+#define CLK_TOP_EDP_SEL					67
+#define CLK_TOP_EDP_FAVT_SEL				68
+#define CLK_TOP_ETH_250M_SEL				69
+#define CLK_TOP_ETH_62P4M_PTP_SEL			70
+#define CLK_TOP_ETH_50M_RMII_SEL			71
+#define CLK_TOP_SFLASH_SEL				72
+#define CLK_TOP_GCPU_SEL				73
+#define CLK_TOP_MAC_TL_SEL				74
+#define CLK_TOP_VDSTX_DG_CTS_SEL			75
+#define CLK_TOP_PLL_DPIX_SEL				76
+#define CLK_TOP_ECC_SEL					77
+#define CLK_TOP_APLL_I2SIN0_MCK_SEL			78
+#define CLK_TOP_APLL_I2SIN1_MCK_SEL			79
+#define CLK_TOP_APLL_I2SIN2_MCK_SEL			80
+#define CLK_TOP_APLL_I2SIN3_MCK_SEL			81
+#define CLK_TOP_APLL_I2SIN4_MCK_SEL			82
+#define CLK_TOP_APLL_I2SIN6_MCK_SEL			83
+#define CLK_TOP_APLL_I2SOUT0_MCK_SEL			84
+#define CLK_TOP_APLL_I2SOUT1_MCK_SEL			85
+#define CLK_TOP_APLL_I2SOUT2_MCK_SEL			86
+#define CLK_TOP_APLL_I2SOUT3_MCK_SEL			87
+#define CLK_TOP_APLL_I2SOUT4_MCK_SEL			88
+#define CLK_TOP_APLL_I2SOUT6_MCK_SEL			89
+#define CLK_TOP_APLL_FMI2S_MCK_SEL			90
+#define CLK_TOP_APLL_TDMOUT_MCK_SEL			91
+#define CLK_TOP_MFG_SEL_MFGPLL				92
+#define CLK_TOP_APLL12_CK_DIV_I2SIN0			93
+#define CLK_TOP_APLL12_CK_DIV_I2SIN1			94
+#define CLK_TOP_APLL12_CK_DIV_I2SOUT0			95
+#define CLK_TOP_APLL12_CK_DIV_I2SOUT1			96
+#define CLK_TOP_APLL12_CK_DIV_FMI2S			97
+#define CLK_TOP_APLL12_CK_DIV_TDMOUT_M			98
+#define CLK_TOP_APLL12_CK_DIV_TDMOUT_B			99
+#define CLK_TOP_MAINPLL_D3				100
+#define CLK_TOP_MAINPLL_D4				101
+#define CLK_TOP_MAINPLL_D4_D2				102
+#define CLK_TOP_MAINPLL_D4_D4				103
+#define CLK_TOP_MAINPLL_D4_D8				104
+#define CLK_TOP_MAINPLL_D5				105
+#define CLK_TOP_MAINPLL_D5_D2				106
+#define CLK_TOP_MAINPLL_D5_D4				107
+#define CLK_TOP_MAINPLL_D5_D8				108
+#define CLK_TOP_MAINPLL_D6				109
+#define CLK_TOP_MAINPLL_D6_D2				110
+#define CLK_TOP_MAINPLL_D6_D4				111
+#define CLK_TOP_MAINPLL_D6_D8				112
+#define CLK_TOP_MAINPLL_D7				113
+#define CLK_TOP_MAINPLL_D7_D2				114
+#define CLK_TOP_MAINPLL_D7_D4				115
+#define CLK_TOP_MAINPLL_D7_D8				116
+#define CLK_TOP_MAINPLL_D9				117
+#define CLK_TOP_UNIVPLL_D2				118
+#define CLK_TOP_UNIVPLL_D3				119
+#define CLK_TOP_UNIVPLL_D4				120
+#define CLK_TOP_UNIVPLL_D4_D2				121
+#define CLK_TOP_UNIVPLL_D4_D4				122
+#define CLK_TOP_UNIVPLL_D4_D8				123
+#define CLK_TOP_UNIVPLL_D5				124
+#define CLK_TOP_UNIVPLL_D5_D2				125
+#define CLK_TOP_UNIVPLL_D5_D4				126
+#define CLK_TOP_UNIVPLL_D6				127
+#define CLK_TOP_UNIVPLL_D6_D2				128
+#define CLK_TOP_UNIVPLL_D6_D4				129
+#define CLK_TOP_UNIVPLL_D6_D8				130
+#define CLK_TOP_UNIVPLL_D6_D16				131
+#define CLK_TOP_UNIVPLL_D7				132
+#define CLK_TOP_UNIVPLL_D7_D2				133
+#define CLK_TOP_UNIVPLL_D7_D3				134
+#define CLK_TOP_LVDSTX_DG_CTS				135
+#define CLK_TOP_UNIVPLL_192M				136
+#define CLK_TOP_UNIVPLL_192M_D2				137
+#define CLK_TOP_UNIVPLL_192M_D4				138
+#define CLK_TOP_UNIVPLL_192M_D8				139
+#define CLK_TOP_UNIVPLL_192M_D10			140
+#define CLK_TOP_UNIVPLL_192M_D16			141
+#define CLK_TOP_UNIVPLL_192M_D32			142
+#define CLK_TOP_APLL1_D2				143
+#define CLK_TOP_APLL1_D4				144
+#define CLK_TOP_APLL1_D8				145
+#define CLK_TOP_APLL1_D3				146
+#define CLK_TOP_APLL2_D2				147
+#define CLK_TOP_APLL2_D4				148
+#define CLK_TOP_APLL2_D8				149
+#define CLK_TOP_APLL2_D3				150
+#define CLK_TOP_MMPLL_D4				151
+#define CLK_TOP_MMPLL_D4_D2				152
+#define CLK_TOP_MMPLL_D4_D4				153
+#define CLK_TOP_VPLL_DPIX				154
+#define CLK_TOP_MMPLL_D5				155
+#define CLK_TOP_MMPLL_D5_D2				156
+#define CLK_TOP_MMPLL_D5_D4				157
+#define CLK_TOP_MMPLL_D6				158
+#define CLK_TOP_MMPLL_D6_D2				159
+#define CLK_TOP_MMPLL_D7				160
+#define CLK_TOP_MMPLL_D9				161
+#define CLK_TOP_TVDPLL1_D2				162
+#define CLK_TOP_TVDPLL1_D4				163
+#define CLK_TOP_TVDPLL1_D8				164
+#define CLK_TOP_TVDPLL1_D16				165
+#define CLK_TOP_TVDPLL2_D2				166
+#define CLK_TOP_TVDPLL2_D4				167
+#define CLK_TOP_TVDPLL2_D8				168
+#define CLK_TOP_TVDPLL2_D16				169
+#define CLK_TOP_ETHPLL_D2				170
+#define CLK_TOP_ETHPLL_D8				171
+#define CLK_TOP_ETHPLL_D10				172
+#define CLK_TOP_MSDCPLL_D2				173
+#define CLK_TOP_VOWPLL					174
+#define CLK_TOP_UFSPLL_D2				175
+#define CLK_TOP_F26M_CK_D2				176
+#define CLK_TOP_OSC_D2					177
+#define CLK_TOP_OSC_D4					178
+#define CLK_TOP_OSC_D8					179
+#define CLK_TOP_OSC_D16					180
+#define CLK_TOP_OSC_D3					181
+#define CLK_TOP_OSC_D7					182
+#define CLK_TOP_OSC_D10					183
+#define CLK_TOP_OSC_D20					184
+#define CLK_TOP_FMCNT_P0_EN				185
+#define CLK_TOP_FMCNT_P1_EN				186
+#define CLK_TOP_FMCNT_P2_EN				187
+#define CLK_TOP_FMCNT_P3_EN				188
+#define CLK_TOP_FMCNT_P4_EN				189
+#define CLK_TOP_USB_F26M_CK_EN				190
+#define CLK_TOP_SSPXTP_F26M_CK_EN			191
+#define CLK_TOP_USB2_PHY_RF_P0_EN			192
+#define CLK_TOP_USB2_PHY_RF_P1_EN			193
+#define CLK_TOP_USB2_PHY_RF_P2_EN			194
+#define CLK_TOP_USB2_PHY_RF_P3_EN			195
+#define CLK_TOP_USB2_PHY_RF_P4_EN			196
+#define CLK_TOP_USB2_26M_CK_P0_EN			197
+#define CLK_TOP_USB2_26M_CK_P1_EN			198
+#define CLK_TOP_USB2_26M_CK_P2_EN			199
+#define CLK_TOP_USB2_26M_CK_P3_EN			200
+#define CLK_TOP_USB2_26M_CK_P4_EN			201
+#define CLK_TOP_F26M_CK_EN				202
+#define CLK_TOP_AP2CON_EN				203
+#define CLK_TOP_EINT_N_EN				204
+#define CLK_TOP_TOPCKGEN_FMIPI_CSI_UP26M_CK_EN		205
+#define CLK_TOP_DRAMULP_CK_EN				206
+#define CLK_TOP_EINT_E_EN				207
+#define CLK_TOP_EINT_W_EN				208
+#define CLK_TOP_EINT_S_EN				209
+
+/* INFRACFG_AO */
+#define CLK_IFRAO_CQ_DMA_FPC				0
+#define CLK_IFRAO_DEBUGSYS				1
+#define CLK_IFRAO_DBG_TRACE				2
+#define CLK_IFRAO_CQ_DMA				3
+
+/* APMIXEDSYS */
+#define CLK_APMIXED_ARMPLL_LL				0
+#define CLK_APMIXED_ARMPLL_BL				1
+#define CLK_APMIXED_CCIPLL				2
+#define CLK_APMIXED_MAINPLL				3
+#define CLK_APMIXED_UNIVPLL				4
+#define CLK_APMIXED_MMPLL				5
+#define CLK_APMIXED_MFGPLL				6
+#define CLK_APMIXED_APLL1				7
+#define CLK_APMIXED_APLL2				8
+#define CLK_APMIXED_EMIPLL				9
+#define CLK_APMIXED_APUPLL2				10
+#define CLK_APMIXED_APUPLL				11
+#define CLK_APMIXED_TVDPLL1				12
+#define CLK_APMIXED_TVDPLL2				13
+#define CLK_APMIXED_ETHPLL				14
+#define CLK_APMIXED_MSDCPLL				15
+#define CLK_APMIXED_UFSPLL				16
+
+/* PERICFG_AO */
+#define CLK_PERAO_UART0					0
+#define CLK_PERAO_UART1					1
+#define CLK_PERAO_UART2					2
+#define CLK_PERAO_UART3					3
+#define CLK_PERAO_PWM_H					4
+#define CLK_PERAO_PWM_B					5
+#define CLK_PERAO_PWM_FB1				6
+#define CLK_PERAO_PWM_FB2				7
+#define CLK_PERAO_PWM_FB3				8
+#define CLK_PERAO_PWM_FB4				9
+#define CLK_PERAO_DISP_PWM0				10
+#define CLK_PERAO_DISP_PWM1				11
+#define CLK_PERAO_SPI0_B				12
+#define CLK_PERAO_SPI1_B				13
+#define CLK_PERAO_SPI2_B				14
+#define CLK_PERAO_SPI3_B				15
+#define CLK_PERAO_SPI4_B				16
+#define CLK_PERAO_SPI5_B				17
+#define CLK_PERAO_SPI0_H				18
+#define CLK_PERAO_SPI1_H				19
+#define CLK_PERAO_SPI2_H				20
+#define CLK_PERAO_SPI3_H				21
+#define CLK_PERAO_SPI4_H				22
+#define CLK_PERAO_SPI5_H				23
+#define CLK_PERAO_AXI					24
+#define CLK_PERAO_AHB_APB				25
+#define CLK_PERAO_TL					26
+#define CLK_PERAO_REF					27
+#define CLK_PERAO_I2C					28
+#define CLK_PERAO_DMA_B					29
+#define CLK_PERAO_SSUSB0_REF				30
+#define CLK_PERAO_SSUSB0_FRMCNT				31
+#define CLK_PERAO_SSUSB0_SYS				32
+#define CLK_PERAO_SSUSB0_XHCI				33
+#define CLK_PERAO_SSUSB0_F				34
+#define CLK_PERAO_SSUSB0_H				35
+#define CLK_PERAO_SSUSB1_REF				36
+#define CLK_PERAO_SSUSB1_FRMCNT				37
+#define CLK_PERAO_SSUSB1_SYS				38
+#define CLK_PERAO_SSUSB1_XHCI				39
+#define CLK_PERAO_SSUSB1_F				40
+#define CLK_PERAO_SSUSB1_H				41
+#define CLK_PERAO_SSUSB2_REF				42
+#define CLK_PERAO_SSUSB2_FRMCNT				43
+#define CLK_PERAO_SSUSB2_SYS				44
+#define CLK_PERAO_SSUSB2_XHCI				45
+#define CLK_PERAO_SSUSB2_F				46
+#define CLK_PERAO_SSUSB2_H				47
+#define CLK_PERAO_SSUSB3_REF				48
+#define CLK_PERAO_SSUSB3_FRMCNT				49
+#define CLK_PERAO_SSUSB3_SYS				50
+#define CLK_PERAO_SSUSB3_XHCI				51
+#define CLK_PERAO_SSUSB3_F				52
+#define CLK_PERAO_SSUSB3_H				53
+#define CLK_PERAO_SSUSB4_REF				54
+#define CLK_PERAO_SSUSB4_FRMCNT				55
+#define CLK_PERAO_SSUSB4_SYS				56
+#define CLK_PERAO_SSUSB4_XHCI				57
+#define CLK_PERAO_SSUSB4_F				58
+#define CLK_PERAO_SSUSB4_H				59
+#define CLK_PERAO_MSDC0					60
+#define CLK_PERAO_MSDC0_H				61
+#define CLK_PERAO_MSDC0_FAES				62
+#define CLK_PERAO_MSDC0_MST_F				63
+#define CLK_PERAO_MSDC0_SLV_H				64
+#define CLK_PERAO_MSDC1					65
+#define CLK_PERAO_MSDC1_H				66
+#define CLK_PERAO_MSDC1_MST_F				67
+#define CLK_PERAO_MSDC1_SLV_H				68
+#define CLK_PERAO_MSDC2					69
+#define CLK_PERAO_MSDC2_H				70
+#define CLK_PERAO_MSDC2_MST_F				71
+#define CLK_PERAO_MSDC2_SLV_H				72
+#define CLK_PERAO_SFLASH				73
+#define CLK_PERAO_SFLASH_F				74
+#define CLK_PERAO_SFLASH_H				75
+#define CLK_PERAO_SFLASH_P				76
+#define CLK_PERAO_AUDIO0				77
+#define CLK_PERAO_AUDIO1				78
+#define CLK_PERAO_AUDIO2				79
+#define CLK_PERAO_AUXADC_26M				80
+
+/* UFSCFG_AO_REG */
+#define CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM			0
+#define CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0		1
+#define CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1		2
+#define CLK_UFSCFG_AO_REG_UNIPRO_SYS			3
+#define CLK_UFSCFG_AO_REG_U_SAP_CFG			4
+#define CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS		5
+
+/* UFSCFG_PDN_REG */
+#define CLK_UFSCFG_REG_UFSHCI_UFS			0
+#define CLK_UFSCFG_REG_UFSHCI_AES			1
+#define CLK_UFSCFG_REG_UFSHCI_U_AHB			2
+#define CLK_UFSCFG_REG_UFSHCI_U_AXI			3
+
+/* IMP_IIC_WRAP_WS */
+#define CLK_IMPWS_I2C2					0
+
+/* IMP_IIC_WRAP_E */
+#define CLK_IMPE_I2C0					0
+#define CLK_IMPE_I2C1					1
+
+/* IMP_IIC_WRAP_S */
+#define CLK_IMPS_I2C3					0
+#define CLK_IMPS_I2C4					1
+#define CLK_IMPS_I2C5					2
+#define CLK_IMPS_I2C6					3
+
+/* IMP_IIC_WRAP_EN */
+#define CLK_IMPEN_I2C7					0
+#define CLK_IMPEN_I2C8					1
+
+/* MFG */
+#define CLK_MFG_BG3D					0
+
+/* DISPSYS_CONFIG */
+#define CLK_MM_DISP_OVL0_4L				0
+#define CLK_MM_DISP_OVL1_4L				1
+#define CLK_MM_VPP_RSZ0					2
+#define CLK_MM_VPP_RSZ1					3
+#define CLK_MM_DISP_RDMA0				4
+#define CLK_MM_DISP_RDMA1				5
+#define CLK_MM_DISP_COLOR0				6
+#define CLK_MM_DISP_COLOR1				7
+#define CLK_MM_DISP_CCORR0				8
+#define CLK_MM_DISP_CCORR1				9
+#define CLK_MM_DISP_CCORR2				10
+#define CLK_MM_DISP_CCORR3				11
+#define CLK_MM_DISP_AAL0				12
+#define CLK_MM_DISP_AAL1				13
+#define CLK_MM_DISP_GAMMA0				14
+#define CLK_MM_DISP_GAMMA1				15
+#define CLK_MM_DISP_DITHER0				16
+#define CLK_MM_DISP_DITHER1				17
+#define CLK_MM_DISP_DSC_WRAP0				18
+#define CLK_MM_VPP_MERGE0				19
+#define CLK_MMSYS_0_DISP_DVO				20
+#define CLK_MMSYS_0_DISP_DSI0				21
+#define CLK_MM_DP_INTF0					22
+#define CLK_MM_DPI0					23
+#define CLK_MM_DISP_WDMA0				24
+#define CLK_MM_DISP_WDMA1				25
+#define CLK_MM_DISP_FAKE_ENG0				26
+#define CLK_MM_DISP_FAKE_ENG1				27
+#define CLK_MM_SMI_LARB					28
+#define CLK_MM_DISP_MUTEX0				29
+#define CLK_MM_DIPSYS_CONFIG				30
+#define CLK_MM_DUMMY					31
+#define CLK_MMSYS_1_DISP_DSI0				32
+#define CLK_MMSYS_1_LVDS_ENCODER			33
+#define CLK_MMSYS_1_DPI0				34
+#define CLK_MMSYS_1_DISP_DVO				35
+#define CLK_MM_DP_INTF					36
+#define CLK_MMSYS_1_LVDS_ENCODER_CTS			37
+#define CLK_MMSYS_1_DISP_DVO_AVT			38
+
+/* IMGSYS1 */
+#define CLK_IMGSYS1_LARB9				0
+#define CLK_IMGSYS1_LARB11				1
+#define CLK_IMGSYS1_DIP					2
+#define CLK_IMGSYS1_GALS				3
+
+/* IMGSYS2 */
+#define CLK_IMGSYS2_LARB9				0
+#define CLK_IMGSYS2_LARB11				1
+#define CLK_IMGSYS2_MFB					2
+#define CLK_IMGSYS2_WPE					3
+#define CLK_IMGSYS2_MSS					4
+#define CLK_IMGSYS2_GALS				5
+
+/* VDEC_CORE */
+#define CLK_VDEC_CORE_LARB_CKEN				0
+#define CLK_VDEC_CORE_VDEC_CKEN				1
+#define CLK_VDEC_CORE_VDEC_ACTIVE			2
+
+/* VENC_GCON */
+#define CLK_VEN1_CKE0_LARB				0
+#define CLK_VEN1_CKE1_VENC				1
+#define CLK_VEN1_CKE2_JPGENC				2
+#define CLK_VEN1_CKE3_JPGDEC				3
+#define CLK_VEN1_CKE4_JPGDEC_C1				4
+#define CLK_VEN1_CKE5_GALS				5
+#define CLK_VEN1_CKE6_GALS_SRAM				6
+
+/* VLPCFG_REG */
+#define CLK_VLPCFG_REG_SCP				0
+#define CLK_VLPCFG_REG_RG_R_APXGPT_26M			1
+#define CLK_VLPCFG_REG_DPMSRCK_TEST			2
+#define CLK_VLPCFG_REG_RG_DPMSRRTC_TEST			3
+#define CLK_VLPCFG_REG_DPMSRULP_TEST			4
+#define CLK_VLPCFG_REG_SPMI_P_MST			5
+#define CLK_VLPCFG_REG_SPMI_P_MST_32K			6
+#define CLK_VLPCFG_REG_PMIF_SPMI_P_SYS			7
+#define CLK_VLPCFG_REG_PMIF_SPMI_P_TMR			8
+#define CLK_VLPCFG_REG_PMIF_SPMI_M_SYS			9
+#define CLK_VLPCFG_REG_PMIF_SPMI_M_TMR			10
+#define CLK_VLPCFG_REG_DVFSRC				11
+#define CLK_VLPCFG_REG_PWM_VLP				12
+#define CLK_VLPCFG_REG_SRCK				13
+#define CLK_VLPCFG_REG_SSPM_F26M			14
+#define CLK_VLPCFG_REG_SSPM_F32K			15
+#define CLK_VLPCFG_REG_SSPM_ULPOSC			16
+#define CLK_VLPCFG_REG_VLP_32K_COM			17
+#define CLK_VLPCFG_REG_VLP_26M_COM			18
+
+/* VLP_CKSYS */
+#define CLK_VLP_CK_SCP_SEL				0
+#define CLK_VLP_CK_PWRAP_ULPOSC_SEL			1
+#define CLK_VLP_CK_SPMI_P_MST_SEL			2
+#define CLK_VLP_CK_DVFSRC_SEL				3
+#define CLK_VLP_CK_PWM_VLP_SEL				4
+#define CLK_VLP_CK_AXI_VLP_SEL				5
+#define CLK_VLP_CK_SYSTIMER_26M_SEL			6
+#define CLK_VLP_CK_SSPM_SEL				7
+#define CLK_VLP_CK_SSPM_F26M_SEL			8
+#define CLK_VLP_CK_SRCK_SEL				9
+#define CLK_VLP_CK_SCP_SPI_SEL				10
+#define CLK_VLP_CK_SCP_IIC_SEL				11
+#define CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL			12
+#define CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL			13
+#define CLK_VLP_CK_SSPM_ULPOSC_SEL			14
+#define CLK_VLP_CK_APXGPT_26M_SEL			15
+#define CLK_VLP_CK_VADSP_SEL				16
+#define CLK_VLP_CK_VADSP_VOWPLL_SEL			17
+#define CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL		18
+#define CLK_VLP_CK_CAMTG0_SEL				19
+#define CLK_VLP_CK_CAMTG1_SEL				20
+#define CLK_VLP_CK_CAMTG2_SEL				21
+#define CLK_VLP_CK_AUD_ADC_SEL				22
+#define CLK_VLP_CK_KP_IRQ_GEN_SEL			23
+#define CLK_VLP_CK_VADSYS_VLP_26M_EN			24
+#define CLK_VLP_CK_SEJ_13M_EN				25
+#define CLK_VLP_CK_SEJ_26M_EN				26
+#define CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN		27
+
+/* SCP_IIC */
+#define CLK_SCP_IIC_I2C0_W1S				0
+#define CLK_SCP_IIC_I2C1_W1S				1
+
+/* SCP */
+#define CLK_SCP_SET_SPI0				0
+#define CLK_SCP_SET_SPI1				1
+
+/* CAMSYS_MAIN */
+#define CLK_CAM_M_LARB13				0
+#define CLK_CAM_M_LARB14				1
+#define CLK_CAM_M_CAMSYS_MAIN_CAM			2
+#define CLK_CAM_M_CAMSYS_MAIN_CAMTG			3
+#define CLK_CAM_M_SENINF				4
+#define CLK_CAM_M_CAMSV1				5
+#define CLK_CAM_M_CAMSV2				6
+#define CLK_CAM_M_CAMSV3				7
+#define CLK_CAM_M_FAKE_ENG				8
+#define CLK_CAM_M_CAM2MM_GALS				9
+#define CLK_CAM_M_CAMSV4				10
+#define CLK_CAM_M_PDA					11
+
+/* CAMSYS_RAWA */
+#define CLK_CAM_RA_CAMSYS_RAWA_LARBX			0
+#define CLK_CAM_RA_CAMSYS_RAWA_CAM			1
+#define CLK_CAM_RA_CAMSYS_RAWA_CAMTG			2
+
+/* CAMSYS_RAWB */
+#define CLK_CAM_RB_CAMSYS_RAWB_LARBX			0
+#define CLK_CAM_RB_CAMSYS_RAWB_CAM			1
+#define CLK_CAM_RB_CAMSYS_RAWB_CAMTG			2
+
+/* IPESYS */
+#define CLK_IPE_LARB19					0
+#define CLK_IPE_LARB20					1
+#define CLK_IPE_SMI_SUBCOM				2
+#define CLK_IPE_FD					3
+#define CLK_IPE_FE					4
+#define CLK_IPE_RSC					5
+#define CLK_IPESYS_GALS					6
+
+/* VLPCFG_AO_REG */
+#define CLK_VLPCFG_AO_APEINT_RX				0
+
+/* DVFSRC_TOP */
+#define CLK_DVFSRC_TOP_DVFSRC_EN			0
+
+/* MMINFRA_CONFIG */
+#define CLK_MMINFRA_GCE_D				0
+#define CLK_MMINFRA_GCE_M				1
+#define CLK_MMINFRA_SMI					2
+#define CLK_MMINFRA_GCE_26M				3
+
+/* GCE_D */
+#define CLK_GCE_D_TOP					0
+
+/* GCE_M */
+#define CLK_GCE_M_TOP					0
+
+/* MDPSYS_CONFIG */
+#define CLK_MDP_MUTEX0					0
+#define CLK_MDP_APB_BUS					1
+#define CLK_MDP_SMI0					2
+#define CLK_MDP_RDMA0					3
+#define CLK_MDP_RDMA2					4
+#define CLK_MDP_HDR0					5
+#define CLK_MDP_AAL0					6
+#define CLK_MDP_RSZ0					7
+#define CLK_MDP_TDSHP0					8
+#define CLK_MDP_COLOR0					9
+#define CLK_MDP_WROT0					10
+#define CLK_MDP_FAKE_ENG0				11
+#define CLK_MDPSYS_CONFIG				12
+#define CLK_MDP_RDMA1					13
+#define CLK_MDP_RDMA3					14
+#define CLK_MDP_HDR1					15
+#define CLK_MDP_AAL1					16
+#define CLK_MDP_RSZ1					17
+#define CLK_MDP_TDSHP1					18
+#define CLK_MDP_COLOR1					19
+#define CLK_MDP_WROT1					20
+#define CLK_MDP_RSZ2					21
+#define CLK_MDP_WROT2					22
+#define CLK_MDP_RSZ3					23
+#define CLK_MDP_WROT3					24
+#define CLK_MDP_BIRSZ0					25
+#define CLK_MDP_BIRSZ1					26
+
+/* DBGAO */
+#define CLK_DBGAO_ATB_EN				0
+
+/* DEM */
+#define CLK_DEM_ATB_EN					0
+#define CLK_DEM_BUSCLK_EN				1
+#define CLK_DEM_SYSCLK_EN				2
+
+#endif /* _DT_BINDINGS_CLK_MT8189_H */

-- 
2.43.0

