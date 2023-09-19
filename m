Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C17CD5BD3
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F8F86908;
	Tue, 19 Sep 2023 17:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RQCrojWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52F986517; Tue, 19 Sep 2023 17:15:03 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9441886AAD
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59be9a09c23so58298237b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136499; x=1695741299; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rF9aXQqJXF4UQksOocxwRmPV/dUG+C4cN3UZOkgOE4E=;
 b=RQCrojWgjDVGvvERNZpGIUojbjwluC0bdskBZGbfUlO0/I3S1j/vrJrm4q7yPL6khY
 Y30mSqXo29KewriRW6tj0LKmDuMV68OSaWKICWb6Galjl7MQOPVjhTGZ7X6qED5o5APp
 vYHrIPlc3LStKGzAcH5cQ97Z7lJUDgzrxD6H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136499; x=1695741299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF9aXQqJXF4UQksOocxwRmPV/dUG+C4cN3UZOkgOE4E=;
 b=PBa72kXNJoY0LYVYDqI06k73dQgOsYo7HqmhCyx6rOFJeQ9tQbFcMbs+gbMHrrP4LK
 4ybBejBn5CJUrhyZ/i8WWuwXp8QbSMUTt+u29MadfY3X3pgGPk7sWd2BdKoNPvlZN3Zs
 ZPMRidvU7IO9jtG7Su6DNS4LAtc6C8Hy00f3B4zQXzd2kYVigWhAWde6dWCUcFsF0Jgv
 5fGJD8hfjV7DRXgK4/0IFTM01xHS3djee0cSIxSKQJKwGg6DOh/GGVmQf2OjgWeLh1Qe
 L2dk+cAH7u0XXkoEy9Rhii+8bGiaDdg/Lp504MpS3Q5SObvRHYudqJdJHhM1QBpfy0Ji
 OJQg==
X-Gm-Message-State: AOJu0YzBeMQgVrBvRfl3rUEVxIP/ls3bXOBM+Ng5qXiK0wvGDnImOLmt
 0rpshe7F7FeQQu2CNbXlvwhJXg==
X-Google-Smtp-Source: AGHT+IFKAZSNVB1eGVy6UbsoTNmiNR8OSJLGcoYOeImK/krX06/k62ms9UKn6UmsXtM+aYVG6FD7KA==
X-Received: by 2002:a0d:d5d2:0:b0:59b:54b5:7d60 with SMTP id
 x201-20020a0dd5d2000000b0059b54b57d60mr11877237ywd.5.1695136499292; 
 Tue, 19 Sep 2023 08:14:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 w124-20020a814982000000b0057a57a9a932sm3181386ywa.107.2023.09.19.08.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:58 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] video: Add parentheses around VNBYTES() macro
Message-ID: <20230919151456.GL305624@bill-the-cat>
References: <1628fc37-2c9f-493d-82c2-9bf225f2645a@moroto.mountain>
 <20230809013930.GR3630934@bill-the-cat>
 <CAPnjgZ3cooZZGKryY5UwBpd7O2kL5W1z++QxQf-Z304eaKvzUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6JFLlBPara9/jKed"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3cooZZGKryY5UwBpd7O2kL5W1z++QxQf-Z304eaKvzUg@mail.gmail.com>
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


--6JFLlBPara9/jKed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 07:04:41PM -0600, Simon Glass wrote:
> Hi Tom, Dan,
>=20
> On Tue, 8 Aug 2023 at 19:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 26, 2023 at 09:54:08AM +0300, Dan Carpenter wrote:
> >
> > > The VNBYTES() macro needs to have parentheses to prevent some (harmle=
ss)
> > > macro expansion bugs.  The VNBYTES() macro is used like this:
> > >
> > >       VID_TO_PIXEL(x) * VNBYTES(vid_priv->bpix)
> > >
> > > The * operation is done before the / operation.  It still ends up with
> > > the same results, but it's not ideal.
> > >
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > In that this seems correct:
> >
> > Applied to u-boot/next, thanks!
> >
> > But I want to note that with gcc-13.1 (and binutils 2.40) or more
> > specifically the kernel.org arm/aarch64/etc toolchains, this causes the
> > generated code to change:
> >    aarch64: (for 1/1 boards) all +8.0 text +8.0
> >             bananapi-m5    : all +8 text +8
> >                u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
> >                  function                                   old     new=
   delta
> >                  video_post_probe                           248     256=
      +8
> >
> > So I don't know that this was a harmless bug.
>=20
> Hmm I should have read the comment directly above...
>=20
> "Note we omit the outer brackets to allow multiplication by fractional pi=
xels."
>=20
> Having said that, it doesn't seem to matter getting (if indeed we do)
> a less accurate result.

But we should fix the comment then, or decide no, this is intentional.

--=20
Tom

--6JFLlBPara9/jKed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJuvAACgkQFHw5/5Y0
tyzBCgv/U2f/62cKxmQvLi0Ho4L9s5J2UCdoAbHx8RbLOxIHErsyikyI276DnG/0
Xg5ZWHc1x4ShQ1useb/XA4pjL7BjWZKSJfiBBySpPGOQWvj1f6cVe5rgT4aIOIQD
LXMWQ4EWhE2pAozhUb99BR1jrDBzI0G6PXn9aMUdunQ7mW1RFS56V64WNNyUwMY0
/JC/dQJdItPgP7+Iwbit1vI92DCX2yKNJ8uL6Zbsu1PHnAEwCfrT5Y3x9Fm562jC
HPHIximkXnoqH54QBxNl33giqEssifpYpF1YJ1oyYXdeyrWEFVHWxvh1yeRL1Ec5
6AvQK/er8YJtO6vPTcb3nD2VMdAtWJraqaEfFr39XKArB8u/4hFN18SFPVA4ISTL
vSzLIkdJ2TClvyFx+tqykfZ5/MFd7GVko9pcGAIozIPYAjSBdpQSFWZnZVUJGfrV
c5sooSlh1O2mhyshPpUJymMwsUAb8xJ7iZZ58C+3usk/Js+DWA3EhIg3u6C+zAFH
ZpYtJ/cE
=MlEO
-----END PGP SIGNATURE-----

--6JFLlBPara9/jKed--
