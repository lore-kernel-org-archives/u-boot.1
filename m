Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DF7CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DEF84CF2;
	Sat,  9 May 2026 13:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rFtfEYwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF3F84CEE; Sat,  9 May 2026 13:12:15 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC99584CD2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnccIMozupTRbFsJxuGv5B7ve6W/rn4eV9UFR8jOzYSNXg89NKYkOG4H+hj1FF5DUyJiZMEvty3fr5HebpjlA97X36TCU8AL3/T+rUioCz3kAU86VoPZ4v6l4kmnlUqY3VGti83fr0R2OHA3OkOONvOspE+k6QLDCAhldPrG7+Lv8Yf7IHqlDLWURTbmf0AU5egydid1Sa4YkrbsfP4jWWfGwOgUYD82tCQ5Pa/OLWJbQ1PtnVP3lLzAedJL9bpUtZyV+smnBxVxS5mbgaX2gmyHrX5PMtvjZXG6VmxDnAPtfNxtBnJB40MRoj0MpqdvitQgalKnadNyfX2920VyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Yq53ghrrP8fHkhBzdLFO37CcBIwg/Ks1FqRAGYoBU=;
 b=XXLXvuWLe50xAbblnCfxnSmzHniHGQ4en4i+6mOW42swRCAei2Owi1hofCCiJX5NSoxJfTmucxZW1YYg0wq42cSpH5zgC47EH60CgHcRHP7Eyb1F5Ne7zrcc8hZB9oeeGMsLLs2sTfdnMuTHwytNlwI0em+/jCOJXd5LA3MXhzpC8PIn1V5MMenACJxQALoY3Wk4ReXawV0EgAiJ4fTPTdSbsoPeXGsDTfEcDI4o5B2Xv7xe8woUhZeO+3iwTgwJCfG6plIo7SavzvmLJKf02Gfw7mp9tAgqafd8WooGXeBifEAL203limhkdhGR8PMyOxCETFPcnsKdZ+/Y0Wrqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Yq53ghrrP8fHkhBzdLFO37CcBIwg/Ks1FqRAGYoBU=;
 b=rFtfEYwUby1G/yl0qr54tgeUmY4C/Wv71nFzx0g8qLT6aioFZBcGLkGH07bSBPVESGu08Omqn5wxJNfI+ebCA9eWefc58q3ki+Js83HY/g2iqRRrYltgOoQey6PySnBRq59NDRAPSxwkhNWQ1F3uVK9YFQGqE8WksqKo+PynsAvG5lnlXv6dy1EgEW81tJbeSIqyUAHp0i1Cwc5E6puOmBdlhNDBBX0/LLFja2POpYPdm12TIdqrDooeokSRmIvDelfkYrSBxhG/dtTs4zsxXn0jBAZKtTuj05gMSEjqaeyvMGRtvcywePyuH+wmC6NPwLbi/Re3yQUPeomuu8f0EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:07 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 00/11] pinctrl: add support of Airoha SoCs
Date: Sat,  9 May 2026 14:11:46 +0300
Message-ID: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: e84920ec-cac1-402c-68b4-08deadbbce95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: cxZEJASPAnte4Xe+d2jvu6bq3b5JnZbSIs/LtOsKfjGDJCwUlYDIu/fWFuU2+kSHBYzt/i9uJmctDO6/7MU//Olqmzl4rvPjzvP6A3dmmw2Eq4jW5YPCfvoz2tcDyjKnIcrbvcg7pfvANUG//zzYtISZJPdEhtph28C4l4WOB1ZlG5j6qAsYsPtutL5DME3L79SF8Ax32hAZfZREL8K66N8M1LArjKPp2NCw2L7Iv9gby6eevwSZ01g/gKJTbr+h97z/pivQapg4V6kMkyJUX18zks1lIvZcLYel86AshI5x13RLHZU4XrsduK2Mytjyu+5qaf/hNesN69yaxobxpCi7ftTV7fGCh8fa6jbnqzFKcNdEcb5IKHFLhDgTvVDODrApW8knWoJ346QEiS75z+pRMpFx9jiQAXmCG+/MfXQ3uqz0u6PhJN+TL+IEeKbUVXjPFXIWfMmcZyoPlX0PbYDqGJR7PjxnUpBYDX5RtEmkGTvvxTzndx9erQfl6jTUyskeEVq+t9qX16T8isBa+d8IMW+6toj4jdg9MyVt+EzW4wlQD1KTwHzACwZpAdWdowBLUCBnwDuv1qLwUv9g3ZYnFXCOes+m4ffOnV80UBE2UWvZLeuOZ5jyRZaiVCIeDhiPZGxENTy2gie6rI/iI4AqdwdT90REpLu4myi7hri17elgMcubRd19gHwysC1IRtbHPrRjan2zz5AJNlnPvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWtGL0JveHYxOTFJUi9ZenJodTRaNlR0U0U5aC9EZUxlS3Q0bTE1TFMzV2kv?=
 =?utf-8?B?MDBGeEVkb2VaKzA0V1FHMjVSVlREN0tVU3QwUU85dHIwbzJyNHBnd2xpYkM2?=
 =?utf-8?B?TDhLa0RGL1Z2SFRaV2RlQzU1UUR3bU1KcmtSRTV3MUxYL0VvQkFjQkJKZklB?=
 =?utf-8?B?QThmcTNLdnQrQWgwa3RqbDFtWVduY3NXSHNycnZoWFJOREZCdEYyaWo3VUxD?=
 =?utf-8?B?RjdNMUtEODhzSVljcjk5Wi85SGhKWkVLUDAxV2JyOHlPL050V0szS1hPaHRj?=
 =?utf-8?B?dWRTT2IxN3hSZnFrazBFSXFUYlJsTytvOXkzVHZEdlpsZVViUEZDR3RpdnRG?=
 =?utf-8?B?eWJLbDVCS3BKL3hodmEvZHQ2WHZnWTVQQjhaV1YxN1QyUlVSUVJadStPRzl3?=
 =?utf-8?B?eVg3VXJtQTRQMWV6UGd2YTdiNXNHQWtMLzY0dnN1SEZuVS9lUktiY0VPWUcr?=
 =?utf-8?B?eWJEbFhLQkxGWWZ5RUNweWw5OVpsdTlmT1hDeWJwemlsY3JIU28rTzJhRmxV?=
 =?utf-8?B?NnpNbG5Zc2ZvS010SzFIS3VQeTRvTEZWTkNZL3lIUXJWNDZoWThWL0dkK1p1?=
 =?utf-8?B?NWhyU0MxVzlSWStiaTBXczJYSURuTDZqbnVLN21yK050MkdwRGliNVZxblRz?=
 =?utf-8?B?U1cyWVRNZGhyYlZhZEY1MzBWRlplVUo5cVQrSHNJdGNrTm5XMnIwNXNza0ts?=
 =?utf-8?B?V2piWmh5YkdHOUtST0VVR3p1SUtKcWdCUFF1aitHZDNrNzhwNWk4Wk9POFhw?=
 =?utf-8?B?aytHQVh3MzFYQVVXanhsUnRIcDFwS3VDWDJHc3N3OEs2ZnJYdGtxM01XQW1S?=
 =?utf-8?B?RWFvRXJUMHBLc0ZoQ1czL1liYzFBU2JUSklHV3RkMTZWNlM3Z1V3YmJMQmcy?=
 =?utf-8?B?Y1dwSmovQURPR2NGbEZQTStMdmhseGVFbE5pMTVzWlZjNXZGMmhGSEZPR3Ix?=
 =?utf-8?B?MHgvY2JIcWxwcCtqYThpT2hiVWhSVWtQQ08zN2wrTENvKzlKSllnTFRIRHhQ?=
 =?utf-8?B?MVlyem1pSlpoSE1qTUs3WkdtemlaVjJBR3VQKzNnNlo3akpNQmZscWw4ZnVQ?=
 =?utf-8?B?b0RWd01yWll0NXJvOHhMMGc4bTBYa1FiUzRIS00zdVRiVlZDa0J1V2pmNk5M?=
 =?utf-8?B?anVyNndJZWtvamNLeUNTTnN3REkrMFhLY2Q5bXlIczJwc1U5SitxeHNsQ1BI?=
 =?utf-8?B?UWJJOU4wejZuM1FOaUR1STBDVWhrSnFyeXV5VGNkZGJqSnhrbVBsYjJUcndu?=
 =?utf-8?B?QTZLTjZnQTEwa2ZEajBZWEZEMVRXWHNoWlRlc25QS1hmYk83VEpIcjg1RUVG?=
 =?utf-8?B?RkczZ3dPQjI1TDhORDVJUjViL1JXdTBTK2JYV0tMbkllT0FpbTBlWGRMQXov?=
 =?utf-8?B?TWlsckpWSHhGcnpWdkczelFVY0dTNFc5ZlNHWjhtVzI3eGx3OXNvTThsNVUr?=
 =?utf-8?B?bkxiT1ZwMTcyZ24xdWZFM0xHdFlYTEREdEN3eENWQW9NSGZuTmtyblpCZ3hQ?=
 =?utf-8?B?bmlONEdDMnVza1NOR05JR0pjNmhMTytXQUY5S3o1d1labEN4ODYxR3VTTUQz?=
 =?utf-8?B?RTJPQVlTbVJnNzcwcmhaT0hGbjY0dWp1M0xWWmFFeVg2a2tGeWNYdmVpTHBW?=
 =?utf-8?B?UTNFTzZISDZiY2dwVGI0QzJZL1pxQXY5dVFDMVVCNlZqUXNMVVo2NFc2SFlr?=
 =?utf-8?B?UHU5MTViU2s4UVhIY0Q5SUdIeGpPOXRuTFIxOGVxQnBQVzdSS1l6dFhLTFo1?=
 =?utf-8?B?SHNVQzJ6MklMTmRubE5EeGdEbHdpYzYzQmZiQXJkTVpLQURTU2VULzBqM3lQ?=
 =?utf-8?B?SFZaOGg4VkNCUUxzYStmbklqb0NjZk1nYUgweUp0dHdWd1p0eGZHR0JjNHFQ?=
 =?utf-8?B?akVhUTQ1TzFxbThZS3JENm9hTmwvbHVKOWFCT2ZhZ0IyTFhPOXU0VG43dGJU?=
 =?utf-8?B?RjRJcW41WDd5Uko1bWREb2srdmRmby9YVG42QncwSVl6UlpwdG5EZTZJRGZ4?=
 =?utf-8?B?VU5zb2JtNHhhL2pOUU5CbUx0OVdkaEk4MnRjbFljOVVlcWsydXBuK1FRRWRQ?=
 =?utf-8?B?cVVJZFgybFNXR0o2emcxL3B2a3RHVUhNbVZBVitmVEFyaWhJbGFObHloSVVj?=
 =?utf-8?B?YU0xVDhVakJLVzZSTCs2bi9kVGoxYjRESDV0VndkYzJRTHJkdU9aUzcrNXIr?=
 =?utf-8?B?dzBCWVczUnA2YW5oVEV0MGZFb2UxRm9Tdy9ySDdmMytnZjllc3FNMk03WVVm?=
 =?utf-8?B?S01CbUlxRE1Zcndvdml6QkFqelN5UmFFb1ZFcUU2dk8vdnAvVzl1alVrUUdu?=
 =?utf-8?B?YkdsTENsWEFCMnBuVGw2WG0wYlA1bjZHanJWdE9xdmdWZlhhbVhTQkZhWUpx?=
 =?utf-8?Q?d95P9zqUQ/PsppiA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e84920ec-cac1-402c-68b4-08deadbbce95
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:07.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCNX5FALF/4ItLffyxG+3jQSnTJPtnhncLmCVua6bmcXtWalVxxRtyKAvXLG+RIbMyd7DT2S5lEd9qBBtrxCUpUtJ9iCjhR+QBlH10cp3+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (9):
  bitops: import BITS_PER_TYPE() macro from linux
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
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  476 ++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 +++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1076 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  979 +++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  648 ++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 4386 insertions(+), 44 deletions(-)
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

