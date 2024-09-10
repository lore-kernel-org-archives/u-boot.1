Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDA3ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D8489016;
	Tue, 10 Sep 2024 13:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eNxAuGfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D6389041; Tue, 10 Sep 2024 13:27:24 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E81388F5E
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48ABRGxi125890;
 Tue, 10 Sep 2024 06:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725967636;
 bh=QC+EsvyA/ODFBwpyc2ZF73EWqWZQHqIPvXdjDlNQx6o=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=eNxAuGfk5KHO88VMrvJhdzUuHsaK/FoXK1pmoOStLxGA+OIn/VbVBzO+KQk9x/s49
 U3chahA2MQzf6ehMjnutt41Gmc09sLo2eo0hLvtDScTtiYctjpxVPA1TcNzrPipTiX
 s2JMM9oujkBRaYmu/9cUiwOHcLCg9Bhf/+J3qpZc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48ABRGbn005591
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 06:27:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 06:27:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 06:27:16 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ABRELc061555;
 Tue, 10 Sep 2024 06:27:14 -0500
Message-ID: <6d9eb1c8-9f0d-4007-a079-e5c4c6d7d794@ti.com>
Date: Tue, 10 Sep 2024 16:57:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] ufs: split flush and invalidate to only invalidate
 when required
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-3-3ee0bffacc64@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-3-3ee0bffacc64@linaro.org>
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
> There is no need to flush and invalidate all data updated by the
> driver, mainly because on ARM platforms flush also invalidates
> the cachelines.
> 
> Split the function in two and add the appropriate cacheline
> invalidates after the UFS DMA operation finishes to make sure
> we read from memory.
> 
> Flushing then invalidating cacheline unaligned data causes data
> corruption issues on Qualcomm platforms, and is largely unnecessary
> anyway, so let's cleanup the cache operations.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 45 ++++++++++++++++++++++++++++++---------------
>   1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 3d9a7d7ee12..5845fd694d3 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -696,17 +696,28 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
>   }
>   
>   /**
> - * ufshcd_cache_flush_and_invalidate - Flush and invalidate cache
> + * ufshcd_cache_flush - Flush cache
>    *
> - * Flush and invalidate cache in aligned address..address+size range.
> - * The invalidation is in place to avoid stale data in cache.
> + * Flush cache in aligned address..address+size range.
>    */
> -static void ufshcd_cache_flush_and_invalidate(void *addr, unsigned long size)
> +static void ufshcd_cache_flush(void *addr, unsigned long size)
>   {
>   	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>   	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
>   
>   	flush_dcache_range(start_addr, end_addr);
> +}
> +
> +/**
> + * ufshcd_cache_invalidate - Invalidate cache
> + *
> + * Invalidate cache in aligned address..address+size range.
> + */
> +static void ufshcd_cache_invalidate(void *addr, unsigned long size)
> +{
> +	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
> +
>   	invalidate_dcache_range(start_addr, end_addr);
>   }
>   
> @@ -754,7 +765,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
>   
>   	req_desc->prd_table_length = 0;
>   
> -	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
> +	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>   }
>   
>   static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
> @@ -785,13 +796,13 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
>   	/* Copy the Descriptor */
>   	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
>   		memcpy(ucd_req_ptr + 1, query->descriptor, len);
> -		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, 2 * sizeof(*ucd_req_ptr));
> +		ufshcd_cache_flush(ucd_req_ptr, 2 * sizeof(*ucd_req_ptr));
>   	} else {
> -		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
> +		ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
>   	}
>   
>   	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
> -	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
> +	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
>   }
>   
>   static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
> @@ -809,8 +820,8 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
>   
>   	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
>   
> -	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
> -	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
> +	ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
> +	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
>   }
>   
>   /**
> @@ -877,6 +888,8 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>    */
>   static inline int ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
>   {
> +	ufshcd_cache_invalidate(ucd_rsp_ptr, sizeof(*ucd_rsp_ptr));
> +
>   	return be32_to_cpu(ucd_rsp_ptr->header.dword_0) >> 24;
>   }
>   
> @@ -888,6 +901,8 @@ static inline int ufshcd_get_tr_ocs(struct ufs_hba *hba)
>   {
>   	struct utp_transfer_req_desc *req_desc = hba->utrdl;
>   
> +	ufshcd_cache_invalidate(req_desc, sizeof(*req_desc));
> +
>   	return le32_to_cpu(req_desc->header.dword_2) & MASK_OCS;
>   }
>   
> @@ -1437,8 +1452,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufs_hba *hba,
>   	memcpy(ucd_req_ptr->sc.cdb, pccb->cmd, cdb_len);
>   
>   	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
> -	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
> -	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
> +	ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
> +	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
>   }
>   
>   static inline void prepare_prdt_desc(struct ufshcd_sg_entry *entry,
> @@ -1461,7 +1476,7 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   
>   	if (!datalen) {
>   		req_desc->prd_table_length = 0;
> -		ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
> +		ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>   		return;
>   	}
>   
> @@ -1487,8 +1502,8 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   	prepare_prdt_desc(&prd_table[table_length - i - 1], buf, datalen - 1);
>   
>   	req_desc->prd_table_length = table_length;
> -	ufshcd_cache_flush_and_invalidate(prd_table, sizeof(*prd_table) * table_length);
> -	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
> +	ufshcd_cache_flush(prd_table, sizeof(*prd_table) * table_length);
> +	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>   }
>   
>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
