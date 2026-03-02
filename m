Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE4EB362B
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B73183F4C;
	Mon,  2 Mar 2026 19:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnuYD3Kx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5037483F56; Mon,  2 Mar 2026 19:08:53 +0100 (CET)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC2583F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1273349c56bso5663948c88.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:08:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772474929; cv=none;
 d=google.com; s=arc-20240605;
 b=XIfydWs1BO6pgXszGEh12pTgzENriVSAJ/kQHnzHu0bVNb77KUaM9gfb3FNUz7G27+
 9Ie2VkTv1y3XwkDCqzvQ6bHqKcpI9WQFfk78JS95NDR9kRVi5YcdAiezwyIotxYFuKH9
 Da0scXkyFH/aux5w2H725ShFUo3xzoykcobzNP1i0fhINyvYBlcKHTYM2Tuy834PA9M6
 3CukrbBDQTXnNpmlfdBlMUTjtvJsBb4LPP2p+Ru1Oym1n2JSEaFolkc4RdXzr9dOLNfe
 g5VYWYHvHrp0l9+hlElj+MdLDyPNlQTYcAOumbhzpLFSyBZ3IDB3nhfPKFRvcipLkP8s
 41uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nY1PPSyvnTxiD9Ibk0wmf4AbOVjvnm8tJUbSkyAXZ5U=;
 fh=hbkZZgIb0aGJU4yrnj7/9R3KkauCCW0jZdoi4xKh5es=;
 b=QG57xVAIlGDO/AQsxxwUqDpumUGVKDt9Y9GME6re+4GVp4z9nTkiK7dl3EDT8RQ1j6
 K3nba8f5MmiX/HYEEvUeCK4OvxEhTL9XlxCEXO853tNXfc4CSbeJk/jvayccealZnhTI
 7HfPswup6TNxK9ztQsct8TLCpNrSjUHaKMs27sSbOQXXSkiKOYz9DK1sqiXo0+d1A4+B
 P4txJysHRm675xymqaqdDddZfHC3DvnYIJ79Il6a8bGo92bDSKmyW04RR1eEmNv5v6PP
 PDzZqSYYBKQqneVWBDCeGecKWc7NBHWiQoI/jqVQzu6/Xj43r6ay6cKkmHiO3evwoOQF
 /jnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772474929; x=1773079729; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY1PPSyvnTxiD9Ibk0wmf4AbOVjvnm8tJUbSkyAXZ5U=;
 b=PnuYD3Kxu1x9GsJhUJq367Wc/I65H9sjS3ydOQjCWkskYMtNi906bBlqmZiyZvqOf7
 LrzrvDJv3r0lKVK+4VPwXS9TLKq+qnWN6mtOIwRGewAoi7FdETJ5M7FcdVlOsL8UNHOa
 7aZ8aeFbKtig/AjC1saQIrkvUU/wdu1CHzo0upXGpjBfk+Z36dT5blayAnmt4UpJb98D
 fp2ARGGsJchOS4RHUdihtrBH3jdhcgt6+2zLHit9tSKatHR+lnUetMn/Mk6lKYyI+8bp
 PmnEzBcCYpl6kUPTDSarm0KyK/d18yQZ3L+BS/SXNbekfG90DH2+otzZqu5G1ZdfmZWQ
 W7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474929; x=1773079729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nY1PPSyvnTxiD9Ibk0wmf4AbOVjvnm8tJUbSkyAXZ5U=;
 b=lLsEXuwP+8P0Xke2uOjTXtvXsRcEM2pjJ7Cy/5tUb9WCREWoeYY+S4NMFgUDvJqb7/
 mlXrUThyRUjo426aKhh/lRmw+yGUCqbLJMqriujDuDUhjplwGeUi37/eDzmq4sJz/oYu
 d9/Q3xjJAecnYKhh3z8+0Rv1TBpppsEvp8tR7Q2sQq9P9OgoMugHAM/kRg8SURFnhNTZ
 9ct5MP9lLiAUFwLcKVC2Sfo2Dg3+ELCwbnCUHGyIgo9wa2BdkPqqa+nh3UAjAnGlPP4W
 KjKq9VGo1MhhQ6/jxpSiCkAw4iJGJM9n0YhZ3fRJ5md+XAadSHMSrz9SkAJI4qCtp4V/
 YESA==
X-Gm-Message-State: AOJu0YzvO+cy9mgrZc1nvwj1JhK8hBWVdvNGL57D7ujC7er7hAdUZyet
 PeBo/veztrgaOrNgGgwceyEf/J+59kI82oiDj5Ir0UAY4yZtRI/vW3AiLxm45Hwzh3JAEhLdj2L
 34rkvhW6B9+5CL5UhYMjmQ4HDPSI0tQ==
X-Gm-Gg: ATEYQzzdc+22rYbC/gdG66fWmsKpTkkVhNAIheoZ1Wfm0oUH1xVHK+52iwcMSJTYQRT
 nFy1mr5vbqnmQN9hAT+Fx0zvMqltO5heJfgnXHOwcaPlAmz1zIYcvTurN3Vf9Bwi109XvNaolpu
 5WeUp96p08+kHF//iQavcL+Zpy2RAH7BHcvnxSMEn7dtxL56vCF3abSY+Xy+NbEFbOyp2f3AlLi
 SSHRmbjR37tjfMJeoMcrHNHPOOoajfhaV/hOLlfOfDgpz8ZpZwJhLoTAfSGTCYazhLBFcYu5AMU
 94jrTUG/ZOsiA6hRsFJXKQ7dks+h0Ic9rjCRYPM=
X-Received: by 2002:a05:7022:20e:b0:123:3488:899f with SMTP id
 a92af1059eb24-1278fc3dcaemr5247393c88.32.1772474928824; Mon, 02 Mar 2026
 10:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20260226111136.354009-1-philip@philipmolloy.com>
In-Reply-To: <20260226111136.354009-1-philip@philipmolloy.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 2 Mar 2026 13:08:14 -0500
X-Gm-Features: AaiRm53zpR7WUT1d4kS_XKvgQoRGTNew3cJCRAQBXHN5k4701Nfl33vDotXtOpE
Message-ID: <CABdDSeXD8OtWNzZNgXh382C7r7Kb1pJN_3dDhaVt5Bfn0t33Qg@mail.gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Update ADI ADSP platform maintainers
To: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, linux@analog.com, 
 Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, E Shattow <e@freeshell.de>, 
 Heiko Schocher <hs@nabladev.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
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

Hi Philip,

On Thu, Feb 26, 2026 at 6:11=E2=80=AFAM Philip Molloy <philip@philipmolloy.=
com> wrote:
>
> This series updates the maintainers for the ADI ADSP platform. It
> follows Greg's series adding support for ADI ADSP SoCs.[1]
>
> Timesys spent years developing and maintaining Linux support for ADI
> ADSP SoCs. The maintenance contract has ended and ADI has brought
> that effort in-house. Additionally, Timesys was acquired by another
> company.
>
> Thanks to everyone at Timesys for all of their hard work over the years!
>
> [1]: https://lore.kernel.org/u-boot/176920759551.2792764.4393744502494646=
019.b4-ty@konsulko.com/
>
> Philip Molloy (2):
>   MAINTAINERS: Update ARM SC5xx
>   treewide: Remove Timesys from ADI ADSP maintenance
>
>  MAINTAINERS                                  | 7 ++-----
>  arch/arm/include/asm/arch-adi/sc5xx/sc5xx.h  | 4 +---
>  arch/arm/include/asm/arch-adi/sc5xx/soc.h    | 4 +---
>  arch/arm/include/asm/arch-adi/sc5xx/spl.h    | 4 +---
>  arch/arm/mach-sc5xx/Kconfig                  | 5 +----
>  arch/arm/mach-sc5xx/Makefile                 | 5 +----
>  arch/arm/mach-sc5xx/config.mk                | 5 +----
>  arch/arm/mach-sc5xx/init/Makefile            | 5 +----
>  arch/arm/mach-sc5xx/init/clkinit.c           | 4 +---
>  arch/arm/mach-sc5xx/init/clkinit.h           | 4 +---
>  arch/arm/mach-sc5xx/init/dmcinit.c           | 4 +---
>  arch/arm/mach-sc5xx/init/dmcinit.h           | 4 +---
>  arch/arm/mach-sc5xx/init/mem/is43tr16512bl.h | 4 +---
>  arch/arm/mach-sc5xx/init/mem/mt41k128m16jt.h | 4 +---
>  arch/arm/mach-sc5xx/init/mem/mt41k512m16ha.h | 4 +---
>  arch/arm/mach-sc5xx/init/mem/mt47h128m16rt.h | 4 +---
>  arch/arm/mach-sc5xx/rcu.c                    | 3 +--
>  arch/arm/mach-sc5xx/sc57x.c                  | 4 +---
>  arch/arm/mach-sc5xx/sc58x.c                  | 4 +---
>  arch/arm/mach-sc5xx/sc59x.c                  | 4 +---
>  arch/arm/mach-sc5xx/sc59x_64.c               | 4 +---
>  arch/arm/mach-sc5xx/soc.c                    | 4 +---
>  arch/arm/mach-sc5xx/spl.c                    | 4 +---
>  drivers/clk/adi/Kconfig                      | 5 +----
>  drivers/clk/adi/Makefile                     | 5 +----
>  drivers/clk/adi/clk-adi-pll.c                | 2 +-
>  drivers/clk/adi/clk-adi-sc57x.c              | 2 +-
>  drivers/clk/adi/clk-adi-sc58x.c              | 2 +-
>  drivers/clk/adi/clk-adi-sc594.c              | 2 +-
>  drivers/clk/adi/clk-adi-sc598.c              | 2 +-
>  drivers/clk/adi/clk-shared.c                 | 2 +-
>  drivers/clk/adi/clk.h                        | 2 +-
>  drivers/dma/adi_dma.c                        | 5 +----
>  drivers/gpio/adp5588_gpio.c                  | 4 +---
>  drivers/gpio/gpio-adi-adsp.c                 | 3 +--
>  drivers/i2c/adi_i2c.c                        | 4 +---
>  drivers/mmc/adi_sdhci.c                      | 4 +---
>  drivers/net/dwc_eth_qos_adi.c                | 3 +--
>  drivers/pinctrl/pinctrl-adi-adsp.c           | 3 +--
>  drivers/remoteproc/adi_sc5xx_rproc.c         | 4 +---
>  drivers/serial/serial_adi_uart4.c            | 4 +---
>  drivers/spi/adi_spi3.c                       | 6 +-----
>  drivers/timer/adi_sc5xx_timer.c              | 3 +--
>  drivers/usb/musb-new/sc5xx.c                 | 2 +-
>  drivers/watchdog/adi_wdt.c                   | 4 +---
>  include/dt-bindings/clock/adi-sc5xx-clock.h  | 4 +---
>  include/dt-bindings/pinctrl/adi-adsp.h       | 4 +---
>  47 files changed, 48 insertions(+), 131 deletions(-)
>
> --
> 2.52.0
>
> base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
>

Thanks for taking care of this. Glad to have people looking at
MAINTAINERS for help if there are any problems rather than pulling our
old email addresses out of a header as well.

For the series,
Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
