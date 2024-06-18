Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8AAC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A65881D6;
	Tue, 18 Jun 2024 15:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QBrVhcJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A43A87FFB; Tue, 18 Jun 2024 15:16:56 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D851588263
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVo0Hc4yjbtXcm5zESrufMELlgdsDTL/r3+kV8WCAALv5HplTnG1uCIhh3v5keG1Zjknh82dtVTSk/waE+bEB1gILSBikDN+zg9iYlhnGh3CPpHIbJSnWEal8KMrrb02Dd8PmadkWCQPtwei4utAS+4l9a6G74zGM4/bBztu8H/pGkl4djz1V9eZA9qSgUTDFPEkwCTvPPdJp8sTqQdUpNZE6hi/X13RUGQ08I3d4ZVOTAXfT3IDGzG0+GFZwDyEHhWSNVggdsyslRmUL1zvLoNZvSE53mSvX/aMaapAjWvDOibAOYRJXrZhOSR+0quQLGa6Chv1iKGdGwvziPdrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS4y2D5Zt9hfTNWgKHgLz36fu6x2MMa7E4wApe9kuV0=;
 b=WoK3bDD8FTcxJKl8Cpa4g8yHY0VVXtqme+qcODxi6L2W6Ynj644y8ZppObMJTdlqVn7NL7gLEuBJn3tS4dMGDt3DoVCJ9fOAEF8Lv4k91rERZQ7Ej4PkoVkYPFMBrd6dhCqwXHSwWztUxCuEu6PvOn8+QQhdA3L0Qy2uiDt6rNuUkPanSuIt2Q5drxv6KwbcgSFvd4y6auetmOyrFM4XrjiA3apgB++eLyJPDUTeM2IGMlDGUwuQVIBOgiJjp/BXfewms8gKssEnIHVlyv4itQIa/J3NvBy/UwiUhMT8l2tDhFeOd2EAESNCZvPPFShNBI+fihw8meQasleDGSVz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS4y2D5Zt9hfTNWgKHgLz36fu6x2MMa7E4wApe9kuV0=;
 b=QBrVhcJPbINNzT4C+v9ygUiNU07yQLGVgwSE4E5PGlPeH4rwnUKechPk9VLR1fs6BKmAmQP6hxxYVh6II1ek7bh/6jwTs1i2qpEuOZjpn4kYWhSAkNEDQT2dxqb41WyBfiyEFsvi53tWNPDm0/r3KZo0vP5ITe7E/XHx9KQzvEo=
Received: from BYAPR11CA0096.namprd11.prod.outlook.com (2603:10b6:a03:f4::37)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:16:50 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1d) by BYAPR11CA0096.outlook.office365.com
 (2603:10b6:a03:f4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 13:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 13:16:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 08:16:46 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] amd: versal2: Use U_BOOT_LONGHELP macro
Date: Tue, 18 Jun 2024 15:16:38 +0200
Message-ID: <9fc5f9c3d92a45f0603e6e912394655f42e96173.1718716595.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=F3DHZ6okXpY8CtKR0Y1Tz0aSn6+tdq9Au4Q2agyVVr4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTCjh3Llh0QK7MMWbN+2c2GxM39eRxLt19K/XN466Yf9
 beXXeNk7YhhYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATWbSNYZqGYeJOXR+Opwcl
 P1dO1pgkulRBimG+q+nyU/kXbZd+qtgr8L37d1Zb1qF6AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f77713a-bd36-4d66-d07d-08dc8f98e9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yXb0p3VKyQc3IlIERcWIl+gyW0O4DDIEDTxAX7itV4iOD3T0hb5A82KcUNzt?=
 =?us-ascii?Q?TyxuDYaUQa822nxrFwDbEQatnvvLMlNs4qE0y7fk+t6T4vzwGpk0qrLLaUNR?=
 =?us-ascii?Q?ty2GGba1SRfBRJ2zgtmvNf2iNU89L6/9Z1orCp1R376zC6X+pNULIsU67Oj5?=
 =?us-ascii?Q?EM0dXE4ChLwD4qZbsstNTvqVVLiInVPLtnpOUfTK0n8lfFMEqwudgAuUR4Ny?=
 =?us-ascii?Q?zw5Z90nJ4BesnVibzal9lgFFalQyjZkactBS1LGboeWgcNnFYp0srNb/P4S9?=
 =?us-ascii?Q?fKNZX3G3uqK+efVHAR5FB+qCTZyds/zCbZFpGd6uxdOC9YLmlUX7mMNRfNFp?=
 =?us-ascii?Q?oR8mwS2APNPLIyLGMZKfMAV5ZJqe2ZEyBaMikC/3pFlYeBRLXkxIFJkIKIVk?=
 =?us-ascii?Q?7cLd8E05mXcKGSlDLy2Pc+h6iUMeDLKGOehtFmODVRh0LWiI/sIrFU2NObQX?=
 =?us-ascii?Q?YWD5zk1Z5KJ225M6noUF2FjE4eHyAWn0vOmvus0aw0ay6X8l2DcveK4SN3Kf?=
 =?us-ascii?Q?Lul3OMhh5FTW7vPYaG9y+8cfJzp1hMlPpNGdfPLWRKaE3Ao9Q+Ff5tMmZkPP?=
 =?us-ascii?Q?Q+ZuUxGso3s8Ytnbov6E1n8sLZL7ccjatjpBHdvKj6AHACTTTYmd1cf5N8pp?=
 =?us-ascii?Q?DLMD4mgim1wXufkMdj3UBxXxtO4Rbi95GoEJ7P+XeGJNrir3N/pplIdtZcjF?=
 =?us-ascii?Q?XH1x28sRreOu0wNCQWUJ/8gMiJebIrAfxbaNBY4ePlUR8Pfp4FjU+iatuCmD?=
 =?us-ascii?Q?DorPJ62tq+xrBKLaOAxDPmZciZNDmgye4VrK2eJZp+pLifhsN9NoH7AxUvoF?=
 =?us-ascii?Q?QInipr/s+09Uri5+Fxr5G/cDXzWo6xjlfVtIvGI6JjAtksaGIiGhrACXOgzx?=
 =?us-ascii?Q?qR82U8cnUtbZtonE8Uu+ZQ6QCB0Uz21ZCWaVgBfSMe2di5o494I9uD1AGd4n?=
 =?us-ascii?Q?wrH2SyY7iombXlpOUumzgFE6q6LF1ySQ7vCs5k0Cfsg0UQh1A4gwhw1ppQwc?=
 =?us-ascii?Q?4xrOAtk2qyeTYFIla2+vfx7VIpPqB3yLVSriEfm9NgSwqkdO752+0FGUCooj?=
 =?us-ascii?Q?XWofCCXIPzW3F102H56CNAWTOrdGoh3CvQ1LFno/ooFmqZY3NxXI5p8xdkkX?=
 =?us-ascii?Q?cfJ85Uf67rN5udaXQAVnlOuDf04KMEqErQwct7u7MErbr8ObjOsQJLHQddtY?=
 =?us-ascii?Q?HzWYJ9KVS8Dxjzfmzx4Iu+k/J+XKUKlSXlQKwNCdKr1vGuz5dBTkSLywOMN1?=
 =?us-ascii?Q?OsMs4pa+OES6VXP2ORxtmEG2+VoHSvld4WtIT2/9E2w6sldTiG7IYMJ9UhCO?=
 =?us-ascii?Q?PE0ERjdcS4M0ZKfBs5DdCEjOwbR5nT6gTty3Z7b00mk1BXcQs13QKn02eJhK?=
 =?us-ascii?Q?E5D30UM4Xu7yFr6LxgaNcr8nMJ4q+hY+oKzexM8ihjf8vX61Dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:16:49.7103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f77713a-bd36-4d66-d07d-08dc8f98e9b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

It is defined as __maybe_unused variable which fix issue when long help is
disabled.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/amd/versal2/cmds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/amd/versal2/cmds.c b/board/amd/versal2/cmds.c
index fbd99918a7f4..56ae39bc6a1e 100644
--- a/board/amd/versal2/cmds.c
+++ b/board/amd/versal2/cmds.c
@@ -71,10 +71,9 @@ static int do_versal2_load_pdi(struct cmd_tbl *cmdtp, int flag, int argc,
 	return cmd_process_error(cmdtp, ret);
 }
 
-static char versal2_help_text[] =
+U_BOOT_LONGHELP(versal2,
 	"loadpdi addr len - Load pdi image\n"
-	"load pdi image at ddr address 'addr' with pdi image size 'len'\n"
-;
+	"load pdi image at ddr address 'addr' with pdi image size 'len'\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(versal2, "Versal Gen 2 sub-system", versal2_help_text,
 			U_BOOT_SUBCMD_MKENT(loadpdi, 3, 1,
-- 
2.43.0

