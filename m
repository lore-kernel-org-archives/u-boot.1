Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85516C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8306184A47;
	Mon, 29 Jun 2026 11:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgCNs0fP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA2384A4B; Mon, 29 Jun 2026 11:47:07 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 188A584A1F
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC8PoEuRs7WJVm6dxErbw4WdvEKuF9hmpqWO8H+TGpOYqup/XJ5z+OreKrqPs+218fkuAcxiYhCQOCZKVmFX1MWF/mMNuHUyaZHyzvxfFXBiz6Q14GekXZUYi5kP8RONIot4I7rm3LDy6qMOhG9f7teCRHnxxJ0ZUiA5Xj3i4rge9SS+YPEzeoj/Hn//0z+QRQ7ZmppzEyd/HRo2rX9PkpJeBiv9Nd/a1aOpo8Fe+aPWEZ7PiRpEOorI5zOhUZBvVh2KKT2Vh0Q9plZX8l2pam+3vtWkCM5SF3AaUwFkhsDYa4h+3BoW1hRdtfNFnpkjOM7YuMElKKYvGArUhHoV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf+7saEKIW5lkp71QCJY3Z+XSqAdWCMOzoIPLp4AFZk=;
 b=u3ZgQlUBdDp3qn2uj7pBXY73T2HUv4AbO8olQL6ofl1LMPykSvLYGhCIeuBHFIZ+zraIpL6ukEVGvd/R8SpWZrawJHX1AyuvUXo9Wre/87r9X43sEJF1WjWlfU+XgAE6x5j9y/HldTUVzyeAvolg55Y/YKKxH8xTBiYNglGhz1gN+huH2ufCo4HV94At5yLjkcpfXZn/B20jGuI1cab6FoF5QJS6PAwT4WGgXqUKtHWpp/r/vUjLgKgKElHRXVbr+9NYYSE38LKVZC1YBySTw+iE0REWrou2usyZvv74Uvt7NdRXCUc71ERTa1Kp+u4xpnVfRVhEY43GuElcaDqv5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf+7saEKIW5lkp71QCJY3Z+XSqAdWCMOzoIPLp4AFZk=;
 b=wgCNs0fPdWb4BvZN1ssg7QWIRExdH5rw5t9OT22jOVNl48sCXaQR0ZYMXzHrIMrjyx17xvdKCGlkV5cgUz0Bp2t62iTLLamEwN2vWuEKRnl3ZwgJ96udFdUgaZuzjWu/IhUR1UZvC/VZeKupEt6dq5OQwq6DHQ7WGOCb010Qz2g=
Received: from CYXPR03CA0014.namprd03.prod.outlook.com (2603:10b6:930:d0::13)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 09:46:53 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:d0:cafe::20) by CYXPR03CA0014.outlook.office365.com
 (2603:10b6:930:d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:46:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:46:50 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 04:46:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Harini T <harini.t@amd.com>, Neal Frager <neal.frager@amd.com>, "Quanyang
 Wang" <quanyang.wang@windriver.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] arch: arm: dts: Add RTC clock nodes for ZynqMP platform
Date: Mon, 29 Jun 2026 11:46:33 +0200
Message-ID: <8838c8c4fcd0dfe151bcee2a6c4da51df81e23cb.1782726386.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782726386.git.michal.simek@amd.com>
References: <cover.1782726386.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eQg1aUuX6Q6xoZbz8LwMV2yDI/6/tmtXMbEMlHzEfUw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ52f29/MT8o9WkTR7P1TJ9V6WafMhT3+87sWzZm8n2J
 z2PCEkwdZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE/oow/NOLuBl6JvZV2IsD
 TNGawf/E98yoMfeYnWW4U+HApe+ZUc5AFbK1Bdcs+VL9rzkothiWzmx+Y9OwYtrJ5B9T/q17eOg
 eJwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1b99a9-b78d-4fdf-67fb-08ded5c35962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XwgQzJBp+AcWdLx0aPwT82P9B8Vhh4DLFAH19BR2O0CPbAPhpblF0N2mVBbp+n7AKfs8adg/TXaUJT3bMbQoVCizELPlcL2sR9hLDCntu1y2QNzgJOh1GA2/0hyHtt/VptzKmh1NbTprk2Xj9cBIANfVh+efacE9IIefnnsfp8VDibAfHz6DL2ORr3O1kWgqk2FgNeUrzFeTCddjnIUzp4EvwsHmpx+gHG7n/6F7PPDMuPnPXT3zPGySCKIWvSuR60JCifdhI2BjMYOB6JFLDUNSoDx1fdL1W3iMyDG0o4Y4Ia5CgeCcsVjm8M0cvVa/rkASsogF07N8iiBq2yOVV2uNiKvLOV441jKwY+SNUgLiD2sWje8ZXf3OKeabwA3OsYQCmcdlEDv69KhpyHE7AgKze+JP2+RLHbRVfiBOeyHio5bd8m2yM2/HVVL3FVrejIRmOypU7miGjpndmSj2zugiPOcgeusgoC78ge7RVzb0i4A6lQL03gTdAQwimchr/jSZM+/llPNi6/s/Sk+2u9Gn5vMjaLDOGPEIZ+FiQpwNHNsqim141OLA+NGFvoGT1WnBU9V40A5pni8KEbMyiiRx+PJ2V7vbA9HDBFlOubKbA7GOpb8O0k2IBYj5Td6oA2qpSfljqpQj7bQO8EI4XuxnfSY8SEPwIWpjrpf49OVE66V9QTyoNQUCfFkPrY3Vrivct/vnvN2vyUWZw5x8zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +K+Q2k5aSAF7Tx9S7n+j3z7CR1Z9j8Inm/M+3QNaxnIej2ht9Unz5zJh5jO286bvU9wgpzjbjj7NjiaOidSnFivgF/uJvRjMbWURENgvEqPCf2LBe9NmYPX70taTRNFsa42XHch9P3pIT6CxMOe7f/w6FCi1U4UY+91xT2yMSNgNiDpgOiWWR1wFW1Rd5r3leQD5uxFpJQdcO4dZ6WW7MpKajtGdeAauMO/Zj0dFxkf/UHjTIFv2xY7yuXJXYXN3nFq6HOqT8XB8KY6NXbkLmFwR56JvDRlb2KilqSTIMy3qv00QPq10SrF9addDFZRer28t/0jmTbCy2wPn+4ci0kl2YBnRV9vHD7nMMdkJj3P2Ux1iB4t6WLAR51b9gd2/tuDSoISs2uGVqYVhLUIFL9O+d5EmrAh2NaD7lK7nMfPIygWPkiM0EDecipXZm+SJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:46:52.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1b99a9-b78d-4fdf-67fb-08ded5c35962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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

From: Harini T <harini.t@amd.com>

Add fixed RTC clock nodes at 32.768 kHz for ZynqMP. The RTC driver uses
this clock to calculate the calibration value, replacing the deprecated
calibration device tree property.

Signed-off-by: Harini T <harini.t@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-clk-ccf.dtsi | 15 ++++++++++++++-
 arch/arm/dts/zynqmp.dtsi         |  1 -
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index 482f432ba7f3..877962df2b36 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -3,7 +3,7 @@
  * Clock specification for Xilinx ZynqMP
  *
  * (C) Copyright 2017 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -49,6 +49,14 @@
 		clock-frequency = <27000000>;
 		clock-output-names = "aux_ref_clk";
 	};
+
+	rtc_clk: rtc-clk {
+		bootph-all;
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "rtc_clk";
+	};
 };
 
 &zynqmp_firmware {
@@ -302,3 +310,8 @@
 			  <&zynqmp_clk DP_AUDIO_REF>,
 			  <&zynqmp_clk DP_VIDEO_REF>;  /* rpll, rpll, vpll */
 };
+
+&rtc {
+	clocks = <&rtc_clk>;
+	clock-names = "rtc";
+};
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 13cfca666572..c225eb219f4c 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1006,7 +1006,6 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "alarm", "sec";
-			calibration = <0x7FFF>;
 		};
 
 		sata: ahci@fd0c0000 {
-- 
2.43.0

