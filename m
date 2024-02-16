Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2124DC48BC4
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 13:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D0E8780A;
	Fri, 16 Feb 2024 14:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUgcfiUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A762487E1D; Fri, 16 Feb 2024 14:48:22 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9981877EC
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 14:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMTUZTyH1bqn1PTQz3NYBXJhTQLCD3ewopp/gVUZKLAOIkRwZFxjXEuIEn+v8mlB6AYBcnyXGQ64pNL5FSlGEb+KVAUKfLwHwoKvs5iY+xuxSQSc2KVdcsrrn5PdhsF5T8gzWWOBMTDSEqE4cWFR//KjuZ3VEcy2Sls8gYmzmkbqdRBNnx+8n3x+ShPwRD6fsjvzaipaMFS1W4sb2wPJy3wwciVt6d7IUoptY2QWBDr0Mrb2ZErn415s5s8RD2O/mZRZ0NSwSSz0ghWSYEX3z99vBpt2i9P6jaDTUbs/+n88NbCBrPl5Ks18jzfBrYsOUgPB5AjBnsCxsxqS8WLM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EevlCy+0WrCVTzz/Bf0F5yCLyabSY98XwLjGkqS2h04=;
 b=cmx8809cjRkXajZFJ7J3EpKB0d37NE3e4KHuXrNLJLi5EYRWzhFNYjV3/AI+LiKRJbe2YVB1FjmCpvUHFPdI2ekrd7GHrmrgXvZGnyfHFtL/5DjMm6Ubv+bdE+kCOLttG+KtoLvYgUoJJbzPIwLfWR9bDWKyD+zZRowstyww3p7GRxXgIpnRHeGmxBkCDiKpEgdOIZOm1mvhaJND+b0+ImsFnhdEBEk0zBeFML2FilGj7dxtU65DVUx4l+fPr82xRpYaXHHWlxppcQHxcGNg38vSj9ASMZLBoVOxk5z1RtzLd8f28TevLbs8GZCxlk4paOrSpDylLm0+3+/dsZkK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EevlCy+0WrCVTzz/Bf0F5yCLyabSY98XwLjGkqS2h04=;
 b=wUgcfiUiyj8wAdfDl1YfvzJCauEO9hbyb55d/VT7JOVJ/7gJHao1g/yGwrYuRrRLENf4HHyt9l93/+xIM3CUuNUZDjKkPjBeT7WgVyu8ixxmaTu24dJeoCdbAzT8Z37TTsyOD4F6yWYz5+7mGCVJBzvUZq9cuD1F8FxHLTj87PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 13:48:13 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 13:48:13 +0000
Message-ID: <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
Date: Fri, 16 Feb 2024 14:48:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::20) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a4b0de-ca27-46b3-4418-08dc2ef5eb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45L55vmzBP/dK3KVocRKJr2glnbxvZAaxENS8jfJieq1ziY/GPPvgQoY6MQdUXI59H6XQku8NRsNkw8fmgkDUd/Y1v3ubg6z2cmJQ8NUIhQRt0GPPlHOHP5v1eMQen6OEAesf3Kw3JqtCpYBVrTc1lljX95Ey5c0gdw9SrU+4PBScVigTb0VKVbta+OzII0tDTFs/+wUlwXQh1U2y/dAIVdh5+sUnJqYNIHDPDdr475AjnSk9Z4LdnbIXZHDnvb4+LB2tuWlNvRcIw8sEf4kKsQ1ccHNuXqPOlUiJEYFUtSqY5qQT5jfI51HfIrElSwa9b5wSSrA6lM1FGJ74SrmYwb3Hx/bDymebCA6vGSidhjy1I6s2dkVmGxzDTgpvgFMkELP4fpcJDbmHUNv/ew/AAzyyd1ThM7m+nXngBrR7FCN4OLe9FiZ5qA7QWk1JbU0a+dnNOaI2DL6FqEYzAFSo2OvWR2+dNAFxXyzYwF8MJgc1j+wVea6PFqLyYzZ68NIcgV1BnyJMdNqiyKq5cCmP9A3vttBBuAfIgg//xmf5ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(38100700002)(83380400001)(53546011)(26005)(6506007)(2616005)(6666004)(36756003)(478600001)(6486002)(966005)(19273905006)(44832011)(6512007)(8936002)(31696002)(5660300002)(86362001)(8676002)(316002)(66476007)(66556008)(66946007)(31686004)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZyUlpIQjNPRjY3NndIaFNvQUpyWmpMOGhoeEpsWE53SnJreWFOTDVoRmRZ?=
 =?utf-8?B?alRYa0JOK2lZaXZPVFhnNGY2TmNOMFdkekVqenB6c1RJbk0vV2J5b2t4UFpt?=
 =?utf-8?B?b1o0SXIrcXZTd0hMaGNuUC91MjgvZDIvOVdydEJYNWR4cEwwYjkxNUJGem5r?=
 =?utf-8?B?M2NsRXU2N3d1Y2JQQmFMVVpNYXVGRUd2MlRWM3dDWWRLQXJobEMxV25aQlJC?=
 =?utf-8?B?OEtjVlZSa2dhdEtadFlJZHQ0U0l6SlZOcmZLRmpsOU9uVHQ5WFFJL29iYzBl?=
 =?utf-8?B?RG9tS1VsZHRBWVUrUE45dmsyemUwN2dzYnpyWG5QWWY0NFMxbmF4bE1meEpq?=
 =?utf-8?B?U21FSFdzTHpxVjBDcjYreUpkc0lvb2xGSFJzVTlaWUlHc0JWckpsNVZYUnIr?=
 =?utf-8?B?NFVkLzFuOWsxRUkzWVMwZ01qT0lrMXJKd1JZNlZZM3VjckRub01ZeXpjN1ZE?=
 =?utf-8?B?bnhrcDExNjFxK1hGejJaaE9pc0FjeERuU0RlSFQyRVlNQmFTNHowV0c4djYy?=
 =?utf-8?B?Wm5sMGdxa1ZtTEMwTExRZUFCZG1idk5tcUxTbmVnNnJtaytNOWF6S1UwZ0p0?=
 =?utf-8?B?aHRnYkF2akRteVFRL2dheDlkOTd5NSt2eEFsVzhCaXdvbzFpRlEvZTByYXdF?=
 =?utf-8?B?YS9HZ1JTQlJWdHQrNHNGZlNrU09kMHVDUVEzN1YyK254RjJnTFJ5NThYVUg4?=
 =?utf-8?B?TWdXcjJKdjhyd3RLeXZ4VEtrRUx4TkVVN0F2cVczNnNnd3haSmxVdTZML0lC?=
 =?utf-8?B?aFExWkQzb0xYZjhTVytpTFdnTktpa3NZZlJsYVJiNWtNaklmTFZBcXllajg1?=
 =?utf-8?B?SndiYmtMUmFiM0dRdzRCcUxWck5Yc2dTR1g0SFByNjV2L3Exa3JRSzM4NkRz?=
 =?utf-8?B?eWJ1MUlTTVgrQjNpR0FoRW5za1dDRnJyYW9JZ2xvMkRwdzNLM1I3WXdlL3E5?=
 =?utf-8?B?UWdEQnREWGVZZFRrZXFQOUZvaHhRN0JQSE1BMUt5NE9MZ2Yrd2dsUWVKcXZS?=
 =?utf-8?B?MlprZmNhVkNMcTNMS3doNnFUaXJ1Rkx1bGdXdC9wTEFielZZbi9aekpVSDJO?=
 =?utf-8?B?N2xBS0tYdE1nUnFQQmFUZUx1WlhSMGFVTW9jU3liRTlFMkRIaElDZVQ4S0VZ?=
 =?utf-8?B?N29YUHhFNWFxeWxsdEprOXZQbGc0KzZ0b3UrKzd0b0RRUFpQTE4rRVRqOVRK?=
 =?utf-8?B?a3cxOUVQc0xQUDlQQ3NlMFZFcm5FYjgvaWhoZ0RTd2dNMTlDTGVub0RLRE56?=
 =?utf-8?B?MEoxc3J6WFNnMENSNVBmaWx6eCsrV012ckIzU0VOaFp5Ty9NQkFmdWRqeEJk?=
 =?utf-8?B?K0NwRk8zSEtEVkFIRFJob0NJM1BvRXZPeXZVZEJSbUR1NHFVVFJGRXE4MGZS?=
 =?utf-8?B?S1FFc3ZtMEYvQ3JTazFzSzJsZy9yYithNVhwb2ZzQlpoeUk2cGRQcDJLY0Z4?=
 =?utf-8?B?RFk2QVVPeERsbW9GMnNlMGJNanJoSGxkYkFqQ3h0aFlHMXRIMjRGZjlrdUU0?=
 =?utf-8?B?L2g1VUJLeG8zenYzc2NZTFVsaGZzUlRlRWRWR3NhM3F5K0d6RDBIcExoRmts?=
 =?utf-8?B?NUFwTXZiRVhna3dvblNRdXVOME81NStZZjhTYkxQMzY5dzB1cDM3ei8vU2JC?=
 =?utf-8?B?VFgxOGdmdWRXeWJWbUJJMzcyS0c5U1VnS2lrMk1yQmo0NnN2WVlLbWJPaDJT?=
 =?utf-8?B?TFAwemNZS0p0bldJdDVEamFpaGpDeEp1N1ZKbmM1eXFQQy84dGJCQlVhbFhP?=
 =?utf-8?B?RWdNNzQxditHNFN5MFpJcHRsSkdIVU9nN1pOV2dqdk16REdNeGhpMzlBRW9P?=
 =?utf-8?B?b3B6QlNtTm5nS1JSYmlWemhMaDZkSmlFSU9oMnYwdlJyeHVBdjNOV25Dc3Bn?=
 =?utf-8?B?M3JVZXhVaFNDc3A5dVcrT1Jla2wrQUFVWlAvTTRBVmlGL3FVbXJNemhoYThC?=
 =?utf-8?B?N3hQS0JFa01ybXVkL1dmSEVzbVYwb3g1eXBZTlFtSnVCQmVkTXNadmoveUc0?=
 =?utf-8?B?b1FvTmp2dTI0TjBUL0U4cm1sTytmc0pNNDRmU1pCWGlFNXgycm1pSC9vNXBD?=
 =?utf-8?B?Q1V2dkxlZ2JlN2U0VTE3bnRXWnNRckRLdWpPcGIzeC9lM3Z2TGd3Wmh1VTVx?=
 =?utf-8?Q?QA+cUbM+ERnuin5pHnfI7hH2U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a4b0de-ca27-46b3-4418-08dc2ef5eb6c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:48:13.2742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOtd9OcPO8zPGb3UcWeHn4HeNZDGjw3wk6+ti7m81jElsBEOluDU+1e+gRUFQVce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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



On 2/15/24 20:31, Sean Anderson wrote:
> On 2/15/24 14:08, Michal Simek wrote:
>>
>>
>> On 2/15/24 18:19, Sean Anderson wrote:
>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>> However, this is a bit tricky to time, since the debugger has to wait
>>> for SPL to initialize RAM before it can load U-Boot. This can result in
>>> long waits, since occasionally initializing RAM (and other things in
>>> psu_init) takes a long time to complete and the debugger must wait for
>>> this worst case.
>>>
>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>> debugger when we are ready for the image. This means we don't have to
>>> wait any more than necessary. We don't change the default config to
>>> ensure we don't break compatibility with existing debuggers that don't
>>> expect us to hit semihosting breakpoints.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>>
>>>    arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>> index a0f35f36faa..5af735aa5ce 100644
>>> --- a/arch/arm/mach-zynqmp/spl.c
>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>> @@ -9,6 +9,7 @@
>>>    #include <image.h>
>>>    #include <init.h>
>>>    #include <log.h>
>>> +#include <semihosting.h>
>>>    #include <spl.h>
>>>    #include <linux/delay.h>
>>>
>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>    }
>>>    #endif
>>>
>>> +static u32 jtag_boot_device(void)
>>> +{
>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
>>> +}
>>> +
>>>    void board_boot_order(u32 *spl_boot_list)
>>>    {
>>>           spl_boot_list[0] = spl_boot_device();
>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>           if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>>>                   spl_boot_list[1] = BOOT_DEVICE_MMC1;
>>>
>>> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
>>> +       spl_boot_list[2] = jtag_boot_device();
>>>    }
>>>
>>>    u32 spl_boot_device(void)
>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>
>>>           switch (bootmode) {
>>>           case JTAG_MODE:
>>> -               return BOOT_DEVICE_RAM;
>>> +               return jtag_boot_device();
>>>    #ifdef CONFIG_SPL_MMC
>>>           case SD_MODE1:
>>>           case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>
>> Good timing. Can you please tell me how to test this? What's the setup?
>> Which debugger are you using?
> 
> I am using OpenOCD with the patches at https://review.openocd.org/c/openocd/+/8133
> 

I am trying it on the top of the latest git but getting issue with event block 
and no idea how to fix it.

# sudo openocd -f 
/usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_hs3.cfg -f 
/usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.org/doc/doxygen/bugs.html
Info : auto-selecting first available session transport "jtag". To override use 
'transport select <transport>'.
wrong # args: should be "-event <event-name> <event-body>"


Do you know how to fix it?

Thanks,
Michal

