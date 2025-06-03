Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405AEC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80B182103;
	Tue,  3 Jun 2025 10:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="plJBP6FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667D882116; Tue,  3 Jun 2025 10:33:52 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26150820EB
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5538Xl4d469547;
 Tue, 3 Jun 2025 03:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748939627;
 bh=HbWWP9eKmXJje7tkrMsudqlAr9LoMyrh0RwJ1opajYA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=plJBP6FWFwUk7Sz8Mc+YtIAJV+IXQoiGZzbhLkvKtVXFHxVo9yXN5F4TYNsT5DimZ
 5gN7AimXzVoLcCk2mstoIAW+ymTu8kuH0WN0bloKU4ZypYwBk+9fSHp+KC3GDpy/Nj
 GjuA6GANcZTNsmhaV8bxH4F0ysxQOnPaCKsKbCJE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5538XlfQ3480794
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 03:33:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 03:33:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 03:33:47 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5538XkvJ162754;
 Tue, 3 Jun 2025 03:33:46 -0500
Date: Tue, 3 Jun 2025 14:03:45 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Moteen Shah <m-shah@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH 2/6] ti_sci_* : Add capability to access DM firmware's
 metadata
Message-ID: <20250603083345.ma2txq7osdwfber5@lcpd911>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-3-m-shah@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528080519.677750-3-m-shah@ti.com>
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

On May 28, 2025 at 13:35:15 +0530, Moteen Shah wrote:
> Introduce response and request structs to receive and request
> information regarding DM version, etc from TI SCI.

Nit: Remove the ", etc"
The patch is literally just about DM version.

> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/firmware/ti_sci.h              | 29 ++++++++++++++++++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h | 26 +++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index f3d9eb453b4..6ef77d83114 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -19,6 +19,7 @@
>  #define TI_SCI_MSG_ENABLE_WDT		0x0000
>  #define TI_SCI_MSG_WAKE_RESET		0x0001
>  #define TI_SCI_MSG_VERSION		0x0002
> +#define TI_SCI_MSG_DM_VERSION		0x000F
>  #define TI_SCI_MSG_WAKE_REASON		0x0003
>  #define TI_SCI_MSG_GOODBYE		0x0004
>  #define TI_SCI_MSG_SYS_RESET		0x0005
> @@ -135,6 +136,34 @@ struct ti_sci_msg_resp_version {
>  	u8 abi_minor;
>  } __packed;
>  
> +/**
> + * struct ti_sci_msg_dm_resp_version - Response for a message
> + * @hdr:		Generic header
> + * @version:		Version number of the firmware
> + * @sub_version:	Sub-version number of the firmware
> + * @patch_version:	Patch version number of the firmware
> + * @abi_major:		Major version of the ABI that firmware supports
> + * @abi_minor:		Minor version of the ABI that firmware supports
> + * @sci_server_version:	String describing the SCI server version
> + * @rm_pm_hal_version:	String describing the RM PM HAL version
> + *
> + * In general, ABI version changes follow the rule that minor version increments
> + * are backward compatible. Major revision changes in ABI may not be
> + * backward compatible.
> + *
> + * Response to a message with message type TI_SCI_MSG_DM_VERSION
> + */
> +struct ti_sci_msg_dm_resp_version {
> +	struct ti_sci_msg_hdr hdr;
> +	u16	version;
> +	u8	sub_version;
> +	u8	patch_version;
> +	u8	abi_major;
> +	u8	abi_minor;
> +	char rm_pm_hal_version[12];
> +	char sci_server_version[26];
> +} __packed;
> +
>  /**
>   * struct ti_sci_query_fw_caps_resp - Response for a message
>   * @hdr:	Generic header
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 05a19a8d86c..3f13a980433 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -30,6 +30,28 @@ struct ti_sci_version_info {
>  	char firmware_description[32];
>  };
>  
> +/**
> + * struct ti_sci_dm_version_info - version information structure
> + * @abi_major:		Major ABI version. Change here implies risk of backward
> + *			compatibility break.
> + * @abi_minor:		Minor ABI version. Change here implies new feature addition,
> + *			or compatible change in ABI.
> + * @patch_ver:		Patch version of the firmware.
> + * @sub_ver:		Sub-version of the firmware.
> + * @dm_ver:		DM version.
> + * @sci_server_version:	Version string of the SCI server.
> + * @rm_pm_hal_version:	Version string of the RM PM HAL.
> + */
> +struct ti_sci_dm_version_info {
> +	u8 abi_major;
> +	u8 abi_minor;
> +	u8 patch_ver;
> +	u8 sub_ver;
> +	u16 dm_ver;
> +	char rm_pm_hal_version[12];
> +	char sci_server_version[26];
> +};
> +
>  struct ti_sci_handle;
>  
>  /**
> @@ -264,10 +286,14 @@ struct ti_sci_core_ops {
>  /**
>   * struct ti_sci_firmware_ops - DM firmware operations
>   * @query_dm_cap: Query the DM capabilities
> + * @get_dm_version: Get the DM version.
> + *		    Return 0 for successful query else appropriate error value.
>   */
>  struct ti_sci_firmware_ops {
>  	int (*query_dm_cap)(struct ti_sci_handle *handle,
>  			    u64 *dm_cap);
> +	int (*get_dm_version)(struct ti_sci_handle *handle,
> +			      struct ti_sci_dm_version_info *get_dm_version);

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
