Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9BDEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495878698F;
	Wed,  6 Sep 2023 04:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YQg/F1jV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28DD865A8; Wed,  6 Sep 2023 04:41:14 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97213866DC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 04:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a32506e90so700526b3a.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693968070; x=1694572870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qbtfx7u6KwcO2aMHhHr2Q6+3/YafCKFjaH7opDRFSf0=;
 b=YQg/F1jV9aobNwpMa0DApqSO4exusX6/Z8hmLX6hUmQdgLWyFTLaEQU2b+c9rgJCoh
 UaYD4vzc2DhPdJ8/QUAwQ6W/O69VhWsrTY1hoSmgSUPs2Hhqwxm3gGfGxrUloqY13ldk
 p8zR7TzVb+EIOKTKev+zZQLG6oGaK0jb1R/df53ykH0GL2lxO7qX4Tg+ZoLPVLbjbMmf
 PaZOiE/KZK+wVRHadD51n8NyUCl9mG2Fgjw5QEjakQ6vAZjkinbNMOm2cg4nZU3h24S5
 gAcfuUh030hZXu7Fww26KXR2XcZIH85v/HSh2QeYDBPAYPwOKe0uogzvI8jHFSrqF/xQ
 JzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693968070; x=1694572870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qbtfx7u6KwcO2aMHhHr2Q6+3/YafCKFjaH7opDRFSf0=;
 b=Y1jdr0USUi/4aIJd3OUbgHSVc/ImbV1VMqrBMoMq1pEZAfWuQd7jf+YogMrBcEG6hV
 SFoYFQv4lo2BtJCAfHqB80cTPDRyX/oN0OSbgRTHB0rItUcSnAXbFgtRM1cgfBeHk2cn
 ws7N28qs+py/XmK64GY/d/c7YmolA7z4SDiwxIPp0fPhBnGdH4dDXoHAZVzH3foZejJt
 +AZr/FOodlIrzU0DE3jl7kkz0erH9QJtvnaTenVEZNbhv6b9FZHKvnk+s7qpJunsketv
 gl/an+xWOI9D8r9ti8wON1ZXKB5fgYPXoD51XI09FqMlskBP7kZwdBnV9iaECkByjBoY
 mP8g==
X-Gm-Message-State: AOJu0Yw99DYk2gyzmj9IoZRYRgT76RUVQdj0XXMvs2cc0zz0MfEGdhyq
 UC70AP3IeAciNRHxVVXOt4rER/cOzZFt47Vq2sPJeA==
X-Google-Smtp-Source: AGHT+IE1f79Vpa8RsZoIzISjVeUOJnf5AMRXymtqTFZ9OS5nj/WTLAjkvNhK41MpaAneh3W9Z+kVnw==
X-Received: by 2002:a05:6a00:f0e:b0:68b:c562:da46 with SMTP id
 cr14-20020a056a000f0e00b0068bc562da46mr16015519pfb.1.1693968069848; 
 Tue, 05 Sep 2023 19:41:09 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:8294:a07d:b7e9:4033])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a6566c5000000b0056428865aadsm9145378pgw.82.2023.09.05.19.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 19:41:09 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: u-boot@lists.denx.de
Cc: etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 6/6] test: dm: add SCMI pinctrl test
Date: Wed,  6 Sep 2023 11:40:11 +0900
Message-Id: <20230906024011.17488-7-takahiro.akashi@linaro.org>
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

In this test, SCMI-based pinmux feature is exercised.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 423b6ef70b29..ca5a2e9c781e 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -21,6 +21,7 @@
 #include <scmi_protocols.h>
 #include <asm/scmi_test.h>
 #include <dm/device-internal.h>
+#include <dm/pinctrl.h>
 #include <dm/test.h>
 #include <linux/kconfig.h>
 #include <power/regulator.h>
@@ -395,3 +396,64 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
 	return release_sandbox_scmi_test_devices(uts, dev);
 }
 DM_TEST(dm_test_scmi_voltage_domains, UT_TESTF_SCAN_FDT);
+
+/*
+ * This part is derived from test/dm/pinmux.c, So
+ *
+ * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
+ */
+
+static char buf[64];
+#define test_muxing(selector, expected) do { \
+	ut_assertok(pinctrl_get_pin_muxing(dev, selector, buf, sizeof(buf))); \
+	ut_asserteq_str(expected, (char *)&buf); \
+} while (0)
+
+#define test_name(selector, expected) do { \
+	ut_assertok(pinctrl_get_pin_name(dev, selector, buf, sizeof(buf))); \
+	ut_asserteq_str(expected, (char *)&buf); \
+} while (0)
+
+static int dm_test_scmi_pinmux(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19",
+					      &dev));
+	ut_assertok(pinctrl_select_state(dev, "default"));
+	test_muxing(0, "<unknown>");
+	test_muxing(1, "<unknown>");
+	test_muxing(2, "I2S.");
+	test_muxing(3, "I2S.");
+	test_muxing(4, "I2S.");
+	test_muxing(5, "GPIO bias-pull-up.");
+	test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
+	test_muxing(7, "GPIO bias-pull-down input-mode.");
+	test_muxing(8, "GPIO bias-disable.");
+
+	ut_assertok(pinctrl_select_state(dev, "alternate"));
+	test_muxing(0, "I2C drive-open-drain.");
+	test_muxing(1, "I2C drive-open-drain.");
+	test_muxing(2, "SPI.");
+	test_muxing(3, "SPI.");
+	test_muxing(4, "SPI.");
+	test_muxing(5, "CS bias-pull-up.");
+	test_muxing(6, "CS drive-open-drain output-mode output-value.");
+	test_muxing(7, "GPIO bias-pull-down input-mode.");
+	test_muxing(8, "GPIO bias-disable.");
+
+	ut_assertok(pinctrl_select_state(dev, "0"));
+	test_muxing(0, "I2C drive-open-drain.");
+	test_muxing(1, "I2C drive-open-drain.");
+	test_muxing(2, "I2S.");
+	test_muxing(3, "I2S.");
+	test_muxing(4, "I2S.");
+	test_muxing(5, "GPIO bias-pull-up.");
+	test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
+	test_muxing(7, "GPIO bias-pull-down input-mode.");
+	test_muxing(8, "GPIO bias-disable.");
+
+	return 0;
+}
+
+DM_TEST(dm_test_scmi_pinmux, UT_TESTF_SCAN_FDT);
-- 
2.34.1

