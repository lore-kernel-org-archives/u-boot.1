Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C5C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 21:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34C1A886E5;
	Wed, 28 Aug 2024 23:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j/nzyWQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C5386E61; Wed, 28 Aug 2024 23:33:52 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69648885C5
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 23:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a1e2ac1ee5so471410685a.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724880829; x=1725485629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XuY2xytayUcnU/cU61zjy2ru5fiW0/3IOCR0ac+vBgs=;
 b=j/nzyWQ4KUFufmnT6C5xsIyF/pLA06a45SNIXfpmQYf+1ymQ60yahFEmzCOgUd5ffI
 q9127fNJyDb3HH7jCkib7YyaODiiesKPom9so6LmKG2lB1VbI93AnBDo0/Pqn3MPczJh
 xKguC2yd44K7a9xoas8V+ffdll6UtJAqDEmjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724880829; x=1725485629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuY2xytayUcnU/cU61zjy2ru5fiW0/3IOCR0ac+vBgs=;
 b=pDece8x7T9gicZZf2eHsTu1bwHwboP4CKsTnedsgUiD1Ouyc3uuPqfIzs1fMa5Xk80
 C2e1NppcE9znlq8Pu4i84NYqHhuVdyRGg/0g6sjfHsh350vZLztVZ3dLms2OZoqvxtUM
 GPKBKDArCup0ce+UHVAQDLMidOLf3lwgif/0aXTpqSW/2fPAfcJl91YwAcY/ClYjVa6Y
 D84dz46MckRRIvQHscenB9tWpzBpGoeMyfc8qq5NRR0dWTT++Dojxly0fYHH81KwetK8
 4U1mquSNl1dqhR3F/iu5nyoU7X4V1spsAmugKWDodzIPck8T+EbkkPSNCFGat3vLivj6
 m/EQ==
X-Gm-Message-State: AOJu0YyARlhaMY55ibo2Qt7dEntkQT271Fbh4odrBPaeGqaekjKf7ZHJ
 s5tOipKjvWvzgACL5FV34g7wQNaoV7jJSk4zd1hR9yRWLcMlcjkbfWfzVsvzeaM94tHHWrr9hFY
 MMRY=
X-Google-Smtp-Source: AGHT+IFS4SJ9c0gWgnYKEZubqIdEErM1BWoudCb4jwVXcTSBoJHuoGY/m3dzENvxLBoISKgEaMCwDQ==
X-Received: by 2002:a05:620a:4511:b0:7a2:32e:3c41 with SMTP id
 af79cd13be357-7a80427841bmr78998585a.60.1724880829062; 
 Wed, 28 Aug 2024 14:33:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a7fee1fc70sm47538785a.71.2024.08.28.14.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 14:33:48 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:33:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240828213345.GW2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <20240828201912.GV2479150@bill-the-cat>
 <CAFLszTjzH9kiM3SEzfjfhCWMCMnLLeBy1UipH9kW0-z3s-1xxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wY6dXHhOQPtk2fEp"
Content-Disposition: inline
In-Reply-To: <CAFLszTjzH9kiM3SEzfjfhCWMCMnLLeBy1UipH9kW0-z3s-1xxA@mail.gmail.com>
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


--wY6dXHhOQPtk2fEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 03:25:00PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 Aug 2024 at 14:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 10:45:23AM -0600, Simon Glass wrote:
> >
> > > With Labgrid we don't need to specify the various methods, except for
> > > the console, which simply calls labgrid-client.
> > >
> > > This allows supporting any boards in your lab, without adding per-boa=
rd
> > > configuration to these hooks.
> > >
> > > Provide ellesmere files as an example.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > I think maybe we call this version "labgrid-buildman" and make sure the
> > documentation emphasizes using buildman to provide U-Boot. This will
> > make it easier for me to provide a follow-up of say "labgrid-external"
> > that requires the binary to be provided, similar to our other hooks.
>=20
> It can be used in this way. The 'ub-pyt -B' does a bootstrap of the
> board without doing a build, if that helps to show the path through
> the code.
>=20
> If you don't pass --build to test.py then it won't do a build.
>=20
> If you like, you can pass --build-dir (and with the testb series
> --build-dir-extra) as you do now. The binary will be written to the
> board as is.

Right, but this gets back to what I'm most confused about (and need to
talk with Kevin Hillman about maybe, but I missed my last meeting where
he was as well), you have a bunch of logic for integration of buildman
too, and I have a few wrappers around exiting labgrid-client commands.
And I don't know what direction upstream is going to want to take.

--=20
Tom

--wY6dXHhOQPtk2fEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbPl7IACgkQFHw5/5Y0
tyyMCAwAuEGrfRKpqUl2JkaaomIzYELkea2E+BcJa2QMbSHl0EFxLjPYmrUh49TR
+TWp65oB6mktpRQbRF+yYa/Y5vCzyz8MbBnDkrQbwhau7BtHsSQ9PuvxJccSN+hd
e8PSUDVLfHV7XwHn+yZd4B/cAEoasYXZjb7E5cMedJKN6tvb4X2Xvo0rXk6H9Isw
xoxNdTYeHQtjo1V9togA4OrBI7Wj/oyO6VS9BMoF0DaWU7U1W7OU6xhgDex4bhTw
IV0dm86oBIOPB/ew1H3BT/uYySW2IqbPAyu35EcBGwv4yGL/qxEAyNR3CVyg1HaY
nDSWkKn1z2EmlcelWU0cY3sYvoiOKtu7UFJxjYJrGm5uinBxlKl6MiUuQ9zkeYzB
+ACYJN+HxyBfRJgGpPU4o3ofYFYQApYgnD7ZieRTFEszeinErA/aebwisfDXIeNI
zMhAyDaQzcXuF85qE5paTPnPEB3MROr4n/YY5E7fYgQCWYKZ5C+K8NXWCRL1xgF1
kzF1nyMt
=gZ7P
-----END PGP SIGNATURE-----

--wY6dXHhOQPtk2fEp--
