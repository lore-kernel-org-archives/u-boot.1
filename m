Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310DCDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 09:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A06C84832;
	Mon, 22 Jun 2026 11:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zKrobYrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92308848DC; Mon, 22 Jun 2026 11:13:51 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FED800AE
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 11:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso4627924a12.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782119628; x=1782724428; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XeYA9AlkGQ9mxxmte50dSkru4U4W8/Us0a61eV6ngLs=;
 b=zKrobYrtix82wLTdReGR95LsWFCoHFBwhg+4vId9h07j01T2/6Tv61tpHUVXmOVxcu
 994gZty/+zAwuqhAATXrBU8aE5alQCloGJw/X+xfADZxi89x7ngl2cvP5d7nm5UGtorR
 JlziD57ZpZa6aKDhTs1mtyX2HaDsFYV7fKVglTrzkxXPUyEB5nY6jjmShGYo2DAzQewc
 qN1pAhX3VecXuIwVmi+uFmLVxs5EH6XZDJgKBmK5UvoLLNvkvR+Q+y3o6yD+qY8VqNCx
 aEuvB7eZLWJ8RLh8QG7BlaA2yiyYywdckvfAjuULa+JLbLEGd3VZ0xsKV/Madanm3tLI
 420A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782119628; x=1782724428;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeYA9AlkGQ9mxxmte50dSkru4U4W8/Us0a61eV6ngLs=;
 b=ngC+U99Mq0o7iZ+wj8q8gOUZC/uQQXJc3H6swkf+e+1SB016olm/MG81R3JU///8eR
 I5pr9n4eFBINtERP6W4IuzBr8ZZzfb8U1B9VTbNgQ8eaGpCzqBj1f2rzJ1OgG1XcXYYC
 7FZvCNdOft+lxZanITX4XmWw35R6GhFvKznp0iNRu/c2l523sv+WgVRCSIy2eLE1/MIl
 9g70SVnWiD2CNszJpujPgHvr6Nc5qs7/VI/NQ3nfbW5M9eemRNe647+mPG6kHA+LmcJh
 XDRMPF0QetAKkstsNcymRVdqJlDw0itM2iLZdmhLpzcHOHsaw13f5WudLJDtHgIxPaHy
 S0YA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d/znr3/wBOiqJft9OxK1P8xsmTp0qOefYVa7fdisIn01y4tQUSE/Be2Y4XQrRlxP0xxpol9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzdAJfQAmI+EDdxfvXXPWzxlMccYnMBIi56Ukf6dzjLgjZaMCwF
 AYYVC694rJuGTvq08IPE/KZ2aGzan4iBm21jKnuq4X0ChMZBEOMqA1hFgALKCXvKAHA=
X-Gm-Gg: AfdE7cl/rV7hGx3Q5LGwTUOG+d0S1sP/jBL/Yysn0wetHnpn/VouVfNleDSIr2YA5i4
 ecA0MTkuWhA/EwKt8pvHpecwYIvxpWnNVXu6WBASDY7J1y1vX9Y3KFO+WmnSikKS0RF7PuWds5h
 h+KaORo7eCMTC7C+1uv0J8am5pSr7F64sDdgz37/HWUO4QDkFKghOaM1HdDuEyDQL7aMJUVC6E+
 jGHqygPrfbDC8YgHAWMOEHZcY9Vl/UZCwkreYh/GXCjiU5oZ8V2e/zXYn2tpzbhz4idVUa+4DcL
 UvUmj1pO0TmccASBkMtPVOG4qK1YmkMIaKW/odDgzSrfKwsKWje/USJVTnm//JR4Seqz2V2yEm2
 jdf64NF8X2bHomckCAR+rTb0+4xGwHoriQjUCQ63f+KaKGaf6G6MsARal0RjPGbQxvw96rYdglJ
 K82Mi3bWjm73KHprHN9lYUKwy9bjnOUib/xYYQR88tCBOG63YNcHlrDiB95qrTaypbLA==
X-Received: by 2002:a05:6402:5303:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-696edc5b035mr6211029a12.4.1782119627431; 
 Mon, 22 Jun 2026 02:13:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ec5:4405:96ac:b43a?
 ([2a01:e0a:106d:1080:ec5:4405:96ac:b43a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b86de31sm2622280a12.12.2026.06.22.02.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 02:13:46 -0700 (PDT)
Message-ID: <43e161d2-55bf-42c9-a8b7-e2de71430e3f@linaro.org>
Date: Mon, 22 Jun 2026 11:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/18/26 17:08, Simon Glass wrote:
> Hi,
> 
> On Wed, 3 Jun 2026 at 06:06, Simon Glass <sjg@chromium.org> wrote:
>>
>> Dear U-Boot Contributors,
>>
>> I would like to introduce the U-Boot Concept tree along with a few thoughts on its role in U-Boot.
>>
>> By way of background, I have been a contributor for about 15 years - around 10k commits and countless reviews. I have introduced many innovations into the project: e.g. sandbox, device tree, C test infrastructure, Binman, standard boot. Of course I could not have done any of this without the U-Boot community (nor would there be any point).
>>
>> As the U-Boot project has matured, the demands for mainline stability and rigorous review have created a natural friction for landing complex, large-scale feature and refactoring series at the necessary pace. This structural reality, which has slowed the adoption of ambitious efforts like bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Concept tree is designed to alleviate.
>>
>> I strongly believe that projects must evolve in order to stay relevant in the long term. This includes code-refactoring, new features and subsystems, along with migration of old code to use them.  A look back at the U-Boot of 2010 shows how far the project has come. I don't think anyone would still be using U-Boot if it had not evolved.
>>
>> I have set up a 'Concept' tree, a possible future for U-Boot, as a way to regain the old pace of innovation. This environment is a proving ground for new features where we maintain a lower bar for risk tolerance and completeness. We will accept partial and speculative features, provided the underlying code remains robust and of high quality, with the shared understanding that features may be dropped if they do not prove beneficial.
>>
>> Another difference is AI. I believe that AI is the next step on from compilers, which also took a long time to produce good code and find acceptance. The Concept tree welcomes (and encourages) high-quality AI contributions and reviews. It accepts PRs and allows reviews on PRs or the mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so sets a high bar for testing. It uses a separate Gitlab instance for now and of course uses a separate mailing list and Patchwork project to avoid cluttering the main list. Concept runs an AI-powered cherry-picker so that it keeps up with mainline. In no sense is it operated as a fork.
>>
>> Once features are landed and functional in Concept I hope that many will find their way to mainline, although inevitably some rework will be needed.
>>
>> I recognise that introducing a new 'Concept' tree might initially cause confusion or concern. This is an invitation to work together to define its role. I welcome all feedback - positive or negative - here on the mailing list, privately, or on irc. Let’s discuss how this initiative can help U-Boot remain the defining firmware for the 2030s.
>>
>> [1]  https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com/
> 
> Just to report that after some brief discussions, we have agreed on a
> path forward here (thank you Peter!).
> 
> Concept will become a custodian tree in U-Boot's Gitlab instance. I
> will run it, with access to my hardware lab. It will cherry-pick from
> mainline and accept code through its own channels (PRs and separate
> mailing list + patchwork). When features are ready for mainline, I
> will send patches to the main list for review in the normal way.
> 
> I have been working to migrate things off u-boot.org (lab, gitlab,
> blog... and email). I am transferring u-boot.org to the SFC once this
> is finished in the next few days. If we do end up setting up email
> addresses for people on u-boot.org, I'd appreciate keeping sjg@
> 
> Tom, Neil Peter, please can you ack this to confirm you are happy with it?

As we already discussed in private, that approach works for me.

Thanks,
Neil

> 
>>
>> Concept tree:
>>                         :
>>                         ::
>>                       ...:::.
>>                   ::  :. -
>>             .   ::::::-  - ::. ..
>>            .:: .:      -==  =.:.
>>          ::.- ::::. ::. :=:. ::::
>>    ::. ::   =..  :.-::: =:
>>      .:-:-. -.::  ::=-:=:
>>    ::::::=.  -.::   ===:       ::.
>>      ::.:::=::=:   -===:--==-::--::
>>        :.    :-=-.:==:.   .:  ::
>>                 ===:       ::  :
>>                 ==:
>>                 ==
>>                :==
>>                -==:
>>                -+=:
>>                =++=.
>>               .-===:
> 
> Regards,
> Simon

