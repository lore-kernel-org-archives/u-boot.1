Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EADC54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CB687BA8;
	Thu,  7 Mar 2024 18:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JppNFsfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBC287B77; Thu,  7 Mar 2024 18:12:58 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E0C87CFF
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6901a6dca63so8141736d6.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831575; x=1710436375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YHwIMnciPtkMfioL1OffI/sMrnjnnuZQiW2/9WAghQ0=;
 b=JppNFsfmlU9CdU/P2/AuGXk0yudwQrE5p/FC+bJqunbitGpFv9cCcynzNfqDGYh87l
 DTmL7OxUBEJMQwFhUzlQJjI7PF1fsuEKJwOGNSo1uoB42axV3DjG6KRvg3R2yc58P3Wm
 uACISLPUOKJS3H5h3S25mUW9WHpEVrAAu40iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831575; x=1710436375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHwIMnciPtkMfioL1OffI/sMrnjnnuZQiW2/9WAghQ0=;
 b=NlSa2vkrulJILVXX2fpjRwyr7rxGieHZ+5Bb4hl9ZHMof6ZJF+pe+IVJRx7BMvdI+M
 EOYLZpfTDnvMHmgqO/fuTQkMEjw1aeRuKAOCKKqs1lb/QUmsN7PohiGYnLxOU+CUkwO3
 1vg+Xmk6I3QiTVW9OuDj8KzchhV7siFS7YvJpjjNGMES+v/dYLbovrW8zxt2J2Cqc9at
 CNlE5j4YUXx5bcaXWzRappjJ5crjPYJFtcMuMsSdF4oiwOz/IiqfrQ9kKv+e6azbtU5i
 vszEpI6s6jJH2N4NY2ueOQ2aDq5bVAgyZJ4nfvUyuDqXxFg0wKaQT6bpgWAH2+YABPLg
 A3Bg==
X-Gm-Message-State: AOJu0YxSIoOm7PBWZMsAsRG2GmZ/dOC/zv8+4sxZFwZlH/oWGxj4tF3O
 S6bxrJCtpfewHvJrGB3y1meOa199qzvnyTADHPw71HK41ZowCuWi1Z7iGWlMICw=
X-Google-Smtp-Source: AGHT+IHwqcvKeABQcvTdtMBmM7Sz0S1XvEtw179/GeBOmROCKJRF/hBIFPaB4FyL5NqEeT2jiEMjig==
X-Received: by 2002:ad4:55e6:0:b0:690:9d2d:52cb with SMTP id
 bu6-20020ad455e6000000b006909d2d52cbmr71308qvb.6.1709831545529; 
 Thu, 07 Mar 2024 09:12:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 of2-20020a056214434200b0068fbc383a80sm1945048qvb.108.2024.03.07.09.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:25 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:23 -0500
From: Tom Rini <trini@konsulko.com>
To: forbidden405@outlook.com
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2] serial: pl01x: set baudrate when probing
Message-ID: <20240307171223.GM1523872@bill-the-cat>
References: <20240228-b4-pl011-v2-1-92129ba2e23a@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tgxc7D+zaegePzEx"
Content-Disposition: inline
In-Reply-To: <20240228-b4-pl011-v2-1-92129ba2e23a@outlook.com>
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


--tgxc7D+zaegePzEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 06:57:52PM +0800, Yang Xiwen via B4 Relay wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> It is found that when DM is enabled, only generic init function is
> called in .probe(). Baudrate is never honored. Add a function call
> to .setbrg() when probing so that we can update the baudrate of the
> serial device.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Applied to u-boot/next, thanks!

--=20
Tom

--tgxc7D+zaegePzEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9XcACgkQFHw5/5Y0
tyzs2wv/SlveEA0So5R/u1EOFinq3cAaRQcsQXBHisOwDp/P7J0OXVxFl/0c42Qh
wUAcc3OJ9UftrWclGVMwulBWgOB2qzFCUHAjiqH8L13gRiR3MuroxAYHUfNWRGRc
LGlsJ1lHQa2leiqbOs9O9+enhqvIQvgJbK4kd5XYXVDZWidy5621xP/AbPadJ1I3
obbNMf9zKnYsKeRDLOu3O2FuT33UbPuYPpSx1A+gzumfaVWd+mng8tLn0g5AQ+F0
dL4B4pl+mmb/H/flXguUCdJWkrdSBfAWpTfh4WC/WhQlEF8ZQJPwC/VXmIJdVtw/
Knn7bR3VGKJh+tcUjrDE8u6BlOHN8xaHImL9DGuRKbpw63o1lEZNu2JTXPmtl54i
LnOWbSPc6diywGA9+tUzfu+yUVlwdK+7AM/+uFLMNJd0RHgXMbZ4A+ad1vMk7pc9
OL57H8kDpOTEEVyf+T5ldXUuBeKpgEcM8DbUxKomTsPYBjq2aXoKGkl0POpvsMbU
joUVyUrr
=F3tq
-----END PGP SIGNATURE-----

--tgxc7D+zaegePzEx--
