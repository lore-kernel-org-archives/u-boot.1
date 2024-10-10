Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8C1CF07B3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 06:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5F1891FC;
	Thu, 10 Oct 2024 08:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uAdauVXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D3889201; Thu, 10 Oct 2024 08:52:01 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFE888FD2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso416499a12.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728543116; x=1729147916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=62Kubloe7jrqNULJyPWG1GGGBhE1314tsCv9V5w+/98=;
 b=uAdauVXf4BjfhQSYdDH+sjVS6JLKW//oRu4LarpUk4OkuxfHj0gRZqqA9SkdIrXt5t
 aKUumjDRM0zxHHCxArBlkibrwRDCrHl5gLAiWILSDD/1Vda3pKwGSZDx7jhYcyAT0/CQ
 3gcM6tSj3452d/QNNy/l38i9J1LlJQRw/P1XTYAlkZ4yBoHwVRIL/r9zYnsCh8U+BIMM
 9H5kqrt7fgwWKt0aUXn3lwqwoNpAr1C3bVuTVCU84I3N5FoSQjv/kwOGtp9k79Nm9KHO
 zDgE8sT6ZaYUcYdhUoJhWXiujbLwHt/INEoCA/hajnsFDhOHUK/m+rsXbVMUmL5gDptO
 ihqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728543116; x=1729147916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62Kubloe7jrqNULJyPWG1GGGBhE1314tsCv9V5w+/98=;
 b=FsQUYgqr9YVzEggfP5VaT5aXdYGLAD+knH36gI4+IrIWSpUUXqLqRAqPOtKhpbH5sO
 fMMx6eMVK9PsLwYR7hI2prcCWJ844bLjq8Amk8pe0rkAnTnMcA9nF0BFi1vjfytVZEbu
 Tqxpm4jAZMezFBy227REmuvbvECe7XR0SP7FwegY5VhUPh538E+cht06lvdCb7QGiYiH
 ohuS/CC2NHi/mfZFVlk/0/Yn8K+2Iv+kMEJqVzpQkSx9HywmeALX9cKDKQWVzyh/Qbm/
 ujG+BTqkv+IFWfXrzdcXuV9YdHSDW0cl95kyykdqa/oy9cxQgolBvdHUrqRXChTA/bsb
 1IhQ==
X-Gm-Message-State: AOJu0Yx407qYnKaG9XbwRpf1W/y4KBM3DWYKbkJLt6UMSJKekKOZ590t
 07K0dlEjTuNsCeTQHKQ5GMrEMhh/lw9AIU+GKggkaoSwX3kUsgKW4evXnGAG29SwJQriuAz3ZpU
 hXNrRzE3kcvHQyBZqyAO28ykMcZQODmmAdUZ5vg==
X-Google-Smtp-Source: AGHT+IEa4DInA/QO0KKcca5EsrR6SZmaz3Up6C13Emp6tXr7Y3+AR5n7xp52l1vRIqz9eVH3FDjpe4XT5aSjr06trTU=
X-Received: by 2002:a17:90b:943:b0:2e2:a667:1a10 with SMTP id
 98e67ed59e1d1-2e2c63d22aemr2772828a91.38.1728543116503; Wed, 09 Oct 2024
 23:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728482473.git.jerome.forissier@linaro.org>
 <6e81886b923e3d7c59fc9996b164b4399f65f14a.1728482473.git.jerome.forissier@linaro.org>
In-Reply-To: <6e81886b923e3d7c59fc9996b164b4399f65f14a.1728482473.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 10 Oct 2024 09:51:20 +0300
Message-ID: <CAC_iWjKHmZHuDYZQQQoG+sz79j26nS2+gaW4KOfsSZi5NtB++g@mail.gmail.com>
Subject: Re: [PATCH v12 13/21] net: lwip: add dns command
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

On Wed, 9 Oct 2024 at 17:50, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add CMD_DNS when NET_LWIP is enabled to provide the dns command using
> lwIP.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig        |  11 ++--
>  cmd/net-lwip.c     |   8 +++
>  include/net-lwip.h |   1 +
>  net/lwip/Makefile  |   1 +
>  net/lwip/dns.c     | 127 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 net/lwip/dns.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 132835e43f8..6a3920a162b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2042,11 +2042,6 @@ config CMD_SNTP
>         help
>           Synchronize RTC via network
>
> -config CMD_DNS
> -       bool "dns"
> -       help
> -         Lookup the IP of a hostname
> -
>  config CMD_LINK_LOCAL
>         bool "linklocal"
>         select LIB_RAND
> @@ -2094,6 +2089,12 @@ config CMD_DHCP
>         help
>           Boot image via network using DHCP/TFTP protocol
>
> +config CMD_DNS
> +       bool "dns"
> +       select PROT_DNS_LWIP if NET_LWIP
> +       help
> +         Lookup the IP of a hostname
> +
>  config CMD_MII
>         bool "mii"
>         imply CMD_MDIO
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index feed719beef..c021da6a674 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -27,3 +27,11 @@ U_BOOT_CMD(
>         "[loadAddress] [[hostIPaddr:]bootfilename]"
>  );
>  #endif
> +
> +#if defined(CONFIG_CMD_DNS)
> +U_BOOT_CMD(
> +       dns,    3,      1,      do_dns,
> +       "lookup the IP of a hostname",
> +       "hostname [envvar]"
> +);
> +#endif
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 9aa371e962c..ff9d03b23e8 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -17,6 +17,7 @@ struct netif *net_lwip_get_netif(void);
>  int net_lwip_rx(struct udevice *udev, struct netif *netif);
>
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index b5af37a9b18..645d8a8c457 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -2,5 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
>
>  obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
>  obj-$(CONFIG_CMD_DHCP) += dhcp.o
> +obj-$(CONFIG_CMD_DNS) += dns.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> new file mode 100644
> index 00000000000..4b937feaee1
> --- /dev/null
> +++ b/net/lwip/dns.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 Linaro Ltd. */
> +
> +#include <command.h>
> +#include <console.h>
> +#include <lwip/dns.h>
> +#include <lwip/timeouts.h>
> +#include <net.h>
> +#include <time.h>
> +
> +#define DNS_RESEND_MS 1000
> +#define DNS_TIMEOUT_MS 10000
> +
> +struct dns_cb_arg {
> +       ip_addr_t host_ipaddr;
> +       const char *var;
> +       bool done;
> +};
> +
> +static void do_dns_tmr(void *arg)
> +{
> +       dns_tmr();
> +}
> +
> +static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
> +{
> +       struct dns_cb_arg *dns_cb_arg = arg;
> +       char *ipstr = ip4addr_ntoa(ipaddr);
> +
> +       dns_cb_arg->done = true;
> +
> +       if (!ipaddr) {
> +               printf("DNS: host not found\n");
> +               dns_cb_arg->host_ipaddr.addr = 0;
> +               return;
> +       }
> +
> +       if (dns_cb_arg->var)
> +               env_set(dns_cb_arg->var, ipstr);
> +
> +       printf("%s\n", ipstr);
> +}
> +
> +static int dns_loop(struct udevice *udev, const char *name, const char *var)
> +{
> +       struct dns_cb_arg dns_cb_arg = { };
> +       bool has_server = false;
> +       struct netif *netif;
> +       ip_addr_t ipaddr;
> +       ip_addr_t ns;
> +       ulong start;
> +       char *nsenv;
> +       int ret;
> +
> +       dns_cb_arg.var = var;
> +
> +       netif = net_lwip_new_netif(udev);
> +       if (!netif)
> +               return -1;
> +
> +       dns_init();
> +
> +       nsenv = env_get("dnsip");
> +       if (nsenv && ipaddr_aton(nsenv, &ns)) {
> +               dns_setserver(0, &ns);
> +               has_server = true;
> +       }
> +
> +       nsenv = env_get("dnsip2");
> +       if (nsenv && ipaddr_aton(nsenv, &ns)) {
> +               dns_setserver(1, &ns);
> +               has_server = true;
> +       }
> +
> +       if (!has_server) {
> +               log_err("No valid name server (dnsip/dnsip2)\n");
> +               net_lwip_remove_netif(netif);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       dns_cb_arg.done = false;
> +
> +       ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
> +
> +       if (ret == ERR_OK) {
> +               dns_cb(name, &ipaddr, &dns_cb_arg);
> +       } else if (ret == ERR_INPROGRESS) {
> +               start = get_timer(0);
> +               sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
> +               do {
> +                       net_lwip_rx(udev, netif);
> +                       if (dns_cb_arg.done)
> +                               break;
> +                       sys_check_timeouts();
> +                       if (ctrlc()) {
> +                               printf("\nAbort\n");
> +                               break;
> +                       }
> +               } while (get_timer(start) < DNS_TIMEOUT_MS);
> +               sys_untimeout(do_dns_tmr, NULL);
> +       }
> +
> +       net_lwip_remove_netif(netif);
> +
> +       if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0)
> +               return CMD_RET_SUCCESS;
> +
> +       return CMD_RET_FAILURE;
> +}
> +
> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       char *name;
> +       char *var = NULL;
> +
> +       if (argc == 1 || argc > 3)
> +               return CMD_RET_USAGE;
> +
> +       name = argv[1];
> +
> +       if (argc == 3)
> +               var = argv[2];
> +
> +       eth_set_current();
> +
> +       return dns_loop(eth_get_dev(), name, var);
> +}
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
