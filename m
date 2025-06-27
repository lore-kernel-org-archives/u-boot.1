Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F82C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3152D82E52;
	Fri, 27 Jun 2025 11:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1TV7acSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C3F82E9A; Fri, 27 Jun 2025 11:21:01 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA2082E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLQuZL54IWZW1jr80Z7WVAU22bJHtecSDzl8QOeKJ0+0u3wzELagCj9ESGdTS1bk0x3OuNDiRg1wAQguA2BiAqsIsSuZmusRDcHcq06OL4tzhriMt1V5VUm0VRiN8Z55LpIbZGTU0XPjHwM9RRxRtJZgQPbc7wKZYapDyQ76YJuGbfnnVDEdq0NyGgi9n5mxCKmoN4/FJzPBdwtF6jMUWApONK3+Jr8x/78G5KkdINUJaen98Hk+uuXFIpYo4S8MLsmbs2iXV6dgtYrKKt2LApMBK4Vj+Jc+mCBXEn0DP1sRs6WnLRy6YnWXTvsXx5DRTtzhFHYWvQhbCCL1CRBNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKYf/KcQ81MpGww48XR1/n4+kn/DAD4ivAuva0j7cJg=;
 b=GbSCrPJAcgPAXkpupX8r7o3bO7EK32v0/bvL/bACisprEpfW+mII7ddydnhEbXrmU4OuUIyYYBH63YMqXR+hwG4a89S6HqcumDV9zHJvHiG5tnZTY80ZX7/1GqV3fd8haRB7W9d7P9Ch+seclscJDbQHDhvADbANxscgO2p+RRs/s+O+f0lltcuKUpS43uuGhXIlw5llfyQuAW34KxJ4F70Zl0bCSSQW5qCVARf46X/kkX1ERm/C6BpnQ4OvpRpaYxq/eh3lrSs2tZW83gGUvhjyVgrqw2SNwM+LC6mUDMwkaywpe7g0joLGdb8Fpidvnm19xt2mMzBgP4eGbHjAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKYf/KcQ81MpGww48XR1/n4+kn/DAD4ivAuva0j7cJg=;
 b=1TV7acSuVF7iaUn4OF24hDy16OX8Pq7R8dKotuUxV3dFmYGmwWuGvxHPL6hZQ7or8gsbiqm5Qb78HlWUOiuu5715p2KzIqX56zm6PV1UBc22sZZ1wporGa0qM3KMe1714aoDFWDgb5i22poQc0sYZUIJta9nKtQNw8vi4OCEM6I=
Received: from SN1PR12CA0090.namprd12.prod.outlook.com (2603:10b6:802:21::25)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 09:20:53 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::7f) by SN1PR12CA0090.outlook.office365.com
 (2603:10b6:802:21::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 09:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 09:20:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 04:20:44 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Jun 2025 04:20:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Paul Alvin <alvin.paulp@amd.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Remove simple-bus description from mini configurations
Date: Fri, 27 Jun 2025 11:20:40 +0200
Message-ID: <a51b11fa21c504a19701ebdccc1e61e899e1aed5.1751016029.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27280; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2YzWy8iB6f00vhFdX2qC1oF7P15ZbvX2xsuodbcf0vk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTEJWUuS/ZdqHW0JFq7MSKhvEZr4TP96S/c71rNdy6/o
 PlfaT5HRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzELZPhF9O3j0YW+zsa1nre
 Nbuefu2h8AuuhKWLAoPX5q7aZLhL5izDH74+cQdPdZZNYVLZ3Y8qTmldPlmiZrGo9Zd6gzaryNE
 Z7AA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: fd851000-707e-442d-394d-08ddb55be9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t64BE7NifspkNY69TVzK2/Mi7KW3MlOw94wz0Arbu7Uhf/p4xcJ12RcREat1?=
 =?us-ascii?Q?/0FyCAb4pqGGzFYrsjspmTlA/0Qwas2Y8Ceoc3biMETLd/xXh1TwnMrmnTSt?=
 =?us-ascii?Q?ykCP1nA3kDoFjqYm7nepJYE8xTn0Rq84BhU9nNsmliolibO8YTMUtxvM1lgk?=
 =?us-ascii?Q?1/sojlntUeNy+b/pza8VtfjWg3ToR9VNOCf2nU4du05copzC3Pv2+YatISkz?=
 =?us-ascii?Q?A4DnFULqZ66Qb0UvCt4spAZMadrYWPG9dxOX+wfYgLaGFRcThxxCb4FUkXAd?=
 =?us-ascii?Q?W8XiJOdLyZg1l+uKF6tDnFLh1Gy30DS74iqEh/rzDT1PBb7rKESQMYDyekAB?=
 =?us-ascii?Q?fOyAUb370FOz9EFQUrFV4rGbYQiIS0WJd9XS64lbnNpE0jyoWkqF8bNEKihN?=
 =?us-ascii?Q?JSjC2+B0X/JEt2n8/WgYYtgPfv3x8Bl3zn+6Mrm5cpF64iptNcQoA7lOm8pJ?=
 =?us-ascii?Q?zxRi8/p8nTcNOkWsN9+hwxVb05LSpuQLidqJyH6WvxHmYFP39O9HkTXaQB6O?=
 =?us-ascii?Q?dgp+pRHUACerO/43q8XV7khN9LEIf9NS5Pvt5Kxj8VJu0Ea7DjH9QJVpMHAH?=
 =?us-ascii?Q?+To5CA65pBpj+RzT/SIFPWU5jD04aO08PBOicQYt9cLv/aTySMiopMSz39gS?=
 =?us-ascii?Q?aHU9SO1id9DbxiezIWVHCQWw+x+BYDsFDC6TS8KKWisSEMp/l6f6LNrf3xKC?=
 =?us-ascii?Q?kPI0EI509TikRHVJTV+1MJ/Wgu9VqfSc6iu5X54Zy/6V4tYYRBhG9CMpM/iR?=
 =?us-ascii?Q?aCsxlf4tsl8Z0oamnivT24Ft2qjWmmWDP7tBByPhexLLW32tSieErCxm72M8?=
 =?us-ascii?Q?JHKLNclPBn7oVZ0cwF7ZLVmoOkaofDbeD2Dv22E9keTN+hLfbE44yZEc6v1p?=
 =?us-ascii?Q?8KvX9mz8R27aPmj5UJoEM7FiFGiNEfYQGZK1OZ7sjFPw4dyIf//yubb5vgIJ?=
 =?us-ascii?Q?7l7gX3vaTvJBeofs0sDBgJFgPhWKbiZKj2zi1IDuK5IgbfCOJuzboGu1y1nM?=
 =?us-ascii?Q?sziFoWbL20MLqtftZFoQbvfUWg3zgSf2TpwOwr3qC+u9pMxezipCJRPCEUsP?=
 =?us-ascii?Q?mT4ElUxJJH1yzFTGw+Z2CFDVDV8Z9KzeOcKqOQwXJR8/qhIhpqmZRwKIVZtW?=
 =?us-ascii?Q?C1P4DpJmhPq5Jaa4nO13UsGo9Tp08JQRN4bA9He4oNlKEs6KcrogxkpW2r/x?=
 =?us-ascii?Q?Owfp2CxRSbOQpjHJTqjsWHES7zu6umsl3AIraMsGixhEvA/7s32hbUbwurME?=
 =?us-ascii?Q?7m+RYX3nt1ScGDGkVnFEGYgl9qeRhNgD1FmFZh0nFVjO5wsQKUb52otNTFf2?=
 =?us-ascii?Q?wfQeE5qUF4d2/+xALT2gGiGBp3sXFqUtiPWfEjpa+JjjmOBtrxIClf9nM+Rm?=
 =?us-ascii?Q?hyD0nuS09N83ko3D58+MJDPQED942kDLmN7KsnFGhM2564gxEX61IVQdZpN6?=
 =?us-ascii?Q?8orGAIeEq6TvLHnE/egiJmvC6pjK1vvqVtckbpvoqTa/EIOpZC0+FsJ3r8F1?=
 =?us-ascii?Q?eK7jxQwDSnBsw5NVRJkcOJy1dlS1knc8+lMH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:20:52.6643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd851000-707e-442d-394d-08ddb55be9e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
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

simple bus node and drivers not bringing up any value for mini
configuration that's why remove it and disable drivers for it to save some
space.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-emmc0.dts            | 36 +++++-------
 arch/arm/dts/versal-mini-emmc1.dts            | 36 +++++-------
 arch/arm/dts/versal-mini-ospi.dtsi            | 52 ++++++++---------
 arch/arm/dts/versal-mini-qspi.dtsi            | 40 ++++++-------
 arch/arm/dts/versal-net-mini-emmc.dts         | 36 +++++-------
 arch/arm/dts/versal-net-mini-ospi.dtsi        | 56 ++++++++-----------
 arch/arm/dts/versal-net-mini-qspi.dtsi        | 42 ++++++--------
 arch/arm/dts/versal-net-mini.dts              | 26 +++------
 arch/arm/dts/zynqmp-mini-emmc0.dts            | 31 ++++------
 arch/arm/dts/zynqmp-mini-emmc1.dts            | 31 ++++------
 arch/arm/dts/zynqmp-mini-nand.dts             | 35 +++++-------
 arch/arm/dts/zynqmp-mini-qspi.dts             | 25 +++------
 configs/amd_versal2_mini_defconfig            |  1 +
 configs/amd_versal2_mini_emmc_defconfig       |  1 +
 configs/amd_versal2_mini_ospi_defconfig       |  1 +
 configs/amd_versal2_mini_qspi_defconfig       |  1 +
 configs/xilinx_versal_mini_defconfig          |  1 +
 configs/xilinx_versal_mini_emmc0_defconfig    |  1 +
 configs/xilinx_versal_mini_emmc1_defconfig    |  1 +
 configs/xilinx_versal_mini_ospi_defconfig     |  1 +
 configs/xilinx_versal_mini_qspi_defconfig     |  1 +
 configs/xilinx_versal_net_mini_defconfig      |  1 +
 configs/xilinx_versal_net_mini_emmc_defconfig |  1 +
 configs/xilinx_versal_net_mini_ospi_defconfig |  1 +
 configs/xilinx_versal_net_mini_qspi_defconfig |  1 +
 configs/xilinx_zynqmp_mini_defconfig          |  1 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |  1 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |  1 +
 configs/xilinx_zynqmp_mini_nand_defconfig     |  1 +
 .../xilinx_zynqmp_mini_nand_single_defconfig  |  1 +
 configs/xilinx_zynqmp_mini_qspi_defconfig     |  1 +
 31 files changed, 196 insertions(+), 269 deletions(-)

diff --git a/arch/arm/dts/versal-mini-emmc0.dts b/arch/arm/dts/versal-mini-emmc0.dts
index 179060c56eee..9044ef1889bb 100644
--- a/arch/arm/dts/versal-mini-emmc0.dts
+++ b/arch/arm/dts/versal-mini-emmc0.dts
@@ -28,28 +28,20 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <0x2>;
-		#size-cells = <0x2>;
-		ranges;
-
-		sdhci0: sdhci@f1040000 {
-			compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
-			status = "okay";
-			non-removable;
-			disable-wp;
-			no-sd;
-			no-sdio;
-			cap-mmc-hw-reset;
-			bus-width = <8>;
-			reg = <0x0 0xf1040000 0x0 0x10000>;
-			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&clk200 &clk200>;
-			no-1-8-v;
-			xlnx,mio-bank = <0>;
-		};
+	sdhci0: sdhci@f1040000 {
+		compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
+		status = "okay";
+		non-removable;
+		disable-wp;
+		no-sd;
+		no-sdio;
+		cap-mmc-hw-reset;
+		bus-width = <8>;
+		reg = <0x0 0xf1040000 0x0 0x10000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&clk200 &clk200>;
+		no-1-8-v;
+		xlnx,mio-bank = <0>;
 	};
 
 	aliases {
diff --git a/arch/arm/dts/versal-mini-emmc1.dts b/arch/arm/dts/versal-mini-emmc1.dts
index ffcc33345296..47f3b74c0655 100644
--- a/arch/arm/dts/versal-mini-emmc1.dts
+++ b/arch/arm/dts/versal-mini-emmc1.dts
@@ -28,28 +28,20 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <0x2>;
-		#size-cells = <0x2>;
-		ranges;
-
-		sdhci1: sdhci@f1050000 {
-			compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
-			status = "okay";
-			non-removable;
-			disable-wp;
-			no-sd;
-			no-sdio;
-			cap-mmc-hw-reset;
-			bus-width = <8>;
-			reg = <0x0 0xf1050000 0x0 0x10000>;
-			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&clk200 &clk200>;
-			no-1-8-v;
-			xlnx,mio-bank = <0>;
-		};
+	sdhci1: sdhci@f1050000 {
+		compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
+		status = "okay";
+		non-removable;
+		disable-wp;
+		no-sd;
+		no-sdio;
+		cap-mmc-hw-reset;
+		bus-width = <8>;
+		reg = <0x0 0xf1050000 0x0 0x10000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&clk200 &clk200>;
+		no-1-8-v;
+		xlnx,mio-bank = <0>;
 	};
 
 	aliases {
diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index 9ca0cf3c027f..eec2a08e7c70 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -28,37 +28,29 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <0x2>;
-		#size-cells = <0x2>;
-		ranges;
-
-		ospi: spi@f1010000 {
-			compatible = "cdns,qspi-nor";
-			status = "okay";
-			reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
-			clock-names = "ref_clk", "pclk";
-			clocks = <&clk125 &clk125>;
-			bus-num = <2>;
-			num-cs = <1>;
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			cdns,is-dma = <1>;
-			cdns,trigger-address = <0xc0000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+	ospi: spi@f1010000 {
+		compatible = "cdns,qspi-nor";
+		status = "okay";
+		reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clk125 &clk125>;
+		bus-num = <2>;
+		num-cs = <1>;
+		cdns,fifo-depth = <256>;
+		cdns,fifo-width = <4>;
+		cdns,is-dma = <1>;
+		cdns,trigger-address = <0xc0000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-			flash0: flash@0 {
-				compatible = "n25q512a", "micron,m25p80",
-					     "jedec,spi-nor";
-				reg = <0x0>;
-				spi-tx-bus-width = <8>;
-				spi-rx-bus-width = <8>;
-				spi-max-frequency = <20000000>;
-				no-wp;
-			};
+		flash0: flash@0 {
+			compatible = "n25q512a", "micron,m25p80",
+				     "jedec,spi-nor";
+			reg = <0x0>;
+			spi-tx-bus-width = <8>;
+			spi-rx-bus-width = <8>;
+			spi-max-frequency = <20000000>;
+			no-wp;
 		};
 	};
 
diff --git a/arch/arm/dts/versal-mini-qspi.dtsi b/arch/arm/dts/versal-mini-qspi.dtsi
index 57427e099f9e..ec4eef74020b 100644
--- a/arch/arm/dts/versal-mini-qspi.dtsi
+++ b/arch/arm/dts/versal-mini-qspi.dtsi
@@ -28,31 +28,23 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <0x2>;
-		#size-cells = <0x2>;
-		ranges;
-
-		qspi: spi@f1030000 {
-			compatible = "xlnx,versal-qspi-1.0";
-			status = "okay";
-			clock-names = "ref_clk", "pclk";
-			num-cs = <0x1>;
-			reg = <0x0 0xf1030000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clk150 &clk150>;
+	qspi: spi@f1030000 {
+		compatible = "xlnx,versal-qspi-1.0";
+		status = "okay";
+		clock-names = "ref_clk", "pclk";
+		num-cs = <0x1>;
+		reg = <0x0 0xf1030000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk150 &clk150>;
 
-			flash0: flash@0 {
-				compatible = "n25q512a", "micron,m25p80",
-					     "jedec,spi-nor";
-				reg = <0x0>;
-				spi-tx-bus-width = <4>;
-				spi-rx-bus-width = <4>;
-				spi-max-frequency = <20000000>;
-			};
+		flash0: flash@0 {
+			compatible = "n25q512a", "micron,m25p80",
+				     "jedec,spi-nor";
+			reg = <0x0>;
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+			spi-max-frequency = <20000000>;
 		};
 	};
 
diff --git a/arch/arm/dts/versal-net-mini-emmc.dts b/arch/arm/dts/versal-net-mini-emmc.dts
index 20e4e2994048..567ceeb36a0b 100644
--- a/arch/arm/dts/versal-net-mini-emmc.dts
+++ b/arch/arm/dts/versal-net-mini-emmc.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx Versal NET Mini eMMC Configuration
  *
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Ashok Reddy Soma <ashok.reddy.soma@amd.com>
@@ -42,26 +42,18 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		sdhci1: mmc@f1050000 {
-			compatible = "xlnx,versal-net-emmc";
-			status = "okay";
-			non-removable;
-			disable-wp;
-			no-sd;
-			no-sdio;
-			cap-mmc-hw-reset;
-			bus-width = <8>;
-			reg = <0 0xf1050000 0 0x10000>;
-			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&clk200>, <&clk200>;
-			xlnx,mio-bank = <0>;
-		};
+	sdhci1: mmc@f1050000 {
+		compatible = "xlnx,versal-net-emmc";
+		status = "okay";
+		non-removable;
+		disable-wp;
+		no-sd;
+		no-sdio;
+		cap-mmc-hw-reset;
+		bus-width = <8>;
+		reg = <0 0xf1050000 0 0x10000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&clk200>, <&clk200>;
+		xlnx,mio-bank = <0>;
 	};
 };
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index a9bf7cc42484..1c94b352dc97 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx Versal NET Mini OSPI Configuration
  *
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Ashok Reddy Soma <ashok.reddy.soma@amd.com>
@@ -42,38 +42,30 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <0x2>;
-		#size-cells = <0x2>;
-		ranges;
-
-		ospi: spi@f1010000 {
-			compatible = "cdns,qspi-nor";
-			status = "okay";
-			reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
-			clock-names = "ref_clk", "pclk";
-			clocks = <&clk125>, <&clk125>;
-			bus-num = <2>;
-			num-cs = <1>;
-			cdns,fifo-depth = <256>;
-			cdns,fifo-width = <4>;
-			cdns,is-dma = <1>;
-			cdns,is-stig-pgm = <1>;
-			cdns,trigger-address = <0xc0000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+	ospi: spi@f1010000 {
+		compatible = "cdns,qspi-nor";
+		status = "okay";
+		reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clk125>, <&clk125>;
+		bus-num = <2>;
+		num-cs = <1>;
+		cdns,fifo-depth = <256>;
+		cdns,fifo-width = <4>;
+		cdns,is-dma = <1>;
+		cdns,is-stig-pgm = <1>;
+		cdns,trigger-address = <0xc0000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-			flash0: flash@0 {
-				compatible = "mt35xu02g", "micron,m25p80",
-					     "jedec,spi-nor";
-				reg = <0>;
-				spi-tx-bus-width = <8>;
-				spi-rx-bus-width = <8>;
-				spi-max-frequency = <20000000>;
-				no-wp;
-			};
+		flash0: flash@0 {
+			compatible = "mt35xu02g", "micron,m25p80",
+				     "jedec,spi-nor";
+			reg = <0>;
+			spi-tx-bus-width = <8>;
+			spi-rx-bus-width = <8>;
+			spi-max-frequency = <20000000>;
+			no-wp;
 		};
 	};
 };
diff --git a/arch/arm/dts/versal-net-mini-qspi.dtsi b/arch/arm/dts/versal-net-mini-qspi.dtsi
index e29a3f36d6e4..97cc39c73e0d 100644
--- a/arch/arm/dts/versal-net-mini-qspi.dtsi
+++ b/arch/arm/dts/versal-net-mini-qspi.dtsi
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx Versal NET Mini QSPI Configuration
  *
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  * Ashok Reddy Soma <ashok.reddy.soma@amd.com>
@@ -42,31 +42,23 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		qspi: spi@f1030000 {
-			compatible = "xlnx,versal-qspi-1.0";
-			status = "okay";
-			clock-names = "ref_clk", "pclk";
-			num-cs = <1>;
-			reg = <0 0xf1030000 0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&clk150>, <&clk150>;
+	qspi: spi@f1030000 {
+		compatible = "xlnx,versal-qspi-1.0";
+		status = "okay";
+		clock-names = "ref_clk", "pclk";
+		num-cs = <1>;
+		reg = <0 0xf1030000 0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk150>, <&clk150>;
 
-			flash0: flash@0 {
-				compatible = "n25q512a", "micron,m25p80",
-					     "jedec,spi-nor";
-				reg = <0>;
-				spi-tx-bus-width = <4>;
-				spi-rx-bus-width = <4>;
-				spi-max-frequency = <20000000>;
-			};
+		flash0: flash@0 {
+			compatible = "n25q512a", "micron,m25p80",
+				     "jedec,spi-nor";
+			reg = <0>;
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+			spi-max-frequency = <20000000>;
 		};
 	};
 };
diff --git a/arch/arm/dts/versal-net-mini.dts b/arch/arm/dts/versal-net-mini.dts
index f98f95a5c2fc..0f0a82e3aa3f 100644
--- a/arch/arm/dts/versal-net-mini.dts
+++ b/arch/arm/dts/versal-net-mini.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx Versal NET
  *
  * Copyright (C) 2021 - 2022, Xilinx, Inc.
- * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022-2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -45,22 +45,14 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		compatible = "simple-bus";
+	serial0: serial@f1920000 {
 		bootph-all;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		serial0: serial@f1920000 {
-			bootph-all;
-			compatible = "arm,pl011", "arm,primecell";
-			reg = <0 0xf1920000 0 0x1000>;
-			reg-io-width = <4>;
-			clock-names = "uartclk", "apb_pclk";
-			clocks = <&clk1>, <&clk1>;
-			clock = <1000000>;
-			skip-init;
-		};
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0 0xf1920000 0 0x1000>;
+		reg-io-width = <4>;
+		clock-names = "uartclk", "apb_pclk";
+		clocks = <&clk1>, <&clk1>;
+		clock = <1000000>;
+		skip-init;
 	};
 };
diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
index ad4b3c5f8b1d..05f61d6bb359 100644
--- a/arch/arm/dts/zynqmp-mini-emmc0.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
@@ -41,25 +41,18 @@
 		clock-frequency = <200000000>;
 	};
 
-	amba: axi {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		sdhci0: mmc@ff160000 {
-			bootph-all;
-			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
-			status = "disabled";
-			non-removable;
-			no-sd;
-			no-sdio;
-			cap-mmc-hw-reset;
-			bus-width = <8>;
-			reg = <0x0 0xff160000 0x0 0x1000>;
-			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&clk_xin &clk_xin>;
-		};
+	sdhci0: mmc@ff160000 {
+		bootph-all;
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		status = "disabled";
+		non-removable;
+		no-sd;
+		no-sdio;
+		cap-mmc-hw-reset;
+		bus-width = <8>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&clk_xin &clk_xin>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
index fd421b4fe7ed..7857106260e1 100644
--- a/arch/arm/dts/zynqmp-mini-emmc1.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
@@ -41,25 +41,18 @@
 		clock-frequency = <200000000>;
 	};
 
-	amba: axi {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		sdhci1: mmc@ff170000 {
-			bootph-all;
-			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
-			status = "disabled";
-			non-removable;
-			no-sd;
-			no-sdio;
-			cap-mmc-hw-reset;
-			bus-width = <8>;
-			reg = <0x0 0xff170000 0x0 0x1000>;
-			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&clk_xin &clk_xin>;
-		};
+	sdhci1: mmc@ff170000 {
+		bootph-all;
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		status = "disabled";
+		non-removable;
+		no-sd;
+		no-sdio;
+		cap-mmc-hw-reset;
+		bus-width = <8>;
+		reg = <0x0 0xff170000 0x0 0x1000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&clk_xin &clk_xin>;
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
index 5e2135158cd5..1ece39997912 100644
--- a/arch/arm/dts/zynqmp-mini-nand.dts
+++ b/arch/arm/dts/zynqmp-mini-nand.dts
@@ -35,27 +35,20 @@
 		bootph-all;
 	};
 
-	amba: axi {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges;
-
-		nand0: nand@ff100000 {
-			compatible = "arasan,nfc-v3p10";
-			status = "okay";
-			reg = <0x0 0xff100000 0x1000>;
-			clock-names = "clk_sys", "clk_flash";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			arasan,has-mdma;
-			num-cs = <2>;
-			nand@0 {
-				reg = <0>;
-				#address-cells = <2>;
-				#size-cells = <1>;
-				nand-ecc-mode = "hw";
-			};
+	nand0: nand@ff100000 {
+		compatible = "arasan,nfc-v3p10";
+		status = "okay";
+		reg = <0x0 0xff100000 0x1000>;
+		clock-names = "clk_sys", "clk_flash";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		arasan,has-mdma;
+		num-cs = <2>;
+		nand@0 {
+			reg = <0>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			nand-ecc-mode = "hw";
 		};
 	};
 };
diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
index 917603dec61d..ddcc39b4e942 100644
--- a/arch/arm/dts/zynqmp-mini-qspi.dts
+++ b/arch/arm/dts/zynqmp-mini-qspi.dts
@@ -42,22 +42,15 @@
 		clock-frequency = <125000000>;
 	};
 
-	amba: axi {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges;
-
-		qspi: spi@ff0f0000 {
-			compatible = "xlnx,zynqmp-qspi-1.0";
-			status = "disabled";
-			clock-names = "ref_clk", "pclk";
-			clocks = <&misc_clk &misc_clk>;
-			num-cs = <1>;
-			reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
+	qspi: spi@ff0f0000 {
+		compatible = "xlnx,zynqmp-qspi-1.0";
+		status = "disabled";
+		clock-names = "ref_clk", "pclk";
+		clocks = <&misc_clk &misc_clk>;
+		num-cs = <1>;
+		reg = <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 	};
 };
 
diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index d224583f56ae..155b554d6c21 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -63,6 +63,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index 3afc6cb2736b..90907dfb72cf 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -54,6 +54,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 54328e85784a..3b4c6205da4b 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index 48fb7ae0e7f3..72e6f613cd56 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 561459befb61..cd5eebabf9a6 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -60,6 +60,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_MMC is not set
 CONFIG_ARM_DCC=y
 # CONFIG_GZIP is not set
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 21f241e07b14..ffa1395fea71 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -59,6 +59,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ARM_DCC=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 6cb654c7a4bd..4d438a9b5cdd 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -59,6 +59,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ARM_DCC=y
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index af9ce4991690..cac691c92cee 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -54,6 +54,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index ecb3b16033cb..220daa894ea0 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -56,6 +56,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 04dd0cdb507a..7f2b1fbc88e7 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -64,6 +64,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index ab201566407d..ba2c76c480b9 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -54,6 +54,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 18ec73722586..a8d0c5fc1287 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -53,6 +53,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 5241da6c63bb..1a3df99f65ed 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -55,6 +55,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 8aa4c8dc77dc..1f9fc71062f2 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
 CONFIG_ARM_DCC=y
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 66e0d5242821..4310412bed99 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -72,6 +72,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_DM_MAILBOX is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index cded70f8f2f1..142d3643ba7a 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -72,6 +72,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_DM_MAILBOX is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index f5c79779df3d..cb474697f518 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -52,6 +52,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
 CONFIG_DM_MTD=y
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index fa58f2a73c0d..717b66f8d384 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -52,6 +52,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
 CONFIG_DM_MTD=y
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index f2d0d6f16edd..2f6135144791 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -73,6 +73,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
+# CONFIG_SIMPLE_BUS is not set
 # CONFIG_FIRMWARE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
-- 
2.43.0

base-commit: cb5189d676852cad7ab3c0691490b2d0dac618b4
