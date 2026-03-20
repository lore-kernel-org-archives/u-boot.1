Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A861099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 21:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA55883FDC;
	Fri, 20 Mar 2026 22:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ywil4eEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0DA83FEC; Fri, 20 Mar 2026 22:25:48 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9B78394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 22:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67c274ffe38so543104eaf.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774041945; x=1774646745;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HyQ94Cb3eys8+Z2C/qVokVF++ItjafExC0l8rFU6aJ8=;
 b=ywil4eEWgdP0PEvZNNXQ7LZxP6UlXf8nj2dr0uO2uJr9B8Ri3lTxw9jrmdYZndEk5W
 SdXbF9bZLO5rAcKBKq2OCphOK6OFtkIMEho1qe0/FgfF9B3OKSNwPftWd2d3+2asY83L
 mDDYZcmKQijpVNNAMkmsbQlVelBXMqAlfYSRpc6+3pyLzHcryZB/C24VQ1pf25lnPQ/T
 IUItDuBSg18CmSgJbZVfGYPDeRRX2DGzgNF+vqHXy8zf/qRQmI3WPQrMP07f99iYgAUg
 KTPY/o1xsw5K8Ga//h5XnIYlSbtYEmSrqmkU7kCAMO9dWtpfPeq7T8HZ9vnoaUEKFWHp
 eHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774041945; x=1774646745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HyQ94Cb3eys8+Z2C/qVokVF++ItjafExC0l8rFU6aJ8=;
 b=aitV8B0XCdPmcZZh3uVhPhpz2eYOI1awmkXd5OzjBhTaEZ4Y6jnBm25S1PkBZNbn1E
 9xwVcPjp4NLg3JVACiEEBYAx9jlwyR9NeFCEu+nqt4uYb5v1Nh3Y9n277lB/LNB4250U
 lmfoODHLw4aYGh0VR36dsNkcl0SFko/61yzpJ20/L8WMdRB/qQ5seTmDMxJoeKq5Z/50
 5Tld0F/8Q+f+Ioa0VaUHGQJE+eDn55WEz4AR4UG/WVfgcusqzxFHnwyDrlm9NdmnpfLp
 3bsXP+l9fkl9NF1Pzvolimj1CloJbevc+lsSks3NO5ktP0VAbHGPkjb0FJ6p1+DMOvSo
 01CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMDwmp6+Tf9UnnjCitPjcF9tSDZZystBzgF0Qmup3FvW85NLnuD7pIvaUPivljwJAkgAYLT5c=@lists.denx.de
X-Gm-Message-State: AOJu0YxT2zDp+wHWRiZpRE6Lsr3bLEjLjMGb2yoj39EhC/6swzTDAqS/
 dJa+/h676KBkpg8pE/GVeDuTY9X1KDpgIMzWLoccS+DbbOWxniMNA5GZgEDgLRprQAE=
X-Gm-Gg: ATEYQzwHUQ1NdVinjA2BxgDFWT0Ic4e+92zWm0yrT4N5hT6mR/8A1vLKA3sd2noItQn
 X17uyfjkEOBIky5VLtrmm7VLVKHYTvT4Ifa4InOFYr58TTC4p5rfJsjOgPmh1dX9pmedSdwGbaS
 XSN9hvc+oPlWaYlmIcwEmZUDGNU1gm2BcPk92i6/qR4kUXijb3EBZYWI9G+cndM1ZP1Xt7m9vcm
 s4EHcw5Jz8GI2fUSpeWG+GfmXnFaFkLQIJP50868JdDfwREy3KRrP2k2JAvArZiz/GVnZr3zxav
 huPknPXJKC9SifoFfmdRleYnPqNZgTrdmws6QCjHywPMTP1iFPyVZToekN6zjozylHY74M9zbk7
 NxDOStX3ddDh4pCc/SHK9Hovaz3Gie2zoL6tMYsDOGh4Kn0eiXxY6/SA599B5jTp7M2eWF/LU0u
 BaJ2x/22nSiIIh05pfJTHiSi0JzLvZx/NvklNapurAsBx4O2CNWtM2b3WPRNBqFY/aPGBzs1A=
X-Received: by 2002:a05:6820:1387:b0:67b:bd65:da85 with SMTP id
 006d021491bc7-67c22dc6854mr3188784eaf.13.1774041944947; 
 Fri, 20 Mar 2026 14:25:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6a3c:6fc:3be2:208d?
 ([2600:8803:e7e4:500:6a3c:6fc:3be2:208d])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252dbd05sm1816147eaf.6.2026.03.20.14.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:25:44 -0700 (PDT)
Message-ID: <d19e7e42-4952-45f8-9387-e169c50fc8ce@baylibre.com>
Date: Fri, 20 Mar 2026 16:25:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] configs: mt8395_evk: rename to
 mt8395_genio_1200_evk_defconfig
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260318-rename-genio-defconfigs-v2-0-1f77580d72f3@baylibre.com>
 <20260318-rename-genio-defconfigs-v2-2-1f77580d72f3@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260318-rename-genio-defconfigs-v2-2-1f77580d72f3@baylibre.com>
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

On 3/18/26 11:45 AM, Julien Stephan wrote:
> Rename mt8395_evk to match the name of the device tree which is
> mt8395-genio-1200-evk.dts
> 
> Also update CONFIG_IDENT_STRING to be consistent.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  board/mediatek/MAINTAINERS                                        | 4 ++--
>  configs/{mt8395_evk_defconfig => mt8395_genio_1200_evk_defconfig} | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 446a9e8e53c..5ae23b1628c 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -14,7 +14,7 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  S:	Maintained
>  F:	configs/mt8390_evk_defconfig
>  
> -MT8395 EVK
> +MT8395
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  S:	Maintained
> -F:	configs/mt8395_evk_defconfig
> +F:	configs/mt8395_genio_1200_evk_defconfig
> diff --git a/configs/mt8395_evk_defconfig b/configs/mt8395_genio_1200_evk_defconfig
> similarity index 92%
> rename from configs/mt8395_evk_defconfig
> rename to configs/mt8395_genio_1200_evk_defconfig
> index 2edf3cb3e35..2d73af353f7 100644
> --- a/configs/mt8395_evk_defconfig
> +++ b/configs/mt8395_genio_1200_evk_defconfig
> @@ -7,7 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
>  CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
>  CONFIG_TARGET_MT8195=y
>  CONFIG_SYS_LOAD_ADDR=0x60000000
> -CONFIG_IDENT_STRING=" mt8395-evk"
> +CONFIG_IDENT_STRING="mt8395-genio-1200-evk"

This is just printed as part of the version and the CPU and Model
which contains the same info is printed right below it, so I would
suggest that we just drop CONFIG_IDENT_STRING. I don't think it adds
anything useful.

Example:

U-Boot 2026.04-rc4 (Mar 20 2026 - 15:23:05 -0500)${IDENT_STRING}

CPU:   MediaTek MT8189
Model: MediaTek Genio-720 EVK
...

If we do keep the config, it should have a leading space, otherwise
there is no space after ).

>  # CONFIG_BOARD_INIT is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPT=y
> 

