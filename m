Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2415AC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DF982B0E;
	Tue, 10 Jun 2025 16:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HE6NuBpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF07182B07; Tue, 10 Jun 2025 16:44:50 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72EBB82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 16:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-407aac76036so3508903b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749566687; x=1750171487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=62l9YHbJgRXTkT4Fq1uQ2l8yKrji1NfhMz7fVCPR608=;
 b=HE6NuBpS5wWrTu6itCHI8uf6UoRvs96tmu8rGhlAWycyniOsEbOCnG4KtcZDxFak0T
 4jKfcxwxYhr/3YZPRxCR4EeIZT/UlW717k8nko0K/S5IWEccg+0L3oO/LTH0/bMWcVbd
 u+3Iie/gT4jOxd8a1xJdG+WLexktzAuq/OK4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749566687; x=1750171487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62l9YHbJgRXTkT4Fq1uQ2l8yKrji1NfhMz7fVCPR608=;
 b=tQpTBTibCOrB3/+WbUt8hit/wePinC8zcNi6u4EosNaxzPBBVRosTcuFW5mwq1LNsD
 xp2KAuZWqcpkD7YK3SC4pm785SiXrJNi8hgrv1mQ/hdxcEscFQWTQfHiz3nABdvCPGeF
 DXgeYy2EVPd6YNrjMmxpTERI4otJqhr9hXlXOt8XJB9a5k86Defc/Bcm7biFY7y/Dhmc
 mu9ZJ4d9f8qqWs3GDbrnXV2dbotD55yUB7gU7xBqiwFRaiortBYNPNJdUDU86PZcqsPF
 gNh3U2iD/yA7aNvg8+0pqOLu82H+pO7STsuxYSzXwv1V/VlipWSZxdHnXS4Wu7qAsEjJ
 wG6Q==
X-Gm-Message-State: AOJu0YwrRwypUxHnUEklMYb68RzMKpguNAdV0hjZPXljE3bMGZupKoHp
 CxrXDK9uFJszrQRe8Fx3cxEBqpUQeFTB8YkV7ATs4GqFA/pJhZea7wEEC304m+x5KyQ=
X-Gm-Gg: ASbGncvgpaYoUZKqVBo66wVJ7PO+JmAS3kF80pVy5qIeZBVkVapY3nQdapUHeUNFHvq
 3xLfQ7+CRp9POIZ8BJ2ZthO2iNmCTGblQtPQAna8R8MhSgXzb9QUPRNHrKcZ8PTzF2Aj21gzdYk
 BEZZ7ctFiQWif5a4PRCvb78YroRY2i6U8VpciOtNdDhPvQ/v+Mi5Q0Esw9ABEBTgU3BpcL/ygkf
 ArPgcBc/ykoj8FX8jz+qKzN+EcReEn1ts1l5qcAZ+zECCJOgbNXiM/iTHySCUQO0j+Z79PBBqNc
 xurOXOlSqN5yFYtofVWgcGFC/cEfHZJ9BWP8smpZ/+zJ6CxzfUvSsQ7TDSM/qHAGfCF1Qd0ce6a
 YzIWPHVg4cg3kxrofcJMm20A=
X-Google-Smtp-Source: AGHT+IEfco55M6BXBOShUFfm/ZcBFiNwbo9k2zMmm1QOh96y4QIBViIHmOx6i9hFI5PBQ9Z2eFciSg==
X-Received: by 2002:a05:6808:6a98:b0:3f8:3489:d93d with SMTP id
 5614622812f47-40905136ff7mr12004885b6e.25.1749566687101; 
 Tue, 10 Jun 2025 07:44:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a54a668c9sm434563b6e.12.2025.06.10.07.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:44:46 -0700 (PDT)
Date: Tue, 10 Jun 2025 08:44:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
Message-ID: <20250610144444.GY1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
 <20250606190625.GZ1382132@bill-the-cat>
 <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
 <20250609145919.GN1382132@bill-the-cat>
 <DAIPP8VS7YQO.3PK5EYRE3D11A@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="niWqx8v8wV3ejlj1"
Content-Disposition: inline
In-Reply-To: <DAIPP8VS7YQO.3PK5EYRE3D11A@ti.com>
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


--niWqx8v8wV3ejlj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 02:01:59PM +0530, Anshul Dalal wrote:
> On Mon Jun 9, 2025 at 8:29 PM IST, Tom Rini wrote:
> > On Mon, Jun 09, 2025 at 05:38:37PM +0530, Anshul Dalal wrote:
> >> On Sat Jun 7, 2025 at 12:36 AM IST, Tom Rini wrote:
> >> > On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:
> >> >
> >> >> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
> >> >> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32=
-bit
> >> >> HS devices and can be enabled on K3 devices.
> >> >>=20
> >> >> For secure boot, the kernel with x509 headers can be packaged in a =
fit
> >> >> container (fitImage) signed with TIFS keys for authentication.
> >> >>=20
> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> >> ---
> >> >>  common/spl/Kconfig | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>=20
> >> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> >> >> index 77cf04d38ed..bc5a334a1c5 100644
> >> >> --- a/common/spl/Kconfig
> >> >> +++ b/common/spl/Kconfig
> >> >> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
> >> >> =20
> >> >>  config SPL_OS_BOOT
> >> >>  	bool "Activate Falcon Mode"
> >> >> -	depends on !TI_SECURE_DEVICE
> >> >> +	depends on !TI_SECURE_DEVICE || ARCH_K3
> >> >>  	help
> >> >>  	  Enable booting directly to an OS from SPL.
> >> >>  	  for more info read doc/README.falcon
> >> >
> >> > I wonder if overloading ARCH_K3 like this isn't a great idea. Or per=
haps
> >> > TI_SECURE_DEVICE is too generic a name. I kind of want to introduce
> >> > something that means TI Secure Boot is supported but also Falcon is
> >> > supported, and then use that as how we disable in Kconfig various
> >> > insecure options. And I assume that it's a matter of effort not
> >> > technical restrictions for supporting falcon mode on older HS parts?
> >>=20
> >> I second your opinion here, the falcon boot flow we do have in K3
> >> devices is quite different from existing platforms but still enabled by
> >> the same SPL_OS_BOOT config. Perhaps adding a config like K3_FALCON
> >> makes sense here.
> >>=20
> >> And yes, older HS *K3* parts should be able to support a similar falcon
> >> style boot flow with not much changes to the k3_falcon_prep function.
> >
> > Maybe we need a common symbol for things that are common to all TI
> > secure devices, and other symbols for K3 or AM33xx (or whatever is most
> > appropriate for that overall era of parts).
>=20
> I was thinking of adding TI_SECURE_DEVICE_(LEGACY|K3) hidden config
> symbols which TI_SECURE_DEVICE selects as below:
>=20
> config TI_SECURE_DEVICE
> 	bool "HS Device Type Support"
> 	depends on ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
> 	select TI_SECURE_DEVICE_LEGACY if ARCH_KEYSTONE || ARCH_OMAP2PLUS
> 	select TI_SECURE_DEVICE_K3 if ARCH_K3
>=20
> We can then use TI_SECURE_DEVICE_LEGACY to disable OS_BOOT for older non
> K3 platforms instead.
=20
The current tech today is the legacy tech tomorrow, so I think a better
symbol name is needed for ARCH_KEYSTONE || ARCH_OMAP2PLUS, especially
since the next question is how much do they in fact share in terms of
tooling and features. But I was also thinking that TI_SECURE_DEVICE
should be a hidden symbol too, and used for the common-if-any parts, and
so SPL_OS_BOOT would depend on !TI_SECURE_DEVICE_K2_OMAP2PLUS or
whatever.

--=20
Tom

--niWqx8v8wV3ejlj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIRNkACgkQFHw5/5Y0
tyzt+QwAiX9/3LwmCG/af9mF0v6ZmKaUlV8WdeB1ZbFQPzORo5AsXxT3O0FbmOL9
gguVb6oHhir89fZ8NebRumcjkX8qqjXik81iiZ7/mvkdYDkWXN3Wg2KUqj+0dOfp
bidMEl8niGvon2XIyEZchNFzpUNC4AVRg7T9qU6FtNXRdoqzH28eYOIQIQZUgRq/
cZKWQfRKOdPTM/8GT6kHrKfWiB46e32XCKsXxezeo1vCoEvLxQrSwxSXn9SuYs/x
LBedIpePF+ngjqLkHoUqIvslPSQKf5xRhmYqgMg294V+O3YXz8W6u7rlaIyL7p2I
toMeqr2St2jKjrKgvCELJxdpjwm/52cz8VL7sWnyEOHdzW25dEn9aGgAT2zNnXaQ
WdTUp9ySdBggdJIsa/wEL5tenrFcQdn8nTxOJsNs4NcPJ+Tr/txstvvmcLvgNXlK
w74AT2VVf+nR6daJTyx1ASA5iBXeN9Mxgar+BppLI3A8U48Uzr22vuTD3p1PNLTh
2NK5bJOV
=o4lq
-----END PGP SIGNATURE-----

--niWqx8v8wV3ejlj1--
