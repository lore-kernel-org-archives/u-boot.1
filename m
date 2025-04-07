Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C2C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BE3182F65;
	Mon,  7 Apr 2025 20:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nTBHvEHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45728303C; Mon,  7 Apr 2025 20:11:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DEEB82F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso46992045e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049469; x=1744654269; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Xvlmke5/p5rhwDUx9m9zn9BsfJkyyCQgkTZSI0AplF8=;
 b=nTBHvEHd5kZJFu1KosdjuSNCFQmmPPEIWaLwFkfZdiTn9tC/0AddyJUw8T2ifxLIwQ
 vsE0cNn1OFZbQAs6haYRgkWWXg5RYwg3B+0gm5g549SvU9mI9m3Yj6A7Kzjd9QNpR0Yu
 UkS+MEQAzVpl2ygWhZRBNsJlwp05Ts3RqfihYOS1uPS0hHKX7QwD1liwqOnOOHrw0vlK
 vNdO7/PvUtt1oIX38ba2xJqTj5DyAm+iGj1foKCywlvtJJWABkSMnF+lyoc9X4SsRSmL
 gL/IR91Fbvqg/8Y6qG1HLXr3sMQ+bcgCg4eSpeIYSPra8ECgH5o8b/3JVRjsVgAUSGc3
 YxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049469; x=1744654269;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xvlmke5/p5rhwDUx9m9zn9BsfJkyyCQgkTZSI0AplF8=;
 b=l4NoT0gWbOw/BLzsFrOcRqiD3ZpP7pkMyxsIXEuaQJ+VOQW8+Rnye+8bpWy9Xun7p0
 rPldcmP5mQPYRPu2BvtRz9vD5yRdqBLCDs2VIFfbboE+iZNAVgZ47YU8EH+9kp+YflWX
 0BpsIp0GFOWTLKCdB1d5spTZ1JoyBbqt5YGLgbB0mnBCBCbpJGXSfmXuEcbXkNeXPccK
 Pp/iE7s3Ykd2FWP85uURM6w86S4ioL4iZVUyR5Y3t5corNRDdSU45TYwHCkPKF5VPfzX
 Dpup53MQIeusRBPjFbB/G84PPWt/0xxusBe2VnKhwG1B6xZUVgFuIHWOFmMoW3mkET0V
 1K+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGpSAvVdNm1gqjjHJLmKV/O64HHJC4CFcE3j/GT9TOV995aewP14Av/LWJ6KeMkNTjOHnbF+M=@lists.denx.de
X-Gm-Message-State: AOJu0YwRhh9D+EfBdZ7MxaLaT9M050iXw5ZvkaLFXvTGr4J19yFwAfJv
 VC3ZlZVh4fhwcz21HKvQJI5fS6Snsqs7FbLb/JmIBIS3WgsZq9yMf8t/5KPaVbYAywNwcyq1NSD
 K
X-Gm-Gg: ASbGncuKyhgRmpLMKXFlOb6r5WOJMhLA7VL7XYC67VNHDndD2YN63x7Ddjn3UMgZdvE
 M6jS4Ar+n52BBqu4Fo3sGwUvzsQam7efdhsjbRhVv9CZCGQPTXVuH733m2qCwgeEaZ73vQ7wAMk
 TePgbL5I+A5fjjlG/spse2vh0wJZPU8ydoIZjOaQJGqFUVI6P/23DZh3Qtg2+taTJRhBXJ21YBK
 kS6jphSZApuMGwnYCaYzGX0ilct7BMxuLfqsgz2vsyWjYY6zT/19PLxBIsH6hItvicw5Kcf6kaJ
 0BHmAxHme/3/IEOLwmN7e5eyANcqTIb+xeyVFFIhqMmfqAVAPGXBo1iuZL0S65D1XrCIg14FbIt
 4Ibosw2w/UUOitNgIOmJtZw==
X-Google-Smtp-Source: AGHT+IFpM3TuozZrdw2yVB/qio7k/KCptC2aIPHn9m3O3a6Zt9Z+7du8mgZKd9g+dycoPLZjcXAsqw==
X-Received: by 2002:a05:600c:1e28:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43ed0d9b49bmr116702015e9.23.1744049469136; 
 Mon, 07 Apr 2025 11:11:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ecasm13180249f8f.18.2025.04.07.11.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:11:07 -0700 (PDT)
Message-ID: <f7b78e48-bb2c-448a-9df6-32fb33ffa7cb@linaro.org>
Date: Mon, 7 Apr 2025 20:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 13/13] board: dragonboard410c: Update maintainers
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-13-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-13-524aefbc8bb4@linaro.org>
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> Ramon has been inactive on the U-Boot mailing list for over a year now and
> the DB410c port has not been updated much lately. I've been doing most of
> the DB410c-specific fixes/rework lately and try to test it every now and
> then, so add myself as new maintainer. Also add Sam as reviewer, since he's
> been doing lots of testing and reviews for MSM8916 recently.
> 
> Cc: Sam Day <me@samcday.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> @Ramon: If you want to stay co-maintainer please let me know, I'm also
> happy to just add myself and Sam additionally.
> ---
>   board/qualcomm/dragonboard410c/MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/MAINTAINERS b/board/qualcomm/dragonboard410c/MAINTAINERS
> index e78f5b2d6421c7e41436cfbb3292f06b10324c6d..9c10fa3053b042ef0b5b44a2c3c4a2f2956cfb60 100644
> --- a/board/qualcomm/dragonboard410c/MAINTAINERS
> +++ b/board/qualcomm/dragonboard410c/MAINTAINERS
> @@ -1,5 +1,6 @@
>   DRAGONBOARD410C BOARD
> -M:	Ramon Fried <rfried.dev@gmail.com>
> +M:	Stephan Gerhold <stephan@gerhold.net>
> +R:	Sam Day <me@samcday.com>
>   S:	Maintained
>   F:	board/qualcomm/dragonboard410c/
>   F:	include/configs/dragonboard410c.h
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
