Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1A9CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F18846FC;
	Fri, 15 May 2026 16:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NIXBFUmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E459884705; Fri, 15 May 2026 16:12:16 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59C9846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so4376180fac.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778854333; x=1779459133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qQEne5TiJctBmVgaf6PunSkKVWTvquNki4CZYDmN8bs=;
 b=NIXBFUmG2ewB3UqhcM/+Nosq8xXcaoFfn8m3nPpTxMl5O8TB+WbWocIYCveL+kuVzl
 1y7XhS37fAJz+h+zp+JfZabDD1+nGVwP9Wezs2a8tKu3ALu4+0AJnNWQROpm6ckd35kR
 AhOxSy/Wan+3pOeYWJQmglb1p/2i4F1yhRZ1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854333; x=1779459133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQEne5TiJctBmVgaf6PunSkKVWTvquNki4CZYDmN8bs=;
 b=IiYOhW30JPkdROUK0FpYxI7gPpGGlUR8CLxS3R30zklx0e2vxwagplwHylK97A770B
 Mb/OZmJNJYSqlJeXMY+dJ438py6zNcTx0uNqMD56Gz6b+LKmWjljYRUW8/QsPLe8tRws
 wSg9gfrsCNUjY/e0WZD/7NusO6hSpfSAe+yVCUHYVd2QAcTEKfMXrHTMSVsBOpngYSSv
 +7tsvcnlIfRlRaKKYYbwxskaDxRfGJz5Fq195nQYck/womH3zMXGXTN0dnP4kJ7PDlt/
 kOLZ9fKWcBRepjwo8oJ2tl4edE6ZknNKiGJuXmP5cxLCbm8HZxpgbsyIjCIYreanDWPI
 RcJg==
X-Gm-Message-State: AOJu0YwyGKOrQHdpl7dX6NxsLyS7/QvPxr+D8mwQGW1ulk4YN5Bq1KFn
 h7dd5Mm0Acd+WEZXeKnmw4B0L5dk1K8Zow260fLVLFIjeATNxWupsUTEzy1BEqCjNcOAfsXilav
 mFGOQsf3+YdjW
X-Gm-Gg: Acq92OG8Fhpr+jDXV6DYu9rXtH/wooEcODRQ/nUKxAygM/Y+vxCk2cwuy+ER2y1jDj9
 34SaoNj662ilXSMtRKnpKP6GoNggbyJPo3K+cDYvrno7gcxgrW7J1M9aF/n2WWcyYrYbNgklb3m
 iCvCaXVO0mLQIg953sIWC2j6OtEFVL8W4itQ3a5YmrfTYQf6GM/D5kcQ6kNCeY45B8YkB5NLs34
 ERCdQ3y+vAT8DtSZVxG0/5IebbDoUOm8DECgyfCkCkdnE18/lTrYGA+/Dsgk/QNx2BWsiX4hHRN
 tu1drNPO8XyKgJ2l5zRmUN1y4itehpwNc//UlxPxUw3IyVwl0hhFvg6QZ0cC1JzDRRh/v9eIh8N
 tM++c5Bor8PBxjDX4LZBIDNQ7Qv4aZsooCgiOZAGkzbOskQ2WR9yInM8RCukEdH8tuQAPq/nix+
 xPQ8yioP5qIbceFB7mv+xrceWgJPq4/UebEt21JcJJvHnSpWYO3VzU4pH8Fde3+Oa8//XMPsczX
 9C0D8/6MvpGZXlszvKyXXwFYEz1XGV7yImKqAh1fTY6HVRhXwr61TWuu0ZZ3g==
X-Received: by 2002:a05:6871:724b:b0:42f:24c4:e317 with SMTP id
 586e51a60fabf-43a2da1b958mr2736843fac.14.1778854333263; 
 Fri, 15 May 2026 07:12:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc1fc0c5sm4161163fac.8.2026.05.15.07.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:12:12 -0700 (PDT)
Date: Fri, 15 May 2026 08:12:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] bloblist / handoff: Make this depend on BLOBLIST_FIXED
Message-ID: <20260515141210.GZ1858239@bill-the-cat>
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-2-trini@konsulko.com>
 <CAMDkj5xKePrX+Q7qhUq1KQpuGr6poyDFcdXxKnwhzQL8K9AJOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eTy2vWDAiGN1b6Km"
Content-Disposition: inline
In-Reply-To: <CAMDkj5xKePrX+Q7qhUq1KQpuGr6poyDFcdXxKnwhzQL8K9AJOQ@mail.gmail.com>
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


--eTy2vWDAiGN1b6Km
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:08:39AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, May 14, 2026 at 2:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > Currently, the only way we support passing a bloblist from one stage to
> > the next is via the BLOBLIST_FIXED mechanism. Update the Kconfig logic
> > to express this constraint.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  common/spl/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index 5fa94098e498..cc819344cad2 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -220,7 +220,7 @@ source "common/spl/Kconfig.nxp"
> >
> >  config HANDOFF
> >         bool "Pass hand-off information from SPL to U-Boot proper"
> > -       depends on BLOBLIST
> > +       depends on BLOBLIST_FIXED
>=20
> I am wondering if SPL can use the same way as we did for Arm Firmware
> Handoff - the address is not defined by Kconfig but via register
> conventions?

As part of future work, yes, it would be good to move in that direction.

--=20
Tom

--eTy2vWDAiGN1b6Km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagcpugAKCRAr4qD1Cr/k
CrDcAQDpMuTNyv5EBRGz8IJWR1Xj1T/vIf94Jwdf/7SbygGWYgEAu0Pmlb4lxLl5
9RNUPbjSl59imLtyHni3l7H2hbjhiw4=
=77ud
-----END PGP SIGNATURE-----

--eTy2vWDAiGN1b6Km--
