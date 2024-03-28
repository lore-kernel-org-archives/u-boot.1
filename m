Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF731C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 04:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E60588096;
	Thu, 28 Mar 2024 05:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AxBsRbvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47BE187BE0; Thu, 28 Mar 2024 05:06:13 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DC587F4F
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqprl0wZfy/ED/ML5Lch2FF/FW5F+EPDhanbMNVrwo8LJHS2cIZ2BkuAA0RY3UxL5MAbJHKJ3E50/12kbi9VFaowPWlT2TX7v1VlFnc1DwJsz31YcsLKgXs91HvHgEDftI4BMLuz8pvnzi34ra6OTTFIas8rbwngez3JwsEArwUT0f9KBvCEeHxAJdAypI/qL9gC5A6OhCa7GffnY6l6zmO5CV9XZK6nwn+MlfCn7jg88JSlgr2WhMrH6t6uGklSK4AlVC33TAhM7cVmRX7qqS9obxo4sBqophbr/FolK2ltR2h0b3d43jh1MXku47/zyg970ZTSN0mEyL5a7PL0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEQeVqBGBKiW4qh+69nH0Ohu1kDx2bovpHqlTIoFT3s=;
 b=XUf+5nabVtYNmRaZuDzEq4craGB1mqyDOZRixyUp6/weZZnUw4SAE4UgWIcmQ/Q75sX4Bjl3IY1yyjSsq68xKhL/O213WOx6Fye5aCycuSh/nip6WZ8GJKFs2aMvRYrZsvQo7RqqGhn2bH5F+NAU5NROsk8EFj+aNgBGJPlbeYJn8EgCkjWo8W+0PypjhZpHGklC/vMpt+GwwmBEJc3lLE/8x5sAO/gHSExYPikDm1aeL73LapBODWljyLkgLtftmlx/H/ge9sN60tNWfASjn9V23V9Jp3unOWz8YJJfZBe1MwVv4JjgADQh8cIQS0rMVagVXY7MjUtvFYtNx/6HUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEQeVqBGBKiW4qh+69nH0Ohu1kDx2bovpHqlTIoFT3s=;
 b=AxBsRbvcbMuhQxEBE1sKP7PqZXadlT+KGA84v+l03o3R1UWdwrap7DEKPQIOKu++Nn7qOrJ0hO9+L02dfaYqIoH45Q54Nizf7ypWKcCduM038Pazvvjr/SdEh0h7/LhQMtMDNsdiQXB7RE0DXByjJPZqhtEWIvrv5f3Bvqt0KXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9488.eurprd04.prod.outlook.com (2603:10a6:102:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:06:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 04:06:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
Date: Thu, 28 Mar 2024 13:05:44 +0800
Message-Id: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKj6BGYC/x3MQQqAIBBA0avIrBsIFbSuEi0iZ2oWaShIEN49a
 fkW/79QKAsVmNULmaoUSbHDDgr2c4sHoYRu0KO2o9Ee5Xomg4mxamTvJmJiZ1yAXtyZWJ7/tqy
 tfRSaMshdAAAA
To: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: b790f636-bdbc-42fb-9378-08dc4edc65c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnPtL+vV4IsJbB52Q52B7D6E2LYnvLfNj2/1XLUQNDfxNXx1eyi1wu6peqEQu4NDN1tsINA66DVCxabDogVzdOrSK5+sGZigHKApViAzIHcWL+AKm/0jKNrD8VB8XtRupurY6omseUHgiArwloqkDiILG9E6n/eFB7WtMFyypO1tVBy8asIcP8CtLjPTVFknMioQExeDjjprAQpV5kLLEEUETQps7/TO9Fp3RUOOzkHuwkb+iZbmWl3ebwCjmYZoFgh8eLENbikKHWsQVyRITFrWjSEqQRoaiw8UQmZOodB6Szvi+92N9bkW2PA23jDzSy8EkBcypuBhNiBnaz3LW0ZIgUYzvIX9Dz6VpMAJdYXl+Q/dM9Op7fhQfqtoKeBoqJQBKbGKV56FbHMUVSJAJsJn4j+i0894CSafexxWZLRPAkKVbHxvJRCUupMrgemOA9soIBW3ocbAw9fW0v5eU7URip6kDJF6FyOnN5VBp0K69tEhv9GU4FCf3Pk6ee9Ppizb5pQV50j1K5R8Gje62jYWc7apBjMyED3cBWBSkjcvIw/4jsXTJWSS2mq7LtHp0S+72rRxwjA8UnNoX98QsLY3eSYKhh4dKEuBaBU8uSuoZ2jD5om5XBCGB78UuhKkJeFsNmJ3hkj6hNMRmL7IXLHe8dCPlC4GsxP5rD8Z9tJUoYC0xtcdU6P0erOovLqC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJVaWJKQytEQm1xSjFoVmtWUHpTYkNnb29zQnBsdVJ4SVpxTUN2TFBkQkRp?=
 =?utf-8?B?aDZsSTl5MEo5TC9qaDBMWExhbG1nN2ZNcWhHbG0rVnFNVitQbDhIcHBXeVU5?=
 =?utf-8?B?bGlaeGc3SzVwUEpEcWJDOFo4NXpOZHc2clpEbUhGRnZMYlRWSGFWMFFqRHl1?=
 =?utf-8?B?NFJXWHhqS2syZlF4cEw5YXkyQlJZZ1V6enRYaWlrWEpKMXo3VzdDaldiNFdZ?=
 =?utf-8?B?c29YT29SLzByTFp0ckdTOFIvVHlTOE1CSU9GSUFzRTVFNStYeWM3T3l3L2ZW?=
 =?utf-8?B?NTZqSWwweXNqaTEzUm1BSG84aXlxd1JGMmpFRGNQK2N2YStuZHJpREJxUkxz?=
 =?utf-8?B?NGV0VXRwblB3K2pFOER2Tjg4SEQ2WFpYb3RPNmM5SmN4WUQ3WDEzQjd5azFn?=
 =?utf-8?B?SkdETTB1RGZFOHIwUmUwV09oeFllTWxCbm1rQ2VHSmxDNXZ2SXFtOWhvbE9F?=
 =?utf-8?B?a3B6ZFYyOE5JWlRoYk9aVnJKS0EzK1laeWE5MUFvM1NwWnJ4SXpTVDdoRDkr?=
 =?utf-8?B?SGpVT0VMV21OUzZRdGp5d1N5RDVRK0UxWm9QZjVTUTJhOU9BZHlQSDVKTy9X?=
 =?utf-8?B?ZndLVGlpLzVhQWZubUtNVGFFTFNveWd2Yi9CVU1zV0RNMFFlOXRDczBxVTZL?=
 =?utf-8?B?Y3BKZWJBWG0vL3krOGNweWNLbUtPT0JQNnV2VTdCQlFtZFl0d0pHUzlwQlZJ?=
 =?utf-8?B?T2RuZStTMy9LVDNtWHZrTlZaS0MxMnBBVmMyZ05ITkdaN2xSSVU4YkprWnJF?=
 =?utf-8?B?bjBiUm8rVUs2MmtNYmpaaVBmL3FBYU1SZzF0LzhCUnd6NnhnWVIzc1lGSTI1?=
 =?utf-8?B?cVFRVUNyVG41SER3V0hXeTJORDlJZW52Ui9RYkk4M0Mvd25zV3I0VDVxVThZ?=
 =?utf-8?B?WXpBYVdVajdsUjFGRkl3MzRGaFcwcHM0MTZhTmExVUNpMWFEbVk0blpyTGlE?=
 =?utf-8?B?N1BBNWZxSlBrMzJueFZrb29laThWMDFOclRhSithb0VSdmhqOEN5eWx0L0VG?=
 =?utf-8?B?TkZLWjlQV21pZXRNNEYybEQ3QjBpZ2lHZVYyZ0tFTlRSL0xsVGJQZFNReWJv?=
 =?utf-8?B?UGZYRmtuOHhVVkQ2Y014Y1RIZjlYK1VHWC92MXczOW9GWGJTQ3lVTVpnb21n?=
 =?utf-8?B?aUtHTjN6MFEvMVgwNW1Vc0pmT0pZV1duRVZJaU5OM1hYcm9xZGE1d2ZiWm5E?=
 =?utf-8?B?UGx4S1l0cHEvb2dRYWY2TG1yTHFGSkZGMitVNUpsL042NlVINlJKUk5Bb3Z4?=
 =?utf-8?B?dEMvSmZFMGxhMDVwNi9aWEhqYXVwcEIyVm4rZ3VxN25aZUlJcGxGR29mc2d2?=
 =?utf-8?B?K3FOUWhFN1dzbFA3RjVGMFdINGlTZGNoTkIrMTlWZURGWGxkWVFKaTlrMkxu?=
 =?utf-8?B?QWcrbEZMMFR3MWZ5ZERRcVU2OHRJak54TzRpdjZsQ1Q2Z25RSy9lSVJUYTVv?=
 =?utf-8?B?cVZNQ1UzOWxrZ3ZoTTlwZ1Jod3pIYmNLcU1yaUtaTDA2a2k0Q2tSQ2Vza3dk?=
 =?utf-8?B?L203YURYZlhzR3JLdGsyemk3R3JyUTJHdmtjanV5VWJFK0t0Vm0wZmZiRUF3?=
 =?utf-8?B?S0lhL0RDYnNaSzBVUWRBd29heXFWMTkrZ3ZBbHZvTmxXeGlRNkhSNWtXWHQ1?=
 =?utf-8?B?c3NiN1F1SURJT1hqSXN6cGJ3ZWd1ekYrK2E1VmQyQWhrYlE2QlVUaTZ1dXFH?=
 =?utf-8?B?eUhyNlJXeG4vODJtT1dvVExtNHN5ckQybnBJT241d2x4UWIzZnNnRDQwMzhT?=
 =?utf-8?B?NWZTVFFlZFhKUHhHSklzQnVCMGhLYnE3YnJKS0h0b3d5bm5jZkhLdTZyZUhW?=
 =?utf-8?B?QnBTSmwvQ0xhRVFWU2x3T25ieGVSU1EzRnRhemRzNlZrUnBINzk3UlVZZXVS?=
 =?utf-8?B?anpsSGF6Qzk4cGgxekZvaGI4TTdsQnZBZ3hIRll4ZmNRSHJDdUZWTGpHa2Jt?=
 =?utf-8?B?elhHR3lOOGIrcFJoV0tBaXMwT3JBSks0amQxL1dQSmtlUzJCRlgwWUVKTU9o?=
 =?utf-8?B?S2lwbzFlS0JpSDF3dTRMMUlYRHMrZlNYMkw1Yk5xZy9XODVXWVAzdTA1YjFU?=
 =?utf-8?B?d0VyOW5uYzl4T3JwK3YrTFdDZG13K2tKdFVEZEUxYkxCNVNzMndSaForanpY?=
 =?utf-8?Q?S2dbUfmtu5QrQGkkvzrIPrh6n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b790f636-bdbc-42fb-9378-08dc4edc65c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:06:08.8230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IUWjxpHl2DBkd7kamckuqMCTzkHhPlWAi/kWnUJaOEhQI0iLXaEsVzbKx3Vlgv3KunkRzEg1Cb6Aw9rtNDfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9488
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

A few nodes were added to soc and board u-boot.dtsi(lpi2c, usbotg), those nodes
could be dropped after upstream linux supports them.

To support OF_UPSTREAM, a few driver changes are included.
For TMU, still use U-Boot node, I will prepare a kernel update,
then back to U-Boot support.

 Mathieu: please help test the boards you maintain when you have time.

Thanks,
Peng.

To: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
To: Stefano Babic <sbabic@denx.de>
To: Fabio Estevam <festevam@gmail.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Signed-off-by: Peng Fan <peng.fan@nxp.com>

Changes in v4:
 - Convert all i.MX93 boards
 - Link to v3: https://lore.kernel.org/r/20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com

Changes in v3:
 - Update patch 5, to drop the imx8mp-evk changes which are wrongly
   included
 - Link to v2: https://lore.kernel.org/r/20240328-imx93-of-v2-0-909f5d37da87@nxp.com

Changes in v2:
 - Add a new patch to sync clock header to avoid breaking
 - Drop the Makefile change which change including order
 - Link to v1: https://lore.kernel.org/r/20240327-imx93-of-v1-0-afab6b31422a@nxp.com

---
Peng Fan (5):
      gpio: imx_rgpio2p: support one address
      serial: lpuart: use ipg clk for i.MX7ULP
      cpu: drop imx9_cpu
      clk: imx93: fix anatop base
      imx93: convert to OF_UPSTREAM

 arch/arm/dts/Makefile                           |   5 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi        | 119 ++++
 arch/arm/dts/imx93-11x11-evk.dts                | 322 ---------
 arch/arm/dts/imx93-phyboard-segin.dts           | 117 ---
 arch/arm/dts/imx93-phycore-som.dtsi             | 126 ----
 arch/arm/dts/imx93-pinfunc.h                    | 623 ----------------
 arch/arm/dts/imx93-u-boot.dtsi                  |  80 +++
 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi |  22 +
 arch/arm/dts/imx93-var-som-symphony.dts         | 323 ---------
 arch/arm/dts/imx93-var-som.dtsi                 | 111 ---
 arch/arm/dts/imx93.dtsi                         | 906 ------------------------
 arch/arm/mach-imx/imx9/Kconfig                  |   1 +
 configs/imx93-phyboard-segin_defconfig          |   2 +-
 configs/imx93_11x11_evk_defconfig               |   2 +-
 configs/imx93_11x11_evk_ld_defconfig            |   2 +-
 configs/imx93_var_som_defconfig                 |   2 +-
 drivers/clk/imx/clk-imx93.c                     |   2 +-
 drivers/cpu/imx9_cpu.c                          | 224 ------
 drivers/gpio/imx_rgpio2p.c                      |  42 +-
 drivers/serial/serial_lpuart.c                  |   9 +-
 include/dt-bindings/clock/imx93-clock.h         | 208 ------
 include/dt-bindings/power/fsl,imx93-power.h     |  15 -
 22 files changed, 273 insertions(+), 2990 deletions(-)
---
base-commit: 280f34ba7d68bb50c0b8eaa040322c1f3b37d46e
change-id: 20240328-imx93-of-v2-f879efef737d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

