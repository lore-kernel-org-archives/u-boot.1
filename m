Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB01FCCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 03:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23D88397A;
	Sat,  1 Nov 2025 04:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cdPWdaVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB3683A15; Sat,  1 Nov 2025 04:29:07 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D455E83677
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 04:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-294fb21b160so19197275ad.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761967743; x=1762572543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IFKgaVX/4YrpkPSoHPZVg4pqZcr2GsJuCNuVcb0Tf+w=;
 b=cdPWdaVf0bIahw3qeBYVRhZIfp+VgKO6fImjbNOBxHxi2S8DQbg3k9fvHnOoiIFEdF
 wBcvOGj8WE5/lT06TKrpxMkRTmYOkajkm0N+Mxi5VJWskDzpiE+ScX2BETrxbJf/R2/p
 8NyeZ18WuPtCpkrQ48tD1qVpj525mNmoGYp4VM6GAE6xMN0pwGtwpH4/ksGpY4n8SVAi
 ieiwwjatpTVH7B9avzbXj3btZZbdvDi/DpVx1+SH9Ak+rVBY0pbn7of2V2TVn0wypW6+
 oQf2ikOf8hqg5nL5dah3P7PsPufBFyLItXUunc5CGIk8OvNNzgc94hhmMxvedNbPrS0s
 Kdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761967743; x=1762572543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IFKgaVX/4YrpkPSoHPZVg4pqZcr2GsJuCNuVcb0Tf+w=;
 b=hS7L5Ox84A8O1hhEgj1fIw+d/91fPESEB3Modzpqis798w5EwLdedH86WEsO919EVs
 C/yyZ7p8D5ySwX0nNh3uB551F7toB4Amal0ORfETtwThUwdYqRAoNetjjQZh8wkfKvNf
 ZyiaLgvldfyoYIf53wLIpSbyR5zI4pDjj8Cu42qgiYjAmpzmlyTY7a+7r5pcb6h2M+SC
 s72zoo46Y1CvVKmvX+00A8CK9xJ67Zb5n+YTmz2RDNlL5uJArdqom4BcLLDt49MpOyXl
 yE4ZJZYGXbfX+MYIPXnylbN6+zLYCxoPpvtvf7Q6yBCdi9DdIhfPNhB6myU7vMwk5Yk3
 40Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS3Yj4/HRE1DwGl6ppCvSvR/kmjPQTcdIyZx6ji1f/yXzeuPm1nGXtqYSmpglqyqgZrL9Covo=@lists.denx.de
X-Gm-Message-State: AOJu0YydPEq2reEuTwcamPSZif5DqrJLRNp0jpNud8EyaYp8TkxVzeCr
 Tu7NBhbEujstEMLzi8bATsZPFHlenCpm7TVgkSolUC4q/7Aq5QHjYZtvbIvtDL9s
X-Gm-Gg: ASbGncsHmg3tr/4kn2JtyMPHzKgLHBymwG5OmSwGlbeJl+stYjXTR5N5CQB6u9UJvnn
 ehFOH0y/KZTVtZ7WF5lbhJKX/98dXLzpYh5Tt8GfqDJ8rUGjsiyyniGBc8R3Il58MiX4dJrdqSQ
 6s6gKXcfuhvov58YgwkAkpHDfrBs2oCSRIKPKw4JvZ7Fgig3G9idc2BPTecRQeyVpgOUoOsMdHS
 lbLZIBuCUQb0XyiiWPqZqDuZn4zh5n5OgAt0U5M4FJ4i4EjCzCyCxIT1xYTqzVhiWOkoDtyGroM
 fmsyjxfcP+Nj3uMoCuSr/xugvAB6xmh/WsDghP3Uj7uL/pnX4MCSkDotRPKAJ8+h5O+W+xSbPGj
 F2NOLAxeA+/2MKQEz0ARomGkjeHHyHVL5E1QbnmL1cU7OVIn6kE+BdlEAqSiwA7yX/wT401FroG
 vAoUhy1661ol9YJFhh0qepjHab0w==
X-Google-Smtp-Source: AGHT+IEJQhkf7NaMdEGHEKVRWFUn+3vJSK2MKMXXWEL7vUdvcIdpcDNMnhHhKzgmsHUKkyW65C9I7Q==
X-Received: by 2002:a17:903:2310:b0:267:ba53:8bd3 with SMTP id
 d9443c01a7336-2951a4935b5mr85132835ad.28.1761967743163; 
 Fri, 31 Oct 2025 20:29:03 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.75])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7d897f379sm3759233b3a.7.2025.10.31.20.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 20:29:02 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] Add make feature support for SoCFPGA Handoff
Date: Sat,  1 Nov 2025 11:28:50 +0800
Message-ID: <20251101032850.1674-1-briansune@gmail.com>
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

Added new make command to support
Altera GEN5 SoCFPGA handoff conversion.
The new make qts_handoff_gen will use
two parameters QTS_DIR and HANDOFF_DIR.
Checking is done via .config SoCFPGA
family selection and directory existency.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 Makefile | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Makefile b/Makefile
index 750f8a84b1f..74474368413 100644
--- a/Makefile
+++ b/Makefile
@@ -485,6 +485,48 @@ CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 LDFLAGS_vmlinux =
 
+# Intel-Altera Gen5 SoCFPGA QTS Handoff generator target (detect SoC from .config)
+QTS_HANDOFF_GEN_PY  := $(CURDIR)/tools/cv_bsp_generator/cv_bsp_generator.py
+
+# Detect SOC family from .config
+SOC_FAMILY := $(shell \
+	if grep -q '^CONFIG_TARGET_SOCFPGA_CYCLONE5=y' .config; then \
+		echo cyclone5; \
+	elif grep -q '^CONFIG_TARGET_SOCFPGA_ARRIA5=y' .config; then \
+		echo arria5; \
+	elif grep -q '^CONFIG_TARGET_SOCFPGA_ARRIA10=y' .config; then \
+		echo arria10; \
+	else \
+		echo unknown; \
+	fi)
+
+.PHONY: qts_handoff_gen
+qts_handoff_gen:
+	@if [ ! -f .config ]; then \
+		echo "Error: .config not found. Run 'make <defconfig>' first."; \
+		exit 1; \
+	fi
+	@if [ "$(SOC_FAMILY)" = "unknown" ]; then \
+		echo "Error: Could not detect SoCFPGA family from .config"; \
+		exit 1; \
+	fi
+	@if [ ! -d "$(HANDOFF_DIR)" ]; then \
+		echo "Error: handoff directory '$(HANDOFF_DIR)' does not exist."; \
+		exit 1; \
+	fi
+	@if [ -z "$(QTS_DIR)" ]; then \
+		echo "Error: QTS_DIR is not defined."; \
+		exit 1; \
+	fi
+	@if [ ! -d "$(CURDIR)/board/$(QTS_DIR)/qts" ]; then \
+		echo "Creating QTS output directory: $(CURDIR)/board/$(QTS_DIR)/qts"; \
+		exit 1; \
+	fi
+	@echo "=== Detected SoCFPGA family: $(SOC_FAMILY) ==="
+	@echo "=== Generating BSP to $(CURDIR)/board/$(QTS_DIR)/qts ==="
+	python3 $(QTS_HANDOFF_GEN_PY) -i $(HANDOFF_DIR) -o $(CURDIR)/board/$(QTS_DIR)/qts
+	@echo "=== QTS generation complete ==="
+
 # Use USERINCLUDE when you must reference the UAPI directories only.
 USERINCLUDE    := \
 		-I$(srctree)/arch/$(SRCARCH)/include/uapi \
-- 
2.25.1

