Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994DFCD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E538807B;
	Tue, 26 Mar 2024 23:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OhZ0//Sf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MpYolbtJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D737388074; Tue, 26 Mar 2024 23:15:05 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1422387B89
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V43yH5lDwz9sj1;
 Tue, 26 Mar 2024 23:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib/EtBN1t0TyTzVUnMI4gCjHjZqoyK5BXtxGTQ7+9yM=;
 b=OhZ0//SflAKJMhSgxoaPxcOQWdbRMzvFC4NVc2nSoFI6HFebHKcJ29oNHAhL/qt3sSEQBW
 XzYhPoEl3yZPUZWs62KUl8hRq7a2x2bjKKeFWQhCxu6d0QlphH4silkeQDr1PolFsqxRFj
 W78qK4xGlYck46I5icHHdjRH5LPkK85gbVEblyPAfp+kkiV+Hi+UzbwMBEy+OjIkTuCa0y
 DLbhquOcBMaLa/6q4VbXRJF8mEl6Gr+yNmYARmjxrkJza8DT2TcHo7um6GCkrvGWxeiOU9
 wyY1o5s+kBLPQqLxHPLVvMUVana2Xezz94UOpgAia/7BX4gaZ4OxO6aMfhkI5w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib/EtBN1t0TyTzVUnMI4gCjHjZqoyK5BXtxGTQ7+9yM=;
 b=MpYolbtJQ3N3hNc142IsnOsuloK3O+PV1v3rcz4D1I0Ta91x1tT8Yo+FN+BezSv2cpARA5
 MuYDzTNityxjPL1vF1wJ7ydSve5yZ693IFrAtvlY/PRl7sXgcsTRLuFGENagYYQ3AEPSII
 znb2HqROu1mCPZ1ioYq8VODEpP4xOz8XB0q81VYTyTtgc/L4r1nwCAIIQnDWyoc5+ToJXA
 T1kv332ypICPyZLESwl0D4K3ybYuLDKDc7Yu564lOJfpNk6VsTciaSQHYk/Wmqc91neF7S
 7B3VXYp6EzMusreli3z6jFpttxjErZpBIbhonATL3aJd6xNk9zgJmBUkhDkQDQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/6] boot: fdt: Clean up env_get_bootm_mapsize()
Date: Tue, 26 Mar 2024 23:13:14 +0100
Message-ID: <20240326221431.55346-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
References: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 372a62344406fcebcd0
X-MBO-RS-META: s1j4ujrmgpqx6uqf8qqggpxnptmd5i4e
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

Reduce tmp variable use and remove unnecessary type cast in
env_get_bootm_mapsize(). This aligns the env variable parsing
with env_get_bootm_low(). No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V3: - New patch
V4: No change
---
 boot/image-board.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 13876b79026..09b6e4e0bdc 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -149,13 +149,10 @@ phys_size_t env_get_bootm_size(void)
 
 phys_size_t env_get_bootm_mapsize(void)
 {
-	phys_size_t tmp;
 	char *s = env_get("bootm_mapsize");
 
-	if (s) {
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
-		return tmp;
-	}
+	if (s)
+		return simple_strtoull(s, NULL, 16);
 
 #if defined(CFG_SYS_BOOTMAPSZ)
 	return CFG_SYS_BOOTMAPSZ;
-- 
2.43.0

