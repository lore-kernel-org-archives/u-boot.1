Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05C8C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD838881B;
	Wed, 31 Jul 2024 19:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oslrLtFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA2486DBD; Wed, 31 Jul 2024 19:17:32 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E25988955
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70941cb73e9so2155598a34.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722446249; x=1723051049; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LpQj308Pay9f3Ssqzf3o2g0Tj6bPMHJQWK41OMxE8bk=;
 b=oslrLtFJfX1js9B91v6xJHP+6aDx3D/dErz2ILuydW5f5ZC40dWEjqKLOgOnKM1+qL
 i7g2ZgWJVyYvvvXmvpPePI8H4wWV/eUUybkdvNPBXgki4N3l0zf+0fJwnhimZvTymIM4
 sDBN71TPkYJC+5zhOz8kvgkXMM4BIIyyXCMZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446249; x=1723051049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpQj308Pay9f3Ssqzf3o2g0Tj6bPMHJQWK41OMxE8bk=;
 b=tYDLzWZi9kW7TkOV5p5OJzPigrIx3kO/SqKIF5Rh8FgVdehtyuraCv05u5rbx03foN
 s5NZd34ChUVBkoDuVW2eWB2gpsnR2qzomTVR+uOWx1lGbKufIitUF821uJRHb1ZT7Hi2
 gsQyscs3g3IVhBT4hOBo/po1NGRbDeR0eQn+F32bcS5Gb2CeH2JdDYtDcRRB657eVCSU
 aPFd+C3eyWCLH4GbQaOgrytisw8PJglGgEkMRI5L4mCnb5AAzulA2w523h0LtqJfRbtT
 DsEa03Xv7wIPk0T70DSn5WYnaRt8vC3v9J7IaZ6dORX+F8OUVJ9Ut6XGe8CHo92HUoyg
 MBLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/CsdUCeTIMIhmwE9mra9dRczkXso2dbVu59pAGXhWVjRFCAHtWv1nI4M7mvMg+owTKf5rwe2NBqHHG3dCM/AmKCxSBg==
X-Gm-Message-State: AOJu0YyI53KVVUHQPdDtjSvtaQAeAWz5kK0ZXEYZtsB0PAO3YeDRTPJr
 zKJx5fPfx5BldspNi0MJXyR4+sRQMmOZLEjobRyOr2H0cUpAfp26yozuczBpqpc=
X-Google-Smtp-Source: AGHT+IEJT9VahxSyugloz269lJCWuqHel+GG2DVPDE8lYk8zXl5ofQTy+SUSAZr1MkH4FfMh7a8VDg==
X-Received: by 2002:a05:6830:6014:b0:709:61c1:374c with SMTP id
 46e09a7af769-70961c13cacmr5058260a34.20.1722446248946; 
 Wed, 31 Jul 2024 10:17:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095ad4e66dsm982479a34.8.2024.07.31.10.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:17:28 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:17:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
Message-ID: <20240731171726.GF3794063@bill-the-cat>
References: <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
 <20240730201129.GB3794063@bill-the-cat>
 <CAFLszThWZUZabbysC15aLaCRt8EL1=qts45hn0Usp5htR-dp1A@mail.gmail.com>
 <20240730212009.GC3794063@bill-the-cat>
 <CAFLszThsMiQWfkVJ0POMJAFDyYWErLssG5vsQOG4V2WTWoE=4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lZuxiZswn57bYZSF"
Content-Disposition: inline
In-Reply-To: <CAFLszThsMiQWfkVJ0POMJAFDyYWErLssG5vsQOG4V2WTWoE=4w@mail.gmail.com>
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


--lZuxiZswn57bYZSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:39:23AM -0600, Simon Glass wrote:

[snip]
> > > > so that
> > > > step three can be seeing what tweaks may be needed in where things
> > > > allocate memory.
> > >
> > > So my series is step 3?
> >
> > Or at least understanding what the problems may still be, yes.
>=20
> In that case I would like to clean up EFI's memory management before
> doing step 2, since I believe many of the problems will just go away
> if we can get that right.

Well, I think that's where some of the big points of contention are,
yes. You say "fix" and Ilias and Heinrich say "but the spec".

Perhaps once step one is done it will be easier to find a way to address
your concerns without also breaking "the spec".

--=20
Tom

--lZuxiZswn57bYZSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaqcaYACgkQFHw5/5Y0
tywvsAv/d+DdJEUHMisSaZEcElKIE0dqogg3f+mtXpvd5Q4Z3wDwvIK4UVhYaV8G
LDZn0tvpwQhiTOWu6PSEUuSo4I3GmE4Tb2M9PIc2yQ/WGd2y/w9jxc9AVTlVVj/A
KTuLB/q5d8cCwhdY0PNv+ET/RbZ63RaXhd7Uaw8Ltse5geI2Ka4W6YDXrJNaI4hB
efbZrq9qfhrbFWhlrEm4VTWeuCxfuF0Aw7cIiIXSmBJWfpVYDu7FQq6p3ZsXoKt5
fe/kkuuX9S48ehz3ffgKaCqSiOKzpq308ZRddUgdlCB5dIQNXPk3LdVD6mXQPlyj
BYqXGqttn5cICmxFAi4Gjze8ACEx4+WNaTF8ykTR0EJGr0t04ibR6swpqJri5nGC
3mb9GJMuFWUAlFo2hXoQfaynIkMdB7x50ipTXbtQnvCDB35f7Lmv1vuDL/zZzK5a
Zc+TfHxERY7UMPhg/Cc8GabH5bLalUb04cg6muUTYSIGtkyR/jI7PlcKzXx1oyPF
pdHZzQ/c
=2NAw
-----END PGP SIGNATURE-----

--lZuxiZswn57bYZSF--
