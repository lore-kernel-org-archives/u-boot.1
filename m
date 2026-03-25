Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2668FEA83D
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E57838BB;
	Wed, 25 Mar 2026 10:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LELZJBkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B8883BC7; Wed, 25 Mar 2026 10:50:03 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EA881E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b40003d13so4043701f8f.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774432200; cv=none;
 d=google.com; s=arc-20240605;
 b=c94KyTX454Y6JwdCAQt+C2o/p8O4RB3ur6GtYqLPP3RubmDOWknDW83w/mIq5AKgLc
 AWG1VEtanAUP7hB4gLI3OqrtsA1XVcqTErW4L7/1+hODNXTtfa0zOT9Mbn282XMZhH0e
 ymVqLS19HQE52Fk9W5z5WU8wxwjZ5dKo/S0QPQgN37jFyQq57epgCMVj9WtGWTTztzi+
 qqbGMxvhg/a7vmoFmd/JEaMEG7XIMj/uC0fxeizLPI1/8oyLYtJ/3M1zWIGbRh/A1AMx
 3OBOc65jSG+EZE3XBwp2nyH6HYH6M+2aIl6DOCmmT2HDgbX9ZusfVYap4ZCy42qtd14Y
 7Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CCRTV9uyRbWISy7+ySM7xkoMVHIkgikoUlESWsDeYR4=;
 fh=ImkcPxi+vjXGJcd+xuKmCKkoF1M+rWnCtZ8MZKB7uhs=;
 b=K1Pwtf6CIC0tVbAJPbOFfLQU8+nVdAiRvvnb8SF4G5nABeEHUS2tZiMbLqU37oSJ0H
 IDT9qQaNkQT7WVLYYPM0O6V8JKU635Qurk3M5PEnGt3KoyAjGuLwFlouXaFmCLtJ/nDL
 blkTTJfj2yJqa/FosR1u2vUVEWDab8sRFVY4m8bAX20eDU8bMFtHekA7tmttALYmLWfC
 FDa7KaJBG+jhF0R/ZX/hFJAZnzDZ+CIFKMkaMCcl5GVHS5yP3vTAervmi1dXrg0HhyiH
 kADOtSHAOsoJWhTIzoPWf5gU30C1UjcchFDfuwyVYyAG2zCiawj0c5a5vDZo++GR6wME
 lGRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774432200; x=1775037000; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCRTV9uyRbWISy7+ySM7xkoMVHIkgikoUlESWsDeYR4=;
 b=LELZJBkb9YgT9sY0vBapabHi7j6BVbs8kf4PfDQEXT8Z/aHe75QAP/sYWSD8um33B8
 3H2X/bsLTH/oYTeKFDsL0qzzocKd0v0MuNc+Ulv+D9uNnHwgN3fUNR9Zy1Fn3L28Nx4A
 zbtUzFBRlWI4jG3HjlCVlbywurxTRW4VI/5MqqQLCevy3sh80oAorDHqh2aU6dluNW8g
 Olwubj0JOXbCDBreXYgzeZ0Cpq8ujGkKh/UYvcRphygb64UD4mq9xTRC2OzzfcUA5W6i
 hbt5V/W8PLuAmR5Y6ClgXSuFzpzlc3vBB+7SywjBtwL6LpVF2HvKaGgpT/2amuWWg3Vk
 +XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432200; x=1775037000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CCRTV9uyRbWISy7+ySM7xkoMVHIkgikoUlESWsDeYR4=;
 b=FetqNBQY3pkPMOvwc5t+FhhQUcT0/3V+nKHvULU/5ebU7IyyGS1evxVu9xIiY0gK64
 tY8pgYM15ha2O5gsxE5Sf7ZDYVkhfq9LXiY3KMUpdXgxgGOClLI21PqTarOC9brr99b4
 k/7owUmnR8f3KszAbl5RATL8rBKPk5X4Y4GJvcq996hYXBFVydmnNOiRa0eALpCu4v/e
 n+SvIhzjl/PPATyunthAk0ICvGKcUEN6PGgOF7JKP4Hea92r+uvC+YnEXzunYY1YS54/
 dANWhj33Yi0fbUzq7gkE5lOL0HsrKvOZ4d/JvZ4JT8rQKPgK2+ttMY7mRTEaKJR6PiBv
 w1VQ==
X-Gm-Message-State: AOJu0YxcZE2Rs/omRl6ElPoPxwfKlh9uuxHzedY7gzuFsX8UoG3Dm9+t
 c+gWg5IndiEnyinnNRv+f6CCyMq32s861d4XMnqwsqt4H4lOeTGRxgYCE5taiEbgJR0rRk2msoj
 Pxe23SVVGGejdSgU65xOZgZao9F+oGQs=
X-Gm-Gg: ATEYQzwp+GkOpDre1HT72kSaL2PI1veFAKIVAunx2FNcXL1RSw+YnMN/uVpTm5bJUag
 pPp7hR4A+kmBwK+vRla/o7cLVlN0QYbAZI+S70iB/edufNyZUdjevYwtcwrLsT/ZHwxQivTU6Ot
 UBHUNLSnaGXvn/rGMSOc3VFWuKe3B+lNAioxunhWsc0qE0MtrC/O3u5WaLwuUgbBhHlNym9T0F3
 PnFpcIZi/6uslBUXNngAg1+8an+Iw58XbhU1pMSprYkkAkvirWcx7AhZL1TnlCoOQNu4aHgiDOH
 9cMUz+Td
X-Received: by 2002:a05:6000:1842:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-43b88a4137fmr3967651f8f.50.1774432199428; Wed, 25 Mar 2026
 02:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260323225537.896180-1-trini@konsulko.com>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Mar 2026 11:49:47 +0200
X-Gm-Features: AQROBzABhbC9_ktNUl2POzJ2hLo8YRR3441-TE89-tLolwsGaucqFxVrU2ci73w
Message-ID: <CAPVz0n3z1MOWOUMJZQpw-vs8oC7eMo9gXdPMpVT62R9-fLSeBA@mail.gmail.com>
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Thierry Reding <treding@nvidia.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io, 
 linux@analog.com
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

=D0=B2=D1=82, 24 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 00:55 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: =C5=81ukasz Majewski <lukma@nabladev.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: u-boot-amlogic@groups.io
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> Cc: u-boot-qcom@groups.io
> Cc: linux@analog.com
> ---
>  arch/x86/cpu/broadwell/sdram.c             | 2 +-
>  arch/x86/cpu/ivybridge/early_me.c          | 2 +-
>  board/liebherr/btt/btt.c                   | 2 +-
>  board/liebherr/xea/xea.c                   | 2 +-
>  drivers/block/efi_blk.c                    | 2 +-
>  drivers/clk/at91/compat.c                  | 4 ++--
>  drivers/clk/at91/sckc.c                    | 2 +-
>  drivers/clk/meson/a1.c                     | 2 +-
>  drivers/clk/meson/gxbb.c                   | 2 +-
>  drivers/clk/nuvoton/clk_npcm7xx.c          | 2 +-
>  drivers/clk/nuvoton/clk_npcm8xx.c          | 2 +-
>  drivers/clk/stm32/clk-stm32mp13.c          | 2 +-
>  drivers/dma/ti/k3-udma.c                   | 2 +-
>  drivers/i2c/tegra186_bpmp_i2c.c            | 2 +-
>  drivers/mmc/bcm2835_sdhci.c                | 2 +-
>  drivers/mmc/fsl_esdhc_imx.c                | 2 +-
>  drivers/mmc/rockchip_sdhci.c               | 2 +-
>  drivers/net/calxedaxgmac.c                 | 2 +-
>  drivers/net/dwc_eth_xgmac.c                | 2 +-
>  drivers/net/qe/dm_qe_uec_phy.c             | 2 +-
>  drivers/net/sni_netsec.c                   | 2 +-
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c | 2 +-
>  drivers/pinctrl/tegra/pinctrl-tegra20.c    | 4 ++--
>  drivers/reset/stm32/stm32-reset-mp1.c      | 2 +-
>  drivers/spi/kirkwood_spi.c                 | 4 ++--
>  drivers/spi/mvebu_a3700_spi.c              | 4 ++--
>  drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>  drivers/usb/dwc3/dwc3-meson-g12a.c         | 2 +-
>  drivers/usb/dwc3/dwc3-meson-gxl.c          | 2 +-
>  drivers/usb/host/ehci-exynos.c             | 2 +-
>  drivers/usb/host/ehci-msm.c                | 2 +-
>  drivers/usb/host/ehci-tegra.c              | 2 +-
>  drivers/usb/host/ehci-vf.c                 | 2 +-
>  drivers/usb/host/ohci-da8xx.c              | 2 +-
>  drivers/usb/musb-new/pic32.c               | 2 +-
>  drivers/usb/musb-new/sc5xx.c               | 2 +-
>  drivers/usb/musb-new/sunxi.c               | 2 +-
>  drivers/video/rockchip/rk3288_mipi.c       | 4 ++--
>  drivers/video/rockchip/rk3399_mipi.c       | 4 ++--
>  drivers/watchdog/arm_smc_wdt.c             | 2 +-
>  40 files changed, 46 insertions(+), 46 deletions(-)
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra
