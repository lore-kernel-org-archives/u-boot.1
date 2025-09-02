Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A1CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295BA83A7A;
	Tue,  2 Sep 2025 10:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1jaWtGSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0491683A98; Tue,  2 Sep 2025 10:54:19 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33BD82C7F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouzt5fpiji1RmDtbrrKsor2uJ1IrF/vjtyS9JSPFXXNLgzh9I0bRn+eu9z2YOPvpId41Gu7ZxWixoWxUleindlYR+hmlE899hbInvra28pQ8UbTNJyGoaAnbDS/qIqHu9fPhX0PBoJRmz3X6aHhbCWlSO10dTFKIHt+XKi9nN4+nV2zcEupNQWagBItBew1F6WoWZ76cyUROVwXi6kVnfGpl12g/P515yQdvgSA6SfJykNpFM1tOt0ipE1VoQE+nTvmrDKi/OHrER9abxUinpnOcNKXuSN72KCwoKYK3OX0FZTuwPokLOpu3X00UE4d8bz/7ls9JWxNe5xlKVbIpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r514/CXmhmSDuFt73RqA99jcPg2EnJh2108qYKzgUQs=;
 b=tYaUnJK+4YirA+OtpSqX4hnspL8LeqAn/aF0E715MQQzILQzkt6CnyoVj7EfqkBrQgfvj9dMx6Wt4YAwQrENrXsQHuclEcQGMIBIruSAiCyA1Usmf8SNFnCH843uEWjm7/JZAL2fdzJYOyeLF9J9ssY0ZUZgiODIcQAlvXO9binTW008Sexlyl6XnvdBMUEWSUFCjJ/R8ugZlz8whl7OLOfdO7cAvuUzebwoSMNG4X5UgbJcpQjyw9VsHNefl/uLQB+kFSWdh3IKJIuYO7mbyYYDRnunh8u9qh31ZhUvzfQwbG0mYAzw9XMudenhk2waf0NLaaTN5aGV3GwcH3i0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r514/CXmhmSDuFt73RqA99jcPg2EnJh2108qYKzgUQs=;
 b=1jaWtGSA8X2hW02bg9UHghQX3eBK57zevukjGO4+T2cokOsUisLyaWLbVMZwrBGHOtHuCnn1ozxqfpf/kSW9Wb7ce8sxh8TTFVAV7PbrmvO0TtBCkQQ4sLq9mOvwmS88m/9W89tDJTjw82G7McI5LalmH3mz4QlnqlqywhGd7S8=
Received: from BY5PR20CA0027.namprd20.prod.outlook.com (2603:10b6:a03:1f4::40)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 08:54:12 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::45) by BY5PR20CA0027.outlook.office365.com
 (2603:10b6:a03:1f4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Tue,
 2 Sep 2025 08:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:05 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Paul Alvin <alvin.paulp@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/12] arm64: zynqmp: Remove "ti,tps53679" property
Date: Tue, 2 Sep 2025 10:53:26 +0200
Message-ID: <609ee957931242ab6cde93e75eb3bd8afa769f12.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4384; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kubFSBVzRlbN4DtfFWw5tXGp+HmH50srcZ0AqSCAIYI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29A565BF3I0zNm4XJPXVX/HEXSoMUYquOnyOScDjz
 JljaqurOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAid50ZGU5x3vVj71g7Ybbr
 oeW73Vf7zUwxO5BxuCLmaNZsyUjhgJ0M/yxfhb3YxaC7rFX94f8KbzU39tZz+wX//+6Si7SLEBI
 N5gEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aeffc9c-d91e-4eda-92d1-08dde9fe4952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/u5fWKz2u5shxxGcdvna+1AC4Licd2sb/jVmaMiZZQkQkagss4XRlMunGr56?=
 =?us-ascii?Q?8xi0LpvOVwsYlwoQPiQc4WAWBbr5b3Zb9aAlf/J/jKjholgapaghNMmfKPjd?=
 =?us-ascii?Q?yxvnxJrqYWZ6gArhFrS8mBRKMdEqiuQG6MxUU5ZHNv0wwD7bexN+VdeBDQ5j?=
 =?us-ascii?Q?12ZTHL4k07hoXScuQmkKjVkNRkyHo7HtyFsWWkjeIK5z1OUV+y3Ss05bA7cJ?=
 =?us-ascii?Q?qxETDx52T94ot+MXX34NUo+TS3qD3/Pt4nCiaJ/4CZZH+OuncdpU5iQUeBBr?=
 =?us-ascii?Q?tGNHvcrcLv1vFrCMT0/Zdc3u8XN013u7Zx7zZOMVPWhNtWFVy6vbid3FXx6P?=
 =?us-ascii?Q?BOr3bRd1fmoML+rwl3TupKJNPsv5bJF9MopSAv3dyX2Tvq0rs17PioATFAQH?=
 =?us-ascii?Q?d7CeUhvatAGWaQBYDGdJnWepreN8tb27q+Fbows8mpKx1Ap+8gMghEY3pAw+?=
 =?us-ascii?Q?ChX1EsyvT5kqvYiOKFn8cYwmhVjoMiDD3n6GQBx7oYNu57voram7lV6mHmPQ?=
 =?us-ascii?Q?9Eh2dYC9RWDcLjalY86hzpIeSkDK39V8qd5ApiLIiCKRoGUQO3cPQImwLe2W?=
 =?us-ascii?Q?yrEzIPi0d1KJBlcL6kzl2BygF3gKiMSoeBanIow5jTi4i012zAthW4bqypps?=
 =?us-ascii?Q?ZloNnhvuiE70DlT0RV0RUju1CZijj5zDMETu36E5U0CdhKh5XnLnRluF/YkR?=
 =?us-ascii?Q?MSzjy3msyHuKMH3kmploRgnC0wP0k2B7V75llCZZSL5XXwURjKHwOfpqhkSa?=
 =?us-ascii?Q?OjfP1dy10Z9pKwjmH7rvZnFfyZvv7gq/A66BNMVPmRtM6JAF/733LNLORC3C?=
 =?us-ascii?Q?lOZzaSm7jf5qU3BD/Md08SgGk+NyTs+Ad7MbJfo46copCUpdlL2IwZefpRJU?=
 =?us-ascii?Q?Gh8A1bDHWuXXxlN5qKy0Ph76UIGGVyRbHWl8hMrtXiRmwsi3MSr6ndbCmiQM?=
 =?us-ascii?Q?3nGUnyn7m7HWcSRIxGfE6YfrulgoEq9+6V93KCEqU7uXGICi4skgtmuOOJKq?=
 =?us-ascii?Q?AJ+uIun1ikscwscq5DEX3M4V5EbdKt2pkY2OwvvGGnBYiUTeXub9frlub8AD?=
 =?us-ascii?Q?i+JT6T26wRgiRG/SpLRb7knWpBmh7INj6yluPCVto+dcU3iSrLPZJk6m+nDb?=
 =?us-ascii?Q?XMzHpKUcMfpnvUmFstSlwOZlwS8NPxHPRmMyqmrRY1fUmpsc1+l1x9wOKnN1?=
 =?us-ascii?Q?edKxN8xQw7BveLJaGWTgqymgIraAYaSU8V6hjVjqwPOIiT75pcC02YhjyXSF?=
 =?us-ascii?Q?BF328RLnd/SgsYYzjoCZrzNLSgsWHdE3QwHfc27kxI0SBpw0/gihkCqZlRnG?=
 =?us-ascii?Q?gJJn+vP1JS1/7BWRWyQ31Tx+uCpddK2jT5IsCRf2AFUSlCSAvfiBPiDRVIBp?=
 =?us-ascii?Q?Pm+UEXtjoaLfZ0+9SnJCagAnQ4ChpiZkyhDphgYvtiUKLAnK4+CYt19xuxHp?=
 =?us-ascii?Q?od5m4ZvxmFgTjgPNfOWhDJmWtYDbeeefjGztMP1tKsso6+maHA7DNB/UOacx?=
 =?us-ascii?Q?uJ1xt2kbZ2pBRKjH8mIPB9+UZSrzfdF+V1gM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:11.6226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aeffc9c-d91e-4eda-92d1-08dde9fe4952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
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

Linux driver has been updated that only ti,tps53681 dt property is needed
and there is no need to provide second compatible string.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-g-a2197-00-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts        | 2 +-
 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 4 ++--
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts     | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index 6ef8b1462eb2..27ea639b7417 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -267,7 +267,7 @@
 				shunt-resistor = <5000>;
 			};
 			tps53681@60 { /* u53 - 0xc0 - FIXME name - don't know what it does - also vcc_io_soc */
-				compatible = "ti,tps53681", "ti,tps53679";
+				compatible = "ti,tps53681";
 				reg = <0x60>;
 			};
 		};
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index c597adb80cb2..ece01e73d29f 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -256,7 +256,7 @@
 			#size-cells = <0>;
 			reg = <2>;
 			reg_vccint: tps53681@60 { /* u69 - 0xc0 */
-				compatible = "ti,tps53681", "ti,tps53679";
+				compatible = "ti,tps53681";
 				reg = <0x60>;
 			};
 			reg_vcc_pmc: tps544@7 { /* u80 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index eefe5ab61e77..021fdce4abba 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -244,7 +244,7 @@
 			#size-cells = <0>;
 			reg = <2>;
 			reg_vccint: tps53681@60 { /* u69 - 0xc0 */
-				compatible = "ti,tps53681", "ti,tps53679";
+				compatible = "ti,tps53681";
 				reg = <0x60>;
 			};
 			reg_vcc_pmc: tps544@7 { /* u80 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 7ea4eab6a376..c45822e1423a 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -248,7 +248,7 @@
 			#size-cells = <0>;
 			reg = <2>;
 			reg_vccint: tps53681@60 { /* u69 - 0xc0 */
-				compatible = "ti,tps53681", "ti,tps53679";
+				compatible = "ti,tps53681";
 				reg = <0x60>;
 			};
 			reg_vcc_pmc: tps544@7 { /* u80 */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index fce0d8d5ca11..6aae2ad642d5 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -178,7 +178,7 @@
 				reg = <0xa>;
 			};
 			reg_vccint: tps53681@60 { /* u70 - FIXME name - don't know what it does - also vcc_io_soc */
-				compatible = "ti,tps53681", "ti,tps53679";
+				compatible = "ti,tps53681";
 				reg = <0x60>;
 				/* vccint, vcc_io_soc */
 			};
diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index 620afba06e6d..40436e5f47c2 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -397,13 +397,13 @@
 
 	/* EXT_PMBUS main - J10 - disable extended PMBUS */
 	vccint: tps53681@60 { /* u1712 - J1770 reset jumper */
-		compatible = "ti,tps53681", "ti,tps53679";
+		compatible = "ti,tps53681";
 		reg = <0x60>;
 		/* vccint, vcc_cpm5n */
 	};
 
 	vcc_io_soc: tps53681@61 { /* u1721 - J1772 reset jumper */
-		compatible = "ti,tps53681", "ti,tps53679";
+		compatible = "ti,tps53681";
 		reg = <0x61>;
 		/* vcc_io_soc, vcc_fpd */
 	};
diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index 7849f8c540bf..e9c6d249a8d1 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -200,7 +200,7 @@
 			reg = <0>;
 			/* On connector J325 */
 			reg_vccint: tps53681@60 { /* u266 - 0xc0 */
-				compatible = "ti,tps53681", "ti,tps53679";
+				compatible = "ti,tps53681";
 				reg = <0x60>;
 			};
 			reg_vcc1v1_lp4: tps544@d { /* u85 */
-- 
2.43.0

