Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6073CE7B5E1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C489B86D93;
	Wed,  4 Oct 2023 11:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rTY7fgZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310D286EAD; Wed,  4 Oct 2023 11:25:34 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 831F086D20
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32488a22810so1737013f8f.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696411531; x=1697016331; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=GFdv021Rizo0irSmbiVZ2+j5AStRjh0n86anmc7BRps=;
 b=rTY7fgZEhWDanJNTdOWyOF2PYlwnvMnaqvuzIbDal8C5vCe2usJfAiCBeIcI6wr4lE
 Iz7EzIaZSuHzEaxHrm6updY3mnoJJgYRfGhk3VIMsPopkOGQRADlvt49Z4QuBPM3ef9s
 6rQQO+l14WQ6M6+D/r+JP+K3uN/UX5kOh3kd+A/7aRHrUqR9JKY/idIzXljBtyqhZt0L
 b7xohssV2hvvT+28qtNBtEp8zkbnmBjVmjLYB3YN0H9TgX/G/Pkm3A1RjLl15DXGM6Je
 CFBMrX6J+7BHImd/DDyRkE2J99IZ+ctUcTPn6ethYNbf+DBgxXK7wonOWwDSG8R15v4y
 364A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411531; x=1697016331;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GFdv021Rizo0irSmbiVZ2+j5AStRjh0n86anmc7BRps=;
 b=VDzbUYrQEDoIggPvMCOiTgtU0OHrqCuIgg0YtJMWmvN7OY20YTZ9Hppmb5pXO7d8SA
 dOoA3qCjJrzZ0EQchhOKMIOKOjaZ5vgB8lzMVhx9G93+VVM1mQmNO7g8j2R7wPWrbATh
 5NidNxMZtmEkPcHfr2kmskuVCzDJZGuo/QQ+HPy3Yq4VbbOKVVA2h9ZlsQ3p/4UzJDbR
 8X5aDB9Iw4KDosOfxB2H5NC2i2gD3AlqiuWu95Yf8xjuOcEuWqczUSt1MdCZFOIPDhrQ
 0JxksMexI8vpQCYLifuHTQDi5ELzjz2Qow54ppGW1YybphGfBVY2QhM8RqLfQIsCgMlz
 2jow==
X-Gm-Message-State: AOJu0YyfhE3FMmjtQq7GWO4Q2nnUGY7x9l2SzhTEO0jYjfLeZ2+EuPPK
 JOg+8CfcC6XEfCiVmg9Nxx6hIQ==
X-Google-Smtp-Source: AGHT+IGW49DOuowNyf+PSIRDHHvYDsWQSPfEk/7q2mUN2OcetxmHm7dOnIpkk0ckufkvSsHNH1B+Qg==
X-Received: by 2002:adf:fd46:0:b0:326:d915:d1c0 with SMTP id
 h6-20020adffd46000000b00326d915d1c0mr1571279wrs.56.1696411530975; 
 Wed, 04 Oct 2023 02:25:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5?
 ([2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a5d48c8000000b00324887a13f7sm3543861wrs.0.2023.10.04.02.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:25:30 -0700 (PDT)
Message-ID: <63ee9c84-dfcd-4752-b51d-9ca9d313734f@linaro.org>
Date: Wed, 4 Oct 2023 11:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/2] ARM: amlogic: ad401: enable SPIFC
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@salutedevices.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Igor Prusov <ivprusov@sberdevices.ru>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20231003202908.16654-1-ivprusov@salutedevices.com>
 <20231003202908.16654-3-ivprusov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231003202908.16654-3-ivprusov@salutedevices.com>
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

On 03/10/2023 22:29, Igor Prusov wrote:
> From: Igor Prusov <ivprusov@sberdevices.ru>
> 
> Enable Amlogic A1 SPI FLash Controller support.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> ---
>   configs/ad401_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
> index 31752cc7f5..9a88e20a6a 100644
> --- a/configs/ad401_defconfig
> +++ b/configs/ad401_defconfig
> @@ -51,4 +51,5 @@ CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
> +CONFIG_MESON_SPIFC_A1=y
>   CONFIG_WDT=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
