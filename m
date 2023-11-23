Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBAAC61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDAF8768A;
	Thu, 23 Nov 2023 05:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ysd8QHfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EF78768C; Thu, 23 Nov 2023 05:49:05 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E6387684
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4mxYF028003;
 Wed, 22 Nov 2023 22:48:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700714939;
 bh=qIiOM+RPKRoxATYolvEzi5L4D0pA3dyFHWP+/UoPs3o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ysd8QHfQPnPXRE0WOPBwhwtyHuNbaN9ghaSsg1qH/wzXZi1qnhE/8/az9TuHiFCHZ
 98KpIQX9KxTaT+3/bsv4kiyTxt3pzlrDSav96nfWeB2tcn53l8sbdbDLyn6tw/tS5D
 yBDAHWKrgY6AvkrAdZJN/9ApcD7/RV3IEtbkd7Pw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4mxwu105811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:48:59 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:48:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:48:59 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4m3Yf116955;
 Wed, 22 Nov 2023 22:48:58 -0600
Message-ID: <697c6279-2a6e-4b9b-a414-5a25671ab903@ti.com>
Date: Thu, 23 Nov 2023 10:18:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] qemu: riscv: Enable UFS support
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-10-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-10-bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Bin

On 11/10/23 18:45, Bin Meng wrote:
> This enables UFS support for QEMU RISC-V 'virt' machine.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> (no changes since v1)
> 
>   board/emulation/qemu-riscv/Kconfig | 2 ++
>   doc/board/emulation/qemu-riscv.rst | 8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
> index d56b4b5bc1..f3ee1f6e90 100644
> --- a/board/emulation/qemu-riscv/Kconfig
> +++ b/board/emulation/qemu-riscv/Kconfig
> @@ -82,5 +82,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>   	imply USB_XHCI_PCI
>   	imply USB_KEYBOARD
>   	imply CMD_USB
> +	imply UFS
> +	imply UFS_PCI
>   
>   endif
> diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
> index 61137bcbf1..8a5eb1eda5 100644
> --- a/doc/board/emulation/qemu-riscv.rst
> +++ b/doc/board/emulation/qemu-riscv.rst
> @@ -131,7 +131,13 @@ An attached disk can be emulated in RISC-V virt machine by adding::
>       -drive if=none,file=riscv64.img,format=raw,id=mydisk \
>       -device ide-hd,drive=mydisk,bus=ahci.0
>   
> -You will have to run 'scsi scan' to use it.
> +or alternatively attach an emulated UFS::
> +
> +    -device ufs,id=ufs0 \
> +    -drive if=none,file=test.img,format=raw,id=lun0 \
> +    -device ufs-lu,drive=lun0,bus=ufs0
> +
> +You will have to run 'scsi scan' to use them.
>   
>   A video console can be emulated in RISC-V virt machine by removing "-nographic"
>   and adding::

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
