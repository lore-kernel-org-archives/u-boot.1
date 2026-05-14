Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ABECD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 05:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCCE80F0E;
	Thu, 14 May 2026 07:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KVF2lGlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F348056B; Thu, 14 May 2026 07:47:25 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0807C83E81
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 07:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgQgm8hjTq3uWePzcYDB9y4faDGgwq1QDogdTmH65oF/BI69ecI6fLK/j8oaBnZrwB2vS4+mO6Ku+8jMhsODqnMdYE1Op3vGs3htbMVOe9S/8fwh1mBYyqdDmBxrRU2NcfCCtY7YS2B30GS/fbRbGP3BxJGGU5r8dCbnZcKgBMKao50b1cyt5plKW5K0Z+C0FpPWdsLgsgqBhnmwzKTCfFuingFbLNKM8KEkNz/bELjvtbSPDCFmbSecAhH3yzTOgOGmxMU4gvUfekCRHe0MijiKV4a9H6Xa3j8hdorXXoRdzB3aEbgndj/tnqO/YiG5gX9r/pQu7NyXZmiVzwP2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmmINoH1dgcTJPJy1ZgMmXmO2p4Sc400C34/iwzfUVI=;
 b=psBqQeI6yjD5LneQ5wsKqAvOoMbrEeitVJEsS/5Hnkuol5NgzYur2gt+8YL0EvKHmrl5PKiV3AnK3Zq5a7ofvucnmHYR1OMgOEWAZDHVPLVimVF2ZTJ/XaPGrRBKXejJKnL4EZc61QBrpCJRKIyyMAf4nzhbZ1jFS/+3/UaWgLU0ES4S/N7RXqCdl3VBPbG66TUt5mon9Vji+/nbIoZwdZ0iHuvC3Rty7ZGwVtOpCkd86JFKFPx6piu/XuLTlA/Dub6fd68QHdeLZY/sOSpMkiZEY6Iydii0yLMSVvG+2K+glfsg/3Zxpzc9Ba63mdkUDJ6eNUufJ0az2z1iBRgHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmmINoH1dgcTJPJy1ZgMmXmO2p4Sc400C34/iwzfUVI=;
 b=KVF2lGlv05/Q1GeOWAWM/pVyUT8DDJjjTEwh6Bv15p1Qg99eWpAx/+WsQjiOtt+7A8R8jUMqmOJHY6zA+dO2ylx9yC8MG/hQ1/NDlG3251dhBdkecMXED3yyi143dRIasHW/8Uefn3IIGbhYJXBl4/p7JwlP1wSpTrobeu1el2UgQzD5Wrrf4b0AYpoprHgX6iNNgvS/x3sqXyNRe1ljJbXi1LdSD3aJm9P+UV2gW4Vt2pb4DXkc5CA97Gqb1HTjWwDYuxdESjAQfe4HaXIKmfmqI39RZbqS2tKa04DXfNCiKyqA1i7NFU+yKlPvSHA9wLM5tLKO1NAlz+b0N0xtTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DS2PR03MB8465.namprd03.prod.outlook.com (2603:10b6:8:32b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:47:19 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:47:19 +0000
Message-ID: <4e117d75-3551-46f1-b4f1-9cc6ee330751@altera.com>
Date: Thu, 14 May 2026 13:47:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] clk: s10: Refactor S10 clock driver
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-8-alif.zakuan.yuslaimi@altera.com>
 <cede72ae-d25f-4b76-89fe-752e9d315478@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <cede72ae-d25f-4b76-89fe-752e9d315478@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DS2PR03MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: cecca3b9-1654-42c5-9c71-08deb17c42ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|55112099003|13003099007|4143699003|56012099003|11063799003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: Dlm5YTgQ+hPIc85rYF7PIeUvd04GiUBU8CR75HxqLnRuHnKwGwqvz6psuQqS3PMcuipYni5gC1Vv7sUEWVwPBaHA5sr8GCnXAE8D/LzHNn1I10oj96LM+IbP9YGs8+iUaTMgB11e4Mw/kc43YEIRJCsbhNomPfbHJwYb7ECKZH/cFSiGB5QpVuADQEd6+L5P/TGWKbYBDnCjzLiGxLPcqojWsi7DHWP/gG5YrJMYj2ey4BKne5nlrpRsj2V45AyPKq0AboqLcX5yB/DiJl1fzKTfAyCQIFj/pnjR1KtQyY8WVlARWyt+VLHtmLe599ZrWKprqQ/yjh4LxR1fQnOS/z+j1YJofiWNGbDz9d2xIt9kRY4iMfiLKnC+mNF03tKkwb401O3xwoGYIntqFekIO36w17a5LCbefPtR4HDEWVWRWWsiJUBIbWe5s/Q4pjmw5CSXIMXgxNk8+ch1e2aqGWjLCyvl/8rbSmSvGhdtHsbgdg+9XINQ7dGdu3T9rh7V+RNBAuEka/JW82sSurp7jLbPm2iCGOhF5JwrYAoON2hNf/FIFYdAzqZTdHxHMm5TwOUcQHF5+uGPHQEhSc1KYAIAiEuoSM9ztyROzmQ8+WgzMkemwdDsfkJdeR2kDIuNp+JbSlJyR+HWqsfTm/qFFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(55112099003)(13003099007)(4143699003)(56012099003)(11063799003)(18002099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amp0Q3dGdjE3MkxDM1BEbkdZaFNPSys4aE93WEpMYTVZRmJFZlRBZGhSK1V5?=
 =?utf-8?B?NFlNem5taWxPVk5sV1lyN01ETzhKaktFK0p5QXU2cVJTSWdJVnd2MXNJZWxn?=
 =?utf-8?B?Vm1hWVdRWm5telRseDhCOWJHRUFOSHhrdU9VV0EyYXord0k3azdEU2xnbFFY?=
 =?utf-8?B?RkFQcjRiSFBrY3VTR3U1bjFsL2ZPRGFJM1hzc1Bab2RhT0pONzFOWFFPWkRN?=
 =?utf-8?B?UGJiamk4ZEE0ZTZJZ0lXTzZXaFBtenNwY0V4M2gzak1McUR3Y3UrZUZaS0VV?=
 =?utf-8?B?MGNpUW5sdnIxc25NS0t3dFF1TVpMVWxwMHlaaTNVN0xUOE4wdTRiYVdpN3Nl?=
 =?utf-8?B?bVpPSEdrNUNHUWRiQzVNWTl3T0lFWkE0Z1crRHBwNCt2dlMydTFKM1FiajBs?=
 =?utf-8?B?bjJzVEIvYy9idlB3VkRCaFM1a3FpdUdZOXRDdVNSNDRuWHdEME9zL1dMZ3l0?=
 =?utf-8?B?RGorSWJYN2xnM0l0RlNsekV0WTJGL04yUG1iRG85MFZMKzcxTnNSRlM3a1dy?=
 =?utf-8?B?QnNDVjBLejNFbEhIQTRta0ZpUVNCUkJybnFjWTNXM1ZvLy9uYTJCdCtRK1A3?=
 =?utf-8?B?elcwWnQ1RE1KaG9OZ3FVQS8zSEM5MjVuVmlSY011RFI5ekJvblh0QnU2YUdK?=
 =?utf-8?B?YWdvNC9aUGhnbEZxMG1LWXdHMUlsOFpUaWV0VGNNb2ZwR0E4Y3AwQ3NCem4x?=
 =?utf-8?B?NXRDdHFCTDhqUHQ2ZlUzSlZLZmg1emlFenJwblg3Skp3YjNPcTdqUXlwVGVB?=
 =?utf-8?B?ZHdaRU1YdE9XRi9ES0ZtMnBIZkR6SnB2bGhnckh3YzBrdlhRT2o5anMvK1Ri?=
 =?utf-8?B?WXAySE1sTmVLSFoxQ1JPYTJDbUp2dlhMNlIwbXB2aFFmeWtVQmNtNDBCekxy?=
 =?utf-8?B?M1Z0UXpPNlJtNXExa0UwN3VZZSs2ekdNazRJOFdSaDZuYmE0VkRUZ3ZueVlu?=
 =?utf-8?B?YUpBNE8zUnpKd1JxOHR3Y2NFVURCTVZwWHg1UmxTYnltUVJZdm9qaWlhU1ox?=
 =?utf-8?B?VzgwMlBmSVFnOVkrWXJpeFFWKzlLQXMxTXg0VkhBY0FXZ0dCNUlZSkc4Wm0z?=
 =?utf-8?B?bld6MjJQRnEzTmR3YktHU05YYlFTMnQyMCtFZlo2S1B4WXN0WTBZMVdaWFFv?=
 =?utf-8?B?WXRtcnE0VmtvOGF3K3B1akdQMHpnb0kxY0JPV1FKSGx3VG45aW12US9kdEx6?=
 =?utf-8?B?akdqZEFGekJ3enh5OTZvYVYxcU5lSE9JcjlYeFFDUE5iUHJzUU01QmMyWWdy?=
 =?utf-8?B?TDg2SjhBWnVIc3paeTRqS0NqL3luSjVGMEFTakIrVFloRncrdWgvSVFEYmVi?=
 =?utf-8?B?V1EyQnhDaVR0MEg5WTlZQzk5cEVVZjNCUUxMb3A3dkRycGNRNndOVXNSdTJl?=
 =?utf-8?B?MGcrQUZIVVBXQ3YxV3c5dlcwUmQ1WjhUcjgzazh2cFJoSVdVSkZYdXRsT1JM?=
 =?utf-8?B?UUJsbURMZ013aytGSmlYb0haaUs0WUZBWkkzcy9JUTV5RGx1WFRjcVppM3c4?=
 =?utf-8?B?RmU3NDBzTlVZYUdQdDZ1c1lURkR0UHFobHJoSzgzWlVHRG5RaEJoZUU5c3Jl?=
 =?utf-8?B?VzQ0L2MvVy9QZG9DS040amwxS2Y5ZmFUUlBPWDZXVDdIaE9Kdk1iYzljVUVx?=
 =?utf-8?B?NTVvdzRUSTFaYlNIWEJLOHFRL0x4MXgreUlzcitTU1E1eDdPcHZMQUxFTFBC?=
 =?utf-8?B?Slc2U1laS3NpUFNMVHFsN0JuQXova0h4ZnRaRmFGZDlWV2FGZE1RNXBacTZY?=
 =?utf-8?B?dEpsaVNvcHVGaVNWNklVRC9IQTg3aXVwZkV4TDEzSFNUdndUK0pmUVdXUDBT?=
 =?utf-8?B?QmlqZ0NlanZ2ZFFpWDA5QzVGVlltTzIwTDBSRVpGWUIzVHUrRkFuZVZwVmls?=
 =?utf-8?B?YnRMeWNMTWdoRXFKR1l4RGU4WHZjV0JPamUzMGxwMmhuejV4dFhjaFBzdVF6?=
 =?utf-8?B?aTlMbDdGOCtNTlB5NDV0SVkyNXpvUXREaXlSbW5UQTQydHJ5MkpoSklpUWsy?=
 =?utf-8?B?OW1YZW5pRGMzRjErMTgralN4WkladkFVZU5hQkp6RnpIZHJ5WllVMFI5ajBm?=
 =?utf-8?B?M2xmM1o3bTd4SzQ3NCtOZEFzWVlydjdzZk04cHkxWk1hTjlROUwyOE5zSlJH?=
 =?utf-8?B?MG9GOVd2V3QxTlVxRzdYZ01yQWZxRFFOOGU2WUlHbnhPd3VuY1hjanpWVmJK?=
 =?utf-8?B?Z094T0hURjNoalJ6aTNJV3o0S251U1VwdXNhZ3haMitqS0w4a0NnOGtmUmtj?=
 =?utf-8?B?MFQweXBNc3pEdVYyaGJOdzJaT0FoNTF4RllRWm5jdG1lWEdJaUNrWXBJNmRQ?=
 =?utf-8?B?b0R1V0pKbFlHc3lvdWxIMFV5cnNUT1pRZHJwLzBxNG5KUXhaRlVUcjdtSVdV?=
 =?utf-8?Q?cUnXnsp0tUEW1simldlOoXbmsSJ+LeWlTOH5z?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecca3b9-1654-42c5-9c71-08deb17c42ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:47:19.4048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/0ozVcRrEcEvk/saiGgyxfrhJPSEclMbo1Hf4kFT31PKSxABRpLnvf5ICN8CNjD11l3qGwi9o/kq0YkKvxkba07wzlFa6y/JdFpY+W6HCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8465
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

Hi Tien Fong,

On 8/5/2026 1:48 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Refactor Stratix10 clock manager driver to support driver model, 
>> following
>> Agilex clock driver.
>>
>> Create a new clock driver, clk-s10.c, for Stratix10 which supports the
>> driver model. This allows several APIs such as enable/disable clock, and
>> get clock rate to be supported.
>>
>> This driver will be initialized during SPL to bring up the clock as early
>> as possible. The clock initialization process are refactored into this 
>> new
>> driver from clock_manager_s10.c during clock driver probe.
>>
>> Excluding Stratix10 from legacy method of obtaining clkmgr base 
>> address in
>> mach-socfpga/misc.c as the base address is already obtained during clock
>> driver probe during SPL initialization.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   MAINTAINERS                                   |   1 +
>>   arch/arm/mach-socfpga/Kconfig                 |   2 +
>>   arch/arm/mach-socfpga/clock_manager_s10.c     | 449 ++-----------
>>   .../include/mach/clock_manager_s10.h          | 176 +----
>>   arch/arm/mach-socfpga/misc.c                  |   3 +-
>>   arch/arm/mach-socfpga/spl_s10.c               |   7 +-
>>   drivers/clk/altera/Makefile                   |   1 +
>>   drivers/clk/altera/clk-s10.c                  | 603 ++++++++++++++++++
>>   drivers/clk/altera/clk-s10.h                  | 202 ++++++
>>   9 files changed, 873 insertions(+), 571 deletions(-)
>>   create mode 100644 drivers/clk/altera/clk-s10.c
>>   create mode 100644 drivers/clk/altera/clk-s10.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d1173126fc6..032f0ee97fc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -159,6 +159,7 @@ F:    arch/arm/mach-socfpga/
>>   F:    board/altera/stratix10-socdk/
>>   F:    board/intel/agilex-socdk/
>>   F:    configs/socfpga_*
>> +F:    drivers/clk/altera/
>>   F:    drivers/ddr/altera/
>>   F:    drivers/power/domain/altr-pmgr-agilex5.c
>>   F:    drivers/sysreset/sysreset_socfpga*
>> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/ 
>> Kconfig
>> index fb98b647442..aa1f3e761cd 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -146,8 +146,10 @@ config ARCH_SOCFPGA_STRATIX10
>>       select ARMV8_MULTIENTRY
>>       select ARMV8_SET_SMPEN
>>       select BINMAN if SPL_ATF
>> +    select CLK
>>       select FPGA_INTEL_SDM_MAILBOX
>>       select GICV2
>> +    select SPL_CLK if SPL
>>       select ARCH_SOCFPGA_SOC64
>>   choice
>> diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/ 
>> mach-socfpga/clock_manager_s10.c
>> index fd27470f967..df636f14f93 100644
>> --- a/arch/arm/mach-socfpga/clock_manager_s10.c
>> +++ b/arch/arm/mach-socfpga/clock_manager_s10.c
>> @@ -1,425 +1,78 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>> - * Copyright (C) 2016-2023 Intel Corporation <www.intel.com>
> 
> 
> all prior copyright notices to be retained
> 
> 
Noted, I will re-add this in v3.

>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>    *
>>    */
>> -#include <compiler.h>
>> -#include <dm/device.h>
>> -#include <linux/errno.h>
>> -#include <asm/io.h>
>> +#include <clk.h>
>> +#include <dm.h>
>> +#include <log.h>
>> +#include <malloc.h>
>>   #include <asm/arch/clock_manager.h>
>> -#include <asm/arch/handoff_soc64.h>
>>   #include <asm/arch/system_manager.h>
>> +#include <asm/io.h>
>> +#include <dt-bindings/clock/stratix10-clock.h>
>> -/*
>> - * function to write the bypass register which requires a poll of the
>> - * busy bit
>> - */
>> -static void cm_write_bypass_mainpll(u32 val)
>> -{
>> -    writel(val, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_BYPASS);
>> -    cm_wait_for_fsm();
>> -}
>> -
>> -static void cm_write_bypass_perpll(u32 val)
>> -{
>> -    writel(val, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_BYPASS);
>> -    cm_wait_for_fsm();
>> -}
>> -
>> -/* function to write the ctrl register which requires a poll of the 
>> busy bit */
>> -static void cm_write_ctrl(u32 val)
>> -{
>> -    writel(val, socfpga_get_clkmgr_addr() + CLKMGR_S10_CTRL);
>> -    cm_wait_for_fsm();
>> -}
>> -
>> -/*
>> - * Setup clocks while making no assumptions about previous state of 
>> the clocks.
>> - */
>> -void cm_basic_init(const struct cm_config * const cfg)
>> -{
>> -    u32 mdiv, refclkdiv, mscnt, hscnt, vcocalib;
>> -
>> -    if (cfg == 0)
>> -        return;
>> -
>> -    /* Put all plls in bypass */
>> -    cm_write_bypass_mainpll(CLKMGR_BYPASS_MAINPLL_ALL);
>> -    cm_write_bypass_perpll(CLKMGR_BYPASS_PERPLL_ALL);
>> -
>> -    /* setup main PLL dividers where calculate the vcocalib value */
>> -    mdiv = (cfg->main_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
>> -        CLKMGR_FDBCK_MDIV_MASK;
>> -    refclkdiv = (cfg->main_pll_pllglob >> 
>> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> -             CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> -    mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
>> -    hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
>> -        CLKMGR_HSCNT_CONST;
>> -    vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
>> -           ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
>> -           CLKMGR_VCOCALIB_MSCNT_OFFSET);
>> -
>> -    writel((cfg->main_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
>> -        ~CLKMGR_PLLGLOB_RST_MASK),
>> -        socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLGLOB);
>> -    writel(cfg->main_pll_fdbck,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_FDBCK);
>> -    writel(vcocalib,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_VCOCALIB);
>> -    writel(cfg->main_pll_pllc0,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLC0);
>> -    writel(cfg->main_pll_pllc1,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLC1);
>> -    writel(cfg->main_pll_nocdiv,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_NOCDIV);
>> -
>> -    /* setup peripheral PLL dividers */
>> -    /* calculate the vcocalib value */
>> -    mdiv = (cfg->per_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
>> -        CLKMGR_FDBCK_MDIV_MASK;
>> -    refclkdiv = (cfg->per_pll_pllglob >> 
>> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> -             CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> -    mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
>> -    hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
>> -        CLKMGR_HSCNT_CONST;
>> -    vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
>> -           ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
>> -           CLKMGR_VCOCALIB_MSCNT_OFFSET);
>> -
>> -    writel((cfg->per_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
>> -        ~CLKMGR_PLLGLOB_RST_MASK),
>> -        socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLGLOB);
>> -    writel(cfg->per_pll_fdbck,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_FDBCK);
>> -    writel(vcocalib,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_VCOCALIB);
>> -    writel(cfg->per_pll_pllc0,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLC0);
>> -    writel(cfg->per_pll_pllc1,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLC1);
>> -    writel(cfg->per_pll_emacctl,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_EMACCTL);
>> -    writel(cfg->per_pll_gpiodiv,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_GPIODIV);
>> -
>> -    /* Take both PLL out of reset and power up */
>> -    setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLGLOB,
>> -             CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
>> -    setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLGLOB,
>> -             CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
>> -
>> -#define LOCKED_MASK \
>> -    (CLKMGR_STAT_MAINPLL_LOCKED | \
>> -    CLKMGR_STAT_PERPLL_LOCKED)
>> -
>> -    cm_wait_for_lock(LOCKED_MASK);
>> -
>> -    /*
>> -     * Dividers for C2 to C9 only init after PLLs are lock. As dividers
>> -     * only take effect upon value change, we shall set a maximum 
>> value as
>> -     * default value.
>> -     */
>> -    writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_MPUCLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_NOCCLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR2CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR3CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR4CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR5CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR6CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR7CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR8CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_MAINPLL_CNTR9CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR2CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR3CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR4CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR5CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR6CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR7CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR8CLK);
>> -    writel(0xff, socfpga_get_clkmgr_addr() + 
>> CLKMGR_S10_PERPLL_CNTR9CLK);
>> -
>> -    writel(cfg->main_pll_mpuclk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_MPUCLK);
>> -    writel(cfg->main_pll_nocclk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_NOCCLK);
>> -    writel(cfg->main_pll_cntr2clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR2CLK);
>> -    writel(cfg->main_pll_cntr3clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR3CLK);
>> -    writel(cfg->main_pll_cntr4clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR4CLK);
>> -    writel(cfg->main_pll_cntr5clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR5CLK);
>> -    writel(cfg->main_pll_cntr6clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR6CLK);
>> -    writel(cfg->main_pll_cntr7clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR7CLK);
>> -    writel(cfg->main_pll_cntr8clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR8CLK);
>> -    writel(cfg->main_pll_cntr9clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR9CLK);
>> -    writel(cfg->per_pll_cntr2clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR2CLK);
>> -    writel(cfg->per_pll_cntr3clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR3CLK);
>> -    writel(cfg->per_pll_cntr4clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR4CLK);
>> -    writel(cfg->per_pll_cntr5clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR5CLK);
>> -    writel(cfg->per_pll_cntr6clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR6CLK);
>> -    writel(cfg->per_pll_cntr7clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR7CLK);
>> -    writel(cfg->per_pll_cntr8clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR8CLK);
>> -    writel(cfg->per_pll_cntr9clk,
>> -           socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR9CLK);
>> -
>> -    /* Take all PLLs out of bypass */
>> -    cm_write_bypass_mainpll(0);
>> -    cm_write_bypass_perpll(0);
>> -
>> -    /* clear safe mode / out of boot mode */
>> -    cm_write_ctrl(readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_CTRL) &
>> -              ~(CLKMGR_CTRL_SAFEMODE));
>> -
>> -    /* Now ungate non-hw-managed clocks */
>> -    writel(~0, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_EN);
>> -    writel(~0, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_EN);
>> -
>> -    /* Clear the loss of lock bits (write 1 to clear) */
>> -    writel(CLKMGR_INTER_PERPLLLOST_MASK |
>> -              CLKMGR_INTER_MAINPLLLOST_MASK,
>> -              socfpga_get_clkmgr_addr() + CLKMGR_S10_INTRCLR);
>> -}
>> -
>> -static unsigned long cm_get_main_vco_clk_hz(void)
>> +static ulong cm_get_rate_dm(u32 id)
>>   {
>> -     unsigned long fref, refdiv, mdiv, reg, vco;
>> -
>> -    reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLGLOB);
>> -
>> -    fref = (reg >> CLKMGR_PLLGLOB_VCO_PSRC_OFFSET) &
>> -        CLKMGR_PLLGLOB_VCO_PSRC_MASK;
>> -    switch (fref) {
>> -    case CLKMGR_VCO_PSRC_EOSC1:
>> -        fref = cm_get_osc_clk_hz();
>> -        break;
>> -    case CLKMGR_VCO_PSRC_INTOSC:
>> -        fref = cm_get_intosc_clk_hz();
>> -        break;
>> -    case CLKMGR_VCO_PSRC_F2S:
>> -        fref = cm_get_fpga_clk_hz();
>> -        break;
>> +    struct udevice *dev;
>> +    struct clk clk;
>> +    ulong rate;
>> +    int ret;
>> +
>> +    ret = uclass_get_device_by_driver(UCLASS_CLK,
>> +                      DM_DRIVER_GET(socfpga_s10_clk),
>> +                      &dev);
>> +    if (ret)
>> +        return 0;
>> +
>> +    clk.id = id;
>> +    ret = clk_request(dev, &clk);
>> +    if (ret < 0)
>> +        return 0;
>> +
>> +    rate = clk_get_rate(&clk);
>> +
>> +    if ((rate == (unsigned long)-ENOSYS) ||
>> +        (rate == (unsigned long)-ENXIO) ||
>> +        (rate == (unsigned long)-EIO)) {
>> +        debug("%s id %u: clk_get_rate err: %ld\n",
>> +              __func__, id, rate);
>> +        return 0;
>>       }
>> -    refdiv = (reg >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> -          CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> -
>> -    reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_FDBCK);
>> -    mdiv = (reg >> CLKMGR_FDBCK_MDIV_OFFSET) & CLKMGR_FDBCK_MDIV_MASK;
>> -
>> -    vco = fref / refdiv;
>> -    vco = vco * (CLKMGR_MDIV_CONST + mdiv);
>> -    return vco;
>> +    return rate;
>>   }
>> -static unsigned long cm_get_per_vco_clk_hz(void)
>> +static u32 cm_get_rate_dm_khz(u32 id)
>>   {
>> -    unsigned long fref, refdiv, mdiv, reg, vco;
>> -
>> -    reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLGLOB);
>> -
>> -    fref = (reg >> CLKMGR_PLLGLOB_VCO_PSRC_OFFSET) &
>> -        CLKMGR_PLLGLOB_VCO_PSRC_MASK;
>> -    switch (fref) {
>> -    case CLKMGR_VCO_PSRC_EOSC1:
>> -        fref = cm_get_osc_clk_hz();
>> -        break;
>> -    case CLKMGR_VCO_PSRC_INTOSC:
>> -        fref = cm_get_intosc_clk_hz();
>> -        break;
>> -    case CLKMGR_VCO_PSRC_F2S:
>> -        fref = cm_get_fpga_clk_hz();
>> -        break;
>> -    }
>> -
>> -    refdiv = (reg >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> -          CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> -
>> -    reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_FDBCK);
>> -    mdiv = (reg >> CLKMGR_FDBCK_MDIV_OFFSET) & CLKMGR_FDBCK_MDIV_MASK;
>> -
>> -    vco = fref / refdiv;
>> -    vco = vco * (CLKMGR_MDIV_CONST + mdiv);
>> -    return vco;
>> +    return cm_get_rate_dm(id) / 1000;
>>   }
>>   unsigned long cm_get_mpu_clk_hz(void)
>>   {
>> -    unsigned long clock = readl(socfpga_get_clkmgr_addr() +
>> -                    CLKMGR_S10_MAINPLL_MPUCLK);
>> -
>> -    clock = (clock >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
>> -
>> -    switch (clock) {
>> -    case CLKMGR_CLKSRC_MAIN:
>> -        clock = cm_get_main_vco_clk_hz();
>> -        clock /= (readl(socfpga_get_clkmgr_addr() +
>> -                CLKMGR_S10_MAINPLL_PLLC0) &
>> -              CLKMGR_PLLC0_DIV_MASK);
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_PER:
>> -        clock = cm_get_per_vco_clk_hz();
>> -        clock /= (readl(socfpga_get_clkmgr_addr() +
>> -                CLKMGR_S10_PERPLL_PLLC0) &
>> -              CLKMGR_CLKCNT_MSK);
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_OSC1:
>> -        clock = cm_get_osc_clk_hz();
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_INTOSC:
>> -        clock = cm_get_intosc_clk_hz();
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_FPGA:
>> -        clock = cm_get_fpga_clk_hz();
>> -        break;
>> -    }
>> -
>> -    clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
>> -                CLKMGR_S10_MAINPLL_MPUCLK) & CLKMGR_CLKCNT_MSK);
>> -    return clock;
>> -}
>> -
>> -unsigned int cm_get_l3_main_clk_hz(void)
>> -{
>> -    u32 clock = readl(socfpga_get_clkmgr_addr() +
>> -              CLKMGR_S10_MAINPLL_NOCCLK);
>> -
>> -    clock = (clock >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
>> -
>> -    switch (clock) {
>> -    case CLKMGR_CLKSRC_MAIN:
>> -        clock = cm_get_main_vco_clk_hz();
>> -        clock /= (readl(socfpga_get_clkmgr_addr() +
>> -                CLKMGR_S10_MAINPLL_PLLC1) &
>> -              CLKMGR_PLLC0_DIV_MASK);
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_PER:
>> -        clock = cm_get_per_vco_clk_hz();
>> -        clock /= (readl(socfpga_get_clkmgr_addr() +
>> -              CLKMGR_S10_PERPLL_PLLC1) & CLKMGR_CLKCNT_MSK);
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_OSC1:
>> -        clock = cm_get_osc_clk_hz();
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_INTOSC:
>> -        clock = cm_get_intosc_clk_hz();
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_FPGA:
>> -        clock = cm_get_fpga_clk_hz();
>> -        break;
>> -    }
>> -
>> -    clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
>> -              CLKMGR_S10_MAINPLL_NOCCLK) & CLKMGR_CLKCNT_MSK);
>> -    return clock;
>> -}
>> -
>> -unsigned int cm_get_mmc_controller_clk_hz(void)
>> -{
>> -    u32 clock = readl(socfpga_get_clkmgr_addr() +
>> -              CLKMGR_S10_PERPLL_CNTR6CLK);
>> -
>> -    clock = (clock >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
>> -
>> -    switch (clock) {
>> -    case CLKMGR_CLKSRC_MAIN:
>> -        clock = cm_get_l3_main_clk_hz();
>> -        clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
>> -                    CLKMGR_S10_MAINPLL_CNTR6CLK) &
>> -                  CLKMGR_CLKCNT_MSK);
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_PER:
>> -        clock = cm_get_l3_main_clk_hz();
>> -        clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
>> -                    CLKMGR_S10_PERPLL_CNTR6CLK) &
>> -                  CLKMGR_CLKCNT_MSK);
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_OSC1:
>> -        clock = cm_get_osc_clk_hz();
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_INTOSC:
>> -        clock = cm_get_intosc_clk_hz();
>> -        break;
>> -
>> -    case CLKMGR_CLKSRC_FPGA:
>> -        clock = cm_get_fpga_clk_hz();
>> -        break;
>> -    }
>> -    return clock / 4;
>> -}
>> -
>> -unsigned int cm_get_l4_sp_clk_hz(void)
>> -{
>> -    u32 clock = cm_get_l3_main_clk_hz();
>> -
>> -    clock /= (1 << ((readl(socfpga_get_clkmgr_addr() +
>> -                   CLKMGR_S10_MAINPLL_NOCDIV) >>
>> -             CLKMGR_NOCDIV_L4SPCLK_OFFSET) & CLKMGR_CLKCNT_MSK));
>> -    return clock;
>> -}
>> -
>> -unsigned int cm_get_spi_controller_clk_hz(void)
>> -{
>> -    u32 clock = cm_get_l3_main_clk_hz();
>> -
>> -    clock /= (1 << ((readl(socfpga_get_clkmgr_addr() +
>> -                   CLKMGR_S10_MAINPLL_NOCDIV) >>
>> -             CLKMGR_NOCDIV_L4MAIN_OFFSET) & CLKMGR_CLKCNT_MSK));
>> -    return clock;
>> +    return cm_get_rate_dm(STRATIX10_MPU_CLK);
>>   }
>>   unsigned int cm_get_l4_sys_free_clk_hz(void)
>>   {
>> -    return cm_get_l3_main_clk_hz() / 4;
>> -}
>> -
>> -/*
>> - * Override weak dw_spi_get_clk implementation in designware_spi.c 
>> driver
>> - */
>> -
>> -int dw_spi_get_clk(struct udevice *bus, ulong *rate)
>> -{
>> -    *rate = cm_get_spi_controller_clk_hz();
>> -    if (!*rate) {
>> -        printf("SPI: clock rate is zero");
>> -        return -EINVAL;
>> -    }
>> -
>> -    return 0;
> 
> 
> The dw_spi_get_clk() removal and the missing STRATIX10_L4_MAIN_CLK(from 
> upstream dts) in socfpga_clk_get_rate() have impacted
> 
> the use case where someone enables spi@ffda4000 or spi@ffda5000 in a 
> board DTS for a general-purpose SPI peripheral (not the use case spi0 = 
> &qspi alias)
> 
> 
I get your point, I will introduce a new function to get clock rate for 
STRATIX10_L4_MAIN_CLK clock in v3.

>> +    return cm_get_rate_dm(STRATIX10_L4_SYS_FREE_CLK);
>>   }
>>   void cm_print_clock_quick_summary(void)
>>   {
>> -    printf("MPU         %d kHz\n", (u32)(cm_get_mpu_clk_hz() / 1000));
>> -    printf("L3 main     %d kHz\n", cm_get_l3_main_clk_hz() / 1000);
>> -    printf("Main VCO    %d kHz\n", (u32)(cm_get_main_vco_clk_hz() / 
>> 1000));
>> -    printf("Per VCO     %d kHz\n", (u32)(cm_get_per_vco_clk_hz() / 
>> 1000));
>> -    printf("EOSC1       %d kHz\n", cm_get_osc_clk_hz() / 1000);
>> -    printf("HPS MMC     %d kHz\n", cm_get_mmc_controller_clk_hz() / 
>> 1000);
>> -    printf("UART        %d kHz\n", cm_get_l4_sp_clk_hz() / 1000);
>> +    printf("MPU         %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_MPU_CLK));
>> +    printf("L3 main     %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_NOC_CLK));
>> +    printf("Main VCO    %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_MAIN_PLL_CLK));
>> +    printf("Per VCO     %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_PERIPH_PLL_CLK));
>> +    printf("EOSC1       %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_OSC1));
>> +    printf("HPS MMC     %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_SDMMC_CLK));
>> +    printf("UART        %d kHz\n",
>> +           cm_get_rate_dm_khz(STRATIX10_L4_SP_CLK));
>>   }
>> diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h b/ 
>> arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
>> index 5dcbda9473e..e5ff0648b86 100644
>> --- a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
>> +++ b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
>> @@ -1,177 +1,13 @@
>> -/* SPDX-License-Identifier: GPL-2.0
>> - *
>> - * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
> 
> 
> all prior copyright notices to be retained
> 
> 
Sure, I will re-add this in v3.

>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>>    *
>>    */
>> -#ifndef    _CLOCK_MANAGER_S10_
>> -#define    _CLOCK_MANAGER_S10_
>> +#ifndef _CLOCK_MANAGER_S10_
>> +#define _CLOCK_MANAGER_S10_
>>   #include <asm/arch/clock_manager_soc64.h>
>> -#include <linux/bitops.h>
>> -
>> -/* Clock speed accessors */
>> -unsigned long cm_get_sdram_clk_hz(void);
>> -unsigned int cm_get_l4_sp_clk_hz(void);
>> -unsigned int cm_get_mmc_controller_clk_hz(void);
>> -unsigned int cm_get_spi_controller_clk_hz(void);
>> -
>> -struct cm_config {
>> -    /* main group */
>> -    u32 main_pll_mpuclk;
>> -    u32 main_pll_nocclk;
>> -    u32 main_pll_cntr2clk;
>> -    u32 main_pll_cntr3clk;
>> -    u32 main_pll_cntr4clk;
>> -    u32 main_pll_cntr5clk;
>> -    u32 main_pll_cntr6clk;
>> -    u32 main_pll_cntr7clk;
>> -    u32 main_pll_cntr8clk;
>> -    u32 main_pll_cntr9clk;
>> -    u32 main_pll_nocdiv;
>> -    u32 main_pll_pllglob;
>> -    u32 main_pll_fdbck;
>> -    u32 main_pll_pllc0;
>> -    u32 main_pll_pllc1;
>> -    u32 spare;
>> -
>> -    /* peripheral group */
>> -    u32 per_pll_cntr2clk;
>> -    u32 per_pll_cntr3clk;
>> -    u32 per_pll_cntr4clk;
>> -    u32 per_pll_cntr5clk;
>> -    u32 per_pll_cntr6clk;
>> -    u32 per_pll_cntr7clk;
>> -    u32 per_pll_cntr8clk;
>> -    u32 per_pll_cntr9clk;
>> -    u32 per_pll_emacctl;
>> -    u32 per_pll_gpiodiv;
>> -    u32 per_pll_pllglob;
>> -    u32 per_pll_fdbck;
>> -    u32 per_pll_pllc0;
>> -    u32 per_pll_pllc1;
>> -
>> -    /* incoming clock */
>> -    u32 hps_osc_clk_hz;
>> -    u32 fpga_clk_hz;
>> -};
>> -
>> -void cm_basic_init(const struct cm_config * const cfg);
>> -
>> -/* Control status */
>> -#define CLKMGR_S10_CTRL                    0x00
>> -#define CLKMGR_S10_STAT                    0x04
>> -#define CLKMGR_S10_INTRCLR                0x14
>> -/* Mainpll group */
>> -#define CLKMGR_S10_MAINPLL_EN                0x30
>> -#define CLKMGR_S10_MAINPLL_BYPASS            0x3c
>> -#define CLKMGR_S10_MAINPLL_MPUCLK            0x48
>> -#define CLKMGR_S10_MAINPLL_NOCCLK            0x4c
>> -#define CLKMGR_S10_MAINPLL_CNTR2CLK            0x50
>> -#define CLKMGR_S10_MAINPLL_CNTR3CLK            0x54
>> -#define CLKMGR_S10_MAINPLL_CNTR4CLK            0x58
>> -#define CLKMGR_S10_MAINPLL_CNTR5CLK            0x5c
>> -#define CLKMGR_S10_MAINPLL_CNTR6CLK            0x60
>> -#define CLKMGR_S10_MAINPLL_CNTR7CLK            0x64
>> -#define CLKMGR_S10_MAINPLL_CNTR8CLK            0x68
>> -#define CLKMGR_S10_MAINPLL_CNTR9CLK            0x6c
>> -#define CLKMGR_S10_MAINPLL_NOCDIV            0x70
>> -#define CLKMGR_S10_MAINPLL_PLLGLOB            0x74
>> -#define CLKMGR_S10_MAINPLL_FDBCK            0x78
>> -#define CLKMGR_S10_MAINPLL_MEMSTAT            0x80
>> -#define CLKMGR_S10_MAINPLL_PLLC0            0x84
>> -#define CLKMGR_S10_MAINPLL_PLLC1            0x88
>> -#define CLKMGR_S10_MAINPLL_VCOCALIB            0x8c
>> -/* Periphpll group */
>> -#define CLKMGR_S10_PERPLL_EN                0xa4
>> -#define CLKMGR_S10_PERPLL_BYPASS            0xb0
>> -#define CLKMGR_S10_PERPLL_CNTR2CLK            0xbc
>> -#define CLKMGR_S10_PERPLL_CNTR3CLK            0xc0
>> -#define CLKMGR_S10_PERPLL_CNTR4CLK            0xc4
>> -#define CLKMGR_S10_PERPLL_CNTR5CLK            0xc8
>> -#define CLKMGR_S10_PERPLL_CNTR6CLK            0xcc
>> -#define CLKMGR_S10_PERPLL_CNTR7CLK            0xd0
>> -#define CLKMGR_S10_PERPLL_CNTR8CLK            0xd4
>> -#define CLKMGR_S10_PERPLL_CNTR9CLK            0xd8
>> -#define CLKMGR_S10_PERPLL_EMACCTL            0xdc
>> -#define CLKMGR_S10_PERPLL_GPIODIV            0xe0
>> -#define CLKMGR_S10_PERPLL_PLLGLOB            0xe4
>> -#define CLKMGR_S10_PERPLL_FDBCK                0xe8
>> -#define CLKMGR_S10_PERPLL_MEMSTAT            0xf0
>> -#define CLKMGR_S10_PERPLL_PLLC0                0xf4
>> -#define CLKMGR_S10_PERPLL_PLLC1                0xf8
>> -#define CLKMGR_S10_PERPLL_VCOCALIB            0xfc
>> -
>> -#define CLKMGR_STAT                    CLKMGR_S10_STAT
>> -#define CLKMGR_INTER                    CLKMGR_S10_INTER
>> -#define CLKMGR_PERPLL_EN                CLKMGR_S10_PERPLL_EN
>> -
>> -#define CLKMGR_CTRL_SAFEMODE                BIT(0)
>> -#define CLKMGR_BYPASS_MAINPLL_ALL            0x00000007
>> -#define CLKMGR_BYPASS_PERPLL_ALL            0x0000007f
>> -
>> -#define CLKMGR_INTER_MAINPLLLOCKED_MASK            0x00000001
>> -#define CLKMGR_INTER_PERPLLLOCKED_MASK            0x00000002
>> -#define CLKMGR_INTER_MAINPLLLOST_MASK            0x00000004
>> -#define CLKMGR_INTER_PERPLLLOST_MASK            0x00000008
>> -#define CLKMGR_STAT_BUSY                BIT(0)
>> -#define CLKMGR_STAT_MAINPLL_LOCKED            BIT(8)
>> -#define CLKMGR_STAT_PERPLL_LOCKED            BIT(9)
>> -
>> -#define CLKMGR_PLLGLOB_PD_MASK                0x00000001
>> -#define CLKMGR_PLLGLOB_RST_MASK                0x00000002
>> -#define CLKMGR_PLLGLOB_VCO_PSRC_MASK            0x3
>> -#define CLKMGR_PLLGLOB_VCO_PSRC_OFFSET            16
>> -#define CLKMGR_VCO_PSRC_EOSC1                0
>> -#define CLKMGR_VCO_PSRC_INTOSC                1
>> -#define CLKMGR_VCO_PSRC_F2S                2
>> -#define CLKMGR_PLLGLOB_REFCLKDIV_MASK            0x3f
>> -#define CLKMGR_PLLGLOB_REFCLKDIV_OFFSET            8
>> -
>> -#define CLKMGR_CLKSRC_MASK                0x7
>> -#define CLKMGR_CLKSRC_OFFSET                16
>> -#define CLKMGR_CLKSRC_MAIN                0
>> -#define CLKMGR_CLKSRC_PER                1
>> -#define CLKMGR_CLKSRC_OSC1                2
>> -#define CLKMGR_CLKSRC_INTOSC                3
>> -#define CLKMGR_CLKSRC_FPGA                4
>> -#define CLKMGR_CLKCNT_MSK                0x7ff
>> -
>> -#define CLKMGR_FDBCK_MDIV_MASK                0xff
>> -#define CLKMGR_FDBCK_MDIV_OFFSET            24
>> -
>> -#define CLKMGR_PLLC0_DIV_MASK                0xff
>> -#define CLKMGR_PLLC1_DIV_MASK                0xff
>> -#define CLKMGR_PLLC0_EN_OFFSET                27
>> -#define CLKMGR_PLLC1_EN_OFFSET                24
>> -
>> -#define CLKMGR_NOCDIV_L4MAIN_OFFSET            0
>> -#define CLKMGR_NOCDIV_L4MPCLK_OFFSET            8
>> -#define CLKMGR_NOCDIV_L4SPCLK_OFFSET            16
>> -#define CLKMGR_NOCDIV_CSATCLK_OFFSET            24
>> -#define CLKMGR_NOCDIV_CSTRACECLK_OFFSET            26
>> -#define CLKMGR_NOCDIV_CSPDBGCLK_OFFSET            28
>> -
>> -#define CLKMGR_NOCDIV_L4SPCLK_MASK            0x3
>> -#define CLKMGR_NOCDIV_DIV1                0
>> -#define CLKMGR_NOCDIV_DIV2                1
>> -#define CLKMGR_NOCDIV_DIV4                2
>> -#define CLKMGR_NOCDIV_DIV8                3
>> -#define CLKMGR_CSPDBGCLK_DIV1                0
>> -#define CLKMGR_CSPDBGCLK_DIV4                1
>> -
>> -#define CLKMGR_MSCNT_CONST                200
>> -#define CLKMGR_MDIV_CONST                6
>> -#define CLKMGR_HSCNT_CONST                9
>> -
>> -#define CLKMGR_VCOCALIB_MSCNT_MASK            0xff
>> -#define CLKMGR_VCOCALIB_MSCNT_OFFSET            9
>> -#define CLKMGR_VCOCALIB_HSCNT_MASK            0xff
>> -
>> -#define CLKMGR_EMACCTL_EMAC0SEL_OFFSET            26
>> -#define CLKMGR_EMACCTL_EMAC1SEL_OFFSET            27
>> -#define CLKMGR_EMACCTL_EMAC2SEL_OFFSET            28
>> -
>> -#define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK        0x00000020
>> +#include "../../../../../drivers/clk/altera/clk-s10.h"
>>   #endif /* _CLOCK_MANAGER_S10_ */
>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>> index 418d7dfb572..6d7128c77be 100644
>> --- a/arch/arm/mach-socfpga/misc.c
>> +++ b/arch/arm/mach-socfpga/misc.c
>> @@ -276,7 +276,8 @@ void socfpga_get_managers_addr(void)
>>                           &socfpga_clkmgr_base);
>>       else if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
>>            !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
>> -         !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5))
>> +         !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) &&
>> +         !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10))
>>           ret = socfpga_get_base_addr("altr,clk-mgr",
>>                           &socfpga_clkmgr_base);
>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/ 
>> spl_s10.c
>> index b05bec2cbc1..ace029557f3 100644
>> --- a/arch/arm/mach-socfpga/spl_s10.c
>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>> @@ -37,7 +37,6 @@ u32 reset_flag(void)
>>   void board_init_f(ulong dummy)
>>   {
>> -    const struct cm_config *cm_default_cfg = cm_get_default_config();
>>       int ret;
>>       struct udevice *dev;
>> @@ -75,7 +74,11 @@ void board_init_f(ulong dummy)
>>       sysmgr_pinmux_init();
>>       /* configuring the HPS clocks */
>> -    cm_basic_init(cm_default_cfg);
>> +    ret = uclass_get_device(UCLASS_CLK, 0, &dev);
>> +    if (ret) {
>> +        debug("Clock init failed: %d\n", ret);
>> +        hang();
>> +    }
>>   #ifdef CONFIG_DEBUG_UART
>>       socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
>> diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
>> index 693446b3d89..e961d059820 100644
>> --- a/drivers/clk/altera/Makefile
>> +++ b/drivers/clk/altera/Makefile
>> @@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += clk-arria10.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += clk-n5x.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += clk-mem-n5x.o
>>   obj-$(CONFIG_ARCH_SOCFPGA_AGILEX5) += clk-agilex5.o
>> +obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += clk-s10.o
>> diff --git a/drivers/clk/altera/clk-s10.c b/drivers/clk/altera/clk-s10.c
>> new file mode 100644
>> index 00000000000..c6492e0cb43
>> --- /dev/null
>> +++ b/drivers/clk/altera/clk-s10.c
>> @@ -0,0 +1,603 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
> 
> 
> NEW FILE, but derived from Intel code
> 
> Copyright (C) 2016-2023 Intel Corporation <www.intel.com> ← must add 
> (code origin)
> 
> 
I will add this in v3.

>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>> + *
>> + */
>> +
>> +#include <log.h>
>> +#include <wait_bit.h>
>> +#include <asm/io.h>
>> +#include <asm/system.h>
>> +#include <clk-uclass.h>
>> +#include <dm.h>
>> +#include <dm/lists.h>
>> +#include <dm/util.h>
>> +#include <dt-bindings/clock/stratix10-clock.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <asm/arch/clock_manager.h>
>> +
>> +struct socfpga_clk_plat {
>> +    void __iomem *regs;
>> +    int pllgrp;
>> +    int bitmask;
>> +};
>> +
>> +/*
>> + * function to write the bypass register which requires a poll of the
>> + * busy bit
>> + */
>> +static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, 
>> u32 val)
>> +{
>> +    void __iomem *base = plat->regs;
>> +
>> +    CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
>> +
>> +    wait_for_bit_le32(base + CLKMGR_STAT,
>> +              CLKMGR_STAT_BUSY, false, 20000, false);
>> +}
>> +
>> +static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, 
>> u32 val)
>> +{
>> +    void __iomem *base = plat->regs;
>> +
>> +    CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
>> +
>> +    wait_for_bit_le32(base + CLKMGR_STAT,
>> +              CLKMGR_STAT_BUSY, false, 20000, false);
>> +}
>> +
>> +/* function to write the ctrl register which requires a poll of the 
>> busy bit */
>> +static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)
>> +{
>> +    void __iomem *base = plat->regs;
>> +
>> +    CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
>> +
>> +    wait_for_bit_le32(base + CLKMGR_STAT,
>> +              CLKMGR_STAT_BUSY, false, 20000, false);
>> +}
>> +
>> +/*
>> + * Setup clocks while making no assumptions about previous state of 
>> the clocks.
>> + */
>> +static void clk_basic_init(struct udevice *dev,
>> +               const struct cm_config * const cfg)
>> +{
>> +    struct socfpga_clk_plat *plat = dev_get_plat(dev);
>> +    u32 mdiv, refclkdiv, mscnt, hscnt, vcocalib;
>> +    uintptr_t base_addr = (uintptr_t)plat->regs;
>> +
>> +    if (!cfg)
>> +        return;
>> +
>> +    /* Put all plls in bypass */
>> +    clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL);
>> +    clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
>> +
>> +    /* setup main PLL dividers where calculate the vcocalib value */
>> +    mdiv = (cfg->main_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
>> +        CLKMGR_FDBCK_MDIV_MASK;
>> +    refclkdiv = (cfg->main_pll_pllglob >> 
>> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> +             CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> +    mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
>> +    hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
>> +        CLKMGR_HSCNT_CONST;
>> +    vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
>> +           ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
>> +           CLKMGR_VCOCALIB_MSCNT_OFFSET);
>> +
>> +    writel((cfg->main_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
>> +        ~CLKMGR_PLLGLOB_RST_MASK),
>> +        base_addr + CLKMGR_MAINPLL_PLLGLOB);
>> +    writel(cfg->main_pll_fdbck,
>> +           base_addr + CLKMGR_MAINPLL_FDBCK);
>> +    writel(vcocalib,
>> +           base_addr + CLKMGR_MAINPLL_VCOCALIB);
>> +    writel(cfg->main_pll_pllc0,
>> +           base_addr + CLKMGR_MAINPLL_PLLC0);
>> +    writel(cfg->main_pll_pllc1,
>> +           base_addr + CLKMGR_MAINPLL_PLLC1);
>> +    writel(cfg->main_pll_nocdiv,
>> +           base_addr + CLKMGR_MAINPLL_NOCDIV);
>> +
>> +    /* setup peripheral PLL dividers */
>> +    /* calculate the vcocalib value */
>> +    mdiv = (cfg->per_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
>> +        CLKMGR_FDBCK_MDIV_MASK;
>> +    refclkdiv = (cfg->per_pll_pllglob >> 
>> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> +             CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> +    mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
>> +    hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
>> +        CLKMGR_HSCNT_CONST;
>> +    vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
>> +           ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
>> +           CLKMGR_VCOCALIB_MSCNT_OFFSET);
>> +
>> +    writel((cfg->per_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
>> +        ~CLKMGR_PLLGLOB_RST_MASK),
>> +        base_addr + CLKMGR_PERPLL_PLLGLOB);
>> +    writel(cfg->per_pll_fdbck,
>> +           base_addr + CLKMGR_PERPLL_FDBCK);
>> +    writel(vcocalib,
>> +           base_addr + CLKMGR_PERPLL_VCOCALIB);
>> +    writel(cfg->per_pll_pllc0,
>> +           base_addr + CLKMGR_PERPLL_PLLC0);
>> +    writel(cfg->per_pll_pllc1,
>> +           base_addr + CLKMGR_PERPLL_PLLC1);
>> +    writel(cfg->per_pll_emacctl,
>> +           base_addr + CLKMGR_PERPLL_EMACCTL);
>> +    writel(cfg->per_pll_gpiodiv,
>> +           base_addr + CLKMGR_PERPLL_GPIODIV);
>> +
>> +    /* Take both PLL out of reset and power up */
>> +    setbits_le32(base_addr + CLKMGR_MAINPLL_PLLGLOB,
>> +             CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
>> +    setbits_le32(base_addr + CLKMGR_PERPLL_PLLGLOB,
>> +             CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
>> +
>> +    wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
>> +              CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
>> +
>> +    /*
>> +     * Dividers for C2 to C9 only init after PLLs are lock. As dividers
>> +     * only take effect upon value change, we shall set a maximum 
>> value as
>> +     * default value.
>> +     */
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_MPUCLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_NOCCLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR2CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR3CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR4CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR5CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR6CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR7CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR8CLK);
>> +    writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR9CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR2CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR3CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR4CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR5CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR6CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR7CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR8CLK);
>> +    writel(0xff, base_addr + CLKMGR_PERPLL_CNTR9CLK);
>> +
>> +    writel(cfg->main_pll_mpuclk,
>> +           base_addr + CLKMGR_MAINPLL_MPUCLK);
>> +    writel(cfg->main_pll_nocclk,
>> +           base_addr + CLKMGR_MAINPLL_NOCCLK);
>> +    writel(cfg->main_pll_cntr2clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR2CLK);
>> +    writel(cfg->main_pll_cntr3clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR3CLK);
>> +    writel(cfg->main_pll_cntr4clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR4CLK);
>> +    writel(cfg->main_pll_cntr5clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR5CLK);
>> +    writel(cfg->main_pll_cntr6clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR6CLK);
>> +    writel(cfg->main_pll_cntr7clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR7CLK);
>> +    writel(cfg->main_pll_cntr8clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR8CLK);
>> +    writel(cfg->main_pll_cntr9clk,
>> +           base_addr + CLKMGR_MAINPLL_CNTR9CLK);
>> +    writel(cfg->per_pll_cntr2clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR2CLK);
>> +    writel(cfg->per_pll_cntr3clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR3CLK);
>> +    writel(cfg->per_pll_cntr4clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR4CLK);
>> +    writel(cfg->per_pll_cntr5clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR5CLK);
>> +    writel(cfg->per_pll_cntr6clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR6CLK);
>> +    writel(cfg->per_pll_cntr7clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR7CLK);
>> +    writel(cfg->per_pll_cntr8clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR8CLK);
>> +    writel(cfg->per_pll_cntr9clk,
>> +           base_addr + CLKMGR_PERPLL_CNTR9CLK);
>> +
>> +    /* Take all PLLs out of bypass */
>> +    clk_write_bypass_mainpll(plat, 0);
>> +    clk_write_bypass_perpll(plat, 0);
>> +
>> +#ifdef COUNTER_FREQUENCY_REAL
>> +    u32 cntfrq = COUNTER_FREQUENCY_REAL;
>> +    u32 counter_freq = 0;
>> +
>> +    /* Update with accurate clock frequency */
>> +    if (current_el() == 3) {
>> +        asm volatile("msr cntfrq_el0, %0" : : "r" (cntfrq) : "memory");
>> +        asm volatile("mrs %0, cntfrq_el0" : "=r" (counter_freq));
>> +        debug("Counter freq = 0x%x\n", counter_freq);
>> +    }
>> +#endif
>> +
>> +    /* clear safe mode / out of boot mode */
>> +    clk_write_ctrl(plat, readl(base_addr + CLKMGR_CTRL) &
>> +              ~(CLKMGR_CTRL_SAFEMODE));
>> +
>> +    /* Now ungate non-hw-managed clocks */
>> +    writel(~0, base_addr + CLKMGR_MAINPLL_EN);
>> +    writel(~0, base_addr + CLKMGR_PERPLL_EN);
>> +
>> +    /* Clear the loss of lock bits (write 1 to clear) */
>> +    writel(CLKMGR_INTER_PERPLLLOST_MASK |
>> +              CLKMGR_INTER_MAINPLLLOST_MASK,
>> +              base_addr + CLKMGR_INTRCLR);
>> +}
>> +
>> +static u64 clk_get_vco_clk_hz(struct socfpga_clk_plat *plat,
>> +                  u32 pllglob_reg, u32 fdbck_reg)
>> +{
>> +     u64 fref, refdiv, mdiv, reg, vco;
>> +
>> +    reg = CM_REG_READL(plat, pllglob_reg);
>> +
>> +    fref = (reg >> CLKMGR_PLLGLOB_VCO_PSRC_OFFSET) &
>> +        CLKMGR_PLLGLOB_VCO_PSRC_MASK;
>> +
>> +    switch (fref) {
>> +    case CLKMGR_VCO_PSRC_EOSC1:
>> +        fref = cm_get_osc_clk_hz();
>> +        break;
>> +    case CLKMGR_VCO_PSRC_INTOSC:
>> +        fref = cm_get_intosc_clk_hz();
>> +        break;
>> +    case CLKMGR_VCO_PSRC_F2S:
>> +        fref = cm_get_fpga_clk_hz();
>> +        break;
>> +    }
>> +
>> +    refdiv = (reg >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
>> +          CLKMGR_PLLGLOB_REFCLKDIV_MASK;
>> +
>> +    reg = CM_REG_READL(plat, fdbck_reg);
>> +    mdiv = (reg >> CLKMGR_FDBCK_MDIV_OFFSET) & CLKMGR_FDBCK_MDIV_MASK;
>> +
>> +    vco = fref / refdiv;
>> +    vco = vco * (CLKMGR_MDIV_CONST + mdiv);
>> +
>> +    return vco;
>> +}
>> +
>> +static u64 clk_get_main_vco_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    return clk_get_vco_clk_hz(plat, CLKMGR_MAINPLL_PLLGLOB,
>> +                 CLKMGR_MAINPLL_FDBCK);
>> +}
>> +
>> +static u64 clk_get_per_vco_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    return clk_get_vco_clk_hz(plat, CLKMGR_PERPLL_PLLGLOB,
>> +                 CLKMGR_PERPLL_FDBCK);
>> +}
>> +
>> +static u32 clk_get_5_1_clk_src(struct socfpga_clk_plat *plat, u64 reg)
>> +{
>> +    u32 clksrc = CM_REG_READL(plat, reg);
>> +
>> +    return (clksrc >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
>> +}
>> +
>> +static u64 clk_get_mpu_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    u64 clock;
>> +    u32 clklsrc = clk_get_5_1_clk_src(plat, CLKMGR_MAINPLL_MPUCLK);
>> +
>> +    switch (clklsrc) {
>> +    case CLKMGR_CLKSRC_MAIN:
>> +        clock = clk_get_main_vco_clk_hz(plat);
>> +        clock /= (CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC0) &
>> +              CLKMGR_PLLC0_DIV_MASK);
>> +        break;
>> +    case CLKMGR_CLKSRC_PER:
>> +        clock = clk_get_per_vco_clk_hz(plat);
>> +        clock /= (CM_REG_READL(plat, CLKMGR_PERPLL_PLLC0) &
>> +              CLKMGR_CLKCNT_MSK);
>> +        break;
>> +    case CLKMGR_CLKSRC_OSC1:
>> +        clock = cm_get_osc_clk_hz();
>> +        break;
>> +    case CLKMGR_CLKSRC_INTOSC:
>> +        clock = cm_get_intosc_clk_hz();
>> +        break;
>> +    case CLKMGR_CLKSRC_FPGA:
>> +        clock = cm_get_fpga_clk_hz();
>> +        break;
>> +    default:
>> +        return 0;
>> +    }
>> +
>> +    clock /= 1 + (CM_REG_READL(plat, CLKMGR_MAINPLL_MPUCLK) &
>> +         CLKMGR_CLKCNT_MSK);
>> +
>> +    return clock;
>> +}
>> +
>> +static u32 clk_get_l3_main_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    u64 clock;
>> +    u32 clklsrc = clk_get_5_1_clk_src(plat, CLKMGR_MAINPLL_NOCCLK);
>> +
>> +    switch (clklsrc) {
>> +    case CLKMGR_CLKSRC_MAIN:
>> +        clock = clk_get_main_vco_clk_hz(plat);
>> +        clock /= (CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC1) &
>> +              CLKMGR_PLLC0_DIV_MASK);
>> +        break;
>> +    case CLKMGR_CLKSRC_PER:
>> +        clock = clk_get_per_vco_clk_hz(plat);
>> +        clock /= (CM_REG_READL(plat, CLKMGR_PERPLL_PLLC1) &
>> +              CLKMGR_CLKCNT_MSK);
>> +        break;
>> +    case CLKMGR_CLKSRC_OSC1:
>> +        clock = cm_get_osc_clk_hz();
>> +        break;
>> +    case CLKMGR_CLKSRC_INTOSC:
>> +        clock = cm_get_intosc_clk_hz();
>> +        break;
>> +    case CLKMGR_CLKSRC_FPGA:
>> +        clock = cm_get_fpga_clk_hz();
>> +        break;
>> +    default:
>> +        return 0;
>> +    }
>> +
>> +    clock /= 1 + (CM_REG_READL(plat, CLKMGR_MAINPLL_NOCCLK) &
>> +         CLKMGR_CLKCNT_MSK);
>> +
>> +    return clock;
>> +}
>> +
>> +static u32 clk_get_sdmmc_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    u32 clock;
>> +    u32 clklsrc = clk_get_5_1_clk_src(plat, CLKMGR_PERPLL_CNTR6CLK);
>> +
>> +    switch (clklsrc) {
>> +    case CLKMGR_CLKSRC_MAIN:
>> +        clock = clk_get_l3_main_clk_hz(plat);
>> +        clock /= 1 + (CM_REG_READL(plat, CLKMGR_MAINPLL_CNTR6CLK) & 
>> CLKMGR_CLKCNT_MSK);
>> +        break;
>> +    case CLKMGR_CLKSRC_PER:
>> +        clock = clk_get_l3_main_clk_hz(plat);
>> +        clock /= 1 + (CM_REG_READL(plat, CLKMGR_PERPLL_CNTR6CLK) & 
>> CLKMGR_CLKCNT_MSK);
>> +        break;
>> +    case CLKMGR_CLKSRC_OSC1:
>> +        clock = cm_get_osc_clk_hz();
>> +        break;
>> +    case CLKMGR_CLKSRC_INTOSC:
>> +        clock = cm_get_intosc_clk_hz();
>> +        break;
>> +    case CLKMGR_CLKSRC_FPGA:
>> +        clock = cm_get_fpga_clk_hz();
>> +        break;
>> +    default:
>> +        return 0;
>> +    }
>> +
>> +    return clock / 4;
>> +}
>> +
>> +static u32 clk_get_l4_sp_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    u64 clock = clk_get_l3_main_clk_hz(plat);
>> +
>> +    clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
>> +              CLKMGR_NOCDIV_L4SPCLK_OFFSET) &
>> +              CLKMGR_CLKCNT_MSK);
>> +
>> +    return clock;
>> +}
>> +
>> +static u32 clk_get_l4_sys_free_clk_hz(struct socfpga_clk_plat *plat)
>> +{
>> +    if (CM_REG_READL(plat, CLKMGR_STAT) & CLKMGR_STAT_BOOTMODE)
>> +        return clk_get_l3_main_clk_hz(plat) / 2;
>> +
>> +    return clk_get_l3_main_clk_hz(plat) / 4;
>> +}
>> +
>> +static ulong socfpga_clk_get_rate(struct clk *clk)
>> +{
>> +    struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
>> +
>> +    switch (clk->id) {
>> +    case STRATIX10_MPU_CLK:
>> +        return clk_get_mpu_clk_hz(plat);
>> +    case STRATIX10_NOC_CLK:
>> +        return clk_get_l3_main_clk_hz(plat);
>> +    case STRATIX10_MAIN_PLL_CLK:
>> +        return clk_get_main_vco_clk_hz(plat);
>> +    case STRATIX10_PERIPH_PLL_CLK:
>> +        return clk_get_per_vco_clk_hz(plat);
>> +    case STRATIX10_OSC1:
>> +        return cm_get_osc_clk_hz();
>> +    case STRATIX10_SDMMC_CLK:
>> +        return clk_get_sdmmc_clk_hz(plat);
>> +    case STRATIX10_L4_SP_CLK:
>> +        return clk_get_l4_sp_clk_hz(plat);
>> +    case STRATIX10_L4_SYS_FREE_CLK:
>> +        return clk_get_l4_sys_free_clk_hz(plat);
> 
> 
> missing STRATIX10_L4_MAIN_CLK(from upstream dts for spi0/1), please 
> check whether is name diff between U-Boot & Linux, or missing.
> 
> 
I will add new case for STRATIX10_L4_MAIN_CLK and its own function to 
retrieve the clock rate in v3.

>> +    default:
>> +        return -ENXIO;
>> +    }
>> +}
>> +
>> +static int bitmask_from_clk_id(struct clk *clk)
>> +{
>> +    struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
>> +
>> +    switch (clk->id) {
>> +    case STRATIX10_MPU_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK;
>> +        break;
>> +    case STRATIX10_L4_MAIN_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
>> +        break;
>> +    case STRATIX10_L4_MP_CLK:
>> +    case STRATIX10_NAND_X_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
>> +        break;
>> +    case STRATIX10_L4_SP_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK;
>> +        break;
>> +    case STRATIX10_CS_AT_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
>> +        break;
>> +    case STRATIX10_CS_TRACE_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
>> +        break;
>> +    case STRATIX10_CS_PDBG_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
>> +        break;
>> +    case STRATIX10_CS_TIMER_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK;
>> +        break;
>> +    case STRATIX10_S2F_USER0_CLK:
>> +        plat->pllgrp = CLKMGR_MAINPLL_EN;
>> +        plat->bitmask = CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK;
>> +        break;
>> +    case STRATIX10_EMAC0_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK;
>> +        break;
>> +    case STRATIX10_EMAC1_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK;
>> +        break;
>> +    case STRATIX10_EMAC2_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK;
>> +        break;
>> +    case STRATIX10_EMAC_PTP_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK;
>> +        break;
>> +    case STRATIX10_GPIO_DB_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK;
>> +        break;
>> +    case STRATIX10_SDMMC_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK;
>> +        break;
>> +    case STRATIX10_S2F_USER1_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK;
>> +        break;
>> +    case STRATIX10_PSI_REF_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK;
>> +        break;
>> +    case STRATIX10_USB_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_USBCLK_MASK;
>> +        break;
>> +    case STRATIX10_SPI_M_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK;
>> +        break;
>> +    case STRATIX10_NAND_CLK:
>> +        plat->pllgrp = CLKMGR_PERPLL_EN;
>> +        plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
>> +        break;
>> +    case STRATIX10_L4_SYS_FREE_CLK:
>> +        return -EOPNOTSUPP;
>> +    default:
>> +        return -ENXIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int socfpga_clk_enable(struct clk *clk)
>> +{
>> +    struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
>> +    uintptr_t base_addr = (uintptr_t)plat->regs;
>> +    int ret;
>> +
>> +    ret = bitmask_from_clk_id(clk);
>> +    if (ret == -EOPNOTSUPP)
>> +        return 0;
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    setbits_le32(base_addr + plat->pllgrp, plat->bitmask);
>> +
>> +    return 0;
>> +}
>> +
>> +static int socfpga_clk_disable(struct clk *clk)
>> +{
>> +    struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
>> +    uintptr_t base_addr = (uintptr_t)plat->regs;
>> +    int ret;
>> +
>> +    ret = bitmask_from_clk_id(clk);
>> +    if (ret == -EOPNOTSUPP)
>> +        return 0;
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    clrbits_le32(base_addr + plat->pllgrp, plat->bitmask);
>> +
>> +    return 0;
>> +}
>> +
>> +static int socfpga_clk_probe(struct udevice *dev)
>> +{
>> +    const struct cm_config *cm_default_cfg = cm_get_default_config();
>> +
>> +    clk_basic_init(dev, cm_default_cfg);
>> +
>> +    return 0;
>> +}
>> +
>> +static int socfpga_clk_of_to_plat(struct udevice *dev)
>> +{
>> +    struct socfpga_clk_plat *plat = dev_get_plat(dev);
>> +    fdt_addr_t addr;
>> +
>> +    addr = dev_read_addr(dev);
>> +    if (addr == FDT_ADDR_T_NONE)
>> +        return -EINVAL;
>> +    plat->regs = (void __iomem *)addr;
>> +
>> +    return 0;
>> +}
>> +
>> +static struct clk_ops socfpga_clk_ops = {
>> +    .enable        = socfpga_clk_enable,
>> +    .disable    = socfpga_clk_disable,
>> +    .get_rate    = socfpga_clk_get_rate,
>> +};
>> +
>> +static const struct udevice_id socfpga_clk_match[] = {
>> +    { .compatible = "intel,stratix10-clkmgr" },
>> +    {}
>> +};
>> +
>> +U_BOOT_DRIVER(socfpga_s10_clk) = {
>> +    .name        = "clk-s10",
>> +    .id        = UCLASS_CLK,
>> +    .of_match    = socfpga_clk_match,
>> +    .ops        = &socfpga_clk_ops,
>> +    .probe        = socfpga_clk_probe,
>> +    .of_to_plat = socfpga_clk_of_to_plat,
>> +    .plat_auto    = sizeof(struct socfpga_clk_plat),
>> +};
>> diff --git a/drivers/clk/altera/clk-s10.h b/drivers/clk/altera/clk-s10.h
>> new file mode 100644
>> index 00000000000..f5be1e68500
>> --- /dev/null
>> +++ b/drivers/clk/altera/clk-s10.h
>> @@ -0,0 +1,202 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
> 
> 
> NEW FILE, but derived from Intel code
> 
> Copyright (C) 2016-2023 Intel Corporation <www.intel.com>  ← must add 
> (code origin)
> 
> 
I will add this in v3.

>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>> + *
>> + */
>> +
>> +#ifndef    _CLK_S10_
>> +#define    _CLK_S10_
>> +
> 
> 
> Best regards,
> 
> Tien Fong
> 

