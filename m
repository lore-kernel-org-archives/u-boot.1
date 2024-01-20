Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A972C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6A887E67;
	Sat, 20 Jan 2024 17:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hyxo8oJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB8887EE7; Sat, 20 Jan 2024 17:56:24 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611C587E1D
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso158279166b.2
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769780; x=1706374580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=hyxo8oJzavXrxt3Zc5O/meFbv0WvezRUYcQH7FyFwhg45wGEmEZZ3mlZadIsod5udY
 qMQk3UWhAmXyreJ0Ly+tOJoZpxSCWvqQ0GGtzejVatVVO9bKCCelBziS79eDUXeB0uQ5
 M8vZoXuU2ZJwi7TVuEn4NwhFdD/vUyeVexYBUrccMdTbVn3wjtZ2hv+t5mQvBFIrF2RL
 o0dNE73p29wdzP93Nu0XyY5xA5OKjVmy70pHSbDV/E34IgX2OWDJzGFJ8xP0bJUZknSN
 TTPypWQhuIfzztwsbWJu3LcWN0admgZTPNeUqGoMkwIjPK/3Wu+823G4QerCSalTmweT
 hHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769780; x=1706374580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=PCNNGio1nAl7u3efENHgrJmNscQwz99MczZEwwK7pJhsiHji/Gmz+II5P3rUAdPbEW
 qz6EozlRisnP50Dkw5BNGWxv8vSiiPG0+9n6v0F+lrDlBHpPS7U+lSJggKkrVJUqNZ0h
 /0kALiC7nu1AospI+84cNWI2n1v/vVSaXP4BuKfjvaZrO5eg+XkO6Sv1xdcOrFy6Etki
 AtYJB9xC8fmuDMLITglyKxatsQ3XSfce3JHeBgrZw5Q3XzNJDY6IPnILIbbifnrQpAQG
 HVsSm1N3dCQwpsH0tSUh3XqkN5Vu9kc8OkkbRDXPDR69p+FvhgpkgusJwBCyrb/JU7Cl
 zyEQ==
X-Gm-Message-State: AOJu0YzUIsl+VIi/G7hXCbrXKyzV1Qs0fZU3N6CmFcRCFebQ5ufF4B53
 EzeRnyzzXP7I8BvA5sAMDhtyfp0R1xYKnBpOuYLwjat6gBjvMINK
X-Google-Smtp-Source: AGHT+IH3elE9y3DNjZm4BaCIegnJWa2kSbOKWsceqOPQAGnPA8Bg+GDmM7pTBUs9SUVoiA7XC4r2eg==
X-Received: by 2002:a17:907:3182:b0:a29:1648:6030 with SMTP id
 xe2-20020a170907318200b00a2916486030mr1143465ejb.86.1705769779730; 
 Sat, 20 Jan 2024 08:56:19 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:19 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 07/13] video: tegra20: dc: add powergate
Date: Sat, 20 Jan 2024 18:55:37 +0200
Message-Id: <20240120165543.10226-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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

Add powergate use on T114 to complete resetting of DC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 35abb6fe46..9a18e38cd8 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -22,6 +22,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/funcmux.h>
 #include <asm/arch/pinmux.h>
+#include <asm/arch/powergate.h>
 #include <asm/arch/pwm.h>
 
 #include "tegra-dc.h"
@@ -32,6 +33,7 @@ DECLARE_GLOBAL_DATA_PTR;
 struct tegra_dc_soc_info {
 	bool has_timer;
 	bool has_rgb;
+	bool has_pgate;
 };
 
 /* Information about the display controller */
@@ -360,6 +362,28 @@ static int tegra_lcd_probe(struct udevice *dev)
 
 	clock_disable(priv->dc_clk[0]);
 
+	if (priv->soc->has_pgate) {
+		uint powergate;
+
+		if (priv->pipe)
+			powergate = TEGRA_POWERGATE_DISB;
+		else
+			powergate = TEGRA_POWERGATE_DIS;
+
+		ret = tegra_powergate_power_off(powergate);
+		if (ret < 0) {
+			log_err("failed to power off DISP gate: %d", ret);
+			return ret;
+		}
+
+		ret = tegra_powergate_sequence_power_up(powergate,
+							priv->dc_clk[0]);
+		if (ret < 0) {
+			log_err("failed to power up DISP gate: %d", ret);
+			return ret;
+		}
+	}
+
 	/* Reset everything set before */
 	reset_assert(&reset_ctl);
 	mdelay(4);
@@ -510,16 +534,19 @@ static const struct video_ops tegra_lcd_ops = {
 static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.has_timer = true,
 	.has_rgb = true,
+	.has_pgate = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.has_timer = false,
 	.has_rgb = true,
+	.has_pgate = false,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.has_timer = false,
 	.has_rgb = false,
+	.has_pgate = true,
 };
 
 static const struct udevice_id tegra_lcd_ids[] = {
-- 
2.40.1

