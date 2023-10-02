Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA18E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A14874F6;
	Mon,  2 Oct 2023 03:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OhO6nH/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8D9874E0; Mon,  2 Oct 2023 03:23:19 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DE1874CB
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso2173374866b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209785; x=1696814585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uMG7cls+hUjAS/gBB8C56EnBoojMeS6NwK0ZLz6+lO0=;
 b=OhO6nH/O1Hv+cldeLFDHnHseTEMtgwwtIwvjWjHkYrfa4I4qKy9/nkISnTHfMNGiBv
 dTY9SLDBZo3i+JDlBdjVcukMCPrBVj9NVmxSF0G0L8HUx3BmYhsZ6yx6gLE9+F/t7k3q
 QDW4O7stkqWJ4npTteMBBBasc4HUkXntvHPXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209785; x=1696814585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMG7cls+hUjAS/gBB8C56EnBoojMeS6NwK0ZLz6+lO0=;
 b=uhv/nc5nIJZeVpFFMaI4IzHvgwOEgjU75zbaqHqLpvjBhsx9ig2u3iUm8nIu3mHsqx
 uoQ3tKbLncBWUdYQkQXivD+IgTyb80R85xoLb7xr98I84GSyD5oZOwZdIAPG89DxQiqp
 8cGR+8H33vzYEsjajmS9LxuwUcgqvLnz+sCRG3A28MYMUYFcfSoXFcKMmzdzS1sm/mjg
 Yd5g5oRJ7GR/NBMGATa9cK6eJxaAXMAahSPNyoOuxgA0EI7fMKIHc1gUcpbp7/6VTOFC
 +TvhKaskEleNNHUsAP4OsQATvUKUawSieis6dJRxSiBUdCL2kaR47NkmOkm8m2Pt1/04
 pXkg==
X-Gm-Message-State: AOJu0YzXTKAXYthQzk49XAAL03eAKFH8/v8g/RpEDAMm/aQwQmJh2nyS
 uprAAGnsbHY/iHLcub2oBZ7uv9h2RObfT6sMGL5TJw==
X-Google-Smtp-Source: AGHT+IERIg/ErlNXq6BGp3c+txrENEvZitxJemAhYq5YDh92FEZ9hsL/nPDCSNZ8peES+FeY0l8zgbhwybB1irMwu8o=
X-Received: by 2002:a17:906:9c9:b0:9ae:4f9e:7813 with SMTP id
 r9-20020a17090609c900b009ae4f9e7813mr7470830eje.73.1696209784918; Sun, 01 Oct
 2023 18:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
 <20230926070043.738340-4-takahiro.akashi@linaro.org>
In-Reply-To: <20230926070043.738340-4-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:17 -0600
Message-ID: <CAPnjgZ20qGzZD=jNh0c2cucN-M8AKnvSh_kD0bL9=JeCC+doLA@mail.gmail.com>
Subject: Re: [PATCH 3/4] sandbox: add SCMI power domain protocol support for
 testing
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de
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

Hi AKASHI,

On Tue, 26 Sept 2023 at 01:01, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> SCMI power domain management protocol is supported on sandbox
> for test purpose. Add fake agent interfaces and associated
> power domain devices.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/sandbox/dts/test.dts                    |   6 +
>  arch/sandbox/include/asm/scmi_test.h         |  20 ++
>  configs/sandbox_defconfig                    |   1 +
>  drivers/firmware/scmi/sandbox-scmi_agent.c   | 265 ++++++++++++++++++-
>  drivers/firmware/scmi/sandbox-scmi_devices.c |  10 +
>  5 files changed, 301 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 36de6a37cf6d..38fcf42cd23d 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -693,6 +693,11 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
> +                       pwrdom_scmi: protocol@11 {
> +                               reg = <0x11>;
> +                               #power-domain-cells = <1>;
> +                       };
> +
>                         clk_scmi: protocol@14 {
>                                 reg = <0x14>;
>                                 #clock-cells = <1>;
> @@ -1589,6 +1594,7 @@
>
>         sandbox_scmi {
>                 compatible = "sandbox,scmi-devices";
> +               power-domains = <&pwrdom_scmi 2>;
>                 clocks = <&clk_scmi 2>, <&clk_scmi 0>;
>                 resets = <&reset_scmi 3>;
>                 regul0-supply = <&regul0_scmi>;
> diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
> index ccb0df6c148f..1b0f4464b98f 100644
> --- a/arch/sandbox/include/asm/scmi_test.h
> +++ b/arch/sandbox/include/asm/scmi_test.h
> @@ -6,10 +6,21 @@
>  #ifndef __SANDBOX_SCMI_TEST_H
>  #define __SANDBOX_SCMI_TEST_H
>
> +#include <power-domain.h>
> +
>  struct udevice;
>  struct sandbox_scmi_agent;
>  struct sandbox_scmi_service;
>
> +/**
> + * struct sandbox_scmi_pwd
> + * @id:                Identifier of the power domain used in the SCMI protocol

@pstate ?

> + */
> +struct sandbox_scmi_pwd {
> +       uint id;
> +       u32 pstate;
> +};
> +
>  /**
>   * struct sandbox_scmi_clk - Simulated clock exposed by SCMI
>   * @id:                Identifier of the clock used in the SCMI protocol
> @@ -45,6 +56,8 @@ struct sandbox_scmi_voltd {
>

[..]

Regards,
Simon
