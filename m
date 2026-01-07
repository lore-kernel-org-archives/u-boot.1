Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D245D0D16C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB8383A1E;
	Wed,  7 Jan 2026 21:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V5/CjKuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2182383A2D; Wed,  7 Jan 2026 21:19:18 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444CC839A5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c13771b2cf9so1800651a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767817154; x=1768421954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpKK+z6m2j6q0w3y6fPS9C7LO0p86cGCIFGvp1Cd38k=;
 b=V5/CjKufCkwTkvqohV/c4Z9wvHvSeZjvLw8MA8UI4xi6nVrBhnI6dh8r1LyUBogvez
 1PTIg6DDwaP6qHjSm4Qwr0pzlpcvQn2R+MrnvhJEMM2y9MTD+iOfRdL+GLRhVtiirV8p
 G7LbSMqXC13cPOLr/v2EpCEIm8Jq+Omi353HCmLfmjMhvWrpvq6npZTUR0+xYfQGZ6bo
 zUFbE+8V1WcNtEXuGwZ0zTBmSOOH+svuv+KrsRPl5g3vBqUq3TlEmsKz1Jl+//ZJqYJW
 txFCCLoNRcKzu4aPKbijVTeyvPMqssY0F1EXh6zQJGt8pX2ZQHn68tbggS+UA49ESaiT
 tj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817154; x=1768421954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dpKK+z6m2j6q0w3y6fPS9C7LO0p86cGCIFGvp1Cd38k=;
 b=ZnKQS+bho6ZegYj5x88dKrj+rKKoYHKHGdYfyphIAReLTJ9V86+e30hmnTPuuy3p8U
 lgajOsWPQfmSKGJuNSltYisjB4wP5qWpy3KPPpqBCOSKUkqzRN2y2+OyCOYVua+Tg7J7
 zcTzJtULMV+ba+YW/R1GiyO0AC5KxPVPDztzL0+RZKV3Ann1Aww2CpcdY7jUlMnWyZ63
 6MwK9gue1QIcUiamKhhxZQoQg20QqPBr+2H1OSmkP6d45sF7S6vJS1Ap4L9CbF0Hiff4
 XItc1DnoddMQ0E9m+4UoXVYLgRGYIs1tX0RQ9NudYBqoLpkEO5lFPJRxKedJ6PLSEhFy
 bOGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRDcvh9M9jn1kr1h/GqX1G8C15vKFciBZRCtrlMR+884XzFBoFwRRKnFwrRSy7YswqCgECLFM=@lists.denx.de
X-Gm-Message-State: AOJu0YzsreRkk2xXFjgupKBvuoe9VJAkSNLDYVR/2H5b/+QuwbKKscDu
 9O57KmvUVLgEnroStvkkpTIaK6w7f3vciw6cSPcKVTf1+5uJxWlqkQtpq1QP7w==
X-Gm-Gg: AY/fxX5B98yJoWzTg94ewIteCh+PoP3tkYPcW1JuRP4KKC4jvylg47ZVU+tW0WEDZOu
 7JufX5lpZ4znateCD7RC4rcTyvK3HVSb+LWGVh+K24fLTgHbUF30j6M54/BpjSLewtikXsRYn9o
 41n4DaGkrvf2AuqVAvLGUecl5OWZ9dAYUi7CWz5J0v2RVuOx1ze1GzzEuVWTNkMP1nMSIQdaFO3
 wC9txIbTTSWilnEHelKqUpo/98WiaMTTuvIx+Wvk29FLPXkDdLb9zAbVmK7vHYfkgr28CGVWA18
 9vDbWp9qBYzBFrBTcabCF0gSufjGfcf5cii1pH9f5tcjpuPZb6XYQsPBXVI3TxcqrXkY+ir3c7G
 5HJVIN0NmAyDaas5dlI41yPBHnlukky0WZh9yegZfldQ7QU+l5q+Tgwx3KsUFzVfLgo1Uc4r0ds
 A+eQkQTaVfy5cpKcVNI62JWNRYeXLT/VwooZY3aNCblaEG6rdrBD1sQyUKWUaV6KqtluXMsdLRo
 gzCmjVoi3vRJO1SdMquVg==
X-Google-Smtp-Source: AGHT+IEVSwvtTXj0pbMJBI0tr86oPUBGppvii3YIFe0dXDhWoa2l+UAnL6gUCclmcFEl8deAbJ9VWw==
X-Received: by 2002:a17:90b:57e6:b0:340:2a59:45c6 with SMTP id
 98e67ed59e1d1-34f68c7a89fmr3544186a91.4.1767817153678; 
 Wed, 07 Jan 2026 12:19:13 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa947ecsm5766077a91.6.2026.01.07.12.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 12:19:13 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v6 3/8] rtc: goldfish: Support platform data for non-DT probing
Date: Wed,  7 Jan 2026 20:18:32 +0000
Message-ID: <20260107201838.3448806-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 21:19:33 +0100
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

Currently, the Goldfish RTC driver exclusively relies on device tree
to retrieve the base address, failing immediately if dev_read_addr()
returns FDT_ADDR_T_NONE. This restriction prevents the driver from
being used on platforms that instantiate devices via U_BOOT_DRVINFO()
instead of device tree, such as the QEMU m68k virt machine.

Add support for platform data to address this limitation. Introduce a
new .of_to_plat hook to handle device tree parsing and populate the
platform data. Update the probe function to rely exclusively on this
platform data, enabling support for both Device Tree and manual
instantiation.

Introduce a new header file include/goldfish_rtc.h to define the
platform data structure.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Changes in v6:
- Refactor driver to use .of_to_plat for DT parsing instead of fallback
  logic in probe.
- Ensure platform data member is named 'reg' with phys_addr_t type.
- Update header includes to follow U-Boot coding style.

 drivers/rtc/goldfish_rtc.c | 23 +++++++++++++++++++----
 include/goldfish_rtc.h     | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)
 create mode 100644 include/goldfish_rtc.h

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index e63a2766c76..d2991ca6719 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -9,6 +9,7 @@
 
 #include <div64.h>
 #include <dm.h>
+#include <goldfish_rtc.h>
 #include <mapmem.h>
 #include <rtc.h>
 #include <linux/io.h>
@@ -74,15 +75,27 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
 	return 0;
 }
 
-static int goldfish_rtc_probe(struct udevice *dev)
+static int goldfish_rtc_of_to_plat(struct udevice *dev)
 {
-	struct goldfish_rtc *priv = dev_get_priv(dev);
+	struct goldfish_rtc_plat *plat = dev_get_plat(dev);
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
+	if (addr != FDT_ADDR_T_NONE)
+		plat->reg = addr;
+
+	return 0;
+}
+
+static int goldfish_rtc_probe(struct udevice *dev)
+{
+	struct goldfish_rtc_plat *plat = dev_get_plat(dev);
+	struct goldfish_rtc *priv = dev_get_priv(dev);
+
+	if (!plat->reg)
 		return -EINVAL;
-	priv->base = map_sysmem(addr, 0x20);
+
+	priv->base = map_sysmem(plat->reg, 0x20);
 
 	return 0;
 }
@@ -103,5 +116,7 @@ U_BOOT_DRIVER(rtc_goldfish) = {
 	.ops		= &goldfish_rtc_ops,
 	.probe		= goldfish_rtc_probe,
 	.of_match	= goldfish_rtc_of_match,
+	.of_to_plat = goldfish_rtc_of_to_plat,
+	.plat_auto  = sizeof(struct goldfish_rtc_plat),
 	.priv_auto	= sizeof(struct goldfish_rtc),
 };
diff --git a/include/goldfish_rtc.h b/include/goldfish_rtc.h
new file mode 100644
index 00000000000..f0e6ba3d543
--- /dev/null
+++ b/include/goldfish_rtc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef _GOLDFISH_RTC_H_
+#define _GOLDFISH_RTC_H_
+
+#include <linux/types.h>
+
+struct goldfish_rtc_plat {
+	phys_addr_t reg;
+};
+
+#endif /* _GOLDFISH_RTC_H_ */
-- 
2.52.0.457.g6b5491de43-goog

