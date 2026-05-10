Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B50CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF20846DD;
	Sun, 10 May 2026 19:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CDSo13/3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yS+agKVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5F984694; Sun, 10 May 2026 19:16:27 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B18D846D0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gD8f06Xzsz9t6y;
 Sun, 10 May 2026 19:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VJ4Aq//q0vQ3u7fNjpCOeBDy8U2259vy3Lo3zFfKMR0=;
 b=CDSo13/3jLEtdytryR9Gac4384P73Hm7ZBYu1WBGYX0UuCIx89wHyvhrCldzZUmTwSVTEu
 a2PVPhYTFRC6nYm5du2HRRtiGWusw1u2wD8+BIifHmvK9rB3iE+G6gQ2k1oBt8B/JaLbZ+
 ePI8fHkWkb4FLUGXgmXeT7rif3WqAz9WkgQ5OZNcFzod7kDttCC6LxnbQmb+ucSqpnl5/b
 kYcG2i7H61LUtRX8DHghaOeXDxTjUCNHLXKI1KSOMTqqpIdGRwpo2kztep6Ci4mKLdUP29
 H2vPFfk4n13aPtnG41Uycu/NB9CF+8H7BfQ1qzGzAwbt0elB5PWcpX/E1/O6jw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VJ4Aq//q0vQ3u7fNjpCOeBDy8U2259vy3Lo3zFfKMR0=;
 b=yS+agKVM8tElLPx0exnO53TZ++eskqjXe11hrsV0vxAs9lmnaRaVQ+SLbOczCBPLCcAskf
 GA3w1AjTGk5YMlpLubhAH7Ew/6fkUe6cd5KZGV4eC13Hv8HOqt5W6NYP3CSaK4XXKzjQBU
 6tYB6Y2YFvPel4ecKm5M2ax8L5riJaNMs1h7A6R6l00VliuLz9E/siR0NQV/ty9O53n6b9
 eI/K/mlYtJ9lKAE6I1vY6ooI170bma0r1qqYL9Pke25ODRtbOeb6JKVeevOMcBhdS9Ygf4
 KoGIaah46ecbckrC8sNXEZvnzXML8gGXvwrTbxTRLmzOk8wOu3bLCYuXoDJizw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] spi: apple: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:16:17 +0200
Message-ID: <20260510171621.56812-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: oz55tn75ptfdza99a6bfw66ruy65iqzk
X-MBO-RS-ID: f8fd637186feabd8be9
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/spi/apple_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/apple_spi.c b/drivers/spi/apple_spi.c
index 5f94e9f7a74..acb74886708 100644
--- a/drivers/spi/apple_spi.c
+++ b/drivers/spi/apple_spi.c
@@ -228,7 +228,7 @@ static int apple_spi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
-struct dm_spi_ops apple_spi_ops = {
+static const struct dm_spi_ops apple_spi_ops = {
 	.xfer = apple_spi_xfer,
 	.set_speed = apple_spi_set_speed,
 	.set_mode = apple_spi_set_mode,
-- 
2.53.0

