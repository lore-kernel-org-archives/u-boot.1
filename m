Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC03C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775F687F74;
	Mon, 18 Mar 2024 16:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lWggubpE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G1mH4joh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0630287F3F; Mon, 18 Mar 2024 16:02:26 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A2A87E6D
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tyykl4WGGz9sj8;
 Mon, 18 Mar 2024 16:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWeFet3negYfl0fwxSejyOLWmjYhc6hezjBTHWAt5z0=;
 b=lWggubpEMzVi5+1e7qGoZ7XXjBXOJQlY0AFMD8RpZEWQkX4keSiwIGfy1bBgphNUdx9h82
 6mHss6GyWVuFQv47w2kMBpSH9Q1HcxJ8H+pRDVu7DSABGvammB78s00Lv41NOXljwtoMO3
 zeMGmGX9GVxd5gRc/SNhqd1I2fqoihVrDc6FmKowdCOQ+851s8zQRzN4bk0NZ4Rt6v/kCr
 cePDxE2K6hdhiWQVErFUXwzpWECIcYgC7wlngcHbgx90mM7Xz0cKhXtWDaSxu1krfcphzb
 ARHPGJcwMpNIQ0aqIl+7HwGbRs7XYMsiPMesKy4fvvYhpV+NA0ewDEOOjqzlug==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWeFet3negYfl0fwxSejyOLWmjYhc6hezjBTHWAt5z0=;
 b=G1mH4johPMti7n+Yagja6UA81O+/efeCYEhmwc2DCwMjaLKbD/MO/ES/hOrWGAx8q23Nt9
 HtOVQrqCoAo+JTZyyrPOkbRy7PYEvi0uteYRxR04oAxlJM+4yQvXe83T5tInFe+s5yODgL
 TkFIv+ZmbhcSt1N6C6Gs61QB9cKqVBwGL3GeqwGaIxo9AoGEYqYIjCz6RYbYTZo/lumQYO
 tCJ07kbDej5ctyXlwayw389dg2uL+D/DJd7eVFOIcnKOMWVSMMQwDAJnA4hsrv8InBTXpQ
 z+ts35H0fDUg3cGP+JAQgeLRoTlvLcL6vXiTsX36KKXcGP2VU8wdHa0WYijbGw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] boot: fdt: Clean up env_get_bootm_size()
Date: Mon, 18 Mar 2024 16:00:45 +0100
Message-ID: <20240318150200.8178-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 01dc7a79b725fdf7d62
X-MBO-RS-META: jiqdmc3fxgykbkqkq1id6iznqucmsadt
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

Clean up tmp variable use and type cast in env_get_bootm_size().
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: - New patch
---
 boot/image-board.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 3263497a1d5..e3d63745299 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -129,10 +129,8 @@ phys_size_t env_get_bootm_size(void)
 	phys_addr_t start;
 	char *s = env_get("bootm_size");
 
-	if (s) {
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
-		return tmp;
-	}
+	if (s)
+		return simple_strtoull(s, NULL, 16);
 
 	start = gd->ram_base;
 	size = gd->ram_size;
@@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
 
 	s = env_get("bootm_low");
 	if (s)
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
+		tmp = simple_strtoull(s, NULL, 16);
 	else
 		tmp = start;
 
-- 
2.43.0

