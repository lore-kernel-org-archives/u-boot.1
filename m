Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5238DD3DEA9
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED74488A0E;
	Fri, 18 Oct 2024 20:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dCid8nXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B959B88B23; Fri, 18 Oct 2024 20:33:00 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550E288A0A
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b153047b29so112856385a.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729276377; x=1729881177; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QEGqLj8TIMj5nrDxtvJOVOSBca0/e/faxD5SNPV9jN8=;
 b=dCid8nXIjS/WNNAxuJ9logOsOUudcY5aTySWAlgGuqBOjKpSXtQx2vQl/NDlD+W3e+
 5r7jwKguTHtiNaIqLKYj2kSQv+lIpacGhDQ8yna4ld9VZyw1iPYealGHfyeVK4VctB/B
 3b3Y6E0gw3D3ub55DVnNLJoDr07q9a7NA0oHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276377; x=1729881177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEGqLj8TIMj5nrDxtvJOVOSBca0/e/faxD5SNPV9jN8=;
 b=oYWTVBugsXMV706J+fz4Xk/ja5otzS1LcpKrmlZ6RYrCXim472RObSNK1L+9QTkc43
 o2ZFpmaChd5p6vzBNEQ2qfX0y6pTq0lUu4vxzAvcLJZFU04lSGTn11oLu13J+NRBj0+B
 vxxGckEAh1RmoMfvI2qxapYkGOP55EOtb9oX/7e07XaZ6AYsoISLOiDMsDkBNTU0K/Aq
 hn8047tDFErFAjjQFUqSwgpNV+MxPTchMKl+lCy2dg7sM2Leu98457YHXVlxtLPJv73o
 RcHqvhyTjFqeDK0PzxuiwzxpuFrZ4eGw6HqUeiKN96XngswhkAs3P4GxCugnV0D5Nvtk
 mEEA==
X-Gm-Message-State: AOJu0Yzy21mzra21taT5wmO+8zb/5PhDzhe7a5aC/QSq9kF4FaDgYTzR
 pZW+/NDO8ksE11v4YRGCmQ2uhWwE+ZCQb7LLIP0xkehpX/fq67NxcxDMU7nvqqY=
X-Google-Smtp-Source: AGHT+IGYV3+z7i4Jx9Jsi4u4LvQ1V38R4XFFGsq+Z2Qcnl1ByqYRoRvf6qePf8uPFTskSSl1fohsBg==
X-Received: by 2002:a05:620a:45a4:b0:7b1:4fab:9fb0 with SMTP id
 af79cd13be357-7b157b5a975mr311124585a.18.1729276377112; 
 Fri, 18 Oct 2024 11:32:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156f8b2e4sm91973585a.20.2024.10.18.11.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:32:56 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:32:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-at91-fixes-2025.01-a
Message-ID: <20241018183253.GG4959@bill-the-cat>
References: <4cfd93f1-84c4-445d-82e3-73ade26afd4c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z3fuvazCjlzlaTAb"
Content-Disposition: inline
In-Reply-To: <4cfd93f1-84c4-445d-82e3-73ade26afd4c@linaro.org>
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


--z3fuvazCjlzlaTAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:55:16PM +0300, Eugen Hristev wrote:

>=20
> Hello Tom,
>=20
> Please pull tag u-boot-at91-fixes-2025.01-a , the first set of fixes for =
the
> 2025.01 cycle.
> This small set includes the maintainer e-mail update and a missing header
> that was causing some build issues.
>=20
> Thanks,
> Eugen
>=20
>=20
> The following changes since commit d2061828a4c1b60b44cd2307b6a782ac2efbff=
be:
>=20
>   dts: Deduplicate dtbs target (2024-10-14 19:32:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git
> tags/u-boot-at91-fixes-2025.01-a
>=20
> for you to fetch changes up to 684939089a31b8a5bedbbb4c2f2bcf935da7d9c6:
>=20
>   ARM: at91: clock: Add missing include of asm/io.h (2024-10-18 10:10:41
> +0300)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--z3fuvazCjlzlaTAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSqdUACgkQFHw5/5Y0
tyyuagv8Dj2+oxKVPgar5/I8BGB8q7lUfwBC4JFVYuphvzJMlg0mfI9EIVco+PQb
mewqnsd839p3agguFtao+hL7xooeqyIBCNA+AlvnwPM4d5y9cRSDXJsxRnfCFulK
3TOU7ncLVSDRkzO6mfDwV9vbbQvFzZ+QYJgydJFcyIekLLJNX2KDC2HmzGN3id0w
5gOKF+7Nmaw/5ewliP0o5GAGAqKITr3hGc8m42ZzJVtRxNU5lcU7shFhlQS74rxO
PPWvUSZwzgG4mv1QW8N+lXy8taBMOaSzp2px/0NjPs3G0YmBHHEWYce/Vo06Uvv+
MVdKnHHBsCkzZz+JdTQNP69egcYcw1fjuA1VfaqGUcfLfRy9GSueXt064JSh3wBQ
3z7KhrE0S3Mx7TjhCb+3ybB7fYlz4Uaimq7YgwY6DJhXhMXenZiKubCuHya9W+cT
r5TU9/uOibW3tOwT2o2zBtR8ygZbuKXB4jzJRZuo2eiamdbHNUGdGVV7UYpfOOE3
4/ErjaWr
=pPEe
-----END PGP SIGNATURE-----

--z3fuvazCjlzlaTAb--
