Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C05FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 06:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F8F88677;
	Mon,  5 Aug 2024 08:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mot/wQt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C0288850; Mon,  5 Aug 2024 08:38:45 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0540388427
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 08:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B4F1060B7F;
 Mon,  5 Aug 2024 06:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F37BC32782;
 Mon,  5 Aug 2024 06:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722839921;
 bh=rjDaVOcHEaQDqHIjPh5DGJd+99QhYJsKKL5YliKsRH0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Mot/wQt2TcUrKN7f+jXB7DRKHT2FAPpK8eBGaLeQ05p60DTeV7SHvKOEh8F58XHm4
 iq5yJMiFkZqOY+tbiwPdkKtXUI1pkClwQwgrrlNwWnQPapq4G9LubKS3zFmIaCqsiX
 sMnmmdec8M19n99kYEop6kEiXW6hXPIur/f60L1XP0N8q/5ly5mkfA2397NYyZByzP
 4KEkjx0oxcxaDZ7nWsoIr0dT4KWBiks7Q/8s8ew4LZxWqeGjeX6fmJAqk06z5D5sGU
 kzZIahWubuE0S9QFcYBaQ91gg0X1cmNrC8NnrY8dQ8l3cp6/z28G//OS7zBUDWK6gA
 8BDKsbbIi9SqQ==
Message-ID: <c7195d30-2789-4d31-81ca-5f285cae40e7@kernel.org>
Date: Mon, 5 Aug 2024 09:38:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: uclass: Modify uc_pdata->name to use
 combination of device name and device's parent name
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20240719085908.3564171-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240719085908.3564171-1-danishanwar@ti.com>
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



On 19/07/2024 11:59, MD Danish Anwar wrote:
> uc_pdata->name is populated from device tree property "remoteproc-name".
> For those devcices that don't set "remoteproc-name", uc_pdata->name
> falls back to dev->name.
> 
> If two devices have same name, this will result into uc_pdata->name not
> being unique and rproc_init() will fail.
> 
> Fix this by using combination of dev->name and dev->parent->name instead
> of using just the dev->name to populate uc_pdata->name.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Andrew Davis <afd@ti.com>
> 
> Failure Example:
> In k3-am64-main.dtsi, both pru0_0 [1] and pru1_0 [2] will have
> dev->name as "pru@34000" although their parent name is different.
> 
> pru0_0 has dev->name as "pru@34000" and parent name as "icssg@30000000"
> pru1_0 has dev->name as "pru@34000" and parent name as "icssg@30080000"
> 
> rproc_init() fails for pru1_0 as the the uc_pdata->name becomes same as the pru0_0.
> More details on this issue can be found here [3]. It was suggested to use a
> different combination if `dev->name` is not unique by Andrew Davis <afd@ti.com> [4]
> 
> Failure Logs:
> 	rproc_pre_probe: 'pru@34000': using fdt
> 	rproc_pre_probe: 'pru@34000': using fdt
> 	rproc_pre_probe: pru@34000 duplicate name 'pru@34000'
> 	_rproc_probe_dev: pru@34000: Failed to initialize - -22
> 	rproc_boot: rproc_init() failed: -22
> 
> To fix it, this commit uses combination of dev and dev's parent name.
> 
> After this commit,
> pru0_0 uc->pdata->name = "pru@34000:icssg@30000000"
> pru1_0 uc->pdata->name = "pru@34000:icssg@30080000"
> 
> Both the names are unique, thus rproc_init() succeeds.
> 
> [1] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
> [2] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
> [3] https://lore.kernel.org/all/5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com/
> [4] https://lore.kernel.org/all/e48f5818-182c-47ab-b384-379659830d38@ti.com/
> 
>  drivers/remoteproc/rproc-uclass.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
> index 3ba2b40dca..e550292dda 100644
> --- a/drivers/remoteproc/rproc-uclass.c
> +++ b/drivers/remoteproc/rproc-uclass.c
> @@ -158,9 +158,15 @@ static int rproc_pre_probe(struct udevice *dev)
>  		uc_pdata->driver_plat_data = pdata->driver_plat_data;
>  	}
>  
> -	/* Else try using device Name */
> -	if (!uc_pdata->name)
> -		uc_pdata->name = dev->name;
> +	/* Else try using a combination of device Name and devices's parent's name */
> +	if (!uc_pdata->name) {
> +		int rproc_name_size = 256;

Instead of hardcoding 256 why not use
		buf = malloc(strlen(dev->name) + strlen(dev->parent->name) + 2);	// 1 for null and one for '-'

> +		char *buf;
> +
> +		buf = malloc(rproc_name_size);

need to check/error out for malloc failure.

> +		snprintf(buf, rproc_name_size, "%s-%s", dev->name, dev->parent->name);
> +		uc_pdata->name = buf;
> +	}
>  	if (!uc_pdata->name) {
>  		debug("Unnamed device!");
>  		return -EINVAL;

-- 
cheers,
-roger
