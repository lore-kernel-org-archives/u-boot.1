Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20451C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D018188DF4;
	Wed, 21 Aug 2024 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kaY5NRuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE55988DB7; Wed, 21 Aug 2024 16:00:07 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A481B88DCA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf7ad1ec3aso34448906d6.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248804; x=1724853604; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8jI2gYyJ3zCM0U0yCRTkgYHZbmcSa9n9btD7KNP5dQM=;
 b=kaY5NRuKuES3wlZun9Ts5O1sH8IJhb2RYivzeiizSWcmpamdVZyEXNHfP79ufwk6jl
 mZlY5bWd9DAvrGl3+ZvLmymcRFsXHehloLawxwJb4AePbgRzZ2Q7jTT5ElgdJ+NyDn03
 qna2P+JdFH0csgRBznbj7rHw25Giao0hh5X8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248804; x=1724853604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jI2gYyJ3zCM0U0yCRTkgYHZbmcSa9n9btD7KNP5dQM=;
 b=KkYXv7zSKnXSoIxtasrwSSujV7Jc1hWG+Ng0Ls+MmEFfqKY21uxIdMeTKQYIkjOV+A
 2smzxdaSHe1JrpQIZL8jWgYm1myQmSAGICA1kg5OTmYwJTy6s2ozFI1P400SqTdKAeHI
 vv1eK7kmmR+d/0vv7K/90Z8vbGPa9jXZakgpikmM8Jc4ygIt5aPWlNUV6HRO/JX3gczQ
 X/MQi7AzsLWDl3PIGLbXlloNr6zEetzEuSeLdhbGCBrckZqdnOImjmdZJx5eVPqmtQR3
 5gkUmUcUyjHItBzMJEKpHd2ZWpp/Tmsa2BJEj6wgcqo1yQReu4AxIAgtRk90eigF2aGM
 QTVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr9H22ODow9jef9vKN/ucN+8bDaRLY8kz7Qh9mwsbjw2iICL5IBoRGa+/3q6B6gYflRGiJ1Zw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz58Kj0TIegg52Lb0zrvHtkoKWDhMhtg7lnlgE76ypN8I0BoCXF
 xGpfuXXXc2PXEuO8dZECyxK2XEC9VYzF2pbWE9cRJ2CIkZcQ6ehpBo3+krG0kBep2ECgvquKdZk
 ckjDFkbGUbKRMG9Fk1Tau3uh9Rj4Dp2hETgyu2jo5a3Wz1tg=
X-Google-Smtp-Source: AGHT+IFG+1c4hFfQL0Vlq2tX9xZjeuUQEpavlG1G5pVedO9wiP+t6ziYxCtxOhdb4a1nEGlWQI4cYPHf3W9aOtRG374=
X-Received: by 2002:a05:6214:4a8c:b0:6bf:6e7e:1315 with SMTP id
 6a1803df08f44-6c1568432abmr28612476d6.35.1724248803974; Wed, 21 Aug 2024
 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-2-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-2-49b07633f3a8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:53 -0600
Message-ID: <CAFLszTib6FwJaTCTgJD2RqFyZx2XodnfkenZuxbqA-QcrzSPYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dts: qcs6490-rb3gen2-u-boot: add override dtsi
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 21 Aug 2024 at 07:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> For running U-Boot as primary bootloader we must define the memory
> layout statically.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> new file mode 100644
> index 000000000000..c3ec4a317f7c
> --- /dev/null
> +++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024 Linaro Ltd.
> + */
> +/ {
> +       /* When running as the primary bootloader there is no prior

We normally have an empty /* on the first line

> +        * stage to populate the memory layout for us. We *should*
> +        * have two nodes here, but ABL does NOT like that.
> +        * sooo we're stuck with this.
> +        */
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0 0x80000000 0 0x3A800000>,
> +                     <0 0xC0000000 0 0x01800000>,
> +                     <0 0xC3400000 0 0x3CC00000>,
> +                     <1 0x00000000 1 0x00000000>;
> +       };
> +};
> +
> +// RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
> +// RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
> +// RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
> +// RAM Entry 3 : Base 0x0100000000  Size 0x0100000000
>
> --
> 2.46.0
>

Can you please use lower-case hex?

Regards,
Simon
