Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C88FC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC4682B20;
	Tue, 17 Jun 2025 10:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xeK3Y+YF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B497382C4D; Tue, 17 Jun 2025 10:32:07 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0532F81E18
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-452f9735424so17269165e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750149124; x=1750753924; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Q5e8UgkFbIFWIUQBRkWuZBxSGuwk7wSwa+a3JS6rHS0=;
 b=xeK3Y+YFy1jDCCvNZa8mKi0rEde0Gv9evT8RQhhFpTqNIjERoEVDpJrJgv9zATKc+0
 KRDti0NJwuT78xFLuaIPdtzWRrfS4A4Wrn9OK+7/DlddkIIMY+zsfjChYn2DVSE7WgOe
 mSLApoGgipbYDv1DBbP+uzQpgqMTw0CC8CvV6UXLkW6UOdHWiA/aqDSQycZHlpVQjHn+
 n4ka74QaQk8JxcpsEMjmeexMj+SRwD1as/u/Fvg9m36t2lrtZ8OXfjiJEawI3ohWJRpD
 YzoErP9I2UlG1XnAj42M2wj1GDyTdEF1m8HzH+6afSbNhfak7QmwLpANktlsenVniJMm
 Ob4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750149124; x=1750753924;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q5e8UgkFbIFWIUQBRkWuZBxSGuwk7wSwa+a3JS6rHS0=;
 b=c0KVQ8qUzlEMTloPDpT3c6lHYjECwT7Cgo+VQsq8hXkqTzdBqc/5LmfKKo34ox2FHk
 QuxnGNdThrbin+t8FQitop8kQO66aiRTFJINJgEOg3+SZlJY/aLHdMjFR2CqA02avjRM
 xobJChVijrfabCaHhcXeCEepxZ6AszcZWxeHTmY0/0rZDCvlzsHGnGJiSn80CSqltOVZ
 IKu6dU9IV2JBZ5+SPbr4ZDyRpBIBBv+ZCB1yvJIb2hauYVj8DxHhAou2WzPTbXaw5O+C
 xVwPZli1E8H11PbapbonmcmmlWnqEpiPw96mMUlWxGBppdG8QCT86qXLUX3Y6qpZB41v
 lWnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkX80CO+C+3lE9cEFI3JuTZYQGKjwlfwfBX2tL4b5Xq+Nzb/MMOltNSsMnKjp8oPmG8oHDNFM=@lists.denx.de
X-Gm-Message-State: AOJu0YxWaj7t07hiHUvAz2XOVirbSULbq48r7TDPAiRF3wdC3Laz0kjR
 QB3myuWtYo0HvjsMn4aRGIuGnMMCalY2fW2K7SxTnqwUHci2WQTcYW6ktbyJg1K0yLI=
X-Gm-Gg: ASbGncs8b5bGzPTcDrZLa8maSg3n0k4rhwuPEObvgfFLK0hzdFPcyrYN/x1TEEXQv7D
 /tlkIrLjB4LgXr1WLmp06KJBRQdsk4d5Inh3HECDXt610uKmSOyD39kMtU3UXw7bwhNjxtC12UC
 NVck1mNEL1lKnmOGSBR9+NGDc0JcnpmRjGfGiEwYpojWFETFtQgg6HyYZR/E/q0gT7kDeaV9AOa
 tmrgw0Rv+jHEGhfGtkYPsHJ9ZIHbeo6G1x3DSpfDXN6IxQARV7KVTxsu0F5alrpwVy3al62rvv0
 f5eDCgz06Epi1KVqQRr+oIj6Rl8KJVJGB++bzJAYPNZKehxvS/tySjOEpI8HazY3LOv9OyEKFcC
 hCf7BLrGyzHGcyVivzhtcswzUopM2lGAYq2R2FG8=
X-Google-Smtp-Source: AGHT+IEDq0I7JXxNk3z1+9cwpMaGJRj4S5TGFD8z9iqrr/48AMDKDX4UcIAWBl/wYe5ViB0av7tbiQ==
X-Received: by 2002:a05:600c:1ca1:b0:453:84a:8cf1 with SMTP id
 5b1f17b1804b1-4533cac6479mr96977885e9.33.1750149124315; 
 Tue, 17 Jun 2025 01:32:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3819:3250:4f73:db31?
 ([2a01:e0a:3d9:2080:3819:3250:4f73:db31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e16b425sm165904285e9.34.2025.06.17.01.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:32:03 -0700 (PDT)
Message-ID: <85c6a4c0-400d-433c-bcf3-e089f15f0c1c@linaro.org>
Date: Tue, 17 Jun 2025 10:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] pci: pcie_dw_meson: Use
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
 <20250617081641.8385-2-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20250617081641.8385-2-marek.vasut+renesas@mailbox.org>
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
> of the same functionality. This does change the behavior slightly, as
> the dw_pcie_link_set_max_link_width() implementation also programs the
> LNKCAP register MLW, this should however be correct and is now aligned
> with Linux kernel behavior.
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
>   drivers/pci/pcie_dw_meson.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
> index bb78e7874b1..483b07ce078 100644
> --- a/drivers/pci/pcie_dw_meson.c
> +++ b/drivers/pci/pcie_dw_meson.c
> @@ -115,13 +115,9 @@ static void meson_pcie_configure(struct meson_pcie *priv)
>   	val &= ~PORT_LINK_FAST_LINK_MODE;
>   	val |= PORT_LINK_DLL_LINK_EN;
>   	val &= ~PORT_LINK_MODE_MASK;
> -	val |= PORT_LINK_MODE_1_LANES;
>   	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
>   
> -	val = readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> -	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	dw_pcie_link_set_max_link_width(&priv->dw, 1);

This also changes PCI_EXP_LNKCAP but I guess it's also done like this
on Linux when calling dw_pcie_host_init.

I'll need to test it, but AFAIK it looks fine:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   
>   	dw_pcie_dbi_write_enable(&priv->dw, false);
>   }

