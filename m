Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D35BE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242F98036B;
	Mon,  6 Jan 2025 15:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CmzYJ6R0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0911680646; Mon,  6 Jan 2025 15:33:02 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF0880612
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so56069955ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173977; x=1736778777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6Jf2uxmLAAnIrqW/Nh4f4ufpINkWMmbikRe/+tmdK4=;
 b=CmzYJ6R0b4bk4NR7BdNpU9OBLJbQmYa9htvk9KbfF802JMMH0AKCKftc1fyee1b2ga
 g2+Scvpu4jGDNomtwW1lD4GJX49vgTsJwoLZ1OcWtfZ2rtASli6Mlr9QYMH6bZ8/sHuM
 DGPZMF7O9dGqxVMrhOey75ikCBUaCEP54C1EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173977; x=1736778777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6Jf2uxmLAAnIrqW/Nh4f4ufpINkWMmbikRe/+tmdK4=;
 b=C0iaPEGK6GYYzC78J9Qpzpn/RNpxyVcpIPEiY779sRi+EdAdi18fB2YpRFKPpILw9/
 bREgouQzRYkcRUfHDOiEKc25h+gNrfA4JLyc1sYWR1I5LA0Dk5dvPNvEg+g7zxrNZPi4
 2IQE0t3eQ6rZgBDRoIuxz3sT4Na05a+azha+ufRUDVkihihk6xiEUVwG73Yq6JGSymCC
 5VEmP0QnOvtKHQfBTytTL1qbEXJdw+XQhcIIt9Kks9MEq6ZxBM+1q1OtR89B/ycNXr8X
 MVb5NbqRyrkYhVCnM9Cbu1ednnuMw+8AdiAT97MGXByoz24UemwGWvsiEiGUmj2FJoh1
 8/Qw==
X-Gm-Message-State: AOJu0Ywwu4ojvFX18nZBSqHPy8B8dzfa8jpaGiSKVaqkBanHPW98H2zy
 fUdcgq6evZWfdyNWHMa1wvfdrhVR+3LuOJA6xNGy2FB+0FdRM1m//sNu/57IMlWdv0pFhxdZ9pA
 =
X-Gm-Gg: ASbGncvjST8oZBn9nbWowHdGxhYK+P3UhLZa/ENK+1yKdJagwiNHZHAREx85DDwjOyS
 23ih8EwBjgnabGWB7PR1AGwC/o7V2ZfDENW+AYAPRIkvaugiTbP2dZRrcKU3hngIQs+uV1NLM6j
 t6XMgKbquXcz3zp94TJzFxxj9f9z2PYSsxUpn6AI5ryp/JjouSxpHu5n7NRXPPMJJtFjPwXBayh
 updFNr9CUkfCLv3NBkaEp64jzS1n/V2NBCBLjuuawn6VcP+oTe0h1btLzd5r97pgvAAV9CNqiAs
 zyUE6whGbao+oe5ttQ==
X-Google-Smtp-Source: AGHT+IEniG3lL7GEN+w8H7i+Z2sTCNytBkqccD5YBy+Tmj9E2Yu4mchTaixlxaKyPZZ4RnwCGqvAhA==
X-Received: by 2002:a92:3651:0:b0:3cd:b013:5c12 with SMTP id
 e9e14a558f8ab-3cdb0135de7mr75283105ab.20.1736173977570; 
 Mon, 06 Jan 2025 06:32:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/33] cpu: Provide a way to get the physical-address size
Date: Mon,  6 Jan 2025 07:32:03 -0700
Message-Id: <20250106143229.3023771-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

