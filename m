Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09995C369A1
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 07:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7848880F;
	Wed, 25 Sep 2024 09:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qsTESs7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA078880F; Wed, 25 Sep 2024 09:02:31 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C890882B7
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 09:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4fUHW781C3OtPBNKxBpMFRGeq9kyrlxZLa0JUlYYvzVBNDnEelkL+qzHatsZvB6eO+50wxh+Vn0LUrh4Nujxz8R6aNRHVSF5k3SM0siiTE8xRlgZncRPLdX9A6N3qY6zL05yh6RE5gdhsLB/yOr0a9IxU3RFuWKwBp3hXOlMw7zG30lHqKS64VAu+RQPRNSlwUDey5mHshR6lbx2rrdChbFWgweCNReqoRfWiC95JUNF0rsYR74VCpAujbtJ6F5VTMAc1wNeSGzZzRAbpclS0RBwNSaCTVrztxSe+KqgYA72b5bpDg3ZeS0DjzkSitLL0VUCvmoaFwX9bJh8uHrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjVSUtu1xgllHLZGfXuu9Gm0iqFi4xX+wXD8Qa97u8s=;
 b=R6gzxUyesgksoP4duchGYwpT1SHkju/ajUdjLMITql07mDGBmfnMymGwUVWVr5o0KCMxkZCDpaHvmSBpqT8InX9OEJqLxNebSTFWkoaPQSYZmnnx0rJyIOrrVqTV1GwC0EsnpL9HeRmjesxiImhN+EFBEHBJQUBK0+FRZz7ovC6OrPK9PpZackIfPt1S+Rgsg/w122k2D1yPibvBkMpA+iBi12648PYyLJuLvzFWkYQ5rhhhJfIcGQQnCEo8cG+vxgR3j8BfX99lGMo68lOakN9+xEg3RZ3S9p+Bwuhdj0e85RwaF+j8m5ukMeJmUgR4aFq04KoiX+4Zl0bmJ/crQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjVSUtu1xgllHLZGfXuu9Gm0iqFi4xX+wXD8Qa97u8s=;
 b=qsTESs7uxFpKR6l19VssnF+htjaWeYM+mx3M4c8Lnv5BZN3AVG/bgH3Q21aRQj4wr8uuqFOlUJS7aT835wjf8XMQiFhf0IScemzvRTSmT9VdPdkg41MnKMDg7hSedBZuVPFLizDmQiuRUqPQwGg2nR8unsFMvTsTDBe+bYw+bNU=
Received: from BL1PR13CA0311.namprd13.prod.outlook.com (2603:10b6:208:2c1::16)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 07:02:16 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::21) by BL1PR13CA0311.outlook.office365.com
 (2603:10b6:208:2c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10 via Frontend
 Transport; Wed, 25 Sep 2024 07:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:02:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:02:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: kernel test robot <lkp@intel.com>, Paul Alvin <alvin.paulp@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] arm64: xilinx: Fix file location described in
 zynqmp-p-a2197-00-revA.dts
Date: Wed, 25 Sep 2024 09:02:07 +0200
Message-ID: <6e6017ad613d452d16ce0f7fba8a6ce32b174413.1727247725.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7308; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MKXN+G7V3eNPv1uGf0GeUEwnNETtIUgZ4qm55DwmSYo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTPWwvqK3I+T5YSLfHjzrj2f/+sr9mZMcs/hLaIvVsxP
 /vpLNHwjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARrc8M88vvXFsdf5ilbMW/
 9EOJrRzLPc4IFDPMT77LIMxzoUncae+0XdbCARPNTpaVAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 782dd953-42d2-44ec-2145-08dcdd2ffd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JdVp3HPuIhuMNdBenZiZLBxY5bhek2W09B5fTFyHwDXAnndzX4cVhHNe8SMc?=
 =?us-ascii?Q?JHTSx+V866nnm/0I+UKRwgQbsg2ru5LqOR12X45G9F+2njL0iMjUCiBQjyNQ?=
 =?us-ascii?Q?vnWCw4yDnoTh98d0LN0dZ02mSzzNulnJ9ud7PmYV1K2mnqe2FCeb78HuN2SY?=
 =?us-ascii?Q?4P1UR0gUBpOAMx9gwvAE6U8ylKZ2VvcmGWB4JmimWyxhmF2mkFplyNzmEdQe?=
 =?us-ascii?Q?wrd5hpm10UuG90uButONoZ7LmiooNeGv4tI+k2AkjLI4FYFkfF946PvbNDsr?=
 =?us-ascii?Q?HSr8TbXNTiZQDUn5jetzdKusnBtSIYJteI2cBz9hLy4jXm+IWGOCnlTmfLCn?=
 =?us-ascii?Q?LgTH9P2lUA4Y09pXSxSHmkpMF6+QfHlIIsuYGx49mBhe5GIqIhiikRGKMsfE?=
 =?us-ascii?Q?979eMDS6e3LFDTKODmd3Bjmrj+bqirFVjtvHSyn3JkqNedXG5DGvZEb9uDQq?=
 =?us-ascii?Q?np4ZHY3dhPeVGQuONSDw/V0vwbRZoVdms73OgMGHL9/Y8rVUsLOw/CIGoeUA?=
 =?us-ascii?Q?B0QeK6RFKaEU1Xne0w8zPXb/VNetlpt0OGBc64NQmtfCEiIDS2d+zQFndEma?=
 =?us-ascii?Q?utpWX1lD3oi6SwESD2/1y570xpiFES0cXTeqM8GT5YTn7HtTxUKHJcA4+Flx?=
 =?us-ascii?Q?BmCfT13s7nY2g9F1HeJdh8A6MK/hxIgORIulkAA5xGtfTXwSVhwxnaSdDA86?=
 =?us-ascii?Q?x5Kxs0MzxPVeod6GPBuNv3fm4k8F8EMqHhqHO+/1WnFLprFOeqASdixrqsMV?=
 =?us-ascii?Q?qsONSXs893kEZbsnSDrIJdUOagmp1KHbxBAdnmIkalExMEtEotME6It29zu6?=
 =?us-ascii?Q?sngfStZUGXvzv8PekWcR68XZoseGcRE8oGIsOQvBjXbkZxZopuPsVKLuTbop?=
 =?us-ascii?Q?mtNxkPrHL9l08X8+keiM6Fv+lBAzXY8mvA+iAW20mu66LduSMTGq8Hd+BXDx?=
 =?us-ascii?Q?rVnJNHe5aMWaFs2IsG0VTk4JNeal/QOMef96ps+C1Y3dhjqDxOSqWRE2bsry?=
 =?us-ascii?Q?gfAvuC4HfnOGvHH+T/eBPZpO3JwI22ui2o6kt8oc3fzmIbjjPBBYy4JvVjGz?=
 =?us-ascii?Q?V9uRnFJWmPgvEOaPNyEgwOvAWk0nIYNYFSXZRB7AecyOtmLPWBVBZ9KLbWzy?=
 =?us-ascii?Q?04o7GCKabkjZVHmnEqMTSm/I4OJ+I3ajGYFs03maw3WYk+8nqZ74g3T6qqOh?=
 =?us-ascii?Q?NPXTM4ooNyvyugVxNDTJItZQqGPkFPHJnI5Yjd2+OQiZSDI6eWnKXFnFHmlM?=
 =?us-ascii?Q?3YLbsFIvNpNOC7mj1l0Up3jV0BxlTXMgO8AbMw/TecMu1LmfP5rKFLf+8ql5?=
 =?us-ascii?Q?WxdA3V6R//d2cndoDyDjXLB0sdZ8P7W5EuZTukyFg/MwR5FajM206XnPxjC9?=
 =?us-ascii?Q?6HCRyqxaoF9ER/y7XEaWKcinjT6z6EMF3xarvqTMVYsPp21rGkUwnMjpk4Ik?=
 =?us-ascii?Q?bOzSake58p97Ik6gf+mLASPOCTCZK9kF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:02:15.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782dd953-42d2-44ec-2145-08dcdd2ffd0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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

Fix pointers to incorrect file name described in DT.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409250603.7achimjs-lkp@intel.com/
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-p-a2197-00-revA.dts | 44 ++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index f93167c41284..fce0d8d5ca11 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -158,7 +158,7 @@
 			reg = <0>;
 			/* On connector J98 */
 			reg_vcc_fmc: tps544@7 { /* u80 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x7>;
 				regulator-name = "reg_vcc_fmc";
 				regulator-min-microvolt = <1800000>;
@@ -166,15 +166,15 @@
 				/* enable-gpio = <&gpio0 23 0x4>; optional */
 			};
 			reg_vcc_ram: tps544@8 { /* u83 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x8>;
 			};
 			reg_vcc_pslp: tps544@9 { /* u85 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x9>;
 			};
 			reg_vcc_psfp: tps544@a { /* u86 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0xa>;
 			};
 			reg_vccint: tps53681@60 { /* u70 - FIXME name - don't know what it does - also vcc_io_soc */
@@ -215,75 +215,75 @@
 			reg = <2>;
 			/* On connector J104 */
 			reg_vccaus: tps544@d { /* u88 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0xd>;
 			};
 			reg_vccaux_fmc: tps544@e { /* u90 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0xe>;
 			};
 			reg_vcco_500: tps544@f { /* u93 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0xf>;
 			};
 			reg_vcco_501: tps544@10 { /* u95 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x10>;
 			};
 			reg_vcco_502: tps544@11 { /* u97 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x11>;
 			};
 			reg_vcco_503: tps544@12 { /* u99 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x12>;
 			};
 			reg_vcc1v8: tps544@13 { /* u101 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x13>;
 			};
 			reg_vcc3v3: tps544@14 { /* u102 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x14>;
 			};
 			reg_vcc1v2_ddr4: tps544@15 { /* u104 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x15>;
 			};
 			reg_vcc1v1_lp4: tps544@16 { /* u106 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x16>;
 			};
 			reg_vcc1_1V8_lp4: tps544@17 { /* u108 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x17>;
 			};
 			reg_vadj_fmc: tps544@19 { /* u109 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x19>;
 			};
 			reg_mgtyavcc: tps544@1a { /* u111 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x1a>;
 			};
 			reg_mgtyavtt: tps544@1b { /* u114 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x1b>;
 			};
 			reg_mgtyvccaux: tps544@1c { /* u115 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x1c>;
 			};
 			reg_util_1v13: tps544@1d { /* u117 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x1d>;
 			};
 			reg_util_1v8: tps544@1e { /* u118 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x1e>;
 			};
 			reg_util_2v5: tps544@1f { /* u119 - FIXME name - don't know what it does */
-				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus - wiring is missing */
+				compatible = "ti,tps544b25"; /* Documentation/hwmon/pmbus.rst - wiring is missing */
 				reg = <0x1f>;
 			};
 		};
-- 
2.43.0

