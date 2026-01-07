Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9669ECFD641
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 14:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF34083A26;
	Wed,  7 Jan 2026 15:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BolJYRgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B6C83A57; Wed,  7 Jan 2026 15:23:50 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FDA839F1
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 15:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-459a6261428so572609b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767795826; x=1768400626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5A+hlgzW21G0ncwXRJfETmBBlWeRhv3g7ATydy42j18=;
 b=BolJYRgv1qVnqvTjmgrz4h3L21UQkOlAJLIPXReiDIKoAdxrNhtUk14gR4XNUubpeL
 2e5AF8pFAJ6sMa9yb/ZUR4oeE3efCixPAMyJhH6EurHMSoAxSUcPLlGBjSNSx0JlPumK
 Yr/w3d+fsvhds/Erpbl+mqQA6ih6nO/MGOXN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767795826; x=1768400626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5A+hlgzW21G0ncwXRJfETmBBlWeRhv3g7ATydy42j18=;
 b=HsoIWGuEi2wLb4NYvDirx9my4AoaRMnKo/6Sn6lRPaSKNfEKVw8oc0F4teqJprEQFv
 PlmdYQW3vZUsWAHoGotsBDhXQncIjk8oqAhi46aJNO/NCSV8vwSbonPp2gxIJHQ6oxs1
 yCnYPTG+w0ObruAHe5W+LZrCPbZcXpnfVjy2gpg3srecWAMEM2bM8Z7K2h0/N1N6bA0f
 OjHxBT8CJwvec1RKiAQA/s4lXNlFA1gpENxt+q1dksR4xcxgfsChEPflYrEaRSOX4Ek+
 /iXpPlo61H46yBrPibvhaZlEH1XYeVt2mLVK7UHNAsuCnWDOnLR0N4JVuKuPbbcstd3m
 GQYA==
X-Gm-Message-State: AOJu0Yx5OEsOEnxamwvvcAT1rrNplhEYPSWciPcZtAvs2NPFsTi4tH4U
 uFnmxBYXyC/He+0PSTtC1oR8UpNUk90UAvRtHyFV/BlSo04vafmoX3cYB4bQGkDjzPY=
X-Gm-Gg: AY/fxX44/5wPb8QrZlSIFhCndsPJ9HLzfGYxPU5ewMQEFywHIl0or+HyfJHSTusxVcG
 PTeW70YQ3v/tCquGCaoPIqXbcsbwVagL8T116bofF15aH70Xj//A3XOxlMz0ImcEH4x/b7dqOLP
 m2fWF0N+8rtUXDoivSDNYAKBWSmkeTpQZLUk7TFuJznSh6X9zY6vjMbn7t7v78IA9DpWTbLqTcm
 wL2zWECpdFZduYrgvtX3Jj/6a4USgvCZde0Ei9PoLmqVciHYlkda5ajp61QImdaLYn3ChVqc+cc
 tx8vM3d3i7QJPDABfkUvHSXm8V97Gz2HYq9Wuhg0Jh5aHLc4nRd7iRMRY4mUVdkiSAhtARQM00r
 VUaT93rI4ISaf9R3sKWCNt2o5kG5WXoiT54Msm/CEVjQ8EU0/3SZoom2eohTQ1xm651psedaMng
 R7N3nRpmMvd+4Ri7W/HxITVrUSOUdT630LZjzgoQbv6ZHKBtGTW7bXHHnLo51ZDI5qyEvAvJG63
 2o5rrLYDHK0ScDwPJ0a5VajU5IN80WZArUdBfY=
X-Google-Smtp-Source: AGHT+IE0Yl4pqVDJ2x0S4oW/W1GlkxeASJ2B1RXEKs0cO4u7nXngA8rbMsSia4yJVRp90myEimQtDg==
X-Received: by 2002:a05:6808:bc7:b0:455:e5c2:a6f9 with SMTP id
 5614622812f47-45a5c99cd0fmr3867336b6e.14.1767795826433; 
 Wed, 07 Jan 2026 06:23:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50721a6sm3324864fac.10.2026.01.07.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 06:23:45 -0800 (PST)
Date: Wed, 7 Jan 2026 08:23:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>
Subject: Re: [PATCH 07/10] riscv: Drop board_quiesce_devices()
Message-ID: <20260107142343.GN3416603@bill-the-cat>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-8-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CCh81suv761izdf7"
Content-Disposition: inline
In-Reply-To: <20260107003131.3064800-8-simon.glass@canonical.com>
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


--CCh81suv761izdf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 05:31:24PM -0700, Simon Glass wrote:

> From: Simon Glass <sjg@chromium.org>
>=20
> This is not used on RISC-V so drop it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
>  arch/riscv/include/asm/u-boot-riscv.h | 1 -
>  arch/riscv/lib/bootm.c                | 8 +++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
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
> index 9544907ab1e..35403e03ab0 100644
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
> @@ -46,7 +42,9 @@ static void announce_and_cleanup(int fake)
>  	bootstage_report();
>  #endif
> =20
> -	board_quiesce_devices();
> +#ifdef CONFIG_USB_DEVICE
> +	udc_disconnect();
> +#endif
> =20
>  	/*
>  	 * Call remove function of all devices with a removal flag set.

You're dropping the generic hook board_quiesce_devices which is wrong
and adding udc_disconnect() and a test for CONFIG_USB_DEVICE which is
not present in mainline.

--=20
Tom

--CCh81suv761izdf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV5sawAKCRAr4qD1Cr/k
Cl3LAQCzXcRZin8O+NiYQRYMFmfbPYGuXJ8JTBiGN6FnylX6agEA4Dey0rZUAMgA
PENmBQYhM3/SrUAwu5w6C89ZEpYe9Aw=
=MHHc
-----END PGP SIGNATURE-----

--CCh81suv761izdf7--
