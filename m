Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A7CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CA583A15;
	Tue, 28 Oct 2025 09:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xSwakBLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1DC83A2B; Tue, 28 Oct 2025 09:15:38 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2516839D6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so28698155e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639336; x=1762244136; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W5d5d0RAxE/t29suUhdxilArs3IbRHpE7Y648ZkVnV4=;
 b=xSwakBLa2/bHVTBkn6iYs0Cxo9jpefvZo7SGkMkUx0s9iI5GN8V9mlNP+urfp+q5Hq
 OpxEW2/Gco8YmsqBQd+Hv/QISvE30ildaPcnpvNRqZ8YW77sPnsJrBsL0mE4C8LzKsDQ
 LHoKuQ7i58KFh0mv88lrdivQzSf/8o3Dhsgzn3ng0xTLsvqsm0MxH8WGvRmjdhDNzrM9
 XYrreSlHFshliWjxxCMnkAKZh5jNai3ysrCt0nVvx8ntSl4b7+v+IkR4xK5Z5MhOcPnM
 SIMnWnpJEhto7vwp+vbrZGlazO1GBYkOChQY4qw2dCcObyIdjioA+bKMW+ENestm1+sd
 zDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639336; x=1762244136;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W5d5d0RAxE/t29suUhdxilArs3IbRHpE7Y648ZkVnV4=;
 b=cR6B4WGvK9NefRPz2kr6Uu7C8BOUEng9SM1ekbAhXr2/rzLZmwajKXW3Y34NyFifUI
 H9wpXujVpBGtw2+DasQKv0T2sTEJnYlMquJ56VUwbgJ80QYRRc0amcqb50L5xej49VrL
 KfekgNiWKHzdyeAfs/zXqob6U+/kTF/DwiwpLTQAVu1PuXLQjQKhvT8X1ZK9MwCH06xk
 H5cgbw1mSbeaPrB9Vn+9tph7nTM7UipaluTyjdvq825oiDeMQxEBjmxvquRm3xK7/eGd
 VzPX00CFntwQK1AQvwhdTTYqE+TMGWgqflQ8P+WsiUQaQkLY+h6fV33EPDdnwRLt4Ppj
 q6bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLAE/1/AdClPvxLrzwv2tf5OJPsWB2uL4oLo1XmZFgk+8kxAyBUHpKB4SZPuWVK759hGcCc8I=@lists.denx.de
X-Gm-Message-State: AOJu0YwQenE2/9l0tTRj0+Ks6CNw6FwvFOKLDl2y7XgVnv/VbKf9vILg
 qBVap6YtImdPsohdbN2+8Mzuq/8eAVQkvZUVvPHq8NyK/JZVR9IcjEeb1Pwl61n6g3I=
X-Gm-Gg: ASbGncu8pn14HSuPFH3Cb935EbuARvLqtNwzAPCGDqhZuEikWkW/otRwv2GJtx9OxlK
 Iao1Dlm8CzJJ00szKXfeJqxodItdHG53p6pzjb5Jo0WgfqKeaExFOsqfLfeH/nyqpwKl1h3sSMJ
 CtfSS1SuZNYVjOdlEkjdMzpDC0pFQHqRQCnGyuPexO+9CUi2+Dy1v6kIV4wnbqoFqKXfYVfsT/K
 9vj7YQTQZYBlwSxRlJN8OFVEb5PhvyoiOjjula/MmXac84u4WFRqLWazWKXS+xcKO8v10NBBl4h
 WhYKiQ/WNmhvoyUY9nF+4sD8sEFXEAg0xbKuyDngTOU2sSsnswPqd/1FDlPqV0ukhHHlLJ91gNV
 UyKW2CTWdkcPqb+wzexSoNmzOqGTIwaB7N/axlm+aOc4I1HhRa1+lqMYYBaE3K0uvGJtptMwpz+
 73btKbh5MDFF/ngBhHN53JQr9ioiBu2lvygGG8U/LsTFcWUCNCVA==
X-Google-Smtp-Source: AGHT+IH2P/rAWTM7tXx00jye4/URQYaAdI83m2mCxJN0X3leJ1VzHNUGuuN5wi2dQOGzsOAbHScXxQ==
X-Received: by 2002:a05:600c:19c6:b0:471:95a:60b1 with SMTP id
 5b1f17b1804b1-47717e71e49mr23195495e9.32.1761639336131; 
 Tue, 28 Oct 2025 01:15:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771bc597c7sm3448105e9.1.2025.10.28.01.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:15:35 -0700 (PDT)
Message-ID: <ab2833a5-7ee6-458e-b2af-a5bb3865abec@linaro.org>
Date: Tue, 28 Oct 2025 09:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/6] ufs: renesas: Update Kconfig entry help text
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
 <20251027170706.29302-5-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20251027170706.29302-5-marek.vasut+renesas@mailbox.org>
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

On 10/27/25 18:06, Marek Vasut wrote:
> The current Renesas UFS driver contains initialization code
> that is specific to R-Car S4 R8A779F0. The upcoming R-Car X5H
> initialization code is different and contained in a separate
> driver. Update the Kconfig entry help text for the current
> driver to help discern it from the X5H driver. No functional
> change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/Kconfig | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index b466374fe40..4c6b08ad31c 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -48,12 +48,12 @@ config UFS_PCI
>   	  If unsure, say N.
>   
>   config UFS_RENESAS
> -	bool "Renesas specific hooks to UFS controller platform driver"
> +	bool "Renesas R-Car S4 UFS Controller support"
>   	depends on UFS
>   	select BOUNCE_BUFFER
>   	help
> -	  This selects the Renesas specific additions to UFSHCD platform driver.
> -	  UFS host on Renesas needs some vendor specific configuration before
> -	  accessing the hardware.
> +	  This selects the Renesas S4 specific additions to UFSHCD
> +	  platform driver. UFS host on Renesas needs some vendor
> +	  specific configuration before accessing the hardware.
>   
>   endmenu

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
