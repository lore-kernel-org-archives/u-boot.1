Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE08CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5A286C53;
	Wed, 11 Oct 2023 21:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hrzl1vkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9B986E77; Wed, 11 Oct 2023 21:09:17 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D1686EC7
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGnjdXD75CCllVts1WfWjKZ2q7yFn7fxfg3FX62yCVmL1zQLhUrj5LqkCoXUtQOf+97lLT1XEYULjKRlBmd00/ldpfMzOmho8QDDuG1Q18w/8Hbtk/RdWdOdURODEAsJSzdXvpjTA6o/x9Fp+rQb5x7TNGUuDXFD+yyecrgSLneq2XV9BbmX/OJ7QBYDLE8VyuwM2vZo7aOqdmAN0DdJGjG06S/W+6oog7Cr6OIAhKK7K4xygTF8iS+nSQLBT/ncsKTGH0ikgG+TUieEa6h1BdaJrLNUS6Z66S+iVxREmpGkmsM/w2kUw0AADsaASFgzpnz6ZFh/zHzwFVhtPWDCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKn+k+eWJV+sYfvWZan8c3zImYLU0Nnwvb/1YiNgLFE=;
 b=OabHKnqjjHtyOVX4gI/VWYnFES9+tzmFda7stkj08/KVv0YPhe7Or4R8V/b4WuhcZckaDHh9IFYxGqRbr93NnKnz90utkxmV40fr9nS79yEwW3qeNHGJw38jDRtjxKYU/d4YQDDqyxHgjuJ1MjZuyhmDqR15jYB5Wqas2NW935QGuJiIcU2Mr/hVXtP8KT8PUmfYw5lIuA5dxIU1udjZOzb9wAh4AARSgczDF+pwhiZMsLzhFzPpV6mpCLMwJHRBoQpixrVTm7bt8MdulmDa40oEPqvoPlkqChtT1zzrwq6VZHu3bgv70lVJquMRQhBAFlkUZQKiJPtWjO/fd77RIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKn+k+eWJV+sYfvWZan8c3zImYLU0Nnwvb/1YiNgLFE=;
 b=hrzl1vkczvgc9EADmUmlAv71s9XcpCoVkmbOJZjGHM2kKlzjS0cCQeDeBT/1WwnU+OTrNkRwIwBQwA1HWVUEcwk/Ik8z5wkdpbBF70AtkuJsGgkUkcnz4d0fN6n3Ib9nhSErCcodU7WZUzdP34hvuIxsNohI60M7X0XRhf2LArA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6717.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 19:07:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 19:07:14 +0000
Message-ID: <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
Date: Wed, 11 Oct 2023 21:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Content-Language: en-US, da
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Sean Anderson <seanga2@gmail.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231011183722.GT3119521@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: c53d2338-5e45-45bc-94c7-08dbca8d4776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whOsFk52Vc1sR39lVwFShLVIXeykaB/pUtekPrOZY4UdkjDT+AnfJ9Yi99pWaTszbNdYZk5t52vfY+BWmG074sVQM9j2zQtikCEB0xh7tqsKyJf2oqD0iXar4hfU4wATwrIh0dCkTK+fJpnJppJbEXmKlqTB4mT5TJKHLwpnVNSD0YdNsDDoC8Fi/6fkQyK1oDNSKDIkhs5ZYGx0yD7yVONhVva3tOw4+pfb1UDDqEX0i1BDAuQEFNdiSBLFo/KX1dYgeecFvT1yQZkulwVEt1g7OwbiKm1hFuJSejRL+O/gRbH/90uDB1LnN5VU2V1A45CAxT6bxAICDxt77JtNVxKX5SqgaflEJqL2r4/xHmU4yBU0VkBhhacnmZSfWcKqagLR/SXMQcycFQWsBVD+eDaZFcbNd8+6TRe29UhhBoN68VqggbsLF4L885ZlY7PzZXj68oxFzWmlpXg7OfZlFSPBunJjd7FdAhV250I3tufA4/snreNMtmaI78gn7ANHHVYKJ/JCF8yelsiohmm/+/VVfdYW6d8Rsi+JUilh1EC+28xqx6NX4G6rbhaqtZ3QsIbf4aAJl5SX9FhVUeEBct8YMIjh+b2pMaolKAx6dgro8t4eN/yM6XatMrzzjrPAm0Ic/r5zFz4VWuKYHJ9eNF14XpC4P5FZ4xwVmr8GtLCqdUegKCQIIgAe1ffJxcS8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39850400004)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(36756003)(31696002)(86362001)(38100700002)(31686004)(66476007)(6512007)(15650500001)(44832011)(8976002)(41300700001)(8676002)(4326008)(6666004)(6506007)(5660300002)(2906002)(52116002)(478600001)(6486002)(8936002)(83380400001)(2616005)(66946007)(54906003)(66556008)(6916009)(316002)(38350700002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWVoNktqeVdwYSt0bGRGWnpldytPUy9uYVVXMHZ1c3Y0aU95T0hJQjUzWGF2?=
 =?utf-8?B?RmF3V2RkZVFqclRUYzlpZkpOMXpRVGE5ZGhNNTFxOWxrd2x5c09LM2REdVJ6?=
 =?utf-8?B?dlhmZ0lwd1lPSS9jQVp4dUVBQW9LRE5jaTQweWlCY1hNb0dkV0NFMzdiLzRi?=
 =?utf-8?B?NWFNNUtRZ3VyOXZJYnl1VzVBY2dUek9RMDlKV3hlUzVjd09UMVB0czUzV2t6?=
 =?utf-8?B?N0NjeURLdmVYeVIzRGdDWVdRSmQrR1BkalhacDVwTW9FZDVEQjV3Z0ZXQ3dy?=
 =?utf-8?B?ZVRXc2Y4RmU2U29Ec2toMjVOUUZ3V0FDZUozMnlDYXBPSWJtU3oyQkJiQU9G?=
 =?utf-8?B?Ti9XYk1IVHM3RTVSS083Z1ZqV3h0RjFISnhhMFEybzBha3EvZFZIM3BSeHdW?=
 =?utf-8?B?eWgrYVY2T0ZiOWVteDZpdytkbmxhaGQxbHNUb09hbFlVQytiRTNyNmJTVlow?=
 =?utf-8?B?K1BJa2NEY3VmUGJCbC80Q1AwRXh3VlNvaDVyajY1ejNxemFoZER6NTViNWgw?=
 =?utf-8?B?eUtvekkreXk3WmcwMjFPU1dzS3JKT012aGpITnhCMzNuRUN1ZlhsK1VUbkNP?=
 =?utf-8?B?b2xSNzQwVUZKOURaQkNDR0s3TUsrdjA1VVR1RnZ6UmJKL0czYldGZEVYejlJ?=
 =?utf-8?B?SUVIL0YzMG9tQzVMa3N2MHlOcHFYK2hWZ1hKMGhpTE5QWTZPcDcybFhrYXZW?=
 =?utf-8?B?S2JIVTlBQjQyTlVYV25LbzZ3VG55VmIxQzV3TklSYzBQM0N5OURScWJUSm9U?=
 =?utf-8?B?N3pPeisyczVrSzQ0bjNicUFsSS92T01YYU8xQkI0RHM5Y3RGQmhGNmxYamNa?=
 =?utf-8?B?b0U2aGdLcFMwOWtSV09oeFNGczJDbG1KOEo5S3UwcnlKNHJRa0FxTTJiVVpF?=
 =?utf-8?B?NEh4N1ZGb3hTZ2hYVEZzeWdqRDR5dS9xSW5RaFVTM3E4YmFWdUV4cnc3YjlW?=
 =?utf-8?B?WWRtMFU5RjRDSEZ6RGxNWlh5ZW15enRwS0d0U29WQy93RFJJajdtclV1OFNw?=
 =?utf-8?B?WnVFN1pYempzQkJXWXNGL09XamNoRTdxZWY0L3hwN0xFN2laRWNMb1JteFdV?=
 =?utf-8?B?bklzZlkrazQva2ZwbHY0SlB5M216VDNtODZmWGcxUzRXWHB3MTBaVDN4ckNs?=
 =?utf-8?B?Ym53bnBQTnhRUDE1UW1RZk5NRzJHcisxZFVnaUJsa1pKK29pVnA5aXQxQ25l?=
 =?utf-8?B?VXlqMCtSOUVNSVdwNmVMMDJxc1RqU2M0bElEUElVaEdkajdlSCtDL3hpK2pm?=
 =?utf-8?B?OWRRczJWYmRoYTV4UTVHRjhocEFIbllENGdNL1crd1doSE5JbEpJRWxBZDhq?=
 =?utf-8?B?YzlLNm1qQWNHOHRwdWhVNWh5aElBNjlXUmpWZlVVNUJCbXB1TUFGRUpYLzZZ?=
 =?utf-8?B?RUdER0Vhb3lyMTBnUVhZdWZBdVROVzBTTFJPeVg5cDRhZkk1enlrQlFiYlB6?=
 =?utf-8?B?amRIYmd1cXU3NThDYmhaZEQ5d1p4WGpkUzA0OGZvRGlYNmJ4UUVKRTAvTWgr?=
 =?utf-8?B?L3N0WkxQQXhWWXhvcVRwcXpRd1ozdzBwaWFydllzRm9DOEFlanU4eHlYcnk2?=
 =?utf-8?B?eHhHVnMyeWdFcU1QNnoraDRXcDNhaEl6ZmxydXhiYWY4Njc2YWhLSmZRWER4?=
 =?utf-8?B?OU4wNlVoVUZJSE8yMmJ4ME5IYkd6WUVXblk4V3ZjSERCWlo1OVZWbkV0SWxK?=
 =?utf-8?B?bVpLbmNuNW4vTjVRYm82djg0V2VXZ0xHZmE1MkZ5Y3dIcENQbzlaTmF2YlVz?=
 =?utf-8?B?cVU1UHlFa2E1cGhKRE1FYW05Q0Nyc1lEdVNGSzJVNHVkR2tuNDZRM2k2Nmd6?=
 =?utf-8?B?N0FNTE5TVngxc2hIOWd2bElHOWhvaGxib1dQRUNGeDBSZG5QejJxT2w5N09h?=
 =?utf-8?B?RytvVmNBTGNURDFaZXNvOUZxcjREVkN2VXprbXFKWGVtZmNBYXNNTGhiYTFO?=
 =?utf-8?B?TlArL0lJUFN0bnlCVDdEK3Y0TDVjY2JNbTJIdE9xVDhzRDhYWThGU0o1RTNH?=
 =?utf-8?B?THRTYVAwR0U5Ymk2SlUrUC9Tbjd5b1FnWmw2NFo5aTNSR3BFQkF5WUh1aU15?=
 =?utf-8?B?VTNjd0MwalhBMk5jTFZPaVI5ZmJqMmpvWUZ0K1doV1RYbFRJRmRoTmFuV0lX?=
 =?utf-8?B?czdtYVJ5SktNWExTUi9lZ09hSFROMGNnMGdOcmxBLzAwVExhME8zSmU5empu?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d2338-5e45-45bc-94c7-08dbca8d4776
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 19:07:14.2785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNe36YyVY2LoAlhrczltrvi56pk2prw/j8Ih/32N8InFFHc91pcIfuyOYWa8CD/0E8L9ztz4zDh/FTmviF8s7aszcRnfUkH9w74pR79mFg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6717
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

On 11/10/2023 20.37, Tom Rini wrote:
> On Thu, Sep 28, 2023 at 10:02:57AM +0200, Rasmus Villemoes wrote:
> 
>> The man page correctly said that -B was ignored without -E, while the
>> `mkimage -h` output suggested otherwise. Now that -B can actually be
>> used by itself, update the man page.
>>
>> While at it, also amend the `mkimage -h` line to mention the
>> connection with -E.
>>
>> The FDT header is a fixed 40 bytes, so its size cannot (and is not)
>> modified, while its alignment is a property of the address in RAM one
>> loads the FIT to, so not something mkimage can affect in any way. (In
>> the file itself, the header is of course at offset 0, which has all
>> possible alignments already.)
>>
>> Reported-by: Sean Anderson <seanga2@gmail.com>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Applied to u-boot/master, thanks!
> 

Thanks, but I'm afraid that was premature.

The original series which this was a fixup/followup for hasn't been
applied, and Sean had reservations. I'm leaving it to Simon or Tom or
whoever has final say to decide if they should eventually go in, but it
would probably be good to get a verdict soonish (it really shouldn't be
too controversial), and if it's a no, this should just be reverted.

Rasmus

