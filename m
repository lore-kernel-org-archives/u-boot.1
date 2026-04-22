Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69EAF94CD4
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 06:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28128352B;
	Wed, 22 Apr 2026 08:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CTjWscCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A020B83936; Wed, 22 Apr 2026 08:59:19 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD0B801A9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 08:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82faf871346so2539326b3a.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776841156; x=1777445956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IwQkiCjzOtZWKf4ivwxlsBZco2dFj2anJmf3fUxAKno=;
 b=CTjWscCpf2CaihZ8XDOU6xoeLme+nOrK5Z0VIe/hhJiWiyruOGDlSg15Qfaf1SvnmI
 Doe+gPYijVnO8UPuMG7YEJJcoXsraXWkQUbKiXmDp446rK4cFGJL3SCIZPscU6Z/csy/
 9BFv4THgFPx5SnX2+eQt4OTcvh+A/WjH0WgI49lMUAweuS36DIOVtiY5e5gQHlnroa+r
 1QQw7cv76JjS/CGJwUhzFhdlVObLmQkr1G8bPnZC0gqmWF52cPUXFkF4b7VHvAg3MwnB
 3scgVDOO6Vex6Ergrw9qVdxqTUxV3kTr4ujWzx6iwt2eHQHgM6xIYmCniZP7+fGislTL
 fk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776841156; x=1777445956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwQkiCjzOtZWKf4ivwxlsBZco2dFj2anJmf3fUxAKno=;
 b=WZgbCu8A88Td1ntIQDdDtbbP/rI8OdbmAxrXTtR5XLqqsw5DVBnxy+l7tCD0P8Rjip
 5YUVijsAyENt4o0YaZaz1D+ZVpRqcVI6Pl5qIDPMqa7bcqNhzw+NWSiRuxuqngmvnv8F
 OeCN1jcfywV1fx7WksIdGrVcCzmehIpFoOiiKKWU4TLE83+fIyc/SPyz7N5ZEuQKX+qz
 +A0DJ7sxhzYEozn0r3CEeAykOCsXjPBvo2b8GEqMEwSlx6gx9/zUBC456EngSUfMITxO
 b6DaGj8Q02ymcG6CXalhZrhQbZzLf63IX312LT9jU0e6vZarVT4z8J2KEu4FC8bpIHhG
 4t3w==
X-Gm-Message-State: AOJu0Ywvfg+mWw3kXUO4vpUK6reZC+AvO93W86Fn0MDUsyyPvfRlFvsT
 9yeM8J1eBxD/nz8YsjL6584fxpOtkzY4hk6FtSp7ViDlTKboIx7PiD/3NOnhcQP4Y8c=
X-Gm-Gg: AeBDietho/X7IpThGj9aBrhBmd8Ei27ukLCK2TXTzKAK3vMWGN0QfJmPkKBoQhjGSUN
 evXfA/GlOqh71dLFU7oRIsuuWOnbokiDr4SaSy9G27X6S49fzOF4uOQPrF3zieN/f8YcoC2uPm1
 IOhZuQhqXcM2bQOLSJm8GKlLU17G6zLmXFXA5yIgXDQqLLSNJIhO2DffaR4OFWK9NqXMfTpXaV1
 GiaEZVo7HSE2uUxBFS9Kuop3EXl16EKRaan7ekWRf6IMTMeqRSHdSlwX/Jq2V1g6lLW7jJGrQ1G
 oS+1NZP/2qSsQFhN7cSmF5ZlqMPN5Egc1V37qRSfGoHrN8n7EP57LdDrM81rbABLa2HPzchyYbi
 Yzb9jZ4+J6WYNMK/oA/FOSOA2mIiVD+vzL1LUdJ/iaT4nlP0PmDWuyeHo4K/pegZYcZQ9Eh3XRd
 Vwli7h6Hhe7fbdaEzAwdZhUuE+FoWnkDBRYpXGE6O9X1sU3MjYiocBIWY=
X-Received: by 2002:a05:6a00:3c86:b0:82d:1faf:7748 with SMTP id
 d2e1a72fcca58-82f8c8e8bc0mr23550746b3a.33.1776841155567; 
 Tue, 21 Apr 2026 23:59:15 -0700 (PDT)
Received: from intel-VirtualBox.. ([185.213.82.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb3f8asm16608273b3a.36.2026.04.21.23.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 23:59:15 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v5] Improve handoff prepare on SoCFPGA
Date: Wed, 22 Apr 2026 14:59:10 +0800
Message-Id: <20260422065910.5398-1-briansune@gmail.com>
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
- Change HANDOFF_KEEP condition to if [ 2501{HANDOFF_KEEP:-0} != 0 ]
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
 arch/arm/mach-socfpga/config.mk | 38 ++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..e777b95b528 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -1,6 +1,17 @@
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
+# Unset - HANDOFF_KEEP= , Clean header files.
+# Set   - HANDOFF_KEEP=0, Clean header files.
+#         HANDOFF_KEEP=1, Backup header files and rename to ".h.handoff_backup.<timestamp>".
 
 ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
 archprepare: socfpga_g5_handoff_prepare
@@ -43,6 +54,27 @@ socfpga_g5_handoff_prepare:
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

