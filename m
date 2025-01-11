Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6ECE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8464C80690;
	Sat, 11 Jan 2025 01:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IpKZh4hP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C5D80658; Sat, 11 Jan 2025 01:00:59 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11968806DB
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso196150839f.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553655; x=1737158455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6Jf2uxmLAAnIrqW/Nh4f4ufpINkWMmbikRe/+tmdK4=;
 b=IpKZh4hPIggKc41TXU6C4ysZNZE3wzj05BI6K4r63ZbJ81vW+1CzecwwkR4FkCjB41
 yXa5xZcsYagm3urNq4J95zyNY4cBlgx+G6mtYQ0t0PWSZf8Vs6P2OgcImhS79sFDOVLJ
 MxwtzKzxW69mZZL2OPXmTPvJQy+xzs3yYJ5n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553655; x=1737158455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6Jf2uxmLAAnIrqW/Nh4f4ufpINkWMmbikRe/+tmdK4=;
 b=gr3OeurWUK1DHb9hGl0ylV47EDrDLl979AWOXHnHl7BF3kryf2cEDRcNhaP2D0dhBn
 ZOulDa39uPg6rKAii+imOxieIuKbU0szgDOPUDPDZtKoU8ctRwcwIsjTJDb+6qNcOX+r
 s8hIaQ7BrLiOev14pGP5+CrnDEYYj+tpsNxk/X1h1sVGnAl8vtaO3WOX2NaYQIbZd5Zw
 vI7EzMt6IRpJqlIBiv754JOSzNW3+0zrj0SRPcgGl0yupDUig8YXAtQBX4CjSknllEJT
 5oJOvWE6wDxCnInHKY+QeiVPtnBT8LFBcoGfuwN+YNnL0DUWvxgw/Bk3X2V4eWuS6vFs
 y3lw==
X-Gm-Message-State: AOJu0YxlxilQgWuavRD2DzgM4QC0tx642Kf38SFqHOCzLb7Y0JPjb5cu
 V59eq4uy7XTV8iYAM6O4dadFifuzJn0itTKT/+b0hlbA3NNUE2Ry3SqZnhISR73hWrtCrsjwSPA
 =
X-Gm-Gg: ASbGnct2JlQiFgPPeb7Vrdme5Za5lbleI+ZVqoJyzxPD9z0/gBOmP1OuAhs2UXIYs5V
 L+imYJq1W+RkB0FLVRgS+OrAMBSqEf2lnLhBHBkmYFrM44asDDWKKKPkQsNBgZ4QYdSkXKApuXk
 YumC7EbnnQWSNXYCasbRdlDrpsTMvAmIHRw4LWsQm+4z81Eni0jhDATyBEy3lLb7VufLxkbU++T
 DPMzjjJJHhIBP43jnHLqK+o0GNS7sdYi7TWNmttaiMe3IrM697T8+PsQ0aqV2tM7lvVQXHCzJ+I
 nyF3mGre7R6EOA7fdA==
X-Google-Smtp-Source: AGHT+IHnHmXagwMo1sKKu60hlueBDfGW+Wccwed8EmLAruA1ymw9rncj4twKU3sQGS073hrIL1mwqQ==
X-Received: by 2002:a05:6e02:1945:b0:3a7:e800:7d37 with SMTP id
 e9e14a558f8ab-3ce3a878177mr88572085ab.10.1736553655230; 
 Fri, 10 Jan 2025 16:00:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/30] cpu: Provide a way to get the physical-address size
Date: Fri, 10 Jan 2025 17:00:04 -0700
Message-Id: <20250111000029.245022-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

This concept exists on x86. Declare it as a generic function so that the
value can be accessed by UPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/cpu.h |  9 ---------
 arch/x86/lib/bdinfo.c      |  1 +
 include/cpu.h              | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 8c1ef4c8cc1..fd389d4024c 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -284,15 +284,6 @@ u32 cpu_get_family_model(void);
  */
 u32 cpu_get_stepping(void);
 
-/**
- * cpu_phys_address_size() - Get the physical address size in bits
- *
- * This is 32 for older CPUs but newer ones may support 36.
- *
- * Return: address size (typically 32 or 36)
- */
-int cpu_phys_address_size(void);
-
 void board_final_init(void);
 void board_final_cleanup(void);
 
diff --git a/arch/x86/lib/bdinfo.c b/arch/x86/lib/bdinfo.c
index 2a78f578dee..bd2cf0b9fcb 100644
--- a/arch/x86/lib/bdinfo.c
+++ b/arch/x86/lib/bdinfo.c
@@ -5,6 +5,7 @@
  * Copyright 2021 Google LLC
  */
 
+#include <cpu.h>
 #include <efi.h>
 #include <init.h>
 #include <asm/cpu.h>
diff --git a/include/cpu.h b/include/cpu.h
index 0018910d61f..d0cd104c05a 100644
--- a/include/cpu.h
+++ b/include/cpu.h
@@ -179,4 +179,18 @@ struct udevice *cpu_get_current_dev(void);
  * @return 0 if OK, -ve on error
  */
 int cpu_release_core(const struct udevice *dev, phys_addr_t addr);
+
+/**
+ * cpu_phys_address_size() - Get the physical-address size for the CPU
+ *
+ * x86 CPUs have a setting which indicates how many bits of address space are
+ * available on the CPU. This is 32 for older CPUs but newer ones may support 36
+ * or more.
+ *
+ * For non-x86 CPUs the result may simply be 32 for 32-bit CPUS or 64 for 64-bit
+ *
+ * Return: address size (typically 32 or 36)
+ */
+int cpu_phys_address_size(void);
+
 #endif
-- 
2.34.1

