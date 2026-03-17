Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D400FD877B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D29184358;
	Tue, 17 Mar 2026 15:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F8ri/6cH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AC084006; Tue, 17 Mar 2026 15:09:25 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FDC84358
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4042fe53946so2202353fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773756561; x=1774361361; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PthJ0R2DWYbi+x/lqWtia45XLwN5P4Db/fehjfOJBjA=;
 b=F8ri/6cH15zmc4cw1NpuEb7zM3bQrd0nPGhB6Xbgbark3oPYo1txEvHtfbYJOmFX8X
 wgaWVFTfxxW13vQ6rno3AeJ2zn2+7aWFSz0Qc9z0n2VlkIW5SVPr8RFnCtAHqLqmiiVI
 PT8c9MOFPDUHH16bj5SpzSAUOVAe/UwIqgBuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756561; x=1774361361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PthJ0R2DWYbi+x/lqWtia45XLwN5P4Db/fehjfOJBjA=;
 b=HVkwbXMzkDYdhq5bjzmMuI29c+e0xzAE17aNBLvoa6vUrpyHoAG0DFDnUFGw1EuH4g
 plufop5083kb7l4P7M/V3Oeuk231TuuNERMFnM8S9/3K0RP5rZskmZ1vffkZ/0jHxACC
 eq8ETEzOrX9bybESVeKu7tged+bf7yUJKcoawzNVpMeQng3q1/jPdgSUba8xGWufM6bN
 qW6z2RGmxprqEYwvKMAghY82Mp0rZuCuLsW17BARwG2+9YVqV5liEPfR2uwl//BgTDp5
 OFbeOHomtQqGZ6rFwEZ98mfNdfYl0ysFmRfYBkRJeepOtMLD8ZAFLI+KqUto92AN14FE
 q4mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO/0DVlzoWTI4j7AgSjnc5cgTEgydWLmmt+xH11mEDUVL7OHtrEXapKbMwveQ/u4Nl9frc4bQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzmM3F24UVzJldH5F/fKFXAV/3KS6BO2JTgV8eCY0e/pHLYg1yF
 uXT9m/wcFqlmSr30zM6KixdbbAv18RZ4J9jf1N3H5RXkYGgeIe7ZLUc6lJSOgsIUyHM=
X-Gm-Gg: ATEYQzyEQN49FniQH2BHxySY4I1+ZLkf9qMh670R0oyXMJJEJQe5Jf3p8R72JmaHuIM
 CtSF3VFkCpZaAnfoTSuvBR9A8h+uclCg2kSeyJHYbf/I/5yu7yNzbafMojRXG100atAPhUo/RIk
 +F86YJjjyHj9m16o1bBh0XMfRIQrHvLZEwqop/O2SN0mywgKS9KgkRP3DWKb8IEjDPXwykVmAg4
 +Gacy67BxDI7UArfIiDSD3PdkQAADgsOGBuFvYEov47hvQePDR9Gb/MsP3KhJLlo2GeklvzNbg8
 71Q2N+5LRi7O64G9d+483+qh9VQyx1w4z+rYNocEMGZQtCU+HFL3igyRXOOtWowtGGytFnzeFte
 ep3qifEirH8ZDisDbQWLR5FrFZSZAadfMjsK+25/jvnOTbh1JhblV+BnaKZRlXq7jUYDGoJYhRn
 4Z4zox0dU7O3/ongHTnw9FiHY+W2iAcP/DxiXGLbJ6Iv19rzY5HgPD0awbuL+GfmnsSb5ELyxuz
 9KrxmGzrm7qM6OJHztALu6581yG3m59ndA1d+HeVCt0QJNr
X-Received: by 2002:a05:6870:7d84:b0:417:7d3:fdcf with SMTP id
 586e51a60fabf-417b943b454mr9792475fac.46.1773756561175; 
 Tue, 17 Mar 2026 07:09:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6ae0e3sm20339737fac.16.2026.03.17.07.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:09:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:09:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH v2] binman: add CST backend selection for i.MX8M signing
Message-ID: <20260317140918.GZ502704@bill-the-cat>
References: <20260213192838.157084-1-marex@nabladev.com>
 <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
 <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
 <CAFLszTgNA1xmMNH=qtaKurDZdFW3dscMwwKyQ7iU-7EMMDOAuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vao2tt4/RMym3zpG"
Content-Disposition: inline
In-Reply-To: <CAFLszTgNA1xmMNH=qtaKurDZdFW3dscMwwKyQ7iU-7EMMDOAuQ@mail.gmail.com>
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


--vao2tt4/RMym3zpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 06:28:47AM -0600, Simon Glass wrote:
> +Heinrich Schuchardt
>=20
> Hi Marek,
>=20
> On Fri, 13 Feb 2026 at 19:51, Marek Vasut <marex@nabladev.com> wrote:
> >
> > On 2/13/26 9:20 PM, Simon Glass wrote:
> >
> > Hello Simon,
> >
> > >> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx=
/habv4/guides/mx8m_spl_secure_boot.txt
> > >> index 1bea091344d..a3ebd397d82 100644
> > >> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > >> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > >> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using e=
ither DT properties or environment
> > >>   variables. The following DT properties and environment variables a=
re supported.
> > >>   Note that environment variables override DT properties.
> > >>
> > >> -+--------------------+-----------+---------------------------------=
---------------------------------+
> > >> -| DT property        | Variable  | Description                     =
                                 |
> > >> -+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > >> -| nxp,loader-address |           | SPL base address                =
                                 |
> > >> -+--------------------+-----------+---------------------------------=
---------------------------------+
> > >> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.b=
in                               |
> > >> -+--------------------+-----------+---------------------------------=
---------------------------------+
> > >> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_=
sha256_4096_65537_v3_usr_crt.pem |
> > >> -+--------------------+-----------+---------------------------------=
---------------------------------+
> > >> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_=
sha256_4096_65537_v3_usr_crt.pem |
> > >> -+--------------------+-----------+---------------------------------=
---------------------------------+
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| DT property        | Variable    | Description                   =
                                   |
> > >> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > >> +| nxp,loader-address |             | SPL base address              =
                                   |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table=
=2Ebin                               |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_=
1_sha256_4096_65537_v3_usr_crt.pem |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_=
1_sha256_4096_65537_v3_usr_crt.pem |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,fast-auth      |             | enable fast authentication met=
hod                                |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_=
sha256_4096_65537_v3_ca_crt.pem    |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,unlock         |             | unlock CAAM in SPL            =
                                   |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is '=
ssl', or selectable 'pkcs11'       |
> > >> ++--------------------+-------------+-------------------------------=
-----------------------------------+
> > >
> > > Perhaps point to an example?
>=20
> Sorry I missed this earlier.
>=20
> >
> > Example of what ? Two lines below, there is an example of using those
> > env vars, see the entire file.
>=20
> Yes I see it, but it doesn't have CST_BACKEND right?
>=20
> >
> > >>   Environment variables can be set as follows to point the build pro=
cess
> > >>   to external key material:
> > >> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> > >> index 8922d6cd070..29bc778d0e5 100644
> > >> --- a/tools/binman/entries.rst
> > >> +++ b/tools/binman/entries.rst
> > >> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file=
 generator and cst invoker
> > >>
> > >>   Properties / Entry arguments:
> > >>       - nxp,loader-address - loader address (SPL text base)
> > >> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> > >> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_655=
37_v3_usr_crt.pem
> > >> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_655=
37_v3_usr_crt.pem
> > >> +    - nxp,fast-auth - enable fast authentication method
> > >> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537=
_v3_ca_crt.pem
> > >> +    - nxp,unlock - unlock CAAM in SPL
> > >> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or sele=
ctable 'pkcs11'
> > >>
> > >
> > > The way it works is you add this as a comment in nxp_imx8mcst.py and
> > > then run 'binman entry-docs' to generate entries.rst - see here:
> > >
> > > https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-d=
ocumentation
> > Why is there this entries.rst then ? Should the entries be removed from
> > here and moved into the py file or what is this inconsistency ?
>=20
> The entries.rst file is there so that the documentation can be build,
> containing it. It might be possible to update 'make htmldocs' to run
> binman to update the generated docs.
>=20
> Heinrich, what do you think about that?

That won't work for readthedocs, it needs to be generated, if it can, as
part of the normal sphix build doc process.

--=20
Tom

--vao2tt4/RMym3zpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablgjgAKCRAr4qD1Cr/k
CtzRAQCcixgAkYI218co1ui5WdstQS3842Pjuuh9CTs6fCnULQEAyWf7domBQaVv
W/6OoYrLjK5qqlzuNGGItyeNjSn2FgA=
=P5qn
-----END PGP SIGNATURE-----

--vao2tt4/RMym3zpG--
