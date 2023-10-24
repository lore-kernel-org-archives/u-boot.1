Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA98C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 12:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D94870CB;
	Tue, 24 Oct 2023 14:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CnmfpYwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D903987151; Tue, 24 Oct 2023 14:33:46 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493F787145
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 14:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWXQNd8uvnOrIx2SB8+pc+1vLCVs/gEe5Cka6++BfNr2t7Cr15bmMau9vTow4zayB7OIMdpMSvWDGfrlUUt0GBhJVQ2cTt0v4yx3/qhfOz3UQFGnYYsroFUQjXdUwkJ5C/CoetpiC59320h2ouLy3S2/6AlRbXE52c2mP+b6ElIXDFeq1ztbH3CFEYB2xLCTXl/eRD2iM4Tlylx7Z4d44XuK9Tl/gPR85GdyXzFlPKQANMkHlorczuEprVxxqU687ZDv6V8UMeKe+VIzKvGqGNjWu3fdZnDLHN7rRaFrxxuESvvor266A/L90C5P9kr61v2IYcJIB74BILXQFHZM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxfWjjgX/6UMa9GVtU0jL9eO64MeNMUaMirmUuE58g4=;
 b=lwgNX2T+a8Y07bstgDBlwIiXt5+piDE+10MbyjFz6TCvURhs0YvP6p+5UWqV7WfsbyKDP/500l35tfvxS0k9tTaAORE5loxu/87hh6QRseynmkhKppjflfjzGxQEmO27J8o9hLJ4rwDWff2qWaZzkIRMQJwMGSo5dnv/a87UTSWIX5103RsPUAQt5CKHN9xRtuvRpWLgSsOeRGgDD8HI2rhuAYK4NZFRQ1wD7x4rXlQ8XEr+E/dwbPWcPYxxd237JamjdDufKVn9oL+tTGdFaeKPT0GnJ9R1jy4/YKaN9krJk0jt2eyLwu0iBH4p9WQvODtVLaQUaTfzZnX5Aul1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxfWjjgX/6UMa9GVtU0jL9eO64MeNMUaMirmUuE58g4=;
 b=CnmfpYwUm4QxTPYbMC8Can06Ry36gvpe+AISDR64AA59w7BLZbmsae4p7N6Mx3SAwuyRqtr1qULu6AI4EKgdTFtv7spl36DZxwmbaftezJBpXrrP+eBFjJCr+MrNIgz4agaBRIiZBth/a+whY63yHFNAs530xC7AVsVkLnyjbNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 24 Oct
 2023 12:33:38 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 12:33:38 +0000
Message-ID: <c1fb916e-7269-485e-a77a-ce28a079c7fe@amd.com>
Date: Tue, 24 Oct 2023 14:33:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
 <20230925141906.GW305624@bill-the-cat>
 <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
 <20230925143325.GZ305624@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230925143325.GZ305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:803:14::25) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: cb973280-e003-4f98-7afc-08dbd48d724b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9N4Qr7oWvK3I/wwLtYTc8zog1o08OLmaufj42FQX/04fuTsDCVOnBXiEUoBxn7NU4svmyMCCRMfhu1HaB2GR4du9h+1W0M/I2gHbWxqe4h4II87c+A6BLBqZx5ge4CdiJQzdJ7B53flu1us6ZkBK0SrU88lSeQJvbJBLQWATJRRCmQVeI0rfDf1H+lWQwIgtfuq9mc/m664rY7bIPSAGBFetL5o95/mxxjaVESvFMGti9z+220xFE4YxZCbvhFgGoA1ItStdtUZvIVXuye7LCJhc0gE0z2ZgZIcY1W48IGMwWSnX4a4zshpW3qNqAY2dxzWl+tyH24fZRvP3xq1baxEoHn0ntA4dD4YcluFn3NG7sbNBlAXspQXGbbmR6EbLGUBqlTrmberPGr/4mCQqwmQuqv/OPpQBEfA/wnhnSGQtCA1A0MV51dlSwRQWd0B31LKWkmFNbL2K9UXzMqLC7GnQ6sAHIDGyaEeSYrozaQinB3dAAvWUsEiK9qOQ6oJDc2wXVyyfLLeLOf1u536pWBAsfR6Xo3KHnLF5cLACXqKCR93FDs3ji+Lv/qWKYXyFBU5cLsfxN8tbuxEJaVeNfFCkn34vrI8yF7SEWPpD6I4y+4kl8p+jmYTW9GJ/nNebONaarnXyFvrEVGzSh97+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(66556008)(66476007)(66946007)(6916009)(6486002)(966005)(53546011)(41300700001)(26005)(83380400001)(6506007)(8676002)(5660300002)(36756003)(8936002)(4326008)(44832011)(2906002)(86362001)(31696002)(38100700002)(478600001)(6512007)(316002)(66899024)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJUOGd5dFZMQVBLOHkycjZSaHJuUzI5OHlZb0lKWjBGL0RaOXpOMlRWTEtn?=
 =?utf-8?B?VzVGNzh2c0t0WGV2Y0FLYXpiMk0xVXI5a0g4Zm8xSEF5MEF5Uk9nRzVoVWdI?=
 =?utf-8?B?QmR6QVdZT2xIbUh1bDBITXpqc1ZNT0duSjJSandoYTJtMjFmVEJuU2YxOTVV?=
 =?utf-8?B?ZnphbEZ1WEZaNmpiMzZkcWpBMjBTN3lUdlpXcGRCUmdsRDB2RDE3eWs1aVJx?=
 =?utf-8?B?VUVvMjltOW5wZTdDeGk4cERyREgyNXk1Y0VsdVdxVGF0Wkc4a29BRll2THJu?=
 =?utf-8?B?Y1R6Y1IxamR1Y2tZZXBmZm5mNG1TUkhNSHg2VjU2cVdMSnp3YklMNll0TjE3?=
 =?utf-8?B?all5aHpwcDYxR0ZTT2g5V253RVoyazc4cXFMbjh0UTdzWG50b0JaWWcySmlK?=
 =?utf-8?B?OFdMdnpkS3F5Ynp4VmhxenlsY2E3czVJMFlybG9tLzFKVElVdmxOR3h5Y29E?=
 =?utf-8?B?RmRTZjdRRzdzSHl4aHdXN1MyTXY4RG55ZndMcGR0WElVNzBZUjN0NnhVSU54?=
 =?utf-8?B?MC9tRWltTENvYjFEUWRzQ3BrTnBxMkY3ZkRQdUxlRE56L2VkNTRpMHdBZ0U3?=
 =?utf-8?B?TmFFbE1QdTc1Z3BmNmlKcEYzRmNzdUVQdWJIMjVCaEVuNSs5SjBGSTlMUXBQ?=
 =?utf-8?B?cEptcXRsZ0dCclBTb2I2TStoWWVHUDl2Zy9IT2d1VGZKNlNpN2R1QkQ5OUhT?=
 =?utf-8?B?OEd2Y2x6bFphbnphN2ttdjZwUWJnY1ZMYkNKQXQ2Y0xrSWU4VEgzV3lrTlho?=
 =?utf-8?B?Z0RLT2cyczl0QjBramFDeERpS1c3cVEwbFR5SG5lTU5qWitQTmM2dHRWVmNl?=
 =?utf-8?B?OHVSdk9sektDTnlHOE96TytUTDY5Rk1JTmlLQ1RVYTFCZkt2N2laT281Vkhk?=
 =?utf-8?B?ODQ3UkJjTmFCc1hkU1VxeDY5VGJRemZ0bHNEanNGRWZqeDZSOUZnUkRtUEtI?=
 =?utf-8?B?d2Nlai9yMXp0ZW00MlNpdTJzallWM3hzb1BSUWp4bUZqaFpGZVV0eUlSSVpo?=
 =?utf-8?B?Rm84MUJtRm5nQUJtWDE2R05tdVR1RW94QjlNZ25uZGQxVll4Tm14L2FvV2ZM?=
 =?utf-8?B?aTN0Yk5CTkkvcmxuMlM2S1JxQ2hXQm5zeGIvTjRtTk1pd3JtK2E5YXNQcmFL?=
 =?utf-8?B?N0hvS1FqUDJKZE41a1BTVFAyVzBZU3ZVU3F3KzMyd0t6TWw0Vzg1dU1mUDNs?=
 =?utf-8?B?TzdnNkxwRGJOM3hkbitNUjBrSVkvVVBXWndyelcyVGozRjFiNHlZSHJHY2F1?=
 =?utf-8?B?N0NKRitFU1pqVEpVOWZjMTUyajRzS3Y2SkxrQVNKRHQ0ZjhuR05FZUI5Umd2?=
 =?utf-8?B?SDRXTWU4V3YxbWI4dURnYXdrK3VkQVhuRGlLZ3IvV2tTVmVMMlJrMXVOUWdi?=
 =?utf-8?B?cUtubEZucy83M0pabG1hMmtMcHlONktxdzJBejAyemY1UDBINU0xb0pWbEsz?=
 =?utf-8?B?ZWlERTdaQkNnd1h6NEV4anAzMWZrRnRPMkJNZXJBOEJoa2o1N1ZIdDNyczJn?=
 =?utf-8?B?TE9JVUhrNnlqTXRWNDFoZXlUcXBBczhQUTJiVDFaVnV1UnJSUHc2WlFDd3R1?=
 =?utf-8?B?cFR5SlVGMGZFekFSQ29iOGY4Ulhjc0Z5QzduM2ZTQjRYeTRBNUpnVldpYm9L?=
 =?utf-8?B?ZWlEd2kvNFMwR1AvWUl3U1c0R0tHQStCR3Vsd2IrV2c2eWhjT2M5MWxuTTRS?=
 =?utf-8?B?ZURxWTFPeS9sZlRRaXljWlRQd3dnVGVPWGxkYjNsMStGKzdCVTdXUmFNT3Bj?=
 =?utf-8?B?VzZmak4wZmFZZ0R2QzdZK0pCMjdxbHpqcmt4a1hyQnpDUndlYUtxc1Q0dlln?=
 =?utf-8?B?aVg3WkNTcWZ0SUdwQ0tBamNtMEhpbWNUTXBKMC96WllMZWg1UEpHSG5pT2dk?=
 =?utf-8?B?R2ZlL2RCYkhOcjdUZDYyeDlkK1BlOCtIQ01Kd1dRUmQ2c25IaVlHbThsZDhz?=
 =?utf-8?B?ajNCTGpnYUNMaGFHUHZoeWsxajVnQVh1UlJXSlQ4R2pPNGFJS2JnbFgzMzBN?=
 =?utf-8?B?RnZvYktSbXcyRWgrVEpSQ0hhR1ZGQkF1Q0FjQ0JOSVN0M0J3MkNEdWo5ZXdB?=
 =?utf-8?B?YjMyMmRlNnluOXQ0YzY0ejhUWmdManN3Q2VHOG1yNXlId2F6cFUzajcyWmNh?=
 =?utf-8?Q?4LgH8xh3zH8P1JXzssKzGbPw6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb973280-e003-4f98-7afc-08dbd48d724b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:33:38.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COV4bxTQ+zIK/yF7aTrtC/uQX7kaFyVkk84higrwpOUP24GZYG7Ar0nAk+sFUCGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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

Hi Tom,

On 9/25/23 16:33, Tom Rini wrote:
> On Mon, Sep 25, 2023 at 04:21:17PM +0200, Michal Simek wrote:
>>
>>
>> On 9/25/23 16:19, Tom Rini wrote:
>>> On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
>>>> Hi Simon,
>>>>
>>>> On 9/25/23 16:01, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/25/23 15:10, Simon Glass wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>> On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>> Hi Simon,
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/23/23 20:13, Simon Glass wrote:
>>>>>>>>> Current alignment which is using 16 bytes is not correct in connection to
>>>>>>>>> trace_clocks description and it's length.
>>>>>>>>> That's why use start_addr variable and record proper size based on used
>>>>>>>>> entries.
>>>>>>>>>
>>>>>>>>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
>>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Changes in v2:
>>>>>>>>> - s/start_addr/start_ofs/g'
>>>>>>>>>
>>>>>>>>>       tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>>>>>>>>>       1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> Applied to u-boot-dm, thanks!
>>>>>>>>
>>>>>>>> FYI: I have merged it to my tree and already sent pull request to Tom.
>>>>>>>> Without it I couldn't pass CI loop to get all reviewed features in.
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/
>>>>>>>
>>>>>>> Ah OK, well that's fine. It was in my patchwork queue still, which
>>>>>>> suggests that the patches were not set to 'applied'?
>>>>>>
>>>>>> I am not using patchwork. But I expect my reply to cover letter was recorded there.
>>>>>
>>>>> Probably. If you reply to each patch, it shows up in the patch, but
>>>>> the cover letter is hidden somewhere else.
>>>>
>>>> I have never started to like patchwork. I installed that client long time
>>>> ago, I also have account for quite a long time.
>>>>
>>>>> If you are not using patchwork, how come you are a custodian? Is
>>>>> someone else dealing with patchwork for you?
>>>>
>>>> Not really. I am just keep track on it via emails.
>>>>
>>>> DT folks did wire CI loop on every patch which they get. I am not aware
>>>> about any feature like this which would bring me something. That's why I am
>>>> considering patchwork as unneeded layer. And I also don't think that I have
>>>> read anywhere that all custodians should be using patchwork.
>>>
>>> Right, patchwork isn't required, but can be helpful.  Part of how
>>> patchwork is maintained for everyone (in U-Boot) is that I have a script
>>> that will update the status of patches to accepted and add the githash,
>>> based on the "patchwork hash" of a given commit.  There's a number of
>>> automated tooling things that other projects use which could be helpful
>>> here, but due to lack of time/resources, we haven't tried them here.
>>
>> Can you share that script? I am happy to run it and pretty much close my list.
>> I am using b4 for applying patches that's why all message-ids are listed in
>> the history which will uniquely identify that patches.
> 
> If you like, yes, you can run the following.  Note that when I run it
> myself between tags, it will still re-update things.  This requires
> having patchwork cloned from git as well and is a slight modification of
> both tools/patchwork-update-commits and tools/post-receive.hook:
> 
> #!/bin/bash
> 
> # Patchwork - automated patch tracking system
> # Copyright (C) 2010 martin f. krafft <madduck@madduck.net>
> #
> # SPDX-License-Identifier: GPL-2.0-or-later
> 
> # Git post-receive hook to update Patchwork patches after Git pushes
> set -u
> 
> PW_DIR=/home/trini/work/u-boot/patchwork/patchwork
> 
> #TODO: the state map should really live in the repo's git-config
> STATE_MAP=".git/refs/heads/master:Accepted"
> 
> # ignore all commits already present in these refs
> # e.g.,
> #   EXCLUDE="refs/heads/upstream refs/heads/other-project"
> EXCLUDE=""
> 
> do_exit=0
> trap "do_exit=1" INT
> 
> get_patchwork_hash() {
>      local hash
>      hash=$(git diff "$1~..$1" | python3 $PW_DIR/hasher.py)
>      echo "$hash"
>      test -n "$hash"
> }
> 
> get_patchwork_hash_harder() {
>      local hash
>      hash=$(git diff "$1~..$1" | sed -e 's/^ $//g' | python3 $PW_DIR/hasher.py)
>      echo "$hash"
>      test -n "$hash"
> }
> 
> get_patch_id() {
>      local id
>      id=$(curl -s "http://patchwork.ozlabs.org/api/patches/?project=uboot&hash=$1" | \
>           jq '.[-1] | .id')
>      echo "$id"
> }
> 
> set_patch_state() {
>      pwclient update -s "$2" -c "$3" "$1" 2>&1
> }
> 
> update_patches() {
>      local cnt; cnt=0
>      for rev in $(git rev-parse --not ${EXCLUDE} |
>                   git rev-list --stdin --no-merges --reverse "${1}".."${2}"); do
>          if [ "$do_exit" = 1 ]; then
>              echo "I: exiting..." >&2
>              break
>          fi
>          hash=$(get_patchwork_hash "$rev")
>          if [ -z "$hash" ]; then
>              echo "E: failed to hash rev $rev." >&2
>              continue
>          fi
>          id=$(get_patch_id "$hash")
>          if [ "$id" = "null" ]; then
>              hash=$(get_patchwork_hash_harder "$rev")
> 	    id=$(get_patch_id "$hash")
> 	fi
> 	if [ "$id" = "null" ]; then
>              echo "E: failed to find patch for rev $rev." >&2
>              continue
>          fi
>          reason="$(set_patch_state "$id" "$3" "$rev")"
>          if [ -n "$reason" ]; then
>              echo "E: failed to update patch #$id${reason:+: $reason}." >&2
>              continue
>          fi
>          echo "I: patch #$id updated using rev $rev." >&2
>          cnt=$((cnt + 1))
>      done
> 
>      echo "I: $cnt patch(es) updated to state $3." >&2
> }
> 
> oldrev=$1
> newrev=$2
> refname=".git/refs/heads/master"
> found=0
> for i in $STATE_MAP; do
>      key="${i%:*}"
>      if [ "$key" = "$refname" ]; then
>          update_patches "$oldrev" "$newrev" ${i#*:}
>          found=1
>          break
>      fi
> done
> if [ $found -eq 0 ]; then
>      echo "E: STATE_MAP has no mapping for branch $refname" >&2
> fi
> 

Sorry for delay on this. I played with your script and also look at git-pw 
client and cleaned my queue.
Pretty much incorrect series, rfcs, etc should be only patches listed.

If you are running it between tags there is no need for me to run it.

Thanks,
Michal


