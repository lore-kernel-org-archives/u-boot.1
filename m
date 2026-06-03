Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2425CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41E6839A8;
	Wed,  3 Jun 2026 09:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="j05zu4Q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8AD8486D; Wed,  3 Jun 2026 09:51:01 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABD48341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amkflnA/vV1U6L/Rd5Lme+NEW4ASfgf/Xp54z5YYjFvllgMbZOkQlAnaOIJ0lyKEub6ysEokTrmXLMn4gfuVwnIaIMbQ4XkWYhWkgwxQZbL9WRJ7j9sJELgxCndy6NUcU9SLhS8b2l0uXuzqAA2xT4dlz0IEXU+y/7HtQlD15F0foNvQ7FJy5ou87+JDzlKQG76TcNQpsNUyVRrGHEtn53YP3jUlDjKpjf/L3j60/cz1+4Y4ECwh+5MFD2EXE96kQNgul83VvaEkEuzjyk8YDnLPt6RtVcUPregmBIbvgyS59pk5oT0ICNgwVXFS3s2EsEi3/oPpNyOL1P/Fy7lH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMAzDWjiXefywOvBjqvgAXAYDUDXPiJItUAX8TFRsVA=;
 b=BqRZdlaUTWbjW2iWYqWivmKdoL6CtOHzQfUh8ZVIs3LURjP3UJqSS+DSFOd9hcdaxTNdaKAurqtu1o3gEfiPijynyBu4c2jPYPfFg44ig4D0SUk9yCaPECDb1sKKAfhh/Q9WWqwZytZVOqHP884FNhcGfbOLzqorExIo0cu71ZV4F+KEJT5twIaWYjGYHcsZoxRhnhWi19WLnflOGzs42gDWJpeTYAZhe3nch2m5xcAQCobwD92c31yzn8AlZnl95gzZJCYIkcV31XKBWie8i3w+kLYBACSwcrwa76pNcgQBsSiQ+OVnugN/IvtA+HZQtPVj8kkpSpJfWIvOLz0jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMAzDWjiXefywOvBjqvgAXAYDUDXPiJItUAX8TFRsVA=;
 b=j05zu4Q/g66NDfCX8JSBK9+fnGBe/gumhS7Vi3KweO8I/wTYAFSzNcLPIKw5sAXPbRY1dc6Q3PS+wD8fjZisgviuvOgYPmQ8d2ekEhBLOEqxgXZvctBU1vXEp/0NBieENGxpCM7hDT1NOXkvHr2HfXiHSyj2OyNb20HAOOFKskG/PuHYFOelJA8wonfjKi54VaBgyooeY0G+YPdcn9X7ybsUUUvDXm/aYyJoV/JFsr/GaXiNsgSzBiQRkPYvBhihcELk7Vi6OR+qK0RUq8ARl/7aZV8I4Bux++OsbiuZqw81wuPPYwUD5VLgSlHDSTDsdDLe54hyj/sX3ZwQiqbB4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DS1PR03MB7920.namprd03.prod.outlook.com (2603:10b6:8:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:50:54 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:50:54 +0000
Message-ID: <a4749046-14bd-4b66-ab5d-1306a7eb4a3d@altera.com>
Date: Wed, 3 Jun 2026 15:50:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] SoCFPGA: Update Boot Support for Stratix10 in
 U-Boot
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DS1PR03MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 300dd283-0c91-4a31-7193-08dec144d6c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|55112099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JQ1zuyHSmXVsbSSPfPaLamRNRMrBdG7/TqXmNsYIzRcgIbDS5NbIBIlb229AsqE0xyjywMdubFYpQ1ifhMUy7mrO8VbY4XP/bBNlicfg0uhjf/q7Pyhf5UOUdVu6TRs3NpHNAfkeFGz6qxFKNM8wzUa+fOfCO32TQMp0p4Vrhx6UzdcqgqCAHa83qRvSZMKlHeUigFI2Qd+VmzATygLRsTLiAhunEcf/Ow4OrudbMIenPqJjSU47K5gZ/TEYyszP4MOctzsLv3HKrz7Xb0fhdrvEAhLpXZlje4YdZ18S8qyUxMpjg33B6wQXFofG20R5MV2cc2Tq8zlTTkCMg8aowTKyFMKfULQWX+5n4qKpELUueHWNKBCYe+TU/JTs9FESLdjtUYj9pbatI/S2v31jl8mxiDXG4ORDdxcqa3fHJbhGo/pvb24apL8gFxu2fchx1I0uMrWo0FcaaAZOUOjkt/4Ze1soXMFtRNi4ag89LKWMTM/Ts91jD9WoPq2kCywrgAw5FuypcJv9PPWP5opyyXWB2iX0jhNHxuZHANCoPeJCygO5h0VCR0doh+Yr+b13OhPBcjSfhdOl4PX8U6zLYDyaAl5V8Nwt9xNO+U2F84tBL7/Og3QndUG/O6Y6xGlrinlwVra+XAvAXt50mp1tWChIxcbRQjDhjuBCKEsHLV+Qw3LKI1FIwRr/BS7M1/0y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(55112099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGc5azFVNEFwWDlLN0RXRXA2VEZXbHRsQ3BXV1RQMXBiVGtzK25rY3VTY21u?=
 =?utf-8?B?bG9Zd3VOYlR6WWFRWjJvTy9NUlhITTRrS0RYSzBWb2h6NVMwNG1PTS92aTEw?=
 =?utf-8?B?b29iS3FPSWxEcTZENGgzOW9pMUJ4QmY4WDVuZ0VTcnAya3BXbTFhYVA5eFJl?=
 =?utf-8?B?K2lxa0gwRk11UDhDT3BUS01TVHZDVERsYXVldDNTWjVVcjRzMXdPaHA1d0Zx?=
 =?utf-8?B?RmYxc2tVT2c2c2kwSk1GV29QNWRPaUFJQ2p1eUZpNGpuaTZYcTllU3RybkdY?=
 =?utf-8?B?MFE5ck51Y0xIeFNjeWVZM3lvUHVSWUxxSkZubjhXUjBLbDI5eDdUWi9hN0Qr?=
 =?utf-8?B?L3dXTlgwWDlydERwUm54aXdUb2hCaDJtbi9jdVA4azE4UklnWGhKbGV5ZWYy?=
 =?utf-8?B?RkpqKys4RUhIUUVyYndyeVhxYlNtNEdSRjFmU2txcmtSWU52TEFBcWJFWEJQ?=
 =?utf-8?B?eU4xRHZhSm9pNFRTSGlkZkdzTHdYTEdSZkw4eUlhenNEWmVnV1lDQXBqNGRL?=
 =?utf-8?B?RVRSU0Fxd0VzVVlDY2FQZVVGRkVuYjNoTHJ5dm9SRWxray9XUlJxeDJZeFRG?=
 =?utf-8?B?YlhCcEdoRjZOUy94QWxETnZBTHdRVmVrVWVOSEFYK3piSXIwWFRncUl0TVZ2?=
 =?utf-8?B?UGFVSDdCUFlWWjk3Z1F4d084azd0Kzc0SUYzM2J1a1NMVkQyeVNjdW1kQzBV?=
 =?utf-8?B?RE4xbWZzbVNaSFZnMFlXWjdLOC9Fb0Z6T2owYVM1TVY3Q3NMem1MTEJOamFG?=
 =?utf-8?B?Y05mWjZ2NGREc3lNRnU4TXc1RjdMclhwZ1k1UjYrU2lsc0ZPbDBNbDhoUVUy?=
 =?utf-8?B?RFJKZEtWNldsbm1JdjJtUWNaVm1ibllWamhTOUNESmxVNC9GTmZvQ2xvMEN5?=
 =?utf-8?B?OEMrOEF0ZHpJbE1TZFV1TzNlYlVIUk9FK0k0Q1ZYNDBYbkozZGJXMDM5QnAz?=
 =?utf-8?B?RWVpTldlclh6T2piRnI4SXNha3NTVjE1WVRwUUxtZGFsVHRleURYNi91UGU4?=
 =?utf-8?B?d2tnNk1mbVE3bkRMTVd4Z2JlKzIwNmpWbnQrV05qVUQ1YitxWUJoMnVWQzVY?=
 =?utf-8?B?UlhTWWZhaHRVSCtvZUxUUVMxSGpET0tUK1k0MVlvTkxKVWx0TWVOV2hQM21a?=
 =?utf-8?B?aCtzTnl4Mnp6Zk5KUmRxRjgvYU1YSE16RWNoZlB3LzRRdGRndWFkOUdJcHp6?=
 =?utf-8?B?U0JtdUl2WXk4UG5lNFdQRjQ2N25VYTdWVWduWGxUSUhjWUlMc2RQVVlZS3lr?=
 =?utf-8?B?TlpLbkt6d1RUZDNYTyt0NEs0TWVCdUlzN1VTbjdyWUJqM1ZKKzhKYSt2K0Vm?=
 =?utf-8?B?SXM3OGZBRFJSVGNwVWlnbHp0SHYzcytHVmc4T3RXb3lsSGw5andtajdHSjMv?=
 =?utf-8?B?R3FMak9rem1HNXJOdUdTbDc0WTBpUEExbUs4S20zZkhlSjU5aXFpNDJVN2hX?=
 =?utf-8?B?MU5qZHdrcXpRYldXcEtrSUJDaVNxZldtZWFEcmlQVmltNzVvdExrYWowZnRU?=
 =?utf-8?B?SkVmRDFuY1lLaHVVY1IrNytSbjRqNm9ScUFFenZwQXpxRm8wUDlhWmFNSExV?=
 =?utf-8?B?TE1nQm0vdGdzV0h6SVk1a0FMSDI0djNKVy9YTXhoNk9zeE5vSDJwYTEyK1J5?=
 =?utf-8?B?bnRidmIreDIxNCtDYzhhdnFPclhmQ3ltSU94YzV5RzlRVTI4Zm1jUEtCcGRG?=
 =?utf-8?B?MVVKRGw2aTczS3FreXNyMzU4TnVzVzBrYkVqQnA5ZXpvemtuVEFYYWw1VzEw?=
 =?utf-8?B?TDZLV3JiaEQrN2tQZ2lnS0F1SGZIakhISDk3Q3VkWEhhMVd5RXRLMkZyYmIr?=
 =?utf-8?B?WTBXelg0VHpqNExKaXZFMGJjZzJWQzNOYjR0aGdSazM5VWlsTWk2RDlhV2Ew?=
 =?utf-8?B?cWh6eGhpOXJvS1VZRHNIc1lwMlRCb05BWCtIQTlzSnBBa2kxYmljOHgrUWRM?=
 =?utf-8?B?bER6d044V1BLK3BORnBmL2dEMllveEovcWFheElBVFB5RFhXN1dJQm9STCtj?=
 =?utf-8?B?UjFEQWJjMndFZURYY0lUR0d3cUdHWUNVTEh5bDdGd3RQRVZIa0M0SXBhZG5m?=
 =?utf-8?B?bWljbTJGZ1o2ejZzdUpPUFhFMzkvZVIwRWV5dEdIdmlCY0xHRWo5dXIrM0pt?=
 =?utf-8?B?TlNYTlcyU1FwR05lRDFBdDh4N1JPbExUaGI0eVI1OUJQQk1jVnh4RTVEZzdm?=
 =?utf-8?B?aHo0bWtaUUl1Rmx0RVZadjQ1ZEhvSXpUaThhd1dsOW1FcVlHSDlJOW9SY3dm?=
 =?utf-8?B?ZEFkY1F2K2pudG8vdnJWWlZtL053QWNQT1NNMDJoNDVXZTNzZlo4OVpTRy80?=
 =?utf-8?B?bzIzcVU4T2hkL0xIbDI5YnF1THRuR00vNlB5TUsramhkVWU4czR0UjBkS2xj?=
 =?utf-8?Q?zCdWMbv0n7qYxoH4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300dd283-0c91-4a31-7193-08dec144d6c6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:50:54.1861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JNwx8Xizi7HyndRQeZPygUJxIj3S3lc0Tj0qE523lucX+qTRWA5xTgZOVtV1YUUHCTPo62vMoZJALLCMq7/u3Hnp7S8/rpyKogm4bSUUrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7920
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

Hi Alif,


On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> This patch set updates the boot support for the Altera SoCFPGA Stratix10 platform in U-Boot. The changes include:
>          1. Board-specific configurations and setup required to enable Stratix10
>             multiboot operation in U-Boot.
>          2. Integration of cache coherency unit (CCU) initialization routine,
>             including CCU conguration in DT.
>          3. Clock, firewall (configured in DT), SMMU, low level initialization
>             specific to Stratix10.
>          4. Refactor of the Stratix10 clock driver and targeted updates to the
>             MMC driver for compatibility with the refactored clock driver.
>
> This patch set has been tested on Stratix10 devkit with QSPI boot (UBI/UBIFS), SDMMC boot and RAM boot (TFTP & ARM DS debugger).
>
> Changes in v3:
> - Removed fdt-2 under &images node and board-2 under &board_config node as
>    socfpga_stratix10_socdk_emmc.dts is not yet available
> - Regenerate defconfig with make savedefconfig
> - SPDX-License-Identifier format correction in
>    board/altera/stratix10-socdk/Makefile
> - Retain Intel Corporation copyright notices
> - Add clk_get_l4_main_clk_hz() for STRATIX10_L4_MAIN_CLK clock rate
>
> Changes in v2:
> - Cleaned up git merge artifact
> - Cleaned up cdns,read-delay parameter for spi node
> - Cleaned up duplicated /delete-node/ kernel in binman node
> - Implement using real hardware clock source frequency following Agilex
>    clock driver
> - Commit message improvement
>
> Alif Zakuan Yuslaimi (9):
>    arch: arm: dts: stratix10: Switch to using upstream Linux DT config
>    configs: stratix10: Combine defconfig for all boot flashes
>    arm: socfpga: Move firmware register settings from source code to
>      device tree
>    arm: socfpga: Update Stratix10 SPL data save and restore
>      implementation
>    arm: socfpga: s10: Enable system manager driver for Stratix10
>    ddr: altera: soc64: Add secure region support for ATF flow
>    clk: s10: Refactor S10 clock driver
>    mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr address retrieval
>    spl: s10: Enhance watchdog support in SPL for Stratix 10
>
>   MAINTAINERS                                   |   2 +
>   arch/arm/dts/Makefile                         |   3 +-
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 313 +++++++++
>   arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------
>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 119 +++-
>   arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ----
>   arch/arm/mach-socfpga/Kconfig                 |   2 +
>   arch/arm/mach-socfpga/Makefile                |   1 +
>   arch/arm/mach-socfpga/clock_manager_s10.c     | 448 ++-----------
>   .../include/mach/clock_manager_s10.h          | 175 +----
>   arch/arm/mach-socfpga/misc.c                  |   6 +-
>   arch/arm/mach-socfpga/spl_s10.c               |  70 +-
>   board/altera/stratix10-socdk/Makefile         |   6 +
>   board/altera/stratix10-socdk/socfpga.c        |  12 +
>   configs/socfpga_stratix10_atf_defconfig       |  90 ---
>   configs/socfpga_stratix10_defconfig           |  69 +-
>   drivers/clk/altera/Makefile                   |   1 +
>   drivers/clk/altera/clk-s10.c                  | 616 ++++++++++++++++++
>   drivers/clk/altera/clk-s10.h                  | 203 ++++++
>   drivers/ddr/altera/sdram_s10.c                |  60 +-
>   drivers/mmc/socfpga_dw_mmc.c                  |   6 +-
>   21 files changed, 1408 insertions(+), 1367 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
>   delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
>   create mode 100644 board/altera/stratix10-socdk/Makefile
>   create mode 100644 board/altera/stratix10-socdk/socfpga.c
>   delete mode 100644 configs/socfpga_stratix10_atf_defconfig
>   create mode 100644 drivers/clk/altera/clk-s10.c
>   create mode 100644 drivers/clk/altera/clk-s10.h


Looks good overall for master, OF_UPSTREAM + DT firewall + clk DM is the 
right direction. Please rebase on current master, fix reset_flag(u32 
flag) in P4 to match spl_data.c, and note SDMMC boot validation after 
defconfig merge. Happy to Ack v4 after that.


Best regards,

Tien Fong


