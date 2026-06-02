Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6565FCD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2D684903;
	Tue,  2 Jun 2026 12:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jTANuAm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C2E8490B; Tue,  2 Jun 2026 12:04:53 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92FA848F0
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3agdrNHFwYLXm1NThYZu7jCFN1t5LrQW+AbGc+XDvnRNkE4kWGZiQTnR7eLGx9yQEeh8cqXyrvaiqBNGSLVUT1kd4Gh0JaS1Kj7jI2JJAkajKUMjEw/rZhszWNYbDYlyDjQkT/J5qMUJMzPqCY5Geh7Se64mRd2tcEoh58m3mIN6wrXG2f6y+5HOfC5eMon2qE7i46MbPsaxNhc/jFrtOilruysb7ZIILul3TMWUnTiytQDyH5FjTU2BLV0rPLPxEgX6FC2+yX3xGUxWT5Lhb3zZ3A4IePSyVVnpN/E9El6fGoxCtz3rzlgGQ9uLnazG5qchpRh317zMGIKzIceJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiIrnrkSgwUFZLcd9V5hDMzcb1jVmnXAV93f7Lp1v0I=;
 b=xTuTWzpKljOHbj5YYaVeRME3AtQw5ztgk4KA2na2Q1SOPD4nZ5TvQnWtmaZ0lUAHK8zuFCdad5pAf7CBchTCCsfDuQcRmCO4l7SPxhS63SjDejwelrbuUMt0aFgxlA0flFYFz9hUSQjhzAE9td3m/Sqz9U2ZKmszUXMeuanYM4CNgi2cvsC3Mp67dzGeA6alaoR/FUBoDUh9DWfP5H6MY5tFIGo0peAzFh7SVX9I2SVRGi/+N35xwZZZQtzYscoixsmgw3jUZ2mfbRUQr1NNjcdeEVmVjVvFyn0HzIMIgn0CN3uMaREt/8xvfvqUxdm7FFxSFfLiOBDb9ezvOS12fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiIrnrkSgwUFZLcd9V5hDMzcb1jVmnXAV93f7Lp1v0I=;
 b=jTANuAm87zilgBIZCANRTyUZ5l6sv+LG+lNGvbYiacXeFDfiIcYWrdoaM00A0f1jV3qi4lljG2DXty7sl5e+tyYz+2R0/DIGg9d+zE2X12vuveJWTbw3gq7uconcObUKD8CzmmpAE5Y8FG4WWkmqSiBsV1agKnpY4xVDJKhaqVnv/R6KsrwyhzJ0Gcbkom60Z3X9bkEQLdKy1g1FI0oeD/cnyA2RZcm5un2mDmOapAUSanxl4Dyxt32G961OY+WvnQRI/ul+cVcor0KJAqvr5Znpo9LcfV/f73NexzTXYIcPI6CODOAJxuWflru7OKfKMUeKxh6UUjumjWbGoD32fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:04:49 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:04:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/6] usb: Migrate drivers to use dev/ofnode APIs
Date: Tue, 02 Jun 2026 19:21:39 +0800
Message-Id: <20260602-devfdt-usb-v2-0-a587ab36b906@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMO8HmoC/23MSw7CIBSF4a00dyyGXhQbR92H6YDHxTIQGqikp
 mHvYscO/5Ocb4dMyVOGe7dDouKzj6EFnjowswpPYt62BuQo+RUls1ScXdk7azao/qZQDMJYCe2
 wJHJ+O7DH1Hr2eY3pc9il/61/mdIzztSFEDUK7RSNYVvOJr5gqrV+AcgCGvuiAAAA
X-Change-ID: 20260526-devfdt-usb-8a17a2383cd6
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9f4546-7269-416f-64ce-08dec08e611f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|7416014|38350700014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: fOWwQMfdMZ6yfWcIiK/jFbgQ9FnoWgS4pj90FW8TZRtumiHfPwM5PO/rNHVbO3wCHN3euQPqtklVqYPxilj+jHX/ornWjqo/ecHfriEEFh2UI9ptqnhZFzD9hE/YIw5oyODn+JMihXsUse0nTrgqPbTMfUaU/CH0TDGJAi2behLNvi6WaslJKX8paCCMvHPm/6q3FR8yhinr8stvINiuL7C/fzhmiPzAqbOJjDncqXOMmqOqJWPypghzdVuBIK3KRomqFH8HzxxF6gGiTHFNO8Imv/bAfeD7J6fdGzVCTQ5VFK0Zb0XYuzWdGWfGU7sO4WhRgbV3gx/l7aIXEJC/Qohmqm//9Wyp9KiynrPhguaUcR6IBA34ikelT8KdWoESHHSWQ0sHZGS6LV577toNZLWTlQfmaMdoxQWa3PkgLcXIpMUo5uoP9sgGsieL2asrrFPTMVYt+f8/u4zOjSCWt3buZq7fZGJutPQOFRu1PQqnw+oOr6mxaQayZ1d1nFRbtE9brTFnDG71YhDPAF7R094rUz8eakL5lFD7O0/kdNiN4fb7cF1jdDt3UjzcBvliqCqoUOhunRdVGfshl3z/+oNpzXCkWwZ9JAoYX+5NwDm57Vaxd6es25Zm3r7F42XB1ZhSa23bfU1de0eIkMbT0FS4mpYImsq/Z2G2Jn0PO1ffEY9aeQb/Dx/ngv9Tmz3OnJiZrETDFa2jQtWd3S5axIEjrrWqhz2+HlHpYt1kqYGeeR+ZlOsw23ECtyVwSz1D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(7416014)(38350700014)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJleDZCSDVXWjRlb0xBTFo2aytxOGJ6WmI5eGIrRDE3WFB3Qy92cjlySkxm?=
 =?utf-8?B?UkxTN2dtNUFRYm1jOFVjSFNFN2MzNi9CQVFnVkV2d3JqRnBvR1JDMDd1ckY1?=
 =?utf-8?B?S0dzcU5iQjVHVFRueDV2ZjJpUm9lS0x6ZytoSW1lM0NBUTBiQ2RKTWRza3Z6?=
 =?utf-8?B?NUtBM2FBbmJwM2V2NmU2a2xIKy9obDlnT2hhZ210ZmdaNlBYa1ZyNXhqbk1u?=
 =?utf-8?B?VHhoaWxLME9jOEFaeFVOWHptenlyNStPOUU2SGZGcE85bFp3RXRYR3YwYjNz?=
 =?utf-8?B?VHlpU1p0R29SWTdETnpnUnJROS9TeExneThVT0RVUUc3OHF4QVhwSVRDT21I?=
 =?utf-8?B?aE1UL3VaSEVKaVV5MkwzcVVNQzlYMmVKaEVDMzZzVTlNaUhSVjFPSjcrL0Vj?=
 =?utf-8?B?bGt1WS9kT1B3N2JiZjRDVEZqaDVFcytnZTBVN2grVHMrVG5kV2pTOXdITkpI?=
 =?utf-8?B?ZHFaOGkwK1FqYzc3bGZJczBsQnQxR1YxeGszWHJUQ0dqR3hlVkZabURDMWJj?=
 =?utf-8?B?NmhNbGYrbDkzYWk5ZGlVejhzeFNvaFEzMm00SWk1R0lWa1BJVzBPR3M3VTZ1?=
 =?utf-8?B?UEw4WmFpZnIvR1ZhVXExNm1RdVhIenc1V2lJMHdaS2hBZnpxajl2aERDcWJw?=
 =?utf-8?B?RDJ5cUl0MzdxRFljZkJSNWphbDFHUnpIZzQ3cmkxVmw0NXd3UWlpWk9HUmNP?=
 =?utf-8?B?ZnlSV290QStCa0VWUmVXcS9XNDVFTWlMenh1Ykhha25TVDZnOVBNQnpPR0ps?=
 =?utf-8?B?MjZ3cGhYK3lEd3ZGM0lPMG5qby9QUlo3MVQ5bTdoTHNDeUE5SzJFQXdQN2hs?=
 =?utf-8?B?MENVSUpRVDlCRDMxekRUTGF3dnIwOEFuSWN3c01yTHNpNysySmRpd2ZDNW14?=
 =?utf-8?B?cWJ2R3krY3dhcTl2SWlmaEwvTGxJc0xvTXpxVnNhekpORGF2Z1oxTDRMU0tj?=
 =?utf-8?B?ZXllM3ZjZlZWUXl0aXljN1lIbUxWS21FMTVaZ3B6N1hLL2FOT0cwTXo5dGlz?=
 =?utf-8?B?cmRaenBoS0VGRHhDTGlSKzhRa0lqSlhhYUhCZWQwRVI1MWY5UTJnanpFY20z?=
 =?utf-8?B?NXYxekcwd2V4ams0ZFRYZitVdlh4Y2hEYW9zNStkTXpDV1MxM3dZbjhUcU9F?=
 =?utf-8?B?Tkh5aDZTa2xNNWZpaWptc05GTFV2cVk1WXBUcHd6TXFLUkdCbTFuS3lzbVlJ?=
 =?utf-8?B?eFF4cmxqcFQ3SG03SDRmTW5pTU51MFEwUldWeERIRE9OeStWQ0RkR0F5TTUw?=
 =?utf-8?B?TUN2bHNVL2JZR0VNRzljb082RHlTZ0lScld5RkVIbklvOG44d0lRaW14Z3pS?=
 =?utf-8?B?MFZBclJiYjg3NGlocHJIbThObzFKRVp2bjJPK3V6RmJmeS9Gd1AzSmpaRG9G?=
 =?utf-8?B?UlJzalBqaWFzZTZUdkRwZXB1TU45UzBqZ25iWUpNZExqamc3YjdId3pWaE01?=
 =?utf-8?B?WnZvNDQrb2FlMEtTUWJGTFJHWXhwSlZxRzFXYTY5SG5hUHpHb2JWcVdTUVd0?=
 =?utf-8?B?UGxjeTdCTCsxeFMzbFVjMU04V042NkZjUnBLSlhUS2wwMGY3dEtudld4N3Bz?=
 =?utf-8?B?L25jczVvbjI3Yk41dTdQYitSSHR0V0lBMHMxL0NjNXU4OVdyWlY2VmhmSVU2?=
 =?utf-8?B?WE9abzNNYk9BUXBzTFZqcGtPdDYySW0rMFdkbnk0bW5sQXVPOHhCcEowUnlr?=
 =?utf-8?B?bjlCZWNraVJhMDM0bVB6UWIreFF1cWxubHZwR1M1UWE4bC9LTFp3Y1RuOFdv?=
 =?utf-8?B?b1JFZFBJQTgyTDBCS1EyYVYxMDlzaCtnS2QrVmpXRTN3T0U1UHdHa2JlTWVy?=
 =?utf-8?B?Uld2M043TExGUktVK1NYWjdZT2tVYUEyMFVWaHFWQUNDWnRqNERTeEp3NTdy?=
 =?utf-8?B?YnppS1RjSVI1WGlCZHNuM1RqbnllUitUbkJWQ0RTZTgyWDRmVUlEd09LZCsv?=
 =?utf-8?B?Z0hQUzNPYk45cHBXKzVJTTVUUFFZelNuWGtoRHd1SzFQNzErblA1RXJNT01w?=
 =?utf-8?B?NG0yYi9WNXBWZXZVUVBxQ2hrRGNyL0FYREk2WDAyazNnd21uSlJZYkhBWjkz?=
 =?utf-8?B?L2oyV2NZUCtnQ2xDMm9keVd4UllmN2pLbkZKbXVXeGZGRFZaaFo5V0lFWHBt?=
 =?utf-8?B?M2lmKzk4K3NGNVpDTVpYeXhNajdCbzZTVEs1VW03Q3E0VE5pLzFZQ3NTWkpz?=
 =?utf-8?B?M0NpaHdQbUw0UzRRWjBZQTdOK0dDSngrcFZnMUdXU29iSW5icnl6eEZUeHdC?=
 =?utf-8?B?VlZyZ0d2UFZIT2Z0QWNvNDBOdUhvRWh0SnhSVUMzU1Y3Z1NISkc4b3g5eERT?=
 =?utf-8?B?akg2MzVGR2JwS1p1ZjhlZlo3cnBNWmc2SVdTYnVBdm5KaHRaLytFdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9f4546-7269-416f-64ce-08dec08e611f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:04:48.1966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiUe5+c0WpzXjrFtEU1+bKwyJXhRtSeu2c4K6oWtSIyg6FFHkfEmNsiWtVvAgfkGAPJ0Fo87AUoz6ZDspit03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612
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

Convert several USB drivers to use the dev_* and ofnode_* APIs and
removes dependency on fdt/devfdt helpers.

The motivation is to:
  - Eliminate direct usage of gd->fdt_blob and fdtdec_* interfaces
  - Avoid devfdt_* helpers in favor of backend-agnostic APIs
  - Ensure compatibility with both live device tree and flat DT

Summary:
  - Clean up unused legacy variables
  - Convert MUSB driver to use dev_* and ofnode_* APIs
  - Improve phandle parsing with proper validation
  - Replace devfdt_remap_addr_* with dev_remap_addr_* in MTK and MTU3
  - Replace devfdt_get_addr_* with dev_read_addr_* in MVEBU

Not have the boards to test mainly regarding the musb changes,
just best practice for the migration.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add R-b from Simon
- Per Simon, for patch 2 and 3, updated commit log.
  in patch 2, drop DECLARE_GLOBAL_DATA_PTR and the including of
  asm/global_data.h
- Link to v1: https://lore.kernel.org/r/20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com

---
Peng Fan (6):
      usb: musb-new: Drop unused variables
      usb: musb-new: Use ofnode and dev APIs
      usb: musb-new: Update phandle handling
      usb: host: xhci: Use dev_remap_addr_name()
      usb: mtu3: Use dev_remap_addr_name()
      usb: xhci: mvebu: Use dev_read_addr_index()

 drivers/usb/host/xhci-mtk.c    |  4 ++--
 drivers/usb/host/xhci-mvebu.c  |  2 +-
 drivers/usb/mtu3/mtu3_plat.c   |  4 ++--
 drivers/usb/musb-new/ti-musb.c | 48 +++++++++++++++++++-----------------------
 4 files changed, 27 insertions(+), 31 deletions(-)
---
base-commit: 0a46055d96ac627c05180cdeaa187a9fdf6b7973
change-id: 20260526-devfdt-usb-8a17a2383cd6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

