Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A161DCA0FF6
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 00:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0808340A;
	Fri, 29 Aug 2025 02:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xpuf1Oq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDD48341A; Fri, 29 Aug 2025 02:54:11 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900F983403
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 02:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-74557b7703aso144714a34.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756428847; x=1757033647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GhcGBaVHECh4w3qH4JV335AMGL8DsKMwPNo00dGsVE0=;
 b=Xpuf1Oq4IbL0jUou0w1HKAtEx6eVeP619cuQBvpWaMpHvrLJok2dwVQj6pBYpeMeSi
 +fK51uxqCBpKDUola7JFiTaUwHns35PIzQE2LebQ8V8exUzrqmTTGvpw5v8wFvDcf5Az
 v0OW9afmBar5TOFHkWTLI+HZ7CRo7289RxDYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756428847; x=1757033647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhcGBaVHECh4w3qH4JV335AMGL8DsKMwPNo00dGsVE0=;
 b=NjYV/ESNwXT6ZcBr9YPKbAeBlcfa8crOaBwdKQTG4p+cfTv+eb+I584haxkLAQVBZa
 I4N2zkB+sj+9otZL9OwIurYMokH50xOw2/7INxq9lOtGtZ/pn9BcVpWGJZ3vmUCRZAur
 kIBDRJ1tAZbl01RD88eZbrAmjyVIpUWrmSLPp0ySPGcGLi8XZDHrsvHwgHOvb7j5jwsq
 jEO7wtq0ocdPGjW1O2TpWnGSiW98cApcwQ2LgVCY4bkxhHNpJMUC865vBgUbaiq16aiO
 v4RsiM+pyQ/6kGOWcbwB7Up9MSdbxHEh88OTEt/ABDQctxdSUnadWDowT01IZlW8dWqn
 0CHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSPD89II6hfFMtEBCE/yb943zzuo4cdkRMOs5vkhdSU4+YUAqWDMl2f1nWn0fvBaVdxcEW5NI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw31fW+y8CNbAQupgUpzFoY3ZZ9hAZvLAMLOIBQt1kMiRlNM+7q
 e+fR2W5S0R5vyN/KcDV1TeqsasSxzP2R/Ovf5Oq/PVN6fnmkGVQUXW4++qutP96z4C0=
X-Gm-Gg: ASbGnctm9BM50fqfjEDZ2gK60E6X69Z0rdGcMKwoP+eGNtUZQvUNBiColzk+dS/UfRz
 MEPY7synzPE59HDKs9i76KykNZsQrPSmufpiGk2OzmJaMN08ukw2hNYA48Cj4HtAdbh3KhpYiPc
 L0CKdwqRcPyH8eEA2z9zJqkqrRhJbnLGGwfXGfAudtYh7A3e80eTH2xTX5QRvn6dRrns1P2Mz1t
 UYBda5e0zAvP3RBMnlJzSfGQ3VL7PLj9ekRht/dkDVhRjt7VNk358fXhY/IGMff4+gEFBZBKK1x
 /PqQoFugjNWO/wVdQzuPQ/aurylVZW/hd5fESdRp16eraL0/D+448kmawplku0Rk2z+75wVuaLf
 fxVJLtcvX3Nsj2c9EsQ+Q5NKsJDdaqHo35ip6JlHBN+NtBG4sTsAcPaI3
X-Google-Smtp-Source: AGHT+IG8f+/kDIJyWPTiXbuywzuz3As9DUQ4tuupwB6YJFiQFNJrE7J9GffyeP9dKqGMoT5hTrl5oA==
X-Received: by 2002:a05:6830:91f:b0:742:f996:ef34 with SMTP id
 46e09a7af769-74500a78e6emr15228447a34.27.1756428847173; 
 Thu, 28 Aug 2025 17:54:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7455857f237sm207118a34.37.2025.08.28.17.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 17:54:05 -0700 (PDT)
Date: Thu, 28 Aug 2025 18:54:03 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchart <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Update mentions of README.fdt-control
Message-ID: <20250829005403.GS124814@bill-the-cat>
References: <20250829003330.489627-1-e@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f6HVE+i1GvvmrjOW"
Content-Disposition: inline
In-Reply-To: <20250829003330.489627-1-e@freeshell.de>
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


--f6HVE+i1GvvmrjOW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 05:33:22PM -0700, E Shattow wrote:

> Update documents 'README.fdt-control' reference to replacement 'control.r=
st':
>   doc/arch/nios2.rst
>   dts/Makefile
>=20
> Fixes: 3e9fddfc4f14 "doc: Move devicetree control doc to rST"
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  doc/arch/nios2.rst | 2 +-
>  dts/Makefile       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
> index 34a75e7fb00..2fabea7bb11 100644
> --- a/doc/arch/nios2.rst
> +++ b/doc/arch/nios2.rst
> @@ -13,7 +13,7 @@ Please refer to the link for Linux port and toolchains:
>  http://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
> =20
>  The Nios II port of u-boot is controlled by device tree. Please check
> -out doc/README.fdt-control.
> +out doc/develop/devicetree/control.rst.

We should do these as proper links within the document now that they
point to rST rather than plain text files. Thanks.

--=20
Tom

--f6HVE+i1GvvmrjOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLD6KAAKCRAr4qD1Cr/k
CttrAQCihYicyIa3xTVB6RskP32UX1vDoAPq9mCt5VXls2E6iQEAnVxsd2uC708n
M769nhj+hNy8RSep5vGq465Gg7ZFhgU=
=sd/e
-----END PGP SIGNATURE-----

--f6HVE+i1GvvmrjOW--
