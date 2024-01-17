Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2AC47DA7
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:54:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F56687A3D;
	Wed, 17 Jan 2024 08:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UaFtJN+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E12B87A05; Wed, 17 Jan 2024 08:53:22 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B50387A4B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d5e004f592so6922635ad.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477987; x=1706082787;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3yg7/QDQvmiHS7UDVQLOwOXg16lk2OJcIfaxQKx4S0=;
 b=UaFtJN+G+rUyHZ5XM/73yAm968sBVrucTpNqODQySQ80ms6y8fvuUrPaz6bdYUzC37
 iLqCtVjLl07ewKdKq0ia+exvR2QOwSrwKmY4qaogXdKQgETn4+sDYyXbnft8aF918231
 77ZTPJrR3q4GSZstamgb2Qd8vLjNQc4Gq5acM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477987; x=1706082787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3yg7/QDQvmiHS7UDVQLOwOXg16lk2OJcIfaxQKx4S0=;
 b=FFTD7Teq2q3rUrHj2d2LOjT1cuoPbYE5sob88+HfR/KF5++lUWGgdR5NCbUbfZWO82
 uiq370ByRCMLis/CSmjMzEObg7ahzci+rfEH9lGXq8J3FdzcGejmHgdAKgf6vHReEXHS
 9cwb9fq9iScwFFW1QsrrH6puOZnxgSKfOAMuz17uM6krGFlGxwzjQEGySmIgK+h20Aiy
 jDW34BYWJZwDu/EKieAOgHg5nS6jm7ixKeyukN/s77eokjzbuR/yFp+a0p4X99jUhHO3
 /JKubZriT60SJE2q4Vnw/vAzrzQ3pU1pzas3Yhg8usDJ9pznVsS1HN7KkStkkOTiVsUM
 ZDpQ==
X-Gm-Message-State: AOJu0Ywkij2qb90boydRGQkTi/ltxcqKNSAayvCeE2jwtRmqfsAaYXlC
 xXIX2SSG+WyWIG6AD8b84To41ZTl/rOK4g==
X-Google-Smtp-Source: AGHT+IHNp3MvdXAN07TmpHm4xJ5YNRFO/p6lHdwnh0uOFHhGQ5cNNgDqtZ/7lXHuPlHZuZZr2NVXlg==
X-Received: by 2002:a17:902:b198:b0:1d4:748f:d4a with SMTP id
 s24-20020a170902b19800b001d4748f0d4amr4842977plr.36.1705477987410; 
 Tue, 16 Jan 2024 23:53:07 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:53:06 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 13/17] video: rockchip: Add rk3328 vop support
Date: Wed, 17 Jan 2024 13:21:50 +0530
Message-Id: <20240117075154.58747-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

Add support for Rockchip RK3328 VOP.

Require VOP cleanup before handoff to Linux by writing reset values to
WIN registers. Without this Linux VOP trigger page fault as below
[    0.752016] Loading compiled-in X.509 certificates
[    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
[    0.788391] inno-hdmi-phy ff430000.phy: inno_hdmi_phy_rk3328_clk_recalc_rate rate 148500000 vco 148500000
[    0.798353] rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
[    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
[    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
[    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
[    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
[    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
[    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
[    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
[    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v3:
- Add WIN0 disable at remove
Changes for v2:
- Add VOP cleanup
- Update commit

 drivers/video/rockchip/Makefile     |  1 +
 drivers/video/rockchip/rk3328_vop.c | 83 +++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 drivers/video/rockchip/rk3328_vop.c

diff --git a/drivers/video/rockchip/Makefile b/drivers/video/rockchip/Makefile
index 4991303c73..f55beceebf 100644
--- a/drivers/video/rockchip/Makefile
+++ b/drivers/video/rockchip/Makefile
@@ -6,6 +6,7 @@
 ifdef CONFIG_VIDEO_ROCKCHIP
 obj-y += rk_vop.o
 obj-$(CONFIG_ROCKCHIP_RK3288) += rk3288_vop.o
+obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328_vop.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399_vop.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_EDP) += rk_edp.o
 obj-$(CONFIG_DISPLAY_ROCKCHIP_LVDS) += rk_lvds.o
diff --git a/drivers/video/rockchip/rk3328_vop.c b/drivers/video/rockchip/rk3328_vop.c
new file mode 100644
index 0000000000..55233f19ee
--- /dev/null
+++ b/drivers/video/rockchip/rk3328_vop.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
+ */
+
+#include <dm.h>
+#include <video.h>
+#include <asm/io.h>
+#include "rk_vop.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void rk3328_set_pin_polarity(struct udevice *dev,
+				    enum vop_modes mode, u32 polarity)
+{
+	struct rk_vop_priv *priv = dev_get_priv(dev);
+	struct rk3288_vop *regs = priv->regs;
+
+	switch (mode) {
+	case VOP_MODE_HDMI:
+		clrsetbits_le32(&regs->dsp_ctrl1,
+				M_RK3399_DSP_HDMI_POL,
+				V_RK3399_DSP_HDMI_POL(polarity));
+		break;
+	default:
+		debug("%s: unsupported output mode %x\n", __func__, mode);
+	}
+}
+
+static int rk3328_vop_probe(struct udevice *dev)
+{
+	/* Before relocation we don't need to do anything */
+	if (!(gd->flags & GD_FLG_RELOC))
+		return 0;
+
+	return rk_vop_probe(dev);
+}
+
+static int rk3328_vop_remove(struct udevice *dev)
+{
+	struct rk_vop_priv *priv = dev_get_priv(dev);
+	struct rk3288_vop *regs = priv->regs;
+	struct rk3288_vop *win_regs = priv->regs + priv->win_offset;
+
+	/* FIXME: Explicit disabling of WIN0 is needed to avoid iommu
+	 * page-fault in Linux, better handling of iommu-address in
+	 * Linux might drop this.
+	 */
+	clrbits_le32(&win_regs->win0_ctrl0, M_WIN0_EN);
+	writel(0x01, &regs->reg_cfg_done);
+
+	return 0;
+}
+
+struct rkvop_driverdata rk3328_driverdata = {
+	.dsp_offset = 0x490,
+	.win_offset = 0xd0,
+	.features = VOP_FEATURE_OUTPUT_10BIT,
+	.set_pin_polarity = rk3328_set_pin_polarity,
+};
+
+static const struct udevice_id rk3328_vop_ids[] = {
+	{
+		.compatible = "rockchip,rk3328-vop",
+		.data = (ulong)&rk3328_driverdata
+	},
+	{ /* sentile */ }
+};
+
+static const struct video_ops rk3328_vop_ops = {
+};
+
+U_BOOT_DRIVER(rk3328_vop) = {
+	.name	= "rk3328_vop",
+	.id	= UCLASS_VIDEO,
+	.of_match = rk3328_vop_ids,
+	.ops	= &rk3328_vop_ops,
+	.bind	= rk_vop_bind,
+	.probe	= rk3328_vop_probe,
+	.remove = rk3328_vop_remove,
+	.priv_auto	= sizeof(struct rk_vop_priv),
+	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
+};
-- 
2.25.1

