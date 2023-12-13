Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF9BC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 14:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580FA87509;
	Wed, 13 Dec 2023 15:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aHN5FCRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9A4877E3; Wed, 13 Dec 2023 15:55:52 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD31871AA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-da077db5145so5830970276.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 06:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702479349; x=1703084149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=48G7W8pdsIIuzVB02CFn7GY8xicpbYrUFGD0n6oF468=;
 b=aHN5FCRG3BIxws5bVePC/ZN0rVPRCXucFt2jdPx3nClYdP1xdosw1m8BuHvCx9hsGi
 dGCOerEH6D4EcN4nmO8KfvapfUMIXj4fhr9VOTkCokTg/7gBe3VJ1VqkqBdelnIb+xmo
 mMMT/QBg62xWhFDhGnZl7lzVAK9Klzfc/kD28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479349; x=1703084149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48G7W8pdsIIuzVB02CFn7GY8xicpbYrUFGD0n6oF468=;
 b=YryXDmQW8fXGu+Ge3/dJwYzBjLHlj+sdXYzkMZIHZgPKA0l3Z3Ik88/JtRr3j3cwEr
 fL7X+aX7k7+b4E+mdCM0ibIYCDMCnco1Oed5qx+ufAZV7sJ7vcfIQvWnkUTWGlnC/Tjb
 J6CkieNzKSvbHiLUMB6SwRaZLJMeYERzebldx/Qq1Z53waXlFGvHoYpX/5EcBJI+Oody
 Fo2VH0mA/n05lzsgmFSyzVX9xE1edUnTZ+oFZKQaPg1rD0ALZMHTak5ROoAinR3Yy0A6
 oqqvdOft2aFTnD8YAzz24e0EWiCm0FR9ZK10PJtbYO2AKuQG5MVYVfZ1ziBl3xUeVy6d
 O70A==
X-Gm-Message-State: AOJu0Yyi5r0wh/lzgwMe2JyBjVumBmlMeT7H1usIDaFGor4HcjCdQ22C
 jdhJDELeas1An0NAW+8S5XIoew==
X-Google-Smtp-Source: AGHT+IGR2Aqolry27byu0K3AF77a+Q0WaibG/C9224F02wuYV6ct/v3s3Rildi1gfIIRfjIZAqDm1w==
X-Received: by 2002:a25:77d8:0:b0:dbc:ca86:7aab with SMTP id
 s207-20020a2577d8000000b00dbcca867aabmr971406ybc.2.1702479348747; 
 Wed, 13 Dec 2023 06:55:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 cj9-20020a056902188900b00dbcd9bb4bbasm205897ybb.58.2023.12.13.06.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 06:55:48 -0800 (PST)
Date: Wed, 13 Dec 2023 09:55:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Duncan Hare <DuncanCHare@yahoo.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] net: wget: Support non-default HTTP port
Message-ID: <20231213145546.GA2039458@bill-the-cat>
References: <20231104151012.51516-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HUQt1s925AlsUcAv"
Content-Disposition: inline
In-Reply-To: <20231104151012.51516-1-marex@denx.de>
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


--HUQt1s925AlsUcAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 04:09:54PM +0100, Marek Vasut wrote:

> Currently the wget command is hard wired to HTTP port 80. This is
> inconvenient, as it is extremely easy to start trivial HTTP server
> as an unprivileged user using e.g. python http module to serve the
> files, but such a server has to run on one of the higher ports:
> "
> $ python3 -m http.server -d $(pwd) 8080
> "
>=20
> Make it possible to configure HTTP server port the same way it is
> possible to configure TFTP server port, using environment variable
> 'httpdstp' (similar to 'tftpdstp'). Retain port 80 as the default
> fallback port. This way, users can start their own trivial server
> and conveniently download whatever files they need into U-Boot.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> Cc: Duncan Hare <DuncanCHare@yahoo.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/net/wget.h |  1 -
>  net/wget.c         | 14 ++++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)

Sorry for the late review, can you please update the docs as well with
this? For example 'tftpdstp' is documented in both the environment doc
and the tftp command doc.

--=20
Tom

--HUQt1s925AlsUcAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV5xe8ACgkQFHw5/5Y0
tyw6Vgv/dACDBoBg3Zb35eej1jqo3clJKd1Y1a/OZDKz/fhx0WwKHq1h5/SQulG6
mIEyUDdCsX/7Bne9+4YisfwLs0BvRlnfnsEcY6A/8lSacp8mMBhVzU6z2+xTOjhk
6m2u5/OFRzrvxlhMln5pZ15nw1DIUNYIRKa7N/hoYUgW837mRISpxCHX/Q1/2ivl
kFLb7LZE+cW5CMWZ2u1OychaR3TF3H7GG/6DiEXrsmA+gaHWs8mTIICavanOKpgg
uXft9JssUozaS0DD8hQsYmjSVBDuJ4ciHiaRYyNlvlIckgn8ZoSYCRdDTNAy8KQw
2Hd2KA805T0QID5vWUsihmfIw/wuFwghQMoAl6yqZOO8L82Ptm2Kvk4qO4HT3u5i
E0D517wHUYqdTfzMFbX7bJRVwuO/W1sfdkqnHXdGhfmvZQ51CyxoADxxTyIN6Rqp
DYuLxuO99oaGs6Sw4tyligEAN+YN5TDPwEu9Z4m4s6zHyd+h/9yYRgEpjgZsPauw
N4JyBx8f
=8Szb
-----END PGP SIGNATURE-----

--HUQt1s925AlsUcAv--
