Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61631CD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 20:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099C18832F;
	Mon,  1 Apr 2024 22:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bj6zVPUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E248803E; Mon,  1 Apr 2024 17:53:11 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D0B882FD
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 17:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431FqvcD002417;
 Mon, 1 Apr 2024 10:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711986777;
 bh=JI7CAFd3h2phfSIG2lFzqy+QSdK1NT9xo5mogbqydgc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bj6zVPUtXG+GM0Q+z+VxsKkXdw149jkyqtgRWL0F8j5rfk0uGFMFZ73pBmAkYCqFx
 obILuZpYljmrvPBWdS7c9nmkKJPSJ3jcqK7Adzgha9RWPQuRD19dq+CAwFD5/1gK+p
 JDVxc/Tgm/cRQKUDW1kXabx4sMdPb7EY+5S8PWDQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431FqvIP019021
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 10:52:57 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 10:52:56 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 10:52:56 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431FqubK048583;
 Mon, 1 Apr 2024 10:52:56 -0500
Date: Mon, 1 Apr 2024 10:52:56 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Apurva Nandan <a-nandan@ti.com>, Beniamino Galvani
 <b.galvani@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 aaba2d45dc2a..b35b9bd1d4ee
Message-ID: <20240401155256.hixw5xl2mvucdrml@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240329132249.4145432-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240329132249.4145432-1-trini@konsulko.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 01 Apr 2024 22:41:06 +0200
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

On March 29, 2024 thus sayeth Tom Rini:
> b35b9bd1d4ee Merge tag 'v6.8-dts-raw'
> 1f50937554b4 Merge tag 'sound-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 576ba37bcbf9 Merge tag 'net-6.8-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> c83dc02bae3e Merge tag 'qcom-arm64-fixes-for-6.8-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
> fb254675a395 ASoC: dt-bindings: nvidia: Fix 'lge' vendor prefix
> c748b8a7dbe8 Merge tag 'tegra-for-6.8-arm64-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into arm/fixes
> a2e893adde74 Merge tag 'imx-fixes-6.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
> abb0f1b369e4 Merge tag 'qcom-arm64-fixes-for-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
> f143aa9a89ec Revert "arm64: dts: qcom: msm8996: Hook up MPM"
> 9a5690b7be49 arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
> ca6dcb63bd34 arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
> 8532bb680bd0 dt-bindings: net: renesas,ethertsn: Document default for delays
> 42569705a4a0 Merge tag 'v6.8-rc6-dts-raw'
> 06c62487a0b4 arm64: dts: imx8mp: Fix LDB clocks property
> 7c93039778e4 arm64: dts: imx8mp: Fix TC9595 reset GPIO on DH i.MX8M Plus DHCOM SoM
> 7f9a36c5ce39 ARM: dts: imx7: remove DSI port endpoints
> 87ea8526eaf3 Merge tag 'loongarch-fixes-6.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> d4a4b892cd33 Merge tag 'arm-fixes-6.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 4faf103c7468 Merge tag 'renesas-fixes-for-v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes
> c1858748b935 Merge tag 'riscv-dt-fixes-for-v6.8-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
> f1bb487d660f LoongArch: dts: Minor whitespace cleanup
> b60485a78d66 Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> d641a222a5d4 arm64: tegra: Fix Tegra234 MGBE power-domains
> 31aeabc2669e ARM: dts: renesas: rcar-gen2: Add missing #interrupt-cells to DA9063 nodes
> 8c5d69d4f1e9 arm64: dts: qcom: Fix interrupt-map cell sizes
> 43b35c5b7347 arm: dts: Fix dtc interrupt_map warnings
> f00ce91341b9 arm64: dts: Fix dtc interrupt_provider warnings
> c21ad68d3254 arm: dts: Fix dtc interrupt_provider warnings
> 20a9f605f025 Merge tag 'v6.8-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
> 1d9be1dcae7c Merge tag 'imx-fixes-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
> c27426925b7b Merge tag 'v6.8-rc5-dts-raw'
> 582c3e28f603 Merge tag 'sound-6.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 81da29f3007e arm64: tegra: Set the correct PHY mode for MGBE
> 30e4bc5d76ff Merge tag 'devicetree-fixes-for-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> f0c34a9f448e riscv: dts: sifive: add missing #interrupt-cells to pmic
> db36be2a8839 arm64: dts: rockchip: Correct Indiedroid Nova GPIO Names
> ec7d411e57d6 arm64: dts: rockchip: Drop interrupts property from rk3328 pwm-rockchip node
> 105b1e4e5e28 arm64: dts: rockchip: set num-cs property for spi on px30
> a05f0ca9a008 arm64: dts: rockchip: minor rk3588 whitespace cleanup
> 41d6b3786aa9 riscv: dts: starfive: replace underscores in node names
> 910c8965eb0c dt-bindings: ufs: samsung,exynos-ufs: Add size constraints on "samsung,sysreg"
> d78e8a541b0a net: marvell,prestera: Fix example PCI bus addressing
> b40e56bea854 ASoC: dt-bindings: google,sc7280-herobrine: Drop bouncing @codeaurora
> 48b3246a26fe Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector"
> a1c414f8f89a Revert "arm64: dts: imx8mp-dhcom-pdk3: Describe the USB-C connector"
> 768ad06f1efa arm64: dts: tqma8mpql: fix audio codec iov-supply
> 77040f90f388 Merge tag 'v6.8-rc3-dts-raw'
> 65143ffc8608 arm64: dts: rockchip: drop unneeded status from rk3588-jaguar gpio-leds
> 39497955d1c0 ARM: dts: rockchip: Drop interrupts property from pwm-rockchip nodes
> 610e244453be arm64: dts: rockchip: Fix the num-lanes of pcie3x4 on Cool Pi CM5 EVB
> d6e600aea013 arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for Cool Pi CM5 EVB
> 6be17990ec10 arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi CM5 EVB
> 77765eecb670 arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
> 7bca62b5ae66 arm64: dts: qcom: sm6115: Fix missing interconnect-names
> b2bc58ba4504 arm64: dts: imx8mp: Disable UART4 by default on Data Modul i.MX8M Plus eDM SBC
> 9474eb5c3d86 ALSA: Various fixes for Cirrus Logic CS35L56 support
> 1e8df48d4da1 dt-bindings: tpm: Drop type from "resets"
> 4d5c46ab184f dt-bindings: display: nxp,tda998x: Fix 'audio-ports' constraints
> fede8bd8306c dt-bindings: xilinx: replace Piyush Mehta maintainership
> eb691d1ece78 Merge tag 'v6.8-rc2-dts-raw'
> 5b093a56e797 ASoC: sun4i-spdif: Add Allwinner H616 compatible
> f2ce9dca7322 ASoC: sun4i-spdif: Fix requirements for H6
> fd23c7505f20 arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved gpio
> cfbd9243ac13 arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved gpio
> 101ce3470b0e Merge tag 'drm-fixes-2024-01-27' of git://anongit.freedesktop.org/drm/drm
> 71ca3bf1c96e Merge tag 'arm-fixes-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 74c898882ebb riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
> 28b77b56d972 arm64: dts: rockchip: mark system power controller on rk3588-evb1
> 986a9f1778ef Merge tag 'samsung-fixes-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/fixes
> 6cf0227916ec arm64: dts: Fix TPM schema violations
> 60245a9006e9 ARM: dts: Fix TPM schema violations
> 92924d8db61a Merge tag 'exynos-drm-fixes-for-v6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-fixes
> 3b240d0d94a9 dt-bindings: media: Remove K3 Family Prefix from Compatible
> 186b38b97035 ARM: dts: exynos4212-tab3: add samsung,invert-vclk flag to fimd
> c4f0c99dffb8 arm64: dts: exynos: gs101: comply with the new cmu_misc clock names
> 429796fee0f1 dt-bindings: clock: gs101: rename cmu_misc clock-names
> 80d76b25d32f Merge tag 'v6.8-rc1-dts-raw'
> 339d8d1caab5 Merge tag 'timers-core-2024-01-21' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> df1980733ce9 Merge tag 'dmaengine-fix-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
> 8c23badf69c3 Merge tag 'riscv-for-linus-6.8-mw4' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> d5a95e32a555 Merge tag 'loongarch-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> 815e38060bf4 Merge tag 'sound-fix-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> f07a1b362766 Merge tag 'for-v6.8-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
> 9411a3099e9c Merge tag 'i2c-for-6.8-rc1-rebased' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> fcb7108dc362 Merge tag 'rtc-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
> 8e06ce5908ff Merge tag 'input-for-v6.8-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> 7b18579c0bef Merge tag 'phy-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
> dd4871a00012 Merge tag 'gpio-fixes-for-v6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> 8dfd2acd2c0c Merge tag 'backlight-next-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
> 736ecd5cf03c Merge tag 'iommu-updates-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> 7d29a06cb311 dt-bindings: i2c: document st,stm32mp25-i2c compatible
> 365a95704e98 dt-bindings: at24: add ROHM BR24G04
> 05d2a9834fd6 Merge tag 'usb-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 70a7bee43907 Merge tag 'tty-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> 6a04bf7a4f07 Merge tag 'char-misc-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> e0c35697cd80 Merge tag 'pci-v6.8-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
> cf29a14b0a23 Merge tag 'pinctrl-v6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> 902219ef9ed0 Merge tag 'mailbox-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox
> c437f65015a8 Merge tag 'leds-next-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds
> d0902d05b4a0 Merge tag 'mfd-next-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
> 8be1d4636d32 Merge tag 'rproc-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
> 6eaaddf12639 Merge tag 'riscv-for-linus-6.8-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> 2cb012b6fe68 LoongArch: dts: DeviceTree for Loongson-2K2000
> 6ab0a6f08b83 LoongArch: dts: DeviceTree for Loongson-2K1000
> 491426707de1 LoongArch: dts: DeviceTree for Loongson-2K0500
> c007f27059d1 dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check warning for interrupt-names
> d9a3ae336ecb dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check warning for reg-names
> 4ee19a9d7583 dt-bindings: loongarch: Add Loongson SoC boards compatibles
> 3e99ee3f7c53 dt-bindings: loongarch: Add CPU bindings for LoongArch
> e8bc7c9c625e dt-bindings: don't anchor DT_SCHEMA_FILES to bindings directory
> f5918b47370e dt-bindings: rtc: max31335: add max31335 bindings
> 7e34d7b53615 rtc: rv8803: add wakeup-source support
> 81d186f05921 Merge branch 'pci/dt-bindings'
> 8bd798490681 Merge branch 'pci/controller/rcar'
> e166e5aad3b0 Merge branch 'pci/controller/cadence'
> 9de355a75fde dt-bindings: gpio: xilinx: Fix node address in gpio
> 28bf1e4e9775 dt-bindings: mailbox: qcom-ipcc: document the X1E80100 Inter-Processor Communication Controller
> f6b31bdd3c60 dt-bindings: mailbox: add Versal IPI bindings
> c3301d070937 dt-bindings: mailbox: zynqmp: extend required list
> 6bf977408719 dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
> b9ea63718a7e dt-bindings: mailbox: qcom,apcs-kpss-global: drop duplicated qcom,ipq8074-apcs-apps-global
> e485b251a3a4 Merge tag 'devicetree-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> 60edd8755b1b Merge tag 'pwm/for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> f946a0610062 Merge tag 'hid-for-linus-2024010801' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
> 5a9222178c60 Merge tag 'media/v6.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> 0c57fa00ac11 Merge tag 'mmc-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> 120152dd192c Merge tag 'pmdomain-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
> f25acec1f182 Merge tag 'gnss-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss
> 040b6611cd72 Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> 432f2b929aa4 Merge tag 'gpio-updates-for-v6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> 5df1a59e6086 Merge tag 'linux-watchdog-6.8-rc1' of git://www.linux-watchdog.org/linux-watchdog
> 1d81fba29be6 Merge tag 'hwmon-for-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> dd7110d3d5d1 Merge tag 'sound-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> c916bd7a1d38 Merge tag 'drm-next-2024-01-10' of git://anongit.freedesktop.org/drm/drm
> 32704b03c7ec Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> c0d1d21fe5ff dt-bindings: fpga: altera: Convert bridge bindings to yaml
> 86986ec77fc7 dt-bindings: fpga: Convert bridge binding to yaml
> 149beabce38e dt-bindings: vendor-prefixes: Add smi
> da831df01407 Merge tag 'soc-drivers-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> d0949aef9e29 Merge tag 'soc-dt-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> c5ee04d9a430 Merge tag 'net-next-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> 17d4b2f2c7c6 dt-bindings: riscv: Document cbop-block-size
> 6361e08793d7 dt-bindings: riscv: permit numbers in "riscv,isa"
> 99f0fa81f51f dt-bindings: riscv: cpus: Clarify mmu-type interpretation
> 5744984c407c ARM: dts: usr8200: Fix phy registers
> fd6e692990ee dt-bindings: PCI: brcmstb: Add property "brcm,clkreq-mode"
> db07ea081cee dt-bindings: power: Clarify wording for wakeup-source property
> 9deb5d7e7649 Merge tag 'v6.8-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> f412e763e552 dt-bindings: mfd: sprd: Add support for UMS9620
> b50b2489e1a2 dt-bindings: input: bindings for Adafruit Seesaw Gamepad
> 9fcf5401177c Merge patch series "riscv: hwprobe: add Zicond, Zacas and Ztso support"
> 6b479ffcb9ed dt-bindings: riscv: add Zacas ISA extension description
> 45e895d242d0 Merge remote-tracking branch 'palmer/fixes' into for-next
> 129abc9e5b89 Merge tag 'thermal-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> 72e795875f31 Merge tag 'mtd/for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> a0d6ec02f5dd Merge tag 'spi-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
> 092d72f89f32 Merge tag 'regulator-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
> f19bbcb501a1 Merge branch 'clk-rs9' into clk-next
> 6c5ff3361f38 Merge branches 'clk-zynq', 'clk-xilinx' and 'clk-stm' into clk-next
> 5348f28123c3 Merge branches 'clk-imx', 'clk-qcom', 'clk-amlogic' and 'clk-mediatek' into clk-next
> dde8a0d89600 Merge branches 'clk-versa', 'clk-silabs', 'clk-samsung', 'clk-starfive' and 'clk-sophgo' into clk-next
> 147299598f64 dt-bindings: ignore paths outside kernel for DT_SCHEMA_FILES
> 5e8ad2415574 dt-bindings: tpm: Document Microsoft fTPM bindings
> 4446def763e6 dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
> d46251bba773 dt-bindings: tpm: Convert Google Cr50 bindings to DT schema
> 4c0c46fcf77f dt-bindings: tpm: Consolidate TCG TIS bindings
> fc825b2e9d71 dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
> 5d51cf126484 dt-bindings: arm: Add remote etm dt-binding
> 32c458bd3442 dt-bindings: mmc: sdhci-pxa: Fix 'regs' typo
> c9ab453dff7c media: dt-bindings: samsung,s5p-mfc: Fix iommu properties schemas
> 481554b6b752 dt-bindings: display: panel: Add synaptics r63353 panel controller
> e04e21bef16e dt-bindings: arm: merge qcom,idle-state with idle-state
> 452e35e6ff26 Merge tag 'irq-core-2024-01-08' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> d35742374b96 dt-bindings: display: samsung,exynos-mixer: Fix 'regs' typo
> ac8ffc6d0764 Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> daf5be0b133e Merge tag 'powerpc-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> b633610fad05 Revert "net: stmmac: Enable Per DMA Channel interrupt"
> fc2b6856183b dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
> 5c111c61a49a dt-bindings: net: snps,dwmac: per channel irq
> 94d319464237 ASoC: dt-bindings: move tas2563 from tas2562.yaml to tas2781.yaml
> 8fbbcaccc3ff Merge tag 'socfpga_dts_updates_for_v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
> 1161aaee27ae dt-bindings: mmc: add Marvell ac5
> e9a747531a5d dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 74165b0
> 57b4e3b1199f Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> cab393f5e80d dt-bindings: serial: Describe ARM dcc interface
> 1d92607a561e dt-bindings: usb: dwc3: Limit num-hc-interrupters definition
> cee9797861a0 dt-bindings: usb: xhci: Add num-hc-interrupters definition
> 4823f8dd230f arm64: dts: mediatek: mt8195: Add 'rx-fifo-depth' for cherry
> 4a4f48930e20 dt-bindings: usb: mtk-xhci: add a property for Gen1 isoc-in transfer issue
> 4ddd871b77e8 arm64: dts: qcom: msm8996: Remove PNoC clock from MSS
> 5598c7c58459 arm64: dts: qcom: msm8996: Remove AGGRE2 clock from SLPI
> a06133f3b90d arm64: dts: qcom: msm8998: Remove AGGRE2 clock from SLPI
> 0e31729b965a arm64: dts: qcom: msm8939: Drop RPM bus clocks
> a9231f1fa44d arm64: dts: qcom: sdm630: Drop RPM bus clocks
> 7806d0946f48 arm64: dts: qcom: qcs404: Drop RPM bus clocks
> 6bbd4a339ffd arm64: dts: qcom: msm8996: Drop RPM bus clocks
> 6c5785d4dec0 arm64: dts: qcom: msm8916: Drop RPM bus clocks
> d99558e0d6ba dt-bindings: usb: qcom,dwc3: Fix SDM660 clock description
> 0e7834fa9ba2 dt-bindings: usb: dwc3: Clean up hs_phy_irq in binding
> f7405c1062e5 dt-bindings: connector: Add child nodes for multiple PD capabilities
> a2f2b957f7b0 arm64: dts: intel: minor whitespace cleanup around '='
> a21ad91a14ac arm64: dts: socfpga: agilex: drop redundant status
> c64326a0161d arm64: dts: socfpga: agilex: add unit address to soc node
> 70eea150a8db arm64: dts: socfpga: agilex: move firmware out of soc node
> 056acfded5ce arm64: dts: socfpga: agilex: move FPGA region out of soc node
> 8e373ef160c7 arm64: dts: socfpga: agilex: align pin-controller name with bindings
> 56a65e118b36 arm64: dts: socfpga: stratix10_swvp: drop unsupported DW MSHC properties
> 5ea405da6608 arm64: dts: socfpga: stratix10_socdk: align NAND chip name with bindings
> 0bc2b8deec9a arm64: dts: socfpga: stratix10: add unit address to soc node
> 3932c6fc63c2 arm64: dts: socfpga: stratix10: move firmware out of soc node
> 174dfac57ae2 arm64: dts: socfpga: stratix10: move FPGA region out of soc node
> e63c11b1c86c arm64: dts: socfpga: stratix10: align pincfg nodes with bindings
> 5ad3116fb135 arm64: dts: socfpga: stratix10: add clock-names to DWC2 USB
> 9185b800f9c3 arm64: dts: socfpga: drop unsupported cdns,page-size and cdns,block-size
> b3832f4d101c ARM: dts: socfpga: align NAND controller name with bindings
> 7772fcc4eef4 ARM: dts: socfpga: drop unsupported cdns,page-size and cdns,block-size
> f466442c93ff dt-bindings: clock: mediatek: add clock controllers of MT7988
> 967ed08fdbd4 dt-bindings: reset: mediatek: add MT7988 ethwarp reset IDs
> 8bb435f3ea7d dt-bindings: clock: mediatek: add MT7988 clock IDs
> 8b8c659b2121 dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
> b822e804fd2c dt-bindings: gpio: add NPCM sgpio driver bindings
> f4c19e862d2b dt-bindings: gpio: realtek: Add realtek,rtd-gpio
> 6690161ed7a9 Merge branches 'apple/dart', 'arm/rockchip', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into next
> 7382fa53a648 dt-bindings: net: renesas,etheravb: Document RZ/G3S support
> 247b8886892f dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
> fec847c57a81 dt-bindings: Add MP2856/MP2857 voltage regulator device
> 42c42ff6c177 dt-bindings: hwmon: gpio-fan: Convert txt bindings to yaml
> 6c13c9d07051 dt-bindings: mmc: sdhci-msm: document dedicated IPQ4019 and IPQ8074
> 1e934476b96c dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel SocFPGA
> 82a434279c9e dt-bindings: HID: i2c-hid: elan: Introduce Ilitek ili2901
> 5fa4567d6c4f Merge tag 'v6.8-rockchip-dts32-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
> a04786e0b7e0 Merge tag 'v6.8-rockchip-dts64-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
> 0bf9a2425459 Merge tag 'qcom-arm64-for-6.8-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
> a3fde0732d5b Merge tag 'qcom-arm32-for-6.8-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
> 62073621d812 Merge tag 'arm-soc/for-6.8/devicetree' of https://github.com/Broadcom/stblinux into soc/dt
> 4cfe8fd4e2b4 Merge tag 'sprd-dt-6.8-rc1' of https://github.com/lyrazhang/linux into soc/dt
> a355b8e8cbdd dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Clean up examples
> 36a030b546d0 dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Fix example node names
> ca1c0a8c8091 dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
> 7123707b90de dt-bindings: thermal-zones: Document critical-action
> c29ec9b83fd7 dt-bindings: thermal: qcom-tsens: document the SM8650 Temperature Sensor
> 5a12787401b5 dt-bindings: thermal: loongson,ls2k-thermal: Fix binding check issues
> 0a6d923c5231 dt-bindings: thermal: convert Mediatek Thermal to the json-schema
> dc5dd3862b77 dt-bindings: input: iqs269a: Add bindings for OTP variants
> 5aa00301cee3 dt-bindings: input: iqs269a: Add bindings for slider gestures
> c4635c803af3 Merge tag 'iio-for-6.8b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
> 571d91b8d8df arm64: dts: rockchip: Fix led pinctrl of lubancat 1
> 548cbdf62c21 arm64: dts: rockchip: correct gpio_pwrctrl1 typo on nanopc-t6
> 86c28823371d arm64: dts: rockchip: correct gpio_pwrctrl1 typo on rock-5b
> 275bc737b480 arm64: dts: rockchip: support poweroff on the rock-5b
> e4f7332bb7f8 arm64: dts: rockchip: Support poweroff on Orange Pi 5
> d0c46aeba839 arm64: dts: rockchip: nanopc-t6 sdmmc beautification
> df73c00bc509 arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings
> 12243eba2b74 arm64: dts: sprd: Add clock reference for pll2 on UMS512
> af72bfcc73f3 arm64: dts: sprd: Removed unused clock references from etm nodes
> d8f5562e697b arm64: dts: sprd: Add support for Unisoc's UMS9620
> bd8f67f82f65 dt-bindings: arm: Add compatible strings for Unisoc's UMS9620
> 9da3db96fae0 arm64: dts: sprd: fix the cpu node for UMS512
> 3ebc08960525 Merge tag 'v6.7-rc7' into gpio/for-next
> cb90fcbed71e dt-bindings: timer: Add StarFive JH8100 clint
> 6f2b19f4df72 dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
> 4421b3e3124f dt-bindings: iio: Add AD7091R-8
> 51a0454cffd6 dt-bindings: power: supply: bq24190: Add BQ24296 compatible
> 4639caeeab2f dt-bindings: power: reset: xilinx: Rename node names in examples
> c873132667ed dt-bindings: power: reset: qcom-pon: fix inconsistent example
> 64cf7a912b11 arm64: dts: rockchip: Fix rk3588 USB power-domain clocks
> 815a2542ad42 arm64: dts: rockchip: configure eth pad driver strength for orangepi r1 plus lts
> 9df823a6207b arm64: dts: rockchip: Support poweroff on NanoPC-T6
> 78bd00069022 arm64: dts: rockchip: rk3308-rock-pi-s gpio-line-names cleanup
> 9d6e0741ae7c arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB
> a64a2e009e21 dt-bindings: arm: rockchip: Add Cool Pi CM5
> 4397d62daec8 arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B
> f1a9c321e26f dt-bindings: arm: rockchip: Add Cool Pi 4B
> 1e413c69529f dt-bindings: vendor-prefixes: Add Cool Pi
> a67ded35095e arm64: dts: rockchip: add gpio-line-names to rk3328-rock-pi-e
> e0ec5767b690 ARM: dts: rockchip: Remove rockchip,default-sample-phase from rk3036.dtsi
> 75e0afe6681c ARM: dts: rockchip: Add stdout-path for rk3036 kylin
> 5b38dc06a1e9 dt-bindings: watchdog: qcom,pm8916-wdt: add parent spmi node to example
> d2f78877f2ea dt-bindings: watchdog: nxp,pnx4008-wdt: convert txt to yaml
> af1fdc5cd02d dt-bindings: watchdog: qca,ar7130-wdt: convert txt to yaml
> 5c3d9631b9ac dt-bindings: watchdog: intel,keembay: reference common watchdog schema
> 6d86f883fd9c dt-bindings: watchdog: re-order entries to match coding convention
> e28051167c06 dt-bindings: touchscreen: neonode,zforce: Use standard properties
> 3119a224ac1c dt-bindings: touchscreen: convert neonode,zforce to json-schema
> 15bf36928144 Merge tag 'icc-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
> dd37eb39a550 dt-bindings: input: convert drv266x to json-schema
> 795f4eddfec7 Merge tag 'qcom-arm64-for-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
> 991ab34b2120 Merge tag 'reset-for-v6.8' of git://git.pengutronix.de/pza/linux into soc/drivers
> 4e7b4659bc67 dt-bindings: mtd: partitions: u-boot: Fix typo
> 35dd951a7fd5 Merge tag 'riscv-cache-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/drivers
> 69b18d58cc6d Merge tag 'riscv-soc-drivers-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/drivers
> fc5aa9bf69fd Merge tag 'samsung-drivers-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/drivers
> 84c9739eb5b5 Merge tag 'qcom-drivers-for-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/drivers
> 0ef14d7a1f46 dt-bindings: crypto: qcom-qce: document the SC7280 crypto engine
> 2fd8394e6d9f dt-bindings: crypto: qcom-qce: constrain clocks for SM8150-compatible QCE
> 40fd9d4f3234 dt-bindings: crypto: qcom-qce: constrain clocks for IPQ9574 QCE
> 30960ac02d6e dt-bindings: rng: starfive: Add jh8100 compatible string
> e6272a79f69c Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> dcd8ac1c5dd8 dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
> 87166d1d3f3f Merge tag 'riscv-dt-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt
> 69abc2365d38 dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add X1E80100 USB PHY binding
> 822a13d2bf90 dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Document X1E80100 compatible
> 6722c7fe2a57 dt-bindings: phy: qcom: snps-eusb2: Document the X1E80100 compatible
> a38a399bccf1 dt-bindings: phy: mediatek: tphy: add a property for force-mode switch
> ca521e2ecf25 dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix path to header
> aa156a9707ec Merge tag 'amlogic-arm64-dt-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/dt
> e6127e00f352 Merge tag 'mvebu-dt64-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/dt
> aad08c0a0671 Merge tag 'mvebu-dt-6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/dt
> e4320c558711 Merge tag 'samsung-dt64-6.8-2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
> 077793e138f6 Merge tag 'qcom-arm32-for-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/dt
> 7ff5e1692425 Merge tag 'ti-k3-dt-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
> f009c98b2a3f dt-bindings: iio: dac: add MCP4821
> e46c2c536959 Merge tag 'ti-keystone-dt-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/dt
> edeab43af36b Merge tag 'zynqmp-dt-for-6.8' of https://github.com/Xilinx/linux-xlnx into soc/dt
> 4e78ad68f722 Merge tag 'imx-dt64-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
> f4ece4b3d883 Merge tag 'imx-dt-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
> 1a2b6b1db701 Merge tag 'imx-bindgins-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
> 71e20fbc3d5b Merge tag 'ux500-dts-soc-for-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into soc/dt
> 056c9efa37c5 Merge tag 'renesas-dts-for-v6.8-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
> 339491d0999f Merge tag 'stm32-dt-for-v6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into soc/dt
> 06086605676a dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in dts
> 640904451ab8 dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
> f88d59ec5d12 Merge tag 'sunxi-dt-for-6.8-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into soc/dt
> e833ff47f9b9 Merge tag 'at91-dt-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/dt
> 9f821c027b01 Merge tag 'juno-update-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/dt
> 4bab8a451f49 Merge tag 'v6.8-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
> a4789dd06449 Merge tag 'v6.8-rockchip-dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
> 5045526f0b7c Merge tag 'mtk-dts64-for-v6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into soc/dt
> a7603f8260b8 Merge tag 'samsung-dt-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
> 16a1d6e0b098 Merge tag 'samsung-dt64-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/dt
> 0f1f66f39700 ARM: dts: ste: minor whitespace cleanup around '='
> 22532c5d3f4a Merge tag 'omap-for-v6.8/dt-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
> 5288e13a2ad4 Merge tag 'hisi-arm64-dt-for-6.8' of https://github.com/hisilicon/linux-hisi into soc/dt
> f44f238cabce Merge tag 'w1-drv-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next
> 61f41fa45eaf Merge tag 'iio-for-6.8a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
> 07d575b06ff9 dt-bindings: pwm: ti,pwm-omap-dmtimer: Update binding for yaml
> fc02de1f5dc0 dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
> 780449a81d3c dt-bindings: pwm: remove Xinlei's mail
> f96dd7edb887 arm64: dts: qcom: sc8180x: Fix up PCIe nodes
> b1ecf20e17e0 arm64: dts: qcom: sc8180x: Mark PCIe hosts cache-coherent
> eeed8f113289 dt-bindings: pinctrl: xilinx: Rename *gpio to *gpio-grp
> 2ef9211e8711 dt-bindings: pinctrl: qcom: drop common properties and allow wakeup-parent
> 188c161805d3 dt-bindings: pinctrl: qcom: drop common properties
> 7834682c0d2c dt-bindings: pinctrl: qcom,ipq5018-tlmm: use common TLMM bindings
> c31ea3c9600f dt-bindings: pinctrl: qcom,x1e80100-tlmm: restrict number of interrupts
> 6cec6f6f090c dt-bindings: pinctrl: qcom,sm8650-tlmm: restrict number of interrupts
> ef7b1c134921 dt-bindings: pinctrl: qcom,sm8550-tlmm: restrict number of interrupts
> a3abecdd0e2e dt-bindings: pinctrl: qcom,sdx75-tlmm: restrict number of interrupts
> 2b1d1c0dd621 dt-bindings: pinctrl: qcom,sa8775p-tlmm: restrict number of interrupts
> 36f8bb953634 dt-bindings: pinctrl: qcom,qdu1000-tlmm: restrict number of interrupts
> 670ced18d87f dt-bindings: pinctrl: qcom: create common LPASS LPI schema
> 5ca197c58799 dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
> 8d27a131f7ad dt-bindings: pinctrl: qcom,pmic-mpp: clean up example
> 6674c2217ce1 Merge tag 'mediatek-drm-next-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-next
> d7dde4a72dfa Merge tag 'drm-msm-next-2023-12-15' of https://gitlab.freedesktop.org/drm/msm into drm-next
> 64ddcb330a18 arm64: dts: qcom: x1e80100-qcp: Fix supplies for some LDOs in PM8550
> 206ab99c38ce arm64: dts: qcom: sm8550: Update idle state time requirements
> 319f395fbc2a arm64: dts: qcom: sm8550: Separate out X3 idle state
> af2f75b56294 ARM: dts: qcom: sdx55: Fix the base address of PCIe PHY
> 4a72661b117b arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
> 5b72e989a37a arm64: dts: qcom: x1e80100: align mem timer size cells with bindings
> b17d7383c10f arm64: dts: qcom: sc7280: Mark SDHCI hosts as cache-coherent
> 3840ead2163a ARM: dts: qcom: sdx55: fix USB SS wakeup
> 9e773fad2487 ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts
> d0728def7588 ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
> 0ee9dac79d46 ASoC: qcom: add sound card support for SM8650
> 345b970f1857 add es8326 dt-bindings, commonize headset codec
> 85a45459eeed GPIO inclusion fixes to misc sound drivers
> 616e88e1109d arm64: dts: qcom: sc8180x: fix USB SS wakeup
> f3d1b2acf659 arm64: dts: qcom: sdm670: fix USB SS wakeup
> 987f42804a25 arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY interrupts
> 2e58236aa851 ASoC: dt-bindings: qcom,lpass-va-macro: remove spurious contains in if statement
> bded77d8cc7b dt-bindings: regulator: qcom,usb-vbus-regulator: clean up example
> e1481a467961 powerpc/fsl: Fix fsl,tmu-calibration to match the schema
> 26e2fad496d4 arm64: dts: amlogic: fix format for s4 uart node
> 8a5115be3855 arm64: dts: amlogic: drop redundant status=okay
> 799049c22bf2 arm64: dts: amlogic: enable some nodes for board AQ222
> 3fea93dcdd73 arm64: dts: amlogic: add some device nodes for S4
> 44721ac7f4da Merge tag 'drm-misc-next-2023-12-14' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> d623bb97a280 Merge tag 'samsung-pinctrl-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into devel
> 81d84dd62616 ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS WSA
> 4f673348bd77 ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS VA
> d5b1bc404268 ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS TX
> 40420db77069 ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS RX
> 605001444f21 ASoC: dt-bindings: qcom,sm8250: Add X1E80100 sound card
> 4e179f2c3905 ASoC: dt-bindings: mt8188-mt6359: add es8326 support
> 0c819517fcb2 ASoC: dt-bindings: qcom,sm8250: document SM8650 sound card
> 0292b51ac8c4 ASoC: tegra: tegra20_ac97: Convert to use GPIO descriptors
> 4c6bc6503e5e Merge tag 'device_is_big_endian-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core into gpio/for-next
> 31d8096d43a1 dt-bindings: gpio: dwapb: allow gpio-ranges
> 873d4c02bbfa dt-bindings: clock: google,gs101: rename CMU_TOP gate defines
> bfc73914844a dt-bindings: clock: si5351: add PLL reset mode property
> af0493badd9d dt-bindings: clock: si5351: convert to yaml
> d1a5fb288be1 dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform
> ee353e29bfb4 dt-bindings: clk: rs9: Add 9FGV0841
> 48b20705829d dt-bindings: clock: brcm,kona-ccu: convert to YAML
> b2b282bb3ba9 dt-bindings: arm: mediatek: move ethsys controller & convert to DT schema
> e35ce136c12f dt-bindings: clock: xilinx: add versal compatible
> 746818ace7a3 dt-bindings: rtc: Add Nuvoton ma35d1 rtc
> d8c717fd9bc8 dt-bindings: Remove alt_ref from versal
> e9caccbf099c arm64: dts: qcom: sc8180x-primus: Allow UFS regulators load/mode setting
> b616df631790 arm64: dts: qcom: sc8180x: Describe the GIC redistributor
> ae7e39a80f0f arm64: dts: qcom: sc8180x: Add interconnects to UFS
> 0f32e7aa54e0 arm64: dts: qcom: sc8180x: Add missing MDP clocks
> 3641f17d731d arm64: dts: qcom: sc8180x: Add UFS GDSC
> 2bbb23973697 arm64: dts: qcom: sc7280*: move MPSS and WPSS memory to dtsi
> a5b4605b6fc6 ARM: dts: qcom: msm8974*: Re-enable remoteprocs on various boards
> f1ecb44efc55 ARM: dts: qcom: msm8974: Remove bogus cd-gpio pinctrl
> 9dd85d38d004 ARM: dts: qcom: msm8974-klte: Remove unused property
> 34c2fdcebf94 arm64: dts: qcom: sc7280: Rename reserved-memory nodes
> 84a50703ca7d dt-bindings: remoteproc: qcom: sc7180-pas: Add SC7280 compatibles
> 47f83514132e dt-bindings: remoteproc: qcom: sc7180-pas: Fix SC7280 MPSS PD-names
> 1dce719ef64f arm64: dts: qcom: sc7280: Remove unused second MPSS reg
> afedac693f18 arm64: dts: qcom: sdm670: add display subsystem
> 1d8d2d147ea5 dt-bindings: soc: qcom,aoss-qmp: document the X1E80100 Always-On Subsystem side channel
> 3ea56a52a7c2 dt-bindings: wdt: Add ts72xx
> 18522cdf3ec6 dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
> 688fe0bdd724 dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061 watchdog
> 9054003bb13e dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988 watchdog and toprgu
> 63d466a6e3b3 dt-bindings: watchdog: realtek,rtd1295-watchdog: convert txt to yaml
> 5b6c41392896 dt-bindings: watchdog: qcom-wdt: Make the interrupt example edge triggered
> 4f8423c375eb dt-bindings: iio: chemical: add aosong,ags02ma
> 766801c2fc4b dt-bindings: vendor-prefixes: add aosong
> 530dcc2cff54 arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode
> a63d7ac5c9ca arm64: dts: qcom: sm8150: add USB-C ports to the OTG USB host
> 6177bf5ba3b4 arm64: dts: qcom: sm8150: add USB-C ports to the USB+DP QMP PHY
> cccb449ab331 arm64: dts: qcom: sm8150: add DisplayPort controller
> 414013ad4921 arm64: dts: qcom: sm8150-hdk: fix SS USB regulators
> 94e5a8422a14 arm64: dts: qcom: sm8150-hdk: enable HDMI output
> 94cd2b0ff062 arm64: dts: qcom: sm8150: make dispcc cast minimal vote on MMCX
> d8577fce5e20 arm64: dts: qcom: sm8650: add fastrpc-compute-cb nodes
> e14f9c1044bd arm64: dts: qcom: sm8550-qrd: add PM8010 regulators
> 66e97e0962a7 arm64: dts: qcom: sm8550-mtp: Add pm8010 regulators
> 6437200479ec arm64: dts: qcom: qcm2290: Hook up MPM
> 75b87eb7e3ee arm64: dts: qcom: msm8996: Hook up MPM
> e043072a3a33 arm64: dts: qcom: sm6375: Hook up MPM
> 623a6180066f dt-bindings: arm: qcom: Add Motorola Moto G 4G (2013)
> 030e5c73208a arm64: dts: qcom: x1e80100-crd: Fix supplies for some LDOs in PM8550
> 58e87053c1f0 arm64: dts: qcom: sc7280: add QCrypto nodes
> 6d138c9b4127 arm64: dts: qcom: sc7180: Switch pompom to the generic edp-panel
> 9248e79cd654 arm64: dts: qcom: sm8150: fix USB SS wakeup
> 8143f0f67202 arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts
> 1d46c82d351b arm64: dts: qcom: sdm845: fix USB SS wakeup
> 5c261eb8cd11 arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts
> 2998fdbc15fe arm64: dts: qcom: sc8180x: fix USB DP/DM HS PHY interrupts
> 220ee261025f arm64: dts: qcom: sm8550: drop unneeded assigned-clocks from codec macros
> ef2823c0a498 arm64: dts: qcom: sm8550: move Soundwire pinctrl to its nodes
> 611112fa3972 arm64: dts: qcom: sm8450: drop unneeded assigned-clocks from codec macros
> 7fe6ee08b28c arm64: dts: qcom: sm8450: move Soundwire pinctrl to its nodes
> eb6e95625c03 arm64: dts: qcom: sm8550: add missing two RX Soundwire ports in configuration
> 6f45533e32ad arm64: dts: qcom: sm8650: drop unneeded assigned-clocks from WSA macro
> 108c60eb7746 dt-bindings: arm: qcom: Fix up htc-memul compatible
> c493fe546f0a arm64: dts: qcom: sm6115: Hook up interconnects
> fd22f3a58a9e Merge branch 'icc-sm6115' of https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into HEAD
> 85a531800a07 ARM: dts: qcom: msm8926-motorola-peregrine: Add initial device tree
> 9c323b20cda8 ARM: dts: qcom: ipq4019: add dedicated SDHCI compatible
> 2fcaa70bfc3c arm64: dts: qcom: ipq8074: add dedicated SDHCI compatible
> 757c981838e3 arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports
> 34e4f27862d1 arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
> 61e7df01e058 arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
> 786be94e8465 arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node
> fe9d727180d2 arm64: dts: qcom: sa8775p: Add missing space between node name and braces
> 8df2548eb151 arm64: dts: qcom: Use "pcie" as the node name instead of "pci"
> 756ec289cf35 ARM: dts: qcom: Use "pcie" as the node name instead of "pci"
> 2066a55949a7 arm64: dts: qcom: acer-aspire1: Add sound
> 90485d1f88ce arm64: dts: qcom: acer-aspire1: Correct audio codec definition
> 3d97796b14f9 arm64: dts: qcom: acer-aspire1: Enable RTC
> 5d870a6a209b arm64: dts: qcom: sm8450: switch UFS QMP PHY to new style of bindings
> 1e57f262d57c arm64: dts: qcom: sm8350: switch UFS QMP PHY to new style of bindings
> 731a9974488a arm64: dts: qcom: sm8250: switch UFS QMP PHY to new style of bindings
> 8a512baad9fa arm64: dts: qcom: sm8150: switch UFS QMP PHY to new style of bindings
> 9c4063711b1f arm64: dts: qcom: sm6350: switch UFS QMP PHY to new style of bindings
> 79c130d88048 arm64: dts: qcom: sm6115: switch UFS QMP PHY to new style of bindings
> 65d88afa8518 arm64: dts: qcom: sdm845: switch UFS QMP PHY to new style of bindings
> fa34450ebcf9 arm64: dts: qcom: msm8998: switch UFS QMP PHY to new style of bindings
> 2d00768d0566 arm64: dts: qcom: msm8996: switch UFS QMP PHY to new style of bindings
> 6d501541ab8b arm64: dts: qcom: sm8450-hdk: Enable the A730 GPU
> 9999a06044c2 arm64: dts: qcom: sm8550-mtp: Enable the A740 GPU
> 1c8862cd1be0 arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
> db2dd74a4321 arm64: dts: qcom: sm8550: Add GPU nodes
> 41411e46e180 arm64: dts: qcom: sm8450: Add GPU nodes
> 67082abed4d1 arm64: dts: qcom: msm8939: Make blsp_dma controlled-remotely
> b0768548dacf arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely
> e529c8cd00c4 arm64: dts: qcom: msm8939: Add clock-frequency for broadcast timer
> dc95d696633b arm64: dts: qcom: Add missing vio-supply for AW2013
> ce476167f046 arm64: dts: qcom: ipq6018: Add QUP5 SPI node
> 4723cf41be1a arm64: dts: qcom: ipq6018: Add remaining QUP UART node
> af3ecf0ef5eb Merge branch '20231201-videocc-8150-v3-1-56bec3a5e443@quicinc.com' into clk-for-6.8
> eeb32e2a4dbd dt-bindings: clock: Update the videocc resets for sm8150
> c591d3616c87 arm64: dts: qcom: qrb4210-rb2: Enable MPSS and Wi-Fi
> 479632ff42dd arm64: dts: freescale: fix the schema check errors for fsl,tmu-calibration
> 4c12613ce6e0 ARM: dts: imx27-phytec-phycore-som: Use 'rtc' as node name
> e55cb89e6ef8 ARM: dts: imx25: Remove unneeded keypad properties
> 610b835be6b9 dt-bindings: net: marvell,orion-mdio: Drop "reg" sizes schema
> 5605354f949e arm64: dts: freescale: imx8qxp: Disable dsp reserved memory by default
> bb83d09752aa arm64: dts: imx8qxp: Add VPU subsystem file
> 11f5b7454c94 arm64: dts: imx8qxp-mek: Move port under USB connector
> f6d6c203902d arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
> 643674137f59 dt-bindings: PCI: qcom: Document the SM8650 PCIe Controller
> ddec040496f1 dt-bindings: PCI: dwc: rockchip: Document optional PCIe reference clock input
> 2d8a490fd767 dt-bindings: PCI: qcom: Correct reset-names property
> 2bdefbbe9381 dt-bindings: PCI: qcom: Correct clocks for SM8150
> 01ce80af6cc2 dt-bindings: PCI: qcom: Correct clocks for SC8180x
> 9c60f1faccc9 dt-bindings: PCI: qcom: Adjust iommu-map for different SoC
> c78e4dd9c7c0 arm64: dts: rockchip: make use gpio-keys for buttons on puma-haikou
> 146cf4124863 arm64: dts: rockchip: expose BIOS Disable feedback pin on rk3399-puma
> 26575df71b2d arm64: dts: rockchip: fix misleading comment in rk3399-puma-haikou.dts
> 93c2098cfa35 ARM: dts: ux500-href: Switch HREF520 to AB8505
> 488dc522177c ARM: dts: ux500-href: Push AB8500 config out
> 7acade644174 ARM: dts: ux500-href: Push AB8500 inclusion to the top
> 0043c908a991 dt-bindings: connector: usb: add accessory mode description
> 7b7f80d863a5 arm64: dts: rockchip: Add vop on rk3588
> ef9ea9ea51ca arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed mode
> a843a4a028e7 arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode
> 83869275890f arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
> 237d1d3aa847 arm64: dts: ti: k3-am6*: Add additional regs for DMA components
> 6540bf190683 arm64: dts: ti: k3-j7*: Add additional regs for DMA components
> f584859d0f96 arm64: dts: ti: k3-am65: Add additional regs for DMA components
> e76881a36a46 arm64: dts: cn913x: add device trees for COM Express boards
> a57b87e79272 dt-bindings: arm64: add Marvell COM Express boards
> 22b670935a1f arm64: dts: armada-3720-turris-mox: set irq type for RTC
> 6b8494ce5492 ARM64: dts: Add special compatibles for the Turris Mox
> 8fcbbd77bc4f ARM64: dts: marvell: Fix some common switch mistakes
> 61b4fbe68e70 ARM: dts: marvell: make dts use gpio-fan matrix instead of array
> 1a025bb583e1 ARM: dts: marvell: Fix some common switch mistakes
> 283f9ebb847c dt-bindings: serial: Add a new compatible string for UMS9620
> 42414ddb491a dt-bindings: serial: imx: Properly describe the i.MX1 interrupts
> a5b226724ae1 dt-bindings: usb: qcom,dwc3: Add X1E80100 binding
> a94c79572ac2 dt-bindings: usb: Document WCD939x USB SubSystem Altmode/Analog Audio Switch
> 6c2112d5f3f3 arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid
> 79493bc9fc10 dt-bindings: connector: usb: add altmodes description
> a98f9ad936ee dt-bindings: usb: nxp,ptn5110: Fix typos in the title
> da44f4e15545 dt-bindings: usb: genesys,gl850g: Document 'peer-hub'
> c32fd07e4010 dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem
> cc8835249ffb ARM: dts: stm32: add dcmipp support to stm32mp135
> dc483bc0495b dt-bindings: gnss: u-blox: add "reset-gpios" binding
> 82239f64506f dt-bindings: iommu: rockchip: Add Rockchip RK3588
> b10f7d79bc86 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> e39b04bbed6e Merge branch 'icc-qcm2290' into icc-next
> c95f389c0366 Merge branch 'icc-sm6115' into icc-next
> b1f1b32e611b dt-bindings: PCI: rcar-pci-host: Add optional regulators
> 51eab76bc15c arm64: dts: allwinner: h618: add Transpeed 8K618-T TV box
> 8f65017d5eb4 dt-bindings: arm: sunxi: document Transpeed 8K618-T board name
> a043657dff28 dt-bindings: vendor-prefixes: add Transpeed
> b9b13eec182f arm64: dts: st: add bsec support to stm32mp25
> 4ba9da13226a ARM: dts: stm32: Consolidate usbh_[eo]hci phy properties on stm32mp15
> 3cd8f921b287 ARM: dts: stm32: don't mix SCMI and non-SCMI board compatibles
> 9d7cd7004fbc dt-bindings: arm: stm32: don't mix SCMI and non-SCMI board compatibles
> 3409584c8b1b ARM: dts: stm32: minor whitespace cleanup around '='
> 46d3a566ba35 regulator: dt-bindings: qcom,rpmh: add compatible for pm8010
> b876feae34ef ASoC: dt-bindings: audio-graph-port: Document new DAI link flags playback-only/capture-only
> b0c246496fbc dt-bindings: display: msm: dp: declare compatible string for sm8150
> 363bcab6054e scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
> 3d1e051b5db8 arm64: dts: imx8mp-dhcom-pdk3: Describe the USB-C connector
> ef545aff5ca3 arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
> 13069c168986 arm64: dts: imx8mp-tqma8mpql-mba8mpxl: Fix USB connector description
> c92840a54a7a arm64: dts: imx8mp-venice: Fix USB connector description
> d0235ca7db0f arm64: dts: imx8mp-verdin: Fix USB connector description
> 8e6a721ca452 arm64: dts: imx8dxl-ss-conn: Move clk_dummy out of USB node
> 7662ace2b978 arm64: dts: imx8mn-evk: Move port under USB connector
> 92576b82f349 arm64: dts: imx8mm-evk: Move port under USB connector
> 91c629656840 arm64: dts: freescale: introduce dimonoff-gateway-evk board
> 8b75c148251b dt-bindings: arm: fsl: add Dimonoff gateway EVK board
> 192ca710eafd dt-bindings: vendor-prefixes: add dimonoff
> edc62a2939e3 arm64: dts: imx8m*-tqma8m*: Add chassis-type
> d35e9fd630d7 arm64: dts: imx8mn-beacon: Support overdrive mode
> a684f6ef9a40 arm64: dts: imx8mn: Enable Overdrive mode
> 0c6ce8fb001d arm64: dts: imx8mm-beacon: Enable overdrive mode
> 42e3d3eaa3cb arm64: dts: imx8mm: Add optional overdrive DTSI
> f9b749293626 arm64: dts: imx8mm: Reduce GPU to nominal speed
> aadc35d489bd arm64: dts: imx93: Fix the micfil clock-names entries
> f8b732c140f6 ARM: dts: imx23/28: Fix the DMA controller node name
> 9697ec153a9c ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
> 62875ee7373e ARM: dts: imx27-apf27dev: Fix LED name
> 6bd0d6d0fb3d ARM: dts: imx25/27: Pass timing0
> 3cd4341f361d ARM: dts: imx25: Fix the iim compatible string
> 52eef6a12e21 arm64: dts: exynos: google: Add initial Oriole/pixel 6 board support
> b0f009ddef83 arm64: dts: exynos: google: Add initial Google gs101 SoC support
> 7932b36aab04 dt-bindings: arm: google: Add bindings for Google ARM platforms
> c439b1ecd46b dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings
> 5114ddf2754e dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes
> 5142777cc846 arm64: dts: renesas: white-hawk-cpu: Fix missing serial console pin control
> 9c5b72f0dbf7 arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces
> c20cd1060c83 arm64: dts: renesas: rzg3s-smarc-som: Use switches' names to select on-board functionalities
> d1702886b9b1 arm64: dts: renesas: r9a08g045: Add Ethernet nodes
> c8bc29914258 arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node
> 2ac19b878bcd arm64: zynqmp: Add missing destination mailbox compatible
> bfda609d3986 arm64: zynqmp: Fix clock node name in kv260 cards
> bf79a715a44c arm64: zynqmp: Move fixed clock to / for kv260
> 067130bf35dd dt-bindings: soc: Add new board description for MicroBlaze V
> 3909199b5365 dt-bindings: soc: xilinx: Move xilinx.yaml from arm to soc
> 5a30f0c409d5 arm64: xilinx: Remove address/size-cells from gem nodes
> c7afa96873c9 arm64: xilinx: Remove address/size-cells from flash node
> e3a99f7f8d11 arm64: xilinx: Put ethernet phys to mdio node
> 6f4a9a0c8df9 arm64: xilinx: Remove mt25qu512a compatible string from SOM
> e3823e6a85e8 arm64: xilinx: Use lower case for partition address
> ee878ab978b7 arm64: xilinx: Do not use '_' in DT node names
> edb56e5ac871 riscv: dts: starfive: Enable SDIO wifi on JH7100 boards
> 738fd2fd6271 riscv: dts: starfive: Enable SD-card on JH7100 boards
> 4a3456d5f756 riscv: dts: starfive: Add JH7100 MMC nodes
> 0b98a998f256 riscv: dts: starfive: Add pool for coherent DMA memory on JH7100 boards
> b7e59570a83e riscv: dts: starfive: Add JH7100 cache controller
> 0e3644417255 riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
> 2ce3980ca0ba riscv: dts: starfive: Group tuples in interrupt properties
> 21bb4608c1f4 arm64: dts: ti: k3-am62-main: Add GPU device node
> 21dbc3bb6085 dt-bindings: interconnect: qcom,msm8998-bwmon: Add QCM2290 bwmon instance
> 0a5288800340 dt-bindings: rockchip,vop2: Add more endpoint definition
> 689213783aed dt-bindings: display: vop2: Add rk3588 support
> d06f02a431a5 dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6115 bwmon instance
> a67732e07f79 arm64: dts: fsd: Add MFC related DT enteries
> a8f325704092 arm64: dts: ti: k3-j721s2-evm: Add overlay for PCIE1 Endpoint Mode
> c33d48e723e9 arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE0 Endpoint Mode
> 411f344456e4 arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs
> e88109a7ea70 arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC
> 8203df16463f arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC
> 12693cd3a151 arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
> 022683d6bab2 arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs
> b13637076b0a arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
> 073920a8e469 spi: dw: Remove Intel Thunder Bay SOC support
> 853b38b4ccbe dt-bindings: media: s5p-mfc: Add mfcv12 variant
> af1444135df0 dt-bindings: soc: rockchip: add rk3588 vop/vo syscon
> ea9d3ade1f63 media: dt-bindings: Add OmniVision OV64A40
> eac07152e0b8 media: dt-bindings: media: imx335: Add supply bindings
> 37535c00a2ec media: dt-bindings: gc0308: add binding
> 9be8a81b5d55 media: dt-bindings: ov8856: decouple lanes and link frequency from driver
> e78a33d58798 media: dt-bindings: alvium: add document YAML binding
> 123e53dddda5 dt-bindings: vendor-prefixes: Add prefix alliedvision
> 5367c47d39ee media: dt-bindings: ak7375: Add ak7345 support
> 33368f1c353f dt-bindings: mfd: pm8008: Clean up example node names
> 2ab5a6b315e7 dt-bindings: leds: qcom,spmi-flash-led: Fix example node name
> fa6a05463677 dt-bindings: leds: aw200xx: Fix led pattern and add reg constraints
> 44e89edff478 dt-bindings: leds: awinic,aw200xx: Add AW20108 device
> 6cd025d35790 dt-bindings: leds: aw200xx: Remove property "awinic,display-rows"
> 65b3a1cec5b9 dt-bindings: leds: aw200xx: Introduce optional enable-gpios property
> 48e46bb513fb dt-bindings: leds: Add Allwinner A100 LED controller
> 193b43eae00d dt-bindings: leds: Fix JSON pointer in max-brightness
> ac28e493721a ARM: dts: imx25: Move usbphy nodes out of simple-bus
> 90f8840e451d ARM: dts: imx1: Use 'bus' for AIPI bus
> dfc79426f635 ARM: dts: imx27-phytec-phycore-rdk: Move usbphy nodes out of simple-bus
> 92c19f27621f ARM: dts: imx27-pdk: Move usbphy0 out of simple-bus
> 09cddc0d2c3d ARM: dts: imx27: Use 'bus' for EMI bus
> e7cd1893e9ea ARM: dts: imx27: Use 'bus' for AIPI bus
> 81e952ba68c6 media: dt-bindings: media: i2c: Add bindings for TW9900
> 2ed7758d7c0a dt-bindings: vendor-prefixes: Add techwell vendor prefix
> 9b5febaeea2a arm64: dts: freescale: add fsl-lx2160a-mblx2160a board
> c763b70a3ecc dt-bindings: arm: fsl: Add TQ-Systems LX2160A based boards
> 6c6fc780325f ARM: dts: imx27-phytec-phycore-som: Use the mux- prefix
> 2571ab1025eb ARM: dts: imx1: Fix sram node
> c64c46277345 ARM: dts: imx27: Fix sram node
> 4606862f29a7 ARM: dts: imx: Use flash@0,0 pattern
> e9c196aff7af ARM: dts: imx25/27-eukrea: Fix RTC node name
> 34087a021485 ARM: dts: imx25-pdk: Pass #sound-dai-cells
> f91e9208f059 ARM: dts: imx25: Pass I2C clock-names property
> cb93e178f443 arm64: dts: freescale: imx93: add i3c1 and i3c2
> 3b2d451cf59f arm64: dts: ls1012a: Remove big-endian from thermal
> 25e47251c772 dt-bindings: input: microchip,cap11xx: add advanced sensitivity settings
> a0fb1bc7fd22 Merge tag 'exynos-drm-next-for-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-next
> aae3e1a63026 dt-bindings: riscv: add Zfa ISA extension description
> ab9eea090f24 dt-bindings: riscv: add Zvfh[min] ISA extension description
> 7a64028da27c dt-bindings: riscv: add Zihintntl ISA extension description
> f4789213e5b6 dt-bindings: riscv: add Zfh[min] ISA extensions description
> c5de05064f79 dt-bindings: riscv: add vector crypto ISA extensions description
> 215c236fe6da dt-bindings: riscv: add scalar crypto ISA extensions description
> 1a96ef0c118a Merge tag 'pef2256-framer' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> 6dbce6382acc Merge tag 'pef2256-framer' into devel
> 1c566bdd0e0f dt-bindings: net: Add the Lantiq PEF2256 E1/T1/J1 framer
> 0e2e3f19a42d arm64: dts: rockchip: Add Anbernic RG351V
> aa1c981f085f arm64: dts: rockchip: Split RG351M from Odroid Go Advance
> 5985d0436d7f dt-bindings: arm: rockchip: Add Anbernic RG351V
> dddd8bf614e2 arm64: dts: rockchip: Add ethernet0 alias to the dts for RK3588(S) boards
> e79626358af1 arm64: dts: rockchip: Add ethernet0 alias to the dts for RK3566 boards
> c2bbb4cb37ce arm64: dts: rockchip: Remove ethernet0 alias from the SoC dtsi for PX30
> 5df2cd229ef2 arm64: dts: rockchip: Remove ethernetX aliases from the SoC dtsi for RK3328
> 773747ea9224 arm64: dts: rockchip: Remove ethernet0 alias from the SoC dtsi for RK3368
> c47780f2190d arm64: dts: rockchip: Remove ethernet0 alias from the SoC dtsi for RK3399
> 0e5a28940713 arm64: dts: rockchip: make dts use gpio-fan matrix instead of array
> 51d3d03836a0 arm64: dts: rockchip: add gpio alias for gpio dt nodes
> 5fcf2d67aa35 arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU
> 80e922961b8e arm64: dts: rockchip: add rk3588 spi aliases to soc dtsi
> 8f3fbd13ee16 arm64: dts: rockchip: add rk3588 gpio aliases to soc dtsi
> 15b3dffcbe21 arm64: dts: rockchip: add rk3588 i2c aliases to soc dtsi
> 095c6f3ed2af arm64: dts: rockchip: move rk3588 serial aliases to soc dtsi
> 5dc789289ead arm64: dts: rockchip: add Theobroma Jaguar SBC
> bc75d639d8bd dt-bindings: arm: rockchip: Add Theobroma-Systems Jaguar SBC
> 3c240c87c027 arm64: dts: rockchip: Add Powkiddy X55
> 2496d275584a dt-bindings: arm: rockchip: Add Powkiddy X55
> 517f4adf026d arm64: dts: rockchip: add USB3 host to rock-5a
> d474a82f6b8f arm64: dts: rockchip: add USB3 host to rock-5b
> 4bf4fdf576e0 arm64: dts: rockchip: add missing tx/rx-fifo-depth for rk3328 gmac
> 56e0ff652ec1 arm64: dts: rockchip: add gpio-line-names to rk3308-rock-pi-s
> 36bdcd2e79dd ARM: dts: rockchip: add hdmi-connector node to rk3036-kylin
> bd117185d559 ARM: dts: rockchip: fix rk3036 hdmi ports node
> 2127f8eafedb dt-bindings: clock: google,gs101: fix incorrect numbering and DGB suffix
> fff73dbf51fc dt-bindings: soc: samsung: usi: add google,gs101-usi compatible
> 37ffa8542576 dt-bindings: serial: samsung: Make samsung,uart-fifosize a required property
> fd8ed4626aeb dt-bindings: serial: samsung: Add google-gs101-uart compatible
> 33bfe5e1dc68 dt-bindings: watchdog: Document Google gs101 watchdog bindings
> e6381c01b68b riscv: dts: thead: Enable LicheePi 4A eMMC and microSD
> 3bd0505c030a riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
> a53de85228bf riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
> fd1214b13ed4 ARM: dts: microchip: sama5d27_som1_ek: Remove mmc-ddr-3_3v property from sdmmc0 node
> 5d2956b92dea dt-bindings: interrupt-controller: mpm: Pass MSG RAM slice through phandle
> 402b4259739c dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S
> 150ddb24b2f0 Merge tag 'coresight-next-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
> 64011b700499 dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
> a5ab14d25e79 dt-bindings: arm-smmu: Add compatible for X1E80100 SoC
> aaa9819e17c5 dt-bindings: iommu: arm,smmu: document the SM8650 System MMU
> c04ccbbeb58a dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
> b73f681e020f arm64: dts: juno: Align thermal zone names with bindings
> 8762e182cc34 dt-bindings: hwmon: Add lltc ltc4286 driver bindings
> 7711cd743748 Merge tag 'exynos-drm-next-for-v6.7-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into exynos-drm-next
> 0c9c816dddb4 Backmerge tag 'v6.7-rc5' into drm-next
> cc330eac5dd3 dt-bindings: iio: humidity: Add TI HDC302x support
> 07a88600291a dt-bindings: iio: light: add ltr390
> a803f8c65ec8 dt-bindings: iio: pressure: add honeywell,hsc030
> 49600f0eeb26 dt-bindings: iio: temperature: add MLX90635 device
> 5f69a9e8d3dd dt-bindings: hwmon: Increase max number of io-channels
> 565f404ae838 dt-bindings: hwmon: Add mps mp5990 driver bindings
> ad5cba1ee29a ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8650 LPASS WSA
> 880126e66fb3 ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8650 LPASS VA
> 19ed8a218bd9 ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8650 LPASS TX
> 322423704418 ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8650 LPASS RX
> f09397ff6cbf dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
> 6263d2ffbb0f dt-bindings: dma: sf-pdma: add new compatible name
> 7581e8bd108d arm64: dts: mediatek: mt8192: Add Smart Voltage Scaling node
> de53c9a33f27 arm64: dts: mediatek: mt8195: Add SVS node and reduce LVTS_AP iospace
> 53ceb33cc2de arm64: dts: mediatek: mt8183: Change iospaces for thermal and svs
> d305525393a4 arm64: dts: mediatek: mt8186: fix address warning for ADSP mailboxes
> d4dbd2b56a9f arm64: dts: mediatek: mt8186: Fix alias prefix for ovl_2l0
> 209e23166717 arm64: dts: mt6358: Drop bogus "regulator-fixed" compatible properties
> b5aaf3dc3cc4 arm64: dts: mt8183: kukui-jacuzzi: Drop bogus anx7625 panel_flag property
> aef30bad7a04 arm64: dts: Add MediaTek MT8188 dts and evaluation board and Makefile
> c8d764a0bbc6 dt-bindings: soc: mediatek: pwrap: Modify compatible for MT8188
> 1b35e3cf8066 dt-bindings: arm: mediatek: Add mt8188 pericfg compatible
> 7e4914880550 dt-bindings: arm: Add compatible for MediaTek MT8188
> c4c85ca7297e arm64: dts: mediatek: mt8195: add DSI and MIPI DPHY nodes
> e7300ae6b913 dt-bindings: display: mediatek: dsi: add compatible for MediaTek MT8195
> cebba0dd1a01 arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
> 8ac8be12ac45 dt-bindings: arm: mediatek: convert audsys and mt2701-afe-pcm to yaml
> 275042f3fe7b arm64: dts: mediatek: mt8195: add MDP3 nodes
> aba1f17e7acc arm64: dts: mediatek: mt8195: revise VDOSYS RDMA node name
> 7032d5f144c2 arm64: dts: mediatek: mt8183: correct MDP3 DMA-related nodes
> 22bae315e031 dt-bindings: display: mediatek: padding: add compatible for MT8195
> 751c1a1076cb dt-bindings: display: mediatek: split: add compatible for MT8195
> e2f195c9941b dt-bindings: display: mediatek: ovl: add compatible for MT8195
> 98aa994aefee dt-bindings: display: mediatek: merge: add compatible for MT8195
> 6f5d6cbaa3f9 dt-bindings: display: mediatek: color: add compatible for MT8195
> ef86984ae659 dt-bindings: display: mediatek: aal: add compatible for MT8195
> 8f6efe19695a dt-bindings: media: mediatek: mdp3: add component TDSHP for MT8195
> f3a2d9b01651 dt-bindings: media: mediatek: mdp3: add component TCC for MT8195
> 9952a02bb5ee dt-bindings: media: mediatek: mdp3: add component STITCH for MT8195
> 6c49acbc4134 dt-bindings: media: mediatek: mdp3: add component HDR for MT8195
> d6fdbfb3b4ad dt-bindings: media: mediatek: mdp3: add component FG for MT8195
> a7d6e829425b dt-bindings: media: mediatek: mdp3: add compatible for MT8195 WROT
> 7db0370c2d66 dt-bindings: media: mediatek: mdp3: add compatible for MT8195 RSZ
> 5620ceb8b6ca dt-bindings: media: mediatek: mdp3: add config for MT8195 RDMA
> 8f056e0ef45c dt-bindings: media: mediatek: mdp3: merge the indentical RDMA under display
> c2d8940ef6fd dt-bindings: media: mediatek: mdp3: correct RDMA and WROT node with generic names
> 4347ab16a815 media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
> e14664bd10f6 arm64: dts: mediatek: mt8195-cherry: Assign sram supply to MFG1 pd
> 0561502a0693 arm64: dts: mediatek: mt8195-cherry: Add MFG0 domain supply
> 08b52bb4b076 dt-bindings: reset: mt8188: Add VDOSYS reset control bits
> 10fbcb9df4e2 dt-bindings: arm: mediatek: Add compatible for MT8188
> 88c996595db3 dt-bindings: display: mediatek: padding: Add MT8188
> ca5643fef42b dt-bindings: display: mediatek: merge: Add compatible for MT8188
> ae3b78a94c61 dt-bindings: display: mediatek: mdp-rdma: Add compatible for MT8188
> 744464b66c7e dt-bindings: display: mediatek: ethdr: Add compatible for MT8188
> 01b1569a2d88 dt-bindings: thermal: convert Mediatek Thermal to the json-schema
> 90d08ec14e3c arm64: dts: mt8183: Add jacuzzi pico/pico6 board
> 5df3f176b5bf dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-pico
> 281ab3bf124c arm64: dts: mt8183: Add jacuzzi makomo board
> 52cfc0fd5dd9 dt-bindings: arm64: mediatek: Add mt8183-kukui-jacuzzi-makomo
> 19dd875d8e0a arm64: dts: mt8183: Add kukui katsu board
> b8dd2f8c3e1c dt-bindings: arm64: mediatek: Add mt8183-kukui-katsu
> 9a6a916f0bc6 arm64: dts: mediatek: Move MT6358 PMIC interrupts to MT8183 boards
> 3f27ea46dc3d arm64: dts: mediatek: Use interrupts-extended where possible
> ad0c69fd2fa3 arm64: dts: mediatek: mt8173: Use interrupts-extended where possible
> c82e8139aeaa arm64: dts: mediatek: mt8183: Use interrupts-extended where possible
> d8a485fe96f7 dt-bindings: soc: mediatek: add mt8186 and mt8195 svs dt-bindings
> e66d619c0c3a dt-bindings: arm: mediatek: mmsys: Add VPPSYS compatible for MT8188
> 5e6b938fc74f arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
> e90ef555e054 arm64: dts: mediatek: mt8183: Add decoder
> 0f0ccec6cc8d arm64: dts: mediatek: mt8173: Drop VDEC_SYS reg from decoder
> b6aed11d9548 arm64: dts: mediatek: cherry: Add platform thermal configuration
> 86760b83d52b dt-bindings: display: simple: Add AUO G156HAN04.0 LVDS display
> a9ddc30ef584 dt-bindings: display: panel: Add Ilitek ili9805 panel controller
> defac25462fb dt-bindings: display: st7701: Add Anbernic RG-ARC panel
> 336bc0e68db2 dt-bindings: display: panel: add Fascontek FS035VG158 panel
> 955ce81826fb dt-bindings: vendor-prefixes: Add fascontek
> 752a79b7aaef dt-bindings: display: panel: Clean up leadtek,ltk035c5444t properties
> 770aea203c16 Merge 6.7-rc5 into tty-next
> 34ef5edc5b88 Merge 6.7-rc5 into usb-next
> 621073890e71 Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64
> bf94b2d5359e arm64: dts: exynos: add minimal support for exynosautov920 sadk board
> e9fd8cf1d2d8 arm64: dts: exynos: add initial support for exynosautov920 SoC
> d0863d30608a dt-bindings: pinctrl: samsung: correct ExynosAutov920 wake-up compatibles
> 9bdf0db8ae4b dt-bindings: samsung: exynos-sysreg: combine exynosautov920 with other enum
> 5b54324e6d5b dt-bindings: dma: Drop undocumented examples
> e2fd1a08fd82 Merge remote-tracking branch 'drm-misc/drm-misc-next' into msm-next
> a04c2351b389 dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG compatibles to GS101
> 9b3c118b3d19 dt-bindings: clock: Add Google gs101 clock management unit bindings
> d97b5e938286 dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
> 6a5a439c0701 dt-bindings: pinctrl: samsung: add gs101-wakeup-eint compatible
> 10422d721886 dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
> 3a5cb767f670 media: dt-bindings: media: rkisp1: Fix the port description for the parallel interface
> 1da803cb7af8 arm64: dts: qcom: qcm6490-fairphone-fp5: Enable WiFi
> 8da528961e4e arm64: dts: qcom: qcm6490-fairphone-fp5: Enable various remoteprocs
> e6fa65e6d152 arm64: dts: qcom: sc7280: Add CDSP node
> fc9753f721c5 arm64: dts: qcom: sc7280: Add ADSP node
> c8ee1d58df76 arm64: dts: qcom: sc7280: Use WPSS PAS instead of PIL
> 52f7c413fda4 arm64: dts: qcom: qcm6490-fairphone-fp5: Enable UFS
> 4df3a7b5d504 arm64: dts: qcom: msm8953: Set initial address for memory
> 423afe7e3dcb ARM: dts: qcom: msm8226: Add GPU
> bba409f9c339 ARM: dts: qcom: Disable pm8941 & pm8226 smbb charger by default
> 7e9db953a623 arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board
> 4e3613f89c7f arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
> d8bfc2581200 dt-bindings: input: gpio-mouse: Convert to json-schema
> 2691fb7a0b13 dt-bindings: drm: rockchip: convert inno_hdmi-rockchip.txt to yaml
> 2dc455b73efa ARM: dts: samsung: exynos4210-i9100: Add accelerometer node
> 0fab2792a476 ARM: dts: samsung: exynos4210-i9100: Add node for touch keys
> 7ea4a30a8fd6 ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12
> 4cee9945012b ARM: dts: microchip: sama5d27_wlsom1_ek: Remove mmc-ddr-3_3v property from sdmmc0 node
> e76f84dfaedb arm64: dts: qcom: sm8650: Add DisplayPort device nodes
> 2cfe9148e611 arm64: dts: qcom: pm8550: drop PWM address/size cells
> 49e3d2a63a49 dt-bindings: display: mediatek: padding: Add MT8188
> 8c1a5538e89b dt-bindings: display: mediatek: merge: Add compatible for MT8188
> 29025812d6c3 dt-bindings: cache: qcom,llcc: correct QDU1000 reg entries
> 3e60d5b58b7d dt-bindings: gpu: samsung-scaler: constrain iommus and power-domains
> 1d6aee346b02 dt-bindings: gpu: samsung-g2d: constrain iommus and power-domains
> d4a84a84e922 dt-bindings: gpu: samsung: constrain clocks in top-level properties
> 1e0b14dc8237 dt-bindings: gpu: samsung: re-order entries to match coding convention
> ba50ff463c59 dt-bindings: gpu: samsung-rotator: drop redundant quotes
> 1a3c1bf5b141 dt-bindings: display: mediatek: mdp-rdma: Add compatible for MT8188
> 0a16c7e2c414 dt-bindings: display: mediatek: ethdr: Add compatible for MT8188
> 925f69a6cc7d dt-bindings: serial: qcom,msm-uartdm: Vote for shared resources
> 44f4478aa927 dt-bindings: serial: snps-dw-apb-uart: include rs485 schema
> fad4b52a0fdb arm64: dts: hisilicon: hikey970-pmic: clean up SPMI node
> 051c12eb5d46 arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
> e567127bd619 dt-bindings: hisilicon: Merge hi3620-clock into hisilicon,sysctrl binding
> 4b823f7042ef arm64: dts: qcom: x1e80100: Add Compute Reference Device
> f51679f0f817 arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts
> ca121fc146b2 dt-bindings: arm: qcom: Document X1E80100 SoC and boards
> c53c3b8c12a4 dt-bindings: arm: cpus: Add qcom,oryon compatible
> aa432318faa9 Merge branch 'icc-x1e80100' of https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into arm64-for-6.8
> 9eba2f2fb214 Merge branch '20231205061002.30759-4-quic_sibis@quicinc.com' into arm64-for-6.8
> f213e67c84b7 Merge branch '20231205061002.30759-4-quic_sibis@quicinc.com' into clk-for-6.8
> ecc521e21905 dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for X1E80100
> 079af735ef3c dt-bindings: clock: qcom: Add X1E80100 GCC clocks
> 8f4495322f78 arm64: dts: qcom: sm8650-mtp: add WSA8845 speakers
> 02b73ff63440 arm64: dts: qcom: sm8650: add Soundwire controllers
> e6679602ac09 arm64: dts: qcom: sm8650: add ADSP audio codec macros
> 5c0a5d9640c3 arm64: dts: qcom: sm8650: add LPASS LPI pin controller
> 7f6211cc8e63 arm64: dts: qcom: sm8650: add ADSP GPR
> b72a9e98977b arm64: dts: qcom: sm8650-qrd: enable IPA
> 13bdc41575ab arm64: dts: qcom: sm8650: add IPA information
> 0fd767d395a1 arm64: dts: qcom: sm8650-qrd: add interconnect dependent device nodes
> d68c8f7f237a arm64: dts: qcom: sm8650-mtp: add interconnect dependent device nodes
> 900a28b939d2 arm64: dts: qcom: sm8650: add interconnect dependent device nodes
> ff01973261d0 arm64: dts: qcom: sm8650: add initial SM8650 QRD dts
> 185ce15a620b arm64: dts: qcom: sm8650: add initial SM8650 MTP dts
> 487b5dde17e2 arm64: dts: qcom: pm8550ve: make PMK8550VE SID configurable
> 61ff00c8e1de arm64: dts: qcom: add initial SM8650 dtsi
> 7266e49a2f3e dt-bindings: arm: qcom: document SM8650 and the reference boards
> 34a104c65fa9 Merge branch 'icc-sm8650' of https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into arm64-for-6.8
> dc9c79dc36cc Merge branch '20231106-topic-sm8650-upstream-clocks-v3-5-761a6fadb4c0@linaro.org' into arm64-for-6.8
> 482bf7559678 Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 89cdcbe73e3a dt-bindings: display: msm: dp-controller: document SM8650 compatible
> 6457d6362b66 docs: dt-bindings: add DTS Coding Style document
> 17bd76b0dcba ARM: dts: rockchip: add gpio alias for gpio dt nodes
> 1e3bf6cdb555 dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: Clean up example
> ebf62e0e08ff dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: Fix regulator binding
> ff778a37f71a dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: Fix up binding reference
> 60bfc8c9aef9 dt-bindings: firmware: qcom,scm: Allow interconnect for everyone
> ae3daad140cd arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial device tree
> 3ab4a6461f9d dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
> a4229e4b1bf7 arm64: dts: qcom: sm8550-qrd: enable IPA
> 0b02bd1a7f8b arm64: dts: qcom: sm8550: add IPA information
> 1d704f347212 dt-bindings: firmware: qcom,scm: document SCM on X1E80100 SoCs
> a07e2c07074c dt-bindings: arm: qcom-soc: extend pattern matching for X1E80100 SoC
> 190053cb1ce8 arm64: dts: qcom: minor whitespace cleanup around '='
> e5d9eb69d255 ARM: dts: qcom: minor whitespace cleanup around '='
> a12829c0d5ea arm64: dts: qcom: ipq8074: Add QUP4 SPI node
> 81c5f29af493 arm64: dts: qcom: qdu1000: Add ECPRI clock controller
> 7f8d2a160503 Merge branch '20231123064735.2979802-2-quic_imrashai@quicinc.com' into clk-for-6.8
> a7b1e49f140b dt-bindings: clock: qcom: Add ECPRICC clocks for QDU1000 and QRU1000
> 0d8365b85a68 ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
> 4e5dc5d2a1e5 arm64: dts: qcom: sm8550: fix USB wakeup interrupt types
> b0dd9226dd63 arm64: dts: qcom: sm8150: fix USB wakeup interrupt types
> 301d240b276b arm64: dts: qcom: sm6375: fix USB wakeup interrupt types
> bcfa8e3ed274 arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
> 20a6fe5d28b2 arm64: dts: qcom: sdm670: fix USB wakeup interrupt types
> d2c7cfd6cfc3 arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types
> 6f29d799b7cf arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types
> ca84d4480b44 arm64: dts: qcom: sc7280: fix usb_1 wakeup interrupt types
> 096085135fda arm64: dts: qcom: sc7180: fix USB wakeup interrupt types
> 6c1f003cc9a1 arm64: dts: qcom: sa8775p: fix USB wakeup interrupt types
> 45bd09d633c8 arm64: dts: qcom: msm8916-longcheer-l8150: Add battery and charger
> 195857e6f299 arm64: dts: qcom: pm8916: Add BMS and charger
> 6caacf1f1bd3 arm64: dts: qcom: sc7280: Add 0xac Adreno speed bin
> 3ddcb3a31e24 arm64: dts: qcom: sc7280: Mark Adreno SMMU as DMA coherent
> b8bf84b9efc0 arm64: dts: qcom: sc7280: Fix up GPU SIDs
> 0830942e59a4 arm64: dts: qcom: sc7280: Add ZAP shader support
> 6a2b85d201c9 dt-bindings: arm: qcom-soc: extend pattern for matching existing SoCs
> ddd782c9e1e9 dt-bindings: cache: qcom,llcc: Add X1E80100 compatible
> 573141bcc2f7 arm64: dts: qcom: sdx75-idp: Enable USB3 and PHY support
> 93789523f679 arm64: dts: qcom: Add USB3 and PHY support on SDX75
> ddc8552a97e0 arm64: dts: qcom: Add interconnect nodes for SDX75
> 2f6480d75792 arm64: dts: qcom: sm8350: Fix remoteproc interrupt type
> 22ab1e4b96e5 arm64: dts: qcom: pm8350k: Remove hanging whitespace
> 648dd7cb906d arm64: dts: qcom: sm8350: Fix DMA0 address
> aa5e755d7246 dt-bindings: iio: adc: qcom: Add Qualcomm smb139x
> aee24a669374 arm64: dts: qcom: sc8180x: align APSS with bindings
> c51b52a3c7aa arm64: dts: qcom: sm6375-pdx225: add fixed touchscreen AVDD regulator
> 714c2d01cb79 arm64: dts: qcom: sm6125: add interrupts to DWC3 USB controller
> 869ed2bf0b06 arm64: dts: qcom: sm6115: align mem timer size cells with bindings
> 5b01a3bc4e38 arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
> abcbd3630645 arm64: dts: qcom: sc8180x-primus: use 'gpios' suffix for PCI GPIOs
> 5281b1e2c756 arm64: dts: qcom: sc8180x-flex-5g: use 'gpios' suffix for PCI GPIOs
> dbf927ecfde3 arm64: dts: qcom: sdm845: correct Soundwire node name
> 27d49e38f5d4 arm64: dts: qcom: sdm845-db845c: correct LED panic indicator
> 85591f38ba27 arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator
> 65b61add6d70 arm64: dts: qcom: sm8250: Add wakeup-source to usb_1 and usb_2
> 343c9084fd53 arm64: dts: qcom: sdm850-lenovo-yoga: Add wakeup-sources
> eb9d72ac20a4 arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin
> e4828a6315b4 arm64: dts: qcom: sm8350: move DPU opp-table to its node
> cfa2fb4b7f5b arm64: dts: qcom: sc8280xp-x13s: drop sound-dai-cells from eDisplayPort
> 927e9926b48f arm64: dts: qcom: sc8180x-primus: drop sound-dai-cells from eDisplayPort
> ca8a02834a8f arm64: dts: qcom: sm8250: correct Soundwire node name
> 682a341c0cdc arm64: dts: qcom: sc8280xp: correct Soundwire node name
> 13f2dbc0a9cb arm64: dts: qcom: qdu1000-idp: drop unused LLCC multi-ch-bit-off
> 6cda67d14000 arm64: dts: qcom: qdu1000: correct LLCC reg entries
> 208a56e344a2 arm64: dts: qcom: sm8450: fix soundwire controllers node name
> c7bee631d3e9 arm64: dts: qcom: sm8550: fix soundwire controllers node name
> 255ca7c95406 Merge branch '20231106-topic-sm8650-upstream-clocks-v3-5-761a6fadb4c0@linaro.org' into clk-for-6.8
> 52721c372031 dt-bindings: clock: qcom: Document the SM8650 RPMH Clock Controller
> a8430c36d8bc dt-bindings: clock: qcom: document the SM8650 GPU Clock Controller
> e39f08bf115a dt-bindings: clock: qcom: document the SM8650 Display Clock Controller
> 076aa9fc05f3 dt-bindings: clock: qcom: document the SM8650 General Clock Controller
> abeff2c9f476 dt-bindings: clock: qcom: document the SM8650 TCSR Clock Controller
> 3714369ceebb dt-bindings: cache: qcom,llcc: Document the SM8650 Last Level Cache Controller
> cb0f1e272d52 dt-bindings: clock: qcom,gcc-msm8939: Add CSI2 related clocks
> 7ee4127b7a3f arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
> d380ef670205 Merge branch '20231026105345.3376-3-bryan.odonoghue@linaro.org' into arm64-for-6.8
> 30a292de3f9a Merge branch '20231026105345.3376-3-bryan.odonoghue@linaro.org' into clk-for-6.8
> f007e023cbd5 dt-bindings: clock: Add SC8280XP CAMCC
> aec8967c6dce dt-bindings: clock: Use gcc.yaml for common clock properties
> 7c1eb93bd0d3 dt-bindings: clock: qcom,gcc-ipq6018: split to separate schema
> b6364ec8f82d dt-bindings: arm: qcom,ids: Add SoC ID for SM8650
> 3f482ad7991e arm64: dts: qcom: sm8550: Enable download mode register write
> fe077e894545 arm64: dts: qcom: sm8350: Add TCSR halt register space
> 956699ec82d4 arm64: dts: qcom: sm8250: Add TCSR halt register space
> e0bd046de230 arm64: dts: qcom: ipq5018: add few more reserved memory regions
> c38c43d3b995 arm64: dts: qcom: ipq5332: add missing properties to the GPIO LED node
> 0390c1ee5e11 arm64: dts: qcom: ipq9574: enable GPIO based LED
> 2f9b91c0cf6d arm64: dts: qcom: qrb2210-rb1: use USB host mode
> 2196010939c0 dt-bindings: firmware: qcom,scm: document SM8650 SCM Firmware Interface
> ae8a176c474a dt-bindings: soc: qcom: pmic-glink: document SM8650 compatible
> c3cb68af1e5d dt-bindings: soc: qcom,aoss-qmp: document the SM8560 Always-On Subsystem side channel
> a6ea4114f911 dt-bindings: mmc: mtk-sd: add tuning steps related property
> 30e4bc60ac6d dt-bindings: mfd: ti,am3359-tscadc: Allow dmas property to be optional
> 5c51588d48df dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
> a03962f53dbd dt-bindings: mfd: qcom-spmi-pmic: Document PM8937 PMIC
> 81a2c830f173 dt-bindings: mfd: qcom,tcsr: Add compatible for sm8250/sm8350
> fe50e0fb05fc dt-bindings: mfd: ams,as3711: Convert to json-schema
> 197c27b6cfaa arm64: dts: fsd: add specific compatibles for Tesla FSD
> 395fa67b6b72 Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64
> 5927c83d20c8 dt-bindings: watchdog: samsung: add specific compatible for Tesla FSD
> 78e4ed4670d7 dt-bindings: samsung: exynos-pmu: add specific compatible for Tesla FSD
> c168df69f5a1 dt-bindings: serial: samsung: add specific compatible for Tesla FSD
> 6dedf66f0e8b dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
> 457e5d03f14d dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
> 4b7a14529669 dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
> a135e0045af7 dt-bindings: mmc: arasan,sdci: Add gate property for Xilinx platforms
> d0ed6c92c98e dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
> f7a9df14027b dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
> b81aa4a5992d media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
> b80f939c4051 dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples
> 44c4f2c40551 dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
> c57fab0a68f9 dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
> f330b6a06a10 dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
> d089bb38e3f6 dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
> d92310a0b805 dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
> 6afb70912c0a Merge tag 'renesas-dts-for-v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
> 77be7b2ec3d6 arm64: dts: ti: Add verdin am62 mallow board
> 5fe3785a98a1 dt-bindings: arm: ti: Add verdin am62 mallow board
> 7bf01a4e3239 ASoC: dt-bindings: fsl,xcvr: Adjust the number of interrupts
> 568ee5fdf77d dt-bindings: interconnect: Add Qualcomm SM6115 NoC
> 7549b7adec53 arm64: dts: ti: verdin-am62: Improve spi1 chip-select pinctrl
> 0b160138fdcc arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Remove HDMI Reset Line Name
> 42aed107725d arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add HDMI support
> 766ac2241c85 arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Lower I2C1 frequency
> bcf7dd5b8b09 arm64: dts: ti: phycore-am64: Add R5F DMA Region and Mailboxes
> e1dfb1eb87a4 riscv: dts: microchip: add the mpfs' system controller qspi & associated flash
> 59d2f723c14b dt-bindings: soc: microchip: add a property for system controller flash
> 4b452a4cfa9e ARM: dts: imx23/28: Remove undocumented "fsl,clkctrl"
> 485e1601cd25 ARM: dts: bcm2711: Add BCM2711 xHCI support
> 439353e944b0 dt-bindings: usb: xhci: Add support for BCM2711
> 4b95e8b40522 ARM: dts: imx28-lwe: Pass device_type to the memory node
> ea0431aa1757 ARM: dts: imx23/28: Remove unneeded "fsl,mxs-gpio"
> e63738dd96c8 ARM: dts: imx28-tx28: Pass #sound-dai-cells
> fc88878c01c0 arm64: dts: imx8mq-phanbell: make dts use gpio-fan matrix instead of array
> e21fe3809cd3 arm64: dts: freescale: verdin-imx8mp: add support to mallow board
> a75cfdc4a966 arm64: dts: freescale: verdin-imx8mm: add support to mallow board
> 3b7bee60295f arm64: dts: imx8mm-venice-gw7: Adjust PCI Ethernet nodes
> 5241ecb06203 dt-bindings: arm: fsl: add verdin imx8mp mallow board
> b80ecc880136 dt-bindings: arm: fsl: add verdin imx8mm mallow board
> ad1ae2498610 arm64: dts: imx8mm: Slow default video_pll1 clock rate
> 5aa830cec5a3 arm64: dts: imx8mm: Remove video_pll1 clock rate from clk node
> 110274d03548 arm64: dts: imx8mm: Simplify mipi_dsi clocks
> 99d898689e0b ARM: dts: imx7s: Add on-chip memory
> 29d17af3b09b ARM: dts: imx7: add MIPI-DSI support
> d9c25edf04ae scsi: ufs: dt-bindings: Add msi-parent for UFS MCQ
> dba1025f17d0 ARM: dts: nxp: Fix some common switch mistakes
> 4ea7b578957d arm64: dts: freescale: minor whitespace cleanup around '='
> dbb52d93894b arm64: dts: imx8dxl-ss-ddr: change ddr_pmu0 compatible
> 941d70d2ae55 arm64: dts: tqma8mpql: Remove invalid/unused property
> ec00a410133c arm64: dts: imx8-ss-audio: Remove unexistent'shared-interrupt'
> 604139ed79f6 arm64: dts: imx93: Remove unexistent 'shared-interrupt'
> 7a445842e287 arm64: dts: imx8qxp-mek: Fix gpio-sbu-mux compatible
> 0c2122b767be arm64: dts: imx8mp-debix-model-a: Use phy-mode
> 2e9827c5e054 arm64: dts: imx8mm-nitrogen-r2: Fix I2C mux subnode name
> d1e22a0dfb43 arm64: dts: imx8dxl-ss-conn: Fix Ethernet interrupt-names order
> 6299d7ae35e5 arm64: dts: imx8mm-emcon-avari: Fix gpio-cells
> 9de3f32f3c7d arm64: dts: imx8qm-ss-dma: Pass lpuart dma-names
> 6905c613057b arm64: dts: freescale: Add SKOV IMX8MP CPU revB board
> b20a05f3b464 arm64: dts: imx8mn-var-som-symphony: add vcc supply for PCA9534
> a5a6af3c0bdd arm64: dts: freescale: introduce rve-gateway board
> 83600000758e arm64: dts: freescale: debix-som-a-bmb-08: Add CSI Power Regulators
> b5e632bcd082 arm64: dts: imx8-apalis: add can power-up delay on ixora board
> 9804057f0f96 arm64: dts: imx8mn-var-som: add fixed 3.3V regulator for EEPROM
> e3c93255cfdb arm64: dts: imx8mm-venice-gw7: Fix pci sub-nodes
> 8357f0b7ae64 arm64: dts: imx8mp: Disable dsp reserved memory by default
> 3b2b78d127df arm64: dts: imx8mp: Add NPU Node
> b13969aeeefc arm64: dts: freescale: debix-som: Add heartbeat LED
> 5c6068a3aecc arm64: dts: freescale: Add dual-channel LVDS overlay for TQMa8MPxL
> 37dbfb74c066 arm64: dts: imx8mp-venice-gw74xx: remove unecessary propreties in tpm node
> 12f50b18b3a5 ARM: dts: nxp: minor whitespace cleanup around '='
> 7e4a296e0073 ARM: dts: imx7d-colibri-emmc: Add usdhc aliases
> aac483d2d190 ARM: dts: imx6qdl-colibri: Add usdhc aliases
> 534d21c04c41 ARM: dts: imx6qdl-apalis: Add usdhc aliases
> 4105f51d0c63 ARM: dts: nxp: imx7d-pico: add cpu-supply nodes
> 4a5f36c1120b dt-bindings: arm: Add compatible for SKOV i.MX8MP RevB board
> 7efe4371f644 dt-bindings: arm: fsl: add RVE gateway board
> 3c86e357feb0 dt-bindings: vendor-prefixes: add rve
> 04660a3dbd9f ARM: dts: broadcom: Add BCM63138's high speed UART
> 2e36ee7e60cd arm64: dts: ti: k3-am62x: Add overlay for IMX219
> 8478bfdedc00 arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
> a361c10e44cc arm64: dts: ti: k3-am62x: Add overlays for OV5640
> 820399f7bf0f arm64: dts: ti: k3-am62x-sk: Enable camera peripherals
> 4de948eeb982 arm64: dts: ti: k3-am625-beagleplay: Add overlays for OV5640
> 8d6be01e5e7c arm64: dts: ti: k3-am62a-main: Enable CSI2-RX
> d52951f9d78a arm64: dts: ti: k3-am62-main: Enable CSI2-RX
> 4d667e27b3fd arm64: dts: ti: k3-am65: Add AM652 dtsi file
> 3d2161ed0c2b dt-bindings: perf: fsl-imx-ddr: Add i.MX8DXL compatible
> 189fe310f16e dt-bindings: clock: support i.MX93 ANATOP clock module
> b44d3f817227 ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)
> b654e96c546e dt-bindings: display: simple: add Evervision VGG644804 panel
> 05a02c1a58e1 dt-bindings: ili9881c: Add Ampire AM8001280G LCD panel
> 96be0427a528 ARM: dts: rockchip: Move uart aliases to SoC dtsi for RK3128
> 18c0b8b47af4 ARM: dts: rockchip: Move i2c aliases to SoC dtsi for RK3128
> 0191774d40bb ARM: dts: rockchip: Move gpio aliases to SoC dtsi for RK3128
> 4b6344ed1b32 ARM: dts: rockchip: Add Sonoff iHost Smart Home Hub
> 3cbab293b053 dt-bindings: arm: rockchip: Add Sonoff iHost
> afacdf8be4db ARM: dts: rockchip: Add rv1109 SoC
> ad1e5ad721a5 ARM: dts: rockchip: Split up rgmii1 pinctrl on rv1126
> fc0ef88ee0a1 ARM: dts: rockchip: Add i2c2 node to rv1126
> bf739d2f67ae ARM: dts: rockchip: Serial aliases for rv1126
> 049605e5080d ARM: dts: rockchip: Add alternate UART pins to rv1126
> 59e8d345382e ARM: dts: rockchip: Enable GPU for XPI-3128
> 464bddcf0726 ARM: dts: rockchip: Add GPU node for RK3128
> 8af06043d850 ARM: dts: rockchip: Add power-controller for RK3128
> 8f65bb97112e dt-bindings: display: himax-hx8394: Add Powkiddy X55 panel
> ed2d8407a82d dt-bindings: display: Document Himax HX8394 panel rotation
> 5319f5062c10 dt-bindings: display: simple: Add boe,bp101wx1-100 panel
> db09be0ff97b ARM: dts: imx6q-apalis: add can power-up delay on ixora board
> 31fdbd1cd6c6 dt-bindings: display: msm: document the SM8650 Mobile Display Subsystem
> 52e16372d1c6 dt-bindings: display: msm: document the SM8650 DPU
> 258f55b8a6c7 dt-bindings: display: msm-dsi-controller-main: document the SM8650 DSI Controller
> f06034e33173 dt-bindings: display: msm-dsi-phy-7nm: document the SM8650 DSI PHY
> e7cafbdafccf dt-bindings: display: msm: Add SDM670 MDSS
> 58504ed9c645 dt-bindings: display/msm: sdm845-dpu: Describe SDM670
> d8b80f6fd0c5 dt-bindings: display/msm: dsi-controller-main: add SDM670 compatible
> 0c71ce621111 arm64: dts: ti: k3-am625-beagleplay: Use UART name in pinmux name
> 0895f560a171 arm64: dts: ti: k3-am62a7-sk: Add interrupt support for IO Expander
> 696f6e8d6176 arm64: dts: ti: k3-am625-verdin: Enable Verdin UART2
> 145b9a5ffb00 arm64: dts: ti: k3-am62-main: Add gpio-ranges properties
> 0d95f5e22dde arm64: dts: ti: k3-am64: Enable SDHCI nodes at the board level
> 8ccabbb5322f arm64: dts: ti: k3-am65: Enable SDHCI nodes at the board level
> 4b9d0ee63df8 arm64: dts: ti: k3-am65: Add full compatible to dss-oldi-io-ctrl node
> b64af72b8e7b arm64: dts: ti: k3-j784s4: Add chipid node to wkup_conf bus
> a70ca898f980 arm64: dts: ti: k3-j721s2: Add chipid node to wkup_conf bus
> 638e0242808a arm64: dts: ti: k3-j721e: Add chipid node to wkup_conf bus
> 0b0e18c3dce2 arm64: dts: ti: k3-j7200: Add chipid node to wkup_conf bus
> 16b21e3cf2ea arm64: dts: ti: k3-am65: Add chipid node to wkup_conf bus
> ba6541592794 dt-bindings: iio: light: isl76682: Document ISL76682
> 3678e1e114f2 dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: add X1E80100 LPASS LPI
> 4854bb4b43e2 dt-bindings: pinctrl: pinctrl-single: add ti,j7200-padconf compatible
> 062b01e5c736 dt-bindings: iio: light: add support for Vishay VEML6075
> 3f170ed89d6f dt-bindings: usb: tps6598x: add reset-gpios property
> 69a424bfd498 dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete example
> 5cf3c6e7327b dt-bindings: adi,ad5791: Add support for controlling RBUF
> 7a11d1470ed1 dt-bindings: display: bridge: lt8912b: Add power supplies
> 562bb8392ec6 spi: spl022: fix sleeping in interrupt context
> 83c535a1ec6b dt-bindings: iio: honeywell,mprls0025pa: drop ref from pressure properties
> 7cb202a1a899 dt-bindings: media: add bindings for stm32 dcmipp
> fce776c784a0 dt-bindings: media: Add bindings for THine THP7312 ISP
> 23c5bf41000e dt-bindings: media: i2c: add galaxycore,gc2145 dt-bindings
> e6429afd32f1 dt-bindings: vendor-prefixes: Add prefix for GalaxyCore Inc.
> d1287a3d111f dt-bindings: gpio: rockchip: add a pattern for gpio hogs
> e08aefe3ce14 Merge tag 'qcom-dts-for-6.7-2' into arm32-for-6.8
> 66862cc676b1 ARM: dts: qcom: Add support for HTC One Mini 2
> ac27d4b5eaa6 Merge tag 'v6.7-rc4' into media_stage
> 8a745825682b arm64: dts: qcom: sm6350: Make watchdog bark interrupt edge triggered
> 4de273b8d5cf arm64: dts: qcom: sc8280xp: Make watchdog bark interrupt edge triggered
> 94d4ed6b0efb arm64: dts: qcom: sa8775p: Make watchdog bark interrupt edge triggered
> 9e80723d8b4f arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge triggered
> ef5fa5d97caa arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge triggered
> 3879bc4c1c04 arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
> 8e7e69e2041a arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge triggered
> 6584d8b4799e arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
> 04f80707bc19 arm64: dts: qcom: sc8180x: drop duplicated PCI iommus property
> 04597b9d0b6f dt-bindings: arm: qcom: Add HTC One Mini 2
> 7ff927ff9139 dt-bindings: vendor-prefixes: document HTC Corporation
> fa70da0426ea arm64: dts: qcom: sm8550: correct TX Soundwire clock
> ed7e07a029d6 arm64: dts: qcom: sm8450: correct TX Soundwire clock
> 541ded0776d2 arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
> 39c752cf5603 arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
> e5319a1187df arm64: dts: qcom: sdm632-fairphone-fp3: Enable LPASS
> daf6cf6a007f arm64: dts: qcom: msm8916-acer-a1-724: Add notification LED
> 2a186fbc9370 arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
> 91d98fe1640a arm64: dts: qcom: msm8939-huawei-kiwi: Add initial device tree
> 6718a893d987 dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5 (2016)
> f36c60304a90 arm64: dts: qcom: msm8953: Use non-deprecated qcom,domain in LPASS
> fa91149122fc arm64: dts: qcom: qrb2210-rb1: add wifi variant property
> 9862c76b6484 arm64: dts: qcom: qrb2210-rb1: Enable CAN bus controller
> 90510995b456 arm64: dts: qcom: qrb2210-rb1: Set up HDMI
> f168a1f5fd2a arm64: dts: qcom: qcm2290: Hook up interconnects
> a66c95bb5052 arm64: dts: qcom: qcm2290: Add display nodes
> 1b3d99e8ad9d arm64: dts: qcom: sc7280: Add the missing MDSS icc path
> 463b9cc7faa3 arm64: dts: qcom: sc7180: Add the missing MDSS icc path
> a2b32f52593b arm64: dts: qcom: sc8280xp: Add QMP handle to RPMh stats
> 0541077473ea dt-bindings: soc: qcom: stats: Add QMP handle
> 46fd383def7f arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b type-c node and enable usb otg
> 45ca7aacee21 arm64: dts: qcom: sm8250-xiaomi-elish: Fix typos
> 9dee357f1ff5 arm64: dts: qcom: msm8939-longcheer-l9100: Add proximity-near-level
> d6b8367dbb65 arm64: dts: qcom: qrb4210-rb2: Enable bluetooth
> 9e8fcdbc4d75 arm64: dts: qcom: sm6115: Add UART3
> e88a0c4a9117 arm64: dts: qcom: sdm632-fairphone-fp3: Enable WiFi/Bluetooth
> a808b8c6d7f4 dt-bindings: arm: qcom: Fix html link
> 004244e4cbd5 arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts
> 3f55e77ebc86 arm64: dts: qcom: Add base qcm6490 idp board dts
> 9e08836a864f dt-bindings: arm: qcom: Add QCM6490 IDP and QCS6490 RB3Gen2 board
> c538a9224903 arm64: dts: qcom: sm4450-qrd: mark QRD4450 reserved gpios
> 34764956c2e4 arm64: dts: qcom: sm4450-qrd: add QRD4450 uart support
> b5fe030e21e0 arm64: dts: qcom: sm4450: add uart console support
> 76478ce29df3 arm64: dts: qcom: sm4450: Add RPMH and Global clock
> 52ea11ee57e9 arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db node
> d42f9497ccad arm64: dts: qcom: ipq8074: pass QMP PCI PHY PIPE clocks to GCC
> 9b98d0a1718e dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE clocks
> 2417b30e3609 arm64: dts: qcom: msm8953: add SPI interfaces
> 66dd2b49a0b3 arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7325 thermals
> 0b651704285a arm64: dts: qcom: qcm6490-fairphone-fp5: Add PMK7325 thermals
> 8630d7baedf5 arm64: dts: qcom: qcm6490-fairphone-fp5: Add PM7250B thermals
> 959371b1b650 iio: adc: Add PM7325 PMIC7 ADC bindings
> b1e6472aae24 arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
> 6aeff20d0bd6 arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
> e8d1d500097e ARM: dts: qcom: msm8974: Add watchdog node
> 615027dbbe1d dt-bindings: arm: qcom: drop the IPQ board types
> ebb3e763ee5b arm64: dts: qcom: ipq5018: enable the CPUFreq support
> 3ca74e9810cf dt-bindings: clock: qcom,a53pll: add IPQ5018 compatible
> dcbafe8963f4 ARM: dts: qcom: sdx65: correct SPMI node name
> 98b030d58c93 ARM: dts: qcom: sdx65: add missing GCC clocks
> 07a16205d0e0 ARM: dts: qcom: sdx65: correct PCIe EP phy-names
> fe48cd5331dc dt-bindings: display: msm: Add reg bus and rotator interconnects
> 8c1892c5f696 dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
> 7cfd5769a991 dt-bindings: display/msm: qcom, sm8150-mdss: correct DSI PHY compatible
> 91abf991ed4a dt-bindings: display/msm: qcom, sm8250-mdss: add DisplayPort controller node
> c203dee53e38 ARM: dts: rockchip: Enable gmac for XPI-3128
> a31102a06882 ARM: dts: rockchip: Add gmac node for RK3128
> d02bab784773 dt-bindings: gpu: mali-utgard: Add Rockchip RK3128 compatible
> 61b6b8e5340b dt-bindings: net: qcom,ipa: document SM8650 compatible
> a0fa8df10233 Merge tag 'renesas-pinctrl-for-v6.8-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into devel
> 6c58c6977828 dt-bindings: gpio: modepin: Describe label property
> 7f00d1c96321 dt-bindings: display: ti: Add support for am62a7 dss
> 6bed64726635 arm64: dts: ti: k3-am68-sk-base-board: Add alias for MCU CPSW2G
> f494c9948974 arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices
> 403938b5222f arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin
> 45e3b6aa9185 arm64: dts: ti: iot2050: Definitions for runtime pinmuxing
> b14c51a347fb arm64: dts: ti: iot2050: Drop unused ecap0 PWM
> 38f52ad2cea9 arm64: dts: ti: iot2050: Re-add aliases
> a84e54a6c2a0 arm64: dts: ti: k3-am62x-sk-common: Mark mcu gpio and mcu_gpio_intr as reserved
> 0baa456c51ce arm64: dts: ti: k3-am62p5-sk: Mark mcu gpio and mcu_gpio_intr as reserved
> 131aadfec025 arm64: dts: ti: k3-am642-evm/sk: Mark mcu_gpio_intr as reserved
> bbda0d8be30e arm64: dts: ti: k3-am64-main: Fix typo in epwm_tbclk node name
> 5e8876dba890 arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type
> fd78a91dedf3 arm64: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes
> 05614d5b4f00 arm64: dts: ti: minor whitespace cleanup around '='
> ca6dff24071e ARM: dts: omap4-embt2ws: Add Bluetooth
> cff0864e2eea Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 2a2ae1545117 dt-bindings: input: gpio-keys: Allow optional dedicated wakeirq
> aed93474ebc0 Merge patch series "Add Huashan Pi board support"
> 318917bad2c6 riscv: dts: sophgo: add Huashan Pi board device tree
> 8a2824be66df riscv: dts: sophgo: add initial CV1812H SoC device tree
> 3ff295494c04 riscv: dts: sophgo: cv18xx: Add gpio devices
> dfcd3e4c81d9 riscv: dts: sophgo: Separate compatible specific for CV1800B soc
> 8c5d4ad957fa dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
> e393d2e6705e dt-bindings: timer: Add SOPHGO CV1812H clint
> 65cc6be0d442 dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
> dce8266bb548 ARM: dts: omap: logicpd-torpedo: do not disguise GNSS device
> 0f0cee70a881 ARM: dts: omap4-embt2ws: enable 32K clock on WLAN
> 33dfdcf03832 ARM: dts: ti/omap: Replace deprecated extcon-usb-gpio id-gpio/vbus-gpio properties
> aa5a9a109405 dt-bindings: power: meson-g12a-power: document ISP power domain
> a9f86a1f45b5 dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
> 5024553a10f5 dt-bindings: marvell: Rewrite MV88E6xxx in schema
> ad4c44e96eec dt-bindings: net: ethernet-switch: Accept special variants
> 17baedd697fb dt-bindings: net: mvusb: Fix up DSA example
> 9c7ccdf2dc30 dt-bindings: net: dsa: Require ports or ethernet-ports
> 8adbf64f3cdd dt-bindings: input: mediatek,pmic-keys: Drop incomplete example
> cdc098b167e1 dt-bindings: input: sprd,sc27xx-vibrator: Drop incomplete example
> 0629a76a9d04 dt-bindings: correct white-spaces in examples
> 2f78b6dd5c42 dt-bindings: reset: hisilicon,hi3660-reset: Drop providers and consumers from example
> f835598ebf60 dt-bindings: arm/calxeda: drop unneeded quotes
> 0d2567437a54 dt-bindings: fsl,dpaa2-console: drop unneeded quotes
> 352ed027a423 dt-bindings: interrupt-controller: qcom,pdc: document pdc on X1E80100
> df641036bac4 dt-bindings: qcom,pdc: document the SM8650 Power Domain Controller
> 1e17b2ba4499 dt-bindings: interrupt-controller: Add SDX75 PDC compatible
> c0aff4abb03a dt-bindings: reset: imx-src: Simplify compatible schema and drop unneeded quotes
> df20c9f94014 dt-bindings: reset: qcom: drop unneeded quotes
> 1516b28c7069 dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/Five SoC
> a80bc27a0fe8 dt-bindings: reset: Add compatible and DT bindings for Amlogic C3 Reset Controller
> 0b8db84ecfc4 ASoC: Intel: Soundwire related board and match updates
> 303600aff1ef Merge v6.7-rc3 into drm-next
> d03f6dca688d arm64: dts: rockchip: Use NCM6A-IO board for edgeble-neu6b
> 2dcf7dbe2812 dt-bindings: arm: rockchip: Update edgeble-neu6 bindings
> b2a45d98f95b arm64: dts: rockchip: add USB3 host on rk3588s-orangepi-5
> 766aa3119c2f ARM: dts: motorola-mapphone: Add basic support for mz609 and mz617
> 3ea15a23d9c7 ARM: dts: motorola-mapphone: Move handset devices to a common file
> 5127524f7e6f ARM: dts: motorola-mapphone: Move LCD to common file for xt875 and xt894
> 7e16bd264a3a dt-bindings: omap: Add Motorola mapphone mz609 and mz617 tablets
> 7d420d843f98 ARM: dts: renesas: r9a06g032: Add missing space in compatible
> 0faa59be192f arm64: dts: renesas: r9a09g011: Add missing space in compatible
> 807cfe5cde5c dt-bindings: phy: add compatible for Mediatek MT8195
> c52707b1bf77 dt-bindings: phy: amlogic,g12a-mipi-dphy-analog: drop unneeded reg property and example
> 34ec5dda2a01 dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: drop text about parent syscon and drop example
> f738d7a9dfab dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
> 2c963cfa7e8e ARM: dts: renesas: armadillo800eva: Add LCD panel
> a35135dad31c dt-bindings: pinctrl: renesas: Drop unneeded quotes
> d5212619f0a0 ARM: dts: renesas: r8a7740: Add LCDC nodes
> 048bdb67a0f6 arm64: dts: renesas: draak: Move HDMI bus properties to correct node
> ab52a67f9767 arm64: dts: renesas: draak: Make HDMI the default video input
> dab3ba03f28c Merge 6.7-rc3 into usb-next
> ec6cd76a8793 arm64: dts: meson-axg: jethub-jxx add support for EEPROM
> 2da076589eac arm64: dts: amlogic: meson-axg: pinctrl node for NAND
> cdc5df918882 arm64: dts: amlogic: minor whitespace cleanup around '='
> a5dead35fc4b arm64: dts: Add watchdog node for Amlogic S4 SoCs
> 37c5369b4667 arm64: dts: Add watchdog node for Amlogic C3 SoCs
> 1d8b2a265b81 dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: add example covering meson-axg-hhi-sysctrl
> 9556e1708419 ARM: dts: imx7s: Add DMA channels for CSPI peripherals
> c1e5b6c6855f arm64: dts: imx8mp-venice-gw72xx: add TPM device
> fc1ee0050ce4 arm64: dts: imx8mm-venice-gw72xx: add TPM device
> 5a125bf20bf1 arm64: dts: imx93: update anatop node
> 292fc296ecdd arm64: dts: imx93-11x11-evk: add 12 ms delay to make sure the VDD_SD power off
> b81451d8d4d3 arm64: dts: imx93: change tuning start to get a large scan range for standard tuning
> 7ee940495143 arm64: dts: imx93-11x11-evk: set SION for cmd and data pad of USDHC
> 1b2037987962 arm64: dts: imx8mp: Describe M24C32-D write-lockable page in DH i.MX8MP DHCOM DT
> 94d5d7d36ba8 ARM: dts: imx6ul: mba6ulx: fix typo in comments
> cbbed6036bfe ARM: dts: imx6qdl: mba6: fix typo in comments
> e6c50d6fd99e arm64: dts: imx8mp-beacon-kit: Enable DSI to HDMI Bridge
> 3743277142d0 arm64: dts: imx8mm: Add CCM interrupts
> 663758efb819 arm64: dts: imx8mn: Add CCM interrupts
> 88774bafda13 arm64: dts: imx8mp: Add CCM interrupts
> e4d9f4208c6c ARM: dts: imx7s: Add missing #thermal-sensor-cells
> e4c3f040fee6 ARM: dts: imx7s: Fix nand-controller #size-cells
> 62a7c97c7c3f ARM: dts: imx7s: Fix lcdif compatible
> 9f3037b332bf ARM: dts: imx7d: Fix coresight funnel ports
> d844fe5270b1 arm64: dts: freescale: add initial device tree for MBa93xxCA starter kit
> ad161fbd54ca arm64: dts: freescale: tqma9352-mba93xxla: add 'chassis-type' property
> 8ec09c8f530c arm64: dts: imx93: Configure clock rate for audio PLL
> 9d7ba48273ea arm64: dts: imx93: Add audio device nodes
> b1553710809c dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator
> 471ace1f09be dt-bindings: gpio: brcmstb: drop unneeded quotes
> f8159413e6f1 ARM: dts: ti: keystone: minor whitespace cleanup around '='
> 381a63044158 dt-bindings: clock: g12a-clkc: add MIPI ISP & CSI PHY clock ids
> c1ad3e49f07c dt-bindings: clk: g12a-clkc: add CTS_ENCL clock ids
> c8fb56a76774 dt-bindings: dma: qcom,gpi: document the SM8650 GPI DMA Engine
> 8e868f10ea21 dt-bindings: dma: rz-dmac: Document RZ/Five SoC
> e1504d7602c0 dt-bindings: net: qcom,ipa: add SM8550 compatible
> f118e169a194 dt-bindings: dma: qcom: gpi: add compatible for X1E80100
> 11518ff4d13c dt-bindings: pinctrl: qcom: Add X1E80100 pinctrl
> d3fe1008f0c8 ASoC: dt-bindings: correct white-spaces in examples
> f9b11918132f dt-bindings: crypto: convert Inside Secure SafeXcel to the json-schema
> 52b8a84c5283 dt-bindings: dma: ti: k3-udma: Describe cfg register regions
> 9b2e4fa1e7f2 dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
> 6d91e2a3766b dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
> ea1d92699d2a dt-bindings: dma: ti: k3-*: Add descriptions for register regions
> 7cf45f021d31 arm64: dts: exynosautov9: use Exynos7 fallbacks for pin wake-up controller
> dc0e2a7e69c2 arm64: dts: exynos850: use Exynos7 fallbacks for pin wake-up controllers
> 185cc3e40c9f dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers
> 54829849af39 Merge branch 'icc-x1e80100' into icc-next
> 8e2202f335a4 dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
> 54f1f68e019b dt-bindings: interconnect: qcom-bwmon: document SM8650 BWMONs
> 4e7bf80ce812 dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm SM8650 SoC
> 615397ecb02b Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> e673bd9cbb13 dt-bindings: serial: fsl-linflexuart: change the maintainer email address
> f79b00fe4cab dt-bindings: serial: renesas,sci: Document RZ/Five SoC
> 911d5cce2a4e Merge tag 'drm-misc-next-2023-11-23' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> ab1f350663b1 dt-bindings: power: rpmpd: Update part number to X1E80100
> 6fe8e1a8dc99 dt-bindings: backlight: mp3309c: Remove two required properties
> cc4e22233cb5 dt-bindings: usb: qcom,dwc3: adjust number of interrupts on SM6125
> 9161184d7271 dt-bindings: net: renesas,ethertsn: Add Ethernet TSN
> 788d52642da4 Merge tag 'v6.7-rc2' into media_stage
> d2975fb00035 dt-bindings: gpu: Add Imagination Technologies PowerVR/IMG GPU
> 59078ccb21d1 dt-bindings: usb: qcom,dwc3: document the SM8560 SuperSpeed DWC3 USB controller
> 627316c016dd dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
> 99b07ecabc3d dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
> 0118ff6d8abd ASoC: dt-bindings: fsl,mqs: Convert format to json-schema
> 0a9a12593184 ASoC: dt-bindings: sound-card-common: List sound widgets ignoring system suspend
> 165648aad162 ARM: dts: stm32: add SPI support on STM32F746
> 8f3fa20269a0 ARM: dts: stm32: add STM32F746 syscfg clock
> dc50601ba2d8 dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
> 72d23e1de1b0 arm64: dts: imx8mp: Add reserve-memory nodes for DSP
> 9bab315d31f8 spi: axi-spi-engine improvements
> 23a75f159231 ARM: dts: stm32: use the same 3v3 for SD and DSI nodes on stm32f469-disco
> 4656437906e9 ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK3128
> 25251d661471 ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK3128
> 2d36fa2aa286 ARM: dts: rockchip: Add USB host clocks for RK3128
> 4e1bd401bbe3 ARM: dts: rockchip: Add Geniatech XPI-3128 RK3128 board
> 7e6458d9a7f3 ARM: dts: rockchip: Add sdmmc_det pinctrl for RK3128
> 12867f1ccb42 dt-bindings: arm: rockchip: Add Geniatech XPI-3128
> fda729bcbd69 arm64: dts: rockchip: Add Powkiddy RK2023
> 317a36f59e1b arm64: dts: rockchip: Update powkiddy,rgb30 include to rk2023 DTSI
> dc9a81379af6 dt-bindings: arm: rockchip: Add Powkiddy RK2023
> 70a31fd9ffa3 dt-bindings: spi: axi-spi-engine: convert to yaml
> b68504144dbe Merge tag 'drm-misc-next-2023-11-17' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> 8260e721d1b5 dt-bindings: display: nv3051d: Update NewVision NV3051D compatibles
> 0a502f9716cc arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
> eccf7ee1aefe arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
> fbd14cd9ff35 ARM: dts: microchip: sam9x60ek: Add IRQ support for ethernet PHY
> c86d9749ca2a ARM: dts: microchip: sam9x60_curiosity: Add IRQ support for ethernet PHY
> 1e1f6887a01b arm64: dts: allwinner: h616: add Orange Pi Zero 2W support
> 5795c68b5edc dt-bindings: arm: sunxi: add Orange Pi Zero 2W
> a5b7fa02fbde dt-bindings: crypto: qcom,prng: document SM8650
> 53be5450f8ac dt-bindings: crypto: qcom-qce: document the SM8650 crypto engine
> e65dc233e98b dt-bindings: crypto: qcom,inline-crypto-engine: document the SM8650 ICE
> d2a2bd80cca6 dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
> f491b5315b58 dt-bindings: Document Marvell Aquantia PHY
> 7b52e889e53f arm64: dts: rockchip: add analog audio to RK3588 EVB1
> 92de4720f37c spi: dt-bindings: renesas,rspi: Document RZ/Five SoC
> 6e54c4bd7590 ASoC: dt-bindings: renesas,rz-ssi: Document RZ/Five SoC
> 87bb03481662 dt-bindings: adis16460: Add 'spi-cs-inactive-delay-ns' property
> 91e2c8ceb4de dt-bindings: adis16475: Add 'spi-cs-inactive-delay-ns' property
> f9fe5526efd5 dt-bindings: iio: Add MCP9600 thermocouple EMF converter
> 9942ece9d870 dt-bindings: iio: imu: Add Bosch BMI323
> 49d380d6e152 dt-bindings: adc: provide max34408/9 device tree binding document
> 895869158303 dt-bindings: media: wave5: add yaml devicetree bindings
> 77bf61c28407 dt-bindings: arm: Add support for DSB MSR register
> 18adf91da0ca dt-bindings: arm: Add support for DSB element size
> 075ac55ca93b dt-bindings: phy: qcom,snps-eusb2: document the SM8650 Synopsys eUSB2 PHY
> fda8409f7058 dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: document the SM8650 QMP USB/DP Combo PHY
> b0b6815d9143 dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document the SM8650 QMP PCIe PHYs
> db24b834638a dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: document the SM8650 QMP UFS PHY
> 6a737e056a8b media: dt-bindings: Add JH7110 Camera Subsystem
> 716cbea9d35a dt-bindings: power: reset: $ref reboot-mode in nvmem-reboot-mode
> c8dedfdf167b dt-bindings: power: reset: $ref reboot-mode in syscon-reboot-mode
> 6c14a95472bb ARM: dts: samsung: s5pv210: fix camera unit addresses/ranges
> 866767db6bbb ARM: dts: samsung: exynos4: fix camera unit addresses/ranges
> f0d3848e2cef ARM: dts: samsung: exynos4x12: replace duplicate pmu node with phandle
> dc6ff9889013 dt-bindings: w1: Add AMD AXI w1 host and MAINTAINERS entry
> a8a9188e96a6 dt-bindings: power: fsl,scu-pd: Document imx8dl
> f06b78172daa dt-bindings: qcom,pdc: Add compatible for SM8550
> 7a87643120eb dt-bindings: input: samsung,s6sy761: convert to DT schema
> e4ccdd770c53 Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64
> 7b213bd80e13 dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920 compatible
> 892b87e000d2 dt-bindings: arm: samsung: Document exynosautov920 SADK board binding
> ce1b89aee7ea dt-bindings: pwm: samsung: add exynosautov920 compatible
> 5e6bd42714ad dt-bindings: serial: samsung: add exynosautov920-uart compatible
> 3ea12f0eff84 dt-bindings: samsung: usi: add exynosautov920-usi compatible
> 5b6e042a72b8 dt-bindings: samsung: exynos-pmu: add exynosautov920 compatible
> 2dff85192843 dt-bindings: samsung: exynos-sysreg: add exynosautov920 sysreg
> 3123103c12c0 dt-bindings: pinctrl: samsung: add exynosautov920
> 5b929ffdc9be arm64: dts: exynos: add gpio-key node for exynosautov9-sadk
> 6bc5effbe8dd arm64: dts: exynosautov9: add specific compatibles to several blocks
> 25addf827769 arm64: dts: exynos850: add specific compatibles to several blocks
> 5ab70c11f08f arm64: dts: exynos7885: add specific compatibles to several blocks
> f7c77a1ea95a arm64: dts: exynos7: add specific compatibles to several blocks
> 56493af64c01 arm64: dts: exynos5433: add specific compatibles to several blocks
> 3530786802b6 dt-bindings: pwm: samsung: add specific compatibles for existing SoC
> 97419692fe3c ASoC: dt-bindings: samsung-i2s: add specific compatibles for existing SoC
> 7081448ca2cf dt-bindings: iio: samsung,exynos-adc: add specific compatibles for existing SoC
> 973115e1f51f dt-bindings: gpu: arm,mali-midgard: add specific compatibles for existing Exynos SoC
> 6b99281097f0 dt-bindings: samsung: exynos-pmu: add specific compatibles for existing SoC
> a893a294345b dt-bindings: serial: samsung: add specific compatibles for existing SoC
> 2a3d0691d56f dt-bindings: rtc: s3c-rtc: add specific compatibles for existing SoC
> 7e49408d51e6 dt-bindings: pinctrl: samsung: add specific compatibles for existing SoC
> 1bb1eca74ad5 Merge drm/drm-next into drm-misc-next
> e9731895ee20 dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatibles for existing SoC
> 33b5aa8f7d9a ARM: dts: qcom: mdm9615: drop qcom, prefix from SSBI node name
> fa1f536e3df0 ARM: dts: qcom: ipq8064: drop qcom, prefix from SSBI node name
> 4e5382dc8820 ARM: dts: qcom: apq8060-dragonboard: rename mpp ADC channels to adc-channel
> 6be6ba7888ef ARM: dts: qcom: pm8921: Disable keypad by default
> 5917ae72cd70 ARM: dts: qcom: msm8974: move regulators to board files
> 551cbcd2547c ARM: dts: qcom: msm8960: drop useless rpm regulators node
> 6d9878cc6a6a ARM: dts: qcom: msm8660: move RPM regulators to board files
> d0ed11e33ba0 ARM: dts: qcom: mdm9615: move RPM regulators to board files
> 1c636116afea ARM: dts: qcom: apq8064: move RPM regulators to board files
> b9d11fecae9e ARM: dts: qcom: pm8058: switch to interrupts-extended
> e8a26b432fd4 ARM: dts: qcom: pm8018: switch to interrupts-extended
> 86831cb445f6 ARM: dts: qcom: pm8921: switch to interrupts-extended
> 6d6c0b95e077 ARM: dts: qcom: pm8058: use defined IRQ flags
> 9d0903209824 ARM: dts: qcom: pm8921: move reg property
> 6a63db48b660 ARM: dts: qcom: pm8018: move reg property
> 9d6af1dd4790 ARM: dts: qcom: pm8921: reorder nodes
> 5db5515193a6 ARM: dts: qcom: pm8058: reorder nodes
> d4df6f1babb5 ARM: dts: qcom: msm8660: split PMIC to separate dtsi files
> c56480ffb4b8 ARM: dts: qcom: mdm9615: split PMIC to separate dtsi files
> f8574d2c7c62 ARM: dts: qcom: apq8064: split PMICs to separate dtsi files
> 298695290d90 ARM: dts: qcom: msm8960: split PMIC to separate dtsi files
> 1c3c930ec46c ARM: dts: qcom: msm8960: move PMIC interrupts to the board files
> 7f5541db889f ARM: dts: qcom: msm8660: move PMIC interrupts to the board files
> 812cfe71b26a ARM: dts: qcom: mdm9615: move PMIC interrupts to the board files
> f5c8a18b7116 ARM: dts: qcom: apq8064: move PMIC interrupts to the board files
> b7510b8da2f6 ARM: dts: qcom: msm8960: fix PMIC node labels
> 6475671dcca1 ARM: dts: qcom: msm8660: fix PMIC node labels
> 4dfac4d841ef ARM: dts: qcom: mdm9615: fix PMIC node labels
> 07091c1b87fb ARM: dts: qcom: apq8064: fix PMIC node labels
> 155004433670 ARM: dts: qcom: strip prefix from PMIC files
> 21220b16b281 ARM: dts: qcom: mdm9615-wp8548-mangoh-green: group include clauses
> 3d3f8059a9f6 ARM: dts: qcom: apq8064-nexus7: move sdcc1 node to proper place
> b9d136b033b8 ARM: dts: qcom: msm8660-surf: use keypad label directly
> fc4f79da1abe ARM: dts: qcom: msm8960: introduce label for PMIC keypad
> 0e33f3448e7c ARM: dts: qcom: apq8064: correct XOADC register address
> 9bed8b24890a ARM: dts: qcom-sdx65: switch USB QMP PHY to new style of bindings
> edfbe32172f4 ARM: dts: qcom-sdx55: switch USB QMP PHY to new style of bindings
> c709366fb89e arm64: dts: qcom: sm8350: switch USB QMP PHY to new style of bindings
> 29a99a6d955d arm64: dts: qcom: sm8250: switch USB QMP PHY to new style of bindings
> e13f8dc0ea91 arm64: dts: qcom: sm8150: switch USB QMP PHY to new style of bindings
> bed6aed8ceec arm64: dts: qcom: sdm845: switch USB QMP PHY to new style of bindings
> 7cb8dff829b0 arm64: dts: qcom: msm8998: switch USB QMP PHY to new style of bindings
> 77a8ce42cb30 arm64: dts: qcom: msm8996: switch USB QMP PHY to new style of bindings
> b92a18870b3e arm64: dts: qcom: ipq8074: switch USB QMP PHY to new style of bindings
> 18dd153b1c8f arm64: dts: qcom: ipq6018: switch USB QMP PHY to new style of bindings
> ad3769d7933c Merge tag 'qcom-arm64-for-6.7-2' into arm64-for-6.8
> 8088e683c89b dt-bindings: i2c: samsung,s3c2410-i2c: add specific compatibles for existing SoC
> c15df41a0c35 dt-bindings: i2c: exynos5: add specific compatibles for existing SoC
> d755df63e9df dt-bindings: hwinfo: samsung,exynos-chipid: add specific compatibles for existing SoC
> 6f4cb3f40711 arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
> 5ddba1791b2b arm64: dts: renesas: rzg2l-smarc-som: Enable 4-bit tx support
> 75b8e7f58abe regulator: add under-voltage support (part 2)
> 791f1550a798 Add DMIC slew rate controls
> e128625eb7cb dt-bindings: pinctrl: document the SM8650 Top Level Mode Multiplexer
> c3c85cc965c8 dt-bindings: pinctrl: qcom,sm8650-lpass-lpi-pinctrl: add SM8650 LPASS
> 6da3c9fd1509 ARM: dts: renesas: marzen: Rename keyboard nodes
> 2d7a77894ba8 ARM: dts: renesas: iwg22d-sodimm: Fix stmpe node names
> f4c62eb4fbd6 arm64: dts: renesas: Add missing ADV751[13] power supply properties
> a94c426db9b8 ARM: dts: renesas: Add missing ADV751[13] power supply properties
> f213adc3b192 ARM: dts: renesas: rcar-gen2: Fix I2C bus demux node names
> 127c56414e9f riscv: dts: renesas: Convert isa detection to new properties
> 9836c1c69324 ARM: dts: renesas: blanche: Add FLASH node
> d446795daa00 ARM: dts: renesas: marzen: Add FLASH node
> 9a4a8a78013a spi: add stm32f7-spi compatible
> e74e9793f9c7 regulator: dt-bindings: Add 'regulator-uv-less-critical-window-ms' property
> eafbf4f37d51 regulator: dt-bindings: Allow system-critical marking for fixed-regulator
> 52381ed5b4ac regulator: dt-bindings: Add system-critical-regulator property
> ec8f058714a6 dt-bindings: regulator: qcom,smd-rpm-regulator: Document PM8937 IC
> cf118cc80e89 dt-bindings: regulator: qcom,spmi-regulator: Document PM8937 PMIC
> 2ae471b5eeb2 ASoC: dt-bindings: use "soundwire" as controller's node name in examples
> caa17228e281 ASoC: dt-bindings: qcom,sm8250: add SM8550 sound card
> 2d2f997a2bdc dt-bindings: es8328: convert to DT schema format
> 68e113702391 ASoC: dt-bindings: Simplify port schema
> eac536a576c7 ASoC: dt-bindings: nau8821: Add DMIC slew rate.
> 409f501ee9b2 dt-bindings: gpu: v3d: Add BCM2712's compatible
> 22f7441e8685 dt-bindings: display: ssd132x: Remove '-' before compatible enum
> a3de98e60ec5 ARM: dts: qcom: add device tree for Nokia Lumia 830
> 9ad6bcd4499d ARM: dts: qcom: add device tree for Nokia Lumia 735
> 41ee9ea2aefd ARM: dts: qcom: add device tree for Microsoft Lumia 640 XL
> 0dc127c0d612 ARM: dts: qcom: add device tree for Microsoft Lumia 640
> d30c995f440e ARM: dts: qcom: add common dt for MSM8x26 Lumias along with Nokia Lumia 630
> ed92546211d5 dt-bindings: arm: qcom: Document MSM8x26-based Lumia phones
> d783936fa1dc arm64: dts: qcom: msm8939-longcheer-l9100: Enable RGB LED
> b14cb550d720 arm64: dts: qcom: msm8916-longcheer-l8910: Enable RGB LED
> 183a2f447424 arm64: dts: qcom: msm8939-samsung-a7: Add sound and modem
> 9b7d68606781 arm64: dts: qcom: msm8916-samsung-j5: Add sound and modem
> f382f197e0c5 arm64: dts: qcom: msm8916-samsung-gt5: Add sound and modem
> 59a815c1572d arm64: dts: qcom: msm8916-longcheer-l8910: Add sound and modem
> 582b4cfec9a9 ARM: dts: qcom: msm8226: provide dsi phy clocks to mmcc
> 1703230be2a6 ARM: dts: qcom: msm8974: sort nodes by reg
> e23f302820cb ARM: dts: qcom: msm8974: replace incorrect indentation in interconnect
> 373015625e6b arm64: dts: qcom: msm8916-longcheer-l8150: Add sound and modem
> c1a66861dc32 arm64: dts: qcom: msm8916-asus-z00l: Add sound and modem
> 489f91f0dfcc arm64: dts: qcom: msm8916-alcatel-idol347: Add sound and modem
> 2f81e02a3b04 arm64: dts: qcom: msm8916-wingtech-wt88047: Add sound and modem
> 07047876d71e arm64: dts: qcom: msm8916-samsung-serranove: Add sound and modem
> 1d94420f32b0 arm64: dts: qcom: msm8916-samsung-a2015: Add sound and modem
> 9334b10d351c arm64: dts: qcom: msm8916: Add common msm8916-modem-qdsp6.dtsi
> 30b857e0f639 arm64: dts: qcom: msm8939: Add QDSP6
> 5b210c47425a arm64: dts: qcom: msm8916: Add QDSP6
> f1aed61c2c48 arm64: dts: qcom: msm8939: Add BAM-DMUX WWAN
> 702f57c12856 arm64: dts: qcom: sc8280xp-x13s: add missing camera LED pin config
> d21fc2d89cfd arm64: dts: qcom: pm7250b: Use correct node name for gpios
> ecc4cb08c0f3 arm64: dts: qcom: sc7280: Add Camera Control Interface busses
> c01ef95e3aa7 arm64: dts: qcom: sdm845-xiaomi-beryllium: enable flash led
> fe3ccb41dafa arm64: dts: qcom: sdm845-oneplus: enable flash LED
> 0f6538f89c64 arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY compatible
> c9e8e85b1afd arm64: dts: qcom: msm8916-*: Fix alphabetic node order
> 9e38e840740d arm64: dts: qcom: msm8939-longcheer-l9100: Enable wcnss_mem
> 5cdb05e593ef arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
> 0d72dfbbf352 arm64: dts: qcom: ipq5332: include the GPLL0 as clock provider for mailbox
> 13c545bfe884 arm64: dts: qcom: ipq9574: include the GPLL0 as clock provider for mailbox
> 8b57686e7ad0 arm64: dts: qcom: ipq6018: include the GPLL0 as clock provider for mailbox
> 11d8f7a1bf44 arm64: dts: qcom: ipq8074: include the GPLL0 as clock provider for mailbox
> 9b0b036ea0de arm64: dts: qcom: ipq9574: populate the opp table based on the eFuse
> f3636ba1edce arm64: dts: qcom: ipq5332: populate the opp table based on the eFuse
> 8831b26a6579 arm64: dts: qcom: sdm670: add specific cpufreq compatible
> 8ce87f299cdb arm64: dts: qcom: sm8150: extend the size of the PDC resource
> b3cbe4ff9c30 arm64: dts: qcom: ipq5018: add QUP1 SPI controller
> f330c2991aa0 arm64: dts: qcom: qrb4210-rb2: don't force usb peripheral mode
> daa68cbafb06 arm64: dts: qcom: Enable tsens and thermal for sa8775p SoC
> 6232143457ae arm64: dts: qcom: sa8775p: Add RPMh sleep stats
> 973959c2edf1 arm64: dts: qcom: sc7280: Add ports subnodes in usb/dp qmpphy node
> 4c021a56b758 arm64: dts: qcom: sm6375-pdx225: Add USBPHY regulators
> 6fb033b4f60e arm64: dts: qcom: sm6375-pdx225: Enable ATH10K WiFi
> fa14ce25949b arm64: dts: qcom: sm6375-pdx225: Enable MSS
> e77ac5cceb8e arm64: dts: qcom: sm6375: Add UART1
> dec2e7998de5 arm64: dts: qcom: ipq9574: Enable WPS buttons
> d3619641203e arm64: dts: qcom: ipq9574: Add common RDP dtsi file
> 9faa71835343 arm64: dts: qcom: ipq5018: Enable USB
> 71275274da1f arm64: dts: qcom: ipq5018: Add USB related nodes
> af8b25f21479 arm64: dts: qcom: sc7280: add TRNG node
> 00e1b06bb47a arm64: dts: qcom: sa8775p: add TRNG node
> ac7c5d2655a7 arm64: dts: qcom: sm8450: add TRNG node
> 0087dcd6513a arm64: dts: qcom: sm8550: add TRNG node
> 
> git-subtree-dir: dts/upstream
> git-subtree-split: b35b9bd1d4eed2acf8bc38ec5b1b6eef6261b4f0
> ---
> Cc:  Apurva Nandan <a-nandan@ti.com>
> Cc:  Beniamino Galvani <b.galvani@gmail.com>
> Cc:  Bryan Brattlof <bb@ti.com>

Acked-by: Bryan Brattlof <bb@ti.com>

Thanks Tom! I must say this was a nice DTB sync :)

~Bryan

> Cc:  Neil Armstrong <neil.armstrong@linaro.org>
> Cc:  Tim Harvey <tharvey@gateworks.com>
> Cc:  Vignesh Raghavendra <vigneshr@ti.com>
> Cc:  u-boot-amlogic@groups.io
> 
> This commit moves OF_UPSTREAM platforms to the v6.8-dts tag. The patch
> itself isn't directly testable I think, and too huge to email
> regardless. The tree exists at:
> https://github.com/trini/u-boot/tree/WIP/29Mar2024-next
> and will for at least a few days before I merge this, if anyone wants to
> run-time test the changes. I'm still doing a world build before/after to
> see if any changes are visible that way. The CC list here was made by
> using "tools/qconfig.py -b" and then "tools/qconfig.py -f OF_UPSTREAM"
> and get_maintainer.pl on the defconfigs for the platforms that listed.
> If I'm missing maintainers of platforms using OF_UPSTREAM, I'm open to
> ideas on what to do next go-round.
> 
>  Bindings/Makefile                             |    5 +-
>  Bindings/arm/calxeda/l2ecc.yaml               |    2 +-
>  Bindings/arm/cpus.yaml                        |    1 +
>  Bindings/arm/fsl.yaml                         |   22 +-
>  Bindings/arm/google.yaml                      |   53 +
>  .../arm/hisilicon/controller/sysctrl.yaml     |   17 +
>  Bindings/arm/marvell/armada-7k-8k.yaml        |   22 +
>  Bindings/arm/mediatek.yaml                    |   25 +
>  Bindings/arm/mediatek/mediatek,audsys.txt     |   39 -
>  Bindings/arm/mediatek/mediatek,audsys.yaml    |  153 +
>  Bindings/arm/mediatek/mediatek,ethsys.txt     |   29 -
>  Bindings/arm/mediatek/mediatek,infracfg.yaml  |    1 +
>  Bindings/arm/mediatek/mediatek,mmsys.yaml     |    3 +
>  Bindings/arm/mediatek/mediatek,pericfg.yaml   |    1 +
>  Bindings/arm/msm/qcom,idle-state.txt          |   84 -
>  Bindings/arm/qcom,coresight-remote-etm.yaml   |   51 +
>  Bindings/arm/qcom,coresight-tpdm.yaml         |   20 +
>  Bindings/arm/qcom-soc.yaml                    |   16 +-
>  Bindings/arm/qcom.yaml                        |   47 +-
>  Bindings/arm/rockchip.yaml                    |   56 +-
>  Bindings/arm/samsung/samsung-boards.yaml      |    6 +
>  Bindings/arm/sprd/sprd.yaml                   |    5 +
>  Bindings/arm/stm32/stm32.yaml                 |   16 +-
>  Bindings/arm/sunxi.yaml                       |   10 +
>  Bindings/arm/ti/k3.yaml                       |    2 +
>  Bindings/arm/ti/omap.yaml                     |    2 +
>  Bindings/ata/ceva,ahci-1v84.yaml              |    3 +-
>  Bindings/auxdisplay/hit,hd44780.yaml          |    2 +-
>  Bindings/cache/qcom,llcc.yaml                 |    5 +-
>  Bindings/cache/sifive,ccache0.yaml            |    6 +-
>  Bindings/clock/baikal,bt1-ccu-pll.yaml        |    2 +-
>  Bindings/clock/brcm,kona-ccu.txt              |  138 -
>  Bindings/clock/brcm,kona-ccu.yaml             |  181 +
>  Bindings/clock/fsl,imx93-anatop.yaml          |   42 +
>  Bindings/clock/google,gs101-clock.yaml        |  106 +
>  Bindings/clock/hi3620-clock.txt               |   20 -
>  Bindings/clock/mediatek,apmixedsys.yaml       |    1 +
>  Bindings/clock/mediatek,ethsys.yaml           |   55 +
>  Bindings/clock/mediatek,mt7988-ethwarp.yaml   |   52 +
>  Bindings/clock/mediatek,mt7988-xfi-pll.yaml   |   48 +
>  Bindings/clock/mediatek,mt8188-clock.yaml     |    2 -
>  Bindings/clock/mediatek,topckgen.yaml         |    2 +
>  Bindings/clock/qcom,a53pll.yaml               |    1 +
>  Bindings/clock/qcom,camcc-sm8250.yaml         |   18 +-
>  Bindings/clock/qcom,gcc-ipq6018.yaml          |   57 +
>  Bindings/clock/qcom,gcc-ipq8074.yaml          |    4 +
>  Bindings/clock/qcom,gcc-other.yaml            |    3 -
>  Bindings/clock/qcom,qdu1000-ecpricc.yaml      |   68 +
>  Bindings/clock/qcom,rpmhcc.yaml               |    2 +
>  Bindings/clock/qcom,sc7180-camcc.yaml         |   18 +-
>  Bindings/clock/qcom,sc7280-camcc.yaml         |   18 +-
>  Bindings/clock/qcom,sdm845-camcc.yaml         |   18 +-
>  Bindings/clock/qcom,sm8450-camcc.yaml         |   20 +-
>  Bindings/clock/qcom,sm8450-gpucc.yaml         |    2 +
>  Bindings/clock/qcom,sm8550-tcsr.yaml          |    8 +-
>  Bindings/clock/qcom,sm8650-dispcc.yaml        |  106 +
>  Bindings/clock/qcom,sm8650-gcc.yaml           |   65 +
>  Bindings/clock/qcom,x1e80100-gcc.yaml         |   72 +
>  Bindings/clock/renesas,9series.yaml           |   10 +
>  Bindings/clock/silabs,si5351.txt              |  126 -
>  Bindings/clock/silabs,si5351.yaml             |  265 +
>  Bindings/clock/sophgo,cv1800-clk.yaml         |   46 +
>  Bindings/clock/st,stm32mp25-rcc.yaml          |   76 +
>  Bindings/clock/xlnx,clocking-wizard.yaml      |    1 +
>  Bindings/clock/xlnx,versal-clk.yaml           |   31 +-
>  Bindings/connector/usb-connector.yaml         |  124 +-
>  Bindings/cpu/idle-states.yaml                 |   81 +-
>  Bindings/crypto/inside-secure,safexcel.yaml   |   86 +
>  Bindings/crypto/inside-secure-safexcel.txt    |   40 -
>  .../crypto/qcom,inline-crypto-engine.yaml     |    1 +
>  Bindings/crypto/qcom,prng.yaml                |    1 +
>  Bindings/crypto/qcom-qce.yaml                 |   14 +
>  Bindings/display/bridge/lontium,lt8912b.yaml  |   21 +
>  Bindings/display/bridge/nxp,tda998x.yaml      |    7 +-
>  Bindings/display/mediatek/mediatek,aal.yaml   |    1 +
>  Bindings/display/mediatek/mediatek,color.yaml |    1 +
>  Bindings/display/mediatek/mediatek,dsi.yaml   |    4 +
>  Bindings/display/mediatek/mediatek,ethdr.yaml |    6 +-
>  .../display/mediatek/mediatek,mdp-rdma.yaml   |   88 -
>  Bindings/display/mediatek/mediatek,merge.yaml |    4 +
>  Bindings/display/mediatek/mediatek,ovl.yaml   |    1 +
>  .../display/mediatek/mediatek,padding.yaml    |   83 +
>  Bindings/display/mediatek/mediatek,split.yaml |   27 +
>  Bindings/display/msm/dp-controller.yaml       |    2 +
>  Bindings/display/msm/dsi-controller-main.yaml |    3 +
>  Bindings/display/msm/dsi-phy-7nm.yaml         |    1 +
>  Bindings/display/msm/mdss-common.yaml         |   18 +-
>  Bindings/display/msm/qcom,qcm2290-mdss.yaml   |   21 +-
>  Bindings/display/msm/qcom,sc7180-mdss.yaml    |   14 +-
>  Bindings/display/msm/qcom,sc7280-mdss.yaml    |   14 +-
>  Bindings/display/msm/qcom,sdm670-mdss.yaml    |  292 +
>  Bindings/display/msm/qcom,sdm845-dpu.yaml     |    4 +-
>  Bindings/display/msm/qcom,sm6115-mdss.yaml    |   10 +
>  Bindings/display/msm/qcom,sm6125-mdss.yaml    |    8 +-
>  Bindings/display/msm/qcom,sm6350-mdss.yaml    |    8 +-
>  Bindings/display/msm/qcom,sm6375-mdss.yaml    |    8 +-
>  Bindings/display/msm/qcom,sm8150-mdss.yaml    |    6 +-
>  Bindings/display/msm/qcom,sm8250-mdss.yaml    |   10 +
>  Bindings/display/msm/qcom,sm8450-mdss.yaml    |   13 +-
>  Bindings/display/msm/qcom,sm8650-dpu.yaml     |  127 +
>  Bindings/display/msm/qcom,sm8650-mdss.yaml    |  328 +
>  .../display/panel/fascontek,fs035vg158.yaml   |   56 +
>  Bindings/display/panel/himax,hx8394.yaml      |    3 +
>  Bindings/display/panel/ilitek,ili9805.yaml    |   62 +
>  Bindings/display/panel/ilitek,ili9881c.yaml   |    1 +
>  .../display/panel/leadtek,ltk035c5444t.yaml   |    8 +-
>  Bindings/display/panel/newvision,nv3051d.yaml |    2 +-
>  .../panel/panel-simple-lvds-dual-ports.yaml   |    2 +
>  Bindings/display/panel/panel-simple.yaml      |    4 +
>  Bindings/display/panel/sitronix,st7701.yaml   |    1 +
>  Bindings/display/panel/synaptics,r63353.yaml  |   61 +
>  .../display/rockchip/inno_hdmi-rockchip.txt   |   49 -
>  .../display/rockchip/rockchip,inno-hdmi.yaml  |  139 +
>  Bindings/display/rockchip/rockchip-vop2.yaml  |  100 +-
>  .../display/samsung/samsung,exynos-mixer.yaml |    6 +-
>  Bindings/display/ti/ti,am65x-dss.yaml         |   14 +
>  Bindings/dma/dma-controller.yaml              |   15 -
>  Bindings/dma/dma-router.yaml                  |   11 -
>  Bindings/dma/loongson,ls2x-apbdma.yaml        |   62 +
>  Bindings/dma/nvidia,tegra210-adma.yaml        |    3 +
>  Bindings/dma/qcom,gpi.yaml                    |    2 +
>  Bindings/dma/renesas,rz-dmac.yaml             |    2 +-
>  Bindings/dma/sifive,fu540-c000-pdma.yaml      |    1 +
>  Bindings/dma/ti/k3-bcdma.yaml                 |   39 +-
>  Bindings/dma/ti/k3-pktdma.yaml                |   26 +-
>  Bindings/dma/ti/k3-udma.yaml                  |   20 +-
>  Bindings/dts-coding-style.rst                 |  196 +
>  Bindings/eeprom/at24.yaml                     |    1 +
>  Bindings/firmware/qcom,scm.yaml               |   18 +-
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |    4 +-
>  Bindings/fpga/altera-fpga2sdram-bridge.txt    |   13 -
>  Bindings/fpga/altera-freeze-bridge.txt        |   20 -
>  Bindings/fpga/altera-hps2fpga-bridge.txt      |   36 -
>  .../fpga/altr,freeze-bridge-controller.yaml   |   41 +
>  .../fpga/altr,socfpga-fpga2sdram-bridge.yaml  |   33 +
>  .../fpga/altr,socfpga-hps2fpga-bridge.yaml    |   49 +
>  Bindings/fpga/fpga-bridge.txt                 |   13 -
>  Bindings/fpga/fpga-bridge.yaml                |   30 +
>  Bindings/fpga/xlnx,pr-decoupler.yaml          |    5 +-
>  Bindings/gnss/u-blox,neo-6m.yaml              |    6 +
>  Bindings/gpio/brcm,brcmstb-gpio.yaml          |    2 +-
>  Bindings/gpio/nuvoton,sgpio.yaml              |   87 +
>  Bindings/gpio/realtek,rtd-gpio.yaml           |   69 +
>  Bindings/gpio/rockchip,gpio-bank.yaml         |    7 +
>  Bindings/gpio/snps,dw-apb-gpio.yaml           |    2 +
>  Bindings/gpio/xlnx,gpio-xilinx.yaml           |    2 +-
>  Bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml   |    6 +-
>  Bindings/gpu/arm,mali-midgard.yaml            |    5 +
>  Bindings/gpu/arm,mali-utgard.yaml             |    1 +
>  Bindings/gpu/brcm,bcm-v3d.yaml                |    1 +
>  Bindings/gpu/img,powervr.yaml                 |   73 +
>  Bindings/gpu/samsung-g2d.yaml                 |   71 +-
>  Bindings/gpu/samsung-rotator.yaml             |    9 +-
>  Bindings/gpu/samsung-scaler.yaml              |   81 +-
>  Bindings/hwinfo/samsung,exynos-chipid.yaml    |   18 +-
>  Bindings/hwmon/gpio-fan.txt                   |   41 -
>  Bindings/hwmon/gpio-fan.yaml                  |   60 +
>  Bindings/hwmon/iio-hwmon.yaml                 |    2 +-
>  Bindings/hwmon/lltc,ltc4286.yaml              |   50 +
>  Bindings/hwmon/lm75.yaml                      |   33 +
>  Bindings/i2c/i2c-exynos5.yaml                 |   11 +-
>  Bindings/i2c/samsung,s3c2410-i2c.yaml         |   22 +-
>  Bindings/i2c/st,stm32-i2c.yaml                |   28 +
>  Bindings/iio/adc/adi,ad7091r5.yaml            |   82 +-
>  Bindings/iio/adc/adi,ad7780.yaml              |    6 +-
>  Bindings/iio/adc/maxim,max34408.yaml          |  139 +
>  Bindings/iio/adc/qcom,spmi-iadc.yaml          |   10 +-
>  Bindings/iio/adc/qcom,spmi-rradc.yaml         |    4 +-
>  Bindings/iio/adc/qcom,spmi-vadc.yaml          |    9 +-
>  Bindings/iio/adc/samsung,exynos-adc.yaml      |   29 +-
>  Bindings/iio/adc/ti,palmas-gpadc.yaml         |   15 -
>  Bindings/iio/amplifiers/adi,hmc425a.yaml      |    4 +
>  Bindings/iio/chemical/aosong,ags02ma.yaml     |   47 +
>  Bindings/iio/dac/adi,ad5791.yaml              |    5 +
>  Bindings/iio/dac/microchip,mcp4821.yaml       |   86 +
>  Bindings/iio/humidity/ti,hdc3020.yaml         |   55 +
>  Bindings/iio/imu/adi,adis16460.yaml           |    4 +
>  Bindings/iio/imu/adi,adis16475.yaml           |    4 +
>  Bindings/iio/imu/bosch,bmi323.yaml            |   77 +
>  Bindings/iio/light/liteon,ltr390.yaml         |   56 +
>  Bindings/iio/light/vishay,veml6075.yaml       |   39 +
>  Bindings/iio/pressure/honeywell,hsc030pa.yaml |  142 +
>  .../iio/pressure/honeywell,mprls0025pa.yaml   |    2 -
>  .../iio/temperature/melexis,mlx90632.yaml     |   19 +-
>  .../iio/temperature/microchip,mcp9600.yaml    |   70 +
>  Bindings/index.rst                            |    1 +
>  Bindings/input/adafruit,seesaw-gamepad.yaml   |   63 +
>  Bindings/input/elan,ekth6915.yaml             |    5 +-
>  Bindings/input/gpio-keys.yaml                 |   41 +-
>  Bindings/input/gpio-mouse.txt                 |   32 -
>  Bindings/input/gpio-mouse.yaml                |   68 +
>  Bindings/input/iqs269a.yaml                   |   98 +-
>  Bindings/input/mediatek,pmic-keys.yaml        |   24 +-
>  Bindings/input/microchip,cap11xx.yaml         |   80 +-
>  Bindings/input/sprd,sc27xx-vibrator.yaml      |   19 +-
>  Bindings/input/ti,drv2665.txt                 |   17 -
>  Bindings/input/ti,drv2667.txt                 |   17 -
>  Bindings/input/ti,drv266x.yaml                |   50 +
>  .../input/touchscreen/neonode,zforce.yaml     |   72 +
>  .../input/touchscreen/samsung,s6sy761.txt     |   32 -
>  .../input/touchscreen/samsung,s6sy761.yaml    |   54 +
>  Bindings/input/touchscreen/zforce_ts.txt      |   34 -
>  Bindings/interconnect/qcom,msm8998-bwmon.yaml |    4 +
>  Bindings/interconnect/qcom,sm6115.yaml        |  152 +
>  Bindings/interconnect/qcom,sm8650-rpmh.yaml   |  136 +
>  Bindings/interconnect/qcom,x1e80100-rpmh.yaml |   83 +
>  .../loongson,liointc.yaml                     |   18 +-
>  Bindings/interrupt-controller/qcom,mpm.yaml   |   54 +-
>  Bindings/interrupt-controller/qcom,pdc.yaml   |    4 +
>  .../renesas,rzg2l-irqc.yaml                   |    5 +-
>  .../sifive,plic-1.0.0.yaml                    |    1 +
>  .../st,stih407-irq-syscfg.yaml                |    4 +-
>  Bindings/iommu/apple,dart.yaml                |    1 +
>  Bindings/iommu/arm,smmu.yaml                  |   77 +-
>  Bindings/iommu/rockchip,iommu.yaml            |   11 +-
>  Bindings/leds/allwinner,sun50i-a100-ledc.yaml |  137 +
>  Bindings/leds/awinic,aw200xx.yaml             |   95 +-
>  Bindings/leds/backlight/mps,mp3309c.yaml      |   10 +-
>  Bindings/leds/common.yaml                     |    2 +-
>  Bindings/leds/qcom,spmi-flash-led.yaml        |    4 +-
>  Bindings/loongarch/cpus.yaml                  |   61 +
>  Bindings/loongarch/loongson.yaml              |   34 +
>  Bindings/mailbox/qcom,apcs-kpss-global.yaml   |   62 +-
>  Bindings/mailbox/qcom-ipcc.yaml               |    1 +
>  Bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml |  132 +-
>  Bindings/media/cnm,wave521c.yaml              |   61 +
>  .../media/i2c/alliedvision,alvium-csi2.yaml   |   81 +
>  Bindings/media/i2c/asahi-kasei,ak7375.yaml    |    4 +-
>  Bindings/media/i2c/galaxycore,gc0308.yaml     |  108 +
>  Bindings/media/i2c/galaxycore,gc2145.yaml     |  113 +
>  Bindings/media/i2c/ov8856.yaml                |   24 +-
>  Bindings/media/i2c/ovti,ov64a40.yaml          |  103 +
>  Bindings/media/i2c/sony,imx335.yaml           |   13 +
>  Bindings/media/i2c/techwell,tw9900.yaml       |  137 +
>  Bindings/media/i2c/thine,thp7312.yaml         |  224 +
>  Bindings/media/mediatek,mdp3-fg.yaml          |   61 +
>  Bindings/media/mediatek,mdp3-hdr.yaml         |   61 +
>  Bindings/media/mediatek,mdp3-rdma.yaml        |  104 +-
>  Bindings/media/mediatek,mdp3-rsz.yaml         |    6 +-
>  Bindings/media/mediatek,mdp3-stitch.yaml      |   61 +
>  Bindings/media/mediatek,mdp3-tcc.yaml         |   62 +
>  Bindings/media/mediatek,mdp3-tdshp.yaml       |   61 +
>  Bindings/media/mediatek,mdp3-wrot.yaml        |   29 +-
>  Bindings/media/rockchip-isp1.yaml             |   11 +-
>  Bindings/media/samsung,s5p-mfc.yaml           |   47 +-
>  Bindings/media/st,stm32-dcmipp.yaml           |   89 +
>  Bindings/media/starfive,jh7110-camss.yaml     |  180 +
>  Bindings/mfd/ams,as3711.yaml                  |  223 +
>  Bindings/mfd/as3711.txt                       |   73 -
>  Bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml  |  140 +-
>  Bindings/mfd/qcom,pm8008.yaml                 |    6 +-
>  Bindings/mfd/qcom,spmi-pmic.yaml              |    7 +
>  Bindings/mfd/qcom,tcsr.yaml                   |    2 +
>  Bindings/mfd/samsung,exynos5433-lpass.yaml    |    2 +-
>  Bindings/mfd/sprd,ums512-glbreg.yaml          |    4 +-
>  Bindings/mfd/ti,am3359-tscadc.yaml            |    2 -
>  Bindings/misc/fsl,dpaa2-console.yaml          |    2 +-
>  Bindings/mmc/arasan,sdhci.yaml                |    8 +-
>  Bindings/mmc/arm,pl18x.yaml                   |    2 +-
>  Bindings/mmc/brcm,sdhci-brcmstb.yaml          |    4 +-
>  Bindings/mmc/marvell,xenon-sdhci.yaml         |    4 +-
>  Bindings/mmc/mtk-sd.yaml                      |    9 +
>  Bindings/mmc/renesas,sdhi.yaml                |    2 +-
>  Bindings/mmc/samsung,exynos-dw-mshc.yaml      |   25 +-
>  Bindings/mmc/sdhci-msm.yaml                   |    2 +
>  Bindings/mmc/sdhci-pxa.yaml                   |    4 +-
>  Bindings/mmc/snps,dwcmshc-sdhci.yaml          |    1 +
>  Bindings/mmc/synopsys-dw-mshc.yaml            |    4 +
>  Bindings/mtd/partitions/u-boot.yaml           |    2 +-
>  Bindings/net/dsa/dsa.yaml                     |    6 +
>  Bindings/net/dsa/marvell,mv88e6060.yaml       |   88 +
>  Bindings/net/dsa/marvell,mv88e6xxx.yaml       |  337 +
>  Bindings/net/dsa/marvell.txt                  |  109 -
>  Bindings/net/dsa/microchip,ksz.yaml           |   34 +-
>  Bindings/net/ethernet-switch.yaml             |   23 +-
>  Bindings/net/lantiq,pef2256.yaml              |  213 +
>  Bindings/net/marvell,aquantia.yaml            |  116 +
>  Bindings/net/marvell,mvusb.yaml               |    7 +-
>  Bindings/net/marvell,orion-mdio.yaml          |   22 -
>  Bindings/net/marvell,prestera.yaml            |    4 +-
>  Bindings/net/pcs/mediatek,sgmiisys.yaml       |   65 +-
>  Bindings/net/qcom,ipa.yaml                    |   24 +-
>  Bindings/net/renesas,etheravb.yaml            |    3 +-
>  Bindings/net/renesas,ethertsn.yaml            |  135 +
>  Bindings/net/sff,sfp.yaml                     |    2 +-
>  Bindings/net/xlnx,axi-ethernet.yaml           |   16 +
>  Bindings/nvmem/st,stm32-romem.yaml            |    1 +
>  Bindings/pci/brcm,stb-pcie.yaml               |   18 +
>  Bindings/pci/qcom,pcie.yaml                   |   63 +-
>  Bindings/pci/rcar-pci-host.yaml               |   11 +
>  Bindings/pci/rockchip-dw-pcie.yaml            |    2 +
>  Bindings/pci/ti,j721e-pci-ep.yaml             |   39 +-
>  Bindings/pci/ti,j721e-pci-host.yaml           |   39 +-
>  Bindings/pci/toshiba,visconti-pcie.yaml       |    2 +-
>  Bindings/perf/fsl-imx-ddr.yaml                |    3 +
>  .../phy/amlogic,g12a-mipi-dphy-analog.yaml    |   12 -
>  .../amlogic,meson-axg-mipi-pcie-analog.yaml   |   17 -
>  Bindings/phy/mediatek,dsi-phy.yaml            |    1 +
>  Bindings/phy/mediatek,tphy.yaml               |    9 +
>  Bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml  |    5 +
>  Bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml   |    2 +
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |    3 +
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |    8 +-
>  Bindings/phy/qcom,snps-eusb2-phy.yaml         |    2 +
>  Bindings/pinctrl/pinctrl-single.yaml          |    1 +
>  Bindings/pinctrl/qcom,ipq5018-tlmm.yaml       |   12 +-
>  Bindings/pinctrl/qcom,ipq5332-tlmm.yaml       |    9 +-
>  Bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    |    8 +-
>  Bindings/pinctrl/qcom,ipq8074-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,ipq9574-tlmm.yaml       |    9 +-
>  Bindings/pinctrl/qcom,lpass-lpi-common.yaml   |   75 +
>  Bindings/pinctrl/qcom,mdm9607-tlmm.yaml       |   18 +-
>  Bindings/pinctrl/qcom,mdm9615-pinctrl.yaml    |   18 +-
>  Bindings/pinctrl/qcom,msm8226-pinctrl.yaml    |    8 +-
>  Bindings/pinctrl/qcom,msm8660-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8909-tlmm.yaml       |   18 +-
>  Bindings/pinctrl/qcom,msm8916-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8953-pinctrl.yaml    |    7 +-
>  Bindings/pinctrl/qcom,msm8960-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8974-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8976-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8994-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8996-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,msm8998-pinctrl.yaml    |    9 +-
>  Bindings/pinctrl/qcom,pmic-mpp.yaml           |   62 +-
>  Bindings/pinctrl/qcom,qcm2290-tlmm.yaml       |    9 +-
>  Bindings/pinctrl/qcom,qcs404-pinctrl.yaml     |    9 +-
>  Bindings/pinctrl/qcom,qdu1000-tlmm.yaml       |   12 +-
>  Bindings/pinctrl/qcom,sa8775p-tlmm.yaml       |   21 +-
>  Bindings/pinctrl/qcom,sc7180-pinctrl.yaml     |    9 +-
>  .../qcom,sc7280-lpass-lpi-pinctrl.yaml        |   49 +-
>  Bindings/pinctrl/qcom,sc7280-pinctrl.yaml     |   30 +-
>  Bindings/pinctrl/qcom,sc8180x-tlmm.yaml       |   20 +-
>  .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      |   49 +-
>  Bindings/pinctrl/qcom,sc8280xp-tlmm.yaml      |   18 +-
>  Bindings/pinctrl/qcom,sdm630-pinctrl.yaml     |   10 +-
>  Bindings/pinctrl/qcom,sdm670-tlmm.yaml        |   19 +-
>  Bindings/pinctrl/qcom,sdm845-pinctrl.yaml     |   10 +-
>  Bindings/pinctrl/qcom,sdx55-pinctrl.yaml      |    8 +-
>  Bindings/pinctrl/qcom,sdx65-tlmm.yaml         |    8 +-
>  Bindings/pinctrl/qcom,sdx75-tlmm.yaml         |   12 +-
>  Bindings/pinctrl/qcom,sm4450-tlmm.yaml        |  151 +
>  .../qcom,sm6115-lpass-lpi-pinctrl.yaml        |   48 +-
>  Bindings/pinctrl/qcom,sm6115-tlmm.yaml        |    8 +-
>  Bindings/pinctrl/qcom,sm6125-tlmm.yaml        |   20 +-
>  Bindings/pinctrl/qcom,sm6350-tlmm.yaml        |   20 +-
>  Bindings/pinctrl/qcom,sm6375-tlmm.yaml        |   18 +-
>  Bindings/pinctrl/qcom,sm7150-tlmm.yaml        |    9 +-
>  Bindings/pinctrl/qcom,sm8150-pinctrl.yaml     |    9 +-
>  .../qcom,sm8250-lpass-lpi-pinctrl.yaml        |   49 +-
>  Bindings/pinctrl/qcom,sm8250-pinctrl.yaml     |    9 +-
>  .../qcom,sm8350-lpass-lpi-pinctrl.yaml        |   49 +-
>  Bindings/pinctrl/qcom,sm8350-tlmm.yaml        |   20 +-
>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        |   49 +-
>  Bindings/pinctrl/qcom,sm8450-tlmm.yaml        |   20 +-
>  .../qcom,sm8550-lpass-lpi-pinctrl.yaml        |   55 +-
>  Bindings/pinctrl/qcom,sm8550-tlmm.yaml        |   12 +-
>  .../qcom,sm8650-lpass-lpi-pinctrl.yaml        |  107 +
>  Bindings/pinctrl/qcom,sm8650-tlmm.yaml        |  141 +
>  Bindings/pinctrl/qcom,x1e80100-tlmm.yaml      |  137 +
>  Bindings/pinctrl/renesas,rza2-pinctrl.yaml    |    2 +-
>  Bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   |    6 +-
>  .../samsung,pinctrl-wakeup-interrupt.yaml     |   45 +-
>  Bindings/pinctrl/samsung,pinctrl.yaml         |    5 +-
>  Bindings/pinctrl/xlnx,zynq-pinctrl.yaml       |    2 +-
>  Bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml     |    2 +-
>  Bindings/power/fsl,scu-pd.yaml                |    1 +
>  Bindings/power/qcom,rpmpd.yaml                |    2 +-
>  Bindings/power/reset/nvmem-reboot-mode.yaml   |    8 +-
>  Bindings/power/reset/qcom,pon.yaml            |   13 +-
>  Bindings/power/reset/syscon-reboot-mode.yaml  |    8 +-
>  Bindings/power/reset/xlnx,zynqmp-power.yaml   |    4 +-
>  Bindings/power/supply/bq24190.yaml            |    1 +
>  Bindings/power/supply/richtek,rt9455.yaml     |    8 +-
>  Bindings/power/wakeup-source.txt              |   18 +-
>  Bindings/pwm/mediatek,pwm-disp.yaml           |    1 -
>  Bindings/pwm/pwm-omap-dmtimer.txt             |   22 -
>  Bindings/pwm/pwm-samsung.yaml                 |    4 +
>  Bindings/pwm/ti,omap-dmtimer-pwm.yaml         |   59 +
>  Bindings/regulator/fixed-regulator.yaml       |    2 +
>  Bindings/regulator/mps,mp5416.yaml            |    4 +-
>  Bindings/regulator/mps,mpq7920.yaml           |    4 +-
>  Bindings/regulator/qcom,rpmh-regulator.yaml   |   14 +
>  .../regulator/qcom,smd-rpm-regulator.yaml     |    4 +
>  Bindings/regulator/qcom,spmi-regulator.yaml   |   19 +
>  .../regulator/qcom,usb-vbus-regulator.yaml    |    5 +-
>  Bindings/regulator/regulator.yaml             |   13 +
>  Bindings/remoteproc/fsl,imx-rproc.yaml        |    8 +-
>  Bindings/remoteproc/qcom,sc7180-pas.yaml      |   21 +
>  Bindings/reset/amlogic,meson-reset.yaml       |    1 +
>  Bindings/reset/fsl,imx-src.yaml               |   31 +-
>  Bindings/reset/hisilicon,hi3660-reset.yaml    |   25 +-
>  Bindings/reset/qcom,aoss-reset.yaml           |   10 +-
>  Bindings/reset/qcom,pdc-global.yaml           |    8 +-
>  Bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml |    2 +-
>  Bindings/reset/xlnx,zynqmp-reset.yaml         |    3 +-
>  Bindings/riscv/cpus.yaml                      |   10 +-
>  Bindings/riscv/extensions.yaml                |  221 +-
>  Bindings/riscv/sophgo.yaml                    |    4 +
>  Bindings/rng/starfive,jh7110-trng.yaml        |    6 +-
>  Bindings/rtc/adi,max31335.yaml                |   70 +
>  Bindings/rtc/epson,rx8900.yaml                |    2 +
>  Bindings/rtc/nuvoton,ma35d1-rtc.yaml          |   48 +
>  Bindings/rtc/qcom-pm8xxx-rtc.yaml             |   36 +-
>  Bindings/rtc/s3c-rtc.yaml                     |    5 +
>  Bindings/security/tpm/google,cr50.txt         |   19 -
>  Bindings/security/tpm/ibmvtpm.txt             |   41 -
>  Bindings/security/tpm/st33zp24-i2c.txt        |   34 -
>  Bindings/security/tpm/st33zp24-spi.txt        |   32 -
>  Bindings/security/tpm/tpm-i2c.txt             |   26 -
>  Bindings/security/tpm/tpm_tis_mmio.txt        |   25 -
>  Bindings/security/tpm/tpm_tis_spi.txt         |   23 -
>  Bindings/serial/arm,dcc.yaml                  |   30 +
>  Bindings/serial/fsl,s32-linflexuart.yaml      |    2 +-
>  Bindings/serial/fsl-imx-uart.yaml             |   29 +-
>  Bindings/serial/qcom,msm-uartdm.yaml          |   13 +
>  Bindings/serial/renesas,sci.yaml              |    2 +-
>  Bindings/serial/samsung_uart.yaml             |   28 +-
>  Bindings/serial/snps-dw-apb-uart.yaml         |    1 +
>  Bindings/serial/sprd-uart.yaml                |    1 +
>  .../amlogic/amlogic,meson-gx-hhi-sysctrl.yaml |   33 +
>  Bindings/soc/mediatek/mediatek,pwrap.yaml     |    6 +-
>  Bindings/soc/mediatek/mtk-svs.yaml            |    2 +
>  .../microchip,mpfs-sys-controller.yaml        |   10 +
>  Bindings/soc/qcom/qcom,aoss-qmp.yaml          |    2 +
>  Bindings/soc/qcom/qcom,pmic-glink.yaml        |   22 +-
>  Bindings/soc/qcom/qcom-stats.yaml             |   14 +
>  Bindings/soc/rockchip/grf.yaml                |    2 +
>  Bindings/soc/samsung/exynos-pmu.yaml          |   10 +
>  Bindings/soc/samsung/exynos-usi.yaml          |    7 +-
>  .../soc/samsung/samsung,exynos-sysreg.yaml    |    5 +
>  Bindings/{arm => soc/xilinx}/xilinx.yaml      |    7 +-
>  Bindings/sound/adi,max98363.yaml              |    2 +-
>  Bindings/sound/allwinner,sun4i-a10-spdif.yaml |    5 +-
>  Bindings/sound/audio-graph-port.yaml          |    6 +
>  Bindings/sound/es8328.txt                     |   38 -
>  Bindings/sound/everest,es8328.yaml            |   77 +
>  Bindings/sound/fsl,mqs.txt                    |   36 -
>  Bindings/sound/fsl,mqs.yaml                   |  105 +
>  Bindings/sound/fsl,xcvr.yaml                  |   22 +-
>  Bindings/sound/google,sc7280-herobrine.yaml   |    1 -
>  Bindings/sound/mediatek,mt2701-audio.yaml     |  116 +
>  Bindings/sound/mediatek,mt8188-mt6359.yaml    |    1 +
>  Bindings/sound/mt2701-afe-pcm.txt             |  146 -
>  Bindings/sound/nuvoton,nau8821.yaml           |    9 +
>  .../sound/nvidia,tegra-audio-max9808x.yaml    |    2 +-
>  Bindings/sound/qcom,lpass-rx-macro.yaml       |   23 +-
>  Bindings/sound/qcom,lpass-tx-macro.yaml       |   25 +-
>  Bindings/sound/qcom,lpass-va-macro.yaml       |   18 +-
>  Bindings/sound/qcom,lpass-wsa-macro.yaml      |   23 +-
>  Bindings/sound/qcom,sm8250.yaml               |    6 +
>  Bindings/sound/qcom,wcd934x.yaml              |    4 +-
>  Bindings/sound/qcom,wcd938x-sdw.yaml          |    4 +-
>  Bindings/sound/qcom,wcd938x.yaml              |    4 +-
>  Bindings/sound/qcom,wsa883x.yaml              |    2 +-
>  Bindings/sound/qcom,wsa8840.yaml              |    2 +-
>  Bindings/sound/renesas,rsnd.yaml              |   36 +-
>  Bindings/sound/renesas,rz-ssi.yaml            |    2 +-
>  Bindings/sound/samsung-i2s.yaml               |   19 +-
>  Bindings/sound/sound-card-common.yaml         |    7 +
>  Bindings/sound/tas2562.yaml                   |    2 -
>  Bindings/sound/ti,tas2781.yaml                |   78 +-
>  Bindings/sound/ti,tlv320aic32x4.yaml          |    2 +-
>  Bindings/spi/adi,axi-spi-engine.txt           |   31 -
>  Bindings/spi/adi,axi-spi-engine.yaml          |   66 +
>  Bindings/spi/renesas,rspi.yaml                |    2 +-
>  Bindings/spi/snps,dw-apb-ssi.yaml             |    2 -
>  Bindings/spi/st,stm32-spi.yaml                |    2 +
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     |    7 +-
>  Bindings/thermal/loongson,ls2k-thermal.yaml   |   10 +-
>  Bindings/thermal/mediatek,thermal.yaml        |   99 +
>  Bindings/thermal/mediatek-thermal.txt         |   52 -
>  Bindings/thermal/qcom-spmi-adc-tm-hc.yaml     |    8 +-
>  Bindings/thermal/qcom-spmi-adc-tm5.yaml       |   16 +-
>  Bindings/thermal/qcom-tsens.yaml              |    1 +
>  Bindings/thermal/thermal-zones.yaml           |   16 +
>  Bindings/timer/sifive,clint.yaml              |    2 +
>  Bindings/timer/thead,c900-aclint-mtimer.yaml  |    9 +-
>  Bindings/tpm/google,cr50.yaml                 |   65 +
>  Bindings/tpm/ibm,vtpm.yaml                    |  104 +
>  Bindings/tpm/microsoft,ftpm.yaml              |   47 +
>  Bindings/tpm/tcg,tpm-tis-i2c.yaml             |   90 +
>  Bindings/tpm/tcg,tpm-tis-mmio.yaml            |   49 +
>  Bindings/tpm/tcg,tpm_tis-spi.yaml             |   75 +
>  Bindings/tpm/tpm-common.yaml                  |   87 +
>  Bindings/trivial-devices.yaml                 |   24 +-
>  Bindings/ufs/qcom,ufs.yaml                    |    2 +
>  Bindings/ufs/samsung,exynos-ufs.yaml          |    9 +-
>  Bindings/ufs/ufs-common.yaml                  |    2 +
>  Bindings/usb/dwc3-xilinx.yaml                 |    3 +-
>  Bindings/usb/generic-xhci.yaml                |   25 +-
>  Bindings/usb/genesys,gl850g.yaml              |    5 +
>  Bindings/usb/mediatek,mtk-xhci.yaml           |   11 +
>  Bindings/usb/microchip,usb5744.yaml           |    3 +-
>  Bindings/usb/nxp,ptn5110.yaml                 |    2 +-
>  Bindings/usb/qcom,dwc3.yaml                   |  151 +-
>  Bindings/usb/qcom,wcd939x-usbss.yaml          |  102 +
>  Bindings/usb/renesas,usbhs.yaml               |    2 +-
>  Bindings/usb/snps,dwc3.yaml                   |    4 +
>  Bindings/usb/ti,tps6598x.yaml                 |    6 +
>  Bindings/usb/usb-xhci.yaml                    |    6 +
>  Bindings/usb/xlnx,usb2.yaml                   |    3 +-
>  Bindings/vendor-prefixes.yaml                 |   22 +
>  Bindings/w1/amd,axi-1wire-host.yaml           |   44 +
>  .../watchdog/allwinner,sun4i-a10-wdt.yaml     |    6 +-
>  Bindings/watchdog/alphascale,asm9260-wdt.yaml |    6 +-
>  Bindings/watchdog/apple,wdt.yaml              |    6 +-
>  Bindings/watchdog/arm-smc-wdt.yaml            |    6 +-
>  Bindings/watchdog/brcm,bcm7038-wdt.yaml       |   10 +-
>  Bindings/watchdog/cnxt,cx92755-wdt.yaml       |    6 +-
>  Bindings/watchdog/dlg,da9062-watchdog.yaml    |   12 +-
>  Bindings/watchdog/intel,keembay-wdt.yaml      |    5 +-
>  Bindings/watchdog/maxim,max63xx.yaml          |    8 +-
>  Bindings/watchdog/mediatek,mtk-wdt.yaml       |    1 +
>  Bindings/watchdog/nxp,pnx4008-wdt.yaml        |   34 +
>  Bindings/watchdog/pnx4008-wdt.txt             |   17 -
>  Bindings/watchdog/qca,ar7130-wdt.yaml         |   33 +
>  Bindings/watchdog/qca-ar7130-wdt.txt          |   13 -
>  Bindings/watchdog/qcom,pm8916-wdt.yaml        |   33 +-
>  Bindings/watchdog/qcom-wdt.yaml               |    2 +-
>  Bindings/watchdog/realtek,rtd119x.txt         |   17 -
>  .../watchdog/realtek,rtd1295-watchdog.yaml    |   38 +
>  Bindings/watchdog/samsung-wdt.yaml            |   29 +-
>  Bindings/watchdog/snps,dw-wdt.yaml            |   10 +-
>  Bindings/watchdog/technologic,ts7200-wdt.yaml |   45 +
>  include/dt-bindings/arm/qcom,ids.h            |    1 +
>  include/dt-bindings/clock/g12a-clkc.h         |    8 +
>  include/dt-bindings/clock/google,gs101.h      |  392 ++
>  .../dt-bindings/clock/mediatek,mt7988-clk.h   |  280 +
>  include/dt-bindings/clock/qcom,gcc-msm8939.h  |    6 +
>  .../dt-bindings/clock/qcom,qdu1000-ecpricc.h  |  147 +
>  .../dt-bindings/clock/qcom,sc8280xp-camcc.h   |  179 +
>  .../dt-bindings/clock/qcom,sm8650-dispcc.h    |  102 +
>  include/dt-bindings/clock/qcom,sm8650-gcc.h   |  254 +
>  include/dt-bindings/clock/qcom,sm8650-gpucc.h |   43 +
>  include/dt-bindings/clock/qcom,sm8650-tcsr.h  |   18 +
>  .../dt-bindings/clock/qcom,videocc-sm8150.h   |    4 +
>  include/dt-bindings/clock/qcom,x1e80100-gcc.h |  485 ++
>  include/dt-bindings/clock/sophgo,cv1800.h     |  176 +
>  include/dt-bindings/clock/st,stm32mp25-rcc.h  |  492 ++
>  include/dt-bindings/dma/fsl-edma.h            |   21 +
>  .../dt-bindings/iio/qcom,spmi-adc7-pm7325.h   |   69 +
>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |   19 +
>  include/dt-bindings/iio/qcom,spmi-vadc.h      |    3 +
>  .../dt-bindings/interconnect/qcom,sm6115.h    |  111 +
>  .../interconnect/qcom,sm8650-rpmh.h           |  154 +
>  .../interconnect/qcom,x1e80100-rpmh.h         |  207 +
>  include/dt-bindings/power/meson-g12a-power.h  |    1 +
>  include/dt-bindings/reset/amlogic,c3-reset.h  |  119 +
>  .../reset/mediatek,mt7988-resets.h            |   13 +
>  include/dt-bindings/reset/mt8188-resets.h     |   75 +
>  include/dt-bindings/reset/qcom,sm8650-gpucc.h |   20 +
>  include/dt-bindings/reset/st,stm32mp25-rcc.h  |  167 +
>  include/dt-bindings/soc/rockchip,vop2.h       |    4 +
>  src/arm/amazon/alpine.dtsi                    |    1 -
>  .../aspeed/aspeed-bmc-facebook-bletchley.dts  |    4 +-
>  .../aspeed/aspeed-bmc-facebook-wedge400.dts   |    4 +-
>  src/arm/aspeed/aspeed-bmc-opp-tacoma.dts      |    2 +-
>  src/arm/aspeed/aspeed-g4.dtsi                 |   14 -
>  src/arm/aspeed/aspeed-g5.dtsi                 |   15 +-
>  src/arm/aspeed/aspeed-g6.dtsi                 |   18 +-
>  .../ast2600-facebook-netbmc-common.dtsi       |    4 +-
>  src/arm/broadcom/bcm-cygnus.dtsi              |    3 +
>  src/arm/broadcom/bcm-hr2.dtsi                 |    1 +
>  src/arm/broadcom/bcm-nsp.dtsi                 |    2 +
>  src/arm/broadcom/bcm2711-rpi.dtsi             |    5 +
>  src/arm/broadcom/bcm2711.dtsi                 |   14 +
>  src/arm/broadcom/bcm63138.dtsi                |    6 +
>  .../intel/ixp/intel-ixp42x-gateway-7001.dts   |    2 +
>  .../ixp/intel-ixp42x-goramo-multilink.dts     |    2 +
>  .../ixp/intel-ixp42x-usrobotics-usr8200.dts   |   22 +
>  src/arm/intel/socfpga/socfpga.dtsi            |    2 +-
>  src/arm/intel/socfpga/socfpga_arria10.dtsi    |    2 +-
>  .../socfpga/socfpga_arria10_socdk_qspi.dts    |    2 -
>  .../intel/socfpga/socfpga_arria5_socdk.dts    |    2 -
>  .../intel/socfpga/socfpga_cyclone5_socdk.dts  |    2 -
>  .../intel/socfpga/socfpga_cyclone5_sockit.dts |    2 -
>  .../intel/socfpga/socfpga_cyclone5_sodia.dts  |    2 -
>  .../socfpga/socfpga_cyclone5_vining_fpga.dts  |    4 -
>  src/arm/marvell/armada-370-rd.dts             |   26 +-
>  .../marvell/armada-370-seagate-nas-2bay.dts   |    8 +-
>  .../marvell/armada-370-seagate-nas-4bay.dts   |    8 +-
>  .../marvell/armada-370-synology-ds213j.dts    |   16 +-
>  .../marvell/armada-381-netgear-gs110emx.dts   |   44 +-
>  .../marvell/armada-385-clearfog-gtr-l8.dts    |   38 +-
>  .../marvell/armada-385-clearfog-gtr-s4.dts    |   22 +-
>  src/arm/marvell/armada-385-linksys.dtsi       |   18 +-
>  src/arm/marvell/armada-385-synology-ds116.dts |   16 +-
>  src/arm/marvell/armada-385-turris-omnia.dts   |   20 +-
>  src/arm/marvell/armada-388-clearfog.dts       |   20 +-
>  src/arm/marvell/armada-388-gp.dts             |    4 +-
>  src/arm/marvell/armada-xp-linksys-mamba.dts   |   18 +-
>  src/arm/marvell/kirkwood-dnskw.dtsi           |    6 +-
>  src/arm/marvell/kirkwood-l-50.dts             |    2 +
>  .../marvell/kirkwood-linkstation-6282.dtsi    |    9 +-
>  .../marvell/kirkwood-linkstation-lswxl.dts    |    9 +-
>  src/arm/marvell/kirkwood-lsxl.dtsi            |    9 +-
>  src/arm/marvell/kirkwood-ns2max.dts           |   18 +-
>  src/arm/marvell/kirkwood-ns2mini.dts          |   18 +-
>  src/arm/marvell/kirkwood-synology.dtsi        |  102 +-
>  src/arm/marvell/mvebu-linkstation-fan.dtsi    |    8 +-
>  src/arm/microchip/at91-sam9x60_curiosity.dts  |    3 +
>  src/arm/microchip/at91-sam9x60ek.dts          |    3 +
>  src/arm/microchip/at91-sama5d27_som1_ek.dts   |    1 -
>  src/arm/microchip/at91-sama5d27_wlsom1_ek.dts |    1 -
>  src/arm/nuvoton/nuvoton-wpcm450.dtsi          |    2 +
>  src/arm/nvidia/tegra20-colibri.dtsi           |    2 +-
>  src/arm/nvidia/tegra30-apalis-v1.1.dtsi       |    1 -
>  src/arm/nvidia/tegra30-apalis.dtsi            |    1 -
>  src/arm/nvidia/tegra30-colibri.dtsi           |    1 -
>  src/arm/nxp/imx/imx1-ads.dts                  |    2 +-
>  src/arm/nxp/imx/imx1-apf9328.dts              |    2 +-
>  src/arm/nxp/imx/imx1.dtsi                     |    9 +-
>  src/arm/nxp/imx/imx25-eukrea-cpuimx25.dtsi    |    2 +-
>  ...25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts |    2 +-
>  ...25-eukrea-mbimxsd25-baseboard-dvi-svga.dts |    2 +-
>  ...x25-eukrea-mbimxsd25-baseboard-dvi-vga.dts |    2 +-
>  src/arm/nxp/imx/imx25-pdk.dts                 |    3 +-
>  src/arm/nxp/imx/imx25.dtsi                    |   41 +-
>  src/arm/nxp/imx/imx27-apf27dev.dts            |    4 +-
>  src/arm/nxp/imx/imx27-eukrea-cpuimx27.dtsi    |    4 +-
>  .../imx/imx27-eukrea-mbimxsd27-baseboard.dts  |    2 +-
>  src/arm/nxp/imx/imx27-pdk.dts                 |   18 +-
>  .../nxp/imx/imx27-phytec-phycard-s-rdk.dts    |    2 +-
>  src/arm/nxp/imx/imx27-phytec-phycore-rdk.dts  |   17 +-
>  src/arm/nxp/imx/imx27-phytec-phycore-som.dtsi |   28 +-
>  src/arm/nxp/imx/imx27.dtsi                    |    7 +-
>  src/arm/nxp/imx/imx53-cx9020.dts              |    2 +-
>  src/arm/nxp/imx/imx6dl-b105pv2.dts            |    2 +-
>  src/arm/nxp/imx/imx6dl-b105v2.dts             |    2 +-
>  src/arm/nxp/imx/imx6dl-b125pv2.dts            |    2 +-
>  src/arm/nxp/imx/imx6dl-b125v2.dts             |    2 +-
>  src/arm/nxp/imx/imx6dl-b155v2.dts             |    2 +-
>  src/arm/nxp/imx/imx6q-apalis-ixora-v1.2.dts   |    2 +
>  src/arm/nxp/imx/imx6q-b850v3.dts              |    3 -
>  src/arm/nxp/imx/imx6q-bx50v3.dtsi             |    2 +-
>  src/arm/nxp/imx/imx6q-var-mx6customboard.dts  |    4 +-
>  src/arm/nxp/imx/imx6qdl-apalis.dtsi           |   10 +-
>  src/arm/nxp/imx/imx6qdl-colibri.dtsi          |    8 +-
>  src/arm/nxp/imx/imx6qdl-emcon-avari.dtsi      |    2 +-
>  src/arm/nxp/imx/imx6qdl-emcon.dtsi            |    1 -
>  src/arm/nxp/imx/imx6qdl-mba6.dtsi             |    6 +-
>  src/arm/nxp/imx/imx6qdl-phytec-pfla02.dtsi    |    1 +
>  .../nxp/imx/imx6qdl-phytec-phycore-som.dtsi   |    1 +
>  src/arm/nxp/imx/imx6qdl-skov-cpu-revc.dtsi    |    2 +-
>  src/arm/nxp/imx/imx6qdl.dtsi                  |    2 +-
>  src/arm/nxp/imx/imx6sx.dtsi                   |    8 +-
>  src/arm/nxp/imx/imx6ul.dtsi                   |    2 +-
>  src/arm/nxp/imx/imx6ull-phytec-tauri.dtsi     |    2 +-
>  src/arm/nxp/imx/imx7-tqma7.dtsi               |    9 +-
>  src/arm/nxp/imx/imx7d-colibri-emmc.dtsi       |    4 +
>  src/arm/nxp/imx/imx7d-flex-concentrator.dts   |    2 +-
>  src/arm/nxp/imx/imx7d-meerkat96.dts           |    2 +-
>  src/arm/nxp/imx/imx7d-pico-dwarf.dts          |    1 +
>  src/arm/nxp/imx/imx7d-pico.dtsi               |    8 +
>  src/arm/nxp/imx/imx7d-smegw01.dts             |    2 +-
>  src/arm/nxp/imx/imx7d.dtsi                    |    3 -
>  src/arm/nxp/imx/imx7s.dtsi                    |   48 +-
>  src/arm/nxp/imx/mba6ulx.dtsi                  |    2 +-
>  src/arm/nxp/lpc/lpc18xx.dtsi                  |    2 +-
>  src/arm/nxp/ls/ls1021a.dtsi                   |    2 +-
>  src/arm/nxp/mxs/imx23-sansa.dts               |   12 +-
>  src/arm/nxp/mxs/imx23.dtsi                    |   10 +-
>  src/arm/nxp/mxs/imx28-lwe.dtsi                |    1 +
>  src/arm/nxp/mxs/imx28-tx28.dts                |    1 +
>  src/arm/nxp/mxs/imx28.dtsi                    |   14 +-
>  src/arm/nxp/vf/vf-colibri-eval-v3.dtsi        |    2 +-
>  src/arm/nxp/vf/vf610-bk4.dts                  |    4 +-
>  src/arm/nxp/vf/vf610-zii-cfu1.dts             |   14 +-
>  src/arm/nxp/vf/vf610-zii-dev-rev-b.dts        |    7 +-
>  src/arm/nxp/vf/vf610-zii-scu4-aib.dts         |   70 +-
>  src/arm/nxp/vf/vf610-zii-spb4.dts             |   18 +-
>  src/arm/nxp/vf/vf610-zii-ssmb-dtu.dts         |   20 +-
>  src/arm/nxp/vf/vf610-zii-ssmb-spu3.dts        |   18 +-
>  src/arm/qcom/pm8018.dtsi                      |   55 +
>  src/arm/qcom/pm8058.dtsi                      |  159 +
>  .../qcom/{qcom-pm8226.dtsi => pm8226.dtsi}    |    2 +
>  src/arm/qcom/pm8821.dtsi                      |   22 +
>  .../qcom/{qcom-pm8841.dtsi => pm8841.dtsi}    |    0
>  src/arm/qcom/pm8921.dtsi                      |  137 +
>  .../qcom/{qcom-pm8941.dtsi => pm8941.dtsi}    |    2 +
>  .../qcom/{qcom-pma8084.dtsi => pma8084.dtsi}  |    0
>  src/arm/qcom/{qcom-pmx55.dtsi => pmx55.dtsi}  |    0
>  src/arm/qcom/{qcom-pmx65.dtsi => pmx65.dtsi}  |    0
>  src/arm/qcom/qcom-apq8026-asus-sparrow.dts    |    4 +-
>  src/arm/qcom/qcom-apq8026-huawei-sturgeon.dts |    4 +-
>  src/arm/qcom/qcom-apq8026-lg-lenok.dts        |    4 +-
>  .../qcom-apq8026-samsung-matisse-wifi.dts     |    2 +-
>  src/arm/qcom/qcom-apq8060-dragonboard.dts     |  164 +-
>  src/arm/qcom/qcom-apq8064-asus-nexus7-flo.dts |   70 +-
>  src/arm/qcom/qcom-apq8064-cm-qs600.dts        |   35 +-
>  src/arm/qcom/qcom-apq8064-ifc6410.dts         |   42 +-
>  .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |  111 +-
>  src/arm/qcom/qcom-apq8064.dtsi                |  203 +-
>  src/arm/qcom/qcom-apq8074-dragonboard.dts     |   35 +-
>  src/arm/qcom/qcom-apq8084-ifc6540.dts         |    2 +-
>  src/arm/qcom/qcom-apq8084-mtp.dts             |    2 +-
>  src/arm/qcom/qcom-ipq4019-ap.dk04.1.dtsi      |    2 +-
>  src/arm/qcom/qcom-ipq4019.dtsi                |    4 +-
>  src/arm/qcom/qcom-ipq8064.dtsi                |    8 +-
>  .../qcom/qcom-mdm9615-wp8548-mangoh-green.dts |    4 +-
>  src/arm/qcom/qcom-mdm9615-wp8548.dtsi         |  143 +-
>  src/arm/qcom/qcom-mdm9615.dtsi                |  183 +-
>  .../qcom/qcom-msm8226-microsoft-common.dtsi   |  327 +
>  .../qcom/qcom-msm8226-microsoft-dempsey.dts   |   17 +
>  .../qcom/qcom-msm8226-microsoft-makepeace.dts |   17 +
>  .../qcom-msm8226-microsoft-moneypenny.dts     |   23 +
>  src/arm/qcom/qcom-msm8226.dtsi                |   48 +-
>  src/arm/qcom/qcom-msm8660-surf.dts            |   61 +-
>  src/arm/qcom/qcom-msm8660.dtsi                |  217 +-
>  src/arm/qcom/qcom-msm8926-htc-memul.dts       |  372 +
>  .../qcom-msm8926-microsoft-superman-lte.dts   |   53 +
>  src/arm/qcom/qcom-msm8926-microsoft-tesla.dts |   67 +
>  .../qcom/qcom-msm8926-motorola-peregrine.dts  |  291 +
>  src/arm/qcom/qcom-msm8960-cdp.dts             |   27 +-
>  .../qcom/qcom-msm8960-samsung-expressatt.dts  |    7 +-
>  src/arm/qcom/qcom-msm8960.dtsi                |   45 +-
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    |   33 +-
>  .../qcom/qcom-msm8974-sony-xperia-rhine.dtsi  |   35 +-
>  src/arm/qcom/qcom-msm8974.dtsi                |  122 +-
>  .../qcom/qcom-msm8974pro-fairphone-fp2.dts    |   33 +-
>  .../qcom/qcom-msm8974pro-oneplus-bacon.dts    |   35 +-
>  src/arm/qcom/qcom-msm8974pro-samsung-klte.dts |   13 +-
>  ...-msm8974pro-sony-xperia-shinano-castor.dts |   35 +-
>  src/arm/qcom/qcom-sdx55-mtp.dts               |    2 +-
>  src/arm/qcom/qcom-sdx55-t55.dts               |    2 +-
>  src/arm/qcom/qcom-sdx55-telit-fn980-tlb.dts   |    2 +-
>  src/arm/qcom/qcom-sdx55.dtsi                  |   63 +-
>  src/arm/qcom/qcom-sdx65-mtp.dts               |    2 +-
>  src/arm/qcom/qcom-sdx65.dtsi                  |   51 +-
>  src/arm/renesas/iwg20d-q7-dbcm-ca.dtsi        |   15 +
>  src/arm/renesas/r8a7740-armadillo800eva.dts   |   28 +-
>  src/arm/renesas/r8a7740.dtsi                  |   65 +
>  .../renesas/r8a7745-iwg22d-sodimm-dbhd-ca.dts |   15 +
>  src/arm/renesas/r8a7745-iwg22d-sodimm.dts     |    4 +-
>  src/arm/renesas/r8a7779-marzen.dts            |   48 +-
>  src/arm/renesas/r8a7790-lager.dts             |   24 +-
>  src/arm/renesas/r8a7790-stout.dts             |   16 +
>  src/arm/renesas/r8a7791-koelsch.dts           |   31 +-
>  src/arm/renesas/r8a7791-porter.dts            |   27 +-
>  src/arm/renesas/r8a7792-blanche.dts           |   50 +
>  src/arm/renesas/r8a7792-wheat.dts             |   21 +
>  src/arm/renesas/r8a7793-gose.dts              |   29 +-
>  src/arm/renesas/r8a7794-alt.dts               |    5 +-
>  src/arm/renesas/r8a7794-silk.dts              |   18 +-
>  src/arm/renesas/r9a06g032.dtsi                |    2 +-
>  src/arm/rockchip/rk3036-kylin.dts             |   21 +
>  src/arm/rockchip/rk3036.dtsi                  |   18 +-
>  src/arm/rockchip/rk3066a.dtsi                 |    5 +
>  src/arm/rockchip/rk3128-evb.dts               |    5 -
>  src/arm/rockchip/rk3128-xpi-3128.dts          |  425 ++
>  src/arm/rockchip/rk3128.dtsi                  |  185 +
>  src/arm/rockchip/rk322x.dtsi                  |    4 +
>  src/arm/rockchip/rk3288.dtsi                  |    9 +
>  src/arm/rockchip/rk3xxx.dtsi                  |    4 +
>  src/arm/rockchip/rv1108.dtsi                  |    8 -
>  src/arm/rockchip/rv1109-sonoff-ihost.dts      |   21 +
>  src/arm/rockchip/rv1109.dtsi                  |   23 +
>  src/arm/rockchip/rv1126-edgeble-neu2-io.dts   |    2 +-
>  src/arm/rockchip/rv1126-pinctrl.dtsi          |   72 +-
>  src/arm/rockchip/rv1126-sonoff-ihost.dts      |   29 +
>  src/arm/rockchip/rv1126-sonoff-ihost.dtsi     |  404 ++
>  src/arm/rockchip/rv1126.dtsi                  |   21 +
>  src/arm/samsung/exynos4.dtsi                  |   26 +-
>  src/arm/samsung/exynos4210-i9100.dts          |   48 +-
>  src/arm/samsung/exynos4212-tab3.dtsi          |    1 +
>  src/arm/samsung/exynos4x12.dtsi               |   22 +-
>  src/arm/samsung/s5pv210.dtsi                  |   18 +-
>  src/arm/st/ste-dbx5x0.dtsi                    |   18 +-
>  src/arm/st/ste-href-ab8500.dtsi               |   48 +
>  src/arm/st/ste-href-ab8505.dtsi               |  490 ++
>  src/arm/st/ste-href.dtsi                      |   55 -
>  src/arm/st/ste-href520-tvk.dts                |    1 +
>  src/arm/st/ste-hrefprev60-stuib.dts           |    1 +
>  src/arm/st/ste-hrefprev60-tvk.dts             |    1 +
>  src/arm/st/ste-hrefprev60.dtsi                |    2 +-
>  src/arm/st/ste-hrefv60plus-stuib.dts          |    1 +
>  src/arm/st/ste-hrefv60plus-tvk.dts            |    1 +
>  src/arm/st/ste-hrefv60plus.dtsi               |    3 +-
>  src/arm/st/ste-nomadik-stn8815.dtsi           |    8 +-
>  src/arm/st/ste-snowball.dts                   |    2 +-
>  src/arm/st/ste-ux500-samsung-codina-tmo.dts   |    2 +-
>  src/arm/st/ste-ux500-samsung-codina.dts       |    2 +-
>  src/arm/st/ste-ux500-samsung-gavini.dts       |    2 +-
>  src/arm/st/ste-ux500-samsung-janice.dts       |    2 +-
>  src/arm/st/ste-ux500-samsung-kyle.dts         |    2 +-
>  src/arm/st/stm32429i-eval.dts                 |    1 -
>  src/arm/st/stm32f469-disco.dts                |   15 +-
>  src/arm/st/stm32f746.dtsi                     |   61 +
>  src/arm/st/stm32mp135.dtsi                    |   11 +
>  src/arm/st/stm32mp151.dtsi                    |    4 +
>  src/arm/st/stm32mp151a-prtt1l.dtsi            |    2 -
>  src/arm/st/stm32mp157a-dk1-scmi.dts           |    4 +-
>  src/arm/st/stm32mp157a-stinger96.dtsi         |    2 -
>  src/arm/st/stm32mp157c-dk2-scmi.dts           |    4 +-
>  src/arm/st/stm32mp157c-dk2.dts                |    1 -
>  src/arm/st/stm32mp157c-ed1-scmi.dts           |    4 +-
>  src/arm/st/stm32mp157c-emstamp-argon.dtsi     |    4 -
>  src/arm/st/stm32mp157c-ev1-scmi.dts           |    5 +-
>  src/arm/st/stm32mp157c-ev1.dts                |    1 -
>  src/arm/st/stm32mp157c-osd32mp1-red.dts       |    4 -
>  .../st/stm32mp157c-phycore-stm32mp15-som.dtsi |    4 -
>  src/arm/st/stm32mp15xc-lxa-tac.dtsi           |    3 -
>  src/arm/st/stm32mp15xx-dhcom-drc02.dtsi       |    1 -
>  src/arm/st/stm32mp15xx-dhcom-pdk2.dtsi        |    1 -
>  src/arm/st/stm32mp15xx-dhcom-picoitx.dtsi     |    2 -
>  src/arm/st/stm32mp15xx-dhcor-avenger96.dtsi   |    2 -
>  src/arm/st/stm32mp15xx-dhcor-drc-compact.dtsi |    2 -
>  src/arm/st/stm32mp15xx-dhcor-testbench.dtsi   |    2 -
>  src/arm/st/stm32mp15xx-dkx.dtsi               |    1 -
>  src/arm/ti/keystone/keystone-k2e-netcp.dtsi   |    6 +-
>  src/arm/ti/keystone/keystone-k2g-evm.dts      |    2 +-
>  src/arm/ti/keystone/keystone-k2g-netcp.dtsi   |    6 +-
>  src/arm/ti/keystone/keystone-k2hk-evm.dts     |    2 +-
>  src/arm/ti/keystone/keystone-k2hk-netcp.dtsi  |    6 +-
>  src/arm/ti/keystone/keystone-k2l-netcp.dtsi   |    6 +-
>  .../ti/omap/am335x-moxa-uc-2100-common.dtsi   |    2 +-
>  src/arm/ti/omap/am571x-idk.dts                |    4 +-
>  src/arm/ti/omap/am5729-beagleboneai.dts       |    3 +-
>  src/arm/ti/omap/am572x-idk-common.dtsi        |    4 +-
>  src/arm/ti/omap/dra7-evm-common.dtsi          |    4 +-
>  src/arm/ti/omap/dra71-evm.dts                 |    4 +-
>  src/arm/ti/omap/dra72-evm-common.dtsi         |    4 +-
>  src/arm/ti/omap/dra76-evm.dts                 |    4 +-
>  .../ti/omap/logicpd-torpedo-37xx-devkit.dts   |    2 +-
>  src/arm/ti/omap/motorola-mapphone-common.dtsi |  298 -
>  .../ti/omap/motorola-mapphone-handset.dtsi    |  234 +
>  .../omap/motorola-mapphone-mz607-mz617.dtsi   |   21 +
>  src/arm/ti/omap/motorola-mapphone-xt8xx.dtsi  |   75 +
>  src/arm/ti/omap/omap4-droid-bionic-xt875.dts  |   11 +-
>  src/arm/ti/omap/omap4-droid4-xt894.dts        |   19 +-
>  src/arm/ti/omap/omap4-epson-embt2ws.dts       |   18 +-
>  src/arm/ti/omap/omap4-xyboard-mz609.dts       |   46 +
>  src/arm/ti/omap/omap4-xyboard-mz617.dts       |   17 +
>  .../allwinner/sun50i-h618-orangepi-zero2w.dts |  176 +
>  .../sun50i-h618-transpeed-8k618-t.dts         |  161 +
>  src/arm64/altera/socfpga_stratix10.dtsi       |   41 +-
>  src/arm64/altera/socfpga_stratix10_socdk.dts  |    8 +-
>  .../altera/socfpga_stratix10_socdk_nand.dts   |    6 +-
>  src/arm64/altera/socfpga_stratix10_swvp.dts   |    2 -
>  src/arm64/amazon/alpine-v2.dtsi               |    1 -
>  src/arm64/amazon/alpine-v3.dtsi               |    1 -
>  src/arm64/amlogic/amlogic-c3.dtsi             |    6 +
>  .../meson-axg-jethome-jethub-j110-rev-2.dts   |   14 +-
>  .../meson-axg-jethome-jethub-j110-rev-3.dts   |   12 +
>  src/arm64/amlogic/meson-axg-s400.dts          |    5 -
>  src/arm64/amlogic/meson-axg.dtsi              |   23 +
>  src/arm64/amlogic/meson-g12a-sei510.dts       |    1 -
>  src/arm64/amlogic/meson-g12a-x96-max.dts      |    1 -
>  .../amlogic/meson-g12b-bananapi-cm4.dtsi      |    2 +-
>  src/arm64/amlogic/meson-g12b-bananapi.dtsi    |    2 +-
>  src/arm64/amlogic/meson-g12b-gtking.dts       |    1 -
>  src/arm64/amlogic/meson-g12b-ugoos-am6.dts    |    1 -
>  src/arm64/amlogic/meson-gx-p23x-q20x.dtsi     |    1 -
>  src/arm64/amlogic/meson-gxbb-kii-pro.dts      |    1 -
>  src/arm64/amlogic/meson-gxbb-p200.dts         |    1 -
>  src/arm64/amlogic/meson-gxbb-vega-s95.dtsi    |    1 -
>  src/arm64/amlogic/meson-gxbb-wetek-play2.dts  |    1 -
>  src/arm64/amlogic/meson-gxm-nexbox-a1.dts     |    1 -
>  src/arm64/amlogic/meson-gxm-rbox-pro.dts      |    1 -
>  src/arm64/amlogic/meson-s4-s805x2-aq222.dts   |   60 +-
>  src/arm64/amlogic/meson-s4.dtsi               |  360 +-
>  src/arm64/amlogic/meson-sm1-sei610.dts        |    1 -
>  src/arm64/arm/juno-base.dtsi                  |   12 +-
>  src/arm64/arm/juno-scmi.dtsi                  |   12 +-
>  src/arm64/broadcom/northstar2/ns2.dtsi        |    1 +
>  src/arm64/broadcom/stingray/stingray.dtsi     |    1 +
>  src/arm64/exynos/exynos5433.dtsi              |   60 +-
>  src/arm64/exynos/exynos7.dtsi                 |   18 +-
>  src/arm64/exynos/exynos7885.dtsi              |   45 +-
>  src/arm64/exynos/exynos850.dtsi               |   40 +-
>  src/arm64/exynos/exynosautov9-sadk.dts        |   51 +
>  src/arm64/exynos/exynosautov9.dtsi            |   10 +-
>  src/arm64/exynos/exynosautov920-pinctrl.dtsi  | 1266 ++++
>  src/arm64/exynos/exynosautov920-sadk.dts      |   88 +
>  src/arm64/exynos/exynosautov920.dtsi          |  312 +
>  src/arm64/exynos/google/gs101-oriole.dts      |  105 +
>  src/arm64/exynos/google/gs101-pinctrl.dtsi    | 1249 ++++
>  src/arm64/exynos/google/gs101-pinctrl.h       |   33 +
>  src/arm64/exynos/google/gs101.dtsi            |  473 ++
>  src/arm64/freescale/fsl-ls1012a.dtsi          |   80 +-
>  src/arm64/freescale/fsl-ls1028a.dtsi          |   87 +-
>  src/arm64/freescale/fsl-ls1043a.dtsi          |   81 +-
>  src/arm64/freescale/fsl-ls1046a.dtsi          |   74 +-
>  src/arm64/freescale/fsl-ls1088a.dtsi          |   74 +-
>  src/arm64/freescale/fsl-ls208xa.dtsi          |   73 +-
>  .../fsl-lx2160a-tqmlx2160a-mblx2160a.dts      |  338 +
>  ...l-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso |   29 +
>  ...l-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso |   17 +
>  ...l-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso |   49 +
>  ...sl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso |   55 +
>  ...sl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso |   47 +
>  .../freescale/fsl-lx2160a-tqmlx2160a.dtsi     |   97 +
>  src/arm64/freescale/fsl-lx2160a.dtsi          |    4 +-
>  .../freescale/imx8-apalis-ixora-v1.2.dtsi     |    2 +
>  src/arm64/freescale/imx8-ss-audio.dtsi        |    2 -
>  src/arm64/freescale/imx8dxl-ss-conn.dtsi      |   16 +-
>  src/arm64/freescale/imx8dxl-ss-ddr.dtsi       |    2 +-
>  src/arm64/freescale/imx8mm-beacon-som.dtsi    |    2 +
>  src/arm64/freescale/imx8mm-emcon-avari.dtsi   |    2 +-
>  src/arm64/freescale/imx8mm-evk.dtsi           |   12 +-
>  src/arm64/freescale/imx8mm-nitrogen-r2.dts    |    2 +-
>  src/arm64/freescale/imx8mm-overdrive.dtsi     |   29 +
>  .../freescale/imx8mm-phygate-tauri-l.dts      |    2 +-
>  .../freescale/imx8mm-tqma8mqml-mba8mx.dts     |    1 +
>  src/arm64/freescale/imx8mm-venice-gw72xx.dtsi |   39 +-
>  src/arm64/freescale/imx8mm-venice-gw73xx.dtsi |   31 +-
>  src/arm64/freescale/imx8mm-venice-gw7902.dts  |   13 +-
>  src/arm64/freescale/imx8mm-verdin-mallow.dtsi |  173 +
>  .../imx8mm-verdin-nonwifi-mallow.dts          |   18 +
>  .../freescale/imx8mm-verdin-wifi-mallow.dts   |   18 +
>  src/arm64/freescale/imx8mm.dtsi               |   18 +-
>  src/arm64/freescale/imx8mn-beacon-som.dtsi    |    2 +
>  .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |    1 +
>  .../freescale/imx8mn-bsh-smm-s2-display.dtsi  |  121 +
>  .../freescale/imx8mn-dimonoff-gateway-evk.dts |  160 +
>  src/arm64/freescale/imx8mn-evk.dtsi           |   12 +-
>  src/arm64/freescale/imx8mn-overdrive.dtsi     |   18 +
>  src/arm64/freescale/imx8mn-rve-gateway.dts    |  285 +
>  .../freescale/imx8mn-tqma8mqnl-mba8mx.dts     |    1 +
>  .../freescale/imx8mn-var-som-symphony.dts     |   10 +
>  src/arm64/freescale/imx8mn-var-som.dtsi       |    9 +
>  src/arm64/freescale/imx8mn.dtsi               |    2 +
>  src/arm64/freescale/imx8mp-beacon-kit.dts     |   94 +-
>  .../freescale/imx8mp-data-modul-edm-sbc.dts   |    2 +-
>  src/arm64/freescale/imx8mp-debix-model-a.dts  |    2 +-
>  .../freescale/imx8mp-debix-som-a-bmb-08.dts   |   56 +
>  src/arm64/freescale/imx8mp-debix-som-a.dtsi   |   22 +
>  src/arm64/freescale/imx8mp-dhcom-som.dtsi     |   14 +-
>  src/arm64/freescale/imx8mp-evk.dts            |   22 +
>  src/arm64/freescale/imx8mp-msc-sm2s-ep1.dts   |    4 +-
>  src/arm64/freescale/imx8mp-skov-reva.dtsi     |  711 ++
>  src/arm64/freescale/imx8mp-skov-revb-hdmi.dts |   20 +
>  src/arm64/freescale/imx8mp-skov-revb-lt6.dts  |  101 +
>  .../imx8mp-skov-revb-mi1010ait-1cp1.dts       |  100 +
>  ...8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtso |   77 +
>  .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   |   37 +-
>  src/arm64/freescale/imx8mp-venice-gw71xx.dtsi |   26 +-
>  src/arm64/freescale/imx8mp-venice-gw72xx.dtsi |   36 +-
>  src/arm64/freescale/imx8mp-venice-gw73xx.dtsi |   28 +-
>  src/arm64/freescale/imx8mp-venice-gw74xx.dts  |   30 +-
>  src/arm64/freescale/imx8mp-verdin-mallow.dtsi |  199 +
>  .../imx8mp-verdin-nonwifi-mallow.dts          |   18 +
>  .../freescale/imx8mp-verdin-wifi-mallow.dts   |   18 +
>  src/arm64/freescale/imx8mp-verdin.dtsi        |   30 +-
>  src/arm64/freescale/imx8mp.dtsi               |   30 +-
>  .../freescale/imx8mq-kontron-pitx-imx8m.dts   |    2 +-
>  src/arm64/freescale/imx8mq-phanbell.dts       |    2 +-
>  src/arm64/freescale/imx8mq-tqma8mq-mba8mx.dts |    1 +
>  src/arm64/freescale/imx8qm-ss-dma.dtsi        |    4 +
>  src/arm64/freescale/imx8qxp-mek.dts           |   21 +-
>  src/arm64/freescale/imx8qxp-ss-vpu.dtsi       |   17 +
>  src/arm64/freescale/imx8qxp.dtsi              |    3 +-
>  src/arm64/freescale/imx93-11x11-evk.dts       |   31 +-
>  .../freescale/imx93-tqma9352-mba93xxca.dts    |  709 ++
>  .../freescale/imx93-tqma9352-mba93xxla.dts    |    1 +
>  src/arm64/freescale/imx93.dtsi                |  127 +-
>  src/arm64/hisilicon/hikey970-pmic.dtsi        |    6 +-
>  src/arm64/intel/socfpga_agilex.dtsi           |   42 +-
>  src/arm64/intel/socfpga_agilex5.dtsi          |    4 +-
>  src/arm64/intel/socfpga_agilex_n6000.dts      |    2 +-
>  src/arm64/intel/socfpga_agilex_socdk.dts      |    2 -
>  src/arm64/intel/socfpga_n5x_socdk.dts         |    5 +-
>  src/arm64/lg/lg1312.dtsi                      |    1 -
>  src/arm64/lg/lg1313.dtsi                      |    1 -
>  src/arm64/marvell/ac5x-rd-carrier-cn9131.dts  |   44 +
>  src/arm64/marvell/ac5x-rd-carrier.dtsi        |   34 +
>  .../marvell/armada-3720-espressobin-ultra.dts |   14 +-
>  .../marvell/armada-3720-espressobin.dtsi      |   20 +-
>  src/arm64/marvell/armada-3720-gl-mv1000.dts   |   20 +-
>  src/arm64/marvell/armada-3720-turris-mox.dts  |   99 +-
>  src/arm64/marvell/armada-7040-mochabin.dts    |   24 +-
>  .../marvell/armada-8040-clearfog-gt-8k.dts    |   22 +-
>  src/arm64/marvell/armada-ap80x.dtsi           |    1 -
>  src/arm64/marvell/cn9130-crb.dtsi             |   42 +-
>  src/arm64/marvell/cn9130-db-comexpress.dtsi   |   96 +
>  src/arm64/marvell/cn9131-db-comexpress.dtsi   |  108 +
>  src/arm64/mediatek/mt6358.dtsi                |   26 +-
>  .../mediatek/mt7622-bananapi-bpi-r64.dts      |    3 +-
>  .../mediatek/mt7986a-bananapi-bpi-r3.dts      |    3 +-
>  src/arm64/mediatek/mt8173-elm-hana.dtsi       |    9 +-
>  src/arm64/mediatek/mt8173-elm.dtsi            |   24 +-
>  src/arm64/mediatek/mt8173-evb.dts             |    3 +-
>  src/arm64/mediatek/mt8173.dtsi                |    8 +-
>  src/arm64/mediatek/mt8183-evb.dts             |    4 +
>  .../mediatek/mt8183-kukui-audio-da7219.dtsi   |    3 +-
>  .../mediatek/mt8183-kukui-audio-ts3a227e.dtsi |    3 +-
>  .../mediatek/mt8183-kukui-jacuzzi-damu.dts    |    3 +-
>  .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |    3 +-
>  .../mt8183-kukui-jacuzzi-fennel-sku6.dts      |    3 +-
>  .../mt8183-kukui-jacuzzi-fennel-sku7.dts      |    3 +-
>  .../mt8183-kukui-jacuzzi-makomo-sku0.dts      |   24 +
>  .../mt8183-kukui-jacuzzi-makomo-sku1.dts      |   24 +
>  .../mediatek/mt8183-kukui-jacuzzi-pico.dts    |   35 +
>  .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  110 +
>  src/arm64/mediatek/mt8183-kukui-jacuzzi.dtsi  |    1 -
>  .../mediatek/mt8183-kukui-kakadu-sku22.dts    |   18 +
>  src/arm64/mediatek/mt8183-kukui-kakadu.dts    |   18 +
>  src/arm64/mediatek/mt8183-kukui-kakadu.dtsi   |   15 +-
>  .../mediatek/mt8183-kukui-katsu-sku32.dts     |   36 +
>  .../mediatek/mt8183-kukui-katsu-sku38.dts     |   40 +
>  src/arm64/mediatek/mt8183-kukui-kodama.dtsi   |    3 +-
>  src/arm64/mediatek/mt8183-kukui-krane.dtsi    |    3 +-
>  src/arm64/mediatek/mt8183-kukui.dtsi          |   12 +-
>  src/arm64/mediatek/mt8183-pumpkin.dts         |    4 +
>  src/arm64/mediatek/mt8183.dtsi                |   62 +-
>  src/arm64/mediatek/mt8186.dtsi                |    6 +-
>  src/arm64/mediatek/mt8188-evb.dts             |  387 ++
>  src/arm64/mediatek/mt8188.dtsi                |  956 +++
>  src/arm64/mediatek/mt8192-asurada.dtsi        |    2 +-
>  src/arm64/mediatek/mt8192.dtsi                |  466 ++
>  src/arm64/mediatek/mt8195-cherry.dtsi         |  117 +-
>  src/arm64/mediatek/mt8195-demo.dts            |    1 +
>  src/arm64/mediatek/mt8195.dtsi                |  483 +-
>  src/arm64/mediatek/mt8395-genio-1200-evk.dts  |    6 +-
>  .../nvidia/tegra234-p3737-0000+p3701-0000.dts |    2 +-
>  src/arm64/nvidia/tegra234.dtsi                |    6 +-
>  src/arm64/qcom/ipq5018-rdp432-c2.dts          |   12 +
>  src/arm64/qcom/ipq5018.dtsi                   |  142 +
>  src/arm64/qcom/ipq5332-rdp-common.dtsi        |    3 +
>  src/arm64/qcom/ipq5332-rdp441.dts             |    2 +-
>  src/arm64/qcom/ipq5332-rdp442.dts             |    2 +-
>  src/arm64/qcom/ipq5332-rdp474.dts             |    2 +-
>  src/arm64/qcom/ipq5332.dtsi                   |   23 +-
>  src/arm64/qcom/ipq6018.dtsi                   |  129 +-
>  src/arm64/qcom/ipq8074.dtsi                   |  126 +-
>  src/arm64/qcom/ipq9574-rdp-common.dtsi        |  169 +
>  src/arm64/qcom/ipq9574-rdp418.dts             |   63 +-
>  src/arm64/qcom/ipq9574-rdp433.dts             |   91 +-
>  src/arm64/qcom/ipq9574-rdp449.dts             |   65 +-
>  src/arm64/qcom/ipq9574-rdp453.dts             |   65 +-
>  src/arm64/qcom/ipq9574-rdp454.dts             |   66 +-
>  src/arm64/qcom/ipq9574.dtsi                   |   25 +-
>  src/arm64/qcom/msm8916-acer-a1-724.dts        |   24 +
>  src/arm64/qcom/msm8916-alcatel-idol347.dts    |  173 +-
>  src/arm64/qcom/msm8916-asus-z00l.dts          |   21 +
>  src/arm64/qcom/msm8916-longcheer-l8150.dts    |   75 +-
>  src/arm64/qcom/msm8916-longcheer-l8910.dts    |  103 +
>  src/arm64/qcom/msm8916-modem-qdsp6.dtsi       |  148 +
>  .../qcom/msm8916-samsung-a2015-common.dtsi    |   71 +
>  src/arm64/qcom/msm8916-samsung-a3u-eur.dts    |   10 +-
>  .../qcom/msm8916-samsung-e2015-common.dtsi    |    4 +
>  src/arm64/qcom/msm8916-samsung-grandmax.dts   |    4 +
>  .../qcom/msm8916-samsung-gt5-common.dtsi      |   92 +-
>  src/arm64/qcom/msm8916-samsung-gt510.dts      |   26 +
>  src/arm64/qcom/msm8916-samsung-gt58.dts       |   46 +
>  src/arm64/qcom/msm8916-samsung-j5-common.dtsi |   14 +
>  src/arm64/qcom/msm8916-samsung-j5.dts         |    4 +
>  src/arm64/qcom/msm8916-samsung-serranove.dts  |   13 +
>  src/arm64/qcom/msm8916-thwc-uf896.dts         |    8 +-
>  src/arm64/qcom/msm8916-thwc-ufi001c.dts       |    8 +-
>  src/arm64/qcom/msm8916-wingtech-wt88047.dts   |   75 +
>  src/arm64/qcom/msm8916-yiming-uz801v3.dts     |    8 +-
>  src/arm64/qcom/msm8916.dtsi                   |   59 +-
>  src/arm64/qcom/msm8939-huawei-kiwi.dts        |  242 +
>  src/arm64/qcom/msm8939-longcheer-l9100.dts    |   56 +
>  src/arm64/qcom/msm8939-samsung-a7.dts         |   70 +
>  src/arm64/qcom/msm8939.dtsi                   |   94 +-
>  src/arm64/qcom/msm8953-xiaomi-mido.dts        |    1 +
>  src/arm64/qcom/msm8953-xiaomi-tissot.dts      |    1 +
>  src/arm64/qcom/msm8953-xiaomi-vince.dts       |    1 +
>  src/arm64/qcom/msm8953.dtsi                   |  110 +-
>  src/arm64/qcom/msm8996.dtsi                   |  129 +-
>  src/arm64/qcom/msm8998.dtsi                   |   92 +-
>  src/arm64/qcom/pm7250b.dtsi                   |    2 +-
>  src/arm64/qcom/pm8550.dtsi                    |    3 -
>  src/arm64/qcom/pm8550ve.dtsi                  |    6 +-
>  src/arm64/qcom/pm8916.dtsi                    |   48 +
>  src/arm64/qcom/pmk8350.dtsi                   |    2 +-
>  src/arm64/qcom/qcm2290.dtsi                   |  504 +-
>  src/arm64/qcom/qcm6490-fairphone-fp5.dts      |  288 +-
>  src/arm64/qcom/qcm6490-idp.dts                |  468 ++
>  src/arm64/qcom/qcs404.dtsi                    |   11 +-
>  src/arm64/qcom/qcs6490-rb3gen2.dts            |  455 ++
>  src/arm64/qcom/qdu1000.dtsi                   |   23 +-
>  src/arm64/qcom/qrb2210-rb1.dts                |  113 +
>  src/arm64/qcom/qrb4210-rb2.dts                |  112 +-
>  .../qcom/qrb5165-rb5-vision-mezzanine.dts     |    2 +-
>  src/arm64/qcom/qrb5165-rb5.dts                |   33 +-
>  src/arm64/qcom/sa8775p-ride.dts               |    5 +
>  src/arm64/qcom/sa8775p.dtsi                   | 1124 ++-
>  src/arm64/qcom/sc7180-acer-aspire1.dts        |  174 +-
>  src/arm64/qcom/sc7180-trogdor-pompom.dtsi     |    2 +-
>  src/arm64/qcom/sc7180.dtsi                    |   14 +-
>  src/arm64/qcom/sc7280-chrome-common.dtsi      |   37 +-
>  src/arm64/qcom/sc7280-herobrine-lte-sku.dtsi  |    7 +-
>  src/arm64/qcom/sc7280-herobrine-wifi-sku.dtsi |    1 +
>  src/arm64/qcom/sc7280-idp.dtsi                |   19 +
>  src/arm64/qcom/sc7280.dtsi                    |  581 +-
>  src/arm64/qcom/sc8180x-lenovo-flex-5g.dts     |    4 +-
>  src/arm64/qcom/sc8180x-primus.dts             |   12 +-
>  src/arm64/qcom/sc8180x.dtsi                   |   61 +-
>  src/arm64/qcom/sc8280xp-crd.dts               |    4 +
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   14 +
>  src/arm64/qcom/sc8280xp.dtsi                  |   24 +-
>  src/arm64/qcom/sdm630.dtsi                    |   53 +-
>  src/arm64/qcom/sdm632-fairphone-fp3.dts       |   19 +
>  src/arm64/qcom/sdm670.dtsi                    |  302 +-
>  src/arm64/qcom/sdm845-db845c.dts              |    4 +-
>  src/arm64/qcom/sdm845-oneplus-common.dtsi     |   23 +
>  src/arm64/qcom/sdm845-wcd9340.dtsi            |    2 +-
>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |   22 +
>  src/arm64/qcom/sdm845.dtsi                    |  127 +-
>  src/arm64/qcom/sdm850-lenovo-yoga-c630.dts    |    8 +-
>  src/arm64/qcom/sdm850-samsung-w737.dts        |    2 +-
>  src/arm64/qcom/sdx75-idp.dts                  |   29 +
>  src/arm64/qcom/sdx75.dtsi                     |  170 +
>  src/arm64/qcom/sm4450-qrd.dts                 |   18 +-
>  src/arm64/qcom/sm4450.dtsi                    |  107 +
>  src/arm64/qcom/sm6115.dtsi                    |  345 +-
>  src/arm64/qcom/sm6125.dtsi                    |    4 +
>  src/arm64/qcom/sm6350.dtsi                    |   20 +-
>  .../qcom/sm6375-sony-xperia-murray-pdx225.dts |   43 +-
>  src/arm64/qcom/sm6375.dtsi                    |   84 +-
>  src/arm64/qcom/sm8150-hdk.dts                 |  264 +-
>  src/arm64/qcom/sm8150.dtsi                    |  223 +-
>  .../qcom/sm8250-xiaomi-elish-common.dtsi      |   47 +-
>  src/arm64/qcom/sm8250-xiaomi-pipa.dts         |  623 ++
>  src/arm64/qcom/sm8250.dtsi                    |  143 +-
>  src/arm64/qcom/sm8350.dtsi                    |  147 +-
>  src/arm64/qcom/sm8450-hdk.dts                 |    8 +
>  src/arm64/qcom/sm8450.dtsi                    |  285 +-
>  src/arm64/qcom/sm8550-mtp.dts                 |  129 +
>  src/arm64/qcom/sm8550-qrd.dts                 |  136 +
>  src/arm64/qcom/sm8550.dtsi                    |  317 +-
>  src/arm64/qcom/sm8650-mtp.dts                 |  727 ++
>  src/arm64/qcom/sm8650-qrd.dts                 |  811 +++
>  src/arm64/qcom/sm8650.dtsi                    | 6013 +++++++++++++++++
>  src/arm64/qcom/x1e80100-crd.dts               |  424 ++
>  src/arm64/qcom/x1e80100-qcp.dts               |  399 ++
>  src/arm64/qcom/x1e80100.dtsi                  | 3527 ++++++++++
>  src/arm64/renesas/draak.dtsi                  |   32 +-
>  src/arm64/renesas/ebisu.dtsi                  |    6 +
>  src/arm64/renesas/r8a77970-eagle.dts          |   15 +
>  .../renesas/r8a779g0-white-hawk-cpu.dtsi      |    3 +
>  src/arm64/renesas/r9a08g045.dtsi              |  106 +
>  src/arm64/renesas/r9a09g011.dtsi              |    2 +-
>  src/arm64/renesas/rzg2l-smarc-som.dtsi        |    1 +
>  src/arm64/renesas/rzg2lc-smarc-som.dtsi       |    1 +
>  src/arm64/renesas/rzg3s-smarc-som.dtsi        |  210 +-
>  src/arm64/renesas/rzg3s-smarc.dtsi            |   65 +
>  src/arm64/renesas/ulcb-kf.dtsi                |    4 +
>  src/arm64/rockchip/px30-engicam-common.dtsi   |    1 +
>  src/arm64/rockchip/px30-evb.dts               |    1 +
>  src/arm64/rockchip/px30-ringneck-haikou.dts   |    1 +
>  src/arm64/rockchip/px30.dtsi                  |    3 +-
>  src/arm64/rockchip/rk3308-rock-pi-s.dts       |   62 +
>  src/arm64/rockchip/rk3308.dtsi                |    5 +
>  src/arm64/rockchip/rk3318-a95x-z2.dts         |    1 +
>  src/arm64/rockchip/rk3326-anbernic-rg351m.dts |   18 +-
>  .../rockchip/rk3326-anbernic-rg351m.dtsi      |  478 ++
>  src/arm64/rockchip/rk3326-anbernic-rg351v.dts |   44 +
>  src/arm64/rockchip/rk3328-a1.dts              |    1 +
>  src/arm64/rockchip/rk3328-evb.dts             |    1 +
>  src/arm64/rockchip/rk3328-nanopi-r2s.dts      |    1 +
>  .../rockchip/rk3328-orangepi-r1-plus-lts.dts  |    4 +-
>  .../rockchip/rk3328-orangepi-r1-plus.dts      |    1 +
>  src/arm64/rockchip/rk3328-roc-cc.dts          |    1 +
>  src/arm64/rockchip/rk3328-rock-pi-e.dts       |   55 +
>  src/arm64/rockchip/rk3328-rock64.dts          |    1 +
>  src/arm64/rockchip/rk3328.dtsi                |   11 +-
>  src/arm64/rockchip/rk3368-evb.dtsi            |    1 +
>  src/arm64/rockchip/rk3368-geekbox.dts         |    1 +
>  src/arm64/rockchip/rk3368-lion.dtsi           |    1 +
>  src/arm64/rockchip/rk3368-orion-r68-meta.dts  |    1 +
>  src/arm64/rockchip/rk3368-r88.dts             |    1 +
>  src/arm64/rockchip/rk3368.dtsi                |    5 +-
>  src/arm64/rockchip/rk3399-eaidk-610.dts       |    1 +
>  src/arm64/rockchip/rk3399-evb.dts             |    1 +
>  src/arm64/rockchip/rk3399-ficus.dts           |    4 +
>  src/arm64/rockchip/rk3399-firefly.dts         |    1 +
>  src/arm64/rockchip/rk3399-gru-bob.dts         |    2 +-
>  src/arm64/rockchip/rk3399-gru-scarlet.dtsi    |    2 +-
>  src/arm64/rockchip/rk3399-hugsun-x99.dts      |    1 +
>  .../rockchip/rk3399-khadas-edge-captain.dts   |    4 +
>  src/arm64/rockchip/rk3399-khadas-edge-v.dts   |    4 +
>  src/arm64/rockchip/rk3399-kobol-helios64.dts  |    1 +
>  src/arm64/rockchip/rk3399-leez-p710.dts       |    1 +
>  src/arm64/rockchip/rk3399-nanopi4.dtsi        |    1 +
>  src/arm64/rockchip/rk3399-orangepi.dts        |    1 +
>  src/arm64/rockchip/rk3399-puma-haikou.dts     |   42 +-
>  src/arm64/rockchip/rk3399-puma.dtsi           |   15 +
>  src/arm64/rockchip/rk3399-roc-pc.dtsi         |    1 +
>  src/arm64/rockchip/rk3399-rock-4c-plus.dts    |    1 +
>  src/arm64/rockchip/rk3399-rock-pi-4.dtsi      |    1 +
>  src/arm64/rockchip/rk3399-rockpro64.dtsi      |    1 +
>  src/arm64/rockchip/rk3399-sapphire.dtsi       |    3 +-
>  src/arm64/rockchip/rk3399.dtsi                |    7 +-
>  src/arm64/rockchip/rk3399pro-vmarc-som.dtsi   |    1 +
>  src/arm64/rockchip/rk3566-lubancat-1.dts      |    2 +-
>  src/arm64/rockchip/rk3566-powkiddy-rgb30.dts  |  154 +-
>  src/arm64/rockchip/rk3566-powkiddy-rk2023.dts |   38 +
>  .../rockchip/rk3566-powkiddy-rk2023.dtsi      |  875 +++
>  src/arm64/rockchip/rk3566-powkiddy-x55.dts    |  926 +++
>  src/arm64/rockchip/rk3566-quartz64-a.dts      |    5 +-
>  src/arm64/rockchip/rk3566-radxa-cm3-io.dts    |    1 +
>  src/arm64/rockchip/rk3566-roc-pc.dts          |    1 +
>  src/arm64/rockchip/rk3566-soquartz-blade.dts  |    4 +
>  src/arm64/rockchip/rk3566-soquartz-cm4.dts    |    4 +
>  .../rockchip/rk3566-soquartz-model-a.dts      |    4 +
>  src/arm64/rockchip/rk3566-soquartz.dtsi       |    1 -
>  src/arm64/rockchip/rk3588-coolpi-cm5-evb.dts  |  216 +
>  src/arm64/rockchip/rk3588-coolpi-cm5.dtsi     |  650 ++
>  .../rockchip/rk3588-edgeble-neu6a-io.dts      |    4 -
>  .../rockchip/rk3588-edgeble-neu6b-io.dts      |    6 +-
>  src/arm64/rockchip/rk3588-evb1-v10.dts        |  100 +-
>  src/arm64/rockchip/rk3588-jaguar.dts          |  802 +++
>  src/arm64/rockchip/rk3588-nanopc-t6.dts       |   18 +-
>  src/arm64/rockchip/rk3588-orangepi-5-plus.dts |    1 -
>  src/arm64/rockchip/rk3588-quartzpro64.dts     |    2 +-
>  src/arm64/rockchip/rk3588-rock-5b.dts         |   13 +-
>  src/arm64/rockchip/rk3588-turing-rk1.dtsi     |    2 -
>  src/arm64/rockchip/rk3588s-coolpi-4b.dts      |  812 +++
>  .../rockchip/rk3588s-indiedroid-nova.dts      |   11 +-
>  src/arm64/rockchip/rk3588s-khadas-edge2.dts   |    1 -
>  src/arm64/rockchip/rk3588s-orangepi-5.dts     |    7 +-
>  src/arm64/rockchip/rk3588s-rock-5a.dts        |   10 +-
>  src/arm64/rockchip/rk3588s.dtsi               |  116 +
>  src/arm64/sprd/ums512.dtsi                    |   39 +-
>  src/arm64/sprd/ums9620-2h10.dts               |   38 +
>  src/arm64/sprd/ums9620.dtsi                   |  245 +
>  src/arm64/st/stm32mp251.dtsi                  |   16 +
>  src/arm64/tesla/fsd.dtsi                      |   53 +-
>  src/arm64/ti/k3-am62-main.dtsi                |   96 +-
>  src/arm64/ti/k3-am62-verdin-dahlia.dtsi       |    3 +-
>  src/arm64/ti/k3-am62-verdin-dev.dtsi          |    3 +-
>  src/arm64/ti/k3-am62-verdin-mallow.dtsi       |  188 +
>  src/arm64/ti/k3-am62-verdin-yavia.dtsi        |    3 +-
>  src/arm64/ti/k3-am62-verdin.dtsi              |   17 +-
>  .../ti/k3-am625-beagleplay-csi2-ov5640.dtso   |   77 +
>  .../k3-am625-beagleplay-csi2-tevi-ov5640.dtso |   77 +
>  src/arm64/ti/k3-am625-beagleplay.dts          |    4 +-
>  src/arm64/ti/k3-am625-phyboard-lyra-rdk.dts   |   98 +-
>  .../ti/k3-am625-verdin-nonwifi-mallow.dts     |   22 +
>  src/arm64/ti/k3-am625-verdin-wifi-mallow.dts  |   22 +
>  src/arm64/ti/k3-am62a-main.dtsi               |  121 +-
>  src/arm64/ti/k3-am62a7-sk.dts                 |   39 +
>  src/arm64/ti/k3-am62p-main.dtsi               |   18 +-
>  src/arm64/ti/k3-am62p5-sk.dts                 |    9 +
>  src/arm64/ti/k3-am62x-sk-common.dtsi          |   16 +
>  src/arm64/ti/k3-am62x-sk-csi2-imx219.dtso     |   84 +
>  src/arm64/ti/k3-am62x-sk-csi2-ov5640.dtso     |   82 +
>  .../ti/k3-am62x-sk-csi2-tevi-ov5640.dtso      |   82 +
>  src/arm64/ti/k3-am64-main.dtsi                |   22 +-
>  src/arm64/ti/k3-am64-phycore-som.dtsi         |  103 +-
>  src/arm64/ti/k3-am642-evm.dts                 |   12 +-
>  .../ti/k3-am642-phyboard-electra-rdk.dts      |    1 +
>  src/arm64/ti/k3-am642-sk.dts                  |   10 +-
>  src/arm64/ti/k3-am642-tqma64xxl-mbax4xxl.dts  |    1 -
>  src/arm64/ti/k3-am642-tqma64xxl.dtsi          |    1 +
>  src/arm64/ti/k3-am65-iot2050-common-pg1.dtsi  |   10 +-
>  src/arm64/ti/k3-am65-iot2050-common-pg2.dtsi  |    4 +-
>  src/arm64/ti/k3-am65-iot2050-common.dtsi      |  826 ++-
>  src/arm64/ti/k3-am65-main.dtsi                |   16 +-
>  src/arm64/ti/k3-am65-mcu.dtsi                 |    8 +-
>  src/arm64/ti/k3-am65-wakeup.dtsi              |   13 +-
>  src/arm64/ti/k3-am652.dtsi                    |   74 +
>  .../ti/k3-am6528-iot2050-basic-common.dtsi    |   16 +-
>  src/arm64/ti/k3-am654-base-board.dts          |    2 +
>  .../ti/k3-am6548-iot2050-advanced-common.dtsi |    2 +
>  .../ti/k3-am6548-iot2050-advanced-m2.dts      |   12 +-
>  src/arm64/ti/k3-am68-sk-base-board.dts        |    1 +
>  src/arm64/ti/k3-am69-sk.dts                   |   96 +-
>  src/arm64/ti/k3-j7200-main.dtsi               |    9 +-
>  src/arm64/ti/k3-j7200-mcu-wakeup.dtsi         |   21 +-
>  src/arm64/ti/k3-j7200-som-p0.dtsi             |  153 +
>  src/arm64/ti/k3-j721e-evm-pcie0-ep.dtso       |   53 +
>  src/arm64/ti/k3-j721e-main.dtsi               |    8 +-
>  src/arm64/ti/k3-j721e-mcu-wakeup.dtsi         |   21 +-
>  src/arm64/ti/k3-j721e-sk.dts                  |  151 +
>  src/arm64/ti/k3-j721e-som-p0.dtsi             |  160 +
>  src/arm64/ti/k3-j721s2-evm-pcie1-ep.dtso      |   53 +
>  src/arm64/ti/k3-j721s2-main.dtsi              |    9 +-
>  src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi        |   21 +-
>  src/arm64/ti/k3-j721s2-som-p0.dtsi            |  193 +
>  src/arm64/ti/k3-j784s4-evm.dts                |  102 +
>  src/arm64/ti/k3-j784s4-main.dtsi              |    9 +-
>  src/arm64/ti/k3-j784s4-mcu-wakeup.dtsi        |   22 +-
>  src/arm64/xilinx/zynqmp-sck-kv-g-revA.dtso    |   40 +-
>  src/arm64/xilinx/zynqmp-sck-kv-g-revB.dtso    |   42 +-
>  src/arm64/xilinx/zynqmp-sm-k26-revA.dts       |    8 +-
>  src/arm64/xilinx/zynqmp-zc1751-xm015-dc1.dts  |    8 +-
>  src/arm64/xilinx/zynqmp-zc1751-xm016-dc2.dts  |   16 +-
>  src/arm64/xilinx/zynqmp-zc1751-xm017-dc3.dts  |    8 +-
>  src/arm64/xilinx/zynqmp-zc1751-xm018-dc4.dts  |   26 +-
>  src/arm64/xilinx/zynqmp-zc1751-xm019-dc5.dts  |    8 +-
>  src/arm64/xilinx/zynqmp-zcu100-revC.dts       |    4 +-
>  src/arm64/xilinx/zynqmp.dtsi                  |   15 +-
>  src/loongarch/loongson-2k0500-ref.dts         |   88 +
>  src/loongarch/loongson-2k0500.dtsi            |  266 +
>  src/loongarch/loongson-2k1000-ref.dts         |  183 +
>  src/loongarch/loongson-2k1000.dtsi            |  492 ++
>  src/loongarch/loongson-2k2000-ref.dts         |   72 +
>  src/loongarch/loongson-2k2000.dtsi            |  300 +
>  src/powerpc/fsl/t1023si-post.dtsi             |   79 +-
>  src/powerpc/fsl/t1040si-post.dtsi             |   71 +-
>  src/riscv/microchip/mpfs-icicle-kit.dts       |   21 +
>  src/riscv/microchip/mpfs.dtsi                 |   17 +
>  src/riscv/renesas/r9a07g043f.dtsi             |    4 +
>  src/riscv/sifive/hifive-unmatched-a00.dts     |    1 +
>  src/riscv/sophgo/cv1800b.dtsi                 |  118 +-
>  src/riscv/sophgo/cv1812h-huashan-pi.dts       |   48 +
>  src/riscv/sophgo/cv1812h.dtsi                 |   24 +
>  src/riscv/sophgo/cv18xx.dtsi                  |  192 +
>  src/riscv/sophgo/sg2042.dtsi                  |   80 +-
>  src/riscv/starfive/jh7100-common.dtsi         |  131 +
>  src/riscv/starfive/jh7100.dtsi                |   60 +-
>  src/riscv/starfive/jh7110.dtsi                |    4 +-
>  src/riscv/thead/th1520-beaglev-ahead.dts      |   20 +
>  src/riscv/thead/th1520-lichee-module-4a.dtsi  |   20 +
>  src/riscv/thead/th1520.dtsi                   |   34 +
>  1311 files changed, 67670 insertions(+), 8539 deletions(-)
>  create mode 100644 Bindings/arm/google.yaml
>  delete mode 100644 Bindings/arm/mediatek/mediatek,audsys.txt
>  create mode 100644 Bindings/arm/mediatek/mediatek,audsys.yaml
>  delete mode 100644 Bindings/arm/mediatek/mediatek,ethsys.txt
>  delete mode 100644 Bindings/arm/msm/qcom,idle-state.txt
>  create mode 100644 Bindings/arm/qcom,coresight-remote-etm.yaml
>  delete mode 100644 Bindings/clock/brcm,kona-ccu.txt
>  create mode 100644 Bindings/clock/brcm,kona-ccu.yaml
>  create mode 100644 Bindings/clock/fsl,imx93-anatop.yaml
>  create mode 100644 Bindings/clock/google,gs101-clock.yaml
>  delete mode 100644 Bindings/clock/hi3620-clock.txt
>  create mode 100644 Bindings/clock/mediatek,ethsys.yaml
>  create mode 100644 Bindings/clock/mediatek,mt7988-ethwarp.yaml
>  create mode 100644 Bindings/clock/mediatek,mt7988-xfi-pll.yaml
>  create mode 100644 Bindings/clock/qcom,gcc-ipq6018.yaml
>  create mode 100644 Bindings/clock/qcom,qdu1000-ecpricc.yaml
>  create mode 100644 Bindings/clock/qcom,sm8650-dispcc.yaml
>  create mode 100644 Bindings/clock/qcom,sm8650-gcc.yaml
>  create mode 100644 Bindings/clock/qcom,x1e80100-gcc.yaml
>  delete mode 100644 Bindings/clock/silabs,si5351.txt
>  create mode 100644 Bindings/clock/silabs,si5351.yaml
>  create mode 100644 Bindings/clock/sophgo,cv1800-clk.yaml
>  create mode 100644 Bindings/clock/st,stm32mp25-rcc.yaml
>  create mode 100644 Bindings/crypto/inside-secure,safexcel.yaml
>  delete mode 100644 Bindings/crypto/inside-secure-safexcel.txt
>  delete mode 100644 Bindings/display/mediatek/mediatek,mdp-rdma.yaml
>  create mode 100644 Bindings/display/mediatek/mediatek,padding.yaml
>  create mode 100644 Bindings/display/msm/qcom,sdm670-mdss.yaml
>  create mode 100644 Bindings/display/msm/qcom,sm8650-dpu.yaml
>  create mode 100644 Bindings/display/msm/qcom,sm8650-mdss.yaml
>  create mode 100644 Bindings/display/panel/fascontek,fs035vg158.yaml
>  create mode 100644 Bindings/display/panel/ilitek,ili9805.yaml
>  create mode 100644 Bindings/display/panel/synaptics,r63353.yaml
>  delete mode 100644 Bindings/display/rockchip/inno_hdmi-rockchip.txt
>  create mode 100644 Bindings/display/rockchip/rockchip,inno-hdmi.yaml
>  create mode 100644 Bindings/dma/loongson,ls2x-apbdma.yaml
>  create mode 100644 Bindings/dts-coding-style.rst
>  delete mode 100644 Bindings/fpga/altera-fpga2sdram-bridge.txt
>  delete mode 100644 Bindings/fpga/altera-freeze-bridge.txt
>  delete mode 100644 Bindings/fpga/altera-hps2fpga-bridge.txt
>  create mode 100644 Bindings/fpga/altr,freeze-bridge-controller.yaml
>  create mode 100644 Bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml
>  create mode 100644 Bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml
>  delete mode 100644 Bindings/fpga/fpga-bridge.txt
>  create mode 100644 Bindings/fpga/fpga-bridge.yaml
>  create mode 100644 Bindings/gpio/nuvoton,sgpio.yaml
>  create mode 100644 Bindings/gpio/realtek,rtd-gpio.yaml
>  create mode 100644 Bindings/gpu/img,powervr.yaml
>  delete mode 100644 Bindings/hwmon/gpio-fan.txt
>  create mode 100644 Bindings/hwmon/gpio-fan.yaml
>  create mode 100644 Bindings/hwmon/lltc,ltc4286.yaml
>  create mode 100644 Bindings/iio/adc/maxim,max34408.yaml
>  create mode 100644 Bindings/iio/chemical/aosong,ags02ma.yaml
>  create mode 100644 Bindings/iio/dac/microchip,mcp4821.yaml
>  create mode 100644 Bindings/iio/humidity/ti,hdc3020.yaml
>  create mode 100644 Bindings/iio/imu/bosch,bmi323.yaml
>  create mode 100644 Bindings/iio/light/liteon,ltr390.yaml
>  create mode 100644 Bindings/iio/light/vishay,veml6075.yaml
>  create mode 100644 Bindings/iio/pressure/honeywell,hsc030pa.yaml
>  create mode 100644 Bindings/iio/temperature/microchip,mcp9600.yaml
>  create mode 100644 Bindings/input/adafruit,seesaw-gamepad.yaml
>  delete mode 100644 Bindings/input/gpio-mouse.txt
>  create mode 100644 Bindings/input/gpio-mouse.yaml
>  delete mode 100644 Bindings/input/ti,drv2665.txt
>  delete mode 100644 Bindings/input/ti,drv2667.txt
>  create mode 100644 Bindings/input/ti,drv266x.yaml
>  create mode 100644 Bindings/input/touchscreen/neonode,zforce.yaml
>  delete mode 100644 Bindings/input/touchscreen/samsung,s6sy761.txt
>  create mode 100644 Bindings/input/touchscreen/samsung,s6sy761.yaml
>  delete mode 100644 Bindings/input/touchscreen/zforce_ts.txt
>  create mode 100644 Bindings/interconnect/qcom,sm6115.yaml
>  create mode 100644 Bindings/interconnect/qcom,sm8650-rpmh.yaml
>  create mode 100644 Bindings/interconnect/qcom,x1e80100-rpmh.yaml
>  create mode 100644 Bindings/leds/allwinner,sun50i-a100-ledc.yaml
>  create mode 100644 Bindings/loongarch/cpus.yaml
>  create mode 100644 Bindings/loongarch/loongson.yaml
>  create mode 100644 Bindings/media/cnm,wave521c.yaml
>  create mode 100644 Bindings/media/i2c/alliedvision,alvium-csi2.yaml
>  create mode 100644 Bindings/media/i2c/galaxycore,gc0308.yaml
>  create mode 100644 Bindings/media/i2c/galaxycore,gc2145.yaml
>  create mode 100644 Bindings/media/i2c/ovti,ov64a40.yaml
>  create mode 100644 Bindings/media/i2c/techwell,tw9900.yaml
>  create mode 100644 Bindings/media/i2c/thine,thp7312.yaml
>  create mode 100644 Bindings/media/mediatek,mdp3-fg.yaml
>  create mode 100644 Bindings/media/mediatek,mdp3-hdr.yaml
>  create mode 100644 Bindings/media/mediatek,mdp3-stitch.yaml
>  create mode 100644 Bindings/media/mediatek,mdp3-tcc.yaml
>  create mode 100644 Bindings/media/mediatek,mdp3-tdshp.yaml
>  create mode 100644 Bindings/media/st,stm32-dcmipp.yaml
>  create mode 100644 Bindings/media/starfive,jh7110-camss.yaml
>  create mode 100644 Bindings/mfd/ams,as3711.yaml
>  delete mode 100644 Bindings/mfd/as3711.txt
>  create mode 100644 Bindings/net/dsa/marvell,mv88e6060.yaml
>  create mode 100644 Bindings/net/dsa/marvell,mv88e6xxx.yaml
>  delete mode 100644 Bindings/net/dsa/marvell.txt
>  create mode 100644 Bindings/net/lantiq,pef2256.yaml
>  create mode 100644 Bindings/net/marvell,aquantia.yaml
>  create mode 100644 Bindings/net/renesas,ethertsn.yaml
>  create mode 100644 Bindings/pinctrl/qcom,lpass-lpi-common.yaml
>  create mode 100644 Bindings/pinctrl/qcom,sm4450-tlmm.yaml
>  create mode 100644 Bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
>  create mode 100644 Bindings/pinctrl/qcom,sm8650-tlmm.yaml
>  create mode 100644 Bindings/pinctrl/qcom,x1e80100-tlmm.yaml
>  delete mode 100644 Bindings/pwm/pwm-omap-dmtimer.txt
>  create mode 100644 Bindings/pwm/ti,omap-dmtimer-pwm.yaml
>  create mode 100644 Bindings/rtc/adi,max31335.yaml
>  create mode 100644 Bindings/rtc/nuvoton,ma35d1-rtc.yaml
>  delete mode 100644 Bindings/security/tpm/google,cr50.txt
>  delete mode 100644 Bindings/security/tpm/ibmvtpm.txt
>  delete mode 100644 Bindings/security/tpm/st33zp24-i2c.txt
>  delete mode 100644 Bindings/security/tpm/st33zp24-spi.txt
>  delete mode 100644 Bindings/security/tpm/tpm-i2c.txt
>  delete mode 100644 Bindings/security/tpm/tpm_tis_mmio.txt
>  delete mode 100644 Bindings/security/tpm/tpm_tis_spi.txt
>  create mode 100644 Bindings/serial/arm,dcc.yaml
>  rename Bindings/{arm => soc/xilinx}/xilinx.yaml (95%)
>  delete mode 100644 Bindings/sound/es8328.txt
>  create mode 100644 Bindings/sound/everest,es8328.yaml
>  delete mode 100644 Bindings/sound/fsl,mqs.txt
>  create mode 100644 Bindings/sound/fsl,mqs.yaml
>  create mode 100644 Bindings/sound/mediatek,mt2701-audio.yaml
>  delete mode 100644 Bindings/sound/mt2701-afe-pcm.txt
>  delete mode 100644 Bindings/spi/adi,axi-spi-engine.txt
>  create mode 100644 Bindings/spi/adi,axi-spi-engine.yaml
>  create mode 100644 Bindings/thermal/mediatek,thermal.yaml
>  delete mode 100644 Bindings/thermal/mediatek-thermal.txt
>  create mode 100644 Bindings/tpm/google,cr50.yaml
>  create mode 100644 Bindings/tpm/ibm,vtpm.yaml
>  create mode 100644 Bindings/tpm/microsoft,ftpm.yaml
>  create mode 100644 Bindings/tpm/tcg,tpm-tis-i2c.yaml
>  create mode 100644 Bindings/tpm/tcg,tpm-tis-mmio.yaml
>  create mode 100644 Bindings/tpm/tcg,tpm_tis-spi.yaml
>  create mode 100644 Bindings/tpm/tpm-common.yaml
>  create mode 100644 Bindings/usb/qcom,wcd939x-usbss.yaml
>  create mode 100644 Bindings/w1/amd,axi-1wire-host.yaml
>  create mode 100644 Bindings/watchdog/nxp,pnx4008-wdt.yaml
>  delete mode 100644 Bindings/watchdog/pnx4008-wdt.txt
>  create mode 100644 Bindings/watchdog/qca,ar7130-wdt.yaml
>  delete mode 100644 Bindings/watchdog/qca-ar7130-wdt.txt
>  delete mode 100644 Bindings/watchdog/realtek,rtd119x.txt
>  create mode 100644 Bindings/watchdog/realtek,rtd1295-watchdog.yaml
>  create mode 100644 Bindings/watchdog/technologic,ts7200-wdt.yaml
>  create mode 100644 include/dt-bindings/clock/google,gs101.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt7988-clk.h
>  create mode 100644 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
>  create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>  create mode 100644 include/dt-bindings/clock/qcom,sm8650-dispcc.h
>  create mode 100644 include/dt-bindings/clock/qcom,sm8650-gcc.h
>  create mode 100644 include/dt-bindings/clock/qcom,sm8650-gpucc.h
>  create mode 100644 include/dt-bindings/clock/qcom,sm8650-tcsr.h
>  create mode 100644 include/dt-bindings/clock/qcom,x1e80100-gcc.h
>  create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h
>  create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
>  create mode 100644 include/dt-bindings/dma/fsl-edma.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm6115.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
>  create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt7988-resets.h
>  create mode 100644 include/dt-bindings/reset/qcom,sm8650-gpucc.h
>  create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h
>  create mode 100644 src/arm/qcom/pm8018.dtsi
>  create mode 100644 src/arm/qcom/pm8058.dtsi
>  rename src/arm/qcom/{qcom-pm8226.dtsi => pm8226.dtsi} (99%)
>  create mode 100644 src/arm/qcom/pm8821.dtsi
>  rename src/arm/qcom/{qcom-pm8841.dtsi => pm8841.dtsi} (100%)
>  create mode 100644 src/arm/qcom/pm8921.dtsi
>  rename src/arm/qcom/{qcom-pm8941.dtsi => pm8941.dtsi} (99%)
>  rename src/arm/qcom/{qcom-pma8084.dtsi => pma8084.dtsi} (100%)
>  rename src/arm/qcom/{qcom-pmx55.dtsi => pmx55.dtsi} (100%)
>  rename src/arm/qcom/{qcom-pmx65.dtsi => pmx65.dtsi} (100%)
>  create mode 100644 src/arm/qcom/qcom-msm8226-microsoft-common.dtsi
>  create mode 100644 src/arm/qcom/qcom-msm8226-microsoft-dempsey.dts
>  create mode 100644 src/arm/qcom/qcom-msm8226-microsoft-makepeace.dts
>  create mode 100644 src/arm/qcom/qcom-msm8226-microsoft-moneypenny.dts
>  create mode 100644 src/arm/qcom/qcom-msm8926-htc-memul.dts
>  create mode 100644 src/arm/qcom/qcom-msm8926-microsoft-superman-lte.dts
>  create mode 100644 src/arm/qcom/qcom-msm8926-microsoft-tesla.dts
>  create mode 100644 src/arm/qcom/qcom-msm8926-motorola-peregrine.dts
>  create mode 100644 src/arm/rockchip/rk3128-xpi-3128.dts
>  create mode 100644 src/arm/rockchip/rv1109-sonoff-ihost.dts
>  create mode 100644 src/arm/rockchip/rv1109.dtsi
>  create mode 100644 src/arm/rockchip/rv1126-sonoff-ihost.dts
>  create mode 100644 src/arm/rockchip/rv1126-sonoff-ihost.dtsi
>  create mode 100644 src/arm/st/ste-href-ab8505.dtsi
>  create mode 100644 src/arm/ti/omap/motorola-mapphone-handset.dtsi
>  create mode 100644 src/arm/ti/omap/motorola-mapphone-mz607-mz617.dtsi
>  create mode 100644 src/arm/ti/omap/motorola-mapphone-xt8xx.dtsi
>  create mode 100644 src/arm/ti/omap/omap4-xyboard-mz609.dts
>  create mode 100644 src/arm/ti/omap/omap4-xyboard-mz617.dts
>  create mode 100644 src/arm64/allwinner/sun50i-h618-orangepi-zero2w.dts
>  create mode 100644 src/arm64/allwinner/sun50i-h618-transpeed-8k618-t.dts
>  create mode 100644 src/arm64/exynos/exynosautov920-pinctrl.dtsi
>  create mode 100644 src/arm64/exynos/exynosautov920-sadk.dts
>  create mode 100644 src/arm64/exynos/exynosautov920.dtsi
>  create mode 100644 src/arm64/exynos/google/gs101-oriole.dts
>  create mode 100644 src/arm64/exynos/google/gs101-pinctrl.dtsi
>  create mode 100644 src/arm64/exynos/google/gs101-pinctrl.h
>  create mode 100644 src/arm64/exynos/google/gs101.dtsi
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso
>  create mode 100644 src/arm64/freescale/fsl-lx2160a-tqmlx2160a.dtsi
>  create mode 100644 src/arm64/freescale/imx8mm-overdrive.dtsi
>  create mode 100644 src/arm64/freescale/imx8mm-verdin-mallow.dtsi
>  create mode 100644 src/arm64/freescale/imx8mm-verdin-nonwifi-mallow.dts
>  create mode 100644 src/arm64/freescale/imx8mm-verdin-wifi-mallow.dts
>  create mode 100644 src/arm64/freescale/imx8mn-bsh-smm-s2-display.dtsi
>  create mode 100644 src/arm64/freescale/imx8mn-dimonoff-gateway-evk.dts
>  create mode 100644 src/arm64/freescale/imx8mn-overdrive.dtsi
>  create mode 100644 src/arm64/freescale/imx8mn-rve-gateway.dts
>  create mode 100644 src/arm64/freescale/imx8mp-skov-reva.dtsi
>  create mode 100644 src/arm64/freescale/imx8mp-skov-revb-hdmi.dts
>  create mode 100644 src/arm64/freescale/imx8mp-skov-revb-lt6.dts
>  create mode 100644 src/arm64/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
>  create mode 100644 src/arm64/freescale/imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtso
>  create mode 100644 src/arm64/freescale/imx8mp-verdin-mallow.dtsi
>  create mode 100644 src/arm64/freescale/imx8mp-verdin-nonwifi-mallow.dts
>  create mode 100644 src/arm64/freescale/imx8mp-verdin-wifi-mallow.dts
>  create mode 100644 src/arm64/freescale/imx8qxp-ss-vpu.dtsi
>  create mode 100644 src/arm64/freescale/imx93-tqma9352-mba93xxca.dts
>  create mode 100644 src/arm64/marvell/ac5x-rd-carrier-cn9131.dts
>  create mode 100644 src/arm64/marvell/ac5x-rd-carrier.dtsi
>  create mode 100644 src/arm64/marvell/cn9130-db-comexpress.dtsi
>  create mode 100644 src/arm64/marvell/cn9131-db-comexpress.dtsi
>  create mode 100644 src/arm64/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
>  create mode 100644 src/arm64/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
>  create mode 100644 src/arm64/mediatek/mt8183-kukui-jacuzzi-pico.dts
>  create mode 100644 src/arm64/mediatek/mt8183-kukui-jacuzzi-pico6.dts
>  create mode 100644 src/arm64/mediatek/mt8183-kukui-katsu-sku32.dts
>  create mode 100644 src/arm64/mediatek/mt8183-kukui-katsu-sku38.dts
>  create mode 100644 src/arm64/mediatek/mt8188-evb.dts
>  create mode 100644 src/arm64/mediatek/mt8188.dtsi
>  create mode 100644 src/arm64/qcom/ipq9574-rdp-common.dtsi
>  create mode 100644 src/arm64/qcom/msm8916-modem-qdsp6.dtsi
>  create mode 100644 src/arm64/qcom/msm8939-huawei-kiwi.dts
>  create mode 100644 src/arm64/qcom/qcm6490-idp.dts
>  create mode 100644 src/arm64/qcom/qcs6490-rb3gen2.dts
>  create mode 100644 src/arm64/qcom/sm8250-xiaomi-pipa.dts
>  create mode 100644 src/arm64/qcom/sm8650-mtp.dts
>  create mode 100644 src/arm64/qcom/sm8650-qrd.dts
>  create mode 100644 src/arm64/qcom/sm8650.dtsi
>  create mode 100644 src/arm64/qcom/x1e80100-crd.dts
>  create mode 100644 src/arm64/qcom/x1e80100-qcp.dts
>  create mode 100644 src/arm64/qcom/x1e80100.dtsi
>  create mode 100644 src/arm64/rockchip/rk3326-anbernic-rg351m.dtsi
>  create mode 100644 src/arm64/rockchip/rk3326-anbernic-rg351v.dts
>  create mode 100644 src/arm64/rockchip/rk3566-powkiddy-rk2023.dts
>  create mode 100644 src/arm64/rockchip/rk3566-powkiddy-rk2023.dtsi
>  create mode 100644 src/arm64/rockchip/rk3566-powkiddy-x55.dts
>  create mode 100644 src/arm64/rockchip/rk3588-coolpi-cm5-evb.dts
>  create mode 100644 src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
>  create mode 100644 src/arm64/rockchip/rk3588-jaguar.dts
>  create mode 100644 src/arm64/rockchip/rk3588s-coolpi-4b.dts
>  create mode 100644 src/arm64/sprd/ums9620-2h10.dts
>  create mode 100644 src/arm64/sprd/ums9620.dtsi
>  create mode 100644 src/arm64/ti/k3-am62-verdin-mallow.dtsi
>  create mode 100644 src/arm64/ti/k3-am625-beagleplay-csi2-ov5640.dtso
>  create mode 100644 src/arm64/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
>  create mode 100644 src/arm64/ti/k3-am625-verdin-nonwifi-mallow.dts
>  create mode 100644 src/arm64/ti/k3-am625-verdin-wifi-mallow.dts
>  create mode 100644 src/arm64/ti/k3-am62x-sk-csi2-imx219.dtso
>  create mode 100644 src/arm64/ti/k3-am62x-sk-csi2-ov5640.dtso
>  create mode 100644 src/arm64/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
>  create mode 100644 src/arm64/ti/k3-am652.dtsi
>  create mode 100644 src/arm64/ti/k3-j721e-evm-pcie0-ep.dtso
>  create mode 100644 src/arm64/ti/k3-j721s2-evm-pcie1-ep.dtso
>  create mode 100644 src/loongarch/loongson-2k0500-ref.dts
>  create mode 100644 src/loongarch/loongson-2k0500.dtsi
>  create mode 100644 src/loongarch/loongson-2k1000-ref.dts
>  create mode 100644 src/loongarch/loongson-2k1000.dtsi
>  create mode 100644 src/loongarch/loongson-2k2000-ref.dts
>  create mode 100644 src/loongarch/loongson-2k2000.dtsi
>  create mode 100644 src/riscv/sophgo/cv1812h-huashan-pi.dts
>  create mode 100644 src/riscv/sophgo/cv1812h.dtsi
>  create mode 100644 src/riscv/sophgo/cv18xx.dtsi
> 
