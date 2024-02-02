Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D24BC48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F7E87B8E;
	Fri,  2 Feb 2024 17:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VqC3TTPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B342987186; Fri,  2 Feb 2024 17:06:23 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E6187BDC
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68c3ac1fdb9so10169086d6.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706889979; x=1707494779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+gPYO3r7wzEkmj6Gz01V7cGsjGadn+6Ew0Mtv/VwwI=;
 b=VqC3TTPBbjJPHA70xa2AYqrgCcL12xI+PN18KuWE7RWVZ5/BDzvoVt8hLWLHJE4+zO
 R/d04vH5Ha1aHw1P8mU0M5fRfEaXa4CvedhTTxOmB15iSjfbHlWC8+EM6QMucwyIydJy
 /zwNwZWma905EQ9HITdrLqZW+N47VJpJq00dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706889979; x=1707494779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+gPYO3r7wzEkmj6Gz01V7cGsjGadn+6Ew0Mtv/VwwI=;
 b=abs/DZ1ABTgPn5X6ED4v5kxwB0aISoVLdFk7eLtxQt+gSfHiudPUmOvZVOL5/76UqI
 t6u0Q9Ypsu321/Y9oCHr7973diidAbzshr11AjZKu0RXE9gRep3TbujOWYDtcqk4Ynap
 kAHcjttyao3BBmvqhYuLbLus/0apzR3+77NofndoGJ9N3+dkjMGcpMhnYi8vHmnY5DkD
 4XD7neP5DTIZE70Tu8YFIiQtf5C8n7n3N3yJuY9NDGQHZGfvKs26ZBJjvj7LrocsziNy
 pPt5904Td3P41GlBEEFJjJIuWJG5E3h8HWWfcA061Y+xmnjN9DmLodmeBLzsyzXLJ9Af
 C8vA==
X-Gm-Message-State: AOJu0YyflUeV7e9QnuI8jBWBb4oyL5wDecXnbuAGVuJ25s6gNbREp9lx
 R19UWoxcMae/295AaBEh+rjn8rckNmmc4BSU326GKVzJqNlKSZ3new2051Z3KSAOC5BHrAoiH32
 N
X-Google-Smtp-Source: AGHT+IH1x+n29Xqhwhcr3hEBurvXkuZKMsKaba8DUBERSx5hbBVyhHTqE7+0QZDXtXCHCJKSMezizA==
X-Received: by 2002:a05:6214:2608:b0:686:261a:76a1 with SMTP id
 gu8-20020a056214260800b00686261a76a1mr11608774qvb.19.1706889978910; 
 Fri, 02 Feb 2024 08:06:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUt/kHwiGPvvN2anMTr4Et7FaHI4dQeGMyYfVZHLvxByNg6uzSEkb89AmrzGX1ejXxc67Q48nfBERlUarJUm1TZrwqU71K95Oib7PVsUIxSzJhPQcXYVUqln+fypa2c251U7+MDEA4Vnus=
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 a9-20020ad441c9000000b0068c3e575edesm921186qvq.87.2024.02.02.08.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 08:06:18 -0800 (PST)
Date: Fri, 2 Feb 2024 11:06:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 1/3] mx6sabresd: Fix U-Boot corruption after saving
 the environment
Message-ID: <20240202160615.GB1152441@bill-the-cat>
References: <20240202160405.4126192-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XeWbC0aiwftkaYSq"
Content-Disposition: inline
In-Reply-To: <20240202160405.4126192-1-festevam@gmail.com>
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


--XeWbC0aiwftkaYSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:04:03PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> U-Boot binary has grown in such a way that it goes beyond the reserved
> area for the environment variables.
>    =20
> Running "saveenv" and rebooting the board causes U-Boot to hang because
> of this overlap.
>    =20
> Fix this problem by selecting CONFIG_LTO so that the U-Boot proper
> size can be reduced.
>    =20
> Also, to prevent this same problem to happen in the future, use
> CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
>    =20
> CONFIG_BOARD_SIZE_LIMIT is calculated as follows:
>=20
> CONFIG_BOARD_SIZE_LIMIT =3D CONFIG_ENV_OFFSET - u-boot-img.dtb offset
> CONFIG_BOARD_SIZE_LIMIT =3D 0xc000 - 69 * 1024
> CONFIG_BOARD_SIZE_LIMIT =3D 715766
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XeWbC0aiwftkaYSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW9EvEACgkQFHw5/5Y0
tyzADQv/asM5oMDz7Lfx5Inw6GSrPbZ7ISQnuPTMtdCzD3p+eeu52zuW24YHZkNs
3lO7A9kh5glKN8FlXhieaeJNHjjHOcUNTupyLn8Xajh0QZh+bQsf2ic5imO7mctE
tHsIhWox2AfX/akLnUBGvX5sEhqo7v15jjsf8/01jQeeR2vrvcyVM4m7a6LKmbhD
5Hl/H+KCtFiJuhLLH3BlUvrFiWFYCPWOMOeiSJF/0bWxnkG52XysfhVWZGvdlRtN
igH3RPXWn9jv2xR/OQR8UaOgMC+t27kNtxshmwQEYybL2/cMw51NmPk0nCigj5HA
287ernZDN7jr7LIhjUWwB9JiCua9OCgmVgzuZY9N+tm6bVEdnDj8gKnDwYK07wOp
Uzuqgn5IDK9K4lFjTWW018h59xv0wkf7xb0A/3pPU65Z3mafVSyjZVsNxVvHTg/q
CZiQThVW0ihVmJOyRe93KrGojNnRmzGe3UyNNawJwqesQzLg7OuRjnizXM+NNd/Z
UPRlAUNm
=hz9B
-----END PGP SIGNATURE-----

--XeWbC0aiwftkaYSq--
