Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3FBD5AE79
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288F789231;
	Thu,  7 Nov 2024 10:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QwVAMwaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DD28923A; Thu,  7 Nov 2024 10:47:04 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92863891FA
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cdbe608b3so7710285ad.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730972821; x=1731577621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iTITwqEs7YmcyWbwwuIv1jJ4eDGK3r0za8rL4DOCy4s=;
 b=QwVAMwaWB/QO+Pk/RCjaBFCShOZUIwJMKhKtKDzbcDAgp2dAJJDMPDLT9NHvGIpOu1
 UNxEv18nCDme1cTwcKJ7/koFPNcXVT1ckPx778fWMUnhsuFnOsvf8svxfvtbZfvKfpm/
 aM0sIcnRlM3l3vAlsKTnZrB923rnA5DndOUc3R5nKkX9w38OJacULVh5ysaWBUyMBY0e
 KHzjhfuwk3KZq9WUEx7y0VUwl0wlM6UggW6QI8cBm2QTDd8DO3b+OZeCD0LgqBYmzTvp
 9k0wic6YuB8GIU6VidEjYCNCubWZtX/X5adJjobDyZ4t3i0yo/KvPjUWcnac7RVtG2XJ
 R5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972821; x=1731577621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTITwqEs7YmcyWbwwuIv1jJ4eDGK3r0za8rL4DOCy4s=;
 b=E+GPH3uDr51HuvDjztRlJaP1j8vCA4RViF9OBl0LoGKItza/5EsDwN1WQeh7wWMmsi
 1yDW6uLZgrdoBbythGvg2gqe1ga1Oz2MP6YtjPOJ7aLX19Aj6OsceBgyKXJYoAX13z+9
 zy2fggbzDvOlcB7pA1ojfVDt+gAkOcWaQ2C2ZVh6jnvrDrz0H46LQ4lu5y9DTfWT3jZ4
 N1/3N35fmoil4dbCkrR1D3ssttJoj/N79OXpXPBUlzSDIpL+yPv83eePTXc+T6qCW8A1
 vQS77AXuuZ/jndxcFLzVTCqqajdys8DHMMUTClOPlBncJYa83CIblYJH0GBc2fo35r87
 xxVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7HsxPOUt5XXIxCzq9/sPV1jfughV82pBY5dXgKQ6xB61Lpvdh3SY2myAWbEoqURrFCvel4cE=@lists.denx.de
X-Gm-Message-State: AOJu0YzeRGHgZhKKsFH5KOhQtPI8TsMuQa1a3IkLtDwMyMWba4A747fv
 bWhQbd0MDNB/+XSe3IyFO0I1hZWmm4VAiVsQQ3oipW7Cc4Ezo0mGCJHMVH8lP3JttaCBb10E9m4
 6Kaak47Eib4xSu0xO/ae3Zd9NfpxPjW1Ya7L4XA==
X-Google-Smtp-Source: AGHT+IE4VMxrN9OPq4qyx/XKNBaUq+X0hiZ0EBunqanZ23Gl3HyG0KJ16bAM1Ma9uIAHlHevX9++PRXIoD72B09sTkU=
X-Received: by 2002:a17:90b:164a:b0:2e2:ad11:bd36 with SMTP id
 98e67ed59e1d1-2e9ab0e5bb4mr470008a91.37.1730972821140; Thu, 07 Nov 2024
 01:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20241103204642.175928-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103204642.175928-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:46:25 +0000
Message-ID: <CAC_iWjKX1x+g3__PUY0jurmbF0X1qS89LtDdU+6uw7PrJ9T2Lw@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: print_printf() must check availability of %ls
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

On Sun, 3 Nov 2024 at 20:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Availability of %ls in printf() depends on having
> CONFIG_EFI_LOADER or CONFIG_EFI_APP.
>
> Respect this when testing.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/print_ut.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/test/print_ut.c b/test/print_ut.c
> index f5e607b21a3..bffd446f6c0 100644
> --- a/test/print_ut.c
> +++ b/test/print_ut.c
> @@ -118,8 +118,10 @@ static int print_printf(struct unit_test_state *uts)
>         snprintf(str, 0, "testing none");
>         ut_asserteq('x', *str);
>
> -       sprintf(big_str, "_%ls_", u"foo");
> -       ut_assertok(strcmp("_foo_", big_str));
> +       if (CONFIG_IS_ENABLED(EFI_LOADER) || IS_ENABLED(CONFIG_EFI_APP)) {
> +               sprintf(big_str, "_%ls_", u"foo");
> +               ut_assertok(strcmp("_foo_", big_str));
> +       }
>
>         /* Test the banner function */
>         s = display_options_get_banner(true, str, sizeof(str));
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
