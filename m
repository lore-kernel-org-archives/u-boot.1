Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF098C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8880E40769;
	Thu, 27 Aug 2026 15:40:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cGy_aui-_Xw; Thu, 27 Aug 2026 15:40:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787845258;
	bh=bd2QA/S7ITVCMx5Biz1Qk/lnjIt0ib92SwFAGygQiCw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mhSbhA8imnUxYThSFyZ63LJAxeGBQLjNji/rOyanbc7t/gFaVDU3BNsXPh5xMr6yx
	 mQAQuxrWjo+o4NOj7elQH/SsK+Gh7eQDss3f72Xgn/bkoMfbmQU1M6/ub6pwBOINx6
	 wGejKCksfIYy1cGfI4C25q9D99GhGNUwNYTvIrCtagluVu41A22YwTyxxCCLoTUncQ
	 eAw8He1voKwubCxry3s29OxlxgvYnhQmme0Vd99ZK0MkaTLPiIlpzm/0VDHMQJduld
	 CuVHqRJBaKogMwdxMAeluzZsGK1Z4a5M2RegRwBtJAhqgFNZi8rZhRJvTzDUQBzwse
	 nGTEGvLbQ7UeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACFF1407C5;
	Thu, 27 Aug 2026 15:40:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B04082FD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A070D40341
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqzD7juuQL87 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:40:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=a/TQdV/m
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 818F04032E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:40:55 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso19497365e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845254; x=1788450054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd2QA/S7ITVCMx5Biz1Qk/lnjIt0ib92SwFAGygQiCw=;
 b=a/TQdV/mcVZmdvHStRvHJppO9+/Rxc/Fot4NX0vUAKRogbeqbwaGY0V9LC0ZVUKoGO
 3PC7Qxb3Du7Wjk4pHCrAmJAjDcSElcZV/9I5CwrWMMVN4b+czhewvStgfODarO3aZhQe
 SCbAjUmOijlQhVkQFo6z5PZMSzabHgudrkzJv853dQ55a4F4aza7UzNw3bKYwXL1XJDH
 myBqqj8uEEs3Ev62BJsUDfYHHV21QEDLnMwj+MfYZlZn7Uq7m7DkWm3Td/ep3wmn6GER
 7cY5dYcaR0GDSCtL/LzmXpqyxVuZWNbUe+X17S9oRFkIlv8sKFtiIo3Wbuz+U5meZ+c1
 ww6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845254; x=1788450054;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bd2QA/S7ITVCMx5Biz1Qk/lnjIt0ib92SwFAGygQiCw=;
 b=ACyRICI5SXZfzteOiSl390nayXucLjVK8Ng6eJzDP/EXILM+03T5VEQhgwI4Vo0xTq
 WS1jo4t25ibxCbS82U9G14MPLV3YTUwj0LPf2sdljto2fWG2lQFIU6ebt3xGu2rqi/uV
 6EAchGnBmvNT1AylV0V764dIQQ6cva9/EW1Qb9VHEIqD5GuoxX0/ScalP+z1d+2GxPfG
 LxDteOjn+vRF9I6OQeabX1MOMW13B+VUR3LZp02yLttFf9SbQL5ZaNCr7C3jEXdT+l7F
 O74f51P0awAOKN4DnK9d2UG220uJsBML5IFVsLKfGzC0C1QhEm792j0iPtCTE1W3Prvr
 h8wA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsJSTNCfDYDLDQvcBj4TH7WkaUXj7qGdiXRs4LhXAXIDlb+QyLC9kCVOnYgWMDU0XnB5/H5Gw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mB4OoF9nHyzVU3rlqPnUN1icpGPpPuajGG4dlFfTMxBrAp640k
 gIozmSItFBRtZaexjszuYSuyfcx5nmUqrx6T9k+yVDyjHzD42Vpb6KPAzJDNE7ofBXLo6shhqLs
 SC+pHnQc=
X-Gm-Gg: AR+sD13NupdQvYZJG0WpvAMdUpmiVRdkORk4g+3XVhlh5SE2bocs6MMemKBz04oEO1X
 NSXN25QBoD2HR2igVZpkGLmsrmWyOS94KUOp2XSrrb02UQvGROeKXMNbtMFYRzbfoQJ0v8pTFkn
 ahM1VRzAxbejMSeUUrcMxkj3mvpekQYHD+P+wu2LGNTV7jhGNsPQ9pmPVJpbttKkkZXxO3Pa+Oa
 i8uOoF0OwCvVpBOeU7Q2mbJTGlXf+z9uTDZtkN57MAFmiMNO9BudbQXOxyQgcYo+D1WFqerA2lC
 xPSbi3y5zbeVVXybM4Vnn16bMtDba2yt12plbnZC6Ys3yr2vkTH0GJJs0cCTkN2QXNSYK/2r88c
 UVCUoIl9ldlkGHU3YteZdL8tGAkqrkXPKP6sclvzrYo2X8x6pPJe/8nNv/Q4ZI93ELBEwxgrHvx
 tp+eI9sgIsAb2fkOGysbyYI4BoaOTB4bP6BxEtg7C9P7FeAwM80XXT1kDCXbICtxg71wXDa0cyx
 GZEyVXyaMx2Kg/WpTNfAGYZY6vrM2s9IOcdJlaXT0aL6A==
X-Received: by 2002:a05:600c:138a:b0:499:d63b:a6da with SMTP id
 5b1f17b1804b1-499dc6e002emr182966605e9.2.1787845253782; 
 Thu, 27 Aug 2026 08:40:53 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49eb3b21sm63956895e9.8.2026.08.27.08.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:40:53 -0700 (PDT)
Message-ID: <5a690fd2-d02c-42fb-9113-658df02d44f1@linaro.org>
Date: Thu, 27 Aug 2026 17:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 9/9] [RFT] meson: Add Khadas VIM1S support
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-10-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-10-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/17/26 19:15, Sean Anderson wrote:
> This adds basic support for the Khadas VIM1S [1]. I built this config on
> a custom board, and I don't even own a vim1s. Please test!
> 
> [1] https://www.khadas.com/vim1s
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   board/amlogic/q200/MAINTAINERS |  1 +
>   configs/khadas-vim1s_defconfig | 80 ++++++++++++++++++++++++++++++++++
>   2 files changed, 81 insertions(+)
>   create mode 100644 configs/khadas-vim1s_defconfig
> 
> diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
> index aece8d5e05c..5281e06f3cc 100644
> --- a/board/amlogic/q200/MAINTAINERS
> +++ b/board/amlogic/q200/MAINTAINERS
> @@ -5,6 +5,7 @@ L:	u-boot-amlogic@groups.io
>   F:	board/amlogic/q200/
>   F:	include/configs/q200.h
>   F:	configs/beelink-gt1-ultimate_defconfig
> +F:	configs/khadas-vim1s_defconfig
>   F:	configs/khadas-vim2_defconfig
>   F:	configs/libretech-s905d-pc_defconfig
>   F:	configs/libretech-s912-pc_defconfig
> diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
> new file mode 100644
> index 00000000000..143425cd2ca
> --- /dev/null
> +++ b/configs/khadas-vim1s_defconfig
> @@ -0,0 +1,80 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_BOARD="q200"
> +CONFIG_ARCH_MESON=y
> +CONFIG_TEXT_BASE=0x0
> +CONFIG_SYS_MALLOC_LEN=0x8000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_MESON_S4=y
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_IDENT_STRING=" vim1s"
> +# CONFIG_PSCI_RESET is not set
> +CONFIG_ENV_VARS_UBOOT_CONFIG=y
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_FIT_VERBOSE=y
> +# CONFIG_BOOTSTD is not set
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_SUPPORT_RAW_INITRD=y
> +# CONFIG_DISTRO_DEFAULTS is not set
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_BOOTARGS="root=/dev/mmcblk1p2 ro rootwait"
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="load mmc 1:1 $loadaddr linux.itb && bootm"

Why not leave the default boot command ?

> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_MISC_INIT_R=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_MAXARGS=32
> +# CONFIG_CMD_BDI is not set
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PART=y
> +CONFIG_CMD_WDT=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_DHCP=y
> +CONFIG_CMD_MII=y
> +CONFIG_CMD_PING=y
> +CONFIG_CMD_PXE=y
> +# CONFIG_CMD_DATE is not set
> +CONFIG_CMD_RTC=y
> +CONFIG_CMD_SYSBOOT=y
> +CONFIG_CMD_EXT2=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ISO_PARTITION=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
> +CONFIG_SYS_I2C_MESON=y
> +# CONFIG_INPUT is not set
> +CONFIG_MMC_MESON_GX=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_MDIO_MUX=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_ETH_DESIGNWARE_MESON8B=y
> +CONFIG_MDIO_MUX_MESON_G12A=y
> +CONFIG_PHY_MESON_GXL=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_MESON_S4=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_DS1337=y
> +CONFIG_RTC_DS1337_NOOSC=y
> +CONFIG_BAUDRATE=888888
> +CONFIG_MESON_SERIAL=y
> +CONFIG_WDT=y
> +CONFIG_WDT_MESON_GXBB=y
> +# CONFIG_TOOLS_MKEFICAPSULE is not set

