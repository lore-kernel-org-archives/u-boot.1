Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7211F5A8CE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225EF8422D;
	Tue, 21 Apr 2026 02:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwA6+vzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D17E842B7; Tue, 21 Apr 2026 02:47:34 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D44B84198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35fb16e56efso2418578a91.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 17:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776732450; x=1777337250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVAhflZNfTrCcHJx/JBXGaE3foVPdgIpiYl4Pnn/9zI=;
 b=EwA6+vzCTXJSF2qEemO9RN49Yf6hSD3s7qKGxn+cmBzYPsAO+EGusOMWfCZ2rjNqrX
 hzNxhYLNKlIYGoBcg/j/Q1ucv9HHXNi+/Lyzacn/HTOyQkvnOw3Rh+dz4uT071i2E5KX
 N0h6BvM2BByEKpKNhqAuuGXH/Ybw0lazpNV/6QplxKC7QqQtq7p856hITRRkEIZOZJt3
 c9M0ZhrDYPlo1Zy9XefX+ToKupseLAbhziZFXByJzvg0tKGaYZ2IY8de71AvG6XVmbif
 eAFqRc4er0Ee3TQVTKQJ+XvUGnsl4qYeabaiQ+ksI89emAc5TNmY8D9eEsCL7DXXNzIn
 fwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776732450; x=1777337250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVAhflZNfTrCcHJx/JBXGaE3foVPdgIpiYl4Pnn/9zI=;
 b=CGNcNz494+r38UqJY/pmxXk8u+gRBSl0jGy7PgXyz1yEU8EdGHLUyU/IrFpdfOOBKO
 u0wyd0NMNmsnc2miPgwMhfER4e+5xX/3fsGU9he95UFz6YDbuej8Pd28hndrLgKp1YVY
 SRTG3aZ1y92ZBWjQOKqv6laS7zXB4aYmOCu24aqQNWpPhOzoxJWtlQgovUGTGTFlvFpb
 FVOmBnlZO3SNYDYKEmx17hf73QA6/FAMlxwp2E37EAS63uem0ZxIoHOHtGLVYbrQtqUt
 977Wal2cg9xBe+omYpI8nmlyxseOaq/qxzEEP2czW8BlvrW3fLniWT71QwsmV7erlYEe
 NDkg==
X-Gm-Message-State: AOJu0YxKLv6ilcrDTKHgiqG6H188cm7DCH9VZXwgi12kNPlirClbbOrP
 dtiIxopeULLhrPXJCa0JxaQfsebMduMbcie53ewDASSxsZTt44qyjf//XI3uFpJB
X-Gm-Gg: AeBDievPFi3XWMZJpYBjcWc8TEmUN4xW0exMymxqem6vl7kB2+2yayhxMSz4U5M+JNv
 iTlP2YWeG4uX6T2BMnmA1tpcBNq8wUtsh9L1C6FsB1kcSTwcS3y4yOjKs3K+d14iasB4pV/g5Fg
 LK4knyaFpHtswp+8QOPl/yDC/diUcFb4NzP0fbqB0G12IYcsh9qcChDwFGyL88PhiMWvG+U7N7U
 5TzZrKPbB11pd//Ob6b5NKiFy85x9t1wYP2IpUWqwLbl/WgmpZjkRVHykousRsukBzEtb46hvOZ
 CukH5anRJrkzOH/UKwCvJMOPXwVde+vfqhwiI72dd3Xg1oaEJfHTz3lVC76x2z7aV9iBLF8sELs
 PV46vJk4F0sUjr+50G8vXXWQoT+rsp2iD6KZypqU/gAX0uZ7F7PDXz/G4JsnMBHz72KjIswRTBo
 QlttcdVgPn0uhLGpPtd8OEsQ0Z4IqJn76iYAiQAEEJtQr1keUbMMFhaQY=
X-Received: by 2002:a17:90b:5107:b0:35f:b870:9c9f with SMTP id
 98e67ed59e1d1-361403f09e9mr15508052a91.12.1776732450250; 
 Mon, 20 Apr 2026 17:47:30 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.70])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff90dsm114476645ad.11.2026.04.20.17.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 17:47:29 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Chee Tien Fong <tien.fong.chee@altera.com>
Cc: Simon Glass <sjg@chromium.org>,
	Brian Sune <briansune@gmail.com>
Subject: [PATCH v4] Improve handoff prepare on SoCFPGA
Date: Tue, 21 Apr 2026 08:47:19 +0800
Message-Id: <20260421004719.73491-1-briansune@gmail.com>
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

There are some cases that the Python scripts
are run and the qts files are not replaced.

This patch introduces:
1) TMP folder for Python script
2) TMP folder will automatically remove on exit
3) If PY script fails, the replace will not conduct.
4) Only when PY script passed the replace with keep
or without keep will be done via NEW HANDOFF_KEEP=xxx
5) When keep is selected the old files are renamed to
xxx.h.handoff.<timestamp>

As such this ensure qts folder h files are properly
updated.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..010ea633f12 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -43,6 +43,27 @@ socfpga_g5_handoff_prepare:
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
+			if [ -n "$${HANDOFF_KEEP+x}" ] && [ "$${HANDOFF_KEEP:-1}" != "0" ]; then \
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

