Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08790FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD4484445;
	Sat, 25 Apr 2026 20:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mL7teGkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0400844DE; Sat, 25 Apr 2026 20:39:31 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C20CC843D6
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-506251815a3so76500961cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777142368; x=1777747168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mXTLj7Nwccn5Nm3ZOf8CpHxy20coVs43D5vapuUGqCw=;
 b=mL7teGkjgCIiwmHOoQ30bcmNgigujXMg1YPBAp+38DyQCd2JnYA0+WrWQAZRPjL9S+
 zV2jhVQ1OxdFYWW/tu+UQJu6TRaSEQwuKcjpyDW7Lwerhz4q9M9j4o+yoKoCFo4HPNSo
 W56yk5POFHVqY8gJbfZVz5QHEnyJZSvC6nwzgT9EXKNDfFa0Wub+hoRKq9o8hc/PMUrJ
 gr5FUVFkoO1bN8pc8MiPUVdepIBorWVc56DRiefXtCo0+R6ppcFqxQS+Qt91y2Au+n6d
 DFHW17IWn0tTpu4khISOw2FoNcQ1zFrgbKHaMYbZXv+FXGJ18qXuk6gPhO0UykJsZigh
 NAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777142368; x=1777747168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXTLj7Nwccn5Nm3ZOf8CpHxy20coVs43D5vapuUGqCw=;
 b=alniZErO0Zt+ngw+L0YeaSdjzqB7wGp91IMgxJNzA9Bv6ccS93sX8hTmM3Mlnzucq7
 DzBvSHcweAMyG+Vh+BFAOtRHbWuTP9B5gLJUb5VmA/Ze85GCuk5GPLvoUrCzLE0HbPe7
 Rs7f6eYN6z5QwuAoboMnhiW0QKV1sqUTREwGY9YeLLqRtmHG48QcBPeK1CF4+5Ib6xzJ
 tWGVhdsmqpOIcW0yqyOFU9UdPniVK7ULwl4BANSzJtigx+BXkOotMOD+Vjbijoqc/sxu
 BjDqSks9D6+xAyRoP3RGvkAXe0m0x0JMGN6873byvj3HSA5pTgPTyfv/GHsWtmBcoiFp
 y4sw==
X-Gm-Message-State: AOJu0YxR8ZsrVfi35faDdu6KRIFnWkFdYKkMr3VhbQfJ1IyqaDHbaqFf
 /IMfcFUiaGTd2TNg7N1TyYs0JvJlQwF3Z6fTe7yUnWKlL7QsUbYIRYpTeYeR/LuJt7scAQ==
X-Gm-Gg: AeBDieto+8vsIcM618JHzwh+dhgw/ZvoC5wq442OJizr0rhEVx6ZXhQ89S3MgS51jfR
 9KTs3zXBGYeKD1BWYn+fXbWKgP2yoN2Q262oZw1HaF/gZ9SHG6hTByzZemegjenLSRKSVaYdoaL
 pyy1cHC1Uiq4jx6z7ng/imamklON3ryLBKF3dqkBVxclbO2kfaZJnB2Lki7XZq/3N2laYSAvQXF
 ZFcmGSQiF67+pd1mch9/y52P0IUtfU/in94ZZnnOmMraFYnGW6TMB4vffH7wqSoGqmpfzlFhDHk
 mwtkxQy1ENbA5cdY8zXexTDQt1DVOuS2I8H5D9pctR06DM2cHOPsNopEIWjVOR+00PsnI8cchR1
 N5fE+CjtLyzRSGx9SLPpMNxJHl7rlfNXlU5+9CRAbmtuziwukw2xkXwZoHWUbp61o9lKeL8keeg
 scdwaXDmYyeXI9o1UnsT+kayuZ61A2facUaBTfay+2I+STxI0AL7Z/eoZ7
X-Received: by 2002:a17:90b:3c0f:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-3614048b2f5mr24667968a91.17.1776916096909; 
 Wed, 22 Apr 2026 20:48:16 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.164])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7cb5sm18670787a91.9.2026.04.22.20.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 20:48:16 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 11:48:04 +0800
Message-Id: <20260423034804.2778-1-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Ensure qts folder header files are properly updated by isolating
the Python execution environment. This prevents partial or failed
script runs from corrupting the target directory.

Changelog v5 -> v6:
 - Clean HANDOFF_KEEP comments.

Changelog v4 -> v5:
 - Change HANDOFF_KEEP condition to if [ "$${HANDOFF_KEEP:-0}" != "0" ]
 - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk

Changes: - Implement a temp folder for Python script execution.
 - Clean temp folder automatically despite execution failures.
 - Gate the file replacement process on the successful exit of
   the Python scripts.
 - Execute the replacement (with or without keep) only upon script
   success via the NEW HANDOFF_KEEP=xxx variable.
 - Rename old files to .h.handoff_backup.<timestamp> when the
   keep option is selected.
Signed-off-by: Brian Sune <briansune@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/config.mk | 39 ++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..f341aaaea56 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -1,6 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Brian Sune <briansune@gmail.com>
+#
+# HANDOFF_PATH
+# ------------
+# Unset - Board path where qts locates and "hps_isw_handoff" should be placed.
+# Set   - Custom path points to "hps_isw_handoff" folder.
+#
+# HANDOFF_KEEP
+# ------------
+# Unset	- Clean header files.
+# Set	- HANDOFF_KEEP= , Clean header files.
+#	  HANDOFF_KEEP=0, Clean header files.
+#	  HANDOFF_KEEP=1, Backup header files and rename to ".h.handoff_backup.<timestamp>".
 
 ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
 archprepare: socfpga_g5_handoff_prepare
@@ -43,6 +55,27 @@ socfpga_g5_handoff_prepare:
 			exit 0; \
 		fi; \
 		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
-		echo "[INFO] Running BSP generator..."; \
-		python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
-		echo "[DONE] SoCFPGA QTS handoff conversion complete."
+		echo "[INFO] Try BSP generator..."; \
+		TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \
+		trap 'rm -rf "$$TEMP_DIR"' EXIT; \
+		if python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$TEMP_DIR"; then \
+			if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
+				echo "[INFO] Preserving old BSP files..."; \
+				TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
+				for f in "$$BOARD_DIR"/qts/*.h; do \
+					[ -e "$$f" ] || continue; \
+					echo "[INFO] $$f -> $${f%.h}.h.handoff_backup.$$TIMESTAMP"; \
+					mv "$$f" "$${f%.h}.h.handoff_backup.$$TIMESTAMP"; \
+				done; \
+			else \
+				echo "[INFO] Clean old BSP files..."; \
+				if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
+					rm "$$BOARD_DIR/qts"/*.h; \
+					echo "[INFO] Removed old BSP files..."; \
+				fi; \
+			fi; \
+			mv "$$TEMP_DIR"/*.h "$$BOARD_DIR"/qts; \
+			echo "[INFO] SoCFPGA QTS handoff conversion complete."; \
+		else \
+			echo "[WARN] BSP generator failed!"; \
+		fi;
-- 
2.34.1

