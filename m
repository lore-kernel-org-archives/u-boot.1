Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8927C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 12:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D52871CC;
	Fri,  1 Dec 2023 13:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OTQhWKiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3CC87209; Fri,  1 Dec 2023 13:51:45 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6090685E44
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 13:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4b28e7a5b41so682294e0c.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701435101; x=1702039901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j23fTRcHbpoumYRtbu+fjvttO1YBai7oo4/uVQJg9yo=;
 b=OTQhWKiDLRw5Cc5qxS2/BJZ4i63dAVExkRsV48/SqXNrwET/kKFTKANQhL670ie96E
 JdKupfercEdU9yvuBXfz763BZcm95Id9g8tAd3iwbP3qEWxTaSpy5r7eiEN8B9pTqssZ
 BWm5Jh/ThsFvkWb1XxNiz1sFDjGiHlWxO3EBC+xHBa+sTNOtOXplKDQ2kTp6RbQUC2QD
 rwaW9z5MQrQidqOgNezUoZa9jK00l/hSGg32WlAvFuhvsYeL5uDFQxTtS5vKmaV+Db0e
 DCQy9/c/7OiE3pXfUYFnXlssrAz6vjwEcqyEP954BS1virTSnetVn55+XM3lqcmGBWb+
 H0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701435101; x=1702039901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j23fTRcHbpoumYRtbu+fjvttO1YBai7oo4/uVQJg9yo=;
 b=Pq5ZYtQTfwaR8KEQOo56QZN5FP90lEw4I+sNLnFXgv3JDi4JXFNIQ2lcNoAUv4TV0e
 D2Gs9q0wBw4aABdfA0fjFXN0+o/y0+ejgMwhno62hNGWhXa9r8qNc5L7bQPWKGoiRXYI
 3EH7XLEFoBoOlJqWF9R9mjzAJE9BXvV6l3dZL67pJ39tsuFHpPIZkq7t3hNrKGxVYtz0
 iQ1HyNNE7lwf2+PFaQvqIdxS21CQcfRYvfiTNNLcMbqZngxfNFL2xo3Oi9N8GCw9xNRD
 BpAxdJS9wBXu8mOB5PFNUa3yWmuqmDp2L1GLf5qzGarYJCbRtwBe6yji/TOekJT+MMRF
 rBgQ==
X-Gm-Message-State: AOJu0YxfHUud/laGS2ZHFWGqCrtmDA1k6SvVI5W4yTLh8y2Rijt+lFkV
 SQ4es9IVulb6cOXlSlOYHaWHjnwBhQyLBV0X3JFmzg==
X-Google-Smtp-Source: AGHT+IGHa8kmIkqOepWFUk1n4FDDfKuposrypLWE/ojiBI4cLz9Wx1sRPPW++zM8rxk+y2Al8+S1Qr7IBJBCu7tcOVw=
X-Received: by 2002:a1f:c342:0:b0:4b2:8bdb:3449 with SMTP id
 t63-20020a1fc342000000b004b28bdb3449mr7221056vkf.13.1701435101043; Fri, 01
 Dec 2023 04:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Dec 2023 18:21:27 +0530
Message-ID: <CAFA6WYM3cEf97jZ0H-f3SdchehOC4TRWYjCqahh-2WXvXzuB0Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Qualcomm PMIC fixes
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

On Fri, 1 Dec 2023 at 01:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This series addresses some long-standing issues with the SPMI arb
> driver, the PMIC, and the PMIC GPIO. It fixes compatibility with
> upstream Linux devicetrees, and simplifies pwrkey/resin support by
> rewriting the pon driver to be a button driver rather than a GPIO
> driver.
>
> Existing users are adjusted to use the new button driver in their
> oard init code.
>
> This series is based on the pinctrl [1] and clock [2] cleanup series.
> There may be some DTS conflicts applying it standalone.
>
> [1]: https://lore.kernel.org/u-boot/20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org/
> [2]: https://lore.kernel.org/u-boot/20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org/
>
> ---
> Changes in v5:
> - Split "rework pwrkey driver into a button driver" into multiple
>   commits
> - Split "qcom_pmic: fix support for upstream DT" into multiple commits
> - Link to v4: https://lore.kernel.org/r/20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org
>

This series looks good overall apart from minor issues. So once you
fix them, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Also, I gave this a spin on QCS404 and didn't find any regressions, so:

Tested-by: Sumit Garg <sumit.garg@linaro.org> (QCS404)

-Sumit

> Changes in v4:
> * Remove some now unsupported DT binding docs
> * Fix qcs404 SPMI arb dts
> * Link to v3: https://lore.kernel.org/r/20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org
>
> Changes in v3:
> * Remove now-unneeded header includes in dragonboard{410,820}c-uboot.dtsi
> * Drop non-standard DTS support from PMIC GPIO driver
> * Also remove old gpio-keys nodes from starqltechn-uboot.dtsi
> * Link to v2: https://lore.kernel.org/r/20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org
>
> Changes in v2:
> * Avoid using non-standard "label" and "linux,code" properties for
>   buttons
> * Add missing sdm845 DTS parts
> * Put button driver in drivers/button
> * Link to v1: https://lore.kernel.org/r/20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org
>
> ---
> Caleb Connolly (9):
>       gpio: qcom_pmic: fix silent dev_read_addr downcast
>       button: qcom-pmic: introduce Qualcomm PMIC button driver
>       mach-snapdragon: switch to PMIC button driver
>       gpio: qcom_pmic: drop pon GPIO driver
>       gpio: qcom_pmic: support upstream DT
>       dts: qcom: adjust pmic gpio to use upstream bindings
>       gpio: qcom_pmic: drop gpio-count property
>       spmi: msm: fix register range names
>       pmic: qcom: dont use dev_read_addr to get USID
>
>  MAINTAINERS                                      |   1 +
>  arch/arm/dts/dragonboard410c-uboot.dtsi          |  11 --
>  arch/arm/dts/dragonboard410c.dts                 |  25 +++-
>  arch/arm/dts/dragonboard820c-uboot.dtsi          |  12 --
>  arch/arm/dts/dragonboard820c.dts                 |  26 ++--
>  arch/arm/dts/dragonboard845c-uboot.dtsi          |  11 --
>  arch/arm/dts/dragonboard845c.dts                 |   4 +
>  arch/arm/dts/qcs404-evb.dts                      |   9 +-
>  arch/arm/dts/sdm845.dtsi                         |  28 ++--
>  arch/arm/dts/starqltechn-uboot.dtsi              |  10 --
>  arch/arm/dts/starqltechn.dts                     |  20 +--
>  arch/arm/mach-snapdragon/Kconfig                 |   3 +
>  arch/arm/mach-snapdragon/init_sdm845.c           |  45 ++-----
>  board/qualcomm/dragonboard410c/dragonboard410c.c |  31 ++---
>  board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
>  doc/device-tree-bindings/gpio/pm8916_gpio.txt    |  48 -------
>  doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt |  94 -------------
>  doc/device-tree-bindings/spmi/spmi-msm.txt       |  26 ----
>  drivers/button/Kconfig                           |   9 ++
>  drivers/button/Makefile                          |   1 +
>  drivers/button/button-qcom-pmic.c                | 165 +++++++++++++++++++++++
>  drivers/gpio/Kconfig                             |   3 +-
>  drivers/gpio/qcom_pmic_gpio.c                    | 146 +++++---------------
>  drivers/power/pmic/pmic_qcom.c                   |  13 +-
>  drivers/spmi/spmi-msm.c                          |  46 +++----
>  25 files changed, 341 insertions(+), 475 deletions(-)
> ---
> base-commit: 4d5dd7090b5ad770974a377f704907893469ebb3
>
> // Caleb (they/them)
>
