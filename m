Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3F4CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 20:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831BA881DB;
	Thu, 28 Mar 2024 21:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aTJi7nf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB6886784; Thu, 28 Mar 2024 21:02:19 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3DC881DC
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 21:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42ee23c64e3so6224801cf.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711656136; x=1712260936; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ni58vsdbKYgl/QMgx5wQjKW36JIOrSqiY4MsRjXMWwo=;
 b=aTJi7nf7V0nY80CSgTUnyWcj1sLYnTZb3ssMb4iLdzNYXkgsgey1F/Y965FuHYYX6i
 0q5ghMq+Cr5BUV6VbQMb7E1/L1OhJXZ3ydcyghKHfdoMZCSejEYDyDNdZA+dLWO6vIgo
 D8Cmc8Un8VwytS1YJ3TbpP1iRuJIq78+oYVYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711656136; x=1712260936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ni58vsdbKYgl/QMgx5wQjKW36JIOrSqiY4MsRjXMWwo=;
 b=sjEtYfPgrx3wXYCv8f4+ju9KxK03C0DFmh5rS2UuRadZMn5HcZtvQAvtP1Iv7YVxDL
 k3znZ29wY+YgpOQOnWUuVHLtE6LOgCHSey/HzGYm2xa4r0QYJvLt9iFXk76tyVRSfY2h
 8jboTv7HkYMZso8MchT7Fsz8adpaTT9pT3QenyvSrN05UXru7KObb62gyZwvQtiby2bZ
 vDEMqZlDI7d1wXkdBwksDpRJWBFh3xBWBzfq7RwEdgFU+R+NqAr0f20gk/2/uGub49+B
 /Koi8b0i5AZNelNM7NtsfMcjISxj0wLHZ3XgQ7RUtopdGudVTjhMPIuf45jZPtAbSFrt
 uQYg==
X-Gm-Message-State: AOJu0YyfPNd0f5uJBdlGed3UY0z3DzVvadfd4Tncep0ws+cB2bs854o8
 j05VBas10oakoe9gv71acRsShkyf7yVxgiXI6eEbdZtpfbKR2p13/DCHKkufynjSCxYgJ34zfdG
 9
X-Google-Smtp-Source: AGHT+IF0mpxf7XJ3Qk6D6Er+kqPlWThkFmzkBUIUSpCRHvOXYvQmPH+IUJbPDOJRyhFObN8YnmYweg==
X-Received: by 2002:a0c:fe63:0:b0:698:7256:b82b with SMTP id
 b3-20020a0cfe63000000b006987256b82bmr202120qvv.38.1711656135893; 
 Thu, 28 Mar 2024 13:02:15 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 gw15-20020a0562140f0f00b00698cd03713bsm389316qvb.27.2024.03.28.13.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 13:02:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:02:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: Pull request doc-2024-04-rc6
Message-ID: <20240328200213.GF3442575@bill-the-cat>
References: <b1e39c62-816f-41b6-964e-12cb7e8b446d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CE15IbeJNeNkmSaM"
Content-Disposition: inline
In-Reply-To: <b1e39c62-816f-41b6-964e-12cb7e8b446d@gmx.de>
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


--CE15IbeJNeNkmSaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 08:56:54PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit dde373bde392c38649c8c4420e0c98ef8d38d9=
dc:
>=20
>   Prepare v2024.04-rc5 (2024-03-25 21:56:50 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-04-rc6
>=20
> for you to fetch changes up to d2fbe1fa29190fc1209364b3d5e33294009da9bd:
>=20
>   doc: add reference to itest in if man-page (2024-03-27 09:30:07 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20082
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--CE15IbeJNeNkmSaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFzMUACgkQFHw5/5Y0
tyy+IAv/SbUBDOtRc77qyzMb5N/e+vco3qvu1LsjH8wQZFHexMRjb4GvFkXE+DF7
H8QzRoKBsDHDMJzkj9Gtbhz7cGrztvaNlcet3LKKIODwv71lVhdX8N9BYVJbIq7x
34uASC+BUh6xVJXedfQfK/gsLDri9Z93RGXE909dCJvaY9eYqaj/6WTtn3IBvG2H
vebYSWqxRcXilcrKQe/drt+6k9b+Dh9gAJIQFp7aKIFzrz62BdzIl4YHLbdRhJAI
lKgGeKxbXuSwAJZzlX2lzNaP77t6m9ICiEspuG4G+jER19ERHLJpjSIZh/8vDzuN
oDEypnUYXCl+x2lHYas9UeCuy9OYGtOpzUW5ep4ybYeXCoiHxO1jK7w2md0AC+gB
0aw8RQjsKOoV8f4H+sRjaCTMDIbL0n3JLkmTWR+cNGGAfO0PYNp6cv+cRVDwbFZv
1A51fH9w/HK9KpfoN/WOHpNLdSruMAQRYEpxQtWLvzDyTLTKu8RmjBMC0oz/VweC
IgMbTDQ3
=2D9j
-----END PGP SIGNATURE-----

--CE15IbeJNeNkmSaM--
