Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDD7FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7850684441;
	Sat, 25 Apr 2026 21:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A5G0Bn0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C051C84459; Sat, 25 Apr 2026 21:18:00 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC5D84150
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8a154cc6a48so99166626d6.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777144677; x=1777749477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=at3TCY3ZpsSYpV6IIwhama1WN9Ehs2t8U8FenpIsdSQ=;
 b=A5G0Bn0Gj/G5lnyKcCDS2WS9XcW0dZN34FWpmZh4WmpBa+xDrtD+btigXWFDPeFmp6
 gEe54R1d06PBAG3UT/WdLgXlndnckwOJ0zX5H9fAwcezFOtqpBnhLQewv40JZ6ybO0kL
 wzJhmKBytkGpjHvRCA/cBnX4ZH6scIn4gVwpKhCISxTp4FfVBoXozF0PQN04JMwKGVJx
 EFn7AeyK6rn3lqamkmaomM8TnLIhv4WugjHI4isPhBfoimqgX8DveepN2HW78ZyHjKSq
 kx8jfR9KJgvSM2MP+GOUPIBAvbk+JU0cdXV7EW3I825YRZFLy4TtPBvzq6RnZViiEh9G
 UJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777144677; x=1777749477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=at3TCY3ZpsSYpV6IIwhama1WN9Ehs2t8U8FenpIsdSQ=;
 b=RrAtFxBO8BdwNb9yPR4JxEwpzQzrdPg3GuRPcFJ3GJ6Tkm2olf0Guc7iHFmNl0txG2
 VSHAEpQ3BLzqahNxI+V/nL/ovbOIG9P+/kWkp1XcZFHiv4WGokJswSSULwGu0vx0kpRC
 zlBDx8mUJWXtIFTAf05vwwWq1OArcTgF7jfjkD6ZhTveMLZA45DPWbWdiO5DPBebP5sb
 fhqFl6yg9jRnC1PcBrGnMiNS4To4weA1L4O6rnslEIkoRtgNTCtHA7cG9Fx37M/jwwe6
 ycYOCqw6IquZw9oF2pXRr3DLzgzSvSTpMGs7V74P2t7rni6PqPt6DR7HKHVWE2D/+pQf
 0ThA==
X-Gm-Message-State: AOJu0YxYYpzg35iUyHbSdJ27QrQBq6sluwbXz0jfmuxZGqJK5Wm+YPSc
 gOdLLaSxLT3zsjZjkcg9o14lxDYbKv084AL1+onC2w3S+5oiuE3hpKrPnohQ7NOTQTLOQA==
X-Gm-Gg: AeBDies61+Lx8wwLhCSpbd0qLTiDO7kiE8z60yH356CjpdYWDG/+O/GQlcTbjrsOYHY
 3KOYf0VeFrQyJxRaKrgshzT+bcVSJntC2WhJhaa2aimweegGrHFVBNPTZINjss/Jo/Crns4uqqN
 T/ferB1WKnGnbSKej+XFGueYIgN8UnHzahQ5vaOurVnhE3L0A+8H+Oxd7NrD6lrdSGsCGSj0jh5
 /BMF1dy2WWKslrabw2j3Jz5WrpwkeLWy3Xbpl5DlP5A0nHqujCIxmtFWoFFQRsm779VOAgMGPNK
 t+rUgHpGwg0w8EyQ8UcO/n5s1X3dQF41dbrduMjTG10QczOXPvb85axnreErG6ms/XShPr7m9Ig
 ttdMk/49qmKc3pSXYMBTH13g2UlDnnTNXMGaUhbp/GddMccUNh3ERVro11ksYZJVUfpYRvM8VE9
 JNbPKpDrwHux/dby19r2WFUfMqJn6m2YIvYXBqKEkOFj19d5Z+0v9ZEOVN
X-Received: by 2002:a17:903:2983:b0:2ae:4cb8:484a with SMTP id
 d9443c01a7336-2b5f9ee2d80mr238413025ad.17.1776918511046; 
 Wed, 22 Apr 2026 21:28:31 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.164])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff3b4sm231563545ad.2.2026.04.22.21.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 21:28:30 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 12:28:24 +0800
Message-Id: <20260423042824.3480-1-briansune@gmail.com>
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

Changes:
 - Implement a temp folder for Python script execution.
 - Clean temp folder automatically despite execution failures.
 - Gate the file replacement process on the successful exit of
   the Python scripts.
 - Execute the replacement (with or without keep) only upon script
   success via the NEW HANDOFF_KEEP=xxx variable.
 - Rename old files to .h.handoff_backup.<timestamp> when the
   keep option is selected.
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

