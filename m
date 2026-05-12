Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBCECD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC04B84676;
	Tue, 12 May 2026 06:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QacHr5ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AA78464D; Tue, 12 May 2026 05:08:57 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA44583CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhNNo/91RutNQBiB0KKJvDAb2zVj6ifFjQslPUiBgy2KVm9IiUkq/KP6sNC/ziyMDXeaFg9FyOHqWk1HMJkdKH8s3oC0DXFuQYzbbeRuipoBS2Fsk+7BRagS1BC2J/Or6m8OLMARPHqxuuiPzmvrPJL2EXWOLPHakk9+6Dx0PxVu7rT9Qb5Sm4vnit0D/rHbu+uL94LxdhSpMo84aQSxO9Kbp4viG656k0L30JtPhbjEJ3C3RqzMUD26qv42zceDTep+NanhBv5VLehvduViPXlg8wl6Qg2O5grSfxq2AIW+AqyUSnMHPswNXTsJf3BV+kMu/bY1WLPxb12cMHoq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfAX1eYdMkG2rbm5uhUz9W7NrWkRw+TfscS3wNw1pjk=;
 b=I2HaJ+M9LHtdRD2ZmQtgEKFsIZ5YI5nbFq6ovZ40GEMmB3Dn1NagdXEm5uYzFpB6PwLALIXnaEqDCSY4GRlIrnEYEXrFjX3QA9L1yuxoUqZPlHVcVdlg4PogCdoukeRJ/MXX70Enw/9TxTKvfkieV1YjQClxK1xR14y2qJ+97g3G8tGAXMViCLXDIZyR2C/jGMQMYmIWp9ol1ji6Q6b5rjwNUFW/EZ3vFoh3yHq8o+JL/4ZyAk5ytfEFM0tiagEzRyqpB7rvLtJjZ3RUnsv7pHaHZnqm6haT/Z5BeSXMHpumtRr7dhWM+hddvYIi8nh0XxAn34nFRieScbzV4H8eVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfAX1eYdMkG2rbm5uhUz9W7NrWkRw+TfscS3wNw1pjk=;
 b=QacHr5iitH50JpeuLwKnDDJ5UtOiurl6s6trm1IhnqPMjs3pmzClyJ+vjakzxagM6X5qbHr3OzflsOXc2lLsRc4lzHblwDp9CRilOxwkbx4RJXz6Tg5kirMJdFa0yePY3H1UT+6XGjRpLe8LF7UWXwWPj4kNxUIIydsLtbnOyUK00e6pUVCcjApa+4le8CErKeqKsAsfmBJg5pGHLd6UN2k2o8sWaduDYjEA352vu8Bg2OGAPVvV3HHKRuwhoIBrA+S4RS0rl6nGoSND4qpM+n9UMvXNTDgqn0FFICQq8tTMXjniwwoc9LBpRMbs9m+gT8K+Jen7xy7vtmW2ZTonzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:08:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:08:51 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 12 May 2026 11:10:12 +0800
Subject: [PATCH v3 5/9] imx: soc: Get watchdog base addresses from device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-wdt-v1-5-0b9e1993557b@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|FRWPR04MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: c89edf66-be8c-47a8-fe0f-08deafd3cb12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|22082099003|18002099003|56012099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: Tc8Bl4D4GTxvbtPlgNInNGmRUpVcXb7BqFWj+VCVXnreeiQ8DfzTJnCrAUOLf63ivXj242jFPF2u/0S9rmk0V1PiJPU1NkyWGI5KPcumMyFhVhBrjLYs+CgGohQELruXvUk6IeQ3qI+kpWVEyvOyNbpnPmlNEJpXypuKh7TgWmEpq0op8AmGEE0RkxhhPQy26v2GcwPgJoCZqOqDDpiCpzUjuJUo69rDLT7gr97p6bHiFvuLp6z0vrx000+m1oX0nS3auBxBSG067Cv9gaj2gGL278/UFGXAqUW84fn1Vdp1ZD6L6YuHAl7m3UWu7obOWuGUbtrZRn297RIHKVArLb5Ktqij4d3ugvgfl0YZzktKdny4hsktFXp3k8RQjOp2N6mpqDW01VABDCdo70VUSsAe7d+znrhTTBdywhiiZHRhYhk1qcHnnkUqf4CiYZmoFmWQRpatKr/FBtO7RxHcb2WcQNdZ5ORrP/hjO8baGtYUETdhARux0OPTpCRGY/s97f0gw35vIKPshEiI2hZgj3nXogxieuuc8uKqRDmKQEKJ/IClzJHesnalLBwLeD/KCC03YN8TIbVAjoSLuEnjOrGZouHfLmN35iTb7ESjVP1wqZy8aT2XZGRQsdErs5roqsvS71NQOwn8B/qhfUtl0zQlMl6iuuFWe6ojRv7agRex5CvjWt6nnpiliq6RAb3XWGzj0GNbC4KTlnSE9vZN9KRgDg1r6TUEaU3ZC5BTGYT3A1cpsOemWXSVjrfABiDA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3E1b2VJdWZSY0w5MFRTaGlIT1l6VVlFT1FjdHBxVGlUSHlWT3pGSlFPeXNP?=
 =?utf-8?B?ODlTYVkwK0Y2OVc5bTA3Sk1yL0o3NDNvYVV4aDQ0UE5XajIxWXFMcW9Tb3pV?=
 =?utf-8?B?ZHZobTNTMWhZZnE2a3ByUG9qN0hEcDFkaE01VU9aRHE0dkhOVmErY0VCV3ly?=
 =?utf-8?B?eVRkdjMrME9jcjFTSnkreXMySnk5UVQxUUZjdysxcS9iZTdKVTBQcHlIUmd1?=
 =?utf-8?B?MCtqQTVkMDlSU1RnU0RWaVNOcUV4TmhGcENIalRUbXgvVkdVdXMxeVcrZWRH?=
 =?utf-8?B?ZjhlcXFvTVRDU2dXZW5HR2czTU5JaXp2TTUybTlPQnRUck1sNkE0N1pOdkNu?=
 =?utf-8?B?dnY1MTYxL1BOa09DY05ISGdQelo4QW16TzJQSm0vWElrbXVNVCtNSy9RaHFM?=
 =?utf-8?B?K1p3WlA4dnloQWJjMlNwVmNxZ2s2aXF0SnVOSFphbzRXNXZBbTEwSlE4M2w5?=
 =?utf-8?B?OGVyZGQyWjZjTGIxTEFtZFpwdmRXL1J6M3JjeFFqOEtkYnZMZkM1aXp3Y2hO?=
 =?utf-8?B?aXRvczdwK0ZOMHVtc3dLd05OVGIvbkZWekJ3ckNsbjhRQTZ6RXZULzZXRGR1?=
 =?utf-8?B?S3R3ZXFZbGY1TmNyc1IyOFRWOFo5U0kzb0lVMUFJQmxwNTk4SjdzSjdibHZx?=
 =?utf-8?B?ZXE0NEpxNm5MMWwvUThRNlp1QWJWWW5TcWE4cFdyNWNxZnBJS2J2c0d6RnJj?=
 =?utf-8?B?dVJFM1l2cG9WbXlSU0dCV1RyMmZOQmlId3BCdTRiKzNWb3J1YzNVTXdvMisv?=
 =?utf-8?B?NUU0RFcyYnErY0dMUzFhK1BRTmhHdm50UTM5cVZWRlJESy9Nbzg4aHBRRHBE?=
 =?utf-8?B?cFdxdGJkVGN4VDdzSEpGR0J6UDMzTHVSeWlhYk1oSWRuUnR2UzNNekQvbWt2?=
 =?utf-8?B?RWp2Rk5zQnM0djNtSVJzTUFWWXpubHJtUm5ublBwaG5mVFhVdThwbVBTOXNu?=
 =?utf-8?B?NThqZDBjVGZXZDc2b2UxWnk0S2VOcmhJQlVYaEtQM2ZVeDFoakQ5aXczQ0tC?=
 =?utf-8?B?bW9VMFZ3VmNUVmNGQUwvNWJnYzdKeEk5cC9VZGZQUzBrZnM5WEd3Q3k2c3V0?=
 =?utf-8?B?aXVCOVUzRUF6Z0hTVzBLNEtNamxrcWtIOWVMd0h4QTE3UG53WHhoODhPbm1x?=
 =?utf-8?B?RU9HN2dWdVdmcUVRRnBlVmhHZW85MXA0SWVndzdybFJlR29XUVRFUXVtRE1P?=
 =?utf-8?B?MmNXM2RhSUJ5cDdFa3FXNFY3c0hySnhYODlhL21WOHRRMmJNdmtCMU9INnZD?=
 =?utf-8?B?K3RXSmRuN1R2ZStvYmFPMzFJRnZJTzBEM01MMm1zWmZYUFI3c0VEZ3BUbngw?=
 =?utf-8?B?TXQwNnRWVitGYjlZQ1JiRllGbUwrYXhjR1I1cTQ3OWJLRHdSVDd6andGUGJD?=
 =?utf-8?B?OVdhMXFna0RreWZCeWtJdVR3Q2twejZIL2IxOWs5K2RlczY2T3E0VGszSFRJ?=
 =?utf-8?B?dmtUT0xWVm9QMi9CY0hrdGo0V3VJL3VZdjJWSlNaL0hOZmFVNG9jVjNmT0Fy?=
 =?utf-8?B?bXlMOWVCQjBuY0Vaai9oVENHRUlFMzJubDVBbzAxOUJETVJNVXBVbW5PbUpI?=
 =?utf-8?B?a21SV0lrZjJZam9mLyt1ZmkzM2JqZVZYeVI3akt5QmJsU1hudm5zaHI4ck54?=
 =?utf-8?B?bDRVN0tUMU9LRzFVMUMybnFmWVNib1BPdWFxMUNacUNVVzZoYzVzeWFxK1c2?=
 =?utf-8?B?eDBpTmNoVVVzbXY1elFEZ3p4UjYrZnVTM2FPZ2plWnVvTzhJekhHQVpJamJw?=
 =?utf-8?B?VXNKUkIyUEJjbWthR3VLRU4yU3drcTExMmhnSHBwV0lvNUc4eFZza0s3OFd3?=
 =?utf-8?B?S1djQWlDMHk0dEUrVVdqRjByZThEa0xsSGR6a1BjSFo2Z0lqSkFRUU1BVkEz?=
 =?utf-8?B?VWVrMVRzcGlRWXBJdmpoU1BZdjRhdUpaS2hZaWNkY00wVlI0bjFPMlNEWWtJ?=
 =?utf-8?B?UU5CS2huR081SlJnUnNVK1hTY08veUJRdGJDRFdzT0UwUmhmdWEwd05VNzh4?=
 =?utf-8?B?ejIyZEhaSk5BRFByK3hxbUZTSUx3Uk54bTRhZytyUTlUTk1LcFdiK0FncUNB?=
 =?utf-8?B?azlnT2lZMDBtOVJGU3p6MXRmWnB6cXczSEU2UmVxUG9SSkVwRDlEeWRFcTQw?=
 =?utf-8?B?cUtMM0VVeEViaEhma0wxSUZGRU1ENVJXUy9FUEZXVGNrb0tiaUY5Z1BLRlFC?=
 =?utf-8?B?ZGEwZ3h2R1djVG1JcHNUbFJBeFRVYnppamtTTUdKNXN4K1RaT0xVcVJmS2ZG?=
 =?utf-8?B?NFhhQ0x5bWg1a3lSaW0reUVNV0NlcVR5ZC9lVGhWQkltM21TelRJWUVmcHlC?=
 =?utf-8?B?eHJ4bXQyVVpxd2lBTFJZTFFuelRQWlhaNG9PdXhJcnRLcFVma01NZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89edf66-be8c-47a8-fe0f-08deafd3cb12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:08:51.4750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig4LBAF8bJ8yVT7iSBKXbaJuNyt/lnelXbD59Kyo8GQgWiv5aWT+nMPlfmZ5pkHoBlSkv30EI2hMwBbyeMoFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11271
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

Replace hardcoded watchdog base addresses with dynamic address lookup
from device tree for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95
and i.MX952.

Move i.MX7ULP watchdog initialization from s_init() to
arch_cpu_init() because ofnode_* APIs depend on FDT, which is not
available during s_init().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c   | 14 +++++++++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c | 15 ++++++++++++---
 arch/arm/mach-imx/imx9/soc.c      | 16 +++++++++++++---
 arch/arm/mach-imx/mx7ulp/soc.c    | 24 ++++++++++++++++++------
 4 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 1ee483065e8..ec85625ea25 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -343,7 +343,19 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_RBASE);
+	ofnode node;
+
+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx8ulp-wdt");
+	     ofnode_valid(node);
+	     node = ofnode_by_compatible(node, "fsl,imx8ulp-wdt")) {
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
index fbee435786c..365891d1d1a 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,9 +786,18 @@ static void gpio_reset(ulong gpio_base)
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		if (!IS_ENABLED(CONFIG_IMX952)) {
-			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		ofnode node;
+
+		for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-wdt");
+		     ofnode_valid(node);
+		     node = ofnode_by_compatible(node, "fsl,imx93-wdt")) {
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
index 44b3e0f5310..edd4ce89911 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -281,9 +281,19 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
+	ofnode node;
+
+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-wdt");
+	     ofnode_valid(node);
+	     node = ofnode_by_compatible(node, "fsl,imx93-wdt")) {
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
index 5306e76223f..d262039ad82 100644
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
@@ -161,8 +165,19 @@ void init_wdog(void)
 	 * In this function, we will disable both WDOG1 and WDOG2,
 	 * and set update bit for both. So that kernel can reconfigure them.
 	 */
-	disable_wdog(WDG1_RBASE);
-	disable_wdog(WDG2_RBASE);
+	ofnode node;
+
+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx7ulp-wdt");
+	     ofnode_valid(node);
+	     node = ofnode_by_compatible(node, "fsl,imx7ulp-wdt")) {
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
@@ -221,9 +236,6 @@ static void init_ldo_mode(void)
 
 void s_init(void)
 {
-	/* Disable wdog */
-	init_wdog();
-
 	/* clock configuration. */
 	clock_init();
 

-- 
2.34.1

