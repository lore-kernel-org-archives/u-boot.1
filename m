Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A71FC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 18:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02FE83015;
	Wed, 21 Jan 2026 19:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W4c/sBLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D912283946; Wed, 21 Jan 2026 19:05:03 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE9780077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 19:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d148ddb583so91403a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769018699; x=1769623499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mHeviWLK3/56HXCCCdcS8e7ic6NoBrLc7w5bnzAYCCQ=;
 b=W4c/sBLz+GLKv6QzPfp3+MeZUT2AFrlQaK0gpUbwwK7wtu0CcPXdEKoI4uwQ1ERGtU
 fZHskMM2zZKnnwyxb9AAwCOP4iiNP7pDfjhgwWncHoDWE1ERhRF4PYkuvRGvDL5B3OmZ
 LyO7imvqsZyvsOfJ9j6jaz9sZn/XXEPrhAGpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769018699; x=1769623499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHeviWLK3/56HXCCCdcS8e7ic6NoBrLc7w5bnzAYCCQ=;
 b=I9oaexEriDRP3T2GyT00nfVHp6an87rOHDENNR9RTFc/f4ed91bcCK0qPMWkg+pEsw
 nV6qcHVgYL+vr2XJc8Xff/eSE6nR508hP1yUChn1GD0MDrocMD2PHDyQJhFfo/X5sL8N
 /D9oVbpKnv3BIgf4Fxc7LL4zLx9inLZ7vM6m2nuze/WSwkHAjzyn156bsZinnzzsO/bX
 swI21WdmxPlgm1ExpYHbOUsaXq1Dc9IYlYfXvNeKtECK+NVqHUPxfUb070N+YkuZBpot
 uCsaXsPhK8fr6UgF6mdjftqXs9T8xXkdYU/V+4753K44temhINb2pNGKGgGL4s3FUzfi
 ttHg==
X-Gm-Message-State: AOJu0Yw7dK1XAZ5YI6js5NzcWgnja9OKRqyZsYxYuzDJgCTiQCqOwf+E
 bAVVWUrqGwh5NNm4xVDdVnDxMjFWHdlAGIpbTRUiKKfrbi1mIR992wC/+qEJXuOMQpM=
X-Gm-Gg: AZuq6aLW2pzFEbTBI0naS9oUrxs5YrP7qNs6vPoHkcLoaj6oSALVaU9M+1J6jOX6QAn
 NR/QaMr1J+l8lZWQVGaKiFcDiyGmoyyrBejZs2gnNuoWcK1dL2qnjBH65zGp6JjUwUpWe2FnX4N
 2+F8LRuu7CbIaf7s6OxXQHEMckBHkvw26/1gX3jDBe7aydiXFdosCqLOyyBWK2vCpuDJUU37em8
 O8N7AUa/wP3JHDWz8+d7PJOUvjgyphOjJwWhokcV2BzjnxtYxgYc9VlFC4b1DpGs/QSzKYLE61U
 aksPjdnVbUMa847RrCoRu+fJvkzMYjRN8wFoMJUrbihQa8M55E3Es+Ql/dvjLToycSClAouhpIq
 Q3nDUP0/hQQOhc7U9TeJEFEfyQdyBOz0ylkCKqQ35WTyo1QIrQVkFFRWsJBSVVsNmxJMeNXHxL5
 MSogvYLomPdY66OnZmDHiz8hj/MNWiUwqx3KnWAT2bQjrahnrjhg0h7ibkOF74B/nPqtQDlLrmD
 dkNT8ijXb4B3jNvZ2ESqLETSN5QEReQyjlLHOA=
X-Received: by 2002:a05:6830:81ea:b0:7cf:d168:1ef3 with SMTP id
 46e09a7af769-7d140ab69acmr3628604a34.23.1769018699430; 
 Wed, 21 Jan 2026 10:04:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b57e2sm10952668a34.27.2026.01.21.10.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 10:04:58 -0800 (PST)
Date: Wed, 21 Jan 2026 12:04:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/4] board: ti: Add 32k crystal initialization
Message-ID: <20260121180456.GA636079@bill-the-cat>
References: <20260108143713.1130054-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q6RuprkLrwSYXKE/"
Content-Disposition: inline
In-Reply-To: <20260108143713.1130054-1-vishalm@ti.com>
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


--Q6RuprkLrwSYXKE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 08:37:09AM -0600, Vishal Mahaveer wrote:

> Add 32k crystal initialization support for am62x, am62ax and am62px TI bo=
ards.
>=20
> Changes for v2:
> - Created a common API which can be called from individual board files
> - Squashed defconfig and board file changes into single commits
>=20
> Vishal Mahaveer (4):
>   board: ti: common: Add function for initialization of 32k crystal
>   board: ti: am62x: Enable 32k crystal on the board
>   board: ti: am62ax: Enable 32k crystal on the board
>   board: ti: am62px: Enable 32k crystal on the board

This breaks building of am62dx_evm_r5 on current master, please rebase,
thanks.

--=20
Tom

--Q6RuprkLrwSYXKE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXEVRQAKCRAr4qD1Cr/k
CvvjAQDsEK5gvv570qWlvb2FLeTnK4Y4vbQCCgzjVtAn2lC7qgEAmEXwruPGWCWZ
cn3NUjgYgu3RXGYSeiR8kg0ouYgwlQU=
=qI8m
-----END PGP SIGNATURE-----

--Q6RuprkLrwSYXKE/--
