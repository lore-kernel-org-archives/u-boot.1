Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8521CC3DA47
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 08:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00FFD887DB;
	Thu, 11 Jul 2024 10:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KQs+tsYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6AB887E6; Thu, 11 Jul 2024 10:29:57 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB328876D
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 10:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPpzV+FYgP8j7eh89+iozDMyqL+Tlx/WQ71KCtOOGi4Gx/SifPEG1oTppJlGCIFuwWi2pl5DRwE0w80XKKxz/dFbDElnwJUKJ+LI+5CIVtAPqSqXFKeP+7VnhVGW9uAngjJZxE1Kao5n0TdLzJkCa1CPU8/0FqavQLJ/nCuW59Rw5o9aP4jHqIsU6/AT12HVX7Kgq4tMTibHDC+rYWy9hcsgAh6pQS6Z+ePgnI9rdgpbVqxHdFW1PNTUMojy1i3pNKp4K8e034W7I3TOFfXYz3NE6IfKW9lKOZhH98AsJcCQOXUFk9t/cLzE+tT7ijhTz1HTb7jiL0od+0i2nWdVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8msuhe8XduR6yJ1tG42iEvbo/H4uM4hC+NJXFe331A=;
 b=nJjtKOsZZ/D7x5Vfi8IhPsAx0/2EH1p6YnpdK8KKSRYfXVyyg+XOeR9p8EQ0sfbvFYx1L1aZ8HD/9T3b76D0vkBGZSN++umTGZNNrmYnQnUixieHRVAUCPJTmsy0q1QGeGsIbRubFisk95uPcr9nDTg/C6NSFcjFhBtcgy9HMGjzPpSvtLvE9HGBtuBajN8KtMf8NdpVMeND5hvGOlfE+vPJn8pap2mGiGgtLPHTjNQplQR+n4u6I9Jk5zcdKuWsBQZ1jq/aUU7vLSmRSqG3DeV2yQloUMBnS/6ME9VQ5ILAdmU2L7IIovAR5nHIOjvl3+f+sOmIpQkFcKfWKnc7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8msuhe8XduR6yJ1tG42iEvbo/H4uM4hC+NJXFe331A=;
 b=KQs+tsYYZKywl/Bt652Um0pPBKk/9FBOlOrVr9OGAvDn+QdYQRy4nAFvHrx1amnGADxjh2ESHnNF+ce0ZQ4V54xqv8c+SJEyMO4movhuaZWf1bxNzsKoTb55B/kWyBwMLJBHnTlF2zTFt0A5HhwEEsD1dO0SZrkZDLbJmb6c2lU=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:29:50 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::25) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 08:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 08:29:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 03:29:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 03:29:47 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 11 Jul 2024 03:29:46 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <lukma@denx.de>, <seanga2@gmail.com>, <git@amd.com>
Subject: [PATCH] clk: zynqmp: Add set_rate support for display clocks
Date: Thu, 11 Jul 2024 13:59:39 +0530
Message-ID: <20240711082939.29260-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d147846-aa7d-4b84-ba82-08dca183a168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HfWILvoL1r5G7nXBe4/pVhybPLfJ7/XYkcQZcf4KlyOFRXKtpVrsKg7G7DL0?=
 =?us-ascii?Q?7OYHQboyK/3oBIij8U9xTJfQbqiIR1gbEkKJzD1w0JU9ivAXA23ol8IgsGiH?=
 =?us-ascii?Q?WCxUZ+AY4qXKJBe1y8bs4epVM53FfCfPoLL2w8T/RGP37tIruh7naVAo7H8s?=
 =?us-ascii?Q?OsDtusnmP2Q9cIw4VSFvLCF1e1AyJFs2ticIIPCn/ai44krNspjdt3pSfnfZ?=
 =?us-ascii?Q?0W8Eayg4QrbO4QVxgH/SWngIPBGz2VCH41KVHobmNi1ktVhycwMuxJruvFuM?=
 =?us-ascii?Q?2zwqTAspZYNX5vxG99pRvwvs+uyJFEW1/X6BKcVAOLIPPivbt1H9ZSML1fKj?=
 =?us-ascii?Q?aYBzLBt3fFJyDtvBh6WNHcv457C0vO1KIOsYV3LTjfvHO/XGQ8Hp5slxNiM/?=
 =?us-ascii?Q?3D4XYGVd8dMFJ9cZSmvvVmsdX070eXNIcOM5R2HzndsKaisKnD2wIQvmjlId?=
 =?us-ascii?Q?VUtMwNG4F5udnqu4oVcO3t5SDz6H0lIJ/Z5z9yezlGAytligF1iJlg9OCtrx?=
 =?us-ascii?Q?B23CUgXZkW1mYfbagdPywoLPndY8tW+9gYWNU5RVNZ+ky6XyhYZ14GlsBnP7?=
 =?us-ascii?Q?QixzIXkM6zMzX0Ixu+dWzAjttnOwme+0oCXxzmKub/PSSxbw3nRK3nVI8Uz7?=
 =?us-ascii?Q?kr37DcsRWTPkwX7STQkL1lTyWKmnAnEWbYSYgrKQjlfS+Ngs5YinQiyEIK8O?=
 =?us-ascii?Q?7jS40KNCT7fzr3MtG0YEsosoWX95cZxLCBfV7n24p7JYGLEko5tCBx10k3ks?=
 =?us-ascii?Q?OASHUPNIg301BKydVP6LFRoWlCIfBgl/InHrLY/ry1hViMCDKW713I0QAqt7?=
 =?us-ascii?Q?QwBAbIisP0s7SXNurnPV6CL7acP+Ii98W022NbAcKH7FrhgdLUjqS/WGk8mR?=
 =?us-ascii?Q?rJgKp6G+e9FcHhTw3kmT7nMalfDRT5sNzwv3kVXJlvzK4319hB10r6cESJol?=
 =?us-ascii?Q?+jVWdY4903n+yy09GQz+oXE63fcso4pMlOkSgJhVvHr6dDZvyz52uUQBfqX4?=
 =?us-ascii?Q?hqdf88NFjz04SB67tRuEerN2pa2z7IMmXyBZ6lNOz2LGlGFALkJciRwgoBRg?=
 =?us-ascii?Q?BvoHdFVMFGPFaYHXyalbyUrrcKoNmhXzuVPzqcxlY84stbLCE5yRmNl5Sb3L?=
 =?us-ascii?Q?vZWkTFia39uFwxF+v+AdL6zVsJraS0OzDcEetuw4Q0Cb4Hyr7zzgQr4rTCh1?=
 =?us-ascii?Q?QwOq6Zy2Ck11AN6lcTZU4EHAz6gQofk6BUdnStAaHvhLKafoTcXXiivyi0ql?=
 =?us-ascii?Q?bBfdx+MOSvitP830YwsUl3xMrBVEfGDUm2MZvIh3XAeInNsVCOC7AYjMSZCb?=
 =?us-ascii?Q?o6Rs3H2+PrCXi+Mlp7yqQFsH4TFZoyPYsbCTD5JQ+uI/l00jxSeOVOcu87f4?=
 =?us-ascii?Q?hNTlwemNi7wU8Fi7+6L1fugTB4eqH7vlHhSOTr0hYkXTg3MIvKsXuUtzCD0T?=
 =?us-ascii?Q?nwAKsof2ZuEhp+5wTcjMQX8cMjpVZJek?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:29:49.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d147846-aa7d-4b84-ba82-08dca183a168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
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

If "assigned-clock-rates" property is included in the
device tree, display driver probe is getting failed, as dp_video_ref
till dp_stc_ref clocks are missing from set rate function, adding
them to fix the probe failure.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/clk/clk_zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 5999926614..5635451821 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -727,6 +727,7 @@ static ulong zynqmp_clk_set_rate(struct clk *clk, ulong rate)
 	case gem_tsu:
 	case qspi_ref ... can1_ref:
 	case usb0_bus_ref ... usb3_dual_ref:
+	case dp_video_ref ... dp_stc_ref:
 		return zynqmp_clk_set_peripheral_rate(priv, id,
 						      rate, two_divs);
 	default:
-- 
2.17.1

