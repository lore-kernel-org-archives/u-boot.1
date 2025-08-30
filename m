Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57CCA1000
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE7D83918;
	Sat, 30 Aug 2025 18:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AKfbIof3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D634083919; Sat, 30 Aug 2025 18:47:32 +0200 (CEST)
Received: from mail-m17218.xmail.ntesmail.com (mail-m17218.xmail.ntesmail.com
 [45.195.17.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BEA583906
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a6273;
 Sun, 31 Aug 2025 00:47:27 +0800 (GMT+08:00)
Message-ID: <ddb6b4c3-0def-4f2b-bbcb-dbe3acae144f@rock-chips.com>
Date: Sun, 31 Aug 2025 00:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] rockchip: rk3576: Disable USB3OTG0 U3 port early
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbe0710903afkunmb7c6f20542d377
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0JPVh0fTklIGkseQx9KH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=AKfbIof3WYO3Ifa56z3BW5fU2AB0VjfI+tWewXiZxgVIIWxzH+p8i+eq0GaQuMr5l4BdA4xuc5iHnBkjjxuZYzCteDZtEaU7WK824jhqHZbbWhHnYPF8tLVPikJ1fCZHXRuJHwmjh+XmCxOd/Gf+ls4Yv8rtrZtwiDPI2WjoscY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=4KJtAfI6LWqSqDzE+XfDxJuK13f70iLY614DqBFhzgA=;
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
> The RK3576 SoC comes with USB OTG support using a DWC3 controller with
> a USB2 PHY and a USB3 PHY (USBDP PHY).
>
> Some board designs may not use the USBDP PHY for USB3 purpose. For these
> board to use USB OTG the input clock source must change to use UTMI clk
> instead of PIPE clk.
>
> Change to always disable the USB3OTG0 U3 port early and leave it to the
> USBDP PHY driver to re-enable the U3 port when a usb3-phy is described
> in the board device tree.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index ba5c94b4b3dd..dc53941ab2f5 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -29,6 +29,9 @@
>   #define SGRF_DOMAIN_CON4	0x10
>   #define SGRF_DOMAIN_CON5	0x14
>   
> +#define USB_GRF_BASE		0x2601E000
> +#define USB3OTG0_CON1		0x0030
> +
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
>   	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
> @@ -151,5 +154,8 @@ int arch_cpu_init(void)
>   	 */
>   	writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
>   
> +	/* Disable USB3OTG0 U3 port, later enabled by USBDP PHY driver */
> +	writel(0xffff0188, USB_GRF_BASE + USB3OTG0_CON1);
> +
>   	return 0;
>   }
