Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73ED66BAC
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 02:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94D289668;
	Wed, 27 Nov 2024 03:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OjcdLGuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970858951E; Wed, 27 Nov 2024 03:20:09 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA3F89668
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 03:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ea37b44e81so4836590a91.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732674005; x=1733278805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=53cambiEKtn+T0Dj38D0cfQ7WshRtWHt/GCeC8YeJqM=;
 b=OjcdLGuk2GMlaavvCCOia0FKMX2wk9BrPvppluJGeXvsF9loMFJwYtNrI/70+JQZ8L
 oMD2n/jUN691AZcBlw79V0vvmR0qCaX9VbhE2tSuv8IZOlEs3u/XuSrQYrWzyKGj+mtT
 RdoT4C7F+ZaKztmpCaCSPKn6NQWCNVgwqe1CqRhEWU2+652u+RtpC2cf8Ab0nNOrGkTb
 FduBlwXS0a0eJHuPeIZ21arjramnza7BWVAVtt2jp5/D7EjMPixKMmc9rmHrsNpDFrKS
 ffL4Wu58laqvp3Bm4IasS5CfmVsgW5sv9Lwc7e3nTDPT9vi/W79d3L27UprkxKUeamY6
 QxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732674005; x=1733278805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53cambiEKtn+T0Dj38D0cfQ7WshRtWHt/GCeC8YeJqM=;
 b=sjDdTOm0ngIHataS1QEPpHgPlDxwE1z2iMXz5Llu5zqDKswW+zvICnWM+IX7AqTEnN
 vTPSTmyCEy5Uck43RWfuG1Z37Oz+sNs5MQyZjjFrWajbMf97h2fzZPb4KPLifsc6FicL
 Z66VgacjiX/3NJX6UR6trPufw7qdEd2aaof2bhKCvTxA5GnDb98EC48qlP4sY5bU3x+m
 2qxkehnY6mE19TrpLeGKsYEB+Rbd8r4/pgQ3ps5yoW2xZqZ5CNuRngGoiee6QtMdvDEl
 kMGw3srpapJOBjE3CkejLYRgoUk8vBhXWEyGclIEOdI4MTvD7R4F0cZyyNcXhK1b88d/
 0rWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO6HcO8WIr34aJR+XhvhXpv7E4C7iQdnLOe8t4e6gYVqHcqyqAStGtWgmQbppun0CBm4GmQ7Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yy855ieiz5At5tw2gUDylpBj6J8vXy6YIMRWHLe0w7vIfUietHD
 +WmTfLifWkKMPwq4XKSlT31qE+Eb5IA3OE1cgiThfYzKCGuH/QBACUqD6bTEOK7v/uNGxyMOvhS
 AxzWD0hskQAdWBn+1mBRDCc19K2yP2QDDefpRUw==
X-Gm-Gg: ASbGncvmleJe5IQc3bx6L2WblhIyVpuqLJo4LLIckCEHNloUpK05qdw7SWUkXLcvKGu
 r4102am1PRIWjtrLvVCSEVX7rQstvRQ==
X-Google-Smtp-Source: AGHT+IHlRdy8cgm8DHMSh/Y22R7OSuTO7BTfINSKQc9IGpAMmo8/ZwRJET+cHiciHB49hgicEei+98tacROwZg404io=
X-Received: by 2002:a17:90b:1c0a:b0:2ea:8295:cd0d with SMTP id
 98e67ed59e1d1-2ee08ecd368mr2151714a91.20.1732674005204; Tue, 26 Nov 2024
 18:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-9-adrianox@gmail.com>
 <1be0e2ae-5d2d-42a2-ac32-355f42b4dcec@gmx.de>
In-Reply-To: <1be0e2ae-5d2d-42a2-ac32-355f42b4dcec@gmx.de>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 26 Nov 2024 23:19:54 -0300
Message-ID: <CAMGU2hVq+SokhugTQOiD9dNFSKbG8kqA42+LoZyJQ_oEsfAo-g@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

El lun, 25 nov 2024 a las 12:40, Heinrich Schuchardt (<xypron.glpk@gmx.de>)
escribi=C3=B3:

> On 25.11.24 01:58, Adriano Cordova wrote:
> > Set the device path of the efi boot device to an HTTP device path
> > (as formed by efi_dp_from_http) when the next boot stage is loaded
> > using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
> >
> > When loaded from HTTP, the device path should account for it so that
> > the next boot stage is aware (e.g. grub only loads its http stack if
> > it itself was loaded from http, and it checks this from its device path=
).
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> > Changes in v5:
> > - Add description of net_dp
> > - Change a void** for an efi_device_path**
> > (no changes since v2)
> >
> >   include/efi_loader.h             |  6 +++++
> >   lib/efi_loader/efi_device_path.c |  2 +-
> >   lib/efi_loader/efi_net.c         | 44 +++++++++++++++++++++++++++++++=
-
> >   net/lwip/wget.c                  |  1 +
> >   net/wget.c                       |  1 +
> >   5 files changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 96b204dfc3..8e7f5becbb 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -126,6 +126,10 @@ static inline void efi_set_bootdev(const char *dev=
,
> const char *devnr,
> >   #endif
> >
> >   #if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> > +/* Call this to update the current device path of the efi net device *=
/
> > +void efi_net_set_dp(const char *dev, const char *server);
> > +/* Call this to get the current device path of the efi net device */
> > +void efi_net_get_dp(struct efi_device_path **dp);
> >   void efi_net_get_addr(struct efi_ipv4_address *ip,
> >                     struct efi_ipv4_address *mask,
> >                     struct efi_ipv4_address *gw);
> > @@ -133,6 +137,8 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
> >                     struct efi_ipv4_address *mask,
> >                     struct efi_ipv4_address *gw);
> >   #else
> > +static inline void efi_net_set_dp(const char *dev, const char *server)
> { }
> > +static inline void efi_net_get_dp(struct efi_device_path **dp) { }
> >   static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
> >                                    struct efi_ipv4_address *mask,
> >                                    struct efi_ipv4_address *gw) { }
> > diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> > index 1e512bf0ea..be0b56d213 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -1181,7 +1181,7 @@ efi_status_t efi_dp_from_name(const char *dev,
> const char *devnr,
> >               dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> >                                    (uintptr_t)image_addr, image_size);
> >       } else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) =
{
> > -             dp =3D efi_dp_from_eth();
> > +             efi_net_get_dp(&dp);
> >       } else if (!strcmp(dev, "Uart")) {
> >               dp =3D efi_dp_from_uart();
> >       } else {
> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> > index 3491d4c481..b448dcee51 100644
> > --- a/lib/efi_loader/efi_net.c
> > +++ b/lib/efi_loader/efi_net.c
> > @@ -16,6 +16,7 @@
> >    */
> >
> >   #include <efi_loader.h>
> > +#include <dm.h>
> >   #include <malloc.h>
> >   #include <vsprintf.h>
> >   #include <net.h>
> > @@ -32,6 +33,13 @@ static int rx_packet_idx;
> >   static int rx_packet_num;
> >   static struct efi_net_obj *netobj;
> >
> > +/*
> > + * The current network device path. This device path is updated when a
> new
> > + * bootfile is downloaded from the network. If then the bootfile is
> loaded
> > + * as an efi image, net_dp is passed as the device path of the loaded
> image.
> > + */
> > +static struct efi_device_path *net_dp;
> > +
> >   /*
> >    * The notification function of this event is called in every timer
> cycle
> >    * to check if a new network packet has been received.
> > @@ -902,8 +910,10 @@ efi_status_t efi_net_register(void)
> >                            &netobj->net);
> >       if (r !=3D EFI_SUCCESS)
> >               goto failure_to_add_protocol;
> > +     if (!net_dp)
> > +             efi_net_set_dp("Net", NULL);
> >       r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > -                          efi_dp_from_eth());
> > +                          net_dp);
> >       if (r !=3D EFI_SUCCESS)
> >               goto failure_to_add_protocol;
> >       r =3D efi_add_protocol(&netobj->header,
> &efi_pxe_base_code_protocol_guid,
> > @@ -999,6 +1009,38 @@ out_of_resources:
> >       return EFI_OUT_OF_RESOURCES;
> >   }
> >
> > +/**
> > + * efi_net_set_dp() - set device path of efi net device
> > + *
> > + * This gets called to update the device path when a new boot
> > + * file is dowloaded
>
> %s/dowloaded/downloaded/
>
> > + *
> > + * @dev:     dev to set the device path from
> > + * @server:  remote server address
> > + */
> > +void efi_net_set_dp(const char *dev, const char *server)
> > +{
>
> If this function is called repeatedly, we are leaking memory.
> I could not find where you free net_dp after a transaction.
> Maybe here is the right place if net_dp is not NULL.
>
> Right, I will free it here.


> > +     if (!strcmp(dev, "Net"))
> > +             net_dp =3D efi_dp_from_eth();
>
> efi_dp_from_eth() may fail and return NULL.
>
> > +     else if (!strcmp(dev, "Http"))
> > +             net_dp =3D efi_dp_from_http(server);
>
> efi_dp_from_http() may fail and return NULL.
>
> How will errors be handled?
>
> efi_net_set_dp works pretty much as efi_set_bootdev, which also does not
have
error handling. These functions are called from outside EFI code and when
EFI is not
available they are declared as static inline empty functions.
They are actually called together in all currently used instances, so I
think
the best is to put efi_net_set_dp inside efi_set_bootdev and make a
patch to handle errors of efi_set_bootdev.

> > +}
> > +
> > +/**
> > + * efi_net_get_dp() - get device path of efi net device
> > + *
> > + * Produce a copy of the current device path
> > + *
> > + * @dp:              copy of the current device path
>
> copy of the current device path or NULL on error
>
> > + */
> > +void efi_net_get_dp(struct efi_device_path **dp)
>
> struct efi_device_path *efi_net_get_dp(struct efi_device_path *dp)
> would reduce dereferencing.
>
> > +{
> > +     if (!net_dp)
> > +             efi_net_set_dp("Net", NULL);
>
> efi_net_set_dp may fail. This needs to be handled. E.g. return NULL.
>
> > +     if (dp && net_dp)
> > +             *dp =3D efi_dp_dup(net_dp);
> > +}
>
> efi_dp_dup may return NULL if out of memory.
>
> > +
> >   /**
> >    * efi_net_get_addr() - get IP address information
> >    *
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index 3347a61e74..7bc7c6a2fe 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -217,6 +217,7 @@ static void httpc_result_cb(void *arg,
> httpc_result_t httpc_result,
> >       print_size(rx_content_len / elapsed * 1000, "/s)\n");
> >       printf("Bytes transferred =3D %lu (%lx hex)\n", ctx->size,
> ctx->size);
> >       if (wget_info->set_bootdev) {
> > +             efi_net_set_dp("Http", ctx->server_name);
>
> Error handling is missing.
>
> >               efi_set_bootdev("Net", "", ctx->path,
> map_sysmem(ctx->saved_daddr, 0),
> >                               rx_content_len);
> >       }
> > diff --git a/net/wget.c b/net/wget.c
> > index 4bb1590410..21d3b8050a 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -442,6 +442,7 @@ static void wget_handler(uchar *pkt, u16 dport,
> >               net_set_state(wget_loop_state);
> >               wget_info->file_size =3D net_boot_file_size;
> >               if (wget_info->method =3D=3D WGET_HTTP_METHOD_GET &&
> wget_info->set_bootdev) {
> > +                     efi_net_set_dp("Http", NULL);
>
> Error handling is missing.
>
> Best regards
>
> Heinrich
>
> >                       efi_set_bootdev("Net", "", image_url,
> >                                       map_sysmem(image_load_addr, 0),
> >                                       net_boot_file_size);
>
>
