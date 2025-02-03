Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AFFC02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 08:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06741801DE;
	Mon,  3 Feb 2025 09:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KK4vl1+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C5B80214; Mon,  3 Feb 2025 09:22:50 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABA4801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 09:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283d48so29691435e9.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 00:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738570968; x=1739175768; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdCAuQq7YaLX9F6CYcThfcusdnle/w2oO81R+575J2U=;
 b=KK4vl1+1blDjjvZ2OuSfA7Vr4LKxhBJwIvVB7DrO8FwGj+uMwoEg06KDLalioeBuxR
 61ZB357HRC3dTmerzjhGR3X/zH6c0f2/69OwRz+2boYN7D04iRmkknWANbzfR1A/075h
 k39aq1YogIug92NSMgW6wtWF7Cooj7pIwLt50aPgX3/AwxBOeWFaoStQHb8rbpcJbl+X
 V5U8Vayk9GnaVXBFHIB0TKIa/HlIr1IJ9GSKRs13qQHUqgIfrH7qETL/1NEo0ClbunnG
 jC5MYEpuEdFRdK7jHY26oirNen5F2WYmGW3elAZx6iZcgcwjYCbaZ3BaORZojL6UE25M
 NAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738570968; x=1739175768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SdCAuQq7YaLX9F6CYcThfcusdnle/w2oO81R+575J2U=;
 b=Gr0ZbH67IbvJiv8PsFC+qkWjj0GoxZFwThBhKLl68pTfNSSa9XhUqyTGi81E/05s5X
 DzM1uQJ/Y6hVF4BImAW25KAJcYekiCeEz6b4CgxFx0oQRdVwb5wwemFalkRP17c9Vpk9
 FTi90ovlNS7Lr9xpEf3pWIOgXJWA/AOx5uIAlAhqbmmTf1Bqp32VgVA0HANVpPRcx4wy
 RziNes16qjciGut2XSipGSS/imCvKkijFwRrNzL4owR96tg3RUodHdCXCdTWFsLP6c3z
 Km1DD5AQnIDcVI+cv2Vax4T8JDLradW9g7pOz8ecrmg9Y/FCHzJPM+dTvpOe36Gz7fge
 6fkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2KIuMZjUwwaj2S0QzFI6JRyaXoa8uVJUq5yaa6T1SOaI4NYXtI9VZj/XMFZVTyHYWGLEC8Qk=@lists.denx.de
X-Gm-Message-State: AOJu0YxxOTV23EXS5/PCB7/HccH9DR13MKQVBR8X1Q6IQz5E4WYtKkO1
 8XUTCIicueBP/S4sa5Rnt7oIosr1bTkvi9cugmHXzHliNZdld1YDkDkTOctZ70I=
X-Gm-Gg: ASbGncttGFbOdAhvQBdIkv+liR1zoiNO/thSDiBMRY977LXPqnKVC6yCS4SzCtZrUIo
 rOvtL+NKUcT4glNihvHLPokRoo+F8xq7oGogXMwBEkA2gKpb8X3vZ72kzzGke3w4kHNAIXqQh5c
 g+CPosJ1dwhiTysQXtsUl6mDMS5mPTbQ0vpF0MBKGgx+GaP0pk/Rbv59EloH0r0mRTLEpQpZqKg
 U7fHROkA+2ySKRi10lWdbf3WTcwmFm13B7c07dudbLGBGquekJH2FWi3ghg6yeJp7f2znyWKoQa
 zOPIGct8uh8FjVJLIPyc8nLRZLwAqaoM+lGDeXPq8EAtyqXmHqdvcHKYobg9zkTpnX2Ab6s=
X-Google-Smtp-Source: AGHT+IEFUyvIXC1Vgly9S8V1K6I2SlPa6hENT4F091LftnWWqCZEQkUyFKEg0Df/W0dOqNgQ8GtFWQ==
X-Received: by 2002:a05:600c:3b8d:b0:434:f767:68ea with SMTP id
 5b1f17b1804b1-438dc3aa64bmr205402985e9.5.1738570967599; 
 Mon, 03 Feb 2025 00:22:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:67a1:15b4:9565:fea8?
 ([2a01:e0a:3cb:7bb0:67a1:15b4:9565:fea8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e239sm180063105e9.18.2025.02.03.00.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 00:22:47 -0800 (PST)
Message-ID: <05a9dd51-9603-4266-80b0-d0687d11663e@linaro.org>
Date: Mon, 3 Feb 2025 09:22:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: lwip: tftp: fix find_option()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250201062214.56747-1-heinrich.schuchardt@canonical.com>
 <20250201062214.56747-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250201062214.56747-2-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

On 2/1/25 07:22, Heinrich Schuchardt wrote:
> Find_option() is used to retrieve the block size value in an option
> acknowledgment in response to a request containing a block size option
> according to RFC2348.
> 
> The format of an OACK response is described in RFC2347 as
> 
> +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
> |  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
> +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
> 
> The current implementation of find_option() only works if
> 
> * blksize is the first option
> * lwip_strnstr() ignores the length parameter,
>   i.e. is implemented via strstr()
> 
> The OACK messages starts with  0x00 0x06. If 'blksize' is the first option,
> strstr() reports a match when the first parameter points to 0x06. Adding
> the string length of 'blksize' plus 2 to the location of the 0x06 byte
> points to the value.
> 
> Find_option() would report a match for option 'blksize' if the response
> contained an option called 'foo_blksize_bar'. In this case find_option()
> would return 'bar' as the value string.
> 
> If 'blksize' were the second option, find_option() would return a pointer
> to the second character of the value string.
> 
> Furthermore find_option() does not detect if the value string is NUL
> terminated. This may lead to a buffer overrun.
> 
> Provide an implementation that correctly steps from option to option.
> 
> Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	new patch
> ---

That's indeed much better! Thanks for the fix. One minor comment below.
In any case:
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Tested-by: Jerome Forissier <jerome.forissier@linaro.org> (qemu_arm64_lwip)

>  lib/lwip/lwip/src/apps/tftp/tftp.c | 54 +++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index 56aeabc4d73..e85e3623066 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -264,19 +264,55 @@ static u16_t payload_size(void)
>    return TFTP_DEFAULT_BLOCK_SIZE;
>  }
>  
> +/**
> + * find_option() - check if OACK message contains option
> + *
> + * @p:		message buffer
> + * @option:	option key
> + * Return:	option value
> + */
>  static const char *
>  find_option(struct pbuf *p, const char *option)
>  {
> -  int i;
> -  u16_t optlen = strlen(option);
> -  const char *b = p->payload;
> -
> -  for (i = 0; i + optlen + 1 < p->len; i++) {
> -    if (lwip_strnstr(b + i, option, optlen))
> -      return b + i + optlen + 2;
> -  }
> +	const char *pos = p->payload;
> +	int rem = p->len;
> +
> +	/*
> +	 * According to RFC 2347 the OACK packet has the following format:
> +	 *
> +	 * +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
> +	 * |  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
> +	 * +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
> +	 */
> +
> +	/* Skip opc */
> +	pos += 2;
> +	rem -= 2;
> +	if (rem <= 0)
> +		return NULL;
> +
> +	for (;;) {
> +		int len;
> +		int match;
> +
> +		len = strnlen(pos, rem) + 1;
> +		if (rem < len)
> +			break;
> +		match = strcmp(pos, option);
> +		/* Skip option */
> +		pos += len;
> +		rem -= len;
> +		len = strnlen(pos, rem) + 1;
> +		if (rem < len)
> +			break;
> +		if (!match)
> +			return pos;

This reads somewhat counter-intuitively ("if no match"). How about
renaming 'match' to 'cmp' or 'diff'?

> +		/* Skip value */
> +		pos += len;
> +		rem -= len;
> +	}
>  
> -  return NULL;
> +	return NULL;
>  }
>  
>  static void

Regards,
-- 
Jerome
