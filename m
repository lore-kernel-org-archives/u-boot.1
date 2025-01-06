Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5196CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBFC80137;
	Mon,  6 Jan 2025 10:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vSqkwzJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D739801DE; Mon,  6 Jan 2025 10:21:01 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E968007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFdTHAMqTTZ3TKYavt/HtT+yo9U+iL2UNHLgcG/TlQRmOq192GXkMy34YIyfWI004b9aVRZkTpUzsGtOECR7uNi+CnFLyDpZbt5633R3kGxlMIbwQrm5iC+kPK/E7VZaSeYQ9RyUBC7Z0MsbFPFwxuISsz6eTR/F0+IAu8c0oDdsWNXF61/RWSJ4E15bYdcyZcgM7OqpCsHfXg4P2+Hd39eIvQBaYmaGoJX4xQFTyibDUf9NX/b7D6fYUaYDk6u74c/YznSJgj6Gc5Z6BDBHd5O3MWh8wrS9GUnWt7lCLzQrpGiWMBfye1Qnjg7m2E2jc++7aLb33DB2fMviA5bNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF/ataaH5zYp3RurHHm7vrLgX2TW00yy1TjC47Pfwvg=;
 b=nwfp7ZzBNcq+ZpvROKis5Uh3+tErrk9ShtmB8/rlWR8FXrMs4lT+4L8bn6F0AKgKYsSwUhCGTx3AIep7XUJ8n3rlbBjf4CxwaAy8HKZbGSgz5wK2vp6cyu0sZgQfmCgMLv6gYyOoFFABU9mqHTajK9/m2jH+qRw+QVIf+fJWzloMdSmXVTqVk3/oTqIOC5wjXCbWGZCDg+wzPZhIXx1A5tVLPOAub4dR/VOcoSPr40FXNKPAEAQJh7tUCsZixGGl+nVum5Ej79zNZw1LUT3Hi/FTyuecbAKVvgeCFKMNZ/vFO4qZHO8hKravG+abwQcL+H9ktzs3AUSAQn0zTERmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF/ataaH5zYp3RurHHm7vrLgX2TW00yy1TjC47Pfwvg=;
 b=vSqkwzJaythK2hxohNeyCaZNMC+nKFgvUcmTvp0dnxxI4D5/e812C2jiI7wuLhzKyce4Xd564Rgw5OFHkkukbN1usMMnXM7vrQSlLJ66L0g+KzavGJLnI5UkxfBiyNGUZX64siQr2ZcJLhBgnfcPfggOla6aPVfILC9WfjKs4h4=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 09:20:47 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::e7) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.9 via Frontend Transport; Mon, 6
 Jan 2025 09:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 09:20:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 03:20:43 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal: RO multi_boot register in non JTAG bootmode
Date: Mon, 6 Jan 2025 10:20:40 +0100
Message-ID: <484b9cafc45e72308a1a29a3ab772020f96784cc.1736155238.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ygT1HTFzpt4zwboKulylHyqJfwWzWTcNZzPb7R6ZGoA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTqBRk6LIL95hs0Q27f4AjYN+9z89OpAkvjxf59qb//5
 lqCwJH8jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARseMM8xMLTrgKBfLxZZWl
 s05l1+LMy7TwYJjvevx/7GGFK4GzHSp5F63YUrRwlushAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa5957f-3a70-425e-9e78-08dd2e3367bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ehk3ljQBBC2DMdONyiTdkmzIOAF2d/YYGwEmrBWkh/BudwG/KeKOqqgwx+c2?=
 =?us-ascii?Q?0WKS5ch3tNAlmS7CkXYTFe6RtJ2y3g3Vx5hxIP85WWnjd/zX/7shXtJokaGY?=
 =?us-ascii?Q?5KqrmHErk9iWMdpyfxByyJT9PmepZU77aDE5mXRjvDW6HVFdGd7JtfAiyl5j?=
 =?us-ascii?Q?nctBCQFabKFUdQ6Jodfou9cx0LSzoJ7kfnfqQApTcSdJ1sdsgvjs1fXJS+1w?=
 =?us-ascii?Q?//4W64wy4YP00Js8uywuDE2RXSrC3v/7bEoqvB69LcznTQLge72DQxIfmSvW?=
 =?us-ascii?Q?UF1+PwpFg8dbPO0m9jxuJfu5CPUnZchjhquwcrx+OdQxT7gKrzaT6lC+4puH?=
 =?us-ascii?Q?diyPv9jO/CBPffHwjeP5SmRiG1PsBjEsrfiZIEtrVb2b5gL8GBlIHc6lO0YQ?=
 =?us-ascii?Q?av7ih/z5LqFlNf5T7eAoih7fmUrSSPR/O+7ojBezOOgHqDrtSNQ1t43MQy9/?=
 =?us-ascii?Q?h4DvxB3Be4IbhPOBIvNIbmrm+pO42VOwc2JRWl8AUML9GB2S0yMi/VvCLWXv?=
 =?us-ascii?Q?A3J3Y6ekuxGCSi+P/ie8s9z1Yhj4SurtvarSD9Cj03WRHWZHeGE18RKrAAra?=
 =?us-ascii?Q?lCZ7iXexgR3WomWO5mx0LH/yYv15mzxbdJHdQHmOEFmSumV+MJOILaKWAMCc?=
 =?us-ascii?Q?zOvIw3wW527yoRicGdCbRjaHPedJ2nzJhkIhvDgLrt8VF7JtL50m2m5gVwdw?=
 =?us-ascii?Q?8YTAI37niJAfNo/lRlUL2UD6hLXPSYthK8zFIJyEM9j+2XTq0QzvyqnY8+2N?=
 =?us-ascii?Q?yhurXkNOWZVc3SDwRddvo2TFI7Pcqza0kw1cCWCiy8RZCIcsSvn+toKFvA+L?=
 =?us-ascii?Q?xW4Kj2fao3qOne5k1DV/c67HAqAAN2KXR4XFEyIL7EDlL2YCQfIz9pV9pidw?=
 =?us-ascii?Q?8nhFlQhkUdkYDuj6tYRxobsfj5K6YSMoO+NLDwbQKpNG53ky9v29RkBcktF0?=
 =?us-ascii?Q?bWMLpHzHI3zexgnG9h8YzFyikNrLt+i1lg1zwGxb4uXXTjcrW9tpXfkBbG7Q?=
 =?us-ascii?Q?I1giMpGzTMqG7VJysABKoz1nZPpmdb1NfAe+gvs1qKxF2ONvYfKN6NDzv2gQ?=
 =?us-ascii?Q?xiGCh93FDDv4czL3S3BjGEJ0Z0F0mCgci4jJs7ioYMw1mdg/TwuM/3ldAkhI?=
 =?us-ascii?Q?IkgfP4yEWX42iP/d3ukTos6jED9sQivHethhqH13ljP1+PsJowXKhr0qfdkf?=
 =?us-ascii?Q?8F7YGJ9XoP2H2UnstdFFYjFdv4kCG8G5cAQWouyMxQ6MGa4ga+Jb7Nha7Tma?=
 =?us-ascii?Q?4L6wX+tO7hkbM+/MdhsgDo3qkFDY6YsT9ZB84Qj5emp1aoezCOSbxGxBVj4A?=
 =?us-ascii?Q?Dq8S2mHIYxAjdBaKcDblfvFsUNbGo7vRomHcRz+92OdvKQkJqHLM/z0fZwHc?=
 =?us-ascii?Q?gWHbq7FcMUnMog89V0DJph93308eHJq/mrzZwxPBGsBCvqBlHph654T+3FM3?=
 =?us-ascii?Q?4LLwVka66RqyDkgsHh5Xo2zmWM+MrFJxB+BmAu4+NztJ5cmPrZzoqycXvCQY?=
 =?us-ascii?Q?xY9tk/E/F4Kp0GE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 09:20:47.3474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa5957f-3a70-425e-9e78-08dd2e3367bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

The main reason for this change is that upstream QEMU has no multiboot
register implemented that's why access to it fails which ends up in CI
failure for our target.
That's why in JTAG bootmode returns 0 which is correct behaviour because
multiboot register is not used in this mode and value should be ignored and
as a side effect it is also fixing CI/Qemu issue.

Also move versal_get_bootmode() to avoid function declaration.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal/board.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index d05220f96ffd..cff810e02ad8 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -36,8 +36,29 @@ static xilinx_desc versalpl = {
 };
 #endif
 
+static u8 versal_get_bootmode(void)
+{
+	u8 bootmode;
+	u32 reg = 0;
+
+	reg = readl(&crp_base->boot_mode_usr);
+
+	if (reg >> BOOT_MODE_ALT_SHIFT)
+		reg >>= BOOT_MODE_ALT_SHIFT;
+
+	bootmode = reg & BOOT_MODES_MASK;
+
+	return bootmode;
+}
+
 static u32 versal_multi_boot(void)
 {
+	u8 bootmode = versal_get_bootmode();
+
+	/* Mostly workaround for QEMU CI pipeline */
+	if (bootmode == JTAG_MODE)
+		return 0;
+
 	return readl(0xF1110004);
 }
 
@@ -120,21 +141,6 @@ unsigned long do_go_exec(ulong (*entry)(int, char * const []), int argc,
 	return ret;
 }
 
-static u8 versal_get_bootmode(void)
-{
-	u8 bootmode;
-	u32 reg = 0;
-
-	reg = readl(&crp_base->boot_mode_usr);
-
-	if (reg >> BOOT_MODE_ALT_SHIFT)
-		reg >>= BOOT_MODE_ALT_SHIFT;
-
-	bootmode = reg & BOOT_MODES_MASK;
-
-	return bootmode;
-}
-
 static int boot_targets_setup(void)
 {
 	u8 bootmode;
-- 
2.43.0

