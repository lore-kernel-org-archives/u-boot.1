Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4C9C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD9D87561;
	Tue, 19 Dec 2023 17:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJfxQSJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C108751B; Tue, 19 Dec 2023 17:17:07 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AB1D87561
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgsA6beFF6Lg9wThcKHgiKPf4z2ynpEofvgefrDkGmk0STCtgCo59OOIatNxt+kJsaHqjGs+rJdC53e05WkJfx2n44IMqzpMtcZoSEJqAIxDN6ePa1qnUih8v9LFBO20apXbsnc/+5BzWJJ53r3ig/z7ubBN2YJmhumxBIOsEcukWxGLbMTZg/ywGjVCEtQwc84C31a+kV8VY+8DtZjx5yyrklFrxm4j3CeUjx7NJ0Q/c5B2v2ygBMv+rN+TQuJ6j+muakci0SlvRLuE9Ii8FNvgHl88Ilx2N82XPxOckJoDBsVOn1UuAbC28du/wcHtPKxjQ/6QPiss2ZGvXVvG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv7YypoJKDyL9eQhRvE2U4bG48t7ORuuAhtNKRkPchM=;
 b=PdOHO1E5MNuFEa6b0R9MXBUGGCB4EqvDurhQyRZ9SygPU1q7ZUxeIcHQJSU7wofcSWaW33My5oI7b2skRC+S7DHy3UUtvy9SaSE124/1Hf16ZtXspuxP98xf/RZpU8NIoeh5hmqBW4AoXQ+KWGJRCe0utM4njPrD8Cth5mHoDAZJ+u54kAUwaMMH6fO8oRwEEthx6EBZJrCmPvQBrIpcExqxJp9xIgfhAdT+DS3cKVesnToGG8HSWluvJRu7RrqMKR5+sI4yzTMJyeY/OOCmskQbi1nViGshLASINe7MpyY66GNJ6khEYyYbq+40KJX5g6iIr8Yb3O1CUGgbaWJLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv7YypoJKDyL9eQhRvE2U4bG48t7ORuuAhtNKRkPchM=;
 b=WJfxQSJcPQQNrsYqX7euRLLuwFxQiiLDP+23GdDpnhoetdM3BBEZuhYzOkuqv4PuUEqYopF7lGWT72zlAO1Sxv3THQ+pL8IsO6vZcOZcx/CIDStnQnT0Z6YNYy+CGwunb53bMZ3i5QVT4BTJmGS2VrhDjJBtZkQhXf57gHmdcUg=
Received: from DS7PR03CA0305.namprd03.prod.outlook.com (2603:10b6:8:2b::25) by
 CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 16:17:02 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::93) by DS7PR03CA0305.outlook.office365.com
 (2603:10b6:8:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 16:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 16:17:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 10:17:00 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 2/4] arm64: zynqmp: Fix clock node name in kv260 cards
Date: Tue, 19 Dec 2023 17:16:48 +0100
Message-ID: <8f392c7ff13bdf2322798818ddeda06446b6d7b8.1703002605.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703002605.git.michal.simek@amd.com>
References: <cover.1703002605.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2904; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Uf5V22xafN2Pjt2WsY32P8NKvmFAPMqPGwj8U5SNbWA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGg++1XYx2fOxX11K7MmupcHaBm71FzdZqAZUlUzt2X
 shU/rmsI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEyEO5Rhvmf2y+hd8boHpYvO
 N/66+yQg9mHdG4b54RoX/RlY0lfXeOl2XBJ6O8121fqDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 238ade10-9176-4157-b822-08dc00adef4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erXM+/4uWIiEJKYaSfGjEpp7aZ8+O6ASy5o3z6SYlxJI6KINilC0JrF1uLPpV7PW6g6gjpLGusSQjqeQGbHoVpoYLsPEwvt6jcsdQ7IAxoGDJaKzxLdRKOkGPDaQY9xLueALkPR2g1Ymc8peQ6jzuGYawdDj5UKGMFkfNLMHtcPnFyGjqN4wU/ERJMQZJKTpG2fOn8RA/KHPdR4oEhFisJLhsoAKk2z79gtMvXLENzj8YEUEmHN1X1S9VN2jx6vT+ftXEYWzkkm5hZM1L5KCiPQrZNl16QocL9xyiYIXqJt94Ia/h1M8tA6OGNfJIVPTn3IwGMTnMvTywjLPcWcAOF+xSkvcRCOxYYYG7mbbijLZdVROWt8VtBxeyDX3WwsROy1ThtEOAMRB60vjjR+yqMXBMxfpevLyqDHANI2aeLNT8w9d56x5Jk+2QenIpePCcdXmec1YBVfOL+Lj59oKci0NjyiS7iAcqivgWZDHL2UPolOYGwajoDRUacmtezYQ718rnkKdfA2Az9Fhm9I6axpB3dfu4PQ75bi93kSGGmIrURWDoFetUPBqbO9H/KY9MabqJWsTzzLBGEDbrmrXdv3IY5EZGx/n3XuCFQeR5ZDt7VewgFYGkN7iigecD4IRGnjFn6KSE2keRpL5/myjts7kh2mbW/33rARSlwYxGkPqTFNad/XB62/fkpj0bESI0I5zO5kCjE2lW+nCIQRg6RF9MFtxoXoPKc44ZTlx1vG8TAutMg7gkUD2PZPAlEmh+t2JJjGwThsAbBEaPk0ZTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(16526019)(36860700001)(110136005)(70586007)(81166007)(82740400003)(36756003)(86362001)(356005)(5660300002)(83380400001)(47076005)(426003)(336012)(26005)(2616005)(478600001)(6666004)(316002)(2906002)(44832011)(8936002)(8676002)(41300700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:17:02.3111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238ade10-9176-4157-b822-08dc00adef4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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

node name shouldn't use '_' that's why convert it to '-'.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 12 ++++++------
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 3db420cc94bb..04ae59290a0b 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -33,37 +33,37 @@
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
 	};
 
-	si5332_0: si5332_0 { /* u17 */
+	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_1: si5332_1 { /* u17 */
+	si5332_1: si5332-1 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	si5332_2: si5332_2 { /* u17 */
+	si5332_2: si5332-2 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
 
-	si5332_3: si5332_3 { /* u17 */
+	si5332_3: si5332-3 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
 
-	si5332_4: si5332_4 { /* u17 */
+	si5332_4: si5332-4 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5332_5: si5332_5 { /* u17 */
+	si5332_5: si5332-5 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 6756fdbdfe9d..adf3511ad313 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -28,37 +28,37 @@
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
 	};
 
-	si5332_0: si5332_0 { /* u17 */
+	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_1: si5332_1 { /* u17 */
+	si5332_1: si5332-1 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	si5332_2: si5332_2 { /* u17 */
+	si5332_2: si5332-2 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
 
-	si5332_3: si5332_3 { /* u17 */
+	si5332_3: si5332-3 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
 
-	si5332_4: si5332_4 { /* u17 */
+	si5332_4: si5332-4 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5332_5: si5332_5 { /* u17 */
+	si5332_5: si5332-5 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
-- 
2.36.1

