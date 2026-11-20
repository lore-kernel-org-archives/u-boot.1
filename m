Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0B606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SQH294tE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rKRalBK1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5D66815D4;
	Fri, 20 Nov 2026 00:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbjsoG7aeNys; Fri, 20 Nov 2026 00:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35D718156B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795134689;
	b=qOkwoQ4MJc1kevrnwEUAmxqgXG+CeKQqKVx6WyMG8kV9HQpw2VgZi4kjtQPms+oQdb9L
	 zYDiFQI08A7QoAdZ+EpCMkXXL+WHbE4yBJLnDW9UNQHEY6ykITmqMJgUb8cKygTnKA1AN
	 /jjLYnlCDHDB+JLT3UC38/enj9udmY5H+crvUOnAvtaUYf9E8dHWQl3qbRck9W1lf/mZN
	 i2+mi2wrayld0uQ0fbKMRN5BShrLxs+qaPBoa7J6xXd4KeZQ4DYl29Vhqzk3dWh+L8uCS
	 g3fEG3zC0hZosxvw9MeuV1TPWhgLUp8rVPDjeTFU4+gaJBPQppmBP1IcPrLWUxjokuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795134689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SIg29uIF18LKkW7p79N2DWkt+9S0i//JlP6kjxXmOMs=;
	b=fCQQku+5TbZ9OTeYK9JdESjEGyCYxq+NXOo3qsvfkTyBY/NYJFJoXqWQx2o4SmsFeRS9
	 ZPK27O3GsqLA3Jvck2YX26K0hukKX1gRipJ4bXlcRSgWf1P/OfwkELP5Hy772zSRO1FGB
	 bygqMXnFKeCl5Z86Cn9wyXd9p+zvr8itCJIfi0O0EwJBCsIvx9tPwlgK4HOPuC9c/dXx9
	 KheEAu838cPUyZkpq9UQhC88yss38CF/DdWqRKv//Z7Bu9OExTPdlmzs09Rj5gWaXjZhv
	 P2FhnWXVRNU/somgZvX++DH0bIf7SSAn9lJX5RCkhUJyALYYw/YcHFEU6M9lE+V9yJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795134689;
	bh=SIg29uIF18LKkW7p79N2DWkt+9S0i//JlP6kjxXmOMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SQH294tERXX0CybIl6Ouh06fVqznufBV9aTC/wuMZmtvWKldNHKtD3Dqgcp8H+VMd
	 zx5aHbItUEjKlajWeYZGZm81qNjkbPII/VVVN08R2aCBea7GUAz5eilCgBaDvTagBV
	 xM7uRq5/4J+kybUS+nrV9vXKSz7GDdQkNqDhC40DqZacid3/gbCaHuXQAwRfBftEoF
	 zjDzL+sFkiLDpYZoaa5rIuuQAFrIw8OyUUoQIVNqlUsQSk5zVvusfAykj5l3dsXhhZ
	 lZu3/sM12PR8VsTvKZ/mtJ7wZvOpMsQG7qWfPNBpXkFQYllU796d1UEC7f8Hb0Q9iI
	 ovYSoZNiQ89SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35D718156B;
	Fri, 20 Nov 2026 00:31:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D0F8169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 534F240079
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCVVXmVOU7yQ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 00:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF31D40063
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=rKRalBK1
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF31D40063
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 00:31:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3B11575;
 Thu, 19 Nov 2026 16:31:21 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E6B3F632;
 Thu, 19 Nov 2026 16:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795134684; bh=FyqKsa8DAIACy0QUJQKwhPIfEaOEF6yKGslkqW4R9hE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rKRalBK1tKkiXsiTgzgZ7j+w3ndZ9iBYActL+A0xyA0Ukj8YLBxcLAXcQXPbbau6s
 ofnI16126WTT8UhymOEPtACdRKmoOns8srp02bPTDBksAo9MmMKFOVovcjxbizQkAD
 T6cTUQU2+FsXvv0aVwk2CRi6Xdqh+2hvkYI1q+Hs=
Date: Fri, 20 Nov 2026 01:31:18 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>, Yixun Lan
 <dlan@gentoo.org>, Enzo Adriano <enzo.adriano.code@gmail.com>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Chen-Yu Tsai <wens@csie.org>, Jernej
 =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 00/26] sunxi: Add Allwinner A733 (sun60i) and Orange Pi
 4 Pro support
Message-ID: <20261120013118.6ca36799@ryzen.lan>
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 13:32:10 +1100
Alastair D'Silva <alastair@d-silva.org> wrote:

Hi Alastair,

thanks for sending this, and for keeping existing patches and their
authors!

> This series adds initial support for the Allwinner A733 (sun60iw2 / sun60i)
> SoC and the Xunlong Orange Pi 4 Pro board to U-Boot.

Please note that the DT bits need to go through the kernel repo
first, so you better send your OrangePi DT to the kernel lists ASAP, to
get this in the wake of the proposed A733 .dtsi and Cubie A7Z patches.
Though it's not clear at this point whether they make it into v7.4.

> The A733 is an octa-core ARMv8 SoC (dual-cluster Cortex-A76 + Cortex-A55)
> with LPDDR5 memory trained by an on-chip Synopsys ARC PMU, an AXP318W PMIC,
> eMMC/SD (MMC0/1/2), USB 2.0 EHCI/OHCI, and a DesignWare PCIe Gen3 x1 host
> controller paired with a Cadence Combo PHY.
> 
> Overview of the series:

xx/26 doesn't look very manageable, so we would need to split this up,
probably along the lines of your groups below:

> - Patches 1-3: Fix AXP318W ELDO voltage mask and sysreset shutdown register,
>   and extend SPL PMIC support for DCDC6/7 and ALDO/BLDO/DLDO/ELDO rails
>   required to bring up LPDDR5 and board I/O.

As the AXP318W support is already in (though sadly unused), those
fixes/changes should be a separate series, as there wouldn't be any new
dependencies.

> - Patches 4-11: Add A733 CCU/R-CCU dt-bindings, GPIO, pinctrl, clock/reset,
>   MMC (including transfer-size-scaled data timeout), and UART console support.
> - Patches 12-13: Add disposable .init.rodata support for AArch64 SPL (allowing
>   large DRAM init tables in SRAM A2 without exceeding the 0x58000 BL31 load
>   address) and ERET-based FEL return support for A733.

As mentioned above, we import DT files and binding headers from the
Linux kernel (through the DT rebasing repo), so the clock bits have to
wait for that to hit mainline. Since Chen-Yu has prepared this already
for linux-next, this should come with a release tag beginning of
January, right in time to cherry-pick this for the next U-Boot merge
window. The clock and peripheral patches are fairly straight-forward,
so I am tempted to merge them ASAP, to allow at least a "U-Boot proper
only" build. This works quite nicely for me here locally. So those
patches should be a separate series as well.

> - Patches 14-21: Add freestanding ARC PMU LPDDR5 training firmware (built from
>   C via ARC_CROSS_COMPILE, or supplied via PMU_FW= / BINMAN_ALLOW_MISSING=1),
>   the A733 LPDDR5 DRAM driver, initial sun60i SoC support, and documentation
>   in doc/board/allwinner/a733-pmu.rst.

Yeah, the DRAM setup code is of course ... interesting, and surely
requires some proper review. Also we need to figure out the boot flow,
alongside the TF-A implementation, to not let them clash. It looks
like build-wise this is somewhat independent from the rest, so could
be a separate series.

> - Patches 22-24: Add the A733 Cadence Combo PHY driver, DesignWare PCIe
>   controller driver, and NVMe distro boot target support. Note that a small
>   SoC helper (sunxi_a733_pcie_soc_init) handles PCIe/SerDes CCU muxes,
>   RTC DCXO feed, SYS_PLL, and NSI QoS until U-Boot's gate-only clk_sunxi
>   driver gains rate/parent support for A733.

NVMe support is a welcomed surprise, but again should be independent of
the rest, both build-wise and functionality-wise. I wonder if that
already works for the A523, maybe you can have a brief look into that.
Then this again could be upstreamed separately, as a distinct series.
And I guess this is also gated on upstream Linux DT bindings.

> - Patches 25-26: Add the sun60i-a733.dtsi SoC device tree and Xunlong
>   Orange Pi 4 Pro board support (defconfig, DTS, and MAINTAINERS).

As mentioned above, this needs to go through the kernel first, then it
would be imported either automatically or courtesy of an explicit
cherry pick.

Thanks,
Andre

> Tested on live Xunlong Orange Pi 4 Pro (6 GiB LPDDR5 @ 3600 MT/s) via FEL
> boot with TF-A BL31 v2.15.0 + pending Allwinner A733 TF-A patches:
> - https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55200
>   (feat(allwinner): add A733 support)
> - https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55204
>   (feat(allwinner): a733: ungate security controllers)
> - https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55205
>   (fix(allwinner): restore core security on power-on)
> 
> Verified functionality:
> - SPL DRAM training (6144 MiB LPDDR5, 3600 MT/s)
> - SD card (mmc0: SD32G 29.7 GiB, 4-bit)
> - PCIe Gen3 + NVMe SSD (UHPVN0153EQ0V2 238.4 GB, partition enumeration)
> 
> Alastair D'Silva (17):
>   power: regulator: axp: Fix AXP318W ELDO voltage mask
>   power: pmic: axp: Fix AXP318W sysreset shutdown register
>   power: axp: Extend AXP318W SPL support with DCDC6/7 and LDOs
>   mmc: sunxi: Scale data transfer timeout with transfer size
>   arm64: spl: Support disposable .init.rodata section after
>     _image_binary_end
>   sunxi: fel: Add Allwinner A733 ERET FEL return support
>   sunxi: dram: a733: Add ARC PMU register, ABI, and build definitions
>   sunxi: dram: a733: Add ARC PMU primitives, clock, telemetry, and CBT
>   sunxi: dram: a733: Add ARC PMU deskew and BIST training firmware
>   sunxi: dram: a733: Add ARC PMU 1D/2D eye training firmware
>   sunxi: dram: a733: Add ARC PMU training state machine
>   sunxi: dram: a733: Add Allwinner A733 LPDDR5 DRAM driver
>   doc: sunxi: Document Allwinner A733 LPDDR5 PMU architecture
>   phy: sunxi: Add Allwinner A733 Cadence Combo PHY driver
>   pci: sunxi: Add Allwinner A733 DesignWare PCIe host controller driver
>   sunxi: Add NVMe to distro boot targets
>   sunxi: Add Xunlong Orange Pi 4 Pro board support
> 
> Enzo Adriano (1):
>   arm64: dts: allwinner: add A733 SoC description
> 
> Junhui Liu (1):
>   dt-bindings: clk: sun60i-a733-ccu: Add Allwinner A733 support
> 
> Yixun Lan (7):
>   gpio: a733: add initial support
>   pinctrl: sunxi: a733: add initial support
>   clock: reset: a733: add initial support
>   clock: a733: implement support for mmc/uart
>   sunxi: mmc: enable support for A733
>   sunxi: a733: uart: setup serial console
>   sunxi: sun60i: initial support for A733 SoC
> 
>  MAINTAINERS                                   |   13 +
>  arch/arm/config.mk                            |    4 +
>  arch/arm/cpu/armv8/fel_utils.S                |  113 +-
>  arch/arm/cpu/armv8/u-boot-spl.lds             |   20 +
>  arch/arm/cpu/armv8/u-boot.lds                 |    1 +
>  arch/arm/dts/Makefile                         |    2 +
>  arch/arm/dts/sun60i-a733-orangepi-4-pro.dts   |  237 +
>  arch/arm/dts/sun60i-a733.dtsi                 |  816 +++
>  arch/arm/include/asm/arch-sunxi/boot0.h       |   20 +-
>  arch/arm/include/asm/arch-sunxi/clock.h       |    1 +
>  .../include/asm/arch-sunxi/clock_sun50i_h6.h  |   19 +
>  .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |   43 +-
>  arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
>  arch/arm/include/asm/arch-sunxi/serial.h      |   15 +-
>  arch/arm/include/asm/arch-sunxi/spl.h         |    3 +
>  arch/arm/include/asm/arch-sunxi/watchdog.h    |    1 +
>  arch/arm/mach-sunxi/Kconfig                   |   47 +-
>  arch/arm/mach-sunxi/Makefile                  |   37 +
>  arch/arm/mach-sunxi/board.c                   |   16 +
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         |  149 +-
>  arch/arm/mach-sunxi/cpu_info.c                |    2 +
>  arch/arm/mach-sunxi/dram_sun60i_a733.c        | 1303 +++++
>  arch/arm/mach-sunxi/dram_sun60i_a733_tables.h |  941 ++++
>  arch/arm/mach-sunxi/pmu/build_pmu_fw.py       |  257 +
>  arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h |  463 ++
>  arch/arm/mach-sunxi/pmu/pmu.ld                |   38 +
>  arch/arm/mach-sunxi/pmu/pmu_cbt.c             |  417 ++
>  arch/arm/mach-sunxi/pmu/pmu_clock.c           |  938 ++++
>  arch/arm/mach-sunxi/pmu/pmu_deskew.c          | 4895 +++++++++++++++++
>  arch/arm/mach-sunxi/pmu/pmu_eye.c             | 3224 +++++++++++
>  arch/arm/mach-sunxi/pmu/pmu_fw.h              |  553 ++
>  arch/arm/mach-sunxi/pmu/pmu_primitives.c      |  531 ++
>  arch/arm/mach-sunxi/pmu/pmu_telemetry.c       |  619 +++
>  arch/arm/mach-sunxi/pmu/pmu_train.c           | 2748 +++++++++
>  arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h       |  251 +
>  arch/arm/mach-sunxi/rmr_switch.S              |   22 +-
>  board/sunxi/MAINTAINERS                       |    6 +
>  board/sunxi/board.c                           |   48 +-
>  common/spl/Kconfig                            |   22 +
>  configs/orangepi_4_pro_defconfig              |   36 +
>  doc/board/allwinner/a733-pmu.rst              |  299 +
>  doc/board/allwinner/index.rst                 |    1 +
>  doc/board/allwinner/sunxi.rst                 |   14 +-
>  drivers/clk/sunxi/Kconfig                     |   14 +
>  drivers/clk/sunxi/Makefile                    |    2 +
>  drivers/clk/sunxi/clk_a733.c                  |  142 +
>  drivers/clk/sunxi/clk_a733_r.c                |   45 +
>  drivers/clk/sunxi/clk_sunxi.c                 |   10 +
>  drivers/gpio/Kconfig                          |    7 +
>  drivers/gpio/sunxi_gpio.c                     |   49 +-
>  drivers/mmc/sunxi_mmc.c                       |   48 +-
>  drivers/pci/Kconfig                           |   11 +
>  drivers/pci/Makefile                          |    1 +
>  drivers/pci/pcie_dw_sunxi.c                   |  355 ++
>  drivers/phy/allwinner/Kconfig                 |    8 +
>  drivers/phy/allwinner/Makefile                |    1 +
>  drivers/phy/allwinner/phy-sun60i-combophy.c   |  293 +
>  drivers/pinctrl/sunxi/Kconfig                 |   18 +
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c         |   98 +-
>  drivers/power/Kconfig                         |  110 +-
>  drivers/power/axp_spl.c                       |  119 +-
>  drivers/power/pmic/axp.c                      |    4 +-
>  drivers/power/regulator/axp_regulator.c       |   12 +-
>  include/axp_pmic.h                            |    5 +
>  include/configs/sun60i.h                      |   11 +
>  include/configs/sunxi-common.h                |    7 +
>  .../clock/allwinner,sun60i-a733-ccu.h         |  291 +
>  .../clock/allwinner,sun60i-a733-r-ccu.h       |   38 +
>  .../reset/allwinner,sun60i-a733-ccu.h         |  129 +
>  .../reset/allwinner,sun60i-a733-r-ccu.h       |   23 +
>  include/sunxi_gpio.h                          |   10 +-
>  71 files changed, 20948 insertions(+), 100 deletions(-)
>  create mode 100644 arch/arm/dts/sun60i-a733-orangepi-4-pro.dts
>  create mode 100644 arch/arm/dts/sun60i-a733.dtsi
>  create mode 100644 arch/arm/mach-sunxi/dram_sun60i_a733.c
>  create mode 100644 arch/arm/mach-sunxi/dram_sun60i_a733_tables.h
>  create mode 100755 arch/arm/mach-sunxi/pmu/build_pmu_fw.py
>  create mode 100644 arch/arm/mach-sunxi/pmu/dwc_ddrphy_pmu_regs.h
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu.ld
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_cbt.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_clock.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_deskew.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_eye.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_fw.h
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_primitives.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_telemetry.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/pmu_train.c
>  create mode 100644 arch/arm/mach-sunxi/pmu/sunxi_pmu_abi.h
>  create mode 100644 configs/orangepi_4_pro_defconfig
>  create mode 100644 doc/board/allwinner/a733-pmu.rst
>  create mode 100644 drivers/clk/sunxi/clk_a733.c
>  create mode 100644 drivers/clk/sunxi/clk_a733_r.c
>  create mode 100644 drivers/pci/pcie_dw_sunxi.c
>  create mode 100644 drivers/phy/allwinner/phy-sun60i-combophy.c
>  create mode 100644 include/configs/sun60i.h
>  create mode 100644 include/dt-bindings/clock/allwinner,sun60i-a733-ccu.h
>  create mode 100644 include/dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/allwinner,sun60i-a733-ccu.h
>  create mode 100644 include/dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h
> 

