Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5069D1CA29
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 05:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD1E88E7B;
	Tue,  5 Nov 2024 06:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g6YNfeqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE3888E7B; Tue,  5 Nov 2024 06:38:06 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E26088F4E
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 06:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-288a90e4394so2254433fac.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 21:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730785078; x=1731389878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QcFFlAaH/RkGGv81PC4da7pPUHS5x6KL2CGZ2ihbzc0=;
 b=g6YNfeqIvDUWCTU+1DoL5xTdGKihLCPuKy6O8BEwfwh+hioNrt6zieSz+Hb61eHblN
 M3CYLea5KGOLLPxVChFqq483280lFCQI2ua13muG/3doO1suCb1mXqOaGTQGsAg0ykdO
 2B+2DJFFXZaxijoGlgXumFUlB3O4LDjacmThKqWwaC0Q0k2CcrbajQ0JZoAa9D8BEVoJ
 VQRLq9ELreXZ/Tup3bPZxB47T24LZZ0BTKvAn5nWIfXlds6Owp1JMp8ymM4WDIkgPkvr
 Gog1uG3m0qe+dSEHB7vJmkKdQA6LgKe8SaZDaDBPWEnPRg6mb4iAMZw0RuHdm2mFEdBW
 0ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730785078; x=1731389878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QcFFlAaH/RkGGv81PC4da7pPUHS5x6KL2CGZ2ihbzc0=;
 b=rRspqGWLacRcQ48bU7U5OHYtArFyLRUIXjquvvEIK0jFIfmlEzbZ8IdvgSC4GodnH6
 Qvgc3ylNocRYAxpH/q2f+YodfmTYyqqkykQTa6fm6I5c5Chj0WHPriPgh+iRha+xTXDA
 ivG9v9IEcTFVWseBllRoH+wNkY5krJXdQMKGoNHFbGqdPxIHfuhHknefSZ5xJMSSY92/
 h4fWkPQVKbPequ9bIFdumjRg9OS6cDWTkFhjvlAP0HZblDKHhPtH0jYLT30vYSTudpL4
 XbEH82DrF5vKk9coTrsHo/hiXzeWhDCldipufz7Q4nfaDebD4FiBf19Ayw/mFhkv/aMq
 zJVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVci+J5WyG5LNkTfyH+CAPvuFvKZp+I3/QmgAyTNjc6bejCaZVd5S7mRs4QH6+xjW9ORaRQPyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzd1QMGWZKdZK47N9weJ6oCIgRn0ukgoVN1F68z/euBQ/0HwKSU
 wPF2P+yN0BxNKistcoSW0gFi9g4tjw/VurvvzHrZ4aTPg9foqGqJWkxiR9f3W1YVHOvpltQzQ7V
 yfpc4l5Zb2Q+mn/tfigXizM1Ds5I=
X-Google-Smtp-Source: AGHT+IEGSrIEJ1TtGh0iSDJ7DMi3KnDzpYlRrvKrEO8g/aI3hFflarxIRlCYqgjjkPY/A0uyBHg8CqhXssJKXLxFvBA=
X-Received: by 2002:a05:6871:378a:b0:278:2c82:e056 with SMTP id
 586e51a60fabf-294648015b1mr18611510fac.23.1730785078265; Mon, 04 Nov 2024
 21:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20240910-exynos-pinctrl-v1-1-f220454470ef@grimler.se>
In-Reply-To: <20240910-exynos-pinctrl-v1-1-f220454470ef@grimler.se>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 5 Nov 2024 14:37:46 +0900
Message-ID: <CALrBrZ3rbEM2wAbwQ=8mbw3-tEpZwQGffVwYYt=n6s5JrpOQ+Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: exynos: fix type of count integer
To: Henrik Grimler <henrik@grimler.se>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Thomas Abraham <thomas.ab@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,


2024=EB=85=84 9=EC=9B=94 11=EC=9D=BC (=EC=88=98) 03:46, Henrik Grimler <hen=
rik@grimler.se>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> unsigned int count is used to capture return of dev_read_string_count.
> When an error occurs dev_read_string_count returns -ve, which can
> hence not be handled correctly. Use int instead of unsigned int so
> that errors are detected.
>
> Fixes: 16ca80adc551 ("pinctrl: Add pinctrl driver support for Exynos7420
> SoC")
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  drivers/pinctrl/exynos/pinctrl-exynos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c
> b/drivers/pinctrl/exynos/pinctrl-exynos.c
> index b393127c64..b37282fa9d 100644
> --- a/drivers/pinctrl/exynos/pinctrl-exynos.c
> +++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
> @@ -114,8 +114,8 @@ static void exynos_pinctrl_set_pincfg(unsigned long
> reg_base, u32 pin_num,
>  int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config=
)
>  {
>         struct exynos_pinctrl_priv *priv =3D dev_get_priv(dev);
> -       unsigned int count, idx;
> -       unsigned int pinvals[PINCFG_TYPE_NUM];
> +       int count;
> +       unsigned int idx, pinvals[PINCFG_TYPE_NUM];
>
>         /*
>          * refer to the following document for the pinctrl bindings
>
> ---
> base-commit: ce1a2630827a1f9ddadb2598ab7936732e6cb723
> change-id: 20240910-exynos-pinctrl-c70d952d7f9b
>
> Best regards,
> --
> Henrik Grimler <henrik@grimler.se>
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
