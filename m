Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F5DFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157BE842E7;
	Sat, 25 Apr 2026 19:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBkv6Ftt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24284842FD; Sat, 25 Apr 2026 19:04:11 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294C6842C7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-605a27fa8d5so4814007137.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777136646; x=1777741446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ELYdV0Mi6VZUYZNcFtqYBDmwnAaJY0IsGrrStGFtJhQ=;
 b=IBkv6FttE1MIypkRzXrTNDVusN3AVN+dGyCeiY/WStR1FmKQ4JiJd68dBItGlUB/6j
 tpXtsXKR07+3ynOF9hCNToVbidb+R1tbNtXuuGdD4RNZ4QVKQX8Rq33/HH0QvqOGx+RP
 R6j1TK7tfmQ0sYUyjrFU8jX6QHHr6/v+lu3IM5Mee93LrrTCZC1yE1otQtS6I/toLv7V
 t3bmKfqvxOoFjv9ltouuc8xOLMsJZrmDmEfd870VP0GZiIZEzOXA/N3QwQynP0cP4MX0
 qF6PPwnXOjyUFMDDeqLtGoX9yiZZAuialOJu/WUyAvDvS5Cg2Xb94Q9FtSErYRlvFVY4
 JlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136646; x=1777741446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELYdV0Mi6VZUYZNcFtqYBDmwnAaJY0IsGrrStGFtJhQ=;
 b=TpFamU1ElMqZut26+78t4YYV1MBMRrkuDNoUN/JzUbbKB3sNJ+m9hbb2cl1NEaDeA6
 lCBJw/EgS7UsMHSg18fF4Z+CvWn76keTqb6SdweVSiSejxQjPiTyxa5L1ZzBTRgIUndV
 2ISSkNu7Ju5KMBEBvStAGc4KwNlgi1bbc2ZgPiuPQ1czh0vp5LN+9pddiDeXtEvBbPzu
 2iCFFoR2JHhiFhfDVsTIGvvyiEykueXAzpFh/RVIg6IpGWmMAAZHCTy8ASmoIDgaFjzs
 PcjOgAd9SkyUO6T9spzlDJYmVh/kIBqXReiYhGsS6mLGkSqYI73GVVcu1H2bVWMapBDS
 DUjw==
X-Gm-Message-State: AOJu0YzdBYUP12akKcB8Vu0Z4VBldFzDJoZKlyG4YhuGI6FnyGiG/n12
 j4knyhPY+WTsyTiBkcSe21UcdeqfV9ZNhAK/gecGoHoHGau7gQOjNJw1Hl4z8yB1KNrg9A==
X-Gm-Gg: AeBDietgzPR9LXa37a/9koAJFpFBNMoocMgaBc/HjyTryKEhx/FoUhtd/37s47EDXfe
 jW5Q5vRoPOwvlFmERBXrHHzDU6XoBLQNEBRKS/sCDovfjsJMONdPF86xTIJOsWahl96i19Mfc5B
 z73OMYcpvovQ4qLeuiWGoa+s89iaCPCn0z+8esAiVHwh/URQseOy/9iyodv0524GYMd1o3uG7cq
 6s5LOoqMjBasLY75Ox817t/lPJmxPKCGVshXIqzTsHW2jtmPtv4qNhMho/Ue1Ctt+VY7Ewa3Mzb
 hqdq8EN7+xPdGTaT5wM6PP3bcIlH3KTnKF9rR4xJwZ2YWNEidfC07mQvxw8r7w1SLKRo/aE/WHr
 53thJoNbnueSNflBgtT/TJBln6qJSHWIegUYRnnJ0+Jt01vaihQzxu5gWCMu1GlNVdQE8BcG6Et
 YRL64ypyth1iepnOHxoD6KZOuMUvQQKfOEXkMdqnBBxixc3/9WwZhgI2wH
X-Received: by 2002:a17:903:384c:b0:2b0:7e4d:f390 with SMTP id
 d9443c01a7336-2b5f9fb1b9cmr247651455ad.41.1776917062047; 
 Wed, 22 Apr 2026 21:04:22 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.164])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b60003ffd7sm163641365ad.80.2026.04.22.21.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 21:04:21 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 12:04:11 +0800
Message-Id: <20260423040411.3257-1-briansune@gmail.com>
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

