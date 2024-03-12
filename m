Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1104C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2705587E63;
	Tue, 12 Mar 2024 10:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hbVBENua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A6787F49; Tue, 12 Mar 2024 10:55:37 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AF787E63
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7db36dbd474so2013854241.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710237333; x=1710842133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A3BTJy0vT4UTu+TWYVWe2PTAyad7lZxXR4Cx8Q57yW0=;
 b=hbVBENua+KtIXfMtO76k55OCIbiFy/78zGFQnojJzEc16s7GofvSYE4kh8CfjB21a+
 lM3oPCa43RMm9nx8pdI1+8DdDOiZNkl+YOIrBf+vyXTZB5ehTkpHQsdHvm4oSRZc2Uv3
 8FyxXSBf/UFjsrDv+urvDz2a15LDYeuAtHcL5TEQgAkhr2Jdo9YuD8s9YR8Nh/01oHIa
 kqwokgIiRBvxOLJneRwWgM8lQ3iX2MIMC7EOlSIyFAWnU4724zTH+oZETgBolXcskPPx
 bfTEuhc5lnTvBHEc4mo8CMDgTIK7+IExRekIVFzT2DCNc1991ZTf43ltpHfA7JlXQ0z5
 nu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710237333; x=1710842133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A3BTJy0vT4UTu+TWYVWe2PTAyad7lZxXR4Cx8Q57yW0=;
 b=odgTiL2KBplHSaVXnVqRd5bDYbXjyyPozFjjFmBQQYYjnCaw2aw/8mOLMEeaEozgcd
 lErmtOQ6I49Vcs3ZbGoA/cuYsCiueNm7TdIkzyMO7qpwcgIH/alOJfV+iRGv9kDC2FXy
 H4lF9nbPc+Gf4HRrSAa3IcwUY2zNhJZF9F5sNrS85fx/L0xRqyoaWPl5ByM85qFnYqtX
 RjkUTK2GIy/VPQKk5FhZTP25sIwYQG8LWJ5Od14Wq7Al6/FQypj0+x/cYNX7PxFP932a
 wRaMf23EAdturnBfp97Af68Wkj5LkvziyuqZZt+Hugb7LwcsPzrCsK+T63ScvdnTmbLs
 fBMA==
X-Gm-Message-State: AOJu0YykK8XsGSH72t8Pab6+1aG8XldzaCWgk4MkdniqnO0/djoyLqkb
 UT3NzQSCKnHPiXTHaEhM5FDZc1bRDPDJrppjpqj+NMXuG6QcQWIzfQTJj0dexT2oGgHfBwe44Je
 ml2dMvdP2f1t45h8hc58DiI0OCDnnB38IYK9UrA==
X-Google-Smtp-Source: AGHT+IFbnh3fY9gxUsLA+KMy6RsVxERPhKpsENMLEfcXtX78w7N5h5rzDEP0vkqKB5Y8XkZLBe4BqY62mzR+vem+qEo=
X-Received: by 2002:a05:6102:538:b0:472:5b16:3e4e with SMTP id
 m24-20020a056102053800b004725b163e4emr5980119vsa.34.1710237333184; Tue, 12
 Mar 2024 02:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <CALeDE9MkbeTOBgArDH-+VxdO7D2iAAb1Mh+gCb6tnm2vg6LOFw@mail.gmail.com>
In-Reply-To: <CALeDE9MkbeTOBgArDH-+VxdO7D2iAAb1Mh+gCb6tnm2vg6LOFw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Mar 2024 15:25:22 +0530
Message-ID: <CAFA6WYMmbL52TF-2_JCb-uhbM87Ytdq1nTnr50Z9Ojg9O49+iQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] imx8mp: Enable PCIe/NVMe support
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Peter,

On Tue, 12 Mar 2024 at 15:13, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Sumit,
>
> > pcie_imx doesn't seem to share any useful code for iMX8MP SoC and it is
> > rather tied to quite old port of pcie_designware driver from Linux which
> > suffices only iMX6 specific needs.
> >
> > But currently we have the common DWC specific bits which alligns pretty
> > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > add support for other iMX8 variants to this driver.
>
> The upstream Linux driver is moving towards a single driver [1] for
> imx6 -> imx9, would it be possible to add support for all generations
> to this driver and then remove the old driver?

Sorry but that's not in scope of this patch-set and neither do I
possess boards with all the imx* SoC variants.

> That would allow this
> single modern driver and removing the old imx6 specific driver.

Folks interested in this can build up on this patch-set and port other
imx* variants and then we could have a single modern driver.

-Sumit

>
> Peter
>
> [1] https://www.spinics.net/lists/linux-pci/msg150359.html
>
> > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> > can reuse the generic PHY infrastructure to power on PCIe PHY.
> >
> > Testing with this patch-set included:
> >
> > Verdin iMX8MP # pci enum
> > PCIE-0: Link up (Gen1-x1, Bus0)
> > Verdin iMX8MP #
> > Verdin iMX8MP # nvme scan
> > Verdin iMX8MP #
> > Verdin iMX8MP # nvme info
> > Device 0: Vendor: 0x126f Rev: T0828A0  Prod: AA000000000000000720
> >             Type: Hard Disk
> >             Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
> > Verdin iMX8MP #
> > Verdin iMX8MP # load nvme 0 $loadaddr <file-name>
> >
> > Changes in v3:
> > - Rebased on top of U-Boot next.
> > - Incorporated misc. updates to commit messages.
> > - New patch#2 to refactor reset driver function names.
> > - Patch#3: Refactored further for better code reuse.
> > - New patch#4 to fix refcount issue with power domain bus.
> > - Patch#5: Refactored further for better code reuse.
> > - Patch#7 & #8: Added dependency on REGMAP and SYSCON. Also, added
> >   support for vpcie-supply regulator.
> > - Patch#7 & #8: Added error paths and .remove callback.
> > - New patch#10 to enable PCIe/NVMe for imx8mp_venice*.
> >
> > Changes in v2:
> > - Renamed PCIe IMX driver pcie_dw_imx8.c -> pcie_dw_imx.c.
> > - Added myself as maintainer for PCIe DWC IMX driver support.
> > - Incorporated various code and commit message improvement suggestions
> >   from Marek, thanks.
> > - Patch#3: Gate PCIe and USB clocks behind corresponding power domain
> >   IDs.
> > - Patch#4: Expose HSIO PLL clocks as a regular clock driver instead
> >   similar to what Linux kernel does.
> > - Patch#7: Picked up tags.
> >
> > Sumit Garg (10):
> >   clk: imx8mp: Add support for PCIe clocks
> >   reset: imx: Refactor driver to simplify function names
> >   reset: imx: Add support for i.MX8MP reset controller
> >   imx8mp: power-domain: Don't power off pd_bus
> >   imx8mp: power-domain: Add PCIe support
> >   imx8mp: power-domain: Expose high performance PLL clock
> >   phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
> >   pci: Add DW PCIe controller support for iMX8MP SoC
> >   verdin-imx8mp_defconfig: Enable PCIe/NVMe support
> >   MAINTAINERS: Add entry for PCIe DWC IMX driver
> >
> > Tim Harvey (1):
> >   imx8mp_venice_defconfig: Enable PCIe/NVMe support
> >
> >  MAINTAINERS                           |   6 +
> >  configs/imx8mp_venice_defconfig       |   8 +
> >  configs/verdin-imx8mp_defconfig       |   6 +
> >  drivers/clk/imx/clk-imx8mp.c          |   6 +
> >  drivers/pci/Kconfig                   |  11 +
> >  drivers/pci/Makefile                  |   1 +
> >  drivers/pci/pcie_dw_imx.c             | 338 ++++++++++++++++++++++++++
> >  drivers/phy/Kconfig                   |  11 +
> >  drivers/phy/Makefile                  |   1 +
> >  drivers/phy/phy-imx8m-pcie.c          | 283 +++++++++++++++++++++
> >  drivers/power/domain/imx8mp-hsiomix.c | 191 ++++++++++++---
> >  drivers/reset/reset-imx7.c            | 125 +++++++++-
> >  12 files changed, 937 insertions(+), 50 deletions(-)
> >  create mode 100644 drivers/pci/pcie_dw_imx.c
> >  create mode 100644 drivers/phy/phy-imx8m-pcie.c
> >
> > --
> > 2.34.1
> >
