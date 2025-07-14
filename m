Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A962FC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2094882E52;
	Mon, 14 Jul 2025 15:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ksIHJAcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5F182F49; Mon, 14 Jul 2025 15:11:03 +0200 (CEST)
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com
 [220.197.32.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FEE82B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.33.147] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1bf332814;
 Mon, 14 Jul 2025 21:10:53 +0800 (GMT+08:00)
Message-ID: <e7189bd3-a68a-45b2-9cf7-adb401ab7574@rock-chips.com>
Date: Mon, 14 Jul 2025 21:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: gadget: rockchip: Add missing dependency
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
References: <20250702010346.18716-1-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250702010346.18716-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxIHlZJSE9KSU5NQh9OSUJWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a98090f491603afkunm492f153c1cc5576
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDY6Nww6ODEwLxc5HRcIMEI5
 TQxPCRhVSlVKTE5JT0JDTU5PT05DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0NPNwY+
DKIM-Signature: a=rsa-sha256;
 b=ksIHJAcFwdq1Gb9oYyt/KGxY/fxcsLt2eNNwK7Uj3CpDpWcJMy6W+DTEVZAEjGe61YIhj8roFPMlW0a5uhUsDemY1MLiWuVNR2Zl40QEIZ7XgeGmHyyFt8pKChoMTigExB4uJH/sttggRgBIFZxYg+V34yQWLSmsfkP5qaEdtLA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=dO8tcGTx4vSzH9lQiBOz1oWlfLtbB45IKS79hYs6OX8=;
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
> The rockchip usb gadget driver cannot build without platform specific
> headers being available. Express that requirement in Kconfig as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/usb/gadget/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 46a83141481f..b0decd7b2512 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -202,6 +202,7 @@ config USB_FUNCTION_MASS_STORAGE
>   
>   config USB_FUNCTION_ROCKUSB
>           bool "Enable USB rockusb gadget"
> +	depends on ARCH_ROCKCHIP
>           help
>             Rockusb protocol is widely used by Rockchip SoC based devices. It can
>             read/write info, image to/from devices. This enables the USB part of

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

