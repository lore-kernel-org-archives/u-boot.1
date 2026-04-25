Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41A0FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE36B843E4;
	Sat, 25 Apr 2026 18:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jDXv2iII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF257843C6; Sat, 25 Apr 2026 18:10:43 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DFC840D8
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by AS8PR04MB9046.eurprd04.prod.outlook.com (2603:10a6:20b:441::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5w8tcdjLwvAYL9iPMBP5ACefDsS4mkK4HGnJ3zhveWw5KLxtg6y0kL2FAu/tgSujkhKZFw+efv8ChNSFAuNy4o0vLC6Sm4mBbwcszJ12XkteSuoQkerFchDWO1vxNI2ho5VbiIKOno2gyT/sADPdoHJI/+TO9I2bkBqaYrlAkm3L/clmxVRk+qPo/z0Xpa9grznhajI4DGHGsjKbEH7qvBxIoGB/SeHdQxSuAewxg0f3tx/R0wlLSepXL85+cAPMMxMHD5CVBzkrQ5+XVRZ53c3tkpSOw+1N5B/SaGJb4bjo2r92xgBVSqekTgGJHj4wuXTIY45lrCfGuyIWR1Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUJh5ve+4geS0rrUON5BgbrFt40Tx3xQDcvdq28ySRQ=;
 b=yZgjny2QUFxR4uVs/PHIiLTNLlupI4wIbYx4/OoGLUue5uTujYgqfJyZFUUXxh59+O5BqVv/KgnoU3w/CskYRoHgbdKRAe1lpvQMLrNIxposA4mSq+oxRzi/MxqCFiwa25fcdh19CZvXa0eLmz1tZOKO/gXKFkjOTbnfhqsfzf8GIamMQ4IjEcQmDaG4JsyM2QZ4t4lKoxGTN0HQALt5jAumd23gJ7DTyCagYnismoZR6QG4JVoT430Rm0uLhSPEYGSXkkXKyFZuvKnXm80MTfsr3P6L0pQWzcCEgy2wHorpIYOELH+jhkpdwzah5mQOmulF726Jn7sBtbw8XJdu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUJh5ve+4geS0rrUON5BgbrFt40Tx3xQDcvdq28ySRQ=;
 b=jDXv2iIItoAbkx4AHUivzG0LFroVMyuDVteT0Deu0ghmrffMi0OUfyIz+IhTUaXqx8PAd6slKQOtaastTb5K3/tioa44reM16fTzkntBqRCgyQgMh7tUk7DG79wZllN9/IrNREqsVZZBR/STpzEvCU5V5Av/4XBAnLLXgPQgSfbqctcYnUwwE+GS4Jxdvi++j5GEok/NaEXuJppqK3UYEpjVj3rZTTAp3svuuw3fqIuqhW86K+HPxlroQR7ianBzL+HY4ZwNT6NUqj+rUZEx0QxTiMLoah7L2itTQfts7McNPG6x8wJ6MNIYqG64vMc8sbNzLPPkHOZyMq6fxncIUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:37:00 +0800
Subject: [PATCH 08/13] imx8mm/n: Drop unused dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-8-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|AS8PR04MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 92feb916-c038-49fd-eb40-08dea2582c5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 7Bq92837bJPF5nYvJgEOf7zMSPcFG/q1JVyqeLL+SdUDEeZLuBF3SDeBs9J7mTtN9EaW6AVj03JYew+cdCYOl+tsLK+U6QI3zfXS3dJxGRQwyH1X6B4N72MU0T1yPSkzlnm46k/fAX8zGNDLLzdUjNExmBG4CnfpeDsWl/6Jx/H5t7IuXyyfrXTJCFZBFnl3nVvAl4azh09TZ+nnokoH9cZuI08+oDFpDsS6SPAkXJ6Np/vRBqPgqdFzZE/Gn0uG0pHq0Tvgi5ZDMXEV0Q70O2/INJ7HGQDcBisfVU/xdJvzeMb1M6u1wMZqWc9wyCWI33l3Gs1q1onf76XY5WzIY9e/hWPR0oPwUc/h0cug1irPRLcb4rinwRoer/djdM/y36Cu8BN3lbykv6GXasWwO+QujQbYNLCWgJn+eQn3JEstBgUKegwBKpMXDxgoY5nUN6SJSOLQ4F7fcUF/zwlTNRbqEH/RmRxtHqUiBp3Uk+HIiNFRu4co29l+0Pj/9FeYq/17OzyIdxRXW5Tu7qRZn9YzdFbsPmhP7a8m3z0B2EwoIdfmtSrBOr/8CsastypTG943ynYNCJGfVOz+1vyMz/dqlBIICNZVLcATDhskYA/tvYrw26MW/B9bCU+TT1kYsVKqJ24gYG5+03qXdI9NzlSpVK4Y87LjGzFGpj97rH927cxFk2ErP5l3NwLVjVWpbZdA1mKIA20e0KNGppSjzTwKgqwYwtGH9bCp4M+l3LBzIhT68c/e8e3fGNrKxokh70Q1i3GPAaO17LC4hZRpBR3UtOfYIT9PNeDraEhDqSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxhVktKbFQrMXFzL01UVnBSVVl5bXdNNFVabjNKckZtTEpGN0RKRHp4aStm?=
 =?utf-8?B?dFI1S3NzOEpDL2Jrc2xDZHFXbGQyUkdhVWw3SS80dVkvdUVWc3NndC9OUDVj?=
 =?utf-8?B?RU5MQkhEdExkaTdibXBydlZZbU1qVkVZMmFwZGFqZXdUazdBekVuYzZWUm9Y?=
 =?utf-8?B?NVhTbkFmQldhTythc2V6TjJLMXNuZUxsYkpVOXN3QkZHNDNPaDA0STJYK0to?=
 =?utf-8?B?cm9VcFhSc0tNeStEdTQ0R0hBRlR5MEdJTkgrZWxxQlN4SFFVU3JyTmxFRG1D?=
 =?utf-8?B?QlZTblhOcmxzeC9WZ29rdEhSSmcyNmdTTU16ZlUzYStJY3RIR0EzNGFsT2xQ?=
 =?utf-8?B?b3BBYTh0T25aeTVhVXFOd0xOTHRvSVF3amc5RDd1SGFJajB6UjhRSkltNzJ4?=
 =?utf-8?B?eVNMT0xkN2VrUHlnbGFyZSs2aXJaQXFpanF2eHdtMlErb1RpaUhxK3N3QVYz?=
 =?utf-8?B?dU5FUDIxYnU0QmRvR1NCRWlEdFF3SzkxdUZuZU9kS0NoR0xhWEpRd0JTT1FW?=
 =?utf-8?B?SUs3T3BQVVBWcmVVSVkyeU1TV1h5cEJmUzB2STU0V2dyT3E1NThlMWF5c0F6?=
 =?utf-8?B?c3N6RmRJR2ljVVV3eStvWWI5aVRtMTVNeWw1UXRuTXkvYUFWaUxnQ3c1Yk9O?=
 =?utf-8?B?VkhaNEdMcnpNNkMwM1hkaVZnQ2o4MWRJUXJPRTlhT2hSdU9pbjA1c3M0QkI3?=
 =?utf-8?B?NlBMS2VsejJoU00ybDVpS0xlRUpBeW80NGo0MHBaSkZoeXNySXJhY0t6aThP?=
 =?utf-8?B?WFV2RFg1N2RaYTNGMW1uaVA3STRFUjVKMHo5SXp6VGZHd3FPazVTNWtMZTVk?=
 =?utf-8?B?aG9PYXJkbW13eTlNaU5xZHlXVjZJZHAwb2RLVFZ5SVVSTTJ6czdJSVlOOSsx?=
 =?utf-8?B?NXo3b2dYWEc2cDRyK1BYN0VEQm1sKzZHUEVXWWh4WXBMdE42elkxTHN2bFRr?=
 =?utf-8?B?OG05aW1xRVpubXFJM1lTVEZHNzNlRzVnZ1IvblN6ZjlWcmRiZ0F1bU5MUHRB?=
 =?utf-8?B?eTBOMXo0WlhFc1UvcmVNZCtvbXZiMG1pcUVmZFJiSDRKaTV1dkg3TUQ3V3E5?=
 =?utf-8?B?UUJqcmJBVXNaSWJZUStEcFNxVUlGZDJhODhvanIxODNMNStOakVvV3VLc0FQ?=
 =?utf-8?B?ckYzcGFFci9Vc1kxQ09qWGFIa3Qrdml3R1pscEhwaVg4ZExWRzd0blpaamZq?=
 =?utf-8?B?WktEMzd5Q2ZWckZ0RUxBZ2tNOUJyUGRZSHhoS1FHYlU3R0s4YkY4Nzc0QUVy?=
 =?utf-8?B?TlhjMGRrRTZTNGRIc0Q2TjRxV0hTL1UxREZXVjFqOHhaTXd6YWNCVHhrOXB5?=
 =?utf-8?B?VTBZM3VydWRkWE9RY3NqdUJ0SXY2STJCNDRMb3hIMXN0TTRFbVdUaGg1WjVq?=
 =?utf-8?B?akRhYXNtWFRVM3NpMi9MOHVvdzcvakR3aGFRcWlpb1FqLzlnVU1JWVpoTG42?=
 =?utf-8?B?VDYySGk2dHNhbzh6NGQ2UjNGY21LZ1llWkk3RCtxbDAwU3BaVEpiK1RUMEJ1?=
 =?utf-8?B?TGMwWTIxd0IzWEhFNmQvSlZxeHNqb1M5MU9GTnFXMk9BVEdUd2ROTmZoV0hL?=
 =?utf-8?B?WlQ2RXBTbGFMTUg0K2VIUFd6aWp4Y2trZVBuWjMrcERRS3ptWDEya2krQXkv?=
 =?utf-8?B?cEZ5QlBGc3o0Tkl1RDdlSzB6cTVocEN2RlpQVW04SUlPcE1ZMkJtS1owZEhh?=
 =?utf-8?B?cUU2NGhtbFVueTdUTVBWRzJBOWpTRXcrY0krbU5qL1dJYjlDYVA5M0JHRGlp?=
 =?utf-8?B?S1VDVlNlRnhhb0o2Nkpid285SVBZc2s3T08wQ28wYUg5Qi9xSTNrTTlTaVdP?=
 =?utf-8?B?bjgxS2gzbFVabXk2MnJsNE92em1Ic1AxSzdyclNTcG1IclRYUFNkNjQrNFBo?=
 =?utf-8?B?ZS9BVGRwS2NvV1F4UGxEbThPQzJDcVEwNVNhRDhQY1BOY1o2dHNhd3BzYUZX?=
 =?utf-8?B?VkJDaU41bmttbVFscDJXUlZPTU5kTU43ckhjc2pqbkl6ZXlzN05rc0N2YzAz?=
 =?utf-8?B?VUJnb0o3MnZ0WWZDR2RadTVnWVBKT3VxdjZ3U0RWeFo0N29aMXFsdThtNnZj?=
 =?utf-8?B?SEwxdG54VXRNMWJ1WFFmNmR2MFRLKzdCUkMwV0x1c1hHNUM2eWhhZWY0U3d2?=
 =?utf-8?B?dVNuN3dNQjlWaGJUVkE1QmtzOVNnTDVvV2lxVVgxTkQ0T1ZpYUZwRXhPMTlL?=
 =?utf-8?B?UW5yUDA3elpMZWRNbW0zZ0RjNEtvSGVwNEgvS2tGY2M2K1FPSkE3NUZkUXFY?=
 =?utf-8?B?WDFybU9XVksyTE12aFkvR3p3NEtkRXlBQndIZUo0a3ozUHg5VUV3djJCc3NJ?=
 =?utf-8?B?VkJUTXkrMElqaHZaVzQrNmJyUzBQbGFZenZsNEw5aFFtYlVrU2NnZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92feb916-c038-49fd-eb40-08dea2582c5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:12.0973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e82l3KlubIZDrZbfJmYZ8j7fDjM/I6cVp2iZBHuflXO9UzUJKJqJuGgKa1Ppyvw/V0dYMhtqTnaFGrxDw5BIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

imx8m[m,n]-beacon-baseboard.dtsi was missed to be deleted in
commit f5585124c90a ("arm64: imx: imx8mm-beacon: Migrate to OF_UPSTREAM")
commit a64feb974f66 ("arm64: imx: imx8mn-beacon: Migrate to OF_UPSTREAM")

arch/arm/dts/imx8mn-evk.dtsi was missed to be deleted in
commit 73d57e0aa45f ("imx: imx8mn-evk: convert to OF_UPSTREAM")

Drop them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mm-beacon-baseboard.dtsi | 437 ------------------------
 arch/arm/dts/imx8mn-beacon-baseboard.dtsi | 309 -----------------
 arch/arm/dts/imx8mn-evk.dtsi              | 533 ------------------------------
 3 files changed, 1279 deletions(-)

diff --git a/arch/arm/dts/imx8mm-beacon-baseboard.dtsi b/arch/arm/dts/imx8mm-beacon-baseboard.dtsi
deleted file mode 100644
index 03266bd90a0..00000000000
--- a/arch/arm/dts/imx8mm-beacon-baseboard.dtsi
+++ /dev/null
@@ -1,437 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-
-/ {
-	leds {
-		compatible = "gpio-leds";
-
-		led0 {
-			label = "gen_led0";
-			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		led1 {
-			label = "gen_led1";
-			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		led2 {
-			label = "gen_led2";
-			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		led3 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_led3>;
-			label = "heartbeat";
-			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	pcie0_refclk: pcie0-refclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	pcie0_refclk_gated:  pcie0-refclk-gated {
-		compatible = "gpio-gate-clock";
-		clocks = <&pcie0_refclk>;
-		#clock-cells = <0>;
-		enable-gpios = <&pca6416_1 2 GPIO_ACTIVE_LOW>;
-	};
-
-	reg_audio: regulator-audio {
-		compatible = "regulator-fixed";
-		regulator-name = "3v3_aud";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usbotg1: regulator-usbotg1 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb_otg1>;
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_camera: regulator-camera {
-		compatible = "regulator-fixed";
-		regulator-name = "mipi_pwr";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100000>;
-	};
-
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		regulator-name = "pci_pwr_en";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		enable-active-high;
-		gpio = <&pca6416_1 1 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <100000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
-	};
-};
-
-&csi {
-	status = "okay";
-};
-
-&ecspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	eeprom@0 {
-		compatible = "microchip,at25160bn", "atmel,at25";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpha;
-		spi-cpol;
-		pagesize = <32>;
-		size = <2048>;
-		address-width = <16>;
-	};
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	camera@3c {
-		compatible = "ovti,ov5640";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ov5640>;
-		reg = <0x3c>;
-		clocks = <&clk IMX8MM_CLK_CLKO1>;
-		clock-names = "xclk";
-		assigned-clocks = <&clk IMX8MM_CLK_CLKO1>;
-		assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
-		assigned-clock-rates = <24000000>;
-		AVDD-supply = <&reg_camera>;  /* 2.8v */
-		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
-
-		port {
-			/* MIPI CSI-2 bus endpoint */
-			ov5640_to_mipi_csi2: endpoint {
-				remote-endpoint = <&imx8mm_mipi_csi_in>;
-				clock-lanes = <0>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-};
-
-&i2c4 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-
-	wm8962: audio-codec@1a {
-		compatible = "wlf,wm8962";
-		reg = <0x1a>;
-		clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
-		DCVDD-supply = <&reg_audio>;
-		DBVDD-supply = <&reg_audio>;
-		AVDD-supply = <&reg_audio>;
-		CPVDD-supply = <&reg_audio>;
-		MICVDD-supply = <&reg_audio>;
-		PLLVDD-supply = <&reg_audio>;
-		SPKVDD1-supply = <&reg_audio>;
-		SPKVDD2-supply = <&reg_audio>;
-		gpio-cfg = <
-			0x0000 /* 0:Default */
-			0x0000 /* 1:Default */
-			0x0000 /* 2:FN_DMICCLK */
-			0x0000 /* 3:Default */
-			0x0000 /* 4:FN_DMICCDAT */
-			0x0000 /* 5:Default */
-		>;
-	};
-
-	pca6416_0: gpio@20 {
-		compatible = "nxp,pcal6416";
-		reg = <0x20>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6414>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	pca6416_1: gpio@21 {
-		compatible = "nxp,pcal6416";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&mipi_csi {
-	status = "okay";
-	ports {
-		port@0 {
-			imx8mm_mipi_csi_in: endpoint {
-				remote-endpoint = <&ov5640_to_mipi_csi2>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-};
-
-&pcie_phy {
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	fsl,tx-deemph-gen1 = <0x2d>;
-	fsl,tx-deemph-gen2 = <0xf>;
-	fsl,clkreq-unsupported;
-	clocks = <&pcie0_refclk_gated>;
-	clock-names = "ref";
-	status = "okay";
-};
-
-&pcie0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
-	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
-		 <&pcie0_refclk_gated>;
-	clock-names = "pcie", "pcie_aux", "pcie_bus";
-	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
-			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
-	assigned-clock-rates = <10000000>, <250000000>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
-				 <&clk IMX8MM_SYS_PLL2_250M>;
-	vpcie-supply = <&reg_pcie0>;
-	status = "okay";
-};
-
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	fsl,sai-mclk-direction-output;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	assigned-clocks = <&clk IMX8MM_CLK_UART3>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usbotg1>;
-	disable-over-current;
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbotg2 {
-	pinctrl-names = "default";
-	disable-over-current;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphynop2 {
-	reset-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_espi2: espi2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
-			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
-			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_led3: led3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
-		>;
-	};
-
-	pinctrl_ov5640: ov5640grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
-			MX8MM_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1	0x59
-		>;
-	};
-
-	pinctrl_pcal6414: pcal6414-gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
-		>;
-	};
-
-	pinctrl_reg_usb_otg1: usbotg1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-		>;
-	};
-
-	pinctrl_pcie0: pcie0grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21       0x41
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
-			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
-			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
-			MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX	0x40
-			MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX	0x40
-			MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x40
-			MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x40
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CD_B_USDHC2_CD_B	0x41
-			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK	0x190
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d0
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK	0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK	0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mn-beacon-baseboard.dtsi b/arch/arm/dts/imx8mn-beacon-baseboard.dtsi
deleted file mode 100644
index 9e82069c941..00000000000
--- a/arch/arm/dts/imx8mn-beacon-baseboard.dtsi
+++ /dev/null
@@ -1,309 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright 2020 Compass Electronics Group, LLC
- */
-
-/ {
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "gen_led0";
-			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		led-1 {
-			label = "gen_led1";
-			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		led-2 {
-			label = "gen_led2";
-			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-		};
-
-		led-3 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_led3>;
-			label = "heartbeat";
-			gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	reg_audio: regulator-audio {
-		compatible = "regulator-fixed";
-		regulator-name = "3v3_aud";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pca6416_1 11 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vsd_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usb_otg_vbus: regulator-usb {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb_otg>;
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
-	};
-};
-
-&ecspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	eeprom@0 {
-		compatible = "microchip,at25160bn", "atmel,at25";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpha;
-		spi-cpol;
-		pagesize = <32>;
-		size = <2048>;
-		address-width = <16>;
-	};
-};
-
-&i2c4 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	status = "okay";
-
-	pca6416_0: gpio@20 {
-		compatible = "nxp,pcal6416";
-		reg = <0x20>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6414>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	pca6416_1: gpio@21 {
-		compatible = "nxp,pcal6416";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	wm8962: audio-codec@1a {
-		compatible = "wlf,wm8962";
-		reg = <0x1a>;
-		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
-		DCVDD-supply = <&reg_audio>;
-		DBVDD-supply = <&reg_audio>;
-		AVDD-supply = <&reg_audio>;
-		CPVDD-supply = <&reg_audio>;
-		MICVDD-supply = <&reg_audio>;
-		PLLVDD-supply = <&reg_audio>;
-		SPKVDD1-supply = <&reg_audio>;
-		SPKVDD2-supply = <&reg_audio>;
-		gpio-cfg = <
-			0x0000 /* 0:Default */
-			0x0000 /* 1:Default */
-			0x0000 /* 2:FN_DMICCLK */
-			0x0000 /* 3:Default */
-			0x0000 /* 4:FN_DMICCDAT */
-			0x0000 /* 5:Default */
-		>;
-	};
-};
-
-&easrc {
-	fsl,asrc-rate = <48000>;
-	status = "okay";
-};
-
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	fsl,sai-mclk-direction-output;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart2 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
-	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	disable-over-current;
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_espi2: espi2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
-			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
-			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_led3: led3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
-		>;
-	};
-
-	pinctrl_pcal6414: pcal6414-gpiogrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
-		>;
-	};
-
-	pinctrl_reg_usb_otg: reg-otggrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
-			MX8MN_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
-			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
-			MX8MN_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX	0x40
-			MX8MN_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX	0x40
-			MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x40
-			MX8MN_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x40
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CD_B_USDHC2_CD_B	0x41
-			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x190
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d0
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x194
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d4
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK	0x196
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD	0x1d6
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mn-evk.dtsi b/arch/arm/dts/imx8mn-evk.dtsi
deleted file mode 100644
index 261c3654007..00000000000
--- a/arch/arm/dts/imx8mn-evk.dtsi
+++ /dev/null
@@ -1,533 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2019 NXP
- */
-
-#include <dt-bindings/usb/pd.h>
-#include "imx8mn.dtsi"
-
-/ {
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		status {
-			label = "yellow:status";
-			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0 0x80000000>;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ir>;
-		linux,autosuspend-period = <125>;
-	};
-
-	audio_codec_bt_sco: audio-codec-bt-sco {
-		compatible = "linux,bt-sco";
-		#sound-dai-cells = <1>;
-	};
-
-	wm8524: audio-codec {
-		#sound-dai-cells = <0>;
-		compatible = "wlf,wm8524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_wlf>;
-		wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
-		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
-		clock-names = "mclk";
-	};
-
-	sound-bt-sco {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "bt-sco-audio";
-		simple-audio-card,format = "dsp_a";
-		simple-audio-card,bitclock-inversion;
-		simple-audio-card,frame-master = <&btcpu>;
-		simple-audio-card,bitclock-master = <&btcpu>;
-
-		btcpu: simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-			dai-tdm-slot-num = <2>;
-			dai-tdm-slot-width = <16>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&audio_codec_bt_sco 1>;
-		};
-	};
-
-	sound-wm8524 {
-		compatible = "fsl,imx-audio-wm8524";
-		model = "wm8524-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8524>;
-		audio-asrc = <&easrc>;
-		audio-routing =
-			"Line Out Jack", "LINEVOUTL",
-			"Line Out Jack", "LINEVOUTR";
-	};
-
-	sound-spdif {
-		compatible = "fsl,imx-audio-spdif";
-		model = "imx-spdif";
-		spdif-controller = <&spdif1>;
-		spdif-out;
-		spdif-in;
-	};
-};
-
-&easrc {
-	fsl,asrc-rate = <48000>;
-	status = "okay";
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			qca,disable-smarteee;
-			vddio-supply = <&vddio>;
-
-			vddio: vddio-regulator {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-		};
-	};
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi>;
-	status = "okay";
-
-	flash0: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <166000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	ptn5110: tcpc@50 {
-		compatible = "nxp,ptn5110";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_typec1>;
-		reg = <0x50>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-		status = "okay";
-
-		port {
-			typec1_dr_sw: endpoint {
-				remote-endpoint = <&usb1_drd_sw>;
-			};
-		};
-
-		typec1_con: connector {
-			compatible = "usb-c-connector";
-			label = "USB-C";
-			power-role = "dual";
-			data-role = "dual";
-			try-power-role = "sink";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-				     PDO_VAR(5000, 20000, 3000)>;
-			op-sink-microwatt = <15000000>;
-			self-powered;
-		};
-	};
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	pca6416: gpio@20 {
-		compatible = "ti,tca6416";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
-&sai2 {
-	#sound-dai-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clk IMX8MN_CLK_SAI2>;
-	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&sai3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	fsl,sai-mclk-direction-output;
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&spdif1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spdif1>;
-	assigned-clocks = <&clk IMX8MN_CLK_SPDIF1>;
-	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
-	status = "okay";
-};
-
-&uart2 { /* console */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	assigned-clocks = <&clk IMX8MN_CLK_UART3>;
-	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usbotg1 {
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	usb-role-switch;
-	disable-over-current;
-	samsung,picophy-pre-emp-curr-control = <3>;
-	samsung,picophy-dc-vol-level-adjust = <7>;
-	status = "okay";
-
-	port {
-		usb1_drd_sw: endpoint {
-			remote-endpoint = <&typec1_dr_sw>;
-		};
-	};
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MN_CLK_USDHC2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MN_CLK_USDHC3_ROOT>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC		0x3
-			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
-			MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
-			MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
-			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
-			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
-			MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
-			MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
-			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
-			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
-			MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
-			MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
-			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
-			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
-		>;
-	};
-
-	pinctrl_flexspi: flexspigrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
-			MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
-			MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
-			MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
-			MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
-			MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
-		>;
-	};
-
-	pinctrl_gpio_wlf: gpiowlfgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
-		>;
-	};
-
-	pinctrl_ir: irgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13              0x4f
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
-			MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_pmic: pmicirqgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
-		>;
-	};
-
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
-			MX8MN_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
-			MX8MN_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
-			MX8MN_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
-		>;
-	};
-
-	pinctrl_sai3: sai3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
-			MX8MN_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
-			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
-		>;
-	};
-
-	pinctrl_spdif1: spdif1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
-			MX8MN_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
-		>;
-	};
-
-	pinctrl_typec1: typec1grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX		0x140
-			MX8MN_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX		0x140
-			MX8MN_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x140
-			MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x140
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
-			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
-			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
-			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
-			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000190
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000194
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000196
-			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
-			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
-			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
-			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
-			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
-			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
-			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
-			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
-			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
-		>;
-	};
-};

-- 
2.51.0

