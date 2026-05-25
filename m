Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999BBCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 12:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343A5846DE;
	Mon, 25 May 2026 14:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UxBl1dXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAF5844CF; Mon, 25 May 2026 08:10:08 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8866E8405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNaRvi+3UJGrZlE0G0PHUbgsf9Mdt/qPfcKUIOKx21PRCuUVhUk8INA0IfrBR47FZbYM/dGlCe0nH5BfIR7/0cVcQ7Tu0486n0bRHyhF2CLPK3EkWhSbbNQME7p9LemzEt/LUl6Pahi1czDGFCWINlrPZIXTugOmUGscIubHzYpcT8z49r/prEJxqM0Q+eRE480S8NtdxKalrE/ueyyGfPPquB/0wFQv4gtCr2JwtILgI9czlkWIRUKRQ+eokubtHl9MGy0Jh9RT9uY9gvmAuyvZMtcTdzbHriFHhLpnBN4u0mZF4PeSJfTbr8tftrcvD3Q85vgem389Iwlx8Gq8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CHyhm5UYzVlli1jQ5t6TbfR8GHVUUrc9I+WlmUUMRY=;
 b=glyS/1mtMBaPKffTHP/5IITiuGC0+0o0aHKFAwf0+nryV/kVUw8uxE6tqLmFPx8nIfswADY/eXe5chc8krPXDTFeg90y/SaBnUxNfTth4vgrGpuaYuxWqm/UcgGFLy/l1IuZH2kHX/AsYj3WlM6hXBXl6yXmVdoYOahyR0EG3BT/cpe/Oehu+VGRrXGrc0Tnm/l+/Lq5dRE3DK8gexTYNHrzOiaVjwt+L5XlyuwDoNlChyxLrOpjKNBC3C0jPHIsPetoWJYwEiQmqJA3A9q7OIz00nmg3qDg67H7Cx93ld88tfjW9YsE/gtuuHNp6FrGqiv5F/I8mUeop4szr+w5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CHyhm5UYzVlli1jQ5t6TbfR8GHVUUrc9I+WlmUUMRY=;
 b=UxBl1dXwlJBFKr3AzAl3/T3Qq5imBjHyVyevbyX3Be+syavfDCTpPitOJIkBby+3rkjiIj8eZPw7iNWgG0s2BtLy0UDqSj8BrdiI5xYjrzEKY2k1GAcIc75oZozDJTBzoZxNegA/ycVFxe87J47aw5WGMCGt5CC3VyGEnEwBc/qBr0n+QwmJTUuV/rjDFe5P/7fbQf3a7v7Dq2CH5pri+dA4fHSney+yRMrQ78g76A87q6rpW7UO2x//NSg204hmWIp4VN8mhxlhrZIG5j/o1dEne7Nn2Knv7Pr6YMivU1B3bGDzy1yCzSILGdwXXndubumffnjob/qtiidzeBzEbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM7PR04MB7063.eurprd04.prod.outlook.com (2603:10a6:20b:11e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 06:10:02 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:10:02 +0000
Date: Mon, 25 May 2026 14:12:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 David Lechner <dlechner@baylibre.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Brian Sune <briansune@gmail.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v4 6/8] imx: soc: Get watchdog base addresses from device
 tree
Message-ID: <ahPoX6NW/Ksdz1X7@shlinux89>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
 <20260519-wdtv4-v1-6-deef133b81cd@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-wdtv4-v1-6-deef133b81cd@nxp.com>
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM7PR04MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b56226-112d-4a57-8450-08deba2441bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014|6133799003|11063799006|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ijBweOH3iTHnq7vZF1AJWjdTLnq4djWpwLXGBYJ53O9Kv9FKPgJoOdRJ/49x5HKxOu5Vt+zndblRRO6XrEPR02ZSKGl0mk2EdlyCD2/fBD0cbIKKLTjPNDn/G0aqJbhmjmQrWuswVmXfx3MeuMg7Ff8fkx4V//OO8mGNB/ei4x59+oHHJwLcsi928DEJybr+VNaWqJTWKyg1nnZF7gziOzhLAV3G4Qru4BbAdsxHjFQw2Ru7sGaFVlispnDOrWYNeBnnaIojxYM+xbn7i0hv0DwXXKnM1l9YJnApma42U6sXWaKcpoYmwHaYexk1fC2T0AVTqiosW3dwZ36i/I3HaJgNw/89cXWi3783PR2gpE4hxosaq4OkLyyuB51F+X2QnuEC3C9rxEd8LD+R/Mcflizg6KY2AVtiaDD/vWSIWMxLlZQ45aDyJpKHeAOsDY7IS/k2YGQkAGsyOQkOS+q+X0Ls2Emf+Dc7hc5rIW+p0tbBF6w26Fk1acy+jOj/ntgGD3dpSvTqOFcoFj1m7j2uPtr/cwCJsQfQOjUAdezjD3/OW8I3q40Az9lSkppVOvA8nA2ct3vTWp4HhwZ4Rmqz5aaDQse2kuf6RSH2/X4GJBm4wdrpqW47jF+a0R/w5RY0k8AamHuFJa1bs8IAtlqPY9fdGiBluF6gDpHeKt7D79T5JLXjhUe/+JUfOw7lrCric6Z53z7r9TdswhN+KRPAMLVWbEvgTKB/O163XGWCnXoabXyReQqw7FGCbKGxJWkn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014)(6133799003)(11063799006)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdTJC625DkKIs6DOAW4KowOntF/5opPZ3llLQpAUrFUP7ojs9jaoYNABlrCL?=
 =?us-ascii?Q?aRvk9ko1lqH6fAtA9IfwtWV//KGzCuGdHPyA8D78IwsIWJg+WZN+Nu0HvFw1?=
 =?us-ascii?Q?HcyUY7LtFTcqtxrQ4C0lndxB3Q3laSHVatWQRDHCbqTiimC/K3FAdcHaoRoW?=
 =?us-ascii?Q?mSO33kqeCgm0mDDeNFvqHqujq98Ky9sXxiECtuvmijpH0FSv1PMzaJAby7zV?=
 =?us-ascii?Q?Y2IYL819NvI42/lcGlXrm/xLN57+mFSJelp+OGPqbcK5T5A6GTOQDiwrAAmE?=
 =?us-ascii?Q?dLAPPHKyQ9vyf+6+1AXJh4xbgcyyRMQ5vYWHeqo9mqrK42+mF7KMdhvypQdS?=
 =?us-ascii?Q?O4QNycdiGyqdMkHpClGK0EUHJdVIEPhF+X8g6CIYKB0YXQx8Fgb4Vx3znOjN?=
 =?us-ascii?Q?IvuULWrxWsoxXdZf89sh4PJrt5gl0SsgZCzPouktmJZgV90dWx5dIjSy2moe?=
 =?us-ascii?Q?ubI63tvdLnRzslCBf2kReYfzUxWO1jBm2vGuut394TlS1qiY+brFvWp9WorU?=
 =?us-ascii?Q?E4u3ySnF6pbfAIw/t5SM14DtUS9qhW4/+pz81Mvl4ILwAzD7Ebt4dvKlsJS2?=
 =?us-ascii?Q?VTlqbyKngtNMlJDIWYMY8ItBP3G7t3IWJpnFKt5H9tXW14NZHHQU60lhHZ2T?=
 =?us-ascii?Q?n90DugANPrEvhPkUwvc9xVekfmUFMIKvGtcgyUXxhViN14SIkk2fFkyBJDeP?=
 =?us-ascii?Q?KdZJy6jHwzMrRxXP8dKazsgnUMX3FynIOuiLJ3LZAmNATVlTwhNTKVWQCB/9?=
 =?us-ascii?Q?mps6YERSf6f58QRilfpmgmLK2fjqOZWxLNVXnX5qOUNj6YPqoG6i6QKRYfi9?=
 =?us-ascii?Q?RJUIfFVa8XEsr2xgt5V8BVxR4Ti9IHbOG5Ceaqwv9xDcZ2ZDongBfbBNPmsg?=
 =?us-ascii?Q?bGeIqN4nLjft175Rw3kQEi/zytMIN/JSEDPfBspailWeseg1dGPePvc0W1j6?=
 =?us-ascii?Q?Apgli0OK7YXXaOokwC8R0Z5HcErHOZmb8Dj0SSAnIjnyZfv12by3Myzs/Y8w?=
 =?us-ascii?Q?HOyHWy4B4buq89xr4vplcE+h0X+q87lu0WuXbnFcEFwBCt3J0kAiYEV4h0Ku?=
 =?us-ascii?Q?iWlS2oMVb3m6de13QBoOoaj6FwqEOFvsip9xZ9zbPAQtFlqOVAYDk5jZNvD0?=
 =?us-ascii?Q?INOZ9awR92kora+B3W5x4c07wM+JIYk8Xe19x93zTDuC/LArGU/wh6mcCj/w?=
 =?us-ascii?Q?EyUjLp5dsVpjxNi4sOma71EBQP89yhEAniJG0K3lxI/rWnrLDqlmlDmjr1X+?=
 =?us-ascii?Q?7jEwX9NvFiX5iEfcz24Ahchtoi1609TRmbMmxvI0rKNviAlE2Uj51r0es7Be?=
 =?us-ascii?Q?PEYPiIwvxj5uTXUJtqk8hqZGbWILs+aNHM/cXB9p03j8780PAqntyL0evqWM?=
 =?us-ascii?Q?tuKaSJjHqQcPhgt1o1I5mR0ITblRuDSzXHtz2BLP+L1Ltrow+F3lckL1g7Hu?=
 =?us-ascii?Q?c43lxeGUgKMOE7grM9GRBQTsu3aaHAeSbbUY+nTr/3FnWaNv5/d8KiozBcZR?=
 =?us-ascii?Q?qB9mDVUUKZvYH1PQrNg4lUY+42HkrboGwwPxZ41o5DTNeS+Xq0KwB60r6jO6?=
 =?us-ascii?Q?66ykfa98JooJrfMK03YJjpC/KjIJVcDFdeyPhMvq+4KFfarZGKsW/8El6hQS?=
 =?us-ascii?Q?i2NLcClCgTskjOt5PQmAl1wq+Tim183/Zm1eiA3B22JScl3ALSc5may9c5eN?=
 =?us-ascii?Q?2NxO2G3k7xF/qmG0FoPqS97VpvT86IQzOugLV16AGNVtT22YucfVMY4lVm7c?=
 =?us-ascii?Q?uUDBJCLoxw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b56226-112d-4a57-8450-08deba2441bf
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:10:01.9930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cewz1NycfKmFZgsBj58xhsOtRguLgc1poBNX7gF3Naq/TL6cC2lfMh0QzX/6aDgxVhydKGxjeqPElLuw07lrqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7063
X-Mailman-Approved-At: Mon, 25 May 2026 14:31:01 +0200
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

On Tue, May 19, 2026 at 02:22:06PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace hardcoded watchdog base addresses with dynamic address lookup
>from device tree for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95
>and i.MX952.
>
>Move i.MX7ULP watchdog initialization from s_init() to
>arch_cpu_init() because ofnode_* APIs depend on FDT, which is not
>available during s_init().
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
