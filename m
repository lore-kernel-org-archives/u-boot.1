Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC86CE7A86
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8547986B5D;
	Sat, 23 Sep 2023 00:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rzot9LA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C510686B5E; Sat, 23 Sep 2023 00:27:04 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83803864D4
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59be6605e1dso35741017b3.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695421621; x=1696026421; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lyMIvJe+K52yuI8ehNOCxNopR+jtp5yQNiI6BtUuIkc=;
 b=rzot9LA23fp05KYslEbSNOXJbdhnqUv9atgmBN32Ux806+Akf6IjaIursSypiDUSSX
 gxFLNrvRWkCg3kjNA9mP/JwWbqXkQS0ZsgeVBva2qAJ1h9eB+b/P3TBrqF3UQUXQORSy
 N+EworHdSW4ANgRd8WXYP6eN2FPvafP2/P9as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695421621; x=1696026421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyMIvJe+K52yuI8ehNOCxNopR+jtp5yQNiI6BtUuIkc=;
 b=c19fjilMAJizthyeyIokWkym1YHBSpQ5G9so1mjcPKR7AdwRrhr8JwF3XM5hFrWE2I
 DbbwpCUs1cMFJKOi+HukZAbHEZZFz7j1TixZXXIgB2S9dJpqgKfK6XLCJszlXefBSTlI
 ms6JVjP6RWt4ems1f0CO9V6tFGV+4Fk18vlM3HWaHnlhhdLg25QucOxonpJbXNiK8M1U
 m33NcAjuHKC6+nv8TzcnbPJ8jXKqPAC6RUJ5s9d/93oZviUg7dCacUxCMFkaZLwpDwQn
 gJ5yDRssHTIWwRADVPZFdrdaTbsV3JOSpKceiqv3yiJ7o6yptuB5COtOjevLWPoh425B
 rYSg==
X-Gm-Message-State: AOJu0YwQ4qiJL3kQSJ131GJNCWcC3KrBNizCWb2DGhlAO/uuYbZAoDVs
 VqygqHKEQ+iyWjlUn1mf344iOQ==
X-Google-Smtp-Source: AGHT+IFSmu48hQsZhIPEXU0zGfj+V5WLDFHf6bobvq3fU4SRZJnrNGN3n5f3y425jzHyY9uMZIRiZQ==
X-Received: by 2002:a81:8356:0:b0:570:77b3:1c78 with SMTP id
 t83-20020a818356000000b0057077b31c78mr990328ywf.25.1695421620686; 
 Fri, 22 Sep 2023 15:27:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c83a-32d9-8f81-ed72.res6.spectrum.com.
 [2603:6081:7b00:6400:c83a:32d9:8f81:ed72])
 by smtp.gmail.com with ESMTPSA id
 j72-20020a81924b000000b00594fff48796sm1117306ywg.75.2023.09.22.15.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 15:27:00 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:26:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: u-boot@lists.denx.de, Dai Okamura <okamura.dai@socionext.com>
Subject: Re: [PATCH] MAINTAINERS: Step up as maintainers of UniPhier SoC
 platform
Message-ID: <20230922222658.GJ305624@bill-the-cat>
References: <20230922085409.1880176-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gt+kpellDIrKPKDS"
Content-Disposition: inline
In-Reply-To: <20230922085409.1880176-1-hayashi.kunihiko@socionext.com>
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


--Gt+kpellDIrKPKDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 05:54:09PM +0900, Kunihiko Hayashi wrote:

> Update maintainers for UniPhier SoC platform.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied to u-boot/master, thanks!

--=20
Tom

--Gt+kpellDIrKPKDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUOFLIACgkQFHw5/5Y0
tyyQjAwAoku2AmJNK93NYgZAW9DAuBpzAlVfBZkeOxkRn99DkpOOI2LVTL7g3rTm
4iJ6/TocR0Zi5N1RiMAslfW2NF3qPqGOS5JswRI9m9zqLtQl2Swr2/jNBRnobvV8
2D45TBDvEMp8sHhrejFUSsiZiuDEfM+pEOzJkjRUwU95mbjGvUwVwaUUPL414bFH
3KmCLeNLwXxwZooqOVCyxRhXc4dgRktMBuVc8blxhLd9OI/4bpWd7JSCLY7Nqd1k
XXo0JYdTcwhKOiLJQicxeeXHgwO8Juo1tS9oqY/4y/TDYGkDD8meEZUdTcCBfJev
SUL3/DPC/I1WS8QAYu+q6FRV7mOvAKbHdTzabyNvpegBHTH1Ns06Nzgj37t5ufB/
Oca9zT8TD1y9AMI+wbZPWAfjDslJR5IcRUVtud01iHHu/TVK5D9qxZ3hkfZqXNR/
FInKz2zEMGa/rmLJl+2iwf3Bwm4Amiy4A0lco3ZWLGxnu+SOEXMGwQsO9xtqFhhs
BKZ/KRa7
=A0oy
-----END PGP SIGNATURE-----

--Gt+kpellDIrKPKDS--
