Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0701C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D67883F7;
	Mon, 22 Apr 2024 13:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="AnVbkAox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4937887C2; Mon, 22 Apr 2024 13:44:10 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4503988397
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41a70466b77so4117075e9.0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713786248; x=1714391048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1CEd5qM/jQNwMESkxyNwi9BJ46V2YfjuepSB65Qh5Q=;
 b=AnVbkAoxH2vg5Kg82Tg3bbMw4EFRklrZYsQ0zPH5ieRqI4JNYzY6cjHcPLpXbTIejj
 meNssDF3LJzgmlJlF2k/Iy58A4Gdb7NoDCBijQSF2E764fOSG7G8p0YcsoNSBsRREMse
 lHEJD1sqEGV0QX/jQpoEbVOZdBG3iDN4j78lcXYyVNd719aPTUyiVQNgyqDzROK7cFEN
 VaphVW1UJXwRBVWDzvFixfXKpiRCHHec9Ap9bNygaZNFb5GU5giRImRfEFJlgv2imDpF
 zh9a9NFlh/D9fJYd7mgFRm7MpeBSODVX3ewkygADaxAs7AeXzWfs+61F4YFYyuqCUvlh
 s6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713786248; x=1714391048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1CEd5qM/jQNwMESkxyNwi9BJ46V2YfjuepSB65Qh5Q=;
 b=crgv0gv0l41nnlk61C5LpP0Q2U3AH6WHXupGx9woaRvqS1EKGYn58BsvPS+VVb1fqC
 Y6sYqUMNBJbD+EuFWkm699cSw1KZQqKci9sQM7Q7xd3yBOsKDeX9JTbKkjxlwiXPPeoA
 xSCCg9CTqjRcOR+BWbk2k2CNUUkG1DC9p95XdcCnfQQQh4GeLdWx71xcb8pYKaFGiai5
 BnFpkd4xrGGMcbnwTKkxcDMKbmkGUWJXcRUUcxJ4EHUCVWiurAcODBc4fkv/w+dbNMQu
 GkC9vz8F6D9oXK6yVlqFDe0iCUePemz6dYHpBXWBRFZgK5G+5wrv3vZmWzli9MedTThy
 Kqdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcd6azlF2RguJJTX3ZharvaFIKvmdObQI/u5UR0LHMuxpIOFH3XtIbwS21msSQ2IB0MDM5ylm44XaURWLleS/BOeiXdQ==
X-Gm-Message-State: AOJu0YxjZKA7liyYNE7BMdIqoxziB9Xb7KrgBt4CDCZKl2cZudBmvG2/
 No9a2k6iI2VXtZf/efaJaQCUtj3jxiAFDRA6G68GKEnlbQa1ZlMu80jXIS4zkqs=
X-Google-Smtp-Source: AGHT+IEf7nQ9tPiV52BB9oEaQHTQ/JaK/9+DDk2ZMwYM5T2yMYZZyHOB3MuEVy4154k+mgG7m0bROQ==
X-Received: by 2002:a05:600c:45ca:b0:41a:6edd:6c2a with SMTP id
 s10-20020a05600c45ca00b0041a6edd6c2amr1176981wmo.40.1713786247694; 
 Mon, 22 Apr 2024 04:44:07 -0700 (PDT)
Received: from fedora.. (dh207-14-170.xnet.hr. [88.207.14.170])
 by smtp.googlemail.com with ESMTPSA id
 e5-20020adfe385000000b003455e5d2569sm12022977wrm.0.2024.04.22.04.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 04:44:05 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 5/5] pinctrl: qcom: ipq4019: support all pin functions
Date: Mon, 22 Apr 2024 13:43:28 +0200
Message-ID: <20240422114359.219762-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422114359.219762-1-robert.marko@sartura.hr>
References: <20240422114359.219762-1-robert.marko@sartura.hr>
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

Currently, IPQ4019 pinctrl driver supports only a very limited number of
pin functions and is not fully DT compatible with Linux pinctrl nodes.

IPQ40xx SoC-s sometimes use different pin function numbers for the same
function depending on the pin number, so for example I2C0 on GPIO58 uses
function number 3 while on GPIO59 it uses function number 2.

So, in order to make the driver compatible with upstream DTS to avoid the
need to patch the pinctrl nodes in U-Boot and support all of the missing
pin functions lets rework the driver based on upstream Linux IPQ4019
pinctrl driver and the pending SM8150 U-Boot pinctrl driver which also uses
different function numbers pased on the exact pin number.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/pinctrl/qcom/pinctrl-ipq4019.c | 306 +++++++++++++++++++++++--
 1 file changed, 293 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 48644a51ae..26ab487857 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -14,19 +14,291 @@
 
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq4019_functions {
+	qca_mux_gpio,
+	qca_mux_aud_pin,
+	qca_mux_audio_pwm,
+	qca_mux_blsp_i2c0,
+	qca_mux_blsp_i2c1,
+	qca_mux_blsp_spi0,
+	qca_mux_blsp_spi1,
+	qca_mux_blsp_uart0,
+	qca_mux_blsp_uart1,
+	qca_mux_chip_rst,
+	qca_mux_i2s_rx,
+	qca_mux_i2s_spdif_in,
+	qca_mux_i2s_spdif_out,
+	qca_mux_i2s_td,
+	qca_mux_i2s_tx,
+	qca_mux_jtag,
+	qca_mux_led0,
+	qca_mux_led1,
+	qca_mux_led2,
+	qca_mux_led3,
+	qca_mux_led4,
+	qca_mux_led5,
+	qca_mux_led6,
+	qca_mux_led7,
+	qca_mux_led8,
+	qca_mux_led9,
+	qca_mux_led10,
+	qca_mux_led11,
+	qca_mux_mdc,
+	qca_mux_mdio,
+	qca_mux_pcie,
+	qca_mux_pmu,
+	qca_mux_prng_rosc,
+	qca_mux_qpic,
+	qca_mux_rgmii,
+	qca_mux_rmii,
+	qca_mux_sdio,
+	qca_mux_smart0,
+	qca_mux_smart1,
+	qca_mux_smart2,
+	qca_mux_smart3,
+	qca_mux_tm,
+	qca_mux_wifi0,
+	qca_mux_wifi1,
+	qca_mux_NA,
+};
+
+#define QCA_PIN_FUNCTION(fname)				\
+	[qca_mux_##fname] = {#fname, qca_mux_##fname}
+
 static const struct pinctrl_function msm_pinctrl_functions[] = {
-	{"gpio", 0},
-	{"blsp_uart0_0", 1}, /* Only for GPIO:16,17 */
-	{"blsp_uart0_1", 2}, /* Only for GPIO:60,61 */
-	{"blsp_uart1", 1},
-	{"blsp_spi0_0", 1}, /* Only for GPIO:12,13,14,15 */
-	{"blsp_spi0_1", 2}, /* Only for GPIO:54,55,56,57 */
-	{"blsp_spi1", 2},
-	{"mdio_0", 1}, /* Only for GPIO6 */
-	{"mdio_1", 2}, /* Only for GPIO53 */
-	{"mdc_0", 1}, /* Only for GPIO7 */
-	{"mdc_1", 2}, /* Only for GPIO52 */
+	QCA_PIN_FUNCTION(aud_pin),
+	QCA_PIN_FUNCTION(audio_pwm),
+	QCA_PIN_FUNCTION(blsp_i2c0),
+	QCA_PIN_FUNCTION(blsp_i2c1),
+	QCA_PIN_FUNCTION(blsp_spi0),
+	QCA_PIN_FUNCTION(blsp_spi1),
+	QCA_PIN_FUNCTION(blsp_uart0),
+	QCA_PIN_FUNCTION(blsp_uart1),
+	QCA_PIN_FUNCTION(chip_rst),
+	QCA_PIN_FUNCTION(gpio),
+	QCA_PIN_FUNCTION(i2s_rx),
+	QCA_PIN_FUNCTION(i2s_spdif_in),
+	QCA_PIN_FUNCTION(i2s_spdif_out),
+	QCA_PIN_FUNCTION(i2s_td),
+	QCA_PIN_FUNCTION(i2s_tx),
+	QCA_PIN_FUNCTION(jtag),
+	QCA_PIN_FUNCTION(led0),
+	QCA_PIN_FUNCTION(led1),
+	QCA_PIN_FUNCTION(led2),
+	QCA_PIN_FUNCTION(led3),
+	QCA_PIN_FUNCTION(led4),
+	QCA_PIN_FUNCTION(led5),
+	QCA_PIN_FUNCTION(led6),
+	QCA_PIN_FUNCTION(led7),
+	QCA_PIN_FUNCTION(led8),
+	QCA_PIN_FUNCTION(led9),
+	QCA_PIN_FUNCTION(led10),
+	QCA_PIN_FUNCTION(led11),
+	QCA_PIN_FUNCTION(mdc),
+	QCA_PIN_FUNCTION(mdio),
+	QCA_PIN_FUNCTION(pcie),
+	QCA_PIN_FUNCTION(pmu),
+	QCA_PIN_FUNCTION(prng_rosc),
+	QCA_PIN_FUNCTION(qpic),
+	QCA_PIN_FUNCTION(rgmii),
+	QCA_PIN_FUNCTION(rmii),
+	QCA_PIN_FUNCTION(sdio),
+	QCA_PIN_FUNCTION(smart0),
+	QCA_PIN_FUNCTION(smart1),
+	QCA_PIN_FUNCTION(smart2),
+	QCA_PIN_FUNCTION(smart3),
+	QCA_PIN_FUNCTION(tm),
+	QCA_PIN_FUNCTION(wifi0),
+	QCA_PIN_FUNCTION(wifi1),
 };
+
+typedef unsigned int msm_pin_function[15];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14) \
+	[id] = {        qca_mux_gpio, /* gpio mode */	\
+			qca_mux_##f1,			\
+			qca_mux_##f2,			\
+			qca_mux_##f3,			\
+			qca_mux_##f4,			\
+			qca_mux_##f5,			\
+			qca_mux_##f6,			\
+			qca_mux_##f7,			\
+			qca_mux_##f8,			\
+			qca_mux_##f9,			\
+			qca_mux_##f10,			\
+			qca_mux_##f11,			\
+			qca_mux_##f12,			\
+			qca_mux_##f13,			\
+			qca_mux_##f14			\
+	}
+
+static const msm_pin_function ipq4019_pin_functions[] = {
+	PINGROUP(0, jtag, smart0, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(1, jtag, smart0, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(2, jtag, smart0, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(3, jtag, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(4, jtag, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(5, jtag, smart0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(6, mdio, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(7, mdc, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(8, blsp_uart1, NA, NA, smart1, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(9, blsp_uart1, NA, NA, smart1, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(10, blsp_uart1, NA, NA, blsp_i2c0, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(11, blsp_uart1, NA, NA, blsp_i2c0, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(12, blsp_spi0, blsp_i2c1, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(13, blsp_spi0, blsp_i2c1, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(14, blsp_spi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(15, blsp_spi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(16, blsp_uart0, led0, smart1, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(17, blsp_uart0, led1, smart1, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(18, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(19, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(20, blsp_i2c0, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(21, blsp_i2c0, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(22, rgmii, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(23, sdio, rgmii, i2s_rx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(24, sdio, rgmii, i2s_tx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(25, sdio, rgmii, i2s_tx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(26, sdio, rgmii, i2s_tx, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(27, sdio, rgmii, i2s_td, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(28, sdio, rgmii, i2s_td, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(29, sdio, rgmii, i2s_td, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(30, sdio, rgmii, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(31, sdio, rgmii, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(32, sdio, rgmii, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(33, rgmii, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(34, blsp_i2c1, i2s_spdif_in, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA, NA),
+	PINGROUP(35, blsp_i2c1, i2s_spdif_out, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA, NA),
+	PINGROUP(36, rmii, led2, led0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(37, rmii, wifi0, wifi1, led1, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(38, rmii, led2, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(39, rmii, pcie, led3, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(40, rmii, wifi0, wifi1, smart2, led4, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(41, rmii, wifi0, wifi1, smart2, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(42, rmii, wifi0, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(43, rmii, wifi1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(44, rmii, blsp_spi1, smart0, led5, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(45, rmii, blsp_spi1, blsp_spi0, smart0, led6, NA, NA, NA, NA,
+		 NA, NA, NA, NA, NA),
+	PINGROUP(46, rmii, blsp_spi1, smart0, led7, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(47, rmii, blsp_spi1, smart0, led8, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(48, rmii, aud_pin, smart2, led9, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(49, rmii, aud_pin, smart2, led10, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(50, rmii, aud_pin, wifi0, wifi1, led11, NA, NA, NA, NA, NA,
+		 NA, NA, NA, NA),
+	PINGROUP(51, rmii, aud_pin, wifi0, wifi1, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(52, qpic, mdc, pcie, i2s_tx, NA, NA, NA, tm, wifi0, wifi1, NA,
+		 NA, NA, NA),
+	PINGROUP(53, qpic, mdio, i2s_tx, prng_rosc, NA, tm, wifi0, wifi1, NA,
+		 NA, NA, NA, NA, NA),
+	PINGROUP(54, qpic, blsp_spi0, i2s_td, NA, pmu, NA, NA, NA, tm, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(55, qpic, blsp_spi0, i2s_td, NA, pmu, NA, NA, NA, tm, NA, NA,
+		 NA, NA, NA),
+	PINGROUP(56, qpic, blsp_spi0, i2s_td, NA, NA, tm, wifi0, wifi1, NA, NA,
+		 NA, NA, NA, NA),
+	PINGROUP(57, qpic, blsp_spi0, i2s_tx, NA, NA, tm, wifi0, wifi1, NA, NA,
+		 NA, NA, NA, NA),
+	PINGROUP(58, qpic, led2, blsp_i2c0, smart3, smart1, i2s_rx, NA, NA, tm,
+		 wifi0, wifi1, NA, NA, NA),
+	PINGROUP(59, qpic, blsp_i2c0, smart3, smart1, i2s_spdif_in, NA, NA, NA,
+		 NA, NA, tm, NA, NA, NA),
+	PINGROUP(60, qpic, blsp_uart0, smart1, smart3, led0, i2s_tx, i2s_rx,
+		 NA, NA, NA, NA, NA, tm, NA),
+	PINGROUP(61, qpic, blsp_uart0, smart1, smart3, led1, i2s_tx, i2s_rx,
+		 NA, NA, NA, NA, NA, tm, NA),
+	PINGROUP(62, qpic, chip_rst, NA, NA, i2s_spdif_out, NA, NA, NA, NA, NA,
+		 tm, NA, NA, NA),
+	PINGROUP(63, qpic, NA, NA, NA, i2s_td, i2s_rx, i2s_spdif_out,
+		 i2s_spdif_in, NA, NA, NA, NA, tm, NA),
+	PINGROUP(64, qpic, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(65, qpic, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(66, qpic, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(67, qpic, audio_pwm, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA, NA),
+	PINGROUP(68, qpic, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(69, qpic, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(70, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(71, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(72, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(73, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(74, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(75, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(76, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(77, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(78, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(79, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(80, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(81, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(82, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(83, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(84, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(85, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(86, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(87, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(88, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(89, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(90, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(91, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(92, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(93, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(94, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(95, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(96, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(97, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(98, wifi0, wifi1, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
+		 NA),
+	PINGROUP(99, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+};
+
 static const char *ipq4019_get_function_name(struct udevice *dev,
 					     unsigned int selector)
 {
@@ -40,10 +312,18 @@ static const char *ipq4019_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int ipq4019_get_function_mux(__maybe_unused unsigned int pin,
+static unsigned int ipq4019_get_function_mux(unsigned int pin,
 					     unsigned int selector)
 {
-	return msm_pinctrl_functions[selector].val;
+	unsigned int i;
+	const msm_pin_function *func = ipq4019_pin_functions + pin;
+
+	for (i = 0; i < 15; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u pin\n", pin);
+	return -EINVAL;
 }
 
 static const struct msm_pinctrl_data ipq4019_data = {
-- 
2.44.0

