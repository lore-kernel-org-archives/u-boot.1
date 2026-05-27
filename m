Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB1CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B314D8470E;
	Wed, 27 May 2026 06:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFeflyOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499CF8470E; Wed, 27 May 2026 06:39:27 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5731780433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so887501766b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856765; cv=none;
 d=google.com; s=arc-20240605;
 b=PFaCpe6KBxcLNjGN57zcbzwPMr0QdZXQnnZ4/9SWgVlQ3TqG+eSYm9youMR4IfI2Eh
 11fMIFZoqlhCTs72/vYHKCaXQOhxc4uGcqGxcs8//4jCjWwYOpzyqu3o/25F/GbHIhPf
 nKHk+Q2oHToZg1CtYTOyyOiec2+XZE5gqU5Kst5vnKSxTpmvcd0drUFJ7Z77JWwQZQv9
 9wuhUGOQooYT2OGjMhS0BOn7qcEPMf4sBtx1yo7aW+dFMUN70Xj4YstpXFc2rdctc4yV
 j9/cWSPkfENZGbYVrqu+vU+DfSBb509SxZ78mRxPzTzMjXumlqYmz9Zt4r7biRigRzwd
 WdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h/SNYRs7dUg1RiBgjAOg3w6aD/vGoThjLBU2Bygn6tU=;
 fh=nqXbri/t605KwzaYj6FnepUyH8OpYdQ47z347Vj1Qjo=;
 b=cCdQ89Pi7RTySs+sKBvNqZVy0QZeKL13+ApG/2Be0j7o1j3OXTwJMRIDhyfYNnT/Of
 WrMhkNUatGPfGZABV20dsnz6Ps0OClYcsQEmVlJJ73jlWlMMH1X2XBO0jZKSTf8uSKcN
 qnUzwcQqLgX0w1gPV8kM+AOikeBgJgIEY8qLNmn6TAmcHYjaCTMRNanynCuXfwvNQDPg
 YKR/trfQq83zJx8eHK4bSg9ilzZfSarf5bD2bDr3YUXKm2j+Q+Ii7ujRZamyY5wnZ2kz
 ey1mQ9S7l92i+E9YkxM6o7M9AthZDEjttecMYr6FPteBK9clyvIXHL+8XlOQBYc4Zdmf
 lTPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856765; x=1780461565; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h/SNYRs7dUg1RiBgjAOg3w6aD/vGoThjLBU2Bygn6tU=;
 b=MFeflyOnMxXPu43e+0YNZ2dAfJ5WD6rIb2zIZokZFCnocAec+gL5HyZb/mDtzVA2RS
 P/O9FZA5Urhpx/6EppathOURYgIinZLhwxuHyXOlMCkd/wiSHSMeolS03WyTV3iwE/xJ
 xpNSCfhNR1k2TQq7igSIt4h3njfnCSA2mB5pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856765; x=1780461565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/SNYRs7dUg1RiBgjAOg3w6aD/vGoThjLBU2Bygn6tU=;
 b=RMEkZrzyvXAh9S48OmVQYWkr9XIQ9uladakY5VAucj/oEeXZVeBTzH/2Mp/zLRbSJV
 mgQ2RbTUy0O4p56zrMKI2nO4NxvdGmC5xep5XdtYVyNxZ5pARXyCs/Y5yKhbMThOELcJ
 QUpHfuOL3xzTnXbfCmP+w5Lnm5vQ/9DUBafVuDh7LnEmTS3e1NLbbDwsoDkTTSbA7avp
 +GYhXesGhVWGQchJFwVpwLUJElvrAkSyOOW8zaSnu7J7empvHpApjNJ/80wWrcZQH4ov
 DpSW8BFT8raLmz+kYm1yOVWP4dIXXaPLv6JKHNTP23XCaSbUaOvASIcaTojKqPtL6l1G
 S2Kg==
X-Gm-Message-State: AOJu0YyNKeBQieUeXZ4268EsC7UK9/Pj47ZW5Rujsly+Lm5tLVeCX1xn
 5+K4+EKziLxUhzSGjNDhHVig8idqfP5uUKjiEwfP3kmZBrD0yGv/pWHOPAWURTFfh1WwObC7BUI
 ptTbhZHJ8Cbo8gvo6UYiChMtBVGO+rbyjTuA3MqFZ
X-Gm-Gg: Acq92OHInclIpKuczi9TnNfC9fmqt7ebvQYOuYwdBGhvoRyhXuVEe2gXHh3qSUuYRP3
 PWrno/+3EWW3syZfkJecJR0kP36HRbWP967WeWCDwND6JNMSEIppsqmouMWkJ8q4krTIPWGGJZo
 oQbQgHzjul9RzUvyxQZ2M+OF0SqEBCVOh19N/Hveo/ci7gZLvbY6nnMovNQ8cvIj3rsgQvvBfai
 4TaZ5ZEg3ZxS+5kjf3wlPVatEJrHkqAGLqggX5aInOoQF00W+ihSvqPDb6XVE6v2ckXmol+CfP6
 ijpmHw==
X-Received: by 2002:a17:907:3e87:b0:be2:36d7:573b with SMTP id
 a640c23a62f3a-be236d757b1mr484019466b.12.1779856764750; Tue, 26 May 2026
 21:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-5-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260213112717.1256823-5-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:39:08 -0500
X-Gm-Features: AVHnY4LwUNI2noAGcj4A7iYiyd-frr_2-VEO1wBwpHiUh-9nzHYIngPORmT2qz0
Message-ID: <CAFLszTidnuvREN8xYPp2oSn1suo2DFYDaCPq_Zoo9i7aw4EsUw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mach-snapdragon: Integrate reboot-mode handling
To: aswin.murugan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org, 
 u-boot-qcom@groups.io, seanga2@gmail.com, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, 
 justin@tidylabs.net, jamie.gibbons@microchip.com, ycliang@andestech.com, 
 me@samcday.com, sughosh.ganu@arm.com, gchan9527@gmail.com, 
 ilias.apalodimas@linaro.org
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

Hi Aswin,

On 2026-02-13T11:27:11, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> mach-snapdragon: Integrate reboot-mode handling
>
> Add reboot-mode detection and automatic fastboot entry to Qualcomm board
> initialization. This enables 'reboot bootloader' functionality on
> platforms with reboot-mode device tree configuration.
>
> Changes:
> - Add qcom_handle_reboot_mode() call in board_late_init()
> - Conditionally compile with CONFIG_DM_REBOOT_MODE
> - Reorganize header includes
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/board.c | 56 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 11 deletions(-)

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -9,6 +9,15 @@
>  #define LOG_CATEGORY LOGC_BOARD
>  #define pr_fmt(fmt) "QCOM: " fmt
>
> +#include <command.h>
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <init.h>
> +#include <lmb.h>
> +#include <malloc.h>
> +#include <sort.h>
> +#include <time.h>
> +#include <usb.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/gpio.h>
>  #include <asm/io.h>
> @@ -16,22 +25,14 @@
>  #include <asm/system.h>
>  #include <dm/device.h>
>  #include <dm/pinctrl.h>
> -#include <dm/uclass-internal.h>
>  #include <dm/read.h>
> -#include <power/regulator.h>
> -#include <env.h>
> -#include <fdt_support.h>
> -#include <init.h>
> +#include <dm/uclass-internal.h>

Please split this header reorganisation into its own preparatory
patch - mixing cleanup with the functional change makes both harder
to review and bisect. The new headers actually required here are just
<command.h> and <reboot-mode/reboot-mode.h>; the rest is pre-existing
churn.

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
> +     reboot_mode = env_get('reboot-mode');
> +     if (reboot_mode && !strcmp(reboot_mode, 'bootloader')) {
> +             printf("Entering fastboot mode due to reboot reason...\n");
> +             run_command("run fastboot", 0);
> +     }
> +}

The env-variable name 'reboot-mode' is the default but is overridable
via the 'u-boot,env-variable' DT property in
dm_reboot_mode_pre_probe(). Reading it back from a hard-coded name
defeats that. Consider reading it via
dev_get_uclass_plat(reboot_dev)->env_variable instead.

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -575,6 +603,12 @@ int board_late_init(void)
>       qcom_late_init();
>
>       qcom_show_boot_source();
> +
> +     /* Handle reboot-mode detection and fastboot entry */
> +#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
> +     qcom_handle_reboot_mode();
> +#endif
> +

Please use if (IS_ENABLED(CONFIG_DM_REBOOT_MODE)) here rather than a
preprocessor #if

You'll need a stub for qcom_handle_reboot_mode() in the
!CONFIG_DM_REBOOT_MODE case, or guard the body of the function itself
so the call site stays unconditional.

With these:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
