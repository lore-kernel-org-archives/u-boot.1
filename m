Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142B1CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 20:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF07836B4;
	Mon, 27 Oct 2025 21:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="izz1Yc1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B26083906; Mon, 27 Oct 2025 21:04:27 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238F18004F
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 21:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3f5e0e2bf7so1138879566b.3
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761595464; x=1762200264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=afwvj1Tp0CNbxAuCTKfkl99xFWEpibXryTbYQnE1BcI=;
 b=izz1Yc1wG+R4Ki3Te+64IigVv1sEpDM3gzLgiOePnVKHRSNbdj4GXh3ygAjr/gv9Qw
 3gsjVq8xOq6vn/+m9y1HgxFRNIWBbHuzZbCuuD2hu/yEe/b0+o+4PCWGdQExi8rBKoLa
 lv5OiQRAQIDivR8U29RjhadANZopAqubsCVLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761595464; x=1762200264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afwvj1Tp0CNbxAuCTKfkl99xFWEpibXryTbYQnE1BcI=;
 b=Fm5H70wiG8Q/s2mfgsXcn/x/idTyBB86pAoMKdETomWQQ3ujBuQ1U6VOwW4Hufcac2
 bf38FudLwz3vdWXUX2rrILUEoRtnfhA6PLlAUuFCUFoUnD4y6nJp1TifWQqvpJjXazre
 19XkK9nfq2s5IflMd/QzdcvXNE/rTIW1TEnnCBbvJXp4Cy5k9+ulIRvMHfODmS+WmuPy
 2cWnT+GG4CGwUXtD+tcAiabdaFjUCloyrSJ/kHSN8c7Z144b+Z4Mmn9vgjppdpkFRmTL
 ULDCep9LQeRXB25TPqPpRHV7s4El11dqDqyI/VGiv0tof2CxoUf02n6giKqYR56rOnwI
 f1GA==
X-Gm-Message-State: AOJu0Yzec+miETwaNRL0GWy9ilvouDyXTfNOLJT55dQXYh0PPdif1iil
 J0vI2/tpsLHMRDja7lR/XGlbY0uVYaJugRijanaoehm5Vd+6vqEYsSRVEO+YbHLliP95nFYUxr2
 Ad1WLMUE780DuRVN6O/73qiHNfRX8g8JEU+Hyf6J/
X-Gm-Gg: ASbGnctfUF6DXMCLpwOSvcJBV2ggE/55d4zv384gXigBxKTVseGqJPzzCK0lrf6c5cE
 gBGafp4bGI0gBTa2xxq/4QiPp3kng05SJXvaa0d8Wgcnj93IDARux5TB6g/0DVRy3SV/iVQ2MeQ
 kxi/FEMcE+CWqVpjg1l6NMK53LnvDDVVwNvI3HqgHJTC+V3GR/hp1f0jt3LHI9bmVeAdd7pjtEp
 BIoMcZjhBhENO/iQ6+VqhpVU1gG3FyaSXTb5OQOPOJGXfJnjikJdXmfZbFnSV5BQ28EKqc=
X-Google-Smtp-Source: AGHT+IHKr5b+qAmJzFbtecM0K826152NlIs2L1BWAIrNhvLNj6tSIfrOWwz4NO0TihVYcko1pnYkfOnUtAOwXuexR4E=
X-Received: by 2002:a17:907:9413:b0:b6d:7f84:628 with SMTP id
 a640c23a62f3a-b6dba597e92mr123529566b.43.1761595463887; Mon, 27 Oct 2025
 13:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
In-Reply-To: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 27 Oct 2025 20:04:12 +0000
X-Gm-Features: AWmQ_bldftDPSJk0izdpScgXumtGOgk4kERHBxufUE0bFGni3oAw_I0VrRg4uK0
Message-ID: <CAFLszTiBfrrQbFNbOASodKA63D2bGG4O4HU4_B2mcjWvkHZTSg@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: more templating for binman and switch SPI
 image to rksd by default
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 27 Oct 2025 at 16:51, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> The images to flash on SPI and MMC boot media are very similar and
> binman templating engine allows to override properties after inserting
> the template, so let's do that to template the whole boot image instead
> of simply the FIT.
>
> While at it, swap the default format for the SPI image from rkspi to
> rksd. This patch should no change any behavior, just that the new SoCs
> are expected to use rksd if unspecified instead of rkspi which is
> assumed required only on some SoCs (like RK3399) due to some BootROM
> bug/quirk.
>
> Finally, a small cleanup of rk3288-tinker-s including twice the same
> file.
>
> Note that I'm planning on adding support for image signature to
> rockchip-u-boot.dtsi in the next few days/weeks, which is the reason why
> I'm doing this now as I've had to duplicate the work for the inclusion
> of the pubkey in the SPL for the SPI and MMC images for no real reason.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (3):
>       rockchip: binman: template all of simple-bin
>       rockchip: make rksd the default format for SPI images
>       rockchip: rk3288-tinker-s: remove duplicate include

Good to see this improvement!

Do you think the VBE series might get another look at some point?

>
>  arch/arm/dts/px30-u-boot.dtsi              |  12 ++
>  arch/arm/dts/rk3036-u-boot.dtsi            |  13 ++
>  arch/arm/dts/rk3066a-u-boot.dtsi           |  12 ++
>  arch/arm/dts/rk3128-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3188-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk322x-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3288-tinker-s-u-boot.dtsi   |   1 -
>  arch/arm/dts/rk3288-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3308-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi |  12 ++
>  arch/arm/dts/rk3328-u-boot.dtsi            |   1 -
>  arch/arm/dts/rk3368-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3399-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3528-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk356x-u-boot.dtsi            |   1 -
>  arch/arm/dts/rk3576-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rk3588s-u-boot.dtsi           |   1 -
>  arch/arm/dts/rockchip-u-boot.dtsi          | 283 ++++++++++++++---------------
>  arch/arm/dts/rv1108-u-boot.dtsi            |  12 ++
>  arch/arm/dts/rv1126-u-boot.dtsi            |  12 ++
>  20 files changed, 320 insertions(+), 148 deletions(-)
> ---
> base-commit: 9094482ca7576877b2bfaa57c8e73cfeb536f8b9
> change-id: 20251027-rockchip-more-template-86af536f7e86
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>

Regards,
Simon
