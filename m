Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B85DE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3194780212;
	Thu, 12 Dec 2024 11:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2Ya3SYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49F7801ED; Thu, 12 Dec 2024 11:21:31 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F90801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so4517885e9.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998889; x=1734603689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcqNW5qzOgc9MjscPcPq/f35gRoGcz+XOaRbAu2YvZo=;
 b=U2Ya3SYC2w2wJ/JMCmcuvLUMZr4VjRdEaIqOaPRQJ6zNy6bUINyY+C3l/CvIWQUKXm
 hJvXhq4B+xCq2RRiVEG1jPvp8Ls2b9ATvt0s3OAqP+Z8OvLSqkr2YzglNv0Vf2zfPPEN
 +LK0DYIfv4l8ThKyckKy+2DENzQcrZqMw5V+B7Zl4nZimVFlpLen/Cookgz+Yy9oQkGG
 VOxrXfZfb2wesj4JHIWyB3B6JNx9ftqBPq6rH/ccSWvOdg4BJOlkjLw5pExxZZ/uf/n7
 EDkvdhj/9o8ans1RLLF5V0gMUw2V6HtcaYEaZSHi7BIB20zjWlWj4o3Q9kQqe0dcFkCL
 pkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998889; x=1734603689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcqNW5qzOgc9MjscPcPq/f35gRoGcz+XOaRbAu2YvZo=;
 b=iCjs5WiILbSfbQwDyChQzxTb7HYRmSknUxUufVDNX8oMxT5ezrCkQdamF114b6CZLp
 V7iGIpEh9/6duZzLrcNuJAdq4IJPQN+ZX4WPD4IZObCwlsCFP+s1+nFmPL1pNQ2a+SI/
 MkhaSiByCXQ6OBdVA9YH2IhT51MV4fFPjUIA8jcSloQjrPWgzWfHAS9SUJfcldLBBYuM
 1ABZSpNG0scKMMKDDTGc/nN0ZwJW1xHFKBMJOuWeA7C31Sdybvqsu6N7nB5t0mRf4o1P
 Qod2mGNZdXn1SSSFUDAlj9+rbGctp0Vu0ugQcfVEg5wEI6zi0vvymBC0cIdaP8HOxHEY
 5P9g==
X-Gm-Message-State: AOJu0YyE0d4V0g7Vs6LQRBFoNhaaVhKWJkySnaqqMUH2Zb2iILV+6eTm
 lmVyuJW18WYBMp24M3dLt+MWxh6kHSGXZe6Eo7EIHuejywt0G+ie
X-Gm-Gg: ASbGncssMwMzpirtoSl9Dq3QtG94ViJ1vA5ZjCEG4CpvkzvdmX9PjsMvxS5IZnG+o74
 0APpOwqOiTeba9Q0QAXCjrPCOPQZnuPSTS33knjOA+Omed35NrsEid32/f8TVB2pklNHMPo3+oS
 GJZQIgkYhsqC0qNPRUVHHeXzgd485ruZ/ixWKq2lt1ztfGR3DYLp2Ob71rTla3tRLA1UMqZF2kI
 w11ac6ZkX4eTZgg4qKe1c1vCFasd8PcH/kcFoGm4Vmiri6M
X-Google-Smtp-Source: AGHT+IGAWYmkw2XOoYbbY/nSqQc23uIc3C3VkkLw8dxs9ahhS/pukUZfSWAI/bojtVFgdvm/W/gdaQ==
X-Received: by 2002:a05:6000:1ac5:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-3864cec7609mr4745091f8f.38.1733998888722; 
 Thu, 12 Dec 2024 02:21:28 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 01/12] video: tegra20: dc: switch to newer clk API
Date: Thu, 12 Dec 2024 12:21:08 +0200
Message-ID: <20241212102119.6466-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

Switch to struct clk instead of working with plain clock id.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index d24aa375b39..bd0d8ca7b8f 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -5,6 +5,7 @@
 
 #include <backlight.h>
 #include <cpu_func.h>
+#include <clk.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
@@ -44,7 +45,8 @@ struct tegra_lcd_priv {
 	const struct tegra_dc_soc_info *soc;
 	fdt_addr_t frame_buffer;	/* Address of frame buffer */
 	unsigned pixel_clock;		/* Pixel clock in Hz */
-	int dc_clk[2];			/* Contains clk and its parent */
+	struct clk *clk;
+	struct clk *clk_parent;
 	ulong scdiv;			/* Clock divider used by disp_clk_ctrl */
 	bool rotation;			/* 180 degree panel turn */
 	int pipe;			/* DC controller: 0 for A, 1 for B */
@@ -301,7 +303,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 			       void *default_lcd_base)
 {
 	struct disp_ctl_win window;
-	unsigned long rate = clock_get_rate(priv->dc_clk[1]);
+	unsigned long rate = clk_get_rate(priv->clk_parent);
 
 	priv->frame_buffer = (u32)default_lcd_base;
 
@@ -309,12 +311,12 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	 * We halve the rate if DISP1 parent is PLLD, since actual parent
 	 * is plld_out0 which is PLLD divided by 2.
 	 */
-	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY)
+	if (priv->clk_parent->id == CLOCK_ID_DISPLAY)
 		rate /= 2;
 
 #ifndef CONFIG_TEGRA20
 	/* PLLD2 obeys same rules as PLLD but it is present only on T30+ */
-	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY2)
+	if (priv->clk_parent->id == CLOCK_ID_DISPLAY2)
 		rate /= 2;
 #endif
 
@@ -334,7 +336,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	 */
 	clock_start_periph_pll(PERIPH_ID_HOST1X, CLOCK_ID_CGENERAL,
 			       150 * 1000000);
-	clock_start_periph_pll(priv->dc_clk[0], priv->dc_clk[1],
+	clock_start_periph_pll(priv->clk->id, priv->clk_parent->id,
 			       rate);
 
 	basic_init(&priv->dc->cmd);
@@ -383,7 +385,7 @@ static int tegra_lcd_probe(struct udevice *dev)
 		}
 
 		ret = tegra_powergate_sequence_power_up(powergate,
-							priv->dc_clk[0]);
+							priv->clk->id);
 		if (ret < 0) {
 			log_err("failed to power up DISP gate: %d", ret);
 			return ret;
@@ -451,11 +453,18 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 
 	priv->soc = (struct tegra_dc_soc_info *)dev_get_driver_data(dev);
 
-	ret = clock_decode_pair(dev, priv->dc_clk);
-	if (ret < 0) {
-		debug("%s: Cannot decode clocks for '%s' (ret = %d)\n",
-		      __func__, dev->name, ret);
-		return -EINVAL;
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_debug("%s: Could not get DC clock: %ld\n",
+			  __func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->clk_parent = devm_clk_get(dev, "parent");
+	if (IS_ERR(priv->clk_parent)) {
+		log_debug("%s: Could not get DC clock parent: %ld\n",
+			  __func__, PTR_ERR(priv->clk_parent));
+		return PTR_ERR(priv->clk_parent);
 	}
 
 	priv->rotation = dev_read_bool(dev, "nvidia,180-rotation");
-- 
2.43.0

