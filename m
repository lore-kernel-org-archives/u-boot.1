Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B439EC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A0780657;
	Sat, 18 Jan 2025 12:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T31tj17v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PnDPxJUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5638807A8; Sat, 18 Jan 2025 12:17:08 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B518073D
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZvFQ1JdLz9smr;
 Sat, 18 Jan 2025 12:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nR8NxXnBkDGI7B0M5v0ZKF2/MQcTCBunMmk9LEUXA/4=;
 b=T31tj17vaSz03dD93bn0eqhpFaOceDgVt7Fad6iPyJEDiWDlnqMiT8LOtSgAS0tRz0RzA3
 fWkeH8WXQlqZSU/P2zVDhh3tQfkjBaU4QzYx0CZqlwnoxnEs1zZua+2mdb0BhdCHxHsANj
 hHy2+ulA+PY2UR0gMqBkvG02q2DsWSIzZfIKYu0IE1k1a+5lLHPXLlOVZ2eODZlgfoem30
 Tn7MUF7Z30tenJJELMcbeNvBuc9UmtimQ216u+C82AdEDpdAVxPRnU8O/3asBVsOmvGjNt
 pVDa9z85LfkV8pyBJju51h4PukDzbUM7k1H4sEPtjj/9eT6+XsGEAi3+htw3nA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nR8NxXnBkDGI7B0M5v0ZKF2/MQcTCBunMmk9LEUXA/4=;
 b=PnDPxJUt98Q0d1rH1YLbhoYwL4GULyRF1vJuloWw6YBfTMG8HI/mMbQ3mzB7Z9rysFkxKM
 wLOp9nAerWdHvCjp23ETTPA6rnY167Dw6j+s02wAZVhzK4KKgweTZEnplzSazm1iQm9q4H
 5INjgFvber3SG1csQWGJgJ7XaWRyqlwDcZeXs4DdPMTEC9Tu4qNJe3Y1sHC43kal9JsteA
 QN7RVErPvn3TXvb0Gxk5EhThyfX9hxD6TlGFfJoq3tMWlaBozaN7iNnX1x1OPzna8WsCKX
 vgvUKLl9v+crGAzSRDvywTtQKb8YafbbIOLjHn/lE3Zg0GlYpDqnQHns84OjqQ==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/8] arm64: renesas: Drop unused code and clean up headers
 on Salvator-X boards
Date: Sat, 18 Jan 2025 12:15:28 +0100
Message-ID: <20250118111621.362188-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a585179839f0e4b080
X-MBO-RS-META: 1xfmw9xsku88174fenb1ypju6aypcqe8
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
 board/renesas/salvator-x/salvator-x.c | 38 +++------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 2c8860bcee4..60f8b94e54a 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -7,41 +7,18 @@
  * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <cpu_func.h>
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
-
-#define DVFS_MSTP926		BIT(26)
-#define HSUSB_MSTP704		BIT(4)	/* HSUSB */
+#include <asm/arch/renesas.h>
+#include <init.h>
 
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
@@ -65,13 +42,6 @@ int board_init(void)
 	return 0;
 }
 
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY) && defined(CONFIG_SYS_I2C_SH)
-void reset_cpu(void)
-{
-	i2c_reg_write(CONFIG_SYS_I2C_POWERIC_ADDR, 0x20, 0x80);
-}
-#endif
-
 #ifdef CONFIG_MULTI_DTB_FIT
 int board_fit_config_name_match(const char *name)
 {
-- 
2.45.2

