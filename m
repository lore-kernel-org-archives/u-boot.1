Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D57CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A47B83B97;
	Sat,  1 Nov 2025 01:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bPP3KmmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B75583B4A; Sat,  1 Nov 2025 01:45:21 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F6FA83B4F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUuRsEY+Gm4+9z1ECaAhOJP1WLO+TWHox9mfcKZqWTdMm+RODtxhoNLz/P7XmEyweF9ZLXbldZvWIFrty2AIWYyB3VSeQBqweKBcViqfaaJyxs1wmrhiv9bwauHjefTo+Dr52h18YFaH29650LaKSOXebXLcXlRWi7ULVGA80nJp8jv0Ns7sUSVpOCPzAg7+0GgkECLYzSbMnQTFRrWbvu6ZmG9pv/6zRWOmB616+OxoQ5LMEPGrJ1CWPyE6vqpcfUJUcOa0kiODUfunldvbqD9qy8SoKBuU8NAdCPqZXrLIXq3+Lgk3xxbUUIJWYkp0I/Ane6GBmh1/D02fNjjSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzGrP2wT7mp4Dom1PAzlLEdQ8cNTNpGV/2vUMSDr4t8=;
 b=DIJMYJ88rOehRaijd7N/aCUVe0J//YbEBSsTQkew/84KhWLSYMS1Qilju88xFLOS1zfhrHsmgqG3Eog2gAAVwyWjOWlYeWLaQWFKJcwmvtrEODm2P7KYAQA2k2wd7CzBG7BoF9B2llC07IiyBmtL5yQ9KVqHNvtQ1Ktbtww8mz2AUvyCuYSZ8UvyqGeJEw0ZBMCC2Fg9zrgDbdbWDNsGXhgPhriHtizKGO4LXvf5ZeDmbbg/LSTS315PDDBVu1a2Ldi74n/RIk0zYi+sY4Kuc9H1YjB5x8hHazXKWTHIF4rQyQElMlwtzJfuR7yxPmY5MpuReF1diGE4n/AA6xWfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzGrP2wT7mp4Dom1PAzlLEdQ8cNTNpGV/2vUMSDr4t8=;
 b=bPP3KmmGXG+RbP7oWPsacq6D29u9k0pi8cYaQdcPYNMlm3oThvC48VXzEyIDpRlh8M/uy9MPfGnROxXJuIMZNLcshagEZ41yIH1R1Ox1zMD9f1tvTO0zT7uWykOVd5nZjUkMjPj43nvT4ox80Go6gcVrbGCgxWfGsAolsnV/neSf9TvbDrVvHUGDI+Q3SaOekOKTNtqb19tkF3LTEMosZewdPWCjTazvK9Q6YjH7g+7UJBmhIPghE/iciwXnFjovUw4L+j5JcDnIiIl/tFzwo5/7VqeBET+RZRkjSaDNGQe4bjf5ILg/HluvCBBgZRHmZyQGtBalnJTMlAub+eunHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 05/19] clk: airoha: use CHIP_SCU regmap helper
Date: Sat,  1 Nov 2025 03:44:49 +0300
Message-ID: <20251101004503.2379529-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a473c95-0dea-4af0-bd89-08de18dfed85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpf6oXx6tNa/4d5L4kyjPjy5ZnIUg9FuW4mZPwz+4BCjBudWn7OKW6Y4ZfMw?=
 =?us-ascii?Q?TkHEyyo9x+z4qLl8gg2TV/5PVrHeakR+SOKIr8fGztMbmcdihGdqbZD1Ldvs?=
 =?us-ascii?Q?NGf4JPCC9fKLZEeioSGZkY5gdVA4Y2aYDRvVKCjhuvVvuSjuTPEQjCB461rO?=
 =?us-ascii?Q?fQ+vPZwcpqfgxWExxdJIdh4y1eeXsm++01vCd8Q4GDOQ0g/QxuUIbyxuJmYz?=
 =?us-ascii?Q?KiD3R61h9K2HJnBv/JuOJNs29XB53qTMX9B3lLt1gQPdngb9JP9i2kOVaHUg?=
 =?us-ascii?Q?Wt11GwA3p+U4URxLJeQjo5lcPm5scbub93E+ezy6Z4U+d3Dfslsdl+2R41ZG?=
 =?us-ascii?Q?7P+uNVo5rXcwX+lKs9y6skU58r/Tys/nLmFhm2wDav3WPSXOqLt8knUQaFk9?=
 =?us-ascii?Q?dSK9rNq7PyiMAmXIZwxsnrNelgKEhIIzWeQcNUtfjtilHjQHPI1W0MTZ9J4T?=
 =?us-ascii?Q?V88+4UfM9xGYelRvljCkJWxjojzPKRjNGSG/lMfIEZLAU3tFFoQlYEJltAyi?=
 =?us-ascii?Q?m5ZbDVBlJZOe9UHryxZUvK7dJCRU1YTMXYpTMyOJyfIs9gayY9GDcf2nnc+v?=
 =?us-ascii?Q?mrsE2u55lOFaZfrOi9InqvkBnUtzWK5DGa87RI/8nk3StlqLEG7aLJZc2GN1?=
 =?us-ascii?Q?/tgdSXAL/XwAi0fSBIKtTFE9ziRzqOoOnSVM71FM6EDFyPBtDG6d3zzeoXfz?=
 =?us-ascii?Q?X5+j96gRaot4avvtXzy0Lr1kP0+SpjPB18IpT1lWzueIvFKO201ChTPtTdro?=
 =?us-ascii?Q?fuY0gO8oJJeo0M0Sx6KV6G3pLOSLejVMo2S1L8hO/1t6UWd1EizUgteg9bKc?=
 =?us-ascii?Q?Xzv3/81+vgcVXCpcU15nFsW5ORA/3eO9qWCcg06TwkmZ9rp99i76kRPejVHm?=
 =?us-ascii?Q?p2Vlx9N4P+v/hEv7lKhTudhk0NJ07t4C5aDOZfx8DaOlv/B4GcE2ZARERDeG?=
 =?us-ascii?Q?z1JDWSVrKhJvLGLE9gylaPVWUatUwekMKLFTF2CeVZtNWS2Ow4wm42cERg88?=
 =?us-ascii?Q?8ZuvxWmkeHDciAvZCRyH3NOaKXZEZohavnH/WaastH31YiCTXGATokPHMvkv?=
 =?us-ascii?Q?Q4/Ti5RugKAG6kAKeJVWbLEic7hQWwzlXMq4TP/V08GXtNO4sR9P5fs9z3qV?=
 =?us-ascii?Q?6UrhHFPvWEk7OcYqlxBWiLfP+UcYknXiAOrCwDjmMAW5QPvPCckX8xpxD201?=
 =?us-ascii?Q?/FF44PIDXaliWLXxkNqGxCEyyslBh9UxGqErP5VSQ5om+jTWfweqpFvgqTsQ?=
 =?us-ascii?Q?lPHIOsi3LmRRXm080/ATrc9QQhfh/F/BzEN2C/ZHJrgARRFvu4t6MVicERht?=
 =?us-ascii?Q?qX4eZ6vlDJ/NZEEIwSfP5Z0ToO56kdlJOXSjww0Xz+Q9JtJjGD9GJPQBozQH?=
 =?us-ascii?Q?cUSjo0/lKCK4nyq61b7VpuMaM1picLc80bCW/m6Glad/ShETrgvA9YKn9B9l?=
 =?us-ascii?Q?vcAITMJ610NfuMQmbiM/1uyPIqRgvzSnjtnyEHkrkAiPVwSJmBvaKIbAYk4i?=
 =?us-ascii?Q?ZOCB7QAYzEgkx1wW1V6cWXJhu6tcmNXi1cQP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/intowguZMQmOWBsLpJRzxBn8lCdGuCNKXXBFWgz1dn/KO0A2RdcNuh4HFa?=
 =?us-ascii?Q?ywzg5WwN99AwCwOADQCPHJfjOdNsfP8SFz8S9+U3RYkLBXDFYBeMds+VgcZ/?=
 =?us-ascii?Q?skn6x451DW5RRFVF4CJn56VkNu9nL0ovXR1OrW4o66ok+apoQt3QWt/1KjmE?=
 =?us-ascii?Q?o8NS8Y7gpyhmd1RdOWbuUCafEGbOoW0HY5RtFd1pyQG5xB6PN7HaVLvbyqmY?=
 =?us-ascii?Q?j0WthAIB7SpfC7lvaK1c98nk+igxhgn2LechwN7N4oqzkG8yq+TYVLVLsSIO?=
 =?us-ascii?Q?aQH6eHup5XwaFR3u4ONuGOk+04VYl1T4fgbJ490SvzVBwUmB+MSjd4O6hxpY?=
 =?us-ascii?Q?LVmyA5JQ1dlPBfxxMuMMjIUHeZk/P2+DYhvWJh5cmoN6o4gCr5c8bVWtkAjb?=
 =?us-ascii?Q?PZyZes+o8rRSrbqhYnZ4UE9m8y6TBgYRE8AHPvQ3x0eKsQb0KooHgG43g61e?=
 =?us-ascii?Q?yRc55qSApwfzZ7CLQ/IOi8wcoKDI3GDxcF6r5q346rCToGiU/w2M5fo+r258?=
 =?us-ascii?Q?9nAolo+WgkyR70FkOpZzJ2FgXa50YBr1eEq2k/hNrSH8IxxAuCNJsT1JTvrQ?=
 =?us-ascii?Q?r16vtzXbdDiqo83OcKxSNnWT4NU8/4HDFOkZ0Q8JNqvGZLLnF68RsNeE1qnz?=
 =?us-ascii?Q?xwG48jFcdbyqOl/0aqqaa0EOkHef8oVHi+GY7fOPk/L4OLphctqDywjaQnZs?=
 =?us-ascii?Q?kga8/OtCrWHIL0xNaDmGhalw2Dql388uFUmCHM3HschCQlkZeMKPVxelHfxC?=
 =?us-ascii?Q?MgO30hDqRrdMbgqgz69BJ7zmjkdmv73hprrfJKDPlbdJsk4WA9lK2E2qT79c?=
 =?us-ascii?Q?l5m5q6wmcINLXQ67VmDYK+/b+HMe1885Sbl4w3tbxnKN0spBXkPKt70mO3GG?=
 =?us-ascii?Q?+nzqi8VuJ2yT+z+ZSQ4e/ZEqNKaALMXA7AbNCRQLhiIKkuXNns0UP4XUSixv?=
 =?us-ascii?Q?6Gmp9DKXrEmtytZ9APc4nIbQ8yW9Dct9XjrRI0aoP1p5BZ8JUKvXUrNRfelo?=
 =?us-ascii?Q?V7bXbhzNa7jYG8ngOa+xcKBI4JYHc/NGTI8DHg3n8Y4SPnmwi9FzqO9WZd2+?=
 =?us-ascii?Q?L/lPR8Fr9rmHYC6A5QZ7jWSYqpRTJrb48InTU2XcMy2sL1vVmQ5dRSGJYH+l?=
 =?us-ascii?Q?pbXAefjgtgPgIVLvSjVgmp8aeyedcbbU0WvR9cAACYDuSLejxrjGX/hf1Z2Z?=
 =?us-ascii?Q?MnQIhTnDCilR7NMfNWbUisSxWvNlwzPwHSUk25XGpxXAMWY3BcKT3jjBNXXa?=
 =?us-ascii?Q?pkMvPoixTVzLo1/TwUeenW8K7fd9ZYtWYnovCHEAispNZkNV2YhElpNLxWgj?=
 =?us-ascii?Q?wT3mpDr/SUGjOky/INmPS4xvbf90CcZmGF6rM45buOPdoN4luBdAeuQLF6N2?=
 =?us-ascii?Q?RPCFY4c+qHy5wv9upOJ+YBDcxwBJpQs1/zM4XLLWf6HyVEcXrIOebQVKLXyN?=
 =?us-ascii?Q?Pme+DbXqQ5K2tnlnZM1ddalceqeA9njyEDJ1rV7YcD+fl6ZMx9oSHCFwxAL5?=
 =?us-ascii?Q?K6XPH5e1bWCyalybYhP+cIZnO1SIvqc8YXfZ4kHvdJxpL2CUH0b8/mXgzLpz?=
 =?us-ascii?Q?gSFma9/aRhHS7vH8FEzkxCncaV7P16eUXWIKeUQGF51jjOHaw1693p/gcUQS?=
 =?us-ascii?Q?+QnCvETjxq5bZLVI2Aw+o58=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a473c95-0dea-4af0-bd89-08de18dfed85
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:17.6586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq1mgP+RaZZ9mdiPpm1fqSHlvabZiufg18UDP4eP5eoUUYperNG38Wu9UwdJRnW+hnpq2Km0tIAHA6yZSMAa8YILpP+rT0iV0d7eZEv9CKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

Use common helper to get CHIP_SCU registers.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/airoha/clk-airoha.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 1b2c4c98de5..8e2f2c08923 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -16,7 +16,7 @@
 #include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <regmap.h>
-#include <syscon.h>
+#include <asm/arch/scu-regmap.h>
 
 #include <dt-bindings/clock/en7523-clk.h>
 
@@ -400,14 +400,8 @@ const struct clk_ops airoha_clk_ops = {
 static int airoha_clk_probe(struct udevice *dev)
 {
 	struct airoha_clk_priv *priv = dev_get_priv(dev);
-	ofnode chip_scu_node;
 
-	chip_scu_node = ofnode_by_compatible(ofnode_null(),
-					     "airoha,en7581-chip-scu");
-	if (!ofnode_valid(chip_scu_node))
-		return -EINVAL;
-
-	priv->chip_scu_map = syscon_node_to_regmap(chip_scu_node);
+	priv->chip_scu_map = airoha_get_chip_scu_regmap();
 	if (IS_ERR(priv->chip_scu_map))
 		return PTR_ERR(priv->chip_scu_map);
 
-- 
2.51.0

