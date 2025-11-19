Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C0BCF3196
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 11:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3259C8391B;
	Wed, 19 Nov 2025 12:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GRQBv7Z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3920083DEB; Wed, 19 Nov 2025 12:17:12 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7EE580FA1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 12:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-297ef378069so61900775ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763551028; x=1764155828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=x8GwWWtvaj+KeWa+KTzLVMHX2JwWEGUfaVKflms3o4k=;
 b=GRQBv7Z/ypF5gRztP9H6g5pxCStHaVNZ56X3IFyKt10nFosRCeAUAf/t0umdUQd4yv
 6dAvgSbf7Vx5xruPWmNXPZpgP3l0OHrmCxjmmR8hqyaJa7KZLHwGz0EKpmjQWpiUbPZX
 qbbVAlF5SqgvZOXtx+CfzvmSLGCT+qgJXlksJ4QigS8cdf3HkJt5CnIkbRXOeGeWQ8K3
 6qHO1/dGwk+JliBM+PvglCYYyJpf1sx2EE/4pnz2OmVBEQpwH7Qjpg/YpD0gLo3C8TYZ
 /1yACGEAhPXn8mVYUUUYwTV6mq61HQo6qQbLj28NHEsqxcqvbaaj2+hDrOJCjcC8i7+6
 UvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763551028; x=1764155828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8GwWWtvaj+KeWa+KTzLVMHX2JwWEGUfaVKflms3o4k=;
 b=wNbsvGlm+HgduEucoOzJP/SzNULTLG9JaSOBqX9EQPPs0wwBRWnTa/dwZq2J5WJlKq
 fhb0M2a+9I2DPOzh5eGzIGKsDaVwmx0rePbm6elTiri0LCR/7YbLPXjupJ46CQqYEam6
 aBmif/uhTCd9QUwxWWNQIusZf8guIKMZy8JaU73FbagwzPchehW5HOAnUgJHVr6r/+3e
 8Tx9MX1QnVqrGOyYMddUQ8AYxS51eyLcS7r+ovURFIeW0od0rqz+Hpc66lxltRzo8OAP
 qFYB/+y/RJdgpuc1GJyC+SaykyGanNfFhKaoQrbceBTknI+oZYM5XzguH4+zlGl3/bPl
 Gzmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Ww9ip1YIyqsHmjC6Bf5VFmzOwsJs785akIPCYvQD46VoeAW/+2TgPEEsY4UsxoR1U2+iaXE=@lists.denx.de
X-Gm-Message-State: AOJu0YzE7wFMwjEzWdtgJzGlmX197kf5av8I54bTL0FOH2Rl3ZoolY6V
 HJtkSykkE5jGhM4kGAfSsgu/SUCKWp+SdHCTPEUMWj864OH/aI3l7Cz1Iy7dz/lB
X-Gm-Gg: ASbGncsAYs8I54kXm9MY9OE+zs7fPkP9R7wty9CasKCIfl6xNym1pAiY0Y8dA+0od2f
 oZaGvotErswZV6NXqcvkFSPJZ0iE8t9DPqr4r4uumS8+Me7M37mJXrZgs54/rjJTiJUB5cOf6DU
 hMvrn//qDloejZdkCFuGKq83frPvd8KhJ5XN0ie7C+PsnQKVTlyqL2SeM4eD7jF2tBY1HkjLVtV
 lmQL8Pe8RAFcKhTW/2s+7xWDIhFqFwiBQvxmpIsDaf2CGjnCdd7Ez95tiBR8Vp/WzH6Qo+mumDf
 cGIaJzPCG+AzXfCjYaundHN2eLT/TkbN6rlCkZy4Cd+1vZ+n0W3mJK8IjT4izib/+xwF2QGxOFe
 EeiEFq7iu83ppazovyLrUi0d1bUnYQBOuP+LDVQGWkkHSvQ5ib49aduffQwKURfP4ZULcnGufeD
 0JngNPK7ZazunlwFKkGC0dIPfoOUl5cljc02ieciZF+IzPwW8=
X-Google-Smtp-Source: AGHT+IF0owYUwMNEWdu000b2sPacqZEwqAw9Oq5dsp5XYmVNmUgf844Jvt90C8hv8lg/JlPLYRqAjw==
X-Received: by 2002:a17:903:19cf:b0:295:24d7:3792 with SMTP id
 d9443c01a7336-2986a6b81aamr242758975ad.1.1763551028172; 
 Wed, 19 Nov 2025 03:17:08 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.50])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2b0c92sm205143635ad.69.2025.11.19.03.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:17:07 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
Date: Wed, 19 Nov 2025 19:16:53 +0800
Message-ID: <20251119111653.456-1-briansune@gmail.com>
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

Add optimized Makefile support for SoCFPGA handoff

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
 arch/arm/mach-socfpga/config.mk | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/config.mk

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
new file mode 100644
index 00000000000..df1eb909129
--- /dev/null
+++ b/arch/arm/mach-socfpga/config.mk
@@ -0,0 +1,50 @@
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
2.25.1

