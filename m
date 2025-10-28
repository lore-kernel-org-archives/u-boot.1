Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E99CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8A68352B;
	Tue, 28 Oct 2025 14:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pE99wui7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9772F82A9E; Tue, 28 Oct 2025 14:02:23 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE8E83623
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so54171585e9.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761656541; x=1762261341; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CfF9SHavyamCIFzWK3U3lEr7vSnoZtEEauTZanN+C8c=;
 b=pE99wui7YfkCagMao0dQvDnX5vOFeigrYE7jYbaqQnjERP90hFeGwRj3g8q/wY5nWp
 rkZjJd68Iq3TX/ZRztYB/32iwmdgDWggBd3sjWJROqh9GsTtiPekg67hzfHLJ04wORGK
 YKYuZq81XgNHTEcwsuPhDltbuQKRJ5/skm0ZEKuPtEAFaU0A0EqmyGr9qyb4WeukV0t/
 r7f0aeH51gw9CdiHRkCsulCDhX7qUlJ6C29B2zOSlLd/dZmlsvxprdw7LIm/1WlZ7wWC
 gSviO0DKVTIt/CSBDfKqjywQAOgZhEicdHPwn9qJVLmHx3EGominjClvQOLvp1oygMj7
 v3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761656541; x=1762261341;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CfF9SHavyamCIFzWK3U3lEr7vSnoZtEEauTZanN+C8c=;
 b=HuQmw/1ntFHI8Jde9gRKe69ORTHN6t8ASv+7oARaZDTfB1SBaUPmzTQKuEx+gEbj4R
 DjQp0lUr0CXYPL5s53f607eor6H9Z0n34AxQwesYIFAFwVikkYr0xSIcj0q+gCMGEGOZ
 LO+0uQJiQKbSN91SB//hIwap8m558TMt8l9e667XALfae7NTKL5UFjS8nqzBSCMEx6HV
 1j8mdgHGBfv+RJ7DyOD5bvVH9jshc48A2kdx623G32gPUK3bzyGlQpcpcmcv2dLvRPWR
 57hLxGxHiL11bXwfR4NZSeYHzThlWz12YNv6UjBwOV/FmNYRNpNMqUgYzoPlXknD3apN
 ITvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUnJNV433+cj+HklGJIYBQt173QzeaVUFxCs/EQ40QLdDA6N7PeLiI9FZyjDrdmvH2DYnd0ho=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe2i2vjo5k5QVuVn+D4Nzm8H+3OvkS1MkXTdgfHT4aalPsaqG2
 sL1ZIiupKYVhw+ZB1sjhl1NSl/v7ngWGZy3Wy1vTovZIgWzhlMucNxQJTkI6nPFil14=
X-Gm-Gg: ASbGncuWDHEgM37y1HE4jyUMPdfP1LwYJTmKrCnksN+fftA5k3jcyQDs5aYt1YhXFO4
 Qr3n+ExGdwISTi4H6iufhASwhiheV498nmLBXreBKP2H8enkQXTu85Zat/A0L1fZ/uZR/gUfMdx
 YA+sJKlmE4Tfwtf4jwL9ArjTQCrSR/lhm5OsM4QaZbctIhEMeRuOTbsSW0jBJJU9zTP4TOcaZ9v
 L2I2kZGRdg+XZDlT/AfYos/HBTV1hVitAwSlFf4JsIqbiTfZqLb7bUfWMfScrwpmSeE8/SqJCyE
 0MDTeeP6LdwmBnp7zciZ12Kei0Yn7lvfYQJgmKfLcapz4kcKfZStMAiYXIDkZNC8LKCloOpCuXW
 zMrLjp6e7ld411eVj9QujN5sb2dkR/1ZS2gC0JgAg4xEJFbMZTiQGYVcU1G4f5qQ1dAzIF8ofnW
 UJWh7IbT1PrFNpnKdP5ve5aCfQolQ9G4tdvyjuP0/klvm9USIIhg==
X-Google-Smtp-Source: AGHT+IFUNIY0lMF+MOLjZxaZvXIp0RypgzpfYgv4TfC7gK7ykEH2UpjDfswwUxbgLlVBwLhXVktsfA==
X-Received: by 2002:a05:600c:4446:b0:476:6ef6:e28c with SMTP id
 5b1f17b1804b1-47717e67e30mr23716475e9.38.1761656540929; 
 Tue, 28 Oct 2025 06:02:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de5f9sm20260666f8f.38.2025.10.28.06.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 06:02:20 -0700 (PDT)
Message-ID: <f2227504-8cb9-4e06-9d8d-3f0f5902e114@linaro.org>
Date: Tue, 28 Oct 2025 14:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 4/4] configs: qcom: Add QCOM_POWER_DOMAIN config
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-5-aswinm@qti.qualcomm.com>
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
In-Reply-To: <20251027113312.3815169-5-aswinm@qti.qualcomm.com>
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

On 10/27/25 12:33, Aswin Murugan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Enable QCOM_POWER_DOMAIN config for qualcomm devices
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v5:
> - No changes to this patch in v5
> 
> v4:
> - No changes to this patch in v4
> 
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done
> 
> v2:
> - No changes to this patch in v2
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 8d1269b4634..a5a1bf7368e 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -129,6 +129,7 @@ CONFIG_MSM_SERIAL=y
>   CONFIG_MSM_GENI_SERIAL=y
>   CONFIG_SOC_QCOM=y
>   CONFIG_QCOM_COMMAND_DB=y
> +CONFIG_QCOM_POWER_DOMAIN=y
>   CONFIG_QCOM_RPMH=y
>   CONFIG_SPMI_MSM=y
>   CONFIG_SYSINFO=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
