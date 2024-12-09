Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B009E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0948975B;
	Mon,  9 Dec 2024 20:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="itqTe6KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C1A88975E; Mon,  9 Dec 2024 20:01:55 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8416589723
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6c6baf8d6so162637585a.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770912; x=1734375712; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=57Ib5xugn5NGXscjIk22Lj5BrOtd6SjUfMtOuOHqwSU=;
 b=itqTe6KHzZZ9HZtnSo+ZBceqFFWhysh6lI1TVtbvLrelWXn7YgAJJvFumv79Y7zqrK
 ddX+Oclok3oj2Oaos1GWxCOCHDB+xRlgnxXu2KF9WhOfCjTSkDCJymk3l+JEXjfdMrDN
 UYLJWMgmheYtW+roumzNmNKPtfjRLRPTD028E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770912; x=1734375712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57Ib5xugn5NGXscjIk22Lj5BrOtd6SjUfMtOuOHqwSU=;
 b=VyLUSMcaBPW8i/b66oj7w5acGH4U1ds+sKa13qiaq0k4ZVw65ZXHcKC9VijgJKLnKi
 GUfGbmH2UC0cYnKxPVRtewiMbARnDnhxChNRtiesmNrB76ZM5tX3CMPtcJF8psF9BusM
 fmMiQvp+Rqe9Fk1BioaEED6DLCEl6N1xvnD4isrRwtpTGyOTSOaexghIOn22Noa8+DIT
 UMyByLlcIXksNuENlvzLEVr0a+pCDiOOxno8nOYmTBieLEchzC8MwC/PStCNIWZru2QP
 7pkcZktBv06heTfXNH2XaMQWUKDKyoxq024oz7bam7/lZ/6jEI4QeUE70RynZNkSCXZK
 I4hA==
X-Gm-Message-State: AOJu0YxmhzF+oyQsOFsULzlkepkGs5pXz1mOyYi2myDbnl+KQWVHGuNN
 Dc/H6AJ1zLRKPQR/OazzIPs1j+sRg9QLKvZiFUo3BeyuM57lC8pOMCnAc1NQWqU=
X-Gm-Gg: ASbGnctEdcdPultiHAewBAwSI3cHRrc7FO+ZDAF9ezqNHcB4DnsjaMDqVP5AtpXu8+D
 qKfF4dSfxgsyMHNqixO+ZfqIvLP8Wnd8plNJv5LGtcEy27XSxf/7wZOR84jMIc0U+OBpEV6zK4D
 /9P+Rxy5BLKfbhmzlEMYxEtdJqes4UacUoepFRZpDbs4vlKlQAP2EsCdnf15zEbNkLBnhdvnYNT
 UoN6KMKSiAGvvnSiZKaYte4l0m1gTp15g/dpzUDksBNW1wyzzI=
X-Google-Smtp-Source: AGHT+IG3rSu1/sXXyYyTMpewthPheKznBNCnej7lVscaIbs3+yZmHdeGw8gKyVRN8MYjLrn296vIDw==
X-Received: by 2002:a05:620a:400a:b0:7b6:d799:1f83 with SMTP id
 af79cd13be357-7b6de6bc74fmr93464885a.3.1733770912271; 
 Mon, 09 Dec 2024 11:01:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a46944sm465334285a.26.2024.12.09.11.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:01:51 -0800 (PST)
Date: Mon, 9 Dec 2024 13:01:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 3/5] rpi: Drop fdt_high and initrd_high
Message-ID: <20241209190148.GS2457179@bill-the-cat>
References: <20241209182002.671953-1-sjg@chromium.org>
 <20241209182002.671953-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UxdzjceF1URy8yqt"
Content-Disposition: inline
In-Reply-To: <20241209182002.671953-4-sjg@chromium.org>
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


--UxdzjceF1URy8yqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 11:19:59AM -0700, Simon Glass wrote:

> These are not needed now since there is a bootm_size setting to keep
> things within the lower part of memory.
>=20
> Drop them.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--UxdzjceF1URy8yqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXPpwACgkQFHw5/5Y0
tyzXnAv/UXvL6HZva+wFPfDAcuToYSKWGSZIFZAjOoycyc1EdvuJLCPsMw9cd8kx
XgATEbujiKGYVxVxBceJTN9brrSw7MSGW0f7xInDYLqr5jKu/AxdC5HMMGkWfSUE
/Bm+YJ2msrb5eKvqb+LVaS+dtLPQsk8D2rP5UHkhJ5G9GVsbnQb27OH5EQ6tHy5X
ActPq3b1NhZREyGNPSIyl51XJsxqI7a7AcuUmiHmNcB1YvsznZtc1ymJdDc808ie
CljSx6/stXElrpfCRO2GLYfFRiwQr9DYzTOjsvXf4oNNvJ9E243eccDvrTQqrR8x
5VVtUTAFZpN/P40UQU0f+cNjx4T9Fwu6LvabrOc+4liSrWftk3OP596BJ5fj7kmD
Dj1wkzvCmZzlL+l+zipYPOllFJpV2lohNe4s/06PeojZ4RnniWd73whG4YiysDXZ
AM1BS3L+GvXHi4elzr6lDgY0Jqqdbew0w9mUbcMZmi8shy3GqABrfBo/GQxK/s/o
bNyPupMu
=x+7g
-----END PGP SIGNATURE-----

--UxdzjceF1URy8yqt--
