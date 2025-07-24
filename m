Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB86C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311CE83631;
	Thu, 24 Jul 2025 10:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ommVP1mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46DB8365C; Thu, 24 Jul 2025 10:22:28 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C46983616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-454f428038eso6035625e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753345346; x=1753950146; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bAu1Xy55dpNFTmBGpSKLq4dHmGAjzxl7ysAc4eZM+w4=;
 b=ommVP1mcTszCLHlTJeXPKE3OGTzP2pl4aJL3umSpjW6mMzFwqwvN99HTRbdjze7yIb
 Plp3SQVKVpJPtr2IL/xbPMrXc0rPjlOpHfVnCqfzI2EykzMxEodZ1AfEmdm/Fuj1A8BA
 oJylh0rVwk37Nv79AjIyeJieg99bK+6mYUfw5LcygfI0662ABOa92VRXgMh7rwRh8svw
 YZ+c8NUuNGud5WDsykD/M9DznPkZiw9/dS8BocBhLDitwvi4oK1gxCzPtz/hH2DcPaZG
 KxkMFYJDBKWc/spBjSvPTSA7Yc0hx89wd4veIedZvzH8/oyjbmeCEN6ETB27+WgT6jqD
 TPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753345346; x=1753950146;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bAu1Xy55dpNFTmBGpSKLq4dHmGAjzxl7ysAc4eZM+w4=;
 b=kKmnh+jtYp/Y7dKFBVB/dxUeCKHbkHFIG3CTSkzrHFaMh2e4+InsppFpa7/cN1kONr
 5juIT1SsJX+CCtXX/sp0xACSD2+rNw/N/XH6e5yRgUWlZWV06MBh6H99EZ2cOI8r9pOs
 U5JBu+JhrD8SFfMD0B3j252376DHTxXAwrDzHQGjKFkf9s8CtK4VWVTrZxGUjfhljOzo
 pd0LjtLpfqxLp4fssrivCxnPRefHDBjgcSZEMngjjPDl51q9yDK2/K8kur51Ect4K1Ha
 arjkDpQH84zqyDalc1fojV0+5PJMOB48pwkB1dMDdx25IzS2gukbkMX0aNFyh+a9sKwS
 iiSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoEkczvO8vh1NdTDn9Q2DFY6n8e6L/W7cjyFc0i6RnYKwB99WA46mPhkAYN0ieHH2EeLtCZZY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5TpZBSVAUN5mBLA0U0B1s5LB1BKldFF/PELIdMXML2yt50oBV
 +9c1Nu5hc73z84wGWqAvfrMUXKTbyTshCQyZum9B4OQ8u2Op8EtxITOLAARjr3r4lMmleVK1b98
 8ZwTG
X-Gm-Gg: ASbGncvcehx9Dz8p9W+zIwAdR0HdLKatrp4YUZPIC7nt9CbA9s/sgOwGlg2eI56Z13N
 WFmfN/y/YDBnG1C3JuITJEeRC04EKJohAwd2DSX7KjZx3a/hdd1+kW30X887FFkRgPJH6GZ9rQl
 nPSVsUTrdpxWo8P5BGZne1Xvr/88LL0wDD9iK6S5Ea0wLlUxP+YoIxnG3xlTa/W82wFxHs6dT7n
 VyCfb7L1VRI6gWA/fhH/UMStrrFWr60P4L14TenNIc7OfgwvvLwviaXqCxVvGjVyvVVWTWZmoRV
 mlZb6sWCEZlrjhiWjRtbPr42ksHAUHUBWIRxIhG8D0AyXuRq4LShcZ/t+Udb1q7KkLg0gW+lpwh
 NFxUjMRfCIhs1gRjPGDuPl3sGyQ5UnTBCXSb2tv4/uTs=
X-Google-Smtp-Source: AGHT+IFtgxusIce/bGO0wXfSwSL4OJ+9I5y+4XfKpkAeb4LgfIdIyqub2JXXeVkqgDg7nXTIEhLbqA==
X-Received: by 2002:a05:600c:4f4f:b0:456:1006:5418 with SMTP id
 5b1f17b1804b1-4586987e38bmr42945365e9.13.1753345345758; 
 Thu, 24 Jul 2025 01:22:25 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705376d2sm10796145e9.3.2025.07.24.01.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:22:25 -0700 (PDT)
Message-ID: <cb7c9a99-fd0c-4393-b6fb-89415e2941f4@linaro.org>
Date: Thu, 24 Jul 2025 10:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] ufs: amd-versal2: Configure RMMI and M-PHY registers for
 HS mode
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20250724044402.260149-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 24/07/2025 06:44, Venkatesh Yadav Abbarapu wrote:
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

Looks good !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
