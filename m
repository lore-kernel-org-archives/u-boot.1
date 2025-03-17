Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BB8C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8444810F5;
	Mon, 17 Mar 2025 15:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L+Z5OZDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00E3811DF; Mon, 17 Mar 2025 15:01:24 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D8D80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3965c995151so3013489f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742220082; x=1742824882; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=SiR000sdg384qcQQvicIb/eZQr4mUKe41ptibOyBBtE=;
 b=L+Z5OZDRjQYB75kf/bav+FAnHGD97L2gXi0Pis7tf+bnpqRhGqLdCMhrOgBxDb5Isd
 BHSRsksgeQ4yXqiyn1bkCtVwzFHUOI90oEsXx6HUr+4lC6Jgx+9B5Jp8s293LSi3S0rB
 iB8isanuvsM0xBZHZJHsAesNfyvPZPPJGzq7M0PSoJaG1G5eaoIBbndlDGiBto3NkfA7
 pRXeIXk7dys8pPb0zwyliQ6W955wIxsQzaEF6ezRfm3IvMumoZh+3vyosnuoh49qgIiP
 Uln22S8kBEAInH1rribSTtqkdjeFAjeSL8z7Jqptk6FDeAke7iunYlbwM8Pg3FjGRf4g
 mr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220082; x=1742824882;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SiR000sdg384qcQQvicIb/eZQr4mUKe41ptibOyBBtE=;
 b=AeJL1wqxWNSNsGJC2EOtHTpCOGyF92CPoAjFsEjGr+ruew0WXu2jcDsS/psjCqKVVv
 m1KPOIQEU01LkFRUZIi9WRM4UU3d3QmGR+hgQfTINkgQTivQLsosNnMm97IUd99s6dIu
 J5+Zat7Hbkeak4hxSwI4UEhI7eAAYaHBq8coR2tqrn18Ns9DWRfC+9qYRVpVJKJ5kC4M
 H5A7+gDhPIfb54fQJtVGb7IY9lM/I8U4bXveDIvnBWBeO6mGPouPVE5jjU6BiH0of5NQ
 sDw0HAbyQW2D/u86/BawMDicO0UDmQxD061BYrI3p78pydwveLZbuRs0cDnTVJecPi2S
 dd8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMnkHufM910jQrnhSaK4HJDSbKqpepED/T9jhKGKMOJSvMp0fM9MDQFx+TakDqnN/4ONvoKYw=@lists.denx.de
X-Gm-Message-State: AOJu0YzZWF2HswxYwunr2tC7wxjB2Z1rV9GwO47MFfBqaF7Oksy0UPGJ
 NqND40KUs1Vq482H/rdjK0iSHe4wueAIfk3/P64ORtmLsGwpfH9wznb4o2g/ZwE=
X-Gm-Gg: ASbGncvgeYB8tefuqgfp7sIpDVL0QgUAZVooIBJIrj8o+r9COJmldhsBKBhgCXMacrl
 qi5Z7fTXfhMH23nLLyb4F+/2wH+wMvqU55M9mBucBEeiUnXIFmuSY92Q8SBkhhm9wSVa89LUsE3
 pagse6UJ1XW2EqSs8LrCjx9xrt/tRkoo9PKBxwNBz5aIpq1UwLe0BFFDF2WAH9A/5dZ3/CM/3T7
 uY2ZIBYShtUFvt9kzrmCbJjW2jNF2Xkx/3tQYVmNTSYW3IPCmC7GclcOwzzH40VDj8j2T1+gy49
 CKZ0tJS82kjYZ3pBHzzoc2fHnyPMn7eWg1KwMOjt/iOCz9kRt9i4BcFXD3MzpJ6dfJN/kNlTOR1
 gxLfnPxgz7oBDg3vbLg5Zaw==
X-Google-Smtp-Source: AGHT+IHiX5Nv1DwoiFOQQTKXbQHffwzno+fCw2PQ4go/0N/hIuipP2RKhfo1T5LN89yzkYEkjEyIFg==
X-Received: by 2002:a5d:59ab:0:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-3971a3975dcmr13906222f8f.0.1742220081735; 
 Mon, 17 Mar 2025 07:01:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a96sm15319678f8f.69.2025.03.17.07.01.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 07:01:21 -0700 (PDT)
Message-ID: <142fdabb-894b-4760-a89f-e4661a14f49c@linaro.org>
Date: Mon, 17 Mar 2025 15:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] clk/qcom: bubble up qcom_gate_clk_en() errors
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
 <20250314-sc7280-more-clocks-v1-1-ead54487c38e@linaro.org>
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
In-Reply-To: <20250314-sc7280-more-clocks-v1-1-ead54487c38e@linaro.org>
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

On 14/03/2025 16:31, Caleb Connolly wrote:
> If we try to enable a gate clock that doesn't exist, we used to just
> fail silently. This may make sense for early bringup of some core
> peripherals that we know are already enabled, but it only makes
> debugging missing clocks more difficult.
> 
> Bubble up errors now that qcom_gate_clk_en() can return an error code to
> catch any still-missing clocks and make it easier to find missing ones
> as more complicated peripherals are enabled.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-apq8016.c  |  3 +--
>   drivers/clk/qcom/clock-qcm2290.c  |  4 +---
>   drivers/clk/qcom/clock-qcom.h     | 12 +++++++++---
>   drivers/clk/qcom/clock-sa8775p.c  |  4 +---
>   drivers/clk/qcom/clock-sc7280.c   |  4 +---
>   drivers/clk/qcom/clock-sdm845.c   |  4 +---
>   drivers/clk/qcom/clock-sm6115.c   |  4 +---
>   drivers/clk/qcom/clock-sm8150.c   |  4 +---
>   drivers/clk/qcom/clock-sm8250.c   |  4 +---
>   drivers/clk/qcom/clock-sm8550.c   |  4 +---
>   drivers/clk/qcom/clock-sm8650.c   |  4 +---
>   drivers/clk/qcom/clock-x1e80100.c |  4 +---
>   12 files changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index b5def55dbc2ac671130624dec56592288a0ceb3d..3bafbfea3b6f5bf903f6f5a593e1f062bd40c53a 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -144,11 +144,10 @@ static int apq8016_clk_enable(struct clk *clk)
>   		return 0;
>   	}
>   
>   	debug("%s: clk %s\n", __func__, apq8016_clks[clk->id].name);
> -	qcom_gate_clk_en(priv, clk->id);
>   
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static struct msm_clk_data apq8016_clk_data = {
>   	.set_rate = apq8016_clk_set_rate,
> diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
> index c78705cb8cf19a75508f5a3a0fbc7c04d750d273..1326b770c3ebd723120de4b6657aafac726023d6 100644
> --- a/drivers/clk/qcom/clock-qcm2290.c
> +++ b/drivers/clk/qcom/clock-qcm2290.c
> @@ -133,11 +133,9 @@ static int qcm2290_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map qcm2290_gcc_resets[] = {
>   	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index ff336dea39cf5cbe35f37f93669285897ba185a4..e9eb659f3ed37522a71e04e9418f48091bf9a0aa 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -6,8 +6,9 @@
>   #define _CLOCK_QCOM_H
>   
>   #include <asm/io.h>
>   #include <linux/bitfield.h>
> +#include <errno.h>
>   
>   #define CFG_CLK_SRC_CXO   (0 << 8)
>   #define CFG_CLK_SRC_GPLL0 (1 << 8)
>   #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
> @@ -104,15 +105,20 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, uint32_t cmd_rcgr,
>   void clk_rcg_set_rate(phys_addr_t base, uint32_t cmd_rcgr, int div,
>   		      int source);
>   void clk_phy_mux_enable(phys_addr_t base, uint32_t cmd_rcgr, bool enabled);
>   
> -static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
> +static inline int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
>   {
>   	u32 val;
> -	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0)
> -		return;
> +	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
> +		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
> +			priv->base, id);
> +		return -ENOENT;
> +	}
>   
>   	val = readl(priv->base + priv->data->clks[id].reg);
>   	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
> +
> +	return 0;
>   }
>   
>   #endif
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index e31f24ed4f0ca989f20d1eadcff5f24f173455fa..527cecf5c8282a7c2e16740e6520241a230bca73 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -72,11 +72,9 @@ static int sa8775p_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sa8775p_gcc_resets[] = {
>   	[GCC_CAMERA_BCR] = { 0x32000 },
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 5d343f120519da02d8ec3e269d348ab46cde70a8..8ffd1f43f23e51140c7822f0f523fdfd8ab1de7a 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -72,11 +72,9 @@ static int sc7280_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sc7280_gcc_resets[] = {
>   	[GCC_PCIE_0_BCR] = { 0x6b000 },
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index adffb0cb2402a6b27e0e998af2f121c519301820..6a0bf16ba2dce7f922adf971817399c71ac35586 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -161,11 +161,9 @@ static int sdm845_clk_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sdm845_gcc_resets[] = {
>   	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
> diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/clock-sm6115.c
> index 9057dfe0bb1873e9edcfd8c01c0a81b6b8b4ca2c..17c2e5617580aae9ad3f0d802bbc6882c2c81043 100644
> --- a/drivers/clk/qcom/clock-sm6115.c
> +++ b/drivers/clk/qcom/clock-sm6115.c
> @@ -145,11 +145,9 @@ static int sm6115_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_CLKREF_CLK);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sm6115_gcc_resets[] = {
>   	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
> diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
> index 88f2e678f43cfcc9b80917f26c211049ebca6f9d..7dd0d56eb43031e893541e4031cbda2e92ae402d 100644
> --- a/drivers/clk/qcom/clock-sm8150.c
> +++ b/drivers/clk/qcom/clock-sm8150.c
> @@ -242,11 +242,9 @@ static int sm8150_clk_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
>   		break;
>   	};
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sm8150_gcc_resets[] = {
>   	[GCC_EMAC_BCR] = { 0x6000 },
> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
> index e322a923a5c048769dd5134c6c24e16bb74e7317..26396847d85964d5056cf9af62b8bc89be34dc43 100644
> --- a/drivers/clk/qcom/clock-sm8250.c
> +++ b/drivers/clk/qcom/clock-sm8250.c
> @@ -194,11 +194,9 @@ static int sm8250_enable(struct clk *clk)
>   		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sm8250_gcc_resets[] = {
>   	[GCC_GPU_BCR] = { 0x71000 },
> diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
> index 62b5a409e8e08243ad53a0bc58af1c7754a3d950..7c06489b9c4df9ce94fa9b44a762c10133377423 100644
> --- a/drivers/clk/qcom/clock-sm8550.c
> +++ b/drivers/clk/qcom/clock-sm8550.c
> @@ -219,11 +219,9 @@ static int sm8550_enable(struct clk *clk)
>   		clk_phy_mux_enable(priv->base, 0x8d078, true);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sm8550_gcc_resets[] = {
>   	[GCC_CAMERA_BCR] = { 0x26000 },
> diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
> index 9baaecb571f6c575c0e7c48d66214c1331b6642f..364454644a699c495479b3099f590562c415ce82 100644
> --- a/drivers/clk/qcom/clock-sm8650.c
> +++ b/drivers/clk/qcom/clock-sm8650.c
> @@ -216,11 +216,9 @@ static int sm8650_enable(struct clk *clk)
>   		clk_phy_mux_enable(priv->base, 0x8d078, true);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map sm8650_gcc_resets[] = {
>   	[GCC_CAMERA_BCR] = { 0x26000 },
> diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
> index bd9c6ed1c8a0b4ca0b5164d849efa5c0755c1e2e..542d6248d658d2921ef18877c70389549c471ab8 100644
> --- a/drivers/clk/qcom/clock-x1e80100.c
> +++ b/drivers/clk/qcom/clock-x1e80100.c
> @@ -173,11 +173,9 @@ static int x1e80100_enable(struct clk *clk)
>   		clk_phy_mux_enable(priv->base, 0x31088, true);
>   		break;
>   	}
>   
> -	qcom_gate_clk_en(priv, clk->id);
> -
> -	return 0;
> +	return qcom_gate_clk_en(priv, clk->id);
>   }
>   
>   static const struct qcom_reset_map x1e80100_gcc_resets[] = {
>   	[GCC_AV1E_BCR] = { 0x4a000 },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
