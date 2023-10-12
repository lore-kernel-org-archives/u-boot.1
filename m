Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D344CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE1086E8A;
	Thu, 12 Oct 2023 15:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQ+M4814";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F8686E8A; Thu, 12 Oct 2023 15:03:00 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D81786E73
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAd2N4rjjGWOEmBPwSDKM+YoV4V14AQXXyca9NKm/O0kjdt++tdAGeJeoWz4H/Gla3Xo93huumIZkOOboGXGvKwfAtaG29tfX8J8E3wgl45NtuatJd+xfdVQLIr0A9vZfeEhzDuemOdJ5w017fj+E8qcwNyIJcncqXDzNlriYPl44zv8ahcCsNcsVsCOEDq0HhJpSTZF4dwrGS7fImESNR05jOY0JDNWbbtWmE6/XvguQLPHemB8sCkD2YIOFtjUSVl1sSLbbfx4+u8EyaTpN/HFkRZKC6KjPhPP6hIxa0Mkr1k7UGmaKLw2i7pb0Si3o1wVuVtQASgPz8LHSHDmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sZ0zMvs6TuX1nY2oQWc1clEKa2kkBCpPtxKxbKYgqs=;
 b=k0KgSYnQ2Os0i960DoVLSigJGpUf8n55Mf2gLfjbJrWSLKaejBb9Q1qjw5XbYNXLtKs6pi5MnmtAUYn0ubudL/U2a0Ml7qBWIApS4UvA+8pukvKbKOpSy912K4D1hR7ZKvfgAAvjMklpl0Npt302q0Js1dsh6SavlL63AKa4RWnW242c/eKYDnvAwmj+KTvE682cPfVC0kCrl69x30gLNtRx6JHxTnt0jlE3SNgKDSZe92c7C04FXFG6vM+xoWHwmEjLo8CxYKl7cv+EOf2FuA/sZmk5UOcIHSDHMWApt+AjxomZi3vpB3liNpT0qccbmtBRDYs63IeV2D1k0Oi9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sZ0zMvs6TuX1nY2oQWc1clEKa2kkBCpPtxKxbKYgqs=;
 b=dQ+M48142K6qgQJolPX4Xa9CATeRJUPDwoTxoibO/eVLotxe7xxeEHqIdIl0atdMXO8lpkkJ2+XnEZYXIFiL6Nl7rNb9AcBb3Ga2HySFTNUYM2SqD0gUeqw+rYV9evsQ/0OtWT/KFoHkb1dKbItWVVB4AHDfjb/YK71jsUCJkeM=
Received: from MN2PR02CA0036.namprd02.prod.outlook.com (2603:10b6:208:fc::49)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:00:45 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::c0) by MN2PR02CA0036.outlook.office365.com
 (2603:10b6:208:fc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 13:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:00:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:00:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 1/5] arm64: zynqmp: Use mdio node by vp-x-a2785-00-revA and
 vpk120-revA
Date: Thu, 12 Oct 2023 14:58:47 +0200
Message-ID: <6c60f5d29b9d9992bd0130fd263c8ed13cb8166c.1697115523.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1697115523.git.michal.simek@amd.com>
References: <cover.1697115523.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=iY/bbofM0X/63ZnR8a70geSajS5wDrlC9HGkdDVuEyI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1tx16r53kZneGiu4vyHhwPSyHM+zHTJG2GP7EtX9/u
 CvIPFPuiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABNZl8cwPyyj9+I5Jt6DO3bM
 X6gg+NamfmP7aYb5Pm/kVr957MDJpcKbdjJ1TvQC2RtfAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: ada474f6-b8a0-4169-0d03-08dbcb233e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oitz1v3vTue83fCyKi26ZYkvf9MPg27vrrMSWsf8XJaSpr/974XVCXaBbOAAdV18hvjX+AFnHSFk4dh1x6klzymsSstBeY2rY77J21flTOymypjq0F1/agcGSWg70qbPzOD5EltZb2Cw4Cx/NsRKtEZy8B+h0hNNGlbjGpXhztKl2ewzvS5TkLbB/9ZGDJQUXrFRInNvSx3pjLn7fVN7AKptZnQfFN0DynGdRpO14/GKR1GQzlCtpEnV62k6ueQPx+x7SYGTWpqgAxbYdJOUyt1ox7lpueRtlFUVm2AcH0a0zihB36kY1anLBfcJcQ7dwBJD0V2z4HAwqprOlRg/p8hiq7ootccxe3WdntyzOf06zV8l97cZwcpLtZdGFdq25MX4MSMFWs01N7h2K2ilVU/FN1/1VNBeP+M0tjRxiPpzyqYv0coHqBJE4VAWT7PxFvRtXfGAwWnWqtddGT08D0/EgoDE/hX9ctUN4dlGMnBkSk0v1KSqp3Kg3OpHzBgKjlEZ+Ze7XEGEPI7FYWJUQYr7PE8SWhVyenHoqao2gn8yD0YsuADNczYMinkwXMQFtw31KKLyP4v6gC4spAC87+3u8NODA/Do0grB3f7xxupOsIeu7QRO5dbvZJV01uIk4fOtq/IkFZOd8HQrYyiEbpODOlwNvu1AFVjUwm3mqHJCCCwq3QyHYreaJaEj7FcbscNXvFlCLLbKIlK2K1GKFXno5iR14yS9sySeYlQlQFLXfRbRqIske9nUwCb2wo0x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(16526019)(26005)(47076005)(336012)(426003)(82740400003)(44832011)(40480700001)(316002)(63370400001)(63350400001)(83380400001)(70586007)(70206006)(36756003)(110136005)(81166007)(2616005)(356005)(86362001)(36860700001)(40460700003)(478600001)(2906002)(6666004)(966005)(5660300002)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:00:42.9472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada474f6-b8a0-4169-0d03-08dbcb233e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

All boards have been converted to use mdio node that's why move ethernet
phys under mdio node too.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Same change was done by:
https://lore.kernel.org/r/ff165281a70a38e2b76fee91e6255ce95ce8021b.1695378830.git.michal.simek@amd.com
---
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 10 +++++++---
 arch/arm/dts/zynqmp-vpk120-revA.dts        | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
index 2f88aa4a0d28..9ab8f5bfffe4 100644
--- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
+++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
@@ -119,9 +119,13 @@
 	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
 	is-internal-pcspma;
 	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
-	/* phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
-	phy0: ethernet-phy@0 { /* u131 - M88e1512 */
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
+		phy0: ethernet-phy@0 { /* u131 - M88e1512 */
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
index 66919f578e02..ce76e0b3db36 100644
--- a/arch/arm/dts/zynqmp-vpk120-revA.dts
+++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
@@ -120,9 +120,13 @@
 	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
 	is-internal-pcspma;
 	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
-	/* phy-reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* reset-gpios = <&gpio 142 GPIO_ACTIVE_LOW>; */
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
-- 
2.36.1

