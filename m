Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE818E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B3468745D;
	Tue,  3 Oct 2023 08:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hSDsKsFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325DA87474; Tue,  3 Oct 2023 08:37:12 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF52787282
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50585357903so633427e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315026; x=1696919826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vr9n0P0qVMY+WYRHd5Ub+DS0AQa6+rIqHwGr+l+6Rho=;
 b=hSDsKsFhNqXv77yLXAmunCM1oYht7YdIFnaj/piz48RSIt2CjOg/a797jx9yo8f0h1
 3x+qrGxUwmvzFRle5zwr5PrT6rDwhn8IY3KJix8WDW6Q56sw/rcbwOy91ic0c6ZS/0o3
 TqGcIMnsxpn2Pi8RoraMnJa4mLx7P4oOJ8wslJ0/lGzVDXKYQuAQnQc2+45JCnpkuEJH
 u0M1k9XieckVxFeGKF5kBLjj4Hs0AKFWmvrWhdoCCiGFdgxb3dRo5a4YQBjyPWBN4VQ4
 p54akWElT+Gh5Szx//oWqDyx0mbUmrYVA+MUQIcihiN2JtmFgsj8ar+Ekq1A+VqzW73G
 Rn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315026; x=1696919826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vr9n0P0qVMY+WYRHd5Ub+DS0AQa6+rIqHwGr+l+6Rho=;
 b=L7kbo3v1IP9JU9zRUDFLlxh+RGBVpkj7dAgf6fKO6WH6osYAALfo3sAIU+H74JqgCO
 cEHuN/9U/nK44/GYB2h0uBnG/zazBXN5i2W+KMiFm6vAbL61rAfgGe2uJ0Loa7AWuOB3
 fBsVcjSuI+CQDpoiw0Ijucq7OtMLuywLe6nr3CwxuHK7p+KtSbsbrzsqJOEAKoLfBzHK
 RevIQjzA/OEFHeUsmkAcJaJ7OX2QsiYxOEhbk3JSJUhb/8T4njGt8nxoF2xfqvCGYuUj
 JDC5LpcGjjaTmua1pJX6GgQ+7EipgTzTM5gOBbvi9GileEYAqiC8GdB8sJ02DnqEzeea
 pFOQ==
X-Gm-Message-State: AOJu0YzbkR2LFEveWwSfaBvSjkExhJVUrUkN3fyTPoSCqhaDXHtVBgsl
 njCwrvM3S2kRwNvVrG/5hCM=
X-Google-Smtp-Source: AGHT+IF1MwSsoChGtmibMQPa7JvKeihKdklOror+LIDDNhos7xcXFHbWi57UYpn7BZKQPadgCIpLSw==
X-Received: by 2002:a19:a40a:0:b0:503:9c2:e44e with SMTP id
 q10-20020a19a40a000000b0050309c2e44emr11085108lfc.55.1696315026125; 
 Mon, 02 Oct 2023 23:37:06 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 14/16] ARM: tegra: board2: add generic late init
Date: Tue,  3 Oct 2023 09:36:45 +0300
Message-Id: <20231003063647.42770-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

