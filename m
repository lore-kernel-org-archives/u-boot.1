Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E5BCD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 13:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5C884879;
	Thu,  4 Jun 2026 15:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DBSHOG6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DF684908; Thu,  4 Jun 2026 15:17:40 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B3C80087
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 15:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b4e1ade7so8113005e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780579057; x=1781183857; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cqkWHam5WdKQOYWcbUQJ9T0+912Puos2eet4nsBujFw=;
 b=DBSHOG6pCeKvnCaKXC0Xn7idkZorJ+6PGjDGLwd1yzslBYY/cGaCGDdesFsXpJAvlK
 95ydXJ6ZF2K24fPUgiZT0BOX/nKJo3QzZv3Q6BZRB+W7gcoFLLiK0t3YprHm3gL4O2iU
 wNoSy4Dw5eRN8g3yh6h3h1sut5O3W9ygToGXTTyq/eYY2KwAiknMhviawt9zwumeCWAy
 JUWc4s/Du8W5N51lVw/U9kMRNXKdYLOBZu4ptTZqFXs61uijZe/thD8k9EGHCl+i3DWN
 DyKLIb7maXFvNWxcB7kDXPH+aiULPNfZbpzM3mf5/RYO/rdWZkidIPDPj84t9T8vACEd
 aRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579057; x=1781183857;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqkWHam5WdKQOYWcbUQJ9T0+912Puos2eet4nsBujFw=;
 b=WsQwjfwl1OTlhoAsq4aDCnqe3UIcLgRdEdKykkRsy8OXOX3C0DgMy/Hejm5r7NilVz
 MyBdQ13XPpPXlC5Hws2N/qST8EtdeNWAvGf9/XpAB66b3kbK/Ty2p9eRlvN8uOrS8Td2
 QUIXVkbEAPO69UmlQDcz10S2DWmtaDFCuVIza+bhWroU3SGDI52VL3DDLUxMNexyV6fC
 0pAwe6yPdQe0+RK7BcQRyg8xYc6diT+4QfHeWezefA4hsS6jM/veCLmTbnLZdOcha03h
 gzuOBc92uW056EAtyS/KIfbPvKW63mTvbqScCOmEvhzXKb9jIplRM2l6h5iwM8bq9Rpm
 IjUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nk86DaTjvOVOB05Frgx6As7GX9Yrl/6bKBkuP2ohioBMf4G6NzU1gdSEV7wBciauYJ4tSykI=@lists.denx.de
X-Gm-Message-State: AOJu0YyZipLnjdNgWfpGLs90QVqxcehS36KAERNnDjpV5BvFXNWjLRL6
 q9zXhC77xs+3M7IA8vK//Uh5/iYMv1mEDfPvrjN0IPbRlwbCucRBpK/5940jqB78cXg=
X-Gm-Gg: Acq92OFbtCPID992L2yqtwpPJhAIX2D+XjpqVdriHQQTz/QxukUG1d/7Bi6lZCIaPJy
 LiCCXmp575/6yIL5z6/k2G7yXw7Qkpgg2ipAoPvTG35ZVBTMnLCNsM9OiiES8Gj4b1c149k6Y2M
 TlHRz57LiIWt5Mhw2V8Mh3AB0u9yA8snY5m7q+C0TZHUIpH36T2pPMehzX4VPc5GxHTTHdcLh2T
 PtZFHUtEPLL4SrS+3qP9YTW6AeDwVGV4rUsEUIz/S/HutXiu9PAd/ffyaEmAKddiH909aMd6HMl
 e3l/asrHw+V4bUWxzfuuv6XP4RfVuag2gG9kECn4VXgmiIYMC1k+C5/Z2kNJ21iZVkrKBECzD2J
 p8p2eKTiNgIm3fOM4kmO1ppIt5nb3Dz1a05DshdijsmNvl/a12h2QD/2DK/bUmkynJ2zY+h5JQB
 MpsY7BfIrTy7T7N9tmwovoJTJKbCflL0KcmU7Lu+ViLUV/69jiC7z8kxpc1lSJUAmdjKElidj/N
 lrNMNZHw5wZnIyd6lj2rOISfA==
X-Received: by 2002:a05:600c:198b:b0:490:b642:ce2a with SMTP id
 5b1f17b1804b1-490b642ce70mr130813235e9.9.1780579056758; 
 Thu, 04 Jun 2026 06:17:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39eb04sm73755415e9.6.2026.06.04.06.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 06:17:36 -0700 (PDT)
Message-ID: <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
Date: Thu, 4 Jun 2026 15:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
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
In-Reply-To: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
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

Hi Simon,

On 6/3/26 07:06, Simon Glass wrote:
> Dear U-Boot Contributors,
> 
> I would like to introduce the U-Boot Concept tree along with a few thoughts
> on its role in U-Boot.
> 
> By way of background, I have been a contributor for about 15 years - around
> 10k commits and countless reviews. I have introduced many innovations into
> the project: e.g. sandbox, device tree, C test infrastructure, Binman,
> standard boot. Of course I could not have done any of this without the
> U-Boot community (nor would there be any point).
> 
> As the U-Boot project has matured, the demands for mainline stability and
> rigorous review have created a natural friction for landing complex,
> large-scale feature and refactoring series at the necessary pace. This
> structural reality, which has slowed the adoption of ambitious efforts like
> bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Concept
> tree is designed to alleviate.

The main issue to land complex large-scale feature and refactoring series is
mainly the lack of human highly qualified reviewers, proper shared project
infrastructure and funding for paid work. Not developers.

> 
> I strongly believe that projects must evolve in order to stay relevant in
> the long term. This includes code-refactoring, new features and subsystems,
> along with migration of old code to use them.  A look back at the U-Boot of
> 2010 shows how far the project has come. I don't think anyone would still
> be using U-Boot if it had not evolved.
> 
> I have set up a 'Concept' tree, a possible future for U-Boot, as a way to
> regain the old pace of innovation. This environment is a proving ground for
> new features where we maintain a lower bar for risk tolerance and
> completeness. We will accept partial and speculative features, provided the
> underlying code remains robust and of high quality, with the shared
> understanding that features may be dropped if they do not prove beneficial.

I'm clearly against having a separate official "U-Boot" fork tree, this will
only lead to confusion to users and contributors if it shares the same
mailing-list and name.

> 
> Another difference is AI. I believe that AI is the next step on from
> compilers, which also took a long time to produce good code and find
> acceptance. The Concept tree welcomes (and encourages) high-quality AI
> contributions and reviews. It accepts PRs and allows reviews on PRs or the
> mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so
> sets a high bar for testing. It uses a separate Gitlab instance for now and
> of course uses a separate mailing list and Patchwork project to avoid
> cluttering the main list. Concept runs an AI-powered cherry-picker so that
> it keeps up with mainline. In no sense is it operated as a fork.

I'm clearly against using AI for any of development or review work as it
can't be fully trusted and will monopolize precious reviewers time reviewing
AI code instead of reviewing legitimate contributions from individual and companies.

Using AI for CI testing and regression testing could help if it doesn't add
a burden for maintainers by reporting false positives.

> 
> Once features are landed and functional in Concept I hope that many will
> find their way to mainline, although inevitably some rework will be needed.

Still I don't understand your point, Linux or Zephyr can land very complex
features with a single tree, what make U-Boot different here ?

> 
> I recognise that introducing a new 'Concept' tree might initially cause
> confusion or concern. This is an invitation to work together to define its
> role. I welcome all feedback - positive or negative - here on the mailing
> list, privately, or on irc. Let’s discuss how this initiative can help
> U-Boot remain the defining firmware for the 2030s.

Our immediate priority is helping U-Boot establish the proper technical and
legal infrastructure to receive funding. Adding AI features, maintaining
separate forks, and managing competing domains only distracts us from the
critical task of switching off the dying Denx infrastructure.

This is my personal opinion,
Neil

> 
> [1]
> https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com/
> 
> Concept tree:
>                         :
>                         ::
>                       ...:::.
>                   ::  :. -
>             .   ::::::-  - ::. ..
>            .:: .:      -==  =.:.
>          ::.- ::::. ::. :=:. ::::
>    ::. ::   =..  :.-::: =:
>      .:-:-. -.::  ::=-:=:
>    ::::::=.  -.::   ===:       ::.
>      ::.:::=::=:   -===:--==-::--::
>        :.    :-=-.:==:.   .:  ::
>                 ===:       ::  :
>                 ==:
>                 ==
>                :==
>                -==:
>                -+=:
>                =++=.
>               .-===:

