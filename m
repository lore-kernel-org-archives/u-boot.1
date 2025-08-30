Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EBDCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00810836B2;
	Sat, 30 Aug 2025 17:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kyyQj0hX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C3683881; Sat, 30 Aug 2025 17:24:48 +0200 (CEST)
Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com
 [45.254.49.227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D2858341A
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f988b;
 Sat, 30 Aug 2025 23:24:43 +0800 (GMT+08:00)
Message-ID: <c543388f-39dc-4bad-810d-c56fe964c4db@rock-chips.com>
Date: Sat, 30 Aug 2025 23:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] rockchip: rk3528: Disable USB3OTG U3 port early
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb94b25d03afkunm17f85b4c4155fd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE1NVhlKGUpMS05OTx1KTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=kyyQj0hXhKVd7kE+k68PenP29DU68z4K1YJGbpPMBkl3HgPFS8TV+FB8oC8+KmbV3iKmS4RKlgikUPskRRa2kNGSKmlH257K/7uEdmTMxdPt58U8Hd9ZrVzyHrT3RFPBSyjkWZm1oZLAO7IDyjyaG5TDuJBB0E8P6pQKgLaQSXY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=5iX0PIT7ZXlS/DdNRECpbZMtcYfJbgd5RKEXiQeQBBY=;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> The RK3528 SoC comes with USB OTG support using a DWC3 controller with
> a USB2 PHY and a USB3 PHY (COMBPHY).
>
> Some board designs may not use the COMBPHY for USB3 purpose. For these
> board to use USB OTG the input clock source must change to use UTMI clk
> instead of PIPE clk.
>
> Change to always disable the USB3OTG U3 port early and leave it to the
> COMBPHY driver to re-enable the U3 port when a usb3-phy is described in
> the board device tree.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3528/rk3528.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
> index 4892ff6ba9d2..f9bfc445b857 100644
> --- a/arch/arm/mach-rockchip/rk3528/rk3528.c
> +++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
> @@ -9,6 +9,9 @@
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/hardware.h>
>   
> +#define VPU_GRF_BASE			0xff340000
> +#define USB3OTG_CON1			0x44
> +
>   #define FIREWALL_DDR_BASE		0xff2e0000
>   #define FW_DDR_MST6_REG			0x58
>   #define FW_DDR_MST7_REG			0x5c
> @@ -69,6 +72,9 @@ int arch_cpu_init(void)
>   	val = readl(FIREWALL_DDR_BASE + FW_DDR_MST16_REG);
>   	writel(val & 0xffff0000, FIREWALL_DDR_BASE + FW_DDR_MST16_REG);
>   
> +	/* Disable USB3OTG U3 port, later enabled in COMBPHY driver */
> +	writel(0xffff0181, VPU_GRF_BASE + USB3OTG_CON1);
> +
>   	return 0;
>   }
>   
