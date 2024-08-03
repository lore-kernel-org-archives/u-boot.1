Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1091C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E46E88C9A;
	Sat,  3 Aug 2024 13:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DwR7mIVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB0A88C82; Sat,  3 Aug 2024 13:10:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3444588CA6
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so52437975e9.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683452; x=1723288252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ijrSFvlKbG9Cm0UZt5dyERtHkhIRBiVxI8Y6gS15Ai0=;
 b=DwR7mIViFiyEtLjQL+x+CV7DgxWsVhF+s8ltq5JJjUbjktqqS9rrf8b/2GyHiVsySE
 tXkQ4lD7Ngz17spW1xHezuNV3FjhxGAlnCOqEtUsQqm2BzJ2O1g4JZWDZtKUvh7WPbXd
 DS/nRIch+Au6SL615nKkSiGi+1+9l2Q0enuEAiw9DRd3lPPBTp0CiJJovcDU8QMfL91g
 kGZhOanrc4B5pOHrNGdodFMsK9OsAnyzuCYXhivGOZirjvcy5TP3tHMQGhzKFFeCInaA
 0lxxP4eBTL/+rItooAcmVFvnz/UdZfQtpimGeCMLo+CnZWTj+MI6gZQyz4WXgQ905fsA
 UnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683452; x=1723288252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijrSFvlKbG9Cm0UZt5dyERtHkhIRBiVxI8Y6gS15Ai0=;
 b=jZdRtGRQdaS8FI4FqBngIvKuVggceTWTopfPiwuJldFCWphmfGH/7bh/ZCUxWR0D7G
 YYCTYZ7l59yaYTKhR+yyoZcjujjuixJE3fpXzHnpulKj/YOIeKt0rno5q1AYg00b6W+p
 r3+HAB0LE6FIrQAk7jAW8wlCo+tm/sv2iKXqiTGWwObZjgA+dD6KuFhCUQ+RzkOfH4+t
 /kfHUg5fz29yTq5wDSg79k09igLsGPPuHZ7J9EgMGeOfnH5Vr1patxbPbq5zCtEiJ+OU
 BKofXiMgEfrVwQ9tUF974EraPfJAzTIcOFCZC/+qXSR5Op4d3fRL7A5lT60VcvbviY6m
 y5og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF/nNuuG82Ffe4h/xqKCudJzE33MNIeAkr3lt8BOj9zL2jHknrtmXo5UmDEugooXN3DdZfoj4jJeDdGr4+dQHqAF/+zw==
X-Gm-Message-State: AOJu0YyzT8wAd877VmLx0W6N2gaXQKMQm3LLEnlaoDEM0RFj22/+P7+3
 67yCG3x34ip3jT/JwbaBBISszyVzoPBEAOjJ7QJAc+uLOivLhkL9
X-Google-Smtp-Source: AGHT+IHVbZRpNtL9L+tJBAArFKaLFNR+ObLVkRWwjiPr0r+xEOHZVVCm4DhStauClRxgXEJekeNOUw==
X-Received: by 2002:a05:600c:474d:b0:428:150e:4f13 with SMTP id
 5b1f17b1804b1-428e6b95014mr39507785e9.33.1722683451511; 
 Sat, 03 Aug 2024 04:10:51 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 13/15] clk: mediatek: mt7986: replace infracfg ID with
 upstream linux
Date: Sat,  3 Aug 2024 10:40:46 +0200
Message-ID: <20240803084050.449-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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

Replace infracfg clk ID with upstream linux version.

The same format is used here with the factor first, then mux and then
gates.

To correctly reference the gates in clk_gate function, define the
gates_offs value in clk_tree now that they are at an offset from mux and
factor.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      |   1 +
 include/dt-bindings/clock/mt7986-clk.h | 124 ++++++++++++-------------
 2 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 7476024f584..59b82ca7de1 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -533,6 +533,7 @@ static const struct mtk_clk_tree mt7986_topckgen_clk_tree = {
 static const struct mtk_clk_tree mt7986_infracfg_clk_tree = {
 	.fdivs_offs = CK_INFRA_SYSAXI_D2,
 	.muxes_offs = CK_INFRA_UART0_SEL,
+	.gates_offs = CK_INFRA_GPT_STA,
 	.fdivs = infra_fixed_divs,
 	.muxes = infra_muxes,
 	.flags = CLK_INFRASYS,
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 39939f8e028..1c28ab34dcf 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -8,11 +8,6 @@
 #ifndef _DT_BINDINGS_CLK_MT7986_H
 #define _DT_BINDINGS_CLK_MT7986_H
 
-/* INFRACFG */
-
-#define CK_INFRA_SYSAXI_D2		0
-#define CLK_INFRA_NR_CLK		1
-
 /* TOPCKGEN */
 
 #define CK_TOP_XTAL			0
@@ -81,68 +76,65 @@
 #define CK_TOP_AP2CNN_HOST_SEL		62
 #define CLK_TOP_NR_CLK			63
 
-/*
- * INFRACFG_AO
- * clock muxes need to be append to infracfg domain, and clock gates
- * need to be keep in infracgh_ao domain
- */
+/* INFRACFG */
 
-#define CK_INFRA_UART0_SEL		(0 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_UART1_SEL		(1 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_UART2_SEL		(2 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_SPI0_SEL		(3 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_SPI1_SEL		(4 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_PWM1_SEL		(5 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_PWM2_SEL		(6 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_PWM_BSEL		(7 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_PCIE_SEL		(8 + CLK_INFRA_NR_CLK)
-#define CK_INFRA_GPT_STA		0
-#define CK_INFRA_PWM_HCK		1
-#define CK_INFRA_PWM_STA		2
-#define CK_INFRA_PWM1_CK		3
-#define CK_INFRA_PWM2_CK		4
-#define CK_INFRA_CQ_DMA_CK		5
-#define CK_INFRA_EIP97_CK		6
-#define CK_INFRA_AUD_BUS_CK		7
-#define CK_INFRA_AUD_26M_CK		8
-#define CK_INFRA_AUD_L_CK		9
-#define CK_INFRA_AUD_AUD_CK		10
-#define CK_INFRA_AUD_EG2_CK		11
-#define CK_INFRA_DRAMC_26M_CK		12
-#define CK_INFRA_DBG_CK			13
-#define CK_INFRA_AP_DMA_CK		14
-#define CK_INFRA_SEJ_CK			15
-#define CK_INFRA_SEJ_13M_CK		16
-#define CK_INFRA_THERM_CK		17
-#define CK_INFRA_I2C0_CK		18
-#define CK_INFRA_UART0_CK		19
-#define CK_INFRA_UART1_CK		20
-#define CK_INFRA_UART2_CK		21
-#define CK_INFRA_NFI1_CK		22
-#define CK_INFRA_SPINFI1_CK		23
-#define CK_INFRA_NFI_HCK_CK		24
-#define CK_INFRA_SPI0_CK		25
-#define CK_INFRA_SPI1_CK		26
-#define CK_INFRA_SPI0_HCK_CK		27
-#define CK_INFRA_SPI1_HCK_CK		28
-#define CK_INFRA_FRTC_CK		29
-#define CK_INFRA_MSDC_CK		30
-#define CK_INFRA_MSDC_HCK_CK		31
-#define CK_INFRA_MSDC_133M_CK		32
-#define CK_INFRA_MSDC_66M_CK		33
-#define CK_INFRA_ADC_26M_CK		34
-#define CK_INFRA_ADC_FRC_CK		35
-#define CK_INFRA_FBIST2FPC_CK		36
-#define CK_INFRA_IUSB_133_CK		37
-#define CK_INFRA_IUSB_66M_CK		38
-#define CK_INFRA_IUSB_SYS_CK		39
-#define CK_INFRA_IUSB_CK		40
-#define CK_INFRA_IPCIE_CK		41
-#define CK_INFRA_IPCIE_PIPE_CK		42
-#define CK_INFRA_IPCIER_CK		43
-#define CK_INFRA_IPCIEB_CK		44
-#define CK_INFRA_TRNG_CK		45
-#define CLK_INFRA_AO_NR_CLK		46
+#define CK_INFRA_SYSAXI_D2		0
+#define CK_INFRA_UART0_SEL		1
+#define CK_INFRA_UART1_SEL		2
+#define CK_INFRA_UART2_SEL		3
+#define CK_INFRA_SPI0_SEL		4
+#define CK_INFRA_SPI1_SEL		5
+#define CK_INFRA_PWM1_SEL		6
+#define CK_INFRA_PWM2_SEL		7
+#define CK_INFRA_PWM_BSEL		8
+#define CK_INFRA_PCIE_SEL		9
+#define CK_INFRA_GPT_STA		10
+#define CK_INFRA_PWM_HCK		11
+#define CK_INFRA_PWM_STA		12
+#define CK_INFRA_PWM1_CK		13
+#define CK_INFRA_PWM2_CK		14
+#define CK_INFRA_CQ_DMA_CK		15
+#define CK_INFRA_EIP97_CK		16
+#define CK_INFRA_AUD_BUS_CK		17
+#define CK_INFRA_AUD_26M_CK		18
+#define CK_INFRA_AUD_L_CK		19
+#define CK_INFRA_AUD_AUD_CK		20
+#define CK_INFRA_AUD_EG2_CK		21
+#define CK_INFRA_DRAMC_26M_CK		22
+#define CK_INFRA_DBG_CK		23
+#define CK_INFRA_AP_DMA_CK		24
+#define CK_INFRA_SEJ_CK		25
+#define CK_INFRA_SEJ_13M_CK		26
+#define CK_INFRA_THERM_CK		27
+#define CK_INFRA_I2C0_CK		28
+#define CK_INFRA_UART0_CK		29
+#define CK_INFRA_UART1_CK		30
+#define CK_INFRA_UART2_CK		31
+#define CK_INFRA_NFI1_CK		32
+#define CK_INFRA_SPINFI1_CK		33
+#define CK_INFRA_NFI_HCK_CK		34
+#define CK_INFRA_SPI0_CK		35
+#define CK_INFRA_SPI1_CK		36
+#define CK_INFRA_SPI0_HCK_CK		37
+#define CK_INFRA_SPI1_HCK_CK		38
+#define CK_INFRA_FRTC_CK		39
+#define CK_INFRA_MSDC_CK		40
+#define CK_INFRA_MSDC_HCK_CK		41
+#define CK_INFRA_MSDC_133M_CK		42
+#define CK_INFRA_MSDC_66M_CK		43
+#define CK_INFRA_ADC_26M_CK		44
+#define CK_INFRA_ADC_FRC_CK		45
+#define CK_INFRA_FBIST2FPC_CK		46
+#define CK_INFRA_IUSB_133_CK		47
+#define CK_INFRA_IUSB_66M_CK		48
+#define CK_INFRA_IUSB_SYS_CK		49
+#define CK_INFRA_IUSB_CK		50
+#define CK_INFRA_IPCIE_CK		51
+#define CK_INFRA_IPCIE_PIPE_CK		52
+#define CK_INFRA_IPCIER_CK		53
+#define CK_INFRA_IPCIEB_CK		54
+#define CK_INFRA_TRNG_CK		55
+#define CK_INFRA_AO_NR_CLK		46
 
 /* APMIXEDSYS */
 
-- 
2.45.2

