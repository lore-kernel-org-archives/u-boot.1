Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F604C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E7F807D3;
	Sat, 18 Jan 2025 12:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EDOAwtld";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LQnTfdsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EB380790; Sat, 18 Jan 2025 12:17:01 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C9D80762
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZvFR5pL4z9ss2;
 Sat, 18 Jan 2025 12:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04VAYFpho0mfDi6yuXi7SmVoUowwHBoVG7WtDkS+daI=;
 b=EDOAwtldKf3x1jX6vuds8a709fipRsBUOTdfwwZwlXGb/yikUdF2Lc6bnM7Z/r5+kyjxvF
 CghUdQlgBJPke7HbCQPsIRt2Agts5X9gx7Rk9KFHxMuDT117JGNawyM7/sayJAPvPVwhNU
 NYBXh/xijTEJFLX13TRjn9lT39WCplTpjEezsuBqs80NGQ5ZTvEnx1ozhRL57po4rB2H+F
 MzDWaj/ct5uPQth/RpSaIE8z1b85X+9WkWSkjJaIxlxvqKd4Gram365jx9eL96W8bcI4f4
 UkLqA/2O99qfEXoZx9xJLx24UxCuHL/TBMWYHzYnc9b1ClwT6ULNJMMYXTdVSA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04VAYFpho0mfDi6yuXi7SmVoUowwHBoVG7WtDkS+daI=;
 b=LQnTfdsHGJH+Yf/igPUtSs5uNtptCw2tZCt3HISbDLBY1bz3UsVg+dV+GkOHptK+W8mSUu
 XrrFOXkPQDDPZVkgmCBHHcihkDRwaLMbWz8+IpVybEQ/asws936YDrh7cR04w2ZwkpEgEy
 lqCc8dKQxYoHde4yT6ZmbVD2vyvbqEz0L6oKLVmfS9LqKY2oSJ9H2iNlv+nalSbKJ+kQct
 Z4gmgOJGlOYDPT8SLM17hXnYR/n6jJXg1D/c6tK6bFzxQjgxvOLKnsadBef2PQtu/PKzlp
 A7wT71b7MU0WC1UguHnY8lxtS2d+ThechYTdNgWCQUieMihX7CEB2N9todJvwg==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/8] arm64: renesas: Drop unused code and clean up headers
 on ULCB boards
Date: Sat, 18 Jan 2025 12:15:29 +0100
Message-ID: <20250118111621.362188-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zg91rkax4utj7j5zzna74qonrun1rh3s
X-MBO-RS-ID: 80d72144132388109df
X-Rspamd-Queue-Id: 4YZvFR5pL4z9ss2
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
V2: No change
---
 board/renesas/ulcb/ulcb.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 64f01b123cb..3f6db0ec3fa 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -6,37 +6,15 @@
  * Copyright (C) 2017 Renesas Electronics Corporation
  */
 
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

