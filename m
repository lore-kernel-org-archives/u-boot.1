Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7291C88E42
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2966A83DFA;
	Mon, 26 Jan 2026 02:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QOYYgm+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF29783E4C; Mon, 26 Jan 2026 02:50:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56068063E
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvqJir8+OhJYKH4dN9gYzGa9p2KGv2gKb60HhA0p9BQyJCtu5i+1X93YsG+JvwOuYLgDQc/Q2JdwfpF9GV/fKMKh4rHO0c8r0kXG0cSla+fin2BFOFnvEvWBMv/SswQe20sffK4aMESx+jaxQnegvaB3xyeOI+h2Nv+MGhZl/8FkTIPq4tUk8U+wPUomTAz/3XEYcso6Lj44zMxlicC5cciiN0rionx1DW98MNKUifrDwGS4OM4AuEKhR1Eb5JSxDsqM77NZyXC69evHeV9vX4xRmptiaGhiQJbcrWb0IMiPV45KrQVLsVPR42VfvURTTz5np4mQVwi3YqjhTJlwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL3ODRI/9dQvfjgzWPvA/K1BveVT6YO6ifIHcxgjkxc=;
 b=aHWQXFgM5aXdCRP+2disA/GFQmdqlLHjCxsBoG7Bu3zoFuwezIrJ9S7vTTbv79cB9HEZ/p3MVxPuD0xnFe8b981DJ6pZRPIhsNe6N8aTylPpmZq0q27JyNsC6FDWC2rsjI/pausugGsql1DRLgXHdwc36ruGVx1FMad+iKsMxF/k9l29EvnkkM9MLITXGmQESf66I+Q8h5qY7nwf0UE6xS17sMDdbfPn2IzPiymzzBMaVGXXAkKgOugZmxLrbOHEpb/JbyBXvHWB1a+iwgykNNne2Tpzjwk2NaBQkV3hlo9YxGYTOcVjWBzJIvcmUxYDQmEc6dpAVZYsdBzdEO5HcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL3ODRI/9dQvfjgzWPvA/K1BveVT6YO6ifIHcxgjkxc=;
 b=QOYYgm+ONwn3WY9xdgwK/zRDUqPfARBcvsZoZsqAv9aFty7zXlJIk7VLek35FClvZ9I0oPP+mulqd7xGN8ylUazXbyRkBXmfpWsPbPpG35koweNCoYnVHpjQVtYcZu6ZWjgmdGGDgSC0xoEOYpH5W2A/DXuVwPn774g400Y2ugnCAprdp5FyWal2iNkGSKj2USIoqXhyB9obV+EOHosJpZN7fK8GjTvqKPX17J/4Bhb0XUI4481dejbeD0ALjNojV4+kqx4xebcK9W1d6CQdd6WQmFUEhOE4Y78QEArwiW7WKaZhNi7kD0PfkY6jYiIVhnKoy5iZsyDySBnOdMU5DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB9902.eurprd04.prod.outlook.com (2603:10a6:150:116::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:50:10 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:50:10 +0000
Date: Mon, 26 Jan 2026 09:50:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 2/2] imx8qx: misc: add command for getting boottype
Message-ID: <aXbITzhaa+NVZV5H@shlinux89>
References: <20260124055044.8149-1-hs@nabladev.com>
 <20260124055044.8149-3-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055044.8149-3-hs@nabladev.com>
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d6a658-39da-44e7-2ab1-08de5c7d3d59
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QjwVuunng3liakijbHlGppU0axvq/Exwj1q+tJ9F/g6Zb+5XDqbe5tJtWuZb?=
 =?us-ascii?Q?4AwPhMuBGpi2kHUAJhMVLZIszLGmSxCi/IP4AjG4Q/9/5nspA1W0Ccj3I4Ie?=
 =?us-ascii?Q?sfyKhb0cfnIHyxtyzM2k4rr+iyBT/m0QsKWvxAwaOMHQp/Zu6WaavVTANpuy?=
 =?us-ascii?Q?D/HfjrG5AE1WcxMZ2CkpSojQ5RDC9SL5Qmc5egJ5Jh9MqLifo6YkbjAiHm25?=
 =?us-ascii?Q?VKM6a+v/0ogrE3nnsZjq7ezFJ7G7DEKHTbULtkOCs/LMtlNKZJHAirn58lux?=
 =?us-ascii?Q?rHKicmJKU6+S7IP8d9PMDaCV33u1CCoMlzjZsk4TUJJE6J+WA+E8fyhDFWaH?=
 =?us-ascii?Q?0Z+rGh2eUPPvDwUKnmjhdqSq1D7NgZg2qaRWa1FaryHrR8wa93r1iH3u+D77?=
 =?us-ascii?Q?u11kF4MgmewxMgLnIbqoPKUIx2ayJ+ZORxZH72on+6U4LR5gcQFq2EM+nvb2?=
 =?us-ascii?Q?s0v4uYdIol3B3h5jt+HKo5NY6KrnI7cuRWkGfTzt/ZcnOkjePmDUw9sCZIDB?=
 =?us-ascii?Q?jxOssHeMa8U0a6a80PDGfsvXUxjNV3BQEBZ0QnKbTDDxo1sGS3x+gqkNpS7x?=
 =?us-ascii?Q?Y81s/1bsQ6W+U3/s4sxFzOy8m7yteY9UDKIkGAomGSH/Thcn4Cn/hPS+eEmT?=
 =?us-ascii?Q?AmUUXFFJYIm8i8hS+2R0fl7y2YtBvNny4Pac/eMTiEupRbKFNKG3O+JpQsPf?=
 =?us-ascii?Q?kk/ghKWarEN5GXY+T4N8o+4br2MdHHftGZWinv17qrJItSMuBjil8CDbi9kp?=
 =?us-ascii?Q?Sv+b0se1ecZk+tiWJ5QqLZubSmCafKxOUzQ1fHtkLF4BYJH7nPw9qM6HGQgj?=
 =?us-ascii?Q?ZJK7qERvYikkA9493tjOMT5WM1DCKBWrNkRo76Obtbw8SW8A0bOgttMJC8yz?=
 =?us-ascii?Q?X1o3aNAPXe8FXuvWbuCx7+YRUec1kk44jCMjm6mF0QLlvgKmWm6omQ9xL1Gh?=
 =?us-ascii?Q?weLO7WkUJZ3YmXjU7vBMlJH3c6NosdG0H8OoCIt+8GDK1e8cdj+a3h+zHWYL?=
 =?us-ascii?Q?ENTxYAdUjZx+AFPHSFa3YPAUmBdBsBf7jrP8QxWEf5EAPuAnJX8/VqWb1wCa?=
 =?us-ascii?Q?yr4myqEPFf2Gpeb8fiJb/wGBti429l4SAd2InaF0xXYWck/je4v0yOyvmi0/?=
 =?us-ascii?Q?ldygCHG4byhAYjBXTo2MgplW7X0Net6fmkrJw5v8DSGGFHLICQRUT9C8U2G1?=
 =?us-ascii?Q?mezJ2NF7ToOhUcpakYu9Hphye5zien0Rvn9g/5QU3BVKVyYMa5VUKIFpSpJB?=
 =?us-ascii?Q?xua2MLttUWSrqrBKzIfo2HUl7J8x4azqi+ofRCFAEuCmJ60uiNDg2VL73NyM?=
 =?us-ascii?Q?i7wM8FpmGtZtZwL2sxEJTmwy7nTznh0BI+StSQvhVE2hIDuPJrH5LKDZaCzJ?=
 =?us-ascii?Q?3nHrkiOgvq5nozpzWlco/DrLYKB3CIsdVNRA0o9HyOhcq79po+TFbpCFbPYK?=
 =?us-ascii?Q?Lnk4vZoF1DrodSfJ/aoiuRkjYnAHV4dt9BeDYlJ6doGaPSWISqdiiM4zd3Ak?=
 =?us-ascii?Q?bRSCrfOdDUcLfqayHJHOq4xqHTC6I/DHp5iTJccKQ+6H50AkCTvldJRtPIcF?=
 =?us-ascii?Q?tCtTA0SzNQpoBjgYLXzgeGqftXzPCv3Q72CmdILLkqFLbfskOfxYKz8NnGGo?=
 =?us-ascii?Q?k72Ks3GGBqBfisMcXAhELz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2GjuoLoZj3/Ub/DpSIgNDJStJp4TS045WdHoRJu2oNkTNvJSBJRkI0mils0r?=
 =?us-ascii?Q?EPsuxXMiIL2n/xOUts6cymEgGE+pp2pdBk1VvOcGCqwcT71sl2IsNqQnR/5U?=
 =?us-ascii?Q?ejWuILduwbBiQa8130RlA06UB2etGlpZHzOcaQCXa/2pq4t/Lt3bCW1zAOWU?=
 =?us-ascii?Q?Ajt/JcmBd8vBCB9pQ+0hXz2EK4+U+oWoloi1AMukxYz9LsdalrmOf+mR6kp+?=
 =?us-ascii?Q?/FYjxSCMi84cfJsiVxXe8eDmezgE3LHvjLmkz+1lYQbd+9K19F7PgDLI5KSn?=
 =?us-ascii?Q?lh9SWCHb+G9D0Ju046ZcZzrJSLq8IIDQlIMdS5vf29xsqYOccCKtKXEglIlg?=
 =?us-ascii?Q?hjnN8EiRnTzHBkkeUgIt/Onno5Bb3EOiNhx9AvH1vhV7QWpMGNrEEwRG6HI0?=
 =?us-ascii?Q?CrWVScSemMkcucpDX7e7IHBzfM31/0ExVToa2hvd5//EhqulWRRTczIqTJU/?=
 =?us-ascii?Q?IwSE2FgnmbCZzW3I2uBFiUNKeoMGXpQaoBdaZ0T1AYnNdIzp0fBuTkZLRwWk?=
 =?us-ascii?Q?xXSBfp1Y9gjcISIAvsBVtxHUYyRCiqWchpE0QyAcmTYcR6rJxdEcx0oLedP+?=
 =?us-ascii?Q?v8Whbc0VUeT0qbMiakeVkcNRXZGXbpg5V+sAx+JLYKSj6HEqhs5i5zPAZNTZ?=
 =?us-ascii?Q?oKSz8ToQo0laypFeYnKNXWltX5dAsr+N9EvFpPC2rU9VIetLmjRwY/BaQqP3?=
 =?us-ascii?Q?C5Uhfc58wN6MTTvROvQM3E8zEBy0JCfzyTSxxFZ00vhbnhriI99Nr6NRFtWT?=
 =?us-ascii?Q?1HbjVkDj7QgKZmG7wCxa/y0nh67UNT3ZaCnYOldL7r4jDEcAb87mtBNfF964?=
 =?us-ascii?Q?H/OF6u/l1lNLvgu5+1cJqb6T1F42cfAJuWNnvEdqfWN4K9C1GA5caSbcpWEZ?=
 =?us-ascii?Q?erpSmePWAjGM4p5n/TIORykHequ2ZssXQrjDBUcy5+ZQSSgVFzvyXg+nwOrF?=
 =?us-ascii?Q?Do2Qynz+bIRxA2DZVKGSO1niWwgAvYSqIMpPg+npGgN9Ntk+BeExWxx761EH?=
 =?us-ascii?Q?MGnZuDRt6wKMdsAqblYD576AidSm2W4Co0zN8EHyecm32O5KMoqrRJTo6ojD?=
 =?us-ascii?Q?Cv59FbFlHj4pw0v1/lal/yfW4Miz2OhpkWdBmAW/TO2BIf3yjEQCAfk2Yq+w?=
 =?us-ascii?Q?TgY5noQWhQgp2MOe6LHmzwiKMiePN+c27QLtl3DrXQ/41Oir400nB96Gqi1c?=
 =?us-ascii?Q?Kn1luM8dpEYFnwoagRfII3pIibk6688TqdHSjEXuQZ035/2ak0HCjugKy5ED?=
 =?us-ascii?Q?tki3J1AcVeaKBNLkYbjasFfy2feYTKWp6jnpQl83fltipqHXZlI00Wcdv3oC?=
 =?us-ascii?Q?oi0O1pRQCW5nW5YY3WJor8YV94xQWm8j2I+KqnJjBHGNkZuyI4eMMUpBY0TZ?=
 =?us-ascii?Q?oZR8K749ZWALso6pa1Czf7VN18Grq9LfTAf1nlP3cqrA1YDX14uNd1asEHfM?=
 =?us-ascii?Q?9Oyyct5/34wqT5/PI9Vmyiv4BYCD0SPmKP27fTm9afqTs1jfZyEHh5clCvZm?=
 =?us-ascii?Q?iwrXy7gurv1vEjJZxhdrFtd5t7glDlQhIP7MVhTmUQsALfPmy0rAnc+klcPA?=
 =?us-ascii?Q?UaSpSHIRmjdBhxKH/kT4teWIYr7VT/3C5+VHoxt36rknTCfqPz5V+YLNbl8P?=
 =?us-ascii?Q?lwQVUrVRrTD6wSkmnlMWTCchk0ERLr7dvP2k26JkgdIfnr3msdbQGA5/dcay?=
 =?us-ascii?Q?3g6A9oyIiSeJyfLxaIh2n79vC98i2zmS2/bdducR5jWuc1znnCyTLMNuCjuV?=
 =?us-ascii?Q?sAZAAmsjWw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d6a658-39da-44e7-2ab1-08de5c7d3d59
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:50:10.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNWWIBN0wl+rAXVeegk5vyaMm4kCck/tDcZNEe7XjETh3AYhD1kp3WJpHgo0Ab8Q01srYFTfvfliThsh4r2YGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9902
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

Hi Heiko,

On Sat, Jan 24, 2026 at 06:50:44AM +0100, Heiko Schocher wrote:
>add boottype command, which saves the boot_type
>primary (0) or fallback (1) in environment
>variable "boottype". If argument "print" is
>passed, it also prints the boottype on console.
>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
>---
>
> arch/arm/mach-imx/imx8/misc.c | 27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>
>diff --git a/arch/arm/mach-imx/imx8/misc.c b/arch/arm/mach-imx/imx8/misc.c
>index c77104d0338..f233432f608 100644
>--- a/arch/arm/mach-imx/imx8/misc.c
>+++ b/arch/arm/mach-imx/imx8/misc.c
>@@ -1,4 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0+
>+#include <command.h>
>+#include <env.h>
> #include <log.h>
> #include <firmware/imx/sci/sci.h>
> #include <asm/mach-imx/sys_proto.h>
>@@ -62,3 +64,28 @@ void build_info(void)
> 	printf("Build: SCFW %08x, SECO-FW %08x, ATF %s\n",
> 	       sc_commit, seco_commit, (char *)&atf_commit);
> }
>+
>+int do_boottype(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>+{
>+	sc_misc_bt_t boot_type;
>+
>+	if (argc > 2)
>+		return CMD_RET_USAGE;
>+
>+	if (sc_misc_get_boot_type(-1, &boot_type) != 0) {
>+		puts("boottype cannot be retrieved\n");
>+		return CMD_RET_FAILURE;
>+	}
>+
>+	if (argc > 1)
>+		printf("Boottype: %d\n", boot_type);
>+
>+	env_set_ulong("boottype", boot_type);
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
>+U_BOOT_CMD(boottype, CONFIG_SYS_MAXARGS, 2, do_boottype,
>+	   "save current boot-container in env variable 'boottype'",
>+	   "[print] - print current boottype"

An description to describe the value, saying which value is for eMMC,
and which for SD. Or even better to decode the value in above function.

Thanks,
Peng

>+);
>-- 
>2.20.1
>
