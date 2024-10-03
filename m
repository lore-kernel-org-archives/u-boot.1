Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51216CF8573
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 10:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B4D88B1F;
	Thu,  3 Oct 2024 12:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bGLxdYRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC4F88B1F; Thu,  3 Oct 2024 12:13:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F283488B63
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 12:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so6565575e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727950377; x=1728555177; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tn/7Z2Z3ze5DyJ7TCggL2shYbKfTEapD/rl0Xw5TkHA=;
 b=bGLxdYRNdRk7HlEUD7rKH1E/EcmunWlTPkuLrrvIzCkbej4Ui22iBmzwpo+ZjdadGF
 DZ6rFXoIAP7TjGGIbm4KL6uzMyP3EJSgCvZF85OLwRQafxxhxQrJNTZzwza3oYJ6Rf1e
 R3wfuu7oRriRKZ9gWhyVq9MqA4FZqc0fDmK13PwNZeXUXXKLzbKOyfquqPsf+iuUE4o/
 /izT4yCJVlOhrvBWh1roU3Uxs//ymH7cjZVLM3tfKYywHQxDi7WEmZDPTb8YcK+xwDi7
 fGeF39WtkCp93tGeFhNPK0NHrjbm/LwGfzkbtnbSFpG0TWiQQBsVosG1DzuSf6PBHHRy
 ZmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727950377; x=1728555177;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tn/7Z2Z3ze5DyJ7TCggL2shYbKfTEapD/rl0Xw5TkHA=;
 b=Z57vigdCQiI69exoV1t/c7Cfd7grLtEJyLiZaNL5APw8iQGUNyuBsNVpTl/wz4MLAa
 y2xsP8gh61d232jas9ErHzgY6yADtxS5pVwklR981d/C6T0XwLHAtQsvvfVB+SnTJuag
 TmmszK1QRkEjOBM9A28cNxoi+VRwXzAVJhVEkRME9AvaBsoZ1SU3qjnwij74PcukQ5Im
 17L7kaqbVEOn/RbM04zwiPcmWOJZpFPzKNmx0KiH5e35o5f7D0I3iVbTJrTRQco5LvcO
 0whmxIPg68NmxtbHOtqqR3AAPLKNZpIeAlIiyYhNBb6ffDE9nQt6szUp8y4OExiBuqD/
 ccCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURmPwERkNO21yqcNZ32bI4n8NSu8mzuuuTJI4vEKcb3K/670qr9X0RfkLK/d1782dBHSqYQTU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+dx8I8NicTSE/lgDCQdyic7lk+XwhPPW+tQ+ouXVVl3LcxpB/
 ERSswU0pgX7WoaNvfxVV7XrRyZTy5Sh5UUtlVI55xwEsh/u7TsGrDAk4xu1wSdY=
X-Google-Smtp-Source: AGHT+IHZrLjirZUqDOl5JN8ncWplAVgkJd6cMTaCQBsU49JXnO55F0n2yBMBgw6SzpZ24FFuPqRRTw==
X-Received: by 2002:a05:600c:3d97:b0:42c:87dc:85e7 with SMTP id
 5b1f17b1804b1-42f7a12b66cmr37961535e9.18.1727950377341; 
 Thu, 03 Oct 2024 03:12:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e534:c027:e113:29a1?
 ([2a01:e0a:982:cbb0:e534:c027:e113:29a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a02eb07sm40802605e9.41.2024.10.03.03.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 03:12:56 -0700 (PDT)
Message-ID: <f6890962-e545-4968-b2cd-f42483733e90@linaro.org>
Date: Thu, 3 Oct 2024 12:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy: qcom: Add SM8150 to QMP UFS PHY driver
To: Julius Lehmann <lehmanju@devpi.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241002-sm8150-qmp-phy-v1-1-719695ad2f1e@devpi.de>
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
In-Reply-To: <20241002-sm8150-qmp-phy-v1-1-719695ad2f1e@devpi.de>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 02/10/2024 20:52, Julius Lehmann wrote:
> Copy PHY tables over from Linux to support SM8150
> 
> ---
> As the title suggests, this is really just a simple patch to add Qualcomm's SM8150 SoC to the QMP UFS PHY driver. It has been tested to work with https://lore.kernel.org/u-boot/20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org/ on a Xiaomi Mi Pad 5.
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 62 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 8908a34df548340556d92ac8ca488dbbbd0e293a..11f92b8261aff48dddb63cd8de31db3716a45fb4 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -189,6 +189,29 @@ static const struct qmp_ufs_init_tbl sdm845_ufsphy_pcs[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>   };
>   
> +static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_tx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x75),
> +};
> +
> +static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x6c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
> +};
> +
>   static const struct qmp_ufs_init_tbl sm8150_ufsphy_serdes[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
>   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
> @@ -623,6 +646,44 @@ static const struct qmp_ufs_cfg sdm845_ufsphy_cfg = {
>   	.no_pcs_sw_reset	= true,
>   };
>   
> +static const struct qmp_ufs_cfg sm8150_ufsphy_cfg = {
> +	.lanes			= 2,
> +
> +	.offsets		= &qmp_ufs_offsets,
> +
> +	.tbls = {
> +		.serdes		= sm8150_ufsphy_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
> +		.tx		= sm8150_ufsphy_tx,
> +		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
> +		.rx		= sm8150_ufsphy_rx,
> +		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
> +		.pcs		= sm8150_ufsphy_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
> +	},
> +	.tbls_hs_b = {
> +		.serdes		= sm8150_ufsphy_hs_b_serdes,
> +		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
> +	},
> +	.tbls_hs_g4 = {
> +		.tx		= sm8150_ufsphy_hs_g4_tx,
> +		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
> +		.rx		= sm8150_ufsphy_hs_g4_rx,
> +		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
> +		.pcs		= sm8150_ufsphy_hs_g4_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
> +	},
> +	.clk_list		= sdm845_ufs_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> +	.vreg_list		= qmp_ufs_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
> +	.reset_list		= qmp_ufs_reset_l,
> +	.num_resets		= ARRAY_SIZE(qmp_ufs_reset_l),
> +	.regs			= ufsphy_v4_regs_layout,
> +
> +	.no_pcs_sw_reset	= false,
> +};
> +
>   static const struct qmp_ufs_cfg sm8250_ufsphy_cfg = {
>   	.lanes			= 2,
>   
> @@ -1100,6 +1161,7 @@ static struct phy_ops qmp_ufs_ops = {
>   
>   static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
> +	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
> 
> ---
> base-commit: 2d21dd440e052bb2c8ccc9fa3137ab40c8f87f14
> change-id: 20241002-sm8150-qmp-phy-ddb990d1a1bc
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
