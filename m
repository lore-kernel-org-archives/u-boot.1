Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD412E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 20:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48941801EA;
	Wed, 11 Dec 2024 21:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ObdyQ6Vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFCE801EB; Wed, 11 Dec 2024 21:23:59 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2018F801DA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 21:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so251976066b.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733948636; x=1734553436; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOqhvBXed0uQ3FG9VOb7QWEzb7gz8MbPo2RTuClbG00=;
 b=ObdyQ6VtcwJMqJP9FVX79XPju2MT880Boa08q++96oqPOhY4zYj4V6v/n4GA37xGre
 SzWPPmhVeRqIpP34I61z6Mlw3U+0+DFu13SPdeX4LSsox0eFSp3/eBLDSUb6jrv9Le8H
 IFka8AWR7+UywRC0MrEbH7x7ahot2wiEjlg+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733948636; x=1734553436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOqhvBXed0uQ3FG9VOb7QWEzb7gz8MbPo2RTuClbG00=;
 b=aXv5YPNOrFJF7yGjQAPIRvp2w55S+7bgKEysxQINgsFEDq338GGWxlY9R3PIQz+d9M
 xiJqrZaJuTonWt+F0wSdvXPdRRHPQeXLJsli0eVa351wae+4NIjQRbKb+FA70mijoEL9
 rnvnyPohlTaVUMZF1TNQgiO8ZwDi5sJctUbrdLNAFwrUlrw2eMvstgPXf/JuUcP1rLTa
 8GRu1lDp/J6FEqfCrl/esD/D/kBBXqAIWk5B04U4Dzwyv3k2E7vcMdEUWA1X5hau/Z11
 PA1EW05PlfEz2pIas+tqjUT1FvVhuZtttAqv6bQz39wpWmKA1KFuEpm5yYhSEAssfoZe
 xmcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKz+cEBT8Nhid1xdhA+X4d9SG6m4SurFer+Pb5b5DTxcYrmO6qaCVE8c8CovB08XgHpYnKOZI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8DNTiyeDzst8KL3eX7QQzmu7XYd5bOBcY0M9IVPCPrzvwzYcT
 wb1gsjZ8Zx8tnR78IPaiuql4vJhSqsLXodu/RLUha2B+dw4jwdI2Z8gaw7ellVdPyVUw2LzJbI/
 0rBvXkqeC4NxDrky/lbzz1MZ1airmHQrPdhZkxvhK/cHJ+MY=
X-Gm-Gg: ASbGncsXImNIVM994YNfo3AL/vKnGsyYGyJKvEkf4lxTBHtePiRQJUEDup4kG2cIce/
 y9Tfja6GEgsTZuPerjmhPHKfRrbl5Ks0EsuNb
X-Google-Smtp-Source: AGHT+IEgrke+qJwmAScy/SxPN8JAcGAhuyJ0k201Ratru2UfJf7TO2jxHKOCk2QvWlMzxKWpmlLXx1/vwXF0jVC6s8c=
X-Received: by 2002:a17:906:4d2:b0:aa6:6ee6:1b7f with SMTP id
 a640c23a62f3a-aa6c1b1cdb0mr114173066b.33.1733948636522; Wed, 11 Dec 2024
 12:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
 <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
 <20241210171113.GD2457179@bill-the-cat>
 <CAFBqBq9-wrpXnz99TNNokjMqbzz0fJPq+UUMqhuuMqZwmjSH=Q@mail.gmail.com>
In-Reply-To: <CAFBqBq9-wrpXnz99TNNokjMqbzz0fJPq+UUMqhuuMqZwmjSH=Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 13:23:44 -0700
Message-ID: <CAFLszTiD21ut+i1ob3sWCMtWF8ccXvhj2c306DDamz06EmpQmQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Janis Danisevskis <jdanisevskis@aurora.tech>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Matthew Garrett <mjg59@srcf.ucam.org>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Janis,

On Wed, 11 Dec 2024 at 10:50, Janis Danisevskis
<jdanisevskis@aurora.tech> wrote:
>
> Hi everyone,
>
> Good catch finding this leak. Would you like me to provide an updated pat=
ch?
> I am good either way. Let Simon take credit for the fix on the git histor=
y. I can live with
> shame :-).

Thanks for the email. If you're able to send a v2, take a look at this
series which has a few other things:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D436150

You can incorporate any or all of those and there's no need to keep me
as the author of anything in particular.

Regards,
Simon


>
> Janis
>
> On Tue, Dec 10, 2024 at 9:11=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
>>
>> On Tue, Dec 10, 2024 at 09:17:26AM -0700, Simon Glass wrote:
>> > Hi Heinrich,
>> >
>> > On Tue, 10 Dec 2024 at 01:50, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
>> > >
>> > > On 23.11.24 20:55, Matthew Garrett wrote:
>> > > > From: Janis Danisevskis <jdanisevskis@aurora.tech>
>> > > >
>> > > > efi_bind_block had two issues.
>> > > > 1. A pointer to a the stack was inserted as plat structure and thu=
s used
>> > > > beyond its life time.
>> > > > 2. Only the first segment of the device path was copied into the
>> > > > platfom data structure resulting in an unterminated device path.
>> > > >
>> > > > Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
>> > > > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
>> > > > ---
>> > > >
>> > > >   lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
>> > > >   1 file changed, 21 insertions(+), 8 deletions(-)
>> > > >
>> > > > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
>> > > > index 9704020b749..cc91e1d74b8 100644
>> > > > --- a/lib/efi/efi_app_init.c
>> > > > +++ b/lib/efi/efi_app_init.c
>> > > > @@ -19,6 +19,15 @@
>> > > >
>> > > >   DECLARE_GLOBAL_DATA_PTR;
>> > > >
>> > > > +static size_t device_path_length(const struct efi_device_path *de=
vice_path)
>> > > > +{
>> > > > +     const struct efi_device_path *d;
>> > > > +
>> > > > +     for (d =3D device_path; d->type !=3D DEVICE_PATH_TYPE_END; d=
 =3D (void *)d + d->length) {
>> > > > +     }
>> > > > +     return (void *)d - (void *)device_path + d->length;
>> > > > +}
>> > > > +
>> > > >   /**
>> > > >    * efi_bind_block() - bind a new block device to an EFI device
>> > > >    *
>> > > > @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct=
 efi_block_io *blkio,
>> > > >                  struct efi_device_path *device_path, int len,
>> > > >                  struct udevice **devp)
>> > > >   {
>> > > > -     struct efi_media_plat plat;
>> > > > +     struct efi_media_plat *plat;
>> > > >       struct udevice *dev;
>> > > >       char name[18];
>> > > >       int ret;
>> > > > -
>> > > > -     plat.handle =3D handle;
>> > > > -     plat.blkio =3D blkio;
>> > > > -     plat.device_path =3D malloc(device_path->length);
>> > > > -     if (!plat.device_path)
>> > > > +     size_t device_path_len =3D device_path_length(device_path);
>> > > > +
>> > > > +     plat =3D malloc(sizeof(struct efi_media_plat));
>> > > > +     if (!plat)
>> > > > +             return log_msg_ret("plat", -ENOMEM);
>> > > > +     plat->handle =3D handle;
>> > > > +     plat->blkio =3D blkio;
>> > > > +     plat->device_path =3D malloc(device_path_len);
>> > > > +     if (!plat->device_path)
>> > > >               return log_msg_ret("path", -ENOMEM);
>> > > > -     memcpy(plat.device_path, device_path, device_path->length);
>> > > > +     memcpy(plat->device_path, device_path, device_path_len);
>> > > >       ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media), "ef=
i_media",
>> > > > -                       &plat, ofnode_null(), &dev);
>> > > > +                       plat, ofnode_null(), &dev);
>> > > >       if (ret)
>> > > >               return log_msg_ret("bind", ret);
>> > >
>> > > Here you have a memory leak for pointer plat if ret !=3D 0.
>> > >
>> > > Simon suggested a follow up patch. Instead we should fix it in this =
patch.
>> > >
>> > > @Simon
>> > > The logic in the caller setup_block() looks wrong.
>> > >
>> > > LocateHandle() does not ensure that when you try to read from the bl=
ock
>> > > device the same still does exist. E.g. if a USB device is removed th=
e
>> > > block IO protocol could be uninstalled and the handle deleted and th=
e
>> > > EFI app may crash. Please, call OpenProtocol() with attribute BY_DRI=
VER.
>> > >
>> > > HandleProtocol() is considered deprecated. Please, use OpenProtocol(=
)
>> > > instead.
>> >
>> > Can you please send a follow-up with your ideas on this?
>>
>> Simon, it's in your tree. The normal path here would be that the
>> submitter would correct this in v2. But you're trying to short-circuit
>> that path for your own reasons. No one should be making work on top of
>> your tree except for you.
>>
>> --
>> Tom
