Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC4DC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D782E87B6B;
	Wed, 17 Jan 2024 15:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GVXZK1r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA9687B79; Wed, 17 Jan 2024 15:26:38 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0F687B66
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ff7dc53ce0so534637b3.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501595; x=1706106395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1L5AfkKCAYkWsZKejjCOjIRgGUvucVN0AcP4VdXYJrI=;
 b=GVXZK1r8Et0TFrYEVzprVnhFbYkT1qMTmBj1QQljR/FAxcCmgF/RUA/P51xSKkrH5G
 gWxHcE2OCJMMofHMHpuMBZUhDYqog2qx8oEcF6Pmx6RVa74RgNVuwcDg6NnqhbblfKC2
 jLLfIis3OQmLcTOgpHK5w0/Zaie5yQMYpXVT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501595; x=1706106395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1L5AfkKCAYkWsZKejjCOjIRgGUvucVN0AcP4VdXYJrI=;
 b=cxDrVtReI9BJA2TNKZ/B9ve36gH/kCn99d1RhCflLQOytTdLiiYVAMmV+a0GuBCQKL
 dw38LZNADXR20uXWvzCBGKY/JWQ9/j294rkmMAtzYkvkX6FzKxT4ByqaCf9p9j7l2h0X
 7K2vQf0SCthWMlGgbQFpHXj7nzLLzkoinTcDm6broqgf6YOSyhAC5JqNZ2tFnV0gNyV9
 CbQd2IKC8UP4UiAeArhYyBurxACYQtvqVZ1UBnZhyWDaseuaX0HX3WHVM0pbiF7jbM3p
 +V2GLF6Pk2Q45HMZaDjCGj8/c5rghXPjfSBccpunK4TS0NdW6pTLtooJCpBZquSyhpu8
 uCHA==
X-Gm-Message-State: AOJu0Yx7N7rMauNfEksNpaR5Lw9ZWw1a+g/snD2UV1+D04wCF4U5GPhj
 o3l37Yax3gl3d4SGCfpd4h1gPiRFZGhmK4KRg78SE3BQtGQ=
X-Google-Smtp-Source: AGHT+IHenkzIaNyQyYRIY/Ib+RiygqvnTXQYg/zEuRW9/8miVwh74wa9aa/6YsL6QdoYav6CnQr3Qw==
X-Received: by 2002:a0d:cb82:0:b0:5ff:6a4c:33b7 with SMTP id
 n124-20020a0dcb82000000b005ff6a4c33b7mr580935ywd.68.1705501595597; 
 Wed, 17 Jan 2024 06:26:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 t199-20020a0dead0000000b005ff788f91dasm118834ywe.110.2024.01.17.06.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:35 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/8] cmd/mem.c: use memmove in do_mem_cp()
Message-ID: <20240117142633.GN12635@bill-the-cat>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
 <20240103104710.4185383-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FABaIhHfJEPflG3u"
Content-Disposition: inline
In-Reply-To: <20240103104710.4185383-2-rasmus.villemoes@prevas.dk>
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


--FABaIhHfJEPflG3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 11:47:03AM +0100, Rasmus Villemoes wrote:

> There's no 'mv' shell command for handling overlapping src and dst
> regions, and there's no point introducing one, when we can just make
> the existing 'cp' command DTRT in all cases. memmove() should at most
> be a few instructions more then memcpy() (to detect the appropriate
> direction to do the copy), which is of course completely in the noise
> with all the string processing that a shell command does.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--FABaIhHfJEPflG3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn45kACgkQFHw5/5Y0
tyzVlwv/QReRkWl/kP0zmvLxywBLGd8AudAlzoW8cmlx4jV+MRcZjn0xn2STzV4v
RZ9rx8qx2AUvDKt8/hhhtJqxpCefHMGoLLzt1knC8V0dXkCPTrKlj/XGEYy6jKGM
rU6KSE6oAxaz7M4mDI6gw09T5W6iziNnFHQArD3BTJ8oZ5Xr7DFTUB2HPcEFpJhk
svtOYidtCguaf22IYy4OrzXTS7ijL9Dr3zc2JuWW7KpYlSHzUBy7BabutSw4UdJh
C8PQnSVg8eGv0d2TmbY9kzXSeqpxjKYPu1e/bNHYF+boetjRipc8hk1Tmloe27sV
vlgB3NFetyHNquTlqunDVQ3KqxrckPeI7hjV569kenyeSvNTf4sXfZuUohJp8tLt
ZAXrWHZSkc38izBNPsM6CrkiFYjrKzHzSe3GOt7zzw7+Rjq6YxhKdWKcQm42Y4xd
qVjku/XlQQ2idOOKqKsso7A0zLnzLnpLlMLotNkp2zZpYQzSLSyr52iur8iKn9jH
VQCRnSYy
=TO/n
-----END PGP SIGNATURE-----

--FABaIhHfJEPflG3u--
