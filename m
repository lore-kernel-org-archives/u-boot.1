Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF79CE7AEF
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D092183F54;
	Fri, 14 Nov 2025 15:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="APMlcK3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1401E84109; Fri, 14 Nov 2025 15:34:32 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96EED83EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-651c743b2d9so939795eaf.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763130868; x=1763735668; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SbG7iyih+UXGn1ZfQSAYMbVg5ho1tBECZJQ64fTmriM=;
 b=APMlcK3HbdbR2rfWjdbQPttFBaRrU/Ls3/i6ENLVDZkrAoSJlI5ofxY3kqe9XL4+NB
 KxzbfZeelASdT/mPPeYA3n2aXvguX/KsAcGrUYuHyCRHOJD9On2FyB9KMyBD8XXGD279
 URf7+aht4/ksk/CzorjgNVFGsVKpYqP+O1c+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130868; x=1763735668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbG7iyih+UXGn1ZfQSAYMbVg5ho1tBECZJQ64fTmriM=;
 b=JnN5f2XGS3sLfw4wUBybJsB3otq30urscOyuOCzDJbP0lgHcEvsBWJ7upqN3Yy3pfi
 3sOHvrfSjK2oSIeOClYRWf7E+GU+t3MqcukUPUtldnxiLT2Thw+rG4QXAES78Y8ngq83
 UYAwG4x6mJxa004zgo4H0IITU/63GmyLGhQrK5PeezKv4njCJmnShh8fB5jhMgwDbSqu
 rHCcYwyQnJ6/DZIMPEIaZjtKxEg7p2WvsJsQqQ6pRC0HOXfReDM9/12Pgp3SZl8jzCJh
 f+Q9gF07dxsTVq2BWJ0hfwyJ7VgLIZ8UUPxeO43PR0nM18jB6xIQn9tKAOzK26ELdFTS
 37gw==
X-Gm-Message-State: AOJu0Yytu9DlEw+GQf9/P5FyC0anFQ++Ep8nLsSMGDzaYor+MCd9nHKp
 ESI4Raeby3szpKELljyOi6iY7O1Z23RLd4v2hq3rJPLVyf6/gKUptMHkA7un1efPBmo=
X-Gm-Gg: ASbGncsPV9eBqJ5ajkaAskQNgf/czx+uGXzvD7hmWCej1NxGCiwyLvELqoy77UgNMV/
 GtbSrJZ/jCVKiDCfnFwEWZ9Xa/kqhpQ1PtEsuMZd3w2qtWRkQw5MG9RkTuXrO8Dd+GQIup59c7P
 WENHYkR7upNN1gE/vK8X29fUVXRruunS5thTN4TADXFhUgCky0iFSRHoIkWogb1zu5ftK9wdKKp
 CwtUhbHnJOsH+g/lF+iB8qRCney+Z7lMBomb7XDln27Ek1jCAb2owAWu1GAOrJjkQ05rl+Thwnt
 ORq4nZu62IeYv0qbowTIBRloSH49V9RQh6DYArObmJLo12RmwYzZyJ/ENQazMfMzbt28ZS/VJ6S
 uv/tpLalVy5FLDX8xmpWuwWtC8c/ey/jroBHPnjpx2nFM26doSRs37WKpABhvUlGsn7TSzgYybX
 Ss7XuFevmzcSbze1UvBAVz+62hGQ+7qw/9Ma9K2BY=
X-Google-Smtp-Source: AGHT+IE4DpBRw2AYXsjSidux3pS0LFZydxkvy5lfF4lsGrGPtdULN+/KtCp5s6X+7pq3gg3q5yawkg==
X-Received: by 2002:a05:6820:2d83:10b0:657:2d96:2cfb with SMTP id
 006d021491bc7-65733cf207dmr1247271eaf.6.1763130868243; 
 Fri, 14 Nov 2025 06:34:28 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cb8732sm2014057eaf.1.2025.11.14.06.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:34:27 -0800 (PST)
Date: Fri, 14 Nov 2025 08:34:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Gitlab: Add a "sage-lab" stage to access a board farm
Message-ID: <20251114143425.GY6688@bill-the-cat>
References: <20251110154231.2629710-1-trini@konsulko.com>
 <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
 <20251111135638.GT6688@bill-the-cat>
 <CAFLszThrucj38rULiXB3HAsHRq5veZo6zBgHekcjymQecZSP5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qf5uEfX7902zBDkk"
Content-Disposition: inline
In-Reply-To: <CAFLszThrucj38rULiXB3HAsHRq5veZo6zBgHekcjymQecZSP5A@mail.gmail.com>
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


--Qf5uEfX7902zBDkk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 05:43:57AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 11 Nov 2025 at 06:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 11, 2025 at 05:58:22AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 10 Nov 2025 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > This is the Gitlab side of adding support for the board lab connect=
ed to
> > > > the "konsulko-sage" runner. On the software side, this lab uses only
> > > > upstream labgrid. On the hardware side, each device under test is
> > > > connected to its own exporter (typically a Raspberry Pi 4) that mus=
t be
> > > > turned on (and cleanly turned off) as part of a given test cycle.
> > > >
> > > > Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspbe=
rry
> > > > Pi 3 and Raspberry Pi 4. In all cases, we enable additional options=
 to
> > > > run more tests on the board. As we have some networking tests, we t=
est
> > > > both the legacy network stack and lwIP. In the case of Pi platforms=
, we
> > > > test all of 32bit configuration, plain configuration and rpi_arm64,=
 and
> > > > again with and without lwIP.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SELFTE=
ST
> > > > based on overall binary size. I've created
> > > > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issue=
s/2
> > > > to track addressing that issue.
> > > > ---
> > > >  .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  .gitlab-ci.yml          |   5 ++
> > > >  2 files changed, 187 insertions(+)
> > > >  create mode 100644 .gitlab-ci-sage-lab.yml
> > >
> > > Would it be possible to add some docs about this? Does the exporting
> > > rpi do a full system boot and then run some scripts to load things
> > > onto the board, then shut down?
> >
> > I don't understand your question. Yes, the exporter is powered on/off in
> > the test job, as explained in the commit message. When it comes up it
> > registers the device under test with the coordinator (and unregisters
> > when powering off).
>=20
> So does that mean that all the logic for talking to the board is not
> in the hooks or Labgrid, but somewhere else? I'm just trying to
> understand how it is put together and compare it with what I did.

I still don't understand what you're asking. Maybe you missed the patch
that added sage to u-boot-test-hooks as well? That contains the labgrid
environment yaml file. The boards are just in labgrid, the exporter
registers them with the coordinator when the exporter comes online.

And FWIW, this isn't ideally how I'd do the labgrid integration, but
tees up the next steps nicely. We need to abstract how our pytest
portion grabs console/flashes/etc so that someone could write a python
native set of classes (since labgrid supports pytest directly).
Iterating on that is easier however when starting with something that
works.

--=20
Tom

--Qf5uEfX7902zBDkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc97gAKCRAr4qD1Cr/k
CikXAQDpQdaubv6zSS1NlbxUYyCYzvCALfJIKksUxcm4K/IQKgD5AUPurTzyrZle
wQSGJJrYjbLdtCpr1jf/dtBStIbrqQw=
=YjnV
-----END PGP SIGNATURE-----

--Qf5uEfX7902zBDkk--
