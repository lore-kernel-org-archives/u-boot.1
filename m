Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF772EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05958865A8;
	Wed,  6 Sep 2023 04:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uMk5da/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68C586963; Wed,  6 Sep 2023 04:41:14 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8515865A8
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2684e225a6cso495161a91.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968068; x=1694572868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDaK2f2RDHI4ZFwb1T775mvqYxCcpP0UOfvoR0syY7s=;
 b=uMk5da/DqHLLw4YpmsQ/3nn+B5FPGaUzhtLzxlaJxYRRAB96WEMQtWsDxdM9RDZpxA
 vJMkRh9PA3ScB5G66t5UieocWJNZ5vlcyLtfaBF68qAjHjIOk5bluEbPSoJ8GHy0R+/w
 12YPvd3FL4XlORMwMTRWWBNfuhZbD8uh06E8wADylx5s9cRsh9qYmW6LyjMvywCVctkl
 M+u4O7esGawT+DvMhGoDUXUWbwIDn0zPo5+IXw4100jZsGYQyFDyNP79QJYcqY1SdEEt
 iZBTJDniUUr3RWFSZWmyzZ30WcNocDrQQ7PNx7QqAF2m3xM/BIyirLB5Cmv8Xs5aqcyX
 95Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968068; x=1694572868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDaK2f2RDHI4ZFwb1T775mvqYxCcpP0UOfvoR0syY7s=;
 b=Cv/TTXO9l4l8kcpFZD9Gt79q5sJq7dCqKUL51FTR+pP4zrby5QdKORG6r7J3zCBD/Y
 9Xnfs9f7XZoU08Lvj1fjUjQ+DMfcw6nSH2CNHOOXccdudmLOuxeaeIRFIc3JT1r2YCzl
 KiH8L0a2W8kCVzHKO2zEjHYQAmkOAJKsvjllhoWry67t6NfHYyhg+ZIX7byX4P3buaMi
 A8l9TugMn5CvCplY0qoVlwyhN2EmaEB3Gf+MbEmpkLgC+jqjYQyM5riw0eBPNLMAbINq
 66C02nm7O8NpzSGkwy1+/g1CWNDMFB4Kzraq2Ed9Ry+TwdRk5nshNyyRngVLYoh2vrGT
 7xfA==
X-Gm-Message-State: AOJu0YwjsTy9k35AVXZImAt3IMO4xf8FV6ohPG9soQHmqwn5YcFInJ4U
 COBp9MJJHc1etsnpCDLtIGQjqqx5qCneKPtBg9RiPA==
X-Google-Smtp-Source: AGHT+IFRMojPiV/qtzkngmKeLN5blxjWHg0uN2w1BD4CRUdN0icXzcLRT4efhGXFgl5U+QS5/zOukQ==
X-Received: by 2002:a05:6a20:4289:b0:133:7a67:b477 with SMTP id
 o9-20020a056a20428900b001337a67b477mr20211617pzj.1.1693968067782; 
 Tue, 05 Sep 2023 19:41:07 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:41:07 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 5/6] firmware: scmi: add pseudo pinctrl protocol support on
 sandbox
Date: Wed,  6 Sep 2023 11:40:10 +0900
Message-Id: <20230906024011.17488-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906024011.17488-1-takahiro.akashi@linaro.org>
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
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

With this patch, sandbox SCMI agent can handle pinctrl protocol.
This feature is used in an unit test for SCMI pinctrl.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/sandbox/dts/test.dts                  | 115 ++++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 722 +++++++++++++++++++++
 2 files changed, 837 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index dc0bfdfb6e4b..d2ddea801995 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -723,9 +723,124 @@
 					};
 				};
 			};
+
+			pinctrl_scmi: protocol@19 {
+				reg = <0x19>;
+
+				pinctrl-names = "default","alternate";
+				pinctrl-0 = <&scmi_pinctrl_gpios>, <&scmi_pinctrl_i2s>;
+				pinctrl-1 = <&scmi_pinctrl_spi>, <&scmi_pinctrl_i2c>;
+
+#if 0
+				scmi_pinctrl_gpio_a: scmi_gpios {
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-bank-name = "scmi_gpios";
+					ngpios = <4>;
+					gpio-ranges = <&pinctrl_scmi 0 5 4>,
+						      <&pinctrl_scmi 4 0 0>;
+					gpio-ranges-group-names = "",
+								  "GPIO_B";
+
+					hog_input_1 {
+						gpio-hog;
+						input;
+						gpios = <1 GPIO_ACTIVE_HIGH>;
+					};
+					hog_output_3 {
+						gpio-hog;
+						output-high;
+						output-mode;
+						output-value = <1>;
+						gpios = <3 GPIO_ACTIVE_HIGH>;
+					};
+				};
+#endif
+
+				scmi_pinctrl_gpios: gpios-pins {
+					gpio0 {
+						pins = "P5";
+						function = "GPIO";
+						bias-pull-up;
+						// input-disable;
+						input-mode = <0>;
+					};
+					gpio1 {
+						pins = "P6";
+						function = "GPIO";
+						// output-high;
+						output-mode;
+						output-value = <1>;
+						drive-open-drain;
+					};
+					gpio2 {
+						pinmux = <SANDBOX_PINMUX(7, SANDBOX_PINMUX_GPIO)>;
+						bias-pull-down;
+						// input-enable;
+						input-mode;
+					};
+					gpio3 {
+						pinmux = <SANDBOX_PINMUX(8, SANDBOX_PINMUX_GPIO)>;
+						bias-disable;
+					};
+				};
+
+				scmi_pinctrl_i2c: i2c-pins {
+					groups {
+						groups = "I2C_UART";
+						function = "I2C";
+					};
+
+					pins {
+						pins = "P0", "P1";
+						drive-open-drain;
+					};
+				};
+
+				scmi_pinctrl_i2s: i2s-pins {
+					groups = "SPI_I2S";
+					function = "I2S";
+				};
+
+				scmi_pinctrl_spi: spi-pins {
+					groups = "SPI_I2S";
+					function = "SPI";
+
+					cs {
+						pinmux = <SANDBOX_PINMUX(5, SANDBOX_PINMUX_CS)>,
+							 <SANDBOX_PINMUX(6, SANDBOX_PINMUX_CS)>;
+					};
+				};
+			};
 		};
 	};
 
+#if 1
+	scmi_pinctrl_gpio_a: scmi_gpios {
+		compatible = "arm,scmi-gpio-generic";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-bank-name = "scmi_gpios";
+		gpio-ranges = <&pinctrl_scmi 0 5 4>,
+			      <&pinctrl_scmi 4 0 0>;
+		gpio-ranges-group-names = "",
+					  "GPIO_B";
+
+		hog_input_1 {
+			gpio-hog;
+			input;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+		};
+		hog_output_3 {
+			gpio-hog;
+			output-high;
+			output-mode;
+			output-value = <1>;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+#endif
+
 	fpga {
 		compatible = "sandbox,fpga";
 	};
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 27d17809be43..d5ff8a2b1c79 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <asm/scmi_test.h>
 #include <dm/device_compat.h>
+#include <dt-bindings/pinctrl/sandbox-pinmux.h>
 #include <linux/bitfield.h>
 #include <linux/kernel.h>
 
@@ -43,8 +44,11 @@
 #define SANDBOX_SCMI_AGENT_NAME "OSPM"
 #define SANDBOX_SCMI_PLATFORM_NAME "platform"
 
+#define SANDBOX_SCMI_PIN_CONTROL_PROTOCOL_VERSION SCMI_PIN_CONTROL_PROTOCOL_VERSION
+
 static u8 protocols[] = {
 	SCMI_PROTOCOL_ID_CLOCK,
+	SCMI_PROTOCOL_ID_PIN_CONTROL,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
 };
@@ -796,6 +800,696 @@ static int sandbox_scmi_voltd_level_get(struct udevice *dev,
 	return 0;
 }
 
+/* Pin control protocol */
+
+/*
+ * This driver emulates a pin controller with the following rules:
+ * - The pinctrl config for each pin must be set individually
+ * - The first two pins (P0-P1) must be muxed as a group
+ * - The next three pins (P2-P4) must be muxed as a group
+ * - The next four pins (P5-P8) must be muxed individually
+ * - The last two pins (P9-P10) must be fixed as a GPIO group only
+
+	P0:  "UART TX",  "I2C SCL"
+	P1:  "UART RX",  "I2C SDA"
+	P2:  "SPI SCLK", "I2S SCK"
+	P3:  "SPI MOSI", "I2S SD"
+	P4:  "SPI MISO", "I2S WS"
+	P5:  "GPIO0",    "SPI CS0"
+	P6:  "GPIO1",    "SPI CS1"
+	P7:  "GPIO2",    "PWM0"
+	P8:  "GPIO3",    "PWM1"
+	P9:  "GPIO_B"
+	P10: "GPIO_B"
+
+ */
+
+static const char * const sandbox_pins[] = {
+#define PIN(x) \
+	[x] = "P" #x
+	PIN(0),
+	PIN(1),
+	PIN(2),
+	PIN(3),
+	PIN(4),
+	PIN(5),
+	PIN(6),
+	PIN(7),
+	PIN(8),
+	PIN(9),
+	PIN(10),
+#undef PIN
+};
+
+static unsigned int sandbox_pin_functions[9];
+static u32 sandbox_pin_states[9][SCMI_PINCTRL_CONFIG_RESERVED];
+
+#define SANDBOX_GROUP_I2C_UART 0
+#define SANDBOX_GROUP_SPI_I2S 1
+#define SANDBOX_GROUP_GPIO_B 2
+
+static const char * const sandbox_groups[] = {
+	/* P0-P1 */
+	[SANDBOX_GROUP_I2C_UART] = "I2C_UART",
+	/* P2-P4 */
+	[SANDBOX_GROUP_SPI_I2S] = "SPI_I2S",
+	/* P9-P10 */
+	[SANDBOX_GROUP_GPIO_B] = "GPIO_B",
+};
+
+static const char * const sandbox_functions[] = {
+#define FUNC(id) \
+	[SANDBOX_PINMUX_##id] = #id
+	FUNC(UART),
+	FUNC(I2C),
+	FUNC(SPI),
+	FUNC(I2S),
+	FUNC(GPIO),
+	FUNC(CS),
+	FUNC(PWM),
+	/* FUNC(GPIO_B) */
+#undef FUNC
+};
+
+static int sandbox_scmi_pinctrl_protocol_version(struct udevice *dev,
+						 struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = SANDBOX_SCMI_PIN_CONTROL_PROTOCOL_VERSION;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_protocol_attrs(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_protocol_attrs_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_pinctrl_protocol_attrs_out *)msg->out_msg;
+	out->attributes_low = (ARRAY_SIZE(sandbox_groups) << 16)
+				+ ARRAY_SIZE(sandbox_pins);
+	out->attributes_high = ARRAY_SIZE(sandbox_functions);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_attrs(struct udevice *dev,
+				      struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_attrs_in *in;
+	struct scmi_pinctrl_attrs_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_attrs_in *)msg->in_msg;
+	out = (struct scmi_pinctrl_attrs_out *)msg->out_msg;
+
+	/*
+	 * Currently all pins have a name with less than 16 characters
+	 * (SCMI_PINCTRL_NAME_LENGTH_MAX).
+	 */
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id < ARRAY_SIZE(sandbox_pins)) {
+			strcpy(out->name, sandbox_pins[in->id]);
+			out->attributes = 0;
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id < ARRAY_SIZE(sandbox_groups)) {
+			strcpy(out->name, sandbox_groups[in->id]);
+			out->attributes = in->id ? 3 : 2;
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_FUNCTION:
+		if (in->id < ARRAY_SIZE(sandbox_functions)) {
+			strcpy(out->name, sandbox_functions[in->id]);
+			if (in->id == 4) /* UART */
+				out->attributes = 4;
+			else if (in->id == 5 || in->id == 6) /* CS or PWM */
+				out->attributes = 2;
+			else
+				out->attributes = 1;
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		out->status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	out->status = SCMI_SUCCESS;
+
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_list_assocs(struct udevice *dev,
+					    struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_list_assocs_in *in;
+	struct scmi_pinctrl_list_assocs_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_list_assocs_in *)msg->in_msg;
+	out = (struct scmi_pinctrl_list_assocs_out *)msg->out_msg;
+
+	/*
+	 * UART -> GROUP0
+	 * I2C  -> GROUP0
+	 * SPI  -> GROUP1
+	 * I2S  -> GROUP1
+	 * GPIO -> PIN5, 6, 7, 8
+	 * CS   -> PIN5, 6
+	 * PWM  -> PIN7, 8
+	 * (GPIO_B -> GROUP2)
+	 */
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id == SANDBOX_GROUP_I2C_UART) {
+			if (in->index == 0) {
+				out->array[0] = 0;
+				out->array[1] = 1;
+				out->flags = 2;
+			} else if (in->index == 1) {
+				out->array[0] = 0;
+				out->flags = 1;
+			} else {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+		} else if (in->id == SANDBOX_GROUP_SPI_I2S) {
+			if (in->index == 0) {
+				out->array[0] = 2;
+				out->array[1] = 3;
+				out->array[2] = 4;
+				out->flags = 3;
+			} else if (in->index == 1) {
+				out->array[0] = 3;
+				out->array[1] = 4;
+				out->flags = 2;
+			} else if (in->index == 2) {
+				out->array[0] = 4;
+				out->flags = 1;
+			} else {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+		} else if (in->id == SANDBOX_GROUP_GPIO_B) {
+			if (in->index == 0) {
+				out->array[0] = 9;
+				out->array[1] = 10;
+				out->flags = 2;
+			} else if (in->index == 1) {
+				out->array[0] = 10;
+				out->flags = 1;
+			} else {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_FUNCTION:
+		if (in->id == SANDBOX_PINMUX_UART) {
+			if (in->index > 0) {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+			out->array[0] = SANDBOX_GROUP_I2C_UART;
+			out->flags = 1;
+		} else if (in->id == SANDBOX_PINMUX_I2C) {
+			if (in->index > 0) {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+			out->array[0] = SANDBOX_GROUP_I2C_UART;
+			out->flags = 1;
+		} else if (in->id == SANDBOX_PINMUX_SPI) {
+			if (in->index > 0) {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+			out->array[0] = SANDBOX_GROUP_SPI_I2S;
+			out->flags = 1;
+		} else if (in->id == SANDBOX_PINMUX_I2S) {
+			if (in->index > 0) {
+				out->status = SCMI_OUT_OF_RANGE;
+				goto err;
+			}
+			out->array[0] = SANDBOX_GROUP_SPI_I2S;
+			out->flags = 1;
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		out->status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	out->status = SCMI_SUCCESS;
+
+err:
+	return 0;
+}
+
+static void copy_config(struct scmi_pin_entry *configs, u32 selector, int skip,
+			u32 *num, u32 *remaining)
+{
+	int max_num, i;
+
+	if ((skip + SCMI_PINCTRL_CONFIG_ENTRY_MAX)
+			> SCMI_PINCTRL_CONFIG_RESERVED)
+		max_num = SCMI_PINCTRL_CONFIG_RESERVED - skip;
+	else
+		max_num = SCMI_PINCTRL_CONFIG_ENTRY_MAX;
+
+	/* TODO: eliminate disabled properties? */
+	for (i = 0; i < max_num; i++) {
+		configs[i].type = skip + i;
+		configs[i].value = sandbox_pin_states[selector][skip + i];
+	}
+
+	*num = max_num;
+	*remaining = SCMI_PINCTRL_CONFIG_RESERVED - (skip + max_num);
+}
+
+static int sandbox_scmi_pinctrl_config_get(struct udevice *dev,
+					   struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_config_get_in *in;
+	struct scmi_pinctrl_config_get_out *out;
+	u32 type, num, remaining;
+	int all_configs, skip;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_config_get_in *)msg->in_msg;
+	out = (struct scmi_pinctrl_config_get_out *)msg->out_msg;
+
+	all_configs = in->attributes & SCMI_PINCTRL_CONFIG_GET_ALL;
+	skip = SCMI_PINCTRL_CONFIG_GET_SKIP(in->attributes);
+	type = SCMI_PINCTRL_CONFIG_GET_TYPE(in->attributes);
+	if (type >= SCMI_PINCTRL_CONFIG_RESERVED) {
+		out->status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	switch (SCMI_PINCTRL_CONFIG_GET_PINCTRL_TYPE(in->attributes)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id < ARRAY_SIZE(sandbox_pins)) {
+			if (all_configs) {
+				if (skip >= SCMI_PINCTRL_CONFIG_RESERVED) {
+					out->status = SCMI_INVALID_PARAMETERS;
+					goto err;
+				}
+				num = 0; /* avoid compiler warning */
+				remaining = 0;
+				copy_config(&out->configs[0], in->id, skip,
+					    &num, &remaining);
+			} else {
+				out->configs[0].type = type;
+				out->configs[0].value =
+					sandbox_pin_states[in->id][type];
+				num = 1;
+				remaining = 0;
+			}
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		out->num_configs =
+			SCMI_PINCTRL_CONFIG_GET_NUM_CONFIGS(remaining, num);
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id < ARRAY_SIZE(sandbox_groups)) {
+			/* TODO */;
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		out->status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	out->status = SCMI_SUCCESS;
+
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_config_set(struct udevice *dev,
+					   struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_config_set_in *in;
+	u32 *status;
+	int i, num;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_config_set_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	num = SCMI_PINCTRL_CONFIG_SET_NUM_CONFIGS(in->attributes);
+	if (num > SCMI_PINCTRL_CONFIG_ENTRY_MAX) {
+		*status = SCMI_PROTOCOL_ERROR;
+		goto err;
+	}
+
+	switch (SCMI_PINCTRL_CONFIG_SET_PINCTRL_TYPE(in->attributes)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id < ARRAY_SIZE(sandbox_pins)) {
+			/* TODO: check value range */
+			for (i = 0; i < num; i++)
+				sandbox_pin_states[in->id][in->configs[i].type]
+					= in->configs[i].value;
+		} else {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		/* TODO: check value range */
+		if (!in->id) {
+			for (i = 0; i < num; i++) {
+				sandbox_pin_states[0][in->configs[i].type] =
+					in->configs[i].value;
+				sandbox_pin_states[1][in->configs[i].type] =
+					in->configs[i].value;
+			}
+		} else if (in->id == 1) {
+			for (i = 0; i < num; i++) {
+				sandbox_pin_states[2][in->configs[i].type] =
+					in->configs[i].value;
+				sandbox_pin_states[3][in->configs[i].type] =
+					in->configs[i].value;
+				sandbox_pin_states[4][in->configs[i].type] =
+					in->configs[i].value;
+			}
+		} else if (in->id == 2) {
+			for (i = 0; i < num; i++) {
+				sandbox_pin_states[9][in->configs[i].type] =
+					in->configs[i].value;
+				sandbox_pin_states[10][in->configs[i].type] =
+					in->configs[i].value;
+			}
+		} else {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		*status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	*status = SCMI_SUCCESS;
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_function_select(struct udevice *dev,
+						struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_function_select_in *in;
+	u32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_function_select_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id == 5 || in->id == 6) {
+			if (in->function_id == SANDBOX_PINMUX_GPIO ||
+			    in->function_id == SANDBOX_PINMUX_CS) {
+				sandbox_pin_functions[in->id] = in->function_id;
+				*status = SCMI_SUCCESS;
+			} else {
+				*status = SCMI_NOT_SUPPORTED;
+			}
+		} else if (in->id == 7 || in->id == 8) {
+			if (in->function_id == SANDBOX_PINMUX_GPIO ||
+			    in->function_id == SANDBOX_PINMUX_PWM) {
+				sandbox_pin_functions[in->id] = in->function_id;
+				*status = SCMI_SUCCESS;
+			} else {
+				*status = SCMI_NOT_SUPPORTED;
+			}
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id == SANDBOX_GROUP_I2C_UART) {
+			if (in->function_id == SANDBOX_PINMUX_UART ||
+			    in->function_id == SANDBOX_PINMUX_I2C) {
+				sandbox_pin_functions[0] = in->function_id;
+				sandbox_pin_functions[1] = in->function_id;
+				*status = SCMI_SUCCESS;
+			} else {
+				*status = SCMI_NOT_SUPPORTED;
+			}
+		} else if (in->id == SANDBOX_GROUP_SPI_I2S) {
+			if (in->function_id == SANDBOX_PINMUX_SPI ||
+			    in->function_id == SANDBOX_PINMUX_I2S) {
+				sandbox_pin_functions[2] = in->function_id;
+				sandbox_pin_functions[3] = in->function_id;
+				sandbox_pin_functions[4] = in->function_id;
+				*status = SCMI_SUCCESS;
+			} else {
+				*status = SCMI_NOT_SUPPORTED;
+			}
+		}
+		break;
+	default:
+		*status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	*status = SCMI_SUCCESS;
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_request(struct udevice *dev,
+					struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_request_in *in;
+	u32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_request_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	/*
+	 * No other agent, so always accept the request
+	 */
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id >= ARRAY_SIZE(sandbox_pins)) {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id >= ARRAY_SIZE(sandbox_groups)) {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		*status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	*status = SCMI_SUCCESS;
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_release(struct udevice *dev,
+					struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_release_in *in;
+	u32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_release_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	/*
+	 * No other agent, so always accept the release
+	 */
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id >= ARRAY_SIZE(sandbox_pins)) {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id >= ARRAY_SIZE(sandbox_groups)) {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		*status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	*status = SCMI_SUCCESS;
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_name_get(struct udevice *dev,
+					 struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_name_get_in *in;
+	struct scmi_pinctrl_name_get_out *out;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_name_get_in *)msg->in_msg;
+	out = (struct scmi_pinctrl_name_get_out *)msg->out_msg;
+
+	/*
+	 * Currently all pins have a name with less than 64 characters
+	 */
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id < ARRAY_SIZE(sandbox_pins)) {
+			strcpy(out->name, sandbox_pins[in->id]);
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id < ARRAY_SIZE(sandbox_groups)) {
+			strcpy(out->name, sandbox_groups[in->id]);
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_FUNCTION:
+		if (in->id < ARRAY_SIZE(sandbox_functions)) {
+			strcpy(out->name, sandbox_functions[in->id]);
+		} else {
+			out->status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		out->status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	out->flags = 0;
+	out->status = SCMI_SUCCESS;
+
+err:
+	return 0;
+}
+
+static int sandbox_scmi_pinctrl_set_permissions(struct udevice *dev,
+						struct scmi_msg *msg)
+{
+	struct scmi_pinctrl_set_permissions_in *in;
+	u32 *status;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*status))
+		return -EINVAL;
+
+	in = (struct scmi_pinctrl_set_permissions_in *)msg->in_msg;
+	status = (u32 *)msg->out_msg;
+
+	if (in->agent_id != 1) {
+		*status = SCMI_NOT_FOUND;
+		goto err;
+	}
+
+	switch (SCMI_PINCTRL_TYPE(in->flags)) {
+	case SCMI_PINCTRL_TYPE_PIN:
+		if (in->id < ARRAY_SIZE(sandbox_pins)) {
+			if (in->flags & SCMI_PINCTRL_PERMISSION)
+				*status = SCMI_SUCCESS;
+			else
+				/* unset not allowed */
+				*status = SCMI_DENIED;
+		} else {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	case SCMI_PINCTRL_TYPE_GROUP:
+		if (in->id < ARRAY_SIZE(sandbox_groups)) {
+			if (in->flags & SCMI_PINCTRL_PERMISSION)
+				*status = SCMI_SUCCESS;
+			else
+				/* unset not allowed */
+				*status = SCMI_DENIED;
+		} else {
+			*status = SCMI_NOT_FOUND;
+			goto err;
+		}
+		break;
+	default:
+		*status = SCMI_INVALID_PARAMETERS;
+		goto err;
+	}
+
+	*status = SCMI_SUCCESS;
+err:
+	return 0;
+}
+
 static int sandbox_scmi_test_process_msg(struct udevice *dev,
 					 struct scmi_channel *channel,
 					 struct scmi_msg *msg)
@@ -847,6 +1541,34 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			break;
 		}
 		break;
+	case SCMI_PROTOCOL_ID_PIN_CONTROL:
+		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_pinctrl_protocol_version(dev, msg);
+		case SCMI_PROTOCOL_ATTRIBUTES:
+			return sandbox_scmi_pinctrl_protocol_attrs(dev, msg);
+		case SCMI_PINCTRL_ATTRIBUTES:
+			return sandbox_scmi_pinctrl_attrs(dev, msg);
+		case SCMI_PINCTRL_LIST_ASSOCIATIONS:
+			return sandbox_scmi_pinctrl_list_assocs(dev, msg);
+		case SCMI_PINCTRL_CONFIG_GET:
+			return sandbox_scmi_pinctrl_config_get(dev, msg);
+		case SCMI_PINCTRL_CONFIG_SET:
+			return sandbox_scmi_pinctrl_config_set(dev, msg);
+		case SCMI_PINCTRL_FUNCTION_SELECT:
+			return sandbox_scmi_pinctrl_function_select(dev, msg);
+		case SCMI_PINCTRL_REQUEST:
+			return sandbox_scmi_pinctrl_request(dev, msg);
+		case SCMI_PINCTRL_RELEASE:
+			return sandbox_scmi_pinctrl_release(dev, msg);
+		case SCMI_PINCTRL_NAME_GET:
+			return sandbox_scmi_pinctrl_name_get(dev, msg);
+		case SCMI_PINCTRL_SET_PERMISSIONS:
+			return sandbox_scmi_pinctrl_set_permissions(dev, msg);
+		default:
+			break;
+		}
+		break;
 	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
 		switch (msg->message_id) {
 		case SCMI_RESET_DOMAIN_ATTRIBUTES:
-- 
2.34.1

