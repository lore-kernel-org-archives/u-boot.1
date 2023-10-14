Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDEDCDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C3886F48;
	Sun, 15 Oct 2023 08:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HlQzZ7Wm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FOnqv/iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B4F86E47; Sun, 15 Oct 2023 08:36:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9EF86F29
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S7DfY2jlKz9slT;
 Sat, 14 Oct 2023 21:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZIQrszuI8Eu8aZmIkLwcylDNEh3aCKB01uLEtaB7dQ=;
 b=HlQzZ7WmjIYKCBEEIGRASYOUbQyCx/FGJaZA57DNALyDBpr1WN7Uj00KKnpnIAwoYxJCTA
 ZzV0R+mFLphJTOaBqz8/7ZWjN/Ld88xDPV0ATVjy1a6a/LHWDFLe/Z2cIqM2DTXZcY03PK
 SILk2dijz5xge7zHjXMzEIGbV3BNjtMKBoIGvWMWFJd4VX2xGRVNJWKAhSiyJLEzHhvsl8
 UBlFvTo+3Aj4a3D+g1lAc42jst8CG1Xuv0xYPuSzgGcJdjJtNyunoi5niZ4FWkkOpuEd2A
 rupOPhFRkVc4Dt1OMK02j7MzfyWKxx1he8se8uvjCxbsL2FAD4EHzpl/tOOcYg==
Message-ID: <6d5ea343-5ce8-49e2-96cf-83762c15d568@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZIQrszuI8Eu8aZmIkLwcylDNEh3aCKB01uLEtaB7dQ=;
 b=FOnqv/iyMCNneC/e7S2jT5CzKNr2SCbDg2G/O+4DV9LhbjORSsOn19hhBkk2oVlQu6VTEQ
 Rj/ZbFjMkbUKN6RY/R9WQPekKpFwFJdChP4Xd0OgJ1IUD/8QZuTzLUkPuiHCXQ5hGr8pHI
 jFOlnp0xndkiTWxVTjAdejqhaBVO6zBS/l1EGi9C77O6OeCHzwakmA0ckuW638I3V2XvIt
 LtkHwqMbqJYJ7r6RWF3B1oHlDaO5wU0Nlab1tzpzQSBObmHCde+sS5FIVLHMYh1/wpSL8G
 gPOOWCcHhbwcy+WABcK8zvsOrBaEXarfzK+/3Yrlk/JvcQ+zDzZOeiYyahup7A==
Date: Sat, 14 Oct 2023 21:56:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 14/19] mmc: renesas-sdhi: Initialize module on RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-15-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-15-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b7cac8c2578b0a74d42
X-MBO-RS-META: frasaag3tbctgi8o6ka18ebjzfe85x4m
X-Rspamd-Queue-Id: 4S7DfY2jlKz9slT
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
> On the Renesas RZ/G2L SoC family, we must ensure that the required clock
> signals are enabled and the reset signal is de-asserted before we try to
> communicate with the SDHI module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>    * Move RZ/G2L specific setup to its own function.
> 
>   drivers/mmc/renesas-sdhi.c | 82 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 1536c9782041..370dbce51ca0 100644
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
> @@ -958,6 +959,74 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
>   		priv->needs_clkh_fallback = false;
>   }
>   
> +static int rzg2l_sdhi_setup(struct udevice *dev)
> +{
> +	struct tmio_sd_priv *priv = dev_get_priv(dev);
> +	struct clk imclk2, aclk;
> +	struct reset_ctl rst;
> +	int ret;
> +
> +	/*
> +	 * On members of the RZ/G2L SoC family, we need to enable
> +	 * additional chip detect and bus clocks, then release the SDHI
> +	 * module from reset.
> +	 */
> +	ret = clk_get_by_name(dev, "cd", &imclk2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get imclk2 (chip detect clk)\n");
> +		goto err_get_imclk2;
> +	}
> +
> +	ret = clk_get_by_name(dev, "aclk", &aclk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get aclk\n");
> +		goto err_get_aclk;
> +	}
> +
> +	ret = clk_enable(&imclk2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable imclk2 (chip detect clk)\n");
> +		goto err_imclk2;
> +	}
> +
> +	ret = clk_enable(&aclk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable aclk\n");
> +		goto err_aclk;
> +	}
> +
> +	ret = reset_get_by_index(dev, 0, &rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get reset line\n");
> +		goto err_reset;
> +	}
> +
> +	ret = reset_deassert(&rst);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to de-assert reset line\n");
> +		goto err_reset;
> +	}
> +
> +	ret = tmio_sd_probe(dev, priv->quirks);
> +	if (ret)
> +		goto err_tmio_probe;
> +
> +	return 0;
> +
> +err_tmio_probe:
> +	reset_assert(&rst);
> +err_reset:
> +	clk_disable(&aclk);
> +err_aclk:
> +	clk_disable(&imclk2);
> +err_imclk2:
> +	clk_free(&aclk);
> +err_get_aclk:
> +	clk_free(&imclk2);
> +err_get_imclk2:
> +	return ret;
> +}
> +
>   static int renesas_sdhi_probe(struct udevice *dev)
>   {
>   	struct tmio_sd_priv *priv = dev_get_priv(dev);
> @@ -1012,9 +1081,15 @@ static int renesas_sdhi_probe(struct udevice *dev)
>   		goto err_clkh;
>   	}
>   
> -	ret = tmio_sd_probe(dev, priv->quirks);
> -	if (ret)
> -		goto err_tmio_probe;
> +	if (IS_ENABLED(CONFIG_RZG2L)) {

Shouldn't there be some compatible string check here too ?

> +		ret = rzg2l_sdhi_setup(dev);
> +		if (ret)
> +			goto err_rzg2l_setup;
> +	} else {
> +		ret = tmio_sd_probe(dev, priv->quirks);
> +		if (ret)
> +			goto err_tmio_probe;
> +	}
>   
>   	renesas_sdhi_filter_caps(dev);
>   
> @@ -1026,6 +1101,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
>   #endif
>   	return 0;
>   
> +err_rzg2l_setup:
>   err_tmio_probe:
>   	clk_disable(&priv->clk);

I think here you can use err_tmio_probe() in any case.
