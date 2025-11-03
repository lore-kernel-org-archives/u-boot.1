Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59E4CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36798838A5;
	Mon,  3 Nov 2025 23:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aLN4j5OB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEE1838D7; Mon,  3 Nov 2025 23:33:52 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4AC8144A
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74526ca79beso3482949a34.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762209229; x=1762814029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=reljXWJCNLTgH3w8InYFgQifnWNaaVW4B4Wh9qcK0FI=;
 b=aLN4j5OBtlRxeJ7OrOqaf2rcqOxslDbkCtJycF4kY0C0GJIluRcCW7Lwrl5nQnhn5D
 tl4oSOBqPIe+FwfO8gaunTEH5JJqmn6CiqBFOHpyDMgmRq7WO3zrnp6xGy0oQ8zhaaI1
 pWzomRkvpvs7stI7MGoxp4yCUKo/bKnWL+o04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762209229; x=1762814029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reljXWJCNLTgH3w8InYFgQifnWNaaVW4B4Wh9qcK0FI=;
 b=f06gWDje2QvvnDwm5J2d4dyHQISQJFCA24kKQ3LssiyHlVlNyWnsHSCQVDyKqCLtyo
 SkzmZfe4xPt1W70yIGnlXUmjZYvkzpHoFBt6ZBH2tZoUn1YnPax3FVTPpPeEgjll728t
 gvLC3h9i0OzoSujhUqUgY5UmeD4UGBW3J5deORiS/bculkiCWyon9m2XF0XwER7Z0YUS
 2SC7FZ/WswqE5mLT33AET9f0poufWKQEJsHcwmEGYzyUbE3tYauC1EIiJP+YbQEcs+V3
 scYRK5VzZQ7sSRCmDLTv8HS0jLx93oPrMmijGJn6L3F6m5oTwskkEhMk6FxswFwHcehY
 UkCw==
X-Gm-Message-State: AOJu0Yw/r3oWQxJK7jr/0JGK+TWdxE6Yop6sWmZOvwrIBI/nw57ahrsU
 nYFXZ2MKgM6eTLr3qrtlXEiORt+BY3mNASFmHL7kvwS2LLm5uhfeTEcGBO7MBYHd2CiqCof7nQd
 uOu87rB5pTw==
X-Gm-Gg: ASbGncuZS+vUxDtzfY/LeVj0j2R2wsQ4xOw2IL4FOOZK8502W5HdDf1FTSrMWoaferH
 k3L3F3uDcQiurEcEnxJ1pf/orRp98rDc8BsHODqqNnIDcRheg7sfQ1KDgRb4pPUnY8NgwYirgw8
 RKYmkFkpP0utxNa+Hu/AbWWyqDHMFZtYcinhWmbMv/Re8wHao27bS5d2+l7BsSi4e4LgZlln9Vd
 xRXzuFUGROLaVsldLlylA7ZeTqjUfEVnRv2EaBA9hbWFs7U64CItGfFuV1AanTJr2H+6gN7CwoY
 vlLGKKm9ERBXEhaqfOj+/RZpKbn3linNbVyHVvA73bOZxpDm4XLKtDcI79C3l40gRJB/pqF24Nr
 BKkpqmEKba1leFMzg1Qf+BxRHZmJUDBuezswvca1Fe3+rbSNtuivZdzoac8FvbU4J+88Ja3018G
 D9e324bnWmdpiRTE4daC2r89bEj5ekAHHpBjJIA44=
X-Google-Smtp-Source: AGHT+IHTE+eRE4qeegqrWw1sAny4XhAV/40IVQvLuqUV2DzbfLSaIFTh7cicK6naThiwp2AdPqXQGw==
X-Received: by 2002:a05:6830:3805:b0:745:a21c:6a57 with SMTP id
 46e09a7af769-7c6967b4676mr7723778a34.21.1762209228780; 
 Mon, 03 Nov 2025 14:33:48 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c24fff45sm506675a34.26.2025.11.03.14.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:33:47 -0800 (PST)
Date: Mon, 3 Nov 2025 16:33:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103223346.GU6688@bill-the-cat>
References: <20251103222840.458-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TGQ9Ub+oo1rR4AWd"
Content-Disposition: inline
In-Reply-To: <20251103222840.458-1-briansune@gmail.com>
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


--TGQ9Ub+oo1rR4AWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 06:28:40AM +0800, Brian Sune wrote:
> Introduce socfpga_gen5_handoff_prepare target in U-Boot Makefile
> Automatically detects Altera/Intel SoCFPGA boards from .config
> Checks for presence of hps_isw_handoff folder and .hiof files
> Runs BSP generator script tools/cv_bsp_generator/cv_bsp_generator.py=20
> if files exist.
> Non-blocking: prepare continues even if handoff folder or files are missi=
ng
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  Makefile | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 750f8a84b1f..32568a6c477 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2158,7 +2158,7 @@ scripts: scripts_basic scripts_dtc
>  # archprepare is used in arch Makefiles and when processed asm symlink,
>  # version.h and scripts_basic is processed / created.
> =20
> -PHONY +=3D prepare archprepare prepare1 prepare3
> +PHONY +=3D prepare archprepare prepare1 prepare3 socfpga_g5_hanoff_prepa=
re
> =20
>  # prepare3 is used to check if we are building in a separate output dire=
ctory,
>  # and if so do:
> @@ -2190,8 +2190,45 @@ archprepare: prepare1 scripts
>  prepare0: archprepare
>  	$(Q)$(MAKE) $(build)=3D.
> =20
> +# Intel-Altera SoCFPGA GEN5 prepare handoff file conversion
> +socfpga_g5_hanoff_prepare:
> +	@VENDOR=3D$$(grep -E '^CONFIG_SYS_VENDOR=3D' .config | cut -d'"' -f2); \

This won't work with separate object directories. Please give things a
spin with "make O=3D/tmp/somedir". It also looks like it's going to impact
every board, and either fail or add some build time? Make sure both say
"sandbox" and "qemu_arm" both build at least, if not a full CI run.
Thanks!

--=20
Tom

--TGQ9Ub+oo1rR4AWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQktxgAKCRAr4qD1Cr/k
Cu61AQDG5v+JiJEPRLDAFc+8txQQ0tbK13cRKqCAaY1FPOwA/gEAjXfo4Fv4E4U0
09rdY54fdvUW+smNXlCJXk/Ynfnn9Qc=
=sVxq
-----END PGP SIGNATURE-----

--TGQ9Ub+oo1rR4AWd--
