Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35464CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AF388D4E;
	Fri,  6 Sep 2024 09:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="E8QlG1Kn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FCB88D21; Fri,  6 Sep 2024 09:22:44 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B1E88D22
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a868d7f92feso239068466b.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607361; x=1726212161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIIyRDY1eWv8t2ucL2WXgANMC+Yu+DY4eC73809BkgI=;
 b=E8QlG1KnX7kzhixYk74wHnz6tNCX/FDZu/d+9jfnOfkedYRq2ZxpejPxkQkncVNWXO
 gMAQedGPVWULOQN0or37rZnRDpC623iJn5McC49XXcuqQQUJB2hWMi4XhPyP99IIBj6p
 gwoJJSi5NP7Rd22UOSqQW7bxsn68sDVPKaV72sUflnsrHeyYUdsS3LAZDpA2Guxwb+Tq
 NUYXB+THWIwwXINtIWYB/mZYjJyRgYdsBwGdko9GBV2NDpenAdyaXgN6JTPzZjrkpwXs
 tG7jwRGvsKFQ67lJw8TH812fdTgWYpq3+2TbMNQY62jWill+xSCf+ykFGwoouD2bvzhG
 N+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607361; x=1726212161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIIyRDY1eWv8t2ucL2WXgANMC+Yu+DY4eC73809BkgI=;
 b=PwNs5xA/MMR7y4Wrw91OssDCSh/r5gEEiAIZkeqc99GWS1RqNB0fj2/24jiDPzq5zP
 phN7/OalisaCHz7bzLHhLOLMFwY2IAGSqPhou1ovtMZeO02BLDU7fRWPZCPrwJsFslSF
 cmDjz5JsYEpssd8cobv2632y7XPb08fiBzGcRlIK/fuyToIPgcH+657xH0NwPm+qd6YR
 WzOoTQ7xj2+tTQkhjRHQEsIWwdrhkh/8wDj1KNvPAQ4aPwlVLFYBhWkv5fqqT8jqr9T9
 xdeK9qdlt8OjzYn0fwJ2MbbqA1+e5rM7k5fop8yjF64cKrvcrDLf1IRaOnVnAyMSiTA+
 4hwQ==
X-Gm-Message-State: AOJu0Yx5W6vtzLxeQ0ymC9jqZKXnGI4lxh7XNUnGx0PXuwFY1wXsWtVx
 qNgGSg12B/iNyUZtSwcdWj0ss4Rkl2KouDKlmF2eKMGEicIjqkHWJqFWQD8fqZVUnA+wPghZ0aJ
 P
X-Google-Smtp-Source: AGHT+IHtRU4TSkpNyz583hyPgBtr/gRsB5QdPRupzJBtarlbOMIfOMWISSgnBGlSEAuVtkdw5gJo1w==
X-Received: by 2002:a17:907:980d:b0:a77:e2e3:354d with SMTP id
 a640c23a62f3a-a897f83a33bmr2003205666b.23.1725607360854; 
 Fri, 06 Sep 2024 00:22:40 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com
Subject: [PATCH v2 05/28] serial: serial_pl01x: Implement .getinfo() for PL01
Date: Fri,  6 Sep 2024 09:22:07 +0200
Message-ID: <20240906072231.2531491-6-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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
2.45.2

