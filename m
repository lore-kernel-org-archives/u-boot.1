Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDC2E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 06:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460DE80141;
	Fri, 13 Dec 2024 07:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f5/8//ip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92271801A0; Fri, 13 Dec 2024 07:05:03 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09196800D7
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 07:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BD64lIn3043721
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 00:04:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734069887;
 bh=8Ed6xlueyvM0lCtYAToG3V65+K6eItj8nVwgZBA3c/8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=f5/8//ip0Pj8auVa0izTQpCJeiJzm5QG+z1HPcnkJdFKN5omVYjuwY/mZzZIxzISe
 XwWn9+NfvqpiW+GMzGX+0xWceMxg82462XXEcDdMLz6r/Qf/W7rkgO9eGWQt1qZeIH
 dg4OOrEhQXveNL1+SIvhc5nfplBql7k5krBhan3k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BD64lHR011534
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 00:04:47 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 00:04:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 00:04:47 -0600
Received: from [10.24.72.152] (uda0132425.dhcp.ti.com [10.24.72.152])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BD64iBS069433;
 Fri, 13 Dec 2024 00:04:45 -0600
Message-ID: <4fb19397-0e3c-4717-9562-1befdf3b52cb@ti.com>
Date: Fri, 13 Dec 2024 11:34:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: fix potential malfunction after ~49
 days uptime
To: Ronald Wahl <rwahl@gmx.de>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>
CC: Ronald Wahl <ronald.wahl@legrand.com>, Pratyush Yadav <p.yadav@ti.com>
References: <20241211205104.16099-1-rwahl@gmx.de>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20241211205104.16099-1-rwahl@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

+ tom and jagan

On 12/12/24 02:21, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@legrand.com>
> 
> The get_timer function returns an unsigned long which may be calculated
> from the ARM system counter. This counter is reset only on a cold reset.
> U-boot divides this counter down to a 1000 Hz counter that will cross
> the 32bit barrier after a bit more than 49 days. Assigning the value to
> an unsigned int will truncate it on 64bit systems.
> Passing this truncated value back to the get_timer function will return
> a very large value that is certainly larger than the timeout and so will
> go down the error path and besides stopping U-Boot will lead to messages
> like
> 
>     "SPI: QSPI is still busy after poll for 5000 ms."

Thanks a lot for fixing this!

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


> 
> Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/cadence_qspi_apb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 93ab2b5635..f2f69cf9f1 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -151,9 +151,9 @@ static int cadence_qspi_set_protocol(struct cadence_spi_priv *priv,
>  /* Return 1 if idle, otherwise return 0 (busy). */
>  static unsigned int cadence_qspi_wait_idle(void *reg_base)
>  {
> -	unsigned int start, count = 0;
> +	unsigned long start, count = 0;
>  	/* timeout in unit of ms */
> -	unsigned int timeout = 5000;
> +	unsigned long timeout = 5000;
> 
>  	start = get_timer(0);
>  	for ( ; get_timer(start) < timeout ; ) {
> @@ -170,7 +170,7 @@ static unsigned int cadence_qspi_wait_idle(void *reg_base)
>  	}
> 
>  	/* Timeout, still in busy mode. */
> -	printf("QSPI: QSPI is still busy after poll for %d ms.\n", timeout);
> +	printf("QSPI: QSPI is still busy after poll for %lu ms.\n", timeout);
>  	return 0;
>  }
> 
> --
> 2.47.1
> 

-- 
Regards
Vignesh
https://ti.com/opensource

