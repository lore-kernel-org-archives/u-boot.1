Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88F3C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6201F8863C;
	Mon, 10 Jun 2024 18:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3JUvmzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E987A88621; Mon, 10 Jun 2024 18:29:45 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266C988645
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-254a7fe21aeso815679fac.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718036982; x=1718641782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KHwijt4/WylUY3Z6rG2szCOOu22EO4Se+xKhptTlOD8=;
 b=f3JUvmzdrqrBEhgVEeCeMLH0VGQMWVeBRcG2zVVWz813QmVIESPqvHuwUuo2CBe/X+
 bTtuGrx9GeWKuLvax3DBEaOnT6UA3GmdJVmgOfMk//0kmoZc0Kn/fFo2XFaPim7iTSSG
 IExpV1KYNhMKgCrjsJEXWgNB4Spi1qTAoF65Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036982; x=1718641782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHwijt4/WylUY3Z6rG2szCOOu22EO4Se+xKhptTlOD8=;
 b=OdKwSyYpQ2hLM5zQU9LGl5L3ToIBljb5vk8tdMj3lfSmdXULcoaUDkqAEdvQVgIzoD
 m+l1YDZtJaoHYJYveoPe13hKey42CV7+5D5beGi5Fsv284GZ2PYxq0F5EWGUf5/P1Hku
 nvEap9mosu6X6yoncUd4MAZIW+ZSIp6ZTrlTMlZPHO33kzYn6FJJHXtivVgVyXTG687D
 hWvtfLagwYT8HssihijpoosrZ6vNzcd3kiXz+tXuTnmtVcmNwCxEzxhdwBGsILgmlHsm
 N9I9UNp+f0jpzJM9R/dNUwrTPXOFkH++P4cqqRuz/1ZuoAl5NUom7cpgfyyUEPcP7/rl
 bRtA==
X-Gm-Message-State: AOJu0Yy9MoTN42HdNUXLhZ7PnIjquuHOb+oI+SNJiw5Jg+agr5wisvVk
 cubeby/c51DonIJ66Gial4yenQ8wYpzAxsAE0phr5xH1uWyI9WvURCFSHKXgpck=
X-Google-Smtp-Source: AGHT+IFHoDekiFjgtlBcU+Z2Ad6PeYL617uLVwUJq9ndKKiF7h/wzGxMwRYowThKMOA3Zh5JLTLHCQ==
X-Received: by 2002:a05:6870:d607:b0:254:c4b2:25e7 with SMTP id
 586e51a60fabf-254ecf3a7b4mr68593fac.19.1718036981706; 
 Mon, 10 Jun 2024 09:29:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5baf4ae6fd1sm504924eaf.46.2024.06.10.09.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:29:41 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:29:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 9/9] Drop the special am335x_boneblack_vboot target
Message-ID: <20240610162939.GP68077@bill-the-cat>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BGkaIGsKFTNfG7Ez"
Content-Disposition: inline
In-Reply-To: <20240610145920.3302001-10-sjg@chromium.org>
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


--BGkaIGsKFTNfG7Ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 08:59:20AM -0600, Simon Glass wrote:

> Now that am335x_evm boots OK on the Beaglebone black, drop the latter
> and update the docs to cover the change.
>=20
> Also add a few updates about 'make fit' and drop the note about the
> security review, as U-Boot's verified boot has had quite extensive
> review now.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BGkaIGsKFTNfG7Ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnKfMACgkQFHw5/5Y0
tyzyjwv/a05HZ2IKJvhnWds8bUS/G24zn7+U8HaUZ+d9l1ECsJGFEPu8meXsqC1E
h3eGbmClpQcocpVL0sCXnicPvT4iQx776umOHu1fu4Cy8xGsedZMSI1Ri6ZDzJ2b
RPxTEKALEb7NR4WGRlrs6BuL2+z2rXZTFh1f0cMRYB7UAFMPG0ZcjNYtU8P7Ckal
Pwd+M+SMlS4uDUsXwrI3yWX0mrFfd+KNHWqun92KNNHzien09keUobaOhujZMhB0
ZJr+WztAXTl73OCgBfjMTkhmjOoxlT5kHTEgrfqYLwn6pHYgp5dT11VDcxW9hGI4
tUzqZkaJvSlBtaAaCZOP5JQPM/En8zCi373L76aXJ/ayvdiraAarXwXvp9aN/4lD
/hwb8gwKTWcKrdGZ36gkXhwQUUcVndnvjUme1nRMYexZ+q8KTz4Ck766A7wwUgfV
aN0S0jd7i/o4kVJYWsm9/pC6cyyUfuHyLdEBoemw3no2ti0XkpeRB5hEjfRzTgbS
dHCzjDw6
=sP3v
-----END PGP SIGNATURE-----

--BGkaIGsKFTNfG7Ez--
