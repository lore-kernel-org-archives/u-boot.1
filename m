Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D9DCD11BF
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 09:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB3A87B30;
	Fri, 22 Mar 2024 10:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FGXVuxw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0EA8785E; Fri, 22 Mar 2024 10:03:35 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C5487D14
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 10:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41477211086so11521915e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711098211; x=1711703011; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TAMH4/1/LYbimxnBM2qb1P0iwDi2hwCWc/v5hXsm8Ms=;
 b=FGXVuxw1FUkgbxxwJzqaxrvN05AQeMg7b9DNBDZDpfzIHFEHJi3lhmOIYPRrhe+Tp1
 TXC/lPqKrKoN8/Qwcv2w8+Z2f0sNt87XcfZwZm5Rqry5YKbGdVXmIuF+twb17fjXlI/9
 1aGcJ5GevEXwQkuZtcjfE/HXkLs/FjFjQ2NW4zmeJt8NITLkW3NPCvTpiJxO0vXcpkfl
 ju6kVz+QgDrTZZSQ05C+hFxWotWsKqNkSBCLAlw3wiD5U+wLvcIG5DOk95QQ34CWAgwD
 5Oy59TbnlH8CozzPtyJL2jovYfMT0G+1qRjx9yCU32rHRwM/x/lvIpdNfhrktOS6tkk3
 W54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098211; x=1711703011;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TAMH4/1/LYbimxnBM2qb1P0iwDi2hwCWc/v5hXsm8Ms=;
 b=E+VKbx3mxKWHuE8Ovv1vix05VnBwq573ynm6i1DSokFKIPwYCX+uy/3GL/2HWqPzdr
 oPmdpAnCyYHUEEBRFeU0yPgQxOBai7Zw8GWxHtrgdB0o3DgqIsdeMaUnjBED+HQLvm+w
 pAI8gBPHRzKyE/RirCrtj95d6HDCZ5WCCdEDXGGNfj0+EWSOJ0Sp4HQblZLf029CshU3
 hWRuR5hOetrbeGPC7hHzLWIukQ6TNh2AxjHCQx58egRN+3h5LEV7b4TWN6jnSddcPT6/
 y7+PWQOn2XTZCMX6J7VFlSrxf8hU+LURUFS0MliKmWSovsZ7PwUaF8MzdG0a+yUcWgiA
 7mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdimUTGNGj4LiG2TnE1dRG4qpb/2x8fiNRoqO1p7RTTkodpt/qrsh0bL9XsiEgMmQnsHlrVEIYmiulpqz6TPOjqx3vKA==
X-Gm-Message-State: AOJu0Yyzg7Z/TAwCvXSYWWz3OKcGBFrcxX2X4JBGZ1OisgZiw9RPIUb1
 m8k+82yD2J4GeFDP4v46FhR6XFeK5T6W1RpIECdG08qOA3GFGA9d5p+vQFl9JEI=
X-Google-Smtp-Source: AGHT+IH+4xiURJc6/0bVtCz/XerbSHompPf//FltcoDBPPgwWzNRgo34ybvyYAtJ3AicoVAJWRiakg==
X-Received: by 2002:a05:600c:1f94:b0:413:2ab7:4396 with SMTP id
 je20-20020a05600c1f9400b004132ab74396mr1421726wmb.18.1711098210437; 
 Fri, 22 Mar 2024 02:03:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7?
 ([2a01:e0a:982:cbb0:3ee1:a278:2b57:55f7])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b00341b451a31asm1351464wrb.36.2024.03.22.02.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 02:03:29 -0700 (PDT)
Message-ID: <045a8bb4-e061-4727-9f07-a55825a99518@linaro.org>
Date: Fri, 22 Mar 2024 10:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM, 
 AXG, G12A, G12B & SM1 SoCs
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Christian Hewitt <christianshewitt@gmail.com>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
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
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
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

Hi Viacheslav,

On 19/03/2024 15:42, Neil Armstrong wrote:
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
> 
> Keep A1 DTs locally since the architecture is still young.
> 
> CI built & tested at:
> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (4):
>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files

Could you run a test run on your boards so make sure is still boots fine ?

Thanks,
Neil

>        dts: meson-g12a: Switch to using upstream DT
>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
> 
>   arch/arm/dts/Makefile                              |   36 +-
>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>   arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>   arch/arm/mach-meson/Kconfig                        |    4 +
>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>   configs/bananapi-m2s_defconfig                     |    2 +-
>   configs/bananapi-m5_defconfig                      |    2 +-
>   configs/beelink-gsking-x_defconfig                 |    2 +-
>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>   configs/beelink-gtking_defconfig                   |    2 +-
>   configs/beelink-gtkingpro_defconfig                |    2 +-
>   configs/jethub_j100_defconfig                      |    2 +-
>   configs/jethub_j80_defconfig                       |    2 +-
>   configs/khadas-vim2_defconfig                      |    2 +-
>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>   configs/khadas-vim3_android_defconfig              |    2 +-
>   configs/khadas-vim3_defconfig                      |    2 +-
>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>   configs/khadas-vim3l_android_defconfig             |    2 +-
>   configs/khadas-vim3l_defconfig                     |    2 +-
>   configs/khadas-vim_defconfig                       |    2 +-
>   configs/libretech-ac_defconfig                     |    2 +-
>   configs/libretech-cc_defconfig                     |    2 +-
>   configs/libretech-cc_v2_defconfig                  |    2 +-
>   configs/libretech-s905d-pc_defconfig               |    2 +-
>   configs/libretech-s912-pc_defconfig                |    2 +-
>   configs/odroid-c4_defconfig                        |    2 +-
>   configs/odroid-go-ultra_defconfig                  |    2 +-
>   configs/odroid-hc4_defconfig                       |    2 +-
>   configs/odroid-n2_defconfig                        |    2 +-
>   configs/odroid-n2l_defconfig                       |    2 +-
>   configs/p212_defconfig                             |    2 +-
>   configs/radxa-zero2_defconfig                      |    2 +-
>   configs/radxa-zero_defconfig                       |    2 +-
>   configs/s400_defconfig                             |    2 +-
>   configs/sei510_defconfig                           |    2 +-
>   configs/sei610_defconfig                           |    2 +-
>   configs/u200_defconfig                             |    2 +-
>   configs/wetek-core2_defconfig                      |    2 +-
>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>   116 files changed, 42 insertions(+), 21511 deletions(-)
> ---
> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
> change-id: 20240319-u-boot-of-upstream-46454fded5ea
> 
> Best regards,

