Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186DCCA0FED
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 00:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53EEF83937;
	Sat,  6 Sep 2025 02:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UeYz7y8R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ic6e6uc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED658394E; Sat,  6 Sep 2025 02:01:20 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C16383906
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 02:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cJYK86GHhz9tkP;
 Sat,  6 Sep 2025 02:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757116876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GM+cvKJ1b8cUeuplHa8hxJw92zhprO6xEZDAOngx9RE=;
 b=UeYz7y8RCOCdGaSFPUabl/YnI27PmDMrRuMLboxOUeDtMbWTtMpXZkfxk/C7WjZY2vcGxm
 a2p7N5iiSrz0qSZbQAKuN8zfDV3dbA8CZN8QuP8RqZGfLoQpFiO9lzs2yxgJ9Z8nKZvsCC
 WEVqLrMjLJiXZHyJb3PA/BtsaW3bcLk7UEvQ6KSkEDmKGmgobkieoNJ1blaMyrVpmZ021V
 DPoNXfxJAiSJZfDfswFbf86CimQkJ/D1w12YzIKvsVEjzzWTLfCD8Kf5vN51f7IqWwk75T
 PiEEw4C511kl1f8YF4ymhSrJfrpWygSHF3vVl6HDQwPRx/nP4bhMgo82BwUEDA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ic6e6uc7;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757116875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GM+cvKJ1b8cUeuplHa8hxJw92zhprO6xEZDAOngx9RE=;
 b=ic6e6uc7OA0YTuPTVF0tbgfQkbCcBjf+zCljYGT7L4fGG/q0Utm/S2rPINw08+M4p3nsK5
 fFxb9rNDBPFWWZD85+NbJF3ChKbJ5gSN5PU4P4qX0HcXqw9Lpctff2WKrKu56FRGkaP0uD
 qCIn+swRlWlNuqejmV8aya3wrBdWI4K34XyYyG7oFk4zS9mgN9vycXzF3c6RVcDEX6FPvU
 IQgiawPAGVFO4B2EzI1JXrwo04tWRkfoXX5IzH4d+U33/pWWK21LwMjaLreLoYCBGaM7cK
 YF2ETQ1mU/civHjnChlSTdl70LssNOuCA34YwtX911h+gJ/Fz0aj1iEqovdvaA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] thermal: sandbox: Staticize sandbox_thermal_get_temp()
Date: Sat,  6 Sep 2025 02:00:53 +0200
Message-ID: <20250906000102.284396-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 063d9403edde67ee850
X-MBO-RS-META: qsj563h7jh4xxzmgacqnt48os9grngdx
X-Rspamd-Queue-Id: 4cJYK86GHhz9tkP
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

Make sandbox_thermal_get_temp() static, since this is not called
outside of the driver. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/thermal/thermal_sandbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sandbox.c b/drivers/thermal/thermal_sandbox.c
index 9af0d0247cb..b7c567d76cd 100644
--- a/drivers/thermal/thermal_sandbox.c
+++ b/drivers/thermal/thermal_sandbox.c
@@ -9,7 +9,7 @@
 #include <dm.h>
 #include <thermal.h>
 
-int sandbox_thermal_get_temp(struct udevice *dev, int *temp)
+static int sandbox_thermal_get_temp(struct udevice *dev, int *temp)
 {
 	/* Simply return 100 deg C */
 	*temp = 100;
-- 
2.50.1

