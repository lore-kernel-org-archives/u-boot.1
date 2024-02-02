Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D254C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 08:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D900886F80;
	Fri,  2 Feb 2024 09:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F6IFD8Nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BBF86F7E; Fri,  2 Feb 2024 09:48:23 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F688753E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 09:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-46cfc9a79ebso249121137.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706863698; x=1707468498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1fIl6ZsGNCVvN7ZCp+BWgd/CtXDaW+zFCx31P2bDNPs=;
 b=F6IFD8NuIefSSYqPaZgNlhm1f4d+gxbKTwVvgcTx2gXiaY3kg/dMe0nUp39mFeYYKY
 EMLh/eHF71eQOSOmTXSTjFLlslKPnZ06pO+kl88Z+8a1AqDcPMBwQOsa1AnLSzdQsgIl
 MjbVVhMtoxaH/Xjr2sUr3Hd5Zj/oMaN3V6vDu/x3eXLDsh6ogr1x/cVd5M+6cUZQfS7w
 sgbUeretT6Q02VdLtyfKRZDTgddcKmkr7ObO4GG7iPXinvG81sGKeT/9yaCKtquDS5RG
 ETI6SEkskuZcr+dzkACMefue0LaEz9qq+Ii/5PU4j3qf4VZpzmMrrTyqEHNzxC7xkcHa
 IHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706863698; x=1707468498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1fIl6ZsGNCVvN7ZCp+BWgd/CtXDaW+zFCx31P2bDNPs=;
 b=M2A8CALdlEN2W72HR0dnzAEFDeK/H7KGPhkdx+P/QcZ+ExbP/juJIeYgKkBs99nNjM
 rWdBBtric+z8gtBVaW2oEsw5j5Cd4dIs/PY+TZTnGyq6iDsR8bBgTnD5f3a2RdgN9pf/
 ZdtD0zHCOuPxoZn4YgJrdGmQaeFIBbjsVNSPBeFcp6s0nngnXc4i46BuyeEbxW9QUpYR
 zPTyJP/H6BDqefzSqt8+//1vhlJ2YMtbz85+FICdS0eVJaz6FrlmAOKbw5Na2V1SCbb5
 lsaGZFvbVeMdNVwfRtWYFyFeeOsXAEYpANGGiOMJFlx8yO6BC0/eodF+3Jg+xTiZPWHq
 9WYA==
X-Gm-Message-State: AOJu0Ywww10q32gt+SRzfpsMtJ9kg7A3/aujhFF9/pJp2l26Zv799u6j
 +mPWLIDlj6tja5L0WZMhVjkn6DCw4oXQlmnbd/C2S4v4nFxQ5i/GVFE13pexZzVf6PgwwqY8KiG
 h8w2p0iLwPPjgy2G9aHymh+2gQrWDP/vqD9agNA==
X-Google-Smtp-Source: AGHT+IEDobV8xYKDrF+uE01pEpyuwgRJKU6csc+Z65G3UcT7vXKgWIhI+3BYbRwmo320hDIh90/H7mORmrT5Po3/76Y=
X-Received: by 2002:a67:f84e:0:b0:469:8762:4e68 with SMTP id
 b14-20020a67f84e000000b0046987624e68mr1502090vsp.33.1706863698321; Fri, 02
 Feb 2024 00:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-26-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-26-e523cbf9e556@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 2 Feb 2024 14:18:07 +0530
Message-ID: <CAFA6WYMDijFRzQyfQmQU=opjBRs59mTOrOsd=By1-8sdHKTQew@mail.gmail.com>
Subject: Re: [PATCH v3 26/36] dts: msm8916: import PMIC dtsi files
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

On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Import the supporting pm8916.dtsi and msm8916-pm8916.dtsi files from
> upstream in preparation for switching boards over.
>
> Taken from kernel tag v6.7
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/msm8916-pm8916.dtsi | 157 ++++++++++++++++++++++++++++++++++
>  arch/arm/dts/pm8916.dtsi         | 178 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 335 insertions(+)
>

[snip]

> diff --git a/arch/arm/dts/pm8916.dtsi b/arch/arm/dts/pm8916.dtsi
> new file mode 100644
> index 000000000000..f4de86787743
> --- /dev/null
> +++ b/arch/arm/dts/pm8916.dtsi
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +
> +       pm8916_0: pmic@0 {
> +               compatible = "qcom,pm8916", "qcom,spmi-pmic";
> +               reg = <0x0 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pon@800 {
> +                       compatible = "qcom,pm8916-pon";
> +                       reg = <0x800>;
> +                       mode-bootloader = <0x2>;
> +                       mode-recovery = <0x1>;
> +
> +                       pwrkey {
> +                               compatible = "qcom,pm8941-pwrkey";
> +                               interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +                               debounce = <15625>;
> +                               bias-pull-up;
> +                               linux,code = <KEY_POWER>;
> +                       };
> +
> +                       pm8916_resin: resin {
> +                               compatible = "qcom,pm8941-resin";
> +                               interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +                               debounce = <15625>;
> +                               bias-pull-up;
> +                               status = "disabled";
> +                       };
> +
> +                       watchdog {
> +                               compatible = "qcom,pm8916-wdt";
> +                               interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
> +                               timeout-sec = <60>;
> +                       };

watchdog button isn't supported by the U-Boot driver code. So it leads
to spurious error as follows:

Unknown button node 'watchdog' should be 'pwrkey' or 'resin'

I suppose the button-qcom-pmic driver should gracefully handle the
unsupported case.

-Sumit
