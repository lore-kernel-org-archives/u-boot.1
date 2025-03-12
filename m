Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE46DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E2A81D99;
	Wed, 12 Mar 2025 19:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCo/iwOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4529D81D6A; Wed, 12 Mar 2025 19:08:17 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D5A81BF4
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e6167d0536so135568a12.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802895; x=1742407695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jtxUT6BRKRrZIxDo4pinzyAJW8zjgOG/dSbZ/L9e84=;
 b=SCo/iwOq0nu7djCm2Di6b34feS+6XEAPPkEsH0DhE6wmHdGnDm9LapyCbUePUmiLiP
 YplM+PzcGWG2RX7bM3YhGqYWfpMwZpVailphTLXlcJb0I5EY/Xt739j3DUksvyUMF0pf
 vw9IvKdeerJGBiCxG5fVrspLbYFfXrMEcOoHJs/ZWVyKHaTw24bYUjH/Jdk8aZNW7Us8
 g2ogmcLR9/BZl2nG8kzGOdaL3qM0JLgQZBmfq3sQ1knTXQYom53qgW3GgKABCFSfkhHa
 aIU/S4bBxP8jGPkuJTxJda1iV+CDOTmDVQedb0DDn+7GsXWpXzFAZhBeMjOaJ9vzgYgA
 BVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802895; x=1742407695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jtxUT6BRKRrZIxDo4pinzyAJW8zjgOG/dSbZ/L9e84=;
 b=qUtmxP2tzAbpATG08bEE5qorJsyvIoS93Tr1sIB0iLpG/Ez2msIGU1gzcsWEeJV4Du
 WLnVF1QWQaVHsZFyG8gS78ymSlvs/HLqCTgTQybBDWczMbF0giTdlaWnrMr/rzESVU9n
 Y1CjFFQVdF3FMwT+NxEb0VVbLkQzWgn1MhZkeTSNPCdLpgBiCfPnFo3mbVOiSiywFRd6
 QRqvM8v/KmrPEYrB/VpzqzNkyz6oh8VY1yYs6e9c/6q4z3e10ohdwZWEK3EA/R3faNmN
 bE3yXwFkP631LYicgMqsU30RKgdrFMqfMqYTqzbY+mcAaMpjRxW19ooAFg2EPjePLmpC
 MbuA==
X-Gm-Message-State: AOJu0YyRN45mG/ap52coBKQWCp07UzzOtRRUsRRSloDndAAxD+SJb9uO
 oMJVnMOPaBnNz6q5mZVYnHNWZy1WY9nm2Y1/GoBm5TyRKvyd/Rqv
X-Gm-Gg: ASbGncvpiR/WqEMQM8PqnfDt03NlhKyz2vzHsPYtqpWICMtTHwpRzQX7fXAXY1UmwOt
 GhTR1JXx/TrnY5mrL7kU38gXNveBy6PU8745jF5+Qq74KxOe7+k3l7Icr7Al+8EePbjuQ7hOyuK
 nf86p6ZKSVMxTz+DQ715t0BWT6uj6AepX05i30nEdGzDRAyDtMGdzaYrgAFITA6JUcGHhcH6lUm
 yjYvfbFbFT00Ddyf3nqDljxcY7yFbXwGJX4HG99UE5Ead4iHTPrM7SNFL2nr18fS+Pn/Hks9RDq
 Cnu0/lMVj+Vglwps9cn3ZfqObSxLC++7sDsU
X-Google-Smtp-Source: AGHT+IGQMYhk7Uaw4G7c6j/5XxfapqAUXOO7AQUSM05VcImCNNF/btIJstcTDILK/ve4y9BTcYGGTw==
X-Received: by 2002:a05:6402:2713:b0:5e7:289d:3f61 with SMTP id
 4fb4d7f45d1cf-5e75f9878cemr13374457a12.30.1741802894591; 
 Wed, 12 Mar 2025 11:08:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 08/13] video: bridge: ssd2825: move post configuration from
 transfer function
Date: Wed, 12 Mar 2025 20:07:49 +0200
Message-ID: <20250312180754.120946-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Reconfigure post panel enable bridge configuration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/ssd2825.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/bridge/ssd2825.c b/drivers/video/bridge/ssd2825.c
index e3be3d22bb4..df69f993ea1 100644
--- a/drivers/video/bridge/ssd2825.c
+++ b/drivers/video/bridge/ssd2825.c
@@ -232,7 +232,6 @@ static ssize_t ssd2825_bridge_transfer(struct mipi_dsi_host *host,
 				       const struct mipi_dsi_msg *msg)
 {
 	struct udevice *dev = (struct udevice *)host->dev;
-	u8 buf = *(u8 *)msg->tx_buf;
 	u16 config;
 	int ret;
 
@@ -261,15 +260,6 @@ static ssize_t ssd2825_bridge_transfer(struct mipi_dsi_host *host,
 	ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
 	ssd2825_write_dsi(dev, msg->tx_buf, msg->tx_len);
 
-	if (buf == MIPI_DCS_SET_DISPLAY_ON) {
-		ssd2825_write_register(dev, SSD2825_CONFIGURATION_REG,
-				SSD2825_CONF_REG_HS | SSD2825_CONF_REG_VEN |
-				SSD2825_CONF_REG_DCS | SSD2825_CONF_REG_ECD |
-				SSD2825_CONF_REG_EOT);
-		ssd2825_write_register(dev, SSD2825_PLL_CTRL_REG, 0x0001);
-		ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
-	}
-
 	return 0;
 }
 
@@ -349,6 +339,7 @@ static int ssd2825_bridge_attach(struct udevice *dev)
 	struct ssd2825_bridge_priv *priv = dev_get_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct display_timing *dt = &priv->timing;
+	int ret;
 
 	/* Perform SW reset */
 	ssd2825_write_register(dev, SSD2825_OPERATION_CTRL_REG, 0x0100);
@@ -385,7 +376,18 @@ static int ssd2825_bridge_attach(struct udevice *dev)
 	ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
 
 	/* Perform panel setup */
-	return panel_enable_backlight(priv->panel);
+	ret = panel_enable_backlight(priv->panel);
+	if (ret)
+		return ret;
+
+	ssd2825_write_register(dev, SSD2825_CONFIGURATION_REG,
+			       SSD2825_CONF_REG_HS | SSD2825_CONF_REG_VEN |
+			       SSD2825_CONF_REG_DCS | SSD2825_CONF_REG_ECD |
+			       SSD2825_CONF_REG_EOT);
+	ssd2825_write_register(dev, SSD2825_PLL_CTRL_REG, 0x0001);
+	ssd2825_write_register(dev, SSD2825_VC_CTRL_REG, 0x0000);
+
+	return 0;
 }
 
 static int ssd2825_bridge_set_panel(struct udevice *dev, int percent)
-- 
2.43.0

