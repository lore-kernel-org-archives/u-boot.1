Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE94C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 16:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAAF8129B;
	Mon, 31 Mar 2025 18:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RiVpcotu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5068F8171B; Mon, 31 Mar 2025 18:07:56 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C8E81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c14138668so1041864a34.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743437272; x=1744042072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OrT9YiF8U7/IU/swS/yK5ekzQU0VpiAQJ5+cSNhxHak=;
 b=RiVpcotu32UEsUi6SeeE8psxcVnGu+4TXFfdGxcEf0+H5Kihg27CSHtw8A9R1WKVXQ
 TR0ZFLpdLbH++iHAaZqNyqZgPVF85TG8DV+eUwjUY5fmC7eKbIRTahdOrgWC8HHCGXU4
 8vaa9+m43U9djDZFDutRGKVthDnbTABnb7z3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743437272; x=1744042072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrT9YiF8U7/IU/swS/yK5ekzQU0VpiAQJ5+cSNhxHak=;
 b=VVVoVdYKVXFVfi2tG8a5jCVXF4bQZCzI1OzLYsBguEiBOcPCcmXRb+YH5NUC8eRFt7
 euMjc3/d3JXmxUEzQzZpOfXweGMkSqbhGvYmWZZptmmWwecChIgwpnNUHh4BFUe5Iw4T
 uCmi5IsVlGqawARa/sJFMrgD5Qp9ZCMiG50NP1BJD1da4mnqs8m7WeJlEdaVIPyAjiin
 V7gl9Xy+dz0DH7gdVBxDfLSI4pJvKrLaB8i6eYZReRgwSU2g8VLtP9KV9AWYcknbKQIS
 5WH+aPoGKu2ECq5++SdpB7uAxJHnKuAbsLf67xkKdsa0pL4scBq+sREK5rDSgqqezaDY
 Wr8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwLbee8lspwMvPIC1CkakD8SLOJOUAqXaz2taqStAWwtmcsR/dQrQYR27EQVr05Icpc4/s4Zs=@lists.denx.de
X-Gm-Message-State: AOJu0YyVo/AKuUdqchvAwKa8oFmig1cROIbrc7ilCXYOMmAmjhJ1knWk
 rhE+4d4pRXS23z40Hg2RMp3SVMQPpGHyMfne5aIyFB+kHPRLhFj6+W2jJ3FZHNs=
X-Gm-Gg: ASbGncuWyH/fovzjob5hK9Irg33iaA37xZYqdybq0WoVymdBR7n1G8JtCkxNWfu1h+z
 LPCfBPAujFQWM1EmW/bzuZPU+A5OzJvFYJxo38FKv/38P8TPRn8dQisI4WHVDEpMNSMhhIlmEAc
 CFyKnXexhtCdDOmCW27nFe7b3fJiNpmW0bYtUdvFZC6hu6mKyRiXIf8lgMFWXa1hedKpFr32Gac
 G2o4Fs5qid7928rWObjt7ig6kg6USyGfTpzp89H1sjI4/Pp5FZO4U/tD+ryI79z/3XzVzjdOIIi
 VgXUZOQEi62pcwR6SGAbAntF0cZ00rAP1mPccxt9p7m+A+EFoqheV7eI22vQRbOW/4G4v6XBNwf
 IbzOIAs6+UMGWZCTk
X-Google-Smtp-Source: AGHT+IGUfklyNXCkjUmUTNlo7mmBqgtc+CWES0dXUYwuh2AE7HHaZQmThIscONFgyp11TQkCUrcAwQ==
X-Received: by 2002:a05:6808:1445:b0:3fa:8bfd:7748 with SMTP id
 5614622812f47-3ff0f54cce1mr6639302b6e.22.1743437271795; 
 Mon, 31 Mar 2025 09:07:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05279b96sm1594110b6e.40.2025.03.31.09.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:07:51 -0700 (PDT)
Date: Mon, 31 Mar 2025 10:07:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 14/18] mtd: spi-nor-tiny: annotate switch/case fallthrough
Message-ID: <20250331160748.GB93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-15-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SbpaSgiEv0u1s8qT"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-15-andre.przywara@arm.com>
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


--SbpaSgiEv0u1s8qT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:09PM +0000, Andre Przywara wrote:

> The SPI NOR code uses an implicit switch/case fallthrough when checking
> different vendors to determine how to deal with extended addressig modes.
>=20
> Add our "fallthrough;" statement-like macro before some label in the
> 4-byte addressing mode code, to avoid a warning when GCC's
> -Wimplicit-fallthrough warning option is enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--SbpaSgiEv0u1s8qT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqvdQACgkQFHw5/5Y0
tyzq2gv+IwxFob8/Qt4kOVGPg4gz+3JKIhlR2aswpdatNr8dWUL0pfzqBcVXfuEu
EM09UqvtoGuv6aBF+ZCqz6ZUCcI03ErL2aDUJNHBPmBmGpC2QqEOoGw+U4kKrs/+
PxvXwHmTw3ASQ0PnE8NLj7Q19O0RFapV2H5b6KssNNQdnmZqZPQLTkVge2/ZtN+j
kD+hq9nLtlcyCVguzD2OpJMiUvlI/QPqVxY/YdeXCocJN3eAb/oqXNqfh7SeGWkj
mx1w+zhKtEoRyi/BDnmbYlRC28GMSznXktTTJ+ID/g6DjLAE4Sb1TDHHTXRGFFaI
BAknFwwu2xjashrAGT+mHTdcvqFq9eqfAXyV2SbgzvfhjjDQI8mEnyL5maNgmNJC
QEup1FrwT+QHP1tyQ0/GUqTAY9H8jr07FW1E+BvHPBR3c/cCFfhrcp2Lc16gQKk6
tln8+wuOjSP7MyQTQdCWDFMnF+Zj4s3bckGS279TUD3Wb903T771RI3I/V+IPQ3o
/9KSlkpK
=jSqb
-----END PGP SIGNATURE-----

--SbpaSgiEv0u1s8qT--
