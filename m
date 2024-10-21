Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76BDD0E6F1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AC688BBE;
	Mon, 21 Oct 2024 13:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MfNDJO82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6548C88EA7; Mon, 21 Oct 2024 13:00:51 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50C688365
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20e576dbc42so28639795ad.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729508447; x=1730113247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=024CXQIvlMCZR/r3tdwanDNRhfSHwJAAuObNa0aEGDo=;
 b=MfNDJO82YwR9/XzvvRBInFBONU+Bwjh6Ddq4J/fs16bmZHnY9xGDeYpvZI4fliOePD
 vgeYngdhXNuqKsUn5AvbeotzvBJvY/lPHTOfgSE43RFMxts9SnPGWq7cM308tTZ4RusN
 HXKRE5V5fgTdYnjIHTXQ/HmtxgN0gamxmu8Ow5FANU7ZaBZAIcOipA7qa2r0fcsJoRKC
 iCfKcJ4w43hfAmSQn2dv4+TEnR1Xj9u6wDKYhbMULmKm14WnUrP/o53bV0LXlURE0Kjc
 NzaXaHs+5WEU3gtsaFftEJArVdiYz1xfZ1J0OcNKOxOG7zgiH6FPoZr4jzzIsnFZNIZe
 mmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729508447; x=1730113247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=024CXQIvlMCZR/r3tdwanDNRhfSHwJAAuObNa0aEGDo=;
 b=kkEe5yz9b9J9cxYWEN6vbjjlBb7ATw55gdGKOaMojJYFLhSyinFw1DRJYFJVQxLO9C
 J6VTPMbjY1tjbz5LfXl9XwppPtdC7yVmc7aWhyPoU8E1IPzMXSVqQe+I3ror4yS7rWFJ
 tU7hpWIL+ZCwasiXBXYMn9AObDBXyS7x2QWYysFkCGVFepOkeZ+GkgLPj5rT01GZkhKj
 BJJiWklxkHjCc1gXsx4tgALIpIlMvxTrD/rGY+BTauQ10EMcfAvFF+s7GbPgai3yMGiu
 U8Cr5ozRQEbT6ztZinamzXzRORLVxILxtaQhCXGiaAIzsCGBVe/Sd0qt2Aqc3vo55ScO
 76cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOv0LccnxJi4lIepJF90RJ3p5Hdf3bo7s8gI475Ib1gzZM7R95DrmoZ0kexxVIdWc9w7ZxVWg=@lists.denx.de
X-Gm-Message-State: AOJu0YwBBTJ1viEdMTdkFvps1OTurng9qKp8QQrZumK4QFkz9c3AksvX
 avaPlo3rxIDMEbPWTZBF7uLspOWOlcVPNvrSXdKGtatI3GhHO9c4ByUQW4rQTZLA2q8BHQKUcNt
 BTcGq4QRStnl+G80uBsPyqIiFgnTgwC3h5MHxcw==
X-Google-Smtp-Source: AGHT+IG/HmkPNkZUn16KsSX0E05JOLd8/ymtGwS6Bq1mWuZU+6Jcmg0F2pkBjRvzAAMgARWxvTnV8vd/Cb9OVxe5LWI=
X-Received: by 2002:a17:90b:2785:b0:2e0:a77e:82ff with SMTP id
 98e67ed59e1d1-2e561a168d1mr13188686a91.33.1729508447407; Mon, 21 Oct 2024
 04:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-5-ilias.apalodimas@linaro.org>
 <CAFLszTj-f9BwFd3oO8uZGS=D_8wDtUcKQD9-9mU1rVUZin9f-Q@mail.gmail.com>
In-Reply-To: <CAFLszTj-f9BwFd3oO8uZGS=D_8wDtUcKQD9-9mU1rVUZin9f-Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Oct 2024 14:00:11 +0300
Message-ID: <CAC_iWjJrUtTnymNK-GpNOp+Qjd2H2z+pPP8caK7KW4DzCVpP5Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] net: lwip: Enable https:// support for wget
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Sat, 19 Oct 2024 at 14:50, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 18 Oct 2024 at 08:23, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > With the recent changes of lwip & mbedTLS we can now download from
> > https:// urls instead of just http://.
> > Adjust our wget lwip version parsing to support both URLs.
> > While at it adjust the default TCP window for QEMU since https seems to
> > requite at least 16384
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  cmd/Kconfig      | 19 ++++++++++++
> >  net/lwip/Kconfig |  2 +-
> >  net/lwip/wget.c  | 78 +++++++++++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 91 insertions(+), 8 deletions(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 8c677b1e4864..e58566a9ba34 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -2118,6 +2118,25 @@ config CMD_WGET
> >           wget is a simple command to download kernel, or other files,
> >           from a http server over TCP.
> >
> > +config WGET_HTTPS
> > +       bool "wget https"
> > +       depends on CMD_WGET
>
> Is it possible to do wget programmatically, i.e. without CMDLINE?

Yes. But that would require more untangling of wget. I'll look into
that once we are done with features.

>
> > +       depends on PROT_TCP_LWIP
> > +       depends on MBEDTLS_LIB
> > +        select SHA256
> > +        select RSA
> > +        select ASYMMETRIC_KEY_TYPE
> > +        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > +        select X509_CERTIFICATE_PARSER
> > +        select PKCS7_MESSAGE_PARSER
> > +       select MBEDTLS_LIB_CRYPTO
> > +       select MBEDTLS_LIB_TLS
> > +       select RSA_VERIFY_WITH_PKEY
> > +       select X509_CERTIFICATE_PARSER
> > +       select PKCS7_MESSAGE_PARSER
> > +       help
> > +         Enable TLS over http for wget.
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
> >         int "Value of TCP_WND"
> > -       default 8000 if ARCH_QEMU
> > +       default 32768 if ARCH_QEMU
> >         default 3000000
> >         help
> >           Default value for TCP_WND in the lwIP configuration
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index b495ebd1aa96..b4f039d38962 100644
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
> >         enum done_state done;
> >  };
> >
> > +bool wget_validate_uri(char *uri);
> > +
> > +int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
> > +                         size_t *olen)
> > +{
> > +       struct udevice *dev;
> > +       u64 rng = 0;
> > +       int err;
>
> ret
>
> > +
> > +       *olen = 0;
> > +
> > +       err = uclass_get_device(UCLASS_RNG, 0, &dev);
>
> Using uclass_get_device_by_seq() would allow aliases to select which
> device is used.

Ok, but I don't think we need it here. We just need a random number
from any device that can send us one no?

>
> > +       if (err)
> > +               return err;
> > +       err = dm_rng_read(dev, &rng, sizeof(rng));
> > +       if (err) {
> > +               log_err("Failed to get an rng: %d\n", err);
>
> If you are showing an error, I think it is more likely to happen when
> trying to find the device, so perhaps do this on the
> uclass_get_device() call?

Sure

>
> > +               return err;
> > +       }
> > +
> > +       memcpy(output, &rng, len);
> > +       *olen = sizeof(rng);
>
> But then why not dm_rng_read() into output and avoid the u64?
> Actually, dm_rng_ops-read() should return the number of bytes,
> perhaps?

The caller defines the length. Copying blindly a u64 might overflow.
But the current code should be
*olen = len

>
> > +
> > +       return 0;
> > +}
> > +
> >  static int parse_url(char *url, char *host, u16 *port, char **path)
> >  {
> >         char *p, *pp;
> >         long lport;
> > +       size_t prefix_len = 0;
> > +
> > +       if (!wget_validate_uri(url)) {
> > +               log_err("Invalid URL. Use http(s)://\n");
> > +               return -EINVAL;
> > +       }
> >
> > +       *port = HTTP_PORT_DEFAULT;
> > +       prefix_len = strlen("http://");
> >         p = strstr(url, "http://");
> >         if (!p) {
> > -               log_err("only http:// is supported\n");
> > -               return -EINVAL;
> > +               p = strstr(url, "https://");
> > +               prefix_len = strlen("https://");
> > +               *port = HTTPS_PORT_DEFAULT;
> >         }
> >
> > -       p += strlen("http://");
> > +       p += prefix_len;
> >
> >         /* Parse hostname */
> >         pp = strchr(p, ':');
> > @@ -67,9 +106,8 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
> >                 if (lport > 65535)
> >                         return -EINVAL;
> >                 *port = (u16)lport;
> > -       } else {
> > -               *port = HTTP_PORT_DEFAULT;
> >         }
> > +
> >         if (*pp != '/')
> >                 return -EINVAL;
> >         *path = pp;
> > @@ -210,6 +248,9 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
> >  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >  {
> >         char server_name[SERVER_NAME_SIZE];
> > +#if defined CONFIG_WGET_HTTPS
> > +       altcp_allocator_t tls_allocator;
> > +#endif
> >         httpc_connection_t conn;
> >         httpc_state_t *state;
> >         struct netif *netif;
> > @@ -232,6 +273,22 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >                 return -1;
> >
> >         memset(&conn, 0, sizeof(conn));
> > +#if defined CONFIG_WGET_HTTPS
>
> if (IS_ENABLED(CONFIG_WGET_HTTPS))
>

Unfortunately, I don't think we can use that here. If
CONFIG_WGET_HTTPS is not enabled LWIP_ALTCP will not be defined, and
the altcp_allocator_t field will be missing from the struct leading to
a compilation error

Thanks
/Ilias

> > +       if (port == HTTPS_PORT_DEFAULT) {
> > +               tls_allocator.alloc = &altcp_tls_alloc;
> > +               tls_allocator.arg =
> > +                       altcp_tls_create_config_client(NULL, 0, server_name);
> > +
> > +               if (!tls_allocator.arg) {
> > +                       log_err("error: Cannot create a TLS connection\n");
> > +                       net_lwip_remove_netif(netif);
> > +                       return -1;
> > +               }
> > +
> > +               conn.altcp_allocator = &tls_allocator;
> > +       }
> > +#endif
> > +
> >         conn.result_fn = httpc_result_cb;
> >         ctx.path = path;
> >         if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
> > @@ -316,6 +373,7 @@ bool wget_validate_uri(char *uri)
> >         char c;
> >         bool ret = true;
> >         char *str_copy, *s, *authority;
> > +       size_t prefix_len = 0;
> >
> >         for (c = 0x1; c < 0x21; c++) {
> >                 if (strchr(uri, c)) {
> > @@ -323,15 +381,21 @@ bool wget_validate_uri(char *uri)
> >                         return false;
> >                 }
> >         }
> > +
> >         if (strchr(uri, 0x7f)) {
> >                 log_err("invalid character is used\n");
> >                 return false;
> >         }
> >
> > -       if (strncmp(uri, "http://", 7)) {
> > -               log_err("only http:// is supported\n");
> > +       if (!strncmp(uri, "http://", strlen("http://"))) {
> > +               prefix_len = strlen("http://");
> > +       } else if (!strncmp(uri, "https://", strlen("https://"))) {
> > +               prefix_len = strlen("https://");
> > +       } else {
> > +               log_err("only http(s):// is supported\n");
> >                 return false;
> >         }
> > +
> >         str_copy = strdup(uri);
> >         if (!str_copy)
> >                 return false;
> > --
> > 2.45.2
> >
>
> Regards,
> Simon
