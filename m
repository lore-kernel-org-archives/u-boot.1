Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45893C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBA4820EB;
	Fri,  2 May 2025 16:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bM/1USZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3757C8210D; Fri,  2 May 2025 16:34:06 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A9981F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-603f54a6cb5so1311758eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746196442; x=1746801242; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sTRZniJmucAVSfbv7DidE3JOWvHy5BYzkARpmsxYJuo=;
 b=bM/1USZAbGI/OCu6sliQpNFZISWSFITxEh2A0QGEGLItlxlYcnbXilhBQEjz5k/Q17
 28/Xx95ljhCyGDCnDKesKLxP14UaGy7hoCf/nwOXZLVWTrTG/UH5KjHvvHiz1nT0lLKd
 4UADd+ZljxwYCpLDYJ+vuN4OkDbWTTc4uJ8xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746196442; x=1746801242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTRZniJmucAVSfbv7DidE3JOWvHy5BYzkARpmsxYJuo=;
 b=vVPAu08ygAoh5JQJVF1uxAZvr0oOVq5zPPt8FmrzOTosaaH6qHq7lhllXNUw66RWUZ
 pE+BcKZ/nc0uPSR2YpdMm85Kh53zZ/NNAk+ig48XHw/zU81RHQTOH4PphhRHWxLtR3T6
 HbsnvHcH6+OMHvfWmmOeEcUfz1Hv1SuO2f+4D/+R5ieybDGfl6z+t8gkFnq93nfT8uCN
 vS07owXGlJLe9UXfCNJD9uFA0t8ej7PRGWvj4aOvGUdu/tl9QvYOjMC9ZmPhPbh2GQZF
 /+eoitbFoku7qJMUWQpfc1YB0V7KEnshM/ncPxwDjFiKiYLQoa1unbTWa2Lz9FGjRvYw
 k8UQ==
X-Gm-Message-State: AOJu0YzyLa9xCRzHLiLNvzpqeaWjCRpouAUbIJFN1RICnS0SXbRbo253
 GImGwoHGnV79bf6HM2hHCtC5GfZDOfNnyhSX/d9zegR52BvykCTPI+UP32dcMOQ=
X-Gm-Gg: ASbGncszwKED1JnT+nUSmBjLzGhdUe4a3mFdXS5nubUI7WvhMwV0P4XCH1HwKnGb1V/
 oQ0kLwtFPDX2ImjY5bTaQLPl5apmf+FdQVXeWnVasuHosRZbRy4yyfcgSQCaawizr2HtJDiGPme
 TFWyXqNS5xevFmfCKFewYKDeiM0oCZ3zVnHMPXq1j6TTGkcCuYofEWtZLaWNq8334dQHnM7wAHy
 ROl7DS5hxzHD05u4PzyhJVyNQGTy2HclfUXi3PwSa/6H5etq7JOgN6+Yg+iCdg7WSxh4KEAnMbR
 qW2/s4/LMhsHGIVhxJB/kLIFlm7btSHhW7T+uGiDZ31MVrb0W8/wdmMA5M4pf3lFQqN5z6UqKHH
 ge/CWaJu3eqXO
X-Google-Smtp-Source: AGHT+IEv8mKE8wzlj9tO3teqQJrOykodpBv9QirsoskXUcWiDvgsucn522k1r1/l0cxkVfyffBIxmA==
X-Received: by 2002:a05:6820:a0b:b0:606:8579:4c5e with SMTP id
 006d021491bc7-607ee6c3646mr1615610eaf.1.1746196442217; 
 Fri, 02 May 2025 07:34:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fb7786sm526475eaf.30.2025.05.02.07.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:34:01 -0700 (PDT)
Date: Fri, 2 May 2025 08:33:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250502143359.GS1261075@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FT53m9yphj0ywH95"
Content-Disposition: inline
In-Reply-To: <20250502025026.4140184-1-sjg@chromium.org>
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


--FT53m9yphj0ywH95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:

> During a recent discussion with Heinrich we discussed why the hooks are
> kept in a separate repo.
>=20
> The amount of code is small, a tenth of the size of the recently added
> lwip, just by way of example. Testing is a critical part of U-Boot and
> one of the things that distinguishes it from firmware projects that have
> not kept up in this area. By having the tests somewhere else, we are
> signalling that it is unusual, or difficult, or optional.
>=20
> The hooks mechanism also needs something of an update to take account of
> real boards in 2025. That will be much easier to undertake if the code
> that test/py talks to is in the same repo.
>=20
> This series brings the hook files in as first-class citizens of U-Boot.
>=20
> If we do go ahead with this, I will send a different series which has
> separate commits (with correct author) in the u-boot-test-hooks repo.

I think bringing more projects directly in to the repository is a bad
idea. Your example of lwip isn't applicable because it's a read-only
subtree that's maintained outside of the project (same as the dts
subtree). But sure, lets "Say Yes". That said, we still need to:
- Remove needless examples from the tree.
- Not include personal labs directly in the tree.

That last one is why I really think this is a bad idea. The point of
having the hooks standalone is so that any given lab can easily add
support for their lab and manage it, without worrying about disclosing
internal layout. There's going to be hard coded default passwords there.
There's going to be repository secrets there. That kind of information
really should not be in a public repository. Integrating the hooks with
mainline will make lab management harder, not easier. The point of the
existing labs in u-boot-test-hooks is to provide samples.

I think this is all why no, we should not go down this path.

--=20
Tom

--FT53m9yphj0ywH95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU19MACgkQFHw5/5Y0
tyy0qAv+NGuZ77g+7MEakqNQjsWU76ChnlgsWQPOnzhZwDJ5v4abmX+3crfKKEdi
yDXp87/NPY8HuGO4p61yewHdOHoF33qxUA6Pj8Xj/WciAEO0DnjZ4y7QjMUdeZwt
4QJH35MsPMPFDXfbB6YBs7T1/3nk1+NFqVIUdHPiA3ImT0/sTNHWSOGIERPs+6ym
aEvgFzeIKYpBNgVlHnzTRTammgZoh2x8Ul0jx5cPFVduU9odtkAJTd+1dNZ76HDa
eK60OITy2gRNU4EKsVlW6Ga31+3tc4TPOhFpdAObjXLoU3N/BFIZhL4DzX4dqm8O
wwMEgK+r67z7/8L1hwsSej7LviSjBz2hgHthTSDLJBnGa/a76STuy/Gp67b9Wp2q
1fb8xXbamW3GKCtNRjCY0zPyW9IP6DhYdMzAjHKh7rc1cwXxSs6QX0wsVt5Dcmvc
y+kR9ZsSL4RMWhko2gDfdLLXeBcvDDHLk7+g6vlqLO4dADXE/LzCwiXgIWR53XUz
znva6ul5
=Mali
-----END PGP SIGNATURE-----

--FT53m9yphj0ywH95--
