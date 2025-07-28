Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CA1C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 07:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF9482F8E;
	Mon, 28 Jul 2025 09:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xfluvr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6D483123; Mon, 28 Jul 2025 09:08:21 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D33182F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Owdjl+Tcz9XUdnxn5vuMThVN1CPJe1K1xLWpNc2JFoa+g2zW3YIhiHMHVHpMJaE7koSq/XSoQHFZXU3ZFKSP11j8E2Tshyzgkhcyc1OSzhUmXwtwsrKnyNb1DjbS1G8mx0rnB3hdom8voC5cySWW56PtfCy3Lkn7jyr7JxY0s368gFoaRZ7t0PbFFqyW5wZfPVzvNBCt7vQBDCjxzz0n6cSWsYXfyGnfZ4Ac1E+8JlI2H/JKUhskupgJhymHNjGrvHemo8OvVToLQofSa4uu1zKHSfpFKBkhm33Y+bayMKcU5DC/RjERPKNDtjHZ0SVZw7s8ebKN+wbZofU53q6Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khv+qZyOo8ethrgEtshySB5vAjfZOn25BVz6cE6pef4=;
 b=AUMvb9CcJsNcq17DcxBRwZOn7a5wiQfLgzea3hDFpIBYSqPA52Nd36fnrLB0HNuPCzaL8+caHy+4k11K46KRFw7jM0cdqbZys3BtPtnvffx2+nmZTYErG9/kkffTxuZsWQjl8XIh2d9zR6BMMV2CXI5iZGsOrSlxboOtvyFuLLGhBsk2O2ctSEkjFxoiQGYQ3YO+a5XrmBubbvOVtEGB9bXvTvsZp/RP/LX6XJxwW4kEzOOPDv2dgoeY2pktqe34EpAifq09UmXBbBXxynkScjpcNV8aqCNdGkn3NHwL/KIAkvow44tAjc8yLBWvIVV+BApuRtNBUNMTH9TXvkxkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khv+qZyOo8ethrgEtshySB5vAjfZOn25BVz6cE6pef4=;
 b=1xfluvr55ti2a7ZapUSFRDodP7BSgC5+ptvOLJ8GBkm7uYvW49T1ofmw90xz1BfN0bCi/3Rdng/LOrF2QeLRkfsK98aCJu32+jN/5HhGAAOl2skK5qE6H2MssJXDg9ECBnmr9imufKt2/mh+hMzNjP3nMIPLgUpSBLIC7/dmp9Q=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.42; Mon, 28 Jul
 2025 07:08:12 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::38) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Mon,
 28 Jul 2025 07:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 07:08:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 02:08:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 02:08:09 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Jul 2025 02:08:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <p.bruenn@beckhoff.com>
CC: Alexander Graf <agraf@csgraf.de>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Muhammad Hazim Izzat Zamri
 <muhammad.hazim.izzat.zamri@altera.com>, Pieter Van Trappen
 <pieter.van.trappen@cern.ch>, Simon Glass <sjg@chromium.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] fpga: Remove ancient ACEX1K support
Date: Mon, 28 Jul 2025 09:07:53 +0200
Message-ID: <20fe425910b6266a2bf0555bda67f60c1dd3aa61.1753686468.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753686468.git.michal.simek@amd.com>
References: <cover.1753686468.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11529; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=bCQpYakEWQaIjvomO1u28JQ+hxfTIn2uzeER8rHMjo8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWS0K57XC7i68rxH7w/30tOHZzvdO3cqKnvdHJ65gfM91
 +Sr+eZ4dZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEdh5j+Kce0qT49cLUW5fi
 TlX+u63Kdi77fUhQgXWQuoTv5D0/5MMZ/lkEnAu8zjQtp1Bl6/rTha6/5kvcSX+qr3RxVbGQl5n
 1dAYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c0a867-792d-4634-f95b-08ddcda583dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EgmIGE76f2WzWCz58wW7sfSbI0szfPG6ClQa9f4Ju3wjUxecpDYOzFP6gHcJ?=
 =?us-ascii?Q?eKxpdxGRCjg7NH/O3R5xc55QVa2rCAkNU3dfe1k5VcIMRzQWTHiVMSCN7XsK?=
 =?us-ascii?Q?7YtYoBayVn6bTPvD5G2Z/yDFMg+8ZOuERV4kac/YJas/9ATRYhNGSberLtnV?=
 =?us-ascii?Q?7run18iPCqTgu5x3m6PkQdPAnKTwwQpB8FgzMq8YBmO11aWj5xTEQeHB3foy?=
 =?us-ascii?Q?lEprzKDWvwP1T9kX6nxoS8DB6RKds9mZV32/GDj6vHJ9cu8K8T/oLEskKvcy?=
 =?us-ascii?Q?oPalM/yMPRlaUDwaxDdn2PMp1ax1HXidG3NqrdEKobfYaDXZiD+90iOjteTy?=
 =?us-ascii?Q?rH0Ckngk4PKEjaikueW0yvCaxmMvEyVB38XpGECnpq4/K10xTkQonDOY5qti?=
 =?us-ascii?Q?6YLgnZtVcJgp3Yrh6X71X+95G9Fhj9ButdaDeVS7E8tpS57Xw6NaW4I1yk9c?=
 =?us-ascii?Q?EvLcRxBQyYZVZbnWtjsTLQtqRtGrlF0dErJWdg+Dx1M4YzU7BrUyICKY1w/F?=
 =?us-ascii?Q?eoQFWZiZYFAetQS6uNsiXNZ3q0TlYedaXeiGPOpft3CQABtw62IIctA7mY7o?=
 =?us-ascii?Q?9XAtlWbWxvim3VX8K8HxQSyVV1rSKuZvXot/PPNr32QBwjhT2tALpIxIF7G3?=
 =?us-ascii?Q?y+ASXl58x8wRYcHQgc+S9TUNG6kSlFOPjWCyjW/yG16WCCeNkLGV8cpVVHYJ?=
 =?us-ascii?Q?vUzvC74MdOxeI2k/CcgY4ozrdIBYRnWlYJp3QAwaZGvRzKYwcU7seMbXSk63?=
 =?us-ascii?Q?nGbV2N7cNdD9+E1OVCdhEaBfUFlDYX95nJLNCE0rYu6e1USkVGdbKLA5FUDF?=
 =?us-ascii?Q?SIGaoGTFr1QhP8pAXAWcqM8eABKvoeIiH+4OhZ2v78AXylcRv7/LKibxU9IS?=
 =?us-ascii?Q?QEwWcHfgVtR5U3rlgNYyPRa2UAEYHTrXIBoZK1ntM92NEnbHibJpqBvXKkqG?=
 =?us-ascii?Q?wCN/l+Qcc8d4eOErB6fyN+PMPM414/oOcNb3OewHqwNpvuwSi4FuGTSTdYQT?=
 =?us-ascii?Q?AGZg6EkILR4Y3GfixvmiQPDaB3XoRdjYchCFFsqA63yQowvP8H/bFuBY+FKA?=
 =?us-ascii?Q?cAhg1kik5gWey/4fE+cgdIo+EMOV9W75RRbdsfSHL7yzav457sf2k7VdaF2b?=
 =?us-ascii?Q?mAsWT5fYpFeZwXAYt/rsgQoTJVOKZFkacivpaKzQ4VfUrAFLY48sOUHve7as?=
 =?us-ascii?Q?CBRuzsUlx55+ZWoswkiz16/oX+0MYS4VrUJF2n/Rnn6f4tQgPNrjIGA3DktV?=
 =?us-ascii?Q?02oSGHPWVjz/wZGxpXsJMnMSi8vopPGlEsI3pFQn5xTJA2JKeA5MBfr0BiSG?=
 =?us-ascii?Q?jjjEvlepunnL5zXCoA1HEe5O6BOI0yFvl+1B7tcFBqSu71ds/0i/3SDM+7Yt?=
 =?us-ascii?Q?HAxd855EdgqvAp6LJr15HSvQIEsJ+7WisHPwZh99trNCXiqYeKi+e2TDkVRD?=
 =?us-ascii?Q?/irlFo2YeEwgdzDCHqE6x++3sGC3id6n0hozrIuBAUclQwIrujKCc+dGhd60?=
 =?us-ascii?Q?oUYBmcaBFQ+v1NC/2Vawrlfdl2xBWQuR/n2T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:08:12.0789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c0a867-792d-4634-f95b-08ddcda583dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8
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

Changes in v2:
- Get EP2/EP3/EP4 sizes back even they are not used by any code today

 configs/sandbox_defconfig |   1 -
 drivers/fpga/ACEX1K.c     | 245 --------------------------------------
 drivers/fpga/Kconfig      |   6 -
 drivers/fpga/Makefile     |   1 -
 drivers/fpga/altera.c     |   5 +-
 include/ACEX1K.h          |  32 -----
 6 files changed, 1 insertion(+), 289 deletions(-)
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
index 7c5253c66cca..4d24545df2cb 100644
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
@@ -45,16 +29,6 @@ typedef struct {
 
 /* Device Image Sizes
  *********************************************************************/
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
 #define Altera_EP2C8_SIZE	247942
 #define Altera_EP2C20_SIZE	586562
 #define Altera_EP2C35_SIZE	883905
@@ -70,10 +44,4 @@ typedef struct {
 #define ALTERA_EP4CE75_SIZE	2495719		/* 19965752 Bits */
 #define ALTERA_EP4CE115_SIZE	3571462		/* 28571696 Bits */
 
-/* Descriptor Macros
- *********************************************************************/
-/* ACEX1K devices */
-#define Altera_EP1K100_DESC(iface, fn_table, cookie) \
-{ Altera_ACEX1K, iface, Altera_EP1K100_SIZE, fn_table, cookie }
-
 #endif /* _ACEX1K_H_ */
-- 
2.43.0

