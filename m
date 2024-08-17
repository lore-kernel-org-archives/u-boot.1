Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B950C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 16:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928B288C7C;
	Sat, 17 Aug 2024 17:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mEOfk2xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616E1886F9; Sat, 17 Aug 2024 17:58:43 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BD788C7C
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5e1c86b83so1885777eaf.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910317; x=1724515117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YmG83dBWOcdnVoZlgwFLS+z2yJ33+Xx3DQsNwV7EtGE=;
 b=mEOfk2xdk7JS0yzhfsm2cAsO7egQAo+FRGrFAYEFhWyqmAMJvekcO7LSWczaBl16sg
 k1TYWsMPt6Q0LO2VvargYMW/5nxha2F6OTGgG+eOeumi5LeSJreA8soj7MJgd3W0fs+q
 njvBz6gOzO2EmLjRDCkNbqdSlOdkRBapYFfSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910317; x=1724515117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmG83dBWOcdnVoZlgwFLS+z2yJ33+Xx3DQsNwV7EtGE=;
 b=XI8jmwJSPXycdCHb9IMPQ79lyyitAz9wr+a/CoynQUwLj9OHu2Bl8D9+InrIAX/ix3
 0h/v9hB5a8FMBwH6ehBcx4IRgtEgUXW4ghgrlVWebarlumDt924Y4LbsFy6B1iGjAlac
 GeQWs6skhLcMoc7/9o7PYynTPhsS4+pUYeivcfh5oIJFjyq0WCcvpzSWJzZpWOt67nmo
 BXhf6jipE6DrNNVzpkBNqvQmSIjUqoNBoxEldFRTHc0Qp6GXUO6b1t0tomhhF0JVQ1q6
 PV7l40Q5T9ZPjpmXRizYWjZAN6Hrq1kByQoELgZ5gjxrAO+1J3IqMJ/SN4KK6fNHZGU9
 4G3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7NQdHTNuiZR0AHczw5Ahlwc3JBZWX10h5GDuXnk6zzVevNnZjayJPc9nmoqR2FJtpJFQoYu7VUWRReA5S5KYzF8OOqA==
X-Gm-Message-State: AOJu0YwAhlr/6AcLWYFiVRqE4P2mfllqzFoXNJbirdNhLVRM074/7xAa
 HDqOOvMq158T8N398MEgfZ3b7RUS+PAqe8l3ybOiDUDtGLhTcnHh99OHk7SDRRl/XlQ9VRRwrtq
 fRgl4k5Np5NWVibWJ1qPmClUfl84vnLoyI9We
X-Google-Smtp-Source: AGHT+IHbg7vielynm5FHUAH9LZQq3khadoEtDR2cg6erQOCqAEP18lYsa4WZOY5lAReTvWwyrTAdx3XPLFkjWejVp5M=
X-Received: by 2002:a05:6358:7f13:b0:1af:15b5:7ca0 with SMTP id
 e5c5f4694b2df-1b39313efd1mr828953155d.6.1723910317527; Sat, 17 Aug 2024
 08:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-10-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-10-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:27 -0600
Message-ID: <CAFLszTi0bqtbKNss6AH58EdjN+7f-wK977PjBborZNdbCTCsPg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 9/9] net/netcat: add netcat over tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch adds downloading/uploading of data with netcat.
> Client/server mode both supported.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/Kconfig          |   7 ++
>  cmd/net.c            |  34 +++++++--
>  include/net.h        |   2 +-
>  include/net/netcat.h |  20 ++++++
>  net/Makefile         |   1 +
>  net/net.c            |   9 +++
>  net/netcat.c         | 159 +++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 226 insertions(+), 6 deletions(-)
>  create mode 100644 include/net/netcat.h
>  create mode 100644 net/netcat.c

Is there a way to test this?

>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda42..abcd003f7f1 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2007,6 +2007,13 @@ config CMD_WGET
>           wget is a simple command to download kernel, or other files,
>           from a http server over TCP.
>
> +config CMD_NETCAT
> +       bool "netcat"
> +       select PROT_TCP
> +       help
> +         netcat is a simple command to load/store kernel, or other files,
> +         using netcat like manner over TCP.
> +
>  config CMD_MII
>         bool "mii"
>         imply CMD_MDIO
> diff --git a/cmd/net.c b/cmd/net.c
> index 53ce2bc5d0c..6ac81415f8a 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -206,6 +206,28 @@ U_BOOT_CMD(
>  );
>  #endif
>
> +#if defined(CONFIG_CMD_NETCAT)
> +static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       if (argc < 2)
> +               return 1;
> +
> +       if (strcmp(argv[1], "load") == 0)

!strcmp

> +               return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
> +       else if (strcmp(argv[1], "store") == 0)

We normally use 'save' in U-Boot.

> +               return netboot_common(NETCAT_STORE, cmdtp, argc - 1, argv + 1);
> +       else
> +               return 1;
> +}
> +
> +U_BOOT_CMD(
> +       netcat,   5,      1,      do_netcat,
> +       "load/store data via tcp netcat utility",
> +       "load [loadAddress] [[hostIPaddr:]port]\n"
> +       "store Address Size [[hostIPaddr:]port]\n"
> +);
> +#endif
> +
>  static void netboot_update_env(void)
>  {
>         char tmp[46];
> @@ -323,16 +345,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>
>         switch (argc) {
>         case 1:
> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE))
>                         return 1;
> -
>                 /* refresh bootfile name from env */
>                 copy_filename(net_boot_file_name, env_get("bootfile"),
>                               sizeof(net_boot_file_name));
>                 break;
>
>         case 2:
> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE))
>                         return 1;
>                 /*
>                  * Only one arg - accept two forms:
> @@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>                 break;
>
>         case 3:
> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE)) {
>                         if (parse_addr_size(argv))
>                                 return 1;
>                 } else {
> @@ -365,7 +389,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>                 }
>                 break;
>
> -#ifdef CONFIG_CMD_TFTPPUT
> +#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
>         case 4:
>                 if (parse_addr_size(argv))
>                         return 1;
> diff --git a/include/net.h b/include/net.h
> index b0ce13e0a9d..5ec826209f0 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -515,7 +515,7 @@ extern int          net_restart_wrap;       /* Tried all network devices */
>  enum proto_t {
>         BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
> -       WOL, UDP, NCSI, WGET, RS
> +       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, RS
>  };
>
>  extern char    net_boot_file_name[1024];/* Boot File name */
> diff --git a/include/net/netcat.h b/include/net/netcat.h
> new file mode 100644
> index 00000000000..09470e7f0ce
> --- /dev/null
> +++ b/include/net/netcat.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: BSD-2-Clause
> + *
> + * netcat include file
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +#ifndef __NET_NETCAT_TCP_H__
> +#define __NET_NETCAT_TCP_H__
> +
> +/**
> + * netcat_load_start() - begin netcat in loading mode
> + */
> +void netcat_load_start(void);
> +
> +/**
> + * netcat_store_start() - begin netcat in data storing mode
> + */
> +void netcat_store_start(void);
> +
> +#endif /* __NET_NETCAT_TCP_H__ */
> diff --git a/net/Makefile b/net/Makefile
> index 64ab7ec740a..dac7b4859fb 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
>  obj-$(CONFIG_PROT_UDP) += udp.o
>  obj-$(CONFIG_PROT_TCP) += tcp.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
> +obj-$(CONFIG_CMD_NETCAT) += netcat.o
>
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net/net.c b/net/net.c
> index 86182cc504e..0e05a8f2336 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -108,6 +108,7 @@
>  #include <test/test.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
> +#include <net/netcat.h>
>  #include "arp.h"
>  #include "bootp.h"
>  #include "cdp.h"
> @@ -564,6 +565,14 @@ restart:
>                         wget_start();
>                         break;
>  #endif
> +#if defined(CONFIG_CMD_NETCAT)
> +               case NETCAT_LOAD:
> +                       netcat_load_start();
> +                       break;
> +               case NETCAT_STORE:
> +                       netcat_store_start();
> +                       break;
> +#endif
>  #if defined(CONFIG_CMD_CDP)
>                 case CDP:
>                         cdp_start();
> diff --git a/net/netcat.c b/net/netcat.c
> new file mode 100644
> index 00000000000..ea225c68c87
> --- /dev/null
> +++ b/net/netcat.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * netcat support driver
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <command.h>
> +#include <display_options.h>
> +#include <env.h>
> +#include <image.h>
> +#include <mapmem.h>
> +#include <net.h>
> +#include <net/tcp.h>
> +#include <net/netcat.h>
> +
> +#define HASHES_PER_LINE                65
> +
> +static struct in_addr          server_ip;
> +static u16                     server_port;
> +static u16                     local_port;
> +static int                     listen;
> +static int                     reading;
> +static unsigned int            packets;
> +static enum net_loop_state     netcat_loop_state;
> +
> +static void show_block_marker(void)
> +{
> +       if ((packets % 10) == 0)
> +               putc('#');
> +       else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
> +               puts("\n");
> +}
> +
> +static void tcp_stream_on_closed(struct tcp_stream *tcp)
> +{
> +       if (tcp->status != TCP_ERR_OK)
> +               netcat_loop_state = NETLOOP_FAIL;
> +
> +       if (netcat_loop_state != NETLOOP_SUCCESS)
> +               printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);

Can you add a comment as to why the \n is needed at the start?

> +       else
> +               printf("\nPackets %s %d, Transfer Successful\n",
> +                      reading ? "received" : "transmitted", packets);
> +       net_set_state(netcat_loop_state);
> +}
> +
> +static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
> +{
> +       net_boot_file_size = rx_bytes;
> +       show_block_marker();
> +}
> +
> +static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
> +{
> +       show_block_marker();
> +       if (tx_bytes == image_save_size)
> +               tcp_stream_close(tcp);
> +}
> +
> +static void tcp_stream_on_established(struct tcp_stream *tcp)
> +{
> +       netcat_loop_state = NETLOOP_SUCCESS;
> +}
> +
> +static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
> +{
> +       void *ptr;
> +
> +       packets++;
> +       ptr = map_sysmem(image_load_addr + rx_offs, len);
> +       memcpy(ptr, buf, len);
> +       unmap_sysmem(ptr);
> +       return len;
> +}
> +
> +static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
> +{
> +       void *ptr;
> +
> +       if (tx_offs + maxlen > image_save_size)
> +               maxlen = image_save_size - tx_offs;
> +       if (maxlen == 0)
> +               return 0;
> +
> +       packets++;
> +       ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
> +       memcpy(buf, ptr, maxlen);
> +       unmap_sysmem(ptr);
> +       return maxlen;
> +}
> +
> +static int tcp_stream_on_create(struct tcp_stream *tcp)

function comment

> +{
> +       if (listen) {
> +               if (tcp->lport != local_port)
> +                       return 0;
> +       } else {
> +               if ((tcp->rhost.s_addr != server_ip.s_addr) ||
> +                   (tcp->rport != server_port))
> +                       return 0;
> +       }
> +
> +       netcat_loop_state = NETLOOP_FAIL;
> +       net_boot_file_size = 0;
> +       packets = 0;
> +
> +       tcp->on_closed = tcp_stream_on_closed;
> +       tcp->on_established = tcp_stream_on_established;
> +       if (reading) {
> +               tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
> +               tcp->rx = tcp_stream_rx;
> +       } else {
> +               tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
> +               tcp->tx = tcp_stream_tx;
> +       }
> +       return 1;
> +}
> +
> +static void netcat_start(void)
> +{
> +       struct tcp_stream *tcp;
> +
> +       memset(net_server_ethaddr, 0, 6);
> +       tcp_stream_set_on_create_handler(tcp_stream_on_create);
> +
> +       if (strchr(net_boot_file_name, ':') == NULL) {
> +               listen = 1;
> +               printf("Listening on port %s...\n", net_boot_file_name);
> +
> +               local_port = dectoul(net_boot_file_name, NULL);
> +       } else {
> +               listen = 0;
> +               printf("Connecting to %s...\n", net_boot_file_name);
> +
> +               server_ip = string_to_ip(net_boot_file_name);
> +               server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
> +
> +               tcp = tcp_stream_connect(server_ip, server_port);
> +               if (tcp == NULL) {
> +                       printf("No free tcp streams\n");
> +                       net_set_state(NETLOOP_FAIL);
> +                       return;

should return an error code

> +               }
> +               tcp_stream_put(tcp);

This looks like a nice API!

> +       }
> +}
> +
> +void netcat_load_start(void)
> +{
> +       reading = 1;
> +       return netcat_start();
> +}
> +
> +void netcat_store_start(void)
> +{
> +       reading = 0;
> +       return netcat_start();
> +}
> --
> 2.39.2
>

Regards,
Simon
