Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701CBCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74698437F;
	Thu, 27 Nov 2025 15:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SwKUjpZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB70A843E3; Thu, 27 Nov 2025 15:04:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343828437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xbf+ECqKlCVrhIBWlMVqpmw4URTOstlOeKfEpwgoF9pvU1qQ4fiNjzNIT+6EjlfX9e/kUZF/ZIEGByJlLA0XZIgE2vScL5DLOjIM33munhpnxlJDiwepGoPFYVHq0RJyGfRIqeEz1nsCj9uAk3Lvqk4gN8B4iFQVIhR/reaAwOEakQQR7hAow+Rf+YdzOnrrGWkSrukUNDzcL1XMIqpPRf7lwvU5fkZhjz0x9YH+v/U97OuC2RdyRqQpkYEAGeiWB72ZyVUwLzVtyHNVcFr/+LqgzSJW3B1tZ1R1ESGFm8pPUQZ7JPl8a0ZmLU5fYLoMZrVkQcl/jfsHiJZDL3dbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NESDO24za1vIJPrpIG/ufqa6jKK7jJdOj0Ap8XfncAM=;
 b=tG3NDoUhwTQlSpEnJuaq45Cbe77faOHdB7nH/DwfnPoqmfAAywEI9aDIMFSBWI/MxE7rDgIOZQz9M4D7hbdHoAoX42dERzv6BOA/ZCNrnQv+LnqCiYYtFwqKsEHeYpBZFW6hxswIuP4UHspRTUtV0C8Wk6EA30l25yHQPnID2J4/9ZM8vs+PGiTrkxVa1Ktvd6vtWKsP40xuElfUbjcCwgg/iWrddSey/bE4IbPSOyySA5Ogp/6N2GwudXYy5NE85bvgv3VLJqdszq9qE+a5AbIA69QKebpKNO1m0lpY/mdhS91XWvv3PYQkuvHzgI28APoe8zI82RE9z1Mv5aNrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NESDO24za1vIJPrpIG/ufqa6jKK7jJdOj0Ap8XfncAM=;
 b=SwKUjpZsQ+77UG768MMUUi4jfxua+7bNrtWFnCsh2lLYbRkXwVT4zOSnzd4Mxfy/OENCwlKB8peJMIAXEY7JXj06NVGSGV7u7i3U0Mda4sN55aNqsfMJcvGk3P4Xed2KqK10b6aLw+Dkf7RHm4hnu0Ql43/+a0Ambt59fq9kE39TKVhZEOkk1v8f1RzHosbuwik2Mq4NhOE3HKuwIhlJby2JcFMYUUxg03ySWlob8DsKl8kgbMvB6b181sXTgqKIdABkhfPMX+6nm8EVXpf6to1jgmWiIynd+Wg7iRE/bG7aNCIOIf+OOEjKZlWzTxBeJaz6HIFuhPgKkg8QNmL0YQ==
Received: from AM0PR02CA0165.eurprd02.prod.outlook.com (2603:10a6:20b:28d::32)
 by AMBP195MB2861.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 14:04:46 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::47) by AM0PR02CA0165.outlook.office365.com
 (2603:10a6:20b:28d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Thu,
 27 Nov 2025 14:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 14:04:46 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 27 Nov
 2025 15:04:45 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/2] arch: arm: dts: k3-am625-phyboard-lyra: Drop bootph
 properties
Date: Thu, 27 Nov 2025 15:04:27 +0100
Message-ID: <20251127140428.701755-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|AMBP195MB2861:EE_
X-MS-Office365-Filtering-Correlation-Id: 681324e0-4407-4d06-b81a-08de2dbdebfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xU/ynZXG40aplgWIl2yMIvW/9LQUTjsuVEjM6RceS3weZ5ce8s5tl4VXudYY?=
 =?us-ascii?Q?1+EElBKxOXDUonk4Ur6o41sP6hVmcrt0OKoonYepLgQ5erMyhMES4k+XkwP5?=
 =?us-ascii?Q?BrKT1VjDmk6kOvwqfgvBFpj7HHQzqqzPLQWYoZgs8O0LDQ5nPT53/LwZ+SW0?=
 =?us-ascii?Q?071u6GyPof/u9BsWeKK0PNNnye/oWEk9HNXUp1veJeEDePKBq4WIC6nhG0Gi?=
 =?us-ascii?Q?BlN5pM0FkVqqKQ31+ryXgQ+TKtuJ3m+wGAxQ+NrwusX6IvNLxcDU34GZKkm8?=
 =?us-ascii?Q?V5zbFnuvT3x0fsja/Nl9uQrhjzjotooI1tB6PA7MnkL+vGBeGBRkd++9fcvL?=
 =?us-ascii?Q?WqszTQmhf8jebw4+pBUQ58M0aF0c1Q62VVyMUYiMPpyOQMKli3KKnCah2k/6?=
 =?us-ascii?Q?TCCV26iVKr3CjcmOZH6sbHAUbsI/7KLgv7T6vLPpUOTCpiQZoV8eEvXBxkkL?=
 =?us-ascii?Q?eZedZd+o5iQqA2kHcrBc9QPC8mOxCzrXUFfn1cJEaCyrPARJnRwxbtDLA44r?=
 =?us-ascii?Q?B0mbjh4na7hC/Fq60CQ0bQh4E/RONlgpsBWJr0EQt4HWWLH4meLcpoypc2iA?=
 =?us-ascii?Q?P8uiy3qYtKYqCVAxgC+SItSs4VcQRsxSSSO9ILwNJnubbUrAfU/kwErWGUWX?=
 =?us-ascii?Q?6gYJ3O0b1mFz6+DX/9Jd3SH+CJhgdVRJ54LR4GgkX4adQAf2dmmQrzn2JmCp?=
 =?us-ascii?Q?jbc434d/f3yxZ37wuRbRUFYc+5uV5sYI/8ihmEEOc5unHxMOdLEI0soLew3j?=
 =?us-ascii?Q?ph8o6CVu9ZloxtX6ClqumOBkjqljAtxBdqcDSc+m9tMB5WdcRT8NNjDqY7VL?=
 =?us-ascii?Q?hK/s5XuJkD/aKFemTvko9v+OljUEWz/AQszj0c41fDvsxMkQ0uYCWImReScA?=
 =?us-ascii?Q?/lcaV5ZHKGL1sk7CPzBYP6K+zDgTZoMkYgp7w6lbD2C8dtU7cIaJ+P8iIUYd?=
 =?us-ascii?Q?MQI89seeVfjzgalYtB5LsQnBarDLOGh62F+w7uSIcavy2SkqV1Z4cYKWnyJ8?=
 =?us-ascii?Q?6tuTDotQVECTU3yGVAckBnslSlZPbKnSRgAt/vrhirXnBnb7JWLN+GrCFDB2?=
 =?us-ascii?Q?DG56vWM/j3lV6cTnxLEMZSyY/18WrTO72PBPGZKIjxoZPlXtGBA5symk14tM?=
 =?us-ascii?Q?/NAQT6a4mrn50H9qP5OJAmiFeqA8kQwF730Ld16neHet3DRcetaIJXkllI9B?=
 =?us-ascii?Q?zllXhi5Sn8Vr6jid7ZE1uUZbt9u2XIWkYjEau/KrDVfj1cvOi/B5jXqzN2mN?=
 =?us-ascii?Q?eK9X6q7in5tlLKnSLdOif2aGXJaN2IqXwIRr298hhgI8mSL4Y29S2KisvVjt?=
 =?us-ascii?Q?WO/wt81Xw5tLUNZIgC35L8lJUni3qXOgRWP2iGyCcsR4P8phr3bPUhwg3PZN?=
 =?us-ascii?Q?chfp6kqGoKcJ2ItNRYt8PxzDshgLI+EZNcs6O6cKRWUp4tJZ6212i6QJhJFw?=
 =?us-ascii?Q?ql1YVrISFkjVeS/KizUQYYX6aSQ3i9gFi5OT4rCxRQEos0ubk8rGuPbyQjIW?=
 =?us-ascii?Q?2dOpTlamJ8GfvJYgZ1JO/xZwYvmfHnTfkJuvsxLFCbvIi8+k6qljEp6C5KPK?=
 =?us-ascii?Q?LHg6UR/EPikGm7tpqRk=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:04:46.4041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681324e0-4407-4d06-b81a-08de2dbdebfc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2861
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

Remove bootph properties no longer needed. These are now handled
in upstream Linux device trees.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    | 100 ------------------
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |   8 --
 2 files changed, 108 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index 3a1a8b06dc6..daa1710dbc4 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -19,36 +19,16 @@
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
-
-	memory@80000000 {
-		bootph-all;
-	};
-};
-
-&cpsw3g {
-	bootph-all;
-};
-
-&cpsw_port1 {
-	bootph-all;
 };
 
 &cpsw_port2 {
 	status = "disabled";
 };
 
-&cpsw3g_phy1 {
-	bootph-all;
-};
-
 &phy_gmii_sel {
 	bootph-all;
 };
 
-&fss {
-	bootph-all;
-};
-
 &main_bcdma {
 	bootph-all;
 	reg = <0x00 0x485c0100 0x00 0x100>,
@@ -63,38 +43,6 @@
 		    "ringrt" , "cfg", "tchan", "rchan";
 };
 
-&main_gpio0 {
-	bootph-all;
-};
-
-&main_mdio1_pins_default {
-	bootph-all;
-};
-
-&main_i2c0 {
-	bootph-all;
-};
-
-&main_i2c0_pins_default {
-	bootph-all;
-};
-
-&main_mmc0_pins_default {
-	bootph-all;
-};
-
-&main_mmc1_pins_default {
-	bootph-all;
-};
-
-&main_pktdma {
-	bootph-all;
-};
-
-&main_rgmii1_pins_default {
-	bootph-all;
-};
-
 &main_rti1 {
 	status = "disabled";
 };
@@ -111,27 +59,8 @@
 	status = "disabled";
 };
 
-&main_uart0 {
-	bootph-all;
-};
-
-&main_uart0_pins_default {
-	bootph-all;
-};
-
-&main_uart1 {
-	bootph-all;
-};
-
-&main_uart1_pins_default {
-	bootph-all;
-};
-
 &ospi0 {
-	bootph-all;
-
 	flash@0 {
-		bootph-all;
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -161,43 +90,14 @@
 	};
 };
 
-&ospi0_pins_default {
-	bootph-all;
-};
-
-&sdhci0 {
-	bootph-all;
-};
-
-&sdhci1 {
-	bootph-all;
-};
-
-&usbss0 {
-	bootph-all;
-};
-
 &usb0 {
 	dr_mode = "peripheral";
-	bootph-all;
 };
 
 &usb0_phy_ctrl {
 	bootph-all;
 };
 
-&vcc_3v3_mmc {
-	bootph-all;
-};
-
-&vcc_5v0_som {
-	bootph-all;
-};
-
-&vddshv5_sdio {
-	bootph-all;
-};
-
 &wkup_uart0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
index 03dc81a4afa..0f2c592593e 100644
--- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
@@ -93,14 +93,6 @@
 	ti,sci = <&dm_tifs>;
 };
 
-/* Main UART1 is used for TIFS firmware logs */
-&main_uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_uart1_pins_default>;
-	status = "okay";
-	bootph-pre-ram;
-};
-
 &mcu_pmx0 {
 	wkup_uart0_pins_default: wkup-uart0-pins-default {
 		pinctrl-single,pins = <
-- 
2.48.1

