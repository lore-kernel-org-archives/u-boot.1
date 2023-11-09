Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF6AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523208713C;
	Thu,  9 Nov 2023 04:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ftRc+TTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14099870DD; Thu,  9 Nov 2023 04:13:34 +0100 (CET)
Received: from mail-m127204.xmail.ntesmail.com
 (mail-m127204.xmail.ntesmail.com [115.236.127.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DDA86FE5
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ftRc+TTnUW8g3J41+oWYkPZ2yb5bux+63vTc6LGkHFM7vFHfrstv+EIy0xHsIpPL39YzxwoiFSiYVr38MoomcmoW0mLjjsPapzSxlKb/ADiDzb0RS92XqXOVRo94aXf5PizJv9sAkBT5BrbX03ioLVshqLs1eJN3aLeNHZZobnE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=vc7/yByxKHYkfjTJsBaCVzxPXJMDg4mib8oGZp4jEbM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 0C4114002F1;
 Thu,  9 Nov 2023 11:12:47 +0800 (CST)
Message-ID: <65c003e4-f251-4593-9f1c-8dcebdcab690@rock-chips.com>
Date: Thu, 9 Nov 2023 11:12:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Enable CONFIG_PCI_INIT_R to
 support EFI networking
Content-Language: en-US
To: =?UTF-8?Q?Martin_Roukala_=28n=C3=A9_Peres=29?=
 <martin.roukala@mupuf.org>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Christopher Obbard <chris.obbard@collabora.com>
References: <20231104130451.111020-1-martin.roukala@mupuf.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231104130451.111020-1-martin.roukala@mupuf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpDTFYaGUkZTEgeQkJJSx1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb21168212eb3kusn0c4114002f1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46GQw4KTw1DwgUGAkXL0Iy
 LSgwCTBVSlVKTUJCT0JCTk1MTkJPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUhJNwY+
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

Hi Martin and jonas,

On 2023/11/4 21:04, Martin Roukala (né Peres) wrote:
> When u-boot chainloads an EFI bootloader such as iPXE, we want to have
> already initialized the PCI subsystem so that network driver is loaded
> and ready to use by the bootloader.
>
> Fixes: 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards")
> Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>

Scan different storage media for boot firmware always cost some time, 
the pci cost a little bit

more time then SPI/eMMC, but since this board already support PCI 
storage, it's reasonable to

enable boot from PCI.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever

> ---
>   configs/rock5b-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 0595325e81..938137c851 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -36,6 +36,7 @@ CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_PCI_INIT_R=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
