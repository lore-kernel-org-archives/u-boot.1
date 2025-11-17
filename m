Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D35ACEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 18:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252D083946;
	Mon, 17 Nov 2025 19:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n0k2oMep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37FFC839D6; Mon, 17 Nov 2025 19:30:14 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D86E80433
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ec4d494383so571924fac.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763404210; x=1764009010; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UW1VvZFC8KVRdQDAHgCch0MypXud66extR5EfXtNUK4=;
 b=n0k2oMepT0mVyDz+X47+/ItaU+j36QzcuY55XBUqWzEux89Ttesb8YomiJq6+ovRFI
 Qnq7gUaLX5aTpC8gvZMf5TLDBLjMS6/1B1biTlZ9hJWEzpKmt21nuEHN1MV26TeRhJri
 2uMlCkEdu0eLLwbLqtWTMb2UOEdgJ7liQkUxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763404210; x=1764009010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UW1VvZFC8KVRdQDAHgCch0MypXud66extR5EfXtNUK4=;
 b=k4nvII6aPb82LFez51RbYYhnEZPlmVhiN3PlFxdOmwZ0GYtBnXEbLoJRhNWwyAU4go
 E01zsRV34lhbT7/RCyZxAzNwadNO5heSKCM6GS8FrYbNDyj9YMK+Y/DLUB1eIoy0AZ8S
 TnJ02XyZPSfXtQ+LMEAWhGg4N2swU5XRQBmUH0NMDVTXtDD0m+qzIYh+c3WP7NaMuixk
 I/N3rjEBqZfUJCeg5ca/CqGb9b5A72Bz1bIzBbFM7i38LyQnArY57maUnnjMU/36HLIf
 ZfS9mjC4fP3vh0lrFW4HmI8iQmgA1Wsb6gwCsOgD5VbCovZVUVq+SHbhcDKL+fVJHICO
 BZQw==
X-Gm-Message-State: AOJu0Yyhaks1z402/3CjE3bckOu5YyJIw01DHq7Ints1z7wOj4yRmiOW
 p2yDYTEUEhwO3+XcII8mUIJi8tyBDK39eQTSnpmS35YqhZC68nCE1dyOajh//bv6cKiDeP2yYyt
 1AFHBqgE5uA==
X-Gm-Gg: ASbGncuAApSR9GjG+pOjLx4jIZ7TlQj2q0DBof2mYfZcGutxuv4TBAXe8JDSDlY1zsq
 IFit2fqFJO6ibqa+pJWYVAjKmu4leLfGlGUkyxk3AUM+rjQ6ZNolaoGCYpoJaRjRM8LeH5PfDiw
 pk5+ej9/vw8z+fvhEuxfqREZx+tKC5lvhaVQ97xZs/clbAmxa17O3MoqpWjRCvVDFZpryb6QObz
 41FfP7eQX8Cgj/NJiCz16PxaRrMfITc92H9UIG8I1Mxz8pafDlfq292PiTg9CG76NvrLHuFQtrj
 0umVSJFdaU58IqMgCddyO9eRjAO0aFuRzo1GIyIQHghf8/s7dNbLT62Fj84vAbych8So+l8hj/Z
 eFWxMKlBoqSBwlEE/stVMdtdzxno//GC5UVkx2ds0AdqoB3BIHmSY3Ln2/da7MY5ZwNc4D9D4bw
 euKtoZ9GY72uGiENsvzOObuBNCektL0k02xYypTQA6sIJvxsPBSQ==
X-Google-Smtp-Source: AGHT+IF3OpNuhAzl4QA504Jl7pJz2LxQk+pl4IMGwVlxELGleKi2Ls1ei9XsFX5ThShEllcgwVQokA==
X-Received: by 2002:a05:6871:60e:b0:3e8:915b:41fb with SMTP id
 586e51a60fabf-3e8915b454bmr4128831fac.41.1763404210203; 
 Mon, 17 Nov 2025 10:30:10 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89697fedcsm2565041fac.1.2025.11.17.10.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 10:30:09 -0800 (PST)
Date: Mon, 17 Nov 2025 12:30:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Gitlab: Add a "sage-lab" stage to access a board farm
Message-ID: <20251117183007.GM2125796@bill-the-cat>
References: <20251110154231.2629710-1-trini@konsulko.com>
 <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
 <20251111135638.GT6688@bill-the-cat>
 <CAFLszThrucj38rULiXB3HAsHRq5veZo6zBgHekcjymQecZSP5A@mail.gmail.com>
 <20251114143425.GY6688@bill-the-cat>
 <CAFLszTi+1UbZ-ut1qYs--Mnv9QSA1A6Z=U4f3B+6tQfSFA8FKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hk8n2FuqBh96TR1w"
Content-Disposition: inline
In-Reply-To: <CAFLszTi+1UbZ-ut1qYs--Mnv9QSA1A6Z=U4f3B+6tQfSFA8FKA@mail.gmail.com>
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


--Hk8n2FuqBh96TR1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:16:05AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Nov 2025 at 07:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 05:43:57AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 11 Nov 2025 at 06:56, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Nov 11, 2025 at 05:58:22AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 10 Nov 2025 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > This is the Gitlab side of adding support for the board lab con=
nected to
> > > > > > the "konsulko-sage" runner. On the software side, this lab uses=
 only
> > > > > > upstream labgrid. On the hardware side, each device under test =
is
> > > > > > connected to its own exporter (typically a Raspberry Pi 4) that=
 must be
> > > > > > turned on (and cleanly turned off) as part of a given test cycl=
e.
> > > > > >
> > > > > > Add support for testing on a SolidRun Hummingboard 2 (imx6), Ra=
spberry
> > > > > > Pi 3 and Raspberry Pi 4. In all cases, we enable additional opt=
ions to
> > > > > > run more tests on the board. As we have some networking tests, =
we test
> > > > > > both the legacy network stack and lwIP. In the case of Pi platf=
orms, we
> > > > > > test all of 32bit configuration, plain configuration and rpi_ar=
m64, and
> > > > > > again with and without lwIP.
> > > > > >
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SE=
LFTEST
> > > > > > based on overall binary size. I've created
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/i=
ssues/2
> > > > > > to track addressing that issue.
> > > > > > ---
> > > > > >  .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  .gitlab-ci.yml          |   5 ++
> > > > > >  2 files changed, 187 insertions(+)
> > > > > >  create mode 100644 .gitlab-ci-sage-lab.yml
> > > > >
> > > > > Would it be possible to add some docs about this? Does the export=
ing
> > > > > rpi do a full system boot and then run some scripts to load things
> > > > > onto the board, then shut down?
> > > >
> > > > I don't understand your question. Yes, the exporter is powered on/o=
ff in
> > > > the test job, as explained in the commit message. When it comes up =
it
> > > > registers the device under test with the coordinator (and unregiste=
rs
> > > > when powering off).
> > >
> > > So does that mean that all the logic for talking to the board is not
> > > in the hooks or Labgrid, but somewhere else? I'm just trying to
> > > understand how it is put together and compare it with what I did.
> >
> > I still don't understand what you're asking. Maybe you missed the patch
> > that added sage to u-boot-test-hooks as well? That contains the labgrid
> > environment yaml file. The boards are just in labgrid, the exporter
> > registers them with the coordinator when the exporter comes online.
>=20
> I saw the hooks patch. But I am missing the logic that actually writes
> U-Boot to the board, powers it on/off, etc. Where is that?

Already in the repository or a different patch I posted for a new SoC.
It's just calls to the appropriate labgrid-client subcommand.

> > And FWIW, this isn't ideally how I'd do the labgrid integration, but
> > tees up the next steps nicely. We need to abstract how our pytest
> > portion grabs console/flashes/etc so that someone could write a python
> > native set of classes (since labgrid supports pytest directly).
> > Iterating on that is easier however when starting with something that
> > works.
>=20
> Yes, that would be nice. It would also make it easier to know when to
> expect the board to respond, rather than the long timeouts we have
> today. I started looking at this in June but didn't finish.

I'm not sure how one is connected to the other there, but yes, doing it
all within python might make some cleanup / configuration easier too.

--=20
Tom

--Hk8n2FuqBh96TR1w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRtpqAAKCRAr4qD1Cr/k
CgcLAQD+mfEwOFVmD/dcRkMcapM8iRJX1HqD00XUL6CCMPAOsgD8DZoj5XG2ZgDt
dK1j383CXBX9Z+7XXiaN1B5s9XjQ1A0=
=z+5g
-----END PGP SIGNATURE-----

--Hk8n2FuqBh96TR1w--
