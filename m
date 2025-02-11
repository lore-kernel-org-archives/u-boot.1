Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D1EC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 21:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5FB780A55;
	Tue, 11 Feb 2025 22:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J9ZUqPTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055AF80AE5; Tue, 11 Feb 2025 22:29:18 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBA8809D0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 22:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f6d2642faso91306455ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739309353; x=1739914153; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CRTs7G6i3v93mDWeUBdzW8G+iPnbGQ6HqdZysyJzan8=;
 b=J9ZUqPTu9apBS7yfPVSyuWzlpYhl9PzcGAoAkGp/wDaXvGBSRvGtRMC/VoPStpmwxz
 B+iCCKAX8K9818bKC0o7JXXkMNkk5XkAwm0Vtc1sArEAmzeI4wkUyNp0FDRHfD9t+CwU
 zkpErr87iyLqKhcLBPDjHkXM++4XUayDCwQZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739309353; x=1739914153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRTs7G6i3v93mDWeUBdzW8G+iPnbGQ6HqdZysyJzan8=;
 b=hdWuVzDUkUekdfskXWkngc6tCVFT9kyXoJvq5pjJkmIGBZzOO/EbSdkdMSGNZBQiYB
 JqeBufdOVIE8FHPWKWZRNpoCKee/4L2UIfW0Cr3pi/hdM8vrKQDVUDfL1sI6rXnPnb5I
 Zv8ZU52ocdczwzurJhzvz4NDj9frMazB5mdbmauzhRammo10Aa89InDeo6qa3ku3y9Mv
 3zt5uVAJP4r1kxmVR/ec+VPRpaNF6ITRTZjcC5qMlH/BpbPtgGS104mDjL6R0ZuG9Zni
 FrEElbqAff1mMTh6eHGljvMADPn0gBzaE7U8XONa2vPm+vAeurTUjRlqmyIC3gkMAijj
 SvFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURRMpmy1tm5MmSTqlxFqlSCl1Zils308Bqcv7ELWIj66qsX0P979zyn7BjQxM3emUpEcrO6bQ=@lists.denx.de
X-Gm-Message-State: AOJu0YznyzqYvaCX+Kv59TICsl5iF5o89zxWKstM9ndi+1hIgHy8N9aY
 IkXMAv5dTNx/d9g4nxGu8xPs1xJcBWCyUJWLcJrZUo7iy2aswj6MqCIfs7/fFUM=
X-Gm-Gg: ASbGncuaYV2/267RlWABKu4RMGupPVDarR7px5UCNgGrGjJeCu+JCHxrcc1XSxJ/SGD
 He/LKmYvK2tNWZ6AHDZMgENsBDGFqHGbQTBs+N/23gX6cyhOjIAv0211bK0mzyP/5l/BJxxMXrr
 FYStF6c0c9B4rnAOBvqDcJISDsDhrTxdWnpxt5UcF4RWqhAi9ky+/N9PFOMm/T9GoErR4RfLsjl
 y8dzvROzMernb64qkPIxnZ9gVVQ1k/7RdCV/tD/jp0rp/TJKE3kRBqkCKBEQo09SK4r/Ic8Llnr
 EiiuwB/IDqAh5jw=
X-Google-Smtp-Source: AGHT+IG1xr9VC7XBUWx+v2r1uZF4jmkMjJIdIJoBn61twFjSmdSjdCbTjAKiZlMokbJbjn7Xsd1A+A==
X-Received: by 2002:a05:6a00:9286:b0:730:9204:f0c3 with SMTP id
 d2e1a72fcca58-7322c4116bemr797173b3a.23.1739309352808; 
 Tue, 11 Feb 2025 13:29:12 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048e20c32sm10102954b3a.170.2025.02.11.13.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 13:29:12 -0800 (PST)
Date: Tue, 11 Feb 2025 15:29:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Huang Jianan <jnhuang95@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
Subject: Re: Security vulnerabilities report to Das-U-Boot
Message-ID: <20250211212909.GI1233568@bill-the-cat>
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EOLOpZqCsF/TXrAC"
Content-Disposition: inline
In-Reply-To: <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
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


--EOLOpZqCsF/TXrAC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> Hi Tom and the rest of the team,
>=20
> Please let me know about fix time, whether this is acknowledged and
> whether you're going to request CVE IDs for those or if I should do
> it.
> The reason is that I found similar issues in other bootloaders, so I'm
> trying to synchronize all of them. For what it's worth, Barebox has
> similar issues and are currently fixing.

Yes, these seem valid. We don't have a CVE requesting authority so if
you want them, go ahead and request them. You saw Gao Xiang's response
for erofs, and I'm hoping one of the squashfs maintainers will chime in.

>=20
> Best regards,
>              Jonathan
>=20
> On Mon, Feb 10, 2025 at 7:51=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibab=
a.com> wrote:
> >
> > Hi Tom,
> >
> > On 2025/2/11 00:41, Tom Rini wrote:
> > > On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> > >
> > >> Thank you.
> > >>
> > >> So, I'm attaching my findings in a md file - see attachment.
> > >> All of those could be avoided by using safe math, such as
> > >> __builtin_mul_overflow and __builtin_add_overflow, which are used in=
 some
> > >> modules in Das-U-Boot.
> > >> There are many cases where seemingly unsafe addition and multiplicat=
ion can
> > >> cause integer overflows, but not all are exploitable - I believe the=
 ones I
> > >> report here are.
> > >>
> > >> Let me know your thoughts.
> > >
> > > Adding in the eorfs and squashfs maintainers..
> > >
> > >>
> > >> Best regards,
> > >>              Jonathan
> > >>
> > >> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > >>
> > >>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> > >>>
> > >>>> Dear U-boot maintainers,
> > >>>>
> > >>>> What is the best way of reporting security vulnerabilities (memory
> > >>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be u=
sing?
> > >>>> I have 4 issues that I think are worth fixing (with very easy fixe=
s).
> > >>>>
> > >>>> Best regards,
> > >>>>              Jonathan
> > >>>
> > >>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.html
> > >>> please post them to the list in public. If you have possible soluti=
ons
> > >>> for them as well that's even better. Thanks!
> > >>>
> > >>> --
> > >>> Tom
> > >>>
> > >
> > >> Filesystem-based Das-U-Boot issues.
> > >>
> > >> =3D=3D erofs
> > >>
> > >> =3D=3D=3D Integer overflow leading to buffer overflow in symlink res=
olution
> > >> In file `fs.c`, when resolving symlinks, the function `erofs_off_t` =
gets an `erofs_inode` argument and performs a lookup on the symlink.
> > >> The function blindly trusts the `i_size` member of the input as such:
> > >>
> > >> ```c
> > >>      size_t len =3D vi->i_size;
> > >>      char *target;
> > >>      int err;
> > >>
> > >>      target =3D malloc(len + 1);
> > >>      if (!target)
> > >>              return -ENOMEM;
> > >>      target[len] =3D '\0';
> > >>
> > >>      err =3D erofs_pread(vi, target, len, 0);
> > >>      if (err)
> > >>              goto err_out;
> > >> ```
> > >>
> > >> The `erofs_inode` structure's `i_size` member is defined with the ty=
pe `erofs_off_t` (which is a 64-bit unsigned integer).
> > >> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input to=
 `malloc` would overflow to 0, allocating a chunk with 0.
> > >> That chunk (saved in `target`) is later written with `erofs_pread`, =
overriding the chunk with partial data controlled by an attacker.
> > >> Therefore, we will have a heap buffer overflow due to an integer ove=
rflow in `len` calculation.
> >
> > Yeah, it's a corner case, I will try to address it later.
> >
> > Thanks,
> > Gao Xiang

--=20
Tom

--EOLOpZqCsF/TXrAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerwSUACgkQFHw5/5Y0
tyzQbwv/Y++LG9rG/4fMhWzQaGEyPvQ8r6P3RkyucImnEpvCD/XsW2THxHQlq7vY
DanXxpd6wD2Q5fWoAZirBYYNDwipQoQktuOQy2QcIsV9ke3OTO1nMAtsniVexgak
ET9nw3yB6X3K5Css2yBai5OfxKDjOl+mtmsuTW0T328G2FCjk2+0nWvn+OVcD4OO
/jWvw5w3Xm8qWB5ena2PLDYtg7BMCSySucpT75/AqwT6+BytuAtQRMYfD5M9Qs5k
BRjG8kVB7pPFUxqNTT9P8w+kKgZC0OTMkw5yj+vzLhjOzP4phv94hbSeUGGRhsW7
s10btCk8imiIizCWY8vPuGmQUXz4EstfpsiJNhnnQopyZstPSlp0Db6ZHgRhtWBy
YRdFAoErzYEGm0mgOn+wsIHpPo8a1pyWAu5EfhglAXir5yBIW1mjkrthRqsLS9Pu
rdr5HRFEmqgyiwg2oVuxitxr3EJwoYfbvlDB96bdf7i+UEOR3UsabdQl/0P07h7f
sEAebW/5
=ylbr
-----END PGP SIGNATURE-----

--EOLOpZqCsF/TXrAC--
