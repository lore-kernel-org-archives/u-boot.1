Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627E8C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 22:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C21CE882B7;
	Tue, 25 Jun 2024 00:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9ueqJ24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7700883FA; Tue, 25 Jun 2024 00:25:24 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891D1883D2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 00:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5bafe063f35so2434038eaf.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719267921; x=1719872721; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3BQVe2ZkGb5oKsbZWj4akMFfRpy534mrpTR0TsZCu8E=;
 b=a9ueqJ24uTWkZO6UZ7xujX5lLySZsNGzqPS4AWb1N/3EWKwAnd20e2Yp5DNCyju72N
 T9vlrNOGfuevdlf7x94xDuRWKiuKcjyVmRO3UsGRSksp7wTrqJedZGZFrQl0e3qwDjWL
 Wuv3RTOQQm6haJlsZZ6BBzXvv4Ud6QnCF1pmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719267921; x=1719872721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BQVe2ZkGb5oKsbZWj4akMFfRpy534mrpTR0TsZCu8E=;
 b=Ys/D3akxbePoVhqQSq6vT5DywP7r71c2PKLtBsklP/HvTim3wiN7ewXX+AtJJxw872
 aeWhGBoiY/j+Jl03yusCcLtl9lZ0aYml7Gq2r0gQLnFcsuBBi1yyvpXqWFbo2tQN3Grf
 bVMjJu1TipB+NxZqu3U+jyP323bpiJitgWlhVr8JZ9GxSSbH40APT7qhMkGIpDyZA12y
 qVt8j/cocAPK4jfk2erJxl3Msrmb+JHbTTs2yKmlFXjDGgjcJ7IVjb7TfKDgZcIu0TtC
 RgomEQ1OKNkRU7fD2SSzMNuS/wtP84K27wHxQ5hG/Gebheyng6j0N3t/5ATx0KvnB4tO
 A5Iw==
X-Gm-Message-State: AOJu0YyhotZ5DgDYW7q8XgIVDPjwUZQjFCcPy8jc2iYE52eGpM7LdiX8
 Yv+IdLa6FJRrNpgg8VKK4fDT9AbI19zH0JGDrrLOO4TCa3pnqtqFHHvf8NPH3Hw=
X-Google-Smtp-Source: AGHT+IEiYiaVwnrFpcgOFI+M5ICpYb3DWBSaWeszzXsn4DeHm9tFJA69kIUHgxJB76M7op7bt040AA==
X-Received: by 2002:a05:6870:4208:b0:24f:e15a:6536 with SMTP id
 586e51a60fabf-25cf8c5f3b4mr2758731fac.18.1719267921208; 
 Mon, 24 Jun 2024 15:25:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd49d1893sm2140568fac.29.2024.06.24.15.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 15:25:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:25:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: btrfs: fix out of bounds write
Message-ID: <20240624222518.GM38804@bill-the-cat>
References: <20240618214138.3212175-1-alexthreed@gmail.com>
 <CAF4oh-NEUG4rVqiUg_wFVaRF+_dFCXQNbrTPNA90Y2iGqksh2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b4VdyNqfNIuLpdBP"
Content-Disposition: inline
In-Reply-To: <CAF4oh-NEUG4rVqiUg_wFVaRF+_dFCXQNbrTPNA90Y2iGqksh2Q@mail.gmail.com>
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


--b4VdyNqfNIuLpdBP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:22:01AM +0300, Alex ThreeD wrote:

> Hi all,
>=20
> Is there something on my side needed to push this forward?

I will pick it up for -next in a while, thanks.

>=20
> On Wed, Jun 19, 2024 at 12:41=E2=80=AFAM Alex Shumsky <alexthreed@gmail.c=
om> wrote:
>=20
> > Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> > buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> > Previously this OOB write have not been noticed because distroboot usua=
lly
> > read files into huge static memory areas.
> >
> > Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> > Fixes: e342718 ("fs: btrfs: Implement btrfs_file_read()")
> > ---
> >
> > Changes in v2:
> > - fix error path handling
> > - add Fixes tag
> > - use min3
> >
> >  fs/btrfs/inode.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 4691612eda..3998ffc2c8 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -640,7 +640,11 @@ static int read_and_truncate_page(struct btrfs_path
> > *path,
> >         extent_type =3D btrfs_file_extent_type(leaf, fi);
> >         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> >                 ret =3D btrfs_read_extent_inline(path, fi, buf);
> > -               memcpy(dest, buf + page_off, min(page_len, ret));
> > +               if (ret < 0) {
> > +                       free(buf);
> > +                       return ret;
> > +               }
> > +               memcpy(dest, buf + page_off, min3(page_len, ret, len));
> >                 free(buf);
> >                 return len;
> >         }
> > @@ -652,7 +656,7 @@ static int read_and_truncate_page(struct btrfs_path
> > *path,
> >                 free(buf);
> >                 return ret;
> >         }
> > -       memcpy(dest, buf + page_off, page_len);
> > +       memcpy(dest, buf + page_off, min(page_len, len));
> >         free(buf);
> >         return len;
> >  }
> > --
> > 2.34.1
> >
> >

--=20
Tom

--b4VdyNqfNIuLpdBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ58ksACgkQFHw5/5Y0
tywA9wwAmCDb6CVM56ER7RwePimtMlpBoa8zCRCB8lB7JsjFz1FxHF7gtSDyOT+F
/xHeJaUNgsuN2ysBzZJAKE4FaumgYk5iGGAt9t/WxIUzgVzZlApOvM56gid+oAGG
ZzNlxpWvT4DctsdnoSAkq/0rvnlni06qwL4btIAVUeBn1r6zEJtyQ4N2rxznBtpu
aSr1Z2tfPv+XKx+TCuzmdrBo7H1zq4nnn2VBwwE/pr0gBMlDRECOQ7wBDRiQxOYn
VLvX2Itc+U78MeBxGnEIVlsGkmmvYvESs4Qq88cwlyrjIvZC2EGOOptVJC1CoIs4
mXBVHGgVtMHyKGVfHrxJCi9AjhZc/+53a/HY4nahSgs0ZKSHyoAPZWtCxWxwRWyN
XrWeFfBZf4BzQllMIRGjHs+fO5Hhhl0j41azHXXR9Ysqxzekn1EgoR3lfkdG1IVt
qH0UEaf0+3jOUjT6SMYLhMLDS8KdwocYu7Ushc2GcNty0rK46FJ1Y8tgjhaqbBfM
hXfqmUCf
=mqts
-----END PGP SIGNATURE-----

--b4VdyNqfNIuLpdBP--
