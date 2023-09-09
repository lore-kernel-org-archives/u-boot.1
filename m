Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9776EEB572
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 13:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16BD86A38;
	Sat,  9 Sep 2023 15:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hselA1Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE32E86A2B; Sat,  9 Sep 2023 15:31:04 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C870D86A38
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 15:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d78328bc2abso2803152276.2
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694266258; x=1694871058; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mdle5ultpgEbqOdY9Xl1+2KrGsftRSsrsw3WeORQOio=;
 b=hselA1NhFsVBLwyKy1WUatV4WOw3cTPMEuk0wkZKSNlyi+Ha/sR5UQRJZVA1ZJy3HY
 vYuqMs3tjsJtc7o5JSPM50Mqcl1geza7vn9kSL3oFQtdwstE7ZjeAVl8kT4OLMwpe8yt
 AkyJgjrsd3PWOwCyY+nIZ3Ax7l0Kwlhc/brFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694266258; x=1694871058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdle5ultpgEbqOdY9Xl1+2KrGsftRSsrsw3WeORQOio=;
 b=rtYu+BJpmgklXTCG6Qgegd3deLkaNOLdnA2+hJKsXrVc+9/4q5zbO+v7u9j9dH4Gn1
 eUjoKCKGRYucwzVbDo/my/vlfFUbKLenmu8iteFKR9u2jebVS55wUeC13tCQfytxtUsB
 E8n1vU6IPStCTYXQSyp1a5cHNaIF9ElXNQSIHgnk0T17Mz8S0M4QX0xIKL6rmKywVlrN
 mq1ch2Muy2qRzeRaZq9ryHpkUcVeIWbC1zmlXCP7qRI5/Aph/681aqMmrnGVVq6kL68o
 8e/M+AaijZ3eOvDm0lMp/8vVhbPRNlGEgwg2NjxBqiRRIv2A9drMs85y44MDDcwloGZW
 jkSA==
X-Gm-Message-State: AOJu0Yy8qx17I4A5nhigoK3ZOr6bK5I+klNvOpAQ+6hU4baKs4e9tfcp
 ChtzDGVT79u9rDmxZi4iGciTMA==
X-Google-Smtp-Source: AGHT+IGEsXQGiyWSD9ZHUB7+FE7BLtq+PyqqyErN7OFEbxcToy5Q3BeIj8apPUTYhhdpyJ+8+wwuug==
X-Received: by 2002:a25:40c8:0:b0:d0a:da40:638e with SMTP id
 n191-20020a2540c8000000b00d0ada40638emr4699519yba.12.1694266258348; 
 Sat, 09 Sep 2023 06:30:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f749-5d0d-9a20-19cd.res6.spectrum.com.
 [2603:6081:7b00:6400:f749:5d0d:9a20:19cd])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a056902010c00b00d71c764379fsm131310ybh.55.2023.09.09.06.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 06:30:57 -0700 (PDT)
Date: Sat, 9 Sep 2023 09:30:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: u-boot@lists.denx.de, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 2/2] board: verdin-am62: fix check for minimum memory
 size
Message-ID: <20230909133056.GN305624@bill-the-cat>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qhyH0eUn6I96tRGQ"
Content-Disposition: inline
In-Reply-To: <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
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


--qhyH0eUn6I96tRGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 10:08:50AM +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>=20
> verdin am62 SKUs comes in multiple memory configuration, check that
> the detected memory is at least 512MB since we have some
> reserved memory just before this threshold and therefore
> the module cannot work with less memory.
>=20
> Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--qhyH0eUn6I96tRGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8c48ACgkQFHw5/5Y0
tyw/iwv+Pim1hzsW/AAsZES9BarWwpqGCmmvdkbaKbcyLGtyX1U+O8gCrLKDVOJv
xNlpbP+av8eTjT3vFFz7Kyw7ZgMVSLRx8DDiobvwZOk2S3GUdEmYutCbSr3SnNQb
L+o+sIzHcwP3fAF49T4VC7nbqHVbMaglM0yb4LURD1sS6sb2YyyDbi3Of5NRlKVl
HkEBRvFjMP1KlSkwTkM7wYsm1T/UNhzjwwGSXAby1o6D64Fp29PIvS/Peo1m7kxs
+266yM7f2YQNvdJcy0+XbIYxEUnq8YD/919i5leXP83++Rg0F6e0owYmJHj+ZtiL
/02I2e61VKh7nbp9Zs/g8/JHMRcc6BOdL3EQ/9AwYv73kye9fY6TLxhasBvsfZcM
/oeVQ2cUFe8WqMbNEu7cceN42nqoVYiUIGoPM7JWK1P7qOjt47J9MFmqMl07WbQp
d6kcbWJFh0hqK38ibUWQ64XVHYG5LeyR3xh6DNcTad4BRNC/fEOHzBV+p9rvCKKG
H27rXYWr
=ah3f
-----END PGP SIGNATURE-----

--qhyH0eUn6I96tRGQ--
