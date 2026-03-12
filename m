Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0BB105A594
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB45841F2;
	Thu, 12 Mar 2026 13:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UmjxyKKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FD483F9A; Thu, 12 Mar 2026 08:17:50 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E3483F2A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJXu/QFMdzoTcw+FSQqqZbZruITvBJSxyTgZusFWbHtDlXnC1SMKB4YKcFbs0QjKgbA+nyYkCVNbf4WMJfOGkKVpibxsEEj2EX4pY59F+tpRk9C5wNRPCrY2CrgYbTdcUY13HHhU6rL8q5CKEg5wkmLF1Sg96WpHsdclUtJUgqL3Z3uymkF1IuVVR370ML1XpesGjBLGiLWF5S5aPd9LOoHRG+gtXqvcCnANsOiPbKxfCk1cIq0e4/Sd384Fw3QcvEBCYEVSwE0UXD6FGkn+bTMlTc7HQj8makaJO0r7ziV5XGWkyxZ4uXMs+0qfyHXhB6wUuF3fn6epXc/J9P6nmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHtwlVAC95PU+8gSrXvN/6HlTOzGeyHJSlGVIq0n36U=;
 b=lr1/P+69277hIrY1cUtgyGTYUUNp1ThoeTVcbdRMUKoeYX1x2NYuEHadxiclqMdWvuqJazRve0lJIueLzN+T59yvZdIPEOHrW15hNgmpxcoVcqMR3Zweq7UiPNlZgJUeOquNSOFrQyWuVcn3u12lHqgRbE91nPzbhNDaEib069UPzPVDYrxfCsdwKN+6tDK+CIR232I0bWELVJscJbRDc8zdQbPCRgxKZUDuVs+Jn11XVTxh8gpkTVPKdKMCD39/WKTvUtQ5Nn9vKDEiO7nWEpFn27myWArg6A1g3iqUOEid31FjyIbZR8xDpp7hkcIf3/9clKQydamvHF17ERx6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHtwlVAC95PU+8gSrXvN/6HlTOzGeyHJSlGVIq0n36U=;
 b=UmjxyKKHgudasABw3g6UVMCGlitYEnaY+rXqZeym9crazObc2AFm9IOrUdudTzrOuNLHdPY3XAuPkjcheFNzCW7XoPW+Ah0mYWNRcZixwqGMEMAo84sAEojWvCrYdcMCrmUudH1XCCYQkRiNz/3oPLrFetc+8v7yhZiMs8rgFVCJjC7XrTuWcfcVgDNsVuBRwaC72u815ob9bQC0682a/JfDuuqGJSbjyOlEQ5W+esY03t70iZQHPj/HpLp0uoftEKjB8niQR3VVyzoFbMEqr/6dS8hlL+3LVuma+xtLAiBTc7LRkJaszuBMP2GICpuLoV/oLJwCdq6jLAlxh09eXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 07:17:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 07:17:44 +0000
Date: Thu, 12 Mar 2026 15:19:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 02/10] watchdog: ulp_wdog: Get watchdog base address
 from device tree
Message-ID: <abJpE4xcqatUacZQ@shlinux89>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
 <20260310-wdog-v1-2-2ee21e890634@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-wdog-v1-2-2ee21e890634@nxp.com>
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9456037a-1bed-47d3-2776-08de80077474
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: O3JAQe6ifLYdOmawLg3CSgUPZ+mo8Wo2OPS4jeG1bAmOjxjehW6vvtBqMyGj/ip596WX9JC6GwuVbbufN/UroOIG186Sj5jE6VjIbAeQuSs7z/LdxR6KGY7oIQkkrn/CrZGrErH37mWpVndsJ75DkCVJNuPHbWShhbz9I0lqopVxnTmU2xEO7E9hlQfiz9y/xBDyZQDBDqTYiXwWR4UBJv1ngj16WDF1OC9HWOgrDzzCaICEwkmKPKDBJEC0z3IEuqcpy8flQb0vZ0ZcmFW+El6A5R9lvwVPYAfBevve4I40i4WUkAXW0zPF75OFgfhKKk/vC/Q0BbNUz13Y2LhbyqlBGXi9+BT6S//diTa1RnskI2MXcX99mJqwIEipbTft6yjOlNrvhrVKP5ptmoIQan9MCKsebaIyBBi9G4apvgJSobly3zDV5f3mQRjUyx7sPS0rwJgkxVSrZmxC8dPl4qZcxZwYA7aOA52CgUprvPtRRbn3b0PVy+IMGsg4IiM8UZVYwgJl0zf3XL0xCORuck4q0ni7ZfjpBGwl1UMjypPW7/xwK/UmL3w5Q3qJwl4Sqfgk4NBLaftnThExgfWek5MDUqPAdO/oVqR1Tuzf/XPLgwKcWo2XJ5eOvqYoH4cMMdc5RAP7YYUkCATpw5l2JB+BijaR0JbPIEd36O3oLjH8O1QpkUb/IdKfuOYeik3pALxxXAuXVUxGvBUO2Ejt4hS7zz+WM6Hvi3DEJpJcJ+6MbN/9YpAFKZ1kORyipYH+d1+zTHhiHYIZcDf085a278jaECtgmE22CXHqykGlM6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSJu68PZd+p2bVtBLjoDydu37znNtvyLksU725X44VBE27+r9TQ6UPrqWnaT?=
 =?us-ascii?Q?AIiH1QgfY4jBvhW3NoS/xMPG/ZhuWGu9oXRhLyiKj76dZW4aeVooREwTgL2T?=
 =?us-ascii?Q?IbHtLJ3aejtGv8uR8C8vc7Co9cbsd8jI7xG8zDOe7OK9aPB9LbEuPatOxSZ6?=
 =?us-ascii?Q?MWteD4TiDMvLZHLDXRF7TCGmaYEYaR9T/r2hh3HLWikE23leOgbj/dX2EdGU?=
 =?us-ascii?Q?r6lmwp91Ov1CooJ5VKJbzwWV7Vc4pQ0uNHB1lJ08YCNL+UfDIVcIDv7SZVAH?=
 =?us-ascii?Q?9ofsdlveNeuSOLz0eQvJ12YeFv2ZI9TL28TepBKUN4I4cutaAL7AqyPd3vvd?=
 =?us-ascii?Q?TyV3ppRvufVQQqUgLjMawcO8jbojrLGrEFEke/V5gQufJqr6VzhXOolrzLHt?=
 =?us-ascii?Q?oTsIGJVJ7BzO8+tAk7CNPnydMh9+hSJ3ZqA8p4mlugszAwsYfdWzLNsjKxJr?=
 =?us-ascii?Q?0yBSLcZWSzumtb5qTdwgKq+D+wl/U4pTbdH7PaxfWzKsB7EkoFaPrhIOS1W+?=
 =?us-ascii?Q?E6uvI/LrFopN/BIOK9GLpyXdYVvNxuh19AfrsSzgmvNyz1xnM72yjQy4WkbF?=
 =?us-ascii?Q?gKwn6/CToJ/amive7c8KmSf7prlyExVHUsu7TAcxJB5iLDK1xZ8C+Rpq7frG?=
 =?us-ascii?Q?uKzf7i3dA2kO2ORsXr42Du0+d4/ZGmOXbi7doh+gntmiynybnZ5GDeONGC9/?=
 =?us-ascii?Q?pacyKTRM+ZV+ThJd34mca3D/i26o12bVQDTusuLpH6LNNaW9Ed3u05bw10S5?=
 =?us-ascii?Q?kklDjA+XlB8FJst6B/Cu479ar1bqLiM+ghgeKGumST2I80WnQs/5sXHqMjNE?=
 =?us-ascii?Q?3Jadvjom9awytnJClp6YotYPVeh7oiF8ujJ3Wgt898w/Trnt2uSC6hpzPS8L?=
 =?us-ascii?Q?2S7z750UcoTVtg+g3EUeztQ9HprFBebyGfDo6t0rVKaQz0EHZMaBSBMpsJWv?=
 =?us-ascii?Q?Zr74A4AS9HderyI+Yw7PuuqVDu8oaJ3Q9MM9HAmwEO72yGhHRLZNvGd4I9Hi?=
 =?us-ascii?Q?A26/NCQA4VXaHJG5JIS/qLBA+G2DjVp6c/F/jnIGxfOozZi/e6WdrjMBH7w5?=
 =?us-ascii?Q?gDswjtNkZvzTb9gy3aUP8uU4qd/RHv+c7tp/ZhVKLU1JjVHC7tyeXy8gdL7k?=
 =?us-ascii?Q?0PpMjZNuYmg5gXtECClTaSdypemclXLdAD2DvM26FwocqwT1bh3y4OY4xfaa?=
 =?us-ascii?Q?LTtNvKIsJ3EbjG+hPVOe1xKmaC8b4LonkTKU24Pj6WxETG+Qoj2649ToqhlN?=
 =?us-ascii?Q?ZO0AwKgSzAbajezwUMaWFOhaNGqou9h+O6Xim/1Ik91beEJwG85H/xNOXGcU?=
 =?us-ascii?Q?/iU4iBXY618yPZX/XbAw/5kygmLuPAIs59LuaOeVpxgDqbFNOAUN6ttR8oc+?=
 =?us-ascii?Q?Qe0osH3z4w2KKPQr5ldcUgFScIMbkxfv/K8vJGifLIq+q1hu6MVRXxNJVsZt?=
 =?us-ascii?Q?wywgYughLptBo0S77UXxhgSTVnxfhDUfgAcYQ8K6nHhCTpLbk72hzAomnXeT?=
 =?us-ascii?Q?uIsXfGcTWXA35AqqNjGadcGBGagF28EDiJeF4EaJhp4a1gF5pG/sKhP76ip3?=
 =?us-ascii?Q?ckBrrv5q3AQTpH8mhTtT8TtRig1pwhsFrQ5D8j6VcCumqYWwzNnPkgDzANz9?=
 =?us-ascii?Q?s9S88baNMdFOFCFkBC1jiIMH8tlPLCQYDH2yiDrFaFg0KBhVv0OJ5pMClseH?=
 =?us-ascii?Q?Pk1k14zi54XJF/w17im0Ar7FfEJ0lykK/PUaYwT5Mq1ilQSLP3T+09oFzhEW?=
 =?us-ascii?Q?B+/d1JxV/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9456037a-1bed-47d3-2776-08de80077474
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:17:44.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSpxW2UCrfH53rF4wyxAxICLf+ngbw1H7zeePcqJlZGMTHo6BIQ0fVBPK/RLBKzeEMu4mnsgodByjG8kW46fzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:43 +0100
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

On Tue, Mar 10, 2026 at 03:53:36PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace hardcoded WDOG_BASE_ADDR with dynamic address lookup from device
>tree.

We need to convert this driver to DM, not patching non-DM.

Stefan requested to convert to DM quite some time ago.

Thanks,
Peng
