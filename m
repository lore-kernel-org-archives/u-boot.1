Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0151CCCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 15:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A411834D4;
	Tue,  7 Oct 2025 17:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JtSjtqON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E084983655; Tue,  7 Oct 2025 17:39:11 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953E98323A
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 17:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-79d36a6298dso2493124a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759851548; x=1760456348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OMOorNYCoQr5p00IVUN796gQlLCwB/MdCdMlMY9jQq4=;
 b=JtSjtqONpXNeHShY2WBw3/Z9kC2WNBIbWpoiS7Q7WEDO7H4s3lA76j2Z3P2K06nlER
 rcwa+OYoHYsTFRe6XVGljUexDDzc99ZyfiSQvgWQRrtI5cS9Hv//rZ1yaOAgCQ1oUHRr
 pwYKiVIzsjeInGEK1vksNdVl5uiRJRAXZ/j+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759851548; x=1760456348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMOorNYCoQr5p00IVUN796gQlLCwB/MdCdMlMY9jQq4=;
 b=cqIwUFYxfTijTv9v682rz6fHBnbu9hea/NA9TVzq6UDkNB1ZdzFy7IM4226CT3nljw
 uDFvTAeo0xcBaKzja0WxS3JhbhbFWjGhyfFZ01ESKwwhJatlhWaWMee3ir5COYzDpePg
 pDcldAK2Js7WeXg7g/CfwM487E3eLmWPbYKBwOqgF1jFoArU3GrlxWCApDFRG18I0Iwm
 YwZETM536Qdad3Ti4xonxXG0OwBRmxtrFLtR8gri5YOjQ6n/g7xvQPetQm/Wr+9dQ2Au
 qMI4eIxohRid28jlhUUPUCgWHeDfGM2+7jX4opwFzNuvxwtMz8dqj7hqX+6w7icsDHZp
 jXUQ==
X-Gm-Message-State: AOJu0YytXvinsX+UNjoWZl9LpvRytpq50KECzzYW4EVjm8v1239KTtGv
 n+3yaruQ+fTPm03dl9CP6ZNYZwMVkqSgInX3pLfez1TRM4GLHKeAGp4ZbSjA8xSRLA8=
X-Gm-Gg: ASbGnctRzDerxGs//G2vtHszHJhT6T7UCW6rJsmphA5r60Vw+NrcirTUBkA9qP2OgWs
 7oMX+T/xMr6P2pwM0FYx36scsgaROc9rB9WnQYuQKU/oPqQnj0qErYsv9075nhCfDIXwD2UzwLt
 hjFUrgyvLRbeWvMbRzcZSY22SQWzjsggDRv8EBAYjPzvdZBhuK5EQHjEeytmEQHRYrRH4HNJHcA
 Y+qJl8tcS0qnzSxuVUgMopkQLIefVaYTZsbStgLNE4UM7slTNzx75a4yi22fuQSTDSz8oIiAhco
 NT8nuGlg2DoTfgcW3YNEH9Q/lEsFm0ndQkjRTjCuBXTUfO/GvNVbz4bo1fo3oAM8oWacfl+uEHm
 jIVnxz3D88GMxFtHl9Ek88uEpl90bBc+iA+j8okuZjfdaqFE45YvgjKeFyDa5LyQKNCoJUE/LZP
 sbJ35d6X//2Q==
X-Google-Smtp-Source: AGHT+IGlnn6IBz9WXs5SxrozBsE2oZyka6iFb0mYyUMPtU5BYVpBGi+ne8iRL0KYgK+Nd/nD6qkWgw==
X-Received: by 2002:a05:6830:7186:b0:750:97f0:3c02 with SMTP id
 46e09a7af769-7c0df79b8d9mr124277a34.18.1759851548120; 
 Tue, 07 Oct 2025 08:39:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f6104adsm4665857a34.4.2025.10.07.08.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 08:39:07 -0700 (PDT)
Date: Tue, 7 Oct 2025 09:39:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
Message-ID: <20251007153904.GK298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
 <20251006234500.GG298503@bill-the-cat>
 <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
 <20251007135009.GI298503@bill-the-cat>
 <CAFLszTjimWcKE8n991-ik-7fyhsesHsm5hrQwx7-FKSqgd48QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BrinPEZthWWQYcIu"
Content-Disposition: inline
In-Reply-To: <CAFLszTjimWcKE8n991-ik-7fyhsesHsm5hrQwx7-FKSqgd48QQ@mail.gmail.com>
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


--BrinPEZthWWQYcIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 09:14:29AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 7 Oct 2025 at 07:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 05:13:55AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 6 Oct 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > It is helpful in tests to be able to show the bootflow that i=
s being
> > > > > > > examined. Move show_bootflow() into boot/ and rename it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Add a log_err() for an invalid state
> > > > > > >
> > > > > > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++=
++
> > > > > > >  cmd/bootflow.c     | 68 ++----------------------------------=
----------
> > > > > > >  include/bootflow.h |  9 ++++++
> > > > > > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > > > > > [snip]
> > > > > > > +     case BOOTFLOWST_COUNT:
> > > > > > > +             log_err("Unexpected boot value of bootflow erro=
r %d",
> > > > > > > +                      bflow->state);
> > > > > >
> > > > > > A small thing, checkpatch.pl catches that this isn't aligned wi=
th the '('
> > > > > > here as it should be.
> > > > >
> > > > > OK. I'm unsure whether I really want this line anyway, since it
> > > > > increases code size.
> > > > >
> > > > > >
> > > > > > A larger thing, and please correct me if I'm wrong, but on read=
ing the
> > > > > > whole set of changes, this move + rename just means we're putti=
ng more
> > > > > > info in the test output, and nothing else?
> > > > >
> > > > > It will also appear if you have CONFIG BOOTSTD_FULL and use 'boot=
flow
> > > > > list' or 'bootflow scan -l'.
> > > >
> > > > But that should be the case before this patch as well, yes?
> > >
> > > Yes, that's right. This is just moving the code into a place where it
> > > can be used from tests.
> >
> > But it's not being used from tests, with this series.
>=20
> Please see this one: 'boot: Add a new test for global bootmeths'

Yes, it calls the function, but doesn't seem to do anything with that,
especially considering what the test does before these patches.

--=20
Tom

--BrinPEZthWWQYcIu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOU0FQAKCRAr4qD1Cr/k
CoQaAP98Y24oJPiVEjm5s1jnOU3xOkV2GhGUnkcLksOi+L91+QD8CHOOjv9JIa3+
ztOs93dnN8GhV0Yem4OvczlZeHuI2gU=
=Nfv1
-----END PGP SIGNATURE-----

--BrinPEZthWWQYcIu--
