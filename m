Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D228D3C906
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A7C88DC8;
	Sat, 19 Oct 2024 13:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MbcItkVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE33088DC8; Sat, 19 Oct 2024 13:50:46 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4BA88F68
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b152a23e9aso184020385a.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338643; x=1729943443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LH+UONprx5eGgnDGEb5OUpZfq2MGHFfGG3P2dHRwWX0=;
 b=MbcItkVFRhVosMWC9AToSwzvlE6n2y6qNYGnMBlLGJ6Va8kX57dNDFXcFj5xvGT8nN
 DWin96xSDx6bvakTXB475U/P46LJKPHnND12bYblCHVAB/eM67WCf9fI5utb/B66+Ne+
 oahAWs8wvqWe1ILA6s50/zdngcyhyATN+ZuSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338643; x=1729943443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LH+UONprx5eGgnDGEb5OUpZfq2MGHFfGG3P2dHRwWX0=;
 b=JwHbITaSuuJp882H/Os8Of36qAB8IAmd12FGMQK5rVYISJVhI/CNkQdYIU4YRASdNg
 9BWo8a6O2SxtUoxyuSLbElUnWc7b5FT90CBIz4EIRgel/DHjSeLyETWMMXa1wRN+M6Hr
 d7n07iSx+WHM48CSaRLEIG+dKK1lie8FpFNO5Am+rtgqF/t+b+4SdF2tT8sY0geT1kai
 +PA/ThpZwW56/CZZhszRTHvFy0XbYg71tzbz1afoU1189IT75AHTGT+t9VP9ihVd2a31
 W0/Pb3NZgTDam9PiEElGa9yz1EM7uuTFLSgBAE4EhRr8yaF5vG7WEBr7ew4KpzSUFN5Y
 Y7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIvIiBah9tH2rhy/rxrPvN5jFxlLqbigCAd+jj3NGMeMY08bSxBOKVwaC3uFC6vQgKONZAg84=@lists.denx.de
X-Gm-Message-State: AOJu0YwcutPGwPCY/iEHf75k29Z83RlyJ1+/aK+LilFfJugUzRJhMlgU
 cQ8AWIfjZzqvvf6aLk30rGh8eBINlyJ5pgqNWM6zYACu8M+uMMbFQR8EkK0QNvVsXLM6hulldlX
 8EVaXHkCo+FiyGKDZ+64rxwKIlQFI54PtWRnW
X-Google-Smtp-Source: AGHT+IF9QJbpHvhSYrBuixiKg6hO5BBWtuHjuMCbzs8J6NgrTAOmoawkrDLapJYVSm/i2UDQ00uJGvWsPePpp82oiiA=
X-Received: by 2002:a05:6214:451b:b0:6cb:ae4e:20de with SMTP id
 6a1803df08f44-6cde15d9ccbmr81675476d6.32.1729338643420; Sat, 19 Oct 2024
 04:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-5-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:50:32 -0600
Message-ID: <CAFLszTj-f9BwFd3oO8uZGS=D_8wDtUcKQD9-9mU1rVUZin9f-Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] net: lwip: Enable https:// support for wget
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Javier Tia <javier.tia@linaro.org>,
 u-boot@lists.denx.de
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

Hi Ilias,

On Fri, 18 Oct 2024 at 08:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> With the recent changes of lwip & mbedTLS we can now download from
> https:// urls instead of just http://.
> Adjust our wget lwip version parsing to support both URLs.
> While at it adjust the default TCP window for QEMU since https seems to
> requite at least 16384
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  cmd/Kconfig      | 19 ++++++++++++
>  net/lwip/Kconfig |  2 +-
>  net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 91 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 8c677b1e4864..e58566a9ba34 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2118,6 +2118,25 @@ config CMD_WGET
>           wget is a simple command to download kernel, or other files,
>           from a http server over TCP.
>
> +config WGET_HTTPS
> +       bool "wget https"
> +       depends on CMD_WGET

Is it possible to do wget programmatically, i.e. without CMDLINE?

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
> index b495ebd1aa96..b4f039d38962 100644
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
> +       int err;

ret

> +
> +       *olen = 0;
> +
> +       err = uclass_get_device(UCLASS_RNG, 0, &dev);

Using uclass_get_device_by_seq() would allow aliases to select which
device is used.

> +       if (err)
> +               return err;
> +       err = dm_rng_read(dev, &rng, sizeof(rng));
> +       if (err) {
> +               log_err("Failed to get an rng: %d\n", err);

If you are showing an error, I think it is more likely to happen when
trying to find the device, so perhaps do this on the
uclass_get_device() call?

> +               return err;
> +       }
> +
> +       memcpy(output, &rng, len);
> +       *olen = sizeof(rng);

But then why not dm_rng_read() into output and avoid the u64?
Actually, dm_rng_ops-read() should return the number of bytes,
perhaps?

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

if (IS_ENABLED(CONFIG_WGET_HTTPS))

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

Regards,
Simon
