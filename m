Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8695D1AD55
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2595F88BC2;
	Wed, 16 Oct 2024 15:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IG+W9mP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CEC88CA1; Wed, 16 Oct 2024 15:29:44 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF56188B99
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 15:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ea78037b7eso3343993a12.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729085380; x=1729690180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OWAlJyakCOArnz904W5pOsrbluUrTU33YNamPIxDDes=;
 b=IG+W9mP/cWesfiATzD9WGnBtRt7HSfGvu8IYyutUdf/E3kIob4eXKPqory+VAYj5+K
 TQWRLHXXAJjvPAijP8RIpI+RHElEmUyvGh6TuO5ujk2m1iPL2D+6sIoMZkD3oOC8LgC0
 ONG8ygFsw133nuf4dhINT0nb44kC1wQcBMRvYraNM9jOVPXnrnNMNJ2dafRvttjk/Ijo
 1rTBKPrJwxr026aUaJz215Avu3QHnK6Eeqor+gVO793dL6fKrYg/FWshcgXzhTKC8tTz
 +OB7W2WQiLUMeY0YpOHq9y7rQKP+1sA/pPQbv52LjPOODY4IqESjClrzuOv/I8ZtnSp6
 zXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729085380; x=1729690180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWAlJyakCOArnz904W5pOsrbluUrTU33YNamPIxDDes=;
 b=fMaqt37LK9i4mWcEWXuT07A2/ebHzB2rFCba2dFTdPSVyWPUiYUEBPhY4dv+t3KQF/
 vEVH9DYEtTh4O5TAtY1pHPWFzkIPqgWDjuyS9ICuTSdd2Ce8WgSRh2eCVTmeoEKgmQZE
 ExsXeohYPdxG0W5lL14yPXH2wxiMjRaZNsb66ZQbr/8VgeEPxBd3x4YZ/mMy6S5CRFty
 tDhE5XtNuHv5iF5mPBx+6KvDWmyff4oCEmLitws66/NwQL5UG0b8JsQp0TqPFIx+9ULb
 JoYe2rl+x0gqTHYQKzddkpf077dAoxuRUGC2jE/irJeZ7dHcT8YwZHMuPFxviP6F4yvO
 k/uQ==
X-Gm-Message-State: AOJu0YwMVo3xznBkm7MPM3KG1i3J+Dqs6RqZmOsbW9NarIqf0Z9ZIyUG
 abF2rxCCjg8RHrOk2FweY56tIeU9SW9TzMssGIIEOKqBAZj0FXKYJpUlo+auL1fRoLk1acf0t0X
 VEssJDVpdybuY9/CQ5yMTsEk8wPbc0EzzAMD1EQ==
X-Google-Smtp-Source: AGHT+IFFkUZI77dRIbdAh2f9mt/v1qRfx3ShDRFAsykmf7bX+ePqEc4pCpGc1k7m50FLwEDanzJMahEeOhs2B9qklh8=
X-Received: by 2002:a17:90a:fa84:b0:2e2:b922:492 with SMTP id
 98e67ed59e1d1-2e2f0affa8emr20289905a91.17.1729085380337; Wed, 16 Oct 2024
 06:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729070678.git.jerome.forissier@linaro.org>
 <631c3507a1b0e45ee86e40643864ead091e197d3.1729070678.git.jerome.forissier@linaro.org>
In-Reply-To: <631c3507a1b0e45ee86e40643864ead091e197d3.1729070678.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 16:29:04 +0300
Message-ID: <CAC_iWj+OVrnTQxWGNoNBOAoAaPL_dOJX_uNtbBjB8TwCBpaCRw@mail.gmail.com>
Subject: Re: [PATCH v13 12/21] net: lwip: add ping command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>
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

On Wed, 16 Oct 2024 at 13:05, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add support for the the ping command with NET_LWIP. The implementation
> is derived from lwIP's contrib/apps/ping/ping.c.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig        |  11 +--
>  cmd/net-lwip.c     |   8 ++
>  include/net-lwip.h |   1 +
>  net/lwip/Makefile  |   1 +
>  net/lwip/ping.c    | 177 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 193 insertions(+), 5 deletions(-)
>  create mode 100644 net/lwip/ping.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 7173f3da0b0..b7d1dd028a1 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2009,11 +2009,6 @@ config CMD_WGET
>           wget is a simple command to download kernel, or other files,
>           from a http server over TCP.
>
> -config CMD_PING
> -       bool "ping"
> -       help
> -         Send ICMP ECHO_REQUEST to network host
> -
>  config CMD_PING6
>         bool "ping6"
>         depends on IPV6
> @@ -2107,6 +2102,12 @@ config CMD_MDIO
>           The MDIO interface is orthogonal to the MII interface and extends
>           it by adding access to more registers through indirect addressing.
>
> +config CMD_PING
> +       bool "ping"
> +       select PROT_RAW_LWIP if NET_LWIP
> +       help
> +         Send ICMP ECHO_REQUEST to network host
> +
>  config CMD_TFTPBOOT
>         bool "tftp"
>         select PROT_UDP_LWIP if NET_LWIP
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 80f0872bb8f..feed719beef 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -12,6 +12,14 @@ U_BOOT_CMD(
>  );
>  #endif
>
> +#if defined(CONFIG_CMD_PING)
> +U_BOOT_CMD(
> +       ping,   2,      1,      do_ping,
> +       "send ICMP ECHO_REQUEST to network host",
> +       "pingAddress"
> +);
> +#endif
> +
>  #if defined(CONFIG_CMD_TFTPBOOT)
>  U_BOOT_CMD(
>         tftpboot,       3,      0,      do_tftpb,
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 37744b0e2cd..9aa371e962c 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -17,5 +17,6 @@ struct netif *net_lwip_get_netif(void);
>  int net_lwip_rx(struct udevice *udev, struct netif *netif);
>
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
> +int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 4e92a101ddb..b5af37a9b18 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -2,4 +2,5 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
>
>  obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
>  obj-$(CONFIG_CMD_DHCP) += dhcp.o
> +obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
> new file mode 100644
> index 00000000000..8dafa25959f
> --- /dev/null
> +++ b/net/lwip/ping.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 Linaro Ltd. */
> +
> +#include <command.h>
> +#include <console.h>
> +#include <dm/device.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <lwip/icmp.h>
> +#include <lwip/inet_chksum.h>
> +#include <lwip/raw.h>
> +#include <lwip/timeouts.h>
> +#include <net.h>
> +#include <time.h>
> +
> +#define PING_DELAY_MS 1000
> +#define PING_COUNT 5
> +/* Ping identifier - must fit on a u16_t */
> +#define PING_ID 0xAFAF
> +
> +struct ping_ctx {
> +       ip_addr_t target;
> +       struct raw_pcb *pcb;
> +       struct icmp_echo_hdr *iecho;
> +       uint16_t seq_num;
> +       bool alive;
> +};
> +
> +static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
> +                     const ip_addr_t *addr)
> +{
> +       struct ping_ctx *ctx = arg;
> +       struct icmp_echo_hdr *iecho = ctx->iecho;
> +
> +       if (addr->addr != ctx->target.addr)
> +               return 0;
> +
> +       if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
> +           pbuf_remove_header(p, IP_HLEN) == 0) {
> +               iecho = (struct icmp_echo_hdr *)p->payload;
> +
> +               if ((iecho->id == PING_ID) &&
> +                   (iecho->seqno == lwip_htons(ctx->seq_num))) {
> +                       ctx->alive = true;
> +                       printf("host %s is alive\n", ipaddr_ntoa(addr));
> +                       pbuf_free(p);
> +                       return 1; /* eat the packet */
> +               }
> +               /* not eaten, restore original packet */
> +               pbuf_add_header(p, IP_HLEN);
> +       }
> +
> +       return 0; /* don't eat the packet */
> +}
> +
> +static int ping_raw_init(struct ping_ctx *ctx)
> +{
> +       ctx->pcb = raw_new(IP_PROTO_ICMP);
> +       if (!ctx->pcb)
> +               return -ENOMEM;
> +
> +       raw_recv(ctx->pcb, ping_recv, ctx);
> +       raw_bind(ctx->pcb, IP_ADDR_ANY);
> +
> +       return 0;
> +}
> +
> +static void ping_raw_stop(struct ping_ctx *ctx)
> +{
> +       if (ctx->pcb)
> +               raw_remove(ctx->pcb);
> +}
> +
> +static void ping_prepare_echo(struct ping_ctx *ctx)
> +{
> +       struct icmp_echo_hdr *iecho = ctx->iecho;
> +
> +       ICMPH_TYPE_SET(iecho, ICMP_ECHO);
> +       ICMPH_CODE_SET(iecho, 0);
> +       iecho->chksum = 0;
> +       iecho->id = PING_ID;
> +       iecho->seqno = lwip_htons(ctx->seq_num);
> +
> +       iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
> +}
> +
> +static void ping_send_icmp(struct ping_ctx *ctx)
> +{
> +       struct pbuf *p;
> +       size_t ping_size = sizeof(struct icmp_echo_hdr);
> +
> +       p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
> +       if (!p)
> +               return;
> +
> +       if ((p->len == p->tot_len) && !p->next) {
> +               ctx->iecho = (struct icmp_echo_hdr *)p->payload;
> +               ping_prepare_echo(ctx);
> +               raw_sendto(ctx->pcb, p, &ctx->target);
> +       }
> +
> +       pbuf_free(p);
> +}
> +
> +static void ping_send(void *arg)
> +{
> +       struct ping_ctx *ctx = arg;
> +
> +       ctx->seq_num++;
> +       if (ctx->seq_num <= PING_COUNT) {
> +               ping_send_icmp(ctx);
> +               sys_timeout(PING_DELAY_MS, ping_send, ctx);
> +       }
> +}
> +
> +static int ping_loop(struct udevice *udev, const ip_addr_t* addr)
> +{
> +       struct ping_ctx ctx = {};
> +       struct netif *netif;
> +       int ret;
> +
> +       netif = net_lwip_new_netif(udev);
> +       if (!netif)
> +               return CMD_RET_FAILURE;
> +
> +       printf("Using %s device\n", udev->name);
> +
> +       ret = ping_raw_init(&ctx);
> +       if (ret < 0) {
> +               net_lwip_remove_netif(netif);
> +               return ret;
> +       }
> +
> +       ctx.target = *addr;
> +
> +       ping_send(&ctx);
> +
> +       do {
> +               sys_check_timeouts();
> +               net_lwip_rx(udev, netif);
> +               if (ctx.alive)
> +                       break;
> +               if (ctrlc()) {
> +                       printf("\nAbort\n");
> +                       break;
> +               }
> +       } while (ctx.seq_num <= PING_COUNT);
> +
> +       sys_untimeout(ping_send, &ctx);
> +       ping_raw_stop(&ctx);
> +
> +       net_lwip_remove_netif(netif);
> +
> +       if (ctx.alive)
> +               return 0;
> +
> +       printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
> +       return -1;
> +}
> +
> +int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       ip_addr_t addr;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       if (!ipaddr_aton(argv[1], &addr))
> +               return CMD_RET_USAGE;
> +
> +       eth_set_current();
> +
> +       if (ping_loop(eth_get_dev(), &addr) < 0)
> +               return CMD_RET_FAILURE;
> +
> +       return CMD_RET_SUCCESS;
> +}
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
