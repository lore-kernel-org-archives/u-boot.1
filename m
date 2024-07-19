Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F56C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DB288BD5;
	Fri, 19 Jul 2024 12:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UjSZFM/z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UjSZFM/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7120C88BD3; Fri, 19 Jul 2024 12:50:32 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720C788B33
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKK1KVPz9tVL;
 Fri, 19 Jul 2024 12:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BCbM2yhWwPhPzFoTFv34nhJMlU+R043xVkVg9btMjo=;
 b=UjSZFM/zWAdTp1qfKN2uUS4x8FIBMuxKl81CkjuGbLVUAhTM+98Oy+AIly8fqtRcoy4wGk
 LdsaqUun35vEqLj5QqtU3k99gM2LJtwGwTI7XZyLiuy+GPJMZ07dl/ROkJTFhoMSEDDSi9
 13lTKlUbGkFbDYv4MwOqTDxELmu82AOhtOFAgYkvh/6DMmoV/9TSEdvGPohNdYLoMhBZeB
 Mip64/sk+jkOFVLEaw77g4G5kVxzcUPWo7bHI+/2hWptW2ROrMHwHsKD5JjLh2kBaaZM2+
 dz+snjmv+SLO3N3GLNFr0QPNWBuyRlZCCEochGAVM8pu5YGaH0N82KGtkRtjOw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BCbM2yhWwPhPzFoTFv34nhJMlU+R043xVkVg9btMjo=;
 b=UjSZFM/zWAdTp1qfKN2uUS4x8FIBMuxKl81CkjuGbLVUAhTM+98Oy+AIly8fqtRcoy4wGk
 LdsaqUun35vEqLj5QqtU3k99gM2LJtwGwTI7XZyLiuy+GPJMZ07dl/ROkJTFhoMSEDDSi9
 13lTKlUbGkFbDYv4MwOqTDxELmu82AOhtOFAgYkvh/6DMmoV/9TSEdvGPohNdYLoMhBZeB
 Mip64/sk+jkOFVLEaw77g4G5kVxzcUPWo7bHI+/2hWptW2ROrMHwHsKD5JjLh2kBaaZM2+
 dz+snjmv+SLO3N3GLNFr0QPNWBuyRlZCCEochGAVM8pu5YGaH0N82KGtkRtjOw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/37] board: ebv: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:50 +0200
Message-ID: <20240719104948.323791-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: orpsxewteiiji7m848nemqm49ar4p5ya
X-MBO-RS-ID: adf72237e2bc816c8d1
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
 board/ebv/socrates/qts/iocsr_config.h | 1 -
 board/ebv/socrates/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/ebv/socrates/qts/iocsr_config.h b/board/ebv/socrates/qts/iocsr_config.h
index c24b5cb5f0b..d9a0c72044b 100644
--- a/board/ebv/socrates/qts/iocsr_config.h
+++ b/board/ebv/socrates/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/ebv/socrates/qts/pll_config.h b/board/ebv/socrates/qts/pll_config.h
index eaa18c1c802..baee1a922a8 100644
--- a/board/ebv/socrates/qts/pll_config.h
+++ b/board/ebv/socrates/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

