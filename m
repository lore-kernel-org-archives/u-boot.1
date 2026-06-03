Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8D9CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5400684898;
	Wed,  3 Jun 2026 18:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nhHBhnVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C856984911; Wed,  3 Jun 2026 18:16:42 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A6C8469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so5854224a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503400; x=1781108200; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KJlDUwzd4f+dE8EotV9XpMTX5yB1vnogDPOidKmElZU=;
 b=nhHBhnVnJzsas3OtjYmUQuIT+hIV5OJPW/jXCuPp/FAoj/gPqNy9VSVxIt7Ye1i7aG
 tzE0eMf2euW4oTKqBLWWbdAAXRP9t08emmNmo4qlVupAhAawUFcR3DYleJApxhig/ZZL
 Ni7AyjVjYVLSnoa90OmlUVjZ4lYShxcCzJdlGwW7TsjwFIUeNMYPWjd7hAp0h7UJknZn
 aFWKRZmkxQbQ3Py9LOpUXGI8xP/JNL5Gbmyk+jGy0XqoSD5fdiLuMy16b1vjKUok4QBo
 9Rie9PLOmUfFjYXSim9UC5zL06iYV/IMPGdUGj30PpgtqBtvNOP6AS/pruix6vpipyql
 sVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503400; x=1781108200;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJlDUwzd4f+dE8EotV9XpMTX5yB1vnogDPOidKmElZU=;
 b=pYmX/f2cxiwA4l04HPV6d+ohB3D7oulQ1xnY9roOLEBQSLiQWTsOBK7qojNTSRZ2e0
 Nf3tDr9Tx8o+K0/U4D6UEeAeZqoGburrDYDp4nXULf8fn2N8ReHNpRBKjSFP1MpcX7o1
 lqS76OVvUEH0QHWIsC6ttROVJTXecu0o0iD32UPP+FuX9wNt2+As0W+fd2D1EBC0R5U9
 Y4tFr1iFcodiEoOnYOr6KxxqAOcqdVu6VH1bn9kbv6o1YueAlxLjwXWHosQQnGd5ucIn
 6qiVYhWQCyy05XEAQxBu4U7UbsSB3SHjZ/Ksj39xnGOV3CvSJlECoo5+eyAgb6qWmTT6
 iFFw==
X-Gm-Message-State: AOJu0Yw6XrIPMeJOe89rCI+q+GEdTXuHmCLeElN14XO0PaN6QnNCC1Zt
 r4MSdPUCWItHmpNAIJo1DBA1/VIXzCTNQXu5tv1WbJLBdu/xY+NhK5IW+4jhwHo4scE5WN1WBFs
 v8RMv
X-Gm-Gg: Acq92OH2Jox7jzg8qXKg1OZqzxq4TvlOvENhqGA4b2beFXJ8SYgnRWC+r5CO+b911R3
 kjwrvi1EOm9Rm4tcL5zN2jLqe98oycFtFk/OR8vXrZhCjunTAUSOejtCYxrHsVOAoAkmQr3zNwD
 CcdwPf39p7FbwQfn2Ms7y/wA+cIAZmvhQArZTdHbtlrKsg8Wl+DGbSgDiOXfO2t7e+yobB+A4zo
 k9DM8sXbySyIer7DAIeada5lofWHbtbDN0Qi4pQjgDcIdmnhxbC8QlilSk6xc7QACmTq/ltLJIC
 fZhl1UQZSE6YN2wtwGUHE4qKhkOinUCa9AIgmBbSS97SZQJk3xCrzAmxRBSIlYGQ+OcHFQMo+I0
 374xpiTtim4Ja8tl+4ixqpLnLGMeRyHaoDDNx+va7GKckTU+0bRTqwspQOxPHmg2xvgUhBkUlUu
 WbCBgEqG5Rfxae3XbIZe443BjeEAejoWbra+2QPOZR++z3CWcY2tfw6VclOit7NE2oikgbH66L9
 UJiXqejWaVOnWlpSA==
X-Received: by 2002:a05:6402:3805:b0:68a:f749:608d with SMTP id
 4fb4d7f45d1cf-68e72932655mr2167820a12.21.1780503400051; 
 Wed, 03 Jun 2026 09:16:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2a0:317e:910e:9ac9?
 ([2a01:e0a:106d:1080:a2a0:317e:910e:9ac9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm8640495f8f.9.2026.06.03.09.16.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 09:16:39 -0700 (PDT)
Message-ID: <469982fe-550a-4c4c-8e2b-f132ba88f85c@linaro.org>
Date: Wed, 3 Jun 2026 18:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ufs: add ufs_tool to Kconfig and Makefile
To: u-boot@lists.denx.de
References: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
 <20260603124553.3763516-4-raz.benyehuda@mobileye.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260603124553.3763516-4-raz.benyehuda@mobileye.com>
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

Hi,

On 6/3/26 14:45, Raz Ben Yehuda wrote:
> Add support for the UFS tool to Kconfig and the Makefile.
> The HBA ID defaults to 0 and can be overridden by the user.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   drivers/ufs/Kconfig  | 15 +++++++++++++++
>   drivers/ufs/Makefile |  1 +
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..8f67d916a72 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -8,6 +8,21 @@ config UFS
>   	  This selects support for Universal Flash Subsystem (UFS).
>   	  Say Y here if you want UFS Support.
>   
> +config UFS_TOOL
> +	bool "ufs tool"
> +	depends on UFS
> +	help
> +	  Add a UFS tool implementation for querying, printing, and updating
> +	  UFS descriptors and configuration parameters.
> +	  Please see doc/README.ufs for details.
> +
> +config UFS_HBA_ID
> +	int "Id of the ufs hba"
> +	depends on UFS_TOOL
> +	default 0
> +	help
> +	  Default UFS HBA ID.

This should be an option of the ufs command, not hardcoded.

Thanks,
Neil

> +
>   config UFS_AMD_VERSAL2
>   	bool "AMD Versal Gen 2 UFS controller platform driver"
>   	depends on UFS && ZYNQMP_FIRMWARE
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..0e472782261 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   obj-$(CONFIG_UFS) += ufs-uclass.o
> +obj-$(CONFIG_UFS_TOOL) += ufs_tool.o
>   obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>   obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>   obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o

