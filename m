Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754DFCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5A1868BF;
	Thu, 12 Oct 2023 15:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jcIpNl3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35844868BF; Thu, 12 Oct 2023 15:58:39 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFAF86CDD
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3XxM0oML1vgJATCJFyQrkdMapl82+UC7you04Bm7ZxIw/qt78xZzbRCV6M6KRmbdYrApg9YsQZ2tsdC/4/DsWdXfic8IMOSYgDcpuhR+2/EJAEmwBO4tsnjEFelkWAipXO32rokkjqW65DQpOzHtkF7pIKstsrwbIolwr8aiIP5VwS/sA07+9xrrlS22RfKXeTzz5JlW6ryeoAaIA0LB/AnJLsIj1PLpAd7xC/rKUC2mt3YkGf7ExWESYL4kQrIyPNuKjNBOLdvAybtwxTqFAV8hFWXSWJxEXQOuulVWXJxNAeaTSJ8F+vl2d3GrMsil9jZamiGHpkdPzrvatEBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUgVLnxRW9VHQWTIAM28kwOyEYdedFgaYT2NI2ZJwuA=;
 b=Cacx2Epj6rOm+mXwkPREie5QGa7FySlO6xy6fydFO1RpIob53B6+oakjKj6RLFTb3nxixOb31WRmJePuMwbSCQigVk59//wROgaSgezyGlc6UShdYp/ntW02NTJbyQHHIgL4fXjSaCd+pfVIOAh6sNo/R0Ox3KbaE+7gmT/vigafEPSvmogArCizUpvpR7Z037GCFWEKJvc78+IhFyq2abjHdX+Bp0fA+KIbCuBt9vWEoTLh4e8mkWgw4McukCtcbg47sxPkKZNHVTM8EpmJ4Pm37eTZBA347vXR0P8ow1Ouu08CZ9RzxQ1x75CpBunOV64NqMVygVYgn+oFQNYssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUgVLnxRW9VHQWTIAM28kwOyEYdedFgaYT2NI2ZJwuA=;
 b=jcIpNl3U0Uq8zL2+tLyWpl1ZAnb7lR06HK5iYLWYryjkKCK2riNoTYk1iur7AMRtqUOBo1D+iUJGy+e1Uhg21hHh2rPyX631lVQ0j2Qv3VrdtkrveupTkKCvqynk0Y92Kvn9zwtS8vTj7GYMP2BWb60xB/b7gO9aBG1lApCv0FE=
Received: from DM6PR18CA0013.namprd18.prod.outlook.com (2603:10b6:5:15b::26)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 13:58:31 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::8b) by DM6PR18CA0013.outlook.office365.com
 (2603:10b6:5:15b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 13:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:58:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:58:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] arm64: dts: zynqmp: make hw-ecc as the default ecc mode
Date: Thu, 12 Oct 2023 15:58:21 +0200
Message-ID: <f47b95616eb40d3a9908ca60df94ec6e873b071c.1697119098.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dYvVpcC8pJ+wqR29b/LfTbEeIuhrhQF5I+Pysk36IgE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT131UuEzoNDr/yKDraGOK3L/zsMunA6f+t723L4/r/c
 S7b2xNxHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BeAiOQzz/TI73cOiVr5UexXx
 /euZD3qdVz7eY5hnE+tRwdD0X/2CCZs6g0yN6yqeGW4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ee718d-7909-46e2-3be9-08dbcb2b516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNPkJxffqIbZSZqDLmO06ZcoKD7dEHWqDDDN+hqbUijaFPAbpgdnTGlDvisISumL5Kqsw9I9TOSFHeTDLwhsPrcTK8E8agYkxgxXs8mP3FCQhG1x9SQqfgINWy9p7Iex0HAPAH0kBcq87aiLIFPYsir+/UtoN4Be1eFJoNDzOcRpkm8UsKP03QvCeoCldwgDby4MW85DoKvT3IfiJmSl7PriY5de3NVecOiuch5i1QEyt2ou7CqU6IM2HO31ERoASjLauUpVSenDr5+s8pljzG3nTSVTbMToT7nudvdXefmdZqqRpi0551I199m57SHcHXEn02s2B2ouz4BN9tCOxx09sGpbd4r53n4AqM4Vou/dj0Y6H1qhwLJMG5AugofK58JT0bNSynckoWA5w+WwqE6FNcio+5AuDo0/jTzC05LeFcCpkG/tMSbTtz2BkuKuKPFks1PMeT1ywujWqNC8L/OQYturDXGJwRTy8i5OQujkq97QZ2rh9vQmkNVjvawUmlZJxDpef8xCMc3aBpWfG0g3/QbOEOw6tFu2WH5YX7SfhWGxDxHDzdeT1iU57bq/q36evu4616ZyTQLo15IKIaPhH5GKpGZJEbpY/nE7ErtcXIiarT/+x2mL7TbmUc49bNIw6PVa+JpqYEX24SaHqAhlGkqfN6GCc86p5PWioyxuZs/7qfYrZimzViXnVX0sQ+jnwkaVhY4zrd8B1C0a/BHdvs458NnPgLIGdueOg9Hf+h/0UEAVaLpbppfsfHPCvO3aH92oTenOhmzGx3i3sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(336012)(26005)(426003)(40480700001)(70206006)(70586007)(356005)(82740400003)(5660300002)(316002)(2906002)(41300700001)(110136005)(2616005)(8676002)(8936002)(4326008)(81166007)(44832011)(36860700001)(47076005)(16526019)(36756003)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:58:31.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee718d-7909-46e2-3be9-08dbcb2b516c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

Except for Linux no other component (i.e., u-boot, fsbl or BootRom) of the
software stack supports software ecc engine. So, make hw-ecc as the default
ecc mode.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
index 23a3ff2fed98..160c6c58b36d 100644
--- a/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts
@@ -141,8 +141,7 @@
 		reg = <0x0>;
 		#address-cells = <0x2>;
 		#size-cells = <0x1>;
-		nand-ecc-mode = "soft";
-		nand-ecc-algo = "bch";
+		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-0";
 		nand-ecc-step-size = <1024>;
@@ -178,8 +177,7 @@
 		reg = <0x1>;
 		#address-cells = <0x2>;
 		#size-cells = <0x1>;
-		nand-ecc-mode = "soft";
-		nand-ecc-algo = "bch";
+		nand-ecc-mode = "hw";
 		nand-rb = <0>;
 		label = "main-storage-1";
 		nand-ecc-step-size = <1024>;
-- 
2.36.1

