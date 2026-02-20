Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD5BC5AD05
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1C483C39;
	Fri, 20 Feb 2026 17:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WrlezuIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823BD83D2E; Fri, 20 Feb 2026 17:53:50 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5786783A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1890f5cafso778483a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771606427; x=1772211227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FiR1NiMUHhvgl/dSxsYUC7rogTb/QwOmbiBCjTESDOg=;
 b=WrlezuIMRLOIfWUikGhI1aIClB9s+AMaJeFFmQOudWfX+vOtKtOdXJZ0R48FT2Fjr/
 Zr1+SEuzG5TQA0787oWY9JJZRH7IPni8IrwRhJG+Aw7JU2Tb8BRL0h+sJlp7nt/i3h/+
 ndlBfojFsENUC2HsMLUJlwV88P4agJEOwSeIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771606427; x=1772211227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiR1NiMUHhvgl/dSxsYUC7rogTb/QwOmbiBCjTESDOg=;
 b=KhwAlUzKkZzsVZQG/iP8jYFy/Pd8oiQSx8Ye/y9VSbyvB/5iUg5LKZIt/JZ4UGkqtg
 ygpVfJXq6N+ywcZy3ewwekxWPLS9rTJsuw8zq92mcioZxJXu1JOofMQv3Hs8/m4ZlyS+
 deERKWhK2pnfNkcBlS6yN+BQbEJFRHv0LNtCu4Jw2XJQTMPqGWAxWg9msb5LBPLlr35i
 4nc0MPCbLqsk5GJMOz0If1BokUVOLg5P5DPo69B1HJXJg+PJjfeodR6FPF/09nfoQcLn
 2Nhf5X5+xuIfryFIhZIz+28nitzGUwXFtmIk7qUO4+0VIALG5vMN1Qu8Bvvf+3WlIx89
 aivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnYVJ5g9awvdBRY+S0QBkfKx3xkCMovIX3OjxruOopgkYgBvU9B4Rm8ryBpa4Ii7nmkbntJpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzbWG1fvuNOp2xQl3qxQyHebWMapaKikQOZYI9rufsHKd31K5lW
 JukiSGgVPvDTs1ogJ2g9VM1TdryfF30qQlAO5cnomUFQDrgsos/heTC2J2idPpTWnEsbjtKNTuR
 I1ixNgRI=
X-Gm-Gg: AZuq6aIKvn7VCMNzqXPw6Gyq5b3A+Hsg0QUJr4Tz2a8NjkHLH3jnzPhPhUVO9mYN2SQ
 MS4ltCGkkxYWkHYu5pmNV/SHMcWW0wDsxzlkb1qvm+lrSZ09mgISKdLmTTWurvuYNMX4TTVrFp0
 F4pIhBwEDXw2gTTRD0urKU1p/W2398in6Vfl6VQQxwKLFvp3qaQ9pyQWpSteSAUmQUFVFpkJasQ
 pMdyhkJPbEW88W8oI7B19jgwO5nQHvw6a0MgriWWIh+eMClJDcBgNxi6owcHQ4T88QFli3c814k
 b6fPMptse6zjaBejBTlgWF2xWOOtGFle++E3evbUPnyBStN45QRZkZe6+nv2kXiNwyAFZtjQZkM
 0roikewfD7OSlurj87tqFuDYV9Znjuh59P5earZFqR+/RDm5kA0DwygOAtI1iqHhP2KQEHvB/PE
 M7k/jotwExsDT2XMW0OkPmuPCyBeKvDyjVlog717RMuIlDguhckBS2mSHu3tXUDodiKh5FfLdBA
 CybZyB4LiGwe5VmZHKEiHxfVXrpqbbDMNvikeua6cqqU9nDqoI=
X-Received: by 2002:a05:6830:2a17:b0:7c7:e3b:488a with SMTP id
 46e09a7af769-7d52bf96783mr181077a34.30.1771606427047; 
 Fri, 20 Feb 2026 08:53:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78503sm9766a34.3.2026.02.20.08.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:53:46 -0800 (PST)
Date: Fri, 20 Feb 2026 10:53:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, u-boot@lists.denx.de
Subject: Re: [RFC PATCH v2 0/9] add software ecdsa support
Message-ID: <20260220165344.GX3233182@bill-the-cat>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <CAMDkj5yPfC=sdD8feU-sWVd4ok9D1045C+VVxn7Z5smKSyaikw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lY/6zu1p+ASU3+x+"
Content-Disposition: inline
In-Reply-To: <CAMDkj5yPfC=sdD8feU-sWVd4ok9D1045C+VVxn7Z5smKSyaikw@mail.gmail.com>
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


--lY/6zu1p+ASU3+x+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 09:58:48AM -0500, Raymond Mao wrote:
> Hi Philippe,
>=20
> On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
> <philippe.reynes@softathome.com> wrote:
> >
> > This serie adds the support of ecdsa with software
> > using mbedtls. So boards without ecdsa hardware may
> > also use signature with ecdsa.
> >
> > To add the support of ecdsa with mbedtls, I have:
> > - enabled ecdsa in mbedtls
> > - add a function sw_ecdsa_verify that uses mbedtls
> > - add a driver sw_ecdsa that call sw_ecdsa_verify
> >
> > I have tested this code with sandbox, and I have
> > followed those steps:
> >
> > 0) build u-boot using sandbox_defconfig and adding those options:
> > CONFIG_ECDSA_SW=3Dy
> > CONFIG_ECDSA_MBEDTLS=3Dy
>=20
> As this series introduces a MbedTLS-only solution, duplicating a
> CONFIG_ECDSA_SW is not necessary, you can just use
> CONFIG_ECDSA_MBEDTLS when linking with ecdsa-sw.o.

And for the next RFC can we see this enabled in sandbox, and then the
tests being able to be run in CI? Thanks!

--=20
Tom

--lY/6zu1p+ASU3+x+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZiRlQAKCRAr4qD1Cr/k
Cty+AP97BrGqiHnjwZC0iQrNV1JD6VYsiLmWy9ZNR5I9scBInQEA8a7olp3fjcN/
5FRKaD+07cI6LhzVhWbthj610vlyyAk=
=bLVU
-----END PGP SIGNATURE-----

--lY/6zu1p+ASU3+x+--
