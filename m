Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613E7C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D2D80107;
	Fri, 16 May 2025 18:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mTDSpTct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DED48006D; Fri, 16 May 2025 18:28:34 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2640D8205B
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-609e7f3caf3so1677963eaf.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747412911; x=1748017711; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4EDnMW3R2dbYLgEKpRa8xDlJfdiXBel5jgqrpEUJlqM=;
 b=mTDSpTctO2v1XPoregacuD1JF57HvpNfSSjVGrcH3R91EFpa7YVfEqSlSSRGCf30eg
 mqxbgr7nayGi7kz35OBZkyC7CJbBFGCS5uOg6mbtAgZ5Z/szZ/CTsDrfg17vghPH3ezr
 EBv/dA7x8UzDVEGeqYzmuna1rs0JhqC4FuX/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747412911; x=1748017711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EDnMW3R2dbYLgEKpRa8xDlJfdiXBel5jgqrpEUJlqM=;
 b=euTrDoMLMWdOSxOW0Bg+d27pHLO+WK07KPqPagRnGuJpg3R/XCEkWr3vRodV18jleK
 fEEgPK/O4TWcfT4UAYOKAVt4rDvIYMn1e/LAPm04RW5cd/SCmFvraB0MGZVwSEFwwh64
 Pf644LG1CD2qpJrTyTHkLcRzLAjMg6zFC8MsunGbBLf8h2m4+q5eiTCuf4/hztP6pp2n
 7XC1BTSJCgtdQzqtI8kAYt4hnPk4sntZtEFwPh477FNpmxzFsrGudxZS3tqguTlqkxSO
 efVk/XAdnvfvU5xG54Z4p0VyDxsPTJ5ubqvDyNpS4McUgvhUsPeYy9euQuZfQfD61tSw
 stOw==
X-Gm-Message-State: AOJu0Yy5OAfrmtxTJ1mQkfICXDgBXMGncnz4q9hoERsJTir2toAi0qKq
 yz2QCZwhCvYzTTLB+FW3iVLdOpbe//Pd/cNP5MwdzXyIRc5S6id5ib1GSGmRI5udyDw=
X-Gm-Gg: ASbGncuNYgC+GKqZL1dBqVajfvZrIybTGXP3YmrfXCYXZR8ueXp7jIRADTWM2NJZ0SG
 wgC2wExqmKl6HhfX898Drvas1WD8dHSkXN6HHTwJyGZepZ+G1woMogBl8MIuek+j1hCZuBGP5i6
 8F7IjM/YOT8gLpv4gcbBCOhiCisro5rmXD50vuyTRT0rFDrqprxKOX2+KZT8Utd1tk8jW7+hiDJ
 X588YenOq+dRd98NTkZgoflmGwu/kqElubZKA1+l4XCAFUd+RwmPn43RRgKolRJusPdV7EPCbiF
 kwBdUWvlkTExj9URLGdopzAISuYMCOV4iDFybBxwCFqHOgfs5r9TK/X2kF2JTokLdqzI2JCVhwV
 M8sbFw9E2+Rra
X-Google-Smtp-Source: AGHT+IE9Q2WRhd+WLhwp4BB0iP3y6QiS8jjVgXVxtoSheZcvhvlkdLoQCcxJLA+eIcy7//9axNKHCQ==
X-Received: by 2002:a05:6830:700e:b0:72b:9014:f5cc with SMTP id
 46e09a7af769-734f6b850d1mr3221593a34.25.1747412910805; 
 Fri, 16 May 2025 09:28:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b6196bsm400671a34.63.2025.05.16.09.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 09:28:30 -0700 (PDT)
Date: Fri, 16 May 2025 10:28:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250516162825.GA2939351@bill-the-cat>
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U+vdnonEpE+MWniT"
Content-Disposition: inline
In-Reply-To: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
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


--U+vdnonEpE+MWniT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 01:38:26PM -0500, Eric Schikschneit wrote:

> This will allow arch(s) that use device tree blobs to pad the end of the
> device tree so they can be modified by board files at run time. This will
> help prevent errors such as FDT_ERR_NOSPACE from occuring.
>=20
> Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.co=
m>
> ---
>  arch/Kconfig                 | 11 +++++++++++
>  arch/arc/dts/Makefile        |  6 +++++-
>  arch/arm/dts/Makefile        |  4 ++++
>  arch/m68k/dts/Makefile       |  6 +++++-
>  arch/microblaze/dts/Makefile |  6 +++++-
>  arch/nios2/dts/Makefile      |  6 +++++-
>  arch/powerpc/dts/Makefile    |  4 ++++
>  arch/riscv/dts/Makefile      |  6 +++++-
>  arch/sandbox/dts/Makefile    |  6 +++++-
>  arch/x86/dts/Makefile        |  8 +++++++-
>  10 files changed, 56 insertions(+), 7 deletions(-)

I like the concept and the cleanup. However, I think we should:
- Put the line
DTC_FLAGS +=3D -p $(CONFIG_SYS_DTC_PAD_BYTES)
in scripts/Makefile.dts with the rest of the DTC_LOGIC as:
ifneq $(CONFIG_SYS_DTC_PAD_BYTES,0)
DTC_FLAGS +=3D -p $(CONFIG_SYS_DTC_PAD_BYTES)
endif

Then we can:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ea33d07c086..a85f751d1e6 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -63,6 +63,17 @@ config SYS_CACHELINE_SIZE
>  	default 64 if RISCV
>  	default 32 if MIPS
> =20
> +config SYS_DTC_PAD
> +	bool "Enable DTC padding"
> +	help
> +	  This will allow the final device tree of your specified arch to
> +	  have pad space at the end. This enables the ability for the device
> +	  tree to be modified in place by board files.

Drop this.

> +config SYS_DTC_PAD_BYTES
> +	int "Size in bytes to pad device tree blob"
> +	default 4096 if SYS_DTC_PAD

And change the defaults to match the existing users, roughly:
	default 32768 if X86 && EFI_APP
	default 4096 if ARC || M68K || MICROBLAZE || NIOS2 || RCAR_64 \
		|| RISCV || SANDBOX || (X86 && !EFI_APP)
	default 0

And then we drop the -p lines from all of the other DTC_FLAGS.

Thanks!

--=20
Tom

--U+vdnonEpE+MWniT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgnZ6UACgkQFHw5/5Y0
tyy0Xwv/aJkcBfk1dczeV81JFwOUmOjzGRKtunkdV5lovNnWici1Gfkt9SeRSFnn
h7G+O0a5EMDGBwR4bigidNgS13xA5d2ugoU/ETeRNfmIA12Q6sYyDEcOuh53qzFH
8bK5W7NYUKW/eMBvIuA/pptRL67FV6wdyRGscXsLrtfdlWIeWQ7a0eray8xezcZ3
xqQoYbTvprZhQ+/f6+l5JbHCcx/Yar74SnbDf+WXCbMc51iZ9r/N8MDR9td/k+VB
nuXFYDvGGOwAKJ6EcUevqaMLdmg5yeUdMraBUQAgAtTNxTBP4bEz0HLDxkWQmY4Y
gC6eIv5I4ksnrPFFlULvt8v4UEZm3FEUxROTQho6P9rxg+xnYxOS+PXt1thQwsHK
yQDlAm5z5F3YKoj/mDl1amcN+COYGJp0+KgcPcg1iVHk22mRzgjVScJ56mJ31UKc
71vIniGHrOWCePWvKKwLpc7YJ3D7F+a/csklO/0jFM4Gvh2f/YcrdVeojvI+f/9p
Snf3Vpxn
=+I0s
-----END PGP SIGNATURE-----

--U+vdnonEpE+MWniT--
