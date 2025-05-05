Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F5C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 18:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0541582161;
	Mon,  5 May 2025 20:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G95MqSJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F8E82163; Mon,  5 May 2025 20:09:26 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348E38215B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 20:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so3739172fac.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746468563; x=1747073363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wOyzOPGVI9FDKNsgsXYbFFgqUvS8TUw8sgSjSph0QVk=;
 b=G95MqSJ3gul0a1b0FxkpZDGxk5GxgcbWJH27mhrnLkKGCWiSN07TM7wzIs7xccZGVh
 3Pp9VA22bwdc0TEFUdaIDGWEwERSi4n484L0ZWBqVm5tNqQPO7ogeuHUwsnHg7FYdNBG
 VU+f34v78pc6nOottp/B97UxWr0FkGOjW8aGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746468563; x=1747073363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOyzOPGVI9FDKNsgsXYbFFgqUvS8TUw8sgSjSph0QVk=;
 b=KH9n2DY0Q98UZ4OHEEfw2ZvgfOZoDBtco2tmj+8IgcuzS1WQ5lq4bn/GSlyEdp8lOS
 fLSxpRl8C7x50evowOYaDJEgFNnMAOf8AUB2fQt3K6nQeL1ZiTTX5e3HBbLym++4ECXA
 TU6I1sAT44eMVx+7OX4ouybogjv+2nDOxJ+a2UHzCGgoqkogdygPIsgaS86FeMm8qTiv
 z/CB7Fe9J7koFKZ8nIGuHf6LJFqF6D77xbtutKCXe/iEkZZ+4m7XQ+mend0NTgux5sVu
 oZG8VObomU6eeyy4PCjRERD/Qh043VJDnSsJMuNifvORilAP1sMNVtKc08Ohk86btuJZ
 4wYA==
X-Gm-Message-State: AOJu0YyOdr49hq27jMXvJMlUngpDeW/LFJs5Gn7gWK1CUE406T4y4mZv
 hoILy6dNUyNFwxz+R0hRmBcI379F1/wxIIevP2StSnvWn2p4B0i+eJrXEnpyKok=
X-Gm-Gg: ASbGncv2mxvEqSjtQQHvX2k4FBrKzltmr1gKnJDxprSXYKGPbIbJrRuRmUCSM9KZ/iJ
 uhzzA1uzJgmc4nrXRHV1yCK9VooAeZ/4RNEqOQD2g9tnYXitst5MqCDFKJU2KEV4FnCiIBuLIDU
 eot7zxJ1A/bf5+MAJLmUAli/duxhmR9rd9IRpT00W8iT3UxvTQMYV9SauhZBnTKLlm7ksHj73KC
 MxTlsYeWFD4G4O956lanSbsCuALANMmuOY3blTH9b3tfmTV3UdhsbghVjv2IRBa6rtgXLw8qV67
 isK8+3lOR0tub38kfVysry0OyML+gM3Puo9DxztXrcwS1iyI2AvIKCJQc3fC7bCUckx6q3mw2DV
 DxQ==
X-Google-Smtp-Source: AGHT+IF0UifdfHBq+Ht1D45bzUm2+uzzaZmKIAy4AQz1Dv98O4vgASSIaW6bOxv5i92wsXLrNd3Cpw==
X-Received: by 2002:a05:6871:2b06:b0:2c1:4827:c0e1 with SMTP id
 586e51a60fabf-2db385c1c9emr296144fac.17.1746468562814; 
 Mon, 05 May 2025 11:09:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0f6d9aesm2122670fac.21.2025.05.05.11.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 11:09:21 -0700 (PDT)
Date: Mon, 5 May 2025 12:09:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250505180916.GH5430@bill-the-cat>
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
 <CAFLszTiPKbz20+=Du4L7fq442dO2QUh+wV7qH3z5FZy0mNZNmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZoS4a2J02AWkZISu"
Content-Disposition: inline
In-Reply-To: <CAFLszTiPKbz20+=Du4L7fq442dO2QUh+wV7qH3z5FZy0mNZNmg@mail.gmail.com>
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


--ZoS4a2J02AWkZISu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:10:33PM -0600, Simon Glass wrote:
> Hi Eric,
>=20
> On Fri, 2 May 2025 at 14:06, Eric Schikschneit
> <eric.schikschneit@novatechautomation.com> wrote:
> >
> > This will allow arch(s) that use device tree blobs to pad the end of the
> > device tree so they can be modified by board files at run time. This wi=
ll
> > help prevent errors such as FDT_ERR_NOSPACE from occuring.
> >
> > Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.=
com>
> > ---
> >  arch/Kconfig                 | 11 +++++++++++
> >  arch/arc/dts/Makefile        |  6 +++++-
> >  arch/arm/dts/Makefile        |  4 ++++
> >  arch/m68k/dts/Makefile       |  6 +++++-
> >  arch/microblaze/dts/Makefile |  6 +++++-
> >  arch/nios2/dts/Makefile      |  6 +++++-
> >  arch/powerpc/dts/Makefile    |  4 ++++
> >  arch/riscv/dts/Makefile      |  6 +++++-
> >  arch/sandbox/dts/Makefile    |  6 +++++-
> >  arch/x86/dts/Makefile        |  8 +++++++-
> >  10 files changed, 56 insertions(+), 7 deletions(-)
> >
>=20
> This is not a board-specific feature. You could try this:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20241206131113.2865416-3=
-sjg@chromium.org/

Simon, can you please read your links before sending them to other
people? There's several things wrong with that patch so suggesting
someone else try it and see is not helpful.

Eric, for your platform can you expand the value used by SYS_FDT_PAD or
is that not updating things in the correct spot for your use case?

--=20
Tom

--ZoS4a2J02AWkZISu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgY/sgACgkQFHw5/5Y0
tywMfwwAuT8W6+4amu4VAnCmaSiRzdUpl0WpvarjGV4qTRnsxbPn7xJUV/Ypxnuc
dvT8JcoyUO/p8Y2IZ7Oix6LcTOYONQVXep8ZJNvfuHHvVPMAwJ5vT9cwdVNuE9/P
1q5/TMrVetSGNPnZuLmq0OX8kFX7HUsw1DfNcHy+og8NHInI3JbN485Vb+q7LnnF
LTEjrdueu1bmoCD5SYS7lgzJ1LX33PnPF6MMzgxIy618OYy/hBC8CA+HWf2dOne7
XAPhLX4uTOQnXK+r7xq8uGMLpan52yfnflACn/4IwqHqldWZqmYCjj9z58ZCYhDr
q4vPnEhFapfanq5bUOs96C76fnaBTLPiZKfGameUty2cbWJySt4+ghcgkCKDNy/T
uEBXjNsWoM3gvh+g6JwwUxypwCIDxaM+nmpcflZ75H1CQHzEuVAKu8IyjHWDg6ia
p30TkvUc3roHfXh7N8uDURjL131yxFQWxpDDJcYXTNpOBm0hzOo+oDte2kT1fPjE
5NFYOIz/
=3Y8g
-----END PGP SIGNATURE-----

--ZoS4a2J02AWkZISu--
