Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143DAF46114
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983CF841E6;
	Mon, 23 Mar 2026 14:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="IYu4q1Gj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2197D84150; Mon, 23 Mar 2026 14:48:09 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91CEE8419C
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ZrmKLBXvOhG/42GEp5hBVT+CjLWDuKxw5PQWWScltzo=; b=IYu4q1GjvJxyMxrI9LrC3vaXjq
 qw3DDJxgDQPe/kChTi9Q+fL9to7oQcCbqh+54qStcRskhUtA7Px238CumUbddV07qKq/N0cEjxdMJ
 Ctv/dA1Y7Xspnwkltef3YQztXg+4ap22TX8NVL2Ly3BNzHUuIIKp83sctgmjcGB4RqogJVYYHZ8Dg
 L42PQcH0Mw70Cx89Jaoue5xbEOY3hnTok62NCqS6v2H5FMS0cJq7GyCrjRELxUraFGnq6eaZR8eZz
 Nj1YPvRflbFXErwsVA8ECMzp2zV3cOqUWLVE3AoFvstxmtMz4TaXpirGor8ijhQcwysDPdKRp1h2v
 KEg8TabQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w4fdT-0000fe-0U; Mon, 23 Mar 2026 14:48:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w4fdR-000M7t-32; Mon, 23 Mar 2026 14:48:02 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH v2 09/10] board: tqma6: use common TQ mmc function
Date: Mon, 23 Mar 2026 14:47:39 +0100
Message-ID: <20260323134746.787430-10-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
References: <20260323134746.787430-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add function from common mmc header and
select TQ_COMMON_SDMMC Kconfig option for MBa6

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig      | 1 +
 board/tq/tqma6/tqma6_mba6.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 1ef9f6732aa..21bcb8e0cb3 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -73,6 +73,7 @@ choice
 config MBA6
 	bool "TQMa6 on MBa6 Starterkit"
 	select TQ_COMMON_BB
+	select TQ_COMMON_SDMMC
 	select USB
 	select CMD_USB
 	select USB_STORAGE
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index d604d6d4f0a..32aeb1b07c8 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -137,3 +137,9 @@ const char *tq_bb_get_boardname(void)
 {
 	return "MBa6x";
 }
+
+int tq_bb_board_late_init(void)
+{
+	board_late_mmc_env_init();
+	return 0;
+}
-- 
2.43.0

