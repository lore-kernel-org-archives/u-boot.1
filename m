Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80C2C021A4
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 08:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A66980BAA;
	Wed, 12 Feb 2025 09:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iGiJDYx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3731807C0; Wed, 12 Feb 2025 09:21:57 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E7580BAD
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4395a917f33so1624865e9.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 00:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739348515; x=1739953315; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tE9eAl2qd2o/n1s/Ttt7njF4QuK8BPkmhatFuM4MCsI=;
 b=iGiJDYx62Bu9S70nyg6TKEOWA7x07XBA9sudLrgCBBKJrdhZE5mRbC9UTOWSF050EH
 mCy4Yyzv6jkwBYE88JGwrGmxpPvJOhTggQd5ta3O7mk2z5PMIBOVyxvGcaBSxHOBq+hR
 j5OZBYMCkF0sApjNMyF2fGzgXS9WCZZzv+nQ7MgM4+T9h/kNj5VVCZOhEicjlRYRyGWO
 AW0Xs705IAL6tut/iNhF3ShHKx4vjNKnQRyxsp26D1jnkWu6hbEHleueuNfwdKWTQWzn
 t+CAZi1T3UM7vpKbcpxbpURyLV3MBCdRR/4RzD+zxmXtDs9qfzlVOD/MyVoRSTJHpure
 7tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739348515; x=1739953315;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tE9eAl2qd2o/n1s/Ttt7njF4QuK8BPkmhatFuM4MCsI=;
 b=uWwlrtcykOSqpRsGPp57nN5nZ6b1MpdRQARwBtjmz0l4m8ZRHZVKuv186ls2j3cDht
 pw1IQ+z0cjWwsX6tYwxDzZjza+oEaZYK8BHuYtnMnYnCcGOl7RPeVTjN8IMtUxuq/0QU
 LqkvxpPozUP2I4XIsucqjjdrvfZOiwZXkxGZqOowcxPlQKKcFc1eLyzI3jCVe9h3brlO
 Jg5q4m+1q3m55kvAFw8AP/+eYbpH6EV40t/ANXmIJr1wyD9Tnkmrj5br9cwTop6QqMgz
 13/8gf68bd8TU9OQ67ZeBHVGuv6gL5GIe4SB4JUXKR7MlZzLAF8RnhxVgnRE0Rewq/6m
 30Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9BDlNZSVPly3SIKFiQHC1UEzPDyyiffSmy2xZmwi8fDkRwbn1PGA6B5YOO3GDw7/HOPj1WZ0=@lists.denx.de
X-Gm-Message-State: AOJu0YxnXy7/SShitVAQV4vvvU91QYF+tCpCkEtTojhaw37FIslCGQfm
 iXtcIxD+zGQwDk5wHHqGlk0QklwFgxhWMSorjR8eDJtvcejDXLvghky2Y9y69y0=
X-Gm-Gg: ASbGncsdRQzjdHFDS9uNpPsXomqc+zjLIt6m/Kqua46zhvKGcVgxjteX6mVOLStlIQE
 3nY6RIGJ2CIQ015Kz261w3Il06BBhIX5+cVZ3Pm/w/H489XprkOetIdg+6JZLRHOcs7N1AFhb+F
 EmShUGjybfQmmCU03zcOQdFTqni5lR1h4vWg2l+5GllN1Uzv7KlxkLpMmD9Hbrhk+Z92RjIfuJe
 Y6kyzgJIfmd4uHGXKuDDemx9K9S7nUEv2tqyd3ZYPNjqdzq0wCS/grM/aDeiO/2urhEfyRKmdAE
 2qxv30lC+sMjT+nvI3Pxwyyrp4wLQkK3VZpAoTvoj9JOjKtNdPhQWgrMzZK9FuoDOej/
X-Google-Smtp-Source: AGHT+IE3aLmSO9aHr746M/b4BI+kOAPY8KeSKGWnH7/vUaFUY4yM0iwBsDCTM0YzBb38FEhHUHwcsg==
X-Received: by 2002:a05:600c:3b82:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-4395839dc66mr16557805e9.3.1739348515227; 
 Wed, 12 Feb 2025 00:21:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aaf2:5110:cd96:8172?
 ([2a01:e0a:982:cbb0:aaf2:5110:cd96:8172])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcdb54668sm13585261f8f.35.2025.02.12.00.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:21:54 -0800 (PST)
Message-ID: <343d08ee-b1fa-444a-95a8-ddf7bbc9b240@linaro.org>
Date: Wed, 12 Feb 2025 09:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] power: regulator: add additional supported LDOs for
 pm8150l
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
 <20250210-b4-rb5-sdcard-v1-1-3c34a8bee77b@linaro.org>
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
In-Reply-To: <20250210-b4-rb5-sdcard-v1-1-3c34a8bee77b@linaro.org>
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

On 10/02/2025 17:30, Caleb Connolly wrote:
> Add the other LDOs that our rpmh driver can currently support. Some of
> these are used on the RB5 to power the sdcard.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 70df51b5fa4ee4001b7eff6facc80957ada84391..cd2b1a654c15e09c154c524378768ed1beb83895 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -480,8 +480,15 @@ static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
>   };
>   
>   static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
>   	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l1-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
>   	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
>   	{}
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
