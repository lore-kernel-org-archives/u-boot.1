Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74855E7717F
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 02:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EE5800B5;
	Sat, 14 Dec 2024 03:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E562A800B6; Sat, 14 Dec 2024 03:20:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 16451800B2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 03:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6362A11FB;
 Fri, 13 Dec 2024 18:21:00 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38263F58B;
 Fri, 13 Dec 2024 18:20:31 -0800 (PST)
Date: Sat, 14 Dec 2024 02:19:50 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Leon Anavi <leon.anavi@konsulko.com>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Cc: u-boot@lists.denx.de, lhristov@gmail.com
Subject: Re: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
Message-ID: <20241214021950.5013865a@minigeek.lan>
In-Reply-To: <e77f6b37-7d50-4f3d-9bed-6d3e39effb4c@konsulko.com>
References: <CALtQ3O2jF6sEvofpZ+FtJgmgTKZvNRuohnwEtPz4ES0WqtxU5g@mail.gmail.com>
 <20241211215327.26dc369a@minigeek.lan>
 <e77f6b37-7d50-4f3d-9bed-6d3e39effb4c@konsulko.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 12 Dec 2024 11:19:06 +0200
Leon Anavi <leon.anavi@konsulko.com> wrote:

Hi Leon,

> On 11.12.24 =D0=B3. 23:53 =D1=87., Andre Przywara wrote:
> > On Mon, 9 Dec 2024 23:08:19 +0200
> > Leon Anavi<leon.anavi@konsulko.com> wrote:
> >
> > Hi Leon,
> >
> > thanks for the report!
> > =20
> >> Commit ffb0294 from 12 November 2023 that simplifies early PMIC setup
> >> conditions causes issues on Cubieboard 4 and Merrii A80 Optimus with
> >> Allwinner A80 SoC (sun9i). The commit was introduced with U-Boot 2024.=
01
> >> (rc3) and remains as of today. Because of it both of these boards hang=
 at:
> >>
> >> Starting kernel ... =20
> > That's odd, how do you boot the kernel, exactly?
> > I just tried mainline U-Boot (via FEL), with: =20
> > =3D> setenv bootargs "console=3DttyS0,115200n8 earlycon"
> > =3D> bootz $kernel_addr_r $ramdisk_addr_r:300000 $fdtcontroladdr =20
> >
> > and it booted fine to the prompt, on a Cubieboard 4 (CC-A80 v1.2).
> > Kernel was some 6.11-rc6 I just had lying around.
> >
> > I also compared the code before and after that patch, the only
> > difference is the order at which DCDC5 gets programmed: before it's
> > after DCDC4, with the patch it's right after DCDC1.
> > The rest looked the same.
> > Booting ffb0294~1 and ffb0294~0 also worked for me, without issues.
> > So can you please describe how you test that, exactly? =20
> I built core-image-base using the Yocto Project and OpenEmbedded as well =
Starting kernel ...
> as the meta-sunxi BSP layer. The U-Boot version depends on the Yocto=20
> release. For Scarthgap it is with U-Boot 2024.01 and for the ongoing=20
> development in the master branches the U-Boot version is 2024.10. The=20
> Linux kernel version is 6.6.28. I experienced the same issue with both=20
> U-Boot versions on Merrii A80 Optimus and Lazar (his email is CC)=20
> confirmed the same results on Cubieboard 4. The boot sequence for the=20
> boards in meta-sunxi is through boot.scr generated from the following=20
> boot.cmd:
> https://github.com/linux-sunxi/meta-sunxi/blob/master/recipes-bsp/u-boot/=
files/arm/boot.cmd
>=20
> In a nutshell, the issue can be reproduced with the following scenario=20
> in U-Boot:
>=20
> setenv bootargs console=3DttyS0,115200 console=3Dtty1 root=3D/dev/mmcblk0=
p2=20
> rootwait panic=3D10

So I tried with an SD card now, and I think I see what you mean now.
I was a bit confused first why it would hang for you after "Starting
kernel ...", but I guess it actually doesn't: can you add "earlycon" to your
command line and confirm that the kernel boots, but hangs while waiting
for the secondary cores?
I am still scratching my head how this commit would affect this
behaviour, but this change here seems to fix it for me:

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 29a329f41a2..d7c46eec615 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -582,7 +582,6 @@ void sunxi_board_init(void)
=20
 #ifdef CONFIG_AXP_DCDC1_VOLT
 	power_failed |=3D axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
-	power_failed |=3D axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
 #endif
 #ifdef CONFIG_AXP_DCDC2_VOLT
 	power_failed |=3D axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
@@ -591,6 +590,9 @@ void sunxi_board_init(void)
 #ifdef CONFIG_AXP_DCDC4_VOLT
 	power_failed |=3D axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
 #endif
+#ifdef CONFIG_AXP_DCDC5_VOLT
+	power_failed |=3D axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
+#endif
=20
 #ifdef CONFIG_AXP_ALDO1_VOLT
 	power_failed |=3D axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);

Can you confirm this?
This fix looks easily mainline-able, as it just restores the old
initialisation order, but I still would like to know why the other
order hangs. Will try to do some experiments.

Cheers,
Andre


> load mmc 0:1 ${fdt_addr_r} ${fdtfile}
> load mmc 0:1 ${kernel_addr_r} zImage
> bootz ${kernel_addr_r} - ${fdt_addr_r}
>=20
> Merrii A80 Optimus board boots fine if I revert commit ffb0294.
> However, if commit ffb0294 is present in U-Boot the board hangs. Here
> is the log: U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> Allwinner Technology CPU: Allwinner A80 (SUN9I) Model: Merrii A80
> Optimus Board DRAM: 2 GiB Core: 62 devices, 18 uclasses, devicetree:
> separate WDT: Not starting watchdog@6000ca0 WDT: Not starting
> watchdog@8001000 MMC: sunxi_set_reset: (RST#0) unhandled
> sunxi_set_reset: (RST#2) unhandled sunxi_set_reset: (RST#1) unhandled
> mmc@1c0f000: 0, mmc@1c10000: 2, mmc@1c11000: 1 Loading Environment
> from FAT... Unable to read "uboot.env" from mmc0:1... In:
> serial@7000000 Out: serial@7000000 Err: serial@7000000 Net: No
> ethernet found. Hit any key to stop autoboot: 0 =3D> setenv bootargs
> console=3DttyS0,115200 console=3Dtty1 root=3D/dev/mmcblk0p2 rootwait
> panic=3D10 =3D> load mmc 0:1 ${fdt_addr_r} ${fdtfile} 24443 bytes read in
> 3 ms (7.8 MiB/s) =3D> load mmc 0:1 ${kernel_addr_r} zImage 5397992
> bytes read in 236 ms (21.8 MiB/s) =3D> bootz ${kernel_addr_r} -
> ${fdt_addr_r} Kernel image @ 0x22000000 [ 0x000000 - 0x525de8 ] ##
> Flattened Device Tree blob at 23000000 Booting using the fdt blob at
> 0x23000000 Working FDT set to 23000000 Loading Device Tree to
> 29ff7000, end 29ffff7a ... OK Working FDT set to 29ff7000 Starting
> kernel ... Please note that U-Boot is marked with suffix "-dirty"
> because of the patches applied by u-boot_%.bbappend from Yocto/OE
> layer meta-sunxi but these patches are for other boards and don't
> touch the file board/sunxi/board.c. Am I missing something as a
> configuration that can make the board boot the same way without
> hanging when commit ffb0294 is present?Best regards, Leon
>=20
> >
> > Please also note we fixed d75fa8c80dcfa in U-Boot (DCDC4/5 typo),
> > and dd36ad71ad6 in the kernel (DCDC5 constraints in the DT).
> >
> > Cheers,
> > Andre
> > =20
> >> Older U-Boot versions without this commit work fine. As a temporary
> >> solution I reverted commit ffb0294 and this way the boards boot
> >> successfully. I tested this work around on Merrii A80 Optimus with
> >> several U-Boot versions, including with U-Boot 2024.10. =20
> > =20
> >> Lazar, a friend who owns Cubieboard 4, also tested and confirmed
> >> his board boots with U-Boot 2024.10 if this commit has been
> >> reverted.
> >>
> >> How to fix this? Is there a known configuration that can be added
> >> to Merrii_A80_Optimus_defconfig and Cubieboard4_defconfig to avoid
> >> hanging with the existing source code from commit ffb0294 ?
> >>
> >> Best regards,
> >> Leon =20

