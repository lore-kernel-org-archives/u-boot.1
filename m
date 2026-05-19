Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FDFCD5BA6
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0CE847C6;
	Tue, 19 May 2026 14:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w3aos9ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4718D8465A; Tue, 19 May 2026 08:20:51 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4098284119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcSEj4H8Hw1Bc60GxvGttpnlv0xJ20Gd5Ktd7VCaw8jAMXQJT/dErJYtX8wtwSRRr/Ucmm0scCKwz+oCeTYL482pLV9h4iomWErXTOUOMdZApHAK+Q9hwBsNH7i9TzcupMrhk+8RKwPUOKoVLmni8lwe0U2j5yQ/FNUk8nWh4p+AoSWi6bweqHrv918c1wI3+AezEbgT6FmV2v6XvPAZc27YY9jA7LClK7irJaGCeBup1XW4O65YD2s14ySJkEIrfGjLTlFPTnNCg4lawvuPtfxXYgU5Ctc2mzKzqXclIbnmonUK0q7d6o5PIiSL404FiGe0CTS0BBdN1i3GOi9Lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrrb1ro91wnKQQ/OV4s3lZVwVYNOsAk0S0SQX7jtRFc=;
 b=mLlGP5SBP8Qk108/ZNQrQ/A1Rr39HaZEztZX97dIOSyYOHNXI+UyoO9gK7bumRLACE+9GDtJFnYyfvcRdd4b3iDqgs2NVoTj6sa3fXCARW6PyrC1kXmS9GlPse480wroCDojaQwRoMgBoyu+XhT6KnXMkOjcH/Q8D4OAK0pHfpD9Dh7nvMJIcUXJMhsZxqHHBaQMZNaoeDo3aEgDlh8sMJ4XxDHAeQv1/8oggcgEPZnvTNgfnh0unWksgJCn+l0+cfDM+NzlDR/hlcWTLfGAAdkR4/UG17Ffk2VvogRkstxsXuSU0M1OYCMKj44LkbCDssfMKLMb/zqStRDPzuBoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nrrb1ro91wnKQQ/OV4s3lZVwVYNOsAk0S0SQX7jtRFc=;
 b=w3aos9wsbt+XdN/7wJbnNk66JeJqi8xDxp5s9NM9gY0Zq4zrYLgYVGA3IeWR6Hrha658vqG5xDmpfhkrHqEHqV8/knTxFjt2rVohkVnC56cpL59JDgI9mzdIG79+PwHT3dykLg+F7KCeuT1ShlHPk6Ga6gm8/qOiqKAv6KhgVLoweb6klbihN/XYtdLGXCtNjOmMugTJYTxYU6DPN8OueutDYSYseqN6lWylqK+uNAuRU+5LJe9g4TqvvC6f6IebIQcoQOn/niwVrk+cZewH7RbaodBTuQU/HU8WJ1mkl9Rwn3KAxrC3VSObbpyIXGCXVP4UXvXTvT+8rhfIXMmCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10902.eurprd04.prod.outlook.com (2603:10a6:800:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 06:20:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:20:45 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:06 +0800
Subject: [PATCH v4 6/8] imx: soc: Get watchdog base addresses from device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-6-deef133b81cd@nxp.com>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
In-Reply-To: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
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
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8a9b27-b764-40dd-e571-08deb56ec2c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|18002099003|22082099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: aVgX+AIznfM3cPfk9hxEKwtCDBJVV2zmGzOn24GgRJblwnuPhxBcuYzW621lDcM4O7K5IfgU/ObJ9rgsc4oWMBSqujkz0NpxY1DGkBEFz3kGJWCqdjjI3eNkZ9WpujoVGc7wEjCLDK8e2r89cH+6u+oLGnqquiG/y74VYcHeCwYGZkKQmz5LvWVsT1lfMDJDvS7EwGlOWsse2PL87lQJFsQKIRikFTqFx3p9NSbpSgYdgW6LPQZ4JOPZt2Ivb/oxJS316ip83o0Q7MQeFLxAaWb2p1USt5d3+ZSD4mSxFNNoDqZpfLj6KNmYLCuSH5CDdR9+geW6JvDvkk2lwH5AdxsKV+tXxHM7vf1khN5Ya3LroS1uhra2sLvKXXfE+jSYkkv1p6gTs1Sq+v11K44d5sX/x6fk2d0jkbjNsOSOJckxWAGO05IvHVykzlH9UOaVjmN+CIOHmVa1l9qS2z8r6rpe+5aDwISY73rl4AjUUGDw9amaMarf6yXJo/K+ptznGeyice7AklklkAz/QmvqKtT7g33uX3GEKM+2PBFNbzZD2COxIAUk2sY4cJV3ir/9bQ5yXnkJDMon0lVVs0wNk6iCF/Q3oAV8WpSg31r3gJX0BXuV688QW9x6Peg7yFM6hV1NyG5ekjkDh5NsHnrdVY3kNwu4dbJetIk2dHNqkNHE17vlBBUm2WvtSZzHuLQOjMZJg+INTscInitZgx+qVMYbIHDGr3278Yh3LBSmeOIHQvfyuM4Fuf2wP1JqHD+4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNnOWNOUkNVSCtUeE5jTUFMVkk5bjRIeS9vVU5jRXhMSmxsYjExT2JHUG5O?=
 =?utf-8?B?M2h0NUEyNk05ajhoK1NKUS9FZDArSlpqNEY3UGI3Q3hLdm9hdHNRaVEwZUZM?=
 =?utf-8?B?NC9ZOVBranZ4U0Y2SDZLVzNCU0F1V3RCcEIrWCtZbmtEZ3RRbnJZR3ZWSjQ3?=
 =?utf-8?B?NjU3WXRyTWNzYnRrK29oNTMxbjhwZlZhdE5Vb0o5dzB5YlRFdEdEUjhvY1Fk?=
 =?utf-8?B?VDVkSTBaT0VHUU5URU40Y3J1Uk8vQzVYblE5cER0MUs1MzIrc1NlaHVPYVQr?=
 =?utf-8?B?NVRqZGJVbFNBQVhQaWdlcHd4ZmdHbmlBNG9lOVBjQmFvQkp4N05TNWdpemIx?=
 =?utf-8?B?Q3dNZys1TWZ1VXBtK2JHTVhQdndkQmFnV25qRlp5OHlPNGc4ckVsb0p1SFQ5?=
 =?utf-8?B?NG9LNUFaYk9DWnJBZUx4d201QlRXRFBxTGlwUkszSStsQWNBYkpVNGo0b0tz?=
 =?utf-8?B?K2NMQStjbkdNVWZzUkF0U2UvZ3pETitIUW9XNGlwMTdhNHlITjVaTWhoUUQw?=
 =?utf-8?B?MFNDUENDblg4UCtwSFFqeEVzcEdTTk5MTk85UWFsclJubk5tYTVEMzZ1d1Ew?=
 =?utf-8?B?eGdtOUdmckRxR1JGYW8zVXBpbTFkK2pTOEZuWTUvenBveGhqalJrQzRIUXVm?=
 =?utf-8?B?ZEg0SmFRMEYxUk53c1BIWVN3OTBZV0w4ZEErTmJsL2xweVV3TkFxdnQ4aUQ4?=
 =?utf-8?B?VDUvZTllenBiVHZRR0JzZVFyQldDV1ozZENHWVoycmhaQVB6UlhNby9acnlW?=
 =?utf-8?B?dlROU3hKYkJmVUpNaXNTZlI4aDA1TTY2TlpTaEl3MUttdGFsZ2cyVHE2bzRC?=
 =?utf-8?B?bmQ2OWw3MnBFWWtFREYzYVBGZE5CQXBlYjlMVnN2anNpSU9zV2J1L25JUUN6?=
 =?utf-8?B?ZTA3VGpFdmhaK1ovRmNLNTdRMlVnVm9jTGFOWkI0RDlISFFKL2IxSTR5QTc4?=
 =?utf-8?B?ZkRiTDBXcFVsUW9wK0o5cWpLZ1Y5bnNNdkZqeHRITjd6ZFVySWNacFRnNStH?=
 =?utf-8?B?MFFQWDQ4SGZoc3JoeEtFTHJuSjg1bkVsS25JUERBSEtPN1ZEelVoZmt1cnE5?=
 =?utf-8?B?ZXlsQkJQL1B2bDFFd29vem4zeGM4NVovL3dGTzgzY0lJdW1aSE1uaGszRUp6?=
 =?utf-8?B?ejRxMVA5aEF0VWxUUjNmWVNLbElrNDB0Q3FDaW1Sc1BrNHpJZWg5ZW50Z1Q0?=
 =?utf-8?B?ZHk5aFRHWFFRdVBEUks3STcxVG5NQ04xR0ZzVk0wN0E2QUNHRGVuTnFiUDBP?=
 =?utf-8?B?amtLMXJsd3Q1dytPVElaYjZPMWhVMGFqdVNkWmhWNWNZNndVRUQvcTJZVWlv?=
 =?utf-8?B?MXVXUUp5S2pJdmJZQzAxRys0Uk1XRW9JYlZ4QUNWcTBDQ0FKTWVXSDlwSTV3?=
 =?utf-8?B?SFNDQUcxdHpsdXVyR1RMcFhyaDFGWExrS0dzK3phRkMxQjJqMC9LdjBYb1A3?=
 =?utf-8?B?Mkhva1VYa1Z3dnVmZ3lkWDRxeWpZN2Q3UkYvM25IUm9pNWNpb0V6cW1tOVVr?=
 =?utf-8?B?UnlpUk5rR2x1Y1hlbG8reElPQUlvd3hPSDAxeXZFWnlzcm03R0tlbXB0NkJl?=
 =?utf-8?B?eG54VFJTQS9Gbk14VFNsT1U1bUJZSkNLNjJqWlNLWURCMVBzM2tMcTRHM2Nu?=
 =?utf-8?B?ak05Q3doZVYrc094K0toc1VlWEkybEErTHR0bjRkcW9aOTNDSkU5THZ6RUt6?=
 =?utf-8?B?UzZkN3JGUUVkZnBUaStuUnFsZXNFZ2hXMmIxUHVLUThxOC9LeXZmM0JCMUdF?=
 =?utf-8?B?dmpQSlZhTkFxcWhhZ2NMdGdESkxOTUhuQmlGMUFhRHFiNmlhWTlrZm5CMU4x?=
 =?utf-8?B?c25NaVJJdUlTNlU5Q3haNDRUeUtKNUlja2dVNGhqTiszZ0ZnR0trK2xkVUtV?=
 =?utf-8?B?Yk1SOU5aajlHZ0Z6a00zLzdsbGswMjFxMC9kRko0dWhISkxFeEdQY1RwcXVk?=
 =?utf-8?B?T21BdHRsemJyK2lNc3FiSmxyc2orbk5sWFBJQnJHUWZQc25vajh0d3p6ZGVH?=
 =?utf-8?B?aFFrTU9LMzBpYUc3d1Axc2FBMWJLK2dSaGN3QmVvS3N1RUNscGZrNnpFVXpR?=
 =?utf-8?B?U2g4eElXZ1pWSWFUR3U2M1hDdXh0THVaVmszaVNBVjdDcHZ1MHkyMFdaK2tU?=
 =?utf-8?B?cmFtdTJ3aUt0U2VPRTJGSnoxdjNDRGlhSmNiVmVnM3lGZ1BwQ2RJWlArNitR?=
 =?utf-8?B?SGthb0Q1ZE1taU1BV3ZYQnMxRXc0T1NlcnBOU1FXK0JCQTQ5MUVuck1yTjkv?=
 =?utf-8?B?NTYzYy9OL3VUSUFLUWRFdG9id1ViNDk1MkFkelcwalhXRFh5WVhFY09VN013?=
 =?utf-8?B?V0xUWDBpRGo2QmVuQlk3U1p0YUU5THExNGtjQUZMZFZnazJjcUhrdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8a9b27-b764-40dd-e571-08deb56ec2c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:20:45.3511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z33/M2xCbKImL+NnqLarw8svk52Q/J7dSmiOUIMyLSaY+8RRPCW72FD7Tu+DvP80rwz8xsow+dU7j4yFKJv/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10902
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

Replace hardcoded watchdog base addresses with dynamic address lookup
from device tree for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95
and i.MX952.

Move i.MX7ULP watchdog initialization from s_init() to
arch_cpu_init() because ofnode_* APIs depend on FDT, which is not
available during s_init().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c   | 12 +++++++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c | 13 ++++++++++---
 arch/arm/mach-imx/imx9/soc.c      | 14 +++++++++++---
 arch/arm/mach-imx/mx7ulp/soc.c    | 22 ++++++++++++++++------
 4 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 1ee483065e8..ccdb949a9da 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -343,7 +343,17 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_RBASE);
+	ofnode node;
+
+	ofnode_for_each_compatible_node(node, "fsl,imx8ulp-wdt") {
+		phys_addr_t base;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			continue;
+
+		disable_wdog((void __iomem *)base);
+	}
 }
 
 static struct mm_region imx8ulp_arm64_mem_map[] = {
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..391393d26ff 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,9 +786,16 @@ static void gpio_reset(ulong gpio_base)
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		if (!IS_ENABLED(CONFIG_IMX952)) {
-			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		ofnode node;
+
+		ofnode_for_each_compatible_node(node, "fsl,imx93-wdt") {
+			phys_addr_t base;
+
+			base = ofnode_get_addr(node);
+			if (base == FDT_ADDR_T_NONE)
+				continue;
+
+			disable_wdog((void __iomem *)base);
 		}
 
 		gpio_reset(GPIO2_BASE_ADDR);
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 44b3e0f5310..66705e27998 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -281,9 +281,17 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
+	ofnode node;
+
+	ofnode_for_each_compatible_node(node, "fsl,imx93-wdt") {
+		phys_addr_t base;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			continue;
+
+		disable_wdog((void __iomem *)base);
+	}
 }
 
 static struct mm_region imx93_mem_map[] = {
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 5306e76223f..ca1cf759fe1 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -83,8 +83,12 @@ enum bt_mode get_boot_mode(void)
 	return LOW_POWER_BOOT;
 }
 
+static void init_wdog(void);
 int arch_cpu_init(void)
 {
+	/* Disable wdog */
+	init_wdog();
+
 	enable_ca7_smp();
 	return 0;
 }
@@ -146,7 +150,7 @@ static void disable_wdog(u32 wdog_base)
 	while (!(readl(wdog_base + 0x00) & 0x400));
 }
 
-void init_wdog(void)
+static void init_wdog(void)
 {
 	/*
 	 * ROM will configure WDOG1, disable it or enable it
@@ -161,8 +165,17 @@ void init_wdog(void)
 	 * In this function, we will disable both WDOG1 and WDOG2,
 	 * and set update bit for both. So that kernel can reconfigure them.
 	 */
-	disable_wdog(WDG1_RBASE);
-	disable_wdog(WDG2_RBASE);
+	ofnode node;
+
+	ofnode_for_each_compatible_node(node, "fsl,imx7ulp-wdt") {
+		phys_addr_t base;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			continue;
+
+		disable_wdog((u32)base);
+	}
 }
 
 static bool ldo_mode_is_enabled(void)
@@ -221,9 +234,6 @@ static void init_ldo_mode(void)
 
 void s_init(void)
 {
-	/* Disable wdog */
-	init_wdog();
-
 	/* clock configuration. */
 	clock_init();
 

-- 
2.34.1

