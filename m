Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17392C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 10:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E718749F;
	Thu, 16 Nov 2023 11:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="m3rf1jOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BDA87465; Thu, 16 Nov 2023 11:30:22 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804FF871D0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1b1a965b-846b-11ee-91e7-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1b1a965b-846b-11ee-91e7-005056994fde;
 Thu, 16 Nov 2023 11:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=LkLSX/tRLu9H2GoqnR2MsWNzS3WMW8UwpkTdNG0MScA=;
 b=m3rf1jOJJL6rxtz0LmttpHkBHWqIWHFx8h++OZAREcXEdnufv1NDSHhOJPvYSNvelwOwMvH/nILlT
 rTtzGeVWjdDIqMtFG0/dL/23TZOIXUzF9jiWkwgdwFHCwpCL1zwp3OUe+WqV5gQ/DFbEdLxw+9L6yD
 KywqNU183+NoHArDmnjOcPvcike2g0hozv/z2Do3OfL0N5XB4DSFU4Z4SCmOieOb/kx/lUpHhNI4xQ
 FDsecs9r4aW1ClVFN6GP8d6p6HXY8iaDsLbs6xkziRVDNU8CPg8RWSzmUntn4yFN2nfLX2UGWOxULp
 Oq4ghpvyCY4/b75eKp/22z2qUHr2asg==
X-KPN-MID: 33|P+F6Hp3iV83R1GI2Ah/lbQtYHSgIiFbgsPK+tkLVnaoQsq54PpIweHoHOzNCUFE
 3j24Px7rEG+6BgfQ2KlcJjyj54L1vV1zzLua/byxtp7U=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nRi411tRv32SHtTiCEmdNoNlRylBx8cumfAGp+zcYoJwKGzwMaY7LAj+MMNB0u1
 O9nE4GtxxRVTsznj+Uh5M6Q==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1c5cdd82-846b-11ee-acaa-00505699d6e5;
 Thu, 16 Nov 2023 11:30:07 +0100 (CET)
Date: Thu, 16 Nov 2023 11:30:06 +0100
Message-Id: <87r0kq7zyp.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: bmeng.cn@gmail.com, lukas.auer@aisec.fraunhofer.de,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <20231116102251.53365-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Thu, 16 Nov 2023 11:22:51 +0100)
Subject: Re: [PATCH 1/1] risc-v: qemu: imply NVME_PCI
References: <20231116102251.53365-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Thu, 16 Nov 2023 11:22:51 +0100
> 
> CONFIG_NVME=y without CONFIG_NVME_PCI=y does not provide working NVMe
> support. Instead of implying CONFIG_NVME we must imply CONFIG_NVME_PCI
> which will select CONFIG_NVME.
> 
> Fixes: e64db0d92e32 ("riscv: qemu: Enable e1000 and nvme support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/emulation/qemu-riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed by: Mark Kettenis <kettenis@openbsd.org>


> diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
> index 933b035991..32511b4e4e 100644
> --- a/board/emulation/qemu-riscv/Kconfig
> +++ b/board/emulation/qemu-riscv/Kconfig
> @@ -56,8 +56,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>  	imply SCSI_AHCI
>  	imply AHCI_PCI
>  	imply E1000
> -	imply NVME
>  	imply PCI
> +	imply NVME_PCI
>  	imply PCIE_ECAM_GENERIC
>  	imply DM_RNG
>  	imply SCSI
> -- 
> 2.40.1
> 
> 
