Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07B6CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB998838EE;
	Sat, 30 Aug 2025 18:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GpE23ZKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52401838F8; Sat, 30 Aug 2025 18:47:16 +0200 (CEST)
Received: from mail-m254101.xmail.ntesmail.com
 (mail-m254101.xmail.ntesmail.com [103.129.254.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8645A838EC
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a626d;
 Sun, 31 Aug 2025 00:47:10 +0800 (GMT+08:00)
Message-ID: <054ab651-530b-4111-b4df-2cdd56ecdbcd@rock-chips.com>
Date: Sun, 31 Aug 2025 00:47:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] rockchip: rk3588: Disable USB3OTG U3 ports early
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbe02f6a03afkunma81f98ff42d1f3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR1NVk5NSEIdSE9PH09CTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=GpE23ZKeORSFRMXkPrWjXKo7tmgZur2aCpHuti5VVlmypBKE18Jp41LSmKp8KvM1Hizq6BVIR8t5jthgg9I4VCIso8L7zCI6PiAmpvqadEOV72Sd4/ZEsAHoDCzMeHuyAxhw8kuest4EvQYoXV3NUwJSaUiNzU+wWLxEjv7CoVc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=VAdqz/lJVnOZdKvaUpR6Fnwr/S+No/9Ii98i+MMjdiQ=;
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


On 2025/7/22 06:07, Jonas Karlman wrote:
> The RK3588 SoC comes with USB OTG support using a DWC3 controller with
> a USB2 PHY and a USB3 PHY (USBDP PHY).
>
> Some board designs may not use the USBDP PHY for USB3 purpose. For these
> board to use USB OTG the input clock source must change to use UTMI clk
> instead of PIPE clk.
>
> Change to always disable the USB3OTG U3 ports early and leave it to the
> USBDP PHY driver to re-enable the U3 port when a usb3-phy is described
> in the board device tree.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index e2278ff792b4..c01a40020896 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -15,6 +15,10 @@
>   #include <asm/arch-rockchip/hardware.h>
>   #include <asm/arch-rockchip/ioc_rk3588.h>
>   
> +#define USB_GRF_BASE			0xfd5ac000
> +#define USB3OTG0_CON1			0x001c
> +#define USB3OTG1_CON1			0x0034
> +
>   #define FIREWALL_DDR_BASE		0xfe030000
>   #define FW_DDR_MST5_REG			0x54
>   #define FW_DDR_MST13_REG		0x74
> @@ -184,6 +188,10 @@ int arch_cpu_init(void)
>   	/* Disable JTAG exposed on SDMMC */
>   	rk_clrreg(&sys_grf->soc_con[6], SYS_GRF_FORCE_JTAG);
>   #endif
> +
> +	/* Disable USB3OTG U3 ports, later enabled by USBDP PHY driver */
> +	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
> +	writel(0xffff0188, USB_GRF_BASE + USB3OTG1_CON1);
>   #endif
>   
>   	return 0;
