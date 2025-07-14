Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5155C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726A983022;
	Mon, 14 Jul 2025 15:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KKwQ9XTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C426B82B07; Mon, 14 Jul 2025 15:11:14 +0200 (CEST)
Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com
 [220.197.31.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0AE82F49
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.33.147] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1bf33282d;
 Mon, 14 Jul 2025 21:11:08 +0800 (GMT+08:00)
Message-ID: <d024abce-72bc-48b2-a8e2-49b8fa027433@rock-chips.com>
Date: Mon, 14 Jul 2025 21:11:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: rockchip: Fix spacing around the Kconfig
 option
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
References: <20250702010346.18716-1-trini@konsulko.com>
 <20250702010346.18716-2-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250702010346.18716-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MaHVYfQxodSxhNTR1DQ0xWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a98090f820003afkunm3e984fd61cc5676
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46NDo5EjE4ShdDHRYIMFZK
 OikaChJVSlVKTE5JT0JDTU1DTE1NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUJLNwY+
DKIM-Signature: a=rsa-sha256;
 b=KKwQ9XTHwphEsJ+a4HGfMLbtfehtmY5F0F+XuiIipKCSr7/wCPE8LdoflmfMT34/GxZCEp6dQOqNYFQAl9B3z8VQ2f9v6j0vO77IgGpcSFdV/R80gSLRKZ0pvelkRokJSOl/PScXDHVk/5f3W3P4N/6kPMzk4XvqI3mW+UaUs8E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=LK+hc9naoPrGYmcsMQfBTht7MEmtLXPvtc9EOAvGHe8=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/7/2 09:03, Tom Rini wrote:
> This Kconfig option used spaces and not tabs for indentation. Switch to
> tabs.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/usb/gadget/Kconfig | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index b0decd7b2512..6201663317be 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -201,13 +201,13 @@ config USB_FUNCTION_MASS_STORAGE
>   	  the eMMC/SD card content to HOST PC so it can be mounted.
>   
>   config USB_FUNCTION_ROCKUSB
> -        bool "Enable USB rockusb gadget"
> +	bool "Enable USB rockusb gadget"
>   	depends on ARCH_ROCKCHIP
> -        help
> -          Rockusb protocol is widely used by Rockchip SoC based devices. It can
> -          read/write info, image to/from devices. This enables the USB part of
> -          the rockusb gadget.for more detail about Rockusb protocol, please see
> -          doc/README.rockusb
> +	help
> +	  Rockusb protocol is widely used by Rockchip SoC based devices. It can
> +	  read/write info, image to/from devices. This enables the USB part of
> +	  the rockusb gadget.for more detail about Rockusb protocol, please see
> +	  doc/README.rockusb
>   
>   config USB_FUNCTION_SDP
>   	bool "Enable USB SDP (Serial Download Protocol)"

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

