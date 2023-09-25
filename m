Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8D1CE7A8C
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BDD86BCF;
	Mon, 25 Sep 2023 17:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Nwbz0PL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 235A886D57; Mon, 25 Sep 2023 17:52:31 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907CC86C06
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivprusov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D689E12000B;
 Mon, 25 Sep 2023 18:52:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D689E12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695657146;
 bh=P5sLefxkAxzz+U5yDD3RLskh7gFgspahP9dsymu8dNQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Nwbz0PL2c8wF/7zr9p5azhhKIbQUT00AkZHe1qzfpYWRkqY/DAEeV+Ox9oGKGMCRJ
 JWso1v00848waVol5URO/wZHUuTQbWJd97TOWjizw8dmQV2DcgcM69pqEMdxLduwqO
 4CGTH4heLrYmbvoIDQrO0l4EYJ+pSv7XAu0hvYQ8Owd3KzmJMJPpOmbVXfUFMdbMeo
 aG3N2weZm9l9n/SLh8Hze1EMk7Qof5nFNhbljVk0tKWyhnEZNW80nEJAy4IF9SrTP8
 RiWVTFmLaMffL7iaPd++ZQ+M9gQswhigOM2PHa+Dq83O3LFmrVJRYxENKnn37DV25J
 hEAwaOKwe2g1A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 25 Sep 2023 18:52:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 25 Sep 2023 18:52:26 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>,
 <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] dt-bindings: clock: Add Amlogic A1 clock bindings
Date: Mon, 25 Sep 2023 18:52:08 +0300
Message-ID: <20230925155209.130671-2-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180104 [Sep 25 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534
 808c2ea49f7195c68d40844e073217da4fa0d1e3,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/25 14:08:00 #21978535
X-KSMG-AntiVirus-Status: Clean, skipped
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

Add clock bindings for Amlogic A1 from linux-next next-20230821.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++++++++++++++++
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +++
 2 files changed, 193 insertions(+)
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
new file mode 100644
index 0000000000..06f198ee76
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PERIPHERALS_CLKC_H
+#define __A1_PERIPHERALS_CLKC_H
+
+#define CLKID_XTAL_IN		0
+#define CLKID_FIXPLL_IN		1
+#define CLKID_USB_PHY_IN	2
+#define CLKID_USB_CTRL_IN	3
+#define CLKID_HIFIPLL_IN	4
+#define CLKID_SYSPLL_IN		5
+#define CLKID_DDS_IN		6
+#define CLKID_SYS		7
+#define CLKID_CLKTREE		8
+#define CLKID_RESET_CTRL	9
+#define CLKID_ANALOG_CTRL	10
+#define CLKID_PWR_CTRL		11
+#define CLKID_PAD_CTRL		12
+#define CLKID_SYS_CTRL		13
+#define CLKID_TEMP_SENSOR	14
+#define CLKID_AM2AXI_DIV	15
+#define CLKID_SPICC_B		16
+#define CLKID_SPICC_A		17
+#define CLKID_MSR		18
+#define CLKID_AUDIO		19
+#define CLKID_JTAG_CTRL		20
+#define CLKID_SARADC_EN		21
+#define CLKID_PWM_EF		22
+#define CLKID_PWM_CD		23
+#define CLKID_PWM_AB		24
+#define CLKID_CEC		25
+#define CLKID_I2C_S		26
+#define CLKID_IR_CTRL		27
+#define CLKID_I2C_M_D		28
+#define CLKID_I2C_M_C		29
+#define CLKID_I2C_M_B		30
+#define CLKID_I2C_M_A		31
+#define CLKID_ACODEC		32
+#define CLKID_OTP		33
+#define CLKID_SD_EMMC_A		34
+#define CLKID_USB_PHY		35
+#define CLKID_USB_CTRL		36
+#define CLKID_SYS_DSPB		37
+#define CLKID_SYS_DSPA		38
+#define CLKID_DMA		39
+#define CLKID_IRQ_CTRL		40
+#define CLKID_NIC		41
+#define CLKID_GIC		42
+#define CLKID_UART_C		43
+#define CLKID_UART_B		44
+#define CLKID_UART_A		45
+#define CLKID_SYS_PSRAM		46
+#define CLKID_RSA		47
+#define CLKID_CORESIGHT		48
+#define CLKID_AM2AXI_VAD	49
+#define CLKID_AUDIO_VAD		50
+#define CLKID_AXI_DMC		51
+#define CLKID_AXI_PSRAM		52
+#define CLKID_RAMB		53
+#define CLKID_RAMA		54
+#define CLKID_AXI_SPIFC		55
+#define CLKID_AXI_NIC		56
+#define CLKID_AXI_DMA		57
+#define CLKID_CPU_CTRL		58
+#define CLKID_ROM		59
+#define CLKID_PROC_I2C		60
+#define CLKID_DSPA_SEL		61
+#define CLKID_DSPB_SEL		62
+#define CLKID_DSPA_EN		63
+#define CLKID_DSPA_EN_NIC	64
+#define CLKID_DSPB_EN		65
+#define CLKID_DSPB_EN_NIC	66
+#define CLKID_RTC		67
+#define CLKID_CECA_32K		68
+#define CLKID_CECB_32K		69
+#define CLKID_24M		70
+#define CLKID_12M		71
+#define CLKID_FCLK_DIV2_DIVN	72
+#define CLKID_GEN		73
+#define CLKID_SARADC_SEL	74
+#define CLKID_SARADC		75
+#define CLKID_PWM_A		76
+#define CLKID_PWM_B		77
+#define CLKID_PWM_C		78
+#define CLKID_PWM_D		79
+#define CLKID_PWM_E		80
+#define CLKID_PWM_F		81
+#define CLKID_SPICC		82
+#define CLKID_TS		83
+#define CLKID_SPIFC		84
+#define CLKID_USB_BUS		85
+#define CLKID_SD_EMMC		86
+#define CLKID_PSRAM		87
+#define CLKID_DMC		88
+#define CLKID_SYS_A_SEL		89
+#define CLKID_SYS_A_DIV		90
+#define CLKID_SYS_A		91
+#define CLKID_SYS_B_SEL		92
+#define CLKID_SYS_B_DIV		93
+#define CLKID_SYS_B		94
+#define CLKID_DSPA_A_SEL	95
+#define CLKID_DSPA_A_DIV	96
+#define CLKID_DSPA_A		97
+#define CLKID_DSPA_B_SEL	98
+#define CLKID_DSPA_B_DIV	99
+#define CLKID_DSPA_B		100
+#define CLKID_DSPB_A_SEL	101
+#define CLKID_DSPB_A_DIV	102
+#define CLKID_DSPB_A		103
+#define CLKID_DSPB_B_SEL	104
+#define CLKID_DSPB_B_DIV	105
+#define CLKID_DSPB_B		106
+#define CLKID_RTC_32K_IN	107
+#define CLKID_RTC_32K_DIV	108
+#define CLKID_RTC_32K_XTAL	109
+#define CLKID_RTC_32K_SEL	110
+#define CLKID_CECB_32K_IN	111
+#define CLKID_CECB_32K_DIV	112
+#define CLKID_CECB_32K_SEL_PRE	113
+#define CLKID_CECB_32K_SEL	114
+#define CLKID_CECA_32K_IN	115
+#define CLKID_CECA_32K_DIV	116
+#define CLKID_CECA_32K_SEL_PRE	117
+#define CLKID_CECA_32K_SEL	118
+#define CLKID_DIV2_PRE		119
+#define CLKID_24M_DIV2		120
+#define CLKID_GEN_SEL		121
+#define CLKID_GEN_DIV		122
+#define CLKID_SARADC_DIV	123
+#define CLKID_PWM_A_SEL		124
+#define CLKID_PWM_A_DIV		125
+#define CLKID_PWM_B_SEL		126
+#define CLKID_PWM_B_DIV		127
+#define CLKID_PWM_C_SEL		128
+#define CLKID_PWM_C_DIV		129
+#define CLKID_PWM_D_SEL		130
+#define CLKID_PWM_D_DIV		131
+#define CLKID_PWM_E_SEL		132
+#define CLKID_PWM_E_DIV		133
+#define CLKID_PWM_F_SEL		134
+#define CLKID_PWM_F_DIV		135
+#define CLKID_SPICC_SEL		136
+#define CLKID_SPICC_DIV		137
+#define CLKID_SPICC_SEL2	138
+#define CLKID_TS_DIV		139
+#define CLKID_SPIFC_SEL		140
+#define CLKID_SPIFC_DIV		141
+#define CLKID_SPIFC_SEL2	142
+#define CLKID_USB_BUS_SEL	143
+#define CLKID_USB_BUS_DIV	144
+#define CLKID_SD_EMMC_SEL	145
+#define CLKID_SD_EMMC_DIV	146
+#define CLKID_SD_EMMC_SEL2	147
+#define CLKID_PSRAM_SEL		148
+#define CLKID_PSRAM_DIV		149
+#define CLKID_PSRAM_SEL2	150
+#define CLKID_DMC_SEL		151
+#define CLKID_DMC_DIV		152
+#define CLKID_DMC_SEL2		153
+
+#endif /* __A1_PERIPHERALS_CLKC_H */
diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
new file mode 100644
index 0000000000..2b660c0f2c
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PLL_CLKC_H
+#define __A1_PLL_CLKC_H
+
+#define CLKID_FIXED_PLL_DCO	0
+#define CLKID_FIXED_PLL		1
+#define CLKID_FCLK_DIV2_DIV	2
+#define CLKID_FCLK_DIV3_DIV	3
+#define CLKID_FCLK_DIV5_DIV	4
+#define CLKID_FCLK_DIV7_DIV	5
+#define CLKID_FCLK_DIV2		6
+#define CLKID_FCLK_DIV3		7
+#define CLKID_FCLK_DIV5		8
+#define CLKID_FCLK_DIV7		9
+#define CLKID_HIFI_PLL		10
+
+#endif /* __A1_PLL_CLKC_H */
-- 
2.34.1

