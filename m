Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835FFD489A3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 13:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADCE98388D;
	Fri, 16 Jan 2026 14:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak6vTUaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59498830E4; Fri, 16 Jan 2026 11:57:32 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1385A8389A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-502a407dabaso4944831cf.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768561049; x=1769165849; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw22eTXVh9eh0wdUdYFgjWm9lxh1R9Hi8CvF1E5QPiI=;
 b=Ak6vTUaK0VeQC25Jhdhy/Ij+ASqSS8WBM/987b35t3O5IepH1EfpNXHsQ+4D7vK1ZS
 PiwQEfYeP/LxxoXqoWvbR3ECsRNnqfnhDrszOgozZIl79QWxdLJsqp24wjxy8Nrg5DFm
 kmUUdi+cKMiqyI3Yq3UN8K1ZLBxRyOriNpDU4l0DOmTFnH978rtPYY47LxqnJ2AhI4Wj
 F8X07mBJpH9CH9MPx/jR9XBBSQQtETlQkdjgO/iPNG8QSwPfF/Evp7mGCklhjr5uahrU
 EZpbyxy9iK6/6xWu89X5VY9+3JR6ii+Gbj+Ffqc1WVfW0FpJ5fqBObx2xC7VFOGxWGdf
 BovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768561049; x=1769165849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aw22eTXVh9eh0wdUdYFgjWm9lxh1R9Hi8CvF1E5QPiI=;
 b=iyfTOi/0MBpsBc5PwHvwKoLDOEJN31DcrQswZnquD+piYrRqMXljED9+zIJWUV1nuG
 achGDNQtJ2f4xoY1x6/f94Kwgsgbt2HAM3oYkNRO0JewOvy6gfFOzZ/1Hxqt7R/Plzg5
 n78xtLF0uHuTWpxftv8FtY0hHSUsamn1DkCshhxg7xStLJ9HnaWPitVfQFELqB3/zhkd
 SHacrN66SD5Uekc46/1gidRxPKPdnd62tsVlfGd/V8pdIFSwEKBAYy+/MbtkQnVGbLFZ
 kjMtUW6A2ut+XcHq2AdCYv6vibYvLK+8176F9N+BBbaXVTCvKY1xHnKTEwITjoLOcCYz
 l7WQ==
X-Gm-Message-State: AOJu0Yw+WlxmoEtuXrCRpUNVpK9TNHf61EIEzkdvpcWFlP98UDLSe32y
 amBfB8bejcXH7fsIhrkiH4PcDGtaMN6SCO10Hw+h5wAiBNS0RWyVh6Z2fOledoCw/EM9igBCWAt
 2Hh0g4oDeTjAgDIBGbO+fh4ZCgHLLTJvKke2+VPQ=
X-Gm-Gg: AY/fxX5HYKRFo8LQRMmTXgdX8AIgmgH7HqxYy08GV9iy7EEqDslO+4oLGbUje3knVQF
 ldE/qhTDnAm0r//HbSQdfTpkqheyX2Du9KDIyN2OUFrEGHRsOsAfPpOqFHhyBzXdmfwRn4shFbt
 2mwWRlFZiIkGPDwjnWhPIHKn/Zo3YL/t/89QnPd/4rhS9R9b0O6EJC8yzg8yqsXtdf5ZiqoQyHU
 A2mQmpPWvPf/qEPbLkJ5TwkvCCqrGI/MAVGF5ooEqil7AnX7fIiVGjCnTDesZZSva64aSGHiVLS
 xEoCtOxPc/EgWpyHupMy9gN+iAOjgDeYywBCvFU=
X-Received: by 2002:ac8:5d05:0:b0:502:9f86:ca31 with SMTP id
 d75a77b69052e-502a16b3652mr38497931cf.52.1768561048734; Fri, 16 Jan 2026
 02:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-1-e8e67649f3f8@gmail.com>
 <e28f332d-72a6-4bb0-82d7-103118410e2e@cherry.de>
In-Reply-To: <e28f332d-72a6-4bb0-82d7-103118410e2e@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 16 Jan 2026 14:57:13 +0400
X-Gm-Features: AZwV_QiP6iXw-ZJyiVLWTBnthmxOfhIe1m7x6pjgXhl-RXE0T0WU5371wuFgrPI
Message-ID: <CABjd4Ywgup9CVY6-K7BfQhG+naXhpx2qDhKEbX9=fLEHXoUdww@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spl: Make UFS available for SPL builds
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Jan 2026 14:32:50 +0100
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

On Wed, Jan 14, 2026 at 10:16=E2=80=AFPM Quentin Schulz
<quentin.schulz@cherry.de> wrote:
>
> Hi Alexey,
>
> On 1/8/26 6:49 PM, Alexey Charkov wrote:
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
> >   common/spl/Kconfig         | 29 +++++++++++++++++++++++++++
> >   common/spl/Makefile        |  1 +
> >   common/spl/spl_ufs.c       | 49 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >   drivers/Makefile           |  1 +
> >   drivers/scsi/Makefile      |  3 +++
> >   lib/Makefile               |  1 +
> >   8 files changed, 86 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 27ce73d83f48..ca31e57f018a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1861,6 +1861,7 @@ M:      Neil Armstrong <neil.armstrong@linaro.org=
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
> > index 4f4119f5806c..6a82260dd010 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1612,6 +1612,35 @@ config SPL_THERMAL
> >         automatic power-off when the temperature gets too high or low. =
Other
> >         devices may be discrete but connected on a suitable bus.
> >
> > +config SPL_UFS_SUPPORT
> > +     bool "Support loading from UFS"
> > +     select SPL_LOAD_BLOCK
>
> Doesn;t this depend on CONFIG_SCSI as well? Like it does nothing without
> it (does it even compile?), see changes you made to drivers/scsi/Makefile=
.

You're right. It's currently possible to disable CONFIG_UFS and
CONFIG_SCSI while keeping this enabled, and then this fails to
compile. I wonder how e.g. CONFIG_SPL_SATA solves this, as it doesn't
pull in SCSI either... Might be something to look into later.

> > +     help
> > +       Enable support for UFS in SPL. This allows
> > +       use of UFS devices such as hard drives and flash drivers for
> > +       loading U-Boot.
> > +
> > +config SPL_UFS_RAW_U_BOOT_DEVNUM
> > +     int "SCSI device number of the UFS device to load U-Boot from"
> > +     depends on SPL_UFS_SUPPORT
> > +     default 0
> > +     help
> > +       UFS devices are usually configured with multiple LUNs, which pr=
esent
> > +       themselves as sequentially numbered SCSI devices. Usually one w=
ould
> > +       get a default LUN 0 taking up most of the space on the device, =
with
> > +       a number of smaller LUNs following it. This option controls whi=
ch of
> > +       them the SPL will attempt to load U-Boot from. Note that this i=
s the
> > +       SCSI device number, which might differ from the UFS LUN if you =
have
> > +       multiple SCSI devices attached and recognized by the SPL.
> > +
>
> I'm not verse in SCSI... Is the device number guaranteed to be stable
> across reboots? Is it probe order dependent? If that's the case, this is
> not a useful symbol and we should be trying to figure out a way to make
> it stable (via aliases for example, or using another mechanism).

It is stable across reboots and it follows the same sequence as LUNs,
but I suspect that if multiple SCSI drives are present (e.g. a UFS
module and some SATA drive) then their numbering might change if e.g.
one plugs/unplugs the SATA drive. Can't check it unfortunately, as I
don't have a device which would support more than one.

There is a dedicated attribute for the LUN within SCSI structures (and
also blk_desc for that matter), but to get to it one still needs to
provide a device number first. So the alternative seems to be to
iterate through all available device numbers, looking for a particular
SCSI target and LUN (and belonging to UCLASS_UFS). That felt a bit
over engineered for the use case at hand, and even then one can still
think of a case where the logic breaks - e.g. if more than one UFS
device is present in the system, and their SCSI target numbers change
based on probe order.

spl_sata.c for instance hardcodes devnum =3D 0, meaning that a system
with two drives would likely boot unpredictably

> > +config SPL_UFS_RAW_U_BOOT_SECTOR
> > +     hex "Address on the UFS to load U-Boot from"
> > +     depends on SPL_UFS_SUPPORT
> > +     default 0x800 if ARCH_ROCKCHIP
> > +     help
> > +       Address on the block device to load U-Boot from,
>
> s/,/./

Ack

> > +       Units: UFS sectors (1 sector =3D 4096 bytes).
> > +
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
> > index 000000000000..6b035db13c41
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
> > +static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, =
ulong size, void *buf)
> > +{
> > +     struct blk_desc *bd =3D load->priv;
> > +     lbaint_t sector =3D off >> bd->log2blksz;
> > +     lbaint_t count =3D size >> bd->log2blksz;
> > +
> > +     return blk_dread(bd, sector, count, buf) << bd->log2blksz;
> > +}
> > +
> > +static int spl_ufs_load_image(struct spl_image_info *spl_image,
> > +                           struct spl_boot_device *bootdev)
> > +{
> > +     int err =3D -ENOSYS;
> > +     struct blk_desc *bd;
> > +     struct spl_load_info load;
> > +     int devnum =3D CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
> > +     unsigned long sector =3D CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
>
> Reverse christmas tree here usually (so longest line at the top).

Ack

> > +
> > +     /* try to recognize storage devices immediately */
> > +     scsi_scan(false);
> > +     bd =3D blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
> > +     if (!bd)
> > +             return -ENODEV;
> > +
> > +     spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> > +     err =3D spl_load(spl_image, bootdev, &load, 0, sector << bd->log2=
blksz);
> > +     if (err) {
> > +             puts("spl_ufs_load_image: ufs block read error\n");
> > +             log_debug("(error=3D%d)\n", err);
>
> Why both a print and a log_debug?

If debug is compiled out along with all the string formatting stuff,
the puts still provides a useful error message with reduced
functionality. I see much of the code under common/spl uses puts for
error strings, and log_* for everything else.

Thanks a lot,
Alexey
