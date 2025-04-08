Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A4C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6438383211;
	Tue,  8 Apr 2025 09:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U7CfmwPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC9A8331F; Tue,  8 Apr 2025 09:16:24 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3193E831FE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso2939363f8f.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744096581; x=1744701381; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AMjfwZHh9DKb/KX7hGYICU25yWpext8QPD0JbEToB+Q=;
 b=U7CfmwPrmEB7mTKO7d2hqLHH3fj9EQkzWrBD7yko00412LE1ggqBy0n8aMqFO+esZS
 Vz/g+/lb+usnrozcGHRjrbvQ7K2smdteI99TkLxsq23ZB3pbsaFb3n+49qO+U2IHLzJH
 7TK8/Y1/9suXMkPwl4RbmlprDIYqnERjgnrINlOcTDjYZN9RCpu5VzverfUH+84uF8CT
 PKe1c2/PVE/dZ9KF9UVXxxvWLeha1X8TanNITCLHQWShPQwFUW0Y8YEpyVhR9OcBzcZR
 jBycxiO34R/+UqVy/oXZtamj/78k7TvGT39CD/9u44SdL1uFij869wQXdohNtyYEAWTx
 iz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744096581; x=1744701381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AMjfwZHh9DKb/KX7hGYICU25yWpext8QPD0JbEToB+Q=;
 b=FqV32ImEp2nPwByLzY0bwm3V234f4Q6ILxgYWDECtqqU24mLg9xxmPmJAeQOiGxuBk
 PX18Luq1G6XeWQere0P4mkMircjYgpHCCzQhy3KNu1ObMEwcwk3w3ASGtCZKkF8HOLGy
 ipliCpY8gejFihBHKjPmQ7cErs+xdB2l+SpHfTl9+5lI2EMOayXgUcPcuCF3Qmr27I86
 gWNkILw2An62J8rHudHltx9I6e5o8RRTveI1qcR9heQq5geM9TAzMxh40AFdEgo79nlZ
 RMlfOpvGqygyoFoIe9C/Ke0XQuELr4LInZCSS3befrpGBCdfoQkhjLxzoiRL5ck6s9zB
 mm+w==
X-Gm-Message-State: AOJu0YxBTMlPH1mZYaIG0d+LUlLqHP7HzmCi6Jn0f1aFJJmQNXVPqlzw
 ultqrRTM9/q6rV8mGfAE9kv7KuJVIIsUSaBcQV6mVra9zUdbiWw/7p6oKkgOaek=
X-Gm-Gg: ASbGncsuSnZWQZLU1lFvi3OHk+by7lffk5KBvqbwFOwHcOd5UjIADj+Q1Y24Oqaj7IK
 iUsLJg45RUc3SQF/4rPGipoUmY+K4xlF6s4+SU+3aB2gjUKVZBIcbviaoCKJTrCbHydR+5Z6gw9
 kqET6Iup2+9Rii+n8O53AoAjZRevqPlCEU7T95DQGm7WQKyKhU4xA3MV3TTL1LnFwgu2XaVbN3Z
 zwi6cJAGCiRrDEr4PDBB7N/kKLc1XCXcxzOOTdMttazGohME8CmdVuXYgBgDdaupDPaeQ4d/M0t
 J1dkj91r/Q5MqDfZ2P7z9TTTBYdl97RhFnnQI8qdZp48edFCP02Q
X-Google-Smtp-Source: AGHT+IFbOV6IQX15OuRWoW8WPjiHhwZZgUM4p/wI7+QgCeAV6/uzaEqQvqwO/i/iA4HBCXV32zwjWg==
X-Received: by 2002:a05:6000:220e:b0:391:3207:2e68 with SMTP id
 ffacd0b85a97d-39d820aca90mr1563920f8f.9.1744096581419; 
 Tue, 08 Apr 2025 00:16:21 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm13879455f8f.100.2025.04.08.00.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 00:16:21 -0700 (PDT)
Message-ID: <fe0ac3f4-6c79-4ce5-b63a-6a2b1b8c5386@linaro.org>
Date: Tue, 8 Apr 2025 10:16:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: sama5d27_wlsom1_ek: Select
 CONFIG_NET_RANDOM_ETHADDR
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250408001639.469298-1-festevam@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250408001639.469298-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 4/8/25 03:16, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, Ethernet fails to probe due to the lack of a valid MAC address:
> 
> ```
> Net:   
> Error: ethernet@f8008000 No valid MAC address found.
> No ethernet found.
> ```
> Select CONFIG_NET_RANDOM_ETHADDR so that a random MAC address is generated
> and Ethernet can work by default.

At91 boards have a eeprom memory that has an unique MAC address. Some
boards have a QSPI memory that keeps it.
The fact that no MAC is available makes me think some of these drivers
are not working. I suggest you debug that, and do not enable random MAC
address.

> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  configs/sama5d27_wlsom1_ek_mmc_defconfig       | 1 +
>  configs/sama5d27_wlsom1_ek_qspiflash_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
> index 378a8af20810..171081310904 100644
> --- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
> @@ -72,6 +72,7 @@ CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
>  CONFIG_ENV_IS_IN_FAT=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_CLK=y
> diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> index 6b75825a13e6..f0831ffe4c52 100644
> --- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> +++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
> @@ -76,6 +76,7 @@ CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_CLK=y

