Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C1DCE8E83
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B713B88E81;
	Thu, 24 Oct 2024 16:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gF+EtbXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEFEA88DDC; Thu, 24 Oct 2024 16:39:23 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FDF88995
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so577503a12.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729780758; x=1730385558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kxEOfb1LPUhPY/1NF5v5KcC8Y4/V6NldiL7OMHFAjc0=;
 b=gF+EtbXppgdy0fR8rLhlEaGcUlO+P8fhrUAlvKUdSfpxByQvPn45jcr+rVpHbq4rrI
 M4OEsEqI4cq93whfSWn6clFcmom6umWb6weQtQ7ixybN4zrY+hJOoJqfeCH8IMVUQhmM
 9/3epEYsdixE/pa4iFTdOpUtIyjfQ94kPkcG1mCuAe3+iNxIdk5GcN+t2vXzsGOi0wJM
 DQ3jljmMPUzUs48Ubb+DhbcAyyYbotV/6VSCYW1FrEyAZ16xCeNc8B3RQm1ZOWtxvB2v
 cC540NOub3gI+lu8f8fdFCaXjIp30tGjOu2FkKw3u5PxrD1VJ1stOkTz3yzy+nbQlpCs
 aMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729780758; x=1730385558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxEOfb1LPUhPY/1NF5v5KcC8Y4/V6NldiL7OMHFAjc0=;
 b=DTowNhFwYuUTafGj78BVbP3oY9xa78GneEansWJotcCpZiHr30tPHeIVZHVTH5xbU8
 6nZome/GCT5kekgGIfMTdPHPjS7jeUjHn/IQWgG25LE19yjuWNHM6hvEI5HseVRmtLYU
 BS+fY6xismCrhWjVSJ5qeWC37zXxSuKbgnts+dAESpBoSqBMe+x7JBecCalMHvozQjoJ
 c2iUjRjzoppP6sUpkN3fZvguHuuoUI7f39vc0cDWXpWYm1sTJF62waPeU+JkOoiOHPXe
 SZRLeXoML7c+KxGg8GODRFchWB2wcSV9VM5vPaC/28aLrcqzUOI5Cbipe4VwZlns4uYR
 AOZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpPuq90zS/JsgjqWL3aj4YimMUoJt3DB+eNNVOpqMkakjdUn41TJpwofICxvQgK2BwNGd9q3w=@lists.denx.de
X-Gm-Message-State: AOJu0YzpKR747PPQ2pdOtB3SMO8CVRXuLXaHQv9UIHGy3X9yX7uHkXlp
 eWTgdK4+fkRhUor8tlpHiXi6gVMIakrW06X3NEZzByFVOBoyHiWqw5SPfVToeRxO1whS8YJtBIq
 UYxpmYmynterfHh4j68Wp/xSDPyiynIVlGOqygg==
X-Google-Smtp-Source: AGHT+IG/zaKyJmkKoDoFS3EgrqWJz3+woKsY6fB7NEYf72YaHWTlIfNAnh+F2VTc6RwusNBluTlbMX9RpVovREKTZ7Y=
X-Received: by 2002:a05:6a21:398a:b0:1d9:3acd:68ea with SMTP id
 adf61e73a8af0-1d989b20a30mr2923544637.25.1729780757621; Thu, 24 Oct 2024
 07:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-5-ilias.apalodimas@linaro.org>
 <CAC_iWjLuqUTKW-okV85RULz-P61kDbniEVERHDeBWpKu5gXcUw@mail.gmail.com>
In-Reply-To: <CAC_iWjLuqUTKW-okV85RULz-P61kDbniEVERHDeBWpKu5gXcUw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Oct 2024 17:38:41 +0300
Message-ID: <CAC_iWj+fB7Kgnh+p_cD+WBhePM1pUahgZZcnTNnz3zKKh-p52g@mail.gmail.com>
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

On Thu, 24 Oct 2024 at 17:04, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Replying to myself here but
>
> On Thu, 24 Oct 2024 at 14:25, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
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
> >           wget is a simple command to download kernel, or other files,
> >           from a http server over TCP.
> >
> > +config WGET_HTTPS
> > +       bool "wget https"
> > +       depends on CMD_WGET
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
> > +       int ret;
> > +
> > +       *olen = 0;
> > +
> > +       ret = uclass_get_device(UCLASS_RNG, 0, &dev);
> > +       if (ret) {
> > +               log_err("Failed to get an rng: %d\n", ret);
> > +               return ret;
> > +       }
> > +       ret = dm_rng_read(dev, &rng, sizeof(rng));
> > +       if (ret)
> > +               return ret;
> > +
> > +       memcpy(output, &rng, len);
> > +       *olen = sizeof(rng);
>
> I just realized I forgot to address this. I'll fix it on v3, but the
> rest of the code is ok to review

So, the correct thing to do here is
memcpy(output, &rng, len);
*olen = LWIP_MIN(len, sizeof(rng)); <-- mbedTLS sets len to 128, so
although sizeof(rng); is ok for now we can't rely on that


>
> Thanks
> /Ilias
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
