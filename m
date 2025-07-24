Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190F0C83F17
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 03:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B49835FD;
	Thu, 24 Jul 2025 05:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m6P9Gl61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877A98360D; Thu, 24 Jul 2025 05:09:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D083835C1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 05:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hpo8/wW2z39GUwcJ0aKBUfFT+jiN3p1l1kQf7Km4F8j+8Q7DxpJpBe2v8DFzjNivMp0P7kFgGP28gX0EEnjuQFUEwyT9e/6OS5hi67/3UJyPeYezwk4cNXHKQNhFtj1ZHTe6uYBSnFEVG1Rt1PiSLmLigMFXUMUyd0mqODtRNchqw6FtangbPI6toQXWO4ABL5W35VzX6HLzUFTr9QOX8ks7NqSICSkZn/cEf+87YPzkrnqGocrGqQ4qtlLH7rPprcaebIth/7XUkZTE9fJEJd+Wz27kpEgyrEwKUptw3dwxIqZi7EcyGrjXZTDc1T7XAtD9wsG20Go16cPcrC0hVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92KDtQjZR2cdnKRciUpZExrHlXjYltzzg5gAC/1PFiY=;
 b=b+wwiZsSKtkyYvrLbpQzYFGx1s1e/waDjiIj2mS4I/s9NtUqjFhMvYfvOiOwqyW2GMNawAnFyDB/3FIW9zD4Sv0Gh5XyJyeQAGyFKib58VCbxCQRNSAGzU/3Ws5ZTFsbW0rP8Oo1p+aryiEa6yiiPBRVK2CTD6dUVk4biXZawZE374vJMNRD5r9Mvv1wdh4VXOF+4eVqIn1k6b4y9P0JHXiOCYN5gxz9UQFNVthfZQA/LmOIXtI9bi89bsaDa+0WZ6JWwqYPV8sy682swb2SC4OmcgAbtVYDEQfLd922qFD+ZyVq7dJdfY7CEPzx1Myoiu4LXAwQ9VdFWc2/yYD6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92KDtQjZR2cdnKRciUpZExrHlXjYltzzg5gAC/1PFiY=;
 b=m6P9Gl61frmc6RgYGqN1fGnb6VPa4ZFak/YhffqStIZSerkWw5+lyIxkZ8982xV6huM5MgKG3d7sJqDgEsiqZMfZEMq+R9zulL9Qtu7cgZ5PTiF07Uxrj3tTpxBbU2f5CJSDHvIvp+APDKbd8eoC6ooU5CTooLDVb2Lu2EIuTd6KMqV/lwYL/TyhoesKJHWLXwDBsa+nAFDMDX1EOd33oYJJ1dYIclTA30G/8S8A14UiMhgOOHTC0stlCFD2ipxw8eWEUZe6xNiVFdEOTbmGLUd4pbqN7QJP5H/nSvSwc9kvvitzyycERJP504w3EZBKPETbSovXl6JZLVnatPMMlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 03:09:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 03:09:51 +0000
Date: Thu, 24 Jul 2025 12:20:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
Message-ID: <20250724042019.GJ18395@nxa18884-linux.ap.freescale.net>
References: <20250714203410.1782783-1-jonas@kwiboo.se>
 <PAXPR04MB84591B628A56777F00320BEF8857A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <23c00620-379d-4bf6-b692-86146b386789@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c00620-379d-4bf6-b692-86146b386789@kwiboo.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bde0a1a-054f-4f13-fa13-08ddca5f8e53
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1J8wwLGuX8o8iFwOm22HA2y9FSoBZ0YLUsnRcDeaCkOJgmweimli8WsUi94X?=
 =?us-ascii?Q?ajP74Zz0FFwTgWQCwwSZI35eveV1TNYWvGonf8hgYMRkL0rdgCNvE272aVLM?=
 =?us-ascii?Q?lOg670NV2JTz9uk7T+b80CzLUJAl6RUbpg+V5lwyQLIDKPc5LsHNgKcBNC8j?=
 =?us-ascii?Q?FDZLZ4kSnyYaq5hdnvA0CGz6Uv5vwnM95au+5VDOg3rLMp/qKYXxkBQCO39l?=
 =?us-ascii?Q?YmSf3vGTmfoyrkjHhBkSq99WRwW1bACk78aXUxNzXWcRP/QotaLzlAvySB1U?=
 =?us-ascii?Q?IWOuuftuYRcXAqBvutLVgQLTdzBDsTTxIdECXAYnN5nGuXEz1NOwfkP4FIfH?=
 =?us-ascii?Q?JWmESHt7LdVtV8HOawPwrNysorqHV+SPjm6V5MrnvNamVepJXfdoSgFYC6Ci?=
 =?us-ascii?Q?yExGi9lPrqDjhobHKtuP5Rg0OJ9n044uRHc+WhHgS5SAMJLFbTUJsnnb7k+l?=
 =?us-ascii?Q?eYCbla5h4q9LzJl0PWbrSc3BjC6+7QFfkUOZYDMxvE5/hpVOe1Kl0WNZFET8?=
 =?us-ascii?Q?VXAqM3tTld2sck5wiNWvulv+8sa2EkQg3InuqiM6MAc6Mr0t7Vz+hxXJAjMn?=
 =?us-ascii?Q?3Do2TnmaXYVLFBqNilZ4sz9iMRqDsMK+OwSm4tXnUIvivoY+DajRvTzgcsUh?=
 =?us-ascii?Q?vBMpZ+rgkONVskbEdiRsugALwXMZxy9ref5HplPTsVERjwuYQv0YmfIfRISM?=
 =?us-ascii?Q?qx2O6wg1BccDkcgNrA3uY4eH3pB7Ohg0CykCHlQuv6bsi/cf7F96xu/Xbrhn?=
 =?us-ascii?Q?As7iGmcQRRqnRnTmgXCozJwugjEy7tRv4KlqoSQbMp8+ShDiqdtagkExvOAm?=
 =?us-ascii?Q?0xOZkphiaL2Qj6O8WN25Ua/+ggn4xPvLQP9yIkwrI5pIOBbbLR+aPA8QrvQv?=
 =?us-ascii?Q?3Wf+UytKosKs24o041IGgSm5L0vVcNUpAmyYZ7MgQY626uuY6SFxd7qpW+ie?=
 =?us-ascii?Q?qmnWBzVpTIx1vclyIQIcZFLVxeNAqGzxAgsbCuqaIhx+a1eytEnHQBHCZkWD?=
 =?us-ascii?Q?1/PFHufcUPvO3NRsCUPFGp4G/OLP31A+F3rABeA9HOa2cmK0YF5kxBpfx8yo?=
 =?us-ascii?Q?WjNJ0Io72+ApWMB8eJ4yTD8P68pm1eYfKQ73KyWsgcqlA2E17xdSMJDf3ajN?=
 =?us-ascii?Q?DSP4LEGnc9nbVdY10z0HBp1yotTxh2sTXv6IBW/M9Zeb7noNZ+9K7Y2ck4Eh?=
 =?us-ascii?Q?9AcIkl/ABx7rTGOvUQtJbSa6zU7ty3ZTceje1sF24vvOGWG204nH4OHiyBK0?=
 =?us-ascii?Q?ouMG4HoBDjb41gHkDTfCizf+1t42n0rpTAHUpJ9g9gVhnHkTCZRDg2TdsA6l?=
 =?us-ascii?Q?xy48VOonCDC9EMG6E/qKCdwU6O8vURSRUyIc6qTze3oWoWU+0y3KH1d7qKdj?=
 =?us-ascii?Q?aA5ycpqUv7m0KLrpLlyv+xshoyhv1sErZmWz6GnzJos1xMxCHyfDPP0L9Ezk?=
 =?us-ascii?Q?9AtdcFIoR5YuJswY5CBjZG7aBb6kgzLGEg6gKjZw/zlXqlJXAdEdLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3l5F2bq58zql15e5GLuudAHjkbHgBZglTEtQFEk/RG7E6EHOTXGfT4wdIlut?=
 =?us-ascii?Q?VTHoE003G5gk0iocuvpNzCXRlrMYEq3Tc2bbSSjELgYDwDQZXMH0op259iME?=
 =?us-ascii?Q?WE19AvfzYtB6oyYhM35m9yM4kME2zeZMAIxsr9of9Pqn4P5LuKsblmORTewi?=
 =?us-ascii?Q?bc1kpleGLcOR6Qp/FxbrPjvLcRBCpWR5DgVBD2CbrP63ir+sAT+42oj1KzxY?=
 =?us-ascii?Q?me7WpavTEmeE0Bfd3pggd8Z22ZFqiTB2JWtpt+yyLVKGFJUnrclrvaA8Q9SH?=
 =?us-ascii?Q?ZJ84OQLPvYiuJWvbMtdE+JOyrIWvNEm2Uts18A2KOcyhemWhAF5NUbS6a5p8?=
 =?us-ascii?Q?F6O0aTpAoD+E+SQCzQ2O5eaqi+WX/k7Wxt/spx1KmkO3Xm8ifUQLleuYPVw/?=
 =?us-ascii?Q?PiJUEAkCaS8CN8s/ytwHuuaFKYScatRapPW5yuZ3ANQTzgZtAHdR2sVOJ06i?=
 =?us-ascii?Q?nIjT/4Eqa2T3KZTrKjk87wblawbR7fW/t/331KtMpRUIjqwTSMOt5vAbMHEI?=
 =?us-ascii?Q?p0TVKY8ABc2kBPONFkyGR9kQ/JYrgr08BmY+Km6qX/j9La4BHe9Ta/hVPUsX?=
 =?us-ascii?Q?hmNhcdIqcosPV4VYzt297VCJfqL+2+rJhBgcJUSr1lj0gaAm12uTrfmAxo6Q?=
 =?us-ascii?Q?dC5E9d3lmms+JnF07rEwm5LDNGlBTz2pGgCIDgUZK7eAcGwnVtO07KGq7hp9?=
 =?us-ascii?Q?TB/U41H1eCUJS/vvYFhm3AviqY6RpiqgkgtkrwYwGy7RkaGHPNRnJt+MISxL?=
 =?us-ascii?Q?R/z19rD6zpsraH++++BiidqyOzbu0jE+cin6+e6JQVTyB38C8nxr/BIgdCiY?=
 =?us-ascii?Q?gRM3js0F+XCDK4dKpeNdNgMMIpNjl9VQHV/3j+zAyS4k+dQpPIF1IRlS+Thy?=
 =?us-ascii?Q?Az+i5J6JkzJvrz5wlda4YT5uvb9THOpMVD9Of+N9qKmklSe8HHlRzkRBwS7W?=
 =?us-ascii?Q?3FQRRgowvM+FupYwrP+RBJhZJF4OofXb5AAbiBi1Bm4rPu2KC6oKZ9MsLwCD?=
 =?us-ascii?Q?fvMx28P+Ml8yOWWYT6P4NxcFmj38B+gFOVTQ+oREbKAxr7JjXpiR0/PiEcEN?=
 =?us-ascii?Q?s+NR9Ri2atK06cw/EFNp+icZN8d7jUa0x0/dxMYMaZhmNQ2qOv9pjkM60FQS?=
 =?us-ascii?Q?IxvaCAav0bL3CTtV9HGSyActx7cjbw8RNwM2eqYO2nIOjrWeXEkXObtPSbWO?=
 =?us-ascii?Q?Vwlk5JRL4PO3oe9Fso6YMK6s6rN+YSiK3nwYwwIg+a88wiz5hviFulONeQ2u?=
 =?us-ascii?Q?dIzDVEZSoIrkJ6zZt0CfRs8me+76jMGxLfdswwGPGBZKgoKZq8ZC3tj9FzNr?=
 =?us-ascii?Q?bXhV4Pk8251TjiaHOhZMFoymtgvhhb6CMKLx7hjMcLXJ4dXKPW1Jvg9ECaSb?=
 =?us-ascii?Q?J5C0sgO5R7vvOCUA6Nhs0U+LPJKH3CBq+iUnDy7Gi6k3vvQilhAxhurZG13S?=
 =?us-ascii?Q?ch8RpCu+QVzOfrDHkAfoyvsBTfH4Z7zX9d0FLfQVItFZwf95sQQZDRMIOA36?=
 =?us-ascii?Q?8HybyjLQUj0Pur0zMcF4g5XqcBx/ON8f+UHKaBxfq28gxtZiqKEE8Yt1jq3O?=
 =?us-ascii?Q?4Cr/FHwRqUyxj+OlJq2C2VP+LibJzz3bIRgcMVg3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bde0a1a-054f-4f13-fa13-08ddca5f8e53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 03:09:51.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zENS7fC3yi2xNUWrySZkiqpejhj0aUb/p3aSwm+XLr1eAjtnN/3FvBbkn7JmJr3BPIGTMK8gZGDG0w1D2yaGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
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

On Tue, Jul 15, 2025 at 01:16:44PM +0200, Jonas Karlman wrote:
>Hi Peng,
>
>On 7/15/2025 3:15 AM, Peng Fan wrote:
>>> Subject: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for
>>> RK3528
>>>
>>> eMMC erase and write support on RK3528 is somewhat unreliable,
>>> sometime e.g. mmc erase and write commands will fail with an error.
>>>
>>> Use the delay line lock value for half card clock cycle,
>>> DLL_LOCK_VALUE, to set a manual xx_TAP_VALUE to fix the unreliable
>>> eMMC support.
>>>
>>> This is only enabled for RK3528, remaining SoCs still use the automatic
>>> tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure
>>> manually for RK3528.
>> 
>> May I ask how linux kernel handle this issue you spotted?
>
>I am not yet sure if or how this issue may be affecting Linux.
>
>This issue turned up when I was testing eMMC on my ArmSoM Sige1 board,
>where a simple "mmc erase 40 5000" to remove an existing bootloader or
>use "mmc write $fileaddr 40 5000" to write the new bootloader
>unexpectedly resulted in an ERROR.
>
>When using the generic-rk3528 target (a minimal generic device tree) the
>emmc module seems to initialize correctly:
>
>  => mmc dev 0
>  rk3568_sdhci_config_dll: clock=400000 enable=0
>  rk3568_sdhci_config_dll: clock=400000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=200000000 enable=0
>  rk3568_sdhci_config_dll: clock=200000000 enable=1
>  rk3568_sdhci_config_dll: dll_tap_value=2007600 DLL_LOCK_VALUE=3b
>  switch to partitions #0, OK
>  mmc0(part 0) is current device
>  =>
>
>However when using a real device tree for the board the sdhci init seem
>to sometime behave differently:
>
>  => mmc dev 0
>  rk3568_sdhci_config_dll: clock=400000 enable=0
>  rk3568_sdhci_config_dll: clock=400000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=200000000 enable=0
>  rk3568_sdhci_config_dll: clock=200000000 enable=1
>  rk3568_sdhci_config_dll: dll_tap_value=2007600 DLL_LOCK_VALUE=3b
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=200000000 enable=0
>  rk3568_sdhci_config_dll: clock=200000000 enable=1
>  rk3568_sdhci_config_dll: dll_tap_value=2007600 DLL_LOCK_VALUE=3b
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=25000000 enable=0
>  rk3568_sdhci_config_dll: clock=25000000 enable=1
>  rk3568_sdhci_config_dll: clock=52000000 enable=0
>  rk3568_sdhci_config_dll: clock=52000000 enable=1
>  switch to partitions #0, OK
>  mmc0(part 0) is current device
>  =>
>
>or something similar could be observed.
>
>Please note that above code that is run print out the value that would
>have been used for dll_tap_value but it never uses it to configure the
>manual tap values.
>
>However when the dll_tap_value are used the initialization seem to be
>back to working normally (single cycle) and erase/write starts working.
>
>Possible that some other underlying power, clock or timing issue is
>causing this discrepancy.
>
>To my knowlede Linux is using interrups during sdhci card inizialization
>compared to U-Boot, so Linux may not be affected of this issue.
>

Thanks for explaining this. This patch is delegated to Kever who
knows more on the SoC, so I will let him to decide.

Thanks,
Peng
