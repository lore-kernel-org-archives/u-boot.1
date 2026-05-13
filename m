Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F670CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131A78468A;
	Wed, 13 May 2026 14:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iPstss2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DDB83E36; Wed, 13 May 2026 10:50:06 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6510838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPtjqG3dYxecZ7tpl71UZ3PxhtC7STMcoaFdtIr9lnw2WT6IaUS7UopsZ09g8wBfmKNoop1JquIBOrlbdOI/vJP98SrLmJ3hk2nPBW1PHJhRjT6gN+A6iTJLZZq483BZWejGg7uLb+pXC3A3xCViFvDnfPEyTCXxM6DUi3XsPWXtTyoLKVoAOnpTQb+yt7E8mjXNkhjAhbrnzFR7W2oCo3AZW3K/Rj3r6eD5WaJO6A9/+7x7OYeSqJrkmGexySlFRWsgu55pcm2KgFxN/BiaEfe8LAZm9U7D3gwgc31cFzMSRXTP2v1RFQFZCiidoI+XCv+jJtLGFK+IIx5upxaSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KOPNQiEhCojWFxhHZqMjvKL83esqYBCjE80kd6TzXE=;
 b=uISgBDne2wZUTZJjKA+KYutnsmHRzNnAjck0IanuXLBascdbkqbM7qEIc4cwb1y6rUGl95hXMwoSaseIekcg6GpWg1eGhAcRt+CoPiKfjB984vdivgpFBh71dhqgAgGtxJ7YlSFo3W+YbF34Bd1fyivRhl7iI/pfVtkm/p6Le6kYH1iqo0ncrU0Yyic+CLkKtoVVSBypG+hUS4+c3/P/zDsy5tQTo3yQ5iXeR/9smJ2Z+hfENQ1r2MTh21b1Ve1l0+EN4OntxUEbbI0XvZ8O1xCNdAXglyV5Nz2I6abQAiwFHx9gz62Sv2hBSjDwgwboDKL3LzyQNKBRJmFiDMe4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KOPNQiEhCojWFxhHZqMjvKL83esqYBCjE80kd6TzXE=;
 b=iPstss2Pj0caPnO+MledpvZPQCPcZsGv7wT2emtKgynd0VheY2U9tUveBc8vXkPzLNyMp+0241CmZIyD4FITM1KWW0+Rlh5DH1RKgodKOFA94TYE0pq/BfPsPk2sfBU9w+ZEI2b8vun+kLyUFn24nSl5IFMm01rhq/zJL9aN61eEe7p74sJVy4VsHSbgEXqJbr23kWkqHKiysOjwC0FH54OBb3pR+9oraW2v6jwTNjUsxi94gVgbW3DnlhvqM7nXnvzV6sVQoiMLaAeLjQtAv8OHrLk5Xd180ORxmK1oR4hVhYHeavMRBzjSqwRIieRYgXQmzNzTpxCq71vOYmmGlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB8255.eurprd04.prod.outlook.com (2603:10a6:102:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 08:49:59 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:49:59 +0000
Date: Wed, 13 May 2026 16:52:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Ion Agorria <ion@agorria.com>, Paul Kocialkowski <contact@paulk.fr>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 7/9] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Message-ID: <agQ71g1bV8Obvput@shlinux89>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-7-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-7-0b9e1993557b@nxp.com>
X-ClientProxiedBy: MA5P287CA0317.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: cd234a41-e780-4986-fc84-08deb0cc9d58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014|18002099003|56012099003|22082099003|8126099003|11063799003;
X-Microsoft-Antispam-Message-Info: RXLedzjR6xZVsM6yarOdk7eVO+7OpMfZpOMTdHsXbH7RIiBzm05wXqwAeBgoK/RFt4We8E0SSMjLHcluUInxngLqKCiRxvbI6XIaZjZ9TEi2kgt0QU5V8ddsmvRFPXgoUUelrc3T6tKYEEABLOQ7HdCrqii+wMlkLDWW8J4T9k40L+BSLEwtHkfzpnfmwZK9TO7/55kT0VPDvnIdhbO0M/whpKguc8aLLRC6OG7hokclxSiFzzjLejBoEgtwSc1iRQnwc7cdsF/6Z1csKWuxQs5ZZeR5SOGup9zYxVHRZnhYPt519HqTm4xT5Sn9XDrEkpiTMB93b4KzPqgkIDNaIrno9IVMWwlR39DrV4KuCLVlhTS3lvjTjuQqVV/cVwiM/Qr63ZKFVQ5UjrOAmDuL5cFKdo1kCgYYRh+PA2o/FrVAuts+cvaI2qeH1BtMskzGN79za5nrBm8iLw1evxvBGO8EUrzL3QOR/QJ1R6xktS2hGCkh0/Dhk4g5tU4RV5z9F1cAkwsyXBSPHIiqc2Tv5VJjMGjgMbwxTsoQkYCBko2GlyztuoqdHze063FMtZGk5+08DW5MWmCNiRAnGJX/7qp4/xTuo3+N6lxTGQS5sNti+m4E0Y8iDagZC5Iw7mkb59IzjN6LIuDTvxXfeyAzTobSugAeVJSxbWEV/+wSfSVsmwY/pi3EZMbTUAOSb0nXBoOMkg72imauESu2n2fUCss2GIt0EK5r43bi0HYMV2HfMAnRhoylyFDKdqMt2/qx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014)(18002099003)(56012099003)(22082099003)(8126099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2/CgXuiQ1cZmL3qVjS153XxXaJTXXE+2uXZqttNGcSOHVbJyZ4UJR7npAW/?=
 =?us-ascii?Q?gS+a2QDBjG0+qSGl7QWTNDbTvnwOmYge8dF1uRzqRsgE4rr5TgxfqKp2ScnF?=
 =?us-ascii?Q?SWyWciDvNpJwbkLOiGnjgmBhard0WUtjsHWM2Q8ZWCk8HttfxnuagZprM7Pl?=
 =?us-ascii?Q?IqNMfOPdrxNSoAcZrnY1ZTtQKpOKchMmej3UiyvhYQX5Jp6HPRaFuQbbk08W?=
 =?us-ascii?Q?IwKqvy9o8kkXDR02Pm9bKzQ5DsbsOir9ATWKAgQguSS7YA6S5wWtCtIzVzLH?=
 =?us-ascii?Q?4O8+OO0hyjLK2FOqoVGOofumj1uqQpqykjJSdt6QwQagniKDxevnluWRsaIy?=
 =?us-ascii?Q?J1jsd/979GRSx4loVrwJQOC1NFU8Ajg4gz5cTEq/98nP2g+Ukn2A4esDJUCn?=
 =?us-ascii?Q?Jekf15gFSLiRdT2lqw6IEPhPxhbnzepihQXVDqEYchF9SMY+eMTGzaebRu01?=
 =?us-ascii?Q?qkaej4DN5OqYCP5vcqJ3q/YsPekPjDbQ+rPpBKYFLcRiVhkGx0U8K1gIDXxk?=
 =?us-ascii?Q?ezxipcKvaLhwoZ2sXNy69QLYxbTyMEC4r3HLeASobTyPSgi/gc3L92ybLRy/?=
 =?us-ascii?Q?qeVOcPXb7fxrb0Mp097w4ARinPpY+7XnUX2XDDMmmE4YJymUBpNDrqRxEzom?=
 =?us-ascii?Q?LS9LAjMJ1s5L89ba4ppuJZIJlbR9+QenYGO9HoKNA7k/vQTFb98TIe+GjmGr?=
 =?us-ascii?Q?hFdWImmuk7LGzJn3VvfEBJOuYOgo/xVWTp6mqC5jkYLNBVKDVtUOERDraCJj?=
 =?us-ascii?Q?+QUFNIb+f9zhseIdPGUiOXKJwalJwPUnwBEpT+CWA7EDXfX3BTYadzn4OHwG?=
 =?us-ascii?Q?Puujfi9fuYsgl8qIjQnsKfAIehiNhTI0kCeOLZe+NziWj+98N5vvhh7NsMg2?=
 =?us-ascii?Q?ENPaSBphk1wYf2sZKhGheP65TtW9MNQWZGqz12byHQDJuA6iv83tuCTlx2xB?=
 =?us-ascii?Q?nFh/phP3G8Ds8KhBLdh/MPKw9noaSIuyPoZ/rsQe8Wofu6QEBJ7Mz1Q09o5f?=
 =?us-ascii?Q?s1xOU1zxPxf6xRRWbiBtgQILjtQ585EKOyUV4buZ36BtEpMNelWin8SwOR+7?=
 =?us-ascii?Q?Bk7YoWMkzrGD7wyLXG2S3EuVVIeadnNPywvm2eNdPOhoAZ/oGU8UOhqZLpbQ?=
 =?us-ascii?Q?cH3NM4qAVEwuOxcdglxbUER6yPxTsX+y6BvyDOv77lHdnyKfkfjSf16aaCcM?=
 =?us-ascii?Q?b2hskPRfMd6Pv3EzCU/gzttcjHCj3GymGaxWILd6G9Dt2h8yNsO6msITbfC1?=
 =?us-ascii?Q?x1wbGjEywRuHwZhkN4elDkjJTLPyo43AZy8XW+/+x46hYIBZYE/p7+NhCs82?=
 =?us-ascii?Q?pHL9JabbtePAbCbIyEOpPxl2UIarNO5OJIdodAzVaUF2E2QVB9VFC9BkhxkW?=
 =?us-ascii?Q?GmNAH3P6Xrxy2dM8qnRX6PSAvWlDvD3JiYqKY+RZ/iFtdCbvNOzB0oriho8S?=
 =?us-ascii?Q?EBXHl66EEjFY7SCZ/5SkPClbGf9LHmYz8+7p3wnsLZOG6LvRIykmd4kX4761?=
 =?us-ascii?Q?KbrGk3qioxegCh7AjZ6o/ix1p8jU06YH0H59WeDkPvNgAkYmvEFvXtlUjLVx?=
 =?us-ascii?Q?nZ3fxrqnYKe9j8n66nxWATv6GJ+Z2dvER2otDjB4ObwvlRplzJtVe7wq4PBm?=
 =?us-ascii?Q?2ptWcpz36t/jNbjyLj340syUT7ZR5hIvaP9Ry3X0nKwy8eET3ZJxeXDERKKi?=
 =?us-ascii?Q?qhXJKaRLK9id3I33Pp1YsoZ+KymJci/n0HlM4vmvRvh48RwK+ohU/rLpi83u?=
 =?us-ascii?Q?7NzUibdqAQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd234a41-e780-4986-fc84-08deb0cc9d58
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:49:59.4123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGZ2nNxOBSlzxpkXbw870bAtQ477a+vJHo1J69m3QgP7ADELTtazVDP3EHJzJct6ARGCRMVyjRwCUjMfwlYrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8255
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:03 +0200
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

On Tue, May 12, 2026 at 11:10:14AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace hardcoded WDOG_BASE_ADDR with driver model based dynamic address
>lookup from device tree.
>
>- Remove hardcoded WDOG_BASE_ADDR from hw_watchdog_* functions
>- Reimplement reset_cpu() using UCLASS_WDT device iteration
>- Add ulp_wdt_expire_now() callback for standard WDT interface
>- Pass wdog register pointer to hw_watchdog_set_timeout()

In theory, patch 9 shoud be merge with this patch to avoid git bisect issues.
or switch to uclass_wdt step by step.

Because without patch 9, reset_cpu will not work if people are doing git bisect.

Or I may miss something.

Regards
Peng
