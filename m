Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F348C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 11:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF50883744;
	Thu, 24 Jul 2025 13:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tXDpqQOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5CD83831; Thu, 24 Jul 2025 13:42:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E64FF836A3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 13:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so8587875e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753357358; x=1753962158; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=pSYUTBi9n/qx75TWBeiwSOnQBA9UQcfD0NhaOEKGkLc=;
 b=tXDpqQOCzCe9kqdx1yoVPu93T09ZaEWQeopyNFg24fK/t/iTU6OCWlnkIpsfXID58A
 icqgzxcEu6jUpIhF5DH0YgDbldAHQyfw0h8zXoOYrrOeYiQm7pzBFES6leR8iTLt4drV
 ZtIkosoXyq3Q4PL18B+nBkRHr/l/5cOyRcv6pmIx/8+6x3kN58dog8L35jJ715rvLGw+
 G2p1gUjXs94by13ko3hTv8zJjyUCpfrSzI48elXdTpsLuiM4uUJkrQfeJMZYcVKkUoZN
 KPXR78ZNqNmh09P9mEVUCVPpkzFC9jyuAOT6c8VyVP/orsQ82YKwZYWIRAKG+imzT32O
 G+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753357358; x=1753962158;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pSYUTBi9n/qx75TWBeiwSOnQBA9UQcfD0NhaOEKGkLc=;
 b=W5JDeYgavMOm358N6lfAMa5a00aeU4XFzkIC6xfLxn3qNo363gcV+fYNyHwJDhyx8o
 dKwlPZmxezmnigdSi5j7/4Jalsn7GHq8b3NrLaDCz166ezYvlTVd607bhuhbeZYnvMx+
 ahDXwoVRj2asKl2jpFEGDxa7e4CQsTyYI2dYj+7IzXl+Fd8+cUMbAVfTsndGAJ0CMeZR
 ASyI1+3VvbnRyHNe87zgc4YSpCUxozDW7CDEERa9H6Ot3WlhR5Fa6eRh29IqZfjL/vve
 PerqMelEnCkc+EiXU4nskVrVvVg456bEjioCy/bE9eGISZCS+fS+pIpnGXZ/EdeppUuA
 P6bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKygPWF9z+Ph5ve849NOAFUqjCz/US0U3hybdbtcSWhqjSddeHefqaQQwiaavgkB05WLFRhT4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9vqO9hu5SDHvFslAC+nDwsc7QXKdnkegun0hzhokwYS/7Ogse
 SgrWkYWEBCBzDzyINExk41NeIOhWVUuKtyz2KKtsGC6rBumZQB39eNkuEJmVle8wE1Y=
X-Gm-Gg: ASbGncvow0WyYmgu8IHIluRVeZK/ULetjn0NkgXUcWXCYXyh4VxsHGqty2WB6BkGpQz
 l1Mda0VoRvy1Vi2ss01IBbaTopWS6D1o6tbM3927bAon/GWmwxL7S+Ikn8eaOl0UhLRLNogyR5C
 XCE6alj2PKdWtlGvoASVYFbRK+5p13BBziecVMwtm4AEo5sXAOJ0P4CZ899ZKl56o6/bZ2O5Eu4
 4EbwVxfWy1Q6df2NDDh48vVm4Eybc9hb4gKUJMTXbBhDNbTZ9T8y/RoOhrjnR1o3WWcznRaq7bc
 byot3aGaCvnx08bofEoqjZ6mLYDYahY3G8wl1UkWph4A9O1ldVPqnLiehdIGtlJ2Ilp/mF92epo
 xrnSDDknVIw3woFjxRmLB9ynhYmpswsPq55GbZPavKNURBdjBkSuCf52fYABd2ayBmP4UutVQF+
 k=
X-Google-Smtp-Source: AGHT+IH/3/cxzr5apqUjQc7T5Eqf9HJZSBIOI5Hv35126EMUqwLW5vpV4EF57nptoUrTn1dakFS/Dg==
X-Received: by 2002:a05:600c:8716:b0:456:11a6:a511 with SMTP id
 5b1f17b1804b1-45868cfb2ecmr51032195e9.20.1753357358271; 
 Thu, 24 Jul 2025 04:42:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:e2d3:d328:dc00:f187?
 ([2a01:e0a:cad:2140:e2d3:d328:dc00:f187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870554a02sm17632755e9.21.2025.07.24.04.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 04:42:37 -0700 (PDT)
Message-ID: <1491319a-fb54-4d1b-8ffa-2ab2a2f74704@linaro.org>
Date: Thu, 24 Jul 2025 13:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] qcom_defconfig: Add VID/PID to represent fastboot
 device
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: casey.connolly@linaro.org, trini@konsulko.com,
 dmitry.baryshkov@oss.qualcomm.com, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250724111911.67872-1-sumit.garg@kernel.org>
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
In-Reply-To: <20250724111911.67872-1-sumit.garg@kernel.org>
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

On 24/07/2025 13:19, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Currently fastboot mode is enumerated as VID/PID: 0000:0000 which is
> not appropriate. On Qcom platforms, fastboot mode is rather enumerated
> as VID/PID: 18d1:d00d in ABL or from fastboot.efi app. So lets use the
> same VID/PID pair in U-Boot to represent fastboot mode.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
> 
> Changes in v2:
> - Rebased to tip of master since v1 didn't apply cleanly there.
> 
>   configs/qcom_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index b9ba7a677d9..4e24a43b888 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -140,6 +140,8 @@ CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
>   CONFIG_USB_FUNCTION_MASS_STORAGE=y
>   CONFIG_UFS=y
>   CONFIG_QCOM_UFS=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
