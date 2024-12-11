Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9206CE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 18:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C093E80378;
	Wed, 11 Dec 2024 19:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i/NmGQzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1188803AE; Wed, 11 Dec 2024 19:00:12 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF862801BD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 19:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so3580034276.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733940008; x=1734544808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StwOSWoS/+VMw5k6zbg+16rNIbkK7q1Uyrej5jz2eds=;
 b=i/NmGQzNLKzwUhaog4oOV9MNu0gL8PgQRG38P6CvBe8a9fry2oMA+ixTYFj91Edu+Y
 BXzG+R84eIUAHFMrPQSpdxAud/Vtskd2wSag9wl8BPMKpFptkBuUpMHgNzYkHqsxuktK
 3o/aiayuEaA81BVDkB1KmXMJgDflpq/Gw6HDHXT4PrDTQ3NJVwpUVm1S5WzSoOkBmWb4
 Ul8vk15B+pEBcLNDPyKuwNkqcQLqs7vAPNf1IFGL+JilfmxF391prnfJATeJ2alXCvD4
 F4G/aveeTms3Jm/TO3JhwxqTUlJMCWBEyRjCfyX58fH1lnpOV+dcnqftcu/gk9XyuQXM
 huYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733940008; x=1734544808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StwOSWoS/+VMw5k6zbg+16rNIbkK7q1Uyrej5jz2eds=;
 b=F6Aq6jCI1kf90q8z2W2mpLa9iAMy7o1OeqwA7WSXj2A/U7w/aCTtpkzBQTXHK+A5+J
 DJpD63snk8E5AWgVA34LvC97LM8FNCdFVGUe3BP1Zidw8FgfvIuhxg1xjp1CQwr+oDRJ
 KXW1XYI9KCZ5HiB3N5LCvNXGMeIoY3uzRQBJXJGFscmGaJl6kAipwzYGpjehjrPYq4+G
 an3MpT1GMfF/HWXrOx3oZe8C7p5mwgfK7sUXMjDSc7JR2VlyFjk8MuSnHUOuBYawISM3
 8P9b/uifX2/y5KUXt+Iv6wriaMV6+4f0BDd77PFUx6dOJoJO4LAA9tXa9l3A4+Yc91Tr
 4ifw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbxCH6JnCBGpxnBruT7scrfRrmZ8xP2d0+PU2SfHULVyG0ZdBuV7neinTUt9mi8/4dgaWA9os=@lists.denx.de
X-Gm-Message-State: AOJu0YxAeMLG5zAC88TktcLBGNcrwnrpPypcSHugPUu2QwHNU5x2Y3zq
 kXMqZr8EGr9t6WapfCep2GZoc7Danu3MqXL2esGn40WMK8iW9qx5J2zb3PoD4/NTxOdT0w4t15c
 4pcdNDNBol1VyVWjYmh9VkPIUGKC6Mv1nBd24zA==
X-Gm-Gg: ASbGncvGyp+fMSVWQQjt58KiobcLCp3iIIANxLSfFS5nwDQC3nd463X5Q8ZEd8VQnNK
 x3Z7FJtZghrpdpuD5QxMxlpC6AkO9X0glN+k=
X-Google-Smtp-Source: AGHT+IGqD1dsIgsiAftFwId+0RgCKeIuGF6l+wbVk5iDy439yklhFFt7uCytnxO6P2QWV4jEWk5qsDmD9GvS/dn6pyQ=
X-Received: by 2002:a05:6902:1104:b0:e3a:1cfe:b656 with SMTP id
 3f1490d57ef6-e3d8fc58d25mr485364276.15.1733940007410; Wed, 11 Dec 2024
 10:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
 <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
 <20241210171113.GD2457179@bill-the-cat>
 <CAFBqBq9-wrpXnz99TNNokjMqbzz0fJPq+UUMqhuuMqZwmjSH=Q@mail.gmail.com>
In-Reply-To: <CAFBqBq9-wrpXnz99TNNokjMqbzz0fJPq+UUMqhuuMqZwmjSH=Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 19:59:31 +0200
Message-ID: <CAC_iWjLZZaRzrgL84ztdPvQT4FeTRqpxH2ZuenD3rir4eBwJPg@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Janis Danisevskis <jdanisevskis@aurora.tech>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Matthew Garrett <mjg59@srcf.ucam.org>,
 Matthew Garrett <mgarrett@aurora.tech>, u-boot@lists.denx.de
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

Hi Janis

On Wed, 11 Dec 2024 at 19:50, Janis Danisevskis
<jdanisevskis@aurora.tech> wrote:
>
> Hi everyone,
>
> Good catch finding this leak. Would you like me to provide an updated pat=
ch?

There's a confusion here let me try to explain. I generally think the
patchset is useful and I'd like us to pull it. But we had some review
comments, Simon pulled the patch in his own private tree but it's not
in U-Boot -master or -next -- apologies for any confusion.

If you can go through the comments and let us know, I can work with
you to fix the remaining issues.

Thanks!
/Ilias
> I am good either way. Let Simon take credit for the fix on the git histor=
y. I can live with
> shame :-).

We all have our special moments of shame, it's a public ML :)


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
