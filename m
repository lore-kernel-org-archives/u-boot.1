Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21968C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F0E807E4;
	Fri, 24 Jan 2025 14:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="075dYtw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3614B807FE; Fri, 24 Jan 2025 14:18:16 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61E080780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4fXgrJqr/FTn6QAH21x6MPRPt0H6nxehmdezBjLwgBTikZFag8orEH3uBau5nDzqRp1HjNj3jF+kZX9VvvEBohJpBmjQDixAi31h820zPPo62PoWGI5HevFN+9vtG4mFUGHwhwp/suspsYFvJRSXqFihwSG1rQu7o1R39DKQ9nEClTCqangihbej8jcPkblN/zJ23/EzL7Wzuug7Dc/Vdpsu8hmp/tf1YaVpREOrBVnFq6MZu0BtZR8+H1yrG3DFLzzWoNSuo86fk+ecjItzTn1jYWft5M64xLmXSCj9+lGX+AGYR8/+5/wjneW5s24LWH7T7fUkmN0i2Mm3FTDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SZPdwsn4LgjmS0sRlfnz55yn04g0hUwRBP49bP6SZ0=;
 b=nm7oKANhTP/7t5m+anw76xlnJmXr9/AEpE3pNyYNqvqAq8oy3ugkPpPNs4Mia9ECDijU8OuI3zYppno7LAvZZn7d7SwK2wF4UM4JOc2eijNdb1ip9UdXUrLC4CoyktlolCr3vwzxpbo7H12gGsknC2etXYPnTDMV23pGkPZ4QYjHMlX44VmnA0ttMSFFNsHsau7L6UHVpSTvrUYlVAyyGlDzCYqZhn4K5b9YevBqTX8v0X4kVV36+Ez3bL0ykeKkkvA/VvMISKK7cJZYZyxo684jXMIeXEMJAnNmhPn8Kypi6vNkBPooi24T0l9vP8jPMcLqOUTnksOY3rz9atTJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SZPdwsn4LgjmS0sRlfnz55yn04g0hUwRBP49bP6SZ0=;
 b=075dYtw8St/QXS3A1xJAxuIT/HggUSADINJ+oT70EpDyE1t/P1g/TNiTiFkFBFbQhO82jHhGM10EuZJ1J6RftpavMcuTeydK3cBF2o/i97Zn7SMXiXqbdqjJu8QpWWcwOySw0gZoRRqT++lP3QMUVVs+teUwUTAOrwsu9yO/ruU=
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 13:18:08 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::2a) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.20 via Frontend Transport; Fri,
 24 Jan 2025 13:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 13:18:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 07:18:03 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] fs: ubifs: Remove unnecessary assignment
Date: Fri, 24 Jan 2025 14:17:57 +0100
Message-ID: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2TEb+hQgwKOvMOoyN6rtd+FpBcpR/FrCD7Havn7KQuI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTJk9k8u3RmXip156pV7b5+Y+8FiYZa3z29W4uO6uY+l
 /D1T2XtiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPp1meYp6s0v/u3nvoPvil6
 cSujtDSzRTXXMMz33/6Ihef4zNu/4/Mvzs6vu9eYwTUNAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8847d90e-a7f6-44b1-cff9-08dd3c798ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HA9xmJhbtJJIOoh+UdmO0dLOJmyuhmWjDSTXEVf7gsTrcappd/R63wAsMTtu?=
 =?us-ascii?Q?IcTrenQM0Yx2tRSbtE/MLeaTb6dTNUdV6CRu20N0lgMe7sGJVPT5op/THxsa?=
 =?us-ascii?Q?4SS1m+mQ/X5GY25grIQSzmYxGYUMxpJLxWNb0R/+uKTEvTyhOtt7W33pd6GM?=
 =?us-ascii?Q?bJOXpRA7/VMGk4U6N82+dm7ica38d9WRfh37CtPBxKxqfn6NlgvDysXywfK4?=
 =?us-ascii?Q?gsTaF0WO0Pdo/+Y9Ouxo8EgR0JfzmKVrTvVVhgdtF40NktM7/pGvJoHE2QXw?=
 =?us-ascii?Q?HriiuwYsrL5nedjqT8dmVjJ6K4l3SujFwGj2PtU16COANItO1O83iRBUPDIY?=
 =?us-ascii?Q?XGQFaw91NeFjzlxvY9UCqOeIN9TEmvqoBFvAvRu5zmkSlAcxVdXxch91LzbF?=
 =?us-ascii?Q?PEO8gevfZg0dswMggGAhEK2hlSFD/66M2kmiTBoDw2fHyCybDmB5r3H2WFVa?=
 =?us-ascii?Q?YUbDs77oeQBG2jR/6VIOLqwj2yUVZpIcjq1xSEQkRoPtCyLkjsTVwtTgSej1?=
 =?us-ascii?Q?4mra46T2BPwVcDQgUuOVVXoOgAyOyvgpab3jAEMx4uA66/ET+UdjnlPa4vHB?=
 =?us-ascii?Q?X6nYaHvOUB0Rc8r8Z1hlJXMmxN2/mLJUwz+ofFUppecepE5UqWpUcLKKJ0Xj?=
 =?us-ascii?Q?jIhDQ7kp2Lnl49fiNekldy9xf/Tg+Ijqz1B8H/jNZ8FrzXhB/Wyx8ViQoJv6?=
 =?us-ascii?Q?FmHuDt+UlZtTBPK2iraI1EZQTUIvSSQzblhT4ch0wtWfKBLaks6v7/5kw/ZC?=
 =?us-ascii?Q?+UbUmrrf1y95yY5x+yOKq1YFOoMmrrwfeB24vyM50MHn56pT7pr0us4khB+S?=
 =?us-ascii?Q?+zTPpO49qxk/2StmBt4X3V6DTfTu8YXcMelyDxlGXLuqykuczYWEUVCkONB+?=
 =?us-ascii?Q?gq1XJbF+m9EYb3bzJwTtncpDi1xbHS5nG7UkSbMs7s9ZU6a/R7MgDMIDcLU7?=
 =?us-ascii?Q?LqwiKL417aVpmi5zEgFLpZY+gCGONlcunf/kG7gKNTI2hv5KLQONV+qNYcov?=
 =?us-ascii?Q?80CZmfVIwFaxhncedM5bKB2usdjEASvXgCbjnFDqWaKZerRm53n6wT4mjyjb?=
 =?us-ascii?Q?T8fhIUZN5O4O/Ca587fAXDBRoIg/bJRDz/ZsB3rB2fV3E9XqIJRimi1Wvr3d?=
 =?us-ascii?Q?CjFv1Ve8uz8btabbcINP5ny6wES9AMrEx/27Nl3ZcZwHiyEyRaXI5N3Gls8K?=
 =?us-ascii?Q?o14oH7TIRQ+HX9ryT6aMYwf/9pkMR1IZVmrQLLP0in89lPrxPJJgNNqnt5LZ?=
 =?us-ascii?Q?G8/QFmx5T/JiT936DGE/dMImYHib9rTzhwSZnt4qrn1m8d0QPoYyNZlFo/bA?=
 =?us-ascii?Q?FEDHFKzZMZZrvT7ntY+Mg5QKlc123oU11toFlgUaEtJ1mqtHJdTItuGSfOWl?=
 =?us-ascii?Q?eW6f52VbA89jVMuTdKnzsCiP5Y9I4e75Rc2F5cEMYdx6299Ls4pf38WlazHJ?=
 =?us-ascii?Q?jsZQlcxAx8VCvLSFSqv53xSgDKImno9SmHgO6tscYUw1mP/QmbMArw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 13:18:07.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8847d90e-a7f6-44b1-cff9-08dd3c798ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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

Variable self assignment has been found by clang. But Linux kernel already
fixed this problem by commit 2a068daf5742 ("ubifs: Remove unnecessary
assignment") and commit ae4c8081eb77 ("ubifs: remove unnecessary
assignment").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 fs/ubifs/recovery.c | 1 -
 fs/ubifs/scan.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
index 6b6884fb2098..12c0575cc976 100644
--- a/fs/ubifs/recovery.c
+++ b/fs/ubifs/recovery.c
@@ -439,7 +439,6 @@ static void clean_buf(const struct ubifs_info *c, void **buf, int lnum,
 {
 	int empty_offs, pad_len;
 
-	lnum = lnum;
 	dbg_rcvry("cleaning corruption at %d:%d", lnum, *offs);
 
 	ubifs_assert(!(*offs & 7));
diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index 7a6e46df5d90..2335e9e2d256 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -169,7 +169,6 @@ struct ubifs_scan_leb *ubifs_start_scan(const struct ubifs_info *c, int lnum,
 void ubifs_end_scan(const struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 		    int lnum, int offs)
 {
-	lnum = lnum;
 	dbg_scan("stop scanning LEB %d at offset %d", lnum, offs);
 	ubifs_assert(offs % c->min_io_size == 0);
 
-- 
2.43.0

