Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A3BCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 13:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2A4835CB;
	Wed, 13 Aug 2025 15:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IC3duaxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA08A835D4; Wed, 13 Aug 2025 15:17:15 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9884C835C9
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 15:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b78d13bf10so6749736f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755091030; x=1755695830; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b3TKzu3Rh+M1k4WeFg/jGzC6eliAJogtjRZJ+yfpCag=;
 b=IC3duaxAenAxMgKbgIbRPzPlW2TZpOIYINukL0hvtLLZfDEnIdpEIAUHvEbE0QT8Rm
 q3YkH+Qfwp614vK8ZaFFhc9Q7+cUXEJp08YFWrPoXNtp2p8tnf4PnMuSNZqtKG6DjmtS
 YDSCO3CeJxMk2YZ+dnQsV1wns31LXGVTR47NRqBqqbQ5hobhFdnb/7saT1XBxXCRCGQU
 hft/jb3F8KPmLL0K22Ok0JyjVsbagtVeV5st6VI5ElPg9ANEc1Rpsso5/NU/5oaIgJmY
 ppdWxDQqsdW3toUbmaVs0hEghSl9MxBYmMtklfdRZ9ef8lDWNAJ3rb6lMTEq5Jadl0XE
 K6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755091030; x=1755695830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3TKzu3Rh+M1k4WeFg/jGzC6eliAJogtjRZJ+yfpCag=;
 b=jpqQcneF2j5lrceIbsVtHZlfUvvrA5zjpEi7CWqAOVcj5v3mIPb4HLMqu3Te/D9RT7
 QnCKH43VbwjSLmOLtSCfxKmtAn4wfx1HDhLQn83nuW1870xRhL6G0QOCsp1nUVJ1YH/X
 HKLjzhsQ3wXB4kGnNP7zbYVC+/HT0H6hgXie4lM5pYCT3/CPbz+uKJPkY/oF8dMU8KcX
 N5HUkQxzSxYZx3WJBR93ASvzTzWUqV+XZ2H88PLMYaDBJKveokM011xO7WtQXx3XYGdc
 WQ3GR18J+Il+3KYzTpDwdkrSA0q9f4LDl5ASVymHu/eqq7pK4PDfrO1x85A/OZZk8b0w
 8Urg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgmmFVfBaRXNl7k0P5ZcDfSU5Rt/lE8KUydN5mGPQMzcC75VGKHCBpv/0knjlpgUCXypHvyp4=@lists.denx.de
X-Gm-Message-State: AOJu0YzXInyoLCHW+jTuyEoTb4bjRhC5kTca7pG2RuCy3fMvso2nnIzI
 22GdimEy2uj8nnofx3KNuV6jr36vTLe0oPC5OZPrdi0ascyQ1VnZcoYVMrfI/4KwY5o=
X-Gm-Gg: ASbGncvSvPdQ/Eo+Q50B+KJy4XmMl7NjqNG78gwn8UW1saiglWhNuN6dgFgbtJrPf1X
 UCqrsQ0UsPnbLUq+C83IiAADkXKa1LvqNb0+goqjHFBxSlTmyHn0yYyfhqRJvZVZsQT7Ntxqk1h
 1pzeh+GK7D2O6o9tHHRqpy79mBBoMqWhmRoy6VSGvfXBWC0+oGiwzDCge7+93+ijh4J9/DXbMTU
 TjwnjlfEcxkSYyWnnJhF+BqtwldawJB3lUjESNbpvOv4jHCYr4QZnLXF9UeIgtCYwZJOobW2gqp
 fNWcao6h+ipJWjv0K8PkNyHUBZEiZTG911L8JTOwLbHe2KfHwMM5w4d0J/BNyUc2RLRjn4WxOuv
 DqwYgf8CaMJJsiC57BkmNYu9Rc3YxrI8qEsovAl3cHTJvzQ9+mYMcVWFlcp4cP1wB
X-Google-Smtp-Source: AGHT+IEJ0KWwTYndrwnaFO19YHBx67B0XF5EnM+u3AAgWSYuuKVTlzIogVXUuxkXw4MAi8RfDg9sXA==
X-Received: by 2002:a05:6000:230a:b0:3b7:888d:8d9a with SMTP id
 ffacd0b85a97d-3b917eae6abmr2509940f8f.29.1755091029828; 
 Wed, 13 Aug 2025 06:17:09 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530b3sm48556867f8f.34.2025.08.13.06.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 06:17:08 -0700 (PDT)
Message-ID: <1a2d436f-2a90-4f35-853d-8a21c00ade53@linaro.org>
Date: Wed, 13 Aug 2025 15:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: msm-geni: No need to NULL check priv
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
 <20250811-serial_msm_geni-v1-2-4499179491bc@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250811-serial_msm_geni-v1-2-4499179491bc@linaro.org>
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
> The NULL check for priv in qcom_geni_serial_poll_bit serves no useful
> prupose as too much other code surrounding it relies on priv being
> valid. Remove the NULL check for priv and other related code.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/serial/serial_msm_geni.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 33016f0cb53..0eb90f82a34 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -288,23 +288,19 @@ static bool qcom_geni_serial_poll_bit(const struct udevice *dev, int offset,
>  	unsigned int tx_fifo_depth;
>  	unsigned int tx_fifo_width;
>  	unsigned int fifo_bits;
> -	unsigned long timeout_us = 10000;
> -
> -	baud = 115200;
> -
> -	if (priv) {
> -		baud = priv->baud;
> -		if (!baud)
> -			baud = 115200;
> -		tx_fifo_depth = geni_se_get_tx_fifo_depth(priv->base);
> -		tx_fifo_width = geni_se_get_tx_fifo_width(priv->base);
> -		fifo_bits = tx_fifo_depth * tx_fifo_width;
> -		/*
> -		 * Total polling iterations based on FIFO worth of bytes to be
> -		 * sent at current baud. Add a little fluff to the wait.
> -		 */
> -		timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
> -	}
> +	unsigned long timeout_us;
> +
> +	baud = priv->baud;
> +	if (!baud)
> +		baud = 115200;
> +	tx_fifo_depth = geni_se_get_tx_fifo_depth(priv->base);
> +	tx_fifo_width = geni_se_get_tx_fifo_width(priv->base);
> +	fifo_bits = tx_fifo_depth * tx_fifo_width;
> +	/*
> +	 * Total polling iterations based on FIFO worth of bytes to be
> +	 * sent at current baud. Add a little fluff to the wait.
> +	 */
> +	timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
>  
>  	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
>  	while (timeout_us) {
> 

-- 
// Casey (she/her)

