Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA258D62067
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECD78952A;
	Tue, 19 Nov 2024 11:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JDt3KYlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A408954E; Tue, 19 Nov 2024 11:21:22 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A31089177
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so26119235e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732011679; x=1732616479; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+v3V7/Yvy40r8hJUn4l4bpZ5YcusuJ//+DTIiWvL/bw=;
 b=JDt3KYlKAMxIjxyIYLblMsNrSSopwBB+zbmv/wp9ANy+iPEtunVPThVbCJtctTQi6I
 4Mt6JrE4jF/zab2rbo1qCbWZTD8wmaPe2Z+WqAkIuet6csCaVCOd6SvlTZ2J2iG1hx70
 Nj6e6Tspf3imx9tBofg4Dk3K0RcHEgLCAhEJDuKaUdV7z7pJVUGiHb/LFzEmzTSQ7iWI
 gFwfgUZk7drS/7YwdP6P8nK8En3Gm2cSRZpcPj86f+aVeDE3utex6lNpPWIUjIUHT2Ig
 B3NYxIPfa5Exoas3KYHW2d3dGuB4zj6EWeAiB7LMtC4B9Y4ygZYyoDzWZwQWGWTIXO8m
 njHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732011679; x=1732616479;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+v3V7/Yvy40r8hJUn4l4bpZ5YcusuJ//+DTIiWvL/bw=;
 b=SU0SnERbXyKqXWcOGu0koD91Bb7xkIUSE7MgnVMzTQvoqv4NA5zMN6U0lH7d7Xog2N
 ST3wuGkpB7a1dgdfsxJIgVWUzz7wl6psunAoAjZCqWj1afFH5gcjpQMIgynqWL4U+KAc
 nNoUriGSQqja43Oil0LvTWNUZgFm5pwh932G2KBDL//M5AByNfqqUyJHRjrgL3lTmzE6
 BsBZ/8HBVNTn2RHBS9uUiXUYFjOWDr8X7CsqTYF2F4wh6CR+y7C23LN3FXjH0Ktbp/DV
 xxeQ2aaciUHWZ6WhNcmHNe8kP/pglynuTtLXErKSxEYBTSr8Ob2zeqrm8pvu2nkIiOAl
 FvfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcSQyUp0Xg6i8t+lhYHl5Xb/cN9XAiYHVTrXR6phAFYlV7nk0Uw6eSBx9LXsnNM8iVuB1nqHI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm0kSqEslNZeFfQQvCIhcVXfEdgJFmR4wVjdxHrvpnu8fnje9e
 idhT6Fe1BpzjTq9ix9Ik3Lr1oN52pElsTP+bWoeNbeu+1ZG0KwOOUeoIyBo4lV8=
X-Google-Smtp-Source: AGHT+IGFnQbbOX6u5oxRmG8m8X0WvKETFZTNxx0vyhsJaNLTVXqxd1MmLyUn5k2mZ1FS7v1KTI/3aA==
X-Received: by 2002:a05:600c:a16:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-432df72a5a6mr152478955e9.10.1732011679651; 
 Tue, 19 Nov 2024 02:21:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5b1b:986b:b33e:8eee?
 ([2a01:e0a:982:cbb0:5b1b:986b:b33e:8eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721b7sm187620515e9.8.2024.11.19.02.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 02:21:19 -0800 (PST)
Message-ID: <015f27e9-1e43-43fe-88b0-3250ab4ee9d7@linaro.org>
Date: Tue, 19 Nov 2024 11:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/5] Add support of Android Boot Image version 2 and
 non-AB image
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
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
In-Reply-To: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
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

Hi,

On 14/11/2024 22:29, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> patchset was tested on khadas VIM3 and VIM3L with AOSP main branch and
> android-mainline kernel and with TI AM62P with android release provided
> by TI.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Changes in v2:
> - Drop patch 3 (configs: khadas-vim3{l}: fix userdata size) already
>    applied
> - Apply Tested-by and Reviewed-by from v1
> - Fix comments
> - Revert malloc/free for slot_suffix
> - Remove vim3/vim3l stuff in meson64_android.h
> - Link to v1: https://lore.kernel.org/r/20241017-adnroidv2-v1-0-781c939902c9@baylibre.com
> 
> ---
> Guillaume La Roque (5):
>        bootstd: android: add support of bootimage v2
>        bootstd: android: add non-A/B image support
>        configs: khadas-vim3l_android{_ab}: move on bootmeth android
>        configs: khadas-vim3_android{_ab}: move on bootmeth android
>        bootstd: Add test for Android boot image v2
> 
>   arch/sandbox/dts/test.dts                 | 10 +++-
>   boot/Kconfig                              |  1 -
>   boot/bootmeth_android.c                   | 78 +++++++++++++++++++++----------
>   configs/am62x_a53_android.config          |  1 +
>   configs/khadas-vim3_android_ab_defconfig  |  7 ++-
>   configs/khadas-vim3_android_defconfig     |  7 ++-
>   configs/khadas-vim3l_android_ab_defconfig |  7 ++-
>   configs/khadas-vim3l_android_defconfig    |  7 ++-
>   configs/sandbox_defconfig                 |  1 +
>   include/configs/khadas-vim3_android.h     | 26 +++++++++--
>   include/configs/khadas-vim3l_android.h    | 26 +++++++++--
>   include/configs/meson64_android.h         |  6 ---
>   test/boot/bootflow.c                      | 29 ++++++++++--
>   test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
>   14 files changed, 208 insertions(+), 47 deletions(-)
> ---
> base-commit: ce427e40a2422b75374ee3404e3f5c6536e8984a
> change-id: 20241015-adnroidv2-a01dca609707
> 
> Best regards,

To whoever applies this patchset, please take the configs patches at the same time!

Neil

