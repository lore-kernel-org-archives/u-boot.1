Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62720C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 08:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C4D88349;
	Fri,  7 Jun 2024 10:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GefPFRpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A70388231; Fri,  7 Jun 2024 10:41:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7351C87FA1
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 10:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C39573F18B
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1717749703;
 bh=Pjj4/ARJ+CQ+r6cAQsac4hVmIwda8PgayuFnj0GK1B8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GefPFRpHyiWI+u0EiUAL5M03pL2btbAu3tVL/ogiySDoEU2MV/FPuyu31lk4MNKHE
 cO88v/TvcXWfIK0h3Beb5UumlB7v3BYUwI5nK+n6rCFJluNt4l+ey8UiPUXwpR6HuN
 KBwUaM1fJplm+7glzx69NOubZNLwmQBpFj8+r4EJiOXnmfCOJbX7L4xfMe4N9f09oT
 j5CBbyCgiRVTFWGk70IbKpeY2qLaMbzg8Q2TYOGiCFaehIAlmqDGXY/MMg5uwfbb5r
 AOef2ZO+3IpRM56+UT58C4+4FU9FtoCI5vz6PDm6+iLlDQPjq8++G8MN0Q7xgu9jFV
 yQc0YqWoqykIw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e808b1db8so1000467f8f.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 01:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717749703; x=1718354503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pjj4/ARJ+CQ+r6cAQsac4hVmIwda8PgayuFnj0GK1B8=;
 b=kQbRpWOgPMKpf58LJwrc4JzLYl4JP0PUNYPwxdgFsbFcOoeCjXkZe792jOV8UN41Db
 q95V4zDdWiY9f7S8ldUaQKeWGs8rRiN73WziW66MPW0N1shgQZt3Svf3RtkxDOv/nXFW
 HGFlRUBY4hHFedjdG4pg2C6MHg/226xbHo8gG3AOSOnwbAegEwCgbFXU+THXLbCj39J8
 C57J90RH5YUGyl2Yr1hiEGMCMXmLqo29Fp7U5sorusdFEO56gVibCh8QK5PVqFOMtEtv
 hcHxDqyrLwtMF1J+GbJOP2fqN3oWq2Ox7kk494if2BhKwCuipfjFfYYYH+Kv8aFVdtAn
 XmBg==
X-Gm-Message-State: AOJu0YyLBlall7zET6a7L79fD6ZWLSlx220mnZtj9VrRUwDHe0gnS1yH
 SqTTyMOs2c/9H7NFGZYLZWo2twlzQ0CGbS0qaRVPthE9tx8max0tCqGoI37NXni141C5zVQtPa5
 XYZiMA8BDdeH0DKxC7KgE3b0XJGv904EBqZ8oSPIFsEPe8HtsE0CR1QgxZF4E9x8DERk=
X-Received: by 2002:a05:6000:50b:b0:34d:7bbb:8d73 with SMTP id
 ffacd0b85a97d-35efea08efemr1825984f8f.2.1717749703375; 
 Fri, 07 Jun 2024 01:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSaYvl5D/TlfGkxeNWcNF38/EMYzlUlmBiMA6gZyG67ssSBD18KXPayu6Px5CnMKnH+ko+tA==
X-Received: by 2002:a05:6000:50b:b0:34d:7bbb:8d73 with SMTP id
 ffacd0b85a97d-35efea08efemr1825965f8f.2.1717749703032; 
 Fri, 07 Jun 2024 01:41:43 -0700 (PDT)
Received: from workstation5.. ([2a00:20:6:1be1:5467:bcef:945:5d8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d687f6sm3519913f8f.55.2024.06.07.01.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 01:41:42 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: add RISC-V fields to bdinfo command
Date: Fri,  7 Jun 2024 10:41:17 +0200
Message-ID: <20240607084117.58837-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The firmware invoking main U-Boot uses

* a0 to pass the boot hart
* a1 to pass a device-tree

Let the bdinfo command print this information, e.g.

    boot hart   = 0x000000000000001b
    firmware fdt= 0x0000000087e00000

The firmware fdt field will only be printed if it is non-zero.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/lib/Makefile |  1 +
 arch/riscv/lib/bdinfo.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/riscv/lib/bdinfo.c

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 9a05b662fd6..65dc49f6fa5 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -26,6 +26,7 @@ obj-y   += setjmp.o
 obj-$(CONFIG_$(SPL_)SMP) += smp.o
 obj-$(CONFIG_SPL_BUILD)	+= spl.o
 obj-y   += fdt_fixup.o
+obj-$(CONFIG_$(SPL)CMD_BDI) += bdinfo.o
 
 # For building EFI apps
 CFLAGS_NON_EFI := -fstack-protector-strong
diff --git a/arch/riscv/lib/bdinfo.c b/arch/riscv/lib/bdinfo.c
new file mode 100644
index 00000000000..7734e51d670
--- /dev/null
+++ b/arch/riscv/lib/bdinfo.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RISC-V-specific information for the 'bdinfo' command
+ */
+
+#include <init.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void arch_print_bdinfo(void)
+{
+	bdinfo_print_num_l("boot hart", gd->arch.boot_hart);
+
+	if (gd->arch.firmware_fdt_addr)
+		bdinfo_print_num_ll("firmware fdt",
+				    (long long)gd->arch.firmware_fdt_addr);
+}
-- 
2.43.0

