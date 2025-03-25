Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D5DC36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 07:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A5580EEF;
	Tue, 25 Mar 2025 08:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xW5gOtwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A0E80F70; Tue, 25 Mar 2025 08:28:29 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A416808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so4247799f8f.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742887707; x=1743492507; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OIXnPgIIdC8OybT9ohPr1ryumELYJnDq3mp9gwDcCyM=;
 b=xW5gOtwguexyTMXeY2QcbzUFUqULtcAORkm4ComrdZ0HNa1WNf8ikpRfymNdMTHDkE
 lIXg0sdL5vEdBS3anfpvTCBEEz+GLpmXeG4VTSRcPmRcP1Wb4mVTz8oJqiEp8TtjIlIv
 6lKOLJwW+ywpdZeb7/89f6X20jd3IhgWUmbNaytT2qxmLjpTzTA37ytpZE/4l54A7Fuj
 ayiOYy6kQbgz38YWiTR1cKu7lk77c9YHWLWBL19Np9W6Cdgu4JP7dhHF5QoktB/+ytcw
 0pDGjd9JEzqNJJMnA13Tz4AKaODlx3MUbiuvH1voWicJCmDu3hqWN3bciKhH0pd/I2FC
 D3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742887707; x=1743492507;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OIXnPgIIdC8OybT9ohPr1ryumELYJnDq3mp9gwDcCyM=;
 b=oAD5vNw9NuUfas4K0bCfocoTcBQQV1ciGN6UyIDkqZsXQ6+kljeCLmkCbomu+bwQYl
 xQuhUwVoDbXEPW1ugxjtZpnd012Bf8Gh/dSQ/Q86JSQgGtfHxpp1PdfZhFADUhA4Y4ge
 kICMddmWrUKQIu6sE5bduNdE9ThPWdzGWy7blrNjPJTsYe2I2dySw4YdJEY2qcDfiCtQ
 WGbc4NNaUWMnQk8s09ooPGP3lTLndsNvIH7cFQAxhURt5+DZh7upQD7u6hB9Cnl5Hh1K
 PrL23xYd2y6Q0f4ZeGwozKYbeRpTwVtcFqOJ0hr+jrg7SEWRyHl6Z1sdcUR2v5YCP3O2
 T6Xg==
X-Gm-Message-State: AOJu0YyWIS9N+UBwQsUj9RB2xqX31mHrfYVvjj41wGXOglJ8Num0sPZ4
 kuF7EbBqujakLyzHFfKcf+kH6yeUrXjtw/Zz60OMCnLr7MIEQvYlRWQO9J+L4gE=
X-Gm-Gg: ASbGnct03uNXyFeqlqPRkHc2LW3qwFu+PTYKj/HdJ980Elqkjm1TWnmM0pQ3ccSQ2ep
 V1TIvmGHZ13InIjBRW42qRze5wNDC+3xzJlaQ42CS8sQc2mtEw7Q2jZMs8h1YaSoLZYris4tPIo
 V2Htg0fRNOEgrbntyUfyN1bRXyWjXJPgcIL1kIuOMg28yONNVlT5gVKLhx8c/9AgeTLHXU8lr2T
 2qqguBDmKYbu//8hKjJdznTt7/BaGZaE2IX5DiNyGJI3txnJIK9qTXAueM3+qnqoNEGT+/M6UxZ
 W4BB18c49ZNiLBuuSyxoByzV19LfT2Yn4HLSGNaKnl7KszI5boVvK6VoHDvzhIzm6RCawR7jJlY
 oLACQGLbeq89Kg8mF
X-Google-Smtp-Source: AGHT+IHkwuRQCdyUfgXlSHY5A6zcfQacrcuEDzBaTd44UuFlcMgZIETSZJ3/n9XUOi8e4gohyczLcw==
X-Received: by 2002:a05:6000:178c:b0:391:47f2:8d90 with SMTP id
 ffacd0b85a97d-3997f9017e3mr12756791f8f.20.1742887706891; 
 Tue, 25 Mar 2025 00:28:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b3ff7sm12760513f8f.48.2025.03.25.00.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 00:28:26 -0700 (PDT)
Message-ID: <a68f36e8-a875-485e-a9e2-e9495e7012ff@linaro.org>
Date: Tue, 25 Mar 2025 08:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/4] qcom_defconfig: enable fastboot
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
 <20250324-sdm845-fixes-fastboot-v1-4-d177a10f336d@linaro.org>
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
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-4-d177a10f336d@linaro.org>
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

On 24/03/2025 19:17, Caleb Connolly wrote:
> Enable fastboot support over USB, using MMC as the backend. This will be
> the internal eMMC on devices that have it, or the sdcard slot on devices
> with UFS (if available).
> 
> We don't use a fixed address for the fastboot buffer because it's
> allocated at runtime per-board. Entering fastboot mode should be done by
> executing "run fastboot" or manually running:
> 
> fastboot -l $fastboot_addr_r usb 0
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ba4d38d100e053e3708ee2623bf3530787b6b94f..f5c005d9c4093e4902b05213ab2f54c8ca70208a 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -61,8 +61,13 @@ CONFIG_CLK_QCOM_SC7280=y
>   CONFIG_CLK_QCOM_X1E80100=y
>   CONFIG_DFU_MMC=y
>   CONFIG_DFU_SCSI=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x0
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>   CONFIG_MSM_GPIO=y
>   CONFIG_QCOM_PMIC_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_QUP=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
