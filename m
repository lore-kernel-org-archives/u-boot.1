Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E9F36C40
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2825839D5;
	Mon, 20 Apr 2026 09:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OpDDA9zV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0856E8421A; Mon, 20 Apr 2026 09:46:11 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C25ED83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso1695708a91.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776671167; x=1777275967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9oeVa8yb4gtrI6Arwx3u19JseEWOs2C3s605xqHzKUQ=;
 b=OpDDA9zVekjprEjiq7JTXBLDj5QbjVkciXU/SNoy3U5JB1mIy70RLCR83/Tam4VV7C
 PF+yzzyavi0Aj294e94fhU+kdSKpaKPD/IaGArZdWm7SLcoRd/ZFEpDmiFfXNT2PQ9Ni
 a09/ecBaK6X56C+d4/A2sKoJKJWn7oI+lpRCioaBDyb734iX2wMP+1oY+3aCgrfUM6NY
 FXYmpZy0DuykF6lsmGLAdW9B/4Lsge5dV4lb+73g8JJpqaSDLpTsvLQE8Vezi6n12J9A
 d6V8OrW92y/yavEd981iQEcnRQ13fUc35Dxh/1ThqVLoE07NEnMaNWnOMBxR6GCH11/W
 hb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776671167; x=1777275967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oeVa8yb4gtrI6Arwx3u19JseEWOs2C3s605xqHzKUQ=;
 b=L1ne7vdiScgJfFtT6IQJovlXMCIe6ins2xX+SaHL4hCWWHCSSPKJ4+5dZP17EAFGyE
 afQq6SMTmkT6f0CaHUUqaMPS0tCX9eV8r7rUOhDsvxU+hRLnj1o1iJ7kNnK1yxJpf8xg
 wI1gMhQO1MDGWhL3U+0QgeqzOuqXfY8XktUqHxFaRSe7xM7kbhZnqf4/+Bl5TFJKU5lP
 DScHkAMdpiVG7WauVwdiaRObbgWalyRsk+0sFlLxVRXThzQvRn4N/RnI6u5/alJt+v30
 iua9bgSOh5eiRNalPFygpZRQfWVpHbUfpTXuE9ElAOLOgQtBLWAnsVq9oXiwohslWcTa
 CiFQ==
X-Gm-Message-State: AOJu0YzH495O2Zz7aKvFS5iUg7V+S/qIJBZQKk+RhoEnh5/2BYMX7ghN
 ZuUb9IoaL+otZo42xNqaJ3mhA8DNZcTdl5J8D+67DuJ0OvmaeG17Oe04J4z8Xo/4
X-Gm-Gg: AeBDievyapkAjk06VM3MfuktqMhAZK2lHoa3HgiIwT0KD5rWDMLo0lYQ89CePln+1u3
 OBj2mYJHfRsVdEm447cy6Lri5pMu9ZbXbYuHvI50FoskNRtZGX7dBjDRGKixl6c34gRClgH1OhU
 Dt+uYEMpiB46ZZYwQGSi/l+6DumaKo/f4wjPcoTNdleDzks2+dxEzHoy1TJd/zRdJmycVlfoD8G
 BTkTH1T6fZcTKLScoZyk9O0sf56i4aaXkFg/UUVWfVA4GcH6F1T+I/o56Df1wALurCD9Oo1APaF
 UmEkzmlx+9JVp2+fsPixZcZSRZxbdqjWw57ZuUhiMDjXHGWb/EVzplIeTpuoyzb2b27doanIvUG
 Q7bKX8rgJarGlAcGOMSc2c6ct6H0/GQTdVvGmt/8d3AJ6BlWQl7208AZ6vjeOd8x6yir/lxpS9y
 LLzhaT55W3PH8ghTE0xMrK3tU13OCCR0DqY3wLQckOTIDoZscix07K5dg=
X-Received: by 2002:a17:90b:5203:b0:35f:b9ea:8f9f with SMTP id
 98e67ed59e1d1-36140464842mr11461546a91.16.1776671166803; 
 Mon, 20 Apr 2026 00:46:06 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.70])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab3ad18sm98181915ad.71.2026.04.20.00.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 00:46:06 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v3] Improve handosff prepare on SoCFPGA
Date: Mon, 20 Apr 2026 15:46:01 +0800
Message-Id: <20260420074601.24988-1-briansune@gmail.com>
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
Make sure qts folder h files are removed before
handoff script runs.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/config.mk | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..5a75b773474 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -8,6 +8,8 @@ else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
 archprepare: socfpga_g5_handoff_prepare
 endif
 
+HANDOFF_KEEP ?= 0
+
 socfpga_g5_handoff_prepare:
 	@SOCFAMILY="$(SOCFAMILY)"; \
 		if [ -z "$$SOCFAMILY" ]; then \
@@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
 			exit 0; \
 		fi; \
 		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
-		echo "[INFO] Running BSP generator..."; \
-		python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
-		echo "[DONE] SoCFPGA QTS handoff conversion complete."
+		echo "[INFO] Try BSP generator..."; \
+		TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \
+		if python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$TEMP_DIR"; then \
+			if [ -n "$$HANDOFF_KEEP" ]; then \
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
+		fi; \
+		trap 'rm -rf "$$TEMP_DIR"' EXIT;
-- 
2.34.1

