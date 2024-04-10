Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79134CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 07:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B1388019;
	Wed, 10 Apr 2024 09:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hIvNyeaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E6688166; Wed, 10 Apr 2024 09:06:40 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6A887916
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 09:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P63aWdAEn8VpTJrrDUZYVxWPUBkS4XXBf04jCS515cwXWaXHJPP33JMtPMu3i6cuKxmFKiF4a72W1jtwXASnI7KuF7iAW6tnmaaRPxN+Sxn6OkrvaBOY3uw0LBwn2tbf2eI4/vO1KS5ks41/3vVD0TwVqTTNAE8eKqC0QoDI7Xa5JhaX6frDQhHtC81w6rWf/Pg5j1Cy4czmabjifleqmrsbAGFV3LU0SNy5kR9COozShJkAk7SDaXlO92nmfSppZCNswwbXadRM4/tTd29SSGZ60W9jJ/qbthPDr/3jTVeIPvbm220d/nFBr+J2pKZ5M0dlKVydKzyPAzO4BeZm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3o3eCWRJgYpL6Bct4Su4wEy7kFoN/b81jPzyzEvXsc=;
 b=QZTctoqpwR5JvH3V/p0fZ4+6E+IM8qSmLKlu2uxqqxWwFHX+QakgS4cgWsRFi//ZGsWF17oK/14SzL/AnCeQMawwrUHahrScgMTs0K2yFC1tOwKgJcSY2yxvLsftJASPic3cobfONkOmIGJ/auiPilonzNkqYoGPPyNmxweEtS1aNme6DVU1GEsGWWju3Lw+Icw1HVfxtTEqO0VoLwNRJM5TuHtH/eTFfoGPOYR+lYiukAo5o64fEusQ+8zc7iannhXlXV+LJh14KhXO1S9lQoxBOPdpVVwhbE7SpKYEfGsg3PDFoVJ3bGLzDaYFm8r8MSkyILLsqnLaigpEGwyebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3o3eCWRJgYpL6Bct4Su4wEy7kFoN/b81jPzyzEvXsc=;
 b=hIvNyeaGxkAUjJNPYK1gjglOCiQQJimNJudIqjzL00tg8SqkjxmKHu0/FbB5Cp6bxuCIOe4a4WNtOnop/+2zXe8BM71nIb360UkskgTrb/Lb+IJ6hLjAl3tq/7YXh7lOAWIP5AIySSUmklaHCKfdLL3NQeOVIk2XVuKFSlzyw9Q=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 07:06:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Wed, 10 Apr 2024
 07:06:34 +0000
Message-ID: <3e51141e-6c0d-4955-a9dc-89d2c5e94279@amd.com>
Date: Wed, 10 Apr 2024 09:06:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Introduce spl_soc_init() for SoC specific
 initialization
From: Michal Simek <michal.simek@amd.com>
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
 <476510ce-8a1a-4ed1-ae98-04beb9c75607@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <476510ce-8a1a-4ed1-ae98-04beb9c75607@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5670:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KZuIBcbClNaHYCRpYgG/ZyBqyfndkIHuq2KSDZM5SSJvHptXu77giYdESQmn/zo+/rcnuVercL0TAOZ+RR3poTxzOpLLyIqdEIHWJmDJa5JOCAIDmU8VFlFvX/amNd1b/Bga1nvpelYkXwRVlpftihqmxhxHIhv/w8X1i4ev71VKHcE5bebs4ZWfITgr9iq+L3qgq9Px2zFSDOPlkOKwftFYPJVfyFbUxUREbUsp8Jsd1gK74zYpH29FEcbKJmc2ojDOrj/CNyQ+dkDEpfgLeAF9QzylewqjijN/EExQBVqEu8g2p4aVSPsJxTCqCP2tPpuE9Ljcfpx1AjzvEjKnpWzNXfDsXMhRncXYDvirdnmmMzpPBc4FAUFR3SYdOVJnqfGBpDrlPb1dV7+aYoLZT3SVdl6iUQ55VuD/2jc8yvD4u42FtUMb33uLrET7yApSYbkPEUZ1FNmMXIyyb/vUfeOY5VITLi2r3Ut642vth9e+5VckiWwEvHT9KBDPLb8/V1DiLLvegZUrehNp3/T8PKbvn6D0uB9VLBgts81Mz71axpKToDAmya+DKzlKbB2rMbPoS0ZmZotczYn2udAU9HBEgvg5geda9NS+iUD3/XWzQ9DFRW6kz34g43mtIfwKmmhPYrMTk+UvU3A4Rm5YpvD2IJso60ggf5U/xqNnm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdDM0gzeVVmVVlrZkdRaVllazZoOUk0Y2dzZmkxOG1MYjJpeWJjbThKN1pp?=
 =?utf-8?B?cGhjbGVZeDhMWldLSGgxVUZvZ0NJYzV1OVJETkFsMDdEWnJObEdjNnpBZ3p1?=
 =?utf-8?B?Mk1qN0VNaGJiTG1KbVE2RlByOU1SM3NGYitRUG54WGQ5TDVNam1DaW9oK0Fj?=
 =?utf-8?B?c25ld2h1OW1NV1poa0JHLzA5MW0xQ3VwWHV4Q1JCdzF6aGpiZWs1SmNIb0VB?=
 =?utf-8?B?bEYrc0ZMR1pYUVJTY2VzdGdZa1grdzNSeWwraGFZb1hBdnQvSmVxUGhJZTZ5?=
 =?utf-8?B?NUlpVW4rQjF2dzREeEQ1U1ZpRVVSWDhhTUVueHVtdUUwZm4zY2d1NFkzL1da?=
 =?utf-8?B?N2xMMGlIeW1tcURKMUlkbmhMc0lkMFkxNDg0T1pvSVhRVmlZeHVlNzJHV3FD?=
 =?utf-8?B?bTl6ZmZnVWlSU0JMUzhNRFdhMzRVeHRpelFWTzRuakdES1JIZHo2dnJHK1JB?=
 =?utf-8?B?TzhVM1NqSk5yeU5qNkQ0cG0xZWNQZkhNV3dNcFozMWxDL2w5SUtKYUZKL2kx?=
 =?utf-8?B?UlVBclhWNkM0QlVMa3dWUkZzUzVBbE9GMGVCZWQwaGJnc2N4Z3BtQUtGQXZh?=
 =?utf-8?B?cGdMSUlCd005cTMyRStlcFVaOGY5ZURVbnhvMVRrbXhqMHp6Wk1yWGRLbjZG?=
 =?utf-8?B?MTd1UElGN2I1dThSa2F6bFk2VW56NlZDRUlIdm0raXY1NXgwYkZ5WGJkUUto?=
 =?utf-8?B?NlhFNG9MZmw2cXp0d0F6am5QRzJab0ZiVEY5eENndzhMNjgxRXI0UkFwdUxM?=
 =?utf-8?B?R3V3OHpEaVpDUi83N2h1cXU2VUNYZjhFQjM3NzQ2cXFKZkZDdTVxOUtHVkhr?=
 =?utf-8?B?Y1plSU9Pangxa0xaa0hnUVlEMXhKTmgwTGhGeVZnTmtmN21KcVUrRm1nMmVT?=
 =?utf-8?B?SzRUY1QyZnZnVVVsU1NHR3VpNHUxeXlLZjZrM0dNZTA0VHJ0RmdTY3Z0RjFQ?=
 =?utf-8?B?K094MDEvM1k0aElHWTBRRHdQMFBxa2JUM3k1aDNBRHl0cEpvL3FTQk40UVVX?=
 =?utf-8?B?V1EwOVFHZXJINzBnUFJENU84azRJNC82N1BCSmpLa3NaYXRkclQ0TDlxTTlM?=
 =?utf-8?B?VHBNQ2wreTNUNW9kMTZjQzlaZEdGSU1HODZqYmM3dk9XWG9OQzBlY0dLOVZk?=
 =?utf-8?B?OXFZWGJKRG9GcXBlNUlDTW5pY3RHdUpEMnU1ZkNBeCt0T3hPNDRFTWx1Syto?=
 =?utf-8?B?cEQrTDBKZUFwVHpSVUdvaDVGZkNTc2lEdWdtd3N1dEVndHdWNTcvN054dENu?=
 =?utf-8?B?TkhTOHoxNnZNSWw2c2lqc0d4YUFUUlN5MnBuOWVtd2JGZ3VpdjNnRnpKT09y?=
 =?utf-8?B?MkZOWWIzcXhLMzVCMVN6MW5FWHo3cjJMaTQzUGJ2WWRnN3BjOUxiRUt0b3J1?=
 =?utf-8?B?Nm9SS0d1bGNNS1dtTlo4elE1dkFOSHgyd09acmFoNXlxN3NWaVZheUhIVWl6?=
 =?utf-8?B?Si82aXdqQXdqRWRpQXRabFlteFV0aFpDZUM2Ymp3cW5GUE5sNjJua1JLK3E1?=
 =?utf-8?B?aWtwYmtnb0t6bko4SUIzZk5YTGkzWWFxSU4yemhQL29YYTlBSEpaMVp2ZldZ?=
 =?utf-8?B?NWg2QXNwVStiQTU0SHFQN0dzVFdlLzRveGVvQXZva2g3dmpMUFM4TmNLSXp6?=
 =?utf-8?B?T1p6NjJ0U2V4Y2xibHhKK2J0K0ZRZnBnOVNRajZHa2MvYWdpR2ltalBSN2du?=
 =?utf-8?B?TWFRRkwvSXRyTUFtaFFDWTBIcnQ5ak5zeXNPbVkxc3RWclJJb0EwVTZiOW9j?=
 =?utf-8?B?KytHeEozc2hPRklWQTVBZTRFZXpMb0VtdmZuZ1B5R3dTOS9mcXQ4VDllNllK?=
 =?utf-8?B?SW5ZZzhmdGZ3a0VyVG45NVZvYVZ4cHhTNGpFVHltTnRPQnhzQllUQTRlNG9v?=
 =?utf-8?B?WlZKNDlJeDd1Mm04SGpYZ3RRdE9VbnBkRmZiQnpGUW9jWXBzTXRvb2R1anYy?=
 =?utf-8?B?MG8vRjFvKzJ2Mkp2MVdLR3lQRG1kZFhLZkVFeS9yUmMva2R5SWZVaS9JakFB?=
 =?utf-8?B?MW5meEdvNklTRSt0eE1vMFhYSHZyMjhZZU9UZlVUQzcyb0RSTy9XWGdtSkpk?=
 =?utf-8?B?djY4RUNSc05pUHlJSjlWM2dEQi9kS29MM2NheWplNkhCVnhkdzdwRHQwYW1x?=
 =?utf-8?Q?twdC/MrH4kdXnAndH4d772GQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cabbe28-30ee-4784-435b-08dc592cc1be
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:06:34.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM7x2Fm19RBT/nT3SufxL8zFBV1z84r/Y3UH6rOG8o35UL5Sjn66BVqHd0f2nAW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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

Hi,

On 4/8/24 14:59, Michal Simek wrote:
> 
> 
> On 3/27/24 13:11, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>>
>> Currently some vendors use spl_board_init() for their SoC
>> specific initialization. This prohibits board developers from adding
>> board init code using said function. This series introduces a new
>> function in order to separate SoC init code from board init code.
>>
>>
>> Changes in v3:
>>   - Rephrase Kconfig description and correct minor typo
>>
>> Changes in v2:
>>   - Change spl_arch_init() to spl_soc_init()
>>
>> Lukas Funke (2):
>>    spl: Introduce SoC specific init function
>>    arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()
>>
>>   arch/arm/Kconfig           | 4 ++--
>>   arch/arm/mach-zynq/spl.c   | 4 ++--
>>   arch/arm/mach-zynqmp/spl.c | 4 ++--
>>   common/spl/Kconfig         | 7 +++++++
>>   common/spl/spl.c           | 3 +++
>>   include/spl.h              | 8 ++++++++
>>   6 files changed, 24 insertions(+), 6 deletions(-)
>>
> 
> Applied.

Actually I need to drop these two patches.
I pushed it to CI and got this error.

Building current source for 1 boards (1 thread, 32 jobs per thread)
    riscv64:  +   sifive_unleashed
+In file included from board/sifive/unleashed/spl.c:17:
+include/asm/arch/spl.h:12:5: error: conflicting types for 'spl_soc_init'; have 
'int(void)'
+   12 | int spl_soc_init(void);
+      |     ^~~~~~~~~~~~
+In file included from board/sifive/unleashed/spl.c:10:
+include/spl.h:825:6: note: previous declaration of 'spl_soc_init' with type 
'void(void)'
+  825 | void spl_soc_init(void);
+      |      ^~~~~~~~~~~~
+make[3]: *** [scripts/Makefile.build:257: spl/board/sifive/unleashed/spl.o] Error 1
+make[2]: *** [scripts/Makefile.spl:533: spl/board/sifive/unleashed] Error 2
+make[1]: *** [Makefile:2055: spl/u-boot-spl] Error 2
+make: *** [Makefile:177: sub-make] Error 2

And it is valid because Risc-V guys are already using it.

$ git grep spl_soc_init
arch/arm/mach-zynq/spl.c:36:void spl_soc_init(void)
arch/arm/mach-zynqmp/spl.c:61:void spl_soc_init(void)
arch/riscv/cpu/fu540/spl.c:10:int spl_soc_init(void)
arch/riscv/cpu/fu740/spl.c:13:int spl_soc_init(void)
arch/riscv/cpu/jh7110/spl.c:31:int spl_soc_init(void)
arch/riscv/include/asm/arch-fu540/spl.h:12:int spl_soc_init(void);
arch/riscv/include/asm/arch-fu740/spl.h:12:int spl_soc_init(void);
arch/riscv/include/asm/arch-jh7110/spl.h:10:int spl_soc_init(void);
board/sifive/unleashed/spl.c:30:        ret = spl_soc_init();
board/sifive/unmatched/spl.c:137:       ret = spl_soc_init();
board/starfive/visionfive2/spl.c:214:   ret = spl_soc_init();
common/spl/Kconfig:279:   spl_soc_init() from board_init_r(). This function 
should be
common/spl/spl.c:715:           spl_soc_init();
include/spl.h:820: * spl_soc_init() - Do architecture-specific init in SPL
include/spl.h:825:void spl_soc_init(void);

It means please take a look at it and send v4.

Thanks,
Michal
