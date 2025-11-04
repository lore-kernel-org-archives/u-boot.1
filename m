Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9291CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129D783968;
	Tue,  4 Nov 2025 23:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7LhVydi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB04A83979; Tue,  4 Nov 2025 23:30:40 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52FC983957
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-33067909400so4332781a91.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762295437; x=1762900237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4sDoWXY9heVcYWpzG+YjEEBbjE/bhrzPUL7kq4NSD8U=;
 b=M7LhVydi4n/vfCQtnkL0fS1H2bv/0uce3waVZwyWPFmVKBVQPArICOUeN6l9tI9YUp
 nT/BYVXA1zWU6tsj8BJyZM2DWuXwO/nZDc3gmKjKmOzKehrP+A8HyBsmqOlNHnGBSdkn
 hN10FBPBHFZW7dNrqL6ik+yMkLqrajNv1k01AMkSL9dFhcCPUc31RP9Fxm8XsHIFRwOv
 LEGDRfSE6neC/3zaPf1gJQx+HG2GzIsdbtTIoS6bKIWOxZMesaBeXIVYLjZAArCtq11k
 fHoRxn7aIs6J3fbgejDkaTSpGtMraSODixOKbnAtleLUrSJ1qk4yIg3OgFYRVEFYEiD+
 jjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762295437; x=1762900237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4sDoWXY9heVcYWpzG+YjEEBbjE/bhrzPUL7kq4NSD8U=;
 b=E22lfL98mCn+clcmddux0hmJxNg+1i5E/iqM7i6v33q5cUipC3O1wzFIisasBXOyZT
 spgbjCJd2PqDnF1WOKzP/ifoeqLgIpS25g3WtHc8Td56Ak1D8rsLpxvvQq30xnwQEJmd
 t0uC82fhB7O2uTX9MCr8eo9Vjtzuc94K3BkP3jSlJh5AKiNMW0sif106mFkEB72b3zGC
 5WXI1WJDuB8RhIPHDzaSi5nWBwVo1DiMjyEAojiUWY+vELcvyUm993rY/AXZ7wFEp2gE
 N6HGS58HqLbik0IcS9fAHcLMMqELFjlF8BFgY+ukdqTAIN8ssCe+qIorZtAvftsnSufm
 9tLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnGyIQtkKNpe4Jgblg4rokgtpJ/zTzKWq7A17lJz3T/mLNgUdKfkfQQnB2UpOso+KPbbXLpfY=@lists.denx.de
X-Gm-Message-State: AOJu0YyBV7L0m+ePsOWSxk23Zk3WbhSOwJbILtDH3kUVs8s2r5Peg6eJ
 yXSoDaSAPr7QTkeE2KTSz1zeEoIMvEGuTbAFu4ZV40Ko2h0cw84sGG89hqUh2nen
X-Gm-Gg: ASbGncu9zKTlGqrfFzjiyMa4nwEjYzMFtk/SPYBwqxzf56zdxrwLQ1ellI/FpqE9B2h
 oEGNKtQLmCRGfZmxs9AQLpilifkEgxaz4IAzq8PpevRyo1r0n310jZjjvjRcS7ERk79Vl3KheoD
 RMpYlx7W5SYIkUf9hZeKk5P010awOwakvCiVMPrWiONLpW1Onkff4y2uDgK55MV1Y6E+O5tAMO3
 I3t9O7QNg9Zvwcv/yiX5VvcRYTzYasSh7b4LFiDrlClwgvaZLo3/yLrEwAPge5lYCX5Up+yfbK6
 kZ1mdZZKtiWzhiD9kdKFNRKAP7/drl6YLnsjcXqR6LebdzsJZPYw8BVg4+9IBG0eZbtF+pZ0hFW
 Dz86yxqZtzZgF9PdK9gG45VJBWDA8kL8FKihTqH/9XdvYs5uq+68Y7+5/xKgwyheLC+lHIhMinM
 W1DVFU26ceiWZXNYkzegrIkI/Rs6gFhrQbNE5+
X-Google-Smtp-Source: AGHT+IGJojKb/c+fb0oP77VQwrE7mqpYqlJosdSyuRekm+XJvnawVI2dy87JCTG5zlVZwRUnSPcu/Q==
X-Received: by 2002:a17:90b:5628:b0:340:a961:80c9 with SMTP id
 98e67ed59e1d1-341a6dec5e6mr871374a91.30.1762295436609; 
 Tue, 04 Nov 2025 14:30:36 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.45])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a68e8029sm639417a91.17.2025.11.04.14.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:30:36 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
Date: Wed,  5 Nov 2025 06:30:23 +0800
Message-ID: <20251104223023.1613-1-briansune@gmail.com>
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

- Introduce socfpga_g5_hanoff_prepare target in U-Boot
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
+archprepare: socfpga_g5_hanoff_prepare
+else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
+archprepare: socfpga_g5_hanoff_prepare
+else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA10),y)
+archprepare: socfpga_g5_hanoff_prepare
+endif
+
+socfpga_g5_hanoff_prepare:
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

