Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC20EFEDA17
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0E384106;
	Wed, 18 Mar 2026 02:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sbFZ+nq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46BF84118; Wed, 18 Mar 2026 02:44:51 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F36A84105
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 02:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4be94eeacso7177752a34.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773798288; x=1774403088; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q/uNF/U970vH+RAveqSJeaai4QSNTLqnm6PIOQaoyrU=;
 b=sbFZ+nq7YrdMnE95Xkxr/MKWIPRsPDRtPcTK//LJjG21kaiNXSkS2SxMOEuBgajGb3
 bY+A0I0YyJESJIuGnLkCworTvVhFPYX97A+Ra7jbp4sGVTcwDK7gT/jyS1r/R7n66uTT
 cEiJ/GAzla4l9sGLxJQHFR2vQ4siSYIHinswI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773798288; x=1774403088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/uNF/U970vH+RAveqSJeaai4QSNTLqnm6PIOQaoyrU=;
 b=dkSoOBdYgrZgDetYluKPxexYQrRUijAEt/mdgBIvnMeLgdLi6i/LLwRlGie3SzkG6S
 dlGcHbs/o02k/LWR0JBDKamLpbtrjVoCFdCofwTvV54Z3A1S6neJZLFg16roII2z/M5j
 evUkFJKj/x8wbHli8szfenXnsy0IZCMQIV0swXq1z/4+E6bYQclIPuu64hbnQtMLZlkX
 qINc0/kb3CfgqCuDP2odxDzanxM3Rim1GYxJPHXU6xQLV/cVx42oomTg952GkHCu56SB
 WpmJzcf6MGRApJDlajmGbWAXcamBoUEi/Pt/FJxgsnz468tNjfincugH0oz+tXE3wbPd
 jFYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+IGUMRKD0i3tH5WP33ASIToxrIVWhE3y1hAODnd2HA63KXAzZEjumMNruWeTWfyY5ddam1sE=@lists.denx.de
X-Gm-Message-State: AOJu0YyCHGLBSXvOeZCM4BNtzIHXFGVuvFTP3miZfNMlZ4dm74Emchtx
 JdPhZy3p1ZecDIvdNWn44VYe8Og/6Qyk6A0KYdhd8GBZRb6L2soXs6go7ZS7jd5OqsI=
X-Gm-Gg: ATEYQzyN1OtRPwAzluHSzzs/q4fTEebFe8foz5Rg1VbW/ZVfe/vUNimxz8mX1dnkqmo
 fTOimhktarjjPGtgXp8naS7vLreTC8ZXrL6SL1Rdo+/A0/Rm+uhPtk+kGxITqM3/mqU6KgJlwtG
 ebnwfk+setOGFt2kzZCIgMXiVyPT21advbXNd6BOAyAjDJmOVpAicOVP/aRQG2N86oU3EQKJGw9
 wzTk4sYxBSD1+DwFlcjPlTRp61lJ3H9zrZoT6lFCmJ26MdQRwfx3hxXNpioE5lQ1KscQbHeQkiY
 s+gegAuEDPylRsdRqzHvcF042K4gAA/lpwTKZRHYgGfuadl90uiexcBty8heca4YnAn72B4v66e
 /piwQZqB/IUuUkaDk5dRB6gyAUOV1aEBwPBTmTFwlXQ1998bHApJlZR8Zuh5WtATiIghkUyvPWL
 bFnHQfUxLyMzRJH9a8GteFwsoPCHthMUcEZVhHEuesRKLtATgOxLCl5nA59qzpBreG6oZFaTe4C
 E1/fer0bNFeaN12HFA8GRHBDHWqrreoF6UmGZa4BSSSoj9Q
X-Received: by 2002:a05:6830:6abc:b0:7d7:5d69:819d with SMTP id
 46e09a7af769-7d7ca866b40mr1191450a34.34.1773798287671; 
 Tue, 17 Mar 2026 18:44:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c998fd30sm1047858a34.12.2026.03.17.18.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:44:46 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:44:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH v2] binman: add CST backend selection for i.MX8M signing
Message-ID: <20260318014444.GI502704@bill-the-cat>
References: <20260213192838.157084-1-marex@nabladev.com>
 <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
 <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
 <CAFLszTgNA1xmMNH=qtaKurDZdFW3dscMwwKyQ7iU-7EMMDOAuQ@mail.gmail.com>
 <20260317140918.GZ502704@bill-the-cat>
 <CAFLszTha9TbXVyRt8yS8i4_Xm6WZ8MQVF3aTB6W-uq99Xn6S3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e3DVRI1sl6QfeHjZ"
Content-Disposition: inline
In-Reply-To: <CAFLszTha9TbXVyRt8yS8i4_Xm6WZ8MQVF3aTB6W-uq99Xn6S3w@mail.gmail.com>
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


--e3DVRI1sl6QfeHjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 06:10:39PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Mar 2026 at 08:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 06:28:47AM -0600, Simon Glass wrote:
> > > +Heinrich Schuchardt
> > >
> > > Hi Marek,
> > >
> > > On Fri, 13 Feb 2026 at 19:51, Marek Vasut <marex@nabladev.com> wrote:
> > > >
> > > > On 2/13/26 9:20 PM, Simon Glass wrote:
> > > >
> > > > Hello Simon,
> > > >
> > > > >> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc=
/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > > >> index 1bea091344d..a3ebd397d82 100644
> > > > >> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > > >> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > > > >> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable usi=
ng either DT properties or environment
> > > > >>   variables. The following DT properties and environment variabl=
es are supported.
> > > > >>   Note that environment variables override DT properties.
> > > > >>
> > > > >> -+--------------------+-----------+-----------------------------=
-------------------------------------+
> > > > >> -| DT property        | Variable  | Description                 =
                                     |
> > > > >> -+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > > > >> -| nxp,loader-address |           | SPL base address            =
                                     |
> > > > >> -+--------------------+-----------+-----------------------------=
-------------------------------------+
> > > > >> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_tab=
le.bin                               |
> > > > >> -+--------------------+-----------+-----------------------------=
-------------------------------------+
> > > > >> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF=
1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > >> -+--------------------+-----------+-----------------------------=
-------------------------------------+
> > > > >> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG=
1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > >> -+--------------------+-----------+-----------------------------=
-------------------------------------+
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| DT property        | Variable    | Description               =
                                       |
> > > > >> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > > > >> +| nxp,loader-address |             | SPL base address          =
                                       |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_t=
able.bin                               |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key C=
SF1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key I=
MG1_1_sha256_4096_65537_v3_usr_crt.pem |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,fast-auth      |             | enable fast authentication=
 method                                |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key S=
RK1_sha256_4096_65537_v3_ca_crt.pem    |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,unlock         |             | unlock CAAM in SPL        =
                                       |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default =
is 'ssl', or selectable 'pkcs11'       |
> > > > >> ++--------------------+-------------+---------------------------=
---------------------------------------+
> > > > >
> > > > > Perhaps point to an example?
> > >
> > > Sorry I missed this earlier.
> > >
> > > >
> > > > Example of what ? Two lines below, there is an example of using tho=
se
> > > > env vars, see the entire file.
> > >
> > > Yes I see it, but it doesn't have CST_BACKEND right?
> > >
> > > >
> > > > >>   Environment variables can be set as follows to point the build=
 process
> > > > >>   to external key material:
> > > > >> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> > > > >> index 8922d6cd070..29bc778d0e5 100644
> > > > >> --- a/tools/binman/entries.rst
> > > > >> +++ b/tools/binman/entries.rst
> > > > >> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg =
file generator and cst invoker
> > > > >>
> > > > >>   Properties / Entry arguments:
> > > > >>       - nxp,loader-address - loader address (SPL text base)
> > > > >> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> > > > >> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096=
_65537_v3_usr_crt.pem
> > > > >> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096=
_65537_v3_usr_crt.pem
> > > > >> +    - nxp,fast-auth - enable fast authentication method
> > > > >> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_6=
5537_v3_ca_crt.pem
> > > > >> +    - nxp,unlock - unlock CAAM in SPL
> > > > >> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or =
selectable 'pkcs11'
> > > > >>
> > > > >
> > > > > The way it works is you add this as a comment in nxp_imx8mcst.py =
and
> > > > > then run 'binman entry-docs' to generate entries.rst - see here:
> > > > >
> > > > > https://docs.u-boot.org/en/latest/develop/package/binman.html#ent=
ry-documentation
> > > > Why is there this entries.rst then ? Should the entries be removed =
=66rom
> > > > here and moved into the py file or what is this inconsistency ?
> > >
> > > The entries.rst file is there so that the documentation can be build,
> > > containing it. It might be possible to update 'make htmldocs' to run
> > > binman to update the generated docs.
> > >
> > > Heinrich, what do you think about that?
> >
> > That won't work for readthedocs, it needs to be generated, if it can, as
> > part of the normal sphix build doc process.
>=20
> Hmm that's a bit of a pain. We don't really want to run binman from
> sphinx. I could create an Sphinx extension to create the entry and
> bintools docs, perhaps?

I'm not sure of the best way to solve the problem of generating this
file on-demand, so it doesn't get out of date (nor edited directly
again). I just know that in addition to the CI targets we need for
readthedocs to do it automatically as well.

--=20
Tom

--e3DVRI1sl6QfeHjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaboDiAAKCRAr4qD1Cr/k
CiUQAP91iz6CXc2WskRRDn5sJ7/0EPZCjdH9+gdKJfyptjc9+QD/VUkYzYwtZHd7
CjxvVy7KLtw0B2HgjVyPT+k9kxcL4AY=
=Z9mw
-----END PGP SIGNATURE-----

--e3DVRI1sl6QfeHjZ--
