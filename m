Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA02CC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 22:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088F9870A0;
	Sat, 25 Nov 2023 23:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R1V9TRo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B688E870BD; Sat, 25 Nov 2023 23:38:04 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9285F8708D
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 23:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-77d632b35faso164048185a.3
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700951881; x=1701556681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/zHkOR4oEQbjtyDqq6+IErLCupdGTcDvRtWlwwxSVOk=;
 b=R1V9TRo1Cw7ovDoRtr0ovNWKi2EADGyuKfO8tXDSmw0rzZkR2lfjZZX+EUgiNkWZFi
 oLbyzxLLgDqRghknLnmx26eaNJ4WZP9iIVgBG7zZ0CPP6R4yPO+JUqTTuI5W5wHz8ctQ
 XDYJC9Y6s2pvlJqrtK+eUv0CL94wbxtoUqHDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700951881; x=1701556681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zHkOR4oEQbjtyDqq6+IErLCupdGTcDvRtWlwwxSVOk=;
 b=V0SE3qW+m+iSLq+a/FQ62zZ4ntvhVTA9CJpWoxFKVhgXO86e3aXD97BmlroOic92Ji
 71DLHSuadRJ107NUsmRXVg+Tkd8kg9O/0eKvo05BB1qyiCmYQ5kCfFc5iyEQ9jluhDoV
 QAjRObXQex8JPMiIxvoG4ip4DbwitSbpDoEXGvG3Y6Nhcjpnc979EpbYd/gBi65E8FtI
 ycrKCJ1qfWwYEl7Xjuk/0c1tIhyGBEuh8Crybey4vTrmYLHBKnQ5QfarthP8bGN9Om9i
 cu4VsG5nTcfWmYIHNd4qHhb9rOMtjYUemc6kNUfMNNO8yega40BxINFpfms6J+eDc0Wl
 YiEw==
X-Gm-Message-State: AOJu0YwmyeL2aRjTFNCFn5OJ4jppcnipMuh7h+ZdkM0onqHPe0V20jVD
 R2xeNC6z06T8Gn2A0A8Z3lutbUjHPeSCPKnpE+ioIQ==
X-Google-Smtp-Source: AGHT+IEpJhmnUziCQI7bhOOFXDmgL5w7rQiGt8MwBEuUhvuKHCzCRpbQnLBSWG8CAXudAPEQCcORKA==
X-Received: by 2002:a05:620a:8e8b:b0:77d:8659:ee5a with SMTP id
 rf11-20020a05620a8e8b00b0077d8659ee5amr4526893qkn.61.1700951881282; 
 Sat, 25 Nov 2023 14:38:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05620a241000b007740c0e52edsm2475508qkn.89.2023.11.25.14.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Nov 2023 14:37:59 -0800 (PST)
Date: Sat, 25 Nov 2023 17:37:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] siemens,am335x: clean-up draco targets
Message-ID: <20231125223757.GU2513409@bill-the-cat>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
 <20231108145322.302927-2-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G8LKB5IPk4o/jlQA"
Content-Disposition: inline
In-Reply-To: <20231108145322.302927-2-enrico.leto@siemens.com>
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


--G8LKB5IPk4o/jlQA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:53:17PM +0100, Enrico Leto wrote:

> Draco is a family of 3 boards: thuban, rastaban & etamin. Rename all
> targets of the family adding the draco- prefix to increase readibility
> and simplify future commits about concerning all boards of the family.
>=20
> The name draco was initially used for the first target. It's deprecated
> since a 2nd target was introduced. Unfortunately the draco target was
> copied to the thuban target instead to be renamed. Remove it to save
> unnecessary maintenance effort.
>=20
> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--G8LKB5IPk4o/jlQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVidzYACgkQFHw5/5Y0
tywYHgwAtgL9gu8Bcn5kjKXOLfRYq9976fgEcpQgb21eSyx3rw6Moc+1z83f9rRz
uTZcVY8T0IIbCnHgdHiUfHauKpEs4TbEnRHxbS3/rkjkn+jCJjqbAhOzdRrf6RMI
5Cjs0h/19ROFU2lwcvO4Rn+KKZ3zCfsfhTZiNuk6foM2gKXoaAqIQcZwLAxp2xQ7
ELLaA6ywg/EAt5jNceCFjxPVp+safZ7HnFvjmXUWGEpKFh+Xiozyfd2/2JsMKWTG
+DJ2wIww8huX105d23rGk2O9aZ1a2q7Sx4lJNh7YR7UssngKuDUAF3kc5UqWB9HD
M1Ak/fZyAUJICzkg6WZvCix48d9aVhaakWNMR+pGVz3Oh7PR89OpOBXlSv03+EyD
XrSg1Lk1Eay1CcyxZ0q1hfr1k4CbYTHzKEJQeRzDpRb3WmQQ4Ju0PcTwLeoTDdWD
6qMkM8CI7Og2VGnATCKwOU/M0mzbaMiluS7I7oEg3LNh7YM8VN81LvK2/OajFKEe
/NqULdzN
=pN2b
-----END PGP SIGNATURE-----

--G8LKB5IPk4o/jlQA--
