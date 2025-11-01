Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19671CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 03:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88EFA839E4;
	Sat,  1 Nov 2025 04:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lV48k+pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013D5839FD; Sat,  1 Nov 2025 04:53:09 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 531C2839DD
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 04:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-340c1c05feeso81327a91.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761969185; x=1762573985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ckBWg9deNS0s55IfU4SwebN26gGhH6JVVELrfC5Oe/Q=;
 b=lV48k+pdzlKVi+NPT8EJ/YpZL8NFr4g+TBQme+aD4huyisrVHnYcpLMbPJ1K4p2v8S
 CZ0GnWzJ1pNr3c20CDVIUFT6QwIS2V1MYFPC0q6f+dcy60/tiJ/R8MjHxfioNR5xicfP
 7lCCgq3YEuhJ21z/CuTydcQ4fx63hCedsT8qnD6Hu/oKDeK2ILFCum94SDqhDmVfqUg/
 wGgUlpO0cmlc0pL3PY0maJ2tappW9RRHLMUhcBxpMRXd80UL0gDfW0yN5eDDwBhFkNkQ
 WGx4ITV/u1ThZI8hd47XrIh2erzLD23prXesu2s384rK667zDWp5awpFlBK9XYSwnDOL
 fEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761969185; x=1762573985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ckBWg9deNS0s55IfU4SwebN26gGhH6JVVELrfC5Oe/Q=;
 b=dcv2CVrRca+OUAxyWqkXGtlKbQsrxhzV7uNmTKCFKig2sBNg+6ejaOto7iisWMSRfW
 ZAPQoeExHY69YhBTU4REhTOhJgz+rOmdgjs1pZ+FiOS3Y4uhRcdg+tRlfOoucoFJs0G9
 AqKxvkMoghm7n3SwrHI8RF8hTecRGT2uCsJYh97kd5ljRJ1J81ObTwUAu0q9uE3Sp6cB
 80HjFg8o8rIpuI7CERjEVhOIR44A8RYpzVyy4jzfbyMLiY8jZrQYcF/EsGCRTpv+9tfF
 wWn0lXoKCGmyuEH87IY4u8RXB8mj/Fb8LDbwTcy3sy+siRWZAh4vhMN1vpAs34p6cj2C
 1+IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdJ+/7FCBiqvgkgNBUM3HjrLcNMS3CZd3syrayU4UcMT2/IVJ9CP1y9OhrA4apf25I5vmLRHY=@lists.denx.de
X-Gm-Message-State: AOJu0YyMSISj1ZEtVxltnvInkboCwL4QhaIrEUrjPzozMmlusiQHW/s5
 +fGPGtAb5T8nqBSkq2QpYJAmZLIouMhXfveYIPJgWidyJCXmTg01jGoRFgnlkVY1
X-Gm-Gg: ASbGncsdoNdPHOcp7sv2EBNyIWVrXK67nSSuhPdcVy2M467LO1sikkPlTZFdxN3W/Gh
 RBaQWFMyNAEgV8o6qCQG8A7R7oHrPEAs/2DXccgxZWzRNDteSxtNoXR7bVPgDNY+Ke4QAosm53/
 i7zeONkcEVbzfQ94EgSnsa053bQxQJm8W2Klwo7lzuCsp3PMemVMNSqRNov33pCKcz/O+WrECQ7
 asydA5UtERiYwyY6IuSMppQD5Pp7+vdFAPP7P9AzYjE9bj1sl+BLhYoWZd9Fto0Cx2je2Azkew4
 wGf8C42lh56WOm4OqBbR2RW2BkSCvDKRWe/mGQMmNjmj/unlDSU+WpSfQDLwsYRXjGoWiQrB4x1
 C/B8lpSEce4yN6v3Ut0TgqGgzKz2D6hQ97yE+tTf0K7ObDNyPwG0LEg6GtQSh2WxpD7KcRz8MvA
 2CV0OQji5lfplOR62/4agl+Jnf0w==
X-Google-Smtp-Source: AGHT+IFggHboH/m6qHC87Ul6RtFUlZaCG9CTFX3Fugl/bOXgZZgloFgNz+Cf3TnPwL6SRE9c+CispQ==
X-Received: by 2002:a17:903:38c8:b0:295:4d50:aaab with SMTP id
 d9443c01a7336-2954d50ab58mr29524975ad.20.1761969184634; 
 Fri, 31 Oct 2025 20:53:04 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.75])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295268a629csm40393305ad.30.2025.10.31.20.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 20:53:04 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] Add make feature support for SoCFPGA Handoff
Date: Sat,  1 Nov 2025 11:52:52 +0800
Message-ID: <20251101035252.261-1-briansune@gmail.com>
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
@@ -484,6 +484,48 @@ CFLAGS_KERNEL	=
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

