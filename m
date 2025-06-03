Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1939FC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98373820EB;
	Tue,  3 Jun 2025 10:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VZCAS4oV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B7382103; Tue,  3 Jun 2025 10:38:27 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E1481E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5538cNKi416881;
 Tue, 3 Jun 2025 03:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748939903;
 bh=4od1tSt4cHptgx4LaxI5yzgLviJPD55eoMcTwDyyjkY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VZCAS4oVI8eEJCvpcGootdoVUpajxsKwVAS2EX4kfgzm90sNJvV8QXS2UXnYbJ/Md
 V93EHJf0ttiY8XycRFBj2MNOU73wl0t/lVP/1Y1rQHVUT5srtH9F6bq5SwREeJ4MXW
 53TH+98B2w532y0/rzHCVIOCmPl+FZaUF7CZMpS4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5538cNnb3614470
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 03:38:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 03:38:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 03:38:22 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5538cKVI080951;
 Tue, 3 Jun 2025 03:38:20 -0500
Message-ID: <50971a76-0bdb-4fea-b22e-488ac3b7f9f1@ti.com>
Date: Tue, 3 Jun 2025 14:08:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] firmware: ti_sci.c: Add a function to request DM
 metadata using ti_sci* calls
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-5-m-shah@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250528080519.677750-5-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

On 28/05/25 13:35, Moteen Shah wrote:
> Add a function to retrieve information of the DM firmware's ABI versions,
> RM/PM HAL, firmware version, etc using TI_SCI protocol.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 54 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index bb9738efa81..8a8edc97e85 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -320,6 +320,59 @@ static int ti_sci_cmd_query_dm_cap(struct ti_sci_handle *handle, u64 *fw_caps)
>  	return 0;
>  }
>  
> +/**
> + * ti_sci_cmd_get_dm_version() - command to get the DM version of the SCI
> + *				 entity
> + * @handle:	Pointer to TI SCI handle
> + * @dm_info:	Pointer to DM version information structure
> + *
> + * Return: 0 if all went fine, else return appropriate error.
> + */
> +
> +static int ti_sci_cmd_get_dm_version(struct ti_sci_handle *handle,
> +				     struct ti_sci_dm_version_info *dm_info)
> +{
> +	struct ti_sci_msg_dm_resp_version *ver_info;
> +	struct ti_sci_msg_hdr hdr;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle || !dm_info)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_DM_VERSION,
> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&hdr, sizeof(struct ti_sci_msg_hdr),
> +				     sizeof(*ver_info));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		return ret;
> +	}
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret)
> +		return ret;
> +
> +	ver_info = (struct ti_sci_msg_dm_resp_version *)xfer->tx_message.buf;
> +
> +	dm_info->abi_major = ver_info->abi_major;
> +	dm_info->abi_minor = ver_info->abi_minor;
> +	dm_info->dm_ver = ver_info->version;
> +	dm_info->patch_ver = ver_info->patch_version;
> +	dm_info->sub_ver = ver_info->sub_version;
> +	strlcpy(dm_info->sci_server_version, ver_info->sci_server_version,
> +		sizeof(ver_info->sci_server_version));
> +	strlcpy(dm_info->rm_pm_hal_version, ver_info->rm_pm_hal_version,
> +		sizeof(ver_info->rm_pm_hal_version));
> +
> +	return 0;
> +}
> +
>  /**
>   * ti_sci_cmd_get_revision() - command to get the revision of the SCI entity
>   * @handle:	pointer to TI SCI handle
> @@ -2738,6 +2791,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	fwl_ops->get_fwl_region = ti_sci_cmd_get_fwl_region;
>  	fwl_ops->change_fwl_owner = ti_sci_cmd_change_fwl_owner;
>  
> +	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
>  	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
>  }
>  

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
