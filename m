Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAB3C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01266874CA;
	Mon, 18 Dec 2023 20:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ASnsZ1DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D7B874CA; Mon, 18 Dec 2023 20:12:21 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF955876AE
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28b3dd5b242so1453612a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926737; x=1703531537;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7P2hMlgT8ftQlmSwjIFfsBtacjVO/uifA9s5CHlCH/c=;
 b=ASnsZ1DV7zamG2OZqrhgz0eaWEtaBydTw+vGk3C9cNuK1sINJc9rq+D1C2QpVLvhBo
 ZddS3r0GR4mP4M9ztftpueKa9ms+PvXiYaAZWGdkV5ZRD9C6XDXjs/Kf4vshaOMPUg1A
 VASuqw+cJ8fOcJ5vyUGvYqm6liRbj2EscN8c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926737; x=1703531537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7P2hMlgT8ftQlmSwjIFfsBtacjVO/uifA9s5CHlCH/c=;
 b=mH6W20JCkOiHQGH2XgIg+dKf0ckzut+iQbiR7V1dEMvpUb6TQ8X73HLf4U0yrhpZiw
 l7040OHOjYdHwAuO9OwyxJv4zhIuvpKesbtVxZ9tRPbRvIxm+XLyzca4cXhmGqtIw5bq
 vJz//SannwEO1yzH5WoULrO0hUys75McDQ9Ztidj89XWBgx+oK48azrxv2J4Rs97C4i1
 Ocx4ouHrPh3crKkXzRdAQyLqh6lJxvrDQjN8oszoKoqxJh55Cgnk1HuhPgtE8M++4Fnr
 BAeip30WJedqBLkwGPcpHK5YX5F+J8G5r9OeVOMVnSnVdS/pEjYAdIwffPUFiODwmzSL
 xzLg==
X-Gm-Message-State: AOJu0YzszPPOM10r6+NDOzqfTtPeZQmoTD8OkYXVqPSLrigk1vl2WyAs
 KRz/J1btE8uwSBhGNqHwcvRG1w==
X-Google-Smtp-Source: AGHT+IHTP48xW24jjs+w0y560MsH8InKSZ51w8RweHMlFHFQtbE2UdGtzb2YhDC3+TcYkJMCN8QmWw==
X-Received: by 2002:a17:90b:4a85:b0:28b:8df7:d513 with SMTP id
 lp5-20020a17090b4a8500b0028b8df7d513mr977811pjb.16.1702926737336; 
 Mon, 18 Dec 2023 11:12:17 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:17 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 13/17] video: rockchip: Add rk3328 vop support
Date: Tue, 19 Dec 2023 00:41:10 +0530
Message-Id: <20231218191114.129329-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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
index 0000000000..a4da3a91e8
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
+	/* write reset values */
+	writel(0xef013f, &win_regs->win0_act_info);
+	writel(0xef013f, &win_regs->win0_dsp_info);
+	writel(0xa000a, &win_regs->win0_dsp_st);
+	writel(0x0, &win_regs->win0_yrgb_mst);
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

