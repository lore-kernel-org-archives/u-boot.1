Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D64CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C0184659;
	Tue, 19 May 2026 14:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZLyKd91B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8967E846CF; Tue, 19 May 2026 14:45:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3CD843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 14:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnV5J6P7qgTkP/WgRyRQsiWlyacA8/V7vuigDaQzBZ1/E9yJUbtWfnY6XH1akXl7pi8tSRtz6F22xrBGEHihxMC+iYvORwqdkLLsSMksuCimAPg+fdAWRzzGIIyqptAg1XavTbUkBQJm7F1bK/KNiCZdHUxMXwrCpCySuM4OZTOi5/JkSAY+7GxoMW21kujHaQ5Fg3Ku9mo52K0+32GqtrGtHUacLqKMdGXsaV1MV8k7RfL1iqr/VayznH2nDAkI64XBQ7by+nA0iBFC/vqov0QpHdhfDspK5zr2Ep2jNLvZ5Jv6OghaCXmEKEIwBjDtKLbKKJX6DasYI1HhZJ3AlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCbaojVqJeTy9anQFy68magOcqaSFCKHaroi5BGUCwM=;
 b=WkRLfv6JrTQfvkAgyqVCAgzRRVwxrNGHExXh2RkkdJAOFGuzsXnl0Au0NbBQs2spu/YH/vuSbll8COHoRmRtklD7cJTrDHfQZP4YTwhAOvip7HvINjJp980fluZZMuJ3GKG3KvW8xDzUWFa5oqFQzcejOKAm48m/iWZFBL8dTcvqxch/DY8szac3B07RTusJ9VmujEkaMhI98MckQWKjAqCqpoLPe2bCueP2WldI+BlEwP59KwKhDlqgsXPJHQyXPbH+CGsMBSjDhPpXMdaRPG7rbfWaYrZYz0PMlqts0wji/zir+GZ7pV27nqlDnHx8zUM4GLoaHcr0GqjFJOnadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCbaojVqJeTy9anQFy68magOcqaSFCKHaroi5BGUCwM=;
 b=ZLyKd91Bk0WpdHPucf8BXvVBVYWagg1YIbouy61S0l914o7wQH20kvFsBlt/es6U3xvoJDZIJyDIyY4momBs2765MLh4Qxr7VwXcVN0bVYQ/+y6fwmwjHyHAUto33muqX90mYaBQqhbox9+ywbgWGH/6B5XVJJbT8zyMWc+z8dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB9577.eurprd04.prod.outlook.com (2603:10a6:10:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 12:45:35 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 12:45:35 +0000
Message-ID: <3c49cee2-bd74-40c8-acb7-7a587ad895cb@cherry.de>
Date: Tue, 19 May 2026 14:45:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot patch submit standard and requirement
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <c8cb1fbe-b15b-46b6-a39e-e6c2bd652ec6@cherry.de>
 <CAN7C2SCguh2M3JFC2UE3UFYf6_Z9a9038UEKpFLTTGFTH_r60w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAN7C2SCguh2M3JFC2UE3UFYf6_Z9a9038UEKpFLTTGFTH_r60w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000212.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8d3) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e01b6e6-44aa-498c-0890-08deb5a48576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: nNSXjYJKceMrY2WtzOIXFqv7716+eJsf4Z1tih0A+mokoCKdEI34kuta81AJMS/vohzIMzXUpztrKZTLD1X6M/nap28fxAtVOLMXRNBj+0fLFi+Dt1Zmt13pvfs5ggZlUp3Lz+SiEd8eANRZNvhBEioGPlykOMD/diEilB6lTDbyr6dvhMN8Ma4PsgM6TmJW93ffS/akc9GOupqBqAwdeGlCNQsDo65FvF8N6vW8czEOhiOGOlSsMBYn6k6z+cWuRoVq/CHko/fNAAZOU+SvV+Bzh3Sc9WY+wp2p3IeS/sCriSC96tnR/ipCKsJNE0yLTDIvZmy2tnXIX24/xsFmPYC9LRuZJyYYkQ68z6HAkjvpCOtf4gEh5LZndNjAJFI5E5kII99pOfqVkzM8SVG9fCI//m3XfpoV2nd53kAAkhyTYf7ySiTCuZFUPVYwczC3/ezp595QlXn2NlAao4Wzgn4ws0dgWW8muHyqAe1OBa84CN4wr72wy0T3sU7WCL64ZCQ8yW6oJC7tfasSqloEH/V/dAkwVEf4Y2z8tAnx0o3r2COVwdyLwfAiN6WK11DrHeNqxcJDSPMTQ2lBy2e2OV42dyUpyzLHvjK+9stDrW7ITPjQSLDYNpQVyqvGyeE9EZNdPAcEKVTopkDUammF1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmN0VUZXRkJFYjRWRW5oQmZjOTN1YS84SjROVFdWVmFMMDVuRDJ3L2VFQmVh?=
 =?utf-8?B?cExjUmY0SWVRZndJUzdDNmswUCt3WUNubEl4OTRhTDZ2b0ZMV0VVT2FUMHcr?=
 =?utf-8?B?cUJRdE8rUXR5czBlWHpsbDZ4TWYvOWwvaGJDTUV0K3ZZVmZVQzczSURmWTQy?=
 =?utf-8?B?OHhnaWtENG41bmh2aVJWRFNBQ1dyMHZMTzJxZExrbFVwOUVBZkdSVlgvS0Zu?=
 =?utf-8?B?ai9NODZMeEd4VmI2a2RKc3hzWGdCd2JzemRuM2w1VnhZOStoM2xLTUpFWHpj?=
 =?utf-8?B?U3N1WXY4SWpZQ0Q5VHF4MzRGWHN1c0dWODlpYXVGVGk4dzhVTldCbmRjNVNT?=
 =?utf-8?B?Q05DbWRld3ZqKzQ3c0dKdXlGanBkUlBjbUQ5ck1ucWJlTjViL1dMdStjSW83?=
 =?utf-8?B?ZjJWcXlOazNEdDcwb2RDVlVtUitGV2hERnlYR1lybGk0TTN1OXpjeGFEbGx2?=
 =?utf-8?B?eWFrUTVsVkp2UUR0WTdDWWVZbWNPb0tzei9NRkZCOXRnQlEyUkRHOHRMYy9F?=
 =?utf-8?B?NmRPN1NoODZJZDcva01IcGpmQnllaHphODlXNEJVQ05jRExHOHZtU1JEQzBz?=
 =?utf-8?B?d052dmFHNzJuZ2JmTTg3V3gzZFFvVlE1YVVEdGJzWGovdGRzaUp5cWR3bXo4?=
 =?utf-8?B?WWZKeDlNenNYRG9ZemRoQVBaUlNCRWsrWGl6NEpZYmYzejdjS2VOenRvQVNt?=
 =?utf-8?B?V3ArQTE4ZnVYSEZzOERjMXhKRkpsZmJIRHZpajB5cU51OGQ1TDcycG1KNnJr?=
 =?utf-8?B?Ly9kQVN6aTNNYkw3RzJLRnB0aUZTWVhseGJnN2NDOW04WXFQVENaeVdGUTZV?=
 =?utf-8?B?azF3WEQ5RHV0aFN2VW9TUVBmWlRSQ1VWK0NLaVVncHloYTljMm9tVzd2L0Fn?=
 =?utf-8?B?aFNDSlR4NDlRanNCY081byt3eTJsTWtwN1FqSEluN1RCenFiV1lZT3oyRHN4?=
 =?utf-8?B?UFNDUGN0eVRtNHVydkVjbGxjTEw4SDlSMEk2TmtoMnplZEF6eW9teEFFdGt6?=
 =?utf-8?B?azlMQkI5WHo5UTdnaFVyZFh4Yk1EeE5tNzhSK09JTExVS1ZTK3RrRFpwZUtM?=
 =?utf-8?B?Z015ak1VNGx6eWFiYUt1c0ZXQytKeFlKZkcvR0tRcmZDcHhyem5Ka0hmRmpK?=
 =?utf-8?B?WlNUWXJsdWRNQnBkVTJjbjVGK1RrUnZEeEd2NzNoYkhDdVc5TUNQUUJFNTdB?=
 =?utf-8?B?eDU1K3o5QUx1NGhpRVFhTzY2MTJKYyttV09jcVhXR0U3aXpXcFNlRkNsbXNH?=
 =?utf-8?B?R2MvZklFNkszN09BTmsreEE2Y2hiMHlhMVU3b1llenNJeUNhSXYrTGx0ZUt2?=
 =?utf-8?B?NG1TcnhkSTQvOGlqYjl0OVNqWEtoVk1FSVhEN3MwOVpEMEJQZG5YQ1BNYkIx?=
 =?utf-8?B?SUNVNnlqQjhmWUYvMWJJd2FOWlJrQ2tPenhsZ0M5Slo1YkRWWmxhOURkV1k0?=
 =?utf-8?B?UTFiQXB0OTA4R1YycGgxbDVzUDFvV1dvTU01L0Vtd254WGRWM0pER2RwQ0d6?=
 =?utf-8?B?Um51NnhVb0dJNHhIZ2V2dWs3QzlNcDZsWlMwd1lKbndSOWtBYzBGSVNVeWQy?=
 =?utf-8?B?MDRXUm1UcWlvczhVdXlYRTNka2hNdklaTkdoU21VaGJVakRtZVBiUGxCSTRv?=
 =?utf-8?B?aUFrNUwyYlh4RjlVSUg1cngyNWJ2ZjVrdEhzMGJuUVVvTVE3cDVXNXN5RXBR?=
 =?utf-8?B?NHdMTjZWK0Q1ZHJHWUpzVWh5bWJCc21DdmlPNjR0NlFoTFFVa05uUjJwYUQw?=
 =?utf-8?B?dmNqT2JEcS92UU5OUm5UWXBXNldiQWd0QWluTk1Oand5cHplQW9vUC9Kelkr?=
 =?utf-8?B?WXNuOTVKOE9nS2V1K2N5bkpJeE94K2lyQTVQN1FPdW5rS2xOWWFIczBEaXZV?=
 =?utf-8?B?NXpDeHBCNE8xQ3BVODFpT3V6Yjg4b3F5ZEJnbHFqaWdJNjJmTmZGU1ZGSDI2?=
 =?utf-8?B?UGZKYXRKWDRLdDJVZmVVSW9DRnFha0xBNnQwamZPTVVyY2RSYnVwaUdySWc3?=
 =?utf-8?B?TXRXbGdZK1ZOdmxUR0F1Rit0UDFvbWlvTm9qQTIzU3dzVWZOZVh6ZEI3WDI2?=
 =?utf-8?B?TmhZTlVCeVJCQUYzemJFd214VmlwaE1TMXMvRWhXRG5HVmNrVlZTNk9xb1hl?=
 =?utf-8?B?WUhMd0NkaFdmdVR6TWxQVzJjZUR4VlhUOElvemFWQTZEem5COHo3RFF0WjNN?=
 =?utf-8?B?R2pGMW1kQ1h2MXptYW56dWNUbXZ3MlFINVVJZWNMcGlNUGdJbXk3SUFKaFpF?=
 =?utf-8?B?YVZDM0cvdnVDcUp0bEpiM2ZiRW1WYWFyaSswUlRGRWNzdDhqZUIyLzliaEgv?=
 =?utf-8?B?VkRDSkozcVpJSkZTR0M2a09UbGJsY1AyaUQwVHJuZVZtb1hYUWJxUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e01b6e6-44aa-498c-0890-08deb5a48576
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:45:35.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbGwnzBPQ4JmcN2GN5awAvnCqHOq2aGqXAYbFsk2pGk6pqMRuFXHEXUp/5je8yKIwmEc411i0tuYHey9Rb65zf/VRGN9o2kWPqkx/NI6Acg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9577
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

Hi Brian,

What I understood as being your complaints are the following:

1. you were told to put the version changelog in your patch to match the 
expected format. You did it in the next version but not the way we 
expected it. You were asked a second time to reformat your changelog to 
adhere to the expected format, with a more precise guideline. A second 
answer then provided you with the link to the documentation.

Appropriate links are
https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-briansune@gmail.com/#3680205
https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-briansune@gmail.com/#3683491
https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-briansune@gmail.com/#3684415

The requests made by Simon (reviewer) and Tien Fong (maintainer) are 
valid as this is explained in details in the docs. See 
https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions 
where you also have an example. However, I see the requests for 
"'Changes in vN:' rather than 'Changelog vN -> vN+1:'" as nitpicks. I'm 
almost certain neither Simon nor Tien Fong would have requested you to 
change that if it was the only thing to complain about. It's just that 
the changelog being part of the commit log is an issue, and since you'll 
likely need to send another version to fix that, "oh by the way, also 
try to do this while at it" happened. It's not unusual. If it was the 
only feedback, I would have understood the frustration.

The second and third links do NOT invalidate what had been said in the 
first one. There was a misunderstanding because there was room for 
misunderstanding. I understand the request made by Simon in the first 
mail could have resulted in the patch you sent, which doesn't match the 
expected format. Nobody's fault here, misunderstandings happen all the 
time. We make things clearer in subsequent versions of the patch or 
discuss them. I do not consider what Simon did as being hostile. If 
something is unclear, you can always ask for clarification.

I will also note that Simon took the time to better explain the rule a 
second time once the misunderstanding was detected and to provide a link 
to the documentation.

I will join Neil here and tell you that the phrasing in
https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-briansune@gmail.com/#3683515 
and 
https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-briansune@gmail.com/#3684100 
is unacceptable towards Simon.

Additionally, dismissing Simon's comments simply because he's a reviewer 
and not a maintainer is not the solution. The project relies on 
reviewers because maintainers do not have the time to review each and 
every version of the patch. We put trust in reviewers so that the work 
load is lighter on maintainers (and hopefully, with more eyes, we miss 
fewer bugs).

2. you feel like you were victim of a double standard because reviewers 
didn't complain about missing or misformated changelog from other 
contributors.

Provided (by you) links are
https://patchwork.ozlabs.org/project/uboot/patch/20260508-qcom_spl-v6-1-aaac1ab17b50@seznam.cz/
https://patchwork.ozlabs.org/project/uboot/patch/20260513015606.591384-2-rs@ti.com/
https://patchwork.ozlabs.org/project/uboot/patch/BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM/
(and some others)

First, there are some patches for which Simon (or Tien Fong, who shared 
Simon's opinion on changelog formatting) didn't participate in.

Second, your examples sometimes are patch series which do have a cover 
letter where the changelog is mentioned. They do not appear on patchwork 
(but they do on the mailing list). See 
https://lore.kernel.org/u-boot/20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz/ 
and lore.kernel.org/u-boot/20260513015606.591384-1-rs@ti.com/. Yes we 
have inconsistencies here. Simon has complained in the past with 
changelog per-patch being better (for him) than changelog per-series 
(i.e. in the cover-letter). Having *some* is good enough for the project 
is what we decided on.

Third, you cannot cherry-pick a single patch version and say "look here 
nobody said anything", later patch versions may receive feedback like 
you had, earlier versions may have received feedback that wasn't taken 
into account (this should not happen, but mistakes happen). Usually, 
once a patch or two gets feedback that something warrants another 
version, reviewers and maintainers pay less attention to the patch 
series as we know we'll have another version to look at in a few days/weeks.

Fourth, different reviewers and maintainers are different people. They 
have their own rules, either stricter, or more lax. It may also depend 
on the reviewer or maintainer mood at the time. You cannot hold Simon 
and Tien Fong responsible for another reviewer or maintainer not telling 
another contributor to follow rules.

If you want to name that multistandard, then yes, we have that. It's 
sometimes desired (not every maintainer wants to apply the same rules 
with the same strictness as others, that's their right as a maintainer), 
sometimes not ("oops, we merged something too quick and forgot to check 
all the rules"). But I don't believe we're applying the multistandard to 
someone in particular. If this happens, please bring this up as I'm 
pretty sure this is not something we want to see happening.

If there are things we can automate or document better, then please 
consider sending patches to improve the situation.


As an aside, I'm not a native speaker and we may be coming from 
different cultures, so this might explain why I'm reading most of your 
mails as being aggressive, dismissive and sometimes plain rude. I 
understand it can be a language barrier, but please remember that we 
have a somewhat diverse community where people come from different 
cultures and different levels of understanding of the English language 
so what may be rude or not rude to you may be received differently by 
people reading you (and vice-versa).

As personal anecdote, I still cringe when I remember participating on 
some forums when I was 14 and thinking "bullshit" was an okay synonym 
for "a lie" or a simple difference of opinion, I cannot imagine how the 
other people felt when reading me back then.

I'll finish by saying that sometimes it's easier to spin a new version 
than arguing or getting angry, even if I slightly disagree with the 
reviewer or maintainer. It's better for my health and it's less 
time-consuming. Picking one's battles is not an easy task :)

Cheers,
Quentin
