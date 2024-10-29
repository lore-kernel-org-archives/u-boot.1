Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12A5D7494E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CB6891B6;
	Wed, 30 Oct 2024 00:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="atP1abnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B387F891B8; Wed, 30 Oct 2024 00:53:19 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADCF891A3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbce8d830dso39016816d6.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730245996; x=1730850796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+gs02xBNhdp77j/1FtZIA8fz3Tzoz9cp88dPICJTn70=;
 b=atP1abnqqyUoShD28rub9pMtqqhGnazICYjPn8fo0/fqDuJOaLRuUna2mCFo4vh1x2
 cWKflc4cbCtXTH5BzRh0uYorme39T/oe/plm3k+BFogRZYpbIRIx7u63d76QWaIJi/tW
 6bikfVpjuCh0OFvBh3DHeYoOkBfpJxcb5S0nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730245996; x=1730850796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gs02xBNhdp77j/1FtZIA8fz3Tzoz9cp88dPICJTn70=;
 b=n0SQdWCJlM/qzWSC+gWlEi+PaHPqNbY8f5Uh6kvFppIM83i0pUjtYHb0Eg7uJ4crQX
 MQif/Fw+2obrDeJnb/wprAboFRaBqS6wlGxELUKFfkmxCtdbrgZLa129kGHAQOMJ7j2T
 BtABPizIkg6eaJ7iWdKYYwZN3X4wHYAh+TIvejy57R2Ujx7OEdf771hioq8UI76J0144
 VdM9SyYWrvMAwuKM69fElKMdW58jRiriNSTWfCabARRe315Npv7+YZBkMkR1FnJqEzFc
 eSVlA7NMXnEkXWp3B5bHF2YHU9NbLxD306VhNH2GMAOQSqQipfxY1dLSZYuXAPWHQz5s
 q7SA==
X-Gm-Message-State: AOJu0YzTqYKS4dO3Rt3tu7wov1lynWDifDqv7BHXrwTlVWjWeMPmblHW
 +Qeex19Zu0a0yy4UHUJq5MW5gEeeheyZ7ssKt2jNoyGQlgJa3W6RmbavoHQbElbMW8bsucfCFiz
 pFOc=
X-Google-Smtp-Source: AGHT+IEq4k0gk+hwd2tZE5i3mJTT5uojSAX/ck9zyWKmUPWL/uTgwURqEJinHNyaXjUB6SbjMZafkw==
X-Received: by 2002:a05:6214:5c45:b0:6cb:832e:9267 with SMTP id
 6a1803df08f44-6d18568dcd8mr177692006d6.7.1730245996499; 
 Tue, 29 Oct 2024 16:53:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991329bsm46772466d6.58.2024.10.29.16.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:15 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 04/11] test: Introduce the concept of a role
Message-ID: <20241029235313.GE2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8sSh+vx0rTgFat53"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-5-sjg@chromium.org>
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


--8sSh+vx0rTgFat53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:38PM -0600, Simon Glass wrote:

> In Labgrid there is the concept of a 'role', which is similar to the
> U-Boot board ID in U-Boot's pytest subsystem.
>=20
> The role indicates both the target and information about the U-Boot
> build to use. It can also provide any amount of other configuration.
> The information is obtained using the 'labgrid-client query' operation.
>=20
> Make use of this in tests, so that only the role is required in gitlab
> and other situations. The board type and other things can be queried
> as needed.
>=20
> Use a new 'u-boot-test-getrole' script to obtain the requested
> information.
>=20
> With this it is possible to run lab tests in gitlab with just a single
> 'ROLE' variable for each board.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Aside from the "look ma, only one conf file" trick, I still do not see how
this differs from the typical board/id system we use today. One can
easily make N symlinks to the generic conf file.

--=20
Tom

--8sSh+vx0rTgFat53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdWkACgkQFHw5/5Y0
tyxaQQv9EBku5vduq+Lvh1dRRYHp+O8+iPY629t8PXVtM9prP5TEGl94AD+0z9+z
xobSGlcFBfjULSopm2FEqJT24lmYW1GNrenQu7FGYDCGLqm2Ll5ggEYt2dMQuak1
vpMQmJmPOzw2HgpD0RM1v+CfsDgGKdBh0CTcG1ev1UvfUbJglR3lBWJbcdBeKA3J
00/GWfUjZox8Wb1nAcRPiH6KCuB9pQVYiRuDL5CrHoPspy5R/mGSEND3lJy2SKEp
UYJy/oLEBBDuMJGCreewaFnRglAr4VXzQabpFoUvKfK9xhzYnVLhj4efWM/fJJuy
8xb5AyVvW0lkGFKCEYDtMjiBAoNhqnG2teQP8j1p5aYsNhJXQz0Jc/wK6T52kMhu
eyAQDvUmlFQxMF4eJYK1z0X8nXCmDdft2WBctfYSFKgcmbRbsCek/IDUIid9b4Us
Y/pFKf04nVYhaJzTT+O1ttrLl2XLIhLpzEiVnaKmGNIRPLV0xrco5xJ97EFxX+Ye
TskTLHtI
=36EN
-----END PGP SIGNATURE-----

--8sSh+vx0rTgFat53--
