Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D46ACDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0656A84994;
	Thu, 25 Jun 2026 17:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yF2iPydr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A831E849C5; Thu, 25 Jun 2026 17:33:09 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A488498C
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso29077995e9.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782401587; x=1783006387; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=utax1RabiMf0ubTzkcZqoJueBxntS2qh3K/01f+kHpM=;
 b=yF2iPydrAa3isVN9KD6R4h58/knT8ek2PRbFJAQoFs7xIh4h54aa1VV42mJcVsRb0m
 esEe17x7Al+CsbI9CgECMq4Lcw5iSokSrGLTdgA2G3pQMsynAlYFncLh4tu4xWRFV72Q
 64KBcZiQNbr6MdjGv3I65TMThHzbgGexQhoAVvy1apty4+iab4MZlA4ImcBdlMMmpQi8
 HVhFKnrtZ18MWLgWglRVJ4isMfMSXlPejv7Q227sS7aZWo7KbGgXjqGw0M+4J38Rns7R
 dYQs4qo3T7M0/4EJdHzB3kmpR1gWwa+16BffhxAaZ3ajh7/cQYSkJZgaXHW7sYFSts5j
 tjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401587; x=1783006387;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utax1RabiMf0ubTzkcZqoJueBxntS2qh3K/01f+kHpM=;
 b=mv0qCO677G2hoUIwJ3VibCKfbVCRct94ft+9DchLmElZW2AmSoiYerKhvFmAj2EBO2
 3VWSDUs0meH0fhrNR8gNymK0VGwVfzrktmaNogxNnKHL4HUkQlUle5cyP4nsjd621iBs
 TPoXLkGvEnaq3pgdDdWGnSd7z8COifSt5rX4jFbsF/T9dV0Wt0z7bIAiVzJ/1k/3bBNX
 aaWCR51c1+3L5bccnhW+BNMTlriNPdcGfkvhS0Dss01yPzfxbBRMmOx5Vchk6pru0XOD
 SamsxlL+m508xYSgEHXm7ZsF+MnkmhErJo07ehQesGd4J6gZbg8mPw7LAf//APE9/7cL
 5S/g==
X-Gm-Message-State: AOJu0Yxq6UrkNqbLRRgIlEBlrVoMkQliFUpjZKolD/ouE4TsS/HnbKka
 hIVqpVSpD2xswy6ceuJGJ8h73u33/alUFBv9VD220Y/SGqxgtLoFtZmWEOvqNT/wkuA=
X-Gm-Gg: AfdE7clzhlixCa9BqvsiZH0gae/wRCtkC0s/cgOwv77wDmBNtleakPrQ0M+NUgaAGpI
 99NGqLvg5F/V2IyzJex0p+HLjR7OOE93yrNDPLT+Q9P0HUUd2uyBM85TfOGS5lMveHAqL3+CFon
 Mc8Vy3v7kp4yzbDMPgh+SRYpoOlSyDxS4dQnSva850+Q3fPzXUT5CsXoTThhYGK036ysMbUZ4V0
 +mEe01se94IcHgcewAAC8Sc8K2MqNwgSqeyGY+USMlPC/7xwRPAdQ3wUmRH/pjdvMObyobD5aYN
 FxO4Mv0NxfEv5ek4HbvOcoSGJ2JAEN+/KOIO2fUu8ST0C/HOQ8y7qgOABZudbharpZbQw2N6ea4
 MQoW3h9SqTz/qqdwaCGIDWbvHvfbW2be6BQRbv14beDZ/C5VrKctk09LYvV05IRvHL+QTe7KoES
 p2xu0YdinzyHwD9ODGiVfy3PKoZfhqZStumonzvIP8lwg5iWRqJicC7L4XAeg2XuNr6g11
X-Received: by 2002:a05:600c:8283:b0:492:5551:19c6 with SMTP id
 5b1f17b1804b1-4926683b0f2mr41741955e9.7.1782401586496; 
 Thu, 25 Jun 2026 08:33:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ff1be9sm5381025e9.8.2026.06.25.08.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 08:33:06 -0700 (PDT)
Message-ID: <f1ca876b-8918-4add-9692-4992de5d552a@linaro.org>
Date: Thu, 25 Jun 2026 17:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] treewide: change email links from mailman to
 patch.msgid.link with message-id
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Gaynor
 <simon.gaynor@ezurio.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20260624-ml-switch-ml-links-to-patch-msg-id-v1-1-da694b9ba71c@linaro.org>
 <CAFLszTg+EqM+gqmZLrz-M2HRLCR8BrUcEswJ9=e+9Ty-cQtLvw@mail.gmail.com>
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
In-Reply-To: <CAFLszTg+EqM+gqmZLrz-M2HRLCR8BrUcEswJ9=e+9Ty-cQtLvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/25/26 17:30, Simon Glass wrote:
> Hi Neil,
> 
> On 2026-06-24T14:39:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> treewide: change email links from mailman to patch.msgid.link with message-id
>>
>> In preparation of the migration of the mailmain mailing-list currently
>> hosted on the denx.de infrastructure, migrate the links in the code,
>> comments and documentation to http://patch.msgid.link to be future proof
>> and always link to the expected content data and uses the message-id in
>> the URL which will help find the appropriate e-mail in the future.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> arch/powerpc/config.mk                   | 2 +-
>>   board/boundary/nitrogen6x/README         | 2 +-
>>   doc/chromium/chainload.rst               | 4 ++--
>>   doc/develop/historical/generic_board.rst | 6 +++---
>>   lib/efi_selftest/efi_selftest.c          | 2 +-
>>   tools/rkcommon.c                         | 4 ++--
>>   6 files changed, 10 insertions(+), 10 deletions(-)
> 
> Typo: 'mailmain' should be 'mailman'. Also the message says 'http://'
> but the URLs use 'https://'

Indeed will fix

> 
>> diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
>> @@ -32,7 +32,7 @@ archprepare: checkgcc4
>> -# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
>> +# See https://patch.msgid.link/1348500648.2514.2.camel@petert
> 
> Trailing slash is inconsistent - nitrogen6x, chainload, generic_board
> and rkcommon have it; this one and efi_selftest.c don't. The
> lore/msgid.link convention seems to be to terminate with '/', so
> please add it here and in efi_selftest.c

Thanks, indeed I forgot it on those ones.

Neil
> 
> Regards,
> Simon

