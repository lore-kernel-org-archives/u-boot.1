Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD72CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 06:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E10E8405A;
	Mon, 25 May 2026 08:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NyMhC0bC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AEF784671; Mon, 25 May 2026 08:13:36 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CD98404D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9ZIt9YuJTg35UKhOGlq6HYbGNQTmAEMlShN671zjjXWZrngDvtN6kgSIS+0q3qMwcTY8XrHUnpM0LZb8UJq4Q6tbxkoGbyq0cP8GDhmT8SWDTZ+CstDqkf/5nZkQZe2w3dDW6zBYKSWkzpR3bUu0I4M0L6O4SQdvweARNwe3wp6+I4gnnrF6W4eyhuvgdMQ2MamgWg0Y3FMKuIcCaPIZ/wC+XeZun7yX/k7Kb1H5dmUroArbHSAVQwsVZfkEDo1FCkg8zlVCvq4JxtaOzeIJeI9/TlswXQhe1HfsC9bEbcuTlLs/P4ju6luq55p8QEyxv8zrYKzU94NKk6qB3Lzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17PhXX9y9JQ68uu1Q7rXiACzS39nc+jG9l6z8RWDzrg=;
 b=gmLAGZCiLaBoGr0yeale+9ywx0DW82G6vowL+5TBhZYrrDdw9zXBBTdD5o9P4f5hhHC/UrzhEPlwZMI5couwYYjqaf5eXMcQACuMGect8MK5T169dL2Bg12SccCfHWll1s41vnID1XVSZZnTsDv4rG0AJ1uwQYLOn2641D7BCa4YlTXs586xbH96ZO6ETfEr6fQ5yltkiV4MUH0NnhWqMfdPl/9PDL1j58QkU4NMxwU2OXY6TVdKugncvUycBC4UWwvFSbwrke/gtbRoaSgPIp+Pr5r9whGuCp1cDXi12bdrBtuIEkU4t+dPWgJFJWM1KwUgKFg/FPym3jUHfvbC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17PhXX9y9JQ68uu1Q7rXiACzS39nc+jG9l6z8RWDzrg=;
 b=NyMhC0bCKFwzL5w2lH8AE/fNvo8aF4oseACc6xg0qaXU5nQLn3ilBJ2Ftd1cP07+WbLyd/sB/WDybDgCp4OrTm9eUAdQ+FpdsdiTVTj4W/wVHzoI258Hb8hv12lUZLBnc9ST+/75ZwqoFNE9eYrbyTVXw6JekfTPKg3EHkiOzZ1PxQHBI6cb5szK/pvzMnohNFrRjARR/fGqgbDYC+yUp+XSWAKbl+YqAKhBNvhgqmOlBI4oF9j9hwQlGTIU5EBDC3EhrEG0kDeQ69PG72NCbuNb/MuZ5+Zpl52msnkmQQaJpycu1yV+68VOEhMNosW79BaT2nyBupZCOvKk0dK9fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:13:31 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:13:31 +0000
Date: Mon, 25 May 2026 14:16:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 jonas@kwiboo.se, festevam@gmail.com, uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH v2] power: regulator: Fix power on/off delay issue
Message-ID: <ahPpPfvVqPSR3fvl@shlinux89>
References: <20260522071414.1155344-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522071414.1155344-1-ye.li@nxp.com>
X-ClientProxiedBy: MA5PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::13) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 249fcb9c-3c85-471e-e3a4-08deba24becd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|11063799006|6133799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Tvzmbx8/ZECSjFhOzom0uNxwVXApbHRCeuv4qtunhMnSIKFxLIMWNT2MovFx91Vj2yeUDoMKS+tzsaNwJo6Q4PEya0DY3zJ6WuaRpboPcmBctQPso4/7z806XskEY3NF9Fdw40BgN3+mkrQ3sbCAuquMjg/1E1tS7Ez7VI1UNB7MZlMWTsFtcAkJB1AXMCaZBq43/q+YMy+2VVqBQj+1zFEGKqs+5GLXbXV3U1PcHgnXN8fg+nSGUJr1v1uSTg7JyKN0IgSZvNaaBY3+SduHHfq6uwDOb2weinoVtsX0tUeRwgdSlYIUE6VMcnPcsfVGDpS9YIPNllyvBT8uz3ixlO2uvCLmmp68fGem13U4ExsOPKULY+ETKmI0Xxjl8WHpEKiWiZ31BPe/fg1qhPYv/HFrHvt7B1cGAtKx/gBCcChw3HPyJXszl3zotZ004Gxu7Cwh+g3t1jUEnHvnTxu/ppaBywrLy9RwjMREvUF9kEVc/2RSg6wzw6IzgKCqXw81e5P+kVmxML/bzFXchy3euAUaszVVvqib4To1jz0o5nR1nLgmKCkU8IrIhNXNTAR01c48GR9vyhcZNwZbnBnGfx+YNUMurQ1IRTltbfskfmYdXWGNgLsPvcx8s8XiGhicpoJZQK80LSOFHLL6010AncC5l1Fc+Jv0Srg1ZHxYvqzGJ4V3cfvfDStpwZiqeUuNRDvjOS/v1xXSeqaMXkewRcMcpYcloz9vg3rgKHTtC0MIJjtD/uu4uYqtuBvGVo5C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(11063799006)(6133799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jl2LlsTdVQWVQ7nHz6g4csc5oTpY/yCXuUK0Cvb89N7ZVl5a61JCbjHTTh5m?=
 =?us-ascii?Q?QBLUiYTp8lgeEy//8xT987Y61RsKwGdhz2cqkHcAs/cq+eQVJZSgWSXJGjFr?=
 =?us-ascii?Q?bsYW6ePhJJWzpB//Ch7dWteKfFMP3X1LiZPLJL7WXjsGyZhkOpICfEXMZq5a?=
 =?us-ascii?Q?tsUtf+oAoTiah0Fk9nM0f5AU5tqXMOxoje/bH/K7jO8f7vFT1552LLwxqk77?=
 =?us-ascii?Q?w2Oq79W4ppL0JKrk12BNZxQ7q7WDVw5ZLwfI9e9tzDMB0D5gU/NNqRHCmcxt?=
 =?us-ascii?Q?oCz7JagVe0OY3NSl93ldJhN+UvhaK0Vf6Z3w+u3oBKuX0wXjyHGJiU7nEmBk?=
 =?us-ascii?Q?V1PU2O2q2JJZxKGMc5J5Refqu84w0oKHyrQT1gmlHZUNjxJo2sGiiM2tEYjZ?=
 =?us-ascii?Q?zmQI4DhoAD1QsoBGiSrvB5tZfKzX5Y8XOyEUnE6AibESN3Hn4srrH3oRZZV2?=
 =?us-ascii?Q?MXA2QTOxFLXcgMhDfpQCqSWHs9mKqz0ME+A8CX0VqgorzMbVOF2KzQUAW8dn?=
 =?us-ascii?Q?fuNIhwtXz656qyJiLM6rWfqytDUjazSZ18ZhtoiXNwY/4Danz45amUDNLkB4?=
 =?us-ascii?Q?5nlAzi2ffukvfzvYUZB4opJhlDKUAXj7eEMrpbmRT+RFK+YBVk+vKsuFxrP6?=
 =?us-ascii?Q?AGEP4UOh0LsEkiZRnrnvV1DCehmLikZLkW0uzwbbMlTgoaaVzhMBQZ2dS/UD?=
 =?us-ascii?Q?rfoS1BL/FeMwFze6jFMDIgceK29sOPTrqyeP3gxBGgyDu10AAbFY8s6l7Pzr?=
 =?us-ascii?Q?myuzp6xKc9gYUeqm3VJ2+G89zbNfGbeNZrXABMrhQ0Dzal58eqwMkCjfhhxM?=
 =?us-ascii?Q?H3cy7/ZOsl0huSX6C2h4vWxrGh5+o8uXiXqgJGlp8zYVhKUsB1TWU+PZdH8X?=
 =?us-ascii?Q?jSXbVPPlpHLNCIcW/qbKRlGGuT5zYy29Anthit/N1YmmJcMY+XkrStORzgDR?=
 =?us-ascii?Q?ulNw74QUFuxHGXbDnYDwzBpXuHN5BBcz4uJiusBEa2OUR4A4bdg3PMEXknC+?=
 =?us-ascii?Q?44vgGGiO+6nm5W+1pIH0kYXt6uZUx1r/eNsR8QcWMnVXuv1RcmBFH3r273S7?=
 =?us-ascii?Q?++LGfKwdSqdQzEIPRWPW0d+Tisq2xPWU1oHe8/Y6chhbVYYcGBisiFks2trz?=
 =?us-ascii?Q?uyH+GUDGUSfmB2AKUMmVgnC775pJGZTazXn+G7nIJt8DxdKEaTynais18mqq?=
 =?us-ascii?Q?mv4cUcrCZIHIWPmws1TTuT0Wm0w8CM82GjU8raIrsmHYxjI2baa0II/d852c?=
 =?us-ascii?Q?YZgbSG96MwgBpzQqF+FWpq0dtp2EfqAXiENHc8vTBOZ10/4K4i5r0lc1tB41?=
 =?us-ascii?Q?hSa7pPcSZktM1jjkb8mufWIIGhV3lUMPG/X77J1DdSsG/D/zj2WhbfowKZ2I?=
 =?us-ascii?Q?a2/2OcL6v8zdl/ietgee7QCY3PtYgj4x33vdzYuIciq+4nwUmXrcW0JUVIe5?=
 =?us-ascii?Q?FvUqL546di8DcdiPNXP9v1jPkg2isFhGb+3ooB59PCe/E1txC2kNH2JqJ217?=
 =?us-ascii?Q?ttJRySe9SptjYiog/MxHVJkv4dAbOnwPt2A/VnE8x5AXx7MwfGQGj2wSdI/k?=
 =?us-ascii?Q?ixOSX1yEtZNRRUgoDwcqtKC7JSdJ5mFP/K4wnDTYUibVuahWDVmCg1ZiydAd?=
 =?us-ascii?Q?pM/6C5NopbHztT1AECCyjqdzkAPBEEub0eAz00wDsCX22qYm1AE6mEyNet6G?=
 =?us-ascii?Q?35Fi/4Xu2tEHiuT6XHZlMBHG3CaL4OSNg0cNqulZDXiwDlYO77V2PWA06cwZ?=
 =?us-ascii?Q?CBcElN4tKg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249fcb9c-3c85-471e-e3a4-08deba24becd
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:13:31.8385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fnmS+xHNelRorzdftcQndD2Epp3AlmbXdXFPizP6Ut5aphV4eMG6bAl8+1psSRtVC9+1OtqMMI+mEyEgpcfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
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

On Fri, May 22, 2026 at 03:14:14PM +0800, Ye Li wrote:
>SD initialization failure happens with some UHS-I SD cards on
>iMX8MM/iMX93/iMX91 EVK after
>commit 4fcba5d556b4 ("regulator: implement basic reference counter").
>When sending operation condition to SD card, the OCR does not return
>correct status. The root cause is regulator on/off delay is missed
>in MMC power cycle with above commit, so SD card is not completely
>power off.
>
>When SD startup, the sequence of MMC power cycle is:
>mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
>-> mmc_power_on
>
>Before above commit, as a fixed regulator, the GPIO is set as:
>  GPIO inactive (in mmc_power_init) ->
>  GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
>  udelay(2000) ->
>  GPIO active (in mmc_power_on)
>
>After the commit:
>  GPIO inactive (in mmc_power_init) ->
>  enable_count is 0, regulator_set_enable returns -EALREADY immediately,
>      so GPIO is inactive but No off-on-delay-us (in mmc_power_off) ->
>  udelay(2000) ->
>  GPIO active (in mmc_power_on)
>
>Move the off-on-delay-us delay before setting GPIO active to fix the issue.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
