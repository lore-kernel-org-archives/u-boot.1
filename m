Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B01C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DCA87F04;
	Fri, 12 Apr 2024 15:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VZhxGgzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79FE888027; Fri, 12 Apr 2024 15:24:52 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AB187915
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G99BETizwgdWAjxQpN+fR7BkM2ZfaWL+Ctdsq6ZJzNsYrFzmUnZ5C0lM5BMBWK9oNlJ4px2XAOoC8Y5tRpGz7mSmz7trSfOPiRVT64bhsDyZzT+hn4JxkpVq5GgHhBQnJKsjQKK/pVJfDbM66m+TAEMb0oS8EzxFHathsXHdCevc33pKXIUlXMpC55nNnjQWqBxB28/eDr+I2O81TDM7w0dwvpxeTWGOMnCBSrXizoA4bU4ttDX9WjOMgspZbK9UW/Itwppf+RBlXwhepNHVUmfQzvhWKjsFLkvHExMHlvNh/dWduCMD2MQNm/xbJLIvYyE6ER2RqxXX+dgXpLi13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHuEhU8TLKhMevhFzgoCn9P6TJQpM+Q0fEgaIzFiDrY=;
 b=RSMFR0p1lC+vlaDZhqyNhObs3XkDnyfE2MSqE7N+HQaiHAiIvLkWgx4a1fAMQZbVtImV3Bzq5Pq9DrSvTOvi1f8p3kAG9iIxTVQ+5gZhgF948xO+PkI56TzIP1pRrjtlzkeg+HWhuyWs1yLP//P3Eh9P7TSPsiCsD/RaCA/OpEsHhUDght+DdxFHL6Equ4RK7YFMp091EW2+1jolvB/u7Xbwz3Sz1GOslAUUb5esDa/+NKnVPNTT4PY15x/6u+XJ6UHdb7Jl9eozqVNUuHcEHcAlcJjogCQ6Qw4VOcOcXLW35EWzl3XIcWPsGqj1Eg1O45ybusp05fxXqExA/gIvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHuEhU8TLKhMevhFzgoCn9P6TJQpM+Q0fEgaIzFiDrY=;
 b=VZhxGgzx5nNHfHDKcE8P+ZL0IISt3pEF2ByNuAr43LcGo00QTOwtlYsEST97t1HzkwYTjz5M+Hte8m54F6Z4XHiAqOWU/KcpYdsUhhGuJtoU6AxHA2WA+1ba3WLUwbfs6MEKkDrhQjtXiNDcNYCLIMlawx0a6HbbyIN28vWk9CQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:24:48 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:24:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
Date: Fri, 12 Apr 2024 22:24:50 +0800
Message-Id: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJEGWYC/23MQQ6DIBCF4asY1qUBBlC76j2aLizOVBYVAw2xM
 d696MY06fK95PsXljB6TOxSLSxi9smHsQx7qpgbuvGJ3PdlMyWUFqAa7l9zCzwQz4pTU7dISDX
 UPStiikh+3mu3e9mDT+8QP3s86+3938maCw7Q9NJ01jiw13Gezi682FbJ5pBayl9pimzxAc5qI
 mnFIdd1/QJintzQ3gAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf32ab7-8697-4e44-6d5b-08dc5af3ed11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsHdTxFwQtCnhQQaZhNXl4WzuStijajE+7czStdhYYevBDNHmQCw841TkkNsvAz17wOBiWjblVgwMFYaXf+HUXUReblaWVRZl0+azz2ZfEGavH+8xdsQ9XMJ2tLRH3IGX3QS12TcgIcAyVQc5sZLjVqy2+Q6/MeKsglzCqvz0YTd7BljGecFzVZr9Ap+vkMqKTAOe76pnEiik4k9e90mFqIHXQlWPThVVYyPwdznASVyPQhoQiGirhNOxnuMaQMw2yeGKUi+cEz0AlAUzFoNac3fB5xyNz7XCJSmGNu3qjGWiLdKbmNCK8WUxZ0Gpgq7U/qefgg2SI+IC8npz/yAreOIo6d3ykI80vPYg3U3H/oE7djRo0lAqb6vID51uHTbWkeIeJFlmjwbj5OP01JHRwnUNxxSJ0lr1SyK+elCJbVQOJL8MYjxSBMFboanQ2DioNa1uA/wLtwpV1ecIAF4fEkQ9QMPDJjyB3gnrCcrprZeau6VWlY2+D71STXSVbv3uwbf2BkWfdbHh/yvC3aTdskQaJv/RT+5XmqwXPsyo866oe8npuXWTzZIUmrB3+AgLcwg194QkKLfYRG6eIrI4fgrx1egMsn5HdHMZCesm60WBlI2HKBlYHb7A/YbLjP0V5Q8iKU7ld+Ws/4u3rSLNUbNeCDc8PsfolfTHOAsLkLHTMWkW1iqm5dYRDHNsfHE9r0kuNmjvFEWHj/QX9a8qIDuMlCfxlkNA7JZpfdMKRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9GbDNjWTZqSmxlbWMwTDRsb1JGcEVpV2lmVG13QWhvdEhjeldHY1ozU1Rv?=
 =?utf-8?B?RitTL2dKeE53UFNzQklTd042UWxCVjJzZEdmaitmcW9uS04ya1h5U21HUE9w?=
 =?utf-8?B?SkRhNmZvbFJXMUdjdDZicytZZHNiSnhhaFord1MxK2pPZ24rR2p0cVpaa3FM?=
 =?utf-8?B?cVdzNG93TU1EUHFSS09hbUxVZG5MekEzTHYzQWJTNnY2c0VvWS9uSURYNWU0?=
 =?utf-8?B?Y3ZyTGtvRnd4Nk9Md2JXM2tyUmlCTTZOQWEwV0RlMGtobGk5eDZiRGtsOFhl?=
 =?utf-8?B?YzFFa0cvTTZmTFR3cnF5UDc0MkxPbE1aSlBSbDJPeHFoeXdDOTRqY2ZiU3JT?=
 =?utf-8?B?V214YXY2U2ZqYTBwcC9weXhwZzZ3elpmY1RyU0Z6Q24yK0FVckJIQWlXTmhE?=
 =?utf-8?B?Tm9kYlExMnJnb01ZdndwNWNVdzVsYklHelltbDE5UERtUUxhOVlNMGp3eVhq?=
 =?utf-8?B?Zyt6ZmMwczg4Vkp0VDZ6REpkVE9OamdtVTZwNmlhbERiMDl6QlBpMG9GMU12?=
 =?utf-8?B?LzVadjBxdHJnS2hJaCs1WFpLOVA0eVAyQ211akV3bFVyYXorQTdFTWhGazdT?=
 =?utf-8?B?SEZpaDliU0k4NFZSMEd3cCs2cExacjJTbU1KTTNZcVVENFFBSWRZL0s1Sm1Z?=
 =?utf-8?B?dzRPUllIT1ZuSjNqeXVLODBidERaMmMxK1kwbzNSOVRrS1dGeU15ZGsxdlVZ?=
 =?utf-8?B?TTRraDZiQUd4K00ydm82dktuN1V3Z3NpYUZRTTl2OXpnOE5oS2NKeEpHMGMy?=
 =?utf-8?B?b25ycFV2bmtKSzFLeW5nSm1Ed2hwUzFReUNOMmJvc1JDZE1TZGhrblV1a045?=
 =?utf-8?B?UitSRGFtS1dnMEl3eFVUSGxpeE9CTThxMjdHMFdPdVk1eUplTUZiVDJWd3lV?=
 =?utf-8?B?SkZlSDRVQTFvWHBRaU43QTE2bTFQMXhhQUIvbDZBK1lkTTZUNVNJd2VGcFpU?=
 =?utf-8?B?aUp6VkhRbTIyMFpxNEUyUEFPZHF0MVFUclAzVmdsS2ZyVWJtd3o3U3d4TE1D?=
 =?utf-8?B?Rzg3UTlhSzY0UWxCRzFPbFBlSjV5WDNnRDJyUllhM1paWVRxbG9OeW9PS1Av?=
 =?utf-8?B?WDVPNWxJR3FXQi8yWExLN1A4OUlXL2xRaGJpU2xMRE9UUTNpVzNFK2NaSEZz?=
 =?utf-8?B?TXExN2V1T1F4TzlYVkVvd1dUOUxkV0hIVWdIdThVV0pUdVVLSEhCbmRLMzgz?=
 =?utf-8?B?MjZ2OVZDQktvbVBoWDVsa2ROc24vSy9PbTBXc3lQeVQ0azBEWnZGUnpyeGZ6?=
 =?utf-8?B?YmttRkFPS3ZSMHVqczdxWXpOalFTT05ZWnRMc3RsUHVKaE5zczBJRVZZOGZT?=
 =?utf-8?B?MFh3N25XQzk2QUwwN3cxakZlZ2U0WUNvd2FQYTlFSUJqZmxqRXpZTUVHLzQv?=
 =?utf-8?B?aG1VS0ZCaUYyaE05S0lGc1h6dzdkbkRmVjJQaFp5bkZRR2xkcmlCTUd3bU9G?=
 =?utf-8?B?L29NOEg2YU5zSGh5akdGNDYzSzlpYzFIbDExR3NLaVZnUC8xdE8wSHQxWGpV?=
 =?utf-8?B?QUlLeFVKT1RXaUZZZTJxUXRmNUFwTU5uQUlLR3pwSVM1Sno2ME5ianpENmdN?=
 =?utf-8?B?WFdFay92T1hMenI0SUY5ZFU0TlBuS1hHNkJEdU5TOU9mek8xdXpCam85c2hx?=
 =?utf-8?B?YUxpbGhBTHVVTU4vQ2JPN01ySFRkcktibGY4L0J1SmdPYXZKVGh1dHl1c1U1?=
 =?utf-8?B?N3JKdFcva0ZnMSs5Q1FERFlURCt0SS9IUkFOTzhITEIwRHc5ajA1Szg5RTZH?=
 =?utf-8?B?ZWxteWJyNzhRYUhKRUduWVl3Um9WdWI5c2UzOGZKWjRBL2JJazQ5MjNtbVFT?=
 =?utf-8?B?dWY3VjFUeEgwRWhnSXJ6QW1jZE1LUzFaLzM1clkxZFFrTWduNnVyZGg2SSsw?=
 =?utf-8?B?UzZvM2RXTmpqajdXQWxvU0ljRnVlc0w0UWZyU2xQcFR1cG1jcGVpY3NReVpy?=
 =?utf-8?B?K1hiYVRvVWN5YnRIaGhJbXlvVzI0L2UzcnFQQTZucVFyZWJKWTFhSHZsQ0Vh?=
 =?utf-8?B?RlFwcTI4N25iNHB1cWdzcnNwNWMweUt6eDErRWM2anZXWW0zbmxkdGhodmpL?=
 =?utf-8?B?WVc5cis1dmZHdVA0M05kc0FHdzVVaUZvN2wydnJmcFpHTUhWbXVyaVNDb1Ey?=
 =?utf-8?Q?mtBjT65Gebq2StOWrVUIDWOgn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf32ab7-8697-4e44-6d5b-08dc5af3ed11
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:24:48.2559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bu1svj7PV8/OSMwLz3Vv4yts7wVGxkmVQrWRZR9nMHhlC7oHlLAZeehXzhn2XCmD1aBuzrfkhwjeVfSDQMoGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966
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

Changes in v6:
- Update the serial lpuart patch, to rename per_clk to clk, also change
  the input parameter u32 *clk to u32 *clk_rate.
- Link to v5: https://lore.kernel.org/r/20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com

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
 drivers/serial/serial_lpuart.c                  |  42 +-
 include/dt-bindings/clock/imx93-clock.h         | 208 ------
 include/dt-bindings/power/fsl,imx93-power.h     |  15 -
 22 files changed, 291 insertions(+), 3005 deletions(-)
---
base-commit: 777c28460947371ada40868dc994dfe8537d7115
change-id: 20240328-imx93-of-v2-f879efef737d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

