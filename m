Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA08D0D171
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC3F840C1;
	Wed,  7 Jan 2026 21:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="inLEKZXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4C183A1E; Wed,  7 Jan 2026 21:19:21 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20E7839A5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso1607422a91.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817157; x=1768421957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaNjLAo2i8ZdKzub7beyyFCaDiCOAeEEOGpmSWAyP7E=;
 b=inLEKZXyUW1pokfRfRQ0rFVlLm400FzL8QprDzrohwzo4fNKojbK9pPNgd8Ds26FjQ
 lqQReifazXVWTm/JvYLbOr3trgBbQwa17Ji28boMWzUvPGhbq19nmnrwGIRiGstmmDcZ
 QTblRKINRtoIsDz2iNZXy0P/v9rVLFGm3ols7ds+ZNPsPFPR//PTB8shnxBPpQDpEnAb
 GYsxK+qN+S5JXWWwN5XPFx01ij6OASiLHqzllwMjXjAJIE2EdKcAcdZkM7iqI5Ivgwup
 GkQ/vCcurAIPp5n0I/BL3p0dlLZg9YUXJZs3GqSVUY8OdnsXKQuW4LsmPt0lrn9+1UBS
 P4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817157; x=1768421957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PaNjLAo2i8ZdKzub7beyyFCaDiCOAeEEOGpmSWAyP7E=;
 b=xOCiKfBxeHt5/r8dSNXgCYBm2smt/IlqT9wFnxWCx2VZ4L+lp+82OwukbV7yOvDD2B
 ZaV90MVWmvCVrsHKwXbRwufPpuT8SVxFLX6Pvg9PxKnNIYcDSlFJDPdwLK9Ew8eWv44Y
 MAnAlaiPhGLYjuaa5nE+4Oc3PeKo+NMd1f+Q2rL/ArJx6CRFmStL/lAsjZYoIZX1AoG0
 PbEpHzC07cfkZIWgSOGE5iwLVemTH+E5C4BPGLou4wooXIYxFemWjp2Y/n172ehSXJhS
 6WrhJZTFbydsYxImdQwhXgCz/4FYZtHxxRWHkoSU/JlvXxhYVUkohMzDKA2OEkSDE5wm
 ZwpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQkzUW6Bg2X2vMCHpjiFZMm+teoYWRTfpPO/yBnL4/gWcI2mt+DRFPBvDzv6GTigj5Ttfgk0I=@lists.denx.de
X-Gm-Message-State: AOJu0Yzrc+Q3efD+F6JlY9e3spMCYu502cEsRKxRE9a8IUV0bJR7jgPq
 zk5+jvcSU0Oubn4R+YnNwrLYeRFO5oNVq8ZXYUNfjgb2BOrZMBYn2WEQ
X-Gm-Gg: AY/fxX4aRjSxhWkgpHuPcNGTwTjFoVPgyYddYynS7XEq6l0Ss+o6ygTcVTqZO96zKUM
 34kvCYLR2hcs+8L5+OjeuQ4BLaG7bHoMn1Pp1YREOJbJGCDv9P6AWc0J9fgjTF638/NYZJdntgz
 ciIIH3b2n5AxfUyIzN2KmM+fdc8iKH6MJNja+CCmsWbHj/NKMF1rBb/4rU1sOOz3RBbfr02gWOi
 8zji1JZIr3sl67pYj9pP0D7duEk2tMY5zFHzA6EOKGtG1cogWHMrkv3z3tX/o20f6kn4lq/Nnnq
 RFwiRQovdYqQJB+cQvOrCvnxOBFl9hTfJvue4hjPDANDudgp6wsTstyHlfVXL+Rtt10KEyY9Uqk
 pRyhKUcY0xXvbUj+H4eDdX+ATf6ATO+vkVvK0Z9zbiS4q9/fBlefhrjvKFCHTEX6CrSo7Bmeozc
 mPZJNfyrP3vuKC6uKtQYN+w8+LY9LZiKnvPQ9RV95kXdVw6VvN6d40b8n/mFTZklNrOYNp++P+J
 8oI2csoeCR2syZc+3r1Rw==
X-Google-Smtp-Source: AGHT+IHMcJDOpvLlqDo9QcsYwy+gzgH4HLrBeGeVu1IEdV2UBCkqdIdm2vSZDNOLNsdCwUDNm4hPTg==
X-Received: by 2002:a17:90b:5830:b0:34c:ab9b:76d6 with SMTP id
 98e67ed59e1d1-34f68cb8efemr3115215a91.25.1767817157332; 
 Wed, 07 Jan 2026 12:19:17 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:16 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v6 4/8] sysreset: Add QEMU virtual system controller driver
Date: Wed,  7 Jan 2026 20:18:33 +0000
Message-ID: <20260107201838.3448806-5-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:33 +0100
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

Introduce a new sysreset driver for the QEMU Virtual System Controller.
This device is found on QEMU "virt" machines (such as the m68k virt
target) and provides a mechanism to trigger system reset and power-off
events.

The driver maps U-Boot sysreset types to the corresponding controller
commands:
- SYSRESET_WARM / SYSRESET_COLD -> VIRT_CTRL_CMD_RESET
- SYSRESET_POWER_OFF -> VIRT_CTRL_CMD_HALT

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v6:
- Introduce new driver to replace board-file reset implementation.

 MAINTAINERS                                |  6 +++
 drivers/sysreset/Kconfig                   |  8 ++++
 drivers/sysreset/Makefile                  |  1 +
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 55 ++++++++++++++++++++++
 include/qemu_virt_ctrl.h                   | 13 +++++
 5 files changed, 83 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qemu_virt_ctrl.c
 create mode 100644 include/qemu_virt_ctrl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efecb213be7..34081769ecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1598,6 +1598,12 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc85xx.git
 F:	arch/powerpc/cpu/mpc85xx/
 
+QEMU VIRTUAL SYSTEM CONTROLLER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	drivers/sysreset/sysreset_qemu_virt_ctrl.c
+F:	include/qemu_virt_ctrl.h
+
 RAW NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
 M:	Michael Trimarchi <michael@amarulasolutions.com>
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 0181f6cd581..120e7510f15 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -298,6 +298,14 @@ config SYSRESET_QCOM_PSHOLD
 	help
 	  Add support for the system reboot on Qualcomm SoCs via PSHOLD.
 
+config SYSRESET_QEMU_VIRT_CTRL
+	bool "QEMU Virtual System Controller support"
+	depends on SYSRESET
+	help
+	  Enable support for the QEMU Virtual System Controller.
+	  This device is used in QEMU machines (e.g. m68k virt) to trigger
+	  system reset and poweroff events.
+
 endif
 
 endmenu
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index f5c78b25896..d18a5d52360 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
+obj-$(CONFIG_SYSRESET_QEMU_VIRT_CTRL) += sysreset_qemu_virt_ctrl.o
diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
new file mode 100644
index 00000000000..e7cacc9b6e9
--- /dev/null
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * QEMU Virtual System Controller Driver
+ */
+
+#include <dm.h>
+#include <qemu_virt_ctrl.h>
+#include <sysreset.h>
+#include <asm/io.h>
+#include <linux/err.h>
+
+/* Register offsets */
+#define VIRT_CTRL_REG_FEATURES  0x00
+#define VIRT_CTRL_REG_CMD       0x04
+
+/* Commands */
+#define VIRT_CTRL_CMD_NOOP      0x00
+#define VIRT_CTRL_CMD_RESET     0x01
+#define VIRT_CTRL_CMD_HALT      0x02
+#define VIRT_CTRL_CMD_PANIC     0x03
+
+static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct qemu_virt_ctrl_plat *plat = dev_get_plat(dev);
+	u32 val;
+
+	switch (type) {
+	case SYSRESET_WARM:
+	case SYSRESET_COLD:
+		val = VIRT_CTRL_CMD_RESET;
+		break;
+	case SYSRESET_POWER_OFF:
+		val = VIRT_CTRL_CMD_HALT;
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops qemu_virt_ctrl_ops = {
+	.request = qemu_virt_ctrl_request,
+};
+
+U_BOOT_DRIVER(sysreset_qemu_virt_ctrl) = {
+	.name = "sysreset_qemu_virt_ctrl",
+	.id = UCLASS_SYSRESET,
+	.ops = &qemu_virt_ctrl_ops,
+	.plat_auto = sizeof(struct qemu_virt_ctrl_plat),
+};
diff --git a/include/qemu_virt_ctrl.h b/include/qemu_virt_ctrl.h
new file mode 100644
index 00000000000..05aad82b767
--- /dev/null
+++ b/include/qemu_virt_ctrl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef _QEMU_VIRT_CTRL_H_
+#define _QEMU_VIRT_CTRL_H_
+
+struct qemu_virt_ctrl_plat {
+	phys_addr_t reg;
+};
+
+#endif /* _QEMU_VIRT_CTRL_H_ */
-- 
2.52.0.457.g6b5491de43-goog

