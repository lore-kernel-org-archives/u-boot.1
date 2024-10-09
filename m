Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB69ACF0430
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 02:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1528900A;
	Wed,  9 Oct 2024 04:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSFDT+4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276DE8900A; Wed,  9 Oct 2024 04:10:05 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB76689040
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 04:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbcc2bd80fso697126d6.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728439801; x=1729044601; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IHKWHWtUBhLTtPbTbiIFskxjZP2O38auuKkfOYQJ3Qw=;
 b=sSFDT+4aDU0UXZt/fPdlcxZCUWNekRS8rCXnzZTBN5xHyJK55r+fFH/LYkGvklifCm
 6e4n9A6pwkZTYVQt4KudFBPKWNZjOCI+++NrjQRkQtrpEdtLQE8TVhq2E8Z4tjAfsXY6
 c17ulGxY5NpV0xvyp+htoliNrRM+3o1Qq1t9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439801; x=1729044601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHKWHWtUBhLTtPbTbiIFskxjZP2O38auuKkfOYQJ3Qw=;
 b=sb0qgOPNHYe7MKXJgrX8mYI2yfR8qDFR0v7idcVQ5bvEz8YtlBH2kCn57Wunz97eXA
 MzquB4KKHzl9z/QftjjjBc+ZI+mMNv6MZm4pZ9TCDhSTZiOj1GwkrHon+YeYxNgselt0
 3YDJZ2g/sZeS7Dw0p+N+4AOTV9OmJvn2K6d1Mu9pzefCKbzJQFaZBU3x/Ua4bQ15yX5y
 jp+SdWlfaUegpREadlz591Zzsex4hqSIgLdJnkxmXHIIOo3WlLdB36ysz6ORZotuJMl2
 cXYxoVrVIpSRTPyAMRC1tJUAnxLIS5xxtBAtlqO3djxUC9KDbaJCCOyn49iC+N3uS322
 TscA==
X-Gm-Message-State: AOJu0YyQHtX6uakbjJvbTPG/OrXJMxG51A3hy1gdar54R6NPWCJGu9fP
 ENw6mqU967CptFlbh3140fHHwykC00LoMoESu/nP6DZaroJ7qYfk0MPFtlMhecA=
X-Google-Smtp-Source: AGHT+IEjPq4GpY2ne4CRmcoQqkz9wrEyMmNmXzHl9r3vnwqMfj5Nn16fRSKHmMPdUovEoQaeuQ99yg==
X-Received: by 2002:a05:6214:4699:b0:6cb:3c3a:69b9 with SMTP id
 6a1803df08f44-6cbc955e719mr18374396d6.38.1728439800891; 
 Tue, 08 Oct 2024 19:10:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbbc88d927sm12055296d6.12.2024.10.08.19.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 19:09:59 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:09:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH] cmd: Make bootvx independent of bootelf
Message-ID: <20241009020957.GH14210@bill-the-cat>
References: <20240929092739.2513768-1-daniel@0x0f.com>
 <172839506989.112860.11166419458122902632.b4-ty@konsulko.com>
 <CAFLszTiY7=hcg=5t6w0RfXs=C3NUMQXJkVs8PZyE281NTK_D3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yroSlIWUz+Z6qf54"
Content-Disposition: inline
In-Reply-To: <CAFLszTiY7=hcg=5t6w0RfXs=C3NUMQXJkVs8PZyE281NTK_D3A@mail.gmail.com>
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


--yroSlIWUz+Z6qf54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 07:57:25PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Tue, 8 Oct 2024 at 07:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, 29 Sep 2024 18:27:39 +0900, Daniel Palmer wrote:
> >
> > > There are lots of usecases for running baremetal ELF
> > > binaries via bootelf but if you enable bootelf you
> > > get bootvx as well and you probably don't want or need
> > > it.
> > >
> > > Hide bootvx behind it's own configuration option.
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
>=20
> It looks like my review here was missed?

I guess you sent it in between when I b4'd it and then pushed it.

--=20
Tom

--yroSlIWUz+Z6qf54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcF5fUACgkQFHw5/5Y0
tyy8IAwAjnn5Kk48U/c2R9xdDtTyFJkCeUUZGy6UdS1AzSzKg49h9LoE9WVQt+pT
C4Ow6W5pYWXRKorrmordom6X3vu1W0yOQlsmtOIHmEOrB8cUGE9i36K1auXZASMW
SNzzU0C+YdB7j1Dzfho2XZQi5mxD9uXImyLrTtY3DFWsuZBqOFQg7rgMwE+4My4u
hW7fWOGvOLwLrY6EC76/dSsVVkOel+7G0uwuUOh+dOXFeg29nZf5cHCL5G4rM6pp
aKX7ZTb704ihGtV2gx65j/jaTvcrbMITR9WMvPGcUQ4fxFSrncgmRVADfx4K3RPx
f0TWYsWHsqLfsiaUMYudG9OwcDX6CF8MyRnTmiWkzWYXOf0N0kITsXbzlxEaF52H
QjnKzcdgGbfoN0xkXCuFLFcKhL6aOBqI7MVlVs3/J9VrMCmPbjEWpI7rQuDYvA7i
X3giHYwR6Gup+0FzeEcot1BIGhsRZ6zrS7AaW91c6P6TzX8jh5ZwUFsscWEYBnFp
fvuUBx0T
=XHUu
-----END PGP SIGNATURE-----

--yroSlIWUz+Z6qf54--
