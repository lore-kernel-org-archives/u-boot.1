Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3619ED64086
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A86BC83AA4;
	Wed, 17 Dec 2025 08:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yo4vruy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D6783AA4; Wed, 17 Dec 2025 08:59:21 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CF083AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b7672a12eb8so87420366b.3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 23:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765958359; x=1766563159; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DXRpD1zIhbgrzqi2/5c50uaguUqqf/DgCt4IBHTuBg=;
 b=Yo4vruy7HBSbXBfNLMQOw4B9qkB2ESQzZGY0N1I1YMzFt3EP93kznX5pmkgNFA6RjE
 jl/spY288PmmpODKfyLrO0HEybZ4UR1UFj07CC3q3yEZ8Sz+wZ9ad1R4NF2m2WyOde4t
 ORIWrST5t5upI37wb5YyoqBSupthXkYN+qBkHAgNEH1jvvD5GQJCz4cXc41nwsviLLki
 nB2TpppJDpnBjPF4BCQwWgUOOZ4UYG2pXEmNsJnJMsy2ewlxVmUFY1Aac+O3RnJt9oYi
 3uBzGcIRnNvOjaTp3eBlHVy1UIvjg8XEpC6u2qCJWjgqeiIps2OlrLSTh0xZFkeRrnab
 Fgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765958359; x=1766563159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DXRpD1zIhbgrzqi2/5c50uaguUqqf/DgCt4IBHTuBg=;
 b=C6xsLx5vo7x16zskJHvEGmFejQ1iLA7VNcMT7Y+JL1a+HzmcVHUZ5W36f3UdEOtyEd
 OZd+HbeAcbf+I89AaNV8UmYKE62UXwEbUAuar5jZDiPucWEC6r3eQ/wAmgDitebse/ZL
 /FCrHIVwwgnGRefrWVBVaMpruG/RSXU/xeiUocpWRrPRn7xtePqRTsY8LyzsNDCpCDhH
 t0SPqdDYhUVWOgWLmU2go9A98Uj5R42goJ17x7aUnlbXiJLcPmjo+cz2l8KQBzSJrSCy
 LOn8C2SK6VNCml+arPswDYcnwfbGgU1iujRvg7Ynh2KFZSQMzdPAHFyxFZ0B4QOYA5rF
 4coA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrxVD77wFTKfUnJ7P0lIxZU5wlsgO22Q/dX9D33bQT/cTtms7L5xBnQpvBMj+44ioQWFVphvk=@lists.denx.de
X-Gm-Message-State: AOJu0YwrzJyLKaqAJJwOnhX1sV9u7bDFy+SNr2pdn1E/wAJ3i45JPEvY
 ROXDY+OuNBHemZjKxN5gPCHYg4kcO/uHFg57zHoifRWBkwDe4i2Z8X+R
X-Gm-Gg: AY/fxX5x1l6egCW3O/enC/zFgZzDLC6krAvqdcjEgUVL+Y8whoeUT5wjLMyKDD+an+4
 mSYkzBibKwHSA+VvIKJv+UnG34xjuXkR+mkjUZEMq3YQZOWPHVYbZ8kn3Ey+RYjwL6ho3EnvZUt
 VVtU2dkrsK/TVDIY0+qW4L3UD52vnt7wGzPUNn/W0a4nMXIYtgiu0ItfKxOL5CzgiZ2/+ROZPLs
 dy6EMO3sInqX6nEcx8ELYfpU4NdUliuVhx6subXm1CweG/u/Uf3zbY7/5qMeVp7uqG4fBvhhNxK
 frLkvQDJlfzHTy46ZAtx6hZO2w5rVNuB0VRu5+Of8zFTfPJR6MIHpca1bMu/l8SZCoG7E8FzFvg
 Zb0RabL5FYUWhhc1IJ1UDX94Te4yfUk8X6S3BMKw2vzispBy2vr/eR8dK2Rdav4DN8BI6rytHGH
 HdN+HziqOj56ecX+uXSF2FT7Ur2FR5lltkmcL3WrFvVgY21SBofQ==
X-Google-Smtp-Source: AGHT+IFfkxEinegj+7Aa1yvE8PwqiUOgCWO5SY9s7EdbYgaLYypEmV69pIi4ENo1NVmRj33TAulvsA==
X-Received: by 2002:a17:907:d27:b0:b72:5d4a:45d4 with SMTP id
 a640c23a62f3a-b7d237b540bmr1078469866b.3.1765958358554; 
 Tue, 16 Dec 2025 23:59:18 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7cfa29eb69sm1943106466b.6.2025.12.16.23.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 23:59:18 -0800 (PST)
Message-ID: <30bf5f74-b3ee-4f83-974c-44b0155e0839@gmail.com>
Date: Wed, 17 Dec 2025 08:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: make rksd the default format for SPI
 images
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@kernel.org>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
 <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
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



On 12/16/25 12:26, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I believe (hope) that the new SoCs should now have this fixed and not
> require the "hack" implemented in rkspi format which almost doubles the
> size of TPL+SPL (idbloader.img).
> 
> It's known to be fixed on RK3566/RK3568, RK3576 and RK3588(S) (according
> to the DTS setting the mkimage format for the SPI's idbloader.img to
> rksd explicitly).
> 
> Since I do not have any board with a bootable SPI flash except on RK3399
> where this work-around is required, I simply invert the logic by having
> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
> that did. It doesn't mean that the SoC actually requires rkspi format,
> just that it's been the case until now (maybe because nobody tested).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/px30-u-boot.dtsi     | 12 ++++++++++++
>  arch/arm/dts/rk3036-u-boot.dtsi   | 13 +++++++++++++
>  arch/arm/dts/rk3066a-u-boot.dtsi  | 12 ++++++++++++
>  arch/arm/dts/rk3128-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3188-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk322x-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3288-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3308-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3326-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3328-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3368-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3399-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk3528-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rk356x-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3576-u-boot.dtsi   |  1 -
>  arch/arm/dts/rk3588s-u-boot.dtsi  |  1 -
>  arch/arm/dts/rockchip-u-boot.dtsi |  1 -
>  arch/arm/dts/rv1108-u-boot.dtsi   | 12 ++++++++++++
>  arch/arm/dts/rv1126-u-boot.dtsi   | 12 ++++++++++++
>  19 files changed, 157 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index 2f726b0aaba..7385de7d6ae 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -27,6 +27,18 @@
>  	};
>  };
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif
> +
>  &otp {
>  	bootph-some-ram;
>  };
> diff --git a/arch/arm/dts/rk3036-u-boot.dtsi b/arch/arm/dts/rk3036-u-boot.dtsi
> index 41ac054b81e..988287e2f12 100644
> --- a/arch/arm/dts/rk3036-u-boot.dtsi
> +++ b/arch/arm/dts/rk3036-u-boot.dtsi
> @@ -4,3 +4,16 @@
>   */
>  
>  #include "rockchip-u-boot.dtsi"
> +
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif
> +
> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
> index d99db7853b5..4272bf4a8e2 100644
> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
> @@ -3,6 +3,18 @@
>  #include "rockchip-u-boot.dtsi"
>  #include "rk3xxx-u-boot.dtsi"
>  

> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};

I think that we shouldn't add extra functionality to old SOCs that nobody is able to verify on real boards anymore.
Just skip this for rk30xx/rk31xx except maybe for rk3288 if someone still has hardware. 

> +#endif
> +#endif
> +
>  &gpio6 {
>  	status = "disabled";
>  };
> diff --git a/arch/arm/dts/rk3128-u-boot.dtsi b/arch/arm/dts/rk3128-u-boot.dtsi
> index 6d1965e6b52..500791a22e7 100644
> --- a/arch/arm/dts/rk3128-u-boot.dtsi
> +++ b/arch/arm/dts/rk3128-u-boot.dtsi
> @@ -10,6 +10,18 @@
>  	};
>  };
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif
> +
>  &cru {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/rk3188-u-boot.dtsi b/arch/arm/dts/rk3188-u-boot.dtsi
> index 8f2849dda24..a164c94e96e 100644
> --- a/arch/arm/dts/rk3188-u-boot.dtsi
> +++ b/arch/arm/dts/rk3188-u-boot.dtsi
> @@ -6,6 +6,18 @@
>  #include "rockchip-u-boot.dtsi"
>  #include "rk3xxx-u-boot.dtsi"
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif
> +
>  &gpio0 {
>  	compatible = "rockchip,gpio-bank";
>  };
> diff --git a/arch/arm/dts/rk322x-u-boot.dtsi b/arch/arm/dts/rk322x-u-boot.dtsi
> index aea917544b1..f783a735ca1 100644
> --- a/arch/arm/dts/rk322x-u-boot.dtsi
> +++ b/arch/arm/dts/rk322x-u-boot.dtsi
> @@ -39,6 +39,18 @@
>  	};
>  };
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif
> +
>  &cru {
>  	bootph-all;
>  };
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index bb0078588fe..97d300a880a 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -46,6 +46,18 @@
>  	};
>  };
>  
> +#ifdef CONFIG_SPL
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
> +		};
> +	};
> +};
> +#endif
> +#endif
> +
>  &bus_intmem {
>  	ddr_sram: ddr-sram@1000 {
>  		compatible = "rockchip,rk3288-ddr-sram";
[snip]
