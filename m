Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B5E6BF00
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 11:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DAA842F2;
	Fri, 30 Jan 2026 12:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qSb4MrMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCE0842F4; Fri, 30 Jan 2026 12:23:47 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BAB8420D
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 12:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 131853F2D6
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1769772224;
 bh=xVCWZ49kYd+eQf8JJSwsltl6tAD25rnwy2zyn5rhPqA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=qSb4MrMgRs1cbPLMIa3afOX00NeoPlgu/hSMmMTbdNM05eg0uc0E8VL3sbzCn/hBi
 Rx4jwurMxo7KWyIGWO2wuPQKnogA5ofAzfrVcDKlsMt0WNgFR7LuwRaHz8QsIjTsUb
 sDtVz1l894uJ2mv04fxNx/XM+SN5xh4wbGBLViykgRddEeUxj9cfPQq+kX5T6k3YNb
 +of90PHwgyUrzSWn7/dirCDgzBOe2K8zXY51LdfhyN0VFMSX2qhl4Nv2DOmTKJvEfT
 zJxjP5lGXxZnZbycEGe5kVnMQZnS3py0jOdUk3N5/5p7kwsUNnyPY6ALJo6HUBHdHm
 /W98UuoVxOfiBi8HPhS7W07B3DWMns3kw4DYpt39jQ/2iC+GfA01A9q2ftY0UNTgeT
 VjxEvv8ANgwhZzjH7ff1rj7Xyr5033grpwoH6wBel/RJl7yZR5v6mLc0h/kEBrn0iQ
 OuibDCNBa12Xp6uZ2VYn+0EHStLn9SX+6X0FIK5fSmLg17nmY87NYThQbaeFsiKezb
 HFFzOAEILCt3+vx6ToCvJqZt5RG6Nf0kML1UzdykeX0+HTjLTS8WXdgiHpKzhssi7P
 4t3ISY0VPQxYYdO4gekUNj9TuRiRlGTg4qPOlLL/Q2VG9dKGTXJfWCVXuPjK+992MZ
 T8AB+Ty8K2q4thBv4UHaGL/Y=
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b7155ca88cso2104176eec.1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:23:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769772222; cv=none;
 d=google.com; s=arc-20240605;
 b=KeT2WTCqdgBLar5LlB+e1fXf6owTwHVMz+EAALH90Lzw8L6ietf2vJTUgCpM7fJXpU
 O+ycJeJP+W5JNBX3vfVNphAb5zc5HuuT5Rn9EgAqxIFB7CEmGMFlpncG2PGV9PLZpdLM
 4LcFMUbUC7PvCn+QVzv/MZo2e/vD4Sx9/HjfF7gIY/C2sFKcmK2r3fVw+d0of8Fe/ksQ
 s1XFV5QHbcz1xFZLHZAaLD1mTntGQBTJ+vAYm8vJmqaGmeIlouVVw6IdSylMT8t32AUw
 afYlLiVYG+E6QR9lSkjO/Hk02w3GZhqyLWlb0aAZO/BYdzgqyveu86AvOCp7k9DYeDRV
 NDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=xVCWZ49kYd+eQf8JJSwsltl6tAD25rnwy2zyn5rhPqA=;
 fh=kHrjdOtZyOqGaOnZM29jzUJNoSoML2h0pQCaeUviom0=;
 b=BNBcym+D5xy5+dSqJEnC9J+KI4G/eKtqPfTW11ZI0FZbWgkqOUouwzvAGh3ewFVN1u
 vQ1ED2YJdYGNSC0/10srEIWe6M3gPhLABIWHlahtb0lryMccfDr5Yh7nb1dvwD2DuU/m
 zlVsUQHIZDcrZGobiN0jDZ3Z9j3fpACD0qJ/AGcO9lbtuIK36X+s0SwntrzxsDnGkaAx
 Joz8UGzXZWqYF55snPp5XkJlFyS9mrpb7/92qKFQyg5en26STqkKLuXP/vHYVJQRvXmO
 x4JowGpjahxkOr4lRPO0EsWWHFoKfsKqXvhpPnRuX6o3K0DW8sctBsCf0fvTTQDnNUtP
 XxdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769772222; x=1770377022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVCWZ49kYd+eQf8JJSwsltl6tAD25rnwy2zyn5rhPqA=;
 b=o/gqxMbxDjCclLMInaWrU7FJzPhBocHkoB8LxigDkMVZdSSVDTyBjjUvj+zDw6zp08
 XH6xU5xdmINZtXHsuLpRJwDSBPo5yNGNcZeND7FhkpNcmyr+lt/rhoo4CdSDYO+swqLD
 VYHANoe0v+Th+/kOXoZ037dsfb96ZPRSjCdfJ60Jr0b98zagTSU6nNgZ2ykktL//WzN9
 jdRKG1IUZjixG+R+8H+rJFQtlWhrvn9qx6wV2D1/udimNB7+1QuvB1Nq3qnGKfBKNZfN
 1IAoO+WfA/kcrts2xssXIxEgLuUg0U6KmPX0cpxblzSjgq/bAoo9qMOuCFcPl+6XTSOn
 /p3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9vaJTepRMX4CGQ4fRSsKOtulnt/FOMVucDUj6KL0imFaLNtpQPN94J+7xJBBuZzJUydiGmmk=@lists.denx.de
X-Gm-Message-State: AOJu0YyaEt9gdRnH54dExo7eAC5euZMfyol9RP5jPo8nopqdwGzaMHoI
 h8NoSHXgbdoONjCPa/BX66X1R1F8kgqisLltpShjQvkT6VLxPmFhWl6bvM3F5XK6fIZFc7zgWYm
 AXjJuxN27U6Lwjf9ezNkOqcFdtsEiymzGFSmmW8UXhllFZvYHWv+KO/zs+7/PWcBCEnMakOWDwT
 gDT85CoobV0HyrLGZwk7TEsfa0CMx8N10tRmTlcJIQsQwzFqgVeDMUkA==
X-Gm-Gg: AZuq6aKAn2pbW9iW19aZ1yB7rnzJo4K3pS0GUJEAMDyewekPmXVJn32OQJBuU/yv1/w
 V17U6/Q3TQolpDojrB/XP6CawhQZPV087qKqO4xWsqmNWKO0VA4JjzJPToMAmlz3jcVV9R7IB2E
 s/2F2gbpH5fZs0TJRybKcWanVQsqQZxeTHSOB8sdHgGyATcYD/j8HiDi4E1YxG2SA=
X-Received: by 2002:a05:7300:a984:b0:2b7:22f1:4fb4 with SMTP id
 5a478bee46e88-2b7c88faaf7mr1136917eec.31.1769772222552; 
 Fri, 30 Jan 2026 03:23:42 -0800 (PST)
X-Received: by 2002:a05:7300:a984:b0:2b7:22f1:4fb4 with SMTP id
 5a478bee46e88-2b7c88faaf7mr1136900eec.31.1769772222074; Fri, 30 Jan 2026
 03:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20260107201838.3448806-1-visitorckw@gmail.com>
 <20260107201838.3448806-5-visitorckw@gmail.com>
In-Reply-To: <20260107201838.3448806-5-visitorckw@gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Fri, 30 Jan 2026 12:23:31 +0100
X-Gm-Features: AZwV_Qja4tXQwvnfOAv8dJdHfjVaVWdkOubhSFNUuhQiXb3-9GQXEzDz6bcHlJs
Message-ID: <CAM=mAOmcekYneTSMwsXQLxdggZU3A7OTHkLJmZEywHL2hmyXEA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] sysreset: Add QEMU virtual system controller driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Alison Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, daniel@0x0f.com, 
 Simon Glass <sjg@chromium.org>, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Kuan-Wei Chiu <visitorckw@gmail.com> schrieb am Mi., 7. Jan. 2026, 21:19:

> Introduce a new sysreset driver for the QEMU Virtual System Controller.
> This device is found on QEMU "virt" machines (such as the m68k virt
> target) and provides a mechanism to trigger system reset and power-off
> events.
>
> The driver maps U-Boot sysreset types to the corresponding controller
> commands:
> - SYSRESET_WARM / SYSRESET_COLD -> VIRT_CTRL_CMD_RESET
> - SYSRESET_POWER_OFF -> VIRT_CTRL_CMD_HALT
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v6:
> - Introduce new driver to replace board-file reset implementation.
>
>  MAINTAINERS                                |  6 +++
>  drivers/sysreset/Kconfig                   |  8 ++++
>  drivers/sysreset/Makefile                  |  1 +
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 55 ++++++++++++++++++++++
>  include/qemu_virt_ctrl.h                   | 13 +++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 drivers/sysreset/sysreset_qemu_virt_ctrl.c
>  create mode 100644 include/qemu_virt_ctrl.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efecb213be7..34081769ecd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1598,6 +1598,12 @@ S:       Maintained
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
>  F:     arch/powerpc/cpu/mpc85xx/
>
> +QEMU VIRTUAL SYSTEM CONTROLLER
> +M:     Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:     Maintained
> +F:     drivers/sysreset/sysreset_qemu_virt_ctrl.c
> +F:     include/qemu_virt_ctrl.h
> +
>  RAW NAND
>  M:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
>  M:     Michael Trimarchi <michael@amarulasolutions.com>
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 0181f6cd581..120e7510f15 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -298,6 +298,14 @@ config SYSRESET_QCOM_PSHOLD
>         help
>           Add support for the system reboot on Qualcomm SoCs via PSHOLD.
>
> +config SYSRESET_QEMU_VIRT_CTRL
> +       bool "QEMU Virtual System Controller support"
> +       depends on SYSRESET
> +       help
> +         Enable support for the QEMU Virtual System Controller.
> +         This device is used in QEMU machines (e.g. m68k virt) to trigger
>

Is this specific to m68k or does it work on all QEMU architectures? If it
works everywhere, I would not mention m68k here.

On x86 QEMU we currently lack poweroff support. So this would come in handy.

Best regards

Heinrich

+         system reset and poweroff events.
> +
>  endif
>
>  endmenu
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index f5c78b25896..d18a5d52360 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>  obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
>  obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>  obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> +obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
> diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> new file mode 100644
> index 00000000000..e7cacc9b6e9
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + *
> + * QEMU Virtual System Controller Driver
> + */
> +
> +#include <dm.h>
> +#include <qemu_virt_ctrl.h>
> +#include <sysreset.h>
> +#include <asm/io.h>
> +#include <linux/err.h>
> +
> +/* Register offsets */
> +#define VIRT_CTRL_REG_FEATURES  0x00
> +#define VIRT_CTRL_REG_CMD       0x04
> +
> +/* Commands */
> +#define VIRT_CTRL_CMD_NOOP      0x00
> +#define VIRT_CTRL_CMD_RESET     0x01
> +#define VIRT_CTRL_CMD_HALT      0x02
> +#define VIRT_CTRL_CMD_PANIC     0x03
> +
> +static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t
> type)
> +{
> +       struct qemu_virt_ctrl_plat *plat = dev_get_plat(dev);
> +       u32 val;
> +
> +       switch (type) {
> +       case SYSRESET_WARM:
> +       case SYSRESET_COLD:
> +               val = VIRT_CTRL_CMD_RESET;
> +               break;
> +       case SYSRESET_POWER_OFF:
> +               val = VIRT_CTRL_CMD_HALT;
> +               break;
> +       default:
> +               return -EPROTONOSUPPORT;
> +       }
> +
> +       writel(val, plat->reg + VIRT_CTRL_REG_CMD);
> +
> +       return -EINPROGRESS;
> +}
> +
> +static struct sysreset_ops qemu_virt_ctrl_ops = {
> +       .request = qemu_virt_ctrl_request,
> +};
> +
> +U_BOOT_DRIVER(sysreset_qemu_virt_ctrl) = {
> +       .name = "sysreset_qemu_virt_ctrl",
> +       .id = UCLASS_SYSRESET,
> +       .ops = &qemu_virt_ctrl_ops,
> +       .plat_auto = sizeof(struct qemu_virt_ctrl_plat),
> +};
> diff --git a/include/qemu_virt_ctrl.h b/include/qemu_virt_ctrl.h
> new file mode 100644
> index 00000000000..05aad82b767
> --- /dev/null
> +++ b/include/qemu_virt_ctrl.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef _QEMU_VIRT_CTRL_H_
> +#define _QEMU_VIRT_CTRL_H_
> +
> +struct qemu_virt_ctrl_plat {
> +       phys_addr_t reg;
> +};
> +
> +#endif /* _QEMU_VIRT_CTRL_H_ */
> --
> 2.52.0.457.g6b5491de43-goog
>
>
