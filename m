Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2D1C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED210801BE;
	Thu, 20 Feb 2025 14:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U3kW9bdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5A6801DE; Thu, 20 Feb 2025 14:25:02 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD1C8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc0d44a876so1423989a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740057898; x=1740662698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EuB9RyrH7cmtJhjKrqiJHUJkbRdE2GAFsZsHmBa7DHM=;
 b=U3kW9bdZr+6Zmyi/IEOm5Ea/y7ZdULnoNlNP35qECfpLZQb/oZVf9ongBZfg+jDT1b
 ecCOsNMlRzxfUTcNYUWlxM5mUfH3UQM4GLW+Y+e6YhJNL2Xtme/Xs7vlPYKAT1xxL3yV
 quFK/V1oo2TmqaNR8n4fTbRLFD5xUkiMz0rLbXdeMo1zDVXKNZCEu4PPT//T2UCw1vZj
 00s9Mc29X771LI6JNt4ejJp4Fyn9rdQ6IZbTpeyUaNTSu8gbRcZg7dS3+OhxKQPrlM+X
 0GkqVfJO+y09YJ+5u+c3WVgu4NOaE9f9388qEaYGaR/TkahsQdnepmOloNapdctvzYvz
 qXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740057898; x=1740662698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuB9RyrH7cmtJhjKrqiJHUJkbRdE2GAFsZsHmBa7DHM=;
 b=k97pcg0sLiIeRO13gIBFZ9iIWbROjZuSXLuXsfX+D7+exibgt8rG+7UXC2sVIniKZK
 K1eGBgKUyHdhgnLCDcC6NWKPKpweaDcTH8nJSat0GrHWNryqF7lRb2hZKHUftUOwz2L5
 q6FaLbSYT6STbwfIJe292X/SLimZ+FkmD5XV8kvYJVqxNUmJY1zwiRTSKPZ/7E4EIcEl
 WI7TDA+x1PbPJI+nWD4YC1B8qgP3Qt2S29GIO25ev/20a63kH2duRvwJamxhfs9RSu+F
 oxLWcLEW8RQbH/zxY3VI2hEFqMt4aJ+eqV+d6BgppGih2CB8pDhZaXPYgzUnKhbSVDSv
 OyMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr1Eo135cx22aUrzahCllxkfNar2WRteWK+kQrfSxCHNgQ0w4nQ92YZB78qfgNx3AI2S55REQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzRLzboWp0SsJzQVreqp3IRt/WjCxXMP5e3mDotJmE4K6mBTYXx
 yPdUdoGUX+h/CLGtWUWE2cVhXj+B4GtcpU3aEjIf9d5gUZqsSjJVTqdpQZ2Wnx+3tfZpvhy2qhx
 Dp14KrHoXU9Wno46W0ISpDFOfoYFgjEEC3DuAiQ==
X-Gm-Gg: ASbGncsaCtkRm9Y+ymV+owwcqPym3duXx+9MK+q4fhHtVy2vjYawa6bxgeJQzsUhZHy
 OpXcXN3VilQAsBMh3E2IXeWKUgUyczpyVpJSJ4nHb8UOcOJKf3XJLJndhBs4I+PGVt+qX5BYhRQ
 ==
X-Google-Smtp-Source: AGHT+IFB9h15Co5kKzjxt/I9Yd2v/2feVf33ecDjKerYnlgoD2yr0esFXatXiLf5KPEfo48D+OAcAeUVWqdbxDcBs9c=
X-Received: by 2002:a17:90b:1b4b:b0:2fa:1f1b:3db2 with SMTP id
 98e67ed59e1d1-2fc41049565mr33911193a91.25.1740057897895; Thu, 20 Feb 2025
 05:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20250127123445.1040480-1-adriano.cordova@canonical.com>
 <20250127123445.1040480-2-adriano.cordova@canonical.com>
 <2185e2ad-e9cf-4ea7-ad59-c5446efaf733@gmx.de>
 <CAMGU2hW-R_59fPUZJKxRYL-rZ8f8hV2gHSj+9it=GntHPNEqhw@mail.gmail.com>
In-Reply-To: <CAMGU2hW-R_59fPUZJKxRYL-rZ8f8hV2gHSj+9it=GntHPNEqhw@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Thu, 20 Feb 2025 10:24:47 -0300
X-Gm-Features: AWEUYZl8uKRYUzMWVerGKyDw4jcioxuDGUnQ3ttDhaxj5zs71ReOLglnRiCMhMY
Message-ID: <CAMGU2hVkeEFmTZk81JKaas7etW7pxPaeBe+_e1mvP5_b7L9V2w@mail.gmail.com>
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

El jue, 20 feb 2025 a las 10:12, Adriano C=C3=B3rdova (<adrianox@gmail.com>=
)
escribi=C3=B3:

>
>
> El jue, 20 feb 2025 a las 4:54, Heinrich Schuchardt (<xypron.glpk@gmx.de>=
)
> escribi=C3=B3:
>
>> On 1/27/25 13:34, Adriano Cordova wrote:
>> > This commit fixes an use after free introduced in Commit e55a4acb54
>> > (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
>> > from wget"). The logic in efi_net_set_dp is reworked so that when the
>> > function is invoked it not only changes the value of the static variab=
le
>> > net_dp (this is how the function was implemented in e55a4acb54) but al=
so
>> > updates the protocol interface of the device path protocol in case efi
>> > has started.
>> >
>> > Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path
>> to HTTP when loaded from wget")
>> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>> > ---
>> > Changes in v3: initialize ret variable in efi_net_set_dp
>> > Changes in v2: use reinstall_protocol_interface() and new_net_dp in th=
e
>> body of efi_net_set_dp()
>> >
>> >   lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++----=
--
>> >   1 file changed, 52 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
>> > index 67593ef50c0..f696a47060c 100644
>> > --- a/lib/efi_loader/efi_net.c
>> > +++ b/lib/efi_loader/efi_net.c
>> > @@ -925,12 +925,15 @@ efi_status_t efi_net_register(void)
>> >                            &netobj->net);
>> >       if (r !=3D EFI_SUCCESS)
>> >               goto failure_to_add_protocol;
>> > -     if (!net_dp)
>> > -             efi_net_set_dp("Net", NULL);
>> > -     r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
>> > -                          net_dp);
>> > +
>> > +     if (net_dp)
>> > +             r =3D efi_add_protocol(&netobj->header,
>> &efi_guid_device_path,
>> > +                            net_dp);
>> > +     else
>> > +             r =3D efi_net_set_dp("Net", NULL);
>>
>> Hello Adriano,
>>
>> thanks for spotting and fixing the issue.
>>
>> Patch 1 of the series is already merged.
>>
>> Why would we create a device-path here and not install it?
>>
>> If this is really intended, please, add a comment.
>>
>
> Hi Heinrich,
>
> efi_net_set_dp is installing it (only if EFI is already up, otherwise it
> saves it in net_dp).
>
>>
>> >       if (r !=3D EFI_SUCCESS)
>> >               goto failure_to_add_protocol;
>> > +
>> >       r =3D efi_add_protocol(&netobj->header,
>> &efi_pxe_base_code_protocol_guid,
>> >                            &netobj->pxe);
>> >       if (r !=3D EFI_SUCCESS)
>> > @@ -1055,18 +1058,58 @@ out_of_resources:
>> >    */
>> >   efi_status_t efi_net_set_dp(const char *dev, const char *server)
>> >   {
>> > -     efi_free_pool(net_dp);
>> > +     efi_status_t ret =3D EFI_SUCCESS;
>> > +     struct efi_handler *phandler;
>> > +     struct efi_device_path *old_net_dp, *new_net_dp;
>> >
>> > -     net_dp =3D NULL;
>> > +     old_net_dp =3D net_dp;
>> > +     new_net_dp =3D NULL;
>> >       if (!strcmp(dev, "Net"))
>> > -             net_dp =3D efi_dp_from_eth();
>> > +             new_net_dp =3D efi_dp_from_eth();
>> >       else if (!strcmp(dev, "Http"))
>> > -             net_dp =3D efi_dp_from_http(server);
>> > +             new_net_dp =3D efi_dp_from_http(server);
>> >
>> > -     if (!net_dp)
>> > +     if (!new_net_dp) {
>> >               return EFI_OUT_OF_RESOURCES;
>> > +     }
>> > +
>> > +     // If netobj is not started yet, end here.
>> > +     if (!netobj) {
>> > +             goto exit;
>> > +     }
>> > +
>> > +     phandler =3D NULL;
>> > +     efi_search_protocol(&netobj->header, &efi_guid_device_path,
>> &phandler);
>> > +
>> > +     // If the device path protocol is not yet installed, install it
>> > +     if (!phandler)
>> > +             goto add;
>> > +
>> > +     // If it is already installed, try to update it
>> > +     ret =3D efi_reinstall_protocol_interface(&netobj->header,
>> &efi_guid_device_path,
>> > +                                            old_net_dp, new_net_dp);
>> > +     if (ret !=3D EFI_SUCCESS)
>> > +             goto error;
>> > +
>> > +     net_dp =3D new_net_dp;
>> > +     efi_free_pool(old_net_dp);
>>
>> How can we be sure that old_net_dp is a device-tree that we installed
>> and was not installed by an EFI application?
>>
>> Best regards
>>
>> Heinrich
>>
>
> Because it comes from the net_dp variable, which is not accessible to EFI
> applications, and is always allocated by U-Boot.
>
> Best,
> Adriano
>

Although it could be teoretically freed by an application. In that case we
would be freeing it twice.

>
>> >
>> >       return EFI_SUCCESS;
>> > +add:
>> > +     ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
>> > +                            new_net_dp);
>> > +     if (ret !=3D EFI_SUCCESS)
>> > +             goto error;
>> > +exit:
>> > +     net_dp =3D new_net_dp;
>> > +     efi_free_pool(old_net_dp);
>> > +
>> > +     return ret;
>> > +error:
>> > +     // Failed, restore
>> > +     efi_free_pool(new_net_dp);
>> > +
>> > +     return ret;
>> >   }
>> >
>> >   /**
>>
>>
