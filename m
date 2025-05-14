Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5D7C3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 08:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCCD682162;
	Wed, 14 May 2025 10:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w/GethEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E541E81DD6; Wed, 14 May 2025 10:34:27 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CD482162
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 10:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a1f9791a4dso2939914f8f.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747211665; x=1747816465; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CJsOH89Gd3waajFCJY5MJMivMAUKw0xuXMa70ik3UZc=;
 b=w/GethEQHIkD0+RqpX4BeSuOLXiLwm39glhEGRLgrvnHjwdrO0Z77XnydYHmCqZxWU
 0nCRL98OJLNVle7oJveGFraFURS1AxFjBpPtJfIdyruHrmJrOmXNk5auBCE8O63oyMuu
 0lTNPSxwbZyasppuH3CIjy17O5Xw7RR1ZlKWym7QFzU5n1aJ3kBwFEqJBYJXECkIvfBB
 Ua7oz/LJofHK+f9+B9UmYbzqbQky8DdlvwNgtE7jAA62ut2psSKGjImXlFUUGxT8F+dY
 0ixkcjOgiwFGZs2W7HM9o5fkWokyveHMXDG+KQ7wVFST0vgUQFm5/Zw6j7l9hf1VDjdO
 UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747211665; x=1747816465;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CJsOH89Gd3waajFCJY5MJMivMAUKw0xuXMa70ik3UZc=;
 b=Qx5W3gQxe19vostI+LT2zBnwzt6ktNmvdGhps9AIKKoPbaCzuDypujCp/76rwB5IXF
 xgPT0CNVgNWPj3VyHCwZLmPqrO3qMYvfJQhmM77hizRdE+b5Crbla/u2BW0EHPdSUGA4
 bVGeQ3b5IsrqIHAIY0LusOsEIJ6D1O3J5qiYmN1vYdfnJqBHcBawZXsTLeNsuvja4MBE
 q/Pq8xgQzWsWSWmp4AM7Yo6JvNrMpZfqXpkuiSX9EYIGhOycMZgSZDZG1cdML6rcDwjw
 UA620il7KAx2QunPOrP1QxdckcKmg+ZmObsWV3AnC7Mw37bO17eNHRA5u9GYfOFTtxML
 +aBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUlk//pecln3/8UmYKjRQUD7rrda3IltNIiuJBEHdZxLVdjZTgXhnyM8CJ8HfEO1aNHkv5Zic=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhv7ZK8K/X3w4k4A8W2iueM+dL/9q08o6XReEZqq6uLuV++0wj
 U5r8sGl78yuiSrpx5c059zJ2OQsWbwzTBbSMJBuqExV0vDVM4KiySLr3VMjJyY4=
X-Gm-Gg: ASbGncv7Ku3DPyiXfmGkKscAAA1caYQtx2AVgiOVVRK9SDS1x074kFGqpwATsJGG41z
 Q1vu63xSi95WeeyN7uOIgs2QcopkxoPe7wrXEL0UnOgMIjShnMdJPdrfbdFS8U7ZfiK9eyi1N//
 TxzqkY86NyMnhmLdSEgp1CM+9ywjthELZj/1V2PIkG68J6nOQ5nC+duRDWLEpYMVEXOOhUhu2Ne
 DOr8ZPTnFs/6Rh1YLx5smFZMovlU/Y1Z7hFr1ukQxk5IZJOPz4/S78PO5ZFRcYI2D9CtwyuW3J0
 q+eetFkVaHC5vuSxgbcp+GW7TgfBI8jYbKgkopOFQKG0JBVl/LGs6sUerxka9DTupcM1WnlGuqH
 ZnK6/pfu1jPS+yHixHAzOdiM=
X-Google-Smtp-Source: AGHT+IGOYiQnDFE+hX7b3oW+qs4VR1aaIHfKBOwoDliaHVn0mTin7lXoicS3NNJXoBV4g+o2lIRO4A==
X-Received: by 2002:a05:6000:1865:b0:3a0:8c45:d30e with SMTP id
 ffacd0b85a97d-3a3496c35dbmr1701388f8f.35.1747211665329; 
 Wed, 14 May 2025 01:34:25 -0700 (PDT)
Received: from [10.61.1.139] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c047sm19730125e9.28.2025.05.14.01.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:34:25 -0700 (PDT)
Message-ID: <a4ed0616-f0db-4dfc-931d-40b2509f13fc@linaro.org>
Date: Wed, 14 May 2025 10:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/5] phy: qcom: Enable QMP UFS PHY driver for QCS615
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 sjg@chromium.org, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 lehmanju@devpi.de, bhupesh.linux@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
 <20250513110213.330495-3-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20250513110213.330495-3-aswin.murugan@oss.qualcomm.com>
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

On 13/05/2025 13:02, Aswin Murugan wrote:
> Enable QMP phy for QCS615, referenced from Linux.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 127 ++++++++++++++++++++++++++++
>   1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 449b9767778..175f55e8113 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -86,6 +86,12 @@ enum qphy_reg_layout {
>   	QPHY_LAYOUT_SIZE
>   };
>   
> +static const unsigned int ufsphy_v2_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_START_CTRL]		= QPHY_V2_PCS_UFS_PHY_START,
> +	[QPHY_PCS_READY_STATUS]		= QPHY_V2_PCS_UFS_READY_STATUS,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_UFS_POWER_DOWN_CONTROL,
> +};
> +
>   static const unsigned int ufsphy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_START_CTRL]		= QPHY_V3_PCS_UFS_PHY_START,
>   	[QPHY_PCS_READY_STATUS]		= QPHY_V3_PCS_UFS_READY_STATUS,
> @@ -715,6 +721,98 @@ static const struct qmp_ufs_init_tbl sc7280_ufsphy_hs_g4_rx[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x0f),
>   };
>   
> +static const struct qmp_ufs_init_tbl sm6115_ufsphy_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV_MODE1, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER2, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE1, 0x98),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE1, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE1, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE1, 0xd6),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE1, 0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE1, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_INITVAL1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_INITVAL2, 0x00),
> +};
> +
> +static const struct qmp_ufs_init_tbl sm6115_ufsphy_hs_b_serdes[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_ufs_init_tbl sm6115_ufsphy_tx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> +	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
> +};
> +
> +static const struct qmp_ufs_init_tbl sm6115_ufsphy_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_TERM_BW, 0x5b),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN1_LSB, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN1_MSB, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN2_LSB, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN2_MSB, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),
> +};
> +
> +static const struct qmp_ufs_init_tbl sm6115_ufsphy_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_PWM_GEAR_BAND, 0x15),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_MIN_STALL_NOCONFIG_TIME_CAP, 0x28),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_LARGE_AMP_POST_EMP_LVL, 0x12),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_TX_SMALL_AMP_POST_EMP_LVL, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V2_PCS_UFS_RX_MIN_HIBERN8_TIME, 0x9a), /* 8 us */
> +};
> +
>   struct qmp_ufs_offsets {
>   	u16 serdes;
>   	u16 pcs;
> @@ -1079,6 +1177,34 @@ static const struct qmp_ufs_cfg sa8775p_ufsphy_cfg = {
>   	.regs			= ufsphy_v5_regs_layout,
>   };
>   
> +static const struct qmp_ufs_cfg sm6115_ufsphy_cfg = {
> +	.lanes			= 1,
> +
> +	.offsets		= &qmp_ufs_offsets,
> +
> +	.tbls = {
> +		.serdes		= sm6115_ufsphy_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_serdes),
> +		.tx		= sm6115_ufsphy_tx,
> +		.tx_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
> +		.rx		= sm6115_ufsphy_rx,
> +		.rx_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
> +		.pcs		= sm6115_ufsphy_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm6115_ufsphy_pcs),
> +	},
> +	.tbls_hs_b = {
> +		.serdes		= sm6115_ufsphy_hs_b_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_hs_b_serdes),
> +	},
> +	.clk_list		= sdm845_ufs_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> +	.vreg_list		= qmp_ufs_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
> +	.regs			= ufsphy_v2_regs_layout,
> +
> +	.no_pcs_sw_reset	= true,
> +};
> +
>   static void qmp_ufs_configure_lane(void __iomem *base,
>   					const struct qmp_ufs_init_tbl tbl[],
>   					int num,
> @@ -1472,6 +1598,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
>   	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },
> +	{ .compatible = "qcom,qcs615-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
