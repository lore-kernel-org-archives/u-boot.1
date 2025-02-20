Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A228C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB5B801BE;
	Thu, 20 Feb 2025 14:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MKER5+Yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE3480C98; Thu, 20 Feb 2025 14:12:45 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD418007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc0d44a876so1404422a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740057161; x=1740661961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HpBeWSY5d/mImHInGeCD6iZQL03ddhYIJZBRLWRvG2c=;
 b=MKER5+Yg//lN8po/dY0XZPuujiIwShH3un/li5Fgm8kzG3JUu72BPL0zJ4eX2i/MyG
 6VPKCWchx/5o/5lS4Ta1HoSKDRtpd5RzcPlaHRW0P4+l5TshitqDb6YDcYMF7SLR0OZj
 t/TG56mMaF/qRFFl5CmGYwieyGP1XuebLI1YARgQu5fdNTLrbzW5LC/2s39FU4WFOx/k
 Me8LCW82FyYaRuJbm9xGOT5XKCFWGgM+HRKFoO/pEWTw6CgBqGOMgzMH1FzW4nfJ7/HI
 Otbslsy8RRt8LcXq8Spx/CQ9Ft1ALIHSP8zvdMc9LWKHL1rtqMUtvgOUHN1jT91/5yxS
 mbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740057161; x=1740661961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HpBeWSY5d/mImHInGeCD6iZQL03ddhYIJZBRLWRvG2c=;
 b=k/4JlCciBdUXe30eJZCPfssWnGRkJF+YMguCwu74tLVNAStnrwhon7M4q6g0WFyMyI
 rNTTgkuJ5fgtluwrkRotlkA6k0ZApCvB5us1ZAlej35VKHcajb2sDPsdu3SzT5gg9co/
 JBc0fTve+lHM8gs7osEAmuZ/yfAS6KhL7bHMF8tg+zDQoYIfShwoN9T6PI0BPeqaJskw
 5A/K7wC2wuBmvZMp1gG3vQAkFIvDFByPAOHbU1/Ow5BXCMPGtCv03W9dHPv9nZx0iEu4
 H2SdkO1T+OjUw3XLulI2fvn7sSS+hrXpJ2Kg3ZohM8BzVePaUSZpeebAFViz6DXcbmg3
 IFpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx8w8A4N8OEouwcK8gVK38UfV+hHnS7BLh7YeuZWwjEzt7/fN5JwjGAslHHQnXDCKeg31RsYI=@lists.denx.de
X-Gm-Message-State: AOJu0YymZ3vdFcFGz5aUpswcU06T+ywvag6xGMt+nRbnHMiSDX8vluUc
 JGNxRfPk3njCH7yCfYG9bJ58uL6DRzZHaEbiixArapsM7RAOzWc7z3j9uEjxtm5rW5mHd1zYe0O
 RahnxxIUn+YDo3xNrmLiBirfQOgo=
X-Gm-Gg: ASbGncuYnc2C65nbix6LKcWs3loy7bAcQp4sqbYmo1PXs6M/uDHlW2Baa7tcavlU2Ns
 AFwmE1KMXeEIkVNGS0xk0VVHyJ0uO3DTB2NqO/u3m3zOKyb5ogLV0x3Zhn/XugxEafZg+ePp3JQ
 ==
X-Google-Smtp-Source: AGHT+IF5LgCljx5l6By730udzvh1961qi4Ih5W2+lExW1giZZRQbHwRlJtlKFutF8VBOkyFyp1fiH+l/BNF7vEnUwA0=
X-Received: by 2002:a17:90b:2d07:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2fc410493bbmr36827761a91.24.1740057161327; Thu, 20 Feb 2025
 05:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20250127123445.1040480-1-adriano.cordova@canonical.com>
 <20250127123445.1040480-2-adriano.cordova@canonical.com>
 <2185e2ad-e9cf-4ea7-ad59-c5446efaf733@gmx.de>
In-Reply-To: <2185e2ad-e9cf-4ea7-ad59-c5446efaf733@gmx.de>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Thu, 20 Feb 2025 10:12:30 -0300
X-Gm-Features: AWEUYZnh33KggncWJBbIqPQCF6RXJA7v3aOIwZ4cla19rWjSRi_LGnONgpyv4so
Message-ID: <CAMGU2hW-R_59fPUZJKxRYL-rZ8f8hV2gHSj+9it=GntHPNEqhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
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

El jue, 20 feb 2025 a las 4:54, Heinrich Schuchardt (<xypron.glpk@gmx.de>)
escribi=C3=B3:

> On 1/27/25 13:34, Adriano Cordova wrote:
> > This commit fixes an use after free introduced in Commit e55a4acb54
> > (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> > from wget"). The logic in efi_net_set_dp is reworked so that when the
> > function is invoked it not only changes the value of the static variabl=
e
> > net_dp (this is how the function was implemented in e55a4acb54) but als=
o
> > updates the protocol interface of the device path protocol in case efi
> > has started.
> >
> > Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path t=
o
> HTTP when loaded from wget")
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> > Changes in v3: initialize ret variable in efi_net_set_dp
> > Changes in v2: use reinstall_protocol_interface() and new_net_dp in the
> body of efi_net_set_dp()
> >
> >   lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++-----=
-
> >   1 file changed, 52 insertions(+), 9 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> > index 67593ef50c0..f696a47060c 100644
> > --- a/lib/efi_loader/efi_net.c
> > +++ b/lib/efi_loader/efi_net.c
> > @@ -925,12 +925,15 @@ efi_status_t efi_net_register(void)
> >                            &netobj->net);
> >       if (r !=3D EFI_SUCCESS)
> >               goto failure_to_add_protocol;
> > -     if (!net_dp)
> > -             efi_net_set_dp("Net", NULL);
> > -     r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > -                          net_dp);
> > +
> > +     if (net_dp)
> > +             r =3D efi_add_protocol(&netobj->header,
> &efi_guid_device_path,
> > +                            net_dp);
> > +     else
> > +             r =3D efi_net_set_dp("Net", NULL);
>
> Hello Adriano,
>
> thanks for spotting and fixing the issue.
>
> Patch 1 of the series is already merged.
>
> Why would we create a device-path here and not install it?
>
> If this is really intended, please, add a comment.
>

Hi Heinrich,

efi_net_set_dp is installing it (only if EFI is already up, otherwise it
saves it in net_dp).

>
> >       if (r !=3D EFI_SUCCESS)
> >               goto failure_to_add_protocol;
> > +
> >       r =3D efi_add_protocol(&netobj->header,
> &efi_pxe_base_code_protocol_guid,
> >                            &netobj->pxe);
> >       if (r !=3D EFI_SUCCESS)
> > @@ -1055,18 +1058,58 @@ out_of_resources:
> >    */
> >   efi_status_t efi_net_set_dp(const char *dev, const char *server)
> >   {
> > -     efi_free_pool(net_dp);
> > +     efi_status_t ret =3D EFI_SUCCESS;
> > +     struct efi_handler *phandler;
> > +     struct efi_device_path *old_net_dp, *new_net_dp;
> >
> > -     net_dp =3D NULL;
> > +     old_net_dp =3D net_dp;
> > +     new_net_dp =3D NULL;
> >       if (!strcmp(dev, "Net"))
> > -             net_dp =3D efi_dp_from_eth();
> > +             new_net_dp =3D efi_dp_from_eth();
> >       else if (!strcmp(dev, "Http"))
> > -             net_dp =3D efi_dp_from_http(server);
> > +             new_net_dp =3D efi_dp_from_http(server);
> >
> > -     if (!net_dp)
> > +     if (!new_net_dp) {
> >               return EFI_OUT_OF_RESOURCES;
> > +     }
> > +
> > +     // If netobj is not started yet, end here.
> > +     if (!netobj) {
> > +             goto exit;
> > +     }
> > +
> > +     phandler =3D NULL;
> > +     efi_search_protocol(&netobj->header, &efi_guid_device_path,
> &phandler);
> > +
> > +     // If the device path protocol is not yet installed, install it
> > +     if (!phandler)
> > +             goto add;
> > +
> > +     // If it is already installed, try to update it
> > +     ret =3D efi_reinstall_protocol_interface(&netobj->header,
> &efi_guid_device_path,
> > +                                            old_net_dp, new_net_dp);
> > +     if (ret !=3D EFI_SUCCESS)
> > +             goto error;
> > +
> > +     net_dp =3D new_net_dp;
> > +     efi_free_pool(old_net_dp);
>
> How can we be sure that old_net_dp is a device-tree that we installed
> and was not installed by an EFI application?
>
> Best regards
>
> Heinrich
>

Because it comes from the net_dp variable, which is not accessible to EFI
applications, and is always allocated by U-Boot.

Best,
Adriano

>
> >
> >       return EFI_SUCCESS;
> > +add:
> > +     ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > +                            new_net_dp);
> > +     if (ret !=3D EFI_SUCCESS)
> > +             goto error;
> > +exit:
> > +     net_dp =3D new_net_dp;
> > +     efi_free_pool(old_net_dp);
> > +
> > +     return ret;
> > +error:
> > +     // Failed, restore
> > +     efi_free_pool(new_net_dp);
> > +
> > +     return ret;
> >   }
> >
> >   /**
>
>
