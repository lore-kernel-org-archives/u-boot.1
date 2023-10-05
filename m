Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E8DE92719
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D57486D0D;
	Thu,  5 Oct 2023 19:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OD26/NLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B48A86B55; Thu,  5 Oct 2023 19:22:36 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097AE86CD0
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so2297096a12.1
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696526546; x=1697131346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gVEbJo5FthcXrHsQvsrvSPn62UEO7pU6eTH7qxZSnIo=;
 b=OD26/NLBlN+xqswI7WG8Rt52VPUjGpKeJtBuz6og7UcUd8JMz1+s/SNQycjJgk4lR2
 knyuba7HyuWlTgU2r+dK0JN0EF9oYHngYoiGdBE/LKTYFQ7+vI8gYIghGeoOMaHNHWci
 0Md68YdMZFZHpXixdZT8tUEbFo276TaICx44o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696526546; x=1697131346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVEbJo5FthcXrHsQvsrvSPn62UEO7pU6eTH7qxZSnIo=;
 b=XN0m4CpugChjSt1khWejrnM8YP39zJ70c9DYHHe7lZdgcq1qxUwGQVZrM8zGT1yWEq
 BVaxggx0dgcj6Dg1o7pVnkcCyVrXOXXSBP+4RAUlTsUZYpQ2iN+nyPeUpMabiEcTZ2Ar
 9zpz3Mlbc5zt4qi/9ABj6izHdw1lOzy8vW40CmT1gi0yzqp+s5cODhSPuzOiwsHQ1Izw
 5zTtSpsO9CIkdcMawN7xluTRQAPZ+ex9qRAkNb50TGS+Yiy1fA77Dz4zkMIZNoRrCsl6
 gCFA+MyHA+2W56jnpyfxLBKVYG7/qyXaswcdobQSoyxNB10H+jKAXaRUHCCPoj2QU9Ml
 WejA==
X-Gm-Message-State: AOJu0YzCtAn8dsBKYAUltDYGsjfJpD+j3K90XVBtZbvXS/N4vsViIJs2
 QBZDYO2BkoDo+c8MKdzqsUfF3Bh4OiAyyXV86vQwDg==
X-Google-Smtp-Source: AGHT+IE6AK9ImrI1b2/KT3j+nxqQjcyP7bt0WrLi8lLobEM/xnwRctIVHSLf5S7S5ONH+W/B3QtOIo40bjkaf/R9HUY=
X-Received: by 2002:a17:906:8465:b0:9ae:6bef:4a54 with SMTP id
 hx5-20020a170906846500b009ae6bef4a54mr5082919ejc.3.1696526545916; Thu, 05 Oct
 2023 10:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-3-rogerq@kernel.org>
 <CAPnjgZ0uMLFdqvpcDMKnXQDL-m1ecUB33gat4EZK7jm=UeEB4g@mail.gmail.com>
 <20231005163148.GR8465@bill-the-cat>
In-Reply-To: <20231005163148.GR8465@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Oct 2023 11:22:07 -0600
Message-ID: <CAPnjgZ0GHurenhh0eSWsQKy0EKmx2mS_rqVhJ=V3Peo8Azx9kQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
To: Tom Rini <trini@konsulko.com>
Cc: Roger Quadros <rogerq@kernel.org>, nm@ti.com, vigneshr@ti.com,
 m-chawdhry@ti.com, 
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, 
 u-boot@lists.denx.de
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

Hi Tom,

On Thu, 5 Oct 2023 at 10:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 05, 2023 at 09:01:42AM -0600, Simon Glass wrote:
> > Hi Roger,
> >
> > On Thu, 5 Oct 2023 at 07:07, Roger Quadros <rogerq@kernel.org> wrote:
> > >
> > > Switch to using bootstd. Note with this change, we will stop using
> > > distro_bootcmd and instead depend entirely on bootflow method of
> > > starting the system up.
> > >
> > > Drop header files that are no longer needed in am64x_evm.h.
> > > k3_dfu.h is available via k3_dfu.env in am64x.env.
> > >
> > > Drop unused macro CFG_SYS_SDRAM_BASE1.
> > >
> > > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > > ---
> > >  board/ti/am64x/am64x.env        | 1 +
> > >  configs/am64x_evm_a53_defconfig | 5 +++--
> > >  include/configs/am64x_evm.h     | 9 ---------
> > >  3 files changed, 4 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
> > > index 68e42222b7..efd736b99b 100644
> > > --- a/board/ti/am64x/am64x.env
> > > +++ b/board/ti/am64x/am64x.env
> > > @@ -15,6 +15,7 @@ console=ttyS2,115200n8
> > >  args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
> > >  run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> > >
> > > +boot_targets=mmc1 mmc0 usb pxe dhcp
> > >  boot=mmc
> > >  mmcdev=1
> > >  bootpart=1:2
> > > diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> > > index 718ad176cb..43bfcf957a 100644
> > > --- a/configs/am64x_evm_a53_defconfig
> > > +++ b/configs/am64x_evm_a53_defconfig
> > > @@ -31,8 +31,9 @@ CONFIG_SPL_SPI=y
> > >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > >  CONFIG_SPL_LOAD_FIT=y
> > >  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> > > -CONFIG_DISTRO_DEFAULTS=y
> > > -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> > > +CONFIG_BOOTSTD_FULL=y
> > > +CONFIG_BOOTSTD_DEFAULTS=y
> > > +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
> > >  CONFIG_BOARD_LATE_INIT=y
> > >  CONFIG_SPL_MAX_SIZE=0x180000
> > >  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> > > diff --git a/include/configs/am64x_evm.h b/include/configs/am64x_evm.h
> > > index 062102a610..f9f8c7bc2f 100644
> > > --- a/include/configs/am64x_evm.h
> > > +++ b/include/configs/am64x_evm.h
> > > @@ -9,15 +9,6 @@
> > >  #ifndef __CONFIG_AM642_EVM_H
> > >  #define __CONFIG_AM642_EVM_H
> > >
> > > -#include <linux/sizes.h>
> > > -#include <config_distro_bootcmd.h>
> > > -#include <env/ti/mmc.h>
> > > -#include <asm/arch/am64_hardware.h>
> > > -#include <env/ti/k3_dfu.h>
> > > -
> > > -/* DDR Configuration */
> > > -#define CFG_SYS_SDRAM_BASE1            0x880000000
> > > -
> > >  /* Now for the remaining common defines */
> > >  #include <configs/ti_armv7_common.h>
> >
> > It looks like this file still includes distro_bootcmd and defines all
> > the BOOT_TARGET things. Can they be dropped? Perhaps for now they
> > could be put behind an #ifdef if other boards need them?
> >
> > I suspect that with your patch as is, the environment is still full of scripts?
>
> There's a lot of TI platforms, so I'm not sure what "#if" you're
> thinking of might make it cleaner?  We could / should move some of the
> still relevant content and comments from that file to
> include/env/ti/ti_armv7_common.env as I do think some of the K3
> platforms could just drop <configs/ti_armv7_common.h> at this point.

OK so if they are using text env then the header-file stuff doesn't
matter since I believe it is ignored? I was thinking of something
like:

#ifdef CONFIG_DISTRO_DEFAULTS

do all the distro #defines

#endif

Regards,
Simon
