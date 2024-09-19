Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DF4CDD573
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2360089167;
	Thu, 19 Sep 2024 15:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h2MYkHnQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8CD890F7; Thu, 19 Sep 2024 11:01:45 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B371890FE
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e042f4636dso367718b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726736499; x=1727341299; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=19yRH4ambhoVE9DkXflQElGemOqCmWtoWrqQejqO0T0=;
 b=h2MYkHnQzrre7pUIWnYBGJ1hNXANNTIK3LmiQEBHcu1WzGodGFi4Z5TE7uKnuQVMNw
 FuN3b4GWtBqCHaRAYH/v/BsHy4VqoJeYx+cKgddwGiZoX6UByVNzFyYqeTdrVdqfCzYA
 4WPltWxTkeDqtfF2Ht9nfOs6gtgraW1dwCMVwbfnkcLQm+EIj3C+hh7lFk9d2z9Ircad
 cs+2lE3VS6dKU7XwvXGFkEqTy+Zyr9NHQDmpkLQ2UbRrg5yMLTD/S7r9/fijF7I6qmEa
 AQeUK8FWiqn1XalG/s8ty7f2b6+6SaxZqsRImQOoF+UaKFWhzCHRWBDZUp9Q2TwQyVKn
 SrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726736499; x=1727341299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19yRH4ambhoVE9DkXflQElGemOqCmWtoWrqQejqO0T0=;
 b=YiIu/IHuZFulgMZexIbrZOMtc9nlWITel7XR1r7W2AJpOn5NmGn+X87bNznFaxGP+u
 z8thaBt0SAZ+ntfM+VbiF0dKD/qb+sDXO7fL/NwHRO1Y2GNAJpPULBAFYt5EvL7Trg/b
 5HY6IT06hVfbfk9/EXx9lknhdr4vq/e6+pusNUy1/9/cVNUTiTe0CkhwGKLdxS+yPXCK
 n75ldyjEdmmLhU7+F5lcDLw75byihgbYoJau4SXwn7+4V1pN314b5Iyo0CVin5NztlB4
 YpwbwAxWhIO2hrXrunH5EVGgdwYYYyreNGgGe98sLQfbrnTwAtcQJ404OTNucBSq+/kR
 ogWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbCP9EAjp7D9OPhwxf03l3vd10QSKqFtygLM15IgEZ4WHqANhnopgAvJAaN5gytWDFcMX1vEw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9Cb5YlER5EhFvj94rrO+AxJ0/Xu+CDK5mu4DxWjKKIR6WTqgb
 5UKex4dt6rZQZ7PPu6yMxvAB1fwITgUOkCFPkFGGAXE1/jehIM4dR6L6a7HNSvsmvyaCQJ1Oaaz
 u9sH4UwXbgEP6l9QXBLWw1isybgU=
X-Google-Smtp-Source: AGHT+IHvB2xZyjpnnvbF+UujwhFSWBZmHiTd6XlkLWiIBfXWCe+zL5pR0sdn5sDtY2G23s2Z/HEWYwpTG9W0HaPIaXc=
X-Received: by 2002:a05:6808:1821:b0:3e0:6b72:f324 with SMTP id
 5614622812f47-3e07a125223mr12761106b6e.20.1726736498311; Thu, 19 Sep 2024
 02:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240905151707.59101-1-sebastian.reichel@collabora.com>
 <20240905151707.59101-2-sebastian.reichel@collabora.com>
In-Reply-To: <20240905151707.59101-2-sebastian.reichel@collabora.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Sep 2024 14:31:21 +0530
Message-ID: <CANAwSgR9+GGhhDnbKevB+and23YrkahJYxDYYtqpkaqO2KE2nA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] usb: tcpm: add core framework
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, 
 Soeren Moch <smoch@web.de>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 19 Sep 2024 15:10:06 +0200
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

Hi Sebastian,

On Thu, 5 Sept 2024 at 21:06, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> This adds TCPM framework in preparation for fusb302 support, which can
> handle USB power delivery messages. This is needed to solve issues with
> devices, that are running from a USB-C port supporting USB-PD, but not
> having a battery.
>
> Such a device currently boots to the kernel without interacting with
> the power-supply at all. If there are no USB-PD message replies within
> 5 seconds, the power-supply assumes the peripheral is not capable of
> USB-PD. It usually takes more than 5 seconds for the system to reach
> the kernel and probe the I2C based fusb302 chip driver. Thus the
> system always runs into this state. The power-supply's solution to
> fix this error state is a hard reset, which involves removing the
> power from VBUS. Boards without a battery (or huge capacitors) will
> reset at this point resulting in a boot loop.
>
> This imports the TCPM framework from the kernel. The porting has
> originally been done by Rockchip using hardware timers and the Linux
> kernel's TCPM code from some years ago.
>
> I had a look at upgrading to the latest TCPM kernel code, but that
> beast became a lot more complex due to adding more USB-C features.
> I believe these features are not needed in U-Boot and with multiple
> kthreads and hrtimers being involved it is non-trivial to port them.
> Instead I worked on stripping down features from the Rockchip port
> to an even more basic level. Also the TCPM code has been reworked
> to avoid complete use of any timers (Rockchip used SoC specific
> hardware timers + IRQ to implement delayed work mechanism). Instead
> the delayed state changes are handled directly from the poll loop.
>
> Note, that (in contrast to the original Rockchip port) the state
> machine has the same hard reset quirk, that the kernel has - i.e.
> it avoids disabling the CC pin resistors for devices that are not
> self-powered. Without that quirk, the Radxa Rock 5B will not just
> end up doing a machine reset when a hard reset is triggered, but will
> not even recover, because the CPU will loose power and the FUSB302
> will keep this state because of leak voltage arriving through the RX
> serial pin (assuming a serial adapter is connected).
>
> This also includes a 'tcpm' command, which can be used to get
> information about the current state and the negotiated voltage
> and current.
>
> Co-developed-by: Wang Jie <dave.wang@rock-chips.com>
> Signed-off-by: Wang Jie <dave.wang@rock-chips.com>
> Tested-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

For the whole series.

Tested-by: Anand Moon <linux.amoon@gmail.com>

> ---
>  Makefile                         |    1 +
>  cmd/Kconfig                      |    7 +
>  cmd/Makefile                     |    1 +
>  cmd/tcpm.c                       |  136 ++
>  doc/usage/cmd/tcpm.rst           |   66 +
>  doc/usage/index.rst              |    1 +
>  drivers/usb/Kconfig              |    2 +
>  drivers/usb/tcpm/Kconfig         |    8 +
>  drivers/usb/tcpm/Makefile        |    3 +
>  drivers/usb/tcpm/tcpm-internal.h |  173 +++
>  drivers/usb/tcpm/tcpm-uclass.c   |  149 ++
>  drivers/usb/tcpm/tcpm.c          | 2288 ++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h           |    1 +
>  include/usb/pd.h                 |  516 +++++++
>  include/usb/tcpm.h               |   99 ++
>  15 files changed, 3451 insertions(+)
>  create mode 100644 cmd/tcpm.c
>  create mode 100644 doc/usage/cmd/tcpm.rst
>  create mode 100644 drivers/usb/tcpm/Kconfig
>  create mode 100644 drivers/usb/tcpm/Makefile
>  create mode 100644 drivers/usb/tcpm/tcpm-internal.h
>  create mode 100644 drivers/usb/tcpm/tcpm-uclass.c
>  create mode 100644 drivers/usb/tcpm/tcpm.c
>  create mode 100644 include/usb/pd.h
>  create mode 100644 include/usb/tcpm.h
>
> diff --git a/Makefile b/Makefile
> index 74df5d177c1f..5a581199c170 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -879,6 +879,7 @@ libs-y += drivers/usb/musb/
>  libs-y += drivers/usb/musb-new/
>  libs-y += drivers/usb/isp1760/
>  libs-y += drivers/usb/phy/
> +libs-y += drivers/usb/tcpm/
>  libs-y += drivers/usb/ulpi/
>  ifdef CONFIG_POST
>  libs-y += post/
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda426..7710bee22ace 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -221,6 +221,13 @@ config CMD_REGINFO
>         help
>           Register dump
>
> +config CMD_TCPM
> +       bool "tcpm"
> +       depends on TYPEC_TCPM
> +       help
> +         Show voltage and current negotiated via USB PD as well as the
> +         current state of the Type C Port Manager (TCPM) state machine.
> +
>  config CMD_TLV_EEPROM
>         bool "tlv_eeprom"
>         depends on I2C_EEPROM
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 87133cc27a8a..bd0b23ef1013 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -172,6 +172,7 @@ obj-$(CONFIG_CMD_SMBIOS) += smbios.o
>  obj-$(CONFIG_CMD_SMC) += smccc.o
>  obj-$(CONFIG_CMD_SYSBOOT) += sysboot.o
>  obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) += stackprot_test.o
> +obj-$(CONFIG_CMD_TCPM) += tcpm.o
>  obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
>  obj-$(CONFIG_CMD_TERMINAL) += terminal.o
>  obj-$(CONFIG_CMD_TIME) += time.o
> diff --git a/cmd/tcpm.c b/cmd/tcpm.c
> new file mode 100644
> index 000000000000..962cd234a869
> --- /dev/null
> +++ b/cmd/tcpm.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Collabora
> + */
> +
> +#include <command.h>
> +#include <errno.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>
> +#include <usb/tcpm.h>
> +
> +#define LIMIT_DEV      32
> +#define LIMIT_PARENT   20
> +
> +static struct udevice *currdev;
> +
> +static int do_dev(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       char *name;
> +       int ret = -ENODEV;
> +
> +       switch (argc) {
> +       case 2:
> +               name = argv[1];
> +               ret = tcpm_get(name, &currdev);
> +               if (ret) {
> +                       log_err("Can't get TCPM %s: %d (%s)!\n", name, ret, errno_str(ret));
> +                       return CMD_RET_FAILURE;
> +               }
> +       case 1:
> +               if (!currdev) {
> +                       log_err("TCPM device is not set!\n\n");
> +                       return CMD_RET_USAGE;
> +               }
> +
> +               printf("dev: %d @ %s\n", dev_seq(currdev), currdev->name);
> +       }
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +static int do_list(struct cmd_tbl *cmdtp, int flag, int argc,
> +                  char *const argv[])
> +{
> +       struct udevice *dev;
> +       int ret, err = 0;
> +
> +       printf("| %-*.*s| %-*.*s| %s @ %s\n",
> +              LIMIT_DEV, LIMIT_DEV, "Name",
> +              LIMIT_PARENT, LIMIT_PARENT, "Parent name",
> +              "Parent uclass", "seq");
> +
> +       for (ret = uclass_first_device_check(UCLASS_TCPM, &dev); dev;
> +            ret = uclass_next_device_check(&dev)) {
> +               if (ret)
> +                       err = ret;
> +
> +               printf("| %-*.*s| %-*.*s| %s @ %d | status: %i\n",
> +                      LIMIT_DEV, LIMIT_DEV, dev->name,
> +                      LIMIT_PARENT, LIMIT_PARENT, dev->parent->name,
> +                      dev_get_uclass_name(dev->parent), dev_seq(dev->parent),
> +                      ret);
> +       }
> +
> +       if (err)
> +               return CMD_RET_FAILURE;
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +int do_print_info(struct udevice *dev)
> +{
> +       enum typec_orientation orientation = tcpm_get_orientation(dev);
> +       const char *state = tcpm_get_state(dev);
> +       int pd_rev = tcpm_get_pd_rev(dev);
> +       int mv = tcpm_get_voltage(dev);
> +       int ma = tcpm_get_current(dev);
> +       enum typec_role pwr_role = tcpm_get_pwr_role(dev);
> +       enum typec_data_role data_role = tcpm_get_data_role(dev);
> +       bool connected = tcpm_is_connected(dev);
> +
> +       if (!connected) {
> +               printf("TCPM State: %s\n", state);
> +               return 0;
> +       }
> +
> +       printf("Orientation: %s\n", typec_orientation_name[orientation]);
> +       printf("PD Revision: %s\n", typec_pd_rev_name[pd_rev]);
> +       printf("Power Role:  %s\n", typec_role_name[pwr_role]);
> +       printf("Data Role:   %s\n", typec_data_role_name[data_role]);
> +       printf("Voltage:     %2d.%03d V\n", mv / 1000, mv % 1000);
> +       printf("Current:     %2d.%03d A\n", ma / 1000, ma % 1000);
> +
> +       return 0;
> +}
> +
> +static int do_info(struct cmd_tbl *cmdtp, int flag, int argc,
> +                  char *const argv[])
> +{
> +       if (!currdev) {
> +               printf("First, set the TCPM device!\n");
> +               return CMD_RET_USAGE;
> +       }
> +
> +       return do_print_info(currdev);
> +}
> +
> +static struct cmd_tbl subcmd[] = {
> +       U_BOOT_CMD_MKENT(dev, 2, 1, do_dev, "", ""),
> +       U_BOOT_CMD_MKENT(list, 1, 1, do_list, "", ""),
> +       U_BOOT_CMD_MKENT(info, 1, 1, do_info, "", ""),
> +};
> +
> +static int do_tcpm(struct cmd_tbl *cmdtp, int flag, int argc,
> +                  char *const argv[])
> +{
> +       struct cmd_tbl *cmd;
> +
> +       argc--;
> +       argv++;
> +
> +       cmd = find_cmd_tbl(argv[0], subcmd, ARRAY_SIZE(subcmd));
> +       if (!cmd || argc > cmd->maxargs)
> +               return CMD_RET_USAGE;
> +
> +       return cmd->cmd(cmdtp, flag, argc, argv);
> +}
> +
> + /**************************************************/
> +
> +U_BOOT_CMD(tcpm, CONFIG_SYS_MAXARGS, 1, do_tcpm,
> +       "TCPM sub-system",
> +       "list          - list TCPM devices\n"
> +       "tcpm dev [name]    - show or [set] operating TCPM device\n"
> +       "tcpm info          - dump information\n"
> +);
> diff --git a/doc/usage/cmd/tcpm.rst b/doc/usage/cmd/tcpm.rst
> new file mode 100644
> index 000000000000..1e8199c0f89c
> --- /dev/null
> +++ b/doc/usage/cmd/tcpm.rst
> @@ -0,0 +1,66 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +.. index::
> +   single: tcpm (command)
> +
> +tcpm command
> +============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    tcpm dev [devname]
> +    tcpm info
> +    tcpm list
> +
> +Description
> +-----------
> +
> +The tcpm command is used to control USB-PD controllers, also known as TypeC Port Manager (TCPM).
> +
> +The 'tcpm dev' command shows or set current TCPM device.
> +
> +    devname
> +        device name to change
> +
> +The 'tcpm info' command displays the current state of the device
> +
> +The 'tcpm list' command displays the list available devices.
> +
> +Examples
> +--------
> +
> +The 'tcpm info' command displays device's status:
> +::
> +
> +    => tcpm info
> +    Orientation: normal
> +    PD Revision: rev3
> +    Power Role:  sink
> +    Data Role:   device
> +    Voltage:     20.000 V
> +    Current:      2.250 A
> +
> +The current device can be shown or set via 'tcpm dev' command:
> +::
> +
> +    => tcpm dev
> +    TCPM device is not set!
> +    => tcpm dev usb-typec@22
> +    dev: 0 @ usb-typec@22
> +    => tcpm dev
> +    dev: 0 @ usb-typec@22
> +
> +The list of available devices can be shown via 'tcpm list' command:
> +::
> +
> +    => tcpm list
> +    | Name                            | Parent name         | Parent uclass @ seq
> +    | usb-typec@22                    | i2c@feac0000        | i2c @ 4 | status: 0
> +
> +Configuration
> +-------------
> +
> +The tcpm command is only available if CONFIG_CMD_TCPM=y.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 6a218c46b4e4..b4be42f59119 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -111,6 +111,7 @@ Shell commands
>     cmd/smbios
>     cmd/sound
>     cmd/source
> +   cmd/tcpm
>     cmd/temperature
>     cmd/tftpput
>     cmd/trace
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index a972d87c7ad4..985d3a9ef7e6 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -85,6 +85,8 @@ source "drivers/usb/emul/Kconfig"
>
>  source "drivers/usb/phy/Kconfig"
>
> +source "drivers/usb/tcpm/Kconfig"
> +
>  source "drivers/usb/ulpi/Kconfig"
>
>  if USB_HOST
> diff --git a/drivers/usb/tcpm/Kconfig b/drivers/usb/tcpm/Kconfig
> new file mode 100644
> index 000000000000..55bf8e202b90
> --- /dev/null
> +++ b/drivers/usb/tcpm/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config TYPEC_TCPM
> +       tristate "USB Type-C Port Controller Manager"
> +       depends on DM
> +       help
> +         The Type-C Port Controller Manager provides a USB PD and USB Type-C
> +         state machine for use with Type-C Port Controllers.
> diff --git a/drivers/usb/tcpm/Makefile b/drivers/usb/tcpm/Makefile
> new file mode 100644
> index 000000000000..a0f76436f3fd
> --- /dev/null
> +++ b/drivers/usb/tcpm/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_TYPEC_TCPM) += tcpm.o tcpm-uclass.o
> diff --git a/drivers/usb/tcpm/tcpm-internal.h b/drivers/usb/tcpm/tcpm-internal.h
> new file mode 100644
> index 000000000000..561442090027
> --- /dev/null
> +++ b/drivers/usb/tcpm/tcpm-internal.h
> @@ -0,0 +1,173 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2015-2017 Google, Inc
> + * Copyright 2024 Collabora
> + */
> +
> +#ifndef __LINUX_USB_TCPM_INTERNAL_H
> +#define __LINUX_USB_TCPM_INTERNAL_H
> +
> +#define FOREACH_TCPM_STATE(S)                  \
> +       S(INVALID_STATE),                       \
> +       S(TOGGLING),                    \
> +       S(SRC_UNATTACHED),                      \
> +       S(SRC_ATTACH_WAIT),                     \
> +       S(SRC_ATTACHED),                        \
> +       S(SRC_STARTUP),                         \
> +       S(SRC_SEND_CAPABILITIES),               \
> +       S(SRC_SEND_CAPABILITIES_TIMEOUT),       \
> +       S(SRC_NEGOTIATE_CAPABILITIES),          \
> +       S(SRC_TRANSITION_SUPPLY),               \
> +       S(SRC_READY),                           \
> +       S(SRC_WAIT_NEW_CAPABILITIES),           \
> +                                               \
> +       S(SNK_UNATTACHED),                      \
> +       S(SNK_ATTACH_WAIT),                     \
> +       S(SNK_DEBOUNCED),                       \
> +       S(SNK_ATTACHED),                        \
> +       S(SNK_STARTUP),                         \
> +       S(SNK_DISCOVERY),                       \
> +       S(SNK_DISCOVERY_DEBOUNCE),              \
> +       S(SNK_DISCOVERY_DEBOUNCE_DONE),         \
> +       S(SNK_WAIT_CAPABILITIES),               \
> +       S(SNK_NEGOTIATE_CAPABILITIES),          \
> +       S(SNK_TRANSITION_SINK),                 \
> +       S(SNK_TRANSITION_SINK_VBUS),            \
> +       S(SNK_READY),                           \
> +                                               \
> +       S(HARD_RESET_SEND),                     \
> +       S(HARD_RESET_START),                    \
> +       S(SRC_HARD_RESET_VBUS_OFF),             \
> +       S(SRC_HARD_RESET_VBUS_ON),              \
> +       S(SNK_HARD_RESET_SINK_OFF),             \
> +       S(SNK_HARD_RESET_WAIT_VBUS),            \
> +       S(SNK_HARD_RESET_SINK_ON),              \
> +                                               \
> +       S(SOFT_RESET),                          \
> +       S(SOFT_RESET_SEND),                     \
> +                                               \
> +       S(DR_SWAP_ACCEPT),                      \
> +       S(DR_SWAP_CHANGE_DR),                   \
> +                                               \
> +       S(ERROR_RECOVERY),                      \
> +       S(PORT_RESET),                          \
> +       S(PORT_RESET_WAIT_OFF)
> +
> +#define GENERATE_TCPM_ENUM(e)          e
> +#define GENERATE_TCPM_STRING(s)                #s
> +#define TCPM_POLL_EVENT_TIME_OUT       2000
> +
> +enum tcpm_state {
> +       FOREACH_TCPM_STATE(GENERATE_TCPM_ENUM)
> +};
> +
> +enum pd_msg_request {
> +       PD_MSG_NONE = 0,
> +       PD_MSG_CTRL_REJECT,
> +       PD_MSG_CTRL_WAIT,
> +       PD_MSG_CTRL_NOT_SUPP,
> +       PD_MSG_DATA_SINK_CAP,
> +       PD_MSG_DATA_SOURCE_CAP,
> +};
> +
> +struct tcpm_port {
> +       enum typec_port_type typec_type;
> +       int typec_prefer_role;
> +
> +       enum typec_role vconn_role;
> +       enum typec_role pwr_role;
> +       enum typec_data_role data_role;
> +
> +       struct typec_partner *partner;
> +
> +       enum typec_cc_status cc_req;
> +       enum typec_cc_status cc1;
> +       enum typec_cc_status cc2;
> +       enum typec_cc_polarity polarity;
> +
> +       bool attached;
> +       bool connected;
> +       int poll_event_cnt;
> +       enum typec_port_type port_type;
> +
> +       /*
> +        * Set to true when vbus is greater than VSAFE5V min.
> +        * Set to false when vbus falls below vSinkDisconnect max threshold.
> +        */
> +       bool vbus_present;
> +
> +       /*
> +        * Set to true when vbus is less than VSAFE0V max.
> +        * Set to false when vbus is greater than VSAFE0V max.
> +        */
> +       bool vbus_vsafe0v;
> +
> +       bool vbus_never_low;
> +       bool vbus_source;
> +       bool vbus_charge;
> +
> +       int try_role;
> +
> +       enum pd_msg_request queued_message;
> +
> +       enum tcpm_state enter_state;
> +       enum tcpm_state prev_state;
> +       enum tcpm_state state;
> +       enum tcpm_state delayed_state;
> +       unsigned long delay_ms;
> +
> +       bool state_machine_running;
> +
> +       bool tx_complete;
> +       enum tcpm_transmit_status tx_status;
> +
> +       unsigned int negotiated_rev;
> +       unsigned int message_id;
> +       unsigned int caps_count;
> +       unsigned int hard_reset_count;
> +       bool pd_capable;
> +       bool explicit_contract;
> +       unsigned int rx_msgid;
> +
> +       /* Partner capabilities/requests */
> +       u32 sink_request;
> +       u32 source_caps[PDO_MAX_OBJECTS];
> +       unsigned int nr_source_caps;
> +       u32 sink_caps[PDO_MAX_OBJECTS];
> +       unsigned int nr_sink_caps;
> +
> +       /*
> +        * whether to wait for the Type-C device to send the DR_SWAP Message flag
> +        * For Type-C device with Dual-Role Power and Dual-Role Data, the port side
> +        * is used as sink + ufp, then the tcpm framework needs to wait for Type-C
> +        * device to initiate DR_swap Message.
> +        */
> +       bool wait_dr_swap_message;
> +
> +       /* Local capabilities */
> +       u32 src_pdo[PDO_MAX_OBJECTS];
> +       unsigned int nr_src_pdo;
> +       u32 snk_pdo[PDO_MAX_OBJECTS];
> +       unsigned int nr_snk_pdo;
> +
> +       unsigned int operating_snk_mw;
> +       bool update_sink_caps;
> +
> +       /* Requested current / voltage to the port partner */
> +       u32 req_current_limit;
> +       u32 req_supply_voltage;
> +       /* Actual current / voltage limit of the local port */
> +       u32 current_limit;
> +       u32 supply_voltage;
> +
> +       /* port belongs to a self powered device */
> +       bool self_powered;
> +
> +       unsigned long delay_target;
> +};
> +
> +extern const char * const tcpm_states[];
> +
> +int tcpm_post_probe(struct udevice *dev);
> +
> +#endif
> diff --git a/drivers/usb/tcpm/tcpm-uclass.c b/drivers/usb/tcpm/tcpm-uclass.c
> new file mode 100644
> index 000000000000..92f9eff1ada6
> --- /dev/null
> +++ b/drivers/usb/tcpm/tcpm-uclass.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 Collabora Ltd.
> + *
> + * USB Power Delivery protocol stack.
> + */
> +
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/uclass.h>
> +#include <linux/err.h>
> +#include <usb/tcpm.h>
> +#include "tcpm-internal.h"
> +
> +int tcpm_get_voltage(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return port->supply_voltage;
> +}
> +
> +int tcpm_get_current(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return port->current_limit;
> +}
> +
> +enum typec_orientation tcpm_get_orientation(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       switch (port->polarity) {
> +       case TYPEC_POLARITY_CC1:
> +               return TYPEC_ORIENTATION_NORMAL;
> +       case TYPEC_POLARITY_CC2:
> +               return TYPEC_ORIENTATION_REVERSE;
> +       default:
> +               return TYPEC_ORIENTATION_NONE;
> +       }
> +}
> +
> +const char *tcpm_get_state(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return tcpm_states[port->state];
> +}
> +
> +int tcpm_get_pd_rev(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return port->negotiated_rev;
> +}
> +
> +enum typec_role tcpm_get_pwr_role(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return port->pwr_role;
> +}
> +
> +enum typec_data_role tcpm_get_data_role(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return port->data_role;
> +}
> +
> +bool tcpm_is_connected(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return port->connected;
> +}
> +
> +int tcpm_get(const char *name, struct udevice **devp)
> +{
> +       return uclass_get_device_by_name(UCLASS_TCPM, name, devp);
> +}
> +
> +static int tcpm_post_bind(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       const char *cap_str;
> +       ofnode node;
> +       int ret;
> +
> +       /*
> +        * USB Power Delivery (USB PD) specification requires, that communication
> +        * with a sink happens within roughly 5 seconds. Otherwise the source
> +        * might assume that the sink does not support USB PD. Starting to do
> +        * USB PD communication after that results in a hard reset, which briefly
> +        * removes any power from the USB-C port.
> +        *
> +        * On systems with alternative power supplies this is not an issue, but
> +        * systems, which get soleley powered through their USB-C port will end
> +        * up losing their power supply and doing a board level reset. The hard
> +        * reset will also restart the 5 second timeout. That means a operating
> +        * system initializing USB PD will put the system into a boot loop when
> +        * it takes more than 5 seconds from cold boot to the operating system
> +        * starting to transmit USB PD messages.
> +        *
> +        * The issue can be avoided by doing the initial USB PD communication
> +        * in U-Boot. The operating system can then re-negotiate by doing a
> +        * soft reset, which does not trigger removal of the supply voltage.
> +        *
> +        * Since the TCPM state machine is quite complex and depending on the
> +        * remote side can take quite some time to finish, this tries to limit
> +        * the automatic probing to systems probably relying on power being
> +        * provided by the USB-C port(s):
> +        *
> +        * 1. self-powered devices won't reset when the USB-C port looses power
> +        * 2. if the power is allowed to go into anything else than sink mode
> +        *    it is not the only power source
> +        */
> +       ret = drvops->get_connector_node(dev, &node);
> +       if (ret)
> +               return ret;
> +
> +       if (ofnode_read_bool(node, "self-powered"))
> +               return 0;
> +
> +       cap_str = ofnode_read_string(node, "power-role");
> +       if (!cap_str)
> +               return -EINVAL;
> +
> +       if (strcmp("sink", cap_str))
> +               return 0;
> +
> +       /* Do not auto-probe PD controller when PD is disabled */
> +       if (ofnode_read_bool(node, "pd-disable"))
> +               return 0;
> +
> +       dev_info(dev, "probing Type-C port manager...");
> +
> +       dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
> +       return 0;
> +}
> +
> +UCLASS_DRIVER(tcpm) = {
> +       .id             = UCLASS_TCPM,
> +       .name           = "tcpm",
> +       .per_device_plat_auto   = sizeof(struct tcpm_port),
> +       .post_bind      = tcpm_post_bind,
> +       .post_probe     = tcpm_post_probe,
> +};
> diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
> new file mode 100644
> index 000000000000..0aee57cb2f4a
> --- /dev/null
> +++ b/drivers/usb/tcpm/tcpm.c
> @@ -0,0 +1,2288 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2015-2017 Google, Inc
> + *
> + * USB Power Delivery protocol stack.
> + */
> +
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/device-internal.h>
> +#include <dm/devres.h>
> +#include <linux/compat.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <time.h>
> +#include <usb/tcpm.h>
> +#include "tcpm-internal.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +const char * const tcpm_states[] = {
> +       FOREACH_TCPM_STATE(GENERATE_TCPM_STRING)
> +};
> +
> +const char * const typec_pd_rev_name[] = {
> +       [PD_REV10]              = "rev1",
> +       [PD_REV20]              = "rev2",
> +       [PD_REV30]              = "rev3",
> +};
> +
> +const char * const typec_role_name[] = {
> +       [TYPEC_SINK]            = "sink",
> +       [TYPEC_SOURCE]          = "source",
> +};
> +
> +const char * const typec_data_role_name[] = {
> +       [TYPEC_DEVICE]          = "device",
> +       [TYPEC_HOST]            = "host",
> +};
> +
> +const char * const typec_orientation_name[] = {
> +       [TYPEC_ORIENTATION_NONE]        = "none",
> +       [TYPEC_ORIENTATION_NORMAL]      = "normal",
> +       [TYPEC_ORIENTATION_REVERSE]     = "reverse",
> +};
> +
> +const char * const typec_cc_status_name[] = {
> +       [TYPEC_CC_OPEN]         = "open",
> +       [TYPEC_CC_RA]           = "ra",
> +       [TYPEC_CC_RD]           = "rd",
> +       [TYPEC_CC_RP_DEF]       = "rp-def",
> +       [TYPEC_CC_RP_1_5]       = "rp-1.5",
> +       [TYPEC_CC_RP_3_0]       = "rp-3.0",
> +};
> +
> +static inline bool tcpm_cc_is_sink(enum typec_cc_status cc)
> +{
> +       return cc == TYPEC_CC_RP_DEF ||
> +              cc == TYPEC_CC_RP_1_5 ||
> +              cc == TYPEC_CC_RP_3_0;
> +}
> +
> +static inline bool tcpm_port_is_sink(struct tcpm_port *port)
> +{
> +       bool cc1_is_snk = tcpm_cc_is_sink(port->cc1);
> +       bool cc2_is_snk = tcpm_cc_is_sink(port->cc2);
> +
> +       return (cc1_is_snk && !cc2_is_snk) ||
> +              (cc2_is_snk && !cc1_is_snk);
> +}
> +
> +static inline bool tcpm_cc_is_source(enum typec_cc_status cc)
> +{
> +       return cc == TYPEC_CC_RD;
> +}
> +
> +static inline bool tcpm_port_is_source(struct tcpm_port *port)
> +{
> +       bool cc1_is_src = tcpm_cc_is_source(port->cc1);
> +       bool cc2_is_src = tcpm_cc_is_source(port->cc2);
> +
> +       return (cc1_is_src && !cc2_is_src) ||
> +              (cc2_is_src && !cc1_is_src);
> +}
> +
> +static inline bool tcpm_try_src(struct tcpm_port *port)
> +{
> +       return port->try_role == TYPEC_SOURCE &&
> +              port->port_type == TYPEC_PORT_DRP;
> +}
> +
> +static inline void tcpm_reset_event_cnt(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       port->poll_event_cnt = 0;
> +}
> +
> +static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
> +{
> +       if (port->port_type == TYPEC_PORT_DRP) {
> +               if (port->try_role == TYPEC_SINK)
> +                       return SNK_UNATTACHED;
> +               else if (port->try_role == TYPEC_SOURCE)
> +                       return SRC_UNATTACHED;
> +       } else if (port->port_type == TYPEC_PORT_SNK) {
> +               return SNK_UNATTACHED;
> +       }
> +       return SRC_UNATTACHED;
> +}
> +
> +static bool tcpm_port_is_disconnected(struct tcpm_port *port)
> +{
> +       return (!port->attached && port->cc1 == TYPEC_CC_OPEN &&
> +               port->cc2 == TYPEC_CC_OPEN) ||
> +              (port->attached && ((port->polarity == TYPEC_POLARITY_CC1 &&
> +                                   port->cc1 == TYPEC_CC_OPEN) ||
> +                                  (port->polarity == TYPEC_POLARITY_CC2 &&
> +                                   port->cc2 == TYPEC_CC_OPEN)));
> +}
> +
> +static void tcpm_set_cc(struct udevice *dev, enum typec_cc_status cc)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       dev_dbg(dev, "TCPM: set cc = %d\n", cc);
> +       port->cc_req = cc;
> +       drvops->set_cc(dev, cc);
> +}
> +
> +/*
> + * Determine RP value to set based on maximum current supported
> + * by a port if configured as source.
> + * Returns CC value to report to link partner.
> + */
> +static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
> +{
> +       const u32 *src_pdo = port->src_pdo;
> +       int nr_pdo = port->nr_src_pdo;
> +       int i;
> +
> +       /*
> +        * Search for first entry with matching voltage.
> +        * It should report the maximum supported current.
> +        */
> +       for (i = 0; i < nr_pdo; i++) {
> +               const u32 pdo = src_pdo[i];
> +
> +               if (pdo_type(pdo) == PDO_TYPE_FIXED &&
> +                   pdo_fixed_voltage(pdo) == 5000) {
> +                       unsigned int curr = pdo_max_current(pdo);
> +
> +                       if (curr >= 3000)
> +                               return TYPEC_CC_RP_3_0;
> +                       else if (curr >= 1500)
> +                               return TYPEC_CC_RP_1_5;
> +                       return TYPEC_CC_RP_DEF;
> +               }
> +       }
> +
> +       return TYPEC_CC_RP_DEF;
> +}
> +
> +static void tcpm_check_and_run_delayed_work(struct udevice *dev);
> +
> +static bool tcpm_transmit_helper(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       drvops->poll_event(dev);
> +       udelay(500);
> +       tcpm_check_and_run_delayed_work(dev);
> +       return port->tx_complete;
> +}
> +
> +static int tcpm_pd_transmit(struct udevice *dev,
> +                           enum tcpm_transmit_type type,
> +                           const struct pd_message *msg)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       u32 timeout_us = PD_T_TCPC_TX_TIMEOUT * 1000;
> +       bool tx_complete;
> +       int ret;
> +
> +       if (msg)
> +               dev_dbg(dev, "TCPM: PD TX, header: %#x\n",
> +                       le16_to_cpu(msg->header));
> +       else
> +               dev_dbg(dev, "TCPM: PD TX, type: %#x\n", type);
> +
> +       port->tx_complete = false;
> +       ret = drvops->pd_transmit(dev, type, msg, port->negotiated_rev);
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * At this point we basically need to block until the TCPM controller
> +        * returns successful transmission. Since this is usually done using
> +        * the generic interrupt status bits, we poll for any events. That
> +        * will clear the interrupt status, so we also need to process any
> +        * of the incoming events. This means we will do more processing and
> +        * thus let's give everything a bit more time.
> +        */
> +       timeout_us *= 5;
> +       ret = read_poll_timeout(tcpm_transmit_helper, tx_complete,
> +                               !tx_complete, false, timeout_us, dev);
> +       if (ret < 0) {
> +               dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       switch (port->tx_status) {
> +       case TCPC_TX_SUCCESS:
> +               port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
> +               break;
> +       case TCPC_TX_DISCARDED:
> +               ret = -EAGAIN;
> +               break;
> +       case TCPC_TX_FAILED:
> +       default:
> +               ret = -EIO;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +void tcpm_pd_transmit_complete(struct udevice *dev,
> +                              enum tcpm_transmit_status status)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       dev_dbg(dev, "TCPM: PD TX complete, status: %u\n", status);
> +       tcpm_reset_event_cnt(dev);
> +       port->tx_status = status;
> +       port->tx_complete = true;
> +}
> +
> +static int tcpm_set_polarity(struct udevice *dev,
> +                            enum typec_cc_polarity polarity)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       int ret;
> +
> +       dev_dbg(dev, "TCPM: set polarity = %d\n", polarity);
> +
> +       if (drvops->set_polarity) {
> +               ret = drvops->set_polarity(dev, polarity);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       port->polarity = polarity;
> +
> +       return 0;
> +}
> +
> +static int tcpm_set_vconn(struct udevice *dev, bool enable)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       dev_dbg(dev, "TCPM: set vconn = %d\n", enable);
> +
> +       ret = drvops->set_vconn(dev, enable);
> +       if (!ret)
> +               port->vconn_role = enable ? TYPEC_SOURCE : TYPEC_SINK;
> +
> +       return ret;
> +}
> +
> +static inline u32 tcpm_get_current_limit(struct tcpm_port *port)
> +{
> +       switch (port->polarity ? port->cc2 : port->cc1) {
> +       case TYPEC_CC_RP_1_5:
> +               return 1500;
> +       case TYPEC_CC_RP_3_0:
> +               return 3000;
> +       case TYPEC_CC_RP_DEF:
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static int tcpm_set_current_limit(struct udevice *dev, u32 max_ma, u32 mv)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret = -EOPNOTSUPP;
> +
> +       dev_info(dev, "TCPM: set voltage limit = %u mV\n", mv);
> +       dev_info(dev, "TCPM: set current limit = %u mA\n", max_ma);
> +
> +       port->supply_voltage = mv;
> +       port->current_limit = max_ma;
> +
> +       return ret;
> +}
> +
> +static int tcpm_set_attached_state(struct udevice *dev, bool attached)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       return drvops->set_roles(dev, attached, port->pwr_role,
> +                                port->data_role);
> +}
> +
> +static int tcpm_set_roles(struct udevice *dev, bool attached,
> +                         enum typec_role role, enum typec_data_role data)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       ret = drvops->set_roles(dev, attached, role, data);
> +       if (ret < 0)
> +               return ret;
> +
> +       port->pwr_role = role;
> +       port->data_role = data;
> +
> +       return 0;
> +}
> +
> +static int tcpm_pd_send_source_caps(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       struct pd_message msg;
> +       int i;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       if (!port->nr_src_pdo) {
> +               /* No source capabilities defined, sink only */
> +               msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
> +                                         port->pwr_role,
> +                                         port->data_role,
> +                                         port->negotiated_rev,
> +                                         port->message_id, 0);
> +       } else {
> +               msg.header = PD_HEADER_LE(PD_DATA_SOURCE_CAP,
> +                                         port->pwr_role,
> +                                         port->data_role,
> +                                         port->negotiated_rev,
> +                                         port->message_id,
> +                                         port->nr_src_pdo);
> +       }
> +
> +       for (i = 0; i < port->nr_src_pdo; i++)
> +               msg.payload[i] = cpu_to_le32(port->src_pdo[i]);
> +
> +       return tcpm_pd_transmit(dev, TCPC_TX_SOP, &msg);
> +}
> +
> +static int tcpm_pd_send_sink_caps(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       struct pd_message msg;
> +       unsigned int i;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       if (!port->nr_snk_pdo) {
> +               /* No sink capabilities defined, source only */
> +               msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
> +                                         port->pwr_role,
> +                                         port->data_role,
> +                                         port->negotiated_rev,
> +                                         port->message_id, 0);
> +       } else {
> +               msg.header = PD_HEADER_LE(PD_DATA_SINK_CAP,
> +                                         port->pwr_role,
> +                                         port->data_role,
> +                                         port->negotiated_rev,
> +                                         port->message_id,
> +                                         port->nr_snk_pdo);
> +       }
> +
> +       for (i = 0; i < port->nr_snk_pdo; i++)
> +               msg.payload[i] = cpu_to_le32(port->snk_pdo[i]);
> +
> +       return tcpm_pd_transmit(dev, TCPC_TX_SOP, &msg);
> +}
> +
> +static void tcpm_state_machine(struct udevice *dev);
> +
> +static inline void tcpm_timer_uninit(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       port->delay_target = 0;
> +}
> +
> +static void tcpm_timer_init(struct udevice *dev, uint32_t ms)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       unsigned long time_us = ms * 1000;
> +
> +       port->delay_target = timer_get_us() + time_us;
> +}
> +
> +static void tcpm_check_and_run_delayed_work(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       /* no delayed state changes scheduled */
> +       if (port->delay_target == 0)
> +               return;
> +
> +       /* it's not yet time */
> +       if (timer_get_us() < port->delay_target)
> +               return;
> +
> +       tcpm_timer_uninit(dev);
> +       tcpm_state_machine(dev);
> +}
> +
> +static void mod_tcpm_delayed_work(struct udevice *dev, unsigned int delay_ms)
> +{
> +       if (delay_ms) {
> +               tcpm_timer_init(dev, delay_ms);
> +       } else {
> +               tcpm_timer_uninit(dev);
> +               tcpm_state_machine(dev);
> +       }
> +}
> +
> +static void tcpm_set_state(struct udevice *dev, enum tcpm_state state,
> +                          unsigned int delay_ms)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       if (delay_ms) {
> +               dev_dbg(dev, "TCPM: pending state change %s -> %s @ %u ms [%s]\n",
> +                       tcpm_states[port->state], tcpm_states[state], delay_ms,
> +                       typec_pd_rev_name[port->negotiated_rev]);
> +               port->delayed_state = state;
> +               mod_tcpm_delayed_work(dev, delay_ms);
> +               port->delay_ms = delay_ms;
> +       } else {
> +               dev_dbg(dev, "TCPM: state change %s -> %s\n",
> +                       tcpm_states[port->state], tcpm_states[state]);
> +               port->delayed_state = INVALID_STATE;
> +               port->prev_state = port->state;
> +               port->state = state;
> +               /*
> +                * Don't re-queue the state machine work item if we're currently
> +                * in the state machine and we're immediately changing states.
> +                * tcpm_state_machine_work() will continue running the state
> +                * machine.
> +                */
> +               if (!port->state_machine_running)
> +                       mod_tcpm_delayed_work(dev, 0);
> +       }
> +}
> +
> +static void tcpm_set_state_cond(struct udevice *dev, enum tcpm_state state,
> +                               unsigned int delay_ms)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       if (port->enter_state == port->state)
> +               tcpm_set_state(dev, state, delay_ms);
> +       else
> +               dev_dbg(dev, "TCPM: skipped %sstate change %s -> %s [%u ms], context state %s [%s]\n",
> +                       delay_ms ? "delayed " : "",
> +                       tcpm_states[port->state], tcpm_states[state],
> +                       delay_ms, tcpm_states[port->enter_state],
> +                       typec_pd_rev_name[port->negotiated_rev]);
> +}
> +
> +static void tcpm_queue_message(struct udevice *dev,
> +                              enum pd_msg_request message)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       port->queued_message = message;
> +       mod_tcpm_delayed_work(dev, 0);
> +}
> +
> +enum pdo_err {
> +       PDO_NO_ERR,
> +       PDO_ERR_NO_VSAFE5V,
> +       PDO_ERR_VSAFE5V_NOT_FIRST,
> +       PDO_ERR_PDO_TYPE_NOT_IN_ORDER,
> +       PDO_ERR_FIXED_NOT_SORTED,
> +       PDO_ERR_VARIABLE_BATT_NOT_SORTED,
> +       PDO_ERR_DUPE_PDO,
> +       PDO_ERR_PPS_APDO_NOT_SORTED,
> +       PDO_ERR_DUPE_PPS_APDO,
> +};
> +
> +static const char * const pdo_err_msg[] = {
> +       [PDO_ERR_NO_VSAFE5V] =
> +       " err: source/sink caps should at least have vSafe5V",
> +       [PDO_ERR_VSAFE5V_NOT_FIRST] =
> +       " err: vSafe5V Fixed Supply Object Shall always be the first object",
> +       [PDO_ERR_PDO_TYPE_NOT_IN_ORDER] =
> +       " err: PDOs should be in the following order: Fixed; Battery; Variable",
> +       [PDO_ERR_FIXED_NOT_SORTED] =
> +       " err: Fixed supply pdos should be in increasing order of their fixed voltage",
> +       [PDO_ERR_VARIABLE_BATT_NOT_SORTED] =
> +       " err: Variable/Battery supply pdos should be in increasing order of their minimum voltage",
> +       [PDO_ERR_DUPE_PDO] =
> +       " err: Variable/Batt supply pdos cannot have same min/max voltage",
> +       [PDO_ERR_PPS_APDO_NOT_SORTED] =
> +       " err: Programmable power supply apdos should be in increasing order of their maximum voltage",
> +       [PDO_ERR_DUPE_PPS_APDO] =
> +       " err: Programmable power supply apdos cannot have same min/max voltage and max current",
> +};
> +
> +static enum pdo_err tcpm_caps_err(struct udevice *dev, const u32 *pdo,
> +                                 unsigned int nr_pdo)
> +{
> +       unsigned int i;
> +
> +       /* Should at least contain vSafe5v */
> +       if (nr_pdo < 1)
> +               return PDO_ERR_NO_VSAFE5V;
> +
> +       /* The vSafe5V Fixed Supply Object Shall always be the first object */
> +       if (pdo_type(pdo[0]) != PDO_TYPE_FIXED ||
> +           pdo_fixed_voltage(pdo[0]) != VSAFE5V)
> +               return PDO_ERR_VSAFE5V_NOT_FIRST;
> +
> +       for (i = 1; i < nr_pdo; i++) {
> +               if (pdo_type(pdo[i]) < pdo_type(pdo[i - 1])) {
> +                       return PDO_ERR_PDO_TYPE_NOT_IN_ORDER;
> +               } else if (pdo_type(pdo[i]) == pdo_type(pdo[i - 1])) {
> +                       enum pd_pdo_type type = pdo_type(pdo[i]);
> +
> +                       switch (type) {
> +                       /*
> +                        * The remaining Fixed Supply Objects, if
> +                        * present, shall be sent in voltage order;
> +                        * lowest to highest.
> +                        */
> +                       case PDO_TYPE_FIXED:
> +                               if (pdo_fixed_voltage(pdo[i]) <=
> +                                   pdo_fixed_voltage(pdo[i - 1]))
> +                                       return PDO_ERR_FIXED_NOT_SORTED;
> +                               break;
> +                       /*
> +                        * The Battery Supply Objects and Variable
> +                        * supply, if present shall be sent in Minimum
> +                        * Voltage order; lowest to highest.
> +                        */
> +                       case PDO_TYPE_VAR:
> +                       case PDO_TYPE_BATT:
> +                               if (pdo_min_voltage(pdo[i]) <
> +                                   pdo_min_voltage(pdo[i - 1]))
> +                                       return PDO_ERR_VARIABLE_BATT_NOT_SORTED;
> +                               else if ((pdo_min_voltage(pdo[i]) ==
> +                                         pdo_min_voltage(pdo[i - 1])) &&
> +                                        (pdo_max_voltage(pdo[i]) ==
> +                                         pdo_max_voltage(pdo[i - 1])))
> +                                       return PDO_ERR_DUPE_PDO;
> +                               break;
> +                       /*
> +                        * The Programmable Power Supply APDOs, if present,
> +                        * shall be sent in Maximum Voltage order;
> +                        * lowest to highest.
> +                        */
> +                       case PDO_TYPE_APDO:
> +                               if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
> +                                       break;
> +
> +                               if (pdo_pps_apdo_max_voltage(pdo[i]) <
> +                                   pdo_pps_apdo_max_voltage(pdo[i - 1]))
> +                                       return PDO_ERR_PPS_APDO_NOT_SORTED;
> +                               else if (pdo_pps_apdo_min_voltage(pdo[i]) ==
> +                                         pdo_pps_apdo_min_voltage(pdo[i - 1]) &&
> +                                        pdo_pps_apdo_max_voltage(pdo[i]) ==
> +                                         pdo_pps_apdo_max_voltage(pdo[i - 1]) &&
> +                                        pdo_pps_apdo_max_current(pdo[i]) ==
> +                                         pdo_pps_apdo_max_current(pdo[i - 1]))
> +                                       return PDO_ERR_DUPE_PPS_APDO;
> +                               break;
> +                       default:
> +                               dev_err(dev, "TCPM: Unknown pdo type\n");
> +                       }
> +               }
> +       }
> +
> +       return PDO_NO_ERR;
> +}
> +
> +static int tcpm_validate_caps(struct udevice *dev, const u32 *pdo,
> +                             unsigned int nr_pdo)
> +{
> +       enum pdo_err err_index = tcpm_caps_err(dev, pdo, nr_pdo);
> +
> +       if (err_index != PDO_NO_ERR) {
> +               dev_err(dev, "TCPM:%s\n", pdo_err_msg[err_index]);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * PD (data, control) command handling functions
> + */
> +static inline enum tcpm_state ready_state(struct tcpm_port *port)
> +{
> +       if (port->pwr_role == TYPEC_SOURCE)
> +               return SRC_READY;
> +       else
> +               return SNK_READY;
> +}
> +
> +static void tcpm_pd_data_request(struct udevice *dev,
> +                                const struct pd_message *msg)
> +{
> +       enum pd_data_msg_type type = pd_header_type_le(msg->header);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       unsigned int cnt = pd_header_cnt_le(msg->header);
> +       unsigned int rev = pd_header_rev_le(msg->header);
> +       unsigned int i;
> +
> +       switch (type) {
> +       case PD_DATA_SOURCE_CAP:
> +               for (i = 0; i < cnt; i++)
> +                       port->source_caps[i] = le32_to_cpu(msg->payload[i]);
> +
> +               port->nr_source_caps = cnt;
> +
> +               tcpm_validate_caps(dev, port->source_caps,
> +                                  port->nr_source_caps);
> +
> +               /*
> +                * Adjust revision in subsequent message headers, as required,
> +                * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
> +                * support Rev 1.0 so just do nothing in that scenario.
> +                */
> +               if (rev == PD_REV10)
> +                       break;
> +
> +               if (rev < PD_MAX_REV)
> +                       port->negotiated_rev = rev;
> +
> +               if ((pdo_type(port->source_caps[0]) == PDO_TYPE_FIXED) &&
> +                   (port->source_caps[0] & PDO_FIXED_DUAL_ROLE) &&
> +                   (port->source_caps[0] & PDO_FIXED_DATA_SWAP)) {
> +                       /* Dual role power and data, eg: self-powered Type-C */
> +                       port->wait_dr_swap_message = true;
> +               } else {
> +                       /* Non-Dual role power, eg: adapter */
> +                       port->wait_dr_swap_message = false;
> +               }
> +
> +               /*
> +                * This message may be received even if VBUS is not
> +                * present. This is quite unexpected; see USB PD
> +                * specification, sections 8.3.3.6.3.1 and 8.3.3.6.3.2.
> +                * However, at the same time, we must be ready to
> +                * receive this message and respond to it 15ms after
> +                * receiving PS_RDY during power swap operations, no matter
> +                * if VBUS is available or not (USB PD specification,
> +                * section 6.5.9.2).
> +                * So we need to accept the message either way,
> +                * but be prepared to keep waiting for VBUS after it was
> +                * handled.
> +                */
> +               tcpm_set_state(dev, SNK_NEGOTIATE_CAPABILITIES, 0);
> +               break;
> +       case PD_DATA_REQUEST:
> +               /*
> +                * Adjust revision in subsequent message headers, as required,
> +                * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
> +                * support Rev 1.0 so just reject in that scenario.
> +                */
> +               if (rev == PD_REV10) {
> +                       tcpm_queue_message(dev, PD_MSG_CTRL_REJECT);
> +                       break;
> +               }
> +
> +               if (rev < PD_MAX_REV)
> +                       port->negotiated_rev = rev;
> +
> +               port->sink_request = le32_to_cpu(msg->payload[0]);
> +
> +               tcpm_set_state(dev, SRC_NEGOTIATE_CAPABILITIES, 0);
> +               break;
> +       case PD_DATA_SINK_CAP:
> +               /* We don't do anything with this at the moment... */
> +               for (i = 0; i < cnt; i++)
> +                       port->sink_caps[i] = le32_to_cpu(msg->payload[i]);
> +
> +               port->nr_sink_caps = cnt;
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +static void tcpm_pd_ctrl_request(struct udevice *dev,
> +                                const struct pd_message *msg)
> +{
> +       enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       enum tcpm_state next_state;
> +
> +       switch (type) {
> +       case PD_CTRL_GOOD_CRC:
> +       case PD_CTRL_PING:
> +               break;
> +       case PD_CTRL_GET_SOURCE_CAP:
> +               switch (port->state) {
> +               case SRC_READY:
> +               case SNK_READY:
> +                       tcpm_queue_message(dev, PD_MSG_DATA_SOURCE_CAP);
> +                       break;
> +               default:
> +                       tcpm_queue_message(dev, PD_MSG_CTRL_REJECT);
> +                       break;
> +               }
> +               break;
> +       case PD_CTRL_GET_SINK_CAP:
> +               switch (port->state) {
> +               case SRC_READY:
> +               case SNK_READY:
> +                       tcpm_queue_message(dev, PD_MSG_DATA_SINK_CAP);
> +                       break;
> +               default:
> +                       tcpm_queue_message(dev, PD_MSG_CTRL_REJECT);
> +                       break;
> +               }
> +               break;
> +       case PD_CTRL_GOTO_MIN:
> +               break;
> +       case PD_CTRL_PS_RDY:
> +               switch (port->state) {
> +               case SNK_TRANSITION_SINK:
> +                       if (port->vbus_present) {
> +                               tcpm_set_current_limit(dev,
> +                                                      port->req_current_limit,
> +                                                      port->req_supply_voltage);
> +                               port->explicit_contract = true;
> +                               tcpm_set_state(dev, SNK_READY, 0);
> +                       } else {
> +                               /*
> +                                * Seen after power swap. Keep waiting for VBUS
> +                                * in a transitional state.
> +                                */
> +                               tcpm_set_state(dev,
> +                                              SNK_TRANSITION_SINK_VBUS, 0);
> +                       }
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       case PD_CTRL_REJECT:
> +       case PD_CTRL_WAIT:
> +       case PD_CTRL_NOT_SUPP:
> +               switch (port->state) {
> +               case SNK_NEGOTIATE_CAPABILITIES:
> +                       /* USB PD specification, Figure 8-43 */
> +                       if (port->explicit_contract)
> +                               next_state = SNK_READY;
> +                       else
> +                               next_state = SNK_WAIT_CAPABILITIES;
> +
> +                       tcpm_set_state(dev, next_state, 0);
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       case PD_CTRL_ACCEPT:
> +               switch (port->state) {
> +               case SNK_NEGOTIATE_CAPABILITIES:
> +                       tcpm_set_state(dev, SNK_TRANSITION_SINK, 0);
> +                       break;
> +               case SOFT_RESET_SEND:
> +                       port->message_id = 0;
> +                       port->rx_msgid = -1;
> +                       if (port->pwr_role == TYPEC_SOURCE)
> +                               next_state = SRC_SEND_CAPABILITIES;
> +                       else
> +                               next_state = SNK_WAIT_CAPABILITIES;
> +                       tcpm_set_state(dev, next_state, 0);
> +                       break;
> +               default:
> +                       break;
> +               }
> +               break;
> +       case PD_CTRL_SOFT_RESET:
> +               tcpm_set_state(dev, SOFT_RESET, 0);
> +               break;
> +       case PD_CTRL_DR_SWAP:
> +               if (port->port_type != TYPEC_PORT_DRP) {
> +                       tcpm_queue_message(dev, PD_MSG_CTRL_REJECT);
> +                       break;
> +               }
> +               /*
> +                * 6.3.9: If an alternate mode is active, a request to swap
> +                * alternate modes shall trigger a port reset.
> +                */
> +               switch (port->state) {
> +               case SRC_READY:
> +               case SNK_READY:
> +                       tcpm_set_state(dev, DR_SWAP_ACCEPT, 0);
> +                       break;
> +               default:
> +                       tcpm_queue_message(dev, PD_MSG_CTRL_WAIT);
> +                       break;
> +               }
> +               break;
> +       case PD_CTRL_PR_SWAP:
> +       case PD_CTRL_VCONN_SWAP:
> +       case PD_CTRL_GET_SOURCE_CAP_EXT:
> +       case PD_CTRL_GET_STATUS:
> +       case PD_CTRL_FR_SWAP:
> +       case PD_CTRL_GET_PPS_STATUS:
> +       case PD_CTRL_GET_COUNTRY_CODES:
> +               /* Currently not supported */
> +               dev_err(dev, "TCPM: Currently not supported type %#x\n", type);
> +               tcpm_queue_message(dev, PD_MSG_CTRL_NOT_SUPP);
> +               break;
> +       default:
> +               dev_err(dev, "TCPM: Unrecognized ctrl message type %#x\n", type);
> +               break;
> +       }
> +}
> +
> +static void tcpm_pd_rx_handler(struct udevice *dev,
> +                              const struct pd_message *msg)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       unsigned int cnt = pd_header_cnt_le(msg->header);
> +       bool remote_is_host, local_is_host;
> +
> +       dev_dbg(dev, "TCPM: PD RX, header: %#x [%d]\n",
> +               le16_to_cpu(msg->header), port->attached);
> +
> +       if (port->attached) {
> +               enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
> +               unsigned int msgid = pd_header_msgid_le(msg->header);
> +
> +               /*
> +                * USB PD standard, 6.6.1.2:
> +                * "... if MessageID value in a received Message is the
> +                * same as the stored value, the receiver shall return a
> +                * GoodCRC Message with that MessageID value and drop
> +                * the Message (this is a retry of an already received
> +                * Message). Note: this shall not apply to the Soft_Reset
> +                * Message which always has a MessageID value of zero."
> +                */
> +               if (msgid == port->rx_msgid && type != PD_CTRL_SOFT_RESET)
> +                       return;
> +               port->rx_msgid = msgid;
> +
> +               /*
> +                * If both ends believe to be DFP/host, we have a data role
> +                * mismatch.
> +                */
> +               remote_is_host = !!(le16_to_cpu(msg->header) & PD_HEADER_DATA_ROLE);
> +               local_is_host = port->data_role == TYPEC_HOST;
> +               if (remote_is_host == local_is_host) {
> +                       dev_err(dev, "TCPM: data role mismatch, initiating error recovery\n");
> +                       tcpm_set_state(dev, ERROR_RECOVERY, 0);
> +               } else {
> +                       if (cnt)
> +                               tcpm_pd_data_request(dev, msg);
> +                       else
> +                               tcpm_pd_ctrl_request(dev, msg);
> +               }
> +       }
> +}
> +
> +void tcpm_pd_receive(struct udevice *dev, const struct pd_message *msg)
> +{
> +       tcpm_reset_event_cnt(dev);
> +       tcpm_pd_rx_handler(dev, msg);
> +}
> +
> +static int tcpm_pd_send_control(struct udevice *dev,
> +                               enum pd_ctrl_msg_type type)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       struct pd_message msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.header = PD_HEADER_LE(type, port->pwr_role,
> +                                 port->data_role,
> +                                 port->negotiated_rev,
> +                                 port->message_id, 0);
> +
> +       return tcpm_pd_transmit(dev, TCPC_TX_SOP, &msg);
> +}
> +
> +/*
> + * Send queued message without affecting state.
> + * Return true if state machine should go back to sleep,
> + * false otherwise.
> + */
> +static bool tcpm_send_queued_message(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       enum pd_msg_request queued_message;
> +       int max_messages = 100;
> +
> +       do {
> +               queued_message = port->queued_message;
> +               port->queued_message = PD_MSG_NONE;
> +               max_messages--;
> +
> +               switch (queued_message) {
> +               case PD_MSG_CTRL_WAIT:
> +                       tcpm_pd_send_control(dev, PD_CTRL_WAIT);
> +                       break;
> +               case PD_MSG_CTRL_REJECT:
> +                       tcpm_pd_send_control(dev, PD_CTRL_REJECT);
> +                       break;
> +               case PD_MSG_CTRL_NOT_SUPP:
> +                       tcpm_pd_send_control(dev, PD_CTRL_NOT_SUPP);
> +                       break;
> +               case PD_MSG_DATA_SINK_CAP:
> +                       tcpm_pd_send_sink_caps(dev);
> +                       break;
> +               case PD_MSG_DATA_SOURCE_CAP:
> +                       tcpm_pd_send_source_caps(dev);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       } while (max_messages > 0 && port->queued_message != PD_MSG_NONE);
> +
> +       if (!max_messages)
> +               dev_err(dev, "Aborted sending of too many queued messages\n");
> +
> +       return false;
> +}
> +
> +static int tcpm_pd_check_request(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       u32 pdo, rdo = port->sink_request;
> +       unsigned int max, op, pdo_max, index;
> +       enum pd_pdo_type type;
> +
> +       index = rdo_index(rdo);
> +       if (!index || index > port->nr_src_pdo)
> +               return -EINVAL;
> +
> +       pdo = port->src_pdo[index - 1];
> +       type = pdo_type(pdo);
> +       switch (type) {
> +       case PDO_TYPE_FIXED:
> +       case PDO_TYPE_VAR:
> +               max = rdo_max_current(rdo);
> +               op = rdo_op_current(rdo);
> +               pdo_max = pdo_max_current(pdo);
> +
> +               if (op > pdo_max)
> +                       return -EINVAL;
> +               if (max > pdo_max && !(rdo & RDO_CAP_MISMATCH))
> +                       return -EINVAL;
> +
> +               if (type == PDO_TYPE_FIXED)
> +                       dev_dbg(dev, "TCPM: Requested %u mV, %u mA for %u / %u mA\n",
> +                               pdo_fixed_voltage(pdo), pdo_max, op, max);
> +               else
> +                       dev_dbg(dev, "TCPM: Requested %u -> %u mV, %u mA for %u / %u mA\n",
> +                               pdo_min_voltage(pdo), pdo_max_voltage(pdo),
> +                               pdo_max, op, max);
> +               break;
> +       case PDO_TYPE_BATT:
> +               max = rdo_max_power(rdo);
> +               op = rdo_op_power(rdo);
> +               pdo_max = pdo_max_power(pdo);
> +
> +               if (op > pdo_max)
> +                       return -EINVAL;
> +               if (max > pdo_max && !(rdo & RDO_CAP_MISMATCH))
> +                       return -EINVAL;
> +               dev_info(dev, "TCPM: Requested %u -> %u mV, %u mW for %u / %u mW\n",
> +                        pdo_min_voltage(pdo), pdo_max_voltage(pdo),
> +                        pdo_max, op, max);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +#define min_power(x, y) min(pdo_max_power(x), pdo_max_power(y))
> +#define min_current(x, y) min(pdo_max_current(x), pdo_max_current(y))
> +
> +static int tcpm_pd_select_pdo(struct udevice *dev, int *sink_pdo,
> +                             int *src_pdo)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       unsigned int i, j, max_src_mv = 0, min_src_mv = 0, max_mw = 0,
> +                    max_mv = 0, src_mw = 0, src_ma = 0, max_snk_mv = 0,
> +                    min_snk_mv = 0;
> +       int ret = -EINVAL;
> +
> +       /*
> +        * Select the source PDO providing the most power which has a
> +        * matchig sink cap.
> +        */
> +       for (i = 0; i < port->nr_source_caps; i++) {
> +               u32 pdo = port->source_caps[i];
> +               enum pd_pdo_type type = pdo_type(pdo);
> +
> +               switch (type) {
> +               case PDO_TYPE_FIXED:
> +                       max_src_mv = pdo_fixed_voltage(pdo);
> +                       min_src_mv = max_src_mv;
> +                       break;
> +               case PDO_TYPE_BATT:
> +               case PDO_TYPE_VAR:
> +                       max_src_mv = pdo_max_voltage(pdo);
> +                       min_src_mv = pdo_min_voltage(pdo);
> +                       break;
> +               case PDO_TYPE_APDO:
> +                       continue;
> +               default:
> +                       dev_err(dev, "TCPM: Invalid source PDO type, ignoring\n");
> +                       continue;
> +               }
> +
> +               switch (type) {
> +               case PDO_TYPE_FIXED:
> +               case PDO_TYPE_VAR:
> +                       src_ma = pdo_max_current(pdo);
> +                       src_mw = src_ma * min_src_mv / 1000;
> +                       break;
> +               case PDO_TYPE_BATT:
> +                       src_mw = pdo_max_power(pdo);
> +                       break;
> +               case PDO_TYPE_APDO:
> +                       continue;
> +               default:
> +                       dev_err(dev, "TCPM: Invalid source PDO type, ignoring\n");
> +                       continue;
> +               }
> +
> +               for (j = 0; j < port->nr_snk_pdo; j++) {
> +                       pdo = port->snk_pdo[j];
> +
> +                       switch (pdo_type(pdo)) {
> +                       case PDO_TYPE_FIXED:
> +                               max_snk_mv = pdo_fixed_voltage(pdo);
> +                               min_snk_mv = max_snk_mv;
> +                               break;
> +                       case PDO_TYPE_BATT:
> +                       case PDO_TYPE_VAR:
> +                               max_snk_mv = pdo_max_voltage(pdo);
> +                               min_snk_mv = pdo_min_voltage(pdo);
> +                               break;
> +                       case PDO_TYPE_APDO:
> +                               continue;
> +                       default:
> +                               dev_err(dev, "TCPM: Invalid sink PDO type, ignoring\n");
> +                               continue;
> +                       }
> +
> +                       if (max_src_mv <= max_snk_mv && min_src_mv >= min_snk_mv) {
> +                               /* Prefer higher voltages if available */
> +                               if ((src_mw == max_mw && min_src_mv > max_mv) ||
> +                                   src_mw > max_mw) {
> +                                       *src_pdo = i;
> +                                       *sink_pdo = j;
> +                                       max_mw = src_mw;
> +                                       max_mv = min_src_mv;
> +                                       ret = 0;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int tcpm_pd_build_request(struct udevice *dev, u32 *rdo)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       unsigned int mv, ma, mw, flags;
> +       unsigned int max_ma, max_mw;
> +       enum pd_pdo_type type;
> +       u32 pdo, matching_snk_pdo;
> +       int src_pdo_index = 0;
> +       int snk_pdo_index = 0;
> +       int ret;
> +
> +       ret = tcpm_pd_select_pdo(dev, &snk_pdo_index, &src_pdo_index);
> +       if (ret < 0)
> +               return ret;
> +
> +       pdo = port->source_caps[src_pdo_index];
> +       matching_snk_pdo = port->snk_pdo[snk_pdo_index];
> +       type = pdo_type(pdo);
> +
> +       switch (type) {
> +       case PDO_TYPE_FIXED:
> +               mv = pdo_fixed_voltage(pdo);
> +               break;
> +       case PDO_TYPE_BATT:
> +       case PDO_TYPE_VAR:
> +               mv = pdo_min_voltage(pdo);
> +               break;
> +       default:
> +               dev_err(dev, "TCPM: Invalid PDO selected!\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Select maximum available current within the sink pdo's limit */
> +       if (type == PDO_TYPE_BATT) {
> +               mw = min_power(pdo, matching_snk_pdo);
> +               ma = 1000 * mw / mv;
> +       } else {
> +               ma = min_current(pdo, matching_snk_pdo);
> +               mw = ma * mv / 1000;
> +       }
> +
> +       flags = RDO_USB_COMM | RDO_NO_SUSPEND;
> +
> +       /* Set mismatch bit if offered power is less than operating power */
> +       max_ma = ma;
> +       max_mw = mw;
> +       if (mw < port->operating_snk_mw) {
> +               flags |= RDO_CAP_MISMATCH;
> +               if (type == PDO_TYPE_BATT &&
> +                   (pdo_max_power(matching_snk_pdo) > pdo_max_power(pdo)))
> +                       max_mw = pdo_max_power(matching_snk_pdo);
> +               else if (pdo_max_current(matching_snk_pdo) >
> +                        pdo_max_current(pdo))
> +                       max_ma = pdo_max_current(matching_snk_pdo);
> +       }
> +
> +       dev_dbg(dev, "TCPM: cc=%d cc1=%d cc2=%d vbus=%d vconn=%s polarity=%d\n",
> +               port->cc_req, port->cc1, port->cc2, port->vbus_source,
> +               port->vconn_role == TYPEC_SOURCE ? "source" : "sink",
> +               port->polarity);
> +
> +       if (type == PDO_TYPE_BATT) {
> +               *rdo = RDO_BATT(src_pdo_index + 1, mw, max_mw, flags);
> +
> +               dev_info(dev, "TCPM: requesting PDO %d: %u mV, %u mW%s\n",
> +                        src_pdo_index, mv, mw,
> +                        flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
> +       } else {
> +               *rdo = RDO_FIXED(src_pdo_index + 1, ma, max_ma, flags);
> +
> +               dev_info(dev, "TCPM: requesting PDO %d: %u mV, %u mA%s\n",
> +                        src_pdo_index, mv, ma,
> +                        flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
> +       }
> +
> +       port->req_current_limit = ma;
> +       port->req_supply_voltage = mv;
> +
> +       return 0;
> +}
> +
> +static int tcpm_pd_send_request(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       struct pd_message msg;
> +       int ret;
> +       u32 rdo;
> +
> +       ret = tcpm_pd_build_request(dev, &rdo);
> +       if (ret < 0)
> +               return ret;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
> +                                 port->pwr_role,
> +                                 port->data_role,
> +                                 port->negotiated_rev,
> +                                 port->message_id, 1);
> +       msg.payload[0] = cpu_to_le32(rdo);
> +
> +       return tcpm_pd_transmit(dev, TCPC_TX_SOP, &msg);
> +}
> +
> +static int tcpm_set_vbus(struct udevice *dev, bool enable)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       int ret;
> +
> +       if (enable && port->vbus_charge)
> +               return -EINVAL;
> +
> +       dev_dbg(dev, "TCPM: set vbus = %d charge = %d\n",
> +               enable, port->vbus_charge);
> +
> +       ret = drvops->set_vbus(dev, enable, port->vbus_charge);
> +       if (ret < 0)
> +               return ret;
> +
> +       port->vbus_source = enable;
> +       return 0;
> +}
> +
> +static int tcpm_set_charge(struct udevice *dev, bool charge)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       if (charge && port->vbus_source)
> +               return -EINVAL;
> +
> +       if (charge != port->vbus_charge) {
> +               dev_dbg(dev, "TCPM: set vbus = %d charge = %d\n",
> +                       port->vbus_source, charge);
> +               ret = drvops->set_vbus(dev, port->vbus_source,
> +                                          charge);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +       port->vbus_charge = charge;
> +       return 0;
> +}
> +
> +static bool tcpm_start_toggling(struct udevice *dev, enum typec_cc_status cc)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       if (!drvops->start_toggling)
> +               return false;
> +
> +       dev_dbg(dev, "TCPM: Start toggling\n");
> +       ret = drvops->start_toggling(dev, port->port_type, cc);
> +       return ret == 0;
> +}
> +
> +static int tcpm_init_vbus(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       ret = drvops->set_vbus(dev, false, false);
> +       port->vbus_source = false;
> +       port->vbus_charge = false;
> +       return ret;
> +}
> +
> +static int tcpm_init_vconn(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       ret = drvops->set_vconn(dev, false);
> +       port->vconn_role = TYPEC_SINK;
> +       return ret;
> +}
> +
> +static inline void tcpm_typec_connect(struct tcpm_port *port)
> +{
> +       if (!port->connected)
> +               port->connected = true;
> +}
> +
> +static int tcpm_src_attach(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       enum typec_cc_polarity polarity =
> +                               port->cc2 == TYPEC_CC_RD ? TYPEC_POLARITY_CC2
> +                                                        : TYPEC_POLARITY_CC1;
> +       int ret;
> +
> +       if (port->attached)
> +               return 0;
> +
> +       ret = tcpm_set_polarity(dev, polarity);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = tcpm_set_roles(dev, true, TYPEC_SOURCE, TYPEC_HOST);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = drvops->set_pd_rx(dev, true);
> +       if (ret < 0)
> +               goto out_disable_mux;
> +
> +       /*
> +        * USB Type-C specification, version 1.2,
> +        * chapter 4.5.2.2.8.1 (Attached.SRC Requirements)
> +        * Enable VCONN only if the non-RD port is set to RA.
> +        */
> +       if ((polarity == TYPEC_POLARITY_CC1 && port->cc2 == TYPEC_CC_RA) ||
> +           (polarity == TYPEC_POLARITY_CC2 && port->cc1 == TYPEC_CC_RA)) {
> +               ret = tcpm_set_vconn(dev, true);
> +               if (ret < 0)
> +                       goto out_disable_pd;
> +       }
> +
> +       ret = tcpm_set_vbus(dev, true);
> +       if (ret < 0)
> +               goto out_disable_vconn;
> +
> +       port->pd_capable = false;
> +
> +       port->partner = NULL;
> +
> +       port->attached = true;
> +
> +       return 0;
> +
> +out_disable_vconn:
> +       tcpm_set_vconn(dev, false);
> +out_disable_pd:
> +       drvops->set_pd_rx(dev, false);
> +out_disable_mux:
> +       dev_err(dev, "TCPM: CC connected in %s as DFP\n",
> +               polarity ? "CC2" : "CC1");
> +       return 0;
> +}
> +
> +static inline void tcpm_typec_disconnect(struct tcpm_port *port)
> +{
> +       if (port->connected) {
> +               port->partner = NULL;
> +               port->connected = false;
> +       }
> +}
> +
> +static void tcpm_reset_port(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       tcpm_timer_uninit(dev);
> +       tcpm_typec_disconnect(port);
> +       tcpm_reset_event_cnt(dev);
> +       port->wait_dr_swap_message = false;
> +       port->attached = false;
> +       port->pd_capable = false;
> +
> +       /*
> +        * First Rx ID should be 0; set this to a sentinel of -1 so that
> +        * we can check tcpm_pd_rx_handler() if we had seen it before.
> +        */
> +       port->rx_msgid = -1;
> +
> +       drvops->set_pd_rx(dev, false);
> +       tcpm_init_vbus(dev);    /* also disables charging */
> +       tcpm_init_vconn(dev);
> +       tcpm_set_current_limit(dev, 0, 0);
> +       tcpm_set_polarity(dev, TYPEC_POLARITY_CC1);
> +       tcpm_set_attached_state(dev, false);
> +       port->nr_sink_caps = 0;
> +}
> +
> +static void tcpm_detach(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       if (tcpm_port_is_disconnected(port))
> +               port->hard_reset_count = 0;
> +
> +       if (!port->attached)
> +               return;
> +
> +       tcpm_reset_port(dev);
> +}
> +
> +static void tcpm_src_detach(struct udevice *dev)
> +{
> +       tcpm_detach(dev);
> +}
> +
> +static int tcpm_snk_attach(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       if (port->attached)
> +               return 0;
> +
> +       ret = tcpm_set_polarity(dev, port->cc2 != TYPEC_CC_OPEN ?
> +                               TYPEC_POLARITY_CC2 : TYPEC_POLARITY_CC1);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = tcpm_set_roles(dev, true, TYPEC_SINK, TYPEC_DEVICE);
> +       if (ret < 0)
> +               return ret;
> +
> +       port->pd_capable = false;
> +
> +       port->partner = NULL;
> +
> +       port->attached = true;
> +       dev_info(dev, "TCPM: CC connected in %s as UFP\n",
> +                port->cc1 != TYPEC_CC_OPEN ? "CC1" : "CC2");
> +
> +       return 0;
> +}
> +
> +static void tcpm_snk_detach(struct udevice *dev)
> +{
> +       tcpm_detach(dev);
> +}
> +
> +static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
> +{
> +       if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)
> +               return HARD_RESET_SEND;
> +       if (port->pd_capable)
> +               return ERROR_RECOVERY;
> +       if (port->pwr_role == TYPEC_SOURCE)
> +               return SRC_UNATTACHED;
> +       if (port->state == SNK_WAIT_CAPABILITIES)
> +               return SNK_READY;
> +       return SNK_UNATTACHED;
> +}
> +
> +static inline enum tcpm_state unattached_state(struct tcpm_port *port)
> +{
> +       if (port->port_type == TYPEC_PORT_DRP) {
> +               if (port->pwr_role == TYPEC_SOURCE)
> +                       return SRC_UNATTACHED;
> +               else
> +                       return SNK_UNATTACHED;
> +       } else if (port->port_type == TYPEC_PORT_SRC) {
> +               return SRC_UNATTACHED;
> +       }
> +
> +       return SNK_UNATTACHED;
> +}
> +
> +static void run_state_machine(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int ret;
> +
> +       port->enter_state = port->state;
> +       switch (port->state) {
> +       case TOGGLING:
> +               break;
> +       /* SRC states */
> +       case SRC_UNATTACHED:
> +               tcpm_src_detach(dev);
> +               if (tcpm_start_toggling(dev, tcpm_rp_cc(port))) {
> +                       tcpm_set_state(dev, TOGGLING, 0);
> +                       break;
> +               }
> +               tcpm_set_cc(dev, tcpm_rp_cc(port));
> +               if (port->port_type == TYPEC_PORT_DRP)
> +                       tcpm_set_state(dev, SNK_UNATTACHED, PD_T_DRP_SNK);
> +               break;
> +       case SRC_ATTACH_WAIT:
> +               if (tcpm_port_is_source(port))
> +                       tcpm_set_state(dev, SRC_ATTACHED, PD_T_CC_DEBOUNCE);
> +               break;
> +
> +       case SRC_ATTACHED:
> +               ret = tcpm_src_attach(dev);
> +               /*
> +                * Currently, vbus control is not implemented,
> +                * and the SRC detection process cannot be fully implemented.
> +                */
> +               tcpm_set_state(dev, SRC_READY, 0);
> +               break;
> +       case SRC_STARTUP:
> +               port->caps_count = 0;
> +               port->negotiated_rev = PD_MAX_REV;
> +               port->message_id = 0;
> +               port->rx_msgid = -1;
> +               port->explicit_contract = false;
> +               tcpm_set_state(dev, SRC_SEND_CAPABILITIES, 0);
> +               break;
> +       case SRC_SEND_CAPABILITIES:
> +               port->caps_count++;
> +               if (port->caps_count > PD_N_CAPS_COUNT) {
> +                       tcpm_set_state(dev, SRC_READY, 0);
> +                       break;
> +               }
> +               ret = tcpm_pd_send_source_caps(dev);
> +               if (ret < 0) {
> +                       tcpm_set_state(dev, SRC_SEND_CAPABILITIES,
> +                                      PD_T_SEND_SOURCE_CAP);
> +               } else {
> +                       /*
> +                        * Per standard, we should clear the reset counter here.
> +                        * However, that can result in state machine hang-ups.
> +                        * Reset it only in READY state to improve stability.
> +                        */
> +                       /* port->hard_reset_count = 0; */
> +                       port->caps_count = 0;
> +                       port->pd_capable = true;
> +                       tcpm_set_state_cond(dev, SRC_SEND_CAPABILITIES_TIMEOUT,
> +                                           PD_T_SEND_SOURCE_CAP);
> +               }
> +               break;
> +       case SRC_SEND_CAPABILITIES_TIMEOUT:
> +               /*
> +                * Error recovery for a PD_DATA_SOURCE_CAP reply timeout.
> +                *
> +                * PD 2.0 sinks are supposed to accept src-capabilities with a
> +                * 3.0 header and simply ignore any src PDOs which the sink does
> +                * not understand such as PPS but some 2.0 sinks instead ignore
> +                * the entire PD_DATA_SOURCE_CAP message, causing contract
> +                * negotiation to fail.
> +                *
> +                * After PD_N_HARD_RESET_COUNT hard-reset attempts, we try
> +                * sending src-capabilities with a lower PD revision to
> +                * make these broken sinks work.
> +                */
> +               if (port->hard_reset_count < PD_N_HARD_RESET_COUNT) {
> +                       tcpm_set_state(dev, HARD_RESET_SEND, 0);
> +               } else if (port->negotiated_rev > PD_REV20) {
> +                       port->negotiated_rev--;
> +                       port->hard_reset_count = 0;
> +                       tcpm_set_state(dev, SRC_SEND_CAPABILITIES, 0);
> +               } else {
> +                       tcpm_set_state(dev, hard_reset_state(port), 0);
> +               }
> +               break;
> +       case SRC_NEGOTIATE_CAPABILITIES:
> +               ret = tcpm_pd_check_request(dev);
> +               if (ret < 0) {
> +                       tcpm_pd_send_control(dev, PD_CTRL_REJECT);
> +                       if (!port->explicit_contract) {
> +                               tcpm_set_state(dev,
> +                                              SRC_WAIT_NEW_CAPABILITIES, 0);
> +                       } else {
> +                               tcpm_set_state(dev, SRC_READY, 0);
> +                       }
> +               } else {
> +                       tcpm_pd_send_control(dev, PD_CTRL_ACCEPT);
> +                       tcpm_set_state(dev, SRC_TRANSITION_SUPPLY,
> +                                      PD_T_SRC_TRANSITION);
> +               }
> +               break;
> +       case SRC_TRANSITION_SUPPLY:
> +               /* XXX: regulator_set_voltage(vbus, ...) */
> +               tcpm_pd_send_control(dev, PD_CTRL_PS_RDY);
> +               port->explicit_contract = true;
> +               tcpm_set_state_cond(dev, SRC_READY, 0);
> +               break;
> +       case SRC_READY:
> +               port->hard_reset_count = 0;
> +
> +               tcpm_typec_connect(port);
> +               break;
> +       case SRC_WAIT_NEW_CAPABILITIES:
> +               /* Nothing to do... */
> +               break;
> +
> +       /* SNK states */
> +       case SNK_UNATTACHED:
> +               tcpm_snk_detach(dev);
> +               if (tcpm_start_toggling(dev, TYPEC_CC_RD)) {
> +                       tcpm_set_state(dev, TOGGLING, 0);
> +                       break;
> +               }
> +               tcpm_set_cc(dev, TYPEC_CC_RD);
> +               if (port->port_type == TYPEC_PORT_DRP)
> +                       tcpm_set_state(dev, SRC_UNATTACHED, PD_T_DRP_SRC);
> +               break;
> +       case SNK_ATTACH_WAIT:
> +               if ((port->cc1 == TYPEC_CC_OPEN &&
> +                    port->cc2 != TYPEC_CC_OPEN) ||
> +                   (port->cc1 != TYPEC_CC_OPEN &&
> +                    port->cc2 == TYPEC_CC_OPEN))
> +                       tcpm_set_state(dev, SNK_DEBOUNCED,
> +                                      PD_T_CC_DEBOUNCE);
> +               else if (tcpm_port_is_disconnected(port))
> +                       tcpm_set_state(dev, SNK_UNATTACHED,
> +                                      PD_T_CC_DEBOUNCE);
> +               break;
> +       case SNK_DEBOUNCED:
> +               if (tcpm_port_is_disconnected(port))
> +                       tcpm_set_state(dev, SNK_UNATTACHED, PD_T_PD_DEBOUNCE);
> +               else if (port->vbus_present)
> +                       tcpm_set_state(dev, SNK_ATTACHED, 0);
> +               else
> +                       /* Wait for VBUS, but not forever */
> +                       tcpm_set_state(dev, PORT_RESET, PD_T_PS_SOURCE_ON);
> +               break;
> +       case SNK_ATTACHED:
> +               ret = tcpm_snk_attach(dev);
> +               if (ret < 0)
> +                       tcpm_set_state(dev, SNK_UNATTACHED, 0);
> +               else
> +                       tcpm_set_state(dev, SNK_STARTUP, 0);
> +               break;
> +       case SNK_STARTUP:
> +               port->negotiated_rev = PD_MAX_REV;
> +               port->message_id = 0;
> +               port->rx_msgid = -1;
> +               port->explicit_contract = false;
> +               tcpm_set_state(dev, SNK_DISCOVERY, 0);
> +               break;
> +       case SNK_DISCOVERY:
> +               if (port->vbus_present) {
> +                       tcpm_set_current_limit(dev,
> +                                              tcpm_get_current_limit(port),
> +                                              5000);
> +                       tcpm_set_charge(dev, true);
> +                       tcpm_set_state(dev, SNK_WAIT_CAPABILITIES, 0);
> +                       break;
> +               }
> +               /*
> +                * For DRP, timeouts differ. Also, handling is supposed to be
> +                * different and much more complex (dead battery detection;
> +                * see USB power delivery specification, section 8.3.3.6.1.5.1).
> +                */
> +               tcpm_set_state(dev, hard_reset_state(port),
> +                              port->port_type == TYPEC_PORT_DRP ?
> +                                       PD_T_DB_DETECT : PD_T_NO_RESPONSE);
> +               break;
> +       case SNK_DISCOVERY_DEBOUNCE:
> +               tcpm_set_state(dev, SNK_DISCOVERY_DEBOUNCE_DONE,
> +                              PD_T_CC_DEBOUNCE);
> +               break;
> +       case SNK_DISCOVERY_DEBOUNCE_DONE:
> +               tcpm_set_state(dev, unattached_state(port), 0);
> +               break;
> +       case SNK_WAIT_CAPABILITIES:
> +               ret = drvops->set_pd_rx(dev, true);
> +               if (ret < 0) {
> +                       tcpm_set_state(dev, SNK_READY, 0);
> +                       break;
> +               }
> +               /*
> +                * If VBUS has never been low, and we time out waiting
> +                * for source cap, try a soft reset first, in case we
> +                * were already in a stable contract before this boot.
> +                * Do this only once.
> +                */
> +               if (port->vbus_never_low) {
> +                       port->vbus_never_low = false;
> +                       tcpm_set_state(dev, SOFT_RESET_SEND,
> +                                      PD_T_SINK_WAIT_CAP);
> +               } else {
> +                       tcpm_set_state(dev, hard_reset_state(port),
> +                                      PD_T_SINK_WAIT_CAP);
> +               }
> +               break;
> +       case SNK_NEGOTIATE_CAPABILITIES:
> +               port->pd_capable = true;
> +               port->hard_reset_count = 0;
> +               ret = tcpm_pd_send_request(dev);
> +               if (ret < 0) {
> +                       /* Let the Source send capabilities again. */
> +                       tcpm_set_state(dev, SNK_WAIT_CAPABILITIES, 0);
> +               } else {
> +                       tcpm_set_state_cond(dev, hard_reset_state(port),
> +                                           PD_T_SENDER_RESPONSE);
> +               }
> +               break;
> +       case SNK_TRANSITION_SINK:
> +       case SNK_TRANSITION_SINK_VBUS:
> +               tcpm_set_state(dev, hard_reset_state(port),
> +                              PD_T_PS_TRANSITION);
> +               break;
> +       case SNK_READY:
> +               port->update_sink_caps = false;
> +               tcpm_typec_connect(port);
> +               /*
> +                * Here poll_event_cnt is cleared, waiting for self-powered Type-C devices
> +                * to send DR_swap Messge until 1s (TCPM_POLL_EVENT_TIME_OUT * 500us)timeout
> +                */
> +               if (port->wait_dr_swap_message)
> +                       tcpm_reset_event_cnt(dev);
> +
> +               break;
> +
> +       /* Hard_Reset states */
> +       case HARD_RESET_SEND:
> +               tcpm_pd_transmit(dev, TCPC_TX_HARD_RESET, NULL);
> +               tcpm_set_state(dev, HARD_RESET_START, 0);
> +               port->wait_dr_swap_message = false;
> +               break;
> +       case HARD_RESET_START:
> +               port->hard_reset_count++;
> +               drvops->set_pd_rx(dev, false);
> +               port->nr_sink_caps = 0;
> +               if (port->pwr_role == TYPEC_SOURCE)
> +                       tcpm_set_state(dev, SRC_HARD_RESET_VBUS_OFF,
> +                                      PD_T_PS_HARD_RESET);
> +               else
> +                       tcpm_set_state(dev, SNK_HARD_RESET_SINK_OFF, 0);
> +               break;
> +       case SRC_HARD_RESET_VBUS_OFF:
> +               tcpm_set_vconn(dev, true);
> +               tcpm_set_vbus(dev, false);
> +               tcpm_set_roles(dev, port->self_powered, TYPEC_SOURCE,
> +                              TYPEC_HOST);
> +               tcpm_set_state(dev, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
> +               break;
> +       case SRC_HARD_RESET_VBUS_ON:
> +               tcpm_set_vconn(dev, true);
> +               tcpm_set_vbus(dev, true);
> +               drvops->set_pd_rx(dev, true);
> +               tcpm_set_attached_state(dev, true);
> +               tcpm_set_state(dev, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
> +               break;
> +       case SNK_HARD_RESET_SINK_OFF:
> +               tcpm_set_vconn(dev, false);
> +               if (port->pd_capable)
> +                       tcpm_set_charge(dev, false);
> +               tcpm_set_roles(dev, port->self_powered, TYPEC_SINK,
> +                              TYPEC_DEVICE);
> +               /*
> +                * VBUS may or may not toggle, depending on the adapter.
> +                * If it doesn't toggle, transition to SNK_HARD_RESET_SINK_ON
> +                * directly after timeout.
> +                */
> +               tcpm_set_state(dev, SNK_HARD_RESET_SINK_ON, PD_T_SAFE_0V);
> +               break;
> +       case SNK_HARD_RESET_WAIT_VBUS:
> +               /* Assume we're disconnected if VBUS doesn't come back. */
> +               tcpm_set_state(dev, SNK_UNATTACHED,
> +                              PD_T_SRC_RECOVER_MAX + PD_T_SRC_TURN_ON);
> +               break;
> +       case SNK_HARD_RESET_SINK_ON:
> +               /* Note: There is no guarantee that VBUS is on in this state */
> +               /*
> +                * XXX:
> +                * The specification suggests that dual mode ports in sink
> +                * mode should transition to state PE_SRC_Transition_to_default.
> +                * See USB power delivery specification chapter 8.3.3.6.1.3.
> +                * This would mean to
> +                * - turn off VCONN, reset power supply
> +                * - request hardware reset
> +                * - turn on VCONN
> +                * - Transition to state PE_Src_Startup
> +                * SNK only ports shall transition to state Snk_Startup
> +                * (see chapter 8.3.3.3.8).
> +                * Similar, dual-mode ports in source mode should transition
> +                * to PE_SNK_Transition_to_default.
> +                */
> +               if (port->pd_capable) {
> +                       tcpm_set_current_limit(dev,
> +                                              tcpm_get_current_limit(port),
> +                                              5000);
> +                       tcpm_set_charge(dev, true);
> +               }
> +               tcpm_set_attached_state(dev, true);
> +               tcpm_set_state(dev, SNK_STARTUP, 0);
> +               break;
> +
> +       /* Soft_Reset states */
> +       case SOFT_RESET:
> +               port->message_id = 0;
> +               port->rx_msgid = -1;
> +               tcpm_pd_send_control(dev, PD_CTRL_ACCEPT);
> +               if (port->pwr_role == TYPEC_SOURCE)
> +                       tcpm_set_state(dev, SRC_SEND_CAPABILITIES, 0);
> +               else
> +                       tcpm_set_state(dev, SNK_WAIT_CAPABILITIES, 0);
> +               break;
> +       case SOFT_RESET_SEND:
> +               port->message_id = 0;
> +               port->rx_msgid = -1;
> +               if (tcpm_pd_send_control(dev, PD_CTRL_SOFT_RESET))
> +                       tcpm_set_state_cond(dev, hard_reset_state(port), 0);
> +               else
> +                       tcpm_set_state_cond(dev, hard_reset_state(port),
> +                                           PD_T_SENDER_RESPONSE);
> +               break;
> +
> +       /* DR_Swap states */
> +       case DR_SWAP_ACCEPT:
> +               tcpm_pd_send_control(dev, PD_CTRL_ACCEPT);
> +               tcpm_set_state_cond(dev, DR_SWAP_CHANGE_DR, 0);
> +               break;
> +       case DR_SWAP_CHANGE_DR:
> +               if (port->data_role == TYPEC_HOST) {
> +                       tcpm_set_roles(dev, true, port->pwr_role,
> +                                      TYPEC_DEVICE);
> +               } else {
> +                       tcpm_set_roles(dev, true, port->pwr_role,
> +                                      TYPEC_HOST);
> +               }
> +               /* DR_swap process complete, wait_dr_swap_message is cleared */
> +               port->wait_dr_swap_message = false;
> +               tcpm_set_state(dev, ready_state(port), 0);
> +               break;
> +       case ERROR_RECOVERY:
> +               tcpm_set_state(dev, PORT_RESET, 0);
> +               break;
> +       case PORT_RESET:
> +               tcpm_reset_port(dev);
> +               if (port->self_powered)
> +                       tcpm_set_cc(dev, TYPEC_CC_OPEN);
> +               else
> +                       tcpm_set_cc(dev, tcpm_default_state(port) == SNK_UNATTACHED ?
> +                                   TYPEC_CC_RD : tcpm_rp_cc(port));
> +               tcpm_set_state(dev, PORT_RESET_WAIT_OFF,
> +                              PD_T_ERROR_RECOVERY);
> +               break;
> +       case PORT_RESET_WAIT_OFF:
> +               tcpm_set_state(dev,
> +                              tcpm_default_state(port),
> +                              port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
> +               break;
> +       default:
> +               dev_err(dev, "TCPM: Unexpected port state %d\n", port->state);
> +               break;
> +       }
> +}
> +
> +static void tcpm_state_machine(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       enum tcpm_state prev_state;
> +
> +       mutex_lock(&port->lock);
> +       port->state_machine_running = true;
> +
> +       if (port->queued_message && tcpm_send_queued_message(dev))
> +               goto done;
> +
> +       /* If we were queued due to a delayed state change, update it now */
> +       if (port->delayed_state) {
> +               dev_dbg(dev, "TCPM: state change %s -> %s [delayed %ld ms]\n",
> +                       tcpm_states[port->state],
> +                       tcpm_states[port->delayed_state], port->delay_ms);
> +               port->prev_state = port->state;
> +               port->state = port->delayed_state;
> +               port->delayed_state = INVALID_STATE;
> +       }
> +
> +       /*
> +        * Continue running as long as we have (non-delayed) state changes
> +        * to make.
> +        */
> +       do {
> +               prev_state = port->state;
> +               run_state_machine(dev);
> +               if (port->queued_message)
> +                       tcpm_send_queued_message(dev);
> +       } while (port->state != prev_state && !port->delayed_state);
> +
> +done:
> +       port->state_machine_running = false;
> +       mutex_unlock(&port->lock);
> +}
> +
> +static void _tcpm_cc_change(struct udevice *dev, enum typec_cc_status cc1,
> +                           enum typec_cc_status cc2)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       enum typec_cc_status old_cc1, old_cc2;
> +       enum tcpm_state new_state;
> +
> +       old_cc1 = port->cc1;
> +       old_cc2 = port->cc2;
> +       port->cc1 = cc1;
> +       port->cc2 = cc2;
> +
> +       dev_dbg(dev, "TCPM: CC1: %u -> %u, CC2: %u -> %u [state %s, polarity %d, %s]\n",
> +               old_cc1, cc1, old_cc2, cc2, tcpm_states[port->state],
> +               port->polarity,
> +               tcpm_port_is_disconnected(port) ? "disconnected" : "connected");
> +
> +       switch (port->state) {
> +       case TOGGLING:
> +               if (tcpm_port_is_source(port))
> +                       tcpm_set_state(dev, SRC_ATTACH_WAIT, 0);
> +               else if (tcpm_port_is_sink(port))
> +                       tcpm_set_state(dev, SNK_ATTACH_WAIT, 0);
> +               break;
> +       case SRC_UNATTACHED:
> +       case SRC_ATTACH_WAIT:
> +               if (tcpm_port_is_disconnected(port))
> +                       tcpm_set_state(dev, SRC_UNATTACHED, 0);
> +               else if (cc1 != old_cc1 || cc2 != old_cc2)
> +                       tcpm_set_state(dev, SRC_ATTACH_WAIT, 0);
> +               break;
> +       case SRC_ATTACHED:
> +       case SRC_SEND_CAPABILITIES:
> +       case SRC_READY:
> +               if (tcpm_port_is_disconnected(port) ||
> +                   !tcpm_port_is_source(port))
> +                       tcpm_set_state(dev, SRC_UNATTACHED, 0);
> +               break;
> +       case SNK_UNATTACHED:
> +               if (tcpm_port_is_sink(port))
> +                       tcpm_set_state(dev, SNK_ATTACH_WAIT, 0);
> +               break;
> +       case SNK_ATTACH_WAIT:
> +               if ((port->cc1 == TYPEC_CC_OPEN &&
> +                    port->cc2 != TYPEC_CC_OPEN) ||
> +                   (port->cc1 != TYPEC_CC_OPEN &&
> +                    port->cc2 == TYPEC_CC_OPEN))
> +                       new_state = SNK_DEBOUNCED;
> +               else if (tcpm_port_is_disconnected(port))
> +                       new_state = SNK_UNATTACHED;
> +               else
> +                       break;
> +               if (new_state != port->delayed_state)
> +                       tcpm_set_state(dev, SNK_ATTACH_WAIT, 0);
> +               break;
> +       case SNK_DEBOUNCED:
> +               if (tcpm_port_is_disconnected(port))
> +                       new_state = SNK_UNATTACHED;
> +               else if (port->vbus_present)
> +                       new_state = tcpm_try_src(port) ? INVALID_STATE : SNK_ATTACHED;
> +               else
> +                       new_state = SNK_UNATTACHED;
> +               if (new_state != port->delayed_state)
> +                       tcpm_set_state(dev, SNK_DEBOUNCED, 0);
> +               break;
> +       case SNK_READY:
> +               if (tcpm_port_is_disconnected(port))
> +                       tcpm_set_state(dev, unattached_state(port), 0);
> +               else if (!port->pd_capable &&
> +                        (cc1 != old_cc1 || cc2 != old_cc2))
> +                       tcpm_set_current_limit(dev,
> +                                              tcpm_get_current_limit(port),
> +                                              5000);
> +               break;
> +
> +       case SNK_DISCOVERY:
> +               /* CC line is unstable, wait for debounce */
> +               if (tcpm_port_is_disconnected(port))
> +                       tcpm_set_state(dev, SNK_DISCOVERY_DEBOUNCE, 0);
> +               break;
> +       case SNK_DISCOVERY_DEBOUNCE:
> +               break;
> +
> +       case PORT_RESET:
> +       case PORT_RESET_WAIT_OFF:
> +               /*
> +                * State set back to default mode once the timer completes.
> +                * Ignore CC changes here.
> +                */
> +               break;
> +       default:
> +               /*
> +                * While acting as sink and auto vbus discharge is enabled, Allow disconnect
> +                * to be driven by vbus disconnect.
> +                */
> +               if (tcpm_port_is_disconnected(port))
> +                       tcpm_set_state(dev, unattached_state(port), 0);
> +               break;
> +       }
> +}
> +
> +static void _tcpm_pd_vbus_on(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       dev_dbg(dev, "TCPM: VBUS on event\n");
> +       port->vbus_present = true;
> +       /*
> +        * When vbus_present is true i.e. Voltage at VBUS is greater than VSAFE5V implicitly
> +        * states that vbus is not at VSAFE0V, hence clear the vbus_vsafe0v flag here.
> +        */
> +       port->vbus_vsafe0v = false;
> +
> +       switch (port->state) {
> +       case SNK_TRANSITION_SINK_VBUS:
> +               port->explicit_contract = true;
> +               tcpm_set_state(dev, SNK_READY, 0);
> +               break;
> +       case SNK_DISCOVERY:
> +               tcpm_set_state(dev, SNK_DISCOVERY, 0);
> +               break;
> +       case SNK_DEBOUNCED:
> +               tcpm_set_state(dev, SNK_ATTACHED, 0);
> +               break;
> +       case SNK_HARD_RESET_WAIT_VBUS:
> +               tcpm_set_state(dev, SNK_HARD_RESET_SINK_ON, 0);
> +               break;
> +       case SRC_ATTACHED:
> +               tcpm_set_state(dev, SRC_STARTUP, 0);
> +               break;
> +       case SRC_HARD_RESET_VBUS_ON:
> +               tcpm_set_state(dev, SRC_STARTUP, 0);
> +               break;
> +
> +       case PORT_RESET:
> +       case PORT_RESET_WAIT_OFF:
> +               /*
> +                * State set back to default mode once the timer completes.
> +                * Ignore vbus changes here.
> +                */
> +               break;
> +
> +       default:
> +               break;
> +       }
> +}
> +
> +static void _tcpm_pd_vbus_off(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       dev_dbg(dev, "TCPM: VBUS off event\n");
> +       port->vbus_present = false;
> +       port->vbus_never_low = false;
> +       switch (port->state) {
> +       case SNK_HARD_RESET_SINK_OFF:
> +               tcpm_set_state(dev, SNK_HARD_RESET_WAIT_VBUS, 0);
> +               break;
> +       case HARD_RESET_SEND:
> +               break;
> +       case SNK_ATTACH_WAIT:
> +               tcpm_set_state(dev, SNK_UNATTACHED, 0);
> +               break;
> +
> +       case SNK_NEGOTIATE_CAPABILITIES:
> +               break;
> +
> +       case PORT_RESET_WAIT_OFF:
> +               tcpm_set_state(dev, tcpm_default_state(port), 0);
> +               break;
> +
> +       case PORT_RESET:
> +               /*
> +                * State set back to default mode once the timer completes.
> +                * Ignore vbus changes here.
> +                */
> +               break;
> +
> +       default:
> +               if (port->pwr_role == TYPEC_SINK && port->attached)
> +                       tcpm_set_state(dev, SNK_UNATTACHED, 0);
> +               break;
> +       }
> +}
> +
> +void tcpm_cc_change(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       enum typec_cc_status cc1, cc2;
> +
> +       tcpm_reset_event_cnt(dev);
> +       if (drvops->get_cc(dev, &cc1, &cc2) == 0)
> +               _tcpm_cc_change(dev, cc1, cc2);
> +}
> +
> +void tcpm_vbus_change(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       bool vbus;
> +
> +       tcpm_reset_event_cnt(dev);
> +       vbus = drvops->get_vbus(dev);
> +       if (vbus)
> +               _tcpm_pd_vbus_on(dev);
> +       else
> +               _tcpm_pd_vbus_off(dev);
> +}
> +
> +void tcpm_pd_hard_reset(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       tcpm_reset_event_cnt(dev);
> +       dev_dbg(dev, "TCPM: Received hard reset\n");
> +
> +       /* If a hard reset message is received during the port reset process,
> +        * we should ignore it, that is, do not set port->state to HARD_RESET_START.
> +        */
> +       if (port->state == PORT_RESET || port->state == PORT_RESET_WAIT_OFF)
> +               return;
> +
> +       /*
> +        * If we keep receiving hard reset requests, executing the hard reset
> +        * must have failed. Revert to error recovery if that happens.
> +        */
> +       tcpm_set_state(dev,
> +                      port->hard_reset_count < PD_N_HARD_RESET_COUNT ?
> +                               HARD_RESET_START : ERROR_RECOVERY,
> +                      0);
> +}
> +
> +static void tcpm_init(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       enum typec_cc_status cc1, cc2;
> +
> +       drvops->init(dev);
> +
> +       tcpm_reset_port(dev);
> +
> +       /*
> +        * XXX
> +        * Should possibly wait for VBUS to settle if it was enabled locally
> +        * since tcpm_reset_port() will disable VBUS.
> +        */
> +       port->vbus_present = drvops->get_vbus(dev);
> +       if (port->vbus_present)
> +               port->vbus_never_low = true;
> +
> +       /*
> +        * 1. When vbus_present is true, voltage on VBUS is already at VSAFE5V.
> +        * So implicitly vbus_vsafe0v = false.
> +        *
> +        * 2. When vbus_present is false and TCPC does NOT support querying
> +        * vsafe0v status, then, it's best to assume vbus is at VSAFE0V i.e.
> +        * vbus_vsafe0v is true.
> +        *
> +        * 3. When vbus_present is false and TCPC does support querying vsafe0v,
> +        * then, query tcpc for vsafe0v status.
> +        */
> +       if (port->vbus_present)
> +               port->vbus_vsafe0v = false;
> +       else
> +               port->vbus_vsafe0v = true;
> +
> +       tcpm_set_state(dev, tcpm_default_state(port), 0);
> +
> +       if (drvops->get_cc(dev, &cc1, &cc2) == 0)
> +               _tcpm_cc_change(dev, cc1, cc2);
> +}
> +
> +static int tcpm_fw_get_caps(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       ofnode node;
> +       const char *cap_str;
> +       int ret;
> +       u32 mw;
> +
> +       ret = drvops->get_connector_node(dev, &node);
> +       if (ret)
> +               return ret;
> +
> +       cap_str = ofnode_read_string(node, "power-role");
> +       if (!cap_str)
> +               return -EINVAL;
> +
> +       if (!strcmp("dual", cap_str))
> +               port->typec_type = TYPEC_PORT_DRP;
> +       else if (!strcmp("source", cap_str))
> +               port->typec_type = TYPEC_PORT_SRC;
> +       else if (!strcmp("sink", cap_str))
> +               port->typec_type = TYPEC_PORT_SNK;
> +       else
> +               return -EINVAL;
> +
> +       port->port_type = port->typec_type;
> +
> +       if (port->port_type == TYPEC_PORT_SNK)
> +               goto sink;
> +
> +       /* Get source pdos */
> +       ret = ofnode_read_size(node, "source-pdos") / sizeof(u32);
> +       if (ret <= 0)
> +               return -EINVAL;
> +
> +       port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> +       ret = ofnode_read_u32_array(node, "source-pdos",
> +                                   port->src_pdo, port->nr_src_pdo);
> +       if (ret || tcpm_validate_caps(dev, port->src_pdo, port->nr_src_pdo))
> +               return -EINVAL;
> +
> +       if (port->port_type == TYPEC_PORT_SRC)
> +               return 0;
> +
> +       /* Get the preferred power role for DRP */
> +       cap_str = ofnode_read_string(node, "try-power-role");
> +       if (!cap_str)
> +               return -EINVAL;
> +
> +       if (!strcmp("sink", cap_str))
> +               port->typec_prefer_role = TYPEC_SINK;
> +       else if (!strcmp("source", cap_str))
> +               port->typec_prefer_role = TYPEC_SOURCE;
> +       else
> +               return -EINVAL;
> +
> +       if (port->typec_prefer_role < 0)
> +               return -EINVAL;
> +sink:
> +       /* Get sink pdos */
> +       ret = ofnode_read_size(node, "sink-pdos") / sizeof(u32);
> +       if (ret <= 0)
> +               return -EINVAL;
> +
> +       port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
> +       ret = ofnode_read_u32_array(node, "sink-pdos",
> +                                   port->snk_pdo, port->nr_snk_pdo);
> +       if (ret || tcpm_validate_caps(dev, port->snk_pdo, port->nr_snk_pdo))
> +               return -EINVAL;
> +
> +       if (ofnode_read_u32_array(node, "op-sink-microwatt", &mw, 1))
> +               return -EINVAL;
> +       port->operating_snk_mw = mw / 1000;
> +
> +       port->self_powered = ofnode_read_bool(node, "self-powered");
> +
> +       return 0;
> +}
> +
> +static int tcpm_port_init(struct udevice *dev)
> +{
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +       int err;
> +
> +       err = tcpm_fw_get_caps(dev);
> +       if (err < 0) {
> +               dev_err(dev, "TCPM: please check the dts config: %d\n", err);
> +               return err;
> +       }
> +
> +       port->try_role = port->typec_prefer_role;
> +       port->port_type = port->typec_type;
> +
> +       tcpm_init(dev);
> +
> +       dev_info(dev, "TCPM: init finished\n");
> +
> +       return 0;
> +}
> +
> +static void tcpm_poll_event(struct udevice *dev)
> +{
> +       const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
> +       struct tcpm_port *port = dev_get_uclass_plat(dev);
> +
> +       if (!drvops->get_vbus(dev))
> +               return;
> +
> +       while (port->poll_event_cnt < TCPM_POLL_EVENT_TIME_OUT) {
> +               if (!port->wait_dr_swap_message &&
> +                   (port->state == SNK_READY || port->state == SRC_READY))
> +                       break;
> +
> +               drvops->poll_event(dev);
> +               port->poll_event_cnt++;
> +               udelay(500);
> +               tcpm_check_and_run_delayed_work(dev);
> +       }
> +
> +       if (port->state != SNK_READY && port->state != SRC_READY)
> +               dev_warn(dev, "TCPM: exit in state %s\n",
> +                        tcpm_states[port->state]);
> +
> +       /*
> +        * At this time, call the callback function of the respective pd chip
> +        * to enter the low-power mode. In order to reduce the time spent on
> +        * the PD chip driver as much as possible, the tcpm framework does not
> +        * fully process the communication initiated by the device,so it should
> +        * be noted that we can disable the internal oscillator, etc., but do
> +        * not turn off the power of the transceiver module, otherwise the
> +        * self-powered Type-C device will initiate a Message(eg: self-powered
> +        * Type-C hub initiates a SINK capability request(PD_CTRL_GET_SINK_CAP))
> +        * and the pd chip cannot reply to GoodCRC, causing the self-powered Type-C
> +        * device to switch vbus to vSafe5v, or even turn off vbus.
> +        */
> +       if (!drvops->enter_low_power_mode)
> +               return;
> +
> +       if (drvops->enter_low_power_mode(dev, port->attached, port->pd_capable))
> +               dev_err(dev, "TCPM: failed to enter low power\n");
> +       else
> +               dev_info(dev, "TCPM: PD chip enter low power mode\n");
> +}
> +
> +int tcpm_post_probe(struct udevice *dev)
> +{
> +       int ret = tcpm_port_init(dev);
> +
> +       if (ret < 0) {
> +               dev_err(dev, "failed to tcpm port init\n");
> +               return ret;
> +       }
> +
> +       tcpm_poll_event(dev);
> +
> +       return 0;
> +}
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 5271e646bb16..270088ad94f7 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -139,6 +139,7 @@ enum uclass_id {
>         UCLASS_SYSCON,          /* System configuration device */
>         UCLASS_SYSINFO,         /* Device information from hardware */
>         UCLASS_SYSRESET,        /* System reset device */
> +       UCLASS_TCPM,            /* TypeC port manager */
>         UCLASS_TEE,             /* Trusted Execution Environment device */
>         UCLASS_THERMAL,         /* Thermal sensor */
>         UCLASS_TIMER,           /* Timer device */
> diff --git a/include/usb/pd.h b/include/usb/pd.h
> new file mode 100644
> index 000000000000..cacda322d7c6
> --- /dev/null
> +++ b/include/usb/pd.h
> @@ -0,0 +1,516 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2015-2017 Google, Inc
> + */
> +
> +#ifndef __LINUX_USB_PD_H
> +#define __LINUX_USB_PD_H
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +enum typec_port_type {
> +       TYPEC_PORT_SRC,
> +       TYPEC_PORT_SNK,
> +       TYPEC_PORT_DRP,
> +};
> +
> +enum typec_data_role {
> +       TYPEC_DEVICE,
> +       TYPEC_HOST,
> +};
> +
> +enum typec_role {
> +       TYPEC_SINK,
> +       TYPEC_SOURCE,
> +};
> +
> +/* USB PD Messages */
> +enum pd_ctrl_msg_type {
> +       /* 0 Reserved */
> +       PD_CTRL_GOOD_CRC = 1,
> +       PD_CTRL_GOTO_MIN = 2,
> +       PD_CTRL_ACCEPT = 3,
> +       PD_CTRL_REJECT = 4,
> +       PD_CTRL_PING = 5,
> +       PD_CTRL_PS_RDY = 6,
> +       PD_CTRL_GET_SOURCE_CAP = 7,
> +       PD_CTRL_GET_SINK_CAP = 8,
> +       PD_CTRL_DR_SWAP = 9,
> +       PD_CTRL_PR_SWAP = 10,
> +       PD_CTRL_VCONN_SWAP = 11,
> +       PD_CTRL_WAIT = 12,
> +       PD_CTRL_SOFT_RESET = 13,
> +       /* 14-15 Reserved */
> +       PD_CTRL_NOT_SUPP = 16,
> +       PD_CTRL_GET_SOURCE_CAP_EXT = 17,
> +       PD_CTRL_GET_STATUS = 18,
> +       PD_CTRL_FR_SWAP = 19,
> +       PD_CTRL_GET_PPS_STATUS = 20,
> +       PD_CTRL_GET_COUNTRY_CODES = 21,
> +       /* 22-31 Reserved */
> +};
> +
> +enum pd_data_msg_type {
> +       /* 0 Reserved */
> +       PD_DATA_SOURCE_CAP = 1,
> +       PD_DATA_REQUEST = 2,
> +       PD_DATA_BIST = 3,
> +       PD_DATA_SINK_CAP = 4,
> +       PD_DATA_BATT_STATUS = 5,
> +       PD_DATA_ALERT = 6,
> +       PD_DATA_GET_COUNTRY_INFO = 7,
> +       PD_DATA_ENTER_USB = 8,
> +       /* 9-14 Reserved */
> +       PD_DATA_VENDOR_DEF = 15,
> +       /* 16-31 Reserved */
> +};
> +
> +enum pd_ext_msg_type {
> +       /* 0 Reserved */
> +       PD_EXT_SOURCE_CAP_EXT = 1,
> +       PD_EXT_STATUS = 2,
> +       PD_EXT_GET_BATT_CAP = 3,
> +       PD_EXT_GET_BATT_STATUS = 4,
> +       PD_EXT_BATT_CAP = 5,
> +       PD_EXT_GET_MANUFACTURER_INFO = 6,
> +       PD_EXT_MANUFACTURER_INFO = 7,
> +       PD_EXT_SECURITY_REQUEST = 8,
> +       PD_EXT_SECURITY_RESPONSE = 9,
> +       PD_EXT_FW_UPDATE_REQUEST = 10,
> +       PD_EXT_FW_UPDATE_RESPONSE = 11,
> +       PD_EXT_PPS_STATUS = 12,
> +       PD_EXT_COUNTRY_INFO = 13,
> +       PD_EXT_COUNTRY_CODES = 14,
> +       /* 15-31 Reserved */
> +};
> +
> +#define PD_REV10       0x0
> +#define PD_REV20       0x1
> +#define PD_REV30       0x2
> +#define PD_MAX_REV     PD_REV30
> +
> +#define PD_HEADER_EXT_HDR      BIT(15)
> +#define PD_HEADER_CNT_SHIFT    12
> +#define PD_HEADER_CNT_MASK     0x7
> +#define PD_HEADER_ID_SHIFT     9
> +#define PD_HEADER_ID_MASK      0x7
> +#define PD_HEADER_PWR_ROLE     BIT(8)
> +#define PD_HEADER_REV_SHIFT    6
> +#define PD_HEADER_REV_MASK     0x3
> +#define PD_HEADER_DATA_ROLE    BIT(5)
> +#define PD_HEADER_TYPE_SHIFT   0
> +#define PD_HEADER_TYPE_MASK    0x1f
> +
> +#define PD_HEADER(type, pwr, data, rev, id, cnt, ext_hdr)              \
> +       ((((type) & PD_HEADER_TYPE_MASK) << PD_HEADER_TYPE_SHIFT) |     \
> +        ((pwr) == TYPEC_SOURCE ? PD_HEADER_PWR_ROLE : 0) |             \
> +        ((data) == TYPEC_HOST ? PD_HEADER_DATA_ROLE : 0) |             \
> +        ((rev) << PD_HEADER_REV_SHIFT) |                                       \
> +        (((id) & PD_HEADER_ID_MASK) << PD_HEADER_ID_SHIFT) |           \
> +        (((cnt) & PD_HEADER_CNT_MASK) << PD_HEADER_CNT_SHIFT) |        \
> +        ((ext_hdr) ? PD_HEADER_EXT_HDR : 0))
> +
> +#define PD_HEADER_LE(type, pwr, data, rev, id, cnt) \
> +       cpu_to_le16(PD_HEADER((type), (pwr), (data), (rev), (id), (cnt), (0)))
> +
> +static inline unsigned int pd_header_cnt(u16 header)
> +{
> +       return (header >> PD_HEADER_CNT_SHIFT) & PD_HEADER_CNT_MASK;
> +}
> +
> +static inline unsigned int pd_header_cnt_le(__le16 header)
> +{
> +       return pd_header_cnt(le16_to_cpu(header));
> +}
> +
> +static inline unsigned int pd_header_type(u16 header)
> +{
> +       return (header >> PD_HEADER_TYPE_SHIFT) & PD_HEADER_TYPE_MASK;
> +}
> +
> +static inline unsigned int pd_header_type_le(__le16 header)
> +{
> +       return pd_header_type(le16_to_cpu(header));
> +}
> +
> +static inline unsigned int pd_header_msgid(u16 header)
> +{
> +       return (header >> PD_HEADER_ID_SHIFT) & PD_HEADER_ID_MASK;
> +}
> +
> +static inline unsigned int pd_header_msgid_le(__le16 header)
> +{
> +       return pd_header_msgid(le16_to_cpu(header));
> +}
> +
> +static inline unsigned int pd_header_rev(u16 header)
> +{
> +       return (header >> PD_HEADER_REV_SHIFT) & PD_HEADER_REV_MASK;
> +}
> +
> +static inline unsigned int pd_header_rev_le(__le16 header)
> +{
> +       return pd_header_rev(le16_to_cpu(header));
> +}
> +
> +#define PD_EXT_HDR_CHUNKED             BIT(15)
> +#define PD_EXT_HDR_CHUNK_NUM_SHIFT     11
> +#define PD_EXT_HDR_CHUNK_NUM_MASK      0xf
> +#define PD_EXT_HDR_REQ_CHUNK           BIT(10)
> +#define PD_EXT_HDR_DATA_SIZE_SHIFT     0
> +#define PD_EXT_HDR_DATA_SIZE_MASK      0x1ff
> +
> +#define PD_EXT_HDR(data_size, req_chunk, chunk_num, chunked)                           \
> +       ((((data_size) & PD_EXT_HDR_DATA_SIZE_MASK) << PD_EXT_HDR_DATA_SIZE_SHIFT) |    \
> +        ((req_chunk) ? PD_EXT_HDR_REQ_CHUNK : 0) |                                     \
> +        (((chunk_num) & PD_EXT_HDR_CHUNK_NUM_MASK) << PD_EXT_HDR_CHUNK_NUM_SHIFT) |    \
> +        ((chunked) ? PD_EXT_HDR_CHUNKED : 0))
> +
> +#define PD_EXT_HDR_LE(data_size, req_chunk, chunk_num, chunked) \
> +       cpu_to_le16(PD_EXT_HDR((data_size), (req_chunk), (chunk_num), (chunked)))
> +
> +static inline unsigned int pd_ext_header_chunk_num(u16 ext_header)
> +{
> +       return (ext_header >> PD_EXT_HDR_CHUNK_NUM_SHIFT) &
> +               PD_EXT_HDR_CHUNK_NUM_MASK;
> +}
> +
> +static inline unsigned int pd_ext_header_data_size(u16 ext_header)
> +{
> +       return (ext_header >> PD_EXT_HDR_DATA_SIZE_SHIFT) &
> +               PD_EXT_HDR_DATA_SIZE_MASK;
> +}
> +
> +static inline unsigned int pd_ext_header_data_size_le(__le16 ext_header)
> +{
> +       return pd_ext_header_data_size(le16_to_cpu(ext_header));
> +}
> +
> +#define PD_MAX_PAYLOAD         7
> +#define PD_EXT_MAX_CHUNK_DATA  26
> +
> +/*
> + * struct pd_chunked_ext_message_data - PD chunked extended message data as
> + *                                      seen on wire
> + * @header:    PD extended message header
> + * @data:      PD extended message data
> + */
> +struct pd_chunked_ext_message_data {
> +       __le16 header;
> +       u8 data[PD_EXT_MAX_CHUNK_DATA];
> +} __packed;
> +
> +/*
> + * struct pd_message - PD message as seen on wire
> + * @header:    PD message header
> + * @payload:   PD message payload
> + * @ext_msg:   PD message chunked extended message data
> + */
> +struct pd_message {
> +       __le16 header;
> +       union {
> +               __le32 payload[PD_MAX_PAYLOAD];
> +               struct pd_chunked_ext_message_data ext_msg;
> +       };
> +} __packed;
> +
> +/* PDO: Power Data Object */
> +#define PDO_MAX_OBJECTS                7
> +
> +enum pd_pdo_type {
> +       PDO_TYPE_FIXED = 0,
> +       PDO_TYPE_BATT = 1,
> +       PDO_TYPE_VAR = 2,
> +       PDO_TYPE_APDO = 3,
> +};
> +
> +#define PDO_TYPE_SHIFT         30
> +#define PDO_TYPE_MASK          0x3
> +
> +#define PDO_TYPE(t)    ((t) << PDO_TYPE_SHIFT)
> +
> +#define PDO_VOLT_MASK          0x3ff
> +#define PDO_CURR_MASK          0x3ff
> +#define PDO_PWR_MASK           0x3ff
> +
> +#define PDO_FIXED_DUAL_ROLE            BIT(29) /* Power role swap supported */
> +#define PDO_FIXED_SUSPEND              BIT(28) /* USB Suspend supported (Source) */
> +#define PDO_FIXED_HIGHER_CAP           BIT(28) /* Requires more than vSafe5V (Sink) */
> +#define PDO_FIXED_EXTPOWER             BIT(27) /* Externally powered */
> +#define PDO_FIXED_USB_COMM             BIT(26) /* USB communications capable */
> +#define PDO_FIXED_DATA_SWAP            BIT(25) /* Data role swap supported */
> +#define PDO_FIXED_UNCHUNK_EXT          BIT(24) /* Unchunked Extended Message supported (Source) */
> +#define PDO_FIXED_FRS_CURR_MASK                (BIT(24) | BIT(23)) /* FR_Swap Current (Sink) */
> +#define PDO_FIXED_FRS_CURR_SHIFT       23
> +#define PDO_FIXED_VOLT_SHIFT           10      /* 50mV units */
> +#define PDO_FIXED_CURR_SHIFT           0       /* 10mA units */
> +
> +#define PDO_FIXED_VOLT(mv)     ((((mv) / 50) & PDO_VOLT_MASK) << PDO_FIXED_VOLT_SHIFT)
> +#define PDO_FIXED_CURR(ma)     ((((ma) / 10) & PDO_CURR_MASK) << PDO_FIXED_CURR_SHIFT)
> +
> +#define PDO_FIXED(mv, ma, flags)                       \
> +       (PDO_TYPE(PDO_TYPE_FIXED) | (flags) |           \
> +        PDO_FIXED_VOLT(mv) | PDO_FIXED_CURR(ma))
> +
> +#define VSAFE5V 5000 /* mv units */
> +
> +#define PDO_BATT_MAX_VOLT_SHIFT        20      /* 50mV units */
> +#define PDO_BATT_MIN_VOLT_SHIFT        10      /* 50mV units */
> +#define PDO_BATT_MAX_PWR_SHIFT 0       /* 250mW units */
> +
> +#define PDO_BATT_MIN_VOLT(mv) ((((mv) / 50) & PDO_VOLT_MASK) << PDO_BATT_MIN_VOLT_SHIFT)
> +#define PDO_BATT_MAX_VOLT(mv) ((((mv) / 50) & PDO_VOLT_MASK) << PDO_BATT_MAX_VOLT_SHIFT)
> +#define PDO_BATT_MAX_POWER(mw) ((((mw) / 250) & PDO_PWR_MASK) << PDO_BATT_MAX_PWR_SHIFT)
> +
> +#define PDO_BATT(min_mv, max_mv, max_mw)                       \
> +       (PDO_TYPE(PDO_TYPE_BATT) | PDO_BATT_MIN_VOLT(min_mv) |  \
> +        PDO_BATT_MAX_VOLT(max_mv) | PDO_BATT_MAX_POWER(max_mw))
> +
> +#define PDO_VAR_MAX_VOLT_SHIFT 20      /* 50mV units */
> +#define PDO_VAR_MIN_VOLT_SHIFT 10      /* 50mV units */
> +#define PDO_VAR_MAX_CURR_SHIFT 0       /* 10mA units */
> +
> +#define PDO_VAR_MIN_VOLT(mv) ((((mv) / 50) & PDO_VOLT_MASK) << PDO_VAR_MIN_VOLT_SHIFT)
> +#define PDO_VAR_MAX_VOLT(mv) ((((mv) / 50) & PDO_VOLT_MASK) << PDO_VAR_MAX_VOLT_SHIFT)
> +#define PDO_VAR_MAX_CURR(ma) ((((ma) / 10) & PDO_CURR_MASK) << PDO_VAR_MAX_CURR_SHIFT)
> +
> +#define PDO_VAR(min_mv, max_mv, max_ma)                                \
> +       (PDO_TYPE(PDO_TYPE_VAR) | PDO_VAR_MIN_VOLT(min_mv) |    \
> +        PDO_VAR_MAX_VOLT(max_mv) | PDO_VAR_MAX_CURR(max_ma))
> +
> +enum pd_apdo_type {
> +       APDO_TYPE_PPS = 0,
> +};
> +
> +#define PDO_APDO_TYPE_SHIFT    28      /* Only valid value currently is 0x0 - PPS */
> +#define PDO_APDO_TYPE_MASK     0x3
> +
> +#define PDO_APDO_TYPE(t)       ((t) << PDO_APDO_TYPE_SHIFT)
> +
> +#define PDO_PPS_APDO_MAX_VOLT_SHIFT    17      /* 100mV units */
> +#define PDO_PPS_APDO_MIN_VOLT_SHIFT    8       /* 100mV units */
> +#define PDO_PPS_APDO_MAX_CURR_SHIFT    0       /* 50mA units */
> +
> +#define PDO_PPS_APDO_VOLT_MASK 0xff
> +#define PDO_PPS_APDO_CURR_MASK 0x7f
> +
> +#define PDO_PPS_APDO_MIN_VOLT(mv)      \
> +       ((((mv) / 100) & PDO_PPS_APDO_VOLT_MASK) << PDO_PPS_APDO_MIN_VOLT_SHIFT)
> +#define PDO_PPS_APDO_MAX_VOLT(mv)      \
> +       ((((mv) / 100) & PDO_PPS_APDO_VOLT_MASK) << PDO_PPS_APDO_MAX_VOLT_SHIFT)
> +#define PDO_PPS_APDO_MAX_CURR(ma)      \
> +       ((((ma) / 50) & PDO_PPS_APDO_CURR_MASK) << PDO_PPS_APDO_MAX_CURR_SHIFT)
> +
> +#define PDO_PPS_APDO(min_mv, max_mv, max_ma)                           \
> +       (PDO_TYPE(PDO_TYPE_APDO) | PDO_APDO_TYPE(APDO_TYPE_PPS) |       \
> +       PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) | \
> +       PDO_PPS_APDO_MAX_CURR(max_ma))
> +
> +static inline enum pd_pdo_type pdo_type(u32 pdo)
> +{
> +       return (pdo >> PDO_TYPE_SHIFT) & PDO_TYPE_MASK;
> +}
> +
> +static inline unsigned int pdo_fixed_voltage(u32 pdo)
> +{
> +       return ((pdo >> PDO_FIXED_VOLT_SHIFT) & PDO_VOLT_MASK) * 50;
> +}
> +
> +static inline unsigned int pdo_min_voltage(u32 pdo)
> +{
> +       return ((pdo >> PDO_VAR_MIN_VOLT_SHIFT) & PDO_VOLT_MASK) * 50;
> +}
> +
> +static inline unsigned int pdo_max_voltage(u32 pdo)
> +{
> +       return ((pdo >> PDO_VAR_MAX_VOLT_SHIFT) & PDO_VOLT_MASK) * 50;
> +}
> +
> +static inline unsigned int pdo_max_current(u32 pdo)
> +{
> +       return ((pdo >> PDO_VAR_MAX_CURR_SHIFT) & PDO_CURR_MASK) * 10;
> +}
> +
> +static inline unsigned int pdo_max_power(u32 pdo)
> +{
> +       return ((pdo >> PDO_BATT_MAX_PWR_SHIFT) & PDO_PWR_MASK) * 250;
> +}
> +
> +static inline enum pd_apdo_type pdo_apdo_type(u32 pdo)
> +{
> +       return (pdo >> PDO_APDO_TYPE_SHIFT) & PDO_APDO_TYPE_MASK;
> +}
> +
> +static inline unsigned int pdo_pps_apdo_min_voltage(u32 pdo)
> +{
> +       return ((pdo >> PDO_PPS_APDO_MIN_VOLT_SHIFT) &
> +               PDO_PPS_APDO_VOLT_MASK) * 100;
> +}
> +
> +static inline unsigned int pdo_pps_apdo_max_voltage(u32 pdo)
> +{
> +       return ((pdo >> PDO_PPS_APDO_MAX_VOLT_SHIFT) &
> +               PDO_PPS_APDO_VOLT_MASK) * 100;
> +}
> +
> +static inline unsigned int pdo_pps_apdo_max_current(u32 pdo)
> +{
> +       return ((pdo >> PDO_PPS_APDO_MAX_CURR_SHIFT) &
> +               PDO_PPS_APDO_CURR_MASK) * 50;
> +}
> +
> +/* RDO: Request Data Object */
> +#define RDO_OBJ_POS_SHIFT      28
> +#define RDO_OBJ_POS_MASK       0x7
> +#define RDO_GIVE_BACK          BIT(27) /* Supports reduced operating current */
> +#define RDO_CAP_MISMATCH       BIT(26) /* Not satisfied by source caps */
> +#define RDO_USB_COMM           BIT(25) /* USB communications capable */
> +#define RDO_NO_SUSPEND         BIT(24) /* USB Suspend not supported */
> +
> +#define RDO_PWR_MASK                   0x3ff
> +#define RDO_CURR_MASK                  0x3ff
> +
> +#define RDO_FIXED_OP_CURR_SHIFT                10
> +#define RDO_FIXED_MAX_CURR_SHIFT       0
> +
> +#define RDO_OBJ(idx) (((idx) & RDO_OBJ_POS_MASK) << RDO_OBJ_POS_SHIFT)
> +
> +#define PDO_FIXED_OP_CURR(ma) ((((ma) / 10) & RDO_CURR_MASK) << RDO_FIXED_OP_CURR_SHIFT)
> +#define PDO_FIXED_MAX_CURR(ma) ((((ma) / 10) & RDO_CURR_MASK) << RDO_FIXED_MAX_CURR_SHIFT)
> +
> +#define RDO_FIXED(idx, op_ma, max_ma, flags)                   \
> +       (RDO_OBJ(idx) | (flags) |                               \
> +        PDO_FIXED_OP_CURR(op_ma) | PDO_FIXED_MAX_CURR(max_ma))
> +
> +#define RDO_BATT_OP_PWR_SHIFT          10      /* 250mW units */
> +#define RDO_BATT_MAX_PWR_SHIFT         0       /* 250mW units */
> +
> +#define RDO_BATT_OP_PWR(mw) ((((mw) / 250) & RDO_PWR_MASK) << RDO_BATT_OP_PWR_SHIFT)
> +#define RDO_BATT_MAX_PWR(mw) ((((mw) / 250) & RDO_PWR_MASK) << RDO_BATT_MAX_PWR_SHIFT)
> +
> +#define RDO_BATT(idx, op_mw, max_mw, flags)                    \
> +       (RDO_OBJ(idx) | (flags) |                               \
> +        RDO_BATT_OP_PWR(op_mw) | RDO_BATT_MAX_PWR(max_mw))
> +
> +#define RDO_PROG_VOLT_MASK     0x7ff
> +#define RDO_PROG_CURR_MASK     0x7f
> +
> +#define RDO_PROG_VOLT_SHIFT    9
> +#define RDO_PROG_CURR_SHIFT    0
> +
> +#define RDO_PROG_VOLT_MV_STEP  20
> +#define RDO_PROG_CURR_MA_STEP  50
> +
> +#define PDO_PROG_OUT_VOLT(mv)  \
> +       ((((mv) / RDO_PROG_VOLT_MV_STEP) & RDO_PROG_VOLT_MASK) << RDO_PROG_VOLT_SHIFT)
> +#define PDO_PROG_OP_CURR(ma)   \
> +       ((((ma) / RDO_PROG_CURR_MA_STEP) & RDO_PROG_CURR_MASK) << RDO_PROG_CURR_SHIFT)
> +
> +#define RDO_PROG(idx, out_mv, op_ma, flags)                    \
> +       (RDO_OBJ(idx) | (flags) |                               \
> +        PDO_PROG_OUT_VOLT(out_mv) | PDO_PROG_OP_CURR(op_ma))
> +
> +static inline unsigned int rdo_index(u32 rdo)
> +{
> +       return (rdo >> RDO_OBJ_POS_SHIFT) & RDO_OBJ_POS_MASK;
> +}
> +
> +static inline unsigned int rdo_op_current(u32 rdo)
> +{
> +       return ((rdo >> RDO_FIXED_OP_CURR_SHIFT) & RDO_CURR_MASK) * 10;
> +}
> +
> +static inline unsigned int rdo_max_current(u32 rdo)
> +{
> +       return ((rdo >> RDO_FIXED_MAX_CURR_SHIFT) &
> +               RDO_CURR_MASK) * 10;
> +}
> +
> +static inline unsigned int rdo_op_power(u32 rdo)
> +{
> +       return ((rdo >> RDO_BATT_OP_PWR_SHIFT) & RDO_PWR_MASK) * 250;
> +}
> +
> +static inline unsigned int rdo_max_power(u32 rdo)
> +{
> +       return ((rdo >> RDO_BATT_MAX_PWR_SHIFT) & RDO_PWR_MASK) * 250;
> +}
> +
> +/* Enter_USB Data Object */
> +#define EUDO_USB_MODE_MASK             GENMASK(30, 28)
> +#define EUDO_USB_MODE_SHIFT            28
> +#define   EUDO_USB_MODE_USB2           0
> +#define   EUDO_USB_MODE_USB3           1
> +#define   EUDO_USB_MODE_USB4           2
> +#define EUDO_USB4_DRD                  BIT(26)
> +#define EUDO_USB3_DRD                  BIT(25)
> +#define EUDO_CABLE_SPEED_MASK          GENMASK(23, 21)
> +#define EUDO_CABLE_SPEED_SHIFT         21
> +#define   EUDO_CABLE_SPEED_USB2                0
> +#define   EUDO_CABLE_SPEED_USB3_GEN1   1
> +#define   EUDO_CABLE_SPEED_USB4_GEN2   2
> +#define   EUDO_CABLE_SPEED_USB4_GEN3   3
> +#define EUDO_CABLE_TYPE_MASK           GENMASK(20, 19)
> +#define EUDO_CABLE_TYPE_SHIFT          19
> +#define   EUDO_CABLE_TYPE_PASSIVE      0
> +#define   EUDO_CABLE_TYPE_RE_TIMER     1
> +#define   EUDO_CABLE_TYPE_RE_DRIVER    2
> +#define   EUDO_CABLE_TYPE_OPTICAL      3
> +#define EUDO_CABLE_CURRENT_MASK                GENMASK(18, 17)
> +#define EUDO_CABLE_CURRENT_SHIFT       17
> +#define   EUDO_CABLE_CURRENT_NOTSUPP   0
> +#define   EUDO_CABLE_CURRENT_3A                2
> +#define   EUDO_CABLE_CURRENT_5A                3
> +#define EUDO_PCIE_SUPPORT              BIT(16)
> +#define EUDO_DP_SUPPORT                        BIT(15)
> +#define EUDO_TBT_SUPPORT               BIT(14)
> +#define EUDO_HOST_PRESENT              BIT(13)
> +
> +/* USB PD timers and counters */
> +#define PD_T_NO_RESPONSE       5000    /* 4.5 - 5.5 seconds */
> +#define PD_T_DB_DETECT         10000   /* 10 - 15 seconds */
> +#define PD_T_SEND_SOURCE_CAP   150     /* 100 - 200 ms */
> +#define PD_T_SENDER_RESPONSE   60      /* 24 - 30 ms, relaxed */
> +#define PD_T_RECEIVER_RESPONSE 15      /* 15ms max */
> +#define PD_T_SOURCE_ACTIVITY   45
> +#define PD_T_SINK_ACTIVITY     135
> +#define PD_T_SINK_WAIT_CAP     310     /* 310 - 620 ms */
> +#define PD_T_PS_TRANSITION     500
> +#define PD_T_SRC_TRANSITION    35
> +#define PD_T_DRP_SNK           40
> +#define PD_T_DRP_SRC           30
> +#define PD_T_PS_SOURCE_OFF     920
> +#define PD_T_PS_SOURCE_ON      480
> +#define PD_T_PS_SOURCE_ON_PRS  450     /* 390 - 480ms */
> +#define PD_T_PS_HARD_RESET     30
> +#define PD_T_SRC_RECOVER       760
> +#define PD_T_SRC_RECOVER_MAX   1000
> +#define PD_T_SRC_TURN_ON       275
> +#define PD_T_SAFE_0V           650
> +#define PD_T_VCONN_SOURCE_ON   100
> +#define PD_T_SINK_REQUEST      100     /* 100 ms minimum */
> +#define PD_T_ERROR_RECOVERY    100     /* minimum 25 is insufficient */
> +#define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
> +#define PD_T_NEWSRC            250     /* Maximum of 275ms */
> +#define PD_T_SWAP_SRC_START    20      /* Minimum of 20ms */
> +#define PD_T_BIST_CONT_MODE    50      /* 30 - 60 ms */
> +#define PD_T_SINK_TX           16      /* 16 - 20 ms */
> +#define PD_T_CHUNK_NOT_SUPP    42      /* 40 - 50 ms */
> +
> +#define PD_T_DRP_TRY           100     /* 75 - 150 ms */
> +#define PD_T_DRP_TRYWAIT       600     /* 400 - 800 ms */
> +
> +#define PD_T_CC_DEBOUNCE       200     /* 100 - 200 ms */
> +#define PD_T_PD_DEBOUNCE       20      /* 10 - 20 ms */
> +#define PD_T_TRY_CC_DEBOUNCE   15      /* 10 - 20 ms */
> +
> +#define PD_N_CAPS_COUNT                (PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
> +#define PD_N_HARD_RESET_COUNT  1
> +
> +#define PD_P_SNK_STDBY_MW      2500    /* 2500 mW */
> +
> +/* Time to wait for TCPC to complete transmit */
> +#define PD_T_TCPC_TX_TIMEOUT   100     /* in ms        */
> +
> +#endif /* __LINUX_USB_PD_H */
> diff --git a/include/usb/tcpm.h b/include/usb/tcpm.h
> new file mode 100644
> index 000000000000..4574a5175ddb
> --- /dev/null
> +++ b/include/usb/tcpm.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2015-2017 Google, Inc
> + * Copyright 2024 Collabora
> + */
> +
> +#ifndef __LINUX_USB_TCPM_H
> +#define __LINUX_USB_TCPM_H
> +
> +#include <dm/of.h>
> +#include <linux/bitops.h>
> +#include "pd.h"
> +
> +enum typec_orientation {
> +       TYPEC_ORIENTATION_NONE,
> +       TYPEC_ORIENTATION_NORMAL,
> +       TYPEC_ORIENTATION_REVERSE,
> +};
> +
> +enum typec_cc_status {
> +       TYPEC_CC_OPEN,
> +       TYPEC_CC_RA,
> +       TYPEC_CC_RD,
> +       TYPEC_CC_RP_DEF,
> +       TYPEC_CC_RP_1_5,
> +       TYPEC_CC_RP_3_0,
> +};
> +
> +enum typec_cc_polarity {
> +       TYPEC_POLARITY_CC1,
> +       TYPEC_POLARITY_CC2,
> +};
> +
> +enum tcpm_transmit_status {
> +       TCPC_TX_SUCCESS = 0,
> +       TCPC_TX_DISCARDED = 1,
> +       TCPC_TX_FAILED = 2,
> +};
> +
> +enum tcpm_transmit_type {
> +       TCPC_TX_SOP = 0,
> +       TCPC_TX_SOP_PRIME = 1,
> +       TCPC_TX_SOP_PRIME_PRIME = 2,
> +       TCPC_TX_SOP_DEBUG_PRIME = 3,
> +       TCPC_TX_SOP_DEBUG_PRIME_PRIME = 4,
> +       TCPC_TX_HARD_RESET = 5,
> +       TCPC_TX_CABLE_RESET = 6,
> +       TCPC_TX_BIST_MODE_2 = 7
> +};
> +
> +struct dm_tcpm_ops {
> +       int (*get_connector_node)(struct udevice *dev, ofnode *connector_node);
> +       int (*init)(struct udevice *dev);
> +       int (*get_vbus)(struct udevice *dev);
> +       int (*set_cc)(struct udevice *dev, enum typec_cc_status cc);
> +       int (*get_cc)(struct udevice *dev, enum typec_cc_status *cc1,
> +                     enum typec_cc_status *cc2);
> +       int (*set_polarity)(struct udevice *dev,
> +                           enum typec_cc_polarity polarity);
> +       int (*set_vconn)(struct udevice *dev, bool on);
> +       int (*set_vbus)(struct udevice *dev, bool on, bool charge);
> +       int (*set_pd_rx)(struct udevice *dev, bool on);
> +       int (*set_roles)(struct udevice *dev, bool attached,
> +                        enum typec_role role, enum typec_data_role data);
> +       int (*start_toggling)(struct udevice *dev,
> +                             enum typec_port_type port_type,
> +                             enum typec_cc_status cc);
> +       int (*pd_transmit)(struct udevice *dev, enum tcpm_transmit_type type,
> +                          const struct pd_message *msg, unsigned int negotiated_rev);
> +       void (*poll_event)(struct udevice *dev);
> +       int (*enter_low_power_mode)(struct udevice *dev, bool attached, bool pd_capable);
> +};
> +
> +/* API for drivers */
> +void tcpm_vbus_change(struct udevice *dev);
> +void tcpm_cc_change(struct udevice *dev);
> +void tcpm_pd_receive(struct udevice *dev, const struct pd_message *msg);
> +void tcpm_pd_transmit_complete(struct udevice *dev,
> +                              enum tcpm_transmit_status status);
> +void tcpm_pd_hard_reset(struct udevice *dev);
> +
> +/* API for boards */
> +extern const char * const typec_pd_rev_name[];
> +extern const char * const typec_orientation_name[];
> +extern const char * const typec_role_name[];
> +extern const char * const typec_data_role_name[];
> +extern const char * const typec_cc_status_name[];
> +
> +int tcpm_get(const char *name, struct udevice **devp);
> +int tcpm_get_pd_rev(struct udevice *dev);
> +int tcpm_get_current(struct udevice *dev);
> +int tcpm_get_voltage(struct udevice *dev);
> +enum typec_orientation tcpm_get_orientation(struct udevice *dev);
> +enum typec_role tcpm_get_pwr_role(struct udevice *dev);
> +enum typec_data_role tcpm_get_data_role(struct udevice *dev);
> +bool tcpm_is_connected(struct udevice *dev);
> +const char *tcpm_get_state(struct udevice *dev);
> +
> +#endif /* __LINUX_USB_TCPM_H */

> --
> 2.45.2
>
