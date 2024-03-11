Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21723C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9838687F7D;
	Mon, 11 Mar 2024 12:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QAnBKBZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE160871C0; Mon, 11 Mar 2024 10:03:48 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FD087F03
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41329a665d8so4848895e9.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710147824; x=1710752624; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iLD3U1Mg6Q5EurtQ0xeMpGRIWV45FrY13A3s+WrKuzE=;
 b=QAnBKBZZGbQoGx5DYRz0mXe/YYnT4SmUM8rT8p5M72rqioBrAOd6KHdp8PDpzvFj1R
 eFqMbXSkfl1r5T2grAkmU6Su0mui7wog51WYGUU9jtGmHpNsbNCv/Wnqmi9u3hjx6XAR
 hy0ZNEUTYzri7jiKX9XduR/KpHHYKmh4oz8BgW1gLTdWOPO5AzB3rqVjcynsp8EHZtie
 u9TQh26xIW6xxcrHXc8TrDxPOkcas8eMw+zWF+i2MAR1Z7cFgFdcnQoiw/OqiAnPsq0E
 ZfxZWBARDr2crlFQfAwXiK9GA40oY/PjqEM+5w5R0tXbStQ9yXQdb7cVeWOPZ7ufUPnY
 Xxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710147824; x=1710752624;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iLD3U1Mg6Q5EurtQ0xeMpGRIWV45FrY13A3s+WrKuzE=;
 b=jP8HZhZqE+ggwKxWa5/jksvUDSoqV+7Hpyk8501JoY7ihgpQkw+T63SAF/IKC/Ma63
 p1P+FlmQudseFOJD1Ei0lNP4Im3aa3HmXuH9KTcH0R20/NI5db7z/gWRCImPwe2NZP/h
 COtVrag5Ny0+4lvZemhH0WWdEr6nC2ntAr+yIFSJrxEDDRUilNjb7hcFj0584MS7ACdn
 dw8Wq87+1n2aX1kzlp2GK33gK6u6Cv/OZGRgd/aFlDjiWgRh0xMGqTV578NWn5dWYmMN
 obpbcdhDEZKjqLTOjmIcJnX+wy8dQ2xrmpTSH8eOh856PTmY1R+Bsv/ZjiuogIg0/p2b
 8GGA==
X-Gm-Message-State: AOJu0Yw6Wy9g4Uy4lx4+t9t60qbDk2MItWDamo+WaRWuaQOJLiBcdiLI
 uphWsVTxVvDM0LBW/2sByc21DXxWikUxSwu9TRDcJcGdVJupJUMCk79FLLggZfk=
X-Google-Smtp-Source: AGHT+IFJb1UlflnRJ1vxhZx5SlBp8RLThAKmOnxRp9zlqajiP3YFRHqq90hj7AqLg3nLXeETPQmCLw==
X-Received: by 2002:a5d:67cf:0:b0:33e:7380:df37 with SMTP id
 n15-20020a5d67cf000000b0033e7380df37mr4241387wrw.58.1710147824290; 
 Mon, 11 Mar 2024 02:03:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:48be:feb9:192b:f402?
 ([2a01:e0a:982:cbb0:48be:feb9:192b:f402])
 by smtp.gmail.com with ESMTPSA id
 t17-20020adfa2d1000000b0033cf80ad6f5sm5907774wra.60.2024.03.11.02.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 02:03:43 -0700 (PDT)
Message-ID: <b22c78b3-09a1-4c7b-98be-87fac3bcd3af@linaro.org>
Date: Mon, 11 Mar 2024 10:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 07/26] amlogic: drop dt-binding headers
Content-Language: en-US, fr
To: u-boot-amlogic@groups.io, caleb.connolly@linaro.org,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com,
 uboot-snps-arc@synopsys.com
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-7-b7ff41925f92@linaro.org>
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
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-7-b7ff41925f92@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 Mar 2024 12:12:53 +0100
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

On 11/03/2024 09:51, Caleb Connolly wrote:
> Dropped in favour of dts/upstream
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   .../clock/amlogic,a1-peripherals-clkc.h            | 168 ---------------------
>   include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |  25 ---
>   include/dt-bindings/clock/axg-aoclkc.h             |  31 ----
>   include/dt-bindings/clock/axg-audio-clkc.h         |  94 ------------
>   include/dt-bindings/clock/axg-clkc.h               | 100 ------------
>   include/dt-bindings/clock/g12a-aoclkc.h            |  36 -----
>   include/dt-bindings/clock/g12a-clkc.h              | 153 -------------------
>   include/dt-bindings/clock/gxbb-aoclkc.h            |  74 ---------
>   include/dt-bindings/clock/gxbb-clkc.h              | 151 ------------------
>   include/dt-bindings/gpio/meson-a1-gpio.h           |  73 ---------
>   include/dt-bindings/gpio/meson-axg-gpio.h          | 116 --------------
>   include/dt-bindings/gpio/meson-g12a-gpio.h         | 114 --------------
>   include/dt-bindings/gpio/meson-gxbb-gpio.h         | 148 ------------------
>   include/dt-bindings/gpio/meson-gxl-gpio.h          | 125 ---------------
>   include/dt-bindings/power/meson-a1-power.h         |  32 ----
>   include/dt-bindings/power/meson-axg-power.h        |  14 --
>   include/dt-bindings/power/meson-g12a-power.h       |  13 --
>   include/dt-bindings/power/meson-gxbb-power.h       |  13 --
>   include/dt-bindings/power/meson-sm1-power.h        |  18 ---
>   include/dt-bindings/reset/amlogic,meson-a1-reset.h |  76 ----------
>   .../reset/amlogic,meson-axg-audio-arb.h            |  19 ---
>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    | 123 ---------------
>   .../reset/amlogic,meson-g12a-audio-reset.h         |  53 -------
>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   | 137 -----------------
>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 161 --------------------
>   include/dt-bindings/reset/axg-aoclkc.h             |  20 ---
>   include/dt-bindings/reset/g12a-aoclkc.h            |  18 ---
>   include/dt-bindings/reset/gxbb-aoclkc.h            |  66 --------
>   include/dt-bindings/sound/meson-aiu.h              |  18 ---
>   include/dt-bindings/sound/meson-g12a-toacodec.h    |  10 --
>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |  13 --
>   31 files changed, 2212 deletions(-)
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

