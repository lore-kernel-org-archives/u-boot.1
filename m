Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265F9FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C9384154;
	Sat, 25 Apr 2026 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j8gXFnkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97C6842E7; Sat, 25 Apr 2026 18:43:43 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483CB842CE
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8a1e1817db6so70952836d6.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777135420; x=1777740220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+dBloXwBkYDV74zc0S1akg1ibsT/+C7OPPsTFBcH79o=;
 b=j8gXFnkJ8Dybh/+IYXJPZPAUiWFXEF9EeqB6b7QgSAdel3Sxc90rT1atKhZgbGtF0t
 qBnAmnNYHKreXTLtltYEsIrFxIVHz+NEgUAekq3JG65eVocXCtmMnPwtnw+jpM/pBK6V
 TtgAiBbaH0sb4v3sRHSzoMJnZFloi8S1MCtSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135420; x=1777740220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dBloXwBkYDV74zc0S1akg1ibsT/+C7OPPsTFBcH79o=;
 b=PvJhgoMjUj0oGxNnW7QtNcONwt7HRYBUiPfLKLrn4/Vf0pKszXKtri3hBvO+p475mN
 srQpOfRCrBHtPerLfifFNcuGyGqvcDno7nru1zShkTnVQ/Z/mrDD7LaGFMv61rHvtSM7
 x4/3JdE4bKe1BL8ieMeZH1hfpSh9ay0jaukkWkX0kvMTUiW8wC8deS9VxSrK0hv6WG/g
 0cqEDLTHWaHLSmzbQZ6DsapKrFPWX+mjjdJrXwA8aEhMOgO4WdMd03YtxyT2MvztcNWj
 vKhY9/+VLYQCtNpUN120O/NMBe6dJL6MJ1GpPHbqeY5SCbJbCXfNeyZEpXQzmDY6rS3y
 DxKQ==
X-Gm-Message-State: AOJu0YwDr8zWfPqHY62hK4yQx8UUCUzIpwPhWnUQOfepDvDF6ZaQavgm
 CVqry9Ihuc3J+HeVoXfQoqJXmokauf8dk5ITgVt6irBXbHdT5mxJBFPDpaQVMFqxCZV6qtjm/74
 SxnfSzGTdTg==
X-Gm-Gg: AeBDiesNGVcEXiY5/rseL9diZEQVxuJomci5U1yE+JguOtOvRvs2iObN2LpBU694j6r
 K9aRc1a7pWSyrjXfcw2nfEITklFVaDfb1GT3W+G09cW1i3lCtFyBpcaydraQrB45d0JruoXtUAe
 zC874DgLV+xtUfe8+6pBpacC0l+++MNAqu4ZXerttwVFvRcxFC0fUXS+/ffPozfcGkZZYmFMPjT
 s8Wa9gLDFqYOnVo7LNBfPez/g352mlrRi20VV6M0bBP+4UGCgRY+N3KAhBADkEJrk1IDCuUElQN
 sVkdITqyzMC+6uJqKP36AK7CXfElyJoGGe4ofnZY3CLF3OHhI2HMYBJrwTY+NjkkSqkmZgJt2Bg
 TGGVX70vJ5Eb5Amzf5KyZGYyX/Bd4Fr5fu5hVEXgT4NrpnzARPADyzca5RocBupJknRW5wk1Tqc
 yCI3utvB1fLWN+7FpvDN/0UA+FuaA+sOu/LDzfB36qiTWe3ye1lsGA9aKy2BezvshPzvkwATHD0
 gtTTJ8Upm9byN0EQvZ11/6S4/VDO0kHuqGwOICr1p8bt8v20PogIY26J4CIGA==
X-Received: by 2002:a05:6808:200a:10b0:479:a908:5f50 with SMTP id
 5614622812f47-479a908611emr11810298b6e.40.1777047600860; 
 Fri, 24 Apr 2026 09:20:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcce5feb25sm11860440a34.26.2026.04.24.09.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:20:00 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:19:55 -0600
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
Message-ID: <20260424161955.GJ41863@bill-the-cat>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-1-efee3f76754d@seznam.cz>
 <20260421204536.GA41863@bill-the-cat>
 <68690d5a-e48c-4ff7-920f-f0d4b65f5bec@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a0LpO9bJ83tSK7E0"
Content-Disposition: inline
In-Reply-To: <68690d5a-e48c-4ff7-920f-f0d4b65f5bec@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:12 +0200
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


--a0LpO9bJ83tSK7E0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 02:14:42AM +0200, Michael Srba wrote:
> Hi,
>=20
> On 4/21/26 22:45, Tom Rini wrote:
> > On Tue, Apr 21, 2026 at 09:43:44PM +0200, michael.srba@seznam.cz wrote:
> >=20
> > > From: Michael Srba <Michael.Srba@seznam.cz>
> > >=20
> > > Some platforms (e.g. least Qualcomm), use the ELF format in creative
> > > ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker scri=
pt
> > > specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded p=
ath
> > > as the default).
> > >=20
> > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > ---
> > >   Makefile           | 10 ++++++++--
> > >   common/spl/Kconfig | 10 ++++++++++
> > >   2 files changed, 18 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 8af18668b0f..50893d5689e 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2004,16 +2004,22 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
> > >   quiet_cmd_u-boot-spl-elf ?=3D LD      $@
> > >   	cmd_u-boot-spl-elf ?=3D $(LD) spl/u-boot-spl-elf.o -o $@ \
> > >   	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> > > -	-T u-boot-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D$(CONFIG=
_SPL_TEXT_BASE) \
> > > +	-T spl/u-boot-spl-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D=
$(CONFIG_SPL_TEXT_BASE) \
> > >   	-Ttext=3D$(CONFIG_SPL_TEXT_BASE)
> > > -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> > > +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
> > >   	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-spl-el=
f.o
> > >   	$(call if_changed,u-boot-spl-elf)
> > > +SPL_REMAKE_ELF_LDSCRIPT :=3D $(addprefix $(srctree)/,$(CONFIG_SPL_RE=
MAKE_ELF_LDSCRIPT:"%"=3D%))
> > > +
> > > +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
> > > +	$(call if_changed_dep,cpp_lds)
> > > +
> > >   u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
> > >   	$(call if_changed_dep,cpp_lds)
> > >   PHONY +=3D prepare0
> > > +
> > >   # MediaTek's ARM-based u-boot needs a header to contains its load a=
ddress
> > >   # which is parsed by the BootROM.
> > >   # If the SPL build is enabled, the header will be added to the spl =
binary,
> > > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > > index d1a85f50209..1d279a2bb05 100644
> > > --- a/common/spl/Kconfig
> > > +++ b/common/spl/Kconfig
> > > @@ -247,6 +247,16 @@ config SPL_HANDOFF
> > >   	  proper. Also SPL can receive information from TPL in the same pl=
ace
> > >   	  if that is enabled.
> > > +config SPL_REMAKE_ELF_LDSCRIPT
> > > +	string "Linker script for SPL ELF"
> > > +	depends on SPL_REMAKE_ELF
> > > +	default "arch/$(ARCH)/u-boot-spl-elf.lds"
> > > +	help
> > > +	  This allows specifying a linker script that will act on u-boot-sp=
l.bin.
> > > +	  Some platforms (e.g Qualcomm) use the ELF format in creative ways,
> > > +	  including in the bootrom. For such platforms, you can change the =
default
> > > +	  linker script to a platform-specific one.
> > > +
> > >   config SPL_LDSCRIPT
> > >   	string "Linker script for the SPL stage"
> > >   	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH_SUNIV
> > Did what I said about cleaning up the remake elf Makefile logic itself
> > get lost somewhere? Sorry. To repeat, we should have a remake elf
> > function, make use of $(PHASE_) and have Kconfig entries for both
> > REMAKE_ELF_LDSCRIPT and SPL_REMAKE_ELF_SCRIPT (so we can use $(PHASE_)
> > again to get the right one. Thanks!
> >=20
> Trying to figure this out, I feel like I must be missing something...
> It seems like $(PHASE_) is never going to be anything other than an empty
> string inside the main Makefile?
> While `libs-$(CONFIG_$(PHASE_)ALTERA_SDRAM) +=3D drivers/ddr/altera/` wou=
ld
> make me think otherwise, most of the contents of the toplevel Makefile
> strongly suggest that it's only ever executed once, rather than one time
> for each of u-boot proper, spl, tpl, vpl. I have tried to use $(PHASE_)
> anyway, but it really doesn't seem to work. Could you explain more
> specifically how I should do this?

I had thought this would work, yes. Does this mean the other cases of
$(PHASE_) in the top-level Makefile also aren't working? And, is there
some other Makefile where $(PHASE_) does indeed work, that we could move
this particular logic to?

--=20
Tom

--a0LpO9bJ83tSK7E0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeuYKAAKCRAr4qD1Cr/k
CtcwAP9i8fuHB1Z+L3ftjohrPmPdQNRIQuoksNDEY3iGbdUmLgEAyIQfMajxXawZ
ayWbFh3nVtlnxK6YdIdOpqmh8GuX4As=
=b1pU
-----END PGP SIGNATURE-----

--a0LpO9bJ83tSK7E0--
