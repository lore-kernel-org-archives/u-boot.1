Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBB7C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 07:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8EB280E84;
	Fri, 14 Aug 2026 07:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L4GVEd6KSNkz; Fri, 14 Aug 2026 07:23:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B2AF80E61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786692192;
	bh=1qWzCayH5C4hhiLr97yW8+kq8ueTZqn6VCfX+sytnDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ex9IeWO830d0yn1Xjam+KTCxPjuM7AGgFh8qn1YaQt0PDBPiDvDgx62yQnd2+IU0W
	 ybVN+0sirm/V8t6iHnQfL5MhbMRsviI9uELAzZs+FozI8R5FOPVDQtZMLA/WKHI0ZP
	 UM+2JRwtAXkkb3Nsexk2qa43Tmlr3Xqd3D5Hdn/8SnEydw5End50mCwVTPBTpQR56B
	 DH89BMrAOiyLV1sxIreVgdfZyU2eISLxSnCvreuyDNx4UAlIrBW/JFg6MmHKdzLNe+
	 wt2YfCXd+SEwYiAQvY5RV02f8EJuI1Fh/SUQjd2nACOaQhW639EpPwabb3THSiszic
	 n+vfwne7Nu9KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B2AF80E61;
	Fri, 14 Aug 2026 07:23:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92883282
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 852EB400AC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJNtCRtxaUk4 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 07:23:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 738DD40084
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 738DD40084
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=eY+Jrmpo
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 738DD40084
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:23:10 +0000 (UTC)
Received: from francesco-nb (2-224-16-253.ip168.fastwebnet.it [2.224.16.253])
 by mail11.truemail.it (Postfix) with ESMTPA id 8069122C16;
 Fri, 14 Aug 2026 09:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1786692188;
 bh=1qWzCayH5C4hhiLr97yW8+kq8ueTZqn6VCfX+sytnDU=; h=From:To:Subject;
 b=eY+Jrmpoh2+fIALNWiiJITBIQ4YTTO0f0EQbMU44nr25biOQRQ/hcCBQ3S7hqYvcL
 o49CEP7hhIJCDHmyUv4AumeaizAsFHaFCmLpEO2Jh0uS7z/2b+hNm4zY5uk5OW8xpO
 7Ykmc08yKFo/NmyJukKsY4LvYCnH1ArWH8SQRFMSunQ4txW1eOMpZv/qcGhIK9cjN8
 9cBFcAgtPlQgEowOqMGyIg/rRnEMvZNMR/+mfWr882+ODsDIVRS7tKaakLIts0ZI22
 +r6Dy7nTpJ3yLoh8b4p9kHNzSbRY3R5i+so3/ezo/UvkhtgWV3G7LW/vhj6WOPobln
 BwLLz3etAQkfQ==
Date: Fri, 14 Aug 2026 09:23:05 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 2/2] doc: board: toradex: add the Colibri VF50/VF61 page
Message-ID: <20260814072305.GC5246@francesco-nb>
References: <20260813150726.2184452-1-mehmet.fide@gmail.com>
 <20260813150726.2184452-3-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813150726.2184452-3-mehmet.fide@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello Mehmet,
thanks for the patch.

On Thu, Aug 13, 2026 at 05:07:26PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> The other Toradex modules are documented here, the Vybrid ones were
> not. Describe the build, the two ways of getting the image into NAND,
> and the flashloader command of the WinCE-era bootloader that modules
> from that era still carry.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
>  doc/board/toradex/colibri_vf.rst | 70 ++++++++++++++++++++++++++++++++
>  doc/board/toradex/index.rst      |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 doc/board/toradex/colibri_vf.rst
> 
> diff --git a/doc/board/toradex/colibri_vf.rst b/doc/board/toradex/colibri_vf.rst
> new file mode 100644
> index 00000000000..d2809bda2e8
> --- /dev/null
> +++ b/doc/board/toradex/colibri_vf.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. sectionauthor:: Mehmet Fide <mehmet.fide@screeningeagle.com>
> +
> +Colibri VF50/VF61 Modules
> +=========================
> +
> +- SoM: https://www.toradex.com/computer-on-modules/colibri-arm-family/nxp-vybrid-vf5xx-vf6xx
> +- Carrier boards: https://www.toradex.com/products/carrier-board/colibri-evaluation-board
> +  and https://www.toradex.com/products/carrier-board/iris-carrier-board
> +
> +Quick Start
> +-----------
> +
> +- Build U-Boot
> +- Flash to NAND from a running U-Boot
> +- Flash to NAND over recovery mode
> +- Modules still carrying the WinCE bootloader
> +
> +Build U-Boot
> +------------
> +
> +.. code-block:: bash

this should be 'console', not bash. Likewise in other places.

> +
> +    $ export CROSS_COMPILE=arm-linux-gnueabi-
> +    $ make colibri_vf_defconfig
> +    $ make
> +
> +This produces ``u-boot.imx``, the image with the IVT for the Vybrid
> +BootROM, ready to be written to the ``u-boot`` NAND partition.
> +
> +Flash to NAND from a running U-Boot
> +-----------------------------------
> +
> +Load the image over TFTP or from a FAT formatted SD card and use the
> +``update_uboot`` script from the default environment:
> +
> +.. code-block:: none
> +
> +    Colibri VFxx # fatload mmc 0:1 ${loadaddr} u-boot.imx
> +    Colibri VFxx # run update_uboot
> +    Colibri VFxx # reset
> +
> +Flash to NAND over recovery mode
> +--------------------------------
> +
> +With nothing bootable in NAND, the Vybrid BootROM falls back to the
> +serial downloader on the USB client port. The `imx_usb_loader
> +<https://github.com/boundarydevices/imx_usb_loader>`_ tool can push
> +``u-boot.imx`` straight into OCRAM and run it:
> +
> +.. code-block:: bash
> +
> +    $ imx_usb u-boot.imx
> +
> +From the running U-Boot, flash NAND as in the previous section.
> +
> +Modules still carrying the WinCE bootloader
> +-------------------------------------------
> +
> +Modules that were shipped with the WinCE-era Toradex bootloader (eBoot)
> +offer a ``flashloader`` command that writes a U-Boot image to NAND:
> +
> +.. code-block:: none
> +
> +    > flashloader u-boot.imx
> +    > reboot
> +
> +The image must be linked at ``CONFIG_TEXT_BASE=0x3f408000``; the BootROM
Not sure that this comment must be here, once you fix the defconfig.
It does not seem specific on the colibri, this is about the SoC.


in any case,

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

