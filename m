Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABACCFA03
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 01:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAE582A9E;
	Tue,  4 Nov 2025 02:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwZOAwQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF7A836D1; Tue,  4 Nov 2025 02:00:24 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C659C8144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 02:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso3947394b3a.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 17:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762218020; x=1762822820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dcTMlCo61/gK/zGHmFzVZd6bpL4zvQumU1cgzD+qUng=;
 b=BwZOAwQyvXMkjs4REOid3N2NCvEPwpGhppmoDS89Ik03I7BEYosrQeJVqP3dVMPXSf
 dX7+u7DHpGCGkDJUAXLHJGje1rRFoEfYtxXqUSujPqYXcn/Na90NATBFONEsVvCoBegJ
 R1fxLE4CGKERPdBsDYL4C5wx7MXwd37zONKOlcSHO82JeIdWUzKhRz2IP/ih/sSEF70C
 W3uw497OeuKJcAiC6+TFukx++t/aVwd1sh0v0/W8ATd84Ho4iZk1HFd54w/Jik+58AVN
 P3eoRi/uvIm1/D3XpbyvdimPxoXl7GiM48+Az05yGI9Y0fX4GQPjrdQhbNxPy8m02wLV
 UEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762218020; x=1762822820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcTMlCo61/gK/zGHmFzVZd6bpL4zvQumU1cgzD+qUng=;
 b=s6ixoWNXs5VWQ43+CM88RXBGw8Bbzn+yva4wciHNKHaWoZQQJAr3Bwh7cW/ZCBCtUR
 210T+RPQYcjin1o2CI0Zas1SbhFPpnsXW9N41OjDR4J4l2rvTziNyO/JmoeavnrRIvM+
 PE27JKGGC39x4H4gXmh0ESxDnJu0RWjZH3TFN0IhCSE1xB6PY0ydmnulefbnAHcho825
 hjbMYE6yZYec+U3JE6wtI94iJ4CKMsF61Q0GSDCS/omVa+6iFOj4PNQDkTQ1My2sT8AF
 lk/28G7PGjM5Qw1MHtTaYVAiAGH69fKmvrgf9IrkbtQA0bPPOzxKvdfZbZ0oTedZR2/x
 +r1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNavgOWa0WzDxvvRzHj2WmJFxlv7QbTYan4l3gSX+zeO3MrGf7NKFVcCB1fEyBPV5UDUzycrU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/tlTAAulipKfdvzRk5+Cg0gjV4ih44y4k1QjgsJDR9UYZ865L
 PICfXfpNFnBBilRIA6jNMF6UzA2XkNY9sr5vPn6kc3jwRZr4+876M+mHmUm42KYK
X-Gm-Gg: ASbGnctBPkSgQBRSXtzy53Bqx+Vz6F1YYBb1ZKocPZTuKo7qyf8oL4MSudzE3Ugh/sg
 2ea21RGOtWcu3W6d5CmW+pfrX1zSkpTBfGyjmvDtgMUQdo6RaVaVx97kqcl37242tKCuQ1ml62Y
 KCD6D8YLyHE9PFPM4GkFOpNvBavfVLWx0LkQHXF0eCgLyqAr15BzokT869AobWcJO/R1iql9FUM
 katBbUZUTOc4Y0D/SFHfJ5FlomcXagMnPNwDgzrHRZBbS+HZMhLnXEB58MWCr3DsdvxW8KrbdM2
 7KRslWnI1bdqx/kItlrv0+W4b7MfBkAvsTOc0Z2RtPwdLm1rJx5dpd/kv4iS1N5d0ttbRIDzUMQ
 B1+WieBGBfo3OcJgGCQrBnWkpAZgFrJefVYM4+bFoNhcpD3sIw6a/YUEkfkpXkk0I2zoTW86AA7
 XMRmnP7hjTABos9JfUnd86HL3tj50=
X-Google-Smtp-Source: AGHT+IGtlv9jFacsKbyLB/VSOehJ+zGQpVqIa9F4yqUPgn8KGMEIiv4uvWzBfOYHfdHvZXrmJzrGCQ==
X-Received: by 2002:a05:6a21:33a4:b0:342:a7cd:9214 with SMTP id
 adf61e73a8af0-348ca96c059mr20123890637.23.1762218019840; 
 Mon, 03 Nov 2025 17:00:19 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f87a7287sm409494a12.31.2025.11.03.17.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 17:00:19 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
Date: Tue,  4 Nov 2025 09:00:03 +0800
Message-ID: <20251104010003.525-1-briansune@gmail.com>
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

- Introduce socfpga_g5_hanoff_prepare target in U-Boot Makefile
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
 Makefile | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 750f8a84b1f..8431024e186 100644
--- a/Makefile
+++ b/Makefile
@@ -2158,7 +2158,7 @@ scripts: scripts_basic scripts_dtc
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-PHONY += prepare archprepare prepare1 prepare3
+PHONY += prepare archprepare prepare1 prepare3 socfpga_g5_hanoff_prepare
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -2190,8 +2190,57 @@ archprepare: prepare1 scripts
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=.
 
+SOCFAMILY :=
+ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
+SOCFAMILY := cyclone5
+else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
+SOCFAMILY := arria5
+else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA10),y)
+SOCFAMILY := arria10
+endif
+
+# Intel-Altera SoCFPGA GEN5 prepare handoff file conversion
+socfpga_g5_hanoff_prepare:
+	@SOCFAMILY="$(SOCFAMILY)"; \
+	if [ -z "$$SOCFAMILY" ]; then \
+		exit 0; \
+	fi; \
+	echo "[INFO] SOC family detected: $$SOCFAMILY";
+	@set -- $$(awk -F'"' ' \
+	    /^CONFIG_SYS_VENDOR=/ {v=$$2} \
+	    /^CONFIG_SYS_BOARD=/ {b=$$2} \
+	    END {print v, b}' .config); \
+	VENDOR=$$1; \
+	BOARD=$$2; \
+	if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
+		exit 0; \
+	fi; \
+	BOARD_DIR=board/$$VENDOR/$$BOARD; \
+	if [ "$$HANDOFF_PATH" ]; then \
+		echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
+	else \
+		HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
+		if [ ! -d "$$HANDOFF_BASE" ]; then \
+			exit 0; \
+		fi; \
+		HANDOFF_PATH=$$(ls -d "$$HANDOFF_BASE"/*/ 2>/dev/null | head -n1); \
+		if [ -z "$$HANDOFF_PATH" ]; then \
+			exit 0; \
+		fi; \
+		echo "[INFO] Auto-detected handoff folder: $$HANDOFF_PATH"; \
+	fi; \
+	HIOF_FILE=$$HANDOFF_PATH/$$(basename $$HANDOFF_PATH).hiof; \
+	if [ ! -f "$$HIOF_FILE" ]; then \
+		echo "[WARN] No .hiof file found in $$HANDOFF_PATH, skipping BSP generation."; \
+		exit 0; \
+	fi; \
+	echo "[INFO] Found hiof file: $$HIOF_FILE"; \
+	echo "[INFO] Running BSP generator..."; \
+	python3 tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
+	echo "[DONE] SoCFPGA QTS handoff conversion complete."
+
 # All the preparing..
-prepare: prepare0 prepare-objtool
+prepare: prepare0 prepare-objtool socfpga_g5_hanoff_prepare
 
 # Support for using generic headers in asm-generic
 asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
-- 
2.25.1

