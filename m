Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF981C3DA62
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 17:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F4B88A45;
	Wed, 17 Jul 2024 19:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LPVurvY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E5A88A4F; Wed, 17 Jul 2024 19:52:00 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D71AB86DBD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 19:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70364e06dc6so296201a34.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721238716; x=1721843516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4KymJMjItiHjaDBo7ehEb15/1IBo4nmyw7/rY1jCfXo=;
 b=LPVurvY+WxOlTPK1e0HDGGL7pYKPnkt3QX4RNyWBttWkATms7CQr+uKmJ5Fq2vsK+H
 nIzau8sdEKjqKtnB1gW1ewFZqRDsJQnw4YLVtANqY6b1hsrorZmTYuueNNaMzbDPz9UZ
 dQBfvaMWCqNZEF02RRlPcXgr0CCq8BNIEX1K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721238716; x=1721843516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KymJMjItiHjaDBo7ehEb15/1IBo4nmyw7/rY1jCfXo=;
 b=fIBUovGjT++1rRBncwFBGj/c/tTXCFerExNIzZRzg/k/bsOdznIKLMiM8U4COBaXnS
 6zGx40pMJj0UmndlnPf6Mzk7vINPy1rEFssP+h436uT9s7rHSflTOm5so2AHrTjtr6Cj
 70kJLEQF69T4NzdZYZijAWMqXiUxJOnR4Fxm8/5pTIYhezQrZ2Cyn/lK5+2axdmLUX72
 spAiDQDrjsD+dJVoI9nfaZBVOK9fcMUZLb1u6F7Ke50YIK/9Vv/OyJGGloMPDwz/drHP
 L2j60avCFapvoKzsoCCb/mc/iD0TthyE15IHVPNgOgNdVm1siY/U4an8obw3VBnk4EEj
 pXqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6OenC3Jk0tHt4RGOwDl1BuqO/6yIDJN8+WHz30Kz4s9GLTC+LwIEaJa5z0daqwiOYptFw+7ZGYEZ5+EZjMyYX8l4MQg==
X-Gm-Message-State: AOJu0Yz0O43yRDnKQLmnNqdN6JgylBVrdTG2S3vprIYJGsIoBV8RM6tr
 K+RstEitod7OuW0UxpUeFj8ZM45YOERPGTlawdECAFgRu5Jea/CKlSHQvgHKqC4=
X-Google-Smtp-Source: AGHT+IFtTJrC+WOBRp63pjXboEs9Fo+tznfniYpnBCLJ5/IlGHpi2jq8bf5MlJtU489IIlRdW1eSkg==
X-Received: by 2002:a05:6830:264b:b0:703:6477:460a with SMTP id
 46e09a7af769-708e3861904mr2562251a34.29.1721238716501; 
 Wed, 17 Jul 2024 10:51:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708e7806ccesm159463a34.23.2024.07.17.10.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 10:51:56 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:51:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: dts: arm/arm64: update devicetree files from
 Linux-v6.10
Message-ID: <20240717175153.GR561963@bill-the-cat>
References: <20240717143415.343827-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZjjATnUyRyajD0lO"
Content-Disposition: inline
In-Reply-To: <20240717143415.343827-1-andre.przywara@arm.com>
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


--ZjjATnUyRyajD0lO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 03:34:15PM +0100, Andre Przywara wrote:

> Sync the devicetree files from the official Linux kernel tree, v6.10.
> This is covering Allwinner SoCs with 32-bit and 64-bit ARM cores.
>=20
> Besides mostly cosmectic changes, this adds cpufreq support to H616
> boards, Nothing that U-Boot needs for itself, but helpful to pass on
> to kernels. We also get the .dts files for the Tanix TX1 TV box and
> three Anbernic handheld gaming devices.
>=20
> As before, this omits the non-backwards compatible changes to the R_INTC
> controller, to remain compatible with older kernels.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

This reminded me I needed to see that v6.10-dts is tagged upstream now.
So, for the record, when can we move sunxi to OF_UPSTREAM? Or what's
blocking it? Thanks!

--=20
Tom

--ZjjATnUyRyajD0lO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaYBLIACgkQFHw5/5Y0
tyxacgwAkdiWRTXME+anSGff1UOKYHvC5BMiBaJWZB7O0K503672kDnvcfzudMZ1
BR8hS0JeRemfUOYDdMT6/cLH51JIANVCU2sJk1KUcoPFX4jqupdEoaIk3Rfa8Qyy
BjKG4wTG1t5ePLlDsF8grCkGdl7nS/i8NG8g4VmQLsPSpTFya+1+Y4KVjEtncVdq
VY9UCvhRcvwLVhOfb8gyfyz9nWixgQthfYhjfU9DvoblnreHQi15iNFNpOcRosG1
iCCW/olVDCckJbNlZvtvhLv/sxSbtqNIOHe+n/Qr91R5Xv8oQhKtynvMphYPynPV
1/7tMC4ESR+TjTBXM9qx18d87zTiuhUvKCWgW6jgBSbwZIsuOjgZ48G0a3LzN170
+akgflgdIeheR7N5nYtzZ9pO1Jl4UpNAljDLA8E2iAj41IecHZP3Ymz+TA4hdP84
fN8p4cebzR75G1YOBLlSEnN9HQ0knIfwTYomvwfj3soy6sittyCbl7hw4wt033X/
t5px4VFz
=B40U
-----END PGP SIGNATURE-----

--ZjjATnUyRyajD0lO--
