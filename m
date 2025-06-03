Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAC0C5AE59
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 01:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0B681E25;
	Wed,  4 Jun 2025 03:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DnXjFYpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA40F8283E; Tue,  3 Jun 2025 22:47:06 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EA382103
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 22:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=donalds@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd/WmOvmcXbYNdD66sQkeNbV/opZc2MgBa3zNrL6dKM4wHtntw+vxaYJidDfnnWmYTNpPGXh5VT8BAthCrlSWA/y9tXopORiLBjUElYke22gpaWe+jTRVAFh+FD0phZIxD0EE5mx/rCTK6mxvLwVtovaSvxp4SC2uoOJS4zANe3TCxLbo2dj5+MN6T0BMoKVzuUdD4jncdJIHOSi6LyUysFN0nZjKHCFe27SRtOTCSHw6DS4CB9pu+ZOQYNRJww2Gz4N3kBYqvVxbxcUm9Ke5gwKsZ3y4tIvfIn+0ckdibsW1QAAqkOvvw5FexOYpHmFBikCmYiixrynn0Fmy8CReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7DpUnnYvNUr5NUYNBcFnYFNEtsrw8U+BB1figKMiiw=;
 b=EyJLdxdgwOyc9HAWVBCpD5Hp6g1028Sd13O2XOIoojnCv95Beg4lIiDCb+pORwvysmIDFJhEAdnkrOsrT0n639SYCh/7SqcbksOxfSr9x8SbE4y7WfzXZHOpbnautnmE6nY2kmL0ps34bLSwNxTPTXmFUe1pQmGNkdhOIcxs8iLsNS323oj0koZdwv+MRki4IiktWrbbSBVup/oJoU2oQNwBW+HD43KA2xb6HuOyhBkWzncWskeah8BXVRe6NiB/P3ndVdDRI0hQqxi56HwyLe/gDZ2WssXZu9GtDhqGSdHNbSPkLP9DYR5WRpMBtdd0nuCN87OPmvPs7LJBMO9w7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=aribaud.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7DpUnnYvNUr5NUYNBcFnYFNEtsrw8U+BB1figKMiiw=;
 b=DnXjFYpmyneKTP79tXTGJsLPd6j3ZyqUEqtktNwyVk/kCWdfQf0/+m4WAQEpj3iKICYmvYvz0bN3G0gllNuNdRSDbSblamVw4fOY/nT3e0xcBx0F7VlgI96TRUeL2+q04dkNmAYKLEgbLLVMAXxOZwQBm+aoE5L4EZQgyrBHEAJUBkcFAiSldOdnMlxJUSJrNgN+/ZxNKNUtoV0OztBrXzBx51vAtt4nX9USajw96mopzTztcs5EY78UvNCKnHwFp8TakvSLMOLZ4PCliLmDxYS9P/L5yH/ofs700SVKWXt19xKRNXolDSVHP1tJQeMv/o5t/IQ2oAaD1KozQwIXxg==
Received: from BYAPR06CA0019.namprd06.prod.outlook.com (2603:10b6:a03:d4::32)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 20:46:59 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::34) by BYAPR06CA0019.outlook.office365.com
 (2603:10b6:a03:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 3 Jun 2025 20:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Tue, 3 Jun 2025 20:46:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 13:46:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 3 Jun 2025 13:46:48 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 3 Jun 2025 13:46:48 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <albert.u.boot@aribaud.net>
CC: <andrew@codeconstruct.com.au>, <donalds@nvidia.com>,
 <peteryin.openbmc@gmail.com>, <wthai@nvidia.com>, <dkodihalli@nvidia.com>,
 <etanous@nvidia.com>, <u-boot@lists.denx.de>
Subject: [PATCH] ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b
Date: Tue, 3 Jun 2025 13:46:46 -0700
Message-ID: <20250603204646.737531-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: f1229239-32a8-441f-7624-08dda2dfc8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ctVQ4/xkJ84Su0XcM5XNWYBk15RYWy52zm23dDlsZb/vDcTK6lp63BlKBHCL?=
 =?us-ascii?Q?ror5v0pwgUN6sZikd8w3vew6AW04uPw7JqCCfK4GjPeqOlLNQJ9BBHBEjNnv?=
 =?us-ascii?Q?xkdVgZyYcF8Oi9vo0M4hkWryI0b1eeg+RAWbN790Ie1+i94YH22c6howuWym?=
 =?us-ascii?Q?wy9o43CYuq+eGpn/2r7uFbZw/k1xDiopjEAkb12a9xJHUMxMP3SNlE3nFyGZ?=
 =?us-ascii?Q?CYn/Jpg4OYDHWv8Zwtcxog4zdoDq5o9HRKeW/o2Am5SHJue5oWNulGQyrgLK?=
 =?us-ascii?Q?IR79tMhfP8QWr1o8MCqa455BQMzgtx9ckaCiOe+2vEpeD/Ik9KVQvdX1oWXX?=
 =?us-ascii?Q?eZ2WRpOaiC5YyMyVeD8YGfUzvb7W3i8g4P3SkYYefBs5nIMKvdUNeoehsgC8?=
 =?us-ascii?Q?YT0h0oRXd0pIx7eSXeyTFFfrI4x2nxD7OzQYiZYxkVtnUaQOFJ10Ky1FwcRI?=
 =?us-ascii?Q?flyFLz5Zs+4qrtve0cuIK3la9MWZP6tgYXhPqiLPlngsQYXqzDccwzYv5g8g?=
 =?us-ascii?Q?9X0cxSlb9/8ShXAvvuedIkiaKcel2vC9fD5UaOFSxolIJMOzo+YpDwOxG3Iw?=
 =?us-ascii?Q?7x3J7eTs14pop+qoVACOGSgV547yJFcDO/aQNms/fx45oGxK5cX3Lxv7GAk0?=
 =?us-ascii?Q?/vnLpZW/EETuJpXh/QF/B1y9UNNtgP6VcpeF/RHyfO/Hbxm9s4fecdrS/tSk?=
 =?us-ascii?Q?U7vW62eSUIQ8y8fItq89z8qexNkFB+rlVcaaIZWduFmIjze3PCXDpT3eHhCP?=
 =?us-ascii?Q?zmMpK3//yh3zVw8dY0UGiNK59WTUY9I/GGKFmQBwwUV3nRgk+f8XLFMDe+ab?=
 =?us-ascii?Q?NuMhIZljpGm7b5IaLLTPSYtME1PsS9xFrosBxV88zzSN2Uc88yMmFc6sJaDh?=
 =?us-ascii?Q?NBKP028lsSmgi6R/EXANCSagLwiSXFOLrBzzh5TY991h7m54VxURQy/s6Zx5?=
 =?us-ascii?Q?Hdqvck8tdxvXW/eo52RgUABBFiatwSDD4/mzrTBm2vK7H8yu27WvrTEXCxlJ?=
 =?us-ascii?Q?wwPJZR/pADL9ZaCNVd8VUYcniKZoMzZYG6kYarJb9gZ/PzU+0ioxyzAYBhVL?=
 =?us-ascii?Q?PFXBaep35p+Fskt1y5yU9Csatq/keZwWpYhtL1c0gRiTO/tDwUK35UdmcA0N?=
 =?us-ascii?Q?pH3XxvfslbdJJByOcrAQeTubkt0mMZhQbVBuhDDC4ul2OAnPVXY+jWkyp6L7?=
 =?us-ascii?Q?Heg51kkRsMIG61r6I5RSXcoLd3RzY3kfYRnewbHKtfaPTeeI+lYPr4UFvV3f?=
 =?us-ascii?Q?Gh2VQcOEKYRMLiqrnApLWfkgvy7+Hukl8jiyFPf6FuBvnOITIYiBSR84FuB1?=
 =?us-ascii?Q?1XmDDXYFv7HLqqBvMWiUd01iMHQeRwlx6efA3S9E3Ny57Mxe4knJedQD1U6V?=
 =?us-ascii?Q?Xy1x9CtJB7a8fs3w+nio2tDdYOQxf9cKqlTXw/U5k0ykBawjCsO17dQvmDJ9?=
 =?us-ascii?Q?syGgkPjI6meGiHntccscauJXxoPC8unL4Cpnp8d6JIdUhXmIFSxrR12bt0T1?=
 =?us-ascii?Q?xeO9AbA/bX5tyLtsUoOnaKx9dB34UOcsRmDCSNIY3yqOThFrljsCw6WuyA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 20:46:58.6868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1229239-32a8-441f-7624-08dda2dfc8dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
X-Mailman-Approved-At: Wed, 04 Jun 2025 03:06:50 +0200
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

GB200 is an Aspeed 2600 based BMC+baseboard for NVIDIA's Blackwell GB200
platform

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]

Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
 arch/arm/dts/Makefile                       |   1 +
 arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts | 235 ++++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dbb2fafc4f..92a529e8f5 100755
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -688,6 +688,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	ast2600-evb.dtb \
 	ast2600-facebook.dtb \
 	ast2600-fpga.dtb \
+	ast2600-gb200-ut30b-nvidia.dtb \
 	ast2600-gb200nvl-bmc-nvidia.dtb \
 	ast2600-greatlakes.dtb \
 	ast2600-intel.dtb \
diff --git a/arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts b/arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts
new file mode 100644
index 0000000000..c7d86de76b
--- /dev/null
+++ b/arch/arm/dts/ast2600-gb200-ut30b-nvidia.dts
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "ast2600-u-boot.dtsi"
+
+/ {
+	model = "AST2600 GB200 UT3.0b BMC";
+	compatible = "nvidia,gb200nvl-bmc", "aspeed,ast2600";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	aliases {
+		mmc0 = &emmc_slot0;
+		mmc1 = &sdhci_slot0;
+		mmc2 = &sdhci_slot1;
+		spi0 = &fmc;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+		ethernet3 = &mac3;
+	};
+
+	cpus {
+		cpu@0 {
+			clock-frequency = <800000000>;
+		};
+		cpu@1 {
+			clock-frequency = <800000000>;
+		};
+	};
+};
+
+&uart5 {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&sdrammc {
+	clock-frequency = <400000000>;
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&wdt3 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio1_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
+&fmc {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fmcquad_default>;
+
+	flash@0 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@1 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@2 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default &pinctrl_spi1abr_default
+			&pinctrl_spi1cs1_default &pinctrl_spi1wp_default
+			&pinctrl_spi1wp_default &pinctrl_spi1quad_default>;
+
+	flash@0 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@1 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "disabled";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default &pinctrl_spi2cs1_default
+			&pinctrl_spi2cs2_default &pinctrl_spi2quad_default>;
+	num-cs = <1>;
+	flash@0 {
+		compatible = "spi-flash", "sst,w25q256";
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+};
+
+&i2c4 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c5_default>;
+};
+
+&i2c5 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c6_default>;
+};
+
+&i2c6 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c7_default>;
+};
+
+&i2c7 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c8_default>;
+};
+
+&i2c8 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c9_default>;
+};
+
+&i2c10 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c11_default>;
+};
+
+&pcie_phy1 {
+	status = "okay";
+};
+
+&pcie_bridge {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&scu {
+	mac0-clk-delay = <0x10 0x0a
+			  0x10 0x10
+			  0x10 0x10>;
+	mac1-clk-delay = <0x10 0x0a
+			  0x10 0x10
+			  0x10 0x10>;
+	mac2-clk-delay = <0x08 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+	mac3-clk-delay = <0x08 0x04
+			  0x08 0x04
+			  0x08 0x04>;
+};
+
+&hace {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&acry {
+	u-boot,dm-pre-reloc;
+	status = "okay";
+};
+
+&display_port {
+	status = "okay";
+};
-- 
2.43.0

