Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C18C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 06:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5E381E25;
	Thu,  5 Jun 2025 08:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hKxJevMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E2D81F0D; Thu,  5 Jun 2025 08:35:53 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136CB8091A
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 08:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so4439895e9.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749105345; x=1749710145; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g5Cg8uPQTcHHRKVRk+KYeySPrcR7b0f8BjvJFU/j3e0=;
 b=hKxJevMJV34SHxFdZtzXoWDgoIDm2ple7yrNlmLL44PbQqc+NOipoCjV+/ihwOa2I6
 aZ2/vor8Z78yjtxpzW6nHWuWQkLANeBws/lSHxdvNTTYOM5qXRlDpHpYB40MVrDOfukI
 HeRhZx9prjIGyJwkYDf8FTJZAyt5LMXFpFYpwj0FJutdswUSno54idH7to97GgktXOzn
 f8060slC8GXoecH6pHWWkuL3SjgzjcTYNGjIHcPFTtmHKCRBu2CnOqArDxXDD3SDyhOk
 ZjmYcj1zG+XOf7XkvNZPbtaasSKKdeLPf1x5hJzfD14Lnxxbw4rter00zUKqaibXJ5Hc
 OeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749105345; x=1749710145;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g5Cg8uPQTcHHRKVRk+KYeySPrcR7b0f8BjvJFU/j3e0=;
 b=eI+3HpP1xpMZ8ynLVev2rD8r9ETnunC9Pluz22jVbL9GoyYSZItf4vbDdGwCTHku/c
 ajk8Vxnl59V79j76GZki1mVXYpOE5shA/wNmEg2B1d08tVZ1ihZAVBnc2fJmIT5xHsnq
 XJuDM1c0zYYIc0qIVt0HvQ5FKvkXWNoM7V5BY4PBrEbKk+ACiokL4DcyXY7oDQzvFCM8
 6MKSFvUTzreJCq1VJdCewjM7/AUeXLdnbNKQpjJQyE8RDRPRLtMTaj072lqU/99CwdZz
 mV08bYT33YehAhQ1xs6mNR9IWZ8QLPp6TgVgnPYhNWhKRt3qVRv8P7SpJWHd3s7YuoHZ
 oItA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf4kMcXOsEX7DL6nrpcZt1XdEwAdxyjtbIpdpuKjXDGP3vlIXgSim8xY7ljAYzxemuQTZdPzM=@lists.denx.de
X-Gm-Message-State: AOJu0YynXaELk84oKJ5Us9JKceA5Gs0JKuPSTH9kUQd1Rnnu3Mk5jAPG
 JTl9da1mQp+zadY/12ZFfh29GaQjzlFRJH+gW0l19Z18DCLLvhoEjBI5dHyIvTXBfxE=
X-Gm-Gg: ASbGncuO/mn49yRbM8bKRTmZWhgFdmI7Qm55UyHXlHounlEDhcmqEc0yfr4EZvRtE3U
 0YTDSl3fy2+1Ps9rLIkQQd2gun9CDBPMy3w6EglBHL/41ppFt5rELeJSz44aiIDNtamKeDBEKSK
 hy2KVBu7EEON3anasloDlP+0lnC4NfnspEEGZIySf72EfaQSkif8uJScb97v9cf3RZdCpY2UoUS
 +u8sZGmtAgrUHJ7nyEdLvypfTFyTsOnHfYmQAKSwUZf0o3mr+tKvK3oLC76zRKPVtSmc/QrbJSe
 +qohf56aJOv77NxBw23P6NCN4Z8YgIknIYUN+zWPk67IyoFOIk22zhmHV0uX+ilR/r+UkjuOaM2
 MkWnaWUufTbCyc9jyQS9w93X6FWYL8D0=
X-Google-Smtp-Source: AGHT+IEEiDWoeP7376KXE7nby/jBdTBW6zTI6Er75hg0Rdiyld1YOw/xbdW5c6OeXOC4wg62lEFEZw==
X-Received: by 2002:a05:600c:1e10:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-451f0b1a239mr54186905e9.18.1749105345475; 
 Wed, 04 Jun 2025 23:35:45 -0700 (PDT)
Received: from [192.168.1.54] (bba-217-165-38-73.alshamil.net.ae.
 [217.165.38.73]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb22a31csm7380455e9.36.2025.06.04.23.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 23:35:44 -0700 (PDT)
Message-ID: <8d7091fb-b07b-4b4c-ba73-fefe574b8fd9@linaro.org>
Date: Thu, 5 Jun 2025 09:35:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, sjg@chromium.org,
 Oliver.Gaskell@analog.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, mkorpershoek@kernel.org,
 robert.marko@sartura.hr, jerome.forissier@linaro.org,
 sebastian.reichel@collabora.com, duje.mihanovic@skole.hr,
 sumit.garg@kernel.org, patrice.chotard@foss.st.com,
 nicolas.ferre@microchip.com, u-boot@lists.denx.de
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-5-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250603050556.80851-5-manikandan.m@microchip.com>
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



On 6/3/25 08:05, Manikandan Muralidharan wrote:
> The clk_register function logs an error if parent_name is missing from the
> Device Tree.On the SAM9X7, the main_rc node is omitted to stay aligned with
> the Linux Device Tree.Remove the parent_name check in at91_clk_main_rc()
> to allow it to pass NULL when the parent is not specified.

Hello Manikandan,

Can you explain a bit? parent_name is a field inside a struct, not in
DT, so where is this parent_name taken from ?
If the main_rc is now gone, which clock fails without this patch ?

Eugen
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/clk/at91/clk-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index 09daae97676..a5186f885f0 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -110,7 +110,7 @@ struct clk *at91_clk_main_rc(void __iomem *reg, const char *name,
>  	struct clk *clk;
>  	int ret;
>  
> -	if (!reg || !name || !parent_name)
> +	if (!reg || !name)
>  		return ERR_PTR(-EINVAL);
>  
>  	main_rc = kzalloc(sizeof(*main_rc), GFP_KERNEL);

