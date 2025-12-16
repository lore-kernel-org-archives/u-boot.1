Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA417D5C0FD
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CE483734;
	Tue, 16 Dec 2025 09:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nDGG0wyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCAB836AC; Tue, 16 Dec 2025 09:46:35 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A896683700
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHeenjo8gs7mMjlztKh3myyUV8ZxGW88QrR+eZRXJlylm1IetZPSnxuVlpKPTzaeIlOauDayUyVYoPtGR8pLjBIj687E3CybA3PIi6dWtiDg1e0LF7qgC+nG+Jq3+sYWgMwJqfrSB02mzPcz/jvtcR2g755H+J9nLr+zpQeRHyWTR5bv6zU0LI+KxYsIh/TeqhHqhJv+vzvSB+QHvnoIGTJQZpLJFU6iDCLSe4MrU5jgekdVXmTcCB1bgn6T0QCU7wwIjYHozldcyJougTHzXU/ROT1dfHJtdKLlaWFkoG0tg3Yp5ROcScQJ8RoAaPZ7FAxE3JZVxn0qyXcmx/n6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByyCxGpd1WNzYBDcOQjM8NYQPBexGuHC6KtfDLHZe8Y=;
 b=f0yqCHFKPvP9YBImCXo1zLSmmVDqsmWIrWZK1y0r9hC1UY3lcHRqWSFirPY/6AgmKK9Ev4xGYQbUDfPUlJfnu1j1XOgULwxXr+LO2nOvvIudi5vEReSBFxg2gFbPnI2SR9FgxVAEcDCDQ+FfwgD7pybxMlmtcjAZG+0Tk25vGGyd90sPZQFMsZccmCFm0r4MpUBHyIjGzN5cO/+f/rMtzddib9ZP0mls0CyjxHIpF09bD6+5zIyzR32BJL/MQIDgVOn8jJDL/WGEh4ujItDhXTkStEE8gJaBn/XsCsre/Z4vBGweyb7bjs6C3qv63mGf4GoFbCHsAtLRNG9XR47g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByyCxGpd1WNzYBDcOQjM8NYQPBexGuHC6KtfDLHZe8Y=;
 b=nDGG0wylSeI3ULQvqmlmQMs91P+lXY+/Tg93vRerceiUtw8xyHe+uiiT5KFomM5Yf6cN2acHeh0TuWh6ur5/XwAiHIJ2EeqALzEJa9okB1xwY+Z0LRoYnO9mh2UDBLOAtm+ALjcu/5L3yphNfSvO0A5BYzPGBHamAqwA2hUCDqNC8FnHTdKuJXRPMIGzjGdoPLhtIecNjNrMJVTXLmgSJGUr8p1GbOEUkQtm8Ebc3ddmNdpgFNQDtzRLsoSEQffFOIGNEA96LxIKpzNjeKJEzRnKTc7Lk1Bs0xrWctN9LjrqtoMMTS6eNqMOM1NvXuyyU5x5BkzRiaxOfCIrxewXxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:46:30 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:46:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 4/5] ddr: altera: arria10: Add DRAM size checking
Date: Tue, 16 Dec 2025 00:46:22 -0800
Message-ID: <20251216084623.19589-5-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: b37ce78d-0968-4c60-898c-08de3c7f9b36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cmXMeVyRZGjgkMPQXDqwd69zyM1XNn/n0AtWQiky6pG5SDmqmfg2oHt+lox7?=
 =?us-ascii?Q?9oYe0F9YM6L2c3HgLMI96vUYixc/FvoXnZg8+v1T1+TGEfFHPsKPv3zZMaxh?=
 =?us-ascii?Q?pETLVZ0kyhYkIU86CedlID/ui1ElIh7/PXE3k5Qpad3tKEq0zqVd8mjnG/56?=
 =?us-ascii?Q?d6DlLzOuXXNlTxMUdXigh2C1clnPvUIP700EsUJzdHYIayLQIyKl5E5z+uNv?=
 =?us-ascii?Q?Pyn3SQ0VseaAGvG7jqxfJNt2VfmuCuvPR0UK1Ywg/YGMHneYezRB7F47WITj?=
 =?us-ascii?Q?2w2vHiABIULp7FKdJ5H95BnqkM/+Q6rodBiU8SPgDbbANaHCtRF0iWJu5GYt?=
 =?us-ascii?Q?rYODXZeRGlvLZLBpzWpyzLyhI2ydfThZc8zLWFsWzh5pf50rxS8JauJYqQ5W?=
 =?us-ascii?Q?cmcg0Ln0Q9YnXxBHVm/yn5DyMJj5O90/zjCmCzED9LaT2+w5b91MS4tckgDg?=
 =?us-ascii?Q?B7iOTQgVSeBrNmIo1C1qrcdxO7jWR9fVLmLBFqmRGvnPAbdBdq0VWAgKsPCj?=
 =?us-ascii?Q?dafPhzJgRBKPQJYqEagnxK4dQ91x1fFO99w06Uc2zkQcGY9fhKg9x9GfzT5v?=
 =?us-ascii?Q?0RDsfmWXqpZM0iQEQ99xa7o8vBgZxRR6BVFRX6zNa0I2H37w3FQ1MdbwrD6t?=
 =?us-ascii?Q?G7bppjFEOFabae/QvSu5YuM6LCbUcmFTroZ/4LPCHRaoYTlzIXS421Irpiv2?=
 =?us-ascii?Q?+LSBvpsVXMLCPZ/bZej/d7Xb2CgomTJTqZOp70xGhN89xkg6vFDf8UKnZQdT?=
 =?us-ascii?Q?YjDfb98eNGpV6fBsnnKclIILJC0Wyr7iLhL+OxyBLldemMr+B471EZSnGXZK?=
 =?us-ascii?Q?X3R9hkiu2b+5NPylgB6Veml+E4t1rTmk1+Bf7Dgl7MMMfjyZzOSdloqUK6Z8?=
 =?us-ascii?Q?VZe10PGMI5zAkero5DzV3DIoE0iyfKD6aTJY+Uo7kEOl8/Uie3D/hJFUCC0m?=
 =?us-ascii?Q?8M8lwPvKE/3yx6KqlIIUF+OzJPUTX2BVcW2zqulNyBBTSnypqOufxp1Klgn1?=
 =?us-ascii?Q?84plEk8ljIP1nrAVlpBvzXITqCqxG74XaLN0/bUGWl3qO5hqU1olYAJORsJ8?=
 =?us-ascii?Q?YcbpP8k7uKpJM/LB3v+aMkLYYzv+IsaxyOybbdHn8OWMUhk5hkj7qbR59+mW?=
 =?us-ascii?Q?W8m/xP8sV2PG28QPtcxC8LW4/QOvM2wcS4JUZlpe0hpHYYJvF4MNnfxUUDy3?=
 =?us-ascii?Q?HzqVQekhbrAOmna4NWp16SrzXLbhG+k0YHrvJtJ7xsDLoLY3c8/ZlcH5Ybhl?=
 =?us-ascii?Q?MqFzVDW6AqCgxRZfpb0VaYoeu8JbS1gtszqca3PDyAw8WANCVas52FdmbcQl?=
 =?us-ascii?Q?uEOpzL6uJAJHgsKuysC+yQyTozzuRDIKJCahQivXeUwEs9Rz3Djsdz5Vc/0x?=
 =?us-ascii?Q?mM5KlYKBR3nxljqNAYOWIjlqDN6lPHRhPSy878L7u4CZ9hI65EooU4E9sVmR?=
 =?us-ascii?Q?cPVXLapP1s1fb2CS9nvHU3VKX7u6jrVs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kgBn2g/Jb2nT/Q5gKLPSB4CglAQNU/jufq46bBULoY5eZB7lPkCXMQei83yI?=
 =?us-ascii?Q?Uv0acRhOaRR6xpd6GN3yi2Mu8fDRsQA2/godXwL+9koKkISQjnP0wZGZZDmU?=
 =?us-ascii?Q?5giVNPKkuBK17/SK3WLj9iRtqbAksjokvrz0fXM+NlRIy4wxWJl/Nd5jXp5O?=
 =?us-ascii?Q?gmmQiGD4b8ndZkMfYl37GT8pmPeDUWiBdybdftsvqfmPXlHx1OxG5NpUePjR?=
 =?us-ascii?Q?HE7VkuyNE6Ua/xbsm2qJ41ivADXG5Z4VdVL43a8t76oJuffOFkcQugk+M2BH?=
 =?us-ascii?Q?T7HfU3fv3/0KziGkvjPxpbAw86o/JoX03DRzbAfOZzlFMRcUYD35bbNkJrVi?=
 =?us-ascii?Q?xfAzEIiS+rbIIT41LlGIHPTj6Eimbz9puMbGcpJttvtVe12b7+KlYMTrOEno?=
 =?us-ascii?Q?S8VkEuXLCmdH82pZkEpVWyM3UkLqBKKbf/BJTqqu8hrAljeGjdP8+4oTHNqL?=
 =?us-ascii?Q?vNPfoWRM8zSldSD2vONl13anSLDLj+N/FB7BOcYdwu7BWU3Xf1yJv5umH97X?=
 =?us-ascii?Q?MsGygd5Y/bH2roCD24rfznOE01swv+3IshCnQijWIj2iW4ZcHDIRD7VSjEza?=
 =?us-ascii?Q?H7OI3TM6b6GgbxIYDhIlag0mxXl1cq/OeTElKmTtq94cSN+NbZe/d5LkV+un?=
 =?us-ascii?Q?nUYoOyBTrXbIfwl5q+xSNvPTxEJ9qD88j3ctz4VsbdsI9+WKosr0VX7ncqLD?=
 =?us-ascii?Q?3PI7HS9lkenf09J8xEy0mwZDOrGfONz+JWJDWJoNBLbO8olTVrOTfSiwxeWd?=
 =?us-ascii?Q?JaN3YB9cuU7k7rEwFecMiHC74aYRGcF4rgo5eq8Ss1lLMXuTxtc/w+2wLRt1?=
 =?us-ascii?Q?ya77EzB6V24d3iX87+5vWiOLo15XOtOvwU2LRbE8TYW7jk8EVHcNLyyzlSvw?=
 =?us-ascii?Q?Cou7kp7F8xJBP4O5onYiRhNjQvr6p7xvqysqkPeEOUB2jF017M0C0KeQQk0r?=
 =?us-ascii?Q?UbMvPTDKwk8dDxlQhjyEybaXfqCgWmL6yvLt0q2zVuJiVCdMuU31D09HSV2r?=
 =?us-ascii?Q?ZEURlG3jdDUeuYr1knjFaR9xqYHFsqhGppkemhbF/DHpr7gHGPGAwpdGD36I?=
 =?us-ascii?Q?g2QcEq6NZWr5rsT5YzH6y75r/UvVoTuenFyOA0Jiwq45a5J5LzeH/f3cjDZ4?=
 =?us-ascii?Q?RzC6gYXhApOIrcQkqhD7e2BErH1qQTrcr0X/AhNoS/XJ9cRK8UFCmYsrtESE?=
 =?us-ascii?Q?b33aAu1lMfzcI6lpd9trBLPFZpyxttRBiZcNofXdQWIy6FrAUcFzuhXiRHUL?=
 =?us-ascii?Q?iI2klbPO0OjxhZUOt3C3tr0xnmcj6ixgl+tcpzovM53hfC2mJWbMURzS8gxZ?=
 =?us-ascii?Q?q+K4x8fEoTPnlMlZHMtIAQlEnU9h0QjmLF6h61rzNsy77bLkHD/FXT8Hmixq?=
 =?us-ascii?Q?hySUJz/NeuxPYIVUtW4AK+nmMdIGbksr5IjXX8FBgSdkH7BTnrg4A8MS/PB5?=
 =?us-ascii?Q?LwTk6va5IYcWsEAq9ydirgIl1/H8pqxleLQn/dtd0EIvFruk/lQi+HJh4KkY?=
 =?us-ascii?Q?iHSGw/Uc5AtHQ1wNLxrdE57rpOyYKf3pQuPf8w/CXYPmAISOPzXb8QwYVWQa?=
 =?us-ascii?Q?F2xizlge/u6fcU/gAmmMaZGeUzAIUA72yr9HbD/j6s4pRwn4aL91WNtLcqSv?=
 =?us-ascii?Q?bJmEbPn18Os2GV3EqQKEh5PPST/98LmLrGXDedaoWvxyrFDxtmgOvTeb0WTT?=
 =?us-ascii?Q?X+agwVv4Ro9X6SGB61tnrEobeiNADxpHLbpAQeA4T45hL1hImZCq+2ekLZMX?=
 =?us-ascii?Q?pAAutYtzA/eT0CdH9IT0g8q+oiOkYYM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37ce78d-0968-4c60-898c-08de3c7f9b36
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:46:29.6678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5m0w4ds56nY5ycXhrJLYShbyEfNABcfl+J55C8zmvAQZA5MPKvjZ0OiN94z8iOZ3KUIF51qpibFDCEKoXYo/LQvUChAj+ETH+ylzs+xX1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add DRAM size checking compare between size from device tree and actual
hardware.

Trigger hang if DRAM size from device tree is greater than actual hardware.
Display warning message if DRAM size mismatch between device tree and
actual hardware.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 0e3a1d42f34..d75c464f42a 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -8,6 +8,7 @@
 #include <fdtdec.h>
 #include <init.h>
 #include <log.h>
+#include <hang.h>
 #include <malloc.h>
 #include <wait_bit.h>
 #include <watchdog.h>
@@ -654,6 +655,22 @@ static int of_sdram_firewall_setup(const void *blob)
 	return 0;
 }
 
+static void sdram_size_check(void)
+{
+	phys_size_t ram_check = 0;
+
+	debug("DDR: Running SDRAM size sanity check\n");
+
+	ram_check = get_ram_size((long *)gd->bd->bi_dram[0].start,
+				 gd->bd->bi_dram[0].size);
+	if (ram_check != gd->bd->bi_dram[0].size) {
+		puts("DDR: SDRAM size check failed!\n");
+		hang();
+	}
+
+	debug("DDR: SDRAM size check passed!\n");
+}
+
 int ddr_calibration_sequence(void)
 {
 	schedule();
@@ -689,11 +706,26 @@ int ddr_calibration_sequence(void)
 	/* setup the dram info within bd */
 	dram_init_banksize();
 
+	if (gd->ram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%ld MiB)\n",
+		       gd->bd->bi_dram[0].size >> 20);
+		printf(" mismatch with hardware (%ld MiB).\n",
+		       gd->ram_size >> 20);
+	}
+
+	if (gd->bd->bi_dram[0].size > gd->ram_size) {
+		printf("DDR: Error: DRAM size from device tree is greater\n");
+		printf(" than hardware size.\n");
+		hang();
+	}
+
 	if (of_sdram_firewall_setup(gd->fdt_blob))
 		puts("FW: Error Configuring Firewall\n");
 
 	if (sdram_is_ecc_enabled())
 		sdram_init_ecc_bits();
 
+	sdram_size_check();
+
 	return 0;
 }
-- 
2.43.7

