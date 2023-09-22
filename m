Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B25CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC4986AF7;
	Fri, 22 Sep 2023 12:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q/qM8WRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B500F86AFB; Fri, 22 Sep 2023 12:36:44 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51FB86AD8
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7kG54bSaKB9PVCyyYKtJ0IasBi2F0gLzBhFCjq5zE3jlTdiDj5Y+578ZQwdU+2JNFCYcvrJXNdAJ8DE+ARHpxJqvtUJkiNUFWSRN0wt7PXn4bE/5kTWz4meycVfquBEr1kHWAiOGkcPR0RwC8qMbreV6ff5r5uD8FXzXO1qVjCIMzs4PHfIP0HbPOCN75XPS/zC7/yHNm+UV5QVVYXN5FdxXph/k3z6pm9iVleYptxs+4N1GVq/vfftmyW3eOYUSqnh8kQLUvQN+bokuJTHiv3MFSkTtHJ21HmAYl2NrJLJvurNTZ7gi1fo0AjvTC021XJiLLXsDEgRqPEsvC00Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP9fhtMzhHPMHXMDtNVmIncebSlEis2mjXxqh+GxFls=;
 b=EzPkNsbQ4Pv2P2NI1diusk2KcHKXYd314yxpw2Q84QyUTEWEE/tVCykrw418KDjkkfNp+VEOaZkFNmleIlyYvtgfIdA6QG64GEc298gg7/+H12FMUXkm8yzY9NTySPE18GPEug0Jq1kmFDi+XJXmXSTJyUw8uVgQP4gBNxCRej8RyCNVneHKB2ObkX7fEmEs8OvJwL8lPrOP3B1izTVBNoWYjsGizHbh0DEGmh05vigbVYlLG+JE934extLIDMSYpi5H67iCeXhonvthxgy0AcK0/oakQ2filBDF34cqYCw9eFOwJL+4EnFb6fV5KIpXqoF99GbdPMgL+uxxcUaq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP9fhtMzhHPMHXMDtNVmIncebSlEis2mjXxqh+GxFls=;
 b=Q/qM8WRx1Lsz/om6GfaYnyP9zcoGpxCfjHfDNvyMZP2BU4lisz2CM00t1AKqB2IMT3MP0EYWG+YNP7rmXt8ajtR0PMS2iGcbOgFaEEQEoYz9XDo1QKbSf0NOlNovDVE2DpWm3h4GGB5DKDeCIVvVkQwYDhrQphcpTPCt2YLsZwY=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 10:36:39 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::2c) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:35:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 05/14] arm64: zynqmp: Describe bus-width for SD card on KV260
Date: Fri, 22 Sep 2023 12:35:34 +0200
Message-ID: <065cb9f1c6706eb4d70066e25cfc30d17b9f875d.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gavS8g/7TNrmUt4G9kyibboGXVcIARooKG0xDfkt8pM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3KnqhdMin836p/X72EWLBnaXEKN5TeVlasvSV8xeb
 SDCbhHbEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACZyUY1hftTx0NWiM1eYXRX0
 ERKZqy/+rPzoPIa5Qhs514cm3p/+8HRdyuapUs7M5rU9AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 31366227-dc35-424b-95fc-08dbbb57cdc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlpK04BtrmY1KWq4OjLuIKrug/0Y7cDaiavbBaz5O3P5mzVi8p7gpawA1SZwiBESnNeKDQQXQUj7ZAigatqzvePSYyoV5DufmAz2h7QOy3AZQnntAnO67+3SQXg/2/AlexqmUw4JTDW54aeY5Qp7A92kb3+kKVHkIP8bx40exZeyUohPsMYvp+afCNjsRNL4h6CiKYHXHokx+jyBS2Q2GY0bGzEUhctHvpnTDHjLj2dgKJtOCGjPj2fDykcEKUV6a1ww0M0hvkjcHfQnJUizO3P3Cr4nIZ7kPOrr4/W3tMgGw9YCbGz/o9y85ppy1XAKFYPq06qMfhyG9DuoVJFFF1IT9ItVjb2LAZzCbB+8AqXyhkgmHPOKD66z3ZoRC5kT3/u7R3diukg/+zHpDaWz3Hk6IKCAWyMUzda0qP4bRRvnhhF+YrRCK0BJ2Fep/x2aW8tE+vLD4HvRLQNtQI5UxSmYdmVQZk66Sl5XEXyBBSKk/zV53pOO4PBOUnRGuU+miHIGG+biY2pOQdHTBUOGWnT8+3EjUd/CwvdsvX36OSh1OMSZFkvOohbpF3q2tnHhB0kl9UPY4uiM74kESMGpbvLTUbHH5+gbIX8dju+9dZDCk8dAAa5Kvuhr7IbGn4wvn3tWLL0OgtYYtP1AXFQcaBq/06AraAr45fWXykkFwtBf5r8byRTY0n7AbcnDRbSw1/kLKMmqC1F6q9/zL84RK2Gh7PHG2agsq1BuMWe6ODA3pG5Zy2qpOPyVA5TDG6gYUgH5nKERMnKaD10EOFqHlupXcp/U+8se6RyL0HukiXyWOIbkoeZ1Krb1ydpWAm4F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230921699003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(81166007)(6666004)(478600001)(44832011)(8676002)(41300700001)(8936002)(5660300002)(316002)(40480700001)(110136005)(70206006)(16526019)(26005)(70586007)(2616005)(2906002)(356005)(336012)(47076005)(426003)(86362001)(36756003)(83380400001)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:39.1208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31366227-dc35-424b-95fc-08dbbb57cdc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
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

SD card is connected with 4 data lines which should be described properly.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 2 +-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 55bef1df75d0..72361f6f9e4a 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -156,7 +156,7 @@
 	disable-wp;
 	xlnx,mio-bank = <1>;
 	assigned-clock-rates = <187498123>;
-	bus-width = <8>;
+	bus-width = <4>;
 };
 
 &gem3 {
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 1b1d9e772f55..44738cef23be 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -144,7 +144,7 @@
 	clk-phase-uhs-sdr25 = <120>, <60>;
 	clk-phase-uhs-ddr50 = <126>, <48>;
 	assigned-clock-rates = <187498123>;
-	bus-width = <8>;
+	bus-width = <4>;
 };
 
 &gem3 {
-- 
2.36.1

