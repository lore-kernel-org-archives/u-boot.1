Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1EDC6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 16:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636F3879E0;
	Sun, 24 Mar 2024 17:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="LGO6KDCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAF88786C; Sun, 24 Mar 2024 17:20:38 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383A787D2F
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 17:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711297235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r+yGXhRHFZlLl6RuaGhxlL2X5evxOa6Xz9wDnf/7F8=;
 b=LGO6KDCx3WFgPaWQkdXnsyCXdDs6DRs2+bMMFVR/3kVizezn61R+YP+WPSk272Y5yusBW0
 PX9SVImBQDSMGzEuagN73Gt3mAA1UuyGTNgNO3MUYBNuxkYfSE/XxldHjMo6EVAmiTBmPC
 aEh5S39ez6pLlHrWjo/SRnwvhCf8+vkCEy8CJrBdO70CeoipY+oc/eqzYZhrycEYhg0gEE
 wVVPmS/mdyvR46hAF7/sMK0A5P3UiNnK/jjIGwSJzzUhEUekQP5QyF5iSyVLSPYlXFaPEe
 HgdFj4AA89IxyCWf6SoKGSwEZBtv7bss0AwCHtVIEd7zt8mX/cpR46lwHYxvew==
Date: Sun, 24 Mar 2024 17:20:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de, Jason Zhu
 <jason.zhu@rock-chips.com>
Subject: Re: [PATCH v2 1/3] rockchip: bootrom: Sync bootsource id enum from
 bootrom
In-Reply-To: <20240322205027.3860170-2-jonas@kwiboo.se>
References: <20240322205027.3860170-1-jonas@kwiboo.se>
 <20240322205027.3860170-2-jonas@kwiboo.se>
Message-ID: <bbf50556a9adb329af9b50dac145626d@manjaro.org>
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

On 2024-03-22 21:50, Jonas Karlman wrote:
> From: Jason Zhu <jason.zhu@rock-chips.com>
> 
> Add more bootsource id:
> 1. BROM_BOOTSOURCE_UNKNOWN
> 2. BROM_BOOTSOURCE_I2C
> 3. BROM_BOOTSOURCE_SPI
> 
> Signed-off-by: Jason Zhu <jason.zhu@rock-chips.com>
> [jonas@kwiboo.se: Update commit message]
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v2:
> - New patch
> ---
>  arch/arm/include/asm/arch-rockchip/bootrom.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h
> b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index 4276a0f6811a..ecf3b4e7428c 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -43,11 +43,14 @@ void back_to_bootrom(enum rockchip_bootrom_cmd 
> brom_cmd);
>   * Boot-device identifiers as used by the BROM
>   */
>  enum {
> +	BROM_BOOTSOURCE_UNKNOWN = 0,
>  	BROM_BOOTSOURCE_NAND = 1,
>  	BROM_BOOTSOURCE_EMMC = 2,
>  	BROM_BOOTSOURCE_SPINOR = 3,
>  	BROM_BOOTSOURCE_SPINAND = 4,
>  	BROM_BOOTSOURCE_SD = 5,
> +	BROM_BOOTSOURCE_I2C = 8,
> +	BROM_BOOTSOURCE_SPI = 9,
>  	BROM_BOOTSOURCE_USB = 10,
>  	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
>  };
