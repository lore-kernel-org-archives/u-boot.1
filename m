Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F987606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Im33X68B;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WTHbhrH2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B85340508;
	Thu, 19 Nov 2026 21:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zsGDBzduADX; Thu, 19 Nov 2026 21:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AD18404EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795124362;
	b=rjQHgAistwhF494voETSv8P1jQ+E1Wp4vyrre4U1eu9dWUKwYTb8e2EnNPmIN9bAv07N
	 vVohBbvO8A67vodpGA2ZxjAW3OxbT8dQvuj2smTLQpTe6Qhn8sFL5uwtoc574+FvuEVtu
	 1RHaJA1EIIPmeIDMX9lePZSwL4cJOF0AmLTh5r+y8IijG21jG3cS4VakPs5c8uQlgdWkr
	 oT92LK094xcRI5QOSX6E2XcWBgXuBIB4zJRRJK9bMPjyoPwb4YqR/05rZzHQj+/RctlDz
	 MYrltMvVlvd5nkkFIkzLsgxGa0/HNtkE8X55ZCVfHcPHABs/rGa/laU9oKOkMHaOoxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795124362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pmDpEjZeZ3miJHE+Nwh+zsglrQa0sHg9eIahuXd8ztU=;
	b=fM/NOOcpJsPdFFKJb55l0n3gTvhhsyUxVAIDgybXe7CRA2DbILfnLUuvzp8aZdOxspz/
	 V2NFIeWINcTDqGFwTJcvj6LkWGxwTbok4X4xoR+FcnB7HmaflblJmuLMUDCAp1k6Zu/B3
	 3cIIWNPsugso+1G/OEBa5q3amiVs44E7sm2tgTLxYw2iSUSr8yUY0OLdb6Vnfr5s/GTqT
	 RD43wRb8tx3QUV0N6YoukWBwpp23qs50+Q/zz3ZoVu1v7+mSt30P/5iREve19rlR1Cl3S
	 Hqj3YzKuN4T3ryJhw20BpYYvUYX8/7IwawWUQGUPxbIepWj3uAo/CCf19tp1vvMeXEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795124362;
	bh=pmDpEjZeZ3miJHE+Nwh+zsglrQa0sHg9eIahuXd8ztU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Im33X68BQo5TXHuGegXfpzfdy2zRCAzZRvqQWG4cHsv1dZc5VwV5fPF1zTQWdZ18C
	 WEU8EUnnBYKtiW9liJD5c6TT3bqpWsD+YE9yjmWvH77Q2TWypgkuKOkkJ4BsCAiW0e
	 kbcLm4UdGgxAGIbOCOAsHGMXsYruVAkiTWc73pdSoqcdn4HWCViBhG/8a0WGEaPeAw
	 3StsTUeLCP7aqI1+0p+R7DmwxrL+uBBMud4sZL5ELic/K3aoiksWFGSZZGnJJjrGkU
	 bNfsgD9VLFJPfPePrMa+0AHRimggaLEVS8DowvCpHOG+XEvWHibTuOtnshhCj04dB0
	 lrate7u3yEv7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD18404EE;
	Thu, 19 Nov 2026 21:39:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C7932F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E9FA40099
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57AcczrkFypJ for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:39:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8BEAB40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WTHbhrH2
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BEAB40079
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:39:19 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-862b090e3c3so125967a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795124358; x=1795729158;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pmDpEjZeZ3miJHE+Nwh+zsglrQa0sHg9eIahuXd8ztU=;
 b=WTHbhrH2vlm6emqb+9UR3yyeQWpAkTuNxNIeQBbLLr3mqabgJAuxIq2kvy6SubILCu
 EHhug5usu4Q3cD6ukEQH69K9z+ONv4reV1B2I2IRbvKlESH3+g5GlROOVA+827RZVyfL
 mFRkru6F04itQkNGajhTPSF2tmP30JqMElxAn2tQu0mIAynB96XI3hPIDHKfUsAyZUUR
 iCnh/eTUd6N7FtEO2iXxVVX8CHiCDhA0l0xoY4HbqoIgaSjYZPRhRdkckEQk8zCV677S
 hb1oASWZHXvDa7IGIy3yB6P0+799a8nS0ELQTBom5RSZFywnAWomguShBKwO84/rgZUo
 e24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124358; x=1795729158;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmDpEjZeZ3miJHE+Nwh+zsglrQa0sHg9eIahuXd8ztU=;
 b=w3jVz4yGcj1nsxoS/3fwdrhRhmF8ZdldWB3NepLFpKiQciHoB2S3TEv/lHuaW05HfO
 EzrGQDri2yQYCUoR+x3QcXSjnaGErPIuvVlHyAKuLmg/fbn6wl2KEV3DA2TgbHHwqZyl
 eRiWib/dI4lQ/f8QMg8tvlU6owOgpFRFIRZqOwCXzKSYzxtzgTTMIlq8BPvUT9w2Dei/
 oWettcehbp4YZkXG2LSBDn/9RPNNWFUQl2OSAdwq8vITXUGEpyrgXOC3z/PYk7Z9Wv6E
 k0i9JoxGWHSfZ1jW/ad/zNkIItmgziZQnZ//bx3c90j0RGE+AovQ7RhaUeaQcmWgI0Dc
 Zd0A==
X-Forwarded-Encrypted: i=1;
 AL+hErHauBH5nixyiD31IIrFN3KDExkJjYHZKa78dSs6+RTuUdRq5T1kQgOBEXX5KkBekV8hjuVc7WU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+dSNcDHrvIPj/S5I8OT+Cazi42WaG56jkQNccb1irbUfjLpqzB
 Qab5uhMKl2iIcZhVtUMSSCkURLZLFVETgUgv807zmeNKrlxOMq/NnT+FBKtqfaW2JTM=
X-Gm-Gg: AYBFou2YQAVTIX+Dpj/JQjJup/fOoOZHvbEydcVAHXREtJLO7peqsWALTqVr1GnPTXu
 rsMkKuM3nQgTlKMIAD+e3/PzlmiBLjQL9sXV/cDriyDPBcJ3CDRatTE3BuhASt07yy+n4rTSZoh
 XkPowRAmZgaLhdshvfxn4DYb1tbYixWyU01wRELMK5oChQO78Xim3yOqfjSLGmtnnuhny+Mz6M2
 bRBHdEMn4L4dVgv79FHUYJgGoFHzImoONrbirfDsjnHXAfLwtZGuLJxEKpcHdOBNqM7725qqPWj
 aI2hRgjr8D0MLqZ1xBiXaWR9H76onBU4Vc9D1xx1ULxF9fc5Kign3wPTVMVDjis91/M16UU4Vg9
 ecMcSeKQ8NF732ypUDPyZKYYPjLIBq3/q2qgn2iwnh6WgYKRjmwOSNt8De6I3RT960xY9/eWtaz
 5uf6o/sFKogXaK7LAMwMMud/fVV5OOTOEMklgR0izHKy49aeTuo997gICMX7CePKJ1R/8mOYIl5
 7E6bQqpxBHXV77PFf75cAxre+dk/lKPKseeroF1xFpkjxTgB2ThoiwvS+WfJ//wyYjdbllS8/ja
 rnn+I99oe2wugU8fiAJhNv+ZkkAld2U6OQoa4eCE99OA+TeAGwNJl4G1K9w44nEZOuLZtIm7/5x
 J5nfZzybO0k2Yd+HAmLSm8cSm
X-Received: by 2002:a05:6830:640e:b0:861:5a01:b30a with SMTP id
 46e09a7af769-86315aabdecmr1580719a34.27.1795124358210; 
 Thu, 19 Nov 2026 13:39:18 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86316822ad4sm604551a34.3.2026.11.19.13.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:39:17 -0800 (PST)
Message-ID: <bfa5a6ea-d318-4fdb-8c9c-397887f701f1@baylibre.com>
Date: Thu, 19 Nov 2026 15:39:16 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm: mediatek: enable I2C4 and I2C5 on the Genio 520
 and 720 EVKs
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
 <20261118-ccaione-upstream-mtk-g720-i2c-v1-7-916dd6cc8d1a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-7-916dd6cc8d1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 2:29 PM, Carlo Caione wrote:
> Both EVKs have an MT6375 on I2C4 and an RT1715 on I2C5. Enable the
> two buses in their shared board devicetree and the U-Boot i2c command
> in their common configuration.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8371-genio-common.dtsi | 32 ++++++++++++++++++++++++++++++++
>  configs/mt8189.config                 |  3 +++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
> index 5b06690620..9190a37707 100644
> --- a/arch/arm/dts/mt8371-genio-common.dtsi
> +++ b/arch/arm/dts/mt8371-genio-common.dtsi
> @@ -12,6 +12,8 @@
>  
>  / {
>  	aliases {
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
>  		serial0 = &uart0;
>  	};
>  
> @@ -351,7 +353,37 @@
>  	};
>  };
>  
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	clock-frequency = <100000>;

Upstream has 400000. Also below.

> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
>  &pio {
> +	i2c4_pins: i2c4-pins {
> +		pins-bus {

		pins {

To match upstream. Also below.

> +			pinmux = <PINMUX_GPIO59__FUNC_SCL4>,
> +				 <PINMUX_GPIO60__FUNC_SDA4>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c5_pins: i2c5-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO61__FUNC_SCL5>,
> +				 <PINMUX_GPIO62__FUNC_SDA5>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	disp_pwm0_pins: disp-pwm0-pins {
>  		pins {
>  			pinmux = <PINMUX_GPIO29__FUNC_DISP_PWM0>;
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> index 52d9cfbc4c..2285bc499d 100644
> --- a/configs/mt8189.config
> +++ b/configs/mt8189.config
> @@ -17,6 +17,7 @@ CONFIG_BLOBLIST=y
>  CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_UFS=y
> @@ -24,6 +25,8 @@ CONFIG_CMD_USB=y
>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CLK=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_MTK=y
>  # CONFIG_MMC_QUIRKS is not set
>  CONFIG_MMC_HS200_SUPPORT=y
>  CONFIG_MMC_MTK=y
> 

