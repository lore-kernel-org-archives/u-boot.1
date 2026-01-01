Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F50EEE25C
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 21:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E2B83CEE;
	Thu,  1 Jan 2026 22:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lr9EzrAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9190283C6E; Thu,  1 Jan 2026 18:54:48 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6069483BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so103109395ad.3
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767290085; x=1767894885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5AFa6EKanWPKcU3cnR2ARYum2Q2gFVKZOPin6hIWO4=;
 b=lr9EzrAXQ7XYzIfbag0jSjNR4jWlaYS7MzeJH5bTi3hIgAFW2WW+nc/tTPRr6EmAae
 /aHKpLgiOAnHyUDdJrRLl4Oh+pTusKVKykPEH/ztMG3MuBCpaGe3B9T8ehc6TTXd9Osw
 CsQwhTybgFCjBWc13En4MIE+fB3t9HfUt4jxoHjGU7LR4jGeeBMwdnRdwykpQPp+qFG4
 QfOylYe5xi4CJMeQhyYQEtfUp5vtM8qsFBxeuiTYnDPSn54VvbcqViWzL+g1xBxHJus4
 CvSbbLx6NbDvC4wgb6RV0YRhNbApDGnVwkdroYprWOupljs4tmBhZaUXKlpIOyuNWLOS
 loDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767290085; x=1767894885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e5AFa6EKanWPKcU3cnR2ARYum2Q2gFVKZOPin6hIWO4=;
 b=hL4rCWs4D/rhPTMqJAkKFMYStoZ7+AbV7lAxk/8DT1PK1YebZdrnQePSM5aD7e1t8V
 9gyBzTOE1FnFIx1Ib8OhwghF9JXp2OH9wtbBOl5udLJRsllnZkAeT2gv3nZYZGTU1RpJ
 popn+qxGPa9TWCEo3680DPfVjoz/UPeBQ/CpOOAur6rdAYRba3JD62X2iwai6FrjOcBt
 oAjzGdrNz+l2fM/Z9PeCcxuzT1i1WuXnNuLAw5C823p5yzi+ApiV6ToWfdnUfdPwBSG8
 YA3aC9plOlA3c7YMzMKj04wDX81f3iVjw9Dt/x8j11jLOGRnokZ6bU4+qjB7/KH/EF5K
 JLWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu8RsQzuh9roVFNimqr0Gkh2llJyndS9iwTnefxmONjM6XbfM88kSR9Q9SFXv67sEekZ1y55o=@lists.denx.de
X-Gm-Message-State: AOJu0YwfCukwA3yDDrRr0v9awUX3KFxpIXm9+VFByj16sK4kQ9Yevort
 4fRKL5JM2IpLjCgfAcQjUKA1+ZAbJvgXOgS5JMyDq/GzUyh9nZXZ2yiO
X-Gm-Gg: AY/fxX6DTadghjiR+xyZektnw5LvxK61Q9Sh79Foz7OxsyDGpQUFUwe4r0hZMvi7dUB
 v85HL6zGCDL46iHLCKBoyEKMaqLEAvpst0co76owTqO9pJm7WbQKKQOLvNTRc3T/fnhv6bWAYjG
 EG3lSInubW9Jr3ngqmXIB06V/0AtSq6D9Jp7XKhpuDCrXCrBlyvdGoShES1i62QekZq2ZZQgbqC
 M5YekW9M7zCcUi0MYxDFboPsFgvbynvMEwDRzuGh4JhrH1ZPp3x57BR+DjVCQiVFv+yc1/rH74L
 srqlllnFf1GeOPFveReLIJRUVflGNKRpsRUxGkVr+NN5ed7mjfIykOPKQdzXYB0fjeQuU0N4MKJ
 bAD+2hFkoqcCtY6lQIoND9Kq8RyU1wVwAFx2KpVHKgN70XGVVcZOB+CKjMaVqu/prT/LZ4eDOVh
 AA0CcqvYa/vRkmqZJ8shDJEevKFJkPCv0d+awLwM3jEieTzA6RC8vIJ1F11SnxHPgItOohcED5L
 mwwq/i0UdTWcgeZfQrrjipDa4IAMW1n
X-Google-Smtp-Source: AGHT+IG2S3ZS9IXKSl6E9/lzkjphRetocNxEcLfJ2Wmk1L2nicF1VBkaAw5dvYPhlyRWnLnMnGr/PQ==
X-Received: by 2002:a17:902:db12:b0:29d:65ed:f481 with SMTP id
 d9443c01a7336-2a2f1f7698fmr388768515ad.0.1767290084875; 
 Thu, 01 Jan 2026 09:54:44 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3a8770e66sm40000615ad.42.2026.01.01.09.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:54:44 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 3/6] rtc: goldfish: Support platform data for non-DT probing
Date: Thu,  1 Jan 2026 17:54:17 +0000
Message-ID: <20260101175420.4118024-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260101175420.4118024-1-visitorckw@gmail.com>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Jan 2026 22:15:35 +0100
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

Add support for platform data to address this limitation. Update the
probe function to fall back to retrieving the base address from
struct goldfish_rtc_plat if the device tree address is unavailable.
Introduce a new header file include/goldfish_rtc.h to define the
platform data structure.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v4:
- Fix sandbox build warning by removing incorrect pointer casting.
- Assign plat->base directly to priv->base instead of using
  map_sysmem() for platform data.

 drivers/rtc/goldfish_rtc.c | 13 ++++++++++---
 include/goldfish_rtc.h     | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100644 include/goldfish_rtc.h

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index e63a2766c76..f6316896595 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -9,6 +9,7 @@
 
 #include <div64.h>
 #include <dm.h>
+#include <goldfish_rtc.h>
 #include <mapmem.h>
 #include <rtc.h>
 #include <linux/io.h>
@@ -77,12 +78,18 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
 static int goldfish_rtc_probe(struct udevice *dev)
 {
 	struct goldfish_rtc *priv = dev_get_priv(dev);
+	struct goldfish_rtc_plat *plat;
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
-	priv->base = map_sysmem(addr, 0x20);
+	if (addr != FDT_ADDR_T_NONE) {
+		priv->base = map_sysmem(addr, 0x20);
+	} else {
+		plat = dev_get_plat(dev);
+		if (!plat)
+			return -EINVAL;
+		priv->base = plat->base;
+	}
 
 	return 0;
 }
diff --git a/include/goldfish_rtc.h b/include/goldfish_rtc.h
new file mode 100644
index 00000000000..bb113a0bd79
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
+	void __iomem *base;
+};
+
+#endif /* _GOLDFISH_RTC_H_ */
-- 
2.52.0.358.g0dd7633a29-goog

