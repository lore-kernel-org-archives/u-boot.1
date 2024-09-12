Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F52EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF9188DCB;
	Thu, 12 Sep 2024 03:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="diLR1s+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AACC88E02; Thu, 12 Sep 2024 03:00:30 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CD988DC6
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-719270b7c94so174692b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102821; x=1726707621; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mlkgwMW7Vl2Ya+sbaOjE+nKMOhieWzKs+D8Ve6OdqCU=;
 b=diLR1s+cDROu5CcqPnbL1cTcFxxid2eZQXZKJYKVLDT2amQkl+Ds6vffjgwuh1Cevx
 EuYZdG3Q0xJ5IbfbYIQ4o65Yjkbj2aZcF56VTuuK2YbFo4nAkJQculNXAywizCrw4eWh
 Xr4oC0wyd8BIuEZL9yDQeywd75i5i6EjkDiTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102821; x=1726707621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlkgwMW7Vl2Ya+sbaOjE+nKMOhieWzKs+D8Ve6OdqCU=;
 b=QrOeK1/o08JjhyuxZJ8mbKTBQ7yaMaHH8cD/hrSC5yflS2xRgS2zbv1R3kZmBiUwyh
 D65s6URDnG3t/sOVM93O8CClJAefr1Mm6lMk5ox8E2l3uB2SCYWcNjF5Nnljw9v/OPlL
 g6zyT8MazWQjegkEdQLasXn9inD0n9Ta+kTSqE67iP7m+8LFo4KmY8xyN0fvrP/5AsHH
 nRwfgu8ZdiTpvqyhBtvNV0ajYoP80kDvJ6uHBSqDFmz5k2CS3dxVslksfDqOmTM3+7vj
 8Lsuivp0S/PheGPqLgybZVJDXtNV3kG2jRobGOisUb29SESduePepx+hbhiKb0X87Z7T
 gRNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX60tVoA8NiC3GLsrfbnFn8tPpQKjJpBoylv2yJ2x04Z2H8phO12Szzeqq/n2To8dFr7eS0Pcg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy39c9b+HG9gBXOs0LnxfBzoRVeY8mGIixO0puO/Zi7fT11rYSt
 pTH4mUAfjlRIEtY5m9u1nPPChLMExLuaMuBw+dX2Ia7/XR2YuCrWpAZvKl2kPXjHRt3qOH4fM5V
 s+kEjI+yP1DRwgIb2blKPUqyv0fZvhfH/YbeI
X-Google-Smtp-Source: AGHT+IFH6WOflwPuO/ch/qUmktXp+/yovQGNaXUcy5ett7XrD7QN26c+LzG8dVJYq4D+gHCeb1XleqEnzd3bzV8maPE=
X-Received: by 2002:a05:6a00:22ca:b0:717:9120:35f with SMTP id
 d2e1a72fcca58-719261fc584mr1555677b3a.27.1726102821292; Wed, 11 Sep 2024
 18:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-11-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240909222720.2563118-11-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:55 -0600
Message-ID: <CAFLszThqbdJ6XuivxXBvc6N1rFX=oZsp-Tt-2N_c11y2Aj1JOA@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] net/netcat: add netcat over tcp support
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

On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch adds downloading/uploading of data with netcat.
> Client/server mode both supported.
>
> How to test:
> ============
>   netcat-openbsd=1.219-1 from debian were used for a tests
>
>   a) Load data from remote host.
>        * U-Boot listen on tcp port 3456
>        * PC connects
>
>      u-boot: netcat load ${loadaddr} 3456
>      PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb
>
>   b) Load data from remote host.
>        * PC listen on tcp port 3456
>        * U-Boot connects
>
>      PC:     netcat -q1 -l -p 3456 < image.itb
>      u-boot: netcat load ${loadaddr} ${PC_IP}:3456
>
>   c) Save data to remote host
>        * U-Boot listen on tcp port 3456
>        * PC connects
>
>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
>      PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb
>
>   d) Save data to remote host
>        * PC listen on tcp port 3456
>        * U-Boot connects
>
>      PC:     netcat -w1 -l -p 3456 >image.itb
>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/Kconfig          |   7 ++
>  cmd/net.c            |  34 ++++++--
>  include/net.h        |   2 +-
>  include/net/netcat.h |  20 +++++
>  net/Makefile         |   1 +
>  net/net.c            |   9 +++
>  net/netcat.c         | 181 +++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 248 insertions(+), 6 deletions(-)
>  create mode 100644 include/net/netcat.h
>  create mode 100644 net/netcat.c

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

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

netcat-like

Please add a reference to the protocol or the 'netcat' tool or both.
Help must be at least 3 lines.

> +
>  config CMD_MII
>         bool "mii"
>         imply CMD_MDIO
> diff --git a/cmd/net.c b/cmd/net.c
> index 53ce2bc5d0c..364139ec5b9 100644
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
> +       if (!strcmp(argv[1], "load"))
> +               return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
> +       else if (!strcmp(argv[1], "save"))
> +               return netboot_common(NETCAT_SAVE, cmdtp, argc - 1, argv + 1);
> +       else
> +               return 1;
> +}
> +

Needs longhelp

> +U_BOOT_CMD(
> +       netcat,   5,      1,      do_netcat,
> +       "load/store data via tcp netcat utility",
> +       "load [loadAddress] [[hostIPaddr:]port]\n"
> +       "save Address Size [[hostIPaddr:]port]\n"
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
> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
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
> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
>                         return 1;
>                 /*
>                  * Only one arg - accept two forms:
> @@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>                 break;
>
>         case 3:
> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
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
> index b0ce13e0a9d..0af6493788a 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -515,7 +515,7 @@ extern int          net_restart_wrap;       /* Tried all network devices */
>  enum proto_t {
>         BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
> -       WOL, UDP, NCSI, WGET, RS
> +       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
>  };
>
>  extern char    net_boot_file_name[1024];/* Boot File name */
> diff --git a/include/net/netcat.h b/include/net/netcat.h
> new file mode 100644
> index 00000000000..d8e09aaaa55
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
> + * netcat_save_start() - begin netcat in data saving mode
> + */
> +void netcat_save_start(void);
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
> index 86182cc504e..d81604a57ce 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -108,6 +108,7 @@
>  #include <test/test.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
> +#include <net/netcat.h>

That should be above net/tcp

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
> +               case NETCAT_SAVE:
> +                       netcat_save_start();
> +                       break;
> +#endif
>  #if defined(CONFIG_CMD_CDP)
>                 case CDP:
>                         cdp_start();
> diff --git a/net/netcat.c b/net/netcat.c
> new file mode 100644
> index 00000000000..633afe5c60b
> --- /dev/null
> +++ b/net/netcat.c
> @@ -0,0 +1,181 @@
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

else if (!((packets + 1) % (10 * HASHS_PER_LINE)))

but it would be nice if you could use 0x10 instead of 10 and masks
here to avoid division. Or perhaps it doesn't matter.

> +               puts("\n");
> +}
> +
> +static void tcp_stream_on_closed(struct tcp_stream *tcp)
> +{
> +       if (tcp->status != TCP_ERR_OK)
> +               netcat_loop_state = NETLOOP_FAIL;
> +
> +       /*
> +        * The status line will be shown after the download/upload
> +        * progress (see show_block_marker() function). This progress
> +        * generally have no final "\n", so jump to new line before
> +        * output the status
> +        */
> +       if (netcat_loop_state != NETLOOP_SUCCESS)
> +               printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
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

blank line before final return. Please fix globally

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
> +/*
> + * This function will be called on new connections (incoming or outgoing)
> + * It MUST:
> + *   -- setup required tcp_stream callbacks (if connection will be accepted)
> + *   -- return a connection verdict:
> + *        0: discard connection
> + *        1: accept connection
> + */
> +static int tcp_stream_on_create(struct tcp_stream *tcp)
> +{
> +       if (listen) {
> +               /*
> +                * We are listening for incoming connections.
> +                * Accept connections to netcat listen port only.
> +                */
> +               if (tcp->lport != local_port)
> +                       return 0;
> +       } else {
> +               /*
> +                * We are connecting to remote host.
> +                * Check remote IP:port to make sure that this is our connection
> +                */
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

!strchr

Please don't compare against 0 or NULL

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

!tcp

> +                       printf("No free tcp streams\n");
> +                       net_set_state(NETLOOP_FAIL);
> +                       return;
> +               }
> +               tcp_stream_put(tcp);
> +       }
> +}
> +
> +void netcat_load_start(void)
> +{
> +       reading = 1;
> +       return netcat_start();
> +}
> +
> +void netcat_save_start(void)
> +{
> +       reading = 0;
> +       return netcat_start();
> +}
> --
> 2.45.2
>

Regards,
Simon
