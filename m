Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97163CEFC21
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F4B88EA8;
	Tue,  8 Oct 2024 17:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rXzpsOXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182A588EC4; Tue,  8 Oct 2024 17:15:31 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2188288DDC
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43057f4a16eso451425e9.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728400528; x=1729005328; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=esCOiD63IexPslStwAMxogPyByd0wbNEbF3bPl2FFwE=;
 b=rXzpsOXDIjWohbKZ8Wn7vg6n4lu4Jnh2b7QOClGnJAbs3mo9GUiozgNWq11eYNQ0JR
 Jf2f63VZ7eXWZDLjoQt1S+2t8N3xVMhgUFlQN5BQvceE3Se/OvmSYz7rZLHgxKfAMHJG
 QlPn8ar/se5coR0yi8iemwg+yqeZJBlWvP4//LKSopzL9PBwxAiIdzMPWNxpW1QllBc3
 c9mkC77foOv/Zd7rBFKAj7d6Zlx8UAUhNCW/EC1dC2lW40/ZTRN0EvP3PPoiKNl4Dxty
 l1LGVcmCLr3TbkyeiDnVjm3t88cdvsICj9oFshrmXF+mUbzEjUrVaEpP2IsvJ30qDUm6
 W/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728400528; x=1729005328;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=esCOiD63IexPslStwAMxogPyByd0wbNEbF3bPl2FFwE=;
 b=bsKuZlbJQz624MXm0IRk5FxjxWaueGtEWdloqCO05Ldf8s9bzTYHIAK1gBmHEIoNLy
 LVZWRVvVE4IsFe8Pd123SK2h1utejnByOFcFW6y0ThUhPn+2y8lwmqhiM62PtbXa6A+y
 dcizbwkNSlk7nJk3Syv5EnQKGmg5OP5tuWvJQebN76t5IkGEUNYJdecnIxFqZm8Bpmue
 kRAdbrLezICzo1wFjZRkpgX59Xv9q4IhwqwxnarpOsFoizocG7rREY6vQypMunSESU2F
 kn7Q+uZT2rO+Lm6wbzT5C8TPDu9kqFXBcSNU1OqgKiVSjMVaGhX4fKMfdCRrYnlz/qpP
 rZUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvRQF/8lte1wwIj+6ACjjNzOkhe7LWogD68ZE2NmiwjgA0Rz5p0Gai1LOccZhaXOUfBCB2c0I=@lists.denx.de
X-Gm-Message-State: AOJu0YxKLmrw1B4je2qH6Ka6R/4vQwJSR3MBOKQnR779Afn6YecfDtT2
 GZXW8/xqxcFzRy/J+5g7HcMCYtUWm2L/N/jIdJO4OuQGaAcpfZRfE6aqKoHRwIk=
X-Google-Smtp-Source: AGHT+IGr/mcTbpyN8X7wjJ2gxsdleRxQexn9fQJeKyjLWz/laeNIMxx/JDilDT3ktTqTNXknDr63fg==
X-Received: by 2002:a05:6000:b08:b0:37d:377d:c7b0 with SMTP id
 ffacd0b85a97d-37d377dcba2mr702050f8f.18.1728400528453; 
 Tue, 08 Oct 2024 08:15:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19?
 ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d376009a0sm707676f8f.88.2024.10.08.08.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 08:15:26 -0700 (PDT)
Message-ID: <c89b43b3-7e48-431c-95bf-d88a6c3fc091@linaro.org>
Date: Tue, 8 Oct 2024 17:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] video: meson: dw-hdmi: do not fail probe if HDMI
 regulator is already enabled
To: Jonas Karlman <jonas@kwiboo.se>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org>
 <b0174edf-5055-4c67-827c-2edefbf969fa@kwiboo.se>
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
In-Reply-To: <b0174edf-5055-4c67-827c-2edefbf969fa@kwiboo.se>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 08/10/2024 16:36, Jonas Karlman wrote:
> Hi Neil,
> 
> On 2024-10-08 14:58, Neil Armstrong wrote:
>> If the regulator is already enabled, this happens if the regulator
>> is set in regulator-always-on, regulator_set_enable() return -EALREADY.
>>
>> Ignore the -EALREADY return since it's not an error.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/video/meson/meson_dw_hdmi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
>> index 587df7beb9b..ee219ce6ec4 100644
>> --- a/drivers/video/meson/meson_dw_hdmi.c
>> +++ b/drivers/video/meson/meson_dw_hdmi.c
>> @@ -419,7 +419,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>>   
>>   	if (!ret) {
>>   		ret = regulator_set_enable(supply, true);
>> -		if (ret)
>> +		if (ret && ret != -EALREADY)
> 
> You could possible relax this further using something like:
> 
>    ret = regulator_set_enable_if_allowed(supply, true);
>    if (ret && ret != -ENOSYS)
> 
> That way you only reach the error state when there is an error with
> supply, for other states e.g. when supply is not found, DM_REGULATOR=n
> or the regulator is already enabled will be treated as success (ret=0).

Nice, thanks for the suggestion :-)

Neil

> 
> Regards,
> Jonas
> 
>>   			return ret;
>>   	}
>>   #endif
>>
>> ---
>> base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
>> change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb
>>
>> Best regards,
> 

