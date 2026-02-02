Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E193BE7315A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 11:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE4883DA7;
	Mon,  2 Feb 2026 12:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cqhtMuKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7AC983E0E; Mon,  2 Feb 2026 12:37:39 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4699E83D77
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 12:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irL1VcOxTTvH70vUUOSA51ev0DHdcw2mQmkNEgHZXRcYUjKKVaBxRQ+LZPJnRpJjs9agu7HBhadKcX5Jvcuqj69Qqxp5chshBsApCJXp+e9QRW83Y1RVeDhQtooIcryVkO4mHNRs4TXPFO9qEnIyYDk+ghA1Tcx6+A1S2EDc4pmgH0qA/jccVv8hTNbX5PcEW7ZALkAEh91Ca1i25ykiCPeBVFCiMsjBX5TG3rCfOzZuGNfFR54JhTkxs2VcRSRG8FLVLWnEr+t+3NnwgN/NtDCRGdkd/xH8wmIAenM11JnS2WFbvzEbEBdF/67IeAUVrK6Qd90/dAK2mFlyp5obtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNmEOpIg5hpyd5/8Xs5heI4BpRxrhQVCCl+F1YGyKAc=;
 b=wC8Foe4qZh//PhLw/EOukrSAWDzox9N0iFTctSKTwF/LclmPsqQqk50AKE4+5gxYKTRISOc5QctdOa7yHcUIf+ILMGSVKilnoYuXongR07fBs7zs+L6qp/jKdgcAuzM4UXt8BDlQuTujG5Bu3Pgwh5J6lYiEex2NuEK3XqFyv85/58GhfmVYWpBJIk2l7s/+0dXDkTMdTlwcqba+pPIgFb/ltOzW9gij6gRcJhdXoatktkcsdRgfV7uZ93QBPL3sg1E2qwHhIRJApIcGsovCXdUZtvb8kmKatzaVQZ/zJbh9+YP2mGHRqhKELoEIGZfG3cwXy/Cuj3vn3OebXrtgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNmEOpIg5hpyd5/8Xs5heI4BpRxrhQVCCl+F1YGyKAc=;
 b=cqhtMuKWXmcVjHcmqKl9teHKpafIi2fVEblvuWbPy8Js7CPzJ3c+wFt3HLfbnu0o38jbOWchCzaBFXOv2OWh8/E/I14pt3be1zPa1+KMCCSYKLi93YrvgRd2ly+Sd+TWnazVGPd0V1jdFz+AjOUgJv7+TLS8RJxAP3EzciEjoYc=
Received: from MN0P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::12)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Mon, 2 Feb
 2026 11:37:28 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::21) by MN0P221CA0006.outlook.office365.com
 (2603:10b6:208:52a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 11:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 11:37:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 05:37:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 03:37:27 -0800
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Feb 2026 05:37:26 -0600
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <Padmarao.Begari@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>
Subject: [PATCH] efi_loader: Improve EFI variable load message
Date: Mon, 2 Feb 2026 17:07:17 +0530
Message-ID: <20260202113717.2696718-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 85644c80-eba1-42cf-695f-08de624f7200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nxlY28G1v+12rbpj9Ims50wJK9uTZ9+Pca4PADn/YPQ4gKBD+NJNBjkLMsuG?=
 =?us-ascii?Q?brBGYwAZmJAfK2wKKzmNLPv934SqgMaNwNPof2tSQJKXhHwYP2FNosQHWD5k?=
 =?us-ascii?Q?EhPK3NFL42K/gBOZsmjsRwQ5J8SudEl6PV9q7OQbeDoKfkpUJM13pVpZ7SmL?=
 =?us-ascii?Q?0gTurVqaDtO5/yoQm2XzYlFCwdapT9bAU6wHxQBJB5LETYtilwytAnOm5al+?=
 =?us-ascii?Q?Eu1Z4PGrB6KzlYL7zdFiKBcEl9xx4m641XgVX+Ha5tmLNt5iWncCJb4mdq8n?=
 =?us-ascii?Q?XHfS7Y9GgsUu+z5mrzQAFW7IuHYOniJpFWVdYS+Jz/4weAp5d/l3yMDK7496?=
 =?us-ascii?Q?SnC5Cijf4/ZQalSRZ/Vw6yvGikS+8adaimDg+KVwuMQCz1BIx2FbH68sAnX3?=
 =?us-ascii?Q?dfp2OZW6UUPjg5oUWuafoYpsSX40KgxrGyTE0QE2MOQQQhzXt25I7xl2QyYu?=
 =?us-ascii?Q?MRkhEDXhByg3qf56xs53GQMIjOIBNDtnG0+hcsltBY9eDssmc5NekWac5TAD?=
 =?us-ascii?Q?i/ai5QYcHt85xb/8MGXPFjLy7FCh7prlnaKb2dXquh16Qq11s5jkjzh6Np45?=
 =?us-ascii?Q?5oyKqG4Vw5lYUuv35g+fKIKgh+buHdszMy7lkQSOtnA+iQXtzdCriv7sVs8D?=
 =?us-ascii?Q?NzQhS/+Di1+OKv4GYM0ZeXLTsuZf0nZ8cN/6RHvZxmGCRUXZ1YhTzUM3JkbW?=
 =?us-ascii?Q?MW7ieKm7KZ9RvHA9WLy+oe7OCRVDYuEZWhiBAWCoTwOCneUtWjAV5+0E2lNE?=
 =?us-ascii?Q?ZdhC0C+8G7FwM7oFD5e3KFc4IyM66xvywUrw609cRaIvg9rGp20C9OEmz5fw?=
 =?us-ascii?Q?3zpQM5UrVYtcRQ3HCtfa3B06wUXbC/7WXD3o3IzRI2K6h5/kmHWTAdq+WSIi?=
 =?us-ascii?Q?ODGmqcPkZa1QsQxI5fJJwznnw4ECX/Y/qCieUYwEKDRIdDR6OJYTEnBeNofO?=
 =?us-ascii?Q?Kg8nfwPHDEWPC4sOUN/wq0oqpM6Hk4VUMy5y8MrxqsRkEtEpMU08/UuXO/Uy?=
 =?us-ascii?Q?KfNN9WfEq9gFvvWE/UNJBM107uNQeCJQEcUi6N2iL77JNNEw/fbPsd1tkr6P?=
 =?us-ascii?Q?7tPMVigQUsgzoquMB9oJROpcqlFyvGBTWgKQQlrLB5VZ/AnpTMjaF/AjLeXb?=
 =?us-ascii?Q?XLMG/NUuB2jY6W4foP5H9AmU9RiOuvJauWHb3NZhWKLwiaAXEm7wPHUnjapA?=
 =?us-ascii?Q?uGTFR+O4i2OTcRF+zTUrqGKcQY+JNc3o7Rd9NzPgW8jZnuUeNiHXGn8ajXPF?=
 =?us-ascii?Q?pis4Z11du+EXv/ex5wpVDu1uZRRoOekQP0Hu0WoK55gsFtaJK3wbtzZ9/xoX?=
 =?us-ascii?Q?EjVL4RtTD2zKftVWormtBpqaZmUmPCO2hI5hetHJlsu8H6FruXsmk+AmFwnH?=
 =?us-ascii?Q?lwRj110aoVHyMp+F+Xg+qE3dGyQx5PauHtxNWsIlmWsf4pZ8qxY2KdwLCTTq?=
 =?us-ascii?Q?olJK3Gxe/3TSH7I2xe/m8DMMzVxdbh/ULEDgCE1oP1a1ksn/4DIDb/lnx++6?=
 =?us-ascii?Q?b/trkHqMbfwkyM+7PHfWcFvS5z7at6LYuBNqQ+bqO/o+wBs2DM8ze+5YXL1O?=
 =?us-ascii?Q?DFTE6fFUiIlxoX06vugI0oX0WFXDdeCAGO8jCrGRZXA/pOEnwhhwge3gjzfn?=
 =?us-ascii?Q?2lyY1LduP9mKykR0tBw/oy84kN0Ga5iskfgt0M0LOApQDM0vIW27aCkP83lh?=
 =?us-ascii?Q?IlHMeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DWPda/CwzqZP5bxjPrrS8QTnOY5sLo3mA6c+bMm4pQe5SkFwFK23L2X8ZjMlU0Sx+SflWoIrkMHUp7pep4+jLvTAFWSwAN1oaPT3oR9rq7jbaCtRyoeX57zzj76zxecI7eb3bMtyybXmen9uy1tKKBM/UDBuudQOLeW4/3BtNC35/3hgI+rURlXqq0PNFL0n53M0CToP6pJZQZLf+tqn1gaNt/cWIvCzfgpMkxQkGwPg1HCgAlbvXvqwSLyAYAjF1iNASDKFikBTA95ypwkb9riX6vcsw+waST32/83a6+knz9yeR0tzmOfac4SqLybrwmSjlGYJ2orHJQurFkZ09ND9q/HUbrk3Cn9fB3DE1hICAcFybaSaU7TWJV6upbWUenLtlsio84lbsYZTneaWLhOs5vp/eIVzgMcoI8UeTRF3ACJSSEvv5pyxPIV5zsw8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 11:37:28.7392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85644c80-eba1-42cf-695f-08de624f7200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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

Change the EFI variable load message from log_err() to log_info() with
neutral wording. The previous "Failed to load" message caused customer
confusion as it appeared to indicate an error condition.

The efi_var_from_file() function deliberately returns EFI_SUCCESS in
this case to allow the boot process to continue normally. This is
documented in the function's comment block but was not reflected in
the log message level or content.

The message now uses informational wording to reflect that this is
normal behavior when the ubootefi.var file does not yet exist.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 lib/efi_loader/efi_var_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index ba0bf33ffbd..f23a964a418 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -173,7 +173,7 @@ efi_status_t efi_var_from_file(void)
 	r = fs_read(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, EFI_VAR_BUF_SIZE,
 		    &len);
 	if (r || len < sizeof(struct efi_var_file)) {
-		log_err("Failed to load EFI variables\n");
+		log_info("No EFI variables loaded\n");
 		goto error;
 	}
 	if (buf->length != len || efi_var_restore(buf, false) != EFI_SUCCESS)
-- 
2.34.1

