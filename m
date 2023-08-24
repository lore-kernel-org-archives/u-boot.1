Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8094FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7A4869F5;
	Thu, 24 Aug 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sclIMiUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECCD869B7; Thu, 24 Aug 2023 21:27:02 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34DAF8698E
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso363745a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905220; x=1693510020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bygunJWYl1ElIdCSMdreG1O6wMAtNDcf5g2o+t8Lc9E=;
 b=sclIMiUMzWVgjm30Wp5pgkcPEBNlcqQdNCWW0bxnQEnHa/6DutWUwHh4yjVshYONIR
 mwGPgyubpXe2aX/8aDm/39u3HcDZCWHvTwoCA23br4A22oRNcnwZB4zFwO1WSfjEbloC
 yOy4882H9a5mnD8lhjukgJsYt9KpNO3n9V1dkQ615jq+ZRVYNvrWLUmIk+4ys2uOlBBW
 0/4QSZ1GJObvcykIAPYGAEchfDvwXRvMf8+STUC+Y6ssqLOaunccqjkbkSRnTBbV/Ju+
 1o/XYf9vYmjBk9Dlr1k1nit3c7ce+duCCoD1WAhGMHjh777DHHv8ZncAyXM+rXl2EFGv
 /LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905220; x=1693510020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bygunJWYl1ElIdCSMdreG1O6wMAtNDcf5g2o+t8Lc9E=;
 b=B746dlN7ZilcrRvdOuW6O6ViWPkggIPUHFDssiZIJb8JfhIgI5nd3QbcmVCG08lU9n
 +gMP0pHXnH3juCkd2VQmND+14ZB8x9l/bL51edoOLzRZuKT1Zdq4+3JKDmZpnSxEBAFi
 B/GHDta75hiQdRD4H+0rL4gIZOhgY8XyrL+dstSnvD/V6QwIkzNHcUPqFmwp7frtBJ5S
 gMViUS/v+7DXXKtjoJiclipzu1WuQf8lmIBWEHXMFwTGXuPE92eatYRbSzdYi1W9l1VP
 5YMO9KTSYxXys58T/KiZGO8yPURw2S+RpzOVzAHiJsFRZRTGGIHOB2Vwb0RVtxuKHZTZ
 d7ZQ==
X-Gm-Message-State: AOJu0YyAZ8bJYM1BXdZ/RfzAyUOMeOLVAf2z/2ERZlGreOIr61pjgx4R
 A/hRKLu6NxafJbw/iQLPxDk=
X-Google-Smtp-Source: AGHT+IHpPJYbUZ/UJ2l6+9T/XK+O4nrs8BZsZqOGWxDJUWDJ5wQUhoBGz0Vts8fn2raT23V6EWWWYQ==
X-Received: by 2002:a05:6402:12cb:b0:528:89d0:90b7 with SMTP id
 k11-20020a05640212cb00b0052889d090b7mr14434371edx.16.1692905219767; 
 Thu, 24 Aug 2023 12:26:59 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 12/16] ARM: tegra114: enable base voltages setup from board
Date: Thu, 24 Aug 2023 22:25:59 +0300
Message-Id: <20230824192603.240104-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Tegra 4, same as Tegra 3, requires configuration of CPU and CORE
voltages in the SPL stage to boot properly. Expose function to be
able perform this configuration in the SPL section of the device
board.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF701T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/tegra114/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra114/cpu.c b/arch/arm/mach-tegra/tegra114/cpu.c
index 62c1053630..7d8f080c31 100644
--- a/arch/arm/mach-tegra/tegra114/cpu.c
+++ b/arch/arm/mach-tegra/tegra114/cpu.c
@@ -13,9 +13,13 @@
 #include <asm/arch/tegra.h>
 #include <asm/arch-tegra/clk_rst.h>
 #include <asm/arch-tegra/pmc.h>
+#include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 #include "../cpu.h"
 
+/* In case this function is not defined */
+__weak void pmic_enable_cpu_vdd(void) {}
+
 /* Tegra114-specific CPU init code */
 static void enable_cpu_power_rail(void)
 {
@@ -254,6 +258,7 @@ void start_cpu(u32 reset_vector)
 
 	/* Enable VDD_CPU */
 	enable_cpu_power_rail();
+	pmic_enable_cpu_vdd();
 
 	/* Get the CPU(s) running */
 	enable_cpu_clocks();
-- 
2.39.2

