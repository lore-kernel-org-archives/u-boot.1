Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DA8D35165
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 16:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119FB840BE;
	Wed,  1 Apr 2026 18:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="femaHUd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE7C840AA; Wed,  1 Apr 2026 17:05:10 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A1984010
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ioana.ciornei@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8I9taOPFhb0oeggshfSneZ0D+iy6iZBU/Xp0h0oUdYrRcT3ecgIxyjt1cqKrHajb2ukWnANlQFHClkzF60bHyzxAXfzKzZbId5M6nUoYJpenwMAv+LiCMPotE5hSGv7l6+JW5D9Fm9OTa7iX7cpDOLaplAB2gKHumaovxtjf5FJPsdVUYqEqbHXaQy6+P2ybwn04DCxcjcUMmY9+dVKF5rRcC0NjE0CMXfdCcetmgO3+eZFllJRhO3Wq76+iwI507Y7fImcq8TtidUNrdMPQ6yG6llXY7w1gqylm/rL+qnQ5IV9DcarxipkOLGjsKLFyq50+HA+RmlRzYKhTmYmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQCi62aRHYwEU4LzV62RhC91KgbOzvXD6zVWLOcxhdU=;
 b=deuZLPSG1x4MwjHqRV//xdRcfoIQL5W+FkOj6y+f57pWlT9FoR0fPPMUzD2Qq6qoCiY1ADY7BIkgWQHsTNRB2KXSykGZa+l7zbDFbepmZ7tjkMoVLzO0buMRW6nOSCHBRi1N2Vmffkgzqbj+JkAwxKZ4ccMORVHpw3n7SfLixOJ8ZhErJEzrB4KbcXhsiLLjTuoRE8UfjYlx0zaIJjqi/rhr+QO+JOcmkUm/3GW4ddGhIlqGkYXr4K5cLLZUWnDVxnOBIypQraYlGU21Q4XIWhb1FYcpGWacF7ROQNrC0sbdpmT5ttsuzWM0kTfyQ57OXGZSb7WjDArBrV7NWDCt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQCi62aRHYwEU4LzV62RhC91KgbOzvXD6zVWLOcxhdU=;
 b=femaHUd7gjLOGbFVWD8rnmrt2q5VSllr6rn8aWgEoiDwnEPd77O1gNAT2oHnoddzy2O0fhwh2ThsMMa44LFtQe69usvnThDxxhRzpoN5SX1BmH71pNMUPkt2+fQ70pO6g/Sf6coZ34GY3PO7z8yJqpvlFY52Ir+LAd0r6cpKQR1/cC6kQsQWseuI06B0WakjM/aKQKo0wCI3+5myp2Fuh2UUA7iGBnsfk8SttjVheCiU3m1eTaKSiiaqzkCjidj6IbD/a1QAjTM5x1/xTaflaLMuA8yqYca7UkVZmhlzeh1HaR9Ed3oEhh/c1GkPqNrH0b+T1qmFtgAxgVYLYS94zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:05:04 +0000
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49]) by DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 15:05:04 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH 3/3] drivers: net: fsl-mc: add the nowait option when applying
 the DPL
Date: Wed,  1 Apr 2026 18:04:45 +0300
Message-Id: <20260401150445.3070308-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
References: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To DB9PR04MB8251.eurprd04.prod.outlook.com
 (2603:10a6:10:24f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8251:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a73f94-b2ec-4997-9f9e-08de90000e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8ekYt9oi4kJugej/EIaKUwDy9678eAwlSbrgNaKNtncUKHLFqN7cjKST3yRxmnnh8Vk1qt0JTSbdB5Bqps99QSKkt/FeCKRbHQKmFySD1IsQ7G+DMykyRj60NN+b1JsevMH3buFDRfUNw8XJjRX5Xzz8ENcXF/FQiDMduuMzJSBneNgoOGsy+1kPVsBRN9FCAFOgjHSb3cvN6mUXgLUuITLRU5INSATdkt+/gnYGKayMVxwChFta8beJ2AM6M8/mawLBTC6ISXbpGhmqy2zc6R7PDneI0YxX09xPz2/gPnoM1XoLqBT+gZTbkhddgAqmd834kK9kypt1NtnGYzXAGlRfloaj9wJByR2DejvQWfYk9YZjohwlnD1R4kU0X75Vj1MtHtaaYNRRM+sHE0H307x6mYykkZi9wCpO11AY6k9ejB8nVnhOGFI8x4X45VATuS28scMtJxzIDolLRaK34WBN6yi87VuAK4NVCou6rIjKiI58l7E7Ibzu+d0thqX9pyFvovBHowSp9cmQF9VhIq0f9BT2Th+kW8pE5pJ51oqLFhEOROcY0iTjo+dSr4vU/Wx15/EPCOUT9GHy7KjJDlXUu6+v/XH8XHxEiET52guYrqS5nWol2+f1I0A+tY9Ln5795qZS8qsGMOCreuZ9WQbxY43FOM1OfTeuefX+s4HU1oqEBsIhj9sf8MPmtuN6rruVfy5KNZXqGApZvBWJrWL66hVV/JNZ+nRtfqustU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8251.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6b3c7g/N4oxI+yLD5Lp4DiTbtaQbyxXdyL5CqWChZvuspqKP4td24jr6UGWj?=
 =?us-ascii?Q?hznmUGxp6BVEfeGfXfrpUIkWtLRl4b1HbUHwY+lhGfsSKdGJTcJEXb9faZ6t?=
 =?us-ascii?Q?E0P1loM0bkg50IyWVOCeUQEQJq/KQSbD8t6HRyQvuIrBjRbWXsAslZ7egKU4?=
 =?us-ascii?Q?6fFNRMYoUeAwElHecIzKVU12QCNBrZscfE8g8J8ZmHsEKTxvyVNZeVz2hUg7?=
 =?us-ascii?Q?vVw9WwxLqLsyxI8F+kKdq6Yjv8qmx94W5H3V80yDjhEa1C7THzdkOIaDXeW0?=
 =?us-ascii?Q?2zeSR0/NO8XLJWSAiGa1v2p+RmyhB9MV+YlkhhBpjNdphaWVIK3YKFsbDqiG?=
 =?us-ascii?Q?kbb/tyN8Y/JpwMWl4lo1QOgPbdTe8ToFUkyIDCYI3kLN0I398SOnrYG9+wqE?=
 =?us-ascii?Q?fNVIQ+CUS4nXv65Hz1lcqBoLAqZTvnS0Dap9FGRN8GB1M8T45yGs5n6ee2L/?=
 =?us-ascii?Q?3Zz9yeFrWCheO5MBvIiOoKe6ADx6YxVyhtyLYhEeoivGIiabEgCMkmNg5FT/?=
 =?us-ascii?Q?22Ahy8WTf3emYQZnYqUmSiLNEj5hmp72SvS0KrcSq3H5ZHb8lpm2bZTi9h3S?=
 =?us-ascii?Q?i8YNnSm1mgQ0gGjmTmKesxkr5xtQj+g69weKpvXtgFVvARLQRTIw4LPyVSNv?=
 =?us-ascii?Q?RHTCJ7J7QifBohcpffCdQwbq8chfZe99ZX0SBwsPK76/bsO6uoekX61AGsrs?=
 =?us-ascii?Q?7XP6nkrNFMit8uKafrm2mZqhEYIsEanpLm2M1Yh7NrHwcN15LgZseeVQlv+1?=
 =?us-ascii?Q?FLR8cUhs1vdJhyfJXNV3DZzPFjV6b/BMRA2OaFT/JXSIYBSaQG656Zh0E6a5?=
 =?us-ascii?Q?9vDOvTBpFinjpP1kL/8XfCHsUTFuiTTSZTBE0mQhbqockv8Ui67Ey1y+wXOp?=
 =?us-ascii?Q?PYQTAQ+AS76n7Oz1JZbb6MG+c/aqMRWdRMC+hyV9jN1gpblw7nAmM/jo3zZo?=
 =?us-ascii?Q?XV6OjkCij8yZ+fYef3C9vFVvtiirwLe81GYW+QlhArdRMg6KKQOvrCZ0AXvr?=
 =?us-ascii?Q?RCO/NgvJ9ZQw3StrLySjJDqcdAIzWLcOuSVWSMuDDWtspa+s2P+Yhmh9Px9G?=
 =?us-ascii?Q?XF93jR+2fxADiRWBAHodbevWlwwpL58BlnUMOyu1RBNpm4bCdythGjHC5Y8v?=
 =?us-ascii?Q?1TpMaqeDoPD8b7nRcRLJGiLHIdbyRRfPTNsfixF+ulzjc6ULhYWCQBV5f3ul?=
 =?us-ascii?Q?KUzHp8Q9ML9CPLdL9xcYXecg9WaAlVC/Epm3De0njG0QPLQKZJT5AwpJPmcL?=
 =?us-ascii?Q?SpCHxuxArkiy0j7bUzOqFpn2Sh3qhY6rcFqBMqGbNLxB9jyq2ZzEu7MzqMor?=
 =?us-ascii?Q?VzJkHJk72cE6YWoe4PdgmPk1k1gqsvLuK+5V+yAE7YMI0UuBjJFCdT3RzTCx?=
 =?us-ascii?Q?mnot6eYwPwpg8O4FIx09GCyNEes2s8GvjGtZWhDTR+V5b+H8bT36Z7WqvYqN?=
 =?us-ascii?Q?b7JXENHCQ6jLLB8aUwyu1j2+WdFpGfSwSmAtTUHoOoBJTgN04/lEn0AFKH9V?=
 =?us-ascii?Q?9iu5vAB74YPpouBg+QaKKRHt+IQLtyffdQX8jzrDYBHFNFaCDXEY0eU0z+AR?=
 =?us-ascii?Q?9T3//pE2vdRavwz/f8EVdZOiYDjB0KP4Tufwx3mD5+1LUi7EavHPi/YI0QEu?=
 =?us-ascii?Q?zwPtEgm2yBjQRcYOAvnOgPLBGlWX4d9LlzTGe+f9+gEwBDbrK4XmMqS+3XH8?=
 =?us-ascii?Q?5Kryjg3cDC0tg9udFDRWE4+qMvP28T9ex23XZnL4D/PW2vyvZ6x4Wln03r1P?=
 =?us-ascii?Q?pXHvJYEiUA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a73f94-b2ec-4997-9f9e-08de90000e0f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:05:04.4169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2Mdh8w4Ekbrw0wYgT9P+R4QXtgqKYnupW1xK69XGXcsfc323nH+/vRi08Z3Q/cmJY8TqD64RKzVHChUDBeQ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:15:20 +0200
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

The process through which the MC firmware parses the DPL and initializes
all the requested DPAA2 objects is a complex one which can take quite a
bit of time. For the those circumstances in which a fast boot is
required on DPAA2 based SoCs, add the 'nowait' optional parameter for
the fsl_mc [lazy]apply dpl command.

When this option is used, the Linux kernel fsl-mc bus must wait for
the firmware to finish parsing the DPL before proceeding with probing
all the DPAA2 objects.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/fsl-mc/mc.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/fsl-mc/mc.c b/drivers/net/fsl-mc/mc.c
index 039375e5dfdd..e28f8d96ed77 100644
--- a/drivers/net/fsl-mc/mc.c
+++ b/drivers/net/fsl-mc/mc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2014 Freescale Semiconductor, Inc.
- * Copyright 2017-2018, 2020-2021 NXP
+ * Copyright 2017-2018, 2020-2021, 2025 NXP
  */
 #include <config.h>
 #include <command.h>
@@ -72,6 +72,7 @@ static u64 mc_lazy_dpl_addr;
 static u32 dpsparser_obj_id;
 static u16 dpsparser_handle;
 static char *mc_err_msg_apply_spb[] = MC_ERROR_MSG_APPLY_SPB;
+static bool wait_for_dpl;
 
 #ifdef DEBUG
 void dump_ram_words(const char *title, void *addr)
@@ -855,13 +856,20 @@ int mc_apply_dpl(u64 mc_dpl_addr)
 	 * Tell the MC to deploy the DPL:
 	 */
 	out_le32(&mc_ccsr_regs->reg_gsr, 0x0);
-	printf("fsl-mc: Deploying data path layout ... ");
-	error = wait_for_mc(&reg_gsr);
 
-	if (!error)
-		mc_dpl_applied = 0;
+	/* Wait for the MC firmware to finish processing the DPL */
+	if (wait_for_dpl) {
+		printf("fsl-mc: Deploying data path layout ... ");
+		error = wait_for_mc(&reg_gsr);
+		if (error)
+			return error;
+	} else {
+		printf("fsl-mc: Started the DPL deploy process\n");
+	}
 
-	return error;
+	mc_dpl_applied = 0;
+
+	return 0;
 }
 
 int get_mc_boot_status(void)
@@ -1995,6 +2003,11 @@ static int do_fsl_mc(struct cmd_tbl *cmdtp, int flag, int argc,
 		 * later from announce_and_cleanup().
 		 */
 		mc_lazy_dpl_addr = mc_dpl_addr;
+
+		wait_for_dpl = true;
+		if (argc >= 5 && strcmp(argv[4], "nowait") == 0)
+			wait_for_dpl = false;
+
 		break;
 		}
 
@@ -2023,6 +2036,10 @@ static int do_fsl_mc(struct cmd_tbl *cmdtp, int flag, int argc,
 
 			mc_apply_addr = simple_strtoull(argv[3], NULL, 16);
 
+			wait_for_dpl = true;
+			if (argc >= 5 && strcmp(argv[4], "nowait") == 0)
+				wait_for_dpl = false;
+
 			/* The user wants DPL applied now */
 			if (!fsl_mc_ldpaa_exit(NULL))
 				err = mc_apply_dpl(mc_apply_addr);
@@ -2071,8 +2088,8 @@ U_BOOT_CMD(
 	fsl_mc,  CONFIG_SYS_MAXARGS,  1,   do_fsl_mc,
 	"DPAA2 command to manage Management Complex (MC)",
 	"fsl_mc start mc <fw_addr> <DPC_addr> - Start the Management Complex firmware\n"
-	"fsl_mc apply dpl <dpl_addr> - Apply the DPL (Data Path Layout) file\n"
-	"fsl_mc lazyapply dpl <DPL_addr> - Apply the DPL (Data Path Layout) file on exit\n"
+	"fsl_mc apply dpl <dpl_addr> [nowait] - Apply the DPL (Data Path Layout) file\n"
+	"fsl_mc lazyapply dpl <DPL_addr> [nowait] - Apply the DPL (Data Path Layout) file on exit\n"
 	"fsl_mc apply spb <spb_addr> - Apply the SPB Soft Parser Blob\n"
 	"fsl_mc start aiop <fw_addr> - Start AIOP\n"
 	"fsl_mc dump_log - Dump the MC Log\n"
-- 
2.34.1

