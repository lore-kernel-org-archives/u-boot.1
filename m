Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4D2C369A0
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 07:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C0D88A43;
	Wed, 25 Sep 2024 09:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0+C7b+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DAB88AD7; Wed, 25 Sep 2024 09:03:56 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F6A8880F
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 09:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxiBxLZ4+s42z7R54IDYuSVJTwRSFzs1S0E8d+8U8Qn7Mr955zCOOmUrIrgcrWnsOZoVRmRQhQL0aXgj3mZ1dWF8esGgK3zQcvozkfgjE4KlUiYUN6FWQ1q0deKXTMxrf0VYP3vmhymy1Ox+3j4mvgGrLKQ50sJUkuvenw0j2wavGICFY3uh+oEzvwAhV3Isc42a2sVHitYtMMyQ9XDF1xuKdWxrhe3Niu9jSRSBsXuNHMymvQQoWwTHcZrvulpVdCSJ/5vcEECQmhderobeooSUXMy6RQw+RCXEsyIgoWtoyLm3F2STtUva0kZlGMxfbmboPh0NHPjOn3d0WvQz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKuuHSnBR1s/RC7pHwu+V3SMgKcnWnxbAz8lNLhcl7Y=;
 b=lurrMTwNwPahPrMsy5mhwp5jX85LUFUXBQK9dXduYCFhLT2rSaVdo5qmcgtB3dPj2kgMlx+aKVmClxsEVAw+29vTBx7Vk1H6mgAvNLMNhkx8Hhz4+Gwk2fESD7WF1n/mhIpiRjHOHRgLLM3SU/H7WvWeFE+AumviVzfa5WTNkboIwPPaG4RD+xur68MY3t9O59JAR/VoJ3sv0TLBjZcJmD5dQUtijG3BjxxuxzXJ9IH4/0+BCRCSsMSRxUtfaNKDbQ8tJqUMXdqrU+k6KE39UCYjXXHVuv8QXgYURh+b0xf4kszITHYahbbEtHuOMCQyx3oFmdlQ24GZbGaKFeLGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKuuHSnBR1s/RC7pHwu+V3SMgKcnWnxbAz8lNLhcl7Y=;
 b=f0+C7b+SOCNw6YWwc8yjpdEaomFeJHtxFVlDG+67mUtrPCk4vgbRWN6dL9+hKnrSB+JX29tELs8HNwVUkEXKPS294BvdQdydLtUlmRxVHGg/vGxnl95uboFLZaQDp7nYjjmvud66CKLy5sqNRrnX81oE4bHtFJaDoZoL4LxmKaA=
Received: from DM6PR06CA0054.namprd06.prod.outlook.com (2603:10b6:5:54::31) by
 CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 07:03:46 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::2c) by DM6PR06CA0054.outlook.office365.com
 (2603:10b6:5:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Wed, 25 Sep 2024 07:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:03:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:03:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm64: zynqmp: Add description for SC on vm-p-m1369 board
Date: Wed, 25 Sep 2024 09:03:38 +0200
Message-ID: <fbc6d56c4aaa33113e35a53520320f4050ed141e.1727247815.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12150; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=xQCbQQr7tI2leqJi3gPHGVmtVe8fHrymndxqRjtMfpg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTPW08L7Jtior5bYm9chdY08alt3BMuNH4y+9du6Jkdu
 T4y5219RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIiivD/PQiduG93rIM3Y90
 b3J377LdKHS2iGF+4tpFxmob+FSDlzL0/Niruzj1gtkjAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: edf6e938-52a4-4340-2cce-08dcdd303292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RXt84rlUs1luUd7AdqYNx9ghX/5G5Odbxnrr5k71RVNgl0ADPDgbj03HusOi?=
 =?us-ascii?Q?wG1QlMWn33qTE3wCsbCGlrsy06P37VHL9sTTS3caRA4TdUbxuvicOQKxRSQD?=
 =?us-ascii?Q?oswc+/ANHIeINgPQsD5o+jlSwzQ2CaO826XuZ/ScaOM0YUDAGvHgGs0g71cB?=
 =?us-ascii?Q?y58MRneMVfA7UYi8cxUQq5DbRn1VCCuygxo+QzVial0c/tOzcGSp7KfnOC8Y?=
 =?us-ascii?Q?NGellrse3H3sIunPz4s3SdHavgT8nZW6I+mAJElCudWtEps6oY2hV9SVIOi3?=
 =?us-ascii?Q?cYrv7riJe/5pXh2F0iHSkW+7OkvyesqeV56tfHLXLC03e/K2i5CQzWvaGFXC?=
 =?us-ascii?Q?l7voBWMih8Ch3N0qXj1DQprsfu/+dd2q9hXs1TPSvl2AyGC1twBq4hxWJV+S?=
 =?us-ascii?Q?h2E/lF8ZhvjTjh1eL1O79GHVIGcoM9H479mfH0Ep6ISF8ECYEC4ouHhiIQrj?=
 =?us-ascii?Q?5Yi24TJ3oNwlyosqtS+ihZDhmY2Lyg6G+3nTPomRg1bvMm/N4ohwyDWhZ4Zu?=
 =?us-ascii?Q?PNhJHMICXo0MHWUJJwo7d7H4vlDvUd9BnTOvzn+nwgjN/6uSaJZs7CMhD907?=
 =?us-ascii?Q?pANj7RoCxUgymA7Nk4uEPey/IpjhuOXRfpKkUQ9E4y7+U6DfmtLQ9ynJehP1?=
 =?us-ascii?Q?XIEB3uWoNRII0hRsmVSmB/KqW1xbNjn8wYtk17Hqj9D8RJsrwdRtV+Dw2gIg?=
 =?us-ascii?Q?XQd9T5aPc2HUArqBSlqk8PAgy7i2tdxDcOwDznAm0fZ8wrznAr/6T2dVzGh9?=
 =?us-ascii?Q?Cj8BdwyD93KDGNtv44D0vcXPyzSvEfyqpxN/JuRLUYAUy0U/MNGDxrfM5hpe?=
 =?us-ascii?Q?5gY8IfN6+yJDKLFrBj1gOFa4vetk8bMM/0OQmd5U+q5XdiFpOt3SBk044zWY?=
 =?us-ascii?Q?+cP8m9QZjmUzo4fJsylDMt1on9cj33scCHMg1QvUzd+uJq5Vs1q+gAGxOFUN?=
 =?us-ascii?Q?1InqiLmpaK/tP3DcveYJ4BljuByq9EMMUMI14JJtmQYXBk+Zr8UBU2p4MJAH?=
 =?us-ascii?Q?gEe5EK06vZ/Oxi0FblOvy4FUYMxrQtYR9YPaDPRG9vu28wyTzDtfyYvmv5qj?=
 =?us-ascii?Q?50Ww6QWxJs67MjwTLF+MCTFg4S/NyzOspT7tG1ri2LrYoJOb0owQkpa7v4gy?=
 =?us-ascii?Q?0oxvbgMpoSlAPcw34VS9i7FmFzV2cIGRlwSh8e85fg/AguC67B7WaBhCPHoh?=
 =?us-ascii?Q?nh82z4It68nbqEKS/0lsjOtvuSZtoQ697wlPGsgmkm7+UyeA5vW/Py+czu3W?=
 =?us-ascii?Q?jYRQ2EMvcynvlbV52IsDOCRHmS/Askx2CAkT5rNNWPyBlm1DcxzHEsQzXRjD?=
 =?us-ascii?Q?VQ4fn3CKOy5fDjKfASKzQriSU72YN+epxgkTBWTAgD7vMDQiwTCWJBH9fPVF?=
 =?us-ascii?Q?CvHvsR1Mdlzul2IVm/L4ojYF/cqKY/4HovutC6F3OIeSVeMSnFmSQSSrOBWT?=
 =?us-ascii?Q?gYPX+ZorNaRPEF5LVLHYG2tIiyJI53j3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:03:45.5439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf6e938-52a4-4340-2cce-08dcdd303292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
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

Board is very similar to vn-p-b2197 with subset of functinality.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/Makefile                         |   2 +
 .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 400 ++++++++++++++++++
 2 files changed, 402 insertions(+)
 create mode 100644 arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b3fe3f3c535b..96026c545916 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -327,6 +327,7 @@ zynqmp-sc-vpk120-revB-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vpk120-revB.dtbo
 zynqmp-sc-vpk180-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vpk180-revA.dtbo
 zynqmp-sc-vpk180-revB-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vpk180-revB.dtbo
 zynqmp-sc-vn-p-b2197-00-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vn-p-b2197-00-revA.dtbo
+zynqmp-sc-vm-p-b1369-00-revA-dtbs := zynqmp-sc-revB.dtb zynqmp-sc-vm-p-m1369-00-revA.dtbo
 
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vek280-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vek280-revB.dtb
@@ -335,6 +336,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vpk120-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vpk180-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vpk180-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vn-p-b2197-00-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sc-vm-p-b1369-00-revA.dtb
 
 zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
 zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
diff --git a/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
new file mode 100644
index 000000000000..8412aecd726c
--- /dev/null
+++ b/arch/arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP VM-P-M1369-00
+ *
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sc-vm-p-m1369-revA",
+		     "xlnx,zynqmp-sc-vm-p-m1369", "xlnx,zynqmp";
+
+	ina226-u19 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_soc_ina 0>, <&vcc_soc_ina 1>, <&vcc_soc_ina 2>;
+	};
+	ina226-u287 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_ram_ina 0>, <&vcc_ram_ina 1>, <&vcc_ram_ina 2>;
+	};
+	ina226-u288 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_pslp_ina 0>, <&vcc_pslp_ina 1>, <&vcc_pslp_ina 2>;
+	};
+	ina226-u289 {
+		compatible = "iio-hwmon";
+		io-channels = <&vccaux_ina 0>, <&vccaux_ina 1>, <&vccaux_ina 2>;
+	};
+	ina226-u290 {
+		compatible = "iio-hwmon";
+		io-channels = <&vccaux_pmc_ina 0>, <&vccaux_pmc_ina 1>, <&vccaux_pmc_ina 2>;
+	};
+	ina226-u291 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_500_ina 0>, <&vcco_500_ina 1>, <&vcco_500_ina 2>;
+	};
+	ina226-u292 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_501_ina 0>, <&vcco_501_ina 1>, <&vcco_501_ina 2>;
+	};
+	ina226-u293 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_502_ina 0>, <&vcco_502_ina 1>, <&vcco_502_ina 2>;
+	};
+	ina226-u294 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcco_503_ina 0>, <&vcco_503_ina 1>, <&vcco_503_ina 2>;
+	};
+	ina226-u295 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_ddr5_rdimm_ina 0>, <&vcc_ddr5_rdimm_ina 1>, <&vcc_ddr5_rdimm_ina 2>;
+	};
+	ina226-u298 {
+		compatible = "iio-hwmon";
+		io-channels = <&lp5_1v0_ina 0>, <&lp5_1v0_ina 1>, <&lp5_1v0_ina 2>;
+	};
+	ina226-u296 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_fmc_ina 0>, <&vcc_fmc_ina 1>, <&vcc_fmc_ina 2>;
+	};
+	ina226-u299 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtm_avcc_ina 0>, <&gtm_avcc_ina 1>, <&gtm_avcc_ina 2>;
+	};
+	ina226-u300 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtm_avtt_ina 0>, <&gtm_avtt_ina 1>, <&gtm_avtt_ina 2>;
+	};
+	ina226-u301 {
+		compatible = "iio-hwmon";
+		io-channels = <&gtm_avccaux_ina 0>, <&gtm_avccaux_ina 1>, <&gtm_avccaux_ina 2>;
+	};
+	ina226-u297 {
+		compatible = "iio-hwmon";
+		io-channels = <&vcc_mipi_ina 0>, <&vcc_mipi_ina 1>, <&vcc_mipi_ina 2>;
+	};
+};
+
+&i2c1 { /* i2c_main bus */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* u97 eeprom at 0x54 described in sc-revB - WP protection via BOARD_EEPROM_WP - J1801 */
+
+	/* i2c_main_1 - u72 - j108 - disable translation, add 8 */
+	/* J133 - OE for u91@55 + 8 - 161,132813MHz - QSFP56G_0 */
+	qsfp56g_0_clk: clock-controller@5d {
+		compatible = "renesas,proxo-xp";
+		reg = <0x5d>;
+		#clock-cells = <0>;
+		clock-output-names = "qsfp56g_0_clk";
+	};
+
+	/* J134 - OE for u92@57 + 8 - 322,265625MHz - QSFP56G_1 */
+	qsfp56g_1_clk: clock-controller@5f {
+		compatible = "renesas,proxo-xp";
+		reg = <0x5f>;
+		#clock-cells = <0>;
+		clock-output-names = "qsfp56g_1_clk";
+	};
+
+	/* i2c_main_2 - u74 - j110 - disable translation, add 9 */
+	/* J210 - OE for u164@50 + 9 - 320MHz - CH2_LP5 */
+	ch2_lpddr5_refclk: clock-controller@59 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x59>;
+		#clock-cells = <0>;
+		clock-output-names = "ch2_lpddr5_refclk";
+	};
+
+	/* i2c_main_3 - u76 - j112 - disable translation, add 6 */
+	/* J231 - OE for u165@50 + 6  - 320MHz - _RDIMM */
+	ddr5_dimm1_refclk: clock-controller@56 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x56>;
+		#clock-cells = <0>;
+		clock-output-names = "ddr5_udimm_refclk";
+	};
+
+	/* i2c_main_4 - u73 - j109 - disable translation, add 5 */
+	/* J117 - OE for u82@50 + 5 - 33,3333MHz - PS_REFCLK */
+	ps_refclk: clock-controller@55 {
+		compatible = "renesas,proxo-xp";
+		reg = <0x55>;
+		#clock-cells = <0>;
+		clock-output-names = "ps_refclk";
+	};
+
+	/* J71 - selection to LP_I2C_SCL_J or LP_I2C_PMC_SCL_J */
+	/* J70 - selection to LP_I2C_SDA_J or LP_I2C_PMC_SDA_J */
+	/* this should be SW controlable too */
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* u134 tps544b25 but connected to J178 connector */
+	/* u48/IMx3112/0x77 -  1:2 multiplexer - also accessed from Versal NET */
+	/* Connection DDR5_UDIMM - SPD can be from 0x50-0x57 */
+	/* FIXME gpio should handle SYSCTLR_PMBUS_ALERT and also INA226_PMBUS_ALERT */
+	/* Access to i2c_pmc bus via u49 with OE j100 or via SYSCTLR_I2C_PMC_EN */
+
+	/* ina226_pmbus - J103 - disable INA226_PMBUS */
+	vcc_soc_ina: power-monitor@40 { /* u19 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x40>;
+		shunt-resistor = <1000>; /* R222 */
+	};
+
+	vcc_ram_ina: power-monitor@41 { /* u287 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x41>;
+		shunt-resistor = <1000>; /* R32981 */
+	};
+
+	vcc_pslp_ina: power-monitor@42 { /* u288 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x42>;
+		shunt-resistor = <1000>; /* R32984 */
+	};
+
+	vccaux_ina: power-monitor@43 { /* u289 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x43>;
+		shunt-resistor = <1000>; /* R32987 */
+	};
+
+	vccaux_pmc_ina: power-monitor@44 { /* u290 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x44>;
+		shunt-resistor = <1000>; /* R32990 */
+	};
+
+	vcco_500_ina: power-monitor@45 { /* u291 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x45>;
+		shunt-resistor = <1000>; /* R32993 */
+	};
+
+	vcco_501_ina: power-monitor@46 { /* u292 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x46>;
+		shunt-resistor = <1000>; /* R32996 */
+	};
+
+	vcco_502_ina: power-monitor@47 { /* u293 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x47>;
+		shunt-resistor = <1000>; /* R32999 */
+	};
+
+	vcco_503_ina: power-monitor@48 { /* u294 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x48>;
+		shunt-resistor = <1000>; /* R33002 */
+	};
+
+	vcc_ddr5_rdimm_ina: power-monitor@49 { /* u295 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x49>;
+		shunt-resistor = <1000>; /* R33005 */
+	};
+
+	lp5_1v0_ina: power-monitor@4a { /* u298 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4a>;
+		shunt-resistor = <1000>; /* R33014 */
+	};
+
+	vcc_fmc_ina: power-monitor@4b { /* u296 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4b>;
+		shunt-resistor = <1000>; /* R33008 */
+	};
+
+	gtm_avcc_ina: power-monitor@4c { /* u299 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4c>;
+		shunt-resistor = <1000>; /* R33017 */
+	};
+
+	gtm_avtt_ina: power-monitor@4d { /* u300 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4d>;
+		shunt-resistor = <1000>; /* R33020 */
+	};
+
+	gtm_avccaux_ina: power-monitor@4e { /* u301 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4e>;
+		shunt-resistor = <1000>; /* R33023 */
+	};
+
+	vcc_mipi_ina: power-monitor@4f { /* u297 */
+		compatible = "ti,ina226";
+		#io-channel-cells = <1>;
+		reg = <0x4f>;
+		shunt-resistor = <1000>; /* R33011 */
+	};
+
+	/* pmbus - j105 - disable main PMBUS - also going to j102 connector */
+	vcc_pslp: regulator@15 { /* u24 */
+		compatible = "ti,tps546b24a";
+		reg = <0x15>;
+	};
+
+	vccaux_pmc: regulator@17 { /* u26 */
+		compatible = "ti,tps546b24a";
+		reg = <0x17>;
+	};
+
+	vcco_500: regulator@18 { /* u27 */
+		compatible = "ti,tps546b24a";
+		reg = <0x18>;
+	};
+
+	vcco_501: regulator@19 { /* u28 */
+		compatible = "ti,tps546b24a";
+		reg = <0x19>;
+	};
+
+	vcco_502: regulator@1a { /* u29 */
+		compatible = "ti,tps546b24a";
+		reg = <0x1a>;
+	};
+
+	vcco_503: regulator@1b { /* u30 */
+		compatible = "ti,tps546b24a";
+		reg = <0x1b>;
+	};
+
+	vcc_ddr5_rdimm: regulator@1c { /* u31 */
+		compatible = "ti,tps546b24a";
+		reg = <0x1c>;
+	};
+
+	gtm_avcc: regulator@22 { /* u37 */
+		compatible = "ti,tps546b24a";
+		reg = <0x22>;
+	};
+
+	gtm_avtt: regulator@20 { /* u38 */
+		compatible = "ti,tps546b24a";
+		reg = <0x20>;
+	};
+
+	gtm_avccaux: regulator@21 { /* u39 */
+		compatible = "ti,tps546b24a";
+		reg = <0x21>;
+	};
+
+	vccint_gt: regulator@2a { /* u44 */
+		compatible = "ti,tps546b24a";
+		reg = <0x2a>;
+	};
+
+	util_1v8: regulator@2b { /* u1839 */
+		compatible = "ti,tps546b24a";
+		reg = <0x2b>;
+	};
+
+	vcc_pmc: regulator@2c { /* u46 */
+		compatible = "ti,tps546b24a";
+		reg = <0x2c>;
+	};
+
+	/* pmbus via U62 as ext_pmbus - disable via j104 */
+	vccint: regulator@10 { /* u18 */
+		compatible = "ti,tps546b24";
+		reg = <0x10>;
+	};
+
+	vccsoc: regulator@11 { /* u20 */
+		compatible = "ti,tps546b24";
+		reg = <0x11>;
+	};
+
+	vcc_io: regulator@12 { /* u21 */
+		compatible = "ti,tps546b24";
+		reg = <0x12>;
+	};
+
+	vcc_psfp: regulator@13 { /* u22 */
+		compatible = "ti,tps546b24";
+		reg = <0x13>;
+	};
+
+	vcc_ram: regulator@14 { /* u23 */
+		compatible = "ti,tps546b24";
+		reg = <0x14>;
+	};
+
+	vccaux: regulator@16 { /* u25 */
+		compatible = "ti,tps546b24";
+		reg = <0x16>;
+	};
+
+	lp5_1v0: regulator@1d { /* u32 */
+		compatible = "ti,tps546b24";
+		reg = <0x1d>;
+	};
+
+	vcc_fmc: regulator@1e { /* u33 */
+		compatible = "ti,tps546b24";
+		reg = <0x1e>;
+	};
+
+	lp5_vdd1: regulator@25 { /* u40 */
+		compatible = "ti,tps546b24";
+		reg = <0x25>;
+	};
+
+	lp5_vdd2: regulator@26 { /* u41 */
+		compatible = "ti,tps546b24";
+		reg = <0x26>;
+	};
+
+	lp5_vddq: regulator@27 { /* u42 */
+		compatible = "ti,tps546b24";
+		reg = <0x27>;
+	};
+
+	vcco_hdio: regulator@29 { /* u43 */
+		compatible = "ti,tps546b24";
+		reg = <0x29>;
+	};
+
+	vcc_mipi: regulator@1f { /* u47 */
+		compatible = "ti,tps546b24";
+		reg = <0x1f>;
+	};
+
+	/* connected via J425 connector
+	 ucd90320: power-sequencer@73 { // u16
+		compatible = "ti,ucd90320";
+		reg = <0x73>;
+	};*/
+};
-- 
2.43.0

