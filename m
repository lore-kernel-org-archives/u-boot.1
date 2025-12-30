Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF5FEE498E
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4EC83F9D;
	Tue, 30 Dec 2025 17:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRoR4eGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBFC83F6D; Tue, 30 Dec 2025 17:01:41 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BEA83F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34ccb7ad166so9297048a91.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110498; x=1767715298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCRmkMHV2EDtCDLkzM4fJdX2WrXLQOnX6j9Xc2hL0Gg=;
 b=IRoR4eGNkg4IfE0IH+acphVJGXAS1FYwsiB3CqCdyq2YBmYEso4XQbkXRvDPwNoSYS
 ptVEiuvqVg1Sg50naenJo6HQZHh5bo2DX+YK8CmNSyRmDoatLY1Ospxs5cbT68wE7npu
 WtVDj8uxEIHPr5usIOvOq2SgWmXFewEaGA4Sd2y3g1II5bBxUtbdIHuRpYMgM2LfiKAT
 5dYQMjSW4C56K6sUxV131bE6UJn//EifNJ1jQOqnpgu6vwGkJxqP4YYvMv0MxaX+sdbP
 C97GiCCqYvsBpR5tYOHAhmn+xWHUAeR62+D9fEM9rH9AO3TSmespiLcMOtLkwIWRvypn
 eCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110498; x=1767715298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mCRmkMHV2EDtCDLkzM4fJdX2WrXLQOnX6j9Xc2hL0Gg=;
 b=QRderH7vkRZmdg8CaAocN3smv0VnuIeEyw4lVM7ae/vv7nN22yQGVR03uL+syQw7Iz
 fbnNmLxy8CLjUGlb15I23X8mETbnCN53Vo3bVNNhb4QNg5ySerpRgokHE2SKAzm0XVb+
 aV07j6OIN6eWJ4mwRnleoAXfnNe32MdAHhvGfEfSigA+IC27m7XPH93xHe7luE5HEPlH
 rMt1q0lpqMuPc7JeC8hU2+dzSpqiy3UuJxPAvoGxVuNVhV8RmdXLNKn2xHnwAyFe1QwJ
 d0dFOva8VYS6YMtQy11RwKFuGUsn/Jec25JCrqhHYTmo6gvO0SYT2glDw6KFdg1gN1ud
 Utgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU74tvuXiC2ZfiiV0Gwor93RUHmp9wz9sqa1QlC0JNagl/phfS9C/iVpy/fHtpjJSRw51aiwtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3ZfmnF2RMlnCZY4udASa/Dr7zUAgRVRaHZuDh7XYrav0hRVeM
 TDu7KnLOy9t5aN3JmDVsj6Pp0+EBVBhietScO8hhj7sL4CdXjD3CyNVh
X-Gm-Gg: AY/fxX4NeGacpJBDbES7PgoUkyAB8t8P34ZCvNPuce1qEpM4GQei1I7APq0zU/ok4RZ
 ilKLb+9eHJCHPaihefgttxlthhmq2/qgpAOCPfwmWp9ywwiVo4QGrdhg/rdewnM7EFkl0s7RM3i
 1XtSqcAwbLpEx4HIMn3IIQWE8V0sE21QkR9N/4+TDATMdbDyNuvFm2Ek8SYclnJS7M9iqexQnkv
 SyrO39TkUbVRHSO/1RHvSs10UC0qSd5w1WTEDGwEHQx4/fcP3gbst7SDzXkMLLXJy+1gRQIFcAD
 Nmrne/r7u9MSUAxT6m9q2jhFYJXu/x6mrJ1FZUZ5pmp2/kByechXoGQlhal2zqrQOTZWLP3rjZ3
 FL9aIFdOvehbFp50lOpc183wELUjLdAU1mEgbkqV8cyi1uQfDVN6Hcp4GzPjbXMbhWO30Jgdy8u
 S6YXS/ZM/7rbMLFFA5qSSKELQt9cn8phN++93ZQ4KbW1Jjxffly5zxnFaDlp8JKcqjbbi/PR5zG
 L9q7G1Rrpod3MlOUExF0w==
X-Google-Smtp-Source: AGHT+IH2GHjhkILCMI5XSpBtJnQwUFnQ1uNMa3+EiB7KReOUHWBbC3Rkuuwstmq6IMW0QPtHhMPeGg==
X-Received: by 2002:a17:90b:1e42:b0:341:6164:c27d with SMTP id
 98e67ed59e1d1-34e92137f6fmr26625033a91.3.1767110497787; 
 Tue, 30 Dec 2025 08:01:37 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c8a2sm28558883a12.6.2025.12.30.08.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:01:37 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 3/6] rtc: goldfish: Support platform data for non-DT probing
Date: Tue, 30 Dec 2025 16:01:09 +0000
Message-ID: <20251230160112.3045527-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230160112.3045527-1-visitorckw@gmail.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Dec 2025 17:55:53 +0100
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
Changes in v3:
- New patch.

It appears there is no specific maintainer listed for this driver?

 drivers/rtc/goldfish_rtc.c | 10 ++++++++--
 include/goldfish_rtc.h     | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 include/goldfish_rtc.h

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index e63a2766c76..900daabccb9 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -9,6 +9,7 @@
 
 #include <div64.h>
 #include <dm.h>
+#include <goldfish_rtc.h>
 #include <mapmem.h>
 #include <rtc.h>
 #include <linux/io.h>
@@ -77,11 +78,16 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
 static int goldfish_rtc_probe(struct udevice *dev)
 {
 	struct goldfish_rtc *priv = dev_get_priv(dev);
+	struct goldfish_rtc_plat *plat;
 	fdt_addr_t addr;
 
 	addr = dev_read_addr(dev);
-	if (addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
+	if (addr == FDT_ADDR_T_NONE) {
+		plat = dev_get_plat(dev);
+		if (!plat)
+			return -EINVAL;
+		addr = (fdt_addr_t)plat->base;
+	}
 	priv->base = map_sysmem(addr, 0x20);
 
 	return 0;
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

