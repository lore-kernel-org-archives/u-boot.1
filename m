Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA22C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769EB87680;
	Wed, 22 Nov 2023 21:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWu2M1gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C8787677; Wed, 22 Nov 2023 21:49:59 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4085E8767B
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5cce5075bd6so2332787b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686196; x=1701290996; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5eBtuPTmmkrZAwMShQB+cmiA8QVC1yAAhwRYM+8/ges=;
 b=FWu2M1gmwwMNDnJPZ2nnCtBQ9+pw76U/+BSTqYoawZDlJmBviF6H7RG7M5IdRcA/Ec
 9xPOdBEvFmK84l44xDdQBL1FWRMwhP1gXq5EBpaUHS3OhyMC0TeUe1eTUrVLKD7Jo7qh
 L6WA474Ah9ukcrb2mirKnNPBzpoz5mEhGFyNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686196; x=1701290996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eBtuPTmmkrZAwMShQB+cmiA8QVC1yAAhwRYM+8/ges=;
 b=d+GlAip72cuR2B6ekZVtTPlBPDm+KMtwzpOq/hA1Bz4Cl86mNx0E3n619sXjjFleRw
 zYFykD+hq4jbDMlakobpBsepN8OnlmIfyGVQQYdkYVx1D/Go9+GLIDP2h9XBb48b4czy
 aAOcaQvjhjvkIb7iOAyjuGQu6ywFiOvFlocAzwsQkiPC7rzooZVfLqBFB25alJVg3RPh
 /ObAlZx6MdkhN/wSfDlkonfFT1s/C9qvlT80S9ZD2pdeZy2THsDJh0Gur7JPDPI2jpyg
 mf9QaaofjKc3PtMQWlbjXcKU5AN5TDXM4YdpTqTDHhEiBs6vRWAfZiuxTLWTs0r80rfX
 7LRA==
X-Gm-Message-State: AOJu0YyFbHqZxqmqXdGOF+rAi8e4PqwpMOR4iv63wIN0/SBwPKE+7o7F
 ASlk43AMg7K2KkRoA2IfzlKesA==
X-Google-Smtp-Source: AGHT+IHUtBw3wgNDP315Um/vQuAidPpwXkwUq48APoPmc4jSYtFdL+FDFixTUVHP0MzPoe8Qd4qDvw==
X-Received: by 2002:a0d:e6cc:0:b0:5cc:d88c:ea19 with SMTP id
 p195-20020a0de6cc000000b005ccd88cea19mr661313ywe.6.1700686196048; 
 Wed, 22 Nov 2023 12:49:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 d66-20020a0df445000000b005cce413fa69sm86134ywf.102.2023.11.22.12.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:55 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: Re: [PATCH 1/1] arm: k3: Enable instruction cache for main domain SPL
Message-ID: <20231122204953.GI2513409@bill-the-cat>
References: <20231113190721.1841748-1-jpaulo.silvagoncalves@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bEwxHqJWTy5XZTNy"
Content-Disposition: inline
In-Reply-To: <20231113190721.1841748-1-jpaulo.silvagoncalves@gmail.com>
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


--bEwxHqJWTy5XZTNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 04:07:21PM -0300, Joao Paulo Goncalves wrote:

> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>=20
> Change spl_enable_dcache so it also enable icache on SPL
> initialization for the main domain part of the boot flow. This
> improves bootloader booting time.
>=20
> Link: https://lore.kernel.org/all/20231109140958.1093235-1-joao.goncalves=
@toradex.com/
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> Tested-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--bEwxHqJWTy5XZTNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaXEACgkQFHw5/5Y0
tyyQzgv/YCSl2y0shSccnXQ5biPcmzjo/Rd+Nq8PEUKTuprJ40wOI+pg5a6snHSZ
YM/gbPUJA4SHdR7CQBlQzLPkfHc6SjHIV2vLapZvfZPvIDhjd4Ck3+l4luvyiQGR
6NhaC4cILuXzOIOqfw8q+kmb24lSB1S2KUudMPqMCCookPTDMySAIdQrlcRGQ8bN
9LZh8DO/bF3VnIBeQfQ8TaRAFR69yy+b1AuLkwl6iwDMIoomg6Nd88lhXj9D1wKz
QR8NMWGpKssi90J8HyY2c/0kZzxDNzXA/YV9BaTlVOmMqrtVHULuR90PEWDJ7vj7
AaNSkV9cFtab2fVElz5mQrHGYCHcWH4UMmNknckSTK+Hp8ksiOSnr7jgNs9v/SM/
/ttrdVR2yfu+H3vVBGJAwEYuuX/VsHpQntW/vTHGKoziqq9yXscP4l2zj9QwE/rb
nsABUjWN3/hgY3o427IhNswC4lP6OFH2+GUhL3ZYlUFvc/72SHp32N30IhNmxK/H
cWoqGNIE
=GnTT
-----END PGP SIGNATURE-----

--bEwxHqJWTy5XZTNy--
