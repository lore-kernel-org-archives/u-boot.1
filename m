Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C242EE020F
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 22:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6273586F63;
	Thu, 14 Sep 2023 00:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cga5htBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECD586F99; Thu, 14 Sep 2023 00:04:26 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF6B86F58
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 00:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7ecdb99b7aso322125276.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694642661; x=1695247461; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EMmNj+82gt8Y1jnJB49M3Bj7MBJykmSatbA/77HvUk4=;
 b=Cga5htBxSNunc0Ml7riQDWbPbF3/Khmq85ZScZc8aE9ar/VfjGhFz9ps9OPKkUfuRe
 h2lOGGEkLvs3g6bTgOfXiGPLXgMQMJi0w0qt9kpPfN0LFm9bkG/IYGxaZ45MkAoBez7d
 JYIcD5YMGGszYkMs1DwKbHGEsWbYC9BWIxj/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642661; x=1695247461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMmNj+82gt8Y1jnJB49M3Bj7MBJykmSatbA/77HvUk4=;
 b=fThWu899R2T8sESk8G9zYml3IpEDc+zpA5mK06fmQfmCOtN7zHYNd3dxPK+MH8nmUr
 vXMem7oS/18wdULBUcEV8CypxnFpuqJOEnbiHfBelPr+XBCwz3mej46W6R+HOg37hcY6
 SZ3UWHYlfwYGGOyh15UJ8qIuKJ95i24egu7zJkqCDeVM26cvkoVwS6Qs2e4uirhZgdRz
 ARhhScqdOTqIqMOoQKAe6VJS40zypQEJdMqRBLNT8+3CncqikdoV78BzFfpLjQgXuNni
 9UyBadI2P6dMBq8BFM8QyAaHSSIBPWkuPJAXooXMikNdQCb9bDCyPvvtC4zYxUdFL+oN
 cWaA==
X-Gm-Message-State: AOJu0YyQEGW20kaSI/ZHl2RBwkTnuJB1Lez81QYi3dpxKC0wv/zSmIb+
 hbVmH0z0SeEmzCbJi2o7GTIgTg==
X-Google-Smtp-Source: AGHT+IGm+S2ypWmmI58Q+h9TwDVSEJ5RF4vL1yJqk5CDeCZ7lFN93PNrSYPkyBhuOa1zN/NJ7cuIQQ==
X-Received: by 2002:a5b:481:0:b0:d42:42f8:93c2 with SMTP id
 n1-20020a5b0481000000b00d4242f893c2mr3361901ybp.16.1694642661352; 
 Wed, 13 Sep 2023 15:04:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a25ac47000000b00d217e46d25csm49772ybd.4.2023.09.13.15.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:20 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:04:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] phy: Return success from generic_setup_phy() when
 phy is not found
Message-ID: <20230913220419.GW305624@bill-the-cat>
References: <20230831230705.1040105-1-jonas@kwiboo.se>
 <20230831230705.1040105-3-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0v7JmK+L0jCxDtQl"
Content-Disposition: inline
In-Reply-To: <20230831230705.1040105-3-jonas@kwiboo.se>
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


--0v7JmK+L0jCxDtQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 11:07:10PM +0000, Jonas Karlman wrote:

> Restore the old behavior of ehci_setup_phy() and ohci_setup_phy() to
> return success when generic_phy_get_by_index() return -ENOENT.
>=20
> Fixes: 84e561407a5f ("phy: Add generic_{setup,shutdown}_phy() helpers")
> Fixes: 10005004db73 ("usb: ohci: Make usage of generic_{setup,shutdown}_p=
hy() helpers")
> Fixes: 083f8aa978a8 ("usb: ehci: Make usage of generic_{setup,shutdown}_p=
hy() helpers")
> Fixes: 75341e9c16aa ("usb: ehci: Remove unused ehci_{setup,shutdown}_phy(=
) helpers")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied to u-boot/next, thanks!

--=20
Tom

--0v7JmK+L0jCxDtQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCMeMACgkQFHw5/5Y0
tyzgowv/VjipIAYx4M+NOe89kNLwmiskBABr8KMZ4X5+OVZLEV2zCV1FqV/nGD+a
GRew/mtFZhbeYTDXdG9M3Q3lnEgTOif9s3HUJcLXuF/n8vx0F1kozW5kGG/rKFed
576Qq0SIK/SxHnqtlEzGrBR7iskgVGQcdCFHxS0JLgmVUhRLPLWADHfhVjEA7USG
+dA31SomJZE9MXNCxMwBO6jJPqA/LMtbFy2VeA5smvkzcmovJMyC78+12AsyhS1J
IVtPNu3K9M+EgOsS46ypKeOPDvIvau5Lb7Px8LxQONtCFuiCXfUMfqRAUwXMFkzV
ocwiKb+PGipoWvfyr1Z4VsnYhmd+WONwlHOVBhxfa+YjHI/o0x2MZo+CRooJf6O9
CPiYJMGUTxo8gG26NudVB0M1sRrejIhDffSc9upU/abnVveptxvv4KyFV1t0+xpd
HPrFeysqXgSQCio9tDwkmNCdYlHkYPA0qqDU9+tLWAxLTCvwj7KuVmvVyFuQkx3t
8sq0EyEG
=v+lU
-----END PGP SIGNATURE-----

--0v7JmK+L0jCxDtQl--
