Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC7CC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA31387FF7;
	Tue, 27 Feb 2024 16:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JtcOF2sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A30987FE8; Tue, 27 Feb 2024 16:42:42 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B9087E92
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6092387bdd0so10386597b3.3
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 07:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709048557; x=1709653357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kc5wjRejfyLkpEw6cnSIcxKQbkwQMLiGCo48qbuYNhY=;
 b=JtcOF2sz6X/IUmmsSiNLx7dTsBsXrbhbfP00FxNOn4bhvE9lHzM5ZnBq3R/TWA3sUC
 p5MUeSgOe9z04iQbLzpu+F65Z9C3JR+D1m2fYqFrIT5MyNNAjE2pSMj81yJ3gtTlvfVe
 up5tcsMPqES4fTlVfDp1ecVBsSieXNtbnsATY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709048557; x=1709653357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kc5wjRejfyLkpEw6cnSIcxKQbkwQMLiGCo48qbuYNhY=;
 b=V+RN1Np9CpkT0sO3bdYVsFCiNnlx/Dsufl4WJ87qVWfmsXb01DkBkWF+HrTVBnSnQz
 ChL9bIJtsxWDC5tsHnrbhu6Tbvzs+8NmY+FXIK3jtkiTaA+ELqqc3k2+WYyUffhf7Nqv
 LzOjdjqDPWEH0aVjUHgpp0yWeataL4m2RTuSd4HwtSfvYWZ/acMWZO6O56zSNbMrm7lj
 dB9FUosGQCp2Wur0VsMA6Cdt9e0XH4G87ezsF2jtLqlA58RVTAEGIeUCPyHIjI3NzWIV
 ZApp9/7oMu2uVehZ9rFn0N8t0uIAjJVpirTOBvsieM5HNZ0OCVdsh+sGpl9ESIlWCljl
 rl8g==
X-Gm-Message-State: AOJu0Yx9sjFmlZAWDny/3Y9LblBqHnqbpyhl9vAv7ABUB51VfWPihANy
 avJzPDcdgae8jJsFbxOwn2GiYbkQO4jEMeGNY4V00Pihhvfopkd15YH8jejF0wM=
X-Google-Smtp-Source: AGHT+IHRqwqrTDnzzows9XDUvbOkxOBBH05e1W+xADkpEE94aZvQnBeFcwsh1Ag05BzLtdVkSPEr7w==
X-Received: by 2002:a81:a981:0:b0:608:4cee:e71f with SMTP id
 g123-20020a81a981000000b006084ceee71fmr2321663ywh.32.1709048557614; 
 Tue, 27 Feb 2024 07:42:37 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 l18-20020a0de212000000b00608b3bacb09sm1837008ywe.46.2024.02.27.07.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 07:42:37 -0800 (PST)
Date: Tue, 27 Feb 2024 10:42:34 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240227154234.GK3040305@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nSgkHIwzn6hgUL2k"
Content-Disposition: inline
In-Reply-To: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
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


--nSgkHIwzn6hgUL2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szymanski wrote:

> Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
> linux") removed the display timings from the board device tree whereas
> they are still needed by the mxsfb driver.
> Add the timings back (the correct ones) in the
> imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> opos6uldev.env file.
>=20
> Update the opos6uldev_defconfig file so that the LCD turns on at boot.
>=20
> Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with linux=
")
> Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@armadeus.com>

What's the long term fix here? Why aren't these needed in Linux anymore,
and perhaps why was it OK to remove them? This is perhaps another case
where we as the U-Boot community need to go and talk with some Linux
Kernel community people. Thanks.

--=20
Tom

--nSgkHIwzn6hgUL2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXeAucACgkQFHw5/5Y0
tywSwAv8DEpvbLaUqXM0VeGdemn5f4eDeydEllMzqWtgl29cTJ6BAlTVQyaJO6bG
vZhnvm38FQVlX28DsRA12f2R0H3ywzlbPNQeX4IbH74qkWlCO9kac0DxyEBdd6GQ
W8Wg1VFgPy2mo95uOLDTOT8tPLknbyWxeFLLV4uczoRsxAVNLv23eJiwWErtfksW
aIU5WJjNNCxRVwhw1IXPZk2pTWgdSR3EFvPXv3qSWya88qm706hUNp0po3s/OneE
A5l48KPb59y4Gaale+kQij8D0DuYrREzSLnKWq2hGhImGJgg3tvYg7ODeoQ8KhgE
Se7hJOmic0VDnwAt0RanFO+bjEnbgA1jkk2hznz+tMZRiKHT/w8pbDdMAMEg5PrA
ftIwS2B7kaTfQOKh2aHq4sC/72DWyFuryycXMVb9enX6OxA+QKRI0/2nHu/MVJkS
MIb7hmPbGOpZzvePA5juc/Fl35JHEjFJWhTixtPCy37rniaEMIolrSrrAFhi90rY
gEMeHpf0
=qdTJ
-----END PGP SIGNATURE-----

--nSgkHIwzn6hgUL2k--
