Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374B3C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 14:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D13288054;
	Tue,  5 Mar 2024 15:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eFPGrgDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0388487FB8; Tue,  5 Mar 2024 15:51:34 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0934C88081
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 15:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5131a9b3d5bso6523227e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 06:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709650289; x=1710255089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aHA9+Bn1nM5VeSU+pgPDmopjqoi0KDzeY77Pohf9quE=;
 b=eFPGrgDriUVmms+6l5F3ixXMOVy9eng4rukmy457LMw3un17PDIk0OkaTNAedHaqAq
 RXKM8kBRXxZpYg3BwhayAGoA5IOZvUKmJCPFgiia2CMSzHSJW3oSAWEZIKt3YYvOv5Wc
 zpmWtpqWTVprL0VEeZwvqmaxhjHy5F6qc3Mt7pWI9OaX6u0igkmVnT6bFnA8nM+gqbzO
 8FVUgyF/O2JKKQBUy0VEdrRx1jbX5MbG1EqTkea4NVZ5oInMmb60/nqIouwMkn+PosyH
 ZimNX8MWdeGlXQcOZM2tSRjEq9NecXyyclnm/CIxOJrKtOiKn/Na/XguXUOhkK/2qt4N
 gH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709650289; x=1710255089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHA9+Bn1nM5VeSU+pgPDmopjqoi0KDzeY77Pohf9quE=;
 b=HiJzbxZO2jOruqAYqeG56w26c7l+Kg5eG48hjzp2v+oIoNUcSZy904CTMXxRaXIE0Y
 A/HsY7FyebjIhYKCRmooP9oU8D3nhvU4oQqxOOJdwt/cE5oJGdUi0+kG32xu45Qcq6vI
 uvnd15XNONBDSvgGLlBITED+oqpKXh6U5Z4wQ8143yjb0z7ezXtP3ETGJERKZOWBlU9G
 xtGtVqZFvEMrsbSVcMVosCOuzkCvQXMexH0CSXLIGE6el2CN6tr2zXjRD6EshWUQ7SE1
 vSxSc+SfHT3FBA47rpCv4eu52LqHnJnTkKuG5Dj4hkwffQiLMQyF5f+C6VUlW5mqeiYU
 zfwQ==
X-Gm-Message-State: AOJu0Yyxfn44fzfq3CAecAzK7/5IGUBFf7Ybzmwc4IucdoO6IpuZnc07
 ycxp/i/g5Bbi+Q6ETVkO8tE0KiQrrHA6rs6dnR3+KlA7RWShTR9Ur58LPkT2ZVQ=
X-Google-Smtp-Source: AGHT+IGdzP/o4WM8qNRD248tnIO3G6KMMzDE/rMZnmTmF+hs+sfe++cAsbawVgSnygEeIBtIL8pERQ==
X-Received: by 2002:ac2:4306:0:b0:513:1cae:4783 with SMTP id
 l6-20020ac24306000000b005131cae4783mr1383604lfh.60.1709650288774; 
 Tue, 05 Mar 2024 06:51:28 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 jn3-20020a05600c6b0300b004128e903b2csm20727426wmb.39.2024.03.05.06.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 06:51:28 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] test: dm: add button_cmd test
Date: Tue,  5 Mar 2024 14:51:03 +0000
Message-ID: <20240305145111.1391645-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

Additionally, fix a potential uninitialised variable use caught by these
tests, the btn variable in get_button_cmd() is assumed to be null if
button_get_by_label() fails, but it's actually used uninitialised in
that case.

CONFIG_BUTTON is now enabled automatically and was removed when running
save_defconfig.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Fixes: e761035b6423 ("boot: add support for button commands")
---
Changes in v2:
- Explicitly assign btn as NULL in get_button_cmd(). This fixes a
  bug where if the undefined variable is non-zero the
  button_get_by_label() check would fail and result in invalid memory
  being accessed.
- Enable CONFIG_BUTTON_CMD for sandbox64 as well as sandbox.
- Link to v1: https://lore.kernel.org/u-boot/20240214170357.4091708-1-caleb.connolly@linaro.org/
---
 common/button_cmd.c         |  2 +-
 configs/sandbox64_defconfig |  2 +-
 configs/sandbox_defconfig   |  2 +-
 test/dm/button.c            | 96 +++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/common/button_cmd.c b/common/button_cmd.c
index b6a8434d6f29..8642c26735cc 100644
--- a/common/button_cmd.c
+++ b/common/button_cmd.c
@@ -32,9 +32,9 @@ struct button_cmd {
  */
 static int get_button_cmd(int n, struct button_cmd *cmd)
 {
 	const char *cmd_str;
-	struct udevice *btn;
+	struct udevice *btn = NULL;
 	char buf[24];
 
 	snprintf(buf, sizeof(buf), "button_cmd_%d_name", n);
 	cmd->btn_name = env_get(buf);
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index d101cca6a738..a62faf772482 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -10,8 +10,9 @@ CONFIG_PCI=y
 CONFIG_SANDBOX64=y
 CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00100000
 CONFIG_SYS_MEMTEST_END=0x00101000
+CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -122,9 +123,8 @@ CONFIG_SYS_ATA_STRIDE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
 CONFIG_SYS_ATA_REG_OFFSET=1
 CONFIG_SYS_ATA_ALT_OFFSET=2
 CONFIG_SYS_ATA_IDE0_OFFSET=0
-CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_CLK_COMPOSITE_CCF=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a8df5e635b26..93b52f2de5cf 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -9,8 +9,9 @@ CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00100000
 CONFIG_SYS_MEMTEST_END=0x00101000
+CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
@@ -165,9 +166,8 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_RTC=y
 CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
 CONFIG_DM_BOOTCOUNT_SYSCON=y
-CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_CLK_COMPOSITE_CCF=y
diff --git a/test/dm/button.c b/test/dm/button.c
index 3318668df25a..830d96fbef34 100644
--- a/test/dm/button.c
+++ b/test/dm/button.c
@@ -130,4 +130,100 @@ static int dm_test_button_keys_adc(struct unit_test_state *uts)
 
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
2.44.0

