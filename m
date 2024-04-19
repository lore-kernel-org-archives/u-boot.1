Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE456C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68BEA88771;
	Fri, 19 Apr 2024 17:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jmX1Pjlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E150B8876F; Fri, 19 Apr 2024 17:22:36 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20F188772
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f90so12544075e9.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713540152; x=1714144952; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ayzvRBNyou9jDzbB4tZA28GyxBVA/iP9hpa5oCUGRds=;
 b=jmX1PjlkxBr+whsnGXMig/fpup9J4m7dYaoUqNwKNOr3dpaAuA7xa9gcDyvyS1Pst6
 ZsMHsqSBmITRCSoKBH5WUkUDPiJwwhIGeUoqhDSbhxXJkRH6OcOXx41oFueDtmDVK41x
 WTVnVe1CAO+t/ryfrh69pDixeBANYlHHbGPGRbAx6em8hKVMh7lN/hTfdOkn8GIN6PBR
 3+2zh4ejZyS45JE6U3RjXe4S887aqBV2FWmLAiGcadqSl8O0ljsFfx/uDL+BO6qMb2Y9
 cD1KeJggTp/Jd1pyrmTvM7YnEXFmwVZPJ4LnaK5+oBe4UTkcLe7/CjHnb48v9x8RHLso
 QPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540152; x=1714144952;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ayzvRBNyou9jDzbB4tZA28GyxBVA/iP9hpa5oCUGRds=;
 b=fQmRyY2pSW22zokMOJeh9ky2CyIkZdSJqpDobQtlV12PMBTe8W430ksK2x5zLFlIm5
 iuR6dCwwM/MzNHE5mIOobCSaxxuP+oKXHUqDbisnEbONm8VvGmriWPJrFUNJUpm1Pnew
 fTN6CyTjiOWPxWUKNtU1fNVYbCV/T0MVOcLOQoAPMi654Fb+BSsNFkXF5km0NB33hPAg
 LP2eF1GsCzPZKX2+m0UpnlHuwGXBfQbQ/FDvRdOBvafRaDPliH89Vm4jMW7PwvQbbzG6
 xtyhPm3kdo45FLD+VnBg/s6vVtX8ulM6eq8VJxUniTQ8MgnSBaiTpw/VouZlTKMM8nl/
 2aIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDrbmQE7wblAY/QLAh/dbgXiHiFbS5qGhnwPgysdYXxvzWYMB3KJe2zw7E8tMx/GL2fzP/ojrvK/pE6SG/uQQZhW/sBQ==
X-Gm-Message-State: AOJu0YybDtBrfRpBYfecDUgVmeRGi7KqDeRAUG9q+dkg7skjc5Or04a4
 a0FWbvgobynWUbDKB7nTpQmMdPR+gx/1R3gzaZMBhJpeMB6mwC/GIwDlLJmrT+M=
X-Google-Smtp-Source: AGHT+IE0BTBAmBcMu9rx/KfMVmMYshFLubRfD8w6UitxwPY9+9Yt50DNi1sYw3uKuQXi081Of4JEFw==
X-Received: by 2002:a05:600c:4fd1:b0:418:3ad0:742 with SMTP id
 o17-20020a05600c4fd100b004183ad00742mr2148526wmq.4.1713540151990; 
 Fri, 19 Apr 2024 08:22:31 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm4656127wrx.107.2024.04.19.08.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 08:22:31 -0700 (PDT)
Message-ID: <66fd02ae-d954-4d5f-8049-4335561c39b1@linaro.org>
Date: Fri, 19 Apr 2024 17:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: drop generic headers
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
 <20240418-b4-of-upstream-build-vendor-v4-2-d404deff386e@linaro.org>
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
In-Reply-To: <20240418-b4-of-upstream-build-vendor-v4-2-d404deff386e@linaro.org>
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

On 18/04/2024 20:39, Caleb Connolly wrote:
> Drop all the subsystem headers that are compatible with the headers in
> dts/upstream.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/dt-bindings/ata/ahci.h                 |  20 -
>   include/dt-bindings/gpio/gpio.h                |  42 --
>   include/dt-bindings/input/gpio-keys.h          |  13 -
>   include/dt-bindings/input/input.h              |  17 -
>   include/dt-bindings/input/linux-event-codes.h  | 806 -------------------------
>   include/dt-bindings/interrupt-controller/irq.h |  19 -
>   include/dt-bindings/leds/common.h              | 106 ----
>   include/dt-bindings/mux/mux.h                  |  17 -
>   include/dt-bindings/phy/phy.h                  |  26 -
>   include/dt-bindings/pwm/pwm.h                  |  14 -
>   include/dt-bindings/spmi/spmi.h                |  10 -
>   include/dt-bindings/thermal/thermal.h          |  15 -
>   include/dt-bindings/usb/pd.h                   |  88 ---
>   13 files changed, 1193 deletions(-)
> 


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

