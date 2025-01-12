Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5BCE7719E
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C7E806B7;
	Sun, 12 Jan 2025 23:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ED9oFLqi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e5HjVf/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC36806DB; Sun, 12 Jan 2025 23:36:01 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA6BB80079
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YWVbg4lC2z9scw;
 Sun, 12 Jan 2025 23:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4YUcSR5QmBn7Oepvp+c47lxKcOG2Fs9nvBk9VtVGTw=;
 b=ED9oFLqim7uYYSv1EVVMfAfQf3VVgYQ2KJLg3ySkYEfdj1EXjiapRS70r7AtJHdfOerZ8L
 rYKbEzuW0jhcVEaFUTCHXn4v7bkqvg7N8OLdcVQSE8fqGBa+pjLANoLDVcdZgMV9Jmud0S
 fDk+S8V4DBcKcQz7she21nE6REd9ATbfo+fHZTFYpZKBd3I8nrNuNm5K1lIBXbldL/Ovaf
 kjRkzQsirnXqE3zgzynux3wvX+qrhpmhO2F4SxJeSGyZgHJBnwEL6m4eHqd77CKeMYPhH3
 uLYy51i+uKPkh+snLMHeg7QSiTki9pVcjd2KNZABU0QEq0RJonlOayoTdfeUlg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4YUcSR5QmBn7Oepvp+c47lxKcOG2Fs9nvBk9VtVGTw=;
 b=e5HjVf/t1eq/IDQK7CEQOjfqpIiGsFGjYqeh+8D3MTRKUSRGkNMk7pVMlxpug8FFO23xz5
 8U0KvdoL5e4L347mAbP1Y9kYc6/In1/OXTbq3N7358tucEAChGYO5kLGUJV1YeXVa+zItm
 ItCv332Vg5rGpPL2+HRs5Vi+3v7xzokyGuLhuduE03IWwdq7HdKmzwc9yhfQx80XtmRylr
 +nmdAIYBA/GCXTt4UMI1zlQbbKH75ETOUzSGQMnnIEdd5eAgJDLoelFOKkwfHTLpulhO2o
 1aYf3ib06wDzAvADe6JAYuBOQnZix8K3PzK9UTP/KfOXPKr3Nx3hK7q2Ft8wpQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] arm64: renesas: Drop unused code and clean up headers on
 Salvator-X boards
Date: Sun, 12 Jan 2025 23:34:24 +0100
Message-ID: <20250112223528.179828-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p3hdqw59og3jtnadnx37ukuoyun8kdk7
X-MBO-RS-ID: 93835000473580e815b
X-Rspamd-Queue-Id: 4YWVbg4lC2z9scw
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
 board/renesas/salvator-x/salvator-x.c | 38 +++------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index b6fb106ca5d..abb17c3fdc5 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -9,41 +9,18 @@
 
 #if !IS_ENABLED(CONFIG_XPL_BUILD)
 
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
@@ -67,13 +44,6 @@ int board_init(void)
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

