Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FD7CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 19:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10ABF848B9;
	Mon,  1 Jun 2026 21:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pPiWFxwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEB7848A1; Mon,  1 Jun 2026 21:53:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0256084855
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 21:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGzHrmON/Q0xgOjUNMfcCgbNsFAo7zYlar+SbZzp0IsMtRz3QxkE4qXjq+jlGLmTOqTdZ3Cf3ZqOQ01ZTkfRVLO8lOON5EOvWX20/0yaIWfsbhZX3+Xse9wu6JCicW8kJ10d4JKszwDGG+0HWZ7N5pHQcceYo2M3kL5KaNtm14SB/FJyKccWGvPqCQNdw/I4nDRsAudcvI3Q3hFMeSCUIJBoq6d73L1hQny80yqTJBSdq6v47J0DhNyjx8Ybo8FC/DhHoB8Wu5GpXdUSfrmkbimmfCtlgjXncMBJp9YUvGdLTUhilHI2+khRExrH32Ri27gypFjRFg6h+MyNzvWwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpNq0evvuc7Wn+n7Sln80JKQvYxmGbxmzI2jcnNeXQQ=;
 b=GmoBQrck9+d3CbgENYRM37cyuCSpMjMAZ/ivWC2T0gE5hf7C7k2RXilwcSB3QqZM7C849HEQIhrPCblQ4izBtuVU/UzJ1a0ovHybOAUkLDTbrVCo16x4akTWFLDf1k9i8+co849vYjW3jLPLW+rvAXRneFP1Cvykx9OFv0JNQIebiQ+zrTNx1RtfkJm425q0PsgB8QDLZiUHSSR5IuksjBtvDW7gWdNsHe/l/fxXZR3MS/04GKAHNxOQrI+VuKXAgyZjPLFPY7SUmY+Rfl1f9/ELO3wv31zYH98Yb+G4/p/l1zXTuLike4IlUhwW86nNCftdrd2cgnVMOYDk1UMuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpNq0evvuc7Wn+n7Sln80JKQvYxmGbxmzI2jcnNeXQQ=;
 b=pPiWFxwQcjUFvLk9F81f2X+RC3Y7rC862zWuGSgT0u7OIuk5grrM+kkXfamuMSz+vlVrOeY73DaKVVkgEyBGCN9S4u0+82L91IHZWs/8BEBcPwDj7H9SG2HobVxTMFd0wAEHbSP+6X5bYXgs9oDp9TmrUyZaQBf45QPJH5FbulLcIBOXKdnFiK+drvVbvFPkesIina8S8pRjgGwNfO91C+GJI9lwoqFVcoTELGm3A/Nknz+C+wga+2AHQr7R8VU5+WjLGFXUao5+f71zsWM1lhIUcYolPm3S0XP2xXeOxh/svJjc9Et4G1DMGnupKijSS/o0o/JsGd5vfFRwgIgf3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 19:53:20 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 19:53:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Anis Chali <chalianis1@gmail.com>,
 Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Crt Mori <cmo@melexis.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v11 00/12] pinctrl: add support of Airoha SoCs
Date: Mon,  1 Jun 2026 22:52:59 +0300
Message-ID: <20260601195311.2390473-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec91450-4bea-4071-4cbb-08dec0176e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YuKTRl5iIZJR6Vp9dWjPAg6+eXDoGML7e53PD1GqVmLOAR+gUcHbO5KkjEYURHnpPiRe6RvqENbZ3+FPutYg0QutEk7x1lzIvkBa/pEEiPA5pRGX9oXVUnY2EzYa3nPYNIuRi9Pi8oh2ow0EsuWBl5soPfHcrzFZLMp3WKcDrjdKjzPnLhoza5V3sxGvBHyHzi1xbJkHYunHnI6R6CNXSZwZqSYmMsFQ79VEAI1qkq6pregKdE2WdYpy+enXaue0eV+e0FTOuE496DXGygKj2sL/wyAG3383ET9JmCfJXzPFCdBs0a4gSIQUXo6ZEXumwHuuq3XxpSE8VZIm00dv3Rng4Lt31UkltLbqL6J3qVoDlTy4zF+t5hc3Sr5A1MXsBROeoErKOhAqEuwcSsbabPbDWOiSu010fSwBPsS/thxaeg0ZlqVSt2ga2bM+aUGSkDv5LG+Mmg2K9+4EIGWeUInh0wtKrVz8UcGWY6e9DBcN9jEEiigHAE1LtYsDtVhvouSMrl1UQM/i1c9y1DfkJj5nRvUfZNQDAzWC4DUYIyYA653y2q6V9uFD38n4wHE6vxo+VNO/a+wqFfVM+P+uyFtU606Pib9Ga5zWlYQ+iwsGF4mavY9GWuFXts3F0VqnwPeUmSdTdy2hsYoaY+lDSBc1m30F2zxD3wbT0yPlisyDwYLwgtIhvuZDbitS5bZFJ8MBS2ZwQzf3IriGmCFE8f/aAx+bppUedMDc4QK5jLYgipZ+uFV27FQgsGoO6HYC2iK/y8v0+xwmhIeuW9OaEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZoUVdaNHdHQXI1RDVGSEgwYXRnQldDUU9oOHNMeXF3TnpHTnNMK0liWnNp?=
 =?utf-8?B?eUh1Rk5FV2VwejFvV1Fhdm53K1VWU1VlZXBsMko3cEloc0pVVVBLNEQ1cUFr?=
 =?utf-8?B?aUlkeDJrRnluamxhemV5enRxRWJsYnNKUXlhU3ZHVFB4VGhpRUp4b2pBUVFs?=
 =?utf-8?B?Rm1aZ1d4MFNudFVmTng0WUtRQXVXM2NLOXlRN21sZXQ3dkJreWZ3N0xhb3hN?=
 =?utf-8?B?NGc3alhDcnR0ZXVVeWZmK0w0QjIyR3ducituNFhzTU56ZTJIV2lRc3E1M1ZX?=
 =?utf-8?B?ZW84U1dESjNGd08wNTFCSjNzTmRlZXdzTWwyeUU2eGxnMEIvSkFNYVlSUHQw?=
 =?utf-8?B?L3JoNkpldHRtTHZyeUJVYjhXV0FwVVNLZlRDdmo3ekR6aThRdnNURm56QWU4?=
 =?utf-8?B?T2tNM1pPSnhzV0lpV1A4YmwvUlJUYmNmN0lwZkhNUnQwRy84QjFVMEcrdGMv?=
 =?utf-8?B?bUo2MVRnSVJ6LzA1VllZMXRyekV0ckcvNVdmYlFVU3phamtWQzY5eFlsSDBH?=
 =?utf-8?B?TEo1ODJpdndNdzlBYUc1cVdnTk5WS1pqY203NXFLNVZKMlh0SGc1SmJqbmVy?=
 =?utf-8?B?RExrYkcxWDRtWlE5RzlkTmd4ZW5saXVXYy9uaEswT1VhM0tpTHRxRmUwdDlJ?=
 =?utf-8?B?dlpDRGJZNTFHZGRURHcvOCtrTWRSMTlSMUZkQ21ZMk9WS09vWUJPOUpyREZm?=
 =?utf-8?B?cGNSM2hQTldJNnRjVkxPS0xOSk9sM2h1ZGEwTm1RMFlNMkQ4WVo4b1RPSlIx?=
 =?utf-8?B?MXdnL3dFRngwYXB3QU4vZmN4ZzVFREFoK050UHRRekYrcEVOTlJUcW9GdmxJ?=
 =?utf-8?B?NWtFQjZGL3ZHYTFwVHlMRmtRUFJUUm5oRmx2dDBabUNIbVRBOWZtUk42R3Jy?=
 =?utf-8?B?V3FVUHJEa05hZjRIQlg0ZU5EMDBkRm80RkdSVUcxM1VaMVRSR3pOSDgrazU1?=
 =?utf-8?B?VlFORWZUOGw5YStKRzEzMDExeEh3Wkd6ODQ4Mzlhc05tRmtLN0cxdHdHVXB5?=
 =?utf-8?B?T0lEM3IzaGdOQjJyMlo3ZHRNQUltdDc2LzVuWGtRbVJmZlIrTCtSKzgreDF4?=
 =?utf-8?B?aHo4bGxCTlZUMCtNSDVhaDNuSlBoUzdMQTEvZEVQN2ptZU1kS3dCUllUVERE?=
 =?utf-8?B?VysxdHlsOERNZkVIUDdhbGx2VVBlK2xzd2Y3U09MZ0hVMkhEbzBjbm1WQjVE?=
 =?utf-8?B?bUJtYVVzR3lLVVJRcGkwQUN5Q29WeS9YMkdtOXVQZy9MZ1pwMGw4SVhNZUFF?=
 =?utf-8?B?OEE0alNDeTM1NlVpRFZITi9ZaFMrV0ZlWG9hV2tYcDNvaE4vaXB6QmtTakpQ?=
 =?utf-8?B?dHJPMkM5ZVhERzVEREMzamRmS0toNStmeU00dXprOXZkM0JkcFBDTEVBS09i?=
 =?utf-8?B?cU9WNS9QVGtaczIwdE5VS0RTVzhyOWtxWW8xeFp0MHlTWkNmK0wwNVBZd2F6?=
 =?utf-8?B?VUY4cXBlNU9maWUvQVNpU2JiYW1wWEQyWjVqaGRZeHRLaUNpSUd3dm5WVkd5?=
 =?utf-8?B?NlN4ZGVlWXVRNzBIZkJnNU00djdMY0h4c2xxYUpoOFJPeXdVYW1BOFQzWlBu?=
 =?utf-8?B?N25sOTRXYWl4R2QyY0hHN3JQYVQzTU51dThyR1QrWGM5em40anhMenc2czJY?=
 =?utf-8?B?YUh0bU1ZY0pZS25xVGF5OXREU09oNEdsenJObUNReUFXZ29FRy9qTzdhclJH?=
 =?utf-8?B?cDFyNXYxeUhxdG5BaEdkbTBmNEtQNnAvUHRMZzd5WmMrdzdoWmYrb1Mwcm9y?=
 =?utf-8?B?NlRoL2p3d0NHbXE3NWw3NzJoZHBWejZyZW1tMjBjRktVY21mSEdQamdhM1lD?=
 =?utf-8?B?TGJEcTJSM0I5WkF0c3o4b1JBRENjWjNxaWNMdFJGM05PajQwY21jK1ErUmV0?=
 =?utf-8?B?cjk1aGM3M044R2t4K2Rxc0JQL21pVXJpMjFVZUFFQWswUHhnT21EWElqZWI4?=
 =?utf-8?B?OVRXTjkxMDFvc3NjdnMyb0I1T0VCUWxrYVdMVG1QQWtHdi9ZVzJTelhGci9i?=
 =?utf-8?B?OXlXUTFtR1l1aGFlYjZPK1RGWENSOGk1cXpGcjc5Wmhkb2N1ZGhLeTRZY3Az?=
 =?utf-8?B?dGVPMnhONkZ1Nnp1QnpmMmZlQitFS3kwRk4xUGJvQnBKK010NE1xQmZjcXlr?=
 =?utf-8?B?Y2QrT1lCbWNuMzE0SDFxYmJ0NzFja1pYa1h0QzFiblZ2Z3FHZkhKeUgxQXRm?=
 =?utf-8?B?Rm1qQzVPUzlTTGVXT0tpN2VxdGhMVkdvT2ZEQlhmdFJGRlVHWkhEM1V5M09r?=
 =?utf-8?B?b0Nhd21sUmUvTXQ4Z2FueE96bENua011STg0Yjhob1g5SVlvU0g2Qk1BWHBy?=
 =?utf-8?B?cEtkUVFWNVAzTFg3VlpwVW4yUmY0U0U4cFFoY0poREVlNzV6M1g0eDRQUzRP?=
 =?utf-8?Q?oZKiZcxWTHjVF+Ps=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec91450-4bea-4071-4cbb-08dec0176e22
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:53:20.0853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWXNFPATs+vSSXPXFu41RAhN3EHchVpQ31LkJVO6ndVseULOt3Xh6MTWoPSrXUXaanrUhUc0mhNFvw3++hDJXoaSGvvSJnSKKhxjDMVe3IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
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
  https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en7523_pinctrl

Additionally in the EN7523 case the patches removes existing gpio dts nodes
and replaces them with pinctrl node. It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * Legacy Linux EN7523 GPIO driver is mostly abandoned
 * The same driver is planned for upstream linux/openwrt

This patchset includes bitfield.h patches created for Linux kernel
by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
and original commit messages. It might be not a best strategy, because
these patches refers to other linux kernel commits not added to U-Boot.
Please note me, if there is a better way.

The patches were tested on EN7523/AN7581/AN7583 boards.
---
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

Changes v4:
 * minor refactoring
 * fix gpio initialization, so gpio driver becomes probed

Changes v5:
 * more bitfield changes
 * sort contents of pinctrl makefile
 * address more issues found by David Lechner

Changes v6:
 * pinctrl makefile sorting/formatting was moved to separate commit
 * replace 'tristate' by 'bool' in airoha Kconfig (thanks to Peng Fan)
 * a bit improve menu entry names
 * add an explanation why en7581 prefix used for an7581 chips.
 * add reviewed by David Lechner line to all patches

Changes v7:
 * an7583: add missed gpio22 pin group

Changes v8:
 * replace en7581 prefix by an7581 in the an7581 pinctrl driver
 * sync en7523 driver with latest Matheus Sampaio Queiroga work

Changes v9:
 * Remove an7581/an7583 prefixes from an7581/an7583 drivers. No point to keep
   it in the chip specific code.
 * Minor refactoring of an7583 drivers to make it more similar to an7581 one.
 * Fixed few bugs in an7581/an7583 drivers.
 * Sync code with latest Matheus Sampaio Queiroga work.
 * Remove en7523 driver by request of Matheus Sampaio Queiroga, because of
   linux en7523 driver is not ready (and currently broken)

Changes v10:
 * Add back en7523 pinctrl driver. The driver was tested/debugged together
   with Matheus Sampaio Queiroga. Pin numbers were changed according to
   the table provided by Benjamin Larsson.
 * Added myself to the list of en7523 pinctrl driver authors.
 * gpio-range property was added to pinctrl dts node.

Changes v11:
 * fix mdio pinctrl function for en7523

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (10):
  bitops: import BITS_PER_TYPE() macro from linux
  pinctrl: add more pinconf/pinctrl definitions
  pinctrl: sort and format the contents of the makefile
  pinctrl: airoha: add shared pinctrl code
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
  configs: airoha: an7581: enable pinctrl/gpio support
  configs: airoha: en7523: enable pinctrl/gpio support
  arm: dts: en7523: add pinctrl/gpio support, drop legacy gpio support

 arch/arm/dts/en7523-u-boot.dtsi         |   23 +
 configs/an7581_evb_defconfig            |    2 +-
 configs/en7523_evb_defconfig            |    2 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  477 ++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 +++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1077 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  980 +++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  759 ++++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 4501 insertions(+), 39 deletions(-)
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

