Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D273C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 09:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0395180086;
	Thu, 22 Jan 2026 10:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="f8OV0agf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B215839DF; Thu, 22 Jan 2026 10:40:05 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D2F80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 400B810E1C6; Thu, 22 Jan 2026 10:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769074799;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=17jramYHRgyDBYo+ubo/O/y5HaXH6dyOwBU14flKnQ4=;
 b=f8OV0agfROfvFZUl8oRBDotk/gNmSUABonhYXVzgHhOzFOFXsMbbqvmFYAPnr3zlgc6kcy
 cq7L9rm5Q3kk3LTx/DsSOxN0iCCxmOENFuDXRX8jDbryrJyGW/4xDfoQyUeWhnoc4SUigq
 EFTttQY1y+lNUVdBK2xULt4inwqcEqorQUcbtpEU4ypq2VRtxVDSsVbT34ZNCgLG9B2kII
 qmEjYlmcu9nT8JwF5AAeeM3XXcMO1C5bBsRQ+ek3BsaZegJCdX6poz/S+aaj8M4hVie/XO
 xNZb7FAb7RQI+0V/B6hp3ZrTxq0Fh7i5DEj6k5EOZserb4GXh/S7VrBHWgd95Q==
Message-ID: <1c9a6853-9acb-9665-78f4-d5c051bf9d2f@nabladev.com>
Date: Thu, 22 Jan 2026 10:40:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/2] doc_ cmd: add documentation for sm3sum
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106141405.82637-1-hs@nabladev.com>
 <20260106141405.82637-3-hs@nabladev.com>
 <a0cb3bb1-c9de-470b-9169-386b05eceb6f@cherry.de>
 <3c02e1a5-aceb-1528-078f-80b695f741dd@nabladev.com>
 <77fbaee4-777b-4d8a-afa5-239d8e0974e2@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <77fbaee4-777b-4d8a-afa5-239d8e0974e2@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

On 22.01.26 10:24, Quentin Schulz wrote:
> Hi Heiko,
> 
> On 1/22/26 10:12 AM, Heiko Schocher wrote:
>> Hello Quentin,
>>
>> sorry for long delay...
>>
>> On 14.01.26 15:22, Quentin Schulz wrote:
>>> Hi Heiko,
>>>
>>> Typo in title, should be doc: and not doc_.
>>>
>>> On 1/6/26 3:14 PM, Heiko Schocher wrote:
> [...]
>>>> diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
>>>> new file mode 100644
>>>> index 00000000000..3b157779a0e
>>>> --- /dev/null
>>>> +++ b/doc/usage/cmd/sm3sum.rst
>>>> @@ -0,0 +1,117 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0+:
>>>
>>> Use the canonical version:
>>>
>>> GPL-2.0-or-later
>>>
>>> c.f. https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fspdx.org%2Flicenses%2FGPL-2.0-or- 
>>> later.html&data=05%7C02%7Cquentin.schulz%40cherry.de%7C752a802f23394270c5f808de5996472c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639046699157004614%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=hFPbf2cm4pcD17T8ORnYC%2FL9VOWm2s%2B8Ebnb6TMjru8%3D&reserved=0 
>>>
>>>
>>> (Do not end it with a colon either).
>>
>> okay, but I just copied from other files... for example
>> doc/usage/cmd/dm.rst:
>>    1 .. SPDX-License-Identifier: GPL-2.0+:
>>    2
>>
>> So of course I change it... but does that mean, we should fix all other
>> files too?
>>
> 
> It's unnecessary churn so I would say no. Considering I had other comments on the patch, I allowed 
> myself this nitpick but if that was the only thing I was bothered with I wouldn't have told you. 
> It's still clear we're talking about the -or-later version of the license. The biggest issue would 
> be with GPL-2.0 or GPLv2 for example because it isn't clear if it's the -only version of the 
> -or-later version since it matches none of the SPDX license identifier.
> 
> I don't think Tom will want a patch to change all SPDX-License-Identifier from GPL-2.0+ to 
> GPL-2.0-or-later but maybe I'm wrong :)

I think not :-P

What is with ending ":" ... above example has also the ending ":"
I removed it as you suggested...

> 
> [...]
> 
>>>> +Description
>>>> +-----------
>>>> +
>>>> +The sm3sum command calculates the SM3_256 Hash from a
>>>
>>> Are there variants of SM3? From what I understood, it's "equivalent" to sha256 in terms of 
>>> security and efficiency, but it's SM3, just that?
>>
>> As I know, there is only sm3_256 hash. If you look for example
>> into include/tpm-v2.h
>>   33 #define TPM2_SM3_256_DIGEST_SIZE 32
>> [...]
>> 277         TPM2_ALG_SM3_256        = 0x12,
>> [...]
>> 301 #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
>>
> 
> So I would say we should use ``SM3`` here, instead of ``SM3_256``?

No, as linux also use the same define, see linux base:
*   6c790212c588 - (HEAD -> master, origin/master, origin/HEAD) Merge tag 
'devicetree-fixes-for-6.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux

  include/linux/tpm.h:
  55         TPM_ALG_SM3_256         = 0x0012,

Thanks!

bye,
Heiko
> 
> Cheers,
> Quentin

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
