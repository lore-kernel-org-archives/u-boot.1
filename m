Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF82C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 07:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0310B8091A;
	Thu,  5 Jun 2025 09:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X9bZLryu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3D881E25; Thu,  5 Jun 2025 09:51:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EEF080050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 09:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso5305285e9.2
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749109893; x=1749714693; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jBQB1lb2I/Al3lfGQMEBgk9DkW9/PALEFZjrOBdHTUk=;
 b=X9bZLryu4QJVLdP/kdMKAzoY2AwxERsbQzCAQeP48coy/3mhYghZFuC/mketv4xFRN
 nktT095d31Bg0uOfv7aHqnHCcwx/kUirf76Mn2Z04KXrygvdaDh8IcBhTOzH059//iHF
 W6AtISsRwqE5LFuB/ZUMLwN6nlruN4g8YNHgIw5TAJ9Y1M/54fQ3RM71bOwNCchy0Sqd
 W1On/9kAlZcUlF+rQj973GldiQ97QrbbkotI8AGaAIhfnkNJnqrlUP9mSmMGIVF1QsKh
 JZoc4jSm7krWKaETjnWwi1+gYFQQsFKvXNUc37HmWW527ZYrZIgbo6uUSHQL02PyyPG0
 Ojng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749109893; x=1749714693;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jBQB1lb2I/Al3lfGQMEBgk9DkW9/PALEFZjrOBdHTUk=;
 b=nWtO/czuhs6N0l8na4Xl6/uvf8zDFfEuFj23PeCeIAJccS3IKn3azwRbp5mD+g4fXK
 4AHryEapq/gV+1guTvzkmBv/D30Dj2V3cBbhGa6oIL4PUC4rXchPQRUZiD2Jr2k4EmK6
 l1fM4YgxWtH1i55F/hmFA7e+dM8aMa2Wm4YztcDLZqdLHvAzdJE9f+FKesEPFZ4WjYaS
 UOug/rOJjF/OYfCMaUikXSdVV277ONqsu1HH3cZR/80arDxaRcL3hF0BwdC7F8LYETUT
 kniQdSPGvfisX/dAYDNss30ld+l9+FECHQjmKzNFHexx+0g1XG7/GC1RDs6toilHHszV
 akOQ==
X-Gm-Message-State: AOJu0YxqQ8YbFWWRKW3o9BKAyq6f6/Sl5VPhLBZFraY3R5MGfVM5UsHm
 ASX7oww2rq1PFjSONU+T6VNP0qX5AU159InGf/K73M6L0PBjK5cNNxoSgggEALK+Dt+D727/RI0
 1hty/
X-Gm-Gg: ASbGncuP6m1m4dmngz/clkjKZD9Y7cFa3bTMyds7bjnlmdu1lup6kUDzuVxRvMyW9pm
 dPlzW5Hs6+FnG2Dm6ArY9+DmvFZsVw96wG7MAw8TxzRF61q4tLiifoUUQqChrpFN+bzhXy/TQx/
 FJvc0W5FDHAcm5NBGqhLhWndiF/SFbLGLkSYTImNJphohqbTV7BH6aCyfWg6ywD620tEAWSVG1H
 kKfgmqySvb3gAwTT6k7O34MylI/i7kbb4/N6+5IuYZYN7IhWHS8jvRN/5b6/M27WActnUBdCJOj
 3fDMiic+ee1Yef9Qod2e67nYZJpM10aRaKBw1hmFjt4+AZ6wHeVoA9NW5OJ2zUzvNinS+g7Gq+m
 Wcy/hk+LDeOFGRhbWyXiDKsNuDdIY
X-Google-Smtp-Source: AGHT+IGn1GRVoG7SmOHqCyn8alXx9N6hEbl7RP4xMOypm0vzvXpDvHhtRjZS+HDtk4gnLn7QTVfKaw==
X-Received: by 2002:a05:600c:4f14:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-451f09b845cmr53581685e9.0.1749109892556; 
 Thu, 05 Jun 2025 00:51:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd?
 ([2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f9816cf0sm15817675e9.16.2025.06.05.00.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 00:51:32 -0700 (PDT)
Message-ID: <3874c4bc-0e9f-4b8d-8217-5c3958925e47@linaro.org>
Date: Thu, 5 Jun 2025 09:51:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: Determining Simon Glass's future in the U-Boot project
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20250528175901.GG100073@bill-the-cat>
 <CAC_iWjJ88yhfFpWk0YYxh7n+RNOYNuvUDEBghdqvS-yLTatuqA@mail.gmail.com>
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
In-Reply-To: <CAC_iWjJ88yhfFpWk0YYxh7n+RNOYNuvUDEBghdqvS-yLTatuqA@mail.gmail.com>
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

On 30/05/2025 14:15, Ilias Apalodimas wrote:
> Hi Tom,
> 
> 
> On Wed, 28 May 2025 at 20:59, Tom Rini <trini@konsulko.com> wrote:
>>
>> Hey all,
>>
>> First, I am not happy to be writing this email. But at this point, I
>> feel I have no other choice, for the good of the overall project and
>> community.
>>
>> Back in January[0] of this year I made a post with almost this same
>> subject line. At that point there had already been a number of problems
>> working with Simon and the overall community. I did not include a list
>> of links. At that point the easiest answer would be to go to the mailing
>> list archive, pick any thread that Simon and I had and see the long
>> disagreements. This trend has fundamentally not changed. And while I
>> started this out with some threads and my summaries of them, instead I
>> want to point to this email I sent this mornig:
>> https://lore.kernel.org/u-boot/20250528170533.GE100073@bill-the-cat/
>>
>> And to repeat what I said there, Simon needs to decide if it's more
>> important to work with the community or have his way every time. Simon
>> cannot have both.
> 
> +1.
> 
> Since I was involved in enough ... I don't mind reviewing patches and
> giving feedback. That's what I signed up for. Reading the same 30+
> series patches though with only 10% of the feedback addressed is just
> not working.
> 
>> Simon needs to accept that some things he think are
>> good ideas have been rejected or he needs to fork off from U-Boot. Or he
>> can ask the community to take over as the project head. If the community
>> wants Simon to run things, I will step down and just be an individual
>> contributor again. Five months of this experiment shows me that it's not
>> working at all and will only be a bigger problem as time goes on.
> 
> FWIW I think you are doing an excellent job and I'd like the situation
> to remain as is.

I'm backing Ilias and Casey here, you're doing an excellent job, maintaining
such project is difficult and you do the job.

Neil

> 
>>
>> And, I mean it. I cannot take the additional stress of what new problems
>> await me every morning. I do not take the above lightly, but I do not
>> think the project can become healthy moving forward without some
>> resolution here and quickly. While I won't claim my time as the head of
>> the project has been perfect, I have tried my best to always be honest
>> and fair and to seek compromise.
>>
>> With respect to voting, would anyone volunteer to run a poll from
>> https://civs1.civs.us/ (which is used by the Yocto Project /
>> OpenEmbedded and likely other FOSS projects/communities) ?
> 
> Thanks
> /Ilias
>>
>> --
>> Tom

