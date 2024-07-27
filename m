Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EA3C3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 17:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739AE88709;
	Sat, 27 Jul 2024 19:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBl81AGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C18188701; Sat, 27 Jul 2024 19:41:17 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B224588718
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 19:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso344243366b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722102075; x=1722706875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNrUlS/Z+kXb/NcWJbTTg/wa0a2cew3xqm1E4XkWHgc=;
 b=RBl81AGwpOtC+NMtNu1qAYlFEEJwjrmnDhnLIFoLAhV6yIILTUETnxyILmEpj2749a
 E7XqsIzGs5Dlq0wuWkL1MXgL8r66Z48WtE0AK6Fkh/f3rwY1iiv2dL6qd1hG4EehgZTn
 al6NuQAcd/6bMi6jOBeniofMLNONB8V/EDdcadTP6DnKrI5OHDwl6qOE7q/0wtnC3IlT
 7/GcDsd1+DY3CbQjKPcUnihsv0P6Z4U+tFN1Pd9X1kfPbWUOFR1Po9R+6VQsB50kDO+s
 v5kLG6qirtAGRAQmbblc8aBsjijs0Ckeu/4+4yrvczdH9OHy5BrU9ibUpBDq0HQD6hIz
 XweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722102075; x=1722706875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNrUlS/Z+kXb/NcWJbTTg/wa0a2cew3xqm1E4XkWHgc=;
 b=DUymgRmxqf+hPLMNNLUCtZAPILsm5oTkjWsy+C276kYaG4W+b9wpgi0jkbICQF2NbD
 ttBYG4vrGa2LPdJ7fzg5YeVEP7J0B6HMh9NNlC+YU/OJLlMQXH3y9M+J8KJPVbSj2MHm
 ftYmc5+l1PVnS2W/aOwRpgzvTwQB/aVw3AxYP3TnKzS7SuWrYQ76HecwnrUsLw2IxOa+
 O1xCO13GbjsKBL3kIvm1e/4hu+NXOP4pbXDfhnMHd7Pc4AnTBPsBCJxYKUEktpDg2lyX
 mVVjdRBRdc1jWq5NWDyxE8elFChqQkXDruqrt2gvCer8ebQpucPGCCfiXIzEF/nUykWS
 lavw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL9zOP8H2lZZNa0IyXfFrR9fWqDK4WHgZ7lBNWnqG5Zi/KeF+mV++B7PTVP2UVs9Q4C4aWuJNeAMSbIg35ZD+Q4PQbEg==
X-Gm-Message-State: AOJu0YzGVhloWawwMeFm8QAt817kotBjkHxkWf9AXTN3CfKia9rGkPBC
 Ocd5nv2D4Lh43jALwUhTJNbnfeRsDV9NdKbkD+t1aQ+DKf8NHWMJ
X-Google-Smtp-Source: AGHT+IGZ3wVTB34mfJDJpS2oESXwGRIv7y6Pom7Shv1osjhA56DSDZDYjIOnWScMlwdOb+D3jRY3cA==
X-Received: by 2002:a17:907:7f12:b0:a7a:bd5a:1eb7 with SMTP id
 a640c23a62f3a-a7d4014ddb1mr188363466b.59.1722102074715; 
 Sat, 27 Jul 2024 10:41:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7acadb8361sm299927466b.207.2024.07.27.10.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 10:41:14 -0700 (PDT)
From: David Virag <virag.david003@gmail.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Virag <virag.david003@gmail.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH 1/2] i2c: samsung: Drop s3c24x0 specific code.
Date: Sat, 27 Jul 2024 19:41:47 +0200
Message-ID: <20240727174152.306827-2-virag.david003@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727174152.306827-1-virag.david003@gmail.com>
References: <20240727174152.306827-1-virag.david003@gmail.com>
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

This has been dead code for many years now. Remove it.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/i2c/exynos_hs_i2c.c | 4 ----
 drivers/i2c/s3c24x0_i2c.c   | 8 --------
 2 files changed, 12 deletions(-)

diff --git a/drivers/i2c/exynos_hs_i2c.c b/drivers/i2c/exynos_hs_i2c.c
index 2ab0bae449..189ce6d509 100644
--- a/drivers/i2c/exynos_hs_i2c.c
+++ b/drivers/i2c/exynos_hs_i2c.c
@@ -145,11 +145,7 @@ static int hsi2c_get_clk_details(struct s3c24x0_i2c_bus *i2c_bus)
 	unsigned int i = 0, utemp0 = 0, utemp1 = 0;
 	unsigned int t_ftl_cycle;
 
-#if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)
 	clkin = get_i2c_clk();
-#else
-	clkin = get_PCLK();
-#endif
 	/* FPCLK / FI2C =
 	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 * FLT_CYCLE
 	 * uTemp0 = (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2)
diff --git a/drivers/i2c/s3c24x0_i2c.c b/drivers/i2c/s3c24x0_i2c.c
index 72d2ab0f73..ae3a801cad 100644
--- a/drivers/i2c/s3c24x0_i2c.c
+++ b/drivers/i2c/s3c24x0_i2c.c
@@ -8,14 +8,10 @@
 #include <dm.h>
 #include <fdtdec.h>
 #include <time.h>
-#if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)
 #include <log.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/pinmux.h>
-#else
-#include <asm/arch/s3c24x0_cpu.h>
-#endif
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <i2c.h>
@@ -53,11 +49,7 @@ static void read_write_byte(struct s3c24x0_i2c *i2c)
 static void i2c_ch_init(struct s3c24x0_i2c *i2c, int speed, int slaveadd)
 {
 	ulong freq, pres = 16, div;
-#if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_ARCH_EXYNOS5)
 	freq = get_i2c_clk();
-#else
-	freq = get_PCLK();
-#endif
 	/* calculate prescaler and divisor values */
 	if ((freq / pres / (16 + 1)) > speed)
 		/* set prescaler to 512 */
-- 
2.45.2

