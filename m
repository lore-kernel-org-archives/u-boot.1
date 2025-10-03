Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319F2CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D458386F;
	Fri,  3 Oct 2025 22:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PWgim+ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9F583870; Fri,  3 Oct 2025 22:19:00 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA8683826
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4242bb22132so25453135ab.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759522737; x=1760127537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eLkHjft4fmvRANPLz2ptkHQU1bExeMiL3B3LxpBrKRA=;
 b=PWgim+ee1M0NX8OyYgwLGlL+rFVKlKrYjFy+k7Edkjyr0d4vceUprVMqsBjFnotv1E
 INvzNnQHyZLW2hy2OqcVzRC661ZaUpopglBY2RA4I6uzlQJ1Tlv7EvE7ZkJq/AsAlKyT
 lk2HGdVhnXAiu2n2ntTcUvQcJPqzNpnsYXeSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759522737; x=1760127537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLkHjft4fmvRANPLz2ptkHQU1bExeMiL3B3LxpBrKRA=;
 b=cHv5DaDLbcgi6i1H1SsbNxuZqlz7PQMXzsdOmMu+MgV0Hqrk2uHliU5kfhn36z/fmu
 GYvMVn48GbQL8JDFJqztgNvQSMYoUbw90XJpmlJ+SS3nOFg/QH0t5gPmwmq08NEoNdVl
 Ff192BqdUK95ZjJVAwjV4Lf5WK7vvIPLAFCmwoAgC989th/T47f9IDY1+w22+qlXngw4
 Db6SQuzpjF7Eev4kWrT6C3TIyGQbE/jG4ifTmZ9FuCYpA5XW2Z/GZhflEKpCj91AlQ6S
 AuEI43rhDMCmC+H7O9gkg7ljONiChFWGdlp5aZoNmGWM384XxIhObgU4bUacMuibkFnV
 dUDg==
X-Gm-Message-State: AOJu0YxFxslNzz2ZvONKuzWgdiI3+9pGEI6wg/3cjgL6IwQxDTbFERQT
 gKoQlmeQtPx4zrx+jyEjFdNoLW3GFj+r5u4r1/hj6q4x2M9wMrko6nLBqUwjfVNy0Xc=
X-Gm-Gg: ASbGncuMI21NeBinJi2Z2WADMDoEDArAMCkD5ncdA6/Ftb96GAjEIvBMn2FiJBtkFVY
 dnZcgsR6jvJd4el8y5H+11VernbEcn/dgpTSjnagh8kStim/HepusQd6JI2A1wIkklUwNfqn8fw
 FFbN0WHGYMYjEhNTl3g+SZzqcGLiSE/vzqWATipKQ0JULA/gyQcSNndLjUuW+KFWyAvx+frQMXL
 tfLfKz5WJxN3iuvHBs80J8uHKeWAzBzob1kvyWd5NDLSwfG10aIHlvvgixfSR2brqy6pmEYGrxT
 NQZ/IT4lkkm2d1t0WAw4jx9amsWdhGSGuyjFZMyefmsNbvjE2flo/5vBsQBkkFuolTrH/uOjATC
 syT8YnfXp8kShw3sIm/dSqW+4v04aybUG+ZSpB/Ofo1kcKsNOb9ZoOUMUL0h17dL+UMrRvQQzNn
 PN6Qq2vsDi+A==
X-Google-Smtp-Source: AGHT+IHLKHPn4gd7O4FYwlaMJdH2wVP2E86dDPx0zk6s01rXjvy1Lnw0SnGMkX1gfTkTD8jzsgxVDA==
X-Received: by 2002:a05:6e02:168e:b0:42d:8acf:a6e2 with SMTP id
 e9e14a558f8ab-42e7ad84328mr61370285ab.15.1759522736846; 
 Fri, 03 Oct 2025 13:18:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42e7b754202sm12442415ab.11.2025.10.03.13.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:18:55 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:18:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/5] pytest: add test script to validate Firmware
 Handoff
Message-ID: <20251003201852.GU6093@bill-the-cat>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003192222.767882-3-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VhdxCyrQ8SUklnwZ"
Content-Disposition: inline
In-Reply-To: <20251003192222.767882-3-raymond.mao@linaro.org>
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


--VhdxCyrQ8SUklnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 12:22:16PM -0700, Raymond Mao wrote:

> Add test cases to validate FDT and TPM eventlog handoff from TF-A
> and OP-TEE via bloblist.
>=20
> For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> OP-TEE indicates a successful handoff.
>=20
> For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> successful handoff.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2:
> - Control the tests to depend on 'env__firmware_handoff_enabled'.
>=20
>  test/py/tests/test_fw_handoff.py | 108 +++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 test/py/tests/test_fw_handoff.py

We should also be adding this to doc/develop/pytest/ as well, to make
sure the documentation is formatted right. The output itself will be
missing on readthedocs, sadly, as there's still some underlying bug to
sort out with the integration.

--=20
Tom

--VhdxCyrQ8SUklnwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOAvrAAKCRAr4qD1Cr/k
CnUKAQD5r9b1yMsDQEEo9h5ZOFWSFNhKmOk92XPv9+cotuybcQEA9q3sWr7KKhuu
IoTHCgaybZqq+Y8sru4IIKADbUlmJAU=
=y+kt
-----END PGP SIGNATURE-----

--VhdxCyrQ8SUklnwZ--
