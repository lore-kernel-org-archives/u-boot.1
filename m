Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C7E10775E4
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 17:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B460483BC7;
	Wed, 18 Mar 2026 18:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gAobw9X6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D4483DA6; Wed, 18 Mar 2026 18:06:59 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB25E83A41
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4138136f02eso115299fac.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773853614; x=1774458414; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BZ0dwZTWCLUjeTGLQnNUrpEZyPgab8wV8W+8/XubfJw=;
 b=gAobw9X6lZX3pbMqg/Y7LcwNAaI6WtwIyxXzc487MdUup6MkEgn0D6SuNJyo4gija+
 eYOLzvNTAPrairuTwFWegFSj/kNyZwRnZiynCG8A1K6dut/2/hwdEN6qSZk9alndRxnR
 h0Zoo18UK8y5Q6zvc3ZL60yCq3Iq4U9jMkpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773853614; x=1774458414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZ0dwZTWCLUjeTGLQnNUrpEZyPgab8wV8W+8/XubfJw=;
 b=o+MklH3kpp/7WEAZzaymMCGeg0KNFGHCXtvztnLzqZZ3EYMaHJI2p/suAdOBw/WWt4
 6pT0QnuBEUReAyZ/CImGeJ9eCTIBtBJ6irpbdyJHYGQi3ZKna2hKxg2yNIqKRJpDuWBP
 TMCRZfnCEPhIzGSFUIAuZ1CtxVwK/U44ki5L93PXf+0LfB7bsXjWrtfngTg6ilGCuzm/
 lga2b/SJs29ulMElhAudUjCdmNbxD147/iXGBFTWYFmBgwwPZ8lGQLCOm7xEcOMgJkMN
 qTpi6ExTJ4lDmxsUq43r/Nldzb3iKWX1lJqU13LixH/K/3kEIvxWDL9lPoPUF21+bs2c
 3ZSA==
X-Gm-Message-State: AOJu0Yz//k1V2pCEoXd1qb3aZMnOxU8wJ21mlbC9b+q0Osfnwwt+uvpf
 ddjGe/LcsczPO7ERhMYlWVmRw0jZEEWKQ7bI0uXgXV81TNKowyITwPaRTqwU8G4QduU=
X-Gm-Gg: ATEYQzxKYABRw+QSbdi7dsA1YXtfFJFpXHeQAa9XB/oJmlpPQa/IPF8ibIMrneBtcEU
 tJUJTK2oxm4rFLpZy/9IooKrpLmDQ7xdOSiedjM4RP5LTcQibqqS3mV47dp9jHsFolUsrzAJyCm
 iDXRZXboAR4Z4Li94pKwDUklheDZHgNPZQwcG7aK2VvlE6iyzOhiTXqvF+RJJFnA6eYRdll9RTe
 S0JAAGfEr4ylV6M3BKBfXviz6TdQXAeqBGS2UEDyfQmpS0yqHgMS5+vhsfWRb7N3ScdScRs8lK5
 5J6eTjmaIh8s2fZjVFhaNTnIsHC/sVhTqQwrh+/lz5yZOje5QPwUu1eZzXd3+q3AouLIjH+iwQK
 x+Y6OEYnwV93nsWLewZel2PsZZewLNHDIy5/q9WUK4i+x4nPSCxhQe8DIb++PGIlZRnXTCcIL13
 Ju/F+12WPUO0wiyivPssl+K1TQzknobgtMriAWw1fQUjTPrCKpjZ5ARXwW03mF8VSTRiCazSxvR
 kIY5ckTdkJZ8NgQOB6Yg8pPqxI9pol0fyVqwKdpSJ0K7V/t4rtc2KsuKNw=
X-Received: by 2002:a05:6871:340b:b0:3e8:970e:d4f7 with SMTP id
 586e51a60fabf-41bd3c95403mr2701704fac.11.1773853614342; 
 Wed, 18 Mar 2026 10:06:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd288d791sm3401617fac.7.2026.03.18.10.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:06:53 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:06:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: Pull request: u-boot-sunxi/master for next
Message-ID: <20260318170651.GM502704@bill-the-cat>
References: <20260318115702.1637000-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uA9gXr/A5JhsEIB0"
Content-Disposition: inline
In-Reply-To: <20260318115702.1637000-1-andre.przywara@arm.com>
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


--uA9gXr/A5JhsEIB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:57:02PM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull these sunxi changes into next:
> For once, replacing the legacy LED API with a more lean alternative,
> just for sunxi's SPL. IIUC, this would be one step closer to dropping
> this deprecated subsystem altogether.
> Also adding two DRAM cleanups for the A133 SoC. There is a third patch
> which requires some changes, will care about that later.
>=20
> Gitlab CI passed, and I booted that briefly on an A133 board and some
> board with a GPIO controlled power LED.
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit a27980786cfb3c430aa1c05da8e79180c584d2=
21:
>=20
>   kbuild: strip sub_make_done from test-script environment (2026-03-16 10=
:41:40 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git sunxi/master
>=20
> for you to fetch changes up to 98429b7be6f45d393cc905b2cf9844eed7b09b8a:
>=20
>   sunxi: a133: dram: Align parameters terminology with Allwinner (2026-03=
-17 23:27:24 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--uA9gXr/A5JhsEIB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabrbqAAKCRAr4qD1Cr/k
CttlAQDRuDpdiDTIdYHt9pI0rHwU6k9GHOFAn92VpkoJEjYs4gEA7GQvdvKRK4cv
1wpoqvaWiolUrixhiV4tasAi0J6WjgE=
=igfv
-----END PGP SIGNATURE-----

--uA9gXr/A5JhsEIB0--
