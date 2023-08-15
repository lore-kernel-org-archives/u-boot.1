Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0780BC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 19:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309C8867E2;
	Tue, 15 Aug 2023 21:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YDZQPfUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E79486940; Tue, 15 Aug 2023 21:55:49 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7F786785
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso34864385ad.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129344; x=1692734144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x6IbbAAWCqGP0nSCS5hSkmgptzVfRQI1JzIEU5FW2lc=;
 b=YDZQPfUWWjnhocQ6YNY5y7vbprDAsOppfi4ZzeqSXlu9MvrMq79bSdU1rW9AO682BW
 NHjCGMdV+IP7GULzEWI05Hn2MG8C78TTHx6Z1ntN0W1iofUHcwqgABF2OXAPkeFtUECo
 lhQmdmou5cMr7LpVO4+sjhi4/uo6VLJxjyiMGGAPXNe+0g1QUZM50GLy487JqX/7gkQ6
 joqAQ9uqWRNFi0GxnId9QOQDwZQmeV6HRlFbpvsMmA3GinvxJOXm6AYgWTdFG92XVEXf
 XXS+cB/oPJp6JH27csKnQ6r1vC/a5eVzRYBePnSTVG6Z3oG3kmcOYCxmFAvWcvvps+Ng
 K+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129344; x=1692734144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6IbbAAWCqGP0nSCS5hSkmgptzVfRQI1JzIEU5FW2lc=;
 b=Ay8tpVYuEO4JeN83Dx9sR5cY+iXfuUiPXCy8kEZNNTpRXUtALpgTU1TVcviDrjgUjV
 CJVSbTfF70ce4BSkRkYrPkCEQ9PrbeUgZZsev8sfZcNOxFAir8uABXpFU+5D2rHU45I2
 xgK9qRdHwSCnkVLYOM7d2OYPYCG6h15yTWQ0hZA1N1xZ3Ca0tt3EcRcdta82uOA0UV9D
 QgMgdUCE8W5HSwgLQ2JWGOiv07yKcpLybZU5M5DkImN8WtSQ5jBp5c6IOs2hmYSy2Gja
 /FCE9tDqf8kFNkjZAT1oBhoPJyQjjc2SXbivqbNVAiCihH/CvwWiZleMnP3Z4nXWh+Kq
 yOUg==
X-Gm-Message-State: AOJu0YwVuoNFAx/Qvkk9HhufdxzZsLeexTHaReiwsW/GCqgqFV3m5T+Q
 NA8oErubXrtgTaz+sySEwhURcw==
X-Google-Smtp-Source: AGHT+IHv2WgFKpy6HF8WCFX5O5DWWpa26AnX9xUdAnKIRbhc5wgNCdO9QD67jyTJiNAZBuks1BWfqw==
X-Received: by 2002:a17:902:b718:b0:1bc:6a89:86ba with SMTP id
 d24-20020a170902b71800b001bc6a8986bamr9016767pls.16.1692129344136; 
 Tue, 15 Aug 2023 12:55:44 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:6581:8508:2ecb:b5dd?
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170902e74500b001b9de2b905asm11416440plf.231.2023.08.15.12.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 12:55:43 -0700 (PDT)
Message-ID: <fd482da0-438f-c4b1-99c1-7b6d631e888e@linaro.org>
Date: Wed, 16 Aug 2023 01:25:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 6/6] ufs: Implement cache management
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-6-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230813235231.591454-6-marek.vasut+renesas@mailbox.org>
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

On 8/14/23 5:22 AM, Marek Vasut wrote:
> Add function to flush and invalidate cache over request and response
> queue entries, and perform flush and optional invalidate over block
> layer data that are passed into the UFS layer. This makes it possible
> to use UFS with caches enabled.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
>   drivers/ufs/ufs.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 041caee714f..7c48d57f99d 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -692,6 +692,21 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
>   	return (ufshcd_readl(hba, REG_CONTROLLER_STATUS) >> 8) & 0x7;
>   }
>   
> +/**
> + * ufshcd_cache_flush_and_invalidate - Flush and invalidate cache
> + *
> + * Flush and invalidate cache in aligned address..address+size range.
> + * The invalidation is in place to avoid stale data in cache.
> + */
> +static void ufshcd_cache_flush_and_invalidate(void *addr, unsigned long size)
> +{
> +	uintptr_t aaddr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	unsigned long asize = ALIGN(size, ARCH_DMA_MINALIGN);
> +
> +	flush_dcache_range(aaddr, aaddr + asize);
> +	invalidate_dcache_range(aaddr, aaddr + asize);
> +}
> +
>   /**
>    * ufshcd_prepare_req_desc_hdr() - Fills the requests header
>    * descriptor according to request
> @@ -735,6 +750,8 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
>   	req_desc->header.dword_3 = 0;
>   
>   	req_desc->prd_table_length = 0;
> +
> +	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
>   }
>   
>   static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
> @@ -763,10 +780,15 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
>   	memcpy(&ucd_req_ptr->qr, &query->request.upiu_req, QUERY_OSF_SIZE);
>   
>   	/* Copy the Descriptor */
> -	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC)
> +	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
>   		memcpy(ucd_req_ptr + 1, query->descriptor, len);
> +		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, 2 * sizeof(*ucd_req_ptr));
> +	} else {
> +		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
> +	}
>   
>   	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
> +	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
>   }
>   
>   static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
> @@ -783,6 +805,9 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
>   	ucd_req_ptr->header.dword_2 = 0;
>   
>   	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
> +
> +	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
> +	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
>   }
>   
>   /**
> @@ -1409,6 +1434,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufs_hba *hba,
>   	memcpy(ucd_req_ptr->sc.cdb, pccb->cmd, cdb_len);
>   
>   	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
> +	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
> +	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
>   }
>   
>   static inline void prepare_prdt_desc(struct ufshcd_sg_entry *entry,
> @@ -1423,6 +1450,7 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   {
>   	struct utp_transfer_req_desc *req_desc = hba->utrdl;
>   	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
> +	uintptr_t aaddr = (uintptr_t)(pccb->pdata) & ~(ARCH_DMA_MINALIGN - 1);
>   	ulong datalen = pccb->datalen;
>   	int table_length;
>   	u8 *buf;
> @@ -1430,9 +1458,19 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   
>   	if (!datalen) {
>   		req_desc->prd_table_length = 0;
> +		ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
>   		return;
>   	}
>   
> +	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
> +		flush_dcache_range(aaddr, aaddr +
> +				   ALIGN(datalen, ARCH_DMA_MINALIGN));
> +	}
> +
> +	/* In any case, invalidate cache to avoid stale data in it. */
> +	invalidate_dcache_range(aaddr, aaddr +
> +				ALIGN(datalen, ARCH_DMA_MINALIGN));
> +
>   	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
>   	buf = pccb->pdata;
>   	i = table_length;
> @@ -1446,6 +1484,8 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   	prepare_prdt_desc(&prd_table[table_length - i - 1], buf, datalen - 1);
>   
>   	req_desc->prd_table_length = table_length;
> +	ufshcd_cache_flush_and_invalidate(prd_table, sizeof(*prd_table) * table_length);
> +	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
>   }
>   
>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)

LGTM, so:
Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
