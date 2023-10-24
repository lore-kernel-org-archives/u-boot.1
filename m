Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D844C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 11:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0F087103;
	Tue, 24 Oct 2023 13:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Y3EX87h+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C36C87124; Tue, 24 Oct 2023 13:17:56 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0781587103
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 13:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmjh8TELrLcQeuWyQvj3ojgId325C6Rw3ZI3FfzjQtazROt3/DvfGJUhSyRjhCh5E5SEirtsawWFX5Ov8wL/UhblEb0oHkpwFgj0pQFhOdHhjKk1wlVjhDsaLpQkXChn2JTh+pJ0u/FE4dTVtO1OOsrgwlrJ6HILPPDfvDvxPh6vSSVdbPhgNPGL+BhcMnGXjmYNvDEjR/Rs5s21ApIqKltUVbpHvrgHnyjavp4mu6srR6k9tVEsgzPsnqvsxyeBz4jZIKkk7QeZfIE4EgBCotUifBjtWYtS70jWpD57ElxsROKMq139CpJmeGtfUgyMnEUuUaGku5Cn+mq7lXnW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJj5alE/NPxGpESaFNZg7WLm5tIis92H5DqQYqNBfsQ=;
 b=Hz4jgZExi8RVvbZkBW/J3uqlmsrzAiSxHcyfnRa3tBFC3QU3d0xp3b5aqmj8YolIroB3RyKV97XesrhksK5ZmEKSW8loTG7h44kWcJ8LC+ZGk2UG0dU3yX5fhzpTlwFEdkGGnqgQkw0XcQq3O1VF5s801BBLdjfQtBXn+dPtxyRhEqoS/YnPym7LEgFKSh0fW+pTkSiLYqlNfsf17Bdl+u6ogz6XVyqvP9cUBGNp8WRVK54iwMDDmvf1llrqj/WAUWioskT7fcmi7nCoKU+YhgtDTOn5bBKTdXsrJBbIjYr48CfIFLTtiI6FnLTxhvHdJj5e7/WwXcSIufBs3oD1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJj5alE/NPxGpESaFNZg7WLm5tIis92H5DqQYqNBfsQ=;
 b=Y3EX87h+VZlGR85x54EEN3vKfbAzpSHNxsq3ryjug7W1o7bDI1Nyjoq/3ZED4Kxw0pwXWMfs7enkLUCFBZWv6WwD/CpJnGGjhYZ8jOBuEacnoN126DlPp056C4tYYlFVjEcNTGViR99HovLUmJXPSSUFX8FvF4x6hjoM5tXo3RI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB6122.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 11:17:52 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 11:17:52 +0000
Message-ID: <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
Date: Tue, 24 Oct 2023 13:17:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Content-Language: en-US, da
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "festevam@denx.de" <festevam@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: f21d9f0c-77cc-419a-2eeb-08dbd482dcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcOHU6DJYo+2Trwy+lR5QdFHYxhJ2AOfo5erRQLTJb5DpngVZRWghT8wqA3ouXjY82JW3lJd8wocMwuaEir/q8sPjE3ymEsXz58x/VE1G8nAttqrOxmfNLmo7JWyDbroFHZ3LWvIqjNQBkG0LDb/t2frutEyiRMYBf6Z+jgO+2iGWXK2XKZh23IXuIZx/vAvWknK46iE+rDUFizLcP415cnOfZeqTkFueRz9m6awvrTfRKDpJpxnFon2ugjntC3kdLiPaWMaP5U80L5P4nOrmx92UPyCun+1aMLxctm1V4ByNNDMyQ6Bh1kyc6xOijyogKj1zFZEPV2Q1syiY6LUivTctX4cpsd9cY8ZgY3flXCUPaVIIrUJI6ROtHnE44X5p1q5W1hLNldlnBjAGj42n9xYPkIN9MsvEbwKaJZzgm7k0nv4XhWxrs28rzXTn5F/fhXd39GMzFGAEsdnxi9M8LEQqIAyOF+CmnhtuiIKd8tVkkjQzKPOQJOVQeuJGUu7kIr1i5BvsZMp+qgr6M01Xg6ulIjxkTyGDDOXLIXrZAnuqESNkqkYpQ34t8YlCPnlBlaC0Svb4F+1nRYv5s7hAM+QtYDHi5VNIDMNtjhVfAiEJGRN1D/srRLUHAoGXtxmm6OeGQIUuJwwSa4fTEZI6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(41300700001)(38100700002)(316002)(66476007)(54906003)(66946007)(66556008)(6666004)(6506007)(2616005)(110136005)(478600001)(6512007)(6486002)(83380400001)(31696002)(44832011)(86362001)(36756003)(5660300002)(8976002)(4326008)(8936002)(8676002)(26005)(31686004)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZTMTA1SjU1OGtjYUoxRElSOVlrZU5IbmJJZ2JabGJEMWI4Nmp4bk1yaGd3?=
 =?utf-8?B?Z0xqRmF5dzlBc0ZBZXVXS2p5TzFBQ3lJRW50NkFtK3ZRVWdhcERuU2NrSXJV?=
 =?utf-8?B?RFRkTjh5QjFpeGg3VFZ6YmVHQkFSak5iVUFhVWNjaklsQ251Y3RXSU5JU0Fn?=
 =?utf-8?B?YXBrK083RVFkRlk1ZnY5QlR6SHViclA5cXVhY1pIL2dsaEgyYStJWEFWM01O?=
 =?utf-8?B?NEdnRVlIY2VKaVh1YmlVVG9lcmFYbHdSNTZRdzk1ZzFQV1AxMGZVbXcrMmRS?=
 =?utf-8?B?QllBdHBhYkw4VHZjekxqYVVhQWpVOS9qL3NNMkVtMTZNVTdFb3BaYW00Q3R0?=
 =?utf-8?B?ckp3OXVWTXZQQml5WjJNQlF0cGxvdk5QYXdxZXl5dGdJMlNEREdrVFZrYnJ3?=
 =?utf-8?B?Y1JVSUJvOUxSUGJLRTk4ai9kV015ZmlLMzRlNm55TFJOZ3BpY3FlQStieVRD?=
 =?utf-8?B?SE1kajlLSWF3SU9Vb1FuaXhMZ0gwU2NUUGJhdXF1YlJxN2dwdXFQdTI3YWVw?=
 =?utf-8?B?RGVzazU2ZmN6UU9JN2d6TTFIaVFQOVhLazhlczNMS0Y2dnFRZmpuQ3Z5c1hp?=
 =?utf-8?B?RzFkbWU3NGwzY2FRWCtkL0JPWlVIdy9WaENiUU5VZnRQS0lEKy9ldWd6MXZR?=
 =?utf-8?B?dHJmamVKdmlYL2pXRlg1WTlTSFN1b2ZOOUxMZ0MxNEMwY1hOeGRBRDhNTnRM?=
 =?utf-8?B?U0Fyeit4dnBMV056ZnVQSTN0NlFFa2dwOTlIQStWS3F0cFg1TVVQQXdWTjNk?=
 =?utf-8?B?M0tiS1h6RVVNbmZ2OENBeno4WFE4MWhXNGV1aUlxbXp5a1Y1TXY1dFVlWlhF?=
 =?utf-8?B?Q0pPdWtJR3JGOW1YRjgwOEJMZVo5UDQwMEhEKzNTVVBSeWpBV3NxNDhmZzVY?=
 =?utf-8?B?dkV2MVJUeTZlS3gyOUd5ZHcwR3pUL0UxYWJ6Y3hySVp4SGlzQTFteU1ySzRW?=
 =?utf-8?B?MVJ1MFpHRXlWd0lhMjNOWkVydmdVcDNNVmR4dU9JODFHVlk1b0pQMGRBNXFC?=
 =?utf-8?B?aVhwUEEwdkZ1Y1ZWRFZEOHdsdXZDWjVxRk4rYW5uN0ZNYldCOUtqWWdvMzho?=
 =?utf-8?B?QzJUYkkxVmNoUjlNS2Q5QklOWFRWWk5MZG5iaTZHZktUdE8zZDNzTXQ1NFVi?=
 =?utf-8?B?SW03a1ZIYktsRnY5QnV0UVdVL0diZGdpSjZBeTdaUGY2N0FIc0tVaGx2MUJk?=
 =?utf-8?B?QjlxTmZEZWFTVG4wOGViS1ExNGVXbWcrd2Z5NTRRNGdGSE5BSGhPdkVYWXZr?=
 =?utf-8?B?WDloWGJCYUU0M0gwdlROS2l2d2lQZm9qVmRYUXhUTG1pbUhqZFRwclo5cjRN?=
 =?utf-8?B?QlNMVXQ0dWd4NkVKbVY4S3V4d3B4bzJ5eS92dGkxZ1ZDQkVSTksvdmkvRGUv?=
 =?utf-8?B?R2JIY1BjVXVvTEE1TDkvYUNFWmx1TTEvaTdsWC9VSU1kVGRnZGJGN1pISjFJ?=
 =?utf-8?B?cVhETEQ3SktKNDlmVnZUVkdHc2VqZFdmM29nZUZvWUMzNDdKOVhWNmtvMVN5?=
 =?utf-8?B?WTg2d2xCZ3NXVzRxYkgzWFVzNHlpUDVqT2JLU1RaY3ZqSGpwWDBQT0xxaE1P?=
 =?utf-8?B?T0RXQU14THZubEZCM2dzT0x3REU0RDgrU0JSbmM5ci9VcW93dktTY0tsQlky?=
 =?utf-8?B?R3JKUUtxSWE1dWpUTFdYM0taU1pSUS9PYTJJcmM0NVpXUUxwS29jWUZJVDVp?=
 =?utf-8?B?ckxEbWhPbkQxa0NudFg0R09JYnNRaGZiNkpTNy84VExwakVJNmd3ZmhJTjFp?=
 =?utf-8?B?V0ZGNUIzWmtKSFVBOUwrVVBKUHVQMmY0S2hWdm5PQzRhcG9sYXJNMXJlL1Rs?=
 =?utf-8?B?elhZUm0weFpKdjVVVDY4TzBnSHYwd21QVDBFQms5dldtTG1xQ1p3czF6UFVv?=
 =?utf-8?B?cUwwaXVqa1N3Q2YwWHg1czhPQ2F0amx3cTBRUVJDWk1sRkZUTVhaUldUNzFY?=
 =?utf-8?B?bWVCbzQ2THZUYWpDYU52WFkxRU53cjJSc3FTcDhwY1RMU1gxb2pncysxa1hS?=
 =?utf-8?B?aFdVS2F6cjFjc3FFN2cwcTJBTHdRVkNua2dNNHdKSFRXTUptWk13Y0VOWklI?=
 =?utf-8?B?cVF4SEZqU2oxdzc0S3dJNkVqSVJOeSt4WE5TS1BZaEUxYkwza1Q0VkpOYlNs?=
 =?utf-8?B?SkhNdkxEQUhwY1FIUWRrZVhYUTNVSDcyWXcyVmE0bXQzOTlLK3hlWFhyazJ0?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f21d9f0c-77cc-419a-2eeb-08dbd482dcf3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:17:52.1774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ckdO/El3vAahXzcSh8qvT2xAMZSTP4PbfmreZtm3Bt8krzHQZp/FyA4vN6X+Ur06sllix+EZiDZZWLf2+BFpjDQ0JYQsWTXMml6H1dJlNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6122
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

On 24/10/2023 12.03, Marcel Ziswiler wrote:
> Hi Rasmus
> 
> Thanks for your help.
> 
> On Tue, 2023-10-24 at 11:18 +0200, Rasmus Villemoes wrote:
> 
> 
> [snip]
> 
>> Hm. Can you show the result of 'fdtdump u-boot.itb | head'
> 
> ⬢[zim@toolbox u-boot.git]$ fdtdump u-boot.itb | head
> 
> **** fdtdump is a low-level debugging tool, not meant for general use.
> **** If you want to decompile a dtb, you probably want
> ****     dtc -I dtb -O dts <filename>
> 
> /dts-v1/;
> // magic:		0xd00dfeed
> // totalsize:		0x414 (1044)
> // off_dt_struct:	0x38
> // off_dt_strings:	0x370
> // off_mem_rsvmap:	0x28
> // version:		17
> // last_comp_version:	2
> // boot_cpuid_phys:	0x0
> // size_dt_strings:	0xa1
> 
>>  as well as
>> just the actual file sizes of u-boot.itb and flash.bin.
> 
> ⬢[zim@toolbox u-boot.git]$ ls -l u-boot.itb u-boot.bin
> -rw-r--r--. 1 zim zim 882984 Oct 24 11:42 u-boot.bin
> -rw-r--r--. 1 zim zim 934504 Oct 24 11:42 u-boot.itb
> 
>> Also, in spl_romapi_read_stream(), can you add a print out what
>> ss->pagesize is, and also an unconditional printf() after the
>> rom_api_download_image() - we apparently don't hit the "Failure download
>> %d", but I'd still like to see if we even return from that
>> rom_api_download_image() call.
> 
> U-Boot SPL 2024.01-rc1-dirty (Oct 24 2023 - 11:56:41 +0200)
> Training FAILED
> DDR configured as single rank
> SEC0:  RNG instantiated
> Normal Boot
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x4802b000, size 1044
> Need continue download 1024
> spl_romapi_read_stream ss->pagesize 0x200
> spl_romapi_read_stream ss->pagesize 0x200
> downloading another 0xc9000 bytes
> rom_api_download_image()=240
> spl_romapi_read_stream ss->pagesize 0x200
> downloading another 0x1ae00 bytes
> rom_api_download_image()=240
> spl_romapi_read_stream�


So this is interesting. I tried disabling CONFIG_IMX_HAB (because that
case doesn't create an .itb with external data) and boot on a board
which is not locked down, and I get

Trying to boot from BOOTROM
Boot Stage: USB boot
Find img info 0x000000004802df00, size 1504
already have 256 bytes
Need continue download 2048
spl_romapi_read_stream(): ss->pagesize = 0x1
spl_romapi_read_stream(): ss->pagesize = 0x1
downloading another 0x9d768 bytes
spl_romapi_read_stream(): rom_api_download_image -> 240
spl_romapi_read_stream(): ss->pagesize = 0x1
downloading another 0x1ff18 bytes
spl_romapi_read_stream(): rom_api_download_image -> 240
spl_romapi_read_stream(): ss->pagesize = 0x1
spl_romapi_read_stream(): ss->pagesize = 0x1
downloading another 0x1622 bytes
spl_romapi_read_stream(): rom_api_download_image -> 240
NOTICE:  BL31: v2.6(release):lf-5.15.71-2.2.0-0-g3c1583ba0-dirty
NOTICE:  BL31: Built : 11:00:38, Nov 21 2022

and this works just fine. But in my case ss->pagesize is 1, whereas you
have 512.

Just exactly how are you booting? It says "Boot Stage: Primary boot"
whereas I'm doing serial download with uuu (i.e. "Boot Stage: USB boot").

It seems weird that you even end up in the is_boot_from_stream_device()
if you're booting from eMMC (which would explain the 512 byte page size).

Also, the prints above reveal that the download of the 0x1ae00 succeeds,
but then we enter the function once more, and for some reason your
printf() gets cut short; in my boot, that's for fetching another 0x1622
bytes. My guess is that the board hangs because it tries to download
more data than the stream can supply, due to the rounding-up to
ss->pagesize. Can you try with this

diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi
b/arch/arm/dts/imx8mp-u-boot.dtsi
index e54df1766fa..4b5e9ff466f 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -100,6 +100,7 @@

        itb {
                filename = "u-boot.itb";
+               align-size = <512>;

                fit {
                        description = "Configuration to load ATF before
U-Boot";

so that u-boot.itb is extended so it's a multiple of 512 bytes?

Rasmus

