Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12177C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565F388C25;
	Fri, 19 Jul 2024 12:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sp9OYVgI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bKrkxJfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70CF88C12; Fri, 19 Jul 2024 12:50:53 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F2288C2F
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKl4DYYz9sdB;
 Fri, 19 Jul 2024 12:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwlUa7VjDhf3H9qkJZO9HXzAuFN5IedaGnV8sVdEH3A=;
 b=sp9OYVgIq3IwlGapMdrIMqhcmMa/OoGFHcDmbhUnIqTRNS0NddfwNMxZxJXlJ7x1AWf19h
 wi7TRM0z43jQ1uMR9KLMFakTbWh14sjh3sz7D8JlT/4E/4hbrIPTnjXMtRvjGnloPV3m44
 yH76nqdhgJUIIvSP1s4qjWs3qAJ8uW8FAQZG0K7kqwSqp+K9tstY8TjbMDG2Pm/KsgGcLC
 TA/spKj0zXixYH2hHvojT0y6NSCMnOSBCBpztjma6IeGY+NDfvEit3HZDJ6MQmUo34zxUt
 mNQf3ZmdHZ+IwLxKK0uubwsXFSj7G3JIFVU0U16coTbQmjKsmMkFNGOs8V3tIg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwlUa7VjDhf3H9qkJZO9HXzAuFN5IedaGnV8sVdEH3A=;
 b=bKrkxJfv65LYZouHc84utAmPj0ZQyuSbkFxRtq3L5Ewxtkwmal7p3HMtQKEgTPgg6U5AYL
 bi7Lc4UDw83uUz+dRy6Brv0caFZMQ8UqnnA0P557vQhP5DJtOcTGdkqe76BGrnoYg4K0Ao
 1mY9pYI/xFy1YqDCLXgPRVkYQPvcoNQwu2EcSH9pF2qziPBqP2rDRHEg0dIHVVicSrR4/P
 Qpaw3KY4Ji7n61dUdhReG+OBrWAssMQ5Xe4s/YhjnfAi7nNLLgFj3zwQ5ZaxTzV+4Ctq/4
 s2DYzlxvcpHuic93gbEgocFyOuzDp77ZBoA86H206xol12el8pW4i9seqfgRYQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 34/37] board: ti: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:11 +0200
Message-ID: <20240719104948.323791-34-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1f615617d1ceb78a526
X-MBO-RS-META: ay8isutfzbyntczgmnfgduijqi8patis
X-Rspamd-Queue-Id: 4WQRKl4DYYz9sdB
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
 board/ti/am335x/board.c         | 1 -
 board/ti/am43xx/board.c         | 1 -
 board/ti/am57xx/board.c         | 1 -
 board/ti/ks2_evm/ddr3_cfg.c     | 1 -
 board/ti/panda/panda_mux_data.h | 1 -
 5 files changed, 5 deletions(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 34f4a919656..681002ba1da 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -339,7 +339,6 @@ static void scale_vcores_bone(int freq)
 	if (power_tps65217_init(0))
 		return;
 
-
 	/*
 	 * On Beaglebone White we need to ensure we have AC power
 	 * before increasing the frequency.
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 40b7fcfc387..431372954b2 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -336,7 +336,6 @@ const struct dpll_params *get_dpll_ddr_params(void)
 	return NULL;
 }
 
-
 /*
  * get_opp_offset:
  * Returns the index for safest OPP of the device to boot.
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index 48668884bdd..cc5e64c9879 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -515,7 +515,6 @@ int get_voltrail_opp(int rail_offset)
 	return opp;
 }
 
-
 #ifdef CONFIG_SPL_BUILD
 /* No env to setup for SPL */
 static inline void setup_board_eeprom_env(void) { }
diff --git a/board/ti/ks2_evm/ddr3_cfg.c b/board/ti/ks2_evm/ddr3_cfg.c
index fe350fee795..690c4e2731f 100644
--- a/board/ti/ks2_evm/ddr3_cfg.c
+++ b/board/ti/ks2_evm/ddr3_cfg.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-
 #include <asm/arch/ddr3.h>
 #include "ddr3_cfg.h"
 
diff --git a/board/ti/panda/panda_mux_data.h b/board/ti/panda/panda_mux_data.h
index ad9e36525b4..3bf6c0146c2 100644
--- a/board/ti/panda/panda_mux_data.h
+++ b/board/ti/panda/panda_mux_data.h
@@ -11,7 +11,6 @@
 
 #include <asm/arch/mux_omap4.h>
 
-
 const struct pad_conf_entry core_padconf_array_essential[] = {
 
 {GPMC_AD0, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)}, /* sdmmc2_dat0 */
-- 
2.43.0

