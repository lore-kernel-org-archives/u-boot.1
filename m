Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B585DC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 06:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01CB180F0E;
	Tue,  3 Jun 2025 08:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TN150tcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0097C81E06; Tue,  3 Jun 2025 08:03:56 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF85180AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55363p3n3411307;
 Tue, 3 Jun 2025 01:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748930631;
 bh=Hj7nXy6bqFswW09EXVupvV7QeikPYNtMogkLPULt4F0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TN150tcHqNO9vIkYQAACmQ4enUKn7rzFPyqL7ZNiXw+hRBo219KvUewkcZlDxWrNY
 brOxdjmBKgbQ5+KihtyRVZuhhcsfLmK99k4U8l0ECiU1Qfu8WlsenvvHf+w6iFeLvm
 ugdAv/g4MpiZvdw2xLQ6JUUprB8Grdz/GfQJpLbA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55363pk43526401
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 01:03:51 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 01:03:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 01:03:50 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55363lhM4174222;
 Tue, 3 Jun 2025 01:03:48 -0500
Message-ID: <e8ff1ade-eab7-41a6-90c3-9373d5f5b19a@ti.com>
Date: Tue, 3 Jun 2025 11:33:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ti_sci_*: Add utility to access tisci firmware and
 SOC capability
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-2-m-shah@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250528080519.677750-2-m-shah@ti.com>
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

Hi Moteen

On 28/05/25 13:35, Moteen Shah wrote:
> Introduce response and request structs for receiving information
> regarding FW/SOC capability from DM. The received capability can
> further be used to call API's based on the feature supported by
> the DM firmware.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/firmware/ti_sci.h              | 13 +++++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h | 12 ++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index bb8bc7beead..f3d9eb453b4 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -26,6 +26,7 @@
>  #define TI_SCI_MSG_BOARD_CONFIG_RM	0x000c
>  #define TI_SCI_MSG_BOARD_CONFIG_SECURITY  0x000d
>  #define TI_SCI_MSG_BOARD_CONFIG_PM	0x000e
> +#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
>  #define TISCI_MSG_QUERY_MSMC		0x0020
>  
>  /* Device requests */
> @@ -134,6 +135,18 @@ struct ti_sci_msg_resp_version {
>  	u8 abi_minor;
>  } __packed;
>  
> +/**
> + * struct ti_sci_query_fw_caps_resp - Response for a message
> + * @hdr:	Generic header
> + * @fw_caps:	64-bit value representing the FW/SOC capabilities.
> + *
> + * Response to a message with message type TI_SCI_MSG_QUERY_FW_CAPS
> + */
> +struct ti_sci_query_fw_caps_resp {
> +	struct ti_sci_msg_hdr hdr;
> +	u64    fw_caps;
> +} __packed;
> +
>  /**
>   * struct ti_sci_msg_req_reboot - Reboot the SoC
>   * @hdr:	Generic Header
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index aa4d105ee98..05a19a8d86c 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -261,6 +261,17 @@ struct ti_sci_core_ops {
>  			  u64 *msmc_start, u64 *msmc_end);
>  };
>  
> +/**
> + * struct ti_sci_firmware_ops - DM firmware operations
> + * @query_dm_cap: Query the DM capabilities
> + */
> +struct ti_sci_firmware_ops {
> +	int (*query_dm_cap)(struct ti_sci_handle *handle,
> +			    u64 *dm_cap);
> +};
> +
> +#define TI_SCI_MSG_FLAG_FW_CAP_DM	0x100
> +
>  /**
>   * struct ti_sci_proc_ops - Processor specific operations.
>   *
> @@ -609,6 +620,7 @@ struct ti_sci_ops {
>  	struct ti_sci_dev_ops dev_ops;
>  	struct ti_sci_clk_ops clk_ops;
>  	struct ti_sci_core_ops core_ops;
> +	struct ti_sci_firmware_ops fw_ops;
>  	struct ti_sci_proc_ops proc_ops;
>  	struct ti_sci_rm_core_ops rm_core_ops;
>  	struct ti_sci_rm_ringacc_ops rm_ring_ops;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
