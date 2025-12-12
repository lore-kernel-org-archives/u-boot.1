Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293D1D49220
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51550839A8;
	Fri, 12 Dec 2025 13:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBnb/OlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CF78367F; Fri, 12 Dec 2025 10:13:49 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1FA8334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 10:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8a3eac7ca30so76905685a.2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765530821; x=1766135621; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlAxeOQwUW5tQjMz+Uxh3avEOhs9p54Hj9q93thtlzs=;
 b=UBnb/OlZ7lcScOPALKDuqD+8p5fIDcgG2VHGKE7pHZnapZXYSS98/BtIBupscZgOIa
 NgDQJxCWYxZxzYKxblhDBk2OYcIt8VPvHSNeUzguQXZBaKYmCurOv30hNPSAzINyWsLW
 eOPNKT/pwkJgaiydqBX3xP50ZZXfUlsCbpBjfujZ74N90fpU0b1Xv8+jMTvG0P5vVIqx
 C5bHVJK6/THve91U/AOPcPoowuoEzlkudP87KyI4LrofCtgNMyvI5ZN3f3igjhlzEKRM
 XlLfe7MCDC6J09t28k7dB2SOgEqlK/n7gzmEItE4NbjF0V8oaLwEal5482TIoe4O4FC0
 OfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765530821; x=1766135621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VlAxeOQwUW5tQjMz+Uxh3avEOhs9p54Hj9q93thtlzs=;
 b=ffXjqBkNVc7/EuXqUMO04CFpxa1GTnOOoqElG6BJZ6WYRsmjwpArF49XR1VYN7Av0m
 lnVRb7fSjEv7poFRQdzB/B3CSkMnqC0xMRPtjhyntzxhdimU1T9WdUWrW+s1Q9h9efAa
 e/YI4xutSUiou3HL5fd+eoenq6IlLiRZaAfoOE5yDeM5EJqKUsTBoMbDejL0vmisy9I3
 OYdvhO4cn1AfrwLSVI5epBfKdOUDwMI4cYM+2YCMN7cOg7aUfb+8iJtNZ8JeOVexh2Us
 0b9gnOgXLXPb5IXvJZdLWAzeHZ9YzdYwQgJUueZHE9qDskFJGaUfOLFiWe30AdCr1XvM
 C37w==
X-Gm-Message-State: AOJu0Yxv7QymrrjR4QOn74m6LKMHkAN9zbVBKhNrp8ojAm+wkd5BOwTn
 4MfkxCDe+Fk37NULuwOvP9sSJcIhjWz9iIJo4lJj6ef73+8OMFXpsQ0bqWu8NuBYXKgf9SEBh/d
 zsemjvykAV18rmdTZZbEMHoLfIipn6lk=
X-Gm-Gg: AY/fxX4AQW2mFqrsJPgRiz9nBBDhTUQpzm5yRG3l5h97rDXw5D5NUYIKm7J2PNWWMoh
 WHCO1kynHZTj94AlDwYINwhBa4dtR26ATX35IRPWSyUZjpuAjpmgfPrr3+aSx0YvrmBubv7WcPn
 wbA94PGmzNast/K+Q3HdQOZJxxpRPBxbwrLNPMmWfyoTKOm9vMqORsozBgLP/WlfuBxgZM/ZHUd
 pqIxPeBEp0ne4LD6gGjeUtqF0YyqaYX4vOa5ymLyjNDlAeLpKZxK47UOUHvUVGNnLkgYQ==
X-Google-Smtp-Source: AGHT+IF35NhZZmDF6LTa/Su1PmubI/QrrXtddTqaNs1acDb0SMUwehVNKk0Bwl5ZMDc6QDyB2KhsxYC/k4THJhyENjE=
X-Received: by 2002:ac8:59cf:0:b0:4ee:1e28:acd2 with SMTP id
 d75a77b69052e-4f1d062af78mr14464851cf.70.1765530820986; Fri, 12 Dec 2025
 01:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
 <20251210-rk3576-ufs-v1-2-a3f9e76eb66e@gmail.com>
 <06a02ccb-e694-4463-83b1-cdc281408972@linaro.org>
In-Reply-To: <06a02ccb-e694-4463-83b1-cdc281408972@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 12 Dec 2025 12:13:31 +0300
X-Gm-Features: AQt7F2rHjWlCUVBtea2AtbFgLR69p6m8eIfOXnQLFi1hZ_CiE2XgOglo1ZVU7Qg
Message-ID: <CABjd4YwfqTj6CxauGgo1rR4a+ku2_N78QXfGCV9RAU+U6PZLDQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] spl: Make UFS available for SPL builds
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anurag Dutta <a-dutta@ti.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Dhruva Gole <d-gole@ti.com>, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Sam Edwards <cfsworks@gmail.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Randolph <randolph@andestech.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Ian Roberts <ian.roberts@timesys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Dec 2025 13:49:05 +0100
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

Hi Neil,

Thanks for your review!

On Thu, Dec 11, 2025 at 10:36=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 12/10/25 21:10, Alexey Charkov wrote:
> > Add minimal infrastructure to build SPL images with support for UFS
> > storage devices. This also pulls in SCSI support and charset functions,
> > which are dependencies of the UFS code.
> >
> > With this, only a fixed offset is supported for loading the next image,
> > which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
> > number of 4096-byte sectors into the UFS block device.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   MAINTAINERS                |  1 +
> >   arch/arm/include/asm/spl.h |  1 +
> >   common/spl/Kconfig         | 16 +++++++++++++++
> >   common/spl/Makefile        |  1 +
> >   common/spl/spl_ufs.c       | 49 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >   drivers/Makefile           |  1 +
> >   drivers/scsi/Makefile      |  3 +++
> >   lib/Makefile               |  1 +
> >   8 files changed, 73 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c9853f409920..c58805a724b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1860,6 +1860,7 @@ M:      Neil Armstrong <neil.armstrong@linaro.org=
>
> >   M:  Bhupesh Sharma <bhupesh.linux@gmail.com>
> >   M:  Neha Malcom Francis <n-francis@ti.com>
> >   S:  Maintained
> > +F:   common/spl/spl_ufs.c
> >   F:  drivers/ufs/
> >
> >   UPL
> > diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
> > index ee79a19c05c9..dd462ea6ad82 100644
> > --- a/arch/arm/include/asm/spl.h
> > +++ b/arch/arm/include/asm/spl.h
> > @@ -30,6 +30,7 @@ enum {
> >       BOOT_DEVICE_XIP,
> >       BOOT_DEVICE_BOOTROM,
> >       BOOT_DEVICE_SMH,
> > +     BOOT_DEVICE_UFS,
> >       BOOT_DEVICE_NONE
> >   };
> >   #endif
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index a43271671648..aa198ee44a3f 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1608,6 +1608,22 @@ config SPL_THERMAL
> >         automatic power-off when the temperature gets too high or low. =
Other
> >         devices may be discrete but connected on a suitable bus.
> >
> > +config SPL_UFS_SUPPORT
> > +     bool "Support loading from UFS"
> > +     select SPL_LOAD_BLOCK
> > +     help
> > +       Enable support for UFS in SPL. This allows
> > +       use of UFS devices such as hard drives and flash drivers for
> > +       loading U-Boot.
> > +
> > +config SPL_UFS_RAW_U_BOOT_SECTOR
> > +     hex "Address on the UFS to load U-Boot from"
> > +     depends on SPL_UFS_SUPPORT
> > +     default 0x800 if ARCH_ROCKCHIP
> > +     help
> > +       Address on the block device to load U-Boot from=EF=BC=8C
> > +       Units: UFS sectors (1 sector =3D 4096 bytes).
>
> The UFS are usually configured with multiple LUNs, so I would expect to a=
t least
> have the LUN parameter in case we use the sector address to load the payl=
oad.

Indeed. Rockchip's tools don't offer a direct way to access
non-default LUNs, which makes it a bit tricky to test booting from
anything other than LUN 0 (apart from using a fully booted system with
its full-blown drivers to write to other LUNs). I'll test and add the
extra Kconfig selector for the LUN.

> >   config SPL_WATCHDOG
> >       bool "Support watchdog drivers"
> >       imply SPL_WDT if !HW_WATCHDOG
> > diff --git a/common/spl/Makefile b/common/spl/Makefile
> > index 4c9482bd3096..e18f3cf09484 100644
> > --- a/common/spl/Makefile
> > +++ b/common/spl/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_$(PHASE_)DFU) +=3D spl_dfu.o
> >   obj-$(CONFIG_$(PHASE_)SPI_LOAD) +=3D spl_spi.o
> >   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) +=3D spl_ram.o
> >   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) +=3D spl_sdp.o
> > +obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) +=3D spl_ufs.o
> >   endif
> >
> >   obj-$(CONFIG_$(PHASE_)UPL) +=3D spl_upl.o
> > diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> > new file mode 100644
> > index 000000000000..3a5fcd4ed7a8
> > --- /dev/null
> > +++ b/common/spl/spl_ufs.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
> > + */
> > +
> > +#include <spl.h>
> > +#include <spl_load.h>
> > +#include <scsi.h>
> > +#include <errno.h>
> > +#include <image.h>
> > +#include <linux/compiler.h>
> > +#include <log.h>
> > +
> > +static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
> > +                          ulong size, void *buf)
>
> What a weird function name, please rename to spl_ufs_load_read

Ack. I grabbed it wholesale from spl_mmc.c - but I agree that it's not
exactly descriptive :) Will rename in v2.

Best regards,
Alexey
