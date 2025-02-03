Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB15C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD495805D7;
	Mon,  3 Feb 2025 21:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HuDlMzpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9746980079; Mon,  3 Feb 2025 21:10:36 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B99805D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8edad9932so36239146d6.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613433; x=1739218233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mGDDZKlK75tNN679zUPWyUKbWiBfV250wFh17n5x6Zc=;
 b=HuDlMzptUI5aXTtSoD5JcwFqT1sMJ9mvXm6+t2EsctDMJ7+ptVzWNlVhkgL74iph1U
 fRJlnTgyjNE1GDs58CT/ito8QiANURZNp/wfgDKxzVxkYXfgaEUDD4yGbTTHNcmKsmz9
 mZJVjufXUy7sLYQ8oyTENbNljslONkPpW0ahc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613433; x=1739218233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGDDZKlK75tNN679zUPWyUKbWiBfV250wFh17n5x6Zc=;
 b=nJWNC/xk/Rpca0icnBcPrsFGO9QIOAFpV/h2QD3L/YViyEruhDJ9U3bZF7bXT5FvLr
 6+V2OFnjWHF1OzfK5dZG4lsvUA0Bu32GOXh6dxlkM42TC0m/O33633fzW1zypqoBa/ag
 56xGQolSIAW60RPICNkzPahLqDcAoIfi6v1KY44xlt7qbPj3fQjuk89Xmx598bXOrOwD
 n9XGiSgbqOLkietJyot0ok7D3GlUEGzUM0qPN+sBrp8BPoHUY8P4IexSNKKnBmObwcbc
 5kE3d5DUFq5ckRv7ntGf2wEVDBiRvBalqtqw9yPzu4e6MDp/flUgZue5q4JXh3KxuvZG
 p49w==
X-Gm-Message-State: AOJu0YzFqGyLA2RN38cK4Bq92iDN4CfKJsrUab3Amz8IYznkPE2wq5En
 N1lhwFAr9PC7PS9Vyuu/1lX8CtBF/VmJCckhUSAwns+d1Cdng9CTZZfPbFG7vpM=
X-Gm-Gg: ASbGnctiMCPQ1Qt/bUPgVjd7E1g/2OZLt8jLZLKYNZIo6E1FWVNkwC5Hrnv6vxvwMav
 2FEz4VvCE9MiQzt4Ks+DV+qUn243yvFfUEY1AbNA1suJBvimj80celeytSgGzFoTPQCTdPn6fHN
 /xpy6PkbWK96llWRhdn8fHYZb6a20zZmCd92+DptWCE/gquocfVmRXB/i4260ZCxy3iqAZUuTsY
 QUgVyHYlvcTceHcqb0sffFQOCWR8DDUblGefk6H/iHqGJbltvna+j+wcQpXE9TYgAGMkfTflMAQ
 D/5w3PFbiTLC87E=
X-Google-Smtp-Source: AGHT+IF+bA2CPSt1USlNmKXs7cLmtFGvfcspiOWj6nZgciy/7E5yl7kuu55J2ZDB45lq3JslrVYcNw==
X-Received: by 2002:a05:6214:623:b0:6d8:7db7:1f2e with SMTP id
 6a1803df08f44-6e243bb87b5mr299810796d6.14.1738613433270; 
 Mon, 03 Feb 2025 12:10:33 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254922a85sm53926656d6.81.2025.02.03.12.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:32 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 30/32] efi: arm: Use EFI flags for all compilation with
 the app
Message-ID: <20250203201029.GS1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-31-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F4IRzEF5M9C2zO2j"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-31-sjg@chromium.org>
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


--F4IRzEF5M9C2zO2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:23AM -0700, Simon Glass wrote:

> As opposed to the payload, which is built normally with just an EFI
> stub, the app is build homogenously using EFI flags. Update
> PLATFORM_CPPFLAGS to enable this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/arm/cpu/armv8/config.mk | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
> index d2d1a8d2bc2..cf0b89819d5 100644
> --- a/arch/arm/cpu/armv8/config.mk
> +++ b/arch/arm/cpu/armv8/config.mk
> @@ -23,5 +23,6 @@ CPPFLAGS_REMOVE_crt0-efi-aarch64.o +=3D $(CFLAGS_NON_EF=
I)
>  CPPFLAGS_crt0-efi-aarch64.o +=3D $(CFLAGS_EFI)
> =20
>  ifeq ($(CONFIG_EFI_APP),y)
> +PLATFORM_CPPFLAGS +=3D $(CFLAGS_EFI)
>  LDSCRIPT :=3D $(LDSCRIPT_EFI)
>  endif

This too should be tidied up and moved somewhere common between arm and
x86.

--=20
Tom

--F4IRzEF5M9C2zO2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIrUACgkQFHw5/5Y0
tyzYlAwApaJWMyIJOwa0UVOHe0Jzb0CcqMuF6vqdLHkN35qQgHYR5BApE39qQoS6
2OQTWfpVSjFwsyunOrJqDVuDWc/OA96lH4rC94T28+DsCM5KwK3lH1S/VeL2zJop
q4+3Lv6GIgjtMfe8GOTmCvuozErh1IqN9E3uT/YWeGD49onmtoQ4yjWx6exfEMsY
U1rk1PSss1S2alLOzSJMvYgI+PLPyyJ/+Hq8mKOu2UkwGGCax9ofyLrZLWGolOUe
pwlSc3dfZOtQSeW6PYQ6Ka/otVsiiwaygC5AH9jY4AW6vwE9zwgUKkGX1onoDMDy
mEL5ih2oiI3abPBBiqqDcH0Eo5TJoEqUGpjwl9ihzm89FYrFouoQRdHDlgXwO4Dv
0bKxn80JUq5Aw9f3Dj+xDictWudICStFF9IUd/C82oPkq4vfG3nCU50hiyWteHAg
s4yn7iWMJUgxM86fxKoNxDhx465miMbEfv30pws3sBVURHY4pph174+IILoGGyw9
NQVBj3Ma
=gLts
-----END PGP SIGNATURE-----

--F4IRzEF5M9C2zO2j--
