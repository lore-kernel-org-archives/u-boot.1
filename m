Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107B0CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DEAB8211F;
	Wed, 20 Aug 2025 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="EpHbKP72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2FD082B07; Wed, 20 Aug 2025 13:10:45 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AB2801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ae1e8so7345108a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1755688243; x=1756293043;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=s/r7ow5DXvynKPIrfRkza3D2Flc7udHIGZ77981prZM=;
 b=EpHbKP72Bo3X6M9Hrb2RC7rwsIC95XV8s8p2JcObAa10EiBbhh6y7VD1ylXiQ5UytH
 pkAk0R+8IW76XzwNQ5tiejWZ8eppUEUBDItRrh2KvxD7JY9rD7ostkqq4L/EfVIf3EEV
 8v4+NCtw+HExyY/AaFWTJfWGUTZSIEJh5vuBMt7PFt/qUwWePkkOIK8cnISFtMG5nbZy
 fKnH/VfVyYwrhvLTRFulT64OSNTvPv/5aCQ1HGLAL6wK9bsW/ahvxPUxROdAyvWEX62X
 FFOp1R0aQAWbHSWfysrzNQQ8J403+By0cQnq183CdFSRL7i/ykS9TpCbURqbg7j8pbmc
 b69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755688243; x=1756293043;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/r7ow5DXvynKPIrfRkza3D2Flc7udHIGZ77981prZM=;
 b=FprvgdHrqiJCvMpSEoMLBGN+tq05YkywlcncqS2dGG0kJ30r7z2GfhhnPykyJ7NnEn
 jEp8i+/6zmv1rsgUT5xnRENK+SfkjSLQfeg2QxDwoQJ+RLnxKyckU6Yl59Jn9XgmATlD
 AUKCrWWmSlU2+0rQ5HJ80Pg7bW0nujAJjXVMVaBu2ooEVWeA5jStuumUeNu4JQWenOJC
 ZWKtrS2NW7/HXP88tDOyuMJlnUFu1475gIv5I/c4CKERfyuWnsDS8s4JP3+eC2FF3ITB
 fKTNXjTJtNLHl4sJn6T5qNCDxgOl5Ir3DoZkgEfFvSrtBL6X7dc+/puAD0mARWarK+lr
 8rXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfDvCSJevqFTWB84uw6ecQBFNGJE8sh0RYm2S5+mjEvJrrgUJ9ABpEdz9fgl5orHzw7l44fRw=@lists.denx.de
X-Gm-Message-State: AOJu0YwmWcwdakJ0xQ6HMhnc38Mfl3Xcg2NVzbdeB4HamkD2cFscgV3N
 0pPrCuSXr11wZamIEnhT+7XPJHUVGeGVR+0T8hS9laypgz4OcVqNSjLxXyH0CF+2Mw==
X-Gm-Gg: ASbGncvE0HO2lCza/G3QAbkQO3nR3Tsv0wGIUnj56Nl0GXWqeeXTcG0nsRIyHWiJfm2
 V99fOoMbS5KkiGqiq7BnWCXTb4M1bazYjGq9cSeG1WJlKhCz/G4S25Lp6BIr/JIa0oaaFBsNN1z
 NwlnSaT3N/QIDt1IvZ0A0lwNBWQormUEYettw1dMXT5LsOHIhMX7VFleceYPE4eEIBba9B3YZtI
 cLLo21iVeEJBPOUvFK98XD+kyo8T3osb1iuTE4LneEdH3Ha39foZEOglG6Xcja/qidrrbjuledb
 GA/QCxgqxsdRUw9YdUP7vcWHJV9cMPQb+igInu3nA1er1NGsvc9wtDnlENQKNtENkvMAFWClKYl
 LABJv5fC8anZK9SW9xRDlcrnb
X-Google-Smtp-Source: AGHT+IE/EXh8/1REOLyIkg9lXgE3yDqg/ZhwtcaIagqIVMfnGzvlfPz2W97qMBBBk152vtipXGKmug==
X-Received: by 2002:a05:6402:518f:b0:618:8cd:5ccb with SMTP id
 4fb4d7f45d1cf-61a97826ce6mr1935726a12.31.1755688242694; 
 Wed, 20 Aug 2025 04:10:42 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a8c1afaa0sm1803894a12.25.2025.08.20.04.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 04:10:42 -0700 (PDT)
Message-ID: <ddeba900-6c0c-43c2-897c-faabcd805073@monstr.eu>
Date: Wed, 20 Aug 2025 13:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: amd-versal2: Configure RMMI and M-PHY registers for
 HS mode
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20250724044402.260149-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250724044402.260149-1-venkatesh.abbarapu@amd.com>
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



On 7/24/25 06:44, Venkatesh Yadav Abbarapu wrote:
> Configure RMMI and M-PHY registers for HS mode required for selection of
> bit rate series A or B. If it is not a calibrated part, then switch back
> to SLOWAUTO_MODE and skip all these configurations.
> Implemented below sequence as per the DWC RMMI databook.
> 1. Override RMMI CBRATESEL with the desired rate.
> 2. Set TX_CFGUPDT_0 to 1'b1 for one TX_CFGCLK_0 cycle.
> 3. Override PHY rx_req to 1, then poll on PHY rx_ack register till it
> goes 1(both lanes).
> 4. Override PHY rx_req to 0, then poll on PHY rx_ack register till it
> goes 0(both lanes).
> 5. Remove PHY rx_req override(both lanes).
> 6. Start the LS PMC.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/ufs/ufs-amd-versal2.c | 112 ++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs.c             |  15 +++++
>   drivers/ufs/ufs.h             |   3 +
>   drivers/ufs/ufshcd-dwc.h      |   3 +
>   4 files changed, 133 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 1c5ed538370..896dda2de4e 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -26,6 +26,10 @@
>   #define MPHY_FAST_RX_AFE_CAL		BIT(2)
>   #define MPHY_FW_CALIB_CFG_VAL		BIT(8)
>   
> +#define MPHY_RX_OVRD_EN			BIT(3)
> +#define MPHY_RX_OVRD_VAL		BIT(2)
> +#define MPHY_RX_ACK_MASK		BIT(0)
> +
>   #define TX_RX_CFG_RDY_MASK		GENMASK(3, 0)
>   
>   #define TIMEOUT_MICROSEC		1000000L
> @@ -422,10 +426,118 @@ static int ufs_versal2_link_startup_notify(struct ufs_hba *hba,
>   	return ret;
>   }
>   
> +static int ufs_versal2_phy_ratesel(struct ufs_hba *hba, u32 activelanes, u32 rx_req)
> +{
> +	u32 time_left, reg, lane;
> +	int ret;
> +
> +	for (lane = 0; lane < activelanes; lane++) {
> +		time_left = TIMEOUT_MICROSEC;
> +		ret = ufs_versal2_phy_reg_read(hba, RX_OVRD_IN_1(lane), &reg);
> +		if (ret)
> +			return ret;
> +
> +		reg |= MPHY_RX_OVRD_EN;
> +		if (rx_req)
> +			reg |= MPHY_RX_OVRD_VAL;
> +		else
> +			reg &= ~MPHY_RX_OVRD_VAL;
> +
> +		ret = ufs_versal2_phy_reg_write(hba, RX_OVRD_IN_1(lane), reg);
> +		if (ret)
> +			return ret;
> +
> +		do {
> +			ret = ufs_versal2_phy_reg_read(hba, RX_PCS_OUT(lane), &reg);
> +			if (ret)
> +				return ret;
> +
> +			reg &= MPHY_RX_ACK_MASK;
> +			if (reg == rx_req)
> +				break;
> +
> +			time_left--;
> +			mdelay(5);
> +		} while (time_left);
> +
> +		if (!time_left) {
> +			dev_err(hba->dev, "Invalid Rx Ack value.\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ufs_get_max_pwr_mode(struct ufs_hba *hba,
> +				struct ufs_pwr_mode_info *max_pwr_info)
> +{
> +	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
> +	u32 lane, reg, rate = 0;
> +	int ret = 0;
> +
> +	/* If it is not a calibrated part, switch PWRMODE to SLOW_MODE */
> +	if (!priv->attcompval0 && !priv->attcompval1 &&
> +	    !priv->ctlecompval0 && !priv->ctlecompval1) {
> +		max_pwr_info->info.pwr_rx = SLOWAUTO_MODE;
> +		max_pwr_info->info.pwr_tx = SLOWAUTO_MODE;
> +		max_pwr_info->info.gear_rx = UFS_PWM_G1;
> +		max_pwr_info->info.gear_tx = UFS_PWM_G1;
> +		max_pwr_info->info.lane_tx = 1;
> +		max_pwr_info->info.lane_rx = 1;
> +		max_pwr_info->info.hs_rate = 0;
> +			return 0;
> +	}
> +
> +	if (max_pwr_info->info.pwr_rx == SLOWAUTO_MODE ||
> +	    max_pwr_info->info.pwr_tx == SLOWAUTO_MODE)
> +		return 0;
> +
> +	if (max_pwr_info->info.hs_rate == PA_HS_MODE_B)
> +		rate = 1;
> +
> +	/* Select the rate */
> +	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(CBRATESEL), rate);
> +	if (ret)
> +		return ret;
> +
> +	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYCFGUPDT), 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = ufs_versal2_phy_ratesel(hba, max_pwr_info->info.lane_tx, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = ufs_versal2_phy_ratesel(hba, max_pwr_info->info.lane_tx, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Remove rx_req override */
> +	for (lane = 0; lane < max_pwr_info->info.lane_tx; lane++) {
> +		ret = ufs_versal2_phy_reg_read(hba, RX_OVRD_IN_1(lane), &reg);
> +		if (ret)
> +			return ret;
> +
> +		reg &= ~MPHY_RX_OVRD_EN;
> +		ret = ufs_versal2_phy_reg_write(hba, RX_OVRD_IN_1(lane), reg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (max_pwr_info->info.lane_tx == UFS_LANE_2 &&
> +	    max_pwr_info->info.lane_rx == UFS_LANE_2)
> +		ret = ufshcd_dme_configure_adapt(hba, max_pwr_info->info.gear_tx,
> +						 PA_INITIAL_ADAPT);
> +
> +	return 0;
> +}
> +
>   static struct ufs_hba_ops ufs_versal2_hba_ops = {
>   	.init = ufs_versal2_init,
>   	.link_startup_notify = ufs_versal2_link_startup_notify,
>   	.hce_enable_notify = ufs_versal2_hce_enable_notify,
> +	.get_max_pwr_mode = ufs_get_max_pwr_mode,
>   };
>   
>   static int ufs_versal2_probe(struct udevice *dev)
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 91f6ad3bfef..57e6e8c013b 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -226,6 +226,21 @@ static int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
>   	return 0;
>   }
>   
> +int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
> +			       int agreed_gear,
> +			       int adapt_val)
> +{
> +	int ret;
> +
> +	if (agreed_gear < UFS_HS_G4)
> +		adapt_val = PA_NO_ADAPT;
> +
> +	ret = ufshcd_dme_set(hba,
> +			     UIC_ARG_MIB(PA_TXHSADAPTTYPE),
> +			     adapt_val);
> +	return ret;
> +}
> +
>   /**
>    * ufshcd_dme_set_attr - UIC command for DME_SET, DME_PEER_SET
>    *
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 53137fae3a8..0337ac5996b 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -428,6 +428,9 @@ enum uic_link_state {
>   #define ATTR_SET_NOR	0	/* NORMAL */
>   #define ATTR_SET_ST	1	/* STATIC */
>   
> +int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
> +			       int agreed_gear,
> +			       int adapt_val);
>   int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
>   			u8 attr_set, u32 mib_val, u8 peer);
>   int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
> diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
> index fc1bcca8ccb..f7d27736f44 100644
> --- a/drivers/ufs/ufshcd-dwc.h
> +++ b/drivers/ufs/ufshcd-dwc.h
> @@ -17,6 +17,7 @@
>   #define CBREFCLKCTRL2		0x8132
>   #define CBCRCTRL		0x811F
>   #define CBC10DIRECTCONF2	0x810E
> +#define CBRATESEL		0x8114
>   #define CBCREGADDRLSB		0x8116
>   #define CBCREGADDRMSB		0x8117
>   #define CBCREGWRLSB		0x8118
> @@ -32,6 +33,8 @@
>   #define MRX_FSM_STATE		0xC1
>   
>   /* M-PHY registers */
> +#define RX_OVRD_IN_1(n)		(0x3006 + ((n) * 0x100))
> +#define RX_PCS_OUT(n)		(0x300F + ((n) * 0x100))
>   #define FAST_FLAGS(n)		(0x401C + ((n) * 0x100))
>   #define RX_AFE_ATT_IDAC(n)	(0x4000 + ((n) * 0x100))
>   #define RX_AFE_CTLE_IDAC(n)	(0x4001 + ((n) * 0x100))

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

