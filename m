Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0EDCF6491
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 05:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45DE88D5B;
	Mon, 30 Sep 2024 07:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZzrIMj1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7FD88D08; Mon, 30 Sep 2024 07:47:31 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A673088D54
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQP5xsrcDna5SH64bckGY6mB+QxkHzv/BTLVpMlFXexFW4v8tFEbDDzyoMjdfSY+1WipYBEn5y7evsLJRlZLP/6fo3J0njhcsSBA+CRmBkkI5GFyI4dQSe4G2SzwmPChrHUyS7461I90Bgz6/nED2CiPUs9o4fudYoCMPbibSF/WMbEfD2qfBu3TZoiEvYbjUsp+2oxZFZf99BAxHSTadgXaCpCj45yQ/h9Y69r13PtaRIieuiz6RZn/S2OpzweWD5oroQ4mIFu+Fd2r7i7v6m71ADXTMcgvzKNE4O+OL9yQADILx2gSiG8wy3iw1FditRSPAaSALDegHQfr6nBFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff12lDwpHfwXbDfwC7/xj0R9E7OcOskTrnBGWP79x5E=;
 b=WM1njNBPI47iWWKuI3fS0VHPrAWLBbWczMfv3pR3F1v53IqlJ/TJjTmjWDBn/ilCvD7b0TK+DE/7YjOjF1hUgbUW+7EgdXRsSFwA9Pkzr0Sl/MNz1h/oD36ewbEznrEstQv+JRQPorvI6FUU8t6u7TzWdKGbr+g2FifmDlMWbR1wFxLuaIrzoJk0+Qd/XvqPKwwXiqYolpaAMRBd1QgGPvUavEE1NYFxnZl3B9X94wqYk4oGaabdQRxuoCGOzfBwcHZQa4apsENNuCicKOyOrOLQePR6m7av6RxsvGkUSddBTCuy25Mpcs4mwp+BoV/hBL4WPNBYdfBeIqkjstn1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff12lDwpHfwXbDfwC7/xj0R9E7OcOskTrnBGWP79x5E=;
 b=ZzrIMj1ytK+l/MDSngaleUbnKyg2LLvYHdXP8Bxmcy8He0ARfTEexsGhfj5sz1UpIBUwiJ2QrORivYicAHiwrX7H+GDiALGez/iacwyIx0L5Ow9snJkZZYwN4ZoHkO26vPNCNKQBYyHLu+k+tb94kr+nZG+AWuW+WmdiUTD/GYc+DKNELMUe9LncjJgwSew0kuBpBGqbktl487mlLQCIdSJR6X7JBrQsXZL8NZdoXgJaruyRFm6ATXN26VsXVHgpFsPFrDa5v5fNhfnfmPV/XTO+xLAdpmCg5KGcw9wDmaEDbDoiUCHegoHCEpWjPOasdD/jOtmP+6N9L5tLmAzE5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:47:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 05:47:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 5/5] mmc: fsl_esdhc_imx: Reset tuning logic
Date: Mon, 30 Sep 2024 14:50:41 +0800
Message-Id: <20240930065041.5554-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240930065041.5554-1-peng.fan@oss.nxp.com>
References: <20240930065041.5554-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3705aaf1-0b78-40ef-a05e-08dce1135df8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?38BV1/Xgo4u7CLB9uTZMg4XkHjkGgIJdQCNt5In28ODky0n+BDoSq2mS5l3g?=
 =?us-ascii?Q?YZiOnDqKrZROlaXxgCFfrV9dgM1T4trAaukC6rTpckaU1p4FDiYITxZ2PlrJ?=
 =?us-ascii?Q?ZT0VrHupweZYsbBNKx22fSfe+rrnPO9Z/jJsXJFxQezHXJw8SLUEax3FYYeh?=
 =?us-ascii?Q?BHPRY/fPIz3tqwSbmy5EVXV+mDygRubGp7hXUlxzqPkvrEskpG9T6Vv3beaN?=
 =?us-ascii?Q?V5kPne5/qvofRTkc1fjM9Mc9ipyJbI9QIvM/rcm3lwmOIzrLTbOU5TRZOMyO?=
 =?us-ascii?Q?jEo4KM5/Y897IM/EawGbKLuumpHNn+34bvUkBZ1smJoEatitzWY1ZMJ7kSys?=
 =?us-ascii?Q?5PQFKZMrjjFS6BW5VaQu7VrDtvfVu287TVd1tWtUkBmdcbPu4IPIGxiH6+7Z?=
 =?us-ascii?Q?s96OUddBDpcwbnou4FiwTrdOG+Moe1Oezd1xWct/BBsKI7/UUBCF+YDmFyds?=
 =?us-ascii?Q?+dvQi8bb/pfKCEFYq7sgk4H9R6cDvlwmv0/DLtglqxhAyXndVXwCPz0N1OOI?=
 =?us-ascii?Q?EpbbjDCp/1x4EE2zolgTliFwBqhEjXULDc68paHjEPdlwUs2ni5bBb8+5DmZ?=
 =?us-ascii?Q?YqU7zd/6WpHyu6/CQ23HkI81G8LPn+g63Q3YRx4N9isNS+oXrrRLu1yGu69f?=
 =?us-ascii?Q?8qmsVGv9H+pk4c4g64L2YyWykDKA30oWR7eMrKMH2CYWCB2sOaDXEhlN7Rqq?=
 =?us-ascii?Q?bNbdAiP8VdIOgjk1HGMnkRPXjf5tPnW/CzB58TcFtPM5/Iq6grh6jbab+e7J?=
 =?us-ascii?Q?W63WhNvDxdVumo5Duaa30M0sJWyr4nsXMIIScvnqhZ8OboTmQ5IVke2kSCss?=
 =?us-ascii?Q?o8n7PvaIIM8VpJTC54PPffnHGUo6Feat2Hac7kT6XO+KtqEhhUgI61AyXRkG?=
 =?us-ascii?Q?UjO8mRCW7GWwhWEj3nv2ZRIngOMoMmHsvgARqKbThgDJNM7Ltj0lWczxbL+i?=
 =?us-ascii?Q?h5rYyMrOJm4+3XTDhesZMBtumfvF5JlqYqAai6pqn7KiMkQTW0PZhih8geHN?=
 =?us-ascii?Q?oACgeE1GAYaqYbgUTLbEdI9wqNGS4gbXUg97A0LdneVhXZQnb8N/MHYLiwrR?=
 =?us-ascii?Q?9uTcpk4JCLjeOrb0m+gkpTHBgDlANlrhEF80kP9JLEL47qS1Q+Vezvs8voJg?=
 =?us-ascii?Q?rxYdhHra/Auh1ZirqMEn3kaPy3o6yxwc1g9PWmVVvFZCzbaiJxU7MIvkj5U4?=
 =?us-ascii?Q?jI2fuuymRMu3xbEdyz2uGVhJriCwOq7ihtreC3ekwBmGLSQTzXApLkcYdBnd?=
 =?us-ascii?Q?uQWmGNeOpTaRN2TxUGXwPY2Dx+GuthOMduf/uMewQvJ6c/1i+L7fIgJ88aE4?=
 =?us-ascii?Q?UTnnmF5ZhWjIrXS1cjdHZ7zs3tPBErgFXr2hT9YdtmYNeEGOYWpxO2vB4+Of?=
 =?us-ascii?Q?nqL4LPEgC61hS6ceqGottnMzXmAmL5dAR7DbbwPy45uzhk49Yw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ONhCEXbIAcAMPh+RUFXOZwxT29W4HtK/vkW5t6jjUeYUnfHmwzzv2WLc02UL?=
 =?us-ascii?Q?EYsPpHyFCsvA22w+7gKipZ4JM2CYvANiAhtguClc4Um/vwMwWnxeoQ1I9ADy?=
 =?us-ascii?Q?W3Bp11NHJ7AJXEFXJRzDtbpau1U7RD+m8FZkzWZsRMezqH7PS6kWQRwhlKBJ?=
 =?us-ascii?Q?1y6b79X2bG29h9H+K1BhGjQ1ZXWiiEVXkYyVD5YXt/S46FU1mioOrfkyj/ED?=
 =?us-ascii?Q?zBhihWjrQJsDwrhfGF2Ch96bXL9hxRqYhNXHRkfPxVbTfvNNCudIOZvfEn5w?=
 =?us-ascii?Q?C6GDOBARhcgGhsYkVYdBzdtcE7PCkCjSLxRiwwDnhDpwXkq3wseV39TtyZ2M?=
 =?us-ascii?Q?LxXLCRFxw6AtmwnnM5patkEAHWh5X8ubVJ0pQND65EcE5TNVjyhFK1OM2wBT?=
 =?us-ascii?Q?M1T9p6pYK4iuTJKY5hcJEQV8Lknc816g9K7dsjXUvJFeHi/0Ib8kiBELTeWp?=
 =?us-ascii?Q?nINM2d7KgVLIdLmc/TeMXuWqJoN2UOzWupnmFbtZy9luqjpt267Y7AjE0F7H?=
 =?us-ascii?Q?IkRImblF57yf+anYtVS0/G3gglWCHsHO7zKyqqDd59G0opObOR/X2Lq0DFv1?=
 =?us-ascii?Q?YuHfA+b32eFq3wFRm7pgzwZZZTFCON3SNkBSxYq7ujP/ycxYZHt6p1UDTrcw?=
 =?us-ascii?Q?VEXvvq9hDtmkml2R8bs9rCXaXScCB7K2chAP9A/vJdwVBqB+pMdxK+X3nHbE?=
 =?us-ascii?Q?jP56UndrfFWpNIF9aPk2/jtS8ak9AdWRG+w25fOsiWpvMWGDy4C8EPs7kqPB?=
 =?us-ascii?Q?QCjAy4VY59AlrpM2waxb+fA2NQGj03vm6atysW9wQhnEyd3XVvtCQ6Dkx/nu?=
 =?us-ascii?Q?CJnVY7XZWplVJeP3q+2I9THP4KdbhyUrMSqj1QcDgmnpadQynmPJDCc/AceQ?=
 =?us-ascii?Q?66AnFCx2MClzOIIWFfQPNLjxwfFH7zhnslYkXKExvKWg+8M2ftS/IplMjNKc?=
 =?us-ascii?Q?pz5SgpKFcdGRPvQ/G+51HR4pjGNcSH42mryfi5wisUKJaa8HYrHzXYmKEcDz?=
 =?us-ascii?Q?ev35cgh5fTMLiu3jvievGbydG+V+lztDr4fQWR0UIKokxp0LLajHtoLBkAoM?=
 =?us-ascii?Q?UymzqXHEE5KER1XnP7Ygy5iTBPlPQR1tUEerPIJAGu6O4/6qNOQejUWELued?=
 =?us-ascii?Q?3GyW3Ly/kkc0zuXkHpxSQeHt0Iq0dSx48VOPj5gGF3kcmWk5useWvoQuutqO?=
 =?us-ascii?Q?+Zdqb9QK7VXYjX5fmBeulVueAY+oThUD+F5ZDhbqKh3uq4VhsWEoaLkaj/wp?=
 =?us-ascii?Q?pSBtH+YlrLZlMg+SNe/ujvsMBdus8cNP0Mu/+c513zd20e8XFre9odzmfPii?=
 =?us-ascii?Q?m2o0It9Trawhf7X7wmaR56uCIuZxwlkSW/RbvXrI18Fr8JKK2i0Zyn0zbXBx?=
 =?us-ascii?Q?C7A0bREWtNMmqQR0kA64+k6RP0tIhxraknL7fAHIdJYc5+ZO7UyvfZcQhI9I?=
 =?us-ascii?Q?L/hkvi9gad4JwSI0K10f79QoK7hD6SNGUXNdwqxgwetkJ1feJIHLhFeFXyU0?=
 =?us-ascii?Q?OgEex2xgPwZnXKAiURJqUAdWZNHEzI5xMqNCAxwk0xLP+5HOa6yzCUVo7RcY?=
 =?us-ascii?Q?vWM58/SVVJP1jj966sXYio5L7TN/XUjhWvtL1E3v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3705aaf1-0b78-40ef-a05e-08dce1135df8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:47:27.9258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAlB7YlPCuo/A2ohy1++IouxDdBz0K9YtjMMAeXz1U2srtKAg2wO4iLVqr8IWT9KAEUjuxr4FcxLNAgsXrqUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
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

When supporting partition reset for SoC such as i.MX95 , the Linux
Kernel may have configured the tuning, while after force reset by
wdog or else, uboot CMD0 will never pass unless config RSTT to reset
tuning logic.

Since RSTA and RSTT are independent, so need both to be reseted in the
controller.

Acked-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 8 ++++----
 include/fsl_esdhc_imx.h     | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 2413bafc32f..d23de876c6a 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -988,11 +988,11 @@ static int esdhc_init_common(struct fsl_esdhc_priv *priv, struct mmc *mmc)
 	ulong start;
 
 	/* Reset the entire host controller */
-	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA);
+	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA | SYSCTL_RSTT);
 
 	/* Wait until the controller is available */
 	start = get_timer(0);
-	while ((esdhc_read32(&regs->sysctl) & SYSCTL_RSTA)) {
+	while ((esdhc_read32(&regs->sysctl) & (SYSCTL_RSTA | SYSCTL_RSTT))) {
 		if (get_timer(start) > 1000)
 			return -ETIMEDOUT;
 	}
@@ -1096,11 +1096,11 @@ static int esdhc_reset(struct fsl_esdhc *regs)
 	ulong start;
 
 	/* reset the controller */
-	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA);
+	esdhc_setbits32(&regs->sysctl, SYSCTL_RSTA | SYSCTL_RSTT);
 
 	/* hardware clears the bit when it is done */
 	start = get_timer(0);
-	while ((esdhc_read32(&regs->sysctl) & SYSCTL_RSTA)) {
+	while ((esdhc_read32(&regs->sysctl) & (SYSCTL_RSTA | SYSCTL_RSTT))) {
 		if (get_timer(start) > 100) {
 			printf("MMC/SD: Reset never completed.\n");
 			return -ETIMEDOUT;
diff --git a/include/fsl_esdhc_imx.h b/include/fsl_esdhc_imx.h
index b8efd2a1664..8612b56609e 100644
--- a/include/fsl_esdhc_imx.h
+++ b/include/fsl_esdhc_imx.h
@@ -31,6 +31,7 @@
 #define SYSCTL_RSTA		0x01000000
 #define SYSCTL_RSTC		0x02000000
 #define SYSCTL_RSTD		0x04000000
+#define SYSCTL_RSTT		0x10000000
 
 #define VENDORSPEC_CKEN		0x00004000
 #define VENDORSPEC_PEREN	0x00002000
-- 
2.35.3

