Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC0BC004C0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 811C4878CE;
	Mon, 23 Oct 2023 18:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s8UPmtx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9307087825; Mon, 23 Oct 2023 18:35:01 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF82878D1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7ad24b3aaso36511097b3.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698078898; x=1698683698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B5GHew0yanr7ywi4FFJ7hA+Of4XGlrzyKhr89ebYX+M=;
 b=s8UPmtx8hBbNEdq2YqhyN2BOPncsg6mBMXW3H7Y3/Upk4PijO3XD9ttA7uaUBCC/pX
 FOrg/vTtWvx9rsYQOzj8i2pU7+weTL56yzTFAma/smx9lYubnKa3ErJhhraYvy7c2Voc
 UqTxV0QA69fPDeBgUf8zAl3bzVXa7glL9/Ag8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698078898; x=1698683698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5GHew0yanr7ywi4FFJ7hA+Of4XGlrzyKhr89ebYX+M=;
 b=VBqJzQBRpjc7GUT1YsWkpYk1+wrMjDMntGZdP7ztw3Duw73YKf3zomZx+UN8VKGE3O
 Vzit7Arrq3yq8l84m/mY78W0GT7cqo+k2e0YkooIYrqliBzmnVEZl5dREih7Xc8SpYa1
 Uq1Ey2pXrIrc3TfhjLu41q6L0DpOw7HBHNn6r5QDRuDs7o2Y06SGdcoSgAohQ0GuklrT
 LwKewiyVBSe7Il5vDf7EOL1LaoHbJ8BFiaVXFX5F8X74IC5IZjMIS2SckI/Nw1W8km9R
 c28Z11+CajzYvAtaJBy02mMx1ENElq3aKCu3ZIlaN+1aDwtZ0Za3OHFP0R/O1YYDMISh
 TK4g==
X-Gm-Message-State: AOJu0Yy/+dPn/vLf2LjgN6pX0fluWGIrPE0T3e1+uCFA/7aiIzWda+S1
 j4paHr93MuCNdezWCrbOJy/tJQ==
X-Google-Smtp-Source: AGHT+IEejQ3fwvCzMtQJ3qxjgaesmARfWuUaAr47tcn3I4y0FcH7unkzBmarf/43ZraIVEcig7GJjg==
X-Received: by 2002:a25:9189:0:b0:d9a:bfe4:d827 with SMTP id
 w9-20020a259189000000b00d9abfe4d827mr8951742ybl.19.1698078897966; 
 Mon, 23 Oct 2023 09:34:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 w31-20020a25ac1f000000b00d9ab86bdaffsm2860091ybi.12.2023.10.23.09.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:34:57 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:34:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@google.com>, heinrich.schuchardt@canonical.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, dianders@google.com
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231023163455.GL496310@bill-the-cat>
References: <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Prwsa/wlK6M1epHx"
Content-Disposition: inline
In-Reply-To: <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
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


--Prwsa/wlK6M1epHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:37:34PM +0200, Mark Kettenis wrote:
> > From: Simon Glass <sjg@google.com>
> > Date: Mon, 23 Oct 2023 00:08:40 -0700
> >=20
> > > > fdt_node_check_compatible() does most of the work...then you need to
> > > > check which FDT has the most specific match (i.e. latest in the str=
ing
> > > > list). That handles things like board revisions, variants, etc.
> > > >
> > > > My concern is about adding a feature when there is already a defined
> > > > spec and mechanism for this to work. What happens when we load the
> > > > file and the compatible is wrong?
> > > >
> > > > At best, I see the filename as a hint.
> > > >
> > > > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > > > shipped in FIT on ARM?]
> > >
> > > FIT is U-Boot specific. For Linux distributions it is easier to use a
> > > firmware agnostic method of booting.
> >=20
> > I'd like to suggest that distros use both. Then U-Boot can work as it
> > was designed and we can avoid these work-arounds.
> >=20
> > FIT is actually implemented in various other bootloaders. In fact
> > perhaps grub is the only one that doesn't? I can't think of any
> > others.
>=20
> Simon, please stop pushing this.  OpenBSD's bootloader does not
> support FIT and we have no interest in supporting it.  Our users
> expect to be able to just copy a new kernel in place and use it and
> our OS upgrade procedure depends on this as well.  And this is
> incompatble with FIT.  I've explained this about a dozen times to you
> now.

In the context of this thread, genuinely, how will OpenBSD (and the rest
of the BSD families) operate? I agree U-Boot doesn't want to have to
know all of the UFSes, so that means the SCT will be populated either by
the DT passed to U-Boot, or the DT we were built with. Is it that since
the next stage is an EFI app, it will check that variable and use that
hint?

--=20
Tom

--Prwsa/wlK6M1epHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2oKwACgkQFHw5/5Y0
tywQWwv9GAeGAU79cTKOFCPsvIQm2L4Gjy+GabgudbfOzK7wMI+RMYecIS/+g4+x
l6Pry6UpdY5rzngkHTrxl1ZlL6wQnRN7zPQCqbZHNqHSuqqy2HZvDv8T+zI8WSfe
OjeaK1aq1eyk0kd+Q3ZgM4UczNRTRaeWnkZQEQ6FBbuOSHjwoayq7jnDm7B85lbn
uIqDWnnSIpyMwoO9/TAorWUokpw0JKRKtNkqcUFLWkGc+Zc2+piMuAk0hDxpjjYP
XBt6vnlF0N4LZhucmVqHeXKzRO3R9+omEJwCBgeQRzIJW0RFpRTlrYmUXymhfs30
hIQkVrdbpb24A8qARJhHCBOzm2z19CE+zGrl2FvqIpKQ19V8IUMyDMb0B59Q+Q6c
+BXUGn67GYQGD0JI1hMxU9xOPKs/BvY2aVXQm77wX2Ym+Axj2uTQvgzypCVh2Etp
0lkFwpoolCE/56hnXBk/w1cLsHIyY7psATiaZtdi/SVyPDPliwtWdK4jlLn6XVrp
4XT6OIeR
=5LlD
-----END PGP SIGNATURE-----

--Prwsa/wlK6M1epHx--
