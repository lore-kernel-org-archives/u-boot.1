Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB84FA374A
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 12:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CEA688D63;
	Fri, 13 Sep 2024 14:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3UZrntAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40183889EF; Fri, 13 Sep 2024 11:32:49 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270E888936
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USha22tsiCMr8vV2wSoYz7rHBa+LAMM1QkP0px5cVr+HBRmNRaGhStfklpSll/s9bSC4tEbIlvjqJ13tNBg1loyxVxvaBdTzT7rsE5b1CvIoecz5CAq/bRXCqPu2/k9Y1VlexN6587u3XhW7I63Rm8pjrnW8jMAcDe0SHCDGRACH8WvnNiIuoa5BVgFshJRjjRCA+H3Endtjr05ywEqnZS1zkmJwuXDrOmTWXa4wzJ2b9blhQKheGSZDoSB62GADtqUdGUOXTaaAr8eXV+jtYrh956Rgaui+0j6iu6DSTh+CQIEFr/gunZlGO7aJnMwrRQvjeSWVHcViUJXCUaXaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WODwaUrH1xjDvaGD5Wtjd0I6PN3i4o2Vjys8RZKixoE=;
 b=uqBZG+2VUNJSy0R+ifsPlBsAMcZuRA+vjNgWhDwnSk76+9e46UM0gfcV1MiPr5wDnG0kwEAGFhKH6hMHZA3Tl6jTcDyFe/Mp0IDsWmdAp25g08C+bl7tuAKDmAlnOGTxTRoGBYcgwh7jscsNowpvkNyrT1aXtHC+tjphmrIMQHo+GSPA2Xtgu5JHnxti+Qo4ookhGaiV2EFfGTmvKRM9v+SWWj5rmMKC1nlOc4MZQgCXmAHy04jb84eSliAklMsVosF+Vd5bhcrpxkfQSV4rSIDubhoPx90RusgHR92wRBOe3Qcv5Z9wyNvJYOLKyycQVUd9xEOMSURgZ9mXnK9UiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WODwaUrH1xjDvaGD5Wtjd0I6PN3i4o2Vjys8RZKixoE=;
 b=3UZrntAzrr2TJmMm2clagBAb4e+HPRw8ftp3XR4JrHJ20R8J66rz2vljhOl1QycsyUmLRZgjUd8+PZU/MviPJiXQzKqrkhhIi/GOdcNT3nmjRRjgz6n8n+O3Xse2XEKgxoO+kXDVZHpsej8ALinYSrWgJef3KGh7SABpz6BgxFw=
Received: from SJ0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:a03:333::30)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 13 Sep
 2024 09:32:43 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::50) by SJ0PR03CA0115.outlook.office365.com
 (2603:10b6:a03:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:32:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:32:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:32:39 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 04:32:38 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git-dev@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] board: xilinx: Remove conditional check for Microblaze
Date: Fri, 13 Sep 2024 15:02:31 +0530
Message-ID: <20240913093231.2343528-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da60990-6cca-4dce-671b-08dcd3d7048e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aMIZ+7n0QCBD4GD1Gp7XZvWHDg/vdoaGV6fTUYqkydgw0R9WwT3pdRb5HRHm?=
 =?us-ascii?Q?6hoX6qhtS/xzCsz5dy5IIKrDVHwmxVr/GQifaUBWMQRJ+8Z168tPxJRn0o7X?=
 =?us-ascii?Q?qfBKvoMURJ37Lvnr3AwsM0C1hgvSgI7uyjRG+o1Tm6Hs3GgNTzXtDEuL25YV?=
 =?us-ascii?Q?rvRGxFon0V3riT4Z82XBgx6KKGsGj5ppjmDQk1VO4t0M53dddfJy7QnFzTRD?=
 =?us-ascii?Q?IbseGgMlA6fE+2k5XNs18PM1LSpTDtFRY33Yikmw81SGZRnRElxr75PajYmp?=
 =?us-ascii?Q?4SDLDi7h40Vyq2upTBBfTF0/5tBX2uS3zuRCtAtvHbI5E4m4sUMtG/5cZPzd?=
 =?us-ascii?Q?2MPjU4q36GXj8vnRsgDuwd92C5uyY1SfnaXnqNdhRw5Y1xT/9N+TrsBDJ9in?=
 =?us-ascii?Q?0XLgrTY/ONZB6lP6fdIvQyUYTAw9nDIuF3cpBxsJRXuB0zPCZTlQruuLK3K2?=
 =?us-ascii?Q?NH4/gExZFUAMz7aCQYDwAAZoebOJG6o/3KcJ1azR+C2XW8J0F6KJ9HYpdflv?=
 =?us-ascii?Q?6a9QAZISoeHM/l42PojiHBAL/q06NeTjt7L251WNlhhC3ROltDPm59/hbdCk?=
 =?us-ascii?Q?meMtuOGgzE0rE2ytWYFoIMEL8yITNi5SLTYGjho5WTsnb1Gw9cc/6Afz241M?=
 =?us-ascii?Q?RR3jHFwC7WVll7UaiiSn9DqT6FlYocFMqcMHg1o/pWAXLQ7QsxrpGBgLXrjq?=
 =?us-ascii?Q?+53asgZlymmfCxniSbjb963Awf2TbfqWKKU8cM7niQP2b3zqloZTO5PkXG4W?=
 =?us-ascii?Q?mkyRv+pPcNCZy7D1dKYem5nGMx55DGCUNNqVawREVHkYR4s0oY2kn+xF0ixr?=
 =?us-ascii?Q?weDOgfrApTRh3v4q8u3TF5tQ7+S3QNYJxqrcI06+8423WYo+n/LVuhDFtmQI?=
 =?us-ascii?Q?li93s64RLWrNrzUWwl0UP0NacrPTY6NF7+qbxjjZLDLpE/DzSuqzC9zTjmSJ?=
 =?us-ascii?Q?CwL69KoX8y3w39yByGwGU8QC+GFwiHo1Hnn8zJOWaYkjjD+7gb94ZfcFjVRB?=
 =?us-ascii?Q?apD66hZHTC9th0mwDf3Z9C0lMJXgcbOtIF7nI3bYrl1ojuhdPTznC5xr5Z31?=
 =?us-ascii?Q?HdQ6AWVp/W2IaRmJPYs9IehJNtJ01zttTX6Vf/Q2yuFcuzoLvaA7KgmpZIpO?=
 =?us-ascii?Q?kJDqEpFCJcI4zGl9f6mQ7Rc2bfZwE2W3vqkDJj0Vy+HDdqMGWi6bXRwc974o?=
 =?us-ascii?Q?5Ie4WUIVwCnDmUdpxUXpdrBqpMYBfAVS7N5KOp9wIwOwcpd8V54XhEzXgZPn?=
 =?us-ascii?Q?IGm4wNovfDCzVSnbxaNJ2VPOvfWTqQdN0odUyYfqjgcanQASDu/ubYisNdOW?=
 =?us-ascii?Q?nhQL2NvzII34KgTdx7RbmZ56TJ7tNLKbMnWOfD9nPDJXQWEQsKS/d3VkeJDk?=
 =?us-ascii?Q?Noi8ekPkcYOKK0dH6jEo2vk5jcsNVRtuPDsjANw1xJeqSDlsmdtRvvANSzQ3?=
 =?us-ascii?Q?y1++nQ1TSZo/Rrxu2ByYHWv7BRd1BwCt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:32:42.6076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da60990-6cca-4dce-671b-08dcd3d7048e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
X-Mailman-Approved-At: Fri, 13 Sep 2024 14:37:34 +0200
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

U-Boot is not picking boot.scr script address from device tree
rather it's using default address for Microblaze platform,
and it's picking for other platforms. Remove conditional check
for Microblaze platform, so that u-boot pick up boot.scr script
address for all platforms from device tree.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 39 +++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 0b43407b9e..a217b39df6 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -426,28 +426,25 @@ int board_late_init_xilinx(void)
 	struct xilinx_board_description *desc;
 	phys_size_t bootm_size = gd->ram_top - gd->ram_base;
 	u64 bootscr_flash_offset, bootscr_flash_size;
-
-	if (!IS_ENABLED(CONFIG_MICROBLAZE)) {
-		ulong scriptaddr;
-		u64 bootscr_address;
-		u64 bootscr_offset;
-
-		/* Fetch bootscr_address/bootscr_offset from DT and update */
-		if (!ofnode_read_bootscript_address(&bootscr_address,
-						    &bootscr_offset)) {
-			if (bootscr_offset)
-				ret |= env_set_hex("scriptaddr",
-						   gd->ram_base +
-						   bootscr_offset);
-			else
-				ret |= env_set_hex("scriptaddr",
-						   bootscr_address);
-		} else {
-			/* Update scriptaddr(bootscr offset) from env */
-			scriptaddr = env_get_hex("scriptaddr", 0);
+	ulong scriptaddr;
+	u64 bootscr_address;
+	u64 bootscr_offset;
+
+	/* Fetch bootscr_address/bootscr_offset from DT and update */
+	if (!ofnode_read_bootscript_address(&bootscr_address,
+					    &bootscr_offset)) {
+		if (bootscr_offset)
 			ret |= env_set_hex("scriptaddr",
-					   gd->ram_base + scriptaddr);
-		}
+					   gd->ram_base +
+					   bootscr_offset);
+		else
+			ret |= env_set_hex("scriptaddr",
+					   bootscr_address);
+	} else {
+		/* Update scriptaddr(bootscr offset) from env */
+		scriptaddr = env_get_hex("scriptaddr", 0);
+		ret |= env_set_hex("scriptaddr",
+				   gd->ram_base + scriptaddr);
 	}
 
 	if (!ofnode_read_bootscript_flash(&bootscr_flash_offset,
-- 
2.25.1

