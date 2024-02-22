Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E353C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 10:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5E48807D;
	Thu, 22 Feb 2024 11:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="veyVzPHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45D988087; Thu, 22 Feb 2024 11:35:15 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B018807B
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 11:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgul1aY6VaZvMdxqMUMWir77Rnxxm23JLSgs3BGk53pMg84XrPX8ZkwVOeiWEsWjzpcGVoP+B4LwOn31iiaxW9HclRtZ1EP6jKL2emGnWhr5yvn/J0j4QJR1OU+rJhp6t1Vc8uCVbHmqr32XKZu6pzAcmQSa0F2hA7LiwPSunKlN7xlTQIvCb6rRZEYjLLi5EZuCHJmT2GDvuVy+V+XVgufyP1wRZX/GGoBqa5JFF8bCeM15DwtrIXWs68bDMaxw7rfUQgPf0+6zv8tfUfIEpROWHLSwQkH9WPwkC/tmHg6zku3brfVoPAaSBl9CTVuXxevvbORFBeqEN8Vz2hcQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAazncpnSzksx1aHkMauWlvbpbbwEEPBaysd/2gn1uA=;
 b=LvuKApWEvo94Q60NVHjYlDRS2UotV4MmjGrwuKZAg5alXCRkhuke/pNq7FT431RCGGXAHsGMjCpt7GMnhi9BKLVyIHx+wOc9+B6HoPkX1Zhi6CSMR7EeinCn82h3RXXpTeku/E5jBr7d/7bKIosHAkCUVqW4RAnEOuL7tDVbYL0A+zZoyTUl+GrorHV8bbF6XzhD0rDGAA6j0yE5GKhOuDhv42C9nTK98qvdmEVFD9/0Ssq16SUzcieF2D4reLsRfQcG8JBhdK8rStmUNW5Qq6RooBNjqo+6czyJbZ8UWqartJ1ZQVtdtjdmHI83oMdpwNZU+x0ygOEGS0L7GO5J+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAazncpnSzksx1aHkMauWlvbpbbwEEPBaysd/2gn1uA=;
 b=veyVzPHesXSEd+JIQqYP1JnLCmTvpv/3w/6WjOEMngAVH9kJSb+JdfgGVlCbIlpGg4Ztu8EwimOCF5qOoa/OzZP6ANr6x4NioiFFKnKUkGTbMV0wqwt45uUES4npDcyyT4g7JssIvSUdFus5cA851DtKLDjphFA++QzinZEaTqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 10:35:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 10:35:08 +0000
Message-ID: <e4913460-077d-41c9-aa9a-c4b2b6f5bfbb@amd.com>
Date: Thu, 22 Feb 2024 11:34:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
 <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
 <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
 <84443f0d-817c-42d8-a70f-f656e6ce79b9@seco.com>
 <769ad987-fdef-4edf-adf8-96f8acee63e3@amd.com>
 <05c38e6d-e9bd-4bf2-a1a1-93ddc5c818c4@seco.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <05c38e6d-e9bd-4bf2-a1a1-93ddc5c818c4@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::6) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4f706e-3cb3-4683-ec04-08dc3391f0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4K61pzCbpjSblylAySh/gamE4hrFQTuwalAkUy8rYtHOIUuf4A+CUuMub6dGndgKl6P1ctldbruYD68pnk1v8fn347wqzmVA6NE3pyrEWQaO//MilfPI1wG3MsRFt8B8gFvndn79SiU+roQKJX8/qHkKrOlsQIQUTpbOy+rlkOuy8wJYq9k/8x8zb+Dd4u/amBcXM1fjXmwPR/wkc8hbg9+td8qRzRcJzKC9bWKL2GmiqZDdvfW6jqnvZx9kSn5Vq2p8f9v1nkxS+91EY8chz3JovSGym5XFcIiH95+q49Yqo49Al/UsGYrpiKlPdJx3jUcnAqtR7/SfFq12P+uRmF1BEb2ombKM9l+oKodNWzed0VvgGvwsgY/y9DYYsFjopUA3SoRP2x3mS8YUxYS8vDiPKyr71UBt4YLW0zNURuHMsyALr3qTH3tzcHLCFVwPOJS3Qe88H8IIfGPr2iUI7AxN+VyBRCmPTzJF0waxHGJOkq2JJHeMzK+0kMar78p74qAlCvknzz60HRAt1iFnPlItuc+5nXtedVbsUTS8XbMyW0qfVf3A8FbPAClhyQr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWE3NG5YYUJUazdBZG5ZZzhPOFlFY1NSZGVVTWhxL0laQ0d0a0xIK3gxVkQ2?=
 =?utf-8?B?cmNucDRoL3NiWVJWYko0S2M3aTlSMXdKb2JOVHRBYUU1UXplcFZZVTFDZk91?=
 =?utf-8?B?aEdwV2pqc3JpTE1jZ292OFZoUlZhV2hCSzdUNlRmWnNVSnhjMjZQZUs1cDhs?=
 =?utf-8?B?d0tqY01XT3hYdG9EMEw4RzdNRTdvR2ZkYzhFQmN5a05kZWN3NmZlVXJuSmpi?=
 =?utf-8?B?OGd1MDNoczMzL05DY1ZHb1ZocDBCWHFiWFUxWGNFTmhhQm52L21Yd1FnSWRK?=
 =?utf-8?B?a0t4QiszenFaTTE5aDJ4OXhFNUlLUVpZNmpOVTc4dUpBR0hhMDEvRGR1emY4?=
 =?utf-8?B?YXNrQ0pCUXFvUW1GbDBFYTB0ZW9PZ0VLR3ZsTHQyKzl4YlZNRE96YjdpTjRV?=
 =?utf-8?B?bGtlWFZ5ekl0YzZSVVd3QjAvdVhNeTdjMXROYmtHdkJSVzZBSmJSSERpclpk?=
 =?utf-8?B?WUorRHpxVUoraWZGbTdaa202OFVhdjc5ajMwdkxJbWt2ZGJqdkxkUGV1STJG?=
 =?utf-8?B?eTVYNWxZRkJZZXZFT2NUVkk1TXV1dXIreHBpaldVcEdEY3kzbFNXL3ZWTVdx?=
 =?utf-8?B?RDlvUFF5dVNDWGRVMUdFOVBNVDFrTEZqYUlpZi9rbSt4R2VxbGxGaDBERE54?=
 =?utf-8?B?OThUR0FMVU1PRHNKSHh4SHY5VTZ3S2RRYTVhcEdLNWdVekZPQUl4dExlUXFF?=
 =?utf-8?B?MXJWK1M2aGcyV0cvOW9IMEcwdk8wMWNMbEpoSDJhVXZlOWVHMW9WZkZ2cmRG?=
 =?utf-8?B?S0wwZkwwbjRJTXA5aGdvLzhxTXRMRHhyQStJNWhGZ014NlpGMFpkaDRuWVJ1?=
 =?utf-8?B?MzNnckkxZ0xvUnlZOXp0RWxBTzdOYzlkdVQzOFB3bW96SldhbzhaamEyMHlj?=
 =?utf-8?B?RVpybUhlY3lXcXdwUXByUzRVVjF4S2ZGckY5TWp4RGVyaDVEV0MvV3lQN1Q3?=
 =?utf-8?B?RE9Bb3BSZ0xLZk1lSFhaaDFmZXNqSWZ2ZElSbWRsWUs0V1ZDRk5NSVY0QXFJ?=
 =?utf-8?B?ZnFKRlM4UkowSVVHQWxOVitRRUc0UUhoaGh3bDB6eW9LcDFpL2p2Y3huaEt2?=
 =?utf-8?B?bnZuQTYrNXpWSUVHVmhYbkgvV0V1bzNEaXhSdkQ2VFkwZGhjQ09MbFZsWVpv?=
 =?utf-8?B?b3RaUU5ZQ2VjamZOcUVFYWVuRGlTakx3UDFvWUduaENDRjJBVlFVN2JlRmVH?=
 =?utf-8?B?YThuSzRSRkhXZDVQUXZaenYvRGFyZFFIZFlFd3FqZ0swNGgySWdTS0NlZWIw?=
 =?utf-8?B?WkFvZ0d3bmV5Sm44ZkNDSittSVh6MkpuMExEQ1JPRnYvZ2lNZ0ludHA0eHpG?=
 =?utf-8?B?bmlBN0VqeE9VclBFUjl2UnBvdVBuM2FzQnRES01vcFZ5bTk0ZmhZUXJsNjBD?=
 =?utf-8?B?a0Qvc05wamVjaFBRQUpBaDIwaW5zT1M1S0FtQTE3NlZVTFFKaEgvSURmbmd2?=
 =?utf-8?B?TnFhMlV3a3JHaFVaTGx0YzVRMTBSZFIyS2FUNGNhMnExai9rZ2l5c2tHU0No?=
 =?utf-8?B?S1hEOURPNzF3NWFWa3lDZXFxTHdIaklrQU9uRnpFNkZBY1JYQ1pTWVZ5dlda?=
 =?utf-8?B?MDZNRHlWTmVIUzlWVVR0SHlZczk2N1pma2ZmS3JHM2ZvM1hSa2hqYlU4YTNS?=
 =?utf-8?B?dkI1WmpYVlRtTW1LYlFQZ2VqeVFLeXJEaHhzSGMwSlZyM25GbVVUU1hFRVY4?=
 =?utf-8?B?QytKTTJZQU5sWmdva0FjTnNjV3M4UjRNVlkxRXRlaTR4bEo1NFArQlBUQ2E4?=
 =?utf-8?B?cXNtV05sSkloQ2lTU3M2Y1d6NXFOREFYejc3K2hoU05rR2psVXhweTZmTFdi?=
 =?utf-8?B?MUxueFlyS0Fwa0pQRUpNczJRTElFbXRuS0VOejdTaDZBVUMycmFnOEtxQWcv?=
 =?utf-8?B?N084bThmaEU5Qm1zc2ZsOW5UNFNvaVcyRitNTS9UUDAvYlBkVUEwQ29UU3BN?=
 =?utf-8?B?N25FT3ovOUpYRWluajlEdURxRXlkSDNYQ3VYZ2MycUFJUVRscERvTXZtVVNv?=
 =?utf-8?B?OEhzVjJuY1loNHdpc21OUHRuNGc3cFhhUG8rbE81eXVGT1o4cGJLMFJETU9x?=
 =?utf-8?B?Zmw2QmRpZFhXSkJXa040OGNCSk5TOTNVUWVHOXl2V0w4aXVzM2VlSUJqKzRV?=
 =?utf-8?Q?dI0DQV0yMRgs2/BmiZzAHlvqh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4f706e-3cb3-4683-ec04-08dc3391f0d1
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:35:08.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UIaXCKPcSpCe6/KDS588+otGzNCA92KUYxhYAGGWup7mHH+ce3p0/1eZa4sSrpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
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



On 2/20/24 20:30, Sean Anderson wrote:
> On 2/20/24 14:18, Michal Simek wrote:
>>
>>
>> On 2/20/24 19:43, Sean Anderson wrote:
>>> On 2/20/24 13:24, Michal Simek wrote:
>>>>
>>>>
>>>> On 2/16/24 17:09, Sean Anderson wrote:
>>>>> On 2/16/24 11:03, Sean Anderson wrote:
>>>>>> On 2/16/24 10:06, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/16/24 14:48, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>>>>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>>>>>>>>> However, this is a bit tricky to time, since the debugger has to wait
>>>>>>>>>>> for SPL to initialize RAM before it can load U-Boot. This can result in
>>>>>>>>>>> long waits, since occasionally initializing RAM (and other things in
>>>>>>>>>>> psu_init) takes a long time to complete and the debugger must wait for
>>>>>>>>>>> this worst case.
>>>>>>>>>>>
>>>>>>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>>>>>>>> debugger when we are ready for the image. This means we don't have to
>>>>>>>>>>> wait any more than necessary. We don't change the default config to
>>>>>>>>>>> ensure we don't break compatibility with existing debuggers that don't
>>>>>>>>>>> expect us to hit semihosting breakpoints.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>>       arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>>>>>>       1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>>>>>       #include <image.h>
>>>>>>>>>>>       #include <init.h>
>>>>>>>>>>>       #include <log.h>
>>>>>>>>>>> +#include <semihosting.h>
>>>>>>>>>>>       #include <spl.h>
>>>>>>>>>>>       #include <linux/delay.h>
>>>>>>>>>>>
>>>>>>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>>>>>>       }
>>>>>>>>>>>       #endif
>>>>>>>>>>>
>>>>>>>>>>> +static u32 jtag_boot_device(void)
>>>>>>>>>>> +{
>>>>>>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>>>       {
>>>>>>>>>>>              spl_boot_list[0] = spl_boot_device();
>>>>>>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>>>              if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>>>>>>>>>>>                      spl_boot_list[1] = BOOT_DEVICE_MMC1;
>>>>>>>>>>>
>>>>>>>>>>> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
>>>>>>>>>>> +       spl_boot_list[2] = jtag_boot_device();
>>>>>>>>>>>       }
>>>>>>>>>>>
>>>>>>>>>>>       u32 spl_boot_device(void)
>>>>>>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>>>>>>
>>>>>>>>>>>              switch (bootmode) {
>>>>>>>>>>>              case JTAG_MODE:
>>>>>>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>>>>>>> +               return jtag_boot_device();
>>>>>>>>>>>       #ifdef CONFIG_SPL_MMC
>>>>>>>>>>>              case SD_MODE1:
>>>>>>>>>>>              case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>>>>>>>
>>>>>>>>>> Good timing. Can you please tell me how to test this? What's the setup?
>>>>>>>>>> Which debugger are you using?
>>>>>>>>>
>>>>>>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2freview.openocd.org%2fc%2fopenocd%2f%2b%2f8133&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f832185958363d84f990a08
>>>>>>>>>
>>>>>>>>
>>>>>>>> I am trying it on the top of the latest git but getting issue with event block and no idea how to fix it.
>>>>>>>>
>>>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
>>>>>>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
>>>>>>>> Licensed under GNU GPL v2
>>>>>>>> For bug reports, read
>>>>>>>>         https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=http%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>>>> Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
>>>>>>>> wrong # args: should be "-event <event-name> <event-body>"
>>>>>>>>
>>>>>>>>
>>>>>>>> Do you know how to fix it?
>>>>>>>
>>>>>>>
>>>>>>> I actually bisect it and found that it is caused by
>>>>>>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>>>>>>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>>>>>>
>>>>>> Interesting. I have been testing with 0.12.
>>>>>>
>>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
>>>>>>
>>>>>> FWIW after installing the udev rules I do not need sudo
>>>>>>
>>>>>>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38)
>>>>>>> Licensed under GNU GPL v2
>>>>>>> For bug reports, read
>>>>>>>        https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=http%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>>> none separate
>>>>>>> Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
>>>>>>> Info : Hardware thread awareness created
>>>>>>> boot_apu
>>>>>>> Info : Listening on port 6666 for tcl connections
>>>>>>> Info : Listening on port 4444 for telnet connections
>>>>>>> Warn : An adapter speed is not selected in the init scripts. OpenOCD will try to run the adapter at very low speed (100 kHz).
>>>>>>> Warn : To remove this warnings and achieve reasonable communication speed with the target, set "adapter speed" or "jtag_rclk" in the init scripts.
>>>>>>> Info : clock speed 100 kHz
>>>>>>> Info : TAP uscale.tap does not have valid IDCODE (idcode=0x48e70126)
>>>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), part: 0x4738, ver: 0x2)
>>>>>>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM Ltd), part: 0xba00, ver: 0x5)
>>>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), part: 0x4738, ver: 0x2)
>>>>>>> Error: JTAG-DP STICKY ERROR
>>>>>>> Error: [uscale.a53.0] Examination failed
>>>>>>> Warn : target uscale.a53.0 examination failed
>>>>>>> Info : [uscale.axi] Examination succeed
>>>>>>> Info : starting gdb server for uscale.a53.0 on 3333
>>>>>>> Info : Listening on port 3333 for gdb connections
>>>>>>> Info : gdb port disabled
>>>>>>>
>>>>>>> but with zcu102 I am still not able to connect because error above.
>>>>>>> The same behavior with recording SOM IDs I see on kv260 (via hs3 cable).
>>>>>>> It looks like that not everything is working for zynqmp.
>>>>>>
>>>>>> Is this with the boot mode set to JTAG? If so, you will not be able to
>>>>>> examine any of the CPUs until you have released them from reset. So you
>>>>>> should be able to run
>>>>>>
>>>>>>            targets uscale.axi
>>>>>>            boot_pmu /path/to/pmu-firmware.bin
>>>>>>            boot_apu /path/to/u-boot-spl.bin
>>>>>>
>>>>>> to boot a CPU. If you want to silence the above error, you can add
>>>>>>
>>>>>>            uscale.a53.0 configure -defer-examine
>>>>>>
>>>>>> to your config. So the full command would be
>>>>>>
>>>>>> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>>>>>>            -f target/xilinx_zynqmp.cfg \
>>>>>>            -c 'uscale.a53.o configure -defer-examine' \
>>>>>>            -c init -c 'targets uscale.axi' \
>>>>>>            -c 'boot_pmu /path/to/pmu-firmware.bin' \
>>>>>>            -c 'boot_apu /path/to/boot.bin'
>>>>>>
>>>>>> Let me know if that works for you.
>>>>>
>>>>> Oh, and I forgot to mention, but if you are testing semihosting then you will need to add
>>>>>
>>>>> -c 'uscale.a53.0 arm semihosting enable'
>>>>>
>>>>> to the end of that. I also find setting the semihosting base directory with
>>>>>
>>>>> -c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'
>>>>>
>>>>> to be helpful.
>>>>>
>>>>> As you can imagine this is a long command line, so I have a config which looks like
>>>>>
>>>>> source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
>>>>> adapter speed 25000
>>>>> source [find target/xilinx_zynqmp.cfg]
>>>>> uscale.a53.0 configure -defer-examine
>>>>>
>>>>> proc boot {imagedir machine} {
>>>>>            targets uscale.axi
>>>>>            boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
>>>>>            boot_apu "${imagedir}/u-boot-spl.bin"
>>>>>            uscale.a53.0 arm semihosting enable
>>>>>            uscale.a53.0 arm semihosting_basedir $imagedir
>>>>> }
>>>>>
>>>>> which I invoke like
>>>>>
>>>>> $ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machine'
>>>>
>>>>
>>>> ok. 0.12.0 version is working better. I am able to load firmware to APU but I was not able to load pmufw. It was saying timeout like this.
>>>>
>>>>> boot_pmu /mnt/disk/som/pmu_obj.bin
>>>> /usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg:173: Error: Timed out waiting for PMU firmware
>>>> in procedure 'boot_pmu'
>>>> in procedure 'resume_pmu' called at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg", line 232
>>>> at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg", line 173
>>>>>
>>>>
>>>> Then I looked at pmu and use below snipset which I use on xsdb to make it visible for debugger and also small waiting time.
>>>>
>>>>
>>>> @@ -141,6 +146,13 @@ add_help_text halt_pmu "Halt the PMU in preparation for loading new firmware.\
>>>>           This should be matched with a call to resume_pmu."
>>>>    proc halt_pmu {} {
>>>>           set axi $::_CHIPNAME.axi
>>>> +
>>>> +       puts "Enable PMU target"
>>>> +       set val [$axi read_memory 0xFFCA0038 32 1]
>>>> +       $axi write_memory 0xFFCA0038 32 [expr {$val | 0x1C0}]
>>>
>>> These should already be set. See table 39-3 in UG1085. Although I seem
>>> to have a combination of 39-2 and 39-3:
>>>
>>>       > targets uscale.axi
>>>       > # BOOT_MODE_USER BOOT_MODE_POR
>>>       > mdw 0xff5e0200 2
>>>       0xff5e0200: 00000000 00000000
>>>       > # jtag_chain_cfg jtag_chain_status jtag_sec jtag_dap_cfg
>>>       > mdw 0xffca0030 4
>>>       0xffca0030: 00000000 00000003 0000003f 000000ff
>>>
>>> Do you see these values in the JTAG boot mode?
>>
>> That 0x1c bit are
>> "Setting these bits disables the security gate for the PMU MDM and allows the PS TAP to connect to the PMU. All bits must be set to 1 for the security gate to be released. (POR reset only)"
>>
>> This is enabled to see PMU microblaze MDM. But I expect microblaze is not supported by OpenOCD but this makes it work for me.
> 
> Yes, I know why you set these bits. But they should all be set already
> (see e.g. my output above). So I am curious if they are not set for you.
> If you have different values for the above registers, then there is
> likely something different about your setup which could also cause your
> below error.

I tried on different zcu102 rev1.0 and I need to have it there.

> 
>>>
>>>> +       sleep 5
>>>
>>> Part of my goal here is to remove "magic" sleeps like this so the boot
>>> process goes faster.
>>
>> I get it. 5s is likely too much and didn't try to minimalize.
>>
>>>
>>>> +       puts "PMU target should be enabled">         set val [$axi read_memory $::IPI_PMU_0_IER 32 1]
>>>>           $axi write_memory $::IPI_PMU_0_IER 32 [expr {$val | $::IPI_PMU_0}]
>>>>
>>>> With that I am able to test your patch but it is kind of slow.
>>>> Max freq I am able to use on zcu102 is 2MHz which is far from 15MHz used by xsdb.
>>>
>>> I have been using the maximum 25 MHz speed without issue.
>>
>> Can you provide more details about board you use?
>> I can switch to different cable or different board but based on
>> your config you are also using digilent smt2 NC module (without USB on it)
>> that's why it is quite scary that I am not able to run it at higher freq.
> 
> It's a custom design based on [1]. The carrier has a smt2 module on it
> which is connected to the ZynqMP via the card edge connector.
> 
> Regarding the clock speed, the datasheet for the smt2 [2] module says
> the maximum speed is 30 MHz, but I use 25 MHz since DS925 says that is
> the maximum speed for the ZynqMP (table 40). Maybe you are using a lower
> VCCINT?
> 
>> I will try different board or different cables.
>> Do you know if standard xilinx cables are supported?
>> This one
>> https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.xilinx.com%2fproducts%2fboards%2dand%2dkits%2fhw%2dusb%2dii%2dg.html&umid=720e2c50-55de-40c4-ac09-1623b19dfef2&auth=d807158c60b7d2502abde8a2fc01f40662980862-1c4afab79eea13f4f1554e802b0609bcea3cc2f7
>> or black version?
> 
> I have not tried those cables (nor do I have them on hand). I have used
> the smt2 as well as the hs3 dongle. I also have a J-LINK, but I do not
> have an adapter cable made.

I have seen it working at 25MHz once but it is not stable with the same digilent 
module.

Anyway please fix typo in subject and rebase it on the top of current master 
branch because it can't be applied and patch is ready to be merged.

Thanks,
Michal
