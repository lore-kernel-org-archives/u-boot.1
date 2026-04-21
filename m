Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D4CF94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D750283936;
	Tue, 21 Apr 2026 23:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q8stTI/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A1083E36; Tue, 21 Apr 2026 22:45:45 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C5983E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 22:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbec19732eso4179839a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776804342; x=1777409142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/IslhEl1/KaufX7kg9pjLsgcXTMnpm1I7mgpj5nlkLw=;
 b=Q8stTI/N3RW1rzdQr+BbOkTYMXDDmWj4XvGWt4zwNarbaLQDgcAGHaRfy0ddODdmKw
 sx5702hMtazWH5PDSdkkg8jJXrDdnyTqm8qf7yqR+nBjRWiSQgZvxOqB19PZAGCDTjHo
 cPSMOSsu/zF4snyXTFbH0OyTAeqFZ8GoCURXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776804342; x=1777409142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IslhEl1/KaufX7kg9pjLsgcXTMnpm1I7mgpj5nlkLw=;
 b=bjoBkOM1E90+ObaCur2TBYOgMaQpGDtD77Jx3pvjt/fSU8jeCPGf0LZhv/S+KvmH/6
 izYRgr5q2V50H/omDnkS/Xzhh/4AFvAft2Qst9mOziaFvZLRNgI8Q4cBTKs9WKvHWgGS
 V+HcHB0oV8GL4SNjldsS22IkAEaD08luZNFf3iBe/2fWSBGmq++NjyEbt6SoonBrIboz
 4lpRnqEfMKKH4UvzDnud9jhErAxaF0310iPlWYnM74wEvs4yzLfhGyoAXYrfsl7MwUcP
 lavkjvelxfPpEVd53QaTHrt9W8xvS1rZosbjqp8e0bjTjhUfUDH2pJMgLOkGuyXHf+5T
 iavA==
X-Gm-Message-State: AOJu0YwfiNtKNtWaRskvnWKZfNOF2D174k0aTBCppwuT4/pSArpYWGMf
 0CVKhMhUiaLAhyxPrDN1WGSpEjSEBNu3HTHkFx/E+6dxdJhTo88nICksMur9irPNJik=
X-Gm-Gg: AeBDieufLnoX/DiK89dHvzwNIJ0A39nM1b4vBk4HRfnvokU6vu2rM4h2AKHoOKn3Gle
 SMhGLZtGG9ozQBm6JCJSgLWdSn0BuuoK3OXeB8DrIgLugHTOtmyIMT35cq71mbO5joGEC4HTkdN
 2wOureZWFTePFCnKcrtkNsPslv/QJ26WpWtwvw/GB6mdUmXtiGCrbB1zCRj/jMdMG7lVhKjSmpW
 IqAOvIqiob4RZSDxI6nf2vJJ34xsYq4zGq/VUJRKR81YzV7fFKkJbsKuPZrP+8DAZUkfiSLXasb
 jkC1DFslN6Mk/UZT5PU5m4tWXDKO6OJVnjDreQboBdFaH/MsRRhOqVjaP5H21ig6DqNkuej422B
 s6dGMs8OJpzoQ2qWkvkeluPMeIqAmXq7H9siw3ep/8iC3+NUg4P/T/yKH1FIVrFhoMEKqkyCo2i
 1RXyW9/oby/I92bUR5F/ym1gKasruS73L4ZZ+RwP+2T+iFEmwlMDMdKzCQuIvRbjMQ4rwkk7s8k
 sFEePD+QBdgbjUHPyXby2H0J+Quh8CDHAMBROFdiNmWtvKvik5nfODfWP14Wg==
X-Received: by 2002:a05:6830:67f4:b0:7dc:db04:d316 with SMTP id
 46e09a7af769-7dcdb04dba5mr2226522a34.8.1776804342055; 
 Tue, 21 Apr 2026 13:45:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975b057bsm13376857a34.20.2026.04.21.13.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:45:41 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:45:36 -0600
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
Message-ID: <20260421204536.GA41863@bill-the-cat>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-1-efee3f76754d@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aN8g6t4SnNVoW3mW"
Content-Disposition: inline
In-Reply-To: <20260421-qcom_spl-v3-1-efee3f76754d@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 21 Apr 2026 23:01:13 +0200
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


--aN8g6t4SnNVoW3mW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 09:43:44PM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Some platforms (e.g. least Qualcomm), use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  Makefile           | 10 ++++++++--
>  common/spl/Kconfig | 10 ++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 8af18668b0f..50893d5689e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2004,16 +2004,22 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>  quiet_cmd_u-boot-spl-elf ?=3D LD      $@
>  	cmd_u-boot-spl-elf ?=3D $(LD) spl/u-boot-spl-elf.o -o $@ \
>  	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> -	-T u-boot-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D$(CONFIG_SPL=
_TEXT_BASE) \
> +	-T spl/u-boot-spl-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D$(CO=
NFIG_SPL_TEXT_BASE) \
>  	-Ttext=3D$(CONFIG_SPL_TEXT_BASE)
> -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
>  	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-elf.o
>  	$(call if_changed,u-boot-spl-elf)
> =20
> +SPL_REMAKE_ELF_LDSCRIPT :=3D $(addprefix $(srctree)/,$(CONFIG_SPL_REMAKE=
_ELF_LDSCRIPT:"%"=3D%))
> +
> +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
> +	$(call if_changed_dep,cpp_lds)
> +
>  u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>  	$(call if_changed_dep,cpp_lds)
> =20
>  PHONY +=3D prepare0
> +
>  # MediaTek's ARM-based u-boot needs a header to contains its load address
>  # which is parsed by the BootROM.
>  # If the SPL build is enabled, the header will be added to the spl binar=
y,
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index d1a85f50209..1d279a2bb05 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -247,6 +247,16 @@ config SPL_HANDOFF
>  	  proper. Also SPL can receive information from TPL in the same place
>  	  if that is enabled.
> =20
> +config SPL_REMAKE_ELF_LDSCRIPT
> +	string "Linker script for SPL ELF"
> +	depends on SPL_REMAKE_ELF
> +	default "arch/$(ARCH)/u-boot-spl-elf.lds"
> +	help
> +	  This allows specifying a linker script that will act on u-boot-spl.bi=
n.
> +	  Some platforms (e.g Qualcomm) use the ELF format in creative ways,
> +	  including in the bootrom. For such platforms, you can change the defa=
ult
> +	  linker script to a platform-specific one.
> +
>  config SPL_LDSCRIPT
>  	string "Linker script for the SPL stage"
>  	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH_SUNIV

Did what I said about cleaning up the remake elf Makefile logic itself
get lost somewhere? Sorry. To repeat, we should have a remake elf
function, make use of $(PHASE_) and have Kconfig entries for both
REMAKE_ELF_LDSCRIPT and SPL_REMAKE_ELF_SCRIPT (so we can use $(PHASE_)
again to get the right one. Thanks!

--=20
Tom

--aN8g6t4SnNVoW3mW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaefh7QAKCRAr4qD1Cr/k
ChLYAQDP6v1VswnslrYiVJFvh4wVgDQYaRZxYu2YPl4L0pcfQwD+KWJ/oWgkumzo
T/s1enHKzLCHSonYrlLltMC4dKCd7AM=
=Hfhl
-----END PGP SIGNATURE-----

--aN8g6t4SnNVoW3mW--
