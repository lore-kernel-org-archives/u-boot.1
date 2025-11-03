Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F10CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1587D82A9E;
	Tue,  4 Nov 2025 00:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NIWo8jGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278D08389A; Tue,  4 Nov 2025 00:48:43 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55708144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-781010ff051so4005184b3a.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 15:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762213719; x=1762818519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PJhABae7YtE4OQ52fwvn417fbzJQzigmYUF3Ktyz3Qs=;
 b=NIWo8jGG50PNfEMmkHFfOm7M1Fs/q0SSiXS+wqeaFgWOFhIqxeCTV6QNVGkFaZUWYr
 WzASouvfM5I0ZxIMAcda0Juec9U9dKR2Svp+IEHdSqAd1id1GRsABBsPJq2S+6jRtWNv
 dD145YBQnliwQv/DtaoQB0Qn2Gw+iqtEVWAQl4U7E9ILn0Er3oWiIG7cegKSMJoub34d
 WSBltMqYuVV+WFojpnqiQBxXQ77GyBDtKphRLE5PIEcHB/D/3LD5GvGtQO8uYVHpLGcn
 alWSUY19bWknk6KP5ozSs5itgo4th+t6QEQRSE7MNhYMv11HIiaUURIIB8wSfvGsZVJK
 rySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762213719; x=1762818519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJhABae7YtE4OQ52fwvn417fbzJQzigmYUF3Ktyz3Qs=;
 b=kHWOfpr7YN0LS1IZK4vHnkvkmTtKtKtrgJGGZQ9X5v3XkWTYjGNfuYDexrFCWyFoOy
 ar09L0dL7gxQ9uPGCMaEM4hYl0UZjfJnRKdLaHrqUNcZ3U8WNkTXsgbet7CnYBdwwNG+
 Gxdlmme4nEWYboCcrkmjZHLVaHJdVoVT96doAQbdE+LHaikHg4iNjtUoOTxgiOZPhJQ7
 5ZQXv2NULOutNfurEcKWLKwIVjTTiInmOmv8jdl9ncYTEKIkwmHIoctsrT+p7s8Y7P1C
 YIFlsJRfRyRtYYXW2iskSFNWrjaKa0Z3zeue+FIeBZBxHx9iZMoMayfmIDqACY+c7Pm1
 El6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV02B367Di2VVUGOlcrpkru5RZYtgoTU5zNCVw/DoyWTkCAx3C4IZ0Hr5YQ1zul4jlmY78B84E=@lists.denx.de
X-Gm-Message-State: AOJu0YxyoUps40YXhwAStvdYd6IIPfm6bRtpaYg5WQlxJbSQKLfaXLRr
 SIyBtyejVgOJ/fa/EA3yVFBAITJFmhvEgTjGThdw0J3ds73nERspwNWhKWL8Grn5
X-Gm-Gg: ASbGnctYpf5IFCa5hEuFuaqrH0f5zc178VN5fdx9487NDC2N4UseWIg0mLtBVc0QbPF
 yD2Ex37I71MX9SMJQpmd1UhMIR+sUUYkVpBIiTgfQlXuBBY/du7JjAkvVr3qTZ6g6xvQ3O2tdQM
 fnpcMlNhzI2rorjaOjgDi/LF+h/ZlHw0H5WeSBBdChZroEum5SLseNaL/LtDHi27JVcInkbKbRO
 VaScaAaNUQWyGBjFP2ecggvDwtN3DIBTQUmAtMfvTE3A0YsdcgboeHa67SNu8DMVRvoaxBUoNz6
 PQZZT1ExmWz0D4LetD/7oOkQ5x1GQxa6vw5IDNeoP4xqsp5I8JfUeJMPG0kZuxd58DONdprKJex
 g+QxjLdPzcWDrszzWXXYfgd9ETwAmegNCbVj0sejoROVA+Pz+3XyaGxOzS2Bmn9+FGyyDrQ/H1m
 9nsYphRX9tyraRX286JRtjo8OZUCA=
X-Google-Smtp-Source: AGHT+IGwIfT7ErDbECVk9lzCJ9Eef0hoMrkoWC0CbHRKKe1ihLE40vG4buSd7aKrVAuzoliWhwtI2A==
X-Received: by 2002:a05:6a00:2d98:b0:7ab:3454:6f2b with SMTP id
 d2e1a72fcca58-7ab345471a7mr5221731b3a.19.1762213719309; 
 Mon, 03 Nov 2025 15:48:39 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.232])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd586f857sm618259b3a.45.2025.11.03.15.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 15:48:38 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v5] Add make feature support for SoCFPGA Handoff
Date: Tue,  4 Nov 2025 07:48:12 +0800
Message-ID: <20251103234812.505-1-briansune@gmail.com>
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
if files exist
Non-blocking: prepare continues even if handoff folder or files are missing
HANDOFF_PATH user define: override the auto detection in board folder

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 Makefile | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 750f8a84b1f..f5efe679259 100644
--- a/Makefile
+++ b/Makefile
@@ -2158,7 +2158,7 @@ scripts: scripts_basic scripts_dtc
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-PHONY += prepare archprepare prepare1 prepare3
+PHONY += prepare archprepare prepare1 prepare3 socfpga_g5_hanoff_prepare
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -2190,8 +2190,50 @@ archprepare: prepare1 scripts
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
+	if [ -n "$$HANDOFF_PATH" ]; then \
+		echo "[INFO] Using manually assigned handoff path: $$HANDOFF_PATH"; \
+	else \
+		HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
+		if [ ! -d $$HANDOFF_BASE ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] Handoff folder found: $$HANDOFF_BASE"; \
+		HANDOFF_FOLDER_NAME=$$(basename "$$(find $$HANDOFF_BASE -mindepth 1 -maxdepth 1 -type d | head -n1)"); \
+		if [ -z "$$HANDOFF_FOLDER_NAME" ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] Handoff subfolder found under $$HANDOFF_BASE"; \
+		if [ -f $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof ]; then \
+			echo "[INFO] Found hiof file: $$HANDOFF_BASE/$$HANDOFF_FOLDER_NAME/$$HANDOFF_FOLDER_NAME.hiof"; \
+			echo "[INFO] Using handoff folder: $$HANDOFF_FOLDER_NAME"; \
+			echo "[INFO] Running BSP generator..."; \
+		fi; \
+		HANDOFF_PATH=$$BOARD_DIR/hps_isw_handoff/$$HANDOFF_FOLDER_NAME; \
+	fi; \
+	python3 tools/cv_bsp_generator/cv_bsp_generator.py \
+		-i $$HANDOFF_PATH \
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

