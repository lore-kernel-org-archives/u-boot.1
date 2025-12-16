Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BC2D5E36F
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 14:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC0B839D7;
	Tue, 16 Dec 2025 15:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPMeyOI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2C583A2D; Tue, 16 Dec 2025 15:10:48 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AADE83623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 15:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so3393666a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765894245; x=1766499045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W8r+RjAY6nMfl9hwUDuJSScVEHTUwLynHbUl3wlIwjk=;
 b=BPMeyOI9BPSFOYK+bckWAjgSrhb+gEvaXGS9pKgPmzf9864XgBC+OndSYbzu3/QMes
 sRFgWOB6WGuAjDhNQha4YMKiQssXUq2kbFFxTK5HDZTI5UUh+rugjt66wCQS1JnganrA
 BB7OFxd918mILR1yPsD6wwy23SSvG0ZfRFB3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765894245; x=1766499045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8r+RjAY6nMfl9hwUDuJSScVEHTUwLynHbUl3wlIwjk=;
 b=wweZUMagoGXxD5m+3wzzyJ2zcXcl5kky9TtavNQT1/t3ryns377aZ+tQgVlNbzWr4N
 jQAH34hKDusbxOf4oExRXNtF8caC+cdJbw9bTBnN2X04eLsfOLk+vXzmFDKrVxSY4Oqw
 ZLwJbhArIBrrDp5e7pfEta8SDuPTs940Z4FzkSoIFLR0Q2gNl12+9VoY1y0H1Yydky33
 i+LWbbI8u6tRQoYFEryOxeHD7T7YPQ95w0MUY/kCA1QtgwfFwLUbSIlwUnbVxInERUUx
 1UwGv0CjfU7ool0BjUx+9LByYOOJGwsNouyrA+83EnmseDAceHdV0fmGTFDOI6z+3sxr
 rd/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEWm1MkoFReBwDJTYEXVuQ8MwagGdHd6U25RZ4AZTM0jYiCmAHilHuKIZ15RegYhLvPzs982Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwCEVzTwqyiGgG5JcOujPMlUvvABmcE/Bp3eZiqe1kXuYsyV4ka
 hTech5skODMx5IAnEGqz9QCSj6eYGD5SRUOehLIjQQaVQKmvvqgoJoIl/ZCeZwVs1vg=
X-Gm-Gg: AY/fxX5/WA1QWnyZv5xnnoAcOBr6lrSR+dA9eWeNKeWqMyOGLdjvy1613Sxt73sRR06
 +dFbIRbG6n/cqbCruR2ZxsnG/SVyNeykCNHpLPxF45Nu1LaTASyodUypWavXRjNpaXXPwsdIPKz
 PNfkVdFgW5vuO/ZVRjt2ieSUmSIVfBPntsnRYdugQJQmJ62zr38v00Fq9gtSf8fQ/jMUxlE+w47
 wqg62qHHBUVIfMuUnBURfszvAPbA9yoZcK57QgPBhPXrKYJbfFMvAVUKrLYwfkPXyvcyuVbUCah
 n9g/yDJmoCeRx/EQCY63l/Z5U5vBbWP06WkPuWOnIvSuR4OYRD7a34d19YgTv2jBSYbmV+B7wto
 wY9YfCMQOX0MkgUDAka7NHH2X1aHWeMVAo3Od1DiqR6+lXXX0RZE4GGfP9g4jmawbCqX8le3k6T
 GuikQkFP9Yj0agYqvhfrQZWtg/KKpiXVnL/+VL4uenk4WbhFtjZg==
X-Google-Smtp-Source: AGHT+IHlK3MQP0IkH8c2HSsIflEbcznaUIZbDBMm1SEF+P008ODE8jLoMB01avD8sEzJIh0hn9+Erw==
X-Received: by 2002:a05:6808:1925:b0:450:6eb0:3481 with SMTP id
 5614622812f47-455ac960d1emr5692314b6e.43.1765894244962; 
 Tue, 16 Dec 2025 06:10:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm8219609b6e.9.2025.12.16.06.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 06:10:44 -0800 (PST)
Date: Tue, 16 Dec 2025 08:10:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, afd@ti.com, nm@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
Message-ID: <20251216141042.GW303283@bill-the-cat>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <20251215163901.GS303283@bill-the-cat>
 <28abddcb-5218-4705-869f-866aee674f70@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8M4SIdk+JQB0fXMp"
Content-Disposition: inline
In-Reply-To: <28abddcb-5218-4705-869f-866aee674f70@ti.com>
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


--8M4SIdk+JQB0fXMp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 10:47:44AM +0530, Beleswar Prasad Padhi wrote:
> Hi Tom,
>=20
> On 15/12/25 22:09, Tom Rini wrote:
> > On Fri, Nov 28, 2025 at 08:34:55PM +0530, Beleswar Padhi wrote:
> >
> >> The AM571x SoC has 1 GB DDR space. As part of normal re-location proce=
ss
> >> U-Boot copies itself to the top of DDR bank. However, on HS devices, t=
he
> >> top 37 MB is used by PPA and is firewalled. This results in an excepti=
on
> >> and the boot fails.
> >>
> >> Introduce a new defconfig for AM571x HS platforms and set
> >> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
> >> as per page size for ARM32) for the same.
> >>
> >> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> >> ---
> >> Fix boot for TI AM571x HS EVM board
> >> v2: Changelog:
> >> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
> >> memory node in DT as it is done by U-Boot as part of FDT fixups
> >> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-c=
ommon.c#L72-L107
> >> 2. Add entry in MAINTAINERS for new config.
> >> 3. Update commit message to use memory size in MB than raw hex bytes
> >>
> >> Link to v1:
> >> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
> >>
> >> Test logs:
> >> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
> >>
> >>  MAINTAINERS                     | 1 +
> >>  configs/am571x_hs_evm_defconfig | 3 +++
> >>  2 files changed, 4 insertions(+)
> >>  create mode 100644 configs/am571x_hs_evm_defconfig
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index b43dae882b3..e5d564cd760 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1780,6 +1780,7 @@ F:	configs/am335x_hs_evm_spi_defconfig
> >>  F:	configs/am335x_hs_evm_uart_defconfig
> >>  F:	configs/am43xx_hs_evm_defconfig
> >>  F:	configs/am43xx_hs_evm_qspi_defconfig
> >> +F:	configs/am571x_hs_evm_defconfig
> >>  F:	configs/am57xx_hs_evm_defconfig
> >>  F:	configs/am57xx_hs_evm_usb_defconfig
> >>  F:	configs/dra7xx_hs_evm_defconfig
> >> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_d=
efconfig
> >> new file mode 100644
> >> index 00000000000..7e44ee5221a
> >> --- /dev/null
> >> +++ b/configs/am571x_hs_evm_defconfig
> >> @@ -0,0 +1,3 @@
> >> +#include <configs/am57xx_hs_evm_defconfig>
> >> +
> >> +CONFIG_SYS_MEM_TOP_HIDE=3D0x2600000
> > Sorry I missed this specific part before. Why isn't this just being
> > changed in am57xx_hs_evm_defconfig ?=20
>=20
>=20
> The firewalled DDR region and the top of DDR (for U-Boot reloc)
> intersects only for AM571x HS device as it has 1 GiB DDR. This
> does not happen for other AM57xx HS devices.
>=20
> > Do we *need* a new config here?=20
>=20
>=20
> We can have it reserved in am57xx_hs_evm_defconfig, but that would
> hide that RAM from other AM57xx devices which do not face this
> limitation. Anyways its just 38MB, so let me know if you prefer to have
> it in am57xx_hs_evm_defconfig and I will send out a revision for the
> same.

I assume that for Linux, the hole does or does not exist correctly,
depending on the platform. And if so, yes, I'd rather one defconfig for
U-Boot. Thanks!

--=20
Tom

--8M4SIdk+JQB0fXMp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUFoYQAKCRAr4qD1Cr/k
CsWfAQCCB/gej35teNFuiuf8AokTByacI0yo8Mm3iSCZ39cC6AEAvmX4GmDFjX8r
lZaa9ppOb1vmRM0grO18uH4xPiTDAAI=
=HjD4
-----END PGP SIGNATURE-----

--8M4SIdk+JQB0fXMp--
