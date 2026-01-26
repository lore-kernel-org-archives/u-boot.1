Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEBCD778B1
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC9F83DFA;
	Mon, 26 Jan 2026 02:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jKmSDgrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EE383E16; Mon, 26 Jan 2026 02:31:13 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD66E83DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfCjfqSYIW+nRTdeVLFy5vCJaPPH8pWbdcpeA15n/uJbDQPKLYbbBFjS1eCY0ps9uh3yh/9Tcnar3JQG/HpFXBWF2gaOdmXKeHI3l5eFvn2nccbaPc2HQUki2pS9KCYDNaZKNbHrdiYa1xnqF39rj1ON+Gw8pgEkjIYmZNQNdICtcigQih3U8QsqsdxjO5nzEm3thzDncxSZpSvXlKekqQ0cSCDKizTpy/m42JSfJSa29lsMfybIWP9YkuE0O2Py7xQQGOpTBfDW6/m6/77WSspbeh3tFO+T3WEI82m+fD2/6QGpSklk+6PRjwnD4wCk+cvglnp9egzO6kiBl4paeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjGv1vY3NEyKJ54a2BP7y8rRTQXwYKbCY5mfpPQF9/k=;
 b=Y2aLscZ1b6wpE5yGww4enmzk9dgNsC3MHUQuka1N1pExPqIJC3r+78B2Tn6RKFEJMUiymGLPZQB739dyH1pWtDt6ybTKjvCLPGG/AE8L74B/lA+3xzKx/NxViKzS22fDooEbd2jmS78nJ7NlaP+lHPucfH1PkDs7t9wi2UGgUPjgcTI8S1p1mglGChLjnlpJmV+9f/7QmoaxWOWp/1asZLATMt8jIlf129xs4GZ4zU4XAmr+nm+z5symrszJrSXOts+miJmEt27l7Bq8P7MhkBFisoZQ0bOJ9WjmB05ZO8B82Duey807u3tyv9f1+CluTN/P1yBGkCkuiE8GRgPyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjGv1vY3NEyKJ54a2BP7y8rRTQXwYKbCY5mfpPQF9/k=;
 b=jKmSDgrk9wD6izthFy4evtG5sNqFW8EPPimTb8oEA5y/FG6wt8kYAflP0Hhzuc72rqv4hSEStmft7qmQCG29QUyzR8iFg8IFIvRYTSjPLSpu8nzAcF83MC4LU7NcVSkITXAOyuiYtY53I6pZkH7iMzBUemkX3FdCT71qwWXxNnZdt7keLlAdCmbUZU5vstXLu4wRfprzfgrydSmTGnbMe76cDiQ7SL49IMxPqNTRV5+CElt+YopxbHSN2aMTladl16z2ASI24CY3/WkzeNvAmeHJSeVos2eSz8W/RaDgHX71Sn2JOqXIUf2Aenzp6nNykPf0oBsK3T8al5mhhCRVIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10540.eurprd04.prod.outlook.com (2603:10a6:150:218::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:31:10 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:31:10 +0000
Date: Mon, 26 Jan 2026 09:31:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 09/11] siemens: capricorn: fix fallback bootm call for
 fitImage
Message-ID: <aXbD24y4JrjPYQYA@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-10-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-10-hs@nabladev.com>
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10540:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a3ff24-d111-4c1b-bbfe-08de5c7a9610
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ilCkH4UwMcG+fNDbn6+hwOXrz6WTKZGJsgWrZLxEL99hGYUBzfut4mavfH5p?=
 =?us-ascii?Q?2Dk9vG7obQXR9x91L7MW6a1V4mZIOkGxfwijbEJtqr/HYxUV/as99MzDAiZ3?=
 =?us-ascii?Q?Yk3JKKsLZtW+y2gI51RqnuLYE3qM1JSpVunuaSFCbc+4YxRwHDQEtTQvIws8?=
 =?us-ascii?Q?JfaZoOe94JByDsek/Gkn7r4Oo0OUm+62m+91Eog1CSvp7rsG4BOpucZXrF+x?=
 =?us-ascii?Q?wYM6tiT4Rpifc1oT4SMEmorMyvcBzCkIMliV/bZoKVbvNz8VmMz6Rd5GccfL?=
 =?us-ascii?Q?RxecBEvz/V/Q9DwAWICjBmvPbvH8cxD9IEMlz3zHyrGYl9JnCqOp63Kh2iw1?=
 =?us-ascii?Q?mlBcddNgTLLr+nItOJc6BJHlJ37205N9X9/ABPyhuzt0Tbn7dsEs02fu48Hv?=
 =?us-ascii?Q?D4/K2Pd0Q1iX7+cBL8naPYMnAyj1JeWCDgUw4kYnuCALVephZWpGFX/i5YOq?=
 =?us-ascii?Q?y2CokIeXmpYk6ZWj2eqD4/Vh9/w3jJX/8VBhgkNroDwI7Ya/GUgFI8UM/yXi?=
 =?us-ascii?Q?RSH4MDTIq32oAQAdx/q1FjwJjRWl0OxWhQaZ0AQOfdu2Oga3e2cdgWEZwD0U?=
 =?us-ascii?Q?yZfcv4qNcjzK4R6rKli+45IUSS7BPex6C3qCgSEzH9RcBNbk4XhIMrsfLuyF?=
 =?us-ascii?Q?1uFP0ClU1mXYDJhZCeeBeGj8brNPC+0SAlWcD3SkfxlphbU62Bnxh6fODLy2?=
 =?us-ascii?Q?CPEnbxw2BEiVYAFz6EZOsnwW7mGtfQHdtL7Ls24PKNFovVbL0xOi21/vneYG?=
 =?us-ascii?Q?ianBF8XqlHCjVCQY1ry67qHdkYKKgF5U0aDK47RJ9g0aaWV/c4ZPaaJAumyn?=
 =?us-ascii?Q?v/SZ2ORyTh0PPA1jj5SJoB3zgaXaTUTYG3smrsxwAsPHJGMMhdROpDwtRuFM?=
 =?us-ascii?Q?Xt/mzjvTMCFgJQaU1kC7JYDb4dGdcmpecC406E31OVx3WcHhTeydHjwJCVuY?=
 =?us-ascii?Q?gzeHhqG/U+FCTbp8QWitil1p040WlYbaKOYJJ+b2R6H47MBRwKfPDw6T3b61?=
 =?us-ascii?Q?po4d0TCHQ5IrR6V8bh0sbspVolAK+wKGVnX1VhX9j3+Z/QE3seUp4zj1mOmS?=
 =?us-ascii?Q?FYfZeeAkx4AHY66igxW3wCReBEsw3alO005tjlUnnBVvlSZaLUJI3fVk35mi?=
 =?us-ascii?Q?JZHdsOUo9WDCYIgegn+bSEF5CnuyshB5B7QTYxL9ZSYcz5x+XJ5sItoZTkPm?=
 =?us-ascii?Q?pGh91Ok2G3qqD++lvD5099iy9rBFlYY4S7w1/ADm057nDWgKwBk0RDGrxU2U?=
 =?us-ascii?Q?dZBgFTP8T48mQO33hVlVcSLTBh5UbDpeVnYc+osPHcTROU3ftziarNl2YYFR?=
 =?us-ascii?Q?5yCXImiI1ikDUQ1lDhamJmkSw570gYVgXSaM78X1tnwXwH1ljvjv/URjFcLP?=
 =?us-ascii?Q?72+dRHX92JRG71c5GNM7Uqx48uRoPkmQQ/xaCmpkq5Zna9dn3+Y45fUyVYk/?=
 =?us-ascii?Q?c2cNWE8+hk/g12RnSRv8M2RBbyqIvpDU+KqD/bqHeq5XP8L0uPkkhCUvMVuS?=
 =?us-ascii?Q?E6cg4cQV4S2XMBibNw3wTkyHJ0nnaRHbcmzCNj9XeeVlZtpc+GyuETXURObs?=
 =?us-ascii?Q?txdRoDu7UQ4DMt2o3tgzdjlYh2ewvHxyB5gjDAGMY3UPJWs7JYTsLS0OJkoJ?=
 =?us-ascii?Q?Rt4RHEREQyDh0xCIO3RqvdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B2YevtONjyuQE7ekRVWBD+8Po829PevB7blvTzm2xQo0XaSrfDG0fmYqjWTH?=
 =?us-ascii?Q?Zo87g0/FlB9ybYBXiHdaNronroIUi0GN9lRVbI6z4UAR5GIa9C2CtvT0vX1B?=
 =?us-ascii?Q?AEbb98p7ZM0RK/xi8lISq5CSiGzQAh/IXKsKqB7fQBQBKkYFekEFDmFWI7XE?=
 =?us-ascii?Q?4nhZh26FtoKVC2cz7TtqafrWiemupRiOR/FF0dWNf3NFkM0RwdW1WFBgHUVq?=
 =?us-ascii?Q?Uv48rXgxgOt4it/d8AiNVLD0XKY0xITOvs31A15p4hTRBvK0uIoXNu+SaLAm?=
 =?us-ascii?Q?R4Nq0ukILIjYMsTGEpRcL2GLv6Yj8bqnD43SrT7ekepp91TA2BdudM+TnIMj?=
 =?us-ascii?Q?8d+4WevyVIttaaNPwp5/iLLLrEQWTFMZjjhazwSDoHzkYQibejBetEap6hUO?=
 =?us-ascii?Q?zdBLc+J0W5EO6DtyjJEhqnYIJbIZhihq3Ds5INTmNQx5k79eUxLPYSlVyIGM?=
 =?us-ascii?Q?F05BKVEfu8fbmKUfbtIKVvJHIHyzGnjoFonRWsvUd0yu7MS6tdy4CPv0LFVT?=
 =?us-ascii?Q?XWvwTuCMhdHP00mHvDSrz3Z9HJMkNjVmv/WkdQbl8q+jXGWaRVghkUiNvCys?=
 =?us-ascii?Q?0BP4dwB9oZJY6Fb1LwyoLYBOHh1SQy1345sq6XBBIrTWpwxZTGhFU4Di1ofJ?=
 =?us-ascii?Q?EahjI04drPW9eA2YiBjhn+AxOZ0mEdgJjbj3gEYdScXxlx7QhxueKwogO+aX?=
 =?us-ascii?Q?LBqsOitV4p8o3W81/PBnjgwy4Su569IXuRullQnoUIxzE8c0NZLYZQUAsz8Y?=
 =?us-ascii?Q?O/L7rIVyEMyYFX4Cii4h5dlgwtljeabcvpV4eYtVW1+F8VUnb+6Cn3hhDePM?=
 =?us-ascii?Q?iVk+mFD4fNsmvEowQdj0jnq8fccJ14n1Z+DCVsVCQJaVKVlOep/90yBb8TT/?=
 =?us-ascii?Q?q4MqL/ijS+gJLksjHnqJebMzKYflvK27kaPgBNlzcSCqYlpF391wDybm+VSH?=
 =?us-ascii?Q?pK3uPOaS/riSHMZA8ZyjV3zkHEzOAvyP0o0MTL6tWhLx5aG54T0MlD3nODWg?=
 =?us-ascii?Q?KDc1by1uiXdfKElOh/bpQiRveFi5EpxbwlLVTnyZQZ1IgjfPk+CMToqf7tp4?=
 =?us-ascii?Q?4ohozY5SobZDoMioy8o0trliccEYar3K9jnVomUyMRh61cQ7IcArbdFxmqDS?=
 =?us-ascii?Q?IdPEqU8pEPJAKf8MTd9QLYJ4nAeSQOJlAmytqzvXp5MwyoUxwaY7sY7G0le6?=
 =?us-ascii?Q?ub4sZux7yFv0NIxvSXEQcVTKEuM/iTU5uUidC4jqZWnojLi3oDQZf2pqqAqc?=
 =?us-ascii?Q?H8Kln0UPRByX5pdOlQj/tERVO5+X8dcEc/RXt51sEjbkQvPX/at0TMGqYlS5?=
 =?us-ascii?Q?+tW/G3B7OX/9s9rVI3Kv33ChWkG7s0FxAKwC99WioEI3pjUSsyMtfj6w/YSt?=
 =?us-ascii?Q?pK1mFj3E/EEDn/JrPu0GKE0veA+sT0cohNh5WOM4c32oaAYJbP5Am6movoLy?=
 =?us-ascii?Q?x0s/90w/+KhMKBqrBwttdmowv42CEN4+4qKB2w9gQwFu6WnMt4M9NzM81wnS?=
 =?us-ascii?Q?xqLAYak53v5BjisN2mvVwzUufNpsMBDXMNzF+9TosVtnA1fdfuWxOJi4M7/V?=
 =?us-ascii?Q?qHvhpfF3sIU90JFJdENTtRXP7wxkoWZGWD3Fl0ZPADTuD1U0ih+IZFUnBDD9?=
 =?us-ascii?Q?gmYRaD5iL0yehBeojdwY+v3+e5G/op0EIQWy4P16dDp6qyF/b6WgNto0Q4KU?=
 =?us-ascii?Q?8lDrZ91wqs+eenh3sVMPIugicJeVnNBhVigemYyVXb9e9TQtJhKdWMbazUGY?=
 =?us-ascii?Q?7OAV+56AZA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a3ff24-d111-4c1b-bbfe-08de5c7a9610
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:31:10.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jXmTe6z22n+jjGfdpk9CHAUF1OYxqChQRdk9cEW/wWMs7laGMkDuG657U7WnklS7CI/CB39yplz3Dr1O/bZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10540
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

On Sat, Jan 24, 2026 at 06:54:50AM +0100, Heiko Schocher wrote:
>From: Walter Schweizer <walter.schweizer@siemens.com>
>
>When dtb_name is missing or a configuration is missing, try to
>boot the default configuration in the image. The call to bootm needs
>the correct loadaddr to succeed.
>
>Fixes booting when factoryset is missing.
>
>Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
