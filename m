Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C82E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 08:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC3B8927A;
	Fri,  6 Dec 2024 09:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vics+UiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639DD89387; Fri,  6 Dec 2024 09:03:10 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13ADD891AD
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 09:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B6833TG2072974
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Dec 2024 02:03:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733472183;
 bh=bTZ7Fl5zAy+/SA+GcBnMUFVbw0ChD83sKDZxvGVSGi4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=vics+UiRLqN6UFKdBEpElDd8ing4bEy+LYBgRQOPcmrbTW3Xb4ToniJQ6lFYRSaak
 nStKI7WvcHZqVf31qQUYe4fZmHwqZ6sEkvdMN/vxfmZnw7TEop8XElddketF1Kf6u6
 Nq3pMtWd2AcaUDOobTGxvaZ6d7404Zmfu61vBr24=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B6833Zr028187;
 Fri, 6 Dec 2024 02:03:03 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 02:03:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 02:03:03 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B6830JI095399;
 Fri, 6 Dec 2024 02:03:01 -0600
Message-ID: <686541aa-1e4c-4cc4-b92e-29d0362b6bcb@ti.com>
Date: Fri, 6 Dec 2024 13:33:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ufs: core: cosmetic fixups
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>, <u-boot@lists.denx.de>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-3-a5cef54b1cdc@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-3-a5cef54b1cdc@linaro.org>
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

On 20/11/24 14:52, Neil Armstrong wrote:
> Fixes some alignment warnings, missing comments on write barrier,
> missing parenthesis around macro parameters and a comment typo.
> 
> No functional changes intended.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c    | 16 ++++++----------
>   drivers/ufs/ufs.h    |  6 +++---
>   drivers/ufs/unipro.h |  4 ++--
>   3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 8a6c9f1e40b058dfd29bc07d011d576cdfc504cb..173b8d01d2a415999248468890cc9bcb66a21c24 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -314,16 +314,12 @@ static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
>   		ufshcd_dme_peer_get(hba, UIC_ARG_MIB(PA_CONNECTEDTXDATALANES),
>   				    &tx_lanes);
>   	for (i = 0; i < tx_lanes; i++) {
> +		unsigned int val = UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
> +						   UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i));
>   		if (!peer)
> -			err = ufshcd_dme_set(hba,
> -					     UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
> -					     UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
> -					     0);
> +			err = ufshcd_dme_set(hba, val, 0);
>   		else
> -			err = ufshcd_dme_peer_set(hba,
> -					UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
> -					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
> -					0);
> +			err = ufshcd_dme_peer_set(hba, val, 0);
>   		if (err) {
>   			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d\n",
>   				__func__, peer, i, err);
> @@ -1963,7 +1959,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   
>   	ufshcd_ops_init(hba);
>   
> -	/* Read capabilties registers */
> +	/* Read capabilities registers */
>   	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
>   	if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
>   		hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
> @@ -2002,7 +1998,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   		      REG_INTERRUPT_STATUS);
>   	ufshcd_writel(hba, 0, REG_INTERRUPT_ENABLE);
>   
> -	mb();
> +	mb(); /* flush previous writes */
>   
>   	/* Reset the attached device */
>   	ufshcd_device_reset(hba);
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 00ecca350c350cc930d9056aba8ada0475a280dd..f4f042005e7fc2638ea6b33f26839c668d22bc9e 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -130,8 +130,8 @@ enum {
>   					(sizeof(struct utp_upiu_header)))
>   #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
>   #define UPIU_HEADER_DWORD(byte3, byte2, byte1, byte0)\
> -			cpu_to_be32((byte3 << 24) | (byte2 << 16) |\
> -			 (byte1 << 8) | (byte0))
> +			cpu_to_be32(((byte3) << 24) | ((byte2) << 16) |\
> +			 ((byte1) << 8) | (byte0))
>   /*
>    * UFS Protocol Information Unit related definitions
>    */
> @@ -915,7 +915,7 @@ static inline int ufshcd_ops_get_max_pwr_mode(struct ufs_hba *hba,
>   }
>   
>   static inline int ufshcd_ops_hce_enable_notify(struct ufs_hba *hba,
> -						bool status)
> +					       bool status)
>   {
>   	if (hba->ops && hba->ops->hce_enable_notify)
>   		return hba->ops->hce_enable_notify(hba, status);
> diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
> index 6df953e6e6073748ac640faea00aa6ac2a8c8663..0aa35ef31dfd263739c0b5c75c26f9191f38e8ec 100644
> --- a/drivers/ufs/unipro.h
> +++ b/drivers/ufs/unipro.h
> @@ -59,7 +59,7 @@
>   #define RXSQCTRL				0x00B5
>   #define CFGRXOVR6				0x00BF
>   
> -#define is_mphy_tx_attr(attr)			(attr < RX_MODE)
> +#define is_mphy_tx_attr(attr)			((attr) < RX_MODE)
>   #define RX_MIN_ACTIVATETIME_UNIT_US		100
>   #define HIBERN8TIME_UNIT_US			100
>   
> @@ -77,7 +77,7 @@
>   #define CBPRGPLL2				UNIPRO_CB_OFFSET(0x00F8)
>   #define CBPRGTUNING				UNIPRO_CB_OFFSET(0x00FB)
>   
> -#define UNIPRO_CB_OFFSET(x)			(0x8000 | x)
> +#define UNIPRO_CB_OFFSET(x)			(0x8000 | (x))
>   
>   /*
>    * PHY Adpater attributes
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
