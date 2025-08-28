Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E8CC8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 08:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D494831D5;
	Thu, 28 Aug 2025 10:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AY0Di2YM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377148328F; Thu, 28 Aug 2025 10:50:08 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79897831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S8o3oN1945025;
 Thu, 28 Aug 2025 03:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756371003;
 bh=cERVBiLDMKiAsHHOJzlEio8D9kN2dGhQRa1SGb0kw+4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AY0Di2YMT5dvalhtAax2KkPoK/yDUCY9espFOC5/hFPtaB1aPZSF2AkrycGIbSGTM
 NPHvuqlFpxYptVoOMm0Awvr4nojA6kwrVd1FdBkk30URlYXlqDBm57DRQfcd14YFUy
 HxBlYCbAFlD9TkAzmSayQzPVU7yis7ouszBQb0Lg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S8o36B3344269
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 03:50:03 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 03:50:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 03:50:02 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S8o021066987;
 Thu, 28 Aug 2025 03:50:01 -0500
Message-ID: <a20eaf48-6ff9-4b83-bd10-a8a99c9ace14@ti.com>
Date: Thu, 28 Aug 2025 14:20:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>
References: <20250825133233.2475300-1-anshuld@ti.com>
 <20250825133233.2475300-2-anshuld@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250825133233.2475300-2-anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 8/25/2025 7:02 PM, Anshul Dalal wrote:
> With the change to dma_addr_t from u32 to u64 for the R5 SPL, the
> existing typecasts from void* to int or vice-versa cause the compiler to
> throw a "cast from pointer to integer of different size".

is this some compiler specific ?. Please mention that

I don't see this warning 
https://gist.github.com/uditkumarti/1c4238a7101d97cdc57b7a40d10147d2

I am on  gcc version 11.3.1 20220712 (Arm GNU Toolchain 11.3.Rel1)


> Therefore this patch changes the casts to a uintptr_t which is
> guaranteed to hold any pointer value, thus supressing the compiler
> warning.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 723265ab2e5..01824310995 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2327,7 +2327,7 @@ static int udma_send(struct dma *dma, void *src, size_t len, void *metadata)
>   {
>   	struct udma_dev *ud = dev_get_priv(dma->dev);
>   	struct cppi5_host_desc_t *desc_tx;
> -	dma_addr_t dma_src = (dma_addr_t)src;
> +	dma_addr_t dma_src = (uintptr_t)src;
>   	struct ti_udma_drv_packet_data packet_data = { 0 };
>   	dma_addr_t paddr;
>   	struct udma_chan *uc;
> @@ -2426,7 +2426,7 @@ static int udma_receive(struct dma *dma, void **dst, void *metadata)
>   
>   	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
>   
> -	*dst = (void *)buf_dma;
> +	*dst = (void *)(uintptr_t)buf_dma;
>   	uc->num_rx_bufs--;
>   
>   	return pkt_len;
> @@ -2518,7 +2518,7 @@ int udma_prepare_rcv_buf(struct dma *dma, void *dst, size_t size)
>   
>   	desc_num = uc->desc_rx_cur % UDMA_RX_DESC_NUM;
>   	desc_rx = uc->desc_rx + (desc_num * uc->config.hdesc_size);
> -	dma_dst = (dma_addr_t)dst;
> +	dma_dst = (uintptr_t)dst;
>   
>   	cppi5_hdesc_reset_hbdesc(desc_rx);
>   
