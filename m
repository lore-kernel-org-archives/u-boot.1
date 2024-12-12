Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE3FE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD22E8023A;
	Thu, 12 Dec 2024 11:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g9FuHTHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2548A80219; Thu, 12 Dec 2024 11:21:39 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422228027D
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so312376066b.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998896; x=1734603696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz197Wh/28h+GZeXhDd1fKkHk6zZCJMwtAYdRCAV+Io=;
 b=g9FuHTHaq0/rZ2YxGlBCxW4Vmc9ROxVQndB4zxEXWsuCVPbgQiQNzEONXaXPIhriim
 alGh4WMHTS09vG326GskSq3tjfAJVLfq88zj/UB4uuDf2tpziUyjeW3pgItBYbgJYeio
 vxr2rYjdOA12/ikkp+2BdOx398twDKB+T/hhKwjC99RnicwpIfdx+kwgEEiFGokdzUOy
 fyWCtlbi3Uc/WhztwV2582usnmo5Jw4usp5uIyBoeDdEFDCBwRw0S4fvGwiZg8CU+EWz
 Gn9MtqyT+aCBvy3sxlkvytkzjddgVBNel2g+6t71O8+JcCdaI/y8Y5yAONSl/R+A2XMa
 5XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998896; x=1734603696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kz197Wh/28h+GZeXhDd1fKkHk6zZCJMwtAYdRCAV+Io=;
 b=N8DRoKBzAIrTJF/HKiKky59YrjH/vVDMpHsny4Ki+vYhPbJhKOgKhmGN10c0yIGMQV
 syEO605r7lyAUYjdBqjDbNnEUfxBP2zoyv/5SOSfaRMdBevxzJdDbnNeVx5ZuI8hw4jO
 ouzPRSeGCz7F91F3jurKQptyoLNU6FxRpcdusZ8MuYHnmJWKTW4dxmGBuTMfBYxtCPqr
 Y5LS39bjA5O+rALD0/lRnfz27QvcwA4c2nsCbzU2/NQeVPTBErmi7UIORWcRIf8yXJ6f
 wG1KKVC4cjLms5egVJ4eM/gFhZPpgvoPNhd+VHHHfA9s9HvYVCuNHCZAXCuNrhM7g4/5
 BNNw==
X-Gm-Message-State: AOJu0YzyE/jy2V9b2q2PGdeXT4yK4y3enlhIekwsw/se/2rAYCgt9yV4
 SswbDpcQxpIbDzn8y7cBBTTf+p8d76E3x6hn3WwsemghvNepGqtb
X-Gm-Gg: ASbGnct/vFubtCdecMg8hzk72UI2d91z7fqQajC8WBbrueGE6qAs2YIKEC383+uqvEB
 XjCqCe2kgU/vGCuDIKlV+lEyNTn+qDXoNW4oAScPM/+vWYDQVQX7cbOUGyJw0SoQPEAu9ydISUc
 0LglOoUtRQMP2UvAZ8E0R+qIVNApRimt/DZKiUtq166uxS/o+qO3gu1uZHQubjBGMaoSh264mYA
 8W4upb3nZ0q7A0rhV1JB0nEy3lpWxiUTuAOr+ssDgwzWbfR
X-Google-Smtp-Source: AGHT+IEpvQORyo0whYuuZ+QDzjdH6+ehpwr+//58tu1srTr8oWN+tpMsxeK0cNEKqGSk6zjkuW3y4w==
X-Received: by 2002:a17:906:32d3:b0:aa6:6d88:3933 with SMTP id
 a640c23a62f3a-aa6c410327emr227610166b.9.1733998895557; 
 Thu, 12 Dec 2024 02:21:35 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 08/12] video: tegra20: dsi: make SOL delay calculation mode
 independent
Date: Thu, 12 Dec 2024 12:21:15 +0200
Message-ID: <20241212102119.6466-9-clamor95@gmail.com>
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

Move SOL delay calculation outside of video mode conditions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 47 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 97895f37739..b65d2118de9 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -698,9 +698,6 @@ static void tegra_dsi_configure(struct udevice *dev,
 		writel(hact << 16 | hbp, &len->dsi_pkt_len_2_3);
 		writel(hfp, &len->dsi_pkt_len_4_5);
 		writel(0x0f0f << 16, &len->dsi_pkt_len_6_7);
-
-		/* set SOL delay (for non-burst mode only) */
-		writel(8 * mul / div, &misc->dsi_sol_delay);
 	} else {
 		if (priv->master || priv->slave) {
 			/*
@@ -720,31 +717,31 @@ static void tegra_dsi_configure(struct udevice *dev,
 		value = MIPI_DCS_WRITE_MEMORY_START << 8 |
 			MIPI_DCS_WRITE_MEMORY_CONTINUE;
 		writel(value, &len->dsi_dcs_cmds);
+	}
 
-		/* set SOL delay */
-		if (priv->master || priv->slave) {
-			unsigned long delay, bclk, bclk_ganged;
-			unsigned int lanes = device->lanes;
-			unsigned long htotal = timing->hactive.typ + timing->hfront_porch.typ +
-					       timing->hback_porch.typ + timing->hsync_len.typ;
-
-			/* SOL to valid, valid to FIFO and FIFO write delay */
-			delay = 4 + 4 + 2;
-			delay = DIV_ROUND_UP(delay * mul, div * lanes);
-			/* FIFO read delay */
-			delay = delay + 6;
-
-			bclk = DIV_ROUND_UP(htotal * mul, div * lanes);
-			bclk_ganged = DIV_ROUND_UP(bclk * lanes / 2, lanes);
-			value = bclk - bclk_ganged + delay + 20;
-		} else {
-			/* TODO: revisit for non-ganged mode */
-			value = 8 * mul / div;
-		}
-
-		writel(value, &misc->dsi_sol_delay);
+	/* set SOL delay */
+	if (priv->master || priv->slave) {
+		unsigned long delay, bclk, bclk_ganged;
+		unsigned int lanes = device->lanes;
+		unsigned long htotal = timing->hactive.typ + timing->hfront_porch.typ +
+				       timing->hback_porch.typ + timing->hsync_len.typ;
+
+		/* SOL to valid, valid to FIFO and FIFO write delay */
+		delay = 4 + 4 + 2;
+		delay = DIV_ROUND_UP(delay * mul, div * lanes);
+		/* FIFO read delay */
+		delay = delay + 6;
+
+		bclk = DIV_ROUND_UP(htotal * mul, div * lanes);
+		bclk_ganged = DIV_ROUND_UP(bclk * lanes / 2, lanes);
+		value = bclk - bclk_ganged + delay + 20;
+	} else {
+		/* set SOL delay (for non-burst mode only) */
+		value = 8 * mul / div;
 	}
 
+	writel(value, &misc->dsi_sol_delay);
+
 	if (priv->slave) {
 		/*
 		 * TODO: Support modes other than symmetrical left-right
-- 
2.43.0

