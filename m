Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DF3E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8612A80431;
	Wed, 11 Dec 2024 19:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=aurora.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=aurora.tech header.i=@aurora.tech header.b="X/K/ZyAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C82803CB; Wed, 11 Dec 2024 18:50:47 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED8C803AE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 18:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jdanisevskis@aurora.tech
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29fd0e63226so1696520fac.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aurora.tech; s=google; t=1733939442; x=1734544242; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EzpdB7vV9VJxrrp5OlsOcQb73jvOw1zw2Owk9+Itbo4=;
 b=X/K/ZyAh8g3puDuKKwBLclx7/YEhH70LbK1zYmSDHZEz4tR1y7fMtD0Prz8XrCMYf9
 JsoyaBqsT/McOiSXWG6TOvWHj1/wY9qNyYSHEOWnLbcnAV6fEVufTE3HRgwW4DhDTItj
 4PitKQi7H2o3QeBQ8R00Z+wXyKRpl2jVy0KNVo/BStgI6vNs5tDNbazYvKkMiFvp2uOm
 whf2NYQJuddqhAgnkoCQOlK/8Kl+FCONGaRWKe8UdKqib3su7AQG9mv3NzuGYsNYP9sh
 QxT0vIK6x53dSkEuPoIkG61d0iZcwIcTaqIBXdkkg2zS1+T6bSyWLU/EfbHMTvyOhSVV
 Y2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733939442; x=1734544242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzpdB7vV9VJxrrp5OlsOcQb73jvOw1zw2Owk9+Itbo4=;
 b=tyhXfI9fjCVbFBP38k05+6Cs+QYP87NeuvDRA9w7v7tc/yT6MqhepRUNbdSSlQQq85
 9LNG5xMtZkCcj/ydVb68R0fkRgdDS9M1ddWB87Keu4nXIUHAZlJHNSrK9pq6R+6pg+9X
 rkIjRRjG4Ii3860pyS3+gIvowNJDAesmUCo11x8iZ7IOtkMTyP9gD1pcUcCOMMgbrDwG
 VU2w+Oz44TUc34AxlXMvhB5aGA/C56btysqm/TDprIzGYOX6ACdF0RkkXShFV1dQUx6b
 wD9bQ5icZQBkStYCQ6bWGiuCWDh1X9xrxDbNceo1SHJZ/bn03K9/Pd3c7KRdCD26kAHv
 heKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSm03gtPNufpO0nJRaEHdN89NgiRBmZRmGJpgR5YeQUWG8XBd4v8k/SYtE+GiHITg6Xzmzueo=@lists.denx.de
X-Gm-Message-State: AOJu0YyZkk4XJtT261dv2eBHYJtxtmxWsY8MN0+bU1VC3L+0PL+jlJeF
 Ie4WakSUX/cixLx2Xzj2BdST4Q94hbdSGZtG3SwBvO49QT82U6a35hfrU+lQEUnRm/5hAJ5jSnj
 usTv471zNUywtuvKhK6e/Ai0yxaiKVpqaoH3ghw==
X-Gm-Gg: ASbGnct4631af0pZ6VSPky12rHiNzIeuLtEV24VGNQftUGvHQ0+PLdcBlSUKuOOUXF6
 y0eR9Gy5KNoZV6qGXy7CuiAAnBSdytAu/
X-Google-Smtp-Source: AGHT+IH+ic9DVisZQA3EY41bin/OB0hPxe6uyEr4ijO9WijwmHcHaRHHTtRibOztOWPsW3m/Y3glexR+NmMAG//seOQ=
X-Received: by 2002:a05:6870:89a3:b0:29e:67cd:1a89 with SMTP id
 586e51a60fabf-2a382756a63mr490917fac.36.1733939442667; Wed, 11 Dec 2024
 09:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
 <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
 <20241210171113.GD2457179@bill-the-cat>
In-Reply-To: <20241210171113.GD2457179@bill-the-cat>
From: Janis Danisevskis <jdanisevskis@aurora.tech>
Date: Wed, 11 Dec 2024 09:50:32 -0800
Message-ID: <CAFBqBq9-wrpXnz99TNNokjMqbzz0fJPq+UUMqhuuMqZwmjSH=Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Matthew Garrett <mjg59@srcf.ucam.org>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 11 Dec 2024 19:54:12 +0100
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

Hi everyone,

Good catch finding this leak. Would you like me to provide an updated patch=
?
I am good either way. Let Simon take credit for the fix on the git history.
I can live with
shame :-).

Janis

On Tue, Dec 10, 2024 at 9:11=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:

> On Tue, Dec 10, 2024 at 09:17:26AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 10 Dec 2024 at 01:50, Heinrich Schuchardt <xypron.glpk@gmx.de>
> wrote:
> > >
> > > On 23.11.24 20:55, Matthew Garrett wrote:
> > > > From: Janis Danisevskis <jdanisevskis@aurora.tech>
> > > >
> > > > efi_bind_block had two issues.
> > > > 1. A pointer to a the stack was inserted as plat structure and thus
> used
> > > > beyond its life time.
> > > > 2. Only the first segment of the device path was copied into the
> > > > platfom data structure resulting in an unterminated device path.
> > > >
> > > > Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> > > > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> > > > ---
> > > >
> > > >   lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
> > > >   1 file changed, 21 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> > > > index 9704020b749..cc91e1d74b8 100644
> > > > --- a/lib/efi/efi_app_init.c
> > > > +++ b/lib/efi/efi_app_init.c
> > > > @@ -19,6 +19,15 @@
> > > >
> > > >   DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > > +static size_t device_path_length(const struct efi_device_path
> *device_path)
> > > > +{
> > > > +     const struct efi_device_path *d;
> > > > +
> > > > +     for (d =3D device_path; d->type !=3D DEVICE_PATH_TYPE_END; d =
=3D
> (void *)d + d->length) {
> > > > +     }
> > > > +     return (void *)d - (void *)device_path + d->length;
> > > > +}
> > > > +
> > > >   /**
> > > >    * efi_bind_block() - bind a new block device to an EFI device
> > > >    *
> > > > @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct
> efi_block_io *blkio,
> > > >                  struct efi_device_path *device_path, int len,
> > > >                  struct udevice **devp)
> > > >   {
> > > > -     struct efi_media_plat plat;
> > > > +     struct efi_media_plat *plat;
> > > >       struct udevice *dev;
> > > >       char name[18];
> > > >       int ret;
> > > > -
> > > > -     plat.handle =3D handle;
> > > > -     plat.blkio =3D blkio;
> > > > -     plat.device_path =3D malloc(device_path->length);
> > > > -     if (!plat.device_path)
> > > > +     size_t device_path_len =3D device_path_length(device_path);
> > > > +
> > > > +     plat =3D malloc(sizeof(struct efi_media_plat));
> > > > +     if (!plat)
> > > > +             return log_msg_ret("plat", -ENOMEM);
> > > > +     plat->handle =3D handle;
> > > > +     plat->blkio =3D blkio;
> > > > +     plat->device_path =3D malloc(device_path_len);
> > > > +     if (!plat->device_path)
> > > >               return log_msg_ret("path", -ENOMEM);
> > > > -     memcpy(plat.device_path, device_path, device_path->length);
> > > > +     memcpy(plat->device_path, device_path, device_path_len);
> > > >       ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media),
> "efi_media",
> > > > -                       &plat, ofnode_null(), &dev);
> > > > +                       plat, ofnode_null(), &dev);
> > > >       if (ret)
> > > >               return log_msg_ret("bind", ret);
> > >
> > > Here you have a memory leak for pointer plat if ret !=3D 0.
> > >
> > > Simon suggested a follow up patch. Instead we should fix it in this
> patch.
> > >
> > > @Simon
> > > The logic in the caller setup_block() looks wrong.
> > >
> > > LocateHandle() does not ensure that when you try to read from the blo=
ck
> > > device the same still does exist. E.g. if a USB device is removed the
> > > block IO protocol could be uninstalled and the handle deleted and the
> > > EFI app may crash. Please, call OpenProtocol() with attribute
> BY_DRIVER.
> > >
> > > HandleProtocol() is considered deprecated. Please, use OpenProtocol()
> > > instead.
> >
> > Can you please send a follow-up with your ideas on this?
>
> Simon, it's in your tree. The normal path here would be that the
> submitter would correct this in v2. But you're trying to short-circuit
> that path for your own reasons. No one should be making work on top of
> your tree except for you.
>
> --
> Tom
>
