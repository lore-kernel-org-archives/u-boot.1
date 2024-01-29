Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE64C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 23:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AE787BDB;
	Tue, 30 Jan 2024 00:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMF11z5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A5887BEE; Tue, 30 Jan 2024 00:40:21 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9D187B77
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 00:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-602c714bdbeso25491457b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706571617; x=1707176417; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LB8/KRUwBhjfYUkfSqxhvUh52i9YKvca5uWas7qw6OQ=;
 b=dMF11z5AK0OLKKsUvBKGQTkdbGyM9SrFefz5Eqwr9+MhglvywvfHXbZOQFKbM/6BnP
 UnfNzME9uRnug5PkSN2ehFLLI/kirljA3ws2jBBGAPerIhxrgX48fEesFfVwiTAdpcit
 Go5ShBn3dMXGBYGXfmpNMR3yiosZ9ByVZH5Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571617; x=1707176417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LB8/KRUwBhjfYUkfSqxhvUh52i9YKvca5uWas7qw6OQ=;
 b=nfmALNF1aEtna3nxjmavAqzE0GPzcHoVCV9rns4H1/HfSu/ZZYV80iezh+yaipCxy1
 IzBp+3gCKY4g45CWDBcJE+YOMDffv9c3y10/IJeHomx4KVx5+QA1X0LGHwgtBRQtZW3z
 H9rVFKB9pKV8VffoLsqXLXjeHlMARGxIkCQuST0CGJNFjPj0A5qKLuIuQNw3GrjWPxQl
 yZvhsZkaBZt31jTOnWUPWAUnK/XWvcZBTueVLcZe9iwec9AIwKmn50NATz2r/Ls4+/FI
 Sq2UShUB1e2I22iHuH3/2TKQk0wwVWP9yn8qikJANIwjPezf+mIIHirfHJisq1nMkFpf
 o5vw==
X-Gm-Message-State: AOJu0Yzk2SrANtYsOpk1tOInvVTZt/LVhAKIGC+bXVHh8xCnNP3UXC7U
 3QurcApuv6N3iTQN1FOmodIs50qPt0QmnfLLps0DPWaORYSBpmDYB+HkSaG1DwBWI+OawK733zd
 l
X-Google-Smtp-Source: AGHT+IG0wYI8zR09kBUMcGveu4Ctc6xV9NVjRx+rSQXE7Dta5AGy2yybFEQs9qIoqlTKDoNSPjj2nw==
X-Received: by 2002:a81:ac5f:0:b0:602:9fc4:bc82 with SMTP id
 z31-20020a81ac5f000000b006029fc4bc82mr28620ywj.23.1706571617026; 
 Mon, 29 Jan 2024 15:40:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 u79-20020a0deb52000000b005ff8b88a631sm2831748ywe.133.2024.01.29.15.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:40:16 -0800 (PST)
Date: Mon, 29 Jan 2024 18:40:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Wei Ming Chen <jj251510319013@gmail.com>, Alexander Dahl <ada@thorsis.com>
Subject: Re: Pull request efi-2024-04-rc1-4
Message-ID: <20240129234014.GN1152441@bill-the-cat>
References: <4c82ae6a-c70b-4997-b023-8261ef6a1604@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zQ1CigNjbpj36GQC"
Content-Disposition: inline
In-Reply-To: <4c82ae6a-c70b-4997-b023-8261ef6a1604@canonical.com>
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


--zQ1CigNjbpj36GQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:18:34PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 526a865fe4fea59fb2638726c26e39557eb97f=
dd:
>=20
>   Merge branch 'master-cleanup' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-27 20:43:20
> -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-04-rc1-4
>=20
> for you to fetch changes up to 21489b4478a72d6c682f24dea80d5ac7790e2692:
>=20
>   efi_loader: check efi_get_variable_int return value (2024-01-29 11:31:44
> +0100)
>=20
> Gitlab CI reported no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19460
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--zQ1CigNjbpj36GQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW4N1sACgkQFHw5/5Y0
tyx56wv/YUrI5ZzysywW7wDQGr0cfkYY2rhdl6XreQ1BFsnTseoD6HvUDA537dFN
tcgX5VEDhdGoTIq7YkRE4AHGbNpdeWCDSJL4KWi4UmptDUQvOPkQJQUYS21YmKte
swNhyvpPbVzwPP7AYznEUTr8Bo5rAvtlMVGXABKU/sZWE9FMDwH4sk41EiSNKZwb
2nfvR7uNjWsc9DgzPo2BFWoEH5MsikHwgD/Kx0rEJAqfMNpE9w0g9FJcL0kRzt6t
NwEHmEkM40+UfFf3jdP54nI05FA1skwNN7QkU8iMixeEbEQ5kzFpq3ZiPzzXQG6i
BxkmXIINH0RXCaZxu0xS4atLVdjQ02WmauHnmqMED7bbc17T4xjgYAunSpE+x89L
4bvCjxrZ36/1dVSak0wKJNLhfQPC0VmnoLKd62OWVBXinxiWQYGfUW4GXX6SiplV
rrsF2LctSeVzns1nSX7iem0weAabiSjGrU31vx9Ai+u5N1fLVzBQN1G1iGhNPw8z
dzhltJUl
=SQ1c
-----END PGP SIGNATURE-----

--zQ1CigNjbpj36GQC--
