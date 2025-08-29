Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D12CA0FFD
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2A383487;
	Fri, 29 Aug 2025 09:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iJjFoIXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1B9B834AD; Fri, 29 Aug 2025 09:19:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4286483447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A83E3F7CB
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756451945;
 bh=a+wZDqR35fUmeZcvYELXJyptK9UhQ9gixZYAN7iM2Dg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=iJjFoIXo7vtoh1y6mZ6bMIs5k1khW1JbEm0Ezc5YpfJHhkvR1J5/TJz7HRioymzkT
 D6mlPtd0R70V6647SwLJAaok3mVkIhlco32F+1VU8qF8KN6jZomPUg5OB4HHf7ZtGz
 e7CTyuDhwu6HOhT4cjUnyke8K2GH/WWZgmHwSe+2VocdlTtIlcE/yMzD6W/IP1Vtjp
 wX15dR4JIVNdgel5UwjQNwUOb8zhM+oOJo/9k34dulT33igwxSydSIAo1YWc5JrR8L
 7w0jBbvmGXCDmxtQ9Duar91PWO9+jiGVHn/V+kks3Zmjh+waJIjffkW9JzJYyiqf5r
 1OxqiI+m5N5mQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0b14daso10475975e9.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 00:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756451945; x=1757056745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+wZDqR35fUmeZcvYELXJyptK9UhQ9gixZYAN7iM2Dg=;
 b=m1oK1DX6bD8UaUpIuNyaWc1+upp3df2hQBa7/2tOABh7g9qDjaNJNYq0NzOBAFhSOL
 mtxOI5Y0ex2wjwCJ7/gZWC/8ve3wvA/dXUA+Yx/TD6XDROSxVRV+ocw1NptyLXjcsOFH
 g1uf5KUnv3VhZ6rOaGXWRRBKbgkv7yX8wx+sZjlSi8UfvZhZ5SPSBbAHvMsZnUUveSvD
 bfN7w7iOYLMgtx9KTco4EqGBon98fWAheijM4+FPcsdPu4VpIF98cjq1sVYck+mX7uTA
 I502k5pQ9lu+H96xKoLyZ4+fI5vnimJaXkgahMFfi0pX+cxHYjVFapidiq6VzAXLWq6I
 cgyw==
X-Gm-Message-State: AOJu0YzOm9MKvMmJIyuESTTTLZJYpFWHVXIA6GXp83fRk09wVsyg3dev
 z+lXZ3iFx6cNOE8bgpebOScQEUtYWqYLocY3XRoYCM6ZuFmBjNBVADL78kClB1P/+r0Jo2mEA6q
 YHJAY5Wydme/QF7oYcXDRPzuufRXHFtbL0lBjuPYnJVS8RJNeKAjzSzhX/PFhb3AVQNhOuyE=
X-Gm-Gg: ASbGncu+/P47KYbLKxA65eoftC9Ci8hEx+2hhvuaqMGM51jntful9cKFlvCcJhRM30D
 ko63aYp+UuG9d3AobIC+Li/AMsc8/icUCHKpxE9pa9J7G87TkGRJkMX1kuxOh2BvZ4cwCsu4B4z
 K5rfxgmolM+RrYfSqh0cWtU6qMKILsnh6oFfZMpRSv4Pzn/lCg/Y3adPzocpPqpEvqfE5iJNVF5
 02h81x4+ANaLqg9D2E4JzuTtMVOELcIZXhlPPDzJlMs9EuETFHRW1eqhnPFxrvleVipyfaQ4swa
 Tdklm8TaR8lt9E1wnLXhPUf/7Jm0ogWrVEfdWJJq17Xi/oDXSgGSNSgh7W1+zGrXEongSv8Q5td
 cVkNliGQFG0ETPPmR4QuP/6US/WW/
X-Received: by 2002:a05:600c:630c:b0:456:f00:4b5d with SMTP id
 5b1f17b1804b1-45b517d4550mr175824665e9.22.1756451944745; 
 Fri, 29 Aug 2025 00:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfd1D2Z/VGM0jFFrRlJhZ3C65zR/+alWYZJkmTXa8XAMgptxmMWHkdWaxmKp99fUFpyt7few==
X-Received: by 2002:a05:600c:630c:b0:456:f00:4b5d with SMTP id
 5b1f17b1804b1-45b517d4550mr175824355e9.22.1756451944183; 
 Fri, 29 Aug 2025 00:19:04 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d?
 ([2a02:3035:6e0:88f7:ae8f:dfdc:303a:75d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66f2041fsm68957935e9.5.2025.08.29.00.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 00:19:03 -0700 (PDT)
Message-ID: <f8ed3792-70ca-498f-9ce7-65040860db07@canonical.com>
Date: Fri, 29 Aug 2025 09:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
To: Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 E Shattow <e@freeshell.de>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-2-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250829060931.79940-2-hal.feng@starfivetech.com>
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

On 29.08.25 08:09, Hal Feng wrote:
> Some node in this file are not used by the upcoming VisionFive 2 Lite
> board. Move them to the board dts to prepare for adding the new
> VisionFive 2 Lite device tree.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

LGTM

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   .../src/riscv/starfive/jh7110-common.dtsi     | 22 ---------
>   .../jh7110-deepcomputing-fml13v01.dts         | 49 +++++++++++++++++++
>   .../src/riscv/starfive/jh7110-milkv-mars.dts  | 49 +++++++++++++++++++
>   .../riscv/starfive/jh7110-pine64-star64.dts   | 49 +++++++++++++++++++
>   .../jh7110-starfive-visionfive-2.dtsi         | 46 +++++++++++++++++
>   dts/upstream/src/riscv/starfive/jh7110.dtsi   | 16 ------
>   6 files changed, 193 insertions(+), 38 deletions(-)
> 
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
> index 4baeb981d4d..9d3d03ad2ed 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
> +++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
> @@ -272,15 +272,9 @@
>   	assigned-clock-rates = <50000000>;
>   	bus-width = <8>;
>   	bootph-pre-ram;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	cap-mmc-hw-reset;
>   	post-power-on-delay-ms = <200>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mmc0_pins>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&emmc_vdd>;
>   	status = "okay";
>   };
>   
> @@ -290,12 +284,7 @@
>   	assigned-clock-rates = <50000000>;
>   	bus-width = <4>;
>   	bootph-pre-ram;
> -	no-sdio;
> -	no-mmc;
> -	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	disable-wp;
>   	cap-sd-highspeed;
> -	post-power-on-delay-ms = <200>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mmc1_pins>;
>   	status = "okay";
> @@ -439,17 +428,6 @@
>   	};
>   
>   	mmc0_pins: mmc0-0 {
> -		 rst-pins {
> -			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
>   		mmc-pins {
>   			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
>   				 <PINMUX(PAD_SD0_CMD, 0)>,
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
> index f2857d021d6..5a2a41a7e8c 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
> +++ b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -11,6 +11,55 @@
>   	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
>   };
>   
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>   &pcie1 {
>   	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
>   	phys = <&pciephy1>;
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
> index 3bd62ab7852..0c90facc4ee 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
> +++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
> @@ -11,6 +11,25 @@
>   	compatible = "milkv,mars", "starfive,jh7110";
>   };
>   
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
>   &gmac0 {
>   	starfive,tx-use-rgmii-clk;
>   	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> @@ -22,6 +41,36 @@
>   	status = "okay";
>   };
>   
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>   &pcie0 {
>   	status = "okay";
>   };
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
> index 31e825be206..c9677aef9ff 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
> +++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
> @@ -14,6 +14,25 @@
>   	};
>   };
>   
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
>   &gmac0 {
>   	starfive,tx-use-rgmii-clk;
>   	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> @@ -44,6 +63,36 @@
>   	status = "okay";
>   };
>   
> +&mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
> +};
> +
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>   &pcie1 {
>   	status = "okay";
>   };
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
> index 5f14afb2c24..d1e4206f125 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -13,6 +13,25 @@
>   	};
>   };
>   
> +&cpu_opp {
> +	opp-375000000 {
> +		opp-hz = /bits/ 64 <375000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-500000000 {
> +		opp-hz = /bits/ 64 <500000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-750000000 {
> +		opp-hz = /bits/ 64 <750000000>;
> +		opp-microvolt = <800000>;
> +	};
> +	opp-1500000000 {
> +		opp-hz = /bits/ 64 <1500000000>;
> +		opp-microvolt = <1040000>;
> +	};
> +};
> +
>   &gmac0 {
>   	status = "okay";
>   };
> @@ -38,9 +57,36 @@
>   };
>   
>   &mmc0 {
> +	cap-mmc-highspeed;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&emmc_vdd>;
>   	non-removable;
>   };
>   
> +&mmc0_pins {
> +	rst-pins {
> +		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> +				      GPOEN_ENABLE,
> +				      GPI_NONE)>;
> +		bias-pull-up;
> +		drive-strength = <12>;
> +		input-disable;
> +		input-schmitt-disable;
> +		slew-rate = <0>;
> +	};
> +};
> +
> +&mmc1 {
> +	no-sdio;
> +	no-mmc;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	post-power-on-delay-ms = <200>;
> +};
> +
>   &pcie0 {
>   	status = "okay";
>   };
> diff --git a/dts/upstream/src/riscv/starfive/jh7110.dtsi b/dts/upstream/src/riscv/starfive/jh7110.dtsi
> index 0ba74ef0467..d2463399b95 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110.dtsi
> +++ b/dts/upstream/src/riscv/starfive/jh7110.dtsi
> @@ -200,22 +200,6 @@
>   	cpu_opp: opp-table-0 {
>   			compatible = "operating-points-v2";
>   			opp-shared;
> -			opp-375000000 {
> -					opp-hz = /bits/ 64 <375000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-500000000 {
> -					opp-hz = /bits/ 64 <500000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-750000000 {
> -					opp-hz = /bits/ 64 <750000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-1500000000 {
> -					opp-hz = /bits/ 64 <1500000000>;
> -					opp-microvolt = <1040000>;
> -			};
>   	};
>   
>   	thermal-zones {

