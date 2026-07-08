Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F91C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 15:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE52A8497A;
	Wed,  8 Jul 2026 17:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VbHurH5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97FAB84994; Wed,  8 Jul 2026 17:13:27 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971F084979
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 17:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9C51118793; Wed,  8 Jul 2026 17:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783523604; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=uVr/mFPwSIhCx5fqhLcVa74bU79jdkI1S5peLRd5D38=;
 b=VbHurH5ANZ623MoXBCu1FK2MZY+2fepxyKrFLP+QSoakC0pcpTvPfMHe4ulMlCjRjk7L0u
 2kw7/FtKaLMEWXkcJLy7HXSogbmDdPgmCQ6F7EHzHYTRQevI3JdYfDGAXLS52c9glqzWq+
 ZxHfDz/roOFrQo7PuF86CCh+sTxU0g2jzsSSmayH2vHGXIBK2bqu8JzT7Mkk/AeZWkVQHB
 QSTRBSP4qihkg2sHI6KdODdv0lVMNq+sgnh18fC8K/TRihouMhFoZi/74ICsV4jCShr03j
 +9Oq3VfrJZlU3g+tLKwLLcBLI4i62ASPp2u74BM1Z+bGspHfzt6HMgSPccSrHA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] serial: lpuart: Clear the OR STAT in tstc to prevent hang
Date: Wed,  8 Jul 2026 17:12:49 +0200
Message-ID: <20260708151321.69075-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Clear the STAT register OR bit every time in .tstc callback, otherwise
a condition may occur when data are fed into the RX FIFO, the FIFO did
overflow, the OR bit is set and prevents any new data from being added
into the RX FIFO, the OR bit is never cleared, and watermark read back
is always 0. If this condition occurs, the .tstc callback will always
report no new characters, and the OR bit will never be cleared, so the
U-Boot shell will be unresponsive until next reboot or kernel boot.

This is easy to trigger on MX95, power on the system and send traffic
on UART from host to the MX95, the MX95 FIFO will overflow and the
U-Boot console will become unresponsive.

Fix this by clearing the OR bit early, in .tstc callback. This way,
even if an overflow occurs, there will be slight loss of RX data, but
the U-Boot console will not become unresponsive.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/serial/serial_lpuart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085..70be9d50634 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -366,10 +366,14 @@ static int _lpuart32_serial_putc(struct lpuart_serial_plat *plat,
 static int _lpuart32_serial_tstc(struct lpuart_serial_plat *plat)
 {
 	struct lpuart_fsl_reg32 *base = plat->reg;
-	u32 water;
+	u32 stat, water;
 
 	lpuart_read32(plat->flags, &base->water, &water);
 
+	lpuart_read32(plat->flags, &base->stat, &stat);
+	if (stat & STAT_OR)
+		lpuart_write32(plat->flags, &base->stat, STAT_OR);
+
 	if ((water >> 24) == 0)
 		return 0;
 
-- 
2.53.0

