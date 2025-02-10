Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E40C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A90807B1;
	Mon, 10 Feb 2025 16:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cIhCJw20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1239B807D6; Mon, 10 Feb 2025 16:52:05 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFFF80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5b3391b033so3474788276.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739202721; x=1739807521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aQMs2ikbpyMnwPmLhTyD263Eyjs2bFGuqzQSY8zzsi0=;
 b=cIhCJw200HyN69E1IOlaGIZsG1leL4jb7hEGw5RtoMkeeWM0Byio/PBNqlaFfG2Y86
 FXuZpDKj8cvdFLinNAbIXnC1vxiN20+w6fPqW0q8NqjXVnAse8M4+JH1+Hvyp278adkO
 /F/GugTfoykQ45vGjujeD9pZYk/CNOe5OBAQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202721; x=1739807521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQMs2ikbpyMnwPmLhTyD263Eyjs2bFGuqzQSY8zzsi0=;
 b=FxYPEBfb+xqRV5mFnGUwGshT/IuS9+FWe3FoYivzBgpz2+1S4DdaqrjS/LPE29CWq3
 wih4+gzzWsuvcN8sNOTWC9bXIMHgNImyDv35L42cHGoqSLMuPtepw4QVCGN0uVcoLD1F
 Q9YIogGRmAQ9PGTyfwKsVZq3vlzoDWBNrlAfoi33s7a+nB7C5zTPfRRXwzrUwsmbMjmS
 y33Bu/Zp2qtbR4PfOayTvgEzvr329+4m0a0GqbFfoWczVRMXwebwuh+fIun/yDS2Aaa4
 walRCsREomxRJjnVEYGlvWvAxmf6EsmfX1jdd1SWQRuZfh1gYmuTH+tsymDYSC31ryip
 1zsA==
X-Gm-Message-State: AOJu0YwXNDUgYkeDZERr7Tu6zc7E4xSUzfJXbspO/isf2Qq024noJJIR
 k79a+bavw2Y5Xx+UI9SgYJG3TOTOxn7gusUzP8sYTgko2TV8arKA9m6XW+fFnKY=
X-Gm-Gg: ASbGncvndnTsFW4sij3Ka6NjdnqTBv/L80O9IQ47qqGTzujDZAIl2Ot80SScnxX+gaj
 IP32gWJc7jxoOZ5NJFC9lHOlroTjHFGNrghT8qgvTCsMLN9IvNTJMPk6vAHokwk/iVFBvMTC7Mu
 /fViimEF+hZJpuQXHcL+r/NNWmLhMtlFHvqbvC0AZzYRdMU05D60i3k8h8cPuC7NAy/t03z2DIX
 0Icbba0sxGQvqDkxOHfyftlyWtql7nVEwIW3c7RhSCtDjZReO2lF/Hg1wEIvZpuVgpBaeTiUWTF
 5jo+yz07/MTPZRo=
X-Google-Smtp-Source: AGHT+IGzOfFaS8zkmPDSe8RauM0dlxUjMOFsxO1VUlo/CRfpO4pUElr+wubpI0h4XWCFyskqwdqXDA==
X-Received: by 2002:a05:6902:2009:b0:e5b:1c0a:6cac with SMTP id
 3f1490d57ef6-e5b4625401fmr12218697276.38.1739202721426; 
 Mon, 10 Feb 2025 07:52:01 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a0f5353sm2643917276.0.2025.02.10.07.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:52:00 -0800 (PST)
Date: Mon, 10 Feb 2025 09:51:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Arnaud Patard <arnaud.patard@collabora.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] drivers/Makefile: Fix TPL build with dwc3 generic
Message-ID: <20250210155158.GH1233568@bill-the-cat>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
 <01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vQuL7hMmyM5ncYjq"
Content-Disposition: inline
In-Reply-To: <01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2ebaafe-000000@eu-west-1.amazonses.com>
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


--vQuL7hMmyM5ncYjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 03:29:58PM +0000, Arnaud Patard wrote:
> When building TPL with DWC3 generic enabled, the following error is
> occuring:
> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `d=
wc3_glue_bind_common':
> .../drivers/usb/dwc3/dwc3-generic.c:527: undefined reference to `usb_get_=
dr_mode'
> .../drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue_bind_common+0x20=
): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `=
usb_get_dr_mode'
> aarch64-linux-gnu-ld.bfd: .../drivers/usb/dwc3/dwc3-generic.c:529: undefi=
ned reference to `usb_get_dr_mode'
> .../drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue_bind_common+0x2c=
): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `=
usb_get_dr_mode'
> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `d=
wc3_glue_probe':
> .../drivers/usb/dwc3/dwc3-generic.c:683: undefined reference to `usb_get_=
dr_mode'
> .../drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue_probe+0xb0): rel=
ocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `usb_ge=
t_dr_mode'
> make[1]: *** [scripts/Makefile.xpl:544: tpl/u-boot-tpl] Error 1
> make: *** [Makefile:2137: tpl/u-boot-tpl] Error 2
>=20
> Enable building drivers/usb/common.c in TPL.
>=20
> Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
> ---
>  drivers/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 0e1f58c515b..7cee5750396 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -78,6 +78,7 @@ endif
>  ifdef CONFIG_TPL_BUILD
> =20
>  obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) +=3D ddr/fsl/
> +obj-$(CONFIG_USB_GADGET) +=3D usb/common/
> =20
>  endif

Do we really need DWC3 in TPL?

--=20
Tom

--vQuL7hMmyM5ncYjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqIJoACgkQFHw5/5Y0
tyxcmQv/ZR41eDm/Whk9oFs08VtYzn9dutoWF4Ogb/TD8l+6/un7bEu2owkPe2Gv
2MfO3q2v7m6HWspbiwXAL0X6a6LzaV6SMhkoxZ/zXDEjmPQIJXm2T6h3vuNfqePX
e/a0Qggch2DpfP1bBneQDX9YqsElsfaPXbHTsY7H8LcZTlr5lKT+R6IRlrPqKj8R
T+erBzG+KtWitz+X+46QkktEBaSAq+pRo53btokFed++fD6d/4CpnmrobGmBqWTF
EKF8hEgL6T2viV27T3J/jRceEwWVcTSgeuj/OKB93UPNa/3JPcb3PL9378z9zbBq
NhZ0bkQeWGJKNJZoSe+M4mrq0tnBl7C+/ukjsdj+wImeu46LsLmen1S7Xup+UQv2
zV8LnTRJm0rtnoVj76YOmSyh8LKnd3ac9OZoRn17DND4YHmUtusLqHfG052eIVeV
QVktzUybd2+VE4N0/8kBu8ZslM9mAPepJIRXdjv1MRkXzZPxAYHC2gJT57/K9qrE
A2ogyy9U
=t4JH
-----END PGP SIGNATURE-----

--vQuL7hMmyM5ncYjq--
