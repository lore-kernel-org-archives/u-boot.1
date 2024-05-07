Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC84C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEAEB8873C;
	Tue,  7 May 2024 09:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XLk0N9KS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2251088723; Tue,  7 May 2024 09:38:07 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF348873C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59a0e4b773so656548666b.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715067484; x=1715672284; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUf5MCMHkqvclPWta1ZaUQKA9s3Zi0lThyE94trVxNU=;
 b=XLk0N9KS+TOVx5crLwYxZsNkbvTArsJsAcZhJvWQN5dkn9RQ0tHjV2/Bj4EshFo51t
 vVrSxQCtXlw3bj/Ch2lBFJpp0s4UP1MLGs9MZkZG3nRIf/Yu7HuSUZAgYnyFGO7nhfUC
 1WHIYzsl0AOclj+Ly8Q6t7d5+dRcZ57WY4zdJRedIvFbiYjrsPzRe5rA17tR1eNDvGjc
 9JDE1Lk8xbT6EEi7EvpoJUFYp64vqdV4mmLdhpDz7juJEWKOjHtXMt1XTJJdWKBtl6RP
 Hlc6f4Lbk2ecWTSFV+Dp9DzYXWhGskeXmBvL8ZANNnL1VETek6To4/Z4tHgBMKf9P5vU
 lxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715067484; x=1715672284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUf5MCMHkqvclPWta1ZaUQKA9s3Zi0lThyE94trVxNU=;
 b=qrjImWIyMz2PXuM2ElLwbNHLIwTfg9LU9bigR2vBZqLsfvIqk7M5s3kKQgHX8SdxO6
 Ld+zVRxiX2W74jt8ABP0QEUgYZjFqGP1WWAv6d5m4asAxK6xeolQJAjSz+UqP+tnBaT1
 sxjJDJnfa6n21/kvLrW4mBTTTFH4pmiyKUsdJrW1L7bFc+z8zh7LdP2SSjlKu6dx3bn4
 nS3w6vL+I2mzxd06UiNbRJNJumKfHAp2eUHq3kZ9CIXwY7013AtGWgCECF8tVAKcS9Ip
 /mesl6PhEM2uSN8j8XQrf6lXvI4b6C41SAMELD2/FkTmYkyn7HRF5U/4ewje7uPHmtpN
 ORuQ==
X-Gm-Message-State: AOJu0Yx0NcNOCWr52Zx8Q0MSxu8hN7NFPUvX/1JGzzZO4zrm5WFo+zPF
 W7wm2s/Ya2/25ujgFMBzgKOZC+OTBIkkO5LRxgARotkUU4PsCTrgmm0VBHzF6cPbj+X300u1Qol
 Zqelhng/ASfd4zEAbw6SFV/GCGsAb43LoRYrMwQ==
X-Google-Smtp-Source: AGHT+IH9Qtfn+mzBB2dgVjMaWHLc+lw48lV40iLg6NbJvnqnhCVCPvwGTYn7jVe96fcB8jIPI2jzEAlH6jGNZqdFtQc=
X-Received: by 2002:a17:906:7d4c:b0:a54:c130:21fd with SMTP id
 l12-20020a1709067d4c00b00a54c13021fdmr7122547ejp.13.1715067484416; Tue, 07
 May 2024 00:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-29-trini@konsulko.com>
In-Reply-To: <20240502013138.2383421-29-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 May 2024 10:37:28 +0300
Message-ID: <CAC_iWjL1Zi_hGy8d0T6vb11a9m+zwTryx78++gTHfM7s_Z2Zzw@mail.gmail.com>
Subject: Re: [PATCH 29/81] firmware: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Weizhao Ouyang <o451686892@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
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

On Thu, 2 May 2024 at 04:32, Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Tanmay Shah <tanmay.shah@amd.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Weizhao Ouyang <o451686892@gmail.com>
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Cc: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c    | 1 -
>  drivers/firmware/arm-ffa/arm-ffa.c           | 1 -
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c   | 1 -
>  drivers/firmware/arm-ffa/sandbox_ffa.c       | 1 -
>  drivers/firmware/firmware-sandbox.c          | 1 -
>  drivers/firmware/firmware-uclass.c           | 1 -
>  drivers/firmware/firmware-zynqmp.c           | 1 -
>  drivers/firmware/psci.c                      | 1 -
>  drivers/firmware/scmi/base.c                 | 1 -
>  drivers/firmware/scmi/mailbox_agent.c        | 1 -
>  drivers/firmware/scmi/optee_agent.c          | 1 -
>  drivers/firmware/scmi/sandbox-scmi_agent.c   | 1 -
>  drivers/firmware/scmi/sandbox-scmi_devices.c | 1 -
>  drivers/firmware/scmi/scmi_agent-uclass.c    | 1 -
>  drivers/firmware/scmi/smccc_agent.c          | 1 -
>  drivers/firmware/scmi/smt.c                  | 1 -
>  drivers/firmware/ti_sci.c                    | 1 -
>  17 files changed, 17 deletions(-)
>
> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> index f1e91d151ea3..e0767fc75517 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> @@ -5,7 +5,6 @@
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
> -#include <common.h>
>  #include <arm_ffa.h>
>  #include <arm_ffa_priv.h>
>  #include <dm.h>
> diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
> index ee0bf9a55b48..94e6105cb38e 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa.c
> @@ -6,7 +6,6 @@
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
>
> -#include <common.h>
>  #include <arm_ffa.h>
>  #include <arm_ffa_priv.h>
>  #include <dm.h>
> diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> index 4bf9f6041fec..1521d9b66ac3 100644
> --- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> +++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> @@ -5,7 +5,6 @@
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
> -#include <common.h>
>  #include <dm.h>
>  #include <mapmem.h>
>  #include <string.h>
> diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
> index 11142429c09b..44b32a829ddf 100644
> --- a/drivers/firmware/arm-ffa/sandbox_ffa.c
> +++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
> @@ -5,7 +5,6 @@
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
> -#include <common.h>
>  #include <arm_ffa.h>
>  #include <dm.h>
>  #include <log.h>
> diff --git a/drivers/firmware/firmware-sandbox.c b/drivers/firmware/firmware-sandbox.c
> index d970d75f781d..226b5cfc191e 100644
> --- a/drivers/firmware/firmware-sandbox.c
> +++ b/drivers/firmware/firmware-sandbox.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Xilinx, Inc.
>   */
>
> -#include <common.h>
>  #include <dm.h>
>
>  static const struct udevice_id generic_sandbox_firmware_ids[] = {
> diff --git a/drivers/firmware/firmware-uclass.c b/drivers/firmware/firmware-uclass.c
> index e83a147a000b..84caf25548be 100644
> --- a/drivers/firmware/firmware-uclass.c
> +++ b/drivers/firmware/firmware-uclass.c
> @@ -2,7 +2,6 @@
>
>  #define LOG_CATEGORY UCLASS_FIRMWARE
>
> -#include <common.h>
>  #include <dm.h>
>
>  /* Firmware access is platform-dependent.  No generic code in uclass */
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index dfad798a2e7d..f99507d86c61 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018-2019 Xilinx, Inc.
>   */
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 03544d76ed4a..c32c3f5c6a54 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2015 ARM Limited
>   */
>
> -#include <common.h>
>  #include <command.h>
>  #include <dm.h>
>  #include <efi_loader.h>
> diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
> index 1d41a8a98fc6..f4e3974ff5b4 100644
> --- a/drivers/firmware/scmi/base.c
> +++ b/drivers/firmware/scmi/base.c
> @@ -6,7 +6,6 @@
>   *             author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <scmi_agent.h>
>  #include <scmi_protocols.h>
> diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
> index 7ad3e8da9f08..6d4497f4b92a 100644
> --- a/drivers/firmware/scmi/mailbox_agent.c
> +++ b/drivers/firmware/scmi/mailbox_agent.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_SCMI_AGENT
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <mailbox.h>
> diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
> index 48dbb88a3fb5..631625d715bf 100644
> --- a/drivers/firmware/scmi/optee_agent.c
> +++ b/drivers/firmware/scmi/optee_agent.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_SCMI_AGENT
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <scmi_agent.h>
> diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
> index cc9011c7312f..19be280ec448 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_agent.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_SCMI_AGENT
>
> -#include <common.h>
>  #include <dm.h>
>  #include <malloc.h>
>  #include <scmi_agent.h>
> diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
> index 603e2bb40aff..96c2922b067e 100644
> --- a/drivers/firmware/scmi/sandbox-scmi_devices.c
> +++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_MISC
>
> -#include <common.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <log.h>
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> index 0f1003e167e6..8c907c3b0328 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_SCMI_AGENT
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <scmi_agent.h>
> diff --git a/drivers/firmware/scmi/smccc_agent.c b/drivers/firmware/scmi/smccc_agent.c
> index 972c6addde21..ac35d07ebaff 100644
> --- a/drivers/firmware/scmi/smccc_agent.c
> +++ b/drivers/firmware/scmi/smccc_agent.c
> @@ -5,7 +5,6 @@
>
>  #define LOG_CATEGORY UCLASS_SCMI_AGENT
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <scmi_agent.h>
> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
> index 509ed618a997..67d2f4500249 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -6,7 +6,6 @@
>
>  #define LOG_CATEGORY UCLASS_SCMI_AGENT
>
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 6c581b9df9c0..8ce0f46e70c8 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -7,7 +7,6 @@
>   *     Lokesh Vutla <lokeshvutla@ti.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <log.h>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
