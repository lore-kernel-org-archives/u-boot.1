Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5A1C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3D481DCA;
	Tue, 25 Mar 2025 15:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DE6gRAVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 951C080F70; Tue, 25 Mar 2025 09:28:29 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A56A808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 09:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZufibf6VgT5IHYcndYHgfkNqDS8aq7IHN5KnVvE+6s6Detp01fOLm9QPsYZoianenCsiAvjLtLI2OmJqVRqs1a82Ec95yY9RQia59T6AxC6JemOmSYficpn4yXPLP/ZfaA/8dEjYB7fmjJcdD1hcYvWdcJ4FOO0CSZjV7/q8wmcgRY3rvTvkkUr4D/btnaF16E+jGj/eGnA0raHKDmFhy2tBwUBSpUw5wh8EFJR8rBjX425bxGMPZTCzM2clJBWdx3M1eLJ7smY3LrthRaB774VSzaQDgNyB2drqghy9IYfuji4S7e8e8hkaHvihQhY3bx3UVwUD6vTmMsiyebJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBP71YlP6dAvrZi6vn0A8C8OD33E0++5/1lTyXy6nPY=;
 b=DG/dIkqx3CR2dFoXXHJjmYd4mZu6kmQekjzYisvq1DImkRx+tBM3ZxVRmqIoB7wkCK3/xiADXejMYPiUaHb1aP5OImnUU6XeWfV+TdyDnGYm3OvKJ52ViosxWXVCcreQELrgeBlq15ZbkQ5TA9cWznYeXNaa0L0mLrC6gEw49Gi7HLFL4r7PaMGC8z0dRRECRJlMXjwJq7WU8f7rGJwbV5woMqPooPgaL6ZUZyd/CjJDSm7ya6oFVEls25u+TSB1TorOq6U+GBOPiFGr3tsckaIxC8EkcEgU8Wq1Btbfu+8gwBA78uGZ5F43RBjGB7k/26La5ryODXMa3l+lDG5htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBP71YlP6dAvrZi6vn0A8C8OD33E0++5/1lTyXy6nPY=;
 b=DE6gRAVOZNM50fpUjaOeFqZqweW7piDQvfhjfV3wDanwec45dT4RNVJ48vPi5Po3mscssJyWtFADSu84q3RUv/jqVEs4+6WJvg1mq3TNq44FYN6hjZ2Tjyw1YNfPqZsHgTSkmxGIOpqGi8w2otqEGO4ExwqhpBXy/uszn9GXyEhF+edi5+y/ePuTA8QArKYdyC4uNlFe3RcF44rXEzxk/eHqy7N8k3/XtDM9P4j1cKGA/g85WPFRh1pBhAvjLwd99gUZKpSZfY5riFxuR2Hg60VH8tuPqjQCW+LSebFIR5dm/1e4zi5LQj/l9jBsf4R77GqkKlQovn9HnBGRki0nMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AS5PR04MB9771.eurprd04.prod.outlook.com (2603:10a6:20b:650::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:28:25 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:28:25 +0000
From: ziniu.wang_1@nxp.com
To: peng.fan@nxp.com,
	jh80.chung@samsung.com,
	trini@konsulko.com
Cc: pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 tharvey@gateworks.com, jonas@kwiboo.se, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron eMMC BOOT/RPMB
 hardware partition resizing
Date: Tue, 25 Mar 2025 16:29:14 +0800
Message-Id: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AS5PR04MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 6974f019-f8ca-4cf1-0158-08dd6b7702b1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XAvGkFWfCspO+WVVU5dt1Hm9roZDDMqLL1D46KOEf4ETzD+YLM+efV6LjWxX?=
 =?us-ascii?Q?S8sR6Jv/oWyZNXmFf6LwwD+OjqY5SHn7+OMcOBXuE2TSTd34TL1wcGthWaq9?=
 =?us-ascii?Q?C8Mogtoclq+pVGmmnElAFKC/69Sr9d6BtLJvIKorNDti2lVFIpB3zuqVq20Y?=
 =?us-ascii?Q?/oQKU32WsnVxBVmgTBvXMftwv8QG0ok7RElm36Cn1NvOZHFTcl9N1jx87M9F?=
 =?us-ascii?Q?Swm7trxvIcJJ1tAUWT2bRKL/BtRuSUnmaA7Yt3W3HYWJE1EKg2iUamVlbUJY?=
 =?us-ascii?Q?DGgLcyHp2Vp1w7+7JO9RWWca0b42ULg+quOA0lwRjS5CxSplZhQhiJgcUOy6?=
 =?us-ascii?Q?Mqtv+JtIgSdfwBlKeHUORJbJqjDrXChujM4mjfejAzImOjsPTYDmcFd12ao6?=
 =?us-ascii?Q?D6Dd4XPWRxoYrbD6w/pIhbYZHEuRA7r7qwiE9Yo5l3KahggwaOfg4d+VPcjX?=
 =?us-ascii?Q?LoKZLQ9fc9OzmyIMVnSEvODTgFZ1b5ypXx7p0XaZKkPaIP9nB94wRH9LzstU?=
 =?us-ascii?Q?S4P5IznL5CD02ddUwkZVeUgubb/Y1k3WNaKK5m73srN/Y+4hBUeDy9Yz5oGd?=
 =?us-ascii?Q?gYkD7/56Mf/pcpcGr8DEOM/tBJp4D8CxXhlCpb2rSgYO1rap37oTQD6iPZH+?=
 =?us-ascii?Q?agZEz1Ip0X23BcXURTSRb+BBG1rbm0Yw8FB2cFFh1j8wg+xSlIQe/tXjTHao?=
 =?us-ascii?Q?r0HarpevYmGQ+iSUjwT17ta1WRs0AB8RJ6+66CffYWIkfNFjo8bLixxBMaAe?=
 =?us-ascii?Q?FVqEA+ipJQgkF5H7oUBKR9aGAMU+9S1efIK9IK515Hr6rsDnAdTIHlkU+O3C?=
 =?us-ascii?Q?KNQ/fM0+2Q8ijZcS7kT+XXUx9FaTaTIEwbpAfDCUE2xKilFKNLGaOuIfmJkA?=
 =?us-ascii?Q?upgtBvE/IBQb1E1hNTMCHejb8HH6jAGl7diWsfUmqPiqv1VuOCAOs615yL5K?=
 =?us-ascii?Q?3ySej/u3mEYRLpYdaAC1sb+VzoVj7zcVmayV3EvX+Jw29zhtb9N+Cb3Uey+T?=
 =?us-ascii?Q?MZYmVTkglXp/pNZ4H8lMRMI3HDD46Ev6sflclk2OJElmaTDyuDfBuaIfcbCv?=
 =?us-ascii?Q?klifYY4abKfTr60YuprjCliEpKm9DJFMvoEdz2VEMYfPdQ8soqjhiVSrhiBi?=
 =?us-ascii?Q?+lBUpl4mXCj99dS5RWoHO2HA1AnfOCUtAP9MR3PcfTwAqGrNl8l0rgT1NV+c?=
 =?us-ascii?Q?VOpXTzU+Cg7Q3Q2Sa3l/uxTiHusmHl/5IMnnR9tKp/aWlQYO9N/ebeEWd0B2?=
 =?us-ascii?Q?vqO1tC/Eod+KI8gjoXFmMsszNCICNT/bwHDuLmaKAcIrFYELQWuJ6a2awAIR?=
 =?us-ascii?Q?tcBZZ7+4TIz/FYSM1MbTbWPKJ1T49Bd/icRe2zW8l4FDc3Cbqt0gAgIn7m2+?=
 =?us-ascii?Q?7acVz+QQIAD3hnNZ3l7jeOvunImj7Jomn6R1MbyZxpx1RfUF9KXMxuxpxJDo?=
 =?us-ascii?Q?+5zpPgoeT4ns0hZXMr+TXT/2Q/Jc8bop?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dGTXbWtRF0X71C7HOPqavstt5Kv61c7VXBdG088UlMcRYuctWF7I6/AdKOIS?=
 =?us-ascii?Q?cgaxkPcfqFCClyJi1bi3X3t9fYQlHocbjp29SKlVsiVTkEIZvPkkUiqcIEYB?=
 =?us-ascii?Q?ae3E7Z5LQoQHaxD0NCxQ06Sj38x3wtpjkv0trTCD1t0gt3IlC1KD0zU1biUf?=
 =?us-ascii?Q?hzO3BUxDAlFB6dsyPCIaw/KpmQaRg38urM5RiZRdIATGGW3MZAxPP0IvQHQL?=
 =?us-ascii?Q?EjWRajZe2oRj+fXPwpD/Mi+gZsS3vFskl1DVnUPK/tRWUhDhSjgkS+ar1Z7t?=
 =?us-ascii?Q?941SX/HAj/WEZcqWn6XBPaMoho2540Z9e/hSUk+RjY8PcgYAltmSoxqZGbzM?=
 =?us-ascii?Q?+72s+32A0gDw9TzAGbAcAzAhcaLtPcdaGq2aI67nqBHae4pjwon8jPEpMKd0?=
 =?us-ascii?Q?AFu6q3G1xcaqvrluQlyTf8gJao3Kpx76kP4vxbK6lz+45/cAyhT2ZPHae8jz?=
 =?us-ascii?Q?c41q/o8MFwlSV7BZ3W6xmmYWMhJEAAnLGzFYN57ee0+xt4UK3TRZDl8/MCYu?=
 =?us-ascii?Q?14Ox/lhYbTQlcdHtV2HiBYRWqpUWLDdCwG5bYj/99jQwCaRGGlPLa6NtawzF?=
 =?us-ascii?Q?b1DgSizsvgU+DyxB/7OF3OOpya0zjOPoTdMH5V/ZhLUS4KASuuRzwHZ0com2?=
 =?us-ascii?Q?0KB8xkOhUXUYOTMAYT+oWMk6403h1/IYfr1EFwZIZlRigRmN50eB0AXt/cLF?=
 =?us-ascii?Q?doIHxoaC9YiheqmxUfSEzeHBDe+2P6FMNBJ6FcYPmEoLu9wSYs+F6Uutd9UR?=
 =?us-ascii?Q?x0lW5JQ8QoY76ZkEDMbdrsBUBOekZeHDlLEt3tyt/CXvTXyiPT/LqleWGuUi?=
 =?us-ascii?Q?kNyRGMOIQGD3CC1OAJi8PEsdeVcz3NpZn+4I39wsj8SoaAOi3DENVq9VfudI?=
 =?us-ascii?Q?bUHFgkW6Kjo0nk4sobBDruXfs2ohxpO3MpS9sMLZTvkxgJaD0tcNnaAKPmqn?=
 =?us-ascii?Q?E8ZpWs3NyChBR++HZQXeU6Wd1dGqls0WSF5jPfZtrotaBZR4DuQchkiY+auz?=
 =?us-ascii?Q?j7LkFIDhfWodxqUlOkTPVyGTuwey3i26lFqNJKlC+Qa8Ot3UCGb3OEq0qOpD?=
 =?us-ascii?Q?p/GwMylq9hhGxJRl6nlsx8vpPTEp7qHPPNudfjFsxDs3EQ3YMPENLNyuS7Kq?=
 =?us-ascii?Q?MuEW7KauIw7Wxrc4z+7/08JAN8qRwnNdcbnlIq+0lQ93Mi1qnCp6l/X6+lK3?=
 =?us-ascii?Q?u516WyPl/Fsc2Gmr1X6oOeduSjyPJxlgknhrZ+V/ZpnZSjGDHG9IkeccK90L?=
 =?us-ascii?Q?mjaH3ISNEUvonCmCLe4+WhT7h4pBMg133cDPmTvjtNpkbBtbpQ6jBq50waiH?=
 =?us-ascii?Q?yL7J6RseXHR6axxfiE7uD/GZxeElTKIcaFkN/LV96dxxZq9mV1VG4W9MPdeC?=
 =?us-ascii?Q?NVrrbVp+qRJ2amNuFkUMwN73uX9WoJ8a7FMV3wl6Ql5Qoj/9Bb++UsJhY4xU?=
 =?us-ascii?Q?TxWYC+Vu5ofZSNCx3muAoPvFSjO/z+iMnwBZm8/k+AhXTRHutQe1W7K/Ibsv?=
 =?us-ascii?Q?Tw7EuGtSbENxPVn45gLgsukSAGITpokQnPQNpiB6B/vhwozzpJwCu7Jrecs+?=
 =?us-ascii?Q?C8PjXMjrIoVdXdT2ACi5o3D3JNJi+JUQFab5Cmqm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6974f019-f8ca-4cf1-0158-08dd6b7702b1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:28:24.9484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n57eayqyWwF5KY0UBumNLmHJwv8gVnb3reE4hG399/9QSs/Tug9ObqNke7fBdmXVjIJMz8ZsK88Zp2mtLI5/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9771
X-Mailman-Approved-At: Tue, 25 Mar 2025 15:56:16 +0100
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

From: Luke Wang <ziniu.wang_1@nxp.com>

Current mmc bootpart-resize command only support Samsung eMMC BOOT/RPMB
hardware partition resizing. Add Sandisk and Micron eMMC BOOT/RPMB hardware
partition resizing support. The commands and parameters for resizing
partitions are different for each manufacturer. Select the corresponding
function according to CID.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
Changed in v3:
- fix capital letters according to Marek's comment
Changed in v2:
- define some macros according to Tom's comment
- correct emmc manufacturer id
---
 drivers/mmc/mmc_boot.c | 173 ++++++++++++++++++++++++++++++++++-------
 include/mmc.h          |   6 ++
 2 files changed, 150 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/mmc_boot.c b/drivers/mmc/mmc_boot.c
index 367c957b518..986e6c500b1 100644
--- a/drivers/mmc/mmc_boot.c
+++ b/drivers/mmc/mmc_boot.c
@@ -8,20 +8,107 @@
 #include <mmc.h>
 #include "mmc_private.h"
 
-/*
- * This function changes the size of boot partition and the size of rpmb
- * partition present on EMMC devices.
- *
- * Input Parameters:
- * struct *mmc: pointer for the mmc device strcuture
- * bootsize: size of boot partition
- * rpmbsize: size of rpmb partition
- *
- * Returns 0 on success.
- */
+static int mmc_resize_boot_micron(struct mmc *mmc, unsigned long bootsize,
+				  unsigned long rpmbsize)
+{
+	int err;
 
-int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
-				unsigned long rpmbsize)
+	/* Micron eMMC doesn't support resizing RPMB partition */
+	(void)rpmbsize;
+
+	/* BOOT partition size is multiple of 128KB */
+	bootsize = (bootsize * 1024) / 128;
+
+	if (bootsize > 0xff)
+		bootsize = 0xff;
+
+	/* Set EXT_CSD[175] ERASE_GROUP_DEF to 0x01 */
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_ERASE_GROUP_DEF, 0x01);
+	if (err)
+		goto error;
+
+	/* Set EXT_CSD[127:125] for BOOT partition size, [125] is low byte */
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BOOT_SIZE_MULT_MICRON, bootsize);
+	if (err)
+		goto error;
+
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BOOT_SIZE_MULT_MICRON + 1, 0x00);
+	if (err)
+		goto error;
+
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BOOT_SIZE_MULT_MICRON + 2, 0x00);
+	if (err)
+		goto error;
+
+	/* Set EXT_CSD[155] PARTITION_SETTING_COMPLETE to 0x01 */
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_PARTITION_SETTING, 0x01);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+static int mmc_resize_boot_sandisk(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
+{
+	int err;
+	struct mmc_cmd cmd;
+
+	/* BOOT/RPMB partition size is multiple of 128KB */
+	bootsize = (bootsize * 1024) / 128;
+	rpmbsize = (rpmbsize * 1024) / 128;
+
+	if (bootsize > 0xff)
+		bootsize = 0xff;
+
+	if (rpmbsize > 0xff)
+		rpmbsize = 0xff;
+
+	/* Send BOOT/RPMB resize op code */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = MMC_CMD62_ARG_SANDISK;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	/* Arg: BOOT partition size */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = bootsize;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	/* Arg: RPMB partition size */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = rpmbsize;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+static int mmc_resize_boot_samsung(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
 {
 	int err;
 	struct mmc_cmd cmd;
@@ -32,10 +119,8 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = MMC_CMD62_ARG1;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error1 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
 
 	/* Boot partition changing mode */
 	cmd.cmdidx = MMC_CMD_RES_MAN;
@@ -43,10 +128,9 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = MMC_CMD62_ARG2;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error2 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	/* boot partition size is multiple of 128KB */
 	bootsize = (bootsize * 1024) / 128;
 
@@ -56,10 +140,9 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = bootsize;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error3 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	/* RPMB partition size is multiple of 128KB */
 	rpmbsize = (rpmbsize * 1024) / 128;
 	/* Arg: RPMB partition size */
@@ -68,11 +151,43 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = rpmbsize;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error4 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+/*
+ * This function changes the size of BOOT partition and the size of RPMB
+ * partition present on eMMC devices.
+ *
+ * Input Parameters:
+ * struct *mmc: pointer for the mmc device strcuture
+ * bootsize: size of BOOT partition
+ * rpmbsize: size of RPMB partition
+ *
+ * Returns 0 on success.
+ */
+
+int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
+{
+	switch (mmc->cid[0] >> 24) {
+	case CID_MANFID_MICRON:
+		return mmc_resize_boot_micron(mmc, bootsize, rpmbsize);
+	case CID_MANFID_SAMSUNG:
+		return mmc_resize_boot_samsung(mmc, bootsize, rpmbsize);
+	case CID_MANFID_SANDISK:
+		return mmc_resize_boot_sandisk(mmc, bootsize, rpmbsize);
+	default:
+		printf("Unsupported manufacturer id 0x%02x\n",
+		       mmc->cid[0] >> 24);
+		return -EPERM;
+	}
 }
 
 /*
diff --git a/include/mmc.h b/include/mmc.h
index 81bccb4cf12..11e95e7a716 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -79,6 +79,10 @@ struct bd_info;
 #define IS_SD(x)	((x)->version & SD_VERSION_SD)
 #define IS_MMC(x)	((x)->version & MMC_VERSION_MMC)
 
+#define CID_MANFID_MICRON       0x13
+#define CID_MANFID_SAMSUNG      0x15
+#define CID_MANFID_SANDISK      0x45
+
 #define MMC_DATA_READ		1
 #define MMC_DATA_WRITE		2
 
@@ -112,6 +116,7 @@ struct bd_info;
 
 #define MMC_CMD62_ARG1			0xefac62ec
 #define MMC_CMD62_ARG2			0xcbaea7
+#define MMC_CMD62_ARG_SANDISK		0x254ddec4
 
 #define SD_CMD_SEND_RELATIVE_ADDR	3
 #define SD_CMD_SWITCH_FUNC		6
@@ -205,6 +210,7 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 /*
  * EXT_CSD fields
  */
+#define EXT_CSD_BOOT_SIZE_MULT_MICRON	125	/* R/W, vendor specific field */
 #define EXT_CSD_ENH_START_ADDR		136	/* R/W */
 #define EXT_CSD_ENH_SIZE_MULT		140	/* R/W */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
-- 
2.34.1

