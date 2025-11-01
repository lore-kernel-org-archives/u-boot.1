Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D971CCFA02
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 16:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE6283885;
	Sat,  1 Nov 2025 17:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BPNxiflt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33D78389A; Sat,  1 Nov 2025 17:07:51 +0100 (CET)
Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com
 [220.197.32.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CF183885
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 17:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 28044c687;
 Sun, 2 Nov 2025 00:07:45 +0800 (GMT+08:00)
Message-ID: <7f3455d7-2802-4743-99a4-9f9362aa3a58@rock-chips.com>
Date: Sun, 2 Nov 2025 00:07:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: spl-boot-order: Defer probe of boot device
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20250804182541.3858351-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250804182541.3858351-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a402cbe7003afkunm8fdbd01e9a6a12
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh5CVh0YHk1OT05CSxlDH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=BPNxifltGbHMdj7sTkFkD3g5ktfNdOhYcYutfKoC+IVLhLXhT3fUebRoz/RjO5mVojs0IMwxg8j1XARgQVHkqk1kzc19dr+Ul9cSAXziTTlazvYpB0LNN8mW1a/fhRSRiACVE/Mv9XuRHRhOUcBtewa0pEodHQzPtGcCjqP+2g4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=fjJ/a4DgtwV910Zdp4VpIZIUTN8TiHnbsLBxSr0PkdM=;
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


On 2025/8/5 02:25, Jonas Karlman wrote:
> Boot devices are being probed when SPL boot order is determined, this
> may unnecessarily delay boot slightly.
>
> Instead defer probe of the boot device until SPL try to load image from
> the boot device by using uclass_find_device_by_of_offset() instead of
> the get variant.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Update commit message
> ---
>   arch/arm/mach-rockchip/spl-boot-order.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 3dce9b30898d..6b1b84dc86d1 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -40,7 +40,7 @@ static int spl_node_to_boot_device(int node)
>   	 * aware of the block-device layer.  Until then (and to avoid unneeded
>   	 * delays in getting this feature out), it lives at the board-level.
>   	 */
> -	if (!uclass_get_device_by_of_offset(UCLASS_MMC, node, &parent)) {
> +	if (!uclass_find_device_by_of_offset(UCLASS_MMC, node, &parent)) {
>   		struct udevice *dev;
>   		struct blk_desc *desc = NULL;
>   
> @@ -72,7 +72,7 @@ static int spl_node_to_boot_device(int node)
>   	 * extended with awareness of the BLK layer (and matching OF_CONTROL)
>   	 * soon.
>   	 */
> -	if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
> +	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
>   		return BOOT_DEVICE_SPI;
>   
>   	return -1;
