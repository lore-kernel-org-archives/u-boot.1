Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD351C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB6F87A30;
	Wed, 25 Oct 2023 01:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WPfPPq0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0716F879F2; Wed, 25 Oct 2023 01:17:09 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1AF879E9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6cd1918afb2so3088876a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189411; x=1698794211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xZHr11fotBkPH1XXj78RnvCmTwvqvvfzqKB/+5T508E=;
 b=WPfPPq0DY/Y4V6suVnu9FPcIM89ktFAcpvlwuR5rrQuH4rcHONCzrbA8wdAv2o40wU
 XT1/cBGoI8o+aBijiP1z9vkF/dK+8prsD4gAKH2JfD2TqHZVaLkSJpKieKpI8Z3t5l2d
 rZf9ZF16dy9+i3Q4X0Zy7hnKFjXJzAlcXPrfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189411; x=1698794211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZHr11fotBkPH1XXj78RnvCmTwvqvvfzqKB/+5T508E=;
 b=kPv6wKOCAcJolD+6RfkoDwmo2P7u8o5CiyTCyRD0eL8DCfRPyRTgBeYbZQBhEl+J3T
 2FiX39UvJFAgRV1WaYxgFGIDBHcCez/MU9hfChPOQsizZDZPMTLH76KFdh3iZBde1Mbh
 NK0Oq6BnxyW1UMN2I6kghcW6C8zKEsFJk2WewE17uEM0X7b4sF9ewPlio1JUOjuo9Yq0
 iYGJGRlfFYaetrTJW1xRsx232Dv/XA3Uqahjj30fNQICGEPDCSdBmNpAHhsya9q6cL3e
 aDfC/QzVj+yx1zxKu9INOw7RLtPvMga57atDkARQkLl+ypC348GmgwaMZupkjJjQX/C0
 ziqg==
X-Gm-Message-State: AOJu0YwSUEUEfIrZ7MddG1W+BlBz2rVQ3I4UoEGy6AVAMr7B19dG+I8h
 9NwjzMs992/U6xTQNmzJbNm2hw==
X-Google-Smtp-Source: AGHT+IGfRzKAM149srdbomyRC+xr4u8hTMCiMJFGG1UgH7HAig2oviI5zdHdwrcT6q00RdLmA60ugQ==
X-Received: by 2002:a05:6830:16cc:b0:6cd:179:f80b with SMTP id
 l12-20020a05683016cc00b006cd0179f80bmr15717030otr.30.1698189410774; 
 Tue, 24 Oct 2023 16:16:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 l123-20020a819481000000b00585f60e970esm4511372ywg.134.2023.10.24.16.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:50 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:48 -0400
From: Tom Rini <trini@konsulko.com>
To: John Clark <inindev@gmail.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Makefile: remove misc include and simple-bin build
 artifacts on clean
Message-ID: <20231024231648.GB496310@bill-the-cat>
References: <20231013132338.42127-1-inindev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pUQDqnSWvC2Sbe6c"
Content-Disposition: inline
In-Reply-To: <20231013132338.42127-1-inindev@gmail.com>
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


--pUQDqnSWvC2Sbe6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 01:23:07PM +0000, John Clark wrote:

> make rock5b-rk3588_defconfig
> make
> make clean
> git status
>=20
> before
> ~~~~~~~
> On branch master
> Your branch is up to date with 'origin/master'.
>=20
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	include/autoconf.mk
> 	include/autoconf.mk.dep
> 	include/config.h
> 	mkimage-in-simple-bin-spi.mkimage-rockchip-tpl
> 	mkimage-in-simple-bin-spi.mkimage-u-boot-spl
> 	mkimage-in-simple-bin.mkimage-rockchip-tpl
> 	mkimage-in-simple-bin.mkimage-u-boot-spl
> 	simple-bin.fit.fit
> 	simple-bin.fit.itb
>=20
> after
> ~~~~~~~
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
>=20
> nothing to commit, working tree clean
>=20
> Signed-off-by: John Clark <inindev@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--pUQDqnSWvC2Sbe6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UGAACgkQFHw5/5Y0
tyzerwv+LzqUNJtKOtLHRStP6zuHPhpfGnYDXfaLvT83YfsX00qEJ5Zj6pktpKgr
8F5BZjAmNNNw3BydIU2bypK89MkutSNWx+Tdy9bKvkEovSVLGicG4q7Vhb5bv49u
FEamEMOO6dvxDeh5QiQkqhiLCbNPeDxpj/AGxi63KqyHA0lUlkWNdVmwx2Fy+QvH
AyJlWReAU6ZsMSTppy4EAVl+XJZoN5dK/YsUesVxwTkOfvkgQOK4V5yI+md971OQ
InN1fLpiqFKST8jrQUx6r9PY1twp+RpBJ3/bNEfUKEn34ejpH7BYQVZYpxIUdShc
Q0Zq8myGjkTwgd8p7NAxI/zYesz6boVXil3LMQMImlEenFoGQj/iISnloCU83wd0
tFKH47r+eUdZdod5MLCDDBQkePtKEYNkM2I8xTdNrcdROoa3gzQavHJ0Js/d64Gp
m/+VGVZgApUs7QmQq4WAEfGdokdlj507Q2D7gfiYqs7vZwLZQj0ZJA8RBjqzZYzi
6xiRJHFu
=VT2N
-----END PGP SIGNATURE-----

--pUQDqnSWvC2Sbe6c--
