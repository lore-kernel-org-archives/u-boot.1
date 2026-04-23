Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8542FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 21:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E27684307;
	Sat, 25 Apr 2026 23:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDWwWDFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CACD84314; Sat, 25 Apr 2026 23:25:17 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C4E68420C
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 23:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50e5b55062fso61681251cf.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777152314; x=1777757114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HDFe3kAhb4usAWl+M1IChfZNghrVPdVvrzlsqI6HTXA=;
 b=KDWwWDFTWZi0M/fd8/m7Ppagwe8OsgjXP2UNGtIkVAX1idYnTV1XkrNDIQ5hblhks7
 DTeH0SZrEWK1jyafC509HJlcx7JRrToZc8yGWoTFfZdNIpMO+ZEZZPYj9BSOBynMvCiA
 knbCypi/1tkIS9T3XKM9x8W9OoXWUBP9lPUWvZXfJE2akqWPQFHZMC5xqLrFEHh5rDb4
 c4llgsmB8rKW1z/w47Djvvfb3+lgbR+MZO5Td8sJQc5gTO6A+pXx4kLhNgy5uXvY4rG0
 L08faUWb9W4HSAqWxLDHA3GT3D2cUh+cudHDApCSuJYdoOIAB4O/qd3nJYZX3nJ4nJyD
 +isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777152314; x=1777757114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDFe3kAhb4usAWl+M1IChfZNghrVPdVvrzlsqI6HTXA=;
 b=d/dJzjP1CUKjovrew4L55XVNEIg7ifAlJJqYiH8BnjzvHnra5f/8B/Cxy72ccyLAlI
 rMUXQJByWP5PuOi670TNi5w5kwvoNg8gfMLcm7mnmwQjv2zp4SmmUmG1F2hqC90Vbqb7
 yRHOC6NNQRd5GAH9fLWnd2In/rZo31ERxDkoHKCxnAKRn5IKPwJVdPhkFU3zdzh5o8tl
 QaUsuupqbmbTIw4s3Sh1iMtembV/q9W7sa2OA03jL5iyZP6ko/Qu6cmSwXzEFF1S6ifZ
 bBop9Nr+yChSXdcClxqXqPid4nTSPEGv42fPt9SeexkkP25OFTPAyA4dfpq3duSSIagF
 LX1g==
X-Gm-Message-State: AOJu0Yz1HQXtWiUufBxwre0hBlxUUklCWExwM884NELwD0WVhza/4mnz
 6tgyGn9JuFlbOOZ/FGy7n+2MVkyvkBEJLDTxvQdS5NtZYdM8nkDsjd2On7zTkRtjM82A4w==
X-Gm-Gg: AeBDiesQtQyjy8QlPdGAMuM/ubOHG8o9rQx8kvYqZo66xfp0js+fDCo7QRRbIHjPSEm
 iTEENgvOHpQfgCdWZ5QPeThFk59pHc1r0QXPkG1MEzoypWRMosArjB4g/xD2KlS6bjyx6ugXEhC
 1TqTq5fH+g7c+2KUggN08Uc6GSdZwwPjZIR490mDv+RGrO1xNy9BpQRUpq6nuqz7PE4h34u4nho
 Sz06B9F2VlOFdeyK7zAjiJjGnTakVR3D3Kl/hmgtmXx7101YovM3H9Vd0XzHJdVh5iE1M+4UtKx
 +eT16O7UoEV/KBuI6/IM1Zi8gYgpuTCOakgfxnFTMMFR2suaxzbpshl/0tOhQvKAAI8iwIL/j7R
 H1MJ0A6tIu8qpJ6tM7uKYevWI8yNwuycWd3KsZqBzXVQs9HZ5s2y2IeRlkhVgdoTpfVVj48apVP
 4GwssI7fLCKtnxioZyF28BmeVPX0lA+QiKqc/0VsCc1tgHVnuWkxHSn+10
X-Received: by 2002:a05:6a20:7495:b0:398:9ae9:710f with SMTP id
 adf61e73a8af0-3a08d6eec72mr27596163637.13.1776915059706; 
 Wed, 22 Apr 2026 20:30:59 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.164])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981c07sm22620309b3a.1.2026.04.22.20.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 20:30:59 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 11:30:42 +0800
Message-Id: <20260423033042.14912-1-briansune@gmail.com>
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

Changelog v4 -> v5:
 - Change HANDOFF_KEEP condition to if [ "$${HANDOFF_KEEP:-0}" != "0" ]
 - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk

Changes:
 - Implement a temp folder for Python script execution.
 - Clean temp folder automatically despite execution failures.
 - Gate the file replacement process on the successful exit of
   the Python scripts.
 - Execute the replacement (with or without keep) only upon script
   success via the NEW HANDOFF_KEEP=xxx variable.
 - Rename old files to .h.handoff_backup.<timestamp> when the
   keep option is selected.

Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Signed-off-by: Brian Sune <briansune@gmail.com>
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

