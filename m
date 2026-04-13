Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0EEF34C4B
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 12:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8794F839DF;
	Mon, 13 Apr 2026 14:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s5X0QWQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BDA483DC9; Mon, 13 Apr 2026 14:24:39 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A9B7839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488c2690057so41586115e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776083075; x=1776687875; darn=lists.denx.de;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzEYOWaS57tBNFxeUqDhAXRkROVxoJ1ZCv3z8ueBmj0=;
 b=s5X0QWQhtTRwskFQ9N3AkKap8PZ7ii4Q2beHLnu2d7Feao3imgQV9IojaPhWyAVEIB
 DTKKuGMW1V34rOH+duPaY9AGh+wKygnRWEPQLCUqDuEU8x757VJiMmtZLH5yoC6gGABI
 Yn14LspahhF4NCljnUyN9NEuRC/+bXmabB7Ppg1DUdqWuISqOl/wP+am0wP9iePixy63
 TLmmNKdPoUT59qoU2/Q5ExiZDv7pSE2jyDHCNutV6CleKnmx249qdkL73l9KS19Y6VxA
 qtSSjHxkMHnAwX3KAdyXdYUItIQWy1hkVEbZiWnqIhQptNamyxZC99scSsdKqNQeIHbC
 jd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776083075; x=1776687875;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzEYOWaS57tBNFxeUqDhAXRkROVxoJ1ZCv3z8ueBmj0=;
 b=gPj2aGuWpLDEMVJtkYpaRUgWBhlgbqZqaYPvlWxo3uhPzFYiQXI3oxhY5jrxUX/eNE
 YKrWhCe2cTxejI74dYZccirRi/GMAz7bb1UJ6LfXXkgbFtA8KykdGisL1grhV4aUszuj
 28DzrgGAjnRuGmjNkPT8H6Gowy6MoG5Okr44LK/rqCIx14yLAUB32WkV5ao/wS6CR5qF
 4dFQdti9qkkv8eReFxvpmYjFM3qFL2Q8sv4ybADRt5VVuzbQBkFTtKHVK780buWO5Pg8
 Pqpj13QovXJwiZv8zFDuFOTMbczvtOpL5xy//zssJSwQk8A4URu6KwxF2RFhFCp/e1SU
 tZxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/txHa04IqsOrciZwwy19ngMS5HCdXzaXPsviV5ZJImjEItoM/Rud578upQSk0lvF9kjn0ZQH0=@lists.denx.de
X-Gm-Message-State: AOJu0YwoDFrsoLxkfu7ajS+WqVn6R7pqG7zyJEkmBiJTdR39Z4ga58o6
 EvmWkIU7iQ9wxxX9BEPxh0QrCzXvouyPMCIYmDdRMqHeoXXrKlX1ww8lGm4c/TM1nV8=
X-Gm-Gg: AeBDieuOVeZZLB1ni9Gt20x3BtcVCeS74MZmIfjPd06t2AQSRRc8Tp3klgD4La/GVqC
 VklptueEDtCFMhQL11O/DsNFl6AZ5CgaCXUhGXfN6SKvkQl6N0f8loTSxu1OPCxc9KYLYCdxCrI
 6bI1FdkEIfgIPAOgxrjqnbK3CfohG459N/sSmJiHDv5GOEnUZbhMc7vJ4Yo2dedaKsOmIuproBc
 Z4pTSaBpfPJpsmY3RiLHkEBsc5xgpHhudX/9eD1S7O44UL14gUUk1bCnIZdn7juBLGMo3Olv5BS
 vryyTgbfyYJTNVZgMEDUjohL0FoBRcbipI+FBN32YZx849JtCNILrjWfmM+eUg809OQExFMCKRj
 +QvvQ0iMjbepNssTpLCTb7zv5GjygDyHXzJs7GD7ac4ya3MBfIrsYXxAJYy2AD+OnkmE0nHPfEW
 koMBGVDRA/lN87PmlInwmrB6GRY3vWUm6WyYP1iL3OsT5kk0jp40UVgvVtLdV3wtkh9iTq
X-Received: by 2002:a05:600c:3107:b0:488:8b52:f7de with SMTP id
 5b1f17b1804b1-488d6860930mr165134105e9.12.1776083075305; 
 Mon, 13 Apr 2026 05:24:35 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d53808b2sm360618475e9.11.2026.04.13.05.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 05:24:34 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/7] mach-snapdragon: Integrate reboot-mode handling
From: Casey Connolly <casey.connolly@linaro.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org, 
 seanga2@gmail.com, sughosh.ganu@arm.com, gchan9527@gmail.com, 
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org, 
 marek.vasut+renesas@mailbox.org, hs@nabladev.com, msp@baylibre.com, 
 ravi@prevas.dk, dinesh.maniyam@altera.com, sajattack@postmarketos.org, 
 peng.fan@nxp.com, quentin.schulz@cherry.de, jamie.gibbons@microchip.com, 
 mateuslima.ti@gmail.com, justin@tidylabs.net, wens@kernel.org, 
 n-francis@ti.com, ycliang@andestech.com, jerome.forissier@arm.com, 
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20260408121841.186410-4-aswin.murugan@oss.qualcomm.com>
References: <20260408121841.186410-1-aswin.murugan@oss.qualcomm.com>
 <20260408121841.186410-4-aswin.murugan@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:24:32 +0200
Message-Id: <177608307280.1177412.930103688416218651.b4-reply@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4518;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=7zIHkAKfsseF/nK92u/nyG1XWFtBQw9CvdMdSeiw3cA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw7DxpzxT5f3MExU3DD9vZZb89M/FL+56RRfPXjg+sl9
 i/gEdjL0lHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmwlXK8N9TRMMmzfa57tpV
 uVMer278ze8ZI/o14NuBvwxpEz5Vye1gZOi1j7msnK3dtW5tVnfP0/oXntsOSjvOUr6s/sqD0WD
 r+n8A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

On 2026-04-08 17:48 +0530, Aswin Murugan wrote:
> Add reboot-mode detection and automatic fastboot entry to Qualcomm board
> initialization. This enables 'reboot bootloader' functionality on
> platforms with reboot-mode device tree configuration.
> 
> Changes:
> - Add qcom_handle_reboot_mode() call in board_late_init()
> - Conditionally compile with CONFIG_DM_REBOOT_MODE
> - Reorganize header includes

Please shuffle around headers in a separate path. Also you add power/regulator.h here but it's not
clear why?

Rather than adding board code for this, could we instead teach reboot-mode-uclass to just probe
the FIRST reboot-mode driver automatically and call dm_reboot_mode_update()? Maybe put this
behind a kconfig option?

It's a bit of a mystery to me why this functionality is stuffed into DM when it clearly doesn't
really belong there, but yeah as usual I'd rather fix the core code here than continue the cycle
of board/platform-specific boilerplate that is wholely unnecessary.

With that change b/q/default.env can be updated to check the env var in preboot_cmd rather than
jumping the gun and running commands before we even get through late init.

Again apologies for the late review.

Kind regards,

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v4:
> 1. Added early return `if (!IS_ENABLED(CONFIG_DM_REBOOT_MODE))`
>    inside `qcom_handle_reboot_mode()`
> 2. Removed `#ifdef` wrapper around function call
> 3. Function now defined unconditionally with runtime check
> 4. Provides user feedback when fastboot command fails
> 
> Changes in v3:
> 1. No change in v3
> ---
>  arch/arm/mach-snapdragon/board.c | 59 ++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..c3e97cdbfdf 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
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
>  #include <linux/arm-smccc.h>
>  #include <linux/bug.h>
>  #include <linux/psci.h>
>  #include <linux/sizes.h>
> -#include <lmb.h>
> -#include <malloc.h>
> -#include <fdt_support.h>
> -#include <usb.h>
> -#include <sort.h>
> -#include <time.h>
> +#include <power/regulator.h>
> +#include <reboot-mode/reboot-mode.h>
>  
>  #include "qcom-priv.h"
>  
> @@ -506,6 +507,38 @@ void qcom_show_boot_source(void)
>  	env_set("boot_source", name);
>  }
>  
> +/**
> + * qcom_handle_reboot_mode() - Process reboot-mode detection and handle fastboot entry
> + *
> + * This function detects the reboot reason from PMIC registers and automatically
> + * enters fastboot mode if the reboot reason was "bootloader".
> + */
> +static void qcom_handle_reboot_mode(void)
> +{
> +	struct udevice *reboot_dev;
> +	const char *reboot_mode;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_DM_REBOOT_MODE))
> +		return;
> +
> +	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &reboot_dev);
> +	if (ret)
> +		return;
> +
> +	ret = dm_reboot_mode_update(reboot_dev);
> +	if (ret)
> +		return;
> +
> +	reboot_mode = env_get("reboot-mode");
> +	if (reboot_mode && !strcmp(reboot_mode, "bootloader")) {
> +		log_info("Entering fastboot mode due to reboot reason...\n");
> +		ret = run_command("run fastboot", 0);
> +		if (ret)
> +			log_warning("Failed to enter fastboot mode: %d\n", ret);
> +	}
> +}
> +
>  void __weak qcom_late_init(void)
>  {
>  }
> @@ -570,6 +603,10 @@ int board_late_init(void)
>  	qcom_late_init();
>  
>  	qcom_show_boot_source();
> +
> +	/* Handle reboot-mode detection and fastboot entry */
> +	qcom_handle_reboot_mode();
> +
>  	/* Configure the dfu_string for capsule updates */
>  	qcom_configure_capsule_updates();
>  
> -- 
> 2.34.1
> 
> 


