Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28B4C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5908588BE3;
	Fri,  2 Aug 2024 21:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aaOim4vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CD088BF5; Fri,  2 Aug 2024 21:19:02 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC7B88BE0
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77ec5d3b0dso988395966b.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626340; x=1723231140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TFkvT0cb3r8p1lt1Rqp70bP6AQ3Ff7xbbDucAJlm20=;
 b=aaOim4vvfRTaEmcnnvKm4Ebd+s6boLD13RD3LNZa1te9EWSuxhaKHMc7fCaaOEEWHE
 7mPQRowjMf/pcCQzbJx7hnzmEht7OvJ6LTV53WquJeTMCqMiupyFWL2H4GexbRtMMMpM
 5tpZX38WVgdi0cAwb86AVqvyPgu+9UjZFEOP6o/QWuzfu0X65PMj1IzBxifVmHbYaFIN
 tfwJHUyNYgwvErxxGU/O6vDV/Acxke7PBTXuFNJMTorKk4OPLcG1YgfHmjjbamOa4q14
 lJRPxNjcpzMKlnWtIJggk/iar7pWu7ZyqqGtALBXWjS0Cad+J/9JacGMaUsuOhPB8sd5
 wsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626340; x=1723231140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TFkvT0cb3r8p1lt1Rqp70bP6AQ3Ff7xbbDucAJlm20=;
 b=m78AjgeIJ/Pon4Giq2kIW9iDB5s+ejeZ4rMxAQPzIUg35JAb9NVHRnkCaXSuhTNEVF
 o1C4YAp2VKkr7Fp8QQgPLV/Uv6cjx7ELqDPULLn2N7heBVDleEdLQm9OAf2lDUFPASg7
 iTw3Ih7nlLeQNDAQX8RtsASLEQgNZQ8fBPrzl6L5pcgeHIfJVAcn4YmM+3iWeMYSLwyU
 oHUJrtVaid0hbtqz2BkkQk2oPofOxum1mdEFNtRbGIzb4GVnLZ/ouXVKGCl5g7v8Z7wH
 SwkowUG0ZblLRbntGIxxh8vOqSbEhfUaycPASkFvEN0fNUdv1bH/BiJkYMLpcD8usLUA
 NXIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKC1SwGGgRik2MHV+la4tOfjgcYPK8+eqKovovkrTW4PGHJoJnuciOd9m5VDtHkBWVO+AiJCbzBuMV1Fp94BtYGekynw==
X-Gm-Message-State: AOJu0YzwkFHy1UP4NRCZvujplsw8r9Cg7g0juhA1HW/tRsNg2LUfMr84
 MLtSU8lP4v5MPX+d+sfjgJo8Mytp5V+rHjAiZQhxc172Y2VEL5DR
X-Google-Smtp-Source: AGHT+IFCqmaCqzA8dfPi8Gd3gxKe+2V089FQSqVY6cmoeIxPeF3JdyC2kbH+abmDKL1JK3R5qKEamw==
X-Received: by 2002:a17:907:94c4:b0:a7a:a3db:c7b3 with SMTP id
 a640c23a62f3a-a7dc4e47551mr296577466b.19.1722626339239; 
 Fri, 02 Aug 2024 12:18:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e8383dsm130128066b.173.2024.08.02.12.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:18:58 -0700 (PDT)
From: David Virag <virag.david003@gmail.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Virag <virag.david003@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] i2c: samsung: Drop s3c24x0 specific code.
Date: Fri,  2 Aug 2024 21:19:15 +0200
Message-ID: <20240802191920.132133-2-virag.david003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802191920.132133-1-virag.david003@gmail.com>
References: <20240802191920.132133-1-virag.david003@gmail.com>
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
2.46.0

