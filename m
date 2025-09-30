Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA31ECAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B0880819;
	Tue, 30 Sep 2025 20:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FMwoAaQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1580E835B0; Tue, 30 Sep 2025 20:39:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057D8835CB
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso147681f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257539; x=1759862339; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KEHMBUpyQlDsmEusN5JpLujBopgCP5c8q5jl66+2qkc=;
 b=FMwoAaQjsC3ZejKwNPy77wRon38eBe0li/0+FAncpeROM/1R7lfFsCYm72ISAhsdx1
 fJXyCVwUYcrWw6gyM9sstcQQqTIDWZoYi7pOoaCH1gDLQniJzdSyCcTpIll+UflRFN/b
 tv/uY9zLTP2HojGwDOBE5JrzeYVxaTAnSYpnMn+NXPSaVVi13FND6bNUoufJYSzf14s8
 seDl2YH9PKwRYk7BmPv/59zVyeZjHk6JotZwMApuPgP+f/QcfvDnx+BRbKwYeIebEYvv
 ax4w7wAusjfORrZMSXfBwl9+xarzNQhlBG58ZH8NnECfgpdjiWxLfRIckRkOV19gmw91
 ereA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257539; x=1759862339;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KEHMBUpyQlDsmEusN5JpLujBopgCP5c8q5jl66+2qkc=;
 b=LJS3i6+JGAQTT3k35Ch+c66MMcDnLlKDS8mkal3CAtJIYA01j5xIfjpPmRGuiBjqOd
 FhItYuWcnx4AQ9oyy8qM2+q4o3GvBqYKuADK0HW8/zKN/SkCzWF6GoSoRykgUbL/UJp4
 LZ3UiD7XtrmDOR2baGvLDpRkmPbBY9ik43DPZ94fprMozpggixJYyu596x9Xq0bg4a0l
 0HkXUf1uGd+cO7S1jyc/7iCxfO1ttncbSdEeEs/yjyfBjCpm81JKUJEkHa9yA92Bhp32
 EZb0rtwZnLv/NloaD0njF/FdsSN/IxkfO3J7m3HTM8UX38aaF7hpPA7mh22q/03vy7dG
 IAog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTWi0otoRQYtas/4xuxXZh5WvdPx3BpGfK3CMr97cBpPLPLmv/5H9l2xmReahAccS5cFVGXOw=@lists.denx.de
X-Gm-Message-State: AOJu0YwZa2c7CqWuVkNB0H4hWQRF9J1WsFt6g7T6UmMt3bRa/Do3hEUK
 1B8MtS+FvPJI3gzorpZ1jl7W4//XRJ6yBFYt5FHW2u1DtPbdmsyUQaPlk9zwi0Txb4I=
X-Gm-Gg: ASbGncuZ1z0UQuxyOV+0T4pCVNST1Ems130D5AUgShWt62LmkM5q0f4/HeMmBer8GNK
 oeExEijhVM58CIMjQo2toecuvR8vNwEqQdwIlhLOmEOxjNMuf/hEwrbqA9pxgSkFzKWmErRL9fj
 ci/bhpn5NzK+LfwpNy6JdU1gThphtMoSz2lbzniqEsV/Rn9+DcUr86D5n9jN7viRT1diN1qOOB/
 8Jz5+T/jANE9spg9KFzFbYEnhbXIatKEzZugQjAKFuf5O6RKT2liq0mhdQHNlGpsjlvHs1qWnr5
 Rh/JXfEMnhX5FrZ1991nxJYbWqB8Lj2ggeaslk6rRKoRkkeqpKHoJvKMCPL/O77lZ5i8zE14qcz
 WXEX9YE3UXoGJGns7f+u251d/uYnztlYw3raV14fwwriWXPaV1nmYEPOAFcufDzzQnB4qQKNT6T
 XQ2WNuz6jDjLRq+M9+8I7EZ8ysZchTIE0wtA==
X-Google-Smtp-Source: AGHT+IGNv4DcHXqqMqBsvYfBNxybQ8g5oxm6FnHH+aLLcryL5l6C9l+jd4CnEExHcv9QRbrDoJwU5A==
X-Received: by 2002:a5d:588a:0:b0:3df:22a3:d240 with SMTP id
 ffacd0b85a97d-4240f26169cmr4732515f8f.4.1759257539263; 
 Tue, 30 Sep 2025 11:38:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602efdsm25027279f8f.34.2025.09.30.11.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:38:58 -0700 (PDT)
Message-ID: <da528302-9ff3-4824-b96f-c973fc1f3780@linaro.org>
Date: Tue, 30 Sep 2025 20:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/5] board/qualcomm: add debug config fragment for MSM8953
To: Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
 <20250924-2025-10-misc-v1-5-7e75842ca714@fairphone.com>
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
In-Reply-To: <20250924-2025-10-misc-v1-5-7e75842ca714@fairphone.com>
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
> Add a fragment similar to others to enable earlycon.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   board/qualcomm/debug-msm8953.config | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/board/qualcomm/debug-msm8953.config b/board/qualcomm/debug-msm8953.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..1ccd70d0d3f4209ad1dc323d59f9d4ba581dcb91
> --- /dev/null
> +++ b/board/qualcomm/debug-msm8953.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x78af000
> +CONFIG_DEBUG_UART_MSM=y
> +CONFIG_DEBUG_UART_CLOCK=7372800
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
