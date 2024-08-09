Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7312DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 22:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAFAE8780E;
	Sat, 10 Aug 2024 00:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMZO4D+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C71688C08; Sat, 10 Aug 2024 00:02:45 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D689D8641A
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 00:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d8060662a1so1461057eaf.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723240961; x=1723845761; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l2UqotfoiVqBd6ELuakL4ufkFI/8ayu1tjeGZOferUU=;
 b=dMZO4D+npFQv1rJg2A9/azskPS6fRekgu9+U3coZ5b0Ir7okWSzEn9YnWQZXCiE+8G
 lhu53QQZRPU9J5aEi9pNDnuBBzYoTEEIj9eC37V99gA139cQ2nxmMUDn7u9qebzDH++C
 JjUAMVmK8X970VOpNMKlKMBF1BsQsBmmg9HYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723240961; x=1723845761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2UqotfoiVqBd6ELuakL4ufkFI/8ayu1tjeGZOferUU=;
 b=VMkbUy0Dvvy5VAlGUG1kVBa5yC/VnP/iOWIjsaS3RxYiRK4llAs+Yj/ONAzvD5iRuu
 Otj3eBDzoiSvH0nolnlQYNqQZnwQNb/+uojd5f43y6yK4rMAEWP1txzcJL0hIMm87z4a
 2IQYuLHsfSIm61OKQn0o7XeNOD7+y0KONTdNBEks4+Xj1RuR12h6OJs9FBvwPHQgLGcy
 YNuQWu66nZwBqe0f0qvWjX5hBgpkoIUPRscBZW1lbYqc45BWCWp0uhz3QomJTipcoL6X
 kqUUZeltYd/dZYEUaaIjKL7vxoZzg0uwAg7IPyYIyRDOgE6p5yF0OxrTTPzC3rAiORVv
 89TA==
X-Gm-Message-State: AOJu0YwmlvZYGLuGXhXwRb55zkseQHvW/z3NjSG1qYzHHRT1AxQWbm8p
 SAsji/T52Ih1U7NCyb3nCnppigoizqRU0nQFcC/F5wfmCfKjMdx6id7xiudB2is=
X-Google-Smtp-Source: AGHT+IGSVcaXNNaqmQDyCZx1Km6+54l4yGGSkxx9D0zzyeIHCS93GBu6tvgUUj2pUxfMtx0Z/A3dpA==
X-Received: by 2002:a05:6820:821:b0:5ce:6671:de2f with SMTP id
 006d021491bc7-5d867bcf83emr3843090eaf.2.1723240961530; 
 Fri, 09 Aug 2024 15:02:41 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da3e59899bsm116471eaf.26.2024.08.09.15.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 15:02:40 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:02:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, lukas.funke@weidmueller.com
Subject: Re: Pull request for tpm-master-09082024
Message-ID: <20240809220238.GZ1626301@bill-the-cat>
References: <20240809185600.1581967-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aJli1SDTw+LB6QQb"
Content-Disposition: inline
In-Reply-To: <20240809185600.1581967-1-ilias.apalodimas@linaro.org>
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


--aJli1SDTw+LB6QQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 09:56:00PM +0300, Ilias Apalodimas wrote:

> Hi Tom,
>=20
> The following changes since commit 6f4c31c2b658358628b5b0fa801f55c7477c75=
85:
>=20
>   Prepare v2024.10-rc2 (2024-08-05 18:13:42 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-09=
082024
>=20
> for you to fetch changes up to c686b38db8f84e5537b8371ac59a5b364662eda4:
>=20
>   tpm: call tpm_tis_wait_init() after tpm_tis_init() (2024-08-06 14:01:14=
 +0300)
>=20
> The pipeline in https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pip=
elines/21949
> showed no problems
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--aJli1SDTw+LB6QQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2kfsACgkQFHw5/5Y0
tyyZjwv7B8BK9chK1EzFMkDtnqxLzc29hQ4OLJyz15EiedkhCEthmB+QF0VI/IaS
2brvmytEG0U3BYzQxtJ6ZZpRFl/WvWpFW5qkNp5k37VazlZptpo14eDEcj3lMZd4
CtrzbCGeNi0bYtdBnEMr44zY+e1V6K+Q3MWPdbc9qBxnGSe8gri68Bq41mQVCwhY
Py5qhBNckc5tqNkyueG8s86DXNMLQIlY0WHLmFx2oBHT98c/JjodvejWI+2kHOGX
/2VqDb8zUO56klCDssbZkEdwMtKLFrmJrMBVlCdveNt8xND4L2NCvzZPpkGZspnE
uHw6PbrU5CZzKpLaIm96t7wZMyX0EwvMoJ9Uw+s5uaMuqo2K4nbfvwjPoDnV8HUk
S4AGaLgjuG2X6DT6zEgPF+n5J/opJRFR3LRAdB9M/46Hnm3ukfCI70zwW8qb41nN
24aTJgtoV1yyyUVliZNnjP8WMygyrrmUaHfRcF1pqRk2WXkABwXPGmfosmy/pT5/
N02xBIks
=d9gu
-----END PGP SIGNATURE-----

--aJli1SDTw+LB6QQb--
