Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC1C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C4B88BAC;
	Fri, 19 Jul 2024 12:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KweWy6kc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pCwr2z/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC2188B89; Fri, 19 Jul 2024 12:30:25 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417A788BA2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQQt66vd1z9slN;
 Fri, 19 Jul 2024 12:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaVO2hV1otlHhUZu+PIc10WYUshPrH+CR95MSMqZa28=;
 b=KweWy6kc5FX+HaPQ81z7b5egGgea56Wflmk1qrotwVbrm8Fa2825TT1a7BuCgxULX2aEIb
 Fmn8uuI8e3v8URpdCV+AiAunQfV9rmlqSlXZ9fbM4YwlIpp/DZQKVVX0Cz01k9Y/cwKuqD
 kqKAB0c+LQ57FvfyMon7Ecx50Vr5MtpDu59URLYSL4Ag93Py4NZt/STHSCLUJGQIAafnXh
 z7FmmiZ5wSsCfuYoB0hxeY/MIan2zwk4pIkDR1RxDtQMcAj3RM8niakDjmkPHp5XuopA+x
 DC1ekEt4dJgY883fldhjG/O8PB778JHrTPx0Mzp9ftTDDenXW4eKs8U7WtkOpA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaVO2hV1otlHhUZu+PIc10WYUshPrH+CR95MSMqZa28=;
 b=pCwr2z/hmhHr4XRuNesA0sTsR6lrpLHK4nkyYJK18rC72q3oAWjCR2pWtGXK3ldfw75dHo
 hq9vu5iFBNAmflici2SouM1S0AxDvk7uCIOnTEb4okLxAx2OzDvqbcbceZludUwdXITPeR
 K0Su49gHEggz6FOPLp23NmHYZAYJH9xl8E/xDJhGOiM766PHDXFJLE3z3KwzmQX6FZ872x
 kpHiMl1n76wvqVgSkoRTF6RJam3pvvgYBORHA9FvwuZ0dzMSEhyqSiwjWdm/u8b5KaRHCT
 fbbk9H7LkFpSa7GGjIRNZ79EyrvN6bXaLEZzUhOdrr/5zyOxYoT+VVwGY2vE9A==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/37] board: davinci: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:04 +0200
Message-ID: <20240719102934.322997-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rufwb3uceqroxn8dub43t99iie3iy3np
X-MBO-RS-ID: 7168315468b080d0af0
X-Rspamd-Queue-Id: 4WQQt66vd1z9slN
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

