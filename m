Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9EFC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DDA8363C;
	Sat, 24 May 2025 01:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jy24mY0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F2483416; Sat, 24 May 2025 00:59:24 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5F88338C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso398324b3a.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041161; x=1748645961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7vM9eXVVetOU2RTYxoukHh7g5LF1YG76H+8sBBj5Hc=;
 b=jy24mY0G8DNYaP/DH4Bx1q1UzPrhUYNHtqnjBYnw7h3ccyZc+1lXJGLbfAREnebi4W
 icw6B6Dgiw0UFV/2r5/lCxIRA/AI9h8Ag5VXt3DceIgfm7JchgDQOWmTu5TpppSVVkzi
 6KYunQ/jnb3L0E4NUVpL7IuTbozDC80r3usbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041161; x=1748645961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7vM9eXVVetOU2RTYxoukHh7g5LF1YG76H+8sBBj5Hc=;
 b=GU3Om8xjWzQsm++Lc3DgOCuuTsn1mhAdXlQNM1/fkx3v6BnY7ephGfC/EtVciv4DnF
 kpcoKTres6fvUiO/dc2IcjvGnSlqjvGXzZrYq3OJCPSmWq8cu0uCpWeUhlLmlrR834bJ
 xtEDDKmg9BJp8ErrzYPvTtjJbw9i8dZ3gnlKcdCdcRSXF95INlNqf/skYQOBO0rQT8xx
 IJrHozekMtFhJgLanqcEyuk7Ho5uQbdze8H/g1Mr8nSObURsufRz3PAENbZHmT6tj7fo
 oW5yrpghdhZgeOroscr/UBvLrqSt33tl+W63cD5WEz4d9ZbxDjTQFs2qi41XFUhPa+Pd
 70gg==
X-Gm-Message-State: AOJu0YyusG/QwRFSHVBMVsRkl2LVt1H2W+GxnafDiQg9Ptp4IXwUNGEj
 FddRou/xc3VyCbQB9OkQuCA19C10j16WjYJpicxZag15QZZ6Ml9fPcua8/HY//nVnPRfe4ftnzP
 Oq1E=
X-Gm-Gg: ASbGnct0E1h7peov5iHjgb0CCoLw+wjFfrc535breiP/uPjTt3xSXr35Jyyq7OfL/o9
 B5Hb7709dscHTlrCPUtF9Sgi68jOU2eUsz9PCvIj+yfOoUZ+bantgP89R3oB/oC5JQtd/a8Gupn
 vjqk5YSoynbFJmxGuH6rvbo/PIdDXygz8HATgXBRFfHs0vj1y3Hue0ZTyn7qmLYm29mNAnhO0K0
 OnqJWFErz3rspTo3+b85RNidcT/ho8NUYj9EanGrPDiwo82FzT1siB2X1ZixoG2hjFEHXIdh4cU
 QFLUZrEENOmVENUBbF1n6/FCfhue+rclXLwP03jwFfhvP2Mbe6T5IFpS1jjB3UoFTsPRDzLVntw
 0+Y8VqoKKF4HAtR0=
X-Google-Smtp-Source: AGHT+IFeXJv8K4AW1imUAs7XEb86haMf8NEavJBzkidq8a7jC64KyGdNLBwrNOte/6dNQNhFWnixYg==
X-Received: by 2002:a05:6a21:3992:b0:1ee:d8c8:4b82 with SMTP id
 adf61e73a8af0-2188c327f47mr1863885637.31.1748041160838; 
 Fri, 23 May 2025 15:59:20 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a987677dsm13740832b3a.132.2025.05.23.15.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:20 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 22/28] mach-snapdragon: Support booting as a coreboot
 payload
Date: Fri, 23 May 2025 15:58:37 -0700
Message-ID: <20250523225845.2311989-23-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Coreboot sets up the DRAM, CPU, and devices before booting a payload,
meaning we can parse the coreboot tables at boot for memory info when
running as a payload. Use the memory descriptors from coreboot if the
tables are present so that Snapdragon SoCs can run U-boot as a coreboot
payload.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/mach-snapdragon/board.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d323789..6850f226f8eb 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/system.h>
+#include <cb_sysinfo.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
@@ -48,6 +49,10 @@ static struct {
 
 int dram_init(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_dram_init();
+#endif
 	/*
 	 * gd->ram_base / ram_size have been setup already
 	 * in qcom_parse_memory().
@@ -81,8 +86,21 @@ static void qcom_configure_bi_dram(void)
 	}
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_board_get_usable_ram_top(total_size);
+#endif
+	return gd->ram_top;
+}
+
 int dram_init_banksize(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_dram_init_banksize();
+#endif
 	qcom_configure_bi_dram();
 
 	return 0;
@@ -235,6 +253,11 @@ int board_fdt_blob_setup(void **fdtp)
 		ret = qcom_parse_memory(external_fdt);
 	}
 
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		debug("Using coreboot tables for memory ranges\n");
+	else
+#endif
 	if (ret < 0)
 		panic("No valid memory ranges found!\n");
 
-- 
Sent by a computer, using git, on the internet

