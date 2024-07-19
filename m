Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794A1C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FDAB88C2A;
	Fri, 19 Jul 2024 12:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g8kKdjj0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GP13KtxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C6288BD7; Fri, 19 Jul 2024 12:50:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E470988C23
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKf4Xr2z9sTf;
 Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFioGloRvb7MWXK5Fzwe5n7jBRa0MATMjx+5ULPv1QI=;
 b=g8kKdjj0lfxvTqVZS5Yijadd6QIHH10jQBR1dy9e4dMfjX0qXiigZfAvPoxsXtmSlAfpi2
 jC1zV9tWjET5X/LXQnSJDxjSQOoDEcM0XWjVPBcol3dY3e5b0R3slNyN9edi9OgNbiSxdb
 QYsrfltQ59YRM/Xa2K7rvLKEp75jKI7eLeJl4F43076encjB08EQHBRGBthdPZ8ycrn/Ny
 g+Vlg8W5lQHehiTId972v+DFX+kBPRQI+RGO6aVeChRNFYNT6WAoYDEWb1cKEOPQ7bpcuH
 m6Mn/9cwUnpWrmct5OgjVOOvwt7CGAfgqv78mNDIcguEDYo/ZEIV2g+balrBGA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFioGloRvb7MWXK5Fzwe5n7jBRa0MATMjx+5ULPv1QI=;
 b=GP13KtxIS7J0n+CjjPL1q0uUFgjH+7CCtgpK2Oo3IZIfDUE08vlFpNV3+Qxy62cfIPqgfa
 bqFsFUQzIoMnwdivQlPE8Hxigw3MkAMVk4QN74aK+Y5XhHlac30Eghu0h2jToEj8B1KqzO
 Hj2DhpSeceyKksaq0Vgc/T2qwpbR6O9Wzz3dBBcK7LVMfOWRDp6DybOc81KtBQjcxK+Dq2
 K4+ssCmkRPIEwvoAGQWL6eaSOIKpmyY6vqvRtosKg4HNZbJWTNeENIG3wC7njNQ7Dw3hjh
 gRAewXRpzHnv0VpgM1I/s1lM3z366hsbLuftmWXlLr9Elqdf2ysPPJFcHG4Yww==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 29/37] board: sr1500: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:06 +0200
Message-ID: <20240719104948.323791-29-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p8kc6fyrzmhczy6s5wr7a5zy5i6gd46t
X-MBO-RS-ID: 1a8240a8cd561682224
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
 board/sr1500/qts/iocsr_config.h | 1 -
 board/sr1500/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/sr1500/qts/iocsr_config.h b/board/sr1500/qts/iocsr_config.h
index 2622b960314..f94769bcbd4 100644
--- a/board/sr1500/qts/iocsr_config.h
+++ b/board/sr1500/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/sr1500/qts/pll_config.h b/board/sr1500/qts/pll_config.h
index 885fe91eeba..990432ac7f9 100644
--- a/board/sr1500/qts/pll_config.h
+++ b/board/sr1500/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

