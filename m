Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0BBE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5744895B6;
	Sun,  8 Dec 2024 23:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p4jasEM8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aS9HSCUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A12895A8; Sun,  8 Dec 2024 23:06:28 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788C38953F
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y5zbj2Lhsz9sjZ;
 Sun,  8 Dec 2024 23:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOTHTSCjPuSCxlT1mBtaXq9gsqFcz3LZ327d+gqsGCQ=;
 b=p4jasEM8929Dfqb4j9S0JOVCUquLfw+nzXuBgtz3l3LI42ZsBygmLAXgy/7kST0PsgSMV2
 PTtF72Nwd6XpCrccZD2PLWSVv2/9bPDt39zvZnHqCm0yEv4POvzcSZcpJ84eRcRiVBuDQ5
 M8k4DqAGodPU6j64v3a/mrYS/M6nsed3YWrBTRmozGI6OoKS6nHG2XsfQ7jVnQsZwQvhqJ
 SqyRBF/glPJFLnwj4kt5n/Baw50+KuRJwT0GH8Bi0MgABnql8nauwtGnBWi+iLHS8Z4aD6
 5Ex4SoLK7wQxEBgNI4e9TjMkjZvH9lncT+ykNBcJNjWrHVZ7piOFIyz48sXBOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOTHTSCjPuSCxlT1mBtaXq9gsqFcz3LZ327d+gqsGCQ=;
 b=aS9HSCUVw2FCODv53yMhZGjFpRQdeIYZDnr6g2GHuxp/7Waai2J9uD+a5yxM0KW/VhULL5
 MyJdIHhRpy47tuPYguc3J3UVHegf7OBKr/6VHHFVLmXuMGuPCNtaJna7wuHzaPw/hCOUQX
 0r+1fuR9R6w0L3IHH/mHmn69jU7cSa/T07O/MG9dcOFtN4xcV03GowUVtrWaC9rY68o5Kg
 8hOYFoBphSMPUbSTcLmRtR1NJ5D2c491/3bD8/MP9+R2qpN2CkOMKpMhvDibrZ6a6HmpzC
 hm9sw5g1+sZ9/ia8WyFYHf3GwNq45cmgWHFpnZR4tdeb80t1+FIXr1QXW9lRZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/13] mtd: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:00 +0100
Message-ID: <20241208220551.204743-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 488giicwuh5ucdty47ugsupur8nz9yka
X-MBO-RS-ID: 3fccd8449ef37a6be84
X-Rspamd-Queue-Id: 4Y5zbj2Lhsz9sjZ
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/Kconfig          | 4 ++--
 drivers/mtd/renesas_rpc_hf.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 3764e2567c1..e7ce8b9577b 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -194,11 +194,11 @@ config ALTERA_QSPI
 	  "Embedded Peripherals IP User Guide" of Altera.
 
 config RENESAS_RPC_HF
-	bool "Renesas RCar Gen3 RPC HyperFlash driver"
+	bool "Renesas R-Car Gen3 RPC HyperFlash driver"
 	depends on RCAR_GEN3 && DM_MTD
 	help
 	  This enables access to HyperFlash memory through the Renesas
-	  RCar Gen3 RPC controller.
+	  R-Car Gen3 RPC controller.
 
 config HBMC_AM654
 	bool "HyperBus controller driver for AM65x SoC"
diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 03545822b07..50a6191d9c2 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen3 RPC HyperFlash driver
+ * Renesas R-Car Gen3 RPC HyperFlash driver
  *
  * Copyright (C) 2016 Renesas Electronics Corporation
  * Copyright (C) 2016 Cogent Embedded, Inc.
-- 
2.45.2

