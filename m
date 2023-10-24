Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3F4C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 13:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF06587009;
	Tue, 24 Oct 2023 15:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mgpERxIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900D987225; Tue, 24 Oct 2023 15:52:29 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52E686FA7
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 15:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso6998154a12.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698155544; x=1698760344; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJcoe/d/rydNak75WR6Lg8pkhiTEGaeOnDDEcueMXGE=;
 b=mgpERxITiWsM7eMp+/P/4CL1Z0ywOn1qPXlH0QNs5vP/xb99/ByQcoE7sXVtGKUrlp
 qEDvTpkw5LLHU1bx2gUcUG/cv9/bh1uCBIxzi3nSYHNM9kwu2coaBgl90BEAmJwRtWip
 Ge8/esn7GeGjqXHA+hwwAx/ErVk/wU1vK3h2YdTKEcPlC662xHiEtTAJ+bo3COWYzeOS
 2d2kF7yWHZiIIfxKES8nw4JcJwOAfJSt4PiSJBCQJGeDdEDCf4FUwQ/RQIEE3aWKenDD
 Za2EHhHiOjuIdRcA2bLpqJqUsirdD5fyl5BYOJgy9XroFnTK3fe6446tLsiLX8LaC6mk
 EAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698155544; x=1698760344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJcoe/d/rydNak75WR6Lg8pkhiTEGaeOnDDEcueMXGE=;
 b=qVFMxWW3y6Ehp0Fujb9aXtbhP941yykVId1pE5j8KwpVvM3zGc2Qi6ZziEu86l2RoW
 bI3ZB/ewZFXjU6/oBCD7dquvyKAoHjD4kjC1W6s0KL6ZsnmUDfDQi086yVOizrMazb7T
 YMZpmF2OYIgSeiPFuH3F1ClziTCUhSCDkFA6vrQyCyAcIULeAHbXWygIgqfJH+HibTRM
 CkM2siNsQoDJMLr74aBVX5t86VDTT2QIbvJR0NXH9vW46ggszZCMnR87w+xHkFxFxmxn
 21Beg/C0utFKTUq9LujR1dxqUDTZqthgyeIM1hvZdngSBYqU9CFlFLo1zuT0OZoiqCFI
 Feuw==
X-Gm-Message-State: AOJu0YzRztklxK2MgERP91Z+k/r5HGa7fwvM+qoa+ppJ7ikFBDjg5quS
 6szXMqFVKzcPGsY537LlNbCgBDBeKnPeZK+6iA0=
X-Google-Smtp-Source: AGHT+IGVV+pZaMiy+Z3f7/aRrWMk3aJyOAFhk3QF3EmTP9jdR+jheOPp202wrOYzhe9oUxwOiuTgNWf56mKCu689R24=
X-Received: by 2002:a05:6402:5186:b0:53f:9045:8cbe with SMTP id
 q6-20020a056402518600b0053f90458cbemr9458749edd.26.1698155544156; Tue, 24 Oct
 2023 06:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
In-Reply-To: <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 24 Oct 2023 14:52:12 +0100
Message-ID: <CALeDE9OxQxknWmDxdR8D6YMBPP5xVcTceSWwVmTztFDqqjmc+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: seanedmond@linux.microsoft.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 24, 2023 at 1:30=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
> > From: Sean Edmond <seanedmond@microsoft.com>
> >
> > Allow dhcp server pass pxe config file full path by using option 209
> >
> > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > ---
> >   cmd/Kconfig |  4 ++++
> >   cmd/pxe.c   | 10 ++++++++++
> >   net/bootp.c | 21 +++++++++++++++++++++
> >   3 files changed, 35 insertions(+)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 5bc0a92d57..adbb1a6187 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
> >       default 0x15 if ARM
> >       default 0x0 if X86
> >
> > +config BOOTP_PXE_DHCP_OPTION
> > +     bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
> > +     depends on BOOTP_PXE
>
> Why should this be disabled by default?
>
> Do we really want a separate config variable?

I had similar thoughts, if it's a defined DHCP option I suspect most
users will want to use that for PXE, if it's not defined we'll have
the same process as we have now for the use to fall back to.

> > +
> >   config BOOTP_VCI_STRING
> >       string
> >       depends on CMD_BOOTP
> > diff --git a/cmd/pxe.c b/cmd/pxe.c
> > index 704589702f..9404f44518 100644
> > --- a/cmd/pxe.c
> > +++ b/cmd/pxe.c
> > @@ -65,6 +65,8 @@ static int pxe_dhcp_option_path(struct pxe_context *c=
tx, unsigned long pxefile_a
> >       int ret =3D get_pxe_file(ctx, pxelinux_configfile, pxefile_addr_r=
);
> >
> >       free(pxelinux_configfile);
> > +     /* set to NULL to avoid double-free if DHCP is tried again */
> > +     pxelinux_configfile =3D NULL;
> >
> >       return ret;
> >   }
> > @@ -141,6 +143,14 @@ int pxe_get(ulong pxefile_addr_r, char **bootdirp,=
 ulong *sizep, bool use_ipv6)
> >                         env_get("bootfile"), use_ipv6))
> >               return -ENOMEM;
> >
> > +     if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
> > +         pxelinux_configfile && !use_ipv6) {
> > +             if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
> > +                     goto done;
> > +
> > +             goto error_exit;
> > +     }
> > +
> >       if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OPTION) &&
> >           pxelinux_configfile && use_ipv6) {
> >               if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
> > diff --git a/net/bootp.c b/net/bootp.c
> > index 7b0f45e18a..6800290963 100644
> > --- a/net/bootp.c
> > +++ b/net/bootp.c
> > @@ -26,6 +26,7 @@
> >   #ifdef CONFIG_BOOTP_RANDOM_DELAY
> >   #include "net_rand.h"
> >   #endif
> > +#include <malloc.h>
> >
> >   #define BOOTP_VENDOR_MAGIC  0x63825363      /* RFC1048 Magic Cookie *=
/
> >
> > @@ -601,6 +602,10 @@ static int dhcp_extended(u8 *e, int message_type, =
struct in_addr server_ip,
> >       *e++  =3D 42;
> >       *cnt +=3D 1;
> >   #endif
> > +     if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
> > +             *e++ =3D 209;     /* PXELINUX Config File */
> > +             *cnt +=3D 1;
> > +     }
> >       /* no options, so back up to avoid sending an empty request list =
*/
> >       if (*cnt =3D=3D 0)
> >               e -=3D 2;
> > @@ -909,6 +914,22 @@ static void dhcp_process_options(uchar *popt, ucha=
r *end)
> >                               net_boot_file_name[size] =3D 0;
> >                       }
> >                       break;
> > +             case 209:       /* PXELINUX Config File */
>
> This 209 appears in multiple places. Please, define a constant, e.g.
> DHCP_OPTION_CONFIG_FILE, in bootp.h and use the symbolic name. Please,
> document the constant referring to RFC 5071.
>
> > +                     if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
> > +                             /* In case it has already been allocated =
when get DHCP Offer packet,
> > +                              * free first to avoid memory leak.
> > +                              */
> > +                             if (pxelinux_configfile)
> > +                                     free(pxelinux_configfile);
> > +
> > +                             pxelinux_configfile =3D (char *)malloc((o=
plen + 1) * sizeof(char));
> > +
> > +                             if (pxelinux_configfile)
> > +                                     strlcpy(pxelinux_configfile, popt=
 + 2, oplen + 1);
> > +                             else
> > +                                     printf("Error: Failed to allocate=
 pxelinux_configfile\n");
>
> We do the same in dhcp6_parse_options(). Please, factor out a common
> function to avoid code duplication.
>
> Best regards
>
> Heinrich
>
> > +                     }
> > +                     break;
> >               default:
> >   #if defined(CONFIG_BOOTP_VENDOREX)
> >                       if (dhcp_vendorex_proc(popt))
>
