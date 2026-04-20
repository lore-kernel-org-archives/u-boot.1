Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A717BF55818
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAC883E36;
	Mon, 20 Apr 2026 13:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t8vRD2Qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D66684258; Mon, 20 Apr 2026 13:21:39 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72D483E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygCMgfH8AEYYK9Ygirqn6R6AFaAtbWXBAllZg+OKvFwFTsJNBLwCItT6Lt73FwI0BamVzFHKpuBrYTKrwNbettsQnkF8R1vvfSMmoc29sdWKkX45nCviGsqUL5cSJLGAEHCXlwnyKetimIKrRcHgkWdqd4xIzleSArgAG6mQmBAhG9crdVPURKqRvY9Tw9yCpi9HLfuuH1UbEj4U9/9BBepwoAuDUrSA4dohdcT3jGq9Cn67KSu65a4K4LfF2QRbcVToiTktEFh7RF9E4S7GmCXQ3H4YH0BzqnmtGt1KBe9mpcxNra12deSI/XKg0o76n8xLSlDIWpomASr2kpEQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=482WBk63ILkbuNf3XcN+ek2tMPGAoiXeZS3O29Vtes8=;
 b=IyyL4ntO2BGhdix0t+GyN08KQ+TCpNkV5fSUPb4tUnpCaYH/dM7jf2HQyXjmCY9nfriu5SONcaQp2DfM8MWNiibKCLVc8bmnvFQkQ7UVFrTDwAyF7oUmr6G/YuNZSz1g5w3VHddwEy1YAGM3DHfmtOLR2PLuJJlNpIGXb79J/4ntTA94c5415M4ZCsj8I0/MhXXqOAMrq5fNnQuTDi/UXFktLtHRZQqdIzi1GEk0I/d5jGiNSnTGmrOO+fXlspZxC9sALM0przC7O2A22HIdXfuVHgo/wf7vIvAQvporhcxbt1c4EBsy5G0qqtEUhJTv/oHM/KPhv/3FWQtLy/7+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=482WBk63ILkbuNf3XcN+ek2tMPGAoiXeZS3O29Vtes8=;
 b=t8vRD2QeS+OTdrhGpHv6IwW9DAOPeDqVtbtbr6a5u+sKNHygCRxh9viv0/OG2MdjcsAQkfYJrdMpQFV0c7totJIp+0gcRte0T28svNi4Jptwu791/c0ZjxxQsGbfWPAusQWT2/YWqtNbQ6mu435R2KVU6pLjP76OWREGUfzqIMNPPRBx5//rUMG5RGGoFwPjYrJfVLXG5+NFnYL8XpqyEMbHgadzPPQAeTyKPfJsxHad5g+bQ37ZrY4mAhF7KT7YfDwROPqtdr1wg9e+oczRzOjKPgSv4bH9RxbSfEuIIe1EJEJBjg1H8jm76W7etBb6Y4F2VS+9Sg3uxgWqwGMgIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:21:33 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:21:33 +0000
Date: Mon, 20 Apr 2026 20:38:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mathew McBride <matt@traverse.com.au>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] usb: onboard-hub: fix compile issue with gpio.h import
Message-ID: <aeYeKi5vfG6cde5r@nxa18884-linux.ap.freescale.net>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
 <20260409-ten64-add-usb5744-v1-1-2094496f72c8@traverse.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-ten64-add-usb5744-v1-1-2094496f72c8@traverse.com.au>
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV1PR04MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: a978047b-5643-4076-3965-08de9ecef9b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dd1rXk+yEDhVg9m8Ae5Sx5im4GssJ4RzXXxEZex33L02mPA9d/9CtolkFoUStyR6qmI+nJBGf5aHSEbop8C1g2cvZxwNN6FKNXTQkRAeWeQseIjWjfNLeFnGE49/lL/FbageHEMpsQ+AzvsLU1esV+5AkSATjaZB8UBmIQ0Gx5bn338CHysppZQjXA4MPqtC6kFyXyjyT1ebncv85qvnNAckFKDztLu3po3EuApDkKqow4uS43ASnFroc4aPldlvG2vysWVllWKPb5j/CRuVnnjvIlhbVZmrnI3OcqmBMyXdi9YDQfQlropJSab+hboe0jqADP7JNkeRPPMyciBTM1SY3gjgGIYqYuDDlcvybq1g19B4DOvM0xu/ih8+r94qjsTo6OLDHThcNMfSQOWTiT2Z2OD47TwKolvsPrlHNWvoPcLAU64Uk8Hu3lTxtbzQMHWx8kPL7OkvQzy4XjkF/61Cs77Gxvrq6LK5kKnQD4CbfKNsktziK9vlS9kUHt+cFpyzJcq2v0DaLFpJ7meYM0tcE4UeZKT1/utfLKHLKg7GQDof14BP9syAzB5jC5nxtYoMo4QU9zAgZ6NvPQIwl5EvXRt+cBO6sSP3rD1fZNr2viZk3RaKtPedf87VoaeIqQHOgrenSsXxxu3pJPNVfbR+V5Qh/OMeKh8iZp+1DQlkNe2DWgen0c8eB0wpoJBuYynroI6rkVUB82UqIf+HwtFGC/18cn+rRL38qmiXGMn5h3q2VKhYfqRuCk0ccxVXK1jAwgr+folVnD38Ka5giaEcQ8GPMnIs7jHULPPrpys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtH9tWjWIr/Nu5nWZF8LMEhTtKmX35Nq4ucmxX9N/efQMhGbYnNA/rUSy+MA?=
 =?us-ascii?Q?/APbBhTQxQU/PqXgiTO3tgOf78H6mIV4uhtg3Kcw9YFrIdjTsBVANMeGqUij?=
 =?us-ascii?Q?7tpFuBRM43/9SNp5XMFBjdI03u/wcpj1oDcE+CrhJct4kbd0AGKYp5bG7xjs?=
 =?us-ascii?Q?fJIyb7zOg2sUW4XQViWYhwvnk5y6ZsTy4VtvHqRkQ6gEyJV90LZg3m8dH69W?=
 =?us-ascii?Q?ZT6x1hufkNTu+yK4nKW53cnHggHOYBFJBysWYJp0NPBZlF1xxNU7+XYRmO7R?=
 =?us-ascii?Q?rphMthz/5VhQFNSIr5AWP+AO2eaxuONjaRT2Wbn0Nu0pTEIFdSVsTX5PyVWK?=
 =?us-ascii?Q?jyxyPZp1C/BcVv4LcOgMLs5eoKh5wJEdms2wAzLRIML+oTGKArkAYkhUJUk9?=
 =?us-ascii?Q?5SmvDhAaxBLbWEa62N00rzUaoLGaMxBhLxyZlRNstn4C1ruAEQgw4JWbrh2q?=
 =?us-ascii?Q?lCtrtpNP1hf/FZ8hIiJXf77ZOulQuCqTwsNfJRYnC8jQnlEr0kqLaQKTIfpl?=
 =?us-ascii?Q?TA2mrjaZ9Ud7N2r0CU9GOdJzdaII8Psj/lMRdGVjShQn02u26G0MPXYG/DTy?=
 =?us-ascii?Q?F6sHgOlUDbA2DuStLn/CcM7pmLsZhqdMs67Dcv0LwrgChplciT7ovhBlcOFy?=
 =?us-ascii?Q?fFbgCRi9wL8RkltEJ7vt66arek4z3PbigxEmHArObzp2rByV+C18jAXTB50D?=
 =?us-ascii?Q?COHkW2gSDn3T9SjsRBrAyb+GhBfOlJVGIGdKie4bWYVT1BC9LWsmCyi4u/Ge?=
 =?us-ascii?Q?cN76r3pbhz/HbpvbyIzISY1trs9tuojjGctlmihN6g9LeEac+ehi643ighYX?=
 =?us-ascii?Q?mG7MbkyPidYEtfb3kXpg1EJSX3GVRklAEUMvw329C1HDZrrF1pFB0IBAIGXA?=
 =?us-ascii?Q?PBgPTbvUebr3DDHgDx01Bgd+qLvHOTcVxOBc7I/U74r6+3wX9bI3j0mOi4cZ?=
 =?us-ascii?Q?sfw+fvxdfig2N7dvKmfieSWLeTLv5nTzdJ3OEq2G+bWOtuqS4BY3tvy/DTax?=
 =?us-ascii?Q?3jn5ZqMtN47dSCFcnBAd9o4qN4YxpuQb+e3uCRx9Rru+BXIRFPWZAoZHM6fl?=
 =?us-ascii?Q?h9XLOtcZllNFirZ46TelvIu0k1hoGrEa1oiyWpLiaVAphPjNPwOFHoX2p6Uo?=
 =?us-ascii?Q?9/rN+MRn8Xqt4Nwmm7PuljJohhmeCdoSjTBX6S+3D+7zbbXsyYquOnwyL6c6?=
 =?us-ascii?Q?FBmdZLwWPrXrt4C3MwH8Vxczy9LdDpNyRREO7a2lcDz7rVSRdse887il87KR?=
 =?us-ascii?Q?Q5tzttN1jX1ZAOFkFb/e/WbO/J5d+jsSUdSFFcxBsZfupVNpvpg9XvzHifFv?=
 =?us-ascii?Q?j+WQ95RUCJzEolryYC91u61VQUTC063u7/2Dro+JrAmAb4tlaSKd3WKRF32e?=
 =?us-ascii?Q?m/NVziGCIaDMW+CLUEQETrb3J6e5bnveRYqXM+8Z9hdZziOnxWLBHwlw+f1R?=
 =?us-ascii?Q?x14oQ6L+PFcBWOe2r4M8HWyxbfXPnaBeuICdKHsLtAcHeAZhYc7wrHzIrgsP?=
 =?us-ascii?Q?ZPgyGEfLyUyKg0SQJyPXG+43GJX3F85GZVCK/EGjRVg8HWR8m5BkZ4trRlzq?=
 =?us-ascii?Q?b5SXoCHH0yNeAO55IMJutZFyi0ztxaQZhH6ZeTIUELioA63lj78lQVmEhAhJ?=
 =?us-ascii?Q?X7W2q2rQ3whGJw4B3G4sOr+20sMilmiCaYCna0g369ja01oSOjFeQbt7wZjz?=
 =?us-ascii?Q?WMD3uWShkkAeF8cnpkeay3tdLOGKmzzIcTDUIpPD0E0Pr5nxGogyD9f5hBpP?=
 =?us-ascii?Q?oxGs+Zuoyw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a978047b-5643-4076-3965-08de9ecef9b3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:21:32.8977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySZec7M0VrhfTuwLFS8fGABA5dyWBmkwmToJ+T5c26PT8A+EWp4iwGHnPOBWNVqKkXwWQkOhiWS3tAgyHKmH5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9151
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

On Thu, Apr 09, 2026 at 10:06:31AM +1000, Mathew McBride wrote:
>This resolves the following compile error when compiling
>ten64_tfa_defconfig:
>
>In file included from ./arch/arm/include/asm/gpio.h:2,
>		 from common/usb_onboard_hub.c:10:
>./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
>   17 |         ulong addr;
>./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
>   18 |         ulong size;
>./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
>   19 |         uint ngpios;
>
>Signed-off-by: Mathew McBride <matt@traverse.com.au>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
