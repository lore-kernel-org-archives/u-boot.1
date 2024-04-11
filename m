Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD958CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 07:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1103087F52;
	Thu, 11 Apr 2024 09:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WhKIvBat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA85A87F3F; Thu, 11 Apr 2024 09:54:45 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87145881B2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 09:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-417d092f39aso2752375e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712822083; x=1713426883;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=M8e+PNFNonfWc2kO6DsY89E93Tz9C36XlOf+fkptQdE=;
 b=WhKIvBatQvuZS0069NMZ+rTjd/rPwOikhp7IYEAjXvCfnU6VX6wp0KFryZ78ef4jEQ
 PHrYbmA6LCZVZRKu0ZbI3GU92MJoUgI3UE0VrBbSbw/NA6s91bib/0X3aiZnRq+eHRWm
 P4j7uU7ZnPnoL7o66FbPZWLo5Zepdne/t8EAV1rqI5oMu34qhWQhyaUpDVGz29athAZi
 MHZAgQzRnuop+Z3gAAGZzVikzXJZ+eekbETChoaGg1NEgqajGuGri/j1hcz4Yrm7mLgj
 2mXBEsWXyS1/kyuW/JEQIT5XF0eaeFhTaYaqQX1K2cDg+WMGz85Y6PtCy0bTtpbtATVS
 GAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712822083; x=1713426883;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8e+PNFNonfWc2kO6DsY89E93Tz9C36XlOf+fkptQdE=;
 b=dTGANrfY0cidTU3DSxL9JcMDCnzzY/f9/AluNfE5zVf/8H2zEHeZJ5ztZhUqgk8tbW
 KNpobY8+2mZ8jQ8NBkU+3ooKx1Nx+mGnM3H/LW4i7dLUlwn5zmSuwkXxhFpQlwuJcUb5
 E8T9hAFdRGTKE16FMCVnjC1UJxMoX8ySDnAw1VHLNJVzOs9u0WaOsmq9WHBFNKopnJ5c
 llF0XhnqpQSIXzfHt3DjPCzHEePy2LZ8qjdeJZCUCM98MfFL2DwZEQpLyhh2PUj2XWVc
 LOQ3+Ex/Ve1YRnvGAjqSMs6O2SKK8ER08W7JCEG9ohgqhFOY6Dm//ySIp5Mlhk+wwP4s
 0BFQ==
X-Gm-Message-State: AOJu0Yyo+MMx4w1sVlBsA4eOEdlpeHTArRkppPo7r61L66F4gaPpLXte
 qnOjUc29IC1F67Nhe1IbheGoyMpsqBOOvri8jRPu/0JW6GRdhKGogpYw/JFK6PM=
X-Google-Smtp-Source: AGHT+IHrF9+28z1Fyt5OjOo+QxB2ShdLU6n+yEuFj8fQa1Vlkat2ehCGskzcNJGIM/8lI+F+wY4izA==
X-Received: by 2002:a05:600c:19d4:b0:417:5be9:1319 with SMTP id
 u20-20020a05600c19d400b004175be91319mr1782306wmq.12.1712822082906; 
 Thu, 11 Apr 2024 00:54:42 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 n9-20020a05600c500900b00416290b3e1dsm1537972wmr.24.2024.04.11.00.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 00:54:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian
 Gmeiner <christian.gmeiner@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime
 Ripard <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonathan Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH v2 12/16] arm: dts: k3-am625-sk-u-boot: Add
 sysreset-controller node
In-Reply-To: <20240408223134.165877-13-j-humphreys@ti.com>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-13-j-humphreys@ti.com>
Date: Thu, 11 Apr 2024 09:54:38 +0200
Message-ID: <87cyqwe3lt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jonathan,

Thank you for the patch.

On lun., avril 08, 2024 at 17:31, Jonathan Humphreys <j-humphreys@ti.com> wrote:

> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Please consider adding a commit message body.

On the TI vendor tree, there is a similar patch with a commit message:
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=c5296d943c2c84dd6dcb3b91305d006ac46f3157

Before patch:
=> reset
resetting ...
System reset not supported on this platform
### ERROR ### Please RESET the board ###

With patch applied:
=> reset
resetting ...

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on am62x sk evm

Andrew also suggested to me that if we are interested by A53 reset only,
we can PSCI reset instead for all k3 architecture:

 --- a/arch/arm/Kconfig
 +++ b/arch/arm/Kconfig
 @@ -784,6 +784,9 @@ config ARCH_K3
          bool "Texas Instruments' K3 Architecture"
          select SPL
          select SUPPORT_SPL
 +       select PSCI_RESET if ARM64
 +       select SYSRESET if ARM64
 +       select SYSRESET_PSCI if ARM64
          select FIT
          select REGEX
          select FIT_SIGNATURE if ARM64

Has the above been considered?


> ---
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index fa778b0ff4c..35bfeae75a0 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -46,3 +46,12 @@
>  &cpsw_port2 {
>  	status = "disabled";
>  };
> +
> +&dmsc {
> +	bootph-pre-ram;
> +
> +	k3_sysreset: sysreset-controller {
> +		compatible = "ti,sci-sysreset";
> +		bootph-pre-ram;
> +	};
> +};
> -- 
> 2.34.1
