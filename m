Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382C7CF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FCF88FCD;
	Wed,  2 Oct 2024 11:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="DREguQm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7FA88FCC; Wed,  2 Oct 2024 11:51:39 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CCF88FC5
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5398f3be400so4185385e87.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862697; x=1728467497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9nBxhtPGVmMhSR0ukLqkGhhFmF2hldHtTOvj4rFDYU=;
 b=DREguQm4Zaa7p0NkWVY6x5k6aUaJZjrUebZr9lVcKR3Jhy79W/BXMwOwl+7522q5Lr
 8nRT5qqqogvSHW7LZG30+WDsaXXm6F+Gg4FjgZo7QT7ptCrcNSO8FrSdaNseZfa+/6Pd
 4GKqJMOEPs0Yr1nIXx6UNvYn3/yOXu1Q2qsHv7l/1j9IKrXaabsEBASPjzJ0K68NvVlr
 J1Qx+bw8NLUhTirFDJyNqShGDMHhR2RbC/yFv7m5wCp8HrUz0Yx+Ng1/tctqL7+QkXL/
 sN3+DjBFfbTJdt/GdQ1GXCvEnmzbiNJlCo8dIgHTU2ogHRvdKaFJ18h8uUpvMHmMXBGx
 Ep2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862697; x=1728467497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9nBxhtPGVmMhSR0ukLqkGhhFmF2hldHtTOvj4rFDYU=;
 b=tvdo/UQuBXBiQhHDOOe7g8olAPJZyZGfXK9oWMjK7IqvIgMScQVb59q6V/S4Y/hfWS
 FaOyfaKxKmQbzmp+9qOMBX6zZS77kaOMamJhVcbHZkaAatcoWsUiiZ7EA9bn/6FbslvZ
 2N2SPHc5EQYeVeeb3co1r++unqZ7HIulNXva9fQcrplfYCwuwR7L0mTFM2gJ62dD7hr8
 kZa0yQ97gQ6dvNIIpJ9z+p4bJO1fRIGmUga0vAquF7vVQMoO3RGHl0BJwSGddiVKqwjS
 T7T+ZU13cejTPMS37uEYgRq7aViB34u47Y29VT457lBDzMJB2acZzp/3H7ILPyYYte/D
 KwlQ==
X-Gm-Message-State: AOJu0YzUeeT70fLCALdQhNJAL4eOaHQeEIJBnqeK38lv5aN7cGmftgOq
 95RyXnmOKVkD68wu8qVYHArnro17l7+xnQJtZKl5pFRbuKps1TrNoIKFh70W5NaeU76IIRohBTS
 P
X-Google-Smtp-Source: AGHT+IGn1O3WTQMgO3hSZ5UDq0UE+8k8aeEYWUrlY/vfWaEzPaoKnKc9a0I5sgs8dW3kq6t105sa7g==
X-Received: by 2002:a05:6512:3d8d:b0:539:530e:9de5 with SMTP id
 2adb3069b0e04-539a07a89f2mr1325765e87.56.1727862696962; 
 Wed, 02 Oct 2024 02:51:36 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:51:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 05/37] serial: serial_pl01x: Implement .getinfo() for PL01
Date: Wed,  2 Oct 2024 11:46:56 +0200
Message-ID: <20241002094832.24933-6-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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
2.46.2

