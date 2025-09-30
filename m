Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A38CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4DFF832AD;
	Tue, 30 Sep 2025 20:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lHvVMRkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0665D800D7; Tue, 30 Sep 2025 20:38:52 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7C8832AD
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso4286931f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257529; x=1759862329; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DWaiXN1vKIufAKLCcIBOQZ0ccL+0qUQsDaU7TSzQQmg=;
 b=lHvVMRkT/94fCucSeHHlmZVa2raPuwleN9g0UrUqxvIABsZqjoU3Xm7PPvinzuMgbY
 YjePXnaHyMkodCPE95MOjKRx66WMxKXy28pPov5m8obeHhRJCY79FH5EfdsjI8lSAgSM
 QeGULbfdxDvhmu+kuGwu0zYqbZPwk8GsMartWLZvLzbVdvnAUcgtp9BxGIcvgyoBw5g9
 iT/JNZ9YSGZKYEWMOae/in5S2JNHcMk1Z9jkC4U/pI0/s7c4jlGbXpfBUSsBtle7JJ84
 0HohbdArCPlPWXoJZHihBhmoSrGr8lPhak3k2pY6aTv5CeLhyQwzXx6dBCwjg9Z18+52
 1WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257529; x=1759862329;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DWaiXN1vKIufAKLCcIBOQZ0ccL+0qUQsDaU7TSzQQmg=;
 b=t9wEAb4+De4tAcx0gOFgFQynpiJD9q2qVrWYGaVd1vsgxR0MtrrjLlHKh6fV/4zMqA
 3YpmlEHw68FMd8k6zqT+THlQ8XnTLtFvVs6vtb1sBhepfXd2kPJ7DnRJoSn3OOR8tXLV
 hebM9r/IacfJLltvz7iUXj0+KZvFc1PqszGGQwBf7Hu7a895U38gVRnmviCzkianzUD9
 RuLILC0TrPTtzWKccjsIgmeyib47kHWmtzG+8oPWWaMHLNE23YSp1xTWXLYHVmhamP7d
 /7Sh076hJ85VLv8NuLAB8twZyIrEi4YgqUwRs0c+sxPMMGfZUKeLciERP4PNKznKBdlH
 KLsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ6C1jpPKH5LAK9uWdxR/TcAeGrgO/FFv19RQMtUMVPFyI7Yh3SHlrpmInhCdAa4GB9xz54gw=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ1/F0WA59AgOxre3vMTN5MKFw4/5pt1Bm5uuUhk9EWSqh2UAk
 43b3VAfc6x5jxAm3BmZXyt0hBpoPVb+JDYVkfbrISMn4lUdRjbWP7A5Kki7ad/jGjPc=
X-Gm-Gg: ASbGncscNED1Ke06/MvXmQj5rqMyiYgbGLi/fKiGefutog/V0szpveN0cs210ZvkrwA
 A/RpHRwf7bQMzg/jfpFkFZrHguRdNdiTvTwFbCmfFLKJ8x85MdXbTBY5uQH2fnWvAt7TnZDfIfw
 LuNdWBkzJRypjajZcZR9dDlWhS8wIICdYqsa9uv6Nlwp4PnRaiSwy5FmrcLpEdmitSARFczdNow
 IGpACGTio4ieCplBvjs+Is/T2GsNogwyASJ3PoXJHeI0vORKJKG1E99mRqxnKiIbYHAPMNinYn/
 oE8xgt654Vqv/fgDDTNq2+xstXyULRQuaJ0v13e/CWhblc5rhze88TQ+uKE2H3TFeae5T1IusgV
 hDPt/KqPemh20TLeBpOUFwjL6OZBpkIwPoKLXHFbvRnUOWoPDmqOFJXofwnTgt9fhysAnNYvl24
 6sVS3OtTL3lsit/z2ASXOEaL+7vi9zo73ytA==
X-Google-Smtp-Source: AGHT+IFrQe3UYaE2aJO8za3K4j5IzeIb/OxGFkTt+vW9iRFGqBYEa6suoprxez53O4+gjLV52hqAQg==
X-Received: by 2002:a05:6000:2204:b0:3ee:b126:6b6 with SMTP id
 ffacd0b85a97d-425578050abmr521989f8f.34.1759257529452; 
 Tue, 30 Sep 2025 11:38:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a18b76sm4333225e9.18.2025.09.30.11.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:38:49 -0700 (PDT)
Message-ID: <2f9588ff-3022-4fa1-962d-80264a28ed81@linaro.org>
Date: Tue, 30 Sep 2025 20:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/5] doc: board/qualcomm: Clean up debug options for QUP
 UART
To: Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
 <20250924-2025-10-misc-v1-4-7e75842ca714@fairphone.com>
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
In-Reply-To: <20250924-2025-10-misc-v1-4-7e75842ca714@fairphone.com>
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

On 9/24/25 13:30, Luca Weiss wrote:
> CONFIG_BAUDRATE is not relevant for the QUP driver, and neither is
> CONFIG_DEBUG_UART_SKIP_INIT so remove them from the doc.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   doc/board/qualcomm/debugging.rst | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
> index c3289c9e4e346058943afd9c803cc44426841544..42821f6546c6425c4b55e1f89501b94bbf9d0623 100644
> --- a/doc/board/qualcomm/debugging.rst
> +++ b/doc/board/qualcomm/debugging.rst
> @@ -42,7 +42,6 @@ Older boards (db410c and db820c)
>   
>   Open ``configs/dragonboard<BOARD>_defconfig``
>   
> -	CONFIG_BAUDRATE=115200
>   	CONFIG_DEBUG_UART=y
>   	CONFIG_DEBUG_UART_ANNOUNCE=y
>   	# db410c - 0x78b0000
> @@ -50,7 +49,6 @@ Open ``configs/dragonboard<BOARD>_defconfig``
>   	CONFIG_DEBUG_UART_BASE=0x75b0000
>   	CONFIG_DEBUG_UART_MSM=y
>   	CONFIG_DEBUG_UART_CLOCK=7372800
> -	#CONFIG_DEBUG_UART_SKIP_INIT=y
>   
>   	CONFIG_LOG=y
>   	CONFIG_HEXDUMP=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
