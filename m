Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E69C4707C
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 16:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E787787463;
	Mon,  8 Jan 2024 17:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IS1mpZfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0232687A82; Mon,  8 Jan 2024 17:45:27 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F04787A99
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 17:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-557a3ce8b72so1471900a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704732322; x=1705337122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZdHUWcjM6WJ5AjDVbMr9xStXJfoCDQIXJ1hiXTPO/E=;
 b=IS1mpZfeW8lxZbWXmYopo+mUWfXoaTLN8SV6tqnqToYFuINqXfTy+/0KSpq4BICaTi
 vnj1xvGs6ljAtWLfqC1LdARHRVRrAOksVcibsCQY3j96+i0lH9Hybd0+1QHGRqOWvaol
 ExCYe9igkwNDr2QbG+uGQs0K4OvN7bRJxYEIGC+eJQzzS91485LhnUc2Ti74TEfuRlLs
 hx5iFGe7o9FEsTfKZ/OUqb4shNXewl49ItQ3GIYczCPGBxZDC5AOPDBqor+hn4K42dP8
 WQutzD2hcGvQ1yn075XtlMCLkOBBq9NdDb4gRQ5X20NfFXzGJhyJljIzX8xPixuREeiF
 EYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704732322; x=1705337122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZdHUWcjM6WJ5AjDVbMr9xStXJfoCDQIXJ1hiXTPO/E=;
 b=B3Vm8sCoO4kY2zNRstkzyVaTVuX8BzAUpUOaDcnwIjc63ZHGnhAM3XR66ZzsVVh3ON
 9BAWNCPVkAYqML4+oxpxMPq/QmjNv6OFJoQVMkXXiRmWF+1G/JOMoS1TKWItdAfvBrRJ
 Es1AmfNFMrNWhKK5GtVsD5ygsxreKYvsO9Djr6eIuWXQTZUsQTP1v5yQVLopOiYAqRFd
 Dv55ygPeDEJDsHWLH6HA7tZBrR2n2SiYy27xEfXZGWOrkUSOwMSc4aG67HzBq9KMOQda
 mP8SA+3wXJbuc/gLH4QwArEoWcZX6Hvj0zSwMoSQPIV4WPZv+C5THDR5m+17UBXNDEIR
 IsBA==
X-Gm-Message-State: AOJu0Yx3u8zRhjpT7dvQwgQwtiOVoyMAfFEegd0AQQ7GHZy+kvhtDRbT
 w9bXQf+Yn/2SQl8Ea8KbFBQ=
X-Google-Smtp-Source: AGHT+IFUkPxuAXlHqLNM5E48d2d+dlqXFtMfdy8KhYWvZZU9BgR6PfKJuV5c+vuYHFAXE9zTMeH51w==
X-Received: by 2002:a50:cdca:0:b0:554:20a:5d56 with SMTP id
 h10-20020a50cdca000000b00554020a5d56mr2580038edj.2.1704732322482; 
 Mon, 08 Jan 2024 08:45:22 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 x8-20020aa7cd88000000b0055751515a84sm26684edv.51.2024.01.08.08.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 08:45:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] video: simple_panel: add EDID support
Date: Mon,  8 Jan 2024 18:45:01 +0200
Message-Id: <20240108164501.4660-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108164501.4660-1-clamor95@gmail.com>
References: <20240108164501.4660-1-clamor95@gmail.com>
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

Support timing parsing from EDID if panel device tree node
provides DDC i2c bus instead of timings node.

Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF201
Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig        |  2 ++
 drivers/video/simple_panel.c | 51 ++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6f319ba0d5..e2016d73d1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -240,6 +240,7 @@ config PANEL
 config SIMPLE_PANEL
 	bool "Enable simple panel support"
 	depends on PANEL && BACKLIGHT && DM_GPIO
+	select I2C_EDID
 	default y
 	help
 	  This turns on a simple panel driver that enables a compatible
@@ -1105,6 +1106,7 @@ config SPL_PANEL
 config SPL_SIMPLE_PANEL
 	bool "Enable simple panel support at SPL"
 	depends on SPL_PANEL && SPL_BACKLIGHT && SPL_DM_GPIO
+	select I2C_EDID
 	default y
 	help
 	  This turns on a simple panel driver that enables a compatible
diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 064c113d2d..f0234349da 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -7,12 +7,16 @@
 #include <common.h>
 #include <backlight.h>
 #include <dm.h>
+#include <edid.h>
+#include <i2c.h>
 #include <log.h>
 #include <mipi_dsi.h>
 #include <panel.h>
 #include <asm/gpio.h>
 #include <power/regulator.h>
 
+#define EDID_I2C_ADDR	0x50
+
 struct simple_panel_priv {
 	struct udevice *reg;
 	struct udevice *backlight;
@@ -53,9 +57,52 @@ static int simple_panel_get_display_timing(struct udevice *dev,
 					   struct display_timing *timings)
 {
 	const void *blob = gd->fdt_blob;
+	struct display_timing edid_timing;
+	struct udevice *panel_ddc, *panel_edid;
+	u8 edid_buf[EDID_SIZE] = { 0 };
+	int ret, bpc;
+
+	/* Check for timing subnode if panel node first */
+	ret = fdtdec_decode_display_timing(blob, dev_of_offset(dev),
+					   0, timings);
+	if (!ret)
+		return ret;
+
+	/* Check for DDC i2c if no timings are provided */
+	ret = uclass_get_device_by_phandle(UCLASS_I2C, dev,
+					   "ddc-i2c-bus",
+					   &panel_ddc);
+	if (ret) {
+		log_debug("%s: cannot get DDC i2c bus: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dm_i2c_probe(panel_ddc, EDID_I2C_ADDR, 0, &panel_edid);
+	if (ret) {
+		log_debug("%s: cannot probe EDID: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
 
-	return fdtdec_decode_display_timing(blob, dev_of_offset(dev),
-					    0, timings);
+	ret = dm_i2c_read(panel_edid, 0, edid_buf, sizeof(edid_buf));
+	if (ret) {
+		log_debug("%s: cannot dump EDID buffer: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = edid_get_timing(edid_buf, sizeof(edid_buf),
+			      &edid_timing, &bpc);
+	if (ret) {
+		log_debug("%s: cannot decode EDID info: error %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	memcpy(timings, &edid_timing, sizeof(*timings));
+
+	return 0;
 }
 
 static int simple_panel_of_to_plat(struct udevice *dev)
-- 
2.40.1

