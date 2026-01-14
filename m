Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A56D38FEF
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 17:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1435E8063E;
	Wed, 14 Jan 2026 18:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MGodT2bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674A2808AF; Wed, 14 Jan 2026 18:08:17 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584D780325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 18:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLDD5KLmW6RkUeejMlnY0LT4mzzBeQ14LqZrXyBeAbYeLTh49nubZ+5lfcVmwJjB/rK+4JioTc2t8VSG4EDFywt8H3KoC0kWvG5NRtSwrG1lJrD6T9JyCuyaT212H0k83fUvOBvctoUJaKSkdymT9Sh3QS2ZxGlzYZ5jr0cjySaZ9WGGWkzDZQ9jo2mN+NXj4MrHEqeUVWFbPWBQOe/HO+jxH1kbbdeIISX8BpvzRyWY8wJtw8KksrDs6VOhzF0+gzAOi8iEgZ5rt/y3qwozsEjs/PhfY7cRCu7Jk4NPo4Du/bcJGQtqRzh2XfZoJi1lgNzOboEHXK6E4eWFQiX2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kOHE+SgrZjLG0EtNXNBEeXXyCr2wK578LPuILLPiig=;
 b=AWVP94InK654i6Do51NI9BVFo8yWimTzAxd7pNKCwR6DCCK+4fBgNfbvHbF+IGGmhhYyV6TcrTlj+PT9y07LanLWZsyFt1Y07fdksc2zWowaOzvVHRmTyoUJvVPH/H6LK+7wrDFk9OLp0UWqP8uSRKbKSKQzQNX+3JTwDa9t3QlYz+/AbA7W7kK0HBtr750eTbuqbDG1DmHxlmTA2UKq7ujiqwT7bJrTi7a1RgG0MKWfEVOgIYETI/9cK3zzYz5b4yZYolRzpRNRw6fKeyIG0Fudn8LAZREk2IOLxX5ED9iTlF3ldoKkH7S2+ApmutE/8y5RHH9YkyHaUTVCQm33nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kOHE+SgrZjLG0EtNXNBEeXXyCr2wK578LPuILLPiig=;
 b=MGodT2bnifTbErUa36CgzjkCkpGpQPbYDsdooHvOFIjBgmx9ebF1Mc8pOba/2i2lrNktssgV7gmz3Av//fjND1FfjqEECoiwPKCB9+Op5odV+NQ9TA+b6teKYiibeZMs8TEQeGcx0TvQ7ZPXBamX7tfDT6QvK/sU1zpEGS+iEp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:08:13 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:08:13 +0000
Message-ID: <a8a8dd8d-dfc2-4274-9203-a88d9bcb8a69@cherry.de>
Date: Wed, 14 Jan 2026 18:08:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260106203433.3133926-1-jonas@kwiboo.se>
 <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
 <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6b6e2c-54eb-4f2e-7e47-08de538f804f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1BESmhNS1YzUFhjV2ZldWcrUnR1eGcvZ0VrZFVtbUp6dVRqcnNRa2ZpSmFl?=
 =?utf-8?B?ZGRYZ0Q5UGUxRkhKQm5UdVl5Z0VHeDZobmFXbnNHVU40T29DWG9IaUM4SlIr?=
 =?utf-8?B?bU9jWENVdzF4VlJBaTJxZWVnTFowTzFQN2dTRXRVK0NVM01rYXd6V0FXSGZG?=
 =?utf-8?B?MTFYaENKbFE5SC9yUXc1Q2dHRk5Pb0p6STZ6bHN5cmlNOGxLcnJkRGk1a2wr?=
 =?utf-8?B?REMwTnBNUlBaQnMwQVJYZjZ1dmVyaElSWEF2OE1jczVWQkJYTWM1Wjk0RUZB?=
 =?utf-8?B?NVc2NmxmcE5UcTk3bTJoZXNaOENGT0pqbDJIaktxMXMrdG96b01RQmI5a3oz?=
 =?utf-8?B?M2VrZDlsM01DMjMwTmxtcUEwUE9RTFhXaUMzVWpJRE5kemt5M0ZKS0hKaWZO?=
 =?utf-8?B?eDY2dzNUWmdNMHpMWEtRU2cxVUlwdjVmWHdHSk1nL0oyMDJTMEthU0s3TmFm?=
 =?utf-8?B?RGp5aWZSM1pnNC9ZSUs4cEdXTzcwNUVEWldkTE8veWkrdjdlVXFGNXNaUHpz?=
 =?utf-8?B?OHlnNy9LTzl3dWhWMVRQcVlZUjJDclg0WEhTYTh5eHRldTR6Smd6U1hqNUU3?=
 =?utf-8?B?Unlxb0JVWEJmeHR5WVdKb2RKNk4rQ3Vyall5OSswTHZnSjV0anpFajRHVElJ?=
 =?utf-8?B?dFo3UzhmVXhRbDRxU1pUWitTNEZ6TEJOWExRMk1aVUF3RDdpbXc1b1dzOGNu?=
 =?utf-8?B?eENvdDhmdHlucjZ4bjRWSVplTURUYUVlNFVoNWNWNXNXQmtXRDdjZHBNQzNV?=
 =?utf-8?B?Ulh1Z2gxVC8zYkNucHRTdzNPM2VJNXkxb0JOOFc2MjE0RFNoTG1scm1hcWVh?=
 =?utf-8?B?dTh2eDZwT2lNUnNLSXpEcWYzRlVsZXA5TTkzOGx1aFFvc1RiUWVoQVNWMXJN?=
 =?utf-8?B?aVV5WmptK3JJYmtiMzRFcTFLV29QajB6SzRmTTNNdlNkc3VtOGN5YW1zcTFr?=
 =?utf-8?B?d3dtalNwSVIxRzlxLzZDN1FjQW1MVm1ZTFpTMHlpMW1icWkvWnl6WE51eEZo?=
 =?utf-8?B?S0JNNWQ0NTE3cTBiUnU5NUJ2ZjlqTjZGNFlRMHlPblh2U3NUVVhzc0ZlUnVk?=
 =?utf-8?B?T21FZW92aGFtU0VnOUliN0FIQm9RNVZIZ2pnZTBidXdteWVZSERpMW5LSHVT?=
 =?utf-8?B?emtsZkMrTXJYYmwvN0tCMlM2RURKWXVRamRYalhCN05MdjN0M25uWi9MT0My?=
 =?utf-8?B?VXc0ZWluYktkQ3JVQ0JSS3NlYTNWYmJZZ0dmMjVRY2kyWTZtamhiNnlzenZi?=
 =?utf-8?B?ZjNwK1VtUjFQU1VqaUxLNWFSU1o1aU5DS2hUMTZuamh2TW1senZ4NEV5R0l1?=
 =?utf-8?B?Z29oczlueS9yRUI2Ky8wOEdmTjZxK3RRaGFiUUR6ak0vUHJpa2oxYUhJV2Ex?=
 =?utf-8?B?SCtTdEpFWDQvdWdvQ0FKc2daRmRLc2FLdU83eW5CRnBCc0hESVlyTDd2eXNw?=
 =?utf-8?B?VHJaa3dML3djS3ZNV2Y0OGZ5eWdpMXRRaUJRaC9aWTdDSTF2UE9BUTd0TkNK?=
 =?utf-8?B?QVQwMHUyclRGWmFxTzBIaHJjQW56b2VzeVc3aDlRSFJFQVNkOHE4c01YRFJO?=
 =?utf-8?B?ZHoxb3kyWFpuM1FlWDBIUnFNb292M2lzQklTTDJQZVIwTmFrYU9QN1lIWWtN?=
 =?utf-8?B?MllPM0VDTzFRc0pjT3dwaktINFA4bEY1Wi9SWlJ0NDlZNGYyN2tXWktZQVhh?=
 =?utf-8?B?ZTV6V0xPKzd5VERadUZNSmlIN0o5b3BYdGFkSC8waUd0MVBhVERYQW1rNUJV?=
 =?utf-8?B?KzZrZC9wVnJiRkNZRWlkVTRVaXM0ckg1WUdySE9nS2tQQ0RCZHZLL1p2TDZ3?=
 =?utf-8?B?dWk3cEJRS1Ftek5Pc1Q3VzBienI3Ni8wR2tVUWNQbCtjYUlHbzZUMXZETUI5?=
 =?utf-8?B?VnBaS0Njd1R4ZmRiQ2grdFF6NHdwWXdCTUR2WUh0UjhZTUdxZVJLS0lab0JP?=
 =?utf-8?B?dUNrK1R6M0NEWXhwN3BkazI5cDNwMlVJMXdNUmRUWjhxbU1BdkZjTGNYb1dj?=
 =?utf-8?B?c0Rua09zaHlTcEhIVWhqZmNzTEtSNTRKU3U4cUU5YWM2YURVVXVrMG1adjBk?=
 =?utf-8?B?SkYrbjcyYTVmVkdHRXBYVElFeXVzSS9zTlFZZmx2RGZvcGRJVlI0WHhDU251?=
 =?utf-8?Q?1n9A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVcveU1mZzFQVjMyUklBVzRCZ3R0VGRMVWpMbC9CeEhzVnJlak4wSXVLUGEz?=
 =?utf-8?B?cXNqT1VydlVvU2hvU1ZjOFpGd3lScktRZDgreGcxS2diRDliU1U4bGMvRTN4?=
 =?utf-8?B?ZElic3lmSVR6TElwemNIN1AyOFZFN0dTL2NJRXUrVDFHdkFSVmZnVVRzNXA2?=
 =?utf-8?B?U0dpVnFpZDExNmhWTlNSU3VzcTd6MlBBVUlUUUI2MFNNNTBLRS9KQmRQWHJJ?=
 =?utf-8?B?NDJmb2pjNitxVkNKeTkwQlU4bUo5TVY4VE9ISW1JdlVENGdkZXlxTGdoMzd0?=
 =?utf-8?B?TDNiSGJ2Vmw5ODlBdCtOaTdtaEVWZlJ6U1QyS1BXaW5tVzI3UEFiOERCRkcy?=
 =?utf-8?B?NFM1OERoUElQdlU3MGZQbjlhUU9qeE9ibVhqOTM1bndNM0laemhJREl4U3N5?=
 =?utf-8?B?ZHo5eC9xZTVGVlU2NHFoV0xpS2hIbDR6dkQ2SjV2V05rbEpHeFczb0FlZ0VI?=
 =?utf-8?B?alJJTHhiZDBWWjErQ0gxbEhzMHhqcXNvSHN6Y0dYYlI3RU5sRlJsbGFaL1Uv?=
 =?utf-8?B?WWd0THkrNnBhbDRSdHBZZzA4RStaQ0JvQXZUYVpYS1BDMUhGb1pPZWJOZU5T?=
 =?utf-8?B?L2lGWlpyT2laaFFpdHdVcjdOdi9JaXdOdzkxT0ZGVnVydjJMT1hFOXJodXhI?=
 =?utf-8?B?OWJyTUZzT0cxeUk2V3hSa1V2Wk9LdUdlSDBPQ3pYdDJYMytWUEhZazZWWTZM?=
 =?utf-8?B?Yy9IbWNCeVJWenJOWlljeGhuVU40V3d6dC9RSXlnT2xRZUdpS241enVrM055?=
 =?utf-8?B?T2M0M2tQVDFHREZEMCtxV040NXJUYmNLWE1MMzVNVnhTWGdIeVplWXcwMkt2?=
 =?utf-8?B?d1JmaVA1bU1xNkpYbTlRQlV1ZUJVNUFQZE1zQ3BhR0JPd0llbkNmSGJ6eDh1?=
 =?utf-8?B?VGlIVnFJSElVU2hCZGMvRWRaM2Z1YzhQaytBVWVYUXg1aWkrN2hSLzZja0Vx?=
 =?utf-8?B?L2RyVGhDT043R3Rlc3ZCdEc2OWdVVFBQTlp0MmNxai9VODU5V1Ftb1JkanhI?=
 =?utf-8?B?c1V1Q2JCcWpHdlVuc3dua1JxU1lkdWdGRmo1dDdSNjVZOGV4eHpPUWZHblJX?=
 =?utf-8?B?ZGdyVTdTbkY4L1gxVCtWTjBKdExsb2dGdXdOQ005SC9ib0JpM1NoYXdEM3Vj?=
 =?utf-8?B?TVdZRC9HQkJ1ZTNFTHppZVhaeXozNnJEYWI0b085eUxWQlpVUDJKQjl3bkl2?=
 =?utf-8?B?c2VhRndWV21vbDFCazhCaUtkWEZ6RTJRUkVOWGZacW1VeXU5eWV1bFErTUhP?=
 =?utf-8?B?NHVzYW1yVzUzL2dPc0s4ekdYaStGaUQ5VmZGSkxmeXZseHBWazVSMjRlQW5D?=
 =?utf-8?B?S1N0eExIZGh1ZER4R1I3R1V4YVJJaGV0a3I4L3hnUys2RWZOTHl4dkxEMW9y?=
 =?utf-8?B?d2RsQ1lGSU1HSHBFaE01N3JrNFByQ3hURXBveVAxbW9wSXZrNE9rbTEydmlF?=
 =?utf-8?B?ZWZxeWVLTTJBN3QxRXRPNEhjN1Znc080aXVBYkZieVZ1aGNGZHhMeFJtV1p4?=
 =?utf-8?B?R2JJL2Y2U0c1M21EWjQ1ZnZrcUxDSjZVT0tOblpaNEswbDJUYkUzZG5UUHVJ?=
 =?utf-8?B?T2lPV1NvTTd4dzNzTzhVRXpXWmdOQWZZUVVRTFB1Tkx0VW1pSjZKTUhuWGN5?=
 =?utf-8?B?N0llMHZDL3hKSGV6RndjVTFGenY4UG5ORkVIR2w2ejVRT1QraTJObUlTcm9Q?=
 =?utf-8?B?bUFYMEcvNmY5dVZ4S0pucGo1RzFwMlMzamVGNXFIOU9WTllVZDljUWtjQUNj?=
 =?utf-8?B?SnBzTXVpQ1h1UENUbEt3RC94aXJDK0ZVSkNRU25qTW8wb2pqM3Y2VnE4UDY4?=
 =?utf-8?B?Y1RzOW1HTDNmRTdBOGxGOFdsMlFGYmFWSU9UcDRLMlhRa3h1MWNJSGRiV00z?=
 =?utf-8?B?cTkyNllmR1lFeDJVTXBxajBLZ1hidUgvMnV2RXdIVEo3NythQjZXczNYdEt2?=
 =?utf-8?B?ZjZKSFRKZC8rNGJHNmUvdThsV2gvRFVhelRnWWFNV0gwYlYrU201ZHpkcFp0?=
 =?utf-8?B?Y2ZUTGpLRXQzN3hBZjFFMWFDdFZZdWpHbS9paWNVaitQeU9uUnJqTHp1M28y?=
 =?utf-8?B?VnhzVG1KNldZKzlrb1Z3alI1SlByWHAvMTNZajdnbmVKWnBXenlSTmR4OXAr?=
 =?utf-8?B?L0h1dGlmRkhUZmtZTGlvS2d0SVpWdjJtUGUxbm8xVlE2eEFqbGFVYysrWFFq?=
 =?utf-8?B?Ly9NYmxPS01pckJQeUlNZXVLc2VvRWMzazg0eXBXQnFlTk85N0R0eGl4Nk1U?=
 =?utf-8?B?Nm01OUV1YXFiSk1MRmtkd0RiR0cycFZtZk1tYlNhdHZCYTlHK0Fxcnpzcmdi?=
 =?utf-8?B?T1Y1S1hnK3VPeGtVSS83bTNDQnR3VGRjQmpnVWdaTndYODhza1dCZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6b6e2c-54eb-4f2e-7e47-08de538f804f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:08:13.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zCA2z8tJHhUzRnP/ogMmqXlB8/OcM1ZbY0PoV4ZiCjY4b9f7BLu0iNcWa/Y8IOJygA2WCc/jFB7OwCiBvHXP70eyMPxO451fZ2eKgXv9MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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

Hi Jonas,

On 1/14/26 4:37 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/14/2026 4:01 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/6/26 9:34 PM, Jonas Karlman wrote:
>>> With the legacy networking stack, it is possible to use USE_SERVERIP,
>>> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
>>> specific TFTP server ip.
>>>
>>> Using the lwIP networking stack use of the 'tftpserverip' environment
>>> variable provide the closest equivalent functionality.
>>>
>>
>> It does read serverip environment variable if it's set, so this should
>> match the behavior with the legacy network stack no?
> 
> This is what I first thought, however it seem that the lwip stack differ
> slightly from the legacy stack, in that the dhcp lookup always seem to
> reset the serverip env var.
> 
>> As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwip
>> and isn't covered by this new variable is it?
> 
> For the lwip stack it looks like the BOOTP_PREFER_SERVERIP Kconfig
> option possible was replaced with use of a 'tftpserverip' env var.
> 
> For legacy stack I had something like following in a .config fragment:
> 
>    CONFIG_BOOTP_PREFER_SERVERIP=y
>    CONFIG_SERVERIP="192.168.2.50"
>    CONFIG_USE_SERVERIP=y
> 

And this meant the serverip would not be overwritten by the dhcp command 
for example (in the legacy stack)? When doing PXE/TFTP, I always do

setenv autoload no; dhcp; setenv serverip X.Y.Z.A; pxe get; pxe boot

When I control the DHCP server, I can actually set the TFTP server 
directly and can skip setting the serverip as it'll be set by the dhcp 
command correctly it seems?

 From my notes, for an OpenWRT DHCP server:

Network → DHCP and DNS → PXE/TFTP tab → Add button
     Filename: default

     Server name: fileserver

     Server address: <TFTP server IP address>

     Force: checked (may not be necessary)

Save & Apply button

I'm assuming you need this for your labgrid farm so hopefully you have a 
way to control the DHCP server :)

> Adding NET_LWIP=y made pxe booting stop working and 'serverip' always
> ended up as the dhpc server regardless if it was set to something else.
> 

Interesting. With tiger-rk3588_defconfig (legacy stack), I get:

=> setenv serverip 192.192.192.192
=> setenv autoload no
=> dhcp
ethernet@fe1b0000 Waiting for PHY auto negotiation to complete........ done
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
DHCP client bound to address 10.2.162.193 (1394 ms)
=> printenv serverip
serverip=10.2.0.122

> Since lwip instead prioritize the 'tftpserverip' env over the 'serverip'
> env for tftp use, adding a similar env var Kconfig option was easy but
> may be wrong path?
> 

I don't mind the addition but I'm wondering if it's not a band-aid patch 
for something else? Maybe lwip missing setting the BOOTP server from a 
DHCP lease for example?

>>
>> This patch is fine, I'm just challenging the justification in the commit
>> log.
>>
>>> Add USE_TFTPSERVERIP and TFTPSERVERIP Kconfig options that can be used
>>> to add the 'tftpserverip' environment variable to force use of a
>>> specific TFTP server ip.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    include/env_default.h |  3 +++
>>>    net/lwip/Kconfig      | 12 ++++++++++++
>>>    2 files changed, 15 insertions(+)
>>>
>>> diff --git a/include/env_default.h b/include/env_default.h
>>> index 7f8dc1c35a74..014873e304d8 100644
>>> --- a/include/env_default.h
>>> +++ b/include/env_default.h
>>> @@ -58,6 +58,9 @@ const char default_environment[] = {
>>>    #ifdef	CONFIG_USE_SERVERIP
>>>    	"serverip="	CONFIG_SERVERIP			"\0"
>>>    #endif
>>> +#ifdef	CONFIG_USE_TFTPSERVERIP
>>> +	"tftpserverip="	CONFIG_TFTPSERVERIP		"\0"
>>> +#endif
>>>    #ifdef	CONFIG_SYS_DISABLE_AUTOLOAD
>>>    	"autoload=0\0"
>>>    #endif
>>> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
>>> index 5789766fe624..0cfd3eb2684f 100644
>>> --- a/net/lwip/Kconfig
>>> +++ b/net/lwip/Kconfig
>>> @@ -72,4 +72,16 @@ config LWIP_TCP_WND
>>>    	  but QEMU with "-net user" needs no more than a few KB or the
>>>    	  transfer will stall and eventually time out.
>>>    
>>> +config USE_TFTPSERVERIP
>>> +	bool "Set a default 'tftpserverip' value in the environment"
>>> +	depends on CMD_TFTPBOOT
>>> +	help
>>> +	  Defines a default value for the IP address of a TFTP server to
>>> +	  contact when using the "tftpboot" command.  (Environment variable
>>> +	  "tftpserverip")
>>> +
>>
>> Does it support IPv4 *and*/or IPv6?
> 
> Not sure, I have only tested IPv4, guess IPv6 probably should work, the
> 'tftpserverip' var should work with same formats that the 'serverip' var
> currently support.
> 
> This help text is mostly just a c/p from the USE_SERVERIP Kconfig option,
> let me know if you think this should be changed.
> 

If it only supports IPv4, I think it should be mentioned. I'm sure 
Jerome will have some input on that when they have time to review :)

Cheers,
Quentin
