Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3303C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3E2882B7;
	Mon, 24 Jun 2024 14:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yysZ9Gc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9CE4883B1; Mon, 24 Jun 2024 14:56:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E64288137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so34993225e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719233758; x=1719838558; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NQFUJ0T5gUV8EnE+EizM2UPNOSwenUjO04Rq436gr2s=;
 b=yysZ9Gc0hE4nwPhH3AyVl+iWfhifAbdHXE1wQ6liQSAoB4ITu7RxktW2Ubq8vRVD1P
 NUprvOBrcFb60mIugGdzO55O02U+1Nre61TFGqeAkcV+VwEKyt4IzfHLf2qYXrWhOg8n
 ncxrPdIPQRiJZ/B09FrQ9qhhxUWgTVmzs/8/UeBAITLNHR4T233hUhIyossakta8wpgG
 pymdgxq8mE8bJM2ef2glLQIkLjq0R8BvKvBa2fOxIZipH1eBxfg/Bd81+cijnBCrsU+R
 VPDPDh/TpP61kXj1syGmNOJimbKbb9/kf3gM9p87wwHpnI3HEyi8sD1khW2nrKqtKkQE
 IFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719233758; x=1719838558;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NQFUJ0T5gUV8EnE+EizM2UPNOSwenUjO04Rq436gr2s=;
 b=DBl/bxkkabuaigm67XCfPftkrJm76yTaraS/o1Q1Hvri4+5MgcF7BoRvtkm8juYB2L
 XJOIAyV0bPnfvDd/x8yTCwl06bk1CuzTpBjdR/AS6JrAQ3RiQ+ENSfnXLRqVZko+IwYr
 KP2ZvWqbparsJURovy/WR5FXgpt9bfOEv6JJfLM+TDmJrHidC/uFWwpj7u1YTjyAPHLX
 fxfi0W8qTKu+NKvP3tHB1B31s9WJTkG5SGJ+ZYkpt3t/E15Kp6BCgrL6oS0DEaTLkIn2
 yuQVM1aTaAtVT0BK4yXaUk/VIxMI2kDKqDMYKrb2B2bD83qTP4kAkL80xjUIHnwLsXjW
 gHvA==
X-Gm-Message-State: AOJu0Yz79GRfd1wgykLjx6NxCQkoBYlLy3pU8xXhN4EH6u19Kk+Zl8fs
 5MhiP/3kp6Ur4Yii72TiX8sUOyAY3AMfzwDenGYh6LwBieXriLl/E9R9gnmxZcU=
X-Google-Smtp-Source: AGHT+IHFV2G0VZs9w3QsJr/7hZHyVlXD6gxmZIjzOzd2RbzA7EDtb+CnvwK1Z8bhzhNZu1oVt55/jw==
X-Received: by 2002:a05:600c:4348:b0:421:f441:e7e7 with SMTP id
 5b1f17b1804b1-4248cc33c88mr29769605e9.19.1719233757424; 
 Mon, 24 Jun 2024 05:55:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74?
 ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a9981sm137880855e9.17.2024.06.24.05.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 05:55:57 -0700 (PDT)
Message-ID: <5448973e-bde0-42fb-b331-57497bbeb80e@linaro.org>
Date: Mon, 24 Jun 2024 14:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] mach-snapdragon: move default environment to a file
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240624123255.2590424-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240624123255.2590424-1-caleb.connolly@linaro.org>
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

On 24/06/2024 14:31, Caleb Connolly wrote:
> Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
> environment to a file under board/qualcomm.
> 
> This is much cleaner and means we don't need to recompile on changing
> the environment.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v1:
> - Don't set bootfile
> - V1: https://lore.kernel.org/u-boot/20240617085629.1744017-1-caleb.connolly@linaro.org
> ---
>   board/qualcomm/default.env | 11 +++++++++++
>   configs/qcom_defconfig     |  2 ++
>   include/configs/qcom.h     | 16 ----------------
>   3 files changed, 13 insertions(+), 16 deletions(-)
>   create mode 100644 board/qualcomm/default.env
> 
> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> new file mode 100644
> index 000000000000..dbf6f4e72600
> --- /dev/null
> +++ b/board/qualcomm/default.env
> @@ -0,0 +1,11 @@
> +stdin=serial,button-kbd
> +stdout=serial,vidconsole
> +stderr=serial,vidconsole
> +preboot=scsi scan; usb start
> +fastboot=fastboot -l $fastboot_addr_r usb 0
> +do_boot=bootefi bootmgr
> +bootmenu_0=Boot first available device=run do_boot
> +bootmenu_1=Enable fastboot mode=run fastboot
> +bootmenu_2=Reset device=reset
> +menucmd=bootmenu
> +bootcmd=run do_boot
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 25fa8b0f7d2b..4ff280fc6e7d 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -46,8 +46,10 @@ CONFIG_CMD_LOG=y
>   CONFIG_OF_LIVE=y
>   CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>   CONFIG_BUTTON_QCOM_PMIC=y
>   CONFIG_BUTTON_REMAP_PHONE_KEYS=y
> +CONFIG_USE_DEFAULT_ENV_FILE=y
> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>   CONFIG_CLK=y
>   CONFIG_CLK_STUB=y
>   CONFIG_CLK_QCOM_APQ8016=y
>   CONFIG_CLK_QCOM_APQ8096=y
> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> index c13a847f62f1..b7d38866c51d 100644
> --- a/include/configs/qcom.h
> +++ b/include/configs/qcom.h
> @@ -10,21 +10,5 @@
>   #define __CONFIGS_SNAPDRAGON_H
>   
>   #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600, 3000000 }
>   
> -/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
> -#define CFG_EXTRA_ENV_SETTINGS \
> -	"stdin=serial,button-kbd\0"	\
> -	"stdout=serial,vidconsole\0"	\
> -	"stderr=serial,vidconsole\0" \
> -	"bootfile=/extlinux/extlinux.conf\0" \
> -	"preboot=scsi scan; usb start\0" \
> -	"fastboot=fastboot -l $fastboot_addr_r usb 0\0" \
> -	"do_boot=bootefi bootmgr\0" \
> -	"bootmenu_0=Boot first available device=run do_boot\0" \
> -	"bootmenu_1=Enable USB mass storage=ums 0 scsi 0,1,2,3,4,5\0" \
> -	"bootmenu_2=Enable fastboot mode=run fastboot\0" \
> -	"bootmenu_3=Reset device=reset\0" \
> -	"menucmd=bootmenu\0" \
> -	"bootcmd=run do_boot\0" /* first entry is default */
> -
>   #endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
