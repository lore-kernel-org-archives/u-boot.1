Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA65CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E4F881D7;
	Thu, 11 Apr 2024 05:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RQnlfbGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C1A88120; Thu, 11 Apr 2024 05:23:05 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2C28814E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/mtrJKjU3Qk5LYK4wYODXOjH2LYKIRzRS0g9Ou0EmI0Xx7Q4ItvCqaXiMZhixiwOMUAGZ9CZ1YYB8D93JnJNuNbCzH6/TRGl2cfkRkMQcTMH8BCDx/5Vr9Yn9Xk9a3Seg9u/EJexIe6iU1sXNoHcecUPvRLbYdUAMvXdut9Opd8xGFTo3Y5FhQrxvYOfRuVvW2c1MxQHvnbCJpESwgA1+Fho/Yo5CSCaHySqAMnLcQhR3OlhJVP9z0Ls9XKiddyST15X9miP68STl/tJvN5VxoHD4r97+NmBOTaYHY7LAAL8R+LK0I06egyCwhsnlBlqD6x7zVIUa1vxafYIZsrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc/QPZsrWLgrX1kjfgUx6HQwzm/Pej039bAj8enzuoo=;
 b=RAB5YBMX73hhHVCP3zHVlgbVE2Nn4UDpcmzMZh9r2anWP4ltI728lKexZjZw+iOyD+9+nYJYTxSiIRxswJWt7Aa4ZZV0DDBA+snCJ/6SsRvdKxt6SFlTUcGzUGvWgJeSf0WOevYZciF04NBeZ0myw14Erbf9jtRCiHK7hgitOGiDRIHuO+P5BRIirj6FGos691vmiYY5piV1TEg/VGe4aGs7ZRkzmK0wfVFkpNiIYcgj8DV7Mo3VSLakXTER7R4p/UdNwk3BFC0VVsjvaxUJbIgiqW/865r4elw3qDwli9cRHb59rpCQro8FmDgiSME83ymsWyj0pw9gGx7CPIVysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc/QPZsrWLgrX1kjfgUx6HQwzm/Pej039bAj8enzuoo=;
 b=RQnlfbGmzYzurzG8vjLLxURcyANKkkOdErgmBi3fs9A+80y2jE4hX72px9HG5N6Cx2f8gl2JWjkbI5iaFa7Y0GDtGO4iSFnYvk1pz6SHs/n3RzYTg2/3bJr8tT+qyw0C1SODcQsx+ItGD8gg2ZISSMKGNLigVyIwjB1dTtTerFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 11 Apr
 2024 03:23:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 11 Apr 2024
 03:23:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v5 0/5] imx93: Conver to OF_UPSTREAM
Date: Thu, 11 Apr 2024 12:22:58 +0800
Message-Id: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJlF2YC/23MQQ6DIBCF4auYWXcaCiLaVe/RuDAw1FkoBhpiY
 7h7qesu/5e874BEkSnBvTkgUubEYa2hLw3YeVpfhOxqgxSyFUr2yMs+KAwes0Tfm4E8eaOMg/r
 YInneT+051p45vUP8nHhuf+t/J7coUKne3fTUaau6x7pvVxsWGEspX/Gr0FykAAAA
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: abffbddf-09e8-4da8-a2cc-08dc59d6b072
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iWA5BK9BLJn/oyYVc4XE438w21lkn1l/hdq/e8cZPZx5NEFKhQfxE2MzdzeI9kx/SuaCw06DODGWU+XQzQhvfWSYwKih1Y/gLHNLnctW8o8ctRLZkIXtHkpLV/RA/uz/fIzvlJgaS8kcOL67cF0GB1BFbBQu/i7u3RTJEPPQvdfv8YaPxxbQWFfHD4/e+e8ChA3T+1fyc5SVrayFKu5cFUoQ6q8qsd8fDhFVxsuBv/0rzMzt4XFaCqARZz5q79mZInFjOf2SxxKMAbpziYbeVhwKnDgoMdFsIjkPj8Ek+oP9XCFhi6fcM3f/Gq/z8dXUR2F8T+cyR7An0PMHrHgnkIalZTU1bS4+JM7Df2WwVcugeByzjpevoeFji/qiksrA/3MEqDNAHNw+qqS7WpO0g7zJ4obpqBl9hzIu4AtmEqOLVkhRea6UHbT42i9nY4btZFCxp50kUCkXwmz0mprC2ALaiQ268LH00ZP7ohyDxoSMAy++Hv38pj5jJRZJz6W3dfIdwV1xGRCyawlyq4BbBI+coBI7o5U1lUfOnLr9QWmXzTOmczvs5fStqY20QBFm7wgWDYGJGtzy0nVwDBK1Mi5Xot6I6pfFSZ41XNXkJyXmvjni/lPFCX9/jL100dTsHwU/uwwYTrZGwbL+nYMnjkwXsj3iEWioX3OUm2fA63YhbadEU0H8kBElP7rviGQjvOv/fdGadLPP0fSdNy/bhX4iEBaQFXJRP2nOAEEmmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T212RVl0blV1c1BUdmVhK3RDdHlFODRSclN2bWUwWXpRSkRVRzY2WXlnYm5k?=
 =?utf-8?B?bU9GUDkwVE9pUUozWUhIbEE0cnFndWYrVFZyeWVJUEpJeURZNW9qUWRTMVB4?=
 =?utf-8?B?bUFYVHlURzIva08rYUVERmtZanltS0lXVjBPVGVqNmw5eGRDNkVUOVlsbWZQ?=
 =?utf-8?B?aGpVb3dzTS90Vk5vMk5FcHJMUisxamt5SDZvRnNjOHVWYUJ4a3pyNjZkL244?=
 =?utf-8?B?aHlMTjNmYzk5NEk3UEk0RGZnRHF6MFpXRE81WDJiTFNaMExvT25kalZTQU52?=
 =?utf-8?B?a09kaWplQ3dFcmxYQTAyVWdBSmpqcDc2V21ubEluRVZLanRVL3RSaExOOXlH?=
 =?utf-8?B?dHg4eng3SHA3SWFFY1RWeldsR004WGlPaHRrWHdzNEV3ZXJoUEhWUUVWcTlH?=
 =?utf-8?B?bGsxeG9ZWjQ4bWxwaTQrZFltQncwMStKajRvcjJ6Z2V2NVc2L2xXbDVTa2dl?=
 =?utf-8?B?OURlT0VIMlFzTUhzamtFd1hScHc2d0tPN1F6cHZJYkNuOFlPNWJRQ3QvWm56?=
 =?utf-8?B?Q3RxbDBtekxjZW4rSjExdWpDalFjSGtYbnFhMEM4WEtMY3p5bEEvUGRaRHd5?=
 =?utf-8?B?amRjcnF6ZWJYTUdXV3dXTHE1QTZRaFcrdkcrR2psYXZFQWtGQ29RRlRlMHoz?=
 =?utf-8?B?ZG94cW9vbFl6bmlKVGZtaXBqNUU5OGZod3M5dk50Q1NvUTN5S0ZUbUpJbXNL?=
 =?utf-8?B?QzRtV0FVZnYwSEJtUFFSV3V5dzU2MjNJTXBBc01vWWdLVUc0b1c1NFJvZlJC?=
 =?utf-8?B?WFBhQ0Y3bUVOaDMveC95VC9OeDV0ZUJWMG5ReXA3NFRLVlBEdGhFaXF1K1No?=
 =?utf-8?B?Z1pVWFV4ZGdyQWUzcnJXM3VLTlR0TldoZEdvMWVLOEZFOURRcmUycXJlcC9F?=
 =?utf-8?B?SDBQWDRtSHdTblZCYTkzamw1dGk4UVYzbW8yNy9HaXBxQmJtbWNGbnZKWXZt?=
 =?utf-8?B?enlyWkt5Q25tbHdOVm1YWHhFbFl4LzRZOXE4TGJndmZMNkp6WnRlVStEU1ht?=
 =?utf-8?B?T0d6MysvNGhoOFhJVldTOFFTSkFINVpPeE5USFJXUzVoS0dudmplU203dXFz?=
 =?utf-8?B?alJMc3lTWWJ2UlBTOE1pU2dqaDVSeisxeFR2akJLME1LN3o4T201amRDNjhw?=
 =?utf-8?B?emhQQ1JyQk5RTWN1SVJNQTBMbjZPeVhJY2o0Q2x1b3Y5RkJlZmdhRytqMTJn?=
 =?utf-8?B?Nld1QXRoVHI4V2R5a3RMRFZXV0FGdTJ4bXczNnhvTUo4TUR3UmkyNTFGMGVB?=
 =?utf-8?B?VWtFa29YWlNtNVBJMWdTZ1JpUjlJYVNPOGJEMlVMcGRvTHJUM1g5OVVxOHBl?=
 =?utf-8?B?bU5aM2ZKT0hhSFFJZFFCdzNFbTJTNDlUUUpaWHVUNjhCSG5zaE43a0M3eFk1?=
 =?utf-8?B?STFrSUp3OE5uYkFmVTJid3VxYlVFWkl1M0ZkQ05hWWppNUdlNDhrZzg4bHdj?=
 =?utf-8?B?bnZUcFdaNlVqSDRISVI1cEdUZVBubmNqQ0l2Q3dNY05yS0MxS3ZrSHhORWpZ?=
 =?utf-8?B?Um15VWVpUFZrUkNsTmJSdEdQWG9WcUE3TmdzYk45MmZsMUd5NVFNWnIxVHdD?=
 =?utf-8?B?REYrN2lWTkRuSUV6b3Y5R2RQa28wbXFRaE80US9YandvaU1NaDRMUk9wdkI4?=
 =?utf-8?B?R3lpdkV2WHRaZjdBWk4wa1Z5U0c4SS8vZ3NyUVpGMTVvWDRMR0Z3S3QzUkdo?=
 =?utf-8?B?cHRURi9ENDhKUEl3dkgwRXJsd3dDd3ZGRDliWFN0ZldxY3FoL0F5TjhoQWRB?=
 =?utf-8?B?aGdsU0tCb2ZaamZEaWpReVQ0Nk15TGVWa1pZaFIrcldzbWpON01mejIyREJS?=
 =?utf-8?B?b3V4bW8vaTZPcWxRK1pFenRHNEJzbmQxQm1tdjRTTWJHdGVaOVVXaXRTV2J5?=
 =?utf-8?B?dHRaVHBKWndVcjV3VDc4RkF2OGI5cm1LZjlmM0Mvd0p4MWVwck9mcWthNnZ2?=
 =?utf-8?B?R05zVExtaks3cVd4TU1WR091a0hTVnJDNlpNbmFTTWVWTGJ1bVBnUDF0TWRB?=
 =?utf-8?B?OGtCSkU4eFF3T0gyT1Btc0Q0NGR3WW9VRzlycnRRdzRRZzhNcGY5emtUdEJC?=
 =?utf-8?B?eHNKT1FuekxmR0NCeU1xcmRndUJiMlg4V1hlY1E3N0s0YklzK1huY0ZIcVBa?=
 =?utf-8?Q?ueWeVZkBbISPqfGl93Thcq1bL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abffbddf-09e8-4da8-a2cc-08dc59d6b072
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 03:23:00.0899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7rj9BJQeYP2RHTKX66lPh4WmKZ2f80AncEFjoJYeEl2/lb4MerHf480FRAAD/0V2zycO2o0TC/AeSRm93+sWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
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

To: Stefano Babic <sbabic@denx.de>
To: Fabio Estevam <festevam@gmail.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
Signed-off-by: Peng Fan <peng.fan@nxp.com>

Changes in v5:
- Correct uart clk checking
- Link to v4: https://lore.kernel.org/r/20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com

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
 drivers/serial/serial_lpuart.c                  |  28 +-
 include/dt-bindings/clock/imx93-clock.h         | 208 ------
 include/dt-bindings/power/fsl,imx93-power.h     |  15 -
 22 files changed, 284 insertions(+), 2998 deletions(-)
---
base-commit: 777c28460947371ada40868dc994dfe8537d7115
change-id: 20240328-imx93-of-v2-f879efef737d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

