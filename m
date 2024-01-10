Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06547C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDB487AB7;
	Wed, 10 Jan 2024 08:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MwR6lQWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DF787A61; Wed, 10 Jan 2024 08:44:11 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0051087A88
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a28ee72913aso840324966b.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872646; x=1705477446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=MwR6lQWxiLTDX6dXosUJKicfxaEj1r6cyJUXBtKOmzPxncorE2B1SivTQnXNvMslRe
 tmgrKRCX8Ne7RefXFreOLgnl8TjB6UlqnQk20ltACTmFiqyz07JKS60N7z1o0hoLVXQo
 Ejz81JJjzjKsckC5F/6yCHzz9KB34K1flpFiPObtecMOTEF0qt7Z34HpbOGCOUudqeSk
 A5GZEt+0HMe9CWVAxuC5Tp0GlR1Oio+kUOPE/ZSMUl2cdJF+04VrZcB5o1M3pIHAE+iQ
 46bd53iXzfHgj2QiM8xWNSbvFtAQVM1jdlwO7aXfIDfQu7lnqvn8eqg2LDwk86kt7j/a
 4EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872646; x=1705477446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqfG3XPeqyBUzojtyvZepgeUN6eD0XN2Xqy3xM++kt8=;
 b=cnr5Z/GREtuAg+W7ED80FhHFjp1Dqq4n6aZ7QL9+Yi0Tv1vTyqSsE8m3i4E1OSGjdU
 iuAna+RJ7/0Ve5vhdQQSuuAA8+TEgmKrOQ+Oy7v6kfmMkmRQngcDZudUJfSyBgA8W5aL
 sfjyJTPoE5IDr6f5iXJiK3krrdBMe7yrOMgtUmlVu2P8/QNGNb8v3Jqyoo64K5xH8Bt5
 WiFM9+np4zJPENEJaItCSQPYjJFo15b7WFXIrFxDlLN4uqXGe1wV9pS9XOJhCjP7HTrV
 TP+33af0NN871RumBmyUt4r9IY1O6qHY8CpOJnElNPR6rWXiAov5gKs1TS8WeSx/MV07
 Salg==
X-Gm-Message-State: AOJu0YwrIsPo+j2/t/HBS62HGY1rOP3DhdMNV/KgZNck/Kccq0bfLLhg
 dFfcDuTvhoZA0WAGZCOcsws=
X-Google-Smtp-Source: AGHT+IFN/57odh+0/U8GG/IknwO50g6rHvlzsRn2w38LabwTw6heYXI2VAHC75hSrgecCQ6cZrjyWQ==
X-Received: by 2002:a17:906:8441:b0:a28:ba5d:e786 with SMTP id
 e1-20020a170906844100b00a28ba5de786mr583440ejy.14.1704872646526; 
 Tue, 09 Jan 2024 23:44:06 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 07/10] video: tegra20: dc: add powergate
Date: Wed, 10 Jan 2024 09:43:39 +0200
Message-Id: <20240110074342.38331-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110074342.38331-1-clamor95@gmail.com>
References: <20240110074342.38331-1-clamor95@gmail.com>
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

