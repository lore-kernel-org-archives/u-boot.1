Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB79F3C9AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A48A83642;
	Tue, 24 Feb 2026 17:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uy2cO+r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8846583E13; Tue, 24 Feb 2026 17:08:47 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5467282BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-67997ce9e1cso3403272eaf.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771949324; x=1772554124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LFZEC1eAatFTXtx96LlkewDl3GibT0/Apl2KS0Pr5ME=;
 b=Uy2cO+r6liFL97P7GF6bQWz+aVqBIgGMvDjDKndYPl64ysDlX7MZ3akhee4lnueWnJ
 uuXvejbX7OduKR2Egg6Ys67Oq6CoDPV3wXnogqFSnsAYKzsZzZFW8I2nRIeNU//o96WC
 Ny7KOWPt8yEFgQ3EBUKbI5xWTgEJ5h89EYJlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949324; x=1772554124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFZEC1eAatFTXtx96LlkewDl3GibT0/Apl2KS0Pr5ME=;
 b=S3Luc+bk4flFtgA4s/q/NyiIOt/J5rCpXp94W9dlkzWoprwsiUN2uJqk6pQ/0F1v36
 BPMFqpLh8YYvN7bxX9YAh4dBKiqxFMsX0wGmj1Tmt0ysrqqGPg4v/FH9HM+blz+GHrPu
 hLrtFFCZCxhmdt+S5Vci+2hyJm1Shl4GmtNG55IBtfmXI8dWrdHCBdZx6LWu4Wn8nld2
 sy14V+UxBqeZApdYt4CHUZgIYztZrz4lMJ3ZecEsQdN/fgdPKAZFAY7EWTYEAqTnAhRC
 Qe48nDn+VeMk5hngrbwft6c16CUIL0XTa2aHhmcakgCtG9trDXLQjo5MTB0720aoVzMR
 Hy/w==
X-Gm-Message-State: AOJu0YxfNwwBjFJvTdjH9UA1PlOKzunHR1SXwJizVZED5Y1maXD9UNT5
 1LeImEkuNquMjKluYf/yEcnUNuqaMXa+YVFXQC4UrcmIrEHC4jCeNK7h3bO/DPeC9nU=
X-Gm-Gg: AZuq6aKwaAcKV+mpoeb8Lr2+JQfNivN7VzU6J4tvFWAasaHhNgeAwDEI8Fhe8gzqmuH
 EV/Lcp+RPg38GnTVn0oPQy5kPpZr5YX0AEtMf/J8iQFRVotC4foS+8Ugxab1Na1JJeQNk0DUdl4
 USPWi3C054Raw6nVykHrUi1CRclKzTOe0Gr03d2k7GPPvlXysanR4vPPXOYnTGZQUQ+rmIVmRvr
 Lng0zT91vRbk4eVHR2pGs9Js7qNP05XC5FpGfr8RriEppcPyq5FGV+/dtEdXzYvCbUirhrQflIc
 C19nyldCTzo6mj6j6hg5rA5+0nH4NsvFJGxdjiefVE2chGrZ6W/423BS/NfN63r+mCUsi3qBSei
 zYeWQAk4wDxCw+Pl4TlPW7YcuGPPKFLjX4U7C5865IShg5wnTuwwuqYrmY1z6fA1VFJK4RFmTkH
 y4jBvp33lo38gi2stiuVYb27zOb+b+T6U18LJWsGVeQbPD2rxi0mgYC+S+3Qvsv2cjC63IotLSl
 3jDZhI8+NXkIrDvP6LEs1UoSKIqVMFAoaqU8y4WkBvP2pWEsnjR+jL1AgLskQ==
X-Received: by 2002:a05:6820:160a:b0:662:facc:529f with SMTP id
 006d021491bc7-679c446f068mr6905043eaf.28.1771949323904; 
 Tue, 24 Feb 2026 08:08:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c570423fsm8550389eaf.15.2026.02.24.08.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:08:43 -0800 (PST)
Date: Tue, 24 Feb 2026 10:08:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>
Subject: Re: [PATCH v2 7/9] riscv: Drop board_quiesce_devices()
Message-ID: <20260224160841.GW3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-8-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qmZYKozPJ0ZYhD9g"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-8-simon.glass@canonical.com>
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


--qmZYKozPJ0ZYhD9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:49AM -0700, Simon Glass wrote:

> This is not used on RISC-V so drop it.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
> Changes in v2:
> - Drop the call to udc_disconnect()
>=20
>  arch/riscv/include/asm/u-boot-riscv.h | 1 -
>  arch/riscv/lib/bootm.c                | 6 ------
>  2 files changed, 7 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/u-boot-riscv.h b/arch/riscv/include/a=
sm/u-boot-riscv.h
> index 543a1688db8..3a8fdb57136 100644
> --- a/arch/riscv/include/asm/u-boot-riscv.h
> +++ b/arch/riscv/include/asm/u-boot-riscv.h
> @@ -16,7 +16,6 @@ int cleanup_before_linux(void);
> =20
>  /* board/.../... */
>  int board_init(void);
> -void board_quiesce_devices(void);
>  int riscv_board_reserved_mem_fixup(void *fdt);
>  int riscv_fdt_copy_resv_mem_node(const void *src_fdt, void *dest_fdt);
> =20
> diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> index 9544907ab1e..c6a008a4559 100644
> --- a/arch/riscv/lib/bootm.c
> +++ b/arch/riscv/lib/bootm.c
> @@ -25,10 +25,6 @@
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> -__weak void board_quiesce_devices(void)
> -{
> -}
> -
>  /**
>   * announce_and_cleanup() - Print message and prepare for kernel boot
>   *
> @@ -46,8 +42,6 @@ static void announce_and_cleanup(int fake)
>  	bootstage_report();
>  #endif
> =20
> -	board_quiesce_devices();
> -
>  	/*
>  	 * Call remove function of all devices with a removal flag set.
>  	 * This may be useful for last-stage operations, like cancelling

This should end up in bootm_final, as the generic hook for things which
don't fit in to the DM model.

--=20
Tom

--qmZYKozPJ0ZYhD9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3NCAAKCRAr4qD1Cr/k
Cl6UAPwJDtwv3jFvXuyzRFyNSp91+iYTrovrXs6OWzXbhJuWgQD+MEqWYbACPGZd
XfPp3u4b13+UWdH6CPkEXZWp/3cfbgU=
=nJ6t
-----END PGP SIGNATURE-----

--qmZYKozPJ0ZYhD9g--
