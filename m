Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFCAC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 458F2886AA;
	Sat, 20 Jul 2024 17:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4j061S2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119DB886B3; Sat, 20 Jul 2024 17:44:06 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43B188618
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-44d1eb90522so10962131cf.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721490243; x=1722095043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6uliTaPz3TOpnpLbR18Rd/Y8Rt5NbDZ/BMa18oX4V0=;
 b=S4j061S22icf9H3Xyq6v8BVIUzr/50RKTQj6t/NOhFv4XboNo0uObLCZ4Pl9M8RQL3
 nbect0MRwnPHICj4QQU01jzJzam7pf8a1Quh6HP0nrZpa92FTpBGgw/a1bEroMOVtWu+
 pzgvkzT2EmkgclZIavsayZSchkVvwJNESf3z0yJsgRE2OrCzRAvYT7w+xCP2SqbuOxOF
 gv53QbnwluTBYXB2WnDgvxnpPImlILtV4S2nrEJy38ixeUA8kbN3vHL9RbZHQWDwFeP8
 PpjgQy+yw+BuEf0n9HkHPjdgmIkw+kd8ixtm0WCr79lre8K37W/IIR0naRlM++mdfNKv
 TBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721490243; x=1722095043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6uliTaPz3TOpnpLbR18Rd/Y8Rt5NbDZ/BMa18oX4V0=;
 b=FYSMM+I8RubLzStrNUcvn9kXC6x4WI5cG7gBiHN2yy6hQxHYeBGtGsMX5VqV9RnG22
 hIyr47CWVfaw3snVYLi7BlOy5w7ELjVmBJmGKmzxRvqaJFbjn6O3rwwqCD6Zsl94zu1N
 Lu/N/MxhXB0qDCPKpqc5SoXiH4ls8mRXIrdKxqG/7EWViK96HKnU5/bvHPFERa3i0aOi
 xnDw0jvydHh3+As+sYazIhWobkTR/a8fPuVE4WOKjlGeWqc7raPwhe//TgUZYO7ZYIwn
 n0b37pW9xuAAuZ2PVEE2wplYvq2K6wx2RV1Netm0L1z0k/zb+Na+NcJfgmk7/sm4VDkE
 u6eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ifV+BoabHrfIlppQ4JrUHGoZKue7Jvw8SOhLc/vm6iqsivuve/Z3XXpTekLpJ9aLXgoEt+piOEoAKjOSy6FAYhA/xw==
X-Gm-Message-State: AOJu0YxCHTWpEFtOAeGXpp7bcxtlBCQZ8hZ6BxGRo5HIRCId8kwbcly4
 ebIM/xxy+tL/Hj0XETyZlBfY4QoyPNw7mujP97mD1DQiFexf4CX0
X-Google-Smtp-Source: AGHT+IHdtDjnpqIrl/S2HZrAKHZlJo9ONIFpXkMkrQ51uNsHOiAqi+ZdqlwXCez/GlfhVs1IT+NmCA==
X-Received: by 2002:a05:622a:1344:b0:446:5764:3c9f with SMTP id
 d75a77b69052e-44fa52824bemr36611461cf.22.1721490242497; 
 Sat, 20 Jul 2024 08:44:02 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9e3b62e8sm16818471cf.74.2024.07.20.08.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:44:02 -0700 (PDT)
Message-ID: <5178a74c-05ff-4b91-443c-3bab888d764a@gmail.com>
Date: Sat, 20 Jul 2024 11:44:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/14] mmc: Use logging instead of printf()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <sean.anderson@seco.com>,
 Tom Rini <trini@konsulko.com>, cmachida <curtis.machida@intel.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-6-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/20/24 02:16, Simon Glass wrote:
> The code makes quite a few uses of __func__ which puts the function
> name into the resulting SPL image. Use the log subsystem instead, to
> reduce size.
> 
> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   drivers/mmc/sdhci.c | 46 +++++++++++++++++++--------------------------
>   1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 560b7e889c7..24998233543 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>   	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>   	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>   		if (timeout == 0) {
> -			printf("%s: Reset 0x%x never completed.\n",
> -			       __func__, (int)mask);
> +			log_warning("Reset %x never completed\n", (int)mask);

I think this cast can be removed too

>   			return;
>   		}
>   		timeout--;
> @@ -139,8 +138,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
>   	do {
>   		stat = sdhci_readl(host, SDHCI_INT_STATUS);
>   		if (stat & SDHCI_INT_ERROR) {
> -			pr_debug("%s: Error detected in status(0x%X)!\n",
> -				 __func__, stat);
> +			log_debug("Error detected in status(%x)!\n", stat);
>   			return -EIO;
>   		}
>   		if (!transfer_done && (stat & rdy)) {
> @@ -173,7 +171,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
>   		if (timeout-- > 0)
>   			udelay(10);
>   		else {
> -			printf("%s: Transfer data timeout\n", __func__);
> +			log_err("Transfer data timeout\n");
>   			return -ETIMEDOUT;
>   		}
>   	} while (!(stat & SDHCI_INT_DATA_END));
> @@ -232,7 +230,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>   
>   	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
>   		if (time >= cmd_timeout) {
> -			printf("%s: MMC: %d busy ", __func__, mmc_dev);
> +			log_warning("MMC: %d busy ", mmc_dev);

Maybe this should be "mmc%d busy\n"

>   			if (2 * cmd_timeout <= SDHCI_CMD_MAX_TIMEOUT) {
>   				cmd_timeout += cmd_timeout;
>   				printf("timeout increasing to: %u ms.\n",
> @@ -316,8 +314,8 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>   		}
>   
>   		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> -			printf("%s: Timeout for status update: %08x %08x\n",
> -			       __func__, stat, mask);
> +			log_warning("Timeout for status update: %08x %08x\n",
> +				    stat, mask);
>   			return -ETIMEDOUT;
>   		}
>   	} while ((stat & mask) != mask);
> @@ -358,7 +356,7 @@ static int sdhci_execute_tuning(struct udevice *dev, uint opcode)
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
>   	struct sdhci_host *host = mmc->priv;
>   
> -	debug("%s\n", __func__);
> +	log_debug("tuning\n");

I think this one should be left as-is. Or at least given something more descriptive.

>   
>   	if (host->ops && host->ops->platform_execute_tuning) {
>   		err = host->ops->platform_execute_tuning(mmc, opcode);
> @@ -380,8 +378,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	while (sdhci_readl(host, SDHCI_PRESENT_STATE) &
>   			   (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
>   		if (timeout == 0) {
> -			printf("%s: Timeout to wait cmd & data inhibit\n",
> -			       __func__);
> +			log_err("Timeout to wait cmd & data inhibit\n");

Might as well fix the grammar while we're at it

log_err("Timeout waiting for cmd & data inhibit\n");

>   			return -EBUSY;
>   		}
>   
> @@ -397,7 +394,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	if (host->ops && host->ops->set_delay) {
>   		ret = host->ops->set_delay(host);
>   		if (ret) {
> -			printf("%s: Error while setting tap delay\n", __func__);
> +			log_err("Error while setting tap delay\n");
>   			return ret;
>   		}
>   	}
> @@ -405,7 +402,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	if (host->ops && host->ops->config_dll) {
>   		ret = host->ops->config_dll(host, clock, false);
>   		if (ret) {
> -			printf("%s: Error while configuring dll\n", __func__);
> +			log_err("Error configuring dll\n");

To distinguish these, can we say "Error while disabling dll"

>   			return ret;
>   		}
>   	}
> @@ -456,7 +453,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	if (host->ops && host->ops->config_dll) {
>   		ret = host->ops->config_dll(host, clock, true);
>   		if (ret) {
> -			printf("%s: Error while configuring dll\n", __func__);
> +			log_err("Error configuring dll\n");

and "Error while enabling dll"

I know this grows .data a bit...

>   			return ret;
>   		}
>   	}
> @@ -472,8 +469,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>   		& SDHCI_CLOCK_INT_STABLE)) {
>   		if (timeout == 0) {
> -			printf("%s: Internal clock never stabilised.\n",
> -			       __func__);
> +			log_err("Internal clock never stabilised.\n");
>   			return -EBUSY;
>   		}
>   		timeout--;
> @@ -738,8 +734,7 @@ static int sdhci_init(struct mmc *mmc)
>   	if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) {
>   		host->align_buffer = memalign(8, 512 * 1024);
>   		if (!host->align_buffer) {
> -			printf("%s: Aligned buffer alloc failed!!!\n",
> -			       __func__);
> +			log_err("Aligned buffer alloc failed\n");
>   			return -ENOMEM;
>   		}
>   	}
> @@ -881,20 +876,18 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>   #else
>   	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>   #endif
> -	debug("%s, caps: 0x%x\n", __func__, caps);
> +	log_debug("caps: 0x%x\n", caps);
>   
>   #if CONFIG_IS_ENABLED(MMC_SDHCI_SDMA)
>   	if ((caps & SDHCI_CAN_DO_SDMA)) {
>   		host->flags |= USE_SDMA;
>   	} else {
> -		debug("%s: Your controller doesn't support SDMA!!\n",
> -		      __func__);
> +		log_debug("Controller doesn't support SDMA\n");
>   	}
>   #endif
>   #if CONFIG_IS_ENABLED(MMC_SDHCI_ADMA)
>   	if (!(caps & SDHCI_CAN_DO_ADMA2)) {
> -		printf("%s: Your controller doesn't support ADMA!!\n",
> -		       __func__);
> +		log_err("Controller doesn't support ADMA\n");
>   		return -EINVAL;
>   	}
>   	if (!host->adma_desc_table) {
> @@ -927,7 +920,7 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>   #else
>   		caps_1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>   #endif
> -		debug("%s, caps_1: 0x%x\n", __func__, caps_1);
> +		log_debug("caps_1: %x\n", caps_1);
>   		host->clk_mul = (caps_1 & SDHCI_CLOCK_MUL_MASK) >>
>   				SDHCI_CLOCK_MUL_SHIFT;
>   
> @@ -953,8 +946,7 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>   			host->max_clk *= host->clk_mul;
>   	}
>   	if (host->max_clk == 0) {
> -		printf("%s: Hardware doesn't specify base clock frequency\n",
> -		       __func__);
> +		log_err("Hardware doesn't specify base clock frequency\n");
>   		return -EINVAL;
>   	}
>   	if (f_max && (f_max < host->max_clk))
> @@ -1047,7 +1039,7 @@ int add_sdhci(struct sdhci_host *host, u32 f_max, u32 f_min)
>   
>   	host->mmc = mmc_create(&host->cfg, host);
>   	if (host->mmc == NULL) {
> -		printf("%s: mmc create fail!\n", __func__);
> +		log_err("mmc create fail\n");
>   		return -ENOMEM;
>   	}
>   

