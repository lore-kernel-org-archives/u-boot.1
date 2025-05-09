Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5092EC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAAE822D7;
	Fri,  9 May 2025 09:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vcjW6EDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C22806D8; Fri,  9 May 2025 09:56:31 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5371C822D7
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso11961615e9.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746777389; x=1747382189; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6d5OttQ2yXQra1+rh5D/qH1+rbl79e3GdoLmqSd8Rvc=;
 b=vcjW6EDUPknlxV1xyyQb0ySIIKlgvM04pHv1/p7i/0L7pY0//XohSgJWeXNoK9m/hm
 knaR1kbsbQdibTxEgxjnXwZa57+EOpJPSxtdYSHt5yQ1lHODXfENCeSImJyY/BS/J5sa
 JD+OezG8ENLRTp2uft+HjzP4EYvquzfchOIybIRRIDn4+DVtmmMs9VUr0hH6hQftQs3t
 R+gaeHVh0+o3hYEPjQ20sHXKoRWhk2kH8i1X31Mh4fIorUwD/CUPOmjHl2Ax/EL05sli
 v9l6s8L3NTc256xrW3h0GZOnYfIG3bXHDdMOK+sXTy0CdwgTCARJ9LwFMKYFFqD+pGY4
 SUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777389; x=1747382189;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6d5OttQ2yXQra1+rh5D/qH1+rbl79e3GdoLmqSd8Rvc=;
 b=IipuZxljW5ZFnL1FTmEs97xYahCujfBKaRRzPCFvgBNBhaEMrLD+D8FXZntg1lKaKm
 qXTX6oBQCGVjDdggzFxLrlUM0ei/4OCC9IJDV3gF5b4YQd+K1ZxcOS9RdSZif8cc7m/u
 OcMofio2SdNaaC5USffZrsUM9jyBmjcSQgvrtI3V5/P2yr8GFLZNhFLOxEc1bAKyIjzr
 dY1HRhQccy1D3Zo/nJruh8HUua9tnueRbz4p/+r1DQccxpLekOJeXlVUmHaqJxJ98H2O
 Qto/S/GQTCaX7QvVnO6pExO2gutl73soRmGdrkOH60iEuEg29U3R8wwabWh/cx5fusXg
 np6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzwvf1zKGlb0ML3Km97IblrPVoYalbDxFrLgyiqqcvyJaNO7R9T/uhPx13H+5lo012DmpjNfk=@lists.denx.de
X-Gm-Message-State: AOJu0YzjTPVTYH/ltKlzAtLY9LRLCEJ+SXH07HCLp4eS7TKHharO56Oa
 w1pRyVgZRgMuNB1E3O3yFFiSDFNJqYyDXqpoEhMJCxxWJwY08/SO7Yhv39/ZTQ0=
X-Gm-Gg: ASbGncsr5nq+XBGSMMJzX3djB0WtQ32pWepcTR/5Ue3z00w+RJBrK2OPe4Ld0BP83yH
 1OQREyRVZNXZyZo/mO7PM05IaX5GKBTL01hUaUOTUYOIS3rca9rJhi6HMvc0EDulDwcK0JDMiJT
 XHyULNicIv2J9RU4UN8vRawGaMSmDInfcO2jfE474aS2+eUEH/kg5jRjC5TeCeoL3aFP3jPogbd
 6uptyWKjO2OtLK7fFDHXAS5DxINHSWdZ8rFK6yWMS3HofcY3p87I8mpV6u6pTpwViB7uBN5vxOj
 MZx7FUgCtraod/RVK6xZuZX296DIqtXgZHjbsrLR35FOoOTAXEKfXSg5EZXMEZ0nCsHFW18rctO
 EM7cVWlrAkodnxZId1h/UHa8lnQ==
X-Google-Smtp-Source: AGHT+IE4r787EqeWN5hkVggL9Owkxa7wQTIrh+SRwwXQ6XYsAl8aa896gImLteC7wftHff8sUwjhYg==
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-442d6d44aa7mr22221275e9.10.1746777388825; 
 Fri, 09 May 2025 00:56:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2?
 ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ed0a5sm2401350f8f.21.2025.05.09.00.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 00:56:28 -0700 (PDT)
Message-ID: <5c3f5474-5b5e-4e73-baf7-b211c482badc@linaro.org>
Date: Fri, 9 May 2025 09:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 2/7] configs: odorid-c2: Enable Onboard HUB driver
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-3-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-3-linux.amoon@gmail.com>
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

s/odorid-c2/odroid-c2/ in the subject

On 09/05/2025 09:02, Anand Moon wrote:
> Enable the onboard USB HUB driver to power the
> USB_HUB_GL852G-OHG on the Odroid C2.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   configs/odroid-c2_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index bcaab46f8bc..f8a66a923c9 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -59,6 +59,7 @@ CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_USB=y
>   CONFIG_USB_DWC2=y
>   CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_ONBOARD_HUB=y
>   CONFIG_VIDEO=y
>   # CONFIG_VIDEO_BPP8 is not set
>   # CONFIG_VIDEO_BPP16 is not set

With that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
