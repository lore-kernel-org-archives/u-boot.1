Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC2CD1BDEA
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 19:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB6988E4B;
	Mon,  4 Nov 2024 20:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PZ/HfKG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5740588E4B; Mon,  4 Nov 2024 20:52:18 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42024884DB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 20:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b155cca097so372913785a.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730749935; x=1731354735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zexukPK0FsM5ctbMYxod6hofVOVYWfNvspHiXUOkzH0=;
 b=PZ/HfKG3g6ryf2uv4tlddoAxQZ933JbUEtZ72F939ZKwHTAcZChOyT2FdESCLTsCz5
 C+LBxB+FxGEbeQGLJuwTvt5xTDKbgkmL8sbzeek0549GY45cYMyERdzxkUANMGHIeO/H
 +l+exXP1AcMlb5WK/1aHOgbPh48T5Q7jddmcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730749935; x=1731354735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zexukPK0FsM5ctbMYxod6hofVOVYWfNvspHiXUOkzH0=;
 b=a/1RwcRUXDeMZdzSPMY8Pn8zRjvfWhlfNqJkXRHsRF/5jlrwUUzjPKA6nWQskR/TLt
 2+lYgCv4TnYy/jNFTD7oiTfiZAfKoEWwcIC2z9gbmQ3pR2BKVK221ZDnk8jM52t+p+Ls
 QKHdSEuAynoivPDnHTPz8HvcWjjDLg4NiEnL32WbDr2nko+xHGjE7n6P3bibkYz+jGyK
 YAvONsWgCz5xzO82DKXx0oYDnEhq8ZMF0gqr4qS3nUsleLPP44J4J+xwCeJIOuQMM8+x
 G+iuRo8h3IIlx8DXJ7tqkCdqOb0KaGNyEsYoTx1VltlkZpDmM+VYJgpHS4IuMONcqjqP
 lt8Q==
X-Gm-Message-State: AOJu0Yy5CTf+jsK4S+dpGCRbQGTJiU6I1dC7YhKpRmdvJy/DQH57eA8t
 VLk/gGG+PAnnohuLhZziVEBt0OaMBrr90HqScgNRkjb6dMecCParU19AGxO61DrlJl4btehVl3c
 S8ME=
X-Google-Smtp-Source: AGHT+IFLmEP2bJq4F7d4Pygq9EMz1QolDpCFG2Vs9tScy5Y8o4vfClKpKoLVIk8zbuSBXROZ+8Ekxw==
X-Received: by 2002:a05:620a:40d3:b0:7b1:8cfa:9222 with SMTP id
 af79cd13be357-7b2f3cd6603mr2599503185a.1.1730749935050; 
 Mon, 04 Nov 2024 11:52:15 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a6fe1dsm451672785a.93.2024.11.04.11.52.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 11:52:14 -0800 (PST)
Date: Mon, 4 Nov 2024 13:52:11 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks][PATCH] labgrid: Add wrapper scripts around
 using labgrid-client for device control
Message-ID: <20241104195211.GR3600562@bill-the-cat>
References: <20240829185620.3179866-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BzDbrueiWmMiEyFM"
Content-Disposition: inline
In-Reply-To: <20240829185620.3179866-1-trini@konsulko.com>
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


--BzDbrueiWmMiEyFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:56:20PM -0600, Tom Rini wrote:

> From: Edi Feschiyan <edi.feschiyan@konsulko.com>
>=20
> General usage for these hooks is documented in the README.md file. In
> terms of implementation, To start with, we add a common file to ensure
> that all required environment variables are set. Next, we add a console
> script which calls labgrid-console. We also add a reset script that
> behaves similarly. For writing files a wrapper around using
> labgrid-client sd-mux is provided and then both Raspberry Pi an TI K3
> platforms have writers provided. Sample board conf files can be found in
> the bin/konsulko-labgrid directory.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Edi Feschiyan <edi.feschiyan@konsulko.com>

With a rename to suffix these as "-trini", applied to
u-boot-test-hooks/master, thanks!

--=20
Tom

--BzDbrueiWmMiEyFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpJeQACgkQFHw5/5Y0
tywo0AwAsRLXbHJJpyYEt3MKPISvuJ49gtVjtCe2jtQhk6DITiN4PgF0y48Ee3mh
O6mofV/w6I7aE9fre8T6t9vi5C/WUSY6wEjHWzbEosFiYnMbLhY1nSESM/im5nTa
tKSoxKPEWAwUH/rHgXXIkejqnxzxkFgfrM5NsuO33NnaoUVW7rVrIMQ+cYRn82/w
RJ4R3QRFeNGiBZhnFBmXQXCuF2A3maybwDnV7irsxZTdPbEzFZF29GFNjZOhwxgW
OpQNQRRGeZD93sOsbnfxcmvXiRdyyqXcglZpTAyaETgQyoTc1uNDJWSsCk6Fb2Oc
RvtZYHtyt0I68fbqciSCRYgRvM2OvYmc0oeVcOnKdLo1DXiD1+6My8nuD6YNJuO6
A3tR/qYyMTQbnIGyhKCNChO522yMnWzticJu3LE3/TIOeim9VoP5BnRr3nWKJuQd
Lh2AP+uxqNrnKBqjYHE+Jp78f6fc/rA2ciq0DotPKzFcRCj2mqg/7SHaJyWXSlvW
ENqL/WXH
=PJ1j
-----END PGP SIGNATURE-----

--BzDbrueiWmMiEyFM--
