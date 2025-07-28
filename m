Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ED9C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 13:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D95382E26;
	Mon, 28 Jul 2025 15:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lFiF9a9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998F682E34; Mon, 28 Jul 2025 15:14:39 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997D882D88
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 15:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-32f3ef6178bso36818471fa.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753708476; x=1754313276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k3a1uBV2x/B6qd1DT74hySPSOiEOKWT23+YKC9TRgWs=;
 b=lFiF9a9QNsOmlldulTZQZy+cpWk6KVVom00P2T8kmBNvxK1+oGc+TeI+oFTp4qbKBe
 0dhlLswL1DcR5XVqcob4nf8uLBbTCTWpj4jy7jgh8+gt4Brqy5gX4dV4dlllXNzvPMgn
 mpy4dErOK/GwfuO9th6bal5YiDcRhvNYMSmpv6MYoLf5cdi0+eiD0A1/w+zV/Y+0OsjQ
 1BoOlDjTOsehrjBsUBNb2DJ4Vw+Eu5qXXkcDSObxu86GkqrSFazKDxxZgRWy9AWkncpz
 6Do/JpGArOMGqRAd4eKIvPRMqdsdK4eKhKb7O6UX94N6nIPtr3q1q7aF/Cquf/xrxEwZ
 1Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753708476; x=1754313276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3a1uBV2x/B6qd1DT74hySPSOiEOKWT23+YKC9TRgWs=;
 b=ojyfiFqOqqJPh0NqNg3/uevQpE0V5umnP1ePoTn/ET9qJ2E/kZZpjZSN4w4nfNf/LC
 nJXEGHp4YvQ3tQZc/TEXm1Ip286etBNorHa+GLOdQ/Sl5zJlND2VFsQUNQeEh+daEGbs
 AB8woafcL43KQFaBE+jZjmzvvE+xC44B0db4eJIGY0EaayMhg6ezu7gr/sXPg1LrjiIb
 dGNDv9lxieRYFxliu4ACy/+vF8VDqIsXZsf4NF2X/jSydjL+WZHM0Jgrkghc2mjM9FwW
 UJPQF0KpX6i3du98Oq0S7tA0J2itQuyTgp3ADuO45MVLCd13r4Q+yu8spCM00QLp5M4O
 e6cA==
X-Gm-Message-State: AOJu0Yw/aJJRAlQ8ZtVEvBD9ZNA05h6vavpjfelC1qutGIDfGlm3RE6t
 PR4nXzLYEVgeKM8TTZB1MHt+QGSwOLii3XyhYACfzsBG6O86QJSaj2KZMc9kVPBp1vCXUeo1Ydj
 8vVpC
X-Gm-Gg: ASbGncs3GQT14f7cT9pCTKXHpGQYN9r5QZcYy3sNRKZNfV0HIKBZAfZbviZpDnipfWb
 dNfBi/3wgl+55Hl14HUXUowu5erZd2m5a0sCGA3G3x346sK3FGNOUristtKEP9s4HkSHlcGUTM6
 66QmQIHlMGHRz2F/o41vHTSdoLW41azDQu6WptCRxw6Tg76gzP+UKgX9OiPWXx04KFfq6AaDYRw
 DHnlfeZNalWPbR3qDb1xso0ylyADJ/+F+SyecNYrVy6GpcZ2lFQ/Qe6prI7w+xa/4XBofJI9yXe
 t240/XSysGUFHq8ZvyAa4ssSjPiosx/V8VMFXU1EqGmZQmEujl5Dc5TWFIK/z7VL2GnypfNDKT5
 nS4yCFEUfrlwbU/fausnn3VP/5AiOUPU002G7/d3H4Cc3/K+Zr4JfJwTFprKBbUv1h4T47Lih30
 E=
X-Google-Smtp-Source: AGHT+IGXI7d4aO396Kthf4E1BrApfpvuOgyT1rnnhrk/y499vJNnVQmCNXpux3GtzyJXipBtnyBm4A==
X-Received: by 2002:a05:6000:1aca:b0:3b7:5985:51f with SMTP id
 ffacd0b85a97d-3b7766746e5mr8639240f8f.44.1753708121064; 
 Mon, 28 Jul 2025 06:08:41 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3de8e.dip0.t-ipconnect.de.
 [79.195.222.142]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eb9bdfsm8681849f8f.20.2025.07.28.06.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 06:08:40 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] treewide: fix Casey's name
Date: Mon, 28 Jul 2025 15:07:55 +0200
Message-ID: <20250728130808.15710-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.50.1
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

I updated the mailmap a while back but it's nice to have authorship
comments adjusted too.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS                               | 4 ++--
 arch/arm/mach-snapdragon/board.c          | 2 +-
 arch/arm/mach-snapdragon/capsule_update.c | 2 +-
 arch/arm/mach-snapdragon/of_fixup.c       | 2 +-
 common/button_cmd.c                       | 2 +-
 doc/board/qualcomm/debugging.rst          | 2 +-
 doc/board/qualcomm/phones.rst             | 2 +-
 doc/board/qualcomm/rb3gen2.rst            | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f31dc74bec1e..c4eaba58a901 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -653,9 +653,9 @@ F:	include/configs/sc5*
 F:	include/dt-bindings/pinctrl/adi-adsp.h
 F:	include/env/adi/
 
 ARM SNAPDRAGON
-M:	Caleb Connolly <caleb.connolly@linaro.org>
+M:	Casey Connolly <casey.connolly@linaro.org>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@kernel.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
@@ -1793,9 +1793,9 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFETCH
-M:	Caleb Connolly <caleb.connolly@linaro.org>
+M:	Casey Connolly <casey.connolly@linaro.org>
 S:	Maintained
 F:	cmd/ufetch.c
 
 UFS
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index ec51ebbbe7f5..fc921a4be269 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -2,9 +2,9 @@
 /*
  * Common initialisation for Qualcomm Snapdragon boards.
  *
  * Copyright (c) 2024 Linaro Ltd.
- * Author: Caleb Connolly <caleb.connolly@linaro.org>
+ * Author: Casey Connolly <casey.connolly@linaro.org>
  */
 
 #define LOG_CATEGORY LOGC_BOARD
 #define pr_fmt(fmt) "QCOM: " fmt
diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 4dced4961b68..3699d91852d5 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -2,9 +2,9 @@
 /*
  * Capsule update support for Qualcomm boards.
  *
  * Copyright (c) 2024 Linaro Ltd.
- * Author: Caleb Connolly <caleb.connolly@linaro.org>
+ * Author: Casey Connolly <casey.connolly@linaro.org>
  */
 
 #define pr_fmt(fmt) "QCOM-FMP: " fmt
 
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 328c7812f307..eec2c0c757e0 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -12,9 +12,9 @@
  * DT designed for Linux, run U-Boot with a modified version, and then
  * boot Linux with the original FDT.
  *
  * Copyright (c) 2024 Linaro Ltd.
- *   Author: Caleb Connolly <caleb.connolly@linaro.org>
+ *   Author: Casey Connolly <casey.connolly@linaro.org>
  */
 
 #define pr_fmt(fmt) "of_fixup: " fmt
 
diff --git a/common/button_cmd.c b/common/button_cmd.c
index 72dac1f9ef6b..a6c437d7a346 100644
--- a/common/button_cmd.c
+++ b/common/button_cmd.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2023 Linaro Ltd.
- *   Author: Caleb Connolly <caleb.connolly@linaro.org>
+ *   Author: Casey Connolly <casey.connolly@linaro.org>
  */
 
 #include <button.h>
 #include <command.h>
diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
index 1c35d1909d12..c3289c9e4e34 100644
--- a/doc/board/qualcomm/debugging.rst
+++ b/doc/board/qualcomm/debugging.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
-.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
+.. sectionauthor:: Casey Connolly <casey.connolly@linaro.org>
 
 Qualcomm debugging
 ==================
 
diff --git a/doc/board/qualcomm/phones.rst b/doc/board/qualcomm/phones.rst
index 1d27196cf540..8afc75877317 100644
--- a/doc/board/qualcomm/phones.rst
+++ b/doc/board/qualcomm/phones.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
-.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
+.. sectionauthor:: Casey Connolly <casey.connolly@linaro.org>
 
 ======================================
 Booting U-Boot on Qualcomm smartphones
 ======================================
diff --git a/doc/board/qualcomm/rb3gen2.rst b/doc/board/qualcomm/rb3gen2.rst
index 4240606224f5..518d01c4c3a3 100644
--- a/doc/board/qualcomm/rb3gen2.rst
+++ b/doc/board/qualcomm/rb3gen2.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
-.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
+.. sectionauthor:: Casey Connolly <casey.connolly@linaro.org>
 
 Qualcomm Robotics RB3 Gen 2
 ===========================
 
-- 
2.50.1

