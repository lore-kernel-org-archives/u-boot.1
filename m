Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB9AD5CCB3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 15:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D902989208;
	Wed, 30 Oct 2024 16:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SdnzeDAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE94F8918E; Wed, 30 Oct 2024 16:10:08 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5A989035
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 16:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4611abb6bd5so39948541cf.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730301005; x=1730905805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=58xCHXWA/8jQyzXyjpmP/0u117yhkG5D0mNTBqliYZA=;
 b=SdnzeDAuIQTevA8LuW0s9OeCW19Mi1un8S/8Xuj1LtqvfrnAdqA89sfLCsNbpWSXmM
 zepaXB8gd4h40HOlvt5Pk5XITKEFva0HWTAe1h4wy/cP5IVuWKgWKQuctaCy4BAERn9H
 fdCH/8dtvc7KxYLeNRjeyOcFFHdrLFhf6Cd+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301005; x=1730905805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58xCHXWA/8jQyzXyjpmP/0u117yhkG5D0mNTBqliYZA=;
 b=i+N65Ybkuza1fGDm0/9JkbvFwMfCYlP7SY05XymnEB6hW/vmTTAnH+JGVp5qww4JjE
 80bF9pDlRQalsMDiV42MxUsDKm1YzWQKCbjco15ygP0wfxHIRmqkgvhekmV3jbS6CtDN
 GcAF30qkvIi2F0CzbHbz/aUjcOtrccUFEAT+KWTmyHAfXzCdyuWLAEU+u9ukNjlov/2f
 mXSq6qfSf5qiM28ymzsXRqT/nAHterovZwhrNjlp/HslQWaExHFYmmvmJArpXa+4m0fq
 wTlkPjiq5HOqviVpr7jxYsAPkAM/3htd9SQyqXueXenywv0r807oYItaRuE5cLmG7c+S
 GB8A==
X-Gm-Message-State: AOJu0Yz80MxDYsUdd+h3Vci1J3PUbdvKllYrM/00BruA79VjUJ8Izc98
 983YZX9+4hw8vK8w68XoHF8o9s7f/LUlOc0DKlRTXSjHAqh5/4UGhWyuEjWLOG0=
X-Google-Smtp-Source: AGHT+IGiBPxtB4WnnhGcN7h0yhBK99VV0+hDsNRehAFnUHmI0xOT2WAU7GoTMxN8fH1NaajZwWSBEA==
X-Received: by 2002:ac8:5a56:0:b0:460:ac3e:cf6 with SMTP id
 d75a77b69052e-4613c1bacb7mr229204411cf.53.1730301005375; 
 Wed, 30 Oct 2024 08:10:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a1c20sm55290501cf.84.2024.10.30.08.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:10:04 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:10:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v9 02/11] efi_loader: Add a test app
Message-ID: <20241030151001.GN2558755@bill-the-cat>
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-3-sjg@chromium.org>
 <20241029201259.GI4959@bill-the-cat>
 <CAFLszTiS3stKYmFMQTW5wh4FnV-YD+EucUDk747Uxq-PwUQ0Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+uQP4G+nHAgH9nks"
Content-Disposition: inline
In-Reply-To: <CAFLszTiS3stKYmFMQTW5wh4FnV-YD+EucUDk747Uxq-PwUQ0Jg@mail.gmail.com>
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


--+uQP4G+nHAgH9nks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 08:44:04AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Oct 2024 at 21:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 08:22:10PM +0100, Simon Glass wrote:
> >
> > > Add a simple app to use for testing. This is intended to do whatever =
it
> > > needs to for testing purposes. For now it just prints a message and
> > > exits boot services.
> > >
> > > There was a considerable amount of discussion about whether it is OK =
to
> > > call exit-boot-services and then return to U-Boot. This is not normal=
ly
> > > done in a real application, since exit-boot-services is used to
> > > completely disconnect from U-Boot. However, since this is a test, we
> > > need to check the results of running the app, so returning is necessa=
ry.
> > > It works correctly and it provides a nice model of how to test the EFI
> > > code in a simple way.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This approach has been specifically rejected with an explained
> > rationale: It breaks how UEFI applications work and you cannot run
> > further UEFI tests in sandbox without resetting.
> >
> > Since as you note, you can't reset in a C-based test, rework this to be
> > a python test where we can safely reset the system and verify that. I
> > believe Heinrich even noted that a test which checks ExitBootServices()
> > working as expected would be helpful as we only have a watchdog test
> > currently.
>=20
> Unfortunately I believe this is the wrong direction, as we are unable
> to check the state of anything once a reset has happened. Thus I
> cannot build on this test, e.g. to see what happened to the devices
> and whether they are still bound. It becomes just a 'black box' test.
> None of the other bootflow tests work this way, BTW.

That's unfortunate in a number of ways then really. It's good when we
can test the state machine is still where we expect it. It's better when
we can test that the functionality works for real. It would probably be
generically useful to have some verification functions that can dump the
state of DM before we finish ourselves up and hand things over to the
OS. We could even make use of this in test/py/tests/test_net_boot.py
when we're booting Linux to make sure it's working as expected.

--=20
Tom

--+uQP4G+nHAgH9nks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmciTEkACgkQFHw5/5Y0
tyyAGAv8C5mfEpY4V+i2ds7x6gyJLO56fG4TUJZfHykhlaerzyXep+qY8OEkGSJa
RfxQTCw6Ie9VKTN7n9YUoRFpQArJplWidzIdWlBa9I0g7HtTIQKsummHNvH+BksZ
i1M3he41CCvx9n1kfiSOWlRnSYzwMDlfQgQLl8wJrAeIGz0W459WzVtPtMi3Rdwu
2Qizsy/ha9VcELgehGaZzXJZtd03qpTSSx1IgA1UYPZoxJ7kSmYnAfIeumnpoI/1
Fz4UpWgNA+hdnGUJJmHVWE9/oNsHApUcd2OvBNtJhpFYX2NUKjLStGXN/lVOaJQ/
JdqZHrlHjeWp8oHLFrZksGQXpruJvclf63Fgo6549/YLYF7wZeyQ5tStDNuoF5LY
N6LnWsGirP5a1wp1CVaRn8LjeU9lrHafOZzeaQZX7wZat5h1TbmD+V3Xm/uo85Oh
9UXJq9wYOwuwdBuGZ58OHRKhdrlmpIPaoiDFO4HKOuHWxUqIOqElnSVCana1lazz
ND5iBnsU
=CqEd
-----END PGP SIGNATURE-----

--+uQP4G+nHAgH9nks--
