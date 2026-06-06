Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB21CD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13DE838BB;
	Sat,  6 Jun 2026 14:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XN5SCuKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7E78466E; Sat,  6 Jun 2026 14:07:50 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD2A8063E
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 14:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so23148905e9.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780747667; x=1781352467; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KhMU0ev7Q67KArv+ldBOc7uT8Y9WYI3OM3uxZJbuvyQ=;
 b=XN5SCuKZm1eCztreN0J1nXtnW72YBzEiwcf6AVvWcOs0cKR4XDhGhULPC2HI4zsUZY
 L0g5CWUipITjVFhtELX4ofCOG5JnZ7V8KUA9wM/h0JDtj9UlslVOoKdctjmb6HZo2ujI
 78u59mbkCmQ+gfKnlArdbhlyzfILRGZvqD0pmihbMp1fuvCXPu0IGWFt0TbTV6bY+rtb
 8HdLXkuJoRu13DdAHEPTK3LzjWlu6I3uPcobxU/4tsRnKsak1c/BRgKlv3i6GXn8xO5o
 ilEmKbmRPIGT1/E/hMyBn/D6Y2Bk0nCxjFyKlCcQZa0QtBFYhDyd9ye7UtaB7igjxbt4
 XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780747667; x=1781352467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhMU0ev7Q67KArv+ldBOc7uT8Y9WYI3OM3uxZJbuvyQ=;
 b=kVIcKhDfthEX2EctZ2VhTvKlsHqf1GkH2t/0YpaJHZeMNer83bDJj74PhaWUiXroUp
 cC7+2wPxOkGfzAsnD1LpB+Xq3If9h0kUZkA32SRg12XmuDY+6iXeLK990YhYNiMIHCpE
 B02IB68lUP8fIQg84t0jfTPfWoop9A97Cql74sFDgb5ukbPPVT/jKR0DA2qHcGWEBl4W
 AuQa0Kp8tR0v56AYW6yB8CFH1/BKtNiFYbtiBuMo2SFHyVEY1dU8baALlbPtT9pgBc/v
 NQNTAI4fjAJ6yCUaqPyKHRKWMI7qp+68PJ3XKCfkRnw1FuCEtHIJ8psDZTdPtcPIxAKG
 BS9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fpdJM5RQW4lIpuBEUXTmVdM+PEEDh8rkfTsej21HuAyaGBB9b3jMMmcneVPyt/0tlIer7UG0=@lists.denx.de
X-Gm-Message-State: AOJu0YzTAhqFK0hkZXlOWIVNZyF9I8E1853UBRl8raVxcP5BK50XZ6bq
 GtSxvtOKjkIIdldhYZ3jBGkNISZSBBa9iRiE/5O+uBxTy4dIClDdNmKSV9xai2ZdpEs=
X-Gm-Gg: Acq92OEqrpJYAv+XZ2isojrG9wm17IGlHcdITBiXfowc4UhFwZtXFOs21HTVMxp0ThA
 J7HcGD0Y/BQ/n97pON2Ny58MgjGKO4NsqtHHmPjtERZMFyZ5wDAjvBKNItmXTaN2MLSyN8D1i+j
 S6Fs+wwwi7Azv1m9BbJhNoSQTXCY31AhArl8umk6rVdcXzXgFy6NH0/sfajm3hW00cfQue7nK7c
 Vz6MUPlB9Jm2mFzsaCSvvFt/azSY4RFgwNqTZyqLDLPN+y6TizRdv+zkGnq1KFegiuP98dtWp0T
 NgUhz2Dwqf7infotmEltyqsKKqKzYTYlXD0OEp/Udi/5FQBcjXNEutNV3HASb6cI9ZBSzEkMtop
 wqpgR0fw0AIMx0eqxH/NTQSh1fL8/bcid7/2sQYprm767OP58xrKFvsDCSvWn8yAkEOEumuxOBJ
 hO1hQ9P2DV6khGOg7B3++NDMs5wvp2Ra47Y8oV4ccrUFbs1oNccWryVShy6+jMh43UhHPKsyIRS
 P2paHjbfYNSG+w+1Q5k
X-Received: by 2002:a05:600c:3588:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-490c2cf5433mr111494785e9.11.1780747666991; 
 Sat, 06 Jun 2026 05:07:46 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:fc76:d61e:2fec:91ec?
 ([2a0e:c5c1:0:100:fc76:d61e:2fec:91ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39e024sm302245115e9.4.2026.06.06.05.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2026 05:07:45 -0700 (PDT)
Message-ID: <fb02b123-df74-4911-bc52-144c901e713d@linaro.org>
Date: Sat, 6 Jun 2026 14:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] mach-snapdragon: Integrate reboot-mode handling
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen
 <justin@tidylabs.net>, Jamie Gibbons <jamie.gibbons@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-8-170c9cbe5099@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260606-pm8916-pon-v1-8-170c9cbe5099@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Sam,

FYI this is superseded by 
https://lore.kernel.org/u-boot/20260521180549.282377-4-aswin.murugan@oss.qualcomm.com/

When you resend you can just indicate that your series is based on top 
of that one so it can get picked.

Kind regards,

On 6/6/26 10:47, Sam Day via B4 Relay wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
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
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   arch/arm/mach-snapdragon/board.c | 56 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..c37195def57 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -9,6 +9,15 @@
>   #define LOG_CATEGORY LOGC_BOARD
>   #define pr_fmt(fmt) "QCOM: " fmt
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
>   #include <asm/armv8/mmu.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> @@ -16,22 +25,14 @@
>   #include <asm/system.h>
>   #include <dm/device.h>
>   #include <dm/pinctrl.h>
> -#include <dm/uclass-internal.h>
>   #include <dm/read.h>
> -#include <power/regulator.h>
> -#include <env.h>
> -#include <fdt_support.h>
> -#include <init.h>
> +#include <dm/uclass-internal.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/bug.h>
>   #include <linux/psci.h>
>   #include <linux/sizes.h>
> -#include <lmb.h>
> -#include <malloc.h>
> -#include <fdt_support.h>
> -#include <usb.h>
> -#include <sort.h>
> -#include <time.h>
> +#include <power/regulator.h>
> +#include <reboot-mode/reboot-mode.h>
>   
>   #include "qcom-priv.h"
>   
> @@ -506,6 +507,33 @@ void qcom_show_boot_source(void)
>   	env_set("boot_source", name);
>   }
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
> +		printf("Entering fastboot mode due to reboot reason...\n");
> +		run_command("run fastboot", 0);
> +	}
> +}
> +
>   void __weak qcom_late_init(void)
>   {
>   }
> @@ -575,6 +603,12 @@ int board_late_init(void)
>   	qcom_late_init();
>   
>   	qcom_show_boot_source();
> +
> +	/* Handle reboot-mode detection and fastboot entry */
> +#if IS_ENABLED(CONFIG_DM_REBOOT_MODE)
> +	qcom_handle_reboot_mode();
> +#endif
> +
>   	/* Configure the dfu_string for capsule updates */
>   	qcom_configure_capsule_updates();
>   
> 

