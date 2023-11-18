Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD43C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 16:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA9086F1F;
	Sat, 18 Nov 2023 17:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="R4nOP5jB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F3C86BFA; Sat, 18 Nov 2023 17:42:05 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04FE86AB3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 17:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2839b922c18so1103038a91.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700325714; x=1700930514; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Zt+xm0H7H77zcxTbKb+bTa+WYaPcMoNijUUckxVJFIk=;
 b=R4nOP5jB4zZfiGxbtJQbh4OO7bdhYY3PQQsTUz/pF4y+zGzDu2UOyTotc5QxFnJKTC
 fp3T/aEyrMtLSe3aZwFavOQQZ+dwzWLn5k58Aqf1kbqwoWBUHztR3TZ9Qe7CCx04iD96
 /obReDT1g6xBLsM0Gql5puBQ9hs+0RgYsFB6TpClHweMGCiNkn8sxzBovWOtPaTrDkK3
 p59OJp36E2cWsnLjiBJvrdPrzmCCbrBc0oL7wzaRLTMFNXf0thHLdijZkj4Q9g2zdtJe
 3UNPgFYKU4kaamWbfETQZcip2BbUyZynqh3LzQUakjhullKJJJmWUfqyml8ls7ziaS6G
 gSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700325714; x=1700930514;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zt+xm0H7H77zcxTbKb+bTa+WYaPcMoNijUUckxVJFIk=;
 b=fBejRSY7TTQEWDqduSDU2LHPxXozqQTKfuwdsg3DP1V2q58Dp/2xh12Za11vBTDqTk
 WpWHFMcsOcMj9HeuxTGITZWncjoevpTBxYPDfTem1lNZO4AVobxYQs9JA8M7sfHyG3Hb
 9anP003NvYCT/ow5X3FDJiq+sErjoEew9VKoBTbTUJf9RAArOAD8KQThelGGYc1xpDDi
 mk2n0m8qQLPWbMV3COwMP09UVmiwM1E1wNzXtSiAilM+VySM+Y25H1t3V5lbjFMXJDeZ
 Bj5BnPncnH5neIbI2s0XPbdG+OxOtErvQcFtwWigrRvx3pu0kPEiyuNn3ULceovTCtQE
 HBrg==
X-Gm-Message-State: AOJu0Yy9KSqqr3skcwh0kiI3bTavVnjgyeVu/FDFrSrpfT1Qk8EbCy3g
 3lsQuNKwsZhjrOmdDeBagVCuFIBgZhFUBmuE+HAwIdMEPlpIgSC9H4Yz3w==
X-Google-Smtp-Source: AGHT+IHITNZHJYwZqX90SdTlFjOjlykKnvQIvdZ8jN/PI6Qhw8mO5UsQH6nW4B4bVM5dWA+NubCpvQB8dH7bSuLB3rc=
X-Received: by 2002:a17:90b:3ecb:b0:283:27e0:6548 with SMTP id
 rm11-20020a17090b3ecb00b0028327e06548mr2505790pjb.47.1700325713921; Sat, 18
 Nov 2023 08:41:53 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Sat, 18 Nov 2023 17:41:43 +0100
Message-ID: <CAKRNjQ0GwWEzYWQuFAVDan9Zj09V9a8f2HJ3+Y85J_2_Vtfdfg@mail.gmail.com>
Subject: [RFC PATCH 1/2] rpi5: initial support
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 18 Nov 2023 17:42:48 +0100
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

rpi5: add alternative way to get MBOX address via FDT node

MBOX on RPI5/bcm2712 has a different offset. Find it via the
"brcm,bcm2835-mbox" node.
---
 arch/arm/mach-bcm283x/include/mach/base.h | 1 +
 arch/arm/mach-bcm283x/include/mach/mbox.h | 4 ++--
 arch/arm/mach-bcm283x/init.c              | 8 +++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm283x/include/mach/base.h
b/arch/arm/mach-bcm283x/include/mach/base.h
index 4ccaf69693..8cd224921e 100644
--- a/arch/arm/mach-bcm283x/include/mach/base.h
+++ b/arch/arm/mach-bcm283x/include/mach/base.h
@@ -7,6 +7,7 @@
 #define _BCM283x_BASE_H_

 extern unsigned long rpi_bcm283x_base;
+extern unsigned long rpi_bcm283x_mbox_addr;

 #ifdef CONFIG_ARMV7_LPAE
 #ifdef CONFIG_TARGET_RPI_4_32B
diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h
b/arch/arm/mach-bcm283x/include/mach/mbox.h
index 490664f878..ad086be467 100644
--- a/arch/arm/mach-bcm283x/include/mach/mbox.h
+++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
@@ -38,8 +38,8 @@

 /* Raw mailbox HW */

-#define BCM2835_MBOX_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
-                 rpi_bcm283x_base + 0x0000b880; })
+#define BCM2835_MBOX_PHYSADDR ({ BUG_ON(!rpi_bcm283x_mbox_addr); \
+                 rpi_bcm283x_mbox_addr; })

 struct bcm2835_mbox_regs {
     u32 read;
diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7265faf6ce..d76c8e5eb2 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -116,6 +116,7 @@ static void rpi_update_mem_map(void) {}
 #endif

 unsigned long rpi_bcm283x_base = 0x3f000000;
+unsigned long rpi_bcm283x_mbox_addr;

 int arch_cpu_init(void)
 {
@@ -126,7 +127,7 @@ int arch_cpu_init(void)

 int mach_cpu_init(void)
 {
-    int ret, soc_offset;
+    int ret, soc_offset, mbox_offset;
     u64 io_base, size;

     rpi_update_mem_map();
@@ -142,6 +143,11 @@ int mach_cpu_init(void)
         return ret;

     rpi_bcm283x_base = io_base;
+    rpi_bcm283x_mbox_addr = rpi_bcm283x_base + 0xb880;
+
+    mbox_offset = fdt_node_offset_by_compatible((void*)gd->fdt_blob,
soc_offset, "brcm,bcm2835-mbox");
+    if (mbox_offset > 0)
+        rpi_bcm283x_mbox_addr =
fdt_get_base_address((void*)gd->fdt_blob, mbox_offset);

     return 0;
 }
-- 
2.40.1
