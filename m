Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D366BC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB198394F;
	Fri, 25 Jul 2025 14:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHm1MsHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C567083955; Fri, 25 Jul 2025 14:02:42 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD6D8393F
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag3CH0FFtPRCya4Zcm29Gt9eBlKExdwGY/sWtsdbI5Gxce4B1E1AwVwWN8DIYljnrwz07ogPkm2jy7CBeSY8XZpkJN/o5XbHw9Npp6wsYCHVmmEbboEhhI17yB7+fdBxnS/9hirNjNdwoFmX6mQ0A7RmRzz8ID5pY3V4DDYTPvSYPPCh/tvYYB9ThhYMrc99oiiRPRIA+G3UajOFkGGx6XEVlWyLRpJR4koy4JoC9Kcp/mhaEI4Px5Kug/tEZlPdDsj3mICYsB7ycNWZRLPVI++xC+Ryhn8/yYMai/pXgyNbGFeyXkVxWoJU0dJEkPFcv0OHQOYJ0XkvZUUyOmxSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZg3S8hiPSq55dW67plSRPp6zBS79eIZCU7OmKnFoDc=;
 b=jHz8gpcoa6f3ufWM1o4VF+tUq3IzLHRa3fkRBfNiyh/kNX7vY8+qIwYjqLrqGhUtvUVSfSsmXyWR73EQXojM+v5drCsAE7bS4CkC40FzKxTKzH5VADEFxztH1foozFrN2xIgcSSrnGO//dDNhr7jDtnJvQfmoSS+1yZn1iRnVB/8JWTTwF1m0NohSbPYc4rARd/i6LaI1PMna1aLTmmTKJtffanp0iYa3gwWQRQDpytQOQCp5G1BH0/EQjJXL38bPTF673jZIOMJOFrFH4OI6WOspueMlOOkP9JU6TTVDVPyVfViCAIsFVOBxcvctR9wFUd7Txj9/yEMww+bwqq0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZg3S8hiPSq55dW67plSRPp6zBS79eIZCU7OmKnFoDc=;
 b=JHm1MsHJMS3/hp/w3AnueQFf4/SbsJ/fYRxqW95p4yfSuIfPg/OzKMUjuHnayYD04DLRsNSPO6jReJbCLApBSnniP+bwDXZ2QOZOKDSJHxZlHWIhzB3WRuIUX/wGkwONSt6l96SVy9aSXXg/9fNC5BHX0Gqqpmt0x5Ut6bMp+/4=
Received: from DM6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:5:1c0::45)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 25 Jul
 2025 12:02:35 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::1a) by DM6PR12CA0032.outlook.office365.com
 (2603:10b6:5:1c0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 12:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 12:02:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 07:01:26 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 07:01:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Lukasz Majewski <lukma@denx.de>, Padmarao Begari
 <padmarao.begari@amd.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/3] clk: zynqmp: Mark zynqmp_clk_ops as const
Date: Fri, 25 Jul 2025 14:01:20 +0200
Message-ID: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=aj5+6gVnScXWUQaFRx8doL4qZmv7G12eMDbylwiqVxk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0FwnG/ZdbdDJxhXHMaul86fK01/xn+izbHCduWlyjd
 bz2nHl0RykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzEXYGRYc+cdhOthPstG44q
 at7cNXGahZ5Ggbmc8YxPcTIml/k70hkZevm3F+7TmLiPVX8+Y7UCw/UZxUu5OVX3frO7rhK5dlI
 rMwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0bf130-ed99-4b7a-7d19-08ddcb7324a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fx3n+TcKrvstzw+ypKnJBzbTJzz2iCsQcYaXZt+Nx6ZbjOLQ1xjelrUmMnK1?=
 =?us-ascii?Q?3W0fBx4Vm/oo7VkM2NtnuaUyw+bTer8lfKwsO8x0mAkxYv/FdbVSaWvBM0J7?=
 =?us-ascii?Q?xOABeyL2XLRY7DB5UGXBqrntgjd2mvlDk0B00CkHe7GkNkgiy1OyXx8nO7b/?=
 =?us-ascii?Q?m/U0YY20vOpCHgYC57h21YX+8VwyhJb7T+rd4bWN99HLHSYkOwBffmIK/JWA?=
 =?us-ascii?Q?PbHMCpR6X2doKjafFWyv6tOd4pKvoPplLYAi0+/28NNCvhaw7WcdQWbzDHoZ?=
 =?us-ascii?Q?MCmwN682EzV8Zl1C8XghGy35Z4kPKspsASVy7j+p7lGhOil7qkuoI+4ZqVVR?=
 =?us-ascii?Q?yI2vjZydt+uPSDd9R3CKHNiPhOXJZXRI9/GT1cBNvM50x8IacFAaoQrE18Sg?=
 =?us-ascii?Q?iFNqG9uoXd56jkbyZQ3Gzov8hMTGn7MveZpwPnCNH8vsYBMcUKUH8RyMRvWE?=
 =?us-ascii?Q?Mc+IK5yPyuC8BhfsYZKqoOrDiAvZRWRwEqZQcmH0L9du/UvcQ7uBkJzN0Z8q?=
 =?us-ascii?Q?Es5W4zjTWGRs0UHAZyLAHaYbJkCFZq+MCVTEfUFScV6ZdRLrAOi1lUCuBucB?=
 =?us-ascii?Q?vdrTrYepabnfJZoeWVx6vuVi7wgtMXI36gif+efyXLucdWnlBUmhpfBPPW3i?=
 =?us-ascii?Q?2sdFuY20UnvK/ojzLlUhBxYT/vWi2atzPQ+vpvjGW3aHyHwdeRMOh9mHQLa+?=
 =?us-ascii?Q?ZHu6kGHy+9Iqiai9+ary/7pjlQtX6d+Aaro4ys6uQhvnzeMC2j4RDdcC5ZLt?=
 =?us-ascii?Q?vSvL3nfCQM1ufR/YytxSmoG1hKn3fny0VUisHIU/WVrUwoITxIkEE5FqiITm?=
 =?us-ascii?Q?gkFUP45XP4iYzrE2LuXemdqWpIMUoXfKBYF5UpvQKwhx0j5MBBWojnFX1nhL?=
 =?us-ascii?Q?hnngFLMiqDCOclIXJFAKUBL7YbPY8ncBEcHjyy0E/MPB3fthp4NTMOykwAvk?=
 =?us-ascii?Q?rSKpTd6uXee7dnysk0ANduzpxoEltPDO2TNjt3ohpHWaGcijBx+47rCGqLxZ?=
 =?us-ascii?Q?Qk2NzWGQKuz1iH6qZc4byYMVcpE1l0NosNoapQySVbS4CRNvvfNducIyfVBV?=
 =?us-ascii?Q?fGswOZlOU1KCKTtwIH4WLWLwFuKTAvx8dLVlzul5Va38LxkqJDqhT9b4D/UU?=
 =?us-ascii?Q?vVeWTb281lRLkbF3PoEp2LtTDEuLzHITPuCrAsZtPryAcf5GOx/tW4h4morm?=
 =?us-ascii?Q?EVFd7fdipu7UE7wbail2Bm4cUdf+piY4xWTN+phcJW+1O4WP+b4tvheLQ6OU?=
 =?us-ascii?Q?F9bYiVy1j0C4ITcfJPbfdATpKbGLxcqy94UmnytI+zZpE7bAKice+FRHMZn/?=
 =?us-ascii?Q?g7lWrGp02YVHHesJH5y4tt5+6Ft1xmP+/JmjE/ORILfPiBS8jiI4mjtq+CM0?=
 =?us-ascii?Q?9ft2O2Y7+GlFtY4OmH19pyqdyzDEnJP71P3sn8kZSkExPk+E1JwJJxMvyL28?=
 =?us-ascii?Q?htZpz9R5muSWk7ZqHiA/j5EZLGWCEcZNldrIDUL/dFCtrUxR7FJnO2xxK24G?=
 =?us-ascii?Q?crgYVhMOQnXI0sY5fzaTxZni91Q9YAJ4wnVQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:02:35.1962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0bf130-ed99-4b7a-7d19-08ddcb7324a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
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

Operations are not changing that's why mark them as const which ensure that
structure will be moved from .data section to .rodata section.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 4f67c958d0fc..7a433a667a49 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -882,7 +882,7 @@ static int zynqmp_clk_enable(struct clk *clk)
 	return ret;
 }
 
-static struct clk_ops zynqmp_clk_ops = {
+static const struct clk_ops zynqmp_clk_ops = {
 	.set_rate = zynqmp_clk_set_rate,
 	.get_rate = zynqmp_clk_get_rate,
 	.enable = zynqmp_clk_enable,
-- 
2.43.0

base-commit: 7178360d325a7ea5356b993a7f4156e4e1e80719
