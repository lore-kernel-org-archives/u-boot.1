Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E7FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA9584559;
	Sat, 25 Apr 2026 22:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OLT+2kOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4457084154; Sat, 25 Apr 2026 21:58:42 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05E284154
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-606045ef716so6380144137.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777147119; x=1777751919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ym9g85/fS7P9zGp4hRu4Z0Oo5nrJqjNHRR5CLRO62c=;
 b=OLT+2kOnw2gwuSe4DGcqM2k1OBTmk2iJPta/g8at0ruQKz06JjbxS4AWTgpFjXQi2u
 n+e/sChPIeriLp9VeVIVWzlnUVZc1p2WkeajwZRAJLfnSK3MKOja7godDEO36bSYk9uz
 zELUHaDe4VHgcWaziD5FwVI++9pp6TLoYvQZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777147119; x=1777751919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Ym9g85/fS7P9zGp4hRu4Z0Oo5nrJqjNHRR5CLRO62c=;
 b=GS7/mW9zjzQenAMYnVq6JmVZDNJkL29AFyrUaIdR8+dmDsPLE5NuJBD0Q4OrS4cJva
 s4JAkKenGzdNkWYPvjCQ5+d+B6lBPJHyCZ+y1xkBwyvRrga/sY1i+Cjp6nnMR1FM5p2h
 khSlpUjATaCLUlBbes7j4ozlxHS9/ES4814QYJe/AOWUHdA5aIuf+x6m0JmAmrcHXQ7F
 1TxAjfC5+Qm5veZPlbsV3DvsfyprKGFSzASaS6RuC88L0bFB2tqp9rrjUZml30NnnHhv
 KFvXLyUHSTfIb3WVtlWMga1VnDplVFF+BgtWRWnjHFoop50fyRYcSXs5TvrWETEftew3
 FIkg==
X-Gm-Message-State: AOJu0YzoKmJ7e69TYGnnbIG43IiuRIRp+vD2u4vrk9wIGsNTy558ViJ5
 1VWspPP+VgU72QSzRLxa5FF88r2uclwyJEtbRS/eP53u/abWlDXtwJ8vcNF6OoHCNXoVIoamDSE
 K/xtSkW3g9Q==
X-Gm-Gg: AeBDiesoaDCR0OVVEPb/eH6Sf7YvffSdIGvVtnOFL6/cPfloSxbPq9Ca0da490YSNkY
 EqXlReL1lezp+08ZHumq92KHBJgOLcN+N3TJ237sc5Y8ZD7wT73spMGz5k98O2VoluWKO1zpO8h
 S6wXKUjrcPAzXDjuPqTc5XP0tUdJ8+mt91bxfgE+9sJ1p5z6/a8a3xiBONcCeS2UMO9/gtVP7kT
 l3fm+qpA/fwLdHggDAcxVFZ2ExFPeCpkLeuOaTcDPa33rqGWecnlg0Aeo3HDn9eUA7iyBQrSdS/
 XM27qs2NjfIDCurYCEZgi6lTIa02W8DaC+754Qvag6VOA+NiJq5Uei/tr2hpqffbGAO25LqOBSh
 PAaaRR0CQt+ciEmADR7XfAtnjmR7XbUt+rbyqPka9kLtxdysPhazELBzAXE+FP8RfeUKZIYSG3/
 X4Wrt3C8udBnoQ4FaoJQlUDrI5DmzhkEeuo18A3TPb54Ng8OueVurz/3BoJOAX3QTuss51XuN1K
 KoVp7CKKAQf6i8Wf46giXKeEWr0tNweZvcxusxAabgf9bKeRhAso8Z4rABLLEML94I34j3C
X-Received: by 2002:a05:6830:6d19:b0:7dc:67:8c9b with SMTP id
 46e09a7af769-7dc94fb1193mr21901330a34.4.1777053389976; 
 Fri, 24 Apr 2026 10:56:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dccfe912edsm11477106a34.16.2026.04.24.10.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 10:56:29 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:56:25 -0600
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
Message-ID: <20260424175625.GK41863@bill-the-cat>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-1-efee3f76754d@seznam.cz>
 <20260421204536.GA41863@bill-the-cat>
 <68690d5a-e48c-4ff7-920f-f0d4b65f5bec@seznam.cz>
 <20260424161955.GJ41863@bill-the-cat>
 <07351632-4572-4bd0-890b-c162ef0ba5d4@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PJ/o4Btbo/vniUBN"
Content-Disposition: inline
In-Reply-To: <07351632-4572-4bd0-890b-c162ef0ba5d4@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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


--PJ/o4Btbo/vniUBN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 07:05:03PM +0200, Michael Srba wrote:
> Hi,
>=20
> On 4/24/26 18:19, Tom Rini wrote:
> > On Fri, Apr 24, 2026 at 02:14:42AM +0200, Michael Srba wrote:
> > > Hi,
> > >=20
> > > On 4/21/26 22:45, Tom Rini wrote:
> > > > On Tue, Apr 21, 2026 at 09:43:44PM +0200, michael.srba@seznam.cz wr=
ote:
> > > >=20
> > > > > From: Michael Srba <Michael.Srba@seznam.cz>
> > > > >=20
> > > > > Some platforms (e.g. least Qualcomm), use the ELF format in creat=
ive
> > > > > ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker =
script
> > > > > specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcod=
ed path
> > > > > as the default).
> > > > >=20
> > > > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > > > ---
> > > > >    Makefile           | 10 ++++++++--
> > > > >    common/spl/Kconfig | 10 ++++++++++
> > > > >    2 files changed, 18 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 8af18668b0f..50893d5689e 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -2004,16 +2004,22 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FOR=
CE
> > > > >    quiet_cmd_u-boot-spl-elf ?=3D LD      $@
> > > > >    	cmd_u-boot-spl-elf ?=3D $(LD) spl/u-boot-spl-elf.o -o $@ \
> > > > >    	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> > > > > -	-T u-boot-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY)=3D$(CO=
NFIG_SPL_TEXT_BASE) \
> > > > > +	-T spl/u-boot-spl-elf.lds --defsym=3D$(CONFIG_PLATFORM_ELFENTRY=
)=3D$(CONFIG_SPL_TEXT_BASE) \
> > > > >    	-Ttext=3D$(CONFIG_SPL_TEXT_BASE)
> > > > > -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> > > > > +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds
> > > > >    	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< spl/u-boot-s=
pl-elf.o
> > > > >    	$(call if_changed,u-boot-spl-elf)
> > > > > +SPL_REMAKE_ELF_LDSCRIPT :=3D $(addprefix $(srctree)/,$(CONFIG_SP=
L_REMAKE_ELF_LDSCRIPT:"%"=3D%))
> > > > > +
> > > > > +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
> > > > > +	$(call if_changed_dep,cpp_lds)
> > > > > +
> > > > >    u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
> > > > >    	$(call if_changed_dep,cpp_lds)
> > > > >    PHONY +=3D prepare0
> > > > > +
> > > > >    # MediaTek's ARM-based u-boot needs a header to contains its l=
oad address
> > > > >    # which is parsed by the BootROM.
> > > > >    # If the SPL build is enabled, the header will be added to the=
 spl binary,
> > > > > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > > > > index d1a85f50209..1d279a2bb05 100644
> > > > > --- a/common/spl/Kconfig
> > > > > +++ b/common/spl/Kconfig
> > > > > @@ -247,6 +247,16 @@ config SPL_HANDOFF
> > > > >    	  proper. Also SPL can receive information from TPL in the sa=
me place
> > > > >    	  if that is enabled.
> > > > > +config SPL_REMAKE_ELF_LDSCRIPT
> > > > > +	string "Linker script for SPL ELF"
> > > > > +	depends on SPL_REMAKE_ELF
> > > > > +	default "arch/$(ARCH)/u-boot-spl-elf.lds"
> > > > > +	help
> > > > > +	  This allows specifying a linker script that will act on u-boo=
t-spl.bin.
> > > > > +	  Some platforms (e.g Qualcomm) use the ELF format in creative =
ways,
> > > > > +	  including in the bootrom. For such platforms, you can change =
the default
> > > > > +	  linker script to a platform-specific one.
> > > > > +
> > > > >    config SPL_LDSCRIPT
> > > > >    	string "Linker script for the SPL stage"
> > > > >    	default "arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds" if MACH=
_SUNIV
> > > > Did what I said about cleaning up the remake elf Makefile logic its=
elf
> > > > get lost somewhere? Sorry. To repeat, we should have a remake elf
> > > > function, make use of $(PHASE_) and have Kconfig entries for both
> > > > REMAKE_ELF_LDSCRIPT and SPL_REMAKE_ELF_SCRIPT (so we can use $(PHAS=
E_)
> > > > again to get the right one. Thanks!
> > > >=20
> > > Trying to figure this out, I feel like I must be missing something...
> > > It seems like $(PHASE_) is never going to be anything other than an e=
mpty
> > > string inside the main Makefile?
> > > While `libs-$(CONFIG_$(PHASE_)ALTERA_SDRAM) +=3D drivers/ddr/altera/`=
 would
> > > make me think otherwise, most of the contents of the toplevel Makefile
> > > strongly suggest that it's only ever executed once, rather than one t=
ime
> > > for each of u-boot proper, spl, tpl, vpl. I have tried to use $(PHASE=
_)
> > > anyway, but it really doesn't seem to work. Could you explain more
> > > specifically how I should do this?
> > I had thought this would work, yes. Does this mean the other cases of
> > $(PHASE_) in the top-level Makefile also aren't working? And, is there
> > some other Makefile where $(PHASE_) does indeed work, that we could move
> > this particular logic to?
> >=20
> Yes, I'm pretty sure the other cases are also not working.
> I don't see a way to do this "properly" with the current Makefile setup,
> but obviously I don't know that much about it.
> I think the cleanest way would be add a new Makefile, maybe
> Makefile.foreachphase in scripts/ (or some shorter name), and have
> the toplevel makefile do include magic to include it multiple times
> with $(PHASE_) set (and probably stuff like $(phase) and/or $(BIN) too,
> those currently don't exist at all but would be handy for obvious reasons=
).
>=20
> In any case I would prefer if the current iteration could just go through
> for now, since this looks like a non-trivial change that would better
> be done by someone who spent more than two days trying to understand the
> Makefile system.

Yes, thanks for looking in to this more. We can do this as a future
clean-up.

--=20
Tom

--PJ/o4Btbo/vniUBN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeuuxQAKCRAr4qD1Cr/k
Cmd3AP4qe3RD8CWQjMw2UzhpjspkY9zFjYkgcd72HtfXU6KGzQD/fYK35wtOdPJs
mGYFai+Zw9ynPQlIInwlC4TIlVqk9gg=
=BqzJ
-----END PGP SIGNATURE-----

--PJ/o4Btbo/vniUBN--
