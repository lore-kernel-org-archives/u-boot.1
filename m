Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0449E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB39580352;
	Wed,  1 Jan 2025 23:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QfTxaFBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54EF6800D7; Wed,  1 Jan 2025 23:11:02 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A0C80107
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21619108a6bso136643675ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769457; x=1736374257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zpr+0uOrHfLq3y4YWyKHMAPX03FsEN1Z0UN8bu1LtN8=;
 b=QfTxaFBBo3qkTxFXFWfKkWBbtYOBWxi+W04TUATuZ1yRx6x9/pxm/0PP+psaDBFP+b
 T0jWsDgNFuKok8fGQl+cFcnhUVXJBgmp644cJOEMEcO21Wuj8imfyE/yElzU7ogzC87X
 pH23FfH7oHLHcpcLk+xvTwCZzPPYg7K6ZL+oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769457; x=1736374257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zpr+0uOrHfLq3y4YWyKHMAPX03FsEN1Z0UN8bu1LtN8=;
 b=rD6gSvktErxmkLP1UvXwaG3+GswomL5V8bWTjrdIQecBeu/iBaF7QqtFvubPOfjc6F
 AA0stiDyJium2Yn47lihBn6f5FFtfYrYtn/HF7S5RCKi122wJWOw07/IiVnzCFSKwbSw
 6edb498pLGw42ZgPWwp9vZfSQTudodD3X2zm2ifGLTAVWsqsxSfdSDi9vWvtVshbwxGT
 /4abymCKfRfaCROcWBh1dRkE0OhFyLZdFy+1/VnbzhN/NnHkyvM8do8jiEZQprthiNcX
 lAhADmJ3LHBj6LDitU47XEfrFeOJJSqJwbUOcExu7YU6MbTL3xHUDGBoSi99BquBtWzB
 tboQ==
X-Gm-Message-State: AOJu0YzHpcheE2LXHYrsoCZ/Mu9uNCccL44qtStfis3+GSS16bxDuEQ1
 qDmrvlytlc8uTWQqmQeIKR2R95D1C1ZOLZVLYC9rkTaPlH2hDjO5OS0x9/by9HbL0P95fOL1Tic
 =
X-Gm-Gg: ASbGncsI+DITf+WXVnDlAOC+SSuSJVRaXfg+05eeAwA3KTjRw/hwEvi/YUy603NKk4f
 a3Dd6ieAaATCdkUFifa+V1g5oahZx/SF+U0q/F3GglJU2PgrZQLEN8cabb9nZMRzhfpqLnjwvfD
 OI2vqNVoFywdh7itdTYFl1K5CAWCqWIw3FSvmF83PEsGx4x5JcX2Zvnf9v8i+SLXi+YT+EzgVWy
 u6zwo81YQwIL8TbQWbVwwumgQLMx2d3o7IGKulYiAcDqORcfz3+fRA=
X-Google-Smtp-Source: AGHT+IHtbaxUZOnkng4I3u43Gc62JJT3/YcNFdPvdsFSQXLZXBK9xGvFfLGfsNXAJGK7fIOhy4myiw==
X-Received: by 2002:a05:6a21:3115:b0:1e1:af74:a235 with SMTP id
 adf61e73a8af0-1e5e0499fafmr64014571637.24.1735769456986; 
 Wed, 01 Jan 2025 14:10:56 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:10:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/67] cpu: Provide a way to get the physical-address size
Date: Thu,  2 Jan 2025 11:08:51 +1300
Message-ID: <20250101221003.1944600-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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
2.43.0

