Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485E6C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB95287B30;
	Thu, 14 Dec 2023 18:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XAwhfH5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6489287B43; Thu, 14 Dec 2023 18:51:47 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDE887B25
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e2eccf46ddso7794977b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576304; x=1703181104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nuirs7KxT86U04Q1c0IBMZ4dwn7ukEZHbu85OBavsXs=;
 b=XAwhfH5U865pLXb7ZtYD2EhFUXzRJh1Vuv8Ej7oHRxK6UUR6OixqHehKuA/iNojnGX
 DKZfIGJWWY7LwrO5DLtRwOQ80QkBzrX+iq7AzJxGesxZi5q6hQjQ8A0pJdWHSmheLyW5
 EMj84xuzFno7dKaVBQjSt6y/Ef61PE84osSbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576304; x=1703181104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nuirs7KxT86U04Q1c0IBMZ4dwn7ukEZHbu85OBavsXs=;
 b=AdZVYY3X9wRDLAwfpaOgPArA0mnjO09nR9vykHdAp/RB2wOzWK3EVO0f9CmU5UHINC
 PBldnE+RFCqGQ+KBiEal73YS+tAa7NP5qmU7Qiz1j9L9Ti0EbWE0NKI+B/N3J8GMB+Yg
 svcdoHYaA/BdtXGrQy+BhrhziGgAru0FdGXuTpQe/vu6ML0DfqmnlJo7ajJq4bfM4jpG
 JaAP6SzajFy9cwyPhBT50ApzUHjpHsyycMuDVAephOBaz+qg3O7OohZ88wztbdf/6MxB
 jxY4awT4d3LiWJWuPBLBa07uRzQ3IXuNgtK6oBaZtvDF8Uwo4uNEyNKcfxmaDPvoJhhh
 /7Eg==
X-Gm-Message-State: AOJu0Yyw3G075mi5i10i4nXQeIUEWI+XOBuQMeS/clVZaxjI0nhr7ZIc
 QE5a8mxwhqmCT8pzB8N4eFxKOA==
X-Google-Smtp-Source: AGHT+IHZAlTzakDBdSBF1S8w4bSScDTRUxSLSPLhUJ6O6RaJN0aPNGMhGc/XFr+eyJyHZaorN+R+GA==
X-Received: by 2002:a81:6c45:0:b0:5e2:26eb:969d with SMTP id
 h66-20020a816c45000000b005e226eb969dmr3322849ywc.42.1702576303849; 
 Thu, 14 Dec 2023 09:51:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a816909000000b005dd004432a3sm5677427ywc.137.2023.12.14.09.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:43 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 16/21] bootm: Tidy up boot_selected_os()
Message-ID: <20231214175141.GK2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-12-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KbOdPI/9hlrUTJgM"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-12-sjg@chromium.org>
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


--KbOdPI/9hlrUTJgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:25AM -0700, Simon Glass wrote:

> Use struct bootm_info with this function, to avoiding needing to
> create a new one.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--KbOdPI/9hlrUTJgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QK0ACgkQFHw5/5Y0
tyxhHgv+IbhbWr/rkFSKOXToO9rVNiZ5yE44O90OtMId/ZD4MOTUpTh7Po774UnS
F1gw2YwyAdw25Pkhm/DK6vsfRzYkHav1f9Q+tIsA/FD+2e1HwDdOm02Jvxp8brQw
1ytY8B/RhiyKus/G5XLW2klQWG3jNM8+Ta8Tg/IPgti+/1XRHEZ8TjfBUs73uz74
73xoHN42+MpTOmDIHmPzzh4eXR5xzh883lgY7fwe3G+a4AcIsPDwvpDnKvt7V/zq
z+lRGWQWNT76aX7uW1wmQESFXK0k497wWbXArqG/5dpMICuXz9RlriClaWBe8PPn
ZP+LFlxlAmQnEGHD0iCTYJb0qfLrs6XCSLotvuJXsrBCCwcY9cQdOfmu+VtsB69O
xjuEvu22py3ciGqEHGuPyuOBmJj8qWCdXSuAyTutJ/qx5JsiGr8dJjDPZYL5z0x9
K6THi7A8mn5cXe7fCEpuVfSIgBKNJ00LQDiUhU7Iqy76Et0Zs6GEEwDomrKIgEhE
m8jE14YB
=5qfE
-----END PGP SIGNATURE-----

--KbOdPI/9hlrUTJgM--
