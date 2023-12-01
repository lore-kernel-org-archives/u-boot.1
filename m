Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15934C07E97
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 09:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C5987483;
	Fri,  1 Dec 2023 10:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z5lc709k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAF087600; Fri,  1 Dec 2023 10:30:41 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E5286F50
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 10:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33319741ba0so1680148f8f.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423038; x=1702027838; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9fH5bWiftZ9QspqGEkIyW3d9T+sL7fUan4i22kM/Pyo=;
 b=z5lc709koMbOj6tzdckMNC5VozeO+T0dUaTUqEFjJuxtfs/49N0X1Bo8t9vX4xbdt7
 4dWFlUU77plpOkpPScuYEg9QtQCaf8SvwFZWzITM9UOW06jVrh8rbCxnr/RJLnm/9Kji
 CTbZXKPvNtM0OUuaVBEGKGH5zyX6Rohd/vWSdgC5QUXPiqFEmOc/y7YKLhLbppiVEi8r
 V1uMQ2544PPymknLswywyr1NDI0ZNkotNxLdNvzkEE1mT+EmC0tvd260JN7bxVKSErP1
 pv9iKWvd6/6MhkRkuwGI+FWc8GUJbk5eG4LXRil1H4PqO/Zpf9Rzgp6x06Pp7zifsmuU
 o4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423038; x=1702027838;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9fH5bWiftZ9QspqGEkIyW3d9T+sL7fUan4i22kM/Pyo=;
 b=LiWT/pgUQWd1yqee6p9/UYZd7E9/HrksgooeXs3/ew4kYRJfgNl66Ho2New9+e2G0G
 cK+Mk1ajRRS1zIB92/JLuFJJDVknC04q2JKuRuqh6wWxDkbfDvPoCnV++nBRbsHUwFQj
 NQiuPkzqYb3QmRkkaEvraLTjkMGIha8/9I7qaGL4P+/Mu1Ut4FQzgsFEXlCdk5Tgw4Zk
 0/0ON2eSXnbFULtLMktio2MJUOQLuwe0SpY8aTq/DV49l8LhzGweMUZghtE8VBjE9b7y
 teLsK3VFftfxgL5Eqv/nNEvr7H4O1xiybU73w9FLAojGPYQQ/gF5KoImJvxnd62V4+zr
 Rtzw==
X-Gm-Message-State: AOJu0Yycu79XLNTln0I0Gcn2TORIHUV7ord2JOp00GV5EBrMsPMYsrG+
 ZnPqfUAJyl1ewcHX0Mf9N5UPcw==
X-Google-Smtp-Source: AGHT+IEBXWsUZ3ZPb6HBBPh2JnYL5Qo9GDI8wgUtfkHUgYXDtyA2HIQMHEnoO5lQXlWVS+klgF6raA==
X-Received: by 2002:adf:e5c9:0:b0:333:2fd2:4b0e with SMTP id
 a9-20020adfe5c9000000b003332fd24b0emr595967wrn.138.1701423038040; 
 Fri, 01 Dec 2023 01:30:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:46dc:1c67:6d66:e21?
 ([2a01:e0a:982:cbb0:46dc:1c67:6d66:e21])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b00332cb846f21sm3695695wrm.27.2023.12.01.01.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:30:37 -0800 (PST)
Message-ID: <fc5a4ea9-6210-403c-9bcf-1ea5ece11c01@linaro.org>
Date: Fri, 1 Dec 2023 10:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 8/9] spmi: msm: fix register range names
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
 <20231130-b4-qcom-dt-compat-v5-8-41500e237ad0@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-8-41500e237ad0@linaro.org>
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

On 30/11/2023 21:22, Caleb Connolly wrote:
> The core and chnl register ranges were swapped on SDM845. Fix it, and
> fetch the register ranges by name instead of by index.
> 
> Drop the cosmetic "version" variable and clean up the debug logging.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/qcs404-evb.dts                |  7 +++--
>   arch/arm/dts/sdm845.dtsi                   |  2 +-
>   doc/device-tree-bindings/spmi/spmi-msm.txt | 26 -----------------
>   drivers/spmi/spmi-msm.c                    | 46 ++++++++++++------------------
>   4 files changed, 23 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
> index 3bb580ba4e17..cf41e5a33dbe 100644
> --- a/arch/arm/dts/qcs404-evb.dts
> +++ b/arch/arm/dts/qcs404-evb.dts
> @@ -362,9 +362,10 @@
>   
>   		spmi@200f000 {
>   			compatible = "qcom,spmi-pmic-arb";
> -			reg = <0x200f000 0x1000
> -			       0x2400000 0x400000
> -			       0x2c00000 0x400000>;
> +			reg = <0x200f000 0x001000>,
> +			      <0x2400000 0x800000>,
> +			      <0x2c00000 0x800000>;
> +			reg-names = "core", "chnls", "obsrvr";
>   			#address-cells = <0x1>;
>   			#size-cells = <0x1>;
>   
> diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
> index a26e9f411ee0..96c9749a52c0 100644
> --- a/arch/arm/dts/sdm845.dtsi
> +++ b/arch/arm/dts/sdm845.dtsi
> @@ -63,7 +63,7 @@
>   			reg = <0xc440000 0x1100>,
>   			      <0xc600000 0x2000000>,
>   			      <0xe600000 0x100000>;
> -			reg-names = "cnfg", "core", "obsrvr";
> +			reg-names = "core", "chnls", "obsrvr";
>   			#address-cells = <0x1>;
>   			#size-cells = <0x1>;
>   
> diff --git a/doc/device-tree-bindings/spmi/spmi-msm.txt b/doc/device-tree-bindings/spmi/spmi-msm.txt
> deleted file mode 100644
> index ae47673b768b..000000000000
> --- a/doc/device-tree-bindings/spmi/spmi-msm.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Qualcomm SPMI arbiter/bus driver
> -
> -This is bus driver for Qualcomm chips that use SPMI to communicate with PMICs.
> -
> -Required properties:
> -- compatible: "qcom,spmi-pmic-arb"
> -- reg: Register block adresses and sizes for various parts of device:
> -   1) PMIC arbiter channel mapping base (PMIC_ARB_REG_CHNLn)
> -   2) SPMI write command (master) registers (PMIC_ARB_CORE_SW_DEC_CHANNELS)
> -   3) SPMI read command (observer) registers (PMIC_ARB_CORE_REGISTERS_OBS)
> -
> -Optional properties (if not set by parent):
> -- #address-cells: 0x1 - childs slave ID address
> -- #size-cells: 0x1
> -
> -All PMICs should be placed as a child nodes of bus arbiter.
> -Automatic detection of childs is currently not supported.
> -
> -Example:
> -
> -spmi@200f000 {
> -	compatible = "qcom,spmi-pmic-arb";
> -	reg = <0x200f800 0x200 0x2400000 0x400000 0x2c00000 0x400000>;
> -	#address-cells = <0x1>;
> -	#size-cells = <0x1>;
> -};
> diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
> index 27a035c0a595..5fe8a70abca7 100644
> --- a/drivers/spmi/spmi-msm.c
> +++ b/drivers/spmi/spmi-msm.c
> @@ -70,7 +70,7 @@ enum pmic_arb_channel {
>   
>   struct msm_spmi_priv {
>   	phys_addr_t arb_chnl;  /* ARB channel mapping base */
> -	phys_addr_t spmi_core; /* SPMI core */
> +	phys_addr_t spmi_chnls; /* SPMI channels */
>   	phys_addr_t spmi_obs;  /* SPMI observer */
>   	/* SPMI channel map */
>   	uint8_t channel_map[SPMI_MAX_SLAVES][SPMI_MAX_PERIPH];
> @@ -95,10 +95,10 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
>   
>   	/* Disable IRQ mode for the current channel*/
>   	writel(0x0,
> -	       priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
> +	       priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
>   
>   	/* Write single byte */
> -	writel(val, priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
> +	writel(val, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
>   
>   	/* Prepare write command */
>   	reg |= SPMI_CMD_EXT_REG_WRITE_LONG << SPMI_CMD_OPCODE_SHIFT;
> @@ -113,12 +113,12 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
>   		ch_offset = SPMI_CH_OFFSET(channel);
>   
>   	/* Send write command */
> -	writel(reg, priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
> +	writel(reg, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
>   
>   	/* Wait till CMD DONE status */
>   	reg = 0;
>   	while (!reg) {
> -		reg = readl(priv->spmi_core + SPMI_CH_OFFSET(channel) +
> +		reg = readl(priv->spmi_chnls + SPMI_CH_OFFSET(channel) +
>   			    SPMI_REG_STATUS);
>   	}
>   
> @@ -186,47 +186,37 @@ static struct dm_spmi_ops msm_spmi_ops = {
>   static int msm_spmi_probe(struct udevice *dev)
>   {
>   	struct msm_spmi_priv *priv = dev_get_priv(dev);
> -	phys_addr_t config_addr;
> +	phys_addr_t core_addr;
>   	u32 hw_ver;
> -	u32 version;
>   	int i;
> -	int err;
>   
> -	config_addr = dev_read_addr_index(dev, 0);
> -	priv->spmi_core = dev_read_addr_index(dev, 1);
> -	priv->spmi_obs = dev_read_addr_index(dev, 2);
> +	core_addr = dev_read_addr_name(dev, "core");
> +	priv->spmi_chnls = dev_read_addr_name(dev, "chnls");
> +	priv->spmi_obs = dev_read_addr_name(dev, "obsrvr");
>   
> -	hw_ver = readl(config_addr + PMIC_ARB_VERSION);
> +	hw_ver = readl(core_addr + PMIC_ARB_VERSION);
>   
>   	if (hw_ver < PMIC_ARB_VERSION_V3_MIN) {
>   		priv->arb_ver = V2;
> -		version = 2;
> -		priv->arb_chnl = config_addr + APID_MAP_OFFSET_V1_V2_V3;
> +		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
>   	} else if (hw_ver < PMIC_ARB_VERSION_V5_MIN) {
>   		priv->arb_ver = V3;
> -		version = 3;
> -		priv->arb_chnl = config_addr + APID_MAP_OFFSET_V1_V2_V3;
> +		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
>   	} else {
>   		priv->arb_ver = V5;
> -		version = 5;
> -		priv->arb_chnl = config_addr + APID_MAP_OFFSET_V5;
> -
> -		if (err) {
> -			dev_err(dev, "could not read APID->PPID mapping table, rc= %d\n", err);
> -			return -1;
> -		}
> +		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
>   	}
>   
> -	dev_dbg(dev, "PMIC Arb Version-%d (0x%x)\n", version, hw_ver);
> +	dev_dbg(dev, "PMIC Arb Version-%d (%#x)\n", hw_ver >> 28, hw_ver);
>   
>   	if (priv->arb_chnl == FDT_ADDR_T_NONE ||
> -	    priv->spmi_core == FDT_ADDR_T_NONE ||
> +	    priv->spmi_chnls == FDT_ADDR_T_NONE ||
>   	    priv->spmi_obs == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
> -	dev_dbg(dev, "priv->arb_chnl address (%llu)\n", priv->arb_chnl);
> -	dev_dbg(dev, "priv->spmi_core address (%llu)\n", priv->spmi_core);
> -	dev_dbg(dev, "priv->spmi_obs address (%llu)\n", priv->spmi_obs);
> +	dev_dbg(dev, "priv->arb_chnl address (%#08llx)\n", priv->arb_chnl);
> +	dev_dbg(dev, "priv->spmi_chnls address (%#08llx)\n", priv->spmi_chnls);
> +	dev_dbg(dev, "priv->spmi_obs address (%#08llx)\n", priv->spmi_obs);
>   	/* Scan peripherals connected to each SPMI channel */
>   	for (i = 0; i < SPMI_MAX_PERIPH; i++) {
>   		uint32_t periph = readl(priv->arb_chnl + ARB_CHANNEL_OFFSET(i));
> 

Looks good:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
