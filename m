Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413A9C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 01:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9671188A1E;
	Tue, 20 Aug 2024 03:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NnBNMyBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9E788AA8; Tue, 20 Aug 2024 03:45:05 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87059889C5
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 03:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3dab336717fso3247007b6e.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724118301; x=1724723101; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VNAAiNkiYAbsPmWOVA0Va3etTGrLkaMSGyEyu1cCsdg=;
 b=NnBNMyBsUTByEi4i9OKLXrPm0gJuSmsxz54Ed+Tr7115FxKN57PJLjpvjqKTrzE8Qg
 l/AbqGZ81vVwMHtuNhngeYNcH+S5WYbqPeMIYtxzA01A9l72KgsJUmP2HTl/eIPEGZQC
 3qIcrt9Pl+7SE1HYCtb7rxoblyR/gL7s+3lw1GgdlNmstxT8SkW57qwfyenNRFkxxrTT
 08wvUTkq+yl45uVIadbxeGK713UiGCCLbbi5v6cwhnSn7MdSIXoqqLsthzboGxfRXWVs
 MGLHAxzfZ/iFhtnd7I7lI6J/95cn9cIrwyRFBgwIN693cvNNNiENY8kn0YWmVWaCn3ji
 qLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724118301; x=1724723101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNAAiNkiYAbsPmWOVA0Va3etTGrLkaMSGyEyu1cCsdg=;
 b=KqY5yKX44LHbNHu/B3Mg+rsLkvwE/S5sNKbs31r54GQ43CJX/GzGNPegGJ3iZcmTdG
 silwUARJRbDpdS35i/TWkrASOMyXESHUO/30/0rxdyUA+hNagGKItoex4Ttwznacqfdt
 mWliQ36vVYADsMZnZ9Qpdz1uSnJ4NATJtIJNh59xsmUjV1/sGh0C662zceqbojumeJ8b
 sfRgikdzrmrt/GKvRtoVRCBVYRs99Qd21teKY9DqyNYD/YNvf16G6ew9hoGOyC2cEfFe
 jjCETBB0gLrZoijJyQWG9piqLG8XeFkXUeoElXYamnxKHlTYDrjhV+EKOfgbCmZMKhAt
 HB4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXuAfuqtzOpQdehElz3k4TXaiLD1lgmIfPUxf2BHWPjnxDGHzwa1dGPBhpq2e2Cc+CW9hPySU/BggfNf4+yu9b3hTPrA==
X-Gm-Message-State: AOJu0YwpoT6QRhzu8EHNomlyJ5J56Y3NPHIZdDaKaVZ8UZ91lwNqryYT
 E3vqz9w8k2pflMiTsNaqjwL8NZJaZ8KfL0DQwKclW8lIfYV+124fW9eMUY27e6+hGzAliIEgnYP
 o+zsmu9dy/Kt+PKapBGkt464KqVM=
X-Google-Smtp-Source: AGHT+IHyxFXk30JBrdD8W9QVvbT+AKftp/DxJ0T5oFtnKeNtokHEoR7l8T1nPsC2IPigkkFZsRFob4L8rbViEt4V2GI=
X-Received: by 2002:a05:6870:1646:b0:270:6612:dddc with SMTP id
 586e51a60fabf-2706612e7d8mr5405562fac.24.1724118301154; Mon, 19 Aug 2024
 18:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
 <CAPLW+4m_rzR-96+4kNfE1a73kiASRAm9m+M56EqqNBZb6V7+5g@mail.gmail.com>
In-Reply-To: <CAPLW+4m_rzR-96+4kNfE1a73kiASRAm9m+M56EqqNBZb6V7+5g@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 20 Aug 2024 10:44:49 +0900
Message-ID: <CALrBrZ3H_FzVUvCOz59gJCiHEPY3_fG6xH3sQ4nMeMdzugwfBg@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2024=EB=85=84 8=EC=9B=94 14=EC=9D=BC (=EC=88=98) 10:15, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Minkyu,
>
> What do you think about this series? It's been pending for a while
> now, so may I ask you to take care of it?
>
> Thanks!
>
> On Wed, Aug 7, 2024 at 10:14=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > Bring 64-bit support to dw_mmc core and Exynos dw_mmc drivers, and
> > enable it on E850-96 board. Additionally do some related cleanups and
> > device tree updates.
> >
> > 64-bit version of DesignWare MMC can be often found on modern ARM64
> > chips. It's different from its older 32-bit version (which is already
> > implemented in U-Boot): some new registers were added, existing
> > register addresses are changed, DMA descriptor table is different, etc.
> > Next Exynos chips are known to have 64-bit DW MMC block:
> >
> >   - Exynos3475
> >   - Exynos5433
> >   - Exynos7420
> >   - Exynos7570
> >   - Exynos7580
> >   - Exynos7870
> >   - Exynos7872
> >   - Exynos7880
> >   - Exynos7885
> >   - Exynos7890
> >   - Exynos850 (Exynos3830)
> >
> > Exynos DW MMC driver was updated too: ARM64 Exynos chips implement thei=
r
> > clock drivers using CCF framework, pinmux configuration is done at
> > startup in DM capable pinctrl drivers, device tree properties were
> > changed w.r.t. their upstream (Linux kernel) counterparts. CLKSEL
> > register address is also different on 64-bit Exynos platforms.
> >
> > The patch series was tested on E850-96 board by running mainline Linux
> > kernel with Debian rootfs from eMMC ("boot" partition) with these
> > commands:
> >
> > 8<-------------------------------------------------------------------->=
8
> > env set fdtaddr 0x8a000000
> > env set bootaddr 0x94000000
> > env set boot_kerneladdr 0x94000800
> > part start mmc 0 boot boot_start
> > part size mmc 0 boot boot_size
> > mmc read $bootaddr $boot_start $boot_size
> > abootimg addr $bootaddr
> > abootimg get dtb --index=3D0 dtb_start dtb_size
> > cp.b $dtb_start $fdtaddr $dtb_size
> > fdt addr $fdtaddr 0x100000
> > cp.b $boot_kerneladdr $loadaddr 2aaaa00
> > env set bootargs console=3DttySAC0,115200n8 printk.devkmsg=3Don \
> >                  root=3D/dev/mmcblk0p12 rootwait rw
> > booti $loadaddr - $fdtaddr
> > 8<-------------------------------------------------------------------->=
8
> >
> > For E850-96 eMMC to function properly in DDR mode, the pending patch [1=
]
> > has to be applied. Otherwise it won't be possible for exynos_dw_mmc
> > driver to change CIU clock rate from 200 MHz up to 400 MHz, and MMC wil=
l
> > fall back to SDR mode, which makes eMMC throughput twice as slower. Wit=
h
> > patch [1] applied, 'mmc info' reports this:
> >
> >     Bus Speed: 52000000
> >     Mode: MMC DDR52 (52MHz)
> >
> > and 'clk dump' shows CIU clock rate to be ~400 MHz (after first mmc
> > operation, e.g. 'part start' or 'mmc read'):
> >
> >     399750000    gout_mmc_embd_sdclkin
> >
> > Which makes sense, because dw_mmc requests to set CCLKIN =3D 52 MHz (wi=
th
> > DDR/8-bit mode), and exynos_dw_mmc tries to set CIU clock rate to:
> >
> >     SDCLKIN =3D 2 * ciu_div * CCLKIN =3D 2 * 4 * 52 MHz =3D 416 MHz,
> >
> > and the closest possible value the clock driver can set is 399.75 MHz,
> > which works just fine.
> >
> > For Exynos4 and Exynos5 (ARM32) boards, this patch series was only buil=
d
> > tested (manually and with buildman). The build is clean (no errors or
> > warnings), but I don't have any Exynos4/Exynos5 boards at my disposal,
> > so I can't actually verify MMC operation there.
> >
> > Changes in v5:
> >   - Added missing bus-width property to sdhci2 node (SD card) in
> >     exynos4412-odroid.dts (patch 14/38)
> >
> > Changes in v4:
> >   - Rebased all patches on top of the most recent master; patches that
> >     were affected by recent changes: 08/38, 13/38, 37/38
> >
> > Changes in v3:
> >   - Rebased all patches on top of the most recent master, which in turn
> >     dropped next patches:
> >     - [PATCH v2 1/40] mmc: dw_mmc: Remove common.h
> >     - [PATCH v2 33/40] mmc: exynos_dw_mmc: Remove common.h
> >
> > Changes in v2:
> >   - Rebased on top of the most recent U-Boot/master
> >   - Added pending R-b tags from the mailing list
> >   - Addressed the comment from Quentin about CONFIG_IS_ENABLED() not
> >     playing nice in SPL case:
> >     1. Dropped [PATCH 35/42]
> >        ("mmc: exynos_dw_mmc: Use CONFIG_IS_ENABLED() to check config
> >         options")
> >     2. Dropped [PATCH 14/42]
> >        ("mmc: dw_mmc: Use CONFIG_IS_ENABLED() to check config options")
> >     3. Got rid of all other CONFIG_IS_ENABLED() changes (used #ifdef fo=
r
> >        now)
> >   - Addressed the comment from Quentin about incorrect logic for divide=
r
> >     update in [PATCH 06/40]
> >   - Guarded exynos_dwmmc_of_to_plat() with #ifded CONFIG_DM_MMC in
> >     [PATCH 22/40]
> >   - Added list of Exynos chips implementing 64-bit IDMAC descriptor (in
> >     [PATCH 00/40])
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2024-March/547719.html
> >
> > Sam Protsenko (38):
> >   mmc: dw_mmc: Remove unused version field from struct dwmci_host
> >   mmc: dw_mmc: Move struct idmac to dw_mmc.c
> >   mmc: dw_mmc: Extract waiting for data busy into a separate routine
> >   mmc: dw_mmc: Extract FIFO init into a separate routine
> >   mmc: dw_mmc: Extract divider update to a separate function
> >   mmc: dw_mmc: Extract FIFO data transfer into a separate routine
> >   mmc: dw_mmc: Extract DMA transfer handling code into a separate
> >     routine
> >   mmc: dw_mmc: Extract setting the DMA descriptor into a separate
> >     routine
> >   mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
> >   mmc: dw_mmc: Add support for 64-bit IDMAC
> >   mmc: dw_mmc: Replace fifoth_val property with fifo-depth
> >   mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
> >   mmc: dw_mmc: Improve coding style
> >   arm: dts: exynos: Add upstream DW MMC properties to all Exynos dts
> >   dt-bindings: exynos: Update bindings doc for DW MMC controller
> >   arm: exynos: Add header guard for dwmmc.h
> >   mmc: exynos_dw_mmc: Fix obtaining the base address of controller
> >   mmc: exynos_dw_mmc: Fix getting private data in
> >     exynos_dwmci_board_init()
> >   mmc: exynos_dw_mmc: Don't call pinmux functions on ARM64 chips
> >   mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF API
> >   mmc: exynos_dw_mmc: Use .of_to_plat for device tree parsing
> >   mmc: exynos_dw_mmc: Convert to use livetree API
> >   mmc: exynos_dw_mmc: Read upstream SDR timing properties
> >   mmc: exynos_dw_mmc: Abstract CLKSEL register
> >   mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
> >   mmc: exynos_dw_mmc: Read common bus-width property
> >   mmc: exynos_dw_mmc: Read common clock-frequency property
> >   mmc: exynos_dw_mmc: Move quirks from struct dwmci_host to chip data
> >   mmc: exynos_dw_mmc: Read and use DDR timing when available
> >   mmc: exynos_dw_mmc: Set requested freq in get_mmc_clk() callback
> >   mmc: exynos_dw_mmc: Add support for ARM64 Exynos chips
> >   mmc: exynos_dw_mmc: Pull all init code into probe function
> >   mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg() after add_dwmci()
> >   mmc: exynos_dw_mmc: Use dev->name as driver's displayed name
> >   mmc: exynos_dw_mmc: Improve coding style
> >   arm: dts: exynos: Remove outdated DW MMC properties in all Exynos dts
> >   configs: e850-96: Enable MMC
> >   doc: samsung: Mention enabled eMMC in E850-96 board doc
> >
> >  arch/arm/dts/exynos4210-origen.dts         |   3 +-
> >  arch/arm/dts/exynos4210-trats.dts          |   6 +-
> >  arch/arm/dts/exynos4210-universal_c210.dts |   6 +-
> >  arch/arm/dts/exynos4412-odroid.dts         |  15 +-
> >  arch/arm/dts/exynos4412-trats2.dts         |  20 +-
> >  arch/arm/dts/exynos5250-arndale.dts        |  10 +-
> >  arch/arm/dts/exynos5250-smdk5250.dts       |  13 +-
> >  arch/arm/dts/exynos5250-snow.dts           |  13 +-
> >  arch/arm/dts/exynos5250-spring.dts         |   7 +-
> >  arch/arm/dts/exynos5420-smdk5420.dts       |  13 +-
> >  arch/arm/dts/exynos5422-odroidxu3.dts      |   4 +-
> >  arch/arm/dts/exynos54xx.dtsi               |  13 +-
> >  arch/arm/mach-exynos/include/mach/dwmmc.h  |  40 +-
> >  configs/e850-96_defconfig                  |  10 +-
> >  doc/board/samsung/e850-96.rst              |   5 +-
> >  doc/device-tree-bindings/exynos/dwmmc.txt  |  46 +-
> >  drivers/mmc/ca_dw_mmc.c                    |   2 +-
> >  drivers/mmc/dw_mmc.c                       | 547 +++++++++++++--------
> >  drivers/mmc/exynos_dw_mmc.c                | 357 +++++++++-----
> >  drivers/mmc/ftsdc010_mci.h                 |   1 -
> >  drivers/mmc/hi6220_dw_mmc.c                |   7 +-
> >  drivers/mmc/nexell_dw_mmc.c                |   5 +-
> >  drivers/mmc/rockchip_dw_mmc.c              |   5 +-
> >  drivers/mmc/s5p_sdhci.c                    |   2 +-
> >  drivers/mmc/snps_dw_mmc.c                  |   6 +-
> >  drivers/mmc/socfpga_dw_mmc.c               |   4 +-
> >  include/dwmmc.h                            | 242 +++++----
> >  27 files changed, 869 insertions(+), 533 deletions(-)
> >
> > --
> > 2.39.2
> >


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
