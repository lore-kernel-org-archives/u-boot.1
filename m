Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C65C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFB68212F;
	Fri,  9 May 2025 09:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q11DQIVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE8982162; Fri,  9 May 2025 09:57:04 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37BDE806D8
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a0b308856fso1204643f8f.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746777422; x=1747382222; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=efmHCeBgTnRYS40xzMd46bnQ79NApzG9AwWl8mFsRHQ=;
 b=q11DQIVRLprB9l68rcdmWZ0TUi7yVbS1cvzvInWxvmlopzvQt7F31tV0CN3ZF8j9tt
 6qq0Vp0JJ98+zVlxqY9/iH1ZRg3yjUuQUggBI/6Q/Z+IiUYa8vrPwq/ZY8JiETu3xdM1
 Gbqh2uklYUzbVIBz55kYZRUX3fpRMUZzv5/3UCCxJ1Z7VwEX4c6MGclAYPXVi/bB5F3d
 5yQTRYpKgh/DeE92d1dqHINiTPNFxtxPChj/Zqvwh1qmPH6sfgUyaj6kQWi7VF3F5O3b
 D36BZJBzZ29+2pyELVfPV/6ketPSLl/auCOzPX6xxEt5tViGD+ekGHO4Hx0YiBJp0lbZ
 V1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777422; x=1747382222;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=efmHCeBgTnRYS40xzMd46bnQ79NApzG9AwWl8mFsRHQ=;
 b=ZNHay3XjwnWZg9+MTc1RmTXH/Ww0ZltOxMiKCJkpOSYKn51ticu4X/2RrJt6Ne20Bh
 UxQ5IMxlo9SBHhSxzHigCR0h93djRfU8EiC5jZ0rQ+erKNKLBlvRxkRVpT4QnGF2+rhc
 voSJTwxk+jvYZWiUHuaYrWJA0EIkGozxUvwahQo5TviffPWN5ScxI6URq6+ve4T1a8yt
 ojspmLZK1zXL5bk1Uwa3Ar4ytDk9f2WsHF1YiJrXQmpswR7XdpuoVjMuK1bx+nQhrKNJ
 Por0oKDyEv+5s/cZi/A6Se5krLtUoi/hrKneB6c1xGEZ2TbrtP+WMD3FIPK+EOn3DAH8
 ALEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMEqarLfWwrvvaOZ69RdXUIWIpdGH1zs6/bbRTmZjAV2FPPhMAbQJbiB8Uyr9mg2/HAm9DwkA=@lists.denx.de
X-Gm-Message-State: AOJu0YzZcN7fdNR5XjzMnjw+/PxNAkZbk3to8VWEjjgh+EKjrDt9DCTl
 T5tOlZpIdVIU34Km8UMgMcbYuNR2+F5DaHqzKViHp96O3MsnGzG+HuxHMSJ1aM0=
X-Gm-Gg: ASbGncthwDqgixsgt/KrFdQqrXqr4/P5wtCrx4vPegPWGgcGvZtiCFcIz7KpRjBSkC8
 VU4mtd/gmha8Fr5LFd20uNsengXDibNh0XvxR5i/es0tVeH/JVg4x02jkYtS/9s5vxNy74gZd3q
 xGsOsHAkx8NJFpo7y7DF6lzAAoZcjnkfByFgN/VQvKhLkN4+MBO+HqBBuim2b4oPLdUM5hd0OWk
 cNfMXpEddPqcyDvUOfz8CkBMD9WC89eU6I5b9gYIoO7HBZuO/ic6B5v7BVQft1K/wB6q43eyyyW
 puGmfi/plDdy1ZzJTgsmgHyfTVQpY6Y0DDbEyEI6mpQw7+Hfrb1MOBI+0RAiBCXD2FP9+zy/Uru
 Wp0eN2uXU11Wg4epu4XUJm3tSMw==
X-Google-Smtp-Source: AGHT+IHxMLKpcJspff1fQ+F7Z5n2uc9edRCypRUuWDy9YHmNaHGAj3wg0csJTx22YfeP+Cnyzaw4zg==
X-Received: by 2002:a05:6000:a91:b0:3a1:f5c6:2bd with SMTP id
 ffacd0b85a97d-3a1f645f228mr1773158f8f.31.1746777421662; 
 Fri, 09 May 2025 00:57:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2?
 ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ec98dsm2408874f8f.25.2025.05.09.00.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 00:57:01 -0700 (PDT)
Message-ID: <6ca82786-94d0-4df2-a2dd-62b21fffb8b5@linaro.org>
Date: Fri, 9 May 2025 09:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 4/7] configs: odorid-n2: Enable Oboard HUB driver
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-5-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-5-linux.amoon@gmail.com>
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

On 09/05/2025 09:02, Anand Moon wrote:
> Enable the onboard USB HUB driver to power the
> USB_HUB_GL853G-OHG on the Odroid N2 and Odroid N2-pluss.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   configs/odroid-n2_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
> index a8cbaee3c96..1bf687c1e6d 100644
> --- a/configs/odroid-n2_defconfig
> +++ b/configs/odroid-n2_defconfig
> @@ -64,6 +64,7 @@ CONFIG_USB_DWC3=y
>   # CONFIG_USB_DWC3_GADGET is not set
>   CONFIG_USB_DWC3_MESON_G12A=y
>   CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_ONBOARD_HUB=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>   CONFIG_USB_GADGET_PRODUCT_NUM=0xfada

Same as patch 2, with that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
