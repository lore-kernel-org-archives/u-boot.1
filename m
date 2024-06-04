Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68A4C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 12:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E93882AC;
	Tue,  4 Jun 2024 14:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PiCdaFZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B429C88418; Tue,  4 Jun 2024 14:22:54 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C90E87C69
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 14:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li/DvTW993sxSqkmnKostEVJNX7r51vCw9pcI1mhHdVJCEIbV2d6FxIFJvtZwg22YK9CrXmO1qhTuL06b25ek2m5rLBXborOk+KI1XBKv630KubkvyiumyP6NgCa8AUA3qY+cvn8l53zi0u8m4bv6GBtajpdse3+/5zwmxzKjGYzBI8TxHrIxzCTH0WczXJAPajW4e5oCl3+uEBszSmb77wmfZ3CU8uVy45Uq6CqbkjQybp/C6jBhtXfUfjhpr9W8k1yZfkmkpefurKm8YFsAItqwyVQTWGt8EKGkaV5wQb1NrItltyi83rfbsI1Q8o0abPXXBMCejAU3FDa8Va3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/u+/lzCgpzHEs9EeIfZaW2aS/0MZTNOq+M4HoB+dGE=;
 b=R1hbkMVfxOoOtklBslXl86bfQB7vpGjxH3DE+P01PhmYgLfvYSUBVGAwdJJFrlyocQG/3YqSD/FnrRHOD8ukXZTmkRsvFuId7lw/pOuruZAACfoaxPyY2uTxit1RmygCOGj952od7bl9CfNRyKgPJjMGBz98GAW+3QsySVQR0DnRfKONJUtpNILHQVZ8utlabM6KEscXi1a9rogGoT8iveYzF++ZFlM0tE/33cTQ+uhK7uuFhLkZMsGyFB0ataUiBmFAotSMXKpv9AOOou60Ontgw+L/qvPQsLlC8uw7al8v1KgEKXVtNhDj+AjVRSpEFmT2CCXqxB3JFv1s12do0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/u+/lzCgpzHEs9EeIfZaW2aS/0MZTNOq+M4HoB+dGE=;
 b=PiCdaFZ/+32uU0O1Y2sTybvYL1cyt5qfkhxNlqblx3XEby7Fk2n3wp6+95sXTYHv9GKrNTQ4XTa2v0wHOH64hZweVGHUBYszb4+YJ0mm/rtuexKE+mmgU1IozU9wEJVBLCcXqP0ohdNar7o4CNI+r3wW+FzPS2aIo+SQBjJIjL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 12:22:48 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 12:22:48 +0000
Message-ID: <a57a03d8-5e45-4ebc-884c-9626a03c6aa9@cherry.de>
Date: Tue, 4 Jun 2024 14:22:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: Fix a handful of doc typos in bootmeth
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com>
 <3bb636fd-39b7-472a-8715-e306dc8c3ac7@cherry.de>
 <87wmn429sw.fsf@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87wmn429sw.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: db89c53b-a93a-49fd-02d7-08dc84910b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnRQVW9oZVBJNmtWQjdpTTRydzBIaXY4Um95QlI0blZUamhBQUQ4ZkZVd0hp?=
 =?utf-8?B?TndWemY3RU9oczI4V0dFSmhRL04wYXFSc3BORmt6aW9GUGJsTHpGN0hIMDJu?=
 =?utf-8?B?Vnl4R3ZySUhFdVoreHJEazgrQzJSZGZtL1IyYXNGSU0wNktUQzFuUEw0QXpu?=
 =?utf-8?B?MGdQREVmbjBIM3ArSVRybmFsWG1lNVV6YW1IN1FZc0lKTFlROVdEUHpra095?=
 =?utf-8?B?L1JTMVBWVCtuUFMzOTdHWm9ERFF3SWRKR3RWbGJiL0hHbUtKS3hFcFRjZGkw?=
 =?utf-8?B?L3FvN0txamhRS3gxMGMvZmNtb1lSbFA0bDNjMmoyOVdnL3BGSFFVR0JXTldI?=
 =?utf-8?B?amp2bUJZWnU1cWNVbU8xWnRSU29nTitKaHN2SHVLRmx1eG1ndlpYckc3TWJZ?=
 =?utf-8?B?S2hCVE8yZUxaU0JTdjJUb2RUQ2NFb1o0R1RobFVQRjYrdTBLK3F0MEI3Tk5j?=
 =?utf-8?B?dkh6LytJdGZoWkxaNkZuVlI0QzNsTm4zdHN2RE9FNlJ5ME94aW9ucFQ3RnVF?=
 =?utf-8?B?VWFEell3bk9kZFpWSS9kWG8xVDBrWUx4SERSQ1ZoaGNaaVdueXJYT3FadDV1?=
 =?utf-8?B?U3lmS2ZsSC9BUkFTbEg0dUdpOW8vZ1N2QTZkTFQyS1N2QnZocHZTd2FRTkky?=
 =?utf-8?B?WDNCK0djRnJEakRzQ09QSXYrbXI1a3NtK05uYkRhR0hrM2xreGcvd0g2NUkv?=
 =?utf-8?B?bGJnUzVCenFCajJkcHpFL0hXZzFiKysvNVBQdGZyMnNlSTJDT3NrbXJ1VE9w?=
 =?utf-8?B?V0tlME9veHF1NUE5dnBxaXZHMzU2aFV5UVJIblN6cG1kMzJET1RaNy9SUHJJ?=
 =?utf-8?B?eVZlc0h1S3REZmZQUG4xaFp6SkYrUzdsbXJDY1IrTEIyeHhkb29QbnRkMjVj?=
 =?utf-8?B?Qi96ZDdWUi9YUEs1V2QzUUR0bGpBczl3MC9nOXN3bU1ibHN6QnBrbUdnT283?=
 =?utf-8?B?Z3FYK3ZoaCtPcExKYmNkRzhzcUtxYUpvZGVLeVR6Rzg2dTgvQmJ6YUFYUndl?=
 =?utf-8?B?SFRWWDY0Y0dTWEoxRVFFMGRpRkp6U29ZNXF5NUZJQVZkbU40Sk5TMkJMVmZT?=
 =?utf-8?B?eVE2ZW4vcUdPb0FwMlFTa3lDU090ZnE0ZUwwRDNYamJmRGZLaFF0M3NXdUVu?=
 =?utf-8?B?WE8vUUR6NWx0VHRVdUhYV3BGRDRVZkt3eHhWRjhJcy8rdWZNU3BtKzRjZ0ZY?=
 =?utf-8?B?MG1QRFNMQU52cUp2Y2VWc0xqSWdVLytINmNQWTBxNEJyU3lIc3FVQzZQWnVM?=
 =?utf-8?B?RTJYc2JBZU5aRjgrQWdkZ0xJd1pyR21nNEx3MkFKZFk1UEoxK0dFUWtuT3o1?=
 =?utf-8?B?alNyZGNqV0cyOW55dWNndkFLenFZWEFodS9aaHRjZXZFWGRYWmhzZTg1cFNr?=
 =?utf-8?B?bjFGSEpFQkduZE1iS0hrdjdNbWI0RWlvM21vWThidktqcDZHQ043SWZLNGFN?=
 =?utf-8?B?U0s5eHUreGxHcFpZK05lTzJRTzUxT3l3R1V4UkN4emg5bXd3RCtSRUVCOHBR?=
 =?utf-8?B?Q1JzajgwakFDWUptUGhJdGxDb2xHN0ZUYlBJc0FlaC9FM1dCZVpBQU9EYmJu?=
 =?utf-8?B?RzNZV210TlU1RFcxT0FONkJGWTlqaXV5L2JjZEZJSnVrMHZmdjJIOE1vK2g4?=
 =?utf-8?Q?FVzyQTIe6EisEt1wnoxFqAC3RTYfR7IkxE1W+oFXzWrY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnlXV0FvdkxZa2xiS3VXOTZjVGkzUS9lcmc4Z0xnZFljQ2JaVmg0UWljOTYz?=
 =?utf-8?B?UjhLNnFyd1NxUUNtK3I0dnhCdjlJaWpueGgxNDRzRVF3Mm15Wk1sOW54ekZu?=
 =?utf-8?B?WmpSbXBweU1mSmtrb3Q5Vmpuc3JYMlkrcFFrc1lRaER3d0ZubXZVNE9nb29I?=
 =?utf-8?B?Ujh4Tlp6NUNXS0RTb2l0cjJHQnNxYlVDRGJrVDBkZXU2NThIM1QrMEgxUnRK?=
 =?utf-8?B?aG1YMGVTZm5aNWl0ZWYwaXA0Tldyd0g5N3hFb0Z4RWpESkhOZlE1azFnTFF1?=
 =?utf-8?B?WEkzVFZ1cjRwVXh1V1ZYUUlvNklNL0lCZy82azI0YjJtK3I0dUJEa3dla01m?=
 =?utf-8?B?eWZkM2JickxvSDB2WDhPWVFrenRHK0xhVS9aQStXYnB2ZUdhTTA4UjQyU0RC?=
 =?utf-8?B?Z2tCMGg3NWRwSmhCcGljOVZFeXJqd2tZYWRaampTU2pJZStLcFRJTlV0c2JB?=
 =?utf-8?B?cVpyMVhlZ2wvQVN5Mm1zdmtWT2UvazlEcXh5SmxTMVpadlY4SHRZRVdkcm1x?=
 =?utf-8?B?cVZSc3M1Q2xiSUEzMVMwek9yVTI0MkFyUHVOOHJqSmxkaHk0K1E5Yjg3L1dz?=
 =?utf-8?B?R3BhSzBtWlhMVSsra3hZeWUwbTFlbEpJY25rMXRBck8reFg2cnRYeGlGc2hi?=
 =?utf-8?B?SEEvWWdEMWpSaE9yMy90U0NrVG5GTVhjcjc5SXBmT0NRNTY1Ykx0YjN3TUN1?=
 =?utf-8?B?cmhBK01WRy9MY2hQbFNycWJocWRwNlZBZDZMRzdQdHhTalM5Z3F1TTNnQVBR?=
 =?utf-8?B?dkhuZjIwTFdDWTlhRWtiVXd3cXBsYVNpTS9WZjRNZXVUQ25XZWdZSVA1SEZX?=
 =?utf-8?B?WnFMTk1QZkt5RmZLWjdJMTE4MXVIelY5T01iYVNjbFdXWnJoM1FrQ2dJR3c2?=
 =?utf-8?B?ZW1DbGFhV2h1VnFWU1hMaFk4SHZqV1dxRTFucitOOU56eXNzMnc4eG9Ob0Ns?=
 =?utf-8?B?YU4xWnFhVk1TYXlXTi96Z2UxUlE4YnVDNEhFTy9DelNWNmVmbC9kaVcxY1Yz?=
 =?utf-8?B?RXNyVmp1UmMvMDc2cm44ZjNlc3JHTm95NFdJcG1rTjdpVVdteTRNL1Uvcmlq?=
 =?utf-8?B?b2VkZVAxZkJPYkp0SityNzU2SElVMytHTjUrd1pURk41anZOcS94SG1jakJz?=
 =?utf-8?B?dXlBWGIyVkdObUF5Rm5BWDZ0Y1hjbVVvYW5NaERWMUlubmF5NlF3emp2NnRM?=
 =?utf-8?B?U3N5TjlKU2Y0VUpNOFhOV3ZwT0R3R3g3dSswZ3hHQ0YwTFZ4UzFNemVoTzhs?=
 =?utf-8?B?K0NhR3VyOVN0V2ZzbkZYVHlka0lWNFNOYWRhUGJUcWdMMDNaWmRDUHRPbHJP?=
 =?utf-8?B?QnlNSld6TkM2Z1JlS1ZLUGVINWRJSjRtcFB0RlRmTVArb3MzSVNZT0F2UTRa?=
 =?utf-8?B?dnBibWJLa1d4MlJzY2hNVFgwUTcrOVZRRWFsbmdnMWtXZFpGU2w5d2V0Q0Ji?=
 =?utf-8?B?RE5lYVl1bCtNU2tud3pMcG9ZZndVb08rRmpPMU5MajJJY3JuRjB0UkRCS3ZM?=
 =?utf-8?B?VWlyWmlGT1FLQXFDZ1VMTyt1cll1ajdlaTlNbVhyQ2NhWWVybFlRNlo2N0hw?=
 =?utf-8?B?MGloSnFNeFFlSFlxbDNqMlhobXJlV2tpeGxVampHRy9nOTJza1dQSWVXcEtZ?=
 =?utf-8?B?U2Fwa25GSHpEaVlPRUQ4YXREemlDeDRUNytrZ2c2N0ZmZjhkTEdhazYwdHZM?=
 =?utf-8?B?MUM2VTNnL1lhVUJEcXZWSGtuWWsrdVFTZUY1eSs1cXBHTjlDaWZuY2UxR095?=
 =?utf-8?B?TjMyNVRCUmhhVXhNdW51UXJ5TFBNUW9BcmRybWtEUkoxbHgwTWR3NVV1VGNP?=
 =?utf-8?B?ZllGSktZWkh5eCs2UG5oMG11Qm13SVhiazNDZDRKLzZaczBmWGdOSGp0SU91?=
 =?utf-8?B?eDNqcG1GQjVSRHRseVBLRVNuZG5MdlZ3aVhQM0RTb3FJS1libG82eU9rSzJs?=
 =?utf-8?B?SHBmL2tjbFRNbGJDd3FFOFduOFduajFlY0RhSkIxTWFMMFlWU1FxaUo2VkNx?=
 =?utf-8?B?Q3k1eXZ0S3ZiVlpRNjcxcDUzQjBCcnhkcmhlN3ljM2RkZW9HMElJRXF3WXhU?=
 =?utf-8?B?SnNQR3JqcnJBWFZGYzYrcFhiOVl5eUxRdW1yS21KV0VWU3pUODNBdk5YNGpi?=
 =?utf-8?B?bmZmNXRkVXcycGFmRTNEQS9sUTRobWFYSFp3YktWRzBsM2FWaG5nQ0QrMlZ5?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db89c53b-a93a-49fd-02d7-08dc84910b8f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 12:22:48.0623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU8h8s6TRV0G5dEoKwgnGAfCPsGZzNm2UotB8On8J4roJzt5zXXRPSG5fxeTtC2lJr3KyvU5gKVHym5JZNptHnvqOGW80JGVOZqF97PFg1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087
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

Hi Mattijs,

On 6/4/24 2:04 PM, Mattijs Korpershoek wrote:
> Hi Quentin,
> 
> On mar., juin 04, 2024 at 11:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Mattijs,
>>
>> On 6/3/24 11:11 AM, Mattijs Korpershoek wrote:
>>> Fix some trivial typos found by browsing the code.
>>> Done with flyspell.
>>>
>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> > ---
>>>    include/bootmeth.h | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/bootmeth.h b/include/bootmeth.h
>>> index 0fc36104ece0..529c4d813d82 100644
>>> --- a/include/bootmeth.h
>>> +++ b/include/bootmeth.h
>>> @@ -40,7 +40,7 @@ struct bootmeth_ops {
>>>    	/**
>>>    	 * get_state_desc() - get detailed state information
>>>    	 *
>>> -	 * Prodecues a textual description of the state of the bootmeth. This
>>> +	 * Produces a textual description of the state of the bootmeth. This
>>>    	 * can include newline characters if it extends to multiple lines. It
>>>    	 * must be a nul-terminated string.
>>>    	 *
>>> @@ -138,7 +138,7 @@ struct bootmeth_ops {
>>>    	 * @dev:	Bootmethod device to boot
>>>    	 * @bflow:	Bootflow to boot
>>>    	 * Return: does not return on success, since it should boot the
>>> -	 *	Operating Systemn. Returns -EFAULT if that fails, -ENOTSUPP if
>>> +	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
>>>    	 *	trying method resulted in finding out that is not actually
>>>    	 *	supported for this boot and should not be tried again unless
>>>    	 *	something changes, other -ve on other error
>>> @@ -151,7 +151,7 @@ struct bootmeth_ops {
>>>    /**
>>>     * bootmeth_get_state_desc() - get detailed state information
>>>     *
>>> - * Prodecues a textual description of the state of the bootmeth. This
>>> + * Produces a textual description of the state of the bootmeth. This
>>>     * can include newline characters if it extends to multiple lines. It
>>>     * must be a nul-terminated string.
>>
>> I see we have a mix of null-terminated and nul-terminated in the tree,
>> is the latter correct?
> 
> Thank you for your review.
> 
> I believe nul-terminated is correct: nul is the character, and null is the pointer.
> 
> See:
> - https://news.ycombinator.com/item?id=22283217
> - https://internals.rust-lang.org/t/null-consistency/16767
> 

Ah, thanks for the pointers, makes much more sense to me now :)

> I'll check the tree and submit another patch to fix this.
> 
>>
>>>     *
>>> @@ -244,7 +244,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
>>>     * @dev:	Bootmethod device to use
>>>     * @bflow:	Bootflow to read
>>>     * Return: does not return on success, since it should boot the
>>> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
>>> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>>>     *	other error
>>>     */
>>>    int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>>> @@ -255,7 +255,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
>>>     * @dev:	Bootmethod device to boot
>>>     * @bflow:	Bootflow to boot
>>>     * Return: does not return on success, since it should boot the
>>> - *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
>>> + *	Operating System. Returns -EFAULT if that fails, other -ve on
>>>     *	other error
>>>     */
>>>    int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>>> @@ -264,7 +264,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
>>>     * bootmeth_setup_iter_order() - Set up the ordering of bootmeths to scan
>>>     *
>>>     * This sets up the ordering information in @iter, based on the selected
>>> - * ordering of the bootmethds in bootstd_priv->bootmeth_order. If there is no
>>> + * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
>>>     * ordering there, then all bootmethods are added
>>>     *
>>
>> Shouldn't this be bootmeths here as well?
>>
>> (And there's another occurrence in boot/bootmeth-uclass.c
> 
> There seems indeed to be some inconsistencies around bootmeths versus
> bootmethods.
> 
> To me, we should use 'bootmeth' everywhere.
> 
> Simon, as the maintainer of bootflow, do you agree ?
> 
> I can spin up another patch to fix this.
> 

c.f. https://lore.kernel.org/u-boot/20211023232635.9195-1-sjg@chromium.org/

"""
For version 2, a new naming scheme is used as above:

    - bootdev is used instead of bootdevice, because 'device' is overused,
        is everywhere in U-Boot, can be confused with udevice
    - bootmeth - because 'method' is too vanilla, appears 1300 times in
        U-Boot
"""

SO I think we should change it to bootmeth(s) indeed.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
