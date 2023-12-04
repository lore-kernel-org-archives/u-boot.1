Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C32C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65B887888;
	Mon,  4 Dec 2023 09:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTSkL2vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15061878B2; Mon,  4 Dec 2023 09:02:51 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855808789F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so5724721e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701676968; x=1702281768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPk1TJPoGXTMLy6R2BThmxQSlyH3Iaj9FkEQ9c5HbaI=;
 b=jTSkL2vjuc0x0GaHYl8dNBdLfQ3CWHMPaPnvMqsM0zosDa4H8XKUG4Ho8cqDoOd9HD
 Nw48MLe9ga+P3OdCbDZLE+pPYhfXcOxsVfH8acgtCRL7vinh8rZl6SxkFEZDuejITSLu
 gK4PM0wSy7+YwXd9ec5SXuCdcXJQis5MgrP6ZfrhaClnI10u0/BIOJx3aVeED6x9ZxUi
 y0St5o3ki2MESjbDsu71LPmLLR0vc0exSjt1mmwRd9tdsWUaRVyVkUMlJ5wpVJDYaLtm
 TJm6iGrZyo1nb5Dek5CVNGRCouK+k9rY6lzLoEMXXt9r0SsHCVB/PiFSyX6M6YLQmSSm
 zFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701676968; x=1702281768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPk1TJPoGXTMLy6R2BThmxQSlyH3Iaj9FkEQ9c5HbaI=;
 b=ZHL860+0daLGBo+YHUTpwCpofnyzrzTB8ypjrAfwe5/hT28rFfqlkQQypZzrQqAMRG
 ZbbFU3ONHvvf+RWdH/LLpd3Bz1zy6o+RL3A8zs7TXTh+5xEFQ5jxOkZ29rCsR+HGdLT0
 5/0Vyswb8mORW5jnF/1Fw4sIV+9cCL4WztSHqbVpLGjGH8eh6y+erjt3G5nER1QUzHeR
 +IviuBwRnpNoyHT5zG6tyh+QU77786/3zkNi5nNIJIiS8lIq7smVdfixs2LKLkElBQr8
 qDIg/zq6X0PROQ1LzlCF5Vu40WziG1sFLGNHkjOzxhIY2grV9ZIGZewwuxZn4ZRIPby9
 BVRQ==
X-Gm-Message-State: AOJu0YySUmMCbh1DzOhzsBN0lIguWzM6FnQOzyjAUEOR2TT8ETquUKVh
 YON6tlGCg5q4qCPxpWRCWW4=
X-Google-Smtp-Source: AGHT+IECIFm8M3422zW4xtWuAy8KTgB+sfq4u6CitUlvxTVd1lzdCUXq3hTOS7hTPo4DL+GZ79rk4w==
X-Received: by 2002:a05:6512:2015:b0:50b:f8ff:a5a9 with SMTP id
 a21-20020a056512201500b0050bf8ffa5a9mr360864lfb.87.1701676967386; 
 Mon, 04 Dec 2023 00:02:47 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 v6-20020ac25606000000b0050572fcf1a2sm1183048lfd.283.2023.12.04.00.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:02:46 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] video: tegra20: dc: add T114 support
Date: Mon,  4 Dec 2023 10:02:29 +0200
Message-Id: <20231204080231.4316-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204080231.4316-1-clamor95@gmail.com>
References: <20231204080231.4316-1-clamor95@gmail.com>
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

Existing Tegra DC driver fits perfectly well for Tegra 4 so
let's add a compatible to state this.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra114-u-boot.dtsi            |  9 +++++++
 arch/arm/include/asm/arch-tegra114/display.h | 28 ++++++++++++++++++++
 arch/arm/include/asm/arch-tegra114/pwm.h     | 13 +++++++++
 drivers/video/tegra20/tegra-dc.c             |  1 +
 4 files changed, 51 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-tegra114/display.h
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h

diff --git a/arch/arm/dts/tegra114-u-boot.dtsi b/arch/arm/dts/tegra114-u-boot.dtsi
index 7c11972552..3038227dbe 100644
--- a/arch/arm/dts/tegra114-u-boot.dtsi
+++ b/arch/arm/dts/tegra114-u-boot.dtsi
@@ -1,3 +1,12 @@
 #include <config.h>
 
 #include "tegra-u-boot.dtsi"
+
+/ {
+	host1x@50000000 {
+		bootph-all;
+		dc@54200000 {
+			bootph-all;
+		};
+	};
+};
diff --git a/arch/arm/include/asm/arch-tegra114/display.h b/arch/arm/include/asm/arch-tegra114/display.h
new file mode 100644
index 0000000000..9411525799
--- /dev/null
+++ b/arch/arm/include/asm/arch-tegra114/display.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  (C) Copyright 2010
+ *  NVIDIA Corporation <www.nvidia.com>
+ */
+
+#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
+#define __ASM_ARCH_TEGRA_DISPLAY_H
+
+#include <asm/arch-tegra/dc.h>
+
+/* This holds information about a window which can be displayed */
+struct disp_ctl_win {
+	enum win_color_depth_id fmt;	/* Color depth/format */
+	unsigned int	bpp;		/* Bits per pixel */
+	phys_addr_t	phys_addr;	/* Physical address in memory */
+	unsigned int	x;		/* Horizontal address offset (bytes) */
+	unsigned int	y;		/* Veritical address offset (bytes) */
+	unsigned int	w;		/* Width of source window */
+	unsigned int	h;		/* Height of source window */
+	unsigned int	stride;		/* Number of bytes per line */
+	unsigned int	out_x;		/* Left edge of output window (col) */
+	unsigned int	out_y;		/* Top edge of output window (row) */
+	unsigned int	out_w;		/* Width of output window in pixels */
+	unsigned int	out_h;		/* Height of output window in pixels */
+};
+
+#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
diff --git a/arch/arm/include/asm/arch-tegra114/pwm.h b/arch/arm/include/asm/arch-tegra114/pwm.h
new file mode 100644
index 0000000000..af39151803
--- /dev/null
+++ b/arch/arm/include/asm/arch-tegra114/pwm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Tegra pulse width frequency modulator definitions
+ *
+ * Copyright (c) 2011 The Chromium OS Authors.
+ */
+
+#ifndef __ASM_ARCH_TEGRA114_PWM_H
+#define __ASM_ARCH_TEGRA114_PWM_H
+
+#include <asm/arch-tegra/pwm.h>
+
+#endif	/* __ASM_ARCH_TEGRA114_PWM_H */
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index f53ad46397..20fa4bb27c 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -467,6 +467,7 @@ static const struct video_ops tegra_lcd_ops = {
 static const struct udevice_id tegra_lcd_ids[] = {
 	{ .compatible = "nvidia,tegra20-dc" },
 	{ .compatible = "nvidia,tegra30-dc" },
+	{ .compatible = "nvidia,tegra114-dc" },
 	{ }
 };
 
-- 
2.40.1

