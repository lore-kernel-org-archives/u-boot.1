Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AD0C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 15:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F519809A5;
	Sat,  8 Mar 2025 16:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZrUpaaDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A77808A2; Sat,  8 Mar 2025 16:52:33 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897DC808A2
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 16:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5499c5d9691so327503e87.2
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741449123; x=1742053923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hGc9zhpAuMfaBnS2DnF+p2FOneyblEoWm8nkFg5FsM=;
 b=ZrUpaaDT+XKs5N1Lt0/1d25wcwteY36dUAsS+KQnhm1zYgKAuKHmshqyVGnqLL2LcO
 BT8Lr7W/l3zWAO5NXcWl3IhsXHYLuGYLpmCxDEndJH9nMKQ+ICEEoVG6Vn9tSc4HhiAV
 tgU+lGmR4DKXvDkG42uV9hb6/2oEGVW07X89DrBUQukTGeo8tyuQkULYbmMPAhB6yocr
 6aqCRQJJnaV+MI0GMKjb0624Of4d7Mm1xtNKGmLVmsed42mcOUwgIWby9zJv5ivtjzdc
 2N66tGVr3e6xDDh6mvB2Xk5CAIuujHIu6is4Gc3iy0oYX7RWXyyWoOtHzGxD8gxvJ+go
 jEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741449123; x=1742053923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hGc9zhpAuMfaBnS2DnF+p2FOneyblEoWm8nkFg5FsM=;
 b=CmAhk3Ka9Idc7RlfUKrvtx9BnRtWBmv3EkFJq8fZwHakj80kKjNEEgU5ClgkqfY/jx
 nAA3PXzJ9lh3oDfnUIxQ1l59vHb8R/MfOZL5LiJFX9FQOzMKCas3N+u6BqJISe+vp0L1
 bq4psAkmZ7iXC/LqTj2ACsbAXxrbPq2Ww8qC1o0CD0/lT3GU0JsgPKDPpi/ruUslQxVU
 1xnfxVy+iYgoAwhiigiuWyrDwff0ZKfEuixAhq/CtZbpeVd0VkGGFrek6qzkZrXP0DQQ
 q6BZzeqqExGa2mrQ7DkvNrxQQpZtTYdYR9ZTmBS8uqpmCIuWTkqt7kWg0GjCYTDogiXL
 qo3Q==
X-Gm-Message-State: AOJu0YyIRgrSwmrQcQ01nWL1TWdW27xjht/0TbL9k29jvNgq3ydgafsI
 vWcaCL2YIbmk1KF6UvebeOS7ZgXuEHsQOJPSHkd+OixA9hMmSMil1Vnz1A==
X-Gm-Gg: ASbGncuN4qlmtv88tQFf8jgAtYGHoklk0/2mAMDFNJp0K8ozoRMGzvZsz3ACZXbDvxC
 OxoZ3XPT2YbNasuEjnyaJHjarrrBJZHrgjXPNEGzU3E5ZDNCoJ8isW4Xtj/AYBnu/LtaAZuQkQl
 5c2IK9m+x1mhpUTDxhkZtwiVw5CBmd6F+nG1/47tkz5nsg1aLVyX2SjJ8hhA+VyaGC7POS8oJrI
 83fDmPdpWIZXpDPDWJomWXmyGLmXirwb1OIgsW0qV1f6y+SSfVz1ETUMuTQwNvynu2jXJdn2f7d
 QQTy98OTLV+NebUGpyKru/xJHpJsc9tSVoxO
X-Google-Smtp-Source: AGHT+IGqTBX3MLpieqnIPf/Wz2SV0S1eEFHIPUKLSctDuZIpySBuN0YuK7KmjsAJ9epUlMI8HO8g1Q==
X-Received: by 2002:a05:6512:1112:b0:545:1ce0:6407 with SMTP id
 2adb3069b0e04-54990e6767dmr2636245e87.27.1741449122770; 
 Sat, 08 Mar 2025 07:52:02 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498b1c3524sm846908e87.228.2025.03.08.07.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 07:52:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] sandbox: remap memory load addresses
Date: Sat,  8 Mar 2025 17:51:27 +0200
Message-ID: <20250308155127.27893-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308155127.27893-1-clamor95@gmail.com>
References: <20250308155127.27893-1-clamor95@gmail.com>
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

The existing memory layout places the bloblist at 0xb000 and the fdt at
0x100, resulting in a 0xaf00 size constraint for the fdt. This constraint
has been reached. Lets modify the layout by moving the bloblist to 0x100,
device tree to 0x1000 and placing early memory allocation after pre-console
buffer at 0xf4000. This should guarantee sufficient memory allocation for
future expansion.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/sandbox/Kconfig         | 2 +-
 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 6 +++---
 include/configs/sandbox.h    | 2 +-
 test/lib/kconfig.c           | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 4c169034d9a..d61a327f151 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -77,7 +77,7 @@ config SANDBOX_BITS_PER_LONG
 
 config SYS_FDT_LOAD_ADDR
 	hex "Address at which to load devicetree"
-	default 0x100
+	default 0x1000
 	help
 	  With sandbox the devicetree is loaded into the emulated RAM. This sets
 	  the address that is used. There must be enough space at this address
diff --git a/common/Kconfig b/common/Kconfig
index 7685914fa6f..cf4bee063ae 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1070,7 +1070,7 @@ endchoice
 
 config BLOBLIST_ADDR
 	hex "Address of bloblist"
-	default 0xb000 if SANDBOX
+	default 0x100 if SANDBOX
 	depends on BLOBLIST_FIXED
 	help
 	  Sets the address of the bloblist, set up by the first part of U-Boot
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a8b0d7f0395..7e641306da2 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -658,10 +658,10 @@ that are mapped into that memory:
 ========   ========================   ===============================
 Addr       Config                     Usage
 ========   ========================   ===============================
-     100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
-    b000   CONFIG_BLOBLIST_ADDR       Blob list
-   10000   CFG_MALLOC_F_ADDR          Early memory allocation
+     100   CONFIG_BLOBLIST_ADDR       Blob list
+    1000   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
    f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
+   f4000   CFG_MALLOC_F_ADDR          Early memory allocation
   100000   TCG Event log              TCG Event Log
   200000   CONFIG_TRACE_EARLY_ADDR    Early trace buffer (if enabled). Also used
   400000   CONFIG_TEXT_BASE           Load buffer for U-Boot (sandbox_spl only)
diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
index 2372485c84e..db2ac7f83bb 100644
--- a/include/configs/sandbox.h
+++ b/include/configs/sandbox.h
@@ -6,7 +6,7 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#define CFG_MALLOC_F_ADDR		0x0010000
+#define CFG_MALLOC_F_ADDR		0x000f4000
 
 /* Size of our emulated memory */
 #define SB_CONCAT(x, y) x ## y
diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
index a3645abf946..2f47af9acf1 100644
--- a/test/lib/kconfig.c
+++ b/test/lib/kconfig.c
@@ -22,10 +22,10 @@ static int lib_test_is_enabled(struct unit_test_state *uts)
 	ut_asserteq(0, CONFIG_IS_ENABLED(_UNDEFINED));
 
 	if (IS_ENABLED(CONFIG_BLOBLIST)) {
-		ut_asserteq(0xb000, IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-						   CONFIG_BLOBLIST_ADDR));
-		ut_asserteq(0xb000, CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED,
-							  BLOBLIST_ADDR));
+		ut_asserteq(0x100, IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+						  CONFIG_BLOBLIST_ADDR));
+		ut_asserteq(0x100, CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED,
+							 BLOBLIST_ADDR));
 	}
 
 	/*
-- 
2.43.0

