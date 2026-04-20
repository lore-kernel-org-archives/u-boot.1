Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE4FF99C76
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 06:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD000840D8;
	Mon, 20 Apr 2026 08:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gh0RSr5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2E98421A; Mon, 20 Apr 2026 08:10:05 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B123683B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 08:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-356337f058aso1620480a91.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776665401; x=1777270201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ow3LYPa3AMZDEMytQoXZLWV7aRCWTX4zuW+ZXJ943bo=;
 b=gh0RSr5ZlI2K4U12ZMSE0NNb8/GeC1wml6oeDcNwPavzLAUdl/Ijm1E77ibNTXat0z
 TkIDIqGPC1GMO6qW4LKsXoDmSx9nx85LpIhiyK0chGowuvcQYutGH8fyiJswZq0pG+zw
 9fYa3ZYsAoFuaMr8PWYuwYAA6zGf+QLsViXF2d+oKvCKHXJ7hK4s6eQJlCDixTJaOW30
 9Von5FLXJIrhEpQqkqXtxMNT/iEMvAFantRpY90hNWIInRorwpFicTVgOpFq7d4OYQ1e
 5YvFX69F55P6CCVrsbbBLleUfzghG66+tXLLdliGzcFnATp7ubXsTGRpXsGb9er+/ShR
 bYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776665401; x=1777270201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow3LYPa3AMZDEMytQoXZLWV7aRCWTX4zuW+ZXJ943bo=;
 b=sxhKVF8X5b2FP/szpH+atPJIT3Wp2DLgvPnetMun5qe+d1V5+okGTxPPgWe3DCTEp6
 2yVMTHUiMg5WPJ6qsQDPg0Q6nBi52XM3iRZsHNNpvdtgYshrsMvaIYv3mEFM1e4zMHry
 Ckqg3EBovL51uk1zenW6yoWVp8LX25ejL5LWuKllnPCHJXfVetZgRnJAfwUEzBBwdFpf
 T98jurp+pCoWLzoxvorWMVFZ/DmksETF4Rra1mMOnyW5GFazQ/8VI1nJpRcWmnUy3rFx
 sr0EKy4iTTaYASvkSo8EePlXiLM9hsu/su9vGJwqA3SEpQICmVJmWmHcKM6UyfpE9ZFk
 vrzQ==
X-Gm-Message-State: AOJu0Ywhld1CgJCrQX5Zo3c4Qgg8bIM1dESV5liW0/10N9y4nFPjOluO
 s4M4aNX06hZ20lashmT5bYURftNM81LCRQNazpwpe+bR/Dspecgj11sVnBtio1Ri
X-Gm-Gg: AeBDiesq+5ps9+TwxeSssrogC5RW7InFZOTCaL4PyPmNt/yppEmRoGMuHh/caPiOh4p
 FChLQOLfiBrFmpOnt3hyVs/H35O6eNpr/GGvjmS0hFoFCDmtCJ6po2YonCYUqySEiKy1KVqv5de
 OBY2Ahbfj/PzwtfUQfHVWe+iFJq1Bn1KHiaa3tAy4LMEGIOt0JmPlVqkcwFwk/+qQ2frRJJz91s
 dSOdwMpQzy/DosAldd69BzCvhE9zxmW4V4fNVYjK47JutwSxMMLMcRlVJawhA2pilNjBnsqSd8y
 bT/SPxOtmtUvujQgBB7GQCs9doJPzVnbKOL8AfZ3+ZRgm8PasU7OzXxErPHBWeWb1aRi7YbL9yQ
 6ssy3gGX3bOA2HxTE/wTVy7NYRrYfxFsuWdqNI3H4tpXI5HvGxJWuNHPTWcsl18Zwd9mg5dIt+u
 ny7HgRSpJdAqdNAW9UYE/Kg9tfJcINi2yfLcv029JyYiXTSOtg3iVwfBbCCCiIQffxuQ==
X-Received: by 2002:a17:90a:dfd0:b0:35e:30bc:96ed with SMTP id
 98e67ed59e1d1-36140402361mr12470983a91.10.1776665400849; 
 Sun, 19 Apr 2026 23:10:00 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.70])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm8697051a91.8.2026.04.19.23.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 23:10:00 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v2] Improve handosff prepare on SoCFPGA
Date: Mon, 20 Apr 2026 14:09:54 +0800
Message-Id: <20260420060954.33211-1-briansune@gmail.com>
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
 arch/arm/mach-socfpga/config.mk | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 1ca1d33cb16..d4998298741 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -43,6 +43,14 @@ socfpga_g5_handoff_prepare:
 			exit 0; \
 		fi; \
 		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
+		echo "[INFO] Clean old BSP files..."; \
+		if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
+			rm "$$BOARD_DIR/qts"/*.h; \
+			echo "[INFO] Removed old BSP files..."; \
+		fi; \
 		echo "[INFO] Running BSP generator..."; \
-		python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
+		if ! python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts"; then \
+			echo "[ERR] BSP generator failed!"; \
+			exit 1; \
+		fi; \
 		echo "[DONE] SoCFPGA QTS handoff conversion complete."
-- 
2.34.1

