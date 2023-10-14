Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5656CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B150786EE4;
	Sun, 15 Oct 2023 08:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sLcYeNhI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m3473Gqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5D286AB9; Sun, 15 Oct 2023 08:32:08 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F394586F36
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S7DZq3TCBz9sd5;
 Sat, 14 Oct 2023 21:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP1GpKmn2UepVBmNm22qYZVUpbgdUhEUUbupyqgVQOI=;
 b=sLcYeNhIqGgYijOUt0lEogfSn4PbYlMqhST8vQVdeYB5FWR5fW3wJfIiUKAlfJARnQWzqf
 SB/m8ibvOKEKkIZNKT3Etr3YoRhWkGrp0Kkyxl2TaedEg9hsXzEWTW0RStKWr4qQYVWeEM
 AuFVzjC7odGRWdty18apo3SoXjYYQLdRD4jq5kjxl34P+5M8KH5CcdhP/w8XQUYBqXRLN4
 Em1D4bp/RcC/p0Tz/SuxKO8lnSe04wFAqd/tpnA/nsg5mN4hJMpyR1MGRdFvB4IgMevxeG
 nnSoiQBx5iP1Ra/GoC380MwefQabCjbSdH6RojRYQ0wRraZm0cN0pAj7RNWwbQ==
Message-ID: <f1a825ff-a6e9-4b53-b270-ccaf42bc1250@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP1GpKmn2UepVBmNm22qYZVUpbgdUhEUUbupyqgVQOI=;
 b=m3473GqoW5ybWTIAx5OPwncOQpwyGmmQ4Vl0BpSAsEs1WGC1pJkwrVsKH903WbZ4LVCPeb
 wz29SbTpuJa/9cq91zKBW33gWRspQohf5eApyaiVzWq4a5MX+xbUKWNx16Ym7kzkIJWZQ6
 N6Bv9NJQh3CBOfKoh6GXvp0w6BM7GYtbhqdvueOCHakXFi9o8zE0DwFVWZMMYl5ZxB2HIT
 NxV1e5LUmKgOT3wpS6lsbjnoB0uTzkZdMwGmY4pw+smkuBOQCqmedsJbmt8uPxfuly5t3a
 nnU4KbJ6ifZMLhJLgYC2/VS3xGPebwh3ICZdoNO2GiWC47iwZMoLCrjAne3I2w==
Date: Sat, 14 Oct 2023 21:53:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 12/19] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-13-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 658626fa3bd1e5822a2
X-MBO-RS-META: ica8xrrouuusarn7bu64a48hca4f4pzk
X-Rspamd-Queue-Id: 4S7DZq3TCBz9sd5
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

On 10/9/23 18:46, Paul Barker wrote:
> Extend the existing driver to support the SCIF serial ports on the
> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
> relevant reset signal is de-asserted before we try to talk to the SCIF
> module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>    * Moved handle_error() changes out to a separate patch earlier in the
>      series.
>    * Unconditionally de-assert the module reset during probe.
> 
>   arch/arm/mach-rmobile/Kconfig |  1 +
>   drivers/serial/serial_sh.c    | 17 +++++++++++++++++
>   drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>   3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index c30ff2caad17..c421181c89cf 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -77,6 +77,7 @@ config RZG2L
>   	imply MULTI_DTB_FIT_USER_DEFINED_AREA
>   	imply PINCTRL_RZG2L
>   	imply RENESAS_SDHI
> +	imply SCIF_CONSOLE
>   	imply SYS_MALLOC_F
>   	help
>   	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> index 2b650d458e71..6ea8da34d434 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -17,6 +17,8 @@
>   #include <linux/compiler.h>
>   #include <dm/platform_data/serial_sh.h>
>   #include <linux/delay.h>
> +#include <dm/device_compat.h>
> +#include <reset.h>
>   #include "serial_sh.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -199,12 +201,26 @@ static int sh_serial_probe(struct udevice *dev)
>   {
>   	struct sh_serial_plat *plat = dev_get_plat(dev);
>   	struct uart_port *priv = dev_get_priv(dev);
> +	struct reset_ctl rst;
> +	int ret;
>   
>   	priv->membase	= (unsigned char *)plat->base;
>   	priv->mapbase	= plat->base;
>   	priv->type	= plat->type;
>   	priv->clk_mode	= plat->clk_mode;
>   
> +	ret = reset_get_by_index(dev, 0, &rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get reset line\n");
> +		return ret;
> +	}
> +
> +	ret = reset_deassert(&rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to de-assert reset line\n");
> +		return ret;
> +	}
> +
>   	sh_serial_init_generic(priv);
>   
>   	return 0;
> @@ -223,6 +239,7 @@ static const struct udevice_id sh_serial_id[] ={
>   	{.compatible = "renesas,scif", .data = PORT_SCIF},
>   	{.compatible = "renesas,scifa", .data = PORT_SCIFA},

Please keep the list sorted, the entry should be here.

>   	{.compatible = "renesas,hscif", .data = PORT_HSCIF},
> +	{.compatible = "renesas,scif-r9a07g044", .data = PORT_SCIFA},
>   	{}
>   };

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
