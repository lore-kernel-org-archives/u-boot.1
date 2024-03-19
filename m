Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80DEC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 09:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180E586F67;
	Tue, 19 Mar 2024 10:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RxFeJGjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC11B87CFE; Tue, 19 Mar 2024 10:15:30 +0100 (CET)
Received: from mail-m155106.qiye.163.com (mail-m155106.qiye.163.com
 [101.71.155.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9196486DBD
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 10:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=RxFeJGjMyZPMW5E7aczoeR8RPovOfvsI7gzBb6/VnjU3a0mLDtxIQzhvfDl+xjf2UEbtPZzG2aE9u0Cpqgs/JMMwQGjIsP6qqk7nqyw5oviYbusZcn7RZyRjYeNi3K7MTOvhEOpYNe9lv9k7WWMdzOlnV5oxN80jSgDK7OZS+Vw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=DaOUrqMGxxtmrl1UtQmbeBw/HZhaD8i0oJJaQKXah0s=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 7EC509003B2;
 Tue, 19 Mar 2024 17:15:09 +0800 (CST)
Message-ID: <5263b2e7-7660-45bc-be5d-cd99647be486@rock-chips.com>
Date: Tue, 19 Mar 2024 17:15:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl: Cache boot source id for later use
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240315173454.2672509-1-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240315173454.2672509-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8ZHlZLHkNCSU4YGhpIHktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e55fe407b03a9kunm7ec509003b2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pzo6HQw5ATMUGhw2T1E3LEwh
 LTVPCS1VSlVKTEpLQ0hCTEpLSENDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT0JLNwY+
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


On 2024/3/16 01:34, Jonas Karlman wrote:
> Rockchip BROM write a boot source id at CFG_IRAM_BASE + 0x10, the id
> indicate from what storage media TPL/SPL was loaded from.
>
> SPL use this value to determine what device "same-as-spl" represent when
> determining from where FIT should be loaded. This works as long as the
> boot_devices array contain a matching id <-> node path entry.
>
> However, SPL typically load a small part of TF-A into SRAM and on RK3399
> this overwrites the CFG_IRAM_BASE + 0x10 addr used for boot source id.
>
> Here boot source id is 3 before FIT images is loaded, and 0 after:
>
>    U-Boot SPL 2024.04-rc4 (Mar 15 2024 - 17:26:19 +0000)
>    board_spl_was_booted_from: brom_bootdevice_id 3 maps to '/spi@ff1d0000/flash@0'
>    Trying to boot from SPI
>    ## Checking hash(es) for config config-1 ... OK
>    ## Checking hash(es) for Image atf-1 ... sha256+ OK
>    ## Checking hash(es) for Image u-boot ... sha256+ OK
>    ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>    ## Checking hash(es) for Image atf-2 ... sha256+ OK
>    ## Checking hash(es) for Image atf-3 ... sha256+ OK
>    board_spl_was_booted_from: failed to resolve brom_bootdevice_id 0
>    spl_decode_boot_device: could not find udevice for /mmc@fe330000
>    spl_decode_boot_device: could not find udevice for /mmc@fe320000
>    spl_perform_fixups: could not map boot_device to ofpath: -19
>
> Use a static bootdevice_brom_id to cache the boot source id after an
> initial read from SRAM to fix this, this allow spl_perform_fixups() to
> resolve correct boot source path for "same-as-spl" after SPL have loaded
> TF-A related FIT images into memory.
>
> With this the spl-boot-device prop can correctly be resolved to the
> SPI flash node in the control FDT:
>
>    => fdt addr ${fdtcontroladdr}
>    Working FDT set to f1ee6710
>    => fdt list /chosen
>    chosen {
>        u-boot,spl-boot-device = "/spi@ff1d0000/flash@0";
>        stdout-path = "serial2:1500000n8";
>        u-boot,spl-boot-order = "same-as-spl", "/mmc@fe330000", "/mmc@fe320000";
>    };
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/spl.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 1586a093fc37..27e996b504e7 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -32,9 +32,17 @@ __weak const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   
>   const char *board_spl_was_booted_from(void)
>   {
> -	u32  bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +	static u32 bootdevice_brom_id;
>   	const char *bootdevice_ofpath = NULL;
>   
> +	if (!bootdevice_brom_id)
> +		bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +	if (!bootdevice_brom_id) {
> +		debug("%s: unknown brom_bootdevice_id %x\n",
> +		      __func__, bootdevice_brom_id);
> +		return NULL;
> +	}
> +
>   	if (bootdevice_brom_id < ARRAY_SIZE(boot_devices))
>   		bootdevice_ofpath = boot_devices[bootdevice_brom_id];
>   
