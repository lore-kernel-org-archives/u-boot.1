Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F56FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6697087622;
	Tue, 21 Nov 2023 23:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="BQSzU+jG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598C487282; Tue, 21 Nov 2023 23:54:52 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57DA86784
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c210e34088so3369619a12.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700607288; x=1701212088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZS/y2YMV7keJ93NCFqF3kU/QNVVc3pdB+4H5q7GkX3Y=;
 b=BQSzU+jGcXd5a/cIg7ZpiDW3yUPuB/fokViIn11U0GvNVi9EpDLmdIznHvoaDRGQdG
 A5T5zu9PLVY6mgEq6aEeXAsZ9T2F0nDali5kQBKfEz45hD+8+oUrFjboR9RMRUuKio54
 cj19LCivTsj27D3r6a0aGCMlXaYYKjYn2ldVg9oXvblwmqX4XD1MpJShhS9f4iWah7O+
 cdMS5n66/OuGz9zN9VUF7jnpkggfOAOQ3awcAyMXcG/dp+XZG/+gg5MrdiAtW5IgYXYV
 gd/o0uRq4sxVMnKs5J5h52r5FZq56rqj4xZ35LsbXTeEvP8LHI251YAhnDUdAmRBrPVE
 vd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700607288; x=1701212088;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZS/y2YMV7keJ93NCFqF3kU/QNVVc3pdB+4H5q7GkX3Y=;
 b=Bij1j0T/95MkcKeX46hjeaYNh3OBhyWohnkODzU2XSurYXLxPkQh7m7ozdEjWg9d71
 uwTQqlEUslzGfoV5R63mr65scs2VzQPyhqZ0Nc9BH5bclwdtQIHY8dV0GwTIgiDvQrmv
 O9qK8ul5RtZcRrSP7MweuPfyzJJig1IO3vajRmNDyUlwvCvl1XfGdaRl5WAJVtFM0EKx
 9fU3G3oPfByE/o7dix+RTJ7x4XsvOSjuwGWX3KTnq650GDgTLEu1YsIl3UGhpTTHvzR7
 A6hBTfb3PJOpr8XdLP40JfU4/g+IlXfzLM/vd9HoPZZG8twWAXZBMNVfniwegVMpTWH2
 Ilng==
X-Gm-Message-State: AOJu0Yzr0C3ncXvm9fd9bLKz+PUKihLcRrvtTkaPkDZ/3xtq/GpNjIaF
 waLPLp33HMTOeflYO1WV211Of7Kzd8FBYSfloWGw0+RYXcXIxAPoeDS8XQ==
X-Google-Smtp-Source: AGHT+IHtlkP85rpC5zxbtnm75evTP7njps6KBtxYoF5WTo8cFfgVrPGNnKvePfuA7WnlY9jwSj9gGiFVOKGoqpf56Xo=
X-Received: by 2002:a17:90b:4ace:b0:280:2652:d42 with SMTP id
 mh14-20020a17090b4ace00b0028026520d42mr736984pjb.23.1700607287908; Tue, 21
 Nov 2023 14:54:47 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Tue, 21 Nov 2023 23:54:37 +0100
Message-ID: <CAKRNjQ20oazcjhAR3+WaQG0MObvHC_Zya8mZKwaRrcCeuZAhpw@mail.gmail.com>
Subject: [PATCH v2 2/3] rpi5: initial support
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, mbrugger@suse.com, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Nov 2023 23:57:42 +0100
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

rpi5: add alternative way to get MBOX address via FDT
 node

MBOX on RPI5/bcm2712 has a different offset. Find it via
"brcm,bcm2835-mbox" node.

Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
---
v2:
      new patch
---
 arch/arm/mach-bcm283x/include/mach/base.h |  1 +
 arch/arm/mach-bcm283x/include/mach/mbox.h |  4 ++--
 arch/arm/mach-bcm283x/init.c              | 12 +++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

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
index 362838e9b9..aef3a31f29 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -145,6 +145,11 @@ static void rpi_update_mem_map(void) {}

 unsigned long rpi_bcm283x_base = 0x3f000000;

+/* This is intialized before relocation. Enforce .data section usage.
+ * Otherwise it's going to .bss and will be zero after relocation.
+ */
+unsigned long __section(".data") rpi_bcm283x_mbox_addr;
+
 int arch_cpu_init(void)
 {
     icache_enable();
@@ -154,7 +159,7 @@ int arch_cpu_init(void)

 int mach_cpu_init(void)
 {
-    int ret, soc_offset;
+    int ret, soc_offset, mbox_offset;
     u64 io_base, size;

     rpi_update_mem_map();
@@ -170,6 +175,11 @@ int mach_cpu_init(void)
         return ret;

     rpi_bcm283x_base = io_base;
+    rpi_bcm283x_mbox_addr = rpi_bcm283x_base + 0xb880;
+
+    mbox_offset = fdt_node_offset_by_compatible((void*)gd->fdt_blob,
soc_offset, "brcm,bcm2835-mbox");
+    if (mbox_offset > soc_offset)
+        rpi_bcm283x_mbox_addr =
fdt_get_base_address((void*)gd->fdt_blob, mbox_offset);

     return 0;
 }
-- 
2.40.1
