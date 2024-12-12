Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB300E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE4F8021D;
	Thu, 12 Dec 2024 11:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Es2Cy/5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8FB80296; Thu, 12 Dec 2024 11:21:37 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313478020B
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso519194a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998895; x=1734603695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crtJMWg/o1fQKBAE+QC6PgobEdrgZ/G53E2opiAmfhw=;
 b=Es2Cy/5zTSsA2xAiF76WKI6k/VCIWT8uTTzMmDc0woFy0lE+JFTk+SDV2XgoqInycP
 w3LuXTdB5ZlUBOsBLYZ0aWV7MxFTTUcoAoRA/cU/MWumPK/epu+GqBnFH8bp2pHw5VWM
 AxJ9zyI3TDftFYm3NELkWUEZfsDyLrAG77+1whdBnrz2IKHHGQtNozYe1nWJym+GMOIh
 ne1cjZfPwb16eGaehaRCgBk5D/LLuvmPNaMcWxnvTf87YMH6+W1ns3W9lAipomgcuXEf
 Zcl3+l6uDhKv4rLf3gvIQ6OOmrlmolr/u3xuBjp5+3cFc0qw88i0pYj3zMe1YHgL974x
 tHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998895; x=1734603695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crtJMWg/o1fQKBAE+QC6PgobEdrgZ/G53E2opiAmfhw=;
 b=sc4xF7chpI9+ow64P0X3iypYuCqNJda1Lt/yenFq8yULgzlTxCVzKp9CpPE+eY5LkA
 ZG03AzsB457nWYhC/hrS/O0jOeOLKrlHBZy1Db1u4re1gwo32gZ0Osy7Mb45MWyfb1J5
 4mGaWGQhLz8qFmRWADGrQo+v+nITpwFVpduEikmWedMBm9bAE+ZNu7WMYxIsY5vQtvwB
 Im6WJrv5zGC7pzuCRM9RLpYIfkp7dW5hSIBowE2YfA8AjzDq/h9wgEZllUkJ/tqhqk6e
 PZdmeDVMaE/6ehpfRiyfpwLyHNmnyskxIOZt/vFAzx/8QX6V++G9rU+l7bO75wngPu+7
 6lWA==
X-Gm-Message-State: AOJu0YwaDedKWKlTSIMbtiOp6S0NMHmxHbIEA00dS+pUEJKxyWypVYQG
 J+WtmdD96eNUcuaz42ST0QWs/Kmf4Cnic1zwKRfojxN4LsZksHkB
X-Gm-Gg: ASbGncuL/Yj5wYsXl5ZymGhAYyq1dM0jDqQFwY6cfvNPyoZOLrpDqUXPEzcqnsFH6cv
 aQ1N0ytKIPlUEeaC3TO9TXZBfaOHS0JVE583v0LqTgTtMj4nv+IN9tiF3ji/ASe2wgm3vq+FGjD
 wye2Yo2bG0Bo6AxDv2nklx1IBzFpqFeNN3pUwF67gtdbNr/WQT+9kFzkwjiBBMSLGVX47gDB5y4
 vvdjd5Ef3iAUjZwm9bW+xSkWbS3G+Bd7L23I7pI1Mm+PzMM
X-Google-Smtp-Source: AGHT+IGhCd+YYc7ijkpUHjL0ByVyxroe/ubXjsBrgGcVDSzXbE7OW0/G0kOCs4Fox4Jeu1gXlEKMFg==
X-Received: by 2002:a17:906:3104:b0:aa6:acd0:aba2 with SMTP id
 a640c23a62f3a-aa6c1ad9e72mr273097066b.1.1733998894525; 
 Thu, 12 Dec 2024 02:21:34 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:34 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 07/12] video: tegra20: dsi: move ganged DSI configuration
 before master panel enable
Date: Thu, 12 Dec 2024 12:21:14 +0200
Message-ID: <20241212102119.6466-8-clamor95@gmail.com>
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

Master panel driver holds commands for both itself and link, so master
panel should be requested after both master DSI and slave DSI are
configured and ready.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 97a30402902..97895f37739 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -819,6 +819,9 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	tegra_dsi_set_phy_timing(&priv->dsi->ptiming,
 				 period * 8, &priv->dphy_timing);
 
+	if (priv->slave)
+		tegra_dsi_encoder_enable(priv->slave);
+
 	/* Perform panel HW setup */
 	ret = panel_enable_backlight(priv->panel);
 	if (ret)
@@ -833,9 +836,6 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	value |= DSI_POWER_CONTROL_ENABLE;
 	writel(value, &misc->dsi_pwr_ctrl);
 
-	if (priv->slave)
-		tegra_dsi_encoder_enable(priv->slave);
-
 	return 0;
 }
 
-- 
2.43.0

