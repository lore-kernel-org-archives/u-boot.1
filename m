Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833A4C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB2F87A7A;
	Mon,  8 Jan 2024 11:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HrSi1wZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F75787A76; Mon,  8 Jan 2024 11:50:58 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143F787A60
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a28a997f3dfso120489066b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711054; x=1705315854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwXC/xsWQeYiM4WGhh31SfRAOMsCCyOdXDLiXP6/Vfs=;
 b=HrSi1wZYHolfgd+z1NZ44EnUlfhBZy3yFMrPMyZYCv4yCt/TPhSukBGoZ09emikgMH
 m3b9mqO+fAAAqlPqwA5e80ginIS89cCRhoO6g+a2BhC6HImCRIl1/pNVtIakWrJyr2Dk
 szn/712i2eWZ3WlxNt4PDLM+YOf1S9Q8QMIiWEnuD3MvJqG4tccPwCZb1capAQUomobx
 IUpgfeI6GX9vLAlF1PBmH2GPBjjJTERZWOLCwFhepLfDOhk6MdoaGjNJKbNuYv3iQtzQ
 NISWD5ZI+fdwESjq36XPQZzyscwfNXilPLyi6gSdn633vBC8+sZmpjU/8XHpigUululP
 5cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711054; x=1705315854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwXC/xsWQeYiM4WGhh31SfRAOMsCCyOdXDLiXP6/Vfs=;
 b=n+ns2z+7dhyMbbNYuFoJCYYVZYlMKKdMn/n18UxJNlIjf8b6Wf2vUeATgeDIf6z/oS
 AAE09+2mwLI/53XCicwu0Nog8oJx+INYVSqk8vZjjmI0qhasbgEu8DfzP9T5hJwVOdQx
 UZOLQcIUz3/3p4QHf2QJr3NWId79UcVfLG+/G9/vTIedfXwZxveSqOoNv1B5mDJZ18yO
 E546ZV+HSFsgIGyc20H5mXduWLAvLH0uU3SXu0irhdezq24SFejDxEwO8APil9V4SMZq
 B8SLLADuVM4O2SaAX+rXY69kz64k56GO1qFi6QJ1xtwh2cSpXCejvG1z/7GaW/mYmnaV
 eiVQ==
X-Gm-Message-State: AOJu0YyQSqEv/qrV6YWKn7ud6nQG928ooNGCq9ZzzKZSrc462/cDTDOM
 bezpZnFZsmCGc8t9eDg6GvuwqZdVGyFD6YXY
X-Google-Smtp-Source: AGHT+IE9YybHPn4hbcuRHAjK7+FVOgNVRQlWBy6+DptJ7trmS8YG+RDsLcnYx00HP28/AoYKEYH0uQ==
X-Received: by 2002:a17:906:378e:b0:a28:e03f:36e9 with SMTP id
 n14-20020a170906378e00b00a28e03f36e9mr1463649ejc.25.1704711054469; 
 Mon, 08 Jan 2024 02:50:54 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 26-20020a170906309a00b00a26ae4fb50asm3821141ejv.89.2024.01.08.02.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:50:54 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/9] video: tegra20: consolidate DC header
Date: Mon,  8 Jan 2024 12:49:55 +0200
Message-Id: <20240108105002.243149-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108105002.243149-1-clamor95@gmail.com>
References: <20240108105002.243149-1-clamor95@gmail.com>
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

Consolidate HD headers and place the result into video/tegra20
since it is used only by devices from this directory.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/dc.h         |  8 ----
 arch/arm/include/asm/arch-tegra114/display.h | 28 -------------
 arch/arm/include/asm/arch-tegra20/display.h  | 28 -------------
 arch/arm/include/asm/arch-tegra30/display.h  | 28 -------------
 drivers/video/tegra20/tegra-dc.c             |  3 +-
 drivers/video/tegra20/tegra-dc.h             | 41 ++++++++++++++++++++
 drivers/video/tegra20/tegra-dsi.c            |  2 +-
 drivers/video/tegra20/tegra-pwm-backlight.c  |  3 +-
 8 files changed, 46 insertions(+), 95 deletions(-)
 delete mode 100644 arch/arm/include/asm/arch-tegra114/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/video/tegra20/tegra-dc.h

diff --git a/arch/arm/include/asm/arch-tegra/dc.h b/arch/arm/include/asm/arch-tegra/dc.h
index 7613d84f22..6444af2993 100644
--- a/arch/arm/include/asm/arch-tegra/dc.h
+++ b/arch/arm/include/asm/arch-tegra/dc.h
@@ -569,12 +569,4 @@ enum {
 #define DC_N_WINDOWS			5
 #define DC_REG_SAVE_SPACE		(DC_N_WINDOWS + 5)
 
-#define TEGRA_DSI_A		"dsi@54300000"
-#define TEGRA_DSI_B		"dsi@54400000"
-
-struct tegra_dc_plat {
-	struct udevice *dev;		/* Display controller device */
-	struct dc_ctlr *dc;		/* Display controller regmap */
-};
-
 #endif /* __ASM_ARCH_TEGRA_DC_H */
diff --git a/arch/arm/include/asm/arch-tegra114/display.h b/arch/arm/include/asm/arch-tegra114/display.h
deleted file mode 100644
index 9411525799..0000000000
--- a/arch/arm/include/asm/arch-tegra114/display.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
-#define __ASM_ARCH_TEGRA_DISPLAY_H
-
-#include <asm/arch-tegra/dc.h>
-
-/* This holds information about a window which can be displayed */
-struct disp_ctl_win {
-	enum win_color_depth_id fmt;	/* Color depth/format */
-	unsigned int	bpp;		/* Bits per pixel */
-	phys_addr_t	phys_addr;	/* Physical address in memory */
-	unsigned int	x;		/* Horizontal address offset (bytes) */
-	unsigned int	y;		/* Veritical address offset (bytes) */
-	unsigned int	w;		/* Width of source window */
-	unsigned int	h;		/* Height of source window */
-	unsigned int	stride;		/* Number of bytes per line */
-	unsigned int	out_x;		/* Left edge of output window (col) */
-	unsigned int	out_y;		/* Top edge of output window (row) */
-	unsigned int	out_w;		/* Width of output window in pixels */
-	unsigned int	out_h;		/* Height of output window in pixels */
-};
-
-#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
diff --git a/arch/arm/include/asm/arch-tegra20/display.h b/arch/arm/include/asm/arch-tegra20/display.h
deleted file mode 100644
index e7b3cffd46..0000000000
--- a/arch/arm/include/asm/arch-tegra20/display.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
-#define __ASM_ARCH_TEGRA_DISPLAY_H
-
-#include <asm/arch-tegra/dc.h>
-
-/* This holds information about a window which can be displayed */
-struct disp_ctl_win {
-	enum win_color_depth_id fmt;	/* Color depth/format */
-	unsigned	bpp;		/* Bits per pixel */
-	phys_addr_t	phys_addr;	/* Physical address in memory */
-	unsigned	x;		/* Horizontal address offset (bytes) */
-	unsigned	y;		/* Veritical address offset (bytes) */
-	unsigned	w;		/* Width of source window */
-	unsigned	h;		/* Height of source window */
-	unsigned	stride;		/* Number of bytes per line */
-	unsigned	out_x;		/* Left edge of output window (col) */
-	unsigned	out_y;		/* Top edge of output window (row) */
-	unsigned	out_w;		/* Width of output window in pixels */
-	unsigned	out_h;		/* Height of output window in pixels */
-};
-
-#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
diff --git a/arch/arm/include/asm/arch-tegra30/display.h b/arch/arm/include/asm/arch-tegra30/display.h
deleted file mode 100644
index 9411525799..0000000000
--- a/arch/arm/include/asm/arch-tegra30/display.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- *  (C) Copyright 2010
- *  NVIDIA Corporation <www.nvidia.com>
- */
-
-#ifndef __ASM_ARCH_TEGRA_DISPLAY_H
-#define __ASM_ARCH_TEGRA_DISPLAY_H
-
-#include <asm/arch-tegra/dc.h>
-
-/* This holds information about a window which can be displayed */
-struct disp_ctl_win {
-	enum win_color_depth_id fmt;	/* Color depth/format */
-	unsigned int	bpp;		/* Bits per pixel */
-	phys_addr_t	phys_addr;	/* Physical address in memory */
-	unsigned int	x;		/* Horizontal address offset (bytes) */
-	unsigned int	y;		/* Veritical address offset (bytes) */
-	unsigned int	w;		/* Width of source window */
-	unsigned int	h;		/* Height of source window */
-	unsigned int	stride;		/* Number of bytes per line */
-	unsigned int	out_x;		/* Left edge of output window (col) */
-	unsigned int	out_y;		/* Top edge of output window (row) */
-	unsigned int	out_w;		/* Width of output window in pixels */
-	unsigned int	out_h;		/* Height of output window in pixels */
-};
-
-#endif /*__ASM_ARCH_TEGRA_DISPLAY_H*/
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 7605e77bc1..56733c529a 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -21,7 +21,8 @@
 #include <asm/arch/funcmux.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/pwm.h>
-#include <asm/arch/display.h>
+
+#include "tegra-dc.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra20/tegra-dc.h
new file mode 100644
index 0000000000..5c05221038
--- /dev/null
+++ b/drivers/video/tegra20/tegra-dc.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  (C) Copyright 2010
+ *  NVIDIA Corporation <www.nvidia.com>
+ */
+
+#ifndef _TEGRA_DC_H
+#define _TEGRA_DC_H
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+/* arch-tegra/dc exists only because T124 uses it */
+#include <asm/arch-tegra/dc.h>
+
+#define TEGRA_DSI_A		"dsi@54300000"
+#define TEGRA_DSI_B		"dsi@54400000"
+
+struct tegra_dc_plat {
+	struct udevice *dev;		/* Display controller device */
+	struct dc_ctlr *dc;		/* Display controller regmap */
+};
+
+/* This holds information about a window which can be displayed */
+struct disp_ctl_win {
+	enum win_color_depth_id fmt;	/* Color depth/format */
+	unsigned int bpp;		/* Bits per pixel */
+	phys_addr_t phys_addr;		/* Physical address in memory */
+	unsigned int x;			/* Horizontal address offset (bytes) */
+	unsigned int y;			/* Veritical address offset (bytes) */
+	unsigned int w;			/* Width of source window */
+	unsigned int h;			/* Height of source window */
+	unsigned int stride;		/* Number of bytes per line */
+	unsigned int out_x;		/* Left edge of output window (col) */
+	unsigned int out_y;		/* Top edge of output window (row) */
+	unsigned int out_w;		/* Width of output window in pixels */
+	unsigned int out_h;		/* Height of output window in pixels */
+};
+
+#endif /* _TEGRA_DC_H */
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index a48f9c85d0..72b91ed26b 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -20,9 +20,9 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/display.h>
 #include <asm/arch-tegra30/dsi.h>
 
+#include "tegra-dc.h"
 #include "mipi-phy.h"
 
 struct tegra_dsi_priv {
diff --git a/drivers/video/tegra20/tegra-pwm-backlight.c b/drivers/video/tegra20/tegra-pwm-backlight.c
index bb677daa8a..5f93f57fe9 100644
--- a/drivers/video/tegra20/tegra-pwm-backlight.c
+++ b/drivers/video/tegra20/tegra-pwm-backlight.c
@@ -15,7 +15,8 @@
 
 #include <asm/io.h>
 #include <asm/gpio.h>
-#include <asm/arch/display.h>
+
+#include "tegra-dc.h"
 
 #define TEGRA_DISPLAY_A_BASE		0x54200000
 #define TEGRA_DISPLAY_B_BASE		0x54240000
-- 
2.40.1

