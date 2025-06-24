Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25676C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A5E82D88;
	Tue, 24 Jun 2025 15:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="E8wMckLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9127882D17; Tue, 24 Jun 2025 12:25:36 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A389C82BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEAbN5Y1+ocrwtzBSptIxe+58ArtbAr4zsw60AHVPqjjFJQGPHaOJfcgKKQg5aCK7frnlbbuRYRDr5rnoGVHNBg+Z9yIW56inzPD+3Q59m58E7wrgLLWcTCKfJGJYQ6kJWIoXecPX5mekomEBPPtTQhL7qOIehPlZWAeLuX0UXaVU2L583x8XM3u0Jp/RhPWIiuJ7gbFdXlbFPXqpSAcONLidfkkAWfvX5Fo+bAA2h6vrSfMnHsUgOQZ0KcHBtGBDCw/N4MfGkLEbasmJhxR2LRlm59HkPBcf+4eRPFkhXKxGcK10z17oujajRShqGR6zDcNbLJTgQKZkxfpK0IF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0WwUvPwtEy3jT2bResxdQQr0AvawAPXju2eCb8zOJ4=;
 b=h1zYpDYFEjAe47wcrbOMZFRxBJROhWd+U7pv/WBe+2vMkJQ+91u0cXx79UxED9GgTcNpBYS10lCGY8gTNN8PBkXuLTswXOfpUNXGH6AMBpgEDx5geguyKgnNTvRibqT1MmAga/D5WwlC4tyfmy3lw66vgL5agWIZQZ6ia9JgfuOjmUgSfZL5jtMozmHUNyWI22+JJsv6MEU2PyF44XOemSdaGCG505S2fTqfD0j00QhMxHvBqt6ii5bcDGQRundQdcMbTL/vrqIDx1xkgQwlNzGp5Qv/HtTkZoInwNd61mHjVxefYYhMv0opW4MGBsN7w1ROJl6LKcgHl+zEBpBtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0WwUvPwtEy3jT2bResxdQQr0AvawAPXju2eCb8zOJ4=;
 b=E8wMckLbmTSfjasXk7gBXjGErNtiy1zQ+1RVeMC7andaCu1B0u/l5bncQxhUVS85wo2oCAIOcttpO4fOPEU8wLkUm+TiZh//rQRZdKAwdlbvGIctFEz0KNx9+qIvlgmi7f/A/Vcsdp/NCWUVECQDe5wYwcD1sAGbtI0EuHh/pE15RtzbMCuOgfTFVyERpiwrZGVrFSEwXxe7bWM+VKijo1ixoroYBOMc5eYzLMRbJjgb3oI27HAP7fP+qa/tHnKPcRBysLXLdsGtAAPHmFqY47E+4Ou+PoMA5N/kSItRNduXJZCH5QbdBYN2dMEiMx+pplLpKmYaUx+P1Q0TkU9xKA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AS1PR09MB5543.eurprd09.prod.outlook.com (2603:10a6:20b:4a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:25:31 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:25:30 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 01/11] riscv: Add initial support for P8700 SoC
Thread-Topic: [PATCH v2 01/11] riscv: Add initial support for P8700 SoC
Thread-Index: AQHb5PJPh8iMmW7EWUKZ2JrhMaR7rQ==
Date: Tue, 24 Jun 2025 10:25:30 +0000
Message-ID: <20250624102449.324410-2-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AS1PR09MB5543:EE_
x-ms-office365-filtering-correlation-id: 541b555d-9782-44ae-08a1-08ddb309722a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UbCtAM4SQzvH0qZHmHylnNTNScGlapw/ZCKQwrH7eQFqdnQzwepoLMAjCg?=
 =?iso-8859-1?Q?B2SM+Et4vCwErTanyyS0V4sXcE2Ec1KTiUdM9Q24TMnjIUvIcTSGVJgIdx?=
 =?iso-8859-1?Q?uxUK7QrP5KOl+//G4vjOWnNeSz6ZRc6fFt7mrPcs/2MEaLRo2v/V8iYQUv?=
 =?iso-8859-1?Q?KYDj3OnDUt+bZgWNaSrTJwJWTn0+AEEZSJRVYKSUGlt1bQnXkiVBEyuzMK?=
 =?iso-8859-1?Q?1NJMqjc6nvtXP3EW9qYlPrWoM4/79A/6almY2l9JG/1XXP3ptW9/hLqZYW?=
 =?iso-8859-1?Q?3GZpvE0tuds48DRW22Nc/XGejAzZk32gQi/ywwqoSnVylVNLskU6IC3LX4?=
 =?iso-8859-1?Q?p8aXXPweccILYl8eOjE/d6wygtkS12VKXmaEjQ1J8jP/tNeiGrhCw3wrWd?=
 =?iso-8859-1?Q?1X22Jiqv71/WB6TpIbZJVS2O8MAnukWXdF6dUI0EnYffbNW9jLz0JYAZrz?=
 =?iso-8859-1?Q?fG8OGBvNqcXig80LHFOd8XI6rIAALJd7udkzLnmABVi+CRG3SbGlW3oAfY?=
 =?iso-8859-1?Q?5rn+2CLinJPaftCQFTkDj8N07r6mibv4XBmm3puinofAUj4jWqTS1v+XZM?=
 =?iso-8859-1?Q?y/jdRSkVIJFe+oTWVAXpmU5t38teU2iEi+ohgJ5cn6F4hFVv4V5macCUS3?=
 =?iso-8859-1?Q?Yx3AhLsOLaH486O/x7yZ1Zw6NAp2IrUwCFNJgz2Iir/TVrPdP4Beo27FFv?=
 =?iso-8859-1?Q?dqZ21nAJ783JpeMcwWlfZ2PmqvRNl7h8jB7aNcMHj1Ufdgo5YLJiHjdXV1?=
 =?iso-8859-1?Q?OssVAbwPJTn90tZ3bqr0k2b+vbzSqAyb1mimfkAAbooZtdEjQgli6LBwCW?=
 =?iso-8859-1?Q?kIVl/dD2QOSHKa0S7p3XQxoeXstt/2SA36QMmWVeuwYeATsi1NCF3DNsP6?=
 =?iso-8859-1?Q?DCNqG5KLz0plizX7a+E6kNBs3g8FzvPQWyQ0yAj7OFQDUon6mhejInnlZs?=
 =?iso-8859-1?Q?0tazbST9VvJw7lU0XY0jQrVKTTo4O+LXZzpLPQXAIj+lp/fybe4cv7TXHN?=
 =?iso-8859-1?Q?UcXMpYe4KS1MPDRiyEnLtCN1tGZtZGUkxZ5IJCjVZs0OWh6VK3U4DHb2yZ?=
 =?iso-8859-1?Q?ah+jGxk4QKFs78vqH62ZhjBAPfMZpXkCjKrUIN7hFJLOpk9dlH/D2ok55U?=
 =?iso-8859-1?Q?m5gzGaLB/jXLyqKFtb9pa7XD4vqJUy/mr/bJwfnF2gt8ffqmKMuEF2SwXR?=
 =?iso-8859-1?Q?sMDk65DljljZtTQJYjb75+ouU3mvVyvNdcGchLTKWpMnUIBW0w+PB55B8o?=
 =?iso-8859-1?Q?0Nmpx+EiZ1PseFIW0ejK+R4u1pDxcTElF6Rkxi6Jsbb9mu1TKDmsOrIREt?=
 =?iso-8859-1?Q?oDVQkRGBxTzDuslya1FjzhLvujJLFbWFrQK/KmMZ9YdWCguq7QNO81yLZd?=
 =?iso-8859-1?Q?e5sYxwfaKEbCQ/PlxMBvSIxy9CJzXTnhM9Us3kbmkdeAl3l4mwLwi53HvI?=
 =?iso-8859-1?Q?IDM/gb/AhPw6rKP9aqp7oA+9HlpcVo0quLz7FSkgnYASb+JQsRpfqtqW/L?=
 =?iso-8859-1?Q?fvdxDYCCqErLS97sAa6qLir800XE6ahjdDTBDfMNngfQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lqH81mfi/C5dxOAwsiMSJcN53RqQKW5rtE5l6bRAM0rC1CnFEkUvr0TX/T?=
 =?iso-8859-1?Q?ZTZ/PetdLy9zEShvnt0oNMmvKhsW+pdOVepPOZ16ud5AeGQgSPuleNxQDL?=
 =?iso-8859-1?Q?gzHu8m/AhROlzRMMFWjVSDOCMf2HXXUKeUIC856UF6lXycCLK1cq2FQL5X?=
 =?iso-8859-1?Q?4soBaaYWs9A0tVBN7VPpek7SswhBCOBuEu64VEEr9towa4hHAOeyreVP0Y?=
 =?iso-8859-1?Q?5BFdjfrOmPos44jfRaqzB+iaTS7x1c34o8LiZsru+fCe2myF6uD3UdU7io?=
 =?iso-8859-1?Q?h/Fn4S550xtBnSC49GWQdZ7KNxkYI0ukWuCcSveb3q8Ryr8OY366KIDkns?=
 =?iso-8859-1?Q?5svG2gTTqb084O+EgGx26uoFiyGLWjeNMuGaAmYIqQpU62QKA6qqMBKNfM?=
 =?iso-8859-1?Q?8d1OX61TRb39a957451yEz8kxvnwntgx0hTvp2t3fcTaD4X6TIOY6Apfq7?=
 =?iso-8859-1?Q?zusd4pAC+B6ie+/IAMOOG7uVoDyUswczgIySzR/1Kv2os5ndn1WlsKZ/II?=
 =?iso-8859-1?Q?5dBmMsjilaBrpDIr1ZinbEOiJrtzZxsd6hNP38uC9k3mcPt7/oAl71j96j?=
 =?iso-8859-1?Q?/uIpjdW+binfHncoB+WpSyV5dU1m9YyZe3wA4L4bBvqdSPm5gDmPCyGaOt?=
 =?iso-8859-1?Q?rrgqBBkzrdW31xsmRytTtpb12K+6aHrftelVkWL51qLRT2a/2SiA/25jli?=
 =?iso-8859-1?Q?OWnXPXw285dRqCSV/7whHi8GXCrE49GtR80YjXwRut1lHYKWGSwe1U2QuJ?=
 =?iso-8859-1?Q?k/evYq7/xgV3wbBzEmajtYvVtV8/+/EZv6McCqd5RHLhBU5+4G/xc65QiP?=
 =?iso-8859-1?Q?/BUopYHroRwn+eKyA7qwieXqoPEzgerMDA6MkB4e6m2f/gi9hDY+G9nnFR?=
 =?iso-8859-1?Q?Cm/USk+UZeT+heIANDhR+FVTIRg06vQtm/97jwmbEv1WqVOUXlybZxicda?=
 =?iso-8859-1?Q?Di6AHVAtdBvAHIozYeq3he9G7FEQ94kvmmuofBb/L884HRHbCeG42n7NVv?=
 =?iso-8859-1?Q?7FbyXEHdkQ77c0Dh6VTGLYWUKOorodPyYr9/J4wWf5sxtq+iVnRyoYTzxV?=
 =?iso-8859-1?Q?DPQ5YLcVQkxCBJWInYdp1baXIf+v/jPpRJCNdVGdnwrCeFctEzn10azWY1?=
 =?iso-8859-1?Q?uzRuCHGKHQxWc8ftKutAiqcegmSk+mtBiiD0KVs1s+CB1Gy7AbCVH3OmqB?=
 =?iso-8859-1?Q?PgMyPv0M9m1ve3wc3xA0eeTNXhHATl0HEWnKXYFzAKTi2475QuO35my3gQ?=
 =?iso-8859-1?Q?8d8QHqEqXpwo9YycbRUAhDq81qqGt0coGBmrwTHFvjJMgwoF/JYnKUHLBL?=
 =?iso-8859-1?Q?o/WTb1XKEoVuVYnTMKa1IZoPwC96rnLOvSWMr6nmgSCMCd/02cpgweH2sR?=
 =?iso-8859-1?Q?MvuYFlgy0IWzcQ6HmwPKjzB+LTDhFvSDMezPEQgZgdNY5N77fiXmAkBDXv?=
 =?iso-8859-1?Q?D0Td6FLruO7bqZpFsjddnO+7USG0Rx3P+jGroLwmQjVxDLJOnq91sNiLYZ?=
 =?iso-8859-1?Q?fLLAcgjaXMshd8BeVssfcRalSJJXCGrG6RZyv/ITdIC9VR8zK2qmsystFs?=
 =?iso-8859-1?Q?dpsaiByZrtcWQ5YO5XHORMVYmlj+T3uasr1XxW+IJDVTiHySMRUBjYP0PL?=
 =?iso-8859-1?Q?cIXrPSeh3vy1A7wadgJBYXKh1evEA42Wm6N4nMgUer95v9OkMWQzJSKg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541b555d-9782-44ae-08a1-08ddb309722a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:25:30.7444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7rwAYBHJYfghgMF69IgH67wBxEx0XlN+mexKEkDGHQGKF9EDdduy38ZAq25GZ0bmr+JvlDgPorPeRGR2XyxSbwvsEy3h1tUzxnkIR3BvdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5543
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add initial platform support for the P8700-F, a high-performance
multi-core RV64GC SoC with optional multi-cluster configuration and
hardware multithreading.

This patch implements initial support required for U-Boot to run on
the P8700-based Boston board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                          |  11 +
 arch/riscv/cpu/Makefile                     |   2 +
 arch/riscv/cpu/p8700/Kconfig                |  15 ++
 arch/riscv/cpu/p8700/Makefile               |   7 +
 arch/riscv/cpu/p8700/cache.c                |  74 ++++++
 arch/riscv/cpu/p8700/cpu.c                  |  22 ++
 arch/riscv/cpu/p8700/dram.c                 |  37 +++
 arch/riscv/cpu/p8700/p8700_platform_setup.S | 155 ++++++++++++
 arch/riscv/cpu/start.S                      |   8 +
 arch/riscv/dts/Makefile                     |   1 +
 arch/riscv/dts/boston-p8700.dts             | 253 ++++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/p8700.h   | 110 +++++++++
 board/mips/boston-riscv/Kconfig             |  43 ++++
 board/mips/boston-riscv/MAINTAINERS         |   9 +
 board/mips/boston-riscv/Makefile            |   8 +
 board/mips/boston-riscv/boston-lcd.h        |  20 ++
 board/mips/boston-riscv/boston-regs.h       |  38 +++
 board/mips/boston-riscv/boston-riscv.c      |   9 +
 board/mips/boston-riscv/checkboard.c        |  43 ++++
 board/mips/boston-riscv/config.mk           |  15 ++
 board/mips/boston-riscv/lowlevel_init.S     |  18 ++
 board/mips/boston-riscv/reset.c             |  15 ++
 configs/boston-p8700_defconfig              |  94 ++++++++
 drivers/clk/Kconfig                         |   2 +-
 include/asm-generic/global_data.h           |   5 +
 include/configs/boston-riscv.h              |  11 +
 26 files changed, 1024 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/p8700_platform_setup.S
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 include/configs/boston-riscv.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c6feae5735..b05e0622908 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,15 @@ config TARGET_XILINX_MBV
 config TARGET_ASPEED_AST2700_IBEX
 	bool "Support Ibex RISC-V cores on Aspeed AST2700 SoC"
=20
+config TARGET_MIPS_BOSTON
+	bool "Support Mips Boston Board"
+	select DM
+	select DM_GPIO
+	select DM_SERIAL
+	select OF_CONTROL
+	select DISTRO_DEFAULTS
+	imply CMD_DM
+
 endchoice
=20
 config SYS_ICACHE_OFF
@@ -115,6 +124,7 @@ source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
+source "board/mips/boston-riscv/Kconfig"
=20
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
@@ -127,6 +137,7 @@ source "arch/riscv/cpu/jh7110/Kconfig"
 source "arch/riscv/cpu/k1/Kconfig"
 source "arch/riscv/cpu/k230/Kconfig"
 source "arch/riscv/cpu/th1520/Kconfig"
+source "arch/riscv/cpu/p8700/Kconfig"
=20
 # architecture-specific options below
=20
diff --git a/arch/riscv/cpu/Makefile b/arch/riscv/cpu/Makefile
index 6bf6f911c67..38894861694 100644
--- a/arch/riscv/cpu/Makefile
+++ b/arch/riscv/cpu/Makefile
@@ -5,3 +5,5 @@
 extra-y =3D start.o
=20
 obj-y +=3D cpu.o mtrap.o
+
+obj-$(CONFIG_P8700_RISCV) +=3D p8700/p8700_platform_setup.o
diff --git a/arch/riscv/cpu/p8700/Kconfig b/arch/riscv/cpu/p8700/Kconfig
new file mode 100644
index 00000000000..0e5e4c9eda6
--- /dev/null
+++ b/arch/riscv/cpu/p8700/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+
+config P8700_RISCV
+	bool
+	select ARCH_EARLY_INIT_R
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER
+	imply SIFIVE_CLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
+	imply CMD_CPU
+	imply SPL_CPU_SUPPORT
+	imply SPL_OPENSBI
+	imply SPL_LOAD_FIT
diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
new file mode 100644
index 00000000000..ecdd232da6f
--- /dev/null
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+
+obj-y +=3D dram.o
+obj-y +=3D cpu.o
+obj-y +=3D cache.o
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
new file mode 100644
index 00000000000..27641035d80
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#include <cpu_func.h>
+#include <asm/global_data.h>
+#include <asm/arch-p8700/p8700.h>
+
+/* NOTE: We force to use a0 in mcache to encode via .word. */
+#define cache_loop(start, end, lsize, op) do {				\
+	const __typeof__(lsize) __lsize =3D (lsize);			\
+	const register void *addr asm("a0") =3D (const void *)((start) & ~(__lsiz=
e - 1));	\
+	const void *aend =3D (const void *)(((end) - 1) & ~(__lsize - 1));	\
+	for (; addr <=3D aend; addr +=3D __lsize)				\
+		asm volatile (".word 0xec0500f3|%0 # force to use %1" \
+								::"i"((op) << 20), "r"(addr));	\
+} while (0)
+
+static unsigned long lsize;
+static unsigned long l1d_total_size;
+static unsigned long slsize;
+
+static void probe_cache_config(void)
+{
+	lsize =3D 64;
+	l1d_total_size =3D 64 * 1024;
+
+	int l2_config =3D 0;
+	long address =3D GCR_L2_CONFIG;
+
+	asm volatile ("lw %0,0(%1)" : "=3Dr"(l2_config) : "r"(address) : "memory"=
);
+	int l2_line_size_info =3D (l2_config >> L2_LINE_SIZE_SHIFT)
+				& L2_LINE_SIZE_MASK;
+	slsize =3D (l2_line_size_info =3D=3D 0) ? 0 : 1 << (l2_line_size_info + 1=
);
+}
+
+void flush_dcache_range(unsigned long start, unsigned long end)
+{
+	if (lsize =3D=3D 0)
+		probe_cache_config();
+
+	/* aend will be miscalculated when size is zero, so we return here */
+	if (start >=3D end)
+		return;
+
+	cache_loop(start, end, lsize, HIT_WRITEBACK_INV_D);
+
+	/* flush L2 cache */
+	if (slsize)
+		cache_loop(start, end, slsize, HIT_WRITEBACK_INV_SD);
+
+	/* ensure cache ops complete before any further memory access */
+	asm volatile ("slli x0,x0,1 # ihb");
+}
+
+void invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	if (lsize =3D=3D 0)
+		probe_cache_config();
+
+	/* aend will be miscalculated when size is zero, so we return here */
+	if (start >=3D end)
+		return;
+
+	/* invalidate L2 cache */
+	if (slsize)
+		cache_loop(start, end, slsize, HIT_INVALIDATE_SD);
+
+	cache_loop(start, end, lsize, HIT_INVALIDATE_D);
+
+	/* ensure cache ops complete before any further memory access */
+	asm volatile ("slli x0,x0,1 # ihb");
+}
diff --git a/arch/riscv/cpu/p8700/cpu.c b/arch/riscv/cpu/p8700/cpu.c
new file mode 100644
index 00000000000..f13c18942f3
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cpu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <irq_func.h>
+#include <asm/cache.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/dram.c b/arch/riscv/cpu/p8700/dram.c
new file mode 100644
index 00000000000..2b54326be39
--- /dev/null
+++ b/arch/riscv/cpu/p8700/dram.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ */
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+phys_size_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/*
+		 * Ensure that we run from first 4GB so that all
+		 * addresses used by U-Boot are 32bit addresses.
+		 *
+		 * This in-turn ensures that 32bit DMA capable
+		 * devices work fine because DMA mapping APIs will
+		 * provide 32bit DMA addresses only.
+		 */
+		if (gd->ram_top > SZ_4G)
+			return SZ_4G;
+	}
+	return gd->ram_top;
+}
diff --git a/arch/riscv/cpu/p8700/p8700_platform_setup.S b/arch/riscv/cpu/p=
8700/p8700_platform_setup.S
new file mode 100644
index 00000000000..c2999045175
--- /dev/null
+++ b/arch/riscv/cpu/p8700/p8700_platform_setup.S
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <elf.h>
+#include <system-constants.h>
+#include <asm/encoding.h>
+#include <generated/asm-offsets.h>
+#include <asm/arch-p8700/p8700.h>
+
+.global p8700_platform_setup
+.global set_flash_uncached
+
+p8700_platform_setup:
+	move s6, ra
+	li	x1,0
+	li	x2,0
+	li	x3,0
+	li	x4,0
+	li	x5,0
+	li	x6,0
+	li	x7,0
+	li	x8,0
+	li	x9,0
+	li	x10,0
+	li	x11,0
+	li	x12,0
+	li	x13,0
+	li	x14,0
+	li	x15,0
+	li	x16,0
+	li	x17,0
+	li	x18,0
+	li	x19,0
+	li	x20,0
+	li	x21,0
+	li	x23,0
+	li	x24,0
+	li	x25,0
+	li	x26,0
+	li	x27,0
+	li	x28,0
+	li	x29,0
+	li	x30,0
+	li	x31,0
+
+	/* a0 has mhartid */
+	csrr	a0, CSR_MHARTID
+
+	li	t0, BOSTON_PLAT_DDR3STAT
+1:	lw	t1, 0(t0)
+	andi	t1, t1, BOSTON_PLAT_DDR3STAT_CALIB
+	beqz	t1, 1b
+
+	/* Test mhartid lowest 4 bits */
+	andi	t0, a0, 0xf
+	bne	t0, zero, setup_pmp
+
+	li	s0, CM_BASE
+	li	t0, 0x1fb80000
+	/* Get cluster number to update CM_BASE */
+	srl	t1, a0, MHARTID_CLUSTER_SHIFT
+	andi	t1, t1, MHARTID_CLUSTER_MASK
+	sll	t1, t1, CM_BASE_CLUSTER_SHIFT
+	add	s0, s0, t1
+	move	t1, s0
+
+	/* Test mhartid lowest 16 bits */
+	li	t2, 0xffff
+	and	t2, a0, t2
+	bne	t2, zero, cm_relocate_done
+	sd	t1, GCR_BASE_OFFSET(t0)
+cm_relocate_done:
+
+	li	t0, GCR_CL_COH_EN_EN
+
+	/* Get core number to update CM_BASE */
+	srl	t1, a0, MHARTID_CORE_SHIFT
+	andi	t1, t1, MHARTID_CORE_MASK
+	sll	t1, t1, CM_BASE_CORE_SHIFT
+	add	s0, s0, t1
+	INDEXED(sd, t0, t1, P8700_GCR_C0_COH_EN, s0)
+3:
+
+	/* Test mhartid */
+	bne	a0, zero, setup_pmp
+
+	/* Map all PCIe DMA access to its default, non-IOCU, target */
+	li	t0,BOSTON_PLAT_NOCPCIE0ADDR
+	sw	zero, 0(t0)
+	li	t0,BOSTON_PLAT_NOCPCIE1ADDR
+	sw	zero, 0(t0)
+	li	t0,BOSTON_PLAT_NOCPCIE2ADDR
+	sw	zero, 0(t0)
+
+setup_pmp:
+	/* Setup PMP */
+	li	t0, 0x2fffffff # 2G from 0x80000000
+	csrw	pmpaddr1, t0
+	li	t0, 0x07ff7fff # 0x40000 from 0x1ffc0000
+	csrw	pmpaddr2, t0
+	li	t0, 0x07f3ffff # 2M from 0x1fc00000
+	csrw	pmpaddr3, t0
+	li	t0, 0x1fffffffffffffff # All from 0x0
+	csrw	pmpaddr4, t0
+	li	t0, ((PMP_NAPOT | PMP_R | PMP_W | PMP_X) << 32) | \
+			((PMP_NAPOT | PMP_R | PMP_X) << 24) | \
+			((PMP_NAPOT | PMP_R | PMP_W | PMP_X) << 16) | \
+			((PMP_NAPOT | PMP_R | PMP_W | PMP_X) << 8)
+	csrw	pmpcfg0, t0
+
+	/* Test mhartid */
+	bne	a0, zero, 2f
+	/* HART 0: Set cacheable for pmp0, pmp1, pmp3, uncacheable for pmp2, pmp4=
 */
+	li	t0, (CCA_CACHE_DISABLE << 32) | (CCA_CACHE_ENABLE << 24) | \
+			(CCA_CACHE_DISABLE << 16) | (CCA_CACHE_ENABLE << 8) | CCA_CACHE_ENABLE
+	j	3f
+2:	/* HART 1 or above: Set cacheable for pmp0, pmp1, uncacheable for pmp2,=
 pmp3, pmp4 */
+	li	t0, (CCA_CACHE_DISABLE << 32) | (CCA_CACHE_DISABLE << 24) | \
+			(CCA_CACHE_DISABLE << 16) | (CCA_CACHE_ENABLE << 8) | CCA_CACHE_ENABLE
+3:
+	csrw	CSR_PMACFG0, t0
+	fence
+
+	/* Test mhartid */
+	beq	a0, zero, 1f
+	/* Jump to 0x80000000 */
+	li	t0, 0x80000000
+	jr	t0
+1:
+	move ra, s6
+	li s6, 0
+	ret
+
+set_flash_uncached:
+	addi	sp, sp, -16
+	sd	 s6, 0(sp)
+	move s6, ra
+
+	/* Set flash uncached at pmp3 */
+	csrr	t0, CSR_PMACFG0
+	li	t1, 0xffffffffffffffff - (0xff << 24)
+	and	t0, t0, t1
+	li	t1, (CCA_CACHE_DISABLE << 24)
+	or	t0, t0, t1
+	csrw	CSR_PMACFG0, t0
+	fence
+
+	move ra, s6
+	ld	s6, 0(sp)
+	addi	sp, sp, 16
+	ret
diff --git a/arch/riscv/cpu/start.S b/arch/riscv/cpu/start.S
index 7bafdfd390a..e36abb5957b 100644
--- a/arch/riscv/cpu/start.S
+++ b/arch/riscv/cpu/start.S
@@ -39,6 +39,10 @@ secondary_harts_relocation_error:
 .section .text
 .globl _start
 _start:
+#ifdef CONFIG_P8700_RISCV
+	call p8700_platform_setup
+#endif
+
 #if CONFIG_IS_ENABLED(RISCV_MMODE)
 	csrr	a0, CSR_MHARTID
 #endif
@@ -416,6 +420,10 @@ call_board_init_r:
 	mv	a1, s4			/* dest_addr */
 	mv	s0, zero		/* fp =3D=3D NULL */
=20
+#ifdef CONFIG_P8700_RISCV
+	call set_flash_uncached
+#endif
+
 /*
  * jump to it ...
  */
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index cf1872f3fdc..60a8c8f93b1 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_TARGET_TH1520_LPI4A) +=3D th1520-lichee-pi-4=
a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) +=3D ast2700-ibex.dtb
+dtb-$(CONFIG_TARGET_MIPS_BOSTON) +=3D boston-p8700.dtb
=20
 include $(srctree)/scripts/Makefile.dts
=20
diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p8700.=
dts
new file mode 100644
index 00000000000..6d700a5675c
--- /dev/null
+++ b/arch/riscv/dts/boston-p8700.dts
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/clock/boston-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	model =3D "p8700";
+	compatible =3D "img,boston";
+
+	chosen {
+		stdout-path =3D &uart0;
+		bootargs =3D "root=3D/dev/sda rw earlycon console=3DttyS0,115200n8r";
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		timebase-frequency =3D <20000000>;
+
+		cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "riscv";
+			mmu-type =3D "riscv,sv39";
+			riscv,isa =3D "rv64imafdcsu";
+			status =3D "okay";
+			reg =3D <0>;
+			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
+			clock-frequency =3D <20000000>;
+			bootph-all;
+		};
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x80000000>;
+	};
+
+	gic: interrupt-controller {
+		compatible =3D "mti,gic";
+
+		interrupt-controller;
+		#interrupt-cells =3D <3>;
+
+		timer {
+			compatible =3D "mti,gic-timer";
+			interrupts =3D <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
+		};
+	};
+
+	pci0: pci@10000000 {
+		status =3D "disabled";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		device_type =3D "pci";
+		reg =3D <0x10000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x40000000
+			  0x40000000 0 0x40000000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci0_intc 1>,
+				<0 0 0 2 &pci0_intc 2>,
+				<0 0 0 3 &pci0_intc 3>,
+				<0 0 0 4 &pci0_intc 4>;
+
+		pci0_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+	};
+
+	pci1: pci@12000000 {
+		status =3D "disabled";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		device_type =3D "pci";
+		reg =3D <0x12000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x20000000
+			  0x20000000 0 0x20000000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci1_intc 1>,
+				<0 0 0 2 &pci1_intc 2>,
+				<0 0 0 3 &pci1_intc 3>,
+				<0 0 0 4 &pci1_intc 4>;
+
+		pci1_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+	};
+
+	pci2: pci@14000000 {
+		status =3D "disabled";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		device_type =3D "pci";
+		reg =3D <0x14000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x16000000
+			  0x16000000 0 0x100000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci2_intc 1>,
+				<0 0 0 2 &pci2_intc 2>,
+				<0 0 0 3 &pci2_intc 3>,
+				<0 0 0 4 &pci2_intc 4>;
+
+		pci2_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+
+		pci2_root@0,0,0 {
+			compatible =3D "pci10ee,7021", "pci-bridge";
+			reg =3D <0x00000000 0 0 0 0>;
+
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			#interrupt-cells =3D <1>;
+
+			eg20t_bridge@1,0,0 {
+				compatible =3D "pci8086,8800", "pci-bridge";
+				reg =3D <0x00010000 0 0 0 0>;
+
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+				#interrupt-cells =3D <1>;
+
+				eg20t_mac@2,0,1 {
+					compatible =3D "pci8086,8802", "intel,pch-gbe";
+					reg =3D <0x00020100 0 0 0 0>;
+					phy-reset-gpios =3D <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
+				};
+
+				eg20t_gpio: eg20t_gpio@2,0,2 {
+					compatible =3D "pci8086,8803", "intel,eg20t-gpio";
+					reg =3D <0x00020200 0 0 0 0>;
+
+					gpio-controller;
+					#gpio-cells =3D <2>;
+				};
+
+				mmc0: mmc@2,4,0 {
+					compatible =3D "intel,apl-sd";
+					reg =3D <0x00022000 0 0 0 0>;
+				};
+
+				mmc1: mmc@2,4,1 {
+					compatible =3D "intel,apl-sd";
+					reg =3D <0x00022100 0 0 0 0>;
+				};
+
+				eg20t_i2c@2,12,2 {
+					compatible =3D "pci8086,8817";
+					reg =3D <0x00026200 0 0 0 0>;
+
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					rtc@0x68 {
+						compatible =3D "st,m41t81s";
+						reg =3D <0x68>;
+					};
+				};
+			};
+		};
+	};
+
+	plat_regs: system-controller@17ffd000 {
+		compatible =3D "img,boston-platform-regs", "syscon";
+		reg =3D <0x17ffd000 0x1000>;
+		bootph-all;
+	};
+
+	clk_boston: clock {
+		compatible =3D "img,boston-clock";
+		#clock-cells =3D <1>;
+		regmap =3D <&plat_regs>;
+		bootph-all;
+	};
+
+	reboot: syscon-reboot {
+		compatible =3D "syscon-reboot";
+		regmap =3D <&plat_regs>;
+		offset =3D <0x10>;
+		mask =3D <0x10>;
+	};
+
+	uart0: uart@17ffe000 {
+		compatible =3D "ns16550a";
+		reg =3D <0x17ffe000 0x1000>;
+		reg-shift =3D <2>;
+		reg-io-width =3D <4>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks =3D <&clk_boston BOSTON_CLK_SYS>;
+		clock-frequency =3D <20000000>;
+
+		bootph-all;
+	};
+
+	lcd: lcd@17fff000 {
+		compatible =3D "img,boston-lcd";
+		reg =3D <0x17fff000 0x8>;
+	};
+
+	flash@18000000 {
+		compatible =3D "cfi-flash";
+		reg =3D <0x18000000 0x8000000>;
+		bank-width =3D <2>;
+	};
+};
diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
new file mode 100644
index 00000000000..5ca9b4b9497
--- /dev/null
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __P8700_H__
+#define __P8700_H__
+
+#define CSR_MIPSCONFIG7		0x7d7
+#define CSR_PMACFG0			0x7e0
+
+#define MHARTID_HART_SHIFT	0
+#define MHARTID_HART_MASK	0xf
+#define MHARTID_CORE_SHIFT	4
+#define MHARTID_CORE_MASK	0xff
+#define MHARTID_CLUSTER_SHIFT	16
+#define MHARTID_CLUSTER_MASK	0xf
+
+#define MARCHID_UARCH_SHIFT	0
+#define MARCHID_UARCH_MASK	0xff
+#define MARCHID_CLASS_SHIFT	8
+#define MARCHID_CLASS_MASK	0xff
+#define MARCHID_CLASS_M		0
+#define MARCHID_CLASS_I		1
+#define MARCHID_CLASS_P		2
+
+#define CM_BASE_CORE_SHIFT	8
+#define CM_BASE_CLUSTER_SHIFT	19
+
+#define P8700_TIMER_ADDR	0x16108050
+
+#define CCA_CACHE_ENABLE	0
+#define CCA_BUFFER_CACHE	1
+#define CCA_CACHE_DISABLE	2
+#define CCA_UNCACHE_ACC		3
+#define PMA_SPECULATION		(0x1 << 3)
+
+#define L1_I_CACHE      0
+#define L1_D_CACHE      1
+#define L3_CACHE        2
+#define L2_CACHE        3
+
+#define HIT_INVALIDATE          4
+#define HIT_WRITEBACK_INV       5
+
+#define HIT_INVALIDATE_D        ((HIT_INVALIDATE << 2) | L1_D_CACHE)
+#define HIT_INVALIDATE_SD       ((HIT_INVALIDATE << 2) | L2_CACHE)
+#define HIT_WRITEBACK_INV_D     ((HIT_WRITEBACK_INV << 2) | L1_D_CACHE)
+#define HIT_WRITEBACK_INV_SD    ((HIT_WRITEBACK_INV << 2) | L2_CACHE)
+
+#define L1D_LINE_SIZE_SHIFT	10
+#define L1D_LINE_SIZE_MASK	0x7
+
+#define GCR_L2_CONFIG	0x16100130
+#define L2_LINE_SIZE_SHIFT	8
+#define L2_LINE_SIZE_MASK	0xf
+
+#define PMP_R			0x01
+#define PMP_W			0x02
+#define PMP_X			0x04
+#define PMP_TOR			0x8
+#define PMP_NA4			0x10
+#define PMP_NAPOT		0x18
+
+#define CM_BASE			0x16100000
+#define CPC_BASE		(CM_BASE + 0x8000)
+
+/* CPC Block offsets */
+#define CPC_OFF_LOCAL		0x2000
+
+#define CPC_PWRUP_CTL		0x0030
+
+#define CPC_SYS_CONFIG		0x0140
+
+#define CPC_Cx_CMD		0x0000
+#define CPC_Cx_CMD_RESET	0x4
+
+#define P8700_GCR_C0_COH_EN	0x20f8
+#define P8700_GCR_C1_COH_EN	0x21f8
+#define P8700_GCR_C2_COH_EN	0x22f8
+#define P8700_GCR_C3_COH_EN	0x23f8
+#define P8700_GCR_C4_COH_EN	0x24f8
+#define P8700_GCR_C5_COH_EN	0x25f8
+
+#define GCR_CL_COH_EN		0x2008
+#define GCR_CL_COH_EN_EN	(0x1 << 0)
+#define GCR_BASE_OFFSET		0x0008
+#define GIC_BASE_OFFSET		0x0080
+#define CPC_BASE_OFFSET		0x0088
+#define ENABLE			0x1
+#define COUNT_STOP		(0x1 << 28)
+#define GIC_LOCAL_SECTION_OFS	0x8000
+#define GIC_VL_MASK		0x08
+#define GIC_VL_RMASK		0x0c
+#define GIC_VL_SMASK		0x10
+#define GIC_VL_COMPARE_MAP	0x44
+
+#define INDEXED(op, reg, idx, offset, base) \
+	li	idx, offset	;\
+	add	idx, idx, base	;\
+	op	reg, (idx)
+
+#define BOSTON_PLAT_BASE	0x17ffd000
+#define BOSTON_PLAT_DDR3STAT	(BOSTON_PLAT_BASE + 0x14)
+#define BOSTON_PLAT_DDR3STAT_CALIB	(0x1 << 2)
+#define BOSTON_PLAT_NOCPCIE0ADDR        (BOSTON_PLAT_BASE + 0x3c)
+#define BOSTON_PLAT_NOCPCIE1ADDR        (BOSTON_PLAT_BASE + 0x40)
+#define BOSTON_PLAT_NOCPCIE2ADDR        (BOSTON_PLAT_BASE + 0x44)
+
+#endif /* __P8700_H__ */
diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
new file mode 100644
index 00000000000..68c5fc50489
--- /dev/null
+++ b/board/mips/boston-riscv/Kconfig
@@ -0,0 +1,43 @@
+if TARGET_MIPS_BOSTON
+
+config SYS_BOARD
+	default "boston-riscv"
+
+config SYS_VENDOR
+	default "mips"
+
+config SYS_CONFIG_NAME
+	default "boston-riscv"
+
+config SYS_CPU
+	default "p8700"
+
+config BOARD_SPECIFIC_OPTIONS
+    def_bool y
+    select P8700_RISCV
+    imply SYS_NS16550
+
+config SYS_CACHELINE_SIZE
+    default 64
+
+config SYS_SDRAM_BASE
+    hex
+    default 0x80000000
+
+config SYS_INIT_SP_ADDR
+    hex
+    default 0x80200000
+
+config STANDALONE_LOAD_ADDR
+    hex
+    default 0x80200000
+
+config SYS_MAX_FLASH_BANKS_DETECT
+    bool
+    default y
+
+config PHY_REALTEK
+    bool
+    default y
+
+endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
new file mode 100644
index 00000000000..e350121395e
--- /dev/null
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -0,0 +1,9 @@
+BOSTON-RISCV BOARD
+M:	Chao-ying Fu <cfu@mips.com>
+S:	Maintained
+F:	board/mips/boston-riscv/
+F:	include/configs/boston-riscv.h
+F:  arch/riscv/cpu/p8700/
+F:  arch/riscv/include/asm/arch-p8700/
+F:  configs/boston-p8700_defconfig
+F:  arch/riscv/dts/boston-p8700.dts
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
new file mode 100644
index 00000000000..9032e2ad6bb
--- /dev/null
+++ b/board/mips/boston-riscv/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2016 Imagination Technologies
+
+obj-y +=3D checkboard.o
+obj-y +=3D lowlevel_init.o
+obj-y +=3D boston-riscv.o
+obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/boston-lcd.h b/board/mips/boston-riscv=
/boston-lcd.h
new file mode 100644
index 00000000000..5f5cd0fe126
--- /dev/null
+++ b/board/mips/boston-riscv/boston-lcd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#ifndef __BOARD_BOSTON_LCD_H__
+#define __BOARD_BOSTON_LCD_H__
+
+/**
+ * lowlevel_display() - Display a message on Boston's LCD
+ * @msg: The string to display
+ *
+ * Display the string @msg on the 7 character LCD display of the Boston bo=
ard.
+ * This is typically used for debug or to present some form of status
+ * indication to the user, allowing faults to be identified when things go
+ * wrong early enough that the UART isn't up.
+ */
+void lowlevel_display(const char msg[static 8]);
+
+#endif /* __BOARD_BOSTON_LCD_H__ */
diff --git a/board/mips/boston-riscv/boston-regs.h b/board/mips/boston-risc=
v/boston-regs.h
new file mode 100644
index 00000000000..4d5ea8833ab
--- /dev/null
+++ b/board/mips/boston-riscv/boston-regs.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#ifndef __BOARD_BOSTON_REGS_H__
+#define __BOARD_BOSTON_REGS_H__
+
+#ifndef BOSTON_PLAT_BASE
+#define BOSTON_PLAT_BASE		(0x17ffd000)
+#endif
+#define BOSTON_LCD_BASE			(0x17fff000)
+
+/*
+ * Platform Register Definitions
+ */
+#define BOSTON_PLAT_CORE_CL		(BOSTON_PLAT_BASE + 0x04)
+
+#define BOSTON_PLAT_SOFT_RST		(BOSTON_PLAT_BASE + 0x10)
+#define BOSTON_PLAT_SOFT_RST_SYSTEM	(0x1 << 4)
+
+#define BOSTON_PLAT_DDR3STAT		(BOSTON_PLAT_BASE + 0x14)
+#define BOSTON_PLAT_DDR3STAT_CALIB	(0x1 << 2)
+
+#define BOSTON_PLAT_BUILDCFG0           (BOSTON_PLAT_BASE + 0x34)
+#define BOSTON_PLAT_BUILDCFG0_IOCU     (0x1 << 0)
+#define BOSTON_PLAT_BUILDCFG0_PCIE0    (0x1 << 1)
+#define BOSTON_PLAT_BUILDCFG0_PCIE1    (0x1 << 2)
+#define BOSTON_PLAT_BUILDCFG0_PCIE2    (0x1 << 3)
+#define BOSTON_PLAT_BUILDCFG0_CFG_LTR  (0xf << 4)
+#define BOSTON_PLAT_BUILDCFG0_CFG_NUM  (0xff << 8)
+#define BOSTON_PLAT_BUILDCFG0_DP       (0x1 << 24)
+#define BOSTON_PLAT_BUILDCFG0_DP_MULT  (0xf << 28)
+
+#define BOSTON_PLAT_DDRCONF0		(BOSTON_PLAT_BASE + 0x38)
+#define BOSTON_PLAT_DDRCONF0_SIZE	(0xf << 0)
+
+#endif /* __BOARD_BOSTON_REGS_H__ */
diff --git a/board/mips/boston-riscv/boston-riscv.c b/board/mips/boston-ris=
cv/boston-riscv.c
new file mode 100644
index 00000000000..e5cd6c42cf7
--- /dev/null
+++ b/board/mips/boston-riscv/boston-riscv.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/mips/boston-riscv/checkboard.c b/board/mips/boston-riscv=
/checkboard.c
new file mode 100644
index 00000000000..cc04bc47803
--- /dev/null
+++ b/board/mips/boston-riscv/checkboard.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include "boston-lcd.h"
+#include "boston-regs.h"
+#include <asm/arch-p8700/p8700.h>
+
+int checkboard(void)
+{
+	u32 changelist, cfg, core, uarch;
+	u64 marchid;
+
+	lowlevel_display("U-boot  ");
+
+	printf("Board: Mips Boston RISC-V\n");
+
+	changelist =3D __raw_readl((uint32_t *)BOSTON_PLAT_CORE_CL);
+	if (changelist > 1) {
+		asm volatile ("csrr %0, marchid" : "=3Dr"(marchid)::);
+		core =3D (marchid >> MARCHID_CLASS_SHIFT) & MARCHID_CLASS_MASK;
+		uarch =3D (marchid >> MARCHID_UARCH_SHIFT) & MARCHID_UARCH_MASK;
+
+		printf("Core:  class%x uarch%x cl%x", core, uarch, changelist);
+
+		cfg =3D __raw_readl((uint32_t *)BOSTON_PLAT_BUILDCFG0);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_CFG_NUM)
+			printf(" config %u",
+			       (cfg & BOSTON_PLAT_BUILDCFG0_CFG_NUM) >> 8);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_CFG_LTR)
+			printf("%c",
+			       'a' + ((cfg & BOSTON_PLAT_BUILDCFG0_CFG_LTR) >> 4) - 1);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_DP)
+			printf(", x%u debug port",
+			       (cfg & BOSTON_PLAT_BUILDCFG0_DP_MULT) >> 28);
+		printf("\n");
+	}
+
+	return 0;
+}
diff --git a/board/mips/boston-riscv/config.mk b/board/mips/boston-riscv/co=
nfig.mk
new file mode 100644
index 00000000000..c1e242f1088
--- /dev/null
+++ b/board/mips/boston-riscv/config.mk
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+quiet_cmd_srec_cat =3D SRECCAT $@
+      cmd_srec_cat =3D srec_cat -output $@ -$2 \
+			$< -binary \
+			-fill 0x00 -within $< -binary -range-pad 16 \
+			-offset $3
+
+u-boot.mcs: u-boot.bin
+	$(call cmd,srec_cat,intel,0x7c00000)
+
+# if srec_cat is present build u-boot.mcs by default
+has_srec_cat =3D $(call try-run,srec_cat -VERSion,y,n)
+INPUTS-$(has_srec_cat) +=3D u-boot.mcs
+CLEAN_FILES +=3D u-boot.mcs
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
new file mode 100644
index 00000000000..8fa85749e40
--- /dev/null
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include "boston-regs.h"
+
+.data
+
+msg_ddr_cal:	.ascii "DDR Cal "
+msg_ddr_ok:	.ascii "DDR OK  "
+
+.text
+
+	.globl lowlevel_display
+lowlevel_display:
+	li	t0, BOSTON_LCD_BASE
+	jr	ra
diff --git a/board/mips/boston-riscv/reset.c b/board/mips/boston-riscv/rese=
t.c
new file mode 100644
index 00000000000..911a051c3d3
--- /dev/null
+++ b/board/mips/boston-riscv/reset.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ */
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include "boston-regs.h"
+
+void _machine_restart(void)
+{
+	writel(BOSTON_PLAT_SOFT_RST_SYSTEM, (void __iomem *)BOSTON_PLAT_SOFT_RST)=
;
+
+	udelay(1000);
+}
diff --git a/configs/boston-p8700_defconfig b/configs/boston-p8700_defconfi=
g
new file mode 100644
index 00000000000..3df7ffe50b3
--- /dev/null
+++ b/configs/boston-p8700_defconfig
@@ -0,0 +1,94 @@
+CONFIG_RISCV=3Dy
+CONFIG_SYS_TEXT_BASE=3D0x1fc00000
+CONFIG_ENV_SIZE=3D0x40000
+CONFIG_ENV_SECT_SIZE=3D0x40000
+CONFIG_TARGET_MIPS_BOSTON=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"boston-p8700"
+
+CONFIG_DISTRO_DEFAULTS=3Dy
+CONFIG_FIT=3Dy
+CONFIG_FIT_VERBOSE=3Dy
+CONFIG_FIT_BEST_MATCH=3Dy
+CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
+CONFIG_SYS_PROMPT=3D"boston # "
+CONFIG_CMD_GREPENV=3Dy
+CONFIG_CMD_MEMTEST=3Dy
+CONFIG_SYS_MEMTEST_START=3D0x80000000
+CONFIG_SYS_MEMTEST_END=3D0x90000000
+CONFIG_BOOTDELAY=3D-1
+
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_ARCH_RV64I=3Dy
+CONFIG_DISPLAY_CPUINFO=3Dy
+CONFIG_DISPLAY_BOARDINFO=3Dy
+#CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
+#CONFIG_CMD_NVEDIT_EFI=3Dy
+CONFIG_CMD_MII=3Dy
+# CONFIG_OF_PRIOR_STAGE=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_SMP=3Dn
+CONFIG_XIP=3Dy
+CONFIG_CLK_BOSTON=3Dy
+CONFIG_RISCV_ISA_C=3Dn
+CONFIG_SHOW_REGS=3Dy
+CONFIG_SYS_NS16550=3Dy
+
+CONFIG_CMD_PCI=3Dy
+CONFIG_CMD_SNTP=3Dy
+CONFIG_CMD_DNS=3Dy
+CONFIG_CMD_LINK_LOCAL=3Dy
+CONFIG_CMD_TIME=3Dy
+CONFIG_CMD_EXT4_WRITE=3Dy
+CONFIG_ENV_IS_IN_FLASH=3Dy
+CONFIG_ENV_ADDR=3D0x1ffc0000
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_MTD=3Dy
+CONFIG_MTD_NOR_FLASH=3Dy
+CONFIG_FLASH_CFI_DRIVER=3Dy
+CONFIG_CFI_FLASH=3Dy
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=3Dy
+CONFIG_SYS_FLASH_USE_PROTECTION=3Dy
+CONFIG_SYS_FLASH_CFI=3Dy
+CONFIG_SYS_FLASH_PROTECTION=3Dy
+CONFIG_DM_ETH=3Dy
+CONFIG_PCH_GBE=3Dy
+CONFIG_PCI=3Dy
+CONFIG_DM_PCI=3Dy
+CONFIG_PCI_XILINX=3Dy
+CONFIG_LZ4=3Dy
+CONFIG_CLK=3Dy
+CONFIG_EG20T_GPIO=3Dy
+
+CONFIG_MMC=3Dy
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_CMD_CPU=3Dy
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_DHCP=3Dy
+CONFIG_CMD_PING=3Dy
+CONFIG_CMD_EXT4=3Dy
+CONFIG_CMD_FAT=3Dy
+CONFIG_CMD_FS_GENERIC=3Dy
+CONFIG_OF_EMBED=3Dy
+CONFIG_CPU=3Dy
+CONFIG_MMC_SDHCI=3Dy
+CONFIG_MMC_PCI=3Dy
+
+CONFIG_UNIT_TEST=3Dy
+CONFIG_UT_LIB=3Dn
+CONFIG_UT_LIB_ASN1=3Dn
+CONFIG_UT_LOG=3Dn
+CONFIG_UT_TIME=3Dy
+CONFIG_UT_UNICODE=3Dn
+CONFIG_UT_ENV=3Dn
+CONFIG_UT_OVERLAY=3Dn
+
+CONFIG_SYS_LOAD_ADDR=3D0x80000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
+CONFIG_TEXT_BASE=3D0x1fc00000
+CONFIG_SYS_MALLOC_LEN=3D0x00800000
+CONFIG_SYS_BOOTM_LEN=3D0x04000000
+CONFIG_SYS_MAX_FLASH_SECT=3D1024
+CONFIG_PHY_ANEG_TIMEOUT=3D40000
+CONFIG_NET_RETRY_COUNT=3D10
+CONFIG_ENV_CALLBACK_LIST_STATIC=3D"io.coherent:io_coherent,"
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 19aa2ffa539..449e72daa23 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -49,7 +49,7 @@ config CLK_BCM6345
 	  clocks on BCM6345 SoCs. HW has no rate changing capabilities.
=20
 config CLK_BOSTON
-	def_bool y if TARGET_BOSTON
+	def_bool y if TARGET_BOSTON || TARGET_MIPS_BOSTON
 	depends on CLK
 	select REGMAP
 	select SYSCON
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global=
_data.h
index 506ee51cdb0..7b25de7bb68 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -702,6 +702,11 @@ enum gd_flags {
 	 * drivers shall not be called.
 	 */
 	GD_FLG_HAVE_CONSOLE =3D 0x8000000,
+	/**
+	 * @GD_FLG_COHERENT_DMA: DMA is cache-coherent.
+	 *
+	 */
+	GD_FLG_COHERENT_DMA =3D 0x10000000,
 };
=20
 #endif /* __ASSEMBLY__ */
diff --git a/include/configs/boston-riscv.h b/include/configs/boston-riscv.=
h
new file mode 100644
index 00000000000..3b3e2567214
--- /dev/null
+++ b/include/configs/boston-riscv.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __CONFIG_BOSTON_RISCV_H
+#define __CONFIG_BOSTON_RISCV_H
+
+#include <linux/sizes.h>
+
+#endif /* __CONFIG_BOSTON_RISCV_H */
--=20
2.34.1
