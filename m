Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DF1CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1C53848C3;
	Sun, 24 May 2026 22:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mOwRTD9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C2A848AA; Sun, 24 May 2026 22:00:53 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE378485F
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5vwDb0m5iThbbDXsJEq+AF+I0XHXzAoR+Y+NocLag6jNFHgW6/U3eYCRV5AOodAsOkKwhBhDRg4+dDIbTIxu4CDILkWsrgjhOCaSJJfVAngqv9xDiLOrSrNCkRjd5Pim6DKP9jpXlz4OhIbZFqDApMA/aTEm9RJ2FcLmxSPVd/WU8vl6Tclrr/CknrfZ2HR+h8GuYYGC9U549iecOdzJbAILnDaQODMs5Sm43+f7QpDbEC+79LMZTRYsf4qNOYjUnZ3aMw4X6kdmZNw8wpv/Z6vELC6hw8DRpACEc01vkBJUZ2JkgwjC0YezahJVgYyp7aPJbmrkUajm0Jr9vM7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XMp6sExPfUQoWIsTBkYxr9mmH5Dwvs/d/TKR4Zc6us=;
 b=akk50xTf2WGNRcT9TuCa+UsHRcxeITHhuPSMK7l7dBrXBe14OZ9GB0tHGuqVBEbjFQpSdAH9wTs50yzluOBz5mAriYPW1gvvLOWGZzkc9u0NkVgpjR9uAk6uoZEy2tvPxzvFV8w3GrcilRTTM2AUf/r/0gzV+klcauxavgRnBomQkolOIZfibMdwTKkFiH2L11i/tZFdFvBxanK9kt62JWQWR1HDHfkkg9q/sAnGU0SgL/uFv/rdYDRMD9Cb4KvH+VQLcRjU2UPtMsw9iABHdqXTW1FJVm0oT0BPvEHtOoTx6Oi28YvyzJCTWMR8vAVAo2T4gTGXZYcZ2bdDyfwyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XMp6sExPfUQoWIsTBkYxr9mmH5Dwvs/d/TKR4Zc6us=;
 b=mOwRTD9RPwNUy+NaJhC0HDFiWRrjNe5G7S/LkjV0E1U9O9c5r3RzuozA5Ycd+pCSeLjPn1JiNr39OE8eSr6Ia6vu4cBc6gOzcDNVWdpPd2Yf0Rwu0dBGLYS/FVBlg6RUfpLwihgXQ0/EGWtcQvty/zUokZO1bjkpcgLGMxjIM/iSe9JMxDyjhDWISp1O2ypqrd14m6p6k/AyuC8y9xCDoey+oDiDTEuP1XsjLPPGyXlPEThf8Ixn6K0n6VHIu0Elm0gRMEETelXgAbdrCgV7napB+UwNU8pBQxIOek0c9c3XYzEjjRj1jEzul5Cb/FU7WsaAQoayuRqSzHhfrvg/Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:00:47 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:00:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v9 0/9] pinctrl: add support of Airoha SoCs
Date: Sun, 24 May 2026 23:00:29 +0300
Message-ID: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: d3004f6b-6477-4292-3d9f-08deb9cf2569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|56012099003|38350700014|921020|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 8ZnG23BQdJHKqAMgsj6UJZ0hgu9k/EhNknwVw8kvkH+lS91FYvYb27Mqkqfv/AyiWlIApn+8pWouTCWJz/C1T+p/Kziry7b9pZno+kxwAGssJsws9dqkShDDqwZE8jUHx1LKE1WdmlmvRoGeEySi5Fb1gocgaIhlPKYgOXHFeTERbO7x7Noc9aFm/ogtlYI9wT6XJLLXvZlKUgMm3hl+m65EizZnOkQp5R3cU4AyofDrdRVOllc48ps0ER6+N64FiXCrSdqI04IJxC00/3njZKBgwNQbG2vFsHzDEDcJk95u1Fc+SNki8l55rrsqcVcQRIqYbZQEWKq9tPXdTqsJ1aXvWDBpHSvIrhMvgRBlzXTClmQEeYwXT0RMB9T3Jqmy3GE7Igpi78BNoFSSf/gwYlkAXHzTyHhIGrer9xzDshgWR07O0WgRRW3Ntc/aEhpB+vieC2f0r7xXeCc/eoV0MwjqwAy1KrH9Ydmlsvlp9fBfelxAvlAWnlnwSvyCmYXD8E661XUa2Xii/xkNhKyl6xzRrc4/WyeJPNc2HxIqZmYH3kRF6uWEbu5PaP8nFTPObWu/NQQPeWaAiVaYg7yalzOuZHFySkcErZ5mhcduX/0X5qnm+8Y0kOn6Q37NWMPbr8O+jOgUQWpcZu0zUQgFJe1QNyDOOEJhGJ2yrltw50zUuBC2I8njz+2stGzZWVFtZqYMkKZtqaSeBQStAPdy1T82Tf113O2Ag/yHzdgVrVK1e6lu9MMn0Uh5tXoZkon4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(38350700014)(921020)(6133799003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkR5RHF6NEQzTm1xMU9CREpNZVN6TUk1UmxJTk44UGVGbTU0aTZJRG5HVDM4?=
 =?utf-8?B?bUdXbWZWb3BYcWpHQ3laSWdOamJWUStqWkhRcG5TT1RnaXZhUUxQSTRraXN6?=
 =?utf-8?B?aFpuUVV0UUZMdHlzSmZ6N0YvS2QydjZQR2NIVHpJcUloVHdtV0ZQeTQyMU1L?=
 =?utf-8?B?ZXBqa2s5MkNmSm1IVFk3TDI5ZVdvYzBlMzFxOVBwU2dFOVBtdEZycTJTbDhk?=
 =?utf-8?B?YXFqN3pwYW1hZGt5Y0NlVm1EOUlIRWcxUit1eUluNm9wa0ROb2xZRFVacm8v?=
 =?utf-8?B?QXVQNDlXUjhmMkFQSUdZdXRoOWt1eDViRWdXcGxhR1ZORFg2WUk3Yy9WMG5Y?=
 =?utf-8?B?aEtPZUNnSXI2b3BhcFJLYWk2ZTFKNWY5Ny9tWkxkaEIxdk9HVk1CRS9KVm9y?=
 =?utf-8?B?MjhqbnZ2V1RaSFhhdU9VVnRPajc2SUhpYitzSmFIVGVWY1FDR0x0TDZoWS90?=
 =?utf-8?B?VGxxWnI4T1hxbDJmQ3lldWYvUmcwR0dWYndKNVJhVTdzZlJSZmN4THVxbjBy?=
 =?utf-8?B?RjRFWE5DaHo3dThkYnFIWitkZ2ZYNDFXUzQ4ck5MbDlaVXZqcm9XdWhmQUQx?=
 =?utf-8?B?QmxUeTVoNU12SkxRczlZLzlsUnR2UUI2OE9kTHRObmtCaXZvalZ1ZUczaXYv?=
 =?utf-8?B?NzJYNHFYUGZvazNVN2NtNmpkTVcyTzJ4RFVvYkpORm1kUlhocUc2QjFUOUsw?=
 =?utf-8?B?SVRiMXFVUDZHN0Raak1Ic3JZVUhYRlVXVVRNWWgrbzhaUjJ0NjAxRWxLVjVJ?=
 =?utf-8?B?TWw3bjlwd3kwdWRod2xoa1htSVVHd3kwdTcwRW1ENWQ5dHA1eG5PVFJtMUxH?=
 =?utf-8?B?bXpoSUtLUTVDaDVqV0ZMUVEzc1BlRkVvKzJjSXFrb0FrYU04bkUyeDJ0WWlZ?=
 =?utf-8?B?ZDA0VkcxN2k5a3dMTGV1TEVPMHlHRDQ4UlBBbWFVK1ZsR0psYWRqUTRPbFBM?=
 =?utf-8?B?b2I2Q0NvR2FUNTNDeUxOcktVSE84US9qMFFpWkFFODJwaGhrSFNGR29kZW85?=
 =?utf-8?B?bGt6MDRKNjdCOWxmaThZRHd4UnJDSHJ6eWNjeHFxZTRSWTFvdkcyMDljZmdB?=
 =?utf-8?B?K3JJSHozMlphcmRsc29sR3k1Sll3TkpPam40bnJUSDM3TElRSWpla05vSE8z?=
 =?utf-8?B?MVZ3bFVJdC9VQkVsYkZ3ZXlXaDBBOXoxNGIrRUdSR21yNFY5bzFOYWV6SjZs?=
 =?utf-8?B?QVlwN0xRaGRWYXJ6VUxiWUNXZk44eXVOMElnNjY1eHllOFpwa2dLNDByY1JJ?=
 =?utf-8?B?UmllWmduMndOd2RIYWVERDlIUUQrSG00a3hIUEtQUVhPVjZJU1RHU1V5Z3dr?=
 =?utf-8?B?Tm03dFdkSTZOY0pRRkZLSVc1SXJvOTJXYVcwQzJuT0JIZTlhQ3NjMzdVLzcr?=
 =?utf-8?B?bWJwRWoydk1DUE03aFJxT3BGWWx1UEFHb3puNWVlcEZxS0ZxaVc3emZqZkJC?=
 =?utf-8?B?T1BwN1Q5bFBLc0g2aG1QZnh4NWpOZ2ZaTjV0U0ZkdCswbktLV2ZPbG42NmJZ?=
 =?utf-8?B?eTVqbURFdm40VFJRT1Z2Z1NKNnFCcXRRRnFHSy80TGhLU2RoN1d6ODVDTi96?=
 =?utf-8?B?UU1JbXc1eDFXbDMvVVR4Y2d5OFV5eGEvZGJFbWJ5dXJLdGVTWUNJVVRvN3ht?=
 =?utf-8?B?bnZOWk9mTmV4ZXBQZjh0NDR4c1hWQTA0a2dkSFpRejMxdUh4MmIxY1J1cmd3?=
 =?utf-8?B?R2w5OEl0eHdvY3orZnplNWJtaThJQTNBTmNhWGhhV0xIbXFqWEYvMUdGQmFV?=
 =?utf-8?B?Y3prWkQ5cnl1ZXI4Vk5PU3FDV2FxMU5CdFRnRUsyWkVzK1pieHZES016S21w?=
 =?utf-8?B?RkZvM3BPU3QzMGFseWUwd3JpZGpkbW5PUHhPWFVGZVRnMDVZeTVsdkpobCsx?=
 =?utf-8?B?cjZUQlR0NmkxS0xkdVd0bTAyRCt6UHR0aThXd0l2YnZCNUtlRFpaOU0rb3o0?=
 =?utf-8?B?cEdhZUJ6OFhnNkdqU2t0YWd6Rk95Mm00YS8yUU1MakNpTkJ1L2kwVW8rcWdF?=
 =?utf-8?B?b1pOd2Q2YzZkOWlkWVdoTzJXMW1BK21QVld5TzhaZ01leVJmdi9velRnd251?=
 =?utf-8?B?UUlSU2hVc3QwdFltTDVkc3lYcVdWMEZ3QitzOXoyelBmVWNuUlRpaFBsQXUy?=
 =?utf-8?B?L1JtNmk5WThodHJBdzlLbVhBNTJ1K0EwUDZUaFE0ZzZmVUNPQzUxNFdIUEU5?=
 =?utf-8?B?OHZnb2UvU0g1Y0Z2aHZCVjFwOXlGYjZrUHRoRVRpeklCckRQV3VHN0p0aUQ4?=
 =?utf-8?B?TXNXeTBCM3RwVnNQLzY5SWVZYjhZOExSa2ZDN0orcFhnYWNlQ3lzbVU0Zm9C?=
 =?utf-8?B?MzhhNHA2dXIyMkVCOWxRQjdPN2tZYUF1RmRyMFBYbi81aXRpT1JhdmFFRmxs?=
 =?utf-8?Q?C92RYWbdrRoONtkY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d3004f6b-6477-4292-3d9f-08deb9cf2569
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:00:47.2766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMFORen1jVbJN12TSyHtIgUsAezzDrzmEUHi3825YIvcs6kUrg1OIR5ZaRVuX30fAziSrWs8G9n9LX5n/AxKlZzkxRgSODlF2tROsAlC8XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

This patch series add pin controller and gpio driver support for AN7581/
AN7583 SoCs. The driver based on official linux airoha pinctrl and
gpio driver with Matheus Sampaio Queiroga changes.

The original Matheus Sampaio Queiroga driver can be taken from the repo:
  https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en7523_pinctrl

This patchset includes bitfield.h patches created for Linux kernel
by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
and original commit messages. It might be not a best strategy, because
these patches refers to other linux kernel commits not added to U-Boot.
Please note me, if there is a better way.

The patches were tested on AN7581/AN7583 boards.
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

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (7):
  bitops: import BITS_PER_TYPE() macro from linux
  pinctrl: add more pinconf/pinctrl definitions
  pinctrl: sort and format the contents of the makefile
  pinctrl: airoha: add shared pinctrl code
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  configs: airoha: an7581: enable pinctrl/gpio support

 configs/an7581_evb_defconfig            |    2 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   21 +
 drivers/pinctrl/airoha/Makefile         |    6 +
 drivers/pinctrl/airoha/airoha-common.h  |  476 ++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 +++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1077 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  980 +++++++++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 13 files changed, 3711 insertions(+), 38 deletions(-)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7583.c
 create mode 100644 include/linux/pinctrl/pinctrl.h

-- 
2.53.0

