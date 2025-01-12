Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDDDE77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B368880212;
	Sun, 12 Jan 2025 23:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wKC2atTT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oNSTYwzM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE50780212; Sun, 12 Jan 2025 23:36:03 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D02806C6
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YWVbj0mdJz9scM;
 Sun, 12 Jan 2025 23:36:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymP4s6/bVD8uHdqmcT5V+Y/zq/RpjegJOk2mS6txhPU=;
 b=wKC2atTTRO32AltCOFKfIMngbZwL6XhLjFLBlnCVGBcFebvSMzj96+KureMpNXDHsjK1K9
 otJbpSzC2nIjXAP64OWCTp8rHPU/QP9nkrJhJQN6dgwqlD114aPLZUo1Tg77IKIy2oFh1c
 jFk8rpS90F5IKqTPqsAy2/lCfHARieTUCEY7+Jvv5t2875c++ghPtmOYhx2pwLF5bRbwj/
 RsksVT2+ohSD398ui2eaKWlcsn9CQP+sw1jMZPmcODgMFHROoGMUJb63C0j8KvFZlRqyHE
 jqrbhavFPyG2rUAcxLHMDjpBEWjOAMm0gQ3HfIlc3tE1kfedvznatCw/Ob3whw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymP4s6/bVD8uHdqmcT5V+Y/zq/RpjegJOk2mS6txhPU=;
 b=oNSTYwzMxsvEnawTwzuLR5h6Dwnx+oUuYEXkrDxIEA0g6SS8F992Q4Qa2CqtS5f+7+89S+
 eg7km9CrBTFeQGYh/OJDHeDPjCbw2oDs8YeNmbpru/IwzyemWnFJNVlMwge8Mzr4NuMaHj
 RFrB2/s8DrOzLPup9QQBr0Tucb3uB/R31zPA6ydp5JkDX7zMyxHhxH1CzW7UyGKebABHrb
 OLCty4MsI0RT4P91Vw/TEVkIXCfXsScdiWVSmIgNUeZmCdSmMp3fRvWJdtfJu28QBINIf9
 g4OoNFQQyY4Jmr4e/YuztRz4IngYc8cN9OF5bnrz7vGw7PdTkBcP5rljaqHUCw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/8] arm64: renesas: Drop unused code and clean up headers on
 ULCB boards
Date: Sun, 12 Jan 2025 23:34:25 +0100
Message-ID: <20250112223528.179828-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k6su7tobn1a8qcqc5bp91j9z5usizsw1
X-MBO-RS-ID: 0e2aa278a8b134f618c
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

CONFIG_IS_ENABLED(SYS_I2C_LEGACY) is not set on this board,
remove the code and also remove all unnecessary headers that
are included in this file.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/ulcb/ulcb.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index e1445adbb69..a441ff0e0d8 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -8,37 +8,15 @@
 
 #if !IS_ENABLED(CONFIG_XPL_BUILD)
 
-#include <image.h>
-#include <init.h>
-#include <malloc.h>
-#include <netdev.h>
-#include <dm.h>
-#include <asm/global_data.h>
-#include <dm/platform_data/serial_sh.h>
-#include <asm/processor.h>
-#include <asm/mach-types.h>
 #include <asm/io.h>
-#include <linux/bitops.h>
-#include <linux/errno.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/gpio.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
-#include <i2c.h>
-#include <mmc.h>
-
-DECLARE_GLOBAL_DATA_PTR;
+#include <asm/arch/renesas.h>
+#include <init.h>
 
-#define DVFS_MSTP926		BIT(26)
 #define HSUSB_MSTP704		BIT(4)	/* HSUSB */
 
 int board_early_init_f(void)
 {
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY) && defined(CONFIG_SYS_I2C_SH)
-	/* DVFS for reset */
-	mstp_clrbits_le32(SMSTPCR9, SMSTPCR9, DVFS_MSTP926);
-#endif
 	return 0;
 }
 
-- 
2.45.2

