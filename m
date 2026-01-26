Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2147C88E40
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293A483DFA;
	Mon, 26 Jan 2026 02:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EcLZW8Dw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2EF83E36; Mon, 26 Jan 2026 02:45:13 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E89283DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMgDdtmesuI8RhQ5FeFCPWIiFydsDh7CpiQ6H3dtJ1sVA0RLYTqrU7hmvCUkLDmv3YbmPlVDqT3oSiMh4xuoGDrKp0A6UJYFW0n1jpbMW/prXRfxlje74EDJTEfteyIp8VmaXmn/NmoSQ+Z+1MFlk4b3F+UJ7TLS3X4SCe+b212sPY229iWpSW/OoAFjYj2OBnP3mQ/18benC0TKT96hRx259ItvPFZeKLX9w1xI6M9bPoBvrJ2pdMK2nk+yC9B1Rd/yfYzpvjhT9aRds7ukEVxWsDD4vXr5/X5mRkW/SjlyK9GU6YYsTzxnFp0Qk+01GCk4ZNafXStJVzow1oDl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQtOFM7cm4ET4a99fDiyZ3BzdvrxQ7NiFC6HThwDtQ0=;
 b=s0XxBVH1GNqUt5Jj21uflFlTO1PEVx+JAgECBOZNLs1qxJNp/+8onTbR58eebK8JbueyUSyM6VKMxFzrepqs6Bnp6CvVj3VmOyxkO9/xr/QUX4eNuZPdM2AqZI5DlEVJSwyAJOn0d/eYFak1RaB8E/zk42x9hZcJ6cGqgjaiCYFR8OyH/AZYxynrPtVMacNPghbWXE/rxlcDuSeaXDFfivoaSw4KiExCNJXuBhPIuYXcQC+9fLwZsFa3NsSSs8DPZiR0iyEGhGV6gb/4JJLzQMlZjdiHIMt9KAB0xTwhsrszqY5aMhrLfOtoyDjYa52ttWFi1HQ+INp8VY15nfyYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQtOFM7cm4ET4a99fDiyZ3BzdvrxQ7NiFC6HThwDtQ0=;
 b=EcLZW8Dw+pElEQ8hDFO2/HsbLhA9VNk2mIZcOQQNHHRw07r842pO7ZDU5OhdwpiZ2N8wN4RwQQfYGgW9jk3JlW1hD81mfUGpM2Zzg/6Dse32zGnF0475pcYpBwZr7cyUEFnTnXK68kL5wW0L0T3D5AcqZaEnSzAgBjpqVk1tyzoJ8kv3FTw8TbimftedRC5TOUSdPJ3orh113lZe5e0A3oI2TJQqOJ9jMu6YkMrg1UeVmKP25BWf5p4O1r/N9h35aSGaVswFB3FFe0tGo6YST4WsQnrufs/2hYBdNOAcRhsdN+Jpt0UPQZlw9FaKbAzDxDsER6PE8FnxT8OeAtoplg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB7268.eurprd04.prod.outlook.com (2603:10a6:20b:1de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 01:44:50 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:44:50 +0000
Date: Mon, 26 Jan 2026 09:44:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 2/2] arch: imx8qxp: Override weak
 fb_mmc_get_boot_offset function
Message-ID: <aXbHDnU+SpgnEt+Q@shlinux89>
References: <20260124054712.7939-1-hs@nabladev.com>
 <20260124054712.7939-3-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124054712.7939-3-hs@nabladev.com>
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f20197-6384-4fcb-9ede-08de5c7c7e91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LhXsnGMVdeUN1uk1njSuVRr2TfgWJ0LkNapdecx/E5tH1inGyIWgDLMdzgoS?=
 =?us-ascii?Q?MZa2lfCxBCwhAa5Zsl2c0o9qEMMWYl/++GMajYG7NkwbbChurLemk6al+wPp?=
 =?us-ascii?Q?4c91FnGHQ2kGxVTrVrM9NlAdcWnvLIIMu1A7SJimnlkv2ktPSrSJPUIwcl5n?=
 =?us-ascii?Q?8eSN7yUwmEOkH5Ob5vN40Nhbhpm4vTB2QpUBCsVr9pgtq/YzIu/b4a52HaV7?=
 =?us-ascii?Q?2vSIuXxS5gV6NL7ao9n73kEGX3jn9jLZ0l4/dnIN5dwF+P+jYEj50uX6Uicc?=
 =?us-ascii?Q?gmmDHDvqvkcGFROh7guqMMHR6G5AIQgn1T007QlCc/NzEXtNFKzbRk71cp6x?=
 =?us-ascii?Q?hNDhZMzYkhNPJI1Wab4N1WwHVqTPYVwzcy/3A05C290CseHvm2wMymBDk3g8?=
 =?us-ascii?Q?sU/WKBa6F6dK/2QKHh/BnCc4A9pAPhvsu5LUQv6lOuPa7+rntRCW35LV6MGc?=
 =?us-ascii?Q?W9jdU8e/VABi2u1WPRYHd1VFaNd26bDwBEB/CETyDLwcf/wgrz8awuFjF9e9?=
 =?us-ascii?Q?tX+cYRqPFGyj8HxVcKDiltFCrPn0yH/g0WlSzzZpFWodKxXs28qFTk+/SujI?=
 =?us-ascii?Q?+xJjSDpFMRrpmIIhxpVb3ydMj/gilpF1WWeQBqbwVhGcoIPY53AAHMPhy4Tz?=
 =?us-ascii?Q?wuBRIjMa5Qw9BX1UkbwhvGfqpqB6sXm0Ta3BHWVDOi7zrZqsWUtRl1l3w70O?=
 =?us-ascii?Q?VE7IwJTypbt5TATxQQgc+4RI0+yadRpibDCNSo1xyL3jDNwoL+FVU+trKNkm?=
 =?us-ascii?Q?RU4hlIRPdzgGeQRn1J5zDS0CNqKGLtGu6quZFN4GJcaLhnrPaUltSR92baBD?=
 =?us-ascii?Q?SNNetCl/YH8/M6Q9XrqCXk/2bkCOm4XBUt0stOJEP762SjIIkcHoTVuxnH1w?=
 =?us-ascii?Q?vwEczMkjlAQgs790XCCDCTAHzGsVG1JfJ94rkO0wgIiH27AQUg6eQqc+7sz8?=
 =?us-ascii?Q?fI1Lx56f0QmGAosWyiN04II+HeoEeEHiOJdPoRag5XdsLyCCZs9lPFcAQW3u?=
 =?us-ascii?Q?kPEwJ/Kz4BO85rSLrmC4/r61i5MfFc87bVyZJOBDixQaBniMknDer7X5mbgl?=
 =?us-ascii?Q?pema/RZBwNv5Vl74hrjzqVpIVjrrDs28GLKnGZvyCrJK3SAmlnmXzhUDGLmy?=
 =?us-ascii?Q?agm//dUQvO6BmInYHLXel4NvYiNYWq95BakNmKiojpO7z2yDGwSY/xE44xGp?=
 =?us-ascii?Q?UHl6eSv+kIrRTFEqv0jD4dhLQVu2CTXQHs55miQE2Z4Qh+jqI/wk1vUXK2nQ?=
 =?us-ascii?Q?P8QV3P8+t+JGPp/9+G7C2x0Cq4Xk6XtBsGRt7SZf109CJVztlA+J+joDm6yh?=
 =?us-ascii?Q?Te6M/fhdPc5Y/t+IHqTp4pwxBnT1hhvZf8b3oy6YjRq9Ust78uoSjNMunXEg?=
 =?us-ascii?Q?d6V7RDEJ4d0z70vBT3s4v6v3ovthvfJtSI7qxJn8bPPg68FYxOET7937mX2Z?=
 =?us-ascii?Q?n6Jnu8Fg40AILUR39G2f4Ggg3dIUYwQjhrwCSPAGZE5lejVS6kLDffKdatWH?=
 =?us-ascii?Q?0C3ehOJ0Vkz5cmtU79KHJIMXHpsmcWr5KDZpaz98yLVUj7GRxXBnvPICfZxv?=
 =?us-ascii?Q?6PneZse0r40i4pHy8bexsPA/qgsZH86LKsf1j/zbbzjC5sUdGdCLnNpwNYWy?=
 =?us-ascii?Q?N52w/ZwdHS7QTgMFP+pv4Es=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6T9WSKM/pMyUp8UqhnlFUNrhS93YhDZReiWUADERl/T6wMRsA8AYHjqZUqWY?=
 =?us-ascii?Q?HBXIaeXA/59b2HtlyV3QpGG2uPi8ZaqZZ/HnnEY5dCcagEicSStXImkFU9hg?=
 =?us-ascii?Q?2zYUVfgAJHm+vO+rVNX/OHIflb7MwFFmbTNAlo+IKai1mn7LM1gSuSuwWQK+?=
 =?us-ascii?Q?S73+DZoYciqJztVNf4msKOI+CEY5h8cQWSgv99H3RHbAbuSdpv8TMJnrQtD1?=
 =?us-ascii?Q?44jy3YqaRm1mz7OSHuflouTxMRfFslir/JUx0DJn7CAGGZnwSlt+5AJ9+lxc?=
 =?us-ascii?Q?4xjLLIAwbKYpK75onDn0fIBnIwNoYrwBTpcLXcHVQnvsQz+5p2KSDUERJJ76?=
 =?us-ascii?Q?gWdaK8dxwLS0LnKLVBPHuYW2mEQDbX1wVBhQJWZVne9VtjQ42J/V+LNEfM1R?=
 =?us-ascii?Q?GcN3tJeDVxFm5W54rzFiaunfhJ6O4MMjQEeK9aerTNn+86TseYpGwSS1aFyv?=
 =?us-ascii?Q?ZmIoKMWGN179eCrU2IT2tGQlJ/gDDUyGD8/i8yZS5FHIrqonfuSJ+cuq0Ffs?=
 =?us-ascii?Q?BNeQQmJqBTiJNd7toj9EVrskgOSPTkUtSaEd4gqmIWJy9D2DGzpmx0AJltoR?=
 =?us-ascii?Q?ThzRZid5woi6zWo2u4gm7DTEz/0J/+GMQae+NNVNCwONB5hZQu3lYShWgpx4?=
 =?us-ascii?Q?YR9j2MroAz8qVq3dwiuMwKd9mk1vDEniWWhrGIppuqXJoHOA4Z3pJ9orufWK?=
 =?us-ascii?Q?ysdtqUeBDaPwaOwjlOc9B+3DrZNvVGlnM8MyQorahnHML7Fl45b4ORC3VOzK?=
 =?us-ascii?Q?8YPlIXXVJ7DQEbA8ZnRRS8hbOjPloTju5f58RYq27E2Tng7e2OVdsYp7gCFS?=
 =?us-ascii?Q?ijwX7Mf36Jnqsg0T1+yq5yGbMNRHKew/zF/Rcv7rns3oAA4nlMOYIR9in/ll?=
 =?us-ascii?Q?u6Po+jCcI4FSxyiKHgpRpEn7gv6QT6vSByg7wmk1ehIsas1LFbxCm0IVWpxA?=
 =?us-ascii?Q?MsnpeKpGun+qBCE0XLoQILBkwAlS860VN15NI6NVGsWV28+nfmXd/vkJNFoH?=
 =?us-ascii?Q?bztjz2DMHFQWqydi0M0/shErjIp6AKDHhyF+4asi3tuFWRYJ71rGqpymvilU?=
 =?us-ascii?Q?3iCeVTmGXJPkisXJXDCGLsodteaAKoLB9GvnrCMokoYyX2yJqAjUi9IfY0mM?=
 =?us-ascii?Q?Sk46JL47/jPgLZj4ic8AEksxnNKxs/Cs62QmqFfSSsRRSnNXtR1ShZG3qvM4?=
 =?us-ascii?Q?/orfjeyJpZJllMQV8pwWU6gK+8h/pGC5hzXTscrINT6zMXDZm4jE/XMM0Imt?=
 =?us-ascii?Q?Yuy9KV677OLF72mdHGdQ15tGA7erj3ro5KzXJtJRq1BRubaoGTpXSiKakvOF?=
 =?us-ascii?Q?M8yzOKztfsw+1E3H9qrXMayR9IFHJqN9yRvQV0ktNzzoXv8v3pkrt1yi/zoq?=
 =?us-ascii?Q?IkdxB+94QJlQdU9e2PRwCH1larPkqJHevvpYthS1poykcU2erRei4n683Wcp?=
 =?us-ascii?Q?vqLMvz4l5+X92SbpnmPd3L3lG2sDtKPVkBGO9XvLnCrR3zvijUrrcchUbZWr?=
 =?us-ascii?Q?BxHvxD9FLT6wL0g2039/AFJobU/EyeCT2elJo5Ow+1lSk/OzpGp6yeE0g+X2?=
 =?us-ascii?Q?ZWRcQPrj3V+2nmaMzF+u15Pc6fBX2dYNqGeOKuWhQ6fiSxWLlj6qcUvrv89d?=
 =?us-ascii?Q?RhPveJlAnOvmR98Pbgm4kd/ynET7yhlc9fQE1MvJrJ9lPbjLhAdp8PJHUaPv?=
 =?us-ascii?Q?925Ovovjsswe4XpkWxa5Zpfd/NfyNAr/Yg7m9NSQvCTgB5TbMqsxzgQSre0i?=
 =?us-ascii?Q?QJmmjc2p2A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f20197-6384-4fcb-9ede-08de5c7c7e91
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:44:50.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZqR1NUyZVsorROeefppqm2fckVvh6Y89nU9j71uT1DW7XdeAcNKnP4Rgt7Vck7ZYfOCHXii0PH6fzDRdem7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
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

On Sat, Jan 24, 2026 at 06:47:11AM +0100, Heiko Schocher wrote:
>From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
>Add IMX8QXP SoCs specific implementation of fb_mmc_get_boot_offset()
>
>This is needed as bootloader offset is different dependent on SoC
>revision!
>
>For revision B0 the bootloader starts at 32k offset. On offset
>0x0 the bootloaders environment is stored.
>
>On C0 revisions of the SoC bootloader image starts at offset 0x0
>
>Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>---
>
> arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
>
>diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
>index 0e112af661c..27c431881b0 100644
>--- a/arch/arm/mach-imx/imx8/cpu.c
>+++ b/arch/arm/mach-imx/imx8/cpu.c
>@@ -899,3 +899,24 @@ bool m4_parts_booted(void)
> 
> 	return false;
> }
>+
>+#ifdef CONFIG_IMX8QXP
>+#include <blk.h>
>+
>+/*
>+ * On B0 revision SoCs the bootloader is on 32k offset
>+ * and at offset 0x0 is the U-Boot Environment stored
>+ *
>+ * So we cannot flash bootloader images to offset 0x0
>+ *
>+ * On C0 revisions of the SoC bootloader image starts
>+ * at offset 0x0 ...
>+ */
>+lbaint_t fb_mmc_get_boot_offset(void)
>+{
>+	if ((get_cpu_rev() & 0xF) == CHIP_REV_C)
>+		return 0;
>+
>+	return 0x40;

There maybe no new chip revisions saying CHIP_REV_D,
but in case.. So below would be better

lbaint_t fb_mmc_get_boot_offset(void)
{
	if ((get_cpu_rev() & 0xF) < CHIP_REV_C)
		return 0x40;

	return 0x0;
}

Regards
Peng
>+#endif
>-- 
>2.20.1
>
