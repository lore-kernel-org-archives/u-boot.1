Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142D3C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D238B876A4;
	Mon, 11 Dec 2023 10:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q++h5fHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D38487718; Mon, 11 Dec 2023 10:01:40 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA444876A4
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d32c599e83so500095ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285296; x=1702890096;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gNxMg1IyhU3HfVGqIXTc3vYjiZZE0NWMhSBqwbjsqU=;
 b=Q++h5fHAxIcyzO4W1S2ovoe0Z/3lF0hYxEWyKNS0p/feRoJdgGpc20rBgpgF/wMXzd
 qvjjQFqtL1oNYDGPJqU2G4Rxu2BBga1cvJtrJUH7KLn70BItyqGn4rTdSB9Kgp4MSfRd
 FthG+m55ZIhnq/ISF+5VLHBIygjXa0gsU4YoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285296; x=1702890096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gNxMg1IyhU3HfVGqIXTc3vYjiZZE0NWMhSBqwbjsqU=;
 b=n8e0FETQ2YJaamcQx9jLyDwZKTmKPwF52M9K/uBYSWo5/dfKlFLoJgPyMVu2gJVIUd
 5tRjpxXmwjFdUQw4RgC2g8Qfzplpt4QaS3zQ2ywJwArptZCmOp5y6H0boQKFXDM3NJfl
 GDWKMlZzDOE1N3Gn9a9D9eJwFP6RFYOAU+8qSNE3i9SObGyrddzp4gbb0ZDHPTvRm0KV
 4fF2LJzP7LAwnhouraOblGC/fVQ3pIumPQTScITANRt+cSyFiIK8tm142eVmI4OW0R9f
 rTObUNV/W4N3MlsYVgxd8uYi5vAi3jTm9i0j5X/FSBJunaCwUkI/tBRdAvkb3GHlwgcw
 fwKw==
X-Gm-Message-State: AOJu0Ywj3SYG4wNZ42QHssCWNqWq69g7DSlprUV3HKZJhjbkEh6z3H5L
 FZ0vgwo2R2MJeyO1NNqTTf1+pw==
X-Google-Smtp-Source: AGHT+IEp/dUmdamyXQFj/4R1a1HyY8/UYc5z06VRLYmwuhmLGb5cNMeJCW4pNimkaUF2o/RUkFGxYA==
X-Received: by 2002:a17:902:b207:b0:1d0:6b95:9c0d with SMTP id
 t7-20020a170902b20700b001d06b959c0dmr3805890plr.65.1702285296299; 
 Mon, 11 Dec 2023 01:01:36 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:35 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH 13/17] video: rockchip: Add rk3328 vop support
Date: Mon, 11 Dec 2023 14:29:35 +0530
Message-Id: <20231211085939.5478-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 drivers/video/rockchip/Makefile     |  1 +
 drivers/video/rockchip/rk3328_vop.c | 66 +++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
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
index 0000000000..2512314e64
--- /dev/null
+++ b/drivers/video/rockchip/rk3328_vop.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Edgeble AI Technologies Pvt. Ltd.
+ */
+
+#include <common.h>
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
+	.priv_auto	= sizeof(struct rk_vop_priv),
+};
-- 
2.25.1

