Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B714C2BA15
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C98F98843F;
	Wed, 19 Jun 2024 14:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="epvcCC6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2483B87F5C; Wed, 19 Jun 2024 14:23:10 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA8D8843F
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so4482545a12.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718799786; x=1719404586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z1SmVFs7eqkmTUp7TbS6JsmJc7S9QvL4vYRr9KMrOxs=;
 b=epvcCC6e4NOpt2FMRcgbOMM/tkAfHQd+2BDKBzr4RlGOUxqiy3Ihx+iEwkexmpXhDF
 x6iz2fkuBNVSrG80aQ0H9TEbKgXmql2spJ5hT2Edc/eW/MTae5aWUVX3p3R5gLuuwhzr
 WB83xyxANEUMC8SQuzS0GRLC1vDqVZD9xKhuaZLAjKjkYcIZyOgnwzziU/mMwudoaFNe
 UB1m8ejHUN2UryYTWGQtXEM5AJ6VUlaXN3zqFQU0RqqpER7l3Ah+MLChV5DcwARW0VIC
 5q7aIGjksQtarP2ga++YDiIHAeEpHL/75UcIu6nYD5IRxCgxiLpVw2nHn2iHlfwC5GSU
 VyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718799786; x=1719404586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z1SmVFs7eqkmTUp7TbS6JsmJc7S9QvL4vYRr9KMrOxs=;
 b=j8dn80MFkS6KHQpqCbf7NjCA41fk3pK/YN6On8PUOX+TSYS0Z4ZLCw1Zw3F8ZaRUrh
 A2tPz9gwHfperhfOskdJl9WzP+qM5FjHl6RGAG98kP6fnax1ieNY8UUkPvRsKm2/I72M
 mGFl5OrYSpeJhU7dVEE3coJ52KVku/MqxbT+3wG+NmsoHEGzSwFjF+wgghwakwZ84XtA
 9SRwiID7gGaf8zr+Ql/ttDkPskog9+5odWfYdaIVVXHUP3s+XpjLTs/9qOpYv6AWKiP8
 gir8QfZ7NcEwrboESibVjYV+q8LuKbvV10j51X9FMQD3ohLXErPsNBgVve4KUhpCXgEN
 9mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR5PONk9BffJmmun7sU6C9gYbnqTsct1lqYFMezrNlxrVxQD1nLjwgifXMAMhM5WI/z1uyzCYl4bPOaheW46ylOwqJ3Q==
X-Gm-Message-State: AOJu0YycEo0rtlEXj8nNPuDI0hptnhfsbvA34/xNGgIMmpJpoy/gFKJM
 Usp8zRwkM6q5byeXrGo0SaFmPeI2TuXo8Y/PWbP8Y9aJMT5bwvdeVPQgXxLygMPNbyuznleUwjM
 xpfZZT8QZWsVEZIb/3Tp5mwQSpuJ0qgEG4C/Ohw==
X-Google-Smtp-Source: AGHT+IHywyD4sS8w1Vqox6bGIxwTega6IBB/wHznBU6PSW/oVVgzIkZoB1XXNTLWsY1mQXIlHe23ULh+M0Jo7E1DG4c=
X-Received: by 2002:a05:6a20:a891:b0:1b8:1be8:8014 with SMTP id
 adf61e73a8af0-1bcbb6415b7mr1915602637.39.1718799786067; Wed, 19 Jun 2024
 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240616173105.7430-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 15:22:28 +0300
Message-ID: <CAC_iWj+VpDYAdzj0fqxBPAPshVt03g9SCNafxN-8RPdrPVDiMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: implement invalidate_icache_all on ARM11
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
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

On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In EFI sub-system we rely on invalidate_icache_all() to invalidate the
> instruction cache after loading binaries. Add the missing implementation on
> ARM1136, ARM1176.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/cpu/arm11/cpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/cpu/arm11/cpu.c b/arch/arm/cpu/arm11/cpu.c
> index 01d2e1a125d..4bf0446b543 100644
> --- a/arch/arm/cpu/arm11/cpu.c
> +++ b/arch/arm/cpu/arm11/cpu.c
> @@ -116,3 +116,15 @@ void enable_caches(void)
>  #endif
>  }
>  #endif
> +
> +#if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
> +/* Invalidate entire I-cache */
> +void invalidate_icache_all(void)
> +{
> +       unsigned long i = 0;
> +
> +       asm ("mcr p15, 0, %0, c7, c5, 0" : : "r" (i));

This looks correct, but can't we define it as
__asm__("mcr p15, 0, %0, c7, c5, 0" : : "r" (0)); ?

Thanks
/Ilias
> +}
> +#else
> +void invalidate_icache_all(void) {}
> +#endif
> --
> 2.43.0
>
