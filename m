Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1554BC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9961C80FA8;
	Wed, 13 Aug 2025 15:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qebhe8wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B71482977; Wed, 13 Aug 2025 15:16:54 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD19080C93
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 15:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso42788605e9.3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755091011; x=1755695811; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvJtmfc+RfG9WN2/Xc0H/5nam3FOMNRHi4Qw8ciARFY=;
 b=Qebhe8wzNKWPoRqIAltO1cAf/cZTcP4uiHp2cyOAPZC+Y7le50yKldth9BZ73I9qb4
 GEms9dLSlJw2tvw+yUfZdonynNGercCFDgDlysJxLU7AirEhGTpc52EOS6R89lSX1QdX
 7qW47iNWAeJgPNaLiU4FlFgb9b+8R1dG4x/HSr5cniWlxIDHYyTts/cXf3y7jSs9PLqR
 LbHMECsc/8rwTWWipcnRTgiXYgVRupDsytERzbk8wfSfUyprOVYXCsVKPzIgIl1m/JIv
 N1ECsOipLgb8Te4zVTRp7AVMKkD+oqv7QWR73jPv9IpJxilwxXwtrXEB3WFpH/AaK/dT
 SlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755091011; x=1755695811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvJtmfc+RfG9WN2/Xc0H/5nam3FOMNRHi4Qw8ciARFY=;
 b=maL8/hkZ+yklfzXWRBG1oGwzshpM/resqAV+Z4NHBpvabcturl8j/SUVj9tgQIvaVz
 b1eITe0vl1Y/Kem1WaFy2Y7tnfFqBwi3j0/54LJbNrddxp5Gpal+CG7WfzYi/XW4nonw
 BxbyemwwskQ5YOKgHHxsBR011U5l4dDSymCX9ZH6lK/nytVSLnyu/XeypqYUph4KfKTq
 uivHyDB3AtJAtH+0gt1BgPb9tnsinhZUVEvPsoJj00FIOYLq35FMWvNhyRD/xCQivxGI
 GtpiQsUkJYhynCCgFj7Dziz1HPh2l/t3bv/E7L+YatuO7qx2sWNIE+WNL5FI36pAwjq+
 evxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLYyIwjylkG1nzJ1fS/KTYbwxVBkEqI1JyizequcoWioFPFe303owqqjCe0re9LTmd+V7tb1U=@lists.denx.de
X-Gm-Message-State: AOJu0YxCDAzq2S0mygYNB8Odty0SF863IYxkGP3uG1FcosAbXGII3Iky
 l/KR/73F5pN/Yxv0ukwqV8tUB9vXlrqsU1UwZxE4+VFewDpt5vpONl0gTXnkHHfj97Q=
X-Gm-Gg: ASbGncs4Y8VTDyJe+mx/TOO3NZNHQPrlrC6nGV3Zx3RlUZ9jn6aA6c+1S67/hlsVPtT
 Ooye9e7lDj5R9V77hHseVxGDFYfz8T7vxk42y1OjLp7kPeVP+h6jxAkddAx5Tsv+2559w5Q2qmU
 hX2O8Gg1NQ4leUZJpYopcE1/3e/OcY6kr9TJqGjClLs8lZ1M0t+VWJlTNzhKioZcz1MwVmojtQy
 3wtBwF0ywmpH5lwinrNgGF6p4E7TtOf9zHcNv3fIc8eEatYi3tinZNrLNeypKy5RkituNeZKn8q
 l4GigI9OA9TxOqStQ/7Ad00IG6JN0BegBrvRwrg5KlmdPl9EGq9jcKiqIFfbIKCPdkKcc4/YFz2
 EL7q5Y07oBMGqYhZ5kKPtx7XV7UdBiJXiMAen1+2tuNZFvemE7mPcJNxsdoKapm+Y
X-Google-Smtp-Source: AGHT+IGmtAOM2WbHaOkXbbVvO5t4AxPwKFJ7b46673LkiH5Ww/Ygn4oMLa6wFVWV50LrKGt7hZgWrw==
X-Received: by 2002:a05:600c:528e:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-45a16a7c3d4mr24930065e9.7.1755091011245; 
 Wed, 13 Aug 2025 06:16:51 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2187sm49387284f8f.70.2025.08.13.06.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 06:16:50 -0700 (PDT)
Message-ID: <36441cf7-c7e6-4083-8b4d-c45bebc98239@linaro.org>
Date: Wed, 13 Aug 2025 15:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: msm-geni: Detect error from get_clk_div_rate
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
 <20250811-serial_msm_geni-v1-1-4499179491bc@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250811-serial_msm_geni-v1-1-4499179491bc@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 11/08/2025 19:03, Andrew Goodbody wrote:
> In msm_serial_setbrg if the call to get_clk_div_rate fails then there
> will not have been an assignment to clk_div which will lead to the call
> to geni_serial_baud using an uninitialised value.
> Check for an error from get_clk_div_rate and return an error code if so.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks Andrew!> ---
>  drivers/serial/serial_msm_geni.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index cb6c09fdd09..33016f0cb53 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -252,6 +252,10 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
>  	priv->baud = baud;
>  
>  	clk_rate = get_clk_div_rate(baud, priv->oversampling, &clk_div);
> +	if (!clk_rate) {
> +		pr_err("%s: Couldn't get clock division rate\n", __func__);
> +		return -EINVAL;
> +	}
>  	ret = geni_serial_set_clock_rate(dev, clk_rate);
>  	if (ret < 0) {
>  		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
> 

-- 
// Casey (she/her)

