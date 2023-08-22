Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690B0EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E470A87245;
	Tue, 22 Aug 2023 06:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lXCDJjoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDFE487110; Tue, 22 Aug 2023 06:10:27 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE0D8687F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a3236a414so2022720b3a.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692677423; x=1693282223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vv1j2/FNtcg2xf5psUYbt3OTbk++ESjT6DtqZu9sAjg=;
 b=lXCDJjoyxjxty0RMdxpFnjUZ7fbIqzQbBMMj2kH76ctmAl3V0+K1t4j5273VPqy8nW
 beUktCXUtrExjjXN7/BA3y82YBBYoRAJenGNbsQw3df2PcX6dJBbRC3+minaRUv5sCnE
 ln7l/AI5HKeas2elDMKr0NlaheHLzAP6i3YlI0B3mhbK7nlkgFm8XeNHG2PRkYiEKtsd
 rvN/2B8UdlFOkzceVzm7JDaAkP15pQ1DDe9eROkdNRVL+cO7jYC9s+ClaVVMMk7GYesN
 XhJupfFQHutDo4v6RdIAQ83SaO/RlOJpVbBiRhccSz0+hTUHJQXOjze17lnYYAgKPazC
 L+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692677423; x=1693282223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vv1j2/FNtcg2xf5psUYbt3OTbk++ESjT6DtqZu9sAjg=;
 b=bJ2rLeObwHAtj+9qkUzschkWrLsGX0Xrr4mVfliDiAThECO1oTIFb0As1IOzgwAlhs
 CtS+r6JxoRsPUeFJJDEtwn8sIF6M/t+hk64pT+t/9RNDSbRyAaUSugBGydfxYcuphzlY
 PNBhxIa6TNnzOmyynLhymlu/3yD7FW+YsdcCNlm40IsYuYnHicRHleCdZFXA5x9asu7U
 DpZw49vjEB+WXFyNfef5M0WBvU4LukaLeyj8e3O1ExQ4m3E+TlwOWhtbljrWmgjbKwyn
 ifXB2CA3ggFhdFYRJER298KBiSmEayfpTaXol0e/b4MLrTZ6Mn0AAqFgJZAvNXnsO0Lh
 LQXA==
X-Gm-Message-State: AOJu0YyeDuo3o/sJ590/P4x8DuwNvJhHUxNARMEJGHga6Oe4yUbkZzr6
 jrG+8oKCgk3XCBodZzz5qYFf5Q==
X-Google-Smtp-Source: AGHT+IFeG+Xdk5HvWszHMjKWN5S7vXGYO3ZCjbO9hHlShTMg4dkusvLt4FMODz9JaiHerVNLNbTPIA==
X-Received: by 2002:a05:6a20:3d81:b0:12f:382d:2a37 with SMTP id
 s1-20020a056a203d8100b0012f382d2a37mr12032637pzi.15.1692677423308; 
 Mon, 21 Aug 2023 21:10:23 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 fe10-20020a056a002f0a00b006889348ba6asm2013939pfb.81.2023.08.21.21.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:10:23 -0700 (PDT)
Message-ID: <3f6e0cbc-bf04-b22d-68aa-614430e4a16a@linaro.org>
Date: Tue, 22 Aug 2023 09:40:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 7/7] ufs: Implement cache management
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
 <20230816150555.245028-7-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-7-marek.vasut+renesas@mailbox.org>
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

On 8/16/23 8:35 PM, Marek Vasut wrote:
> Add function to flush and invalidate cache over request and response
> queue entries, and perform flush and optional invalidate over block
> layer data that are passed into the UFS layer. This makes it possible
> to use UFS with caches enabled.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: No change
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

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
