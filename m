Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073A1C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E0487779;
	Wed, 29 Nov 2023 17:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dhsTNv4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 698B38777C; Wed, 29 Nov 2023 17:58:09 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233FC87777
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cd3c4457a0so68351467b3.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277086; x=1701881886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nHYYKf3vZZ4Zjnf03q45/WfZDC8eXnNivqzN6leikpI=;
 b=dhsTNv4VQdgiFTlQIAKF3Jm/DawTSWNUJOA3RxYdz3Xjr2TD3t2t2fzaCGYlzzhJSj
 +9PdbvNLgG/56bnF1UwacU0T2oxgZKgc7CkWIUF7F7Vny+AmPWOY1uTKzwdpB29tPK+E
 wYVPU0v5ZC5K0Wk1pxxM2TQ3YRjsPBQGJTdq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277086; x=1701881886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHYYKf3vZZ4Zjnf03q45/WfZDC8eXnNivqzN6leikpI=;
 b=gfKvcHYLw0gZ1ACnZATyHpd/sls3l2GwlUdOZmzaVnCuqNNamSMQdpT5T/97AwMWbV
 xVue+BjWcapYQQVSxhzHgMVdL0SaGBBuxwP9a+k5X72BBXGmXUtXAyYc9tfZdgUyAqxo
 NC7hJIgUJhbTs1kRKP4+x4z4jr7zXisub3jALkE+2g6NE8RxRJ8XvWetdfPUgkHF7UZ5
 T3GSH8AacYEC/zO0LdHKQbHMrTlRCCD81r4g83zR3qQmUlEW6kvhHWrAl88/j0KDJwDi
 MHZSlBuVs1Q8Sqd2YV4r/6nnYwSOD6xQXurRW86T9PFAzxD3CHhmSiylBsN6Ckim/94s
 d9kA==
X-Gm-Message-State: AOJu0YxrbakASEtXeD+fJOxN6N1wSN2S98To2N3RpbKlnxUOIJ65kOmZ
 fyLKhuNnEGqhRVVv/OrjVXr2cg==
X-Google-Smtp-Source: AGHT+IEjbruDPBluyXzVVTXqFjjxFS20jjTJMWNRyRqdaDkHzSANaiCoOLzuChPmXIPPOsB+frDpRg==
X-Received: by 2002:a0d:ef47:0:b0:5a7:b481:4dd2 with SMTP id
 y68-20020a0def47000000b005a7b4814dd2mr20122416ywe.47.1701277085768; 
 Wed, 29 Nov 2023 08:58:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a814813000000b005cb331f463esm4663902ywa.8.2023.11.29.08.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:58:05 -0800 (PST)
Date: Wed, 29 Nov 2023 11:58:03 -0500
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: vicooodin@gmail.com, oleksandr_andrushchenko@epam.com, u-boot@lists.denx.de
Subject: Re: [PATCH] xen: pvblock: fix the maximum io size in one operation
Message-ID: <20231129165803.GM2513409@bill-the-cat>
References: <20231115015345.490313-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RUByZqRmRooOcdby"
Content-Disposition: inline
In-Reply-To: <20231115015345.490313-1-takahiro.akashi@linaro.org>
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


--RUByZqRmRooOcdby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:53:45AM +0900, AKASHI Takahiro wrote:

> The current implementation may cause BUG_ON() in blkfront_aio()
> 	BUG_ON(n > BLKIF_MAX_SEGMENTS_PER_REQUEST);
>=20
> In pvblock_iop(), a read/write operation will be split into smaller
> chunks of data so that the size in one access (aio_nbytes) is limited
> to, at the maximum,
> 	BLKIF_MAX_SEGMENTS_PER_REQUEST * PAGE_SIZE
>=20
> But this works only if when the *buffer* passed in to pvblock_io()
> is page-aligned. If not, the given data region may stand across
> (BLKIF_MAX_SEGMENTS_PER_REQUEST + 1) pages. See the logic in
> blkfront_aio():
> 	start =3D (uintptr_t)aiocbp->aio_buf & PAGE_MASK;
> 	end =3D ((uintptr_t)aiocbp->aio_buf + aiocbp->aio_nbytes +
> 	       PAGE_SIZE - 1) & PAGE_MASK;
> Then this will lead to BUG_ON() above.
>=20
> This can be fixed by decreasing the maximum size of aio_nbytes.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Fixes: commit 3a739cc6c948 ("xen: pvblock: Implement front-back protocol =
and do IO")

Applied to u-boot/next, thanks!

--=20
Tom

--RUByZqRmRooOcdby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbZsACgkQFHw5/5Y0
tyx2dAwAutlXtKcxBW3gyuSJvXZfzKTvmYKgqd7wbB8OwbBJw4yzFhREHkjjq3Ey
i49zedPpGYivs3fg4GVdBUrOwG5wPRZ+RvVobNHKKZ0tqupGIbfXD9MxBWLpP5cG
ZmPNrVHrfC9tT4VPXWhQD1LcLwqWCIQQf5T/qSpSOn5LlL1CE8FMdyfUVm4UjfVJ
K/9qUl6SGtEzh20MFMW0PHEArXZ/xqLdSoP48BL39bgM66cyNoq8PNCaEfcrzZd0
Y3+WUWH+xHxT6lF0Csk54JL+QDVszMcOuAe4s7SnBIbvVs71YJEbiB0Xu9C1bZOq
2iytGRm7cd9APrFDAvVdvT45QqVs/98FJR+9wnei9/YNRItCU8/xkhaeGLB+5Gue
yLFhkTwWIHlwtE7EPKdz/X16XJrb2drEcHsmyyTWCRPJ6Cg8hoABy8UFxgKh7LoQ
6OonrXwRWCdOUTI5IxLFnwzGO1tRNMid4fYGxJwdKOlMEuvSBqOy07Gg/nhHGhBF
+N0XcNfD
=K+Rc
-----END PGP SIGNATURE-----

--RUByZqRmRooOcdby--
