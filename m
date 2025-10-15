Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D638CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8653483303;
	Wed, 15 Oct 2025 17:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mG7aDKk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDCA835B0; Wed, 15 Oct 2025 16:32:24 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5A08313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4710022571cso6272825e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538741; x=1761143541; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5G/pzUDmAWP39RNeIkhwHh1OMLzLKAP5G+xfsbBMiU=;
 b=mG7aDKk5NUgqy089hF+welTW+1oGiVx+MBFsFyjSJRMzr2KNYxtpkvojxad7zfMViO
 Xa50wHB9Xik+mD604CuNYua8Apd14PizF1WQKtPVLylj//P2t69weKXHhg66u25AoGmu
 Djkm/RqdVMW67FzpTgWvM+1uEXcS6qQCpnY3fH/8V2dDfw3Lj2Me9z32TSeQ5Q/O+DtP
 YpGXoDD35e6rkSp+o2xjmHEwVgEEo5LrcnDw0aVpcgaHUOzIOxF0Fm8rgVjoQ5KALNtZ
 Tq2SBSFpUmVtrm4KU9xLD7wwKMRjmam2JMAvKdn+gMUUbJxuHd08w84WbAQcjbZkQ6Cp
 4Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538741; x=1761143541;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5G/pzUDmAWP39RNeIkhwHh1OMLzLKAP5G+xfsbBMiU=;
 b=aS4+0H8lw1m2qKOK1i3C2YhtCJjx4sgJStbZrCVV1wwf7Xjw4IsPAGE9osJ/wOanyE
 Re8TnXhcJx1BBmALhTzZTkfcnnBYE+MKIM8cQJwH9Fgws+Sga42MLreWO/7IKwozVmh7
 xk2QZLDoYlN6aFYbMWXtgAQsYpb04RPQMm2W0X2V6Am6r9i3tJYetpFt9hy47UUX9plN
 0/ptM8iZH/0KWaX2IMzSS1PCg9twqyLYX34k/JTNsEUQkDvK/gpYUjoHWKcI6yhgd0Em
 GIao4reRxwWS/EQWdjuAi9McpnIE/tWNA3h43VMYOF9j8aGnqxogsggv4GNu7d+6puZz
 AKTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrb0CH1AnkakskSYTTsImOuM0DdDPT8Glvw60yGoOCkqESt/HoWLFUuJoXt+9YpfM+Vjax800=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9y0pELLTgNal6Uze6zLb/ohd4ZRVbsu4OXQ3ub3GqK0m/DGCr
 Gj7VMugvmgGMteWivsb1kF0HVWDEuVtlCBQc+o3hldLa8qt0z+rA1BJqGoPwqUaQ42g=
X-Gm-Gg: ASbGncsWQhaMY4Hq8DC7WzZUulpMS5mzX5jij2/byp62DIfGQx2jUvoeOxC3V3cf9Ma
 vV1Jwy4fYJJVvAYfJlMa3QdHAV61xgJhPc5K6EMSvcbeaJRrRDDgYAm+mmtO6XIsSbi6A9QEcxb
 YrmxkU088rvaaS1GhtlTQEhcmZLPln/81cMblI1UInEmEIYYnIKN6zQzr8WtlS/FA3ga0u0r2jp
 tHyK+7/ckK7ZrcX1z+mUnoShIOng+tz96wyqnYE2uj7rQdz3lmTCxWCzP3j8xgC5WY2eraIaCkB
 iYH6YqeudGzv+qIOmv/QsTSWzuc/ANFeGsbehUH/MZeHtbBXyMTbxeJHxiF2uoxqQ0YXXhSXjGz
 ozGil3sDlrBQFnhRqoY6QiRp8PxULyFhRAlrjRPlLhC5E40UtxHzhoq4FXvVvs7AlOoNci9rj0Q
 ==
X-Google-Smtp-Source: AGHT+IGpoVfGLE6ayqDBinGSA8T0Qgz6rCdE95D3/d6SX1NXBSxgZaQBiBLkHjt9eoMpy6vxWPuThg==
X-Received: by 2002:a05:600c:5490:b0:46e:4744:add7 with SMTP id
 5b1f17b1804b1-46fae33db7amr213440255e9.7.1760538741374; 
 Wed, 15 Oct 2025 07:32:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:20 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 00/24] clk: Remove passing of negative errors through
 unsigned return
Date: Wed, 15 Oct 2025 15:32:05 +0100
Message-Id: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWw72gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MD3eSc7Pj8gmJd4yTz5GTL5OQUA3MDJaDqgqLUtMwKsEnRsbW1AEt
 mhXtZAAAA
X-Change-ID: 20251010-clk_ops-3b7cc9ccd070
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
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
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 15 Oct 2025 17:55:48 +0200
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

This series removes the passing of negative errors through the .get_rate
function in the clk_ops struct. This function returns an unsigned long.
The only value guaranteed to not be a valid clock rate is 0. This will
also bring the drivers more in sync with Linux to allow for easier code
porting and other maintenance in the future.
Another series will address the calling of clk_get_rate and associated
error handling.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (24):
      clk: meson: Remove negative error returns from clk_get_rate
      clk: sifive: Remove negative error returns from clk_get_rate
      clk: armada-37xx: Remove negative error returns from clk_get_rate
      clk: thead: th1520-ap: Remove negative error returns from clk_get_rate
      clk: ccf: Remove negative error returns from clk_get_rate
      clk: at91: Remove negative error returns from clk_get_rate
      clk: renesas: Remove negative error returns from clk_get_rate
      clk: rockchip: Remove negative error returns from clk_get_rate
      clk: Remove negative error returns from clk_get_rate
      clk: starfive: Remove negative error returns from clk_get_rate
      clk: altera: Remove negative error returns from clk_get_rate
      clk: uniphier: Remove negative error returns from clk_get_rate
      clk: aspeed: Remove negative error returns from clk_get_rate
      clk: nuvoton: Remove negative error returns from clk_get_rate
      clk: exynos: Remove negative error returns from clk_get_rate
      clk: imx: Remove negative error returns from clk_get_rate
      clk: ti: Remove negative error returns from clk_get_rate
      clk: mediatek: Remove negative error returns from clk_get_rate
      clk: owl: Remove negative error returns from clk_get_rate
      clk: tegra: Remove negative error returns from clk_get_rate
      clk: adi: Remove negative error returns from clk_get_rate
      clk: sophgo: Remove negative error returns from clk_get_rate
      clk: stm32: Remove negative error returns from clk_get_rate
      clk: x86: Remove negative error returns from clk_get_rate

 drivers/clk/adi/clk-shared.c             |  2 +-
 drivers/clk/altera/clk-agilex.c          |  2 +-
 drivers/clk/altera/clk-agilex5.c         |  2 +-
 drivers/clk/altera/clk-n5x.c             |  2 +-
 drivers/clk/aspeed/clk_ast2500.c         |  2 +-
 drivers/clk/aspeed/clk_ast2600.c         |  2 +-
 drivers/clk/at91/compat.c                |  6 ++--
 drivers/clk/clk-hsdk-cgu.c               |  2 +-
 drivers/clk/clk-uclass.c                 |  4 +--
 drivers/clk/clk.c                        |  2 +-
 drivers/clk/clk_fixed_factor.c           |  4 +--
 drivers/clk/clk_k210.c                   |  6 ++--
 drivers/clk/clk_sandbox.c                |  4 +--
 drivers/clk/clk_scmi.c                   |  4 +--
 drivers/clk/clk_vexpress_osc.c           |  2 +-
 drivers/clk/clk_zynq.c                   |  4 +--
 drivers/clk/clk_zynqmp.c                 | 40 ++++++++++-----------
 drivers/clk/exynos/clk-exynos7420.c      |  2 +-
 drivers/clk/imx/clk-imx8qm.c             |  6 ++--
 drivers/clk/imx/clk-imx8qxp.c            |  6 ++--
 drivers/clk/imx/clk-imxrt1170.c          |  2 +-
 drivers/clk/imx/clk-pllv3.c              |  2 +-
 drivers/clk/intel/clk_intel.c            |  2 +-
 drivers/clk/mediatek/clk-mtk.c           |  2 +-
 drivers/clk/meson/a1.c                   | 10 +++---
 drivers/clk/meson/axg.c                  | 10 +++---
 drivers/clk/meson/g12a.c                 | 36 +++++++++----------
 drivers/clk/meson/gxbb.c                 | 20 +++++------
 drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
 drivers/clk/mvebu/armada-37xx-tbg.c      |  2 +-
 drivers/clk/nuvoton/clk_npcm.c           | 10 +++---
 drivers/clk/owl/clk_owl.c                |  2 +-
 drivers/clk/renesas/clk-rcar-gen2.c      |  8 ++---
 drivers/clk/renesas/rzg2l-cpg.c          |  8 ++---
 drivers/clk/rockchip/clk_px30.c          | 24 ++++++-------
 drivers/clk/rockchip/clk_rk3036.c        |  2 +-
 drivers/clk/rockchip/clk_rk3066.c        |  8 ++---
 drivers/clk/rockchip/clk_rk3128.c        |  6 ++--
 drivers/clk/rockchip/clk_rk3188.c        |  6 ++--
 drivers/clk/rockchip/clk_rk322x.c        |  4 +--
 drivers/clk/rockchip/clk_rk3288.c        |  6 ++--
 drivers/clk/rockchip/clk_rk3308.c        | 26 +++++++-------
 drivers/clk/rockchip/clk_rk3328.c        |  6 ++--
 drivers/clk/rockchip/clk_rk3368.c        |  8 ++---
 drivers/clk/rockchip/clk_rk3399.c        | 12 +++----
 drivers/clk/rockchip/clk_rk3528.c        | 20 +++++------
 drivers/clk/rockchip/clk_rk3568.c        | 62 ++++++++++++++++----------------
 drivers/clk/rockchip/clk_rk3576.c        | 36 +++++++++----------
 drivers/clk/rockchip/clk_rk3588.c        | 32 ++++++++---------
 drivers/clk/rockchip/clk_rv1108.c        |  4 +--
 drivers/clk/rockchip/clk_rv1126.c        | 52 +++++++++++++--------------
 drivers/clk/sifive/sifive-prci.c         |  8 ++---
 drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
 drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
 drivers/clk/stm32/clk-stm32-core.c       |  4 +--
 drivers/clk/stm32/clk-stm32f.c           |  6 ++--
 drivers/clk/stm32/clk-stm32h7.c          |  4 +--
 drivers/clk/tegra/tegra-car-clk.c        |  2 +-
 drivers/clk/tegra/tegra186-clk.c         |  2 +-
 drivers/clk/thead/clk-th1520-ap.c        |  2 +-
 drivers/clk/ti/clk-am3-dpll-x2.c         |  4 +--
 drivers/clk/ti/clk-divider.c             |  4 +--
 drivers/clk/ti/clk-mux.c                 |  2 +-
 drivers/clk/ti/clk-sci.c                 |  2 +-
 drivers/clk/uniphier/clk-uniphier-core.c |  2 +-
 65 files changed, 290 insertions(+), 290 deletions(-)
---
base-commit: ecdc3872a767fb045be3296d4317ae978a14b022
change-id: 20251010-clk_ops-3b7cc9ccd070

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

