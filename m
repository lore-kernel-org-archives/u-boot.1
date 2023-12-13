Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C98C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 13:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8449687506;
	Wed, 13 Dec 2023 14:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WHoH2f/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3D687633; Wed, 13 Dec 2023 14:41:02 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75900874A5
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cua0l05hBVNQJGphLWDMEAjBGxc4/NiiUulChlaexpYZaxTyOv34EogSu78wpiKM6RxRuMvCtc9x97Uvnhkn3f7CFiEYD6FY3fo8gToT/XWfMzqVxmSbItfs47Uznl2xeO2h70UbF/QNi2EyFmKylfUELHyt1KBSvyiIqMDPvnnMVatlakVH15Pz4CtuQPHahS/se+ocVvWIgzmzaddRq4kzyPoPP78i/4GekkTyQMJYfHM990LcEWABWq4xw8Ux9PnzshZI9LrwnOpdJ0YARqcHAPjljEi4SDWL7F5VSMpH+FZA7n+T0QJG9XxOQufnsDqvCzlSRV+4BpAOrTvsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/MYSCLoGWRpKyxCNh7wjvBke2mPkWRnuPhydlD9cls=;
 b=RYoGFISBVeKzzbcm4gNabWB9zvMBnaO6RuP0fX7OXxJNDJzoYu8B+me6Uwnd+pGzkd3NnjtnM2Vi79mqAIU7rkEFX3pw/NtyBUUVW/vmSi5nfxi9Yum2WGDQIAhAMLOhmKjyFNQjVv/xz4dYdfX/7fd9KlPeB26ZhUFiX8Rjc5JWl83Y491BIGsyUR7U38zoFCixonhiRMRXgJGPtEJwj7YLFxIPHNOGFuCxr+21Qx2RDIy4RxnI45YjaCjpU0cCa93iTtI7hI8APW2U8QS0gnHKTXCatkMDyhBUOFKujJHnMirhAYX2o8NQhn/rNp86Xj1sK85IQLtcNEu1k6mXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/MYSCLoGWRpKyxCNh7wjvBke2mPkWRnuPhydlD9cls=;
 b=WHoH2f/d7d7UQ6ydef8uBjLkpjuOkJSMKC1vUbss/O+UzbmwO2LGzgJ0A8xYmUEf/TrrZUo9mJ49sfsDZ1wzs3xfntK31lJ4dpW9gU0YDieXMaVNj4AwHJ8BAUPb2U3UNqM0ue3KPQFYlrIw0s4iQOE1wCuxzDPyVAtxWtb3btU=
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:40:56 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::a3) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 13:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 13:40:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:40:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 07:40:55 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 07:40:54 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <luca.ceresoli@bootlin.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v2 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Date: Wed, 13 Dec 2023 13:40:52 +0000
Message-ID: <20231213134052.2818879-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: e615ae28-2d13-4460-fcb2-08dbfbe12246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBpsYVuatFPgtE4f7pI0DLSeCgXpFy5Wd34mWTr6Cu68ZQA5GXj644e61pNrnxcqOY4nL6xo/wZMmjQUqA+DbO4kdJZat1YKKJ1vnB/quDP9k6ttOVBE+w04KE5TLHUkmet5oeFXGZYnlXy4/eTmTUmf/UnbQfMbHPAOVFfR6xic3Q1rZv6GcmQlyw5HYUMnMefz7zNOIfArKW2yeZPEmXnKmPy8TW3JJdtCiLWOb4nvBa/mSvR4w4i4CKAfh8RW+0OS25YmvkqTQzfJgFNzo8rLBOQa3j3FvzqcGJjxjDS/V8e0+iGsPHCwlFLEl2OWjArixqJTT/p5ts+A/f2j9eRLPek8qyP4vqe5gsnZ4DpmbCABNp53wrwDMTxtRk4cwab1HOKWAPa9BuFQn6qX12gofG3Z6FepmBrCm4Qe+qbLe6ViNYjMgoSHayLa2EzWYcX57uoewsj7YhJxr9auVLf6fv6d2Ik+QBqd7yhNJRAoVKAWth+QKYhzIwHFVucZujpcGZvAybVKCqicvuuS4Ye+5F46ZCxj7OOPr/GmST69rbHbGKmRl8X9l8uczkyhW+MtOhHcHH/YzPhfc4hwy5MX1IJ94yZtoNX0kwIus/EOyiuUMM6MAo0/CvVAdldzrXYsRWmFrpCt2CIGSARFbdfvPpbbsaJrRz2/WTerkbUkB5WVI2aWNlML8Ul6iByjy5EgJsfT2qBf/gXPEkht3xeRkiBdybonBlN34afcI7Rj9zUJkGmqg8iXA3j5Jgw0fjhNRmhO67TwcJ/zIm4h2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40460700003)(426003)(26005)(336012)(1076003)(2616005)(47076005)(36860700001)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(54906003)(6916009)(70206006)(70586007)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:40:56.3410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e615ae28-2d13-4460-fcb2-08dbfbe12246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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

Now that the zynqmp pinctrl driver supports the tri-state registers, make
sure that the pins requiring output-enable are configured appropriately for
SOMs.

Without it, all tristate setting for MIOs, which are not related to SOM
itself, are using default configuration which is not correct setting.
It means SDs, USBs, ethernet, etc. are not working properly.

In past it was fixed through calling tristate configuration via bootcmd:
usb_init=mw 0xFF180208 2020
kv260_gem3=mw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
  gpio toggle gpio@ff0a000038

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
V1->V2:
 - remove output-enable from gem1 conf-rx pins
---
 arch/arm/dts/zynqmp-sck-kd-g-revA.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
index 56f3128528..12865392a3 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
@@ -175,6 +175,7 @@
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -226,6 +227,7 @@
 		conf-bootstrap {
 			pins = "MIO44", "MIO49";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -233,6 +235,7 @@
 			pins = "MIO38", "MIO39", "MIO40",
 				"MIO41", "MIO42", "MIO43";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -241,6 +244,7 @@
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -271,6 +275,7 @@
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
@@ -298,6 +303,7 @@
 			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
 			"MIO72", "MIO73", "MIO74", "MIO75";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
-- 
2.25.1

