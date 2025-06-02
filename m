Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7693CC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 15:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027728291D;
	Mon,  2 Jun 2025 17:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GjIrbYiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C91982A46; Mon,  2 Jun 2025 17:01:50 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B0A8291D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 17:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6facb09ea08so66391966d6.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748876507; x=1749481307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SdAu5uW3g5y9zWkZx2GsTxXqGUSzODxFkSE4NPGYtgM=;
 b=GjIrbYiSP8+2Mi4PaLJFS2F5LNc+DA4aYE9lYwpVLqQJh9yHwllQkIsuvn2t8EagTT
 ZW/8HjkeDVElc0qfnVidvLOXKNVdcp+byeoOjL9c3palh7quKLuPy1dRdGZZSqni6T4R
 zWoEXzAnCmcPJuTWQS9yXz2kKzcG8ly7MpM8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748876507; x=1749481307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdAu5uW3g5y9zWkZx2GsTxXqGUSzODxFkSE4NPGYtgM=;
 b=mEzVKfjyvB8iEDJv8ozPOfB+uz9ABL/CbVZg5Uv3QRLrbZyjKg5gQGidR7MFjzB92m
 Kd/LYZjHNwlb3o2r2InA40iFy8TArtkQsOesz4gBAGRT5HKRhqNqB502ChXY5Fiw8BhW
 dknKsw1+PIEwckpF0ushX/3v7Sl2bPn8UYa65S1+G26MCwu0AQJRiBHEmZ+k2tsQEpoj
 qP1G8KFuIjEm6LrsRta/63tQel3yxmWKr1DVuxisR3Qu61Aw2ojk4uAQfEzAucoxHf//
 kDtD/ln5GtUq0Y7ijzB1rM/Cgf8QZbFPwDUNZUT55kLNHIlrVRhAFCPdvjrbhU4SspMp
 S6Xw==
X-Gm-Message-State: AOJu0YwBEiONxAAv/SylX9rmodbxRjMR9ncPChEklvvgaBrSbeHzqa7B
 LuQXGv2RyLZi3fR7v2iUQuE3yeZh5WHGvtC5PKdDyDrOof4F+e4DPu9CwXWFOPRO/YM+MAc9LpZ
 kIWgzN9M=
X-Gm-Gg: ASbGnctefFYzh8rgRX/yMIKYbRnPd6PSgOo7pB8xzJLi+L8Ey8x0tv68Ki5nHh+z8B1
 6MXaNZAbOQHHRL7iPI0oQ4PruG0i6oEKz3UmW/yzPnrMT5UioaJGbT/coLrCnQE3pYWJ4bP355/
 1eosTGB+5QVVcxf9D20e+Fmq9giMxmf2tgCjuQcH+1S+vCmI4kYvb7H1HbyfexQeCkL4JqNH9Cb
 TJe5/8eTvaL/oLC/k7Iks2QJW7Pawx0LQYbMifahCE2jvWixlWwMmiHaOvZJ0M8/LbrNLHh2d3h
 C9ZdqP7ndtAkbh76xiSOlLf1Nm5D4qt1xMUZASuBJJqdh9botld7bqSglEHf4Ocp0qaBfMofhIw
 NDAY8z9X2JlsuMTsIYWYCYB4=
X-Google-Smtp-Source: AGHT+IH+osfrchzSQYTnBm1/aXgAdphblHT+oZOo+UTizMBAKHeA9cQYXMuUVtoHMsp0jQHkTA7G+g==
X-Received: by 2002:a05:6830:6c14:b0:727:4356:9f07 with SMTP id
 46e09a7af769-736ece8e47dmr8637654a34.14.1748876496088; 
 Mon, 02 Jun 2025 08:01:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af879fe2sm1615627a34.40.2025.06.02.08.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 08:01:35 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] ram: Move Kconfig options into their own menu entry
Message-ID: <20250602150133.GY100073@bill-the-cat>
References: <20250602101515.37384-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fUAj9jS8zUBVHh3q"
Content-Disposition: inline
In-Reply-To: <20250602101515.37384-1-ziyao@disroot.org>
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


--fUAj9jS8zUBVHh3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 10:15:15AM +0000, Yao Zi wrote:

> RAM drivers using Device Model currently lack of their own Kconfig menu
> entry, which makes Kconfig put all options of the class in the top-level
> menu of device drivers. These options are also incorrectly grouped with
> pinctrl options in the generated .config, which is hard to read. Let's
> create a menu entry for these drivers.
>=20
> Fixes: 6c51df6859f ("dm: Add support for RAM drivers")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fUAj9jS8zUBVHh3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg9vM0ACgkQFHw5/5Y0
tyzhzAv/dL2i+Y/8BuJ/vwA7eqtSiok7//lOtPzZ3n/5lJXdNpuR2Mf/XUl5djJv
SCsnnwI8/1ClbrDbJpzMO1U7hq6AsxYnfGwYTgHkiQnASf4gXXF5LCCuZ/duawxh
t4kqzKRn2EuF52k6KHpHyqE13mtFkKyitPqasxCF54Cbd73Gt8HI4PmI8mxgJhAs
7fBv8t8vK+8HPaQbp4wJ7bz1RxNK9yhEjQGCjlb77ghkoIN2h+3Jn5SYXPihrJQp
fCLhJidw+9B90Xb5Gsj1/S6FFdx/KakAV6SAh4HSQ/nc7NzGcqFDOtBabFj0DLE4
Ge3hE2HjSB/IcasF6Ge+Baqp45gVwU+6BLHSpvyyJV6KdLsgtDE+hAGPPEvD/06V
EOTB1VqY8eztpQFqKwsANqGKlsZwjdU65HwE7+uTmKbyiyYxFKfH9PHOWMalt10q
aHsQRKKx6nTlc26IFaTAJjmMNlsTfPhzSmSGNyWXXG+NM3qqjBp2CvKVThHwDrcA
NAXzdanM
=BGrd
-----END PGP SIGNATURE-----

--fUAj9jS8zUBVHh3q--
