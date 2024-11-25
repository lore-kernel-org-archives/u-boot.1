Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F37AD58D7F
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A08BB89A3A;
	Mon, 25 Nov 2024 19:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cRPujoPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B24589A3E; Mon, 25 Nov 2024 19:48:33 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BDE899EA
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e382589e8fdso4734147276.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732560510; x=1733165310; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mQmgolb35lTF/etskFnNEE4dfGv/SZw+Udvdn6X/teY=;
 b=cRPujoPFM1BimGO3/jUU/Na7ah1IuWb/vKAhE6fMH5ZJMBZLAhw5FrzAep6liECxVi
 S8lZ+/OOnYNULHPMlnXK42WFKkNSFm7CWSvF7r35tAtTK3FX7xTxaaGqIo3Q5uNDelmY
 KbImdUDDN+2oWt4vkZEm1Bc5GyJDTDmZqA0+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732560510; x=1733165310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQmgolb35lTF/etskFnNEE4dfGv/SZw+Udvdn6X/teY=;
 b=bM3bRB9RPjOBzavYwovNQpTWMq211nFI3L0RtNB5H4ASKdb8pWxYH6WNYBvrNvdXKO
 GtOHRTp31w2QfvoEYaaRC47DsYzklT64sGKvzGrK2og8h3e33eK3AZNniPXn1ild+c7y
 87x8dBOOLerNdwllwN/SGJyT8TtiiGuFBgUXRVlQ9ZT3YZahbrkkvY8YNFzAO4Ffvlcl
 juQI5r7NZDDPoPk7WuZjiK48IihhRUWNMbOyX0EL93zdPq+EeFVXi/hdqo782VpWQvlT
 iQU4Lx4V51DkWWtymSo53jIjCu+KAFIjnxiUDWpJhkuaAKkkxglmEVLemtmMtxSZMllx
 kR5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnOZW+H7f1RlhmQ6kSFVE+v/RBYhqwPVndFj1G84J/iTvJzOkxNReRv62UxroRplUxnxI3b6w=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4R7ielNLhYodkfjrVjYLT7XnbIaNZvcF3gVg/VzT3/NTq4GCm
 oe3cnRp409ALwpOd1BK01a6O9fgLLrs3+04T10fosxQU0EJ7t/XkwI3laLkZqEg=
X-Gm-Gg: ASbGncuraOahIO6vLOAP0m60qSsjeahcARQbcWNV+LXCiWLqTwXthfAEWKjqAUAMDJf
 s4WQmQHxskzE/tLuZmooVLVHwBFwMjjpzUdQbIu5vHldLO6QlI41XEAzcYcdXqScB/pfvwoDhfD
 uoKOAhyM+qx1k00JsUJUyyA8dKy6GpQZb11BUQ6zJ3sfx3Ah5BIc8sa7cOp0SsQl0zXCK+9c5Dj
 JvTerb3C8kxRWJCpC4D2XVYYjbg8Zp4hLu/dUtzrsysicNmSg==
X-Google-Smtp-Source: AGHT+IEO+ThLq3PpHU4TW7kKuJ01tXNgAMRaNcCIAK7/o5NiRDl50OQ2CV8remFQQFMjGUrtWSnYgw==
X-Received: by 2002:a05:6902:2002:b0:e30:7c38:668b with SMTP id
 3f1490d57ef6-e38f8be3802mr11514190276.37.1732560509862; 
 Mon, 25 Nov 2024 10:48:29 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c47fb4csm48093591cf.70.2024.11.25.10.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 10:48:28 -0800 (PST)
Date: Mon, 25 Nov 2024 12:48:24 -0600
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
Message-ID: <20241125184824.GL3600562@bill-the-cat>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <20241125180847.GK3600562@bill-the-cat>
 <ad58b032-f618-498f-8cce-f13d0f6d6021@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YWJyKgW3E+bbqwRs"
Content-Disposition: inline
In-Reply-To: <ad58b032-f618-498f-8cce-f13d0f6d6021@amd.com>
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


--YWJyKgW3E+bbqwRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 07:44:15PM +0100, Michal Simek wrote:
>=20
>=20
> On 11/25/24 19:08, Tom Rini wrote:
> > On Mon, Nov 25, 2024 at 07:03:41PM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 11/25/24 11:35, Heinrich Schuchardt wrote:
> > > > On 25.11.24 11:02, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 11/25/24 10:21, Heinrich Schuchardt wrote:
> > > > > > On 11/25/24 09:32, Michal Simek wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 11/23/24 22:45, Heinrich Schuchardt wrote:
> > > > > > > > The CI uses the following command to launch xilinx_versal_v=
irt_defconfig:
> > > > > > > >=20
> > > > > > > >  =A0=A0=A0=A0 qemu-system-aarch64 -M xlnx-versal-virt \
> > > > > > > >  =A0=A0=A0=A0 -display none -m 4G -serial mon:stdio \
> > > > > > > >  =A0=A0=A0=A0 -device loader,file=3Du-boot,cpu-num=3D0
> > > > > > > >=20
> > > > > > > > 'usb start' or invoking eth_bootdev_hunt leads to a crash w=
hen function
> > > > > > > > dwc3_core_init() tries to access a register at offset 0xc70=
4 (DWC3_DCTL)
> > > > > > > > relative to the register start address 0xfe20c100.
> > > > > > > >=20
> > > > > > > > Disable CONFIG_USB_DWC3 until the driver problem is fixed.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@can=
onical.com>
> > > > > > > > ---
> > > > > > > > v2:
> > > > > > > >  =A0=A0=A0=A0new patch
> > > > > > > > ---
> > > > > > > >  =A0 configs/xilinx_versal_virt_defconfig | 2 --
> > > > > > > >  =A0 1 file changed, 2 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/configs/xilinx_versal_virt_defconfig
> > > > > > > > b/configs/ xilinx_versal_virt_defconfig
> > > > > > > > index c8f166c1221..06a240173ba 100644
> > > > > > > > --- a/configs/xilinx_versal_virt_defconfig
> > > > > > > > +++ b/configs/xilinx_versal_virt_defconfig
> > > > > > > > @@ -153,8 +153,6 @@ CONFIG_USB=3Dy
> > > > > > > >  =A0 CONFIG_DM_USB_GADGET=3Dy
> > > > > > > >  =A0 CONFIG_USB_XHCI_HCD=3Dy
> > > > > > > >  =A0 CONFIG_USB_XHCI_DWC3=3Dy
> > > > > > > > -CONFIG_USB_DWC3=3Dy
> > > > > > > > -CONFIG_USB_DWC3_GENERIC=3Dy
> > > > > > > >  =A0 CONFIG_USB_ULPI_VIEWPORT=3Dy
> > > > > > > >  =A0 CONFIG_USB_ULPI=3Dy
> > > > > > > >  =A0 CONFIG_USB_GADGET=3Dy
> > > > > > >=20
> > > > > > > NACK. That's not the way to go. If one test is failing in CI
> > > > > > > disable that test not really support which is for HW too.
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > > Michal
> > > > > >=20
> > > > > > Hello Michal,
> > > > > >=20
> > > > > > It is not that a single test fails. USB is completely unusable
> > > > > > on the board. 'usb start' leads to an immediate crash.
> > > > >=20
> > > > > I am not applying any patches on SOM with HEAD and usb is partial=
ly working.
> > > >=20
> > > > Don't you see a crash when executing 'usb start'?
> > > > What QEMU are you using?
> > > >=20
> > > > > I can agree that it is not super stable with upstream only patches
> > > > > but that's different story.
> > > > >=20
> > > > > >=20
> > > > > > The problem already existed in v2021.01.
> > > > >=20
> > > > > Any log?
> > > >=20
> > > > $ git reset --hard origin/master
> > > > $ make xilinx_versal_virt_defconfig
> > > > $ CROSS_COMPILE=3Daarch64-linux-gnu- make -j$(nproc)
> > > > $ qemu-system-riscv64 --version
> > > > QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
> > > > $ qemu-system-aarch64 -M xlnx-versal-virt \
> > > >   > -display none -m 4G -serial mon:stdio \
> > > >   > -device loader,file=3Du-boot,cpu-num=3D0
> > > >=20
> > > >=20
> > > > U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +010=
0)
> > > >=20
> > > > CPU:=A0=A0 UNKNOWN
> > > > Model: Xilinx Versal Virtual development board
> > > > DRAM:=A0 2 GiB (effective 4 GiB)
> > > > EL Level:=A0=A0=A0=A0=A0=A0 EL3
> > > > Core:=A0 32 devices, 13 uclasses, devicetree: board
> > > > Warning: Device tree includes old 'u-boot,dm-' tags: please fix by =
2023.07!
> > > > MMC:=A0=A0 sdhci@f1040000: 0, sdhci@f1050000: 1
> > > > Loading Environment from nowhere... OK
> > > > In:=A0=A0=A0 uart@ff000000
> > > > Out:=A0=A0 uart@ff000000
> > > > Err:=A0=A0 uart@ff000000
> > > > Bootmode: JTAG_MODE
> > > > Net:
> > > > ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
> > > >=20
> > > > Warning: ethernet@ff0c0000 (eth0) using random MAC address - 5e:f6:=
37:a3:68:24
> > > > eth0: ethernet@ff0c0000
> > > > ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
> > > >=20
> > > > Warning: ethernet@ff0d0000 (eth1) using random MAC address - 5e:8a:=
ec:a9:d7:e8
> > > > , eth1: ethernet@ff0d0000
> > > > MMC: no card present
> > > > MMC: no card present
> > > > Cannot persist EFI variables without system partition
> > > > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > > > Missing RNG device for EFI_RNG_PROTOCOL
> > > > Hit any key to stop autoboot:=A0 0
> > > > Versal> usb start
> > > > starting USB...
> > > > Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
> > > > elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
> > > > elr: 000000007ff17fd8 lr : 000000007ff18940
> > > > x0 : 00000000fe20c100 x1 : 0000000040000000
> > > > x2 : 0000000033310000 x3 : 000000000000003f
> > > > x4 : 000000007ffa74b0 x5 : 000000007c112880
> > > > x6 : 000000007ffa74c0 x7 : 000000007c300000
> > > > x8 : 0000000000000684 x9 : 000000007bda668c
> > > > x10: 0000000000000003 x11: 0000000000000188
> > > > x12: 0000000000000000 x13: 000000007bda6be0
> > > > x14: 0000000000000000 x15: 000000007bda6224
> > > > x16: 000000007fee9244 x17: 0000000000000000
> > > > x18: 000000007bea6be0 x19: 000000007c111b48
> > > > x20: 000000007c111240 x21: 0000000047822004
> > > > x22: 000000007ff998b2 x23: 000000007ff998e8
> > > > x24: 000000007ffd4514 x25: 0000000000000000
> > > > x26: 0000000000000000 x27: 000000007c111130
> > > > x28: 000000007c1110d0 x29: 000000007bda67b0
> > > >=20
> > > > Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
> > > > Resetting CPU ...
> > > >=20
> > > > resetting ...
> > > >=20
> > > > $ cat u-boot.map
> > > >   =A0.text.dwc3_core_init
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0000000008068f24=
=A0=A0=A0=A0=A0 0x6a0 drivers/usb/dwc3/core.o
> > > >   =A0.text.dwc3_of_parse
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00000000080695c4=
=A0=A0=A0=A0=A0 0x310 drivers/usb/dwc3/core.o
> > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00000000080695c4=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_of_parse
> > > >=20
> > > > >=20
> > > > > > Do you know of any QEMU/U-Boot combination where USB ever worke=
d on the board?
> > > > >=20
> > > > > Why was this visible in CI in past and why this pops up now?
> > > > > What has changed? I don't think there was any change in QEMu
> > > > > regarding USB but I can double check.
> > > >=20
> > > > We never started USB in the CI.
> > > > With patch 6/6 of the series usb_bootdev_hunter() is invoked which =
starts USB.
> > >=20
> > > Did you push this to gitlab CI? Which test/py is failing there?
> >=20
> > Er, we don't do "usb start" in CI yet, is why it doesn't fail there. Or
> > are you suggesting this is a QEMU problem ?
>=20
> This is where it is failing from dwc3_core_init().
> dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
>=20
> It means it is likely qemu model limitation.

And since this is for the virt platform, doesn't it make sense to
disable it until the model is fixed?

--=20
Tom

--YWJyKgW3E+bbqwRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdExnUACgkQFHw5/5Y0
tyxJ6Av6A7vw2P2iE3s3IMYs+XAaz+XobyivvCwHZmQWeVUCzD3Q7gEDhBYau2Dv
G1KdHbK5qKziRg/ci/zL0evEp3ZxEqxd/k4+MpzQHPnw2NzfZgAbh1/Fh1pd+tg5
LnclKxRazpq7ZrOvGQi/6pp6SQyjMc7KT1vtXzn9sPlDcahEVxDDt4YRToY8QNr/
FQ5iIuBq0oOx0rJkVEHh3IqxzbgNESOymDUL0ADiqkPQPzPkn7Th0+uk5/z6WtxH
9xBtD8KveUeqDB9F27sF8wRffxf8u0pKYTDdumWN5IwVcsJqchUCSTaAaJc76udS
QR5QUJ3ujKnmEDF3o7JYgiAX76WEa8NGNTuKMGWRzIfuOfxnvQvwgXND8husga1O
+FDbesgxg4x4ghEDWEbK/sXKnlWQV7dgYDHmMcAu8blglJ54jk/l6IXFKW9P2c3u
vKl+1SaaTnPUozGAs/3KC6Kfd3ZN/UWhiaNBTn+4e6R4Fvqa2FxUhOVjUdqTJ6aQ
MJSAo5Vu
=/Csg
-----END PGP SIGNATURE-----

--YWJyKgW3E+bbqwRs--
