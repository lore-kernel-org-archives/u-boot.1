Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7E0D1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B827884150;
	Thu,  8 Jan 2026 18:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGDk6bUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E1A84150; Thu,  8 Jan 2026 18:50:31 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29288415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-598f81d090cso3490071e87.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767894628; x=1768499428; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aqg0d+JfumtHkZHrXg5Ohf9aH7Z2f+6p5Y622ih5neQ=;
 b=RGDk6bUqNQNoVfDazU3F7UL5+dEHBiMjGyd9mhYl9gWvJGmD79MjPcoxARgEPvXjNl
 o98StgFA5cl3i0iHvNvvwK1wc83La4A+VkhQF3I4tF5YjPcYtES9LfVe4tXvdPpUJrAh
 ZkwgjxKH3cQCwLP47jOoB2HVnaHwvjLa6iWGNbcMMHO3kOuDrgiZwsHHJWjnKOV361Vk
 b3GzpMMSU60BYox89HM8SAkkuHIwvfS2ORtSSAU4qNtxSMSHKrh7l8iKxXISSVogHxhE
 bQC9G8px7tIIyVWogdpItGjyqgVJhRLJ6Y5lFg7VoZ47lMqeERp9FY61vdOt7pX48a/p
 0c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894628; x=1768499428;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aqg0d+JfumtHkZHrXg5Ohf9aH7Z2f+6p5Y622ih5neQ=;
 b=cLowZbccYLBQwLsOb1LCiYxo4qrdVS7307dF85nfjYdSUeArYTxQSdq9lPnVTVMY0R
 pLU6+gVOA3iB7txkABlMyofw/xn+N3HFO3qWupOktvSpDEjXJZBsx2X/B8UsL/MjJr4m
 jAn8OLYihQeFCgJPYHnXbdvEAj639uTtcA3BmpEHqCNLNjWHZL/iLHMWQ942dg2t+5fG
 ZC5sK7pBWi9H3JUBjMhMcr6rjeSIIR0hAHpksw8efwUX1I2XSJGyVkwnET6nDfg+RLv+
 vOBDQXeM4PYbD55otJzl31RQUpXkkoFcr8Rc22dmt2uWo6TdLNr7S3KWLkH/xMUCGHYk
 xphQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViXGzdg/evRGs3d4yJVWfENOktFPGWTaitJTkJOA0ZH2I3WpQwWlwe6Nxduy09m++pzeOehgo=@lists.denx.de
X-Gm-Message-State: AOJu0YwbjNkpP6beEVADmbJAQF7cvsphs1uNd0jZv4uAgMbqOJXYGoUq
 FACDu0jeli3zdg54682MCo5oAE1jjcIqiq8SYqk8TF0km7/0gsWDCZCuCjaKBOyDEjk=
X-Gm-Gg: AY/fxX5TVUErtQuUtpNw/9m2rS13htgMopVvG9x8LH2wd82n2AWgV+UOJ9hxjGkpnKT
 acw9XREm7K3zv0NLpbvnSRUBxifEF+ozyceyTMm9arunbA3pSHd+VUgaT1JHVpu9dF7GnTJJ7xY
 xeGjgDoOflraNxBx+TXwlgoBCm2Uu6FRoAo60fdYx/bI4PPCQWOCkGJEYbHqR4yMvsPD2G35HX4
 +MJsl9VqhQXS8Tc8TS8+CvTJQfQHTqvxyxxRvg5rEO5IBvHyUkluyI1OIDOE5oVv8sxLlpiZMBn
 DKvuABQFBNIndjyt5N5RSLpOeeKzJ/I4yVz9Lk4fCyW/C7MfnvxtbpMNcU7uwf9oG65Vw6AmU0q
 2w8Pab2c+W5+6zHrlKlJqivHYfQ+ZsMBW5Qyzr+ny0XxlT441/UcvinDYcGT/gbO6jpbWXp6EmD
 ISrdXkA8AWqJglY+lrnXalGahFsXht+/fvSLxmCKcSWTxNkmHvGD0=
X-Google-Smtp-Source: AGHT+IEbffuvTWTAQ+dAfS9/+ulg5QKJonFQCjHcNhV7phn/dcU2lxw8mZ5on+jU3f9BpweKsHkfzg==
X-Received: by 2002:a05:6512:3d08:b0:594:74f9:3b3 with SMTP id
 2adb3069b0e04-59b6f047e24mr2293430e87.29.1767894627868; 
 Thu, 08 Jan 2026 09:50:27 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b6a97e94csm1911825e87.91.2026.01.08.09.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 09:50:27 -0800 (PST)
Message-ID: <7c1a8774-e16f-4c35-9493-5e11c073ba7d@linaro.org>
Date: Thu, 8 Jan 2026 18:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mach-snapdragon:: Add support for fastboot reboot
 reason detection
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, me@samcday.com,
 sughosh.ganu@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 08/01/2026 07:55, Aswin Murugan wrote:
> Add functionality to detect and handle reboot-to-bootloader requests
> by reading PMIC PON (Power On) registers. When the device is rebooted
> with the bootloader flag set, U-Boot will automatically enter fastboot
> mode.
> 
> This implementation supports multiple PMIC generations:
> - Gen 4 PMICs: Uses PON_SOFT_RB_SPARE register (0x88F)
> - Newer PMICs: Uses SDAM-based PON_REBOOT_REASON register (0x7148)

Could you give a few examples of gen4/newer PMICs and/or release years
so we can get a better idea of which codepaths different SoCs will use?
Having a code comment for this would also be great for anyone having to
debug this in the future.>
> The PMIC model is automatically detected via revision ID registers to
> determine the correct register addresses. After detecting a fastboot
> reboot reason, the register is cleared and fastboot mode is entered
> via the "run fastboot" command.

This is a great feature and useful to have, I'm glad to see it being
implemented.

As I understand it this is the approach a bunch of other architectures
take, but I'm not really happy with having all this driver code in
mach-snapdragon or with hardcoding so much.

Can you move the driver code to the existing pmic_qcom.c and then have
it set an environment variable based on the boot mode?

At this point I think it's ok to then just run commands based on the
value of that variable just before qcom_configure_capsule_updates().
There's an argument to be made for an extra level of indirection and
having this be fully generic (so other platforms can make use of it) but
our usecase here doesn't really justify it.

Kind regards,
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 146 +++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..02b84297e05 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -19,6 +19,7 @@
>  #include <dm/uclass-internal.h>
>  #include <dm/read.h>
>  #include <power/regulator.h>
> +#include <power/pmic.h>
>  #include <env.h>
>  #include <fdt_support.h>
>  #include <init.h>
> @@ -32,9 +33,32 @@
>  #include <usb.h>
>  #include <sort.h>
>  #include <time.h>
> +#include <command.h>
>  
>  #include "qcom-priv.h"
>  
> +/* Reboot mode definitions */
> +#define QCOM_REBOOT_MODE_FASTBOOT	0x2
> +#define QCOM_REBOOT_MODE_MASK		0xFE
> +
> +/* PON (Power On) register addresses - Gen 4 PMICs */
> +#define QCOM_PON_BASE_ADDR		0x800
> +#define QCOM_PON_PERPH_SUBTYPE		(QCOM_PON_BASE_ADDR + 0x5)
> +#define QCOM_PON_SOFT_RB_SPARE		(QCOM_PON_BASE_ADDR + 0x8F)
> +
> +/* PON register addresses - Newer PMICs (SDAM-based) */
> +#define QCOM_PON_REBOOT_REASON_SDAM	0x7148
> +
> +/* PMIC Revision ID registers */
> +#define QCOM_PMIC_REVID_BASE		0x0100
> +#define QCOM_PMIC_METAL_REV		(QCOM_PMIC_REVID_BASE + 0x02)
> +
> +/* PMIC identification values */
> +#define QCOM_PMIC_TYPE_QC		0x51
> +#define QCOM_PMIC_SUBTYPE_GEN4		0x4
> +#define QCOM_PMIC_MODEL_PM855		30
> +#define QCOM_PMIC_MODEL_INVALID		0x00
> +
>  DECLARE_GLOBAL_DATA_PTR;
>  
>  enum qcom_boot_source qcom_boot_source __section(".data") = 0;
> @@ -489,6 +513,125 @@ static void configure_env(void)
>  	qcom_set_serialno();
>  }
>  
> +/**
> + * detect_pmic_model() - Detect PMIC model from revision ID registers
> + * @dev: PMIC device
> + *
> + * Reads the PMIC revision ID registers to identify the PMIC model.
> + * This is used to determine which register addresses to use for
> + * reading the reboot reason.
> + *
> + * Return: PMIC model number or QCOM_PMIC_MODEL_INVALID on error
> + */
> +static int detect_pmic_model(struct udevice *dev)
> +{
> +	u8 rev_id[4] = {0};
> +	int ret, i;
> +	u8 pmic_model;
> +
> +	/* Read 4 bytes from PMIC REVID registers */
> +	for (i = 0; i < 4; i++) {
> +		ret = pmic_reg_read(dev, QCOM_PMIC_METAL_REV + i);
> +		if (ret < 0) {
> +			log_debug("Failed to read PMIC REVID reg 0x%X: %d\n",
> +				  QCOM_PMIC_METAL_REV + i, ret);
> +			return QCOM_PMIC_MODEL_INVALID;
> +		}
> +		rev_id[i] = (u8)ret;
> +	}
> +
> +	/* Verify this is a Qualcomm PMIC device */
> +	if (rev_id[2] != QCOM_PMIC_TYPE_QC) {
> +		log_debug("Not a Qualcomm PMIC (type=0x%02X)\n",
> +			  rev_id[2]);
> +		return QCOM_PMIC_MODEL_INVALID;
> +	}
> +
> +	pmic_model = rev_id[3];
> +	log_debug("PMIC Model: 0x%02X (Metal=0x%02X, Layer=0x%02X)\n",
> +		  pmic_model, rev_id[0], rev_id[1]);
> +
> +	return pmic_model;
> +}
> +
> +/**
> + * check_fastboot_mode() - Check if device should enter fastboot mode
> + *
> + * Reads the PMIC PON (Power On) register to check if the reboot reason
> + * indicates that fastboot mode should be entered. The register address
> + * varies depending on the PMIC generation.
> + *
> + * For Gen 4 PMICs: Uses PON_SOFT_RB_SPARE register
> + * For newer PMICs: Uses SDAM-based PON_REBOOT_REASON register
> + *
> + * If fastboot mode is detected, clears the reboot reason and enters
> + * fastboot mode via the "run fastboot" command.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int check_fastboot_mode(void)
> +{
> +	struct udevice *dev;
> +	int ret, reboot_reason, reg_val;
> +	u32 pon_reset_addr;
> +	u8 peripheral_subtype;
> +	int pmic_model;
> +
> +	if (!IS_ENABLED(CONFIG_DM_PMIC))
> +		return 0;
> +
> +	ret = pmic_get("pmic@0", &dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Detect PMIC model for address resolution */
> +	pmic_model = detect_pmic_model(dev);
> +	if (pmic_model == QCOM_PMIC_MODEL_INVALID)
> +		return -1;
> +
> +	peripheral_subtype = pmic_reg_read(dev, QCOM_PON_PERPH_SUBTYPE);
> +
> +	/* Select register address based on PMIC generation */
> +	if (peripheral_subtype == QCOM_PMIC_SUBTYPE_GEN4)
> +		pon_reset_addr = QCOM_PON_SOFT_RB_SPARE;
> +	else
> +		pon_reset_addr = QCOM_PON_REBOOT_REASON_SDAM;
> +
> +	log_debug("PON reg: 0x%X (subtype=0x%X, model=0x%X)\n",
> +		  pon_reset_addr, peripheral_subtype, pmic_model);
> +
> +	/* Read reboot reason */
> +	reg_val = pmic_reg_read(dev, pon_reset_addr);
> +	if (reg_val < 0) {
> +		log_debug("Failed to read reboot reason: %d\n", reg_val);
> +		return reg_val;
> +	}
> +
> +	reboot_reason = (reg_val & QCOM_REBOOT_MODE_MASK) >> 1;
> +	log_debug("Reboot reason: 0x%02X (raw=0x%02X)\n",
> +		  reboot_reason, reg_val);
> +
> +	if (reboot_reason == QCOM_REBOOT_MODE_FASTBOOT) {
> +		log_info("Fastboot mode detected, entering fastboot...\n");
> +
> +		/* Clear reboot reason */
> +		reg_val &= (~QCOM_REBOOT_MODE_MASK);
> +
> +		if (pmic_model == QCOM_PMIC_MODEL_PM855)
> +			pon_reset_addr = QCOM_PON_SOFT_RB_SPARE;
> +
> +		ret = pmic_reg_write(dev, pon_reset_addr, reg_val);
> +		if (ret != 0)
> +			log_warning("Failed to clear reboot reason (%d)\n",
> +				    ret);
> +
> +		/* Enter fastboot mode */
> +		ret = run_command("run fastboot", 0);
> +	}
> +
> +	return ret;
> +}
> +
>  void qcom_show_boot_source(void)
>  {
>  	const char *name = "UNKNOWN";
> @@ -573,6 +716,9 @@ int board_late_init(void)
>  	/* Configure the dfu_string for capsule updates */
>  	qcom_configure_capsule_updates();
>  
> +	/* Check reboot reason for fastboot */
> +	check_fastboot_mode();
> +
>  	return 0;
>  }
>  

-- 
// Casey (she/her)

