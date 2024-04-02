Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74509C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EC08830F;
	Tue,  2 Apr 2024 10:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EcoUq9mE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2792E8803F; Tue,  2 Apr 2024 10:32:43 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED41A88327
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d47a92cfefso58680811fa.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712046760; x=1712651560; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=50d3u+HnWTyHvXgLDqKyKxVujRQCFhQMa99lGWk1mA4=;
 b=EcoUq9mEqYjhMsOO6AfCjsedWIu0j+b+VHPUk7JmBVO7CDEuJPg0lqgvo4Yly7D05m
 mzOBMNbH9eDjKEM3046WjnwtzFwngPjxyJzR0fH1Qo0wl35z5LbtULLm0ADln1lXa6Vv
 XGAP00UuQ2bawiXMSt7eUG1qVknbHco+JydEmhTJir03epGorarsDBrNqqfjx/Eb1qrp
 OPD3xTda8ow0IgUqPhPt3t2gZRDSMh0dOPBBh7CDEB93lCTadYYOwV7QE4EqzSFAv+rm
 bTp9J78hSMDMrxnmfG/SjWOxf6syIv0vEEtWEbCb/0mPIgQtBzKbYmA72qnACGBvPFUg
 wPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712046760; x=1712651560;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=50d3u+HnWTyHvXgLDqKyKxVujRQCFhQMa99lGWk1mA4=;
 b=DpqkTgPWwjFfbjrWZb1C+2uLuJP7qHbbmJWuQcLUCnhjoHh5L2xArlJRIDphqLylW3
 CexK57Kaox2Gj0Qilb+gwH+F8RlY2qYqKvROeMjrlU4tioatFuqRud7iJwwxatb6Ay37
 UWLB5VBsP17F0PXdnaG3f33GD1fWT4fBiNYTAX5aR4qUeqDCtE4tF5dmd6xHexn24i3G
 Ak2EyqPNRFEKWa9g0n/sxFHyCp1gjdpzNH2rmnwNM8Sxu3KgaXLHTod7AUcO0AW9qP53
 ZNikhBPAM7AQNwiKEH7Qxdz8Qpvilwp5+HzkhQdM5eWURkzR46zwqrEggK+GaNUxgX/+
 +1Yg==
X-Gm-Message-State: AOJu0Yz9vflgDzDcM/dp0H1ynBQyogS4cJk/UXLwn7J8/Za51u1DKXx+
 H3A/hqQMRQV8/KJqCk8jTFhIvu5XCfQi6u9RUuBb6AqZD94djHOkxeGNW0WEkZU=
X-Google-Smtp-Source: AGHT+IG4b29c2L/5Yg9KpIe6LiVfw9I7VU55uPKOavaqcpC30MWzc6JCLcaJwNjI4PlcvCqZiPlpGQ==
X-Received: by 2002:a05:651c:1a10:b0:2d8:19fe:4879 with SMTP id
 by16-20020a05651c1a1000b002d819fe4879mr3403071ljb.38.1712046760284; 
 Tue, 02 Apr 2024 01:32:40 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a05600c3ba600b00415509b11c3sm13301543wms.22.2024.04.02.01.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:32:39 -0700 (PDT)
Message-ID: <1c1f180f-a9e2-4ce7-a32c-a89b4c447b9a@linaro.org>
Date: Tue, 2 Apr 2024 10:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 13/16] dts: sdm845-db845c: add u-boot fixups
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-13-4e98228b3d03@linaro.org>
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
In-Reply-To: <20240328-b4-qcom-livetree-v5-13-4e98228b3d03@linaro.org>
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

On 28/03/2024 18:59, Caleb Connolly wrote:
> The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
> This is incorrectly modelled in Linux where only the PCIe dependency is
> expressed. The correct way to handle this will be through a
> usb-connector node, but for now we'll just mark the regulator as
> always-on so that it will be enabled automatically during boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/sdm845-db845c-u-boot.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> new file mode 100644
> index 000000000000..906f9faa5451
> --- /dev/null
> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Needed for Linux to boot from USB, otherwise if PCIe driver is not in initramfs
> + * the VBUS supply will never get turned on.
> + * https://lore.kernel.org/linux-arm-msm/20240320122515.3243711-1-caleb.connolly@linaro.org/
> + */
> +&pcie0_3p3v_dual {
> +	regulator-always-on;
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
