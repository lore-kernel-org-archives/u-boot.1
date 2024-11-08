Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B9DD5E15A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F7F88EBA;
	Fri,  8 Nov 2024 12:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wYvUW9NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E5588B0C; Fri,  8 Nov 2024 12:18:44 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7907A88FD0
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so1671975a91.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731064720; x=1731669520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5lzPAJ5s9l6AGLZr2s9okCUSCr32Zl7pmcAie53xsnw=;
 b=wYvUW9NPlnDltin4phxLS7lyotpjG8w3aIXQfLklHvYu2/hsxdLfI6IJ54OFcBJUi/
 e4ihxxzZnM3oCB0jG9GYBPrVnVzhsjiTj/eTcUw8uvJEEM96V2+c7LElN7Qz0TGGNPxh
 mYOCFwKqRqZQGJRON4DsgT6KL4wgUhQb/M5xqF5fDvoYdA4Yba5Cod5dKiuJP90bnKCs
 zAhh3SHX1X9k8/z3iXmGr/BBYBTSlO7AyyMahVVDx5VAthJbjDSV84+RcpTWgYwJSi6h
 NSgjlDkfR42Kc5o13rGa+qUmELy0mtLDc5Xo0XqYBOseFJzaljG9Tsbn8fHyxpXxFuOO
 0RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731064720; x=1731669520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5lzPAJ5s9l6AGLZr2s9okCUSCr32Zl7pmcAie53xsnw=;
 b=qhhF1pt3Fmsn4nnzBuk7anYm6mQwQBOD6N28BTPZfRhyyqVe4dRb+18nksNK1dF8nm
 l8qvuGQUqgUvcZeskurlhCH9KeZkWHDv76DK8DZv+axLVb+U6c2eePiUTNxiWYNE06Z/
 uIKGtUeQDIVe5IpQBJJWXKKSC3ttT9qGAghw1zgK2NHTFba982I0R4/6Klc90qFzyzdA
 gz/V6+nIxfupPLOkT4vX0FqG5VGrYI6W32utV40p/nR+CydRqWQYCvsZz+tlaPB0tjQO
 cndpGrj46xiVY08Zh1uNBZlukhAcFwRZo5wRAiDVEiRTJCIFCc2+gpH4QZyQv/n4poiw
 da+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURZmC6kBkayoGzmjmxFp2dKm/jiUDjmQ2wplHgSUG6fSJZIcudpbjcvOfYFh4Ztsr+/qvNFGs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+yeXh1a5gfAOfLzvKLP7YRon7F304Mu3MtJPZVTVSoV1SG+3B
 MGRc7sX88kqUgOV7WY9p55ZoflCsqplkkCpC99XyCy7iydHiSSYTNx6PbRje9OAx92cXSOCJLw2
 LEv4WlVjj9s96o8VHF0icK87flubBX3Pa7OzQfA==
X-Google-Smtp-Source: AGHT+IGtNuj39sYVa+QyBLB89Y67C/o2re6YbmijC1naJLEOuL43s/DGP9xhO0LWLrEk+FhMwIQgooLV8dvSWxgtJOw=
X-Received: by 2002:a17:90b:4ac9:b0:2e9:4967:244 with SMTP id
 98e67ed59e1d1-2e9b177352fmr3267000a91.24.1731064718446; Fri, 08 Nov 2024
 03:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-4-ilias.apalodimas@linaro.org>
 <66c8e1a4-00e0-499c-9a2c-5fb83eb3e4e9@linaro.org>
In-Reply-To: <66c8e1a4-00e0-499c-9a2c-5fb83eb3e4e9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Nov 2024 11:18:02 +0000
Message-ID: <CAC_iWjKDNeQtooM2DC0Ejj63ZQmDCk1gq-PUfnqbNTuspS+YbQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] net: lwip: Add Support Server Name Indication
 support
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Javier Tia <javier.tia@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

Hi Jerome,

On Wed, 6 Nov 2024 at 13:39, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 10/24/24 12:24, Ilias Apalodimas wrote:
> > From: Javier Tia <javier.tia@linaro.org>
> >
> > SNI, or Server Name Indication, is an addition to the TLS encryption
> > protocol that enables a client device to specify the domain name it is
> > trying to reach in the first step of the TLS handshake, preventing
> > common name mismatch errors and not reaching to HTTPS server that
> > enforce this condition. Since most of the websites require it nowadays
> > add support for it.
> >
> > It's worth noting that this is already sent to lwIP [0]
> >
> > [0] https://github.com/lwip-tcpip/lwip/pull/47
> >
> > Signed-off-by: Javier Tia <javier.tia@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 11 +++++++----
> >  lib/lwip/lwip/src/include/lwip/altcp_tls.h           |  2 +-
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > index ef19821b89e0..24b432966312 100644
> > --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> > @@ -106,6 +106,7 @@ struct altcp_tls_config {
> >    u8_t pkey_count;
> >    u8_t pkey_max;
> >    mbedtls_x509_crt *ca;
> > +  char host[256];
> >  #if defined(MBEDTLS_SSL_CACHE_C) && ALTCP_MBEDTLS_USE_SESSION_CACHE
> >    /** Inter-connection cache for fast connection startup */
> >    struct mbedtls_ssl_cache_context cache;
> > @@ -642,6 +643,7 @@ altcp_mbedtls_setup(void *conf, struct altcp_pcb *conn, struct altcp_pcb *inner_
> >    /* tell mbedtls about our I/O functions */
> >    mbedtls_ssl_set_bio(&state->ssl_context, conn, altcp_mbedtls_bio_send, altcp_mbedtls_bio_recv, NULL);
> >
> > +  mbedtls_ssl_set_hostname(&state->ssl_context, config->host);
> >    altcp_mbedtls_setup_callbacks(conn, inner_conn);
> >    conn->inner_conn = inner_conn;
> >    conn->fns = &altcp_mbedtls_functions;
> > @@ -951,7 +953,7 @@ altcp_tls_create_config_server_privkey_cert(const u8_t *privkey, size_t privkey_
> >  }
> >
> >  static struct altcp_tls_config *
> > -altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2wayauth)
> > +altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2wayauth, char *host)
> >  {
> >    int ret;
> >    struct altcp_tls_config *conf = altcp_tls_create_config(0, (is_2wayauth) ? 1 : 0, (is_2wayauth) ? 1 : 0, ca != NULL);
> > @@ -973,13 +975,14 @@ altcp_tls_create_config_client_common(const u8_t *ca, size_t ca_len, int is_2way
> >
> >      mbedtls_ssl_conf_ca_chain(&conf->conf, conf->ca, NULL);
> >    }
> > +  memcpy(conf->host, host, sizeof(conf->host));
>
> What if host is smaller than sizeof(conf->host)? Should be strncpy() IMHO.

Looking at it, if host is smaller than sizeof(conf->host) we will copy
random bytes from that and we dont know what...
So I think it's better to memcpy the min value of strlen(host) and
sizeof(conf->host)?

Thanks
/Ilias
>
> >    return conf;
> >  }
> >
> >  struct altcp_tls_config *
> > -altcp_tls_create_config_client(const u8_t *ca, size_t ca_len)
> > +altcp_tls_create_config_client(const u8_t *ca, size_t ca_len, char *host)
> >  {
> > -  return altcp_tls_create_config_client_common(ca, ca_len, 0);
> > +  return altcp_tls_create_config_client_common(ca, ca_len, 0, host);
> >  }
> >
> >  struct altcp_tls_config *
> > @@ -995,7 +998,7 @@ altcp_tls_create_config_client_2wayauth(const u8_t *ca, size_t ca_len, const u8_
> >      return NULL;
> >    }
> >
> > -  conf = altcp_tls_create_config_client_common(ca, ca_len, 1);
> > +  conf = altcp_tls_create_config_client_common(ca, ca_len, 1, NULL);
> >    if (conf == NULL) {
> >      return NULL;
> >    }
> > diff --git a/lib/lwip/lwip/src/include/lwip/altcp_tls.h b/lib/lwip/lwip/src/include/lwip/altcp_tls.h
> > index fcb784d89d70..fb0618234481 100644
> > --- a/lib/lwip/lwip/src/include/lwip/altcp_tls.h
> > +++ b/lib/lwip/lwip/src/include/lwip/altcp_tls.h
> > @@ -92,7 +92,7 @@ struct altcp_tls_config *altcp_tls_create_config_server_privkey_cert(const u8_t
> >  /** @ingroup altcp_tls
> >   * Create an ALTCP_TLS client configuration handle
> >   */
> > -struct altcp_tls_config *altcp_tls_create_config_client(const u8_t *cert, size_t cert_len);
> > +struct altcp_tls_config *altcp_tls_create_config_client(const u8_t *cert, size_t cert_len, char *host);
> >
> >  /** @ingroup altcp_tls
> >   * Create an ALTCP_TLS client configuration handle with two-way server/client authentication
>
> With the above comment addressed:
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
>
> Thanks,
> --
> Jerome
