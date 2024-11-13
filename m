Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D978D41C3C
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 12:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51C188EE0;
	Wed, 13 Nov 2024 13:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="guP89qRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13AA89579; Wed, 13 Nov 2024 13:51:30 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315BA88D29
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 13:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21116b187c4so54788215ad.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 04:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731502287; x=1732107087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dFgO+gxlS5sfTq08nCBBFiqJ9gtusXT4zdDyN21FUuk=;
 b=guP89qRiXkFXoFW3tjai8QNGRI8Ctj8AdmZeyo2jJSQWQEtdhhIODzKhE42PcAPbdf
 NAeBzxDHYE1p/ESODCQoFZlz9zd/wRjJmyvoK6DtlAygl9DyFRIvb+V+55E5Zyjfqk5/
 tt3L8iRISFteJAAbT+e97I3+YJ2Csbc0piYpli3pQRAmH+k4zv16qLcO3RCCY/dq1UcP
 6i/fXP+Ek3G3E/ElxK1UKJmK5yfxWo6dJ/zB791I+K4WJZpezqtE5OtsNazGjk7nVUwy
 yDpAFlZF6eM716/xcMcOwYN5ELAOZ5Z1SGdO3mRwW5QUHSdyYv+zbBAnkOrG0oKvLLmR
 +ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731502287; x=1732107087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFgO+gxlS5sfTq08nCBBFiqJ9gtusXT4zdDyN21FUuk=;
 b=FQg6kW+tAbvJO1nOVpc61vsgns3BIKiQtejStDovYsw5Ob/AOeA+vx3MoMJotWjOmC
 LxMZ5TV1gZVrGGAkC4LNaP8o1hvYBuo2RDFNzF9wupnxiEY/V1S9Fhh+emXtFj1YyLo+
 V0qCQfrjtI5eXZnU5XZ+nTnPZLWMKQHMc7AHtOap6Po4MJFQpedph6comEctcVB4gu+T
 Ti4uzBgdjmmcR0eKP1UTpeQn/JEDDSsF3H0OObOa44wkM+QE9ritNn+cnPSmQxBsvl8T
 e0SbSk0qc/b6sinkXVYoLI01Ackt3Z15+uKioPc1t/zTev0DEH4+geu3TGyUY2/fHxxW
 5ykA==
X-Gm-Message-State: AOJu0YyXzbxtsmyyo7XxCKKB9M49poR96CjhCBVNfteje3WgLHAC26zD
 7DvXhRdOzTm9i/6Cj8EKsADzD0X724wOI+5lFO62Dlux0XeG5voOeSWr/eUvx8VQ7l/BkiDwLit
 2awCgioB/Fj5luTvPTwBRT5aPIIs=
X-Google-Smtp-Source: AGHT+IEURt/2kREp4ZjoSZGHus/R4br2/eny249PgB7sBf0O4DQKoCpiqnWx4fIhX0F1cUKM0hE7iax+Iz63w/Pi+Pk=
X-Received: by 2002:a05:6a21:6da7:b0:1d9:21a0:14e0 with SMTP id
 adf61e73a8af0-1dc229266a9mr27905001637.12.1731502286544; Wed, 13 Nov 2024
 04:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-9-adrianox@gmail.com>
 <CAC_iWjJMtqGfON-feNhbWSPHZz9BEzZqbriV6byDmyEbkkazdw@mail.gmail.com>
In-Reply-To: <CAC_iWjJMtqGfON-feNhbWSPHZz9BEzZqbriV6byDmyEbkkazdw@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 13 Nov 2024 09:51:14 -0300
Message-ID: <CAMGU2hWyo8O553HW=fJftm0awFHcOrxeVDVsuXcraWKKMBuBGg@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] efi_loader: device_path: add support for HTTP
 device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El mi=C3=A9, 13 nov 2024 a las 5:16, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Add efi_dp_from_http to form a device path from HTTP. The
> > device path is the concatenation of the device path returned
> > by efi_dp_from_ipv4 together with an URI node and an END node.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > Changes in v3:
> > - Moved argument checks in efi_dp_from_http to the beginning of the
> function
> >
> >  include/efi_loader.h             |  1 +
> >  lib/efi_loader/efi_device_path.c | 55 ++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 612bc42816..96b204dfc3 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct
> blk_desc *desc, int part);
> >  struct efi_device_path *efi_dp_from_file(const struct efi_device_path
> *dp,
> >                                          const char *path);
> >  struct efi_device_path *efi_dp_from_eth(void);
> > +struct efi_device_path *efi_dp_from_http(const char *server);
> >  struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
> >                                         uint64_t start_address,
> >                                         size_t size);
> > diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> > index 82a45da1fa..158f08b9e5 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -1012,6 +1012,61 @@ struct efi_device_path *efi_dp_from_ipv4(struct
> efi_ipv4_address *ip,
> >         return dp2;
> >  }
> >
> > +struct efi_device_path *efi_dp_from_http(const char *server)
> > +{
> > +       struct efi_device_path *dp1, *dp2;
> > +       struct efi_device_path_uri *uridp;
> > +       efi_uintn_t uridp_len;
> > +       char *pos;
> > +       char tmp[128];
> > +       struct efi_ipv4_address ip;
> > +       struct efi_ipv4_address mask;
> > +
> > +       if ((server && strlen("http://") + strlen(server) + 1  > 128)
>
> sizeof (tmp) instead of 128
>
> > +           (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> > +               return NULL;
> > +
> > +       efi_net_get_addr(&ip, &mask, NULL);
> > +
> > +       dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL);
> > +
> > +       strcpy(tmp, "http://");
>
> I've sent this a while back which is close to merging [0]. I am ok
> with merging http support first, but if it's not too much of a pain
> can you rebase on top of that and add https:// as well?
>

For that I'd have to change the wget patches too. I will try to add it in
the next version,
otherwise I can send a separated patch.


> > +
> > +#if IS_ENABLED(CONFIG_NET_LWIP)
> > +       if (server) {
> > +               memcpy(tmp + strlen("http://"), server, strlen(server)
> + 1);
> > +       }
> > +#else
> > +       if (server) {
> > +               memcpy(tmp + strlen("http://"), server, strlen(server)
> + 1);
> > +       } else {
> > +               ip_to_string(net_server_ip, tmp + strlen("http://"));
> > +       }
> > +#endif
> > +
>
> I think it's easier to read if you rewrite this as
> if (server)
>     memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
> else
>      if (!IS_ENABLED(CONFIG_NET_LWIP)
>          ip_to_string(net_server_ip, tmp + strlen("http://"));
>
> I agree, but then there is an empty else { } , not sure if that would
generate a warning.

> +       uridp_len =3D sizeof(struct efi_device_path) + strlen(tmp) + 1;
> > +       uridp =3D efi_alloc(uridp_len + sizeof(END));
> > +       if (!uridp) {
> > +               log_err("Out of memory\n");
> > +               return NULL;
> > +       }
> > +       uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +       uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +       uridp->dp.length =3D uridp_len;
> > +       debug("device path: setting uri device path to %s\n", tmp);
> > +       memcpy(uridp->uri, tmp, strlen(tmp) + 1);
> > +
> > +       pos =3D (char *)uridp + uridp_len;
> > +       memcpy(pos, &END, sizeof(END));
> > +
> > +       dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)urid=
p,
> 0);
> > +
> > +       efi_free_pool(uridp);
> > +       efi_free_pool(dp1);
> > +
> > +       return dp2;
> > +}
> > +
> >  /* Construct a device-path for memory-mapped image */
> >  struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> >                                         uint64_t start_address,
> > --
> > 2.43.0
> >
>
> [0]
> https://lore.kernel.org/u-boot/20241110083017.367565-1-ilias.apalodimas@l=
inaro.org/
>
> Thanks
> /Ilias
>
