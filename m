Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BF3CEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C7C83CD2;
	Tue, 18 Nov 2025 09:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R6MKu025";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D7D83CD3; Tue, 18 Nov 2025 09:07:25 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903A583CCF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so2908983f8f.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763453243; x=1764058043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=pPU/7n/vP335iX0v7hEBDHWKeVxqEZjpZBXOtyNQ1mY=;
 b=R6MKu025WSekeDhsx7B17F62iGpPj3ld5S2dODeWjftxE8SHnNIgW3WcUVT3Chdj2C
 XOp+LBgm50XpLFE079ljFsL+Xk3SoqyGxRI6i4VKA/1fl6n+vnfnoOZZHAxoqdxHKKBN
 T6RRPuiNcFHbd0FGA38VAgEllwizov5GCghmnpe5saCFDTheWe+6uWbNrLiv2MBr8BH/
 5t0668Hq24EZ1du8rsrgvWeh6Liy4EfbTc0FFr3etEKTgLPeg1DY7zNcQ86uzI5U5/IY
 tineow1BX2pyfoCEJIRDs7SN77M8bHGLeiPay+W86tywf06MRemik8rReFb3V10O0JkF
 5bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763453243; x=1764058043;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPU/7n/vP335iX0v7hEBDHWKeVxqEZjpZBXOtyNQ1mY=;
 b=O0fzzkd5vZlKGrl5/HciulaEb0mOAG9/h8FOUJm60Q85CQYrc8fb3bJgv22cgalxGl
 LGQkxK6evwafvYmIuXQOu6Dn9lgpBPJoCmpP9JVr1txOlAVk0pmZnIMOSF73kM/QtmWw
 +p/1dcAfy51msMPaojaaCnm15iXM955D+E6OcSa44K/z+uRRExR9U7VoJii74IdCg8CC
 46GFjkeLyQg3Yuggq3JvuE0ue7ORs1LHyS5etS+n1XffE8wvVcyavSpGJYDzfknD5NWo
 8DkV1+XzZJ+kvtvG+e71V/6jOvR3R8Mt+CO7ohcHAzFUk4Uk7Be+AvMRDDqOd+9mzRMJ
 i6iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/RsiF3vGmeQKeUtUo5Jsnhg8qSvWIevu4rtyLznkIXa/bxnx4czM7s8/3c27mR6TSjUlx/UI=@lists.denx.de
X-Gm-Message-State: AOJu0YypBEH5fcSr7hXpjchZWfnh+epfxnS4w9JDTXOGKVzCBksYHVQU
 JO0tZj/SBhfyn8PB3JYkjdGUzJMoEKgRBEuR7QAnHXOjMDrXqGIqOQAxO1nLe3Qm4y0=
X-Gm-Gg: ASbGncva7yK87Se0Vwb9uPqE1SFxLMsByl3ZZmZGDywYSNefSTd9PmEo2m+DM47v0X3
 ncWbeiiEqdurgvs6kRnmFIgcwRMfGX+AZhCVSmC51q103SWljV5KBFEKYf3Anzz2WvwCee9ZFSV
 z6JWVDaQbJKNqxDsGjUyPXQ654sMj5ucqcblfl5dziiDPma4lia5hRw+qIs+vAx7pX5WDbTfaAx
 p9+WhB9Pz6g1N0X1EUKsTpqvB2so3ZCG4nRyPxgZqwFtxvUWuyFjbsDP/7YgVd3wLutV9VqjvXi
 c8FIiv4TqWe2j14m5F68sWJH/yH+hNN1l1bsFnLDKRd8lnqfIs1HG+iIvV+aWa3/3q64U6BZHSc
 x6f/aSX4jLrFmKisImkD2czHG4VdQ3UjleUjf1vK0eepwQ2itJMxCS0TS+HKYR3j1o4oVC0b51K
 2oDO+bjthJv3dw7ua9bUBMsTjTezPB14OmHIKfBa2bSNGKyi3ZsBdA3Vn0lVQACLJKdAB7XK6Cu
 xMJiaAQXAwM
X-Google-Smtp-Source: AGHT+IHu87TNJ5A6ipmqVXRy+JrMtkl/GHcBtjFFngrJON6bWdn1SGip/w9VaVbp8u8lBFEu/Sbaag==
X-Received: by 2002:a05:6000:26c2:b0:42b:487c:d7cb with SMTP id
 ffacd0b85a97d-42b59367903mr13616236f8f.34.1763453242813; 
 Tue, 18 Nov 2025 00:07:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:366e:5264:fffe:1c49?
 ([2a01:e0a:3d9:2080:366e:5264:fffe:1c49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17cbfsm30565413f8f.35.2025.11.18.00.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:07:22 -0800 (PST)
Message-ID: <f0612d68-d69f-41be-8f46-c7ae6060479a@linaro.org>
Date: Tue, 18 Nov 2025 09:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-4-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20251114063804.3835132-4-balaji.selvanathan@oss.qualcomm.com>
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

On 11/14/25 07:38, Balaji Selvanathan wrote:
> Add support for QCS615 QUSB2 PHY by introducing platform-specific
> initialization table and register layout. The implementation reuses
> the IPQ6018 register layout and defines QCS615-specific tuning
> parameters for proper USB PHY operation.
> 
> This change is based on the upstream Linux kernel implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qusb2.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/phy/qcom/phy-qcom-qusb2.c | 38 +++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> index d98f6108e69..a5d724eebd4 100644
> --- a/drivers/phy/qcom/phy-qcom-qusb2.c
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -176,6 +176,19 @@ static const unsigned int sm6115_regs_layout[] = {
>   	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
>   };
>   
> +static const unsigned int ipq6018_regs_layout[] = {
> +	[QUSB2PHY_PLL_STATUS] = 0x38,
> +	[QUSB2PHY_PORT_TUNE1] = 0x80,
> +	[QUSB2PHY_PORT_TUNE2] = 0x84,
> +	[QUSB2PHY_PORT_TUNE3] = 0x88,
> +	[QUSB2PHY_PORT_TUNE4] = 0x8C,
> +	[QUSB2PHY_PORT_TUNE5] = 0x90,
> +	[QUSB2PHY_PORT_TEST1] = 0x98,
> +	[QUSB2PHY_PORT_TEST2] = 0x9C,
> +	[QUSB2PHY_PORT_POWERDOWN] = 0xB4,
> +	[QUSB2PHY_INTR_CTRL] = 0xBC,
> +};
> +
>   static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
>   	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
>   	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
> @@ -189,6 +202,19 @@ static const struct qusb2_phy_init_tbl msm8996_init_tbl[] = {
>   	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>   };
>   
> +static const struct qusb2_phy_init_tbl qcs615_init_tbl[] = {
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xc8),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xb3),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xc0),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
> +};
> +
>   static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
>   	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
>   	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
> @@ -248,6 +274,16 @@ static const struct qusb2_phy_cfg sdm660_phy_cfg = {
>   	.autoresume_en = BIT(3),
>   };
>   
> +static const struct qusb2_phy_cfg qcs615_phy_cfg = {
> +	.tbl = qcs615_init_tbl,
> +	.tbl_num = ARRAY_SIZE(qcs615_init_tbl),
> +	.regs = ipq6018_regs_layout,
> +
> +	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +	.mask_core_ready = PLL_LOCKED,
> +	.autoresume_en = BIT(0),
> +};
> +
>   static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>   	.tbl = qusb2_v2_init_tbl,
>   	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
> @@ -453,6 +489,8 @@ static const struct udevice_id qusb2phy_ids[] = {
>   	{ .compatible = "qcom,qusb2-phy" },
>   	{ .compatible = "qcom,qcm2290-qusb2-phy",
>   	  .data = (ulong)&sm6115_phy_cfg },
> +	{ .compatible = "qcom,qcs615-qusb2-phy",
> +	  .data = (ulong)&qcs615_phy_cfg },
>   	{ .compatible = "qcom,sdm660-qusb2-phy",
>   	  .data = (ulong)&sdm660_phy_cfg },
>   	{ .compatible = "qcom,sm6115-qusb2-phy",

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
