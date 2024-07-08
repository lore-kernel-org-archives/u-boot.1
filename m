Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768A7C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 16:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE141887E4;
	Mon,  8 Jul 2024 18:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Q/UGNodT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6902B887CF; Mon,  8 Jul 2024 18:13:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75341887E4
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 18:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720455217; x=1721060017; i=xypron.glpk@gmx.de;
 bh=vqm8ik6rlwr5b4ZO9+9QCB71BVOKJdNh3zPlMBbadf0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Q/UGNodT+rSHJba8EFQ/zlLWvX1ZN31T33OsYYM35445Skl/UsLgwKTW/EZFmzGP
 4HugaNC9Hz43rJlAHvUL2hONdI0utWDiigmuosDpffQvZxWywhd4FW3LFGnXQh6s/
 NPdQnrimrvUVkprDXhLexIl+5puRtmP7rZ9lnQxmFnaAxypvTBSLsJF6kpmgl6xwF
 XEE+RkCRF9GjXljcY9icc42+srGkpEoVQ8+UD/ICIy13j5S6Lzo/w3XoiUlTP4QxZ
 321H7FHitSMpZYhITpQB2n1qoyvvGDshnuZO44fLOb7nV9ssjEIpcQtkgt//GEiNs
 PrEyQ+I48Aqs1W4oFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1scySz2iyC-003sLA; Mon, 08
 Jul 2024 18:13:37 +0200
Message-ID: <04455d76-a76f-40a0-91ac-a04056c640fe@gmx.de>
Date: Mon, 8 Jul 2024 18:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/2] doc: Remove FIT documentation that is elsewhere
To: Sam Povilus <sam.povilus@amd.com>
Cc: git@amd.com, trini@konsulko.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20240708153941.1045588-1-sam.povilus@amd.com>
 <20240708153941.1045588-2-sam.povilus@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240708153941.1045588-2-sam.povilus@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1CRpr1l+VtcqCLHAj+hxWooOLo+vMV3BRO0l9anwCeo2VZNBDF0
 igeDzY6YzoBvnwiAMFkfKl0s2jojrMD0vI8R3MYs+8A9cV9AMKftfeozBr3l/VxyfxrzpOo
 GUNLBCO+EhcnklCCeRGWvX3gkTBAfhRo6cae05ngK8vrAMykdw4iflKBSNuj+oD0+GxO/Uf
 TTVK6gUEGnzgFURRP7uVQ==
UI-OutboundReport: notjunk:1;M01:P0:m1X1E1gdC1k=;kmwx4VE9klkdKE3FrvnmC2mkzDv
 Cmxa34MeZO1iJF9qosepre5d68K7nzTPbpW4P8XiblBojm8EvreMioh3r7+wC8dyNl8nFiGHo
 KfaltgiMHEXx5fDtoDCCHPcqb2+zkWBkKsjk2nQEHmWHq0tMM7ZqixJVJwoOtI4bZEzGMTL9I
 hXGhIsuPK1hmTsGZYdVuqJp4asobTb8YOT8Jjtj9m9eLSnT5ZtLlr9K66ByfxLMOieVfrs3g4
 02OZjvvg7mg7APc76nk9IWpZxaGq5G4Gh50YZPACtZyA2KlpyLEn07UTYoRs5ZZPSWmfHW947
 f21kx4XP8wmC0hJFu2kFPqQqb9/Aya5/wccQzmxEgHoqTEu+YG50iPO14V/1ZHOVRzo3Xvszv
 Uz720O5F1E+XiQxVazVCoe/HoY8jSKM3qO0N1pGtBvy8m/SWJtqY0baeJgrW/7XUbGCUFC8FU
 GHLIV1h7HD/OjmP954rvy8hpsS/yh1wj18h/IMgjtO7Q3YGe5vXJDrN3wGk06g0xtLP+MP/KX
 sirZv227nPWxCyUaAKm8YtvpweqdwzEaUMu9ioLCI6EZpiR0HBjIW2F37auvY+MJtV+QfYsIa
 PlhFIqDDja3qsQv6eDAzJpkoiWTKWNgekIbrrq72veP4RrPsMJbNhXedhJR/0h7SnV6OVL/fV
 I8K2+AB0wuB2kngABTxMjJ1NA2To6J7bBItXEweJK7ddthdCwggwF6RVvNrQIXrTqjNS1GSHb
 f+4Z3O6nsuiBvz6QdgghrPl4HxvfYJxS8koE9c563T0h3kJWfplwZfAUbZsneVXLTXQ0tcxBF
 HSRbOulCUCWfUxTg9KBpzFuo2xrhrPzPybJKwER6QrSrg=
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

On 08.07.24 17:39, Sam Povilus wrote:
> FIT documentation is now a separate project, instead of having a
> duplicate, we should point at the other project.
>
> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
> ---
>   doc/usage/fit/index.rst              |   5 +-
>   doc/usage/fit/source_file_format.rst | 682 +--------------------------
>   2 files changed, 5 insertions(+), 682 deletions(-)
>
> diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
> index bd25bd30b2..af2e481212 100644
> --- a/doc/usage/fit/index.rst
> +++ b/doc/usage/fit/index.rst
> @@ -4,13 +4,12 @@ Flat Image Tree (FIT)
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   U-Boot uses Flat Image Tree (FIT) as a standard file format for packag=
ing
> -images that it it reads and boots. Documentation about FIT is available=
 at
> -doc/uImage.FIT
> +images that it it reads and boots. Documentation about FIT is available=
 in

%s/it it/it/

> +`the Flattened Image Tree project <https://fitspec.osfw.foundation/>`_.
>
>   .. toctree::
>       :maxdepth: 1
>
> -    source_file_format

It would preferable not to remove the line in this patch instead of
adding it in the second patch again.

>       howto
>       x86-fit-boot
>       signature
> diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source=
_file_format.rst
> index b2b1e42bd7..0c44329a82 100644
> --- a/doc/usage/fit/source_file_format.rst
> +++ b/doc/usage/fit/source_file_format.rst
> @@ -3,682 +3,6 @@
>   Flattened Image Tree (FIT) Format
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Introduction
> -------------
> -
> -The number of elements playing a role in the kernel booting process has
> -increased over time and now typically includes the devicetree, kernel i=
mage and
> -possibly a ramdisk image. Generally, all must be placed in the system m=
emory and
> -booted together.
> -
> -For firmware images a similar process has taken place, with various bin=
aries
> -loaded at different addresses, such as ARM's ATF, OpenSBI, FPGA and U-B=
oot
> -itself.
> -
> -FIT provides a flexible and extensible format to deal with this complex=
ity. It
> -provides support for multiple components. It also supports multiple
> -configurations, so that the same FIT can be used to boot multiple board=
s, with
> -some components in common (e.g. kernel) and some specific to that board=
 (e.g.
> -devicetree).
> -
> -Terminology
> -~~~~~~~~~~~
> -
> -This document defines FIT by providing FDT (Flat Device Tree) bindings.=
 These
> -describe the final form of the FIT at the moment when it is used. The u=
ser
> -perspective may be simpler, as some of the properties (like timestamps =
and
> -hashes) are filled in automatically by the U-Boot mkimage tool.
> -
> -To avoid confusion with the kernel FDT the following naming convention =
is used:
> -
> -FIT
> -    Flattened Image Tree
> -
> -FIT is formally a flattened devicetree (in the libfdt meaning), which c=
onforms
> -to bindings defined in this document.
> -
> -.its
> -    image tree source
> -
> -.itb
> -    flattened image tree blob
> -
> -Image-building procedure
> -~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -The following picture shows how the FIT is prepared. Input consists of
> -image source file (.its) and a set of data files. Image is created with=
 the
> -help of standard U-Boot mkimage tool which in turn uses dtc (device tre=
e
> -compiler) to produce image tree blob (.itb). The resulting .itb file is=
 the
> -actual binary of a new FIT::
> -
> -    tqm5200.its
> -    +
> -    vmlinux.bin.gz     mkimage + dtc               xfer to target
> -    eldk-4.2-ramdisk  --------------> tqm5200.itb --------------> boot
> -    tqm5200.dtb                          /|\
> -                                          |
> -                                     'new FIT'
> -
> -Steps:
> -
> -#. Create .its file, automatically filled-in properties are omitted
> -
> -#. Call mkimage tool on a .its file
> -
> -#. mkimage calls dtc to create .itb image and assures that
> -   missing properties are added
> -
> -#. .itb (new FIT) is uploaded onto the target and used therein
> -
> -
> -Unique identifiers
> -~~~~~~~~~~~~~~~~~~
> -
> -To identify FIT sub-nodes representing images, hashes, configurations (=
which
> -are defined in the following sections), the "unit name" of the given su=
b-node
> -is used as it's identifier as it assures uniqueness without additional
> -checking required.
> -
> -
> -External data
> -~~~~~~~~~~~~~
> -
> -FIT is normally built initially with image data in the 'data' property =
of each
> -image node. It is also possible for this data to reside outside the FIT=
 itself.
> -This allows the 'FDT' part of the FIT to be quite small, so that it can=
 be
> -loaded and scanned without loading a large amount of data. Then when an=
 image is
> -needed it can be loaded from an external source.
> -
> -External FITs use 'data-offset' or 'data-position' instead of 'data'.
> -
> -The mkimage tool can convert a FIT to use external data using the `-E` =
argument,
> -optionally using `-p` to specific a fixed position.
> -
> -It is often desirable to align each image to a block size or cache-line=
 size
> -(e.g. 512 bytes), so that there is no need to copy it to an aligned add=
ress when
> -reading the image data. The mkimage tool provides a `-B` argument to su=
pport
> -this.
> -
> -Root-node properties
> ---------------------
> -
> -The root node of the FIT should have the following layout::
> -
> -    / o image-tree
> -        |- description =3D "image description"
> -        |- timestamp =3D <12399321>
> -        |- #address-cells =3D <1>
> -        |
> -        o images
> -        | |
> -        | o image-1 {...}
> -        | o image-2 {...}
> -        | ...
> -        |
> -        o configurations
> -          |- default =3D "conf-1"
> -          |
> -          o conf-1 {...}
> -          o conf-2 {...}
> -          ...
> -
> -Optional property
> -~~~~~~~~~~~~~~~~~
> -
> -description
> -    Textual description of the FIT
> -
> -Mandatory property
> -~~~~~~~~~~~~~~~~~~
> -
> -timestamp
> -    Last image modification time being counted in seconds since
> -    1970-01-01 00:00:00 - to be automatically calculated by mkimage too=
l.
> -
> -Conditionally mandatory property
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -#address-cells
> -    Number of 32bit cells required to represent entry and
> -    load addresses supplied within sub-image nodes. May be omitted when=
 no
> -    entry or load addresses are used.
> -
> -Mandatory nodes
> -~~~~~~~~~~~~~~~
> -
> -images
> -    This node contains a set of sub-nodes, each of them representing
> -    single component sub-image (like kernel, ramdisk, etc.). At least o=
ne
> -    sub-image is required.
> -
> -configurations
> -    Contains a set of available configuration nodes and
> -    defines a default configuration.
> -
> -
> -'/images' node
> ---------------
> -
> -This node is a container node for component sub-image nodes. Each sub-n=
ode of
> -the '/images' node should have the following layout::
> -
> -    o image-1
> -        |- description =3D "component sub-image description"
> -        |- data =3D /incbin/("path/to/data/file.bin")
> -        |- type =3D "sub-image type name"
> -        |- arch =3D "ARCH name"
> -        |- os =3D "OS name"
> -        |- compression =3D "compression name"
> -        |- load =3D <00000000>
> -        |- entry =3D <00000000>
> -        |
> -        o hash-1 {...}
> -        o hash-2 {...}
> -        ...
> -
> -Mandatory properties
> -~~~~~~~~~~~~~~~~~~~~
> -
> -description
> -    Textual description of the component sub-image
> -
> -type
> -    Name of component sub-image type. Supported types are:
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    Sub-image type        Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    invalid               Invalid Image
> -    aisimage              Davinci AIS image
> -    atmelimage            ATMEL ROM-Boot Image
> -    copro                 Coprocessor Image}
> -    fdt_legacy            legacy Image with Flat Device Tree
> -    filesystem            Filesystem Image
> -    firmware              Firmware
> -    firmware_ivt          Firmware with HABv4 IVT }
> -    flat_dt               Flat Device Tree
> -    fpga                  FPGA Image }
> -    gpimage               TI Keystone SPL Image
> -    imx8image             NXP i.MX8 Boot Image
> -    imx8mimage            NXP i.MX8M Boot Image
> -    imximage              Freescale i.MX Boot Image
> -    kernel                Kernel Image
> -    kernel_noload         Kernel Image (no loading done)
> -    kwbimage              Kirkwood Boot Image
> -    lpc32xximage          LPC32XX Boot Image
> -    mtk_image             MediaTek BootROM loadable Image }
> -    multi                 Multi-File Image
> -    mxsimage              Freescale MXS Boot Image
> -    omapimage             TI OMAP SPL With GP CH
> -    pblimage              Freescale PBL Boot Image
> -    pmmc                  TI Power Management Micro-Controller Firmware
> -    ramdisk               RAMDisk Image
> -    rkimage               Rockchip Boot Image }
> -    rksd                  Rockchip SD Boot Image }
> -    rkspi                 Rockchip SPI Boot Image }
> -    script                Script
> -    socfpgaimage          Altera SoCFPGA CV/AV preloader
> -    socfpgaimage_v1       Altera SoCFPGA A10 preloader
> -    spkgimage             Renesas SPKG Image }
> -    standalone            Standalone Program
> -    stm32image            STMicroelectronics STM32 Image }
> -    sunxi_egon            Allwinner eGON Boot Image }
> -    sunxi_toc0            Allwinner TOC0 Boot Image }
> -    tee                   Trusted Execution Environment Image
> -    ublimage              Davinci UBL image
> -    vybridimage           Vybrid Boot Image
> -    x86_setup             x86 setup.bin
> -    zynqimage             Xilinx Zynq Boot Image }
> -    zynqmpbif             Xilinx ZynqMP Boot Image (bif) }
> -    zynqmpimage           Xilinx ZynqMP Boot Image }
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -compression
> -    Compression used by included data. If no compression is used, the
> -    compression property should be set to "none". If the data is compre=
ssed but
> -    it should not be uncompressed by the loader (e.g. compressed ramdis=
k), this
> -    should also be set to "none".
> -
> -    Supported compression types are:
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    Compression type      Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    none                  uncompressed
> -    bzip2                 bzip2 compressed
> -    gzip                  gzip compressed
> -    lz4                   lz4 compressed
> -    lzma                  lzma compressed
> -    lzo                   lzo compressed
> -    zstd                  zstd compressed
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -data-size
> -    size of the data in bytes
> -
> -
> -Conditionally mandatory property
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -data
> -    Path to the external file which contains this node's binary data. W=
ithin
> -    the FIT this is the contents of the file. This is mandatory unless
> -    external data is used.
> -
> -data-offset
> -    Offset of the data in a separate image store. The image store is pl=
aced
> -    immediately after the last byte of the device tree binary, aligned =
to a
> -    4-byte boundary. This is mandatory if external data is used, with a=
n offset.
> -
> -data-position
> -    Machine address at which the data is to be found. This is a fixed a=
ddress
> -    not relative to the loading of the FIT. This is mandatory if extern=
al data
> -    used with a fixed address.
> -
> -os
> -    OS name, mandatory for types "kernel". Valid OS names are:
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    OS name               Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    invalid               Invalid OS
> -    4_4bsd                4_4BSD
> -    arm-trusted-firmware  ARM Trusted Firmware
> -    dell                  Dell
> -    efi                   EFI Firmware
> -    esix                  Esix
> -    freebsd               FreeBSD
> -    integrity             INTEGRITY
> -    irix                  Irix
> -    linux                 Linux
> -    ncr                   NCR
> -    netbsd                NetBSD
> -    openbsd               OpenBSD
> -    openrtos              OpenRTOS
> -    opensbi               RISC-V OpenSBI
> -    ose                   Enea OSE
> -    plan9                 Plan 9
> -    psos                  pSOS
> -    qnx                   QNX
> -    rtems                 RTEMS
> -    sco                   SCO
> -    solaris               Solaris
> -    svr4                  SVR4
> -    tee                   Trusted Execution Environment
> -    u-boot                U-Boot
> -    vxworks               VxWorks
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -arch
> -    Architecture name, mandatory for types: "standalone", "kernel",
> -    "firmware", "ramdisk" and "fdt". Valid architecture names are:
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    Architecture type     Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    invalid               Invalid ARCH
> -    alpha                 Alpha
> -    arc                   ARC
> -    arm64                 AArch64
> -    arm                   ARM
> -    avr32                 AVR32
> -    blackfin              Blackfin
> -    ia64                  IA64
> -    m68k                  M68K
> -    microblaze            MicroBlaze
> -    mips64                MIPS 64 Bit
> -    mips                  MIPS
> -    nds32                 NDS32
> -    nios2                 NIOS II
> -    or1k                  OpenRISC 1000
> -    powerpc               PowerPC
> -    ppc                   PowerPC
> -    riscv                 RISC-V
> -    s390                  IBM S390
> -    sandbox               Sandbox
> -    sh                    SuperH
> -    sparc64               SPARC 64 Bit
> -    sparc                 SPARC
> -    x86_64                AMD x86_64
> -    x86                   Intel x86
> -    xtensa                Xtensa
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -entry
> -    entry point address, address size is determined by
> -    '#address-cells' property of the root node.
> -    Mandatory for types: "firmware", and "kernel".
> -
> -load
> -    load address, address size is determined by '#address-cells'
> -    property of the root node.
> -    Mandatory for types: "firmware", and "kernel".
> -
> -compatible
> -    compatible method for loading image.
> -    Mandatory for types: "fpga", and images that do not specify a load =
address.
> -    Supported compatible methods:
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    Compatible string           Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    u-boot,fpga-legacy          Generic fpga loading routine.
> -    u-boot,zynqmp-fpga-ddrauth  Signed non-encrypted FPGA bitstream for
> -                                Xilinx Zynq UltraScale+ (ZymqMP) device=
.
> -    u-boot,zynqmp-fpga-enc      Encrypted FPGA bitstream for Xilinx Zyn=
q
> -                                UltraScale+ (ZynqMP) device.
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -phase
> -    U-Boot phase for which the image is intended.
> -
> -    "spl"
> -        image is an SPL image
> -
> -    "u-boot"
> -        image is a U-Boot image
> -
> -Optional nodes:
> -
> -hash-1
> -    Each hash sub-node represents separate hash or checksum
> -    calculated for node's data according to specified algorithm.
> -
> -signature-1
> -    Each signature sub-node represents separate signature
> -    calculated for node's data according to specified algorithm.
> -
> -
> -Hash nodes
> -----------
> -
> -::
> -
> -    o hash-1
> -        |- algo =3D "hash or checksum algorithm name"
> -        |- value =3D [hash or checksum value]
> -
> -Mandatory properties
> -~~~~~~~~~~~~~~~~~~~~
> -
> -algo
> -    Algorithm name. Supported algoriths and their value sizes are:
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -    Sub-image type       Size (bytes) Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -    crc16-ccitt          2            Cyclic Redundancy Check 16-bit
> -                                      (Consultative Committee for Inter=
national
> -                                      Telegraphy and Telephony)
> -    crc32                4            Cyclic Redundancy Check 32-bit
> -    md5                  16           Message Digest 5 (MD5)
> -    sha1                 20           Secure Hash Algorithm 1 (SHA1)
> -    sha256               32           Secure Hash Algorithm 2 (SHA256)
> -    sha384               48           Secure Hash Algorithm 2 (SHA384)
> -    sha512               64           Secure Hash Algorithm 2 (SHA512)
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -value
> -    Actual checksum or hash value.
> -
> -Image-signature nodes
> ----------------------
> -
> -::
> -
> -    o signature-1
> -        |- algo =3D "algorithm name"
> -        |- key-name-hint =3D "key name"
> -        |- value =3D [hash or checksum value]
> -
> -
> -Mandatory properties
> -~~~~~~~~~~~~~~~~~~~~
> -
> -_`FIT Algorithm`:
> -
> -algo
> -    Algorithm name. Supported algoriths and their value sizes are shown=
 below.
> -    Note that the hash is specified separately from the signing algorit=
hm, so
> -    it is possible to mix and match any SHA algorithm with any signing
> -    algorithm. The size of the signature relates to the signing algorit=
hm, not
> -    the hash, since it is the hash that is signed.
> -
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -    Sub-image type       Size (bytes) Meaning
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -    sha1,rsa2048         256          SHA1 hash signed with 2048-bit
> -                                      Rivest=E2=80=93Shamir=E2=80=93Adl=
eman algorithm
> -    sha1,rsa3072         384          SHA1 hash signed with 2048-bit RS=
A
> -    sha1,rsa4096         512          SHA1 hash signed with 2048-bit RS=
A
> -    sha1,ecdsa256        32           SHA1 hash signed with 256-bit  El=
liptic
> -                                      Curve Digital Signature Algorithm
> -    sha256,...
> -    sha384,...
> -    sha512,...
> -    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -key-name-hint
> -    Name of key to use for signing. The keys will normally be in
> -    a single directory (parameter -k to mkimage). For a given key <name=
>, its
> -    private key is stored in <name>.key and the certificate is stored i=
n
> -    <name>.crt.
> -
> -sign-images
> -    A list of images to sign, each being a property of the conf
> -    node that contains then. The default is "kernel,fdt" which means th=
at these
> -    two images will be looked up in the config and signed if present. T=
his is
> -    used by mkimage to determine which images to sign.
> -
> -The following properies are added as part of signing, and are mandatory=
:
> -
> -value
> -    Actual signature value. This is added by mkimage.
> -
> -hashed-nodes
> -    A list of nodes which were hashed by the signer. Each is
> -    a string - the full path to node. A typical value might be::
> -
> -	hashed-nodes =3D "/", "/configurations/conf-1", "/images/kernel",
> -	    "/images/kernel/hash-1", "/images/fdt-1",
> -	    "/images/fdt-1/hash-1";
> -
> -hashed-strings
> -    The start and size of the string region of the FIT that was hashed.=
 The
> -    start is normally 0, indicating the first byte of the string table.=
 The size
> -    indicates the number of bytes hashed as part of signing.
> -
> -The following properies are added as part of signing, and are optional:
> -
> -timestamp
> -    Time when image was signed (standard Unix time_t format)
> -
> -signer-name
> -    Name of the signer (e.g. "mkimage")
> -
> -signer-version
> -    Version string of the signer (e.g. "2013.01")
> -
> -comment
> -    Additional information about the signer or image
> -
> -padding
> -    The padding algorithm, it may be pkcs-1.5 or pss,
> -    if no value is provided we assume pkcs-1.5
> -
> -
> -'/configurations' node
> -----------------------
> -
> -The 'configurations' node creates convenient, labeled boot configuratio=
ns,
> -which combine together kernel images with their ramdisks and fdt blobs.
> -
> -The 'configurations' node has the following structure::
> -
> -    o configurations
> -        |- default =3D "default configuration sub-node unit name"
> -        |
> -        o config-1 {...}
> -        o config-2 {...}
> -        ...
> -
> -
> -Optional property
> -~~~~~~~~~~~~~~~~~
> -
> -default
> -    Selects one of the configuration sub-nodes as a default configurati=
on.
> -
> -Mandatory nodes
> -~~~~~~~~~~~~~~~
> -
> -configuration-sub-node-unit-name
> -    At least one of the configuration sub-nodes is required.
> -
> -Optional nodes
> -~~~~~~~~~~~~~~
> -
> -signature-1
> -    Each signature sub-node represents separate signature
> -    calculated for the configuration according to specified algorithm.
> -
> -
> -Configuration nodes
> --------------------
> -
> -Each configuration has the following structure::
> -
> -    o config-1
> -        |- description =3D "configuration description"
> -        |- kernel =3D "kernel sub-node unit name"
> -        |- fdt =3D "fdt sub-node unit-name" [, "fdt overlay sub-node un=
it-name", ...]
> -        |- loadables =3D "loadables sub-node unit-name"
> -        |- script =3D "
> -        |- compatible =3D "vendor,board-style device tree compatible st=
ring"
> -        o signature-1 {...}
> -
> -Mandatory properties
> -~~~~~~~~~~~~~~~~~~~~
> -
> -description
> -    Textual configuration description.
> -
> -kernel or firmware
> -    Unit name of the corresponding kernel or firmware
> -    (u-boot, op-tee, etc) image. If both "kernel" and "firmware" are sp=
ecified,
> -    control is passed to the firmware image.
> -
> -Optional properties
> -~~~~~~~~~~~~~~~~~~~
> -
> -fdt
> -    Unit name of the corresponding fdt blob (component image node of a
> -    "fdt type"). Additional fdt overlay nodes can be supplied which sig=
nify
> -    that the resulting device tree blob is generated by the first base =
fdt
> -    blob with all subsequent overlays applied.
> -
> -fpga
> -    Unit name of the corresponding fpga bitstream blob
> -    (component image node of a "fpga type").
> -
> -loadables
> -    Unit name containing a list of additional binaries to be
> -    loaded at their given locations.  "loadables" is a comma-separated =
list
> -    of strings. U-Boot will load each binary at its given start-address=
 and
> -    may optionally invoke additional post-processing steps on this bina=
ry based
> -    on its component image node type.
> -
> -script
> -    The image to use when loading a U-Boot script (for use with the
> -    source command).
> -
> -compatible
> -    The root compatible string of the U-Boot device tree that
> -    this configuration shall automatically match when CONFIG_FIT_BEST_M=
ATCH is
> -    enabled. If this property is not provided, the compatible string wi=
ll be
> -    extracted from the fdt blob instead. This is only possible if the f=
dt is
> -    not compressed, so images with compressed fdts that want to use com=
patible
> -    string matching must always provide this property.
> -
> -The FDT blob is required to properly boot FDT based kernel, so the mini=
mal
> -configuration for 2.6 FDT kernel is (kernel, fdt) pair.
> -
> -Older, 2.4 kernel and 2.6 non-FDT kernel do not use FDT blob, in such c=
ases
> -'struct bd_info' must be passed instead of FDT blob, thus fdt property =
*must
> -not* be specified in a configuration node.
> -
> -Configuration-signature nodes
> ------------------------------
> -
> -::
> -
> -    o signature-1
> -        |- algo =3D "algorithm name"
> -        |- key-name-hint =3D "key name"
> -        |- sign-images =3D "path1", "path2";
> -        |- value =3D [hash or checksum value]
> -        |- hashed-strings =3D <0 len>
> -
> -
> -Mandatory properties
> -~~~~~~~~~~~~~~~~~~~~
> -
> -algo
> -    See `FIT Algorithm`_.
> -
> -key-name-hint
> -    Name of key to use for signing. The keys will normally be in
> -    a single directory (parameter -k to mkimage). For a given key <name=
>, its
> -    private key is stored in <name>.key and the certificate is stored i=
n
> -    <name>.crt.
> -
> -The following properies are added as part of signing, and are mandatory=
:
> -
> -value
> -    Actual signature value. This is added by mkimage.
> -
> -The following properies are added as part of signing, and are optional:
> -
> -timestamp
> -    Time when image was signed (standard Unix time_t format)
> -
> -signer-name
> -    Name of the signer (e.g. "mkimage")
> -
> -signer-version
> -    Version string of the signer (e.g. "2013.01")
> -
> -comment
> -    Additional information about the signer or image
> -
> -padding
> -    The padding algorithm, it may be pkcs-1.5 or pss,
> -    if no value is provided we assume pkcs-1.5
> -
> -
> -
> -Examples
> ---------
> -
> -Some example files are available here, showing various scenarios
> -
> -.. toctree::
> -    :maxdepth: 1
> -
> -    kernel
> -    kernel_fdt
> -    kernel_fdts_compressed
> -    multi
> -    multi_spl
> -    multi-with-fpga
> -    multi-with-loadables
> -    sec_firmware_ppa
> -    sign-configs
> -    sign-images
> -    uefi
> -    update3
> -    update_uboot
> -
> -.. sectionauthor:: Marian Balakowicz <m8@semihalf.com>
> -.. sectionauthor:: External data additions, 25/1/16 Simon Glass <sjg@ch=
romium.org>
> +FIT format documentation has been moved to

%s/FIT/The FIT/g

Otherwise looks good to me.

Best regards

Heinrich

> +`a separate project <https://fitspec.osfw.foundation/>`_. Updates to th=
e
> +format/specification should be submitted there.
> \ No newline at end of file

