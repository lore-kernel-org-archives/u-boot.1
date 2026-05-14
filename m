Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBDBCD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 01:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA33780F0E;
	Thu, 14 May 2026 03:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5tR/93D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C2783E81; Thu, 14 May 2026 03:42:52 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FE780F0E
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 03:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c798fc1a28cso3520994a12.3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778722968; x=1779327768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L1gT5HGYS0VlnB1E9eOU3WXaPbvLLvZGdxV/riyXgkI=;
 b=D5tR/93DILMrV3kuDYUV1mR+MswCTRTwIzF4NxSpERLiN7TFVD30UC8/EqceVwOiZW
 uvw1oxaXau3XEG+e6ncznLGDDTp2K4PWVdBR53L7CdFaDU9H8Nnf+Q9x0VlzxW5Lriua
 eETm0BkxhHhCgxZkcGlWWJzQXtnRGUureBE72/hRoPsE0jXa9rtFlqEhhVYJ6P+Kly0x
 SsLzRAwoy1Y4LOoA20CxyMBa0hMe7TZR6f+orLGW31GYuDVKF8HdG+5s145gQUWnv7Z0
 OxjQdwv6N2VF1D6kVhpOMaO007DlaA3Km/w0neWRE7bq+jTunVQMo/yd2f1rIvpZPe54
 t8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778722968; x=1779327768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1gT5HGYS0VlnB1E9eOU3WXaPbvLLvZGdxV/riyXgkI=;
 b=Y1MlybfUMfxM7oQQ5XBxSGB424JOo6otnxr6+YFfBnkOX8+cnhLox7H4k9zFAbxpSn
 VYZ/uBWfSuDwZkZHXngFOEw7gx6AmKfHkQSNoNjkn+YHOY880vb5+qZq5XMbtaYHNNrZ
 xb5/h6C0O6PhSzOD8Kr1pPkZRREmwXQJFJxQPNmoL5WXsqpwFLC/WBvjGyYZm9WELcTg
 exVAbCfiZQaPjssondruNcUylRdCG/LmS8tNNqdRAS/M2JPhR7Q+gXetBBV1R3GPn6/K
 gujcFA9sT+8wjbv5LqMaYTQ/TMAQ5hmrEPkticKxkILVPXVLEayTi7ppgSSROs3cTSUj
 BvQg==
X-Gm-Message-State: AOJu0Yxl2seBxDTwy8otrsgZbjfIlm6Tk23jrHSKc2aGPaZgqeYOM6jh
 uEtga5Tgjj/ya0eh9JA+1z9AGAf1lBNe4VR2o4KedUonBkIwI/X9uhoNqmttfEODSEc=
X-Gm-Gg: Acq92OGGj88XDoX/iLkJ3HJBW/FcucZrAOK2FRy2UZttQf0uu3gkAeJf6O2Mo6HKkes
 nIEIBFogfalsL3ikMOb6IgXNTFL0eeelcodOFbr3c+qTHLbBmyAHopf95oSjPg/yhaDB0jstlkH
 Qx8kFjCAnR9skQAMMfNaWZr4SouNbCxcmpNf9PYDt2SCeIYCFFySP1jhrHqKhKqTSeXn4i8weiL
 04CiE9Cfo5RhTw6Uqpo4HPSABwoPkKLCHhO+SV7TUvMdst8baM/6NNonrangKhtdfaq4dLqIdeu
 tclQ/YyXyxuu+F1NQ/N1D0hZbdgKzBvyQHetEij946iDZM+wOqvHxt1uJfszP/e88NZb5Ioak7U
 qsnDgUjMGWAbnhKM8DiaCm/pRqMHupPFMt2VKUcMZ5TRYGPU7KzK6EvT15sUCcGSCzFKk6cE/4e
 IBmgqrGlsHvnypXlpUfdN0MXnzVpZy0uy0+QmbkjoN5NqwFA==
X-Received: by 2002:a05:6a21:33a0:b0:3a0:babd:b957 with SMTP id
 adf61e73a8af0-3af80e76a1bmr6494354637.28.1778722967902; 
 Wed, 13 May 2026 18:42:47 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.235])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1977b128sm836619b3a.22.2026.05.13.18.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 18:42:46 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Chee Tien Fong <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 14 May 2026 09:42:42 +0800
Message-Id: <20260514014242.21676-1-briansune@gmail.com>
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

Signed-off-by: Brian Sune <briansune@gmail.com>
---
Changes for v6:
 - Clean HANDOFF_KEEP comments.
Changes for v5:
 - Change HANDOFF_KEEP condition to if [ "$${HANDOFF_KEEP:-0}" != "0" ];
 - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
Changes for v4:
 - Move trap 'rm -rf "$$TEMP_DIR"' EXIT; after temp folder create
 - Change HANDOFF_KEEP condition to
   if [ -n "$${HANDOFF_KEEP+x}" ] && [ "$${HANDOFF_KEEP:-1}" != "0" ];
   HANDOFF_KEEP=0 from rename to discard old header files
Changes for v3:
 - Implement a temp folder for Python script execution.
 - Clean temp folder automatically despite execution failures.
 - Gate the file replacement process on the successful exit of
   the Python scripts.
 - Execute the replacement (with or without keep) only upon script
   success via the NEW HANDOFF_KEEP=xxx variable.
 - Rename old files to .h.handoff_backup.<timestamp> when the
   keep option is selected.
Changes for v2:
 - Add handoff Python script execution check
Changes for v1:
 - Implement basic remove and replace header files
 
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

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

