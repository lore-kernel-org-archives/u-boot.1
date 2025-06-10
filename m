Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFFBC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 14:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E179382B0E;
	Tue, 10 Jun 2025 16:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Wn0PPZ4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7841582B18; Tue, 10 Jun 2025 16:59:38 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E58F82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 16:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9F6E3F691
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749567575;
 bh=6Z9V6EwyO28Mpu+t0WWxJLZaGtTS3gimgnKfHLbtsWc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Wn0PPZ4VN7nmC7pApWGY5TncyV6OoQrF8kiTOnJTSa5QMeBZE617miosWqzcGN4z+
 V0gkcpBaq4Fn2/BP7ewbRNxlnNDD0KhmiTP9vX8cBjonAt9PoQilRPBwFeAUkwK6bN
 ZUCLHICTIo/r4snlKh5uksRyjHhOcoZ0uHsebP2Dfqc6iiAcO7pS6HrRpc+kTLUOdR
 cKmxHHh3HTq6Fnbmk0xWHPB3iM4DiaFUD9c38MvkR0jBH0NenSq53qgXGXToITUgfD
 QFie/IEmPWO7yY0xGw1yWYoSwr0hAQNwZ7UL+WS1LvR1m5ywQwGQLAeHGwmIC2Bb2X
 FGDXhsejovPEg==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ade0abc1ce0so422829066b.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749567575; x=1750172375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Z9V6EwyO28Mpu+t0WWxJLZaGtTS3gimgnKfHLbtsWc=;
 b=mH3u1Pkt2MnF6yVzZc+HwMMqMMIrlEBVCAg/n+C78rVU2WZd1B0H1F2uZMtDs7uGkK
 fLb+4KCUTvdORIXjJKpCY+RW1ekkxOuNnXxyMd6KUgu6JWdjWHummfzvjj4FXDIV9+jB
 qFWY8Iy4fw8/HQBIL6tqOnJ2lc/dWm7gxK50HJYMEtNo86T6JznGAhjM81ZvC0TfFv+6
 TkJ3txacWwoRebfB9mJPMd39sY5L3vW4Gh4QCaseOcimEpxFy9Efpl1a4HRlfTwSfXs1
 SPVXUgEzjNRwcHQROYGh4UqgL3FsCTcA1fwJXxmW9vDM80ReDwsLBE5VIGAcBBUoLELK
 AnyQ==
X-Gm-Message-State: AOJu0YzZygKjvvvofPYXN6bweurDeHTdIevleLNoxjMFlS8MLvsNreF2
 zj/Tp0ap77KXLQX/bF5/eWCDHUbH7bvjoOxHiQMJk4aWHaeymznW40pgGVeZSKzQKHyTJ0jfrO/
 DE+gZUyccyEsKkGqPX/Jlg+5fuHsSiUh8JQjU0tBhp4dzz7LPjwvtcPd4X8XJrWBQSE6y5Ps=
X-Gm-Gg: ASbGnctNBiSnCMRyii0poO4Jev/AiaA+hmooMBIt0aIiZF7511w1tSu40zWJQ4AN3A6
 9uJX4tPc/BdIWrDSdXh0wAnlSAm/Gg/9R75rxSMmIl1v/eKbmzHkMZyyvqE0clRMZCDNE6zaYBH
 XCCRaCCEB0MIscqr+8bXnTe3IkN/QBg2qvjVr8s2dhA7o1cZijXHGPZLO1kpt/Wel91ePGptVwT
 sYbjxxGlIez2sSiBOol7vrOc4SRfrvvS0dhE8oB0VJzz4THBa/RatEktYl6Oz6DxwC8H4lkzjGf
 0HFeVkm7MqlmbK7r4PUXHtpPV1jJ8SXQOm8WhwNOrFF1dj2Ux0fD07Ul1+VIC6pTp2mShkPVKxa
 lKcqBujXj6tY03S2Hq8M=
X-Received: by 2002:a17:907:96a8:b0:ad8:a41a:3cca with SMTP id
 a640c23a62f3a-ade1a905801mr1704347066b.14.1749567575080; 
 Tue, 10 Jun 2025 07:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ozJ7OYocMUFqt1Igxt4bTD7o8/8z9bNyCAIl7WoBSDiGyZZBGsCds6aNwSNhSqChkVF4iQ==
X-Received: by 2002:a17:907:96a8:b0:ad8:a41a:3cca with SMTP id
 a640c23a62f3a-ade1a905801mr1704344266b.14.1749567574573; 
 Tue, 10 Jun 2025 07:59:34 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c5d4sm747372766b.92.2025.06.10.07.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 07:59:34 -0700 (PDT)
Message-ID: <6143f2db-2c4a-4a97-a418-285f7f733af3@canonical.com>
Date: Tue, 10 Jun 2025 16:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pylibfdt: correct license information
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
 <7240ff54-a730-4f86-9ed2-8ca242ab8388@cherry.de>
 <5f843f23-77fe-441e-80f7-28ad10431f68@canonical.com>
 <04f3a57e-6a73-4409-9820-e0d1c7ba998e@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <04f3a57e-6a73-4409-9820-e0d1c7ba998e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10.06.25 15:12, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 6/10/25 1:17 PM, Heinrich Schuchardt wrote:
>> On 10.06.25 12:53, Quentin Schulz wrote:
>>> Hi Heinrich,
>>>
>>> On 6/7/25 1:32 PM, Heinrich Schuchardt wrote:
>>>> Setuptools 78.1.1 shows warnings:
>>>>
>>>> * Pattern 'GPL' did not match any files.
>>>> * Pattern 'BSD-2-Clause' did not match any files.
>>>> * SetuptoolsDeprecationWarning: License classifiers are deprecated.
>>>>
>>>> Cf. https://eur02.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Fpackaging.python.org%2Fen%2Flatest%2Fguides%2Fwriting-pyproject-&data=05%7C02%7Cquentin.schulz%40cherry.de%7C0adb7b1dc0614f539d0808dda81061b4%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638851510506087467%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=EE9NsYjNmv9u%2FCkTUJlLaDtXouwZ2pNPlBwvLFuwQlA%3D&reserved=0 toml/#license
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>   scripts/dtc/pylibfdt/setup.py | 4 +---
>>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/ 
>>>> setup.py
>>>> index c6fe5a6a446..487e669f524 100755
>>>> --- a/scripts/dtc/pylibfdt/setup.py
>>>> +++ b/scripts/dtc/pylibfdt/setup.py
>>>> @@ -158,12 +158,10 @@ setup(
>>>>       long_description_content_type="text/plain",
>>>>       url="https://eur02.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Futils%2Fdtc%2Fdtc.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C0adb7b1dc0614f539d0808dda81061b4%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638851510506108720%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=r00cvV5e%2BYJO6je%2FyIip3lMC%2FjqkUpTKvC%2FpMS9aobU%3D&reserved=0",
>>>>       license="BSD",
>>>> -    license_files=["GPL", "BSD-2-Clause"],
>>>> +    license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2- 
>>>> clause.txt"],
>>>>       classifiers=[
>>>>           "Programming Language :: Python :: 3",
>>>> -        "License :: OSI Approved :: BSD License",
>>>> -        "License :: OSI Approved :: GNU General Public License v2 
>>>> or later (GPLv2+)",
>>>
>>> This is an issue though, as it's supposed to be replaced by the 
>>> license argument to the setuptools.setup() function and we aren't 
>>> matching there (though tbf, we weren't already matching :) ).
>>
>> Upstream setup tools has been changed to ignore these lines.
>>
>>>
>>> Also, I'm not entirely sure BSD is unambiguous?
>>
>> There are BSD Zero Clause License, BSD 1-Clause License, BSD-2-Clause, 
>> and BSD-3-Clause, and further variants. See
>>
>> https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fspdx.org%2Flicenses%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C0adb7b1dc0614f539d0808dda81061b4%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638851510506121987%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=INVUJ5iYA8APRyK0u9Rh2QUYLR%2B%2F0%2FGwevzMVHxgPiM%3D&reserved=0
>>
>> The linked files in license_files are unambiguous.
>>
>>>
>>> I would suggest:
>>>
>>> license="GPL-2.0-or-later OR BSD-2-Clause"
>>>
>>> to match the SPDX-License-Identifier at the top if the setup.py file :)
>>
>> 51ec8db23280 ("pylibfdt: correct license information") is already 
>> merged. Please, send a new patch id you want to change the license field.
>>
> 
> Fair enough, sending a patch...
> 
> I did a similar changes in an unrelated project a while ago, c.f. 
> https://github.com/maxpat78/FATtools/pull/20/ 
> commits/6f811b1a6719e605d8c6fb03d1e95468fa2de720
> 
> It seems like we need to make sure setuptools is 77.0.3 or later now. I 
> don't see a declared dependency there though and it seems we add the 
> path to the pylibfdt to the sys.path wherever we need it. I assume we 
> would need to bump that version in those projects' pyproject.toml/ 
> requirements.txt?
> 
> Should we just ignore this for the moment? At the same time, setuptools 
> 77.0.3 is very recent, most distros don't actually package it just yet. 
> If I trust my old self, if we build those tools within virtualenv/venv, 
> then it would anyway just pick the latest available version on PyPi?

Thanks for looking at this in depth.

These are our requirements currently:

tools/binman/pyproject.toml:2:requires = ["setuptools>=61.0"]
tools/buildman/pyproject.toml:2:requires = ["setuptools>=61.0"]
tools/dtoc/pyproject.toml:2:requires = ["setuptools>=61.0"]
tools/patman/pyproject.toml:2:requires = ["setuptools>=61.0"]
tools/patman/requirements.txt:5:setuptools==75.8.0
tools/u_boot_pylib/pyproject.toml:2:requires = ["setuptools>=61.0"]

I did not see any issue in our CI. We don't install the Ubuntu Jammy 
default setuptools (59.6.0-1.2ubuntu0.22.04.3) in our Docker image.

Best regards

Heinrich
