Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4F7CCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 13:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8558C83804;
	Sat, 18 Oct 2025 15:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BQeuM6Vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B11083796; Sat, 18 Oct 2025 10:34:58 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3A6836D1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 10:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-63bad3cd668so5118291a12.3
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760776495; x=1761381295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TN8v39CEynpSs/RWE9EK++GbCKZy07kiS6n5uZksZs=;
 b=BQeuM6VqDfX6dlB+IZ5STdKS4LfWV2ltLvL+ncg7C4mrSVoHZBLty/QijbV2EBWx3g
 IQeDy+0Qd7RgykWB2MIPaBNjWHzQKFOioXEapKULUGouPgtsk9KhRWTKrGSUOx1vJ6TZ
 nObdwFiKNkLL2SQEKkoVftxmn7Pb/nA+F46Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760776495; x=1761381295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TN8v39CEynpSs/RWE9EK++GbCKZy07kiS6n5uZksZs=;
 b=LlKbbYvBWiUDMZd5ODXygeL4Af8MolNLaL0ld/uhe1t8uqKFa68/TK8+Peh30+AY7V
 oi5K5nUcaOyp79ePkQ3UlrGBtKgPUjabt8ZJ+EYO5hT/eoG6SnchZcq9Bt5mmAtIcQF3
 Sq3jAzrqJCymBMUZA5PqwOr6UBPxEncVFxvWjNmLxdsJZOc4JKtJFCz2aFNLbtX2wAFi
 YntetNVv6/4xn0BO/i0lnI/cY2XmukAlOgQWAFG72Q0oX7bcAfaqZalIjeulsPfT1ht1
 FUNNtoAg/zrUkCkY9fjJgQPKMOT2gPMu8YAwWVs9BHZLDlOZWsoFVyx68bB1n0D1Bv2z
 MzCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsLu0+vsvN4WPLl6dfAewnMotlkRHyMumLqqIyLujL3uQtbwiQu09ymQxZrrgiXaCjG355NTY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxwobv+rEFhRtZ0AKkTWDvA3SZt5Q6b4dd9fAGOTIkt+Bic9a2K
 b9aWWetRI8S7o5nNI4dq8+ES0IdkB9w7wlmOH0zLVAYIXNpeGQxJad2W/G651sgH92CKD+3BDHW
 L70ryCiaxf7bTbD6XmtAVi7QxMIG4Wwkl13EnQeiA
X-Gm-Gg: ASbGncuVKrk5eT+SmTK2OX8a5iLIq26+WG7XOxGPyop5ePtWTWdw8fO1g6tGxcb0CEi
 2VVnItpo5JXuWu2aHC76CgyI8/XtMwqd6FjCm8/IslUrdasiT0IwoYkVd1a/JbIb5vHAiz3ur3f
 /rvrKSCD4o8p6XlQJR86hXh6J9fjW430UNCpWKhv97ndGq9V5vKCz2czA1MD1ueBvtG/KfwL3B9
 qd3EG9Uwo8g5Qbdbvnc/oij4QZvVP9y46YihWlG0wuvd1Hcd5Hx1CgJqxFOpdG8h+Izfhg=
X-Google-Smtp-Source: AGHT+IEf23NULiuEGhtcXMtzNBMWc1d84uqfm3ZdB4X16YC7xYdHfBCBwbKFKif0s2eGpp3LILi6dEHZ238jYHmtZro=
X-Received: by 2002:a05:6402:2551:b0:63c:295a:d516 with SMTP id
 4fb4d7f45d1cf-63c295ad6f1mr5158309a12.27.1760776494770; Sat, 18 Oct 2025
 01:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Oct 2025 09:34:42 +0100
X-Gm-Features: AS18NWCEjgecNko4UjK5__lepbWi8gcDzElH8_F1VwD5CWAa6U0WFzGQfP0xzNQ
Message-ID: <CAFLszTjnB5zji6JkCpKTHMRZYvcR9hS5rebxZ2_rHj77BWN2VQ@mail.gmail.com>
Subject: Re: [PATCH 00/24] clk: Remove passing of negative errors through
 unsigned return
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 adsp-linux@analog.com, 
 uboot-stm32@st-md-mailman.stormreply.com, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Yao Zi <ziyao@disroot.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Heiko Schocher <hs@nabladev.com>, Jonathan Currier <dullfire@yahoo.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 18 Oct 2025 15:53:45 +0200
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

Hi Andrew,

On Wed, 15 Oct 2025 at 15:32, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> This series removes the passing of negative errors through the .get_rate
> function in the clk_ops struct. This function returns an unsigned long.
> The only value guaranteed to not be a valid clock rate is 0. This will
> also bring the drivers more in sync with Linux to allow for easier code
> porting and other maintenance in the future.
> Another series will address the calling of clk_get_rate and associated
> error handling.

Some indication of the problem you ran into would be useful here.

>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (24):
>       clk: meson: Remove negative error returns from clk_get_rate
>       clk: sifive: Remove negative error returns from clk_get_rate
>       clk: armada-37xx: Remove negative error returns from clk_get_rate
>       clk: thead: th1520-ap: Remove negative error returns from clk_get_rate
>       clk: ccf: Remove negative error returns from clk_get_rate
>       clk: at91: Remove negative error returns from clk_get_rate
>       clk: renesas: Remove negative error returns from clk_get_rate
>       clk: rockchip: Remove negative error returns from clk_get_rate
>       clk: Remove negative error returns from clk_get_rate
>       clk: starfive: Remove negative error returns from clk_get_rate
>       clk: altera: Remove negative error returns from clk_get_rate
>       clk: uniphier: Remove negative error returns from clk_get_rate
>       clk: aspeed: Remove negative error returns from clk_get_rate
>       clk: nuvoton: Remove negative error returns from clk_get_rate
>       clk: exynos: Remove negative error returns from clk_get_rate
>       clk: imx: Remove negative error returns from clk_get_rate
>       clk: ti: Remove negative error returns from clk_get_rate
>       clk: mediatek: Remove negative error returns from clk_get_rate
>       clk: owl: Remove negative error returns from clk_get_rate
>       clk: tegra: Remove negative error returns from clk_get_rate
>       clk: adi: Remove negative error returns from clk_get_rate
>       clk: sophgo: Remove negative error returns from clk_get_rate
>       clk: stm32: Remove negative error returns from clk_get_rate
>       clk: x86: Remove negative error returns from clk_get_rate
>
>  drivers/clk/adi/clk-shared.c             |  2 +-
>  drivers/clk/altera/clk-agilex.c          |  2 +-
>  drivers/clk/altera/clk-agilex5.c         |  2 +-
>  drivers/clk/altera/clk-n5x.c             |  2 +-
>  drivers/clk/aspeed/clk_ast2500.c         |  2 +-
>  drivers/clk/aspeed/clk_ast2600.c         |  2 +-
>  drivers/clk/at91/compat.c                |  6 ++--
>  drivers/clk/clk-hsdk-cgu.c               |  2 +-
>  drivers/clk/clk-uclass.c                 |  4 +--
>  drivers/clk/clk.c                        |  2 +-
>  drivers/clk/clk_fixed_factor.c           |  4 +--
>  drivers/clk/clk_k210.c                   |  6 ++--
>  drivers/clk/clk_sandbox.c                |  4 +--
>  drivers/clk/clk_scmi.c                   |  4 +--
>  drivers/clk/clk_vexpress_osc.c           |  2 +-
>  drivers/clk/clk_zynq.c                   |  4 +--
>  drivers/clk/clk_zynqmp.c                 | 40 ++++++++++-----------
>  drivers/clk/exynos/clk-exynos7420.c      |  2 +-
>  drivers/clk/imx/clk-imx8qm.c             |  6 ++--
>  drivers/clk/imx/clk-imx8qxp.c            |  6 ++--
>  drivers/clk/imx/clk-imxrt1170.c          |  2 +-
>  drivers/clk/imx/clk-pllv3.c              |  2 +-
>  drivers/clk/intel/clk_intel.c            |  2 +-
>  drivers/clk/mediatek/clk-mtk.c           |  2 +-
>  drivers/clk/meson/a1.c                   | 10 +++---
>  drivers/clk/meson/axg.c                  | 10 +++---
>  drivers/clk/meson/g12a.c                 | 36 +++++++++----------
>  drivers/clk/meson/gxbb.c                 | 20 +++++------
>  drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
>  drivers/clk/mvebu/armada-37xx-tbg.c      |  2 +-
>  drivers/clk/nuvoton/clk_npcm.c           | 10 +++---
>  drivers/clk/owl/clk_owl.c                |  2 +-
>  drivers/clk/renesas/clk-rcar-gen2.c      |  8 ++---
>  drivers/clk/renesas/rzg2l-cpg.c          |  8 ++---
>  drivers/clk/rockchip/clk_px30.c          | 24 ++++++-------
>  drivers/clk/rockchip/clk_rk3036.c        |  2 +-
>  drivers/clk/rockchip/clk_rk3066.c        |  8 ++---
>  drivers/clk/rockchip/clk_rk3128.c        |  6 ++--
>  drivers/clk/rockchip/clk_rk3188.c        |  6 ++--
>  drivers/clk/rockchip/clk_rk322x.c        |  4 +--
>  drivers/clk/rockchip/clk_rk3288.c        |  6 ++--
>  drivers/clk/rockchip/clk_rk3308.c        | 26 +++++++-------
>  drivers/clk/rockchip/clk_rk3328.c        |  6 ++--
>  drivers/clk/rockchip/clk_rk3368.c        |  8 ++---
>  drivers/clk/rockchip/clk_rk3399.c        | 12 +++----
>  drivers/clk/rockchip/clk_rk3528.c        | 20 +++++------
>  drivers/clk/rockchip/clk_rk3568.c        | 62 ++++++++++++++++----------------
>  drivers/clk/rockchip/clk_rk3576.c        | 36 +++++++++----------
>  drivers/clk/rockchip/clk_rk3588.c        | 32 ++++++++---------
>  drivers/clk/rockchip/clk_rv1108.c        |  4 +--
>  drivers/clk/rockchip/clk_rv1126.c        | 52 +++++++++++++--------------
>  drivers/clk/sifive/sifive-prci.c         |  8 ++---
>  drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
>  drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
>  drivers/clk/stm32/clk-stm32-core.c       |  4 +--
>  drivers/clk/stm32/clk-stm32f.c           |  6 ++--
>  drivers/clk/stm32/clk-stm32h7.c          |  4 +--
>  drivers/clk/tegra/tegra-car-clk.c        |  2 +-
>  drivers/clk/tegra/tegra186-clk.c         |  2 +-
>  drivers/clk/thead/clk-th1520-ap.c        |  2 +-
>  drivers/clk/ti/clk-am3-dpll-x2.c         |  4 +--
>  drivers/clk/ti/clk-divider.c             |  4 +--
>  drivers/clk/ti/clk-mux.c                 |  2 +-
>  drivers/clk/ti/clk-sci.c                 |  2 +-
>  drivers/clk/uniphier/clk-uniphier-core.c |  2 +-
>  65 files changed, 290 insertions(+), 290 deletions(-)
> ---
> base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
> change-id: 20251010-clk_ops-3b7cc9ccd070
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>

If you don't return an error, we cannot tell if the operation
succeeded, or not. U-Boot needs to be deterministic and we need to be
able to debug errors and detect them at runtime.

We use ulong for the return value as a bit of a compromise, since it
is inefficient to use 64-bit on a 32-bit machine. Ideally it would be
long, but some clock rates are 3GHz and it would be confusing to cast
to ulong before using the value.

An alternative we discussed was to return an integer error with the
clock rate returned in a parameter, but that seemed less efficient.

With 64-bit machines, there really isn't a problem. Just checking for
a negative value is good enough, since the clock rate isn't going to
be 9 exahertz(?). Values between -CONFIG_ERR_PTR_OFFSET and 0 are
errors and are defined to be so.

If you want clk_get_rate() to work like Linux (suppress / ignore
errors?), that's fine, but please create a clk_get_rate_err() (or
similar) which actually returns the correct error, and keep the error
return on the uclass interface. It is not uncommon to have the uclass
do some processing on values passed to/from driver. This allows people
who care to obtain the error.

Regards,
Simon
