Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189D4E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1570A8061B;
	Sun, 12 Jan 2025 23:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GPK//niX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gnY9arW9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F240806C6; Sun, 12 Jan 2025 23:36:01 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5931801F5
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YWVbf26vMz9sdZ;
 Sun, 12 Jan 2025 23:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S76ByUySpWK0t31PWYQR0SuDRRiwBDfa9ZJBLntkBPY=;
 b=GPK//niXIfdx9pPH7c7M1LLHPgmHbrQpZW7jEMVrbNlstPqSM3LPDbIGZyvhWRrWtNIVqs
 n0GDkbcZhYjkm5Ghjlp2HgXtlFYrmiO6WnY3nZ/1HtpK+Phrv/yTTc6xALt3IZhmePARlI
 xLr4WHWRRjdsNMSSaiEFwk4/yseGaS6weG0YWdFSNbXFBeEe9CM/wdzRuKKgzgibw6oZvP
 l/nBRE5v8L3hYQ4tevTIB6SIMfLD2jTVuw4Qj6LTHmNJPMtZeH2FYMU8/yIF0HKFDfMG3A
 CTgxLKjjW517gwUesTwDAPpACqIIJ053zUKDiGHj0UR/hxP3Crqb8qt+Rwh32w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S76ByUySpWK0t31PWYQR0SuDRRiwBDfa9ZJBLntkBPY=;
 b=gnY9arW9MPHjR1WgtNjUwu51bn8ML2l/72mfunipnbjtZJ2KuNRoKrhFgyMgPMNXnaV731
 TU1dnKRRkBQsTR30PBIn5iXsYNdTi+FjryrWc8VRBSotGkQH/XhEYY2FbG9dEXXTPta84m
 +ssTiYbkbWpAqZa/nXv+9mDzMeyXzbQBVCRlYMrW5WdffF18TgFjkJyiQkh+6StX5HVeP5
 475XRFffhSPjZGm8OZo6R4PAvuTgaczJx1BupBm+WJ6MSDrxERmSWMINNCOXT8SFBQKTMN
 h/FALqIloYbEsGTRh7QjkgtUoaW6oMQWhuRMJ88jr0J4xBgpmr+zGuPEaQs6rg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] arm64: renesas: Drop unused code and clean up headers on
 R-Car D3 Draak
Date: Sun, 12 Jan 2025 23:34:23 +0100
Message-ID: <20250112223528.179828-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d3dcc005a8b9edae9b2
X-MBO-RS-META: ztwsoh9bkjb4hi7ar9akoepdf8cdfiah
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
 board/renesas/draak/draak.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index b742b8d6220..a8c40ff1f07 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -8,43 +8,17 @@
 
 #if !IS_ENABLED(CONFIG_XPL_BUILD)
 
-#include <cpu_func.h>
-#include <hang.h>
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
-
-#define GSX_MSTP112		BIT(12)	/* 3DG */
-#define SCIF2_MSTP310		BIT(10)	/* SCIF2 */
-#define DVFS_MSTP926		BIT(26)
-#define HSUSB_MSTP704		BIT(4)	/* HSUSB */
+#include <asm/arch/renesas.h>
 
 int board_early_init_f(void)
 {
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY) && defined(CONFIG_SYS_I2C_SH)
-	/* DVFS for reset */
-	mstp_clrbits_le32(SMSTPCR9, SMSTPCR9, DVFS_MSTP926);
-#endif
 	return 0;
 }
 
+#define HSUSB_MSTP704		BIT(4)	/* HSUSB */
+
 /* HSUSB block registers */
 #define HSUSB_REG_LPSTS			0xE6590102
 #define HSUSB_REG_LPSTS_SUSPM_NORMAL	BIT(14)
-- 
2.45.2

