Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50D2D47CC3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F148309A;
	Fri, 16 Jan 2026 11:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uoa+7feM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A77C830E4; Fri, 16 Jan 2026 11:10:11 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15C382BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B7ED040779;
 Fri, 16 Jan 2026 10:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C8EC116C6;
 Fri, 16 Jan 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768558206;
 bh=s8pTgPsHbl+GKhMdOue+O55ryrIauU/kYQGshI4MmIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uoa+7feMy9H0rdBB5BwrDlTGgSQLxGC71YGx0F1257+WWJU2Jut0u5f0nKy/IIFky
 9+/DpjZYr4WP5fCaW6nHYipZIk5lItspMFtw9fsCaY3Ls80wl1rvCGltFu2UZMsaY7
 U2Sq0itMAqNZY2JLb40KOt4g515lPzdJSEWrmWykM3LxMPW5JNw/gckbh0Fr7HWCiN
 jST1nRdLpQ4w7kK5+eueM1ENF5V5NCEYyVkBQv4CWxC/BxoojB2EEtR8g3fiR68TOa
 mS7AnJZGleYicrXIkMk28DIimbfL2vKtSW5hOAerGqCpK/G+7u5QpqOenLroU0DNwn
 SBRS2Hn9uh0JA==
Date: Fri, 16 Jan 2026 15:39:58 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com,
 w.egorov@phytec.de, jonas@kwiboo.se, michael@amarulasolutions.com
Subject: Re: [PATCH v2 0/6] rockchip: use OF_UPSTREAM for rk3288
Message-ID: <aWoOdgirPwHHMJwg@sumit-xelite>
References: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
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

On Sun, Jan 11, 2026 at 05:27:03PM +0100, Johan Jonker wrote:
> The device tree for rk3288 combined is now
> available in the /dts/upstream directory.
> Use imply OF_UPSTREAM to migrate all rk3288 boards.
> Clean up MAINTAINERS.
> 
> Changed V2:
> Rebase
> Moved upstream changes to separate patches
> Split in smaller pieces
> 
> Johan Jonker (6):
>   ARM: dts: rockchip: Remove mshc aliases from RK3288
>   ARM: dts: rockchip: Add spi_flash label to rk3288-veyron
>   ARM: dts: rockchip: move edp assigned-clocks to edp node on rk3288
>   rockchip: Switch rk3288-veyron boards to upstream devicetree
>   rockchip: Switch remaining rk3288 boards to upstream devicetree
>   rockchip: imply OF_UPSTREAM for rk3288 boards

Glad to see the diffstat, fwiw:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
>  arch/arm/dts/cros-ec-sbs.dtsi                 |  52 --
>  ...boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} |   0
>  arch/arm/dts/rk3288-evb.dts                   |  20 -
>  arch/arm/dts/rk3288-evb.dtsi                  | 476 -----------
>  arch/arm/dts/rk3288-popmetal.dts              |  20 -
>  arch/arm/dts/rk3288-popmetal.dtsi             | 547 ------------
>  arch/arm/dts/rk3288-rock-pi-n8.dts            |  17 -
>  arch/arm/dts/rk3288-rock2-som.dtsi            | 278 ------
>  arch/arm/dts/rk3288-rock2-square.dts          | 181 ----
>  arch/arm/dts/rk3288-veyron-chromebook.dtsi    | 205 -----
>  arch/arm/dts/rk3288-veyron-jerry.dts          | 208 -----
>  arch/arm/dts/rk3288-veyron-mickey.dts         | 266 ------
>  arch/arm/dts/rk3288-veyron-minnie.dts         | 302 -------
>  arch/arm/dts/rk3288-veyron-speedy.dts         | 143 ----
>  arch/arm/dts/rk3288-veyron.dtsi               | 795 ------------------
>  arch/arm/dts/rk3288-vmarc-som.dtsi            | 361 --------
>  arch/arm/dts/rk3288-vyasa.dts                 | 473 -----------
>  .../dts/rockchip-radxa-dalang-carrier.dtsi    | 137 ---
>  arch/arm/mach-rockchip/Kconfig                |   1 +
>  board/amarula/vyasa-rk3288/MAINTAINERS        |   1 -
>  board/chipspark/popmetal_rk3288/MAINTAINERS   |   1 -
>  board/google/veyron/MAINTAINERS               |  10 +-
>  board/radxa/rock2/MAINTAINERS                 |   1 -
>  board/rockchip/evb_rk3288/MAINTAINERS         |   6 +-
>  configs/chromebit_mickey_defconfig            |   4 +-
>  configs/chromebook_jerry_defconfig            |   4 +-
>  configs/chromebook_minnie_defconfig           |   4 +-
>  configs/chromebook_speedy_defconfig           |   4 +-
>  ...8_defconfig => evb-rk3288-rk808_defconfig} |   4 +-
>  configs/firefly-rk3288_defconfig              |   1 -
>  configs/miqi-rk3288_defconfig                 |   1 -
>  configs/phycore-rk3288_defconfig              |   3 +-
>  configs/popmetal-rk3288_defconfig             |   4 +-
>  configs/rock-pi-n8-rk3288_defconfig           |   2 +-
>  configs/rock2_defconfig                       |   4 +-
>  configs/tinker-rk3288_defconfig               |   1 -
>  configs/tinker-s-rk3288_defconfig             |   1 -
>  configs/vyasa-rk3288_defconfig                |   4 +-
>  doc/board/rockchip/rockchip.rst               |   8 +-
>  .../src/arm/rockchip/rk3288-veyron.dtsi       |   2 +-
>  dts/upstream/src/arm/rockchip/rk3288.dtsi     |   9 +-
>  41 files changed, 30 insertions(+), 4531 deletions(-)
>  delete mode 100644 arch/arm/dts/cros-ec-sbs.dtsi
>  rename arch/arm/dts/{rk3288-evb-u-boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} (100%)
>  delete mode 100644 arch/arm/dts/rk3288-evb.dts
>  delete mode 100644 arch/arm/dts/rk3288-evb.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-popmetal.dts
>  delete mode 100644 arch/arm/dts/rk3288-popmetal.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-rock-pi-n8.dts
>  delete mode 100644 arch/arm/dts/rk3288-rock2-som.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-rock2-square.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-chromebook.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-veyron-jerry.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-mickey.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-minnie.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron-speedy.dts
>  delete mode 100644 arch/arm/dts/rk3288-veyron.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-vmarc-som.dtsi
>  delete mode 100644 arch/arm/dts/rk3288-vyasa.dts
>  delete mode 100644 arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
>  rename configs/{evb-rk3288_defconfig => evb-rk3288-rk808_defconfig} (95%)
> 
> --
> 2.39.5
> 
