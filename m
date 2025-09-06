Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E0ACA0FED
	for <u-boot@archiver.kernel.org>; Sat,  6 Sep 2025 00:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0DB83957;
	Sat,  6 Sep 2025 02:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hjjMaB/Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IzSzEc9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F6483979; Sat,  6 Sep 2025 02:01:43 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E008C83906
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 02:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cJYKc4rRjz9tXv;
 Sat,  6 Sep 2025 02:01:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757116900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X7RlVsWm9y/6+RvcmSQfOvghGn/qTp6vFJQJvfegr4U=;
 b=hjjMaB/YGyRuvXI6Tx2J4MAXqmFiKZ66efc0wheznSpyz+Vn+ypi1a+d+WDxR1kUuC8FSe
 f6NEpH4OLOY2X6o3QB+KrZ5JYquqrWA5ppTwtOnGvrBr1j0W5BLLjBhE+wbEh4bQVqTddz
 bb6OSYJ4jz76zcDt3WirrYsYT70KBF6D/45SHzT3MUlK8NfLNLoeBVHh1JLrxQyj8n6jC7
 WkPAyyhCS8SykP8886usE9KTR9wCw/ytDpuPPeOTpKeIto/aMxd+VqCM/YDBqjgyDc3xtD
 krZ29SxBeZw2H8HWZ6+bO3ehKCkypYjyWV5V89qrWzgqgfnZSy2K2n3zFJPS9w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=IzSzEc9o;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757116898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X7RlVsWm9y/6+RvcmSQfOvghGn/qTp6vFJQJvfegr4U=;
 b=IzSzEc9oPXa3zoKC4WesCUhEjcTo3Kg8QO2R8oV19UOt4ldacPJF8AAjtCh6p+FEEsI13W
 9uXVHzJ0Z2YoY8T/x8J/vR6/ZvwaiQ8mN36W/bbCG4ZjjMJ4AwqVSifQGBxkuPQBrtu8th
 B7loh3MeRh+62fddn2frSsP4zODaeUKnV3VITnbEWS7yugLAgpdlEc6RHuH9eIggnPMdxl
 pQ/crvU6KNw3Nh1CIHk13fXit56KngborCfJmM3+0rcZB95XIsIsmsD8XfGiymVtI2GKXO
 TmlzdZiKtrCWPYoV5MEDGdrq2YNr0+hUuqQb8mQ7c4XHPm+L4rcp/WvQtoPZPA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] thermal: Sort the Makefile
Date: Sat,  6 Sep 2025 02:01:18 +0200
Message-ID: <20250906000129.284428-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 96355ae77e2303fb3ac
X-MBO-RS-META: 3sufu3cpxxyhbos6drkesymjk5nqo3h6
X-Rspamd-Queue-Id: 4cJYKc4rRjz9tXv
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

Sort the Makefile alphabetically. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/thermal/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b5ab0fc221f..18ad453f9b1 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -4,9 +4,9 @@
 # Author: Nitin Garg <nitin.garg@freescale.com>
 
 obj-$(CONFIG_DM_THERMAL) += thermal-uclass.o
-obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
-obj-$(CONFIG_IMX_THERMAL) += imx_thermal.o
 obj-$(CONFIG_IMX_SCU_THERMAL) += imx_scu_thermal.o
-obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
+obj-$(CONFIG_IMX_THERMAL) += imx_thermal.o
 obj-$(CONFIG_IMX_TMU) += imx_tmu.o
+obj-$(CONFIG_SANDBOX) += thermal_sandbox.o
+obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
 obj-$(CONFIG_TI_LM74_THERMAL) += ti-lm74.o
-- 
2.50.1

