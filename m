Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502BBC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8189A88B93;
	Fri, 19 Jul 2024 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LweSiFOs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LweSiFOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C78188B92; Fri, 19 Jul 2024 12:50:21 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A19D88B80
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRK70vvwz9sPv;
 Fri, 19 Jul 2024 12:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIaokK4YiwLZHUl5ITHrezdzPImXARsSPveVUdjSkEE=;
 b=LweSiFOsFmDnHPGPCXDvIdAZOzc2i0IYJno2mT/FIeemBUEMBItyquqjxesP4E7n/2l8jv
 vCeN+WImyscCQN0kVbIMEwpvWxHDRaez75ENY5C/alQVvUZ6WaxkHcUP14gNxujcUszCcs
 kyX4pYOMwqIcg7976dESciG7+tSvxUARDbLjyMMRky+HZXAQGAEzkm+1vm8gx1O59mMOCm
 /m4h23rI37fynZvyfRTVwIbvBHILMZ9Elax67RoAze3hjJfjJ9U1OmmZL1a/8BAGnLnW6a
 +2Q+3XLZQStF25iU8sgz2cEcZnLDrLhCEBGGfZ+t6Qur/LE1KcqMSapUzmoQnw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIaokK4YiwLZHUl5ITHrezdzPImXARsSPveVUdjSkEE=;
 b=LweSiFOsFmDnHPGPCXDvIdAZOzc2i0IYJno2mT/FIeemBUEMBItyquqjxesP4E7n/2l8jv
 vCeN+WImyscCQN0kVbIMEwpvWxHDRaez75ENY5C/alQVvUZ6WaxkHcUP14gNxujcUszCcs
 kyX4pYOMwqIcg7976dESciG7+tSvxUARDbLjyMMRky+HZXAQGAEzkm+1vm8gx1O59mMOCm
 /m4h23rI37fynZvyfRTVwIbvBHILMZ9Elax67RoAze3hjJfjJ9U1OmmZL1a/8BAGnLnW6a
 +2Q+3XLZQStF25iU8sgz2cEcZnLDrLhCEBGGfZ+t6Qur/LE1KcqMSapUzmoQnw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/37] board: altera: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:40 +0200
Message-ID: <20240719104948.323791-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i8m4wconzkenpfy8k713k4eys5o1iq4q
X-MBO-RS-ID: 9fce352bd5c9ee62253
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
 board/altera/arria5-socdk/qts/iocsr_config.h   | 1 -
 board/altera/arria5-socdk/qts/pll_config.h     | 1 -
 board/altera/cyclone5-socdk/qts/iocsr_config.h | 1 -
 board/altera/cyclone5-socdk/qts/pll_config.h   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/board/altera/arria5-socdk/qts/iocsr_config.h b/board/altera/arria5-socdk/qts/iocsr_config.h
index f201ad34587..9bd3e1b5abf 100644
--- a/board/altera/arria5-socdk/qts/iocsr_config.h
+++ b/board/altera/arria5-socdk/qts/iocsr_config.h
@@ -691,5 +691,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004100,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/altera/arria5-socdk/qts/pll_config.h b/board/altera/arria5-socdk/qts/pll_config.h
index 7fe290b28d9..902caf450d3 100644
--- a/board/altera/arria5-socdk/qts/pll_config.h
+++ b/board/altera/arria5-socdk/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 2
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
diff --git a/board/altera/cyclone5-socdk/qts/iocsr_config.h b/board/altera/cyclone5-socdk/qts/iocsr_config.h
index a571fb3e509..6df8cdb12dd 100644
--- a/board/altera/cyclone5-socdk/qts/iocsr_config.h
+++ b/board/altera/cyclone5-socdk/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004100,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/altera/cyclone5-socdk/qts/pll_config.h b/board/altera/cyclone5-socdk/qts/pll_config.h
index a46d124e9e9..59a9dcfdb61 100644
--- a/board/altera/cyclone5-socdk/qts/pll_config.h
+++ b/board/altera/cyclone5-socdk/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 4
 #define CFG_HPS_ALTERAGRP_DBGATCLK 4
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

