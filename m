Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94A4C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F80876F7;
	Tue, 19 Dec 2023 17:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rbvpq45Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84FE87854; Tue, 19 Dec 2023 17:05:15 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 311E187871
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c38de1ee4so47400835e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001888; x=1703606688; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UxodADE95K0YuCqigT8uYLupzfKCzDwytvkUAbfYazY=;
 b=Rbvpq45Y/DkzPr/TG6iDgtLRcK/UU0MTkY8MWi6gBHC01NkfQXpGxAB9S/YSUezxez
 Sfes40ACuYHRYUmseCD6C7pz8atXkjvfkEDhnuPrTrVJqdmwO4rEPhz9HknOplDx0GF+
 P9+ANxHcDSvjDweUHDbOdw620I7bFC62RhirgnhGXuzV80ZXJFk3OyfyvPK/zAnU4s58
 Q4UVO+aYBWUwFkmxsULR3eE+x8Hpoxx3L7qsqrc0p2SYmCOv3GXPEaTlSgWP3lJcssWk
 sjf+4nmvaNY9X8FOLuogPvvBTuZ49vYb8Kl97pBV7+9u0KhN9ypd83pH5lJXHHiJLpwq
 MN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001888; x=1703606688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxodADE95K0YuCqigT8uYLupzfKCzDwytvkUAbfYazY=;
 b=ZXVCevoPCbxgvkRLfxpaPHJVoHMlwivEhELEe5TKF4Vl4/u4hrd8KIZ3lrj3+FSJYd
 CqPrw8RYPhUJnCQdu7tYVYLRl5NTzSTMoWMmdm3MbE9t01hB6xtmxnFMsLQerTsqcPXD
 aHIA2cpxMH8P/HtNY45GCtp5plpvZTYo3QkuMd6TR9AhqzojnAJd4Cd7uJW3lemHdkg0
 ea2aWh0Wk5aIEkhq5ssAsPlCAnkCLxsiCNAzSy+UBYq71fxyczdk2e22dKIo3vd7YIoF
 BchrL+8Q5t5LmZix6j09Lgm+oKDiFVlBfUMqUJr6e6Wv6wjJBmr4eTk7OClkeAqeV30L
 gEvg==
X-Gm-Message-State: AOJu0Ywr49pov3Z9mLXiegNGkWOG0SJk2dIGuybbceTR9Bf/PHbQaZqW
 twyhj7Q35igc17DRug5OakkzDQ==
X-Google-Smtp-Source: AGHT+IE4PCmvXStgjtsmAQOTknFDmxTXvpT2r00Uy/8lTqKyk1Ra1hye6LsGnKcKyhXVfN3BhWLm3A==
X-Received: by 2002:a1c:7210:0:b0:40c:3ea4:c0fe with SMTP id
 n16-20020a1c7210000000b0040c3ea4c0femr8209746wmc.100.1703001888587; 
 Tue, 19 Dec 2023 08:04:48 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:48 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:26 +0000
Subject: [PATCH v2 25/32] dt-bindings: import headers for MSM8996
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-25-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=30101;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=J/VhFc+lNaa2wnROXK7w71Om8fqihQVbLQD8PsWXlNg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/SyaZX/+rziytS+RbaLrgyex3jPvWh2pflOx5/nK9
 4amQW9fdpSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJVBUxMmw7Wx9sWjYnKGdz
 pLJ0i9lfg9uWBpHG0VPezbzcdWrf9jMMf0WvfkxwDlr/dq3MsX1/vTiO3ha/Up8YpsRf13jjb0J
 J630A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Import dt-binding headers for MSM8996/APQ8096 from Linux.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-msm8996.h       | 360 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-msm8996.h      | 295 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8996-cbf.h    |  12 +
 include/dt-bindings/interconnect/qcom,msm8996.h    | 163 ++++++++++
 include/dt-bindings/sound/qcom,wcd9335.h           |  15 +
 5 files changed, 845 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8996.h b/include/dt-bindings/clock/qcom,gcc-msm8996.h
new file mode 100644
index 000000000000..45b320503905
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-msm8996.h
@@ -0,0 +1,360 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_GCC_8996_H
+#define _DT_BINDINGS_CLK_MSM_GCC_8996_H
+
+#define GPLL0_EARLY						0
+#define GPLL0							1
+#define GPLL1_EARLY						2
+#define GPLL1							3
+#define GPLL2_EARLY						4
+#define GPLL2							5
+#define GPLL3_EARLY						6
+#define GPLL3							7
+#define GPLL4_EARLY						8
+#define GPLL4							9
+#define SYSTEM_NOC_CLK_SRC					10
+// U-Boot: Breaks CI, this clock is unused anyway
+/* #define CONFIG_NOC_CLK_SRC					11 */
+#define PERIPH_NOC_CLK_SRC					12
+#define MMSS_BIMC_GFX_CLK_SRC					13
+#define USB30_MASTER_CLK_SRC					14
+#define USB30_MOCK_UTMI_CLK_SRC					15
+#define USB3_PHY_AUX_CLK_SRC					16
+#define USB20_MASTER_CLK_SRC					17
+#define USB20_MOCK_UTMI_CLK_SRC					18
+#define SDCC1_APPS_CLK_SRC					19
+#define SDCC1_ICE_CORE_CLK_SRC					20
+#define SDCC2_APPS_CLK_SRC					21
+#define SDCC3_APPS_CLK_SRC					22
+#define SDCC4_APPS_CLK_SRC					23
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC				24
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC				25
+#define BLSP1_UART1_APPS_CLK_SRC				26
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC				27
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC				28
+#define BLSP1_UART2_APPS_CLK_SRC				29
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC				30
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC				31
+#define BLSP1_UART3_APPS_CLK_SRC				32
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC				33
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC				34
+#define BLSP1_UART4_APPS_CLK_SRC				35
+#define BLSP1_QUP5_SPI_APPS_CLK_SRC				36
+#define BLSP1_QUP5_I2C_APPS_CLK_SRC				37
+#define BLSP1_UART5_APPS_CLK_SRC				38
+#define BLSP1_QUP6_SPI_APPS_CLK_SRC				39
+#define BLSP1_QUP6_I2C_APPS_CLK_SRC				40
+#define BLSP1_UART6_APPS_CLK_SRC				41
+#define BLSP2_QUP1_SPI_APPS_CLK_SRC				42
+#define BLSP2_QUP1_I2C_APPS_CLK_SRC				43
+#define BLSP2_UART1_APPS_CLK_SRC				44
+#define BLSP2_QUP2_SPI_APPS_CLK_SRC				45
+#define BLSP2_QUP2_I2C_APPS_CLK_SRC				46
+#define BLSP2_UART2_APPS_CLK_SRC				47
+#define BLSP2_QUP3_SPI_APPS_CLK_SRC				48
+#define BLSP2_QUP3_I2C_APPS_CLK_SRC				49
+#define BLSP2_UART3_APPS_CLK_SRC				50
+#define BLSP2_QUP4_SPI_APPS_CLK_SRC				51
+#define BLSP2_QUP4_I2C_APPS_CLK_SRC				52
+#define BLSP2_UART4_APPS_CLK_SRC				53
+#define BLSP2_QUP5_SPI_APPS_CLK_SRC				54
+#define BLSP2_QUP5_I2C_APPS_CLK_SRC				55
+#define BLSP2_UART5_APPS_CLK_SRC				56
+#define BLSP2_QUP6_SPI_APPS_CLK_SRC				57
+#define BLSP2_QUP6_I2C_APPS_CLK_SRC				58
+#define BLSP2_UART6_APPS_CLK_SRC				59
+#define PDM2_CLK_SRC						60
+#define TSIF_REF_CLK_SRC					61
+#define CE1_CLK_SRC						62
+#define GCC_SLEEP_CLK_SRC					63
+#define BIMC_CLK_SRC						64
+#define HMSS_AHB_CLK_SRC					65
+#define BIMC_HMSS_AXI_CLK_SRC					66
+#define HMSS_RBCPR_CLK_SRC					67
+#define HMSS_GPLL0_CLK_SRC					68
+#define GP1_CLK_SRC						69
+#define GP2_CLK_SRC						70
+#define GP3_CLK_SRC						71
+#define PCIE_AUX_CLK_SRC					72
+#define UFS_AXI_CLK_SRC						73
+#define UFS_ICE_CORE_CLK_SRC					74
+#define QSPI_SER_CLK_SRC					75
+#define GCC_SYS_NOC_AXI_CLK					76
+#define GCC_SYS_NOC_HMSS_AHB_CLK				77
+#define GCC_SNOC_CNOC_AHB_CLK					78
+#define GCC_SNOC_PNOC_AHB_CLK					79
+#define GCC_SYS_NOC_AT_CLK					80
+#define GCC_SYS_NOC_USB3_AXI_CLK				81
+#define GCC_SYS_NOC_UFS_AXI_CLK					82
+#define GCC_CFG_NOC_AHB_CLK					83
+#define GCC_PERIPH_NOC_AHB_CLK					84
+#define GCC_PERIPH_NOC_USB20_AHB_CLK				85
+#define GCC_TIC_CLK						86
+#define GCC_IMEM_AXI_CLK					87
+#define GCC_MMSS_SYS_NOC_AXI_CLK				88
+#define GCC_MMSS_NOC_CFG_AHB_CLK				89
+#define GCC_MMSS_BIMC_GFX_CLK					90
+#define GCC_USB30_MASTER_CLK					91
+#define GCC_USB30_SLEEP_CLK					92
+#define GCC_USB30_MOCK_UTMI_CLK					93
+#define GCC_USB3_PHY_AUX_CLK					94
+#define GCC_USB3_PHY_PIPE_CLK					95
+#define GCC_USB20_MASTER_CLK					96
+#define GCC_USB20_SLEEP_CLK					97
+#define GCC_USB20_MOCK_UTMI_CLK					98
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK				99
+#define GCC_SDCC1_APPS_CLK					100
+#define GCC_SDCC1_AHB_CLK					101
+#define GCC_SDCC1_ICE_CORE_CLK					102
+#define GCC_SDCC2_APPS_CLK					103
+#define GCC_SDCC2_AHB_CLK					104
+#define GCC_SDCC3_APPS_CLK					105
+#define GCC_SDCC3_AHB_CLK					106
+#define GCC_SDCC4_APPS_CLK					107
+#define GCC_SDCC4_AHB_CLK					108
+#define GCC_BLSP1_AHB_CLK					109
+#define GCC_BLSP1_SLEEP_CLK					110
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK				111
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK				112
+#define GCC_BLSP1_UART1_APPS_CLK				113
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK				114
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK				115
+#define GCC_BLSP1_UART2_APPS_CLK				116
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK				117
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK				118
+#define GCC_BLSP1_UART3_APPS_CLK				119
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK				120
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK				121
+#define GCC_BLSP1_UART4_APPS_CLK				122
+#define GCC_BLSP1_QUP5_SPI_APPS_CLK				123
+#define GCC_BLSP1_QUP5_I2C_APPS_CLK				124
+#define GCC_BLSP1_UART5_APPS_CLK				125
+#define GCC_BLSP1_QUP6_SPI_APPS_CLK				126
+#define GCC_BLSP1_QUP6_I2C_APPS_CLK				127
+#define GCC_BLSP1_UART6_APPS_CLK				128
+#define GCC_BLSP2_AHB_CLK					129
+#define GCC_BLSP2_SLEEP_CLK					130
+#define GCC_BLSP2_QUP1_SPI_APPS_CLK				131
+#define GCC_BLSP2_QUP1_I2C_APPS_CLK				132
+#define GCC_BLSP2_UART1_APPS_CLK				133
+#define GCC_BLSP2_QUP2_SPI_APPS_CLK				134
+#define GCC_BLSP2_QUP2_I2C_APPS_CLK				135
+#define GCC_BLSP2_UART2_APPS_CLK				136
+#define GCC_BLSP2_QUP3_SPI_APPS_CLK				137
+#define GCC_BLSP2_QUP3_I2C_APPS_CLK				138
+#define GCC_BLSP2_UART3_APPS_CLK				139
+#define GCC_BLSP2_QUP4_SPI_APPS_CLK				140
+#define GCC_BLSP2_QUP4_I2C_APPS_CLK				141
+#define GCC_BLSP2_UART4_APPS_CLK				142
+#define GCC_BLSP2_QUP5_SPI_APPS_CLK				143
+#define GCC_BLSP2_QUP5_I2C_APPS_CLK				144
+#define GCC_BLSP2_UART5_APPS_CLK				145
+#define GCC_BLSP2_QUP6_SPI_APPS_CLK				146
+#define GCC_BLSP2_QUP6_I2C_APPS_CLK				147
+#define GCC_BLSP2_UART6_APPS_CLK				148
+#define GCC_PDM_AHB_CLK						149
+#define GCC_PDM_XO4_CLK						150
+#define GCC_PDM2_CLK						151
+#define GCC_PRNG_AHB_CLK					152
+#define GCC_TSIF_AHB_CLK					153
+#define GCC_TSIF_REF_CLK					154
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK				155
+#define GCC_TCSR_AHB_CLK					156
+#define GCC_BOOT_ROM_AHB_CLK					157
+#define GCC_MSG_RAM_AHB_CLK					158
+#define GCC_TLMM_AHB_CLK					159
+#define GCC_TLMM_CLK						160
+#define GCC_MPM_AHB_CLK						161
+#define GCC_SPMI_SER_CLK					162
+#define GCC_SPMI_CNOC_AHB_CLK					163
+#define GCC_CE1_CLK						164
+#define GCC_CE1_AXI_CLK						165
+#define GCC_CE1_AHB_CLK						166
+#define GCC_BIMC_HMSS_AXI_CLK					167
+#define GCC_BIMC_GFX_CLK					168
+#define GCC_HMSS_AHB_CLK					169
+#define GCC_HMSS_SLV_AXI_CLK					170
+#define GCC_HMSS_MSTR_AXI_CLK					171
+#define GCC_HMSS_RBCPR_CLK					172
+#define GCC_GP1_CLK						173
+#define GCC_GP2_CLK						174
+#define GCC_GP3_CLK						175
+#define GCC_PCIE_0_SLV_AXI_CLK					176
+#define GCC_PCIE_0_MSTR_AXI_CLK					177
+#define GCC_PCIE_0_CFG_AHB_CLK					178
+#define GCC_PCIE_0_AUX_CLK					179
+#define GCC_PCIE_0_PIPE_CLK					180
+#define GCC_PCIE_1_SLV_AXI_CLK					181
+#define GCC_PCIE_1_MSTR_AXI_CLK					182
+#define GCC_PCIE_1_CFG_AHB_CLK					183
+#define GCC_PCIE_1_AUX_CLK					184
+#define GCC_PCIE_1_PIPE_CLK					185
+#define GCC_PCIE_2_SLV_AXI_CLK					186
+#define GCC_PCIE_2_MSTR_AXI_CLK					187
+#define GCC_PCIE_2_CFG_AHB_CLK					188
+#define GCC_PCIE_2_AUX_CLK					189
+#define GCC_PCIE_2_PIPE_CLK					190
+#define GCC_PCIE_PHY_CFG_AHB_CLK				191
+#define GCC_PCIE_PHY_AUX_CLK					192
+#define GCC_UFS_AXI_CLK						193
+#define GCC_UFS_AHB_CLK						194
+#define GCC_UFS_TX_CFG_CLK					195
+#define GCC_UFS_RX_CFG_CLK					196
+#define GCC_UFS_TX_SYMBOL_0_CLK					197
+#define GCC_UFS_RX_SYMBOL_0_CLK					198
+#define GCC_UFS_RX_SYMBOL_1_CLK					199
+#define GCC_UFS_UNIPRO_CORE_CLK					200
+#define GCC_UFS_ICE_CORE_CLK					201
+#define GCC_UFS_SYS_CLK_CORE_CLK				202
+#define GCC_UFS_TX_SYMBOL_CLK_CORE_CLK				203
+#define GCC_AGGRE0_SNOC_AXI_CLK					204
+#define GCC_AGGRE0_CNOC_AHB_CLK					205
+#define GCC_SMMU_AGGRE0_AXI_CLK					206
+#define GCC_SMMU_AGGRE0_AHB_CLK					207
+#define GCC_AGGRE1_PNOC_AHB_CLK					208
+#define GCC_AGGRE2_UFS_AXI_CLK					209
+#define GCC_AGGRE2_USB3_AXI_CLK					210
+#define GCC_QSPI_AHB_CLK					211
+#define GCC_QSPI_SER_CLK					212
+#define GCC_USB3_CLKREF_CLK					213
+#define GCC_HDMI_CLKREF_CLK					214
+#define GCC_UFS_CLKREF_CLK					215
+#define GCC_PCIE_CLKREF_CLK					216
+#define GCC_RX2_USB2_CLKREF_CLK					217
+#define GCC_RX1_USB2_CLKREF_CLK					218
+#define GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK			219
+#define GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK			220
+#define GCC_EDP_CLKREF_CLK					221
+#define GCC_MSS_CFG_AHB_CLK					222
+#define GCC_MSS_Q6_BIMC_AXI_CLK					223
+#define GCC_MSS_SNOC_AXI_CLK					224
+#define GCC_MSS_MNOC_BIMC_AXI_CLK				225
+#define GCC_DCC_AHB_CLK						226
+#define GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK				227
+#define GCC_MMSS_GPLL0_DIV_CLK					228
+#define GCC_MSS_GPLL0_DIV_CLK					229
+
+#define GCC_SYSTEM_NOC_BCR					0
+#define GCC_CONFIG_NOC_BCR					1
+#define GCC_PERIPH_NOC_BCR					2
+#define GCC_IMEM_BCR						3
+#define GCC_MMSS_BCR						4
+#define GCC_PIMEM_BCR						5
+#define GCC_QDSS_BCR						6
+#define GCC_USB_30_BCR						7
+#define GCC_USB_20_BCR						8
+#define GCC_QUSB2PHY_PRIM_BCR					9
+#define GCC_QUSB2PHY_SEC_BCR					10
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				11
+#define GCC_SDCC1_BCR						12
+#define GCC_SDCC2_BCR						13
+#define GCC_SDCC3_BCR						14
+#define GCC_SDCC4_BCR						15
+#define GCC_BLSP1_BCR						16
+#define GCC_BLSP1_QUP1_BCR					17
+#define GCC_BLSP1_UART1_BCR					18
+#define GCC_BLSP1_QUP2_BCR					19
+#define GCC_BLSP1_UART2_BCR					20
+#define GCC_BLSP1_QUP3_BCR					21
+#define GCC_BLSP1_UART3_BCR					22
+#define GCC_BLSP1_QUP4_BCR					23
+#define GCC_BLSP1_UART4_BCR					24
+#define GCC_BLSP1_QUP5_BCR					25
+#define GCC_BLSP1_UART5_BCR					26
+#define GCC_BLSP1_QUP6_BCR					27
+#define GCC_BLSP1_UART6_BCR					28
+#define GCC_BLSP2_BCR						29
+#define GCC_BLSP2_QUP1_BCR					30
+#define GCC_BLSP2_UART1_BCR					31
+#define GCC_BLSP2_QUP2_BCR					32
+#define GCC_BLSP2_UART2_BCR					33
+#define GCC_BLSP2_QUP3_BCR					34
+#define GCC_BLSP2_UART3_BCR					35
+#define GCC_BLSP2_QUP4_BCR					36
+#define GCC_BLSP2_UART4_BCR					37
+#define GCC_BLSP2_QUP5_BCR					38
+#define GCC_BLSP2_UART5_BCR					39
+#define GCC_BLSP2_QUP6_BCR					40
+#define GCC_BLSP2_UART6_BCR					41
+#define GCC_PDM_BCR						42
+#define GCC_PRNG_BCR						43
+#define GCC_TSIF_BCR						44
+#define GCC_TCSR_BCR						45
+#define GCC_BOOT_ROM_BCR					46
+#define GCC_MSG_RAM_BCR						47
+#define GCC_TLMM_BCR						48
+#define GCC_MPM_BCR						49
+#define GCC_SEC_CTRL_BCR					50
+#define GCC_SPMI_BCR						51
+#define GCC_SPDM_BCR						52
+#define GCC_CE1_BCR						53
+#define GCC_BIMC_BCR						54
+#define GCC_SNOC_BUS_TIMEOUT0_BCR				55
+#define GCC_SNOC_BUS_TIMEOUT2_BCR				56
+#define GCC_SNOC_BUS_TIMEOUT1_BCR				57
+#define GCC_SNOC_BUS_TIMEOUT3_BCR				58
+#define GCC_SNOC_BUS_TIMEOUT_EXTREF_BCR				59
+#define GCC_PNOC_BUS_TIMEOUT0_BCR				60
+#define GCC_PNOC_BUS_TIMEOUT1_BCR				61
+#define GCC_PNOC_BUS_TIMEOUT2_BCR				62
+#define GCC_PNOC_BUS_TIMEOUT3_BCR				63
+#define GCC_PNOC_BUS_TIMEOUT4_BCR				64
+#define GCC_CNOC_BUS_TIMEOUT0_BCR				65
+#define GCC_CNOC_BUS_TIMEOUT1_BCR				66
+#define GCC_CNOC_BUS_TIMEOUT2_BCR				67
+#define GCC_CNOC_BUS_TIMEOUT3_BCR				68
+#define GCC_CNOC_BUS_TIMEOUT4_BCR				69
+#define GCC_CNOC_BUS_TIMEOUT5_BCR				70
+#define GCC_CNOC_BUS_TIMEOUT6_BCR				71
+#define GCC_CNOC_BUS_TIMEOUT7_BCR				72
+#define GCC_CNOC_BUS_TIMEOUT8_BCR				73
+#define GCC_CNOC_BUS_TIMEOUT9_BCR				74
+#define GCC_CNOC_BUS_TIMEOUT_EXTREF_BCR				75
+#define GCC_APB2JTAG_BCR					76
+#define GCC_RBCPR_CX_BCR					77
+#define GCC_RBCPR_MX_BCR					78
+#define GCC_PCIE_0_BCR						79
+#define GCC_PCIE_0_PHY_BCR					80
+#define GCC_PCIE_1_BCR						81
+#define GCC_PCIE_1_PHY_BCR					82
+#define GCC_PCIE_2_BCR						83
+#define GCC_PCIE_2_PHY_BCR					84
+#define GCC_PCIE_PHY_BCR					85
+#define GCC_DCD_BCR						86
+#define GCC_OBT_ODT_BCR						87
+#define GCC_UFS_BCR						88
+#define GCC_SSC_BCR						89
+#define GCC_VS_BCR						90
+#define GCC_AGGRE0_NOC_BCR					91
+#define GCC_AGGRE1_NOC_BCR					92
+#define GCC_AGGRE2_NOC_BCR					93
+#define GCC_DCC_BCR						94
+#define GCC_IPA_BCR						95
+#define GCC_QSPI_BCR						96
+#define GCC_SKL_BCR						97
+#define GCC_MSMPU_BCR						98
+#define GCC_MSS_Q6_BCR						99
+#define GCC_QREFS_VBG_CAL_BCR					100
+#define GCC_PCIE_PHY_COM_BCR					101
+#define GCC_PCIE_PHY_COM_NOCSR_BCR				102
+#define GCC_USB3_PHY_BCR					103
+#define GCC_USB3PHY_PHY_BCR					104
+#define GCC_MSS_RESTART						105
+
+
+/* Indexes for GDSCs */
+#define AGGRE0_NOC_GDSC			0
+#define HLOS1_VOTE_AGGRE0_NOC_GDSC	1
+#define HLOS1_VOTE_LPASS_ADSP_GDSC	2
+#define HLOS1_VOTE_LPASS_CORE_GDSC	3
+#define USB30_GDSC			4
+#define PCIE0_GDSC			5
+#define PCIE1_GDSC			6
+#define PCIE2_GDSC			7
+#define UFS_GDSC			8
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8996.h b/include/dt-bindings/clock/qcom,mmcc-msm8996.h
new file mode 100644
index 000000000000..d51f9ac70566
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8996.h
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_MMCC_8996_H
+#define _DT_BINDINGS_CLK_MSM_MMCC_8996_H
+
+#define MMPLL0_EARLY					0
+#define MMPLL0_PLL					1
+#define MMPLL1_EARLY					2
+#define MMPLL1_PLL					3
+#define MMPLL2_EARLY					4
+#define MMPLL2_PLL					5
+#define MMPLL3_EARLY					6
+#define MMPLL3_PLL					7
+#define MMPLL4_EARLY					8
+#define MMPLL4_PLL					9
+#define MMPLL5_EARLY					10
+#define MMPLL5_PLL					11
+#define MMPLL8_EARLY					12
+#define MMPLL8_PLL					13
+#define MMPLL9_EARLY					14
+#define MMPLL9_PLL					15
+#define AHB_CLK_SRC					16
+#define AXI_CLK_SRC					17
+#define MAXI_CLK_SRC					18
+#define DSA_CORE_CLK_SRC				19
+#define GFX3D_CLK_SRC					20
+#define RBBMTIMER_CLK_SRC				21
+#define ISENSE_CLK_SRC					22
+#define RBCPR_CLK_SRC					23
+#define VIDEO_CORE_CLK_SRC				24
+#define VIDEO_SUBCORE0_CLK_SRC				25
+#define VIDEO_SUBCORE1_CLK_SRC				26
+#define PCLK0_CLK_SRC					27
+#define PCLK1_CLK_SRC					28
+#define MDP_CLK_SRC					29
+#define EXTPCLK_CLK_SRC					30
+#define VSYNC_CLK_SRC					31
+#define HDMI_CLK_SRC					32
+#define BYTE0_CLK_SRC					33
+#define BYTE1_CLK_SRC					34
+#define ESC0_CLK_SRC					35
+#define ESC1_CLK_SRC					36
+#define CAMSS_GP0_CLK_SRC				37
+#define CAMSS_GP1_CLK_SRC				38
+#define MCLK0_CLK_SRC					39
+#define MCLK1_CLK_SRC					40
+#define MCLK2_CLK_SRC					41
+#define MCLK3_CLK_SRC					42
+#define CCI_CLK_SRC					43
+#define CSI0PHYTIMER_CLK_SRC				44
+#define CSI1PHYTIMER_CLK_SRC				45
+#define CSI2PHYTIMER_CLK_SRC				46
+#define CSIPHY0_3P_CLK_SRC				47
+#define CSIPHY1_3P_CLK_SRC				48
+#define CSIPHY2_3P_CLK_SRC				49
+#define JPEG0_CLK_SRC					50
+#define JPEG2_CLK_SRC					51
+#define JPEG_DMA_CLK_SRC				52
+#define VFE0_CLK_SRC					53
+#define VFE1_CLK_SRC					54
+#define CPP_CLK_SRC					55
+#define CSI0_CLK_SRC					56
+#define CSI1_CLK_SRC					57
+#define CSI2_CLK_SRC					58
+#define CSI3_CLK_SRC					59
+#define FD_CORE_CLK_SRC					60
+#define MMSS_CXO_CLK					61
+#define MMSS_SLEEPCLK_CLK				62
+#define MMSS_MMAGIC_AHB_CLK				63
+#define MMSS_MMAGIC_CFG_AHB_CLK				64
+#define MMSS_MISC_AHB_CLK				65
+#define MMSS_MISC_CXO_CLK				66
+#define MMSS_BTO_AHB_CLK				67
+#define MMSS_MMAGIC_AXI_CLK				68
+#define MMSS_S0_AXI_CLK					69
+#define MMSS_MMAGIC_MAXI_CLK				70
+#define DSA_CORE_CLK					71
+#define DSA_NOC_CFG_AHB_CLK				72
+#define MMAGIC_CAMSS_AXI_CLK				73
+#define MMAGIC_CAMSS_NOC_CFG_AHB_CLK			74
+#define THROTTLE_CAMSS_CXO_CLK				75
+#define THROTTLE_CAMSS_AHB_CLK				76
+#define THROTTLE_CAMSS_AXI_CLK				77
+#define SMMU_VFE_AHB_CLK				78
+#define SMMU_VFE_AXI_CLK				79
+#define SMMU_CPP_AHB_CLK				80
+#define SMMU_CPP_AXI_CLK				81
+#define SMMU_JPEG_AHB_CLK				82
+#define SMMU_JPEG_AXI_CLK				83
+#define MMAGIC_MDSS_AXI_CLK				84
+#define MMAGIC_MDSS_NOC_CFG_AHB_CLK			85
+#define THROTTLE_MDSS_CXO_CLK				86
+#define THROTTLE_MDSS_AHB_CLK				87
+#define THROTTLE_MDSS_AXI_CLK				88
+#define SMMU_ROT_AHB_CLK				89
+#define SMMU_ROT_AXI_CLK				90
+#define SMMU_MDP_AHB_CLK				91
+#define SMMU_MDP_AXI_CLK				92
+#define MMAGIC_VIDEO_AXI_CLK				93
+#define MMAGIC_VIDEO_NOC_CFG_AHB_CLK			94
+#define THROTTLE_VIDEO_CXO_CLK				95
+#define THROTTLE_VIDEO_AHB_CLK				96
+#define THROTTLE_VIDEO_AXI_CLK				97
+#define SMMU_VIDEO_AHB_CLK				98
+#define SMMU_VIDEO_AXI_CLK				99
+#define MMAGIC_BIMC_AXI_CLK				100
+#define MMAGIC_BIMC_NOC_CFG_AHB_CLK			101
+#define GPU_GX_GFX3D_CLK				102
+#define GPU_GX_RBBMTIMER_CLK				103
+#define GPU_AHB_CLK					104
+#define GPU_AON_ISENSE_CLK				105
+#define VMEM_MAXI_CLK					106
+#define VMEM_AHB_CLK					107
+#define MMSS_RBCPR_CLK					108
+#define MMSS_RBCPR_AHB_CLK				109
+#define VIDEO_CORE_CLK					110
+#define VIDEO_AXI_CLK					111
+#define VIDEO_MAXI_CLK					112
+#define VIDEO_AHB_CLK					113
+#define VIDEO_SUBCORE0_CLK				114
+#define VIDEO_SUBCORE1_CLK				115
+#define MDSS_AHB_CLK					116
+#define MDSS_HDMI_AHB_CLK				117
+#define MDSS_AXI_CLK					118
+#define MDSS_PCLK0_CLK					119
+#define MDSS_PCLK1_CLK					120
+#define MDSS_MDP_CLK					121
+#define MDSS_EXTPCLK_CLK				122
+#define MDSS_VSYNC_CLK					123
+#define MDSS_HDMI_CLK					124
+#define MDSS_BYTE0_CLK					125
+#define MDSS_BYTE1_CLK					126
+#define MDSS_ESC0_CLK					127
+#define MDSS_ESC1_CLK					128
+#define CAMSS_TOP_AHB_CLK				129
+#define CAMSS_AHB_CLK					130
+#define CAMSS_MICRO_AHB_CLK				131
+#define CAMSS_GP0_CLK					132
+#define CAMSS_GP1_CLK					133
+#define CAMSS_MCLK0_CLK					134
+#define CAMSS_MCLK1_CLK					135
+#define CAMSS_MCLK2_CLK					136
+#define CAMSS_MCLK3_CLK					137
+#define CAMSS_CCI_CLK					138
+#define CAMSS_CCI_AHB_CLK				139
+#define CAMSS_CSI0PHYTIMER_CLK				140
+#define CAMSS_CSI1PHYTIMER_CLK				141
+#define CAMSS_CSI2PHYTIMER_CLK				142
+#define CAMSS_CSIPHY0_3P_CLK				143
+#define CAMSS_CSIPHY1_3P_CLK				144
+#define CAMSS_CSIPHY2_3P_CLK				145
+#define CAMSS_JPEG0_CLK					146
+#define CAMSS_JPEG2_CLK					147
+#define CAMSS_JPEG_DMA_CLK				148
+#define CAMSS_JPEG_AHB_CLK				149
+#define CAMSS_JPEG_AXI_CLK				150
+#define CAMSS_VFE_AHB_CLK				151
+#define CAMSS_VFE_AXI_CLK				152
+#define CAMSS_VFE0_CLK					153
+#define CAMSS_VFE0_STREAM_CLK				154
+#define CAMSS_VFE0_AHB_CLK				155
+#define CAMSS_VFE1_CLK					156
+#define CAMSS_VFE1_STREAM_CLK				157
+#define CAMSS_VFE1_AHB_CLK				158
+#define CAMSS_CSI_VFE0_CLK				159
+#define CAMSS_CSI_VFE1_CLK				160
+#define CAMSS_CPP_VBIF_AHB_CLK				161
+#define CAMSS_CPP_AXI_CLK				162
+#define CAMSS_CPP_CLK					163
+#define CAMSS_CPP_AHB_CLK				164
+#define CAMSS_CSI0_CLK					165
+#define CAMSS_CSI0_AHB_CLK				166
+#define CAMSS_CSI0PHY_CLK				167
+#define CAMSS_CSI0RDI_CLK				168
+#define CAMSS_CSI0PIX_CLK				169
+#define CAMSS_CSI1_CLK					170
+#define CAMSS_CSI1_AHB_CLK				171
+#define CAMSS_CSI1PHY_CLK				172
+#define CAMSS_CSI1RDI_CLK				173
+#define CAMSS_CSI1PIX_CLK				174
+#define CAMSS_CSI2_CLK					175
+#define CAMSS_CSI2_AHB_CLK				176
+#define CAMSS_CSI2PHY_CLK				177
+#define CAMSS_CSI2RDI_CLK				178
+#define CAMSS_CSI2PIX_CLK				179
+#define CAMSS_CSI3_CLK					180
+#define CAMSS_CSI3_AHB_CLK				181
+#define CAMSS_CSI3PHY_CLK				182
+#define CAMSS_CSI3RDI_CLK				183
+#define CAMSS_CSI3PIX_CLK				184
+#define CAMSS_ISPIF_AHB_CLK				185
+#define FD_CORE_CLK					186
+#define FD_CORE_UAR_CLK					187
+#define FD_AHB_CLK					188
+#define MMSS_SPDM_CSI0_CLK				189
+#define MMSS_SPDM_JPEG_DMA_CLK				190
+#define MMSS_SPDM_CPP_CLK				191
+#define MMSS_SPDM_PCLK0_CLK				192
+#define MMSS_SPDM_AHB_CLK				193
+#define MMSS_SPDM_GFX3D_CLK				194
+#define MMSS_SPDM_PCLK1_CLK				195
+#define MMSS_SPDM_JPEG2_CLK				196
+#define MMSS_SPDM_DEBUG_CLK				197
+#define MMSS_SPDM_VFE1_CLK				198
+#define MMSS_SPDM_VFE0_CLK				199
+#define MMSS_SPDM_VIDEO_CORE_CLK			200
+#define MMSS_SPDM_AXI_CLK				201
+#define MMSS_SPDM_MDP_CLK				202
+#define MMSS_SPDM_JPEG0_CLK				203
+#define MMSS_SPDM_RM_AXI_CLK				204
+#define MMSS_SPDM_RM_MAXI_CLK				205
+
+#define MMAGICAHB_BCR					0
+#define MMAGIC_CFG_BCR					1
+#define MISC_BCR					2
+#define BTO_BCR						3
+#define MMAGICAXI_BCR					4
+#define MMAGICMAXI_BCR					5
+#define DSA_BCR						6
+#define MMAGIC_CAMSS_BCR				7
+#define THROTTLE_CAMSS_BCR				8
+#define SMMU_VFE_BCR					9
+#define SMMU_CPP_BCR					10
+#define SMMU_JPEG_BCR					11
+#define MMAGIC_MDSS_BCR					12
+#define THROTTLE_MDSS_BCR				13
+#define SMMU_ROT_BCR					14
+#define SMMU_MDP_BCR					15
+#define MMAGIC_VIDEO_BCR				16
+#define THROTTLE_VIDEO_BCR				17
+#define SMMU_VIDEO_BCR					18
+#define MMAGIC_BIMC_BCR					19
+#define GPU_GX_BCR					20
+#define GPU_BCR						21
+#define GPU_AON_BCR					22
+#define VMEM_BCR					23
+#define MMSS_RBCPR_BCR					24
+#define VIDEO_BCR					25
+#define MDSS_BCR					26
+#define CAMSS_TOP_BCR					27
+#define CAMSS_AHB_BCR					28
+#define CAMSS_MICRO_BCR					29
+#define CAMSS_CCI_BCR					30
+#define CAMSS_PHY0_BCR					31
+#define CAMSS_PHY1_BCR					32
+#define CAMSS_PHY2_BCR					33
+#define CAMSS_CSIPHY0_3P_BCR				34
+#define CAMSS_CSIPHY1_3P_BCR				35
+#define CAMSS_CSIPHY2_3P_BCR				36
+#define CAMSS_JPEG_BCR					37
+#define CAMSS_VFE_BCR					38
+#define CAMSS_VFE0_BCR					39
+#define CAMSS_VFE1_BCR					40
+#define CAMSS_CSI_VFE0_BCR				41
+#define CAMSS_CSI_VFE1_BCR				42
+#define CAMSS_CPP_TOP_BCR				43
+#define CAMSS_CPP_BCR					44
+#define CAMSS_CSI0_BCR					45
+#define CAMSS_CSI0RDI_BCR				46
+#define CAMSS_CSI0PIX_BCR				47
+#define CAMSS_CSI1_BCR					48
+#define CAMSS_CSI1RDI_BCR				49
+#define CAMSS_CSI1PIX_BCR				50
+#define CAMSS_CSI2_BCR					51
+#define CAMSS_CSI2RDI_BCR				52
+#define CAMSS_CSI2PIX_BCR				53
+#define CAMSS_CSI3_BCR					54
+#define CAMSS_CSI3RDI_BCR				55
+#define CAMSS_CSI3PIX_BCR				56
+#define CAMSS_ISPIF_BCR					57
+#define FD_BCR						58
+#define MMSS_SPDM_RM_BCR				59
+
+/* Indexes for GDSCs */
+#define MMAGIC_VIDEO_GDSC	0
+#define MMAGIC_MDSS_GDSC	1
+#define MMAGIC_CAMSS_GDSC	2
+#define GPU_GDSC		3
+#define VENUS_GDSC		4
+#define VENUS_CORE0_GDSC	5
+#define VENUS_CORE1_GDSC	6
+#define CAMSS_GDSC		7
+#define VFE0_GDSC		8
+#define VFE1_GDSC		9
+#define JPEG_GDSC		10
+#define CPP_GDSC		11
+#define FD_GDSC			12
+#define MDSS_GDSC		13
+#define GPU_GX_GDSC		14
+#define MMAGIC_BIMC_GDSC	15
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,msm8996-cbf.h b/include/dt-bindings/interconnect/qcom,msm8996-cbf.h
new file mode 100644
index 000000000000..aac5e69f6bd5
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8996-cbf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Linaro Ltd. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_CBF_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_CBF_H
+
+#define MASTER_CBF_M4M		0
+#define SLAVE_CBF_M4M		1
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,msm8996.h b/include/dt-bindings/interconnect/qcom,msm8996.h
new file mode 100644
index 000000000000..a0b7c0ec7bed
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8996.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Qualcomm MSM8996 interconnect IDs
+ *
+ * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8996_H
+
+/* A0NOC */
+#define MASTER_PCIE_0			0
+#define MASTER_PCIE_1			1
+#define MASTER_PCIE_2			2
+
+/* A1NOC */
+#define MASTER_CNOC_A1NOC		0
+#define MASTER_CRYPTO_CORE0		1
+#define MASTER_PNOC_A1NOC		2
+
+/* A2NOC */
+#define MASTER_USB3			0
+#define MASTER_IPA			1
+#define MASTER_UFS			2
+
+/* BIMC */
+#define MASTER_AMPSS_M0			0
+#define MASTER_GRAPHICS_3D		1
+#define MASTER_MNOC_BIMC		2
+#define MASTER_SNOC_BIMC		3
+#define SLAVE_EBI_CH0			4
+#define SLAVE_HMSS_L3			5
+#define SLAVE_BIMC_SNOC_0		6
+#define SLAVE_BIMC_SNOC_1		7
+
+/* CNOC */
+#define MASTER_SNOC_CNOC		0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_CNOC_A1NOC		2
+#define SLAVE_CLK_CTL			3
+#define SLAVE_TCSR			4
+#define SLAVE_TLMM			5
+#define SLAVE_CRYPTO_0_CFG		6
+#define SLAVE_MPM			7
+#define SLAVE_PIMEM_CFG			8
+#define SLAVE_IMEM_CFG			9
+#define SLAVE_MESSAGE_RAM		10
+#define SLAVE_BIMC_CFG			11
+#define SLAVE_PMIC_ARB			12
+#define SLAVE_PRNG			13
+#define SLAVE_DCC_CFG			14
+#define SLAVE_RBCPR_MX			15
+#define SLAVE_QDSS_CFG			16
+#define SLAVE_RBCPR_CX			17
+#define SLAVE_QDSS_RBCPR_APU		18
+#define SLAVE_CNOC_MNOC_CFG		19
+#define SLAVE_SNOC_CFG			20
+#define SLAVE_SNOC_MPU_CFG		21
+#define SLAVE_EBI1_PHY_CFG		22
+#define SLAVE_A0NOC_CFG			23
+#define SLAVE_PCIE_1_CFG		24
+#define SLAVE_PCIE_2_CFG		25
+#define SLAVE_PCIE_0_CFG		26
+#define SLAVE_PCIE20_AHB2PHY		27
+#define SLAVE_A0NOC_MPU_CFG		28
+#define SLAVE_UFS_CFG			29
+#define SLAVE_A1NOC_CFG			30
+#define SLAVE_A1NOC_MPU_CFG		31
+#define SLAVE_A2NOC_CFG			32
+#define SLAVE_A2NOC_MPU_CFG		33
+#define SLAVE_SSC_CFG			34
+#define SLAVE_A0NOC_SMMU_CFG		35
+#define SLAVE_A1NOC_SMMU_CFG		36
+#define SLAVE_A2NOC_SMMU_CFG		37
+#define SLAVE_LPASS_SMMU_CFG		38
+#define SLAVE_CNOC_MNOC_MMSS_CFG	39
+
+/* MNOC */
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CPP			1
+#define MASTER_JPEG			2
+#define MASTER_MDP_PORT0		3
+#define MASTER_MDP_PORT1		4
+#define MASTER_ROTATOR			5
+#define MASTER_VIDEO_P0			6
+#define MASTER_VFE			7
+#define MASTER_SNOC_VMEM		8
+#define MASTER_VIDEO_P0_OCMEM		9
+#define MASTER_CNOC_MNOC_MMSS_CFG	10
+#define SLAVE_MNOC_BIMC			11
+#define SLAVE_VMEM			12
+#define SLAVE_SERVICE_MNOC		13
+#define SLAVE_MMAGIC_CFG		14
+#define SLAVE_CPR_CFG			15
+#define SLAVE_MISC_CFG			16
+#define SLAVE_VENUS_THROTTLE_CFG	17
+#define SLAVE_VENUS_CFG			18
+#define SLAVE_VMEM_CFG			19
+#define SLAVE_DSA_CFG			20
+#define SLAVE_MMSS_CLK_CFG		21
+#define SLAVE_DSA_MPU_CFG		22
+#define SLAVE_MNOC_MPU_CFG		23
+#define SLAVE_DISPLAY_CFG		24
+#define SLAVE_DISPLAY_THROTTLE_CFG	25
+#define SLAVE_CAMERA_CFG		26
+#define SLAVE_CAMERA_THROTTLE_CFG	27
+#define SLAVE_GRAPHICS_3D_CFG		28
+#define SLAVE_SMMU_MDP_CFG		29
+#define SLAVE_SMMU_ROT_CFG		30
+#define SLAVE_SMMU_VENUS_CFG		31
+#define SLAVE_SMMU_CPP_CFG		32
+#define SLAVE_SMMU_JPEG_CFG		33
+#define SLAVE_SMMU_VFE_CFG		34
+
+/* PNOC */
+#define MASTER_SNOC_PNOC		0
+#define MASTER_SDCC_1			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_USB_HS			4
+#define MASTER_BLSP_1			5
+#define MASTER_BLSP_2			6
+#define MASTER_TSIF			7
+#define SLAVE_PNOC_A1NOC		8
+#define SLAVE_USB_HS			9
+#define SLAVE_SDCC_2			10
+#define SLAVE_SDCC_4			11
+#define SLAVE_TSIF			12
+#define SLAVE_BLSP_2			13
+#define SLAVE_SDCC_1			14
+#define SLAVE_BLSP_1			15
+#define SLAVE_PDM			16
+#define SLAVE_AHB2PHY			17
+
+/* SNOC */
+#define MASTER_HMSS			0
+#define MASTER_QDSS_BAM			1
+#define MASTER_SNOC_CFG			2
+#define MASTER_BIMC_SNOC_0		3
+#define MASTER_BIMC_SNOC_1		4
+#define MASTER_A0NOC_SNOC		5
+#define MASTER_A1NOC_SNOC		6
+#define MASTER_A2NOC_SNOC		7
+#define MASTER_QDSS_ETR			8
+#define SLAVE_A0NOC_SNOC		9
+#define SLAVE_A1NOC_SNOC		10
+#define SLAVE_A2NOC_SNOC		11
+#define SLAVE_HMSS			12
+#define SLAVE_LPASS			13
+#define SLAVE_USB3			14
+#define SLAVE_SNOC_BIMC			15
+#define SLAVE_SNOC_CNOC			16
+#define SLAVE_IMEM			17
+#define SLAVE_PIMEM			18
+#define SLAVE_SNOC_VMEM			19
+#define SLAVE_SNOC_PNOC			20
+#define SLAVE_QDSS_STM			21
+#define SLAVE_PCIE_0			22
+#define SLAVE_PCIE_1			23
+#define SLAVE_PCIE_2			24
+#define SLAVE_SERVICE_SNOC		25
+
+#endif
diff --git a/include/dt-bindings/sound/qcom,wcd9335.h b/include/dt-bindings/sound/qcom,wcd9335.h
new file mode 100644
index 000000000000..f5e9f1db091e
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,wcd9335.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_SOUND_QCOM_WCD9335_H
+#define __DT_SOUND_QCOM_WCD9335_H
+
+#define AIF1_PB                 0
+#define AIF1_CAP                1
+#define AIF2_PB                 2
+#define AIF2_CAP                3
+#define AIF3_PB                 4
+#define AIF3_CAP                5
+#define AIF4_PB                 6
+#define NUM_CODEC_DAIS          7
+
+#endif

-- 
2.42.1

