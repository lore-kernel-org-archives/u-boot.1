Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68F7C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 07:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5452887B58;
	Fri, 26 Jan 2024 08:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhn7RyMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E5987B58; Fri, 26 Jan 2024 08:24:58 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D406187B34
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjgX2jlxDV7MSUJq+owEFZ8R7bfSsAXu5sA/geR9S8wTkMQEd0ELSZYjqOhssJDh6BDh+XXvVGqld9u8TaXN4HNfKXp8ve3WVTpbd+G4QQWRwrb89KP4r/Z55EPxLwcXhy+/XmclN05ZNR5NrGRQ/DmkPZcrR0v8cas9gsFc8YraHo4X4bnLlU9ARpTe2Fa78Y4HK/gYppE269oxuB/icjUhpMQ9VOk+AG1uRkzQn6+yXJmMggYcr/RuX3RqarqVr9Ys/qTUs8b8GVMO2p/OM8zNuyI9SaMvlVRs31XQWpR2rEgliu8jzJ2I3sZD9JNYS5QyGYUvIDnmkz9UUkx3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMOcXiBtECYscmUJE1tnfKOGjgl81Rq1DY6F0WZa/4o=;
 b=MEMHyFojZFPO5377eWOMmKRXhVJhZ2K2iePH/o6Is9zyE3B2WKqoyZRxPxhBV4v1eqRm62tfpU664jkMuWB+WMCZ0kKNmVVVoeR20ldDVXJQgyo4mZCNMKxennTfNbxz0IrfZ+Si6F8c6F0ggHraqz2tFbQVXkDP0lCp2zh9d/1KQ4vaXaIDBsXVq/iM3FC79PypXfv+qQ/EnIZH7QZNcfj3lCuDrYC67KG7C0FIYZCipMhw+zRVfIgY4V48i0w0yqS/VG/LfeFaFcH+WiiNlef0RlUEQhK5ZjkZJ7dZUiRxbgzcBVosyCxDumUIktSMZqXv2vHcNM0mAutZ1+0bBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMOcXiBtECYscmUJE1tnfKOGjgl81Rq1DY6F0WZa/4o=;
 b=mhn7RyMSp//btCszDg7OPO8bO+9c5raTxXq5ZS3YrGZumu6Elfdf4lPQ42qMw/7cI8hkJ3UcPxnFxbQgbTuiTKmD1n0+6iXzUQLnXq+xoB6P9LHVjaX0tEy2dHAqP5aXceb59n51K1L280euuaE7qORShFHxy1Y67j7NpVQSGkY=
Received: from DM6PR07CA0046.namprd07.prod.outlook.com (2603:10b6:5:74::23) by
 BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.26; Fri, 26 Jan 2024 07:24:52 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::8a) by DM6PR07CA0046.outlook.office365.com
 (2603:10b6:5:74::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Fri, 26 Jan 2024 07:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 07:24:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 01:24:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Sagar Karmarkar <sagar.karmarkar@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Sync clock labels with kr260 revB
Date: Fri, 26 Jan 2024 08:24:41 +0100
Message-ID: <abac6069e6029ed4076ec7b9d6b33604b6072aa3.1706253871.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+C1oxmWmp9TAUwIYxCoQkgAZlAuvcK2EpSzIanh0D1A=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTNcQYZvlG/naRkylo2PF9seP5s4Wm3yYyvr23/nrlq4
 QJBu3CBjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRu5MZ5md4nTg2/2tJwyk9
 G6NVFpoqO3LqwhnmO548VJmqevvaZZk5bfos501bLwdEAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 103d24c9-1656-4e21-9b94-08dc1e3fe347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qP0jHce46oloMRKEguJTIhwhOnF0MtS6yhHuVSe5VyU5eMwpJezmi6F0VlAXmKtBOG7MZueGgM/W5ueLf9akpbYGwHH5+3N1k2adEecuvbU1z/tV5xPmIG3cdqHQVnyD/sKVD5hA9DiqFYmat0Gn3qPCuHuC2QwFZLDGbxMe66k/lvT8qt4vyv+mXVBBBWB9sjHLUEqBqZnk+Eh+R6en+QoD203gV0oub9RZIFhM0/wzf7snxrySQxlrcqJ/4DAmJ9o4WoosxEy9KUpg4TWTN+vSrfIZJEnehnirl0zZN7WW7FH6lSHa3pv0UwLpaKsjvGrxDzY0FL8cfwbB0ldunDzM2eG0Nqb3NvNG4g3328xD/fK5QAZmV7i36STZkkfqTRSPEpMBvf9oefM2aQKZj+J4YYLwN3WP2viNDt68x31Lhod15BdUkTBMKYSBUNt+5e93UExMmw8tpeJNZvjPlnBOfkL5YYoldIHiEm51DhsvZgki3VgeTMakR7P+9WF/WEyXyUJoU0Om9LlbBa9E4o27SsDvn+yfdgb4I4iJrsAw+ECsuFiqAUlmigS5t+Ufkcw1JjLnYFpYHanDuuQSgy415sbnBfRWY4UFIG9iR7lTzLi3j1mPb16ecuywVDkl+ZHL7Nurql/xJQN/aTsN0A9zdxrqXPrTRmZx/pv90x/5hwlx86/fdtUwchOkbXX3Sc93cWEVd+9OgDs/jZq2vINH8C4iVMr1GOFQftjxqQvZ5kUSwbw8SO9FjOThEXiCZvSViDv4gSivL5F7KbWfWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(41300700001)(82740400003)(40460700003)(356005)(81166007)(110136005)(70586007)(54906003)(70206006)(316002)(86362001)(6666004)(8936002)(8676002)(478600001)(40480700001)(36756003)(4326008)(44832011)(2906002)(36860700001)(5660300002)(47076005)(2616005)(26005)(16526019)(426003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:24:52.3567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103d24c9-1656-4e21-9b94-08dc1e3fe347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

Board description describes the hard part of chip (PS) but programmable
logic (PL) part is not described in this file. But clocks on the board are
not only connected to PS but also wired to PL. And because two revisions
are available where revA is using one si5332 and revB multiple clock chips
using the same clock labels helping with keeping only one device tree
overlay which targets PL. That's why synchronize clock labels and use
labels from revB which are more generic.
Unfortunately if there is driver for si5332 chip split could happen again
but it is still worth to do it now and solve this issue when occurs.

Reported-by: Sagar Karmarkar <sagar.karmarkar@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 7717abf7bd8a..39ca98a9d47f 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -25,37 +25,37 @@
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
 	};
 
-	si5332_0: si5332-0 { /* u17 - GEM0/1 */
+	clk_125: si5332-0 { /* u17 - GEM0/1 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_1: si5332-1 { /* u17 - DP */
+	clk_27: si5332-1 { /* u17 - DP */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
 
-	si5332_2: si5332-2 { /* u17 - USB */
+	clk_26: si5332-2 { /* u17 - USB */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5332_3: si5332-3 { /* u17 - SFP+ */
+	clk_156: si5332-3 { /* u17 - SFP+ */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <156250000>;
 	};
 
-	si5332_4: si5332-4 { /* u17 - GEM2 */
+	clk_25_0: si5332-4 { /* u17 - GEM2 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	si5332_5: si5332-5 { /* u17 - GEM3 */
+	clk_25_1: si5332-5 { /* u17 - GEM3 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
@@ -115,7 +115,7 @@
 &psgtr {
 	status = "okay";
 	/* gem0/1, dp, usb */
-	clocks = <&si5332_0>, <&si5332_1>, <&si5332_2>;
+	clocks = <&clk_125>, <&clk_27>, <&clk_26>;
 	clock-names = "ref0", "ref1", "ref2";
 };
 
-- 
2.36.1

