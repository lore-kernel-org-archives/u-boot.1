Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC9606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rc7LYeaF;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=EE7RORLJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CACEA40ABD;
	Sat, 21 Nov 2026 12:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNHFOIAm_RAg; Sat, 21 Nov 2026 12:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2977540EA7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264543;
	b=g5cQ4xp/rPHIJDLZwBj9eMemVZGnQCdsGVyIWvHrTchyc2QY70GBkoEn3UAycmXE/JPE
	 uaFdzCN9dax30QnxPXQsvFWqyuaf3NdQ9m7l4h7ldhci+dEBeWUUqR+t1VgDWuRqKtNDh
	 kMGT8o0eSGtYgVvP14uXJzWlpUmykMKsE5Htpgc6XbG0aMHFSm+pboJoDeQOEg4FrGUpG
	 Kl7f3jKJz6R5UW1NdsVej33Ef1dnXvAfQTx2ds3CVjpujBU9goTyRAKRsD6E8lmzEAxJn
	 ZoAOpK0SKi8yOJQXRtO6sviCzafaBRtF3oAxgAaiD10F+DHWvp/hyHXYTqVR/m2DpMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OTvVtBA8B3I2MSFcI1M0ETnzFFhQaN0uY2NggKTgCe8=;
	b=lPwC6yByGLB4EFcSRn0VcUUdNRWZK9oYHLcdqtp1IBsKf30vZCyZ3luXUlJqdstIH4lo
	 /s95M3a/4v2W72SpuQ6vqj41vuaUS+P2lgk/uXYxsljsAOWWtDUyZt7n+QJqvjvxEyRt3
	 wEpEvB/NdM5zuzA4yg69txGPbvLEasrMIuLHrUaENDrcjM9Y4Ib2B8t3td9KWhUqfyAcH
	 k0azOT3emHWq7TTjeSJ46gAs9BdzStHbjixZFGiQjqYS3lDh0mN0oalFqdL21ung31TnH
	 HkRmqHp5ZEMdFYNr3H+s0JP007L6n81m8TVx2jVahnSbx/6cSUpKBFTz7Rlq9tAsn/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264543;
	bh=OTvVtBA8B3I2MSFcI1M0ETnzFFhQaN0uY2NggKTgCe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rc7LYeaFeLQvg0gX8olKHL3AwLBd4/DuLDU/IuFzLQPc9o/Pj0zibesiRGjkAZzo5
	 D8Ig257ObJvbPfSuRbc2/SiF1+sU59vk4tYjABaibOaVNHVcVoGrGktm/KXaM8gM8z
	 g2iy6NbL3xqYzm7+tGtVbG24cN5VHQGDeCHxKaTN1+1ROEJEvvcVS73+/kDjIrAPWh
	 GO9DjcKY3WZwIg5CI4gD7Usy/mV/HFT+uyRwzKJIr0M8CTQjGMvQoVQ3hCok7BBWhZ
	 B28Jp3cKP6ewgOt1S3h7PINNQZwZPhhaUkTLCtaZwzDaCAzF+jRSi88h35ERBUImR0
	 fVUx2OcDxg0uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2977540EA7;
	Sat, 21 Nov 2026 12:35:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFBF2759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4E8940070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3tAuGyzy9_NM for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AE04340012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=EE7RORLJ
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE04340012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:31 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-491971ac844so1586901f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264529; x=1795869329;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OTvVtBA8B3I2MSFcI1M0ETnzFFhQaN0uY2NggKTgCe8=;
 b=EE7RORLJ6Vidp8sjbYEZetj4N4TpQTx0+cAK2dVrDX5i0UkZFVuoCPeH6xk3mzkd23
 +72YLyioEWjyRboT7W3LBRhJ6ne0+xudVbUwXw0ZLYFVsupAHq2FGimC/Kxn2a6DWfgL
 jeh0sJF19b46Ut7mZLecRgsgRLSswzL+D14Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264529; x=1795869329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OTvVtBA8B3I2MSFcI1M0ETnzFFhQaN0uY2NggKTgCe8=;
 b=sVnw0P0L+WESgGpuPPhof8M1dPwENIjhVj7SnDHNKDoQBdhU4xFB65YDi4Kuyr9OCH
 GIclnjrEzqEHMhjzkAfGPO2RE50hakHjcOwjEYXXYUwPEvw+JawRAJkErfvEDsqBcr/Y
 iQBw4NjUQHPZpMJKydj+PyuR6anQBWP4xCoUn70gRiqOhwS5VpxOCDdZEWcCgwdpNr+q
 3jtV+eg8S4GIcJUVhUhPDMMkgpHCl6s06cnVkc8uU5yKhS+SAONBCAcJ5UKBZvOTT+Fv
 oIZNOLuP3qFQy7xXaxqPaOY0KU7k7/D9cirkgURd3q/3A6U9zecIzuKyFTwO8VckQhyI
 o8Vw==
X-Gm-Message-State: APuU4Z/SPxeprrSlb5ZQ+as7/Q9VC/P6RMIQWHRisoGNurjQCvFzx6t6
 SckrBgKlyJOSMBnvUarO6d+QZQOW7Dlsaps4KYyYavETzIKI/pHFGPLDbBlBZKAI+Pc9/D8n+NB
 ROjt2
X-Gm-Gg: AZFdTZdpPVeoSByDRD216babePT3x1JIRdYPSU97fngsAN7C27skUzUdlwxs0ZGlT93
 ohUpaCB4LJ5RGRsWo/p6wsRd7BSKOscrTJ8w1yiwgz2ygpy/0eEcY2s299N4YOes4zJ68kI469F
 78B5ykwxtmM6qrjyVamvs+BwGfmN4mHPeKdlaSthbkuyBKetLgHlOzv1AWauExWhkh/RNVrR5jS
 XEkJJ6RCwPfdNbF5C+VMuBZOoV8rd3JHb5Goz4IAKE94ZSMhFijUDCJTbmlrCQfEm5mrCloh90e
 qzFmDe705yfIIE3akFyLyOIyWlMNLjVtulBPb7a7pQLwVuNoNIF2RTWsBeaoW519dcI6dZZ2RaO
 toLF1H9nNSApZsHJPjp8UBi6dxuwsJNYIH4An3W/EyH2/dKtdDfWIMe+jrumG4jSzggWLqKuDcB
 A9KjoL1636zqFEAmL62Gsvjnh7r+7goyqqSYim/rxz+IFOkldeeNcbpyRd0k89290U7z1ygu8Az
 F9qEvmVaPzE8Aen1epa0mNJdg64udrBeHAvXONUrPKh7K9f2wsIqqE+2b8nhy6irZtG3Kpwube6
 eHHYyNkkr5xn3+WI4qtahEkDORp0YLnaSvQe91yx+xLx1p/tHQv7mHr7z6P0yKjE+Guk1JSlJBG
 8I/b/FjrB4uriNsPtrQIamZXjwrNVMSgZV18MODCprdPYrRcO6k4g/2rLUjWXg/ip601D9Qpbud
 JJ/XyXietPS8VEQJhHsx8joiOZxg==
X-Received: by 2002:a05:6000:24c3:b0:4a4:368:409d with SMTP id
 ffacd0b85a97d-4abaa9769d3mr13782363f8f.3.1795264528935; 
 Sat, 21 Nov 2026 04:35:28 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:28 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/25] video: bridge: Add Samsung DSIM bridge
Date: Sat, 21 Nov 2026 13:34:07 +0100
Message-ID: <20261121123451.2471185-18-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Samsung MIPI DSIM controller is common DSI IP that can be used in various
SoCs like Exynos, i.MX8M Mini/Nano.

In order to access this DSI controller between various platform SoCs,
the ideal way to incorporate this in the as a bridge that can support
all different platform.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Bind the DSI host to the DSIM node and drop the
  "samsung,sec-mipi-dsi" compatible
- Fix typo in a comment

 drivers/video/bridge/Kconfig            |   13 +
 drivers/video/bridge/Makefile           |    1 +
 drivers/video/bridge/samsung-dsi-host.c | 1561 +++++++++++++++++++++++
 drivers/video/bridge/samsung-dsim.c     |  162 +++
 drivers/video/bridge/samsung-dsim.h     |   20 +
 5 files changed, 1757 insertions(+)
 create mode 100644 drivers/video/bridge/samsung-dsi-host.c
 create mode 100644 drivers/video/bridge/samsung-dsim.c
 create mode 100644 drivers/video/bridge/samsung-dsim.h

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index 81261c610059..c5a4901587d4 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -44,6 +44,19 @@ config VIDEO_BRIDGE_ANALOGIX_ANX6345
 	  The Analogix ANX6345 is RGB-to-DP converter. It enables an eDP LCD
 	  panel to be connected to an parallel LCD interface.
 
+config VIDEO_BRIDGE_SAMSUNG_DSIM
+	bool "Enable IMX SEC DSI video support"
+	select MIPI_DPHY_HELPERS
+	select VIDEO_BRIDGE
+	select VIDEO_LINK
+	select VIDEO_MIPI_DSI
+	help
+	  Enables the common driver code for the Samsung
+	  MIPI DSI block found in SoCs from various vendors.
+	  As this does not provide any functionality by itself (but
+	  rather requires a SoC-specific glue driver to call it), it
+	  can not be enabled from the configuration menu.
+
 config VIDEO_BRIDGE_SOLOMON_SSD2825
 	bool "Solomon SSD2825 bridge driver"
 	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
diff --git a/drivers/video/bridge/Makefile b/drivers/video/bridge/Makefile
index 520f36a7a6f4..a46594c561b2 100644
--- a/drivers/video/bridge/Makefile
+++ b/drivers/video/bridge/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_VIDEO_BRIDGE_PARADE_DP501) += dp501.o
 obj-$(CONFIG_VIDEO_BRIDGE_PARADE_PS862X) += ps862x.o
 obj-$(CONFIG_VIDEO_BRIDGE_NXP_PTN3460) += ptn3460.o
 obj-$(CONFIG_VIDEO_BRIDGE_ANALOGIX_ANX6345) += anx6345.o
+obj-$(CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM) += samsung-dsim.o samsung-dsi-host.o
 obj-$(CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825) += ssd2825.o
 obj-$(CONFIG_VIDEO_BRIDGE_TOSHIBA_TC358768) += tc358768.o
 obj-$(CONFIG_VIDEO_BRIDGE_LVDS_CODEC) += lvds-codec.o
diff --git a/drivers/video/bridge/samsung-dsi-host.c b/drivers/video/bridge/samsung-dsi-host.c
new file mode 100644
index 000000000000..32257cfcca4c
--- /dev/null
+++ b/drivers/video/bridge/samsung-dsi-host.c
@@ -0,0 +1,1561 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Amarula Solutions
+ * Copyright 2018 NXP
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_DSI_HOST
+
+#include <dm.h>
+#include <clk.h>
+#include <dm/device_compat.h>
+#include <asm/io.h>
+#include <log.h>
+#include <phy-mipi-dphy.h>
+#include <linux/err.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <asm/unaligned.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <div64.h>
+#include <video_bridge.h>
+#include <panel.h>
+#include <dsi_host.h>
+#include <asm/arch/gpio.h>
+#include <dm/device-internal.h>
+#include "samsung-dsim.h"
+
+#define MIPI_FIFO_TIMEOUT		250000 /* 250ms */
+
+#define DRIVER_NAME "samsung_dsi"
+
+/* reg bit manipulation */
+#define REG_MASK(e, s) (((1 << ((e) - (s) + 1)) - 1) << (s))
+#define REG_PUT(x, e, s) (((x) << (s)) & REG_MASK(e, s))
+#define REG_GET(x, e, s) (((x) & REG_MASK(e, s)) >> (s))
+
+#define RGB_STATUS_CMDMODE_INSEL	BIT(31)
+#define RGB_STATUS_GET_RGBSTATE(x)	REG_GET(x, 12,  0)
+
+#define CLKCTRL_DPHY_SEL_1P5G		(0x0 << 29)
+#define CLKCTRL_PLLBYPASS		BIT(29)
+#define CLKCTRL_BYTECLKSRC_DPHY_PLL	REG_PUT(0, 26, 25)
+#define CLKCTRL_SET_LANEESCCLKEN(x)	REG_PUT(x, 23, 19)
+#define CLKCTRL_SET_ESCPRESCALER(x)	REG_PUT(x, 15,  0)
+
+#define ESCMODE_SET_STOPSTATE_CNT(X)	REG_PUT(x, 31, 21)
+#define ESCMODE_FORCESTOPSTATE		BIT(20)
+#define ESCMODE_FORCEBTA		BIT(16)
+#define ESCMODE_CMDLPDT			BIT(7)
+#define ESCMODE_TXLPDT			BIT(6)
+#define ESCMODE_TXTRIGGERRST		BIT(5)
+
+#define MVPORCH_SET_CMDALLOW(x)		REG_PUT(x, 31, 28)
+#define MVPORCH_SET_STABLEVFP(x)	REG_PUT(x, 26, 16)
+#define MVPORCH_SET_MAINVBP(x)		REG_PUT(x, 10,  0)
+
+#define MHPORCH_SET_MAINHFP(x)		REG_PUT(x, 31, 16)
+#define MHPORCH_SET_MAINHBP(x)		REG_PUT(x, 15,  0)
+
+#define MSYNC_SET_MAINVSA(x)		REG_PUT(x, 31, 22)
+#define MSYNC_SET_MAINHSA(x)		REG_PUT(x, 15,  0)
+
+#define INTSRC_PLLSTABLE		BIT(31)
+#define INTSRC_SWRSTRELEASE		BIT(30)
+#define INTSRC_SFRPLFIFOEMPTY		BIT(29)
+#define INTSRC_SFRPHFIFOEMPTY		BIT(28)
+#define INTSRC_FRAMEDONE		BIT(24)
+#define INTSRC_LPDRTOUT			BIT(21)
+#define INTSRC_TATOUT			BIT(20)
+#define INTSRC_RXDATDONE		BIT(18)
+#define INTSRC_MASK			(INTSRC_PLLSTABLE	|	\
+					 INTSRC_SWRSTRELEASE	|	\
+					 INTSRC_SFRPLFIFOEMPTY	|	\
+					 INTSRC_SFRPHFIFOEMPTY	|	\
+					 INTSRC_FRAMEDONE	|	\
+					 INTSRC_LPDRTOUT	|	\
+					 INTSRC_TATOUT		|	\
+					 INTSRC_RXDATDONE)
+
+#define INTMSK_MSKPLLSTABLE		BIT(31)
+#define INTMSK_MSKSWRELEASE		BIT(30)
+#define INTMSK_MSKSFRPLFIFOEMPTY	BIT(29)
+#define INTMSK_MSKSFRPHFIFOEMPTY	BIT(28)
+#define INTMSK_MSKFRAMEDONE		BIT(24)
+#define INTMSK_MSKLPDRTOUT		BIT(21)
+#define INTMSK_MSKTATOUT		BIT(20)
+#define INTMSK_MSKRXDATDONE		BIT(18)
+
+#define PKTHDR_SET_DATA1(x)		REG_PUT(x, 23, 16)
+#define PKTHDR_GET_DATA1(x)		REG_GET(x, 23, 16)
+#define PKTHDR_SET_DATA0(x)		REG_PUT(x, 15,  8)
+#define PKTHDR_GET_DATA0(x)		REG_GET(x, 15,  8)
+#define PKTHDR_GET_WC(x)		REG_GET(x, 23,  8)
+#define PKTHDR_SET_DI(x)		REG_PUT(x,  7,  0)
+#define PKTHDR_GET_DI(x)		REG_GET(x,  7,  0)
+#define PKTHDR_SET_DT(x)		REG_PUT(x,  5,  0)
+#define PKTHDR_GET_DT(x)		REG_GET(x,  5,  0)
+#define PKTHDR_SET_VC(x)		REG_PUT(x,  7,  6)
+#define PKTHDR_GET_VC(x)		REG_GET(x,  7,  6)
+
+#define FIFOCTRL_FULLRX			BIT(25)
+#define FIFOCTRL_EMPTYRX		BIT(24)
+#define FIFOCTRL_FULLHSFR		BIT(23)
+#define FIFOCTRL_EMPTYHSFR		BIT(22)
+#define FIFOCTRL_FULLLSFR		BIT(21)
+#define FIFOCTRL_EMPTYLSFR		BIT(20)
+#define FIFOCTRL_FULLHMAIN		BIT(11)
+#define FIFOCTRL_EMPTYHMAIN		BIT(10)
+#define FIFOCTRL_FULLLMAIN		BIT(9)
+#define FIFOCTRL_EMPTYLMAIN		BIT(8)
+#define FIFOCTRL_NINITRX		BIT(4)
+#define FIFOCTRL_NINITSFR		BIT(3)
+#define FIFOCTRL_NINITI80		BIT(2)
+#define FIFOCTRL_NINITSUB		BIT(1)
+#define FIFOCTRL_NINITMAIN		BIT(0)
+
+#define PLLCTRL_DPDNSWAP_CLK		BIT(25)
+#define PLLCTRL_DPDNSWAP_DAT		BIT(24)
+#define PLLCTRL_PLLEN			BIT(23)
+#define PLLCTRL_SET_PMS(x)		REG_PUT(x, 19,  1)
+#define PLLCTRL_SET_P(x)		REG_PUT(x, 18, 13)
+#define PLLCTRL_SET_M(x)		REG_PUT(x, 12,  3)
+#define PLLCTRL_SET_S(x)		REG_PUT(x,  2,  0)
+
+#define MAX_MAIN_HRESOL		2047
+#define MAX_MAIN_VRESOL		2047
+#define MAX_SUB_HRESOL		1024
+#define MAX_SUB_VRESOL		1024
+
+/* in KHZ */
+#define MAX_ESC_CLK_FREQ	20000
+
+/* dsim all irqs index */
+#define PLLSTABLE		1
+#define SWRSTRELEASE		2
+#define SFRPLFIFOEMPTY		3
+#define SFRPHFIFOEMPTY		4
+#define SYNCOVERRIDE		5
+#define BUSTURNOVER		6
+#define FRAMEDONE		7
+#define LPDRTOUT		8
+#define TATOUT			9
+#define RXDATDONE		10
+#define RXTE			11
+#define RXACK			12
+#define ERRRXECC		13
+#define ERRRXCRC		14
+#define ERRESC3			15
+#define ERRESC2			16
+#define ERRESC1			17
+#define ERRESC0			18
+#define ERRSYNC3		19
+#define ERRSYNC2		20
+#define ERRSYNC1		21
+#define ERRSYNC0		22
+#define ERRCONTROL3		23
+#define ERRCONTROL2		24
+#define ERRCONTROL1		25
+#define ERRCONTROL0		26
+
+#define PS_TO_CYCLE(ps, hz) DIV64_U64_ROUND_CLOSEST(((ps) * (hz)), 1000000000000ULL)
+
+#define MIPI_HFP_PKT_OVERHEAD	6
+#define MIPI_HBP_PKT_OVERHEAD	6
+#define MIPI_HSA_PKT_OVERHEAD	6
+
+/* DSIM_STATUS */
+#define DSIM_STOP_STATE_DAT(x)		(((x) & 0xf) << 0)
+#define DSIM_STOP_STATE_CLK		BIT(8)
+#define DSIM_TX_READY_HS_CLK		BIT(10)
+#define DSIM_PLL_STABLE			BIT(31)
+
+/* DSIM_SWRST */
+#define DSIM_FUNCRST			BIT(16)
+#define DSIM_SWRST			BIT(0)
+
+/* DSIM_TIMEOUT */
+#define DSIM_LPDR_TIMEOUT(x)		((x) << 0)
+#define DSIM_BTA_TIMEOUT(x)		((x) << 16)
+
+/* DSIM_CLKCTRL */
+#define DSIM_ESC_PRESCALER(x)		(((x) & 0xffff) << 0)
+#define DSIM_ESC_PRESCALER_MASK		(0xffff << 0)
+#define DSIM_LANE_ESC_CLK_EN_CLK	BIT(19)
+#define DSIM_LANE_ESC_CLK_EN_DATA(x)	(((x) & 0xf) << 20)
+#define DSIM_LANE_ESC_CLK_EN_DATA_MASK	(0xf << 20)
+#define DSIM_BYTE_CLKEN			BIT(24)
+#define DSIM_BYTE_CLK_SRC(x)		(((x) & 0x3) << 25)
+#define DSIM_BYTE_CLK_SRC_MASK		(0x3 << 25)
+#define DSIM_PLL_BYPASS			BIT(27)
+#define DSIM_ESC_CLKEN			BIT(28)
+#define DSIM_TX_REQUEST_HSCLK		BIT(31)
+
+/* DSIM_CONFIG */
+#define DSIM_LANE_EN_CLK		BIT(0)
+#define DSIM_LANE_EN(x)			(((x) & 0xf) << 1)
+#define DSIM_NUM_OF_DATA_LANE(x)	(((x) & 0x3) << 5)
+#define DSIM_SUB_PIX_FORMAT(x)		(((x) & 0x7) << 8)
+#define DSIM_MAIN_PIX_FORMAT_MASK	(0x7 << 12)
+#define DSIM_MAIN_PIX_FORMAT_RGB888	(0x7 << 12)
+#define DSIM_MAIN_PIX_FORMAT_RGB666	(0x6 << 12)
+#define DSIM_MAIN_PIX_FORMAT_RGB666_P	(0x5 << 12)
+#define DSIM_MAIN_PIX_FORMAT_RGB565	(0x4 << 12)
+#define DSIM_SUB_VC(x)			(((x) & 0x3) << 16)
+#define DSIM_MAIN_VC(x)			(((x) & 0x3) << 18)
+#define DSIM_HSA_DISABLE_MODE		BIT(20)
+#define DSIM_HBP_DISABLE_MODE		BIT(21)
+#define DSIM_HFP_DISABLE_MODE		BIT(22)
+/*
+ * The i.MX 8M Mini Applications Processor Reference Manual,
+ * Rev. 3, 11/2020 Page 4091
+ * The i.MX 8M Nano Applications Processor Reference Manual,
+ * Rev. 2, 07/2022 Page 3058
+ * The i.MX 8M Plus Applications Processor Reference Manual,
+ * Rev. 1, 06/2021 Page 5436
+ * all claims this bit is 'HseDisableMode' with the definition
+ * 0 = Disables transfer
+ * 1 = Enables transfer
+ *
+ * This clearly states that HSE is not a disabled bit.
+ *
+ * The naming convention follows as per the manual and the
+ * driver logic is based on the MIPI_DSI_MODE_VIDEO_HSE flag.
+ */
+#define DSIM_HSE_DISABLE_MODE		BIT(23)
+#define DSIM_AUTO_MODE			BIT(24)
+#define DSIM_VIDEO_MODE			BIT(25)
+#define DSIM_BURST_MODE			BIT(26)
+#define DSIM_SYNC_INFORM		BIT(27)
+#define DSIM_EOT_DISABLE		BIT(28)
+#define DSIM_MFLUSH_VS			BIT(29)
+/* This flag is valid only for exynos3250/3472/5260/5430 */
+#define DSIM_CLKLANE_STOP		BIT(30)
+#define DSIM_NON_CONTINUOUS_CLKLANE	BIT(31)
+
+/* DSIM_ESCMODE */
+#define DSIM_TX_TRIGGER_RST		BIT(4)
+#define DSIM_TX_LPDT_LP			BIT(6)
+#define DSIM_CMD_LPDT_LP		BIT(7)
+#define DSIM_FORCE_BTA			BIT(16)
+#define DSIM_FORCE_STOP_STATE		BIT(20)
+#define DSIM_STOP_STATE_CNT(x)		(((x) & 0x7ff) << 21)
+#define DSIM_STOP_STATE_CNT_MASK	(0x7ff << 21)
+
+/* DSIM_MDRESOL */
+#define DSIM_MAIN_STAND_BY		BIT(31)
+#define DSIM_MAIN_VRESOL(x, num_bits)	(((x) & ((1 << (num_bits)) - 1)) << 16)
+#define DSIM_MAIN_HRESOL(x, num_bits)	(((x) & ((1 << (num_bits)) - 1)) << 0)
+
+/* DSIM_MVPORCH */
+#define DSIM_CMD_ALLOW(x)		((x) << 28)
+#define DSIM_STABLE_VFP(x)		((x) << 16)
+#define DSIM_MAIN_VBP(x)		((x) << 0)
+#define DSIM_CMD_ALLOW_MASK		(0xf << 28)
+#define DSIM_STABLE_VFP_MASK		(0x7ff << 16)
+#define DSIM_MAIN_VBP_MASK		(0x7ff << 0)
+
+/* DSIM_MHPORCH */
+#define DSIM_MAIN_HFP(x)		((x) << 16)
+#define DSIM_MAIN_HBP(x)		((x) << 0)
+#define DSIM_MAIN_HFP_MASK		((0xffff) << 16)
+#define DSIM_MAIN_HBP_MASK		((0xffff) << 0)
+
+/* DSIM_MSYNC */
+#define DSIM_MAIN_VSA(x)		((x) << 22)
+#define DSIM_MAIN_HSA(x)		((x) << 0)
+#define DSIM_MAIN_VSA_MASK		((0x3ff) << 22)
+#define DSIM_MAIN_HSA_MASK		((0xffff) << 0)
+
+/* DSIM_SDRESOL */
+#define DSIM_SUB_STANDY(x)		((x) << 31)
+#define DSIM_SUB_VRESOL(x)		((x) << 16)
+#define DSIM_SUB_HRESOL(x)		((x) << 0)
+#define DSIM_SUB_STANDY_MASK		((0x1) << 31)
+#define DSIM_SUB_VRESOL_MASK		((0x7ff) << 16)
+#define DSIM_SUB_HRESOL_MASK		((0x7ff) << 0)
+
+/* DSIM_INTSRC */
+#define DSIM_INT_PLL_STABLE		BIT(31)
+#define DSIM_INT_SW_RST_RELEASE		BIT(30)
+#define DSIM_INT_SFR_FIFO_EMPTY		BIT(29)
+#define DSIM_INT_SFR_HDR_FIFO_EMPTY	BIT(28)
+#define DSIM_INT_BTA			BIT(25)
+#define DSIM_INT_FRAME_DONE		BIT(24)
+#define DSIM_INT_RX_TIMEOUT		BIT(21)
+#define DSIM_INT_BTA_TIMEOUT		BIT(20)
+#define DSIM_INT_RX_DONE		BIT(18)
+#define DSIM_INT_RX_TE			BIT(17)
+#define DSIM_INT_RX_ACK			BIT(16)
+#define DSIM_INT_RX_ECC_ERR		BIT(15)
+#define DSIM_INT_RX_CRC_ERR		BIT(14)
+
+/* DSIM_FIFOCTRL */
+#define DSIM_RX_DATA_FULL		BIT(25)
+#define DSIM_RX_DATA_EMPTY		BIT(24)
+#define DSIM_SFR_HEADER_FULL		BIT(23)
+#define DSIM_SFR_HEADER_EMPTY		BIT(22)
+#define DSIM_SFR_PAYLOAD_FULL		BIT(21)
+#define DSIM_SFR_PAYLOAD_EMPTY		BIT(20)
+#define DSIM_I80_HEADER_FULL		BIT(19)
+#define DSIM_I80_HEADER_EMPTY		BIT(18)
+#define DSIM_I80_PAYLOAD_FULL		BIT(17)
+#define DSIM_I80_PAYLOAD_EMPTY		BIT(16)
+#define DSIM_SD_HEADER_FULL		BIT(15)
+#define DSIM_SD_HEADER_EMPTY		BIT(14)
+#define DSIM_SD_PAYLOAD_FULL		BIT(13)
+#define DSIM_SD_PAYLOAD_EMPTY		BIT(12)
+#define DSIM_MD_HEADER_FULL		BIT(11)
+#define DSIM_MD_HEADER_EMPTY		BIT(10)
+#define DSIM_MD_PAYLOAD_FULL		BIT(9)
+#define DSIM_MD_PAYLOAD_EMPTY		BIT(8)
+#define DSIM_RX_FIFO			BIT(4)
+#define DSIM_SFR_FIFO			BIT(3)
+#define DSIM_I80_FIFO			BIT(2)
+#define DSIM_SD_FIFO			BIT(1)
+#define DSIM_MD_FIFO			BIT(0)
+
+/* DSIM_PHYACCHR */
+#define DSIM_AFC_EN			BIT(14)
+#define DSIM_AFC_CTL(x)			(((x) & 0x7) << 5)
+
+/* DSIM_PLLCTRL */
+#define DSIM_FREQ_BAND(x)		((x) << 24)
+#define DSIM_PLL_EN			BIT(23)
+#define DSIM_PLL_P(x, offset)		((x) << (offset))
+#define DSIM_PLL_M(x)			((x) << 4)
+#define DSIM_PLL_S(x)			((x) << 1)
+
+/* DSIM_PHYCTRL */
+#define DSIM_PHYCTRL_ULPS_EXIT(x)	(((x) & 0x1ff) << 0)
+#define DSIM_PHYCTRL_B_DPHYCTL_VREG_LP	BIT(30)
+#define DSIM_PHYCTRL_B_DPHYCTL_SLEW_UP	BIT(14)
+
+/* DSIM_PHYTIMING */
+#define DSIM_PHYTIMING_LPX(x)		((x) << 8)
+#define DSIM_PHYTIMING_HS_EXIT(x)	((x) << 0)
+
+/* DSIM_PHYTIMING1 */
+#define DSIM_PHYTIMING1_CLK_PREPARE(x)	((x) << 24)
+#define DSIM_PHYTIMING1_CLK_ZERO(x)	((x) << 16)
+#define DSIM_PHYTIMING1_CLK_POST(x)	((x) << 8)
+#define DSIM_PHYTIMING1_CLK_TRAIL(x)	((x) << 0)
+
+/* DSIM_PHYTIMING2 */
+#define DSIM_PHYTIMING2_HS_PREPARE(x)	((x) << 16)
+#define DSIM_PHYTIMING2_HS_ZERO(x)	((x) << 8)
+#define DSIM_PHYTIMING2_HS_TRAIL(x)	((x) << 0)
+
+#define DSI_MAX_BUS_WIDTH		4
+#define DSI_NUM_VIRTUAL_CHANNELS	4
+#define DSI_TX_FIFO_SIZE		2048
+#define DSI_RX_FIFO_SIZE		256
+#define DSI_XFER_TIMEOUT_MS		100
+#define DSI_RX_FIFO_EMPTY		0x30800002
+
+struct samsung_dsim_driver_data {
+	const unsigned int *reg_ofs;
+	unsigned int plltmr_reg;
+	unsigned int has_freqband:1;
+	unsigned int has_clklane_stop:1;
+	unsigned int has_broken_fifoctrl_emptyhdr:1;
+	unsigned int num_clks;
+	unsigned int min_freq;
+	unsigned int max_freq;
+	unsigned int wait_for_reset;
+	unsigned int num_bits_resol;
+	unsigned int pll_p_offset;
+	const unsigned int *reg_values;
+	unsigned int pll_fin_min;
+	unsigned int pll_fin_max;
+	u16 m_min;
+	u16 m_max;
+};
+
+enum reg_idx {
+	DSIM_STATUS_REG,	/* Status register */
+	DSIM_RGB_STATUS_REG,	/* RGB status register */
+	DSIM_SWRST_REG,		/* Software reset register */
+	DSIM_CLKCTRL_REG,	/* Clock control register */
+	DSIM_TIMEOUT_REG,	/* Time out register */
+	DSIM_CONFIG_REG,	/* Configuration register */
+	DSIM_ESCMODE_REG,	/* Escape mode register */
+	DSIM_MDRESOL_REG,
+	DSIM_MVPORCH_REG,	/* Main display Vporch register */
+	DSIM_MHPORCH_REG,	/* Main display Hporch register */
+	DSIM_MSYNC_REG,		/* Main display sync area register */
+	DSIM_INTSRC_REG,	/* Interrupt source register */
+	DSIM_INTMSK_REG,	/* Interrupt mask register */
+	DSIM_PKTHDR_REG,	/* Packet Header FIFO register */
+	DSIM_PAYLOAD_REG,	/* Payload FIFO register */
+	DSIM_RXFIFO_REG,	/* Read FIFO register */
+	DSIM_FIFOCTRL_REG,	/* FIFO status and control register */
+	DSIM_PLLCTRL_REG,	/* PLL control register */
+	DSIM_PHYCTRL_REG,
+	DSIM_PHYTIMING_REG,
+	DSIM_PHYTIMING1_REG,
+	DSIM_PHYTIMING2_REG,
+	NUM_REGS
+};
+
+static const unsigned int exynos_reg_ofs[] = {
+	[DSIM_STATUS_REG] =  0x00,
+	[DSIM_SWRST_REG] =  0x04,
+	[DSIM_CLKCTRL_REG] =  0x08,
+	[DSIM_TIMEOUT_REG] =  0x0c,
+	[DSIM_CONFIG_REG] =  0x10,
+	[DSIM_ESCMODE_REG] =  0x14,
+	[DSIM_MDRESOL_REG] =  0x18,
+	[DSIM_MVPORCH_REG] =  0x1c,
+	[DSIM_MHPORCH_REG] =  0x20,
+	[DSIM_MSYNC_REG] =  0x24,
+	[DSIM_INTSRC_REG] =  0x2c,
+	[DSIM_INTMSK_REG] =  0x30,
+	[DSIM_PKTHDR_REG] =  0x34,
+	[DSIM_PAYLOAD_REG] =  0x38,
+	[DSIM_RXFIFO_REG] =  0x3c,
+	[DSIM_FIFOCTRL_REG] =  0x44,
+	[DSIM_PLLCTRL_REG] =  0x4c,
+	[DSIM_PHYCTRL_REG] =  0x5c,
+	[DSIM_PHYTIMING_REG] =  0x64,
+	[DSIM_PHYTIMING1_REG] =  0x68,
+	[DSIM_PHYTIMING2_REG] =  0x6c,
+};
+
+static const unsigned int exynos5433_reg_ofs[] = {
+	[DSIM_STATUS_REG] = 0x04,
+	[DSIM_RGB_STATUS_REG] = 0x08,
+	[DSIM_SWRST_REG] = 0x0C,
+	[DSIM_CLKCTRL_REG] = 0x10,
+	[DSIM_TIMEOUT_REG] = 0x14,
+	[DSIM_CONFIG_REG] = 0x18,
+	[DSIM_ESCMODE_REG] = 0x1C,
+	[DSIM_MDRESOL_REG] = 0x20,
+	[DSIM_MVPORCH_REG] = 0x24,
+	[DSIM_MHPORCH_REG] = 0x28,
+	[DSIM_MSYNC_REG] = 0x2C,
+	[DSIM_INTSRC_REG] = 0x34,
+	[DSIM_INTMSK_REG] = 0x38,
+	[DSIM_PKTHDR_REG] = 0x3C,
+	[DSIM_PAYLOAD_REG] = 0x40,
+	[DSIM_RXFIFO_REG] = 0x44,
+	[DSIM_FIFOCTRL_REG] = 0x4C,
+	[DSIM_PLLCTRL_REG] = 0x94,
+	[DSIM_PHYCTRL_REG] = 0xA4,
+	[DSIM_PHYTIMING_REG] = 0xB4,
+	[DSIM_PHYTIMING1_REG] = 0xB8,
+	[DSIM_PHYTIMING2_REG] = 0xBC,
+};
+
+enum reg_value_idx {
+	RESET_TYPE,
+	PLL_TIMER,
+	STOP_STATE_CNT,
+	PHYCTRL_ULPS_EXIT,
+	PHYCTRL_VREG_LP,
+	PHYCTRL_SLEW_UP,
+	PHYTIMING_LPX,
+	PHYTIMING_HS_EXIT,
+	PHYTIMING_CLK_PREPARE,
+	PHYTIMING_CLK_ZERO,
+	PHYTIMING_CLK_POST,
+	PHYTIMING_CLK_TRAIL,
+	PHYTIMING_HS_PREPARE,
+	PHYTIMING_HS_ZERO,
+	PHYTIMING_HS_TRAIL
+};
+
+static const unsigned int reg_values[] = {
+	[RESET_TYPE] = DSIM_SWRST,
+	[PLL_TIMER] = 500,
+	[STOP_STATE_CNT] = 0xf,
+	[PHYCTRL_ULPS_EXIT] = DSIM_PHYCTRL_ULPS_EXIT(0x0af),
+	[PHYCTRL_VREG_LP] = 0,
+	[PHYCTRL_SLEW_UP] = 0,
+	[PHYTIMING_LPX] = DSIM_PHYTIMING_LPX(0x06),
+	[PHYTIMING_HS_EXIT] = DSIM_PHYTIMING_HS_EXIT(0x0b),
+	[PHYTIMING_CLK_PREPARE] = DSIM_PHYTIMING1_CLK_PREPARE(0x07),
+	[PHYTIMING_CLK_ZERO] = DSIM_PHYTIMING1_CLK_ZERO(0x27),
+	[PHYTIMING_CLK_POST] = DSIM_PHYTIMING1_CLK_POST(0x0d),
+	[PHYTIMING_CLK_TRAIL] = DSIM_PHYTIMING1_CLK_TRAIL(0x08),
+	[PHYTIMING_HS_PREPARE] = DSIM_PHYTIMING2_HS_PREPARE(0x09),
+	[PHYTIMING_HS_ZERO] = DSIM_PHYTIMING2_HS_ZERO(0x0d),
+	[PHYTIMING_HS_TRAIL] = DSIM_PHYTIMING2_HS_TRAIL(0x0b),
+};
+
+static const unsigned int exynos5422_reg_values[] = {
+	[RESET_TYPE] = DSIM_SWRST,
+	[PLL_TIMER] = 500,
+	[STOP_STATE_CNT] = 0xf,
+	[PHYCTRL_ULPS_EXIT] = DSIM_PHYCTRL_ULPS_EXIT(0xaf),
+	[PHYCTRL_VREG_LP] = 0,
+	[PHYCTRL_SLEW_UP] = 0,
+	[PHYTIMING_LPX] = DSIM_PHYTIMING_LPX(0x08),
+	[PHYTIMING_HS_EXIT] = DSIM_PHYTIMING_HS_EXIT(0x0d),
+	[PHYTIMING_CLK_PREPARE] = DSIM_PHYTIMING1_CLK_PREPARE(0x09),
+	[PHYTIMING_CLK_ZERO] = DSIM_PHYTIMING1_CLK_ZERO(0x30),
+	[PHYTIMING_CLK_POST] = DSIM_PHYTIMING1_CLK_POST(0x0e),
+	[PHYTIMING_CLK_TRAIL] = DSIM_PHYTIMING1_CLK_TRAIL(0x0a),
+	[PHYTIMING_HS_PREPARE] = DSIM_PHYTIMING2_HS_PREPARE(0x0c),
+	[PHYTIMING_HS_ZERO] = DSIM_PHYTIMING2_HS_ZERO(0x11),
+	[PHYTIMING_HS_TRAIL] = DSIM_PHYTIMING2_HS_TRAIL(0x0d),
+};
+
+static const unsigned int exynos5433_reg_values[] = {
+	[RESET_TYPE] = DSIM_FUNCRST,
+	[PLL_TIMER] = 22200,
+	[STOP_STATE_CNT] = 0xa,
+	[PHYCTRL_ULPS_EXIT] = DSIM_PHYCTRL_ULPS_EXIT(0x190),
+	[PHYCTRL_VREG_LP] = DSIM_PHYCTRL_B_DPHYCTL_VREG_LP,
+	[PHYCTRL_SLEW_UP] = DSIM_PHYCTRL_B_DPHYCTL_SLEW_UP,
+	[PHYTIMING_LPX] = DSIM_PHYTIMING_LPX(0x07),
+	[PHYTIMING_HS_EXIT] = DSIM_PHYTIMING_HS_EXIT(0x0c),
+	[PHYTIMING_CLK_PREPARE] = DSIM_PHYTIMING1_CLK_PREPARE(0x09),
+	[PHYTIMING_CLK_ZERO] = DSIM_PHYTIMING1_CLK_ZERO(0x2d),
+	[PHYTIMING_CLK_POST] = DSIM_PHYTIMING1_CLK_POST(0x0e),
+	[PHYTIMING_CLK_TRAIL] = DSIM_PHYTIMING1_CLK_TRAIL(0x09),
+	[PHYTIMING_HS_PREPARE] = DSIM_PHYTIMING2_HS_PREPARE(0x0b),
+	[PHYTIMING_HS_ZERO] = DSIM_PHYTIMING2_HS_ZERO(0x10),
+	[PHYTIMING_HS_TRAIL] = DSIM_PHYTIMING2_HS_TRAIL(0x0c),
+};
+
+static const unsigned int imx8mm_dsim_reg_values[] = {
+	[RESET_TYPE] = DSIM_SWRST,
+	[PLL_TIMER] = 500,
+	[STOP_STATE_CNT] = 0xf,
+	[PHYCTRL_ULPS_EXIT] = DSIM_PHYCTRL_ULPS_EXIT(0xaf),
+	[PHYCTRL_VREG_LP] = 0,
+	[PHYCTRL_SLEW_UP] = 0,
+	[PHYTIMING_LPX] = DSIM_PHYTIMING_LPX(0x06),
+	[PHYTIMING_HS_EXIT] = DSIM_PHYTIMING_HS_EXIT(0x0b),
+	[PHYTIMING_CLK_PREPARE] = DSIM_PHYTIMING1_CLK_PREPARE(0x07),
+	[PHYTIMING_CLK_ZERO] = DSIM_PHYTIMING1_CLK_ZERO(0x26),
+	[PHYTIMING_CLK_POST] = DSIM_PHYTIMING1_CLK_POST(0x0d),
+	[PHYTIMING_CLK_TRAIL] = DSIM_PHYTIMING1_CLK_TRAIL(0x08),
+	[PHYTIMING_HS_PREPARE] = DSIM_PHYTIMING2_HS_PREPARE(0x08),
+	[PHYTIMING_HS_ZERO] = DSIM_PHYTIMING2_HS_ZERO(0x0d),
+	[PHYTIMING_HS_TRAIL] = DSIM_PHYTIMING2_HS_TRAIL(0x0b),
+};
+
+static const struct samsung_dsim_driver_data exynos3_dsi_driver_data = {
+	.reg_ofs = exynos_reg_ofs,
+	.plltmr_reg = 0x50,
+	.has_freqband = 1,
+	.has_clklane_stop = 1,
+	.num_clks = 2,
+	.max_freq = 1000,
+	.wait_for_reset = 1,
+	.num_bits_resol = 11,
+	.pll_p_offset = 13,
+	.reg_values = reg_values,
+	.pll_fin_min = 6,
+	.pll_fin_max = 12,
+	.m_min = 41,
+	.m_max = 125,
+	.min_freq = 500,
+	.has_broken_fifoctrl_emptyhdr = 1,
+};
+
+static const struct samsung_dsim_driver_data exynos4_dsi_driver_data = {
+	.reg_ofs = exynos_reg_ofs,
+	.plltmr_reg = 0x50,
+	.has_freqband = 1,
+	.has_clklane_stop = 1,
+	.num_clks = 2,
+	.max_freq = 1000,
+	.wait_for_reset = 1,
+	.num_bits_resol = 11,
+	.pll_p_offset = 13,
+	.reg_values = reg_values,
+	.pll_fin_min = 6,
+	.pll_fin_max = 12,
+	.m_min = 41,
+	.m_max = 125,
+	.min_freq = 500,
+	.has_broken_fifoctrl_emptyhdr = 1,
+};
+
+static const struct samsung_dsim_driver_data exynos5_dsi_driver_data = {
+	.reg_ofs = exynos_reg_ofs,
+	.plltmr_reg = 0x58,
+	.num_clks = 2,
+	.max_freq = 1000,
+	.wait_for_reset = 1,
+	.num_bits_resol = 11,
+	.pll_p_offset = 13,
+	.reg_values = reg_values,
+	.pll_fin_min = 6,
+	.pll_fin_max = 12,
+	.m_min = 41,
+	.m_max = 125,
+	.min_freq = 500,
+};
+
+static const struct samsung_dsim_driver_data exynos5433_dsi_driver_data = {
+	.reg_ofs = exynos5433_reg_ofs,
+	.plltmr_reg = 0xa0,
+	.has_clklane_stop = 1,
+	.num_clks = 5,
+	.max_freq = 1500,
+	.wait_for_reset = 0,
+	.num_bits_resol = 12,
+	.pll_p_offset = 13,
+	.reg_values = exynos5433_reg_values,
+	.pll_fin_min = 6,
+	.pll_fin_max = 12,
+	.m_min = 41,
+	.m_max = 125,
+	.min_freq = 500,
+};
+
+static const struct samsung_dsim_driver_data exynos5422_dsi_driver_data = {
+	.reg_ofs = exynos5433_reg_ofs,
+	.plltmr_reg = 0xa0,
+	.has_clklane_stop = 1,
+	.num_clks = 2,
+	.max_freq = 1500,
+	.wait_for_reset = 1,
+	.num_bits_resol = 12,
+	.pll_p_offset = 13,
+	.reg_values = exynos5422_reg_values,
+	.pll_fin_min = 6,
+	.pll_fin_max = 12,
+	.m_min = 41,
+	.m_max = 125,
+	.min_freq = 500,
+};
+
+static const struct samsung_dsim_driver_data imx8mm_dsi_driver_data = {
+	.reg_ofs = exynos5433_reg_ofs,
+	.plltmr_reg = 0xa0,
+	.has_clklane_stop = 1,
+	.num_clks = 2,
+	.max_freq = 2100,
+	.wait_for_reset = 0,
+	.num_bits_resol = 12,
+	/*
+	 * Unlike Exynos, PLL_P(PMS_P) offset 14 is used in i.MX8M Mini/Nano/Plus
+	 * downstream driver - drivers/gpu/drm/bridge/sec-dsim.c
+	 */
+	.pll_p_offset = 14,
+	.reg_values = imx8mm_dsim_reg_values,
+	.pll_fin_min = 2,
+	.pll_fin_max = 30,
+	.m_min = 64,
+	.m_max = 1023,
+	.min_freq = 1050,
+};
+
+static const struct samsung_dsim_driver_data *
+samsung_dsim_types[DSIM_TYPE_COUNT] = {
+	[DSIM_TYPE_EXYNOS3250] = &exynos3_dsi_driver_data,
+	[DSIM_TYPE_EXYNOS4210] = &exynos4_dsi_driver_data,
+	[DSIM_TYPE_EXYNOS5410] = &exynos5_dsi_driver_data,
+	[DSIM_TYPE_EXYNOS5422] = &exynos5422_dsi_driver_data,
+	[DSIM_TYPE_EXYNOS5433] = &exynos5433_dsi_driver_data,
+	[DSIM_TYPE_IMX8MM] = &imx8mm_dsi_driver_data,
+	[DSIM_TYPE_IMX8MP] = &imx8mm_dsi_driver_data,
+};
+
+/* DSIM PLL configuration from spec:
+ *
+ * Fout(DDR) = (M * Fin) / (P * 2^S), so Fout / Fin = M / (P * 2^S)
+ * Fin_pll   = Fin / P     (6 ~ 12 MHz)
+ * S: [2:0], M: [12:3], P: [18:13], so
+ * TODO: 'S' is in [0 ~ 3], 'M' is in, 'P' is in [1 ~ 33]
+ *
+ */
+
+struct samsung_dsi {
+	void __iomem *reg_base;
+	struct clk sclk_mipi;
+	const struct samsung_dsim_driver_data *driver_data;
+
+	/* kHz clocks */
+	u64 pix_clk;
+	u64 bit_clk;
+	u64 hs_clock;
+
+	unsigned int lanes;
+	unsigned int channel;			/* virtual channel */
+	enum mipi_dsi_pixel_format format;
+	unsigned long mode_flags;
+	unsigned int pms;
+
+	struct mipi_dsi_device *device;
+	u32 max_data_lanes;
+
+	struct mipi_dsi_host dsi_host;
+	struct display_timing timings;
+};
+
+static inline void samsung_dsim_write(struct samsung_dsi *dsi,
+				      enum reg_idx idx, u32 val)
+{
+	writel(val, dsi->reg_base + dsi->driver_data->reg_ofs[idx]);
+}
+
+static inline u32 samsung_dsim_read(struct samsung_dsi *dsi, enum reg_idx idx)
+{
+	return readl(dsi->reg_base + dsi->driver_data->reg_ofs[idx]);
+}
+
+static int samsung_dsi_wait_for_pkt_done(struct samsung_dsi *dsim, unsigned long timeout)
+{
+	u32 intsrc;
+
+	do {
+		intsrc = samsung_dsim_read(dsim, DSIM_INTSRC_REG);
+		if (intsrc & INTSRC_SFRPLFIFOEMPTY) {
+			samsung_dsim_write(dsim, DSIM_INTSRC_REG, INTSRC_SFRPLFIFOEMPTY);
+			return 0;
+		}
+
+		udelay(1);
+	} while (--timeout);
+
+	return -ETIMEDOUT;
+}
+
+static int samsung_dsi_wait_for_hdr_done(struct samsung_dsi *dsim, unsigned long timeout)
+{
+	u32 intsrc;
+
+	do {
+		intsrc = samsung_dsim_read(dsim, DSIM_INTSRC_REG);
+		if (intsrc & INTSRC_SFRPHFIFOEMPTY) {
+			samsung_dsim_write(dsim, DSIM_INTSRC_REG, INTSRC_SFRPHFIFOEMPTY);
+			return 0;
+		}
+
+		udelay(1);
+	} while (--timeout);
+
+	return -ETIMEDOUT;
+}
+
+static int samsung_dsi_wait_for_rx_done(struct samsung_dsi *dsim,
+					unsigned long timeout)
+{
+	u32 intsrc;
+
+	do {
+		intsrc = samsung_dsim_read(dsim, DSIM_INTSRC_REG);
+		if (intsrc & INTSRC_RXDATDONE) {
+			samsung_dsim_write(dsim, DSIM_INTSRC_REG, INTSRC_RXDATDONE);
+			return 0;
+		}
+
+		udelay(1);
+	} while (--timeout);
+
+	return -ETIMEDOUT;
+}
+
+static int samsung_dsi_wait_pll_stable(struct samsung_dsi *dsim)
+{
+	u32 status;
+	ulong start;
+
+	start = get_timer(0);	/* Get current timestamp */
+
+	do {
+		status = samsung_dsim_read(dsim, DSIM_STATUS_REG);
+		if (status & DSIM_PLL_STABLE)
+			return 0;
+	} while (get_timer(0) < (start + 100)); /* Wait 100ms */
+
+	return -ETIMEDOUT;
+}
+
+static unsigned long samsung_dsim_pll_find_pms(struct samsung_dsi *dsi,
+					       unsigned long fin,
+					       unsigned long fout,
+					       u8 *p, u16 *m, u8 *s)
+{
+	const struct samsung_dsim_driver_data *driver_data = dsi->driver_data;
+	unsigned long best_freq = 0;
+	u32 min_delta = 0xffffffff;
+	u8 p_min, p_max;
+	u8 _p, best_p;
+	u16 _m, best_m;
+	u8 _s, best_s;
+
+	p_min = DIV_ROUND_UP(fin, (MHZ(12)));
+	p_max = fin / (MHZ(6));
+
+	for (_p = p_min; _p <= p_max; ++_p) {
+		for (_s = 0; _s <= 5; ++_s) {
+			u64 tmp;
+			u32 delta;
+
+			tmp = (u64)fout * (_p << _s);
+			do_div(tmp, fin);
+			_m = tmp;
+			if (_m < driver_data->m_min || _m > driver_data->m_max)
+				continue;
+
+			tmp = (u64)_m * fin;
+			do_div(tmp, _p);
+			if (tmp < driver_data->min_freq  * MHZ(1) ||
+			    tmp > driver_data->max_freq * MHZ(1))
+				continue;
+
+			tmp = (u64)_m * fin;
+			do_div(tmp, _p << _s);
+
+			delta = abs(fout - tmp);
+			if (delta < min_delta) {
+				best_p = _p;
+				best_m = _m;
+				best_s = _s;
+				min_delta = delta;
+				best_freq = tmp;
+			}
+		}
+	}
+
+	if (best_freq) {
+		*p = best_p;
+		*m = best_m;
+		*s = best_s;
+	}
+
+	return best_freq;
+}
+
+static int samsung_dsi_config_pll(struct samsung_dsi *dsim)
+{
+	int ret;
+	u32 pllctrl = 0, status, data_lanes_en, stop;
+
+	writel(dsim->driver_data->reg_values[PLL_TIMER],
+	       dsim->reg_base + dsim->driver_data->plltmr_reg);
+
+	/* TODO: config dp/dn swap if requires */
+
+	pllctrl |= PLLCTRL_SET_PMS(dsim->pms) | PLLCTRL_PLLEN;
+	samsung_dsim_write(dsim, DSIM_PLLCTRL_REG, pllctrl);
+
+	ret = samsung_dsi_wait_pll_stable(dsim);
+	if (ret) {
+		log_err("wait for pll stable time out\n");
+		return ret;
+	}
+
+	/* wait for clk & data lanes to go to stop state */
+	mdelay(1);
+
+	data_lanes_en = (0x1 << dsim->lanes) - 1;
+	status = samsung_dsim_read(dsim, DSIM_STATUS_REG);
+	if (!(status & DSIM_STOP_STATE_CLK)) {
+		log_err("clock is not in stop state\n");
+		return -EBUSY;
+	}
+
+	stop = DSIM_STOP_STATE_DAT(status);
+	if ((stop & data_lanes_en) != data_lanes_en) {
+		log_err("one or more data lanes is not in stop state\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void samsung_dsi_set_main_mode(struct samsung_dsi *dsim)
+{
+	u32 bpp, hfp_wc, hbp_wc, hsa_wc, wc;
+	u32 mdresol = 0, mvporch = 0, mhporch = 0, msync = 0;
+	struct display_timing *timings = &dsim->timings;
+	unsigned int num_bits_resol = dsim->driver_data->num_bits_resol;
+
+	mdresol |= DSIM_MAIN_VRESOL(timings->vactive.typ, num_bits_resol) |
+		   DSIM_MAIN_HRESOL(timings->hactive.typ, num_bits_resol);
+	samsung_dsim_write(dsim, DSIM_MDRESOL_REG, mdresol);
+
+	mvporch |= MVPORCH_SET_MAINVBP(timings->vback_porch.typ)    |
+		   MVPORCH_SET_STABLEVFP(timings->vfront_porch.typ) |
+		   MVPORCH_SET_CMDALLOW(0x0);
+	samsung_dsim_write(dsim, DSIM_MVPORCH_REG, mvporch);
+
+	bpp = mipi_dsi_pixel_format_to_bpp(dsim->format);
+
+	wc = DIV_ROUND_UP(timings->hfront_porch.typ * (bpp >> 3), dsim->lanes);
+	hfp_wc = wc > MIPI_HFP_PKT_OVERHEAD ?
+		wc - MIPI_HFP_PKT_OVERHEAD : timings->hfront_porch.typ;
+	wc = DIV_ROUND_UP(timings->hback_porch.typ * (bpp >> 3), dsim->lanes);
+	hbp_wc = wc > MIPI_HBP_PKT_OVERHEAD ?
+		wc - MIPI_HBP_PKT_OVERHEAD : timings->hback_porch.typ;
+
+	mhporch |= MHPORCH_SET_MAINHFP(hfp_wc) |
+		   MHPORCH_SET_MAINHBP(hbp_wc);
+
+	samsung_dsim_write(dsim, DSIM_MHPORCH_REG, mhporch);
+
+	wc = DIV_ROUND_UP(timings->hsync_len.typ * (bpp >> 3), dsim->lanes);
+	hsa_wc = wc > MIPI_HSA_PKT_OVERHEAD ?
+		wc - MIPI_HSA_PKT_OVERHEAD : timings->hsync_len.typ;
+
+	msync |= MSYNC_SET_MAINVSA(timings->vsync_len.typ) |
+		 MSYNC_SET_MAINHSA(hsa_wc);
+
+	debug("hfp_wc %u hbp_wc %u hsa_wc %u\n", hfp_wc, hbp_wc, hsa_wc);
+
+	samsung_dsim_write(dsim, DSIM_MSYNC_REG, msync);
+}
+
+static void samsung_dsi_config_dpi(struct samsung_dsi *dsim)
+{
+	u32 config = 0, rgb_status = 0, data_lanes_en;
+
+	if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO)
+		rgb_status &= ~RGB_STATUS_CMDMODE_INSEL;
+	else
+		rgb_status |= RGB_STATUS_CMDMODE_INSEL;
+
+	samsung_dsim_write(dsim, DSIM_RGB_STATUS_REG, rgb_status);
+
+	if (dsim->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
+		config |= DSIM_CLKLANE_STOP;
+		config |= DSIM_NON_CONTINUOUS_CLKLANE;
+	}
+
+	if (dsim->mode_flags & MIPI_DSI_MODE_VSYNC_FLUSH)
+		config |= DSIM_MFLUSH_VS;
+
+	/* disable EoT packets in HS mode */
+	if (dsim->mode_flags & MIPI_DSI_MODE_EOT_PACKET)
+		config |= DSIM_EOT_DISABLE;
+
+	if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		config |= DSIM_VIDEO_MODE;
+
+		if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+			config |= DSIM_BURST_MODE;
+
+		else if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+			config |= DSIM_SYNC_INFORM;
+
+		if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_AUTO_VERT)
+			config |= DSIM_AUTO_MODE;
+
+		if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_HSE)
+			config |= DSIM_HSE_DISABLE_MODE;
+
+		if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_HFP)
+			config |= DSIM_HFP_DISABLE_MODE;
+
+		if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_HBP)
+			config |= DSIM_HBP_DISABLE_MODE;
+
+		if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO_HSA)
+			config |= DSIM_HSA_DISABLE_MODE;
+	}
+
+	config |= DSIM_MAIN_VC(dsim->channel);
+
+	if (dsim->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		switch (dsim->format) {
+		case MIPI_DSI_FMT_RGB888:
+			config |= DSIM_MAIN_PIX_FORMAT_RGB888;
+			break;
+		case MIPI_DSI_FMT_RGB666:
+			config |= DSIM_MAIN_PIX_FORMAT_RGB666;
+			break;
+		case MIPI_DSI_FMT_RGB666_PACKED:
+			config |= DSIM_MAIN_PIX_FORMAT_RGB666_P;
+			break;
+		case MIPI_DSI_FMT_RGB565:
+			config |= DSIM_MAIN_PIX_FORMAT_RGB565;
+			break;
+		default:
+			log_err("invalid pixel format\n");
+			break;
+		}
+	}
+
+	/* config data lanes number and enable lanes */
+	data_lanes_en = BIT(dsim->lanes) - 1;
+	config |= (DSIM_NUM_OF_DATA_LANE(dsim->lanes - 1) | DSIM_LANE_EN_CLK |
+			DSIM_LANE_EN(data_lanes_en));
+
+	debug("DSIM config 0x%x\n", config);
+
+	samsung_dsim_write(dsim, DSIM_CONFIG_REG, config);
+}
+
+static void samsung_dsi_config_cmd_lpm(struct samsung_dsi *dsim, bool enable)
+{
+	u32 escmode;
+
+	escmode = samsung_dsim_read(dsim, DSIM_ESCMODE_REG);
+
+	if (enable)
+		escmode |= ESCMODE_CMDLPDT;
+	else
+		escmode &= ~ESCMODE_CMDLPDT;
+
+	samsung_dsim_write(dsim, DSIM_ESCMODE_REG, escmode);
+}
+
+static void samsung_dsi_config_dphy(struct samsung_dsi *dsim)
+{
+	const struct samsung_dsim_driver_data *driver_data = dsim->driver_data;
+	const unsigned int *reg_values = driver_data->reg_values;
+	u32 reg;
+	struct phy_configure_opts_mipi_dphy cfg;
+	int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
+	int hs_exit, hs_prepare, hs_zero, hs_trail;
+	unsigned long long byte_clock = dsim->hs_clock / 8;
+
+	if (driver_data->has_freqband)
+		return;
+
+	phy_mipi_dphy_get_default_config_for_hsclk(dsim->hs_clock, dsim->lanes, &cfg);
+
+	/*
+	 * TODO:
+	 * The tech Applications Processor manuals for i.MX8M Mini, Nano,
+	 * and Plus don't state what the definition of the PHYTIMING
+	 * bits are beyond their address and bit position.
+	 * After reviewing NXP's downstream code, it appears
+	 * that the various PHYTIMING registers take the number
+	 * of cycles and use various dividers on them.  This
+	 * calculation does not result in an exact match to the
+	 * downstream code, but it is very close to the values
+	 * generated by their lookup table, and it appears
+	 * to sync at a variety of resolutions. If someone
+	 * can get a more accurate mathematical equation needed
+	 * for these registers, this should be updated.
+	 */
+
+	lpx = PS_TO_CYCLE(cfg.lpx, byte_clock);
+	hs_exit = PS_TO_CYCLE(cfg.hs_exit, byte_clock);
+	clk_prepare = PS_TO_CYCLE(cfg.clk_prepare, byte_clock);
+	clk_zero = PS_TO_CYCLE(cfg.clk_zero, byte_clock);
+	clk_post = PS_TO_CYCLE(cfg.clk_post, byte_clock);
+	clk_trail = PS_TO_CYCLE(cfg.clk_trail, byte_clock);
+	hs_prepare = PS_TO_CYCLE(cfg.hs_prepare, byte_clock);
+	hs_zero = PS_TO_CYCLE(cfg.hs_zero, byte_clock);
+	hs_trail = PS_TO_CYCLE(cfg.hs_trail, byte_clock);
+
+	/* B D-PHY: D-PHY Master & Slave Analog Block control */
+	reg = reg_values[PHYCTRL_ULPS_EXIT] | reg_values[PHYCTRL_VREG_LP] |
+		reg_values[PHYCTRL_SLEW_UP];
+
+	samsung_dsim_write(dsim, DSIM_PHYCTRL_REG, reg);
+
+	/*
+	 * T LPX: Transmitted length of any Low-Power state period
+	 * T HS-EXIT: Time that the transmitter drives LP-11 following a HS
+	 *	burst
+	 */
+
+	reg = DSIM_PHYTIMING_LPX(lpx) | DSIM_PHYTIMING_HS_EXIT(hs_exit);
+	samsung_dsim_write(dsim, DSIM_PHYTIMING_REG, reg);
+
+	/*
+	 * T CLK-PREPARE: Time that the transmitter drives the Clock Lane LP-00
+	 *	Line state immediately before the HS-0 Line state starting the
+	 *	HS transmission
+	 * T CLK-ZERO: Time that the transmitter drives the HS-0 state prior to
+	 *	transmitting the Clock.
+	 * T CLK_POST: Time that the transmitter continues to send HS clock
+	 *	after the last associated Data Lane has transitioned to LP Mode
+	 *	Interval is defined as the period from the end of T HS-TRAIL to
+	 *	the beginning of T CLK-TRAIL
+	 * T CLK-TRAIL: Time that the transmitter drives the HS-0 state after
+	 *	the last payload clock bit of a HS transmission burst
+	 */
+
+	reg = DSIM_PHYTIMING1_CLK_PREPARE(clk_prepare) |
+	      DSIM_PHYTIMING1_CLK_ZERO(clk_zero) |
+	      DSIM_PHYTIMING1_CLK_POST(clk_post) |
+	      DSIM_PHYTIMING1_CLK_TRAIL(clk_trail);
+
+	samsung_dsim_write(dsim, DSIM_PHYTIMING1_REG, reg);
+
+	/*
+	 * T HS-PREPARE: Time that the transmitter drives the Data Lane LP-00
+	 *	Line state immediately before the HS-0 Line state starting the
+	 *	HS transmission
+	 * T HS-ZERO: Time that the transmitter drives the HS-0 state prior to
+	 *	transmitting the Sync sequence.
+	 * T HS-TRAIL: Time that the transmitter drives the flipped differential
+	 *	state after last payload data bit of a HS transmission burst
+	 */
+
+	reg = DSIM_PHYTIMING2_HS_PREPARE(hs_prepare) |
+	      DSIM_PHYTIMING2_HS_ZERO(hs_zero) |
+	      DSIM_PHYTIMING2_HS_TRAIL(hs_trail);
+
+	samsung_dsim_write(dsim, DSIM_PHYTIMING2_REG, reg);
+
+	reg = DSIM_BTA_TIMEOUT(0xff) | DSIM_LPDR_TIMEOUT(0xffff);
+
+	samsung_dsim_write(dsim, DSIM_TIMEOUT_REG, reg);
+}
+
+static void samsung_dsim_write_pl_to_sfr_fifo(struct samsung_dsi *dsim,
+					      const void *payload,
+					      size_t length)
+{
+	u32 pl_data;
+
+	if (!length)
+		return;
+
+	while (length >= 4) {
+		pl_data = get_unaligned_le32(payload);
+		samsung_dsim_write(dsim, DSIM_PAYLOAD_REG, pl_data);
+		payload += 4;
+		length -= 4;
+	}
+
+	pl_data = 0;
+	switch (length) {
+	case 3:
+		pl_data |= ((u8 *)payload)[2] << 16;
+	case 2:
+		pl_data |= ((u8 *)payload)[1] << 8;
+	case 1:
+		pl_data |= ((u8 *)payload)[0];
+		samsung_dsim_write(dsim, DSIM_PAYLOAD_REG, pl_data);
+		break;
+	}
+}
+
+static void samsung_dsim_write_ph_to_sfr_fifo(struct samsung_dsi *dsim,
+					      void *header, bool use_lpm)
+{
+	u32 pkthdr;
+
+	pkthdr = PKTHDR_SET_DATA1(((u8 *)header)[2])	| /* WC MSB  */
+		 PKTHDR_SET_DATA0(((u8 *)header)[1])	| /* WC LSB  */
+		 PKTHDR_SET_DI(((u8 *)header)[0]);	  /* Data ID */
+
+	samsung_dsim_write(dsim, DSIM_PKTHDR_REG, pkthdr);
+}
+
+static int samsung_dsim_read_pl_from_sfr_fifo(struct samsung_dsi *dsim,
+					      void *payload, size_t length)
+{
+	u8 data_type;
+	u16 word_count = 0;
+	u32 fifoctrl, ph, pl;
+
+	fifoctrl = samsung_dsim_read(dsim, DSIM_FIFOCTRL_REG);
+
+	if (WARN_ON(fifoctrl & FIFOCTRL_EMPTYRX))
+		return -EINVAL;
+
+	ph = samsung_dsim_read(dsim, DSIM_RXFIFO_REG);
+	data_type = PKTHDR_GET_DT(ph);
+	switch (data_type) {
+	case MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT:
+		dev_err(dsim->device->dev, "peripheral report error: (0-7)%x, (8-15)%x\n",
+			PKTHDR_GET_DATA0(ph), PKTHDR_GET_DATA1(ph));
+		return -EPROTO;
+	case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE:
+	case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_2BYTE:
+		if (!WARN_ON(length < 2)) {
+			((u8 *)payload)[1] = PKTHDR_GET_DATA1(ph);
+			word_count++;
+		}
+		fallthrough;
+	case MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE:
+	case MIPI_DSI_RX_GENERIC_SHORT_READ_RESPONSE_1BYTE:
+		((u8 *)payload)[0] = PKTHDR_GET_DATA0(ph);
+		word_count++;
+		length = word_count;
+		break;
+	case MIPI_DSI_RX_DCS_LONG_READ_RESPONSE:
+	case MIPI_DSI_RX_GENERIC_LONG_READ_RESPONSE:
+		word_count = PKTHDR_GET_WC(ph);
+		if (word_count > length) {
+			dev_err(dsim->device->dev, "invalid receive buffer length\n");
+			return -EINVAL;
+		}
+
+		length = word_count;
+
+		while (word_count >= 4) {
+			pl = samsung_dsim_read(dsim, DSIM_RXFIFO_REG);
+			((u8 *)payload)[0] = pl & 0xff;
+			((u8 *)payload)[1] = (pl >> 8)  & 0xff;
+			((u8 *)payload)[2] = (pl >> 16) & 0xff;
+			((u8 *)payload)[3] = (pl >> 24) & 0xff;
+			payload += 4;
+			word_count -= 4;
+		}
+
+		if (word_count > 0) {
+			pl = samsung_dsim_read(dsim, DSIM_RXFIFO_REG);
+
+			switch (word_count) {
+			case 3:
+				((u8 *)payload)[2] = (pl >> 16) & 0xff;
+			case 2:
+				((u8 *)payload)[1] = (pl >> 8) & 0xff;
+			case 1:
+				((u8 *)payload)[0] = pl & 0xff;
+				break;
+			}
+		}
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return length;
+}
+
+static void samsung_dsi_init_fifo_pointers(struct samsung_dsi *dsim)
+{
+	u32 fifoctrl, fifo_ptrs;
+
+	fifoctrl = samsung_dsim_read(dsim, DSIM_FIFOCTRL_REG);
+
+	fifo_ptrs = FIFOCTRL_NINITRX	|
+		    FIFOCTRL_NINITSFR	|
+		    FIFOCTRL_NINITI80	|
+		    FIFOCTRL_NINITSUB	|
+		    FIFOCTRL_NINITMAIN;
+
+	fifoctrl &= ~fifo_ptrs;
+	samsung_dsim_write(dsim, DSIM_FIFOCTRL_REG, fifoctrl);
+	udelay(500);
+
+	fifoctrl |= fifo_ptrs;
+	samsung_dsim_write(dsim, DSIM_FIFOCTRL_REG, fifoctrl);
+	udelay(500);
+}
+
+static void samsung_dsi_config_clkctrl(struct samsung_dsi *dsim)
+{
+	u32 clkctrl = 0, data_lanes_en;
+	u64 byte_clk, esc_prescaler;
+
+	clkctrl |= DSIM_TX_REQUEST_HSCLK;
+
+	/* using 1.5Gbps PHY */
+	clkctrl |= CLKCTRL_DPHY_SEL_1P5G;
+	clkctrl |= DSIM_ESC_CLKEN;
+	clkctrl &= ~CLKCTRL_PLLBYPASS;
+	clkctrl |= CLKCTRL_BYTECLKSRC_DPHY_PLL;
+	clkctrl |= DSIM_BYTE_CLKEN;
+
+	data_lanes_en = (0x1 << dsim->lanes) - 1;
+	clkctrl |= CLKCTRL_SET_LANEESCCLKEN(0x1 | data_lanes_en << 1);
+
+	/* calculate esc prescaler from byte clock:
+	 * EscClk = ByteClk / EscPrescaler;
+	 */
+	byte_clk = dsim->bit_clk >> 3;
+	esc_prescaler = DIV_ROUND_UP_ULL(byte_clk, MAX_ESC_CLK_FREQ);
+
+	clkctrl |= CLKCTRL_SET_ESCPRESCALER(esc_prescaler);
+
+	debug("DSIM clkctrl 0x%x\n", clkctrl);
+
+	samsung_dsim_write(dsim, DSIM_CLKCTRL_REG, clkctrl);
+}
+
+static void samsung_dsi_set_standby(struct samsung_dsi *dsim, bool standby)
+{
+	u32 mdresol = 0;
+
+	mdresol = samsung_dsim_read(dsim, DSIM_MDRESOL_REG);
+
+	if (standby)
+		mdresol |= DSIM_MAIN_STAND_BY;
+	else
+		mdresol &= ~DSIM_MAIN_STAND_BY;
+
+	samsung_dsim_write(dsim, DSIM_MDRESOL_REG, mdresol);
+}
+
+static void samsung_dsi_disable_clock(struct samsung_dsi *dsim)
+{
+	u32 reg;
+
+	reg = samsung_dsim_read(dsim, DSIM_CLKCTRL_REG);
+	reg &= ~(DSIM_LANE_ESC_CLK_EN_CLK | DSIM_LANE_ESC_CLK_EN_DATA_MASK |
+		 DSIM_ESC_CLKEN | DSIM_BYTE_CLKEN);
+	samsung_dsim_write(dsim, DSIM_CLKCTRL_REG, reg);
+
+	reg = samsung_dsim_read(dsim, DSIM_PLLCTRL_REG);
+	reg &= ~DSIM_PLL_EN;
+	samsung_dsim_write(dsim, DSIM_PLLCTRL_REG, reg);
+}
+
+static inline struct samsung_dsi *host_to_dsi(struct mipi_dsi_host *host)
+{
+	return container_of(host, struct samsung_dsi, dsi_host);
+}
+
+static int samsung_dsi_bridge_clk_set(struct samsung_dsi *dsim_host)
+{
+	int bpp;
+	unsigned long pix_clk, bit_clk;
+	unsigned long fin, fout;
+	u8 p, s;
+	u16 m;
+
+	bpp = mipi_dsi_pixel_format_to_bpp(dsim_host->format);
+	if (bpp < 0)
+		return -EINVAL;
+
+	pix_clk = dsim_host->timings.pixelclock.typ;
+	bit_clk = DIV_ROUND_UP_ULL(pix_clk * bpp, dsim_host->lanes);
+
+	dsim_host->pix_clk = DIV_ROUND_UP_ULL(pix_clk, 1000);
+	dsim_host->bit_clk = DIV_ROUND_UP_ULL(bit_clk, 1000);
+
+	fout = dsim_host->bit_clk;
+	fin  = clk_get_rate(&dsim_host->sclk_mipi);
+	if (fin == 0) {
+		log_err("Error: DSI PHY reference clock is disabled\n");
+		return -EINVAL;
+	}
+
+	fout = samsung_dsim_pll_find_pms(dsim_host, fin, bit_clk, &p, &m, &s);
+	if (!fout) {
+		log_err("failed to find PLL PMS for requested frequency\n");
+		return -EINVAL;
+	}
+	dsim_host->pms = PLLCTRL_SET_P(p) | PLLCTRL_SET_M(m) |
+			 PLLCTRL_SET_S(s);
+	dsim_host->hs_clock = fout;
+
+	debug("%s: bitclk %llu pixclk %llu pms 0x%x\n", __func__,
+	      dsim_host->bit_clk, dsim_host->pix_clk, dsim_host->pms);
+
+	return 0;
+}
+
+static int samsung_dsi_bridge_prepare(struct samsung_dsi *dsim_host)
+{
+	int ret;
+
+	/* At this moment, the dsim bridge's preceding encoder has
+	 * already been enabled. So the dsim can be configured here
+	 */
+
+	/* config main display mode */
+	samsung_dsi_set_main_mode(dsim_host);
+
+	/* config dsim dpi */
+	samsung_dsi_config_dpi(dsim_host);
+
+	/* config dsim pll */
+	ret = samsung_dsi_config_pll(dsim_host);
+	if (ret) {
+		log_err("dsim pll config failed: %d\n", ret);
+		return ret;
+	}
+
+	/* config dphy timings */
+	samsung_dsi_config_dphy(dsim_host);
+
+	samsung_dsi_init_fifo_pointers(dsim_host);
+
+	/* config esc clock, byte clock and etc */
+	samsung_dsi_config_clkctrl(dsim_host);
+
+	return 0;
+}
+
+static int samsung_dsi_host_attach(struct mipi_dsi_host *host,
+				   struct mipi_dsi_device *device)
+{
+	struct samsung_dsi *dsi = host_to_dsi(host);
+
+	if (!device->lanes || device->lanes > dsi->max_data_lanes) {
+		log_err("invalid data lanes number\n");
+		return -EINVAL;
+	}
+
+	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO)		||
+	    !((device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)	||
+	      (device->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))) {
+		log_err("unsupported dsi mode\n");
+		return -EINVAL;
+	}
+
+	if (device->format != MIPI_DSI_FMT_RGB888 &&
+	    device->format != MIPI_DSI_FMT_RGB565 &&
+	    device->format != MIPI_DSI_FMT_RGB666 &&
+	    device->format != MIPI_DSI_FMT_RGB666_PACKED) {
+		log_err("unsupported pixel format: %#x\n", device->format);
+		return -EINVAL;
+	}
+
+	dsi->lanes	 = device->lanes;
+	dsi->channel	 = device->channel;
+	dsi->format	 = device->format;
+	dsi->mode_flags = device->mode_flags;
+
+	debug("lanes %u, channel %u, format 0x%x, mode_flags 0x%lx\n", dsi->lanes,
+	      dsi->channel, dsi->format, dsi->mode_flags);
+
+	samsung_dsi_bridge_clk_set(dsi);
+	samsung_dsi_bridge_prepare(dsi);
+
+	return 0;
+}
+
+static ssize_t samsung_dsi_host_transfer(struct mipi_dsi_host *host,
+					 const struct mipi_dsi_msg *msg)
+{
+	struct samsung_dsi *dsim = host_to_dsi(host);
+	int ret, nb_bytes;
+	bool use_lpm;
+	struct mipi_dsi_packet packet;
+
+	ret = mipi_dsi_create_packet(&packet, msg);
+	if (ret) {
+		dev_err(dsim->device->dev, "failed to create dsi packet: %d\n", ret);
+		return ret;
+	}
+
+	/* config LPM for CMD TX */
+	use_lpm = msg->flags & MIPI_DSI_MSG_USE_LPM ? true : false;
+	samsung_dsi_config_cmd_lpm(dsim, use_lpm);
+
+	if (packet.payload_length) {		/* Long Packet case */
+		/* write packet payload */
+		samsung_dsim_write_pl_to_sfr_fifo(dsim, packet.payload,
+						  packet.payload_length);
+
+		/* write packet header */
+		samsung_dsim_write_ph_to_sfr_fifo(dsim, packet.header, use_lpm);
+
+		ret = samsung_dsi_wait_for_pkt_done(dsim, MIPI_FIFO_TIMEOUT);
+		if (ret) {
+			dev_err(dsim->device->dev, "wait tx done timeout!\n");
+			return -EBUSY;
+		}
+	} else {
+		/* write packet header */
+		samsung_dsim_write_ph_to_sfr_fifo(dsim, packet.header, use_lpm);
+
+		ret = samsung_dsi_wait_for_hdr_done(dsim, MIPI_FIFO_TIMEOUT);
+		if (ret) {
+			dev_err(dsim->device->dev, "wait pkthdr tx done time out\n");
+			return -EBUSY;
+		}
+	}
+
+	/* read packet payload */
+	if (unlikely(msg->rx_buf)) {
+		ret = samsung_dsi_wait_for_rx_done(dsim, MIPI_FIFO_TIMEOUT);
+		if (ret) {
+			dev_err(dsim->device->dev, "wait rx done time out\n");
+			return -EBUSY;
+		}
+
+		ret = samsung_dsim_read_pl_from_sfr_fifo(dsim, msg->rx_buf,
+							 msg->rx_len);
+		if (ret < 0)
+			return ret;
+		nb_bytes = msg->rx_len;
+	} else {
+		nb_bytes = packet.size;
+	}
+
+	return nb_bytes;
+}
+
+static const struct mipi_dsi_host_ops samsung_dsi_host_ops = {
+	.attach = samsung_dsi_host_attach,
+	.transfer = samsung_dsi_host_transfer,
+};
+
+static int samsung_dsi_init(struct udevice *dev,
+			    struct mipi_dsi_device *device,
+			    struct display_timing *timings,
+			    unsigned int max_data_lanes,
+			    const struct mipi_dsi_phy_ops *phy_ops)
+{
+	struct samsung_dsi *dsi = dev_get_priv(dev);
+	struct udevice *dsi_bridge = device->dev;
+	enum samsung_dsim_type hw_type = (enum samsung_dsim_type)dev_get_driver_data(dsi_bridge);
+
+	dsi->max_data_lanes = max_data_lanes;
+	dsi->device = device;
+	dsi->dsi_host.ops = &samsung_dsi_host_ops;
+	dsi->driver_data = samsung_dsim_types[hw_type];
+	device->host = &dsi->dsi_host;
+
+	dsi->reg_base = (void *)dev_read_addr(device->dev);
+	if ((fdt_addr_t)dsi->reg_base == FDT_ADDR_T_NONE) {
+		dev_err(device->dev, "dsi dt register address error\n");
+		return -EINVAL;
+	}
+
+	dsi->timings = *timings;
+
+	return 0;
+}
+
+static int samsung_dsi_enable(struct udevice *dev)
+{
+	struct samsung_dsi *dsim_host = dev_get_priv(dev);
+
+	/* enable data transfer of dsim */
+	samsung_dsi_set_standby(dsim_host, true);
+
+	return 0;
+}
+
+static int samsung_dsi_disable(struct udevice *dev)
+{
+	u32 intsrc;
+	struct samsung_dsi *dsim_host = dev_get_priv(dev);
+
+	/* disable data transfer of dsim */
+	samsung_dsi_set_standby(dsim_host, false);
+
+	/* disable esc clock & byte clock & dsim pll */
+	samsung_dsi_disable_clock(dsim_host);
+
+	/* Clear all intsrc */
+	intsrc = samsung_dsim_read(dsim_host, DSIM_INTSRC_REG);
+	samsung_dsim_write(dsim_host, DSIM_INTSRC_REG, intsrc);
+
+	return 0;
+}
+
+struct dsi_host_ops samsung_dsi_ops = {
+	.init = samsung_dsi_init,
+	.enable = samsung_dsi_enable,
+	.disable = samsung_dsi_disable,
+};
+
+static int samsung_dsi_probe(struct udevice *dev)
+{
+	struct samsung_dsi *dsim_host = dev_get_priv(dev);
+	int ret;
+
+	ret = clk_get_by_name(dev, "sclk_mipi", &dsim_host->sclk_mipi);
+	if (ret)
+		debug("Failed to get sclk_mipi clock\n");
+
+	return ret;
+}
+
+U_BOOT_DRIVER(samsung_dsi) = {
+	.name			= "samsung_dsi",
+	.id			= UCLASS_DSI_HOST,
+	.probe			= samsung_dsi_probe,
+	.remove			= samsung_dsi_disable,
+	.ops			= &samsung_dsi_ops,
+	.priv_auto		= sizeof(struct samsung_dsi),
+};
diff --git a/drivers/video/bridge/samsung-dsim.c b/drivers/video/bridge/samsung-dsim.c
new file mode 100644
index 000000000000..5a366fa976c5
--- /dev/null
+++ b/drivers/video/bridge/samsung-dsim.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Amarula Solutions
+ * Copyright 2019 NXP
+ *
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dsi_host.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <video.h>
+#include <video_bridge.h>
+#include <video_link.h>
+#include <asm/io.h>
+#include <asm/arch/gpio.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+#include <power/regulator.h>
+#include "samsung-dsim.h"
+
+struct samsung_dsim_priv {
+	struct mipi_dsi_device device;
+	void __iomem *base;
+	struct udevice *panel;
+	struct udevice *dsi_host;
+};
+
+static int samsung_dsim_attach(struct udevice *dev)
+{
+	struct samsung_dsim_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_device *device = &priv->device;
+	struct mipi_dsi_panel_plat *mplat;
+	struct display_timing timings;
+	int ret;
+
+	priv->panel = video_link_get_next_device(dev);
+	if (!priv->panel || device_get_uclass_id(priv->panel) != UCLASS_PANEL) {
+		dev_err(dev, "get panel device error\n");
+		return -ENODEV;
+	}
+
+	mplat = dev_get_plat(priv->panel);
+	mplat->device = &priv->device;
+
+	ret = video_link_get_display_timings(&timings);
+	if (ret) {
+		dev_err(dev, "decode display timing error %d\n", ret);
+		return ret;
+	}
+
+	ret = uclass_get_device(UCLASS_DSI_HOST, 0, &priv->dsi_host);
+	if (ret) {
+		dev_err(dev, "No video dsi host detected %d\n", ret);
+		return ret;
+	}
+
+	/* allow to use the compatible */
+	device->dev = dev;
+	ret = dsi_host_init(priv->dsi_host, device, &timings, 4,
+			    NULL);
+	if (ret) {
+		dev_err(dev, "failed to initialize mipi dsi host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int samsung_dsim_set_backlight(struct udevice *dev, int percent)
+{
+	struct samsung_dsim_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = panel_enable_backlight(priv->panel);
+	if (ret) {
+		dev_err(dev, "panel %s enable backlight error %d\n",
+			priv->panel->name, ret);
+		return ret;
+	}
+
+	ret = dsi_host_enable(priv->dsi_host);
+	if (ret) {
+		dev_err(dev, "failed to enable mipi dsi host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int samsung_dsim_bind(struct udevice *dev)
+{
+	int ret;
+
+	/* The DSI host shares the DSIM node with the bridge */
+	ret = device_bind_driver_to_node(dev, "samsung_dsi", "dsihost",
+					 dev_ofnode(dev), NULL);
+	if (ret)
+		return ret;
+
+	return dm_scan_fdt_dev(dev);
+}
+
+static int samsung_dsim_probe(struct udevice *dev)
+{
+	struct samsung_dsim_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_device *device = &priv->device;
+
+	device->dev = dev;
+
+	return 0;
+}
+
+static int samsung_dsim_remove(struct udevice *dev)
+{
+	struct samsung_dsim_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (priv->panel)
+		device_remove(priv->panel, DM_REMOVE_NORMAL);
+
+	ret = dsi_host_disable(priv->dsi_host);
+	if (ret) {
+		dev_err(dev, "failed to enable mipi dsi host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int samsung_dsim_check_timing(struct udevice *dev, struct display_timing *timings)
+{
+	timings->flags &= ~DISPLAY_FLAGS_DE_HIGH;
+	return 0;
+}
+
+struct video_bridge_ops samsung_dsim_ops = {
+	.attach = samsung_dsim_attach,
+	.set_backlight = samsung_dsim_set_backlight,
+	.check_timing = samsung_dsim_check_timing,
+};
+
+static const struct udevice_id samsung_dsim_ids[] = {
+	{ .compatible = "fsl,imx8mm-mipi-dsim", .data = DSIM_TYPE_IMX8MM },
+	{ .compatible = "fsl,imx8mn-mipi-dsim", .data = DSIM_TYPE_IMX8MM },
+	{ }
+};
+
+U_BOOT_DRIVER(samsung_dsim) = {
+	.name				= "samsung_dsim",
+	.id				= UCLASS_VIDEO_BRIDGE,
+	.of_match			= samsung_dsim_ids,
+	.bind				= samsung_dsim_bind,
+	.remove				= samsung_dsim_remove,
+	.probe				= samsung_dsim_probe,
+	.ops				= &samsung_dsim_ops,
+	.priv_auto		= sizeof(struct samsung_dsim_priv),
+};
diff --git a/drivers/video/bridge/samsung-dsim.h b/drivers/video/bridge/samsung-dsim.h
new file mode 100644
index 000000000000..9bb2a379589b
--- /dev/null
+++ b/drivers/video/bridge/samsung-dsim.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Amarula Solutions
+ */
+
+#ifndef SAMSUNG_DSIM_H
+#define SAMSUNG_DSIM_H
+
+enum samsung_dsim_type {
+	DSIM_TYPE_EXYNOS3250,
+	DSIM_TYPE_EXYNOS4210,
+	DSIM_TYPE_EXYNOS5410,
+	DSIM_TYPE_EXYNOS5422,
+	DSIM_TYPE_EXYNOS5433,
+	DSIM_TYPE_IMX8MM,
+	DSIM_TYPE_IMX8MP,
+	DSIM_TYPE_COUNT,
+};
+
+#endif
-- 
2.43.0

