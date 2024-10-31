Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4C3E6748A
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 22:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5DA88E0F;
	Thu, 31 Oct 2024 23:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rad7qIua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52F088E41; Thu, 31 Oct 2024 23:19:08 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011CF8897F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so9559936d6.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730413145; x=1731017945; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C8ARmKe/GAIDDlmUj/ODsNQ7wZ494W/KvHPG1r3fdKg=;
 b=Rad7qIuaJuzYELhKoNxo723xOxDSZgbARlFcTfRz4876FeDA+4eSXNBWxHDaRmWEkl
 tEuJ0QugyWOeWKoYjDxUzYKY65/GIEMasDSaKvH6KtPvv6/GTRjHKmx0/nKExIx0/q+v
 HctFmu/VxN/vQTUmGyr2AUAPnWIV6SSFqFoxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730413145; x=1731017945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8ARmKe/GAIDDlmUj/ODsNQ7wZ494W/KvHPG1r3fdKg=;
 b=W8fT1RZCL75IWXDU+jQs8JtMAkI2ME4+n0W0jM4gRAez7lX8yIamVZhz5y21/wccUl
 M8nYuQ2/iSqg9E70R2niziLGZXe4uRx8XSaecIP4kV2q0etziBK4mAF9ZLNVvkmeKgxl
 VwBmNVrv0O7znLpIBBRIjFl+fHjZcQShOw3rQVoR4LUrlXSdme36MiOAHCUULbUU3qZ5
 cwpJI240nFBDYu25B7I/eNlFjjMu7w8FyS0lXOlZaXKGJjF6pTLefk/SBBMt2ZiE0/q1
 Vxyh5JLBhzHsmtnVGrfnT/U7vxXewFaj1oe3LCKSm8rcllAfCev818WoTsHDEnLYtahY
 g9sA==
X-Gm-Message-State: AOJu0YxFVaRo9/HeD+TW2BRK90sBlXGxS4zTjsU3igVoaXhaVnCCYLhc
 YYPwWqO+15AbtjBHzaFUUWzK/IxdQdCKvteGdqsdMP7vMHhBZON9SAQcuV+gLp0=
X-Google-Smtp-Source: AGHT+IF7d4lUmLAzA8atrEA4B6XsTcFCOQayECuL2mZJ33AjOIxNIHGJTn2/xCenVZk7EpGF9QgjFA==
X-Received: by 2002:a05:6214:3981:b0:6cb:d538:cc48 with SMTP id
 6a1803df08f44-6d35c118ba5mr15403406d6.22.1730413144814; 
 Thu, 31 Oct 2024 15:19:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9f451sm12375956d6.25.2024.10.31.15.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 15:19:04 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:19:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 04/11] test: Introduce the concept of a role
Message-ID: <20241031221901.GH3600562@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-5-sjg@chromium.org>
 <20241029235313.GE2558755@bill-the-cat>
 <CAFLszTjh7bxon5mvM2y1cfAA40UqdJVq6G=aR_k7dKr1OZXU9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2C31Ik+2ClZYXUOn"
Content-Disposition: inline
In-Reply-To: <CAFLszTjh7bxon5mvM2y1cfAA40UqdJVq6G=aR_k7dKr1OZXU9A@mail.gmail.com>
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


--2C31Ik+2ClZYXUOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 07:01:56PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 07:51:38PM -0600, Simon Glass wrote:
> >
> > > In Labgrid there is the concept of a 'role', which is similar to the
> > > U-Boot board ID in U-Boot's pytest subsystem.
> > >
> > > The role indicates both the target and information about the U-Boot
> > > build to use. It can also provide any amount of other configuration.
> > > The information is obtained using the 'labgrid-client query' operatio=
n.
> > >
> > > Make use of this in tests, so that only the role is required in gitlab
> > > and other situations. The board type and other things can be queried
> > > as needed.
> > >
> > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > information.
> > >
> > > With this it is possible to run lab tests in gitlab with just a single
> > > 'ROLE' variable for each board.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Aside from the "look ma, only one conf file" trick, I still do not see =
how
> > this differs from the typical board/id system we use today. One can
> > easily make N symlinks to the generic conf file.
>=20
> You can still do that if you like. I have always found that approach
> confusing, so I prefer the configuration to be in Labgrid. It also
> allows me to connect to the boards using an interactive console,
> something that isn't possible without some kind of mapping.

This is where we get to the point where I honestly don't know. On the
one hand, there's the position I usually take. Minimize changes that are
due to preferences and locally wrap things as needed. I have a wrapper
around buildman for example, for the tasks I need. I have wrappers
around labgrid. There's a few things mine does that yours doesn't but
there's a few things your does that mine doesn't. On the other hand, I'm
sure I'm not optimally using labgrid for managing the lab. My hesitation
boils down to that your implementation seems phrased / positioned as the
only way to do things. And no two labs are alike.

--=20
Tom

--2C31Ik+2ClZYXUOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmckAlUACgkQFHw5/5Y0
tyyzsAv/S+lGfIsepEFvX7037qG3j5wRP7CgTLN571HPrumQLPTvYgcZTgRgc5RZ
Puld8FrvHwOZhj0YAQsXoOB0f3ieZ9DNCFhsPO1rHG2q8gquSmZybzgJ9pkshdaJ
Iq525wq03O1MK4IcK3UX0U7LRWPAL++dMR4cQB+Ti1/ZjDoJqA2CBjScUmpMLN9t
8J96dhJGLC6gP7o7KXnm3W1rDcEZQ/OJKA4I7Qe2ifGgzeEZgxTQ/VJ+zMhJe+x9
OKuXRzYtpJ5mvzmczifaUc1HUqTv5vqZDk31VH1UGDtUt33phrWwNr+wEJk0Vl3V
NSKlNFUcO53NRgcwGtNtKT3dvshqp4DnyIdQMtG80okDamsQmObve08PCVRk7sRZ
wRm9J5KaEDP+3DJYB+m4zMILCaGzI0bvG/7ZN6mkODX2dZcXq3nA+qbRP4mOEDmz
b5IGBGsS7WUL85oYtoXIJL/5MlUYlK1OMQSDBZZqDQ+hr34CeNt4QFlM19vcaGx0
F7BhyALX
=9wWO
-----END PGP SIGNATURE-----

--2C31Ik+2ClZYXUOn--
