Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81D3C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C3B80EBB;
	Wed, 29 Jan 2025 18:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tuqGfPVP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XYY8U30w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D7A80EAF; Wed, 29 Jan 2025 18:05:50 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A4380646
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YjpSr0kSDz9st4;
 Wed, 29 Jan 2025 18:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIHzdp5/Mh8mUxuL20wpUACEeDTxMDE8uilgHLz29sg=;
 b=tuqGfPVP1FJ9TwbCMCGxwt0RoF59WVfr1WMRrMT4ZTArjCSZW4vGUMYfYxn9kgQy+8cNAd
 tVeTtLBV+7rguZRo/+XzHtrNJzX4UOmyMVb2SlPjsnSI+60M/NQPqt9r0v80imfLQsRknA
 NKf/H3wwLXrsm6ctgd3qKflBpvJOwF4w+IHnlan/tTApZXzMYxRoHpUaQklKPtgFpvWsvL
 vro9LSF31aayDbHS3WIpmawY6wCWTEhi4a1FJQYrTHTLhABKrA/28iNyBwiMb70yza0e43
 o5aeATwKKwud6Y/SqAIy7E08J5t+QXKr91eHQtzNn73i83ls0KM9lOZrH2goSQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIHzdp5/Mh8mUxuL20wpUACEeDTxMDE8uilgHLz29sg=;
 b=XYY8U30wozndI23kY6+PCf1T7F/9uFuMM6VyRkGl4r4INRypKkMlSn9uW8iFSP3ez8dolt
 GRFYS3UkSOhBoP8O3WCURrNRHTgCsH3f/KZzs94ZeK5db3Xi0Le9g9XD237bi803Qy9Uqr
 uZE2e1UBiAhdoXv70StJW6fwl39cvxdavCJRqtvjHNJCXQOPXnlsryaP5k9vTyqmsaxuLn
 65eYx7SZT4hqAIbTFmdgmbxg2BrB0bSnJ/K+NsvjzEar95YYr+Vg9TOuc7Z95ARLWHy3wn
 L+5JPriOigiXF3zKMkOv5ovWHSm+yfSA29r9yfADtqThoD+3qCfdmmwVtt9Xsg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 7/9] arm64: renesas: Drop unused code and clean up headers
 on ULCB boards
Date: Wed, 29 Jan 2025 18:04:32 +0100
Message-ID: <20250129170514.82118-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j18urqeuxg5fyenzt6tp554qimjt54qi
X-MBO-RS-ID: 21ea979b9649fcc82db
X-Rspamd-Queue-Id: 4YjpSr0kSDz9st4
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

