Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8055DC5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0E780F9C;
	Tue,  3 Jun 2025 00:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RxYBuX1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC5181E72; Tue,  3 Jun 2025 00:31:07 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED0F80F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4067ac8f6cdso2875728b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903464; x=1749508264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DDy2KwzBjWZGIQ0UpqTC32mLkLGZ19lRxV2bCnxeBsk=;
 b=RxYBuX1yuo+UM9d/1Lljb5bQ6QDwdaipFg+n8x+1O42PwBllkFxhrXaWWrqNV/ylU7
 P6W6pb5uxADp8swVN6dee7De4YQPPeqyWrKM+MxOYnG6QI4tZ4Zwt/nG7RDSVeHZRo6+
 O8lNcITpDs42Clel0mnZQz/0JfBEswiFqIWSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903464; x=1749508264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDy2KwzBjWZGIQ0UpqTC32mLkLGZ19lRxV2bCnxeBsk=;
 b=cyBeknyZ3WpGHyfy/mTllMJewnkUJGQva3juZ9WcryvrNYrLqjYSL3ilnT8TcrOItz
 fG1ZOGwBo4x0saOqj29H/GoWfUou8geRXkfBP0aory+gDYcgO9Em+CEOFSvAikLjxwoU
 4bESv/1QrRtuO6jhFdfW5khbBeBCFKewl48Nn21ajfDX9h2/J+fMEfiPIbbtL4MZN4f/
 54Zr54cBiG1Z8if3GL7TZYtsH7Zf8PqWiS2fn0b8ec0NmSwB67Egg20JcLRvcYMPQScu
 zyOfUMssRmTYz8u6tqdkYUEYhrgib1WZtkk5t/mDi7E0X9ll+ZEut0qi8BVOz41FmMSn
 iKCQ==
X-Gm-Message-State: AOJu0YwMXz39xVjI0GSoCjyR/gNuSEgEG2muYnnZFvH/LSq7kJ6z2ZWE
 ZHiAOkoJUfX3VU2cOM/TYkY3G7+jaFnEt/HAFYzyOEj16AVvj+hDAg7Fo1QOhbr2XKanrSjyu8J
 4deC9DZk=
X-Gm-Gg: ASbGncstlY8p4uBDy07rnGM7BBtNdbuGJypXM/6mkQjjvDGIS0YQrBKfsweGBfKp7ZI
 lMNJwqe95xCwVgseB+EWqyBZQZ971uJ9GThk+gpTddY2aoVD/KTvQnP8YccrHJZuBpv2O9C2+Oo
 TMOHH+w44H/Dqr97qlNE3ihkWJ+6c8L52p7rZ7Qo3yyGYvpgLdS9C0miofJTs0peUok/W+A1xpH
 6N1OtaPzIqqoYF1oU8QX+evhK9yrwsZKp/zFhcWvZLNJYvM6Yx7KX4qPqc/zkx2eAgiMg/0VGdm
 76YQgTlPfBHkjM1hUBPLkhCX2SAKxcFwtPKsWuzmFkiFB1LepM6v1v/BjpNHm1qaaux0KIbpZKh
 N1onjQxEBtncv
X-Google-Smtp-Source: AGHT+IG6LDWwdw6yO0wkLHLQMZbs7S7FRJVBv8xX4GVVG6J+n5Iwjv4idCbiFtW8shXM2RO5TlK48A==
X-Received: by 2002:a05:6808:6b89:b0:407:9d24:aef7 with SMTP id
 5614622812f47-407a65d8712mr6004875b6e.18.1748903464126; 
 Mon, 02 Jun 2025 15:31:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af82cffdsm1676998a34.14.2025.06.02.15.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:31:03 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:31:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] dtc: Add Kconfig option to pad device tree blob
Message-ID: <20250602223101.GA1230232@bill-the-cat>
References: <20250520182305.3819776-1-eric.schikschneit@novatechautomation.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eAIk0U3stO4UI7ik"
Content-Disposition: inline
In-Reply-To: <20250520182305.3819776-1-eric.schikschneit@novatechautomation.com>
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


--eAIk0U3stO4UI7ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 01:23:05PM -0500, Eric Schikschneit wrote:

> This will allow arch(s) that use device tree blobs to pad the end of the
> device tree so they can be modified by board files at run time. This will
> help prevent errors such as FDT_ERR_NOSPACE from occuring.
>=20
> Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.co=
m>

I was testing merging this and I found a few problems, sorry.

> ---
>  arch/Kconfig                   | 7 +++++++
>  arch/arc/dts/Makefile          | 2 +-
>  arch/m68k/dts/Makefile         | 2 +-
>  arch/microblaze/dts/Makefile   | 2 +-
>  arch/nios2/dts/Makefile        | 2 +-
>  arch/riscv/dts/Makefile        | 2 +-
>  arch/sandbox/dts/Makefile      | 2 +-
>  arch/x86/dts/Makefile          | 2 +-
>  doc/board/broadcom/bcm7xxx.rst | 6 ++----
>  doc/develop/makefiles.rst      | 5 ++++-
>  scripts/Makefile.dts           | 4 ++++
>  11 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ea33d07c086..a683af3d591 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -63,6 +63,13 @@ config SYS_CACHELINE_SIZE
>  	default 64 if RISCV
>  	default 32 if MIPS
> =20
> +config SYS_DTC_PAD_BYTES
> +	int "Size in bytes to pad device tree blob"
> +	default 4096 if ARC || ARM || M68K || MICROBLAZE || NIOS2 \
> +		|| RISCV || SANDBOX || X86
> +	default 32768 if X86 && EFI_APP
> +	default 0

I believe this is the logic I suggested and so the problem is on me. For
ARM && ARM64, this is right. But for 32bit ARM, we should be 0 and let
individual boards set this as needed (none today but your board does
need it). This leads to size growth and then failure on a few platforms
is how I noticed this.

The second problem is that the Makefiles in dts/upstream are confusingly
not 100% upstream things and so also need to have -p 0x1000 taken out of
them as they'll get the value this way instead.

--=20
Tom

--eAIk0U3stO4UI7ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg+JiUACgkQFHw5/5Y0
tyy8sAv7BE3kdAgql0Tukew7ezX+wDcTQD6pKRcNI3qRax+TfCIwbW3XfmthBiCc
gyiEdEyOYwomKh43FEgE7SNAxcPvV3wih26lm599xrhLdgVR0Mqv1UH96kh9/kan
xHMD/i6VUwPkVGi/ro7EKa7iZpfBEcqZArV7uitZ5TNi03/jQqzIYqcZ6wSa6ikH
ZpsrgyywO+l+iuULTiEDm6zJsuceW6dOX9+WPTSQ0qSiS9D7wx34+AL3i5fSEqJL
QKHIkfKWWbldE3QfcieR61j6VejNeH+Mxvi05hFMWXOBZiV2xoPGEDT09WV9tTm0
scR5U2gt1mrwYf3FwQe+YZqWpb+dJmZQraWR0tW9DQJZG3dvmDaRjuLTEkRZsArh
3K0vsbakIiNkiGSncY00feVl32GIvYkKH45b0tDJ6kHYRV/tvtcc4fKdiL7MH8/L
PzTZSeQ0zlAArTZt/hsOl2Dhn0zgV9SoLltxby+pnwIq1g8b3rxksEVlMTXCiroc
s1luINUD
=wdIn
-----END PGP SIGNATURE-----

--eAIk0U3stO4UI7ik--
