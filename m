Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E8EE6FE58
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1858641B;
	Fri, 22 Sep 2023 17:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ac2uX9uf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7FC8655F; Fri, 22 Sep 2023 17:50:33 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3D78620C
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59bbdb435bfso27195657b3.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695397830; x=1696002630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9e0JXKKlEIdAYYLfzjg6JP0yy5hByxVq2F4R00KQCPk=;
 b=Ac2uX9ufDX8+kO6aPF5PdRHfcD20KEOf1EERYIL1dzysDldGfgvSlzosKjGvbKoKa0
 9eoro1snwRJjek3uh7cMuP7pRoXeKm4NMr8cEePi5ZXs4JiszlUu3BM2xgyqvbIfzJw7
 DN5pxHJEUGT1ZZQZ+cfFuca6OvEoB/bkG3+vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397830; x=1696002630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9e0JXKKlEIdAYYLfzjg6JP0yy5hByxVq2F4R00KQCPk=;
 b=evNAHipYCMeOZ30wHjvRszD8C0vfJ70+9PUAVOZWxdnOmsHC9sF8kmymywv2UAD6iG
 4jC5AyHdheUE+UIWoM+IjXSBWez1Axz3ohineIIxxS2hSpFnYIQaWEWiMmqwEJBgowl0
 KS+VL+WKrmKrclxTMJOSq5+ff4AAKHAo+dDosGmj0tcop2E/eyHPIv9S005Rr/0Fp3hb
 WXdVsnB9jDc3m7cd5Xc1VaOToENJuyyV56JnwUkK9KFtuoQ8qLKUZcCY9+jSfAP3Wg4L
 WvnvqukHooZ750PthrSUCeu9IEHCgvABWTT2CvrMVcpyio7/kpi+4AWKEK5xgskR85sc
 4KUw==
X-Gm-Message-State: AOJu0YzzlHMSzJzCF1MR93zlTBDIzUXT3NY3h1o178IhpPp8Guwtd0qU
 L4zhiJSKJhUh8ypz0vC+Ip40KQ==
X-Google-Smtp-Source: AGHT+IEwE2XUDhAW45wA9cH08LFNCirV56CPFeWtlu6v18g/Vv2GX+ccrP/+LrgvPpup7cmRxdlTTQ==
X-Received: by 2002:a81:a542:0:b0:59b:586c:c65e with SMTP id
 v2-20020a81a542000000b0059b586cc65emr14300ywg.36.1695397830142; 
 Fri, 22 Sep 2023 08:50:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 z184-20020a8189c1000000b00594fb0e2db3sm951443ywf.138.2023.09.22.08.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:50:29 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:50:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Durai Manickam KR <durai.manickamkr@microchip.com>,
 u-boot@lists.denx.de, hari.prasathge@microchip.com,
 varshini.rajendran@microchip.com, cristian.birsan@microchip.com,
 nicolas.ferre@microchip.com, balamanikandan.gunasundar@microchip.com,
 Eugen Hristev <eugen.hristev@collabora.com>
Subject: Re: [PATCH 0/4] Add support for sam9x60 curiosity
Message-ID: <20230922155027.GA305624@bill-the-cat>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
 <20230922-gangrene-evolution-9c087f58f165@ifak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FUIW7A/LSyxob5gs"
Content-Disposition: inline
In-Reply-To: <20230922-gangrene-evolution-9c087f58f165@ifak-system.com>
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


--FUIW7A/LSyxob5gs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 09:00:38AM +0200, Alexander Dahl wrote:
> Hello Durai,
>=20
> Am Thu, Sep 21, 2023 at 10:36:27PM +0530 schrieb Durai Manickam KR:
> > This patch series adds boot from NAND support, configs update and=20
> > fixes. The changes has been done on top of u-boot version 2023.07.
>=20
> Well, interesting.  I sent patches for NAND flash support on that very
> board some weeks ago which were already applied to the at91 custodian
> tree:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-at91/-/tree/next?ref_type=
=3Dheads
>=20
> Tom already merged that to the mainline next branch.  I suggest you
> rebase on next.
>=20
> Add Eugen to Cc, since he still is officially listed as maintainer of
> the at91 stuff.

And please make sure that the DTS changes are syncing back from the
kernel and note what release they are part of.

--=20
Tom

--FUIW7A/LSyxob5gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUNt8AACgkQFHw5/5Y0
tyxG3wv/dpQDdtC3xnYIFN6SBZw55lyxtttchDYXXGnedn8LOABBZhpiIxKFeDZP
ggwJGS6TeM7DsDrRxg5YH7qrdaQu2MhsdOSWQo3MMuHMf1x8qF8dvqkqjmY2mFBR
UGvEZDoikZrqcCIzmY9A7IM5kDNgEyKfKBijEFtY6FGFHraI0VBgX9TfudALTmQo
DHOgTDxM1cly33Zj3av9I8yYpSNARbmB4Z5NYbiwbbapcW9yjV87BxJ4z7//hqo2
mv0TuZBr0f7GhTzaI81nLWOziJ64DeZCRy9cA56TWAXI0sQnZ/NurSKr9Sn0DXIZ
9HG1df+PC5k+X00PMZzf6Bb2W9YgPEsTBDcbPLejKKhvjXr4IKTIG+Vz8t58CbHI
EJWbISxDAissYvMXzcmgwzK0ojIqXFHKCtLi5S7IhJBpmsSLF1/M1IqfeovdxSYg
8DfZvgfWyKeia8bRPLPEO+/1yGyfezI2XRVVkwV5lzai5w2D0SSW9O2toRtyxcwI
qFfC4T6A
=bSx/
-----END PGP SIGNATURE-----

--FUIW7A/LSyxob5gs--
