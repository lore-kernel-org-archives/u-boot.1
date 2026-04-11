Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CF8F3ED50
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 17:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A704B84118;
	Sat, 11 Apr 2026 19:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qPiq9xZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F0184118; Sat, 11 Apr 2026 19:27:51 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB0A83DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 19:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3591cc98871so1546423a91.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775928468; x=1776533268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KaJ6lsXbGYi/BLZcb0iwsVUy8cGezcCZZrYfpwxoyx4=;
 b=qPiq9xZMH7b5AepUBf54o0+i6uF7dccZ10xmR34Qg0xw3hEk2yhUSI02kl/od0FoHc
 UQAkBy9H51Ztz3PD/A/YNwpYBDv2k3RSXh+Psuck4gkKEJ3164+E1+jYRJ8nCNazmicD
 6j37CJ1l4nAVf+syGwFUlGa23g6YXmAwMwp32nBI1GbzeoF6fd1vTnW1Y9z/V0h/4V/u
 KlCgZCqrabvLYCtcNgcH0BWmPOC5yR2LtZY/sYRE1uGBczWuamiq+ttgouswQ2ROYDHc
 Rtta7UcTLE4dRiJDpJkUlyvkNCYLNO75GYwR1Lstt8A+dUvuVylFccPkwlh5qyjqfOhc
 og7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775928468; x=1776533268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaJ6lsXbGYi/BLZcb0iwsVUy8cGezcCZZrYfpwxoyx4=;
 b=CeDOCAvA9X+WYXDCHcd9THFTDs1oXMvRqVLW/Ud9yAM71BvvLjslr7pdHz9Q0bwr7/
 VJKes8/5Z4jTSWC9FHSU5cF9HCJtDJVq2WGImucKKgyDUnlJxiCTTWxanDyLSfAgHtSE
 VV1CVADclpuPGn7rpmukt2hTPCopShtpBl57zhKbSHvHVgtx5Wrsox6FX/uZAQsfB9hw
 AZTbn+D0Wdnn2L130NDzjaUOCMSMabGmonRZKQKj3OWemrG7BXmu91CAPKNwgtAFyXwu
 wlD2c5ihlm5/mAmyJnxlFJDmWBO9BpZdjZaPldUQMuHNahv6bIHl9h+XddAud7jCd9Vv
 /3gw==
X-Gm-Message-State: AOJu0YyvbXJPATyBCAhBPFCN9AgEybmn122RCcbLDgc4uABkul/VZUd3
 NIiddBOjV7IWpF+truq6XS+xdkdG8aFlJLNZ1ZgU/fkdhBMT3ghcNxa6CvCpPg==
X-Gm-Gg: AeBDievY00+PTo7ISoeu1fq0LfqqOxQwqz2HPRzzDvFy+PehXSKqizGzXZUDFVYbsVa
 JcWdrrEv9Jnxex2z9kqTBjWeHp1IWBmriSoO+sb6csVieE5SElUvurS7YYngpc99LaKXpFElId5
 4KPiLnrVMLjsCeoBhk2Wu18it175EykMvfshVItptmwafTTKEn6TD94JH1yHjlieNxD49E1Lrq1
 LgB1+ttLyXVIMswEPLyzCJdUKXkxSyWcnVUCszrdyKzlBio1DZHQqskVVLPiK5L6mDLICzxufuh
 pmeIDFyp9LCbB9A9nwUGwLGFLEzDM5smCznNMyU+h6Uhfx2Pj1it2o0wTIAsQcrSBsLGiWBmgOi
 7fLVwd+7wu0U4R1i4BNyYIxbE5PADft0ITEFxqZV+cQ8TWqgNd8IQoHlPfXmtyoYL+1JiPMdVpN
 WC0TTPfG8FFD+eMq2wtPkmq3t+2zTyAHZQvEaGCj3TIg10sQ==
X-Received: by 2002:a17:90b:1d8a:b0:35e:30bc:96ed with SMTP id
 98e67ed59e1d1-35e42781abdmr7871163a91.10.1775928467834; 
 Sat, 11 Apr 2026 10:27:47 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.200])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e411ff4c3sm7155785a91.2.2026.04.11.10.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:27:47 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v1] Improve handosff prepare on SoCFPGA
Date: Sun, 12 Apr 2026 01:27:30 +0800
Message-Id: <20260411172730.218700-1-briansune@gmail.com>
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
 arch/arm/mach-socfpga/config.mk | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..d9d9d4f2373 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -43,6 +43,11 @@ socfpga_g5_handoff_prepare:
 			exit 0; \
 		fi; \
 		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
+		echo "[INFO] Clean old BSP files..."; \
+		if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
+			rm -r "$$BOARD_DIR/qts"/*.h; \
+			echo "[INFO] Removed old BSP files..."; \
+		fi; \
 		echo "[INFO] Running BSP generator..."; \
 		python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
 		echo "[DONE] SoCFPGA QTS handoff conversion complete."
-- 
2.34.1

