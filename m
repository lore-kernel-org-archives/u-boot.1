Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3387CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 16:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36AE2831C2;
	Wed, 27 Aug 2025 18:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u5ijnbVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA6F831C2; Wed, 27 Aug 2025 18:14:18 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72766831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 18:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RGEEqT1784546;
 Wed, 27 Aug 2025 11:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756311254;
 bh=v4m+ZhBvqNjniHPOXiQJ+Wcz7B0O/BbCjLigwPmU5NM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=u5ijnbVGxODo/mzpcZcT1g9o5fn33nLVjdyRpW4qLg8yteoXEmVihIlG1ET3sthpU
 w5omMMI9Od6vce8CULERUMuMt3JdK39gICIf7eEdz601aI4hYEcgZbSdoA5ra8ymhJ
 2oldUgXhPI8QVlPVPCwrFTsNdx9CDqsPpTVCjeR8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RGEDl12255679
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 27 Aug 2025 11:14:13 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 11:14:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 11:14:13 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.235.150])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RGECXj3355416;
 Wed, 27 Aug 2025 11:14:13 -0500
Date: Wed, 27 Aug 2025 21:44:11 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH v1 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
Message-ID: <20250827161411.whvffhrbx4k7axnv@prasanth-server>
References: <20250825133233.2475300-1-anshuld@ti.com>
 <20250825133233.2475300-2-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250825133233.2475300-2-anshuld@ti.com>
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

Hi Anshul,
On 19:02, Anshul Dalal wrote:
> With the change to dma_addr_t from u32 to u64 for the R5 SPL, the

From above line, Does this patch meant to after patch 2/2 ?

> existing typecasts from void* to int or vice-versa cause the compiler to
> throw a "cast from pointer to integer of different size".
> 
> Therefore this patch changes the casts to a uintptr_t which is
> guaranteed to hold any pointer value, thus supressing the compiler
> warning.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 723265ab2e5..01824310995 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2327,7 +2327,7 @@ static int udma_send(struct dma *dma, void *src, size_t len, void *metadata)
>  {
>  	struct udma_dev *ud = dev_get_priv(dma->dev);
>  	struct cppi5_host_desc_t *desc_tx;
> -	dma_addr_t dma_src = (dma_addr_t)src;
> +	dma_addr_t dma_src = (uintptr_t)src;

Considering after the dma_addr_t changed to u64, please help me understand what
warning does the above change fix.

Thanks,
Prasanth

>  	struct ti_udma_drv_packet_data packet_data = { 0 };
>  	dma_addr_t paddr;
>  	struct udma_chan *uc;
> @@ -2426,7 +2426,7 @@ static int udma_receive(struct dma *dma, void **dst, void *metadata)
>  
>  	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
>  
> -	*dst = (void *)buf_dma;
> +	*dst = (void *)(uintptr_t)buf_dma;
>  	uc->num_rx_bufs--;
>  
>  	return pkt_len;
> @@ -2518,7 +2518,7 @@ int udma_prepare_rcv_buf(struct dma *dma, void *dst, size_t size)
>  
>  	desc_num = uc->desc_rx_cur % UDMA_RX_DESC_NUM;
>  	desc_rx = uc->desc_rx + (desc_num * uc->config.hdesc_size);
> -	dma_dst = (dma_addr_t)dst;
> +	dma_dst = (uintptr_t)dst;
>  
>  	cppi5_hdesc_reset_hbdesc(desc_rx);
>  
> -- 
> 2.50.1
> 
