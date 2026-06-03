Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71EACD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 05:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D9B8486D;
	Thu,  4 Jun 2026 07:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="YOKj2cI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BBD8467E; Thu,  4 Jun 2026 01:23:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2118480433
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mateusz.furdyna@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqY7T/tw3ICYyL5HB/A/0xXNVeAWMD5G+ECovzZnq6Mq1Rh7EgknVdh6s05s7D5VGNWy3MCJaUPpERGJJsj8njNm9/FnlyWdlXDtkk2BMv96MDElnf7v6Xah67mW5aQEJUmEwgcfovQFB6rAMH/kRIL3CMXNIOGoAOy5D92QKmGunUJ1J9gtc0gK1eAlZb+h6e0IgHOGLv4JhREIGQhNM8OPh1x/g5MRf2VzUWaTA9YXxBi7aui/5re+/7WaJN3iKGbgIATebbzkaV++H+Eaz3SQ1iUg/MPGoRAaJqgGk0NgV0srfZyQ0fM5YqTGUvICa5Pp2768H+mZf94MpYIAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi2oxpCKczmYxHIByZSi0lDjP4v/Yum9gw8Bd6Eg00U=;
 b=fFyN4Hr5CB32CnnLpCyroD5CGxj25bZUHRO65WzyjucvbASF921EEPlZxU7kH9HXD/grd4h7tDwTKuM0+2DZ3Tmoufza/BtsomxaQSeI5mUssnbFIfaDbj+EXZp3q5mHo45+PRqDm/7wqkcRhggt+j104dwIef0j/fgvuwAOikYOPTjhjeoihH2dHUGGEiB362UKN6+j3w48lrCUkHVJlSwB8e6gLtZkqCUlfK5QuIs7zf2nUMSsb3+HoDjEqPREnnfm0M/QCNTj8MN26tPR/aNCIj0HuJsS2tlC+pykwszM/TPzMd61JDn7/ZNTcGs0C3X87MAplMEi4TxHZjcCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi2oxpCKczmYxHIByZSi0lDjP4v/Yum9gw8Bd6Eg00U=;
 b=YOKj2cI+ZdCdl7Op9COBCDE/hT/AZ+eD1GSihac6kLKFbObmjhdm5kjpbmTteSRLjEGLbbcP/JVCvX/niJbjOgkn3/OeuVjh3gO1bGVDXmdCKIJXGZbzSMrqI0YJz5pb+vPadolmoHbAVj+DUcDT07CVgzuVytwrur/gNW4GwAXYFsPsGi4tNMp4hpQMZ2zdhR/B5Hb1Xv9avSoez1vmelXgCW+gdhYHfODs+sFwgthOn9c90Q1eJR/cz6ZIOw8InXez3J86mpkvdHXB3oTFrVIq3nmFFFvW+ecqfxVZbry5xbdL0AnPSI97tm5aCChVakSt6MwDz0j2M56zzklkgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 by GV4PR07MB11548.eurprd07.prod.outlook.com (2603:10a6:150:2eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 23:23:48 +0000
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc]) by AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 23:23:47 +0000
Message-ID: <00f5f51e-3fcc-49d1-82ce-e6311ab64339@nokia.com>
Date: Thu, 4 Jun 2026 01:23:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: clear IP defragmentation state after returning a
 complete packet
To: Simon Glass <sjg@chromium.org>
Cc: Ben Warren <biggerbadderben@gmail.com>,
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Mariusz Madej <mariusz.madej@nokia.com>
References: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com>
 <CAFLszThkbskeSsf+HJY41Q0BKYiX3QgXAuSR3Vx6anPXTrR-kw@mail.gmail.com>
Content-Language: en-US
From: Mateusz Furdyna <mateusz.furdyna@nokia.com>
In-Reply-To: <CAFLszThkbskeSsf+HJY41Q0BKYiX3QgXAuSR3Vx6anPXTrR-kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000518.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::670) To AS8PR07MB7461.eurprd07.prod.outlook.com
 (2603:10a6:20b:2af::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7461:EE_|GV4PR07MB11548:EE_
X-MS-Office365-Filtering-Correlation-Id: eff532f4-c439-4632-c7a2-08dec1c729d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: gMZyxvUoFmgpCJIzKW6CVATMdVKabW1143fmd54DrdBymeTenAOT1ox1i43w9p2mKs4MgjbOtiBPP0KvtUVOyTCDUqKen0C8C4mJRytF17BKlhvy0CCmtbHx7Due2eOVSJaPZZbQGdXlgZHW3Q24LDkRvo/As8FLHPJNiBT9VNcejt4NiDyXrRkMam+vlAkRMLYWBSM9sjSVmhe4aejZrKLhfVSJ9kWoFFdKOoVTZswZsnGlFQr/rNVsq/pWzFd8wJl1ENn5rjsBRlnSrA02xf+sNujoPiBojyPyOy/76hwzgid4JW2YH3Pq4coMXednY8qWlhf6mWPzBkKSejfdnGcXx7VD4bHjuzbfwiebGlTmx6Y4nRLrH8Jwo1uWm6JnnN0LIBMvd0Z/B9BwuBWEKFoVjPCkuYMPTj44kHw5/6wVDKqEfPXsc6C0VffoA/B57AlrxuyW2FK62S/1Wy59l/h8AOwnrWl2CrNiai5y4mz+wTZbvut3Koehh0/DYpw+tajMCQBOjDYt6ZpbaQBM4Zd4t6OzJl5yRNmIGpCHBliGqTGb1nOUJxUuz9SwaVQuuvVQ8WBql0lG8//80V2PevUr7++PJCsQYsMXIWBnuYOsJObituvnc5eHWkFPgj6WY0CvOW/GKlwUnSPC0oVK12MyHYiKYwzlc49C5q5s7E/6y1HEpugABnmNOWZi+kcR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR07MB7461.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHN2VVZ6RHpIanQrdnFSNytPVHFNL09MKzRyRmNqZENJdWlENHpaQW4zTkta?=
 =?utf-8?B?K2FGL3IyN1Bqa2xPMFNad09QcmFvcDhKd0pTbENGVGFoc3FPcWxTd3JLc0wz?=
 =?utf-8?B?VzNKU2hKbHN6SHlVVkh6ZlhYaEdYZVJUUXdwNm1DS2lLTHg0N3N2T2tBaGow?=
 =?utf-8?B?RW4xbkRaenZDa1p4d04wQTZJR1lMcFo0emZ0c0lqOUlrVEcrUzJwQ3d3MDJs?=
 =?utf-8?B?OXM0amQ5V2tIcnAyTmdHQnFkd09waEpYV3FvbFhjNnpaWFBsZVNuNFdjOVhZ?=
 =?utf-8?B?RExYZHA0QjJROStJSmtwSnZPYmNGdWYzZk0wUFBmclF2QitqLzFPNHhYNDB0?=
 =?utf-8?B?aTU1WjhKdlBxQkZsRHZBN1VhUWZ6OUpZMmpJTHVibVdIaFNBbEk2WVFPNy9n?=
 =?utf-8?B?bTdBY2I3cjF4Q1RrODdtNHhEcmVCVVo0Y0FFbFBLNlg1dk83Tk0rTXU2OEkv?=
 =?utf-8?B?a25wWHM4TW9mdzEzUmpaUDdGRmpWWlJob2tiNUgxVmlUYzhyc0NKYTdKRkwx?=
 =?utf-8?B?dnQ2THlCZy9xQlpSQWhWeW80ZTlERjVKTUlMYUs5WEZRQVl6TjRRcDdtWHlu?=
 =?utf-8?B?dEZDVUhoL20zY2RMTngrNnhmOGFHb0VuT2pVWXRFak9WUFJEcXh5UFh3Vk56?=
 =?utf-8?B?VjdPWERnOGV0U0lvZ2pBc1kzaEx6elc1dWdrZWxQRmtEZTFJbEdqeHFqZ3l3?=
 =?utf-8?B?dVZKcEl0Vmk1Y0d5bFN3RHRxeDV3TWlCQ2FrbjZkUjFNbHh4Rm14ak1BTjBX?=
 =?utf-8?B?K1ZYSjNJcTJZbmNYdEdXaWRiTXNEM1R6NkVYamtXRTVpZlMzd28vZG1UWGFR?=
 =?utf-8?B?a0pDNU9IaHQyK3AwTVhEb2FJeC9xbnE2K24vM2tISUl5eW9LVW5FZHdRY0du?=
 =?utf-8?B?OUFZMDdTK0pLMVhaOC9yb3NMRmgvQ1I0Nm5seE1iOHdmbDJjbkphMUhJYmoz?=
 =?utf-8?B?Zk45aTB2WWtTbXV4MGdqNUpic0lUUVc5VmtyOWNya2Y2RzVNK0U2b1cyeEpV?=
 =?utf-8?B?NVBYYkhTb0xlRDd1cDBqWitFSE5lV1VXbHI5eGx3VDVtdG80SWo0T2RPZFZU?=
 =?utf-8?B?UmdjblI5NmNvdmEwSForK1V5c2FCZXFrRm14cHVpYzBROE1sT3o2aTNlSGpN?=
 =?utf-8?B?bkh3bVRhajBMUW1zNm1USlNMY1BYM3pLbVY5OEYzMDQ2cjVPS0FXdWcyLytP?=
 =?utf-8?B?eE5qTGtna2JvcEQ5b1ZGeUZuL2xIRXRpWDBzdUd6bWRPNHI0TUtrNlZFbmxj?=
 =?utf-8?B?ZnpSdGNDVy93NDJXNzkrdHhITXVxWTNjSWs1ZWhTaUJxeUJ6U015dFM0Yk1E?=
 =?utf-8?B?cG1Gd1JWOUg2TzQ0cEJEajIrVnpuSllkYlZDVm91SWI5S2Z0SEpENVVTZFdX?=
 =?utf-8?B?OVd4WkRRVkVHMUhJMUNVc1QzNURsSUdYTW9GVnBYa0VYQ1QvQlliQU4zbmpk?=
 =?utf-8?B?c3JkZkFxU1h1NTNvY3NqaC9rN1VrUVRvRDUxNEhPQjNVc2ErUW1rRVdFc2hq?=
 =?utf-8?B?cGl6V2R1MVJSYVZEMERURFp2ZVF3Q1RsZ2thNmtDWHVrcjR3UDltQWZSTkk1?=
 =?utf-8?B?ekZzR05ibjdBaFZDZ1ZrSlNKQ2p5ZDBTT3lPNUt6REpTZUVCZUNwQnZTMnUx?=
 =?utf-8?B?dlZGN01paWlneEhzZUNlUnRCUy9zZFhCd3NLcnAwUzExdjVtS0xCT0JoSW93?=
 =?utf-8?B?Mk1kZEV0amxyK1A5S2RvSitSVXJRRmhTUzRXY2ltbG1yNmtTRmRSb0lnejl2?=
 =?utf-8?B?azczTmhlTHh1amZSTmtmZ0JpNE90b1hxMWowTEI4SDZET09kd2pWYmU0U3Rv?=
 =?utf-8?B?N2NzV0xaSTB1Q2Y1a2xUU3N2SlNMOUM3ZlZaUTVlZzVWMWh0UkpkV3VNcDl5?=
 =?utf-8?B?VVVNZU9GL1dlMWdLL0tXSmU3bGtZcFJ4Uk8ydVAzaGtYVGlSbjB4Uk5hQ2Y4?=
 =?utf-8?B?SE1zWW9mNlMvR3FqMnRsQU8vL3NmeUU0M2hVYW5wMnJDSExDK1ZiOU9OTVRF?=
 =?utf-8?B?bk5nODRaMDRRMVpmWkJQb29pWFJ3eDdLSU9GcmRGOFpBTVRObXB6d1BsMXY5?=
 =?utf-8?B?MTQwaVFQNHAxNmMxTmJRcXJzU0ZNb0NpWkFMS0JDMVQrVWtvbzZaVUhzSzhI?=
 =?utf-8?B?eGNkc002YWlwYm51QkU3WjExUVlURTdvUXpFemVCKzQyOUNNN0RLOWxMRGdH?=
 =?utf-8?B?aFJGSG5mbDBhMTJhaXQrazdwSzlqWVlEa3g3R3U4dDhhUWhuc01sdXBkaDRO?=
 =?utf-8?B?bE1IT3lXRHBwTmNxSzVXYWZaaFlFQ1hoaVVBdlZLL3hJKzMyZng2Y0FNekRR?=
 =?utf-8?B?aWIrMml6SWlMVW8yeUt4ZFJ4SFowZmVTemVEUTBQQjI2MFM3QjFSWXNOd1R4?=
 =?utf-8?Q?d3j10EI3dEP6JiP4=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff532f4-c439-4632-c7a2-08dec1c729d0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7461.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 23:23:47.8291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mlD6L1/wQ9DLNS6vgLuTMUPUU53ThWRZXlmySdmArdRSfkOM+IS5NDp5NPmexXMZk5ULLr7Ol6ZKkdmaQTsAosZDi99fLI5iY5yWk6irls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11548
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:10:31 +0200
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

Hi Simon,
Thank you for a review!

(I apologize in advance for any issues caused by my mail client's 
potentially still incorrect configuration)

On 03/06/2026 19:04, Simon Glass wrote:
> Hi Mateusz,
> 
> On 2026-06-01T22:48:21, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
>> net: clear IP defragmentation state after returning a complete packet
>>
>> During the IP defragmentation process, after the reassembly is finished
>> with the last packet arriving with MF=0, the reassembly state wrt.
>> static counters is not cleared. In case this last arriving packet with
>> MF=0 gets duplicated, payload bytes are mistakingly treated as hole data.
>>
>> A malicious actor who can deliver fragmented IP traffic to a U-Boot
>> instance with CONFIG_IP_DEFRAG=y can corrupt memory via out-of-bound
>> writes and redirect control flow into attacker-supplied payload bytes
>> that already sit in pkt_buff[].
>>
>> Publicly available AI models are able to generate a reproducer based
>> on the provided information.
>>
>> Fix: once the assembled packet has been handed back to the caller, mark
>> the reassembly state empty so that any further fragment (duplicate,
>> replay, or a brand-new datagram that happens to reuse the ip_id) goes
>> through the normal re-init path and rebuilds a clean hole list instead
>> of dereferencing payload bytes as struct hole.
>> [...]
>>
>> net/net.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> with nits below
> 
>> diff --git a/net/net.c b/net/net.c
>> @@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
>>
>>        *lenp = total_len + IP_HDR_SIZE;
>>        localip->ip_len = htons(*lenp);
>> +
>> +     /* Mark the reassembly state empty so that any further
>> +      * fragment goes through the normal re-init path and
>> +      * rebuilds a clean hole list
>> +      */
> 
> Please use the standard U-Boot multi-line comment style with /* on its
> own line, to match the rest of this file (see lines 962 and 1016):
> 
>     /*
>      * Mark the reassembly state empty so that any further
>      * fragment goes through the normal re-init path and
>      * rebuilds a clean hole list.
>      */
> 

Ack, will do.

>> diff --git a/net/net.c b/
>> @@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
>> +     total_len = 0;
>> +     first_hole = 0;
>> +
>>        return localip;
>>   }
> 
> Only total_len = 0 is actually needed, since the re-init path at line
> 1007 already resets first_hole (and payload[0]) whenever !total_len is
> true. Still, this doesn't hurt.

Ack, will keep the first_hole = 0 for the sake of "defensive programming".

> 
> Any chance of adding a test? Probably this is a little tricky...

Hmm. __net_defragment() is called from net_defragment() when 
CONFIG_IP_DEFRAG=y, which in turn is called from 
net_process_received_packet().

net_process_received_packet() is finally declared in
include/net-common.h and reachable from outside the compilation unit of 
net.c.

If this isn't too much of a stretch, I'd propose creating a new file in 
test/dm/net_defrag.c and reuse the existing test infrastructure here. 
The stretch is this placement in `dm`. What could be a better choice?

The test would pass a 2-fragment, pretty short datagram:
- frag A = MF=1, 8 bytes of data
- frag B = MF=0, 8 bytes of data

After completion the unfixed code leaves total_len=16, first_hole=1, and 
payload[1] now holds frag B's data bytes. On a duplicate of frag B, the 
function does h = payload + first_hole and reinterprets those data bytes 
as a struct hole.

Now, in order to actually have a deterministic and reliably failing test 
for the unfixed code, we could:
- first, use net_set_udp_handler() to count incoming datagrams
- craft B's 8 data bytes to look like this "benign" hole
	last_byte = 16, next_hole = 0, prev_hole = 0
- abuse the delivery condition (net.c lines 1054-1058):

	if ((h >= thisfrag) && (h->last_byte <= start + len)) {
		/* complete overlap with hole: remove hole */
		if (!h->prev_hole && !h->next_hole) {
			/* last remaining hole */
			done = 1;

Duplicated packet B would trigger duplicated delivery condition, call 
handler registered using net_set_udp_handler() and increase the counter 
in case of unfixed version; fixed version would count only a single UDP 
packet in the test scenario. No segfaults.

Sounds like a plan? Let me know if test/dm is an acceptable place for 
this and I will write it in a separate commit (same patchset).

> 
> BTW, 'mistakingly' in the commit message should be 'mistakenly'.

Thank you, honestly, that's a way to finally remember the correct 
spelling :D. Will fix the commit message.

> 
> Regards,
> Simon

