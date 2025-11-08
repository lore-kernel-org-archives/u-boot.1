Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69D3CCFA13
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 15:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0128683E4C;
	Sat,  8 Nov 2025 16:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K/W2xjtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD0783E61; Sat,  8 Nov 2025 16:01:59 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F8483DF3
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 16:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4439ecf6004so843937b6e.1
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 07:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762614115; x=1763218915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/bQi2pmzn95cZtu844o8W9U5h0kHDutH7rPrbW9jaM=;
 b=K/W2xjtF6If69bs03EdqexJbbPLZdiMTuJiNrJAmV/hI02mRJUS6GNfcoAcuWIHe3D
 1qXdAgATm0qZKKA6pLfCTB7YHlbcsBuSztZS82suSXjwjUS0OPqmu+S1TaM+AIFyQK2J
 +m1uwViX5zRrigTeEkOpSdc8fLWoM6PrKis6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762614115; x=1763218915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/bQi2pmzn95cZtu844o8W9U5h0kHDutH7rPrbW9jaM=;
 b=bhi9bbJOHH1eG7LNEuRVgGMaRoVDb6lR8d+n/4eHsJ/C4AvwO4CHv7svnWtBxHZrMK
 SRR0VAXtg0VfFVMxuHssVYEXYRWrN2Abl94dy1wioZBI24O+aCJZYGEBo72x4Yw244EO
 DZqUv84NDbcdxwK3StmaSxD7V4nCr0/uIqN77u2ebq2CxLbKNF3gXQ96VbXStx4hrMO6
 IS7uzpKhjUe9cymRsYfLzobFwVwqX0HMSsLxuKtOBybJYoYUMvRSLzKtrj2DBC1VMPuL
 uwoDairIyCOudRMjReAqeifA7UgeGyTD5p0R/NvoadVneovAR6c+p+a2AdzTRsABovfH
 q+/A==
X-Gm-Message-State: AOJu0YzBbnTX3ZW8w08tHVJZXkFtvjTqB8W/qwA/O4a7Fhw1WpeKdyJz
 W33mL6oIIuqg8FGl+938EqysrT9W/j2j/xAWuRzVtaRgGnN+2UZKQr4KK4wklGPSLMNjE8sRAxf
 mTgqb7t5K9Q==
X-Gm-Gg: ASbGncvBEzzAAGbv0fXkg2HweCTMVfsXQ0fZ1yFuCnk/Dy9KTxsJ5P4c4mUzugwO0mH
 VD/vxZhA6trprUZ6BLU9Iwhtp90JoOmcEGxJqfRr6W3STRQuMTbwumiAJZiEBoZlZKBgTWdOtF2
 qvpNTFb3ev9E1a+OwFTUKK5+AGc/XJxLYuWspIuNers9Dg0lP5OkxQYhjXgVNNIZxFoLx1/FhjG
 c6wbJpP7rUyMOwQ6jCxoqBppTnvDVsQHpPYIXTK5oFV5jGiVjwxcKliSfwCareY1jr8xcaOSNfX
 aiD3HiSEAuwxDge/x6nIn/ztb+UW0vMcn6sixDik6+hK1u5adTc6hK3QB8orDhlYYJQfilN5N/2
 O3G8ybGc6wSgvgUUVT1Cu6BoBbKrNjepdk80raQfVkWWfyEHEWVsZr+1VI0BNIKwoXRFFqussnb
 pvgKy9bC2BS3Vw+d35StciTZJo6OGGnHmKKYWn7N9PxCN6pLgwFQ==
X-Google-Smtp-Source: AGHT+IH7ihw+M0hIOr6DLPri51xPRpVs/LWq+JFEYAWxTnCc5Gll8MeWy23t1WzHQ/jCAAOKn4i9xw==
X-Received: by 2002:a05:6808:1903:b0:44f:9b51:2256 with SMTP id
 5614622812f47-4501c746d03mr2719957b6e.10.1762614115364; 
 Sat, 08 Nov 2025 07:01:55 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f5ea20sm3102955a34.13.2025.11.08.07.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 07:01:54 -0800 (PST)
Date: Sat, 8 Nov 2025 09:01:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 0/2] 'part name' subcommand and some robustification
Message-ID: <20251108150152.GJ6688@bill-the-cat>
References: <20251020121100.1742812-1-ravi@prevas.dk>
 <20251107201927.GA2243313@bill-the-cat> <87pl9tcry1.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iHoUbJCLXSa3KtEW"
Content-Disposition: inline
In-Reply-To: <87pl9tcry1.fsf@prevas.dk>
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


--iHoUbJCLXSa3KtEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 01:02:14AM +0100, Rasmus Villemoes wrote:
> On Fri, Nov 07 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Oct 20, 2025 at 02:10:58PM +0200, Rasmus Villemoes wrote:
> >
> >> Implement a "part name" subcommand, mirroring the existing "part
> >> number" subcommand.
> >>=20
> >> In the discussion for v1 of that, it came up that there's a bit of
> >> inconsistency in how much and what one can assume to be initialized in
> >> 'struct disk_partition' after a successful call of one of the
> >> get_info* family of functions. The new patch 1/2 tries to consolidate
> >> that by making sure all ->get_info invocations go through a common
> >> helper that at least always initializes the string members.
> >>=20
> >> Rasmus Villemoes (2):
> >>   disk/part.c: ensure strings in struct disk_partition are valid after
> >>     successful get_info
> >>   cmd/part.c: implement "part name" subcommand
> >>=20
> >>  cmd/gpt.c              |  4 +--
> >>  cmd/part.c             | 16 ++++++++++-
> >>  disk/part.c            | 62 ++++++++++++++++++++++++------------------
> >>  doc/usage/cmd/part.rst | 13 +++++++++
> >>  include/part.h         | 16 +++++++++++
> >>  5 files changed, 81 insertions(+), 30 deletions(-)
> >
> > This leads to some of the bootstd tests failing in CI, unfortunately.
>=20
> Do you have a link?

Right, sorry:
https://source.denx.de/u-boot/u-boot/-/jobs/1292597

> Also, how exactly should one run those bootstd tests? When I just build
> sandbox_defconfig and do 'ut bootstd', I get 130 failures, so I assume I
> need to do something extra.

So, you want to run it through pytest rather than directly, I find:
https://docs.u-boot.org/en/latest/develop/pytest/usage.html
And then
https://lore.kernel.org/all/20251029143346.1320868-1-kory.maincent@bootlin.=
com
has the full rather than partial list of host requirements, if you don't
want to grab the docker container CI uses and run inside that.

--=20
Tom

--iHoUbJCLXSa3KtEW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ9bWAAKCRAr4qD1Cr/k
ClUYAQCUT8v2CARH1Dx0sneKccPYFq1+lYuu7oxANrqwsxOxcwD/YzXYa/MnVb1E
CWqWg7TWraBt0IuBcqtDz/bckb/DjwM=
=eyUk
-----END PGP SIGNATURE-----

--iHoUbJCLXSa3KtEW--
