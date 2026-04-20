Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B6F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3A6843C0;
	Mon, 20 Apr 2026 22:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cxqh5I/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7C9843C7; Mon, 20 Apr 2026 15:25:45 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828DE84366
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 33E6960580;
 Mon, 20 Apr 2026 13:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E80AC2BCB9;
 Mon, 20 Apr 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776691541;
 bh=nUeDqqIqZThKOvtq1TG14lEDvu9YNvNLQwVNei7ZDwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cxqh5I/MNGBO+GHOeTt2ar85NXBjdUDIeVxchtgkRvvJZDiLkvBdWLD6WTf0zuMK7
 4Kg3nBZwwBGYA/Ug8F6OeB1B34HDR5QNXt+bRk0hjpf55FztpFlTtx/LJw0BWo5rY2
 +sxnz4VQxAIn/wgLbDefbPCkZz2shGajp0AeEsd7UJyPxjQS5/WaiLE0PbjxtBSTbw
 JFfXfm88b+5RZLo4v3QA8Tk4fY5aUNuy4KACpz+TPSEFjkPF66mkohUw8IzlTCCvzN
 Bmme4PEBachQcRvQG75jTbBxNy8GPpq9aCN9K1oGqj2nQ9QDtpUiLTru4BHWGwn2Lp
 HKQ3/c+Ky8Z7Q==
Date: Mon, 20 Apr 2026 18:55:25 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 michael.srba@seznam.cz
Subject: Re: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
Message-ID: <aeYpRSg2S6p8dNZt@sumit-xelite>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
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

Adding Michael

On Fri, Apr 10, 2026 at 02:41:47PM +0530, Varadarajan Narayanan wrote:
> Add details about the SPL & U-Boot proper build steps, converting to
> flashable images, source URLs for the needed binaries and scripts.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> index 99cf8eba57c..d09dba52044 100644
> --- a/doc/board/qualcomm/rdp.rst
> +++ b/doc/board/qualcomm/rdp.rst
> @@ -42,6 +42,67 @@ on your device with::
>  
>  U-Boot should be running after a reboot (``reset``).
>  
> +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
> +====================================================================

Rather than just the build steps, please describe the overall boot flow.
And since you have created a common SPL file for all the Qcom platforms,
can you ellaborate on how the boot flow is going to be reused across
Qcom platforms. Maybe we just need a dedicated spl.rst document here.

Also, how does this series align with one for SPL support on SDM845 here
[1]? Are there things that both SPL ports can reuse from each other?

[1] https://lore.kernel.org/all/20260411-qcom_spl-v2-0-9609557cf562@seznam.cz/

-Sumit

> +
> +Please refer to the following URLs for more details about the platforms.
> +
> +	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
> +
> +	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
> +
> +1. Since U-Boot SPL is enabled on these platforms, the build command generates
> +   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
> +   top of the U-Boot sources and ${out_dir} as the output directory,
> +
> +	$ cd ${uboot_dir}
> +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +	$ make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
> +	$ make -j8 O=${out_dir}
> +
> +   U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
> +   U-Boot image:	${out_dir}/u-boot.elf
> +
> +2. Convert the SPL image to multi ELF
> +
> +	$ cd ${out_dir}/spl
> +	$ python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
> +	$ python create_multielf.py -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
> +					-o u-boot-spl.melf
> +
> +   This u-boot-spl.melf should be flashed into 0:SPL partition.
> +   Please see below for the location of ``tmel-ipq52xx-patch.elf``
> +
> +3. Convert the U-Boot image to bootloader image
> +
> +	$ cd ${out_dir}
> +	$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
> +
> +   The u-boot.mbn has to be combined with qc_config.elf, QCLib.elf, TFA and
> +   OPTEE. Please see below for the location for these ELFs. TFA and OPTEE can be
> +   built from the sources using the following commands
> +
> +   TFA:
> +	$ make PLAT=ipq52xx QTISECLIB_PATH=path/to/libqtisec_dbg.a SPD=opteed
> +
> +   OPTEE:
> +	$ make PLATFORM=qcom-ipq52xx -j16
> +
> +   These binaries can be combined into a flashable image using ``gen_its.py``.
> +
> +	$ python gen_its.py --arch ipq5210		\
> +		--qclib_path QCLib.elf			\
> +		--qcconfig_path qc_config.elf		\
> +		--tfa_bl31_path bl31.mbn		\
> +		--uboot_path u-boot.mbn			\
> +		--optee_path tee-raw.mbn		\
> +		-p qcconfig qclib			\
> +		-P tfa_bl31 uboot optee			\
> +		-o output/hm_503_test_uboot.img		\
> +		--template template.its
> +
> +   This should be flashed into 0:BOOTLDR partition.
> +
>  .. WARNING
>  	Boards with newer software versions would automatically go the emergency
>  	download (EDL) mode if U-Boot is not functioning as expected. If its a
> @@ -56,3 +117,11 @@ U-Boot should be running after a reboot (``reset``).
>  
>  .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
>  .. _edl: https://github.com/bkerler/edl
> +.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
> +.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf
> +.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
> +.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
> +.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
> +.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
> +.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
> +.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
> -- 
> 2.34.1
> 
