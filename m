Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C05CF259B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58C388001;
	Mon, 14 Oct 2024 04:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dplFwN/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A25F8899C; Mon, 14 Oct 2024 04:24:57 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1541087D1A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-45effbc3348so33147261cf.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728872694; x=1729477494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NFrAy385yEmbt+2u6IcCo8vbFGte5pehNv0fo7DqHxg=;
 b=dplFwN/CwFm/lvIsYhOweNFABllby6Wc1y5Kvn9nDMZQmmHYwIrvK+qP0CshYxKuP9
 peIiamxeEw8RehK7Qvh6fN3MmExpNHoQErkV2z9LR8VkwU5iNp/5v+0nsnOfA03bv8mm
 MTgcmFQS4Ml+MSmnuvLX93hs/EfJBZ1kzjKI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728872694; x=1729477494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFrAy385yEmbt+2u6IcCo8vbFGte5pehNv0fo7DqHxg=;
 b=HGVmaZE9/K1lAnl9TMIHjqd4WTS2wI/5q1IEg7k/VR9Ust7QkebB0jgqqQpEExqeie
 ch89bzbMBH8dUrChRAp2pIeMx8dgKqnuPimgJ+9sDoyODM7c157GA5n5xNIHALcr90Tv
 /ib36liSK04llZPg2CeLS4fQIrtFvjqSdGmeHVr95Ko0BJv3YiEL4xs3+YkyfTbnPij4
 ZeRRg+wFBfMCFv+O2Gz6GgBBvfvZlwQ9oXjXES1GoLJOmLQ/XQcs08cGZ16g0Jwk+/+O
 4YLxyOC1BE5hkZU+GxCwF6fwT8L4chlukssB2mKxejD0q3/GhpGhq0C/0BbOMA5cUCMM
 iL0Q==
X-Gm-Message-State: AOJu0YzVvwOLg2HQgFBpk+TmxkwWplvqJOVx/5KjE+jMUbgOmIoumqu2
 bXSPz6mU4e0RMSVh1yUFqqh6hLa/CP747mdwMd0Edt1t01FtHd5JvdGm7H3VSuytBI2tVyLi4rW
 B6vI=
X-Google-Smtp-Source: AGHT+IHfUkEHdIMJe97FY/XsZpqZVOOYEdhs8NkNEniIEXXozlwUfavUCtJcEdrjw8/lisvg07YSCQ==
X-Received: by 2002:ac8:5852:0:b0:460:4051:1598 with SMTP id
 d75a77b69052e-4605839dc3dmr128576591cf.8.1728872693903; 
 Sun, 13 Oct 2024 19:24:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042789a5csm39853281cf.20.2024.10.13.19.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 19:24:52 -0700 (PDT)
Date: Sun, 13 Oct 2024 20:24:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241013
Message-ID: <20241014022449.GB53053@bill-the-cat>
References: <20241013201910.1485853-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IhVulKLSMNX6gj86"
Content-Disposition: inline
In-Reply-To: <20241013201910.1485853-1-festevam@gmail.com>
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


--IhVulKLSMNX6gj86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 05:19:10PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 47e544f576699ca4630e20448db6a051789606=
97:
>=20
>   Merge patch series "Tidy up use of 'SPL' and CONFIG_SPL_BUILD" (2024-10=
-11 12:23:25 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241013
>=20
> for you to fetch changes up to 19c0e50a6951b22cfe175986cc54bbbd2e85f30b:
>=20
>   clk: imx8mp: Add i.MX8MP Dummy clk (2024-10-13 09:46:05 -0300)
>=20
> u-boot-imx-master-20241013

Applied to u-boot/master, thanks!

--=20
Tom

--IhVulKLSMNX6gj86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcMgOUACgkQFHw5/5Y0
tyxk5AwAoT9/LS192grZbGVZPSGcmU3slHsuO4bh2k8Mv/d6CfI7L/kInNyK1d9Q
WYiSZaMD2OzgqhFuQniBppDJqQDmKqkaI9jarwE+ptJ1Ru6odJF8ei5P3dfZTlag
AflXoJQxfksHwydGPsVt905YO3ElleOyr612Ja3ctkyqsFYVh4Ru4brmBKZQNh8L
e3pJOydjNrpkAy6cHb/CIKr8WyxHOJIlNYKZcHdjBlx32t8Ss/ho/bs+C8qPOW9N
blx/QgPuPPrT1UrAB7lQBP+hXopJu7/7Ss+vwl2RJZQx1sXwx9YN3vZHuXRXgHgs
JrflU1PfHBTtM2jqq6HxnMG2lCZJgxN/sWCN8Nq6j03MRRWZ1KAIWUZkj7CHmrgu
wkHlWGjoiTi1eDh27rf04qLYIxPstrmnLx9M/vfFagU9JzmRYlx/fHQEtiimIyTy
OBT1frwI7pCHoRL8QkUtF+hS9Uu0nVP1bcOTB6c5Pr1awqlQZ1rg4SB1h+ydMBdO
Eg+A3+jm
=BuY2
-----END PGP SIGNATURE-----

--IhVulKLSMNX6gj86--
