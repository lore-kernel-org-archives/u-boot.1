Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F07C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DCD864CE;
	Wed, 23 Aug 2023 20:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KaDUQ9Mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F0586451; Wed, 23 Aug 2023 20:15:47 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC56E8647B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58c92a2c52dso64038717b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692814543; x=1693419343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bW4Pzyi1GwYUnObZTDp66h/IowrguUAversKGLfilj0=;
 b=KaDUQ9MzmQsBM2pbi8Hu7HiRsdqnq7KVMsEuOyVR91rQOLoQu9GnX+tVYF2HaqCpMi
 wCft06Ny1i/ar5M3zlqxYKU40Oe6dfqmE4wYVrN4quiDHwKQEsw62ZH3oSsK4B+iooTE
 aJMymv5tTRl9UBwG9lNBecgXgxUZ6i/rObReY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692814543; x=1693419343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bW4Pzyi1GwYUnObZTDp66h/IowrguUAversKGLfilj0=;
 b=YCalvpO4o2mwiLAOszU0sDG0c6KO0NCJezWmoGmTcpZblzLigVjGWnMKWddwJNvy2G
 e/C9JkuApzoltdJqJXCUPObitsIlJPajMzm7R08yDfquORus97iqrbmE06TIRyBOS7Ou
 2PPwKLKSCyInHs3m6nWX3iTdkpEuTen/kXG+kG8iKmsBFVABtVk7nnkiaRHUzCrXO455
 21Izq6l+0vHXy4IDv1H8g32o59JazaQapKucMFxKKGFTj7SIVjAxlsMNvzAER/V/WeMp
 s/uFthEJLhICoiGcDc/9A40+OLEPpytg3tcmS2ru1FpX4owZwVU0WBtAkZWW2QW5TDzr
 QQYA==
X-Gm-Message-State: AOJu0YyFEojpomL7P7b8njvjrhmDU1oB6odksKr4bakazzluJtXBUAtR
 5ZU/iqeBsJxx8yIrXmig0paqvw==
X-Google-Smtp-Source: AGHT+IHOleP5r5uZfqh1TLFauuqWOMcSWHVWdbqdSDOoGLC95KSY1HMPtru6uVZCz/wL1nIGxnBHiA==
X-Received: by 2002:a0d:d145:0:b0:581:5cb9:6c2b with SMTP id
 t66-20020a0dd145000000b005815cb96c2bmr12497365ywd.45.1692814543643; 
 Wed, 23 Aug 2023 11:15:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a0dc701000000b0058ddb62f99bsm3516121ywd.38.2023.08.23.11.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:15:43 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:15:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/8] doc: Add gpt command documentation
Message-ID: <20230823181541.GA3953269@bill-the-cat>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-3-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cRclv/BoCz07UjvR"
Content-Disposition: inline
In-Reply-To: <20230823164755.2874792-3-JPEWhacker@gmail.com>
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


--cRclv/BoCz07UjvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:47:38AM -0600, Joshua Watt wrote:

> Adds initial documentation for the gpt command
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  doc/usage/cmd/gpt.rst | 139 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 doc/usage/cmd/gpt.rst

You need to update the index too so it's included (and doesn't trigger
an error about orphan files).  Please do a 'make htmldocs' to make sure
everything else is clean, thanks.

--=20
Tom

--cRclv/BoCz07UjvR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmTM0ACgkQFHw5/5Y0
tywYbgwAmBPfQ++OHfb3GTQP2qKdenexjYU7o5H9KIsH8wJ1/1fpv51dr6ZV+FG2
HwhCAWXl14h1t0PyhyL1OmoAtxO31ORhp4wMO0KJIJgv3+z7N2VyLMnsJVsmmvZm
Q+UMTvV8ePCqkmfJrdfHNfVxCho4W0CrNDEY52hiO8XaE3K1lyxUfisebaGWBmIN
TIIXlrmBRUpUNr+v1N8nFNc4ZbUOJFtk+4t2OxwRWyqzcd+AI745Bz0srdnHwMcf
RNOUB1wMsAOwr9kQkUpiYhCh4bPXWegPi48DqXEO3wXXhecXrIyfqsBgTYUfysx5
XmvcbTPl3X/yITNxv+UMHW+Fb47AdgrXzgZ26SJt8FhJ0thRRYQX1lEzW7Kh8inW
sSBolJIpWQXEvjwWgQTCNW3EE9Xt4qUd3wYLdczi/QFXXKM/Q1vdzKVW7xRX7iFa
QVCApdVW7AvHbTccCtTbdlJ9/x5ekGs0DB8lpRpdgos7qJFhfM+8/NBVZ3vAYD3s
1EQ6Vb65
=Roht
-----END PGP SIGNATURE-----

--cRclv/BoCz07UjvR--
