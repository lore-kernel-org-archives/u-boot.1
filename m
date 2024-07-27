Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ABFC3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB403886AF;
	Sat, 27 Jul 2024 09:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YD5aN2qv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290C088646; Sat, 27 Jul 2024 09:20:16 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A64884DB
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so256460766b.3
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064813; x=1722669613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NJTOyzjSlfNeZ5isli+1YIundr9ep5kny/FT3tTejQ=;
 b=YD5aN2qvvk8/vNWwc/ow3JA41965Iym8usXct5ZQuhIC1emLj/OolgLjHPtGXLnwy8
 su+VGxfDtCVBwmsAPUABhm5EBmfVKaMJLHqnoruyUhOIDMpmQTEk3rGW7uLH0+RR/Al7
 4ZquzQjFaXZl+cFOYMEZo/uNFtDfIKKiIGny9FAyXH/eNC/kPIJdn2ueRHJyuJnYqu86
 UpeCg9+fKvTTD15zZxjywqODK3WaI6oTPgHlZ4eUuTmVLWW9wYRCW54P1w6OnoOLIB63
 tY0eKDA0d5YxHPCClf0wSZnTjGIMxye2mevb/H1XUwsHkWHitY7ObP8+Z3ygEdavYHWs
 xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064813; x=1722669613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NJTOyzjSlfNeZ5isli+1YIundr9ep5kny/FT3tTejQ=;
 b=WrBxkTgcg3u5d2Ox90PhBwaxIvlGNHwbB7VtPGa/Ws0xyJzCcVoTcR6MVGjip+9BYK
 MefJQRQpBL8RW9EtxNjJFwWB0PtsGXKCJuP2GLmVwdGOzFZScXcMxq7+G4mR5WFX+9L5
 nWMOvQGLxs8Z6f57V/FC/BP5smeUgCGCNZxwj3wnuERtiXhyXiMYnZ41IOiDPY83CAL4
 zp/cB60pjub6ScSJ9auOhFzEXrx93tFFsiSIX+exNWYsEFxobCD2J6e2Rx0nUzftdTO9
 8CQVYGIpF2F+GDTdXkbMIYKF1kaBrbAaDVEQLyl9W+4NobmV5uMXiFoo30bIoD1hseOG
 we8w==
X-Gm-Message-State: AOJu0Ywxc8YiXOqIozeu40MpJ6vmGLnGuUPE05GJzSADMofa7dqiKZcv
 5AwbWPNSXLsZLY6D6Q6Gf5lz7nxdDM2+U8Us7oj4ND1iS5UW/CBjaqs5AdQsj+bANwK3FFosXcR
 wxLs=
X-Google-Smtp-Source: AGHT+IE6SbEATNpX5LxglxsDuM5m4Onl54gMsQt/JKeERSyQbuYOG08+W96hSCAjpIXq0wjkbK44Vw==
X-Received: by 2002:a17:907:c70a:b0:a77:cd51:3b32 with SMTP id
 a640c23a62f3a-a7d4014c651mr89823066b.62.1722064813657; 
 Sat, 27 Jul 2024 00:20:13 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:13 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Maximilian Brune <maximilian.brune@9elements.com>
Subject: [PATCH 05/17] serial: serial_pl01x: Implement .getinfo() for PL01
Date: Sat, 27 Jul 2024 09:17:06 +0200
Message-ID: <20240727071742.1735703-6-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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
2.45.2

