Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2AECD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBBB8484C;
	Tue,  9 Jun 2026 09:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iy4oHsUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EE1E8405A; Tue,  9 Jun 2026 09:49:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A258484C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfWek6xBbJAiCKuJBLhLKK24KDFE6CqRz87m5MRzPnWhZhZKzklZUqLM0YOSqgUv/OpaZ3yL89/1W3lHV3V44GXDEBtNZEuVtCjyscLRBm+hzkUnm3TUW4/aDkIc1XGBBUlEnwbGSbKCJFiL1W0XCLqyAicS6ewexwuED49OmsSQBYpAFmWcXLKtahZ9pB8DiN4lJu8fX6oJj2jXuvIwMuOn+pnpT3yFT/qOl2ZsCcNuFGvSbv/ALup4vQmmqhsTAHxIR8iFcGfkYbBvOqCOEVzwDwFzDClpJKbSQPB+4HY3XrBc0mwsVYQtKCV16i3tY+diP3j0j1xKvaxaiqvExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzFzbv/MddoVsh6V3NWwAOUYn7C0pbfMBR+88eHKkQ=;
 b=rBelryEQBqcDFteZKF5ekt5Igj3T+qERHtcz6owM0mvRR1P/UH01fgY03xrrQYEvPlZ6IoYiGHS1OsdPdwlTFRATeegLLg2s+m+tRi604A3q7SudWUQXCxQDAx0v801rLyqLccvNpF3t3tUfqx0qCNIsIpUGp6vil2mzcDzv5so2VROXPX1Zo+difyvZveCGIESfdYE+DiYCi2zqdniETw07vaxs4qkM2uT5bMQg1LBubGcaSZmGbRDYA93f/ef9JZhIIczn2jcccyYy+evqlItqaqwUX9pDYFp3HfqYU7S+Nb375ZEnvmWLykYL1C9bgNqV5yIQy4vjekKR3yoyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzFzbv/MddoVsh6V3NWwAOUYn7C0pbfMBR+88eHKkQ=;
 b=iy4oHsUkgNT+u4kgLQqQ1R1lNqtjeBsP2ahA1DtE37AYLLISNI9qp97DVv85cgQhQVbV9Fdb237nTuIWIxCf0HxsKTR1XsQyjdtP3u58rHAb7ZMr8alo5rPJMi9i7tI249aZ0bNxCejGrJZuNpFUxgJzaV8vW4iSxnaIKeVYAVc=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:49:11 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::1) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 07:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:49:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:49:02 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:49:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shaikh Mohammed Suhan <suhan.sm@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, "Rob Herring (Arm)" <robh@kernel.org>, "Rohit
 Visavalia" <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/9] arm64: zynqmp: add USB hub supply regulators
Date: Tue, 9 Jun 2026 09:48:20 +0200
Message-ID: <541ee484c0f73fda630022528ddc56d01a481bca.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6810; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dvlQo2Q2lL23qx4AKVkdIOsPsyWGvNuFdRru3ajuBUA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH3X3f/lIZ93FN3ozHOJ7Hx9qmh628oBpqbnC/QfpX
 084BcwR6yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJdExnZDjy+byhvadU2aUJ
 LfOWmrMXJIln+c33vvQ9xDSqXsZNv52RYe6HN3f0z880eXb8pUZ573wVkTD/NRWHRYtV1k4WXlI
 kxQ0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: d547dbb7-44d4-49a6-46b5-08dec5fb97d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mFK7Kd09LZwFa/lW8nlYzdKJPAmFObapFAd8X6kj74xLrKSa/Loev4zMnWEvvsFSutXxSSsxuF/GDLA257esjbFLYRCVtkz+9DO4qSIVsQht+aGx/kE5KWGSNAbmQp4RfgEWZa+tjHBJTJuQm8Czyvq9RgLtIAdlajyFC2uSzn3H8WPXMOPnywWQzS+K8CWivRIbQLK/wRR25I9oaSg2Ml7mXBZHjBMe4jTxLaDkbA59kuzIbGin5anoLshIP1Ut27Y+6i6UAMJqVYqSH1khK2Sux2/lkgZXCG0v7/+50sEWUkU1GbBaLCt64XL7/yssUd17MFzo+Ga0+vNXEwJGJx10nCnLsMMzxfcvBUhGkE5gRQ5o5Sm7eFclaE8Z4vuHdQRehjJYjefgjENd0NgDtGoikUMGijgm2kaD9EY4NzaG+c1q1bjK7p6g7s/QIz3fQy4YKRoTOLdmsfhtrb1N5L181DO7XCjJdEDQikc7lxybI/oLQpof0rulZKb4q3Lrvti50Zalwp4ddcxOx6LWh+cI5hDTPwWS9udnAQBUMGF9mZJsrEHqcbJ3j/sh5qgjZyvqyJnhJYaXKK5k4cKNT6I5ssJS3q9DmIq5AO8sMe4SqL1fZtcwnVJuESWY0jPabRO8WdQOhuzGvE5/wwcc+z+M/cFf7WJ7VDTtZeVLc4EMSwuq6/I3qQ9V/olZWRC4Sp8hhxMJ7PmLE2iqNbGUa+7nGIzl5kB9M4T9n5HMjZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2wfidE2DWCR9IH0I/5tCVj9Rd3SsHlLLAWYua8c0DrN3vvkAzZkwXWRNMGh0LHvoZJCgakFXgINCqYYzhxt4d7ab6+2qd8Sj/7qmfS9NmnB9B0YOiZzt/gje+D0/OXJCUoU2T05HBVezudKfYuf24vKgb5tOedJFB80wuZ70YEqyrngo7hmHhF4GDvGdq2+ObJXJwugMoCeFSsRoykpCOWyRWEPtGFv+hcEEl9VBpY+J0wMGZkvUaqseG7gndWSNXHxgudf2SKtI9s8TmaBKFAbxg/qFIrIA184m15244ntrjkVX+pSgtXjukZlCsO0rvpQHoub26KlnTgd5eVWQj/dnk+zm/eStS9CEeUvJl20RxnqNypn0LzAhV1ARyqXPRH33CHlbO1CFuNxjTobXJzoF9U9m0OUovByEp5Dm7m12dSjVko9GNhIgRZnWdFAe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:49:10.6711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d547dbb7-44d4-49a6-46b5-08dec5fb97d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
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

From: Shaikh Mohammed Suhan <suhan.sm@amd.com>

Add fixed supply regulators for the onboard USB hub (USB2744) used on
Kria platforms.

The USB hub requires two always-on power rails:
- vdd:  3.3V main supply
- vdd2: auxiliary supply

Model these rails as fixed regulators and reference them from the hub
node to accurately describe the hardware.

Signed-off-by: Shaikh Mohammed Suhan <suhan.sm@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 20 ++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 22 ++++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 22 ++++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 20 ++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 20 ++++++++++++++++++++
 5 files changed, 104 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 021bf8ac26e6..02b9d82eb7c7 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -50,6 +50,24 @@
 		gpio-controller;
 		gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
 	};
+
+	vdd_usb_hub: regulator-vdd-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb_hub";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd2_usb_hub: regulator-vdd2-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd2_usb_hub";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &can0 {
@@ -124,6 +142,8 @@
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 048aeb1e7654..47f0fb5f74f1 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -85,6 +85,24 @@
 		gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>,
 			<&slg7xl45106 4 GPIO_ACTIVE_LOW>;
 	};
+
+	vdd_usb_hub: regulator-vdd-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb_hub";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd2_usb_hub: regulator-vdd2-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd2_usb_hub";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
@@ -196,6 +214,8 @@
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub_1>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -233,6 +253,8 @@
 		peer-hub = <&hub1_3_0>;
 		i2c-bus = <&hub_2>;
 		reset-gpios = <&slg_delay 1 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 2eef6ba7df75..b3c75f67bbd6 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -86,6 +86,24 @@
 		gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>,
 			<&slg7xl45106 4 GPIO_ACTIVE_LOW>;
 	};
+
+	vdd_usb_hub: regulator-vdd-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb_hub";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd2_usb_hub: regulator-vdd2-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd2_usb_hub";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
@@ -197,6 +215,8 @@
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub_1>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
@@ -234,6 +254,8 @@
 		peer-hub = <&hub1_3_0>;
 		i2c-bus = <&hub_2>;
 		reset-gpios = <&slg_delay 1 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index ea947cd2dc02..3c551f303150 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -85,6 +85,24 @@
 		gpio-controller;
 		gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
 	};
+
+	vdd_usb_hub: regulator-vdd-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb_hub";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd2_usb_hub: regulator-vdd2-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd2_usb_hub";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -169,6 +187,8 @@
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index ea7b9253468e..a60bd7b7bdb2 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -81,6 +81,24 @@
 		gpio-controller;
 		gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
 	};
+
+	vdd_usb_hub: regulator-vdd-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb_hub";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd2_usb_hub: regulator-vdd2-usb-hub {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd2_usb_hub";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
@@ -156,6 +174,8 @@
 		peer-hub = <&hub_3_0>;
 		i2c-bus = <&hub>;
 		reset-gpios = <&slg_delay 0 10000 10000>;
+		vdd-supply = <&vdd_usb_hub>;
+		vdd2-supply = <&vdd2_usb_hub>;
 	};
 
 	/* 3.0 hub on port 2 */
-- 
2.43.0

