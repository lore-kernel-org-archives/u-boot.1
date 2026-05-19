Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6FCCD5BA4
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B1B8470E;
	Tue, 19 May 2026 14:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jhyR//j/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BF88465A; Tue, 19 May 2026 08:20:28 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0040F84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEUxc8jazrM27dq/dNGrMSjOXxt8tNXmn97GHOnWG6vq1pYn5fq5gRtbN18HTNlks4Df6s/HjctvYlFARR9IPvZyUffkzWew99ECFa4JQrgoHduGtNZQHFS2wg7tsyMEUWmYMWq86NmE+2GNjNW0gEXwOMOBu8bywVBEwkV6qlGLNOdHwBY0/nb9LVtyi+nzw8SOXB771YeMeJSmd4jEYRa4CRwn4VAv3ZDoDZqs+dbaLWuyFjyuFmomETPdoB/n9uQI2H0ZTKcJiurZa0qF2omPRP1PntJiksyWjUzSuRjRjqze7dH8+GGHfUNu9DmQ5I/6Dr5iBlPOG8k8aHXUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMZ962iyUiUKRa5jqrwFqsaeChBuZ33QNeapdElxJYk=;
 b=pR/M7spM1gIKBzgxmtdsyu3pxMXZC0uCk9I/DTXb0yIvs8qJYH/0D6cwMjfEZ0t5bsdloLjvjrTr+0cccomR1E1+EITv34NpCfqqEKucBm9ctNQgLGF1BkhKHg+/LQ9ShLxSW9sUqi50sbcGr+HUzFIJYQkFroTU9M8TluIDTD112vr85ej6Y78FQpStUrPckXghgr/dTj374JtTyaslkmNWyaja6EAnZdFjnt9CpHIY4rQabR89DXsB54NhIw+Q1Zp7+Bf/dghTyy9UvgiTiHt8huQeXkpYx5fnRk3UT2uX1tSJyvUoz0pxJqgQKrf6RaJpJfG5TrzZsX6qSua97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMZ962iyUiUKRa5jqrwFqsaeChBuZ33QNeapdElxJYk=;
 b=jhyR//j/dB6CtfPIMS7Urc37lFlRtcou3BCwG3rrW8Q5Mbdyo8ZpooD4e0axOSokBaz72NYd00KGrvulGmTO5+eo6x5ENZ2LU7qKDTHL4qoxBirRZxnV6gNB+usspow3hhhGQpmGLAUFtHhmSog7+7S06VVbVNrZfUbFtew5ON885o4oryxsD9kZAWXlc3r59z6tvDMCSjUCpLdPHaD/XTgLD50d1bFcsGHRi7cljcyjb92D+dbaeNuaWG9MBeTxLmPSaBK2vPWiMvijJfUKndMYrytTqOteQ5BTbQ+cNhNZNvgKROoKCNXgafXWwLCIrhdZptWEoWspjXYuUN+hvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:20:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:20:21 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 19 May 2026 14:22:04 +0800
Subject: [PATCH v4 4/8] imx93_var_som: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-wdtv4-v1-4-deef133b81cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 582de986-8858-4ece-0adf-08deb56eb446
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|22082099003|18002099003|56012099003|38350700014|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: 96lrWiB6CYIy3drzwh0/yDa+fYBSSELGjEFbLS6qfDA8Xal4Xm2g/zupa1wigR9DuTsUnRm61+fRPCRndCkMPnWb+IfF8LaGBjqJva/n0O7VC12O4hkv0LXmEOAkHRXUDKCVlAEAxxAE62DNgS1AJWiZfg5fpcTawKg0KB1aIAlLhEIlMyjkvsaTJJc8eNKc8DV8/pfsRkf6LukMpQaILaq437BagfdfZj64jVFjJnjrI1rJMtOCO8MPqZmC/XZ+PSWNeGCGWOeDIhSlBwFTI6/Ji7hVIHwnJfBIRsUy/NR5aQIvFRm6EU9rK4itBPokZsTauc2B7r9G5zZ0lO/Jf4vgnLeKVNfedCcNJzhHlGyUEye3H8/fU1zQyvb4MQmtVq/owUQKrRd/PCKsKgTyngwGQoc1Cm0L47GDU/ons4ebm+mm1PzevMeAroHzNhPO+29PrmLWTxF5wKDcqc1b9YT40GnSgpyyQREz9qKaHRROBA7kbRkkRMQWd9zV/7IrugTqDmon1bP0oxck4KK5G00eR1n11B79wze9QUTrm2N0Hk3hjPEgiMTqTNkawRr3ynb6LAZJ+01Q6NKt5fbkmc6mHWRK4BniuWf0lSsTee8/EDofNWYQ41zpYu8RK+nfgmBox9+kBLjDKe8tR1JOlLpIWeQtycZJKDA5VhvrxVhcTfpVDta0Tz56p+yUG58WHl/uXX1nBIAj90w1OpH0NvEf+GFoXkAKt4HfGlKytJnqh0wYjHF6pQTXFS3yzd4o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNxanVqbUtvTDNRMUp1SGpIOVFVcmxBenMzMHA2cjBiY0RrRzRFeU8xVFVB?=
 =?utf-8?B?NGo0dXJScDlBWXJ6Z3RHU3hCZHhoRnlVeUUycFNkVklwRFQ4SE9XYlU1NndW?=
 =?utf-8?B?bVZRTFhRQkM1THNqaktqaHJpNHV6MFRsQTVPRWh3VVVSTVV4UC9GSHdyWTVy?=
 =?utf-8?B?ZmJ3WkIxMmh3bWx4NlpWVysxWG9FWm83azNndmUyY1oyZEVRREFjUVJ3TkZT?=
 =?utf-8?B?VGMyMlI4NDZPcHdRVDJLclRzMWFwWEZDTmRtaWRHb0FnbUp5d2l3dXRnMUNy?=
 =?utf-8?B?ZVdqVjhwT2ZtU2E3cFlqcm95VjlYRmxSdnA3dU9mTk0vUnRNZmFMdGJUQk16?=
 =?utf-8?B?M2o3UUU3anVmZWFHODlzbkR1TmJwcEFjMkZYQ2JGWGtwYlpKeWUwbU1vMThW?=
 =?utf-8?B?MXVkNFlJZThIb20reHB0am51QmVlR0dNNkVhUTZWQUVEcXlkOHJ5RFBnMW5E?=
 =?utf-8?B?NHlmQlVMRHVHNHp2Q2xVcmxLZy9XcFFwK256aUtVaDhPa21sSDhJSUJmUVkv?=
 =?utf-8?B?WjNDY1FzT21BK2pmK042cHF6M084UHYyUmdpSkVma0ZMN2MvNE14L0x5Rk9X?=
 =?utf-8?B?SzBoZnVMeGZMbUx3L2RWOTZKRkVxUFpPMEZMakFzMU1ZMmdwd2ZmTTRlcmk3?=
 =?utf-8?B?bzM0M3BScDVTRnp5VjNkOS9OeFdTVTRQRWlKRDlaMW5GTTBQeTh6TERxaCtX?=
 =?utf-8?B?czdpMDlseFhCRXg2YksrellWL1l2YXg3VWVMTm16ekhHb29wN2ZVUGVwYmJr?=
 =?utf-8?B?QWRmM3duNzVCUWc2bXZmMkd2TWQveFI0ZlhHelFXdkdVaUJWaXNNM2JSWFlX?=
 =?utf-8?B?VWU2cEV5RXpUL0hMN3BpRlhqa0d2MFJwMS9uUVN5OHJ3K1Frc3BydElGbEZT?=
 =?utf-8?B?Mjg1RmYrQitGRWIxdVU4Q1E0WDNyTjlEMGtzLzZQS1BiOUVyeHU1VTJIb2Y2?=
 =?utf-8?B?UmUvVnlpNGFCRUQxelFsbXp0T01tYWJKQnlaZFp5b3hlM2xPNU1KZmdSVUU1?=
 =?utf-8?B?RE1JQmVSSnAzZkdZS0tsV04yVGZIZWk2Ny93cXhqTUZ3eTRjQ0UzWHp1a2Vo?=
 =?utf-8?B?UENtOWZZZHMvTVpiK3RqWGJTTFlDTldDVFV1K2pEUXBUYmJ6cWMzanpybXdu?=
 =?utf-8?B?aCtIRE9UWjBhZUZqRFVVZU9nSksvc3ZNeEJtQ3AyQjhneloycjNreFRtQ0xN?=
 =?utf-8?B?anVSV3Z3QmpjUy84b1RlYUlja29CUzBWdHB2Q0RQU2YrSUNUSWVMNWhpVE1q?=
 =?utf-8?B?Y2RTb1IxRVlMUlNlWVBDWkZqcTVERWdLd2JJY3orNTFCNngwcm1JUFNFdGx3?=
 =?utf-8?B?YjJUOEdjcTFKb205U2ZMOW83NU1jU2hTYXgwTktCRUJUNkdITWFLVlhSdldi?=
 =?utf-8?B?cUV5THlxSnJYdFVlZnNQY2ZqeXJEd3dobjNhZ3RzUjhPUHZUcnkwc2lGd1Ja?=
 =?utf-8?B?dEs1K1JaNWYxMEgzQWxNbnFFQTNhcURtdno4SWdteGxaSkprMXYxelEvejJi?=
 =?utf-8?B?c0VJd0s2NzBxUm43RWVqQThDTEdTalRpMUxXc3haeCtaaGVRZFFWVW1qR3Ja?=
 =?utf-8?B?VkpnYmJJMUQydzZLQmtBblJWVHA2SVhHV1BFVnJ2OVVVbWpHVTA5UForS2xw?=
 =?utf-8?B?RnZUajN6WDNmOG40VXNwaFFOWjF4cVVxVzc5V3RqNTFDMnFEbzJwSFFiRWRN?=
 =?utf-8?B?amJaV0xWL3RkR0RLL3lScjhCSDYzcFFHUVh5TzdxcTQyMWNRcS9seTJUUDk2?=
 =?utf-8?B?d2h0bWM2WXRXR04rVUcxYnZmQ0p2ajRNM3I0M3Ezb202eDNmTWxxMGE2L2di?=
 =?utf-8?B?THNLQjBnTjJjWlBuZ0pCUS9oN3lJNGZLbXpNRHhHT1B1cXR2T3drQ0VGcDl5?=
 =?utf-8?B?TmJVNnpsNjFIa2xvejlId2w1cTAwVDd5WXVQM2hIQ2EzUUFrM1ZqakVYeWhW?=
 =?utf-8?B?YXZtVy9sMjJleGFlVjFFUnp2WnNtc0hGTFVTa0wxR3J3YitJbE92d2pyRU9P?=
 =?utf-8?B?WUprZnJIUytGNHVoMjEwd3pRUjJwK1VkWDh2ZnZSUEJ6YVFyR2FPcUJHMUpY?=
 =?utf-8?B?VkZyWjJscmtWSlZYR0YzRm1LR21xeVFqMFBFWEZVYjBkWW1FUUMrNDh5Tk9l?=
 =?utf-8?B?MWRSSFZZbERWdm9kZTI3SUJaa3Q2c0pnMlNWUXFxaExlTkMzMUNNbk1xdFNZ?=
 =?utf-8?B?cW9LR002VTRaSnN5aWM1d3dGUERsZm52V0JQUCsrTFJNY3dRNzQ5UWRQMERx?=
 =?utf-8?B?SldXc3JrOTZOMnAya09CRFc2RGhGMG5EYS93NFdFQVNMOWY0ZVd5WlUxOHE2?=
 =?utf-8?B?T2l1MkNiZy8rOTA0dFl2L0VyendHaXlTYlIxcGNEKy9ONTFiVHQzdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582de986-8858-4ece-0adf-08deb56eb446
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:20:21.0957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+apvuzDRx3K+nzvAtZe9bpqZ6GyCDZdFoxObfXrsMgvonq8SDZjFv6GOlwZOvlS1EfhJvRBMinqUpkatN94DQ==
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

Enable OF_UPSTREAM and remove local device tree files in favor of
upstream device trees from Linux kernel.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/Makefile                   |   3 -
 arch/arm/dts/imx93-var-som-symphony.dts | 323 ------------
 arch/arm/dts/imx93-var-som.dtsi         | 111 ----
 arch/arm/dts/imx93.dtsi                 | 906 --------------------------------
 arch/arm/mach-imx/imx9/Kconfig          |   1 +
 configs/imx93_var_som_defconfig         |   2 +-
 6 files changed, 2 insertions(+), 1344 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6dda2d2f807..283e0fcbff8 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -888,9 +888,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-kontron-pitx-imx8m.dtb \
 	imx8mq-librem5-r4.dtb
 
-dtb-$(CONFIG_ARCH_IMX9) += \
-	imx93-var-som-symphony.dtb
-
 dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-evk.dtb \
 	imxrt1170-evk.dtb \
 
diff --git a/arch/arm/dts/imx93-var-som-symphony.dts b/arch/arm/dts/imx93-var-som-symphony.dts
deleted file mode 100644
index 1bc61942716..00000000000
--- a/arch/arm/dts/imx93-var-som-symphony.dts
+++ /dev/null
@@ -1,323 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2021 NXP
- * Copyright 2023 Variscite Ltd.
- */
-
-/dts-v1/;
-
-#include "imx93-var-som.dtsi"
-
-/{
-	model = "Variscite VAR-SOM-MX93 on Symphony evaluation board";
-	compatible = "variscite,var-som-mx93-symphony",
-		     "variscite,var-som-mx93", "fsl,imx93";
-
-	aliases {
-		ethernet0 = &eqos;
-		ethernet1 = &fec;
-	};
-
-	chosen {
-		stdout-path = &lpuart1;
-	};
-
-	/*
-	 * Needed only for Symphony <= v1.5
-	 */
-	reg_fec_phy: regulator-fec-phy {
-		compatible = "regulator-fixed";
-		regulator-name = "fec-phy";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-enable-ramp-delay = <20000>;
-		gpio = <&pca9534 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 18 GPIO_ACTIVE_HIGH>;
-		off-on-delay-us = <20000>;
-		enable-active-high;
-	};
-
-	reg_vref_1v8: regulator-adc-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		ethosu_mem: ethosu-region@88000000 {
-			compatible = "shared-dma-pool";
-			reusable;
-			reg = <0x0 0x88000000 0x0 0x8000000>;
-		};
-
-		vdev0vring0: vdev0vring0@87ee0000 {
-			reg = <0 0x87ee0000 0 0x8000>;
-			no-map;
-		};
-
-		vdev0vring1: vdev0vring1@87ee8000 {
-			reg = <0 0x87ee8000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring0: vdev1vring0@87ef0000 {
-			reg = <0 0x87ef0000 0 0x8000>;
-			no-map;
-		};
-
-		vdev1vring1: vdev1vring1@87ef8000 {
-			reg = <0 0x87ef8000 0 0x8000>;
-			no-map;
-		};
-
-		rsc_table: rsc-table@2021f000 {
-			reg = <0 0x2021f000 0 0x1000>;
-			no-map;
-		};
-
-		vdevbuffer: vdevbuffer@87f00000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0x87f00000 0 0x100000>;
-			no-map;
-		};
-
-		ele_reserved: ele-reserved@87de0000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0x87de0000 0 0x100000>;
-			no-map;
-		};
-	};
-};
-
-/* Use external instead of internal RTC*/
-&bbnsm_rtc {
-	status = "disabled";
-};
-
-&eqos {
-	mdio {
-		ethphy1: ethernet-phy@5 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <5>;
-			qca,disable-smarteee;
-			eee-broken-1000t;
-			reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <20000>;
-			vddio-supply = <&vddio1>;
-
-			vddio1: vddio-regulator {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy1>;
-	phy-supply = <&reg_fec_phy>;
-	status = "okay";
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
-			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
-			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
-			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
-			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
-			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x5fe
-			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX93_PAD_PDM_CLK__CAN1_TX                       0x139e
-			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX               0x139e
-		>;
-	};
-
-	pinctrl_lpi2c1: lpi2c1grp {
-		fsl,pins = <
-			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
-			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c1_gpio: lpi2c1gpiogrp {
-		fsl,pins = <
-			MX93_PAD_I2C1_SCL__GPIO1_IO00			0x31e
-			MX93_PAD_I2C1_SDA__GPIO1_IO01			0x31e
-		>;
-	};
-
-	pinctrl_lpi2c5: lpi2c5grp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
-			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO23__GPIO2_IO23			0x31e
-			MX93_PAD_GPIO_IO22__GPIO2_IO22			0x31e
-		>;
-	};
-
-	pinctrl_pca9534: pca9534grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX93_PAD_GPIO_IO18__GPIO2_IO18		0x31e
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x13fe
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
-		>;
-	};
-};
-
-&lpi2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c1>;
-	pinctrl-1 = <&pinctrl_lpi2c1_gpio>;
-	pinctrl-2 = <&pinctrl_lpi2c1_gpio>;
-	scl-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-
-	/* DS1337 RTC module */
-	rtc@68 {
-		compatible = "dallas,ds1337";
-		reg = <0x68>;
-	};
-};
-
-&lpi2c5 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep", "gpio";
-	pinctrl-0 = <&pinctrl_lpi2c5>;
-	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
-	pinctrl-2 = <&pinctrl_lpi2c5_gpio>;
-	scl-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-
-	pca9534: gpio@20 {
-		compatible = "nxp,pca9534";
-		reg = <0x20>;
-		gpio-controller;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pca9534>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
-		#gpio-cells = <2>;
-		wakeup-source;
-	};
-};
-
-/* Console */
-&lpuart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	clocks = <&clk IMX93_CLK_LPUART1_GATE>, <&clk IMX93_CLK_LPUART1_GATE>;
-	clock-names = "ipg", "per";
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	disable-over-current;
-	status = "okay";
-};
-
-/* SD */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-	no-sdio;
-	no-mmc;
-};
-
-/* Watchdog */
-&wdog3 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx93-var-som.dtsi b/arch/arm/dts/imx93-var-som.dtsi
deleted file mode 100644
index 6c77b886666..00000000000
--- a/arch/arm/dts/imx93-var-som.dtsi
+++ /dev/null
@@ -1,111 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- * Copyright 2023 Variscite Ltd.
- */
-
-/dts-v1/;
-
-#include "imx93.dtsi"
-
-/{
-	model = "Variscite VAR-SOM-MX93 module";
-	compatible = "variscite,var-som-mx93", "fsl,imx93";
-
-	mmc_pwrseq: mmc-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		post-power-on-delay-ms = <100>;
-		power-off-delay-us = <10000>;
-		reset-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>,	/* WIFI_RESET */
-			      <&gpio3 7 GPIO_ACTIVE_LOW>;	/* WIFI_PWR_EN */
-	};
-
-	reg_eqos_phy: regulator-eqos-phy {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_eqos_phy>;
-		regulator-name = "eth_phy_pwr";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100000>;
-		regulator-always-on;
-	};
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy0>;
-	phy-supply = <&reg_eqos_phy>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <1000000>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			eee-broken-1000t;
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
-			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
-		>;
-	};
-
-	pinctrl_reg_eqos_phy: regeqosgrp {
-		fsl,pins = <
-			MX93_PAD_UART2_TXD__GPIO1_IO07			0x51e
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x13fe
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
-			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
-		>;
-	};
-};
-
-/* eMMC */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx93.dtsi b/arch/arm/dts/imx93.dtsi
deleted file mode 100644
index d6964714ea0..00000000000
--- a/arch/arm/dts/imx93.dtsi
+++ /dev/null
@@ -1,906 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-#include <dt-bindings/clock/imx93-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/fsl,imx93-power.h>
-#include <dt-bindings/thermal/thermal.h>
-
-#include "imx93-pinfunc.h"
-
-/ {
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		i2c0 = &lpi2c1;
-		i2c1 = &lpi2c2;
-		i2c2 = &lpi2c3;
-		i2c3 = &lpi2c4;
-		i2c4 = &lpi2c5;
-		i2c5 = &lpi2c6;
-		i2c6 = &lpi2c7;
-		i2c7 = &lpi2c8;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		mmc2 = &usdhc3;
-		serial0 = &lpuart1;
-		serial1 = &lpuart2;
-		serial2 = &lpuart3;
-		serial3 = &lpuart4;
-		serial4 = &lpuart5;
-		serial5 = &lpuart6;
-		serial6 = &lpuart7;
-		serial7 = &lpuart8;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		A55_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x0>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-		};
-
-	};
-
-	osc_32k: clock-osc-32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "osc_32k";
-	};
-
-	osc_24m: clock-osc-24m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "osc_24m";
-	};
-
-	clk_ext1: clock-ext1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext1";
-	};
-
-	pmu {
-		compatible = "arm,cortex-a55-pmu";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <24000000>;
-		arm,no-tick-in-suspend;
-		interrupt-parent = <&gic>;
-	};
-
-	gic: interrupt-controller@48000000 {
-		compatible = "arm,gic-v3";
-		reg = <0 0x48000000 0 0x10000>,
-		      <0 0x48040000 0 0xc0000>;
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-	};
-
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	usbphynop1: usbphynop1 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	usbphynop2: usbphynop2 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x80000000>,
-			 <0x28000000 0x0 0x28000000 0x10000000>;
-
-		aips1: bus@44000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x44000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			anomix_ns_gpr: syscon@44210000 {
-				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
-				reg = <0x44210000 0x1000>;
-			};
-
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			system_counter: timer@44290000 {
-				compatible = "nxp,sysctr-timer";
-				reg = <0x44290000 0x30000>;
-				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&osc_24m>;
-				clock-names = "per";
-				nxp,no-divider;
-			};
-
-			tpm1: pwm@44310000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44310000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM1_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm2: pwm@44320000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44320000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM2_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			lpi2c1: i2c@44340000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44340000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c2: i2c@44350000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44350000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi1: spi@44360000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44360000 0x10000>;
-				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi2: spi@44370000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44370000 0x10000>;
-				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44380000 0x1000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART1_GATE>, <&clk IMX93_CLK_LPUART1_GATE>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44390000 0x1000>;
-				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			flexcan1: can@443a0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x443a0000 0x10000>;
-				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_AON>,
-					 <&clk IMX93_CLK_CAN1_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				status = "disabled";
-			};
-
-			iomuxc: pinctrl@443c0000 {
-				compatible = "fsl,imx93-iomuxc";
-				reg = <0x443c0000 0x10000>;
-				status = "okay";
-			};
-
-			bbnsm: bbnsm@44440000 {
-				compatible = "nxp,imx93-bbnsm", "syscon", "simple-mfd";
-				reg = <0x44440000 0x10000>;
-
-				bbnsm_rtc: rtc {
-					compatible = "nxp,imx93-bbnsm-rtc";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				};
-
-				bbnsm_pwrkey: pwrkey {
-					compatible = "nxp,imx93-bbnsm-pwrkey";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-					linux,code = <KEY_POWER>;
-				};
-			};
-
-			clk: clock-controller@44450000 {
-				compatible = "fsl,imx93-ccm";
-				reg = <0x44450000 0x10000>;
-				#clock-cells = <1>;
-				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
-				clock-names = "osc_32k", "osc_24m", "clk_ext1";
-				status = "okay";
-			};
-
-			src: system-controller@44460000 {
-				compatible = "fsl,imx93-src", "syscon";
-				reg = <0x44460000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges;
-
-				mediamix: power-domain@44462400 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44462400 0x400>, <0x44465800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
-						 <&clk IMX93_CLK_MEDIA_APB>;
-				};
-
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-			};
-
-			anatop: anatop@44480000 {
-				compatible = "fsl,imx93-anatop", "syscon";
-				reg = <0x44480000 0x10000>;
-			};
-
-			tmu: tmu@44482000 {
-				compatible = "fsl,imx93-tmu";
-				reg = <0x44482000 0x1000>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-calibration = <0x0000000e 0x800000da
-						       0x00000029 0x800000e9
-						       0x00000056 0x80000102
-						       0x000000a2 0x8000012a
-						       0x00000116 0x80000166
-						       0x00000195 0x800001a7
-						       0x000001b2 0x800001b6>;
-				#thermal-sensor-cells = <1>;
-			};
-
-			adc1: adc@44530000 {
-				compatible = "nxp,imx93-adc";
-				reg = <0x44530000 0x10000>;
-				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ADC1_GATE>;
-				clock-names = "ipg";
-				#io-channel-cells = <1>;
-				status = "disabled";
-			};
-		};
-
-		aips2: bus@42000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			wakeupmix_gpr: syscon@42420000 {
-				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
-				reg = <0x42420000 0x1000>;
-			};
-
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			wdog3: wdog@42490000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x42490000 0x10000>;
-				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
-				timeout-sec = <40>;
-			};
-
-			tpm3: pwm@424e0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424e0000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM3_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm4: pwm@424f0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424f0000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM4_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm5: pwm@42500000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42500000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM5_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm6: pwm@42510000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42510000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM6_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			lpi2c3: i2c@42530000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42530000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c4: i2c@42540000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42540000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi3: spi@42550000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42550000 0x10000>;
-				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi4: spi@42560000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42560000 0x10000>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42570000 0x1000>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42580000 0x1000>;
-				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42590000 0x1000>;
-				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x425a0000 0x1000>;
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			flexcan2: can@425b0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x425b0000 0x10000>;
-				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_CAN2_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN2>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				status = "disabled";
-			};
-
-			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
-				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
-				reg-names = "fspi_base", "fspi_mmap";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_FLEXSPI1_GATE>,
-					 <&clk IMX93_CLK_FLEXSPI1_GATE>;
-				clock-names = "fspi_en", "fspi";
-				assigned-clocks = <&clk IMX93_CLK_FLEXSPI1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				status = "disabled";
-			};
-
-			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42690000 0x1000>;
-				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x426a0000 0x1000>;
-				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpi2c5: i2c@426b0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426b0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c6: i2c@426c0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426c0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c7: i2c@426d0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426d0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpi2c8: i2c@426e0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426e0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi5: spi@426f0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x426f0000 0x10000>;
-				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi6: spi@42700000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42700000 0x10000>;
-				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi7: spi@42710000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42710000 0x10000>;
-				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-			lpspi8: spi@42720000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42720000 0x10000>;
-				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				status = "disabled";
-			};
-
-		};
-
-		aips3: bus@42800000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			usdhc1: mmc@42850000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42850000 0x10000>;
-				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC1_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <8>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
-				status = "disabled";
-			};
-
-			usdhc2: mmc@42860000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42860000 0x10000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC2_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <4>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
-				status = "disabled";
-			};
-
-			eqos: ethernet@428a0000 {
-				compatible = "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
-				reg = <0x428a0000 0x10000>;
-				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "macirq", "eth_wake_irq";
-				clocks = <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER2>,
-					 <&clk IMX93_CLK_ENET>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>;
-				clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER2>,
-						  <&clk IMX93_CLK_ENET>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>;
-				intf_mode = <&wakeupmix_gpr 0x28>;
-				snps,clk-csr = <0>;
-				status = "disabled";
-			};
-
-			fec: ethernet@42890000 {
-				compatible = "fsl,imx93-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
-				reg = <0x42890000 0x10000>;
-				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER1>,
-					 <&clk IMX93_CLK_ENET_REF>,
-					 <&clk IMX93_CLK_ENET_REF_PHY>;
-				clock-names = "ipg", "ahb", "ptp",
-					      "enet_clk_ref", "enet_out";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
-						  <&clk IMX93_CLK_ENET_REF>,
-						  <&clk IMX93_CLK_ENET_REF_PHY>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>, <50000000>;
-				fsl,num-tx-queues = <3>;
-				fsl,num-rx-queues = <3>;
-				status = "disabled";
-			};
-
-			usdhc3: mmc@428b0000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x428b0000 0x10000>;
-				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC3_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				bus-width = <4>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
-				status = "disabled";
-			};
-		};
-
-		gpio2: gpio@43810080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43810080 0x1000>, <0x43810040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
-				 <&clk IMX93_CLK_GPIO2_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 4 30>;
-		};
-
-		gpio3: gpio@43820080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43820080 0x1000>, <0x43820040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
-				 <&clk IMX93_CLK_GPIO3_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
-				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
-		};
-
-		gpio4: gpio@43830080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x43830080 0x1000>, <0x43830040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
-				 <&clk IMX93_CLK_GPIO4_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
-		};
-
-		gpio1: gpio@47400080 {
-			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x47400080 0x1000>, <0x47400040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
-				 <&clk IMX93_CLK_GPIO1_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 92 16>;
-		};
-
-		s4muap: mailbox@47520000 {
-			compatible = "fsl,imx93-mu-s4";
-			reg = <0x47520000 0x10000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tx", "rx";
-			#mbox-cells = <2>;
-		};
-
-		media_blk_ctrl: system-controller@4ac10000 {
-			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
-			reg = <0x4ac10000 0x10000>;
-			power-domains = <&mediamix>;
-			clocks = <&clk IMX93_CLK_MEDIA_APB>,
-				 <&clk IMX93_CLK_MEDIA_AXI>,
-				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
-				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
-				 <&clk IMX93_CLK_CAM_PIX>,
-				 <&clk IMX93_CLK_PXP_GATE>,
-				 <&clk IMX93_CLK_LCDIF_GATE>,
-				 <&clk IMX93_CLK_ISI_GATE>,
-				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
-				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
-			clock-names = "apb", "axi", "nic", "disp", "cam",
-				      "pxp", "lcdif", "isi", "csi", "dsi";
-			#power-domain-cells = <1>;
-			status = "disabled";
-		};
-
-		usbotg1: usb@4c100000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c100000 0x200>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root_clk", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop1>;
-			fsl,usbmisc = <&usbmisc1 0>;
-			status = "disabled";
-		};
-
-		usbmisc1: usbmisc@4c100200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c100200 0x200>;
-			#index-cells = <1>;
-		};
-
-		usbotg2: usb@4c200000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c200000 0x200>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root_clk", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop2>;
-			fsl,usbmisc = <&usbmisc2 0>;
-			status = "disabled";
-		};
-
-		usbmisc2: usbmisc@4c200200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c200200 0x200>;
-			#index-cells = <1>;
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 92cc688cbc7..7fa6d6369e8 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -121,6 +121,7 @@ config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
 	select IMX93
 	select IMX9_LPDDR4X
+	imply OF_UPSTREAM
 
 config TARGET_KONTRON_MX93
 	bool "Kontron OSM-S/BL i.MX93"
diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index da5d473a7d9..26b0623ccdf 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx93-var-som-symphony"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-var-som-symphony"
 CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_IMX93_VAR_SOM=y
 CONFIG_OF_LIBFDT_OVERLAY=y

-- 
2.34.1

