Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43566FD3770
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F08E8840A6;
	Wed, 25 Feb 2026 16:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zs7BmGdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1021840A6; Wed, 25 Feb 2026 16:54:37 +0100 (CET)
Received: from mail-oi1-x233.google.com (unknown [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E0684088
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463a0e14b4dso2198269b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772034764; x=1772639564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B5dIthr9MClucSzRvyijBzQp8Vc2+y0u/c7OGZ6N2EU=;
 b=Zs7BmGdURfk9vfFXIvKY0CJ7j3W180q7xIa1m7yh2vl3A6aelGtxBPgl41RRCC8Ff6
 dytwgay8fyNmmvPFmM4FuS/Mh9KPbiXuqd0s+fZwTuz6RrzVyduCSnfpsnocXDsWGvou
 Vzi+7wubZ2Tbf7e7hQntgAt5RS5tTdEMp0+vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772034764; x=1772639564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5dIthr9MClucSzRvyijBzQp8Vc2+y0u/c7OGZ6N2EU=;
 b=QwiRJw5FJ6oSZCp+1zLXvJoDOdTw3XiueL06zbv0YnakN/XszGmbDVRn/4rp5pcmYG
 2GzsPVR70bZQoKtfeH1XxFa63EVZenlibiAICaReXRh8QQCKQQbZGRaU2UJitp+6WR6y
 2E9itn8uZjxsHazwEF9EQjE4+TJOkggjmQhSuTkTvxvWrqeceTLNmOQhBltyzhB26XpW
 ybXQFw4KJQ/5PlyuCXW3DMjzxi5hm+qdQ/FCeACDzRRHf0eC9k6ccOoQYRzxZQMrj3Tc
 el+2cabvg9n3N2SILQOfDWiLJD6NcfSK72nvCWZ7eCNlDMNQSGFwE2Mk5MFrSW+RTn0J
 lCGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVexvYcH4flqosug4ayTC4hB1qKhJ417s9igaA2PHiSpLiKmadRWarmyrT4HsJ8zOMmJ1aFIt4=@lists.denx.de
X-Gm-Message-State: AOJu0YyThzw6JPR4aqMBJP2SIacJforhzMEHRsZy0/fUQpQLPaq60ALu
 HLazU6hwaZ4uYN35zRJnCMIs/MGRYbeupSQWSGuO5D2Aq0f4c5PYFpFskl3U25ldsrQ=
X-Gm-Gg: ATEYQzx5zpNaeKpsutjZy57L1w2BRcqoHzebFWM0Rcko98NDHr0TRRTN5BSnLzTpcWn
 5fyRccBWNFj+r2PsAl9DrxIFgX/9lNNmy8hLA+SYXJWyVYcpL2oTwAymfR2WGm/neek2iVIMv8n
 BiT8SW7+0fyiVR1hXuUcTDJAxIgqKxT46/gbl5FvSOtM7wTCnjk5btafyyR3ln+JH6wWvDkht/d
 nebXjxbyEN21gBIneS3ctrjCyVBleYAmDxCO9lnW6kVVeiH94j3OvuFg+1Q/oEnupjBoHHra/gm
 wyiHDjFqBYNYkOaazmLTtSnq4okXRMGN5kUZATbY2RabWDD0qQsPhsZ3mHzsGMgwhn0nDBb20nm
 Kmhins75l1fDyGeuFrQqdXzih1OOkgJe1KNyXDurV3kWuTrFJzKtVntcQPS1w6L0p7yalwEERNn
 SO5ODS8yomFL51CJmmeMg3jLGivonxQBkw4JFgDKg29CG5sNlQGaz7YEF07XJZFnhiAYJP5d6bQ
 yN5aZ04+bCg6s4R61Vqut0JqXiLfcbQchBUXwzuVCEBrsJu9Bk=
X-Received: by 2002:a05:6808:17a6:b0:462:dc57:f8ba with SMTP id
 5614622812f47-464461fe120mr8445371b6e.27.1772034764547; 
 Wed, 25 Feb 2026 07:52:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46449fd6ebbsm9249872b6e.2.2026.02.25.07.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:52:43 -0800 (PST)
Date: Wed, 25 Feb 2026 09:52:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288
Message-ID: <20260225155242.GM1593142@bill-the-cat>
References: <20260225155050.73841-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vnEIPLz1BBsB2DME"
Content-Disposition: inline
In-Reply-To: <20260225155050.73841-1-heinrich.schuchardt@canonical.com>
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


--vnEIPLz1BBsB2DME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 04:50:50PM +0100, Heinrich Schuchardt wrote:

> Remove the reference to the non-existent symbol. As ROMs typically
> come as powers of two there seems no need for this value.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 48b033e7e27..20896374810 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -319,7 +319,6 @@ config ROM_SIZE
>  	default 0x200000 if UBOOT_ROMSIZE_KB_2048
>  	default 0x400000 if UBOOT_ROMSIZE_KB_4096
>  	default 0x800000 if UBOOT_ROMSIZE_KB_8192
> -	default 0xc00000 if UBOOT_ROMSIZE_KB_12288
>  	default 0x1000000 if UBOOT_ROMSIZE_KB_16384
> =20
>  config HAVE_INTEL_ME

Fixes: 64542f4616c4 ("x86: Make ROM_SIZE configurable in Kconfig")
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vnEIPLz1BBsB2DME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8ayQAKCRAr4qD1Cr/k
CuC5AP9hG2kLOPyqXnJuGFb22aEewk9TsH5TSl2VRwkLYg891gD4nSqoNiMXuXt8
uPJPDwmpI51qc3HCdrSilCnZzpUuCw==
=UFEa
-----END PGP SIGNATURE-----

--vnEIPLz1BBsB2DME--
