Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC64E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7953D86DE1;
	Mon,  2 Oct 2023 16:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AhxahxZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D598C86DE1; Mon,  2 Oct 2023 16:04:29 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545C686CBA
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4064867903cso65155265e9.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696255466; x=1696860266; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4vY4FztZ0cMrW7YePV43G3OHaF7W09n30OsEvx87QHY=;
 b=AhxahxZzy59dOyrZgKYL9aHrh2XXzSyqjpezsES8XFyYqn9TOu87Nb7b7UWs4w/C9/
 iL56Sm2CBqOxfaPJC5VWf+dwWr/W54+l9/ho9HbWYTGHveAZyOGMKP2F8oMFCcT+Rzmy
 RpvzhnU0oSF7koymozkDPkrYSLVhFcPla8jNmg35mZ4gF7CqGAnUlEJADqk0R0HpE/YI
 QFEdmdVD/XoX3n2APK65z9kx2c2No69Nbgt0PT9efuxXrkd+TfSf25PKvef/NcV2oBcv
 kl+7THsMJr/iPwGmOnJVet1WVqrr04XjgVSQ0gaqDSy2LzCKM/8wkWYKyJdYFFfHdLED
 7IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696255466; x=1696860266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4vY4FztZ0cMrW7YePV43G3OHaF7W09n30OsEvx87QHY=;
 b=h/QT7OfbwFDbjdPYM+/KtzwKGspPZy17IPantbw9n4GaO86/JWcUcQlDsj5pIq4E/J
 JNOoT7A1i1jxHGoZEVPitC0bvEaP+GfBNWwCcc7tv0zY2sMYNEdr9bby1Yvp+wWmrMmM
 TMQfm+x9q1vaCWpyfc4FvfIyBuYeEt+2cN6XDAfh3+67ZvPTebtV2dbVR7cC9cqFZAxh
 /Q8sbXU2Q4WZILODPFIjUXa+hZQmqnYZ5Wyq6218i8uQo30/pL6xqsYpvaeCoMyjnYvW
 WFxe0KE+2K/0sn4oKzOSuFXeellLnMV5A1tDzKnkYykUL/kTt4QMLw0dbGLLZ89n1EEK
 C8ww==
X-Gm-Message-State: AOJu0Yxnvuoqg7Y/okx/tqakUzPVUHzTIRf8bi6A8Hj+UgWL9IE5knX2
 huJhxgfTCP+WM6gRxkIU9q2v6Q==
X-Google-Smtp-Source: AGHT+IEUtk/lGfwi5CCnUfySgRIRhrA6W8PaIw2RAuQTvF0OYmLlaQJolVAEeKCyzgoZGnxhkNMlFA==
X-Received: by 2002:a5d:568d:0:b0:319:7c7d:8d1 with SMTP id
 f13-20020a5d568d000000b003197c7d08d1mr10726870wrv.44.1696255466413; 
 Mon, 02 Oct 2023 07:04:26 -0700 (PDT)
Received: from [192.168.7.91] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b003142e438e8csm28123240wrt.26.2023.10.02.07.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 07:04:25 -0700 (PDT)
Message-ID: <83cb83de-f771-1054-98ed-0e322fc775a2@linaro.org>
Date: Mon, 2 Oct 2023 16:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/16] arm: dts: Introduce j784s4 u-boot dts files
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-11-a-nandan@ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20231001165545.494212-11-a-nandan@ti.com>
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

Hello Apurva,

On 10/1/23 18:55, Apurva Nandan wrote:
> Introduce the base dts files needed for u-boot or to augment the linux
> dtbs for use in the u-boot-spl and u-boot binaries.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add binman and ddr dtsi files ]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>  arch/arm/dts/Makefile                        |    2 +
>  arch/arm/dts/k3-j784s4-binman.dtsi           |  505 +
>  arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi | 8757 +++++++++++++++++
>  arch/arm/dts/k3-j784s4-ddr.dtsi              | 8858 ++++++++++++++++++
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi       |   25 +
>  arch/arm/dts/k3-j784s4-r5-evm.dts            |  105 +
>  6 files changed, 18252 insertions(+)
>  create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 85fd5b1157..21cfebff58 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1327,6 +1327,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
>  			       k3-am68-sk-r5-base-board.dtb\
>  			       k3-j721s2-common-proc-board.dtb\
>  			       k3-j721s2-r5-common-proc-board.dtb
> +dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-evm.dtb\
> +			       k3-j784s4-r5-evm.dtb
>  dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
>  			      k3-am642-r5-evm.dtb \
>  			      k3-am642-sk.dtb \
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> new file mode 100644
> index 0000000000..f9b191424c
> --- /dev/null
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -0,0 +1,505 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + */

<snip>

> +&binman {
> +	ti-spl_unsigned {
> +		filename = "tispl.bin_unsigned";
> +		pad-byte = <0xff>;
> +
> +		fit {
> +			description = "Configuration to load ATF and SPL";
> +			#address-cells = <1>;
> +
> +			images {
> +
> +				atf {
> +					description = "ARM Trusted Firmware";
> +					type = "firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "arm-trusted-firmware";
> +					load = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
> +
> +					atf-bl31 {
> +						filename = "bl31.bin";
> +					};
> +				};
> +
> +				tee {
> +					description = "OPTEE";

The official spelling is "OP-TEE".

> +					type = "tee";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "tee";
> +					load = <0x9e800000>;
> +					entry = <0x9e800000>;
> +
> +					tee-os {
> +						filename = "tee-pager_v2.bin";

Since OP-TEE 3.21.0 this could/should be replaced with tee-raw.bin. Although tee-pager_v2.bin is still produced unconditionally (even when the "pager" feature is disabled in OP-TEE) it might not be the case in the future, and the name is somewhat misleading when pager is disabled anyways (which is clearly the case here since tee-pageable_v2.bin is not used).

Thanks,
-- 
Jerome
