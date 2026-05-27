Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E91CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99168341A;
	Wed, 27 May 2026 14:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K3SKpABs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEDF839A8; Wed, 27 May 2026 14:16:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC198056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gQTBR3ZXcz9ty2;
 Wed, 27 May 2026 14:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779884207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZoYU9/z+RIjwJnhV4urHowIFwdA1P14wmvSfpbJEJA=;
 b=K3SKpABs4TFFsxsUjlZbNgJD/wcBHx4chY7e8JGRgIorWHf8ODM6KFBiN8j7cRY1F8oxwW
 eoC/S6kVzcgYLjsRH4+cYmKjV07eYhRjo5ib5yPXTlUE/f94kdor/qWTEaSvcXIN8dqG9G
 2+8uqF0sfi3mgyzir505UUMkRmkBRujTl6j5TaWxbB/psd8QBBMafPinZpkKHs9M6JCNH6
 lpCMC2S1Mnbty9mu/dcrpXmaKNXZQUVEfDPaHE0n+upDZlAbjFTZvtTp7C+aswdTxO8PPu
 cHNvWpYLhF0csSi6ZDRazZzxMolz0k2nvV8jD7SLHkimh2JbukONDG91lsWVTg==
Message-ID: <f350e6bb-55ba-4303-87fe-623f2285e2bc@mailbox.org>
Date: Wed, 27 May 2026 14:16:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] phy: ti-pipe3: Use device API for DT parsing
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
 <20260526-devfdt-phy-v1-1-908ff621dea4@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260526-devfdt-phy-v1-1-908ff621dea4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nwkc1y559e9i6s1hu4uag1xke4ifsjo5
X-MBO-RS-ID: d2bed089941f63f45a8
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

On 5/26/26 08:39, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace legacy FDT parsing in get_reg() with the device API
> dev_read_phandle_with_args() which removes direct access to gd->fdt_blob
> and aligns the driver with modern U-Boot DT handling.
> 
> The offset is retrieved from the phandle argument instead of manually
> parsing the property cells. Add validation for the argument
> count to avoid out-of-bounds access on malformed DTs.
> 
> Also switch from devfdt_get_addr_size_index() to dev_read_addr_size_index()
> for consistency with the DM API.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/phy/ti-pipe3-phy.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/ti-pipe3-phy.c b/drivers/phy/ti-pipe3-phy.c
> index 62f6cc2bfbf..080016ba417 100644
> --- a/drivers/phy/ti-pipe3-phy.c
> +++ b/drivers/phy/ti-pipe3-phy.c
> @@ -6,6 +6,7 @@
>   
>   #include <dm.h>
>   #include <dm/device.h>
> +#include <dm/device_compat.h>
>   #include <generic-phy.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> @@ -428,10 +429,10 @@ static int pipe3_exit(struct phy *phy)
>   
>   static void *get_reg(struct udevice *dev, const char *name)
>   {
> +	struct ofnode_phandle_args phandle;
>   	struct udevice *syscon;
>   	struct regmap *regmap;
> -	const fdt32_t *cell;
> -	int len, err;
> +	int err;
>   	void *base;
>   
>   	err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
> @@ -449,10 +450,14 @@ static void *get_reg(struct udevice *dev, const char *name)
>   		return NULL;
>   	}
>   
> -	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), name,
> -			   &len);
> -	if (len < 2*sizeof(fdt32_t)) {
> -		pr_err("offset not available for %s\n", name);
> +	err = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &phandle);
> +	if (err) {
> +		dev_err(dev, "parse %s failed: %d\n", name, err);
> +		return NULL;
> +	}
> +
> +	if (phandle.args_count < 1) {
> +		dev_err(dev, "%s: missing args\n", name);
>   		return NULL;
>   	}
>   
> @@ -460,7 +465,7 @@ static void *get_reg(struct udevice *dev, const char *name)
>   	if (!base)
>   		return NULL;
>   
> -	return fdtdec_get_number(cell + 1, 1) + base;
> +	return base + phandle.args[0];
>   }
>   
>   static int pipe3_phy_probe(struct udevice *dev)
> @@ -471,7 +476,7 @@ static int pipe3_phy_probe(struct udevice *dev)
>   	struct pipe3_data *data;
>   
>   	/* PHY_RX */
> -	addr = devfdt_get_addr_size_index(dev, 0, &sz);
> +	addr = dev_read_addr_size_index(dev, 0, &sz);
>   	if (addr == FDT_ADDR_T_NONE) {
>   		pr_err("missing phy_rx address\n");
>   		return -EINVAL;
> @@ -484,7 +489,7 @@ static int pipe3_phy_probe(struct udevice *dev)
>   	}
>   
>   	/* PLLCTRL */
> -	addr = devfdt_get_addr_size_index(dev, 2, &sz);
> +	addr = dev_read_addr_size_index(dev, 2, &sz);
>   	if (addr == FDT_ADDR_T_NONE) {
>   		pr_err("missing pll ctrl address\n");
>   		return -EINVAL;
> 

