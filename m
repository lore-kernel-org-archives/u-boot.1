Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ECCD68BDA
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 00:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D50896DC;
	Sat, 16 Nov 2024 01:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lGjoaY1I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA3B896E1; Sat, 16 Nov 2024 01:32:01 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2D9896C4
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 01:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b147a2ff04so6915785a.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 16:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731717118; x=1732321918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jLda2fgpJTAuAFaVkJ/oRCJA2f9BIcl7y5xFYsLmxQM=;
 b=lGjoaY1I7xc4qe7FhoQVrJj3KGfps2kA/Jp9F//LrKnbkO9Uw1EfNNw6JAPhuhpYwy
 BiTX+OWrXXg1pQ8NUm/KLYKKYd4QklbTLMj7Wwgq6snWr06e5SnGvOpBOvXN3dIwQrF8
 T9sJvaBSNPnVeTntQ3r7x0LHDWoj1mIu6QblE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731717118; x=1732321918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLda2fgpJTAuAFaVkJ/oRCJA2f9BIcl7y5xFYsLmxQM=;
 b=TrQaeFsPQP6X+yrUefJ56HgyPaHJckSgFJiwYcZWd05WCRvtYH9x+DwyNVVn+Zv+Bz
 0N1g2Xu+wpKcT0BD5l73WBMp6Gcm8e+H3HCGYuxlnDo4QaoNzJjvv6n291yr9Ne5L0Fz
 7+Hst+DvlOTvmnx327l7sPci5oqa/zSLvjySeI4CITkQdCXZ5gksogyOMvDo8jvzqLAC
 4LmDhbZWzLp9GbTG6XbvT3XGQcfwMndy/thNhaTBQ5ZprLgo96eJRq/em+0hPM4wTPC1
 74wzJb2v1cGMJ25c6qBtkLUuY2YLP/hCF89JBZ17ckukv9XgdOEdlbb4MPl0PizbQYUL
 /GVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYmaHwHYkqKQf3NTZGqGEerGfhIPJPj3OrUTgNc3xcNENb+08oJd5aciF+HfEUm3SKGlS/A10=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3Lrl33dxJoHVw+oF8XB5izJaAi414SzBdEnNFvsZAAgmacJcU
 gaLgb5UInyRTxi8D0ktVxeXscNTqbJbBdKe6cMYT+6NG35Sw1GcSN341SLc8rXY=
X-Google-Smtp-Source: AGHT+IE/XsIg13ZtVYIm+JwLtngrF0yK6tOmbABf84N/heI1tQOMdqyojkQIpCxz4qoR2pEodOQwTQ==
X-Received: by 2002:a05:620a:408b:b0:7af:c60b:5acf with SMTP id
 af79cd13be357-7b3622badbcmr697927685a.10.1731717118430; 
 Fri, 15 Nov 2024 16:31:58 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9abb66sm213384685a.52.2024.11.15.16.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 16:31:57 -0800 (PST)
Date: Fri, 15 Nov 2024 18:31:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v13 00/10] net: tcp: improve tcp support in legacy stack
Message-ID: <20241116003153.GC3600562@bill-the-cat>
References: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oanA+Z/39w6H6wYg"
Content-Disposition: inline
In-Reply-To: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
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


--oanA+Z/39w6H6wYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 06:36:33AM +0300, Mikhail Kshevetskiy wrote:

> Legacy TCP stack is bad. Here are some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selective acknowledge
>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes inst=
ead
>=20
> This series of patches fixes all of the above issues.

Can you please work with CI to get everything there to pass? Thanks. See
https://docs.u-boot.org/en/latest/develop/ci_testing.html if needed for
help on starting that.

--=20
Tom

--oanA+Z/39w6H6wYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc35+4ACgkQFHw5/5Y0
tyyzcQv+JVpRi4GLn2fjp8+Tak+RoRt7D8Fk2TijdZ7vozRWPDFk9kTGYP/Z992h
22N5QI8GjWLmBwU8XL43cdJ9TK0BhpLzVeySXtZqWMaOARg4M9/hgZqX9Rceemtz
Pj15+YDfwEAfsI0vUeXKNlUF1C5qKLmwzHwp30QDEShyQoTg1FW0jzen3lXlP4W0
e3JHYYapz8gCHCINDam+JhATQ1P0G4b8byL91E0W/Rkvv/wUWQFg4qSQi7REA+WG
RrfNdUqgX/b7Mjq7Sn2sNlLiAFVl/Sw4nUxv/hLuKRDeTkeK+OZXqnwZMmlsDaf0
DyulqTFVKnJfGkVU6+Ujwh23LPHXG7QbtcydzAjgZYKIm6GyyUKypZqVwh9GSZr7
K7ILY9gYO4vb4QjfehLrAX/0C+kUc0gz+xRXabpOcMKy+USEkFMZFbDwH917p9sq
FjD23aCeeUwN+X6duK1KbXR/9fJwMg5pRJK64Tvu1jXs+5LUOiQfMfelEpi/LEgf
2SL7Hoej
=OeSn
-----END PGP SIGNATURE-----

--oanA+Z/39w6H6wYg--
