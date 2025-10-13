Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAB5CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 03:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134A283839;
	Mon, 13 Oct 2025 05:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="L0rhRAIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2195837E2; Mon, 13 Oct 2025 05:41:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEEBA837E4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 05:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6AIgzVg75qcBxncb5adS6BD+pSlVcqgbiMbIfQ978ItGg+2k4JsZZxcu9Bv0bEgE35sJBstbEKGGgNqONXqe3X3bO0eF9CSq8YfxqG92Fw0V/Z5VD+p9o9/g6bxedldMqh+xYKlm7UzOdLZtgAARV6W5g7Tp1QzJUODMlGPPi2egDEDqaZGnLNyAaGpkTvfiChR++Z8CJb40TgS2wkLh66nUaRjszGXfKb3dGk1UqRs8+87nuR1R2Zp+w7Ypf5dZ/rzXuTz3hcIAGV60PuA8J+s5Ng4HXwXDbzMf1Zslg6SmkiWBo/cCycAWacisGP2ALRxHof9LLk9R5lpTjumVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wQW7LEKZXy24eXDWIWArlANZ16QmnmvfNSHmQHCuZ0=;
 b=Kv+AOEmmRhJJj+W1HQv789qbDf3HrlEnpsLcbMCxL84MUWGAVUzUM/dBvhixJTYo7O+d+IXpsF2UczF7NKHD/SjtxeVyZbAZEzJmdPDeoK5jbAOX4liOGZFTbJ5rNm2O3MPOoFvN9l3kcMY/6sh5QfnAv/gAo+cIPCkrxjIgD+m7K3AEZKIaC/Cx+I/L+WvwymqmTk5RNFLR92gyz1BUekcNrsyQBbPNCXoRZGZviL0X/p1USd7/Qn5HJ9SXYcnLqVFY1lV1VwTBWa4/ULDDarXG+PS9MArTIVHvYCJIhV2qo6fptYaVOmyz6ztoO4cgu59tu6LJzKldpLXYB8k9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wQW7LEKZXy24eXDWIWArlANZ16QmnmvfNSHmQHCuZ0=;
 b=L0rhRAIKO8hXzxSV9PMHpIk0MMFQbP9Xa3GczetPgAZbONc4E42wNj8gJ7E/A+zWpFaKZ32bpDgvYE9r/uyJBrVwiw2uj2kQsEWMUgwN2SfwbJYNBo2ymNfyQCVNbZvKUSJCfylUB2/9hhww3XEs+zzhaZF6LV6lsT5O89mtyfWAe5rFvtq15E2uNOZM6+AmCJD4yHU10b8bel5c6A01XLvnW3M/9w1pXI7lZ0J7zXnlaUkF2lg8BA7OEUX/i+ICVVHhvSkcP5/sJXFKmtVTGyKuh5K5kyLhiYtOOrsoCXPRMlC7ZbM3LcNXC4sSsjL+HLX/0lRc0XxcjkKeLGY08g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 03:41:54 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 03:41:54 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 1/3] imx95_evk: Share the env file for both 19x19 EVK and
 15x15 EVK
Date: Mon, 13 Oct 2025 11:41:26 +0800
Message-Id: <20251013034128.1752157-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251013034128.1752157-1-ye.li@nxp.com>
References: <20251013034128.1752157-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 34124529-0c7d-4bb5-e033-08de0a0a7338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4CF8mBGE6lmHlkmzP8g/jgk5bK/2r4AwlPVKpIu1KE1NqumONeUhQx4RyzjB?=
 =?us-ascii?Q?Yf1CBpU3RkntizJ0uyyRufUty87XGVxMH4EWihVmra6rcIByJYOALTXmINIp?=
 =?us-ascii?Q?f1vRY1uLl8nzAm+LaPSy1eN497DXqOzfj/HYlFfrsXNyM9xYdI8NZZ4tTpal?=
 =?us-ascii?Q?QUiPNEPgPDYqR/JBQMsiGBcdbKRcme+d4QZmnmFNSp7HSTN254RhFIQd7hCN?=
 =?us-ascii?Q?WJK11VITYdiGATa82EnIqXgBF5cphh6BzaQNTElmRC/f9qNazHmEptwbLe0P?=
 =?us-ascii?Q?OENV4GGkMpimuNMQVBytkOQRocJrK3UKPTrWqPRafGrvmXwGkYS+sZ2nKqFB?=
 =?us-ascii?Q?XU3cjsBgsPvDOie7P0WttC9UtSgvobdUxxWErokkfEh6IWEEzr41Uq/6rFVm?=
 =?us-ascii?Q?yRX6VHGHwuvOa6ugNEFQtIANavnDC4/TOZdg0pJ24pJf7Phaody7UEBIqwjU?=
 =?us-ascii?Q?a/9K5fupQuiWZ5fYNCeQApPLn9duX72k7l2VBXWU1m3vuGojU1hQA7uvaqyW?=
 =?us-ascii?Q?i54qE9tKGPnjoJmnrI34H/S7jpHxyTV0i2X/CgB4ml2od1N/gG0Z965N/M37?=
 =?us-ascii?Q?NAtQx3oOG0jMOYEzfx3eZCIsnUBW9DuxYN8sVZoblMy871KBXJtXnILX19z9?=
 =?us-ascii?Q?GseifOPvcuvhWhu2cCeh0d8tQn/phnzEWBYaMicmiRqa/MCMHgp49JqCQtF2?=
 =?us-ascii?Q?W12RfvdYOx5smJGnjWv8gP/cEIR8SzEgaUAtU/hDzxb2NN4ucMH8QKte8LZb?=
 =?us-ascii?Q?LPHaq7ECh5zvhGzbIqr93N6neq1mhUXMgQAgQkWaSv73l5LHDvxAe+gH7/Qf?=
 =?us-ascii?Q?TRo1PhkswPuKBwj2DOIXsuFroIhWnsHR83PnSqx0JJjohfaqRgzXQ0+WcEsl?=
 =?us-ascii?Q?JmmQ1CGtpieHz9Tj2u1dBiN9yQscODfQ94mOMSC4OjJVnEbTEC5Asily9Unt?=
 =?us-ascii?Q?XJY4aXgR3obcIIL3eOcdj5HNDfyLLNCNpkgr2l5YQoaktY+N40RqmSeCXbEH?=
 =?us-ascii?Q?R3ctu/7EL8H7Yame3Yy9gYRB+L1qpAHlKt3fX20ahR1fXVEhMfiRTL+zNibe?=
 =?us-ascii?Q?eOqvP69MFl546BLF9qfbIbLYngUtR72P6S668w70Cfmm2CGKyoLJr/QKxR/8?=
 =?us-ascii?Q?IkxXVdoumrADJtxDygcow/MlrXSofJAAvqSaOLO+MNUyeQS32Blhn3pdYup4?=
 =?us-ascii?Q?xFKAM3D49qEF9QDHqUR64Swawg4nRmqZQx2PuX/JHwsdLQLbzTU11BxZar2X?=
 =?us-ascii?Q?FpJmPJzTKcnntdjmwKploHO7JKlQXCw506tR4jx3dF/uvrSvk1KAIkmkgQg4?=
 =?us-ascii?Q?sRt82/w6SUtJn8lLmqS7mD2oyqnu5+U1PysB2IDfeuyzbTWcjZJKo4B9vXWj?=
 =?us-ascii?Q?C23lOrZpF0SVdYsvGK3siEdOrPGDXMkvVEYfb6VEo/I/+cJgqOh/WsetAtv7?=
 =?us-ascii?Q?y36UoQSLUuMfBAWXMh7xQYALXcZQiTqQS6qVesjQryVQhYrsY695Y96Zpieo?=
 =?us-ascii?Q?vYy3Vb8QycSspRx6Xr5ad0rCc+MVLNKKbA+i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrCqa1PlcMl7OvA2jv2KphGwAhgpNmN4Q1ZpVYi5NSyead7TigXhzk1jRs4k?=
 =?us-ascii?Q?IFPGbfuE6A91OEVPky646q010ITi5y8EzjjTBpYzz5YvbiGRyvFJI7LvgyUD?=
 =?us-ascii?Q?/qwdRKx/KM8/URnYdxzn/Ve+wMmm5mAnvxbgVY3vE3IeEodCrlXgCfx3qXv2?=
 =?us-ascii?Q?PdraHhyexEzgcLP6uhIMWkqemDGx377d+1M/b47tBnRzXwLYFUbvFtRSGgP7?=
 =?us-ascii?Q?2sPl9KvfCU2IHjLwEKifLk+rBY99GnO/odMshHv1H8SVwjsG5iojzpan+Gng?=
 =?us-ascii?Q?L0p6d0W5mJSSdISbga0594L6SrTR6GEyesqEsDCokdhwzOs3tCrwI/+eM9Gb?=
 =?us-ascii?Q?KGgufkAGemDEjzayJolMqm7t3j6gej+MpimCV0SpFpcfpyq82g15nciqaAi+?=
 =?us-ascii?Q?IInYI4LWwSPtCi6qKNAPuRq0K4RDdda5vcYsCX1lgHCkekl6R3BJ3gOr+c8T?=
 =?us-ascii?Q?+PBVao452adeXN0q3QP3QDTUV8cFAo2bGAacLhG9VWDsI78MSbjrPE+L0CGH?=
 =?us-ascii?Q?CT77ruZhIuO0E9ne9AIWsf6kzxdUwFKTWgBQGL9scFoxP9DtjtDTL233uk2D?=
 =?us-ascii?Q?50PrZlIKK8uP821Hu67XJHnTOseFSQxMGI6afrbcGntFRSx5//rchcPmH5Fn?=
 =?us-ascii?Q?bqH/he93IOcBKPNcKB574Di79Lm7tNjmzC6vl2ig7iVzGkfWzAtGedExJW6P?=
 =?us-ascii?Q?jsF2/ez8BiW1LnmaBm/I1xc0D4EHt8nhnu+oE5lcf3NVJ6qibk23UHW2FXon?=
 =?us-ascii?Q?J77fZHvMGYwGYuKSGMdGBbr/QGFoW3i45IHWiqmUVkxSdkRu3SGHimE3VIpY?=
 =?us-ascii?Q?rqTVe3nFkPPDstH+Ge+P1kj/yzU9W0pNOii8ombfoJ7p4ov4fflbgolUS1c3?=
 =?us-ascii?Q?Bxwwmr9IJMnb9dmIU1uB0e0HvMusljBLZoX9fcRisfp0Mn6npr4BeX7Lvv2g?=
 =?us-ascii?Q?41R/GwxjWGdNATDyrh796EosO39Zi9HzM0vkk4SIRRknyrY7wzeGHssvuwxa?=
 =?us-ascii?Q?/hz+64ZwxNulAmkFTnb2hhF/Rp00rKIxihFWMnGhA4M5Z2EyW/z+DMUnWPWy?=
 =?us-ascii?Q?7hC1AOY5Pvuut4315+dyBSQawBdrLjYYfttayqdS7PaAT6P362jY17tMRKir?=
 =?us-ascii?Q?OzJ/MsRqrr/AC7A8WIFD/nuBqTNPejKkrTSG5ulNVnFJJKGe8qtf6luJYqai?=
 =?us-ascii?Q?ltUQVh/YWKtUzatVw928JD34HtU1TuN9I2zuKr+tqtyuxu1E9vTr2wBy/5lM?=
 =?us-ascii?Q?tSzFmbIw4jjJP9eRDbniI778AVluxwcvk4+f4QD2r5yzT3mrpbi6l5DuR8pS?=
 =?us-ascii?Q?8IFUfuFHakgmWcg2uyfw3R8dKs78X0SgeNBTxVsxpJ9Xx0eSEcIWCW29TJQf?=
 =?us-ascii?Q?7bH4tLL0slaE2XTlWYJAK5tbq0hocIanyWeBbuIIoh6EBvU4qK7BgDN9WZoz?=
 =?us-ascii?Q?58c79ARPTy89T51NIuAysOf45Tk3tzXu8gu6hNyZu3zIQ8eF0aiR90lT8Z1E?=
 =?us-ascii?Q?CkMynt8ml248swLCHkOTdSCodvoDs4a6IyoOKzCOrx2JK+4TwIEUa2JEtgrJ?=
 =?us-ascii?Q?dm68RY4AM1I/YXx1zSM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34124529-0c7d-4bb5-e033-08de0a0a7338
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:41:53.5832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpmNsIKS9NcqW/n+pBPZ7bd1d9e1bmk+e8JI55EJKUFx/MJF3f7JuYdqN/9l4qnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
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

Rename the env file to imx95_evk.env to share it with iMX95 15x15 EVK

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 .../freescale/imx95_evk/{imx95_19x19_evk.env => imx95_evk.env}  | 0
 configs/imx95_evk.config                                        | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename board/freescale/imx95_evk/{imx95_19x19_evk.env => imx95_evk.env} (100%)

diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_evk.env
similarity index 100%
rename from board/freescale/imx95_evk/imx95_19x19_evk.env
rename to board/freescale/imx95_evk/imx95_evk.env
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 231b42cb377..631ec23c335 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -7,7 +7,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_ENV_SOURCE_FILE="imx95_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
-- 
2.37.1

