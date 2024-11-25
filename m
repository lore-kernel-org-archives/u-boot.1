Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77444D58D77
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20A288D13;
	Mon, 25 Nov 2024 19:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WEOjn39m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1409588DE6; Mon, 25 Nov 2024 19:08:55 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA8680245
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4668f208f10so12081171cf.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732558131; x=1733162931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nchU+rJaq1h0pyDG8hbcvgLclaaQtUihngi3PK+suNk=;
 b=WEOjn39mE4WKnVwhu05bjNir78eaA7ysKwoEPU9Lkt1Pl1uJFpbaV6g66YEaN9C4hC
 2utHJd40MMQnjZx27u9o+4SSUsZndTWYL6/QKeJrwulwfamEB7BLUWRm5qDc+QTJv9eG
 2LX3CpIR0MzRJmTrdM4Tu56MvDuh4Zu3zFrBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732558131; x=1733162931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nchU+rJaq1h0pyDG8hbcvgLclaaQtUihngi3PK+suNk=;
 b=hD9X22FWaeSjhrdiZ+bxuC6eJ4MM0yFN3SR6yU+/+wU0CGN+q29t2WU8d+avj6RYZc
 1N65BDQ064QZ1Lgr1/J232BaHbr6746/H5/vpcnocW3fKan9umLETYivULs9didHDWgd
 lzZmV2eBvO3Tt/QldnOsRJ7iGzgyAIkIZj/m/RBSkDvGJ+T6HdAN/j6KAemZVVp26oyL
 DMPxtxQC5jpO5mzzmhEBm+Qn8rfireXQl3YdNS4STG1ifCo36QP0B5Bdz/6jSv0TM2QK
 ujpv6yZpLx3VkXDy1kWOtZibAmTfTKOw8qUu4a0o1CqRDEMo693dzJtNmrexbBR1+zh/
 5dug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM6Asvm3aFCp8b09Aw0Y5ogGRzAm9cVKmsI4nKfduVrG6y016jDgemqb27Vxwi4iGUuO5wltg=@lists.denx.de
X-Gm-Message-State: AOJu0YzOe4C30Azi2rl7x8TrzlC/AA53kq0N13UFgRhb4ruBaYzW26B1
 0qXvjJ4zmrwLab6SqGAqKItv3Vgn5EE5iH6fSkLQlZBwUC8I1KyPQ1cngcqRS44=
X-Gm-Gg: ASbGncv6v70cBY9w1YNBHdtTAehPGBddIbs6oSr5NIisv0Y8axEzOqgQtasQO4RYSfT
 HXA9/fa5S2quF+6wjH5AExqZ+DN1eYBXfceXiIU5LIks1yiYis+TBYlSjb1WeGjuprSvRUFRzEs
 /xUOto7eTq2oIQMcd9NGmD+kwkliMl7mJbEOlg/eWQxlQ/NtJC8FY1Dvt/mCUhzZeVL1uyJCPId
 2Kz50Lfax5PPHNQvu33Gv0+0Dz3jvVeVXvuSWIbI7HW10IlfA==
X-Google-Smtp-Source: AGHT+IHT5xs52GzUunTgSBTyjUwLoI+eWTowYXCGhQF9kRJb/76VJ+F3DDmjPh497GlYstVAOxEBYg==
X-Received: by 2002:a05:622a:750a:b0:466:94d8:926c with SMTP id
 d75a77b69052e-46694d8949emr42150931cf.13.1732558131422; 
 Mon, 25 Nov 2024 10:08:51 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466a174606esm3154021cf.79.2024.11.25.10.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 10:08:50 -0800 (PST)
Date: Mon, 25 Nov 2024 12:08:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
Message-ID: <20241125180847.GK3600562@bill-the-cat>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O8sS9UvT7JPF2Hj3"
Content-Disposition: inline
In-Reply-To: <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
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


--O8sS9UvT7JPF2Hj3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 07:03:41PM +0100, Michal Simek wrote:
>=20
>=20
> On 11/25/24 11:35, Heinrich Schuchardt wrote:
> > On 25.11.24 11:02, Michal Simek wrote:
> > >=20
> > >=20
> > > On 11/25/24 10:21, Heinrich Schuchardt wrote:
> > > > On 11/25/24 09:32, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/23/24 22:45, Heinrich Schuchardt wrote:
> > > > > > The CI uses the following command to launch xilinx_versal_virt_=
defconfig:
> > > > > >=20
> > > > > > =A0=A0=A0=A0 qemu-system-aarch64 -M xlnx-versal-virt \
> > > > > > =A0=A0=A0=A0 -display none -m 4G -serial mon:stdio \
> > > > > > =A0=A0=A0=A0 -device loader,file=3Du-boot,cpu-num=3D0
> > > > > >=20
> > > > > > 'usb start' or invoking eth_bootdev_hunt leads to a crash when =
function
> > > > > > dwc3_core_init() tries to access a register at offset 0xc704 (D=
WC3_DCTL)
> > > > > > relative to the register start address 0xfe20c100.
> > > > > >=20
> > > > > > Disable CONFIG_USB_DWC3 until the driver problem is fixed.
> > > > > >=20
> > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonic=
al.com>
> > > > > > ---
> > > > > > v2:
> > > > > > =A0=A0=A0=A0new patch
> > > > > > ---
> > > > > > =A0 configs/xilinx_versal_virt_defconfig | 2 --
> > > > > > =A0 1 file changed, 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/configs/xilinx_versal_virt_defconfig
> > > > > > b/configs/ xilinx_versal_virt_defconfig
> > > > > > index c8f166c1221..06a240173ba 100644
> > > > > > --- a/configs/xilinx_versal_virt_defconfig
> > > > > > +++ b/configs/xilinx_versal_virt_defconfig
> > > > > > @@ -153,8 +153,6 @@ CONFIG_USB=3Dy
> > > > > > =A0 CONFIG_DM_USB_GADGET=3Dy
> > > > > > =A0 CONFIG_USB_XHCI_HCD=3Dy
> > > > > > =A0 CONFIG_USB_XHCI_DWC3=3Dy
> > > > > > -CONFIG_USB_DWC3=3Dy
> > > > > > -CONFIG_USB_DWC3_GENERIC=3Dy
> > > > > > =A0 CONFIG_USB_ULPI_VIEWPORT=3Dy
> > > > > > =A0 CONFIG_USB_ULPI=3Dy
> > > > > > =A0 CONFIG_USB_GADGET=3Dy
> > > > >=20
> > > > > NACK. That's not the way to go. If one test is failing in CI
> > > > > disable that test not really support which is for HW too.
> > > > >=20
> > > > > Thanks,
> > > > > Michal
> > > >=20
> > > > Hello Michal,
> > > >=20
> > > > It is not that a single test fails. USB is completely unusable
> > > > on the board. 'usb start' leads to an immediate crash.
> > >=20
> > > I am not applying any patches on SOM with HEAD and usb is partially w=
orking.
> >=20
> > Don't you see a crash when executing 'usb start'?
> > What QEMU are you using?
> >=20
> > > I can agree that it is not super stable with upstream only patches
> > > but that's different story.
> > >=20
> > > >=20
> > > > The problem already existed in v2021.01.
> > >=20
> > > Any log?
> >=20
> > $ git reset --hard origin/master
> > $ make xilinx_versal_virt_defconfig
> > $ CROSS_COMPILE=3Daarch64-linux-gnu- make -j$(nproc)
> > $ qemu-system-riscv64 --version
> > QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
> > $ qemu-system-aarch64 -M xlnx-versal-virt \
> >  > -display none -m 4G -serial mon:stdio \
> >  > -device loader,file=3Du-boot,cpu-num=3D0
> >=20
> >=20
> > U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
> >=20
> > CPU:=A0=A0 UNKNOWN
> > Model: Xilinx Versal Virtual development board
> > DRAM:=A0 2 GiB (effective 4 GiB)
> > EL Level:=A0=A0=A0=A0=A0=A0 EL3
> > Core:=A0 32 devices, 13 uclasses, devicetree: board
> > Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023=
=2E07!
> > MMC:=A0=A0 sdhci@f1040000: 0, sdhci@f1050000: 1
> > Loading Environment from nowhere... OK
> > In:=A0=A0=A0 uart@ff000000
> > Out:=A0=A0 uart@ff000000
> > Err:=A0=A0 uart@ff000000
> > Bootmode: JTAG_MODE
> > Net:
> > ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
> >=20
> > Warning: ethernet@ff0c0000 (eth0) using random MAC address - 5e:f6:37:a=
3:68:24
> > eth0: ethernet@ff0c0000
> > ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
> >=20
> > Warning: ethernet@ff0d0000 (eth1) using random MAC address - 5e:8a:ec:a=
9:d7:e8
> > , eth1: ethernet@ff0d0000
> > MMC: no card present
> > MMC: no card present
> > Cannot persist EFI variables without system partition
> > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > Missing RNG device for EFI_RNG_PROTOCOL
> > Hit any key to stop autoboot:=A0 0
> > Versal> usb start
> > starting USB...
> > Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
> > elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
> > elr: 000000007ff17fd8 lr : 000000007ff18940
> > x0 : 00000000fe20c100 x1 : 0000000040000000
> > x2 : 0000000033310000 x3 : 000000000000003f
> > x4 : 000000007ffa74b0 x5 : 000000007c112880
> > x6 : 000000007ffa74c0 x7 : 000000007c300000
> > x8 : 0000000000000684 x9 : 000000007bda668c
> > x10: 0000000000000003 x11: 0000000000000188
> > x12: 0000000000000000 x13: 000000007bda6be0
> > x14: 0000000000000000 x15: 000000007bda6224
> > x16: 000000007fee9244 x17: 0000000000000000
> > x18: 000000007bea6be0 x19: 000000007c111b48
> > x20: 000000007c111240 x21: 0000000047822004
> > x22: 000000007ff998b2 x23: 000000007ff998e8
> > x24: 000000007ffd4514 x25: 0000000000000000
> > x26: 0000000000000000 x27: 000000007c111130
> > x28: 000000007c1110d0 x29: 000000007bda67b0
> >=20
> > Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
> > Resetting CPU ...
> >=20
> > resetting ...
> >=20
> > $ cat u-boot.map
> >  =A0.text.dwc3_core_init
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0000000008068f24=A0=A0=
=A0=A0=A0 0x6a0 drivers/usb/dwc3/core.o
> >  =A0.text.dwc3_of_parse
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00000000080695c4=A0=A0=
=A0=A0=A0 0x310 drivers/usb/dwc3/core.o
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00000000080695c4=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_of_parse
> >=20
> > >=20
> > > > Do you know of any QEMU/U-Boot combination where USB ever worked on=
 the board?
> > >=20
> > > Why was this visible in CI in past and why this pops up now?
> > > What has changed? I don't think there was any change in QEMu
> > > regarding USB but I can double check.
> >=20
> > We never started USB in the CI.
> > With patch 6/6 of the series usb_bootdev_hunter() is invoked which star=
ts USB.
>=20
> Did you push this to gitlab CI? Which test/py is failing there?

Er, we don't do "usb start" in CI yet, is why it doesn't fail there. Or
are you suggesting this is a QEMU problem ?

--=20
Tom

--O8sS9UvT7JPF2Hj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdEvSsACgkQFHw5/5Y0
tyyLvgv+NRubslpxclE5Y/KmyH0KNuugNtIykxSrP5c3LqP5AF3TYK3PCO8xQ+To
uMpVGQUivMT2Sz8wFrLsENB4M67PnKOULsrw4FtwXFq8p2t8vBC9+3dOwgyNqn5Z
GWoOscD6wT5R5e7PYwv3JB8kmOy7ZXklbci2bv3p1pSqEBAv32UXUetI3sYqplIl
1t9QHhpx5ThGHEZALpOHX5UToVzeSkxQeKVyv4NmVLTDW+kVmxRpYom4vF/A5yEt
WqOCjLaOu8B/d2cJls47YV+mZn6xUHkvnw2FQgg+rLSUAV0ln48V7eVEIJS77xjb
gGl90NAEmKR1wqI9DBIU8+1wAAEG/7d6q9L2dkr7LOJ5nmm+69Ix4A01zfcS6s8L
sWg5BvM7YT1TITN6jSslCGWhEGMUaxyofsbitB4+mW7n2qcAfBn9TtSZATawxPsQ
ATk430JxyXnBPiK69/QbfEs0Qsc/n/Kri0qYNWqj9vCpISiTpBRC1SmIYTMqcYik
Gn+7sTbh
=kNFJ
-----END PGP SIGNATURE-----

--O8sS9UvT7JPF2Hj3--
