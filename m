Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DADFC27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED3986DBD;
	Tue, 11 Jun 2024 11:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZyrhWqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C30B88381; Tue, 11 Jun 2024 11:42:00 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9D283333
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-60585faa69fso3707741a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718098915; x=1718703715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tI3DQZlYgkggSMn1gLZyfTBtw1h51wENqXu5KPsYzS8=;
 b=AZyrhWqiom6Rf3ZoAm8ckSrIw/E2oX+21EcWT/vbIuR2xp8enVtU11N+bkXfdDfRcx
 4gEDZqE9HqKDwidc2IyjzqiwdWyN7yOglu7xYr7nTA+uo4PqauyEadlKjIhUMi5/YdvY
 jbGxHwy6kMO8Upy6TUFGMnY555dO4nNUouqCiOCDSqtKQDaSRA9FLlnQpxWKeZkN5Dcn
 SZn+HxJmsNnXpkyZxYnq4WMjmI8m9+UeO9F8CEShL9kEF06suoRNTQFz1zQO2rMWmpNL
 9+7OX4GujeOs8k/7aVHmnap9wmL5R0fWjOW+/V4OAtjf9hWqJrwC8wop6gO1fqEalnAi
 LcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718098915; x=1718703715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tI3DQZlYgkggSMn1gLZyfTBtw1h51wENqXu5KPsYzS8=;
 b=odXBfabkMt3FjDFNR0+NI7QsZnAD1yRCoIQoYz9vtWdT3Uip/mvkel63ULvDQizGbt
 PmhXzf9I7HKTFzP3a8xu7JMFogfHFoQSUt24QHHk+M8ngWWMMYJozkuJnxXSuNpeUKtj
 O04+lzpMBl+SH4H7u/w+3aEV6V37+DjsZeeze7/LhC7fLmSWRaaQgvJv7x3gy2bNPloQ
 OKmf2HWB8Is3lgVuk9SilGKXyxElk4E22ixpFWW1D4DUXAPeDdpFwW9nkvmeSh/l0UZ9
 LYYEsuwsFx8F071lC4I6rHgPXkIclrNLWXSEnhjIiEtSpdSnDtLZmjuvIQd7SwSq4Rvt
 9Lgg==
X-Gm-Message-State: AOJu0YwmbKxr9jnrzp40WxNxJc6mJopKkQiSeHNFsCwvk1wf+4er6SNu
 T5yan7qVkiVI2ct5apVhXxIj4SlTTRJxiGq4VLNtQuqbFft1Be+uxNOyyWg+
X-Google-Smtp-Source: AGHT+IG49A1A8zyij4d2McRvpSo2iw//gShjbjWQ2DswtPU5St6ILSZurHOAAgCS2Gch0padMZ+klQ==
X-Received: by 2002:a17:902:ec83:b0:1f7:1bf3:db10 with SMTP id
 d9443c01a7336-1f7288cb99bmr32990775ad.20.1718098915131; 
 Tue, 11 Jun 2024 02:41:55 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6d859ea3csm76873555ad.178.2024.06.11.02.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:41:54 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] dt-bindings: clk: import header for clock controller
 of sophgo CV1800B
Date: Tue, 11 Jun 2024 17:41:13 +0800
Message-ID: <20240611094134.18868-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611094134.18868-1-seashell11234455@gmail.com>
References: <20240611094134.18868-1-seashell11234455@gmail.com>
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

Import header file of sophgo cv1800b clock controller from kernel

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Link: https://lore.kernel.org/all/IA1PR20MB4953637E7A6C121D7A700F1CBB8BA@IA1PR20MB4953.namprd20.prod.outlook.com/

---

(no changes since v1)

 include/dt-bindings/clock/sophgo,cv1800.h | 176 ++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

diff --git a/include/dt-bindings/clock/sophgo,cv1800.h b/include/dt-bindings/clock/sophgo,cv1800.h
new file mode 100644
index 0000000000..cfbeca25a6
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,cv1800.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Ltd.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
+#define __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
+
+#define CLK_MPLL			0
+#define CLK_TPLL			1
+#define CLK_FPLL			2
+#define CLK_MIPIMPLL			3
+#define CLK_A0PLL			4
+#define CLK_DISPPLL			5
+#define CLK_CAM0PLL			6
+#define CLK_CAM1PLL			7
+
+#define CLK_MIPIMPLL_D3			8
+#define CLK_CAM0PLL_D2			9
+#define CLK_CAM0PLL_D3			10
+
+#define CLK_TPU				11
+#define CLK_TPU_FAB			12
+#define CLK_AHB_ROM			13
+#define CLK_DDR_AXI_REG			14
+#define CLK_RTC_25M			15
+#define CLK_SRC_RTC_SYS_0		16
+#define CLK_TEMPSEN			17
+#define CLK_SARADC			18
+#define CLK_EFUSE			19
+#define CLK_APB_EFUSE			20
+#define CLK_DEBUG			21
+#define CLK_AP_DEBUG			22
+#define CLK_XTAL_MISC			23
+#define CLK_AXI4_EMMC			24
+#define CLK_EMMC			25
+#define CLK_EMMC_100K			26
+#define CLK_AXI4_SD0			27
+#define CLK_SD0				28
+#define CLK_SD0_100K			29
+#define CLK_AXI4_SD1			30
+#define CLK_SD1				31
+#define CLK_SD1_100K			32
+#define CLK_SPI_NAND			33
+#define CLK_ETH0_500M			34
+#define CLK_AXI4_ETH0			35
+#define CLK_ETH1_500M			36
+#define CLK_AXI4_ETH1			37
+#define CLK_APB_GPIO			38
+#define CLK_APB_GPIO_INTR		39
+#define CLK_GPIO_DB			40
+#define CLK_AHB_SF			41
+#define CLK_AHB_SF1			42
+#define CLK_A24M			43
+#define CLK_AUDSRC			44
+#define CLK_APB_AUDSRC			45
+#define CLK_SDMA_AXI			46
+#define CLK_SDMA_AUD0			47
+#define CLK_SDMA_AUD1			48
+#define CLK_SDMA_AUD2			49
+#define CLK_SDMA_AUD3			50
+#define CLK_I2C				51
+#define CLK_APB_I2C			52
+#define CLK_APB_I2C0			53
+#define CLK_APB_I2C1			54
+#define CLK_APB_I2C2			55
+#define CLK_APB_I2C3			56
+#define CLK_APB_I2C4			57
+#define CLK_APB_WDT			58
+#define CLK_PWM_SRC			59
+#define CLK_PWM				60
+#define CLK_SPI				61
+#define CLK_APB_SPI0			62
+#define CLK_APB_SPI1			63
+#define CLK_APB_SPI2			64
+#define CLK_APB_SPI3			65
+#define CLK_1M				66
+#define CLK_CAM0_200			67
+#define CLK_PM				68
+#define CLK_TIMER0			69
+#define CLK_TIMER1			70
+#define CLK_TIMER2			71
+#define CLK_TIMER3			72
+#define CLK_TIMER4			73
+#define CLK_TIMER5			74
+#define CLK_TIMER6			75
+#define CLK_TIMER7			76
+#define CLK_UART0			77
+#define CLK_APB_UART0			78
+#define CLK_UART1			79
+#define CLK_APB_UART1			80
+#define CLK_UART2			81
+#define CLK_APB_UART2			82
+#define CLK_UART3			83
+#define CLK_APB_UART3			84
+#define CLK_UART4			85
+#define CLK_APB_UART4			86
+#define CLK_APB_I2S0			87
+#define CLK_APB_I2S1			88
+#define CLK_APB_I2S2			89
+#define CLK_APB_I2S3			90
+#define CLK_AXI4_USB			91
+#define CLK_APB_USB			92
+#define CLK_USB_125M			93
+#define CLK_USB_33K			94
+#define CLK_USB_12M			95
+#define CLK_AXI4			96
+#define CLK_AXI6			97
+#define CLK_DSI_ESC			98
+#define CLK_AXI_VIP			99
+#define CLK_SRC_VIP_SYS_0		100
+#define CLK_SRC_VIP_SYS_1		101
+#define CLK_SRC_VIP_SYS_2		102
+#define CLK_SRC_VIP_SYS_3		103
+#define CLK_SRC_VIP_SYS_4		104
+#define CLK_CSI_BE_VIP			105
+#define CLK_CSI_MAC0_VIP		106
+#define CLK_CSI_MAC1_VIP		107
+#define CLK_CSI_MAC2_VIP		108
+#define CLK_CSI0_RX_VIP			109
+#define CLK_CSI1_RX_VIP			110
+#define CLK_ISP_TOP_VIP			111
+#define CLK_IMG_D_VIP			112
+#define CLK_IMG_V_VIP			113
+#define CLK_SC_TOP_VIP			114
+#define CLK_SC_D_VIP			115
+#define CLK_SC_V1_VIP			116
+#define CLK_SC_V2_VIP			117
+#define CLK_SC_V3_VIP			118
+#define CLK_DWA_VIP			119
+#define CLK_BT_VIP			120
+#define CLK_DISP_VIP			121
+#define CLK_DSI_MAC_VIP			122
+#define CLK_LVDS0_VIP			123
+#define CLK_LVDS1_VIP			124
+#define CLK_PAD_VI_VIP			125
+#define CLK_PAD_VI1_VIP			126
+#define CLK_PAD_VI2_VIP			127
+#define CLK_CFG_REG_VIP			128
+#define CLK_VIP_IP0			129
+#define CLK_VIP_IP1			130
+#define CLK_VIP_IP2			131
+#define CLK_VIP_IP3			132
+#define CLK_IVE_VIP			133
+#define CLK_RAW_VIP			134
+#define CLK_OSDC_VIP			135
+#define CLK_CAM0_VIP			136
+#define CLK_AXI_VIDEO_CODEC		137
+#define CLK_VC_SRC0			138
+#define CLK_VC_SRC1			139
+#define CLK_VC_SRC2			140
+#define CLK_H264C			141
+#define CLK_APB_H264C			142
+#define CLK_H265C			143
+#define CLK_APB_H265C			144
+#define CLK_JPEG			145
+#define CLK_APB_JPEG			146
+#define CLK_CAM0			147
+#define CLK_CAM1			148
+#define CLK_WGN				149
+#define CLK_WGN0			150
+#define CLK_WGN1			151
+#define CLK_WGN2			152
+#define CLK_KEYSCAN			153
+#define CLK_CFG_REG_VC			154
+#define CLK_C906_0			155
+#define CLK_C906_1			156
+#define CLK_A53				157
+#define CLK_CPU_AXI0			158
+#define CLK_CPU_GIC			159
+#define CLK_XTAL_AP			160
+
+// Only for CV181x
+#define CLK_DISP_SRC_VIP		161
+
+#endif /* __DT_BINDINGS_SOPHGO_CV1800_CLK_H__ */
-- 
2.41.0

