Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0B7C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849E182B20;
	Tue, 17 Jun 2025 10:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ca4YMCkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CDA82C8D; Tue, 17 Jun 2025 10:32:40 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4C581E18
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso25502065e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750149157; x=1750753957; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nwqxchRTLurVFTfO5VBlW5Va1x1dnyiDlX+kHYQ02Ew=;
 b=Ca4YMCkP3OvInVMctV++lZQ2R+bJWYkwRFR+bkmkv3IDrL5rVmGmTPNk5MKfy2/bqN
 jDqo8gV+KvESclVH8Y2k4/1EYNiV9DtWvYIakbu87sYO5T+ufjyclYdJ5St5pqQDE58d
 LG+scSigJEZMpkVRxuH9HMTZ1N0LhjE/OrjLMH44glvKmL7ZTEJnwI2ijNhojEecWzUV
 gXcmdCD/7k9LDb8tNbFO5Osh5NoIxT9sFxefHCIDmMIr4kgiRHrhUFeY2MkSUj0LskHu
 jPuhgSF6fENO23Ak6K9XrYq48SSkoCJVUfBc4nk2f/F/PXR/GiKY47nJg3reWVsffGau
 bRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750149157; x=1750753957;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nwqxchRTLurVFTfO5VBlW5Va1x1dnyiDlX+kHYQ02Ew=;
 b=tdrYaS7sSH+PK24dbjGMOJVRnoD2O3Mi8XyAkb88AnNvMYJrKwnVUFg/cE2MXOO4W4
 NxuPOR/JcBr9zGmLpgfkXWsCEkNWhZVuheY/nReW9sN8XpCOiYAnCnFRrYLjeQZ19jLo
 n4qbSCDrDfVAJGl77YvHe4rwYzdCB+/6OGvNVmDf0D1kbyiEOzGCfBnOeYLoZyu3jEpd
 vdMLKBHC4uwmSeoUvMRz2vvjV4Z1EwFMp71y6x3bsojqXJmq5P7EIEa7x5N7oYp1pcXF
 ax92kPtSkPygkojzDAXaGo1/iezphTeG0ncPHLz+cyvYClnYA/5Peb9Z+I0mvur/VYui
 yPDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnR41oC7o+Vo/fFEkhx2VKNg/BLulI8024mwTUXWmDsPhfhcXjuv8Taj3yDQ5Fk746qLKicp4=@lists.denx.de
X-Gm-Message-State: AOJu0YxMcIzMRP7nU0G8L6Iy0AKhPYCOzKRSoAw5ybdoZIJLt7F+nxWU
 UGIrS9PYh6+Ws15HbvVLGKpALWVaMvgH9J91lJjPR9Y+ualcy2vLAqxTuUEsSFLQlm0=
X-Gm-Gg: ASbGncuDVu/3gm9EIyLEUq+EGSAnx7tN+tUU955nF0KLAusq4oknNhR7mnVIqJYeaRL
 VtNAKZLBKLCDDx0ipmcOF6zYyYdAyJH4ukfgMkizwvBLL2OV1JH3EnvXzAKPu1kJ4UEz6zOy7/X
 NwdXKPNadrYBiz1om4A4FGisqNgH74QK/Sq4YS/CVac12PJp9Y/TfAhrqh+3HLm/64M3pnZvivS
 QHpmJziRkLajKorwH1SOHJpRwHGhmjo4T6XzmCVFOez0GsbpJXriHkWLUqLivpga6M/tS52aGuX
 IVTQrj7Cci1Gyiyb3nLaWfPxiY6FgF3temExKepF5dSuvG0zxxSkH8QiPOMB5F8ebNixVGLKfJd
 IcfxDkBYd0sdFD15nlrx2l7y8WjCSDTDfzotsHqg=
X-Google-Smtp-Source: AGHT+IHkNt2mpOn3Hq1fszesvFqA20mKARSUyQVrtuZgopfk0rZ2vDYgQRdlXsQwGMgLnOXYdAt+1g==
X-Received: by 2002:a05:600c:8b29:b0:450:cf42:7565 with SMTP id
 5b1f17b1804b1-4533cb0aeb2mr108266295e9.23.1750149157226; 
 Tue, 17 Jun 2025 01:32:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31?
 ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b28240sm13337658f8f.72.2025.06.17.01.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:32:36 -0700 (PDT)
Message-ID: <e5b3f23a-60d9-4d4b-8cd3-ac6bd77e4b7f@linaro.org>
Date: Tue, 17 Jun 2025 10:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/6] pci: pcie_dw_qcom: Use
 dw_pcie_link_set_max_link_width()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Crispin <john@phrozen.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
 <20250617081641.8385-3-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20250617081641.8385-3-marek.vasut+renesas@mailbox.org>
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

On 17/06/2025 10:16, Marek Vasut wrote:
> Use dw_pcie_link_set_max_link_width() instead of local implementation
> of the same functionality.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/pci/pcie_dw_qcom.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index 39b4cd4efe2..978754e8472 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -213,17 +213,6 @@ static void qcom_pcie_clear_hpc(struct qcom_pcie *priv)
>   	dw_pcie_dbi_write_enable(&priv->dw, false);
>   }
>   
> -static void qcom_pcie_set_lanes(struct qcom_pcie *priv, unsigned int lanes)
> -{
> -	u8 offset = pcie_dw_find_capability(&priv->dw, PCI_CAP_ID_EXP);
> -	u32 val;
> -
> -	val = readl(priv->dw.dbi_base + offset + PCI_EXP_LNKCAP);
> -	val &= ~PCI_EXP_LNKCAP_MLW;
> -	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, lanes);
> -	writel(val, priv->dw.dbi_base + offset + PCI_EXP_LNKCAP);
> -}
> -
>   static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *priv)
>   {
>   	/* iommu map structure */
> @@ -299,15 +288,9 @@ static void qcom_pcie_configure(struct qcom_pcie *priv)
>   	val &= ~PORT_LINK_FAST_LINK_MODE;
>   	val |= PORT_LINK_DLL_LINK_EN;
>   	val &= ~PORT_LINK_MODE_MASK;
> -	val |= PORT_LINK_MODE_2_LANES;
>   	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
>   
> -	val = readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> -	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> -
> -	qcom_pcie_set_lanes(priv, 2);
> +	dw_pcie_link_set_max_link_width(&priv->dw, 2);
>   
>   	dw_pcie_dbi_write_enable(&priv->dw, false);
>   }

I'll need to validate it on HW, but it looks fine:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
