Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDD3C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57DE38805B;
	Mon,  4 Mar 2024 16:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LY0o5TDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D124C88076; Mon,  4 Mar 2024 16:28:37 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99AC88035
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-609408d4b31so44827457b3.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566114; x=1710170914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=duA7W3D33o8WMISGJKUybjbZcFswLBitfBEOYKPA9dQ=;
 b=LY0o5TDIMTp3YGwSkpxZaqmlGCoWUVbx6ysNKlfffdX3rt7dn6X9DUI4Py+nR9SEAW
 B+V6Jvm/F+A2oTsB59rQnB1GyhewMZ4uggg9vMPBUy+ofmiDg25SC00vZSIpWlpOGDhG
 nD+Nwh85pb7BxDeu/V9RNLsAz5gUV99rfJmm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566114; x=1710170914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duA7W3D33o8WMISGJKUybjbZcFswLBitfBEOYKPA9dQ=;
 b=w0/zbtF90LxhArageebqjJXYhxGgtAf+STznOykNfaDjHq7sWK7ZRe4PFvY+40Qz5c
 iEycyBk78SBfKnfw5+zL6bdOoTdIdwlhXwjqBzI84Nz3EohsoatnpfExc7B4GAfUZwhn
 S+VKhJeRO2itn358RY3I0GMSfDt78Is3E8tB32QeGL41rHGi0d65YxPihYDUho0a3EPG
 3spuyShUbPBtA/aHYtSThKZAFN2RdxTREAZnDt9MiUVp1ZOZT5VyXE6l5wPTb8Q1eSSh
 jaHif+lVShMyZUCgyQXjFoAY4LxVXSro47XYX2C49o6mr+Dh1bKuEWIUpOMDXIvG6qkd
 MmxA==
X-Gm-Message-State: AOJu0YzevmpUk/DyMWaxTRpCgRMpBd5yU5lotggYZtka1uV7V3r1YTB8
 XIr0WygjVi2vvezI/be4UDzTVsREM7J9bI6xYnRpuvywccFBTeSi2k026WiI7qk=
X-Google-Smtp-Source: AGHT+IGpEm83xawRxMZqH4cp0NuX3Uynx5OI6+Z6XfuyQRLJULBj/XcdQSKMV45qMDjfgM07WUQ4Dw==
X-Received: by 2002:a81:7343:0:b0:607:f50f:3770 with SMTP id
 o64-20020a817343000000b00607f50f3770mr9366505ywc.41.1709566114545; 
 Mon, 04 Mar 2024 07:28:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 r25-20020ac867d9000000b0042e43880355sm4488834qtp.14.2024.03.04.07.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:34 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] FWU: developerbox: read boot index from NOR flash
Message-ID: <20240304152832.GD1523872@bill-the-cat>
References: <20240208023345.1601269-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OOEwHxMO4vCtwBRQ"
Content-Disposition: inline
In-Reply-To: <20240208023345.1601269-1-masahisa.kojima@linaro.org>
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


--OOEwHxMO4vCtwBRQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 11:33:44AM +0900, Masahisa Kojima wrote:

> The FWU Multi Bank Update feature allows the platform to boot the
> firmware images from one of the partitions(banks).
> On the Developerbox, SCP-firmware running on the SCB(Cortex-M3)
> passes the value of the boot index on the NOR flash.
> Add a function to read the boot index value from the NOR flash.
>=20
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--OOEwHxMO4vCtwBRQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6KAACgkQFHw5/5Y0
tyy2CwwAsaSrgmEnWqj8B52xl2qXBFxg0AGlUgNpmzd+dco0nWVbHVoswpbIBU9f
dZYFz9HaGunYQwHLB7r5x7zzqs8DXK5KwKHlqaF+VXCamPzKmHP/qcjayqhzQSTm
M9MRNW5mDYHUjqDe3io3i9ToR/WcgOADvgZpnV7coZzWRNOTLBbW8b9lXrKQdjgw
3DHtj1ga57kIxA9XreMcYtq0UOfne9gC0VCjIRwo4JVOieKa90r2azYWLI7rlvGq
jaY/KF2nAxWD6n64awDAhJJ1i/c1J4c6kwt1DBtqzk1iqBDnodankXsKyjKq3eL8
zmY4AwiD+HfYnKMX/XOfQrdaM3DitnDDPDR77+KxjhRZwlMFPwHEyjD2ar0GOOa/
PXDeHSczdND1qDXa0r63lMJGMGDujQOZGU+kxPhTJE/gmlWNcqweq3uywOnL8vdN
z61SfAaUPtRQ3Kc5c4MsK0CXb0cK1YihzT2nfZt9hqps1XvRnd+2kfEbsC7TI/uS
Zq7AM0Mg
=pF7f
-----END PGP SIGNATURE-----

--OOEwHxMO4vCtwBRQ--
