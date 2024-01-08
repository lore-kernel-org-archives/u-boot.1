Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7973BC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D115C87A9A;
	Mon,  8 Jan 2024 11:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WSyothWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAF787A34; Mon,  8 Jan 2024 11:51:01 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B2A87A76
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a28a997f3dfso120496666b.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711058; x=1705315858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dCfRVShF0VtCBOQ5RHl9WeNWBTKsTuRyGps7xUIsVc=;
 b=WSyothWlVTNdWYdij+DR/gwIDd9CPVYDSCJK3x9ySAa9flEKAikj3nk6Jw30zgbd7h
 p3hvqJhMyvYSP/m7R9QVXo3zcKv2ubgEh+uleFVPo01+mXx2ik+lyzTghsrWrcjAeIJg
 q0Pry805xw1+3kQbqRy6R28gHWn9s/lZbW6bGXm7bYkrz0sD8ixzOFQYZcTcMRkC/zhJ
 lHlav4eJB0lT9W6WulXEv8elSPQkm5LMfaKzwf1GeuF9L/S4Fh3l9cA0GWTuQafW528I
 XGw55Kh9giUxnQcaX3bQ+RqhEPGXGNJ1zC4+3+YUuCgMfDS1qaAA3Lh9qxNyPbgIXTRU
 fsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711058; x=1705315858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dCfRVShF0VtCBOQ5RHl9WeNWBTKsTuRyGps7xUIsVc=;
 b=U4wWOUwZISAO9PXovLFE59cYbSm62xrSF+1ri5EdMVJW3Hri9TkV26iGnAUH5i4nvq
 ynwQSVqzAZ2PYw4pqZgfJCJaJowyJnyj51G8Rr6oalTjfSJ0/BJQWU0WAd0ojlG+Rmeh
 spKVQCQG6PVRcKbhhgg0GIDr8iTiyXxsjYZ7QXbs0bZzev7wxPidr2d6+u7QZsbE8VFY
 r+C72/bDj/JPTgcmVyhlryiYpHL4s+A6SM9Zv76p1vFvQZy/cdSxYI6CYsHXYfAVkKb+
 RDU1Q45wQnQaGYWV0fRPV3f25lmvBblXLPvkkaB4hCv09YaTIvOENCLpLsAqa6L1OVkb
 P02g==
X-Gm-Message-State: AOJu0Yxm9TMBFAdINEgnZCYQwvqn+0+KItsmHRpoNgoNvZaUuVX9xaSU
 0dWyFRmXnPWMaUr/RO6z9u0=
X-Google-Smtp-Source: AGHT+IFP+uaa8bjpcU8J5H/eeUwBiRE/V2wn89ST1ol9YUGePAmlXRqVjkvJR0DZiyUbPz4YHxufLw==
X-Received: by 2002:a17:907:a0cf:b0:a28:c16a:f18a with SMTP id
 hw15-20020a170907a0cf00b00a28c16af18amr1486339ejc.5.1704711058493; 
 Mon, 08 Jan 2024 02:50:58 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 26-20020a170906309a00b00a26ae4fb50asm3821141ejv.89.2024.01.08.02.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:50:58 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 6/9] video: tegra20: dc: add powergate
Date: Mon,  8 Jan 2024 12:49:59 +0200
Message-Id: <20240108105002.243149-7-clamor95@gmail.com>
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

Add powergate use on T114 to complete resetting of DC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index f6e20eeee2..41b22a2c6e 100644
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

