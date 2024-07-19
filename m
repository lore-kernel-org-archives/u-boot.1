Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F8FC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525D688BD0;
	Fri, 19 Jul 2024 12:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HxUMMHER";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HxUMMHER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED7A88B8A; Fri, 19 Jul 2024 12:50:28 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6D588B33
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKG16pDz9tXg;
 Fri, 19 Jul 2024 12:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaVO2hV1otlHhUZu+PIc10WYUshPrH+CR95MSMqZa28=;
 b=HxUMMHERSn4rx6Zpeb9iC3i4yKTQJ/RhwxwsKG9/ApvZS6N0XAicGHS1qcdx8PqRHhh744
 Rpfr1YsTg+yTWtf5GcOXcqIM0/Wxa2d65XgGKQHjzCiYPAZlbIMbgfn0v5LH+BZ2ETV1KG
 MbuG48+EQTA9oT5GrClEZh8KwTM3p7I43XP79zGWhKUKbj2Xy6iv0narI7gMPuFjNcewvh
 92AGzzyB40vNgsmcEiungPwI1cBfcTxqD1OZxxfjAHqAP//e5XE+s9KxQig36aFP/fQ6re
 BU7jScmjhhUW3iKS614ip/1RXbFGTLOy74vrBsmM17nG52ZilYYyoicxs/OCiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaVO2hV1otlHhUZu+PIc10WYUshPrH+CR95MSMqZa28=;
 b=HxUMMHERSn4rx6Zpeb9iC3i4yKTQJ/RhwxwsKG9/ApvZS6N0XAicGHS1qcdx8PqRHhh744
 Rpfr1YsTg+yTWtf5GcOXcqIM0/Wxa2d65XgGKQHjzCiYPAZlbIMbgfn0v5LH+BZ2ETV1KG
 MbuG48+EQTA9oT5GrClEZh8KwTM3p7I43XP79zGWhKUKbj2Xy6iv0narI7gMPuFjNcewvh
 92AGzzyB40vNgsmcEiungPwI1cBfcTxqD1OZxxfjAHqAP//e5XE+s9KxQig36aFP/fQ6re
 BU7jScmjhhUW3iKS614ip/1RXbFGTLOy74vrBsmM17nG52ZilYYyoicxs/OCiA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/37] board: davinci: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:47 +0200
Message-ID: <20240719104948.323791-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1dhxi93rth6xa86jmgocpkk5p48o9ru8
X-MBO-RS-ID: e5441f64105b664d019
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/davinci/da8xxevm/omapl138_lcdk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xxevm/omapl138_lcdk.c
index 607e05ad9ae..03c34455c50 100644
--- a/board/davinci/da8xxevm/omapl138_lcdk.c
+++ b/board/davinci/da8xxevm/omapl138_lcdk.c
@@ -167,7 +167,6 @@ int board_init(void)
 	/* address of boot parameters */
 	gd->bd->bi_boot_params = LINUX_BOOT_PARAM_ADDR;
 
-
 	/* setup the SUSPSRC for ARM to control emulation suspend */
 	writel(readl(&davinci_syscfg_regs->suspsrc) &
 	       ~(DAVINCI_SYSCFG_SUSPSRC_EMAC | DAVINCI_SYSCFG_SUSPSRC_I2C |
@@ -195,7 +194,6 @@ int board_init(void)
 	       &davinci_emif_regs->ab2cr); /* CS3 */
 #endif
 
-
 #ifdef CONFIG_MMC_DAVINCI
 	if (davinci_configure_pin_mux(mmc0_pins, ARRAY_SIZE(mmc0_pins)) != 0)
 		return 1;
-- 
2.43.0

