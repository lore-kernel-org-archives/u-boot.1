Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5356C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D717807B6;
	Sat, 18 Jan 2025 12:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ibab7NkG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L6lGjt+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CA880756; Sat, 18 Jan 2025 12:16:58 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C57EA80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZvFN4Rn2z9sm9;
 Sat, 18 Jan 2025 12:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rltLTlQ7GaPFv+dwNhWOt8ng9RtlkOUGoLzGWS2pBQI=;
 b=Ibab7NkGGszpW+j/u7XUxQ3nudXItkLDrDI9zQB9FUf9aIoT/1B0zVE9vko6zesd2wIDgm
 X5imKA0fdrPFGWQRCNBpdXH811iOxEo/07QaydTxPfqvzG80cVADrezfdwTCPpKbcUDJT3
 bMAKUk0JNdLV7UwYi2QkX3NeKNmixmn1riefa0tYhnfo7Fp0bDoaLaPjDuyo/AM7T43HHx
 IDZlSFWkHWmrydW1Mw1fds0ClwyvTXwRPRUdcw27xvxAxf78JsCxB1hkCG+R0RXnqfytSq
 FSc4UH0C5Vy6eUPBi0uJLn8jQ4lrxqcbvz7opaPYhFUOkBxPreFztdu1UeXDxw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rltLTlQ7GaPFv+dwNhWOt8ng9RtlkOUGoLzGWS2pBQI=;
 b=L6lGjt+nBzGkbJBRo/QCCVuHOoF8ir1Tfj13LfIbEwzQUn8xZuFeCCy7DVdfKVPqukhA0W
 9J7gl0aN+zrChxEy9LPJF/hKrBnHg1dTDWKESdP2H3OtZG+B6LG5UIrbJd1FYIf1hPJDZx
 IgkYcvbKR8rzcuNhFuEQZANFw96v+M2RbrRxyp3OuPu5eudboOMDrBzaw92RiaO83bK3KQ
 osQ+hUlASX4WeLd18zpj1hjw7F3ntSE2bcISxwqv4rmMRpYMN7+H2QHyN2bJZ46HkYgGLM
 3PK+39PstZwAQFN08XQh7e/JtpJyIY456k9CxLUo9nx718RUtm2ghEoLfH2UZA==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] arm64: renesas: Drop unused code and clean up headers
 on R-Car D3 Draak
Date: Sat, 18 Jan 2025 12:15:27 +0100
Message-ID: <20250118111621.362188-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zshtnnth5za7p7wbmar1uwwk8go33ko4
X-MBO-RS-ID: d833d4dc83643949fcf
X-Rspamd-Queue-Id: 4YZvFN4Rn2z9sm9
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

