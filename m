Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5FFC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E1B87FAB;
	Mon,  4 Mar 2024 14:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="Mkp6QgUb";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="bX8Qlsc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061BF86F1E; Mon,  4 Mar 2024 14:39:13 +0100 (CET)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C28986F1E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1709559541; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=kLJIUXXe3dA6K1L663q7gUsHCu9sctrkj2HL2vG7D61lvZxWLPUwm/wLX4g10mKkmb
 2SsyvjQrvcRmOrjYi/IGgtg87MYD5TubBok0UBXtlEHzoYSTpU2s07u1VYbVR293KXCY
 LYRjkthh5Q03OP8hajOzISw/4LN5FX8+Sp9ktojsSasoXTpB4Bikdpr9JsKkyGjrHml/
 YAbBNaFawqhszqNwp8uaLRzrYF1dzibQQ40Gm6020jIUTVtZd60wgjtwt4B1wQZ0s8Ia
 x8MlHQEbQRqbKvQPa+2BI+7v9iKgLBnHMUq7WXjn5ECmSjWj2dJ7eZ1LN20FfbVyIXJK
 mrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709559541;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=jAM5oL2kgLur5WXMDho1cgo0eHL/A3lKQHT9bqFIaA8=;
 b=L/l07ivxD/NoK5GcuoWDA2/PbsSPqo8aDX1/LZFK6tpq5FrGUD9Hric5KMOgZaCAk8
 0c3JENxJYvugZKv/ZUL3dpOrinSlwRY9EFRc+rar/teuOQyrUlI4U93NcJRuXnD+eTuK
 9wagDQhC5gIBMe3OV2PTLbSjDpnv40lWEbVFSGcmsxT5uH1FdrO5/QaW7c7KpcI0UC7l
 uBlTkCojgX9GjRvcJfX+tgYBJ8HxDjIPa+QX+tOop1UCBKu1tEqer128UVGmmRDTgD12
 UzuhYhvH9LwNpzj9iUIIA7vz5GJigwU98fId3qIbqkhARxgOx0e475EkPRMy83yn5aJc
 7TbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709559541;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=jAM5oL2kgLur5WXMDho1cgo0eHL/A3lKQHT9bqFIaA8=;
 b=Mkp6QgUbWV8Zqr2VhJ50pvC5LP4mRYmnEgRgaowQcG41dFc1IcA4l0Da3h73dQVPxf
 w+nm5uqRMWuJwp2A30cSP9yHcFrH3oJ3exZaqaibzxn/dIO9Y8ysppwN9fJTwN3tmS8f
 l/74qNhCghLhEsNOEJNTp41Ur2VDaR6YNPpfQDCM0er8DsDLWBpI/gHWZlgM4jHYazPb
 W3NTULNkgOA81/trXVh4XfXPBiz7nBfzfMh3d0+imZY0bVhcL7X4jpnKptGz0jAeA4c9
 x/LmOyGLRlPTrWnL5ukBkOL7PFo88BBi9+Yp1zqUmU3nofV27TYVEzNsqecqCiJ8m9xQ
 5cVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709559541;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=jAM5oL2kgLur5WXMDho1cgo0eHL/A3lKQHT9bqFIaA8=;
 b=bX8Qlsc2Y7d9z7Pmt22Qcx2dAIXdfY4iQpqHxRdOrjcVLJ56OSIFSru3jUdwiP82TO
 xLVmyN4aLAjJVZXSyHBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 50.2.0 DYNA|AUTH)
 with ESMTPSA id ufb408024Dd0EbP
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 4 Mar 2024 14:39:00 +0100 (CET)
Date: Mon, 4 Mar 2024 14:38:59 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 8/8] board: add support for Qualcomm SA8155P-ADP board
Message-ID: <ZeXO8wOAi7az0kgN@gerhold.net>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-9-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229142043.1263690-9-volodymyr_babchuk@epam.com>
Content-Transfer-Encoding: 7bit
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

On Thu, Feb 29, 2024 at 02:21:09PM +0000, Volodymyr Babchuk wrote:
> SA8155P Automotive Development Platform is Qualcomm SA8155-based board
> for developers. The nice thing that it has unlocked loaders with test
> keys support, which means that U-Boot for this platform can be
> launched at earlier stages.
> 
> This patch adds basic board support with only serial port and
> networking operation. I am using U-Boot to ease up Xen porting onto
> this board, so I am mostly interesting in booting U-Boot in EL2. But
> more conventional setup with Android boot image is supported as well.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> 
>  arch/arm/dts/sa8155p-adp-u-boot.dtsi     | 30 ++++++++
>  arch/arm/mach-snapdragon/Kconfig         | 14 ++++
>  arch/arm/mach-snapdragon/Makefile        |  2 +
>  arch/arm/mach-snapdragon/init_sa8155p.c  | 30 ++++++++
>  arch/arm/mach-snapdragon/sysmap-sm8150.c | 31 ++++++++
>  board/qualcomm/sa8155p-adp/Kconfig       | 12 +++
>  board/qualcomm/sa8155p-adp/MAINTAINERS   |  6 ++
>  configs/sa8155p_adp_defconfig            | 33 +++++++++
>  doc/board/qualcomm/index.rst             |  1 +
>  doc/board/qualcomm/sa8155p-adp.rst       | 94 ++++++++++++++++++++++++
>  include/configs/sa8155p_adp.h            | 25 +++++++
>  11 files changed, 278 insertions(+)
>  create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
>  create mode 100644 arch/arm/mach-snapdragon/init_sa8155p.c
>  create mode 100644 arch/arm/mach-snapdragon/sysmap-sm8150.c
>  create mode 100644 board/qualcomm/sa8155p-adp/Kconfig
>  create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
>  create mode 100644 configs/sa8155p_adp_defconfig
>  create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
>  create mode 100644 include/configs/sa8155p_adp.h
> 
> [...]
> diff --git a/doc/board/qualcomm/sa8155p-adp.rst b/doc/board/qualcomm/sa8155p-adp.rst
> new file mode 100644
> index 0000000000..cff68cd55f
> --- /dev/null
> +++ b/doc/board/qualcomm/sa8155p-adp.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +.. sectionauthor:: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> +
> +SA8155P Automotive Development Platform
> +=======================================
> +
> +About
> +-----
> +This document describes the information about SA8155P Automotive
> +Development Platform aka SA8155P-ADP.
> +
> +Currently U-Boot can be booted either as Android boot image, or in EL2
> +mode, instead of hypervisor image. In the latter case it is possible
> +to use U-Boot to either boot Linux with KVM support or to boot Xen
> +Hypervisor on this board.
> +
> +Supported HW modules
> +^^^^^^^^^^^^^^^^^^^^
> +Port for this board is in early development state. Right now U-Boot
> +supports serial console and networking. No USB/fastboot or UFS support
> +yet. So it is not possible to save environment variables as
> +well. Nevertheless this is enough for development as user can download
> +all required images via TFTP.
> +
> +Installation
> +------------
> +Build
> +^^^^^
> +Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> +
> +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +	$ make sa8155p_adp_defconfig
> +	$ make
> +
> +This will build ``u-boot.bin`` in the configured output directory.
> +
> +Boot in EL1 mode instead of Android boot image
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Create a dummy ramdisk image:::
> +
> +	$ echo "This is not a ramdisk" > ramdisk.img
> +
> +Compress u-boot binary:::
> +
> +	$ gzip -c u-boot.bin > u-boot.bin.gz
> +
> +Append DTB again (binary we use already have DTB embedded in, but
> +Android boot image format requires another DTB at the end of the
> +archive):::
> +
> +	$ cat u-boot.bin.gz u-boot.dtb > u-boot.bin.gz-dtb
> +
> +Now we've got everything to build android boot image:::
> +
> +	$ mkbootimg --kernel u-boot.bin.gz-dtb \
> +	--ramdisk ramdisk.img --pagesize 4096 \
> +	--base 0x80000000 -o boot.img
> +
> +Finally you can flash new boot image with fastboot:::
> +
> +	$ fastboot flash boot boot.img
> +
> +Or just boot U-Boot without flashing anything:::
> +
> +	$ fastboot boot boot.img
> +
> +Boot in EL2 mode instead of Qualcomm's hypervisor stub
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +This approach ensures that U-Boot is booted in EL2 and it is possible
> +to run virtualization software (like Xen or KVM) on the board. You
> +must understand that this approach breaks Qualcomm's boot chain. You
> +will not be able to call all subsequent loaders, so you will not be
> +able to use fastboot for example. Use this approach only if you want
> +to experiment with virtualization on SA8155P-ADP.
> +
> +We need to create ELF file from the u-boot binary. We can't use
> +existing U-Boot ELF, because it does not include appended DTB
> +file. Easiest way to do this is to use ``create_elf.py`` from the
> +following repository: `qtestsign(lorc)
> +<https://github.com/lorc/qtestsign/tree/create_elf>`_: ::
> +
> +	$ python ../qtestsign/create_elf.py u-boot.bin 0x85710000 u-boot.mbn
> +

Have you tried using CONFIG_REMAKE_ELF in U-Boot? That should
effectively do the same (build a new ELF based on u-boot.bin with the
appended device tree). The Qualcomm DragonBoard 410c port is using that
option to solve the same problem.

But I'm glad to see that the ELF abstractions in qtestsign worked well
for your purpose. :-)

Thanks,
Stephan
