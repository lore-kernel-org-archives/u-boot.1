Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0624C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7B7835D4;
	Thu, 24 Jul 2025 04:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bz1zV9wK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CAFE835FE; Thu, 24 Jul 2025 04:27:57 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1688A835C1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5w1AKqVtNpmWMe3cu9zPbtLTtFt4FaZt3BRVlwTXjliWhrCsBpQOlhSMAVvwcull9CMWsxgWw57xBmTZDvi3GOMhljIfMMFVQ3YQKEqwMTBspPI4auM1ACHBry/vQSaC0kfWrOxCnVFgEJLReSc7H8NydKRmmF/aYP/Cxy+S3eGfxZ9Q5nVX5Qp5DzeoXdAI0+d5Q6gu4K+PUfGJFHEJ9babjmIvbIk82J6y1ftLbnaR5TE2K+Jt4iVgX6PY99au8q+IGFb6m/oZdgZHCJol0G1rdFFID970X3GE+lEHblNDSBgOH+UtU2bvfLh38pE19s5tu/qe1Ew4y+Akx/vEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpKvxhkzF3JZTsAw2fVnHajMsHeuVpaXgVKmusIpgT4=;
 b=Al+I+3pkcZ4WZEsfKdmzFcnBAYpE1B6yhVMQ8Y59Z7F1WV7iz1fDWPNta7kJkStwPzU8w2+d5HY45D0XrWUNNtKRx13jCAAmqOlEL2/g6pNtPnVqbXmyqBtnbvE7f1g4srZAKma8bJUbB/e3Wz1CjUDQDVPWK7z/O4kwB6lY3Ovvlh3N0tuCM8DqCqSa0ZoSrvuXNI8ERZqZd5EaDJnn8yOd7jTbQ+b8z3UFaJ+Aa+6Nx0iLLolDvxO+x2aQ/boewNPALLClhZB/SwuSaCH1d81hvyv9xNS60QlbJkELFT5dXHwzJN8adipNH11TUiUnsypCmOX1FyE7Hstyswr5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpKvxhkzF3JZTsAw2fVnHajMsHeuVpaXgVKmusIpgT4=;
 b=Bz1zV9wKWWvE/px4QvGUttv37XkHsZmi1KNBrWrGsnDFOOmMJ/dFFVBHA6xgB3e76m7POGknaEaCC0yhZ/m30z96S7ZSLf/yBaP6YVkk0OnxpHv5exmkl7CwhR0R2PvZ2aZ0zicsWiuh0S6KBrvg3cCFdoY+nkh2zQouZQa8DNKYgHlSasEdlLCE8LrpY0wqwxr4n8yGxLVWaIt1yj9tay6YWTU76OunPJDGpf4/6PZcF6qs9WRfPyIoLn/nubtEmP/siRdK9xBjC7Z+2Gg8Aojbwo+wU6UP2Fx/bvuEY+txAZuD6kzUQo8PBiUD1jhZnTe33b5FwksOcZdrmykmkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 02:27:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:27:50 +0000
Date: Thu, 24 Jul 2025 11:38:22 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
Message-ID: <20250724033822.GE18395@nxa18884-linux.ap.freescale.net>
References: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: e92d0061-9cfe-4ca3-095e-08ddca59af42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9B+dWEvpiOtBrN6OAk0cXQtvrbzezQ2w9JKVQvUMQHXPNCGE7pKlFGl/nM?=
 =?iso-8859-1?Q?QhdoejHS6u5/pAqOgSKjPv7rJ/CZrauxek+me5Zm/ZaXQeotVom16/MlIM?=
 =?iso-8859-1?Q?ZJnxjaVhCVPaB36MBzfZ0H3oA6wv7/M9ExIHg5Vv6NTTbPSloPHfd9SJOb?=
 =?iso-8859-1?Q?RC8oHWMiFauCO6qyoeFTVF5Y7BNbLe1HE+HN1wtJuXHlxKHmz6L61dT4tI?=
 =?iso-8859-1?Q?z9bq5vRhsBzMBaBTu4YnpMJXT0zkF+5xFtZ/z8Bta6NorFEpCZPlCx7B0b?=
 =?iso-8859-1?Q?cs0u7CxD9CM8IYT5MG7rrm9cGD9TBwBFhamL60iQpZ/xkZY2LZG8Qv5W55?=
 =?iso-8859-1?Q?GGD3dTFY1V+hj/2X4ri4NerwhfQU9tS+eA3w+oHvXnMKWzNPrI8aCsm5wo?=
 =?iso-8859-1?Q?NmXeHnFTKfqD5Z1oBoa8qVoHTfUluOLGg3ME+zIpHoRE380WaSdrhFb1kP?=
 =?iso-8859-1?Q?4ef2Zk7VJBmvf8IWsOLVFqzaPAA7tibNufP69ScVbQSjk3lSVbUg3DSiFb?=
 =?iso-8859-1?Q?JnDprlzswk8xqGAWJ48+SW/4bzYWC61hL0JA5syItuz8mSOk3T3ZVwyRs8?=
 =?iso-8859-1?Q?kEqeMlo8aj7Ut+H7dzhUT3Pb5iyQGds5KwtTD7qprzRLZGaOSgy2SELNFg?=
 =?iso-8859-1?Q?29m1wSCfThMFkCEx3QegLUfd+NzTkCEqQ1PcLB/1TvotgM06z4fg0xOq4z?=
 =?iso-8859-1?Q?SlM8QpBLdyZcAZ8yyXWZJa0wiRYeV6cLLFyaHa5zSt3lp1uYgPzGMVPoDQ?=
 =?iso-8859-1?Q?M8Riag1s+1zz/3ru4/fCot6IfnKFW6PYvb/VVcUAGvH3EKXPPdxOMoK90q?=
 =?iso-8859-1?Q?61bzIYrUiuh7csbIJUtORTXov1xC8fkeKV1CfCuQtQoCCqR8SRvEM8hbfS?=
 =?iso-8859-1?Q?/lBeoWoJpn0OyOXTckHJSPYSUmaJ2NgKl7ziD1kNrBcRU+W2HYvGMA3fxF?=
 =?iso-8859-1?Q?B1SJ+rAMC+9xrBLyRkAA8Y2KF/h0sqeV0PpV8EB1DdKx0fi196U9AalSig?=
 =?iso-8859-1?Q?AXaDc4SIwGj2N3MGHDNr+JP1jLfkxdK+0nZGSef2HTHoWj6HW2eB+TmrRk?=
 =?iso-8859-1?Q?Hvj67EREhzAWVOoOf/yO0vez3hCcvIkW7czdM9IAej3sDFu/zYZMQfKIWa?=
 =?iso-8859-1?Q?GgDeMi1eXNdo90JgjTyTRM1K/enkoxH2JgSgWlkWvc38OzDOsvbFkxXRwT?=
 =?iso-8859-1?Q?Lqc2ifOZZ1thsFjbBpMjifDH5CjiOh8evimHyE2ztssrTxOcxCWZQI3Snm?=
 =?iso-8859-1?Q?rz3F0NpduMgb8gIMdBMFW6VIVNxGR+t3ipAk7LTT1sQCm44onBaMskGW60?=
 =?iso-8859-1?Q?cKwfsxxpU6+hFcU+1CHXftfhThoN02AN6S0AnWo3dBiHp1PanGM+mBf5sq?=
 =?iso-8859-1?Q?oeQbBmrA2at+7iIg0YekZy8a4Hdc5+Bmfvt4slrdUUVVANQ91SXZrROer5?=
 =?iso-8859-1?Q?2cqUE47EEg7CEM/bLiXYvBuRsC/jrYxQhscwFo/pXBJLiOX5MqMdp/ltEd?=
 =?iso-8859-1?Q?T8roZJ0sV7szD6NEMwxuoCWZs3OKxFDP+6RCU0WwNJfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?35h4qOsIkuDEAI+RLrLFbJ3CZ6IuC8hxGXtYe6eBy27tV87ppBUUD+3nCw?=
 =?iso-8859-1?Q?05aWxPsgbYsTOtg79XtGlL/ekvp/v11ozcKsBPp/gA3jfPdSsYJlhlWBnI?=
 =?iso-8859-1?Q?P6/W8JBOzznqcUk1Ym9FRwkXvy2YLq7XnM+5FDaKwDCW0sq4BCiZ7yBlAb?=
 =?iso-8859-1?Q?bOevFPHtjXO1m9c47o3dRWoIu/E9nK6VbI3mHz8av9RE8laKGCA3gAM9v4?=
 =?iso-8859-1?Q?nuGLcR7gvm+pCB9xpMlrVEuhypDXCG1E+w2x8QDV2uEwcgtGTMemyYp+0Z?=
 =?iso-8859-1?Q?4T5wIqJSdOa/Kev79wOCgPCntcy7/r3xvQ1tT35jCtyYl5iNUnCyJQcdM0?=
 =?iso-8859-1?Q?oO8zoYbaA0Ogjn1JlYvgFlWNb9l14E/MKzsMDHE4Ivkju88JU9WklMmTfm?=
 =?iso-8859-1?Q?BnW9YhU1x4XCn7FL5wHMN+AH9QKx548bNnEGdvLdw3xaeSQCps6y5WC1qi?=
 =?iso-8859-1?Q?AgwMxE7hR6CUznwGFY3BQiyaVhO+/IOJ4Ash8B5KYPpVfPs2gzP1YW6mVG?=
 =?iso-8859-1?Q?MtlVyXdzhtDxaweYXLCYePrRmV2upjXJM5kl48HnQ76ZId/96IPExkKVuH?=
 =?iso-8859-1?Q?qlrCm0QnxhD7uW//0JOWiva8+ck4T2dWHmutsomNp9hZ79dZUBv1YV5IeE?=
 =?iso-8859-1?Q?RNim1Ms/hJpfwoxYnRD1CYh9y3KzYFkMSeU8uyakSe8hdKKexdO4BYkl6B?=
 =?iso-8859-1?Q?liBo5QheG62iks2apfs/Of0ySOHh1SQ6XmO6blXHK94u92/xbLEQmpG9na?=
 =?iso-8859-1?Q?/jb60+0mA81FhZaS01m6K2w4yR1rq+Xe8twznAwsHMO1k1otDA8LOSRpGJ?=
 =?iso-8859-1?Q?TnlMtqns79ego0GpoNFgUweNde2Tg9bAAmPJ7AoezVC/iQTcNU4HZS54Zu?=
 =?iso-8859-1?Q?hzGC2VSAElTBYCT5wi4+fAfYRTO4UH30i8q96+hlm3rv939f3GblMlt9Gq?=
 =?iso-8859-1?Q?U6PZSR1ARXus8PL6oWUqSAnEw3tbVunDpTPbni6qt4CNjupLMypT9OjZpu?=
 =?iso-8859-1?Q?FwmmdDhkKAnTENL5DHup1nRZwqxOYPLMZ/wZrTDomvTsoI9VLq/F2lHxLk?=
 =?iso-8859-1?Q?DHRZTlucmFB5wCk/asITBO5aaiy/CLTgGIgAulIpVV2Azt4s3PGUOZhdZw?=
 =?iso-8859-1?Q?ILGQlk6mj41EsjSnHyU5kXiPMeBHN+SWt1oZcFI3Y/uxnC3SUR8sWkn1M4?=
 =?iso-8859-1?Q?XmFAk+BfYAt94fSYMfZC2qcUmodyFsiSy5YAq34k+JnT1496q8o//hlg/x?=
 =?iso-8859-1?Q?ji0M2SaTxQ1BkQ4577kbIi2bZifjBAGlEMI78JejYurnPbQ5lNZHzHfX/q?=
 =?iso-8859-1?Q?9b+RIVDov1vlykDyw4Q8zHujqzICKF/pTfJlehERRYdvrIihsNZ8hBlflo?=
 =?iso-8859-1?Q?0KtyGzqCCA2exOLeULpaog/+Rz0auLf2Tj0Y3qY4riarIdcX0o/1IYykAB?=
 =?iso-8859-1?Q?0JvG6WPEFplkzbg9zC/jlY7II2BkEVn5PZB2UMGcTJR/jcRG2GLXzTffMm?=
 =?iso-8859-1?Q?5/daLypPMRBjeIo/8v27B/wbFubM5q9CKFKc9q6GmHUgibLJWOqY/LokG+?=
 =?iso-8859-1?Q?FmGRE7Fz/U1bHznlL2jhb3/PpPhFyhi+IA8mSZf+SvDW7/CCmDjRwEeF4Z?=
 =?iso-8859-1?Q?bsu1XJsartjHOQNueCWnSc4tY9xgGPo178?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92d0061-9cfe-4ca3-095e-08ddca59af42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:27:50.3441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYPGu2zJK6Q771CedrIXSveBqlU5GB44B6TOoEDx4iAZJfCPY0NVR6N2FgIqrGFJtjRe6PbUkuc3WQI9NsbFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450
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

On Tue, Jul 22, 2025 at 11:04:45AM -0300, João Paulo Gonçalves wrote:
>From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>
>On i.MX95, when booting from USB, the U-Boot environment is always
>assumed to be in RAM. However, this causes the boot to hang when
>`CONFIG_ENV_IS_NOWHERE` is not enabled. The boot also hangs even if the
>environment is present in another storage media (for example, eMMC). Fix
>the issue by correctly handling the U-Boot environment's location when
>booting from USB. Also, set the environment location based on the ENV
>config and not solely based on the boot device type.
>
>---
>Hello all,
>
>The change was not tested on mainline, but with downstream
>`toradex_imx_lf_v2024.04` U-Boot branch. In the past, i.MX8M had the
>same problem and the solution was similar.
>
>Best Regards,
>João Paulo Gonçalves
>---
> arch/arm/mach-imx/imx9/scmi/soc.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>index 13f13ca7d1056ac5a9f1b529b13e0d8dbe2462f1..2c052c38521793e1f6ab2dc5125afa3b5ca63d0f 100644
>--- a/arch/arm/mach-imx/imx9/scmi/soc.c
>+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>@@ -633,9 +633,13 @@ enum env_location env_get_location(enum env_operation op, int prio)
> 	if (prio)
> 		return env_loc;
> 
>+	if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
>+		env_loc = ENVL_NOWHERE;
>+
> 	switch (dev) {
> 	case QSPI_BOOT:
>-		env_loc = ENVL_SPI_FLASH;
>+		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>+			env_loc = ENVL_SPI_FLASH;
> 		break;
> 	case SD1_BOOT:
> 	case SD2_BOOT:
>@@ -643,10 +647,14 @@ enum env_location env_get_location(enum env_operation op, int prio)
> 	case MMC1_BOOT:
> 	case MMC2_BOOT:
> 	case MMC3_BOOT:
>-		env_loc =  ENVL_MMC;
>+		if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
>+			env_loc =  ENVL_MMC;
> 		break;
> 	default:
>-		env_loc = ENVL_NOWHERE;
>+		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>+			env_loc = ENVL_SPI_FLASH;
>+		else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
>+			env_loc = ENVL_MMC;

If boot from USB, this means env_loc will be override here.

NXP boards always use RAM env when booting from USB.
If your boards has different settings, I think we may need to
introduce board_env_get_location. Or add some device tree
properties to specify the env settings.

Thanks,
Peng

> 		break;
> 	}
> 
>
>---
>base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
>change-id: 20250722-v1-fix-imx95-usb-boot-9e6d760be10e
>
>Best regards,
>-- 
>João Paulo Gonçalves <joao.goncalves@toradex.com>
>
