Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E3AE9DE62
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 08:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B6184144;
	Thu,  9 Apr 2026 10:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SrIe9fLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D68E8413A; Thu,  9 Apr 2026 10:01:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169E684105
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 10:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4888375f735so5331455e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775721668; x=1776326468; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aW2gugJkyZ22WphGeCYCMqovQKZmR9g7NH0G6lciFP0=;
 b=SrIe9fLPo7+82VppU4y8yyW/pIdTYZJDcC0p6xFzW22y8cR98QN4UbvitBtHrKfPiU
 ODd5QKQVH4/cmZqLbgxnDQut3ds3C5n5WqA5pZCVrYO4MRfbkAImseIRpv9WBxWvorSR
 Wq1iI04y6GyQgiuyLvLi3Gqz1WwCqoFD2+NHZh409Bigigpkga0GWBEoMTpahjl6wGi6
 kw3kJoenjIyP9K2KUJ0YnojwWuVugt2R9TPLxiGiYyeSbZL7g4FNDkyxfLT9i6lBuZ8j
 ia0+3j1bPq6bzmtWW1JKn9u+qwHxVvfbqLRrJakabLxiyaWHUC4TivgeK9Lic7FxAoIX
 yOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775721668; x=1776326468;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aW2gugJkyZ22WphGeCYCMqovQKZmR9g7NH0G6lciFP0=;
 b=ZoH4MeJJXfrk4IbGlR3XlKD8x99o0E91yqniw7Bs8xNk4tTNuilKS7jDSkxDkUWeC6
 AqxggKo/deH+5BtJ0hLxLnrrcdHuKn6hVxFz4aZbu/O+2FnNk0SdBVBqB0eb5uBIM+NP
 GBzhsgzG+6+EqztUZw7VBCgtQ+giBBvriKhryI8ECYC5qjJZxid70IEXT5qlXunaB+Nh
 BJm+dR0tHTypqCcadZhc/FL5gwXsQCgPGFHOjUX9QBW7ORJAnyK5w5gOLEloXURfzcJ0
 xMLMAUl2KmX8w8ILy8vmyA3tasb6FcaV0sIb3NjLhAfATUVYiW603O46ofmvaTJRuWlR
 aXkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgKg5g1I9mUyvsl3E4v2JbJHisRCyB5uNNUqhNUtMFcPdFJWiJ2jf1gicAet8K7R+zl7N/tMg=@lists.denx.de
X-Gm-Message-State: AOJu0YzmdbRVVp8ae04xNyGHgb8BvL5acpJk6qcVSbkYaA+Wop1OkLc1
 t6tTQY+byRPJh4tSTUmzvdyfo+A7QxcxIJ9f4e+/4shjLS9M1MRzT1Y4hsfb/rWgJ20=
X-Gm-Gg: AeBDieuAy+UxcAMXPhzxgYJoMts5Dkgr3/cpSrneqigAJGRTDMGXtzvgZD5OtrgRhTf
 g0/+shktA/MmhV0spItYS/n9e6DUIIFDmz60bC25GRffFuwKNaHXyDmxNOHy3ltlAHIDaSl+Iff
 ouVpShpQwMGJBHwLONPsubp3NIlIzljWuVgDbenNKXqSe1SFGXO7OYmosbMoqppqBM7LzdlGYIT
 OdoPt8ZT4vhQQg0DwMv91YZDj+f+rYRp4tdsUN4N0QCbTqYMnMRZ97KwPWpMl4JF1EXuFHmKUMH
 jJ0m29lp/0UQ5FvLBpGSAw/2SU62025yos74eY3mMR4bH1B3JJygAfisUOI2Aiygi7ewLXwyJRC
 eXtmw18hKyrjmvR8Bb5jAmICBX2iqt2ZD/Eo7t+RQbFbTBO3+pIEEyLWloPW+Gp788hBVxRageb
 d+QMjnLW5sDjg5dPM2P8gzbE/MwiSOXjcqdNwpUEbC+faGWjAh4P/SGuoSgs/lw8WhXh5AWojT0
 NObOSE=
X-Received: by 2002:a05:600c:8012:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-4889974a416mr339869645e9.11.1775721668044; 
 Thu, 09 Apr 2026 01:01:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213?
 ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cf9f350asm36818435e9.8.2026.04.09.01.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 01:01:07 -0700 (PDT)
Message-ID: <aea62a67-6634-4ca5-bd41-5a5de7c639be@linaro.org>
Date: Thu, 9 Apr 2026 10:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] configs: libretech-ac_defconfig: enable EFI Capsule
 on Disk
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-3-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-3-6f3386eb5124@postmarketos.org>
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

On 4/8/26 22:30, Ferass El Hafidi wrote:
> Everything is already in place for EFI capsule updates, so enabling
> Capsule on Disk is fairly trivial. This allows updating U-Boot on SPI
> flash from Linux using fwupd's Capsule support.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   configs/libretech-ac_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
> index 1a67ca734b8..17d54655017 100644
> --- a/configs/libretech-ac_defconfig
> +++ b/configs/libretech-ac_defconfig
> @@ -23,6 +23,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_REMAKE_ELF=y
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
>   CONFIG_FIT_VERBOSE=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
