Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A70C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491F8885F2;
	Fri, 26 Jul 2024 16:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AkaV63jL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69BF3878ED; Fri, 26 Jul 2024 16:05:09 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8809885F2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7093705c708so962549a34.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722002705; x=1722607505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2rSUNgSjeq1Y6QMthpJibO4d0X7SgglkpC8tQOE52Ac=;
 b=AkaV63jLFR3DQHaKsfpjJ4Fzx6rradwLtgBbQTww8eLChDwR26WyMK1vkGnSeFmu9g
 ArM91DnGJHGUHo2XWkN5fFA3IRu+Q0x9NkGEWxHY9qF3sCtWp4PV29NKi+U61SLt/B97
 SqrwrSicioMNvYewmL19IM6hWQOkEQ4236W1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002705; x=1722607505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rSUNgSjeq1Y6QMthpJibO4d0X7SgglkpC8tQOE52Ac=;
 b=Lvtu7c1ySq9IrGwtZ3siTmAmNz2Svx02TdWOerUnGpzdhSKtJOhiTrpOJccQXty1Gp
 3PD/LPExpGhMvK/fBCf7GktJVsAiO33EIXtjm9ZmxzR4770XY8vPy9diP3L5KbBc//9z
 0sqKrrLDOTtpnsUnSbgusXbLwT5exZV5M/JrcrMwqshQP/2xqcE48FZtoaYA3kgM1SHn
 UfHxekpiW9vxZ1UKaVb43S7fymehBTUFUFusHpAiwOIaclBbbny4/Iqfey07M4M2K66Q
 1Xi+6mTCLaGRusTp705lh3ayCkEnU54jJLnRpFOhomqIX1UkRygENhYMu7pSR4v+hSoe
 T8QQ==
X-Gm-Message-State: AOJu0YyshN/H1zGZGASAtY1taH1I9pOfKw10xg8QaLmR6gZlisyHSRJM
 4gh38lUEU1yimwTaQ7crfXHgJQJAQhW5kgVc1tZnBhzS3nbBTSE61t4xwqiwODM=
X-Google-Smtp-Source: AGHT+IFM6J9eXPFh1YTecYqe+9gKUgkh/790Y3LguONA1LDBNaAFBK1oA+SeXlupoWjGMkrLPxaIBQ==
X-Received: by 2002:a05:6870:524:b0:254:8afa:6914 with SMTP id
 586e51a60fabf-264a0eaf1a1mr7092119fac.34.1722002705401; 
 Fri, 26 Jul 2024 07:05:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093078f877sm747143a34.75.2024.07.26.07.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:05:05 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:05:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v5 16/20] configs: add qemu_arm64_lwip_defconfig
Message-ID: <20240726140502.GI989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <dcb78f4958be3ad322168ccac6214991af44c884.1721910373.git.jerome.forissier@linaro.org>
 <20240725155806.GV989285@bill-the-cat>
 <5d3859cb-f1c5-4f43-9223-ba1ce021937f@linaro.org>
 <20240725162531.GX989285@bill-the-cat>
 <eeaa2258-83f3-47da-a8ad-c666457e1f08@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aNBnZRLSpWKBqYbD"
Content-Disposition: inline
In-Reply-To: <eeaa2258-83f3-47da-a8ad-c666457e1f08@linaro.org>
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


--aNBnZRLSpWKBqYbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 02:27:05PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 7/25/24 18:25, Tom Rini wrote:
> > On Thu, Jul 25, 2024 at 06:10:48PM +0200, Jerome Forissier wrote:
> >>
> >>
> >> On 7/25/24 17:58, Tom Rini wrote:
> >>> On Thu, Jul 25, 2024 at 02:57:37PM +0200, Jerome Forissier wrote:
> >>>
> >>>> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig =
and
> >>>> selects NET_LWIP instead of NET. This config has all the supported n=
et
> >>>> commands enabled.
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> ---
> >>>>  configs/qemu_arm64_lwip_defconfig | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>  create mode 100644 configs/qemu_arm64_lwip_defconfig
> >>>>
> >>>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_=
lwip_defconfig
> >>>> new file mode 100644
> >>>> index 00000000000..1afef04d7a0
> >>>> --- /dev/null
> >>>> +++ b/configs/qemu_arm64_lwip_defconfig
> >>>> @@ -0,0 +1,5 @@
> >>>> +#include <configs/qemu_arm64_defconfig>
> >>>> +CONFIG_NET_LWIP=3Dy
> >>>> +CONFIG_CMD_DNS=3Dy
> >>>> +CONFIG_CMD_WGET=3Dy
> >>>> +CONFIG_EFI_HTTP_BOOT=3Dy
> >>>
> >>> This doesn't work,
> >>
> >> How so? I've used "make qemu_arm64_lwip_defconfig" hundreds of time to=
 build for
> >> arm64 QEMU :o
> >=20
> > Yes, but buildman (and CI) are in a chicken-and-egg situation without a
> > few more details in the new defconfig, sadly.
>=20
> With:
>=20
> $ cat configs/qemu_arm64_lwip_defconfig
> #include <configs/qemu_arm64_defconfig>
>=20
> CONFIG_ARM=3Dy
> CONFIG_ARCH_QEMU=3Dy
>=20
> CONFIG_NET_LWIP=3Dy
> CONFIG_CMD_DNS=3Dy
> CONFIG_CMD_WGET=3Dy
> CONFIG_EFI_HTTP_BOOT=3Dy
>=20
> ...I get:
>=20
> $ make qemu_arm64_lwip_defconfig
> generated_defconfig:71:warning: override: reassigning to symbol ARM
> generated_defconfig:71:warning: override: ARM changes choice state
> generated_defconfig:72:warning: override: reassigning to symbol ARCH_QEMU
> generated_defconfig:72:warning: override: ARCH_QEMU changes choice state
> #
> # configuration written to .config
> #
>=20
> It is OK?

Yes, that's fine. Thanks.

--=20
Tom

--aNBnZRLSpWKBqYbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmajrQ4ACgkQFHw5/5Y0
tyydpQwAqTeNYpD/qgr9dYtt010wVnHunKeblrPrFzgbigQ6+jjjEpVwGur1Jek4
MAcU8RGn8jjQa9/E3UZPfTF+PH0hvVZRFdIDiD5YQSrb79BTQsT11BOPCtp9BF1a
Fng5jYaMoo8vUE2K926tXlfFKHiBbWU6jElXpHsBfrurMK9s3s13OrGG+UI+nODo
9ilA+1GDo53Y+KrnqE7kNClCDS/frxDSqvW16XwM2tFLAoZU72mTed2z4nxwBQ2v
5EmX5EufZXnp+aQ2s13E8Vu/LQesPoRsIpSJhwi01c7D0kefqe8/rhW7EsWmM7+S
OjAGEFfA+wrEZpLYNNRgY9LhdbUGoggCLhyz52bMlRslxRkWSLpNnDl6tKa17M7C
tOvxXeyJM6S+IiofmnzOci87W+hM2oIF/S+fVe3UwDFT+PFSed9UCfaqDoqTFfxq
Ex/Di/ntQFR7eArm5ZJFH86HloMu/zO7o7+rQ34nhioUyvGxdKN26JF/GfJSiKsS
emz+kDzx
=6ZeN
-----END PGP SIGNATURE-----

--aNBnZRLSpWKBqYbD--
