Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF43ED6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 23:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0803089588;
	Wed, 20 Nov 2024 00:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HpaXLKS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE57895D2; Wed, 20 Nov 2024 00:10:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1315289500
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 00:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732057826; x=1732662626; i=xypron.glpk@gmx.de;
 bh=/vO+FgD2bSmgnl0Lz9ZQq2SGbXZPF9Veqs3Je+cJ8ns=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HpaXLKS8qy0aHi1aSvhC/HvQbcMWPgI9rdVaqqJ20sksOwPHP7fJZ7wcqmld3bcz
 kKs1KBBTtPrEvWM1NuzfffjtN9cGzMydSQ44FdbhEXtB3+XH37jbmzgBDmSP+A5Hv
 RyzG9pLgHoBIl8C4c3rMDWl6fcX7+IbuFTigoaru6c7cg5UsT87zi56Qfed7nkXbM
 ZQ6un0LGUlPrdR5oER8rTOb3O7Z96vInEN74XJ29H61oRnjkQMEGt1VZJaA6TW2ru
 tnmsOu8L9aq//B2rfxiHaPMbjsZ8Xw/77OF8Gp3naXFXUjEFbj4Te8Lp/4mqRwRN+
 pAhag/YnXmx5TsB4GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1tSAs22w63-00KT7o; Wed, 20
 Nov 2024 00:10:26 +0100
Date: Wed, 20 Nov 2024 00:10:23 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org, trini@konsulko.com,
 alpernebiyasak@gmail.com, ada@thorsis.com
CC: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/3=5D_doc=3A_develop=3A_Fix_?=
 =?US-ASCII?Q?typos_and_wording_in_binman/binman=2Erst?=
User-Agent: Thunderbird for Android
In-Reply-To: <20241119222837.27550-2-l.rubusch@gmail.com>
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-2-l.rubusch@gmail.com>
Message-ID: <316ED154-4011-41B4-8565-CD37C95D72B8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4pmE7GGj0fFtFrm3Fu2s4vMB14MTOFK1Sf7jmiJuKdHnikKxDFG
 orsL+23OUfv1Z//y5WdKvJolYUXaU1aLhpxnmhu7TH8P112+z/bcn6wT5wUy2vw3oh0PX0B
 5kVha+46dUNnTvDqrV/xXfpGPOnmLOjuRC7/VqO9XYVKeW953lhFEaocqSrHg7rYLEm3u8m
 S/r6J6OvU4qUpvdN0/dzg==
UI-OutboundReport: notjunk:1;M01:P0:mzJMybNO6IM=;rzj62qPf58NSnsMl4a5dkvoHQqa
 uCeKkqLlkHGX1ZkTWZLvZTIQmeU2yrgZWaoDwvHAuZLsjC4dkZLSUSqEVHcpkjjxki7JjMAwv
 B9zRhM0bxDpUbt2BBMfscOiRx4TCVGuXju0HByqvf1xauMMs9XtF0aN354f0mIfar7SdhRAUv
 1yWwDdsL4eSFT0cW9KZfwrZ3zL9hmB/OmfE/yLr+GCsjhRm7uEvxVNeJKY3tSHOG9CuBHljQF
 Jkw9vih9ZRVThKBoX/7p6RATJsFgUAPWFFxEFKiaRcGePLOO56TUPbTx79lq4xOKjfEJH1rt6
 m+d1iJ697OUHIrZ8Gok/+BewS3ztczfUn3mnu79zpeLO+SXgywBz5VFTLcK1Lhz5F6GLp91Wi
 4tZJt1DPCuSBjCNSjDXJ5GF7l6Mg3cJkmYqNecxrxPn/sVDmL1lzLSJ1q4W+32k66xUZgvAvu
 /eoxgGdyXqCgINxX/wDj/vMY9U3slRV/MlbcpZ7F5jyWjqLacwIrzI9bOLz1YnAcjK5AQkMYO
 8JkkhGW9/VfMb/xeIujgthQlR1WQk+F+3/eMjgyH9fFjXHwGW7+pDCySYMpJ+JGR28n4nBxfU
 ng1HHX8jyqVCUt+ypcj6NPqHIA2nDgVjrMxmAYTPLXJRw+hzPm9TULGusApAezZ3qAdmlhnF3
 PZ5YN3i8FwlaUJ5+Bh8xv9lZCAQLARDvIkU+s4uxCvvGj0BVZvuZTv6pdQMnSleLA8ljAipxl
 /wuCmb2Cv0TX0Tji9gAYitRC2m2eSw5gexCGOKsztCqB8ASybKHO75W2ZHSOfmgfhf82NYlNh
 wdt/5qNDHGVzpTaPacEGRJkwh8MyRbjwRvhtkgYJbyVHUED4j7E6P8oty18iheB0Fh3XF7aHM
 f9pptOs97/ULj2UzDQx4TORgfX91WGa53BDFUI6zvi0xS1Sjn0kJJxPy9
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

Am 19=2E November 2024 23:28:35 MEZ schrieb Lothar Rubusch <l=2Erubusch@gma=
il=2Ecom>:
>Fix some typos and duplicate words in binman=2Erst=2E
>
>Signed-off-by: Lothar Rubusch <l=2Erubusch@gmail=2Ecom>
>---
> tools/binman/binman=2Erst | 238 ++++++++++++++++++++--------------------
> 1 file changed, 119 insertions(+), 119 deletions(-)
>
>diff --git a/tools/binman/binman=2Erst b/tools/binman/binman=2Erst
>index 381e55686f=2E=2E620b5fa048 100644
>--- a/tools/binman/binman=2Erst
>+++ b/tools/binman/binman=2Erst
>@@ -5,7 +5,7 @@ Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Firmware often consists of several components which must be packaged tog=
ether=2E
>-For example, we may have SPL, U-Boot, a device tree and an environment a=
rea
>+For example, we may have SPL, U-Boot, a device-tree and an environment a=
rea

Both devicetree and device tree are common spelling variants=2E See for in=
stance https://www=2Edevicetree=2Eorg/=2E

> grouped together and placed in MMC flash=2E When the system starts, it m=
ust be
> able to find these pieces=2E
>=20
>@@ -19,7 +19,7 @@ together=2E
> What it does
> ------------
>=20
>-Binman reads your board's device tree and finds a node which describes t=
he
>+Binman reads your board's device-tree and finds a node which describes t=
he
> required image layout=2E It uses this to work out what to place where=2E
>=20
> Binman provides a mechanism for building images, from simple SPL + U-Boo=
t
>@@ -31,13 +31,13 @@ needed=2E
> Features
> --------
>=20
>-Apart from basic padding, alignment and positioning features, Binman sup=
ports
>+Apart from basic padding, alignment, and positioning features, Binman su=
pports
> hierarchical images, compression, hashing and dealing with the binary bl=
obs
>-which are a sad trend in open-source firmware at present=2E
>+which is a sad trend in open-source firmware at present=2E

It is not Binmans support (singular) that is a sad trend=2E It is binary b=
lobs (plural) that are a sad trend=2E

Best regards

Heinrich

>=20
> Executable binaries can access the location of other binaries in an imag=
e by
>-using special linker symbols (zero-overhead but somewhat limited) or by =
reading
>-the devicetree description of the image=2E
>+using special linker symbols (zero-overhead but limited) or by reading
>+the device-tree description of the image=2E
>=20
> Binman is designed primarily for use with U-Boot and associated binaries=
 such
> as ARM Trusted Firmware, but it is suitable for use with other projects,=
 such
>@@ -55,14 +55,14 @@ Motivation
> ----------
>=20
> As mentioned above, packaging of firmware is quite a different task from
>-building the various parts=2E In many cases the various binaries which g=
o into
>-the image come from separate build systems=2E For example, ARM Trusted F=
irmware
>+building the various parts=2E In many cases the various binaries which g=
o into image
>+come from separate build systems=2E For example, ARM Trusted Firmware
> is used on ARMv8 devices but is not built in the U-Boot tree=2E If a Lin=
ux kernel
> is included in the firmware image, it is built elsewhere=2E
>=20
>-It is of course possible to add more and more build rules to the U-Boot
>+It is of course possible to add further build rules to the U-Boot
> build system to cover these cases=2E It can shell out to other Makefiles=
 and
>-build scripts=2E But it seems better to create a clear divide between bu=
ilding
>+build scripts=2E But it seems preferable to create a clear divide betwee=
n building
> software and packaging it=2E
>=20
> At present this is handled by manual instructions, different for each bo=
ard,
>@@ -82,7 +82,7 @@ Benefits:
>   - Avoids cluttering the U-Boot build system with image-building code
>   - The image description is automatically available at run-time in U-Bo=
ot,
>     SPL=2E It can be made available to other software also
>-  - The image description is easily readable (it's a text file in device=
-tree
>+  - The image description is easily readable (a text file in device-tree
>     format) and permits flexible packing of binaries
>=20
>=20
>@@ -102,7 +102,7 @@ You can install binman using::
>=20
>    pip install binary-manager
>=20
>-The name is chosen since binman conflicts with an existing package=2E
>+The name was chosen since binman conflicts with an existing package=2E
>=20
> If you are using binman within the U-Boot tree, it may be easiest to add=
 a
> symlink from your local `~/=2Ebin` directory to `/path/to/tools/binman/b=
inman`=2E
>@@ -116,9 +116,9 @@ load / execution addresses, compression=2E It also su=
pports verification
> through hashing and RSA signatures=2E
>=20
> FIT was originally designed to support booting a Linux kernel (with an
>-optional ramdisk) and device tree chosen from various options in the FIT=
=2E
>-Now that U-Boot supports configuration via device tree, it is possible t=
o
>-load U-Boot from a FIT, with the device tree chosen by SPL=2E
>+optional ramdisk) and device-tree chosen from assorted options in the FI=
T=2E
>+Now that U-Boot supports configuration via device-tree, it is possible t=
o
>+load U-Boot from a FIT, with the device-tree chosen by SPL=2E
>=20
> Binman considers FIT to be one of the binaries it can place in the image=
=2E
>=20
>@@ -140,7 +140,7 @@ Relationship to mkimage
> -----------------------
>=20
> The mkimage tool provides a means to create a FIT=2E Traditionally it ha=
s
>-needed an image description file: a device tree, like binman, but in a
>+needed an image description file: a device-tree, like binman, but in a
> different format=2E More recently it has started to support a '-f auto' =
mode
> which can generate that automatically=2E
>=20
>@@ -173,7 +173,7 @@ build system=2E
> Consider sunxi=2E It has the following steps:
>=20
>   #=2E It uses a custom mksunxiboot tool to build an SPL image called
>-     sunxi-spl=2Ebin=2E This should probably move into mkimage=2E
>+     sunxi-spl=2Ebin=2E This should better go into mkimage=2E
>=20
>   #=2E It uses mkimage to package U-Boot into a legacy image file (so th=
at it can
>      hold the load and execution address) called u-boot=2Eimg=2E
>@@ -193,7 +193,7 @@ can be replaced by a call to binman=2E
> Invoking binman within U-Boot
> -----------------------------
>=20
>-Within U-Boot, binman is invoked by the build system, i=2Ee=2E when you =
type 'make'
>+Within U-Boot, binman is invoked by the build system, i=2Ee=2E, when you=
 type 'make'
> or use buildman to build U-Boot=2E There is no need to run binman indepe=
ndently
> during development=2E Everything happens automatically and is set up for=
 your
> SoC or board so that binman produced the right things=2E
>@@ -208,10 +208,10 @@ invocations as well, but these should be dropped wh=
en those architectures are
> converted to use binman properly=2E
>=20
> As above, the term 'binary' is used for something in INPUTS-y and 'image=
' is
>-used for the things that binman creates=2E So the binaries are inputs to=
 the
>-image(s) and it is the image that is actually loaded on the board=2E
>+used for the things that binman creates=2E Hence, the binaries are input=
s to the
>+ image(s), and it is the image that is actually loaded on the board=2E
>=20
>-Again, at present, there are a number of things created in Makefile whic=
h should
>+Again, at present, there are a few things created in Makefile which shou=
ld
> be done by binman (when we get around to it), like `u-boot-ivt=2Eimg`,
> `lpc32xx-spl=2Eimg`, `u-boot-with-nand-spl=2Eimx`, `u-boot-spl-padx4=2Es=
fp` and
> `u-boot-mtk=2Ebin`, just to pick on a few=2E When completed this will re=
move about
>@@ -222,15 +222,15 @@ are needed, in that one invocation=2E It does this =
by working through the image
> descriptions one by one, collecting the input binaries, processing them =
as
> needed and producing the final images=2E
>=20
>-The same binaries may be used by multiple images=2E For example binman m=
ay be used
>+The same binaries may be used for multiple images=2E For example, binman=
 may be used
> to produce an SD-card image and a SPI-flash image=2E In this case the bi=
naries
> going into the process are the same, but binman produces slightly differ=
ent
> images in each case=2E
>=20
> For some SoCs, U-Boot is not the only project that produces the necessar=
y
> binaries=2E For example, ARM Trusted Firmware (ATF) is a project that pr=
oduces
>-binaries which must be incorporate, such as `bl31=2Eelf` or `bl31=2Ebin`=
=2E For this
>-to work you must have built ATF before you build U-Boot and you must tel=
l U-Boot
>+binaries which must be incorporated, such as `bl31=2Eelf` or `bl31=2Ebin=
`=2E For this
>+to work you must have built ATF before you build U-Boot, and you must te=
ll U-Boot
> where to find the bl31 image, using the BL31 environment variable=2E
>=20
> How do you know how to incorporate ATF? It is handled by the atf-bl31 en=
try type
>@@ -267,29 +267,29 @@ nor is there any need to provide a real ATF BL31 bi=
nary (for example)=2E These can
> be added later by invoking binman again, providing all the required inpu=
ts
> from the first time, plus any that were missing or placeholders=2E
>=20
>-So in practice binman is often used twice:
>+Then, in practice binman is often used twice:
>=20
>-- once within the U-Boot build system, for development and testing
>-- again outside U-Boot to assembly and final production images
>+- Once within the U-Boot build system, for development and testing
>+- Again, outside U-Boot to assembly and final production images
>=20
> While the same input binaries are used in each case, you will of course =
you will
>-need to create your own binman command line, similar to that in `cmd_bin=
man` in
>+need to create your own binman command line, like that in `cmd_binman` i=
n
> the Makefile=2E You may find the -I and --toolpath options useful=2E The
>-device tree file is provided to binman in binary form, so there is no ne=
ed to
>+Device-tree file is provided to binman in binary form, so there is no ne=
ed to
> have access to the original `=2Edts` sources=2E
>=20
>=20
> Assembling the image description
> --------------------------------
>=20
>-Since binman uses the device tree for its image description, you can use=
 the
>+Since binman uses the device-tree for its image description, you can use=
 the
> same files that describe your board's hardware to describe how the image=
 is
>-assembled=2E Typically the images description is in a common file used b=
y all
>+assembled=2E Typically, the images description is in a common file used =
by all
> boards with a particular SoC (e=2Eg=2E `imx8mp-u-boot=2Edtsi`)=2E
>=20
>-Where a particular boards needs to make changes, it can override propert=
ies in
>-the SoC file, just as it would for any other device tree property=2E It =
can also
>-add a image that is specific to the board=2E
>+Where a particular board needs to make changes, it can override properti=
es in
>+the SoC file, just as it would for any other device-tree property=2E It =
can also
>+add an image that is specific to the board=2E
>=20
> Another way to control the image description to make use of CONFIG optio=
ns in
> the description=2E For example, if the start offset of a particular entr=
y varies
>@@ -303,7 +303,7 @@ by board, you can add a Kconfig for that and referenc=
e it in the description::
>         =2E=2E=2E
>     };
>=20
>-The SoC can provide a default value but boards can override that as need=
ed and
>+The SoC can provide a default value, but boards can override that as nee=
ded and
> binman will take care of it=2E
>=20
> It is even possible to control which entries appear in the image, by usi=
ng the
>@@ -317,15 +317,15 @@ C preprocessor::
>=20
> Only boards which enable `HAVE_MRC` will include this entry=2E
>=20
>-Obviously a similar approach can be used to control which images are pro=
duced,
>-with a Kconfig option to enable a SPI image, for example=2E However ther=
e is
>-generally no harm in producing an image that is not used=2E If a board u=
ses MMC
>+Obviously, a similar approach can be used to control which images are pr=
oduced,
>+with a Kconfig option to enable a SPI image, for example=2E However, the=
re is
>+no general harm in producing an image that is not used=2E If a board use=
s MMC
> but not SPI, but the SoC supports booting from both, then both images ca=
n be
>-produced, with only on or other being used by particular boards=2E This =
can help
>-reduce the need for having multiple defconfig targets for a board where =
the
>+produced, with only one or other being used by a particular board=2E Thi=
s can help
>+reduce the need for having multiple defconfig targets, for boards where =
the
> only difference is the boot media, enabling / disabling secure boot, etc=
=2E
>=20
>-Of course you can use the device tree itself to pass any board-specific
>+Of course, you can use the device-tree itself to pass any board-specific
> information that is needed by U-Boot at runtime (see binman_syms_ for ho=
w to
> make binman insert these values directly into executables like SPL)=2E
>=20
>@@ -341,14 +341,14 @@ Producing images for multiple boards
> When invoked within U-Boot, binman only builds a single set of images, f=
or
> the chosen board=2E This is set by the `CONFIG_DEFAULT_DEVICE_TREE` opti=
on=2E
>=20
>-However, U-Boot generally builds all the device tree files associated wi=
th an
>-SoC=2E These are written to the (e=2Eg=2E for ARM) `arch/arm/dts` direct=
ory=2E Each of
>+However, U-Boot builds all the device-tree files associated with an
>+SoC=2E These are written in the (e=2Eg=2E for ARM) `arch/arm/dts` direct=
ory=2E Each of
> these contains the full binman description for that board=2E Often the b=
est
>-approach is to build a single image that includes all these device tree =
binaries
>+approach is to build a single image that includes all these device-tree =
binaries
> and allow SPL to select the correct one on boot=2E
>=20
> However, it is also possible to build separate images for each board, si=
mply by
>-invoking binman multiple times, once for each device tree file, using a
>+invoking binman multiple times, once for each device-tree file, using a
> different output directory=2E This will produce one set of images for ea=
ch board=2E
>=20
>=20
>@@ -429,7 +429,7 @@ build=2E
>=20
> (Future work will make this more configurable)
>=20
>-In either case, binman picks up the device tree file (u-boot=2Edtb) and =
looks
>+In either case, binman picks up the device-tree file (u-boot=2Edtb) and =
looks
> for its instructions in the 'binman' node=2E
>=20
> Binman has a few other options which you can see by running 'binman -h'=
=2E
>@@ -441,7 +441,7 @@ Enabling binman for a board
> At present binman is invoked from a rule in the main Makefile=2E You sho=
uld be
> able to enable CONFIG_BINMAN to enable this rule=2E
>=20
>-The output file is typically named image=2Ebin and is located in the out=
put
>+The output file is typically named image=2Ebin and is in the output
> directory=2E If input files are needed to you add these to INPUTS-y eith=
er in the
> main Makefile or in a config=2Emk file in your arch subdirectory=2E
>=20
>@@ -476,19 +476,19 @@ You can access this value with something like:
>     ulong u_boot_offset =3D binman_sym(ulong, u_boot_any, image_pos);
>=20
> Thus u_boot_offset will be set to the image-pos of U-Boot in memory, ass=
uming
>-that the whole image has been loaded, or is available in flash=2E You ca=
n then
>+that the whole image has been loaded or is available in flash=2E You can=
 then
> jump to that address to start U-Boot=2E
>=20
> At present this feature is only supported in SPL and TPL=2E In principle=
 it is
> possible to fill in such symbols in U-Boot proper, as well, but a future=
 C
>-library is planned for this instead, to read from the device tree=2E
>+library is planned for this instead, to read from the device-tree=2E
>=20
> As well as image-pos, it is possible to read the size of an entry and it=
s
> offset (which is the start position of the entry within its parent)=2E
>=20
> A small technical note: Binman automatically adds the base address of th=
e image
> (i=2Ee=2E __image_copy_start) to the value of the image-pos symbol, so t=
hat when the
>-image is loaded to its linked address, the value will be correct and act=
ually
>+image is loaded to its linked address; the value will be correct and act=
ually
> point into the image=2E
>=20
> For example, say SPL is at the start of the image and linked to start at=
 address
>@@ -523,7 +523,7 @@ each entry in the images it processes=2E The option t=
o enable this is -u and it
> causes binman to make sure that the 'offset', 'image-pos' and 'size' pro=
perties
> are set correctly for every entry=2E Since it is not necessary to specif=
y these in
> the image definition, binman calculates the final values and writes thes=
e to
>-the device tree=2E These can be used by U-Boot at run-time to find the l=
ocation
>+the device-tree=2E These can be used by U-Boot at run-time to find the l=
ocation
> of each entry=2E
>=20
> Alternatively, an FDT map entry can be used to add a special FDT contain=
ing
>@@ -556,8 +556,8 @@ Passing command-line arguments to entries
> -----------------------------------------
>=20
> Sometimes it is useful to pass binman the value of an entry property fro=
m the
>-command line=2E For example some entries need access to files and it is =
not
>-always convenient to put these filenames in the image definition (device=
 tree)=2E
>+command line=2E For example, some entries need access to files, and it i=
s not
>+always convenient to put these filenames in the image definition (device=
-tree)=2E
>=20
> The -a option supports this::
>=20
>@@ -594,7 +594,7 @@ This requests binman to create an image file called u=
-boot-sunxi-with-spl=2Ebin
> consisting of a specially formatted SPL (spl/sunxi-spl=2Ebin, built by t=
he
> normal U-Boot Makefile), some 0xff padding, and a U-Boot legacy image=2E=
 The
> padding comes from the fact that the second binary is placed at
>-CONFIG_SPL_PAD_TO=2E If that line were omitted then the U-Boot binary wo=
uld
>+CONFIG_SPL_PAD_TO=2E If that line were omitted, then the U-Boot binary w=
ould
> immediately follow the SPL binary=2E
>=20
> The binman node describes an image=2E The sub-nodes describe entries in =
the
>@@ -606,7 +606,7 @@ Entries are normally placed into the image sequential=
ly, one after the other=2E
> The image size is the total size of all entries=2E As you can see, you c=
an
> specify the start offset of an entry using the 'offset' property=2E
>=20
>-Note that due to a device tree requirement, all entries must have a uniq=
ue
>+Note that due to a device-tree requirement, all entries must have a uniq=
ue
> name=2E If you want to put the same binary in the image multiple times, =
you can
> use any unique name, with the 'type' property providing the type=2E
>=20
>@@ -622,7 +622,7 @@ offset:
> align:
>     This sets the alignment of the entry=2E The entry offset is adjusted
>     so that the entry starts on an aligned boundary within the containin=
g
>-    section or image=2E For example 'align =3D <16>' means that the entr=
y will
>+    section or image=2E For example, 'align =3D <16>' means that the ent=
ry will
>     start on a 16-byte boundary=2E This may mean that padding is added b=
efore
>     the entry=2E The padding is part of the containing section but is no=
t
>     included in the entry, meaning that an empty space may be created be=
fore
>@@ -639,7 +639,7 @@ min-size:
>     ('pad-before' and 'pad-after'), but not padding added to meet alignm=
ent
>     requirements=2E While this does not affect the contents of the entry=
 within
>     binman itself (the padding is performed only when its parent section=
 is
>-    assembled), the end result will be that the entry ends with the padd=
ing
>+    assembled), the result will be that the entry ends with the padding
>     bytes, so may grow=2E Defaults to 0=2E
>=20
> pad-before:
>@@ -647,8 +647,8 @@ pad-before:
>     that the contents start at the beginning of the entry=2E This can be=
 used
>     to offset the entry contents a little=2E While this does not affect =
the
>     contents of the entry within binman itself (the padding is performed
>-    only when its parent section is assembled), the end result will be t=
hat
>-    the entry starts with the padding bytes, so may grow=2E Defaults to =
0=2E
>+    only when its parent section is assembled), the result will be that
>+    the entry starts with the padding bytes, so it may grow=2E Defaults =
to 0=2E
>=20
> pad-after:
>     Padding after the contents of the entry=2E Normally this is 0, meani=
ng
>@@ -656,7 +656,7 @@ pad-after:
>     other properties)=2E This allows room to be created in the image for
>     this entry to expand later=2E While this does not affect the content=
s of
>     the entry within binman itself (the padding is performed only when i=
ts
>-    parent section is assembled), the end result will be that the entry =
ends
>+    parent section is assembled), the result will be that the entry ends
>     with the padding bytes, so may grow=2E Defaults to 0=2E
>=20
> align-size:
>@@ -664,7 +664,7 @@ align-size:
>     that the size of an entry is a multiple of 64 bytes, set this to 64=
=2E
>     While this does not affect the contents of the entry within binman
>     itself (the padding is performed only when its parent section is
>-    assembled), the end result is that the entry ends with the padding
>+    assembled), the result is that the entry ends with the padding
>     bytes, so may grow=2E If 'align-size' is not provided, no alignment =
is
>     performed=2E
>=20
>@@ -675,7 +675,7 @@ align-end:
>     of the entry, so the contents of the entry will still start at the
>     beginning=2E But there may be padding at the end=2E While this does =
not
>     affect the contents of the entry within binman itself (the padding i=
s
>-    performed only when its parent section is assembled), the end result
>+    performed only when its parent section is assembled), the result
>     is that the entry ends with the padding bytes, so may grow=2E
>     If 'align-end' is not provided, no alignment is performed=2E
>=20
>@@ -708,7 +708,7 @@ extend-size:
>     entry=2E
>=20
> compress:
>-    Sets the compression algortihm to use (for blobs only)=2E See the en=
try
>+    Sets the compression algorithm to use (for blobs only)=2E See the en=
try
>     documentation for details=2E
>=20
> missing-msg:
>@@ -725,23 +725,23 @@ assume-size:
>     size if requested=2E
>=20
> no-expanded:
>-    By default binman substitutes entries with expanded versions if avai=
lable,
>+    By default, binman substitutes entries with expanded versions if ava=
ilable,
>     so that a `u-boot` entry type turns into `u-boot-expanded`, for exam=
ple=2E The
>     `--no-expanded` command-line option disables this globally=2E The
>     `no-expanded` property disables this just for a single entry=2E Put =
the
>-    `no-expanded` boolean property in the node to select this behaviour=
=2E
>+    `no-expanded` boolean property in the node to select this behavior=
=2E
>=20
> optional:
>     External blobs are normally required to be present for the image to =
be
>     built (but see `External blobs`_)=2E This properly allows an entry t=
o be
>-    optional, so that when it is cannot be found, this problem is ignore=
d and
>+    optional, so that when it cannot be found, this problem is ignored a=
nd
>     an empty file is used for this blob=2E This should be used only when=
 the blob
>     is entirely optional and is not needed for correct operation of the =
image=2E
>     Note that missing, optional blobs do not produce a non-zero exit cod=
e from
>     binman, although it does show a warning about the missing external b=
lob=2E
>=20
> insert-template:
>-    This is not strictly speaking an entry property, since it is process=
ed early
>+    This is not an entry property, since it is processed early
>     in Binman before the entries are read=2E It is a list of phandles of=
 nodes to
>     include in the current (target) node=2E For each node, its subnodes =
and their
>     properties are brought into the target node=2E See Templates_ below =
for
>@@ -751,7 +751,7 @@ symbols-base:
>     When writing symbols into a binary, the value of that symbol is assu=
med to
>     be relative to the base address of the binary=2E This allow the bina=
ry to be
>     loaded in memory at its base address, so that symbols point into the=
 binary
>-    correctly=2E In some cases the binary is in fact not yet in memory, =
but must
>+    correctly=2E In some cases, the binary is in fact not yet in memory,=
 but must
>     be read from storage=2E In this case there is no base address for th=
e symbols=2E
>     This property can be set to 0 to indicate this=2E Other values for
>     symbols-base are allowed, but care must be taken that the code which=
 uses
>@@ -759,14 +759,14 @@ symbols-base:
>     address is used=2E
>=20
> The attributes supported for images and sections are described below=2E =
Several
>-are similar to those for entries=2E
>+of them are like the attributes for entries=2E
>=20
> size:
>     Sets the image size in bytes, for example 'size =3D <0x100000>' for =
a
>     1MB image=2E
>=20
> offset:
>-    This is similar to 'offset' in entries, setting the offset of a sect=
ion
>+    This is like 'offset' in entries, setting the offset of a section
>     within the image or section containing it=2E The first byte of the s=
ection
>     is normally at offset 0=2E If 'offset' is not provided, binman sets =
it to
>     the end of the previous region, or the start of the image's entry ar=
ea
>@@ -799,7 +799,7 @@ sort-by-offset:
>     the 'offset' properties are set by CONFIG options, so their ordering=
 is
>     not known a priori=2E
>=20
>-    This is a boolean property so needs no value=2E To enable it, add a
>+    This is a boolean property, so it needs no value=2E To enable it, ad=
d a
>     line 'sort-by-offset;' to your description=2E
>=20
> multiple-images:
>@@ -842,7 +842,7 @@ skip-at-start:
>     Image size !=3D 4gb=2E
>=20
> align-default:
>-    Specifies the default alignment for entries in this section, if they=
 do
>+    Specifies the default alignment for entries in this section if they =
do
>     not specify an alignment=2E Note that this only applies to top-level=
 entries
>     in the section (direct subentries), not any subentries of those entr=
ies=2E
>     This means that each section must specify its own default alignment,=
 if
>@@ -883,7 +883,7 @@ elf-base-sym:
>     be read correctly=2E See binman_syms_ for more information=2E
>=20
> offset-from-elf:
>-    Sets the offset of an entry based on a symbol value in an another en=
try=2E
>+    Sets the offset of an entry based on a symbol value in another entry=
=2E
>     The format is <&phandle>, "sym_name", <offset> where phandle is the =
entry
>     containing the blob (with associated ELF file providing symbols), <s=
ym_name>
>     is the symbol to lookup (relative to elf-base-sym) and <offset> is a=
n offset
>@@ -894,7 +894,7 @@ preserve:
>     flag should be checked by the updater when it is deciding which entr=
ies to
>     update=2E This flag is normally attached to sections but can be atta=
ched to
>     a single entry in a section if the updater supports it=2E Not that b=
inman
>-    itself has no control over the updater's behaviour, so this is just =
a
>+    itself has no control over the updater's behavior, so this is just a
>     signal=2E It is not enforced by binman=2E
>=20
> Examples of the above options can be found in the tests=2E See the
>@@ -905,16 +905,16 @@ either by using a unit number suffix (u-boot@0, u-b=
oot@1) or by using a
> different name for each and specifying the type with the 'type' attribut=
e=2E
>=20
>=20
>-Sections and hierachical images
>+Sections and hierarchical images
> -------------------------------
>=20
> Sometimes it is convenient to split an image into several pieces, each o=
f which
> contains its own set of binaries=2E An example is a flash device where p=
art of
>-the image is read-only and part is read-write=2E We can set up sections =
for each
>+the image is read-only, and part is read-write=2E We can set up sections=
 for each
> of these, and place binaries in them independently=2E The image is still=
 produced
> as a single output file=2E
>=20
>-This feature provides a way of creating hierarchical images=2E For examp=
le here
>+This feature provides a way of creating hierarchical images=2E For examp=
le, here
> is an example image with two copies of U-Boot=2E One is read-only (ro), =
intended
> to be written only in the factory=2E Another is read-write (rw), so that=
 it can be
> upgraded in the field=2E The sizes are fixed so that the ro/rw boundary =
is known
>@@ -947,7 +947,7 @@ read-only:
>=20
> name-prefix:
>     This string is prepended to all the names of the binaries in the
>-    section=2E In the example above, the 'u-boot' binaries which actuall=
y be
>+    section=2E In the example above, the 'u-boot' binaries which be
>     renamed to 'ro-u-boot' and 'rw-u-boot'=2E This can be useful to
>     distinguish binaries with otherwise identical names=2E
>=20
>@@ -955,7 +955,7 @@ filename:
>     This allows the contents of the section to be written to a file in t=
he
>     output directory=2E This can sometimes be useful to use the data in =
one
>     section in different image, since there is currently no way to share=
 data
>-    beteen images other than through files=2E
>+    between images other than through files=2E
>=20
> Image Properties
> ----------------
>@@ -970,11 +970,11 @@ filename:
> allow-repack:
>     Create an image that can be repacked=2E With this option it is possi=
ble
>     to change anything in the image after it is created, including updat=
ing
>-    the position and size of image components=2E By default this is not
>-    permitted since it is not possibly to know whether this might violat=
e a
>-    constraint in the image description=2E For example, if a section has=
 to
>+    the position and size of image components=2E By default, this is not
>+    permitted since it is not possible to know whether this might violat=
e a
>+    constraint in the image description=2E For example, if a section mus=
t
>     increase in size to hold a larger binary, that might cause the secti=
on
>-    to fall out of its allow region (e=2Eg=2E read-only portion of flash=
)=2E
>+    to fall out of its allow-region (e=2Eg=2E read-only portion of flash=
)=2E
>=20
>     Adding this property causes the original offset and size values in t=
he
>     image description to be stored in the FDT and fdtmap=2E
>@@ -985,7 +985,7 @@ Image dependencies
>=20
> Binman does not currently support images that depend on each other=2E Fo=
r example,
> if one image creates `fred=2Ebin` and then the next uses this `fred=2Ebi=
n` to
>-produce a final `image=2Ebin`, then the behaviour is undefined=2E It may=
 work, or it
>+produce a final `image=2Ebin`, then the behavior is undefined=2E It may =
work, or it
> may produce an error about `fred=2Ebin` being missing, or it may use a v=
ersion of
> `fred=2Ebin` from a previous run=2E
>=20
>@@ -1045,10 +1045,10 @@ value back to the device-tree node=2E For example=
::
>=20
> Here, a new 'value' property will be written to the 'hash' node containi=
ng
> the hash of the 'u-boot' entry=2E Only SHA256 is supported at present=2E=
 Whole
>-sections can be hased if desired, by adding the 'hash' node to the secti=
on=2E
>+sections can be hashed if desired, by adding the 'hash' node to the sect=
ion=2E
>=20
>-The has value can be chcked at runtime by hashing the data actually read=
 and
>-comparing this has to the value in the device tree=2E
>+The hash value can be checked at runtime by hashing the data read and
>+comparing this hash to the value in the device-tree=2E
>=20
>=20
> Expanded entries
>@@ -1078,14 +1078,14 @@ which in turn expands to::
>         };
>     };
>=20
>-U-Boot's various phase binaries actually comprise two or three pieces=2E
>-For example, u-boot=2Ebin has the executable followed by a devicetree=2E
>+U-Boot's phase binaries comprise two or three pieces=2E For example, u-b=
oot=2Ebin
>+has the executable followed by a device-tree=2E
>=20
>-With binman we want to be able to update that devicetree with full image
>+With binman we want to be able to update that device-tree with full imag=
e
> information so that it is accessible to the executable=2E This is tricky
>-if it is not clear where the devicetree starts=2E
>+if it is not clear where the device-tree starts=2E
>=20
>-The above feature ensures that the devicetree is clearly separated from =
the
>+The above feature ensures that the device-tree is clearly separated from=
 the
> U-Boot executable and can be updated separately by binman as needed=2E I=
t can be
> disabled with the --no-expanded flag if required=2E
>=20
>@@ -1117,11 +1117,11 @@ which in turn expands to::
>         };
>     };
>=20
>-Of course we should not expand SPL if it has no devicetree=2E Also if th=
e BSS
>+Of course, we should not expand SPL if it has no device-tree=2E Also, if=
 the BSS
> padding is not needed (because BSS is in RAM as with CONFIG_SPL_SEPARATE=
_BSS),
>-the 'u-boot-spl-bss-pad' subnode should not be created=2E The use of the=
 expaned
>+the 'u-boot-spl-bss-pad' subnode should not be created=2E The use of the=
 expanded
> entry type is controlled by the UseExpanded() method=2E In the SPL case =
it checks
>-the 'spl-dtb' entry arg, which is 'y' or '1' if SPL has a devicetree=2E
>+the 'spl-dtb' entry arg, which is 'y' or '1' if SPL has a device-tree=2E
>=20
> For the BSS case, a 'spl-bss-pad' entry arg controls whether it is prese=
nt=2E All
> entry args are provided by the U-Boot Makefile=2E
>@@ -1749,7 +1749,7 @@ Options:
> Options used only for testing:
>=20
> --fake-dtb
>-    Use fake device tree contents
>+    Use fake device-tree contents
>=20
> --fake-ext-blobs
>     Create fake ext blobs with dummy content
>@@ -1789,7 +1789,7 @@ Positional arguments:
> paths
>     Paths within file to list (wildcard)
>=20
>-Pptions:
>+Options:
>=20
> -h, --help
>     show help message and exit
>@@ -1899,7 +1899,7 @@ Options:
>=20
> -P PROCESSES, --processes PROCESSES
>     set number of processes to use for running tests=2E This defaults to=
 the
>-    number of CPUs on the machine
>+    numbering the CPUs on the machine
>=20
> -T, --test-coverage
>     run tests and check for 100% coverage
>@@ -1974,13 +1974,13 @@ Image creation proceeds in the following order, f=
or each entry in the image=2E
> 1=2E AddMissingProperties() - binman can add calculated values to the de=
vice
> tree as part of its processing, for example the offset and size of each
> entry=2E This method adds any properties associated with this, expanding=
 the
>-device tree as needed=2E These properties can have placeholder values wh=
ich are
>-set later by SetCalculatedProperties()=2E By that stage the size of sect=
ions
>+device-tree as needed=2E These properties can have placeholder values wh=
ich are
>+set later by SetCalculatedProperties()=2E By that stage, the size of sec=
tions
> cannot be changed (since it would cause the images to need to be repacke=
d),
> but the correct values can be inserted=2E
>=20
>-2=2E ProcessFdt() - process the device tree information as required by t=
he
>-particular entry=2E This may involve adding or deleting properties=2E If=
 the
>+2=2E ProcessFdt() - process the device-tree information as required by t=
he
>+entry=2E This may involve adding or deleting properties=2E If the
> processing is complete, this method should return True=2E If the process=
ing
> cannot complete because it needs the ProcessFdt() method of another entr=
y to
> run first, this method should return False, in which case it will be cal=
led
>@@ -1989,7 +1989,7 @@ again later=2E
> 3=2E GetEntryContents() - the contents of each entry are obtained, norma=
lly by
> reading from a file=2E This calls the Entry=2EObtainContents() to read t=
he
> contents=2E The default version of Entry=2EObtainContents() calls
>-Entry=2EGetDefaultFilename() and then reads that file=2E So a common mec=
hanism
>+Entry=2EGetDefaultFilename() and then reads that file=2E Thus, a common =
mechanism
> to select a file to read is to override that function in the subclass=2E=
 The
> functions must return True when they have read the contents=2E Binman wi=
ll
> retry calling the functions a few times if False is returned, allowing
>@@ -2039,7 +2039,7 @@ what happens in this stage=2E
> 11=2E BuildImage() - builds the image and writes it to a file
>=20
> 12=2E WriteMap() - writes a text file containing a map of the image=2E T=
his is the
>-final step=2E
>+last step=2E
>=20
>=20
> =2E=2E _`External tools`:
>@@ -2049,14 +2049,14 @@ External tools
>=20
> Binman can make use of external command-line tools to handle processing =
of
> entry contents or to generate entry contents=2E These tools are executed=
 using
>-the 'tools' module's Run() method=2E The tools generally must exist on t=
he PATH,
>+the 'tools' module's Run() method=2E The tools must exist on the PATH,
> but the --toolpath option can be used to specify additional search paths=
 to
> use=2E This option can be specified multiple times to add more than one =
path=2E
>=20
>-For some compile tools binman will use the versions specified by commonl=
y-used
>+For some compile tools binman will use the versions specified by commonl=
y used
> environment variables like CC and HOSTCC for the C compiler, based on wh=
ether
> the tool's output will be used for the target or for the host machine=2E=
 If those
>-aren't given, it will also try to derive target-specific versions from t=
he
>+are not given, it will also try to derive target-specific versions from =
the
> CROSS_COMPILE environment variable during a cross-compilation=2E
>=20
> If the tool is not available in the path you can use BINMAN_TOOLPATHS to=
 specify
>@@ -2077,7 +2077,7 @@ to build the final image, no matter what steps are =
needed to get there=2E
>=20
> Binman also provides a `blob-ext` entry type that pulls in a binary blob=
 from an
> external file=2E If the file is missing, binman can optionally complete =
the build
>-and just report a warning=2E Use the `-M/--allow-missing` option to enbl=
e this=2E
>+and just report a warning=2E Use the `-M/--allow-missing` option to enab=
le this=2E
> This is useful in CI systems which want to check that everything is corr=
ect but
> don't have access to the blobs=2E
>=20
>@@ -2172,7 +2172,7 @@ symbol tells binman the size of the BSS region, in =
bytes=2E It needs this to be
> able to pad the image so that the following entries do not overlap the B=
SS,
> which would cause them to be overwritte by variable access in SPL=2E
>=20
>-This symbols is normally defined in the linker script, immediately after
>+These symbols are normally defined in the linker script, immediately aft=
er
> _bss_start and __bss_end are defined, like this::
>=20
>     __bss_size =3D __bss_end - __bss_start;
>@@ -2186,7 +2186,7 @@ Concurrent tests
> Binman tries to run tests concurrently=2E This means that the tests make=
 use of
> all available CPUs to run=2E
>=20
>- To enable this::
>+ Enable this::
>=20
>    $ sudo apt-get install python-subunit python3-subunit
>=20
>@@ -2202,7 +2202,7 @@ See :doc:`=2E=2E/binman_tests`=2E
> Debugging tests
> ---------------
>=20
>-Sometimes when debugging tests it is useful to keep the input and output
>+Sometimes when debugging tests, it is useful to keep the input and outpu=
t
> directories so they can be examined later=2E Use -X or --test-preserve-d=
irs for
> this=2E
>=20
>@@ -2363,10 +2363,10 @@ blob can come from any suitable place, such as an=
 `Entry_u_boot` or an
>=20
> The `soc-fw` node is a `blob-ext` (i=2Ee=2E it reads in a named binary f=
ile) whereas
> `u-boot` is a normal entry type=2E This works because `Entry_fip` select=
s the
>-`blob-ext` entry type if the node name (here `soc-fw`) is recognised as =
being
>+`blob-ext` entry type if the node name (here `soc-fw`) is recognized as =
being
> a known blob type=2E
>=20
>-When adding new entry types you are encouraged to use subnodes to provid=
e the
>+When adding new entry types, you are encouraged to use subnodes to provi=
de the
> data for processing, unless the `content` approach is more suitable=2E C=
onsider
> whether the input entries are contained within (or consumed by) the entr=
y, vs
> just being 'referenced' by the entry=2E In the latter case, the `content=
` approach
>@@ -2378,8 +2378,8 @@ History / Credits
>=20
> Binman takes a lot of inspiration from a Chrome OS tool called
> 'cros_bundle_firmware', which I wrote some years ago=2E That tool was ba=
sed on
>-a reasonably simple and sound design but has expanded greatly over the
>-years=2E In particular its handling of x86 images is convoluted=2E
>+a simple and sound design but has expanded over the
>+years=2E In particular, its handling of x86 images is convoluted=2E
>=20
> Quite a few lessons have been learned which are hopefully applied here=
=2E
>=20
>@@ -2387,11 +2387,11 @@ Quite a few lessons have been learned which are h=
opefully applied here=2E
> Design notes
> ------------
>=20
>-On the face of it, a tool to create firmware images should be fairly sim=
ple:
>+On the face of it, a tool to create firmware images should be simple:
> just find all the input binaries and place them at the right place in th=
e
> image=2E The difficulty comes from the wide variety of input types (simp=
le
> flat binaries containing code, packaged data with various headers), pack=
ing
>-requirments (alignment, spacing, device boundaries) and other required
>+requirements (alignment, spacing, device boundaries) and other required
> features such as hierarchical images=2E
>=20
> The design challenge is to make it easy to create simple images, while
>@@ -2409,7 +2409,7 @@ To do
> Some ideas:
>=20
> - Use of-platdata to make the information available to code that is unab=
le
>-  to use device tree (such as a very small SPL image)=2E For now, limite=
d info is
>+  to use device-tree (such as a small SPL image)=2E For now, limited inf=
o is
>   available via linker symbols
> - Allow easy building of images by specifying just the board name
> - Support building an image for a board (-b) more completely, with a
>@@ -2417,7 +2417,7 @@ Some ideas:
> - Detect invalid properties in nodes
> - Sort the fdtmap by offset
> - Output temporary files to a different directory
>-- Rationalise the fdt, fdt_util and pylibfdt modules which currently hav=
e some
>+- Rationalize the fdt, fdt_util and pylibfdt modules which currently hav=
e some
>   overlapping and confusing functionality
> - Update the fdt library to use a better format for Prop=2Evalue (the cu=
rrent one
>   is useful for dtoc but not much else)

