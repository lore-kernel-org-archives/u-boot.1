Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02013CD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE2F86B09;
	Fri, 22 Sep 2023 12:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i90KL5yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1684886ADC; Fri, 22 Sep 2023 12:36:46 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B3386AE9
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt0JDVpqFtzqm8Cdwei8uL7E6rsj81RTrZBu1sXvZm0TJ4YS5UWp3S/2+1wQ/ksbZFepZ9YcpUsoE3Qq1I+WOxZ2C6JHz8UtjEnahhFzo73BOfqVz/CE07+jgSsxwnSNQd8EFoadsVfg18AQWOLOzg7BdKJYdXTOkWnQt1/pnJLFTcI1OoGaKMYNENSD02Sx6tnFubj66cDSKGfOQ6/mS6mJv+iRiiKvBuDV9pxwXnoEzFDuZ2IoMT+Yznd2Ibnp+SEKlizXATFo2+ozCK8eYUVnZ+NL6TnPHobbJV7e1/ZIkG+7wognNT8Z0teq5EfCxKb/ckOXsJ6Ah4r5AH6euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2AgYH3BsAeNwYYS21NNHAdDz4DY2WD0rcuWuo5Wx2w=;
 b=R3wS9OzwPbek3xG7ymPaqiYRv0oO9P4toFM0U2sjs6yT8bRQNBsaQjisVQyDOCIxtdfcot3r5DzDVIzMHoVjNNK1sFl4E8IGeLvMpcobLedIJuldqUEkAIDLcQVfwNzP00c4vDiVStAuuyiuARsI4idiyyHqzT6viP6UIO1jzaKG4aoFilQIfycRlQ64ELqla6vD3/V0HSYb4U2vn/meAIYd2wGwJGesWNsr4b7iPI4ffMS+8mjglsrOE2Rzcy0V3WL60e2GYIj4k2eH/+Z2ZzBqrzpRt4JhK31APBSVvBW4rvf9WKEQXJcVT+kJSpIlESOVkZz/bI+AQWQ2sU3OgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2AgYH3BsAeNwYYS21NNHAdDz4DY2WD0rcuWuo5Wx2w=;
 b=i90KL5yfmxbgnl0FkzRXPJshn96yRM8FVrnZL0m91+MdKelyHTV9kd8k/PngYpLl07xNpkXmfpoUERicHUJE6qKhAAuLDTasPr28MVEIajB/muAUftpl7jwchM/Sty166duscW3sXaTdU4uF8A92kLnQR9QI7qtFa0C9u0SbnFI=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 10:36:40 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::50) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:38 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 06/14] arm64: zynqmp: Fix Siva's email address format
Date: Fri, 22 Sep 2023 12:35:35 +0200
Message-ID: <e970cc0dfabe293c2baf6b231d34f3af0386f1eb.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8460; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pw8t+1oJJt5QaDExTBYT5e7eEL5lUaSgtfP+P/kvMJQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3Km22WujWByYDp56q1LP0HXto+ikT9GFdu4/XvLzn
 7E1Fo7siGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABNJl2NY0HtvVeT0Y5p9vPaL
 glZbLrf+vKXwKMP8GquqcAarkzdd3CbLBeUHn1qsnJUNAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e16a54a-b1ef-4b2e-c5bb-08dbbb57cebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gnim5Qmo86Bb6XM7XR53E6UVk/v2JPRFct90BPK4kc8Ch9r+kCsOish3VOLZTnrHRtqWr7AV/Z6H4uGchnb7KPlP3OVcvw913rIpztiC2V6Rmp9EavSxFnp/aXLkihTI3NM1DYTLF4aq1tQfR2bkpstcRPusiN6OhtOswzvS4p+ZbSHADq8Iu8bIojosAU7Of2G6kesxOu/4rCQdvPTXq4G7QYAvnuuCQOSDU9xgGilJB0+Ya3hk42kU03mAksIX9c7vhwmOs9ScrjsTLTxMIQ9QbiPJg++2dUduaBrS1gLsT5R/xTHhhvkLUY6S+/KMwpHZ3TErIS+xJ4uKhajSd2hnURzyaeLiUFzREkeW/KMKF9BLmMSuo/Lkd0GebtlU+aPBiAditvg0XbveJKFNmtmsEfjrbPXoR6pXNKcMwiyFUj8RjR59t9PBBtALBgidGvxQUNxyPKwnYR3fdSM5/76EUW10AA8tEc4b+cybFXAe3NgZ5ncHNsQLzWbQtrh1xaXGaTeGemaCZ2aiSOUJ8LfczWLMWNxEsRIBOu+Dw8W7NrI+VmVdksqHxK7a39JibX0B4z07vEFJyomlXubyw7CX/VnQ7h6IDl8EUCS2CmyRvBFbYngv6TRgFQJnLTr1qRIodHXFCTobipRsBbrBmvNLrVjJq/TfhPksdrNDJSlUxCy+/YhF2MGLEzG33gAXPTwSoYnMfeMUdzxuydmMk3M9a3gtd2fVGPVcHQGsz3CFWQBNGM+NN0HkcIDUUJ2dpa2tuPHE1VcmrPvuzIN7RK6IXUfi/HzvOqR31/Kgzk3z6QO1bUxIrFXXKhtSpux3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(186009)(82310400011)(451199024)(230921699003)(1800799009)(40470700004)(46966006)(36840700001)(2616005)(336012)(426003)(83380400001)(26005)(16526019)(6666004)(82740400003)(478600001)(81166007)(36860700001)(356005)(47076005)(41300700001)(110136005)(70586007)(8936002)(316002)(8676002)(2906002)(40460700003)(5660300002)(44832011)(36756003)(86362001)(40480700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:40.7302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e16a54a-b1ef-4b2e-c5bb-08dbbb57cebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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

Some patches didn't have his full name and also there was one more ">" at
the end of email address. That's why correct both of these issues.

Fixes: 174d728471d5 ("arm64: zynqmp: Switch to amd.com emails")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-emmc0.dts       | 2 +-
 arch/arm/dts/versal-mini-emmc1.dts       | 2 +-
 arch/arm/dts/versal-mini-ospi.dtsi       | 2 +-
 arch/arm/dts/versal-mini-qspi.dtsi       | 2 +-
 arch/arm/dts/versal-mini.dts             | 2 +-
 arch/arm/dts/zynqmp-mini-emmc0.dts       | 2 +-
 arch/arm/dts/zynqmp-mini-emmc1.dts       | 2 +-
 arch/arm/dts/zynqmp-mini-nand.dts        | 2 +-
 arch/arm/dts/zynqmp-mini-qspi.dts        | 2 +-
 arch/arm/dts/zynqmp-zc1254-revA.dts      | 2 +-
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts | 2 +-
 arch/arm/dts/zynqmp-zcu1275-revA.dts     | 2 +-
 arch/arm/dts/zynqmp-zcu1275-revB.dts     | 2 +-
 arch/arm/dts/zynqmp-zcu1285-revA.dts     | 2 +-
 arch/arm/mach-versal/mp.c                | 2 +-
 drivers/fpga/zynqmppl.c                  | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/versal-mini-emmc0.dts b/arch/arm/dts/versal-mini-emmc0.dts
index bd685ddfdb42..60b1c0e1fc44 100644
--- a/arch/arm/dts/versal-mini-emmc0.dts
+++ b/arch/arm/dts/versal-mini-emmc0.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018-2019, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/versal-mini-emmc1.dts b/arch/arm/dts/versal-mini-emmc1.dts
index fbdcf5d77f56..751cc38ee5c0 100644
--- a/arch/arm/dts/versal-mini-emmc1.dts
+++ b/arch/arm/dts/versal-mini-emmc1.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018-2019, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index 5683a2306bde..1abe44f40426 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018-2019, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/versal-mini-qspi.dtsi b/arch/arm/dts/versal-mini-qspi.dtsi
index 2fec92ce3ec8..9347ea32c9cb 100644
--- a/arch/arm/dts/versal-mini-qspi.dtsi
+++ b/arch/arm/dts/versal-mini-qspi.dtsi
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018-2019, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/versal-mini.dts b/arch/arm/dts/versal-mini.dts
index a213b745bc26..844e3840acec 100644
--- a/arch/arm/dts/versal-mini.dts
+++ b/arch/arm/dts/versal-mini.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2019, Xilinx, Inc.
  *
- * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
index 08ec2f7b4a9a..02e80bd85e1a 100644
--- a/arch/arm/dts/zynqmp-mini-emmc0.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
index 905de08fdb0b..ce1cdb207538 100644
--- a/arch/arm/dts/zynqmp-mini-emmc1.dts
+++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
index e5688fd703e6..e0517cf46017 100644
--- a/arch/arm/dts/zynqmp-mini-nand.dts
+++ b/arch/arm/dts/zynqmp-mini-nand.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2018, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
index fc0a2e801e49..ee8be5360004 100644
--- a/arch/arm/dts/zynqmp-mini-qspi.dts
+++ b/arch/arm/dts/zynqmp-mini-qspi.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2015 - 2020, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/zynqmp-zc1254-revA.dts b/arch/arm/dts/zynqmp-zc1254-revA.dts
index 5c4acd17cc5d..c6a63201c1c4 100644
--- a/arch/arm/dts/zynqmp-zc1254-revA.dts
+++ b/arch/arm/dts/zynqmp-zc1254-revA.dts
@@ -5,7 +5,7 @@
  * (C) Copyright 2015 - 2020, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
- * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
index 74a5b020e863..0d2ea9c09a0a 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts
@@ -4,7 +4,7 @@
  *
  * (C) Copyright 2015 - 2021, Xilinx, Inc.
  *
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  * Michal Simek <michal.simek@amd.com>
  */
 
diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
index 9404c139a24b..095c972f1322 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
@@ -5,7 +5,7 @@
  * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
- * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/zynqmp-zcu1275-revB.dts b/arch/arm/dts/zynqmp-zcu1275-revB.dts
index c06d262506d0..4060dc3613a2 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revB.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revB.dts
@@ -5,7 +5,7 @@
  * (C) Copyright 2018 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
- * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/dts/zynqmp-zcu1285-revA.dts b/arch/arm/dts/zynqmp-zcu1285-revA.dts
index 99ea143c02ea..4f85837e64f6 100644
--- a/arch/arm/dts/zynqmp-zcu1285-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1285-revA.dts
@@ -5,7 +5,7 @@
  * (C) Copyright 2018 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
- * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/mach-versal/mp.c b/arch/arm/mach-versal/mp.c
index 7bd39289fac5..2487b482ddb1 100644
--- a/arch/arm/mach-versal/mp.c
+++ b/arch/arm/mach-versal/mp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * (C) Copyright 2019 Xilinx, Inc.
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 #include <common.h>
diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
index b1f201fb18ba..2656f5fc5ecf 100644
--- a/drivers/fpga/zynqmppl.c
+++ b/drivers/fpga/zynqmppl.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2015 - 2016, Xilinx, Inc,
  * Michal Simek <michal.simek@amd.com>
- * Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>>
+ * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
 #include <console.h>
-- 
2.36.1

