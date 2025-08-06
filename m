Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29477C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 00:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5118144A;
	Wed,  6 Aug 2025 02:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s3POp37a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I3zEWLP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32708144A; Wed,  6 Aug 2025 02:58:22 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B2E83933
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 02:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxX2c5ypqz9sQb;
 Wed,  6 Aug 2025 02:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wURCgJ2zI8dbSXsv+b6bDPEVi57kDonnbhOFLrmfi3E=;
 b=s3POp37auzB3xk1yqiOins6aFb15pBewsKq9XsPqqyft+5JmBH1Mzx3MtFE5CCcFtJc/r4
 lgUwk/m5MnmVkLCdXH/dMDtN49oDc0QZf8vUqwSBbAtaZijFUOJwlDjEX6z1hjR3Swsu23
 h4DYauSTeQlsk3cS1go7/Zz/VONMgxozq7sm9IQlH/wEVZsLFY5Mcv+8gPxU3YYq1INB4/
 941hB0bP69p5AAxmn9NnBE3qVA7xxFcMsNYN6vEQMeVxdUwlGHA9QLjVehwHqd4/4GGWaZ
 ubs+LzI6MFB3+Wkcv02/eZjWjIb2nbOn4feprl9yZLhfQN25sEsx1pH7woTjGQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=I3zEWLP7;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754441863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wURCgJ2zI8dbSXsv+b6bDPEVi57kDonnbhOFLrmfi3E=;
 b=I3zEWLP7HRWCQvsFeVy9nEXTWV6x2k+DVfKHGxB8lV5LKOdXJhpVAKtYGEVvaJgeQcbbVu
 73GpQ7/Ya7EnlJjNWWPjFY1XJoxW4FRilwmKEg+0TObxaNk+oQMkcOKgUNCLdHvakzZUz0
 973c81OoEZkCf97AeeREUcDjj8zdptT4P9GbIUULx6N2WNnsarOuacldNmBNzttnMBJXVL
 eFmYEPaQNPIRKIjL3InJhLQyig2G1XxR1uSsTVHhuVLlJYn0ZjYgAQ1AhloSetLmPABg5v
 9Oz7aMqECqD5pxsvJ4wj6n9httLt23DXn3nupRcgcBfm1XgPDg9M5ANTw1XyAg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: r8a779g3: Disable dual-rank DRAM on Retronix
 R-Car V4H ES2 Sparrow Hawk
Date: Wed,  6 Aug 2025 02:57:14 +0200
Message-ID: <20250806005729.284162-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b6aed124f2bb5c83094
X-MBO-RS-META: hbp8m4rsfb5ifm34w1myczw7ik7a46ok
X-Rspamd-Queue-Id: 4bxX2c5ypqz9sQb
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

The R-Car V4H SoC before rev.3.0 can not support dual-rank LPDDR5 DRAM.
This affects 16 GiB dual-rank DRAM configuration of Retronix R-Car V4H
Sparrow Hawk board. Fall back to 8 GiB single-rank DRAM configuration
on such systems instead.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/sparrowhawk/sparrowhawk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index 871dad8172a..1fd7a63d2fa 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -116,7 +116,7 @@ dbsc5_get_board_data(struct udevice *dev, const u32 modemr0)
 	 * Use MD[19] setting to discern 8 GiB and 16 GiB DRAM Sparrow Hawk
 	 * board variants from each other automatically.
 	 */
-	if (modemr0 & BIT(19))
+	if ((renesas_get_cpu_rev_integer() >= 3) && (modemr0 & BIT(19)))
 		return &renesas_v4h_sparrowhawk_16g_5500_dbsc5_board_config;
 	else
 		return &renesas_v4h_sparrowhawk_8g_6400_dbsc5_board_config;
@@ -244,7 +244,7 @@ void renesas_dram_init_banksize(void)
 	int bank;
 
 	/* 8 GiB device, do nothing. */
-	if (!(modemr0 & BIT(19)))
+	if (!((renesas_get_cpu_rev_integer() >= 3) && (modemr0 & BIT(19))))
 		return;
 
 	/* 16 GiB device, adjust memory map. */
-- 
2.47.2

