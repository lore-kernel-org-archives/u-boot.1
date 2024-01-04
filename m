Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB87C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 09:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7500A8792C;
	Thu,  4 Jan 2024 10:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="yMt6uhr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1478687930; Thu,  4 Jan 2024 10:04:52 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A14A878AD
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 10:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704359088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71Qqnd2wtZIXTrBDBp8sB9PiWH0gNBI9kYH8qs1y4ns=;
 b=yMt6uhr/btfN5h/IuHXJjfvM2zv9P0SyaU6Iadf+M98mhM83qWgZ//KbsnHcaAbl2Cnrg7
 qiNy0+5oQ5s6tnhihj84NIFNHATHdSKr6o5nEEgQwk7muwXih5Hwm3rJADgdvAGuQLYeK9
 R0i9h7boZgYEesOTPFywzH9F+CoRQQnUJ0z+diWCkI1I/Zl712TL/Nbjb32//n+THBB38K
 wEahWfOZMwRG4UVwca2Ae2fSFlc75eze9xnfBs9Y2Z+N44gYd7TdD9vaUJNWvgwPxWo6hv
 o60vBQJglTS+Je8swGp1X1W5i029BqvB/W+1wFComUaz1dH8Ba7yH0V6AjsXOQ==
Date: Thu, 04 Jan 2024 10:04:47 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 1/1] mmc: Avoid buffer overrun in mmc_startup()
In-Reply-To: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
References: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
Message-ID: <54a6014511f065c7419f98eda4795fd8@manjaro.org>
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

On 2024-01-04 04:49, Heinrich Schuchardt wrote:
> If the CSD register contains a reserved value (4 - 7) in bits 0:2 of 
> the
> TRAN_SPEED field, a buffer overrun occurs. Resize the mapping table.
> 
> According to the original report
> https://lore.kernel.org/u-boot/20180826231332.2491-11-erosca@de.adit-jv.com/
> reserved values have been observed resulting in a buffer overrun.
> 
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Fixes: 272cc70b211e ("Add MMC Framework")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/mmc/mmc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index d96db7a0f8..00f4964aae 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -1570,13 +1570,20 @@ static int sd_read_ssr(struct mmc *mmc)
>  	return 0;
>  }
>  #endif
> -/* frequency bases */
> -/* divided by 10 to be nice to platforms without floating point */
> +/*
> + * TRAN_SPEED bits 0:2 encode the frequency unit:
> + * 0 = 100KHz, 1 = 1MHz, 2 = 10MHz, 3 = 100MHz, values 4 - 7 are 
> reserved.
> + * The values in fbase[] are divided by 10 to avoid floats in 
> multiplier[].
> + */
>  static const int fbase[] = {
>  	10000,
>  	100000,
>  	1000000,
>  	10000000,
> +	0,	/* reserved */
> +	0,	/* reserved */
> +	0,	/* reserved */
> +	0,	/* reserved */
>  };

This makes me wonder what frequency unit(s) should actually be used when 
the reserved values are encountered?  What happens if zero is used in 
that case?  I had a brief look at drivers/mmc/mmc.c and using zeros 
doesn't seem like the best approach.

>  /* Multiplier values for TRAN_SPEED.  Multiplied by 10 to be nice
> @@ -2560,6 +2567,8 @@ static int mmc_startup(struct mmc *mmc)
>  	mult = multipliers[((cmd.response[0] >> 3) & 0xf)];
> 
>  	mmc->legacy_speed = freq * mult;
> +	if (!mmc->legacy_speed)
> +		log_debug("TRAN_SPEED: reserved value");
>  	mmc_select_mode(mmc, MMC_LEGACY);
> 
>  	mmc->dsr_imp = ((cmd.response[1] >> 12) & 0x1);
