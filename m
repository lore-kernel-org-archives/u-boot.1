Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786E4C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 13:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFFF388859;
	Fri,  9 Aug 2024 15:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="acb3gmDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC3888A2F; Fri,  9 Aug 2024 15:14:52 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444ED8871E
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 15:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479DEejl100936;
 Fri, 9 Aug 2024 08:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723209280;
 bh=TpmNbuaMHnKygs2oiI+4+uUCBXyNZuPCE4HddIU9JkE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=acb3gmDtr9Kdkmh7KnT6eK6AZWkNn3YjMDtSk9PCkxq6zRuSzytcZeMUQfR4Z8YXE
 PiVytT1ASBkAH/klTO51MrLFGia6ugXg2eFRFuIp9Qg4Y5yRhBovBJZFSivbSph3TZ
 +kqEs5uj7pw2lOTlZItccU2/3s2SJAhYl43giyQc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479DEeOF033862
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Aug 2024 08:14:40 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 08:14:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 08:14:40 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479DEdpE086040;
 Fri, 9 Aug 2024 08:14:39 -0500
Message-ID: <51385cfa-1d73-4365-90be-2a46010b15ea@ti.com>
Date: Fri, 9 Aug 2024 08:14:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remoteproc: uclass: Modify uc_pdata->name to use
 combination of device name and device's parent name
To: MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Roger Quadros <rogerq@kernel.org>, "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240807090829.530865-1-danishanwar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240807090829.530865-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 8/7/24 4:08 AM, MD Danish Anwar wrote:
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

Reviewed-by: Andrew Davis <afd@ti.com>

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
> pru0_0 uc->pdata->name = "pru@34000-icssg@30000000"
> pru1_0 uc->pdata->name = "pru@34000-icssg@30080000"
> 
> Both the names are unique, thus rproc_init() succeeds.
> 
> Changes since v1:
> *) Instead of hardcoding rproc_name_size to 256, changed it to be equal to
>     strlen(dev->name) + strlen(dev->parent->name) + 2 as suggested by
>     Roger Quadros <rogerq@kernel.org>
>   *) Added check for malloc failure as suggested by Roger Quadros <rogerq@kernel.org>
> 
> [v1] https://lore.kernel.org/all/20240719085908.3564171-1-danishanwar@ti.com/
> [1] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
> [2] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
> [3] https://lore.kernel.org/all/5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com/
> [4] https://lore.kernel.org/all/e48f5818-182c-47ab-b384-379659830d38@ti.com/
> 
>   drivers/remoteproc/rproc-uclass.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
> index e64354dd52..3233ff8041 100644
> --- a/drivers/remoteproc/rproc-uclass.c
> +++ b/drivers/remoteproc/rproc-uclass.c
> @@ -158,9 +158,19 @@ static int rproc_pre_probe(struct udevice *dev)
>   		uc_pdata->driver_plat_data = pdata->driver_plat_data;
>   	}
>   
> -	/* Else try using device Name */
> -	if (!uc_pdata->name)
> -		uc_pdata->name = dev->name;
> +	/* Else try using a combination of device Name and devices's parent's name */
> +	if (!uc_pdata->name) {
> +		/* 2 in the rproc_name_size indicates 1 for null and one for '-' */
> +		int rproc_name_size = strlen(dev->name) + strlen(dev->parent->name) + 2;
> +		char *buf;
> +
> +		buf = malloc(rproc_name_size);
> +		if (!buf)
> +			return -ENOMEM;
> +
> +		snprintf(buf, rproc_name_size, "%s-%s", dev->name, dev->parent->name);
> +		uc_pdata->name = buf;
> +	}
>   	if (!uc_pdata->name) {
>   		debug("Unnamed device!");
>   		return -EINVAL;
> 
> base-commit: 6f4c31c2b658358628b5b0fa801f55c7477c7585
