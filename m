Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3199AC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B48968070C;
	Sat, 18 Jan 2025 07:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M/BRId+9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KTPQhZon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6641280757; Sat, 18 Jan 2025 07:16:41 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D82D80077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZmZv1Q9rz9sjF;
 Sat, 18 Jan 2025 07:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OtEHtIHPfD/YEqs5pEaqTTw/VieIwlo8F8T4UTg9ca4=;
 b=M/BRId+9nxuWZ2GQZ+UhKzKta3cdAhD+l+KX6bJ/CO7QaogJYCnv3YAlH+ZjzeAMgvVqgT
 KV0a2z/C1qmET9mxY1+C9iuXl6Iekll3u7mSHRmunewOOrpqbWtB6EDjjDGdaKZFKbVXvl
 ad6AC0EnUvkDRUDYeXlJcDycOnfie8fFCIDZ06okeaG/U+7Vi3aU3aChYWexX6Co2jWqsv
 l29WTgJ1CRjCsjva75ytOzH5qL8aPndKe8uj/N5leMYEp0OztLgA3mW4Riwg9n36/s7fsO
 yCSaf7I0CZNC1/lzyMbQYNUO+st0QgrRz9vCAakDIcJFv76V4L1PZhKXmITWsA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OtEHtIHPfD/YEqs5pEaqTTw/VieIwlo8F8T4UTg9ca4=;
 b=KTPQhZonsXGT+IBmTGkJ7m9PG+WO1d1LWgCkAvpb5YbLcMNodtY+8eqpCVwjFn5cO86u1H
 KEsVLJmmzUc1bLhYTucKE9XGhsUG/5eZB/roDa6JXVVESjDNicXoNKD3fDURb76HgtOs3o
 xRSOHjw25c1qBeA37JJWQOsEXBlZztHeUIiXpctm+srOs1QDjQMXnKLwAb7nrndIVU+DGC
 q+jadEUBlHIg4PJCpHQ68p5/7JNR2fF0YURpxM1WxCBlVNhkQEkx/fHR8Iobtv0kigRAfY
 EYx76Mh8cFRFf5yuasrSDK+hXAD9qVlABmnhz6O3IQ9Sw14c7WIlrhzYhQtMGg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: miiphybb: Convert ifdef DEBUG to debug()
Date: Sat, 18 Jan 2025 07:16:17 +0100
Message-ID: <20250118061629.125005-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 80bd1d12407913a96d2
X-MBO-RS-META: bw564az1i7gmoqgg3ecz4a4n7e7qrg8b
X-Rspamd-Queue-Id: 4YZmZv1Q9rz9sjF
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

Replace ifdeffery with plain debug() function call. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/phy/miiphybb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 171c1719b5b..5497b838225 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -183,9 +183,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	bus->set_mdc(bus, 1);
 	bus->delay(bus);
 
-#ifdef DEBUG
-	printf("miiphy_read(0x%x) @ 0x%x = 0x%04x\n", reg, addr, rdreg);
-#endif
+	debug("miiphy_read(0x%x) @ 0x%x = 0x%04x\n", reg, addr, rdreg);
 
 	return rdreg;
 }
-- 
2.45.2

