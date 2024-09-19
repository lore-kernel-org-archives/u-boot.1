Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44991CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E18789209;
	Thu, 19 Sep 2024 16:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/cV84iF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A1C58919B; Thu, 19 Sep 2024 16:10:42 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB67C891FA
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db4f323b12so485160a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755037; x=1727359837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d+pfqLDFmYVwUQzZLI+NVzEfWt7+Mcv0hdjkz1XIaNI=;
 b=V/cV84iFPQiieLktr+c0tSh8q8vu89fg0hA3yBozIJ9o8ITvhTRN2UEXJy9f3QTNng
 4WsRE3o38rZggKz8oz9y2IFziJzB+G9QY5ypcXEz9ayUAXdIpaGMgHExEYWDLSQuPKwn
 XmankkZYJ6Fz5zQoRc0HBJZWWEsa/csNvUpXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755037; x=1727359837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+pfqLDFmYVwUQzZLI+NVzEfWt7+Mcv0hdjkz1XIaNI=;
 b=Id2EGpO3wk5HL7NzAiRsEpBi2e/WrFplNVzs39O9CC6kAbgWSbc0g83CL+N1rH3uw/
 SPUTY4eTlqOZNtOp0dkZd0xb/VQ3U9y3hyHSh1DMsHwf/1Jjt/ljdzf574Aio8DgbLuG
 apBeFI+cJcAfnU8MOciyLjBpNW1d+5FYrDordQwTeYQ1ZGjY6qymQ7RnxI3jnFFnUSjP
 2PlODQ6INcX595Q+xa20VDIy8L1TfCKk3x5Rml0cTgHr/YEPQhxNKvMzftrdByIqkQTT
 bNqNAgdu1bKr2KgELoUeyf2fLfKoQcfsJNsdCAX7PX81XyX3Yw4Mqs3wQwhHCbowGk9P
 XtZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz3MyX+6ZzBaEf3nUQfCea7O0xKQwJ4Jo9erXaxhnJafjzBdTY3N70Oyw99HGxhwgqYgO/Mo4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+o/KTQ4bYcMxyCtuUFOUt8VCMjOr76FtMIJZOnKVpfbj9B8TN
 rjSu/eZDEIwia7bWiR1WtQxmqg7ygUUGRNL5VvLMBiCSETvUdu3Ib2pgjocsO8m41wP5IEetUcz
 fLzyqZ6UkIHUH2a2tErKXya8G7X65Cp4/o4dK
X-Google-Smtp-Source: AGHT+IEeosko2aYveIhDgPp/fSdvygSv9cjwGeMw/N1oM4vMen66M2fypfeAZDljMlu10my4l18lkrXUFqt2/tQqJsw=
X-Received: by 2002:a17:90a:e20a:b0:2dd:66a8:8ab6 with SMTP id
 98e67ed59e1d1-2dd66a89a1dmr5038628a91.13.1726755037392; Thu, 19 Sep 2024
 07:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-11-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThqbdJ6XuivxXBvc6N1rFX=oZsp-Tt-2N_c11y2Aj1JOA@mail.gmail.com>
 <680515ee-58fe-49dc-b7f3-53478d23b9c2@genexis.eu>
In-Reply-To: <680515ee-58fe-49dc-b7f3-53478d23b9c2@genexis.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:15 +0200
Message-ID: <CAFLszTiZMkxCGdDwxG5YeSmmHDYRPVeF0FaFagra9imSno_PPw@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] net/netcat: add netcat over tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
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

Hi Mikhail,

On Sun, 15 Sept 2024 at 09:06, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
>
> On 12.09.2024 03:59, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> This patch adds downloading/uploading of data with netcat.
> >> Client/server mode both supported.
> >>
> >> How to test:
> >> ============
> >>   netcat-openbsd=1.219-1 from debian were used for a tests
> >>
> >>   a) Load data from remote host.
> >>        * U-Boot listen on tcp port 3456
> >>        * PC connects
> >>
> >>      u-boot: netcat load ${loadaddr} 3456
> >>      PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb
> >>
> >>   b) Load data from remote host.
> >>        * PC listen on tcp port 3456
> >>        * U-Boot connects
> >>
> >>      PC:     netcat -q1 -l -p 3456 < image.itb
> >>      u-boot: netcat load ${loadaddr} ${PC_IP}:3456
> >>
> >>   c) Save data to remote host
> >>        * U-Boot listen on tcp port 3456
> >>        * PC connects
> >>
> >>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
> >>      PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb
> >>
> >>   d) Save data to remote host
> >>        * PC listen on tcp port 3456
> >>        * U-Boot connects
> >>
> >>      PC:     netcat -w1 -l -p 3456 >image.itb
> >>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  cmd/Kconfig          |   7 ++
> >>  cmd/net.c            |  34 ++++++--
> >>  include/net.h        |   2 +-
> >>  include/net/netcat.h |  20 +++++
> >>  net/Makefile         |   1 +
> >>  net/net.c            |   9 +++
> >>  net/netcat.c         | 181 +++++++++++++++++++++++++++++++++++++++++++
> >>  7 files changed, 248 insertions(+), 6 deletions(-)
> >>  create mode 100644 include/net/netcat.h
> >>  create mode 100644 net/netcat.c
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Can/should I add this "Reviewed-by" to the next patch version?

Yes

>
> >
> > nits below
> >
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index 978f44eda42..abcd003f7f1 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -2007,6 +2007,13 @@ config CMD_WGET
> >>           wget is a simple command to download kernel, or other files,
> >>           from a http server over TCP.
> >>
> >> +config CMD_NETCAT
> >> +       bool "netcat"
> >> +       select PROT_TCP
> >> +       help
> >> +         netcat is a simple command to load/store kernel, or other files,
> >> +         using netcat like manner over TCP.
> > netcat-like
> >
> > Please add a reference to the protocol or the 'netcat' tool or both.
> > Help must be at least 3 lines.
>
> Netcat (https://en.wikipedia.org/wiki/Netcat)  uses plain TCP/UDP for
> data delivery. In the TCP case, TCP by itself provides reliable,
> ordered, and error-checked data delivery, so no additional protocols are
> required.
>
> Is it enough to write the following description?
>
> netcat is a simple command to load/store kernel, or other files,
> using well-known netcat (nc) utility. Unlike classic netcat utility
> this command supports TCP-based data transfer only, thus no data
> will be lost or reordered. Any netcat implementation should work,
> but openbsd one was tested only.

Yes, thanks

>
>
> >> +
> >>  config CMD_MII
> >>         bool "mii"
> >>         imply CMD_MDIO
> >> diff --git a/cmd/net.c b/cmd/net.c
> >> index 53ce2bc5d0c..364139ec5b9 100644
> >> --- a/cmd/net.c
> >> +++ b/cmd/net.c
> >> @@ -206,6 +206,28 @@ U_BOOT_CMD(
> >>  );
> >>  #endif
> >>
> >> +#if defined(CONFIG_CMD_NETCAT)
> >> +static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >> +{
> >> +       if (argc < 2)
> >> +               return 1;
> >> +
> >> +       if (!strcmp(argv[1], "load"))
> >> +               return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
> >> +       else if (!strcmp(argv[1], "save"))
> >> +               return netboot_common(NETCAT_SAVE, cmdtp, argc - 1, argv + 1);
> >> +       else
> >> +               return 1;
> >> +}
> >> +
> > Needs longhelp
> Could you explain? Usage examples?

I just mean something like this:

U_BOOT_LONGHELP(bootmeth,
        "list [-a]     - list available bootmeths (-a all)\n"
        "bootmeth order [<bd> ...]  - select bootmeth order / subset to use");

That example is from bootmeth.c

> >
> >> +U_BOOT_CMD(
> >> +       netcat,   5,      1,      do_netcat,
> >> +       "load/store data via tcp netcat utility",
> >> +       "load [loadAddress] [[hostIPaddr:]port]\n"
> >> +       "save Address Size [[hostIPaddr:]port]\n"
> >> +);
> >> +#endif
> >> +
> >>  static void netboot_update_env(void)
> >>  {
> >>         char tmp[46];
> >> @@ -323,16 +345,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
> >>
> >>         switch (argc) {
> >>         case 1:
> >> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
> >> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> >> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
> >>                         return 1;
> >> -
> >>                 /* refresh bootfile name from env */
> >>                 copy_filename(net_boot_file_name, env_get("bootfile"),
> >>                               sizeof(net_boot_file_name));
> >>                 break;
> >>
> >>         case 2:
> >> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
> >> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> >> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
> >>                         return 1;
> >>                 /*
> >>                  * Only one arg - accept two forms:
> >> @@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
> >>                 break;
> >>
> >>         case 3:
> >> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
> >> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> >> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
> >>                         if (parse_addr_size(argv))
> >>                                 return 1;
> >>                 } else {
> >> @@ -365,7 +389,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
> >>                 }
> >>                 break;
> >>
> >> -#ifdef CONFIG_CMD_TFTPPUT
> >> +#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
> >>         case 4:
> >>                 if (parse_addr_size(argv))
> >>                         return 1;
> >> diff --git a/include/net.h b/include/net.h
> >> index b0ce13e0a9d..0af6493788a 100644
> >> --- a/include/net.h
> >> +++ b/include/net.h
> >> @@ -515,7 +515,7 @@ extern int          net_restart_wrap;       /* Tried all network devices */
> >>  enum proto_t {
> >>         BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
> >>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
> >> -       WOL, UDP, NCSI, WGET, RS
> >> +       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
> >>  };
> >>
> >>  extern char    net_boot_file_name[1024];/* Boot File name */
> >> diff --git a/include/net/netcat.h b/include/net/netcat.h
> >> new file mode 100644
> >> index 00000000000..d8e09aaaa55
> >> --- /dev/null
> >> +++ b/include/net/netcat.h
> >> @@ -0,0 +1,20 @@
> >> +/* SPDX-License-Identifier: BSD-2-Clause
> >> + *
> >> + * netcat include file
> >> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> >> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> + */
> >> +#ifndef __NET_NETCAT_TCP_H__
> >> +#define __NET_NETCAT_TCP_H__
> >> +
> >> +/**
> >> + * netcat_load_start() - begin netcat in loading mode
> >> + */
> >> +void netcat_load_start(void);
> >> +
> >> +/**
> >> + * netcat_save_start() - begin netcat in data saving mode
> >> + */
> >> +void netcat_save_start(void);
> >> +
> >> +#endif /* __NET_NETCAT_TCP_H__ */
> >> diff --git a/net/Makefile b/net/Makefile
> >> index 64ab7ec740a..dac7b4859fb 100644
> >> --- a/net/Makefile
> >> +++ b/net/Makefile
> >> @@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
> >>  obj-$(CONFIG_PROT_UDP) += udp.o
> >>  obj-$(CONFIG_PROT_TCP) += tcp.o
> >>  obj-$(CONFIG_CMD_WGET) += wget.o
> >> +obj-$(CONFIG_CMD_NETCAT) += netcat.o
> >>
> >>  # Disable this warning as it is triggered by:
> >>  # sprintf(buf, index ? "foo%d" : "foo", index)
> >> diff --git a/net/net.c b/net/net.c
> >> index 86182cc504e..d81604a57ce 100644
> >> --- a/net/net.c
> >> +++ b/net/net.c
> >> @@ -108,6 +108,7 @@
> >>  #include <test/test.h>
> >>  #include <net/tcp.h>
> >>  #include <net/wget.h>
> >> +#include <net/netcat.h>
> > That should be above net/tcp
>
> Is there any reasons?
>
> Should I move <net/wget.h> as well?

Oh, yes, net/xxx should be before test/xxx

See here: https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

[..]

Regards,
Simon
