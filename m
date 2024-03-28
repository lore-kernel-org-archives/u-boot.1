Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41E2C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB826880A7;
	Thu, 28 Mar 2024 00:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AOI8TOmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF853880A7; Thu, 28 Mar 2024 00:47:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C6288060
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpneYVYo/ezapcjPOipfHeFJhKEg3I9fEH1gjU4MYFOVYJMoZiy+nfZFgXyhPY8weAabs0Ki4lVJp3eUOj+TdiWTVIQVA7uwbM8s5by5s8JDKWyAxz9Nqnk6y+nmcfE87ZRJEfxpMQhvMuAdP40UyVL8fGgA8ssqc+X+DmPZPrRZscH8TKDJQapQ2KC+XzbJ5GEvkjep43A4kuKjzEY5whR5Zudjl+PEjI5Im055EqJbYRWc2jzLpiBg9evz9j3BjhwakjB2jF9+igMzTW42QiOqRFphkXHtSn6KGEMMzCe418pCgHmj9LrDxAKs6gPAflsXsoV8oKPC1dSwX+E3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CND+hy9YJk/B/QuDQISprB9nFeEIpOq6ETE5+TRrrA=;
 b=cIyWixW0jRh0OE9whD4lWxvw+9eILs9jBbDcLbIQX8DHNlrmfFPnvuk3MBaSuCn7S5iCysMBpQ+Tl7CMS8UOF6N6iwKVI9RnwW4olRQqhg1Um74cKH6tDl4WlD5h599lI9Dy+XksUrCxXlPd0nSz8RMd9BJqNCDTOdfYTscMXQFDzKzk15G8WS81xifhZu3dW6yvGnGdWbK9djt/4Elm0HZSO+vfUujGH4uTmkqm4PzhjFUKew7XKxmZg2EJPuQF9MDQU6TDxuCEeX8HsuSBDshcCaCCjdwVjwNCzxF2r9HFlPqcN9ZWlsl+WGEjUczAGpvrvwtOZwkvaxqYmrIa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CND+hy9YJk/B/QuDQISprB9nFeEIpOq6ETE5+TRrrA=;
 b=AOI8TOmgcZ8fJhP2GglkOZ8HYPAzCK9D4HJ6WtOj4/7GntgA7rzJr+L5KxvBRaQDgko2PLRwexZGW7wPsidqfBX3J90oGKcYjuNbd0lhJSD517RIpHLeDp8Klkbfi6uMK9d1wuWjt+MitlffpW1w0lJP/L/3lbx832atUf8rTQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/6] imx93-11x11-evk: convert to OF_UPSTREAM
Date: Thu, 28 Mar 2024 08:46:46 +0800
Message-Id: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPa9BGYC/23MQQ7CIBCF4as0sxYDQ8XUlfcwXUAd7CwKDZgG0
 3B3sWuX/8vLt0OmxJTh1u2QaOPMMbTAUwfTbMOLBD9bA0rspcar4KUMWkQvLoY8usF4JIR2XxN
 5Lgf1GFvPnN8xfQ55U7/1D7IpIYX11hmnVY9o76Gs5ykuMNZavzJLuY+eAAAA
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f06fb2-a482-4726-7a39-08dc4eb839ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIwWiqZZLSoyAK516a+QtL1Xjn74XoTY9HbipWVfFwH+gwEJIdKnmIWx8De8hDL7MoWcp7y3ckgr+uqhMArH3Qkd1xihXGwaqgFLlC+byquPt39NdpGytsGfKcFqW/RwydJ6nSq0uQZTKbOD7WnU2lNjIR2GODcAj7bwOIKRuziljA3/UFBO8tpxOd5w8Fn8noA86XHOJnaU+FxwxacHvGus0Jy5/Y8QkffqKDXY7qvh7Vfs7nvGM++3iJcoyq6/vvH/OCijjdIv3dr69Cxrv+N/qjL7YwYeSy2Ayc2sPuWlzLaVI7sqSeJCMb/8uH6y41tkHfSgd7IU0ESLjTfmkA65amnEBaa0A4Dg9FPg2CUWG3ePBsXN0Rqf7DsJa9yIXfxXGOzuDio3et5VL9ry6XNeLp1oQgGp0Zokcc5u/0f+TENzt400VTWednL11MKDnSwp4fosqe+EiYFc27SvYK+HDAgPTZRvFQVGxPTfQeea6DWG9dBEdUOPr1OMUXcFC5k893Owvf0grEX9Tt3JPm6C/wyjk64iwM+V+Y4csxZQMCv4JZAQYaNzzzui2i56LCkYis8O3zlNh6k73B7rjytwe7eFAoV9UABvLvvWccw8yIWC7U+B0tvvCeveez3rcxgXLvJlGtYMWyYIgR4ba/xGAyxkHbmtei5JYLxyEfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpoM3JDcms4dndDUkNhVXB3dEVObjV3dFFxWkxMREtBZUZ2RlI2WXJvREts?=
 =?utf-8?B?NHB6WWRKWkRPUXhNSHBJTVJucjVLZURSK3FMNGh2YkpoS28vS2tpVXRyM2xi?=
 =?utf-8?B?N29XMHdYRERhZkJDeDhXclFqYVlvbE5DSTljVGNyckhWYVUwRVhVays4T2E2?=
 =?utf-8?B?dW1mQXVRdXhnZ1BEL3VIR09oOGR3emZzMVJRZk1taHA1N2htcnpMUkR6a2g4?=
 =?utf-8?B?NkpIclR1UFo5dnZSRzFZdmJJVW1vNFJCdFZkYTBVV2REeWtxS21VM0NKNVlW?=
 =?utf-8?B?SWMzWVE2YjdHRjBPM1BvV1lHVUtJS3MrbGNSbU1zbWFna1prb3JxVWlTQVhQ?=
 =?utf-8?B?bVRZMmZRWGxDYjR5V3prSTZDbkxvVVorWjJhMFp1dUNiQmw1eEF4MGdzMi9Q?=
 =?utf-8?B?bGtIY1VZVkQyR1NYVHlBN09JOHN4ZnB1TFVyd1paYnZlR0NXY3dyWDI1ZXBn?=
 =?utf-8?B?MDIwSzVHTHkvY2FJQ2wwSjNBMGcvSXB0c2QzMEtXMVZ0ZmZPaVB2cUxVN2VB?=
 =?utf-8?B?VUFNMkYvTVUxZmxWUy9vY1R6TGN0ZjFldVNPU2thZXlEL0hSUzdyODJEVTdQ?=
 =?utf-8?B?K1ZKenlFREpGODl6WThDM0N2cEZFMDA5VW1oOExFd3RtdW1sOEZkNW1PM1Ny?=
 =?utf-8?B?N2ZXbEo2dVMxTmIyNlhlcklMd0xtb1Eya3N2Z1VzTjRhZG9BU1BvR2lEM280?=
 =?utf-8?B?cEFMazdsdkhlOUx6MEwydFlINnZpMi9mbEd0UEtGMVhHYm9BWlBWV1lSTU1V?=
 =?utf-8?B?MTAyRE9ZMi8yZ1UzcTBwR3piWU00MW13cjJVdEJpOTJwZ0J0TEFLbHByMUsy?=
 =?utf-8?B?L1RpbEc5a04xNCsyMlhsZStQbmtTQ3BSa2FwZndFOWc2Q1B1TEx3YXE1ekov?=
 =?utf-8?B?VzZ2TnBoR1RGM0FiRUhqOFNxazFyMjdqM1pQQ0U4alVxM2RNc3pPY1MvR3Ax?=
 =?utf-8?B?bHpqOVhKcDNvNG13Qjh5b0tVSGZnejV5MFk0aHBUeHY5cVkxUVNnMVZZNjNw?=
 =?utf-8?B?SHM0YXZPbDFTbThoUEgraXNOeERWVHprUFVPMkpUM2VqekVOR1B0dWMrRWFZ?=
 =?utf-8?B?N2FqNnJQTE0vSEQ0TGpjandyQU04RWJhS2JZVEtLR0lqTFVzMHJPUGpLZTBR?=
 =?utf-8?B?QU55dzhScUZ6U3BlekVFUkdtZ1lUMGRCNDR6cUx3cmUyNXNGNE50SUFER3V4?=
 =?utf-8?B?M1hHTGF6VnB0TytPR2hHbmQwVG9hYnBtaWtacTdJemwwQkY3R1JxcEh3MXRH?=
 =?utf-8?B?UU9FUHFhVmgydWpHeVZpd21hR3grUEkwSG5kb0s0Zm0wd1ZZUFZyWG9IS3J5?=
 =?utf-8?B?WHRvNkx6UWplMkRZZ09SRFc2U2d3Z3NubUtra2YrVU9rV1BGbEY2dGNRRFNt?=
 =?utf-8?B?dXp0OWZXR0EyMHpBOEtXLzZaZEg3N1FGMmJsaEswc096Ym9LYm1MKzRIN1ps?=
 =?utf-8?B?TWhmeVNGaElUVWI2QWhSbmF4L0tiRTJOYXc3c2p5THlSSUJUVlRrSW9sZG9y?=
 =?utf-8?B?OWIxVzZkZ1JkR0h0azlDM1VQQzFqNmJCeDRtYk1qRHRMUWFjRzhkUGpBS3Ux?=
 =?utf-8?B?Nmh6UThqUzJoNWtkL0dHQTlORVBKVGlKRTRab2pmdUh4V3QzRzJxZklaNWRR?=
 =?utf-8?B?TitzZXFyRURmMytEem4wUUxKU3JCM2lRYUVoVVlXeFNvWkluZWN6U25UcSsz?=
 =?utf-8?B?dEZsVmZxQlRhazRjT0tFdVJEQ0hEQUtzeUxSRURUZE1Zd2JwbG5jOElvYWQ1?=
 =?utf-8?B?My9rNS94UFFuVTNJRlVUTHZEbTRuYUIxa3dRamprQzhIOHNCWVBxRXdYTjgy?=
 =?utf-8?B?dEZ1bHc2Nkozd2VlNUtOWTJyYXdwQ1NPUUF3Wk1zNXhsMkNvYlR5VEtwWkpT?=
 =?utf-8?B?RDdHL0svNUF6cnQ1NEJDdkFTYkFTUzNqRW1uYUNmMDlHS3RzMk0zMS93UUtI?=
 =?utf-8?B?SmxXOGR3TnJxcWJjeG41TThDM2ZxeExGZmdLMkdHT3JoYTV3S2tsTzEyOTlQ?=
 =?utf-8?B?OXBjc2lVQU5HQzJMWU5sU2g1RGUrZXBOUVlDWTZSV3hBNXJ2eVkvQ2I4Ui8y?=
 =?utf-8?B?VzlyQXRFVDREcERzSi96M0hRd2V1RWEyNjljbUJCSFc4YlUxdktJbmhxSXpq?=
 =?utf-8?Q?EUfhafLlvXfNRmaCJoEKPMTOW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f06fb2-a482-4726-7a39-08dc4eb839ff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:13.7291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE29xvz/7MSWWlJayCYDwVfkqshBPXX+01EP+g5dySaUoOyWN3ymlWm4yQGcfzc85YtlqvacBII78pVHog7Otg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

To support OF_UPSTREAM, a few driver changes are included.
For TMU, still use U-Boot node, I will prepare a kernel update,
then back to U-Boot support.
Add the pmic nodes to x-u-boot.dtsi, since upstream still not has it.
imx93.dtsi still kept because other boards still use it as of now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add a new patch to sync clock header to avoid breaking
- Drop the Makefile change which change including order
- Link to v1: https://lore.kernel.org/r/20240327-imx93-of-v1-0-afab6b31422a@nxp.com

---
Peng Fan (6):
      gpio: imx_rgpio2p: support one address
      serial: lpuart: use ipg clk for i.MX7ULP
      cpu: drop imx9_cpu
      clk: imx93: fix anatop base
      dt-bindings: imx93: sync clock header
      imx: imx93-11x11-evk: convert to OF_UPSTREAM

 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx8mp-evk.dts              | 684 -------------------------------
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 ++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 ---------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 +
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 drivers/clk/imx/clk-imx93.c              |   2 +-
 drivers/cpu/imx9_cpu.c                   | 224 ----------
 drivers/gpio/imx_rgpio2p.c               |  42 +-
 drivers/serial/serial_lpuart.c           |   9 +-
 include/dt-bindings/clock/imx93-clock.h  |   3 +-
 13 files changed, 185 insertions(+), 1240 deletions(-)
---
base-commit: ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606
change-id: 20240327-imx93-of-56ef2b96f2e2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

