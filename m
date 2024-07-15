Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C76C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FB3888AC;
	Mon, 15 Jul 2024 12:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="susHVvLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C2288897; Mon, 15 Jul 2024 12:08:58 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451B088853
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so5207191a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038136; x=1721642936; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OF76tLlohvDjPr8qGLbtCRZpdV9zcWQISuqlg021S0o=;
 b=susHVvLV1Ib0h5XAck+GylMCLiT+15E7jUO9QQ608if39mNeS/fN9M7ntXtj9dV0ij
 slz/755yvPvftGn5DsGsS8MtEk8wXGd74JMNLy0kQtvjRmhWh8MXzw6NzSYwvzhqI5xf
 IwBM7n1RMS/EasA4tCn4QzylbDSGC3llR3GZSIxqipilDF9ravlhZ7TX+qOsirxHYckz
 6VVG969hqVU4So+8Z07LS+vmW2c77bfbO0SKedVAf8S8uEDKYDZhoi3uadnJMdLaz8+9
 S6ryMWAB+m/W9nt792ifR2mHIPjKTqvISWdeN8Kw2FHPXchlzqXQbey9jKwAq0TxOSof
 w+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038136; x=1721642936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OF76tLlohvDjPr8qGLbtCRZpdV9zcWQISuqlg021S0o=;
 b=hEaUvvGjYM/1ajvk00HPcxUcz98NTpzauKhDhmw6Hw8DuydQ8+FcVGq/mohH4V8en5
 gld6aqfhAT2oD0yfUHcwmsD1H0gQxEJ/B2wGMjLEkqVpxfQnTYKDm7LiC9pr59JPrP7N
 NA62zYTyqt6Mm0yaIB4dZD5zXLC19ZU+o5An33nqtS22M+uC8vhvHwM1DYhw6+I1ERBL
 2E7/D1mPKgdrG7kEbDcjQjw8jKd/tcLcEjJv4h00wi/+egRrepaozSxpoBLngTWUrwlQ
 4+imq77DRqs7zJC+cqkHi+qBwiMK6evU/i9rvzXa9WBbB5/vqHmEY9z1oVVcDIf2oiTY
 7AAw==
X-Gm-Message-State: AOJu0Yy+KAgdbeBypYLRVt2GnJC6DBmuYKu8aSXxwMQt1KiG3tvFCIi0
 b1UlGoT1PByj4YTHdmyGW4R72rL6++ft5ATglIPKmzxFgYHYTZBIOGbBaFHBJ7o=
X-Google-Smtp-Source: AGHT+IFOfdxbCZQpIq9MLoWxfw1Q9D80Me7vCzFgWRVBi2u5uTWBLZzGtDl6i8q3gIGwNsPEaxltbA==
X-Received: by 2002:a17:906:4f01:b0:a6f:2ee7:b21a with SMTP id
 a640c23a62f3a-a780b89f406mr1261780766b.65.1721038135867; 
 Mon, 15 Jul 2024 03:08:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:22 +0200
Subject: [PATCH v6 23/24] power: regulator: qcom-rpmh-regulator: add build
 infra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-23-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Pso8b/uVAl+mlHoL5Qsl7woxZlxMQtfdivEwIMBQyfo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUHMVeLzjpThGvy6F+v5iPAgNRxeR4Zb3vCz
 IHsJtSL0zCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BwAKCRAFgzErGV9k
 thHTD/9mE6vCqg7ptB2SxBRarFyg78cM6eKgD/SfCefmalLQgljV/exyjkfRIKT7pGN4ecbrqN7
 5TSd1bdLaiFznRU50SYfu5FoORcxonwGC8r80U+vhp4/nE+VqHu31hFcwkXAMO8lAsBxsppUBvo
 0dKly7vXHbyk++q1iJZdbzk+zWQAs7gjvgWcPS5fNY38AmUfPnxTV/1xSqsfibPTuA4XdXv1G4b
 TRtb/YafYJ77uYtXOLZxjTnmV0iOtoR3bTjpdnUjuAaac+rzsr0tSNgY6QXpoHMZLmyXwYMls7m
 xC2nD8RL5aTS45BIyJHhYW0lH6CQnmuCyZ8anj58X2VQIZfo6Qu5aE3sE9IZ9vxnshD9sFIjutq
 LkULwlHyye/uYTtH9rqjGI6a5TPcoPgE6g6r//VZSqxiTOdaEh/X9EGcFW4wXy5Q64h0tqnJQEZ
 6nCcHxPlfH85+KPv6YtzNw54/3ClW+Dc+nsjN3Lyv7Y1X6MXjs5D9c+z/yQ7W7eI3PbB6bRYXfd
 glZJY471VAEtHBkEX37cCcmUCWSg8w+q6K5qsV1GOHBHKer6YRESeCK1N7q1DHzPjq4vj0e2FyY
 vHb5nGSxa9vNuVQXV4vZsqO9/4NmT8y1x5LO/024u+4wwjw7BKxiGvBJSH1M854Lwnd+rsPMfs1
 meoV1q8vr6d0KCg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add Kconfig and Makefile entries for this driver now that it can build
for U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/Kconfig  | 8 ++++++++
 drivers/power/regulator/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 102ec7bc5f89..bc061c20d75e 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -215,8 +215,16 @@ config DM_REGULATOR_GPIO
 	This config enables implementation of driver-model regulator uclass
 	features for gpio regulators. The driver implements get/set for
 	voltage value.
 
+config DM_REGULATOR_QCOM_RPMH
+	bool "Enable driver model for Qualcomm RPMh regulator"
+	depends on DM_REGULATOR && QCOM_RPMH
+	---help---
+	  Enable support for the Qualcomm RPMh regulator. The driver
+	  implements get/set api for a limited set of regulators used
+	  by u-boot.
+
 config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
 	depends on DM_REGULATOR_GPIO && SPL_GPIO
 	select SPL_DM_REGULATOR_COMMON
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index f79932d83307..56a527612b74 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -20,8 +20,9 @@ obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FIXED) += fixed.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
+obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
 obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o

-- 
2.45.2

