Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7E7CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 16:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F56384509;
	Thu,  9 Oct 2025 18:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HiK4RVoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D758F84582; Thu,  9 Oct 2025 18:02:04 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F35383EAC
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 18:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599G1uvo494712;
 Thu, 9 Oct 2025 11:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760025716;
 bh=sPmuBLJVT1DfGb+D2k0wPCK4fWcchlNuHH5T90gCSiw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HiK4RVoeb7ygKF8S5uxCMPx55ayyi9WZfVWLrP5dxu49PocE3AexUGE+yWqREfZOr
 zuobIBZE/N2oE6mk6l2CdBKDLlWGDGkiNJe+ZOOglcT/LiN4W0o13oWwaKDLo4cac3
 jAF42m5tvdJPB+HIvWIjV3Ah+4e6g35RSpVd0hIc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599G1ula1543473
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 9 Oct 2025 11:01:56 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 11:01:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 11:01:55 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599G1qdS263638;
 Thu, 9 Oct 2025 11:01:53 -0500
Message-ID: <7ead6477-d54e-4a39-a6d5-b193ce9f2398@ti.com>
Date: Thu, 9 Oct 2025 21:31:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ufs: Add support for sending UFS attribute requests
To: Jared McArthur <j-mcarthur@ti.com>, <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, <u-kumar1@ti.com>
References: <20250827185056.954640-1-j-mcarthur@ti.com>
 <20250827185056.954640-2-j-mcarthur@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250827185056.954640-2-j-mcarthur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 8/28/2025 12:20 AM, Jared McArthur wrote:
> Some UFS attributes must be set before a UFS device is initialized.
> Add ufshcd_query_attr and ufshcd_query_attr_retry to send UFS
> attribute requests.
>
> Taken from Linux Kernel v6.17 (drivers/ufs/core/ufshcd.c) and ported
> to U-Boot.
>
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
> ---
>   drivers/ufs/ufs.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
>
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 91f6ad3bfef..9e67dd86232 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1107,6 +1107,101 @@ static int ufshcd_query_flag_retry(struct ufs_hba *hba,
>   	return ret;
>   }
>   
> +/**
> + * ufshcd_query_attr - API function for sending attribute requests
> + * @hba: per-adapter instance
> + * @opcode: attribute opcode
> + * @idn: attribute idn to access
> + * @index: index field
> + * @selector: selector field
> + * @attr_val: the attribute value after the query request completes
> + *
> + * Return: 0 for success, non-zero in case of failure.
> + */
> +int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
> +		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val)
> +{
> +	struct ufs_query_req *request = NULL;
> +	struct ufs_query_res *response = NULL;
> +	int err;
> +
> +	if (!attr_val) {
> +		dev_err(hba->dev,
> +			"%s: attribute value required for opcode 0x%x\n",
> +			__func__, opcode);
> +		return -EINVAL;
> +	}
> +
> +	ufshcd_init_query(hba, &request, &response, opcode, idn, index, selector);
> +
> +	switch (opcode) {
> +	case UPIU_QUERY_OPCODE_WRITE_ATTR:
> +		request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
> +		request->upiu_req.value = cpu_to_be32(*attr_val);
> +		break;
> +	case UPIU_QUERY_OPCODE_READ_ATTR:
> +		request->query_func = UPIU_QUERY_FUNC_STANDARD_READ_REQUEST;
> +		break;
> +	default:
> +		dev_err(hba->dev,
> +			"%s: Expected query attr opcode but got = 0x%.2x\n",
> +			__func__, opcode);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
> +
> +	if (err) {
> +		dev_err(hba->dev,
> +			"%s: opcode 0x%.2x for idn %d failed, index %d, err = %d\n",
> +			__func__, opcode, idn, index, err);
> +		goto out;
> +	}
> +
> +	*attr_val = be32_to_cpu(response->upiu_res.value);
> +
> +out:
> +	return err;
> +}
> +
> +/**
> + * ufshcd_query_attr_retry() - API function for sending query
> + * attribute with retries
> + * @hba: per-adapter instance
> + * @opcode: attribute opcode
> + * @idn: attribute idn to access
> + * @index: index field
> + * @selector: selector field
> + * @attr_val: the attribute value after the query request
> + * completes
> + *
> + * Return: 0 for success, non-zero in case of failure.
> + */
> +int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
> +			    enum attr_idn idn, u8 index, u8 selector,
> +			    u32 *attr_val)
> +{
> +	int ret = 0;
> +	u32 retries;
> +
> +	for (retries = QUERY_REQ_RETRIES; retries > 0; retries--) {
> +		ret = ufshcd_query_attr(hba, opcode, idn, index, selector, attr_val);
> +		if (ret)
> +			dev_dbg(hba->dev,
> +				"%s: failed with error %d, retries %d\n",
> +				__func__, ret, retries);
> +		else
> +			break;
> +	}
> +
> +	if (ret)
> +		dev_err(hba->dev,
> +			"%s: query attribute, idn %d, failed with error %d after %d retries\n",
> +			__func__, idn, ret, QUERY_REQ_RETRIES);
> +	return ret;
> +}
> +


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   static int __ufshcd_query_descriptor(struct ufs_hba *hba,
>   				     enum query_opcode opcode,
>   				     enum desc_idn idn, u8 index, u8 selector,
