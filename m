Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB25BC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 17:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165BF87CFC;
	Wed, 14 Feb 2024 18:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="niRoNMaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E675587D58; Wed, 14 Feb 2024 18:04:14 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D407C87CEC
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 18:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so25493071fa.1
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707930243; x=1708535043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yhpMDsIC09JdO7QpMYChoW4F4CcLj2AGrV/8yzoMvMg=;
 b=niRoNMaQbYs0O+1jH7ruSkagmWR3+m5yW4fQvBDQ4g9tn8U1jDglRy3nea8fso3NuV
 M+/jYF5ZAxZ8U7+5z/RFPlooPi1qlowInmSgoqFjLU8RGI4mMyeBKw4r3PHaF3eZB4X6
 xOObCU/tM41Zj1AgFOwDMrm4Mw11P4v8YS7aabvwRSOSx0RxmLDbIg7WbdBT17WixDP+
 M1FukVQaH3e3f2NGhghlw3lJ23y3FLyX+b7GfpGWOICdzzkGgsaoczQ5yi5vVHtNaSWi
 SABrYSAaW5i+5nKPkMPUHMnUyH/iqJ1NnNE0n3ORDRYF81Gysc3S4D7+POaklwvV4c2L
 SitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707930243; x=1708535043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yhpMDsIC09JdO7QpMYChoW4F4CcLj2AGrV/8yzoMvMg=;
 b=g3tRej0LzzA5RBEawRO3ur5CgZzK7GvdZTsybNt4JCDG/uxYXUM8yfzJL1FyOPZp4w
 EA8UyMdYsSjbs2/49P1fFtK4GfsT4f/1NYaBkrVPwVWDEtMbgApvz1OsJqMPRmPstEnj
 k62yhYd9immTFKjlp3B94f61+YV6ljFCra4CpwLe+sKww9Tx1uZBUoYo31f12k6/GAyi
 gjeDJ9zAR7SWHO8o3ksB22utSNyMa1yARgFub0f9rJKrnPe/ra8FdiTKQlncOQfbY90Y
 4IsrA/XtlzsJQWIYmjWKPk5U3vFYXMEiNdP5ywRoSUEzzbuh0E4Xvv79AAt+LtILduay
 mAPQ==
X-Gm-Message-State: AOJu0YzFXXXUWmjKbUZSh3JUNWkODEC9K5xcN2SWRFFvKtc9bfhOrDin
 WEevSAwcjxvEXWLzuzmMNBye+lFJQE+sMo0gIH76UrwEaObbMxxgz/JyvAj9CX8=
X-Google-Smtp-Source: AGHT+IH0fH/PfwEkU1s+fyRBEoNfaqw8YGJIhzNYANQ0omC3nU/pgQz1zdc6A1q2Vc9Ls5aozAqDJw==
X-Received: by 2002:a2e:7d0f:0:b0:2d0:9fb2:2c79 with SMTP id
 y15-20020a2e7d0f000000b002d09fb22c79mr2704868ljc.3.1707930243027; 
 Wed, 14 Feb 2024 09:04:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtUiNBOy4obkMIYPMjD1wHa8unM3vfCfiD0SIbRjckxZ+DX6JSjyPM2K9aoCn5wEOpnLojv/WXzZ/+oJyPb141B2MN40d8a/xmsiVaRO6/fnZ5FJ8BSHD9KDhQ
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 ay31-20020a05600c1e1f00b00410232ffb2csm2565063wmb.25.2024.02.14.09.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 09:04:02 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] test: dm: add button_cmd test
Date: Wed, 14 Feb 2024 17:03:46 +0000
Message-ID: <20240214170357.4091708-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
MIME-Version: 1.0
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

Add a test for the button_cmd feature. This validates that commands can
be mapped to two buttons, that the correct command runs based on which
button is pressed, that only 1 command is run, and that no command runs
if button_cmd_0_name is wrong or unset.

CONFIG_BUTTON is now enabled automatically and was removed when running
save_defconfig.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/sandbox_defconfig |  2 +-
 test/dm/button.c          | 96 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a8df5e635b26..93b52f2de5cf 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -10,6 +10,7 @@ CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00100000
 CONFIG_SYS_MEMTEST_END=0x00101000
+CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
@@ -166,7 +167,6 @@ CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_RTC=y
 CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
 CONFIG_DM_BOOTCOUNT_SYSCON=y
-CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
diff --git a/test/dm/button.c b/test/dm/button.c
index 3318668df25a..830d96fbef34 100644
--- a/test/dm/button.c
+++ b/test/dm/button.c
@@ -131,3 +131,99 @@ static int dm_test_button_keys_adc(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_button_keys_adc, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
+/* Test of the button uclass using the button_gpio driver */
+static int dm_test_button_cmd(struct unit_test_state *uts)
+{
+	struct udevice *btn1_dev, *btn2_dev, *gpio;
+	const char *envstr;
+
+#define BTN1_GPIO 3
+#define BTN2_GPIO 4
+#define BTN1_PASS_VAR "test_button_cmds_0"
+#define BTN2_PASS_VAR "test_button_cmds_1"
+
+	/*
+	 * Buttons 1 and 2 are connected to gpio_a gpios 3 and 4 respectively.
+	 * set the GPIOs to known values and then check that the appropriate
+	 * commands are run when invoking process_button_cmds().
+	 */
+	ut_assertok(uclass_get_device(UCLASS_BUTTON, 1, &btn1_dev));
+	ut_assertok(uclass_get_device(UCLASS_BUTTON, 2, &btn2_dev));
+	ut_assertok(uclass_get_device(UCLASS_GPIO, 1, &gpio));
+
+	/*
+	 * Map a command to button 1 and check that it process_button_cmds()
+	 * runs it if called with button 1 pressed.
+	 */
+	ut_assertok(env_set("button_cmd_0_name", "button1"));
+	ut_assertok(env_set("button_cmd_0", "env set " BTN1_PASS_VAR " PASS"));
+	ut_assertok(sandbox_gpio_set_value(gpio, BTN1_GPIO, 1));
+	/* Sanity check that the button is actually pressed */
+	ut_asserteq(BUTTON_ON, button_get_state(btn1_dev));
+	process_button_cmds();
+	ut_assertnonnull((envstr = env_get(BTN1_PASS_VAR)));
+	ut_asserteq_str(envstr, "PASS");
+
+	/* Clear result */
+	ut_assertok(env_set(BTN1_PASS_VAR, NULL));
+
+	/*
+	 * Map a command for button 2, press it, check that only the command
+	 * for button 1 runs because it comes first and is also pressed.
+	 */
+	ut_assertok(env_set("button_cmd_1_name", "button2"));
+	ut_assertok(env_set("button_cmd_1", "env set " BTN2_PASS_VAR " PASS"));
+	ut_assertok(sandbox_gpio_set_value(gpio, BTN2_GPIO, 1));
+	ut_asserteq(BUTTON_ON, button_get_state(btn2_dev));
+	process_button_cmds();
+	/* Check that button 1 triggered again */
+	ut_assertnonnull((envstr = env_get(BTN1_PASS_VAR)));
+	ut_asserteq_str(envstr, "PASS");
+	/* And button 2 didn't */
+	ut_assertnull(env_get(BTN2_PASS_VAR));
+
+	/* Clear result */
+	ut_assertok(env_set(BTN1_PASS_VAR, NULL));
+
+	/*
+	 * Release button 1 and check that the command for button 2 is run
+	 */
+	ut_assertok(sandbox_gpio_set_value(gpio, BTN1_GPIO, 0));
+	process_button_cmds();
+	ut_assertnull(env_get(BTN1_PASS_VAR));
+	/* Check that the command for button 2 ran */
+	ut_assertnonnull((envstr = env_get(BTN2_PASS_VAR)));
+	ut_asserteq_str(envstr, "PASS");
+
+	/* Clear result */
+	ut_assertok(env_set(BTN2_PASS_VAR, NULL));
+
+	/*
+	 * Unset "button_cmd_0_name" and check that no commands run even
+	 * with both buttons pressed.
+	 */
+	ut_assertok(env_set("button_cmd_0_name", NULL));
+	/* Press button 1 (button 2 is already pressed )*/
+	ut_assertok(sandbox_gpio_set_value(gpio, BTN1_GPIO, 1));
+	ut_asserteq(BUTTON_ON, button_get_state(btn1_dev));
+	process_button_cmds();
+	ut_assertnull(env_get(BTN1_PASS_VAR));
+	ut_assertnull(env_get(BTN2_PASS_VAR));
+
+	/*
+	 * Check that no command is run if the button name is wrong.
+	 */
+	ut_assertok(env_set("button_cmd_0_name", "invalid_button"));
+	process_button_cmds();
+	ut_assertnull(env_get(BTN1_PASS_VAR));
+	ut_assertnull(env_get(BTN2_PASS_VAR));
+
+#undef BTN1_PASS_VAR
+#undef BTN2_PASS_VAR
+#undef BTN1_GPIO
+#undef BTN2_GPIO
+
+	return 0;
+}
+DM_TEST(dm_test_button_cmd, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-- 
2.43.1

