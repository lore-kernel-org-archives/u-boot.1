Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F907CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996DC846D3;
	Tue,  9 Jun 2026 14:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nYaGfqpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DFB84701; Tue,  9 Jun 2026 14:10:26 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC26807C4
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-becfa735b9aso735745966b.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781007022; x=1781611822; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wgendA8xttWSr5qmfvOinCRAPhD60xBXQNFah77xxns=;
 b=nYaGfqpvouTqZp4DUOq+HSsjpppKb4vdmmzMn0Vq3c4jclWJ47pXc3ntHojavoJT0t
 FLwdgg3mMUi9s/A8QvOA8rHI4qzc94sECkU9i0g0X0b1IU1Eqq0gDlMk16TgcliCrRkm
 Ou4mRKF3lXWK7ETMlkzF2SPv4rfV08LeJ2JFlVk6nVS+GqQvJxiWGXxYVaGlSLAtIeMo
 c2EpOHFrFFZih9HKK7DP4YjoegxXms6TpA13gqWfxjz5tuWLlEUNSrj1C9mkrMuT/sLj
 u5YdY6SnUX7veTdQlCJLF53Us6xVuSf1G/xtuzBPa7fJIsyb0Ltl7ifw71RSYT8KF5Xk
 muQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781007022; x=1781611822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgendA8xttWSr5qmfvOinCRAPhD60xBXQNFah77xxns=;
 b=sPzhlvualCNG0MBX54EbwQJHZ38CWGkwimr6K9W3Oc1m4taNuRsTLkBNUYwpZxPJ/v
 FkPi0JNRwKneIY4kRLDgXKkMNM/dMnTTpK9RF46yAzZlPHiKEDzby3SLCWuzo1OV1hTN
 GwLU7wjHpw+Xp+pI0oAEhvnIUx6rvsqQgakuERbl9HPXRZ3sIV4/pD84a0R8SWdAd+YS
 UopsY7D9AAQwcrCZ3Ecf3jpkm2HIMvLqDrb2IDM2yLmVvAckD2TJLk1unQGlzTc+s3wy
 KTsJWGvc+jzoK8PxUd9xXCME3/sjMFa/NOfrBuUlUFetaKVRUjEsqkOOKWKZkFEpAZ7y
 B3KQ==
X-Gm-Message-State: AOJu0YxJ0JKK539ypSESc3xJNoikFvZt+GjryUjkasjbpcCMy6Omfz61
 7eXpQb8UYPno+WXS1/LHni+osCV25Ag8CYhl1osmJ6X/bwFv98SXlopDuPFoAmyL3b4=
X-Gm-Gg: Acq92OGsjeoSEEI0iEKKP+V3/8OEvcNQ/B1lAIFko7wGQ+SsZ4VD1YuVJFTA1ndH4BP
 xJsxm1JK1XA0cy+gLkVETTa6TtHyy/+WWaTlmzI4k69F5L3P1EE8C/qSjSOD0seAR/avU9E+aw2
 nZtOvTpqIDXOug9SFSwuWR00pdTpndBHthAuqcZfCQhNMD3G+LXNm4dxr1lpC9MOxCdLzrKC9fm
 4lACKTye2h8nBhl2eO9XEdjR12vSafbqnBtv3iYm0KVrfmLY9YOXcXiPYu1vuiD9nBqPNdlyZxy
 xPJHLQzBeaP1mN/uTT30EFPUXhCw28DViWngeNBTGACwVZ3oOImyuXgPtQDweHXbUTP9YNRnuXv
 rbghycEU7OB7k7SQLckGMDQA3pRuxhhAMVWgesrpKrsQtKAdhPliBPBAtXYeIdnJ1eEvvE3KI86
 ozOhNvnuKnmlvz91WwzeEA5ilXnTEgav/u0ulr01dGJHLw3Rf8AtFeP7FOaGcZtj5jIEh4gPtIm
 g==
X-Received: by 2002:a17:907:c518:b0:bed:eb8b:d404 with SMTP id
 a640c23a62f3a-bf370866e4cmr1026612866b.16.1781007022295; 
 Tue, 09 Jun 2026 05:10:22 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055308063sm1031161666b.48.2026.06.09.05.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 05:10:21 -0700 (PDT)
Message-ID: <cbdb7a26-41d3-4f46-bbcb-c289ea844c29@linaro.org>
Date: Tue, 9 Jun 2026 14:10:21 +0200
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
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAFLszTipPLKDSyOsgCWPXQx5oORCQjUrohfZG1Z1P91iATzLhA@mail.gmail.com>
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

On 09/06/2026 01:31, Simon Glass wrote:
> Hi Casey,
> 
> On Mon, 8 Jun 2026 at 12:06, Casey Connolly <casey.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 08/06/2026 19:13, Simon Glass wrote:
>>> Hi,
>>>
>>> I want to start a new thread to work through the issues which result
>>> in later versions of [1] moving to custom build rules instead of
>>> Binman.
>>>
>>> From what I understand there are some things unique to Qualcomm here,
>>> as well as some general comments [2]
>>>
>>> Let's first get a list of the problems and then we can look at
>>> possible solutions.
>>
>> I wrote a whole big reply here but then I realised it was not likely to
>> be productive, so I'll keep it short and sweet.
>>
>> For binman to make any sense to me, it would be a very simple frontend
>> and library for vendor/board specific image processing. Configuration
>> would be static and defined in the Python scripts, dynamic configuration
>> is huge scope creep.
>>
>> If that's all binman was, and it was co-maintained and used by other
>> custodians then I would definitely see the value in using it to avoid
>> dealing with makefile fragments and other nonsense.
>>
>> Instead, it is a massive and overbearing "feature" that does stupid
>> stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
>> (which crashed for me btw). The moment I try to use a tool for
>> post-processing and it changes U-Boots runtime behaviour like this I am
>> fully out. Choosing to design and implement something as overbearing as
>> binman is just absurd, it prescribes a lot of functionality that I do
>> not want or need. I'm just not willing to invest so much time figuring
>> out how it works so I can fix it if it breaks something for my boards.
>>
>> As-is it seems much more appropriate to stay within my means and ensure
>> that I feel confident that I can maintain whatever Qualcomm-specific
>> tooling we have. Vendoring a Python tool and making a tiny wrapper for
>> it is just the plainly obvious solution, I know exactly how it works, I
>> can fix it if it breaks, and it doesn't fuck with my U-Boot image or dtb.
>>
>> That you are so clouded by your own perspective that you feel the need
>> to email me on the list to ask about problems with binman as if I
>> haven't already expressed myself clearly both in my mkmbn series and on
>> irc (and as if comparing my patches doesn't reveal the issues) makes it
>> quite clear that I'm much better off keeping CONFIG_BINMAN=n
> 
> Thanks for the candid response - I'd genuinely rather have the blunt
> version than a polite one that leaves the real objections unsaid.
> 
> Starting a fresh thread wasn't meant to suggest you haven't already
> explained yourself; it was to give the topic enough focus to actually
> resolve it, rather than have it scattered across review comments and
> IRC. I've read the mkmbn series and I want to make sure I've
> understood the concerns correctly, so let me write them back to you as
> a problem list and you can tell me where I've got it wrong:
> 
> 1. Binman is too large and prescriptive - what you want is a thin
> frontend/library, with configuration defined statically in Python
> rather than driven dynamically from the DT.
> 2. It modifies the board DTB, which you don't want it touching.
> 3. It adds code to the U-Boot image that changes runtime behaviour -
> and it crashed for you.
> 4. The maintenance cost is unacceptable: you can't be confident you
> can fix it yourself when it breaks one of your boards.
> 5. A vendored Python script with a small wrapper gives you full
> understanding and control, which a shared tool doesn't.

Did you really just put my email through an LLM?

> 
> The runtime crash is the one I most want details on. Binman's runtime
> support (reading its tables from the FDT) is optional and shouldn't be
> pulled in for a board that doesn't ask for it - if it was, that's a
> bug I want to find. Are you sure you have CONFIG_BINMAN_FDT disabled?
> 
> Perhaps Qualcomm's images are so simple that it isn't worth using
> Binman. That was the view I took when I saw that you were just
> creating an extra binary. But then I see Sam's series and I wonder
> whether there is more to this?
> 
> There is considerable value in having all boards use the same
> image-creation framework. The data-driver approach is much easier to
> configure and understand. See [3] for a talk on why Binman helps.

Well this is what it all comes down to I suppose. I have nothing against
having a common framework, it just shouldn't be so opinionated on things
that really aren't related to image processing.

> 
> I would be happy to take a look at this to see if I can figure out
> these issues. Most SoCs that have moved to Binman have needed at least
> some additions and changes in the tool and I don't mind digging into
> the issues you have and coming up with proposals / solutions.
> 
> Regards,
> Simon
> 
>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org/
>>> [2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org/
> 
> [3] https://www.youtube.com/watch?v=L84ujgUXBOQ

-- 
// Casey (she/her)

