Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BDBCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8A288013;
	Thu, 11 Apr 2024 05:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azwnWemx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADC98816C; Thu, 11 Apr 2024 05:13:04 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959A987F6E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78d68c08df7so235453785a.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712805181; x=1713409981; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok0CuD0fpKwnfIKaGcWEbG9OKqMVntYHpPjLjC9qqWM=;
 b=azwnWemx3FKZirkLRleolt7GlQrxAheiJcYoC/3s4stK77DXjwqt3K29K4P87I54Zy
 wfVCB18NlfhZd3LsFNEUad1mgSu/nK4+rZfxeBKOcVtYaPyrVvUctkThkfzWwCYks7IS
 r6o7MUFjGetkExba7ERrQBCmaDhtJHOV5KTQPMlRHZxFMgDctZ2RyJG6MWx0HEiH92Nl
 gmE3gdPcDF5aCTJkoiESzpa6imAUzJ9Mfx+cvrkR9T2cPFmPP7ROWQgt+uzji6oYEslr
 Mou6Zn9BWYgjZ+YIeWmC1itxsffpMMoFLXJEWPRDgNYYPP2lzpCTrC5Sa3l8kR2uYkaM
 K+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712805181; x=1713409981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ok0CuD0fpKwnfIKaGcWEbG9OKqMVntYHpPjLjC9qqWM=;
 b=ldEcu/gZEBaeuCJKHVQrsbwzpDvZ7N1V5ReE0rzao0Zvh7W5EeRuSKGY2tEh7zRwrp
 hmoTmcmqCf9fA7MhXu9icUv4Iua5w9XdhAXJmwriIhvz4Mo1onT28iBtehbhdIXgqAvg
 91gloviguRIPkZ133Ngd5CgVfXvPvZa19uJnvMH8lz8cmK2pBEoBv7zj5gByt06SfHcL
 j46/+iccmB1+j+CP0voNtHVXofIQpbGpyWYOlNScwbVXOZKxujVuRFolxUHCJ9NxhuP8
 JiWjp5SmpkwqX3tz1Zps1Tgk5vSUum2jsSRmjgcxh4wZMw/WI4fGNEn0R81yFVd6i1us
 E1OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrKI+ClhEKReiYIIDigItQw/acHNOqI+kzM8py5olJHZ7xBFGfBK4vaycr1FeVFQW63NJ0Pf+27gAlZbKRge4/eEYSmA==
X-Gm-Message-State: AOJu0Yyh5+dfno9P5LuXo9+9GZbuq4hUjqVh9hnUhahKKuoHkubVA3vI
 J6MQ2BOs7lYUZ2TGB0Oszisl+SwB9rEze2C0wBFQnKS3IH5U0ewFRP+7EA==
X-Google-Smtp-Source: AGHT+IGTA+iFA6UxumOhFVpoL5xcYOn1fR3SAyQRhWuQoBg6d8yd7TbIiJ4wMmF/ORPb0VQX5MFkMg==
X-Received: by 2002:ae9:e514:0:b0:78d:3acf:c96c with SMTP id
 w20-20020ae9e514000000b0078d3acfc96cmr4309855qkf.58.1712805181443; 
 Wed, 10 Apr 2024 20:13:01 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d15-20020a05620a158f00b0078d54363075sm430310qkk.40.2024.04.10.20.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 20:13:01 -0700 (PDT)
Message-ID: <d98c06e7-ba9f-f09b-2f59-f678de6d4b93@gmail.com>
Date: Wed, 10 Apr 2024 23:13:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] clk: sifive: append missing \n to messages
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: Anup Patel <Anup.Patel@wdc.com>, u-boot@lists.denx.de
References: <20240216163535.275085-1-heinrich.schuchardt@canonical.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240216163535.275085-1-heinrich.schuchardt@canonical.com>
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

On 2/16/24 11:35, Heinrich Schuchardt wrote:
> If multiple messages are written, line-feeds improve the readability.
> 
> Fixes: c40b6df87fc0 ("clk: Add SiFive FU540 PRCI clock driver")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/clk/analogbits/wrpll-cln28hpc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
> index a3cb109d357..537c696b727 100644
> --- a/drivers/clk/analogbits/wrpll-cln28hpc.c
> +++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
> @@ -81,7 +81,7 @@ static int __wrpll_calc_filter_range(unsigned long post_divr_freq)
>   {
>   	if (post_divr_freq < MIN_POST_DIVR_FREQ ||
>   	    post_divr_freq > MAX_POST_DIVR_FREQ) {
> -		WARN(1, "%s: post-divider reference freq out of range: %lu",
> +		WARN(1, "%s: post-divider reference freq out of range: %lu\n",
>   		     __func__, post_divr_freq);
>   		return -ERANGE;
>   	}
> @@ -229,7 +229,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
>   	int range;
>   
>   	if (c->flags == 0) {
> -		WARN(1, "%s called with uninitialized PLL config", __func__);
> +		WARN(1, "%s called with uninitialized PLL config\n", __func__);
>   		return -EINVAL;
>   	}
>   
> @@ -335,7 +335,7 @@ unsigned long wrpll_calc_output_rate(const struct wrpll_cfg *c,
>   	u64 n;
>   
>   	if (c->flags & WRPLL_FLAGS_EXT_FEEDBACK_MASK) {
> -		WARN(1, "external feedback mode not yet supported");
> +		WARN(1, "external feedback mode not yet supported\n");
>   		return ULONG_MAX;
>   	}
>   

Reviewed-by: Sean Anderson <seanga2@gmail.com>

But maybe these should be dev_dbg?
