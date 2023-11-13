Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE2DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 23:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142FB8711E;
	Tue, 14 Nov 2023 00:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t/esBdxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642BC87124; Tue, 14 Nov 2023 00:59:53 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D888711A
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cba6e8e65so29664321cf.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699919989; x=1700524789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMGjl3mecnaRTKWpoem/n6dVUUP0TrOMRbwae6jAeQc=;
 b=t/esBdxO3wV7b4MMU1YEG0u3KzbmwfxvWnyOh6HZWloLDsJ1kbgPMhGzzB8XCi9Cxy
 dc5MzxvMrnMdMG9kn8xexk1Dasjuu1qgZIRzlTmnXYFzcyFBGf1O39eEBJmVA4kibJlT
 NspuUPcZjCi5Y3icg87ABos8N7mMn4hLzg780=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699919989; x=1700524789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMGjl3mecnaRTKWpoem/n6dVUUP0TrOMRbwae6jAeQc=;
 b=Ko5bILQPPv7gIhjM4Jwkik9Bk4TFT5FeTMTGr7rx5xb8mwseB4QSOY+OgPkIxDISps
 2vLsp4D5jwQCCAr1RE1GSzbfVCjtGVoM1qgallY5h4+Ck+Fk+OmuknIeWdT44hZTcEhb
 wTCTF8aoaWBdR6VIht2bW/rqpkxUPB9Ngzdf68c0h+2w46J7YedUATjI/MneKFiNZOJM
 WySdpTLBmVZAgtmVIZHbQKLCZdxt9PZx81nmPwJExci82rAX+gbkcHPdQUGYROfJTRr3
 3fuuJghNJLago89r3EIFKxqoAiXeofaTDIlwcl6c6AKOeJWzyGh4BlMBTZ84f+GTBLO6
 pxYw==
X-Gm-Message-State: AOJu0YyX7FUBp7DlNJazGWdpu0CzVtNRz7kdb6MmNZNzb2+oVOAR9nNx
 KHKHenkiVZS/XsxTY+TGYc6oOw==
X-Google-Smtp-Source: AGHT+IFQlyR95ZzaRv8Y5ghv98tyRZ6UncO8wUAhMA+eWGVe4pnvAkIXQduI/tiZRApP5jzSOdYs+g==
X-Received: by 2002:a05:622a:14c:b0:417:95e7:a2f7 with SMTP id
 v12-20020a05622a014c00b0041795e7a2f7mr721491qtw.19.1699919989129; 
 Mon, 13 Nov 2023 15:59:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 t19-20020ac865d3000000b0041ce9ebaad2sm2305600qto.43.2023.11.13.15.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 15:59:48 -0800 (PST)
Date: Mon, 13 Nov 2023 18:59:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, nm@ti.com, u-boot@lists.denx.de, vigneshr@ti.com,
 u-kumar1@ti.com, reidt@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: misc: Move esm-k3.txt to
 ti,j721e-esm.yaml
Message-ID: <20231113235946.GN6601@bill-the-cat>
References: <20231113043023.2126690-1-n-francis@ti.com>
 <20231113043023.2126690-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F9ucvff4/l3lPrKL"
Content-Disposition: inline
In-Reply-To: <20231113043023.2126690-2-n-francis@ti.com>
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


--F9ucvff4/l3lPrKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 10:00:22AM +0530, Neha Malcom Francis wrote:

> Move esm-k3.txt to ti,j721e-esm.yaml in line with the devicetree
> documentation in kernel.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

I assume this is also from v6.7-rc1 and:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--F9ucvff4/l3lPrKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVSuHIACgkQFHw5/5Y0
tyyqbAwAiQ2m0PDEhV850xrX1BBAixlhVqidRKh1XoZb/nPafGfPZ84CRJhXQl8g
5LS9LgKJTeEe4n2Q2E/oJt/M/bihMAW22KxccnakMLn2m9pwx4NFc4M+GQx8hODd
UjFcCnDXcjkx9s/IhQjRoel/+u/nvWRJ9h1byQTKYGaxW25a05n5C5+HA8iipa1g
lwlvxJIEqiMGsKDgPKXNXEiHELQlmJUbn5fHNmhZzQWYTBRubBV9vB9ej8Ij/DRb
veQcZdvn6mcgejJ842r6jSE7mC1Oh1zWuAR4atkmqNp+NkphSNHC69K3YBKfE5AS
UXzaDIrYci8pF8Svvptcoas0UejHRtMf7AwBy/wVkq6ahh0Ux+IY+tDDxYHH6r8l
5RxQgc80Of03icPGsgcfqbzB33TTbZO8EndoT7eVlyW+3ApLHmu99qec8mexbPrf
4bVroQtj3XRRz513i0n7XDrIW9kOSdQgFoBj+4JxU1gpYdMpkBw6sSw5lRUx2d2p
pkY+rURc
=b+T1
-----END PGP SIGNATURE-----

--F9ucvff4/l3lPrKL--
