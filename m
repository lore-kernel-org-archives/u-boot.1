Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39926C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365DC87D29;
	Tue, 23 Jan 2024 18:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X60h0I9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D37587DBA; Tue, 23 Jan 2024 18:17:15 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A79987D7A
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so428376166b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030229; x=1706635029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=X60h0I9DR14nuVj5wrwC2c3aJTEBdCct4sHtHP+w454kFNIJKbXzb3DQNXa8ZGZ6pG
 WYlZwKTCZOIWe9Ik8XY0PV9OP1BX4lNX/yRsHSRVSeSx9RPx7qXxL3vhR0ExLUeZRm6U
 3fpNDefbEnimM3pR2H1YmxBCRtl+D2Kg8hgu5zF+BVVYaVrIUTbPWKmGFo168vRR8Kmh
 fMqwga6mrDOUZLCQG9890i6q/2R7zFBh4mnJaZJyeEPuF4yC/+qlcUyU+59fR7ZumvuO
 hdb3PO7UN/eL7G7q3HqWbALk9Zm+4m8D95JcDVYCOzWcX1b2xIDMhHnk8tovOT1zKL2S
 TJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030229; x=1706635029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=LBet9qQj7OTAvCb4GDiPmUEbFzTfB3b5JbmY2KWKiARjy8Bzc5U5DO+nfEJZKpIuqF
 TaF2rExX0gQ8fn9rFLALeg81jJ8jMCxC1CaWMUK4jCRasSjKsKsVzm7bQQrTExofiTlO
 gbEMBK8a3rO4qP6xljRDiakeqLpmgyy0QB4E6IIkCEUeZU/T1U5UeYgbiWtAreYWcoph
 bs9YNXmJ7bwpOmaS4BPlQspI/eEySk10HL5AXI/IRsyRpmSS+Ko2VM2Xsjn65INLrYLT
 bthBZq4fw3TltzjyH8/Kmw8ZWXiT96ybaIHETMzc97Z8pti5xL4HsRTecOhhNRiBTunb
 S9Bg==
X-Gm-Message-State: AOJu0YzJfqPfQOhfNS7vq3uvXLM58vjcOEWL3u9ZPdyCProjWruOiXrr
 jt2vQLlx/v390vY5udP/y5ofVQk0kv12Jcahr/gzcTjuUZodWw8fUp53MdGXLP6TmQ==
X-Google-Smtp-Source: AGHT+IHSOKc/rWLMDdJjZwKpNR/F2hp4ah25rYxY7km+GPYsidso41u204aZKGaEscPJITu6o6w4MQ==
X-Received: by 2002:a17:906:4089:b0:a2e:d5c7:425c with SMTP id
 u9-20020a170906408900b00a2ed5c7425cmr125906ejj.30.1706030228952; 
 Tue, 23 Jan 2024 09:17:08 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 07/18] video: tegra20: dc: add powergate
Date: Tue, 23 Jan 2024 19:16:22 +0200
Message-Id: <20240123171633.246057-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

