Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB20D5E15A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA3F890B9;
	Fri,  8 Nov 2024 12:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qaTPN9yT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A378890BC; Fri,  8 Nov 2024 12:32:04 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D252890B1
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cdbe608b3so21179645ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731065521; x=1731670321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A4TrYCl75jahhsE/Ytyp6mKFYf3gmVx8FnXMZqXwv7M=;
 b=qaTPN9yTST70mFcGUZQXbXfzELWjh+1fgUoPknGrL1x4ywJh67GUa+XGSr8XXof0q8
 sawLDAVoLuG008IzsANd5KvdZybnUl65jElrVmXGinYvvi5uYX144ew5Oo+xIfgMhHCN
 z7+f729G1v62l+pr2Ma99tdfZ3BwQO8KwcwGTNR1tm2lCN344wxy5UD9PwTCwQjKcLQQ
 WurhtbMyVfEn1aIXUSg6xu/u0rB9IKXMoPz6WaY8pRX/xg/e5iDjVBGo+Ee91g1sopN/
 1Bw8kDS2vSZHHLtYq7XuUAzclnykyaREP9s6tW74w90wWfoSGqcGMQyGpz4rZm7cwRd0
 bIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731065521; x=1731670321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A4TrYCl75jahhsE/Ytyp6mKFYf3gmVx8FnXMZqXwv7M=;
 b=gE8hjPqPOyv1iTBH1XzbUUjcUob5O+4PXA4tJJBWo0xKLlZt3fMbdfoe1qhoWW8omY
 M/cz9Y7PC/1PndUveI3OzEwnTHHVQGMxs3TvhLGGteTj+i7LLBqHVuZazv8E5GAKVE8u
 3fYtxTbh0npHSzrSA+IoRWJ7zd/Vro+E175SlCGyc5xXcljM1M8HoJU4CguJ/VTneqjD
 loVtcfi96ouof0SJP48XbPXjl5+io+50sLR9ITROVsbwgPRvVAiPdMBG6zwosoLuNKsb
 npRwFR/S5tVmFmStB2IFxkn8f7bZawXNQ3KlMm9XBbyM24yysmlpty6/jCB/XzUhGxGK
 +ZdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCO+KB5+4TAq58pQ3MIyz27rNk6Ca6h2I3BTaeUCMHpWmSnThoKLQkX85Nbe5dPwIoNN65NZE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7yGHINkB3kW9oyqz4CIeflA1/GOw0cKgwaDIRpzqduya/AJB7
 0QFFgdRC5H4i2mG6gnOpgM2Q8ED5CZvACMMA+QlE5YCEkIMiR9vBwT5JoMTzGX76sym0mreGwCJ
 1PIqer7xwy9eN1QySFrwoW3HVqxtNOpIYt3r+CQ==
X-Google-Smtp-Source: AGHT+IGC5ierz55SSgj4+UxyOVrsps0Re8mgpF94TWs5AwxOykb3vKAcFiuwWSV9Ylyg6ybRhGMQkVW9VqX9oa7jH2Y=
X-Received: by 2002:a17:90b:2f0d:b0:2e0:80e8:a31a with SMTP id
 98e67ed59e1d1-2e9b174633bmr3003861a91.35.1731065520540; Fri, 08 Nov 2024
 03:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
 <fc4c79a4-2a78-41c5-8ea9-2c19e91d64b9@linaro.org>
In-Reply-To: <fc4c79a4-2a78-41c5-8ea9-2c19e91d64b9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Nov 2024 11:31:24 +0000
Message-ID: <CAC_iWj+VwDa4fL_UMe6p7roEN+kXNwTLVvWHM+DPJti8zOMZ9A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: lwip: Enable https:// support for wget
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: raymond.mao@linaro.org, xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
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

Hi Jerome

On Wed, 6 Nov 2024 at 13:50, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Ilias,
>
> On 10/24/24 12:24, Ilias Apalodimas wrote:
> > With the recent changes of lwip & mbedTLS we can now download from
> > https:// urls instead of just http://.
> > Adjust our wget lwip version parsing to support both URLs.
> > While at it adjust the default TCP window for QEMU since https seems to
> > require at least 16384
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  cmd/Kconfig      | 19 ++++++++++++
> >  net/lwip/Kconfig |  2 +-
> >  net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 91 insertions(+), 8 deletions(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 3ee70f31b142..1d90a884e2c1 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2126,6 +2126,25 @@ config CMD_WGET
> >         wget is a simple command to download kernel, or other files,
> >         from a http server over TCP.
> >
> > +config WGET_HTTPS
> > +     bool "wget https"
> > +     depends on CMD_WGET
> > +     depends on PROT_TCP_LWIP
> > +     depends on MBEDTLS_LIB
> > +        select SHA256
> > +        select RSA
> > +        select ASYMMETRIC_KEY_TYPE
> > +        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +        select X509_CERTIFICATE_PARSER
> > +        select PKCS7_MESSAGE_PARSER
> > +     select MBEDTLS_LIB_CRYPTO
> > +     select MBEDTLS_LIB_TLS
> > +     select RSA_VERIFY_WITH_PKEY
> > +     select X509_CERTIFICATE_PARSER
> > +     select PKCS7_MESSAGE_PARSER
> > +     help
> > +       Enable TLS over http for wget.
>
> s/http/HTTP/
> Maybe add "This adds support for https:// URLs"?

Sure

>
> > +
> >  endif  # if CMD_NET
> >
> >  config CMD_PXE
> > diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> > index 8a67de4cf335..a9ae9bf7fa2a 100644
> > --- a/net/lwip/Kconfig
> > +++ b/net/lwip/Kconfig
> > @@ -37,7 +37,7 @@ config PROT_UDP_LWIP
> >
> >  config LWIP_TCP_WND
> >       int "Value of TCP_WND"
> > -     default 8000 if ARCH_QEMU
> > +     default 32768 if ARCH_QEMU
> >       default 3000000
> >       help
> >         Default value for TCP_WND in the lwIP configuration
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index b495ebd1aa96..1a2ecdcddf34 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -7,13 +7,17 @@
> >  #include <efi_loader.h>
> >  #include <image.h>
> >  #include <lwip/apps/http_client.h>
> > +#include "lwip/altcp_tls.h"
> >  #include <lwip/timeouts.h>
> > +#include <rng.h>
> >  #include <mapmem.h>
> >  #include <net.h>
> >  #include <time.h>
> > +#include <dm/uclass.h>
> >
> >  #define SERVER_NAME_SIZE 200
> >  #define HTTP_PORT_DEFAULT 80
> > +#define HTTPS_PORT_DEFAULT 443
> >  #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
> >
> >  enum done_state {
> > @@ -32,18 +36,53 @@ struct wget_ctx {
> >       enum done_state done;
> >  };
> >
> > +bool wget_validate_uri(char *uri);
> > +
> > +int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
> > +                       size_t *olen)
> > +{
> > +     struct udevice *dev;
> > +     u64 rng = 0;
> > +     int ret;
> > +
> > +     *olen = 0;
> > +
> > +     ret = uclass_get_device(UCLASS_RNG, 0, &dev);
> > +     if (ret) {
> > +             log_err("Failed to get an rng: %d\n", ret);
> > +             return ret;
> > +     }
> > +     ret = dm_rng_read(dev, &rng, sizeof(rng));
> > +     if (ret)
> > +             return ret;
> > +
> > +     memcpy(output, &rng, len);
> > +     *olen = sizeof(rng);
> > +
> > +     return 0;
> > +}
> > +
> >  static int parse_url(char *url, char *host, u16 *port, char **path)
> >  {
> >       char *p, *pp;
> >       long lport;
> > +     size_t prefix_len = 0;
> > +
> > +     if (!wget_validate_uri(url)) {
> > +             log_err("Invalid URL. Use http(s)://\n");
> > +             return -EINVAL;
> > +     }
> >
> > +     *port = HTTP_PORT_DEFAULT;
> > +     prefix_len = strlen("http://");
> >       p = strstr(url, "http://");
> >       if (!p) {
> > -             log_err("only http:// is supported\n");
> > -             return -EINVAL;
> > +             p = strstr(url, "https://");
> > +             prefix_len = strlen("https://");
> > +             *port = HTTPS_PORT_DEFAULT;
> >       }
> >
> > -     p += strlen("http://");
> > +     p += prefix_len;
> >
> >       /* Parse hostname */
> >       pp = strchr(p, ':');
> > @@ -67,9 +106,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
> >               if (lport > 65535)
> >                       return -EINVAL;
> >               *port = (u16)lport;
> > -     } else {
> > -             *port = HTTP_PORT_DEFAULT;
> >       }
> > +
> >       if (*pp != '/')
> >               return -EINVAL;
> >       *path = pp;
> > @@ -210,6 +248,9 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> >  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >  {
> >       char server_name[SERVER_NAME_SIZE];
> > +#if defined CONFIG_WGET_HTTPS
> > +     altcp_allocator_t tls_allocator;
> > +#endif
> >       httpc_connection_t conn;
> >       httpc_state_t *state;
> >       struct netif *netif;
> > @@ -232,6 +273,22 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >               return -1;
> >
> >       memset(&conn, 0, sizeof(conn));
> > +#if defined CONFIG_WGET_HTTPS
> > +     if (port == HTTPS_PORT_DEFAULT) {
>
> Does this mean the port has to be 443 for HTTPS to be used? Or that
> plain HTTP is not possible over port 443? That would be overly restrictive
> IMO.

We set that port in parse_url(). So if http:// is parsed we will, by
default, set it to 80 and if https:// is found we set it to 443.
But I think you are right, we already support configurable port
numbers which I missed, so I'll just pass a bool to parse_url and only
enable this for https:// regardless of the port

Cheers
/Ilias
>
> > +             tls_allocator.alloc = &altcp_tls_alloc;
> > +             tls_allocator.arg =
> > +                     altcp_tls_create_config_client(NULL, 0, server_name);
> > +
> > +             if (!tls_allocator.arg) {
> > +                     log_err("error: Cannot create a TLS connection\n");
> > +                     net_lwip_remove_netif(netif);
> > +                     return -1;
> > +             }
> > +
> > +             conn.altcp_allocator = &tls_allocator;
> > +     }
> > +#endif
> > +
> >       conn.result_fn = httpc_result_cb;
> >       ctx.path = path;
> >       if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> > @@ -316,6 +373,7 @@ bool wget_validate_uri(char *uri)
> >       char c;
> >       bool ret = true;
> >       char *str_copy, *s, *authority;
> > +     size_t prefix_len = 0;
> >
> >       for (c = 0x1; c < 0x21; c++) {
> >               if (strchr(uri, c)) {
> > @@ -323,15 +381,21 @@ bool wget_validate_uri(char *uri)
> >                       return false;
> >               }
> >       }
> > +
> >       if (strchr(uri, 0x7f)) {
> >               log_err("invalid character is used\n");
> >               return false;
> >       }
> >
> > -     if (strncmp(uri, "http://", 7)) {
> > -             log_err("only http:// is supported\n");
> > +     if (!strncmp(uri, "http://", strlen("http://"))) {
> > +             prefix_len = strlen("http://");
> > +     } else if (!strncmp(uri, "https://", strlen("https://"))) {
> > +             prefix_len = strlen("https://");
> > +     } else {
> > +             log_err("only http(s):// is supported\n");
> >               return false;
> >       }
> > +
> >       str_copy = strdup(uri);
> >       if (!str_copy)
> >               return false;
>
> Thanks,
> --
> Jerome
