Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E09CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 14:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5F583AAE;
	Sat,  1 Nov 2025 15:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vS1JA1vE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FEC83AB0; Sat,  1 Nov 2025 15:16:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701FF83A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 15:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bfc8=5K=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762006593;
 bh=8LtZ5MZs0AoyO4Ytbd5jc7wuLra3c0MinF9ZuMr3+Lo=;
 b=vS1JA1vEozRwhl/wwYkrP4fD350UPhBpV12ib+vsisF3B/abvDBsvgOoBfzgWh3nS8ft6UP+o
 fREFjMxPKOm58O7aDPhgqhbIBpu62TfDKU4AZFLVq35NklGqOIR7zesM1FKWxOVXvA5D+LbWUHd
 gsUWzhrxYpRG2LRImO/owuAMS9sz1eihqn6RZg20+OORN72NAgBGp2nwqMpujPV2MBvDhLMmZz/
 vm5eLLA8O0yT5eyvw+sOzqRlZE9f6m9FXdBJIw0cQjv0Uz4ipTmNutRwtDPslR29V9xz+JF2wPU
 gbUwEOHRofAZj4E/M+vykLSFt/YHO57b0WJ+I+67l7bg==
X-Forward-Email-ID: 69061640d434f17504503da2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1ffa25f8-b2e0-4a2d-82cf-0c93349ec34c@kwiboo.se>
Date: Sat, 1 Nov 2025 15:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: spl-boot-order: Defer probe of boot device
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20250804182541.3858351-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250804182541.3858351-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Kever,

Please consider this patch for v2026.01.

Also found at https://patchwork.ozlabs.org/patch/2118921/

Regards,
Jonas

On 8/4/2025 8:25 PM, Jonas Karlman wrote:
> Boot devices are being probed when SPL boot order is determined, this
> may unnecessarily delay boot slightly.
> 
> Instead defer probe of the boot device until SPL try to load image from
> the boot device by using uclass_find_device_by_of_offset() instead of
> the get variant.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Update commit message
> ---
>  arch/arm/mach-rockchip/spl-boot-order.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 3dce9b30898d..6b1b84dc86d1 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -40,7 +40,7 @@ static int spl_node_to_boot_device(int node)
>  	 * aware of the block-device layer.  Until then (and to avoid unneeded
>  	 * delays in getting this feature out), it lives at the board-level.
>  	 */
> -	if (!uclass_get_device_by_of_offset(UCLASS_MMC, node, &parent)) {
> +	if (!uclass_find_device_by_of_offset(UCLASS_MMC, node, &parent)) {
>  		struct udevice *dev;
>  		struct blk_desc *desc = NULL;
>  
> @@ -72,7 +72,7 @@ static int spl_node_to_boot_device(int node)
>  	 * extended with awareness of the BLK layer (and matching OF_CONTROL)
>  	 * soon.
>  	 */
> -	if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
> +	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
>  		return BOOT_DEVICE_SPI;
>  
>  	return -1;

