Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70804CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F5D84DAB;
	Fri,  8 May 2026 19:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DeYQj3cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC88284D9E; Fri,  8 May 2026 18:49:40 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C1584D6D
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso298433166b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258978; cv=none;
 d=google.com; s=arc-20240605;
 b=cO4KoHysadFPutYQfAoCdHB79Va4SDr7MxyOL0isPl4upA/S1w/k4vF09sJjDqsgz6
 4Ktsgach2dpgqjRkP1nruqN4KxFVLQhfWRA5wQvusl4AB7yak1zX8UuFEPXS9X0YU5G8
 Qz66leSeozW3sLzULaQ/yHhodtgAr33kJoLr/0aEdhctZ0kJ1za47LE86TECnEtZ1MoW
 UDfNPQ/ok7pBDjqYX7JQrlxcmJ+Pj2C6T/KmjaLSvrwV0OOfAEn24UVYxBlomy7sU9EM
 vD39O9fUEkdN7aeT/n2TmCnIjLs4nthb0RxWiwJwXJaRqmlJMROjq9nStQVAfRw2skYU
 1uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3mVZZdeQ2a2RK6/L9smiT78A1FfouJlPbqzo2pxYgcA=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=Jb7gox+PhGk58z8U8kVBkQM4IX2vmjORA/5swmisIZ34kXLonBmlzOJJeF1ZKGAY7f
 2iQa6lxwN2/eDtXcMQXGki4bg8+nFV2QZSUuW03YheEF1D8WxdUtmOKjYdacFlihDxun
 JlOHTY1be6MId5+cBTNn602Rv3se5f/YkGrYaZlFddHLqn3fqf+xIgqUaIh9dyfNo/ad
 75AdOLIABqqyBFeHAX27s+F3LRemIV1I4BAtgH+XMUF16Zz3VSVuBvyj9nZihqXK9csX
 VuhZbudDWr4dJNzYji60Jav6VY6JVj4dUYVJx381eCzaosk9QG6V8m+2PNrgxaNHVjrj
 FGtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258978; x=1778863778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3mVZZdeQ2a2RK6/L9smiT78A1FfouJlPbqzo2pxYgcA=;
 b=DeYQj3cuUwONOpOIZgi7YvnYPFRM8eXmnXrV5t3SsokfGzY6FM3VOdDPdcFNvYp/ue
 ebfX9/+YSuy+fprnurpV4h+Cp1CkWOyAlae44uteSTyHUxTZe92bzWuhHyv5QCQWMMgR
 anFZCp04nznA3pK8VMhMx11Kl8u+dQOEn9rQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258978; x=1778863778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mVZZdeQ2a2RK6/L9smiT78A1FfouJlPbqzo2pxYgcA=;
 b=kfmCUR6fkYaNC5O0vOIx+PM26Ev3F/R4yFdk57Eapiuy/HF46R2JOnHy01kBL8O5nq
 jF+TsoZc9gSCrEgRlDGpjdK3EF6ejDn6iTHs0dhZFCNVet0pdNdQhL48OVBIkZpCg92Y
 TfYCyzuAfYR0yBDryGRiuFxtZAahCa2myUr1jOtQHDKRLRQS+lEA+EnUa4JQOrA1IM3P
 COEtQ21BQgbL7chBIRQRsIr8smX5sYGqKa8q/O2NTrMl/St4Hscs7YSIpvCR6JzufheE
 Z7EKlJYaCc1wgU1IvOdinmE69Ph0pSc2bQcXGnhmMNUNMLwwL9YhF7nTy96WrUmknfxt
 1fEQ==
X-Gm-Message-State: AOJu0YwGJ88UHINfpFOcJ49aBjFHY5tNwbHKD7fFkMe1zkmn7v4u0hU5
 Zho6mtoJmWB21rK9tQoddn/VHVN25fjzzD/IR10RCuWeWqwzPkYwJoFSa1YeKGrlQVn4hnfNQMZ
 qEjNSn/9Du+hVA+lmUqwM7O1PhymW2/XyPh9WskS0
X-Gm-Gg: AeBDievijIpfnGEWz76b/D3PbE8HBkRtY7ybUu5kTJqG074gIq4x8qigcU7MhvBEjR5
 hPQCjfO1SbnwPEvdczPwvaNrw9Y1OJXZk08iB/+RnuzZ9ydtsxPCuVl97aVNbkQ4fUs+8Zcqxkm
 szwoUm19W0rBrlVh6rIPq8gaFde9KDtaTp+koger48mutAJClOR0XtTGz8t9bnJlu0dlNE4jks/
 QkZ4Y9XEhP6d72ALlrvF9g0BUh0Cnxc7kq87qZTWnJuxtjSkyeh4wD/XIn/M/ZRzujS9k/r/9Ok
 /9DV8w==
X-Received: by 2002:a17:907:782:b0:ba7:ade5:8605 with SMTP id
 a640c23a62f3a-bc56ae2897amr866059566b.6.1778258977913; Fri, 08 May 2026
 09:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
 <20260508-qcom_spl-v6-4-aaac1ab17b50@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v6-4-aaac1ab17b50@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:49:25 -0600
X-Gm-Features: AVHnY4Iy8F08D_vx4WsOP2_0fqb1eCwU0A0VtTY137PFuiAxA4Hfeuq3s0Vzv90
Message-ID: <CAFLszTiMG3z6TqGc3D5=NdTVXgUFNekhKMyZNyKQPbVL4gL-1Q@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] mach-snapdragon: boot0.h: split out
 msm8916_boot0.h
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 08 May 2026 19:24:23 +0200
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

Hi Michael,

On 2026-05-08T00:33:28, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: boot0.h: split out msm8916_boot0.h
>
> Prepare for supporting alternative boot0.h per-SoC by splitting out
> the existing msm8916-specific code.
>
> There is now a selection mechanism to choose a specific boot0.h
> in the Kconfig. BOOT0_MSM8916_PSCI_WORKAROUND is the only option
> right now, but more can be added. The toplevel boot0.h additionally
> enables conditionally performing the include only in u-boot proper,
> or only in SPL.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/mach-snapdragon/Kconfig                   | 16 ++++++
>  arch/arm/mach-snapdragon/include/mach/boot0.h      | 60 +++-------------------
>  .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 +++++++++++++++++++
>  configs/dragonboard410c_defconfig                  |  1 +
>  4 files changed, 79 insertions(+), 52 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> @@ -11,6 +11,7 @@ CONFIG_ENV_OFFSET=0x0
>  CONFIG_DEFAULT_DEVICE_TREE='qcom/apq8016-sbc'
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_SYS_LOAD_ADDR=0x80080000
> +CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y
>  CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"

Do you need to see CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND=y in
hmibsc_defconfig too? It looks like hmibsc_defconfig is also an
apq8016 (msm8916) board with CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y, so it
currently relies on the same PSCI workaround and will silently lose it
after this patch. If not, it is worth mentioning in the commit
message.

> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
> @@ -1,54 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Workaround for "PSCI bug" on DragonBoard 410c

...
> +#if defined(CONFIG_SPL_BUILD)
>       b       reset
> -
> -     .align  3
> -el1_system_param:
> -     .quad   0, 0, 0, 0, 0, 0, 0, 0, 0       /* el1_x0-x8 */
> -     .quad   reset                           /* el1_elr */
> -el1_system_param_end:
> +#else
> +#if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
> +#include 'msm8916_boot0.h'
> +#else
> +     b       reset
> +#endif
> +#endif

You could flatten this with #elif - which would make it more obvious
that the SPL path is intentionally a stub.

    #if defined(CONFIG_SPL_BUILD)
        b       reset
    #elif defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
    #include 'msm8916_boot0.h'
    #else
        b       reset
    #endif

Regards,
Simon
