Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E74C61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B9387479;
	Wed, 22 Nov 2023 14:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H4NRbSbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64D9875F2; Wed, 22 Nov 2023 14:12:04 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82846875CB
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db029574f13so6582555276.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658719; x=1701263519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k1ABau3ytv5IlzWnSTidL79BKOABx2FP1+W0cvwMdzU=;
 b=H4NRbSbfVhzBInOXPOXVu3PgCXo9yr3PkK77XfBjNmGQpGKO+O7arX1lIHmZl97v1S
 UsK2a6E/v/kXqGo+kC/xIRpqxRhyxFO3SoPTLLgis5MBHmEYgASoGkTYHKsD0H6HUBOq
 px3ockjKrWbeMubTgwianlpl+WPu+fW7NKbWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658719; x=1701263519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1ABau3ytv5IlzWnSTidL79BKOABx2FP1+W0cvwMdzU=;
 b=Zdwg3rPqJI1e05d8rxWbIb3G4/Bj4hdUhWYDEHb22/0WK7wr6HK0VjO9vOiYEEpoWG
 895R4Oe5aU0l/1g+RgExpn1oPY87OFOT6oEV8gxn5eGp2XPfHAcFwl5bkQ4TOqRpIX+H
 36AE+zuWwv9FXPVhiXn3sssNPHsKhudPrQpgYtisXABxHdJkiKLiJ90Wxq7NQDtcdVFA
 jh3JW9ngJ4isF14Y/qtrTVc1YaTsXQGsi7Ik7pPzNmP/0bgaALvmiIikmIaFmoNMi1Qm
 PnkmVBhioURwyYSLENZJYVe9KGUIKMd0cCIYvDGP0rF0bIaIDuSgoQqTDjeq0ovpjy98
 aPdQ==
X-Gm-Message-State: AOJu0YxID+GAjNZmcM2l3tbs6D+vGfjdrouXQwdPYX/5Wmi5Hz1aw5Yd
 N+cMkfKH1sKQKhyTfyK0gGd+5sROCpp0w5m+N1vDXA==
X-Google-Smtp-Source: AGHT+IEN4/a6O40ab4YlThst2rtHb1ULMSxvz6FbabTwOh5xIivFlzJj5AerDB4uVOzJb8xukFR3cA==
X-Received: by 2002:a25:bfd1:0:b0:d9a:4cc2:1961 with SMTP id
 q17-20020a25bfd1000000b00d9a4cc21961mr2190875ybm.26.1700658719563; 
 Wed, 22 Nov 2023 05:11:59 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.11.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:11:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 05/11] global: Rework architecture global_data.h to include
 <linux/types.h>
Date: Wed, 22 Nov 2023 08:11:48 -0500
Message-Id: <20231122131154.2444690-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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

In most cases, the architecture global data currently makes use of
assorted linux types, but does not include <linux/types.h> to provide
them. Add <linux/types.h> instead of relying on indirect inclusion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/mips/include/asm/global_data.h    | 2 +-
 arch/nios2/include/asm/global_data.h   | 2 ++
 arch/powerpc/include/asm/global_data.h | 3 +--
 arch/riscv/include/asm/global_data.h   | 1 +
 arch/x86/include/asm/global_data.h     | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/global_data.h b/arch/mips/include/asm/global_data.h
index f0d3b07bf1eb..34b7e0bed945 100644
--- a/arch/mips/include/asm/global_data.h
+++ b/arch/mips/include/asm/global_data.h
@@ -7,8 +7,8 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <linux/types.h>
 #include <asm/regdef.h>
-#include <asm/types.h>
 
 struct octeon_eeprom_mac_addr {
 	u8 mac_addr_base[6];
diff --git a/arch/nios2/include/asm/global_data.h b/arch/nios2/include/asm/global_data.h
index 1a0e7d25fa3b..b56e8a5078e0 100644
--- a/arch/nios2/include/asm/global_data.h
+++ b/arch/nios2/include/asm/global_data.h
@@ -6,6 +6,8 @@
 #ifndef	__ASM_NIOS2_GLOBALDATA_H_
 #define __ASM_NIOS2_GLOBALDATA_H_
 
+#include <linux/types.h>
+
 /* Architecture-specific global data */
 struct arch_global_data {
 	u32 dcache_line_size;
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 6ed21c781fe4..f7860122a00b 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -8,8 +8,7 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
-#include <config.h>
-#include "asm/types.h"
+#include <linux/types.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 937fa4d15446..d00247ad9536 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -10,6 +10,7 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <linux/types.h>
 #include <asm/smp.h>
 #include <asm/u-boot.h>
 #include <compiler.h>
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 6f4a7130f1da..1ef7f1f0349e 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -9,6 +9,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
 #include <asm/processor.h>
 #include <asm/mrccache.h>
 
-- 
2.34.1

