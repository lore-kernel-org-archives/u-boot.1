Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50828C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 07:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBDD879D5;
	Wed, 25 Oct 2023 09:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Gh1mLVwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE288718F; Wed, 25 Oct 2023 09:59:14 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D378287A66
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFAr40E6KGFWV5JHXfyiWSNlpAWPhufiRw/pN2rX8rNkASUdg/7PW5NVBS0CZWCYEg7pN1Tair4B79qZ5P1Pqlum2KiVwNeYmFzSqYwqJoPmLIL9BU+wUwuPndXu9S+19QhRUhPtKCDq0QiQV5M2fzj+EmF4+k9lzFPt3v5kNb2vlYJJiHiuHBlWYDWxssyuzHn+mvD/9zHWAM5MiBh9MMDbqEfC0H8ESL5/DaL1comlbL73FcRitItBI9dKhf0VGcBTPIOASXgqc6M3gjVQPS0bUWW3GWZsU4p1tE4oQ/0ayF2bkqXMQNUMdBqAo8zslQjlYBVP490hdRYA7RDj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM5f3MQbyp5mWRU8frOep3FAgGsOWhtnijelQV61fQE=;
 b=DKamK0y+o3IjZSds3bQA2LUy5n93Svm2whzmwKmSB55CICOqki3XFCaXAlLfehxRPIF46sVA6ExmOKET+jcJAiQ0Ga+DuKYhFQOrVIw+U1w4l11sgGBH7Bu7OKSEL03MI5MERmCzJSb6t6K/SEUPkK387UMWqE77CJNYwjp+PZ777R9jDQVp3+0mpANYHmTZ5STTAh3S7iPJCtBno7Sk1MWT0lKlH3Kli3RdGQq2sPXC5SIKtnTxW6WZkov5v0siozEwCiBfMceDDdQC7cBB7SnMoWWuXNLNRKxwrhBPWcB6J/sChRaSCTzK+u7Bn5u6tjKYlz0SSTXSxjDiaUcHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM5f3MQbyp5mWRU8frOep3FAgGsOWhtnijelQV61fQE=;
 b=Gh1mLVwjZoQEe7xXgqYmjWWS4wQJBJRTOmgv0pvlNAT8h0qWQwfK+WvfFWb4Nik3OireZTZcpW7agvnpqGDxbjhwM3hbDPoZZsZGYNj2NhUD9XVmCnAqFVXsA3DJrcMFRoLlJ6KKPZ4NnenLqvmnGIcSpdl44gJ6tI0hj+Iu5AU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB8242.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 07:59:08 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b%6]) with mapi id 15.20.6933.014; Wed, 25 Oct 2023
 07:59:08 +0000
Message-ID: <15e3f937-48ac-4d52-bf16-acac9f31f715@solid-run.com>
Date: Wed, 25 Oct 2023 09:59:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cmd: mvebu/bubt: move eMMC data-partition uboot from
 LBA-0 to 4096
Content-Language: en-US
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, kabel@kernel.org
References: <20231008124621.18803-1-josua@solid-run.com>
 <20231008124621.18803-3-josua@solid-run.com>
 <42f08b26-ad20-4edd-9e70-4e2d676c7f5a@denx.de>
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <42f08b26-ad20-4edd-9e70-4e2d676c7f5a@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM9PR04MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9399dc-c9f0-49a7-4aca-08dbd5304482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvORpi3Ovd6BDiNmMrTASoSoodEu8N2X09VjbDPqgqRdemStMPpa93hRBlA1lzKfnfQqfIOj6PRNzxA6YxjUsUGNxRCCaNZlUyGxLrg9YdPplad9U8GmFi8qlpJmp7Z8l4HdzPNuNHPGz++VJAAl7qEgPm+DUo3OeFtzhLTGBBRgsUpPJiGgFPWCdWuiIzUuTNUm9HyiwpkRkgGzLTClH5cY+dyzqgkJrilZj/tTvFGz8gHNQb06UHugPrhL/FHXTS/+smnqXchd0kKdeS3DPxAJD5wdpUq5u2o6BUBPYXksOVJJNvvIbLJdrKpKyTalNWJsQXNR9Vch735Nd0jrjxSywJ695DICtrYBzqb5nnecIbWZpwnM+8v7Y35az9E0S4qMQh+kRMGzA3/BooT7dMaBQ6xbK2U4fX0EJiLESIJNM5wsAxc+mGORTFSJ8fQLM9jEu/m+QG24X88A3uYAV8YsQWUwY/T/Om+MvrawnSrm1xVejI8jJ55VcTMGvi2vUR73k+j1fX8pxIgNKwLm6yu0huMKY04LogKo+EV6pTol5vMPWgk0Zw/IXdNL7GC2ovH++romrz8MGHnUHaWnYvAr5RKUZOqr3N6DYLAmhoz2NLg5Vjk2yeF4zgMV76a/M8+xLqckQBzqF0t+8wM8+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39840400004)(136003)(376002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(5660300002)(4326008)(8676002)(8936002)(31696002)(2906002)(4744005)(36756003)(86362001)(6486002)(478600001)(31686004)(6512007)(26005)(53546011)(2616005)(6506007)(66476007)(66946007)(66556008)(316002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NmRUZqcnZzaUVXMHFOTWF6cUR5VS9rcFBraVRoVEhJbit1bSt1R1JJejFi?=
 =?utf-8?B?dmxVNlB1VlE0SDEvM3ErR3ZjVFpORzFtMTd0bGIvb05Malc2VjJHOUtCMWwy?=
 =?utf-8?B?ZlRScW5RWm5nUGF1Q2xRb1Y2UHViN2VqeDQxbE5zdCs3Vjg5SjZYQkFyTFAy?=
 =?utf-8?B?cDE0dVBKWmZkVDMxalFQc1lzdVdLYU5raDdqNHdBVFVhK01WWmJ2K3hVeE05?=
 =?utf-8?B?M1ZIQy9nYnMzU1RYYTYrbDdPb0JzaVNRdkhmTW9CNGdMS2RNT0dydDhneWND?=
 =?utf-8?B?WHFIZ2lyUU8vbGNrT1VGM0U4T1AzRGN0Y2J4UnhmSjgvMGFleW9PQ21nblZF?=
 =?utf-8?B?OVR0MTEyTXFjbEZiNlBYd2gyd0gzVmxJVEUyMXE4YVpWamR2ZytNVHRxdi82?=
 =?utf-8?B?ZC8xcjBJRjY1L0ZZN3lKMTBFeWlmSkEybFc1VHFPRk94dkxObC9xL3dNd09R?=
 =?utf-8?B?aGIvR3JFRlBDYWVLQmpaOGpmYTM5WUVQM2dSMGNndHcyaUJyTGgzcWtXQmVN?=
 =?utf-8?B?RG1nMGdJbFJidzVtTlJSeTRHakw1UXNhZXROcTJybVF3Y1g0SHhuWWIvQlNt?=
 =?utf-8?B?Und0SDd5eGFCZi9RT3lWK2NyYWV1VjQ2M210YWhYcVoxWEZoMmsrY3pNZ1Ax?=
 =?utf-8?B?NzFFVENPcW1TcHNwZmZmRkJTNUIvSWlyanovYUtDV0hrWWpnMHlDQW9lTlJN?=
 =?utf-8?B?azRIb3hKQXJiTjd2ZlJ1dnd4UlcxRE9YalJISnhVa1QyU3N6N3VEUmdSWUpN?=
 =?utf-8?B?aFhQSmRVUXE0TGpVSkRNeWlmOFpqa0ZMM3IwaU5Va2V3d1h6Z05UdUp2Nmpy?=
 =?utf-8?B?N0NsQkRWSUhnR3pFbi80L0N4K0dVVFJvVzNENCtHWnJ4RDc1QzFoMHkySFlD?=
 =?utf-8?B?bHp5WU82Y0srTUlPUHBvMktrNzgyZ0k0VjIzbXlla2wxejVuUzUvUmdlSXAv?=
 =?utf-8?B?cnowdHNlZ3hlU3hCbXprZVhyVXJ4b2MrbEttTVZMZENPc3gwY1VubmRFYTVL?=
 =?utf-8?B?OWtTcUl4N0FrL3llSHEwS2owVzRRcUhnSnZFTkJmOG5IOS90YkdJNENUQ0c0?=
 =?utf-8?B?S1BlVDNsTXYzTkd4U3AreXFxNSttaUhxTXBOTUdPSTFWZWZyN1BtaXQzc2pi?=
 =?utf-8?B?NGM3eHdmZmxnV1ZDcnJDYklEemNlRXVpUGV2RUc0WlU2RzZvYjZBN3RheVBR?=
 =?utf-8?B?U0FtLzBFQlZ2OEJNc1ZUU0cvTW1LeCt1d0s3SlM5TU9KcDdwTkQwdFFDb3Zi?=
 =?utf-8?B?R21lak1aaUlBTXJDUHE3dmpPN0YzRVJSTGtzQ1VRcXdHTk1aYUExbVJxNklZ?=
 =?utf-8?B?aUR5SXZHY3pPaFFjN2ZqRUdjazBDTy9xcHRKci8va3NxVzg1R0JacUZheE5T?=
 =?utf-8?B?ZWRyNytaQm91N3Z3UlFCU0dlTGJYajJmMm1Ic1prRlVSQ0VlSDR4ZDNHbHhL?=
 =?utf-8?B?ejJwa29QalcydmJMNTdOVGhoeUQ4b1U2bEFoSjhrZ1cxTU5YenJOY3Fta0o4?=
 =?utf-8?B?VVBLdVRhZ0kwVDVMdWUyR1d6TXIvUnRFUWh1UzRmNGRPSk1TVHA4ZmowUS9n?=
 =?utf-8?B?TWtSTGVlNW5LNVhybmZzS2hLTndzWW9FMGZvV0xaeVhnUTZtWnJYOFVqaEtR?=
 =?utf-8?B?d0UwMkY5ZVUyU2piSTJYSVV0U1gxN2YxSlgyeDBwVXhDQXFjc015U0VpQ1RW?=
 =?utf-8?B?VXhEa0pKcDNwc0xmNWZJRTQxQlYydXVncHZsZjRBeUtDaVBtanVlMTNKSm1s?=
 =?utf-8?B?WU12UGliaW5EOUhLQTBnVEllQUtRekFZT2J6b21RN2xDcTBPc0lPNjd5dUdS?=
 =?utf-8?B?dlFOZGZHeExOOGVmdTcvOVRHc3VrUWk5U1JiOFcyNTY0Tjh6elZTcjZLMTFW?=
 =?utf-8?B?ZkJKY3FQY0Nza0FhNmM2aDRLczhUOFFBeWgrcllVZ2ZSUDBFTi9neFVoa29z?=
 =?utf-8?B?ejRuTUJaejhZc0pZRHhtZnhBUmhJMUo4eVhrUzNjVDlLSnBoQmdJc1NkS1ZH?=
 =?utf-8?B?eVNvZkRLcWtkTGJ0QUVZSkxKdnVYU1NVVHdxQ3ZQSUFBVlhXcWpjdU1oekJD?=
 =?utf-8?B?dEswNEgrZ3I5ZzZHUTdUdmdYT21scmVjT3BVK0lyOE5WamdsczJ4akd5dEh2?=
 =?utf-8?Q?ZcahxBwkVp3pkxMTCEWfhiLEI?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9399dc-c9f0-49a7-4aca-08dbd5304482
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:59:08.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gal8EFzwm6YyOwx1mheMarx5GADt36ttd/Im/nVbeaoQA3c34gUiahO2XkQJmzMRkl87EHkcAeiuWpRlI1A3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8242
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

Hi Stefan,

Am 20.10.23 um 11:30 schrieb Stefan Roese:
> On 10/8/23 14:46, Josua Mayer wrote:
>> +    else if (!part)
>> +        start_lba = 4096;
>
> This patch leads to this error, e.g. for turris_mox_defconfig:
>
> cmd/mvebu/bubt.c: In function 'mmc_burn_image':
> cmd/mvebu/bubt.c:247:19: error: 'part' undeclared (first use in this 
> function)
>   247 |         else if (!part)
>       |                   ^~~~
> cmd/mvebu/bubt.c:247:19: note: each undeclared identifier is reported 
> only once for each function it appears in
>
> Could you please check and fix?
I will fix guard it the same way the declaration of part variable is 
guarded, and submit v2.
>
> Thanks,
> Stefan
