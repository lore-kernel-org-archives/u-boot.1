Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CA7C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 11:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E64882CB;
	Mon, 13 May 2024 13:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jEWwtkoM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD45882D5; Mon, 13 May 2024 13:10:02 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F2A882B6
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 13:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSaudFEivMPPY1GcM/H1ETvk1OR2UsKPE9l2gDYNCO/FCcjdeYseL6hqkax8x3mE2bLfHIqWwzM2qnZtnDzn3D21JqwvuFTYatWs5CrvhjxPZu3OU6mdtWQfotnHbOYWDcayFuPYl5s+LO3AlDnkSQalChJ6A/Nv2dRyPAF+rYISrU5s10dTi3TXqeWoOj7UA1Phqw+5423co+Vvpupn5H8Lx2rxrcsyuUq0ccqs+22wIpOCR60sS+WTk9odJJ7yK9a8P4C697QWt8DOeFd3obY/FdMmFv5s+CriUbeOIA1A4pxAyM2PGvqHN4YZLvMo9NSDF4V8XL5/3kCPIOx5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWmFLEU7BNnOH+Hzayfh0htmLEzXAA0kUqXmEYdPSmk=;
 b=L7dS1JBbEB8TA70XYuMzNupxY5p+neJsJv7awHl2X1qe+GUVqeXKTMTklfmjCAMzCIsJyjwtmwHOIvvmzwDNVnpjBFET6x8HmhtNqqOhXQcNFZuuyLqwfgv+txC8UoqflQDarwnshOFGSkVpAE1+Cc7TgifII+tGD20jSHeNQr9K/MCPVsooHfwEAKSrrQHvqmNpefJfenyj4GoGwAd+WiQ2P1h8bmaWjKWxmcC7kT3yg/BK7C+ETM9axJHd2SUHy4lxiSs280b2Sup8wEN0GFsXVODhagHk4ORWyPb6/+rYc+2ZyuxfJq4ENF7GnYAahp/r2N8Mr6Ufu1yJmJ4wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWmFLEU7BNnOH+Hzayfh0htmLEzXAA0kUqXmEYdPSmk=;
 b=jEWwtkoMwC0PNBbWxb6S38c7xJRcpjItXFRMMxD+bbQdjoWJfxGt8/XjL+1Pc1uP5an+Lf3WZi0lCXZhff25qWQHblUhSUrm0rang6uVXYZFk3Fvoi+6GcClEIx9Q7JbMTFhz7EpdwXecDc7U+gElvhhAQ0dyZ56X6vU8DymAis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB5794.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:61::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:09:55 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:09:55 +0000
Message-ID: <5a406521-a1a8-4e51-b9f6-0cfdfd304667@prevas.dk>
Date: Mon, 13 May 2024 13:09:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wdt-uclass: prevent multiple cyclic_register calls
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
 <20240509004714.1394547-3-rasmus.villemoes@prevas.dk>
 <16a0c385-8293-42da-b56d-0122fea46d2b@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <16a0c385-8293-42da-b56d-0122fea46d2b@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: f533f69b-f6ee-40db-b414-08dc733d37f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUJGVzUveFY1OGg3SktkUW1DU1NwNTRlaUlrYlM1ZmdZckJqU09PSE1JNVgx?=
 =?utf-8?B?TVAxYzliSld6M2o1dDZCNU9wZklpMFptRWljM2cxcG0rL09hMERSd1ZFU3h5?=
 =?utf-8?B?VVdyakJSZ3BSejVjanorMkRFdmYya1hTOWt4TUZEdUpJNk9PZ1lnejFZRkRT?=
 =?utf-8?B?RTF3b0w1RXBKejgzODlxV05uZDhLV3pPc2NISUFUL3pEMUxqS0JoNGxvK1pV?=
 =?utf-8?B?MlBDUlVnQ3VZMEZScGJqbE1rS243M3NJREo4N2p1QlJxbWdsT0VOTEhaYkc1?=
 =?utf-8?B?blRsUzNpOWpSUngwK2JMWnpVaXZGMzg3YzlLeC9PZUFqS2VaUE5aR2owWWlK?=
 =?utf-8?B?RGJVRXVrdzVrNVAxNDdkdjduSmRwTUx5Q3RxOXllT1pHVWd3TWgzOWw4Q091?=
 =?utf-8?B?bDdUQlN3M2FsTFRVdkxuSHZZMllOSEthWnFWVHA0QjNlM2RVYUtsc0s2bm9C?=
 =?utf-8?B?ODUwRmxkZk51ZFlidDJWQm15cndQZHpkcEdrbjRXUTJTeGl6eUpyWE9hOFJt?=
 =?utf-8?B?cFFPOWZUanFwdnEwNThtSzVaTVZuUFNEL3JFMWFDSldsQitRYkRyem5MT1Ba?=
 =?utf-8?B?OHdCUmJiNW0xeXZ2Si9GSzRLb0Y0NC90em15NmZ3dWVPdXdlbkVNMHFtclN0?=
 =?utf-8?B?VWxrM3ZkV3FMWXNJRURnS3hUemJpSnNoMnhSaWVmMy84NCszcGFrdjZ2T0RM?=
 =?utf-8?B?c21ldEZrZUpvTElrNzlKRHRrRFZQYzRYeHIwSnhyR0kwTmVQSVFDZkxBYTVk?=
 =?utf-8?B?bXY3bG84dWVTWXVpaDI2YnVEYkdpWFpMTVpjSWlhU2ErZVVqOFhVUWpuUWFP?=
 =?utf-8?B?Z2VRZWoyUzA3QjJSVmNzTEN5OEpJSldSTjM4Vy80N25NbEhQZm16MzQxU0tO?=
 =?utf-8?B?UU5iRjBrS2hzdDRBWnNSaEo5V2VPdXMwa2gzc0RlQmdKSVJNMVVPYWw4UnlB?=
 =?utf-8?B?djQ1THQ3RFNHZkV3YjkrNkEyTW4vaFJWWnViS1p4U2ZBWGMzYzRadkxYeitB?=
 =?utf-8?B?NGVnWnp1QUI5MmFVTDNEYU1YdGI2ZU55NVBKMWVnc2tUb1IwS2FIWVVQLzRO?=
 =?utf-8?B?KzkyQkY5cmVxbjdZekdNdzJ5ek9wZlFyWDlwN3d5cVQzQURnZVY4T2R3d29V?=
 =?utf-8?B?cjhvaG1TbFFlTk1kYkk0WWtGME8yYkNqVFFESW1Jc3lLdXNsZTJzUGk4NDcw?=
 =?utf-8?B?VERsRGV2SjdnTE5mRDBMbjFaZzhCaWFyNjFzcVdUTTZhaVdNeTliZ2d1SXVq?=
 =?utf-8?B?OFRSbzNVM3JwTk1QYVY2Z1RLOCs3RlYyOFVPK1lFbm9WckhMSXpiRDBUZHdW?=
 =?utf-8?B?M2VTcmRBcCtGc2FFWWo2cjA2Tm5YU3FCaGxHZ3MvS24rMS9Fcm5ud0U2U0Jm?=
 =?utf-8?B?aW84R013Rjc0MGUxT0VmdElPMnJWaWlzZjJLQnZMbnBiUVVQUzZmUnVDQnhq?=
 =?utf-8?B?d2Z3WHRGTXl0L1EvbktMUzVvNmlkSXVJNHhIZEtOWktOeUtlZEgyM2RzVTUy?=
 =?utf-8?B?SjNlVTVhdTk0L2thSkduSlh6OHJ4aGp1NTB2b0o5WUEzSGUxRDdyRUFNTzRT?=
 =?utf-8?B?T0JyQ0s5Z3FqZWhrQnQwWDlKMkU0bldwT2l4cGZYNWZGUEZQVGRKL2VnR3kv?=
 =?utf-8?B?Y09TazcvK2lQMjU5Tmo3UzdZKzJ5NXZxUlZ4NC8rMHpLQ29pTmh5b0gxR002?=
 =?utf-8?B?ZXdRZUp3R0E5MWdxZjZxQUhEWDJwdjMyb1d3enE3S2xKMzYrVTlKTFV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2M1RWl3djZPVWdHeHkvSzBPSXdtRit4Z3FGRW4xQTllajcwRkZmZ0pTU0ty?=
 =?utf-8?B?a0ZySWI4VWJaWWNIYTY5cnNxRGYxUjZMVWQ0ZVl3M1JjZUtvc0V0cHpvdW13?=
 =?utf-8?B?Nzh1SkwvcWRqbnBMRUljMmVOaVllbUUzaHRBNDMrSjhHT0dUV3MrcmMwcDlM?=
 =?utf-8?B?SHNkS0Nkck1nWmJkaU9INjRVajg1ZnBaMmgxZHd2WFp6SmtQYy9CY3k4T2tH?=
 =?utf-8?B?eWVQU1J6ZWREYlFnNDFES1ZndzlRd2lnbW9EWXdJd3lWbk5FNmM0dDRkTFFG?=
 =?utf-8?B?MDZubU9GNEljNHNUb2xhL2dBWjRaQ0NrWTJDUEhsRm9sUFF6MjNRWE9GOElJ?=
 =?utf-8?B?ZWxtemVPRHpTcUlVMTUrWGM4Q3hoRnQ2V1h6b2U1Tk91ZjBGYWF5UEJuYkdo?=
 =?utf-8?B?amRpeVJDQ2N1eHd3K21aT2ZDR0ljZTJEUkN4czlSK0hoRGdkemJJMFdvejlO?=
 =?utf-8?B?NVIyWUFxU1RjQTJuZGxJVnZWc05IbHVtUkNEVExOZ1ZMdmlhYThPNXZvWDdr?=
 =?utf-8?B?bjYwSldtam0vbytKY1prbWZBZitqYUZmdmxGQnNkQU9BRjVLVEIxRis5TmZD?=
 =?utf-8?B?ODNKMWpCODhXQ3JxWHhTSkoxcGlTLzVLbFBuWXY2dVdUREV0VzZvWFIwSmg4?=
 =?utf-8?B?dGtISlFkSWxZem9NRzNLem5ITjBhY2pVTUV5M1JPWXFVWFpGZ1ZCMVdjTWpQ?=
 =?utf-8?B?bm9oemZRQ0xQZjF4N2V5NEZrc29WdzJNdi9sSFBrWHhEajViaFIxSWFaSVZH?=
 =?utf-8?B?Q2hvRlpIRnJnb2FORDl4U2psYUZSZ3hVcyszRy9TSUVGellibU9iYWpLNksv?=
 =?utf-8?B?RjhiWUYwMU5EVktDcEU2dGliSC9qblVWc2M1eGRITURZZjhqeUhrbG5tdVZM?=
 =?utf-8?B?OGxqY3NWd2ZtYmhEaThQZEdQU1llajJhTit3TVJuUytSc04rZEtzY3ZjdXFa?=
 =?utf-8?B?OFFJMldFMjZQbytTc05rVXdzVGJER3gzaFVlUFl5TmIxNFpQTHVGeVZkR1pW?=
 =?utf-8?B?VlJXTm9TdkoxL0hqRU9aUUtlclZneThYUlJmL2JOU2pzZnlEVGJOeE5TaTZz?=
 =?utf-8?B?TkQvV3RtaExjQ1JPQ3FkdGxZTXIrZXNrQnZxQ3VWd2RLb28wYm5abGplNTJj?=
 =?utf-8?B?aDJRNjNjcWRvUk8wME9MMmlSQXg0ZVc0L0UzN21xUG5rTGFicm1PK2cySkF4?=
 =?utf-8?B?UzRRcUNVWUdTQVhYdXlOSnNWWmxyQ1FjMjRDNHJoZldGNjF0VW9QMkN3cy9S?=
 =?utf-8?B?SzZOYnB5ZGZuTFFmVFBXRnpVQUJuempjYnI5SGJLQlZESmFHSmFaU0lEcFNs?=
 =?utf-8?B?by9YN25Gb2lXNGlqMTVxWEk5RzErZlBJM3pkUE5VbS9GbFFHK081SmZlVVE5?=
 =?utf-8?B?ZG56TmlQVVZ6L2o2OENzdFdwdGhhak05a0NGdGZyUW5oWjJlSWlzTTlJZEg5?=
 =?utf-8?B?alFmTDE0VDljd25oRGJBbTRha3U0RnFLNENPYkN0NFV5SmY5RXkyTlVsby9z?=
 =?utf-8?B?R1BGN3pnOHI1K0VZOUFUUmlUZ1NoOXNOeUduZjQ5djZPem9lWkhVb1RBTzlL?=
 =?utf-8?B?YlJvU05weUcxU2x4bEc4dkpzaUtTUnRPRE9RTnM5Z0NONXk1MHc2TGRldWZh?=
 =?utf-8?B?Q0x0ZGlIS2lzRlY1OVRpSzduNUNlMHNIck9xSUZuZEIzR3BrS0VDY0p6S1dN?=
 =?utf-8?B?UVlWRHdkUHo2S2ZUWnByQUhML2RFZU9iNEJJZDMwTE9BRDdVbkp0MWplOVZT?=
 =?utf-8?B?YkF5OE41aXRacTNOeVEzNFJ2S0JpRkFSWjl4MlByaG9MRFUybU5LNlkvdUdB?=
 =?utf-8?B?YjRMTW8rTW5qMVZIYVE0VGplaGY1bHlyOFJTQmFrSllUZ3BPQ0JTRndlS2dP?=
 =?utf-8?B?ajluN0FpMk5yUTFwUVRneGlVSVp5VEh4TU5SU1pRNlJnbTI3QkdqYmFMZXBR?=
 =?utf-8?B?YVh2c2ROU3kwSDRnYXFqdWZoWVo2TkpudTMzVlBuZXlyU0lHVTBxMUk0SzEr?=
 =?utf-8?B?TVlWZk1QWmMzZ2hrZDZ6eFcvR2dwam5vaWRNc0pRSVNSRGRpMnVpbmVHSU1J?=
 =?utf-8?B?US9TdFJkeXlURXV0TTdOdFhqakpsUTRIM3h3d3ZGM3YrbUg3Qi9ualM2bWtM?=
 =?utf-8?B?Mno1YlZlSmR0QTB1bzE2TGEyQTNldFpuTkRxb01ZSDZrMUczYUJ6NG5sbkJi?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f533f69b-f6ee-40db-b414-08dc733d37f2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:09:55.0200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1vE3V5cwEx3hsCKqUaKHOWAWqAHZ4bsHasMTUaJ1EIGXgXxXZcvUtIkG9MrJzre1jpX9FqJsPu+dDETA5nWhTW6jg1yE+O1wWRZXoTI6HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5794
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

On 13/05/2024 12.40, Stefan Roese wrote:
> On 5/9/24 02:47, Rasmus Villemoes wrote:
>> Currently, the cyclic_register() done in wdt_start() is not undone in
>> wdt_stop(). Moreover, calling wdt_start multiple times (which is
>> perfectly allowed on an already started device, e.g. to change the
>> timeout value) will result in another struct cyclic_info being
>> registered, referring to the same watchdog device.
>>
>> This can easily be seen on e.g. a wandboard:
>>
>> => cyclic list
>> function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
>> => wdt list
>> watchdog@20bc000 (imx_wdt)
>> => wdt dev watchdog@20bc000
>> => wdt start 50000
>> WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
>> => cyclic list
>> function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
>> function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
>> => wdt start 12345
>> WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
>> => cyclic list
>> function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
>> function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
>> function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s
>>
>> So properly unregister the watchdog device from the cyclic framework
>> in wdt_stop(). In wdt_start(), we cannot just skip the registration,
>> as the (new) timeout value may mean that we have to ask the cyclic
>> framework to call us more often. So if we're already running,
>> first unregister the old cyclic instance.
> 
> Thanks again for all your valuable work here. I do have a question
> regarding this patch though. AFAIU, it's a valid use-case to enable
> 2 different watchdog devices. And this patch will prevent such a
> setup. Or do I misunderstand this?

No, that shouldn't prevent enabling or petting two different watchdogs
at all, that should work just as well as today. All the state I'm
looking at and modifying belongs to one specific device, it's not
wdt-uclass-global state, it's wdt-uclass-per-device state.

But with the existing code, if one calls wdt_start() a second time on an
already started device, the existing priv->cyclic pointer is dropped on
the floor (it gets unconditionally overwritten by the new
cyclic_register() return value), so one gets the situation that the same
device has multiple cyclic callbacks registered. Also, we're not
unregistering the device from the cyclic framework upon ->stop().

Today, that's "mostly harmless". It does mean 'cyclic list' becomes
cluttered, and is a memory leak, so you could exhaust memory by doing
wdt_start in a loop, and cyclic_run() ends up doing extra callbacks to
the same device (all but one will be no-ops due to the per-device
rate-limiting of ->reset callbacks). In practice there's no chance of
memory corruption or other failures. However, that changes with 3/3,
where it would be catastrophic to call cyclic_register() with an already
registered cyclic_info instance, as the hlist would become corrupt. I
think it's worth fixing regardless of whether 3/3 is accepted.

Rasmus

