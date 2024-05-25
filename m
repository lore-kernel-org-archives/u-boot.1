Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76786C25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 21:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B53388268;
	Sat, 25 May 2024 23:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eMx2dB2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A1588276; Sat, 25 May 2024 23:16:33 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386088811D
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 23:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-df4e0d8fa10so4218280276.1
 for <u-boot@lists.denx.de>; Sat, 25 May 2024 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716671790; x=1717276590; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dumPyKVhTSaaOdg3z13XWQALUr2jW1/vj7Y9Mb7Aq0Y=;
 b=eMx2dB2Pd474QQOU0SOFj+OJrvLVV9jznvdsO9xFRPOyXCDHwRC3nYV6jWHNPys8BQ
 K1+6KmEqO57flKEypapawgEHHOVQ3H+NpWZU1mEX96GLZAXzHoXIql1uUKrfkPzWpSc3
 cBtLsHLaYY3ZLP/IypEV5pvOZzpek7s2gWTWLM7U9Vr+H0tdqIu2IqYnopBfZgW0LGoB
 MvKqvBGM4pX+SBzkOQDFMxLqk5jochPA/n8vFf3D2WEeI7NZ0mQqSznJfg6z5wRPlqDn
 nOQxqCZqEyrQVjnoswHRebDDVYnplBhxfoZuElD116MfNZv9GWpPS6PnxCi3alGvRHGj
 PZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716671790; x=1717276590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dumPyKVhTSaaOdg3z13XWQALUr2jW1/vj7Y9Mb7Aq0Y=;
 b=n0aLGsggNTW10mJWLzF7QdQJi6h7wRZblprmvbCWlZ8kPkEZUgQoZtsGgrbf3Yg+MK
 upOO1oB0ilJWhIl7rennEMzajy6mDCIEEm5B/QekONyXn/4tBe/xt+t4B5UpB+i2ZhS2
 SMdaTauk8aa1bIyuATx6Bj0Bd2DiCEO0J5r77I/N7OBAjh/N/cszgwjK47du8ad9T4ZQ
 8WcRvwye2Co1gnfEHTo5DSRSPzhduu/qnDwS8vlCLRD/I5cXRwY5tMnR+faEcm4VWZR2
 RigNuQRbJ0+4/LtI9UCKVTDDWB/fLGbRNWVyknVw4UJnuZRw9O97ZDPoZXhi1IhU3OC1
 iizw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS3E7qkpF4B/TWimO8UIN+j2eIboFlFJ4JPmTIZgGoRk9IOzPSeTqG+hAvzQqqEsg8lgSnT1GqndrfnmmcMkdu2hVIcQ==
X-Gm-Message-State: AOJu0YwPrkMyWo2jOK9G0rfDsyum+0DrfkjyTRIBp8OIhfCm4HZnGj9I
 Y4ZHUw62bybFiT+rvkBZ2hyhDwwFd2+ZYwwdTAoJUIsD561VFdXMMxYAlHouAZ/BY7Y0ZWcMKHb
 MLM3FdHUcllEBPvlv91TiCo8NMWL4lauP/gmnxwO2mBhtNSJ1At0=
X-Google-Smtp-Source: AGHT+IFPQM1+xxGVJ6pc7+DJW8+D6S/o2sh3nkXgTRw5KKa8ffvudiWA1BTpkvD4Y19rkd+d5zrkrqNE//zSDk+Ug8M=
X-Received: by 2002:a25:e20c:0:b0:df4:d9ba:2b6a with SMTP id
 3f1490d57ef6-df77215ec93mr5270393276.14.1716671789957; Sat, 25 May 2024
 14:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240523220334.2502-1-semen.protsenko@linaro.org>
 <CAFA6WYP6m=Jz=9qOXd03K1jKcxkTOEWzGyOscg4bdGcVeX_TFw@mail.gmail.com>
In-Reply-To: <CAFA6WYP6m=Jz=9qOXd03K1jKcxkTOEWzGyOscg4bdGcVeX_TFw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 25 May 2024 16:16:19 -0500
Message-ID: <CAPLW+4mTpc89nbAu=J-rU_X6vhexuVkfQLQWAiYgLTizrtGXHQ@mail.gmail.com>
Subject: Re: [PATCH] arm: exynos: Migrate E850-96 board to OF_UPSTREAM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 23, 2024 at 11:57=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> + Krzysztof, Fyi..
>
> On Fri, 24 May 2024 at 03:33, Sam Protsenko <semen.protsenko@linaro.org> =
wrote:
> >
> > Use upstream device tree files and bindings. To do so:
> >  - imply (enable) OF_UPSTREAM option for E850-96 target
> >  - point DEFAULT_DEVICE_TREE in E850-96 config to upstream dts
> >  - remove now not needed local dts files, binding docs and headers
> >  - update MAINTAINERS correspondingly
> >
> > Upstream device tree files for Exynos850 SoC and E850-96 board are
> > pretty much the same as local (removed) ones, so the conversion is
> > rather straightforward and painless in this case. The appended dts file
> > (arch/arm/dts/exynos850-e850-96-u-boot.dtsi) stays unchanged.
> >
> > The only remaining local dt-bindings doc for E850-96 board is
> > exynos-pmu.yaml. It wasn't removed as it's quite different from Linux
> > kernel version. Particularly U-Boot local version of exynos-pmu.yaml
> > describes "samsung,uart-debug-1" property, which is not present in Linu=
x
> > kernel binding. Later it might be upstreamed to Linux kernel, and once
> > it's done the U-Boot exynos-pmu.yaml binding can be removed.
> >
> > No functional change.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  MAINTAINERS                                   |   7 +-
> >  arch/arm/dts/Makefile                         |   1 -
> >  arch/arm/dts/exynos850-e850-96.dts            | 273 ------
> >  arch/arm/dts/exynos850-pinctrl.dtsi           | 663 --------------
> >  arch/arm/dts/exynos850.dtsi                   | 809 ------------------
> >  arch/arm/mach-exynos/Kconfig                  |   1 +
> >  configs/e850-96_defconfig                     |   2 +-
> >  .../clock/samsung,exynos850-clock.yaml        | 307 -------
> >  .../soc/samsung/exynos-usi.yaml               | 162 ----
> >  include/dt-bindings/clock/exynos850.h         | 337 --------
> >  include/dt-bindings/soc/samsung,exynos-usi.h  |  17 -
> >  11 files changed, 3 insertions(+), 2576 deletions(-)
> >  delete mode 100644 arch/arm/dts/exynos850-e850-96.dts
> >  delete mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
> >  delete mode 100644 arch/arm/dts/exynos850.dtsi
> >  delete mode 100644 doc/device-tree-bindings/clock/samsung,exynos850-cl=
ock.yaml
> >  delete mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yam=
l
> >  delete mode 100644 include/dt-bindings/clock/exynos850.h
> >  delete mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h
> >
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>

Thanks, Sumit! I forgot to update board/samsung/e850-96/MAINTAINERS,
so I'll be sending v2 shortly.

[snip]
