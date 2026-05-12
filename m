Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC34CD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B5784694;
	Tue, 12 May 2026 06:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GDKRvJeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 534128464D; Tue, 12 May 2026 05:09:47 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AED83CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXdpR667UDTmIoviyyuqjpdJ9myUd2rGjsN+OOMEofub5//XS3Y7mNJPvoJ9rjSgqzijk0rS5ccN3IUO83ZI9FiQ0rom4NoNrKdrUW7gNkFKW8k1TsOR2KP6DzXAIvjshqJXgUeAWhRVVGMGptnMkddM14LlYswZpBE/yfU+/8lfgyzMdG6UYtuXUxdoQZe+nfq5kFoE/b3pNndZ926LYFIEnBQC/OZqKjMbl23aoc1poG2gvIQnoe1u8EAh7l07gGEPfHvrJs9d+h3nVgBrMUNWGveJQ7RVLX5Tu/SpkFXBAGRvQPryT9L6hwHuEbaawTJ2XcFe1IQ57EqR1gDFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTjFIvKdlOwC/WYwbUXMm9EwYRhzk8JHl0UUlWgvm7c=;
 b=QBq8hlSjBn0ugGc713iNFERyPZnHfEX45v5o6ky/qZSaAcu0h2aDjdnSC912UMY9OdI77hGyeiwOWdhlThR45K/H/BgasVnbgx0DkkgeD0ul3r3/Ck7Fo0nWQh8MAzcDX1ZH/xXKRirsrJxVt/O+EcdhE2sW9XSq2CANy1VlayU8YxfaVcMuL9D98VKPp1RwQmmoz8rR7CO6RrMrUtByRrDZrf2NrnPYZ7vr2lRsO+REi5xhcAIl+vL4vHdgpF846jx9r5zn6PtzHCSp1eBEe06COXLC6kvfdcOZn4mb85ceZa9/L3Zj0e0dZVfv1gW7kRzaEjqaRSG53kkjcAkCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTjFIvKdlOwC/WYwbUXMm9EwYRhzk8JHl0UUlWgvm7c=;
 b=GDKRvJeg5NRlflEb+FeTrCE1oRtgcuncJpQdU9NZJxrTA8Gr6HarT0MPXN+a3Jt8i3X+nDO2rHmnjcYkqw1RIjYVNuoFMPHFC7MoP5eRriz9Q295Ep8u+I8Blyoq1aUxA8ts7ox3yU6vPFlV/Y/WQDY3nOdlqOlSSE9//nNNUg0pnhKVE4jthVIMQuLctcWf8f7VFtb51GbExpyEoP1tXyQ7h2RAe0HulP0cx7Mc21b6paKXlWxlDwrMO5901n26AFDhTs5DHmlWT+IqqymQjkHkOZ+ypWNjn+XsAi2/vUPd20UZhBetZLTmpYEgN2wJr+VaZrvqeW8DzXoVsMtlvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:09:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:09:39 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 12 May 2026 11:10:16 +0800
Subject: [PATCH v3 9/9] imx: Remove hardcoded watchdog base address macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-wdt-v1-9-0b9e1993557b@nxp.com>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
In-Reply-To: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Brian Sune <briansune@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Ion Agorria <ion@agorria.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, David Zang <davidzangcs@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 486cf04c-7540-40a1-1eeb-08deafd3e7ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|7416014|38350700014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D6G+I+Wjr83GWqR/eZ8EAh6OAffTv98jnzSyA0cQzH30Jems1zf9JyIrqmBCD2kCWZSbko2/6JWTKW6SAWVjJA+AtQGINRkBYosm+3kRX3qxd0tqDFWdbES0arKp8oWrCaQgQosVKJGd/pRcPAUrelPOhhM7pQIO7bafagmR5IZ1rhRodpmoZVHj2J1gT+8vhhP8HufCkC1uLGuiiRd/E08h4qT5QtDL18gzA5EBCxKVwPyozvLidoMgtaNiEj8Tk6Eu1nXrEP4DNEuWUW2+QgEewFgOoWy6jlv/NotlY9M56XeaVccMojY/xodoRWSlvaANcwZefzLpMAcaWKw3TZXNXYoyPUuvVbwwr/++4bOh0XDMj0BGmwY0O4mHv9QEhIOCpcc6HhU8g3Q9x7P9LOC+3OZ4aqDNQ+r9RVE8yougb1dCtkG4YSIhdvL/KdSNKf2AT31iVXuxQXQx1oPPzOi3vAYLz5VsrCg3lEoYf0uIpcwDGbqvyjebwC/t06xcFfin4qGBmYxSSUD47LzbAeF2kL0qO4cHkbRRNLOgb/fWHHn+Iq+z/aR+nDEM9tcSSTpFaJ4pFGOoP3p9MVdL1ydiGQwVqOFkbdDfIlFCOJmSvIU5YZ5czGB0utyNKou6ZvVByBHX9NWB3EkCHLxoCDqg+wYn2Hod2MlOsAYZVqMG94SSMY5kAxxXRU4t+OOHkHyFb5qhXr2XMBxkeEja0uHuoq7VLvWRmDVdCv02609Loh+nFEpC8r+yKyzdesLc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(7416014)(38350700014)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZYRHdBMEpvVjJkRnRCQlFYd3o3NU5UZS9IYXlrVHBtMFBsUFFZQlc0RlRM?=
 =?utf-8?B?SjJ5V0pQd1dGMGd4d2RadHVQYWo0L1lZTTBYSk5NU1o3ZElFTEc1VE5MbnBW?=
 =?utf-8?B?Z25zVFozV1htRHY1YWVZL1dQS2g5RlRIc3VTMmh1RVVCemV2RmZoYjRCdGJH?=
 =?utf-8?B?emdkZFJ5R3pSZ1E3L3FCQjBaK0tlalYzVHRiZmpVakY3UXlXRmE2NXZhbXFI?=
 =?utf-8?B?aFJjMjhsbDBxaS9wS0FuTnVUOFE2UUsxVHRIQ3FzbGt5Y25IVXZ3OU5qUEVt?=
 =?utf-8?B?OFVnVWQ1NERIeGVyWW9jU2pVU3VGV1kxdmhFR3pDTWNyMEdjZHhQSkI4U09x?=
 =?utf-8?B?a0l5VktEMHl2cWhFZHJwK0s4MGE0QmsvK3hCcWZLVzc5QUxudzlFa1JZZUlS?=
 =?utf-8?B?MDBIWDhNWmtML3NWdnVSZFFRSVBaMmN2MXdOL3JCd3JKK0UvK0NZUDFHMVRt?=
 =?utf-8?B?RkNyYzFMRUpEM1hHR0ZVWlJHTStETzhiM1FOMDh4VjlvQjkyVjg5S1ZhSGJO?=
 =?utf-8?B?c2k0TWloY2ZiQmYzNlZrR1JHVnNDRTQ0RGF5cjZDS1J3V0NBNmZSMXcrVkpP?=
 =?utf-8?B?UzFGdUlZOVJ0S2VWME4yRy9YZU9pQmd1eDk0Y2V2dy8yZlpKYktrM3pyTEZu?=
 =?utf-8?B?TndkZlF5VmxncTc0ZXY5TWhDTjhpclJkS0xsZENxdmFPcHhHbXUrQXhDWEhL?=
 =?utf-8?B?RjZIbGttMmUxWGZ5WFdTMEE4VjhCRThPTFc1QXd6SW45Z3drTDN3L0FiNjU5?=
 =?utf-8?B?SC8rMWtvTGErVzduVjJSMklmWnh4MGlkY1d4MmhsQ3kzd3ZWeDJ2Y1JveWQw?=
 =?utf-8?B?d2p5eDBUVDFJaUFuVU8rdGp4b1EzYVd4b2wyUi9oMFFjYkxVZS9ScFRONWp3?=
 =?utf-8?B?cXFiNnZLMW8yTzNJU09RZENOd1NqUmR4WmkwQk1QclZPdFMxUGFxdkZRKzda?=
 =?utf-8?B?c2tIZUlWWjFuWFBMN2h3dlJDcU9taXZYdndCZUJJVHRQaG5RcTE4MnExMldV?=
 =?utf-8?B?YlBtRUNJaVcxdDNQTEtuMGJhQzZlS2ZLc3krR05wRmliMW0xOVVFSEVncFQ1?=
 =?utf-8?B?eFpvVVJVay9rTW5WRjhmUWhFNk5oRVU4d0V0NWRZbzhJd3pSaitlQWhCRkNB?=
 =?utf-8?B?c1UybFB3ZDRHNkM5eTlkNVduSFFjWlllV2sxZHhHS1RBNnFkNk84SStTYjJY?=
 =?utf-8?B?WXRDSElJOWt2NS9BcWIwdm5JeTNqTFRtdWhXSkgvai9nSU5GZ0pWNG9ST0xX?=
 =?utf-8?B?RDNOQy9qczl3d0JsaXZBbkp0TWZhL0J0Tk5CWmxJeENraGdpWTlTcXR5R2t6?=
 =?utf-8?B?eHVwT283LysrSXBXRHJmWTVlQ3ZUclFkaVdBREdyQTlvRUZVWTlhdlk2RFcz?=
 =?utf-8?B?SmlXbXZMdTU0TG5PcllrNkF2WUFVZ0dKMkk5WWhXbkF2bVdWdU1CZXhvQmVn?=
 =?utf-8?B?eWFvTFBGbG1nQmRSaFk5YVFvTkMrczBXVEFNY1lXOEVHbThmYThVL01kUTJJ?=
 =?utf-8?B?aGhqU1l2bXlETzc4U3JDZGV0ZmN1MnNkajl4KzBHUTR5YmN2Tm9uMFFQa3BJ?=
 =?utf-8?B?SkZOckNMWDJSZERZbTZ1VnlRbkcvV0lHSUlZSkNQVmh5ZG9Gc3BQRUYrVkpK?=
 =?utf-8?B?RHFuMWR4ck42amhlV211d2w1TEsxck9FMHU3RkNncmQyWEFpV3F5ejc2SGEy?=
 =?utf-8?B?YldZVm5ROG4wR2JzRXVidnNtbE5tZnh5Ty9zcEM1SFZDT1cyeGlVSnVVNG1T?=
 =?utf-8?B?TGpYaWxhOUZ0dVlXazJ0cTU4S0tGMnlkWDN3VzZkaTVsRVJHM05TeEhMa25F?=
 =?utf-8?B?VGlzQ2FSNk05TkJPWEVtTDdSc1NFOXR5ZGlWN0hBZlo1aklOQk9LbHFOME8r?=
 =?utf-8?B?dGRjYTRIU3N4cVdMdjdFdll5TkpVY0dTNXp0MEd1eVcrNkpMTCt2NTk2MTZK?=
 =?utf-8?B?SCtwMU1ZdDk1VlFCS2FYZ2hkNS9nUmVQVjZVelN2WVRTK2tXdmpFNG83Zmds?=
 =?utf-8?B?K2luVmFyT21rQ0d0R3lLNXJnNEplSFN5WlVxNDJxdEx0MGZVMVJackR5Rjdj?=
 =?utf-8?B?akVjSGRPTWZXWTlTcmFtTlBoZFFEM3p4SHJ5NHNVSDhxeHJpbHlEUXkvbWdQ?=
 =?utf-8?B?OGhZZ1ZJek55M2M5UHdzT1RHTTNwUVpFSE1NWVRHSGVQdGpvcldOeGpVajNs?=
 =?utf-8?B?anJPQkh1S3FRZ1ZRL3JpMEhwOEYvVkNkVjA0VmpKMVRVR3VsYUhScEk1RElK?=
 =?utf-8?B?N09hM0JPU0ZUTURwZzUvOG45dmo1RktuOEsyWXdXQmtvcHl4bVlwaW1VaGIy?=
 =?utf-8?B?SW9ROENNK3FRdHJBVGt3dnNEK1U5TVFTai9SUVNyNmphOFNucDhqUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486cf04c-7540-40a1-1eeb-08deafd3e7ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:09:39.8485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kWO/SVK0eb32xBH8LH3o8jpgWfxD7czHnRWzt6EFtnPY4GdP+mMsJeiM4401WvEuCZTOv3KkCYBaL5r/ZPZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
X-Mailman-Approved-At: Tue, 12 May 2026 06:40:14 +0200
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

From: Alice Guo <alice.guo@nxp.com>

The watchdog base addresses are now obtained from the devicetree via
ofnode_* functions. Remove the hardcoded macro definitions as they are
no longer needed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h | 2 --
 arch/arm/include/asm/arch-imx9/imx-regs.h    | 9 ---------
 include/configs/imx8ulp_evk.h                | 2 --
 include/configs/imx91_evk.h                  | 2 --
 include/configs/imx91_frdm.h                 | 2 --
 include/configs/imx93_evk.h                  | 3 ---
 include/configs/imx93_frdm.h                 | 3 ---
 include/configs/imx93_qsb.h                  | 2 --
 include/configs/imx93_var_som.h              | 3 ---
 include/configs/imx94_evk.h                  | 3 ---
 include/configs/imx95_evk.h                  | 2 --
 include/configs/kontron-osm-s-mx93.h         | 2 --
 include/configs/mx7ulp_com.h                 | 3 ---
 include/configs/mx7ulp_evk.h                 | 3 ---
 include/configs/phycore_imx91_93.h           | 3 ---
 include/configs/toradex-smarc-imx95.h        | 2 --
 16 files changed, 46 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
index a038cc1df33..f9c5e21c14f 100644
--- a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
@@ -20,8 +20,6 @@
 
 #define SIM1_BASE_ADDR		0x29290000
 
-#define WDG3_RBASE		0x292a0000UL
-
 #define SIM_SEC_BASE_ADDR	0x2802B000
 
 #define CGC1_SOSCDIV_ADDR	0x292C0108
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 2d084e5227a..fbf2e6a2b01 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,15 +17,6 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
-#ifdef CONFIG_IMX94
-#define WDG3_BASE_ADDR      0x49220000UL
-#define WDG4_BASE_ADDR      0x49230000UL
-#else
-#define WDG3_BASE_ADDR      0x42490000UL
-#define WDG4_BASE_ADDR      0x424a0000UL
-#endif
-#define WDG5_BASE_ADDR      0x424b0000UL
-
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index edfd6f70815..b4f80fb944b 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -30,6 +30,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_RBASE
 #endif
diff --git a/include/configs/imx91_evk.h b/include/configs/imx91_evk.h
index 9c5014fd0a5..13918e2b873 100644
--- a/include/configs/imx91_evk.h
+++ b/include/configs/imx91_evk.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx91_frdm.h b/include/configs/imx91_frdm.h
index 6d051ed88a5..480b3fb477a 100644
--- a/include/configs/imx91_frdm.h
+++ b/include/configs/imx91_frdm.h
@@ -20,6 +20,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		SZ_2G /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index ffd72a38bcb..67774f54790 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -26,7 +26,4 @@
 #define PHYS_SDRAM                      0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
index c98c10774cb..bcea360b399 100644
--- a/include/configs/imx93_frdm.h
+++ b/include/configs/imx93_frdm.h
@@ -20,7 +20,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_qsb.h b/include/configs/imx93_qsb.h
index a7b94f7ab57..350f094c2a6 100644
--- a/include/configs/imx93_qsb.h
+++ b/include/configs/imx93_qsb.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_var_som.h b/include/configs/imx93_var_som.h
index 9dc10aea407..6a425e6d1ea 100644
--- a/include/configs/imx93_var_som.h
+++ b/include/configs/imx93_var_som.h
@@ -38,7 +38,4 @@
 
 #define CFG_SYS_FSL_USDHC_NUM 2
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
index f93c3c4e4a8..2623c13db06 100644
--- a/include/configs/imx94_evk.h
+++ b/include/configs/imx94_evk.h
@@ -18,7 +18,4 @@
 #define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
 #define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 3d22740b3f4..1fdc9ce21ef 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -23,6 +23,4 @@
 #define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
 #endif
 
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/kontron-osm-s-mx93.h b/include/configs/kontron-osm-s-mx93.h
index ab2b42298c8..fed75e6fa12 100644
--- a/include/configs/kontron-osm-s-mx93.h
+++ b/include/configs/kontron-osm-s-mx93.h
@@ -25,6 +25,4 @@
 #define CFG_MXC_USB_FLAGS		0
 #endif
 
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __KONTRON_MX93_CONFIG_H */
diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index d27e9d2eaa1..501c3059cc3 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -15,9 +15,6 @@
 #include "imx7ulp_spl.h"
 #endif
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1MHz from TSTMR */
 
 /* UART */
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index ace1eee70cf..21dbec837f0 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -11,9 +11,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1Mhz from TSTMR */
 
 /* UART */
diff --git a/include/configs/phycore_imx91_93.h b/include/configs/phycore_imx91_93.h
index 02fa1d9b274..d1bf086546f 100644
--- a/include/configs/phycore_imx91_93.h
+++ b/include/configs/phycore_imx91_93.h
@@ -22,7 +22,4 @@
 #define PHYS_SDRAM                   0x80000000
 #define PHYS_SDRAM_SIZE              0x80000000
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __PHYCORE_IMX91_93_H */
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index e1aebd70af2..8a880b96503 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -19,6 +19,4 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
-#define WDOG_BASE_ADDR	WDG3_BASE_ADDR
-
 #endif

-- 
2.34.1

