Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62F1C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 20:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F018091A;
	Thu, 15 May 2025 22:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hgBl+GPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26618129F; Thu, 15 May 2025 22:54:21 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BC2806D8
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 22:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-605f7d3216bso520502eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747342457; x=1747947257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yS8lCxhMDrINhngyEefqhkmMCeK60l8hi/dSnXsUaCM=;
 b=hgBl+GPQqU51X8vhPSvm9lvdGJsrr+1fwW5hyb5z0DE2pUD0TBZHEpKxwsF4byqhmV
 fsMpaaCS3mvchW4Z2ta5qgjY9FlOQiWlZ7h444gzVUzpIt4fNFX9ynsncxs8KoPDte5l
 GF1wK6eb8kAU7k96PshWVKd2PsFVX5olubwcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747342457; x=1747947257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yS8lCxhMDrINhngyEefqhkmMCeK60l8hi/dSnXsUaCM=;
 b=qzoUOm9oFurf3l/9RP7inqmdU+IRud7QXt0KmW4yseW5FONtyuuUzfgzjj4Wep1Euk
 x8xqvE+sFQohaNBR8fiIq/5Ik9DKE9pudwDHR1GPxS4B9vESaB918A6xIdgC+GQrDj8r
 v6X3ZDYqrkvuEbbiJpAlOaC5ojg0P7y6rtGYFOB0foqPaYvI4DNMZtGt+Y9TdHarbVLy
 15fHbH1BV4lLqO6t2ztQogEpsYf0tgM1mfJEj4bEOCxKpuqsCnZR8AUkyCn2NfLlhY0d
 04Yv+rD/F7UyFYdzwW2fKEHOeI0np64azDN/g4I3P6NFUx4MggmJxVCtUKbFeH5aEQAJ
 VwKg==
X-Gm-Message-State: AOJu0Ywo/f9n5HZM/heDhf4EgnAaqejL1jUFToisPphQDUu597fLCOWd
 SDVbXd+4R5IHH/9t70gmrjuRv33x8ZCkbildNO4LoHAwGvXF5k1lcHmlIDX8Qgv9TBmSQ6pCCt0
 bvO8Qgqw=
X-Gm-Gg: ASbGncvv6EiSLCX7KY7CV2Lk19y/0ZWgSdpILDKQy8DyPSVinia923sRC3wXKlw/X37
 cKPVRhCgrwZ4vnGwmCzzi2TQIjAq35NVsaptaxW0qydAaK2ycCiFYBOpTwCdb250jV/SKMF3He4
 Wr9/zVTuZZ4Ibq8lAvkLZGKJlcTFx9KzQ2VaGxhOXDPtrvrvKWAU0TCR4ARvmd62zIVd2e2q2Wn
 +nzWc2Qkmn3h+LJEQ2otKUP4vqUweKswtMaR/0auomyUqkm4oyaqfiaDJWiZw4DfR6sS+myRytO
 8wSa7OZ5wIXczdFLXrdwQgxtEv/QCC0rtuBz69eTWEjcnf537gNY2sJN9fWUT2TD1Y09CY2vFFO
 mGouBXJfZ2jF5
X-Google-Smtp-Source: AGHT+IHtBi6jlYGOHpdEDSwC1IEBrMLTTA2pNUTNsDztX6K0Q/ak1EKc7Q/mvlKyzlkB1H0rRJyV3Q==
X-Received: by 2002:a05:6820:1896:b0:603:f903:c85a with SMTP id
 006d021491bc7-609f3736881mr553206eaf.4.1747342456943; 
 Thu, 15 May 2025 13:54:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f2f1d764sm130382eaf.1.2025.05.15.13.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 13:54:16 -0700 (PDT)
Date: Thu, 15 May 2025 14:54:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Xu Zhang <423756212@qq.com>
Subject: Re: [PATCH v4 09/22] passage: arm: Accept a passage from the
 previous phase
Message-ID: <20250515205413.GD100073@bill-the-cat>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
 <20250514215821.GD603748@bill-the-cat>
 <CAFLszTg2vMEVSR--ksh9cVRHBQWxzC++Nf83iDq7utUwku8Hrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mhtTfNO/wY/I3HXc"
Content-Disposition: inline
In-Reply-To: <CAFLszTg2vMEVSR--ksh9cVRHBQWxzC++Nf83iDq7utUwku8Hrg@mail.gmail.com>
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


--mhtTfNO/wY/I3HXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 09:26:42PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 10, 2025 at 03:42:07PM +0200, Simon Glass wrote:
> >
> > > Accept a bloblist and control devicetree from a previous phase in
> > > registers 0 to 3, as documented in the Firmware Handoff
> > > specification[1].
> > >
> > > Note that there is currently a weak function called save_boot_params()
> > > which happens to save the same registers as are needed for this
> > > protocol. But it seems better to implement this feature as a first-cl=
ass
> > > citizen, if for no other reason than that many boards have their own
> > > version of save_boot_params() which may not happen to save the requir=
ed
> > > registers. A weak function is not a good basis for an API.
> > >
> > > [1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > > While some efforts were made to encourage Intel to adopt this
> > > specification, this has not yet been successful. However I do intend =
to
> > > use my proposed x86 handoff in U-Boot, once this series is in.
> > >
> > > Changes in v4:
> > > - Update commit message to indicate this can only be for ARM at prese=
nt
> > > - Update commit message to mention why save_boot_params() is not used
> > >
> > > Changes in v3:
> > > - Add support for aarch64 also
> > > - Update registers to match the Firmware Handoff protocol
> > >
> > > Changes in v2:
> > > - Use three registers instead of two for the entry
> > >
> > >  arch/arm/cpu/armv7/start.S | 10 +++++++++-
> > >  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
> > >  arch/arm/lib/crt0.S        |  6 ++++++
> > >  arch/arm/lib/crt0_64.S     |  6 ++++++
> > >  4 files changed, 33 insertions(+), 1 deletion(-)
> >
> > This is what makes me think you aren't actually working on my feedback
> > about taking what we have in-tree, now, rather than just forward porting
> > your old series and deleting the current code.
>=20
> Well, yes, I sent this v3 series because I had thought you were
> willing to allow me to maintain bloblist. I certainly appreciate the
> work in this area, though.
>=20
> >
> > We have save_boot_params doing exactly what it should today, including
> > saving off a standard passage and making what was saved available later,
> > in an intentional fashion. If, hypothetically, Pi needs to override
> > save_boot_param because a future new-firmware-blob does standard passage
> > but at run time we want to support both, that's a good thing.
> >
> > With commit ea3348ebc215 ('Merge patch series "Handoff bloblist from
> > previous boot stage"') we already implement the specification in [1]. It
> > is not a "which happens to". It is intentional.
> >
> > I guess the overall challenge here is that you want to do things which
> > are a superset of the firmware handoff spec itself?
>=20
> Yes,, much of this series relates to putting some structure into
> things which are passed via standard passage, including validation.
>=20
> I actually don't understand why you would be keen on using
> save_boot_params(), a weak function, used for board-specific features,
> to implement standard passage. We should build standard passage in as
> a first-class citizen. I certainly don't want to try to implement
> things that way on x86.

You seem to have misunderstood a lot of things and perhaps need to go
and re-read the feedback. Nothing about a weak function implies less
than "first class" and "maintain the code" does not equate "delete and
replace functional code with the same thing, but I wrote it". And if you
aren't going to do that, please don't bother posting a v4 either later
this week. I feel like I'm having zero progress with you taking my
feedback on anything at this point.

--=20
Tom

--mhtTfNO/wY/I3HXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgmVHUACgkQFHw5/5Y0
tyzpOgv+JhvI2oXKcvUmiTgRzNFicFbrcRJ7y63AMuQngtF1t5QZivr4AK2lJ3Wm
aFWp7hK7nGiAW+EddUrYBAK2ZqJjGHG++/SBJBRGqb5dDZtnAc46Jo6DQoM5nvEz
nJrEqlVNPzgdM7LeranQeq7qjVdxSRHl2KN0w8ZGmevskZqq7OIlPgvsfO8eVXEe
6gOKCwyxFOqD32fztTqQrkGvushw61FBNz1RTbcuMNpjLKkAgyzb+Y3j5pyH1Ulj
Hmf2Pp9My84N8Uli1HeNbjrnoTZgq6D/nHDk2xmQ0/GseDQk2pP2iSkbOE+MFOuh
ltbD/a0EnnqHSyQGAwJvvAKIywPJzybDh+GuTqRJ49QWo1vYOIM6ddc60h2Ncqmv
mpRX0MtII7Fbh301XP97G/+kWLrsxEeiYyhOUCqs8f0PlvrDUsA9Zt4l4zUeJEBM
uhAwVGnYLswZAbEs/Ky2Vm8MCskIAdUl8BncFk2ceR9evUGfsuxFzycR0xvCmhpx
W3rApRH8
=b9Gq
-----END PGP SIGNATURE-----

--mhtTfNO/wY/I3HXc--
