Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4877EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131D089016;
	Tue, 10 Sep 2024 13:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fetmrs8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A471D89039; Tue, 10 Sep 2024 13:14:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1632388F63
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48ABE9sx123379;
 Tue, 10 Sep 2024 06:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725966849;
 bh=MqmkLRfrriQHie+nPEPR5fKH12d7eLgVmdTzlz8Mrgw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fetmrs8ote4pMEaybprAxK7LzuUBmM+bOIAZ5lHy5MWHgX0bechlnrS1jNgMwqJA3
 0BnSjIl9hmGhhtdZ8m0sm2z39sVU9mWIR+b0QH5viAys+aCvqcFYsMLgZYMUT7CXkv
 lbuL+5IyD17rcEj22XMFbM1W7T9C8Kjjy9JNK9Jw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48ABE9hA094351
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 06:14:09 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 06:14:09 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 10 Sep
 2024 06:14:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 06:14:08 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ABE6LU090186;
 Tue, 10 Sep 2024 06:14:07 -0500
Message-ID: <e35541ac-734f-4b86-9974-10fd602f2b52@ti.com>
Date: Tue, 10 Sep 2024 16:44:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] ufs: fix dcache flush and invalidate range
 calculation
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-2-3ee0bffacc64@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-2-3ee0bffacc64@linaro.org>
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

On 10/09/24 14:50, Neil Armstrong wrote:
> The current calculation will omit doing a flush/invalidate on the last
> cacheline if the base address is not aligned with DMA_MINALIGN.
> 
> This causes commands failures and write corruptions on Qualcomm
> platforms.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index e005cc90608..3d9a7d7ee12 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -703,11 +703,11 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
>    */
>   static void ufshcd_cache_flush_and_invalidate(void *addr, unsigned long size)
>   {
> -	uintptr_t aaddr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> -	unsigned long asize = ALIGN(size, ARCH_DMA_MINALIGN);
> +	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
>   
> -	flush_dcache_range(aaddr, aaddr + asize);
> -	invalidate_dcache_range(aaddr, aaddr + asize);
> +	flush_dcache_range(start_addr, end_addr);
> +	invalidate_dcache_range(start_addr, end_addr);
>   }
>   
>   /**
> @@ -1466,13 +1466,13 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   	}
>   
>   	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
> -		flush_dcache_range(aaddr, aaddr +
> -				   ALIGN(datalen, ARCH_DMA_MINALIGN));
> +		flush_dcache_range(aaddr,
> +				   ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
>   	}
>   
>   	/* In any case, invalidate cache to avoid stale data in it. */
> -	invalidate_dcache_range(aaddr, aaddr +
> -				ALIGN(datalen, ARCH_DMA_MINALIGN));
> +	invalidate_dcache_range(aaddr,
> +				ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
>   
>   	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
>   	buf = pccb->pdata;
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
