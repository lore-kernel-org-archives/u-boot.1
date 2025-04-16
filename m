Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85321C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 08:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48B782C49;
	Wed, 16 Apr 2025 10:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aCWwKYVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA2382CF6; Wed, 16 Apr 2025 10:42:29 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B87812BC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 10:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcq7wKkFRIDUQrMLGfvtGadn0a/W0Dv7fWvmygQ1K8xXJ56fqDFatdhvFC0p8Fgo0nFUg+6YedybUzyBerx776i8Trog1/b85/bB2dNIL+6l6e3GSvQgEkaT6pnKHTKIPOztvGbyTWjms9SSclAO9XNKaYYatrrnZFhKwHCMKfRMdA1gg+Z1XOL1FkKDa7mbiyRYj+eBW7mDrTf3I2o9guSAakAxuGMtizGZcTtKMZLzgyY1KBquf/wSBJGeT2hNVbiKxCZjnhovihjaTqwm+VWzviYP+7KihYKNIRk4i0mf2W4EYmN2WuFP6MN967N2BB/cb1j3ecI8TRJa6hhWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWNg9z8490HX0pIxeAMzqkKPUA9qyBZYFKR5P5EOW04=;
 b=AqES0x0Y/Wypg24OHJjjDm2PtxeJWO+TNCWTgYR2+/V15iE3/G4nBgRkREjb/LKk57yg9sAbVnaYvqlOQI5FvMAo9mAJdSK5lH2aDMzvtq68I+zspt0e2f9VQcvM71/yNcBfsa5XrUSn9dbhFqeJZRC5N4awTJnBR1F4i2rrpTm8TE1muGbUskibQGp85+wXqB6nygK5Iu3P1k4cOt14REaX4sUjb1kNT9M1/FdOHP04mOsZpm+83Hhj+MkeTQ2UfKx8FMKMUbiPV3uuumnP6IIX9xuMcubpSAGuN76K8P05xfiV0D97xng8fW8hrLX2Y6i9ARo444HKKVm1HDvc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWNg9z8490HX0pIxeAMzqkKPUA9qyBZYFKR5P5EOW04=;
 b=aCWwKYVsDUQZNpxrIyCE83bbIhMylS5QkuXpa/wiOquWGGYrHHNri2XRVevqE54SUbQX8CUeWsfknUHMuOySLphja/jBPdQOmfrm9f3G7YwzugqHpEn82gy4JBPVn+UwE/O+H/EiVdypNywifeqm0dV6P0eUSXhIxLbRDQW7O3x5l8jKbJx/numAWQ72AfLrndoRIa0qKvJPJx/iGeDJXxzz55N6WUyvyFF5eNilGqTJcxq8vfcCCldIc9JghXsZJrzjY1ero6wIedZdsu49tOjRxqGBOpMtrhExkgjhGKmQxi2QcAjt3Bhn239XTqxod2CTEWNodBoHLICV87TMmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3873.namprd03.prod.outlook.com (2603:10b6:408:2c::15)
 by BN5PR03MB8111.namprd03.prod.outlook.com (2603:10b6:408:2ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 08:42:22 +0000
Received: from BN7PR03MB3873.namprd03.prod.outlook.com
 ([fe80::92d6:74fb:1062:bd9d]) by BN7PR03MB3873.namprd03.prod.outlook.com
 ([fe80::92d6:74fb:1062:bd9d%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:42:22 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v1] arch: arm: dts: agilex5: Set SDIO_SEL GPIO pin as output
Date: Wed, 16 Apr 2025 01:42:12 -0700
Message-Id: <20250416084212.14313-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To BN7PR03MB3873.namprd03.prod.outlook.com
 (2603:10b6:408:2c::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3873:EE_|BN5PR03MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 16351220-c928-48b6-628f-08dd7cc29b38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F20zJ8BCMVMlC47JWIld851mNIQyn/KHgix5EfRV0jiHiKkvJBYXR+4PIUOw?=
 =?us-ascii?Q?BAxmWiF90xrb+N3RGlUKcUh3/tFF8VAcvh80vU2WWV23dWBsfowe1QWlyDqd?=
 =?us-ascii?Q?W8/RNnjQIudh9QMa5K9ysF3/F/3yI03oxdKriEYcbryKmi9SZTZ+6h+h8zhj?=
 =?us-ascii?Q?57kPIetUhEa2oBKAHNqBq1vFAbno3wNWAjvjRKOISTwgw7nTgkJ1wblHGFtb?=
 =?us-ascii?Q?l64j/em3P1Ad56Re8y9SOtnQ3aHr/oecKltVh7B/Mrjbuw9GZJ7O+26uC0Ty?=
 =?us-ascii?Q?CtyYkJgh1Yl9Js4j66KysZlpkyt2rYpyAppRP7LmF6fPVSL3WDiGNG7pCEiB?=
 =?us-ascii?Q?xQIgK76o1S3XTV9pRi4ZmDTsql9Bzu0N5sABrG/sWGeTjRjoc1KHTxEw0hOy?=
 =?us-ascii?Q?QDx+vp7qE5Y1kadgJvedkB4zrm5AqMAd3R3GkhiCe3M5b50EOXdYJ4HlgdWv?=
 =?us-ascii?Q?HdXRUN+nwemWOHM81ZBpbyky4kxHpVfnG3U7863Ll9fE/6TLoyQfFdWS2Eu0?=
 =?us-ascii?Q?plP7h61Q7iJFjkbgsC2MKAIns5T8E+BoUt3N1Kic3dszhZ4sD4PBRlmGO5dc?=
 =?us-ascii?Q?uoRZY554GJZsPxE1TYgtBP9bEEiRZKPPVRlBlRmShQa3kCRMYrAJgutBehPl?=
 =?us-ascii?Q?d9Atx9ho+oP7GA68FMGV93l0sS90VTNh1feQWuYlqGtM0c8rnCRJmGlDWnIu?=
 =?us-ascii?Q?fN5BaJVsnUzoN/QTxnBICvk8/2DQs+k/Q9vbJJP4vEPN9o40SnLqTf6Hm7YS?=
 =?us-ascii?Q?vg9hO3dcVYQBI7bNaW7KYujTTuGidTiCJJOfyQAjAUPK6SPQ9BtbCZBNfwrM?=
 =?us-ascii?Q?mhyJXrnRHdS0+OG2VtzoYwvM+ZmrWhy8eMrXH/2Wr5VIwUavQJat6Q66HaHT?=
 =?us-ascii?Q?V32ocVWLVDqBADckvCB5AYwa0b3MWV9ydFRA4kVQtrRovlGBwWORZYw3tF6o?=
 =?us-ascii?Q?2gkAxQTajA4HJjEVvlU6gObQqcfdYbeGBevu7TO/eHtNuy41U8kKkqX6wAp9?=
 =?us-ascii?Q?ptCcJYRIUGJFnRjxVlUCbRC0h1M/iOpGSn+Ye9IjmChy5u3bj/1ORroO3qhc?=
 =?us-ascii?Q?qudIF1RNlXdA0KhGhEn7ip7EzmVvFNlGHuH/95MijfSq5iv1QIZ8FFBeRsdD?=
 =?us-ascii?Q?8so9L+DX/bShj2cAugtXoz09REc8zkfrZSxyIyOwK7mklAUvva+roMyQZF2W?=
 =?us-ascii?Q?fv2RkFCKNMe2xRk2StpFMi+my2BEAWl7Ji6xJf+1qm4Bd5qVsczsZUzY0EJS?=
 =?us-ascii?Q?RvwsHjZk7tX7QWzAqV2rFnrsRPnH7lLQ9mo+h+2aFrx3nJPQqv/ZhZNSw3Cz?=
 =?us-ascii?Q?h+GhVoC21zuDTcsA0xaeEYPWNtPgZtWyVl8/CBXGg6zQ8aBSAERbe8CTXx75?=
 =?us-ascii?Q?44pJjD1g9LaF1N1kGntdt5eDZ0wi9P33UMkmaKTeFjfpX85TrAi6bto5ALwP?=
 =?us-ascii?Q?x2UXEbOHnXE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3873.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFawj979HAnFRDCPYjm3xngIyfqJt9tj4YKdaaOLni6i5mper32kDWTl1snM?=
 =?us-ascii?Q?zj6BuJN/tl8cJyxqns6ZUvfrKwwywNPd4nkeQyLilYanHSqHkUx4/A9LOt87?=
 =?us-ascii?Q?b3rGABm+MHs3hQguPU3LCmrIKPqtaeh6UifkRiatL3/LAwDwPk75KxydPYMO?=
 =?us-ascii?Q?QNpJnzz0NWvau9RSoj97sE9RUIgMnemBnaVd04czg5L1GVT/3dGqFz2WpwIB?=
 =?us-ascii?Q?JpyNlosdDPD4pUqgCKwG5nbHb29InhM4PLJVDJBlXjBNmvBMDw3cjZPl2Y1S?=
 =?us-ascii?Q?Cr0MjdUgRWPpNI/TcYZcpTE7iaBoEiEim4NPcZfYxdZV6bPEIDjhEnhp3vao?=
 =?us-ascii?Q?C5wtG175guqH5NKz9GC+5jbwqosbrqmC50jZkI/Vj9FA+wZCFUOftM1E1r4w?=
 =?us-ascii?Q?Vc7U4XzICaSPpn0+xAxo2QAyqIKUGFks2RHCte3fBb8M1UE6DE4c2zSCYt7D?=
 =?us-ascii?Q?VZbKn93Pgcm7CF11RCe7IQRjiAuaApy3I2b/c2u8yE930QHSGZVP6CAttCsD?=
 =?us-ascii?Q?IDs+A9+b+jJz2b+5BorW3POYGrUI4gAHRVEh7hihC15ohjXysOWNkm+miOMH?=
 =?us-ascii?Q?jfHywQeLcXM98XWFD+YsJPX7ESm5gAWDJnNZD9R2902FTUspjRiy/rh/51r1?=
 =?us-ascii?Q?fKvEY3porho0chdwp6T82yloDtbOD0l6LR889PQspMMM0D6iD7WEbR1X86J2?=
 =?us-ascii?Q?33Jky1J9ZiIT9jCAAT5+I3pU5ZCfG7/lAPylbIlkXOCxSt0FTNYrglM5t3VH?=
 =?us-ascii?Q?YD5ZIvToAz/oOyn3YgWxi/ZnH7TtyFenZkOaCnvg55HTYw7NyfWi7U/dLDm1?=
 =?us-ascii?Q?hs9/5btGIPbNBQEkeQNIVBIt7cHKy5Qi74yRjtenWbMN0GiSzBdv8Agkwcz3?=
 =?us-ascii?Q?yDFaAwjbtCP5J8Fvwoe62nvC/ao3i4TwhUXjc9tNDHjLaWLCY57Tlz5H9VvO?=
 =?us-ascii?Q?Ux52wewbasWSm4iqolr68Ezik2v51UtYZzv/wLAHVff2sLPk2nEqx01WYNo+?=
 =?us-ascii?Q?NHoxE+6xovWo/4GYBJTntrgzqFdU7OHksQu8qWHWetHPTCrIhC4yfY4fbN7z?=
 =?us-ascii?Q?JvqC5ygFNErV//tJ1Bn1seLmAYcx1OBMYfpG5yMXPtLHgT9ij9U+hMrATHkr?=
 =?us-ascii?Q?0lT033kx81X/7S/7mRCibvHvHU96U0PDeZkuytURuGgVeFWR5o0tIBRSYnXw?=
 =?us-ascii?Q?3/Z6fzTcjf+efxuijnspIjHjCYxjpXaZWsgY5SWGM6HgwYVa9rCnqV3VPiCE?=
 =?us-ascii?Q?fN0emYs5cOeIvzcp9f3qSOs8jW4C1fYuNMGUHpnnV3upCiFmlzXoyZY9T3d3?=
 =?us-ascii?Q?8S+amtYBj6pIwzTK3tuqjTQfgsNY5XUF6SjKpGJ6rVpavBFMIHCuzGJ9/QCa?=
 =?us-ascii?Q?h9fUrRaFxu6SdL500nTNHeH50PTdCmi/K4kfjGNju2Cihqtwv4irs0kjKPNv?=
 =?us-ascii?Q?gdjPTP6hyIz1uHE/34DhPXjNfMYItgyK6o29AJYcPFmFnERlIWcKEPWCUn5x?=
 =?us-ascii?Q?plUFhYk/E7C70R+IdL1vm0JF++J4qELLO4PQRFoTvuqnc0naRzylfyjfL8aq?=
 =?us-ascii?Q?cYNDpFWM3ebP1h3Lpxo2Rir7X29txtljY4nJrW+11n8bu8OoOf/cE95XBNws?=
 =?us-ascii?Q?eXQWYErTXJ+BEIWTqfoXWC0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16351220-c928-48b6-628f-08dd7cc29b38
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3873.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:42:22.7933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oJBTVsLbggfOD/U7pKVV2WZsPcXQYrzuuWh2aRXOpZIfdLukDsQAisW+TYrqF1wcjoaT9fEkqjBixhiEqYkHSYM8RxkegRxKQ5lPnTbIJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8111
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Use GPIO hogging method in device tree to set SDIO_SEL pin (portb3)
direction as output with value 0 after power-on reset.

This is to ensure stable 0V voltage reading from SDIO_SEL GPIO pin
after board init.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 11 +++++++++++
 configs/socfpga_agilex5_defconfig        |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 8d6503dd091..b34af85c58d 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -673,6 +673,17 @@
 	bootph-all;
 };
 
+&gpio1 {
+	/* Configure GPIO 1 pin 3 as output pin with value 0 during GPIO probe */
+	portb: gpio-controller@0{
+		sdio_sel {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+};
+
 &i2c0 {
 	reset-names = "i2c";
 };
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8f327e5f2ab..cf0d678e1a2 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x80200000
+CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
@@ -73,6 +74,8 @@ CONFIG_BOOTFILE="kernel.itb"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-- 
2.25.1

