Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C40C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041558389E;
	Tue, 22 Jul 2025 13:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6XVG2RUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576FA83844; Tue, 22 Jul 2025 13:42:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD20483887
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGM9ab5FYuETCxRKXpJC9nQpnpxAGTMWhqC4n8LR40paasvdxefw7IBVfjcPAsW+tQpoKm4NHegLXNr1NKPdxP57w3yX2MljZso7Dd7aZFBM6axqUjOXqNABFqs9tLccrNhbElcSQzV+cclrwQBdkKlwdMcCdPrWKXzCT6M03dc3Wt8++xu1k9m6gXZQl1v4MNVbXSRc5l8FNHSqZcxU9EpOHEPO0aVJ81fr7xhvOyuIuzSC7M0sMOfXFX9t3HHc0O8X6cIAHiGGZIbynGwNP1Mbh0mWO2w6jjVMPd8Ovh/x6XiODfmHEgS8fyMOltvVaS6c9WGpgHQXOVu8iw5hwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=c4UOL5JDBHBwrR00KaJNGJETxoH1cGzaM+OWvaXy+/RsYuQoy0QK/onLeoEd/sI2dEbWrIqU6HzoZ6fUE6bHhsIo8V9nLzzc+PJ2j34nbKoIns2QTUzSrJqNpITtTBLP+XEo5SWlUKiosG+NsAitwwU9RFZ8fKl/Cd2aoLpYWXDElqm22xjluzGO1BmDQ8Vzpr1DtO9Q89qA1+5oUGresGA9R1btb/BI2LWUaR+PYufKuBFRYvXOienQ476EXt8vLJIqJ5hv4d3Nm+/e2eJ3z0eWfmUEDpjHSfh8wQWqi6pKeHcU73IfOqIjde/E26G8cho/lVPbzjKtStFLamK4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joe3FTpTyfHftH0nZKovFP4Po8Wwcg4QHNndEk6K+gM=;
 b=6XVG2RUFkrmtkyYvWNDvrHW+H075YQuLeq33Wf5fjwB+oliREmfPqtF1u+I8mqVXMjkV0wZP7b9VGY5t4iEsrC5jKsAnlhzXxPj2e87oaGBbyeuU3TOffPPv93pEb//1iQKdht2mlRaS300wf+vecUV4xEIsKvQ/r5U+yoODYhr6zgaLfDcf3MdLJEhF/dtt4eQ72kEgOINTrAXWox68RQKraUzGSakWF2pv1ICJlVdHUUlMCxVnZ9KEUWXUvKLAbKzsNBYFKKDPW41mX26TShOW3YQoRDwHKO2SYD1dwnVJxQ/GfKjhn0r6oCTUm4rwF2u/C3zPsCymzbVsEoOkrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8674.eurprd08.prod.outlook.com (2603:10a6:10:3d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:42:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 08/19] mtd: spinand: minor refactoring
Date: Tue, 22 Jul 2025 14:41:24 +0300
Message-ID: <20250722114135.768998-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1161987a-c471-4195-6fe7-08ddc914c664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JSXQbmF43RE+9fqP+0Zt3LYFwI5BU6D6DwRW1QJLMOJgeUXOR9/06Givim/+?=
 =?us-ascii?Q?8k8d7b8N5kIXkIzbW6K1bhqi6Es0LDFM+y7N2eFfrX2Bg72oBzxCYeA0JBXy?=
 =?us-ascii?Q?6iMetaMUcHNzGnYAkz5kVSAKzHFnOVKeRyPaeaE8HeEcIt4YUbFHKKo+zgeR?=
 =?us-ascii?Q?Kl7+aYE9Tw8NFkbgd2eEE/ucaxlYrLOrEmD/i32vxMMGmoGih7y2zy8dGFny?=
 =?us-ascii?Q?MEVGWQN4ltQzsK8i+cxh9ZoFNsLJm+TU8zThb6dft+KT4TSkPMAFk8uQi/b4?=
 =?us-ascii?Q?N2Jo7D8tFvZtBU36proDdw2X8o+O1Fh+JwSM9+A7LvI6Hx2Mb4vaEoKLNAHC?=
 =?us-ascii?Q?5mNLERC6kn2iOiwHskUPt7A6B9d67FpjAoQJP0hjn88E2uYjwnkktlfLB3ae?=
 =?us-ascii?Q?z0NdDcf491iaP+fAiJM3299tPngyqC3YZKIn3SpMH9/uxS4MOdllt9sRxH/d?=
 =?us-ascii?Q?yzdhMga6TKfHeepYQOTvazpEpHgl9yLAFAbnvBkASMiscoH+wLOsxy3ElFR+?=
 =?us-ascii?Q?UetvKCxk3Fumg2xnkB5sTh9YqrEG4j7gpm5U2R4CEF9L/mbBy0kR7GxpkkjJ?=
 =?us-ascii?Q?Ya7eNekB+Rrpe0gJ5V6l4AiaSgx/MN8IR0p8q8OzKKSD0UWf6W/KapGTb7R9?=
 =?us-ascii?Q?Zyll05Q83xIrht/bCZh9KYma4iv16KikgP+GNAW8X0gnEQTb5T55dMsZuvH8?=
 =?us-ascii?Q?nqLA/umLxBuVg0NsSp83DXAX+u4N5OlzaNdAT454w6hvLALVN476F+zl1mQh?=
 =?us-ascii?Q?GBAG5U7WCykxU3ZNR9rLPX4GvIRwh2q5uhHMYGHqRDjRZr1PKqsqI3V6eKlZ?=
 =?us-ascii?Q?YRhtJHCYDLNbGPMC8gC+p+fcqCzYSx2wnUPl+zGXisY3+z2Oxb0D7wxmqfvf?=
 =?us-ascii?Q?bgHS6hAapq0Vgaylq+0fwCYPWpQtBulibNlyPdvTDdrwkLQfATbqNI+jlYUT?=
 =?us-ascii?Q?3Px1ZhVqvOwU8Oa/ImmQqlHCAZMSMpo6e6buNnoYRwJkjOL0l1v2fKCilVaX?=
 =?us-ascii?Q?490v3t7i43LBJ/+0cER4VcHjoGGliCGc+SFbNiPkv5S0tmHLE8zrwLdysPiq?=
 =?us-ascii?Q?wZB8dO6TjecNcDmX62Mqu1gUJgVY7/PfHmApQWi6rtEfmY1eEeiSfiSPaBwy?=
 =?us-ascii?Q?lkjPM3+cUc6/pv6DDVnLjaV4yXm+CVGGENnzc8P2W4zm0a5V4PZg0/ILSoEf?=
 =?us-ascii?Q?IcvEkhK8VCeQRm92yKEHIo5BC2iavSY8IgEf2J3EBVdDAfMmA+/YRWysdc0S?=
 =?us-ascii?Q?LTe8aRgbQAO5aT6FQZ9K2GloiG5ZId3oGkJHVx+aM5XO0x9IWub0QJ2jFV5Z?=
 =?us-ascii?Q?dBSFoboW0DNhlvwh7YSLnpa5nUVMzcFlIPkoFi0l8THZzXzdBjt6xfhhYa87?=
 =?us-ascii?Q?EZOZSTl4wPHr+KoiLVciL6niLvMEMqajV08Z/oYhX+vk9sV2bnuv+f4SRKO3?=
 =?us-ascii?Q?/tbi1EvsBCf35dYVbcTJlVNIEXaGKNdv/r+/MWDayk5GTXg4F+mV6FZJLl05?=
 =?us-ascii?Q?LMjFGLvZFb7yIOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwkX/+MP1VmLtjY4ggyhhhE6El/DVaoIfS1cu2TBEGcUgL0VEMun2UIb2LWY?=
 =?us-ascii?Q?TSiR8W6DBDd3V+wCAZpDhA5QMaoXhEz4joIfxa4TbnjVfIhA7qiBEQD3opbv?=
 =?us-ascii?Q?BVARGnlfHaMvqthlCrQsKruM0I/XSBaCY1aO/yMrDYDXzukQy9VaQOYfM///?=
 =?us-ascii?Q?V1k55ktX6eSFnaYMT7jdqeuO4N2+5z+bOWopL9jb/MVeVqYEe+bOJXY2zVoA?=
 =?us-ascii?Q?HFXHxwkBBrgmOsNvCjQ4MAlMgPjPCtqXdin68uHvznqqU1/03Sd9JLpCE3Wy?=
 =?us-ascii?Q?qYlvXzD59GPaDRA2LhoaiqgwJXX6o/lejtHRdbu+PUZIr/4alcT8hGhqr70B?=
 =?us-ascii?Q?0FYD8KBtBLlH3rTq2dnR0fmAMVw1sMxt307KSCK7SUlVw7KQzHBe1MGG7Tvn?=
 =?us-ascii?Q?VMhlwHeEC2/afIFGYOBKoR2WvlnuE3RSPaxYQUuGVs8s/0axz2RJOnLeVZUW?=
 =?us-ascii?Q?1HHFzwpzTE/VAiiZcfYuo0LFf6XOqmE9Jsv4nC8m5UW+T14Vs21m0Zclneul?=
 =?us-ascii?Q?ZkmCsVJE7Py7L/8f7ig1wCXFyO+NHYDq9K8kTgvPpPxj5qiHIXzJCPBNKDW2?=
 =?us-ascii?Q?JpWvZIXaLx2DC2KzFnz1OK4t3xvwL1RsuZTP3XykLtdCx/bSfTTe3lUAMDvx?=
 =?us-ascii?Q?+neM49dbGzjiLchXBV6ttRkKQiU/no7kr/baAaY4Fn6NFeSEYB9buSG0kpSg?=
 =?us-ascii?Q?09wvCOELTRD0r/viU5F2qMTD2gsX8T8ogNJUCkE+dwA0ksbVBn41qq5Ddnsp?=
 =?us-ascii?Q?e6ZfWgh5lmrThlAC4q1qR/ku7Gpko1B3WdCK+LjlIKUCAmyl2n28UyOIfhlb?=
 =?us-ascii?Q?8vTvR5QsDxjscptk2kIcxYziCRDPeocC06CShQTYds37ObOB+78bvomxkP2Z?=
 =?us-ascii?Q?NdrqyAxg8v2aRrFDiz2jpBRQSnpPox9yVhxEnmOP+NpS0MBAzI2KcC/CUPoP?=
 =?us-ascii?Q?KgJKWtuhpggneWBfnYLDrhiQUdsmeAmqSPZfPNv1t8Fl2Nzzuk5eK0+G8mtM?=
 =?us-ascii?Q?DNFwIYXQT78aUdV1Uw5NGemPazWQifLn0HXqMaY5U7kZ4lqWv2R8FxvBON3D?=
 =?us-ascii?Q?RKm92g9d80ICsdv8UbtSM9s2sf+Co5bJm83LEchUyo+qffRGIqkQNNKgut/u?=
 =?us-ascii?Q?VD7HSRMcLk400E8Fw1DVV2lIMk1Bdii3a3TlKYKA86WT2F/0sthpn9TpgYdX?=
 =?us-ascii?Q?wVfz7XMbEukwu6ZvI5kO7WC7AYylJiuypnP8zJrb0G/pkRUhRFUeCZrS1pQY?=
 =?us-ascii?Q?SLr7EowQb8UEs3FCz5VrrSOMAqP/5sEIqY8ZJja57v6kKZAKKH765ez5shUp?=
 =?us-ascii?Q?BeqDnXTtmGfGIG6VnERht6Kns85pGRr3MpzZPusApPyIz065OUV1/8PDDhC3?=
 =?us-ascii?Q?v0B6sEFCoK/wZ0eG5K6UNE+BwcZm0cmATeCY+qYeKy7DcxU0CjQxCRzLBowo?=
 =?us-ascii?Q?aOc0pqXSXmGzE1MN0PiAuLI50pV+RNMfqjxIjbBonlA6kUCpKzl9OpUis8YK?=
 =?us-ascii?Q?d87aCYdkLTpbfd/n+jEWT7+S1JepaOyT7evgC9kZckByUKMGQt18dBTJwRTo?=
 =?us-ascii?Q?wNPvAJkXT5QN+umFaZulYDFMNfcSsdYtw5NnrQBeB3b6b+zawmtklHsmScsH?=
 =?us-ascii?Q?OdUdUQOK7PZXCx3RjEs6Ruo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1161987a-c471-4195-6fe7-08ddc914c664
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:02.3378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iumLOzOKiz5wtuh5IM6HolIqKBB8ngdAwCkd8B+/tJfErdje2LhFk3SObcYG/+7FcrJMSgF5W8EAHdBsLb+vCYxSMzUdkNf7xi34oRT2PFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8674
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

No functional changes, just some refactoring to match better linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 098ed0c4cd2..df59d3d23ce 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1091,11 +1098,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1128,41 +1179,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1189,6 +1209,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.47.2

