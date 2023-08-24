Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B857C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDCA86A01;
	Thu, 24 Aug 2023 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5a+OoDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E10869FB; Thu, 24 Aug 2023 21:27:05 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959D7869B1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff9abf18f9so217807e87.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905222; x=1693510022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vr9n0P0qVMY+WYRHd5Ub+DS0AQa6+rIqHwGr+l+6Rho=;
 b=P5a+OoDPn2GvK57aqwPkdfxQiUjciyHlxbYYor7tIB3Qn+eV/kyQtVSP6wLXR9xRLQ
 WxC0ZkkZMOMcPnEZxyDQHl9RNn752+zpDql6ZRK1zJau8BEOXCLjIHdlqG1KtTg9x0Tg
 lzD4WwO1Xem98aAnoEmH5qHASRKKX7apZjBuCSe9wT8Bem8n4pI1VzOy/MFAoRfx9dBd
 965hgwxnY7yxPOzQ98WHRE1tg5pAn/WSiduhm4MMnrgPkCi8GT2maeQnpk3RO8gtwdvN
 UPdcv3YlCdZAuLxzjHHWqy3rJIRV0SjCVQ+Gd33CNmxlgm1nW1rNGytCFp1ItH0q1bUn
 7zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905222; x=1693510022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vr9n0P0qVMY+WYRHd5Ub+DS0AQa6+rIqHwGr+l+6Rho=;
 b=F+o8nhqbp9+W2ygy334Fh75T8EgPLiuo1X3pt6Qz6n/0T3GB9QoucUU5WKEsAZH2G/
 8ksMvhTZt8ur3alIG23s93y7NE3HB79iUO09HFT7IRyvnZ+ttS9JaaRtXUOl3aaU4zdb
 TEKEKrWsrDbTObSOTs6kCIZQ/ZwywaQsek726Q8V7aL+VW/HL8A+IwUblGQUqqxFnl52
 /86/iaGP+Ec11HaTeFvrrVruUVsE4nty9taV8jelBBE3oduO0MVxw8q0PQFHHy0RTtWp
 N3h8zUt0LZxYzqxApw1VzBzLMfFyrMD7gnWLVdPj/nxH2pt/sCWr4C9LSs89DV15oMxY
 S8IA==
X-Gm-Message-State: AOJu0YyKpqVDfuc/e4nsrss5XDo2uOkBHZBt8afcTOce44BsNW17Atoh
 NXW2TGuwA4UsB3VR6nQwRzUZ/5tCtejn4g==
X-Google-Smtp-Source: AGHT+IHUYyvzB+MXk1hImTJdJoGW32BJSN2bNI0b5zRLWqScK1gmmmQjo5QGgiVyPlMpWtq+wWCJvQ==
X-Received: by 2002:a05:6512:3ca1:b0:500:7d05:552a with SMTP id
 h33-20020a0565123ca100b005007d05552amr12487436lfv.53.1692905221684; 
 Thu, 24 Aug 2023 12:27:01 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:27:01 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 14/16] ARM: tegra: board2: add generic late init
Date: Thu, 24 Aug 2023 22:26:01 +0300
Message-Id: <20230824192603.240104-15-clamor95@gmail.com>
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

Board specific late init allows vendors to set up different device
or board specific env variables (like serial number, platform name).
In case this information is missing, u-boot will lack info regards
serial or platform.

To avoid this prior nvidia_board_late_init internal generic function
is called which fills required data. In this case platform name is
obtained from get_chip and serialno is filled with SoC id.

Though SoC id is not dedicated to be devices serial but it fits well
in case of restriction of data about device and since SoC is basically
a main chip of the device.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Transformers
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/mach-tegra/board2.c | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 981768bb0e..cd405874d3 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -26,6 +26,10 @@
 #include <asm/arch-tegra/gpu.h>
 #include <asm/arch-tegra/usb.h>
 #include <asm/arch-tegra/xusb-padctl.h>
+#ifndef CONFIG_TEGRA186
+#include <asm/arch-tegra/fuse.h>
+#include <asm/arch/gp_padctrl.h>
+#endif
 #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
 #include <asm/arch/clock.h>
 #endif
@@ -256,6 +260,37 @@ int board_early_init_f(void)
 }
 #endif	/* EARLY_INIT */
 
+#ifndef CONFIG_TEGRA186
+static void nvidia_board_late_init_generic(void)
+{
+	char serialno_str[17];
+
+	/* Set chip id as serialno */
+	sprintf(serialno_str, "%016llx", tegra_chip_uid());
+	env_set("serial#", serialno_str);
+
+	switch (tegra_get_chip()) {
+	case CHIPID_TEGRA20:
+		env_set("platform", "tegra20");
+		break;
+	case CHIPID_TEGRA30:
+		env_set("platform", "tegra30");
+		break;
+	case CHIPID_TEGRA114:
+		env_set("platform", "tegra114");
+		break;
+	case CHIPID_TEGRA124:
+		env_set("platform", "tegra124");
+		break;
+	case CHIPID_TEGRA210:
+		env_set("platform", "tegra210");
+		break;
+	default:
+		return;
+	}
+}
+#endif
+
 int board_late_init(void)
 {
 #if defined(CONFIG_TEGRA_SUPPORT_NON_SECURE)
@@ -268,6 +303,14 @@ int board_late_init(void)
 #endif
 	start_cpu_fan();
 	cboot_late_init();
+
+	/*
+	 * Perform generic env setup in case
+	 * vendor does not provide it.
+	 */
+#ifndef CONFIG_TEGRA186
+	nvidia_board_late_init_generic();
+#endif
 	nvidia_board_late_init();
 
 	return 0;
-- 
2.39.2

