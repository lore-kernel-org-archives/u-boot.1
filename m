Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2364ACA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 09:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439B183071;
	Tue, 26 Aug 2025 11:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="0ldz4nix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A33B830A0; Tue, 26 Aug 2025 11:44:35 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA9282FC7
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 11:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0333e70c0e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q7MVEH008503;
 Tue, 26 Aug 2025 11:44:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 mADqJ0jHw8uJITS+uZuuKwEJdws4Vx+x6UeQF2P/csM=; b=0ldz4nixUsjTo6z7
 xPyNNi3VG/yQG7joTCFQ6bDWC+3hLJ7jLpiMdUEvYxES211ai3X1z3Hyue5dsk6f
 YhswjTxUaLnjOOHyrIffsf/BKbDRBErXsXsL/Vbd1ql62MxkqUy2hxt2vHSaCIgO
 wrNGdfaMwJN82hgiEqUIdizj8uW7V7mn1v/7XqUUYG71lUrcnx3fNIFbnQ0Oodsa
 NzPFRWUJYvqW9pI5OjEAywyeqMTR8SwpowviDt+6G+0XapX0jPq3qK+J1Sj0QnZy
 afbBcbC5oH+vwv+ml+IJbRYh8QJ0XVwAnM49Giq2osslaSBLiI+Q3TnbpeK41w2Q
 x0VHyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5tstp5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 11:44:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B536E4004A;
 Tue, 26 Aug 2025 11:43:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 955D6512666;
 Tue, 26 Aug 2025 11:42:52 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 11:42:52 +0200
Message-ID: <69cf7b5d-f0b0-4676-b6d5-2faf9da7d3c3@foss.st.com>
Date: Tue, 26 Aug 2025 11:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: stm32_sdmmc2: avoid infinite while loop
To: Christophe Kerello <christophe.kerello@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20250812135526.268574-1-christophe.kerello@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250812135526.268574-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
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



On 8/12/25 15:55, Christophe Kerello wrote:
> Avoid unlimited while loop by adding a timeout. The timeout is
> calculated based on a minimal throughput of 256 KB/s.
> The timeout is set at least to 2 seconds.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
> 
>  drivers/mmc/stm32_sdmmc2.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
> index 9483fb57daf..122690aef3e 100644
> --- a/drivers/mmc/stm32_sdmmc2.c
> +++ b/drivers/mmc/stm32_sdmmc2.c
> @@ -385,15 +385,29 @@ static int stm32_sdmmc2_end_data(struct udevice *dev,
>  	u32 mask = SDMMC_STA_DCRCFAIL | SDMMC_STA_DTIMEOUT |
>  		   SDMMC_STA_IDMATE | SDMMC_STA_DATAEND;
>  	u32 status;
> +	unsigned long timeout_msecs = ctx->data_length >> 8;
> +	unsigned long start_timeout;
> +
> +	/* At least, a timeout of 2 seconds is set */
> +	if (timeout_msecs < 2000)
> +		timeout_msecs = 2000;
>  
>  	if (data->flags & MMC_DATA_READ)
>  		mask |= SDMMC_STA_RXOVERR;
>  	else
>  		mask |= SDMMC_STA_TXUNDERR;
>  
> +	start_timeout = get_timer(0);
>  	status = readl(plat->base + SDMMC_STA);
> -	while (!(status & mask))
> +	while (!(status & mask)) {
> +		if (get_timer(start_timeout) > timeout_msecs) {
> +			ctx->dpsm_abort = true;
> +			return -ETIMEDOUT;
> +		}
> +
> +		schedule();
>  		status = readl(plat->base + SDMMC_STA);
> +	}
>  
>  	/*
>  	 * Need invalidate the dcache again to avoid any


Applied to u-boot-stm32/master

Thanks
Patrice
