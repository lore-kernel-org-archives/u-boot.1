Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9DBCD8CAC
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF1A84884;
	Tue,  9 Jun 2026 09:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pzc4tMiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A2F84841; Tue,  9 Jun 2026 09:49:01 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7118487C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI2vvL5LwcUCwUVElsZP/Sqs6IkUYUgohLbO1LvBclkcS5NIVxcE/jmqzIFJ75k17O8v/a9msk18Jtz7+VeNgzG2+BSUtncV+3nwwoe0lT8O+pcXDr6xqGt4AZONMIzrmiUjffQz3PSqEuNcxVlaLTDTmFmrPTgN6yuzM18qwcVXXmVzGGyZk51/KjHVPodYQlB9oLf2+tCWvdYZnz9ND2CGXvbc/Q8+ilvxe3pr/7sVTQ3tgNeKIXoeHrGpNKsrohFVH1hgPzNb/fOpTP4uRYajolLxKESd3xQblUnZwYeJ9niG7ffJ+csCpmzTsl/LLhCpi125z7jX/+8ST5oCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmvhN/tU41SiQUZOtvqQOVBDDN3T+AfganpEtRF1ulY=;
 b=VCrc4BH+3lPLldlJsIWJZHHELCopOEvdZmMq4ZbGXxv4O86c/VfQiB7Mq7cmWX8CLgyFCevdcIBo1t+O/gxAO54VH3j82wHVuqCoSrfE14LRCFEsMFoWi7uWYWxuRC/5pYTjcv5baTKwvAvA9tRdbmeJpk3gIOL3MeZwLXNjkOfAP8jW76amsFW/v/nhrfZ+4xne68L+9+RlY5rt6jP8FH9WSL3BLotTAalGyixFUBpx/cO/hKoo+mvwNCdmEV+l595UW8pC1donQZmgo4R0RHKltvmdKn3JBebqQG+oZPgE81mP+TrEwTjBB5eC0CDqSo3QMREdLeoMr0266Jah9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmvhN/tU41SiQUZOtvqQOVBDDN3T+AfganpEtRF1ulY=;
 b=Pzc4tMizuGwe2NvAhgV6yLVqQTPrxUqABEDKMVme6xeN1rE2MEw3Yo3wCByTSCFAELWGMdZk7YDQbm0NAcJMpWiJFTSkNbGG5KQrsMt3FLzjPK4C8peW1mOYnRts2LNEzqrB9fm+GbgpkI5c7AyydHYneVl+a7iI7s2t1YEncFw=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:48:54 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::4e) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:48:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:48 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:48:47 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, "Rob Herring (Arm)" <robh@kernel.org>, "Rohit
 Visavalia" <rohit.visavalia@amd.com>, Shaikh Mohammed Suhan
 <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/9] arm64: zynqmp: Drop incorrect #phy-cells from
 ethernet-phy nodes
Date: Tue, 9 Jun 2026 09:48:17 +0200
Message-ID: <d50e4ed12227609f3f827acde885c1d37782b8a9.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9229; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0MSOGde2pWRNsOSjsu/8tTJJDnMo6/FLhWVwvDPvguA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH3Vlu2540s5k71ztLoeNy9ecWifHwKcp80zDVH5Wy
 KbaVHaDjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIYSrDP412uYux7m9WyGpo
 W62ZZGPyxyVQiU39Vm5uWWOUisCl5YwM/9c/yiuWujvjMpu98Stnxvjni4L8N7GbT/3QPXFipeU
 jBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e11f27-8890-4ce9-e48f-08dec5fb8da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YPsSiWUYJKizQpDY5SuJJhnxNmMud+QcjjFb6EY/GYmDiy4mTu5ur++QYes6ANCydF+f0ztfVpxOZNDqNbIbgggVmVXjc5uaQqHml1n0X6efLefbi8o7taKRDfKtqgQu5fA6MVNAg+b+M3zNDEH/yg2GbOSJRiTJuNVE2NaMv7vG8ziXyVqYGnMBbqHo4hG/MrjixoyI8XxL3G2M5+dzoBVlNQMgFqICJuWuxtmTUHwFW7BaI5no/cPN94R/ezQd24/5OvzztOOriWESJnZjSlRpQea4NLGMyIONPuvd99JkhX6htXZt+ICh0yzQdv3i394mc7gCfHeeJ95T5XKjHUiX2c5ahLbU4mCIdRWHPhMgjaVIUeUHG21LRZ352aOVGhwgSGPnUiV5HfDdEv3wktiwDzH5v9vzeZp5+JgUL5m2Nptk7UArsSvmaMnxkELZyhC2lJhtq/Xtu3aisXpZ3fAuCbmE3qY2cHyvHnzCoKTpoN9nwxtBYm3Txj2NkcXKu0dPUb62AbNSyK4F4VicowIKKFubWZoqjb+6HiqYgczsxtYa5yksw9xs3tCjGPFETQusDi+QjyszYz8fStMciwOaECMrwy2NWdqCxTeXSvXF4iPioYNtoa2GSJNhM2FXSqVgAROJsFoQ1YxM6+QHvFfGNkegpSRspVSqSr7t1wjcLZx2lyXgYq2mQJKbFdSH/NK4C+2sxyywHvwQB6DenAIbEHQKxSyRB59imrncZPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wbCzp5SCba3nPIp0/kMC/S3HaNeXAdmYYSRYhfNxBsF7eN5wMCU/UNWmVkU60z3Qpmxcao8jwHdkMkFqc+i2a3kEc+XM+PTE2PSElLNDlniT0j74ILNHXuMZ5JcD2vdAoW+YmQVWj9HTng/8VVl492NO2sp4FZ6jJDhvb8MIYg4rEyZI3HEVOJEqiz3BjWPAqYLr2YSKDHsKdsq/AqA7wVpNSJyZDYhAG0HSpnww1mhix5dw0V13H2ubsIG6OhuN+gNyalIg+BUSqMiqkPW/GnN4yV3NTzbI2N54pjKdUysaoni0AvEke4Wwaky8BqMVN+0BVjOpcg4BbG7GgS+X1v8tDuOsNcW66InJ/gWkKn5wli+zk+2C4ZFiUfDut7IOE9jlPXTHEp9fIDHs/wx5QEDxp9QOnq/iCB5u37wOzh0Y+ezYx3o9LcxD9yiH56+D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:48:53.5795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e11f27-8890-4ce9-e48f-08dec5fb8da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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

The #phy-cells property is meant for generic PHY providers
(Documentation/devicetree/bindings/phy/phy-bindings.txt) and is not a
valid property for ethernet-phy nodes. Its presence triggers a
dt-validate warning:

  ethernet-phy@x (ethernet-phy-id001c.c816): Unevaluated properties
  are not allowed ('#phy-cells' was unexpected)

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-revB.dts        | 1 -
 arch/arm/dts/zynqmp-sc-revC.dts        | 1 -
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 1 -
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 2 --
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 2 --
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 1 -
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 1 -
 arch/arm/dts/zynqmp-zcu102-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu102-revB.dts    | 1 -
 arch/arm/dts/zynqmp-zcu104-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu104-revC.dts    | 1 -
 arch/arm/dts/zynqmp-zcu106-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu111-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu208-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu216-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu670-revA.dts    | 1 -
 arch/arm/dts/zynqmp-zcu670-revB.dts    | 1 -
 17 files changed, 19 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index 6181072c1da1..4367136cae8f 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -136,7 +136,6 @@
 		#size-cells = <0>;
 
 		phy0: ethernet-phy@1 {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <1>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
diff --git a/arch/arm/dts/zynqmp-sc-revC.dts b/arch/arm/dts/zynqmp-sc-revC.dts
index 530a4a5f080f..b9b192f09864 100644
--- a/arch/arm/dts/zynqmp-sc-revC.dts
+++ b/arch/arm/dts/zynqmp-sc-revC.dts
@@ -23,7 +23,6 @@
 		#size-cells = <0>;
 
 		phy0: ethernet-phy@1 { /* ADI1300 */
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id0283.bc30";
 			reg = <1>;
 			adi,rx-internal-delay-ps = <2400>;
diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 8342479b108a..021bf8ac26e6 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -148,7 +148,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@8 { /* Adin u31 */
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id0283.bc30";
 			reg = <8>;
 			adi,rx-internal-delay-ps = <2000>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index db042ffb4f36..048aeb1e7654 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -265,7 +265,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@4 { /* u81 */
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <4>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
@@ -277,7 +276,6 @@
 			reset-gpios = <&slg7xl45106 5 GPIO_ACTIVE_LOW>;
 		};
 		phy1: ethernet-phy@8 { /* u36 */
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <8>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index e3567d0abfe0..2eef6ba7df75 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -266,7 +266,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@4 { /* u81 */
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <4>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
@@ -278,7 +277,6 @@
 			reset-gpios = <&slg7xl45106 5 GPIO_ACTIVE_LOW>;
 		};
 		phy1: ethernet-phy@8 { /* u36 */
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <8>;
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index f93c7460a552..ea947cd2dc02 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -209,7 +209,6 @@
 		#size-cells = <0>;
 
 		phy0: ethernet-phy@1 {
-			#phy-cells = <1>;
 			reg = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 70de6933600e..ea7b9253468e 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -200,7 +200,6 @@
 		#size-cells = <0>;
 
 		phy0: ethernet-phy@1 {
-			#phy-cells = <1>;
 			reg = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 6b1aea95e65a..3d71742fcbee 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -217,7 +217,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@21 {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <21>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu102-revB.dts b/arch/arm/dts/zynqmp-zcu102-revB.dts
index 3c28130909bc..bad59d7b1d26 100644
--- a/arch/arm/dts/zynqmp-zcu102-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revB.dts
@@ -19,7 +19,6 @@
 	phy-handle = <&phyc>;
 	mdio: mdio {
 		phyc: ethernet-phy@c {
-			#phy-cells = <0x1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu104-revA.dts b/arch/arm/dts/zynqmp-zcu104-revA.dts
index 0bfeed4293cb..b4e62bf6bb61 100644
--- a/arch/arm/dts/zynqmp-zcu104-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revA.dts
@@ -126,7 +126,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu104-revC.dts b/arch/arm/dts/zynqmp-zcu104-revC.dts
index a7387f4a0e6f..f7a91402a097 100644
--- a/arch/arm/dts/zynqmp-zcu104-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu104-revC.dts
@@ -131,7 +131,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 7b1097579fc2..5eb5f77220d6 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -217,7 +217,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			reg = <0xc>;
 			compatible = "ethernet-phy-id2000.a231";
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index ba1b63391005..72d331a740fa 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -189,7 +189,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 888f711aad97..70b1e81e304c 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -176,7 +176,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index ccdbf8967aa0..bc0ca24ff050 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -183,7 +183,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
index 058d6b2e6486..1215babe2146 100644
--- a/arch/arm/dts/zynqmp-zcu670-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
@@ -185,7 +185,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
index 010d412b2027..e91f280e4576 100644
--- a/arch/arm/dts/zynqmp-zcu670-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
@@ -185,7 +185,6 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		phy0: ethernet-phy@c {
-			#phy-cells = <1>;
 			compatible = "ethernet-phy-id2000.a231";
 			reg = <0xc>;
 			ti,rx-internal-delay = <0x8>;
-- 
2.43.0

