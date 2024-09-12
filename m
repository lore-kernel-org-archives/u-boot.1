Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3335EE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A6E88D5C;
	Thu, 12 Sep 2024 02:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W1Eu/p02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4998888D70; Thu, 12 Sep 2024 02:59:09 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532A388D7E
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718da0821cbso297826b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102744; x=1726707544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GlsiM+QMYPl220yJnswD7h/MBOmS0As1iDf/KGTcqPE=;
 b=W1Eu/p0297tGBYW7N5w8pBKTEXNoFuiv81H8D+Iv9uGP4xo0zm1BmiUiuUitZSLNU4
 TIGMJ28GpAVygX9pPWkdEkr8u3Mxw5AfrSQ1f3gzWfyK62igvqOakG/YEwJgUnjSDB+S
 zdE1G8nQE7mmXfDZmMH1wkl7Rh3lvJsOTZZck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102744; x=1726707544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GlsiM+QMYPl220yJnswD7h/MBOmS0As1iDf/KGTcqPE=;
 b=e65OtcnCJ8k6gQdEtpXORIsfD7Ijznf1ZR66g0Hw/hLK8Z0D0zXLHwJ0yxX8YMCOE9
 EdF/dV9MxXZALUfBqEf/6msHXi0tsW/ztt7cY95vEGba2Ng80d8cohK5g0596YshLGEo
 pSNddngE5eeTCLm7B1EewhGWRojO2H9RtQSkC3FCOpuHfx8j1T261OxQxQ8zHF+KLY+V
 UlaCUrovmw45RUpl3enrIBLv7QJ9tfYyi7jdhN/WpN+6pkFEn8/a4FLG6taAeTWmDRWH
 R8yuXZMqhgL/lUIsfelpQvMH7emjNDiGdm7BTCKkYwu1c5lkIQXbiLFBhVfRAxLmB8ux
 t5mw==
X-Gm-Message-State: AOJu0Yx77rhjzsku43VcgBJotwXiMfcSkBBq8QdpqL/6oPyyrZ45l4wc
 8i+mWQmXThfyJ6rrdR+gPjF/bt2/c49uF4IHMv6EwJQ8fE9A7a6+iSd/RXVaZ/RJDIoqmQzd7PW
 eBI3cNDrA4jnoG0H2aSKWAtvb5AFA20H0mCWB
X-Google-Smtp-Source: AGHT+IGgyuc8cStdqIFS1AiWQ9dZTpWcaBs36SFscRSHfA+uhhFSC70BQnw4g0wd75T+KODqjrxsV9smz5nmMVg1cfE=
X-Received: by 2002:a05:6a00:b83:b0:70b:a46:7db7 with SMTP id
 d2e1a72fcca58-719260962c0mr1654760b3a.16.1726102743872; Wed, 11 Sep 2024
 17:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-26-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-26-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:24 -0600
Message-ID: <CAFLszTjAtOS+cr6=4vMEm9y7DGzLT6jZ9wJDQLM31BBWpf8+tA@mail.gmail.com>
Subject: Re: [PATCH v3 25/30] arm: bcm283x: Generate ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Generate SoC specific ACPI tables for BCM2711:
> - MADT
> - FADT
> - PPTT
> - GTDT
>
> Board specific tables like DSDT and SSDT are added in a separate patch.
>
> When ACPI is enabled for a different SoC compliation will fail by
> design, indicating the required functions that needs to be implemented.
> When ACPI is not enabled the added code does nothing, keeping existing
> behaviour.
>
> TEST: Booted on RPi4 with only ACPI enabled, providing no FDT to the OS.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v2:
> - Drop duplicated code to generate ACPI tables. Is now part of efi loader.
>
> ---
>  arch/arm/mach-bcm283x/Makefile       |   4 +
>  arch/arm/mach-bcm283x/bcm2711_acpi.c | 150 +++++++++++++++++++++++++++
>  2 files changed, 154 insertions(+)
>  create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

> diff --git a/arch/arm/mach-bcm283x/Makefile b/arch/arm/mach-bcm283x/Makefile
> index 7cd068832f..38e320307d 100644
> --- a/arch/arm/mach-bcm283x/Makefile
> +++ b/arch/arm/mach-bcm283x/Makefile
> @@ -4,3 +4,7 @@
>
>  obj-$(CONFIG_BCM2835) += lowlevel_init.o
>  obj-y  += init.o reset.o mbox.o msg.o phys2bus.o
> +
> +ifeq ($(CONFIG_GENERATE_ACPI_TABLE),y)
> +obj-$(CONFIG_BCM2711) += bcm2711_acpi.o
> +endif
> \ No newline at end of file
> diff --git a/arch/arm/mach-bcm283x/bcm2711_acpi.c b/arch/arm/mach-bcm283x/bcm2711_acpi.c
> new file mode 100644
> index 0000000000..34adc0aa42
> --- /dev/null
> +++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024 9elements GmbH
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + */
> +
> +#include <acpi/acpi_table.h>
> +#include <asm/acpi_table.h>
> +#include <asm/armv8/sec_firmware.h>
> +#include <asm/arch/acpi/bcm2711.h>
> +#include <dm/uclass.h>
> +#include <tables_csum.h>
> +#include <string.h>

Please fix header order [1]

[1] https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
