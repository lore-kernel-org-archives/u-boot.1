Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72552F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CE484474;
	Mon, 20 Apr 2026 22:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EplWihjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AC584319; Mon, 20 Apr 2026 20:05:49 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F77842BF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 20:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso2917661a34.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776708345; x=1777313145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+jwCh8XJmQcTXnBuUIf9A6vweFvRdttIduE6VojnMx4=;
 b=EplWihjvXd3g+10+bpCD3PMXMFKPYDDCM8aRN7wn/Z+vOsUPEN+TPdRitLtFqDHkee
 wulGNwxerSkhfdZg/6iAX6ONy0qXHT1SInNV6dJ57p5mnj/kjfoA6p3KftPO62PoPh+/
 O9kVigWo7amZfm/BnR9YWrl8y9MvkA+oXRI6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776708346; x=1777313146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jwCh8XJmQcTXnBuUIf9A6vweFvRdttIduE6VojnMx4=;
 b=YSwbyBfv9YZyeLuMVL21+KGQO1/kcg3eweL86Znm/HcKa8qHBzIlN5WX9N1A27DQqy
 cs5CQmfgvYssJIeYx9sdxoGKDfdsR1k0t4xgoKPwNSfQYaTez4dH1VMprAl3q22+etel
 feCLn4cwxP8UOKMK1fqd+zsGmlIUM6XFwz4lDCSRnTODT81zWCSMup71C66gDU6Zyrtk
 qNxTnlp10vd5IKPf4DDly41X6zXLbF4yf8ZwPYBN27g8fB/cVruMVqboDuYexqcLXH3f
 kPo96jxPQDsJUKxHERi+q8C2Jm09FN9eZ7edGrSW51aU7mfoG2faJonylTspA9rlFEbl
 FHnA==
X-Gm-Message-State: AOJu0YyboVTyTgVhEZtqYONPKghJQLSaoOPzE5WcXLRi3T/ENA6MrX1D
 STAZjoEaspdHoaG6rwEyxpomKdWx9iopFeE3AFFvm0poEeldORndunpuUqeZSL+K5U4=
X-Gm-Gg: AeBDieuXap101Dml4rVjNBjzERDOqraTOjHFLTIJFcYcv/y3PS5FeTydEBIZ8JAd0o4
 ytpHyRxBDdpZPmVMyuOhVRl1n0ZVqGT/sAssml+qT8RuiQEPMrY2qPzpG0/tm9zyZ5qkTjp3Zy0
 7ArtwDxGExAqvddmKeWHclPKi/onYCM1rlzEMZkWIGK6ZrtkLFNfkYPiJaqR2FGD8QHV+Kg1IoX
 dDCr8YwXzYdyJ5N5Vb4TTpT2M20jJwJL9tF0g8Z4uZ5QaZ72LPKSJCAyEWRm7vCN23RMnGp+cgY
 vwZFL/a6DBN4VdApiGa1P04zuNqNm2x+mJWdkwxtEVTOatq7n0TEXGfJr5EUeph3DE9gWS78Rdo
 U/JKwErUwdt3+akeT0VMX6Gpe+DI2Xi++idM/dCZcSuMpwGGx52JTUm2dLxkGvdP7kuaR3+1PYG
 yE+DHQ+pEb24mpmFvrHg09jxkMdmQHvo3BVi289Qzp36LUW0s9K7hx3Eqzw+UQSCZdH6efGd2qD
 KfsQZ0uxYP8XcQWbz8o9R9xyeD2O8B64/LjfsVqlTUKqEtEsdWMr7oy9gEf4A==
X-Received: by 2002:a05:6820:4dfc:b0:687:7e0e:c605 with SMTP id
 006d021491bc7-69462f6c0c5mr7799367eaf.58.1776708345520; 
 Mon, 20 Apr 2026 11:05:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69464fe4084sm6065288eaf.12.2026.04.20.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 11:05:44 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:05:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Srba <Michael.Srba@seznam.cz>
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
Subject: Re: [PATCH v2 06/10] mach-snapdragon: Kconfig: changes / additions
 to support SPL
Message-ID: <20260420180540.GW41863@bill-the-cat>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
 <20260413171717.GA41863@bill-the-cat>
 <596c73ef-b0ec-4543-bd06-ac3b18029edd@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oS89ctqYYTJRGGUJ"
Content-Disposition: inline
In-Reply-To: <596c73ef-b0ec-4543-bd06-ac3b18029edd@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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


--oS89ctqYYTJRGGUJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 03:01:22AM +0200, Michael Srba wrote:
> Hi,
>=20
> On 4/13/26 19:17, Tom Rini wrote:
> > On Sat, Apr 11, 2026 at 02:00:11AM +0200, michael.srba@seznam.cz wrote:
> >=20
> > > From: Michael Srba <Michael.Srba@seznam.cz>
> > >=20
> > > An SoC to target has to be selected, e.g. SPL_TARGET_SDM845.
> > > This will select reasonable defaults and enable per-SoC linker
> > > script (if required).
> > >=20
> > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > ---
> > >   arch/arm/Kconfig                 | 31 +++++++++++++++++++++++++++-
> > >   arch/arm/mach-snapdragon/Kconfig | 44 +++++++++++++++++++++++++++++=
+++++------
> > >   2 files changed, 68 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 03416c55265..8490e336516 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1138,9 +1138,38 @@ config ARCH_SNAPDRAGON
> > >   	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> > >   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> > >   	select SYSRESET
> > > -	select SYSRESET_PSCI
> > > +	select SYSRESET_PSCI if !SPL
> > >   	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> > >   	select MMU_PGPROT
> > > +	select SUPPORT_SPL
> > > +	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
> > > +	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
> > > +	select SPL_DM if SPL
> > > +	select SPL_DM_GPIO if SPL
> > > +	select SPL_DM_PMIC if SPL
> > > +	select SPL_DM_USB_GADGET if SPL
> > > +	select SPL_ENV_SUPPORT if SPL
> > > +	select SPL_GPIO if SPL
> > > +	select SPL_HAS_BSS_LINKER_SECTION if SPL
> > > +	select SPL_LIBCOMMON_SUPPORT if SPL
> > > +	select SPL_LIBDISK_SUPPORT if SPL
> > > +	select SPL_LIBGENERIC_SUPPORT if SPL
> > > +	select SPL_MMC if SPL
> > > +	select SPL_OF_REAL if SPL
> > > +	select SPL_OF_CONTROL if SPL
> > > +	select SPL_PINCONF if SPL
> > > +	select SPL_PINCTRL if SPL
> > > +	select SPL_PINCTRL_FULL if SPL
> > > +	select SPL_PINCTRL_GENERIC if SPL
> > > +	select SPL_PINCONF_RECURSIVE if SPL
> > > +	select SPL_PINMUX if SPL
> > > +	select SPL_SPRINTF if SPL
> > > +	select SPL_STRTO if SPL
> > > +	select SPL_USB_GADGET if SPL
> > > +	imply DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC
> > > +	imply SPL_EVENT if SPL_USB_DWC3_GENERIC
> > > +	imply OF_LIVE if USB_DWC3_GENERIC
> > > +	imply SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
> > >   	imply OF_UPSTREAM
> > >   	imply CMD_DM
> > >   	imply DM_USB_GADGET
> > This part looks good.
> >=20
> > > diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdra=
gon/Kconfig
> > > index 976c0e35fce..74d687ceee2 100644
> > > --- a/arch/arm/mach-snapdragon/Kconfig
> > > +++ b/arch/arm/mach-snapdragon/Kconfig
> > > @@ -11,18 +11,12 @@ config SYS_VENDOR
> > >   	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
> > >   	  will be used as the custom board directory.
> > > -config SYS_MALLOC_LEN
> > > -	default 0x10000000
> > > -
> > >   config SYS_MALLOC_F_LEN
> > >   	default 0x2000
> > >   config SPL_SYS_MALLOC_F
> > >   	default y
> > > -config SPL_SYS_MALLOC_F_LEN
> > > -	default 0x2000
> > > -
> > >   config SYS_MALLOC_LEN
> > >   	default 0x800000
> > > @@ -45,4 +39,42 @@ config SYS_CONFIG_NAME
> > >   	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h =
header
> > >   	  will be used for board configuration.
> > > +config SPL_SHARES_INIT_SP_ADDR
> > > +	default n
> > > +
> > > +config SPL_HAVE_INIT_STACK
> > > +	default y
> > > +
> > > +# SPL targets
> > > +
> > > +config SPL_TARGET_SDM845
> > > +	bool "Set reasonable default values for running SPL in SRAM on sdm8=
45 devices"
> > This namespace is confusing and so shouldn't be used. Does SDM845 get
> > used without SPL? We should probably follow the convention of adding a
> > new defconfig of <whatever board>_spl_defconfig, that enables the
> > options as needed.
> The rationale for this naming was that outside SPL, we don't currently
> discriminate between SoCs at compile time (there is some discrimination
> between legacy board support the and unified "board" which covers all
> non-legacy boards no matter the SoC, but for non-legacy boards there
> is just a single build of U-Boot proper, possibly with a board dtb
> appended if used as the primary bootloader). I suppose the SPL_ prefix
> may be confusing and isn't strictly necessary, and we may need a similar
> target option for msm8916 in the future which wouldn't be used in SPL
> but in u-boot proper, so it makes sense to get rid of the prefix.
>=20
> The reason we need this config option at all (even if we move all
> the Kconfig defaults that use it into the defconfig) is that the
> boot0.h is shared among all of mach-snapdragon, and we need a way
> to select which SoC-specific boot0.h we should include.
> Now, it does look like SYS_SOC is intended for stuff like this,
> however changing SYS_SOC from snapdragon seems to completely break
> the unified board support which isn't really worth it.
>=20
> Admittedly, it does seem that I somehow completely forgot to mention that
> use of the config option in both the commit message and the Kconfig,
> but it is effectively the only use it has left after moving everything
> into the defconfig.
>=20
> So, should I include an SoC selection menu similar to the board selection
> menus in e.g mach-exynos, which would now solely be used by the ifdef
> in boot0.h? Something like
> ```
> choice
> =A0 =A0 prompt "Qualcomm SoC select"
> =A0 =A0 default TARGET_NONE if !SPL
> =A0 =A0 help
> =A0 =A0 =A0 While U-Boot on Qualcomm platforms doesn't generally need com=
pile-time
> =A0 =A0 =A0 adjustment based on the target SoC, there are a few exception=
s to this.
> =A0 =A0 =A0 Currently this concerns boot0.h discrimination.
>=20
> config TARGET_NONE
> =A0 =A0 bool "Generic build"
> =A0 =A0 help
> =A0 =A0 =A0 Select this if you're not building SPL. U-Boot proper builds =
are currently
> =A0 =A0 =A0 generic across all SoCs.
>=20
> config TARGET_SDM845
> =A0 =A0 bool "SPL targeting the sdm845 SoC"
> =A0 =A0 help
> =A0 =A0 =A0 Select this if you are bulding u-boot SPL for sdm845.
> =A0 =A0 =A0 Currently this gates sdm845-specific boot0.h (only used in SP=
L).
>=20
> endchoice
> ```
>=20
> ... or do you have something else in mind? I'm not entirely sure if you're
> suggesting to get rid of TARGET_SDM845 completely (which I really don't s=
ee
> as possible at least without a lot of unnecessary pain) or just of it's
> use for the defaults.

That's for explaining more. The SPL_xxx namespace is generally reserved
so that we can do things like:
obj-$(CONFIG_$(PHASE)FOO) +=3D foo.o
in a Makefile, and have symbols for SPL_FOO, FOO (and TPL_FOO).

So I think your suggestion here is fine, pending feedback from the
snapdragon maintainers.

--=20
Tom

--oS89ctqYYTJRGGUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeZq8QAKCRAr4qD1Cr/k
CgbzAQCo5Et5Ru3vtrjCPIrQviHMPuaNeYcqZ0HQ0yJdgrcU6AEA8BI+MSQXMGI/
9Qv/lQqSUcK4yTD7PVNj7yoQbo088wE=
=A2vI
-----END PGP SIGNATURE-----

--oS89ctqYYTJRGGUJ--
