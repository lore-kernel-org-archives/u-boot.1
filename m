Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAFFF99C89
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 19:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8163383B99;
	Sat, 18 Apr 2026 21:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aXD4aYci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C15083BC8; Sat, 18 Apr 2026 21:09:28 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333BD839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 21:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d55b97f358so1030618a34.3
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776539365; x=1777144165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XNQm+vmIghDhZYF54R6cMAjs1ePjRfEtabtc0VLzHwo=;
 b=aXD4aYciFuXBQs5T/rFXZ7YGD27bm2GHIsnFARwzU+BvZ8ur/av+eHwx64ricqJQJ7
 9+0YV0G8FKTQnCnLK/wV4Ddhve604pTpbIKwVbZuZPzMzSs00Hb3zaTl1Z/iusJK+7cI
 8DZMuYWQ9bx7TJOop6xWM2NUFT+LMdNcJZrt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776539365; x=1777144165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNQm+vmIghDhZYF54R6cMAjs1ePjRfEtabtc0VLzHwo=;
 b=YtBkyK4fV7I2b+luBbyHFrO4VN1D2EcHXVYB7H+MmWvQHqC+n9rwhz43x5pK18vmMh
 73ZqhYXMDK7tDnXSl+AMF9slHDb9Chise403D9MpyCbkpYd7dgz9knlsz+riKlv7mKil
 BgBKQRLRgC1NZ6OQFTd6tBDDqlKS0tJlr9aVFh8Ge42RwMRklCIYagQl2ZlbjOreDctS
 5pWz14ROTeAc/rsD6eKss06uz/RbUuJhJvijtAHdGm9IPwjLuF/aY71T1e/wr4gU/GR6
 /Qzkg4TRBxRc/0qBCuHSl3O2cnCK1leWcq6hRVbdem70uzkaCh1PyslT6gIo9aAxH03v
 rPLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ghqgUjXnxPHjbJdXQJLjJrSiEIb29tKx/z84i2hRH1hgm2RVFSTqI6isEwPdOqhskVnunTto=@lists.denx.de
X-Gm-Message-State: AOJu0YxMngt7X1HTZFXtg+LO56t8sJBvVnPU2vpC+o/Ge/dhuTN+FeRv
 TQVfi0KjJ3eh7UyovX3Kj6ozK2WatvaKnOOAB++PnMEqVZM7F3i6mrnKtPq1/RkEcMY=
X-Gm-Gg: AeBDiesk2tmK/aGXLdcyYeCBh2ER2luvuxAvD0BaWJUamZ5sNKdgPN3Y0xU9T8vS1QZ
 fFoQTtS9VwSwi74MpdUWmspQ3GMmAXDVFE6cLTaMobbXYQwZ1y00rGv1oSOGGG/dMuK9/GjZcsL
 Q6AGs72qTyXbjJES5FKJeIJBu5CCwkJ/sXLDk73B76oH+lJNqHf2CTcndpcdfhHEk7sGWo5xoIM
 648xgXKToB5YHg6GLpMhQmE5oAFMXBIIavPvy/qmHXQiLQUl9+8gKAbCAiRq9vMcj87sZC51VW+
 ufWrZ15SQndQRE1uPRZqzLZst6pC/gRdTTOFDSlPCt/cOsznPhiI/qYSv2+veHy21K1h9N8IgA+
 WjDKIEUhpqeqG4xcYjZsCogdht0tZux2r4MLtZt5RDCH1gqA19Ql3q5hP28X2fjIJ8nudFyvl1o
 RvDhQQX3y2Jne4mqm0mmpNw5johOsneJJl7p9/z7ceL5v8ZsYbvB8XlYbu3upEHDcOwx4EXhH4r
 nmJufqM6po3DljU+fpvdLbLQtHzbVVZ61Ctz93o+fBOeTJgJLGEeLP1MqqiKg==
X-Received: by 2002:a05:6830:280a:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7dc951175bdmr5233247a34.9.1776539364863; 
 Sat, 18 Apr 2026 12:09:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc9759bf4esm4319903a34.18.2026.04.18.12.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 12:09:23 -0700 (PDT)
Date: Sat, 18 Apr 2026 13:09:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
Message-ID: <20260418190921.GS41863@bill-the-cat>
References: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CUzb8Px2/8HG4rbF"
Content-Disposition: inline
In-Reply-To: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
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


--CUzb8Px2/8HG4rbF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 08:15:10PM +0200, Heinrich Schuchardt wrote:

> When building with GCC 15.2 the following warning show up:
>=20
>     scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
>     assignment discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type
>     [-Wdiscarded-qualifiers]
>       422 |                 sep =3D memchr(fixup_str, ':', fixup_len);
>           |                     ^
>     scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
>     assignment discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type
>     [-Wdiscarded-qualifiers]
>       432 |                 sep =3D memchr(name, ':', fixup_len);
>           |                     ^
>=20
> Define sep as const char *.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  scripts/dtc/libfdt/fdt_overlay.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Is this something already fixed in upstream dtc?

--=20
Tom

--CUzb8Px2/8HG4rbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaePW2gAKCRAr4qD1Cr/k
Ch/TAP0RbYG5SaeVyUOk9tPRBLOIJDOEi+Nnuusbn6PeLAGlbgEA30Zgs2OglXT0
8iNklSfzo2Sf/LRmks9Cu50a+hFZRgY=
=vTlI
-----END PGP SIGNATURE-----

--CUzb8Px2/8HG4rbF--
