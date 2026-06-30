Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C8DC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 09:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA9384A1F;
	Tue, 30 Jun 2026 11:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G+Gb9xEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C31A84A20; Tue, 30 Jun 2026 11:37:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A622384979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 11:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFBFA4161C;
 Tue, 30 Jun 2026 09:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB51F00A3A;
 Tue, 30 Jun 2026 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782812222;
 bh=Fby6VvbDMklpNhZqZ/NOcW7Fdme+ea2k6H9zCpH6AdM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=G+Gb9xEN687OZfccES2rDjEcXY5WfYvrIXxExxK9qjDE0zsBLXZdVrMHOSNSLtx4z
 9XoucAhzfwSHYGf+YMbQv5gWuSt25QNuFua9D3AU9O4vgtaflfQ2Nr9x56rbo3bWAH
 6sAVN073ostQuSm/pkqr7zbyydIHvXgBgEmSi8UgFuZAkjp8H9XCYKRZ+zS80Pi1lO
 5c31r2cjPyspeED+HabtpZ0tBtWspEECdO1btmId7f5TMdIgKEgSZ2KHQfBFkWLO3w
 nZIPdfFicZmQ37lPW1IBlvnlSB/v9W9LNjA/FnMuBMkLSzPl8i9xlnIrOu2m8AnpMr
 J4Dpm+YhFy2GQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, Marek
 Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andre Przywara
 <andre.przywara@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria
 <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Weijie Gao <weijie.gao@mediatek.com>, Zixun LI
 <admin@hifiphile.com>, Jerome Forissier <jerome.forissier@arm.com>, Jens
 Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v4 00/64]  drivers: usb: dwc3: sync code with Linux v6.16
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
Date: Tue, 30 Jun 2026 11:36:59 +0200
Message-ID: <8733y48j44.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jens,

Thank you for the series.
This is a lot of work.

On Mon, Jun 29, 2026 at 10:43, Jens Wiklander <jens.wiklander@linaro.org> wrote:

> Hi,
>
> This is a follow up on my last two patchsets [1] [2], where the latter only
> with a small change in addition to posting all the patches.
>
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back into
> U-Boot.
>
> This series synchronizes the DWC3 core with Linux v6.16. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
>
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>    a "snapshot" import of the drivers/usb/dwc3 directory for every major
>    kernel version (v3.19 through v6.16).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work [3])
>    re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>    required for U-Boot integration.
>
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [4].
>
> These patches are also available at [5].

I've tried this out on the Khadas VIM3 board using
khadas-vim3_android_defconfig and usb gadget (with fastboot) seems to
misbehave.

With the series applied, I see:
"""
U-Boot 2026.07-rc3-00064-g511db6941796 (Jun 30 2026 - 11:20:08 +0200) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (total 3.8 GiB)
Core:  408 devices, 37 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... MMC Device -1 not found
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot: 0
=> fastboot usb 0
failed to start <NULL>: -12
g_dnl_register: failed!, error: -12
exit not allowed from main input shell.
"""

With v2026.07-rc3, I see:
"""
U-Boot 2026.07-rc3 (Jun 30 2026 - 11:24:04 +0200) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (total 3.8 GiB)
Core:  408 devices, 37 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... MMC Device -1 not found
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot: 0
=> fastboot usb 0
crq->brequest:0x0
"""

The failure code path seems to go through:
g_dnl_register("usb_dnl_fastboot");
  usb_composite_register(&g_dnl_driver);
    usb_gadget_register_driver(&composite_driver);
      usb_gadget_probe_driver(driver);
        udc_bind_to_driver(udc, driver);
          driver->bind(udc->gadget);


I don't know why it's happening but I wanted to give some feedback early
on.
I'll have a closer look.

Thanks,
Mattijs

>
> Thanks,
> Jens
>
> [1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/
> [2] https://lore.kernel.org/u-boot/20260624123025.GA3245275@rayden/
> [3] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [4] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30524
> [5] https://github.com/jenswikl/u-boot-1/tree/poc/usb_dwc3_sync_v4
>
> v3 -> v4:
> - Restored obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) for dwc3-am62.o
>
> RFC v2 -> v3:
> - Rebased on v2026.07-rc3
> - Configured out a few prints in drivers/usb/gadget/udc/udc-core.c
>   to make it build for am335x_evm_defconfig
> - Applied provided tags in [1]
> - Published as a branch
>
> RFC v1 -> RFC v2:
> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>   dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
>   from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
>
> Jens Wiklander (60):
>   usb: dwc3: restore to original v3.19-rc1 kernel import
>   usb: dwc3: import from kernel v3.19
>   usb: dwc3: import from kernel v4.0
>   usb: dwc3: import from kernel v4.1
>   usb: dwc3: import from kernel v4.2
>   usb: dwc3: import from kernel v4.3
>   usb: dwc3: import from kernel v4.4
>   usb: dwc3: import from kernel v4.5
>   usb: dwc3: import from kernel v4.6
>   usb: dwc3: import from kernel v4.7
>   usb: dwc3: import from kernel v4.8
>   usb: dwc3: import from kernel v4.9
>   usb: dwc3: import from kernel v4.10
>   usb: dwc3: import from kernel v4.11
>   usb: dwc3: import from kernel v4.12
>   usb: dwc3: import from kernel v4.13
>   usb: dwc3: import from kernel v4.14
>   usb: dwc3: import from kernel v4.15
>   usb: dwc3: import from kernel v4.16
>   usb: dwc3: import from kernel v4.17
>   usb: dwc3: import from kernel v4.18
>   usb: dwc3: import from kernel v4.19
>   usb: dwc3: import from kernel v4.20
>   usb: dwc3: import from kernel v5.0
>   usb: dwc3: import from kernel v5.1
>   usb: dwc3: import from kernel v5.2
>   usb: dwc3: import from kernel v5.3
>   usb: dwc3: import from kernel v5.4
>   usb: dwc3: import from kernel v5.5
>   usb: dwc3: import from kernel v5.6
>   usb: dwc3: import from kernel v5.7
>   usb: dwc3: import from kernel v5.8
>   usb: dwc3: import from kernel v5.9
>   usb: dwc3: import from kernel v5.10
>   usb: dwc3: import from kernel v5.11
>   usb: dwc3: import from kernel v5.12
>   usb: dwc3: import from kernel v5.13
>   usb: dwc3: import from kernel v5.14
>   usb: dwc3: import from kernel v5.15
>   usb: dwc3: import from kernel v5.16
>   usb: dwc3: import from kernel v5.17
>   usb: dwc3: import from kernel v5.18
>   usb: dwc3: import from kernel v5.19
>   usb: dwc3: import from kernel v6.0
>   usb: dwc3: import from kernel v6.1
>   usb: dwc3: import from kernel v6.2
>   usb: dwc3: import from kernel v6.3
>   usb: dwc3: import from kernel v6.4
>   usb: dwc3: import from kernel v6.5
>   usb: dwc3: import from kernel v6.6
>   usb: dwc3: import from kernel v6.7
>   usb: dwc3: import from kernel v6.8
>   usb: dwc3: import from kernel v6.9
>   usb: dwc3: import from kernel v6.10
>   usb: dwc3: import from kernel v6.11
>   usb: dwc3: import from kernel v6.12
>   usb: dwc3: import from kernel v6.13
>   usb: dwc3: import from kernel v6.14
>   usb: dwc3: import from kernel v6.15
>   usb: dwc3: import from kernel v6.16
>
> Jerome Forissier (4):
>   usb: host: re-import xhci-ext-caps.h from kernel v6.16
>   usb: gadget: re-import epautoconf.c from kernel v6.16
>   usb: udc: re-import udc-core.c from kernel v6.16
>   usb: fix build after resync of DWC3 with kernel v6.16
>
>  drivers/usb/cdns3/ep0.c                |    8 +-
>  drivers/usb/common/common.c            |   23 +
>  drivers/usb/dwc3/Makefile              |   57 +-
>  drivers/usb/dwc3/core.c                | 1710 ++++++----
>  drivers/usb/dwc3/core.h                | 1060 ++++--
>  drivers/usb/dwc3/debug.h               |  432 +++
>  drivers/usb/dwc3/dwc3-omap.c           |    2 -
>  drivers/usb/dwc3/ep0.c                 |  737 ++--
>  drivers/usb/dwc3/gadget.c              | 4256 ++++++++++++++++--------
>  drivers/usb/dwc3/gadget.h              |  112 +-
>  drivers/usb/dwc3/glue.h                |   36 +
>  drivers/usb/dwc3/io.h                  |   29 +-
>  drivers/usb/dwc3/linux-compat.h        |   16 -
>  drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
>  drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>  drivers/usb/gadget/at91_udc.c          |   46 -
>  drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>  drivers/usb/gadget/ci_udc.c            |  470 ---
>  drivers/usb/gadget/composite.c         |    2 +-
>  drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
>  drivers/usb/gadget/epautoconf.c        |  289 +-
>  drivers/usb/gadget/ether.c             |   21 +-
>  drivers/usb/gadget/f_acm.c             |   20 +-
>  drivers/usb/gadget/f_fastboot.c        |   10 +-
>  drivers/usb/gadget/f_mass_storage.c    |    5 +-
>  drivers/usb/gadget/f_rockusb.c         |   11 +-
>  drivers/usb/gadget/f_sdp.c             |   12 +-
>  drivers/usb/gadget/f_thor.c            |   19 +-
>  drivers/usb/gadget/udc/Makefile        |    1 +
>  drivers/usb/gadget/udc/udc-core.c      | 1099 +++++-
>  drivers/usb/host/xhci-dwc3.c           |    4 +-
>  drivers/usb/host/xhci-ext-caps.h       |  158 +
>  drivers/usb/host/xhci-exynos5.c        |    2 +-
>  drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>  drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>  drivers/usb/musb-new/musb_uboot.c      |   39 -
>  include/dm/device_compat.h             |   13 +
>  include/dm/read.h                      |   46 +
>  include/linux/compat.h                 |   15 +
>  include/linux/usb/ch9.h                |   25 +-
>  include/linux/usb/gadget.h             |  520 +--
>  include/linux/usb/otg.h                |   10 +
>  include/linux/usb/phy.h                |   56 +
>  43 files changed, 7591 insertions(+), 4175 deletions(-)
>  create mode 100644 drivers/usb/dwc3/debug.h
>  create mode 100644 drivers/usb/dwc3/glue.h
>  delete mode 100644 drivers/usb/dwc3/linux-compat.h
>  delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
>  create mode 100644 drivers/usb/host/xhci-ext-caps.h
>
>
> base-commit: 76d62273bc8a5dc126ed79ed0fb65e5a97359577
> -- 
> 2.43.0
