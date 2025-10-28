Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D3ACCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3EEC839D7;
	Tue, 28 Oct 2025 09:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fEMXxBeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354E8839DE; Tue, 28 Oct 2025 09:13:55 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD49B839D6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-427084a641aso4117343f8f.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639232; x=1762244032; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=kiWHSy1m6zeJQXbSbPmTSXWRGU3QB5IYbz+fZVhuXVw=;
 b=fEMXxBeC4JrlnqW5qwXlofCWMloLWpwuFtdTz1BbBCg9adtZgvHtdvMyYACh4CJcV4
 tgdgLnxtXBmN5pYFFVNCVnZaTA7CT9wFpDOkjAvvY5v06lnoa3m4lD/NAT8f4MsNp5RI
 7LM9lF5GIyvKzOgPLVjaQ2ydV11kOqJcZw06aerW1yIvXqDW9IZnkt3zvV+Ge6zJAxz3
 +yv8X+ic0yzbzf9zSnIwWNqd5LDtFz9MIkl+Pl9VX7dgxFwMP79jibuOniElLw0bMZ7i
 Exb5hHRHueVVuDMQ0IpxoEm7fFQLxc+HiVKkdnSFps7zIL6bTJewdeiSLfy3Kbh9sMbZ
 uPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639232; x=1762244032;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kiWHSy1m6zeJQXbSbPmTSXWRGU3QB5IYbz+fZVhuXVw=;
 b=u0UdvhTPgKt3vHFOR28w5EIp30Xar9bczOH6LMETw2j1OTER6xRxrNQ6U/klA0bElZ
 xiG3rSqa8cwVRAPEQChmK1BMxRidWWwhysOfDDW1A5ZKTKpxMQSeldZz7hMqkosdxo7d
 Asp2Zp6c5PlmKGP6nV/GXpc8w+VOEfUF8P5CMA23UKBRbA7g6MEDrhmGpteNhUCc2Mno
 vPPtpULS+ssXe3/g7BZmq/9+kq2QNZfaeLg/oVnkw5wL/jUshed8IDQ3Ksgfphvncwi0
 AcukDSrwjHuObm0qkcZwHKhv0r3IfprfbZCMYXQ9L25sqBRls09uvNXTE+t0JgLHIzM4
 IFUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYd+1Ww24To5oWxyxA+IBUTSDP3dPYV53AenByUXxJlova7fFQ7qItjzuFt3tkfoylNgvpHY4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5juFaRnOysZvgQVatlXA1u1u56vfrwM/eR4iGMb6LPy3EGXUL
 0v+dq+QvDSdWK/Agk9eCJT5jQqoY7gTWujhgotGEkX8U8aoTORzdvfhLkmvyShR4LiY=
X-Gm-Gg: ASbGncs8NTbXgqy9/LBOOvnoLEKamF4f4/EHKPWfSfVBPINiHwUJxYwLWpOb9CsfiFa
 kUcHqIfWkL2S6rt+r+ar0RVtqmGXQBDXpXng2HoSHUG+TIAaAbu9McgNgE2RygZUyw25vEb98XL
 ujhjB59PsH0mW5vXoS0gXZzV0NFggX0Kj9+V96vwwjzvD41vXuvqZEPPCMeZvkJfvSY2F8dQaSn
 T22kpLYz7jqKt21IOjTmzQT+7hjlZyJCSYA+CiOHgxMPKLrQLlk+7oPBbr8b1AblgQBw0RiuDwV
 LvAQsiIPePHpmSPgzBvAl4aHYyj/8PLMk1dzxDjrwahWfoA77i79SjoNKUTEoxgmwDMhRkP4awc
 alCAX2sQyL3tXdye2C10lA7aL/t8BW9xVFE86ngem5Qkj96sLbI5PiaOC5wm+rGL4VWEAMCoTaC
 lFcjswkkYherviRUN71eAmKvyTA0C3+X/TeU0ThwbEynoiXS6fRYppIX5ou977
X-Google-Smtp-Source: AGHT+IFllMAO6gsR3QB+itfYjMZfMNssrm0N15tti2FT67U2AL9ZxkdhQE3SCG7aY5CopM5V0zfquA==
X-Received: by 2002:a5d:5f46:0:b0:429:94c3:77f with SMTP id
 ffacd0b85a97d-429a7e7a38emr1734421f8f.37.1761639232003; 
 Tue, 28 Oct 2025 01:13:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5985sm18766542f8f.25.2025.10.28.01.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:13:51 -0700 (PDT)
Message-ID: <f3df6fd3-c854-43fe-8061-112058b03c4c@linaro.org>
Date: Tue, 28 Oct 2025 09:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] ufs: core: Keep Makefile and Kconfig list sorted
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
In-Reply-To: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
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
> Sort the Makefile and Kconfig lists alphabetically. No functional change.
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
>   drivers/ufs/Kconfig  | 38 +++++++++++++++++++-------------------
>   drivers/ufs/Makefile |  2 +-
>   2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index b08ca08b07c..b466374fe40 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -15,17 +15,6 @@ config CADENCE_UFS
>   	  This selects the platform driver for the Cadence UFS host
>   	  controller present on present TI's J721e devices.
>   
> -config UFS_PCI
> -	bool "PCI bus based UFS Controller support"
> -	depends on PCI && UFS
> -	help
> -	  This selects the PCI UFS Host Controller Interface. Select this if
> -	  you have UFS Host Controller with PCI Interface.
> -
> -	  If you have a controller with this interface, say Y here.
> -
> -	  If unsure, say N.
> -
>   config QCOM_UFS
>   	bool "Qualcomm Host Controller driver for UFS"
>   	depends on UFS && ARCH_SNAPDRAGON
> @@ -39,6 +28,25 @@ config TI_J721E_UFS
>   	  This selects the glue layer driver for Cadence controller
>   	  present on TI's J721E devices.
>   
> +config UFS_AMD_VERSAL2
> +	bool "AMD Versal Gen 2 UFS controller platform driver"
> +	depends on UFS && ZYNQMP_FIRMWARE
> +	help
> +	  This selects the AMD specific additions to UFSHCD platform driver.
> +	  UFS host on AMD needs some vendor specific configuration before accessing
> +	  the hardware.
> +
> +config UFS_PCI
> +	bool "PCI bus based UFS Controller support"
> +	depends on PCI && UFS
> +	help
> +	  This selects the PCI UFS Host Controller Interface. Select this if
> +	  you have UFS Host Controller with PCI Interface.
> +
> +	  If you have a controller with this interface, say Y here.
> +
> +	  If unsure, say N.
> +
>   config UFS_RENESAS
>   	bool "Renesas specific hooks to UFS controller platform driver"
>   	depends on UFS
> @@ -48,12 +56,4 @@ config UFS_RENESAS
>   	  UFS host on Renesas needs some vendor specific configuration before
>   	  accessing the hardware.
>   
> -config UFS_AMD_VERSAL2
> -	bool "AMD Versal Gen 2 UFS controller platform driver"
> -	depends on UFS && ZYNQMP_FIRMWARE
> -	help
> -	  This selects the AMD specific additions to UFSHCD platform driver.
> -	  UFS host on AMD needs some vendor specific configuration before accessing
> -	  the hardware.
> -
>   endmenu
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index 2a378e45111..548306fb99e 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -7,6 +7,6 @@ obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
>   obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
>   obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
>   obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
> +obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>   obj-$(CONFIG_UFS_PCI) += ufs-pci.o
>   obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
> -obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
