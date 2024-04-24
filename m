Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA740C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 14:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2942888B9A;
	Wed, 24 Apr 2024 16:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zc4qW4SE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A878882B; Wed, 24 Apr 2024 16:14:17 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C7688E57
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 16:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a587831809eso242457766b.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968055; x=1714572855; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=848ds+hOEPPuKQ1bCRe2gPVsR4gbPu7BJofoO5mfZpo=;
 b=Zc4qW4SEal7xP9YK5wXd7O1NMtAhyP4Q1lbjyph9AKbdvU7sePahb3ml8Pg9qL+Q+n
 aTw1ffZzslgutPLo7olzwYr/4jBqmi16rOZjxASL5fgZl3KV7uVXRBk0toufVLPh9Svg
 7Ux25/sa/yD1TPhLwpPHXy9pqg70xGEBm2xhyCeKY5BJFLgPwQUe+hAxLslGN1C0wDtG
 1Ou+1foBVF/8NUWcN6b01UQShTB18LegJkVTSgklLaPjb2ugBxZPsZt193fZl5QCIzXg
 W1OdkTPEyAu61/7tlpBqqnvvysB4qrn7Te016m7Cs5qfEpSr8OzGqRm4PbpAmymsEkOa
 y2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968055; x=1714572855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=848ds+hOEPPuKQ1bCRe2gPVsR4gbPu7BJofoO5mfZpo=;
 b=Rgyyjt0AHsijYs7dtlLDrDRxOZcJbC81CZumkh+LhF9/4u31lEyXpLT1OtLjJgtszX
 0Gifie6P9Mb2sjsldHWz7WwNDQLIe6jbTTmDafOKeopuIcACy8jWL5kCKKB3sMoah03g
 dMEF06SndnHZiVvGGPybIcuhcsV2l88ZOHr2BSysJFTKGwJarPSxeKFDGI+WRFcvQNLn
 6CYrm93hpPWusc5UoDl9QThm5HhiZSvKoaVljX26siaHodm0FNpa9EPAj1liTGTwL5cQ
 s8QxJNl2fa50g7z516STUH3oITwj49VBMOcUSpT1QLqo19A24wlllt/nW7ldi1AUYPfw
 EP2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUul9MyhYECs62cHlzzOJICXdyZxXOrwHGZ/jHghF/H8eQp0NiKVNzTXsqWZfl4UkYEMXCgn7Jlj2YgNcQ0kzSaADGySw==
X-Gm-Message-State: AOJu0YzeAp+JFm9REuJeHEkD0B/rprIxzYnS1xNSjEUlB8gQknhacLqs
 s5lgJOjnd8t+uIra47uG21IYBHPtiZzPN8s8GGgciRTFDhZr6Y9rx8WjFrssGEA=
X-Google-Smtp-Source: AGHT+IF3C0M9OgP+5l5hhwsEdjSjamE9ipak4wCMNGRktLAdYatB1/6t8JMF8ogM+3R5biICwvCghQ==
X-Received: by 2002:a17:907:868d:b0:a52:66f3:a9ee with SMTP id
 qa13-20020a170907868d00b00a5266f3a9eemr2028255ejc.41.1713968054969; 
 Wed, 24 Apr 2024 07:14:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4c3a? ([2a02:8109:aa0d:be00::4c3a])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a170906260300b00a559965b896sm5764281ejc.202.2024.04.24.07.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 07:14:14 -0700 (PDT)
Message-ID: <4be4e06d-2c39-4a32-84d3-e4bb080892fe@linaro.org>
Date: Wed, 24 Apr 2024 16:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: dts: drop downstream IPQ4019 DTSI
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: j.beck@linefinity.com
References: <20240424111434.373920-1-robert.marko@sartura.hr>
 <20240424111434.373920-3-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240424111434.373920-3-robert.marko@sartura.hr>
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



On 24/04/2024 13:13, Robert Marko wrote:
> We want to use OF_UPSTREAM on IPQ40XX as its well supported upstream, so
> lets drop our downstream DTSI.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/qcom-ipq4019.dtsi | 202 ---------------------------------
>   1 file changed, 202 deletions(-)
>   delete mode 100644 arch/arm/dts/qcom-ipq4019.dtsi
> 
> diff --git a/arch/arm/dts/qcom-ipq4019.dtsi b/arch/arm/dts/qcom-ipq4019.dtsi
> deleted file mode 100644
> index f9489e42ea..0000000000
> --- a/arch/arm/dts/qcom-ipq4019.dtsi
> +++ /dev/null
> @@ -1,202 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2019 Sartura Ltd.
> - *
> - * Author: Robert Marko <robert.marko@sartura.hr>
> - */
> -
> - /dts-v1/;
> -
> -#include "skeleton.dtsi"
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/clock/qcom,ipq4019-gcc.h>
> -#include <dt-bindings/reset/qcom,ipq4019-reset.h>
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	model = "Qualcomm Technologies, Inc. IPQ4019";
> -	compatible = "qcom,ipq4019";
> -
> -	aliases {
> -		serial0 = &blsp1_uart1;
> -		spi0 = &blsp1_spi1;
> -	};
> -
> -	reserved-memory {
> -		#address-cells = <0x1>;
> -		#size-cells = <0x1>;
> -		ranges;
> -
> -		smem_mem: smem_region: smem@87e00000 {
> -			reg = <0x87e00000 0x080000>;
> -			no-map;
> -		};
> -
> -		tz@87e80000 {
> -			reg = <0x87e80000 0x180000>;
> -			no-map;
> -		};
> -	};
> -
> -	smem {
> -		compatible = "qcom,smem";
> -		memory-region = <&smem_mem>;
> -	};
> -
> -	soc: soc {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -		compatible = "simple-bus";
> -
> -		gcc: clock-controller@1800000 {
> -			compatible = "qcom,gcc-ipq4019";
> -			reg = <0x1800000 0x60000>;
> -			#clock-cells = <1>;
> -			#reset-cells = <1>;
> -			bootph-all;
> -		};
> -
> -		rng: rng@22000 {
> -			compatible = "qcom,prng";
> -			reg = <0x22000 0x140>;
> -			clocks = <&gcc GCC_PRNG_AHB_CLK>;
> -			status = "disabled";
> -		};
> -
> -		soc_gpios: pinctrl@1000000 {
> -			compatible = "qcom,ipq4019-pinctrl";
> -			reg = <0x1000000 0x300000>;
> -			gpio-controller;
> -			gpio-count = <100>;
> -			gpio-bank-name="soc";
> -			#gpio-cells = <2>;
> -			bootph-all;
> -		};
> -
> -		blsp1_uart1: serial@78af000 {
> -			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> -			reg = <0x78af000 0x200>;
> -			clock = <&gcc GCC_BLSP1_UART1_APPS_CLK>;
> -			bit-rate = <0xFF>;
> -			status = "disabled";
> -			bootph-all;
> -		};
> -
> -		blsp1_spi1: spi@78b5000 {
> -			compatible = "qcom,spi-qup-v2.2.1";
> -			reg = <0x78b5000 0x600>;
> -			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -			bootph-all;
> -		};
> -
> -		mdio: mdio@90000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "qcom,ipq4019-mdio";
> -			reg = <0x90000 0x64>;
> -			status = "disabled";
> -
> -			ethphy0: ethernet-phy@0 {
> -				reg = <0>;
> -			};
> -
> -			ethphy1: ethernet-phy@1 {
> -				reg = <1>;
> -			};
> -
> -			ethphy2: ethernet-phy@2 {
> -				reg = <2>;
> -			};
> -
> -			ethphy3: ethernet-phy@3 {
> -				reg = <3>;
> -			};
> -
> -			ethphy4: ethernet-phy@4 {
> -				reg = <4>;
> -			};
> -		};
> -
> -		usb3_ss_phy: ssphy@9a000 {
> -			compatible = "qcom,usb-ss-ipq4019-phy";
> -			#phy-cells = <0>;
> -			reg = <0x9a000 0x800>;
> -			reg-names = "phy_base";
> -			resets = <&gcc USB3_UNIPHY_PHY_ARES>;
> -			reset-names = "por_rst";
> -			status = "disabled";
> -		};
> -
> -		usb3_hs_phy: hsphy@a6000 {
> -			compatible = "qcom,usb-hs-ipq4019-phy";
> -			#phy-cells = <0>;
> -			reg = <0xa6000 0x40>;
> -			reg-names = "phy_base";
> -			resets = <&gcc USB3_HSPHY_POR_ARES>, <&gcc USB3_HSPHY_S_ARES>;
> -			reset-names = "por_rst", "srif_rst";
> -			status = "disabled";
> -		};
> -
> -		usb3: usb3@8af8800 {
> -			compatible = "qcom,dwc3";
> -			reg = <0x8af8800 0x100>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			clocks = <&gcc GCC_USB3_MASTER_CLK>,
> -				 <&gcc GCC_USB3_SLEEP_CLK>,
> -				 <&gcc GCC_USB3_MOCK_UTMI_CLK>;
> -			clock-names = "master", "sleep", "mock_utmi";
> -			ranges;
> -			status = "disabled";
> -
> -			dwc3@8a00000 {
> -				compatible = "snps,dwc3";
> -				reg = <0x8a00000 0xf8000>;
> -				phys = <&usb3_hs_phy>, <&usb3_ss_phy>;
> -				phy-names = "usb2-phy", "usb3-phy";
> -				dr_mode = "host";
> -				maximum-speed = "super-speed";
> -				snps,dis_u2_susphy_quirk;
> -			};
> -		};
> -
> -		usb2_hs_phy: hsphy@a8000 {
> -			compatible = "qcom,usb-hs-ipq4019-phy";
> -			#phy-cells = <0>;
> -			reg = <0xa8000 0x40>;
> -			reg-names = "phy_base";
> -			resets = <&gcc USB2_HSPHY_POR_ARES>, <&gcc USB2_HSPHY_S_ARES>;
> -			reset-names = "por_rst", "srif_rst";
> -			status = "disabled";
> -		};
> -
> -		usb2: usb2@60f8800 {
> -			compatible = "qcom,dwc3";
> -			reg = <0x60f8800 0x100>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			clocks = <&gcc GCC_USB2_MASTER_CLK>,
> -				 <&gcc GCC_USB2_SLEEP_CLK>,
> -				 <&gcc GCC_USB2_MOCK_UTMI_CLK>;
> -			clock-names = "master", "sleep", "mock_utmi";
> -			ranges;
> -			status = "disabled";
> -
> -			dwc3@6000000 {
> -				compatible = "snps,dwc3";
> -				reg = <0x6000000 0xf8000>;
> -				phys = <&usb2_hs_phy>;
> -				phy-names = "usb2-phy";
> -				dr_mode = "host";
> -				maximum-speed = "high-speed";
> -				snps,dis_u2_susphy_quirk;
> -			};
> -		};
> -	};
> -};

-- 
// Caleb (they/them)
