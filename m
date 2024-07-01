Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D074DC3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 15:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B3A884EA;
	Mon,  1 Jul 2024 17:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EstbVbsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EE5884CC; Mon,  1 Jul 2024 17:54:53 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D467884EA
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 17:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so675431a12.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719849289; x=1720454089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYwiNEJal/KVhB2K7xIfnd1LOQeyJzrj/q72wBUWGq0=;
 b=EstbVbsdreCrDyRRmfF6uXB38CUGVM+mFzQPlg1wGln00nCZMzcvM4TzlqoK0jPwpc
 DtGS9pvYpHO5vt7l4YQXHQttMuxxVYHR0u/mj9gQHfwL4TFAXxiF4jGdY5UvXNKoZWbO
 3GowUDuqwfiUD0kR9CUcJPk1poQ8IZAotlFonxnh8AxzPl0AP53uo3IJRnwZLfXfKyEW
 0ApKATttRAc8LZFW6RkHIGAgmgYUU1i+ncy3MFYJx37EAzAlqalJ5PGbaxz+vwR094Om
 JThF7465J4cxlfO1qQFgqtpL6ibt2xqzBHh43WfCDhPxqE6XkkW9n0rEPvK4jtlaZqhG
 gZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719849289; x=1720454089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYwiNEJal/KVhB2K7xIfnd1LOQeyJzrj/q72wBUWGq0=;
 b=dHtvVQeXskblDgdjbd778figHqXveFHb/3C3ZRzjESjLC/XIZfMUgCVDvYqAlhgCiT
 AN0FWihCuwt7z1I5DgT3B+mDph/DFgjtKi1pZWKXpGb1etix0+Q4lMgzbhrYiPrUAVVG
 ARCZUjkM/S1pwxKJYg16oM80oXL39ye7aSIgw4wIMD/+nTLZWGSY09nAk9uHKW/md4tC
 DM1RjTd1aW6ytKwQrhuR2s9KDW5xEHHPJv26jwXy+KKqM4adNeF0IzrpYV/1mLcNGOPd
 GNYPYzBPG2XELyloe6fXEI8xtC1mhNPRVXAuJVSZwOpjMa3990X6abeCpOVFdhdXoQAz
 L6Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIW83EUZDY5MrGJAh4aIKZzJYCxWbooB8Win1gcpURMNFVIZCdkaeF28C3rkGaWjStFhWlE4J6W4PuwVEKnlHzC32tgA==
X-Gm-Message-State: AOJu0YzD0Q/csp8faJRV/CoGfKMBIixefGywZIfxDHrDu4T84XkFLIyF
 tjsJH1s0jgPdx1EcNtIb5IllLgPavZGXAGG8l3EriUawL/oMdoQt40RLcKHQgGbcGIJqepn9yEV
 MHf8dNp2IB/BT8uiXISz2XdtJUvs=
X-Google-Smtp-Source: AGHT+IGigGRwYww/sa8TzZ9CgYi5u6qqY0H9LtZR7zUWRSAiHZ0sINqXAiirH/9Ey2y66yy+yyRLh5nDWAvUc5mnnbs=
X-Received: by 2002:a05:6402:2068:b0:586:e702:971e with SMTP id
 4fb4d7f45d1cf-587a0fdbed1mr3631510a12.38.1719849288287; Mon, 01 Jul 2024
 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627113939.100620-8-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627113939.100620-8-mikhail.kshevetskiy@iopsys.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 1 Jul 2024 16:54:37 +0100
Message-ID: <CALeDE9NZFy_XFaWj=LOFw6BvqhcC=hs8QCwKg3VRfbCzcJFZkQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] net/httpd: add httpd common code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
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

> This patch adds HTTP/1.1 compatible web-server that can be used
> by other. Server supports GET, POST, and HEAD requests. On client
> request it will call user specified GET/POST callback. Then results
> will be transmitted to client.

Why are we adding a HTTP server? I don't see a cover letter explaining
overall what you're attempting to achieve with this patch set so
please add that. Also I suggest you look at the LWIP patch set [1] as
that may make what you wish to achieve more straight forward.

Peter

[1] https://lists.denx.de/pipermail/u-boot/2024-June/556526.html

> The following restrictions exist on the POST request
> at the moment:
>   * only multipart/form-data with a single file object
>   * object will be stored to a memory area specified in
>     image_load_addr variable
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net.h       |   2 +-
>  include/net/httpd.h |  64 ++++
>  net/Kconfig         |  14 +
>  net/Makefile        |   1 +
>  net/httpd.c         | 695 ++++++++++++++++++++++++++++++++++++++++++++
>  net/net.c           |   6 +
>  6 files changed, 781 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/httpd.h
>  create mode 100644 net/httpd.c
>
> diff --git a/include/net.h b/include/net.h
> index 235396a171b..6debbf8ed2a 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -516,7 +516,7 @@ extern int          net_restart_wrap;       /* Tried all network devices */
>  enum proto_t {
>         BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
> -       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, RS
> +       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, HTTPD, RS
>  };
>
>  extern char    net_boot_file_name[1024];/* Boot File name */
> diff --git a/include/net/httpd.h b/include/net/httpd.h
> new file mode 100644
> index 00000000000..ff0dc93ecf5
> --- /dev/null
> +++ b/include/net/httpd.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * httpd support header file
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + *
> + */
> +#ifndef __NET_HTTPD_COMMON_H__
> +#define __NET_HTTPD_COMMON_H__
> +
> +struct http_reply {
> +       int             code;
> +       const char      *code_msg;
> +       const char      *data_type;
> +       void            *data;
> +       u32             len;
> +};
> +
> +struct httpd_post_data {
> +       const char      *name;
> +       const char      *filename;
> +       void            *addr;
> +       u32             size;
> +};
> +
> +enum httpd_req_check {
> +       HTTPD_REQ_OK,
> +       HTTPD_BAD_URL,
> +       HTTPD_BAD_REQ,
> +       HTTPD_CLNT_RST
> +};
> +
> +struct httpd_config {
> +       enum net_loop_state     (*on_stop)(void);
> +       void                    (*on_req_end)(void *req_id);
> +
> +       enum httpd_req_check    (*pre_get)(void *req_id, const char *url);
> +       enum httpd_req_check    (*pre_post)(void *req_id, const char *url,
> +                                           struct httpd_post_data *post);
> +
> +       struct http_reply *     (*get)(void *req_id, const char *url);
> +       struct http_reply *     (*post)(void *req_id, const char *url,
> +                                       struct httpd_post_data *post);
> +
> +       struct http_reply       *error_400;
> +       struct http_reply       *error_404;
> +};
> +
> +/**
> + * httpd_setup() - configure the webserver
> + */
> +void httpd_setup(struct httpd_config *config);
> +
> +/**
> + * httpd_stop() - start stopping of the webserver
> + */
> +void httpd_stop(void);
> +
> +/**
> + * httpd_start() - start the webserver
> + */
> +void httpd_start(void);
> +
> +#endif /* __NET_HTTPD_COMMON_H__ */
> diff --git a/net/Kconfig b/net/Kconfig
> index 5dff6336293..424c5f0dae8 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -243,6 +243,20 @@ config PROT_TCP_SACK
>           This option should be turn on if you want to achieve the fastest
>           file transfer possible.
>
> +config HTTPD_COMMON
> +       bool "HTTP server common code"
> +       depends on PROT_TCP
> +       help
> +         HTTP/1.1 compatible web-server common code. It supports standard
> +         GET/POST requests. User MUST provide a configuration to the
> +         web-server. On client request web-server will call user specified
> +         GET/POST callback. Then results will be transmitted to the client.
> +         The following restricions on the POST request are present at the
> +         moment:
> +           * only mulipart/form-data with a single binary object
> +           * object will be stored to a memory area specified in
> +             image_load_addr variable
> +
>  config IPV6
>         bool "IPv6 support"
>         help
> diff --git a/net/Makefile b/net/Makefile
> index dac7b4859fb..c1f491fad02 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PROT_UDP) += udp.o
>  obj-$(CONFIG_PROT_TCP) += tcp.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
>  obj-$(CONFIG_CMD_NETCAT) += netcat.o
> +obj-$(CONFIG_HTTPD_COMMON) += httpd.o
>
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net/httpd.c b/net/httpd.c
> new file mode 100644
> index 00000000000..31c10843a44
> --- /dev/null
> +++ b/net/httpd.c
> @@ -0,0 +1,695 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * httpd support driver
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <command.h>
> +#include <version.h>
> +#include <display_options.h>
> +#include <env.h>
> +#include <image.h>
> +#include <mapmem.h>
> +#include <malloc.h>
> +#include <net.h>
> +#include <net/tcp.h>
> +#include <net/httpd.h>
> +
> +#define HTTP_PORT              80
> +
> +#define MAX_URL_LEN            128
> +#define MAX_BOUNDARY_LEN       80
> +#define MAX_MPART_NAME_LEN     80
> +#define MAX_FILENAME_LEN       256
> +#define BUFFER_LEN             2048
> +
> +enum http_req_state {
> +       ST_REQ_LINE = 0,
> +       ST_REQ_HDR,
> +       ST_REQ_MPBOUNDARY,
> +       ST_REQ_MPART,
> +       ST_REQ_MPFILE,
> +       ST_REQ_MPEND,
> +       ST_REQ_DONE,
> +};
> +
> +enum http_reply_state {
> +       ST_REPLY_ERR = 0,
> +       ST_REPLY_HDR,
> +       ST_REPLY_BODY
> +};
> +
> +enum http_method {
> +       HTTP_UNKNOWN = -1,
> +       HTTP_GET,
> +       HTTP_POST,
> +       HTTP_HEAD,
> +       HTTP_OPTIONS,
> +};
> +
> +struct httpd_priv {
> +       enum http_req_state     req_state;
> +       enum http_reply_state   reply_state;
> +
> +       struct tcp_stream       *tcp;
> +
> +       enum http_method        method;
> +       char                    url[MAX_URL_LEN];
> +       u32                     version_major;
> +       u32                     version_minor;
> +       u32                     hdr_len;
> +
> +       u32                     post_fstart;
> +       u32                     post_flen;
> +       char                    post_fname[MAX_FILENAME_LEN];
> +       char                    post_name[MAX_MPART_NAME_LEN];
> +       char                    post_boundary[MAX_BOUNDARY_LEN];
> +
> +       int                     reply_code;
> +       u32                     reply_fstart;
> +       u32                     reply_flen;
> +       void                    *reply_fdata;
> +
> +       u32                     rx_processed;
> +       char                    buf[BUFFER_LEN];
> +};
> +
> +static struct http_reply options_reply = {
> +       .code      = 200,
> +       .code_msg  = "OK",
> +       .data_type = "text/plain",
> +       .data      = NULL,
> +       .len       = 0
> +};
> +
> +static int stop_server;
> +static int tsize_num_hash;
> +
> +static struct httpd_config *cfg;
> +
> +static void show_block_marker(u32 offs, u32 size)
> +{
> +       int cnt;
> +
> +       if (offs > size)
> +               offs = size;
> +
> +       cnt = offs * 50 / size;
> +       while (tsize_num_hash < cnt) {
> +               putc('#');
> +               tsize_num_hash++;
> +       }
> +
> +       if (cnt == 50)
> +               putc('\n');
> +}
> +
> +static void tcp_stream_on_closed(struct tcp_stream *tcp)
> +{
> +       struct httpd_priv *priv = tcp->priv;
> +
> +       if ((priv->req_state != ST_REQ_DONE) &&
> +           (priv->req_state >= ST_REQ_MPFILE)) {
> +               printf("\nHTTPD: transfer was terminated\n");
> +       }
> +
> +       if (cfg->on_req_end != NULL)
> +               cfg->on_req_end(tcp->priv);
> +
> +       free(tcp->priv);
> +
> +       if (stop_server)
> +               net_set_state(cfg->on_stop != NULL ?
> +                             cfg->on_stop() :
> +                             NETLOOP_SUCCESS);
> +}
> +
> +static void http_make_reply(struct httpd_priv *priv, struct http_reply *reply,
> +                           int head_only)
> +{
> +       int offs = 0;
> +
> +       if (priv->version_major >= 1) {
> +               offs = snprintf(priv->buf, sizeof(priv->buf),
> +                               "HTTP/%d.%d %d %s\r\n"
> +                               "Server: %s\r\n"
> +                               "Connection: close\r\n"
> +                               "Cache-Control: no-store\r\n"
> +                               "Content-Type: %s\r\n"
> +                               "Content-Length: %d\r\n",
> +                               priv->version_major, priv->version_minor,
> +                               reply->code, reply->code_msg, U_BOOT_VERSION,
> +                               reply->data_type,
> +                               head_only ? 0 : reply->len);
> +               if (priv->method == HTTP_OPTIONS)
> +                       offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
> +                                       "Access-Control-Allow-Methods: GET, HEAD, OPTIONS, POST\r\n");
> +               offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
> +                               "\r\n");
> +       }
> +
> +       priv->reply_code = reply->code;
> +       priv->reply_fstart = offs;
> +       if (!head_only) {
> +               priv->reply_flen = reply->len;
> +               priv->reply_fdata = reply->data;
> +       }
> +}
> +
> +static enum httpd_req_check http_parse_line(struct httpd_priv *priv, char *line)
> +{
> +       char                    *url, *version, *data, *end;
> +       u32                     len, tmp;
> +       enum httpd_req_check    ret;
> +       struct httpd_post_data  post;
> +
> +       switch (priv->req_state) {
> +       case ST_REQ_LINE:
> +               if (strncasecmp(line, "GET ", 4) == 0) {
> +                       priv->method = HTTP_GET;
> +                       url = line + 4;
> +               } else if (strncasecmp(line, "POST ", 5) == 0) {
> +                       priv->method = HTTP_POST;
> +                       url = line + 5;
> +               } else if (strncasecmp(line, "HEAD ", 5) == 0) {
> +                       priv->method = HTTP_HEAD;
> +                       url = line + 5;
> +               } else if (strncasecmp(line, "OPTIONS ", 8) == 0) {
> +                       priv->method = HTTP_OPTIONS;
> +                       url = line + 8;
> +               } else {
> +                       /* unknown request */
> +                       return HTTPD_CLNT_RST;
> +               }
> +
> +               version = strstr(url, " ");
> +               if (version == NULL) {
> +                       /* check for HTTP 0.9 */
> +                       if ((*url != '/') || (priv->method != HTTP_GET))
> +                               return HTTPD_CLNT_RST;
> +
> +                       if (strlen(url) >= MAX_URL_LEN)
> +                               return HTTPD_CLNT_RST;
> +
> +                       if (cfg->pre_get != NULL) {
> +                               ret = cfg->pre_get(priv, url);
> +                               if (ret != HTTPD_REQ_OK)
> +                                       return ret;
> +                       }
> +
> +                       priv->req_state = ST_REQ_DONE;
> +                       priv->hdr_len = strlen(line) + 2;
> +                       priv->version_major = 0;
> +                       priv->version_minor = 9;
> +                       strcpy(priv->url, url);
> +                       return HTTPD_REQ_OK;
> +               }
> +
> +               if (strncasecmp(version + 1, "HTTP/", 5) != 0) {
> +                       /* version is required for HTTP >= 1.0 */
> +                       return HTTPD_CLNT_RST;
> +               }
> +
> +               *version++ = '\0';
> +               version += strlen("HTTP/");
> +
> +               priv->version_major = dectoul(version, &end);
> +               switch (*end) {
> +               case '\0':
> +                       priv->version_minor = 0;
> +                       break;
> +               case '.':
> +                       priv->version_minor = dectoul(end + 1, &end);
> +                       if (*end == '\0')
> +                               break;
> +                       fallthrough;
> +               default:
> +                       /* bad version format */
> +                       return HTTPD_CLNT_RST;
> +               }
> +
> +               if (priv->version_major < 1) {
> +                       /* bad version */
> +                       return HTTPD_CLNT_RST;
> +               }
> +
> +               if ((priv->version_major > 1) || (priv->version_minor > 1)) {
> +                       /* We support HTTP/1.1 or early standards only */
> +                       priv->version_major = 1;
> +                       priv->version_minor = 1;
> +               }
> +
> +               if (*url != '/')
> +                       return HTTPD_CLNT_RST;
> +
> +               if (strlen(url) >= MAX_URL_LEN)
> +                       return HTTPD_CLNT_RST;
> +
> +               priv->req_state = ST_REQ_HDR;
> +               strcpy(priv->url, url);
> +               return HTTPD_REQ_OK;
> +
> +       case ST_REQ_HDR:
> +               if (*line == '\0') {
> +                       priv->hdr_len = priv->rx_processed + 2;
> +                       switch (priv->method) {
> +                       case HTTP_GET:
> +                       case HTTP_HEAD:
> +                               if (cfg->pre_get != NULL) {
> +                                       ret = cfg->pre_get(priv, priv->url);
> +                                       if (ret != HTTPD_REQ_OK)
> +                                               return ret;
> +                               }
> +                               fallthrough;
> +
> +                       case HTTP_OPTIONS:
> +                               priv->req_state = ST_REQ_DONE;
> +                               return HTTPD_REQ_OK;
> +
> +                       default:
> +                               break;
> +                       }
> +
> +                       if (*priv->post_boundary != '\0') {
> +                               priv->req_state = ST_REQ_MPBOUNDARY;
> +                               return HTTPD_REQ_OK;
> +                       }
> +                       /* NOT multipart/form-data POST request */
> +                       return HTTPD_BAD_REQ;
> +               }
> +
> +               if (priv->method != HTTP_POST)
> +                       return HTTPD_REQ_OK;
> +
> +               len = strlen("Content-Length: ");
> +               if (strncasecmp(line, "Content-Length: ", len) == 0) {
> +                       data = line + len;
> +                       priv->post_flen = simple_strtol(data, &end, 10);
> +                       if (*end != '\0') {
> +                               /* bad Content-Length string */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +                       return HTTPD_REQ_OK;
> +               }
> +
> +               len = strlen("Content-Type: ");
> +               if (strncasecmp(line, "Content-Type: ", len) == 0) {
> +                       data = strstr(line + len, " boundary=");
> +                       if (data == NULL) {
> +                               /* expect multipart/form-data format */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +
> +                       data += strlen(" boundary=");
> +                       if (strlen(data) >= sizeof(priv->post_boundary)) {
> +                               /* no space to keep boundary */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +
> +                       strcpy(priv->post_boundary, data);
> +                       return HTTPD_REQ_OK;
> +               }
> +
> +               return HTTPD_REQ_OK;
> +
> +       case ST_REQ_MPBOUNDARY:
> +               if (*line == '\0')
> +                       return HTTPD_REQ_OK;
> +               if ((line[0] != '-') || (line[1] != '-') ||
> +                   (strcmp(line + 2, priv->post_boundary) != 0)) {
> +                       /* expect boundary line */
> +                       return HTTPD_BAD_REQ;
> +               }
> +               priv->req_state = ST_REQ_MPART;
> +               return HTTPD_REQ_OK;
> +
> +       case ST_REQ_MPART:
> +               if (*line == '\0') {
> +                       if (*priv->post_name == '\0')
> +                               return HTTPD_BAD_REQ;
> +
> +                       priv->post_fstart = priv->rx_processed + 2;
> +                       priv->post_flen -= priv->post_fstart - priv->hdr_len;
> +                       /* expect: "\r\n--${boundary}--\r\n", so strlen() + 8 */
> +                       priv->post_flen -= strlen(priv->post_boundary) + 8;
> +
> +                       if (cfg->pre_post != NULL) {
> +                               post.addr     = NULL;
> +                               post.name     = priv->post_name;
> +                               post.filename = priv->post_fname;
> +                               post.size     = priv->post_flen;
> +
> +                               ret = cfg->pre_post(priv, priv->url, &post);
> +                               if (ret != HTTPD_REQ_OK)
> +                                       return ret;
> +                       }
> +
> +                       tsize_num_hash = 0;
> +                       printf("File: %s, %u bytes\n", priv->post_fname, priv->post_flen);
> +                       printf("Loading: ");
> +
> +                       priv->req_state = ST_REQ_MPFILE;
> +                       return HTTPD_REQ_OK;
> +               }
> +
> +               len = strlen("Content-Disposition: ");
> +               if (strncasecmp(line, "Content-Disposition: ", len) == 0) {
> +                       data = strstr(line + len, " name=\"");
> +                       if (data == NULL) {
> +                               /* name attribute not found */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +
> +                       data += strlen(" name=\"");
> +                       end = strstr(data, "\"");
> +                       if (end == NULL) {
> +                               /* bad name attribute format */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +
> +                       tmp = end - data;
> +                       if (tmp >= sizeof(priv->post_name)) {
> +                               /* multipart name is too long */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +                       strncpy(priv->post_name, data, tmp);
> +                       priv->post_name[tmp] = '\0';
> +
> +                       data = strstr(line + len, " filename=\"");
> +                       if (data == NULL) {
> +                               /* filename attribute not found */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +
> +                       data += strlen(" filename=\"");
> +                       end = strstr(data, "\"");
> +                       if (end == NULL) {
> +                               /* bad filename attribute format */
> +                               return HTTPD_BAD_REQ;
> +                       }
> +
> +                       tmp = end - data;
> +                       if (tmp >= sizeof(priv->post_fname))
> +                               tmp = sizeof(priv->post_fname) - 1;
> +                       strncpy(priv->post_fname, data, tmp);
> +                       priv->post_fname[tmp] = '\0';
> +                       return HTTPD_REQ_OK;
> +               }
> +
> +               return HTTPD_REQ_OK;
> +
> +       case ST_REQ_MPEND:
> +               if (*line == '\0')
> +                       return HTTPD_REQ_OK;
> +
> +               len = strlen(priv->post_boundary);
> +               if ((line[0] != '-') || (line[1] != '-') ||
> +                   (strncmp(line + 2, priv->post_boundary, len) != 0) ||
> +                   (line[len + 2] != '-') || (line[len + 3] != '-') ||
> +                   (line[len + 4] != '\0')) {
> +                       /* expect final boundary line */
> +                       return HTTPD_BAD_REQ;
> +               }
> +               priv->req_state = ST_REQ_DONE;
> +               return HTTPD_REQ_OK;
> +
> +       default:
> +               return HTTPD_BAD_REQ;
> +       }
> +}
> +
> +static enum httpd_req_check http_parse_buf(struct httpd_priv *priv,
> +                                          char *buf, u32 size)
> +{
> +       char                    *eol_pos;
> +       u32                     len;
> +       enum httpd_req_check    ret;
> +
> +       buf[size] = '\0';
> +       while (size > 0) {
> +               eol_pos = strstr(buf, "\r\n");
> +               if (eol_pos == NULL)
> +                       break;
> +
> +               *eol_pos = '\0';
> +               len = eol_pos + 2 - buf;
> +
> +               ret = http_parse_line(priv, buf);
> +               if (ret != HTTPD_REQ_OK) {
> +                       /* request processing error */
> +                       return ret;
> +               }
> +
> +               priv->rx_processed += len;
> +               buf += len;
> +               size -= len;
> +
> +               if ((priv->req_state == ST_REQ_MPFILE) ||
> +                   (priv->req_state == ST_REQ_DONE))
> +                       return HTTPD_REQ_OK;
> +       }
> +       /* continue when more data becomes available */
> +       return HTTPD_REQ_OK;
> +}
> +
> +static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
> +{
> +       struct httpd_priv       *priv;
> +       void                    *ptr;
> +       u32                     shift, size;
> +       enum httpd_req_check    ret;
> +       struct http_reply       *reply;
> +       struct httpd_post_data  post;
> +
> +       priv = tcp->priv;
> +
> +       switch (priv->req_state) {
> +       case ST_REQ_DONE:
> +               return;
> +
> +       case ST_REQ_MPFILE:
> +               show_block_marker(rx_bytes - priv->post_fstart,
> +                                 priv->post_flen);
> +               if (rx_bytes < priv->post_fstart + priv->post_flen) {
> +                       priv->rx_processed = rx_bytes;
> +                       return;
> +               }
> +               priv->req_state = ST_REQ_MPEND;
> +               priv->rx_processed = priv->post_fstart + priv->post_flen;
> +               fallthrough;
> +
> +       case ST_REQ_MPEND:
> +               shift = priv->rx_processed - priv->post_fstart;
> +               ptr = map_sysmem(image_load_addr + shift,
> +                                rx_bytes - priv->rx_processed);
> +               ret = http_parse_buf(priv, ptr,
> +                                    rx_bytes - priv->rx_processed);
> +               unmap_sysmem(ptr);
> +
> +               if (ret != HTTPD_REQ_OK)
> +                       goto error;
> +               if (priv->req_state != ST_REQ_DONE)
> +                       return;
> +               break;
> +
> +       default:
> +               ret = http_parse_buf(priv, priv->buf + priv->rx_processed,
> +                                    rx_bytes - priv->rx_processed);
> +               if (ret != HTTPD_REQ_OK)
> +                       goto error;
> +
> +               if (priv->req_state == ST_REQ_MPFILE) {
> +                       /*
> +                        * We just switched from parsing of HTTP request
> +                        * headers to binary data reading. Our tcp->rx
> +                        * handler may put some binary data to priv->buf.
> +                        * It's time to copy these data to a proper place.
> +                        * It's required to copy whole buffer data starting
> +                        * from priv->rx_processed position. Otherwise we
> +                        * may miss data placed after the first hole.
> +                        */
> +                       size = sizeof(priv->buf) - priv->rx_processed;
> +                       if (size > 0) {
> +                               ptr = map_sysmem(image_load_addr, size);
> +                               memcpy(ptr, priv->buf + priv->rx_processed, size);
> +                               unmap_sysmem(ptr);
> +                       }
> +
> +                       show_block_marker(rx_bytes - priv->post_fstart,
> +                                         priv->post_flen);
> +               }
> +
> +               if (priv->req_state != ST_REQ_DONE)
> +                       return;
> +               break;
> +       }
> +
> +       switch (priv->method) {
> +       case HTTP_OPTIONS:
> +               reply = &options_reply;
> +               break;
> +
> +       case HTTP_GET:
> +       case HTTP_HEAD:
> +               if (cfg->get == NULL) {
> +                       ret = HTTPD_BAD_REQ;
> +                       goto error;
> +               }
> +               reply = cfg->get(priv, priv->url);
> +               break;
> +
> +       case HTTP_POST:
> +               if (cfg->post == NULL) {
> +                       ret = HTTPD_BAD_REQ;
> +                       goto error;
> +               }
> +               post.name     = priv->post_name;
> +               post.filename = priv->post_fname;
> +               post.size     = priv->post_flen;
> +               post.addr     = map_sysmem(image_load_addr, post.size);
> +               reply = cfg->post(priv, priv->url, &post);
> +               unmap_sysmem(post.addr);
> +               break;
> +
> +       default:
> +               ret = HTTPD_BAD_REQ;
> +               goto error;
> +       }
> +
> +       http_make_reply(priv, reply, priv->method == HTTP_HEAD);
> +       return;
> +
> +error:
> +       priv->req_state = ST_REQ_DONE;
> +       switch (ret) {
> +       case HTTPD_BAD_URL:
> +               http_make_reply(priv, cfg->error_404, 0);
> +               break;
> +       case HTTPD_BAD_REQ:
> +               http_make_reply(priv, cfg->error_400, 0);
> +               break;
> +       default:
> +               tcp_stream_reset(tcp);
> +               break;
> +       }
> +}
> +
> +static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
> +{
> +       void                    *ptr;
> +       struct httpd_priv       *priv;
> +       u32                     shift;
> +
> +       priv = tcp->priv;
> +       switch (priv->req_state) {
> +       case ST_REQ_DONE:
> +               return len;
> +       case ST_REQ_MPFILE:
> +       case ST_REQ_MPEND:
> +               shift = rx_offs - priv->post_fstart;
> +               ptr = map_sysmem(image_load_addr + shift, len);
> +               memcpy(ptr, buf, len);
> +               unmap_sysmem(ptr);
> +               return len;
> +       default:
> +               /*
> +                * accept data that fits to buffer,
> +                * reserve space for end of line symbol
> +                */
> +               if (rx_offs + len > sizeof(priv->buf) - 1)
> +                       len = sizeof(priv->buf) - rx_offs - 1;
> +               memcpy(priv->buf + rx_offs, buf, len);
> +               return len;
> +       }
> +}
> +
> +static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
> +{
> +       struct httpd_priv *priv;
> +
> +       priv = tcp->priv;
> +       if ((priv->req_state == ST_REQ_DONE) &&
> +           (tx_bytes == priv->reply_fstart + priv->reply_flen))
> +               tcp_stream_close(tcp);
> +}
> +
> +static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
> +{
> +       struct httpd_priv       *priv;
> +       u32                     len, bytes = 0;
> +       char                    *ptr;
> +
> +       priv = tcp->priv;
> +       if (priv->req_state != ST_REQ_DONE)
> +               return 0;
> +
> +       if (tx_offs < priv->reply_fstart) {
> +               len = maxlen;
> +               if (len > priv->reply_fstart - tx_offs)
> +                       len = priv->reply_fstart - tx_offs;
> +               memcpy(buf, priv->buf + tx_offs, len);
> +               buf += len;
> +               tx_offs += len;
> +               bytes += len;
> +               maxlen -= len;
> +       }
> +
> +       if (tx_offs >= priv->reply_fstart) {
> +               if (tx_offs + maxlen > priv->reply_fstart + priv->reply_flen)
> +                       maxlen = priv->reply_fstart + priv->reply_flen - tx_offs;
> +               if (maxlen > 0) {
> +                       ptr = priv->reply_fdata + tx_offs - priv->reply_fstart;
> +                       memcpy(buf, ptr, maxlen);
> +                       bytes += maxlen;
> +               }
> +       }
> +
> +       return bytes;
> +}
> +
> +static int tcp_stream_on_create(struct tcp_stream *tcp)
> +{
> +       struct httpd_priv       *priv;
> +
> +       if ((cfg == NULL) || stop_server ||
> +           (tcp->lport != HTTP_PORT))
> +               return 0;
> +
> +       priv = malloc(sizeof(struct httpd_priv));
> +       if (priv == NULL)
> +               return 0;
> +
> +       memset(priv, 0, sizeof(struct httpd_priv));
> +       priv->tcp = tcp;
> +
> +       tcp->priv = priv;
> +       tcp->on_closed = tcp_stream_on_closed;
> +       tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
> +       tcp->rx = tcp_stream_rx;
> +       tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
> +       tcp->tx = tcp_stream_tx;
> +       return 1;
> +}
> +
> +void httpd_setup(struct httpd_config *config)
> +{
> +       cfg = config;
> +}
> +
> +void httpd_stop(void)
> +{
> +       stop_server = 1;
> +}
> +
> +void httpd_start(void)
> +{
> +       if (cfg == NULL) {
> +               net_set_state(NETLOOP_FAIL);
> +               return;
> +       }
> +       stop_server = 0;
> +       memset(net_server_ethaddr, 0, 6);
> +       tcp_stream_set_on_create_handler(tcp_stream_on_create);
> +       printf("HTTPD listening on port %d...\n", HTTP_PORT);
> +}
> diff --git a/net/net.c b/net/net.c
> index 809fe5c4792..ca761c57372 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -111,6 +111,7 @@
>  #include <net/tcp.h>
>  #include <net/wget.h>
>  #include <net/netcat.h>
> +#include <net/httpd.h>
>  #include "arp.h"
>  #include "bootp.h"
>  #include "cdp.h"
> @@ -575,6 +576,11 @@ restart:
>                         netcat_store_start();
>                         break;
>  #endif
> +#if defined(CONFIG_HTTPD_COMMON)
> +               case HTTPD:
> +                       httpd_start();
> +                       break;
> +#endif
>  #if defined(CONFIG_CMD_CDP)
>                 case CDP:
>                         cdp_start();
> --
> 2.43.0
>
