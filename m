Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBEBC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6768788B81;
	Fri, 19 Jul 2024 12:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NzMUEU/X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KCHdea7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF041887CE; Fri, 19 Jul 2024 12:30:16 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC73887CE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WQQsy65sVz9smQ;
 Fri, 19 Jul 2024 12:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIaokK4YiwLZHUl5ITHrezdzPImXARsSPveVUdjSkEE=;
 b=NzMUEU/XaRJJAzm6BC8YMLVzgPcFahLEPcRFsZBktxnmc5G810dvDYd+Rtd9byJuoJgnAD
 iBuCax1c1kJERjnDHpJx3u1Xu7H/EdsRvpjjLoysQvE4R9gUw9+WWTuEoJByZl3OR3wFJi
 X97BkTjx4SINbMipf0u/nfjaLk6FATLFKsOtFeBXRAM5xckN4NKR57iOyd0g69gCrYq72y
 6xfeQCMlUN9xtLv/QhcvsZ1ALeuuG/X5eu3disdgocSqhioc/Q87eGlyN7MTlRiNx3BLjw
 /AX+lqamwEdt1EVPDb6PB/QQMo7K7KkCSQYOGt55Ja1n+Et+Xyhhzdzu7U1U5Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIaokK4YiwLZHUl5ITHrezdzPImXARsSPveVUdjSkEE=;
 b=KCHdea7/ri56/qAyyiV4mn2OO9YtN4K5risxl99fkX8m9jB1aM4EXC2JHV1RsMxPNHpA1E
 ZM3ezmbVrK3j/ENbKQThYfmj0+/LnCsS5KFoWPe0HeQzZMOU6EFX/UZAz2kT8zrXxQmRvR
 SaWyImIzAEh987OikqXTLLmNQoA2uqpdqW/i2jiJ7LPSENC7sTe4M7T3LyOYvxzABGNhtS
 mfKBLhQv40Yur3QEoHd6Vw8iXmKNuu1YtiVgmyz69TouzyLVUU1aUzmWx/VVdh7i//BwCu
 48a2vuJjfOPya26xXOqoRBITTFWHGsLCHNYtnxVGRll8mzQmACPq5tleYgZFPg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/37] board: altera: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:27:57 +0200
Message-ID: <20240719102934.322997-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c5z96e64afxgn1p6zddok3a5zd1ypp7d
X-MBO-RS-ID: 6ca2d5d86b3e29c2e79
X-Rspamd-Queue-Id: 4WQQsy65sVz9smQ
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

