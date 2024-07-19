Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA465C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B954388BDF;
	Fri, 19 Jul 2024 12:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x0xmHhG8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qBzE2aac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128C988B33; Fri, 19 Jul 2024 12:50:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F18788B9E
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKG6wfpz9sls;
 Fri, 19 Jul 2024 12:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cswUZg2yKt6JLdpZihNtvrEqJPDKC/6Q7yijZm7pxLw=;
 b=x0xmHhG8dCnEJeU48vx6JcsR8lxI9v/xEPnpc0NloJmE1rPlXdg+Vx7SVSwcinr03+hBi7
 dRxkpGwMz78S4TQQHaPXi+gRXNES9QjADimc/J0XQNWaNsxJIn48yXAUUvcHTA4C3Z50A4
 Cpv7Gqq0QqNnvcgh3QRkcNXL31AwSeVDxaE0HnUswyyFI4EIcmlMzJ3m2jAt00yDOXeiMQ
 ekvTTR4a8oFSIpcmKzSltaeboaOuQwKggpb5yIATz/t6ri290lTTaPaDem6kW+UkUW6n2T
 R2nC7AIWEW+xbhV/1IbLD02utEml/0rAzX9QxLoJlHCbMIlnRJhVcEkbnXODVg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cswUZg2yKt6JLdpZihNtvrEqJPDKC/6Q7yijZm7pxLw=;
 b=qBzE2aacTzYokbcoENwU8LdEfRd7ZSymoeJ/nnqZe6sU2ebbzGUojNGe5G7WBvanLBTtvU
 K27y3zFfMUGVJdAQM0wT2CMjF9aqutYWiOMgW2q8nHfw8VEcHiBgr2nSd2dQkCUg+cUPsY
 24BqDYK/UciC/dk6NFLGlXn/yXwOiNmA4Qd0p78LJ0avOEXXX8YxhPrHvRNg3xSgnMORWS
 /+V0ZjkiZvEuLUwP5kJDr+kX0fpqzPiE91QKRImSzAD2VVU9fiQPPvNMAUYFLgPbsAavLA
 O/qGtme3kJC8CTSs+EJgbB/AhSE8jloRBc0Zxbb+HueAS0tCCs0ECoTLLLLQuQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/37] board: devboards: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:48 +0200
Message-ID: <20240719104948.323791-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iazkfs7881prcok6fkkhiygts5pin9bp
X-MBO-RS-ID: 174053b0567881195b4
X-Rspamd-Queue-Id: 4WQRKG6wfpz9sls
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
 board/devboards/dbm-soc1/qts/iocsr_config.h | 1 -
 board/devboards/dbm-soc1/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/devboards/dbm-soc1/qts/iocsr_config.h b/board/devboards/dbm-soc1/qts/iocsr_config.h
index 56b2130671a..6bec839e283 100644
--- a/board/devboards/dbm-soc1/qts/iocsr_config.h
+++ b/board/devboards/dbm-soc1/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/devboards/dbm-soc1/qts/pll_config.h b/board/devboards/dbm-soc1/qts/pll_config.h
index 104e324d8a4..52f1eb0c7b4 100644
--- a/board/devboards/dbm-soc1/qts/pll_config.h
+++ b/board/devboards/dbm-soc1/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

