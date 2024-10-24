Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863DBCE8E78
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F6A88E63;
	Thu, 24 Oct 2024 16:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cgfX3nWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A76388E63; Thu, 24 Oct 2024 16:05:04 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCB588F69
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e30116efc9so773621a91.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778696; x=1730383496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+8VWmrcWy7eJR8258Gnwp3mqaFMCWiGUyxEnjX+jUh0=;
 b=cgfX3nWOnfdmPW6G2Gos+aQbDiPC6iYVKwLvoxaNk+Fxw5lt+qrwzWk62SIyN/BFk8
 bJ3EAaAt+tCK6szCWf2XzNf04aQHp6XUyLQAXJML9/rNbwb9/AlkP9BHzjXW1qji1Qps
 2pdHQwJsdNifnlNcQBS0Xoh2EVIj9RQgC5zI31fSnLOQb10x/fog9GU6eL0Zypa4wuh2
 KgVKVb/IRe3WkIMWPw/Quh7JSnQnvv97vkk5FsM0JogWvdZ4Y9+lVwRP6wIlckh6sTIZ
 Go9vCr7k/08shSeiPF5dg2WaGw8ntD5Rj+P7Lx10XIDW+YYsypFmXsKg1glF8e64C4Ww
 YPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778696; x=1730383496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8VWmrcWy7eJR8258Gnwp3mqaFMCWiGUyxEnjX+jUh0=;
 b=Gr9HpxQIIVWvCxf2oa0l3H4VZ8fbbmZdKqHfyjh72EkhxUDXpqJpfiKQxbwcWuNDLv
 FmxtUohl/LTDG+lXrPwLS28x6CLiVGsqj6WJ6mYjPgmF5R/xsMvDBidc+Q1q78ColdYb
 NHpv0zTDbLNUSQQ2NJpaThkgGeKaawqL/dB3WpGtNosbOTVSj3LRYTg+P5ebj6pzgOhe
 y6k3b85q2vU0+DuXT95Bxgw5m+JwMUt578bgTk1Ij/FyauBtbAIDfXakxE5IejYGqDx2
 uD0xmQ4QNnJs+el5sSK4G5ksb69Um4RnVBLXf27JxIV7DsDdq59GWxJnM7IDrQTCz/PO
 3xQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVbPEyX7+yiT7Exsuxi2xWGbh+QHIY+fEjtta//Ntv9P6MiwGeuOi6DepTUV8BEfeCj/IHkgY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxhd8nr1hinA4n5NobWQ1ckMQv0jQlfwRLvp+QoAC0kvJIGHX0S
 S+qjnvBiynEsyysLngIWb+MVMWSLqmS/ER9+RN2S6BNxin5jTDQuMyG+sCp+iak070CPwQ5j/W3
 C+zIZNnEIK/7C+TcDfMyCIoJIRVgzbquf3mwzgQ==
X-Google-Smtp-Source: AGHT+IEws+o2izwiTsIxTMasxKuDWnN/jaOjdYAMVyIZMZe8vG7VKdiqL4hJO8yhN73FIgu96WJpTuF+V01J2wurBvc=
X-Received: by 2002:a17:90b:4c48:b0:2e2:cef9:4d98 with SMTP id
 98e67ed59e1d1-2e77f6d8cd6mr2255083a91.25.1729778694745; Thu, 24 Oct 2024
 07:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Oct 2024 17:04:17 +0300
Message-ID: <CAC_iWjLuqUTKW-okV85RULz-P61kDbniEVERHDeBWpKu5gXcUw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: lwip: Enable https:// support for wget
To: jerome.forissier@linaro.org, raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
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

Replying to myself here but

On Thu, 24 Oct 2024 at 14:25, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> With the recent changes of lwip & mbedTLS we can now download from
> https:// urls instead of just http://.
> Adjust our wget lwip version parsing to support both URLs.
> While at it adjust the default TCP window for QEMU since https seems to
> require at least 16384
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  cmd/Kconfig      | 19 ++++++++++++
>  net/lwip/Kconfig |  2 +-
>  net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 91 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 3ee70f31b142..1d90a884e2c1 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2126,6 +2126,25 @@ config CMD_WGET
>           wget is a simple command to download kernel, or other files,
>           from a http server over TCP.
>
> +config WGET_HTTPS
> +       bool "wget https"
> +       depends on CMD_WGET
> +       depends on PROT_TCP_LWIP
> +       depends on MBEDTLS_LIB
> +        select SHA256
> +        select RSA
> +        select ASYMMETRIC_KEY_TYPE
> +        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> +        select X509_CERTIFICATE_PARSER
> +        select PKCS7_MESSAGE_PARSER
> +       select MBEDTLS_LIB_CRYPTO
> +       select MBEDTLS_LIB_TLS
> +       select RSA_VERIFY_WITH_PKEY
> +       select X509_CERTIFICATE_PARSER
> +       select PKCS7_MESSAGE_PARSER
> +       help
> +         Enable TLS over http for wget.
> +
>  endif  # if CMD_NET
>
>  config CMD_PXE
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> index 8a67de4cf335..a9ae9bf7fa2a 100644
> --- a/net/lwip/Kconfig
> +++ b/net/lwip/Kconfig
> @@ -37,7 +37,7 @@ config PROT_UDP_LWIP
>
>  config LWIP_TCP_WND
>         int "Value of TCP_WND"
> -       default 8000 if ARCH_QEMU
> +       default 32768 if ARCH_QEMU
>         default 3000000
>         help
>           Default value for TCP_WND in the lwIP configuration
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b495ebd1aa96..1a2ecdcddf34 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -7,13 +7,17 @@
>  #include <efi_loader.h>
>  #include <image.h>
>  #include <lwip/apps/http_client.h>
> +#include "lwip/altcp_tls.h"
>  #include <lwip/timeouts.h>
> +#include <rng.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <time.h>
> +#include <dm/uclass.h>
>
>  #define SERVER_NAME_SIZE 200
>  #define HTTP_PORT_DEFAULT 80
> +#define HTTPS_PORT_DEFAULT 443
>  #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
>
>  enum done_state {
> @@ -32,18 +36,53 @@ struct wget_ctx {
>         enum done_state done;
>  };
>
> +bool wget_validate_uri(char *uri);
> +
> +int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
> +                         size_t *olen)
> +{
> +       struct udevice *dev;
> +       u64 rng = 0;
> +       int ret;
> +
> +       *olen = 0;
> +
> +       ret = uclass_get_device(UCLASS_RNG, 0, &dev);
> +       if (ret) {
> +               log_err("Failed to get an rng: %d\n", ret);
> +               return ret;
> +       }
> +       ret = dm_rng_read(dev, &rng, sizeof(rng));
> +       if (ret)
> +               return ret;
> +
> +       memcpy(output, &rng, len);
> +       *olen = sizeof(rng);

I just realized I forgot to address this. I'll fix it on v3, but the
rest of the code is ok to review

Thanks
/Ilias
> +
> +       return 0;
> +}
> +
>  static int parse_url(char *url, char *host, u16 *port, char **path)
>  {
>         char *p, *pp;
>         long lport;
> +       size_t prefix_len = 0;
> +
> +       if (!wget_validate_uri(url)) {
> +               log_err("Invalid URL. Use http(s)://\n");
> +               return -EINVAL;
> +       }
>
> +       *port = HTTP_PORT_DEFAULT;
> +       prefix_len = strlen("http://");
>         p = strstr(url, "http://");
>         if (!p) {
> -               log_err("only http:// is supported\n");
> -               return -EINVAL;
> +               p = strstr(url, "https://");
> +               prefix_len = strlen("https://");
> +               *port = HTTPS_PORT_DEFAULT;
>         }
>
> -       p += strlen("http://");
> +       p += prefix_len;
>
>         /* Parse hostname */
>         pp = strchr(p, ':');
> @@ -67,9 +106,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
>                 if (lport > 65535)
>                         return -EINVAL;
>                 *port = (u16)lport;
> -       } else {
> -               *port = HTTP_PORT_DEFAULT;
>         }
> +
>         if (*pp != '/')
>                 return -EINVAL;
>         *path = pp;
> @@ -210,6 +248,9 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
>         char server_name[SERVER_NAME_SIZE];
> +#if defined CONFIG_WGET_HTTPS
> +       altcp_allocator_t tls_allocator;
> +#endif
>         httpc_connection_t conn;
>         httpc_state_t *state;
>         struct netif *netif;
> @@ -232,6 +273,22 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>                 return -1;
>
>         memset(&conn, 0, sizeof(conn));
> +#if defined CONFIG_WGET_HTTPS
> +       if (port == HTTPS_PORT_DEFAULT) {
> +               tls_allocator.alloc = &altcp_tls_alloc;
> +               tls_allocator.arg =
> +                       altcp_tls_create_config_client(NULL, 0, server_name);
> +
> +               if (!tls_allocator.arg) {
> +                       log_err("error: Cannot create a TLS connection\n");
> +                       net_lwip_remove_netif(netif);
> +                       return -1;
> +               }
> +
> +               conn.altcp_allocator = &tls_allocator;
> +       }
> +#endif
> +
>         conn.result_fn = httpc_result_cb;
>         ctx.path = path;
>         if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> @@ -316,6 +373,7 @@ bool wget_validate_uri(char *uri)
>         char c;
>         bool ret = true;
>         char *str_copy, *s, *authority;
> +       size_t prefix_len = 0;
>
>         for (c = 0x1; c < 0x21; c++) {
>                 if (strchr(uri, c)) {
> @@ -323,15 +381,21 @@ bool wget_validate_uri(char *uri)
>                         return false;
>                 }
>         }
> +
>         if (strchr(uri, 0x7f)) {
>                 log_err("invalid character is used\n");
>                 return false;
>         }
>
> -       if (strncmp(uri, "http://", 7)) {
> -               log_err("only http:// is supported\n");
> +       if (!strncmp(uri, "http://", strlen("http://"))) {
> +               prefix_len = strlen("http://");
> +       } else if (!strncmp(uri, "https://", strlen("https://"))) {
> +               prefix_len = strlen("https://");
> +       } else {
> +               log_err("only http(s):// is supported\n");
>                 return false;
>         }
> +
>         str_copy = strdup(uri);
>         if (!str_copy)
>                 return false;
> --
> 2.45.2
>
