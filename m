Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAA4E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42565801CE;
	Thu, 12 Dec 2024 14:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qSfpmFkZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Iaf7rX0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C16800CF; Thu, 12 Dec 2024 14:36:38 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD8D801D7
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y8D5b6SFPz9sw4;
 Thu, 12 Dec 2024 14:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3dcz4gwe54hCYI0BmU5rCoggxmiFUuwC1zvMCBQeRns=;
 b=qSfpmFkZs0iZWLGfSuI3CZZrq4ANd7fQQtVgBLM+1LHd2cAPtYFPwk2FRROhddxne3zUA3
 VIRenHFegQBZQ+EWq7CUjtqqfqHePiB2vHetx+h3umxqBku/aZCo6u3m+irYVjcVSbGKpa
 f4TnvIn3B+1j+wfspdRsHNcTOeUZSriERPBtIAITI/V0VNCJv4So5Z70Y++c2caLMJncV/
 n+fa+pKOZazVEsMZmjUfo4LhbYRyzM9sQ/FBOX1o/3y5QTCKZ45JbgQ/ctu1R/f2g+hzC1
 sAwvQbSeblPbpXXpQ45m8fuImmdVIxV6dF4HLn92akDkNkWDIj9mbIjpAWc4SQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3dcz4gwe54hCYI0BmU5rCoggxmiFUuwC1zvMCBQeRns=;
 b=Iaf7rX0El4PGGKzCoEzN6nhixogpKwW/Q0CvpQh6iTBAL2qYUWYiCUT9odpoRjKiAxDxwU
 iRF9PaCq36yCFln3dmG3UpNs+nvIRtsc9besIcw7OjCBqs+DyCU++bedU2PLqfSY9Tuf7b
 TsC6UWFPL9alwufOrOcjk61LlGNuHU6S22resyjSMp2rTulzxP6CVpYFzeWPpf75e97TSo
 TYwoQbDnK3DMJHuMvZRL6N3slSJIdIPBtehX/nAy33fYP8ETFI76QDkrkt96R10oMjIZGv
 haTWFUDoC4N87UzBFQU7RyOqAIp8gFe2uyXTmoorWN4+vkTt6ilNsnZBc8GS5Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Make stub PSCI implementation available on
 64bit R-Car SoCs
Date: Thu, 12 Dec 2024 14:36:09 +0100
Message-ID: <20241212133617.84336-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dh7q7ruip3qtdpsofix6oft6pd93o49o
X-MBO-RS-ID: bfb660209b51dfd15b5
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

Make the R-Car V3U stub PSCI implementation available on 64bit R-Car SoCs.
This implementation is useful during early board bring up, where it can
supplant missing fully-featured PSCI implementation. Note that this PSCI
implementation is very basic and offers only SoC reset functionality. It
is unable to enable or disable secondary CPU cores nor does it offer any
suspend/resume functionality.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Makefile                           | 4 ++--
 arch/arm/mach-renesas/{psci-r8a779a0.c => psci-rcar64.c} | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/arm/mach-renesas/{psci-r8a779a0.c => psci-rcar64.c} (92%)

diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index 71e12e00aba..317fce02d2b 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -15,8 +15,8 @@ obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o memmap-gen3.o
 obj-$(CONFIG_RZ_G2) += cpu_info-rzg.o
 obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o memmap-rzg2l.o
 
-ifneq ($(CONFIG_R8A779A0),)
-obj-$(CONFIG_ARMV8_PSCI) += psci-r8a779a0.o
+ifneq ($(CONFIG_RCAR_64),)
+obj-$(CONFIG_ARMV8_PSCI) += psci-rcar64.o
 endif
 
 OBJCOPYFLAGS_u-boot-spl.srec := -O srec
diff --git a/arch/arm/mach-renesas/psci-r8a779a0.c b/arch/arm/mach-renesas/psci-rcar64.c
similarity index 92%
rename from arch/arm/mach-renesas/psci-r8a779a0.c
rename to arch/arm/mach-renesas/psci-rcar64.c
index b6c49e731f9..a230692c9e0 100644
--- a/arch/arm/mach-renesas/psci-r8a779a0.c
+++ b/arch/arm/mach-renesas/psci-rcar64.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file implements basic PSCI support for Renesas r8a779a0 SoC
+ * This file implements basic PSCI support for Renesas R-Car 64bit SoCs
  *
  * Copyright (C) 2020 Renesas Electronics Corp.
- *
  */
 
 #include <asm/io.h>
-- 
2.45.2

