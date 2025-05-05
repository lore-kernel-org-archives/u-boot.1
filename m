Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECC3C369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 07:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D6B81F66;
	Mon,  5 May 2025 09:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KlfgMJBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D59D681F7E; Mon,  5 May 2025 09:26:12 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717068091A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 09:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso38722435e9.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746429970; x=1747034770; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=GIIcTVroQWMd2HLgkXndFFfRm6dNkx/BSen0019CTwI=;
 b=KlfgMJBaFwSUpjGYiLLMjJcIiyrygOOZ/qO4jjMUHlJLh1QsfL9mqqfb4Gom1m8OJz
 BgWKy1G1iP4LqbVwWKsIZqrpV/GdSj+y3LofuMzvRT/IbEXE8suJbESarBJ3lsJIwRN4
 HopbapAh42eyOlOzTALmlx1y6fvbEGL7OkMHV/NdbVqtHkWTuZanT2I0KPEmeP6LnNhv
 ez52RcIjSFKjp0X4Eaamy6bw5Tio50MB0W5zdeXW4GczHGfKsXmF0AYvNJxqG7ztEp2B
 HQdauzG1edlz88GpRnnvcaD/av8YwqriPjnHLEePJbklJGmQvoHFk8LZjnHL4EXfiJ+J
 VJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746429970; x=1747034770;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GIIcTVroQWMd2HLgkXndFFfRm6dNkx/BSen0019CTwI=;
 b=bhvhLZ0gTi2IyFUd4rjm7mQnOylUUVX/Vw14pj1uBSkJRJf2urTNG7atVYQOSstuQt
 mzxj+P7bXjKfiChJd7kgnE+ZaKcx9kSukFUeE6Suw7Jx2ofujcqqt6YudEQN4SZ6gr3E
 kN9EMPohTSlVBXXW6zfCw5qRuwuDtHXh/tewoQj2yufNpa0dT9+KZcSAQFTrNYA1a4XC
 fvV+b+hf3teorVnXTe2DS3cal+z3otz++n8Ds0vp9OFb1nBqvyYzW+HD4NUEtfZvONt5
 GoecW6VFnxpX5YjZ6TupdgfhRqSzSfvmvrlVRxyCUGby/hjiuU0CcqRCo94Xu2NdaH05
 FQLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjVy4LN9rGMEUyuhxHZSmrsvTGlzglBW6OxhlDQuoFYY3/kSDGtR8Vc7e0+WOCVY9jemk8Hm8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8XlFYbexHL3JUcZWStsqXn/r5+Ry1Fc6cUmASerEKEZIgNzw/
 7p167FnbAirqC5itAG6xFW79IzprRJTs4+d9DDAXRSanNr+D7yAF0jlJAkE+8Bc=
X-Gm-Gg: ASbGncsyeiEvfACGVR3J0uLd/aVhPLR2WO/FrL9sw6gnFO8hGFWe/aCuaDosrbl+hn2
 eOlr1RhqVML4EDt5fjIYh3BKMQFGyyXk2OTU12EsJ8sgLVxGoLlx5WrYiq7CoQJCbYKCMOA9SOW
 RsPqwtuFpts9nLNBSzeN8JRL4jCGpU0J2fPJBRk4vBjYaVFI2WEnn8HWrR5pUh0zE89ouUESm/F
 dwUHw6D2s86WbZEcK9sTgBa2U7YVQAZUeXCjUf1ffurbdzkYpU3lyGXGAp1QbBwnW7UkQlGXMKn
 uq/qdXCDYIDiAMmqqNCvMlmCNHSk6YIpLyDuwl8WJfubHTA3fGI7daYr6eLhZggNbepBNJd2ulV
 KHbfWk3i0Rv8eI75JoA==
X-Google-Smtp-Source: AGHT+IHx9R5lCas8kJqaka5JL8NTo65cNXLtnW7w5rELRU3k/z6ucmd+pPg4AJqbEwPXvHP93jJbQw==
X-Received: by 2002:a05:600c:3554:b0:43d:aed:f7de with SMTP id
 5b1f17b1804b1-441c492371cmr38560945e9.21.1746429969865; 
 Mon, 05 May 2025 00:26:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3?
 ([2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad762fsm170611835e9.5.2025.05.05.00.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:26:09 -0700 (PDT)
Message-ID: <0469bb8b-042d-4c6f-974d-6d1879262e91@linaro.org>
Date: Mon, 5 May 2025 09:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] mach-snapdragon: Update fdtfile logic to work for RB1 and
 RB2
To: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 loic.minier@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250423051132.292329-1-sumit.garg@kernel.org>
 <183C90A92BBF63A5.32718@groups.io>
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
In-Reply-To: <183C90A92BBF63A5.32718@groups.io>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 05/05/2025 09:23, Neil Armstrong via groups.io wrote:
> Hi,
> 
> On 23/04/2025 07:11, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> RB1 and RB2 have three root compatibles where the last one can't be used
>> to decode fdtfile name (qcm* vs qrb*). So rather just rely on the first
>> compatible to retrieve the SoC name.
> 
> OK, so "soc" would be qcm2290 instead of qrb2210, what's the problem since
> you have "board" with "qrb2210-rb1" ?
> 
> What is the difference between qcm2290 & qrb2210 that affects U-boot ?
> 
> Same for qrb4210 vs sm4250.
> 
> If you have a custom board code, you can still match on the root compatible.

Forget my comment, it affects the fdtfile construction....

> 
> Neil
> 
>>
>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> ---
>>   arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index deae4d32378..dc8220e89b4 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -437,16 +437,24 @@ static void configure_env(void)
>>       /* The Qualcomm reference boards (RBx, HDK, etc)  */
>>       if (!strncmp("qcom", buf, strlen("qcom"))) {
>> +        char *soc;
>> +
>>           /*
>>            * They all have the first compatible as "qcom,<soc>-<board>"
>>            * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
>>            * the dash.
>>            */
>> -        if (!strsep(&tmp, "-")) {
>> +        if (!strsep(&tmp, ",")) {
>> +            log_warning("compatible '%s' has no ','\n", buf);
>> +            return;
>> +        }
>> +        soc = strsep(&tmp, "-");
>> +        if (!soc) {
>>               log_warning("compatible '%s' has no '-'\n", buf);
>>               return;
>>           }
>> -        /* tmp is now "rb5" */
>> +
>> +        env_set("soc", soc);

OK, so you should move the other env_set("soc", ...) code in the other else branch
to avoid having a double env_set("soc", ...)

>>           env_set("board", tmp);
>>       } else {
>>           if (!strsep(&tmp, ",")) {
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1677): https://groups.io/g/u-boot-qcom/message/1677
> Mute This Topic: https://groups.io/mt/112410772/900740
> Group Owner: u-boot-qcom+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-qcom/leave/13197875/900740/1403832380/xyzzy [neil.armstrong@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

