Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D423EE87845
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0CB83B85;
	Tue,  3 Feb 2026 17:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uG0uNZ4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715A583B8F; Tue,  3 Feb 2026 17:13:49 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBA883B85
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45c93313721so3771018b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770135226; x=1770740026; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XTK2PiWZVa7ZMlL8wa5DZZFiBIHavDqvjGeW1/NUNGU=;
 b=uG0uNZ4/HYltiTldY6XKzHJ+Ng9wBbMqocqlYFmFf9J+HIs16JicIhuBRMBEIwzI3R
 im1ICGni2oPgy/3n4ztGykmhNO6kVZN38FgwgdtTIko1At2r4h2q0Lw9hMo2bYmlLCk1
 w/VfkDLIBjGp7p8gh4itN9R4Z+0QsqmJRaHRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770135226; x=1770740026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTK2PiWZVa7ZMlL8wa5DZZFiBIHavDqvjGeW1/NUNGU=;
 b=A86OdLcvmMgto/P8y+jFRRr4x73kCAvnb6zwWiTb1zbWxZTynE865V93pMyTb9gSAK
 mAhw3pJ2dbJNlecfExe/++4SasbnPrQE82rPQUYn/YaOICw/msm+p8tnrYp1liJB4eEp
 OkOxuYtqDcmpDIxJlI4raNzAMynzdeep6gGvHsrFZ6w5cIJmZiidNpx3QHTPqtG6m8Pk
 6bGqOl0Opqq+LiFwKSGqPzp5IQPH/0nCxJfpMYpAFPZ9Qjn6ioD9eb94EWsEkHc44xFQ
 bVZyoyqnguVzP1L4GiK/niU1VjxbEPhYW4kNtzjPduXcNsiacrJI5wrwWuBNPpRE5siT
 jhGg==
X-Gm-Message-State: AOJu0YxbbSDYYR/EqT+cRXmsYs7vo/qGzS0VQD81zlnj+zhX06Bdjzc9
 wXUXWuwO7qlxEdca8t6ZPEhfEwztkCIgUftSTb/6cWDMS56hW35oKSWfIZozHpyGLpQ=
X-Gm-Gg: AZuq6aJOXCgvbHYP4ShPVuQ46rmQKLoIcP7BEHQKj+94umrVEu5lBU3Joad1SHfdnMq
 pcWv5vgBFJkn+YFphs2uHHKkUHTU9lDd2j9/ELe++/sGDdBC214xHTYv5ULI8H40YIiuSjdKxN5
 ZIL6aMlURg9nNiDilsNOHPJD+D8ZuljuJe0N0J+SScmI2/st1WArllCOhXzOAyKo1WJrPggU5Vp
 Zm1+rdIBMztDcv+x07Eky4LkzMctUFIC2hNX+56sB3M5b+vcQdNRGDvWCxU3l8YT/QV2q3vAHH8
 thGrM+cg94W1DyaRsYnLXGEP3li+87F+GMn1k/TwRr6hTFvu6CWqD3PmEBx2ycBb3lBjqcV6+A2
 q0SYl+CR+DZjQaLXyxkltgCKe5MILlbMIq8MkddzP2Jsn5eKUMhqj+qMNx0+WjAmSAGklhvjb9h
 ZD1tefhZYEXM0TnctcgAPuU6dUi+7xJVOgDUecEEYhsm3QRzMSyQ1hPtDwz2PLCdNK4covx6A4M
 KzfAH105/+++yK0/EV1Ot8x4GFpdCkqnk2zsoc=
X-Received: by 2002:a05:6808:5193:b0:45f:1b74:218a with SMTP id
 5614622812f47-45f34b4edb1mr7602133b6e.1.1770135226083; 
 Tue, 03 Feb 2026 08:13:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462cb7ca939sm758792b6e.9.2026.02.03.08.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 08:13:45 -0800 (PST)
Date: Tue, 3 Feb 2026 10:13:43 -0600
From: Tom Rini <trini@konsulko.com>
To: niko.mauno@vaisala.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] bootcount: Use predefined count/magic bit masks
Message-ID: <20260203161343.GM2603314@bill-the-cat>
References: <20260203144404.12093-1-niko.mauno@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vLaVU4FvhDGPkeLA"
Content-Disposition: inline
In-Reply-To: <20260203144404.12093-1-niko.mauno@vaisala.com>
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


--vLaVU4FvhDGPkeLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 04:44:02PM +0200, niko.mauno@vaisala.com wrote:

> From: Niko Mauno <niko.mauno@vaisala.com>
>=20
> Use predefined bit masks in operations where only the magic half or
> only the count half of the 32-bit value are processed.
>=20
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vLaVU4FvhDGPkeLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIetgAKCRAr4qD1Cr/k
Cit1AP96aUlV5eZKjXiZ8BnujK4kb7IFxqVM0+Ut8AoBZjzjmQD+OHI6GGm1yxDL
NMJgvqg1Gmp3EjEHit6oJbyrWNsABAY=
=UrJF
-----END PGP SIGNATURE-----

--vLaVU4FvhDGPkeLA--
