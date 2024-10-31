Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F6D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4908988DF1;
	Thu, 31 Oct 2024 19:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IVfbIBIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F4088E0F; Thu, 31 Oct 2024 19:34:22 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE923889E9
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-460a415633fso7459711cf.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730399660; x=1731004460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cf7fUNkPMzbr4CZYOH6k0cePacS0dilsOcqxGQiAoHU=;
 b=IVfbIBIPc7Q4YtlMiChT/lw9F4IkaUflbUlZkrJGw8c1rfzuPIkn5de7uWLEf+sXAL
 k/Pmb9Ixacrgclv1aNNnbEiazV4UOjj/HqIJoIkJEgAsOrSBqvr6vP8MfW4Lqvxoc6Nf
 i7Xkrxxeb+pbrrgFE1IbVvyztY2ubzNwxmrCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730399660; x=1731004460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cf7fUNkPMzbr4CZYOH6k0cePacS0dilsOcqxGQiAoHU=;
 b=D4RtDwld98oQxHnR9ZdXhP3s49j+vUo8a3Kw6GcTeRZ3k+G+ZovdcVwVT3xtPM2bTq
 d/ELXBUQG/uK31f7L/UaVt6ezbtOGGjtdVdxOQFC4eO938Nuk1GZJ4C0z/Vak6J4m5cC
 Ti9clPUI1pU0TqrI1FtAu9vbcSYFrTBY0pONO/groV75nX2ezpuljo3QzBKxaJvFeuGp
 w5xMg3K5KID2MzryIPD6VBWpyIxSJXrIlJKY5/nyw3fjYpJGeNy7XjjHymVQTR/f2OLl
 b2x3MhXAuXmy+GzPVwqliDKyPhjGyN0LUhLFKXsFSCCQeWJbo+lBvd2hvzM18i/A65KD
 sDWQ==
X-Gm-Message-State: AOJu0YzalDX2ok709bEx4IuSPBaGfyEz46gCBvGKdotPr4rL1bEyTLqd
 4989+e2ReH55B+SSFkJXN4hb5syxsXAt58hbOKXdRUWxt5ob59QzKq92O47ePaM=
X-Google-Smtp-Source: AGHT+IE/PzigiYkBlv7WDQFm4UTNIDZwkcSunEsgyONd0o3nn/VEmbKMpQHm+2GTXfSbM2fsrOsoCg==
X-Received: by 2002:ac8:7397:0:b0:462:ad4a:7761 with SMTP id
 d75a77b69052e-462ad4a9d61mr32047811cf.2.1730399659532; 
 Thu, 31 Oct 2024 11:34:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad19f1f7sm10121841cf.92.2024.10.31.11.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:34:18 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:34:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 02/11] test: Release board after tests complete
Message-ID: <20241031183416.GC3600562@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-3-sjg@chromium.org>
 <20241029235303.GC2558755@bill-the-cat>
 <CAFLszThVsDEaFr2EYbfBi3u+MLp5D+OW7HkQKAgeJaAoei6gAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b1ivMb8gEOXAPD3J"
Content-Disposition: inline
In-Reply-To: <CAFLszThVsDEaFr2EYbfBi3u+MLp5D+OW7HkQKAgeJaAoei6gAw@mail.gmail.com>
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


--b1ivMb8gEOXAPD3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 07:00:14PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 07:51:36PM -0600, Simon Glass wrote:
> >
> > > When a board is finished with, the lab may want to power it off, or
> > > perform some other function. Add a new script which is called when te=
sts
> > > are complete.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > But please note I don't see an up to date version of the
> > u-boot-test-hooks side of this which would include the release wrapper,
> > and presumably files.
>=20
> Please see my patch from late August "Provide some basic scripts for
> Labgrid integration"

Yes. There was quite a long discussion on patch 3/3 and I'm not 100%
sure where the next steps there are on what the next iteration should
have. If the release script was it's own patch then I believe the first
3 patches could be merged today and then that leaves the actual labgrid
stuff that conflicts with my setup to figure out.

--=20
Tom

--b1ivMb8gEOXAPD3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjzagACgkQFHw5/5Y0
tyy3igv/dYuAvzTC52Z+4DDovSsmmH71QZHmTZ6j+3b9V06BQgP09PbMhjQe6Irg
0lJlHxDla2r9MkPHnQZ2fhQkTaASlg0JJ19oOaATH1wxBVEXglzpZwsgzJ0YT99b
mz80eRqcwUad80y9dMtSRZldr+ZqbebRBx9UEbhhbKe7wbCJesGSGPySikgm+m7J
vZa9ZDsbwXT2bhEglYL+n13S7qfrHMstItfMJOc7jGsGPRKVjlyu91emigqQPwY2
uEmB/ngFkKWGysa+v7PPbekw0x9e4QG4ibaEQL0AJBucsJcsnSbNSJs5S+oRsO4S
9xl3HY9/WCBdS15S9QbIHNLEWsmestLBBAo1hbwornhAYaKroqdvdlRSyOXA7MpI
jC54UGfZVvsuakXSAMG+6CuUSBv6Wc1qirN6Ux0x3mrHD9Acs/KLWy3Xetv3qYXL
IYEx33xpWCW5w7xnMFEuFTTMEcsPu2t3J20flxFStTQH1T7awATQYM7Nf0Ew3QGn
6KOvQE54
=vjIk
-----END PGP SIGNATURE-----

--b1ivMb8gEOXAPD3J--
