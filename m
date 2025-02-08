Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A317C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 23:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8B580805;
	Sun,  9 Feb 2025 00:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FvyRKjV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C451580821; Sun,  9 Feb 2025 00:05:02 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABBDF807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 00:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5dce4a5d8a0so5327940a12.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739055900; x=1739660700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DE9PG+490YOnSodd3sbPCZQ16wlcdtn/eH/ZbGe4iR4=;
 b=FvyRKjV0mNWcQ8I2Oz6gYKUkFyqnRZkwBxEAOwk1S1VU6ZRwtFJct0zCLi1OU8TfsA
 Wp/jRyEUc3oMkLeRV/SqFKfvWuJsfi41MCJimfMbzRxnVyyXtqLrTP+dbEIaqWWG1NNJ
 PpZGZWSzcCaAhU1ztxhzs2z+asjVrgNhbCi+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739055900; x=1739660700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DE9PG+490YOnSodd3sbPCZQ16wlcdtn/eH/ZbGe4iR4=;
 b=nHQHfHeEFcSWWTO0zxd9h+Kzq4eT1YJDIOhreLMSqNRQA9U3wdinLaVwgMmD6CsByY
 Dty6BxnwxWgWWPPX6tlKV7e23kHdeATgei/lQPBdgaHk1tOSQGSzUEFdjCsbUFfV3HIB
 HG130LEIQf3Mwz6DlvVqCz8HHcfTmPApPUp5xEXcu9yOwVMizLZR2Ws/mFsDsRwkSz9P
 m9h1lGjD84k9/0lUFQYQVSyoQer5huX7kYndnYOWtZ1lV/GqkoGXwfrKIFzoifmVWIVm
 XwiYur1mzf7wKGTFZ0rSbXqf7sByI52727oo5tfeCu/07tlGs3KUbTBw8uU1GZpSoGSz
 3l0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1tWalVX9u89bdBGk6X2pkQQtJ/hzUbUjNYhFn9Neo5QTHA4paOAxBPWFmvxdpdBYzmPZoOMc=@lists.denx.de
X-Gm-Message-State: AOJu0YwN/sMJ6SPvRA9m8xM2qGSTaS1IJzyr9lBKocb9s+ZggkPE9RKw
 nV8gVpCLPAfONJYa5tbKvM9pWMCSmat7z1Y1xctfXvUeQmQsW1dv/QSLOHB6H83DSE0lYgMx0mn
 hnhkvgeb3JAJvKSj8+VDhIvNRGEwxGLD5jNGu
X-Gm-Gg: ASbGncsOd9Ao2CYIupPu6baRdcHsO2eDtv5/paCT3IK+ar5ZLC5Smd5aEOlRYXxGDPx
 Ks7oDsQ1pORKwHRlTpz/C8TXosby1ag9Lic1yXTdJdiUX8SlZMppMsa8fyl3WZnt1/ig3ZiaXpw
 ==
X-Google-Smtp-Source: AGHT+IHWOZLLV7jtNvI8OLhjj9bMwo6KsricuXLEULl28ICz5N2UGZS4EfpUWRPhhEArxZnyrOYIqIH238M+D/KXGfo=
X-Received: by 2002:a05:6402:360d:b0:5de:5865:69ae with SMTP id
 4fb4d7f45d1cf-5de58656b68mr13790668a12.29.1739055899992; Sat, 08 Feb 2025
 15:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-3-jonas@kwiboo.se>
In-Reply-To: <20241212235735.164272-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Feb 2025 16:04:48 -0700
X-Gm-Features: AWEUYZkXZhkFJPHQxQnjA-aMQfT5EcF73qhV8T_JH5j6gHkVePHyV4alXHWiLJY
Message-ID: <CAFLszThaHxr6T5mj6jCWUUsieuSkCsmcWMDNu+td5jSimeL2PA@mail.gmail.com>
Subject: Re: [PATCH 02/12] rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value
 in offset prop
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
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

Hi Jonas,

On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Use the offset configured with SYS_SPI_U_BOOT_OFFS Kconfig option
> instead of a hardcoded 0x40000 for the FIT payload offset.
>
> This has no intended impact as SYS_SPI_U_BOOT_OFFS=0x40000.

When you add CONFIG options into a devicetree, it makes it difficult
to build it. We have to individually build U-Boot for each target just
to get the right values.

For rk3399-generic, this means I have to drop gru.

Can we not use a binman symbols instead?

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk3399-gru-u-boot.dtsi | 2 +-
>  arch/arm/dts/rk3399-u-boot.dtsi     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Regards,
SImon
