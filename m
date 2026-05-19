Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBC7CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40842847E1;
	Tue, 19 May 2026 14:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O451+fJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F10E8465A; Tue, 19 May 2026 08:21:03 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BBB84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqldrT2TcLzoqnA9UUD6XMLRjOOdlaBQPpE+pl8Lb8i6UWVivWt1vNWYSor8eqXtuJSR7573RBsnPJpzsKZ8FduR7tH49XEKfA3k2Gu3rzux2xfyiR/aEwSZF5iwNHsh9JJe0FQSS6RNVgEnM4pgGwE9e0xNmpzjiAceiDnvHzPs/X/s2jmtYgn7XCiwuN94sbs2EajfO0kQg9igEDO88JN9Tz8YUe7kCmbhC8B0RDlClfn5+Jn0SD3ns8yy8uj4sqLdTfd9jStrJiqH3cLK6HRONIM3ZXuROadaO1mw42w5iHPUCJ0e9al7KszhdIzdeT5hkfnVkMKPf51Iu9heKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wec212yWF9x9KntYFOa5gOuczRIgwdNyD+R0hKztdLM=;
 b=IJa6wBW0LxZYGwN/qezefEq5L6CD3nqNLX392ugM+NAemlkCWXQPm4zAfRfhdF46LzzBWkYjbNarVv+9r1dchUth3S5PL3FHYEn+X0WyzKG9CpQYu9/YCnqFk9HR1COT2Gy6Vol1fJI9ffPIjYE2ajVS1Q7EAu63acZdJQNuCf48J5uNs7Z/R4ID2k+hBBvO8DXW9cJvdMb91RY2GkEQMb2Lgg0aBGWMhXgzykwjAjURg+F9fZq6GlDeecFKuE/ELVbnorPInMNsnAYF5lYVlWHwLE5EohQ8mfslqbJhYToJRVN8CYxNRAsxUs9f9srU8vSxBbOkoqW7mKpJpsFMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wec212yWF9x9KntYFOa5gOuczRIgwdNyD+R0hKztdLM=;
 b=O451+fJ6dFWjombINhQCZ7wGDcImXxm5zE3q3atm2aC9CkY4TO3JrIww4aRoSnMtGDGyFURNsThZN89jC5FcnEujNJEKt6liuCcfUZ5M6xbNKhfN5jeD/oRveXh1PUNqsit/xJLpnLXQFgzwWxGaKwEJhxlTZTlxQHoXhx1o0/ATPANeDLKEPA86VbwKB39X4PT/1wBbocfdRM52p4BYQjbjzevC9kqAKI5mnTPtlbocA3N6Swt/GRQTg1jxHUFcqW/pa54ws3mFlsuNrXA9WtyA25v3+JPN5+kPvacjEI7AwlHhZScxNkvv1HivcvaFBt9e/VGQmdtZUVap2wrN2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10902.eurprd04.prod.outlook.com (2603:10a6:800:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 06:20:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:20:57 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:07 +0800
Subject: [PATCH v4 7/8] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-7-deef133b81cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9353d858-465d-4e2a-548d-08deb56ec9da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|18002099003|22082099003|56012099003|38350700014|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: bCC7egNj/8ftMAiO2/JDgDr8tRSOLhdRguAnT5/sdoSpEmswtD8QFDH751JnCxg+o7aBa9HvJ07wwxqsATxH+Td5lzhAWqhDxpesWQ7u/bxRQ8J1GXDm9fl8NX0tTAbLD2Yl5quRcFep2H8WJBN1lFFq5YTK1sRpBF9rNs1R+aFZM6SiX+o97ZWCtBDb3uu2UWneAankQUyxdujGKEK1Y9W04G3CfdQ3UEbsXthuBHPVZHVmghrpD42yxaLeh1GX6t3b2P51mCDPatt9kxBFmMjX/+QAOeEzEu7bS6jyBqVwQ0jFnv86n6dviNrsdJ6pwPTKp3ox0fP6sM8cdk4YGf4gOV4GgYbFVU/wECmJOSujBz3way8Wl4u8ELFpOp6NAfDWdSnrllpbIZ59IFo3TxB/QGmFHW4l7jUVg2NaQB7K5EswnhTjlQOtS+x0SaV6UVW+G+owoYVn8lwstbx0HxkQlCfTcN2KdrB+y0fZeicaTAxer8r9I3qPl7RVpLq9tZyCj4nzDYjMYVtnxQIdnXD+Tiz3kOM8ZzFP5NZS8XI4GyUVe6UNs4pmS1q4XUXrs02CR/C/ps/kdE5OFtarU1IJMkCFtO5N2HFJI+7jv4aXeTRAeL5Z/3Ef2nVZdlDebpP11ZYVMtiiYpvbWoxjWqCVFO5ht9W0L9MFCQADk+8c73eCjiHYqV5/oiXsgxw+Fo5mCfhGHEzn9rBnfm3Byw0ORc9SACCiiALZ8/RtKtAm8KDcWMvQvNRcgLATuXi8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1Q4bkdLQUhkeGdmUlR0SEFobllyS3hZdjRzdERwL2tka2VDRDVnQzFYQ2th?=
 =?utf-8?B?dTdXVWM3V1pkS3gyUkhLMUhLanNDQ05hZk1iWmt3aWk5c1IxQzdPSldiUzJZ?=
 =?utf-8?B?OTU0c3UwYWRndjV0SDhLSEx5MENXdzFtREFqem5RRGRwVDJ2ZmxzU3JCRG0z?=
 =?utf-8?B?Zm9mYTl6ME50Z2FJUW9TcWo1b041NzZuS2krclNYSkhJblVidUxjUUpWU1cr?=
 =?utf-8?B?TGdTdDd0L0UrcEV3TXJLSGlzQ3ozMFVtU1YybVcxTDF6Q1lHV0EvRDAyYUlp?=
 =?utf-8?B?bWFzOEQ0L1BOWUphV01tLzBML05sdnpZM1pzL3dJSWV2TTIweXNmZFhXWCs2?=
 =?utf-8?B?bnBVbmNlMkJLNjZIbVV1VUdDeUdISDEvOEVEOFd4SFFndkg2RGFmeWQzZlBp?=
 =?utf-8?B?QjU1alpHMXJsVlhveDZvVlBRNUE0cGZGVGdLMENnRlEwZDBpYlNLRGVhbzU5?=
 =?utf-8?B?b1ZiMWttNENPRG9DWFJlQlk3ZkVTbjhtMkk0alN1eWJEOEV2WjAvVUkwQ3My?=
 =?utf-8?B?Qk1DSlUzaDdDb2wvakpMa0JDL1ZaVExNNklhbUVDVitQb1dtVTdzc3lLWk1P?=
 =?utf-8?B?TWY4OS81MnNzRHM5VkU3YmRrVFJ4Zk1Xd21BbE4yRHhwUGQyVmtZRktsamNk?=
 =?utf-8?B?ckVJZkE5Q1U3RUNpclNvdU4vYXRHTU03QXFsQzRaSzJ6ZmhOcVczcjUzZFlC?=
 =?utf-8?B?UDRCeDgwNUh2b2twbTJlL1hueXAweVdCMVNTTWdPdUk4WHozUFVnQVl3MFRt?=
 =?utf-8?B?RzdoeU85NkJxdVE1cWNwb3U2RXNMdFhQYlN5NGdORUxDU1R4bUtLZlpJNEtp?=
 =?utf-8?B?a0psQjN3a3F0QXgvMEo4WFlCcUxZNHlYVTc4OFpwOWZ5Q2xQTDdOZ0VrSFlq?=
 =?utf-8?B?dEt3UnFaV0N6VlFTWEJZakVwZjRLemoxbHdEcjROdGh0ZXVEL0ZPQk90Smgx?=
 =?utf-8?B?clFzcEt2Q1IzUmRRV3p0aXZBUDNFbk9FWHpHSVphTE1FMDVGTTllREV3OTBk?=
 =?utf-8?B?Ym9QczBkSkp0WitMQ0dWK3dyQ2kwMzBSY2wzM1hWSlRGMXJXdFhYUzM3VDNU?=
 =?utf-8?B?ZlB1SjY4cG5tWVJkd3Fzdkd5SlhNaExwLzBOZSt2OUt6ekxodHg4YVdLVHVQ?=
 =?utf-8?B?c3N1OFQvRXlEOXJMeHIyb2tET0hwa00xT29lTkF2dUVhU2dQeCtiYk01b2g5?=
 =?utf-8?B?TEFNRDdDUWVaOU9TZytyWWRKNG1pYWovL0lpRitRYXNYUE9ONnU3akhJdCsv?=
 =?utf-8?B?QWlTR2tjN1Z4bE1SUzUyb3h2KzZWK08waENDdnZEdVVvN3dRM3pDMWxHSmxR?=
 =?utf-8?B?MzlCTGhYQU14VDFwU0w0My90OTNsUFp3ZEQ3RTgrTENqMytub2Z6dFMwMWRC?=
 =?utf-8?B?Vk4xdmc4eXFvZS9XOFo2L2FDT0hZY0doOWorRFlBZWFmSEUxbHVnZk50UGRV?=
 =?utf-8?B?b3VpK0lDVlkvWWdQUHZlSUp0RkVEVUlpMER4R1c4RlVuVGdXdUVrN2czdmc2?=
 =?utf-8?B?ZnpRa1pmM0hnVDNxTnJzZy90MTNNOHNYMnFvS2hLTE0ybThUalhvVDUxK3lw?=
 =?utf-8?B?cGtEZXZYR290akoxWXQySWRUNWVUaDVWL21WZE9URmVmTlFoUk83NFdiRzdr?=
 =?utf-8?B?ZXIzTzZMNDZUZGFmeEozcE1ob2x3MzRHeWhEMGg0Qnk5bWJ5MzlDVzEydHlS?=
 =?utf-8?B?MElLM1FiSzlZemEvcHU3aHFTWFYvbjBUTmJZRFRtbEZWeFAvZUZvdHE5SExS?=
 =?utf-8?B?V08wa3lzTjNIdGpud09QZ3kweUJoMzZpcEt0b09YRXU5UTFscUp1WHZFZCtK?=
 =?utf-8?B?VXVsZndYZnBrTmNHVElYWFJlVWhBeHcvUkxvSzlsamUwTTIvOHp4akJYUlRJ?=
 =?utf-8?B?RVEwQ0NybzFEU291SWxtMmR1eGp1YnRIc0kyMEkzWmM5VE5CeHlFZXZJZ0Nr?=
 =?utf-8?B?RDI3WVNCTlN5b2xDZmI1Y2xyOU92U3hZcEVaa1gwcW9QUkN4YnorM09MR1lC?=
 =?utf-8?B?M1lVVVZUS2VUelp2RjBVVjlOVU9adWE3bW1nM1lNeWZzQlRYdVpVV05FQ0VD?=
 =?utf-8?B?bnNRbDdIL2piQk5YZDBIQmpTNTR6RjBaaSs0aFNDSE4wbXJLRUZpdXNjb05Y?=
 =?utf-8?B?WHdGOWdvMFpSanptUWVwNHB4YjNhc2xObUpqYlBUbGpsKzdUUUZkeWdDU0Vi?=
 =?utf-8?B?a0E0ZEp3VjBmUkNkUStnUlI1Yi8vcjgxUndWVDFYckRVaW5KS1NXbzVZZDFN?=
 =?utf-8?B?SHZyb1pVL2I5VmVEMDBCeE9nYlBPY0JTTzJYbURYWXJnLzhURGRhTnpGNkwr?=
 =?utf-8?B?UE9RZjkvSDU3L2phMUVaZDZBZGhkNW9acUE3c1llTnVLZ1BFRlp1QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9353d858-465d-4e2a-548d-08deb56ec9da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:20:57.2547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzdkcWdLGaiGiyF+Bzh0R9jj9UvPLESW8EEHNjGJ5lr0tbh4YA7Q399DT+QNl03rWx5w0qPo5e0k3ksy3n5Vig==
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

Replace hardcoded WDOG_BASE_ADDR with driver model based dynamic address
lookup from device tree, allowing reset_cpu() to dynamically locate
watchdog devices from device tree.

This change also enables CONFIG_WDT for relevant boards and ensures the
watchdog nodes are available for driver model usage.

- Remove hardcoded WDOG_BASE_ADDR from hw_watchdog_* functions
- Reimplement reset_cpu() using UCLASS_WDT device iteration
- Add ulp_wdt_expire_now() callback for standard WDT interface
- Pass wdog register pointer to hw_watchdog_set_timeout()
- Enable CONFIG_WDT for boards using ULP watchdog
- Remove wdog3 status = "disabled" overrides from U-Boot device tree
  overlays, as the watchdog device needs to be accessible for driver
  model based reset functionality.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex boards
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi             |  4 --
 arch/arm/dts/imx943-evk-u-boot.dtsi              |  4 --
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi         |  4 --
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi         |  4 --
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi |  4 --
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   |  4 --
 configs/imx8ulp_evk_defconfig                    |  1 +
 configs/imx93-phycore_defconfig                  |  1 +
 configs/imx943_evk_defconfig                     |  1 +
 configs/imx95_15x15_evk_defconfig                |  1 +
 configs/imx95_evk.config                         |  1 +
 configs/mx7ulp_com_defconfig                     |  1 +
 configs/toradex-smarc-imx95_defconfig            |  1 +
 configs/verdin-imx95_defconfig                   |  1 +
 drivers/watchdog/ulp_wdog.c                      | 79 +++++++++---------------
 15 files changed, 36 insertions(+), 75 deletions(-)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 860994129ae..ac130b54738 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -26,10 +26,6 @@
 	status = "disabled";
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &per_bridge4 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 247a7ed6838..3b3619d2232 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -153,10 +153,6 @@
 	bootph-pre-ram;
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &xspi1 {
 	bootph-pre-ram;
 	pinctrl-names = "default";
diff --git a/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
index 514dd729be9..34b4073ff35 100644
--- a/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
@@ -44,10 +44,6 @@
 	bootph-pre-ram;
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &pinctrl_uart1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
index 8b59831b7ca..1083d863c4d 100644
--- a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -28,10 +28,6 @@
 	bootph-pre-ram;
 };
 
-&wdog3 {
-	status = "disabled";
-};
-
 &pinctrl_uart1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
index 97ce7402e50..c30e2d6aaee 100644
--- a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -104,7 +104,3 @@
 &usdhc2 {
 	bootph-pre-ram;
 };
-
-&wdog3 {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
index 83802156d52..7d16001baa5 100644
--- a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
@@ -106,7 +106,3 @@
 &usdhc1 {
 	bootph-pre-ram;
 };
-
-&wdog3 {
-	status = "disabled";
-};
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index baa8c1e4695..2101532833e 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -92,3 +92,4 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 0634378149d..f87581d4ddc 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -156,6 +156,7 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
 CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
 CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 # CONFIG_RSA is not set
 # CONFIG_SPL_SHA256 is not set
 CONFIG_LZO=y
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 70265f13bba..b60d39a1fa2 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -151,3 +151,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index e9cd289d31f..3c18956ffe9 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -147,5 +147,6 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 30ad2e60313..743778d9554 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -151,3 +151,4 @@ CONFIG_NXP_FSPI=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
+CONFIG_WDT=y
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index d63168fe886..c9c3f6b5f26 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -63,3 +63,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index caf0718fc13..9363eb5cbb6 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -175,5 +175,6 @@ CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 # CONFIG_SPL_SHA1 is not set
 CONFIG_LZO=y
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index 50515250d17..ea1ebb0c492 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -180,5 +180,6 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_SDP_LOADADDR=0x90400000
 CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
 # CONFIG_SPL_SHA1 is not set
 CONFIG_LZO=y
diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
index 83f19dc0e86..e3a89031c44 100644
--- a/drivers/watchdog/ulp_wdog.c
+++ b/drivers/watchdog/ulp_wdog.c
@@ -7,6 +7,7 @@
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 #include <dm.h>
+#include <linux/delay.h>
 #include <wdt.h>
 
 /*
@@ -51,11 +52,9 @@ struct ulp_wdt_priv {
 #define CLK_RATE_1KHZ			1000
 #define CLK_RATE_32KHZ			125
 
-void hw_watchdog_set_timeout(u16 val)
+void hw_watchdog_set_timeout(struct wdog_regs *wdog, u16 val)
 {
 	/* setting timeout value */
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
 	writel(val, &wdog->toval);
 }
 
@@ -89,7 +88,7 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	while (!(readl(&wdog->cs) & WDGCS_ULK))
 		;
 
-	hw_watchdog_set_timeout(timeout);
+	hw_watchdog_set_timeout(wdog, timeout);
 	writel(0, &wdog->win);
 
 	/* setting 1-kHz clock source, enable counter running, and clear interrupt */
@@ -107,57 +106,20 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	ulp_watchdog_reset(wdog);
 }
 
-void hw_watchdog_reset(void)
-{
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
-	ulp_watchdog_reset(wdog);
-}
-
-void hw_watchdog_init(void)
-{
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
-	ulp_watchdog_init(wdog, CONFIG_WATCHDOG_TIMEOUT_MSECS);
-}
-
-#if !CONFIG_IS_ENABLED(SYSRESET)
+#if !CONFIG_IS_ENABLED(SYSRESET) && CONFIG_IS_ENABLED(WDT)
 void reset_cpu(void)
 {
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-	u32 cmd32 = 0;
-
-	if (readl(&wdog->cs) & WDGCS_CMD32EN) {
-		writel(UNLOCK_WORD, &wdog->cnt);
-		cmd32 = WDGCS_CMD32EN;
-	} else {
-		dmb();
-		__raw_writel(UNLOCK_WORD0, &wdog->cnt);
-		__raw_writel(UNLOCK_WORD1, &wdog->cnt);
-		dmb();
-	}
+	struct udevice *wdt;
 
-	/* Wait WDOG Unlock */
-	while (!(readl(&wdog->cs) & WDGCS_ULK))
-		;
+	for (uclass_first_device(UCLASS_WDT, &wdt);
+	     wdt;
+	     uclass_next_device(&wdt)) {
+		if (!dev_read_enabled(wdt))
+			continue;
 
-	hw_watchdog_set_timeout(5); /* 5ms timeout for general; 40ms timeout for imx93 */
-	writel(0, &wdog->win);
-
-	/* enable counter running */
-	if (IS_ENABLED(CONFIG_ARCH_IMX9))
-		writel((cmd32 | WDGCS_WDGE | (WDG_LPO_CLK << 8) | WDOG_CS_PRES |
-		       WDGCS_INT), &wdog->cs);
-	else
-		writel((cmd32 | WDGCS_WDGE | (WDG_LPO_CLK << 8)), &wdog->cs);
-
-	/* Wait WDOG reconfiguration */
-	while (!(readl(&wdog->cs) & WDGCS_RCS))
-		;
-
-	hw_watchdog_reset();
-
-	while (1);
+		wdt_expire_now(wdt, 0);
+		break;
+	}
 }
 #endif
 
@@ -184,6 +146,20 @@ static int ulp_wdt_reset(struct udevice *dev)
 	return 0;
 }
 
+static int ulp_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	int ret;
+
+	/* 5ms timeout for all others; 40ms timeout for "fsl,imx93-wdt" */
+	ret = ulp_wdt_start(dev, 5, flags);
+	if (ret)
+		return ret;
+
+	mdelay(50);
+
+	return 0;
+}
+
 static int ulp_wdt_probe(struct udevice *dev)
 {
 	struct ulp_wdt_priv *priv = dev_get_priv(dev);
@@ -202,6 +178,7 @@ static int ulp_wdt_probe(struct udevice *dev)
 static const struct wdt_ops ulp_wdt_ops = {
 	.start = ulp_wdt_start,
 	.reset = ulp_wdt_reset,
+	.expire_now = ulp_wdt_expire_now,
 };
 
 static const struct udevice_id ulp_wdt_ids[] = {

-- 
2.34.1

