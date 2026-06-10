Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77829CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 11:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA2184878;
	Wed, 10 Jun 2026 13:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="feLY4SdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33614848A1; Wed, 10 Jun 2026 13:27:35 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1405184841
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6924a68e3f3so3041252a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781090851; x=1781695651; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu4pUMD8ykN64EWBmvxDK77OjDStNY3bGPbgw5H/5PI=;
 b=feLY4SdHapeMSrDBz+ZF6ScMD2NaMJmt9MVT2FKAEYHwv/NOjnropdikQK/6IOsmXe
 WX8Zubm0dUkVR6PYo++4J7QSMLyz+0Gj/+AW06KPXC+Tsdk7DxsgHjGaaubqwEOPbRGb
 dABGNfvoQUmna6IF9qCUmHdZNWXKRothSrq4UU0al7h8cRjHYpNxk1ZVq3uCdlJN6iyJ
 iA/wA2S4oIuBAkBbMSH9wkFCIRAHEH0dZx1Qz0r3X1Oi4ln0YIxXY88NPzYOCxN9Gl9q
 fof8poUIO3Gmun0G3V2uqJKcBPIXduxtjQsx4bvpUd5DXF6aIyf7vqM8wj9/tI9trA9o
 AakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781090851; x=1781695651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu4pUMD8ykN64EWBmvxDK77OjDStNY3bGPbgw5H/5PI=;
 b=CCjZr+t32KUsazoe3nuHGyvzXWMF7rhLbHfizCUVoMgJ5W+P+OjRCwDnCucZWPymNQ
 uyBJiZrrv41R0QhSw0wMcwArvIYHJf0VHSATT6IVte+VGoTInH6GhEppv8Lo0DG/I+b3
 EwlXb9ZDO+W4fFokIGziNWkQvhaK19+kJ0DzpbtgAhsqzxTEfUKHJ6JwGyIRqyNdkfIH
 2hkhOuv2vw6nizSEl0G0nAjy9QLXBiWWJkzb8+2V0YfqC078/JQA7vqxRVRhJ3IJWdb1
 3L72mYQii4th3B6toEY4MFJ3UrlqYlm4nvH9Wbvl85+7PWNkUDP+cZVi7eJLaQvswI9T
 xpEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ94A5QN0quS7DjxlPm2GdZTvETZsNhUQtijz8mNME8Cdd9NVvwTEtC3wEae2Z+0+PwHh6L+f98=@lists.denx.de
X-Gm-Message-State: AOJu0YwswyHyNv1+pi3VQer0/5TA5Wm74r4gY3sPmRu+m7SXJmNPWAHx
 lKu1fXlU1uAO+RyRGsxJEyCPhBuP2WxV+VUk0KKfu7YLM2FPgXt7dqXO35mF5ZskmGc=
X-Gm-Gg: Acq92OEB3qqXl5EiaFy0SQGn4WI1Bq7kRormX/nshHFXxVO+5leAIF9pBKyzfxQBsyP
 YpwfP3vWuDoEfv0CRzqICUjmhB9qJp0CBtlNeXX5F9j7bpcGXDOP3YAZDy6t3QmeZylZrkDPnxi
 py+wvfXD0aYDKHW7MmJRzYy+LGsqFLR7HIb/x5FQDTIfaarfpAztLzfDxdQviF6Sxoldzt7YQPa
 /5+2IUE103RsOCTeVYSgq9/84l3Cfj0BtZV6el3mEjOC+zXZgYCmSdF4e+UINgzDqzn3ADEkCVp
 yu5patRyjw+60Oap9JVitg+yDXRN4icaZqJJU6ZgHGv3SiNZYzkRhyJuE+SZZwNi13kjmkhsUcn
 VbaloHYmoCgDAGvC+Ig1gaPxkAELXyrkpDW1chwSMdPb7kBL2pnRvkQSzjgwUcaVQuuNWjg8qK+
 hx3xst0t1JigASYqk5przbqlZkW9A2f8NG9RNOdKpA1f8UTtynNkxs8Vo2m/DaaI2/AsdmVtuKK
 w==
X-Received: by 2002:a05:6402:4506:b0:68b:b599:870f with SMTP id
 4fb4d7f45d1cf-68fa525e6e3mr11941983a12.24.1781090851551; 
 Wed, 10 Jun 2026 04:27:31 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65867e7dsm9851846a12.20.2026.06.10.04.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:27:31 -0700 (PDT)
Message-ID: <bbead433-3ebc-4635-87f6-0ea30b4343fa@linaro.org>
Date: Wed, 10 Jun 2026 13:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-snapdragon: warn on root compatible string
 truncation
Content-Language: en-US
To: Vivek Ray <vk092kumar@gmail.com>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io
References: <20260610093726.1231041-1-vk092kumar@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260610093726.1231041-1-vk092kumar@gmail.com>
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

Hi Vivek,

On 10/06/2026 11:37, Vivek Ray wrote:
> The configure_env() function copies root compatible strings into a
> 32-byte buffer prior to parsing. If a compatible string exceeds this
> limit, strlcpy() silently truncates it, producing a malformed fdtfile
> path and a boot failure with no indication of the root cause.
> 
> Add explicit truncation checks after both strlcpy() calls and emit a
> log_warning() with the offending compatible string to make such
> failures easier to diagnose.

Thanks for the patch! Is there a particular board you ran into this
issue with?

If the buffer is too small for some boards then we should definitely
increase it, could you bump it up to 128?

> 
> Signed-off-by: Vivek Ray <vk092kumar@gmail.com>

> ---
>  arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..9324030ae4d 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -391,6 +391,7 @@ static void configure_env(void)
>  	const char *first_compat, *last_compat;
>  	char *tmp;
>  	char buf[32] = { 0 };
> +	int len = 0;
>  	/*
>  	 * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
>  	 * The vendor is skipped when it's a Qualcomm reference board, or the
> @@ -417,7 +418,10 @@ static void configure_env(void)
>  		return;
>  	}
>  
> -	strlcpy(buf, first_compat, sizeof(buf) - 1);
> +	/* A safety check to avoid silent failure due to name truncation */
> +	len = strlcpy(buf, first_compat, sizeof(buf) - 1);
> +	if (len >= sizeof(buf) - 1)

I think there's an off by 1 here, this should just be > not >=, and the
same below.

Kind regards,

> +		log_warning("compatible '%s' got truncated, fdtfile name too long\n", first_compat);
>  	tmp = buf;
>  
>  	/* The Qualcomm reference boards (RBx, HDK, etc)  */
> @@ -468,7 +472,11 @@ static void configure_env(void)
>  
>  		/* Copy the last compat (e.g. "qcom,sdm845") into buf */
>  		memset(buf, 0, sizeof(buf));
> -		strlcpy(buf, last_compat, sizeof(buf) - 1);
> +
> +		/* check for name truncation */
> +		len = strlcpy(buf, last_compat, sizeof(buf) - 1);
> +		if (len >= sizeof(buf) - 1)
> +			log_warning("compatible '%s' got truncated, fdtfile name too long\n", last_compat);
>  		tmp = buf;
>  
>  		/* strsep() is destructive, it replaces the comma with a \0 */

-- 
// Casey (she/her)

