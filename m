Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DCACDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D058186B71;
	Mon, 16 Oct 2023 16:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NDqnZngd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5AD86BA1; Mon, 16 Oct 2023 16:21:44 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C8286823
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.localnet (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id C0FBF66071C7;
 Mon, 16 Oct 2023 15:21:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697466100;
 bh=JS3+9rmYCLVYVJ4yRCDpVEkNSJozTgCGj2nfNddx9g4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NDqnZngdM5RC6KMNv9G8ulSz9pZ5eLm86BI5yQ5cXBZmRRlAVMZ//ca+W7lXhGGsI
 YXWV16xImp8dy7IS54IrdqsOYGnG4fbttM1V0cihRJoKky5XwtrCiDAVPz6wvVr6gy
 QdFfvk6Z3irkOfAt+3swz+fzdYikdCgAE1r4lWtUTc4qDY1B5RoiXbtNRa/QrQv8Gs
 WX5dGTUqYeqnd7vgwm8wqCK1Xeq0vHEEsWmj6XbhIXoJti0yZlGfThYezhFpdihaJg
 ECcaAi9c468xSvS2SufBFeFBgQNXF7SPummXVwPwIThAli40NYX+E2f7jsUueBUyEE
 xG/rPBe7BittA==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>
Subject: Re: [PATCH v5 2/6] cmd: Add a sysinfo command
Date: Mon, 16 Oct 2023 10:21:49 -0400
Message-ID: <12366510.O9o76ZdvQC@arisu>
In-Reply-To: <CAPnjgZ1s3OP6cq94qLF3mzkK6YwrjEFc91LOiUQWadj0NBZSqA@mail.gmail.com>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-3-detlev.casanova@collabora.com>
 <CAPnjgZ1s3OP6cq94qLF3mzkK6YwrjEFc91LOiUQWadj0NBZSqA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Monday, October 2, 2023 2:56:28 P.M. EDT Simon Glass wrote:
> On Mon, 2 Oct 2023 at 09:21, Detlev Casanova
> 
> <detlev.casanova@collabora.com> wrote:
> > The command is able to show different information for the running
> > system:
> > * Model name
> > * Board ID
> > * Revision
> > 
> > This command can be used by boot shell scripts to select configurations
> > depending on the specific running system.
> > 
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  cmd/Kconfig   |   6 +++
> >  cmd/Makefile  |   1 +
> >  cmd/sysinfo.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 140 insertions(+)
> >  create mode 100644 cmd/sysinfo.c
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Would prefer more help text in the Kconfig as this is pretty vague

Indeed, how would that sound ?

Display information to identify the system. It supports showing a board id, a 
revision number as well as a human readable name.

> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 43ca10f69cc..67d019aa795 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -218,6 +218,12 @@ config CMD_SBI
> > 
> >         help
> >         
> >           Display information about the SBI implementation.
> > 
> > +config CMD_SYSINFO
> > +       bool "sysinfo"
> > +       depends on SYSINFO
> > +       help
> > +         Display information about the system.
> > +
> > 
> >  endmenu
> >  
> >  menu "Boot commands"
> > 
> > diff --git a/cmd/Makefile b/cmd/Makefile
> > index 9bebf321c39..972f3a4720e 100644
> > --- a/cmd/Makefile
> > +++ b/cmd/Makefile
> > @@ -167,6 +167,7 @@ obj-$(CONFIG_CMD_SPI) += spi.o
> > 
> >  obj-$(CONFIG_CMD_STRINGS) += strings.o
> >  obj-$(CONFIG_CMD_SMC) += smccc.o
> >  obj-$(CONFIG_CMD_SYSBOOT) += sysboot.o
> > 
> > +obj-$(CONFIG_CMD_SYSINFO) += sysinfo.o
> > 
> >  obj-$(CONFIG_CMD_STACKPROTECTOR_TEST) += stackprot_test.o
> >  obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
> >  obj-$(CONFIG_CMD_TERMINAL) += terminal.o
> > 
> > diff --git a/cmd/sysinfo.c b/cmd/sysinfo.c
> > new file mode 100644
> > index 00000000000..46369ff9ac7
> > --- /dev/null
> > +++ b/cmd/sysinfo.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2023
> > + * Detlev Casanova <detlev.casanova@collabora.com>
> > + */
> > +
> > +#include <command.h>
> > +#include <env.h>
> > +#include <sysinfo.h>
> > +#include <exports.h>
> > +
> > +static int get_sysinfo(struct udevice **devp)
> > +{
> > +       int ret = sysinfo_get(devp);
> > +
> > +       if (ret) {
> > +               printf("Cannot get sysinfo: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = sysinfo_detect(*devp);
> > +       if (ret) {
> > +               printf("Cannot detect sysinfo: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int do_sysinfo_model(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                           char *const argv[])
> > +{
> > +       struct udevice *dev;
> > +       char model[64];
> > +       int ret = get_sysinfo(&dev);
> > +
> > +       if (ret)
> > +               return CMD_RET_FAILURE;
> > +
> > +       ret = sysinfo_get_str(dev,
> > +                             SYSINFO_ID_BOARD_MODEL,
> > +                             sizeof(model),
> > +                             model);
> > +       if (ret) {
> > +               printf("Cannot get sysinfo str: %d\n", ret);
> > +               return CMD_RET_FAILURE;
> > +       }
> > +
> > +       if (argc == 2)
> > +               ret = env_set(argv[1], model);
> > +       else
> > +               printf("%s\n", model);
> > +
> > +       if (ret)
> > +               return CMD_RET_FAILURE;
> > +       else
> > +               return CMD_RET_SUCCESS;
> > +}
> > +
> > +static int do_sysinfo_id(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                        char *const argv[])
> > +{
> > +       struct udevice *dev;
> > +       u32 board_id;
> > +       int ret = get_sysinfo(&dev);
> > +
> > +       if (ret)
> > +               return CMD_RET_FAILURE;
> > +
> > +       ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_ID, &board_id);
> > +       if (ret) {
> > +               printf("Cannot get sysinfo int: %d\n", ret);
> > +               return CMD_RET_FAILURE;
> > +       }
> > +
> > +       if (argc == 2)
> > +               ret = env_set_hex(argv[1], board_id);
> > +       else
> > +               printf("0x%02x\n", board_id);
> > +
> > +       if (ret)
> > +               return CMD_RET_FAILURE;
> > +       else
> > +               return CMD_RET_SUCCESS;
> > +}
> > +
> > +static int do_sysinfo_revision(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                              char *const argv[])
> > +{
> > +       struct udevice *dev;
> > +       int rev_major;
> > +       int rev_minor;
> > +       char rev[64];
> > +       int ret = get_sysinfo(&dev);
> > +
> > +       if (ret)
> > +               return CMD_RET_FAILURE;
> > +
> > +       ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_REV_MAJOR,
> > &rev_major);
> > +       if (ret) {
> > +               printf("Cannot get sysinfo int: %d\n", ret);
> > +               return CMD_RET_FAILURE;
> > +       }
> > +
> > +       ret = sysinfo_get_int(dev, SYSINFO_ID_BOARD_REV_MINOR,
> > &rev_minor);
> > +       if (ret) {
> > +               printf("Cannot get sysinfo int: %d\n", ret);
> > +               return CMD_RET_FAILURE;
> > +       }
> > +
> > +       snprintf(rev, sizeof(rev), "%d.%d", rev_major, rev_minor);
> > +
> > +       if (argc == 2)
> > +               ret = env_set(argv[1], rev);
> > +       else
> > +               printf("%s\n", rev);
> > +
> > +       if (ret)
> > +               return CMD_RET_FAILURE;
> > +       else
> > +               return CMD_RET_SUCCESS;
> > +}
> > +
> > +static char sysinfo_help_text[] =
> > +       "model <varname>     - Show or set the board model in varname\n"
> > +       "sysinfo id <varname>        - Show or set the board id in varname
> > (in format 0xHH)\n" +       "sysinfo revision <varname>  - Show or set
> > the board revision in varname"; +
> > +U_BOOT_CMD_WITH_SUBCMDS(sysinfo, "System information", sysinfo_help_text,
> > +                       U_BOOT_SUBCMD_MKENT(model, 2, 1,
> > do_sysinfo_model),
> > +                       U_BOOT_SUBCMD_MKENT(id, 2, 1, do_sysinfo_id),
> > +                       U_BOOT_SUBCMD_MKENT(revision, 2, 1,
> > do_sysinfo_revision), +);
> > --
> > 2.41.0




