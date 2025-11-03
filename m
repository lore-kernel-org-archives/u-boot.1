Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF98CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C2C82A9E;
	Mon,  3 Nov 2025 23:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IABe5y8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800CD82A9E; Mon,  3 Nov 2025 23:28:59 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3642D8144A
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso4830861b3a.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208936; x=1762813736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dJWxwoYPsR7S8JfDrCfzS2FN9FgxXSiTChUu/wzcr1g=;
 b=IABe5y8RGWb3JAK/Go2n5JoorCSyMrsEb8PZoWwqY7yUnWsA7x/eyVfZRekErse4xY
 3v9V8+6UVldyGU+yiR6oNznaZ/3sI4IIqk2LShAWFo0L804zuAahmabhWExNXfTnYdhn
 4BWqrYNgK3fa5IutrG/tLuuKPbH1Iazis1q7e5psEq4TfB6pT5XXQGpyPkpyDlQAxhSJ
 NBoW2JYbpElBni5YqAPBGJNX1BkSjQrjYY9KRnLaKNzo/OE/KZ9r3bSOXPniSff4S2yZ
 2mXi/UoLRGqhE1tRtwsb4QN2rDRIRtY8BLBqsYjARIoVpXnWw6NfowuVAlajjtYJxBNu
 ocYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208936; x=1762813736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dJWxwoYPsR7S8JfDrCfzS2FN9FgxXSiTChUu/wzcr1g=;
 b=TGwr+r4rWOO0ASU6D91+NhEMEyuN6KojxNvZiR/YMq7TVMKCmoV6c5QZu5qOAu6+tc
 ofbUPg1Ms+Y8QLiOT1T6oHKMRv5/EAQNqo+n/obCWec2JXsNmS35MFxrBrLsv3h7zh2r
 /DridG9fwWOzze6oFuv125GjO4vLOIOTliOHCLADTvHgWIv7fI+PEEqebrWiL5Hmu/+9
 P3Pc1DWmr57iP7bX/yQKQgR7lGbTMOPxfu0otWGCO+R/MvSgremAd2LtnJ4ayNBdr4hC
 L2AecW3F2O7wpcNyapkM/RWCoXwGftot68oHfyCphLLQ2M1A5ViqQqm63bPXsarEPRvQ
 bHsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwKmxri9FtPtkoRkCHr/vVk7ZOUR8T47schIGNn2gCjhO07TEaxQec7CtqK8JQY/dJdCdGO3o=@lists.denx.de
X-Gm-Message-State: AOJu0YxREskzmF6nmTOCrQZNJG9Fn3NpTmLokUOXiktfmvZdROY0ojjM
 kjORKEU6EnNHAJK+Q5bTcdeOKXAtWAhZhHKelIarhI4ijeQcxlEK+ZAuierBLKoi
X-Gm-Gg: ASbGnctW75b6ukkvlFs8wRyjtdz2oq1rRzfN08llPOJkESBZYdmsZMWTLsXqpzo8miI
 6tG9awjbm+0qVUg07wWlLZ7VMSPDwJGB3xRDyzD1azTf+t9+BI+YEXd62RVwjIWmOhE8DiQVQLb
 js9fBUAMzrDVR8vhagNymlXNzVomFv2tifLoFc3WmDE6M3lbNTsfKK2nYLnYf1LCN6dV89AkujO
 W1GKiPuD0E1YD+dQOf91e4lsBZvrHx8VX0dKNYWE00g5VV4QE/4+uXYlzBXvdy3U9WvoGSygYww
 6LGWRH7pLM8abE79HDN3JRykGtxfBk+CK6AaCYrl6hwbPefLbOPWrFFD/Abq/IS7+wET8NVLfiU
 zn+7W50hjp2ax+3VPb0fFD0eSo927fXJ8m6ifT4T9mlfx212D2jF36iygAJLgBZ8iLHguWVGevH
 hoznFgP4eOWftcRCtpCMU0fAVNuUKaTNsFFoWqFg==
X-Google-Smtp-Source: AGHT+IGWOBAP+ZnDdvooCXr593YS5aZOQgDHhP9q+Lui3wz0MVLHS1KkTc6RvPZnweB/4n96w1Foxg==
X-Received: by 2002:a05:6a00:1890:b0:7a1:49f7:ad04 with SMTP id
 d2e1a72fcca58-7a777760c4fmr17644601b3a.14.1762208935185; 
 Mon, 03 Nov 2025 14:28:55 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.232])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd586c25fsm488635b3a.42.2025.11.03.14.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:28:54 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3] Add make feature support for SoCFPGA Handoff
Date: Tue,  4 Nov 2025 06:28:40 +0800
Message-ID: <20251103222840.458-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

Introduce socfpga_gen5_handoff_prepare target in U-Boot Makefile
Automatically detects Altera/Intel SoCFPGA boards from .config
Checks for presence of hps_isw_handoff folder and .hiof files
Runs BSP generator script tools/cv_bsp_generator/cv_bsp_generator.py 
if files exist.
Non-blocking: prepare continues even if handoff folder or files are missing

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 Makefile | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 750f8a84b1f..32568a6c477 100644
--- a/Makefile
+++ b/Makefile
@@ -2158,7 +2158,7 @@ scripts: scripts_basic scripts_dtc
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-PHONY += prepare archprepare prepare1 prepare3
+PHONY += prepare archprepare prepare1 prepare3 socfpga_g5_hanoff_prepare
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -2190,8 +2190,45 @@ archprepare: prepare1 scripts
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=.
 
+# Intel-Altera SoCFPGA GEN5 prepare handoff file conversion
+socfpga_g5_hanoff_prepare:
+	@VENDOR=$$(grep -E '^CONFIG_SYS_VENDOR=' .config | cut -d'"' -f2); \
+	BOARD=$$(grep -E '^CONFIG_SYS_BOARD=' .config | cut -d'"' -f2); \
+	if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
+		exit 0; \
+	fi; \
+	if grep -q 'CONFIG_TARGET_SOCFPGA_CYCLONE5=y' .config; then \
+		SOCFAMILY=cyclone5; \
+	elif grep -q 'CONFIG_TARGET_SOCFPGA_ARRIA5=y' .config; then \
+		SOCFAMILY=arria5; \
+	elif grep -q 'CONFIG_TARGET_SOCFPGA_ARRIA10=y' .config; then \
+		SOCFAMILY=arria10; \
+	else \
+		exit 0; \
+	fi; \
+	BOARD_DIR=board/$$VENDOR/$$BOARD; \
+	HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
+	if [ ! -d $$HANDOFF_BASE ]; then \
+		exit 0; \
+	fi; \
+	echo "[INFO] Handoff folder found: $$HANDOFF_BASE"; \
+	HANDOFF_FOLDER_NAME=$$(basename "$$(find $$HANDOFF_BASE -mindepth 1 -maxdepth 1 -type d | head -n1)"); \
+	if [ -z "$$HANDOFF_FOLDER_NAME" ]; then \
+		exit 0; \
+	fi; \
+	echo "[INFO] Handoff subfolder found under $$HANDOFF_BASE"; \
+	if [ -f $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof ]; then \
+		echo "[INFO] Found hiof file: $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof"; \
+		echo "[INFO] Using handoff folder: $$HANDOFF_FOLDER_NAME"; \
+		echo "[INFO] Running BSP generator..."; \
+	fi; \
+	python3 tools/cv_bsp_generator/cv_bsp_generator.py \
+		-i $$BOARD_DIR/hps_isw_handoff/$$HANDOFF_FOLDER_NAME \
+		-o $$BOARD_DIR/qts || echo "[WARN] BSP generator failed, continuing..."; \
+	echo "[DONE] SoCFPGA QTS handoff conversion complete."
+
 # All the preparing..
-prepare: prepare0 prepare-objtool
+prepare: prepare0 prepare-objtool socfpga_g5_hanoff_prepare
 
 # Support for using generic headers in asm-generic
 asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
-- 
2.25.1

