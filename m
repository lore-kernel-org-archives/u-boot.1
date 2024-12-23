Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E1EE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 17:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BF780725;
	Mon, 23 Dec 2024 18:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ff0W0cOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A8E880711; Mon, 23 Dec 2024 18:29:59 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B215280730
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 18:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6eb531e13so214433685a.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734974995; x=1735579795; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ac3leiTxn59Zgtfl5byoDyJVkjxrD5iBMRzqA9sJPFo=;
 b=ff0W0cOAjTBv3XVGh9nFdkpjGU/C29ftganC4dlc1dAOzdcY1ZCzYCiPC8wLfKfoL1
 C/tiQEoOgDcEVQhHXRG9J+v+XxmS3d44r8WguZNRvAWqV1VQ4pHqrKCz5w83nTqvEXQF
 nugrPVjLwTMpq+XLql8F8cQFd+FXkZ5l2oJA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734974995; x=1735579795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac3leiTxn59Zgtfl5byoDyJVkjxrD5iBMRzqA9sJPFo=;
 b=nV7Iib6+P2eV0KNLMSVHuZyDgw53N2zgZxoQhVBClzq3oPDWeYlANVfwFhDnPlDeJk
 3me7ABabqH/01aGn0aLAR3eH4Ydfx23JtKASej9/xGKJMyI0VlKJsvg+qpeaBSNdhwOm
 u5aEowIgoPo4sl/CLxxb4RH8FwCOEslySGkJpWYMg+icB7Y8G7bfZGUZHofmTKh/0mwi
 oUQpwb+Ptg2gFR74/OChDigyRYFiwr3VBlKhysHx7GxYl6AwlstO4Zw/tydJphUMhmOS
 ZnDROZhYlIQFip8MLF6fFVkpiZOnZCHWkQPc5AHmr0Oo0uEWDN6tmpmt9AqxyWmQHxOr
 tYYQ==
X-Gm-Message-State: AOJu0YzP/54qk/q22bt8AECC4LIsc1Er2N+0565jXCRotnAp/4J4damt
 Vr1ociFQNHt1aHdATjKzeo0E6Wc3vffAmch0ZHElAtPvLUciCubNJfYUAotkApU=
X-Gm-Gg: ASbGncsKA+w/zT3QczOsm+xnOBdkabetmX5jItvjBr4k0l4Bbnk1lZ/Zr6VJYvrFAja
 BCDQvjrnA/b/xsyyqutak67LaVKdxPFj+9tOWS1R+eE+qz59GefeALWLboWFHMZaM+eXrBt12mT
 XLkJ5BT27QeBRdW/Mwk5P7uOeDAoeRHp76XXmyKMhdYgjAgYQTokXLa7dmzNrwvDKEGwyrGae9G
 RlpjgqiZwlezgHC2+iMTwSd1IPyac6BVHaG+lg1KonyVsVT12L+Zn+ifw==
X-Google-Smtp-Source: AGHT+IGZ1EEIymQtHeQxcpg84PTQpaLcPS3SpmRdFuZt6XxkG645XcvmB99xp3+k2KM+3DaZ9Zt8/Q==
X-Received: by 2002:a05:6214:260b:b0:6d4:2646:108a with SMTP id
 6a1803df08f44-6dd23329655mr227895946d6.12.1734974995564; 
 Mon, 23 Dec 2024 09:29:55 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb525sm45229306d6.97.2024.12.23.09.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 09:29:54 -0800 (PST)
Date: Mon, 23 Dec 2024 11:29:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20241223
Message-ID: <20241223172952.GS1505244@bill-the-cat>
References: <20241223131632.1507487-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ueg+eG49IVeyy96/"
Content-Disposition: inline
In-Reply-To: <20241223131632.1507487-1-festevam@gmail.com>
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


--ueg+eG49IVeyy96/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 10:16:32AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 5947cd76acdd65f48f0748af01241cb6c0756f=
ba:
>=20
>   Merge branch '2024-12-21-add-arm64-CI-host-support' into next (2024-12-=
21 12:27:55 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20241223
>=20
> for you to fetch changes up to 6016960ceb9d3fda591cda94df3841748fb65596:
>=20
>   imx: Use per board ddrphy_trained_csr (2024-12-23 08:10:15 -0300)
>=20
> u-boot-imx-next-20241223

Applied to u-boot/next, thanks!

--=20
Tom

--ueg+eG49IVeyy96/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdpng8ACgkQFHw5/5Y0
tywyOwwAjkGTnkNxw2cJRuOLFOBAyj6Je0KvVXserB7PNMGBamjjt/SJWapCT1vX
8tkccjiiBBS+WF0RJMGpHN5aZ9IL1h2dajziosQgBmtcl1pZVrRnk4BZ+IwUO2a0
zvimvwXvX/NbF8O3wAfj3KKb0kZqXtg9YR1A7zIjhknbf7vHjcRWtqQ1zvF/3ss6
+cDn2OSN/09IzJG3n2Dz6RTsDnnFhdMo6X0j8D8bw1mpUKcpmoUjdia2YqmsZUbh
G99KpyL3xDdfkwfTQbYeLo8hhAOl3e4ZlirLJmSRv4CrXOVTbv/pZrv2tAqZqFr0
21Au3I8oNObGvJdv6XRB+xm6N3WSuBKToeKrgN1qz43BiFmXAoqg775tuN+3wl8I
WeaLi0oGW6Hbjfsbzn0LzCtx+IudbD2dbfYQVnHmy/iJbK941lg+6bI133XT1hYv
40cVYccivJ7PXVR/TRTIa1XB2hOYddjZ0vOTGUhods2QdA2S+l6U0nC44MvBcjSM
NSNVURop
=xPdb
-----END PGP SIGNATURE-----

--ueg+eG49IVeyy96/--
