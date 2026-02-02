Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5ADE7DEEF
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 14:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBE683EEF;
	Mon,  2 Feb 2026 15:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKkqoV+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C66683D7A; Mon,  2 Feb 2026 09:11:48 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4F183D77
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 09:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82310b74496so2372835b3a.3
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770019903; x=1770624703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cwhRspcFcoyk8KEJ0bPYD8t4m6/JwU09lOj/dC8o690=;
 b=AKkqoV+6AyUVQ4GxnMzhVwuNERPGx9SJscer4PymvdY1vSYcx/MtvRXsEhS80TEBkN
 8fFN+F/HP8GUOL082FTk0yHzAwaSUdLRQ3cokXq3qh6+PdGcSqHhT6vssytsH79Agfuo
 QUOCY4ThsDqDTalSprBh+CWuJHC8THB6Xa64mHkWNF6TC81gnz+2SlHSAGRbItOhOLaR
 d77l+bxS+nHZV0quc7Pl3bniDPNRXilJhRt61CN0qfLZrHeHVw7StRxjCqiyXwwjrO0y
 Dwoxp7DNavz1zNK+LaoNCduw095O3HDo5eECcQk0brFD3pFrpmCzPejSRP92XzpTA4Ms
 kZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770019903; x=1770624703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwhRspcFcoyk8KEJ0bPYD8t4m6/JwU09lOj/dC8o690=;
 b=EvPrhOc4g8Zvr1YkbGP7aC8jDygeTwZcC4sN/tZVCCYgpwbwNt6pJmtG7DNcoUg/66
 Vf/zWj8wgGq0GjRFrR0Aj9LXRKDM2blolOu18yjY0E6sVkhcWsowzVEF+IpHwPou3OtG
 q84bHlAc2FLKFOWxyoQ8phmqqAuWKVS1kIUPaggIEEE/8yf2MyHH5B2BqekwcWvrJcyJ
 /zaqR28VPWBI+zJgWgK8V/Z1ExW2+yUlF3O+H7xEaG88Fc7V6zhBR85jluENmo7LJU/v
 C0bc1j0I5Q7Ot8DU7BCGyVSZ8J31AF03Y7FV8HsESG69r8vSTSo6Tl68JoqncPp5lM/3
 dRZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP3Nl0aFs4IFSseCbl2TP6WuCVg+gLRFua/VosL1SXqzxjzQ4kqE2bBKn6FYPzoteB+s2nwxg=@lists.denx.de
X-Gm-Message-State: AOJu0YxhK2E/CSL8zJresghuwnpxmB4xXJuYPlhq08u0Up/ClYYN6m28
 c3Zjp93FcpIAdpN9P359L6xt2EFi42s7ISS0241UpURu9rermdFE+0ok
X-Gm-Gg: AZuq6aL3WMG47pCof06lvjGS57/jIAle/HmTsFFjXMh3fUtxPoIQyRGir79W60ym0xx
 HoZyNUtoU3aedFzuXnG3wEPZoJQWNF8sMDxyS/v0Ps0ICW7XsqfFyMw5ONnCSQmadWDMGEtzY+U
 EqNH7hY5IbiIG7WlnTFFr8k5+NPk6fk8EaLYQC1hI7U4P4s9xFMzUd/CRFXfRzo2RhlkT1PNVH+
 1pw/scVwMwdL7cya4DzhxIQWVMHUWmRxxMBQb83qJUcRsiL3o3I+OOh4X7uqS+sPHreyBh23yOt
 NbKEl82Ii4Tgapmvk3JX0YJu8P5VAtJa5tyf+EJcV9VFBeAYY/bGHP7/ureNZ5i2I5ag+JrVkW5
 Agh/XpUGWfrochC8qQwvAykzVMWHBVMFnggkjxT8h0GE0OqP+JYPHBRqYbcVEPQzDY826wNr73e
 NCAM5BsllPHynnvaKdR9XfiKmG
X-Received: by 2002:a05:6a21:9d91:b0:387:a311:3825 with SMTP id
 adf61e73a8af0-392e016eca4mr10427108637.61.1770019903128; 
 Mon, 02 Feb 2026 00:11:43 -0800 (PST)
Received: from google.com ([2402:7500:479:35ee:d067:66a5:801b:b821])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6427da845csm13647610a12.12.2026.02.02.00.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 00:11:42 -0800 (PST)
Date: Mon, 2 Feb 2026 16:11:39 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>,
 daniel@0x0f.com, Simon Glass <sjg@chromium.org>,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 4/8] sysreset: Add QEMU virtual system controller driver
Message-ID: <aYBcO6pQYJpoc_H5@google.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
 <20260107201838.3448806-5-visitorckw@gmail.com>
 <CAM=mAOmcekYneTSMwsXQLxdggZU3A7OTHkLJmZEywHL2hmyXEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM=mAOmcekYneTSMwsXQLxdggZU3A7OTHkLJmZEywHL2hmyXEA@mail.gmail.com>
X-Mailman-Approved-At: Mon, 02 Feb 2026 15:12:15 +0100
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

Hi Heinrich,

On Fri, Jan 30, 2026 at 12:23:31PM +0100, Heinrich Schuchardt wrote:
> Kuan-Wei Chiu <visitorckw@gmail.com> schrieb am Mi., 7. Jan. 2026, 21:19:
> 
> > Introduce a new sysreset driver for the QEMU Virtual System Controller.
> > This device is found on QEMU "virt" machines (such as the m68k virt
> > target) and provides a mechanism to trigger system reset and power-off
> > events.
> >
> > The driver maps U-Boot sysreset types to the corresponding controller
> > commands:
> > - SYSRESET_WARM / SYSRESET_COLD -> VIRT_CTRL_CMD_RESET
> > - SYSRESET_POWER_OFF -> VIRT_CTRL_CMD_HALT
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v6:
> > - Introduce new driver to replace board-file reset implementation.
> >
> >  MAINTAINERS                                |  6 +++
> >  drivers/sysreset/Kconfig                   |  8 ++++
> >  drivers/sysreset/Makefile                  |  1 +
> >  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 55 ++++++++++++++++++++++
> >  include/qemu_virt_ctrl.h                   | 13 +++++
> >  5 files changed, 83 insertions(+)
> >  create mode 100644 drivers/sysreset/sysreset_qemu_virt_ctrl.c
> >  create mode 100644 include/qemu_virt_ctrl.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index efecb213be7..34081769ecd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1598,6 +1598,12 @@ S:       Maintained
> >  T:     git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
> >  F:     arch/powerpc/cpu/mpc85xx/
> >
> > +QEMU VIRTUAL SYSTEM CONTROLLER
> > +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> > +S:     Maintained
> > +F:     drivers/sysreset/sysreset_qemu_virt_ctrl.c
> > +F:     include/qemu_virt_ctrl.h
> > +
> >  RAW NAND
> >  M:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >  M:     Michael Trimarchi <michael@amarulasolutions.com>
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > index 0181f6cd581..120e7510f15 100644
> > --- a/drivers/sysreset/Kconfig
> > +++ b/drivers/sysreset/Kconfig
> > @@ -298,6 +298,14 @@ config SYSRESET_QCOM_PSHOLD
> >         help
> >           Add support for the system reboot on Qualcomm SoCs via PSHOLD.
> >
> > +config SYSRESET_QEMU_VIRT_CTRL
> > +       bool "QEMU Virtual System Controller support"
> > +       depends on SYSRESET
> > +       help
> > +         Enable support for the QEMU Virtual System Controller.
> > +         This device is used in QEMU machines (e.g. m68k virt) to trigger
> >
> 
> Is this specific to m68k or does it work on all QEMU architectures? If it
> works everywhere, I would not mention m68k here.

The virt-ctrl device was originally introduced in qemu for the m68k
virt machine, which remains its sole user to date. However, as the
implementation resides in hw/misc/virt_ctrl.c, I believe it was
designed to be generic and architecture-agnostic from the start.

Regards,
Kuan-Wei

> 
> On x86 QEMU we currently lack poweroff support. So this would come in handy.
> 
> Best regards
> 
> Heinrich
> 
> +         system reset and poweroff events.
> > +
> >  endif
> >
> >  endmenu
> > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > index f5c78b25896..d18a5d52360 100644
> > --- a/drivers/sysreset/Makefile
> > +++ b/drivers/sysreset/Makefile
> > @@ -32,3 +32,4 @@ obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
> >  obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> >  obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
> >  obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> > +obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
> > diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> > b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> > new file mode 100644
> > index 00000000000..e7cacc9b6e9
> > --- /dev/null
> > +++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + *
> > + * QEMU Virtual System Controller Driver
> > + */
> > +
> > +#include <dm.h>
> > +#include <qemu_virt_ctrl.h>
> > +#include <sysreset.h>
> > +#include <asm/io.h>
> > +#include <linux/err.h>
> > +
> > +/* Register offsets */
> > +#define VIRT_CTRL_REG_FEATURES  0x00
> > +#define VIRT_CTRL_REG_CMD       0x04
> > +
> > +/* Commands */
> > +#define VIRT_CTRL_CMD_NOOP      0x00
> > +#define VIRT_CTRL_CMD_RESET     0x01
> > +#define VIRT_CTRL_CMD_HALT      0x02
> > +#define VIRT_CTRL_CMD_PANIC     0x03
> > +
> > +static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t
> > type)
> > +{
> > +       struct qemu_virt_ctrl_plat *plat = dev_get_plat(dev);
> > +       u32 val;
> > +
> > +       switch (type) {
> > +       case SYSRESET_WARM:
> > +       case SYSRESET_COLD:
> > +               val = VIRT_CTRL_CMD_RESET;
> > +               break;
> > +       case SYSRESET_POWER_OFF:
> > +               val = VIRT_CTRL_CMD_HALT;
> > +               break;
> > +       default:
> > +               return -EPROTONOSUPPORT;
> > +       }
> > +
> > +       writel(val, plat->reg + VIRT_CTRL_REG_CMD);
> > +
> > +       return -EINPROGRESS;
> > +}
> > +
> > +static struct sysreset_ops qemu_virt_ctrl_ops = {
> > +       .request = qemu_virt_ctrl_request,
> > +};
> > +
> > +U_BOOT_DRIVER(sysreset_qemu_virt_ctrl) = {
> > +       .name = "sysreset_qemu_virt_ctrl",
> > +       .id = UCLASS_SYSRESET,
> > +       .ops = &qemu_virt_ctrl_ops,
> > +       .plat_auto = sizeof(struct qemu_virt_ctrl_plat),
> > +};
> > diff --git a/include/qemu_virt_ctrl.h b/include/qemu_virt_ctrl.h
> > new file mode 100644
> > index 00000000000..05aad82b767
> > --- /dev/null
> > +++ b/include/qemu_virt_ctrl.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> > + */
> > +
> > +#ifndef _QEMU_VIRT_CTRL_H_
> > +#define _QEMU_VIRT_CTRL_H_
> > +
> > +struct qemu_virt_ctrl_plat {
> > +       phys_addr_t reg;
> > +};
> > +
> > +#endif /* _QEMU_VIRT_CTRL_H_ */
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
> >
