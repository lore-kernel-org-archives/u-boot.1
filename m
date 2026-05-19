Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E8CD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3296843B6;
	Tue, 19 May 2026 14:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Qno1CqwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693AC8465A; Tue, 19 May 2026 08:20:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5883B84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEGgzW1Y+uzRhFXMulrtMC13gtben2xknOyWQmxiyqxcTl2D8sgR0wmXXX7p7mULLbxl0KCKZ6X0WXDoSD4161kmG0v6fU8YbkK+G0FAvmocKTDwI2GMMUMoFkngvdeNkBNyT9BB2p3IVu5iYSJCcfDzO8T1Gjgs9nskXtGytdPOh2PTnJwMqYj3j9IpTK5JGAIVcgmrzgELjt5AXu+hK7zjaw2iLj2OffyiOx5OvxPHhd68nn/I+rCiBD/kr56nwW1YPuI2IxY/fb/D0Ozpj8akABmSLW3qUwMajF9v2aD+pJVpJrH6TX0SCySoAN195ZE8iM7+ZKDWqrfEDu9ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6AunxTYIJETuMDOaoH0gVYbayULnUCb1QFQ1dwIDj8=;
 b=ixehvoVNlYQn7yXAL5W23a+w6rnzvIlyCoKfg7fPsnDl6XkRy+SxtSJNAUWd/b5OVgzFFAfgNCsVl7j4R0SxZmocCQyIxHpKAeBSqSJ61VUmbqSW4GhbKQAtdL2JOIKqR5YmHCShsVFskIL5GYRTa5e1LCBjr76rEDW3hjuYGS8mkTC3Hc72ziTRQ69+euTSw/hx3sgAePPp8XrmT+3k2xWYRp6vFV2GAcrP5VbjRUh8SS8dibbJvidUWCX68qN5MfwFTmkbxnuEs1KGd5cwxYfj0FGj6rzVhE1GXKd1Dc9IJByispyEoK7e4s6DR1j7DGIFG47uMRszTSrDj1BeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6AunxTYIJETuMDOaoH0gVYbayULnUCb1QFQ1dwIDj8=;
 b=Qno1CqwKb03rWmLTnJg2NMw0XRQ1jM4ClG5q3vlcmR02GqhoXdiBJ/GMa7P//7ombQ5HJdHtdywAC2l59TB2pVu+nj1ac6hOuzsEmVoQ47mWR/pvIFqdGpVnEJ6K0QaeOvxW4YdbdEEQKcBKcLwhNV6PsPrGj3jrlBh/SbG46mk7voUty2AjlxR3R2lul+DvVzj0UfEdHpIT40rcTZJ8wca2OzMDFi26JEp91GrWJmgpUL+G6K/GHCxGVHFMW6+iV+js0qeB4Qgzd1VchBfskPyIb90kfPQG/SEl1r3Xw+yTYqwKwnRDoM889rCbV40/Ydpg6gSidhtpDONeHdUeJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:20:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:20:33 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:05 +0800
Subject: [PATCH v4 5/8] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-5-deef133b81cd@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: ef93309c-1f84-426f-dce7-08deb56ebba4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|22082099003|18002099003|56012099003|38350700014|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: hu2yCKJOBEHNbDvFhLX6KH9yR2eVqgHY4FRVeVIY3rIQ/NHYr8qwnUHEg9G9YxIHh++5tQ2U8ZzeKb/FJhr/Q0c5SKgBw98ZJEE5C6s1pMcefoqvHgVnod1Udei9M0vRCbycQrPEd4Mrvh0yZl0kg5FuD/+SsBrwopMWwBLLRWoURkxyRksHPKSH9vZezM4wzrru27t0wM92oaPhJ/6mN79qvRUzgrqA6lelai6+RE//tQA2jcEPlexZoiThCPLQ5qN2JbBK2fsJSyoM/Mc2NAzELzZNS3a8acHAzm+KkVJXLHdlwO98LMntQb5PsLpyg3FQyDH14pjy7ZtHVlcdYfFMMh5o88qFOglTnFjqJDrKRyuoiHFk9N7Kaha82OT8QH4+/gIrHomxOeRklJ0UojUc0+FNSaHEQHHhh7kskBsn5hRyqTkek5dD5H2/U5+PrMPP8rszaxIALGx6pMTIMLL4Nf76OlqlD1PdkgjcNj/j+FmTZ7eyzHxMsQ95q3ceSOKzJt+Fhy88Nz7GYJuY29OrSUseBd4iG+maUjoS0bMGHHgawxVC4qWpIN/brHzTEzmrritvkuE2HjPtJ4LCKFj7G8slQ0nErDkfkdakM1tn1++zRkhWmPZZUMcG7sJvMCf/5lyT3F+p+KdaEjhQiF4B243PdG0+zdA67evZKMoWNCseifupBlrNjTzjy4BTUtG4MRRJh/c+YYhuRaK3UPGDUr6WPb30cMU1V1kymqkWeFuPQm/CP009mVTQGMht
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJpY29HZHdvL2VxMUhEdXFMdGZpSWUzdHNTWnpXRkhCanpHdkVURFBEeGNn?=
 =?utf-8?B?Z1ZQb0RRMVlCNjdBamZ6L3BtYlIvNHNoRDd4WW5mWSs4SGVRZXYySUZmTjVx?=
 =?utf-8?B?ODczbTgzMGJRVWtSTXlKUFJuY0VrU1o1QWh5YVN2ck5kbVB3V1oxVlY3MWl2?=
 =?utf-8?B?ek1RSjlWYkZRTS9nMTJPSEhXMzI5eE1pR3o3MDJXYzR5UDZIWUMvYUZQVWJP?=
 =?utf-8?B?UTYzTGJBSmw3aXVYRGVFaXdPR0tYMzJYRHNhR2cySzRxbCtjaDk2TTBSWWlv?=
 =?utf-8?B?YmJJeHpzbUVkZktaZ3R5STRUQTh0R2dhK2lHSW5NRUxZRExXR2ZZTUZUOU1q?=
 =?utf-8?B?bFFKQ0xKS0FhOEZHYmdhdDZTRzN3WmhwRVppUStsYzhoOHBBR1ZXdTcrR1R2?=
 =?utf-8?B?d1BmTyt2RWxIZVdpTWJXR013Ky9zbW5RdC9YNkFENENwcFVJUVJFclVDZnZD?=
 =?utf-8?B?L3hlSEJweHNPamdDZkVDV05IUHRkRzlqVUJlV3laRDdZNmo3UllyOUpyT3dI?=
 =?utf-8?B?QWpMeWRoRUJ3NWpDRCtZcG1YL1VTWHRlTVp5WWp2cGFlWWFFWHU5dDJSWkdW?=
 =?utf-8?B?V0dVbUUwcWlMc295Zml1RDFiRmYycjFIcy9zZndUUXlNcGM5SmczR21nR1Ur?=
 =?utf-8?B?Z05JU3E1QVNnQ1dwM3BHQnZnUW5wbkVGQWNWV0JVQ1FFL291TzdqZU9jcUFZ?=
 =?utf-8?B?NFZ6S3BRRVpSSjdVUUszaURUb1cwLzRRTHZna0o0TjU3T0EreGVSUG1WSVpt?=
 =?utf-8?B?bVlFMTFFNUQrT1ZCOXdFeUJTTllWaFNMWG9BQUdRb01LRzlXM0VuL2tCZ3FS?=
 =?utf-8?B?T2R3clVlcm5vN0VVcEc5ZWRXdWR6ZGp3UUluOGpkM0tkVzlCVTYvWm44VWRG?=
 =?utf-8?B?QTExWGRLbDYxQkppblhpRUhoQzBNSHlXQngrS1FORHFGdWxNell1bmdVQUxT?=
 =?utf-8?B?K09wS2VLNmppK0dSSjVBSUZGbWViL1NEa1BYcTF5L1Bjdyt2TURZMHdEeXFX?=
 =?utf-8?B?a0NMSDZ2SzgrcXNsNDNPRmNSWXlXMCtvamwrVDY0Y2Z0OWRNL0J3YTZwc1hM?=
 =?utf-8?B?bnVBT3dwY3NaUmpqV1hZcDU4a1lncThkRHV6di9LOGlXVXYyWUVGeklZMUxp?=
 =?utf-8?B?R0hKSVN0ODhoaWFQc3B0NVZ2QUZBa1BDWld5MHJLSW5ZRjFwMEtJand1WC96?=
 =?utf-8?B?UCs3YUw3ZldyZXB2ejRaOVlXbnJZaWhTZEl5UzhBNnpRQkNzRlQxNVRtUmlk?=
 =?utf-8?B?S2pybUcwaDU0ZGUzblRnVlRXeWpKWjZvK0s4L0VUOFkrakdOL29RYjRhVE4w?=
 =?utf-8?B?NktFS1VUOCtqcHZTYy9tK0NQWElqM2EzSGZmRmg0ZnA2eGNoQnROYWthRXJX?=
 =?utf-8?B?K2JLTEJsNHV3R2ZMUHNxczRRMG14b3VrS2JGYjQ4c0c1Q0dWRDBoaXFXb04z?=
 =?utf-8?B?Z2JVWUJSc0lhYU5oS2pTcFltWGlLVkpyRWE4d0pTVFFXV0dFNTJ4LzZIbm9a?=
 =?utf-8?B?QUd0elZJUXNJSW9SdXd2Rnp3MFFsVG56cGxPL3lHN2ZqMmVJd0dMT3cvcWVh?=
 =?utf-8?B?akgwZWprMmlMM2kva0p1c3hIRnNzTVhxdEtMcnJpMlZ5eXhOS0Z0V0RucStp?=
 =?utf-8?B?UnB0N29ocW5xN1Flcm0xWVNPQnNBV0dFa0tuWWNuejhiWUs2c2h6djZBYkpP?=
 =?utf-8?B?cGNvcjJVUU5rZlE4ekI2Rmx2dUV3dzV0SkdiS0t3VDBEend3MDlBb0lUU0dM?=
 =?utf-8?B?QlpDbTErMU1zM243R3RDSGV4aExNbHUyYUM5MFlScFpaMnpZSVdYbjBJMW9m?=
 =?utf-8?B?aXkwQjBWOGlvNGJaZExhdStEa1dQYUNCbUp4SUNIYlpIZ00wQkppN0VZMmpX?=
 =?utf-8?B?TDdMVWpPclRIczlaYitiS2pMWWRBQkJkeThUM3lRdW1MdFgvQjZLSmFteUw5?=
 =?utf-8?B?TldhMzFWeWlTUGJiQ01xU1l1YXhKRHRYdU94T1U2eENhcWJKQklMVFRib1Ni?=
 =?utf-8?B?QlJLREszM3dac3hyVFR2QWVzcHMrUUdvV0ZuSU8wWUMyTDZiYzUwdytKSTla?=
 =?utf-8?B?YWh5TElqSktxTWFIdXpSam40NkN3UHlJV2VhWkxjQytDK0Uva0NzYzFDY1N4?=
 =?utf-8?B?L0w0WDFkM3QxYWJ5dEtYeERQZEhzV2sxajloVExiTzJUc2VmWVZIKzVnbXht?=
 =?utf-8?B?Z3drcjdPOERlQ3pTeCttSzNHVk9hSEwzVWtFd0VTWlZLb2hVTjY0RDdXbGtj?=
 =?utf-8?B?SytmYkdZWWNSbXBmSnpVNFBwNk9iSmllb3RuZThHazVzZzhIMmtBZ2hadmNO?=
 =?utf-8?B?OXNkOWdxNm9pUU0vZDVPTzZ1SUdtS0N6dWVBUTZ6bDZ4SFJIdnlRdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef93309c-1f84-426f-dce7-08deb56ebba4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:20:33.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I90wMmSz7XeK5pVcXHEZxeEKH6nwYmup3aL9JwFOQpe5iU+n/tk2LxkSdasqyv5Vo++oVQ2OZbhS5afitJqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453
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

Update watchdog device tree nodes to enable dynamic base address
retrieval for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95 and
i.MX952. This allows the bootloader to obtain watchdog base addresses
from the device tree instead of using hardcoded values.

- imx7ulp: Add wdog2 node
- imx8ulp: Mark wdog3 available
- imx91/imx93: Add wdog4 and wdog5 nodes
	       Mark wdog3/wdog4/wdog5 available
- imx943: Add wdog4 node and mark wdog3/wdog4 available
- imx95/imx952: Add wdog4 node and mark wdog3/wdog4 available

Watchdog nodes are marked with "bootph-all" to ensure availability
during early boot stages when init_wdog() occurs.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx7ulp-com-u-boot.dtsi |  2 ++
 arch/arm/dts/imx7ulp-evk-u-boot.dtsi |  6 ++++++
 arch/arm/dts/imx7ulp-u-boot.dtsi     | 17 +++++++++++++++++
 arch/arm/dts/imx8ulp-u-boot.dtsi     |  4 ++++
 arch/arm/dts/imx91-u-boot.dtsi       | 12 ++++++++++++
 arch/arm/dts/imx93-u-boot.dtsi       | 12 ++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi      | 19 +++++++++++++++++++
 arch/arm/dts/imx95-u-boot.dtsi       | 14 ++++++++++++++
 arch/arm/dts/imx952-u-boot.dtsi      | 14 ++++++++++++++
 9 files changed, 100 insertions(+)

diff --git a/arch/arm/dts/imx7ulp-com-u-boot.dtsi b/arch/arm/dts/imx7ulp-com-u-boot.dtsi
index f6d34e1b635..e13bcfe45f4 100644
--- a/arch/arm/dts/imx7ulp-com-u-boot.dtsi
+++ b/arch/arm/dts/imx7ulp-com-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2019 Foundries.io
  */
 
+#include "imx7ulp-u-boot.dtsi"
+
 &iomuxc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx7ulp-evk-u-boot.dtsi b/arch/arm/dts/imx7ulp-evk-u-boot.dtsi
new file mode 100644
index 00000000000..1944a024ecc
--- /dev/null
+++ b/arch/arm/dts/imx7ulp-evk-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx7ulp-u-boot.dtsi"
diff --git a/arch/arm/dts/imx7ulp-u-boot.dtsi b/arch/arm/dts/imx7ulp-u-boot.dtsi
new file mode 100644
index 00000000000..88cb5716a29
--- /dev/null
+++ b/arch/arm/dts/imx7ulp-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+&ahbbridge0 {
+	wdog2: watchdog@40430000 {
+		compatible = "fsl,imx7ulp-wdt";
+		reg = <0x40430000 0x10000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&pcc2 IMX7ULP_CLK_WDG2>;
+		assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG2>;
+		assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
+		timeout-sec = <40>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/dts/imx8ulp-u-boot.dtsi b/arch/arm/dts/imx8ulp-u-boot.dtsi
index 30baaeff8ef..54ecbcf1795 100644
--- a/arch/arm/dts/imx8ulp-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-u-boot.dtsi
@@ -61,3 +61,7 @@
 	};
 };
 #endif
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx91-u-boot.dtsi b/arch/arm/dts/imx91-u-boot.dtsi
index 5b639c965d6..149f7bc685a 100644
--- a/arch/arm/dts/imx91-u-boot.dtsi
+++ b/arch/arm/dts/imx91-u-boot.dtsi
@@ -90,3 +90,15 @@
 		};
 	};
 };
+
+&wdog3 {
+	bootph-all;
+};
+
+&wdog4 {
+	bootph-all;
+};
+
+&wdog5 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index dc86746ac90..a84cdf2bc45 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -96,3 +96,15 @@
 			       0x000001b2 0x800001b6>;
 	#thermal-sensor-cells = <1>;
 };
+
+&wdog3 {
+	bootph-all;
+};
+
+&wdog4 {
+	bootph-all;
+};
+
+&wdog5 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 8a7a6f11158..74481aeefb5 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -159,6 +159,21 @@
 	};
 };
 
+&aips4 {
+	bootph-all;
+
+	wdog4: watchdog@49230000 {
+		compatible = "fsl,imx94-wdt", "fsl,imx93-wdt";
+		reg = <0x49230000 0x10000>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		fsl,ext-reset-output;
+		status = "disabled";
+		bootph-all;
+	};
+};
+
 &clk_ext1 {
 	bootph-all;
 };
@@ -442,3 +457,7 @@
 &sram0 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 6dec159752b..cc67f09ed97 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -138,6 +138,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@424a0000 {
+		compatible = "fsl,imx93-wdt";
+		reg = <0x424a0000 0x10000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
+		bootph-all;
+	};
 };
 
 &aips3 {
@@ -238,3 +248,7 @@
 &scmi_buf1 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
index e977014992e..28f47244356 100644
--- a/arch/arm/dts/imx952-u-boot.dtsi
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -115,6 +115,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@420c0000 {
+		compatible = "fsl,imx93-wdt";
+		reg = <0x420c0000 0x10000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
+		bootph-all;
+	};
 };
 
 &aips3 {
@@ -237,6 +247,10 @@
 	bootph-pre-ram;
 };
 
+&wdog3 {
+	bootph-all;
+};
+
 &scmi_iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;

-- 
2.34.1

