Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EA0C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 11:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA0883942;
	Fri, 25 Jul 2025 13:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rtJ+pDw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6644483942; Fri, 25 Jul 2025 13:26:21 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEB38393E
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 13:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvcHH9eln7G7cV2APlAYMP1BjmAGezjONuNR1lpTWrUtM68JskL//fKTt7SENJpAN8rHKRLRX4yrb6gPO2aulgAoX08cQ69ZNVRQ3m0K3bM47Bz9A3KFtm0b99qgr2JymKxO8YMlTGHmOxrRk2WLTRS+Hnopcw53p5vvqNQ72zHix5AfeWW4W+HBxhvsutRQL0R2LURwTSa3YpbrzI8fhHmvflGM2w2tLV0sy3or7s3/hqxHavaYRpN4HPslKCzTgrjyVFVZ3N6+xk3wpRIofPnPuR1ZSDqJbSUjpBMH6Qvtt7wgMc/IwDcF+Z6f/NPvZ0DQhpGyZtjCbluwRUJasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcF0SbKqeJSTrtPZ5BDWz6preNTBSa0+som9R5Y3ZQQ=;
 b=QbikncdxfkTdrhzrpQDmHGWpWF50dQOw3r4khYmv0iNwyqEkpm3yJPE8PJ2x2WqUluC4RhyqXMbAReJPPxObHeKNwL4o1oAWkALI4/+DPAlp2M4p8bYlKnsEz2IYCM3UzxZQKIMleXAc5SWHgFgIas2Fk5x2qRZrRhTcY2wqn0mOKRJp8HZfC8MngEaJnVf2mTZXbh+9gBhy8htSID/ZLvRzu1uVTEAcIkrU+/Z9EV2j7sS+0AxiF26/yKR12KYQfoXE9/U2efqckfY3YMhL5DoErwMrC7BEvXX66L4dXrWZNroCu5Qc3UJihmE9lOKwTp//JPDjjdZL+cRRcnDfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcF0SbKqeJSTrtPZ5BDWz6preNTBSa0+som9R5Y3ZQQ=;
 b=rtJ+pDw+Uztv3tv38B598OuDmhQwXajPjaddFtkNBsubBZq7u8OK8R2gjNmMfchhR6QKzYM6MAtouOtFMXXZ1xSRYEsSkHYK0bxBghYvn6eXIwfFEcsZQ9m8gxKsZiARAW6jNRCQ8DNbSdKv7TxD2aTRCoNWyiHEQJCNwkE39+8=
Received: from BYAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:c0::27)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 25 Jul
 2025 11:26:13 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::79) by BYAPR05CA0014.outlook.office365.com
 (2603:10b6:a03:c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.8 via Frontend Transport; Fri,
 25 Jul 2025 11:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:26:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:26:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:26:10 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 06:26:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <p.bruenn@beckhoff.com>
CC: Alexander Graf <agraf@csgraf.de>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Muhammad Hazim Izzat Zamri
 <muhammad.hazim.izzat.zamri@altera.com>, Pieter Van Trappen
 <pieter.van.trappen@cern.ch>, Simon Glass <sjg@chromium.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] fpga: Remove ancient ACEX1K support
Date: Fri, 25 Jul 2025 13:25:53 +0200
Message-ID: <36c875d63ce340a56b71873460d56bb54675b42e.1753442748.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753442748.git.michal.simek@amd.com>
References: <cover.1753442748.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11933; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=jf14XNy2fw87qqj+WWuTBy9Pa2a7vXo+AQ6Pgp54S2o=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0Z564yXRsSVjcu0s2fZs73m+5bzePce/kW0YH7E+4b
 eP+JnZPt6OUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAmkivHyHDp3GOVLh7pVDMz
 Yw9b/frLAXFRBvybYpqy5h01z5d+7cfwP/pCzBbb8K/bE+8X2+9LepYbn/CR6fO8Q6VlBdu0JKT
 +MQEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 73770bfe-ef67-4131-eac5-08ddcb6e0fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WR8YvVWiqATaPVwm17vJ255Efoyy4aoI+YQgkCerdzibJ0TiqVvF1c2Vtc+E?=
 =?us-ascii?Q?TM207NUrYLQBD9jJSnZy7T/0wt70l0NZlUclIwp2g41eHlHwnyzCuoHkfs1Z?=
 =?us-ascii?Q?M7vrdNqhpsInD7EYnNHA/Ojc1rE4ZFb0BgJgxFS9s8SoiSkItALKaRJgaoxs?=
 =?us-ascii?Q?tIyJcKBkWtghCbQqwbW0EV7rHkxWiDGubTnxOZpVesY6D153RBE5FP4bDVYM?=
 =?us-ascii?Q?fsEPWeZCyqOUqrF80kPxut7vFo/xuAEmi73epJsXLhVsKvYERrLYfaDwa5eE?=
 =?us-ascii?Q?CCbJPMcQYSV9vxRTqzdLncMKHmGZ0tjXMP0gsS+RvVXrBRhTJgVCp9lW6cyK?=
 =?us-ascii?Q?Chijw1Q1x/p2+0CAmgr6WDfudpm5qPup1c1s6WDiWKrCLShjZSUHcH36I75F?=
 =?us-ascii?Q?/rrKxiW/Hue6yHR3gU98kI7f485hWW2akyXU3wg/mBoFuX52tRqaNEA0O6KR?=
 =?us-ascii?Q?iIMTKl/VjLhcdT3sIeY+21uz6WDS5DyoyOVxwGKbJsg/Iqkbs1UvGHqjyI8q?=
 =?us-ascii?Q?VlEif+KVf4nOyaH+qIvlifrV+eWRDoYJGRjaCILBrVRQzQ23vcExzJvdZToH?=
 =?us-ascii?Q?MUCQ3Z1kIGeetCuVKCsW6n8eD7oP27CbLotp3aBUONOcJ22/sNrlr5oi30fF?=
 =?us-ascii?Q?dve4Bs9I14QYvPf9uorFwJLBIhg+5C4dKgRQXdSEQvdwK/7ISmi9WVX0IpHP?=
 =?us-ascii?Q?xy4Ye43jPG/HEW+sudoFfaZwb4dOfHun8YCDOzd1I9B7eTDMRmudCP+74/TL?=
 =?us-ascii?Q?gv/+vrQ6nqej2bjMIIjRd319BRbWA+JIt7ZrqBdAzPR/obNbiq+raf7LnKpz?=
 =?us-ascii?Q?Whp4QY1zZIi2ZUhJVOG2qylYIHEQGXf2KA0xXOuWaVGtXky63/G0QGNrH1Pw?=
 =?us-ascii?Q?TZgYeBMWKetQrIaPh5ie38yKg8c7X/eQwExTvtCeTA/VE7EYOGFb0shb+EaD?=
 =?us-ascii?Q?sS0je4UWq4JKpxzXzGrW1EVecWDk16LE/iglvrXC2EZtPbZO2NveYzQRj6Gr?=
 =?us-ascii?Q?eTkpQO477QaGsVIXO5071aKAwRK5Ebp5OO0OqJoSFuTNIgz1T7ZmzL5UtVGr?=
 =?us-ascii?Q?2tU4vjnHjNY4/1x8k1VEEYN1rsPJGHudnyAD/kqprlkbNvmaSQr9AxXu2yhG?=
 =?us-ascii?Q?5ZOna8qiXGsdMSiOUYlKSPFoEIcWVx7+EcmBmLPSiguk51MrvWdsA4ovuzap?=
 =?us-ascii?Q?cx8CdkK+hB57qLt4SU5iymBDqU/lsgNSHjVHGdOuc/1yEOSOeJWx9BuK5bip?=
 =?us-ascii?Q?2AeVI8Q2bDMDJOrZUAjLoU/THE2LNKhmE8DFRwk1je/JmmlHRSJA+VKxoRER?=
 =?us-ascii?Q?Vt8OCjPzEYD8xXoQiH1P+5/JkDT3JW+gt3vRJbiDfQ+njhSO9/oKw4Ugijoy?=
 =?us-ascii?Q?DrEtS6cT0609Hq1+E9BbD1roGMbSxmZjeRS1TfB46Bv5JC8ThJOfu5rohnX+?=
 =?us-ascii?Q?lP06DRXtEZRU7a+EqDk8Qx2TvR0mdk3cHGIpKMWzvb4TCpReKyLsKxv7uQ4s?=
 =?us-ascii?Q?K7DRN9x8XidZx8WNbQSUONG3VvkAGDQluRrS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:26:12.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73770bfe-ef67-4131-eac5-08ddcb6e0fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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

Coverity (CID 583149) reports issue on code which is not enabled by any
real platform that's why remove it completely.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/sandbox_defconfig |   1 -
 drivers/fpga/ACEX1K.c     | 245 --------------------------------------
 drivers/fpga/Kconfig      |   6 -
 drivers/fpga/Makefile     |   1 -
 drivers/fpga/altera.c     |   5 +-
 include/ACEX1K.h          |  49 --------
 6 files changed, 1 insertion(+), 306 deletions(-)
 delete mode 100644 drivers/fpga/ACEX1K.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 0c030f4a7925..96546cc0bcfe 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -206,7 +206,6 @@ CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_ALTERA=y
 CONFIG_FPGA_STRATIX_II=y
 CONFIG_FPGA_STRATIX_V=y
-CONFIG_FPGA_ACEX1K=y
 CONFIG_FPGA_CYCLON2=y
 CONFIG_FPGA_LATTICE=y
 CONFIG_FPGA_XILINX=y
diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
deleted file mode 100644
index e1514fc56d04..000000000000
--- a/drivers/fpga/ACEX1K.c
+++ /dev/null
@@ -1,245 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2003
- * Steven Scholz, imc Measurement & Control, steven.scholz@imc-berlin.de
- *
- * (C) Copyright 2002
- * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
- */
-
-#define LOG_CATEGORY UCLASS_FPGA
-
-#include <config.h>		/* core U-Boot definitions */
-#include <console.h>
-#include <log.h>
-#include <ACEX1K.h>		/* ACEX device family */
-#include <linux/delay.h>
-#include <time.h>
-
-/* Note: The assumption is that we cannot possibly run fast enough to
- * overrun the device (the Slave Parallel mode can free run at 50MHz).
- * If there is a need to operate slower, define CFG_FPGA_DELAY in
- * the board config file to slow things down.
- */
-#ifndef CFG_FPGA_DELAY
-#define CFG_FPGA_DELAY()
-#endif
-
-#ifndef CFG_SYS_FPGA_WAIT
-#define CFG_SYS_FPGA_WAIT CONFIG_SYS_HZ/10		/* 100 ms */
-#endif
-
-static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize);
-static int ACEX1K_ps_dump(Altera_desc *desc, const void *buf, size_t bsize);
-/* static int ACEX1K_ps_info(Altera_desc *desc); */
-
-/* ------------------------------------------------------------------------- */
-/* ACEX1K Generic Implementation */
-int ACEX1K_load(Altera_desc *desc, const void *buf, size_t bsize)
-{
-	int ret_val = FPGA_FAIL;
-
-	switch (desc->iface) {
-	case passive_serial:
-		log_debug("Launching Passive Serial Loader\n");
-		ret_val = ACEX1K_ps_load (desc, buf, bsize);
-		break;
-
-		/* Add new interface types here */
-
-	default:
-		printf ("%s: Unsupported interface type, %d\n",
-				__FUNCTION__, desc->iface);
-	}
-
-	return ret_val;
-}
-
-int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize)
-{
-	int ret_val = FPGA_FAIL;
-
-	switch (desc->iface) {
-	case passive_serial:
-		log_debug("Launching Passive Serial Dump\n");
-		ret_val = ACEX1K_ps_dump (desc, buf, bsize);
-		break;
-
-		/* Add new interface types here */
-
-	default:
-		printf ("%s: Unsupported interface type, %d\n",
-				__FUNCTION__, desc->iface);
-	}
-
-	return ret_val;
-}
-
-int ACEX1K_info( Altera_desc *desc )
-{
-	return FPGA_SUCCESS;
-}
-
-/* ------------------------------------------------------------------------- */
-/* ACEX1K Passive Serial Generic Implementation                                  */
-
-static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize)
-{
-	int ret_val = FPGA_FAIL;	/* assume the worst */
-	Altera_ACEX1K_Passive_Serial_fns *fn = desc->iface_fns;
-	int i;
-
-	log_debug("start with interface functions @ 0x%p\n", fn);
-
-	if (fn) {
-		size_t bytecount = 0;
-		unsigned char *data = (unsigned char *) buf;
-		int cookie = desc->cookie;	/* make a local copy */
-		unsigned long ts;		/* timestamp */
-
-		log_debug("Function Table:\n"
-			  "ptr:\t0x%p\n"
-			  "struct: 0x%p\n"
-			  "config:\t0x%p\n"
-			  "status:\t0x%p\n"
-			  "clk:\t0x%p\n"
-			  "data:\t0x%p\n"
-			  "done:\t0x%p\n\n",
-			  &fn, fn, fn->config, fn->status,
-			  fn->clk, fn->data, fn->done);
-#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
-		printf ("Loading FPGA Device %d...", cookie);
-#endif
-
-		/*
-		 * Run the pre configuration function if there is one.
-		 */
-		if (*fn->pre) {
-			(*fn->pre) (cookie);
-		}
-
-		/* Establish the initial state */
-		(*fn->config) (true, true, cookie);	/* Assert nCONFIG */
-
-		udelay(2);		/* T_cfg > 2us	*/
-
-		/* nSTATUS should be asserted now */
-		(*fn->done) (cookie);
-		if ( !(*fn->status) (cookie) ) {
-			puts ("** nSTATUS is not asserted.\n");
-			(*fn->abort) (cookie);
-			return FPGA_FAIL;
-		}
-
-		(*fn->config) (false, true, cookie);	/* Deassert nCONFIG */
-		udelay(2);		/* T_cf2st1 < 4us	*/
-
-		/* Wait for nSTATUS to be released (i.e. deasserted) */
-		ts = get_timer (0);		/* get current time */
-		do {
-			CFG_FPGA_DELAY ();
-			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
-				puts ("** Timeout waiting for STATUS to go high.\n");
-				(*fn->abort) (cookie);
-				return FPGA_FAIL;
-			}
-			(*fn->done) (cookie);
-		} while ((*fn->status) (cookie));
-
-		/* Get ready for the burn */
-		CFG_FPGA_DELAY ();
-
-		/* Load the data */
-		while (bytecount < bsize) {
-			unsigned char val=0;
-#ifdef CONFIG_SYS_FPGA_CHECK_CTRLC
-			if (ctrlc ()) {
-				(*fn->abort) (cookie);
-				return FPGA_FAIL;
-			}
-#endif
-			/* Altera detects an error if INIT goes low (active)
-			   while DONE is low (inactive) */
-#if 0 /* not yet implemented */
-			if ((*fn->done) (cookie) == 0 && (*fn->init) (cookie)) {
-				puts ("** CRC error during FPGA load.\n");
-				(*fn->abort) (cookie);
-				return (FPGA_FAIL);
-			}
-#endif
-			val = data [bytecount ++ ];
-			i = 8;
-			do {
-				/* Deassert the clock */
-				(*fn->clk) (false, true, cookie);
-				CFG_FPGA_DELAY ();
-				/* Write data */
-				(*fn->data) ((val & 0x01), true, cookie);
-				CFG_FPGA_DELAY ();
-				/* Assert the clock */
-				(*fn->clk) (true, true, cookie);
-				CFG_FPGA_DELAY ();
-				val >>= 1;
-				i --;
-			} while (i > 0);
-
-#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
-			if (bytecount % (bsize / 40) == 0)
-				putc ('.');		/* let them know we are alive */
-#endif
-		}
-
-		CFG_FPGA_DELAY ();
-
-#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
-		putc (' ');			/* terminate the dotted line */
-#endif
-
-	/*
-	 * Checking FPGA's CONF_DONE signal - correctly booted ?
-	 */
-
-	if ( ! (*fn->done) (cookie) ) {
-		puts ("** Booting failed! CONF_DONE is still deasserted.\n");
-		(*fn->abort) (cookie);
-		return (FPGA_FAIL);
-	}
-
-	/*
-	 * "DCLK must be clocked an additional 10 times fpr ACEX 1K..."
-	 */
-
-	for (i = 0; i < 12; i++) {
-		CFG_FPGA_DELAY ();
-		(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
-		CFG_FPGA_DELAY ();
-		(*fn->clk) (false, true, cookie);	/* Deassert the clock pin */
-	}
-
-	ret_val = FPGA_SUCCESS;
-
-#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
-		if (ret_val == FPGA_SUCCESS) {
-			puts ("Done.\n");
-		}
-		else {
-			puts ("Fail.\n");
-		}
-#endif
-	(*fn->post) (cookie);
-
-	} else {
-		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
-	}
-
-	return ret_val;
-}
-
-static int ACEX1K_ps_dump(Altera_desc *desc, const void *buf, size_t bsize)
-{
-	/* Readback is only available through the Slave Parallel and         */
-	/* boundary-scan interfaces.                                         */
-	printf ("%s: Passive Serial Dumping is unavailable\n",
-			__FUNCTION__);
-	return FPGA_FAIL;
-}
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 9456ca3149ae..18e7d7c99a9a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -34,12 +34,6 @@ config FPGA_STRATIX_V
 	help
 	  Say Y here to enable the Altera Stratix V FPGA specific driver.
 
-config FPGA_ACEX1K
-	bool "Enable Altera ACEX 1K driver"
-	depends on FPGA_ALTERA
-	help
-	  Say Y here to enable the Altera ACEX 1K FPGA specific driver.
-
 config FPGA_CYCLON2
 	bool "Enable Altera FPGA driver for Cyclone II"
 	depends on FPGA_ALTERA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 610c168fc35c..6c779d5b5df6 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_FPGA_XILINX) += xilinx.o
 obj-$(CONFIG_FPGA_LATTICE) += ivm_core.o lattice.o
 ifdef CONFIG_FPGA_ALTERA
 obj-y += altera.o
-obj-$(CONFIG_FPGA_ACEX1K) += ACEX1K.o
 obj-$(CONFIG_FPGA_CYCLON2) += cyclon2.o
 obj-$(CONFIG_FPGA_INTEL_SDM_MAILBOX) += intel_sdm_mb.o
 obj-$(CONFIG_FPGA_STRATIX_II) += stratixII.o
diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 64fda3a307c7..4a9aa74357ec 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -28,10 +28,7 @@ static const struct altera_fpga {
 	int			(*dump)(Altera_desc *, const void *, size_t);
 	int			(*info)(Altera_desc *);
 } altera_fpga[] = {
-#if defined(CONFIG_FPGA_ACEX1K)
-	{ Altera_ACEX1K, "ACEX1K", ACEX1K_load, ACEX1K_dump, ACEX1K_info },
-	{ Altera_CYC2,   "ACEX1K", ACEX1K_load, ACEX1K_dump, ACEX1K_info },
-#elif defined(CONFIG_FPGA_CYCLON2)
+#if defined(CONFIG_FPGA_CYCLON2)
 	{ Altera_ACEX1K, "CycloneII", CYC2_load, CYC2_dump, CYC2_info },
 	{ Altera_CYC2,   "CycloneII", CYC2_load, CYC2_dump, CYC2_info },
 #endif
diff --git a/include/ACEX1K.h b/include/ACEX1K.h
index 7c5253c66cca..44d1b9765657 100644
--- a/include/ACEX1K.h
+++ b/include/ACEX1K.h
@@ -12,26 +12,10 @@
 
 #include <altera.h>
 
-extern int ACEX1K_load(Altera_desc *desc, const void *image, size_t size);
-extern int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize);
-extern int ACEX1K_info(Altera_desc *desc);
-
 extern int CYC2_load(Altera_desc *desc, const void *image, size_t size);
 extern int CYC2_dump(Altera_desc *desc, const void *buf, size_t bsize);
 extern int CYC2_info(Altera_desc *desc);
 
-/* Slave Serial Implementation function table */
-typedef struct {
-	Altera_pre_fn		pre;
-	Altera_config_fn	config;
-	Altera_clk_fn		clk;
-	Altera_status_fn	status;
-	Altera_done_fn		done;
-	Altera_data_fn		data;
-	Altera_abort_fn		abort;
-	Altera_post_fn		post;
-} Altera_ACEX1K_Passive_Serial_fns;
-
 /* Slave Serial Implementation function table */
 typedef struct {
 	Altera_pre_fn		pre;
@@ -43,37 +27,4 @@ typedef struct {
 	Altera_post_fn		post;
 } Altera_CYC2_Passive_Serial_fns;
 
-/* Device Image Sizes
- *********************************************************************/
-/* ACEX1K */
-/* FIXME: Which size do we mean?
- * Datasheet says 1337000/8=167125Bytes,
- * Filesize of an *.rbf file is 166965 Bytes
- */
-#if 0
-#define Altera_EP1K100_SIZE	1337000/8	/* 167125 Bytes */
-#endif
-#define Altera_EP1K100_SIZE	(166965*8)
-
-#define Altera_EP2C8_SIZE	247942
-#define Altera_EP2C20_SIZE	586562
-#define Altera_EP2C35_SIZE	883905
-#define Altera_EP3C5_SIZE	368011		/* .rbf size in bytes */
-
-#define ALTERA_EP4CE6_SIZE	368011		/* 2944088 Bits */
-#define ALTERA_EP4CE10_SIZE	368011		/* 2944088 Bits */
-#define ALTERA_EP4CE15_SIZE	510856		/* 4086848 Bits */
-#define ALTERA_EP4CE22_SIZE	718569		/* 5748552 Bits */
-#define ALTERA_EP4CE30_SIZE	1191788		/* 9534304 Bits */
-#define ALTERA_EP4CE40_SIZE	1191788		/* 9534304 Bits */
-#define ALTERA_EP4CE55_SIZE	1861195		/* 14889560 Bits */
-#define ALTERA_EP4CE75_SIZE	2495719		/* 19965752 Bits */
-#define ALTERA_EP4CE115_SIZE	3571462		/* 28571696 Bits */
-
-/* Descriptor Macros
- *********************************************************************/
-/* ACEX1K devices */
-#define Altera_EP1K100_DESC(iface, fn_table, cookie) \
-{ Altera_ACEX1K, iface, Altera_EP1K100_SIZE, fn_table, cookie }
-
 #endif /* _ACEX1K_H_ */
-- 
2.43.0

