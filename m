Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB93C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7DD88046;
	Mon,  4 Mar 2024 16:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="skEJ4li3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C638803B; Mon,  4 Mar 2024 16:27:50 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0297188039
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-429de32dad9so33916701cf.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566066; x=1710170866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kPuqGtwLJIH64JayHsRsBgZzEO3BJjRu0pt7985LWwg=;
 b=skEJ4li30pkEWZYkj7WmoBKDSOZAMFaJtp8dl3aknd/HcxcA792eJblgvnpaY0PoOa
 9JDQfuf0FVs3CYahjs5Ur+dIp6lL/PNR9y2w4QSUM/4h/psV+9wFg719jAQz0igMWlyr
 OwfijhnsIwbt2GZN4YzoTJGGufU9PdiQCv3Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566066; x=1710170866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPuqGtwLJIH64JayHsRsBgZzEO3BJjRu0pt7985LWwg=;
 b=cj+gmIW4tCjVdKjKNpQlvTrm0I116PP6JjgohALxUWb6h49zOt3s0brDe3kl/6fZmb
 2iu+LvjXXFiJ1uu0ytT5MSHmspz1rdhWTb6yJtvkoSphw3bT52TeHP67jkPqkzC0v1h0
 EsnGkB++SozCJPJcjbnVl4NFWsGC5aYtbHzJ8lTUj6tjKBKa0pEJykWat2jv78oKvksG
 24ltMvqULcFVMSV+fywg0aaYriVRor6VIrNHeXTIF9awowlyj0PnpFnRm2EX72LpnkmJ
 vpVErqklSbJb7zc02oHUW5gKPUpS4z4ZYyJb6qui3PQYTRMLYARKdeYs6ubk4CwjfbMM
 fkGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6acrjKYW1lt1zJ0Szz40/8nafzjBQgswsPyfhGATUk+54oC8Ux1yTXLmepC9/dIBK0QcaMgBgLJ6aiRc/chGEFh2QRQ==
X-Gm-Message-State: AOJu0Ywvn7fEl2P44GLY8rkS9rwN+07vgc2/li13iT8bqpE8jQ1BzNC4
 F9G1QzKwYLjj+1wMiWsR0SP995YFf09EZ26uUEsdfwu1a4QF1mVbyenmKSl18Zc=
X-Google-Smtp-Source: AGHT+IFKT72IcQyQENdUbmx/IFkLserw12lTu9TYOOcpR6uUgGvg89KE/oZkcct7r7tUuh1s8mfDpw==
X-Received: by 2002:a05:622a:14b:b0:42e:e152:be3b with SMTP id
 v11-20020a05622a014b00b0042ee152be3bmr7132711qtw.37.1709566065657; 
 Mon, 04 Mar 2024 07:27:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 r21-20020ac84255000000b0042ef9768d15sm261433qtm.13.2024.03.04.07.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:45 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] bootstd: fix build error when CONFIG_MMC is disabled
Message-ID: <20240304152743.GV1523872@bill-the-cat>
References: <e910bbd4-e509-4e6f-a458-d2e00741aec6@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="COrdl5ac4v4H2O4o"
Content-Disposition: inline
In-Reply-To: <e910bbd4-e509-4e6f-a458-d2e00741aec6@moroto.mountain>
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


--COrdl5ac4v4H2O4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:26:21AM +0300, Dan Carpenter wrote:

> This code assumes that CONFIG_MMC and it causes a build error when
> the config is disabled.
>=20
> aarch64-linux-gnu-ld.bfd: test/boot/bootstd_common.o: in function `bootst=
d_test_check_mmc_hunter':
> test/boot/bootstd_common.c:83:(.text.bootstd_test_check_mmc_hunter+0x70):
>     undefined reference to `_u_boot_list_2_bootdev_hunter_2_mmc_bootdev_h=
unter'
>=20
> Fixes: 66e3dce78750 ("bootstd: Allow hunting for a bootdev by label")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--COrdl5ac4v4H2O4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6G8ACgkQFHw5/5Y0
tyxubwwAhcNcgeA5JWR71byM1Wb0iOiblopT+QGR0zDtuLpuXvJY5Sszf2oquwYu
4zjetiR8PyF+Vsr04hrVEtxFYHfpzdp8q5rkhdk0d+ujeeYSQD+SXL7JUgcDUhPE
sM9xTxARNxwOmo6Kty1xUl4YB8E3N3kgOiexsNbjpEP2r2yMs+/czzR2JK8Yr6CE
XF8NJWdA5vcvJkUau788mM2VlFma/J36+mLkhc96kXEq/5iGe/J1ok7hdmKvCghG
kTPt6F/iEA+A3mh5oFYqKPC3jXMyHCSxuzBHrPOIpz6f3d2+mDJRNuIOoltDbNVb
CLKV7/k/eyCSj4qkgKVqTWcZ5Bo6H0OtfWrsWiKURj+QwpaT5utqzI0PJh1peL9c
XdXXl60akZdDGeYVDggthhPqU6NgIM8JhG/qrC+NuoFwWVuCHYd00qmy4ZCRh89G
EfT7/BwKbO1nHmTPy9+6rGfYznipYjst5buytvYq1aWIr45Ai6RYmmB5oF0W8kxt
+JTR2vMU
=h3q9
-----END PGP SIGNATURE-----

--COrdl5ac4v4H2O4o--
