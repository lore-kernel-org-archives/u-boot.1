Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10348D1AD55
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9963688CFB;
	Wed, 16 Oct 2024 15:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vEKW3SF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BEF488D1C; Wed, 16 Oct 2024 15:30:15 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCE988CFB
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 15:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so4759961a91.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729085411; x=1729690211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jeiU87kay/vfgfuBa63WLjd9HaL0xbyjYPsUzRDzp/U=;
 b=vEKW3SF+eMynWkdTn/StO2/HL4TdTXfLB8MO3bj2fS6wulXP2ZP+XTsLbzTyTxL73f
 GU2/hAEmpwOSHTC1WUCA7bieJhFad/B2TShM5CZdQcv96vJ/aRlrfflFDHO1QoD5xxvN
 djs68oKpdAbiIKbW2RSU4Io5pn9oHYTLrUpehIDcfSKTukp+RJZiU4DN0RZnuBoUFNSG
 n2DaGMc/k48BZUTq7y/bO4qiRwB8pQ8XStLyUVG9RsOSWjUdvMRiaAxqgVKCqvuduLAK
 QuU3nMw3KoKCgSkyTYMcGvNB77HUjHosRh2Md9mrsmRsugS7pkDTYSo1aUcF6c46RTXy
 pMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729085411; x=1729690211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeiU87kay/vfgfuBa63WLjd9HaL0xbyjYPsUzRDzp/U=;
 b=oR6+pnJ/uKvNFOndGQ8YHu8K11lOzqzP8ojY0Oq8FztbyqlaDSfdfzDKW3pjugJ9fy
 ODTNVjXcrcz2SMTVCFRut3XW58c0v18XlNeznZfpXcyffaT0At/D8ERGAw7XzmJ8raS3
 vEC8aocb25t+59iwP/CtpDa2c/qdJu7sQoli/hFrzLX9148pzbmszEKhK33+usPiSoiB
 VZR5h9B4VqW9DouihAcmrNrxYmiW04HcTKD0zUu4KUQKh1qvkUO2FDsC5N0P4+RBhFWR
 Vgcy1qenM2KiEkkdAcPYw+CM/Slu7coW67kKMK6x3cvlscrrvGHPARcZTKfXEvyEHwZ8
 bPSw==
X-Gm-Message-State: AOJu0YxKhmZh8s/a7yGO9DMPs/SB6qRNZsleEq/KcJW/MrX/+kBggOct
 21mgMzTkmE9g4mMfLm9Az2tmNvLp1wpFg7xZlYQVDHEm2RssnufDNCKeBJ4xOxmlGcYchCg4bWr
 0NMecnTkHNiDA2Le83hfey9pXSxEGxo7VNXB1MQ==
X-Google-Smtp-Source: AGHT+IEtcTkonykMDHbOY1PbtLET6k2/NSb3AH84imfURb3s0r6ADkWFmCz7hq3uuc2p9bwRg+wsCwqrO6p/3tc11C4=
X-Received: by 2002:a17:90b:4a04:b0:2e2:d7db:41fa with SMTP id
 98e67ed59e1d1-2e31536e31fmr19265952a91.33.1729085411450; Wed, 16 Oct 2024
 06:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729070678.git.jerome.forissier@linaro.org>
 <6a7582ab314aca691738c0a0ec68d45b9bf335eb.1729070678.git.jerome.forissier@linaro.org>
In-Reply-To: <6a7582ab314aca691738c0a0ec68d45b9bf335eb.1729070678.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 16:29:35 +0300
Message-ID: <CAC_iWj++gWcj9frBeRCMSf+huPbGJukoDuEdNPsMAwuYzcsiRg@mail.gmail.com>
Subject: Re: [PATCH v13 13/21] net: lwip: add dns command
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
> index b7d1dd028a1..2791ad5393c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2027,11 +2027,6 @@ config CMD_SNTP
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
> @@ -2079,6 +2074,12 @@ config CMD_DHCP
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
