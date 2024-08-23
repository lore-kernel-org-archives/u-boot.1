Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B683C5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C39C88B82;
	Fri, 23 Aug 2024 23:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YmQIvQ7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427D688B82; Fri, 23 Aug 2024 23:30:48 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468F988BE4
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a1dcc7bc05so150361585a.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724448644; x=1725053444; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YnVsy5xeiS8glbK/JIz+g1prZVB18mOYP/LpP+1geHY=;
 b=YmQIvQ7HKNtN8BXjEKz5kDCMuFIwRHh6LHztTIW1YDitnEXRLiQW/wFJxsCxrb8qog
 XQxexX7uR4WBZPx627OcgdVqNLJ8m3yZAaAvLetuF8PJHwBrGJZ6ay6J6F/73iLO3z/x
 L9RQaPWO5VMGV6gTBCtRr17AhXcT/ZYET8wsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448644; x=1725053444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnVsy5xeiS8glbK/JIz+g1prZVB18mOYP/LpP+1geHY=;
 b=FCA4MYlGgNWaQ+ucm9msQeEUhH0ops5awOcOcyyT/m1+IrGrWK9oxShHKAP98+vJSD
 +/1qf5NbsD+GA3vHL5E5aQJMnbSrmAp+n2szed48r/R6tWCZvC2fuGuTamV4GpaIhOoj
 60Ek9TBK9v6b4udMKg1N7T9BgITuI/XrPc+J3ZXAVStJo63mDFm3nEsA1vyrXYdrx6/b
 HJEc54a4/qTfJJWrognAd7UP0IXuoTPaghNzb/s9mE1/PisY5jsb962eLmkQhwCGlm0E
 zpYmpCbfQ7tO9AZe8IbquTR6ElGy5whzYPftsdMAzLY9RC2vg5l7KM1d3RgeLwaGx1SW
 h5PQ==
X-Gm-Message-State: AOJu0YyUBpCg9DNv18sQ4OoG2jDXVHXfB17wGO8bNpH4V5h9L6aNgz5f
 Xzg5vtbE9S/bEZF/po8tm1VkBe3Ipp/I+5ARY8zykAFtcwpkTM6LE1DNvLZRi0A=
X-Google-Smtp-Source: AGHT+IFHpzmdjClowwjfvfBIIj/ywPWIgVyBsPZ9zQElwUZLTvpYXux2DFxSm/UQ4odvk4QqhnLiEA==
X-Received: by 2002:a05:620a:28c6:b0:79f:c0d:782b with SMTP id
 af79cd13be357-7a68971de8bmr510234985a.39.1724448644020; 
 Fri, 23 Aug 2024 14:30:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3f7b75sm216783485a.104.2024.08.23.14.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:30:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:30:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v9 04/37] arm: omap2: add missing #include <netdev.h>
Message-ID: <20240823211833.GA1626301@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <a74407230cf665355ed114f28adbef9fd7e1f80c.1724419624.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wIFTl5Vdx0Xt1nM1"
Content-Disposition: inline
In-Reply-To: <a74407230cf665355ed114f28adbef9fd7e1f80c.1724419624.git.jerome.forissier@linaro.org>
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


--wIFTl5Vdx0Xt1nM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 03:48:08PM +0200, Jerome Forissier wrote:

> emac.c implements cpu_eth_init() so it needs to pull the corresponding
> header file.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wIFTl5Vdx0Xt1nM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbI/4AACgkQFHw5/5Y0
tywGnQv9FpKN6Btvd6IxE+yz/8CUzv0nJojv3uLPN7i6/AW5EBRb7icTG2LDo/Fa
YsGytkipzqQKv/VAKrQlyhghf/8s7QEWqW1rrI7XL3hBioagqV51GUl/ZeY9WU7G
krKgWk1/3JVMNfpRL/OuepqOm4t+JAkjpuetzTq4+ihpEI8vUnFaVcNrj21NIGmm
N0x97Jz0T6BeWMrG2H/oX8ozY4BtLi3wwZ0tQA2Vp/XTqtlBTm/89IvwLUTZANY6
JX/z9CZE/m+vMtVgxahtxhxxE5omCJmeFq5TqQEX2GpdE1RIliEAkIcrHoRsNAvk
IOM0Pe7LkFwa/eEmtDI729z9PvIQleGgNBXbPP1KH3HzKEpa/JUnJ5XbQfA2kpZn
0Z0pK6hXF2kJdSoGaKgNFBbzWQ7ZAmetOnsRpbD4MkVEEIjcs/yAyp+UVDhoSt9Z
7TFNbDALqVfnopWiBQnyhgyv9UqIQjlE8+Rbhrb47IEzk/Z9Pj4M0r1yPxOw+RSV
IiWnuJTA
=Tw47
-----END PGP SIGNATURE-----

--wIFTl5Vdx0Xt1nM1--
