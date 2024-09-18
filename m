Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E94CDD541
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A5388E07;
	Wed, 18 Sep 2024 17:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="JB01HMQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 803E388EF7; Wed, 18 Sep 2024 17:22:10 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1076C88706
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdba33b0so8805724a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672927; x=1727277727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ta632l/OzkeBllyBS1wjgzq57epJ46bHhzgb4ezorw0=;
 b=JB01HMQaTvcJU7rh9qqSUDhgvyRjRLyXgiGV3RhF9hgHFwIMHYyFJyh4MlKNFpXIbk
 9nPaG8JFq0Lec0ToUSHFkYiubIieBBMgc0hP4ZJuT1g891CwkVz73t+IACkQ2o1fLMtW
 Cxr8eKhfysuzj1KnW3GYvlImWY4jmnDT1wZmen7uN+MsF103AWjfCDa/avVvtER+WiIH
 UPc8Y+g3UZVjjS0QC7nwTYd503I3JxdrfoZyVewmcr/94HjEzMEQIeMwVTxz803YNfC9
 Efj4zDlk7vfr+fOhuLJ90dZmgm8KVjK7ufIjQePTnFevQ0yGkQM+0cK3LnJzBDsDctBb
 NdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672927; x=1727277727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ta632l/OzkeBllyBS1wjgzq57epJ46bHhzgb4ezorw0=;
 b=nBxGQimH3hbJiYFDDzPMxT4Pq802wnHxWpcoL3oTSeIlsEcWhEdQVOE8A6SXFJBb85
 vPeSJZr0hRrYsvXzywhhnfTj/W2FJxcssIaNGaxo+IYRbz9i//47FgTmLIBwCWDsr4F7
 Qq2lXR1I/evf0lTOhV8DXqQyfubSsOB5vse1tIkWiqXzfPcDBhSzF9qqWISgRT9ncEIx
 J6FeAlkg9p/p0J/wAb9kT7GIt0kIaca72fLZKdlmco8kjJD5SnBgBwK6+2Je4c/UKAQY
 IAOgwcj2XYEzi8K0wuqkRy13r7Os8gkB6EV5F9uyekn4bIAYRxpf7e6wEgaiKC5gAHkE
 gyag==
X-Gm-Message-State: AOJu0YyD+2eWbuVGQyyu5DpLgXTo7LaMqRPh3hY9S0L7HmsD2uO2jhIk
 zEoelyBJrOrAVJU36T/D97ni+jBKwK6xwLeDe75fgpt90c0qlN2uaUALvncAJ6MSFUXjS45HP6E
 S
X-Google-Smtp-Source: AGHT+IFxXrwxpBxX70yTX2+7JQ6/FfqknnaC1kITKO24UkpUfwPEA2een8Lg2Df+qNClzlPeRzbirA==
X-Received: by 2002:a17:907:e220:b0:a8b:154b:7649 with SMTP id
 a640c23a62f3a-a9029472608mr2087224866b.15.1726672927405; 
 Wed, 18 Sep 2024 08:22:07 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:07 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/35] serial: serial_pl01x: Implement .getinfo() for PL01
Date: Wed, 18 Sep 2024 17:20:09 +0200
Message-ID: <20240918152136.3395170-6-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

