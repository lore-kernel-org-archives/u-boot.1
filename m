Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688F8C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCDD587BF3;
	Fri, 15 Dec 2023 23:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LkPyhEyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7517E87BE7; Fri, 15 Dec 2023 23:48:12 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E4987BE1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-591341db3a1so833918eaf.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680489; x=1703285289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H+207f64NysE4fNN2KOO5UZLbCM5/VJ5jlhIW9kXs28=;
 b=LkPyhEyUlO9XybF6R4GA0gBq6cZSDIsWjw4CgHt7HSKStPIEfliFq+uNKW0ENbQ7qX
 d9yNgwQLUSb/EID3vzcUxDhNreCsUzoCXGfa4+NeVD7/0QpKrNMwbOE9o8v8NLgI2dAs
 BlQivsHy/p4ILWzh9h1r8qRUJejIWGQ8ZP5rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680489; x=1703285289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+207f64NysE4fNN2KOO5UZLbCM5/VJ5jlhIW9kXs28=;
 b=GvztNnmru7oKBqtrskhKoKqYEzSGsp74irDlNoEtgezwVZpvvzeCU8IBdK2aLsBc/m
 OETd9Y44/u90BkawU6eClp2Xt8JEbAis04mnvgzh2etuzdatJZzimNamdG65xBgleyei
 YAEmlsWxXtLEA9/oyoEXxOq/DZAB39NNv5W1x/YpFA2OOrRvsaijUd2SRCTDUaiU/oxu
 eY+dLR5q5cbWnqA3wYkYmq6qcxYgwwcHvm5TBdPuDjYn0OcwtFH33DVwq8Wil79BFE0c
 AcwSWYbVEZOHjDY8X6456qagjCXXmY8WFVHtdL8MuWDd/lDN+6l98CPYqh3gDRrKstRa
 gtVg==
X-Gm-Message-State: AOJu0YyRomgMl/Ltr414EFhunMKCTCog9UjvoN1CLpp+IaHKYTYY+4qr
 e0jNaBgEID1baHFWIuQNHwMyFQ==
X-Google-Smtp-Source: AGHT+IG13Rnjeai85plq4DYOFZJtpnu9lvQX/F0KA4awtJvVHy/wksmiq2OfMj1L5Gk15t2G/NI/xg==
X-Received: by 2002:a05:6358:7e13:b0:172:ae2a:2256 with SMTP id
 o19-20020a0563587e1300b00172ae2a2256mr1950398rwm.27.1702680488685; 
 Fri, 15 Dec 2023 14:48:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a0ce98e000000b0067abe3867a0sm7073629qvn.146.2023.12.15.14.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:07 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Apurva Nandan <a-nandan@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] arm: mach-k3: Do not map ATF and OPTEE regions in
 MMU
Message-ID: <20231215224806.GE2513409@bill-the-cat>
References: <20231128170528.407707-1-afd@ti.com>
 <20231128170528.407707-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bVW35IvsZzUAQjIB"
Content-Disposition: inline
In-Reply-To: <20231128170528.407707-3-afd@ti.com>
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


--bVW35IvsZzUAQjIB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:05:26AM -0600, Andrew Davis wrote:

> ATF and OPTEE regions may be firewalled from non-secure entities. To
> prevent access to this area we leave a hole there in the MMU map. This
> is the same idea as [0] but we complete that patch by adding the same
> for AM65, J721e, J7200, and J721s2 here.
>=20
> [0] commit 0688ff3ae23c ("arm: mach-k3: arm64-mmu: do not map ATF and OPT=
EE regions in A53 MMU")
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--bVW35IvsZzUAQjIB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV816YACgkQFHw5/5Y0
tyxIMAwAq6QS2U1z5UWeGLAnSQofQ/aUWwMX3dyHS9cXXlJeQZUmB2PRD1oe8n49
SX/36NkbPcg/Et0FMnFBVQuTz3FNbb7AEackXwfKM4p0+FsRqaoXGLcfXKwUoJ3W
JWmeMKAWy6lYAMY6/A24PmTiaGQbfeON3AGyLsABIz5WVjBsOwRk+ijwlOTcKRAY
s0fnjcDeqxcwFYUePVh8RBsNLT8JYOWCGulkADX3TPdloKbb2u1k6MuoW/mL8y8z
9Yn/H+UxqNpsTRreBHkW9yp0zyEk06DpqJee33wA8Znsp0R/5oys5eiMbDT16tR/
FDk0JPC4+av5SQFe1rVb5NxA5GA6u+BygVq3eopjuwtwu1QRGT6wIr7D0u7GwIzT
KeL/KKFWAc07eYfW+PKGFHLOkWtAse+jxZIoddSFQZws2cF/dlJ0yf673y9H935i
04W23hOqA4JnvmskiwoUyiF4+IQeBW97lNOhP0hWo2o9PBsbgt83QsmnhWuCTloI
6qhI1hMl
=WCNB
-----END PGP SIGNATURE-----

--bVW35IvsZzUAQjIB--
