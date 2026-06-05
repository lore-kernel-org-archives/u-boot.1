Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB3FCD6E5D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0718486D;
	Fri,  5 Jun 2026 10:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7S+SRZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5ECA84874; Fri,  5 Jun 2026 10:50:22 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043D18484F
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBB0yDwUGpLc4kOxbNyoLH3N73MsVTauH2REm+WlR0hInjdzelMfbgz0QuKbUYO+lWp2m3n3tL+K5UvtJUAKa78hngTW3n4u0eX57Ezi1n2fTj8/3lJlYpDABXxE942ilqrNS8pqnLefxrv9bwHvENXmL6+uO+KKxxID1Z8t0UhYTjcvtKpzs1nVkIPZjsVSeUjpNNEtDve96iSyfRUSVQyaWETfKE3JZ7mjib7aCOcIuZ7Ryy5HZfmfBSVy9C2Mc+RuWMZ4Lo4Os/sOJT+IxpO0ioX0lNWfp8xyNIgdNRkbvVfdAC82s6jkuiULIUjtKDqJBbI1UAWpg7i8AH4IrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugU93bg8yFL5Pvr8pOQ8jUMboSYF+9B4h4cWWlsnE0I=;
 b=HfbEyHUbddyB673rIva0iVfJxCumTGyEOrDQyfV6QMUoSLIlGQElOHOPuj9lZl0ymE5Pmhjk2LloOXLMKPTBY69Vs6jJIhE43ddW92IAEvqydL41Tke7Zn0MNCZm1rXoQMqbN1O+PFbQdS77gNZ307/GRwmsH9IIb5kijSc4VYr1qhn/COrRvZRf0Ps2K4pO7d3kHtckUaQlTDxgG7srERsu2RBiG6sMykdYCqHMuJXjpSorwV5JCQQ6fJPBb6WYsKbxbCXFF+0GE9Ur/5s8bnyfsNXB15r/MhS7QDEyHzDKDqY71YJ/xNF44ujN+dIgfie9295BGI8ekHqFd85BYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugU93bg8yFL5Pvr8pOQ8jUMboSYF+9B4h4cWWlsnE0I=;
 b=E7S+SRZrMm8Iu/QrTMdaYWdRHRMkge6lER/obcAVILOBx4TAD13OJ8tknf1JaTKE09UBkaUZ6WXKoF32HW1K7M5SZBTDYL//WkC78kqq3eZ5Cky/HKyreyU2rhKEkHjLODIUewYTlySRvxDAYso/orrrH2YDnnuTKhywMB7GX2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 08:50:16 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:50:16 +0000
Message-ID: <0ca48558-9504-4693-96f8-94dc0ea35d48@amd.com>
Date: Fri, 5 Jun 2026 10:50:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: mkimage: allow zynqmp to use a register initialization file
To: Sean Anderson <seanga2@gmail.com>,
 "Erich E. Hoover" <erich.e.hoover@gmail.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
 <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
 <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
 <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
 <CAEU2+vrTq-3Xy5MwHAJZ_zjx7bdM1qih=3Tmkp_u758WcXf+YA@mail.gmail.com>
 <1cd5b625-89c5-73cf-93a2-654af3906f60@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <1cd5b625-89c5-73cf-93a2-654af3906f60@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: d6567da7-2780-4a86-3de8-08dec2df76d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: wF320NJSoKEjWFUQaPtcEn3mM6OdFRYPGd5GtUxBRjOEPzuvnz/UXrG4YCnPiZfnZV6Sh/wstqJqFordX7X1bYp5qcS4UbA1GlFrFFnfsQcbfQj2XQBx+7wTRNv2mcVSt3utlcWxnXbvIdYWqtlanxjMUCJ7PASpTmGcXKtbbIR6paNgScKmFjZCdTANkMfPVURde5ZuPwUe0dc8VxWpS/ia5Xb18Q+ZZPviFfxyGv86NXIKZiINiasOsuL++lpcJjd7unnSzK0mkWrLg7OD2s2kmC/t/NSTT3feYiVZCG3F66SPJwGajeRTDvPgge4w1iu0PGwflnPdltjNYq5C7EkyxF63PqkYQyMzzqwzoqeNNGZqgP/uYcr8b3WDyT9oKXUWbkJtryBjYTeoOfZG8vR6XRoDXM/yYyzMhRjNf+lDWPEsfd5WVEK2xtkV0QB45xNK6WIP7hxM34WAllq6JREQOof9jj/x5ndMcj/6N5XGjNCiSMRsfKRFbmBpNENING/sXYLHjd2l644FAQ3SNVmk97GztjYRmrRtrJSr/MCpSXITduzr4k6BEvFKMxG1ygj0/RK7wG5IZIKPfMr6pxB4zTB3m9Nq2omf86yJQUD5W+Vcixh0tOvstLCPBgPJKulrBYo1VVHb1azsZMTCfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxvRDF0ODF4Z0tiVnN2cXo5TkM0N2FsenZJOVBoUWJxOEtlU3RaNHRVRGho?=
 =?utf-8?B?NEpPTEY0K1c5Y01DMDBmYzJkZHM0VHJLTmtrSFR1em9ZeWRzdmh3N2JQZGpn?=
 =?utf-8?B?TjNDV1FuaUQwZ0ErVXpXc2o5SkNRaFJzL0JiRzVwREZLTWV2OGR3eHJHdDF3?=
 =?utf-8?B?aEVxVEFwVXpuV0hyR3hxOFJpU3hxNlNrYXBHM1dBcmtFMXl2a1A5TW5MbHM0?=
 =?utf-8?B?aWZvaEN6Q0M1Wjd2NDFmNktmWFJJVUNVWjMxaWh5L292Mmh0L3hLcGhiM2d3?=
 =?utf-8?B?UXJLOTR4L0tZaUxWc0RmTEVpMm03S0R2QW92MzV4V2lLRXFKTklHdlJ4NWlr?=
 =?utf-8?B?R0QwS3JsK1VQbm1zbUZJUmZDeXhZY2NhU2VkakIzd0lybDNGOUo3TjNHVWJE?=
 =?utf-8?B?L3BIVTJpQWJMSldIc1dLRmhudW5rZFpVTUlCUVpRSTdVN0c2bmcwN28zdDBn?=
 =?utf-8?B?czBpUVZLS0FkM2Q2L2R0TDBwZHFiUFZhZjJPbXE1TTVIdjArcksrNTMzMyt3?=
 =?utf-8?B?YUFXNHpON0Q2MXlKcVIxc1F4RmVIK3RiMGhYVTRzak10U0t4R0dSeGV2UkZE?=
 =?utf-8?B?bGdFdnpsQ0UrTGd2aXk4dzNCMVVsbWtGczdtNTZWdmhpQmtjaVlMaEp4ZWVM?=
 =?utf-8?B?bCs0Q3VJeTRDcVo5NlN0VGpGME9MUXlPeWdNdlU2NEpZTVFuUDVSSzFaOFlR?=
 =?utf-8?B?YmNPaEdveEZ1TGhGUWw0U2lPMUNEVkQ4dGtzaVpoSEpMRjJQald0bU80bHBt?=
 =?utf-8?B?ajZhb29LLzgySFIwMEVsZ3ZPb0d2RWFSNFBTWE5KVXZRWis1djlBcVNJbGln?=
 =?utf-8?B?Z0ZFejd3c3l2d09uR29OOEpDOU85R3RrOS94Tmh0QUFZbURoUTV3end0czEw?=
 =?utf-8?B?UzZ5WHk1eGdxcDVJMDhJSHpGZGtLZW0raUxYMDh4Y1Fmc2lMY1FnblZwQzBu?=
 =?utf-8?B?SFFGU3g4MXlDMkt0dGVQRzJ1SndzNzZHazhCeVpPcEk0SXBvb2ZUbXBrQjZY?=
 =?utf-8?B?Q0tkdk9sandaRzhPY3VrUk1SbXNMS2hpQTdzT1VKMWltYlRiWHVTUnA2cld0?=
 =?utf-8?B?Z0h6WWxKTDd1eWcrTVlSZ2w0cnNTZGQyU3IwYStIM2MxVmw0dit0MXMwQ0Vi?=
 =?utf-8?B?VkhIOC9ES2JWVjRkUDgzTW9DK3pLU0Jka295NUtvZXV2N21HWWtNRE9hS0Ix?=
 =?utf-8?B?Ynh2NXhMZndHMzhnTXc0ZlJCQ25Pa1k2d2dtVXpTbXBtMTRHRTZxem1OQW8r?=
 =?utf-8?B?Rkxub04vdmM3NGY2NjJWNFZ3bXpUQndxR0JjUEdaTjUrM1FwSW9mK0k3RXR2?=
 =?utf-8?B?M2VHSFpQMnVmWFJFbjdrZTdtUVZxV1JaQk95YUNuL2IvRHBJbHAyTWFYcURO?=
 =?utf-8?B?dElIQ1lsdkxJL0FQRUk5b21vcnkvQVhrKzN2bWthbTBZNDJuWFVrS2ZJMHNu?=
 =?utf-8?B?SzhLWmlXRjVNUDVRQ2lVdnFGVVl4WlFRUWlEZ2FqRzd3ZjNzWU5rZGhEbGRF?=
 =?utf-8?B?Q0UyODhGMno2TUFTMkJYUVRFYnVoWS9jbTcyK2NJcXhyYVdtWDk4Nm9iaGJE?=
 =?utf-8?B?RXBISEhFd0o0TUVyclhxRTlxZnBQdGhzSjJGaVgrdG9wUjdybFQwdzZleXNk?=
 =?utf-8?B?cmtpZ3lNdEtxVVJ3dWN3MzAraER0QU9vQXI3cmhVdEtSejYyZ1ZJSTV3bGsx?=
 =?utf-8?B?YTZBQjlxNEpFVjYzTEt6VWRhU0RnMzIyczF5TnBiTlVEanU3RDA1eFA0MnY3?=
 =?utf-8?B?R3ZmSHVrRmV0V0RmaGRpa0ZaRzZieUZZbTNpUC8ycWduU0h5eTJKbm1VcFJY?=
 =?utf-8?B?Tmh3aUNqdGdZb1hPL2t1bFNBak1ORlpiOFVUM1ZGQUFtRzFjZHVIbGgwRldP?=
 =?utf-8?B?MDB3MldGUU1EdmMxMzJaRDQwdTdvbHY3enA2WjFxNzl6aEpqQW1XaGwrMmFR?=
 =?utf-8?B?RnZ2QWVFWXFwUFJMaVVFa2MxME1iM2UydldwNjB5WVduOFhEV0tlR214Q3hy?=
 =?utf-8?B?QmU2ajRJUnVWNEZWcXJPWEk3Mk92NS94RXVJTkZEY214RTQrZUlsRVJpYnlK?=
 =?utf-8?B?ZzdZa0w0SFVRbktPM3p0eUg5anU4WUl1eEVzTTN3TktjZkMzd0twVjgxVWx3?=
 =?utf-8?B?YzIxSE85RTN4ZVY1OHVGS2Q4cEo0RzZ4K2xGS0toZXJKMU94SzFXN1JPNHV3?=
 =?utf-8?B?cjF0U2NFa09oM012L2o2Z0o2YThERnZyL3FONytlMjRkVjZVaDNkYTBMNkxn?=
 =?utf-8?B?Sko0RmpSUks5TzVCcGhBUldJQzQxWWV4NGUydHpJK1B6Wml0WFk1OWJxV2NK?=
 =?utf-8?B?Rk1kMEpUdENDOGhES2FFWGpmajNsVUFRUTlQSlM1L2MrT0kvY21hQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6567da7-2780-4a86-3de8-08dec2df76d2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:50:16.1575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/sCr8yKcPdehspReHO8+bKSVBFa5txsiHcwc3YqpnG87qzSUfjjPd12Vrfo/QwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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



On 6/3/26 19:51, Sean Anderson wrote:
> On 6/3/26 13:45, Erich E. Hoover wrote:
>> On Wed, Jun 3, 2026 at 11:34 AM Sean Anderson <seanga2@gmail.com> wrote:
>>> On 6/3/26 12:25, Erich E. Hoover wrote:
>>>> ...
>>>> Yes, sort of, if you are using "zynqmpimage" instead of "zynqmpbif"
>>>
>>> I've never seen the point of BIFs; I've been able to do everything I
>>> want with zynqmpimage.
>>
>> My understanding is that "zynqmpimage" only works if you have one
>> "partition", so if you're passing the ATF or other partition data I
>> think that you have to use "zynqmpbif".
>>
> 
> I used ATF, but this was with SPL. So the boot process went something like
> 
> Boot ROM loads zynqmpimage
> - PMU firmware to PMU RAM
> - U-Boot SPL to OCRAM
> 
> U-Boot SPL loads FIT
> - ATF to OCRAM
> - U-Boot/DTB to DDR
> - Bitstream to PL
> 
> And ATF was configured to jump to DDR after initializing.
> 
> I guess if you are using FSBL that doesn't work, but IMO FSBL is yet another
> incompatible bootloader to maintain. I'd rather have a shared codebase
> (SPL/U-Boot).
> 
>>> But this info would be good to put in the commit message.
>>
>> How's this sound?:
>> ===
>> The ZynqMP Boot Image Format allows specifying the register
>> initialization file with the "[init]" attribute.  Since this
>> feature is already supported by the "zynqmpimage" backend, this
>> commit implements a binding to that existing support.
>> ===
>> ( https://lists.denx.de/pipermail/u-boot/2026-June/620814.html )
>> Please accept my apologies again for messing that up the first time around.
> 
> Actually, I liked how you explained it in your previous email
> 
> If you are using "zynqmpimage" instead of "zynqmpbif"
> then you can add the register initialization with -R. This patch
> leverages that existing capability to add support for the "[init]"
> attribute in the zynqmpbif backend:
> https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/init
> 
> We are using this feature, in combination with other zynqmpbif options, like so:
> ===
> image : {
>          [init] fsbl.int
>          [bootloader] fsbl.elf
>          [pmufw_image] pmufw.elf
>          [destination_cpu=none] fsbl.tcl
>          [destination_cpu=a53-0, exception_level=el-3] bl31.elf
>          [destination_cpu=a53-0, exception_level=el-2, load=0x08000000,
> startup=0x08000000] u-boot.bin
> }
> ===

I am reading it as request for v2 with updated commit message. That's why please 
send v2 with it.

Thanks,
Michal

