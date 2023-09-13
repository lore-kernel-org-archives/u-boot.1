Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203A2EDEC4D
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 12:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4F786A81;
	Wed, 13 Sep 2023 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dj0Sh3y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE6186A81; Wed, 13 Sep 2023 14:51:06 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A70D286A78
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 14:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bfb0a2682fso20909981fa.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694609462; x=1695214262; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xg6pOoetwbSVH8bb4vxc5Xq1NoarOWeihPoiKCMIyRU=;
 b=dj0Sh3y9DR8YJiDvy+3Mw3Jj1cKdmEmSnYtolvd2L/nH/yS/A3wCzQtpOVyOw0YvBt
 nEoN9BXLtktTUsAtEyzScPq9L9OfgFXTg8zTQRu9RXNkfysmhXJ5oH/HCib7TA+m6Aot
 Z3h060KGPIPS4xaH0rB7FUEbPas1yUVMeJ5qZ8xljOjRKSpOmcU4UmLy16TDcJKf1RPp
 TgcPIXxy8qhNwq5//EKodDOXyVYxfSvJiykzg0KxEQ8Hz0e4d11TJ5OXsZeapLyKnqj4
 rNuCewQHM/akoe8XKh1mD7KjXq9Ce1PtVWR/pm8lxEIwFtPHBcHJEObJ/66xflOaHJ4B
 ZMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694609462; x=1695214262;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xg6pOoetwbSVH8bb4vxc5Xq1NoarOWeihPoiKCMIyRU=;
 b=uDk0sBpPZhGEp7vdJ9Gc7n0kWzGZ1/V1PXKDVYrBNNlHoxV3svAooZ0datH50h4gdj
 tdAzlPJQmraN8MrHhN32M66pF58aGM2NQuOb4U22hGKTi4ThAzbcO6EcLOFOYkHYly+2
 Nbxo/tHZyVMY6mXyCS/6PrQLY6woXDJa5s9jqW3Yad/kK6TVXn6SkZ8B0Csv+mMAS/wX
 dqgOcsUdWkcc44DflybW3JUYl04vpkN8reSImYnKgm1SdPnbRTXzzO4iRQM7m8lRCgak
 qCvy9VUZnJDy4g/xNL5WAL1be76MZ7wQvcxbYKVc/7qz7VPlunWsIDP+5U7N+VzpdjuL
 O5IQ==
X-Gm-Message-State: AOJu0YyyoH2bv+a4QPxE1yE+/nBUvkPj2S737kv341Tku+AplXW/FuZW
 XNwZBtUfCFQw6JKgbONCS6/wZMSunsAxLuPqWoVA7T2KeOk=
X-Google-Smtp-Source: AGHT+IGdvbFlxfMFvyMkANPVWfOBr/m6hOBjZTWuc8bPR3xbg/aRf4TcB/dOJaHV7hLsZ6lKalWYacOJY+PhPl4eO1k=
X-Received: by 2002:a2e:b00e:0:b0:2bd:bc9:30aa with SMTP id
 y14-20020a2eb00e000000b002bd0bc930aamr2340706ljk.23.1694609461903; Wed, 13
 Sep 2023 05:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230831024951.22599-1-twoerner@gmail.com>
 <20230831101511.GD8826@kitsune.suse.cz>
In-Reply-To: <20230831101511.GD8826@kitsune.suse.cz>
From: Trevor Woerner <twoerner@gmail.com>
Date: Wed, 13 Sep 2023 08:50:49 -0400
Message-ID: <CAHUNapQxb=5sr3FPscBht_SAYh4++yvbMscwEnmQRJhw1TdO1g@mail.gmail.com>
Subject: Re: [PATCH] am33xx: ignore return value from usb_ether_init()
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Can this get added to the next release? I don't see it in -next.

On Thu, Aug 31, 2023 at 6:15=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:

> Hello,
>
> On Wed, Aug 30, 2023 at 10:49:50PM -0400, Trevor Woerner wrote:
> > In 2cb43ef1c223 ("usb: ether: Fix error handling in usb_ether_init") th=
e
> error
> > handling of usb_ether_init() was changed. Not a single other call site
> of this
> > function checks its return value, therefore follow suit in the am33xx
> code.
>
> then there is the question what point is there in having a return value
> in this function at all.
>
> Anyway, it's fine to not check the return value in the caller if there
> is no use for the error.
>
> Reviewed-by: Michal Such=C3=A1nek <msuchanek@suse.de>
>
> >
> > Do not cause the boot to halt if the usb gadget ethernet initialization
> fails:
> >
> >       initcall sequence 9ffdbd84 failed at call 808024b9 (err=3D-19)
> >       ### ERROR ### Please RESET the board ###
> >
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  arch/arm/mach-omap2/am33xx/board.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/am33xx/board.c
> b/arch/arm/mach-omap2/am33xx/board.c
> > index ecc0a592e993..8f772310a1a7 100644
> > --- a/arch/arm/mach-omap2/am33xx/board.c
> > +++ b/arch/arm/mach-omap2/am33xx/board.c
> > @@ -270,11 +270,7 @@ int arch_misc_init(void)
> >               return ret;
> >
> >  #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
> > -     ret =3D usb_ether_init();
> > -     if (ret) {
> > -             pr_err("USB ether init failed\n");
> > -             return ret;
> > -     }
> > +     usb_ether_init();
> >  #endif
> >
> >       return 0;
> > --
> > 2.41.0.327.gaa9166bcc0ba
> >
>
