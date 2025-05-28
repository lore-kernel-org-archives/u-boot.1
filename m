Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF65C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 11:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F9F83A7F;
	Wed, 28 May 2025 13:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OJB3MlE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21F483A8A; Wed, 28 May 2025 13:23:06 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7631F839A7
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 13:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so28874375e9.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748431384; x=1749036184; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77+OSxSbNpuELypXeqBauA35p/0XCphsRhwC164ZRh8=;
 b=OJB3MlE/H+KOI8sVTdk4JdlQKWs+JYPriH1jtZR0ms8URzJlkBdodgTd+hAB9pWL9u
 hUaDlqJPNaiyvPB2ttvmZclKw0xWu8OY3zW9SjYKukKpFQsESAWWpsZ+Wtjmk6DiJQPq
 mRrd8B5Qfmyc+05DhIy+t5fi2w8Wn+nwHxtCMKqX22+PoRC/L/EwOeKcnT0QE6NoY6HW
 B+vs/zQIuFH5aH6zerdw8W50w1aUGtdWwjAWeNGTV5iVk7FJuweQB2VjyenmBOswCnKI
 9HhDtG2Et+H7zYOWH5Xr5RLCtclRzJEobRXPVQu+8AgUL/Iufpiiyb5sePB1m4UAoQWy
 39Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748431384; x=1749036184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77+OSxSbNpuELypXeqBauA35p/0XCphsRhwC164ZRh8=;
 b=dfHbSXr1+LVCO5F63wliWOU03A4D+kN6IYzZ4yFN3OohKqMnuCj8MMCGZ4bZbIeWy6
 wVrvL0BfWZZ+BxGAaT6RwawKK+qy0AaRbg9TiGkuFiVszQ0l57nzhiwhB8hyyyhFX+zH
 ALBxoj922yXk2cKzlF9qEA4BFjbdPKaonBCP7ObWPx2bnHI3bJ/K3z2W/5FyDp8Kk/iv
 wCAG71yQJxvkIgiAed88wmzb46wYUv4i4aTIPI89Q7qrh2gI73VxzKY9Czn1hUYFo13p
 3KGn4woVYiCSX2RqLzNvhNv7TGlQP9uO6Bkev2pjCKvtDgLVAagiWsPz1nAKX4iwNOcn
 X6Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk3iKLpq8kmbaHCXSGeWg8MWnjVYMeAb+ODbc+pFyUbcYgMTjdLpSM1ZfyBw5dTicC381pAAo=@lists.denx.de
X-Gm-Message-State: AOJu0YwJYtVAxJDKZV8xdnJrzyyOt7NQb6iSY8CYvE8OXVVLWBzFtnIu
 AJWBw3PEuI2GJSna+xpdsepLr29Rgw9pGEldUjkjAu1DgM9xMYcOqhsbfqgvD6xXLwo=
X-Gm-Gg: ASbGncunkHfblLLHEmOdvcQXDJ0lpvshQB4HjMvyv2YeaAY8no+pOaihAgb2uL6R00H
 UYIkBvbiSW0Eb8dPB5fmGIctMufYOdLEmuOOo553zNOyiJIMnyIYIdyVA7XpkXpopxm7gZWpJSI
 XJb6dXvBETPmruCONRDXOG/KqT4eUBHMU1Q9PypL67aqrei2ItdQiwwC4h2WwHuOvcuf7lXl0E3
 zO/eP4pwrURjg/OjFqYf5xK+8LJCmOH9Cyg5SXy1jA+o9UPJXQVhPBc0ljGxmYQvt7/y8fapXj7
 nZKSHGo0/f0cSVQPmGCDNDgX5bb9MzmQVn4h2yiiD1midAcpo8I4uIrxws1+Kd97VhtriUoyLPM
 H1MrNQ96IncwwYAm40J/Lqc3E1Q==
X-Google-Smtp-Source: AGHT+IEL+Y5rTjKoIQaRa/KcXPFTt13ybKU2Xti4n2KIVJiNrjUHAf51rW+EWABkJeDyJOe+Vxckig==
X-Received: by 2002:a05:600c:1d15:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-450725458d3mr14824065e9.7.1748431383742; 
 Wed, 28 May 2025 04:23:03 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:7b9d:1015:16d5:5c7e?
 ([2a01:170:117e:fc:7b9d:1015:16d5:5c7e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6e5d0sm1216036f8f.4.2025.05.28.04.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 04:23:02 -0700 (PDT)
Message-ID: <5b13c86b-1efb-44e1-9ee8-03c2863337d0@linaro.org>
Date: Wed, 28 May 2025 13:23:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] serial: msm-geni: Enable SE clk in probe
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-8-swboyd@chromium.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250523225845.2311989-8-swboyd@chromium.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Stephen,

On 5/24/25 00:58, Stephen Boyd wrote:
> Enable the serial engine clk in probe so that this driver can work on
> platforms that don't already initialize the clk for this device before
> this driver runs. This fixes a problem I see on Coreboot platforms like
> Trogdor where the UART hardware isn't enabled by coreboot unless the
> serial console build is used.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/serial/serial_msm_geni.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index cb6c09fdd09e..620cb9a59343 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -131,6 +131,7 @@ struct msm_serial_data {
>   	phys_addr_t base;
>   	u32 baud;
>   	u32 oversampling;
> +	struct clk *se;
>   };
>   
>   unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
> @@ -181,19 +182,6 @@ static int get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
>   	return ser_clk;
>   }
>   
> -static int geni_serial_set_clock_rate(struct udevice *dev, u64 rate)
> -{
> -	struct clk *clk;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> -
> -	ret = clk_set_rate(clk, rate);
> -	return ret;
> -}
> -
>   /**
>    * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engine
>    * @base:	Pointer to the concerned serial engine.
> @@ -252,7 +240,7 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
>   	priv->baud = baud;
>   
>   	clk_rate = get_clk_div_rate(baud, priv->oversampling, &clk_div);
> -	ret = geni_serial_set_clock_rate(dev, clk_rate);
> +	ret = clk_set_rate(priv->se, clk_rate);
>   	if (ret < 0) {
>   		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
>   		return ret;
> @@ -561,6 +549,16 @@ static int msm_serial_probe(struct udevice *dev)
>   {
>   	struct msm_serial_data *priv = dev_get_priv(dev);
>   	int ret;
> +	struct clk *clk;
> +
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +	priv->se = clk;
> +
> +	ret = clk_enable(clk);
> +	if (ret)
> +		return ret;

There's a subtle change in behaviour here, since we'll now fail probe if 
the clock isn't found. I think it would be best to treat this clock 
being missing as non-fatal since it can make bringup a little easier (no 
need to stub the clock).

Kind regards,>
>   	ret = geni_set_oversampling(dev);
>   	if (ret < 0)
-- 
Casey (she/they)

