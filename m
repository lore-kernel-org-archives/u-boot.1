Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0709C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 13:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB4988348;
	Mon, 27 May 2024 15:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XNUmxDcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A474688349; Mon, 27 May 2024 15:12:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE14882EF
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 15:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4D4343F363
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716815524;
 bh=bSkHfBTZ6ZNrSowCq3l0I68jb/Wc9rYCdnaXrtGbrRQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XNUmxDcJXoYtLrVeizqvanDIGGC3Rp7A1LsEh97m8PPEkDGC4YfSVnjD4GINU/IGj
 OQJl39oHEmUIiaLCkKFUQ2wTCbq0tUdFxTcEM+qDKmzS5nfgdAsJqzOLhQBHOsQzdY
 Es4rK0nQU+o8HqmvE8GuQzCTlOZOwaMxmgPARCipWvvgA9d444JX98fN1I0qxg1bEi
 3LR6podKtVP6t6lsNze1gsbQgdB0DgWZOuSGPasyNnkwvon6aZMy+IDNK6YD8L3XI7
 kSMl99PCKWQCUhC+Uvb6BebBG+QnzPtRMMbxqquhBLIA8sQabau5ucNkx+NytVby5e
 e7RJmDjbiQSyA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-357766bb14fso1462207f8f.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 06:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716815523; x=1717420323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSkHfBTZ6ZNrSowCq3l0I68jb/Wc9rYCdnaXrtGbrRQ=;
 b=Ah/ytLp4Er2utJeh0H3CwHvwDOiVlQlcPDY4xPTzigTPcE8WVa1XSoQC4t2pdVMjgD
 ylvn1TQ53Bs9jPL8Lx13wR1nLoqndvCBgd9nBt/Xdr0b5cXzTB1SsatDPcsgwJEEE6RF
 eVIlhQ0/D14nYthpBlbTZYv5dIutjHxEUaXOEdBw94Jn4h7YQB0Y2Q57I+LtcQu/zYvq
 LiqII03sHFk3AhhjMsMr9a7BWa1yo+WAMAjAJp1rU7VwPsGekfBwXzJomCPIw9yOuEO2
 4b8nIazdDIC9xTSPw+9U48pNGdrCyEnPVCX99gdjnvFHI9HVeuHID+h70NlpEqjesmiF
 MW0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfqqI347lqWVvEC1vgtgiiqMNDSgcIGjc+1jgO8CrSHD8QuffchL0zG2gUI/dntQ/i6E+s4a1dcvpoHVJB2YM1oVuZew==
X-Gm-Message-State: AOJu0YyMoPw77mid1id/ztHdN0lObdYgyLjxlolg9PZ5Sy1uUlPCb2Ki
 zRftv0Wkl0KxwchlD3IzUjVWW7/FdiC0CCRXoFuBhXGpPV2rZfpZhCWKNeoY8KrBNjFsBtPBwjp
 0uBxO0vkxs6H7qzee6vGJZvqrupbEgTZCBkb4HyxdOGy9lR0t5ZHgbnWQ3kNOQDDQvYA=
X-Received: by 2002:a05:6000:1188:b0:356:50e7:e942 with SMTP id
 ffacd0b85a97d-35650e7eda5mr5032127f8f.61.1716815523203; 
 Mon, 27 May 2024 06:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8t1UuQp2AsHJnYyzeZoZEKmNdHRrH4h5uLQraM3mvwH4/9GRxlDamCPsjJK+NHR/vf4u8yw==
X-Received: by 2002:a05:6000:1188:b0:356:50e7:e942 with SMTP id
 ffacd0b85a97d-35650e7eda5mr5032090f8f.61.1716815522615; 
 Mon, 27 May 2024 06:12:02 -0700 (PDT)
Received: from ?IPV6:2a00:20:1:709a:ef3f:9315:b3f8:b2d3?
 ([2a00:20:1:709a:ef3f:9315:b3f8:b2d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7dbcbsm8990827f8f.20.2024.05.27.06.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 06:12:02 -0700 (PDT)
Message-ID: <9364f2f9-33e4-4ed5-a03a-658fe5364b46@canonical.com>
Date: Mon, 27 May 2024 15:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: jh7110: Update qspi node with upstream
To: matthias.bgg@kernel.org
Cc: jh80.chung@samsung.com, xingyu.wu@starfivetech.com, u-boot@lists.denx.de, 
 mason.huo@starfivetech.com, duwe@suse.de, hal.feng@starfivetech.com,
 yanhong.wang@starfivetech.com, Matthias Brugger <mbrugger@suse.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Nam Cao <namcao@linutronix.de>,
 minda.chen@starfivetech.com, trini@konsulko.com, ycliang@andestech.com,
 rick@andestech.com
References: <20240527104730.20244-1-matthias.bgg@kernel.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240527104730.20244-1-matthias.bgg@kernel.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 27.05.24 12:47, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Upstream node uses a specific SoC compatible to make the kernel driver
> work. Copy over the upstream node to fullfill that need.

Thanks for looking into the compatibility of the U-Boot device-tree with 
Linux.

Could you, please, replace "Upstream" by "Linux" and refer to the 
relevant file:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/starfive/jh7110-common.dtsi?h=v6.10-rc1

%s/fullfill/fulfill/

Please, fully describe the change, e.g.

* Define MTD partitions for StarFive VisionFive 2
* Adjust QSPI compatible string to use StarFive specific driver
* Adjust QSPI clock and reset definitions

> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
> 
>   .../jh7110-starfive-visionfive-2-u-boot.dtsi  |  2 +-
>   .../dts/jh7110-starfive-visionfive-2.dtsi     | 29 ++++++++++++++++---
>   arch/riscv/dts/jh7110.dtsi                    | 19 +++++++-----
>   3 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> index 3012466b305..a69d8fcb391 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> @@ -40,7 +40,7 @@
>   &qspi {
>   	bootph-pre-ram;
>   
> -	nor-flash@0 {
> +	nor_flash@0 {
>   		bootph-pre-ram;
>   	};
>   };
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> index e11babc1cde..375449b73a8 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -305,17 +305,38 @@
>   };
>   
>   &qspi {
> -	spi-max-frequency = <250000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>   	status = "okay";
>   
> -	nor-flash@0 {
> +	nor_flash: nor_flash@0 {
>   		compatible = "jedec,spi-nor";
> -		reg=<0>;
> -		spi-max-frequency = <100000000>;
> +		reg = <0>;
> +		cdns,read-delay = <5>;
> +		spi-max-frequency = <12000000>;
>   		cdns,tshsl-ns = <1>;
>   		cdns,tsd2d-ns = <1>;
>   		cdns,tchsh-ns = <1>;
>   		cdns,tslch-ns = <1>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			spl@0 {
> +				reg = <0x0 0x80000>;
> +			};

Why should we have a gap here?

%s/0x80000/0xf0000/

> +			uboot-env@f0000 {
> +				reg = <0xf0000 0x10000>;
> +			};
> +			uboot@100000 {
> +				reg = <0x100000 0x400000>;
> +			};

And another gap here?

> +			reserved-data@600000 {
> +				reg = <0x600000 0xa00000>;
> +			};

When replacing u-boot.itb by EDK II it would be preferable to have a 
single partition reaching to the end of the SPI-flash.

So I would suggest

uboot@100000 {
	ret = <0x100000 0xf00000>;
}

Best regards

Heinrich

> +		};
>   	};
>   };
>   
> diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> index 2cdc683d49b..2b331e58497 100644
> --- a/arch/riscv/dts/jh7110.dtsi
> +++ b/arch/riscv/dts/jh7110.dtsi
> @@ -480,19 +480,22 @@
>   		};
>   
>   		qspi: spi@13010000 {
> -			compatible = "cdns,qspi-nor";
> -			reg = <0x0 0x13010000 0x0 0x10000
> -				0x0 0x21000000 0x0 0x400000>;
> -			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>;
> -			clock-names = "clk_ref";
> +			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
> +			reg = <0x0 0x13010000 0x0 0x10000>,
> +			      <0x0 0x21000000 0x0 0x400000>;
> +			interrupts = <25>;
> +			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
> +			clock-names = "ref", "ahb", "apb";
>   			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
>   				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
>   				 <&syscrg JH7110_SYSRST_QSPI_REF>;
> -			reset-names = "rst_apb", "rst_ahb", "rst_ref";
> +			reset-names = "qspi", "qspi-ocp", "rstc_ref";
>   			cdns,fifo-depth = <256>;
>   			cdns,fifo-width = <4>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> +			cdns,trigger-address = <0x0>;
> +			status = "disabled";
>   		};
>   
>   		syscrg: clock-controller@13020000 {

