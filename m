Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96D9C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 08:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2ACD87E2B;
	Fri,  9 Feb 2024 09:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vh+6sac7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8926087E39; Fri,  9 Feb 2024 09:18:38 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FDA8709C
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 09:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIUF5hTqRzI/Q3btbpzXW1D1nt3Cf3+rlcquElyCsiSHgdYOjKgCNaTpum1RZwKwC022i7QHjfLOP2sNbhbyjbOg3V/XHzMWlUFRflHoGr0vAJvL1uI/kDIYi2Ek6zAId/gW1hyl1xUQCTsEC9C01Hc04T+zRWhOlFxBKdnuoq8MEL7sSS8G2ZD5lOJdsMZkznjojMKYFFK36cEZOkWRemmkmyfK1qWraGBKT5BeY7r+1sPtor9K3AjZQ1p9CpRzn2PWmsQddLT4SMeu0+iu0YeO4rAWbxa3PVp46HH/L8OsnlV5nRkRhnUlU0kZpmkxYPWJghjH920+KhaGnPldDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BApvDuY7Bu75sJAilAiS+fRAoAlC35WQOuqzh1BD/jg=;
 b=DXQr72OF+YCcVwp3JzxI+vS2lyYdKZ20tte+AzXZRPfLoEW77Kr13gUwxstWMx1ijKjDJ2NQVOxufEidfIwK9+4F6a4FuNS8/JbqfkBQxygkCnUJctF4xBE/9NAhch/xIZHiGZUR/xaeHgM9/oA71m398fu+Nuw9WmABO5x1hnki3s9sH2ZqAOanrcouaaCe7QsOTdSu25lgSYO8wJWTizeiQpgeUDWgFGox5UeVaAwcQKOM11eCVngdfv1MnDydWg6+T7pep2+KDD+qmqhDUu4Pi/RckC7/LLhTptW+VQQ5L4sVBZIsVbHPushpprXQ5M4QNJJuOUAf3CNB7NOmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BApvDuY7Bu75sJAilAiS+fRAoAlC35WQOuqzh1BD/jg=;
 b=vh+6sac7VSj6jOerF3Xru7YRXuQMdoRSu5gS7cHDBGxTPnjfZe0+fVdBkgGJTMTDVBs4cSX4XFxW5bRXbssMKOmVNX8/ewnzlM42tMpuvmUKwjZvgVDohc8ZXLXkFKr5RxNPmCPTuShARbZm//y1GRQGS3tvIDYpJBmqF+MXJLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 08:18:32 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 08:18:32 +0000
Message-ID: <64578f39-fea5-44c1-ae9e-e60c133210b6@amd.com>
Date: Fri, 9 Feb 2024 09:18:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Add the missing function prototype
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240207083328.1673752-1-venkatesh.abbarapu@amd.com>
 <d899a443-4e51-490b-be18-7bd1b58efd0e@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <d899a443-4e51-490b-be18-7bd1b58efd0e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: cd65c462-4af3-45a2-172e-08dc2947b44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fGFMSWaH0olumlo7XzwFONBMIZOQsR4hMhJjkk4TDEOeZBiRvluz5b0GtCppzlbA2Gr8v7wqJkEF2xneFWCyxUiGhj1m85TSH2YwUuvN6ioIlj8YbWBNrJJYxOB4zqz3JzsQT9EeEq+CVsRNIF3kE4XU5O64xf2APujBYarzZc3IkyEWR4KQGRahNM8Q3Snn0W8J9s0pw3YXXVJTTzcttmjvKbKYwv3hKpBiiPob4n9m1qY5ObPeY+bgSkGNd7cGROotwFYgfEyO9lX21jlglPV/3UDdZ5Q69ZRxFpX3REJ3wLnH7MB9JykYbYngBsOXxMNZ3iK7aJWALhrlhfzGAeahR4IQ41wavtmWH+cED7gTxLB81LVaS8yVgbHlb9yrW01ojZ2KNLVplDfm8gZBv0KYBOMroUmNsL5rJKDTCdZRLlfU6rdGcdrtswCMHCrF07KcKsn3X4PEUWAjGzBjA9M1ebYrNJcKwf4rNJnUVQJvly1/EIVTB8af7zbf3zFhUV9K5uW62/CL3pjh5dvbqkYyXoIAF/JxgOU5zvx90YtePYHu2AQ4SRGVoFQLcJ3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(26005)(2616005)(6512007)(6666004)(4744005)(44832011)(83380400001)(2906002)(478600001)(6486002)(5660300002)(66556008)(316002)(8676002)(4326008)(8936002)(66946007)(66476007)(36756003)(31696002)(38100700002)(86362001)(6506007)(31686004)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0w4bkZLcXJUZmdVc3NITk5wbmNaQnh3WGxmTXhkeENGakxEWTVwUTQ3T1p0?=
 =?utf-8?B?OHJubm1lMFlQUmR3T2N1Wms5M1BnbjJvVjRxUFFZQnFzeFhVR0FaMmVTVnN6?=
 =?utf-8?B?bVlwRTBVZ09VYTZzVVh6Q1Y1ZUw3M0xqdkJ4R0FXWEg4Q3dpcTFhc2tINnh4?=
 =?utf-8?B?bjkwV2Fwc0JNdTNuMWFMMkt6TDlaajNvSmVWakFXTHBlN1JQMHJ3dmw0UE9S?=
 =?utf-8?B?d1RnaytNdGhpNXN6aEFEOEluRXlVeThFbFpKdUJJOUdocWVsQk5WM1l5dzQz?=
 =?utf-8?B?WlFCQ3FQSXk1c3dYQytrQnpJeVVoNzRaUjFyRWx4aHFZWmhtZEpITTRyOVdo?=
 =?utf-8?B?clNXdjFWc210UFRBNXNsck54VkxyT1RFeUR2OFdHMm9DQ0lJMkx5WnR6TEgr?=
 =?utf-8?B?OEtUTFJwNVNXWHZ1b2hPY1lIYk1MaUpDNGpkYWM5U2U0RFFWRlc4UllBbDFs?=
 =?utf-8?B?SXBpa00xNnFkMDI5Y2xmbzF6RmdWNUlvM3JGYzhscG5XMmNtOUdtc2VFMVhE?=
 =?utf-8?B?blpCWTZOSEdPSlJ3QzYyTm52UWUwbXRaMllnTGJzWHY1dG84VTFaRlNHb0t2?=
 =?utf-8?B?bkcvMUpJQU1XcThQdk54dzZ0TGpXci80VXpzUFFLbXlsU1BZR1lMdGkxYWZN?=
 =?utf-8?B?VWhjWVYyYUs0aUszQTcxY0ZGb09QT3RrblIycFVLM0dLZWVKYTNKZHFRUUZ4?=
 =?utf-8?B?VExYMXU5bTFCZHNNMEkyL2RtOE5McGtqUkpmQlc1OWxMeXIxQ1lSNDlWZDlC?=
 =?utf-8?B?Y0VkVFMvUDlqY0dQZm5ZT2p0c0o4eDYrdFdqTU9MUFJqdENXZGkwTWhDQlNk?=
 =?utf-8?B?ZWNreDA1aVR6K2ZOVjdFWkdCYTBYZkJKYVJJOVFPRzQ0Q3F3d3FSRkovdGMw?=
 =?utf-8?B?Rk13WFNNalVQaWZhRVJzUkZBVkR3L1Nka0k3MTZjeHVWbXNaMHpEc0FZY0NT?=
 =?utf-8?B?MHpIak5nRjhPTUJ2NFRrR1FoU2hvZkZZRUJHTWVEVGF5VmRZc29rTlRrc21h?=
 =?utf-8?B?K2xpUHNuMDNJZXFON01iSkx2RktPVFo3YjFGUEh6V1dXbmhjL1htcVlrdWNu?=
 =?utf-8?B?aUhCa3c5UzJTSXJuUW84QUozTW5zNEVyeEY0MkJZdmtLajJIVDNKb1E0aVQr?=
 =?utf-8?B?Y1FEMFVjZllwWHJzc3piNkI1SkpkaVRjNmxDVG9TSGVLTm1CeWlsRW9YUnNO?=
 =?utf-8?B?VHdZSnBtQkRjWi9MZUpIVWRjOSszK3BKWEhENmVIS3JWSWp4WDFlcUUvQjZy?=
 =?utf-8?B?eEVkNjJGbkdaYzlKYVlOZDNzbkQ2K2ZScTZIdGlpWVR5Wjg4d054ZG1CVDV2?=
 =?utf-8?B?cGRhbXU5RC9PL1VteU5xcjZHTUE5c1AwdlBONm5LQlQ3MVlvanRpSzVZbUd3?=
 =?utf-8?B?T2gwMmdNTmtQell3bk1HVFdBMUhuUlFmbDJQNU9KMCtqMWYrazNqMTIraStF?=
 =?utf-8?B?RFJDb28rRnd3YlhJUk9DRGUrSURpWFJzdFlpREVuYjZveDhrUkpzdU1iMTVh?=
 =?utf-8?B?Ym9Jak9SMDFPa0hSNHFMaE5kQUNWRW5QMTk3TTd2TlZmV2pPNEYrOWZIcUpa?=
 =?utf-8?B?NHIxV3c4SlNaU2ZJdllTcE5HZ0tXc1dDQlppRGNiNkZSUitWNE03d3ZET1Bv?=
 =?utf-8?B?NWI1aGRxdm9ycUdYNk55NUtJN01pRUxEVDVWUlA3aDBtTGVBTG1Gb2NzdGk3?=
 =?utf-8?B?NW9jdWNRMUcwT3NtRXV1ckIvOVlOZk1GaEViM3V2VjZDWlk0NjArb003Z2JB?=
 =?utf-8?B?aXY5blpQNU4vWURFblFVeWxFRllOVnNnWENiWFFBQ1M5c21vZ2RtRmMyMksw?=
 =?utf-8?B?clFka0JTRng3VHJFV0dTU21vd2hOYUFxTisvUlNZK3FoWkRPKzd2QjZobEFo?=
 =?utf-8?B?NUttKy9taU9PZFJaL2pYd1kvQXlzN1lFU05LRWZvU0k5WXoyOWsvazdVSk90?=
 =?utf-8?B?QkxENHJiOGdIdWliNm1obXFmTDdwUkI3ZUpNd2FTUG5sY2UrRGFOVHorYUZS?=
 =?utf-8?B?bEl0UFkweVIydkh1em14Rk9HRXZkeVNZaGIwTVZIL09CTzhqSzdYWDlWeElI?=
 =?utf-8?B?R0tDOC9hZ0xoLzZ0eVVEMVpja3B3UC8wQ2wwT2dTY2I0eE9NVnRWSUhhVmtr?=
 =?utf-8?Q?WiUqrOHQVX473k5+avc17OCT6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd65c462-4af3-45a2-172e-08dc2947b44e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:18:32.5210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Krg9TO+KnYJchJXxIhtJ9hHEqR3HjoSqMHal+e7ZtJFcU5nuCcSnbxWykFVCDAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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



On 2/7/24 12:30, Michal Simek wrote:
> 
> 
> On 2/7/24 09:33, Venkatesh Yadav Abbarapu wrote:
>> Add missing prototype to fix the below sparse warning
>> warning: no previous prototype for 'spl_spi_get_uboot_offs'
>>      [-Wmissing-prototypes]
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   board/xilinx/zynqmp/zynqmp.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>> index 9f50090720..ba49eb7be2 100644
>> --- a/board/xilinx/zynqmp/zynqmp.c
>> +++ b/board/xilinx/zynqmp/zynqmp.c
>> @@ -18,6 +18,7 @@
>>   #include <ahci.h>
>>   #include <scsi.h>
>>   #include <soc.h>
>> +#include <spl.h>
>>   #include <malloc.h>
>>   #include <memalign.h>
>>   #include <wdt.h>
> 
> 
> good. Please send it to upstream.

:-) this is already upstreamed.
Applied with also
Fixes: 2c8a09219cdb ("arm64: zynqmp: Add multiboot support for SPL/SPI offset 
calculation")

Thanks,
Michal

