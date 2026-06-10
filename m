Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C6ECD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 11:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51CF84841;
	Wed, 10 Jun 2026 13:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c6V/W9VD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E71484843; Wed, 10 Jun 2026 13:21:35 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9C9807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bf1141c26ecso826103166b.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781090491; x=1781695291; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fBbWL6ylXDCp4me5+7d3JgNcaAM7Rzc5A0+zUIU3wLk=;
 b=c6V/W9VD02syAYGcHd1cH8arQPoFdl7yAnfrXQsvP2e5a+ZKmbz4SfKFEajPol3/cy
 Vf9bCjqcehLZ0a9mkqyq0PkC/oEguz+ViapoHp9XFEPWhUmHMIy9PGZAmYyawNkPAF90
 8Jzngf9rE/KCARLAGkC8dYkabgGovNkLYa++8ekB/GOK1/wJRD3hxxZxhbip1szna+s3
 pHl018tdqtf6VHUT7q5RHlz8tmjE7NMF2tUu4JbDq7Aw/rHDvrOD5qRv1s/U9efj5jwR
 7djW4Ag+ZgbAOGfNMOFYRp8qH8ZGo87scNPkKvnYYz7cR+Y5Jmk5x6BUvVSSPFIjYqc0
 MYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781090491; x=1781695291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fBbWL6ylXDCp4me5+7d3JgNcaAM7Rzc5A0+zUIU3wLk=;
 b=cs30bRaEFUMDbnPB5BcF15u5rJcNX8DXSawjmJ8nCsQkPGu/pCUS/6uKnnDSdTD/Uz
 hlAh7GwXzN+1pFM1NrmGyDMLyAhj0w5x5wTcXrY5QBgRtRhqpfGdhvWcfq1mMb5W83DZ
 MHuhEZlG0SzztOdUL3Njh7pwAShkn38geGcHSjT2s4GrPhuHUGV1vAUo40SFAu0MDZeL
 UX9ORR2rN8TwYru/uPJcD8zui6zEhSGyYGINeQK1IVI6jeQ8RoiVjzedcblwqo0GwQov
 Z1C65gcAQZ69+5ZT3bpn7BC08ZSYwJ3+Ku/VXW0A5s0n+ATidOVwfIrN+CxZZXBEmHUF
 9tRQ==
X-Gm-Message-State: AOJu0YzvgZAHF1rE0SMBkAvqexQsk4aOuCJSav8zcQkrlOQNn4IuC6/s
 /QouzIkGR8esjPh2DfGzcVBEjuh+mi9OmoXlw29Dw303o0BFMu5w320+7GJu0DAXw8s=
X-Gm-Gg: Acq92OE/L6lVVyx2joAfVwuw3n569fG2ZLwM84Sm2W504JQ6WKpUdA6J0N3j2x3ww2i
 FRHmG7lYGEWdI+RSneX+3yRQ1CuMCLx4AKhbcJchjImtVkbYMLUbkeK1ogb6jb/gWm/vfUuxx9V
 JWgEZOWPYq+dlRR700ZrGKHMsZ+y2HGWWQR5NCH8jsIXG5R5Yir4Aor/KWKHfGOjVfveusbCt1G
 owTz8oiRS22VjrmhF3I/25+JIBz7NxzgihbfU5J/x+ufEWB9HhYxo7ZsGHZtuWlJj1UpRfJ2yLO
 Ke8ATlcLEW6r+xkUlsvt/kC+YFs4TARfXVlpemjcDHxFLw/5gUk/PhOnrGbrWvR7zAQw4pExOqC
 yepbmzMnroftTm5kJ8h+X6l2mp0our0/UrAI3wH/xwrb0FeonWebpd+HSR8iSrDNV7/pYke8u34
 3kumDOoMTfpVK4oDUG4acO7UBQWk8v4rj1M1oPxT+7PZPAL8SgsAwYvCTvGhhg2Vg19gqot5cAS
 nhyF27WApEw
X-Received: by 2002:a17:906:8a76:b0:bec:da5b:5a6 with SMTP id
 a640c23a62f3a-bf370e6215fmr883684966b.21.1781090490668; 
 Wed, 10 Jun 2026 04:21:30 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0517721c2sm1136437366b.3.2026.06.10.04.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:21:29 -0700 (PDT)
Message-ID: <c47b55e7-1b6b-4428-a511-aadac7246fc4@linaro.org>
Date: Wed, 10 Jun 2026 13:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Binman with Qualcomm
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Sam Day <me@samcday.com>
References: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
 <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
 <CAFLszTipPLKDSyOsgCWPXQx5oORCQjUrohfZG1Z1P91iATzLhA@mail.gmail.com>
 <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
 <CAFLszTgcmUN8cbVjwrX0+fmH=gL5ufSXV46H_qsXWvWvHD3TgA@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAFLszTgcmUN8cbVjwrX0+fmH=gL5ufSXV46H_qsXWvWvHD3TgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 09/06/2026 17:33, Simon Glass wrote:
> Hi Casey,
> 
> On Tue, 9 Jun 2026 at 06:10, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 09/06/2026 01:31, Simon Glass wrote:
>>> Hi Casey,
>>>
>>> On Mon, 8 Jun 2026 at 12:06, Casey Connolly <casey.connolly@linaro.org> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 08/06/2026 19:13, Simon Glass wrote:
>>>>> Hi,
>>>>>
>>>>> I want to start a new thread to work through the issues which result
>>>>> in later versions of [1] moving to custom build rules instead of
>>>>> Binman.
>>>>>
>>>>> From what I understand there are some things unique to Qualcomm here,
>>>>> as well as some general comments [2]
>>>>>
>>>>> Let's first get a list of the problems and then we can look at
>>>>> possible solutions.
>>>>
>>>> I wrote a whole big reply here but then I realised it was not likely to
>>>> be productive, so I'll keep it short and sweet.
>>>>
>>>> For binman to make any sense to me, it would be a very simple frontend
>>>> and library for vendor/board specific image processing. Configuration
>>>> would be static and defined in the Python scripts, dynamic configuration
>>>> is huge scope creep.
>>>>
>>>> If that's all binman was, and it was co-maintained and used by other
>>>> custodians then I would definitely see the value in using it to avoid
>>>> dealing with makefile fragments and other nonsense.
>>>>
>>>> Instead, it is a massive and overbearing "feature" that does stupid
>>>> stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
>>>> (which crashed for me btw). The moment I try to use a tool for
>>>> post-processing and it changes U-Boots runtime behaviour like this I am
>>>> fully out. Choosing to design and implement something as overbearing as
>>>> binman is just absurd, it prescribes a lot of functionality that I do
>>>> not want or need. I'm just not willing to invest so much time figuring
>>>> out how it works so I can fix it if it breaks something for my boards.
>>>>
>>>> As-is it seems much more appropriate to stay within my means and ensure
>>>> that I feel confident that I can maintain whatever Qualcomm-specific
>>>> tooling we have. Vendoring a Python tool and making a tiny wrapper for
>>>> it is just the plainly obvious solution, I know exactly how it works, I
>>>> can fix it if it breaks, and it doesn't fuck with my U-Boot image or dtb.
>>>>
>>>> That you are so clouded by your own perspective that you feel the need
>>>> to email me on the list to ask about problems with binman as if I
>>>> haven't already expressed myself clearly both in my mkmbn series and on
>>>> irc (and as if comparing my patches doesn't reveal the issues) makes it
>>>> quite clear that I'm much better off keeping CONFIG_BINMAN=n
>>>
>>> Thanks for the candid response - I'd genuinely rather have the blunt
>>> version than a polite one that leaves the real objections unsaid.
>>>
>>> Starting a fresh thread wasn't meant to suggest you haven't already
>>> explained yourself; it was to give the topic enough focus to actually
>>> resolve it, rather than have it scattered across review comments and
>>> IRC. I've read the mkmbn series and I want to make sure I've
>>> understood the concerns correctly, so let me write them back to you as
>>> a problem list and you can tell me where I've got it wrong:
>>>
>>> 1. Binman is too large and prescriptive - what you want is a thin
>>> frontend/library, with configuration defined statically in Python
>>> rather than driven dynamically from the DT.
>>> 2. It modifies the board DTB, which you don't want it touching.
>>> 3. It adds code to the U-Boot image that changes runtime behaviour -
>>> and it crashed for you.
>>> 4. The maintenance cost is unacceptable: you can't be confident you
>>> can fix it yourself when it breaks one of your boards.
>>> 5. A vendored Python script with a small wrapper gives you full
>>> understanding and control, which a shared tool doesn't.
>>
>> Did you really just put my email through an LLM?
> 
> I copied my full reply (including your context) into Claude along with
> some patchwork threads to make sure I had not missed any points you
> raised in patchwork. It gave various suggestions which I think helped
> avoid my bias creeping in and to improve the tone. I don't mind
> avoiding that with your emails in future.

Isn't having opinions on The Right Way to do things kind of the job of
maintainers? If you're avoiding bias in your responses then I may as
well just discuss the merits of binman with claude by myself

> 
> I suspect Gmail also highlighted various sections and I accepted some
> of those changes too...in fact there are four suggestions in these two
> paragraphs right now.
> 
>>
>>>
>>> The runtime crash is the one I most want details on. Binman's runtime
>>> support (reading its tables from the FDT) is optional and shouldn't be
>>> pulled in for a board that doesn't ask for it - if it was, that's a
>>> bug I want to find. Are you sure you have CONFIG_BINMAN_FDT disabled?
>>>
>>> Perhaps Qualcomm's images are so simple that it isn't worth using
>>> Binman. That was the view I took when I saw that you were just
>>> creating an extra binary. But then I see Sam's series and I wonder
>>> whether there is more to this?
>>>
>>> There is considerable value in having all boards use the same
>>> image-creation framework. The data-driver approach is much easier to
>>> configure and understand. See [3] for a talk on why Binman helps.
>>
>> Well this is what it all comes down to I suppose. I have nothing against
>> having a common framework, it just shouldn't be so opinionated on things
>> that really aren't related to image processing.
> 
> Do you have any thoughts about improving / resolving the points above?
> For example, you mentioned at one point that it should use yaml rather
> than device tree. Perhaps we can discuss it on one of the calls, if
> that is easier?

I did mention that, but on further reflection as I stated above I think
that support for dynamic image configuration should be an extension to
the core functionality if there is a justified use for it. In the vast
majority of cases I would rather expect that the correct configuration
could be selected from CONFIG_SYS_VENDOR/SYS_BOARD and the toplevel DT
compatible properties, perhaps an additional mechanism to select a
"flavour" if some board needs to support multiple mechanisms for baking
U-Boot.

In any case, from my experience trying to engage with you to find common
ground such as with EVT_OF_LIVE_BUILT I don't feel as though spending
much more time discussing this would lead to productive or tangible
outcomes. Even in this thread I'm again reminded why engaging in
technical discussions with you feels like such a time sync.

Given the sheer size of binman and my issues with it being so
fundamental on a technical level, I suspect the most practical solution
would be to introduce a replacement that drops the OOP model and just
focuses on allowing tools like mkmbn to work without introducing custom
make targets with a long term goal of deprecating binman and migrating
everything away from it.

Regardless of the technical issues, a solution would need investment
from other custodians, and for me personally at least it would have to
be someone other than you maintaining it. Your unwillingness or
inability to discuss technical topics on their merits [1] makes it clear
that you care more about what is effectively engagement farming the
U-Boot lists and wasting time than actually improving the project.

To be explicitly clear (as if I wasn't already in my first reply), I
chose to respond and clarify my position on binman in the hopes that
(despite what experience has shown me) maybe this would be productive.
If you had replied and said "actually using DT for configuration is good
because XYZ", or "yeah it's true that binman has a bit of a learning
curve and maybe the API could be less opinionated", anything that would
actually let us talk about binman then this could have been a productive
thread.

You maintain the tool, you SHOULD have opinions on how it should work
and you should not be afraid to express them and justify them,
particularly if you believe that a criticism comes from a place of
ignorance. Likewise as a maintainer you should be open to changing your
mind with additional context. When you refuse to be upfront about your
opinions and instead masticate endlessly on the broader topic, it
suggests you either don't care or are using dubious tactics to avoid a
technical discussion. One that might make you face the reality that e.g.
binman isn't the amazing solution you think it is and maybe even does
have some very fundamental issues.

*insert inline reply "i never said binman doesn't have issues" *

If you want to have a technical discussion let's not do that amongst all
this noise, try this again from my first response in this thread.

I'm increasingly busy with maintainer duties and my own contributions to
U-Boot, so while I do certainly care about long-term health and tooling,
the time I'm willing to give for those discussions is limited.

[1]:

Like for example this thread where you so far have completely avoided
engaging with my critique of binman and instead responded with needless
commentary, AI summaries, and questions that only serve to generate
tangential endless discussion: "Perhaps Qualcomm's images are so simple
that it isn't worth using Binman. [...] But [...]"

> 
> - Simon
> 
>>
>>>
>>> I would be happy to take a look at this to see if I can figure out
>>> these issues. Most SoCs that have moved to Binman have needed at least
>>> some additions and changes in the tool and I don't mind digging into
>>> the issues you have and coming up with proposals / solutions.
>>>
>>> Regards,
>>> Simon
>>>
>>>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org/
>>>>> [2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org/
>>>
>>> [3] https://www.youtube.com/watch?v=L84ujgUXBOQ
>>
>> --
>> // Casey (she/her)
>>

-- 
// Casey (she/her)

