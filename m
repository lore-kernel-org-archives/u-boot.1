Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76532C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 09:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BA68851E;
	Fri, 28 Jun 2024 11:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sqyQsdl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9842F88581; Fri, 28 Jun 2024 11:59:36 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF768851E
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52e743307a2so525180e87.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719568773; x=1720173573; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1CjBZpY6Cgykx7jxf4p8fvOOoWK4yuGaGanuncNylKI=;
 b=sqyQsdl82ZVkuwToBnNuDZUJww1CgHmxOL8nqPRfwONohwDQNI/DnkJh2BkIZp0KGl
 guIthaSaVcewOck63GgcDzmMIGQBXzAfWoiRjuvAizb8t2mDJyUiM66UJQis0vfKBFOK
 CzHjdvl7u6syFpiz/WxlGZfzpg9W559Ky4l4dfzXBLzzNo1gWzyGtEPfy9snx4J52pMg
 knnBCWFCwMCg9Gyh9xL7APC6Y3bN0QOJh+mif8FjemEetaykFgE8V4ZgETJlXA7PaQzH
 fLwhLMPsIpWIRTQTGDdG2f9eg+Sxc7b2jf2YOScSVW+Z486mHygpTHo3nBqNcSf5ZSiP
 Msrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719568773; x=1720173573;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1CjBZpY6Cgykx7jxf4p8fvOOoWK4yuGaGanuncNylKI=;
 b=sPH1ET71Lb36cIR7oeEWtC2uDKUuXpVd6puUgQwCydDkWTXNSvOwPqqBokE0xYXL5n
 4s/8qpHEINPVo37u20azrJTeQmGBKyNaP3cUNyVKuSCmMOdK0pLdL1JhMZ4pLgAVJKlD
 KTUU3GMitHPUxquOsO0IfzHURCkWgrDOQNbpjk8+ajeG2Ilcn3jjF2RItZ+0i1UBM0vx
 ookUCYSX7A34JlaZez6HwzpuWK5lEB00wHvNYe6PWlaDmSw9ohOFh/26GM3vfUTrPgE3
 eqryX9o4GJ3d0Mc7AdVEQR08fPLV+78qyscxRorip0/hJFeikJihEqCMZ/X+Tf5WnMuv
 0G8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtVuAsXKQNbKZuYIixWTjDrim+1ds0PRipnr8DH2tDo14q+WcqK3cjHRsUXHkr/k9+BUkmRecOU/BlxRHPo92jAq+DvQ==
X-Gm-Message-State: AOJu0Yzss3w7B2SAXQYZ3eK+oejKvZ/O3klC9xVGKJy6yZ5X5M57dYFz
 XoZJHAy+2QN39bEHvmEP+OAM79f7W024JrkVeX2+lEaDj/vWdtY2lFlaH4ky7As=
X-Google-Smtp-Source: AGHT+IFov27mPN7BQgjhyBlnjxjM97fE1f2HLfGDv2+T14yZRYLdFGheImF76mkau8budfag6g1qRw==
X-Received: by 2002:a19:5e4f:0:b0:52c:b09e:136d with SMTP id
 2adb3069b0e04-52ce183ae38mr12035253e87.32.1719568773169; 
 Fri, 28 Jun 2024 02:59:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b17d:324d:ca1:ab31?
 ([2a01:e0a:982:cbb0:b17d:324d:ca1:ab31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0fb3sm27276235e9.40.2024.06.28.02.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 02:59:32 -0700 (PDT)
Message-ID: <3272888c-1370-43e1-ae5b-b789e1faf2c6@linaro.org>
Date: Fri, 28 Jun 2024 11:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] clk: add a stub clock driver
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
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
In-Reply-To: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
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

On 27/05/2024 19:12, Caleb Connolly wrote:
> As U-Boot works to align itself with upstream devicetrees, there are
> some common issues we start to run into, that of hardware blocks which
> might be important for an OS like Linux, but which aren't useful in
> U-Boot.
> 
> For example, the Resource Power Manager found on Qualcomm platforms
> includes clock controllers and power domains which are only useful for
> managing power consumption and enabling low power states.
> 
> As this is not at all relevant for U-Boot, we can safely ignore these
> devices, but we don't have a good way to communicate that to U-Boot.
> 
> As an initial step, implement a "stub" clock driver which can be bound
> to these devices so that drivers will work as expected. Make the
> Qualcomm SM6115 RPMCC the first user of this, and enable the driver for
> Qualcomm platforms.
> 
> To: Tom Rini <trini@konsulko.com>
> To: Lukasz Majewski <lukma@denx.de>
> To: Sean Anderson <seanga2@gmail.com>
> To: Caleb Connolly <caleb.connolly@linaro.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: u-boot@lists.denx.de
> Cc: u-boot-qcom@groups.io
> 
> Changes in v2:
> - Take the other discussed approach of just implementing a stub driver.
> - Link to v1: https://lore.kernel.org/r/20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org
> 
> ---
> Caleb Connolly (2):
>        clk: add stub clock driver
>        qcom_defconfig: enable stub clock
> 
>   configs/qcom_defconfig |  1 +
>   drivers/clk/Kconfig    |  7 ++++++
>   drivers/clk/Makefile   |  1 +
>   drivers/clk/clk-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 72 insertions(+)
> ---
> change-id: 20240527-b4-clk-stub-9698797a65ef
> base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
> 
> // Caleb (they/them)
> 

LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
