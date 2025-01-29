Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59D5C02192
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266A480BA3;
	Wed, 29 Jan 2025 18:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DqUKg8bx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W1C64U8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5258E80C99; Wed, 29 Jan 2025 18:05:47 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D32E80A09
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YjpSm3Fvsz9sb6;
 Wed, 29 Jan 2025 18:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tolwMxkzc3SX1slxHXSiZ8w8B/A6/XQ4c1vyCLdeg0o=;
 b=DqUKg8bxMkUMy6HpZNWMKFxa3OKyGUrLesrQo9K9xpUiiGfh38oYeHSitYQRsmAyxLjUvw
 SrwG9l3gZFhZE2zowk8BxKTtd0B0W1KbFmW9IGTmNHpS2NH7rkeYgepmfRqWa4LG1iTIyX
 B8PhCh8N17IzuyKNAAjD+u23uJ9vHybjv9QornR00nvBMWOjPYLI3E5jOeL5+nXIR6J5pp
 A5tqsBpjGRPDEc9+H6wAnmur78ThD9M9TKsnA/B12el+cpql2/2vTJbd+RgIrb83Jvb/lj
 NizYwiX0Kgy4dGtC2FkkjBtbOjdwC57UFa6JXIl2P7BSJtwlP3UPYAWWeCTVOw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tolwMxkzc3SX1slxHXSiZ8w8B/A6/XQ4c1vyCLdeg0o=;
 b=W1C64U8nukG2DfDtU9YDqNqTgpyy29W/kWYyEo0SfZTPi2qy/v9bdWK/FJdSwsX3IgvH1G
 sQqcIqwXMgbKSPTgzntY4+0qQgkcNJ+irHIJaK+3y4TwUImqcykw5VSk8KIXEcfAO3Xe8n
 mEJuGmlPb2hCjYaNZ2tV/CR8o6tdFDSwdbCDGsHNVqCyzaE8rPJ/40W1D23XcmSB0BVFHQ
 qw5icd5mr2+To41qgt9XwFBtSg+tH3xdHKNlqH0YbzuLHzefe7wq132KF8Z+8g2GP16T1O
 aTlrhXYm1EKan7Tf+yHlcvlntAY88w6KF7STJ5lURXuqqoVHn414p81cfb94wg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/9] arm64: renesas: Drop unused code and clean up headers
 on R-Car D3 Draak
Date: Wed, 29 Jan 2025 18:04:30 +0100
Message-ID: <20250129170514.82118-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 79f49df01478a173d73
X-MBO-RS-META: dofizarpfob1d6433m3ty7cnqbnntra9
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
V3: No change
---
 board/renesas/draak/draak.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index a51bf65674f..85213497ce4 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -6,43 +6,17 @@
  * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
  */
 
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

