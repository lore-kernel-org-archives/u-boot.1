Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED5C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3B08468A;
	Thu, 24 Aug 2023 17:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hBOxAo5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6834883F7B; Thu, 24 Aug 2023 17:16:38 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6848486776
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59205f26e47so33137b3.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890194; x=1693494994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+yDzePQqbeAxTLEZMPVIUN8JJZ7XmywsYstjTpAYpbg=;
 b=hBOxAo5+Gin97OGb/CKeRIndZdBIEnrD0eDw6q8o92N9G4Ir+GlW573sxTAGo9sgHO
 Mpd9ujJLSmTjdIYbORx5n6nvceFgSk2T0zkXup5LXnvxXvZVSdcfSDf0o2ETI3EYC1sX
 Lme+STdeANRYvXR9wdUxZsk1DLCpXc2hb+NFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890194; x=1693494994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yDzePQqbeAxTLEZMPVIUN8JJZ7XmywsYstjTpAYpbg=;
 b=KtnpJAB3WMoIkuWFWojZ1VnnOAB1LlLixPJM9Ex6hYmnJY4iV5IJjQToNzXYOJp8eO
 I+NYNtFpo6jJ9flneKjHawosnzmI4MyKTd14wIwB+JlV0DtcGcZ5/irTdRGusoyZomYN
 cAiLrzn2XMPcruc645TzIV8UKLJaB5JCkX+MH2/bsDWFKCUNs5E3cFXrQUyAd5OzvvER
 Q90vqqAFrtL2j4GIcKJPGzW2MHAUk65/qemPner4K1oWKq3Lmxh4WlvIp9jln5Wlb4OR
 Xu4EahoTvoNxniSr/8eetBtRFpZtuCxJntQ0KXR6Kp3alaerjETdFIuF4fr1aenNvhN3
 GN9w==
X-Gm-Message-State: AOJu0Yz3bxP4bJKhvS+husgEFuhd69o5u3RqG3mnOyMZLgU+0eNA5Sw9
 k/Ov8HL0i3SdL9oUdY+6tRbHIw==
X-Google-Smtp-Source: AGHT+IGV/UNEHmgJDhK7/yM5nP1gOAH0AA9+0LaBZzwihPJrL221HjJmDGVlmd3zP+6cOELE8VhS5Q==
X-Received: by 2002:a81:72c1:0:b0:577:606c:284b with SMTP id
 n184-20020a8172c1000000b00577606c284bmr14881680ywc.16.1692890194139; 
 Thu, 24 Aug 2023 08:16:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 j80-20020a819253000000b005845e6f9b50sm3976840ywg.113.2023.08.24.08.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:16:33 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:16:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
Message-ID: <20230824151631.GZ3953269@bill-the-cat>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824133814.GH3953269@bill-the-cat>
 <CAPnjgZ1oY9SRWNj9RUe2L8=1ndE2LfxkmqqEj-MNtxL_ff-QyQ@mail.gmail.com>
 <20230824144535.GP3953269@bill-the-cat>
 <CAPnjgZ3Xh0HY3psNbWSZViLgECuDSfdg1zmh7c=OsaiL4a_TjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hv5hEJT3DG7Uio3R"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Xh0HY3psNbWSZViLgECuDSfdg1zmh7c=OsaiL4a_TjA@mail.gmail.com>
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


--Hv5hEJT3DG7Uio3R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 08:49:36AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 24 Aug 2023 at 08:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 08:41:21AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 24 Aug 2023 at 07:38, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 23, 2023 at 09:02:53PM -0600, Simon Glass wrote:
> > > >
> > > > > In this early stage of using binman to produce output files, we a=
re mostly
> > > > > seeing people using common extensions such as '.bin' and '.rom'
> > > > >
> > > > > But unusual extensions appear in some places.
> > > > >
> > > > > We would like 'buildman -k' to keep the build outputs, but this i=
s hard if
> > > > > there is no consistency as to the extension used.
> > > > >
> > > > > This series adjusts binman to enforce just 4 extensions for outpu=
t images:
> > > > >
> > > > >    .bin
> > > > >    .rom
> > > > >    .itb
> > > > >    .img
> > > > >
> > > > > Other extensions will produce an error. With this rule observed, =
buildman
> > > > > can keep the required files.
> > > > >
> > > > > Some patches are included to fix up some easy problems. But the f=
ollowing
> > > > > boards generate 'custMpk.pem' and it is not clear how to fix this=
, so I am
> > > > > asking for help from the maintainers:
> > > > >
> > > > >    am62ax_evm_r5 am62x_evm_r5 am64x_evm_r5 am65x_evm_r5
> > > > >    am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc am65x_hs_evm_r5
> > > > >    j7200_evm_r5 j721e_evm_r5 j721s2_evm_r5 verdin-am62_r5
> > > > >    am62ax_evm_a53 am62x_evm_a53 am64x_evm_a53 am65x_evm_a53
> > > > >    am65x_hs_evm_a53 j7200_evm_a72 j721e_evm_a72 j721s2_evm_a72
> > > > >    verdin-am62_a53
> > > > >
> > > > > It looks like the .pem files are listed as top-level images, e.g.:
> > > > >
> > > > >    &custmpk_pem {
> > > > >       filename =3D "../../ti/keys/custMpk.pem";
> > > > >    };
> > > > >
> > > > > but if the only objective is to pick up an existing file, it is b=
etter to
> > > > > set BINMAN_INDIRS to include that directory. Also we should only =
have
> > > > > simple leafnames in the 'filename' property, so the '../../ti/key=
s' is not
> > > > > correct. It makes it harder for people to get the files from othe=
r places.
> > > > > Making this easier is one of binman's goals.
> > > > >
> > > > > Most likely the custmpk_pem node can be removed and the .pem file=
 can be
> > > > > included directly in the place that needs it, e.g. by adjusting t=
he
> > > > > ti-secure-rom etype (or ex509_cert) to use tools.get_input_filena=
me() when
> > > > > reading the key file.
> > > > >
> > > > > For example, this:
> > > > >
> > > > >    custMpk {
> > > > >       filename =3D "custMpk.pem";
> > > > >       custmpk_pem: blob-ext {
> > > > >          filename =3D "../keys/custMpk.pem";
> > > > >       };
> > > > >    };
> > > > >
> > > > > is really just copying a file from '../keys/custMpk.pem' to 'cust=
Mpk.pem'
> > > > > so is equivalent to:
> > > > >
> > > > >    custMpk {
> > > > >       type =3D "blob";
> > > > >       filename =3D "custMpk.pem";
> > > > >    }
> > > > >
> > > > > (note that blob-ext implies that the blob may be missing, so blob=
 is a
> > > > > better choice, since the key cannot be missing)
> > > > >
> > > > > The fact that the .pem files are at the top level means that they=
 are
> > > > > output images, which surely is not intended. They should be burie=
d in the
> > > > > image description, at a lower level, as part of something else.
> > > > >
> > > > > So please take a loke at the above and see if the binman descript=
ions can
> > > > > be reworked slightly to follow these new rules.
> > > > >
> > > > >
> > > > > Simon Glass (6):
> > > > >   binman: Require image filenames to have certain extensions
> > > > >   buildman: Keep all permitted output files
> > > > >   buildman: Show progress when regenerating the board.cfg file
> > > > >   buildman: Start the clock when the build starts
> > > > >   kontron_sl28: Use u-boot-update.bin instead of u-boot.update
> > > > >   stm32mp15: Use u-boot-spl-stm32.bin instead of u-boot-spl.stm32
> > > > >
> > > > >  .../dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi   |  2 +-
> > > > >  arch/arm/dts/stm32mp15-u-boot.dtsi             |  2 +-
> > > > >  doc/board/kontron/sl28.rst                     |  4 ++--
> > > > >  doc/board/st/stm32mp1.rst                      | 18 +++++++++---=
------
> > > > >  include/configs/stm32mp15_dh_dhsom.h           |  2 +-
> > > > >  tools/binman/binman.rst                        |  5 +++++
> > > > >  tools/binman/etype/section.py                  |  3 +--
> > > > >  tools/binman/ftest.py                          | 12 ++++++++++--
> > > > >  tools/binman/image.py                          |  9 +++++++++
> > > > >  tools/binman/test/022_image_name.dts           |  4 ++--
> > > > >  tools/binman/test/311_bad_image_name.dts       | 17 ++++++++++++=
+++++
> > > > >  tools/buildman/boards.py                       | 15 ++++++++++++=
---
> > > > >  tools/buildman/builder.py                      |  3 ++-
> > > > >  tools/buildman/builderthread.py                | 11 +++++++----
> > > > >  tools/buildman/control.py                      |  3 ++-
> > > > >  15 files changed, 81 insertions(+), 29 deletions(-)
> > > > >  create mode 100644 tools/binman/test/311_bad_image_name.dts
> > > >
> > > > This doesn't seem to address the ones I pointed out on IRC as being=
 the
> > > > first order (to me anyhow) problem of needing the _unsigned files o=
n the
> > > > platforms you list above for PEM files.
> > >
> > > I think it should be xxx-unsigned.bin instead of xxx.bin_unsigned
> >
> > As I was saying on IRC, you need to make that change then, if we're
> > going to go down this path, before v2023.10 is out.
>=20
> Yes I can do that one...but I am stuck on the PEM files so need the
> maintainer there to figure out what is up, as described in detail in
> the cover letter.
>=20
> >
> > And to repeat what I said inside another part of the thread, the u-boot*
> > glob is hiding other "arbitrary" extensions that we've had in-use for
> > forever.
>=20
> Yes, understood. Do you think that is a problem? I should improve the
> docs for buildman -k too.

Well, I'm not convinced that just extending the list in 2/6 isn't
better.  What this series does is say "anything that's not prefixed with
u-boot can only have a few suffixes, for CI".  Since most people still
aren't going to use buildman instead of make, to build things.  It'll
just be maybe-feasible for some other cases now.

--=20
Tom

--Hv5hEJT3DG7Uio3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTndE8ACgkQFHw5/5Y0
tyyHYwwApJaxvNSjzjxChGe7GgYuTEA3+5HyEzM5rKqQ0W76O0nghQacQUgzBa3S
QbqdqcH5n2R/bede6wQcn//dI1/PwImNNAV7iL0JDMynv7JFaniXy2F8xHR1V1H0
o4AL73YUiH0uzpi03Ix7gLOreB2lbPN04wQi8S2phzi9HrB9MUxo8+5UB1uNRhWH
CZvuzKx1cWZ646YEr1T1r3VwKvD46ySghtaM9kQqio7bLrsp3+cl5xaw5Y9+96DX
uBX/es05KyKOb2jxMZPLZJW2aIDNSiNAdcfnHzFLa/ifqNsbHy1rMjs1Cc9XH0wB
AamiCakvyTltTkcUeAQixEyWSb1TdE2CCtPbF/Fk26d+uzgB4uhhGceZfxZEEazN
Bxgyu7YuAq1U8SwsBqzzvIgZBRDKq+wLTYLQ+fJMkpkVoNQNja2/W5FrFksdtgp2
U9yjHSab+1EXQ2UjdNlNm7WDvuZXcbxX1cXVS5MsMu6HcSLWudYebEUwfxWWfHJ/
UnuFSIs3
=xWOF
-----END PGP SIGNATURE-----

--Hv5hEJT3DG7Uio3R--
