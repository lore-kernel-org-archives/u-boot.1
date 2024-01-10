Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D97C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 20:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E5E878E9;
	Wed, 10 Jan 2024 21:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NsOygsSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6DA876F6; Wed, 10 Jan 2024 21:09:51 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937CE878DF
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 21:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e5508ecb9so18012545e9.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704917389; x=1705522189; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eSSCU82PqAN93Mv3ShwMaSbEGKd77XyunqWa2sVtd4I=;
 b=NsOygsSG839hHjUy+IJxxbj3eMz0mvbslSrmDhBFozjCScpNUVrRkBVx0pIXuXyB4h
 o3qDBDlh245qWC1TsJXFWCRj6CuWU1BRSog56vlC2kTD29N2DdQLsUHrQSYY79Sd/a+E
 zKblovEZW+4A5nJ/huEednUX2X+7a5LxJOXAC5xFuDFt9Px1wCU7+HObGvEpWbRBW3mm
 Dl881WFDH0fp5oh5KRM/qQKkLubjL2TTvDe4TG0kBOshFnrosGBvHskVMKHKloAozHZ1
 zQMsmcGuMZLoNgEGEWt1kKAR4PdahuSgh5zBu9be6MbNYntXdAGeVWs/BrB3FZvga/4E
 GhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704917389; x=1705522189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eSSCU82PqAN93Mv3ShwMaSbEGKd77XyunqWa2sVtd4I=;
 b=Yl33pV7ZbF04hARUYYqqbM2fv1QcA49JOZ9/P2nzmNuAutDqLZCCBdxlIGVZ/L/8uT
 EJgxZxkbTnw397Tq+FFgmbZlHqlxAE9QoBAkSnBqy3n2EcZSaubyJItJ05mITPTa5zIK
 y+nS+NOKjaqvIp/fM3FogkG6sUId0YM4yYe083X4JBo3mZtbjAvG0ULO6r7Sb7UZCrqM
 f8zee5iTO0Dt8uUH7htT8nYTrJnqH0wRpM/0zSK4L5DSC78vX2mGNEoJFQD/VRjPxH1q
 6izFhJZZ/UJ7j/YCELZN/0n9Ly+ctfPFwAXAeRNUgHswBwCedfz4OKGJxeuFvVTi4cws
 BhxQ==
X-Gm-Message-State: AOJu0Yz/vkDKy4qu/fLXa/KE1gin5fmwNIJrx9iGVtjUbBVNt2Gtb++b
 z8Ww412GQfF6UHctnQvz0b9Rl904BncYIw==
X-Google-Smtp-Source: AGHT+IG4u2iftSyMmBndB7LPXl8nOD8Ahs6WATAdg4x4UI862yh+mmIEGpZGaqiKnaAua1kq/iAQNA==
X-Received: by 2002:a05:600c:6a97:b0:40e:532d:b26 with SMTP id
 jl23-20020a05600c6a9700b0040e532d0b26mr952302wmb.1.1704917388889; 
 Wed, 10 Jan 2024 12:09:48 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 ek10-20020a05600c3eca00b0040d81ca11casm3195101wmb.28.2024.01.10.12.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 12:09:48 -0800 (PST)
Message-ID: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
Date: Wed, 10 Jan 2024 20:09:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot: add support for button commands
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240109115310.1917139-1-caleb.connolly@linaro.org>
 <6c46c19f28a1008550fe3c3249c034d4@manjaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <6c46c19f28a1008550fe3c3249c034d4@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 10/01/2024 18:08, Dragan Simic wrote:
> On 2024-01-09 12:51, Caleb Connolly wrote:
>> With the relatively new button API in U-Boot, it's now much easier to
>> model the common usecase of mapping arbitrary actions to different
>> buttons during boot - for example entering fastboot mode, setting some
>> additional kernel cmdline arguments, or booting with a custom recovery
>> ramdisk, to name a few.
>>
>> Historically, this functionality has been implemented in board code,
>> making it fixed for a given U-Boot binary and requiring the code be
>> duplicated and modified for every board.
>>
>> Implement a generic abstraction to run an arbitrary command during boot
>> when a specific button is pressed. The button -> command mapping is
>> configured via environment variables with the following format:
>>
>>   button_cmd_N_name=<button label>
>>   button_cmd_N=<command to run>
>>
>> Where N is the mapping number starting from 0. For example:
>>
>>   button_cmd_0_name=vol_down
>>   button_cmd_0=fastboot usb 0
>>
>> This will cause the device to enter fastboot mode if volume down is held
>> during boot.
> 
> This is simply awesome, but I see one possible issue -- the need to have
> proper environment variables defined for a particular board or device,
> to make the buttons work as expected.  Obviously, those environment
> variables can be absent or can become missing for numerous reasons.

Is CFG_EXTRA_ENV_SETTINGS not persistent enough?
> 
> I think that we should have an additional mechanism in place that
> defines the buttons and the associated commands even if no environment
> variables are found.  Like a set of fallback defaults for a particular
> board or device, built into the U-Boot image.  For example, Rockchip
> boards have those defaults pretty well defined.

A programmatic API for register button/cmd mapping from
board_late_init() (for example) sounds sensible to me.

Is this really an issue that invalidates the implementation proposed
here though? It feels much more like a nice-to-have addition that maybe
we could leave out for now?

It also has a MUCH wider scope imo - should board override env or vice
versa? What about triggering default AND custom actions for one button
press? What if a board wants to register a callback function instead of
running a command?) - these are questions I don't want to answer with
this patch.
> 
>> After we enter the cli loop the button commands are no longer valid,
>> this allows the buttons to additionally be used for navigating a boot
>> menu.
>>
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra30
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Changes since v1:
>>  * make get_button_cmd() static.
>>  * use #if IS_ENABLED(CONFIG_BUTTON_CMD) instead of #ifdef
>>    CONFIG_BUTTON_CMD.
>>  * Kconfig fixes
>> ---
>>  boot/Kconfig              | 15 +++++++
>>  common/Makefile           |  1 +
>>  common/button_cmd.c       | 83 +++++++++++++++++++++++++++++++++++++++
>>  common/main.c             |  3 ++
>>  doc/usage/environment.rst |  4 ++
>>  include/button.h          |  9 +++++
>>  6 files changed, 115 insertions(+)
>>  create mode 100644 common/button_cmd.c
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index fbc49c5bca47..882835731ea9 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -20,6 +20,21 @@ config TIMESTAMP
>>        loaded that does not, the message 'Wrong FIT format: no timestamp'
>>        is shown.
>>
>> +config BUTTON_CMD
>> +    bool "Support for running a command if a button is held during boot"
>> +    depends on CMDLINE
>> +    depends on BUTTON
>> +    help
>> +      For many embedded devices it's useful to enter a special
>> flashing mode
>> +      such as fastboot mode when a button is held during boot. This
>> option
>> +      allows arbitrary commands to be assigned to specific buttons.
>> These will
>> +      be run after "preboot" if the button is held. Configuration is
>> done via
>> +      the environment variables "button_cmd_N_name" and
>> "button_cmd_N" where n is
>> +      the button number (starting from 0). e.g:
>> +
>> +        "button_cmd_0_name=vol_down"
>> +        "button_cmd_0=fastboot usb 0"
>> +
>>  menuconfig FIT
>>      bool "Flattened Image Tree (FIT)"
>>      select HASH
>> diff --git a/common/Makefile b/common/Makefile
>> index cdeadf72026c..53105a6ce12a 100644
>> --- a/common/Makefile
>> +++ b/common/Makefile
>> @@ -10,6 +10,7 @@ obj-y += main.o
>>  obj-y += exports.o
>>  obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
>>  obj-$(CONFIG_AUTOBOOT) += autoboot.o
>> +obj-$(CONFIG_BUTTON_CMD) += button_cmd.o
>>
>>  # # boards
>>  obj-y += board_f.o
>> diff --git a/common/button_cmd.c b/common/button_cmd.c
>> new file mode 100644
>> index 000000000000..b6a8434d6f29
>> --- /dev/null
>> +++ b/common/button_cmd.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2023 Linaro Ltd.
>> + *   Author: Caleb Connolly <caleb.connolly@linaro.org>
>> + */
>> +
>> +#include <button.h>
>> +#include <command.h>
>> +#include <env.h>
>> +#include <log.h>
>> +#include <vsprintf.h>
>> +
>> +/* Some sane limit "just in case" */
>> +#define MAX_BTN_CMDS 32
>> +
>> +struct button_cmd {
>> +    bool pressed;
>> +    const char *btn_name;
>> +    const char *cmd;
>> +};
>> +
>> +/*
>> + * Button commands are set via environment variables, e.g.:
>> + * button_cmd_N_name=Volume Up
>> + * button_cmd_N=fastboot usb 0
>> + *
>> + * This function will retrieve the command for the given button N
>> + * and populate the cmd struct with the command string and pressed
>> + * state of the button.
>> + *
>> + * Returns 1 if a command was found, 0 otherwise.
>> + */
>> +static int get_button_cmd(int n, struct button_cmd *cmd)
>> +{
>> +    const char *cmd_str;
>> +    struct udevice *btn;
>> +    char buf[24];
>> +
>> +    snprintf(buf, sizeof(buf), "button_cmd_%d_name", n);
>> +    cmd->btn_name = env_get(buf);
>> +    if (!cmd->btn_name)
>> +        return 0;
>> +
>> +    button_get_by_label(cmd->btn_name, &btn);
>> +    if (!btn) {
>> +        log_err("No button labelled '%s'\n", cmd->btn_name);
>> +        return 0;
>> +    }
>> +
>> +    cmd->pressed = button_get_state(btn) == BUTTON_ON;
>> +    /* If the button isn't pressed then cmd->cmd will be unused so
>> don't waste
>> +     * cycles reading it
>> +     */
>> +    if (!cmd->pressed)
>> +        return 1;
>> +
>> +    snprintf(buf, sizeof(buf), "button_cmd_%d", n);
>> +    cmd_str = env_get(buf);
>> +    if (!cmd_str) {
>> +        log_err("No command set for button '%s'\n", cmd->btn_name);
>> +        return 0;
>> +    }
>> +
>> +    cmd->cmd = cmd_str;
>> +
>> +    return 1;
>> +}
>> +
>> +void process_button_cmds(void)
>> +{
>> +    struct button_cmd cmd = {0};
>> +    int i = 0;
>> +
>> +    while (get_button_cmd(i++, &cmd) && i < MAX_BTN_CMDS) {
>> +        if (!cmd.pressed)
>> +            continue;
>> +
>> +        log_info("BTN '%s'> %s\n", cmd.btn_name, cmd.cmd);
>> +        run_command(cmd.cmd, CMD_FLAG_ENV);
>> +        /* Don't run commands for multiple buttons */
>> +        return;
>> +    }
>> +}
>> diff --git a/common/main.c b/common/main.c
>> index 7c70de2e59a8..717e8b7e8bd2 100644
>> --- a/common/main.c
>> +++ b/common/main.c
>> @@ -8,6 +8,7 @@
>>
>>  #include <common.h>
>>  #include <autoboot.h>
>> +#include <button.h>
>>  #include <bootstage.h>
>>  #include <cli.h>
>>  #include <command.h>
>> @@ -61,6 +62,8 @@ void main_loop(void)
>>              efi_launch_capsules();
>>      }
>>
>> +    process_button_cmds();
>> +
>>      s = bootdelay_process();
>>      if (cli_process_fdt(&s))
>>          cli_secure_boot_cmd(s);
>> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
>> index c57b717caaf3..ce5a9627f025 100644
>> --- a/doc/usage/environment.rst
>> +++ b/doc/usage/environment.rst
>> @@ -190,6 +190,10 @@ bootm_size
>>  bootstopkeysha256, bootdelaykey, bootstopkey
>>      See README.autoboot
>>
>> +button_cmd_0, button_cmd_0_name ... button_cmd_N, button_cmd_N_name
>> +    Used to map commands to run when a button is held during boot.
>> +    See CONFIG_BUTTON_CMD.
>> +
>>  updatefile
>>      Location of the software update file on a TFTP server, used
>>      by the automatic software update feature. Please refer to
>> diff --git a/include/button.h b/include/button.h
>> index 207f4a0f4dbd..8d38e521324d 100644
>> --- a/include/button.h
>> +++ b/include/button.h
>> @@ -74,4 +74,13 @@ enum button_state_t button_get_state(struct udevice
>> *dev);
>>   */
>>  int button_get_code(struct udevice *dev);
>>
>> +#if IS_ENABLED(CONFIG_BUTTON_CMD)
>> +/* Process button command mappings specified in the environment,
>> + * running the commands for buttons which are pressed
>> + */
>> +void process_button_cmds(void);
>> +#else
>> +static inline void process_button_cmds(void) {}
>> +#endif /* CONFIG_BUTTON_CMD */
>> +
>>  #endif

-- 
// Caleb (they/them)
