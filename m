Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0375C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 13:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3201835B6;
	Thu, 10 Jul 2025 15:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="csJK25gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D7D835C0; Thu, 10 Jul 2025 15:54:01 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EDE83599
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4067ac8f6cdso645267b6e.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752155638; x=1752760438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mAe65GTZcvPpdB37qZzuTvtGqcgxazKRGSSVASYnUs0=;
 b=csJK25gs5JzQ7oIoattNojnzIp8DCtfS8RtkUT3S93dnt2rPlQq7dKGbmoUSpVpprB
 SkBdWqWU1DyJq6oerNEMQ8pvUl+ES6MZx3sn5xb71eodOABtZ+QFJ0sDH4Q+gVTcm4Mz
 q2G2Q1SWFh3W2TT2vGPLIFSQbr+YOZgtm2cao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752155638; x=1752760438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAe65GTZcvPpdB37qZzuTvtGqcgxazKRGSSVASYnUs0=;
 b=DMJ8+pPmliFIsEBrNJ1aq2t/+wfFSlUbe8CeHX8h8DIIVbKkcv2jwKWykEokZx3rcO
 VeDJx0WTzdWDtZsgqNzk7OZodGvG2DhkJgWdUleDS6cUvG+QLEahQWwEJO0qsBJkLE/f
 pc3la5aUG/Ij6L+mzi3TzsgSRzllTIVX/n7CEsSFm4TI5UZPv1omOWQ6CRznQgFPr/4D
 0qwVzkyAtTPX+52lvcGvCNEuEvX13k+OadlZEvCDL4YmbqYtbPnyLJ6UyhLL03oUXOqg
 bSymc3Up7XBj0q2drmOxT/oibXUGBCbeu5irEuH0zTf3n+rDlWe679/EAOZyjngjN1Q6
 6ylA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb9UeJBoymyYyU1EY7C6t/EPKYUxxmcl7zmjpS58bb5yih1OZhmi2GQAPpgHMp1BRpcOJrFdI=@lists.denx.de
X-Gm-Message-State: AOJu0YwyoPTz+pYl8hkO/aSI1q6gedJqqYUoL5Wff5U2OgT6VN0AR9Mr
 BPcU2FKiSNnQrsoVisSyPqBWDTYPSb3JWyvkQ2qn2r+VDfZBe1jKr2iVF9MCmHsfj/o=
X-Gm-Gg: ASbGncvxQ6y4lBbQoBGHF5jhheIoFnUbi29095XJP+MzXPcoIQ7pg21TKufFjA7cDr5
 m6Z+YCGvRLryDLq7wzAl0Hg4Tfnf9X5zE5hyIiVAzxoSDO3jUsvZtWlEyrDn5ypw653qXi35Sw1
 mueJZ95ztT/3dUHhPY7OiRFYpEHCqMn1kh7su34ukK1x3X85naFiHXhYBIcnVats/+yKNWwkUtB
 sol4jksTud5K8tW0MSgW3XG3fAmqSsI+08Lz7Cq6eUNY/kCV4QnlxGLY7bZrRyf8ZhMzMz9n8Hx
 7WqnxQSLhlzWy2CYv/B2GuFqpqu7f1H/ZsuKe7/+bXMdcoxcRI0vl+QmE7d3uOnUnImcbsMS7na
 CU+r3KtGOVPiJ9Mo4ogqN
X-Google-Smtp-Source: AGHT+IFqOR2euMxAOs/6MqMANYWHP9xVz9J6XJl8yCVmeYqlmh0qY8th/PTsBLodBg+PVmsPYM00TQ==
X-Received: by 2002:a05:6808:2385:b0:409:f8e:72a6 with SMTP id
 5614622812f47-413f39816f3mr2149791b6e.1.1752155637576; 
 Thu, 10 Jul 2025 06:53:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41418c0ae9bsm208795b6e.6.2025.07.10.06.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 06:53:56 -0700 (PDT)
Date: Thu, 10 Jul 2025 07:53:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Yannic Moog <Y.Moog@phytec.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/6] binman: rework dropping absent entries from
 packaged image
Message-ID: <20250710135354.GZ6424@bill-the-cat>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <20250613-binman_faked_optional-v3-3-1e23dd7c41a2@phytec.de>
 <CAJ+vNU2o3jtSMaUTd_1xms7QeAdJwTyy8Q+UiKQC56rCwk2G6g@mail.gmail.com>
 <ccf0d5863d8505336a43524d7b871338db16fc3d.camel@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iGwnuOFSltSTvinA"
Content-Disposition: inline
In-Reply-To: <ccf0d5863d8505336a43524d7b871338db16fc3d.camel@phytec.de>
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


--iGwnuOFSltSTvinA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 05:53:22AM +0000, Yannic Moog wrote:
> Hi Tim
>=20
> Am Mittwoch, dem 09.07.2025 um 10:50 -0700 schrieb Tim Harvey:
> > On Fri, Jun 13, 2025 at 5:04=E2=80=AFAM Yannic Moog <y.moog@phytec.de> =
wrote:
> > >=20
> > > When blobs are absent and are marked as optional, they can be safely
> > > dropped from the binman tree. Use the drop_absent function for that.
> > > Rename drop_absent to drop_absent_optional as we do not want to drop =
any
> > > entries that are absent; they should be reported by binman as errors
> > > when they are missing.
> > > We also reorder the processing of the image the following:
> > > - We call the CheckForProblems function before the image is built.
> > > - We drop entries after we checked for problems with the image.
> > > This is okay because CheckForProblems does not look at the file we ha=
ve
> > > written but rather queries the data structure (image) built with binm=
an.
> > > This also allows us to get all error and warning messages that we want
> > > to report while avoiding putting missing optional entries in the final
> > > image.
> > > As only the blobs are dropped, the sections still remain in the
> > > assembled image. Thus add them to the expected test case checks where
> > > necessary.
> > >=20
> > > In addition, a rework of testPackTeeOsOptional test case is necessary.
> > >=20
> > > The test did not really do what it was supposed to. The description s=
aid
> > > that optional binary is tested, but the binary is not marked as
> > > optional. Further, the tee.elf file, when included in the image
> > > properly, also shows up in the image data. This must be added as well.
> > >=20
> > > As there is no global variable for the elf data, set the pathname to =
the
> > > elf file that was created when setting up the test suite.
> > > For the test case get the filename and read the contents, comparing t=
hem
> > > to the contents of the created binman image.
> > >=20
> > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > ---
> > > =C2=A0tools/binman/control.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 5 ++---
> > > =C2=A0tools/binman/entry.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 6 +++++-
> > > =C2=A0tools/binman/etype/cbfs.py=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > > =C2=A0tools/binman/etype/mkimage.py |=C2=A0 2 +-
> > > =C2=A0tools/binman/etype/section.py | 16 ++++++++++++----
> > > =C2=A0tools/binman/ftest.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 14 ++++++++------
> > > =C2=A0tools/binman/image.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 ++
> > > =C2=A07 files changed, 32 insertions(+), 16 deletions(-)
> > >=20
> > >=20
>=20
> [...]
>=20
> > > diff --git a/tools/binman/etype/section.py b/tools/binman/etype/secti=
on.py
> > > index
> > > 1d50bb477534702019502d08f8648d4c9a367c0f..03c4f7c6ec74c6fa75c9362e2fe=
cdb0e6a
> > > b568cb 100644
> > > --- a/tools/binman/etype/section.py
> > > +++ b/tools/binman/etype/section.py
> > > @@ -537,7 +537,7 @@ class Entry_section(Entry):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for entry in self._e=
ntries.values():
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 entry.WriteMap(fd, indent + 1)
> > >=20
> > > -=C2=A0=C2=A0=C2=A0 def GetEntries(self):
> > > +=C2=A0=C2=A0=C2=A0 def GetEntries(self) -> dict[str, Entry]:
> > > =C2=A0
>=20
> the problem is that I forgot to "packport" typing support for older python
> versions < 3.9.
> Thank you for bringing this to my attention.
>=20
> >=20
> > Hi Yannic,
> >=20
> > This series just got merged to master and I noticed it failing
> > building imx8mm_venice on my Ubuntu 20.04 dev host which has Python
> > 3.8.10.
> >=20
> > make imx8mm_venice_defconfig
> > make
> > ...
> > =C2=A0 BINMAN=C2=A0 .binman_stamp
> > binman: 'type' object is not subscriptable
> > make: *** [Makefile:1336: .binman_stamp] Error 1
> >=20
> > Do you know what the minimum version of python required is or what
> > would need to be changed here to support the previous version of
> > python that worked?
>=20
> Absolute minimum version is 3.5. That is when typing got introduced.
>=20
> Quoting from binman pyproject.toml:
>=20
> > description =3D "Binman firmware-packaging tool"
> > readme =3D "README.rst"
> > requires-python =3D ">=3D3.7"
> >=20
>=20
> But there has been a patch that tried to make binman work for 3.6.
> de65b122a2534 ("tools: Fall back to importlib_resources on Python 3.6")
>=20
> Should I create a solution for python >=3D 3.5 or >=3D 3.7?

I think we should aim for >=3D 3.5, since the toml file is out of date if
someone else fixed it for 3.6 (and so I assume some other LTS distro
uses 3.6). Thanks!

--=20
Tom

--iGwnuOFSltSTvinA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhvxe4ACgkQFHw5/5Y0
tywUFwwAl+CyADVyqINEDqbnQGMaIahSgA8bsX+MCFY6tcNXLswQn1QYJYoGJxc8
hlqQbfY3xr8FQVplurIVFqgJ5S5tFRC/r0HkNrVqr6wXInaeh3EGnl8RMCbF/aaQ
9XYIY2NXCvGNUM6C7G4MuTmHaUBcmY5DV5L6RF0a1sPdQT/MChr9VOn35L+EILlx
YSq8gjssT6f3IBj4mu1WGPKdZGKJW/NoAJekcqjsvHA1C8TbmZR44eqaZkFh3RJ+
tiAJ1rVhH2T1Zf7bVQ/ddj7pYScrFnKAAvsJFTFyQFf1lx6Z2b66fJE98lnOhJ/B
6ADXlZFbDRuC4Vy9cWLNDl0sSLZMaUetMdZ+rTTHXVBuDZ9r2IIxYp9l4s5IjXDt
fU0BldP4sxmLWoZ7siILKx09DewmorzoNIxHWqjcOj9PUwJABKlZI3Fl56X2hcri
KD3OywvZ/CwhgFiqxmQUaEKCs3FiNgwmrGBXJvucnwe0vRprI7HKRd6NqCo0JWXy
HhDxxxs/
=NAu9
-----END PGP SIGNATURE-----

--iGwnuOFSltSTvinA--
