Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B273DC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 23:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC653887D0;
	Wed,  1 May 2024 01:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SA2h/6lS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027EF8883F; Wed,  1 May 2024 01:51:14 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D508816A
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 01:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZcBDaPmUGlBHezBnlN8wYVfOYoyYJRxJQi6mLOnkYFi9eKTm9gt7Ct78nPgK5FGWA30UA4UTXsTX/XfMgnGQ9WkqIdHA8VnU7FuhFHKFrynoRpsGqIi6YBdcBHnMHoPs9kzbOzXisdJKg/oD0/zhGHT1sn633EGR26Ore4Rhv6I/nAqd6dU7Pt53hAT2oH1zogO5T9IDuG53Db4mzIh9Hu1/MYjk7eZdWPgVMqTSb9dl8FrY7nxSegHXvRzZelaRgNKXnN4j7IrQqwobx7IYcicezF9XoB0j449jHEPwYWjWLhYQ9Wgjb3UNEY1yVMnYxBHGSqN5XBovvTDEKjKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ppfhWvJcw9nu0qdkstcEjy2S+BKzn+/5vEydqMCyJE=;
 b=f34fyxZ8AFlmKQsKbtX2FysYyO+myZ+eg2An+1b0WX6CV6pz+v+BPLW6w4FKJDLCn6PYLdkgXfmlMTpYAkGaz0Y4rTXlY6uJcPGK720ZhRJk7NTYO25oqrrS0DCsTuH7dvtynBlyGOnWPjxHSvteDyOBf/tGbLdXI12DTanMgdJnPtPscBmNPwN5s9EKSS1nqWpyUGsxjZkDq+a/OANfZaBpqvTfuoIg/kQ9VyGFpFWcVlxigLX/Em/rN+p9uM9Fy4kgtFtaPU/uYYqcNZyd/pYhMFYB7YaCC7M5vMKbqilNE9XIyZsEFd4TZ8J8k1w9ZsMAm6b7WOZp6Hxp69PpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ppfhWvJcw9nu0qdkstcEjy2S+BKzn+/5vEydqMCyJE=;
 b=SA2h/6lSG0M1dlbNKIvXFfeqjwBUlz5r1Yd86nk1YQZB9KkqNDO/zZNQ3DIOMWKLwGM6nZqaSVe8EfAU750smuuCzp932jgEOLWzOLmqX3jn26C7/xK3xyj/LEhlpNVwwh9HlhhvtAKeH9yPypPTIFFcsASvYUJhCp63fw5AUSY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 23:51:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 23:51:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 32/33] arm: fsl-layerscape: Remove <common.h> and add
 needed includes
Thread-Topic: [PATCH 32/33] arm: fsl-layerscape: Remove <common.h> and add
 needed includes
Thread-Index: AQHamwNv9iLjBXTRLUWyN7zGEsZ1eLGBfGnw
Date: Tue, 30 Apr 2024 23:51:09 +0000
Message-ID: <DU0PR04MB9417AC18901E6841901814E4881A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-32-trini@konsulko.com>
In-Reply-To: <20240430133559.1836389-32-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8829:EE_
x-ms-office365-filtering-correlation-id: 1296981c-a876-45f9-c043-08dc697068b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?xGD760rhP7CwWbo4RUKjdekMZDgQPyzy6jSCghNLFXrHUV5FKNX/jGS+6g4t?=
 =?us-ascii?Q?zmRK/AtkxLiNWVtFTVtLZVPNnPxzqy2273HjL9ZqimVoaxGvlHfd3JCsEmdu?=
 =?us-ascii?Q?bSPz8WTBrGjGkF9aG9XYiXLyZMhwhi+cYfnLatXhv/7ikUzw9wE3L0GHBzye?=
 =?us-ascii?Q?V9ceKUP6LsXwWtO1d/mmwg8JPxtozwjetAaNidTh0SAi3u6sZZQ5GkIvxqZY?=
 =?us-ascii?Q?DBHZ5tAZbzSsjlFCbgRtFksdKWXXLPcEh7cibfl7sG0yh3RPdbQt1aeWcR+r?=
 =?us-ascii?Q?LFoTBagPxg/75vJiVA2cupSa9HBFvVmUIp+9x0oRWfnRfeoUoflcb0J3wVZR?=
 =?us-ascii?Q?TI+JTh2RKZHKu1nLgllOdJ+mMge11Oysw4tKcEOn3XefNurvgPpqOIxS96SE?=
 =?us-ascii?Q?z7L5LOzKwn1gw/HB3GK+BgxViFOLqJr8H75Wd0fUWTX1J8CjbeytgjOx89/1?=
 =?us-ascii?Q?wSAeqSMDZaUvPaqBOiTAkOIq3H8YUlGK5X+TayCCcjC26YmMFiRJxqs8sD3P?=
 =?us-ascii?Q?LPivm+5N/bIU7ghc3JpDvmBJRfUQWUl1WD2BEhMtmeS7DDtfXAU88UEzdyz0?=
 =?us-ascii?Q?8vk3wVkXDt2XXX/1i8aHc/7oyF+tve0n+kbA9tk2d6vfXHbEY1oMK4drUIaD?=
 =?us-ascii?Q?pSOMCPbY449jq01J1hXtycw8rrhE9li0P+CVwTG9vg3Ftq/BOFawNjBnD6lI?=
 =?us-ascii?Q?cLTMhHg1TRxBEn46YIYDA2UF885mw+1ULsmSTLjQAMSB+0PcVl6nJjExguHg?=
 =?us-ascii?Q?HtvZk8IAy2zXCqiPqXjgvjX9QgV2SZKsgUf4FfBv29gIbJWcLgbl0W+9iD7L?=
 =?us-ascii?Q?8iEFyRHzmAuYILAuhLbxl14ugkNz4vQ/gUKXkyDw31KLjE0yl90RiWhUWhaP?=
 =?us-ascii?Q?PFq1GYOZowLdA0FPNlR76rnx83bMqXA/GeZ4biErXBnPXuudtH0EsTFCtHnJ?=
 =?us-ascii?Q?eO7YciHhovjqL0fdvftLgeeqrVPwttOC3zM9pEEIYySLgk8UfauyDpn4TE+s?=
 =?us-ascii?Q?Mj8IjZdfy1pIuFgSvFwYbpRK+jr/ggP0j8aYl013PpXKRVh3UIdLB6CcROlR?=
 =?us-ascii?Q?CcN3OFrsYx7kwCZv4zLEKm0J0jEGRZDOdkQLrBTcgj/dxNpwe0bEQWVsbqaq?=
 =?us-ascii?Q?ihTlO/IvcL06rdp1bdqOWzQX3/G/MhK9VRc7r02xFlaJmCM2xKQjYhk0RpMM?=
 =?us-ascii?Q?aUAeev/IwFc006GoZEsxN5SlEbTHUT4aymZOqdfCjApJohcLQY6+9Bhjrrk1?=
 =?us-ascii?Q?+xNBRUGkQoNt+eSXaLSFGpsgr1q7F+9aNHwXM/B4BNYz/yDnDI+ziA1WCWlC?=
 =?us-ascii?Q?6G6NhInppvaoqI+TYCsv4GXZBXpuKjHoCJy+2hy6TULBcQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a28RJuidH+OAyU+xLxyoHBDU5T5zGcS4G3zrvLenvRYlrHAvfkwLY/f0ncQZ?=
 =?us-ascii?Q?IKZ814yA2GHAnlPh04ZfGn07+6oSGnS0pP6lN9UCri8mQGl0ZQm9+s0wh+Ct?=
 =?us-ascii?Q?rMzHE+CCe4DZBkaUHx1dCiEgBx+V84d1gvOTJANVJC0xrsxBKktPDbQ1wn0M?=
 =?us-ascii?Q?Q9GPg/E3cMUjXmBWb4FYhXJMcp1ZqzoA8u9TmmW0oqgH+NXiaWPeHi3fbpfa?=
 =?us-ascii?Q?SIKdxgqwTUZqKR8EarzZ3yGAw9ffGraK1klCMXgRzlV3NllOkvR+Uwdo9UM0?=
 =?us-ascii?Q?jpOXLiW/DpCUTgb4O8+PCO2pIQ8+9JD78FYnd0nBUbtjKXgF3cz5R86Zw5xX?=
 =?us-ascii?Q?R39vgu4CX7G+WFbjsgVfNx4ktNH0/e4/wkhecw2NWKe3AHoQtOI6+zV+9/rZ?=
 =?us-ascii?Q?WTRKVEQIyBNhODKsSK1N7p/cuKOYK8HApQwo0n67Q9SOaEyJ40/xNHX2n6VW?=
 =?us-ascii?Q?ctWToDl9iiN6r4ToSI29LmxZczB/S/3Vvw7upDknUoH5jDtlTb0WoxTaQ/+W?=
 =?us-ascii?Q?S6QlgBLlnPN64JRV5ZFZ4xdQWXR4lujd3YjqfM4/v6KM71I0Psx3qyWun8wQ?=
 =?us-ascii?Q?IIKDZvrm/g+9a/TCyDwLMp6lAZJpuqwr6G0SC3msuG39EtJxUyi+Ttbx1SW1?=
 =?us-ascii?Q?V5hgb6QGt2EolgbNglsrDaglT0FJbAXBzzl6ev/VZGILwyQZuy1umU7yndoh?=
 =?us-ascii?Q?1LGpeZKxEAs9XCno90HKVHtFKHV/3D8IzWVlAsJ0ZSjk7Ldn6m+9zrGC5qLs?=
 =?us-ascii?Q?Ie2t5Bu+7HnQWyFKbBkZBsbjXgRrThHofWhtqxld8+F7I0mEawwU/v5bNdU+?=
 =?us-ascii?Q?4aYXuk0eRs8PJAVuVaq7Cnfwq3Pm61MIBUpA8HieFEeAVpAurAlTUsinCaOj?=
 =?us-ascii?Q?vWhfU97XWFd9j+1BT3lF6DFJekf6rdPaXNwBLDLyJL2BhYR1md0ZPMQTOmzH?=
 =?us-ascii?Q?fotJZIrvO2BMVMTgAxqmlq9R7i514gSBv4MS8iV1jB80aNpXv5pqTgswBK7y?=
 =?us-ascii?Q?6d9qreTim5x8hlHqLt3ywkvSrenVbjqfFC/64yRPtKUG1rfgWCp88WcS6u7X?=
 =?us-ascii?Q?NXIu7/HV44sIjto4OIy0SI/pVpxtG8y4b5TPAfGA9cdJXEbv2gcDZmsZ0iEC?=
 =?us-ascii?Q?hKdl1oTVdDevCVt0lxXtmnpcWAB/pyjizNTanwLbqATfJ0VLSrOhoGIEEkKO?=
 =?us-ascii?Q?YDzIcvm+EIbj1gEQu+1KvFXCwV2O6+jKvxir+MDDedP8zPOTXNGUUoyrmLZ4?=
 =?us-ascii?Q?xBmspsWScdMS0SUZL8s+/6I44LzxIZZu2ZfDblgA4vPf3Re05CFmVEpcqmIs?=
 =?us-ascii?Q?09gusOZJ41eWR9VLLp3GvlNBU6o/A2VkAfpDh/8aBFuaKUrkTbKeMV2CmVvA?=
 =?us-ascii?Q?yeMDxB78+dPSWO81jSSghUL6jnJePQDeUpKhzIITD14lLGgFT+6lh2F4JkTM?=
 =?us-ascii?Q?fhNDgcqRIx2v2Cv5JzOJQu8Ku289ciiRG0m/GfP8Al26EXw+e4rHW8EKkK1h?=
 =?us-ascii?Q?ldhjaF957pntzg7ZPYct2jwX/O7/w4irODpjGUIwIYFCx63/BRQyROgL69YV?=
 =?us-ascii?Q?in+RDJEvPri7CqX+7YQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1296981c-a876-45f9-c043-08dc697068b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 23:51:09.3531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCQON09Ya7L2WtSUtD1L8OJAaAhoGPpSYW4apZqpmR45FjOfV2ftu08xbnOgMX8VNSvu3sfneU43LV9xuKO10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829
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

> Subject: [PATCH 32/33] arm: fsl-layerscape: Remove <common.h> and add
> needed includes
>=20
> Remove <common.h> from all fsl-layerscape related files and when needed
> add missing include files directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/cpu/armv7/ls102xa/clock.c                     | 2 +-
>  arch/arm/cpu/armv7/ls102xa/cpu.c                       | 1 -
>  arch/arm/cpu/armv7/ls102xa/fdt.c                       | 2 +-
>  arch/arm/cpu/armv7/ls102xa/fsl_epu.c                   | 1 -
>  arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c            | 2 +-
>  arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c            | 2 +-
>  arch/arm/cpu/armv7/ls102xa/soc.c                       | 2 +-
>  arch/arm/cpu/armv7/ls102xa/spl.c                       | 1 -
>  arch/arm/cpu/armv7/ls102xa/timer.c                     | 1 -
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c                | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/fdt.c                | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c   | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c    | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c   | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c    | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/icid.c               | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c     | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c         | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c     | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c         | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c     | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c         | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c     | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c         | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c     | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c     | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c         | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c         | 3 ++-
>  arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c     | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/mp.c                 | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/soc.c                | 2 +-
>  arch/arm/cpu/armv8/fsl-layerscape/spl.c                | 2 +-
>  arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h  | 2 ++
> arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h | 1 +
>  arch/arm/include/asm/arch-ls102xa/fsl_serdes.h         | 2 ++
>  35 files changed, 40 insertions(+), 32 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv7/ls102xa/clock.c
> b/arch/arm/cpu/armv7/ls102xa/clock.c
> index 4e1fe281201f..e885a85ce65c 100644
> --- a/arch/arm/cpu/armv7/ls102xa/clock.c
> +++ b/arch/arm/cpu/armv7/ls102xa/clock.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/armv7/ls102xa/cpu.c
> b/arch/arm/cpu/armv7/ls102xa/cpu.c
> index c455969609f6..74a2dcbc116a 100644
> --- a/arch/arm/cpu/armv7/ls102xa/cpu.c
> +++ b/arch/arm/cpu/armv7/ls102xa/cpu.c
> @@ -4,7 +4,6 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <net.h>
> diff --git a/arch/arm/cpu/armv7/ls102xa/fdt.c
> b/arch/arm/cpu/armv7/ls102xa/fdt.c
> index 1c3d24bcad94..34eea22eb923 100644
> --- a/arch/arm/cpu/armv7/ls102xa/fdt.c
> +++ b/arch/arm/cpu/armv7/ls102xa/fdt.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <net.h>
>  #include <asm/global_data.h>
> diff --git a/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
> b/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
> index e31a4fb6c31b..664eae532d5f 100644
> --- a/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
> +++ b/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
> @@ -3,7 +3,6 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <asm/io.h>
>=20
>  #include "fsl_epu.h"
> diff --git a/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
> b/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
> index f74d819ea1ea..c1eadb34523f 100644
> --- a/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
> +++ b/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/immap_ls102xa.h>
>  #include <linux/errno.h>
> diff --git a/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
> b/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
> index 8c030be8b36f..3032e266c5d4 100644
> --- a/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
> +++ b/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <linux/kernel.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/immap_ls102xa.h>
>=20
> diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c
> b/arch/arm/cpu/armv7/ls102xa/soc.c
> index 84d4ea3a8f4a..7ff59edd452e 100644
> --- a/arch/arm/cpu/armv7/ls102xa/soc.c
> +++ b/arch/arm/cpu/armv7/ls102xa/soc.c
> @@ -3,7 +3,7 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <log.h>
>  #include <asm/arch/clock.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/armv7/ls102xa/spl.c
> b/arch/arm/cpu/armv7/ls102xa/spl.c
> index a19496862359..374de92d026c 100644
> --- a/arch/arm/cpu/armv7/ls102xa/spl.c
> +++ b/arch/arm/cpu/armv7/ls102xa/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <spl.h>
>=20
>  u32 spl_boot_device(void)
> diff --git a/arch/arm/cpu/armv7/ls102xa/timer.c
> b/arch/arm/cpu/armv7/ls102xa/timer.c
> index c6126b10c355..6f32ced5aec3 100644
> --- a/arch/arm/cpu/armv7/ls102xa/timer.c
> +++ b/arch/arm/cpu/armv7/ls102xa/timer.c
> @@ -3,7 +3,6 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <time.h>
>  #include <asm/global_data.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> index 12d31184ad91..d2dbfdd08a02 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> @@ -4,7 +4,7 @@
>   * Copyright 2014-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <env.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
> b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
> index 22ce6992165b..ca6be3626fbe 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
> @@ -4,7 +4,7 @@
>   * Copyright 2020-2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <efi_loader.h>
>  #include <log.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
> index b1bb29bcaf55..78961d8089e4 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
> @@ -3,11 +3,12 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <log.h>
>  #include <asm/io.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/string.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/soc.h>
>=20
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
> b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
> index 4455eb1726dc..9a24d4b30313 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
> @@ -4,7 +4,7 @@
>   * Copyright 2019 NXP.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <asm/global_data.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
> index fbd5fd7d433b..b768790437fd 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
> @@ -4,7 +4,7 @@
>   * Copyright 2014-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
> b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
> index 137778dc136b..452246e0e67f 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
> @@ -6,7 +6,7 @@
>   * Derived from arch/power/cpu/mpc85xx/speed.c
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <asm/global_data.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
> b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
> index c22e73253c3c..04ffefafbf73 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
> @@ -3,7 +3,7 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <linux/libfdt.h>
>  #include <fdt_support.h>
>=20
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
> index 8d7beca7db38..c0e5455507a4 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/immap_lsch2.h>
>=20
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> index 86a49b152e44..d48baa63816f 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> @@ -3,9 +3,9 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <fdt_support.h>
>  #include <log.h>
> +#include <asm/arch/stream_id_lsch3.h>
>  #include <asm/arch-fsl-layerscape/immap_lsch3.h>
>  #include <asm/arch-fsl-layerscape/fsl_icid.h>
>  #include <asm/arch-fsl-layerscape/fsl_portals.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
> index 80d2910f679f..1b4eab3613e5 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
> @@ -3,7 +3,8 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
> +#include <linux/kernel.h>
>  #include <asm/arch/fsl_serdes.h>
>=20
>  struct serdes_config {
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
> index e3c3fc6bfb55..ec80e42055d9 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
> @@ -3,11 +3,12 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch-fsl-layerscape/immap_lsch2.h>
>  #include <asm/arch-fsl-layerscape/fsl_icid.h>
>  #include <asm/arch-fsl-layerscape/fsl_portals.h>
>  #include <fsl_sec.h>
> +#include <asm/arch/stream_id_lsch3.h>
>=20
>  #ifdef CONFIG_SYS_DPAA_QBMAN
>  struct qportal_info qp_info[CFG_SYS_QMAN_NUM_PORTALS] =3D { diff --git
> a/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
> index 6c5e52ebaa69..1911ca1a175b 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/immap_lsch2.h>
>=20
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
> index 333d7e2fa21a..a73dd316f8d0 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
> @@ -3,10 +3,11 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch-fsl-layerscape/immap_lsch2.h>
>  #include <asm/arch-fsl-layerscape/fsl_icid.h>
>  #include <asm/arch-fsl-layerscape/fsl_portals.h>
> +#include <asm/arch/stream_id_lsch3.h>
>=20
>  #ifdef CONFIG_SYS_DPAA_QBMAN
>  struct qportal_info qp_info[CFG_SYS_QMAN_NUM_PORTALS] =3D { diff --git
> a/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
> index 9347e516bf69..26ca4ca10f3d 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
> @@ -4,7 +4,7 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/immap_lsch2.h>
>=20
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
> index 23743ae10cff..3a076ca04f6e 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
> @@ -3,10 +3,11 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch-fsl-layerscape/immap_lsch3.h>
>  #include <asm/arch-fsl-layerscape/fsl_icid.h>
>  #include <asm/arch-fsl-layerscape/fsl_portals.h>
> +#include <asm/arch/stream_id_lsch3.h>
>=20
>  struct icid_id_table icid_tbl[] =3D {
>  	SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID), diff --git
> a/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
> index fe667f06c395..154b727392e1 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2017-2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>  #include <asm/arch/soc.h>
>  #include <asm/io.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
> index 7997422840f2..5088c8ebb7ff 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>=20
>  struct serdes_config {
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
> index e6403b795263..c320e835c996 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
> @@ -3,10 +3,11 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch-fsl-layerscape/immap_lsch3.h>
>  #include <asm/arch-fsl-layerscape/fsl_icid.h>
>  #include <asm/arch-fsl-layerscape/fsl_portals.h>
> +#include <asm/arch/stream_id_lsch3.h>
>=20
>  struct icid_id_table icid_tbl[] =3D {
>  	SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID), diff --git
> a/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
> index 3a0ed1fa550c..df9329df77e1 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
> @@ -3,10 +3,11 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch-fsl-layerscape/immap_lsch3.h>
>  #include <asm/arch-fsl-layerscape/fsl_icid.h>
>  #include <asm/arch-fsl-layerscape/fsl_portals.h>
> +#include <asm/arch/stream_id_lsch3.h>
>=20
>  struct icid_id_table icid_tbl[] =3D {
>  	SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID), diff --git
> a/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
> b/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
> index 5941d90e036f..43f0e8c87ba9 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
> @@ -3,7 +3,7 @@
>   * Copyright 2018, 2020 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/arch/fsl_serdes.h>
>=20
>  struct serdes_config {
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/mp.c
> b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
> index ce0c46ad0d4e..db913208b9e9 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/mp.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <image.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
> b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
> index 4c61d28c20f0..d85a630f8a3c 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
> @@ -4,7 +4,7 @@
>   * Copyright 2019-2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <env.h>
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
> b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
> index 232adfa843a2..a739ff2da581 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <debug_uart.h>
> diff --git a/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
> b/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
> index 9e29350ca4ba..a02bec9371c0 100644
> --- a/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
> +++ b/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
> @@ -7,6 +7,8 @@
>  #ifndef __FSL_SERDES_H__
>  #define __FSL_SERDES_H__
>=20
> +#include <linux/types.h>
> +
>  #ifdef CONFIG_FSL_LSCH3
>  enum srds_prtcl {
>  	/*
> diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> index 9794db044996..147ca2f99de6 100644
> --- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> +++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
> @@ -6,6 +6,7 @@
>  #ifndef __ARCH_FSL_LSCH2_IMMAP_H__
>  #define __ARCH_FSL_LSCH2_IMMAP_H__
>=20
> +#include <config.h>
>  #include <fsl_immap.h>
>  #ifndef __ASSEMBLY__
>  #include <linux/bitops.h>
> diff --git a/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
> b/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
> index 9244e0a78fd3..35e3ec7a9878 100644
> --- a/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
> +++ b/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
> @@ -6,6 +6,8 @@
>  #ifndef __FSL_SERDES_H
>  #define __FSL_SERDES_H
>=20
> +#include <linux/types.h>
> +
>  enum srds_prtcl {
>  	/*
>  	 * Nobody will check whether the device 'NONE' has been configured,
> --
> 2.34.1

