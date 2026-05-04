Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716B6CD3424
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 00:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4B384255;
	Mon,  4 May 2026 02:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4NMMbyAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E356845D8; Mon,  4 May 2026 02:34:42 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC7383EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 02:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyorTJvivuZw8vsZR68d6M1g4uOU/Jokc0OSBbItxJu9rT59jLgvQWp4ZP/U2O4zBc0sdJPOzUZMMAwU4ZjBbmzsvizG5jKWamE1ZbAyaofO+aZ2iAZBr7Kb9EWrKWqyw/ZkIadwsnMv/uafqFtFmiDOyCTvNJ3g4hfeWQt2pxHtBMzDtDWXZlvIPN3qnCl/n4E+jdV+ZUGCwYwX5vhB9t+Vf95hRTlH6fb+VI+d9cGw4x/6fAoTpp8yJLPcsDCrQTH/j9jjKcfqHEPiBG6sjn5a36S4qZzZwa9ZlTDXTZDjJCoREWCIBZXsGmDgmgQKVSAi1RBEVMmXZywDKepPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh43FrOgIwTUjIHTbee3TmO5Hosyyb35pZla7SbAb6M=;
 b=lBvteQaLyMNo9zuylKRj1L8aOxsodwhjQxidssG33MUwV2qHtOsITqkzy59Lrw10igDD4zEnIl+gxsoscbkdogkb+SKq0TMxFhc1lUl3EPy/yXEL35mZFMwra0qjVCO0XlTw7hVyJJ5AoDRe1vdsVqnPFwYw2UDT10zUPtANL14DmYDpyzrtQjEQMDZFHKMQDrJsESCzaizWqwSWaiy0XYfUfyLzrVYL6Kj3ez7HZwleu9imIDhhf9klR+DnErgyG5jvfTpsRz9HGvEZOS8bLTTNXFXY5bjTkF7+tEdxmOnxuRjsqZfRrRuVqiMIAN+7IokZfDlICofEu1D+SErTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh43FrOgIwTUjIHTbee3TmO5Hosyyb35pZla7SbAb6M=;
 b=4NMMbyAnZHTbwQZGdA7pKhMHMuHKDakcKKtJY1G6fK30UefjB3DNTNhGkWsTN+9ggJHmVqRY+kImKOHqbnMcfCDafuCB94bCd7/EDrCMhhNFyWtDVn2w/pKvJIW6x104PIvexq6MOJGD/3K/ZfobPwF/QECYIns158HzoY7dxIKTo1DE5CivGDWo4cdvOlDjYJ8f3vXhsvjvNOkSMo7AaW/Y48w+LrdDz0yMSYBQc9Vj1rCxLf1ll3Vcj3EEaqcoNagsnZ7aSn2tpW2jZBUOYWbZiSsCQoviFV4/BOHLh/Y2xyyHhJ/Si0YoaJnHzhP0xhN6V86ys/gXu1bvchQs4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 00:34:37 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9846.025; Mon, 4 May 2026
 00:34:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 0/9] pinctrl: add support of Airoha SoCs
Date: Mon,  4 May 2026 03:34:12 +0300
Message-ID: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00023A03.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2aa) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 592aac9e-31be-443e-a76e-08dea974eb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: L18KeZbO7NXAldOfuEWlG8VFrosaWDwl2aoUdVYmXA4AVRCpnsCxHlSwiadm1vgU6dGm3fqIwRQXZunbyPaPsWYDJ9e0amEmRnKJx/2qGQbojR4K9mSKrSM5VrOQ53AJo1YDW8DBiPVSE+J3tG46WyJaPxyklLuYTM6ERgq5wDGEQ+1Cxa0cczAceJtKDlZUo/vnXLB85DNVdDNgEY+hS5aidyK03vcQ2KrWsglGYDGxB8icGrkZ1dzJbJWClU3CdqeOBSEk9SoyTEmHvAO5IrnnXrOtn4pMbBHpPDdFiVo0Q93f95jj5yzimh9bGBtrYHz7uQ2hAlQ6cMRdfxI/4yK8dYluLnYLZ57qmZ3Jnl90twIVpFN557v4+L8NlUFevEZaz63dp3Mz850bXgYsb+d4Bf3wDrxCzdMGs+kxYSKHeEbisF1Ra4R8DNl7+29uY9BQX0Q2cVVYOVLiDll3FvlNkfQWOIHy8P8nETvY/b0+Jv5D9ySYFHGuNVaIbR1zswBO6mxXQxv0pBcdEbL+tpfe1zxFyy2TlayP0TMWPA6iRmu5sVRuO7byQRDAc4E65vfi3hTvkhSDeuWIjjgrqZPw/JOL7uvBi6qwC1ic5gaIH/AkaLlxota37Nbz5U2Bg1TcEss2Hdd5Imf/XBgk+WlYC/vNRPwP5Q6aJbKgwRWnNPwS2ZQF3YHlIhEMo6EHhf/Ydjo5Gs0lh6IKr7tsWFcry1ERXJN8hySIe32jLCyDTCCbv9SHS+gIk+zN7DKdR6HTAsaeJ5JQ4cpI+JNiqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHR4dGp3VDdEcVA3alBMZmZ6bkpqMlVZY2NiMVBEd0xYQ1ZqSmlXTHRGaGFT?=
 =?utf-8?B?ZkFRekRKeXRyR2hmTU10d1dsZFQ4MEtlSWtGSFJCQWM1bXBUV2RNTFk1OVha?=
 =?utf-8?B?Zkl5alhyenBOOUNFN1JLcDl5Y09GUEdhc2I2cW93Y09oakRicmNIbjlXSjlX?=
 =?utf-8?B?dlBNcmZzRHZidWFrWFNQQUNPZ1VVVExrY2hRZVNDVnNzRHpJRHZZSmRwamFP?=
 =?utf-8?B?blVhSVhySThBTlI3ZmxjQ2RWc1dJd1IxVFphVlRuemhlZ1B2R1RDNW9iNUd1?=
 =?utf-8?B?eUFsYkpCa21wSzRRdDg5Q1hMVFVrbGNrN0JFMElveTFVc3hwd1A3ZmVNZVcv?=
 =?utf-8?B?Y05RRy96K1lhN08zYngwUm5IdWJqdVNGd0FWeUhZNHJCYmN6NFBRTXhzazRE?=
 =?utf-8?B?VkRPUGhnMnp4dVZ1N21nQTNvQXRqVmlOMjQzNGtCVVBDZE9wMW1BSzMxMDZr?=
 =?utf-8?B?emhFYUtsMFRoWm5iSktsUS9MMytyak52WGFYL0d2WDRqa1QrY1k2M1MzdmhY?=
 =?utf-8?B?WDdXZlFra21xYVdjWTlrNkFyclBpVmE1MS9Zd1B5RGR1MG5tL0NFUzRFV3Rq?=
 =?utf-8?B?WlE1TUUvWkMvcEdMRzFVQkFjTnV2WEJrdW9sOTdzcUFrZ1ZRdmdubzd5bjZO?=
 =?utf-8?B?Uko2WEJGYzhCRm01b3Bmdk9XOFRpUWI4Y0hqMkFnejNrQzJxVDBCbkNMNmNI?=
 =?utf-8?B?OTJjaFVQakh2VzlzNDZEZllieG9RRkk3MDUyRnlZN1FuZjJRV1ptVUFqdG9P?=
 =?utf-8?B?UWFSSmNVTXVRYTRkMGVLUk9qZUE0dklCaW5DcjNsQjIram5xNnh0Z0VkejNo?=
 =?utf-8?B?MTY0eXpMVktCMmtTMkNkTnBpVDJqVWhoZmJraVZOQ04xSDIxdEIzemZLZHk5?=
 =?utf-8?B?a0dWa1UrbWZmNzFOZmlMT3JaV1dEWEpYdU9lSGNkbDhwbDZ2cVZkeDBDeXBB?=
 =?utf-8?B?Q3ZLRVVZNDNrVVQyMGJ6OXNWb2lGTjVRT1d5ZHRVWjB1VWRtYStxK1FtS0Vs?=
 =?utf-8?B?RGhhZnQ1MDV1QjRKZlNhTWxjSU1XdFduN2tWZHdlZDdFWTVYSEpxSVNqeFh0?=
 =?utf-8?B?VDVjdkJuQjhScnRvN3hYcFEvQnEwcWE5WDRDYXQvbUpjZkp0ZDB3SFlGUjVu?=
 =?utf-8?B?eEx1VWt3SlpKQXJEYzR3a1Rld2lZY1hIRkpLT21sOC9ENEFrMDVoWnNyY0NP?=
 =?utf-8?B?ZmcrV3N3TWVJZFFMOFF3MCsvc1J6N2Z3dXRKMzYzWnQ5QjM1MTRMQ242STdm?=
 =?utf-8?B?RDcvdDJob1FibmlBcUpabzlqcGVVakZrd0NVR3JqZjFhbmtLQS9uLzB2bzda?=
 =?utf-8?B?QTB6T1l0cC91SCtLNHlPRytqamdBWEx2ZW93MWQvaCtYbFhXYUxwcThFdytt?=
 =?utf-8?B?ZENxZ2xMSDlXSHNIeGh2b0FnSlFKd0pzL1ZkeDc0a1lGNG9paEEzNG5iTEVx?=
 =?utf-8?B?ekozYTZ5TUFGMUZ1c0tmMUloVjU2WTJSSEJuUEhQaTRaZmtva1FsNmFoMWta?=
 =?utf-8?B?UXYzTGEzQTZpTnVGN0RHb2t6MFFyQlBGU3Y2UHZOcTRTZ2NOdHdQNWU4TE5J?=
 =?utf-8?B?TXo5QWFRQVNuRTFZMkVHOEF6TTlVSWVuNnFOREFRM2xIejVLNDNaR1FEMG4x?=
 =?utf-8?B?Y3FIdjFJU29yYnE4bHRaWUxISFY1RkVERzhKSy9Gb0Z4MHVDcXptVmE5UUp1?=
 =?utf-8?B?S2R6K0ZoR3dHSnk1NzNaRVROZCs2anhOUzliZXF6aVA2dlZLTXRBZGdMMWRL?=
 =?utf-8?B?cWNVTGY0VWxibDcwUTloaWYyQmRmZkQvQldpeTFnODFCNXF2TFViRHVzSXRo?=
 =?utf-8?B?ZHNVUkxoeGpiODNCa0hpKzRHK25acFhJaElnMnd2RGdiWis5YW9nYnBuZlFM?=
 =?utf-8?B?dkFuWnNKRHY3eHJuQlFTQlBReGxRN2xOQW0rdVVjWmNxSE1sWkVIck5XTW0y?=
 =?utf-8?B?a3lHYXdJOUplSkpLL21qV0M5RExlMUh3eWhCdE84eE5HcXc2alZucEdkUkVG?=
 =?utf-8?B?ZkhaWkgvYVpXdk5DZU0zNDk0V0dHY3RITXh3dzNXaFhIQjBvamRjeDdjZ1Zz?=
 =?utf-8?B?OGJWbStIbE94OWR5VUZBbStsZWFINCs2OG81SDk5UUxMWU5mTGdyb2dhMGJQ?=
 =?utf-8?B?N0cxZVFBQ2xzRFc1MTU4dERaSkFkN3phbjJRMXZ5WG1SK0JsSVZYVnRwUllV?=
 =?utf-8?B?cFI1aHZjbkhEbFByNDhmSHBNTXI2R0dsVnRCSk9GN0pYSmtJSHV5R3VVZm5C?=
 =?utf-8?B?dEtBMCtRWm5jYmovVVZnN2NpcWd4N2dxU1RjSHVlTldRMmJLYVpNa2NHS09O?=
 =?utf-8?B?L3BvVTBKZWgzQUk3OFhISDlJMkc4c2t4UzFMMGc5ZmZubmhzdXV1b0FwTkRT?=
 =?utf-8?Q?cxaSoTOZ37kP2vls=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 592aac9e-31be-443e-a76e-08dea974eb3a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 00:34:36.5201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoUkeLGEADO9ZSmMduZftw4BaTVrNeQREhmXoOwRQyK4YxXugOr1P/2bWkTzZUXRlBfp1lNvAUeb+qPVuGMO4SGRsTkh6pEc/0jGSryBteo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
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

This patch series add pin controller and gpio driver support for EN7523/
AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
gpio driver with Matheus Sampaio Queiroga changes.

The original Matheus Sampaio Queiroga driver can be taken from the repo:
  https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl

Additionally in the EN7523 case the patches removes existing gpio dts nodes
and replaces them with pinctrl node. It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * Legacy Linux EN7523 GPIO driver is mostly abandoned
 * The same driver is planned for upstream linux/openwrt

The patches were tested on EN7523/AN7581/AN7583 boards.

Changes v2:
 * pinctrl driver was split on common and per SoC parts
 * EN7523 SoC support was added
 * EN7523/AN7581 defconfigs were updated to activate
   pinctrl/gpio support
 * Board/SoC independent pinconf/pinctrl definitions
   were moved to global includes

Changes v3:
 * add non-constant field_{prep,get}() helpers
 * put airoha common code to a separate patch
 * put en7523 dts change to a separate patch
 * add support of "pinmux status" command
 * address a lot of comments from David Lechner

Geert Uytterhoeven (1):
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (8):
  pinctrl: add more pinconf/pinctrl definitions
  pinctrl: airoha: add shared pinctrl code
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
  configs: airoha: an7581: enable pinctrl/gpio support
  configs: airoha: en7523: enable pinctrl/gpio support
  arm: dts: en7523: add pinctrl/gpio support, drop legacy gpio support

 arch/arm/dts/en7523-u-boot.dtsi         |   21 +
 configs/an7581_evb_defconfig            |    7 +-
 configs/en7523_evb_defconfig            |    3 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |    1 +
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  513 +++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  827 +++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1074 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  976 ++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  648 ++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   59 ++
 include/linux/pinctrl/pinctrl.h         |   74 ++
 15 files changed, 4258 insertions(+), 7 deletions(-)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7583.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-en7523.c
 create mode 100644 include/linux/pinctrl/pinctrl.h

-- 
2.53.0

