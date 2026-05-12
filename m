Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391ECCD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3478468E;
	Tue, 12 May 2026 06:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GCBRfgzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D889F8464D; Tue, 12 May 2026 05:09:34 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D235983CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzH58DtHT3qgOavQpM8HbgJ+XwtcbDnUgP9KAA6uaehnHCro8EJA7hj+pQx+X0krYU1l7qgjL9ZxeXOA39tMyvF3z590zRei59MKB+V0O1ieXk0CjLBpubayUktGORbvuzt4YlzfUges89+iVaxu/WTjwkgducbbkqpJgexl6LlQ+yOg5Jd9wg+OT6MUQg3/TJZ55z9yGoyNPYNJPQP2qI5yJvqxpLxOQyxLkE02bR/YufsaWF7W3VUJ4H8lP2blEylMNIAxYpgrJMbGWBuMDID0Rpv9a6mZoBV0OrCjkY6EcYXjM1bhVsDuQDmN/etcrogVXD2JRjk/1WOhLYAnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWenSontpWSznu2C40UskZHZzfLiWaK4KUR1Qiew4P8=;
 b=CoUiDbutYvrmNSV3cExZDhx3t0Yk2fBibEAAmtizlVkQMqqD7qLisRGtpRro7h22V832tqFgOpk2xbiG4Lo7Wc7mhWM0XLqFHpk92hnbfHOxGPkXqGL08tXm2ryho4RB6cLGC/VZpHY/p7IyeEDQfmwm5TXNEUhWLVjTuPsfWyFnI9GO5LgFnXzyKVmu/boze11DthAixTcOk1Xd2aX6kLUL9Jv7nGdNQAYn7oWes13JDHAgQSnkxEe0cx6/QtZu0gfr7RoC0YHKsZXR2UAWFNjjFKEZ1F6LHDj/A2cNDiOeYt3NehT6t+0UhCpd1lXCzF96OLHjvPP43cIKVHq1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWenSontpWSznu2C40UskZHZzfLiWaK4KUR1Qiew4P8=;
 b=GCBRfgzwKe3yPc/td6GSF3wDYyLVqPb8TpRdNVZmrtRV+JhYTtNIEMr6Gyn2FXjLxwj39rZikZsuiRXweKMhAVGJaDeEu1S9pC8511Rd8hjIXBgnYFx6Apxlfr3GESz0Q5peaxV3JXO3cHuz05DrSoVtBb9HR9YrhQ3CW6GJ675ZH8QPsTd1gtYY3L6DSBFNYNQN+6/+pakgyWd+quN7MHr0LxlvNtIhG4wgQou/aI3tEOetn4jL7EpU3EIPadZeSxEgSdjUsdh8a4mtZVJXbNiqfvu++5NEuXXJuArU7TkOkczqbF1TrBIqjJlfkS0Hc6ysIiBHo5H8DAro1O7gkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:09:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:09:26 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 12 May 2026 11:10:15 +0800
Subject: [PATCH v3 8/9] arm: dts: imx: Enable watchdog driver model support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-wdt-v1-8-0b9e1993557b@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d06bb3af-aac4-42ef-67a9-08deafd3e014
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|22082099003|18002099003|56012099003|3023799003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: HqO5q3ZYWbAorHGQHIpf+THNhll8dye9/nbeJZ052s0c3pk+GMLoTsjbwJ4aQ1nj0Ghxn1TDmrBF2JbA1Ge9KWtMnpGjp9klTBPSOyT1Xx+DZ4tBlT/AqHSwHYAmir9gRTgHN1OzEYwS/pQyIulo0Je2BEnN7f2XL5WbpZVrxkkmjpHSAwSWeXlOkz2GIsm2qi3FFYr2yeKvHvc1IQyWZ4TNCVVB4rOQ7V2JS1ShXfBudKgKIxKaOCUhAr0e9JuOyfgKaP94ijVX+RgPQEyfWDwvDSVk/ITstbKrwfVh4YMeIunIka4DNbIiVxvqr7bBwzOVVUHuLzfvPOnFIJrPOFrw3Qfdtns7cYM7pXfCci330WqTZtDPfxZInTWkR31j4FgmcC2KnIXqh//DZUd9ZfAa/E63isRgGdAfYnP0PDYk+Cmkn/mKsfGsehVAKSsC9UoQ3XwYR7CegrVt6+cTQQuSSDn2kCELTTZcRbd4VfA++wX4vxuCavWVNxwk2cG9TAfwfY0qZczaWalTBbB9Jgfur1RR/BlIUs0yI4ARF9Tlq30/74KJz6pI9dAcYtEXftAxX9E8jxGibH8jpB2oViLY3150No6/ouyrIwDixdphOV+ILu14y35H5vtg0joivbxtpi3QzR6+DuOBkKeqJPJtRYwFuJDG4K0KftVAqhMgHyyX4Ncbgm0tUBNQfuKD+HPQGwlG3m6nrr4AUd7kO2Aok8d9oxrGN/WM65QD2uTGxb069wfjShFcOsPIhjfp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0U0cG9aS29mWnp5ck9zeGlSakx3Y3F6TERWSlJFY1B0MTZPRE9iUmJTUThy?=
 =?utf-8?B?alF0YkRGNXpWeWRFUjhHUmhkUDFmZEZzSko0b2tFQUFWUktnazNHdG4rZzRI?=
 =?utf-8?B?Z29WMXZPUHE2MktDOFhZSlAzNytQTFFhcEVCMVhKcEVjRVc1aVRqWnAwQUs4?=
 =?utf-8?B?V3ZVVkwrZ2FVRjhKbW1lVjkwb25vL1NMZFR6eG1IVHA5K2Fnam1RWTlJaXBt?=
 =?utf-8?B?cmphd1dPU3BwY3dycTZseksrZHNYc2kybWV4dDFQNXJoZlBvNW91UmZOck81?=
 =?utf-8?B?cXVlNFdCM0daeTRUdHhwbDJzVDRNMlh0bWc2QU44Vy9JclJMRWs4aDJoWlA4?=
 =?utf-8?B?SitHWDFLeWJGbUtUaTJuK2RXMnYxSnY2bW96U3ovSmM3N0RhQ0E0N3AvOTdr?=
 =?utf-8?B?bGlLVFJQSFdBeWJRVE5XYmJqdjEwZkszajZPQXdzOHMraHh2Z2I4aWYxeGpS?=
 =?utf-8?B?dkloVTFYWGlsZk9ZeGhKV2o2ZXcwanJnVjkyNHBlRkVCMTlEVzJ6TUsrUTRU?=
 =?utf-8?B?bmo4eE9aelozRVpiLy9VQ0EzZlF1eHNURkx6cCs4TU5ZYzdua3ZQalREV0dO?=
 =?utf-8?B?UjlOeDRwOXQxc3FKdkJWcGVUZ24xNzJKRER4Q05GeUwwSWFYTE5oKzVrQ0lh?=
 =?utf-8?B?RENINTFxcTNUTDQ1ZDdWOU1uZTFyZlBVV1JxRXc2L0FYOUk3ajNzcktnUm44?=
 =?utf-8?B?WnhadnQzSm5PMWZwZEF0aXlYRFhuSWJDQkRlRjV4Um41ckcyY2hwRElyTUFk?=
 =?utf-8?B?WCtvTXZvVElMWkZNWjY0TnZVRDJocFVwRVdub0EzdUhGMHdnK2xudU50dGRW?=
 =?utf-8?B?Qk1rKzRpOWdoM3BybmFxUU1Wa2RvVEVGRExHcStQZ1lMS0dQaDRZMm1EaG92?=
 =?utf-8?B?Z3EwTENiWUpZalZUamtURW1GMUh1Sjc2SkVSazJpMFkzV2VjUWU5ZWhLQnNq?=
 =?utf-8?B?cklFdlp3czgzclFrcm1WY2tIREJlL3Z2cXd6VldoVkx0QUJ0eEtPa0lDYjVm?=
 =?utf-8?B?bC9DUFlrdm40OW9vVExSSmsxcVR1MlRJNVJWU290eUpwdEQ1MmJFaUxRTXBx?=
 =?utf-8?B?VlBDZHFGOXF5NER2UGEzbW9DYkE2RWR6eW5YaUduakNhTUxkSm5aMFpKU3RX?=
 =?utf-8?B?VFpEcEJ1S2F6Ky9JbnZDT3lobFdaeUxVdDlIMXdVclR3RTZydzFucmowTWV3?=
 =?utf-8?B?ajFWNElMNU9zTS9HakVmVnU4WlN5ZHNlbGtaaDhFR0ZmYUZWTU1uSXBSWFU3?=
 =?utf-8?B?bTU0TUdLRm1wNm90dW1IVSs4MFdVeXhYalEvK1VvUzBwNVpkTDE3R3VTbzBq?=
 =?utf-8?B?cmIvU1c3VEtGZFpocmpMWFV2UElwRnB2Vm9CSm5pblQwYjV6Qk9rZCtycW84?=
 =?utf-8?B?R0E5Z0Z6ZW55aDVLZUh6YzRvY3hTWlRTTm9mOGdHZVUrelVLUUZIYVU2ZnJ1?=
 =?utf-8?B?bVF1a2dSWjJFM1IvdzdvN2RqbEp6ZUdybVU3WTdVZk80R1Nxb0thdUc0LzB6?=
 =?utf-8?B?d3F6NCsvQjlpSzduR2NORmZrOXBLM0d3VG1hWWZEdjZHbGEvSUx0MmhYSHh1?=
 =?utf-8?B?RW9RdmwrdFRWSWRPSXNTOEhyS05MQVBzY1AvdXhjQ1c2RGJFVkhPWmpkWERP?=
 =?utf-8?B?ZUdLNFlMMHhWczREM2kyS0JzeWNydFRBUmUzSjZjcEpDMFlDSWVvbzdVdjlC?=
 =?utf-8?B?dlFCTmpaRi9jS3F5T0JFL3J1MVdIVkdEZG1KTVlKa2QwL1BZSlYwNzJXek1u?=
 =?utf-8?B?aGh1cVlFS1ZtbklLdkhYMHgvTkRmbFhOb0lGNWpRSzNUNk5HamFpOUc1TkVt?=
 =?utf-8?B?Wnl2eTUrQjJ6TVdQcmE0SmpaUzNkV1gwdVowZlJnbGRUd2pBYUp1WnZQSm9Y?=
 =?utf-8?B?ZjVEWWNBVUo1T0ltVzdLV0JzVDNrUXpUTVBReWdJbmRPRjlGNG9seXZuU1I1?=
 =?utf-8?B?eWl6K25FaGxBWTN2TDdEZkNlOEp2NlIwZElNTER2K2FIYzBxRXQzWWlkYkFP?=
 =?utf-8?B?bFl0WWdQOTNBdFZXb3VLNTE3S0lxTzFpazgyY3dpV0MxWGxvcWVid2NNT3hI?=
 =?utf-8?B?RnlJc2pXUnBnOGJtM21wOWM0c1BHWDdEYkdNYmlTamliUDkrUEJBYVQ0N2U3?=
 =?utf-8?B?bmlxd0QzRjRRcWpOUlVycUZqa3AxOHk4RHh2eC9XYnJPcWExMEdDVkI4aVYr?=
 =?utf-8?B?K2s2WGVYS0IzcUtJRzZ2TU1PTWJ0UnMzYXZhR3pOaFhIUTVYb1pRRytCazJp?=
 =?utf-8?B?aC9pM3dYUGdCd3Fja28vZi9maTV5TjBwSVNTNDZ3RnhkeEtDZVg0QW9LTm82?=
 =?utf-8?B?RjZrU3pYa2xFaWM0cjR1b21oYThQcG9WNzNhNkZQbjE3S0QzMkxtZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06bb3af-aac4-42ef-67a9-08deafd3e014
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:09:26.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJQ3pFVIc4zG1nrbsNdOsj86N80DXZqOQaltVvY5a6BKeUDpLJ4/6Wicvi+KYM89XzTZsWP3wRhxnGorhzu15Q==
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

Enable CONFIG_WDT for boards using ULP watchdog to allow reset_cpu() to
use watchdog driver model instead of hardcoded base addresses.

Remove wdog3 status = "disabled" overrides from U-Boot device tree
overlays, as the watchdog device needs to be accessible for driver
model based reset functionality.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi             | 4 ----
 arch/arm/dts/imx943-evk-u-boot.dtsi              | 4 ----
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi         | 4 ----
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi         | 4 ----
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 4 ----
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   | 4 ----
 configs/imx8ulp_evk_defconfig                    | 1 +
 configs/imx93-phycore_defconfig                  | 1 +
 configs/imx943_evk_defconfig                     | 1 +
 configs/imx95_15x15_evk_defconfig                | 1 +
 configs/imx95_evk.config                         | 1 +
 configs/mx7ulp_com_defconfig                     | 1 +
 configs/toradex-smarc-imx95_defconfig            | 1 +
 configs/verdin-imx95_defconfig                   | 1 +
 14 files changed, 8 insertions(+), 24 deletions(-)

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

-- 
2.34.1

