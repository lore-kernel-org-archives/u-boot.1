Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16414C43638
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 05:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F38484832;
	Mon, 29 Jun 2026 07:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rqiKx5X0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D79384844; Mon, 29 Jun 2026 07:23:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E272843B6
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQGVQRIAuUqYzNOGNiRd3DOJ2oPWGDDT+h7FpwW6UJiZJlIyOqQpQ2SG3p/vQxep3EOSletLtv0XxxMXyX5vi/p+IGsfH7koADB2vSwWTgfWpAlrfX+LSfYPIaSkb+Vj8l3KkHPCRHgM0UHZT83LEQPkVrMTH78V9OtfaCe9gw1T5TVHjBREWcHySl+PT4h3cX68IfJZmR2An9KToCXEQNEmfp1hKfEHQ3S0uAQxI+fTzS+4klMPDAEjOAfNmkZmTPw/082f7lsPsLdduAhiYqgQX+JoKe+7NcWIPhiIqMPSMezrtkPV5z1XQd4Cr7oXj3jwmX/vn3HPq4WfpjQ6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0WXRQQqCzY273yLY4kBDP3wS2W+sPXtip52H/SB6aU=;
 b=Y7QtGBrDElebxUHTVOc2V54dp91F3LIEu1HMRfKDUqyDD6JBkYR03JEOCaJtjNvv4XZOTd7kikqqt/TpFIVNxNlmZgE1eEVfv0wqIDvUg1B03mkY0EgAnI75oROBD0v7TIS0cuF35bRihF+ImIoda8TPOg6f+qtYGkZlNFuCBdTYUVplkWhb88qkm98WR8+WRHM196FDwqpkFmTJFw7IUQDrTHCfpjaU2vsJm4Jkxgk7ItdMxL81ZA807L43bdIs3Xvt3ef8S/pUv5Pc1ienXtJGX31FAsOrHIU29VHbsC3pOzGIA1+P1Q9LlgevFiMoslKylsSItS5omDv76USa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0WXRQQqCzY273yLY4kBDP3wS2W+sPXtip52H/SB6aU=;
 b=rqiKx5X0tqastzkbz/+BQLrH9NRyPPah3at3llYUoMYF5GDITUUD+xjPafZE3/XihAlUPHCkx91IZxFbjuqw4l++gxei1Y0WI+6R6EGzbec2mXmLi+fc4gImbhf7Q4v/v4M/kQb7PSURlrXpAkK4cMDCFAzyTbWFM0HrenHnFIksfrdAjfHH3uIamttluzFZ05DGya6PHeiF8L5PIz5qB9dsoJG6RXEd862vvjnTngkyPzjHNacmVA3qztU3CfDIUjL9TKaiWvrvJvjQcnODZOkA2eQF349wWvZMh9GeshTBEztBmJOa3CpTnXF9c3TiDAyvMyCeQ6GJRbs72p1BvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 05:23:43 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Mon, 29 Jun 2026
 05:23:43 +0000
Date: Mon, 29 Jun 2026 13:27:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/4] mmc: dw_mmc: Allow use of in-spec voltage range for
 vqmmc-supply
Message-ID: <akICK2m6uxqKdc33@shlinux89>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
 <20260628102527.1247889-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628102527.1247889-4-jonas@kwiboo.se>
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 2613a448-2cc4-4614-f531-08ded59e9628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZGhLSVKxEDPPR92knT7VRglDZFQwxOKp7SETcfuSwySEF3x057uMfinZNxpVdVqzACGjcja07Ti04PwrPbFj/Wv2jyNSM6WzEe1s/7tNFYH59cQHDasdtfsbieWRd+gUTZ2SVvJoO9PYmcdxcwtvrlpcaFmjYNIUn/s8+lDAnGaCi5bw49AR2DQlSzkjYXWUji18jyYX8wT94puhUIULsD+An9vL08jkp1er3dgB73FEh3UjkM07EQJ9u3v6fVjllex7ktilOF21sihgQGXHVz4s+4b+pVU3SyR6f/JFVZA4VAVihas0/DdRZhaHFo3pb3M6D2onV1dYtFFzHEzFqpPv3XY83sUkItBwHXFvTLBmoGc9a9oyE9crWhsNjtz2PT12UxpdB3601blHYGAk1lt/l1e6NWVbXhL0dU/+9YkG+rpW4S5FEMXlRgaozeQWwdlVPUXagnHVrv40Emxeep1PvEqkMC3Xj/4SBWpyiCGAXWrNXvzsHOVSdXivzbUdaM1Nc0ai/IN/3//KpTCC1trTfvmngD52cy0PvcSuh1PJl2wWoKS5VcaphMnXyiP2tJsx9XaFyXy1/HFlFobPlexYJ1egBgAFCv9bQPYtBGNOUKHUD39+7PgfkiYOPD2NyV2pxnDxWbbtkstasYSnxeujQlNg7Py1h1X8OaaYvRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpjfoUHxC57+YqJDrcML+yxqaG4nhnIQh28vndNBVwmywDYJd0oNHm/5z16S?=
 =?us-ascii?Q?Uu8YR48BK4e65vvscEZ2aKYdMGOpUDAsqF+0E5QMkSnT9wuG1Msfs6eyQkZG?=
 =?us-ascii?Q?sVX6S3mcbBTXk8yxkVhEuN1EOZ9ui1efZssHozzjZKwaUxYrB+Bvo8f0hE8Q?=
 =?us-ascii?Q?0B3GKJXTB/ZH8n8a9hkkda6kK0gvNbHkRjlJHuIMZnLAtVmAws5qzqQijdc1?=
 =?us-ascii?Q?eG4WLGaQA9xx/i74+X58gD7gjz2eETh0TtKkeGeoVWELVJccZQWJqI7hggg6?=
 =?us-ascii?Q?ivMXvxx8C6PDSfZC6Fiu/166EhOkGLgjFKB0SOW/hlSUk0nhyHqnu+r8uKU+?=
 =?us-ascii?Q?7XKF9B7dkgYnJ9wK31Z8Jl5xSdU/19TKDHUbJR1edwnmirKX1jLUALpiaijK?=
 =?us-ascii?Q?kC2o+M8NJ9sv7HKNJKZPxE5Ppofq/w/j7sSiXsphhyFG9jMMjZeRp6Ya1JQS?=
 =?us-ascii?Q?8mMurOtp0o3aKcaIki2GGfg4v1+0FPJsTVgBKudn3XAIVrg+x4GkG7zW3bW2?=
 =?us-ascii?Q?pcoBsX2tKsK9hGdJaI8jPTM4xBcPDXmMyxvCfVAbNC614hVLzEYfOBfgpWMz?=
 =?us-ascii?Q?ehJx6o3/yG7jCfZApqXxZv/O6AAML24py+0VqbNHYAy54mmORhOZFRV5+6vD?=
 =?us-ascii?Q?KQXLEZFtmVWjos9KmYpvqmxxA2IlwUqOcKho+hIDLy2q/UKuPgqkJ/i14xww?=
 =?us-ascii?Q?Zjrv79soOATA8EAUV5H2lvWtIqTd0Haw/t0lZ6P1CY43sECcrPCyUfQnXtb9?=
 =?us-ascii?Q?k/kea8tVA1i0kkRX9Y4lTZv3yiE7kFLFMvs6zY9ynUnVjYgWef3je6McsXEh?=
 =?us-ascii?Q?EYHNS8I9lekIsZTHHGt+cjH0dSKtLRF9bwIfqd3gXZMtTKaWa2LZVczAT06N?=
 =?us-ascii?Q?bauH4tARyaotoXIJ7xOQ5/wytq7m+9RtbwMW7up6VXFk4o/HxI9kY1oSKoYT?=
 =?us-ascii?Q?yKSGTgYKhaiaHslBko3R9HvWTYOw8YLna49L9V4rBYw58qN1Cdn8+LQY8GVO?=
 =?us-ascii?Q?T7uEf+qepYtdmOy31geNFjuc3VjLZ29ZZyb7MVuTiutFchf7+tOegQ3C9Sne?=
 =?us-ascii?Q?BnIlMlnUwscmZ2bWASYcbQBn/ODWb6BtyAPEamBy983oUIx/ynePHUKRYQH7?=
 =?us-ascii?Q?pYnT8ai8o1ZE+hPhXKc/qnPqk0EGRFU4wuxA42aRyXGS70bx5wPpKpWuArnD?=
 =?us-ascii?Q?dMxn43PaCfNzY9u8GxzQseoo5H+kMykFZabdiZzCG68JRtv/1KXmD/ne7iAV?=
 =?us-ascii?Q?9LF/0nIy4z/VJKy/si0x1VtmsUN8mKBfKDkkcPUMbkYbzFDAM5Za2zyLQ4JT?=
 =?us-ascii?Q?RsBMt4hHZgWIjdwcS4vPCXGCKWF+oBBkOgmBmDpw0EzXAC4FcOO1Zp0vaEz+?=
 =?us-ascii?Q?aihn5vndKF4zy1vfelkwsiAWIWCkkXVcWYhcVPXp3FJr8HqDvtzEuOCP0SA7?=
 =?us-ascii?Q?Cw1mti0LP3RK8rkWTvv5wFbtAyk7120vEopfyowy/jEfefTpSZENZ7/z/h4u?=
 =?us-ascii?Q?ea5nxPmwkC1MECi+KAlY8V3aUa8rsdODYAtIshevRxrhrw8VosFienbtXizM?=
 =?us-ascii?Q?oroD++yrlfnGsYpLF8I08MbF0ITnG/ba6fEra7eNMGgNu9SW6dpNZ01WbMHI?=
 =?us-ascii?Q?zjRYJp87lnpmtNJbZjYi6C/PCnS0v0RYU4pmAh/zgqSJgbMltpo4VJk3VUD5?=
 =?us-ascii?Q?NNoFjuejpM2mjT/MVnxGcHeG7w/60se2uBuJCdiFCE3ZmogwpTJugKrPMm3g?=
 =?us-ascii?Q?C6VDStdee4lXpawgtsP/0KbHIJsx8QMCW8VHdYnPQaokwoTkKokB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2613a448-2cc4-4614-f531-08ded59e9628
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:23:43.5896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kYpce0eM3k3HWKkwlvKwHYUdVM3ZJ7n0mYSlD0mKGrs9Au6fPTJPISv7qfIVKlEVzBbMyzybfcSb6PQw3eQ7S5IZ7PyaAxNgcIUHeEP+5x+x011Cw2sR/FZWVPiVuMC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466
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

On Sun, Jun 28, 2026 at 10:25:25AM +0000, Jonas Karlman wrote:
>The Rockchip RK3399 SoC SDMMC IO domain supports 1.8V and 3.0V mode, and
>the 3.0V mode is within SD Standards allowed 2.7V-3.6V range. However,
>the commit 0b75109b6aaf ("mmc: dw_mmc: return error for invalid voltage
>setting") help enforce strict 1.8V and 3.3V when setting vqmmc-supply
>making mmc_set_signal_voltage() now fail for MMC_SIGNAL_VOLTAGE_330 and
>leading to an improper switch to MMC_SIGNAL_VOLTAGE_180.
>
>Use regulator_set_value_clamp() to set an SD Standards voltage range,
>1.70V-1.95V and 2.7V-3.6V, I/O voltage instead of requiring an exact
>regulator value to closer match Linux and to fix use of 3.3V signal
>voltage on Rockchip RK3399 boards using MMC_IO_VOLTAGE=y.
>
>Fixes: 0b75109b6aaf ("mmc: dw_mmc: return error for invalid voltage setting")
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
