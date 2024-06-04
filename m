Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627F5C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 17:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9569B88400;
	Tue,  4 Jun 2024 19:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSbrEkNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB9888414; Tue,  4 Jun 2024 19:09:11 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE0A8839D
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 19:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f8da5e4850so3061888a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717520948; x=1718125748; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BPKCg7bCA/5sgekmDJgW/4UTPgsUl/fUxzeQAqmIDCY=;
 b=GSbrEkNnrqDisySZmsp1qQvYx5ts9IUjmkcMgBHXIqGZtdOzz3ghtzja4rpeMAp28b
 kUjt8DZ6tfgy7p8zP+rtWMH6oOqs1GAwniqe2GMAuKO2RFM7/Kd8kjauiR+gpoAqYjPM
 3i6Rj5b82y+UeQ5xkgG9Qupf0/QLchZ63ZOBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717520948; x=1718125748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPKCg7bCA/5sgekmDJgW/4UTPgsUl/fUxzeQAqmIDCY=;
 b=ksiOOB6cv5Ju5qpHtxCIbOwP3BRckX1xKhllgFHG9zk1v7WbwqV9wY9mcN60cFrnkm
 JCqw1juhvT24jF25+OEuXpx7rLiNh6asfbBxZ+yaUygwSLdQ7aJT7Eh5Jpx0WvxtuejZ
 P4ViIQSQgEtP94UnAFh1MO7c7392+INYYMTSGHH0HvMf+Z3MIiQoEtcCufqa3ZOhhkth
 56UXuJMvTRvMube0oRgu8GberbSmW/IT6JwXZGgxJ+BOCMMcMI9o5BIxht+7plECl08j
 EjGRW0GcVGdZWrIEE0+NVTA74TQ8x5EmICe7M+4i9zL6lis2+FFF1jmmBAnGvkdtS7OT
 8B2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaFVs32xBdPFjCgje8W37RnDMFXTjQrXS/hZYmisR87d13YIaHKC1VtvLEXUzsViBCkrBJyKi20ArgCmOdNlwS2g29IQ==
X-Gm-Message-State: AOJu0YxzXlH6xuOP2Z3wMSML+T/RrARK/J05qfLpF3strLG9+3Ut/l7H
 pnJQLGTsLenO0g1X51dKVM/RcCrqgQlBR68PF2dKkpzk6IRA9wd0Z6Wc4WfcApY=
X-Google-Smtp-Source: AGHT+IFMXzhDgjs9BbCqHLJsA+wBjG/NqTpm2S2Y8nGTzZJAubTLsUmznBz8HejRg9txRib6elt6lg==
X-Received: by 2002:a05:6870:2499:b0:24f:e75d:32ec with SMTP id
 586e51a60fabf-25122a6c64emr114050fac.46.1717520947646; 
 Tue, 04 Jun 2024 10:09:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25085226dccsm3381517fac.37.2024.06.04.10.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 10:09:07 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:09:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] LoongArch initial support
Message-ID: <20240604170905.GL68077@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240523152540.GR2568172@bill-the-cat>
 <36b2a4a8-9a37-44b8-9630-bb48a862e60d@app.fastmail.com>
 <20240523154317.GT2568172@bill-the-cat>
 <ce9d23a2-d273-4493-83dd-ef565cbc1c44@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RHp3AFHlcK4ueDYN"
Content-Disposition: inline
In-Reply-To: <ce9d23a2-d273-4493-83dd-ef565cbc1c44@app.fastmail.com>
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


--RHp3AFHlcK4ueDYN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 11:50:20AM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=884:43=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, May 23, 2024 at 04:38:52PM +0100, Jiaxun Yang wrote:
> >>=20
> >>=20
> >> =E5=9C=A82024=E5=B9=B45=E6=9C=8823=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=
=8B=E5=8D=884:25=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> >> > On Wed, May 22, 2024 at 04:34:43PM +0100, Jiaxun Yang wrote:
> >> >
> >> >> Hi all,
> >> >>=20
> >> >> Sorry for flooding the mailing list recently, yet another huge RFC =
series ahead.
> >> >>=20
> >> >> So after working on MIPS, arm64be and Xtensa I'm now on LoongArch, =
as suggested
> >> >> by=C2=A0Heinrich.
> >> >
> >> > My big feedback here, and it applies to all of your other series as
> >> > well, is to please update CI to make use of and test this. On the Do=
cker
> >> > side, update tools/docker/Dockerfile as needed. For Azure, you can t=
ell
> >> > it to use a different image and then follow the documentation on
> >> > https://docs.u-boot.org/en/latest/develop/ci_testing.html and for Gi=
tLab
> >> > you can at least use their "linter" to make sure that your additions
> >> > have the correct syntax. Thanks.
> >>=20
> >> Hi Tom,
> >>=20
> >> Thanks for the feedback, I thought CI is for custodians only :-)
> >>=20
> >> Do you mean I should include azure/gitlab pipeline file to create
> >> pipeline for those new qemu targets?
> >
> > Yes, just like the rest of the QEMU targets.
>=20
> Hi Tom,
>=20
> I've got CI working on azure-pipeline for my arm64be, xtensa and LoongArch
> work.
>=20
> What is the best way to submit all these changes? I think I can send patc=
hes to
> update Dockerfile and CI hooks first, then after new docker image being b=
uilt
> I'll combine CI related changes into these series and refresh all those s=
eries.
>=20
> Will it work for you?

Yes, please do a series that updates the Dockerfile and CI yaml files
(do your best to update .gitlab-ci.yml as well, I'll fix it up if
needed). Then say the other series depend on that previous one being
applied. You can post an RFC patch or what have you that just changes to
pointing at your test images instead and so long as it's a stand alone
patch it's easy to drop. Thanks!

--=20
Tom

--RHp3AFHlcK4ueDYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZfSi0ACgkQFHw5/5Y0
tyy6bwv9HQTjqpiicxv+mV3TlBhEJEjYz+olKic9GGyi6VI7XTEzKinwCLHlaiP0
iOcYU9rcaaY90fJ7pJWYdcbIbV89vebEul2VPBEdqPOR3nWHybTo4q0umAmSktRf
Rroc48On/sQNSVyQAGnKDA7sln1W6Kql6BeeVrumi7PzoJGIIVcbC/j2ZIchZRC6
E7XUxJ5O9VrajnAF37vfOlDDLAIsUQ8RYToGEiWPaD17key1lAqiRUbp9b/UCJJS
dy6aToHli8/rnVCMaXrNZzV2j6OpQm/4K2NGyHzHdb5LbuXPt/kQ+yc091TMuyyn
p+yGKvk8xdoSOFXibE82dKgB/yKYvvuLyIceqjiBADROWOwKd/aredr9mC67cvZ5
zKH8YOVTmw/mAhWkRjlWlMzItZJkqYC/3Ll4bcUBdnuFoRk9WCthSJzadsMu/wpx
gNBrfFpT8FdHGivy6jQRaBs7Y3YmhuE/TQ9lqfANEgUWx6S/6dz9LwYjY7SPOulH
w5GeNCzO
=pN9j
-----END PGP SIGNATURE-----

--RHp3AFHlcK4ueDYN--
