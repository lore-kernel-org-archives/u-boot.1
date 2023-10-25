Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E33EC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 07:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8352E87A65;
	Wed, 25 Oct 2023 09:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHVxGPTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0373B87A6F; Wed, 25 Oct 2023 09:33:23 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF1B87251
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f89aHz4pbbo45EOO4neByinjRlPm8rO2W2KOv1330rBY+CsyPniF2Q230vM6AyQgWeVSXTkE91vDOqzfpm8wMcKghmyz+0MXqjluBmJ7UxP9fRbrPLFRY2Ktjnd7Nmtwd9WAQyCC4X34DQpgUscZ+wIXK2BPtOQRBYDq+W4p1lNWAuRPZ93ugZ4FNfkA1FX+3ufJPnlEzjrLS0j7ASNMpyTrWhKokmQZShhXAQJNUBdMZb0yLtIjb+LDGgGputcCvQSs5epb4mK5ahUuUbmqQUWSzAEUOo2t8RnOyywNaMPrT7/k6mVR4UMzTfyj3wcRq6FEB73NiwnkPLzWoAat3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goACJYEb9t5vvdb5QRXQjFZj+EZChAK0rzVOAU4p12o=;
 b=f0mFWucBEclB+uVtCBK2CUdKJkjJA2qkyq/MBMxn0bXPpURDoobI6MGIuQrSRl21EAsUTG88mcsyPpsz+DvJX3eMIMallWvibZhBIQ36HztqayVLY74vulI22ww1mJrxtbgCm6PfCRN4Q8RDYJl8K5uDQohtGVMbUsbOJgFcHDHdHaUuMuPw6WtdSBK6I6cbeIKyllr/Cpz7BS2RxNnaEuEFzkcVBygaOvSQBVLhLmo4XNXhZUpw5wfjZ2pzaLUYX4HSYpvABJJVCYOIxqmabSAR1dnJevO7nGrOCk4OxEkDGrC/Xhz2nurM4F0cEhHQFFdDJMXH+6+/9V6J2WjxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goACJYEb9t5vvdb5QRXQjFZj+EZChAK0rzVOAU4p12o=;
 b=tHVxGPThmTqvsodD/Uu7X5IdOpGjpYMNeGPxs5CgH5erjRrigBJTvtLhsIREuJIQ0z9IQX9Sp2Um5znwishISJDfjl+S2nDJOFFjDV9mGrSWMPGOenvwxwXpzWRY5WeEMB8jdeD5aAvN+nw57DlvaKVtmjMGwQlVBn1lIPfBiF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:33:16 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:33:16 +0000
Message-ID: <cefd9ab1-9ce0-46da-a969-9fb09e55d4fa@amd.com>
Date: Wed, 25 Oct 2023 09:33:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
References: <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
 <20230925141906.GW305624@bill-the-cat>
 <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
 <20230925143325.GZ305624@bill-the-cat>
 <c1fb916e-7269-485e-a77a-ce28a079c7fe@amd.com>
 <20231024180337.GB496310@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231024180337.GB496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb0ee10-07b5-4b52-910c-08dbd52ca71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knLjf31khgyRVz+9UyR/0svglNqaA0tQI0/GdQGOZrhApGHLJsRUDanKwxqA+JiG4dluaiDgXppUWU0YM2eBMfg0ByDE1L3XIht8w+w3kdSZyOFORlpwzDHdIvTkOmzTjXT+Mna0uDZxbhoTmh61X/MRpz/ELB3a8pklWAjgVuJ6naHz9IFW0QM8FV0RUkbC6r6XRQZAaGlAr+kre+D+28O3/8HTCg7+bOLUy36I7U9tUsYkn/Puh6NHhNN3AxAbdNvYWFQDX4G0/j6p6Ba+P420KcZe173onroIQXBkbotWkNYXpqq7IHnDeimJTwCpokU5o91gnhr9l0G07+XWEC3i73xFxwb9MHccmf1KIYHhjL8GqLAZgl+dnvll6zoQAmj1f/8diN991ReaRxTcM1EgoEaV7m0/Xe009chdjhO7qPJzNjnuUZY5SshPPI+UHWMn/Xf7407Lzrt8lIQ1bsLRskAwIDVutjADsKDXxQnF+Pa7IvQuwA7r6V8BZ0675UC+QlhHm8qIP4BvPfii/c78+ZG84EKAQiVBCoE/Gv/iEnYSForKcCScuzsc+fw8talNZ1egD+L0OVHrk5+oy5OZEnVlH64s0WbgW9VCbCp43/zsP94sQD9Jcpj2B47jvAYLWYPpg0Mt6x1ev/bLLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(31686004)(66899024)(2906002)(31696002)(36756003)(5660300002)(86362001)(6916009)(41300700001)(8936002)(4326008)(8676002)(478600001)(2616005)(6666004)(6506007)(53546011)(38100700002)(316002)(66946007)(66476007)(44832011)(66556008)(83380400001)(6512007)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFQc2pURlp1YXVNZFhjKzFhbWdObi9hSy9zdTRiZDdpL0dLdUpzNlRVSndW?=
 =?utf-8?B?YVZ3d2xRRzJOTHBtZmdkU0RlOUFIWnk3NEZiYjAvNFdEa1dRc3ZoWjBrempX?=
 =?utf-8?B?R2VucXFGT3hySW9wYkxEcHlZYkNwV2E1WFZLTE16L1lPdzJ4U1RTLy9Td3Ji?=
 =?utf-8?B?dGxTMXJLanA3Tm5RTVp5NC9GOStiRERpT3Y1R0V3NXF1emlycjIxYmlkWmlC?=
 =?utf-8?B?NkRIeHVLMHRUOGQvU2JEd2o2ais0TWtvbEpGNVNVc0N5RncreTRyTDVkQUJH?=
 =?utf-8?B?MFNrb05WL0NTUEJvYXRpb2txalZLazJEak1yc0VhcUNrRGpDb3RPVHZ4Nkdk?=
 =?utf-8?B?M3k0c3dyWUVnRVo3UUN2WWNhUTNWNVB6MnRNTmVGTm1WdG9JaGxJVG9PSXY3?=
 =?utf-8?B?NjAxKzV2YWM3YjdhUEJPMWhXYVV3MDdVZlVjZURtdlRzTjNjK3FvV2hqWmZP?=
 =?utf-8?B?REZKYjZhM0RQcUxMWmxKOWdsQzNmaU9vSDVwa3VZSVRCS1I5aDVYRGJFY2tq?=
 =?utf-8?B?NUhuZVlOMGNBcDVYOUZheERqejU0SXE5MlgzcStJWUF1SzQ3YlUrdE9UY0F3?=
 =?utf-8?B?YUhuOXJWZFp0aUxCM1p0STY0RGs4V1JmUGxHL0h6S0MxZGhiVlEyMFA3TzNZ?=
 =?utf-8?B?N01sdzZ4RzQyOEs0KzlxMW9xL1JjUmJiczNTbWhkUlVtWHVSOXRscU9uSHI5?=
 =?utf-8?B?a3ZXUWt3ZmtzYWNyVEpEQS9uS2EzbEgzS1RLc2lPeStOK0IwTUZYenBUcVA3?=
 =?utf-8?B?NnhZNjQ1NDRMQkU1aTBET2xJS0NoVEJiK1VGalNURGxBYkpLcjZFbHZEc1FB?=
 =?utf-8?B?R1pMdWtDZXlUZEFhcENkN0pUMGJtaWowS2N0c0twWW5jN3ZvTm5MODdMZ0Jw?=
 =?utf-8?B?WW1tdzdjdSsrVUcxYjZ6aVpmbDhYQlZwYnFRRERTVkpLSXpZMFpJS2szRVIw?=
 =?utf-8?B?enhPZlB2ejNRTVNoQndJdlVmYm9TZTljRE5ha1g3ZkFIS3pDOTBHT3FpWGJ3?=
 =?utf-8?B?SUs3VTNxZmxJNEZmaXgyT3RVdlZBbGtoS2RUN3pFT2lpclNaaWZWWXNXbTFy?=
 =?utf-8?B?Y2dkb0twQ2VWdXlqOWxibjlDRW5aV0pXNDV6bEFxcFNrdDhFYUlOVGJPbUlO?=
 =?utf-8?B?bmI4YTNiSkhrUUk3Vk1wUjFTRTZjUDVFREVRbW1qQUJwQ1hSUERIcGd0Uncx?=
 =?utf-8?B?YUlzQ2hyMHVWSEU4OUVyUFA2S0xBdml0MVBHV2Y4ZmorTU5mem1XRkp3TFU1?=
 =?utf-8?B?MzhPZU45aThQQXEyQndnWTRHWFhqbDlQamxRRlJXRkUyTmh4N3NyOU9KUzJO?=
 =?utf-8?B?dmJTQkptc0hsVXZJTG5oN0VGMW5LSThCYWlNWjRRUmgzQ1Jqdk4rUWlENVVh?=
 =?utf-8?B?WGhhUy9tNDlCZTRGSXhzNVBvQlloQnZOVFo0a2k1VVE5SlJrbUlZQ1h5THRK?=
 =?utf-8?B?QWE3VVkxWVg0NEd6K21oZjdPK2wvaTdMT1NFa2pWS3VnSmtBa2U4MW92blAz?=
 =?utf-8?B?K0NNRm9EUVhtMXZncWs0OVcyY2VPc244eEZtdXp2Z0FIRmdOc3VUcENINlQr?=
 =?utf-8?B?RHVjMTdzK3MwNHNvR3hXdGdsWGQzaGs3WmlTWlFXS0pibEVEcDJaWDFWbUpP?=
 =?utf-8?B?M21XWEZNWEtvL2FNZUJiSnJmRnd5MFo0WVlHYjk1QU9tMU01TlVRZW9hQ0VC?=
 =?utf-8?B?bllmUDQ1Zk82VU9FRndEc2Q5Wk1Lb2w4SEVSRmlKdVMvN2tMY2crKzA2bHo4?=
 =?utf-8?B?U052eDNaR2dQck5tNVhyRlY3VGl5MFM1bmJrUk9uWkRRb2NIUy9OWUt5N1Iw?=
 =?utf-8?B?TjhBbUdZWWVhb09RY3Q3NzNlV2Roc1VxRTVlMzJJZjJBR1BJVjRKZkNncWZx?=
 =?utf-8?B?YUh6a0lKT0RkNmpSSy9DeGQrMGlQREZGb0dlQnJMbFphaEE3REFmZ0hVL05O?=
 =?utf-8?B?YmpBTFNtWVlPWWFlZEdKR21yblhWV2xpOGdQZk9wSjJLZXYxVnAyZEZsVEZE?=
 =?utf-8?B?TGJZYi9NTzVidGJLOEhZSHlDbHh6bWQ4YkxYanZMTHY2clRNOHRHVW9wQ0Ir?=
 =?utf-8?B?c3ZxODMwbnBVMWNGYVBIQVRMbURVbmRvZlRyekh0cWNQemZNVWx2VzFDWDc3?=
 =?utf-8?Q?bW9blK7dN3sGkCkA+0mlxryO6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb0ee10-07b5-4b52-910c-08dbd52ca71b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:33:16.3158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKwHjZ9Qyp50EVTR1yIxXQQ3wnY/EAvdn6TWPZOjnmTiIv+DJmr0p5vy30UyIe5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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



On 10/24/23 20:03, Tom Rini wrote:
> On Tue, Oct 24, 2023 at 02:33:26PM +0200, Michal Simek wrote:
>> Hi Tom,
>>
>> On 9/25/23 16:33, Tom Rini wrote:
>>> On Mon, Sep 25, 2023 at 04:21:17PM +0200, Michal Simek wrote:
>>>>
>>>>
>>>> On 9/25/23 16:19, Tom Rini wrote:
>>>>> On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
>>>>>> Hi Simon,
>>>>>>
>>>>>> On 9/25/23 16:01, Simon Glass wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>> On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/25/23 15:10, Simon Glass wrote:
>>>>>>>>> Hi Michal,
>>>>>>>>>
>>>>>>>>> On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Simon,
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 9/23/23 20:13, Simon Glass wrote:
>>>>>>>>>>> Current alignment which is using 16 bytes is not correct in connection to
>>>>>>>>>>> trace_clocks description and it's length.
>>>>>>>>>>> That's why use start_addr variable and record proper size based on used
>>>>>>>>>>> entries.
>>>>>>>>>>>
>>>>>>>>>>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
>>>>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>> Changes in v2:
>>>>>>>>>>> - s/start_addr/start_ofs/g'
>>>>>>>>>>>
>>>>>>>>>>>        tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>>>>>>>>>>>        1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> Applied to u-boot-dm, thanks!
>>>>>>>>>>
>>>>>>>>>> FYI: I have merged it to my tree and already sent pull request to Tom.
>>>>>>>>>> Without it I couldn't pass CI loop to get all reviewed features in.
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/
>>>>>>>>>
>>>>>>>>> Ah OK, well that's fine. It was in my patchwork queue still, which
>>>>>>>>> suggests that the patches were not set to 'applied'?
>>>>>>>>
>>>>>>>> I am not using patchwork. But I expect my reply to cover letter was recorded there.
>>>>>>>
>>>>>>> Probably. If you reply to each patch, it shows up in the patch, but
>>>>>>> the cover letter is hidden somewhere else.
>>>>>>
>>>>>> I have never started to like patchwork. I installed that client long time
>>>>>> ago, I also have account for quite a long time.
>>>>>>
>>>>>>> If you are not using patchwork, how come you are a custodian? Is
>>>>>>> someone else dealing with patchwork for you?
>>>>>>
>>>>>> Not really. I am just keep track on it via emails.
>>>>>>
>>>>>> DT folks did wire CI loop on every patch which they get. I am not aware
>>>>>> about any feature like this which would bring me something. That's why I am
>>>>>> considering patchwork as unneeded layer. And I also don't think that I have
>>>>>> read anywhere that all custodians should be using patchwork.
>>>>>
>>>>> Right, patchwork isn't required, but can be helpful.  Part of how
>>>>> patchwork is maintained for everyone (in U-Boot) is that I have a script
>>>>> that will update the status of patches to accepted and add the githash,
>>>>> based on the "patchwork hash" of a given commit.  There's a number of
>>>>> automated tooling things that other projects use which could be helpful
>>>>> here, but due to lack of time/resources, we haven't tried them here.
>>>>
>>>> Can you share that script? I am happy to run it and pretty much close my list.
>>>> I am using b4 for applying patches that's why all message-ids are listed in
>>>> the history which will uniquely identify that patches.
>>>
>>> If you like, yes, you can run the following.  Note that when I run it
>>> myself between tags, it will still re-update things.  This requires
>>> having patchwork cloned from git as well and is a slight modification of
>>> both tools/patchwork-update-commits and tools/post-receive.hook:
>>>
>>> #!/bin/bash
>>>
>>> # Patchwork - automated patch tracking system
>>> # Copyright (C) 2010 martin f. krafft <madduck@madduck.net>
>>> #
>>> # SPDX-License-Identifier: GPL-2.0-or-later
>>>
>>> # Git post-receive hook to update Patchwork patches after Git pushes
>>> set -u
>>>
>>> PW_DIR=/home/trini/work/u-boot/patchwork/patchwork
>>>
>>> #TODO: the state map should really live in the repo's git-config
>>> STATE_MAP=".git/refs/heads/master:Accepted"
>>>
>>> # ignore all commits already present in these refs
>>> # e.g.,
>>> #   EXCLUDE="refs/heads/upstream refs/heads/other-project"
>>> EXCLUDE=""
>>>
>>> do_exit=0
>>> trap "do_exit=1" INT
>>>
>>> get_patchwork_hash() {
>>>       local hash
>>>       hash=$(git diff "$1~..$1" | python3 $PW_DIR/hasher.py)
>>>       echo "$hash"
>>>       test -n "$hash"
>>> }
>>>
>>> get_patchwork_hash_harder() {
>>>       local hash
>>>       hash=$(git diff "$1~..$1" | sed -e 's/^ $//g' | python3 $PW_DIR/hasher.py)
>>>       echo "$hash"
>>>       test -n "$hash"
>>> }
>>>
>>> get_patch_id() {
>>>       local id
>>>       id=$(curl -s "http://patchwork.ozlabs.org/api/patches/?project=uboot&hash=$1" | \
>>>            jq '.[-1] | .id')
>>>       echo "$id"
>>> }
>>>
>>> set_patch_state() {
>>>       pwclient update -s "$2" -c "$3" "$1" 2>&1
>>> }
>>>
>>> update_patches() {
>>>       local cnt; cnt=0
>>>       for rev in $(git rev-parse --not ${EXCLUDE} |
>>>                    git rev-list --stdin --no-merges --reverse "${1}".."${2}"); do
>>>           if [ "$do_exit" = 1 ]; then
>>>               echo "I: exiting..." >&2
>>>               break
>>>           fi
>>>           hash=$(get_patchwork_hash "$rev")
>>>           if [ -z "$hash" ]; then
>>>               echo "E: failed to hash rev $rev." >&2
>>>               continue
>>>           fi
>>>           id=$(get_patch_id "$hash")
>>>           if [ "$id" = "null" ]; then
>>>               hash=$(get_patchwork_hash_harder "$rev")
>>> 	    id=$(get_patch_id "$hash")
>>> 	fi
>>> 	if [ "$id" = "null" ]; then
>>>               echo "E: failed to find patch for rev $rev." >&2
>>>               continue
>>>           fi
>>>           reason="$(set_patch_state "$id" "$3" "$rev")"
>>>           if [ -n "$reason" ]; then
>>>               echo "E: failed to update patch #$id${reason:+: $reason}." >&2
>>>               continue
>>>           fi
>>>           echo "I: patch #$id updated using rev $rev." >&2
>>>           cnt=$((cnt + 1))
>>>       done
>>>
>>>       echo "I: $cnt patch(es) updated to state $3." >&2
>>> }
>>>
>>> oldrev=$1
>>> newrev=$2
>>> refname=".git/refs/heads/master"
>>> found=0
>>> for i in $STATE_MAP; do
>>>       key="${i%:*}"
>>>       if [ "$key" = "$refname" ]; then
>>>           update_patches "$oldrev" "$newrev" ${i#*:}
>>>           found=1
>>>           break
>>>       fi
>>> done
>>> if [ $found -eq 0 ]; then
>>>       echo "E: STATE_MAP has no mapping for branch $refname" >&2
>>> fi
>>>
>>
>> Sorry for delay on this. I played with your script and also look at git-pw
>> client and cleaned my queue.
>> Pretty much incorrect series, rfcs, etc should be only patches listed.
>>
>> If you are running it between tags there is no need for me to run it.
> 
> I do this after each tag so yes, you don't have to run it as well if
> it's not helpful to you (it may be helpful to custodians that do use
> patchwork, perhaps with the upstream commit they're basing their PR on
> and then their own tag for me, to then clean up their queue?).

Actually I have updated that git filter above just to list sha1 from git for me 
as committer and that could serve purpose for custodians for cleaning up the queue.
Would be maybe worth to commit this script to u-boot repository that other 
custodians can start to use it.

Thanks,
Michal

