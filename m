Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2D5C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 11:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC5A884ED;
	Fri,  5 Apr 2024 13:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="amiGjVAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C0B884EF; Fri,  5 Apr 2024 13:19:32 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C713884E7
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 13:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQocN+cH+hAuOSaAoyGGTASBayAEZ85W2HS37F07t19v1RwwGXKpUn6NcY/trmaKVnvQ1+umXW+eGJ5DafD2vjh0XTJv8VCxQx4dKQAjJyGreJobnfYxJueu6JxsLdrJNnHEqrrUTWjzgX7DR1MMZYa+WDQ7CMsd+z0nQR7dP5GlAKl0taqLzknMTetQbrbxmODUyLdbXW7/lT6r0Ry2neZfi7hiU8swV0mNKs9B23Wl9HkQuIT/xjOHDIEzx8NfLp4Wa6UKiaX2CuMGm4aSMPXYN9qlkBLiFKiLjp0Xk8s3mHF9ozlrRzxxp0z/zkPA5sS2+Mq834BPTxSXyqG29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INLIfBzwp5MoAzMQ7pLanRLoRhcdRhZ6pkqUcKePJpA=;
 b=J3T1LIny1NWicT2vc3L7HoBsx52kQewsFqi+cedA7lf4D+BmFg6d8YmCQXlOOhLZd1HCfEr4nbIUXvvzLj8cwR/EsrpbAosOucgNaKNiMtVQaqsu6DRe9s2on4pHUCVaQYlwhOjCePCvqaujbe7nR3pZ8p3F9oOBXmp0lXQ/e9R/HrkKfOjUsmmyBMStZkl/fPu2IVev5zhI8L/HQQWU+75UKDF2O2uOXpTn/mAgFqD+BgcgV94na2zaDrhMcKlkGsA5iTCguFLz/c1d/biUsfwgY0u092rbCTbQmKJtdQCIo99iZvwuzjg9Qf+bdq0gbipO6t7rA8QQiwuNZ3SBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INLIfBzwp5MoAzMQ7pLanRLoRhcdRhZ6pkqUcKePJpA=;
 b=amiGjVAnYez6Q0+/4eyvBwrMbJ0t2mtSi0Yd6PELChyqWkh/KaDiwyRwwEz6wMvR8Y/iqGxxYQeAKOb1v/qNTnPrQTHr8DF1T7ZxdgPPq29Jpq14g98X7Snx3mK1ZWqBT3qQoB5Uqwek2ss13+2TAYW6tXQAozrQ18aAde2WWWcBFEyj2+GhKNxhY62AMJ44h+ag6NPhNMPl8eleL0HK8FsuqLaI10V0p1XS92RNnwQ2APsVXWsAKUACaB0z5PRVYVycmg0ozIVwkYk8LkhsiIrJmumx4WJyN/MOCHT0cmC06lgx2G2zbvIm4vEPz+kibTb0vqn4htxJH9G1Zq28MQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 11:19:26 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 11:19:26 +0000
Message-ID: <af028f18-1f8c-4bbb-9286-009ee7e80dca@theobroma-systems.com>
Date: Fri, 5 Apr 2024 13:19:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [V1 PATCH 1/2] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com, tom@tom-fitzhenry.me.uk,
 jonas@kwiboo.se, inindev@gmail.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com
References: <20240401181435.553351-1-macroalpha82@gmail.com>
 <20240401181435.553351-2-macroalpha82@gmail.com>
 <7ceeb297-f1aa-406d-8e87-d02a92e58af8@theobroma-systems.com>
 <DM4PR05MB92297603EC71B34A037A87F9A53C2@DM4PR05MB9229.namprd05.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <DM4PR05MB92297603EC71B34A037A87F9A53C2@DM4PR05MB9229.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VE1PR04MB7472:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OF8CUH75OS0bs+iYz1CJJ81qQzb0i9feE3ys7FNi9ey65mpWM4goftqWdyIYpm1JQqiR8ZaICE+9MsFZJA/v+/1z4WSHZETdAR9Jyq5LUf585HruRBazFOrEoDrAc/lTJIxk96GzFHpkTX1w5AgI8PIzVvmEni9o8DvSN6YdcwUW5RDxCdnlDsp+wZaK0OB1rZ6JJy+e/HI+5u+Umzy9x2dgSraYojreNJHdJEew6eex58VnfLVkk+9qM/BV1oNVjGkC0xusCvB1+37I4VAtXO9VFPYi0y6Kbdjt6rnshrPdljk+GKyCQNedfQhQmyPHzRpsT0FiqkoceT4jhPXhYOfBNrB7vtUwScHrYjHl+pGZUFb8LCaDyaLuC56AADY2amSeYsVwPXe3hP0btShXYbnXAONNCWdGJL8qjbZV4iqRMuCXT8MZiTovNmXWHKA225aDkkBiCdHQqIyRklChVmi0BsukYO5HLOORjRUlc6r1XDBCj2Ps2qCpUJrWim6+jnxUpmAAMP+yNwuEzM02kmbG17mU7SlAPJQB7rO3Y90O9HOlUxDKHd9i5Ou+80XXP1Gb2lvL/tWSh6M6bBsHKnNyLYzRfrtnsNVfvseWYqhbnrxwJTO3AHJWT2iVnIq8rFGVnwpLXqRG5DxtahtX9uoqIZ3Jxf10Gyy2i3vwXDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW04ajQ0bkFtaWxnRk1iQnRPaWR1NU1HRUNzSlc1SUNyYnVQUUtYNXdLVCtt?=
 =?utf-8?B?d3JVSDVCbzcxTm9BUDNDV1c4MkRZNzAvVFQrbGY3czdhQmJLditOa3N5Snhy?=
 =?utf-8?B?cEtlcVk3cGJSZER0TUdqN0NaalYyb0dldXVPUHhQbERvbmZVdkhUWWxsZnI1?=
 =?utf-8?B?SS9BNk5yZ3lKSzVaOGJUNnB6NEFUMnB4NEZzTitWQk1MT0o4bkpvVzhUNVg3?=
 =?utf-8?B?ZGFjVlQxampNeHQwM0dxMlRVdEk4ejlXd2ZDdDdET3c0WVpYc0wrczdhOGc0?=
 =?utf-8?B?S09LdFBxS3JwU0pKcGpBNDJWNmw1ZGZ6alRPa2dXUi9HVHVTRkRlQ1EyYVN6?=
 =?utf-8?B?OHdMYUJQYTBuMVdSckJOMDErcTYvN2lYaDZJVVlubFFOSzJ5WW1ra01WZVhG?=
 =?utf-8?B?anBGcVpBYzJoVTRldGdDUlhjYU8vV1FtN0UvZ05YUXhZUmtwN2RMZW1PRGJE?=
 =?utf-8?B?M1RkY1IyTEhyODAwMWJoSHBIc1VvdmxLWDJvaUwvanpNRXZmdWVEQ0o3MXVT?=
 =?utf-8?B?ais3RlJSN25meU1neXZBUGozWWdzZndvQUdzcktnWUtDY2MwWWJ4cDc0Qml2?=
 =?utf-8?B?VEdBL3VFT0lpek1mdk8vNzIvQTRLemFLR1ZBQkErNGJveWRhcTFucytwSkxT?=
 =?utf-8?B?ZlZLcVo3VkJJdzVjVUM4L2MrR296N2EyWW1kQ0cwOUtUVE0vbmo2YzcvM0Rr?=
 =?utf-8?B?YStpam44UVlERkJxSUJ2OTAzaVVyeUsrc1ZPYUcxcEZ6QmR3bURvOGtlNnlK?=
 =?utf-8?B?czRuTHZUMHRLdU5zd2JRZ2h4VHdFSUZDTXhOZjlGOUp2RlJHZXMrZHJLS3Yx?=
 =?utf-8?B?RzZkZkhSVHhWakhvdXkrRko0K3RUcjVsMEhEdGdyMGVRRHlHVTk4L1FIa0oz?=
 =?utf-8?B?WmpmbTJHUEh3cG1mczJBUGVYcmNqY2thbnYyM2VWUE5lL2JFZlpESlo5Q3Z4?=
 =?utf-8?B?YzNNcGw4aEhLUitEaGQ4Smt3V09xb1h0QmJHdkMzMnpHYTEzbk1CaEtSTlJn?=
 =?utf-8?B?d01TVmhJSDRFbHExQXZ6Mzh6K0dpeUNXVUE3Uy84ZjY4TUNPUUF1ZE50ZW4r?=
 =?utf-8?B?UW84Sy9tL1puREVzZlM4d3h5Zy9uaU1MOGpSWDZyVVE1RzN5RG1hTWNiRmJQ?=
 =?utf-8?B?UTNJVGFoYXdya1N0TE15dW85Y2JvZjVka0tVMmFLYTNGdDYrUXgvUnA0UDRV?=
 =?utf-8?B?VlhDaU9Sd21FUjJEdXNmbWw4NEFMbDRQTDlxWDM1Nis1eEZRYVFOWDJYVWRz?=
 =?utf-8?B?SFZpZUxQVzRSVFN0aU9CL3J5MndSdlpQMU9OMTh5emZ3blNka0Uxa3EvZUNo?=
 =?utf-8?B?akVTUVhOd05sbmdyTjhxdjhraVBpbW5NWVRuRDZYblp1LzhDckQ1eFBDYTVK?=
 =?utf-8?B?R2puQ0pKZFVhaVJKOE0xVHJQWFpsWW96aWZUbTZkOFd4U0Urcm9iZGJxakFG?=
 =?utf-8?B?R2M2VXpvdVBNcW9pbjl2dXNqNm1SaHliVkhPK2lMSXZiQkg0QkpLWlovYW5Y?=
 =?utf-8?B?YmhXQ0hLNWxQeGFUT0Nqc3FEbm1ITVNod1pGNC9KWFlsK1paNGR6cjhWaGFI?=
 =?utf-8?B?RkVKMk44Y2k3VEI4cFJESmJYUHovbkdld0hBWW5pekx0ZkM2WVZSRFpRc3Mr?=
 =?utf-8?B?VU1Xbnd1MW1JK0FIOU5Ha1ZBbCsvQ0lhOXlhNWtuSFhEaXNHckp1eU5FUDAx?=
 =?utf-8?B?ai8rdWkrRnNTNEFtWU41UUJqQjJra1hKNis3UUl6cXVXSFJqYWw5ODNKbTd2?=
 =?utf-8?B?eWU4VG5PdHhoTWRSN29tdXBaOGhXZGtDeTYvbWhTaS96cDBKTGQ3TVNjay90?=
 =?utf-8?B?SGdpd2pMMUY2ZFY4WmZVaXJlUHFEWWNmeGVFS09iMWUvUFpDdWxFMWhsekFX?=
 =?utf-8?B?bkRvK05Ca3krRkE3RVNwT1VIRWJmUEtHT2VVUHNRRjhxSTJhMHp0RE9rTHB0?=
 =?utf-8?B?U29neWE3ZlJwaXBLMUJwV3FkSDlxTEcxa2hENVd6TWl3dytPeFA2b083QTVk?=
 =?utf-8?B?WGZIVVIrd0t4WFlia3dTVFJtbjJ3cTRyVEZCdjk4VmpvRHNYKytuU0NWL2Uz?=
 =?utf-8?B?TXdrYmNKMUt6TWR0TDJjM0Qzd0pWT3Z6Zlo3RmlGSVZRdXJLbWgzMGI4WEtY?=
 =?utf-8?B?NmY5aWZ6ci9lRHNFa3hEdjlMdEwrNlJiczdNQkhmWnEzK0x4aFZsaXJkdlRS?=
 =?utf-8?Q?V6GFaMsGmRI0sstT040xEZI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54db4fd0-afbc-4499-993e-08dc556240ae
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 11:19:26.1836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMTnU1fyHkijaDATdcoc8TI5jBJpxeiBfQl6wsNu3+epJ7/GAZeu4w8jPy3me4IkvSBwypaEBl164GfUq0OziQlHeJlscB/ChJt2yI6kzSixWEFQx7w+50MVHBYhWWKr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472
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

Hi Chris,

On 4/4/24 23:33, Chris Morgan wrote:
> On Tue, Apr 02, 2024 at 06:38:59PM +0200, Quentin Schulz wrote:
>> Hi Chris,
>>
>> On 4/1/24 20:14, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Allow RK3568 and RK3588 based boards to get the RAM bank configuration
>>> from the ROCKCHIP_TPL stage instead of the current logic. This fixes
>>> both an issue where 256MB of RAM is blocked for devices with >= 4GB
>>> of RAM and where memory holes need to be defined for devices with
>>>> = 16GB of RAM. In the event that neither SOC is used and the
>>> ROCKCHIP_TPL stage is not used, fall back to existing logic.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>    arch/arm/mach-rockchip/sdram.c | 100 +++++++++++++++++++++++++++++++++
>>>    1 file changed, 100 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
>>> index 0d9a0aef6f..e02fb03c5f 100644
>>> --- a/arch/arm/mach-rockchip/sdram.c
>>> +++ b/arch/arm/mach-rockchip/sdram.c
>>> @@ -12,6 +12,7 @@
>>>    #include <asm/io.h>
>>>    #include <asm/arch-rockchip/sdram.h>
>>>    #include <dm/uclass-internal.h>
>>> +#include <linux/errno.h>
>>>    DECLARE_GLOBAL_DATA_PTR;
>>> @@ -35,11 +36,110 @@ struct tos_parameter_t {
>>>    	s64 reserve[8];
>>>    };
>>> +/* Tag magic */
>>> +#define ATAGS_CORE_MAGIC	0x54410001
>>> +#define ATAGS_DDR_MEM_MAGIC	0x54410052
>>> +
>>> +/* Tag size and offset */
>>> +#define ATAGS_SIZE		SZ_8K
>>> +#define ATAGS_OFFSET		(SZ_2M - ATAGS_SIZE)
>>> +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
>>> +
>>> +/* ATAGS memory structure. */
>>> +struct tag_ddr_mem {
>>> +	u32 count;
>>> +	u32 version;
>>> +	u64 bank[20];
>>> +	u32 flags;
>>> +	u32 data[2];
>>> +	u32 hash;
>>> +} __packed;
>>> +
>>> +/**
>>> + * rockchip_dram_init_banksize() - Get RAM banks from Rockchip TPL
>>> + *
>>> + * Iterate through the defined ATAGS memory location to first find a
>>> + * valid core header, then find a valid ddr_info header. Sanity check
>>> + * the number of banks found. Then, iterate through the data to add
>>> + * each individual memory bank. Perform fixups on memory banks that
>>> + * overlap with a reserved space. If an error condition is received,
>>> + * it is expected that memory bank setup will fall back on existing
>>> + * logic. If ROCKCHIP_EXTERNAL_TPL is false then immediately return,
>>> + * and if neither ROCKCHIP_RK3588 or ROCKCHIP_RK3568 is enabled
>>> + * immediately return.
>>> + *
>>> + * Return number of banks found on success or negative on error.
>>> + */
>>> +__weak int rockchip_dram_init_banksize(void)
>>> +{
>>> +	struct tag_ddr_mem *ddr_info;
>>> +	size_t val;
>>> +	size_t addr = ATAGS_PHYS_BASE;
>>
>> I think this should be phys_addr_t instead of size_t?
>>
>> size_t is an unsigned long on aarch64 and phys_addr_t is an unsigned long
>> long so 4B vs 8B.
>>
>> This however would likely prevent us from reusing this code on aarch32
>> machines, but maybe it's a problem for the people who'll look into
>> supporting this :) (also, aarch32 and >= 3.75GiB may be a bit optimistic :)
>> ).
> 
> Could I just specify a size and not worry about it? A u32 should be more
> than enough to hold the maximum RAM address of an RK3588 board (32GB).
> That would allow this to work on both 32 and 64 right? Otherwise I could
> further restrict this code to the AARCH64 ifdef.
> 

There's even a bigger issue here as phys_t is an 8B structure (on 
Aarch64) while the atags are actually 4B aligned, so that would 
unnecessarily increase the complexity for arithmetic on those addresses. 
So u32 would probably be fine then.

>>
>>> +	int i;
>>> +
>>
>> u8 is plenty enough here :)
> 
> I use it as a return value where there are negative numbers (though
> obviously this should never be negative since it's an increment
> counter). Does that matter?
> 

You could return i still and let the compiler do the conversion.

No, it's not a blocker, but that may unnecessarily increase the size of 
the TPL.

[...]

>>> +			break;
>>> +		addr += 4;
>>
>> This is an incorrect step size, addr is 4B, so this will result in 16B
>> increments, which may be too much. Additionally, we shouldn't read every 4B
>> as the tag is only ever guaranteed to be 4B aligned, not that we would have
>> a tag every 4B. This also means that it's possible somehow the content of a
>> tag at a 4B-aligned offset has the CORE_MAGIC for some reason, but we
>> shouldn't match on it.
>>
> 
> I'm not quite sure I follow. Are you saying I need to increment every
> 4 * the value of size in the tag_header? The value I show is 0x5 in
> my header meaning increment every 0x14?
> 

What we have in memory is (each 4B) (correct me if I misread Rockchip's 
code)

tag1.size = 6
tag1.magic
data1[0]
data1[1]
data1[2]
data1[3]
tag2.size = 4
tag2.magic
data2[0]
data2[1]

...

You start with addr = &tag1.size
when you do addr +4, you now have addr= &data1[2]

By casting data1[2] into a tag struct, you would have

tagX.size = data1[2]
tagX.magic = data1[3]

If somehow data1[3] matches the magic, you'll detect tag data as a tag 
header, and that's no good. Also, you may be missing a tag by checking 
every 16B, which isn't guaranteed by Rockchip's ATAGS (only guaranteed 
to be 4B aligned)

tag1.size is the size of the tag1 in multiples of 4B (u32), so the 
header + data.

That's what I got from

"""
#define tag_next(t)     ((struct tag *)((u32 *)(t) + (t)->hdr.size))
"""

because of pointer arithmetic there.

[...]

>>> +	}
>>> +	if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
>>> +		return -ENODATA;
>>> +
>>> +	ddr_info = (void *)addr + 4;
>>
>> It seems that arithmetic operations on void pointers is illegal in the C
>> standard. This also quite obfuscate what you want to do here.
>>
>> Considering that in this patch you're iterating for each 4B until you get
>> the MAGIC, the next 4B are data for that header of that magic.
>>
>> If you go for the tag_header I suggested above, I would recommend to do the
>> following instead:
>>
>> """
>> ddr_info = (u8*)addr + sizeof(addr);
>> """
>>
>> This is a bit more explicit wrt to what's expected, we want to have the
>> address of the data right after the tag_header we point to currently. (and
>> in-code comments also do not hurt :) ).
>>
> 
> Should I use a (u8*) though? While that works for now, if the ATAGS get
> put at a higher offset wouldn't something like a u32 make more sense?
> 

That's a good point, but because of pointer arithmetic you cannot simply 
have

"""
ddr_info = (u32*)addr + sizeof(addr);
"""

Because that would make ddr_info 4* 4B (sizeof(addr) * u32 pointer 
arithmetic).

What you could do is:

"""
bool core_found = false;
u32* addr = (void *)ATAGS_PHYS_BASE;
struct tag_header *tag = addr;

while (addr < (ATAGS_PHYS_BASE + ATAGS_SIZE)) {
	val = tag->magic;
	if (!core_found) {
         	if (val == ATAGS_CORE_MAGIC)
			core_found = true;
         } else if (val == ATAGS_DDR_MEM_MAGIC) {
		break;
	}

	addr += tag->size;
         tag = addr;
}

if (addr >= (ATAGS_PHYS_BASE + ATAGS_SIZE))
	return -ENODATA;

ddr_info = addr + sizeof(tag) / sizeof(u32);
if (!ddr_info->count || ddr_info->count > CONFIG_NR_DRAM_BANKS)
	return -ENODATA;
"""

(NOT COMPILED/TESTED)

Cheers,
Quentin
