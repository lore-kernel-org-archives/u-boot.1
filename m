Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E7CC5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 04:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC9187647;
	Thu, 23 Nov 2023 05:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q+e8vQup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7F187647; Thu, 23 Nov 2023 05:25:30 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79672875AF
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 05:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4PNW6077850;
 Wed, 22 Nov 2023 22:25:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700713523;
 bh=OttK9rinyw5WInruwJp6mvot6B1rQmEocxTUobQ9ttQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Q+e8vQupCDwSRN3uMl2iNzDy5l+VnQ4lmAx6/f+FmKG6E22Qkpk3X8ceAir6L22tS
 78YHGvwTVY5C10twghOwh7XUf+Q6bDXzLf8FnP8EzYnMHW0d+S7yu9W1pE4X3Fmw3I
 34su+CB7vmeTd+MgnAHbeAFHEDFSuxljqVr0JiGg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AN4PNLa101298
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Nov 2023 22:25:23 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 22:25:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 22:25:23 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AN4OdrA070851;
 Wed, 22 Nov 2023 22:25:21 -0600
Message-ID: <0d311314-71e3-46d1-bec4-4fc589f052e2@ti.com>
Date: Thu, 23 Nov 2023 09:55:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] ufs: Add a line feed to the end of some dev_xxx()
 messages
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-3-bmeng@tinylab.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231011131552.14665-3-bmeng@tinylab.org>
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

Hi Bin,

On 11/10/23 18:45, Bin Meng wrote:
> Add a line feed to improve readability of some dev_xxx() messages.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/ufs/ufs.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index f534d6e29f..96801866d3 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -320,7 +320,7 @@ static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
>   					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
>   					0);
>   		if (err) {
> -			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d",
> +			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d\n",
>   				__func__, peer, i, err);
>   			break;
>   		}
> @@ -441,7 +441,7 @@ static int ufshcd_make_hba_operational(struct ufs_hba *hba)
>   		ufshcd_enable_run_stop_reg(hba);
>   	} else {
>   		dev_err(hba->dev,
> -			"Host controller not ready to process requests");
> +			"Host controller not ready to process requests\n");
>   		err = -EIO;
>   		goto out;
>   	}
> @@ -930,7 +930,7 @@ static int ufshcd_copy_query_response(struct ufs_hba *hba)
>   			memcpy(hba->dev_cmd.query.descriptor, descp, resp_len);
>   		} else {
>   			dev_warn(hba->dev,
> -				 "%s: Response size is bigger than buffer",
> +				 "%s: Response size is bigger than buffer\n",
>   				 __func__);
>   			return -EINVAL;
>   		}
> @@ -1179,11 +1179,11 @@ static int ufshcd_read_desc_length(struct ufs_hba *hba, enum desc_idn desc_id,
>   					    &header_len);
>   
>   	if (ret) {
> -		dev_err(hba->dev, "%s: Failed to get descriptor header id %d",
> +		dev_err(hba->dev, "%s: Failed to get descriptor header id %d\n",
>   			__func__, desc_id);
>   		return ret;
>   	} else if (desc_id != header[QUERY_DESC_DESC_TYPE_OFFSET]) {
> -		dev_warn(hba->dev, "%s: descriptor header id %d and desc_id %d mismatch",
> +		dev_warn(hba->dev, "%s: descriptor header id %d and desc_id %d mismatch\n",
>   			 __func__, header[QUERY_DESC_DESC_TYPE_OFFSET],
>   			 desc_id);
>   		ret = -EINVAL;
> @@ -1302,7 +1302,7 @@ int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>   
>   	/* Sanity checks */
>   	if (ret || !buff_len) {
> -		dev_err(hba->dev, "%s: Failed to get full descriptor length",
> +		dev_err(hba->dev, "%s: Failed to get full descriptor length\n",
>   			__func__);
>   		return ret;
>   	}
> @@ -1323,14 +1323,14 @@ int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
>   					    &buff_len);
>   
>   	if (ret) {
> -		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d",
> +		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d\n",
>   			__func__, desc_id, desc_index, param_offset, ret);
>   		goto out;
>   	}
>   
>   	/* Sanity check */
>   	if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id) {
> -		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header",
> +		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header\n",
>   			__func__, desc_buf[QUERY_DESC_DESC_TYPE_OFFSET]);
>   		ret = -EINVAL;
>   		goto out;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
