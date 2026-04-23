Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AF7FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB258419E;
	Sat, 25 Apr 2026 22:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MUf9YK/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D989384178; Sat, 25 Apr 2026 22:14:25 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A585284178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-50e5c7eb565so73673291cf.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777148062; x=1777752862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ELYdV0Mi6VZUYZNcFtqYBDmwnAaJY0IsGrrStGFtJhQ=;
 b=MUf9YK/4jXpuy9+9oR056xy4PFcCn9fV66pFBdV28+BZGHWFtETqWLDDD3JUUP2t4Q
 O0SRwQAHpNFRhLB5YwGscqfuPoCsG9TrOByv4x8cdn1XGFLv4pRwM5dicuflQMxbbs9v
 IehRG5qIC1xtOuee0j+uN23pUYof8sJM2904W6A2fH66k0vtcoJJSxKdIF4B/UXVvs2+
 Oq+TlhY93CQjLExcFgqMDp/Fx91b+Wk/4GZu5W+A243UEIXTqbgaXFuOVB0YaHR4LKPC
 NZL6lLaCSN8pDRcQnDkgDJPM/BETL4Ll4vKBZAV7XUePkx3vxU6FJESWc7Shs+nV885A
 Yo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777148062; x=1777752862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELYdV0Mi6VZUYZNcFtqYBDmwnAaJY0IsGrrStGFtJhQ=;
 b=LrCGGUPZsaoC9X0jbdL91YU9FiUk8bLntR8lwCfHA2aiIvEtZhhWblA2uihrNs0afi
 7Tj6ItST+jtPPZGMaC45JZOhRElbRMxMX8dl3/EC7C4Gy2equS0iF+5c6lCPBk78EAAz
 Ja8/SZlWySYvkfswurIT/EOJKEow2ecENMG54sDC1LTSDzSSd9EDmT+bAk2IlScNeSmR
 C5dAGhxgXe4IOwVy/UQJJOR4kQM2GDWoqOAyhi5mFqzg2YE9237d5BksLc+/meK4NXBK
 QNjLa7hkQBWcC+tF01SgVdQ0z67C7zxkjasyQL/Cr0DkPq5IEIqHYUhOgFIQiyIUi9a+
 s8/g==
X-Gm-Message-State: AOJu0Yyo7TcuK84oIqjdT5VbdNNC3rkXREGKucMTzAnN3dhbSwxyQDb0
 82jJ4ylsltEkuzURouI24MfTWU74OIiaAzyZ3Dms7u6OYEESJbBbgU+gPsppK5h0fYZk0A==
X-Gm-Gg: AeBDieuDdmRamGz/kT39hRflQz67FR/IYJHKreruuBpGXL8jmJeMd1NYD2t+PKx2MIy
 vWCfgKETM9rtYjWngBG1AHJvbPaNGmoOMLaYfOCfpGNYaNlJEAozdDvkgxsl1SZAGPCbCZi/8dE
 6nYp1lwCUgaUJE/m91j1frbuaQ0F1QmfTpou5u48EWAjgaZ7j5uYV63oxZkPAoDM0K2qK37WuIO
 dfk0onWrBjFlylmyoZP7RnjdL7DiGhh4wOeJJiPSTU7/HkGKGslEFNEm2Kun7ZB37kVOhKJNnaS
 KvrXBpvpA/Mi3Avq+5O9jlM8FLznofH4TVH1UJ6k5qNURfNwhDxdBuc/1A83VeDdi3MeCGfRtlO
 cqDq5XC7H2SceubLKzmLRPY/CG4ZjdY20XKJRqXuETIjXXGe2X/s5A/9B9HDMtRJ3Dhb36MGhLY
 rEfl42BKlVTsOWhAck5OEFDeeGSmt/YC+YI67SmPBlIgljgkErZs1vXxCz
X-Received: by 2002:a17:90b:2f0c:b0:35b:a9f3:62ee with SMTP id
 98e67ed59e1d1-361404b247cmr29133451a91.27.1776918343743; 
 Wed, 22 Apr 2026 21:25:43 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.164])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141990bb6sm19166109a91.17.2026.04.22.21.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 21:25:43 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v6] Improve handoff prepare on SoCFPGA
Date: Thu, 23 Apr 2026 12:25:38 +0800
Message-Id: <20260423042538.3367-1-briansune@gmail.com>
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

