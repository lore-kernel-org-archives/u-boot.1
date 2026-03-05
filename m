Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA82F47CA3
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99908839A8;
	Thu,  5 Mar 2026 18:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K0gxUmwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1855383E81; Thu,  5 Mar 2026 18:46:06 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED1B800AE
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 18:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhOsdZtrliQvc6EIWuAKzCGIhG+BamuQCK24wvxioRxrUEMaRKFAg3uREIiaarFviDPvTSf/Dn+itIYTTyowiiunKeS6X5McgIM50z25uz5yLY1t1gaGjp+pl+KINqyrWS5Z5x97PNw1rNclUByNx/JecLR0A2ZH6BJDI8txnYl/mCnQ1pq32uyzxPEtFPBBIqFluLL5A6A0LSB7romV415VFpP//HX7xl8Gg5Gebf0rZzG29A9gLWTMjkPYN8xF0mdlUo9+8Rkiv8vgiKdfOlUzAWTCvfG0a/aOSBDpQXUfiNPH3W+OhIlVtU99MwLJ0QVpUpjJrATbKxYZ6u29jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adDBhQncExWYbSopPgXW47bh5Z4ez56Im2c9GGKX7lg=;
 b=NGcgau782dwBokl0B5ipTOmYIgPgrGgpLRxmGm1eoC7yQZCf3BYf/tN0LiRiN7rjUuNI7uEDc+Fq2cZYttPa7/bnFEKGHVoYc9XeJhUdMiBvQWrqNsLXGLz/cMzqDmFG0dw4K3zjuGWBkHljUJ6pO/5XOdxwf/kbUgGA2aYgK3+9mMuso8C3GiyWyZN3XCIMNdFBUr/VIah/GABFcEiZ27a5aAopjusRm3mWWNcwf9SA/GLYguywe9izuw5vCvspKaso4iGhB2worih8w2g41oJnz4Rxzf6NUsC203G6WTvsy4D9fhhTLCRN7ugrwE2Naap+VVhDvQCYf0S6MaMWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adDBhQncExWYbSopPgXW47bh5Z4ez56Im2c9GGKX7lg=;
 b=K0gxUmwmWHTj2Gnwf5Rq6LYbjuQhTojkhIj0Vo+4VJTPS/UX+Prw8glkvMiBi8qz+NGfk4rkXvsoSkRbUEuOcwSwZKyPwhG6SPUIkXqt0/7TRQ/QmlFuPZ8GOfOWtlZZ5jJTr3sGcwiH8TBlpiDaeGFOIk18qPrzUDKfTVrN/Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7739.eurprd04.prod.outlook.com (2603:10a6:10:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 17:46:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:46:01 +0000
Message-ID: <94ff2577-ee65-4e45-8cfd-315a4669a8db@cherry.de>
Date: Thu, 5 Mar 2026 18:45:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add an initial CONTRIBUTE.rst
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20260303214653.4096007-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260303214653.4096007-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0060.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::49) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6862f04a-f977-448f-169a-08de7adf10ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: dvNYTpkIudr0+GN8VkTLlY7IpXhnqsmmwEw5jfFekJtmaT934R5CbY+jmXCPeAAo1nyU2DoSMKSoR8qD+SZZcNSXOJyheUpW+mc9PUP9i6ZGqx+m/gnbSiGKXxJYMEELMM+GJ7DZThZtcsCb7J5W4P92P6+tI/DnWwxXbb7iLmjk5wjkFfme4Q2bYVJ6PiAYadg947NzRYvjOeJVRuw1gKoazOJHkp+tDU4e0t4URWVjEq6CCAuFT/hHaUNhteKwd47TGvFhr74zctph0edTq0VuA2OzRkmupvehYWe/BtTY+nKJR3zNGeybkXRiFHRcGppXIWs/bXMHFm9TUnkwMiBHih8rKyIBgLQzqfOu8fz7UGUFIBYYVeFN0DqhIpDUF6JIHoZg5EPVDFFUK3oZKKI375IiF3sIPkOlVTRWZuIfRHmlTFNlLnxVd59povg3Hxn2UCL6ZALcwlb3yy39pqRBh9t/6VUiseeSHCvArFQDH0xA+Q6A3gS86LhpOYlt30rA+iXj9CLH7Ckd8IgP0qRN65HBbEGyNFXexjuxszw29UzZVrYW1NtV1Sj5oli9Qse9nk4ribKvoj3lzGJg+1jPV+wCXS8bMmd0znbxLzcN2vti2ULjiYzFoZdXsagfCqfi6qrdELaC+C9IjpyXpMqLmCyixUgh76ZfI1lmReihCRsWt4mmYDqpHYDsl9R5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnc0b3hYczRERVNvRlRobWNKS1M2dmpGdS9iVHdEVC9Vai82OFRTSnpJSVRI?=
 =?utf-8?B?UjJ6YVlkL2VmODhKU3FKdkhGakRkbHREbnZEbDh2TE0yUkdHY25kZ0lpYkx6?=
 =?utf-8?B?QzBSSWZqS0VtbHYwd3RzNE1JZEkvS08wQmg4VFNnZjFzdHVSMGdrV2ZJMjBP?=
 =?utf-8?B?MWxrMXlHTHpjbTVxRjZrREs3ZHMyUHB0eEord2lFREFCUzNqTFEreXFZaWJ2?=
 =?utf-8?B?cDdqWFgwRkF5b3N2eHZJcEVaK1UxNWlvSVhycm5MV2dOeFFjTVExYXhJUEdL?=
 =?utf-8?B?clViQ1d6SEdhdTk3ZXdkZmZQYnQ4NHV1Nmx3U0xvODhoSi9zZjRld1VBM1hv?=
 =?utf-8?B?c29oMjRsMmsvT2owbVpMWlplTS90Z2xzdUtEQ3VWcnFXcjA3WGM2bU4rcHEy?=
 =?utf-8?B?b29rK2VtcHp5TjhPU0R2YWQ3K3l6Z1Y2Rjc0WkVkU3NlT0ZwblgrRVVMYlRn?=
 =?utf-8?B?Ni9KWHNBVC9EMGl5WmVhL3lrdHdMZ1FYRXBYc1VNalcxQ1ZCZ0RGbEdoRjBr?=
 =?utf-8?B?Ni80Q2MvTjNhZ0t4eVJrOHJhUFJudHR1YUsxK1pZT29MT00rWElGbkpmaFBF?=
 =?utf-8?B?enZTRk5Kd2tjTHowSG01QnJOKzhwK0E1M1dLRUljZUtEdjFZdWI4bW1Ib3pZ?=
 =?utf-8?B?ZHo1VTZjR3g3eVhoL1FHRFgva0tKRUkxOEVTVkVLZFlEN0NXMXp4Z0VDS2Fz?=
 =?utf-8?B?c25NNVgyZ3psOEU3eDc5U2pJZktpOTY2UEpPeHBsSjM3QzAveTZEZHByUTRC?=
 =?utf-8?B?T3pmSmRmVUxoQ1ViNWJMUDVkQWhuRkduTnZ4cW5LMllyN1VnUkJ3TTNxRElq?=
 =?utf-8?B?TjRMT1ppbzU2WWZtQUNSekl0NkwwMDJQMnlLdktoR0hSS0FTaG9OZ2VrR1lO?=
 =?utf-8?B?a1JJc1pnVzViYUxqUTBKdjdnQTZ2NCt3dGJZaHI0VjVya04rVDBSM0wwV3dH?=
 =?utf-8?B?Yys0WWVYbXFkd1BZYitDdjJxb2k4a3J2WFNoR3pPZEwxZ29pbDArTjQ3TDM0?=
 =?utf-8?B?aXpiQ1JhYkxjeHhWYVYzNjQ3NE8vQlU2eWFpYWJ6UzZ6WE45L1dROFlvRDJv?=
 =?utf-8?B?MFZ6UXljWVRRRzcwdzQwVk1OemdzNWdZVWQxYWppZmkxZ2dsVTA0M3IvTzNw?=
 =?utf-8?B?ODBwdGM3QlFMVEhCQ2JMVkxWSVViYkQ4TC9TVWw0Q28vMnloVzRNUDlwMThZ?=
 =?utf-8?B?REJyOTJjaFVndGJIN3pCUU1UQmEyMnRiT0FqaW5OUXNPTGxpb1hKUnpBY2dw?=
 =?utf-8?B?a0diKzBib2VuT2lCRGx1L1ZJQ0FMbnBaT0liKzBmelQ5R2N2TENNUWRHSU5H?=
 =?utf-8?B?T3ZFSlBoczh2TDdNZTAwa0thbWR0czFZMXZXck00SnRGelVrM281VG1WSXdy?=
 =?utf-8?B?NDVuRGs5YjJhb05BWVY3NC94S0kvMyt0eXNzNUdxbnVSVTlqcE40V1JORVI0?=
 =?utf-8?B?UTRrSkI5dC9SM0pkYUp4bGpsUDljWnhnRFJCUW1YaXYrc2EwWkN4MmJueW12?=
 =?utf-8?B?RW82MGNtM3FPd2t4bmp2WldYWXl0UFlHWWVmeW1ZVTV0cGszaFBvemN5QXha?=
 =?utf-8?B?QUpYT0ZyUXJhQ0FFMkd4ZlRlQWFkYThDNTYyTkVTS2J3YzY4WlcxOFBJVTlo?=
 =?utf-8?B?MTRyeVZTbEk0ei9mN082cnpLWmFSbS9mR3doNU94LzAyVi9KYmZvaU9RY1lY?=
 =?utf-8?B?MVphaXVyVUZqcUg1OWlWeVlzZmZWNXZJM05TK3R1UFJEbHBKTzB2eFY2UldB?=
 =?utf-8?B?M0txNlRqYndsb1c0L0ZYZjlGYlAzTTNabFo4Q2E5UERtMmE3UEk5V2FjaXJT?=
 =?utf-8?B?VUVRSm5yNktOUEFDOWUxS0Jpb2FUSXFwZ1VrTjJVa1psZ3UrdkNZUHJHaEdW?=
 =?utf-8?B?aUNEUGxUeFNpNU1OaG45Q3d5T21NS3FJT1JZbW0yVTUzTmpWN1cxSVdrY0I4?=
 =?utf-8?B?K3JUeVNUYnFzUkdyYUE4dWI0S0NZTEtCTlBTZWc3eDU3amJsUk1vS1ZUbEFx?=
 =?utf-8?B?YnpUY3dzOWppUkhEcjR5UTNCVk9TaFFuelBBK2szL09xZ01ydFNvV3lWd3o0?=
 =?utf-8?B?SytZdFBkWTVqSTIxSG4xa2N3dG5SWVVsS0MvNXpRS2xtNFRCVUdGSjNqZ0Vh?=
 =?utf-8?B?dFlIUzRvR0lHaDVKYmszb0h1SVhUTzY2SndBRlpMbWZRejZDdVRoNlIrb2xV?=
 =?utf-8?B?U3h2K1pSK1Zzc092S1Z1ZHZtQWlFamNTS0IvMi9MOVdEc1RKM1VOTzlYdmYz?=
 =?utf-8?B?VkdZQUdlVnR3RFJRc3grVWZMUXVyc3dXNGVXQnAyaEJ3bGU1R041TzVFL0FE?=
 =?utf-8?B?aWhSRkJsQTdVelFPSkdBZFA3WTFCYUNHRWpkTkVVWWpPK1ViakoxMWFVTll6?=
 =?utf-8?Q?t7VP3ZJ9pSJ8k+69xSItosOgX7C++UlE9w2pN?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6862f04a-f977-448f-169a-08de7adf10ce
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:46:01.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsqdDxc/9AkLwOsF7Tg0uz3t/fXVQkC26ivIJJd/LUz5xC5n59U+nu+00bmIo6hu9VYU9lJJ+SSmSmsW5mE6QT7r3Oop62dXSDVud7C/XpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7739
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

Hi Peter,

On 3/3/26 10:46 PM, Peter Robinson wrote:
> Add a contributors file to provide a high level overview
> for people who wish to contribute to the project outlining
> basic details and setting some project expectations.
> 
> This isn't intended to replace any of the existing documentation
> but rather provide a succinct top level document that's easy
> to find to enable users to understand the project and get
> started as quickly as possible.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   doc/CONTRIBUTE.rst | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>   doc/index.rst      | 10 +++++++
>   2 files changed, 80 insertions(+)
>   create mode 100644 doc/CONTRIBUTE.rst
> 
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> new file mode 100644
> index 00000000000..7602e5c5a6a
> --- /dev/null
> +++ b/doc/CONTRIBUTE.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
> +
> +Overview
> +--------
> +
> +This document is a high level contributors overview setting overall expectations,
> +so people can get started quickly, the rest of the documentation goes into the
> +details.
> +
> +Code of Conduct
> +---------------
> +
> +The U-Boot project doesn't currently have an explicit code of conduct, but all
> +contributors are expected to act cordially to, and be respectful of, each others

s/others/other's/ ?

> +contributions and opinions. There are many code of conducts for open source
> +projects available to review if you are unsure of expectations.
> +
> +Repository
> +----------
> +
> +The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
> +> +Contributions
> +-------------
> +
> +Contributions to the project are welcome. The U-Boot project uses a fairly
> +traditional Linux style development workflow using git and `a mailing list
> +<https://lists.denx.de/listinfo/u-boot>`_.

Note that lore.kernel.org/u-boot may be more user-friendly (especially 
for people using b4).

> +
> +Patches should be sent to the mailing list using ``git send-email`` or the
> +equivilant commands using ``b4`` or ``patman`` with appropriate sign-off and
> +attributions for the code in question. Maintainers should be copied on mails
> +and they can be found with the ``./scripts/get_maintainer.pl 0001-fix.patch``
> +script. Please don't send patches as attchments, and ensure corporate mail

s/attchments/attachments/

> +systems don't reformat patches, append disclaimers or other uneccessary notes.

s/uneccessary/unnecessary/

> +
> +Patch Series
> +------------
> +
> +Patch series for a specific subject are welcome but they should be constrained
> +to a single topic with a cover letter outlining the intention of the series.
> +
> +Generally bug fixes for existing bugs should be at the beginning of the
> +series before any enhancements to allow those patches to be picked up early.
> +
> +Each iteration of a patch set should be versioned, allow enough time for people

Awkward wording here. Maybe switch to a dot instead of a comma?

> +to review previous versions of the series and incorporate all the review
> +feedback before sending a new version. A week between larger patch sets is
> +considered as reasonable amount of time.
> +
> +Development Branches
> +--------------------
> +
> +The U-Boot developers use two main branches for developing the code. The master
> +branch is used for the current development cycle, while there is also a next
> +branch intended to land changes for the next release early to enable wider
> +testing of larger code changes. The next branch is merged to master shortly
> +after the tagging of a new major release.
> +
> +Similar to Linux there is a two week merge window post release after which a
> +release candidate is tagged. There's typically a new release candidate every
> +two weeks post merge window until the stable generally available release.
> +
> +Release Schedule
> +----------------
> +
> +There is currently four major releases a year in January (.01), April (.04),
> +July (.07) and October (.10). These typically happen on the first Tuesday of
> +that month. There is currently no release branches or long term releases.

General remark, this doesn't provide links to more extensive 
documentation so it feels a bit like a single-source of truth. We may 
also unwittingly end up contradicting ourselves in other parts of the docs.

So at the very least can we have links in this docs pointing to the more 
extensive documentation? Especially on the mailing list contribution 
workflow.

Another option could be to reuse verbatim other portions of the docs. 
Move current snippets into my-snippet.rst.inc and then in the 
appropriate places do

.. include:: my-snippet.rst.inc

Such that it cannot be outdated. Of course, wording or syntax may need 
to be adapted so it's not looking odd in the various places this may be 
included.

Cheers,
Quentin
