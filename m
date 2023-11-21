Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA57DC5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 09:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 997EB8757E;
	Tue, 21 Nov 2023 10:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ycsJK0Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1A8874E8; Tue, 21 Nov 2023 10:18:08 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673F8871CD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 10:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso3415896f8f.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 01:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700558286; x=1701163086; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=In9SnW6V42J9lK1zUchnAXRX4VyoLJCwhg874RYUt90=;
 b=ycsJK0Hzteyvyhc9gvgcVw7HefRrFcKnPC2h/KCkqUF7mkh5CAwI5CvAMdsUgpFMAc
 y3sr8F1aE9272moMpIEEiJo6SiTGAuDNcLjuHaB9UbVG8GxzVbFWa4lS0vDJy+tvQvxN
 X676yKWwbym5tV0XzfbX/LvzOB6ch3Ln5PN5lDrzvJPhK3maEkjMJAvNrTa3pNaQiQqh
 uH4obKw46zFbv0Rd8/ex4H1Bjlq9eXPBpJ0AerZv4COWrhVWmMeLZ9KgtyMUBdJNS6KZ
 RYN5R8mpNQlHz+mrQPMYhc8oqZnChvQbxAbW+S3mIRso2FVj+jNvLPX4z09gRt9lrzDU
 i2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700558286; x=1701163086;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=In9SnW6V42J9lK1zUchnAXRX4VyoLJCwhg874RYUt90=;
 b=rjiS1/sBtgHGQTlgLYf8qs31ENsB2CLKaF5bN9sd5iceMpcxIm1sZZMOP3eDzbCVhB
 JbGMvDYmKcyZsnh7CYZOF7IpRHDSzZY1GSjhjYiF83MvObUqab+RjNKSyHS35sMWsRNr
 1gI4WTHXVszzd+uct7I3cTERz2SNKduRiWp+7PH+9ohdY29az/49EZYYTFFWlJJi7KRG
 h7k5XBzcx5zrEOnLPHDIMb0aa95/nRJlFhTwHeSIOH4P9/fdleA2FdBfJnF0db6dwqPT
 ayhHGMHaBlP4dZLMAiwX+7QlUmrAQCnn6h5XTwZEIBH3/mIEdU5rd691oILh7B8e0E9e
 WWlg==
X-Gm-Message-State: AOJu0YxJAPSOa5fVxQJz4goA7eQcvtKtBxARqLfRhfUCJW35jo5BGrAE
 S0pa8rysywOtm1MVF4VrYqQ9oA==
X-Google-Smtp-Source: AGHT+IFh1j3TmFbCNxOBS+eQs3WV7FIaJmy/wpDmCZI8cRh0wpzDULN5/Nr/hxnnqnHg3m8ui1ojSQ==
X-Received: by 2002:a05:6000:178b:b0:332:cb20:ddc2 with SMTP id
 e11-20020a056000178b00b00332cb20ddc2mr2923477wrg.40.1700558285741; 
 Tue, 21 Nov 2023 01:18:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a?
 ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfe841000000b00332cfd83b8dsm122642wrn.96.2023.11.21.01.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 01:18:05 -0800 (PST)
Message-ID: <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
Date: Tue, 21 Nov 2023 10:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
References: <20231120201609.619598-1-trini@konsulko.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231120201609.619598-1-trini@konsulko.com>
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

Hi Tom,

On 20/11/2023 21:16, Tom Rini wrote:
> Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> eventually display this information
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Posting this as this was the easiest platform for me to test some SMBIOS
> related patches on and I needed to populate the nodes so I could check
> things in dmidecode once Linux was up.

Sorry to be late a the party, but can't this be dynamically found from DT's compatible & model ?
Since I'll probably need to add this to all boards, it seems like a duplicate of what's already in the DT.

> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: u-boot-amlogic@groups.io
> ---
>   .../meson-gxl-s905x-libretech-cc-u-boot.dtsi  | 23 +++++++++++++++++++
>   configs/libretech-cc_defconfig                |  2 ++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
> index 39270ea71c8b..e56cd67a9d91 100644
> --- a/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
> @@ -5,3 +5,26 @@
>    */
>   
>   #include "meson-gxl-u-boot.dtsi"
> +
> +/ {
> +	smbios {
> +		compatible = "u-boot,sysinfo-smbios";
> +
> +		smbios {
> +			system {
> +				manufacturer = "libre.computer";
> +				product = "Le Potato";

I'll use the real product identifier here instead: AML-S905X-CC

Here's the downstream vendor change:
https://github.com/libre-computer-project/libretech-u-boot/commit/cb68b838f1b80ad201ec02f04d2841ee535b9818

> +			};
> +
> +			baseboard {
> +				manufacturer = "libre.computer";
> +				product = "Le Potato";
> +			};
> +
> +			chassis {
> +				manufacturer = "libre.computer";
> +				product = "Le Potato";
> +			};
> +		};
> +	};
> +};
> diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
> index baa9b1b3dbc5..24a46f50d0d9 100644
> --- a/configs/libretech-cc_defconfig
> +++ b/configs/libretech-cc_defconfig
> @@ -55,6 +55,8 @@ CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_MESON_SERIAL=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y

Thanks,
Neil

