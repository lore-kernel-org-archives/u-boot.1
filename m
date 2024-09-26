Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAC4CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C432E88D29;
	Thu, 26 Sep 2024 10:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Mk70PP8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E895788D29; Thu, 26 Sep 2024 10:02:33 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37F982BA7
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f7528f4658so6352521fa.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337738; x=1727942538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ta632l/OzkeBllyBS1wjgzq57epJ46bHhzgb4ezorw0=;
 b=Mk70PP8oApbkwrj6BgxXFhQM+zO8/R8jzBAfUxswvN91k8KKTMFjvGF1PnwQ3MPvQu
 qncPvKMQfO3xTo1BP/Cr8i4cf/gj3+JcjNcJMSP9vsFrmbctA96akg1GMCqXqkZrPExw
 81fMr0ldS86GZf0sPanrKIToD3ASgLDeWk+W8VKJeSzRMJle6bTD4s3SttCzaYcP4/aO
 A5lrZkEjzukLErEmE0p7NOQ6qO1ghIZTxAzrulK7WtCWH61m6idTIJBbvvvY7T/g8V8i
 DN6dZoGMHfhHjTwAYjUp3ZI2W7hz1nmOp9ap1TtXpag6bqYFXOj/xlfoHKObv+2UKAjr
 Id4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337738; x=1727942538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ta632l/OzkeBllyBS1wjgzq57epJ46bHhzgb4ezorw0=;
 b=Q+o3OvL5sRaCqHtdFBt2Yjp2OLXfvHXmTWS3NCrjVfkZuEZ1NOiAMzJ3NtMyrm1qBi
 Z6kc/e9SfCZncy9v3NqIP6/1jjYW88h0sMSDiG1CD80kK9+FWrtujcjMHnUy0PY1Itj8
 EqW1mLN5AIu2hmTSgj9r3OfhFVjLHbAGRo/Hl+L4weXXaRV8LQOin/DE4d7lP0RF/vZE
 KPSw3je+RuYQj17YNSMaPg4toQ6loBOyXUvSCa3ze+2k3XUpntNJvfGuCiWE/NaeU6LT
 DEzvmzcWtSpc1k5FHdlkNmDtZVA9VhsBJBoYKyyMKhtpUNO/oQnMExwgO/9BiOaNCpPC
 6Fow==
X-Gm-Message-State: AOJu0YyEAFbVFGMzdRVI8ChKuClyJ0yB6zefUxtt/bUEo1IcdUUmlNRy
 Ea6Kng5B2NjmF/vZGEamd7I9w1ASXEA6kPz0sPunwrvFVz8sRZTBZlyimZnw16dSnUg2cFcPbt+
 m
X-Google-Smtp-Source: AGHT+IGb87EvuFqXQeHZTFoaa0oBZyQDgA/wlRBK8fS5nthuyKWPl/T0bGemEu+MN7mp8YBV4AaUHA==
X-Received: by 2002:a2e:74f:0:b0:2f7:5e7f:b4e1 with SMTP id
 38308e7fff4ca-2f91ca4643bmr27058921fa.30.1727337737692; 
 Thu, 26 Sep 2024 01:02:17 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:17 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 05/36] serial: serial_pl01x: Implement .getinfo() for PL01
Date: Thu, 26 Sep 2024 09:58:53 +0200
Message-ID: <20240926080021.148031-6-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

From: Maximilian Brune <maximilian.brune@9elements.com>

When ACPI is enabled on arm it will use the getinfo function to fill
the SPCR ACPI table.

Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 boot/bootflow.c               |  8 ++++++--
 drivers/serial/serial_pl01x.c | 24 ++++++++++++++++++++++++
 include/serial.h              |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 59d77d2385..d8807eb109 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -936,11 +936,15 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 		return ret;
 
 	*buf = '\0';
-	if (!strcmp("earlycon", arg)) {
+	if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
 		snprintf(buf, sizeof(buf),
 			 "uart8250,mmio32,%#lx,%dn8", info.addr,
 			 info.baudrate);
-	} else if (!strcmp("console", arg)) {
+	} else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
+		snprintf(buf, sizeof(buf),
+			 "pl011,mmio32,%#lx,%dn8", info.addr,
+			 info.baudrate);
+	} else if (!strcmp("console", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
 		snprintf(buf, sizeof(buf),
 			 "ttyS0,%dn8", info.baudrate);
 	}
diff --git a/drivers/serial/serial_pl01x.c b/drivers/serial/serial_pl01x.c
index 80c35963b8..ab67922d18 100644
--- a/drivers/serial/serial_pl01x.c
+++ b/drivers/serial/serial_pl01x.c
@@ -19,6 +19,7 @@
 #include <watchdog.h>
 #include <asm/io.h>
 #include <serial.h>
+#include <spl.h>
 #include <dm/device_compat.h>
 #include <dm/platform_data/serial_pl01x.h>
 #include <linux/compiler.h>
@@ -272,6 +273,28 @@ __weak struct serial_device *default_serial_console(void)
 	return &pl01x_serial_drv;
 }
 #else
+
+static int pl01x_serial_getinfo(struct udevice *dev,
+				struct serial_device_info *info)
+{
+	struct pl01x_serial_plat *plat = dev_get_plat(dev);
+
+	/* save code size */
+	if (!spl_in_proper())
+		return -ENOSYS;
+
+	info->type = SERIAL_CHIP_PL01X;
+	info->addr_space = SERIAL_ADDRESS_SPACE_MEMORY;
+	info->addr = plat->base;
+	info->size = 0x1000;
+	info->reg_width = 4;
+	info->reg_shift = 2;
+	info->reg_offset = 0;
+	info->clock = plat->clock;
+
+	return 0;
+}
+
 int pl01x_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct pl01x_serial_plat *plat = dev_get_plat(dev);
@@ -341,6 +364,7 @@ static const struct dm_serial_ops pl01x_serial_ops = {
 	.pending = pl01x_serial_pending,
 	.getc = pl01x_serial_getc,
 	.setbrg = pl01x_serial_setbrg,
+	.getinfo = pl01x_serial_getinfo,
 };
 
 #if CONFIG_IS_ENABLED(OF_REAL)
diff --git a/include/serial.h b/include/serial.h
index d129dc3253..d7a9a8cfb8 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -124,6 +124,7 @@ enum serial_stop {
 enum serial_chip_type {
 	SERIAL_CHIP_UNKNOWN = -1,
 	SERIAL_CHIP_16550_COMPATIBLE,
+	SERIAL_CHIP_PL01X,
 };
 
 enum adr_space_type {
-- 
2.46.0

