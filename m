Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB6DCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F5084951;
	Wed,  6 May 2026 16:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D+SBbAmp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5EC8495C; Wed,  6 May 2026 16:34:55 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE54F847E1
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so3507015f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778078093; x=1778682893; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eRPZvTuj9PZvZ1gY28UHC+Sw2tAGhhpx2QYJMWbOvOE=;
 b=D+SBbAmpihUsl1kMRsNwi8syjTqYM/bRqvgHyN43+eV7s2Ic2gIan0MfGZIkwVvFog
 896FCS+ZV+9tdWVxYUAQVSqB5UhF4U2U/05mcg2/LXCTCsb1RkrpZ6/k4SSM4WNNqEId
 PiqlKroFAXL+Njb09CThcqwBQ35rP+fiEvc36pc6JH3rYtklXP6zWHtzrSwTPUXW45x2
 /mEG5GVyJCJXmZ4+AVNml5khDvea2+Fnvwrr0imglYHMR2GRncC01VwzndFzlUpTE6Fj
 VA2S9+LczKqzzLiPUeqUVrwSF5+yCm29LvblaaShl7+FVif7ZMIo4d+ysSRn7A9pqu/E
 aT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078093; x=1778682893;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRPZvTuj9PZvZ1gY28UHC+Sw2tAGhhpx2QYJMWbOvOE=;
 b=cuvAhx9O/mIfdlTdxxL7T9y3QWbxR+CDA1fjZToarsWBUm8CISDY6XtbHREHJM8QGW
 N8B2rLO+grtuoclaft5B7PdhpnLOYcQjdZwMhFG29Bn7OEWt90Upi/XcppRsb2DPzN1Z
 NqDXPX5rwjnxqUaPwGAqlYjHET90nOPemNVPTpTUqiVw+Kr6wWdsfAoudWyl0/7ANfnx
 a9C+jeV0fQQYABem7AFEc6oHs/dcyP2BFsbE/yVmX/IVnWcCAz3bScyzpwkLpZ/c2vBK
 wadkXoSNH2SDU47YWiryiJp46VBPtS9CC5PYeb+j/WDdlzWUAcs5lbHfmMcIgOib5LQp
 DCYQ==
X-Gm-Message-State: AOJu0Yz9HN+51FXlcqG6u+gTgCZTYvwyjb2VnodPJtwyLoGWVNVFlq2M
 vcSFfzjqJ/TNlEf0DjfFfpScnuzv5AteN0tfbwGZk2nyj3qFLyaSb+bTi5HVOER38Mns7FC3ylB
 v6j4d
X-Gm-Gg: AeBDies2DAAT3OxDki7osWv6+zDIAUwf75af3Kg9x/tGXiXpOlGylHjTRbcFaKm2O9l
 zMMnpmhmWva/q12uzEVvXzf2+QP8vbwsBXv2QCupoSmls5h+Dia3Zc/BuAvDF2Iw6co9jhtfZ2M
 Yg91hnTfZlTncMOf9lykDmR6fD5ZukARHmzxsLfUx6kkvVERH5ffv5u8o6Q1XPT+sTPBx4EcTtI
 HDcH+JXDy5f8FzuYxdLTUZBknUdO7WFOlUYUG66+oCRn7CepRfdtm7dlE5IHFb9TMxBCCDx614c
 D/Xg8yVEAbtHlZCW2sGc9jg33rFwcMvN1NCVknj6i9voqPtZxjisR5leLEXU+RMvjDeRT0kddpc
 c8Y34UdkyaQlrhrqBcPeR3i1hwXH0Ku7Fag5z1B5W+yE5BRft+LJKGLeu48mq4BNOfqYfIyw7+/
 yvPy3aVFhE1DyyfYEryGvgr3wCIfW3Q8A5w3WeLk/1EdQng7iglOUPMeAs46f+z2LzsVtZe3KJq
 sv/6zxJKJICXXnoaw==
X-Received: by 2002:a05:6000:22c6:b0:43c:f247:4792 with SMTP id
 ffacd0b85a97d-4515b524475mr6675559f8f.12.1778078092906; 
 Wed, 06 May 2026 07:34:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a3bb:11a4:ca24:24ed?
 ([2a01:e0a:106d:1080:a3bb:11a4:ca24:24ed])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03e04sm13144733f8f.21.2026.05.06.07.34.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:34:52 -0700 (PDT)
Message-ID: <5ba58555-78cd-454f-9fcc-5aaec5fd4205@linaro.org>
Date: Wed, 6 May 2026 16:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] pci: brcmstb: Fix iBAR size calculation
To: u-boot@lists.denx.de
References: <20260428163940.CE7CB68D0A@verein.lst.de>
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
In-Reply-To: <20260428163940.CE7CB68D0A@verein.lst.de>
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

On 4/28/26 18:39, Torsten Duwe wrote:
> From: Torsten Duwe <duwe@suse.de>
> 
> Fix inbound window size calculation, like Linux commit 25a98c7270156.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
> 
> ---
>   drivers/pci/pcie_brcmstb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
> index 1f97cda5cc7..8a25fb04563 100644
> --- a/drivers/pci/pcie_brcmstb.c
> +++ b/drivers/pci/pcie_brcmstb.c
> @@ -105,8 +105,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
>   	if (log2_in >= 12 && log2_in <= 15)
>   		/* Covers 4KB to 32KB (inclusive) */
>   		return (log2_in - 12) + 0x1c;
> -	else if (log2_in >= 16 && log2_in <= 37)
> -		/* Covers 64KB to 32GB, (inclusive) */
> +	else if (log2_in >= 16 && log2_in <= 36)
> +		/* Covers 64KB to 64GB, (inclusive) */
>   		return log2_in - 15;
>   
>   	/* Something is awry so disable */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
