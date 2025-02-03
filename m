Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F330C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F19F28078B;
	Mon,  3 Feb 2025 21:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="raWkAPdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D4580790; Mon,  3 Feb 2025 21:10:18 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C367E800D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6e9586b82so433940885a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613414; x=1739218214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zZ8Gh8m06AkXhGKME/XPNtOZjvvCsvRhspY2aRE58Dc=;
 b=raWkAPdMnDuphQFpPWxlyAOe0hE3l/pJh+k5cgqCena05jmSGI+Gia+fXteqbNKd95
 hxMHwo4bx3ND2IWMY6mu9p5hbuwpPBHkP3L6LMrDWkm68oRN1yN62JnIwpcSGfrsCfG3
 RpvnjUPsJlZET9bJVZvgr4ENHmJTMdxgYmgKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613414; x=1739218214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ8Gh8m06AkXhGKME/XPNtOZjvvCsvRhspY2aRE58Dc=;
 b=ccSx/FOsjgNyyKbqen4NzgG9pt1JQvjz24KH0rKlG/rzBkMmrKExTh559I7Ye+3/GJ
 zvAN54bfU6m4eyCltCGrIjstG/TH1UQ+C3tpt+jEHTYprHBg+DurnzDPCgK2+GUHwFDx
 WfWP6bkOVPZzlpp1ylXSLj/KXRi6kc+h1MvtuKPamoFcRd/tu3UnGuziUnKZhd6MrZG3
 vZbiboC1qDedrCfizOHVSk4zD+aUkmGoIBu3r1mV9vCNkJMqfTtHMs+IzdEx6wxqTYLK
 qRHFVZV8pslbzhwcapHvKYRCtbs/aef4wThniQxN6j5PuRcKpEcSU5BZu9nMZM1IdPxL
 75GQ==
X-Gm-Message-State: AOJu0YxjnikqPPa4eTecjeTXJzoDF5Mw4EmzCCX2OCzu301Bn5IAlKs5
 1lxP6mZW5QW3rUS/mV3cr2s6eeDencSGa6OFGhIcW/g2zBOnFM3Nefk40kFiTgkxKuNHro8LflQ
 P
X-Gm-Gg: ASbGncui1Tv+vYETqsuLoIvQVQ9+Dj1iiEB97LPXJA0XNbbWlc3fyNHn9l//LvKjJ/b
 pY0nQCnGO47woyTLdRoAtUSr/RSe+jZunlc6ruaP3/wEy50J/0uKXETyUHPklCnnOkFP67KaONu
 ok4he85nT6NVVLy3ntKtUpKn4vKdOv8kXSfm7/+ZdYGUd80C1Ph/FWs40J50xJjzQbdCmBvAms/
 nvTYKyWZJSHQl41wkgrX84eAM9r3jKlOFWBF363vGQ4F52OnfRT9m2+XR3vuOmJJH7bqYg4xGWX
 kUsor1CAevUiAD8=
X-Google-Smtp-Source: AGHT+IF0i4RjRfTH0R4KhMQ+fljxmN1It/bALH5IV9VzuXINxskFL+TJpLv6PGL6viWqca9YWrQeuA==
X-Received: by 2002:a05:6214:d8d:b0:6d8:7a7d:1e6b with SMTP id
 6a1803df08f44-6e243bb5e06mr360440216d6.10.1738613413731; 
 Mon, 03 Feb 2025 12:10:13 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254832678sm54935256d6.50.2025.02.03.12.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:13 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 26/32] efi: arm: Select the EFI linker script for the app
Message-ID: <20250203201010.GP1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-27-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L2+fl787El6pwnEP"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-27-sjg@chromium.org>
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


--L2+fl787El6pwnEP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:19AM -0700, Simon Glass wrote:

> The app needs a special linker script, so select that for the app.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/arm/cpu/armv8/config.mk | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
> index 1ee31680106..d2d1a8d2bc2 100644
> --- a/arch/arm/cpu/armv8/config.mk
> +++ b/arch/arm/cpu/armv8/config.mk
> @@ -21,3 +21,7 @@ LDFLAGS_EFI_PAYLOAD :=3D -Bsymbolic -Bsymbolic-function=
s -shared --no-undefined \
> =20
>  CPPFLAGS_REMOVE_crt0-efi-aarch64.o +=3D $(CFLAGS_NON_EFI)
>  CPPFLAGS_crt0-efi-aarch64.o +=3D $(CFLAGS_EFI)
> +
> +ifeq ($(CONFIG_EFI_APP),y)
> +LDSCRIPT :=3D $(LDSCRIPT_EFI)
> +endif

This should be tidied up to use SYS_CUSTOM_LDSCRIPT / SYS_LDSCRIPT and
just live in the defconfig or board/efi/Kconfig under
BOARD_SPECIFIC_OPTIONS if that's objectionable.

--=20
Tom

--L2+fl787El6pwnEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIqIACgkQFHw5/5Y0
tywldwv7BdaM2OK+KqqQoscgkN0Uusmza5huPXQXbYzvnDZUJuzPd8SaDUZvhFXe
IhoaDIxTm7T14QKFOTMFjF5Rns9G+Cv4V2htsklavkvrAujD3bugGtdNMT+Qp7VJ
7ROqBD4Ok35ViM+SXY6UKQC4rTKsYd0WtmJu8wFJgLYS2XvqouJsOGD4eczx880/
3BhJ91RMq+n65BrckM6xgLSI2eUxabqTZbeQK1ccVowprx529woxICPTz9AEacXf
+/e1wy7v6QmDSE7oIsWcx/j0xDJ8Xx7pgYfgHn+eRQhz3LBljGO7HQekvaEHN4Wh
hlzrUTuWxxU7wcL/P7fxlr78wr0tP5L26KpXloJEQ1l/rCiIEUyvM845RYAOPXC1
6NSytcC7oKWPJ3fnOT/tEMdd4RZrDB1hE3dMvkpkj56zQJzhkocS/yJDs/ZHdmeb
IyAD9kmqPLE/8ZmrsapGtmS/kdfAPSB5ENttbQAhk5Ggaal503sMR1avEu9wH3Ud
sG7nbVmi
=Ook+
-----END PGP SIGNATURE-----

--L2+fl787El6pwnEP--
