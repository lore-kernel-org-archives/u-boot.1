Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC9AC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6143681FAA;
	Tue,  1 Apr 2025 10:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XcIAIUg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC4981FEE; Tue,  1 Apr 2025 10:41:00 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C525481F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so58827935e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496857; x=1744101657; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bEa77DMaWILcVIB32qt0js+1SDLidiTedHY0fnGJcvo=;
 b=XcIAIUg+B+p5bcT4198C0L/fIbwrryjDmjSFKgRauaJmkYqcDGRRgWYZJKACE0I68O
 V2D3iyOJ/X3Pn+lNNLi1boVMMyqgUd+L2wxF4LEhy+fjCy6Wd22B0zDjfGiLPrueZyEc
 dfpoEPd0z3/+Uk9BT68nLHbF3Ssi8ohr6sLADI/xx4A8etwkwDG4jkOnxOZhoj4ith+N
 mSLcFuz8F8br8Tr7q3CJZGe78dDZ/kTtrbgUfrvfi37Ebf7XtM91dSXODJ3KH0AcVR3Z
 VTCiHD8gWt/Dx26QrGmigOBa9tgd/3v6FNEAiIU3yzH1xmW5rvZCIK/gsqxK5uKTJZ7m
 9XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496857; x=1744101657;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bEa77DMaWILcVIB32qt0js+1SDLidiTedHY0fnGJcvo=;
 b=I38a7PFdavEMYroqlb0tLLU8O/H0kTOLr2h6kN8XfVe0596w4PlmnsyFYekVaRma+k
 qCCmKMofuxHWuk+O5x3rhjK3AWxMMTVU9iMm3Mao32VSroYsB12TqIGzEpp1/eFwifIv
 lCJvqg4YqV1HVNlEXaeDobGrT0mmQpGGsmdn94PXWBEX4XGQxF8KUdvUYAO3Tj/6Vb/K
 O4G+dmKDdStL62vU3i1J9hBRtSMCAuMvP00tWpnBeQ+RwCJDrDHCEpSM581Nd2suTC4z
 KnHM9ylwnlwqxecLyN+Pgb775pF0oCwpthPGFdWLd2nu3CffSZSipeXEw7bnJGv9Mvlo
 ARKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8guZw0Q2ldtsGv6Q1kiYQlkLDK8HyxWlRaEmGrIxyuskrQIGMdLZEVRmhpaXtmwu3IVRw7oQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwKk4T4gGiMheRvhPnkB3njqf1hKVaD5yi6sHQ0phCO8aWuylFc
 TFgGJva9i4HFxgNF0882TqO0d60cFvbN22t5Img5/t0Y+TblmIdih7iWlXfk6MePf+kLdCrMwhX
 S
X-Gm-Gg: ASbGncslWPTlfncOs5V9BXXBdOAaEFspu1ViW4A97lf/pnMwL61/r3k6JSdtSSG6lbj
 BLTZK4zmTTJ3TgUYeZUB0DanWQvDpyQLhlDrb6wNCeHqM5/AJAjTNFbH+uPlqXoZym6F8xg5WZj
 TebUc4CpzheKI4ZDfqMzYpFam9aB46w8/mHMEeU9Tm2Y0gdgs6b2nVVJjZxNQJZ+0Vl7dv02hcz
 hX7LmFIUYfV9pSPTx8xeHXz8cGhdiMM/cF5KYuvRE5UhbPswOIq8QO0D3rjUjl6qPiFhEqm+QMN
 8byDU9vvJK2OE9JusuEFCxjpNCfs7P9Lw2cYV/XKiYC+Jzi9y4f0y6ws34+aplnK9coYXi+2X3Y
 kEsFwDKNRx9RqpdAC8EvIrA==
X-Google-Smtp-Source: AGHT+IGsw0pIxhvHAHyl+NqETBPNgsAv/MGg7DZI3DGC28yKp3RrgVF2gHsiHcoMNV5ocBWIFCuUyA==
X-Received: by 2002:a05:600c:1e88:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-43db62bf807mr93121335e9.28.1743496857085; 
 Tue, 01 Apr 2025 01:40:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0?
 ([2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41b4sm13318793f8f.85.2025.04.01.01.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:40:56 -0700 (PDT)
Message-ID: <69deeb78-0430-4ca9-bb12-2f621559cb97@linaro.org>
Date: Tue, 1 Apr 2025 10:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/6] button: qcom-pmic: prettify and standardise button
 labels
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
 <20250331-qcom-phones-v4-5-f52e57d3b8c6@linaro.org>
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
In-Reply-To: <20250331-qcom-phones-v4-5-f52e57d3b8c6@linaro.org>
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

On 31/03/2025 14:23, Caleb Connolly wrote:
> Boards using gpio-keys for volume buttons label them "Volume Down",
> let's match that here, and make the power button nicer too.
> 
> This simplifies configuring button_cmds in a board-agnostic way.
> 
> Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
> Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.c | 2 +-
>   board/qualcomm/dragonboard820c/dragonboard820c.c | 2 +-
>   drivers/button/button-qcom-pmic.c                | 8 ++++----
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index fcbf2c3fe60f21bae1c6d64b542a4d9867c33826..d0d82489f53c4f31b7b08bcf6e4269730027874a 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -71,9 +71,9 @@ int misc_init_r(void)
>   	struct udevice *btn;
>   	int ret;
>   	enum button_state_t state;
>   
> -	ret = button_get_by_label("vol_down", &btn);
> +	ret = button_get_by_label("Volume Down", &btn);
>   	if (ret < 0) {
>   		printf("Couldn't find power button!\n");
>   		return ret;
>   	}
> diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
> index d3333a59db01caa940224a99df6b43a3375cacf8..12a9273ec4b9d240bc2eaed2834d5265290153ec 100644
> --- a/board/qualcomm/dragonboard820c/dragonboard820c.c
> +++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
> @@ -105,9 +105,9 @@ int misc_init_r(void)
>   	struct udevice *btn;
>   	int ret;
>   	enum button_state_t state;
>   
> -	ret = button_get_by_label("pwrkey", &btn);
> +	ret = button_get_by_label("Power Button", &btn);
>   	if (ret < 0) {
>   		printf("Couldn't find power button!\n");
>   		return ret;
>   	}
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index f9f0948ae095f433e35ecfc0f98741ab1a850742..e3bb9bd758aca819b3a10aac84787e703c55d36a 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -72,27 +72,27 @@ static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
>   	{
>   		.compatible = "qcom,pm8941-pwrkey",
>   		.status_bit = PON_KPDPWR_N_SET,
>   		.code = KEY_ENTER,
> -		.label = "pwrkey",
> +		.label = "Power Button",
>   	},
>   	{
>   		.compatible = "qcom,pm8941-resin",
>   		.status_bit = PON_RESIN_N_SET,
>   		.code = KEY_DOWN,
> -		.label = "vol_down",
> +		.label = "Volume Down",
>   	},
>   	{
>   		.compatible = "qcom,pmk8350-pwrkey",
>   		.status_bit = PON_GEN3_KPDPWR_N_SET,
>   		.code = KEY_ENTER,
> -		.label = "pwrkey",
> +		.label = "Power Button",
>   	},
>   	{
>   		.compatible = "qcom,pmk8350-resin",
>   		.status_bit = PON_GEN3_RESIN_N_SET,
>   		.code = KEY_DOWN,
> -		.label = "vol_down",
> +		.label = "Volume Down",
>   	},
>   };
>   
>   static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
