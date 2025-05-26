Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86847C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC4282CA0;
	Mon, 26 May 2025 09:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IssAK6rS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5F382CA0; Mon, 26 May 2025 09:34:15 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6585882C96
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcCc0GbkCXcz5lvKfII/mLRKi5FgmZ100l+BaqGQ+ThTDQc4SHFTFFSWMc1/hNm7YrxacWu60DDZ1QaTVOsezM05hUmFGuezbHF8LzR0Sv8z3q3HLvPNmU8a9Krcc7cGhaq5c5rHz903mK/64ZVZ0ubnLhivZWvfVJk4A8F57cRWRZGnIyeFJ99LFWIXPc9fwrzxubJzOm4pYMwvnIPCYs9cLmYPDBW4OrCRPELzHFhUC39+1X50EE3JiNhRL7i19xH8hkNKA/Wvrds1fycR+Lk8NqAGRSkNyxb7o/16rpdb8mBBBR0NRWul8mEel6OPok0K4K279mZqw/Xt3N9OmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75w+b45dNL40nVgPg4mWsMqaXEKvSUX1dHw/yJK+uHA=;
 b=LPnsEDLTCFCKgH2nF5W1qQrlQpXaDAuWm/0oQPcH84fhAQEV5zuEve+YYj41ExI1DU++G0Hg7PQ1qeolLJ6+8OnQVbK2RJY2kGqbEisHaVdbbuQaB+dCUt62Of74kH5D/UYgXbUshKM0E65WTnbrDVd1NBcaIEmNMFAMiyGVzmo/6B/0lmr3lCvTizQkXMOzxN35a+E/CYZwd5MoeCc112iuAME0BM7R4Xzt9TLzuW+OUuHziYs5qrd0ibc8LbdP4CxWjFsLo3d+f2TLxJEOkhmxBmtYq42DeJL6cdRXDCLJosVQ4NSaVoKVjH0vepUj7ffs5bL9YJaLsZWWW17b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75w+b45dNL40nVgPg4mWsMqaXEKvSUX1dHw/yJK+uHA=;
 b=IssAK6rSck3g+f0cx9t6Fj5x5y5tmsq9SupewI9JS4szcj/TqGP9dgr1cytNCfJ3XaRbDWn5luly4J9Swf5FPROXjXsOnd+Igf6HLqEwTqo3n2F9KOaJT1zEnweDcUt7Wkfqs+PNrVJeIhlKqYGv3+ccyTmf5M4b33iDhqEnDX7WBLEgSVutHZY5fXyMnU37UQhu8ND5UzUk46nJOcBXPi/3srUxr70xJJGYnhnbW2UgjUaVLFfoKwnD+mv7abZVk6IVdgks4GLNIlDlopJSFdNA5LJCi2eLt3885P4M+4PxW8eUnxtu/dZT8+w+/hB+v9cTc92y0ZITtPFQvoTgYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 07:34:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:34:10 +0000
Date: Mon, 26 May 2025 16:43:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/4] mtd: mxs_nand_dt: Move from clk_get/clk_enable to
 clk_bulk api
Message-ID: <20250526084356.GQ19264@nxa18884-linux>
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-2-michael@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525122316.661999-2-michael@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 052cdb91-2231-4c57-3e13-08dd9c27b448
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5KB4jJjVUc6/urMpp2/xtfkigtSjbSW9sc1I01Lw+TBV9MZjwKjO3J8ayLmY?=
 =?us-ascii?Q?bQZ8gF9PCwMVmpSaaSJ53UNVFPPDUNkBEUpi0i/6xtLc2wEShQiXpAFGCeWg?=
 =?us-ascii?Q?yTUOkYYY2qjhTf7ziE1Zwq13XVtv1GNP/ubTz//tZDAkg+2kLlrtL+omzEPW?=
 =?us-ascii?Q?QgvcgZgHzDkSeEeFIGPUrGzyfzT9UPd6gA+qzD+j25ARrEK9nCwxD7TjAhic?=
 =?us-ascii?Q?Jdi9YBEp3zMPeW1mcciiumZV3JaiJmShRMN9bIa49aR6+yoQJSWewxobU9Y+?=
 =?us-ascii?Q?Q3kmIaljnHGtEq6Gy8UCYxDQUOeO4bZpCcsDXC8gCQaOGJK9MFfBJfGnesHT?=
 =?us-ascii?Q?RMp/qHYEDgwCima2vyOSDx04VOB/7X8aPB730gy1eJV03ijKbguTH5YWZlF0?=
 =?us-ascii?Q?+5JvtdqlCt/Liho6Fl4k7I5PSw1oOxv4znsfVmFQCq/HgEDIfqQXyXr7zWsE?=
 =?us-ascii?Q?XYZKZG/FplsOqNmvDpjb8PbV5JJ8fJxgXgFNI0PBUEO5RRX4zvpyHeUvBhiM?=
 =?us-ascii?Q?zngoB8et7k+j9Z4E9EjZU1MTrV3COi8nkFONRP/ouOEEN26Q2Sf3tYqC6ckN?=
 =?us-ascii?Q?hvYI/UQ9B3AHPqroxwPo66zkbsBzuW2NSAyJupoOccijIjRT3RUmxR1jdiuy?=
 =?us-ascii?Q?uq6XQj602kG/YrX4F4Y3uPhVvEhuF2kB1wNOFyDwTeJw81V8EZ07kDDay/Xl?=
 =?us-ascii?Q?Y5+QcYTarrDaz2nPlapQbMUJeZaVb9SLb+hLpIIQSc4yN188P1OYz2UgsWT9?=
 =?us-ascii?Q?hbyBZGsmUdLw3NaYhLMm3MHlbYxHOr2BiJx1Lf845pqcCTcrXxZAXhUrgcMv?=
 =?us-ascii?Q?8dZfA7Lt6xRH5cJQDBBWlvs2hG117mnKTP0AH9EZSDQX0/Kv+elFqI2HfVJ7?=
 =?us-ascii?Q?wKWjraIWKacGR69f5Dsqaa9OacO+0bPec1Zhk+jtaPewDu4IZn0we3O+5kfh?=
 =?us-ascii?Q?NML34YZSLt2eRwm0hszvqXjpZIXKYexj+id2mcUMrnfxELe8x9FEKRu1cLfm?=
 =?us-ascii?Q?NkrBabHfeHD93rt+VUaXjj3WdZa/oNiH67e2fnTiDTp2CRL7DJVTHlh7WX36?=
 =?us-ascii?Q?jzc3/ji48m6cfsxgyaUtLt/eMeh2MyyqguCwQyEBENYlPyCXsqa4odbNCWQP?=
 =?us-ascii?Q?Ugb/03rhTi3M/M7VdueLumobeX4HREJNmbt7zS6xICPWx2bWXS88mDt2G+rN?=
 =?us-ascii?Q?mzWWyzhRoxp2vfaoG05VQlrfQSOiGC/QZR0loCDYCumQx/NTPO/JWwfTXxa4?=
 =?us-ascii?Q?J7QmxMxDzqVrSKLRdRH0QDlHOPaBbj7cdHRpcf6TtqNBFTDzEnIkFwucrJFT?=
 =?us-ascii?Q?oE5EdQ+A+EMZpK8DnLbXfJs8uNa2dTff5kIxmU+O/KacvEj4hNW+VNeQQVKl?=
 =?us-ascii?Q?+D0QZmqlG0zXGp3NcjOgI55+Bip7vBH30dAs9ojMzO6R3bkWR4g8dhTFw9c2?=
 =?us-ascii?Q?iJzt1Hz5HO2X5a70dm/YSP8auZvpWv6OJP1UvE+Gh7tznC4bpxh96g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLqPi/RBTcfXgRmH2IOFlB7K6Xsdhy3BQxpSpJ36hZorUhW9hvv/s2YLOgSK?=
 =?us-ascii?Q?/SZcHJlQpmlf0cbo2qKRWsZzZAQVAJuCvjRP8A3JQxUky0+RHSyBg08+Iu/y?=
 =?us-ascii?Q?DtXJx8FQbb8+Ifplx/kFrTaEIURW7TQfrfZEVKrDSt00nwX3rwNNgxNUJQeR?=
 =?us-ascii?Q?CQ5VnLB+6jUEHQbBuLJ6vyPSwUwcmUNIBHZLaUZCk/cEB7D29Xl3HjDFq06n?=
 =?us-ascii?Q?m9QgPjNxIDzGdVr1VL3pxIMfpQ7BG+iG53EBWkEdBfFupQ7xmQ84K0Ji2sKK?=
 =?us-ascii?Q?XrMlGtB64Uxac6DlyFWfNES6CkhCenYFkbIM2/tV3hzISl31tjNaYCrkKshb?=
 =?us-ascii?Q?QxF1nAhBrTNWZh9Xw/0v7q/ELXdAvDZl/c0x/3FpmrGxN03CzFYjA0ZdCRm9?=
 =?us-ascii?Q?kpWiC86qoFiEVnTNsB7tzqJa5SC9av92q6nYKgtbqLUhlfYd6+qTZWi2m7Z9?=
 =?us-ascii?Q?k1xOoTeqqgjo5yO9FnIGZN/QHgB7NVGNmkRoWMTOUY21PNIOjMZq8Cx9E+wq?=
 =?us-ascii?Q?XaGbDvHCTIaaxqiGEGdxkITQinpwB2KgbbIRuQQmJsdv8FkyHE4iYOxQahsX?=
 =?us-ascii?Q?rcgR7RhwxqVqK4P7CbFz9c2/kH4N8iQHXGmeZmGXaMmlUONqPSq5b4lgkFOr?=
 =?us-ascii?Q?c6m/dWO0//RIiiwWyhdJjHBX9rwxHFpmJq1PRMlCIa2akZW6muw2+c8bOLrc?=
 =?us-ascii?Q?Yan7wtqtesM3SUG/Gj6wj3hfQACgC0efk8OPPDTtpBTNNz1yHyEPGGjxNlbN?=
 =?us-ascii?Q?QusXqeW17t07dxTLpl+nhXTpBqJ9Jx5tdh2okqm6FZeNF7BfCTUEYhuKKYrh?=
 =?us-ascii?Q?gNIDR3nV12RFSLqqmVbfUlxQeR0XUxSRpjoVxc6ePN0Gqj9m84JWr4cHAhJR?=
 =?us-ascii?Q?i+/UGDtTUAJG1l3BPeckyHMGyb2bi5XBA9rfHdIfaTLjCU+cnR+a1PqYO27g?=
 =?us-ascii?Q?pfaHxpUO4nLhMu0prOy9S90iuBfACmIwUWqDfi5PviXzcra728xxAPPllxMT?=
 =?us-ascii?Q?PI+dz+M+mLBa+63Lf7pG+Z+G+m+uqeYT5b7ZgmHYBAXrMZpEyiat2urT3svU?=
 =?us-ascii?Q?W74r/qr/VKWEVkZJCXv0SSzktl9sUWo+tJchmulHuoqGJtF6iuWT4gJPoUxc?=
 =?us-ascii?Q?9nZbaoE2NcyR2hbbpQjiCsC9epyBAGKfjF94BlKA4WK5y3oPWwfE1+Cq4iV5?=
 =?us-ascii?Q?SJKC5qg33rpNA79m1ndTJY6hvbCITGMaQefQvhpdaq9yC7tE5SoH/2klfs1k?=
 =?us-ascii?Q?FoutwYxUnanZYUsL/69alwQLDQdD0eqkWn0PeqHB+IGO/zXqmCXnA0Ywu97v?=
 =?us-ascii?Q?M2V70FPmKjnk+PW517aBrMccuGptQLz/G29soOMhqhCzfjSKtVSLRspW1Tkn?=
 =?us-ascii?Q?6pvGLTfiNVFr00Wz2tlj1NBoJRxpvof9WuD8R5b8uLjrRsraeIcGtbl8xt7K?=
 =?us-ascii?Q?DazlqpS47zsnIyRFFtwaNAuNojcVW2G6Dx6tPTUJRC+eSqT/yAXHcilYA8Uw?=
 =?us-ascii?Q?ExzFzOBFGmF3uqLf/+SQxK0siM2GEHjJJUHRYrnf+dphCrRAgdB3qbbD2QRk?=
 =?us-ascii?Q?OkyfCeCTav5RqQe2kLdWX/bed5YnyRkNZAQ1cx4N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052cdb91-2231-4c57-3e13-08dd9c27b448
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:34:10.1028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRSrSmHLNS5tuyy6NiAE71EXSKZtObKWrlhO6IE4eKFMbb/F1pDNwQ73yMOw8ls/GRI6MYFE5d4jkGmIcBZpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8619
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

On Sun, May 25, 2025 at 02:23:10PM +0200, Michael Trimarchi wrote:
>Make simple the clock registration and enable and allow later
>to add support for other platforms
>
>Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>---
>
> drivers/mtd/nand/raw/mxs_nand_dt.c | 48 ++++--------------------------
> 1 file changed, 5 insertions(+), 43 deletions(-)
>
>diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw/mxs_nand_dt.c
>index 11dbcbbf442..b62474bc5ab 100644
>--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
>+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
>@@ -100,9 +100,7 @@ static int mxs_nand_dt_probe(struct udevice *dev)
> 
> 	if (IS_ENABLED(CONFIG_CLK) &&
> 	    (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
>-		/* Assigned clock already set clock */
>-		struct clk gpmi_clk;
>-
>+		struct clk_bulk clk_bulk;
> 		info->gpmi_clk = devm_clk_get(dev, "gpmi_io");
> 
> 		if (IS_ERR(info->gpmi_clk)) {
>@@ -111,47 +109,11 @@ static int mxs_nand_dt_probe(struct udevice *dev)
> 			return ret;
> 		}
> 
>-		ret = clk_enable(info->gpmi_clk);
>-		if (ret < 0) {
>-			debug("Can't enable gpmi io clk: %d\n", ret);
>-			return ret;
>-		}
>-
>-		if (IS_ENABLED(CONFIG_IMX8)) {
>-			ret = clk_get_by_name(dev, "gpmi_apb", &gpmi_clk);
>-			if (ret < 0) {
>-				debug("Can't get gpmi_apb clk: %d\n", ret);
>-				return ret;
>-			}
>-
>-			ret = clk_enable(&gpmi_clk);
>-			if (ret < 0) {
>-				debug("Can't enable gpmi_apb clk: %d\n", ret);
>-				return ret;
>-			}
>-
>-			ret = clk_get_by_name(dev, "gpmi_bch", &gpmi_clk);
>-			if (ret < 0) {
>-				debug("Can't get gpmi_bch clk: %d\n", ret);
>-				return ret;
>-			}
>-
>-			ret = clk_enable(&gpmi_clk);
>-			if (ret < 0) {
>-				debug("Can't enable gpmi_bch clk: %d\n", ret);
>-				return ret;
>-			}
>-		}
>-
>-		ret = clk_get_by_name(dev, "gpmi_bch_apb", &gpmi_clk);
>-		if (ret < 0) {
>-			debug("Can't get gpmi_bch_apb clk: %d\n", ret);
>-			return ret;
>-		}
>-
>-		ret = clk_enable(&gpmi_clk);
>+		ret = clk_get_bulk(dev, &clk_bulk);
>+		if (!ret)
>+			ret = clk_enable_bulk(&clk_bulk);

You enable clk bulk and together with a standalone gpmi_io clk?

Regards,
Peng


> 		if (ret < 0) {
>-			debug("Can't enable gpmi_bch_apb clk: %d\n", ret);
>+			debug("Can't enable gpmi clks: %d\n", ret);
> 			return ret;
> 		}
> 	}
>-- 
>2.43.0
>
>base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
