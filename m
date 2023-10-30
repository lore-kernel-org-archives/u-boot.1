Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B496C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 17:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88385879E5;
	Mon, 30 Oct 2023 18:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tm267nMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6C3874A8; Mon, 30 Oct 2023 18:37:50 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA8D87484
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 18:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7b3d33663so47023287b3.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698687466; x=1699292266; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rrLb1CgITfOTZHrBeaMGeS2MqjDtaqxBTqRgau7URBc=;
 b=tm267nMMg/ApaNpfAFGZ/MWuW4LvctWGk0YNJEnS4G8m9DdNmTOvgEVsnncH3C2ssD
 Uq20Pn5RFAMVYOmyCRWpjAAIj33Tcj3w5EpAvyPsEa93liTNUQMaphoIIeJ6BLF4WRjo
 Vf0Wd84Ct/WNN5Xr5wkhZvuYzzcy5wWuKrhus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698687466; x=1699292266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrLb1CgITfOTZHrBeaMGeS2MqjDtaqxBTqRgau7URBc=;
 b=HxzHiDRdEzKdFvKqTS/Yqyl/Y83WTgYkLipc7o24pf1ql+zj+wLNrAtMezhc2R4O2P
 UVNYk8awUxyRtDXhQic6E/+wKzGQi9iru1IqMJRPA3NgyQ5nT5ZNxipYGgEUIcvZSIux
 ugJkO3vtcqTZbKM1kaglXuF7ZxQ+GKJ5fDIORWflM83oUrVToLqRt+tGFJvIOMhTePa9
 K4scdmfPB7S/ssaZr/otrg4GrHBMvBops7qQl3K/zQqOrpJ/RDjCEdelqEXu5+f/D1P3
 j/aUz1/vibMv/0JlR1Z+dbfQMhwPspUZwm4Jsb/pTgXm2gFsoniFSS79hXUmmUE9vR+J
 cnoA==
X-Gm-Message-State: AOJu0YyoidKqdzcyUVt1ml9lW2xUvxm/JHQQNXrSAM9T3T9eWToyrLAU
 ELV5iRvPxIzDMOAw1g/Xkv01O2huqS7EaDFN7kk+Ag==
X-Google-Smtp-Source: AGHT+IGZwrQD+rao53iQi9iCtyGE4zzpN6GpbfxN4GDD+9lIhdtLkcEQSAKFEpU7/tqTgET/UaD3Ew==
X-Received: by 2002:a81:e70b:0:b0:5a1:db6a:6459 with SMTP id
 x11-20020a81e70b000000b005a1db6a6459mr9451327ywl.40.1698687466635; 
 Mon, 30 Oct 2023 10:37:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 qr8-20020a05620a390800b007671cfe8a18sm3506300qkn.13.2023.10.30.10.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 10:37:46 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:37:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] buildman: Support upstream branch name containing /
Message-ID: <20231030173744.GW496310@bill-the-cat>
References: <20231030172234.867888-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZKmV+KjOpY7KsCDR"
Content-Disposition: inline
In-Reply-To: <20231030172234.867888-1-sjg@chromium.org>
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


--ZKmV+KjOpY7KsCDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:22:30AM -0700, Simon Glass wrote:

> Buildman assumes that branch names do not have a slash in them, since
> slash is used to delimit remotes, etc. This means that a branch called
> 'WIP/tryme' in remote dm ends up being 'tryme'.
>=20
> Adjust the logic a little, to try to accommodate this.
>=20
> For now, no tests are added for this behaviour.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/patman/gitutil.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/patman/gitutil.py b/tools/patman/gitutil.py
> index b0a12f2e8c06..10ea5ff39f5c 100644
> --- a/tools/patman/gitutil.py
> +++ b/tools/patman/gitutil.py
> @@ -147,8 +147,9 @@ def get_upstream(git_dir, branch):
>      if remote =3D=3D '.':
>          return merge, None
>      elif remote and merge:
> -        leaf =3D merge.split('/')[-1]
> -        return '%s/%s' % (remote, leaf), None
> +        # Drop the initial refs/heads from merge
> +        leaf =3D merge.split('/', maxsplit=3D2)[2:]
> +        return '%s/%s' % (remote, '/'.join(leaf)), None
>      else:
>          raise ValueError("Cannot determine upstream branch for branch "
>                           "'%s' remote=3D'%s', merge=3D'%s'"

Thanks for looking at this. Poking at this a little more and what git
does/doesn't allow in names, and also does/doesn't tell us easily via
git config, I think this is correct.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZKmV+KjOpY7KsCDR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU/6eUACgkQFHw5/5Y0
tywWLgwApcXwIGlCIEgkKHYCrn5BrKUSKVk4NKW+EosYgZKE/LfC51VpP3i0cxwV
56yeStfOV+COYiBIKf51Fv3cfUMFzawDq1KfOhgwOQYoYs3Ot0PychUSGxFNI2dX
N86em8etopr29b8EaG2Tf3aYlGYHUkDamofpexZviyg8UWEtWnLjpkBQlGKNvUTJ
Ju+7MAV/eV4xp5UIFNibCqkvd/cVEvVKhiJ3VxASbt9lU9QFH1LGsNPeBGbEsXLo
bRVyCjKuP4wtn/VOWcl5vuWKwvek4P8jHrr57EPthjWaJ+GA3CZagVOM/0oxS9Us
s9TfHhsOQqx5LyFWzJJHHeP68ib3zgW8yyBcPtz8wsP+F5PtLn+9E4JNCdOC/a9A
ogAqOSSUAN3tFeow6HNDuNu6Xq3LuzsbkdBFJTGXJalZdoAqaXiDNXKmIlrH6EnF
Pt8ff3C82yJpDVDOwY3YZFsZRS1+2cSbHpJBocTEwGMA/OGzWGetK7yiR5H+S57m
dy4sO+1w
=P67m
-----END PGP SIGNATURE-----

--ZKmV+KjOpY7KsCDR--
