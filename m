Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2633C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B3E88835;
	Mon, 15 Jul 2024 16:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dX3GYPWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0BC8888E; Mon, 15 Jul 2024 16:39:24 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0F588677
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF4WtSat5zAB9InIGlnjg1EXKBw7MiJVs3kNpKwipxBY1egwtrc/pjasSmfgjlWq1cZ2p4plXxyHYWxTmVgbLNp9uoY0ltBR8X5ogjkUZQHrtMMQHI1REQb1ayuWTaLsHQUUhcxEBLwbWttLFsp3fumajFxpuqrXyMpbrAffAHmrZ3+uZF+F0RtGuN2XWG5SWRV6z2YRDF0y45GOJfqIlXa1heYem6PZUvVpBU79Z4ZN+zJj+sFdXT5JPLC87AGVdoe1RKEwm41NlwHlpdRmJ/bXSoCbz5cEKwBm8Bpnve2q5MwSUj7GBadL4TyY2MExUX6jP7AdtJLHi6z5pV2SjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCHzoiGWUEEcYt9DAETt+cWraQbPczmVAzJ6In4TleU=;
 b=le69JQ7jaA6LIiDQNX1mF+6tBKtXGF0nypgSUU4twhtWfQ7sH5NsvnfpOTJ3Ka1I6qn+Eh6ssSC7rPcOXOXe6z9pBY2H9GOD+DPl7OsoMVoL97EvFjeCFyNd/4NRmWSbm10CljCQe0cVVko73GBzBJ9XwGtPZH9rUsb0Cp92oWmkci0d3CW7hrvUIwgKgfdUQwhEirFLv9nLxFGQPeM+bwXYg7ud6fePY5EhdRosIv4NPHnZcyMC4pswJw7WMRQYJqgoFiQUbxO7UzteJxWwkVlQkFBZEDeenlhmbASrfQtKHt4oT4lakJgkXij98+uxvUCkUKwxSijtwjB5h7vYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCHzoiGWUEEcYt9DAETt+cWraQbPczmVAzJ6In4TleU=;
 b=dX3GYPWpZbs+OYx6UeNOORyR7fxdpCNXUdzMMPTb/vHIb4VQN5YkLHGwS1ZtAAuBO1zakx7yDZK1AQ8MXxxhjb9/dSwBG+3DymMt0vDtw+caHKR25eyZ13D3MWUoW9iaVzDBE5c2l5xLl3TxOo7U1vqohkgJ3UxAkDq/vQ8U2qU=
Received: from DM6PR21CA0012.namprd21.prod.outlook.com (2603:10b6:5:174::22)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 14:39:16 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::12) by DM6PR21CA0012.outlook.office365.com
 (2603:10b6:5:174::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 14:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:39:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 09:39:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: versal: Remove undocumented cadence,qspi compatible
Date: Mon, 15 Jul 2024 16:39:11 +0200
Message-ID: <13ccfe6b447c426aad06edbf0b8e52fd1eb97ee3.1721054349.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/UBhhBSm+X5JUSJSr9QEE74TItXPkeXAuixFbk8SFAE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSpJhOy7ofVZc4TWjStMXMjzyXWR1nvBZrlmRaZsLIzT
 N/K8zu5I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAFzkBcM85W++j7jvP4trXP/b
 t9xZNEBy3v/1DAtaJyV4J1ivCPq455JO1uEH/eeP2boDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: aca12047-7e09-4e22-d738-08dca4dbe73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k5pm9rybA1B5XYSPJFSGuyP778K0eM/+gLId17gO48B8IZl+VXAjkBa7vzhh?=
 =?us-ascii?Q?JXCERtcqPFvjXBKXvwhaPw9Rpa2s1In8+3WAkuak+Yx7Fr135bJZ46AmNxmb?=
 =?us-ascii?Q?nvKJV4zeJhw6waRxfFH4SpAusUdThl4xmLT3NNL9y0PzM5qxUfSoOxIj1AGW?=
 =?us-ascii?Q?Kg70ywJzFTM9HZcOU5JpxJv1v0R3u3YCGLjxC4rAwx/aqsCn6ERPqpstiBIR?=
 =?us-ascii?Q?CxB7P0GfU6y44zQI0PMG1OmKAlp5aC8iE9OtUDIBG6PeTlunFykYWQlmsp3j?=
 =?us-ascii?Q?PzxUbkdo18Ld1mxFBL3BHiDaqFc02l1JYPKoPW+rx8M6Ph7p1Wykx5u0zKJg?=
 =?us-ascii?Q?HmyRNuJA4r1QUX/LkllC9MjIXKGlQpgA5OZNUBHFBvKS8ZShsANeTxExjelW?=
 =?us-ascii?Q?wjhHiS1GJDB2sTi3dIZPoFcEtxlmHVoid/OTgcWn8ioMp1sUt7ZACndcPSVv?=
 =?us-ascii?Q?EP/nruZOzIwMf4U1eYOPh6kBh9pL4I1v734eEdSqCXIPzGSs8rr6dml8lKPu?=
 =?us-ascii?Q?d6qpqaNYr35irc7vyCZKYeZoFfBaJ0UvuIGRUS2nmy22FC0rnBo2+nEwOYFr?=
 =?us-ascii?Q?Bbn254JSrVVDKS0RK9WfeCdUBmeYxIxp3rhKd4lAnIfLW2ui+1AAOjh93XwO?=
 =?us-ascii?Q?MCtwrK2JtjFLjcQL9pWE0S1sjFPxupOCIGayNiRRYL2neQz3q0XG+tn0/Rfo?=
 =?us-ascii?Q?dleplZlP9k7yw60hYUgfawQDMw8ss65nmvWdHaiCtrWIfNZLXO7CxzNrvKNy?=
 =?us-ascii?Q?nRKLZxwKRTXsOJA7Bhl/20cKWhL1JwSCUOnO6cnRSneNvWha99fgSzR6DL3p?=
 =?us-ascii?Q?9zvL8oDk/sVb+OT26NNs6Chzyj47yBAh1Ij7DUp2FnzIvT5i6BANJDGA0jtF?=
 =?us-ascii?Q?+/uh8bZFf5rvUyIWS01S8FMk0JU+w0oj/WRhH5CMYyO61RuMC221b/v/mx+c?=
 =?us-ascii?Q?FFJ5+L27JqaXCRphoYJ4EfYrT3T/X+0TQXrE3wuMkQ9N4Gt41S9L0JZytDs8?=
 =?us-ascii?Q?mNBdgTwR0G+qKP97cohHQpXQC5mUQp5lqdJlkZbnIXwVSv7lkW/xzD6IPczj?=
 =?us-ascii?Q?2M3cF5kue0KT8F7DNpCFDHJPl9hNZMBDGdNr+eL9w7RM1X9nUiVlkcGjyJg+?=
 =?us-ascii?Q?iaTAtcXtl+KQN+SHwzAQBZOkUMaIEwx6m6kLNopzt5o6vI0SJQDih4F0i7Da?=
 =?us-ascii?Q?ryjmfRizbPtc4k4ER4FeEX4K6CM4YTaJ4JMlgBq1MrX5CIo6hiXH2MFYOr7N?=
 =?us-ascii?Q?LoaKErysU8fphm92dtnX05mAc2AGaAmHwqG6pZWs0e3R3z43qiq/oAEspvdv?=
 =?us-ascii?Q?Vr3X8IkQ1cRAb6hkhiivmxONqgt/zKLg2rrgC8Tn05E/OAlOdcYHxJzSd1vA?=
 =?us-ascii?Q?As8irw9HSdPdVDqRXK11f5HBS0laTB2QTC6RZDkAT1lph7C8OXKg7BEyI09b?=
 =?us-ascii?Q?HHVA4pT4DXYZe09XUFHCVypM0dKtk3WV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:39:16.3056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca12047-7e09-4e22-d738-08dca4dbe73d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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

Compatible string is not the part of dt-schema and also not used by U-Boot
or Linux that's why remove it completely.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-ospi.dtsi     | 2 +-
 arch/arm/dts/versal-net-mini-ospi.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index 1abe44f40426..8735292a1273 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -36,7 +36,7 @@
 		ranges;
 
 		ospi: spi@f1010000 {
-			compatible = "cadence,qspi", "cdns,qspi-nor";
+			compatible = "cdns,qspi-nor";
 			status = "okay";
 			reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
 			clock-names = "ref_clk", "pclk";
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index d511b823754b..a9bf7cc42484 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -50,7 +50,7 @@
 		ranges;
 
 		ospi: spi@f1010000 {
-			compatible = "cadence,qspi", "cdns,qspi-nor";
+			compatible = "cdns,qspi-nor";
 			status = "okay";
 			reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
 			clock-names = "ref_clk", "pclk";
-- 
2.43.0

