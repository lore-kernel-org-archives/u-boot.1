Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE99D29DE2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD4E8389A;
	Tue, 13 Jan 2026 09:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c/VyT/9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80BC883655; Tue, 13 Jan 2026 08:51:03 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D2383015
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ6bEmA0vMYr2O/n+WzjgJdMeXFpqHdPUSxHFKWFdhZ3qO9AWmW6GveFhDV4U1uQiRE+nXpUrSkeK6GUE0gYp9tAzWuow+S4I3UegxFSjwHEFAdjVR+iBj03CDwE71j6wxg3BaIeqS8wYUTqbMKLzv81zs508soWFhgddCQoH/XIZCDRFwQFfM/d+hA5DEE7RHnRv7wMSaBLUvmrM9xFzXB0jY7/lQZBksEyOzAk3rR2uITPNkp5TbxVANw7gP/Fj30bAICUiOtyD0RTg0AREnNSE3DV0noh6aktxIIpR0p2JU6HP3XN9hwaBSv746IMWHfGRYVlImrENltepZIqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgZHnzgaolot/ClXzabKPNCApGuPgzaV7WwXJBQeYrY=;
 b=CC7T+E4xhUOYMJz/06C8zCLCy6jCwZrKOIe+0NuJZkcg631HLJTWXo+HtIKquaN3W3skihnVe2+aTm9LL323Ds+LerhHULc4tmwZtJKWgHCPVVMjapqQHaTjK+eqQPWm0Xk68BtAdS3YFWhpGXgChj6RB+x5MQijmtPH7XVQ9SzcUnwulIBnqNG/n5ImWcmUU1E7Qllojh1eOIGmApiR9V5MvgcpEJTcvNLG3xVzOt9YARgYywEBrubOXDG7Jo7twwTB5D4Ipi8KarTb4L9+r5KipaJ49CWue7sU2ajJwS5Qh+D4Nxzix7/w2qEj0dn9VR2iUMhuGnvleFuRvU4B4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgZHnzgaolot/ClXzabKPNCApGuPgzaV7WwXJBQeYrY=;
 b=c/VyT/9v0vwRriYhvxSrwHRQa17tyW3fuw7mtXanMwG1ZQLdboQGCAoxPoe/074TS+heZodqElS2df+DGJ06c4LYGN4dRW0gogu3rhg0qxMS/UHRyrKYvaK7KajaVvnHuSyC/SPUXvokoGDbdpYFllDk/U53XVOrQSLT/HB5OMclAD2WgIxKbNK88Cd3IjatlhoRODuyn2hFtdP4oqDxJquLsAYrzZRE3vbxzRn6H3XkVVl61kLM2KxZfhkrLGSd21cUQZuoX9De2t7anrKajAOJMNfNWiF5VnJuD8MFqrUtt4JkQgNkj+AjAvOWP9qpsPa6s/mxH+F+KeIIGftsoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB12140.eurprd04.prod.outlook.com (2603:10a6:150:30c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:50:59 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:50:59 +0000
Date: Tue, 13 Jan 2026 17:05:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH v2 3/3] power: regulator: common: fix compilation issue
Message-ID: <aWYKywKkaJITY5R6@nxa18884-linux.ap.freescale.net>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV2PR04MB12140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1f4d95-b1b6-42fa-a143-08de52787d86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|19092799006|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6eoTytXGdtX71wfNuLZ6yAiUGgza9FIh95FZVsIqzyE2/d7BGXe3mWa0ApZc?=
 =?us-ascii?Q?FQwptMnom12OsJHfOG6rvubZ5o7zohZztWcWFGklqjrDJvsjL9LNzZMcU9CI?=
 =?us-ascii?Q?hB41pQAYTIlguwcDxzbc6JQbl094DqaU2KRMANyslgBTarEbRNAMNYXhHD6A?=
 =?us-ascii?Q?9sCQ5qDMMZfW9040utOwlVXBA/ry+imv3b2FB6xNfZ7mYlH01bmc5xsXOMQ8?=
 =?us-ascii?Q?vG/jYb5SSrJZLkghOZXDUp+qrRFTX9pTpr5nwaVClqXyOSjSOTtMJPtf2b4W?=
 =?us-ascii?Q?DbeFZJ6akfas79vowFafKhldS6rBORLKX05s+fPRoYHaDQR8yPkZNJYDUElC?=
 =?us-ascii?Q?ZFDO4IphGN2bdIwRng8uQ9shBQF1vtegFcRKLT/7tiVNzUjxZjVvHyy4PC97?=
 =?us-ascii?Q?Pk0OZyFbAnlPUsKBwBe+m3zLSarflYvpgr8+lNdr1wk6UeUNqRkq9wErO1bv?=
 =?us-ascii?Q?LnFsoAkvpahCRjngAIgNjldLh+wpAkklWvAgO8L69bPPKS1ssMSYyhujBWRe?=
 =?us-ascii?Q?D6pgM71XC30nCHsLC1O8sRsDq11Kgsb0pfMIXVCiEHv5ezERDCsrVO+CVrIW?=
 =?us-ascii?Q?oizWhqm+T4DVWDt/1oczXIN4tXTaAjvNlDr64ZVn0El5z46C5fFoekSaHf+f?=
 =?us-ascii?Q?B//1+oVHLOs8TH20xbzEXilKuw58ESqxIIZ6He+ghlQLu6xaTkn0qoidniUj?=
 =?us-ascii?Q?j4UJktzxpN4QNYsJ4isz/nxj2qoB7DZnXROrQ9o/JPqH9CBaGV8C0Ng5d+1C?=
 =?us-ascii?Q?R3hwCYfyO6NjwaO86zAWnholSeVRfRiYxJQ28H2nRiGIy7jqlIMNkO1/8M0e?=
 =?us-ascii?Q?8nN6Z1Ni1kLYjNn2w7wAnKI17psbHao19eZR9EFiT2/JQcJ+RvasmRFktYrF?=
 =?us-ascii?Q?KzOYYvb5AMAls99URGX3oGdnz4sZRxUnPmA3x1qf6LPesUtA5s8yVkO9mXQQ?=
 =?us-ascii?Q?WGcYYFStmv+zdqjjFkOpqxOiD23oBc0NusiEic/ejUweowYjpMk+XGtNQ0yq?=
 =?us-ascii?Q?CDkXLBvE5W+6BFhNrnf9dA/gfbQ81M0R3pEB2ucde1cjA4yRoYh5kPKTeSZr?=
 =?us-ascii?Q?Bc1Lxwe/r1tECMqM6MBniA+D4CgxSEPTPJmr3TBz3CPEhwpwJQKuzByHaNDo?=
 =?us-ascii?Q?vMp/2cNjOHjLR8MyBErS/n42DM6jVVeIv1LA1t4MLwYJTKzI5TuTj0vFBgZ6?=
 =?us-ascii?Q?sYbOT/YcJRVUxNTiwaoFVo2Pc5jCdhFcQp18egjbl7XA8sxaqTHzPwYIbiqo?=
 =?us-ascii?Q?VIm8TZO0ti5eZZJxYBWD3iXmqp7MokVste9z1Lfs3pQYrIZhc/vC7j51gNku?=
 =?us-ascii?Q?RlHbAxlW3CLjr6Z9XlHIZee60Cvoi1RB3cBfgf+erjztl8O0Tue1IFqy2PGW?=
 =?us-ascii?Q?U+To/b0MqLZN6NciPOGjr/0ESgv035Gf/10F9PZH0Tx7FPQTVqjP8BEcRL8A?=
 =?us-ascii?Q?zj/E7kpeni50kS1kXiqxfV3C73kmNkcR8C5rVUlWUDAQ0FXFif/dFhci3+ai?=
 =?us-ascii?Q?tAoh+Irc11iNRucI/7xeeSXJQyuSFts19AeU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rrr9z+AhzR/wzAtfZY1SDrVe2GsCXbeQf9au96tQeRdA7gOEjbAgwmwmXEZh?=
 =?us-ascii?Q?eKgDZBS1O/Wcf9L5Q6sa5Rtm888Ug5XLJZPDEBcrmjFziT0zX+Jd0zZD/XP3?=
 =?us-ascii?Q?PzZ9acaZ3e9x+xKr//BqUaRK4Yxv7v5C+GVnxBM3/Cu5gsRiiyPkzOSb4in6?=
 =?us-ascii?Q?DXZlSoZXAyIIuzcneSC+0DDrfmLMZkq2nJ2NKI4XwVX/wDVpmzU6+urCUY0l?=
 =?us-ascii?Q?p8u2jNTQ0LzcSzgss018l6pMqRIBJPEhepx5p+gfs8YMSEzYvwtZOkQNzpwJ?=
 =?us-ascii?Q?KoPpi3352pl9F2Blbd4ep+s1ijCoxbOL+07cg5OZwtUPF3S7FjkRyVEKE5A2?=
 =?us-ascii?Q?JFXkNovcsSJUjzGJL2RmnAVKM3HwHtYPUeNqWHJ1LlqO8cmL0FHfjsrvrh1Z?=
 =?us-ascii?Q?WLGP1Omz5jwXOBUXiYCa1k3KrkN9upOp7dbsxBDnsz0kUZG6M1PiiQlCSen1?=
 =?us-ascii?Q?4gQbA0ouD9frC9SsfsiwLx4WPqjVa1lOofDax9vER2ZoLEhmkcoTcLy7GqCS?=
 =?us-ascii?Q?Y7nc/2uqyzfcRrhz7AESraf68cZnARgxsYrC5Ou43FZs/MnDaZYa4e2jcUgd?=
 =?us-ascii?Q?YTtPXCJn8YSNMhWueF13bl7KO3QFQ8X2fivAlh7ZAcFAHNaAQRD6L27VU1sO?=
 =?us-ascii?Q?JCRw2XGxM/ekoAnq2uJ6xKRkjG9UI16iczBTfU2PbnJRlvGQwmyTbVHqFDqu?=
 =?us-ascii?Q?50Fo5TyW18wG16Si614rqmpf8VbkZ1RJlzgw0XSaGcAWTzQVHIVt3TG+jaKk?=
 =?us-ascii?Q?2rTgZTewijtttiH84qekPXbpXuAdHXJA104UJCsKZTmKDTJtFVAnKri1iBqy?=
 =?us-ascii?Q?mYZH/25yR3Wr//eTtveK8lnWvj8/gQA8EQhFCOi5vwlCfXE65QFPW5hBspd2?=
 =?us-ascii?Q?XTsNehPJJiRnK8OifP9jvJm5FBCavToThdArBO80gj8ieYGTaLjp3IC26TVq?=
 =?us-ascii?Q?IuJbxCFLPFOolC2YrFkzro/KnpoEjXIHSB4yCzve2kAYu0TNJ5I9ucsa+1cM?=
 =?us-ascii?Q?+GF8TSBGJCe1ltr2fYB2Gmx3ztXDmT6kVw158LdNXCVqotJcOQ1FJaOSiO5+?=
 =?us-ascii?Q?A8bJ0ONtdCQ0pVDa/4ByTrPxJ8skaFxMApgKKi1nOB0H0XzoC41hciR5QwGO?=
 =?us-ascii?Q?21XdZQjq+1QAFNogePbyXy3hdB+CT/hH+DIr36aApy0rX9r2UYV501IFr1S0?=
 =?us-ascii?Q?Os717iTlquc4HvZytxVmRai/otKvjGsBAqqIW35v9ifcvQKl+65g5Gy0h+Qq?=
 =?us-ascii?Q?FwWzNux45JrOheKYVR91TPDHweTRRZBK2HN67hdaqiYlwKqQOJawBI0RgOQr?=
 =?us-ascii?Q?bqLiVHah5rVfLEGH1tEL+jhVzTLzR1ZIJXMYwmjQRReZH9dEazlJ8HorB30s?=
 =?us-ascii?Q?sqJbTvZ7BEZxiwD8q7o5yH4F0yLIQfXonXaQ2587dKOqBTZ6VgT8r4pnROHk?=
 =?us-ascii?Q?c77JxzGhg1yROL8kuY9skviSlYDsBwSS0dEeAzclJRl42Z8OlKUJbFto62NS?=
 =?us-ascii?Q?2FWd90q7So8DAXnm4u6sTnUMlO5DnAnUzEZBbjEmuHi60fadLe3tD6bz9cSy?=
 =?us-ascii?Q?LTydP6In88WYcvuqtImV18xoE6ZzRfOJt6z9YnmDDnjMRlbGCpR8C9YgcwYO?=
 =?us-ascii?Q?bfEk8RCX3nGafmnx+nuMkEAc0N3nvHyFZEnQe5NAUulMwtVC/yH9HP6KCg0M?=
 =?us-ascii?Q?3eqp+p1jbaCP8Dn+a0OAU4po+3wJ6GEzbfn2JstnaGzjE+4tl1SXQflNsglZ?=
 =?us-ascii?Q?iEeh6zzq3w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1f4d95-b1b6-42fa-a143-08de52787d86
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:50:59.0759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRPbKYUiSZy9PSmYipF0K/ANWKrFXlhSmRHoVqLWN4OtPahR9PSCqlB5543izoAWhoSm6/rknGvcwwoutg8beA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12140
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

On Thu, Jan 08, 2026 at 03:42:49PM +0100, Julien Stephan wrote:
>If CONFIG_DM_GPIO is not enabled, compilation fails with the following
>errors:
>
>aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
><...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
>aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
><...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
>aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
><...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
>make: *** [Makefile:2029: u-boot] Error 139
>
>Since the enable gpio is optional we can conditionally skip these calls.
>
>Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
