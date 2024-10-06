Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C9CFB43F
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3199688B0A;
	Sun,  6 Oct 2024 01:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FaOXZIim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EA588B0A; Sun,  6 Oct 2024 01:19:15 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED7988B55
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utIhkp8efL23g+DCUQv7XzNsgdBJB7pdljVEn7T6JB6V+dgRO36nm3bPF6MGNiFEAfSHzK2NNhL6uBNB+rdCU5PmgMPaID5h/xpja4gKX1TKb53t5CCOuie7+j9AugxWMDR1JPJTs4a3HJh1w6HXJV2WSuBjHHqdEXg4J7aXQtOrNgBzMceZQD5wbaaxiRR2AN8vau771ISuoW4DeOIp6IAWkXISa0gXEcKXoCWs7ZGnjxUadWgSWpDjln7/0ZsF8pv550hZSBZ/8NWDyrbyS69kC+o7mC6BFusn5FpoiU7GFpRvmeR3bLs+w+4hLxbmwtzuIB1un0CCvpj7kqkMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQzaVs1KVYxPFZltB9PEPAQ6hJ2AYyI4dvdNLYV70D0=;
 b=TduwDHHovKHr1UOhdqIhDeD2qp+eG4/k9+O73B7xgousDv3HTwxVV/QMVC/uib+J4iRJJsJkVHGQKiqxWVhMJlCVEj5dEoU5DbTNnwxi959kP2L0mgsBThAUcX0P11Z6461rLyhcfrq7zwMZbeGKPatEijqAOo7AcpakcpMVfAbK8C24MBYviZFBWlhukoVvDWtUE23VeEU51G9NFux6gPzTQBq5120iFitODnX0Mu/x59azhjBmlaWDS5tyTciWizkoqErx0PBMGVy3vc3AFBNDy0FVFnpXI4k5EX7dk5E6ymVv53TBMkJoCdCxC+bnYdVoJU3/izU/eMaNKJQw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQzaVs1KVYxPFZltB9PEPAQ6hJ2AYyI4dvdNLYV70D0=;
 b=FaOXZIimahctPBIhCwJUbomvPM+yjPVyEjW06lKwJUn+dO/k3tWJuv3A6ZctPxletoqMYhum4wYNyMgG/mFnHRgthc7OMZ23qgMB1uT5pJmn8OydLZfsrWTERO+4l5dL+CMnklaFINW5Kp+W1Q04RnV8Ak2TkUPJ95q9K+7fyIETvSAXx2DNdUW6INPnTPAAwLcbboQUNscb09CGPHQu3TXiTrZ+KlaYWGjnXStATSI2ndKg2Xw9DRRwS05sl5u8t6aS3C5yVNDgGasTzGCxi7unDELR3xHgmxqAiLFsjViVxNwGGBb7WFtIBQTr7981y1oA2sue4VQ/Wm9SyOAdHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8104.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 23:19:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:19:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 2/2] misc: ele_mu: Clear RR when initialize MU
Date: Sun,  6 Oct 2024 08:22:51 +0800
Message-Id: <20241006002252.14895-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241006002252.14895-1-peng.fan@oss.nxp.com>
References: <20241006002252.14895-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4be6e2-2bb6-4c39-8810-08dce5941f2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apZGTtmk8dmLtVYdiVpH7kGOto2GO/z/WmHHMlihsJCLE9RQorvqbxXc0tcY?=
 =?us-ascii?Q?nevIdpuEbFVNY16pyQ0et6dguEdvNHV+K9TClHsOiRBDUXJIMSVh6phKg6P0?=
 =?us-ascii?Q?zXGYjsjRaV7/nLWH0n8RX2V3MAyeHHjZ23tlWF0ugrdstUDf6OVRM0TB3MLD?=
 =?us-ascii?Q?0yL/x2ryDiVWNm7SN8HhN5D1BpYj0trFissNM0hsmF2abOjuJ/PVW/zVtBiC?=
 =?us-ascii?Q?ewITIKTfSM38WrHgx0Rh1J7ZKjhA2xy8/rV+hcPT6A8LKvkFdPCwHQr2c4+P?=
 =?us-ascii?Q?E76uh40odIwsX5remrhKKib9K1Be0T+UFYtQnlYKLpK69mkkiG4/BlzpK2S0?=
 =?us-ascii?Q?CrBlrf2J3/fjstuUm9nq7wSTpylFungH2YlXkVSqkQJK5g6WTnyxcjEimylM?=
 =?us-ascii?Q?BE897sqkxP1DkwY3GKehP5zJOncBD/dQu0msgk11BdTHqkvpCmZ7STk6p65V?=
 =?us-ascii?Q?0AQ9ozqTEHb/M6HiQTLcCmRNrKk9zEGmkM9Br0CR+lVS8I+7pWYk8vjtZx2H?=
 =?us-ascii?Q?k/vNW+/49OSeoh2n3vaBZNQw98nk9jRdc/qe/DEJuZO+CxbcA28uvFbk/hkU?=
 =?us-ascii?Q?vB4D/O4Yj4JlaXCeOleKgl+8BZ72y5ND1lsozlp34ZMRFlVZ/prPXjATg+Ew?=
 =?us-ascii?Q?fJSkreInlaNcNa/0TTVevcqkCOtMZaWeDGi0fYlt5otNoNiI6oegO+SaZSTb?=
 =?us-ascii?Q?dUbPbrfdhk+N1e55PptLY9DpHvrVjnDFP72o1Qpz1OSkg6a4WGhjt0X+lENz?=
 =?us-ascii?Q?iLBuRi1XpWnojmxHA+++F41s8fJ+KP0pOW/NJlvAEkfOBORtWvDwGKNuEvNf?=
 =?us-ascii?Q?/qiTr1XrQ2OPVnXSrm0CPgeOsyhlewRnSbyHpHT8smoG4CIRng63CCPGgjOE?=
 =?us-ascii?Q?HOkDXrBuz5wNbpKcfCb7wyF2ZcybuslLcNi2vqZogCiXS96CacSuMzRLH4TM?=
 =?us-ascii?Q?7L4CEW2T8pgYQFS7dSDvRYqRalu8GVp4S6WIvgSp6aPQXp04G9scJ0nYoZZM?=
 =?us-ascii?Q?oZYfRjp8QYY+fFdm/NP0gi34zYgH14f7GV7zuS53CUvpmZnQWgoo/wb1bqb9?=
 =?us-ascii?Q?NUckdGVYSkBtRD2pUAy/XwXQTCZdSOU3yJvF9fqiB/jH/BwwaJBOh0DnHoRV?=
 =?us-ascii?Q?J4SIiBcdiMioqHYGBxWSu0IvOtQOtxtmBFuUqm4HDmBpaeE4RF/2BPUPeYQO?=
 =?us-ascii?Q?w20j6ikC8LqGV9WKWtlpGKjkJDWGi8nIawZfRd9Zk4RjpFd1Y8ByVQqMSjnq?=
 =?us-ascii?Q?2wujjKejO8fFiJqscLb36MwRbnTXc0r1Zzf2Y9U9xT8S/dye+x5dKKkVL5c+?=
 =?us-ascii?Q?R6c5Q7Xt5GUesZ0KdcNsmcMPdYJ/iyffb1SusKqLkSipfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iY0hbUh6YmtckouUFrdTaEg50WtxFrTPUTQshjcHu8KvKCxKTjyDfp15rH5/?=
 =?us-ascii?Q?KbZQsrXkdFeiN6PVA8FGF72KVqrb6bhNVjnnkCS74YOKo1Lc60CB9R3cUJmH?=
 =?us-ascii?Q?YzokUCrR/TamubLLK9LrAoVLfgf0dSLxt1huKEW5sil/yRlClFCqv8ni6Jwf?=
 =?us-ascii?Q?wDnhLX01M4KHX47L+miNV/aY2jxDKACXoyDNPmGzAjNX3Z3OoYsl0Xdt89fA?=
 =?us-ascii?Q?2Ci71nkyYWEitYDGCAGD6jYF1VnIb+X3OPMdIBWX8vkJH0Zhe3dHNLd7PsZw?=
 =?us-ascii?Q?bjz2WVN1z4fSKqzvtcYtUtp+XhQurt5j82ZN1+NMU561yH7kaQZtObCQk0LH?=
 =?us-ascii?Q?f6TMN1vKfgD0lRt2qXg03gUi/r6i+e6SWlV2+PqDVUdtkDPNGwYlXO2NK30h?=
 =?us-ascii?Q?fgN147jvfUdZGNMz4iJqKTzmR6ieSJ7I4tVRwfCgMV8sj1s1bsUaHCGaQ73C?=
 =?us-ascii?Q?HjMC6ok26Fm/7c9s/Iaw/V2DKjA4FYBIB3f/nF1itfslxVoY5DPboY+c3kZR?=
 =?us-ascii?Q?UXnTc6FMEh49nOmX4EIIfaR+8Tl7XUB0hw91l4RG5hRDmjuf4LCkXo7/LtZO?=
 =?us-ascii?Q?sGadT8yP7F2CqharbK4Y0cCmFbtXO7SDcqNlWP9Q2fmCzwHWAgmSNfoR8ft2?=
 =?us-ascii?Q?uGG7yyElolWka0kP2eUkhfudPyV3Rkmp8iRk7djBaCNTPHB3XcJstf/Upjty?=
 =?us-ascii?Q?Baey6p4UtvvrCH1negzAqNndO0CdYkpcopBAOfuNXl/HjjBOhefHzGrOVYbh?=
 =?us-ascii?Q?UGtepFHwazvY2valMhiiBG4RO58z9uDWGoRTyhNL/C7YkkgAK8SKXOvKOo9I?=
 =?us-ascii?Q?m9dMiY6CtHso5mbFOJIo0Rfr+0GwfaLJkoyOvx+X1sKAR7ux7kUvS/Wyc5s8?=
 =?us-ascii?Q?F0EBjqxcYgaCJilLzz8bmPsePOTSYJAUxKIAmgRApgQiNcm7ZRlbWblIk1K2?=
 =?us-ascii?Q?0NamCH1nEpOw4DF5w5WdFbVYZsSAu1tckoug03uBTA/QnVtc/401sfKQrgwl?=
 =?us-ascii?Q?YOEyjrsW+DtOS4PwB4KrHSsz+wtEo5P127bzlthGmwRk6tnsX16qx48ooVqU?=
 =?us-ascii?Q?9Tpi84QIWcm1+hgVH4ETQTqL59Px2lTuaFwz4qJ5U07L/waHUutRuk5YO7nt?=
 =?us-ascii?Q?NJxrM+7UW6FicQkG9rNs2WxYLRPRikKKJ8VvvzazGMecoJFf0HamB0xIv22z?=
 =?us-ascii?Q?wPqU+QJAwuWW1JrZxXVOngozu634JjOIP4ZJgo3C12V5Y62ZQHxzLEG9zEDO?=
 =?us-ascii?Q?kc1ooHgCKNLlbgFmZJIwzNRrNZFhRZ73Ypf643G65D/yCyDkrQAnMphX4Gcw?=
 =?us-ascii?Q?nfgMOighyDnzidDKdbCBoEW7Ibw5lO/5dBo5O2t3kx8Ve5SvSlurFIr8etas?=
 =?us-ascii?Q?ZzuKzQbaeOIMCs31xDxqkLnxKM5JFYMYj9S+uYMsBGZIUxSt4EwPQzhLEZgg?=
 =?us-ascii?Q?1rJGsaYc7PafRGWkuzRHWl5TNLZouThVevrDEYwmp2a+WReVbwGa74jo4Zix?=
 =?us-ascii?Q?ZlfZIZftPGifqgM843GQcUyzIs5zb76XDXo6zNNwbScTt5ZCk9kdQp1ZdiHa?=
 =?us-ascii?Q?8yAzjbkwejLyvV+66apYUvybHmUNkAE9LGtmvlZM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4be6e2-2bb6-4c39-8810-08dce5941f2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:19:12.3758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce3dsezkSIQ7QCgdO+QJv+eYGixTCMdsDAxgU1O1L+fy9P0r7Qo1aff1L29DxOSEltZ0QWrIiHOmoAjsyygSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8104
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

From: Peng Fan <peng.fan@nxp.com>

When OS is doing ELE API call, before OS get the response, OS is force
reseted, then it is possible that MU RR has data during initialization
in SPL stage. So clear the RR registers, otherwise SPL ELE API call will
work abnormal.

Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/ele_mu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/imx_ele/ele_mu.c b/drivers/misc/imx_ele/ele_mu.c
index f5ba3a4ffa5..cdb85b999db 100644
--- a/drivers/misc/imx_ele/ele_mu.c
+++ b/drivers/misc/imx_ele/ele_mu.c
@@ -25,9 +25,20 @@ struct imx8ulp_mu {
 void mu_hal_init(ulong base)
 {
 	struct mu_type *mu_base = (struct mu_type *)base;
+	u32 rr_num = (readl(&mu_base->par) & 0xFF00) >> 8;
+	int i;
 
 	writel(0, &mu_base->tcr);
 	writel(0, &mu_base->rcr);
+
+	while (true) {
+		/* If there is pending RX data, clear them by read them out */
+		if (!(readl(&mu_base->sr) & BIT(6)))
+			return;
+
+		for (i = 0; i < rr_num; i++)
+			readl(&mu_base->rr[i]);
+	}
 }
 
 int mu_hal_sendmsg(ulong base, u32 reg_index, u32 msg)
-- 
2.35.3

