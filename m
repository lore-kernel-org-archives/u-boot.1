Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C82C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1C187EA9;
	Sat,  2 Mar 2024 23:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="tgjJgIOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311D487EB2; Sat,  2 Mar 2024 23:25:26 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F73787EA9
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709418323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgINfTSDsTipbOMBk6UteXhp1gX+8LvP63XZMFOSZyo=;
 b=tgjJgIOcXalE6JK2m5wlgAM9cmEXbCjUv++V7AMeZ3mzfQkxdk8VeoaCDiUFzd3SVEU9Ie
 1GZjY7CVoGCPFrDPjzvQLGRIslfh+ozByeVb2GC/c13H6FCgmmB1XM+9DOBbyVI0AByTDm
 Um4mtIWkGCMlegrfrBLwnLwDl9i5kbprv9EQo2kSTQZtRg6MKPuTNGE94awgKIHlr2sadl
 rjgY1KIl7bIBA/gL5wy64A67WNvrh50ZlSZFkQgsOGbSHVznLjgvKMaBcB+KBKoqzA9i96
 0jljhyvHwc844N+6GAujGFZu7cagfqrOlaC9upHSJXwhBLEjmsv6nrFfFcJG0A==
Date: Sat, 02 Mar 2024 23:25:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de, kernel@collabora.com, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 2/2] rockchip: spl-boot-order: Improve debugging
 message when device isn't found
In-Reply-To: <20240302145107.168080-3-chris.obbard@collabora.com>
References: <20240302145107.168080-1-chris.obbard@collabora.com>
 <20240302145107.168080-3-chris.obbard@collabora.com>
Message-ID: <c55e8ab6b10f4ae15f117d3ef9c7a518@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Christopher,

On 2024-03-02 15:50, Christopher Obbard wrote:
> When debugging the SPL boot order, the node ID of a device which hasn't
> been found is printed but it can be quite hard to relate that to the
> specific devicetree node. To aid debugging, print the node path as well 
> as
> the ID.
> 
> Original debug message:
> 
>     board_boot_order: could not map node @73c to a boot-device
> 
> With this patch applied this becomes e.g:
> 
>    board_boot_order: could not map node @73c (/spi@ff1d0000/flash@0)
> to a boot-device

I'd suggest that the main part of the patch subject is adjusted
a bit, e.g. to something like "show DT path for missing device".

Otherwise, looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
> 
>  arch/arm/mach-rockchip/spl-boot-order.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c
> b/arch/arm/mach-rockchip/spl-boot-order.c
> index e548a7dc718..b23666fb017 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -151,8 +151,8 @@ void board_boot_order(u32 *spl_boot_list)
>  		/* Try to map this back onto SPL boot devices */
>  		boot_device = spl_node_to_boot_device(node);
>  		if (boot_device < 0) {
> -			debug("%s: could not map node @%x to a boot-device\n",
> -			      __func__, node);
> +			debug("%s: could not map node @%x (%s) to a boot-device\n",
> +			      __func__, node, conf);
>  			continue;
>  		}
