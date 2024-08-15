Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4686FC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 22:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351F088AF8;
	Fri, 16 Aug 2024 00:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HmOvmB3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9523788AF4; Fri, 16 Aug 2024 00:14:27 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64EF088B1F
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 00:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db1bc36bc2so678477b6e.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723760061; x=1724364861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NwWPsao+IOeaVI9hU215KXwCmtMlUkeanjYqAh8hMwI=;
 b=HmOvmB3uKkbzbOCo5wfJROQGPt/CYRtrm+8GrAsdMV+yGaPCXWNYLOBTS2mmC/mFvP
 Rtw0/7dUpGoQr4R+wFT/jcygyOiixuY/XnLnyTY1R1vkA48zJM3f5SKMGbrCudyYliRV
 gSKGJyX2ca2+EzBIjx1ev3SEhvMN7B9hHm4x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723760061; x=1724364861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwWPsao+IOeaVI9hU215KXwCmtMlUkeanjYqAh8hMwI=;
 b=WoykN3E9BYSkulfDyu9v1G5+X7L/QFaAGmP4s6e3BCpvVsCWYcYZ/1CBIxpn8/U4mh
 GQ/xPM4QaPcdB0dsEbcCXhOZ/MFrk9C8yQ4oo31V2lfBO1RceoIaDnKOekeuAQBe4onb
 Znm7YMWq1YzzfWnWqMhZ3KYKS/nRkuWB4Psvik3W/jSfd6nKw0RAFhaFMC/W7hkLl62Y
 21ptmzivqDbmFuiMKvNGNNXH2f/dOXh+uhHshV02PQyCaGJkE8Fb59VAtBSx9+AbYH0W
 sclxjzDlwy5cvUoxVtnKGBdUSKqe0ZW+/dNwjj8efwIM2m1CpswMrhtiXgIcj/4Myz2V
 8ObQ==
X-Gm-Message-State: AOJu0YxpraF9tlWRpKDxrTBtHoAerHtCQo+O9lEAUqJdm5y0oR0Ezzjk
 Y0J1zQdnnbHYxVQNiZD8g2skT9kVV1Ds3y66XVrJxH+kt8s42m5kMXbkBsXjdFM=
X-Google-Smtp-Source: AGHT+IGvUNvQgfVCxokFYjs/g3R53NCa76xQNDXs+nsOniZ3aHIEF5faCKvpOr1C5IA5Iy0C/haTBA==
X-Received: by 2002:a05:6808:2114:b0:3db:16c2:7f1 with SMTP id
 5614622812f47-3dd31693985mr1714645b6e.8.1723760061478; 
 Thu, 15 Aug 2024 15:14:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33ef4338sm436188b6e.48.2024.08.15.15.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 15:14:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:14:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at,
 francis.laniel@amarulasolutions.com, glaroque@baylibre.com,
 mkorpershoek@baylibre.com, sjg@chromium.org,
 christian.taedcke@weidmueller.com
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
Message-ID: <20240815221418.GA3500277@bill-the-cat>
References: <20240802093322.15240-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZRc7IovizICnovSG"
Content-Disposition: inline
In-Reply-To: <20240802093322.15240-1-richard@nod.at>
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


--ZRc7IovizICnovSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 11:33:20AM +0200, Richard Weinberger wrote:

> There is no need to mount the filesystem on the host side.
> All filesystem tools offer some way to fill the fs without mounting.
>=20
> So, create the content on the host side, create and fill the fs
> without mounting.
> No more sudo or guestmount needed.
>=20
> This new approach works because the tests don't care about user IDs
> and no device files are needed.
> If user IDs start to matter it's still possible to use wrapper
> tools like fakeroot in future while filling the fs.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  test/py/tests/fs_helper.py        |  11 +-
>  test/py/tests/test_fs/conftest.py | 175 ++++++------------------------
>  test/py/tests/test_ut.py          |   4 +-
>  3 files changed, 47 insertions(+), 143 deletions(-)
>=20
> diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
> index 380f4c4dca..154e01264c 100644
> --- a/test/py/tests/fs_helper.py
> +++ b/test/py/tests/fs_helper.py
> @@ -9,7 +9,7 @@ import re
>  import os
>  from subprocess import call, check_call, check_output, CalledProcessError
> =20
> -def mk_fs(config, fs_type, size, prefix, size_gran =3D 0x100000):
> +def mk_fs(config, fs_type, size, prefix, src_dir, size_gran =3D 0x100000=
):
>      """Create a file system volume
> =20
>      Args:
> @@ -39,6 +39,13 @@ def mk_fs(config, fs_type, size, prefix, size_gran =3D=
 0x100000):
>      else:
>          fs_lnxtype =3D fs_type
> =20
> +    if src_dir:
> +        if fs_lnxtype =3D=3D 'ext4':
> +            mkfs_opt =3D mkfs_opt + ' -d ' + src_dir
> +        elif fs_lnxtype !=3D 'vfat':
> +            # Implement src_dir for this fs!
> +            raise
> +
>      count =3D (size + size_gran - 1) // size_gran
> =20
>      # Some distributions do not add /sbin to the default PATH, where mkf=
s lives

This brings two new pylint errors:
test/py/tests/fs_helper.py:47:12: E0704: The raise statement is not inside =
an except clause (misplaced-bare-raise)
test/py/tests/fs_helper.py:78:4: E1120: No value for argument 'src_dir' in =
function call (no-value-for-parameter)

--=20
Tom

--ZRc7IovizICnovSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+fbMACgkQFHw5/5Y0
tyxmTQwApFGqNUurURAWR39oZebo6DOXm4TqdfEv1TB1D5UkNEp8iBGOc07gP0iW
kIqxE3TtTkB8IBhyHeRKRPzL2df66q5wILLb1BGUa4QNr6GujDxIuVT7oE7JHU7i
qTdgDa++C2MRBoM6zxN5S/ulqrbG0jZ8lLgOp5ZPd+kX9qlc1IzJvWY9niklEvAZ
iPX9JLNa9Xr+XXwaahMQ3Rab1OXviS0IPRAmAEKi3jN82DkdbsuFu153QCeBw0Or
Ozb2CfRR1xUjYIkrnmfVADxHrTI4O9fDfuvB+yI//EpgDbadRveFdcMnVjxk2T/3
srOYUwc1FVD/EKrSXvPn7UrGdBxSxR8Xz9P25RLKqU8MPwhRTsDV5akZ38Z6qik9
1MwaBNrvSwQISCqlmai9frOQ6oJ/33mUvzy2ZFm9XLH5cP3vo7T19m49AfgXkqun
KQSXQrK/oPivFrJKt6MhLXwtAQsj4UDtqXW2r/FtuB1spJTWjau5PJ6aUYQUD1Vh
qftaUWau
=sERz
-----END PGP SIGNATURE-----

--ZRc7IovizICnovSG--
