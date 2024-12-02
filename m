Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6EEE69E8E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 20:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD3089492;
	Mon,  2 Dec 2024 21:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YUHwgIJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD908945A; Mon,  2 Dec 2024 21:17:18 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F36894A9
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 21:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b66e94bfb8so385596885a.3
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733170635; x=1733775435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z/mFHFrMpEZScEgtyCGQlGQv90B0/0fBJwXLC9KJeLw=;
 b=YUHwgIJigdqSrNftHp/IjUYlm/bydih6wAP7wg8n3TSjM9Urt8JzVPe1+eWvn1RMrq
 PQqLM+JOFmEQktqOxnGqaxHyH9cli27XKAl4kHhWiyi/CmIQCtR3zRw4EPlnwVOaUSDo
 IjdlEkkpdcDnuK8VOYrLOMZM7Ibb0gA8ip7PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733170635; x=1733775435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/mFHFrMpEZScEgtyCGQlGQv90B0/0fBJwXLC9KJeLw=;
 b=Ig9oB5V44W2tpBOYU0XggauBCVwExywLr1BBkKigLwmwVzW5OSYZ+XZ/myXtIy9pGh
 NGqSFlCbi05NkolF9GiJaoHKKRTAzj5FeA8Gvnqrt/DvJr1k3paR9MhE7oJ5UBrmp7d+
 gl4aukri6Ptj9CjzPtV9HMzOBhgJoRh0NzaOYPwGAZcDT4glYCADIG3mSI1J/JQvP1Ms
 5753uJdNB9k1jykavXP2Kv80OFGFrIFr+p6BlF6BKNHtRMRA9pqyGl31SaaamH13g0IJ
 Fog5f45L2j5F6WBcJ89qaTTFINJEvZs9TDC6CX1+BsF4tOWIkOG68HMaT4bgilTykbbA
 +qpw==
X-Gm-Message-State: AOJu0Yz1IpgKvzEQ7gKnd/Qdb7PTSyKCOBT/dOrDYJqFlr4PiqPF1THt
 Z3ZiA03alSrQUs1V25E67CRVBpY2Pe1qJZBCbdNIvraTPAZh53ynlnS3jfOhNHE=
X-Gm-Gg: ASbGncumolFgvPYZzlwo+/wZZwV4I/Vc7XLakCiV+QwP0MEfKZUEnsP7n6IV4aHKrOw
 84b069RQ8E6z3vVWX3io+WwRGgdzmkte2a49aeCCsaUbR6dOvSLzLIM1R3qV9ClZr3Fiq+1MFAV
 f5MvgnPRocu4/dHRaVjNSvLIuNxw3vuXwc/p2q0ubaFxqVgUZgg79KaI2oNgZphzK9eW8N+18IJ
 esrjPZJLCKXmYP0Xl0sV1HWAt/EbdAumEqvcb2+qMGPWGhwDg==
X-Google-Smtp-Source: AGHT+IFesrROpfpQLLLv1D/t5rB7u9fwcBcFKvV9QRsR3FnI2Ymvrf3vZQZsWSD9DtkciLYbWGIxkw==
X-Received: by 2002:a05:620a:1993:b0:7b6:6c46:55e with SMTP id
 af79cd13be357-7b67c278ee8mr3658363085a.19.1733170634760; 
 Mon, 02 Dec 2024 12:17:14 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c42317b3sm53108591cf.74.2024.12.02.12.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 12:17:13 -0800 (PST)
Date: Mon, 2 Dec 2024 14:17:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 02/25] efi_loader: Fix typos in enum efi_allocate_type
Message-ID: <20241202201710.GG2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NnoQfN+eLiFuOFeB"
Content-Disposition: inline
In-Reply-To: <20241201152505.1666789-3-sjg@chromium.org>
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


--NnoQfN+eLiFuOFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 08:24:21AM -0700, Simon Glass wrote:

> Fix 'indicatged' and 'adress' typos.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NnoQfN+eLiFuOFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOFcYACgkQFHw5/5Y0
tyx5Owv+KIVetlHymr+bY7DAOLmh6NkuaDhkVAAK+Dp0dhPanemA80usV4XacuK6
VXpvaA/T52ydIXixZlpilJGgFf3YKpqRxOxmtxktt6z0zhF5Z1wUqBCi+ujji8iG
NMOaQOpI1hXuSXqeJL0BrPtc9anx+1gT2gVUBN4Gl7z0lp0zAbpCMW1cToh8z1UQ
Ad++W9WK2yk0+JWzVdc8KP/qHK1slv/ATYumuor3oZBgRHpnNnxR5sb6E3mg2ZB6
S7bKfZ5Hv46+07iWC6rwEMWSoQx1Afyck3Be/NnKQH85WrTiydZrZYWuPYTyyeKW
lFJ8bT+uOz59FB/jVkEbhunt700ysFb0Trcoyyi1oK/8sb6mQkdFRYFU/S+5N/9X
ZWQU04xJd8g+vj6LX8b0ndfz1NMq5uAee8BfhgqUPAAndmSjy0LsUD/PEpApeT4O
4MHDIPSU6jiVKujYC16G9VE2nNypQ6jj5cTlE6bkEGDTPVn2WG10g53F16eRRPPQ
z5RigBx7
=/Ds1
-----END PGP SIGNATURE-----

--NnoQfN+eLiFuOFeB--
