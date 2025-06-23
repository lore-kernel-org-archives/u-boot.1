Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52816C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 13:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34D182E05;
	Mon, 23 Jun 2025 15:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VxGnMXkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCB782E25; Mon, 23 Jun 2025 15:48:38 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D6882DA1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 15:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4067b7d7e52so846614b6e.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750686514; x=1751291314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E7HudCdgo/evCuDPExdIs+JI8nHtThb9DVySCyAzb8M=;
 b=VxGnMXkL5xM8hug/8tFO0bSWAgCeFzW/FDRjdJlteW5GBkJ9AiRbdXV+0UlxbpB4yd
 5Li1H+YL1/8lIPMuoHc3XaXGPAIsudYrebFTbyp8EeOYPM5cdNCrQIPq9yFV2iHWHM5x
 mTbNiJKYuG6HixoUdpWMZumjMAs8Gdf+DBNs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750686514; x=1751291314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7HudCdgo/evCuDPExdIs+JI8nHtThb9DVySCyAzb8M=;
 b=MJK+QAoTNAXHG17Xx8+XTpMBJSF1JsnTZbfX4FXUgtRQKl3lZ6+HwNsbY3//ppv3aQ
 7dmRR9kPexeTaxwKvB+xcIApDcQz9Fk2hzakg7ZVBCcp6owJNLmV+MTUv/5njd3mCD1N
 oGUDhVPEHVDmBfzw1vejNcfSVZbvLjWUYUI2vEFnn0aUaYfabMtBXI0aKPYuRRwQ5O6G
 Tl++brxWk/U7spj8Kpe3nHC74Z+ZcxSlPIF9Hjiuz5OUeelrjafCB2QrtmI1NPogUDDI
 sPD84y4BFEnU4X29STO9IJXhEosKxBu99Lvu6RMS+KaP2WBQSlM2pDrUBcrxKQgrzuk0
 8hfA==
X-Gm-Message-State: AOJu0YwE7J654yOHOqlETwYuGq3Cz5IbV5pGky9Bx33CYvYwyIzDOI0J
 Wja6mMDJNIwfcKGvaIgw5XQRBLMJJYL5BulVjJcp46wj3j3BnLPTBxqkhSryj52B7bI=
X-Gm-Gg: ASbGncs7k7XME3bVKFIVncLKz16AKobxeUjLUMdN15yorAa4xzPhzFpRbOWJfx44svX
 U6zoD/pbjiXAqAbTixcVKYmHqLCQg2GlvDmS814tNTP15dwixJVG+tJa/n+RE+Oruyqe7ogBWO1
 lQhUAuH2c5tF9IIdc4xFtKFZG9GRyQlKJllsaRXKQUAiN1+B7ZvxET4iR1EjEEGyzujfjjojIyn
 c6OkwXz3g7yuGBJmOZcrgvTe4frM8AKslHXVnHu3feyBs0OLoayL2izuUJDCEqzFuEAx5fGAh2e
 X8modT1B039RaQEwHfBiMccSa8Is3bAiETWEa0Tkx90ioWBkjbylCcnmxTK0+XtuaUaK3x8fnQ7
 iHqoFi4tez79Z5jsQoVDU7f0=
X-Google-Smtp-Source: AGHT+IEa4vC2DyeI5l615frOtIhCUwiHV2YC5pXUR6ZQmC0Na1JZfiDWwe1A47U0h65RneyGZ+iUrA==
X-Received: by 2002:a05:6808:4f50:b0:408:fbb6:f4cb with SMTP id
 5614622812f47-40ac7033bb6mr9143749b6e.6.1750686513936; 
 Mon, 23 Jun 2025 06:48:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6d11bacsm1406140b6e.35.2025.06.23.06.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:48:33 -0700 (PDT)
Date: Mon, 23 Jun 2025 07:48:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] arm: kirkwood: fix freeze on boot
Message-ID: <20250623134830.GA4003484@bill-the-cat>
References: <20250623080823.2163074-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kKchQTM5Ufqk96kq"
Content-Disposition: inline
In-Reply-To: <20250623080823.2163074-1-jerome.forissier@linaro.org>
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


--kKchQTM5Ufqk96kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:08:16AM +0200, Jerome Forissier wrote:

> Commit 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if
> __thumb2__ is not set") is not a proper fix for the LTO link error
> mentioned in its description. It causes 32-bit arm instructions to be
> mixed with thumb instructions, which the Kirkwood SoCs do not support.
> For example, board_init_r() is mostly generated in Thumb-1 mode as
> expected since the build flags contain -mthumb -mthumb-interwork. The
> MCR instruction corresponding to writefr_extra_feature_reg() is also
> correcly emitted as a 32-bit ARM instruction (it cannot be encoded in
> Thumb-1 anyways). The problem is, the compiler inlines the MCR without
> generating the BX or BLX instruction which are needed to transition
> between the ARM and the Thumb-1 states. From the objdump output:
>=20
> 006186a0 <board_init_r>:
> board_init_r():
> /home/jerome/work/u-boot/common/board_r.c:799
>   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
>   6186a2:       b0ab            sub     sp, #172        @ 0xac
> get_gd():
> /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
>   6186a4:       464a            mov     r2, r9
> ...
> /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
>   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
> writefr_extra_feature_reg():
> /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
>   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
>                 ^^^^^^^^
>                 32-bit ARM instruction
>=20
> Further investigation is needed to understand how to fix the issue so
> that the code size is minimal for all boards. In the mean time, this
> fix disables LTO for the two problematic files (common/board_f.c and
> common/board_r.c). This makes the Kirkwood-based boards bootable again.
> The binary size is increased by 1048 bytes which is perfectly
> acceptable.
>=20
> Fixes: 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if __thumb=
2__ is not set")
> Reported-by: Tony Dinh <mibodhi@gmail.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
>  common/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/common/Makefile b/common/Makefile
> index 35991562a12..f0b7eadf7d2 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -19,6 +19,8 @@ obj-y +=3D version.o
>  # # boards
>  obj-y +=3D board_f.o
>  obj-y +=3D board_r.o
> +CFLAGS_REMOVE_board_f.o :=3D $(LTO_CFLAGS)
> +CFLAGS_REMOVE_board_r.o :=3D $(LTO_CFLAGS)
>  obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) +=3D board_info.o
> =20

I'm sizing checking this now, but we might need a v2 with something
like:
ifeq ($(CONFIG_SYS_THUMB_BUILD),y)
=2E.. remove ...
endif

So that we don't grow *everyone* with LTO by 1KiB. I'm checking now how
bad that will go.

--=20
Tom

--kKchQTM5Ufqk96kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZWysACgkQFHw5/5Y0
tyz3PAv/Uab/w9koTqXRHVWTcRm0IEw6pvc9Enyl2qPYPR9UMxS78r3m71ieSTed
1wdSUE72TiXbiXhw7UQTax+VFW56+LQR2OlOL9nvR/gUHzRge4uK4eLYylI0GVTI
4s2WPc+4Pvic7DbsGIeGFpbU9ZvBPYKF6KdpdKCiwIa9Bef9EpPSOTNOFxs3cbC/
6Gqoqn8iGanx3pWgFUl5bCA9ivHJxyu/Qjq6V/tvJ33OfAZfqcAU3MdTqlcaH/hE
7Rx/GURPCOHVtGpQffPAQXiRFI0jEf+aKBOODKoBjP6tdy2D+ghZYxlyrNMB3snK
ww8wRWWhnF0Ufyt6aQ3rSfHO3lhTp2YPEiwpidmBIu7Jyy4cj8qc5rfA10IglIb/
yZMwc6d4iD74/0P2CiBWZzxTfdTiu96vTiXAuY10gtXingA3T5OjfdmY7nO9r3w6
funL9f/tTAXntzqkocCJmO9pdNfyWXO/3ZApCCOseLK2K8NA7+I60BzwIYJeLpgZ
/drCbT9s
=jpjZ
-----END PGP SIGNATURE-----

--kKchQTM5Ufqk96kq--
