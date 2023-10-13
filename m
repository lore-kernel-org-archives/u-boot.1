Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BD5CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 17:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E065486BDF;
	Fri, 13 Oct 2023 19:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D5TlFYI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EC686E04; Fri, 13 Oct 2023 19:23:41 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847618653E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 19:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-504427aae4fso4123036e87.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217815; x=1697822615; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k4zmFXofAG0g6UNt7pgQd2YpCES3ZjAM7Qi2Z0ng2Dc=;
 b=D5TlFYI69Mr2kc1GNrudmgUZy8q2+qLZqM6Y+E/TtYimw2215P+qTmxryd9NPKG1hU
 rKzPdsnaID/qVCk6ZB5YKOUnkl32Bb7VqsYvTAaZTFFQF+hK2MiGdV1EiA2OM00LmTFl
 FjBIqoza48HlR5WQd+afwO+vPoqIbraoSBS6tXHQ5nHjkJmfJa+JvVjLfuxC7vTvRW3Q
 ql+sP6Y0vMJerYIBMv5h/81cLYCOEhjE/3xO+0URz5ZbmzFvkp+ZxqbRGvF8uUaq/bEe
 RXKUo81rqfb6gHiek70zRP1IHlVY67mTCSAF4tp4cr3ajismDG0vFa3x8cEfBXMmlpwC
 ZPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217815; x=1697822615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4zmFXofAG0g6UNt7pgQd2YpCES3ZjAM7Qi2Z0ng2Dc=;
 b=ZOoZPNcHZKU3W5CnitZsdQOgKMJOwoKA8gi7tongM+36BF1nLjTh26k6uT2qwmUc3w
 elC5igEaocpmZhKoMR3/qa1TLtFf5syilimPoNPzpvgHZUq+6NP6IKNZLL9X4t33HoK1
 7sDKr9kyzQhVtW8AY3YB4uCapCUgQtoIyKvTLKNTkcGbB6DI9JwqSxyDfuRPKbDMG33R
 EcX1NBBFLCIrhMQg/d5COFEWp3tKi96NmMOPa4QeTgOocRULGfIgrTw+0xSnE0K2D6x5
 c/xyjHXVzewCeZRZNoxxfMxIwZHxVfQdDSYITlu9AQO1KmuV6uzO7tPUfqBovRWI/sRY
 K7Sw==
X-Gm-Message-State: AOJu0YwEvjpDeDgSQ4HZ9xf42/GX1rzWenJUdOGqrPdSqV4pCGCzqche
 PejjZcLpmWCGbr5+RLYwufFZq5+H7an7H/5FMC6Zhg==
X-Google-Smtp-Source: AGHT+IFHgrV+h3upx1Kt8VOqOLgswAI1MgzQsFBL2HGxD/uV1b1wILVc3HY0ZmzRQUFrI0FK+EtwdCbzQoYVqt5LWdA=
X-Received: by 2002:ac2:4ecb:0:b0:4fe:b97:e361 with SMTP id
 p11-20020ac24ecb000000b004fe0b97e361mr574797lfr.18.1697217814635; Fri, 13 Oct
 2023 10:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231012144551.679551-1-eajames@linux.ibm.com>
 <20231012144551.679551-6-eajames@linux.ibm.com>
In-Reply-To: <20231012144551.679551-6-eajames@linux.ibm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Oct 2023 19:22:58 +0200
Message-ID: <CAC_iWjKB-GkvDELoo083gpuPd32qZJDwHvPzepzHsF7hPioxMQ@mail.gmail.com>
Subject: Re: [PATCH v12 5/8] test: Add sandbox TPM boot measurement
To: Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
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

Hi Eddie,

This doesn't apply on -master, can you please rebase?

Thanks
/Ilias

On Thu, 12 Oct 2023 at 16:49, Eddie James <eajames@linux.ibm.com> wrote:
>
> Use the sandbox TPM driver to measure some boot images in a unit
> test case.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v5:
>  - Only compile in the measurement u-boot command when
>    CONFIG_MEASURED_BOOT is enabled.
>
>  arch/sandbox/dts/sandbox.dtsi | 13 +++++++
>  arch/sandbox/dts/test.dts     | 13 +++++++
>  configs/sandbox_defconfig     |  1 +
>  include/test/suites.h         |  1 +
>  test/boot/Makefile            |  1 +
>  test/boot/measurement.c       | 66 +++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c                 |  4 +++
>  7 files changed, 99 insertions(+)
>  create mode 100644 test/boot/measurement.c
>
> diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
> index ff7e5584c5..241f397ba6 100644
> --- a/arch/sandbox/dts/sandbox.dtsi
> +++ b/arch/sandbox/dts/sandbox.dtsi
> @@ -4,11 +4,23 @@
>   * and sandbox64 builds.
>   */
>
> +#include <config.h>
>  #include <dt-bindings/input/input.h>
>
>  #define USB_CLASS_HUB                  9
>
>  / {
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               event_log: tcg_event_log {
> +                       no-map;
> +                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
> +               };
> +       };
> +
>         binman {
>         };
>
> @@ -342,6 +354,7 @@
>
>         tpm2 {
>                 compatible = "sandbox,tpm2";
> +               memory-region = <&event_log>;
>         };
>
>         triangle {
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 9a863ea732..bb2ddd9bf2 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -9,6 +9,7 @@
>
>  /dts-v1/;
>
> +#include <config.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/gpio/sandbox-gpio.h>
>  #include <dt-bindings/input/input.h>
> @@ -68,6 +69,17 @@
>                 osd0 = "/osd";
>         };
>
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               event_log: tcg_event_log {
> +                       no-map;
> +                       reg = <(CFG_SYS_SDRAM_SIZE - 0x2000) 0x2000>;
> +               };
> +       };
> +
>         binman: binman {
>         };
>
> @@ -1422,6 +1434,7 @@
>
>         tpm2 {
>                 compatible = "sandbox,tpm2";
> +               memory-region = <&event_log>;
>         };
>
>         tpm {
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index d667cb9ae4..12c387a77e 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -349,3 +349,4 @@ CONFIG_UNIT_TEST=y
>  CONFIG_UT_TIME=y
>  CONFIG_UT_DM=y
>  CONFIG_ARM_FFA_TRANSPORT=y
> +CONFIG_MEASURED_BOOT=y
> diff --git a/include/test/suites.h b/include/test/suites.h
> index 1c7dc65966..48ed549c13 100644
> --- a/include/test/suites.h
> +++ b/include/test/suites.h
> @@ -45,6 +45,7 @@ int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
> +int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>  int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>  int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index 52947580ae..068522cb9e 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -4,6 +4,7 @@
>
>  obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
>  obj-$(CONFIG_FIT) += image.o
> +obj-$(CONFIG_MEASURED_BOOT) += measurement.o
>
>  obj-$(CONFIG_EXPO) += expo.o
>  obj-$(CONFIG_CEDIT) += cedit.o
> diff --git a/test/boot/measurement.c b/test/boot/measurement.c
> new file mode 100644
> index 0000000000..9db2ed324c
> --- /dev/null
> +++ b/test/boot/measurement.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test for measured boot functions
> + *
> + * Copyright 2023 IBM Corp.
> + * Written by Eddie James <eajames@linux.ibm.com>
> + */
> +
> +#include <common.h>
> +#include <bootm.h>
> +#include <malloc.h>
> +#include <test/suites.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <asm/io.h>
> +
> +#define MEASUREMENT_TEST(_name, _flags)        \
> +       UNIT_TEST(_name, _flags, measurement_test)
> +
> +static int measure(struct unit_test_state *uts)
> +{
> +       struct bootm_headers images;
> +       const size_t size = 1024;
> +       u8 *kernel;
> +       u8 *initrd;
> +       size_t i;
> +
> +       kernel = malloc(size);
> +       initrd = malloc(size);
> +
> +       images.os.image_start = map_to_sysmem(kernel);
> +       images.os.image_len = size;
> +
> +       images.rd_start = map_to_sysmem(initrd);
> +       images.rd_end = images.rd_start + size;
> +
> +       images.ft_addr = malloc(size);
> +       images.ft_len = size;
> +
> +       env_set("bootargs", "measurement testing");
> +
> +       for (i = 0; i < size; ++i) {
> +               kernel[i] = 0xf0 | (i & 0xf);
> +               initrd[i] = (i & 0xf0) | 0xf;
> +               images.ft_addr[i] = i & 0xff;
> +       }
> +
> +       ut_assertok(bootm_measure(&images));
> +
> +       free(images.ft_addr);
> +       free(initrd);
> +       free(kernel);
> +
> +       return 0;
> +}
> +MEASUREMENT_TEST(measure, 0);
> +
> +int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc,
> +                     char *const argv[])
> +{
> +       struct unit_test *tests = UNIT_TEST_SUITE_START(measurement_test);
> +       const int n_ents = UNIT_TEST_SUITE_COUNT(measurement_test);
> +
> +       return cmd_ut_category("measurement", "measurement_test_", tests,
> +                              n_ents, argc, argv);
> +}
> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> index 0f56409e80..e87adcb71e 100644
> --- a/test/cmd_ut.c
> +++ b/test/cmd_ut.c
> @@ -99,6 +99,10 @@ static struct cmd_tbl cmd_ut_sub[] = {
>  #if CONFIG_IS_ENABLED(UT_UNICODE) && !defined(API_BUILD)
>         U_BOOT_CMD_MKENT(unicode, CONFIG_SYS_MAXARGS, 1, do_ut_unicode, "", ""),
>  #endif
> +#ifdef CONFIG_MEASURED_BOOT
> +       U_BOOT_CMD_MKENT(measurement, CONFIG_SYS_MAXARGS, 1, do_ut_measurement,
> +                        "", ""),
> +#endif
>  #ifdef CONFIG_SANDBOX
>         U_BOOT_CMD_MKENT(compression, CONFIG_SYS_MAXARGS, 1, do_ut_compression,
>                          "", ""),
> --
> 2.39.3
>
