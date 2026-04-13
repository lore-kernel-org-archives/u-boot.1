Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263FEF531CA
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D328839D5;
	Mon, 13 Apr 2026 23:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fXe/HgoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAC9839DF; Mon, 13 Apr 2026 19:12:48 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C868352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d1872504cbso4206758a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776100365; x=1776705165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n6muvBam7nUhAZW3PnrpKXUtDBoHBIjwSUsEGZNSufY=;
 b=fXe/HgoXYV1Lm/9NZ62SMOTRPFToJv4Qcl4n4QaTqtRf9yzP2zFKDyplih6U3O0U1M
 szQCPRsfmSmSMmG+Atopn7fEKafnaB2xKdmpA5Y7rvb253TSgxng+vy+UxuIkK6T3EHf
 VJfc1wX0aP/YY+hK7paJXLioccE4IIg49SLlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100365; x=1776705165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6muvBam7nUhAZW3PnrpKXUtDBoHBIjwSUsEGZNSufY=;
 b=BGo+vZBBiQtQ9+VZE5iwkb5H+XE0cDJzH9KqaLXV5pvy662wNV/WvdcXtUt0tNx9Tv
 M8E1p6DK3yI2uaCjYP5Ylb8ruWL1kv3lxBm5F4qmOzF950oKq2AlF9NXgJMAWyteSDUn
 yrKjfe5gnvwFd/ipUXUbJ4C94zlcxoIqblTDHAOnCWDWkrjLl4D+Zwh75B1ixD+cNgVQ
 3wuNgi2f+qZ67cuTFQKGaH1O56cAs1aQgEd6UzfV/XT8SP0GIv+Lcd8vstn75IsdC3wn
 hEd+FrzLsExy2GTuygxz4NlOputHTbMNBPH2tLRNCFhEJEn2NJUO1F0BLe6sNGijGLQU
 of9Q==
X-Gm-Message-State: AOJu0YwuKzuqoy35tQS77m8duN37Ffh0FlVGQ7LSx2M7Oy43Hq46Xxli
 pMnwfLsXVfwBWB7Y0VwLUUTJPnl2EaQvCdTVWiku1dzHwHBei+eEbEy5el6fGO/yOqU=
X-Gm-Gg: AeBDievwI10hX5v7ADWVKG69gKoy7YEYpGXZXBqKxZEoOfg3j1mdZc6vqdLXufGY9GD
 /IoIN0swbBY6ktQ+oEGTYSeJJR89uSIMvpXYi2XhuDK2/R9PMb/UjXad7JuaNJ3xzaLeA/dUq34
 QXq284ZNk0prVaq/O4sh0qTw5bHUx0fSK7MqWy9KMrfwMJzZYAN8x4q3Jk4oO+v4/i96aDqaLqz
 MY1OhQTbrxLHC2wSGxhZpo7HQNGb9LrnNefKPVqLFAxDv5EUQI2QXWuc+IGo2agaIgcBr3YepsO
 8zWWS5bp6mLTDJMQ1Mjjo7gSs135xr1bEDj1Gg8sqQqlT8lL2u3EyUvbxsUTq6BxYmMxBm+tk8o
 2kK7SzGbWvtv8T7dq3OqbUjutwM6gGLpYEu69Ie2uRC7GwbSqFZJ0vOcrvBFarKHEnVRVNrVEQc
 KvCPBbbzE05XkceH1pj62t5EO/vV1qdzG4OB7vp9Z6jPAnBC4xhPzraKP2/7yT5o3OlklEoyRw0
 oz2EVbEvRj+aE434Rytqv+LaMHnh1BiRtOdA5SaZ0d5XisFKaE=
X-Received: by 2002:a05:6830:6da6:b0:7d7:f3d1:d701 with SMTP id
 46e09a7af769-7dc1762da55mr7789946a34.6.1776100364998; 
 Mon, 13 Apr 2026 10:12:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc26907f82sm9557622a34.17.2026.04.13.10.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:12:44 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:12:40 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Subject: Re: [PATCH v2 01/10] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
Message-ID: <20260413171240.GY41863@bill-the-cat>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-1-9609557cf562@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lR4kkx6+/WPVb6iY"
Content-Disposition: inline
In-Reply-To: <20260411-qcom_spl-v2-1-9609557cf562@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 13 Apr 2026 23:13:56 +0200
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


--lR4kkx6+/WPVb6iY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 02:00:06AM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> On some platforms (at least Qualcomm), the bootrom expects an ELF file.
> Since the contents of the ELF file are platform specific, add a config
> option that allows specifying a linker script to use to produce the
> ELF file.
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  Makefile           | 28 ++++++++++++++++++++++++++++
>  common/spl/Kconfig |  9 +++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 8af18668b0f..754ca4d67e2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1232,6 +1232,9 @@ INPUTS-$(CONFIG_SPL) +=3D $(CONFIG_SPL_TARGET:"%"=
=3D%)
>  endif
>  INPUTS-$(CONFIG_REMAKE_ELF) +=3D u-boot.elf
>  INPUTS-$(CONFIG_SPL_REMAKE_ELF) +=3D spl/u-boot-spl.elf
> +ifneq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
> +INPUTS-y +=3D spl/u-boot-spl.elf
> +endif
>  INPUTS-$(CONFIG_EFI_APP) +=3D u-boot-app.efi
>  INPUTS-$(CONFIG_EFI_STUB) +=3D u-boot-payload.efi
> =20
> @@ -2001,6 +2004,8 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>  	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< u-boot-elf.o
>  	$(call if_changed,u-boot-elf)
> =20
> +ifeq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
> +
>  quiet_cmd_u-boot-spl-elf ?=3D LD      $@
>  	cmd_u-boot-spl-elf ?=3D $(LD) spl/u-boot-spl-elf.o -o $@ \
>  	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> @@ -2010,10 +2015,33 @@ spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf=
=2Elds
>  	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
>  	$(call if_changed,u-boot-spl-elf)
> =20
> +endif
> +
>  u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>  	$(call if_changed_dep,cpp_lds)
> =20
>  PHONY +=3D prepare0
> +
> +ifeq ($(CONFIG_SPL),y)
> +ifneq ($(CONFIG_SPL_REMAKE_ELF_LDSCRIPT),)
> +
> +SPL_REMAKE_ELF_LDSCRIPT :=3D $(addprefix $(srctree)/,$(CONFIG_SPL_REMAKE=
_ELF_LDSCRIPT:"%"=3D%))
> +
> +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
> +	$(call if_changed_dep,cpp_lds)
> +
> +quiet_cmd_u-boot-spl-elf ?=3D LD      $@
> +	cmd_u-boot-spl-elf ?=3D $(LD) spl/u-boot-spl-elf.o -o $@ \
> +	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> +	-T spl/u-boot-spl-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D$(CO=
NFIG_SPL_TEXT_BASE) \
> +	-Ttext=3D$(CONFIG_SPL_TEXT_BASE) -z max-page-size=3D0x1000
> +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
> +	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
> +	$(call if_changed,u-boot-spl-elf)
> +
> +endif
> +endif
> +
>  # MediaTek's ARM-based u-boot needs a header to contains its load address
>  # which is parsed by the BootROM.
>  # If the SPL build is enabled, the header will be added to the spl binar=
y,
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index d1a85f50209..f8981cb4fe5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -247,6 +247,15 @@ config SPL_HANDOFF
>  	  proper. Also SPL can receive information from TPL in the same place
>  	  if that is enabled.
> =20
> +config SPL_REMAKE_ELF_LDSCRIPT
> +	string "Linker script to run with u-boot-spl.bin as input"
> +	depends on !SPL_REMAKE_ELF
> +	help
> +	  This allows specifying a linker script that will act on u-boot-spl.bi=
n.
> +	  Some platforms (e.g Qualcomm) use the ELF format in creative ways,
> +	  including in the bootrom. Unlike SPL_REMAKE_ELF which uses a standard
> +	  linker script, this allows specifying a platorm-specific one.

This is starting to get a little odd. I think we need a pre-requisite
series to cleanup the remake elf logic, so that:
- The lds used is configured in Kconfig (and the default is the current
  one everyone else uses).
  - If we can have different ones for full U-Boot, or SPL
- The Makefile has a broken out the logic for doing the relink itself.

--=20
Tom

--lR4kkx6+/WPVb6iY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0kBAAKCRAr4qD1Cr/k
ChlyAQDxqN8lQKc3csjjtbI7AXT1qicivefyZkPQV1Qh8wgLVQEA1bFu61/raPwc
R2WcLBZel0dVLRs8EuBW+OyY10SlZAI=
=KPuL
-----END PGP SIGNATURE-----

--lR4kkx6+/WPVb6iY--
