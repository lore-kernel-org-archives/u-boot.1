Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5FDC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB1882ED0;
	Mon,  7 Apr 2025 17:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="eHuES8sQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E526382ED4; Mon,  7 Apr 2025 17:09:48 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68E282CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+7xQkFn4IAf2Np3X+XHbQDTT7IT7uFOodhu9WtEuVTU=; b=eHuES8sQ3Lyf1EEeaEbn36J98B
 t03X/sjIIIA7KdstoBZvBPhgfpJn4ZjpTGhjXtCqz4rr4/2sIHzUXMlJ5Jg7+TOdmn1UOqetnhknK
 43W90fddbKD0Jkeyz6mb07+je09n0xmP9qe910KQEioIWOHq6Cwlp1foyv3pZ/8VjnA01jdNNc6r9
 1J9KAizCXdUtOh406/ZFOilV7WBZOK7YxMkw2gt2WOj/VrFl6VB4Zr4c4w7PbKPO+32XlqpR0oX4H
 HRFMm5SULflctNQkmr3mKk7zKQxRykuun3wXtn/9h0slx8v4f9RSuINejkSfk+iAMro6ah15u3Ep/
 W+QiPbMA==;
Received: from i53875b95.versanet.de ([83.135.91.149] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u1o6O-0004uR-Cv; Mon, 07 Apr 2025 17:09:32 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: sjg@chromium.org, philipp.tomsich@vrull.eu,
 Kever Yang <kever.yang@rock-chips.com>
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: Re: [PATCH 00/20] Support for the RK3576
Date: Mon, 07 Apr 2025 17:09:31 +0200
Message-ID: <2220773.irdbgypaU6@diego>
In-Reply-To: <1580874a-e1b8-4c0b-a897-2f672e96b248@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <1580874a-e1b8-4c0b-a897-2f672e96b248@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Kever,

Am Sonntag, 6. April 2025, 17:09:59 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Kever Yang:
> Hi Heiko,
>=20
>      Do you have new version for this patch set?

with 6.15-tc1 the devicetree for my Firefly board now also made it to the
dt-rebasing repository, where I can cherry-pick it from for u-boot.

So yes, I'll try to come forward with an updated version hopefully
this week.


Heiko


> On 2024/11/21 22:27, Heiko Stuebner wrote:
> > This adds support for the RK3576 SoC from Rockchip.
> >
> > Currently supported (and tested) features are accessing and reading from
> > sdhci and sdmmc devices as well as pxe-booting via the network interfac=
e.
> >
> > As can be seen by the DONOTMERGE labels, this needs to wait a bit still.
> >
> > The core RK3576 devicetrees will be part of 6.13-rc1, but the Firefly
> > board I only submitted last week, so this would only appear in 6.14-rc1=
 .
> >
> > If someone from Collabora could provide a board patch for the ArmSom
> > board they are working with, this would speed things up a bit ;-) .
> >
> > Checkpatch seems mostly happy too.
> >
> >
> > Detlev Casanova (3):
> >    dt-bindings: clock, reset: Add support for rk3576
> >    DONOTMERGE: arm64: dts: rockchip: Add rk3576 SoC base DT
> >    arm: rockchip: add RK3576-specific syscon ids
> >
> > Elaine Zhang (2):
> >    clk: rockchip: Add rk3576 clk support
> >    reset: rockchip: implement rk3576 lookup table
> >
> > Finley Xiao (1):
> >    dt-bindings: power: Add support for RK3576 SoC
> >
> > Heiko Stuebner (11):
> >    dt-bindings: clock, reset: fix top-comment indentation rk3576 headers
> >    DONOTMERGE: arm64: dts: rockchip: add rk3576 otp node
> >    DONOTMERGE: dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC
> >      binding
> >    DONOTMERGE: arm64: dts: rockchip: Add devicetree for the ROC-RK3576-=
PC
> >    rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regions
> >    ram: rockchip: Add rk3576 ddr driver support
> >    rockchip: otp: Add support for RK3576
> >    mmc: rockchip_sdhci: Add support for RK3576
> >    mmc: rockchip_dw_mmc: Add support for rk3576
> >    net: dwc_eth_qos_rockchip: Add support for RK3576
> >    rockchip: rk3576: Add support for ROC-RK3576-PC board
> >
> > Steven Liu (1):
> >    pinctrl: rockchip: support rk3576 pinctrl
> >
> > Xuhui Lin (2):
> >    rockchip: mkimage: Add rk3576 support
> >    arm: rockchip: Add RK3576 arch core support
> >
> >   arch/arm/dts/rk3576-roc-pc-u-boot.dtsi        |   12 +
> >   arch/arm/dts/rk3576-u-boot.dtsi               |  119 +
> >   arch/arm/include/asm/arch-rk3576/boot0.h      |   11 +
> >   arch/arm/include/asm/arch-rk3576/gpio.h       |   11 +
> >   arch/arm/include/asm/arch-rockchip/clock.h    |   12 +
> >   .../include/asm/arch-rockchip/cru_rk3576.h    |  486 ++
> >   .../include/asm/arch-rockchip/grf_rk3576.h    |  225 +
> >   .../include/asm/arch-rockchip/ioc_rk3576.h    |  244 +
> >   arch/arm/mach-rockchip/Kconfig                |   46 +-
> >   arch/arm/mach-rockchip/Makefile               |    1 +
> >   arch/arm/mach-rockchip/rk3576/Kconfig         |   57 +
> >   arch/arm/mach-rockchip/rk3576/Makefile        |    9 +
> >   arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |   32 +
> >   arch/arm/mach-rockchip/rk3576/rk3576.c        |  169 +
> >   arch/arm/mach-rockchip/rk3576/syscon_rk3576.c |   26 +
> >   arch/arm/mach-rockchip/sdram.c                |   11 +-
> >   board/firefly/roc-pc-rk3576/Kconfig           |   12 +
> >   board/firefly/roc-pc-rk3576/MAINTAINERS       |    7 +
> >   configs/roc-pc-rk3576_defconfig               |   77 +
> >   doc/board/rockchip/rockchip.rst               |   12 +
> >   drivers/clk/rockchip/Makefile                 |    1 +
> >   drivers/clk/rockchip/clk_rk3576.c             | 2517 +++++++
> >   drivers/misc/rockchip-otp.c                   |   11 +
> >   drivers/mmc/rockchip_dw_mmc.c                 |    1 +
> >   drivers/mmc/rockchip_sdhci.c                  |   12 +
> >   drivers/net/dwc_eth_qos.c                     |    4 +
> >   drivers/net/dwc_eth_qos_rockchip.c            |  141 +-
> >   drivers/pinctrl/rockchip/Makefile             |    1 +
> >   drivers/pinctrl/rockchip/pinctrl-rk3576.c     |  287 +
> >   drivers/pinctrl/rockchip/pinctrl-rockchip.h   |    3 +
> >   drivers/ram/rockchip/Makefile                 |    1 +
> >   drivers/ram/rockchip/sdram_rk3576.c           |   65 +
> >   drivers/reset/Makefile                        |    2 +-
> >   drivers/reset/rst-rk3576.c                    |  647 ++
> >   dts/upstream/Bindings/arm/rockchip.yaml       |    5 +
> >   .../Bindings/clock/rockchip,rk3576-cru.yaml   |   56 +
> >   .../power/rockchip,power-controller.yaml      |    1 +
> >   .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++
> >   .../dt-bindings/power/rockchip,rk3576-power.h |   30 +
> >   .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 ++
> >   .../src/arm64/rockchip/rk3576-pinctrl.dtsi    | 5775 +++++++++++++++++
> >   .../src/arm64/rockchip/rk3576-roc-pc.dts      |  736 +++
> >   dts/upstream/src/arm64/rockchip/rk3576.dtsi   | 1717 +++++
> >   include/configs/rk3576_common.h               |   42 +
> >   include/configs/roc-pc-rk3576.h               |   15 +
> >   tools/rkcommon.c                              |    1 +
> >   46 files changed, 14798 insertions(+), 8 deletions(-)
> >   create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/rk3576-u-boot.dtsi
> >   create mode 100644 arch/arm/include/asm/arch-rk3576/boot0.h
> >   create mode 100644 arch/arm/include/asm/arch-rk3576/gpio.h
> >   create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3576.h
> >   create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rk3576.h
> >   create mode 100644 arch/arm/include/asm/arch-rockchip/ioc_rk3576.h
> >   create mode 100644 arch/arm/mach-rockchip/rk3576/Kconfig
> >   create mode 100644 arch/arm/mach-rockchip/rk3576/Makefile
> >   create mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
> >   create mode 100644 arch/arm/mach-rockchip/rk3576/rk3576.c
> >   create mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
> >   create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
> >   create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
> >   create mode 100644 configs/roc-pc-rk3576_defconfig
> >   create mode 100644 drivers/clk/rockchip/clk_rk3576.c
> >   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3576.c
> >   create mode 100644 drivers/ram/rockchip/sdram_rk3576.c
> >   create mode 100644 drivers/reset/rst-rk3576.c
> >   create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3576-cru.ya=
ml
> >   create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk=
3576-cru.h
> >   create mode 100644 dts/upstream/include/dt-bindings/power/rockchip,rk=
3576-power.h
> >   create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk=
3576-cru.h
> >   create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-pinctrl.dtsi
> >   create mode 100644 dts/upstream/src/arm64/rockchip/rk3576-roc-pc.dts
> >   create mode 100644 dts/upstream/src/arm64/rockchip/rk3576.dtsi
> >   create mode 100644 include/configs/rk3576_common.h
> >   create mode 100644 include/configs/roc-pc-rk3576.h
> >
>=20




