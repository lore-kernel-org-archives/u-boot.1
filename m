Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F21BC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 17:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DEC817D3;
	Wed, 12 Mar 2025 18:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FqZ4kYFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A918056A; Wed, 12 Mar 2025 18:59:24 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32228056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso23192566b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802362; x=1742407162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn8UeEiXeDK0vAt/+b7Z73pbS+1kobx7gkjmMFV48UQ=;
 b=FqZ4kYFS4UDLH6EKFQdpZo+KxXfhJbR/A/bMLZhNHGiR8pRZIi1wxHIZriebShYBMU
 Uh1OzkM3zzj9jrKhseRMOYWIzQ52fZp4knh0Mh2gszfjfbyiYQDPDf/xZQBBTEKbO3eN
 Z25+jT97KYfUopG98eZgSgnZOVXCETp+n0DOk0i5/3uPuFIjhShNYIzIlaRelGugLq/t
 2HKkIx8xOGla2/fwhBnl0byLcUDrnFzsp/kp1jRUgxgRJmDY4k8sqH+aJTt54bNZY9Qq
 n3LGto/6LsIgWOmCb+kxflvyXguyc4Qc1EgHFMiS0KgXnYVsg/9j3/r9vnP7EOpYOMbm
 yL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802362; x=1742407162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pn8UeEiXeDK0vAt/+b7Z73pbS+1kobx7gkjmMFV48UQ=;
 b=ItLT1M/zdbt7MflsxxtnnYzJviqp10692PceTMPzvO6d4McZbXLbFr4cwdnRBTpRys
 GQ/Me3itzqEpr1kTjMxROElZlcNWNGqxljhVCll3Q3yNRnilnAWQnTbm8yrEUExtL1DV
 IbX7H+eHjcq7NDHcoT8rUXM5f6t6FEiK4AsZy+3U6TuddZvDxVeW53aRwWqp5zrxrjqG
 dtp/hOi65amfn8ZhAFMZ1KH5nhD0aauDAL85zC1+JHLfGFTqHE0XPR2KQTcjGV2wiSDr
 ZPAciAp4Iynd6BzeUy2zAk/J/sVF0W1IqRSooQ3l68XpM6p6eNiZWks/z6laoTELQoY/
 0V+w==
X-Gm-Message-State: AOJu0YyxWSCg0/FkkZZDdJQwshoac3hgeUeq4nIgimk8PcLRFr559Mcn
 IDkFwnmSoMetqyzVHjJBVMY/W2kDY1HTM6PBFo5jpLhHobTaQWpP
X-Gm-Gg: ASbGnctGQvgkr7YnMHoN99QBumgAzAwj453PQ5mjVUYnhjUc+x2F1UCKRLyW4UN6waq
 09VKkmU5kU67MgVV9tvNvyVTANM5u/y6QgkOJM4sm5ScXVibHFWUnc09VNfQDDgsSZ6TZxsSPHl
 mVk8DVf4bRHRf+WYNo49quWc+guL97CbTtxXbXjhOHxGxOxref5jBaTLmoSc4M4x/CdzJ2KeCQt
 QFDNiMXBV8yYgsALyVoOe10j5OZSjA89wuGi/UsFAG9OdMK/71i/4sbzHvzvqAX/OL8qSpCFOIi
 gdWPs/89wD/mzloOqoSd6YsM+/JhbL5vLatrOLbxz4n7ObI=
X-Google-Smtp-Source: AGHT+IFqlL7avQY1iPbxnqAslCn6RYPy+dMHQhrRoo9HUKFXPVZpAzU92HW8Ac8nDfswhIANz1/HRA==
X-Received: by 2002:a17:907:9455:b0:abe:fed3:9eb8 with SMTP id
 a640c23a62f3a-ac252f5c8b9mr3330972966b.41.1741802361916; 
 Wed, 12 Mar 2025 10:59:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 01/10] video: tegra20: implement a minimal HOST1X driver
 for essential clock and reset setup
Date: Wed, 12 Mar 2025 19:58:48 +0200
Message-ID: <20250312175857.120313-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

Introduce a simplified HOST1X driver, limited to the basic clock and reset
initialization of the bus.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/Kconfig        |  5 ++
 drivers/video/tegra20/Makefile       |  1 +
 drivers/video/tegra20/tegra-dc.c     |  5 --
 drivers/video/tegra20/tegra-host1x.c | 86 ++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 5 deletions(-)
 create mode 100644 drivers/video/tegra20/tegra-host1x.c

diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra20/Kconfig
index f5c4843e119..d7c402e95fd 100644
--- a/drivers/video/tegra20/Kconfig
+++ b/drivers/video/tegra20/Kconfig
@@ -1,6 +1,11 @@
+config HOST1X_TEGRA
+	bool "NVIDIA Tegra host1x BUS support"
+	depends on SIMPLE_BUS
+
 config VIDEO_TEGRA20
 	bool "Enable Display Controller support on Tegra20 and Tegra 30"
 	depends on OF_CONTROL
+	select HOST1X_TEGRA
 	help
 	   T20/T30 support video output to an attached LCD panel as well as
 	   other options such as HDMI. Only the LCD is supported in U-Boot.
diff --git a/drivers/video/tegra20/Makefile b/drivers/video/tegra20/Makefile
index a75aea2a875..c0fd42a72d5 100644
--- a/drivers/video/tegra20/Makefile
+++ b/drivers/video/tegra20/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+obj-$(CONFIG_HOST1X_TEGRA) += tegra-host1x.o
 obj-$(CONFIG_VIDEO_TEGRA20) += tegra-dc.o
 obj-$(CONFIG_VIDEO_DSI_TEGRA30) += tegra-dsi.o tegra-mipi.o mipi-phy.o
 obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += tegra-pwm-backlight.o
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 16a2b5281bf..001967f2a5a 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -319,11 +319,6 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 						/ priv->pixel_clock) - 2;
 	log_debug("Display clock %lu, divider %lu\n", rate, priv->scdiv);
 
-	/*
-	 * HOST1X is init by default at 150MHz with PLLC as parent
-	 */
-	clock_start_periph_pll(PERIPH_ID_HOST1X, CLOCK_ID_CGENERAL,
-			       150 * 1000000);
 	clock_start_periph_pll(priv->clk->id, priv->clk_parent->id,
 			       rate);
 
diff --git a/drivers/video/tegra20/tegra-host1x.c b/drivers/video/tegra20/tegra-host1x.c
new file mode 100644
index 00000000000..58ab871a3b4
--- /dev/null
+++ b/drivers/video/tegra20/tegra-host1x.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <clk.h>
+#include <log.h>
+#include <reset.h>
+#include <linux/delay.h>
+
+#include <asm/arch/clock.h>
+#include <asm/arch-tegra/clk_rst.h>
+
+struct tegra_host1x_info {
+	u32 clk_parent;
+	u32 rate;
+};
+
+static int tegra_host1x_probe(struct udevice *dev)
+{
+	struct clk *clk;
+	struct reset_ctl reset_ctl;
+	const struct tegra_host1x_info *info;
+	int ret;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		log_debug("%s: cannot get HOST1X clock: %ld\n",
+			  __func__, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = reset_get_by_name(dev, "host1x", &reset_ctl);
+	if (ret) {
+		log_debug("%s: cannot get HOST1X reset: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	info = (struct tegra_host1x_info *)dev_get_driver_data(dev);
+
+	reset_assert(&reset_ctl);
+	clock_start_periph_pll(clk->id, info->clk_parent, info->rate);
+
+	mdelay(2);
+	reset_deassert(&reset_ctl);
+
+	return 0;
+}
+
+static const struct tegra_host1x_info tegra20_host1x_info = {
+	.clk_parent = CLOCK_ID_CGENERAL,
+	.rate = 150000000, /* 150 MHz */
+};
+
+static const struct tegra_host1x_info tegra114_host1x_info = {
+	.clk_parent = CLOCK_ID_PERIPH,
+	.rate = 136000000, /* 136 MHz */
+};
+
+static const struct udevice_id tegra_host1x_ids[] = {
+	{
+		.compatible = "nvidia,tegra20-host1x",
+		.data = (ulong)&tegra20_host1x_info
+	}, {
+		.compatible = "nvidia,tegra30-host1x",
+		.data = (ulong)&tegra20_host1x_info
+	}, {
+		.compatible = "nvidia,tegra114-host1x",
+		.data = (ulong)&tegra114_host1x_info
+	}, {
+		.compatible = "nvidia,tegra124-host1x",
+		.data = (ulong)&tegra114_host1x_info
+	}, {
+		/* sentinel */
+	}
+};
+
+U_BOOT_DRIVER(tegra_host1x) = {
+	.name		= "tegra_host1x",
+	.id		= UCLASS_SIMPLE_BUS,
+	.of_match	= tegra_host1x_ids,
+	.probe		= tegra_host1x_probe,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.43.0

