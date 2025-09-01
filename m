Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE52ACA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 07:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5C1833AD;
	Mon,  1 Sep 2025 09:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jk60HuPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BA5833AD; Mon,  1 Sep 2025 09:56:28 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCF8831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 09:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b8b02dd14so4602105e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756713384; x=1757318184; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4IkkFhmsk5rz1xAmy9qL8t9MYPOp8fJNmTW3RhGYfz8=;
 b=jk60HuPl4qXQBt15ZUFhCfh+W5ZyUja1L+UEirBVhyurd7xzJ62mhA4L7Cx+zgY4Xl
 Tr0vLEj58Sr2CyF6mqLrvG1r8agAp3wkQhwcEc+7lTN9HSYpOZs26iwDUaC25VaLDpqj
 R2GZSByPqMR5MwqXFDO0089dpwjEcqe1XumGTl2DpERQGUA+k/sUnNNujTNsIYsV9KlP
 6Qrvs9zv64Tg9maooHzHExUUTXFfHDJmtb+SfLn56YCgFea9AaLiddCEbLrMF3DjbWyQ
 5O0LzgXW/G2XxDCUjsmcijSLruKxolhvqX4D0dMAMfVnp3WyLcEVCoHZ5K1Te9dZ3yue
 Qnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756713384; x=1757318184;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4IkkFhmsk5rz1xAmy9qL8t9MYPOp8fJNmTW3RhGYfz8=;
 b=QwuNYjgzYrfDRfqVB1ua7UlDKOVN4aJTNJ0K7k58mrr8yxdSDA8g+yyiae8AoyUJRV
 C0F7zzjXx9JTMbkXH6FsgHZ0l0Jpu8FGynYppFZpeifSOBkXGMd2LpWJJxS/rIwsvfG7
 b81GY9SHHq+HYC+JF+UDBKku1IuhTudzH6otcIp7qrZVE9P8w4bZj6h7lwlpLnzjPkDa
 mgifZ5eyqk2ibMcbh3WGcpJAHHkr98hc/B+nCxcTZiWCeuBE+gPBo7bHZb4cuO3vr+h9
 JyP1CyR7YQkL7X/iZ1hOQau+ZvDjSO/sTQMA3pQSaVdXGtbh3uQPphMUWArWpiTnBiCj
 M5AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW954cDLdxxJHfHzVviS/vYgG/iM8rtfWTymLRgQSZ+q/yv8JuNAATjI0CAo6r6PtYKRpx63z0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy77OA/wdK4bQstRvhpl5n8Anqzvv0AxmqZzDjfp/RIlzGyLoFM
 NgVKjipkGouaokDGwCC0PCWWjZXfvaF92CV9UV/sL40srMmqdql5hTFiH4ubCbH8vz0=
X-Gm-Gg: ASbGncsxWgDxS2Yfr/x6JGaHg+Q6m22UTqFKAlZNl2bGloUHQDO+svT29cZTMBSXkMI
 qD2O+HMhwDHax4o8xei2EPLzMYBlQqI2qJEcdYVsz10Dj7lcGpo3USjknKvg0W+eoLOF9Z95DS/
 nOPVwUHAAS+ocK3Ygp9wuNL84PynhsGb7qJrN/3iN8okVLpZMo8X1eF6ukXtFgJTraNqEQLqF1S
 OqW9xKUdBD28BZ5hD5cX9OjO+KFk9mI6pRcRIgpry9l3cIKYCNIqbaX9C2IHFlhycPfhe+J0WbL
 wIrQJ195EaEfV7T5FcUXhg7a2bnKfJOAlqdLiYIq/RxBwIy4SYOXGcrGv8dcJcMuP8cs1QYE4/8
 +ESezWfDQqMEEX09AwKRuwscdT5vdEMrgGDKp9XMzx8WUnyb1eNmG9cDnsl+NPg2FsT5I2zpuPs
 yModg5UV4=
X-Google-Smtp-Source: AGHT+IFL9juVnCZ7OPFP1T5K2rE6ggdFwiKJbRsGqqO0dxyKp1SnCc+R3WFjg3Bdk1bykjxnwG/xAw==
X-Received: by 2002:a05:600c:1387:b0:45b:615c:cd2 with SMTP id
 5b1f17b1804b1-45b85525da3mr64841745e9.8.1756713384320; 
 Mon, 01 Sep 2025 00:56:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a?
 ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b814da51esm124755005e9.8.2025.09.01.00.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:56:23 -0700 (PDT)
Message-ID: <9223b2c7-5318-4f31-9df6-61a0463bc357@linaro.org>
Date: Mon, 1 Sep 2025 09:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] phy: qcom-qmp-ufs: Import SM7150 tables from Linux
To: Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250831004602.699953-1-adrian@mainlining.org>
 <20250831004602.699953-4-adrian@mainlining.org>
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
In-Reply-To: <20250831004602.699953-4-adrian@mainlining.org>
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

On 31/08/2025 02:46, Jens Reidel wrote:
> From: Danila Tikhonov <danila@jiaxyga.com>
> 
> Import the init sequence for the UFS on SM7150.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Jens Reidel <adrian@mainlining.org>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 61 +++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index f3c606847fb..a2a0e226f0c 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -221,6 +221,36 @@ static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_rx[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
>   };
>   
> +static const struct qmp_ufs_init_tbl sm7150_ufsphy_rx[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
> +};
> +
> +static const struct qmp_ufs_init_tbl sm7150_ufsphy_pcs[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL1, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xff),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> +};
> +
>   static const struct qmp_ufs_init_tbl sm8150_ufsphy_serdes[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
>   	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
> @@ -1018,6 +1048,36 @@ static const struct qmp_ufs_cfg sm8150_ufsphy_cfg = {
>   	.no_pcs_sw_reset	= false,
>   };
>   
> +static const struct qmp_ufs_cfg sm7150_ufsphy_cfg = {
> +	.lanes			= 1,
> +
> +	.offsets		= &qmp_ufs_offsets,
> +
> +	.tbls = {
> +		.serdes		= sdm845_ufsphy_serdes,
> +		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
> +		.tx		= sdm845_ufsphy_tx,
> +		.tx_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
> +		.rx		= sm7150_ufsphy_rx,
> +		.rx_num		= ARRAY_SIZE(sm7150_ufsphy_rx),
> +		.pcs		= sm7150_ufsphy_pcs,
> +		.pcs_num	= ARRAY_SIZE(sm7150_ufsphy_pcs),
> +	},
> +	.tbls_hs_b = {
> +		.serdes		= sdm845_ufsphy_hs_b_serdes,
> +		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
> +	},
> +	.clk_list		= sdm845_ufs_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> +	.vreg_list		= qmp_ufs_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
> +	.reset_list		= qmp_ufs_reset_l,
> +	.num_resets		= ARRAY_SIZE(qmp_ufs_reset_l),
> +	.regs			= ufsphy_v3_regs_layout,
> +
> +	.no_pcs_sw_reset	= true,
> +};
> +
>   static const struct qmp_ufs_cfg sm8250_ufsphy_cfg = {
>   	.lanes			= 2,
>   
> @@ -1593,6 +1653,7 @@ static struct phy_ops qmp_ufs_ops = {
>   static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
>   	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
> +	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
>   	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
