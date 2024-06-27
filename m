Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737BAC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 14:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1B08852E;
	Thu, 27 Jun 2024 16:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G1GSc3aS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A988854E; Thu, 27 Jun 2024 16:43:51 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E348811C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-25d0d16e38eso2420463fac.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719499428; x=1720104228; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CSaLi0QtohHGkIutKxofG9KMirc10F0apUWwBa1SEak=;
 b=G1GSc3aStDNmyQchyXvrQglbhfaEHrF4PV9CXUEbZEtPjM+Jlz/pKecrWyUJG7NdYG
 EsV+dT08bPMwPxffsKB/L1tE+kNAuPft2MukkvK22LwWsPfWNenDgTOy1EuU7FSNZAbR
 fL44FA/S7mUHm9chXk5Zn/8RM19VyalEkSzw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719499428; x=1720104228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSaLi0QtohHGkIutKxofG9KMirc10F0apUWwBa1SEak=;
 b=DI8wTc9YzqxIaCZ7vRB7CGM+e53sEoXiOlJJaHWtwkDBAeLew4N6nNoESNP+xtvrqb
 Sai+O2beNxZsrrYRHER/jh26m6bX/8P/sS/m6ol+hf3unmX9v57r/3mqf7+uWXnBCjEh
 13mxAcoCKmY4TLPmFyWeAW3LCalvObnkbdld93R1H5pS6/XZwEccITl5a19hTFWoM2Vq
 dfJ/45tfbGl7oB5ceRMQgQ0ZnYt2h0G2JHNTpD4bM1WuvE44m4BOKfxYBU6YofyX97fU
 bcvznv7h3FQaQYsGYuk6R9M7+zuEXsj2bMrqhlcoL8IvbQiEEglN7qzWprhzRSAj4vx8
 gY4A==
X-Gm-Message-State: AOJu0YwATfmWeHwaPr737zURz9MTnyPcdUM4CDZmCMVXIgkZ64QkFfpp
 wy5180cI5U/oJSzrRr5cxbD52t2loGqYk95P02IeinfxgKbWTnIBq+wqrvRQWmg=
X-Google-Smtp-Source: AGHT+IGQU2a8EYwBVCaKo9g47oJP11zuK+AUVKY+kFDkhzb4CtNTa5uKyzjhLnLa8gpIsIDn91KlhQ==
X-Received: by 2002:a05:6870:b48e:b0:24f:c9e3:b76f with SMTP id
 586e51a60fabf-25d06bd5898mr13023782fac.19.1719499428051; 
 Thu, 27 Jun 2024 07:43:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d72d55340sm375686fac.43.2024.06.27.07.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:43:47 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:43:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 "u-boot-board-maintainers@lists.denx.de"
 <u-boot-board-maintainers@lists.denx.de>
Subject: Re: [ANN] U-Boot v2024.07-rc5 released
Message-ID: <20240627144344.GD38804@bill-the-cat>
References: <20240624193035.GK38804@bill-the-cat>
 <e396268c-e106-4bb8-a40d-e0582e556c6b@cs-soprasteria.com>
 <20240625151929.GS38804@bill-the-cat>
 <7b87013a-23b6-419f-a163-2e9f4c44b200@csgroup.eu>
 <20240626150113.GX38804@bill-the-cat>
 <9bf49364-e95f-486a-9642-66953657e4aa@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Av7/uBUgmeHAAtNC"
Content-Disposition: inline
In-Reply-To: <9bf49364-e95f-486a-9642-66953657e4aa@csgroup.eu>
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


--Av7/uBUgmeHAAtNC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:23:34AM +0200, Christophe Leroy wrote:
>=20
>=20
> Le 26/06/2024 =E0 17:01, Tom Rini a =E9crit=A0:
> > On Tue, Jun 25, 2024 at 09:20:54PM +0200, Christophe Leroy wrote:
> > >=20
> > >=20
> > > Le 25/06/2024 =E0 17:19, Tom Rini a =E9crit=A0:
> > > > On Tue, Jun 25, 2024 at 03:12:38PM +0000, LEROY Christophe wrote:
> > > > > Hi All,
> > > > >=20
> > > > > Le 24/06/2024 =E0 21:30, Tom Rini a =E9crit=A0:
> > > > > > Hey all,
> > > > > >=20
> > > > > > Well, once again I need to check my calender reminders since, w=
hoops,
> > > > > > I'm a week late. That said, looking at the list of changes in t=
his
> > > > > > slightly elongated period, I think it's OK. At this point we're=
 a week
> > > > > > out from the release, so it's time for clear and obvious regres=
sion
> > > > > > fixes. Ideally ones introduced this release cycle so there's le=
ss
> > > > > > chances of unintended side-effects.
> > > > > >=20
> > > > > > In terms of a changelog,
> > > > > > git log --merges v2024.07-rc4..v2024.07-rc5
> > > > > > contains what I've pulled but as always, better PR messages and=
 tags
> > > > > > will provide better results here.
> > > > > >=20
> > > > > > With that, the final release is planned for Monday, July 1st, 2=
024.
> > > > > > Thanks all!
> > > > > >=20
> > > > >=20
> > > > > For your information, I have started testing v2024.07 on my power=
pc
> > > > > boards in operational condition and I have a major problem : U-bo=
ot
> > > > > doesn't get the Linux kernel started before the watchdog fires. I=
 have
> > > > > to disable watchdog to get it running.
> > > > >=20
> > > > > This problem doesn't occur with v2024.04.
> > > > >=20
> > > > > I bisected it to commit 340fdf1303dc ("zlib: Port fix for CVE-201=
6-9841
> > > > > to U-Boot") and I also confirm that v2024.07-rc5 works well with =
that
> > > > > commit reverted on top of it.
> > > > >=20
> > > > > Any idea of what is going wrong with that commit ?
> > > >=20
> > > > Are you able to check the zlib performance before/after that commit?
> > > >=20
> > >=20
> > > Indeed there's a huge difference.
> > >=20
> > > Before : 12298074 timebase ticks to decompress kernel
> > > After :  17145906 ticks, that is 40% more time.
> > >=20
> > > But behind that, we also need to understand why the watchdog is not k=
ept
> > > alive during that time.
> >=20
> > That is odd, I would have expected it to have been kept alive.
> >=20
>=20
> I digged into it a bit more and really that commit 340fdf1303dc ("zlib: P=
ort
> fix for CVE-2016-9841 to U-Boot") is the issue. The watchdog is still kept
> alive, but not fast enough. On powerpc 8xx, the CPU watchdog has a timeout
> of slightly more than 1s, so it must be kept alive very often.
>=20
> schedule() is called in inflate() just before calling inflate_fast(), whi=
ch
> worked until now because the maximum time spent in inflate_fast() was abo=
ut
> 300ms. With the above commit, more than 1s is spent in inflate_fast() , f=
or
> the problematic block the time spent inside inflate_fast() is multiplied =
by
> almost 4.
>=20
> The problem is that the commit does more than what it says and removes
> an important optimisation that is using halfwords instead of bytes for the
> copy.
>=20
> I'm going to send shortly a patch to partially revert that commit. But if
> you feel it is better to revert the commit completely and provide a fix in
> next cycle, it is ok as well, up to you but I think it is important to get
> that fixed for v2024.07.
>=20
> I'm also sending a fix on the setup of 8xx watchdog, but that has almost =
no
> impact in reality and doesn't fix the problem.

Thanks for digging in to all of this, I'll have to think about what path
is better at this point in the cycle.

--=20
Tom

--Av7/uBUgmeHAAtNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9eqAACgkQFHw5/5Y0
tyyL/gwApWIJHzIa8VaC/yL8+toEPcQXNUrgVLFW/DZzcUb96pbzasNz6KyweRQ/
VDwbh1cy6EIJq4VPmPIJ+89R1uEKc8tR+SjrAB6vO6kckLZxF1M+MZJgoOM8T/6V
z3BLAwyjHuO0MOLj5Xgg0C8xLuoQgMpJQ56jWCeTDJ0mGKOzuwAkmtMowdZVU3N+
SutJRmJw/QjgQ6gAQ5eeTRXLZ0WRZnFpaQqqJMmBU8pxOOlJUr8hnBwgZtaohSmI
t5owjndPkvEKCwmvrKN5FpyG5YS9ow2ZECI2CRB5rQVEFAnARk8nPftD4PRniLWh
CW8gHjEewlWl4u/phDH/bp+QKPpyy2oj49R6/1TZj1YigtjqkjLh5i8eZoFNx+1a
4KEZx4029QZCsaSnDEhWvDBZjt8bwDmJOth3GpDBVtzhYVm2w+t+2kJrC/7mmd9r
hjgxTkApt/nEjKtn4/Z1ilWfz3B2v77XvBgPJ+/krEKrIpeVzAH2B4qySDR+LTIR
i8TJV9+E
=m8/n
-----END PGP SIGNATURE-----

--Av7/uBUgmeHAAtNC--
