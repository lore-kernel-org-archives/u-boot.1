Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B9FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C749846A1;
	Mon,  4 May 2026 15:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sY62zUFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2052F84653; Mon,  4 May 2026 15:03:24 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8088A80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnjFnOk5vAb6gEzo6lX25bbSMXnTlyLjss5lMi0L/k3EQxw64ZnCL6nhCBgk8KS2WhCEpiH470n+IL+sYuP3ljHvD1CXIjN4Bd/IUNXC4qVhwOBI+9zsH3NNcTpu/nZ7P9i0YZPdQi1Yyaqs6HxfDStZgR2qlhYVxASM2wlQ8EBNTjCtLhxiBvYjsSN0zoWDOtkBc69ev/FJw3RjI4BHexXJPpPVh6YgK2pZLFC1gKSLgm62kYooRk5y1JJEVB0YNum61rNxm18rhoFJvXVxVOSTdpgUCR554bidqdbHhgU9HVEJrQSxzmIdeDqZwWuPKXfXDMAg7ZF21hOKmASwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDwByd1kEw4ivdgTSYy2arDQXR3W7r2zgeszL8EXwOs=;
 b=U/pB3B4m88J/s5l3k0r4gzf7mrobJgaaHnSZEsTMrsBXy096EcJ+z4s5R+tEzVAgM1TFtiq6Wotxv6KmaZyXBZ3B7KHgWybQYOQtCEVyOlCr+1owcl/GypE0D5fP+i0oMl7p5XoFC7NJFZGDwcIm1oRZmi+hIAxAMSPnEmZWNemoxUsBeyYb5cSeCqoCPvO1UfxC/1S7RxbdaImG9Jejk9UnEE6o/YYtk8bX9uxKAGagFc8jjDdg5Ygc7d5OPXGTUQfZOxn1yLiYDJlOi5lWYi9jMHrGK/63WVMJ2iS+gU5qceR42L0syrQP10nA9XMzsl07YZK9F8zMujnZnaQOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDwByd1kEw4ivdgTSYy2arDQXR3W7r2zgeszL8EXwOs=;
 b=sY62zUFqD8R3D1weZp2Rlr1Ow1ZdrmZqGWVqgjv5BAbxIdbDqMFkYvHJSe6+Ch9jglwpZ6BRoeH0eEda8O/obrE8YygnweRz9bZ4O2Lx7f+RNxAzAsAroThVZ+1hp0ZLQIriR2vNpN+/kGt1iDO7CDe6upDXgU1eeOUj5dVknk0mEo3zM+W9+K5QaC0GSz5t8mZbfSCu98Avs0wVEfl7uLY65IZsYmLqI2tHsDO+n3ws48uLyTubwZ4qOD8ZChn0BJkLgMs5cABt5mfXfcZLX7Pv8NvQ37VsyFar8/yI5kA8mxZ2GCOom7y0IZgTRqg2ZL9qNkX+tI9dUPxd2rXSog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:03:15 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:03:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 0/9] pinctrl: add support of Airoha SoCs
Date: Mon,  4 May 2026 16:02:57 +0300
Message-ID: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8f5c7b-4d51-4e06-f8bb-08dea9dd80fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|7416014|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: Qzv9NgMQtCHMjj79EvCaQmSJOXcmOJOLNltUdIHUVPBeZUi40NTflHY4qlOVV1RZB07zex/9ZPU8WZ4spGCImxrMBLu4Xnrcz7v7aqLpjHR6aqjrY/19ux52kWLJtv2EgwZ1O+nKXGRQGzW/syoPvJFPl4Qt/umR2LOA7nMsegTMO1Vrk3wu3QhMEO4pt3PaAJTHdDSBKuiGZvEJTxwkiPN4lE3QhZWBx1hSIP2s8u72V2gNivIER/R0kp61pIuMwM4ZBDjglVbTbF1yOTQ3VuUSPWhXNaI7kCpM9MRP/EX5DiDfUTn+hivLa1iEAVE/EALtTlJiY/usTH8wY+5l0dUQ18dEcfT58yaMV/g4tpDywUcXpwXG6edU+xx8yb6+BrQL/teCeK3TPZlYD53h/Z3Rxj6WjEl1WJIo5O7JIkk0yYqeUZtwhovt+Re+LT63WknmplyAbDSEbtR2ZdIQ5MtoiB0SiKsQzxPgVEe2WNArWVfaAPyaiPOBENv5Kq1JtygG8omCHzheoQlNPpexYutnrh9Zt/qddNbA9eg7qxEDsaZufwn+th5VZ7pUbbuKTnddk8+7egdjbeiuNpZllnP1S8pjCbzmmPHVQfQUBtVXBddAN/7+By7WmAMhTAfL7N2FCmqWIqmRKYmVJLrwHQBIiZEOb1k2MrqnpuuecVUFewsUlYCOXrafXSEUFWiIprmy05bRojU8SYE4jkgRCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(56012099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JTVTNiYWJ1V2JTZDg2REthVjAzK0NIZkRPUTRrRWRpY1dYVkVzTkxMM09p?=
 =?utf-8?B?WDNZc0RWczJyTzd5ZDkwbWszZGRpWWdjbFpnWmhkMWkzYXIwT1ltNm45cDVQ?=
 =?utf-8?B?WkNQY3JtQXI4Tk5ERGhkdHo1ODFQU2RlSW1TK0VpbXBtR2dWdmhEVmkzT2tR?=
 =?utf-8?B?NmlMdlI4a0FsZ0VEbmoraEdMNFNuZ1k5M1hZbTNrUzdJVW5PRlBWMHNENzJh?=
 =?utf-8?B?aFp5TmdDdjVnQjdhdWtwU1FhbmliMitJTTJaci80Z0xaRXlIWkdjRTV0WEx6?=
 =?utf-8?B?Qk9NU0lZNkdNRVoxTzBZeERZRk5MU3BKWTN2UnlMNE1BdnhpTUZ0eEhEaEdE?=
 =?utf-8?B?UVJpVWpucWphMTEzSTZOTmVNYldyRCtZZHBrNnhFOTU4a3JNM0UyQjZ3MXBC?=
 =?utf-8?B?dUtNbDJWSmFISzZJUzZBUzFmYUZqVGJ5UnRiblBBZWRWa1k5bGg0Sy9NZ3Fw?=
 =?utf-8?B?SlJiYVh1NjdtbDlkaDhDRlFLNzMyVXVVUDkvNlBjWVpVd3F6NUgxSTBjZXdz?=
 =?utf-8?B?ejJnY0h5TU5vTzJlWGVzbWd6bkp5VWRKSDI1NXBSbkhVMzhMWUNIVDQ1blpN?=
 =?utf-8?B?N3Nib1lDeWlicDBRZFJHd3VSZm5ZYmxWTC9MbFhSclFoMDVkRkpnN0Mrd2pp?=
 =?utf-8?B?RzJiOS91MHN6SklQdEp1OWJOdEhOQ25CN3lZQVVqbU9KLzJyVDhZVGVEekxQ?=
 =?utf-8?B?bGpvS0ZQekYxVHRwekJ4SG94YVcrRTZseEJTdUI3NVlNYzdSaUZZejdwdFZN?=
 =?utf-8?B?VHlodFdXSVp1ZVJTU2U4OTFBYVNnemc3dkoyNjFDWWVqSE8rWk52amc5K1Fy?=
 =?utf-8?B?bFR3Z3VDU1BEakpDNDgreGlUTEZMbEp6emZQOEIzYUJSM08rNkhXZ2lYdXZK?=
 =?utf-8?B?VmJGTE00T3BGZ1RVdDdEb1ZxWDZ3d0I2bi9QUDcxVDNBMDNubU54UVlEbTQx?=
 =?utf-8?B?ZXFVRzNIaGR2ejhDSzUwS3RjUmNNQ21rTGxNVmgrVklrZVlMSS9ES3poVWRw?=
 =?utf-8?B?S3JsTThBa1M4U0I2TkFLcWJNbW9WWUFuaEZhUWtFWGhxVUlwdEU4aXQvMEZM?=
 =?utf-8?B?MEd0Vlc1dU1sUGdweUNDaFVIelVBalZkVFNaVCtSdWwyNndERkZwZUkvSHFZ?=
 =?utf-8?B?b3dHcld6amRGd0tZYUVVamZ6OW9DbkR6cktoTDhxTlVneWVQRnplYU11bzZx?=
 =?utf-8?B?N1RyVjgzZG40K0hzK2I1dEwrRzZxZVZ1aHhWcHl5elhmcTNHcGYxeHhWeitT?=
 =?utf-8?B?YzNBTVA1Um5Ea2EyQ1hBQXZFN0JabmdwYW9ZdWpKWS9veDVndzMxVDJMVDFj?=
 =?utf-8?B?TTRUZXBuVkZMa2l3SWt3bkRlL1VhYm50VWRlektFQTROVlJNZ3V1aDBqVEFo?=
 =?utf-8?B?QTJXRGZKYUp3ZjkxRUNDRWErekNYdUxFdHFUcXcxUUJ6UkxxMnN4ZzNHcVdX?=
 =?utf-8?B?c05QRFZpZk5Bd0tJa0VSditCSFJVVTJ2b3o2MG90Qm54T1FkbGpMQjdFM3J4?=
 =?utf-8?B?MldMc0tkcHZhMUhTT2puTTJuTHZxclhUaHdOSWhYeGdTbi9ydFE3cmhiN3Jm?=
 =?utf-8?B?enZrcEI2YkFvQW1ZYW5xVENQUmtDYmJZRGR5b3ErSGxNSkdLMkNXVXc4VkV6?=
 =?utf-8?B?R0VsOGVveWk1OUxFaTJsTDlzdHFVNnVvaGZSWDJuK0s0UlhpOWk3ZDdqbmRE?=
 =?utf-8?B?czl3bzhhRlRKVXN0NGZ0bHVlaFVBeGhjaDF6MlpETllxZVI4Y1c0WFlxa3dU?=
 =?utf-8?B?NHRqNmdES1QyUm1hekJnTWRsa0N3bVRVNm1mMkxlK1RwVk5wanJOUGFHVnBp?=
 =?utf-8?B?cWJCb2JjbjRnc25Id21jZXEwcVBPaWpyYXVCazhjTjY2L204S3A1dENqazA3?=
 =?utf-8?B?aU0zNE0wWUtZcmFpVTUvYXZpRjlLNCtLeTZxNTQxN05HQWxYaVQ1YUxMVWJT?=
 =?utf-8?B?Rkp3amNmMTFmd3h1djlLcVFMMHRqL1p0eXBDRmtqcmQ0bkdWSWsra0hmSHh1?=
 =?utf-8?B?M3crMDJGamdOOTNjOGIycWdQYUNZd1dQN0NrU2picFc4RTFTdG5rTGRpVnRR?=
 =?utf-8?B?YXZ1M2RyeXdEWGpDbXFTRXZOY2ZSdVhyMEpsWWZ5WFdIODBEaWUzNkhLblZ0?=
 =?utf-8?B?eHdUbit6bDhJWXJQOEIreUpZMXIzM1g0L2F4Y1R4ZXNVc0RENFhwZm8wWWl1?=
 =?utf-8?B?cHpXYjV2dFhhc2Q5NDRMSmtaakhSdXlOTGhUUmRIdDZvSndWc0N0YmJxMk5E?=
 =?utf-8?B?eU1ZTDhoeDNBT3NYakVyMk8yVzVXTnpZcTN4cUVFYVZXanArcWZuUkFEeWlX?=
 =?utf-8?B?UW9LOHlQK2cyaDlEejlFZ0dQeEs2dXFqUkhiTjVvNXE4bFUxUDVqcGMxQ0VF?=
 =?utf-8?Q?35b1wOKI5GRuraEI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f5c7b-4d51-4e06-f8bb-08dea9dd80fb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:03:15.3056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGIA9f4TGznOv0fBLpAO8BKTYCDXXRs5pxlDJHQKQJW40Vcdpl1Rjt/ATEyVJVByGEls8nyjOZnK36ehKA3rQ8pu8nPLlu8Ao8MGpSS+zOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
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

---
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
 drivers/pinctrl/airoha/airoha-common.h  |  512 +++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  843 ++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1074 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  976 ++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  648 ++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   59 ++
 include/linux/pinctrl/pinctrl.h         |   74 ++
 15 files changed, 4273 insertions(+), 7 deletions(-)
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

