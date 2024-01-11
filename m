Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC8C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 15:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B718749F;
	Thu, 11 Jan 2024 16:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XRp6/uYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CC68749F; Thu, 11 Jan 2024 16:54:02 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD36087250
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 16:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7831b3a48e7so315273485a.3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704988438; x=1705593238; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6FRLRnuuY/v+cUvWoEU0FxOs/oZbw07SuzYT1mqY7Tk=;
 b=XRp6/uYCQwYsaHGTNY0jSgDjS67oU6oKybxEMZtZHJby4vpjFro+r3fIV8/RwdZTsC
 7UjVHd/obGEfwfMI2XUl+OxuB+ZUCrlE0iJTGIWU2IgMClTRH/yhfa4uFXBT5XJbO21B
 7IFqXO7dgugQfAGfFrg06FD97ny1WOGxRxFpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988438; x=1705593238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FRLRnuuY/v+cUvWoEU0FxOs/oZbw07SuzYT1mqY7Tk=;
 b=WGH6YePSLbItL1EDx0jgJGKz2mIO/qUg9y3Wy7gvlapkqmlYSfQDHgkGUYF77Ck0v3
 Bw1ky+PDk9TqR1xBGTSyIvw/g9lZ2ykj09UAqyM6oZxe9r5IFgnQLv5lhQumVP3vOlze
 sFz4bAFW2mKg8kxUKHG9N+rlN0Kc3JzDWJAuARuHZTj19vXuZDGlO/tsNneJg3yiK1AY
 nl8GLLWCvq3FV1TCxO1cv7suby/DXbYtLG5p8ZxdR987X2tvR9a29sYnDfesXb7WmUf4
 3HU9iDLQs8tP9Snb0o1SLzQWZtnBvOK8GUI9DZ5aJxx2kbUZ8ZPTeB6/N7LjrZ+APAvP
 ncyA==
X-Gm-Message-State: AOJu0Yw1kxtpcgglZrwR+QdmfdJSaiIdGlazs3qhSc18Kgh8Jxnl2wPe
 +9VruLwZhTjZtOtQnp6WfMNs6hL+XJlvVA==
X-Google-Smtp-Source: AGHT+IFRZa3KvO26BVhgNI19n9jPujC+9bqRhNE+D6qcQgb0pcZhYbYctIgGJVx6xrshwwEGOpFM5g==
X-Received: by 2002:a37:ac05:0:b0:783:4638:e790 with SMTP id
 e5-20020a37ac05000000b007834638e790mr369453qkm.61.1704988438450; 
 Thu, 11 Jan 2024 07:53:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 bq43-20020a05620a46ab00b00783244c7a95sm423066qkb.24.2024.01.11.07.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:53:57 -0800 (PST)
Date: Thu, 11 Jan 2024 10:53:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: net_boot: Add test cases for net boot
Message-ID: <20240111155355.GI1610741@bill-the-cat>
References: <46d98c2d18f3577b755b9f0af886307f0d91849b.1704783802.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rpzkdW/b1g/EZh8q"
Content-Disposition: inline
In-Reply-To: <46d98c2d18f3577b755b9f0af886307f0d91849b.1704783802.git.love.kumar@amd.com>
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


--rpzkdW/b1g/EZh8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 12:33:36PM +0530, Love Kumar wrote:

> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> boot case loads the FIT image into DDR and boots using bootm command
> whereas pxe boot cases downloads the pxe configuration file from the
> TFTP server and interprets it to boot the images mentioned in the pxe
> configurations file.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>  test/py/tests/test_net_boot.py | 371 +++++++++++++++++++++++++++++++++
>  1 file changed, 371 insertions(+)
>  create mode 100644 test/py/tests/test_net_boot.py

Can you expand a little more on how far this test goes? Does it actually
get as far as a login prompt or ? Thanks.

--=20
Tom

--rpzkdW/b1g/EZh8q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWgDxAACgkQFHw5/5Y0
tyxdowwAkE0qvp5Ivxh1N1luRU6AIYIlfXyKIhyD9TVluTkQBuWWAUTkP5QMeSuO
zLeGapVLuruqFb63/hCWSPndxuNH7d/hCSf9IgRsOtAuO6SzLNJMQiQ1xUxNgyPe
9c7wvq8hQ6LPMtfmlolEcZa9zAu4l7IarqI1zGjqzCvirpgsp4lFQHj8hMgeKb1w
cbQoVgwfzYj37laD35Pphqy5vkIJYf+1pEYnTjHiiBBJwE6uVlNiw/OnfToITuP2
VyYlLC1kpvCv1T1uLxITm91MUydcScxOaVWx7bwGsNySR49/nLUAarn+93XIoy6B
WyYIhstR3Jx8hDem6paD+sftrasn1vIT/mVggObCJbOp2/ue7Hx6muhMcdi9D5I7
B2Sa7qoPmRrhuCRA+5SsnBHifkyUYdLDqpvhapapqIjD8/Y5CQaxz6FzXRvs6PQY
GN9p32HCL3SfGq0078V+wrHLtxEt1Rkl5OPjcBvcMsfjICyQTdKkg5JD7dX4uY/g
tignHcUA
=3ab6
-----END PGP SIGNATURE-----

--rpzkdW/b1g/EZh8q--
