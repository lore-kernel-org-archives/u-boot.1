Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7540C79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB1483EB3;
	Mon,  5 Jan 2026 19:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCmRyQ8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2013A83DFF; Mon,  5 Jan 2026 17:52:52 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA38A83DE4
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0834769f0so994325ad.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631968; x=1768236768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpZ4Lv3RlWk2dIp5NWMRefuqPYkEwi4XUaYSSAmjc0c=;
 b=LCmRyQ8oBzqsA9mxIztO55lLEYRNk5r5ngPjhkzb5D8zkIE6+MxIuBW2h3QxAxEPiN
 zB43O3AN/Mozgaj9G6yJ7/bDiFIvdNrFKh4+2oq7IfaOUTRMqA5uMwPX1B+9yNOtTiis
 /rXwcOpWj3T8ydHUJEnrvjgNzjBxB69uau3NIcfvYnDLH4O4jcq356sOM5Im9FeEiuFg
 XFrYCQSj2hiY5btnBswy5PBIEN8cO/jvvBa2ak15o3M5zeqvsM0+OrIOudwO8hq1U6t+
 sLW1gJbaQiw4neTSePO0llvwlR3FKthgogbchkcV+LDWops7DpKfNHzcW7ZsQbfoKuEC
 rHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631968; x=1768236768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NpZ4Lv3RlWk2dIp5NWMRefuqPYkEwi4XUaYSSAmjc0c=;
 b=SBc0mH+3e2RqONWKoLnFzzpYdFofctVFv2bdncSq14dvpvsK72QrkPPG3hOP2EYKrx
 YeXQOxDvrW3rRR21I7oJRMMVwwoRFe2Hs0LAP792UP4YtJD2QDSyix47/QaprCjNmDLx
 vg8jLWgd7q4Jn39Q53XBB9Ft267a6HLYGhk4DKRp3tPLEu4ecPBoAchxzyseLgpZHrMD
 zXvHhtMSp5LBSco2U466cgiO+3x+n7AyecAwlVehxIxs1pR8Bhb3yypOli3nh2X33P/4
 ixxcbl7xqMRHFEveleUdGGU7P0SkRwB3XBHPyXNqItl3ZKz4tw3NpT4382S2LElN+6iS
 kWBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWizlneTi2kkNWHsCGqqINHzxLTmDBFnQ5KKX9lv7ThSkw0r7ry9aq+aw/WxXFmifBZwcSCYbU=@lists.denx.de
X-Gm-Message-State: AOJu0YymvXQtH4QCL2pfxh4/zByk7Pa8eg1r6QhtKuRxIN9an5h7VF9C
 Ynl+22vlQTrFt3VkkZ5PLeN/KwzF7fYKj3btmXEKnDltsE6JS7LWfki2
X-Gm-Gg: AY/fxX6nlqRmU46f3j47Bh5ycID9ycLg+CM4vn+eYhtjFWeRchTa32VFJ4zribjBfd4
 hk8T5bur5+MVRrk6ynYXrihlM3wpBwbcHTC+5Xp3OuXQnYq0l092tuYAoCjAkh6isLMouTulLXk
 z8A/+9y0njMDeYFk7WfcmG5NFpawCx5ADjkvQWr8B59uvdl/wQgurkooiqKHEjj4/nCgFEHW2Y5
 2J53ZL9rn91gxnoSbMCeGfwFsslXYUcj7hNsJ3HhQRlkkwI7u6QxAeHege2Vcd9BvliXKDocm0I
 4HAYJQY/1GBHoeGYm7ka0c0USXTrG6kN52t09BOB+Xrcfbj+FjlHVXFyOIV5zPUe7QfJ9wUE2RM
 gGcLLPvnT+t4PbTjpodnY8u5C+aFRl09Tdbsz5S5o0zfjsK6p//g/J8/pYwsi71vAio7AbOBQ/T
 OyW3VOXvVTMd5oG6B0qEQY00A7wKSNDy8LcuBtXJuYYQmty8fz1n5l7utX2Ej+uxqLO2K1g8tK+
 3T252BohiGKjmGvhdzV8A==
X-Google-Smtp-Source: AGHT+IHN00+IY44XFSHMk07xzpdnCH+5pv/L05xQHbM+Qt/6TnYDE0hOeqD5LQzsuARVc6UtjLUVHw==
X-Received: by 2002:a17:902:d483:b0:2a0:d63c:784d with SMTP id
 d9443c01a7336-2a3e2e1282fmr2679365ad.40.1767631968295; 
 Mon, 05 Jan 2026 08:52:48 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:52:47 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT probing
Date: Mon,  5 Jan 2026 16:52:17 +0000
Message-ID: <20260105165221.1816070-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260105165221.1816070-1-visitorckw@gmail.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:16 +0100
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
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Changes in v5:
- Rebase on u-boot/next branch.

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

