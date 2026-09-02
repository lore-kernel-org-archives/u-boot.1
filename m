Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87581C61DD3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 00:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 390F940753;
	Wed,  2 Sep 2026 00:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwEtknRDg9du; Wed,  2 Sep 2026 00:03:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788307423;
	bh=i5cG60JUn4F71k97n79KTATlR5HHZArans6w4LF33Ms=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WwxYrVeHRbyMzmvXMe8W7B8dhetUdM494zieWaU4JswaSwYP3nMJyu+R5i0xVEuQe
	 4IAKEEiZnRQOkxbADU5boBhVTlAKClNMFZ5dDD2GCi1FI24MZbp8g7glONBD0wyCIt
	 SRkooxQjxjdsapoa5jP5IuE4EDhGDYj8vocnIN/qdHEAOwAIbKjSLrhgtlW+UQXUu2
	 XYe+dzi2Y4OZN1/6pogclsaClTwr9v/rhs5TrprrxTVibXcttLmbZcKwA3/TA4kJhQ
	 GoHxLW3KeQG2kyfrriOkCs6BSlRMj/o5p5XZPzuYPuEFv1spN48yBlu2I8rQTPcq8G
	 YMmwZXRcMOmpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CC0F40756;
	Wed,  2 Sep 2026 00:03:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 726532FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6401B40756
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mxs67-dP_2a4 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 00:03:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=qfgh6Elx; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=TVMmzESG
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B6C440753
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 00:03:40 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hZNHG1vZczKmDD;
 Wed, 02 Sep 2026 02:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i5cG60JUn4F71k97n79KTATlR5HHZArans6w4LF33Ms=;
 b=qfgh6Elx2zZkWdj+/4+m46dc7pdS+G3F5BmRiys/Z84rH1KQnw6dgWShk6jZHhWD5D6S5s
 EWKQRHWvUfjpN361eUhu71MjVPhD2ovGtjASW2ZSk8Mla0qtHcweavW0Vn+AgqEX/KxrDg
 a9MbHRtkXsdLEXbfyqT5zC+uTRfFPUgJXHfFGhTLkuFjO93AtHDiyfZh1vziIZ78n5dKwx
 cM/7sPmd7yOsmZQsyiSugXrrZeIUc+n3G9Tnkw8D6JQV566ocU/lCYwe3F18ga5Ah+q9zk
 WEukD7AyXlq6YOfgEAkSETLke6aKipQ5uL1W1TP0to5HyGdl+tWSWM8xgM5SOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i5cG60JUn4F71k97n79KTATlR5HHZArans6w4LF33Ms=;
 b=TVMmzESGobDFMYhWHi0jCoy3qLGcbMdWOFSakCtdRBxaTh7PhzuHxQUhrufGCbH5GVrUs4
 X7OLU8zp42BCOaHg03GgdU8gPtfjxsSGqu9dSBmPcrmPZXyicS+03nqBYKHj11/TRAo8GY
 kMHCbe+MIaIQEmoJlljlKlXE2tR7/3/lQ8hVjnCzY3REp2p51pFmU1STI/mnDpyL8UxjFy
 Riw/lIV1d5QhlF5y5IpLQS+bizukHL7JhvJ/iazFxlSC2xzJ+m9iFQY5l+yZ9qbdWnmaYx
 zFkdZ+TRqichXFt/m+9KTJA4YoeZ6RtnoPdhFCEM+MgqFF63ktjHou2stbL14w==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Drop empty board_early_init_f() from Renesas
 R-Car Gen5 common code
Date: Wed,  2 Sep 2026 02:03:15 +0200
Message-ID: <20260902000335.350866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jmi1nnzdtqfgx4q6p6rgfr63tncmer6e
X-MBO-RS-ID: d9ab3de810e86bebcd3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The board_early_init_f() is empty, remove it, and instead disable
CONFIG_BOARD_EARLY_INIT_F configuration option to prevent the core
from calling board_early_init_f().

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 board/renesas/common/gen5-common.c | 5 -----
 configs/renesas_rcar5.config       | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/board/renesas/common/gen5-common.c b/board/renesas/common/gen5-common.c
index 51bab2aa19e..1d7e7d2ab15 100644
--- a/board/renesas/common/gen5-common.c
+++ b/board/renesas/common/gen5-common.c
@@ -25,11 +25,6 @@ static void init_gic_v3(void)
 	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
 }
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* Allow WDT reset */
diff --git a/configs/renesas_rcar5.config b/configs/renesas_rcar5.config
index fbf158dfdb3..14fbe68655c 100644
--- a/configs/renesas_rcar5.config
+++ b/configs/renesas_rcar5.config
@@ -6,6 +6,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
 
+# CONFIG_BOARD_EARLY_INIT_F is not set
 CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
 CONFIG_CMD_MMC=y
 CONFIG_DM_ETH_PHY=y
-- 
2.53.0

