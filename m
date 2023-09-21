Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E797ECD342E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 07:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4C6E80282;
	Thu, 21 Sep 2023 09:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WJecgXYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FC486A2F; Thu, 21 Sep 2023 09:57:52 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D22B8646E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 09:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5tWdggqQhKyDZRgmOXACh3rbz9zzyl/ek00GcvWtHQxdd4D3RPBePUcXo5F68NVTUlwvUCvCCzy4smHKQfzgAr1aVBPsyweW9fulFY6n9YcZjGT0fkGQDXdWUdpw6Lf5J2ZapFzDSEGQ9Dz5V26W4oZvJYJ1ub7jHotWjmzZv/BFj2q4EcRPbQebX0Xiyo2j8uxNWq4Ca574l3rBFi/j7wfEoopGD8EzzcVcqKZiDq3V1jQ8vgJz13SGh/zWkHC7vlcWIrH8MyP7zhKojblsJERGB3Z6q4oxE1KclNoqbE4Gqgdzv0+axjDGaSzroCeIUuEwagnkC9sAbUwhO2i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdDfW3TzKboU3myVdcEQl6vpCrcB4vjTI4ngvWuq1L8=;
 b=RtpSXQ8f+QcqK30pnHcxfwtv+J4aRQK72ipY4G4LjRlUOWuzNaetQ+YoBai5XZg4eBg1qEqhLwD9pkPL78vs6H6S75BExXY7BvxkMhbNOVb/PPLn0jxI7P9TV1bvzFv8/h8uekbI44xFu24cjoPN5u8RNbd8NVPWzOGRyzpXl+d+pJZgPFl1M7C5vLztci+gyF1ajo3wLg9Ln5T0tX6rr4qUp98+y7YTAjZO8+UAMeipNKCuETAHX2E1qA55q5eM7RmwIU5y9BVsYgb8EDtg3J+n6axz2VFS9t6F+vfzRe9D6qxj45XkAkP/cbfJgeYGwrrDH9bM7wSPfjitU2x27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdDfW3TzKboU3myVdcEQl6vpCrcB4vjTI4ngvWuq1L8=;
 b=WJecgXYLqZa0JdoIZbLESA+zyLmC47cFRaWsNbLiRiNNtKJPhax0VCnOh9BYiSkdX/tx9ufsrvXX9mNSQYgGtRe6xhECbP6FOi0ysZfpjnjZPY5xxuSOOzCTTWXgMt1HcOHnDvtx8THeObDtrFplu/eFXyiXq4k2t2d3Sh4pqnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 07:57:48 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 07:57:48 +0000
Message-ID: <e52f81a9-1006-ca4f-8501-7c6c1f6087e5@prevas.dk>
Date: Thu, 21 Sep 2023 09:57:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US, da
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAPnjgZ2=Yx=rqWwi9_N+dzKQq0EViGohYd0QrJYxrUERpZwXyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:208:122::49) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8881d2-5465-49c8-4348-08dbba78727e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAjVbcD/WdZ+zH69RUF8Olu9kr1pS6Bya5xvFobhQ1BIlZbhJmooQJKhBHfGqkiZRTqzw9ZO/WWK7XjHwQ637f5+CgTJ+yBZ0/TtclFS3SF04eBQRWhZBSkbi3gMXu8stD2RI3TMNPqp5GU6imEAH3V7J8NeRRoXjDavZM9iI2o8VhOv1SLcrPOOJ4HqmJVwMmHHV5uAwLeUe+jQp1a8OfXu4ReuRFHnIvPODAkGsHbkoQICN/fryJKaQ1hlqH0fC4M6lmjbIJallVYd9vBPQ7qyC6nzvXWP2JOROBIUzwJAcZFslidGMy/l/QXQoZab29yhVHirLDFg5KpH9JUZ0PuqqGmtnfAAr3ebvl6pO7kOwcJYhUSKtbLa7iWOTkI6A1aOQPkYiDVWjb3P1F7C/GxonrUKp2B0+zq650PpsiXtDlIJRKlw8xhCcsRjG8MehmhOnGDdfi24Qg/phUvTyImWrgs9IQPFeVNNzdZ+/VLEDbV6P8XPUThjV2JLInQc2bRIFNWGyRlsWI0SNmXgqZNae0dTTIO03+0EwJ9c1JTwwGtTm6AyAGfzngDhjFxYk783xZ8GC8Gk6BkXRrzQhwoQ4959ZWN8Wu/YoCWFazNBUHPcgrDuLJK71uzVCyI1Ksw/9ENBNqzot9mqz3NSAXkC9zfy9O+0Urm1C3u11AjDtzwDPcatMvPGVnIEMWUG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(39850400004)(366004)(1800799009)(451199024)(186009)(26005)(2616005)(6486002)(6506007)(52116002)(6512007)(86362001)(36756003)(38350700002)(38100700002)(31696002)(478600001)(41300700001)(5660300002)(44832011)(6916009)(83380400001)(54906003)(8676002)(66476007)(66946007)(66556008)(8976002)(31686004)(316002)(8936002)(4326008)(2906002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z00rT25oamRHL2ZUSGE1TkgyU3dLdUJiM3Q4V2tHNzg1MEpZMWhzUmlGSm1w?=
 =?utf-8?B?bTBXSjhiaHd2RHlYYjZwNnpYc2prSlp3VXJ4V3luRHRWL2V3YzZwZGJmMGJT?=
 =?utf-8?B?cU1XejJ4L3lVYnZieVVMWmJvM2ZYNXhXamxzdmIzYXZ3TG1hSGUwWURvMVdX?=
 =?utf-8?B?YXl0TEdCNEg4M2xmMzJQRjNqWmRma3RBc1o0VUROZGFndjJGR1dnajBpdVRH?=
 =?utf-8?B?VDJKMFVrMEl0QW1WV2I5cnh3S1lFdzJ0UkViVUpXdEpxcEdtbFFNYmFhMDhF?=
 =?utf-8?B?TWIrRkJGZUVzWnJJU3NyeW53Z0paMCttZUtxMkhqZmFGZTE0R2Y2U2x0bWto?=
 =?utf-8?B?V2FjQ3ZCclJtZjFBNWtzU0xrdkFEYjdldGpEaUtGVmJhOHlFVHZycFBWdHNZ?=
 =?utf-8?B?T1M0QWhoK3BycFhyeEZZdmgwdEdlVWFkelVick1KRUpkcm9XNSsyanJGVVhF?=
 =?utf-8?B?SGt5Rk1YUmsyWmhnUUVraTcxWXI0bThXMW5VcDlTdFFaWW1YdGpsL25naCtj?=
 =?utf-8?B?bytrSEJCMTFSNC90WEEwUmh5UjZWaW8yQVA0SVE1dU5wVTBGaEhBRDc3NU5s?=
 =?utf-8?B?Q1N5cnZBQ0N1S1g0b2hsdHVkQWJwMVYwWTk2eEh2UTB0RUpISmRuUG1lbG9I?=
 =?utf-8?B?SElQOG9jY2ZZcjNKWCtMRGxjQUFIWmFTQkVnVlkyVVhwNGNxdTRmb1o2blJM?=
 =?utf-8?B?anZRbnBlNHFUbU5yOU85ZHk0TThMN3NXUE5JcU5jUXlWMGR0dmM1R21ZNEEr?=
 =?utf-8?B?OExtbGNOYkV0NllIRjZjb0Q4Q2x3TUZhdzFkUFVOYjcvdUhHc3JVVUFtdmZR?=
 =?utf-8?B?THNYamJSS2xoblplRDRPSGFMRVZUSllvSmUzR2NiQ1ltSDZoTVovVkprYnVt?=
 =?utf-8?B?L0pvQ1BqeXNGT0tmckFpZjVVbWZOM2I4dmlLM2JTY1NwTWtZdWx3RnZJVDE4?=
 =?utf-8?B?NlRyNEw2ck9hRm5sQjlheGtaN0FqbUltYzhiWnFwMGluSXRiQ0pTR2h2QU9K?=
 =?utf-8?B?WnFTcllKQjBqdGM0bnlFUnZGbzkwM1VKQ3dOWm9teFo2NHN1SWR1ZkkrMU9E?=
 =?utf-8?B?MzVYNnI3YzdZTHNoLzFDajF1YTZFUDg4MVFwaW9GWU9HcC9JQlBDSnBTOVpY?=
 =?utf-8?B?ZmF0bGV4SGI1SDJiakIwZ0FNVlhPQ2VCN0d0RUtQcFpCNmo0T1J2b1R5VGQ1?=
 =?utf-8?B?Ni82QUtDOXpjYXlQYW9TOXhRaGVkN0ZMcEFSeGxlYjEwQUFySFRLTXZ5cDMv?=
 =?utf-8?B?eG9DYzFEUUlYTHNRbFFCSDU4bDBIUEJwU2QrU0RQVXh0RFpZc2Mza3FSamdT?=
 =?utf-8?B?d1FpelE3SDYyV3V5Ym5sb1gvZ3JkSllNZEgrcEVjYnFJR3RwM0hkbHJWQmZ3?=
 =?utf-8?B?UjRpcnoybVZNTmdNSHd0dlNQdXlMb3RjZVU3a2RlWFhic3RrUGRUTHJKZzFl?=
 =?utf-8?B?YWY0clpkdGFBVGdiTnQ1aEtvUEFwQkNrd2ZpNnE5MnJ3TlB1WkVUMU8rSWZh?=
 =?utf-8?B?RE8yb1ZxQTFiOU1LU2tpaEVyNmxUNUxtaklHV2tjTEk4YW9xeno5QlRndlFY?=
 =?utf-8?B?dWZTT21LR2NGcXJ0MWZIK3FXdGZXZmlYdFB6WXBMbC9UVlgxUTE3SkdHME41?=
 =?utf-8?B?N1VRSDFvcnRHL2NkR1IwRWQrUmF0Qkp4ak5jcFNsajlWeVJORWhVWDhzUy9X?=
 =?utf-8?B?QW1tOUw0NjQ4Y1Bwa0pXSGkxWXJ3RDFLZldWZFQrV2pZTVZhSHN3REJxbWYr?=
 =?utf-8?B?dEVwZ0xWZVkxWTFQYWNick0zSktMNFN6RWd1K2tOYVFla3plSlVxUXRZWStM?=
 =?utf-8?B?WjNQT3RDcDdOc01Kc3o4TFgvMWI1Q2cxWGkzaUhEWFVKZlYyeityOUMrUnRJ?=
 =?utf-8?B?SGVJS2NSbzFVS3NyUWNJQUZtejdsVTFocVZBU245ZkhZZkxpUHhPcTlxQ3pN?=
 =?utf-8?B?SXlGNWlMclRHNnRURHR5QjhNNWVOWk5wUTh5YktpZHlwcXo1MnVyenMvV04r?=
 =?utf-8?B?RTl6ZmVUWVpidTBxUlNYdXpZYTZ5TDhBY0NEMFZEYyt5b1pDZ0dqeituR1NX?=
 =?utf-8?B?Tkc3UFdkOWJWWWxZZUg3QXF3ZUlMNU1tOXhjcGwxenh5Z21MUlBGTk1TNlcx?=
 =?utf-8?B?RVkvb08zT3duaFdIRHVyaFNIUVB5dWlFOS85V04yMlVJTmZrOW1nUFBzSlRp?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8881d2-5465-49c8-4348-08dbba78727e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 07:57:48.4030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bph7AXofejZPFFTza6eHzlsl8B2Tm2bLz8YgT7GwkcFtmclEeqSiMCEnUiGBKyG7pJPpIRjoYRB9hiqSiNhW0OGhf7Z9xVcURbY8MUIMG38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7084
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

On 21/09/2023 03.02, Simon Glass wrote:
> Hi Rasmus,
> 
> On Tue, 19 Sept 2023 at 05:37, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
>>
>> In some cases, using the "external data" feature is impossible or
>> undesirable, but one may still want (or need) the FIT image to have a
>> certain alignment. Also, given the current 'mkimage -h' output,
>>
>>   -B => align size in hex for FIT structure and header
>>
>> it is quite unexpected for -B to be effectively ignored without -E.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>  tools/fit_image.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Q below
> 
>>
>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>> index 9fe69ea0d9..2f5b25098a 100644
>> --- a/tools/fit_image.c
>> +++ b/tools/fit_image.c
>> @@ -712,6 +712,42 @@ err:
>>         return ret;
>>  }
>>
>> +/**
>> + * fit_align() - Ensure FIT image has certain alignment
>> + *
>> + * This takes a normal FIT file (with embedded data) and increases its
>> + * size so that it is a multiple of params->bl_len.
>> + */
>> +static int fit_align(struct image_tool_params *params, const char *fname)
>> +{
>> +       int fit_size, new_size;
>> +       int fd;
>> +       struct stat sbuf;
>> +       void *fdt;
>> +       int ret = 0;
>> +       int align_size;
>> +
>> +       align_size = params->bl_len;
>> +       fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
>> +       if (fd < 0)
>> +               return -EIO;
>> +
>> +       fit_size = fdt_totalsize(fdt);
>> +       new_size = ALIGN(fit_size, align_size);
>> +       fdt_set_totalsize(fdt, new_size);
> 
> Shouldn't this be fdt_open_into()?

I honestly just copy-pasted fit_extract_data() and shaved it down to the
part that does the "align the FDT part of the file".

I don't really understand your question. Are you saying this doesn't
work (or maybe doesn't work in some cases), or are you saying that
there's a simpler way to do this? For the latter, sure, one doesn't
really need to parse the whole FDT; we could just

  open()
  pread() length from FDT header, convert to cpu-endianness
  length = ALIGN(length)
  pwrite() the new length in fdt-endianness
  ftruncate()
  close()

but I thought it was better to stay closer to how fit_extract_data() was
done.

Rasmus

