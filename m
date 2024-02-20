Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B37C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630BF87DEB;
	Tue, 20 Feb 2024 15:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nh30nGn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDA887FC7; Tue, 20 Feb 2024 15:08:34 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C37187DE0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c1404d05bfso3770819b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708438101; x=1709042901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zElQoAb8iaVPIFfKnEH38bAiiHGEA0awcPnttE3seAU=;
 b=Nh30nGn/KmUl5YiP27+03LN5rG/J7+4+MGepgukjPDJ+l7V1Jh7TExrRAnFHOaTRDs
 +tGsU1o9zqMUmE11CM4SrFJiCQtyAXZQFGHRrgyxG23mcRL0WNbgZF36mEf456Sg8k5v
 m/fa95arT9k7joVLHWnNvmxwS1YkSGZkCZgqwUGXHQCsNJvcmjcsCyZHSdrXgpKYYLYK
 2kv+aLqjB9+aP+gAk80BjTHqs8UMKLrqFFG9y8xR4tgtUzBNck0VldijNyofrNgE3Z5I
 kbrHhcTQYuAX+XeemjafwsjEwTgUACmeXlECFZiWLzJBmRlMFYG2nGtRMKZ3dSc8uvh9
 +y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438101; x=1709042901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zElQoAb8iaVPIFfKnEH38bAiiHGEA0awcPnttE3seAU=;
 b=QkOwWBkpF86fDw4GILFwTmouloRohn+9am+cPUkSouk1IEt+OiVSK9updcjifIXNyn
 n5xB317YhWwHMGRF44DVvz9LSlCSwEeiTXDWKnLdsnoZr4lppYS94IbCt0D3URS8HWBL
 UocdtQ6/g/2YlgO2e3I4vPuiVmWk8TBUoOoVjVKmSwVo9RT7ekkpll0cFEUhJZHRCfGa
 LSOMotV8PT9u1PP/lO6EHxI2W9iscj010JS3H60eqGHyebCDP/3NVOvsjLS3yVinGoym
 4okhhj3VnlIQTbb9XOn2OgyPbAMvPCorcvey91hNcUF42gr9WOKk4h7f/eszSf6YuO+z
 +R9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCs8roUhqYNUqOvawGGkp2/fAGlUUTb6sPF9zpam9LtJAezXRVoVZun7rDfc20Wui336trhtNo2sLfYZ1PRlkDcst7zw==
X-Gm-Message-State: AOJu0YwEdQLRcgVFnStFukDfBf/k9CBSuswbd2P5M3FZySqGMUP8Py4j
 LD2NNBZHUla6wadcOluP+65adD8pV+QudydcyhlUpZu2fvUbUIMd5oAK+8biuWkRCTVTAOscQ0Q
 SBOpaHnoGqQNt0YGH7iHnRA6/c+CoeX44k84poQ==
X-Google-Smtp-Source: AGHT+IH0EAUt4ky4Osc68QwW9S66xuuMAfLHkfeV7mYthkIvI3d3ejRbj7ecKC0MyZ49+6je7NEiR1wlLe42KD37h1A=
X-Received: by 2002:a05:6808:1390:b0:3c0:4580:6919 with SMTP id
 c16-20020a056808139000b003c045806919mr16366791oiw.56.1708438101683; Tue, 20
 Feb 2024 06:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-39-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-39-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:38:10 +0530
Message-ID: <CAFA6WYNfG27-cDG5Egc4BnqBCr_icN-moGcqqBGgKC1E-Nggjw@mail.gmail.com>
Subject: Re: [PATCH v4 39/39] MAINTAINERS: Qualcomm: add some missing paths
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
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

On Fri, 16 Feb 2024 at 02:23, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add drivers and DTS files, as well as regex matches for
> qcom/qualcomm/snapdragon.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  MAINTAINERS | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46ba17647f3e..8b048b1faf7c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -576,18 +576,22 @@ M:        Caleb Connolly <caleb.connolly@linaro.org>
>  M:     Neil Armstrong <neil.armstrong@linaro.org>
>  R:     Sumit Garg <sumit.garg@linaro.org>
>  S:     Maintained
> -F:     arch/arm/mach-snapdragon/
> -F:     drivers/button/button-qcom-pmic.c
> -F:     drivers/clk/qcom/
> +F:     arch/arm/dts/msm8*.dtsi
> +F:     arch/arm/dts/pm8???.dtsi
> +F:     arch/arm/dts/pms405.dtsi
> +F:     arch/arm/dts/sdm845.dtsi
> +F:     drivers/*/*/pm8???-*
>  F:     drivers/gpio/msm_gpio.c
>  F:     drivers/mmc/msm_sdhci.c
>  F:     drivers/phy/msm8916-usbh-phy.c
> -F:     drivers/pinctrl/qcom/
>  F:     drivers/serial/serial_msm.c
>  F:     drivers/serial/serial_msm_geni.c
>  F:     drivers/smem/msm_smem.c
>  F:     drivers/spmi/spmi-msm.c
>  F:     drivers/usb/host/ehci-msm.c
> +N:     qcom
> +N:     snapdragon
> +N:     qualcomm
>
>  ARM STI
>  M:     Patrice Chotard <patrice.chotard@foss.st.com>
>
> --
> 2.43.1
>
