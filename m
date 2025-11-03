Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4404CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1975C8331F;
	Mon,  3 Nov 2025 16:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G5MB9OR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA2D8331F; Mon,  3 Nov 2025 16:37:04 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFC580050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c28bf230feso4933387a34.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762184220; x=1762789020; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ck8vD+HWfGmbqrBCyw5ZcJkokKHYED+GwB4Kapr8jjY=;
 b=G5MB9OR/aiAgerkd9cyhWrxouF+TBTkIFkk2MW5nqnSYYBMG+KXR7LHWC95pk0p5g2
 AB05kAWonwarWnPcPZgVVeVtw1hV6kkNXTu5FvOCaeo+Z+08FE9FCTeezeFkswPRPYhf
 6Ux3LYeYn421p9IZHvg/NopUudkRAEwD2MIgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762184220; x=1762789020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ck8vD+HWfGmbqrBCyw5ZcJkokKHYED+GwB4Kapr8jjY=;
 b=wv1NexB/5VY/TIz8xj88zuwAAteERiQ1HHtFWEKf59+t0k/OH9CdTxYv+IqPehEN7r
 Xhk3uroqTvcuFJUk6dbtLjwodaLurW98mxoacrR+wzLIPFPgDTp2BK3iDwxaJ1LZUMQq
 oIpKL3dhpvaUVSkmPP9BKp20RJkV6Sho88ya0bavC+j3+HInXHhhyDMFxoI8fziRzTAA
 tmZzQWVPpKP5h80fw/BfWiAlugp0qcC/+PShCLOGIVlsQQ8J2MWxmWGQqJh6mu6wzFwj
 kwswkM1jenGV5IXCU5oUHLLw+m2ykrsGJrVZrZY6k5CoHpjBg87wOwtnjciyX+3OJwDH
 3nLg==
X-Gm-Message-State: AOJu0Yw82g1/J5Su9I6R4j5PJsydnPkjqGFarpOsCiEz3ZNHexd7UpFP
 qM0u0z8qg/cZcfxaQ0LnbGu2cvA/6NqxtGBICmQk/avqOa6lDNcO8HHwOo+Z06zn2PM=
X-Gm-Gg: ASbGnctpjNBvPtCRC60Ej+1yrFeBd4UTO9c6dxP7T/55/YZmFaZUE1sH80Srlz7Wm+I
 oMwhea2kpZ57ZWT2Q17UqDKZ5rcBS8+ToZUuh9grwkG+RlM/dxGqawkTS8wu+I+84RQgy+cBKXL
 6bTValZdO7tLWp9GcI1TIOkSKMHeR2r0PF6+dsgcjzEW/Htfc6SddQltyVdOOCAvSYVDiikYWT5
 KvTALD669DuI9WbKvoOYZtL567yWYPq/4VB8Si5pg5iu8bx7aO7JKh/HIgGGRy+L9V3ZJN5VpYN
 TcYNC0K7Pkl2bv8qsk7lyjHynnd2VcMHYJGLkSF6aO/2yScVd9vv1JLyVU3upecCDW0UjQuZ3+R
 PKklcva1SW+SX4VK8KOBQffOO+ZLKajxNwZMRBNkSWRgVYKWAIZwR/LUaxLK0+a53+dYdbm3fKc
 U1GVZXO29OGvjJZ0q4jYCi5xwNv3GI7HXVZzHhZsO2O/+6fvOLFD2Fq1cG9Rp/
X-Google-Smtp-Source: AGHT+IGDfwJbXuIXykwOOIToE1VY+PKPv1CMot7z77ysx9V2KHFFr5XfiytREYEL4urxfOg+AzGauw==
X-Received: by 2002:a05:6808:3195:b0:443:f722:ec30 with SMTP id
 5614622812f47-44f88ad97b0mr7133726b6e.19.1762184220143; 
 Mon, 03 Nov 2025 07:37:00 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad41aec4sm165002eaf.14.2025.11.03.07.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:36:59 -0800 (PST)
Date: Mon, 3 Nov 2025 09:36:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103153657.GO6688@bill-the-cat>
References: <20251101035252.261-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wOd+7msmtklZx8Fl"
Content-Disposition: inline
In-Reply-To: <20251101035252.261-1-briansune@gmail.com>
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


--wOd+7msmtklZx8Fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 11:52:52AM +0800, Brian Sune wrote:

> Added new make command to support
> Altera GEN5 SoCFPGA handoff conversion.
> The new make qts_handoff_gen will use
> two parameters QTS_DIR and HANDOFF_DIR.
> Checking is done via .config SoCFPGA
> family selection and directory existency.
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  Makefile | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 750f8a84b1f..74474368413 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -484,6 +484,48 @@ CFLAGS_KERNEL	=3D
>  AFLAGS_KERNEL	=3D
>  LDFLAGS_vmlinux =3D
> =20
> +# Intel-Altera Gen5 SoCFPGA QTS Handoff generator target (detect SoC fro=
m .config)
> +QTS_HANDOFF_GEN_PY  :=3D $(CURDIR)/tools/cv_bsp_generator/cv_bsp_generat=
or.py
> +
> +# Detect SOC family from .config
> +SOC_FAMILY :=3D $(shell \
> +	if grep -q '^CONFIG_TARGET_SOCFPGA_CYCLONE5=3Dy' .config; then \
> +		echo cyclone5; \
> +	elif grep -q '^CONFIG_TARGET_SOCFPGA_ARRIA5=3Dy' .config; then \
> +		echo arria5; \
> +	elif grep -q '^CONFIG_TARGET_SOCFPGA_ARRIA10=3Dy' .config; then \
> +		echo arria10; \
> +	else \
> +		echo unknown; \
> +	fi)
> +
> +.PHONY: qts_handoff_gen
> +qts_handoff_gen:
> +	@if [ ! -f .config ]; then \
> +		echo "Error: .config not found. Run 'make <defconfig>' first."; \
> +		exit 1; \
> +	fi
> +	@if [ "$(SOC_FAMILY)" =3D "unknown" ]; then \
> +		echo "Error: Could not detect SoCFPGA family from .config"; \
> +		exit 1; \
> +	fi
> +	@if [ ! -d "$(HANDOFF_DIR)" ]; then \
> +		echo "Error: handoff directory '$(HANDOFF_DIR)' does not exist."; \
> +		exit 1; \
> +	fi
> +	@if [ -z "$(QTS_DIR)" ]; then \
> +		echo "Error: QTS_DIR is not defined."; \
> +		exit 1; \
> +	fi
> +	@if [ ! -d "$(CURDIR)/board/$(QTS_DIR)/qts" ]; then \
> +		echo "Creating QTS output directory: $(CURDIR)/board/$(QTS_DIR)/qts"; \
> +		exit 1; \
> +	fi
> +	@echo "=3D=3D=3D Detected SoCFPGA family: $(SOC_FAMILY) =3D=3D=3D"
> +	@echo "=3D=3D=3D Generating BSP to $(CURDIR)/board/$(QTS_DIR)/qts =3D=
=3D=3D"
> +	python3 $(QTS_HANDOFF_GEN_PY) -i $(HANDOFF_DIR) -o $(CURDIR)/board/$(QT=
S_DIR)/qts
> +	@echo "=3D=3D=3D QTS generation complete =3D=3D=3D"
> +
>  # Use USERINCLUDE when you must reference the UAPI directories only.
>  USERINCLUDE    :=3D \
>  		-I$(srctree)/arch/$(SRCARCH)/include/uapi \

OK. I was hoping that we could just automate as part of the regular
build process seeing for example $(BOARD)/foo.xml and invoking the
script to re-create foo.c and so forth, but that doesn't seem to be the
case. So, no Makefile logic. We should then instead start on some
content for doc/board/socfpga/ and document this tool there. Thanks!

--=20
Tom

--wOd+7msmtklZx8Fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQjMGQAKCRAr4qD1Cr/k
ChMAAP46IXHnfreOWyCgvAF6BYS5pX8JPIQ7k9CdSGlZt1+r9QD/TVWE/mnbFNrK
a4NHHKt11x09BY/mWh1w/6y7A1fwigI=
=rzOh
-----END PGP SIGNATURE-----

--wOd+7msmtklZx8Fl--
