Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0995C04A94
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BA286992;
	Mon, 14 Aug 2023 17:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CBFbumL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A6886970; Mon, 14 Aug 2023 17:04:21 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7402865B6
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d659ad4af70so3810445276.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025458; x=1692630258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ct0jvH+8Gvxg1sA+/OlRKEc4mpLILIDjPe/r9iV9isg=;
 b=CBFbumL7zQUk9UxvqE9LBe0XseupyQUUzKZdbPb2fraxAwnfeIyDOkAp93ZlgZnHwo
 d3OP4w6xmbFqxwg+DFbV8g+OStPEu5Ui9TgqERL+G4W1bW+pWGuztsi5wdnBjqwcB2bd
 +OJ2ADubS/NBLC/EPPrPzOekNQW2d7YcTs3Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025458; x=1692630258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ct0jvH+8Gvxg1sA+/OlRKEc4mpLILIDjPe/r9iV9isg=;
 b=Pl0AuAv85vpLhDNZir9c0r5GPCXO7OEGdHJ1dcyWPagg4JechFp2sNCu7mQjnpG5Kp
 1XeVNbpevhUsK4JKSf3H7c7cD3Kw7m9ghz05yRscaSOjxebR5pydykCWfOK3bdmgaPCa
 U8dstwHAJiECvEpQ3VCq4UMbWzU8X8tUjr/zqrgU5e4Bp/rJz2X8OAWC4MITq+ehS22U
 /92rV+gGhR7GrQiN9IxdTgeaqYi7PjoNbQfcqOb/PWDJOwtRJ8LEvV9GLEzI/bAhBo0l
 BaYu1/2KRRCa1f/YqDD2GjqCxiGt7yOilBxJqoCCEtq/8+jzLh/7x+4V66bX42tcbPYl
 Y6lw==
X-Gm-Message-State: AOJu0YyPza3hYfkoFOPWbr7sl9U/n8MbCsJGHqnOEbv49JKDgipE7Gt3
 Q21pYiCuhrdeltoXoqxHOGnuDQ==
X-Google-Smtp-Source: AGHT+IE1nHRfhbsl57DqQH74Xg3Km1xau8Oe+nKjIPOHyP9n5vEAJ3vyNX7KFmS4L9VtqtinJhPzhw==
X-Received: by 2002:a25:c014:0:b0:c76:173c:6718 with SMTP id
 c20-20020a25c014000000b00c76173c6718mr11864079ybf.1.1692025458251; 
 Mon, 14 Aug 2023 08:04:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 c201-20020a25c0d2000000b00d679ae188a6sm1676891ybf.37.2023.08.14.08.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:16 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:04:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Stefan Roese <sr@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Warren <twarren@nvidia.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Aaron Williams <awilliams@marvell.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Paul Burton <paul.burton@mips.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Aswath Govindraju <a-govindraju@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Fedor Ross <fedor.ross@ifm.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ovidiu Panait <ovpanait@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jason Liu <jason.hui.liu@nxp.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] common: return type board_get_usable_ram_top
Message-ID: <20230814150413.GU3630934@bill-the-cat>
References: <20230813050011.9345-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ1fxfxUT2g8wfi9YoJt4K2EDgCzy10Tv_D5p3T2yB-dVg@mail.gmail.com>
 <ff12490d-3ef8-dc66-2716-4b85ad5dbfea@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Axb0kZV6kblCVZ8F"
Content-Disposition: inline
In-Reply-To: <ff12490d-3ef8-dc66-2716-4b85ad5dbfea@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 14 Aug 2023 17:04:57 +0200
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


--Axb0kZV6kblCVZ8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 08:31:31AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> On 8/13/23 15:36, Simon Glass wrote:
> > Hi Heinrich,
> >=20
> > On Sat, 12 Aug 2023 at 23:01, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > board_get_usable_ram_top() returns a physical address that is stored =
in
> > > gd->ram_top. The return type of the function should be phys_addr_t li=
ke the
> > > current type of gd->ram_top.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/arm/mach-imx/imx8m/soc.c           | 2 +-
> > >   arch/arm/mach-mvebu/arm64-common.c      | 2 +-
> > >   arch/arm/mach-rockchip/sdram.c          | 2 +-
> > >   arch/arm/mach-stm32mp/dram_init.c       | 2 +-
> > >   arch/arm/mach-sunxi/board.c             | 2 +-
> > >   arch/arm/mach-tegra/board2.c            | 2 +-
> > >   arch/mips/mach-jz47xx/jz4780/jz4780.c   | 2 +-
> > >   arch/mips/mach-octeon/dram.c            | 2 +-
> > >   arch/riscv/cpu/fu540/dram.c             | 2 +-
> > >   arch/riscv/cpu/fu740/dram.c             | 2 +-
> > >   arch/riscv/cpu/generic/dram.c           | 2 +-
> > >   arch/riscv/cpu/jh7110/dram.c            | 2 +-
> > >   arch/x86/cpu/broadwell/sdram.c          | 2 +-
> > >   arch/x86/cpu/coreboot/sdram.c           | 2 +-
> > >   arch/x86/cpu/efi/payload.c              | 2 +-
> > >   arch/x86/cpu/efi/sdram.c                | 2 +-
> > >   arch/x86/cpu/ivybridge/sdram.c          | 2 +-
> > >   arch/x86/cpu/qemu/dram.c                | 2 +-
> > >   arch/x86/cpu/quark/dram.c               | 2 +-
> > >   arch/x86/cpu/slimbootloader/sdram.c     | 2 +-
> > >   arch/x86/cpu/tangier/sdram.c            | 2 +-
> > >   arch/x86/include/asm/u-boot-x86.h       | 2 +-
> > >   arch/x86/lib/fsp1/fsp_dram.c            | 2 +-
> > >   arch/x86/lib/fsp2/fsp_dram.c            | 2 +-
> > >   board/broadcom/bcmns3/ns3.c             | 2 +-
> > >   board/imgtec/boston/ddr.c               | 2 +-
> > >   board/menlo/m53menlo/m53menlo.c         | 2 +-
> > >   board/raspberrypi/rpi/rpi.c             | 2 +-
> > >   board/ti/am65x/evm.c                    | 2 +-
> > >   board/ti/j721e/evm.c                    | 2 +-
> > >   board/ti/j721s2/evm.c                   | 2 +-
> > >   board/toradex/verdin-am62/verdin-am62.c | 2 +-
> > >   board/xilinx/common/board.c             | 2 +-
> > >   common/board_f.c                        | 2 +-
> > >   include/init.h                          | 2 +-
> > >   35 files changed, 35 insertions(+), 35 deletions(-)
> >=20
> > While you are here, could you please fix the function comment?
> >=20
> > [..]
> >=20
> > > diff --git a/include/init.h b/include/init.h
> > > index 8873081685..b1e1451166 100644
> > > --- a/include/init.h
> > > +++ b/include/init.h
> > > @@ -304,7 +304,7 @@ int show_board_info(void);
> > >    *
> > >    * @param total_size   Size of U-Boot (unused?)
> >=20
> > It seems confused about the param, and we should have a return value.
>=20
> The parameter with the monitor length (size of U-Boot code) is not used
> anywhere (though it is passed on to functions like
> mrc_common_board_get_usable_ram_top() where it isn't used either).
>=20
> We should try to eliminate the parameter in further patches.
>=20
> >=20
> > Also should explain what this function is used for.
>=20
> That explanation exists.
>=20
> I will put the documentation fix into a separate patch so we can apply it=
 to
> 2023.10. I don't know if Tom wants to apply this patch to next or to
> 2023.10.

I'm thinking we should take this for v2023.10.

--=20
Tom

--Axb0kZV6kblCVZ8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQm0ACgkQFHw5/5Y0
tyxp1Av+IdIhoW4Gywx2lQF/fQlXcQV4jXdC6wSU4v/NtsXT7FOPZ6jhdnFB/ugz
nXus7fUZGQMX+IsM79O0PFhbJGx5+QD/cE01Rgip/pEi+cQTz7aIGWRc50FsTh6X
t7vDTpsGPSkcAeV+YqXE67K6nqFlUPwrJ4Rj1NLaB76FQx9kMmEeWbA2C1UUVCPG
MH3siCB4FDUdMcSdi4VWmkLAY62rjfVTuEYQBJQdtvFrJ66deV4VRoPGiVRwLdJ5
SJyo3dSgzcy5JlHT0wVSecIVjK7hqlGIqX3xlV7dxT6eRg9Rwc/BIQHox49BlFIE
IhnDu7ltuPNmoh5dhDOtoYwAOyo7EAAFul3Flhpq2YgUDv9aYc8DoHEimL4VanMS
nNNmh4YtzxSts7ZFHeKI8JdVRLBVi5eB/NwfKPAYsF/96Fk0zKiuEaAETPVvzJBv
GPn53a+kM++Huz19PHDgFEM/BgMsCgOYkojMawvk5hovBFhvMCXpUyT4M9g5Vw9N
boOK9FB+
=q5bH
-----END PGP SIGNATURE-----

--Axb0kZV6kblCVZ8F--
