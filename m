Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34233EEB58C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA4186A2B;
	Sat,  9 Sep 2023 15:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dkRjdztp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F79D86A30; Sat,  9 Sep 2023 15:31:07 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE99803AE
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a88ef953adso2237665b6e.0
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266263; x=1694871063; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K10vt/MiD6EQhk6AUaI8PFu5lE+NZNQLCr87fen+Xio=;
 b=dkRjdztp5AYasgIzPbyH5NWhc8fivU9oTfXFN9VytFKmNLvywA5sJLSswcn0u3e+w9
 uLXD3IgUUOWmf5v8NjUF7JGDPj2sWypmGb3d+VzsvyO9PbYz2NPO1oHRfk4MbxU4sLZ7
 Y8EQTg9O465QqsBiJGH78B9kEuXjNgsusnAl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266263; x=1694871063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K10vt/MiD6EQhk6AUaI8PFu5lE+NZNQLCr87fen+Xio=;
 b=PsYMVow2GXVExxQ2XLhGFAmm5xhzCsiMMaiBjnmEyBGDke3QMkAywwWhkuy9O02cQ3
 V/qmIzAjb9io3C/iQyt0TzCeF6dDUjV3Yoc6GY8Hii2w6ihb1eYSjL5TJ1Nrj955r19e
 YcJEUfaTtdBolyFBSj0pLy3fyruXWqQ9Es6zuWVbUoKGEU5lvO0Q3FVeoR+2vrw36ep7
 IEbcEfZUI6LJytmLcURN1MrTFvw6rFvc+H0gHZddL6AG6qkq8zx+TXV3CuMUbHmGuKqy
 r31g97Bq1VE3TZ0EpgTU6B14Yos/GiKV83GoZ5l3a3SSkXQykI9DOYyb9Nwc4QHVlEdH
 EKeQ==
X-Gm-Message-State: AOJu0Yzv81Wq+HDyA9aQs9vHRF7TzprXZYFtyPPukidMg2C3RUC7YM2w
 utce8j0nDeU7pxPNF2GwxZKbKQ==
X-Google-Smtp-Source: AGHT+IELNXLraKSqSseLTpE6odSjJbcqorAIqTMVn/xxJftFYzlbxUPfy6B0WK8tP1GcSgs7Oc2zRw==
X-Received: by 2002:a05:6808:b12:b0:3a7:35af:bbc0 with SMTP id
 s18-20020a0568080b1200b003a735afbbc0mr5448923oij.54.1694266263297; 
 Sat, 09 Sep 2023 06:31:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a056902010c00b00d71c764379fsm131329ybh.55.2023.09.09.06.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:31:02 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:31:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Nishanth Menon <nm@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1] include: configs: verdin-am62: drop unused sdram
 address
Message-ID: <20230909133101.GO305624@bill-the-cat>
References: <20230828215037.482278-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="83eI6PlzLqmQvpV/"
Content-Disposition: inline
In-Reply-To: <20230828215037.482278-1-marcel@ziswiler.com>
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


--83eI6PlzLqmQvpV/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:50:37PM +0200, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Drop unused macro. This was copied straight from the AM62x EVM but while
> meant for a second region of DDR this is not even needed for the AM62x
> EVM configurations and has meanwhile also been dropped there.
>=20
> Note that on the Verdin AM62, we do auto-detect the amount of SDRAM.
>=20
> While at it also update the comment noting that CFG_SYS_SDRAM_SIZE is
> the maximum which is only used for such auto-detection.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--83eI6PlzLqmQvpV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c5QACgkQFHw5/5Y0
tyw2DQv9HVy9fUMKtdB/UoHyzglo3RGTx9zunyFrHW9f7mcerM8GojHkaHlf8xmr
u4ZnmCQG8QvzDg1MUxDLD5Zcyy1HywhRmg+DsSxzHxOG0TWSiSqODiRFy9R6uvau
oedtSXIUpqgwLamuhtOkNsdPefaGlUDLu/to74jYh48a/FkxtR9x9SjeFfEto/G3
hYPLy0wI33vLh0Qm67SVM+JfDTix4YNzV9m9sJTeeb8uj4vN7eWjWqui6rzmoyQt
mkTUp3C1UjRHkjQxriCx97sxVcelwWUHbUWIvC6RqDJtpLJQ14YZWIf+7/6fET/0
w2KVrzTZkxPZZqMK3yLQ4wGdt/7YpArnn+hzvhRR8Lj7YGghD1lmZDIPhCmwUf5W
MTKb8kDkFKAlLTpjzmwznNukqAWb++JxoqPKP5H3QZSYQAj8k3WgL/Q1MtwE88Nu
0FvhK5YUyH/QdcKAMIJFR/MeFO7vPlHLt4Sv9CgymhIqe30bPPW3KMSDnnv0VSq8
2+gZi5XJ
=pC+Z
-----END PGP SIGNATURE-----

--83eI6PlzLqmQvpV/--
