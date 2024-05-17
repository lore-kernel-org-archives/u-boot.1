Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA46C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 14:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2149F8818C;
	Fri, 17 May 2024 16:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cF0BLS58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05C7882CF; Fri, 17 May 2024 16:35:17 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F38287EF4
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 16:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a0b68733f5so5205616d6.1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715956514; x=1716561314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4rfKwnKtEeSjfwfJjfFFLC9erifzxv4gzUoQ4aj317M=;
 b=cF0BLS58xrJMpN8yVQJHwC/BZKjdaEdR/T9jigOZO72jvPd0/aOPh92rflZnexfBA2
 GXyrIrYjDme8fRePqsJQS0sI2J37Q5H38bPBCvOkHTmzwGbsqRNzHHo9qU9PtD9XlGdY
 ISy3eGX9eClYRIHp3Z8bYAeRWKgJvhKyFInSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715956514; x=1716561314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rfKwnKtEeSjfwfJjfFFLC9erifzxv4gzUoQ4aj317M=;
 b=r8wUCpjrZ52TNB8/4eSRjEYq8ucLTuWNjoq9xtSORkKk2vXnRb/9LeA1GhIGgJDvZn
 JZTYka6gIC4mBMG9TISHT8kiHKF9vlA3/t2NQG4yQ4N/SG6Zs5S+/TdWmLQPED1HLnwz
 6MMjROefnHZQXONx02rcvU7zqKa9vuSA7RSou7/9J2sK5Yqr2bSV+7qgL9/kn9VeuNpF
 45deK7fFCnJ2Wx34CDZQOjoEp2rS/vUYDOdLfApT6hIJ8TT6Xw3djiCHZFOnfgsvsfbC
 z+iPfOFC1011LkBG0cyvV2eXFtgQNFV8qnmy1FTan7M6EndoLF/MLyrF2GMKDZ6rNxM8
 BaCQ==
X-Gm-Message-State: AOJu0YwPf9FtSqutFcWoujw50pfpB0ub+kyPLvLynTwBs9nHCEdTCL1a
 Jq+OagLYXUlBiPKKaMztHYd9D5JuBlv2m7Wk1O9VzmvvC4wrymiXL2yR3s484PeJVtDUXyfuIqb
 aH5I=
X-Google-Smtp-Source: AGHT+IFOQ3VTLZOjT7LkpJjkz8jrRiBtaZFYw8VYj1hKdKDVBdzoyE0di49emdb+pILhPZdQabsoEQ==
X-Received: by 2002:a05:6214:5342:b0:6a0:a9c5:af85 with SMTP id
 6a1803df08f44-6a1682794aamr229285586d6.53.1715956514242; 
 Fri, 17 May 2024 07:35:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194945sm85167766d6.61.2024.05.17.07.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 07:35:13 -0700 (PDT)
Date: Fri, 17 May 2024 08:35:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/2] doc: process.rst: Document device tree resync rules
Message-ID: <20240517143511.GH2568172@bill-the-cat>
References: <20240516203416.928567-1-trini@konsulko.com>
 <20240516203416.928567-2-trini@konsulko.com>
 <364fef96-5f0a-466d-99ad-6a4310f7c2f4@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="psF/Tdk79nh/xqtt"
Content-Disposition: inline
In-Reply-To: <364fef96-5f0a-466d-99ad-6a4310f7c2f4@cherry.de>
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


--psF/Tdk79nh/xqtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 10:35:43AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/16/24 10:34 PM, Tom Rini wrote:
> > Document the logic of when we do a full resync of the device trees used
> > by OF_UPSTREAM as well as that cherry-picking is allowed as needed.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   doc/develop/process.rst | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index a66540a698c1..0542b3fc1245 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -108,6 +108,19 @@ Differences to the Linux Development Process
> >     In U-Boot, ``"-rc1"`` will only be released after all (or at least =
most of
> >     the) patches that were submitted during the merge window have been =
applied.
> > +Resyncing of the device tree subtree
> > +------------------------------------
> > +
> > +As explained in :doc:`devicetree/control` some platforms make use of d=
evice tree
> > +files which come from a git subtree that mirrors the Linux Kernel sour=
ces
> > +itself. For our purposes, we only track releases and not release candi=
dates for
> > +merging in our tree. These merges follow the normal merge window rules.
> > +
> > +In the case of specific changes, such as bug fixes or new platform sup=
port,
> > +these can be "cherry-picked" and are subject to the normal merge rules=
=2E For
> > +example, a bug fix can come in later in the window but a full re-sync =
only
> > +happens within the merge window itself.
> > +
>=20
> Can we provide an example on how to cherry-pick those changes with a comm=
and
> line?

This is covered in doc/develop/devicetree/control.rst already so I'd
rather not, in this document, which is currently just "why" we do
things. If we need full examples and not just how to use, we should
expand "Resyncing with devicetree-rebasing" in the other document I
think.

> Additionally, in doc/develop/devicetree/control.rst we say:
>=20
> """
> However, if `dts/upstream/` hasn't yet received devicetree source file for
> your newly added board support then you can add corresponding devicetree
> source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
> CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=3D<name>` when
> prompted by Kconfig.
> """
>=20
> But now we have a second option, cherry-picking upstream changes instead,=
 so
> I assume we should document it there as well (or cross-reference?).
>=20
> Looks good to me otherwise, thanks for clarifying this new process.

Thanks for spotting that part, yes, I'll go re-word that as well.

--=20
Tom

--psF/Tdk79nh/xqtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZHaxsACgkQFHw5/5Y0
tyzdBgwAiyrEHgwpLBfAB9Vyu+gVQRfPERxI0nbbOhYrSvF/m9b6Xbx/b63/jLDB
YWDT5eg0OTCI/K5rn2wYZyctrDEqjoTH1vO5TjR+nnXQyQb9pxPATuMpchZAokwX
5ASyJeVbogdnTU5oHh+rzPO4GTyOhsVBQqYCYUhT12DYaVwLPHu1x5Q9N4dqiskf
OfT6Buv+huiVGae66l0Fy4kQ/JKxE0la/PFUXIGIUzSD9Czz+jx+WHTRpW8T8NLY
f/kTYXM6+siGnFx9e7XYFhGOxkQBbxq2nsICQm1CCC6U3xlVMJklBWi0SJxqYPjb
0TPlikLL5l4AsPqijciPvgeX/C2CH34Dn7OyeYVo93FkRf1wd8C4h7vp65PagQ86
UbTeifepe4ecRJqcqV1A6ambHbTq6Ikd8OfQxb8748XystpJ6FT6sgzLjcr5EGse
+cl75uW2LaYAX48gotB4mMTkiCmvVRjzFNTpUxjQbOeZMXmySZhr9Y6oN0Sb1lBN
36kKeheS
=A7PW
-----END PGP SIGNATURE-----

--psF/Tdk79nh/xqtt--
