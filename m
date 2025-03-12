Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EC2C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E3B981B52;
	Wed, 12 Mar 2025 18:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eOB2A53W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3013B81A0E; Wed, 12 Mar 2025 18:59:33 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 302F1819C3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so60253a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802370; x=1742407170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjcOTj2CNEX6YnHGLq/YazgD2HIGhhhYE1dJZ4aYK7I=;
 b=eOB2A53WaKVILhePvru1IFQq94V1SQpHyv+e6cwxElzv1n9OmRsR3HkFhsSpiCsaYw
 3slx1ST9maJEELW5O6KXVQlKU5r3Fo9t3Eo+gIuieb/RiTBmDl1+XyE/4SHev2dVvJ0G
 Xbt/GticH6UrBenEtkiVzN08zJjzhYAXQGXN84glaELGojCuyk6thjbXyba5S2950HKh
 2hfOvUrgPt1e567dWsa9nRQo8fMNUcL0tqvx+uYEoYn3aFdehWp8SQnuLeNdVFPJQU8c
 ejVrbAQ5YIbeSF2FU6KF3fwHcSJthlzKChJi9QWlJGDFY5D2KaMN8nX7nt+m3nmYD6dq
 xnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802370; x=1742407170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjcOTj2CNEX6YnHGLq/YazgD2HIGhhhYE1dJZ4aYK7I=;
 b=toZJU2+Lx7MOcZ1DYQFD8jnniODcsHDT/JgfEfzh5AHGCM2QmI9z4FkgDrkx6qtt3z
 4aVoqIp8EFSfFiMjhL+Kdnya6r3L6DlFLojycUWTtolBBGG2RE9NGUs+cR13Zm5WwAvb
 lOEKCaHjvWQSnVBAwBhJD3ZlNCoXUBbPpx28Tr5frTuZ09C9ne4SEJjysMHMKstBnLk+
 1y+hd1DPZjegDHf9i/Tu2JhOaflnuq9ZPS4zTz2TVl4aIl5Uqm4fo3MC6edMXepBTRG9
 tDi+vDTNb3y/2PGBFejc++YhXmqto8NE4nMIqEldNCnOhP9kTn4HX3OMHJFi1YoEB/2L
 z4lg==
X-Gm-Message-State: AOJu0Yzb4H7IuNYD60NU2itWTcxKICNFZfvhUdBB8HZkWE1T95HXLEFl
 TMcMLwRNfJQIpy0mrdKulCB5xitC9BLt0DYyMjiCHxU64r3rG+jsOgEV+A==
X-Gm-Gg: ASbGnctHpv8XUSQJDT5VLRty2WNlbUKEKuYFYsoAOsH5Vl9gJQPPIUAgMeTDxF5Wp90
 VNn70oLSv7CgZWClFPzXfcWvTm6SRjxGR5+CAAt3NChNCbYkPDgdplrKvnA6Bc+CNTEzZi/63p8
 rKcDACLY1L5kkG4oaPRLtqNrFj0C5eYpAclyvN5EhoWJ5RyGXB7UNbyybsok3AVC4RuPhSIIB4R
 0++ym1IA59Q/f63stKq/SmsVxCayJHvgKxY2eqQ7ZfPWdQZryoeFjPlKVuoLHEVVL5MvgYHhZKI
 qN1SBmz9aXiKsajn6ETA4JlHPicv9bikR1hE
X-Google-Smtp-Source: AGHT+IFJDwD/KlkQRPbbRmXJsYPJ95NbKvDSubmjUW3YoQb3tWmvrIZ7+CJHEoch/NJna/eNQiK/Ew==
X-Received: by 2002:a17:907:874b:b0:abf:5fa3:cf96 with SMTP id
 a640c23a62f3a-ac2b9de398amr1154500166b.14.1741802369498; 
 Wed, 12 Mar 2025 10:59:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:29 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 09/10] video: tegra20: dsi: convert to video bridge UCLASS
Date: Wed, 12 Mar 2025 19:58:56 +0200
Message-ID: <20250312175857.120313-10-clamor95@gmail.com>
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

Switch from PANEL_UCLASS to VIDEO_BRIDGE_UCLASS since now
Tegra DC driver has bridge support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/Kconfig     | 2 +-
 drivers/video/tegra20/tegra-dsi.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra20/Kconfig
index ce990b4481f..598f9ea1f21 100644
--- a/drivers/video/tegra20/Kconfig
+++ b/drivers/video/tegra20/Kconfig
@@ -14,7 +14,7 @@ config VIDEO_TEGRA20
 
 config VIDEO_DSI_TEGRA30
 	bool "Enable Tegra 30 DSI support"
-	depends on PANEL && DM_GPIO
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
 	select VIDEO_TEGRA20
 	select VIDEO_MIPI_DSI
 	help
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 9f39ac7589b..3ce0d33e380 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -11,6 +11,7 @@
 #include <mipi_display.h>
 #include <mipi_dsi.h>
 #include <backlight.h>
+#include <video_bridge.h>
 #include <panel.h>
 #include <reset.h>
 #include <linux/delay.h>
@@ -991,7 +992,7 @@ static int tegra_dsi_ganged_probe(struct udevice *dev)
 	struct tegra_dsi_priv *mpriv = dev_get_priv(dev);
 	struct udevice *gangster;
 
-	uclass_get_device_by_phandle(UCLASS_PANEL, dev,
+	uclass_get_device_by_phandle(UCLASS_VIDEO_BRIDGE, dev,
 				     "nvidia,ganged-mode", &gangster);
 	if (gangster) {
 		/* Ganged mode is set */
@@ -1118,8 +1119,8 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	return 0;
 }
 
-static const struct panel_ops tegra_dsi_bridge_ops = {
-	.enable_backlight	= tegra_dsi_encoder_enable,
+static const struct video_bridge_ops tegra_dsi_bridge_ops = {
+	.attach			= tegra_dsi_encoder_enable,
 	.set_backlight		= tegra_dsi_bridge_set_panel,
 	.get_display_timing	= tegra_dsi_panel_timings,
 };
@@ -1133,7 +1134,7 @@ static const struct udevice_id tegra_dsi_bridge_ids[] = {
 
 U_BOOT_DRIVER(tegra_dsi) = {
 	.name		= "tegra_dsi",
-	.id		= UCLASS_PANEL,
+	.id		= UCLASS_VIDEO_BRIDGE,
 	.of_match	= tegra_dsi_bridge_ids,
 	.ops		= &tegra_dsi_bridge_ops,
 	.bind		= dm_scan_fdt_dev,
-- 
2.43.0

