Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5981C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 06:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8A283EE7;
	Fri, 11 Apr 2025 08:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHKVGni1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA44983EDF; Fri, 11 Apr 2025 08:31:37 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC3A83E96
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXwAITy6YBTb7w1ERpRj8npT1m+9TBsz7j6b2BOJt2PyOtc2gIbQWdJNX28L7w8CNz/HnHvjNAkyJ3eqZCWn2Nj8X2kn/Et4bw/ZIGI6kVLaME8S7UdiS5Z7YSO8Y32IgrQ1UIsiz5yU5cKgra6ZWOf4g8St8+45tAoBlaVASLgHzRW69CNzhf35UarPACijS3ZlP9TR0MvBg+L+vOy48Un+YIjpHAKsDTh6OkP6xcJqmX2eghs2vBUPgiZbvwoVOTncAm2zh4AkwbmxWK5e+zSScH7aHevNZZQBavqFJj0JpfJMAQMvEI7He0nwDAIv0ybUKAloN5QSUnR83Tp1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXddEIJeTxDkuSuZqe15Rd+XDsUMgc1F3OeY7cy8SHM=;
 b=dAkqG4W6CT5Hs8InK+Gmgb8ThEMtwWT+0xoVdCkEJR3TjsASRe9WD3mGPpNl1Y1W2ssEqza/towQD7cmFnKCxIVP3KbTJosEk0nLfntHhwct1fWvHANVWDtpw2Trfn+xtstFPmApcr8hNbqigsp7B7gfFfTDBYTnaxMqkkN24pAQ2SwJOGwQudkE/LFjW4uTCzeGOH0acmsvImk00ck/8Vr53VkpDeE7JsudFWHH50M6iUx6eu0ALUw1madm96bnp2ii8wYPwBzz/FWb8PCgZR0riUvh9iIVtWpt+wH9q3neakEuvurR/4yguR30o8Hp8oTsNmOy5r+/YESpWuC2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXddEIJeTxDkuSuZqe15Rd+XDsUMgc1F3OeY7cy8SHM=;
 b=UHKVGni1XT3DA6DH+8///PTfsBb4tHXp7nxJIXj9YOLDXw5OvJDyIU5RKC1W1C6v6U2Nr7snUpDJMXv7MvPFTHN2KgFgfaFkRKDZBv6VNIzf0Vdh66PfBjxs+iTzy9M0sM1E+iz+HO2jbm8bImiOmN06Aj0Czt7a+J+R4wOWcEU=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 11 Apr 2025 06:31:31 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::eb) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 06:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:31:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 01:31:29 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 01:31:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: Remove CMD_NET protection
Date: Fri, 11 Apr 2025 08:31:19 +0200
Message-ID: <a28c1113f97c4b480ba6b75ed695147eb17a20ec.1744353078.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b75fea-00fc-4f93-e3da-08dd78c27f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xo2xHQoSF1dq0Z8FNXyRvFfIZdB4UlRsw6zXxi8M2RmOvl4k3IO7i+5yo244?=
 =?us-ascii?Q?B9ZZeMyl1kjc3sgNVjGm9js8XRags9+zXQCSfHdJmXHWeK+r8mmZZrMD3Cfw?=
 =?us-ascii?Q?W3An9TugBujShz0NJ0w4vFdy1auXNncS9ETtivhGyWKwJHY/C20L8iXdOpDw?=
 =?us-ascii?Q?kFRY7fTOoB+jicfM7KzUpZFOE8uB3Oqh+2xx1Utxks9VOvHCLavjfjYtoLRY?=
 =?us-ascii?Q?+y9YvyeEonDuTV44CiI7ro8/O6wnOur4UhDYWi42C6rr9Z7ZctrRGSeWrPLn?=
 =?us-ascii?Q?DKlrbkMuO1Un7jcmi0eG2NjTJsJwKWoLzpkkUp88UxUoZzMrZdwiwUIzzPpk?=
 =?us-ascii?Q?j/99ML8vF7qrWp9akH/zkBqbl+fGnOI3jZar5Y+5uH4dyUk1BNFRkk64FYUk?=
 =?us-ascii?Q?bT8RV07scels62UcDRTl2w4GwQ9VrXL/UiPVnmv+Qz/szD9DdE3Fg7NptX8P?=
 =?us-ascii?Q?RwklMrrAoa8fCX3BBqTJFpq1UXtMbOgSz5mr0MIIcrFAmLtWGz2YJneshC9f?=
 =?us-ascii?Q?LPwzYTG32TlvjzE4SPkMkdIwBtDF7q5YBtX8fTxEmk+yKfSWx24AwOENcPCY?=
 =?us-ascii?Q?2nF4WrNxuVP3ovKOlHDoUSbFOLU+NLV/RSPKppMS6xjj9GjVbbQQqSe6dmne?=
 =?us-ascii?Q?7SzSIGQOUTbMokpjJPXtwOMP/nPIEHBXiSpyQBjoLxngaHl6OPizxRGeEV87?=
 =?us-ascii?Q?zc4ARUNIOy79sPd5a5sSGtfwbvriWCJxxJzaifRM84Ppjov2fIJKG+BFJ2E4?=
 =?us-ascii?Q?MVpqhDMb46H3MMyQtTK9XpPGGtmmiziJi+bOc/4RU3jno97dbI51Ei5VnTNr?=
 =?us-ascii?Q?rnhE1wAM/eYSryw+pi39Io3Tk2AVIOI6YgfUs2mHYq7xkuvUYCMcheC/x9mx?=
 =?us-ascii?Q?H9nqyjWI2hjq4cnbVaxwW5tHMmT+yqUjOvIeJOL1dnarI+UDjpvAiHYaKCLS?=
 =?us-ascii?Q?Lcs/xZyCzDFBbMUKVgF26G0pCRqNAYFrwX8GDXyZpQVaxb2L9YrRq3K3B23j?=
 =?us-ascii?Q?+9x6OjOb054CS+T9/61miwLeHJ+uVSnRBWGcuW5t+5gXFffSBckCIwVdGZKL?=
 =?us-ascii?Q?ziBh3m0aNin7awaSnwVFCKqEXG7gd466D0SvzCKP6SkMdL09r1oTGnG9EYtq?=
 =?us-ascii?Q?d5oY7cwb1OaWA0Uf7nUxeBeu3MqEUTpO6df7NXZRBJn1fM0WVcuD+YGW80L7?=
 =?us-ascii?Q?8etAMOkU0wZWpwRAMVEwBiW+msmzAhdHM5ALVEDmiuR2tuR3of1vUGEpcVsM?=
 =?us-ascii?Q?WGt1lE/VYpv3TEtz8I2dHSLrlM5QutspTUGFivljCkwu8XkbGoLgTJnbu61r?=
 =?us-ascii?Q?k8dPlEQ9HrMRkfViE8ZavwljtOocCQdw/ckVMhSUsmfUdovQ9h/qcNwVeA2W?=
 =?us-ascii?Q?PTIyZzTrWw9ER8VkhFGOB8fxGDbBmD9E+zpBAncK+QiEwZQK1dDrynwRCq8v?=
 =?us-ascii?Q?/VznwYCE3qlafZMNoQseXQv3s9ixRuK8RiogT2OTC40xzzV4Cg3BPcwB9CiG?=
 =?us-ascii?Q?QqVcCz/llTu4On4yJ021zNsxkkWN97+VH5Dh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:31:31.3839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b75fea-00fc-4f93-e3da-08dd78c27f80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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

CMD_PXE is already under CMD_NET in Kconfig that's why make no sense to
have another ifdef inside source code.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/pxe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmd/pxe.c b/cmd/pxe.c
index 37b8dea6ad6f..0f26b3b42197 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -13,7 +13,6 @@
 
 #include "pxe_utils.h"
 
-#ifdef CONFIG_CMD_NET
 const char *pxe_default_paths[] = {
 #ifdef CONFIG_SYS_SOC
 #ifdef CONFIG_SYS_BOARD
@@ -331,5 +330,3 @@ U_BOOT_CMD(pxe, 4, 1, do_pxe,
 	   "get [" USE_IP6_CMD_PARAM "] - try to retrieve a pxe file using tftp\n"
 	   "pxe boot [pxefile_addr_r] [-ipv6] - boot from the pxe file at pxefile_addr_r\n"
 );
-
-#endif /* CONFIG_CMD_NET */
-- 
2.43.0

