Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D31D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 09:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8506283A5B;
	Mon,  1 Dec 2025 10:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vwj800ao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB9F83A64; Mon,  1 Dec 2025 10:04:25 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2044083A2B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 10:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7b6dd81e2d4so3639543b3a.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764579861; x=1765184661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dqL2MKvIo1zHfLttPSPyYxhLZ3zWeYPS2sD/JmLEs8s=;
 b=Vwj800aoIwb2rioLGlFNmhYiNd61XAZ5v5XIrgKTCRvXMG4YNPGdgyEmnfYyr9Ymr+
 1gKI/b8O80D7v2rAIqOU3dRiBYSRLUEHsySSbJQQqG+XHG6VJDB8T2wdWK5yL3F/zUtg
 i9AH4Qu8fKXUNSV0CXxczly9ibErQfeUdM/LmcICCJaizBpAtxrhI8eadm/6mc01nE6K
 EqH3dD5LG+Kp8Ge1IcGo2v0uYPch72gSdLXamYwM3Hl77UlCJDlEKUjM/WNNjDJjSRKQ
 jrpV9XQ13Kvz7sAlnKiLcL4EEBsDBriAHZKKhJ3+Fd5vwYo/grCcmhNfRSZpx2JzC6Qz
 wQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764579861; x=1765184661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dqL2MKvIo1zHfLttPSPyYxhLZ3zWeYPS2sD/JmLEs8s=;
 b=Mi9dLZJs+OV+72bZPBMZoVwir8b8jydc4CBDoeFSVRcFaxjixQA7iNHNunNL86+ydU
 aXr26ZurxT6Y8eX894owJJRl2anHOtiCU4HmuoH6nNNVxG6w6WTeP5sVS4gHjqDu5Est
 r8ChcAvIxvnJTcm0n+3ktwQ6ca8Po5qLsVDhddkoQkrpFS+Dz6jyKTEJwkc10/U0G/oU
 24ERQIoq5u4dEgCFnTCYZdcW02GeRXgmI8UXt7Hete6Dv1Ed3+t/HA2hBThm6itDXowp
 niAPL5NvdFUmN6tv98sUuCpcSniup8U0BXp2vR3iBy82d150CPEofHaB4i6dDoZ6QVNA
 vXuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCSpj3fxzmO1s4p2afjm8foFfmbrlHbahca01yG8uGk/1jFKwEf54/2lVbUmJFgvj6xar7m5k=@lists.denx.de
X-Gm-Message-State: AOJu0Ywa4CaNU9l4UQVRM6nKkbofNlxe6LEoE6BHZ4ukJueDxucQ/qEf
 ZJLzVB+IKRlqWAMbLrdPFBQo8E3hl+T0LNzyOrAjAApnlw8MAhnBCRob
X-Gm-Gg: ASbGncsblhyHAoTEWlRhNGlSD0GJUUUZ7zuL4tLZKGGRko7Mn5Z/XS8xGsK+bX3SlcY
 L3dz5se6NRwRrepBsYbvNvMDjTpDSc/Jem4NCzkPFeiZO8383GJv6gxqVfH79PaLxz4fvJZoFoq
 0M/xfXlTDl+lEp19qkrVlIRtBX7ebbR1ebjaaXuzMDyz2CiMyoZBr7dtBBAYeErXnvNHj+tlwyS
 IDVex5DsJXFVFNV7A6BZcg4JIHgXLHFfKsiSKlpJY3Sn8eo8Z7F0jDolYBu2Msh1APsx4PHYBCD
 mqzt5JkuO5xZzFfcRgn2AF3xDI8OSSYDUInL4Rz/g2Ui7YkSerRHSbhsHsinJkhOsvZTChqY5wY
 /QoxJGDQByf3ErSrSeqVyMZ6tlc6wLKJszRzskuWPFdGytktbVzbiEyonxMWwlL2uQuc8s4gnw9
 B6MIpoE4aulWIN0xmVgo83aE/5Nwp75EAlr7hnjQ==
X-Google-Smtp-Source: AGHT+IF83Trt3QRVUk0CPrftmei8VhIp0itZX4XZ2dU5TegCbGrghpNcfj2xggSDM2kBYFBB7RS/SA==
X-Received: by 2002:a05:6a00:9286:b0:782:5ca1:e1c with SMTP id
 d2e1a72fcca58-7c58e112b18mr42973284b3a.21.1764579861298; 
 Mon, 01 Dec 2025 01:04:21 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.248])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15e9c40a2sm12757861b3a.32.2025.12.01.01.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 01:04:21 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v9] Add optimized Makefile support for SoCFPGA handoff
Date: Mon,  1 Dec 2025 17:04:07 +0800
Message-ID: <20251201090407.616-1-briansune@gmail.com>
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

- Introduce socfpga_g5_handoff_prepare target in U-Boot
  arch/arm/mach-socfpga/config.mk
- Users can convert the handoff via make prepare.
- Detects Altera/Intel SoCFPGA boards from .config
- Combines vendor/board extraction into a single shell call
- Checks for hps_isw_handoff folder and .hiof files
- Uses ls -d instead of find for faster folder detection
- Runs BSP generator script only if files exist
- Non-blocking: continues if handoff folder or files are missing
- HANDOFF_PATH user define allows overriding auto-detected folder
- Minimizes subshells and other slow constructs for faster CI

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/config.mk | 48 +++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/config.mk

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
new file mode 100644
index 00000000000..2290118f747
--- /dev/null
+++ b/arch/arm/mach-socfpga/config.mk
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Brian Sune <briansune@gmail.com>
+
+ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
+archprepare: socfpga_g5_handoff_prepare
+else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
+archprepare: socfpga_g5_handoff_prepare
+endif
+
+socfpga_g5_handoff_prepare:
+	@SOCFAMILY="$(SOCFAMILY)"; \
+		if [ -z "$$SOCFAMILY" ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] SOC family detected: $$SOCFAMILY";
+		@set -- $$(awk -F'"' ' \
+		    /^CONFIG_SYS_VENDOR=/ {v=$$2} \
+		    /^CONFIG_SYS_BOARD=/ {b=$$2} \
+		    END {print v, b}' .config); \
+		VENDOR=$$1; \
+		BOARD=$$2; \
+		if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
+			exit 0; \
+		fi; \
+		BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
+		if [ "$$HANDOFF_PATH" ]; then \
+			echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
+		else \
+			HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
+			if [ ! -d "$$HANDOFF_BASE" ]; then \
+				exit 0; \
+			fi; \
+			HANDOFF_PATH=$$(ls -d "$$HANDOFF_BASE"/*/ 2>/dev/null | head -n1); \
+			if [ -z "$$HANDOFF_PATH" ]; then \
+				exit 0; \
+			fi; \
+			echo "[INFO] Auto-detected handoff folder: $$HANDOFF_PATH"; \
+		fi; \
+		HIOF_FILE=$$HANDOFF_PATH/$$(basename $$HANDOFF_PATH).hiof; \
+		if [ ! -f "$$HIOF_FILE" ]; then \
+			echo "[WARN] No .hiof file found in $$HANDOFF_PATH, skipping BSP generation."; \
+			exit 0; \
+		fi; \
+		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
+		echo "[INFO] Running BSP generator..."; \
+		python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
+		echo "[DONE] SoCFPGA QTS handoff conversion complete."
-- 
2.34.1

