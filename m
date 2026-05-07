Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE8BCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE1984B9D;
	Fri,  8 May 2026 00:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SYtaOYjK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jwaKWKj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31A784B86; Fri,  8 May 2026 00:08:05 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840C384C00
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBRFt1x8qz9tLQ;
 Fri,  8 May 2026 00:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wlei/Wd049OMhv3MXPrKiRi+1fHg/n+/q2cuINdcvhQ=;
 b=SYtaOYjKUIqIKN8lDkTGE7ap3oVq1e9orXq9Apexy/qfE0Af184Q/gLOWCrmibo8QzZEDw
 oPYj0UWDi+fbLilzD4dUKvQDUmnsaCsXWEE7PC3IWWtb0v5BuygoHT6FSlQIbr9/tGec8Z
 LraqLLIDjAfZOnAsTPho56AMRhnAUtN/Obi7OVEEqoJ6Do/4lh/P74vfEtPjPx8EvzpAWS
 akZZ9TLVfzaL+iB8y3l2u2Dnd7qEqIGVEggEgJbm5tk9VytY93lb7kpPbOVag3JkAW881L
 X9gCGml7OGxagd5yXgKYzouR6BqMGoSS2HVsjMxOG0L1orT7SqojL6GkfkI7iA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wlei/Wd049OMhv3MXPrKiRi+1fHg/n+/q2cuINdcvhQ=;
 b=jwaKWKj/6RmP2P4SY9B35T7uKEUR3gjukYx/Ir17jpKC4OoWpHMP5bDuQTdk00a65T5nCe
 iNBlhj/oqxRPEgkqCSB7//rqWmJCsY3Wm4fx9D/NzyAWRYRJmRfdGvUciwZYcnHoZNN4sv
 qq9sWpuctcj8ZgBnmdjh+uhMS3xnVfFHdkAqcvyodhEWakqBCXZW8fxV5PXuPAxbiDKk9h
 FaYeeNzsf8yO3TukYpMEIhwpA6WOceGnjX/MLr5aMbehRg3XfibQn4LXFnxVFOlis+B2d5
 dkKHJvg9ScSMTJq2Fg5rnYEmvoBbKlhH/QJgrMSxt2caHRZoBX1fnyqwZS6oNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mmc: bootstd: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:07:48 +0200
Message-ID: <20260507220757.209233-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j5wbtm787mwz8ddat7bm49nkowd7rkjy
X-MBO-RS-ID: 57e91ad0a8fa981789b
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
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mmc/mmc_bootdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc_bootdev.c b/drivers/mmc/mmc_bootdev.c
index 5a1688b75d0..b382521fdeb 100644
--- a/drivers/mmc/mmc_bootdev.c
+++ b/drivers/mmc/mmc_bootdev.c
@@ -19,7 +19,7 @@ static int mmc_bootdev_bind(struct udevice *dev)
 	return 0;
 }
 
-struct bootdev_ops mmc_bootdev_ops = {
+static const struct bootdev_ops mmc_bootdev_ops = {
 };
 
 static const struct udevice_id mmc_bootdev_ids[] = {
-- 
2.53.0

