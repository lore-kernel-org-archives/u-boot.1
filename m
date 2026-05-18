Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECF3CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0B4846AE;
	Tue, 19 May 2026 00:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TThlXp0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600B9846C6; Tue, 19 May 2026 00:50:27 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EB78469F
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e4de538f83so1709916a34.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779144624; x=1779749424; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dWazLwTeXdG6RpbKlK31ucLk1ZBQ8Z3hXtFQ7UXTBWY=;
 b=TThlXp0W9Vrl8i+SrjKxEYxBTjD4+TUI3iPHjPxKDGhYncNlg0Dg1WgTeVw3GjroYn
 kZXWyKK++yD0fLbQihxXVe+Aytt7DwP5TMG4jxIXbaHwxCh8CAC4bYQLm46sj+MXlxRX
 RzsgBFvtWuIqzbZqe01c40ttH/T9fa0byWNIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779144624; x=1779749424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWazLwTeXdG6RpbKlK31ucLk1ZBQ8Z3hXtFQ7UXTBWY=;
 b=U9t0l1qCPL/W89t0B8km40s5t5BUYUB9rLD9aZIRm5EpUX8IKBYsa3ilGYdNLPdUFO
 tkLguxUUyn9JogshM85j+AFDy3ngH8MO1d0QSRz/CSxTAgmhnRHRIuzE5ORg9yiso/jt
 BJGaHfjdPZZ2lLyxPuX7E/UfxoUrlnuNU3W2FcX4I6fsKU7ZyPRnMR9l9qjAJJBWyBXU
 Oag+fIX/W9/bTvXoIR6oYKgyb35++ajl1WU6lpZFhWA8IuGzOK/4wBGoFFA1kftHZRwy
 g7kGDpRmcyKly3cfNnu7AYQKzwMK684lW/WbpJKzg1XwGr+deZ1x7+EetFx+V44DTofX
 dbqw==
X-Gm-Message-State: AOJu0YxFjsoUa1VGS+/NPvl3DwW0o5ztmV2iGNIVnGbq5uePAHejZhG0
 HtQ5dkEXkDK0LbHRqwtjEGBYb0aFwbMJ9d1fQ/kvmwV77H+WiddtOMWyIXHC/Ppilrs=
X-Gm-Gg: Acq92OE8MSitsL7jAlYjROfT9bXSnPlEXsaMc0UoPco6/w04NEzXOOzqt/R3taPtMoP
 u/ZrlIQZDbYkKd9B7Hdk73948GjiFU34tK033MU8v8Lbo3fVF37bQL4i1zFsfTj1v5d+BHDKZb2
 1CU09OXtspK3iIFxp+htQ2ZNXeBxda4FDBfrw+sy1spp0JY+nFmnUTWCDowmxBepij/QKAnxP4W
 PeZrtxaw0uHH5UUOEBdVOPVOn2CLwBrtdOQRNAcIPIRB//CNuE29dhVD+2XyDU0V9kxkQ5+TM45
 sQNTKom3REvQKHDHOx9Vv5Hu5Ru+G4v1po0XnzixDbZt+5rMJ7vEcKPucpjP58GMZaU1Y960GqZ
 boagmB43w1bMxAV9RchzT2PwxV3mk0GQq4p1jPC5QlwTBd3Vi/jfGyiDi2OwzhDTGNkGivDnHxP
 D+3U5qaMhiS+uYCCvYNJOcb9COnAgmdjNZ4DFurfHh/YqhCqav/GwAKvLZ4k4JItfdmEX8B2G2r
 sapgTqUUv8sWlc7e/Uv8HbYCVFOc9TQ4gExLG8teeFBd/O3wew=
X-Received: by 2002:a05:6830:6689:b0:7dc:d0e3:5bdd with SMTP id
 46e09a7af769-7e4f2ba16d0mr11262338a34.19.1779144623905; 
 Mon, 18 May 2026 15:50:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bbd0be3sm8663989a34.15.2026.05.18.15.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:50:23 -0700 (PDT)
Date: Mon, 18 May 2026 16:50:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
 Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Adam Lackorzynski <adam@l4re.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] virtio: Staticize and constify driver ops
Message-ID: <20260518225021.GA482288@bill-the-cat>
References: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QMlbX5J712IusnRq"
Content-Disposition: inline
In-Reply-To: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
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


--QMlbX5J712IusnRq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 07:17:53PM +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Christian P=F6tzsch" <christian.poetzsch@kernkonzept.com>
> Cc: Adam Lackorzynski <adam@l4re.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/virtio/virtio-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclas=
s.c
> index c36e9e9b3a7..6e4a3d7a7c1 100644
> --- a/drivers/virtio/virtio-uclass.c
> +++ b/drivers/virtio/virtio-uclass.c
> @@ -400,7 +400,7 @@ UCLASS_DRIVER(virtio) =3D {
>  	.per_device_auto	=3D sizeof(struct virtio_dev_priv),
>  };
> =20
> -struct bootdev_ops virtio_bootdev_ops =3D {
> +static const struct bootdev_ops virtio_bootdev_ops =3D {
>  };
> =20
>  static const struct udevice_id virtio_bootdev_ids[] =3D {

So, this shows off a problem that needs to be handled differently. In
boot/bootdev-uclass.c we can't have ops be null. And moving this to
static const leads to size growth due to the compiler no longer being
able to play some game that it used to do. I'll post a patch shortly
that reworks the function in boot/bootdev-uclass.c and then drops these
empty structs.

--=20
Tom

--QMlbX5J712IusnRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaguXpQAKCRAr4qD1Cr/k
CjaHAQDZYYKhiNhAkOPwgQT3gFOC5dqG0GRvC03/Ov+WCkvHMgEAjJ8T7fCB9x01
TLYRhWo7EQxc9mbPvsi9rl/2Y3kkGQw=
=OP0g
-----END PGP SIGNATURE-----

--QMlbX5J712IusnRq--
