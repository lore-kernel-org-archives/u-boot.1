Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9290EC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E48880EB0;
	Thu, 13 Feb 2025 14:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KY6yXi6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFAD680EB5; Thu, 13 Feb 2025 14:54:17 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32486807D9
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab7cc0c1a37so172042666b.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739454854; x=1740059654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qXCoHPdR+GjDt5J/bpw7cZ5Sg3j0P6wfvMgAv60t+6Y=;
 b=KY6yXi6RJLJ+oiDGr0pOassRfpqEmaT9tgbybsSeDdWsEtgWp5V9wkBlYsRJDKVtKI
 I84DA5pZnNBSwFJgtZ/sepbrr+I7GNRSZIC7H9yiZ88SuVKsw5oLN+YRny1UBAHAnGW9
 t9N/n4B+udw8rySeeq9AhpdpX0kV1M8kBoB8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739454854; x=1740059654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qXCoHPdR+GjDt5J/bpw7cZ5Sg3j0P6wfvMgAv60t+6Y=;
 b=JEho5McsF+/Y0ExwUtrrOf0+8cjaPB+cKXjDnYelX0JFgQjcZ8stYsM/HX30tE82ic
 NWGzHFww6jdf67ZsmP5jhLyS6ylYbS5JUPjjglkB7ttt2ajtk8VuQiPB0AhJCKtbgpMq
 12Ir6WcXPIuXE6uvJx1HVtf8XrbC6pwprE9QCDDER8CW3B2Tya5ZbSdNTw9BVAUdyyIw
 zbjZOsH8jf0D4J0dUAI728f11u6HW+LHq5K+3v+7t3VOt1WnV3gCYABol+k4FMYzUARY
 jMECYCNhBgdN9oHPDpdS+s1kOtJzaqnhQ2yXI7qJk5IGVIbs7azIQXBLQekwEAhIAN/g
 anKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1UzvHyvHL2qRq2hgEVZIWUzYUuBodLWGil1eP3EC98QeA8jJnNWnPy4XyH5MztjU9eKyw5+k=@lists.denx.de
X-Gm-Message-State: AOJu0YwxPgLoNQAjiqipcAMiNoXMnrMyco7Te6C/9zgxsHXGlB3SuZ6+
 BkiKkoilmJwOtRWjWXt45USYtfE9f5rFUDfx9adHdt+shJ+HvsmnPO77wch8eeQBHXVleUJWvyW
 bjv0OXw9g8kEHkCN3Yt8ObXG0wx7186zDfFGT
X-Gm-Gg: ASbGncsaLVIE7+1OA8hE//R9GQYeD8/C9oziPLyBva6KZxueAbGFHsCGUzhFhLLLkTq
 XHvbc7MKCBm7aEWBwN1Y/h18x1+hqikDRJUR73Df8ZCrNHweY48qGE6tmQJLk9b5dbReOpAGCIj
 yxr99DZm0fQN9zO5ewgLi3QQsTFSjc
X-Google-Smtp-Source: AGHT+IFuM6C78uuEdWIbh2PSddW18TPPxsKNHIQoT3mvNk+7J5IBxMLiuRaj4yeypTQUZP9gePADO0Bvi8qAUeEWKVg=
X-Received: by 2002:a17:907:720a:b0:ab7:b9b5:60e7 with SMTP id
 a640c23a62f3a-ab7f347e265mr617846666b.40.1739454854565; Thu, 13 Feb 2025
 05:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
In-Reply-To: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 06:54:03 -0700
X-Gm-Features: AWEUYZkUZqzYAHpNKhu4FoWzq1K2O_a1i05peV1Sr97QuG8GWR7vipWIwDGbM78
Message-ID: <CAFLszTic+bPv-JjsZ4JVz1RXQ247rmjPbGYzQhi5Z8=PC1728w@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: remove u-boot.rom generation and use
 binaries from simple-bin in simple-bin-image
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Tue, 11 Feb 2025 at 03:29, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> This gets rid of u-boot.rom generation as that was used only on Rockchip
> Chromebooks and their maintainer (Simon) seems to agree[1] that
> u-boot-rockchip-spi.bin should do the job now so we don't need to
> generate it anymore. This was agreed for RK3399 Chromebooks, I'm
> attempting to do the same for RK3288 Chromebooks as well so we don't
> have anything requiring that u-boot.rom anymore.
>
> Since HAS_ROM is only guarding this u-boot.rom generation, they are
> removed too from the individual configs.
>
> Finally, this also fixes an issue reported by Naoki[2] where binman
> would try to find symbols from proper to install in xPL binary only for
> it to not find it as we do not generate (on Aarch64) the proper binary
> in simple-bin-spi image node, only in simple-bin, so it cannot have
> access to the symbol. As to why this triggered only when some seemingly
> unrelated symbols are enabled, I do not know.
>
> The first two commits are cleanups. If they are controversial, they can
> be dropped and I'll apply the same fixes for rockchip-u-boot.dtsi to
> {rk3288,rk3399}-u-boot.dtsi binman nodes.
>
> Note that none of the patches were tested outside of a simple build
> test.

Are you able to run them through my lab?

>
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com
> [2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (3):
>       rockchip: rk3399: do not generate u-boot.rom anymore
>       rockchip: rk3288: do not generate u-boot.rom anymore
>       rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
>
>  arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
>  arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>  arch/arm/dts/rockchip-u-boot.dtsi     | 10 ++++++++++
>  arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
>  arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>  5 files changed, 10 insertions(+), 66 deletions(-)
> ---
> base-commit: 636fcc96c3d7e2b00c843e6da78ed3e9e3bdf4de
> change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>

Regards,
Simon
