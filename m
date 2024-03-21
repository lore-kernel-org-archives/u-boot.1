Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113AEC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 10:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DEE87EFA;
	Thu, 21 Mar 2024 11:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0bURX4bu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B738288087; Thu, 21 Mar 2024 11:08:08 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B10C87DC7
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso454098f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711015684; x=1711620484;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GveuQTod++AlDrILXj8YzLYWcHOGNiosnUtd54t9KrM=;
 b=0bURX4buWURUEn9flYwg61VUCo08vLVafaWhM+FuY4dLIjiaNHrl3kzw9dldradLs2
 phbYdY3QDW8+8/ZQSXxZ3RFVYnMNgzRbBRfzqGmsCVEILZ32liJ6uVM3OXj+xRkxCIQ0
 p7mM2bEyMEkOxbGdNSY9JflYsKWH4VCiJnAY140BHCmYsTb4bFf8XzmNgJwF0kLajlFe
 jZ+h3Ri24FGjBGWpGibCrB4H5mNrMlm5i0Dt8d7SIUkwVfNiaLQlsNcW9spl9mUx6Q6o
 K8m+uLNz1ZM3GWxuLpZi1LkjCGoTTEvVqi5D5bQ/CKzKZnQ6ThGj2fYC9fVmUQ+JdHC5
 0dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711015684; x=1711620484;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GveuQTod++AlDrILXj8YzLYWcHOGNiosnUtd54t9KrM=;
 b=XvV/GS81JhK95kiPYyIxJKv0TAkXuttO18YyU+n3+QeESneBGAvZ8RMK3oL6ULXePm
 sVD/6ohhyf54nVbaLdJoufD+VreJmEP9bQDsbSKJbLZo2UYi/FEimLXttaSpfJQwQ2Yy
 0BU3Qkvo3dJP8AlfZi77GRZDUueZrBg/QbfayDxWKmyTNNW+z0XIx1x7coixZQIjr5D2
 BCKg2i8dio0W59+M0Q+6X6AQV/jTLlDQ45cwaQCUPqTpdkE94m52m7vK95Bk+VUAEA+u
 N1td1vj4xF66YTI4yYJoE+8hPannU3zU3Oa2e+aCUHiKBA4T+PF6s2ch2nej4YNVdIoT
 i9Tw==
X-Gm-Message-State: AOJu0YwEirQqdWlijQjFR+E9jcELDcxUmo8m8d5+Z4WSCoP7yrinibXX
 aX0xEC5ihvLUcs43vkro340XG+q4iHVcTq+u5wxBL/Z0lpK7/dkpF7laXcE1VgM=
X-Google-Smtp-Source: AGHT+IGbor2CXS73lYdEzQRmDAlm0yun/ANSAoZ+31RVMS2mY2KC/kE9mr1MUz092UvZoTudVV6cDg==
X-Received: by 2002:adf:e6ca:0:b0:33e:7719:325d with SMTP id
 y10-20020adfe6ca000000b0033e7719325dmr1081912wrm.2.1711015684415; 
 Thu, 21 Mar 2024 03:08:04 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d42d2000000b0033e456f6e7csm17012247wrr.1.2024.03.21.03.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 03:08:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Alexander Gendin <agendin@matrox.com>, Caleb
 Connolly <caleb.connolly@linaro.org>, Ehsan Mohandesi
 <emohandesi@linux.microsoft.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mario Six <mario.six@gdsys.cc>, Sean
 Anderson <seanga2@gmail.com>, Sergei Antonov <saproj@gmail.com>, Simon
 Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] test: dm: add button_cmd test
In-Reply-To: <20240319132459.1997125-1-caleb.connolly@linaro.org>
References: <20240319132459.1997125-1-caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 11:08:03 +0100
Message-ID: <8734sjoq2k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Thank you for the patch.

On mar., mars 19, 2024 at 13:24, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Add a test for the button_cmd feature. This validates that commands can
> be mapped to two buttons, that the correct command runs based on which
> button is pressed, that only 1 command is run, and that no command runs
> if button_cmd_0_name is wrong or unset.
>
> Additionally, fix a potential uninitialised variable use caught by these
> tests, the btn variable in get_button_cmd() is assumed to be null if
> button_get_by_label() fails, but it's actually used uninitialised in
> that case.
>
> CONFIG_BUTTON is now enabled automatically and was removed when running
> save_defconfig.
>
> Fixes: e761035b6423 ("boot: add support for button commands")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Pipeline: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/19995
> Changes in v3:
> - Enable CONFIG_BUTTON_CMD for sandbox_flattree as well.
> - Link to v2: https://lore.kernel.org/u-boot/20240305145111.1391645-1-caleb.connolly@linaro.org
>
> Changes in v2:
> - Explicitly assign btn as NULL in get_button_cmd(). This fixes a
>   bug where if the undefined variable is non-zero the
>   button_get_by_label() check would fail and result in invalid memory
>   being accessed.
> - Enable CONFIG_BUTTON_CMD for sandbox64 as well as sandbox.
> - Link to v1: https://lore.kernel.org/u-boot/20240214170357.4091708-1-caleb.connolly@linaro.org/
> ---
>  common/button_cmd.c                |  2 +-
>  configs/sandbox64_defconfig        |  1 +
>  configs/sandbox_defconfig          |  1 +
>  configs/sandbox_flattree_defconfig |  1 +
>  test/dm/button.c                   | 96 ++++++++++++++++++++++++++++++
>  5 files changed, 100 insertions(+), 1 deletion(-)
>
> diff --git a/common/button_cmd.c b/common/button_cmd.c
> index b6a8434d6f29..8642c26735cc 100644
> --- a/common/button_cmd.c
> +++ b/common/button_cmd.c
> @@ -32,9 +32,9 @@ struct button_cmd {
>   */
>  static int get_button_cmd(int n, struct button_cmd *cmd)
>  {
>  	const char *cmd_str;
> -	struct udevice *btn;
> +	struct udevice *btn = NULL;
>  	char buf[24];
>  
>  	snprintf(buf, sizeof(buf), "button_cmd_%d_name", n);
>  	cmd->btn_name = env_get(buf);
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 3be9a00a8575..a62faf772482 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -10,8 +10,9 @@ CONFIG_PCI=y
>  CONFIG_SANDBOX64=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_SYS_MEMTEST_START=0x00100000
>  CONFIG_SYS_MEMTEST_END=0x00101000
> +CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 4ad10363e91b..93b52f2de5cf 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -9,8 +9,9 @@ CONFIG_SYS_LOAD_ADDR=0x0
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_SYS_MEMTEST_START=0x00100000
>  CONFIG_SYS_MEMTEST_END=0x00101000
> +CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_RSASSA_PSS=y
>  CONFIG_FIT_CIPHER=y
>  CONFIG_FIT_VERBOSE=y
> diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
> index 039018627527..6bf8874e722e 100644
> --- a/configs/sandbox_flattree_defconfig
> +++ b/configs/sandbox_flattree_defconfig
> @@ -7,8 +7,9 @@ CONFIG_SYS_LOAD_ADDR=0x0
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
>  CONFIG_SYS_MEMTEST_START=0x00100000
>  CONFIG_SYS_MEMTEST_END=0x00101000
> +CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
> diff --git a/test/dm/button.c b/test/dm/button.c
> index 3318668df25a..830d96fbef34 100644
> --- a/test/dm/button.c
> +++ b/test/dm/button.c
> @@ -130,4 +130,100 @@ static int dm_test_button_keys_adc(struct unit_test_state *uts)
>  
>  	return 0;
>  }
>  DM_TEST(dm_test_button_keys_adc, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
> +
> +/* Test of the button uclass using the button_gpio driver */
> +static int dm_test_button_cmd(struct unit_test_state *uts)
> +{
> +	struct udevice *btn1_dev, *btn2_dev, *gpio;
> +	const char *envstr;
> +
> +#define BTN1_GPIO 3
> +#define BTN2_GPIO 4
> +#define BTN1_PASS_VAR "test_button_cmds_0"
> +#define BTN2_PASS_VAR "test_button_cmds_1"
> +
> +	/*
> +	 * Buttons 1 and 2 are connected to gpio_a gpios 3 and 4 respectively.
> +	 * set the GPIOs to known values and then check that the appropriate
> +	 * commands are run when invoking process_button_cmds().
> +	 */
> +	ut_assertok(uclass_get_device(UCLASS_BUTTON, 1, &btn1_dev));
> +	ut_assertok(uclass_get_device(UCLASS_BUTTON, 2, &btn2_dev));
> +	ut_assertok(uclass_get_device(UCLASS_GPIO, 1, &gpio));
> +
> +	/*
> +	 * Map a command to button 1 and check that it process_button_cmds()
> +	 * runs it if called with button 1 pressed.
> +	 */
> +	ut_assertok(env_set("button_cmd_0_name", "button1"));
> +	ut_assertok(env_set("button_cmd_0", "env set " BTN1_PASS_VAR " PASS"));
> +	ut_assertok(sandbox_gpio_set_value(gpio, BTN1_GPIO, 1));
> +	/* Sanity check that the button is actually pressed */
> +	ut_asserteq(BUTTON_ON, button_get_state(btn1_dev));
> +	process_button_cmds();
> +	ut_assertnonnull((envstr = env_get(BTN1_PASS_VAR)));
> +	ut_asserteq_str(envstr, "PASS");
> +
> +	/* Clear result */
> +	ut_assertok(env_set(BTN1_PASS_VAR, NULL));
> +
> +	/*
> +	 * Map a command for button 2, press it, check that only the command
> +	 * for button 1 runs because it comes first and is also pressed.
> +	 */
> +	ut_assertok(env_set("button_cmd_1_name", "button2"));
> +	ut_assertok(env_set("button_cmd_1", "env set " BTN2_PASS_VAR " PASS"));
> +	ut_assertok(sandbox_gpio_set_value(gpio, BTN2_GPIO, 1));
> +	ut_asserteq(BUTTON_ON, button_get_state(btn2_dev));
> +	process_button_cmds();
> +	/* Check that button 1 triggered again */
> +	ut_assertnonnull((envstr = env_get(BTN1_PASS_VAR)));
> +	ut_asserteq_str(envstr, "PASS");
> +	/* And button 2 didn't */
> +	ut_assertnull(env_get(BTN2_PASS_VAR));
> +
> +	/* Clear result */
> +	ut_assertok(env_set(BTN1_PASS_VAR, NULL));
> +
> +	/*
> +	 * Release button 1 and check that the command for button 2 is run
> +	 */
> +	ut_assertok(sandbox_gpio_set_value(gpio, BTN1_GPIO, 0));
> +	process_button_cmds();
> +	ut_assertnull(env_get(BTN1_PASS_VAR));
> +	/* Check that the command for button 2 ran */
> +	ut_assertnonnull((envstr = env_get(BTN2_PASS_VAR)));
> +	ut_asserteq_str(envstr, "PASS");
> +
> +	/* Clear result */
> +	ut_assertok(env_set(BTN2_PASS_VAR, NULL));
> +
> +	/*
> +	 * Unset "button_cmd_0_name" and check that no commands run even
> +	 * with both buttons pressed.
> +	 */
> +	ut_assertok(env_set("button_cmd_0_name", NULL));
> +	/* Press button 1 (button 2 is already pressed )*/
> +	ut_assertok(sandbox_gpio_set_value(gpio, BTN1_GPIO, 1));
> +	ut_asserteq(BUTTON_ON, button_get_state(btn1_dev));
> +	process_button_cmds();
> +	ut_assertnull(env_get(BTN1_PASS_VAR));
> +	ut_assertnull(env_get(BTN2_PASS_VAR));
> +
> +	/*
> +	 * Check that no command is run if the button name is wrong.
> +	 */
> +	ut_assertok(env_set("button_cmd_0_name", "invalid_button"));
> +	process_button_cmds();
> +	ut_assertnull(env_get(BTN1_PASS_VAR));
> +	ut_assertnull(env_get(BTN2_PASS_VAR));
> +
> +#undef BTN1_PASS_VAR
> +#undef BTN2_PASS_VAR
> +#undef BTN1_GPIO
> +#undef BTN2_GPIO
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_button_cmd, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
> -- 
> 2.44.0
