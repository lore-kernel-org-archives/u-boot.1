Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43941C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B33E88967;
	Thu,  1 Aug 2024 07:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="czau3Qi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC68F884BE; Thu,  1 Aug 2024 07:33:45 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4AB88ADA
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so2801355a12.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722490422; x=1723095222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMw6nSK/bj3k0MpybUw/oCW/apySRZLpdg0k0rEuspA=;
 b=czau3Qi0qukiyqPBIC0TuT30skPQ1bjgalJtxxreziGFt58tuxJluDa1D95HOOTTmT
 VhOzXZJLYPpcZf5T9tmlykmZQvc+s9h1wumwjJu0BmvJpyjVOOFla8jLzRrBvDa+Om3r
 Ge233KVgP3Yvc/q+WCqupnE/KGNxB48qLTqMTjmoExjH4IhKLQ0Pp1SO/j6l1RIh/2K2
 dG6HPNPe/h/fccQxJNny40BYfi2BaggklaaNFoMGciOPv8JV5QAHuvQDxTnxcs/1hzQO
 eJjnxE3jXxd513EUOotn711GxmeEsJ4+mqEf/LBZ1iiUKcf1f32C9959Tgp9cBeclOXV
 fMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490422; x=1723095222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMw6nSK/bj3k0MpybUw/oCW/apySRZLpdg0k0rEuspA=;
 b=G62MrEuplAoipMBTb5s4arqBT1uMyeovfxCHqwGp/nqe2VU7Zcwnrz1MHQH6xTyX8A
 1j4wscu8ugmfctfpmTwleWr9irTpxUzk7tXL4HapGjZi4QtYROtTdBbt16Rkc0wDN3F7
 fkocXwknk7+trSVnVglfPz9Va5LUB0cfRlxv75Bh7OMupkmgYLEQ5l8skM4PwSdQP/3P
 MM3n1rr4hjv2UuaCgunYWSY1YqtCvivackMLB20I0/79N5z5SF2tv4Nk6GV4NllR0LfG
 gjvmBtQkF/qAK1wvGKCxDUdeKENAW4aKUcg7bmD90Xf9moRK72psT827TsXGYugQBqKD
 z3AQ==
X-Gm-Message-State: AOJu0YzNiEcKwTF73eJiV2zgKULPsh6fgkDs/OP0HZeFAtd2vxy9DeEm
 IJRC4cr7APy+olivZRzQ5rpAvit//DcQtng3vJMTWeFocvUzHDrS
X-Google-Smtp-Source: AGHT+IG9ilpdJTuhNf3Rojljm3Nva4cipbn4kdaokpAp11aIeeaLsq6R2Tv6sM7lw4TMW6oNspmTUA==
X-Received: by 2002:a50:ef17:0:b0:5af:5538:e03e with SMTP id
 4fb4d7f45d1cf-5b77c974c1fmr157635a12.9.1722490422293; 
 Wed, 31 Jul 2024 22:33:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3a95sm9477990a12.61.2024.07.31.22.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:33:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] video: tegra20: dsi: add ganged mode support
Date: Thu,  1 Aug 2024 08:33:14 +0300
Message-ID: <20240801053315.6428-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801053315.6428-1-clamor95@gmail.com>
References: <20240801053315.6428-1-clamor95@gmail.com>
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

Implement ganged mode support for the Tegra DSI driver. The DSI host
controller to gang up with is specified via a phandle in the device tree
and the resolved DSI host controller used for the programming of the
ganged-mode registers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 95 +++++++++++++++++++++++++++++--
 drivers/video/tegra20/tegra-dsi.h | 15 ++++-
 2 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 35a8e6c176..6327266dd2 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -20,6 +20,7 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
+#include <asm/arch-tegra/clk_rst.h>
 
 #include "tegra-dc.h"
 #include "tegra-dsi.h"
@@ -50,6 +51,10 @@ struct tegra_dsi_priv {
 	int host_fifo_depth;
 
 	u32 version;
+
+	/* for ganged-mode support */
+	struct udevice *master;
+	struct udevice *slave;
 };
 
 static void tegra_dc_enable_controller(struct udevice *dev)
@@ -595,6 +600,17 @@ static void tegra_dsi_set_phy_timing(struct dsi_timing_reg *ptiming,
 	writel(value, &ptiming->dsi_bta_timing);
 }
 
+static void tegra_dsi_ganged_enable(struct udevice *dev, unsigned int start,
+				    unsigned int size)
+{
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct dsi_ganged_mode_reg *ganged = &priv->dsi->ganged;
+
+	writel(start, &ganged->ganged_mode_start);
+	writel(size << 16 | size, &ganged->ganged_mode_size);
+	writel(DSI_GANGED_MODE_CONTROL_ENABLE, &ganged->ganged_mode_ctrl);
+}
+
 static void tegra_dsi_configure(struct udevice *dev,
 				unsigned long mode_flags)
 {
@@ -679,9 +695,19 @@ static void tegra_dsi_configure(struct udevice *dev,
 		writel(hact << 16 | hbp, &len->dsi_pkt_len_2_3);
 		writel(hfp, &len->dsi_pkt_len_4_5);
 		writel(0x0f0f << 16, &len->dsi_pkt_len_6_7);
+
+		/* set SOL delay (for non-burst mode only) */
+		writel(8 * mul / div, &misc->dsi_sol_delay);
 	} else {
-		/* 1 byte (DCS command) + pixel data */
-		value = 1 + timing->hactive.typ * mul / div;
+		if (priv->master || priv->slave) {
+			/*
+			 * For ganged mode, assume symmetric left-right mode.
+			 */
+			value = 1 + (timing->hactive.typ / 2) * mul / div;
+		} else {
+			/* 1 byte (DCS command) + pixel data */
+			value = 1 + timing->hactive.typ * mul / div;
+		}
 
 		writel(0, &len->dsi_pkt_len_0_1);
 		writel(value << 16, &len->dsi_pkt_len_2_3);
@@ -691,10 +717,40 @@ static void tegra_dsi_configure(struct udevice *dev,
 		value = MIPI_DCS_WRITE_MEMORY_START << 8 |
 			MIPI_DCS_WRITE_MEMORY_CONTINUE;
 		writel(value, &len->dsi_dcs_cmds);
+
+		/* set SOL delay */
+		if (priv->master || priv->slave) {
+			unsigned long delay, bclk, bclk_ganged;
+			unsigned int lanes = device->lanes;
+			unsigned long htotal = timing->hactive.typ + timing->hfront_porch.typ +
+					       timing->hback_porch.typ + timing->hsync_len.typ;
+
+			/* SOL to valid, valid to FIFO and FIFO write delay */
+			delay = 4 + 4 + 2;
+			delay = DIV_ROUND_UP(delay * mul, div * lanes);
+			/* FIFO read delay */
+			delay = delay + 6;
+
+			bclk = DIV_ROUND_UP(htotal * mul, div * lanes);
+			bclk_ganged = DIV_ROUND_UP(bclk * lanes / 2, lanes);
+			value = bclk - bclk_ganged + delay + 20;
+		} else {
+			/* TODO: revisit for non-ganged mode */
+			value = 8 * mul / div;
+		}
+
+		writel(value, &misc->dsi_sol_delay);
 	}
 
-	/* set SOL delay (for non-burst mode only) */
-	writel(8 * mul / div, &misc->dsi_sol_delay);
+	if (priv->slave) {
+		/*
+		 * TODO: Support modes other than symmetrical left-right
+		 * split.
+		 */
+		tegra_dsi_ganged_enable(dev, 0, timing->hactive.typ / 2);
+		tegra_dsi_ganged_enable(priv->slave, timing->hactive.typ / 2,
+					timing->hactive.typ / 2);
+	}
 }
 
 static int tegra_dsi_encoder_enable(struct udevice *dev)
@@ -774,6 +830,9 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	value |= DSI_POWER_CONTROL_ENABLE;
 	writel(value, &misc->dsi_pwr_ctrl);
 
+	if (priv->slave)
+		tegra_dsi_encoder_enable(priv->slave);
+
 	return 0;
 }
 
@@ -803,6 +862,14 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 	unsigned int mul, div;
 	unsigned long bclk, plld;
 
+	if (!priv->slave) {
+		/* Change DSIB clock parent to match DSIA */
+		struct clk_rst_ctlr *clkrst =
+			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+
+		clrbits_le32(&clkrst->plld2.pll_base, BIT(25)); /* DSIB_CLK_SRC */
+	}
+
 	tegra_dsi_get_muldiv(device->format, &mul, &div);
 
 	bclk = (priv->timing.pixelclock.typ * mul) /
@@ -854,6 +921,24 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 	reset_set_enable(priv->dsi_clk, 0);
 }
 
+static int tegra_dsi_ganged_probe(struct udevice *dev)
+{
+	struct tegra_dsi_priv *mpriv = dev_get_priv(dev);
+	struct udevice *gangster;
+
+	uclass_get_device_by_phandle(UCLASS_PANEL, dev,
+				     "nvidia,ganged-mode", &gangster);
+	if (gangster) {
+		/* Ganged mode is set */
+		struct tegra_dsi_priv *spriv = dev_get_priv(gangster);
+
+		mpriv->slave = gangster;
+		spriv->master = dev;
+	}
+
+	return 0;
+}
+
 static int tegra_dsi_bridge_probe(struct udevice *dev)
 {
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
@@ -873,6 +958,8 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	priv->video_fifo_depth = 1920;
 	priv->host_fifo_depth = 64;
 
+	tegra_dsi_ganged_probe(dev);
+
 	ret = reset_get_by_name(dev, "dsi", &reset_ctl);
 	if (ret) {
 		log_debug("%s: reset_get_by_name() failed: %d\n",
diff --git a/drivers/video/tegra20/tegra-dsi.h b/drivers/video/tegra20/tegra-dsi.h
index 69dac4bd1b..683c5e31a3 100644
--- a/drivers/video/tegra20/tegra-dsi.h
+++ b/drivers/video/tegra20/tegra-dsi.h
@@ -98,9 +98,9 @@ struct dsi_timeout_reg {
 	uint dsi_to_tally;		/* _DSI_TO_TALLY_0 */
 };
 
-/* DSI PAD control register 0x04b ~ 0x04e */
+/* DSI PAD control register 0x04b ~ 0x052 */
 struct dsi_pad_ctrl_reg {
-	/* Address 0x04b ~ 0x04e */
+	/* Address 0x04b ~ 0x052 */
 	uint pad_ctrl;			/* _PAD_CONTROL_0 */
 	uint pad_ctrl_cd;		/* _PAD_CONTROL_CD_0 */
 	uint pad_cd_status;		/* _PAD_CD_STATUS_0 */
@@ -111,6 +111,14 @@ struct dsi_pad_ctrl_reg {
 	uint pad_ctrl_4;		/* _PAD_CONTROL_4 */
 };
 
+/* DSI ganged mode register 0x053 ~ 0x04e */
+struct dsi_ganged_mode_reg {
+	/* Address 0x053 ~ 0x055 */
+	uint ganged_mode_ctrl;		/* _DSI_GANGED_MODE_CONTROL_0 */
+	uint ganged_mode_start;		/* _DSI_GANGED_MODE_START_0 */
+	uint ganged_mode_size;		/* _DSI_GANGED_MODE_SIZE_0 */
+};
+
 /* Display Serial Interface (DSI_) regs */
 struct dsi_ctlr {
 	struct dsi_syncpt_reg syncpt;	/* SYNCPT register 0x000 ~ 0x002 */
@@ -133,6 +141,7 @@ struct dsi_ctlr {
 	uint reserved5[4];		/* reserved_5[4] */
 
 	struct dsi_pad_ctrl_reg pad;	/* PAD registers 0x04b ~ 0x04e */
+	struct dsi_ganged_mode_reg ganged; /* GANGED registers 0x053 ~ 0x055 */
 };
 
 #define DSI_POWER_CONTROL_ENABLE	BIT(0)
@@ -202,6 +211,8 @@ struct dsi_ctlr {
 #define DSI_PAD_PREEMP_PD(x)		(((x) & 0x3) << 4)
 #define DSI_PAD_PREEMP_PU(x)		(((x) & 0x3) << 0)
 
+#define DSI_GANGED_MODE_CONTROL_ENABLE	BIT(0)
+
 /*
  * pixel format as used in the DSI_CONTROL_FORMAT field
  */
-- 
2.43.0

