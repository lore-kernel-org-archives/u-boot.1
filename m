Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE7BC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 21:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6EB867E2;
	Sun,  5 Nov 2023 22:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nFHYi93f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4495F86487; Sun,  5 Nov 2023 22:19:17 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD70C86BEC
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 22:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d0169cf43so25524976d6.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699219153; x=1699823953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MQsgZTl3kNMQ+QoRpNASAB2VhHQTWL7kamCFJOJ0jd4=;
 b=nFHYi93fRmgezVF/fiOwGwqUAIV5cek6TI49+q7aSvuZC2/1gUv+dTnqh30TN6pcni
 asCJgIYDgS9216IKcOFYIb6+IreEs5h5zExZBJVPjVJEIdVpCoLK/LjOgnYyQQRymtLU
 HbAH04iys1Zcxa8BzY42atyEgIlLqgMnnYNVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699219153; x=1699823953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQsgZTl3kNMQ+QoRpNASAB2VhHQTWL7kamCFJOJ0jd4=;
 b=ffGNDxTPs/PWzI1pwWBW5RomYeJGoLJtmbk2/zsolQ7tNvDF/6wzl80xeGGXoKwbZJ
 h8ozRW6S67WHbxj6oJ4Z0LHYPybjZsaQqzUk9X1eM2Q58BMaADbzCOG7eboQz9mqF/gc
 OyvKOD7uQtI7ON9kUUpddmFc5UoYa155kw4ae4sB+WUcWEcgJy/ZDPhj+M3esRRk9Ng0
 vRdkQvyI62d0vn0oS54PgN0Vc5DObx67EuCVUImaXnz1MuXySAG9sriwgYptpFFgQeDp
 4hPz+DX3SsRSuOh2E3pE/kJ817+fGlgShOFX0ijHN/jXhi8R56LVr0acDSHfjXNa5Gev
 xk0Q==
X-Gm-Message-State: AOJu0YxzsojnNYoleETTtHFow23hd1Y5UG0NE1e/MzgINJxTiRFW0oCD
 u7/PdHlQxZpkDM9hykGl8lf0IA==
X-Google-Smtp-Source: AGHT+IEkpiRmDrDelQCcTMcP18PlB55UOQlROERJKa9mTEHka7ylrR/M82xU3wyu/sCv/yImUDUwkw==
X-Received: by 2002:a05:6214:c49:b0:672:a2f4:d3d6 with SMTP id
 r9-20020a0562140c4900b00672a2f4d3d6mr24078184qvj.62.1699219153349; 
 Sun, 05 Nov 2023 13:19:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 s8-20020ad45248000000b00670867d7bdfsm2851432qvq.122.2023.11.05.13.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 13:19:12 -0800 (PST)
Date: Sun, 5 Nov 2023 16:19:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 1/4] bootm: Allow ignoring the load address with
 kernel_noload
Message-ID: <20231105211910.GE496310@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DuUqjcGSXPdyfrp8"
Content-Disposition: inline
In-Reply-To: <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
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


--DuUqjcGSXPdyfrp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2023 at 01:03:51PM -0700, Simon Glass wrote:

> This image type is supposed to ignore the load address. But at present
> it fails if the load address is missing. If it is zero, the image is
> loaded at address 0, which may not work on all boards.
>=20
> Make use of the kernel_addr_r environment variable, instead, since this
> seems to be a more reliable final address for the kernel.
>=20
> Another option would be to create a new Kconfig for this, or to use a
> region of memory known to be free, e.g. calculated from the DRAM banks.
> But in any case we should try to avoid conflicting with the
> kernel_addr_r variable. So the approach in this patch seems reasonable
> to me.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

How are you creating the image in question here? A noload FIT is
supposed to just supposed to go from where it is. Where do things fall
down later?

--=20
Tom

--DuUqjcGSXPdyfrp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVIBsgACgkQFHw5/5Y0
tyy7NQv6AzZyAn5YF/5lvE5V0uGHY6bnAip5vTqAVOMOUFtJ+pUowD1ZIx25i2KK
WxXmlkET/a55bHwmLNYZAVV3r+LHJwJxfDcxLiM8Ch45f5K5rItL6DQUH6MOIctx
8Ih8TMMESv66JkiYVi1ItSBkp0KWZ749FCHUk4+njRv3cHX5Y3xEYpAYfO3Chd0L
JH3CwXXfGZ4Ua7iwQaZAIOc7iWZA2XSk/XkW/gZbDpHjWp2h7URMrW+IRNpOTMZ/
wd0Cyok3+nXM7ZzAOXb54DtMs5drKp4KQeBd41yyXCmucrTbvDKlJZIffrVznIgL
1cEUwLpnzP2qtTFTiPlUWAYgEM15uwxilanpThwGmFUwYJ0t1hHISbu42sfqnWek
asFwfF/BV6l7Py7onggyP/HKqHrxfyUw9EMPe23z2caWI10y7uezkuRGNDEPpUjG
OLfcsf1M3NA5Ij6AEASQ/6s9ovPZPp0iA8ghoII/wyEAMykKtFd2tbZZEsc1AQgI
ue7qOANW
=4MuY
-----END PGP SIGNATURE-----

--DuUqjcGSXPdyfrp8--
