Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AAECF07B3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 06:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D10388FE4;
	Thu, 10 Oct 2024 08:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BkAz602T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68670891C8; Thu, 10 Oct 2024 08:50:20 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDE788FD2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so3840715ad.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728543009; x=1729147809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ig2Ho9HcqsFpqbH/DH1UZP2e0FVGikzpCpyprFrKoUM=;
 b=BkAz602TBAFKk70FLdItpu8A1E9vezJJ3W1gox5pbwjOGf2m9xCZlo7FwjxGZFWQGj
 V34Dy83mY/p29NnkJYoQrfHhx4Eg9KIBV2H65ylzMeoZtv9gYgjjIM/w/bTPCgMvhfgq
 c0YUtBpt2B+QyP7RuPegYQ9U/Wy8+LOYaFn9B0qWSjnxUk0aHvbh5tEAJH2JOR5eWGmj
 +xEjmh6Rr3bAsO4ZGr1LIr2/aYztgAdpOnBzMMJakLP0n02yNskLaA/mT5ctuksEVXA2
 CIhYJpOvXfic8o8m2mv+tx03depLiQPFY1rsmyzCehivxwzPw1cZF5lLITqf+Fo4vClh
 DySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728543009; x=1729147809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ig2Ho9HcqsFpqbH/DH1UZP2e0FVGikzpCpyprFrKoUM=;
 b=uy0AIXRD67JzBJDe8Bf2v52ld+OF5NWGShmhe+mAFt6gGG46aOSoqMKSTPa6YyJahb
 +rLQQMG0YN4kPCnfbh8QSIGCU8aRLq/0sDyp1o38xTNZaP/swMAW59YlnBH2ZnpG7vRF
 viJStyOCXtH0ms5L/ghhRKQE7ZmX49MrCj83uKZ66djBTgZY6KhmBBSviuxMluL5YHX+
 KvXNPdeExjpwfBED4Ob9EsdI4qr5vXNiP/imJlOOvFJF9CN9uQx1p1LkAq0yqNcZSWrw
 j2WQksyNewK0HiGvKACEBpSGukBTnHgZsndAB2B/fo+qOzFjkzeVM2Y/UPLENYbHNcTr
 LDFw==
X-Gm-Message-State: AOJu0Yw9f1QmdE1Gm+kEiEXTtshWvnoHpoy5bzKBh9Q15ir2uxRyfaFZ
 NbmbOe0nyuzojzVvZt1ictIP+UDOxDYdQ4SfpRn15t9b/W0/0APkxV+EMKSfzhPdkuPXv8hahq4
 cY2qwMS9NvQaF7wn7MbyKxAScsrGEjEg+IkaITA==
X-Google-Smtp-Source: AGHT+IEogAwa9M6XXdmbqJypBKQT0IYHGaKM7YXDDks3RqQDZ3J7ZOqjRdTHZ/60qcasOcirVp1W2DayhESkHIH8jys=
X-Received: by 2002:a17:902:da84:b0:20c:862a:fcfc with SMTP id
 d9443c01a7336-20c862afeacmr25809775ad.6.1728543008817; Wed, 09 Oct 2024
 23:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728482473.git.jerome.forissier@linaro.org>
 <b675ee2a95876cdf7d6d8583562bd665949867b7.1728482473.git.jerome.forissier@linaro.org>
In-Reply-To: <b675ee2a95876cdf7d6d8583562bd665949867b7.1728482473.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 10 Oct 2024 09:49:32 +0300
Message-ID: <CAC_iWjKh9=pVV-1c+EFD-=ADAQwDKi7WrH55pNgpRkSFUab1wA@mail.gmail.com>
Subject: Re: [PATCH v12 15/21] net: lwip: add wget command
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
> Add support for the wget command with NET_LWIP. The command normally
> expects a URL: wget [loadaddr] url, but it also accepts the legacy
> syntax: wget [loadaddr] [server:]file.
> The server IP may alternatively be supplied via ${httpserverip} which
> has higher priority than ${serverip}.
>
> Based on code initially developed by Maxim U.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig        |  18 ++-
>  cmd/net-lwip.c     |   8 +
>  include/net-lwip.h |  18 +++
>  net/lwip/Makefile  |   1 +
>  net/lwip/wget.c    | 357 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 394 insertions(+), 8 deletions(-)
>  create mode 100644 net/lwip/wget.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6a3920a162b..0e1f0ce1adc 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2016,14 +2016,6 @@ config SYS_DISABLE_AUTOLOAD
>           is complete.  Enable this option to disable this behavior and instead
>           require files to be loaded over the network by subsequent commands.
>
> -config CMD_WGET
> -       bool "wget"
> -       select PROT_TCP
> -       default y if SANDBOX
> -       help
> -         wget is a simple command to download kernel, or other files,
> -         from a http server over TCP.
> -
>  config CMD_PING6
>         bool "ping6"
>         depends on IPV6
> @@ -2131,6 +2123,16 @@ config CMD_TFTPBOOT
>         help
>           tftpboot - load file via network using TFTP protocol
>
> +config CMD_WGET
> +       bool "wget"
> +       default y if SANDBOX
> +       select PROT_TCP if NET
> +       select PROT_TCP_LWIP if NET_LWIP
> +       select PROT_DNS_LWIP if NET_LWIP
> +       help
> +         wget is a simple command to download kernel, or other files,
> +         from a http server over TCP.
> +
>  endif  # if CMD_NET
>
>  config CMD_PXE
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index c021da6a674..42f8bd6b259 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -35,3 +35,11 @@ U_BOOT_CMD(
>         "hostname [envvar]"
>  );
>  #endif
> +
> +#if defined(CONFIG_CMD_WGET)
> +U_BOOT_CMD(
> +       wget,   3,      1,      do_wget,
> +       "boot image via network using HTTP protocol",
> +       "[loadAddress] URL"
> +);
> +#endif
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index ff9d03b23e8..1c3583f82a1 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -16,8 +16,26 @@ void net_lwip_remove_netif(struct netif *netif);
>  struct netif *net_lwip_get_netif(void);
>  int net_lwip_rx(struct udevice *udev, struct netif *netif);
>
> +/**
> + * wget_with_dns() - runs dns host IP address resulution before wget
> + *
> + * @dst_addr:  destination address to download the file
> + * @uri:       uri string of target file of wget
> + * Return:     downloaded file size, negative if failed
> + */
> +
> +int wget_with_dns(ulong dst_addr, char *uri);
> +/**
> + * wget_validate_uri() - varidate the uri
> + *
> + * @uri:       uri string of target file of wget
> + * Return:     true if uri is valid, false if uri is invalid
> + */
> +bool wget_validate_uri(char *uri);
> +
>  int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>
>  #endif /* __NET_LWIP_H__ */
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 645d8a8c457..f2558f8763a 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
>  obj-$(CONFIG_CMD_DNS) += dns.o
>  obj-$(CONFIG_CMD_PING) += ping.o
>  obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_WGET) += wget.o
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> new file mode 100644
> index 00000000000..b495ebd1aa9
> --- /dev/null
> +++ b/net/lwip/wget.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2024 Linaro Ltd. */
> +
> +#include <command.h>
> +#include <console.h>
> +#include <display_options.h>
> +#include <efi_loader.h>
> +#include <image.h>
> +#include <lwip/apps/http_client.h>
> +#include <lwip/timeouts.h>
> +#include <mapmem.h>
> +#include <net.h>
> +#include <time.h>
> +
> +#define SERVER_NAME_SIZE 200
> +#define HTTP_PORT_DEFAULT 80
> +#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
> +
> +enum done_state {
> +        NOT_DONE = 0,
> +        SUCCESS = 1,
> +        FAILURE = 2
> +};
> +
> +struct wget_ctx {
> +       char *path;
> +       ulong daddr;
> +       ulong saved_daddr;
> +       ulong size;
> +       ulong prevsize;
> +       ulong start_time;
> +       enum done_state done;
> +};
> +
> +static int parse_url(char *url, char *host, u16 *port, char **path)
> +{
> +       char *p, *pp;
> +       long lport;
> +
> +       p = strstr(url, "http://");
> +       if (!p) {
> +               log_err("only http:// is supported\n");
> +               return -EINVAL;
> +       }
> +
> +       p += strlen("http://");
> +
> +       /* Parse hostname */
> +       pp = strchr(p, ':');
> +       if (!pp)
> +               pp = strchr(p, '/');
> +       if (!pp)
> +               return -EINVAL;
> +
> +       if (p + SERVER_NAME_SIZE <= pp)
> +               return -EINVAL;
> +
> +       memcpy(host, p, pp - p);
> +       host[pp - p] = '\0';
> +
> +       if (*pp == ':') {
> +               /* Parse port number */
> +               p = pp + 1;
> +               lport = simple_strtol(p, &pp, 10);
> +               if (pp && *pp != '/')
> +                       return -EINVAL;
> +               if (lport > 65535)
> +                       return -EINVAL;
> +               *port = (u16)lport;
> +       } else {
> +               *port = HTTP_PORT_DEFAULT;
> +       }
> +       if (*pp != '/')
> +               return -EINVAL;
> +       *path = pp;
> +
> +       return 0;
> +}
> +
> +/*
> + * Legacy syntax support
> + * Convert [<server_name_or_ip>:]filename into a URL if needed
> + */
> +static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
> +{
> +       char *p = nurl;
> +       size_t n;
> +       char *col = strchr(arg, ':');
> +       char *env;
> +       char *server;
> +       char *path;
> +
> +       if (strstr(arg, "http") == arg) {
> +               n = snprintf(nurl, rem, "%s", arg);
> +               if (n < 0 || n > rem)
> +                       return -1;
> +               return 0;
> +       }
> +
> +       n = snprintf(p, rem, "%s", "http://");
> +       if (n < 0 || n > rem)
> +               return -1;
> +       p += n;
> +       rem -= n;
> +
> +       if (col) {
> +               n = col - arg;
> +               server = arg;
> +               path = col + 1;
> +       } else {
> +               env = env_get("httpserverip");
> +               if (!env)
> +                       env = env_get("serverip");
> +               if (!env) {
> +                       log_err("error: httpserver/serverip has to be set\n");
> +                       return -1;
> +               }
> +               n = strlen(env);
> +               server = env;
> +               path = arg;
> +       }
> +
> +       if (rem < n)
> +               return -1;
> +       strncpy(p, server, n);
> +       p += n;
> +       rem -= n;
> +       if (rem < 1)
> +               return -1;
> +       *p = '/';
> +       p++;
> +       rem--;
> +       n = strlen(path);
> +       if (rem < n)
> +               return -1;
> +       strncpy(p, path, n);
> +       p += n;
> +       rem -= n;
> +       if (rem < 1)
> +               return -1;
> +       *p = '\0';
> +
> +       return 0;
> +}
> +
> +static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
> +                          err_t err)
> +{
> +       struct wget_ctx *ctx = arg;
> +       struct pbuf *buf;
> +
> +       if (!pbuf)
> +               return ERR_BUF;
> +
> +       if (!ctx->start_time)
> +               ctx->start_time = get_timer(0);
> +
> +       for (buf = pbuf; buf; buf = buf->next) {
> +               memcpy((void *)ctx->daddr, buf->payload, buf->len);
> +               ctx->daddr += buf->len;
> +               ctx->size += buf->len;
> +               if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
> +                       printf("#");
> +                       ctx->prevsize = ctx->size;
> +               }
> +       }
> +
> +       altcp_recved(pcb, pbuf->tot_len);
> +       pbuf_free(pbuf);
> +       return ERR_OK;
> +}
> +
> +static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> +                           u32_t rx_content_len, u32_t srv_res, err_t err)
> +{
> +       struct wget_ctx *ctx = arg;
> +       ulong elapsed;
> +
> +       if (httpc_result != HTTPC_RESULT_OK) {
> +               log_err("\nHTTP client error %d\n", httpc_result);
> +               ctx->done = FAILURE;
> +               return;
> +       }
> +       if (srv_res != 200) {
> +               log_err("\nHTTP server error %d\n", srv_res);
> +               ctx->done = FAILURE;
> +               return;
> +       }
> +
> +       elapsed = get_timer(ctx->start_time);
> +       if (!elapsed)
> +               elapsed = 1;
> +       if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
> +               printf("\n");
> +       printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
> +       print_size(rx_content_len / elapsed * 1000, "/s)\n");
> +       printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
> +       efi_set_bootdev("Net", "", ctx->path, map_sysmem(ctx->saved_daddr, 0),
> +                       rx_content_len);
> +       if (env_set_hex("filesize", rx_content_len) ||
> +           env_set_hex("fileaddr", ctx->saved_daddr)) {
> +               log_err("Could not set filesize or fileaddr\n");
> +               ctx->done = FAILURE;
> +               return;
> +       }
> +
> +       ctx->done = SUCCESS;
> +}
> +
> +static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> +{
> +       char server_name[SERVER_NAME_SIZE];
> +       httpc_connection_t conn;
> +       httpc_state_t *state;
> +       struct netif *netif;
> +       struct wget_ctx ctx;
> +       char *path;
> +       u16 port;
> +
> +       ctx.daddr = dst_addr;
> +       ctx.saved_daddr = dst_addr;
> +       ctx.done = NOT_DONE;
> +       ctx.size = 0;
> +       ctx.prevsize = 0;
> +       ctx.start_time = 0;
> +
> +       if (parse_url(uri, server_name, &port, &path))
> +               return CMD_RET_USAGE;
> +
> +       netif = net_lwip_new_netif(udev);
> +       if (!netif)
> +               return -1;
> +
> +       memset(&conn, 0, sizeof(conn));
> +       conn.result_fn = httpc_result_cb;
> +       ctx.path = path;
> +       if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> +                              &ctx, &state)) {
> +               net_lwip_remove_netif(netif);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       while (!ctx.done) {
> +               net_lwip_rx(udev, netif);
> +               sys_check_timeouts();
> +               if (ctrlc())
> +                       break;
> +       }
> +
> +       net_lwip_remove_netif(netif);
> +
> +       if (ctx.done == SUCCESS)
> +               return 0;
> +
> +       return -1;
> +}
> +
> +int wget_with_dns(ulong dst_addr, char *uri)
> +{
> +       eth_set_current();
> +
> +       return wget_loop(eth_get_dev(), dst_addr, uri);
> +}
> +
> +int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> +{
> +       char *end;
> +       char *url;
> +       ulong dst_addr;
> +       char nurl[1024];
> +
> +       if (argc < 2 || argc > 3)
> +               return CMD_RET_USAGE;
> +
> +       dst_addr = hextoul(argv[1], &end);
> +        if (end == (argv[1] + strlen(argv[1]))) {
> +               if (argc < 3)
> +                       return CMD_RET_USAGE;
> +               url = argv[2];
> +       } else {
> +               dst_addr = image_load_addr;
> +               url = argv[1];
> +       }
> +
> +       if (parse_legacy_arg(url, nurl, sizeof(nurl)))
> +           return CMD_RET_FAILURE;
> +
> +       if (wget_with_dns(dst_addr, nurl))
> +               return CMD_RET_FAILURE;
> +
> +       return CMD_RET_SUCCESS;
> +}
> +
> +/**
> + * wget_validate_uri() - validate the uri for wget
> + *
> + * @uri:       uri string
> + *
> + * This function follows the current U-Boot wget implementation.
> + * scheme: only "http:" is supported
> + * authority:
> + *   - user information: not supported
> + *   - host: supported
> + *   - port: not supported(always use the default port)
> + *
> + * Uri is expected to be correctly percent encoded.
> + * This is the minimum check, control codes(0x1-0x19, 0x7F, except '\0')
> + * and space character(0x20) are not allowed.
> + *
> + * TODO: stricter uri conformance check
> + *
> + * Return:     true on success, false on failure
> + */
> +bool wget_validate_uri(char *uri)
> +{
> +       char c;
> +       bool ret = true;
> +       char *str_copy, *s, *authority;
> +
> +       for (c = 0x1; c < 0x21; c++) {
> +               if (strchr(uri, c)) {
> +                       log_err("invalid character is used\n");
> +                       return false;
> +               }
> +       }
> +       if (strchr(uri, 0x7f)) {
> +               log_err("invalid character is used\n");
> +               return false;
> +       }
> +
> +       if (strncmp(uri, "http://", 7)) {
> +               log_err("only http:// is supported\n");
> +               return false;
> +       }
> +       str_copy = strdup(uri);
> +       if (!str_copy)
> +               return false;
> +
> +       s = str_copy + strlen("http://");
> +       authority = strsep(&s, "/");
> +       if (!s) {
> +               log_err("invalid uri, no file path\n");
> +               ret = false;
> +               goto out;
> +       }
> +       s = strchr(authority, '@');
> +       if (s) {
> +               log_err("user information is not supported\n");
> +               ret = false;
> +               goto out;
> +       }
> +
> +out:
> +       free(str_copy);
> +
> +       return ret;
> +}
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
