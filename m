Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE78E7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC82874A5;
	Tue,  3 Oct 2023 15:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OmjJCsJo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RPJRIv0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B36874A2; Tue,  3 Oct 2023 15:41:02 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D510987486
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S0Jqv4Tzxz9spr;
 Tue,  3 Oct 2023 15:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9o/zG1KKsIfCt9lNeEwlNWVEUvDQ5YGvf9FL0R+F14=;
 b=OmjJCsJoJFSYBXG+6XH4i34jfawXVMcU3BgNGakN13xVhCgGKQsq4xQxUXIR4y2ILWUHOr
 epRuRX6P28MXni4E7BRRyJDjHBdMF4dcIepUVDAKnTdutayNNdbTayrmiv4hzSog2badMg
 KIDtPdarrVAVD4A9QzyGymxgvZlk/MXATk+smtQr/rt84ybwVIAH6VkxSqIMp3OERNMrno
 TpEJjRBu9AJ0qf7FMRj9NEGgyKZ5nUTAqNa1+Q2W67W43+rOwk3OA2mhzHVJ6pXdlZtRYr
 uZ8eUFTj/ggDIzZqtA/MY1xISb+uNhdsJDHMz49UA4c+ChRchhT4ZsuO8A4gHA==
Message-ID: <2effddcd-af1c-966b-9548-54be82536e06@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9o/zG1KKsIfCt9lNeEwlNWVEUvDQ5YGvf9FL0R+F14=;
 b=RPJRIv0PPaDwelPWQPx14pNIhoUwsq27hXLe3YD/WgFYnpJKZTts4nPVlCEUaPBQ1pJNFy
 BR6Sn+ZoerTKNftU3IZ2owJ0PXfb5J9UdEfY+TQdKMu+qL+6hYDt7CkD95N78ftXb9PGmr
 Up7LCNZ87F57hCCcxZ+MuZcGHeElB+9tezSP6yOY2fwQKr43gHPv1dwAQXHAvohfI4t84v
 BJMWSHUIb6h4eSpJrglD9HPtNHGFW950wX2NyJitVcIhVSjeI3Wt/jKmpCVdFDAtg0Qzbt
 cnPZvJW+zvyXOuHy7UxlwVZ5ouNcZT2VcjkfP6g8WpK+E3s4dz6L0BIv2+aBOg==
Date: Tue, 3 Oct 2023 15:25:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 11/16] mmc: renesas-sdhi: Initialize module on RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-12-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-12-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zrydzopmxrijmhwqyygrhaascqf6fwm6
X-MBO-RS-ID: a23e6198e9aec38f474
X-Rspamd-Queue-Id: 4S0Jqv4Tzxz9spr
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

On 9/20/23 14:42, Paul Barker wrote:
> On the Renesas RZ/G2L SoC family, we must ensure that the required clock
> signals are enabled and the reset signal is de-asserted before we try to
> communicate with the SDHI module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/mmc/renesas-sdhi.c | 61 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 8e716f74491f..170c5dcc2ebe 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -20,6 +20,7 @@
>   #include <linux/io.h>
>   #include <linux/sizes.h>
>   #include <power/regulator.h>
> +#include <reset.h>
>   #include <asm/unaligned.h>
>   #include "tmio-common.h"
>   
> @@ -964,6 +965,8 @@ static int renesas_sdhi_probe(struct udevice *dev)
>   	u32 quirks = dev_get_driver_data(dev);
>   	struct fdt_resource reg_res;
>   	DECLARE_GLOBAL_DATA_PTR;
> +	struct clk imclk2, aclk;
> +	struct reset_ctl rst;
>   	int ret;
>   
>   	priv->clk_get_rate = renesas_sdhi_clk_get_rate;
> @@ -1012,6 +1015,49 @@ static int renesas_sdhi_probe(struct udevice *dev)
>   		goto err_clkh;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_RZG2L)) {
> +		/*
> +		 * On members of the RZ/G2L SoC family, we need to enable
> +		 * additional chip detect and bus clocks, then release the SDHI
> +		 * module from reset.
> +		 */

This could use a separate function, and then, use bulk clock API via 
clk_get_bulk() and co .

> +		ret = clk_get_by_name(dev, "cd", &imclk2);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get imclk2 (chip detect clk)\n");
> +			goto err_get_imclk2;
> +		}

[...]
