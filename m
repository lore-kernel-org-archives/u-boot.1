Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0DDC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 14:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AE382F67;
	Sat, 24 May 2025 16:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lPkZMSBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFC78310F; Sat, 24 May 2025 16:53:20 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D555082D6C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 16:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6065803ef35so162882eaf.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748098396; x=1748703196; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ob/YioGCWmNDaTzUpW7g8HNbqZIkkZ0yjBe7HuuTArs=;
 b=lPkZMSBj5RqsfI+/OHadrPIcClqsrutCJ+GZsbevjQhBMGlTnRDxW+eTGQBfrjr2dM
 g1VN84DL6OWafEy5JjLvT5JE2Wb56bHu8x3S5jjazURkvxuoPW7OGRDs5AQUfePnsmMc
 lsEiNqVndkwXhDz4KyQWjVIg6G19EUxVpFSe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748098396; x=1748703196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ob/YioGCWmNDaTzUpW7g8HNbqZIkkZ0yjBe7HuuTArs=;
 b=dMYeLzHRhR+LhjLqBj5hFQd45l6HjczyvQ6/2fgdNENzlO1nF2gf9+OMAxUnPAd2in
 kBu2oGb+uAy/U44E2ADk1pT9FTa9sdJ7Uk5RwwVMth1oyTU/mDU3e5K6BlHstiOC9CCo
 fRHl9Rl74zpgJMOcfmDV2w6/pM/FjMdS81ZooVX7tUR5+VckXjnPPAHIM7yA4J+EWk1s
 KKCrtWwosgIT1Q6jcZ5VUDIfaACVeRe267aL6t9LaGbGNqM+G8TUlG+I/5mUkuMW9KNm
 Zrv/jey1uLuhBRTqtb66Dg9cbISN2yMU/YleK81ieJttsFOwl9sQOSsjjSS/idwBV2RM
 WdKg==
X-Gm-Message-State: AOJu0YzybeEOmkVXDjN13xd1lap+jUgJWmWswHTKb0xlPwuQoy/WIHpa
 sG5U2rUfTivWTTffx3vRTngXKKx1qgcUYJ4cZWNWSu6v04fNPbtUfndZ2UamYoBqNpI=
X-Gm-Gg: ASbGnctdtiu8exCGAGQXCAFv5NSH7maTwKkpcPaxUOmsQSu4WvUFX00haxNhxRz8/pC
 GIuI2Nv20U6IeBBB1vuaEJJ6k9GOkNRDKbkRyQWsFHveB7Ti+Qw2bxUQ8UXpAnAASKflMgTVAIQ
 51IXRlCYKHPgPdagAt9RMkbefc0T4tyBzohAzGNN4dFFnCqn+7UuwOC40qggq2HoDrgFpfQD7jx
 efIHovzkP8BN10YDSexIsLDw9JrOGoCqN7XlLlBOhUxoEpPjXkPD9cKRAlGRAcxS3o185c6ESMD
 qmt52+oQSpmS3KzFy5bJDfQgPmsnlSrlLfZrFWcYz4MzMu8cr6iwMffaOJLrLuQQldlMjSxSaEi
 B++iuS9lCU8QJ
X-Google-Smtp-Source: AGHT+IFJt/KjNxTzm67p8MYmU11RBlufyBVexDfF7aaCpQGEsf9vE/w0ASOB+ay2YAP+ThmIq06okw==
X-Received: by 2002:a05:6820:2714:b0:60b:a06a:2f31 with SMTP id
 006d021491bc7-60ba06a3b3dmr1551946eaf.4.1748098396397; 
 Sat, 24 May 2025 07:53:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b87fa82c3sm1267025eaf.8.2025.05.24.07.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:53:15 -0700 (PDT)
Date: Sat, 24 May 2025 08:53:13 -0600
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
Message-ID: <20250524145313.GP100073@bill-the-cat>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
 <20250514215821.GD603748@bill-the-cat>
 <CAFLszTg2vMEVSR--ksh9cVRHBQWxzC++Nf83iDq7utUwku8Hrg@mail.gmail.com>
 <20250515205413.GD100073@bill-the-cat>
 <CAFLszTgHg6VfuJbTwdbkfAu4s-ZG0EpZ+6W5i13vC5iu=c+16w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gze7l6nzHuY+oP2e"
Content-Disposition: inline
In-Reply-To: <CAFLszTgHg6VfuJbTwdbkfAu4s-ZG0EpZ+6W5i13vC5iu=c+16w@mail.gmail.com>
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


--gze7l6nzHuY+oP2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 03:31:08PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 15 May 2025 at 21:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 15, 2025 at 09:26:42PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, May 10, 2025 at 03:42:07PM +0200, Simon Glass wrote:
> > > >
> > > > > Accept a bloblist and control devicetree from a previous phase in
> > > > > registers 0 to 3, as documented in the Firmware Handoff
> > > > > specification[1].
> > > > >
> > > > > Note that there is currently a weak function called save_boot_par=
ams()
> > > > > which happens to save the same registers as are needed for this
> > > > > protocol. But it seems better to implement this feature as a firs=
t-class
> > > > > citizen, if for no other reason than that many boards have their =
own
> > > > > version of save_boot_params() which may not happen to save the re=
quired
> > > > > registers. A weak function is not a good basis for an API.
> > > > >
> > > > > [1] https://firmwarehandoff.github.io/firmware_handoff/main/index=
=2Ehtml
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > While some efforts were made to encourage Intel to adopt this
> > > > > specification, this has not yet been successful. However I do int=
end to
> > > > > use my proposed x86 handoff in U-Boot, once this series is in.
> > > > >
> > > > > Changes in v4:
> > > > > - Update commit message to indicate this can only be for ARM at p=
resent
> > > > > - Update commit message to mention why save_boot_params() is not =
used
> > > > >
> > > > > Changes in v3:
> > > > > - Add support for aarch64 also
> > > > > - Update registers to match the Firmware Handoff protocol
> > > > >
> > > > > Changes in v2:
> > > > > - Use three registers instead of two for the entry
> > > > >
> > > > >  arch/arm/cpu/armv7/start.S | 10 +++++++++-
> > > > >  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
> > > > >  arch/arm/lib/crt0.S        |  6 ++++++
> > > > >  arch/arm/lib/crt0_64.S     |  6 ++++++
> > > > >  4 files changed, 33 insertions(+), 1 deletion(-)
> > > >
> > > > This is what makes me think you aren't actually working on my feedb=
ack
> > > > about taking what we have in-tree, now, rather than just forward po=
rting
> > > > your old series and deleting the current code.
> > >
> > > Well, yes, I sent this v3 series because I had thought you were
> > > willing to allow me to maintain bloblist. I certainly appreciate the
> > > work in this area, though.
> > >
> > > >
> > > > We have save_boot_params doing exactly what it should today, includ=
ing
> > > > saving off a standard passage and making what was saved available l=
ater,
> > > > in an intentional fashion. If, hypothetically, Pi needs to override
> > > > save_boot_param because a future new-firmware-blob does standard pa=
ssage
> > > > but at run time we want to support both, that's a good thing.
> > > >
> > > > With commit ea3348ebc215 ('Merge patch series "Handoff bloblist from
> > > > previous boot stage"') we already implement the specification in [1=
]. It
> > > > is not a "which happens to". It is intentional.
> > > >
> > > > I guess the overall challenge here is that you want to do things wh=
ich
> > > > are a superset of the firmware handoff spec itself?
> > >
> > > Yes,, much of this series relates to putting some structure into
> > > things which are passed via standard passage, including validation.
> > >
> > > I actually don't understand why you would be keen on using
> > > save_boot_params(), a weak function, used for board-specific features,
> > > to implement standard passage. We should build standard passage in as
> > > a first-class citizen. I certainly don't want to try to implement
> > > things that way on x86.
> >
> > You seem to have misunderstood a lot of things and perhaps need to go
> > and re-read the feedback. Nothing about a weak function implies less
> > than "first class" and "maintain the code" does not equate "delete and
> > replace functional code with the same thing, but I wrote it". And if you
> > aren't going to do that, please don't bother posting a v4 either later
> > this week. I feel like I'm having zero progress with you taking my
> > feedback on anything at this point.
>=20
> Are you completely set on the idea of a weak function here?

Am I completely set on following the general architecture and design we
have and not making needless changes? Again, you seem to have either
misread not not understood feedback and are intent on doing what you
want anyhow.

--=20
Tom

--gze7l6nzHuY+oP2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgx3VkACgkQFHw5/5Y0
tyyAnwv8CjaHiLk3H9QqyWMJcNUDVzXaHMuEYbcauzsv6e1PBkzs+muhXU4xVlJD
L3ZvwC/D+DUIoxL0dQ067Xn0vyEkljABQnIzRWzBIqjp8vS0+Q1c9jAamQSIQiWY
0PH7V25zydPeDpy0fqob7Yl2iO9tuNV3F+DMJ3YNlinkRARNbCrC4dXxYlvfCZbe
OJKsCO+veEOXvfj94Sb+yo7SwZnW0UTVqkaZ/m7tP/yu4VSad4YlKk/Q6By/zW95
iTz0C7Xi4pzNBokSCeFMA9fEQqrJSzHinM0foMdbU6ro/rV6VXbFpSZ+cE3tAZVR
OwQ0rbC/m0MtDdIZcsmA4SypAbrODk4WDAxOPjF2HA48goYNuH0t3Oqs3q34aheB
1nAHzCUi5N/5Yu41OlM+nJJW+ddCnEzNfoNEsBIJv7IMU8w5dItpjuYo/K8pocIX
2pCghsteQbJlr8vdL9YaYMY4sh+0ij4BqdUlFsUcusWERg2OPDFi7ukBMi+L9MrS
WLpb4OyW
=5y45
-----END PGP SIGNATURE-----

--gze7l6nzHuY+oP2e--
