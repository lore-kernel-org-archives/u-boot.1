Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B15C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 06:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F370787F3A;
	Tue, 20 Feb 2024 07:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KMOzZwAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA0387DE9; Tue, 20 Feb 2024 07:31:18 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BEA87F79
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 07:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-47063d4b17cso674414137.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708410667; x=1709015467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BBMD3yI5/xzt5OQNjxNoK6yDUrkxOxGUvJM+A1if+rk=;
 b=KMOzZwALaEjJhQaunwBjUgcGICniYlkcu2pCwgoEsvw/j7QHdRHNmsCPRe+zlC3NWr
 Nu8QnRvkc1G3VTk/NWcp8jAwiab5Lh7D1D/o+kZCjNKuIG75Gu7V2PCjo6Kzpp7HEH1z
 GVhInn9MgpPTI1KoRAS8MxxQp5f3/SsoD6bEmfDVYQ2Nln6C8FWACHjouIliS+I1LpcI
 qeYkJe21r5aHooS0eJ9d3AAGVmELNxpigw1QAXXrlhwo2/9vBHEVbAAXcWmeE6FdrMYW
 BZrGSqX28uULxCNdpSla5NVKIUVCEBxoGD+Olyglt2dpzNSOSmMK5tXvsjAP4sA6pPjY
 xSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708410667; x=1709015467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBMD3yI5/xzt5OQNjxNoK6yDUrkxOxGUvJM+A1if+rk=;
 b=n8HMTTF1/GQaCs3dPD5rHg+R+SJV0QMgWcCzZVBavrjNz2HaareI23zpBwE9ql6aZ+
 aEmYyPjptk3g8dni1+c5Nl4rg20bIwa6GvPWyXPHgqGgapEEj3IvMuU3y/7ar5WQZzOV
 CnCs/5Hl0ja0BsNt5rBfpPJijPILsExpueFR5v+Mz6TfmN6jcslhpzIQ3AXB0H/2uhod
 6xlntOcvzksREfcYeetsX6SXFYe55syMsGyS7Qsu4tl6posOX+XEiCC1sDHBMgjfuBqY
 7Gza5LnL1Wov8hoDPzHmTFttwot4gEjJyyvNeFyZwpN3eciPCiKSu2vdTWaSkn01TrMN
 lDTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJPTGYwgaY2l/3M7Y6mAUDuFwwnaEsF/1QvSABvgqobUNOUxxVLlxBJHX4ou5cvoQr18QImsQgg0B1OGhZWFSo3RWMnw==
X-Gm-Message-State: AOJu0Ywm82xqDnID0NLR/0MbknakXfJTVlPgdPDOKx3T5el9OPT8tAf4
 G1rbZj1L/65j8xEx04S3qBZ4s+BYd8Na2OxLMPuEl9WB4uPQhAlTtb4p+QOS5RxpgfDbdPp98IZ
 5C4ZgQhVN/EO4yTi8MzF8qRP8lt7g6dPrXiQ74A==
X-Google-Smtp-Source: AGHT+IH5lKrGNeV44iOwFni7heiCSgRR+RxtbK/iz1MgdBrH4nMhilZ/rDXHhVYnI2NAvomJe9qcdiZ5R1QzIw7nO5U=
X-Received: by 2002:a05:6102:12d6:b0:470:5ce1:cee7 with SMTP id
 jd22-20020a05610212d600b004705ce1cee7mr2974068vsb.14.1708410666882; Mon, 19
 Feb 2024 22:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-12-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-12-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 12:00:55 +0530
Message-ID: <CAFA6WYO+dQ2p0xzs4Q5-yQ2XbdtybH1F2h0-9G88h+b0MFBLqw@mail.gmail.com>
Subject: Re: [PATCH v4 12/39] sandbox: dts: fix qcom pmic gpio
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Adjust the DT to match upstream bindings.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/sandbox/dts/sandbox.dtsi | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
> index 241f397ba6e7..c93ce7128942 100644
> --- a/arch/sandbox/dts/sandbox.dtsi
> +++ b/arch/sandbox/dts/sandbox.dtsi
> @@ -419,17 +419,16 @@
>                 #size-cells = <0x1>;
>                 pm8916@0 {
>                         compatible = "qcom,spmi-pmic";
> -                       reg = <0x0 0x1>;
> +                       reg = <0x0 0x0>;
>                         #address-cells = <0x1>;
> -                       #size-cells = <0x1>;
> +                       #size-cells = <0x0>;
>
>                         spmi_gpios: gpios@c000 {
>                                 compatible = "qcom,pm8916-gpio";
> -                               reg = <0xc000 0x400>;
> +                               reg = <0xc000>;
>                                 gpio-controller;
> -                               gpio-count = <4>;
> +                               gpio-ranges = <&spmi_gpios 0 0 4>;
>                                 #gpio-cells = <2>;
> -                               gpio-bank-name="spmi";
>                         };
>                 };
>         };
>
> --
> 2.43.1
>
