Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63A1FB5E93
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 00:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFC884228;
	Tue, 17 Mar 2026 01:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pD0UHQcJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lO9c9dX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BA984248; Tue, 17 Mar 2026 01:34:10 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D268C84221
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 01:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fZXyQ2Zvsz9vBD;
 Tue, 17 Mar 2026 01:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773707646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tx7LZJvVVqGC4Q3e47yfsMlfwj5FiOV//fU1ZmoxoVk=;
 b=pD0UHQcJKXYnI3jrb/6vmMyf7ixjQOT6A1gyM/k1u0GAtFO9XNDrnMpGq+9hAliNmTDxaO
 X72R05Od7c8oXEqWzqJL9avf8JgbsWI7oCuFT+wOv2zTHo8DtDY2t0LPZAVbNC0n5wQMii
 b+xsnfSzn6hy+K4M2/Ud0iBbRK40Lz1acwLOTLXW61j9ZHY/kAN6kpLRU1cevs0RXfUMCw
 dKrLkZDhyaeiAsmSnhT+xBpnZJxONQ8Km7Z3In0bHRwYu6AZIRFicJKUyi4/U7c9nTEjMz
 IuJdgXlgwoJlb+QRm+79h81G8U2BHQTAaZl8cJ3edrH/fkE5owI9rzPh3KAFKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773707644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tx7LZJvVVqGC4Q3e47yfsMlfwj5FiOV//fU1ZmoxoVk=;
 b=lO9c9dX8qrB5QIw1atj0xGw+/HIbSdBwdkVFBFF/qIcOkVrstQy2qJpeBhb6dc5tPQgQeX
 Ayg9lHKXIRUwnMhdxYmdXVdoBbBNi4CLXUgvZRZrZZaQ18uf4UhMqAzk3qOuSj8ywgE0Ph
 NYo1Zv2S60pzsI4q3BFbHS2a3D5ktlPS9x1aCXv0ZxfjeS5KTylfYMmOdsnd7bPKczS+pz
 EBTcMNUGb15FHAvpC6FRmm78QkrZYTPq+ht4RyAo6Six3Ur0JeEGHzYAA7eO3KIGgyQKCG
 q14f0kkZ+J4jF59/dDT9sHpo8XQqK4BiNCQz7+eWwYW547t25hx7pl/QA4pOZA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ram: renesas: dbsc: Use macro in renesas_dbsc5_board_config
 channel count
Date: Tue, 17 Mar 2026 01:33:54 +0100
Message-ID: <20260317003402.177486-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9cfb90022700748dc53
X-MBO-RS-META: pw96w4xx51rdffbach1qmgc46b3zm6z7
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

Use DRAM_CH_CNT macro in renesas_dbsc5_board_config channel count.
The macro is defined in the same file a few lines above. This way,
the maximum channel count in the structure and the macro can not
diverge.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/dbsc5.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dbsc5.h b/include/dbsc5.h
index cec937d89e7..b9b8703141a 100644
--- a/include/dbsc5.h
+++ b/include/dbsc5.h
@@ -50,7 +50,7 @@ struct renesas_dbsc5_board_config {
 		u8 bdcfg_dm_swap[SLICE_CNT];
 		/* SoC ckeX([1][0]) -> MEM csY */
 		u8 bdcfg_cs_swap;
-	} ch[4];
+	} ch[DRAM_CH_CNT];
 };
 
 #endif	/* __INCLUDE_DBSC5_H__ */
-- 
2.51.0

