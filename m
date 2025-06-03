Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEACC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 06:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE39680F0E;
	Tue,  3 Jun 2025 08:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fmcnN54Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFD581E06; Tue,  3 Jun 2025 08:16:23 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A43880AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5536GJSC380117;
 Tue, 3 Jun 2025 01:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748931379;
 bh=gKFSXFSuX+FciBrRqzKdfMBagstzRxC2Y+W4sWXO1ww=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fmcnN54Z7m7PB1kBo7foJtmge7lHNRigPL5mdyymQVsTLva6kHro9zWdP8GtbCyXk
 wvUcj+9p5HbSxYNGkfhfWFgMjijnyM1IeI87VJ2jvevJAH4ynbCutjPQwnf8UYULbh
 67iocw5MT71ECH4bmUgg6+O/EBMM0BUwpsYkOSRQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5536GIJn1124029
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 01:16:19 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 01:16:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 01:16:18 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5536GF7o4188917;
 Tue, 3 Jun 2025 01:16:16 -0500
Message-ID: <b76f4e6f-ae98-4ae5-8984-d36ea8f82d19@ti.com>
Date: Tue, 3 Jun 2025 11:46:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] firmware: ti_sci.c: Add a function to query DM
 firmware's capability
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-4-m-shah@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250528080519.677750-4-m-shah@ti.com>
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
> Add a new function to query the capabilities of the DM firmware, using
> TI SCI protocol to retrieve a 64-bit firmware capability, where each bit
> represents a specific capability supported by the firmware.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 45 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 54d6689ce78..bb9738efa81 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -278,6 +278,48 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
>  	return ret;
>  }
>  
> +/**
> + * ti_sci_cmd_query_dm_cap() - Command to query DM firmware's capabilities
> + * @handle:	Pointer to TI SCI handle
> + * @fw_caps:	Pointer to firmware capabilities
> + *
> + * Return: 0 if all went fine, else return appropriate error.
> + */
> +static int ti_sci_cmd_query_dm_cap(struct ti_sci_handle *handle, u64 *fw_caps)
> +{
> +	struct ti_sci_query_fw_caps_resp *cap_info;
> +	struct ti_sci_msg_hdr hdr;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_QUERY_FW_CAPS,
> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&hdr, sizeof(struct ti_sci_msg_hdr),
> +				     sizeof(*cap_info));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		return ret;
> +	}
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret)
> +		return ret;
> +
> +	cap_info = (struct ti_sci_query_fw_caps_resp *)xfer->tx_message.buf;
> +
> +	*fw_caps = cap_info->fw_caps;
> +
> +	return 0;
> +}
> +
>  /**
>   * ti_sci_cmd_get_revision() - command to get the revision of the SCI entity
>   * @handle:	pointer to TI SCI handle
> @@ -2624,6 +2666,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	struct ti_sci_dev_ops *dops = &ops->dev_ops;
>  	struct ti_sci_clk_ops *cops = &ops->clk_ops;
>  	struct ti_sci_core_ops *core_ops = &ops->core_ops;
> +	struct ti_sci_firmware_ops *fw_ops = &ops->fw_ops;
>  	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
>  	struct ti_sci_proc_ops *pops = &ops->proc_ops;
>  	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
> @@ -2694,6 +2737,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	fwl_ops->set_fwl_region = ti_sci_cmd_set_fwl_region;
>  	fwl_ops->get_fwl_region = ti_sci_cmd_get_fwl_region;
>  	fwl_ops->change_fwl_owner = ti_sci_cmd_change_fwl_owner;
> +
> +	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
>  }
>  
>  /**

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
