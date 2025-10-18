Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F6CCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 21:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0B6836B4;
	Sat, 18 Oct 2025 23:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BW2zKE1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D19883768; Sat, 18 Oct 2025 16:04:25 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C535C83631
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 16:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-43f935f7d14so1156648b6e.3
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760796261; x=1761401061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wuAbPfZKcdHeCJ+R2lg8Vyr8AvZf5RRjqFEw3QtM6Hs=;
 b=BW2zKE1LJTaLx3ndKe4uBQYfKp5o/bwLWkUNCrCfSW0OwQaYoZlq4dFfyKTAWu5zT1
 LG990k3xuhAEfkWT9th0V6+3u4jMToQ3JG8U3qRZAEFlXs2gR5Zp8lmsw3vMJNyQfCqI
 +eBV9UqFNBJ4iCdKbKAkf03yF8fwWpP9ED25A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760796261; x=1761401061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuAbPfZKcdHeCJ+R2lg8Vyr8AvZf5RRjqFEw3QtM6Hs=;
 b=Xcg5ebefdESgUGGyHrVzYoC0KJT5GrJyOlkn0PKgpYH+lEo1gRfGheUvVjHoMLnCWi
 DI6p8PIM1TXL3Q3KIZlc9ZcQ+da7vIag5YqnzMY+q7QKYtkz8xbah/NGkUg8X8zESOaH
 +wZCSQebsZpu0dXrrfYFLVIbzlOK2JkkF6L9ZnHr5nRqTM/w1wHg/o9i/A5dNKslHdzF
 ILOk6m9dovhuuSGvZNV5FyDiT9W7ar2ky4V8/+9mFexlI06piddWn7DmdShPHazvnswp
 /A7JEFg6ItjSsrsAZ+7Dx8WkLZDHFQcQthuKj/qroMD9IrGcUTh62BRTcjUAax2lNrU3
 Cqcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ8kobjfC+3BVsmmQZXISwxZgSHc1OCFm20fVhu8OF1ePP027nq74xKrust6iD7NK7RB31km8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf4xmy1QCYeWILADJrroOTkz6k4i+K+N8zm8XVY1Ek7wK8zsIS
 wCoC+i5uvip4cb8d5aCUdgsNE5d2stCltU/rDEba7lTcxBM4RO6onrK0wKhfbS5VIQI=
X-Gm-Gg: ASbGncsFlUTtWz+bYGB6QqkrjNgdbGUF8IJ0TzPbGXYBjTTnvSN8ta58JTRT/qBG3JJ
 7ATx+ynI2LWKGXbTh6naG4+JNoL14C+Cm5iS/Ev5ZM9h11p1z0ndvI4B05p6ZXVY8rR0zTUG9Ms
 eyMi/3TcfRmtUupQhk5v/ura80omXv5MjKF4IzpF32sJ5cbvtjsl4Chl0incB2Zqo4IJBkyYNBG
 RnnKJVUr79u9/ECDIYRQFOwoChnlU2Hf129P4ctoqMoWIRd5tUGMOfj4kQ3dTMXqFsgQeup0tOs
 ELZE/EdRvb/OLsJdBpMEpn2XgxAv57HCzgWqHBRDZ7yw4McJ2zU4jl2e/nzUZqZEHaQ0pMyJqiB
 Z9CxFnJk7GeOxuF030fhslI0JFRQWs+f7ESwqsw4qYypa5ZURy+FOqauKy4bL3Dq6vywIXKZPmh
 sHTpWvMlBc6JAF1G4ivo5ik7VKf86zmoRY5vFLV50=
X-Google-Smtp-Source: AGHT+IGDFAnvW7ZjRMItT+YnltVJd/d4c1KbPS9EnXXz00WLnmPEfQ4m59x5GEtaMfHLyzXx7cfQKw==
X-Received: by 2002:a05:6808:4f50:b0:441:d679:efa1 with SMTP id
 5614622812f47-443a2fecd71mr2701484b6e.32.1760796261212; 
 Sat, 18 Oct 2025 07:04:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dc4d5460sm554862b6e.4.2025.10.18.07.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 07:04:19 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:04:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de, Paul Barker <paul@pbarker.dev>,
 uboot-snps-arc@synopsys.com, Dai Okamura <okamura.dai@socionext.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ye Li <ye.li@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
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
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 00/24] clk: Remove passing of negative errors through
 unsigned return
Message-ID: <20251018140414.GN6688@bill-the-cat>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <CAFLszTjnB5zji6JkCpKTHMRZYvcR9hS5rebxZ2_rHj77BWN2VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l8GSp1oDBcWYb4IP"
Content-Disposition: inline
In-Reply-To: <CAFLszTjnB5zji6JkCpKTHMRZYvcR9hS5rebxZ2_rHj77BWN2VQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 18 Oct 2025 23:27:21 +0200
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


--l8GSp1oDBcWYb4IP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 09:34:42AM +0100, Simon Glass wrote:
> Hi Andrew,
>=20
> On Wed, 15 Oct 2025 at 15:32, Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
> >
> > This series removes the passing of negative errors through the .get_rate
> > function in the clk_ops struct. This function returns an unsigned long.
> > The only value guaranteed to not be a valid clock rate is 0. This will
> > also bring the drivers more in sync with Linux to allow for easier code
> > porting and other maintenance in the future.
> > Another series will address the calling of clk_get_rate and associated
> > error handling.
>=20
> Some indication of the problem you ran into would be useful here.

The problem statement is in the paragraph you're quoting. The numerical
value of -ENOENT is a valid clock rate.

> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> > Andrew Goodbody (24):
> >       clk: meson: Remove negative error returns from clk_get_rate
> >       clk: sifive: Remove negative error returns from clk_get_rate
> >       clk: armada-37xx: Remove negative error returns from clk_get_rate
> >       clk: thead: th1520-ap: Remove negative error returns from clk_get=
_rate
> >       clk: ccf: Remove negative error returns from clk_get_rate
> >       clk: at91: Remove negative error returns from clk_get_rate
> >       clk: renesas: Remove negative error returns from clk_get_rate
> >       clk: rockchip: Remove negative error returns from clk_get_rate
> >       clk: Remove negative error returns from clk_get_rate
> >       clk: starfive: Remove negative error returns from clk_get_rate
> >       clk: altera: Remove negative error returns from clk_get_rate
> >       clk: uniphier: Remove negative error returns from clk_get_rate
> >       clk: aspeed: Remove negative error returns from clk_get_rate
> >       clk: nuvoton: Remove negative error returns from clk_get_rate
> >       clk: exynos: Remove negative error returns from clk_get_rate
> >       clk: imx: Remove negative error returns from clk_get_rate
> >       clk: ti: Remove negative error returns from clk_get_rate
> >       clk: mediatek: Remove negative error returns from clk_get_rate
> >       clk: owl: Remove negative error returns from clk_get_rate
> >       clk: tegra: Remove negative error returns from clk_get_rate
> >       clk: adi: Remove negative error returns from clk_get_rate
> >       clk: sophgo: Remove negative error returns from clk_get_rate
> >       clk: stm32: Remove negative error returns from clk_get_rate
> >       clk: x86: Remove negative error returns from clk_get_rate
> >
> >  drivers/clk/adi/clk-shared.c             |  2 +-
> >  drivers/clk/altera/clk-agilex.c          |  2 +-
> >  drivers/clk/altera/clk-agilex5.c         |  2 +-
> >  drivers/clk/altera/clk-n5x.c             |  2 +-
> >  drivers/clk/aspeed/clk_ast2500.c         |  2 +-
> >  drivers/clk/aspeed/clk_ast2600.c         |  2 +-
> >  drivers/clk/at91/compat.c                |  6 ++--
> >  drivers/clk/clk-hsdk-cgu.c               |  2 +-
> >  drivers/clk/clk-uclass.c                 |  4 +--
> >  drivers/clk/clk.c                        |  2 +-
> >  drivers/clk/clk_fixed_factor.c           |  4 +--
> >  drivers/clk/clk_k210.c                   |  6 ++--
> >  drivers/clk/clk_sandbox.c                |  4 +--
> >  drivers/clk/clk_scmi.c                   |  4 +--
> >  drivers/clk/clk_vexpress_osc.c           |  2 +-
> >  drivers/clk/clk_zynq.c                   |  4 +--
> >  drivers/clk/clk_zynqmp.c                 | 40 ++++++++++-----------
> >  drivers/clk/exynos/clk-exynos7420.c      |  2 +-
> >  drivers/clk/imx/clk-imx8qm.c             |  6 ++--
> >  drivers/clk/imx/clk-imx8qxp.c            |  6 ++--
> >  drivers/clk/imx/clk-imxrt1170.c          |  2 +-
> >  drivers/clk/imx/clk-pllv3.c              |  2 +-
> >  drivers/clk/intel/clk_intel.c            |  2 +-
> >  drivers/clk/mediatek/clk-mtk.c           |  2 +-
> >  drivers/clk/meson/a1.c                   | 10 +++---
> >  drivers/clk/meson/axg.c                  | 10 +++---
> >  drivers/clk/meson/g12a.c                 | 36 +++++++++----------
> >  drivers/clk/meson/gxbb.c                 | 20 +++++------
> >  drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
> >  drivers/clk/mvebu/armada-37xx-tbg.c      |  2 +-
> >  drivers/clk/nuvoton/clk_npcm.c           | 10 +++---
> >  drivers/clk/owl/clk_owl.c                |  2 +-
> >  drivers/clk/renesas/clk-rcar-gen2.c      |  8 ++---
> >  drivers/clk/renesas/rzg2l-cpg.c          |  8 ++---
> >  drivers/clk/rockchip/clk_px30.c          | 24 ++++++-------
> >  drivers/clk/rockchip/clk_rk3036.c        |  2 +-
> >  drivers/clk/rockchip/clk_rk3066.c        |  8 ++---
> >  drivers/clk/rockchip/clk_rk3128.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk3188.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk322x.c        |  4 +--
> >  drivers/clk/rockchip/clk_rk3288.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk3308.c        | 26 +++++++-------
> >  drivers/clk/rockchip/clk_rk3328.c        |  6 ++--
> >  drivers/clk/rockchip/clk_rk3368.c        |  8 ++---
> >  drivers/clk/rockchip/clk_rk3399.c        | 12 +++----
> >  drivers/clk/rockchip/clk_rk3528.c        | 20 +++++------
> >  drivers/clk/rockchip/clk_rk3568.c        | 62 ++++++++++++++++--------=
--------
> >  drivers/clk/rockchip/clk_rk3576.c        | 36 +++++++++----------
> >  drivers/clk/rockchip/clk_rk3588.c        | 32 ++++++++---------
> >  drivers/clk/rockchip/clk_rv1108.c        |  4 +--
> >  drivers/clk/rockchip/clk_rv1126.c        | 52 +++++++++++++-----------=
---
> >  drivers/clk/sifive/sifive-prci.c         |  8 ++---
> >  drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
> >  drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
> >  drivers/clk/stm32/clk-stm32-core.c       |  4 +--
> >  drivers/clk/stm32/clk-stm32f.c           |  6 ++--
> >  drivers/clk/stm32/clk-stm32h7.c          |  4 +--
> >  drivers/clk/tegra/tegra-car-clk.c        |  2 +-
> >  drivers/clk/tegra/tegra186-clk.c         |  2 +-
> >  drivers/clk/thead/clk-th1520-ap.c        |  2 +-
> >  drivers/clk/ti/clk-am3-dpll-x2.c         |  4 +--
> >  drivers/clk/ti/clk-divider.c             |  4 +--
> >  drivers/clk/ti/clk-mux.c                 |  2 +-
> >  drivers/clk/ti/clk-sci.c                 |  2 +-
> >  drivers/clk/uniphier/clk-uniphier-core.c |  2 +-
> >  65 files changed, 290 insertions(+), 290 deletions(-)
> > ---
> > base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
> > change-id: 20251010-clk_ops-3b7cc9ccd070
> >
> > Best regards,
> > --
> > Andrew Goodbody <andrew.goodbody@linaro.org>
> >
>=20
> If you don't return an error, we cannot tell if the operation
> succeeded, or not. U-Boot needs to be deterministic and we need to be
> able to debug errors and detect them at runtime.
>=20
> We use ulong for the return value as a bit of a compromise, since it
> is inefficient to use 64-bit on a 32-bit machine. Ideally it would be
> long, but some clock rates are 3GHz and it would be confusing to cast
> to ulong before using the value.
>=20
> An alternative we discussed was to return an integer error with the
> clock rate returned in a parameter, but that seemed less efficient.
>=20
> With 64-bit machines, there really isn't a problem. Just checking for
> a negative value is good enough, since the clock rate isn't going to
> be 9 exahertz(?). Values between -CONFIG_ERR_PTR_OFFSET and 0 are
> errors and are defined to be so.
>=20
> If you want clk_get_rate() to work like Linux (suppress / ignore
> errors?), that's fine, but please create a clk_get_rate_err() (or
> similar) which actually returns the correct error, and keep the error
> return on the uclass interface. It is not uncommon to have the uclass
> do some processing on values passed to/from driver. This allows people
> who care to obtain the error.

This is moving things in the right direction of having the error
reporting and handling done where it can be done correctly. If there's
further parts of the Linux kernel-like API we need, we can take those
next.

--=20
Tom

--l8GSp1oDBcWYb4IP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPOeWgAKCRAr4qD1Cr/k
ChTiAP9bd9AcnF9YQPEbhXRUDcVTsqeEjIS15V3Bf0DUt+edXgEAxdcXEmTx0HeV
5KJkZx1hXeGto6NJRTJUtcv/Yan48A0=
=I5dp
-----END PGP SIGNATURE-----

--l8GSp1oDBcWYb4IP--
