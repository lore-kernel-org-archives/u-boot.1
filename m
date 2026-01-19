Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB8EC98315
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 01:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD268313B;
	Mon, 19 Jan 2026 02:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+obX1Ze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CDA8389A; Mon, 19 Jan 2026 02:55:32 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746668004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 02:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7f216280242so1487669b3a.1
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768787729; x=1769392529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e2/YMnQjILIlfZ+QXyr/KY3X8dCWcRCWmS1KO72JTQg=;
 b=k+obX1ZeTHzZPY1F06exDwwTG8jS38C4YnQerxnG+l9QmJ4u1cLuGRVZC4MuX7JFlc
 RPLCQS9ac8houzS2T7XZmZNks/SwWfu1flK7GjzDqS62KgbZuzQr12fkRtspLTCI9jdV
 Mm3Hsc1KOGqcSCi7m1PfnAkbrhwO6rac6QWJ5uPheyZw63jy8BVUePVlXir0gpB8dT+A
 iOF3tmaMZhI7FO8acClNFOx54v5ChgbtVjL2HfS96WDSrgxuqNKHZjaWMEicc0jQLng+
 Flu+omYAfDoQC60XHMAKXKzu8PMFbhoI7qdaiKZ8PuB9FWAfaFPyL9J+k4l+G4bm/QFz
 B1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768787729; x=1769392529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2/YMnQjILIlfZ+QXyr/KY3X8dCWcRCWmS1KO72JTQg=;
 b=jQaPTQsz+sswaiomKZxBZ5jAld+h8m0csyy5lI6Oo0eBREqLwEjWveWLE7heOTDItV
 zykoDDLwdJwlSfKs25UkcxF3//E5qDUbpj1vO+a8gb8aKc1DEjuOdIeXmOJe3Ic/uZwC
 7m5cssRbiUU8545V8psiWgExYUOphhj4eBlsd/elowmhFKhDJLjCfcc8B2tmjjjOET49
 c0DinCA28t5CEAuUCNgAX4oHa4Svfj8bzEi5ye7zVQ/qFIy0//l0Nm9/3XRHixj/FdLp
 bvZqEb0C+Pq9fG7OF/Eqn83N+aYC/UQ5i/tcIcNYR9BhIGQz7T2klgOYAAH5UyvA35zY
 uj4A==
X-Gm-Message-State: AOJu0YwsXJlK8rV4TEwVMGDalxXxNwjxPsi4u2ev5yUzSyVCt9/p/iPl
 dKKoKcdxJkLucr9Bh/nEQKXWkRH1WRfGHc9h2iVjTzKgdD+8Au9frAWO+jlfjA==
X-Gm-Gg: AY/fxX4bKgg9b7qcMxSSGmwuSEVjFegM6VnbjB0+1h4BXNL4gUpathPFEbs085YEYWY
 mIuCeDtxJpjWaIjLlMitVSpPFfWTk9j/ZUZgrBQe1c0M39Jodpsz47Wri3EDP5Rbm/AbodBvjXM
 zFq0tgBB/vXjb3G6zBl2rd5JdZKOoq/PTXXz2Z3A6wYotTQSIO4VNFT0lhQa8Rn8K2T/GpcWYl1
 4tOVNNrNo4cNOqMH8H288juij7l1luhaIohQYOZkjh38JGpbwmd7Blgg/M+1JmZELX3CiX13o2W
 yvyN6TetOedxuyVJ1CtZdCA097Fl+Tiq8TFM/HwJvH1qjDTyo9hKcgUYlWWU4tos5E4J2XiouGO
 ydkZ9EFfk1NILm/dj1OneHrXPCWreox8JRKr4CBqhd4Ivrw8/tXzK+iP5ZdJ8K2FOLIPAJdWZiw
 mrzQg5jkimbWKhX6Fx3A4Es+dgm52Cae0h8g==
X-Received: by 2002:a05:6a00:6c98:b0:81c:ce40:b29b with SMTP id
 d2e1a72fcca58-81fa06850eamr8065086b3a.15.1768787728634; 
 Sun, 18 Jan 2026 17:55:28 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.136])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10bdafdsm7485597b3a.15.2026.01.18.17.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:55:28 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>
Subject: [PATCH v1] fix socfpga GEN5 handoff script path
Date: Mon, 19 Jan 2026 09:55:22 +0800
Message-Id: <20260119015522.30558-1-briansune@gmail.com>
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

src variables not longer defined, fixed by srctree

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/config.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
index 2290118f747..3909d399895 100644
--- a/arch/arm/mach-socfpga/config.mk
+++ b/arch/arm/mach-socfpga/config.mk
@@ -23,7 +23,7 @@ socfpga_g5_handoff_prepare:
 		if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
 			exit 0; \
 		fi; \
-		BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
+		BOARD_DIR=$(srctree)/board/$$VENDOR/$$BOARD; \
 		if [ "$$HANDOFF_PATH" ]; then \
 			echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
 		else \
@@ -44,5 +44,5 @@ socfpga_g5_handoff_prepare:
 		fi; \
 		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
 		echo "[INFO] Running BSP generator..."; \
-		python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
+		python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
 		echo "[DONE] SoCFPGA QTS handoff conversion complete."
-- 
2.34.1

