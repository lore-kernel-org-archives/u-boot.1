Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97998FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D232584324;
	Sat, 25 Apr 2026 20:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W7a8dFJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8315884401; Sat, 25 Apr 2026 20:13:01 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E46842FC
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-9568bae58f7so4460752241.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777140778; x=1777745578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wBFNCyQF1/ZQAKnYTf+xmEqUnMrUmNb6GuodGV0JMqw=;
 b=W7a8dFJj3pi7oXdx+dl565JV+8Ia8J0+OTZM29UOLDFhFZTA2ms7R9OICfS8OA2W32
 +sX54l3NoYBvkl2MnNAh4GCIpATLxGjt+rJWKR5rU9gBOyo32ANvtN38P9ocZx3Rh6uI
 FFQ8DImlK40tyA2lui1X9KO7o9zYfaAzJaSlzKIXzAoU5stW9AvLKlaAOztUUP4eOzCj
 3UTOl0bEtifZDH6tw8EPXF42FUHDyN+c9FaGXNlCTs1OzL5LOeISjQ99He0UjAk+qdH4
 E3twn/Bfmd2lA2C8moF6i/rNPcxw4kg1uDuzXSUtcoq1gi+1qNsfYjh4Of8drG8S90qw
 CRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140778; x=1777745578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBFNCyQF1/ZQAKnYTf+xmEqUnMrUmNb6GuodGV0JMqw=;
 b=nuM/hZezbnK0RhbpLvq9hrRdT4Rw2w0czhEhuBzrSZSBzShsJHGql0QPdQy6AyoJ3Z
 m+twv6vTsiNk2Mex1c+BLPbvo9eB2uDevBDJ44H2uPjwd4UyZFCqQIDlGcEVLoeXz0qv
 19nbtiry4ef40fIZhPuEO7atdx7YnDhBeaUGCEUA3q/Ufhx1qNhcj0WN0DjCvNyhzmR7
 P8nM0PvqTjOHcVgzNES2BtEk/5MPWNtzqqEsRHsxdhob3RAVbQz58YHAdAtsKj5fWW9o
 uBGwdmi6g/OUBbna5tF7yb/8wp7OL3ywmtwbuiuYRCX8HErHI0TrJp5JXxtu1/cNHsJU
 z/3Q==
X-Gm-Message-State: AOJu0YyJlkAkh/PA1D9GYxasvD55lESgusQYplL/b2xH0Z1ZZxAhR5Ut
 AvhP/3dMSih1SFArXM35kbStpW5crVx/6VRiFEsvTn+rSN35X8d87i4TQFpkHPs8maF9DA==
X-Gm-Gg: AeBDiesXn6u08tzB20iKNblXWo7PXwf7VcTls013yYedj83uHIrhBBWQx051lLB/yqD
 8UFEPk7SxXPSP0HAryseqxcVPeYbM6Mrn9yhpVToHL9U8XJn8S49oplAhZ2l/0jDLMzkgpYny5f
 XjOQRgwbCXsiDQd1WLKjJkHIh7FM5+P2vuwu9XgPr+fgsL8MDyS44yUS5f1ApfFNHwU40BTlCe/
 8ECXqOUTFrQaNwFQrnKeJROxqzh9zVzZcmt9ipFYV/NbLK8FpQ/cXrNdrsqo+xHumiqtUWtXv0O
 uLIJGn44LYJYi2vu1AtaURdYWsMqTSfAkCGLf2/vT0MaJuQ5vTR51TpYoHaTz6hqmAkOSPHw7zK
 FAJhVwin2Gpm8zfdmmCoZpOQ/uFF3qbQ3wtFmLQ4k9Z0gWd2agtt6n/D0mIOfku2WgtJZxVPMfC
 hTVdOKOCQ3UNsSLNbh5V6WEbqg6m2lYc6G23uM7paV3UjqF1vTkkgyrV0j
X-Received: by 2002:a17:903:286:b0:2b2:680c:2193 with SMTP id
 d9443c01a7336-2b5f9f64affmr269266985ad.31.1776913920542; 
 Wed, 22 Apr 2026 20:12:00 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.152])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3bd2bsm189529935ad.74.2026.04.22.20.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 20:12:00 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 11:11:55 +0800
Message-Id: <20260423031155.14747-1-briansune@gmail.com>
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
 - Change HANDOFF_KEEP condition to if [ "{HANDOFF_KEEP:-0}" != "0" ]
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

