Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE0C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 20:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D8E87DEF;
	Mon, 19 Feb 2024 21:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o3mI46RP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF56687DEF; Mon, 19 Feb 2024 21:50:08 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A7B87F59
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-607bfa4c913so44499117b3.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708375791; x=1708980591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QAIzF8zkInCIafHm01SAypVJTKMewYcUv0uCZxVRHJQ=;
 b=o3mI46RP0sechph2qG2IHBYtbY4fSMaXp2QrMpuAQNIaDo7Ep/HdXYh3LxoVA78Bhf
 K9ellzD2QdvXM/6xnlibq2VAMTtTJKYWRa9n32rllrTsd8EGG89gvB/WT/S4ymL3vZgk
 onOg65bBaK7GcAO271/gb59F0l9eVsQPzCOkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708375791; x=1708980591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAIzF8zkInCIafHm01SAypVJTKMewYcUv0uCZxVRHJQ=;
 b=YHUBrjWjpn41HMHk67GlYrTjwUIMTTqMzc8RBz4ehvVsNaPFmjCe3q5XjIbMvQuBBf
 +X3t9g3i1xZ3af97CirolULiItLHfc7TSjRtZJFJubE2SO+7fx5Qn5zVX/2FkUcBi9ys
 EUr6KDpgVawC4PAcPpZu+F4cm42Z/d5njWU3uQPvW46JoGAIC9gFtbsqNsk6ITG9mnhK
 pMqlof/ninSD1LvYwOJZFS2soqaI3pgD+A93X39wH/wW4nRyE4HGuuIbi3F3dqrBBr/o
 UhkmwsfPUPCGMOY7v0EU+ds729+0uUqRhUUsuGCUC5uBbWVpYbTQ8qTP3o/cPSKZvi2Z
 rEJA==
X-Gm-Message-State: AOJu0YyoayqdHfFunofmi3XAga1HFyQjbZkt5+kNdQOZ+cGpt4mtg+y3
 tHb6/v7W7LPEwEyg3wGR50GmOEDR+7V8G8OHlQg5/VP04xXP6I/glzl47g0qhYo=
X-Google-Smtp-Source: AGHT+IHBe23aob7vr459vaEDMLfT7p3944ubVUF6rEm86wP+Ofw+HIQQD8VqIl321ZYBXd6x3v/wnA==
X-Received: by 2002:a05:690c:4442:b0:608:1b39:245a with SMTP id
 gq2-20020a05690c444200b006081b39245amr6445710ywb.1.1708375791495; 
 Mon, 19 Feb 2024 12:49:51 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 h123-20020a0dde81000000b006040d34e58csm1789169ywe.74.2024.02.19.12.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 12:49:50 -0800 (PST)
Date: Mon, 19 Feb 2024 15:49:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] virtio: fix get_config / set_config for legacy VirtIO
 targets
Message-ID: <20240219204949.GN3040305@bill-the-cat>
References: <20240212073708.4161197-1-dmitry.baryshkov@linaro.org>
 <CAA8EJppQQG0F+tR202ZLraG8x_CJ9ZH2jcm+ncs2eq=pX0D7Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1kOGEpVGCpHehYgH"
Content-Disposition: inline
In-Reply-To: <CAA8EJppQQG0F+tR202ZLraG8x_CJ9ZH2jcm+ncs2eq=pX0D7Mw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--1kOGEpVGCpHehYgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 10:09:12PM +0200, Dmitry Baryshkov wrote:
> On Mon, 12 Feb 2024 at 09:37, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > The functions virtio_pci_get_config() and virtio_pci_set_config() don't
> > take the offset into account when reading the config space. For example
> > this manifests when U-Boot tries to read the MAC address of the VirtIO
> > networking device. It reads 6 equa bytes instead of the proper addess.
> >
> > Fix those functions by taking the offset in the config space into
> > account.
> >
> > Fixes: 4135e10732a0 ("virtio: Add virtio over pci transport driver")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>=20
> Gracious ping
>=20
> > ---
> >  drivers/virtio/virtio_pci_legacy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio=
_pci_legacy.c
> > index cf5dfb17a94d..aa89604ae84d 100644
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> > @@ -107,7 +107,7 @@ static int virtio_pci_get_config(struct udevice *ud=
ev, unsigned int offset,
> >         int i;
> >
> >         for (i =3D 0; i < len; i++)
> > -               ptr[i] =3D ioread8(ioaddr + i);
> > +               ptr[i] =3D ioread8(ioaddr + offset + i);
> >
> >         return 0;
> >  }
> > @@ -121,7 +121,7 @@ static int virtio_pci_set_config(struct udevice *ud=
ev, unsigned int offset,
> >         int i;
> >
> >         for (i =3D 0; i < len; i++)
> > -               iowrite8(ptr[i], ioaddr + i);
> > +               iowrite8(ptr[i], ioaddr + offset + i);
> >
> >         return 0;
> >  }

I'll take this for -next when it opens.

--=20
Tom

--1kOGEpVGCpHehYgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXTvukACgkQFHw5/5Y0
tyxiywwAqw9NZqZm1qcWjgkWOEdyq59q+E9Tni2jKs1oKv1e69HEbgFXIkfUnHa0
ab8QHrLoQeEis1vwOvUjfmX59c64bbjx4HyaJybFBCGZ/0zjdV0k9h+uM+waCh4V
figH9hcvpsr9xzZj9dlkILWpsQpb6wDQ8IbdwW0K98VeM9BuIkdsaIvbaUOpputT
O/Xp7Pg8B0nqrznDzqJ0775ATLUbKU57+Rm3gMU0qJ2Ne5udqH6Wwl0u7yJV+HJc
EjS5tvMsG8YLMpUwKb3/GUlRyFgBlLAiFIhyqFNGE7K8s7pGgTkNREBMUBStzwTh
QSWzZhggU/M5SVFvcNNAo0/NywGITNIJxmXH6MC2BNXNmHfHnyh3Ddqq+vKuTQaO
LpPpaICUIvjCB7aSR8YLnT0YsUBAxr+ERQAJ7qRVI8T3TX/rjp4oSZyd5M9km7OY
cS1ZSs2HwVWIrakdZzM6bW79GI0gUbR2OpOzIwaJXoqgIyY0u5Xm3eJ32lY2nn/K
mFbqyRNm
=4eOV
-----END PGP SIGNATURE-----

--1kOGEpVGCpHehYgH--
