Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84056ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 11:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB3A38902A;
	Tue, 10 Sep 2024 13:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XEg03Zh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5818903F; Tue, 10 Sep 2024 13:33:49 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3915289016
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 13:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48ABXeX0075547;
 Tue, 10 Sep 2024 06:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725968020;
 bh=kAy/XxpssIsCuxmp9yfsu9ZYsHnSTzwoNn/Z+GEONQI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=XEg03Zh3X9UKTDMJ+7U0y9imF9i8G0UkzmRGB4JvqBXQvzHsYwTM62d77LcoMor6n
 Odq95vntFtO9MWY7zDWgdzvtnVsOV7WF1Gzb73no+EPEkzde7LGdJcyXxTmiavBpWj
 nUCasPwrqrsHZin+DRqGRTtqBwXn/q9Kfxc4sOyw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ABXeu3023636;
 Tue, 10 Sep 2024 06:33:40 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 06:33:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 06:33:40 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48ABXcKn068799;
 Tue, 10 Sep 2024 06:33:39 -0500
Message-ID: <7fbbe3b5-bc4a-4d84-9fc6-0ef0b19aedb5@ti.com>
Date: Tue, 10 Sep 2024 17:03:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ufs: use dcache helpers for scsi_cmd data and only
 invalidate if necessary
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-4-3ee0bffacc64@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-4-3ee0bffacc64@linaro.org>
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
> Now we have proper flush and invalidate helpers, we can use them
> directly to operate on the scsi_cmd data.
> 
> Likewise, we do not need to flush then invalidate, just flush _or_
> invalidate depending on the data direction.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 5845fd694d3..d99dcdef7d0 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1468,7 +1468,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   {
>   	struct utp_transfer_req_desc *req_desc = hba->utrdl;
>   	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
> -	uintptr_t aaddr = (uintptr_t)(pccb->pdata) & ~(ARCH_DMA_MINALIGN - 1);
>   	ulong datalen = pccb->datalen;
>   	int table_length;
>   	u8 *buf;
> @@ -1480,15 +1479,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   		return;
>   	}
>   
> -	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
> -		flush_dcache_range(aaddr,
> -				   ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
> -	}
> -
> -	/* In any case, invalidate cache to avoid stale data in it. */
> -	invalidate_dcache_range(aaddr,
> -				ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
> -
>   	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
>   	buf = pccb->pdata;
>   	i = table_length;
> @@ -1517,8 +1507,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>   	prepare_prdt_table(hba, pccb);
>   
> +	ufshcd_cache_flush(pccb->pdata, pccb->datalen);
> +
>   	ufshcd_send_command(hba, TASK_TAG);
>   
> +	ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
> +
>   	ocs = ufshcd_get_tr_ocs(hba);
>   	switch (ocs) {
>   	case OCS_SUCCESS:
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
