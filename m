Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82552FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230958439F;
	Sat, 25 Apr 2026 20:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pl1cMKWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8395F843B6; Sat, 25 Apr 2026 20:10:29 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F7984324
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8a093c784b0so103311516d6.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777140626; x=1777745426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wsg0/KzVSgomn6XJvYIQUigIlc4yvMGN9MnT5s/EMP0=;
 b=pl1cMKWcC+VNElE2qR6c8zDQGcVL3VK7Z9fRI5puVb+zABhhjoq8F6P+VWtyk1qj8U
 RzE3i/jTne1S88tW4SXSeuoJHKzBQ/CUUo6NCR1qw0Wv4AK9lcHu9uY5JI+7Sbn4H6Nh
 32/S2JTGqzXQjmFvZWhnVQ6Gwpy+2y34m+1LAQx88+2ivKk4OiCSob57cQkuXF99ZqwH
 dwEgHQguiyQq1p8hUCKRPa6y3TQhZmi/v2VJ8/qiGglMcKZwe6za8g+24JZE6lmi5zte
 kS637+1S4O/kyDsG5dYLctVamD4usQCAEjMP0WCITABeKEWTeFju1CHe/AFZYF0D19C2
 n9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140626; x=1777745426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wsg0/KzVSgomn6XJvYIQUigIlc4yvMGN9MnT5s/EMP0=;
 b=bma2u3HAVxDzA1XdZnNNuvCW37qGGPWXkolxcNIPKyQbAap6PYFgh+ilJqIk46aaYq
 t1NyjnqjhhezN4ScQ+BRy409nLYvUff374GoPPSiyxz1jyr00yuRFYNZNKqVOhZfJKqz
 2lO6qz0x6B57xbz2mTqpDg7T88uEfHvCEM/wxbI4jlLACPsmM2y+qf1732swSkyU+2ON
 S2fLfojvNeeuJL5eJbu/ygpWNp5xUEh6n9V1Xcb7VYEgpOUjVWPxVd5i80GTOX83Y6pA
 auxh+23MiJBuwYo/Q1gfFFSqwjkUvmVrBNdztM/f3zp3vEYhk8fFc7iumH8/PqyzEyQD
 MnZA==
X-Gm-Message-State: AOJu0Yz5RNmf3PCh1k75NZGPS/X3Px0+gYWs+0RuLjtNLgD7xLRye+Pt
 CKLROgM2YvfOVNnzJBC8Npo7hfuJey1KjOr9Emu2U2TtvD9A6sM/e5TcIH8kroPBM1IMgg==
X-Gm-Gg: AeBDieumXXJhhUBINaWjjwFLzZHCCHWBJ5fEgfV/A7e3yKu0o9cNFHCDYxQv7v4KUZC
 svuH9bXA3EDjDo2VfsbxNFlOE4sM7tvq4aehzb/EfjSYcBac9PT1MYm+oxWc5ItEpUKQ6bz8SPE
 i70YfDoXq2pQqiO6sbBe1YkYkrqtP7K0Py1J2n9spApXewaRTcOiTJ44NtaFzQh3+i7dWC7OsNx
 wcYQSfpqcT0Sv4ZzEg4Ef1AdN+zSMYLW6j+izonobMGjMaiYwB00NNTP/2PyOFLmImlkVGfTUAo
 IH8emZzKE8pd61OwYEFLFb06LAKRu/SxAK+wMBYd5LqnSW3WNRunYukWw6pbKf0sb7HjYOJyw+R
 CNtvEGq2EOIs7B7syBeyHoUoxJpSOtLw5yaagdbPfSruSpemZHJqy1LBgmRS5eTIN/NS/FLKYms
 ejur3Mp6K3WSBWDlTsoRwhDoX85+6ADgPa3XYgnVEU664lNAeGVVXyllJxublqlOik//A=
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id
 d9443c01a7336-2b5f9f3aa58mr246311555ad.30.1776915356269; 
 Wed, 22 Apr 2026 20:35:56 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.164])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa1763dsm164544315ad.23.2026.04.22.20.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 20:35:56 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 11:35:51 +0800
Message-Id: <20260423033551.15109-1-briansune@gmail.com>
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

