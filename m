Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF32CD462A1
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B4E894D4;
	Wed, 13 Nov 2024 14:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BBEUCXTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085D888FC8; Wed, 13 Nov 2024 14:40:03 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43500894D4
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso1227930166b.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731505200; x=1732110000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WVxfRytA7rX7+q3TIlEG5295QXpAx9I2DNWu7yAOsVo=;
 b=BBEUCXTeA1ho9XbceBm+MXMcXex6Hrq6iZ1uXwLI0D6zzUqq9toztrGofF8GE57XUv
 YqCpmVJJNWHAO2UpJnzIh3OVTlfDlSE6eEEcxqYk/IUEl+pSQaKGixdWxDUXHfcNeQIA
 QFWeGo/6D3QvxW8hc+CJBLrTBw74j96iywvf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731505200; x=1732110000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVxfRytA7rX7+q3TIlEG5295QXpAx9I2DNWu7yAOsVo=;
 b=igSgho8GYNVZIrcZnrdsHRPCYwBT3SjGi4IDKQuxTRXEChC7PxsDAXb4aNRTnk2tsu
 x4mjE2sR7KWwySVPrKuBl5QFbRYSRJdJAZl+1HHl6srIRBYnggEH2LgvOJeQ+jw4juc5
 lT747YaSgvPML0srGXbTMRDNIlvXXqK/Ycl4CldD2abOcVffWhQJqfRlrp9gLyfAZyHk
 WFssCUK3cE/05NKivCPLolQAci4SodbUaqpmkYAa1Mm1BV97DQgeKKwcR2Pg/1vWADvY
 ESCenmybGnOU573xZe7Qjag2Rjjay0xhsK0HwH2LM1MCx3Gs6ajTysVSsGK9VvGnRvbU
 lQzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0CbyZCJjo8c5OK7yZhuAUJJnFW7KVAoAiMoN2TjYd7uh6G0CxrcnKXLnAVsLHl0bWPw6phFc=@lists.denx.de
X-Gm-Message-State: AOJu0YxNtH1J/UlAFqq4/oBqdW11sl2vJZFpAtDsAU7TN6OzU+I1Zqhm
 ggodvLpxLvAJdvhqBQZWFrmp4Q6Rc0DOWtztUv9k5xlPVjL92j0Fm54pcpqRFCycbrDK3f10Lah
 TP8PxQ3Wf0HeQGK/XDItJrfRu+SmiwaJ1DYv9
X-Google-Smtp-Source: AGHT+IGlOZ2M+2VIAVaYVykqGzSoqKLlI8TuBsobC1wq19ihomRlkC88BwnqCJsQAztVrfrpvPQ3A8VSwI88Gm4F4yw=
X-Received: by 2002:a17:907:6d05:b0:a9a:19c8:740c with SMTP id
 a640c23a62f3a-a9eeffeeb1bmr2000073966b.47.1731505199738; Wed, 13 Nov 2024
 05:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 06:39:43 -0700
Message-ID: <CAFLszTjhzw8i-28V+V8M+v41x5Y46vqeDOW+DyCP0JOKdszf7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 3 Nov 2024 at 15:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We often convert hexadecimal strings to hextoull(). Provide a wrapper
> function to simple_strtoull() that does not require specifying the radix.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  include/vsprintf.h | 13 +++++++++++++
>  lib/strto.c        |  5 +++++
>  2 files changed, 18 insertions(+)

Could you add a test?

>
> diff --git a/include/vsprintf.h b/include/vsprintf.h
> index fe951471426..9da6ce7cc4d 100644
> --- a/include/vsprintf.h
> +++ b/include/vsprintf.h
> @@ -44,6 +44,19 @@ ulong simple_strtoul(const char *cp, char **endp, unsigned int base);
>   */
>  unsigned long hextoul(const char *cp, char **endp);
>
> +/**
> + * hex_strtoull - convert a string in hex to an unsigned long long
> + *
> + * @cp: The string to be converted
> + * @endp: Updated to point to the first character not converted
> + * Return: value decoded from string (0 if invalid)
> + *
> + * Converts a hex string to an unsigned long long. If there are invalid
> + * characters at the end these are ignored. In the worst case, if all characters
> + * are invalid, 0 is returned
> + */
> +unsigned long long hextoull(const char *cp, char **endp);
> +
>  /**
>   * dec_strtoul - convert a string in decimal to an unsigned long
>   *
> diff --git a/lib/strto.c b/lib/strto.c
> index f83ac67c666..206d1e91847 100644
> --- a/lib/strto.c
> +++ b/lib/strto.c
> @@ -78,6 +78,11 @@ ulong hextoul(const char *cp, char **endp)
>         return simple_strtoul(cp, endp, 16);
>  }
>
> +unsigned long long hextoull(const char *cp, char **endp)
> +{
> +       return simple_strtoull(cp, endp, 16);
> +}
> +
>  ulong dectoul(const char *cp, char **endp)
>  {
>         return simple_strtoul(cp, endp, 10);
> --
> 2.45.2
>

Regards,
Simon
