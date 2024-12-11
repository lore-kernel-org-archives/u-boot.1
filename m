Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7B5E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1656B80303;
	Wed, 11 Dec 2024 08:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pEbdC8hU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rDSJEkEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD9280282; Wed, 11 Dec 2024 08:32:38 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7D180212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7S441pP3z9ssn;
 Wed, 11 Dec 2024 08:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tp805NjB7plIPACAVPIocO60mKWw8lCO0hBEN9ayfc=;
 b=pEbdC8hUzexRljsOR8AP+tdhCj1N4kVO0U/n6Vn/jeDoxK7BbtoOPeLvonoP1oRlAS+/w2
 QGsQYOCWmet7kBGZO8NDGVaotcJPaJn2riuQ5AWDggUckAYtXDUB4WSicXuyuZcw1xX6xq
 EbOFDn2Iw0KOGhSnPYZ3TyGiMMsf1lF4zKj8lJHVwkIbOdG46M5d5MquBT3/lQY+6Lhcfz
 SpczP+8k8FS+e2VHoIuymOyGb6xyyt5CB4pX7MqG633XnJbVWkWXJWCvhXjGwfqHLR8NQQ
 R8pJAFDDYlU6/fe8ipcJaEcMMtKpm/Z/y4FTXdevdBm3WHyCKIOqLHqEJ+mEUA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tp805NjB7plIPACAVPIocO60mKWw8lCO0hBEN9ayfc=;
 b=rDSJEkEanvl7VF7s6UMMmGm+SCdbw6JdJInnXE1AUBV1jZSpCvF3GqLfChlVE4EX50pEKG
 rYmBkessT5r8LVcHcka8lHRplZbDARMP42O+wNIt+Pp7LzO2n5IqX8lfbhiwSBhRoWjYlJ
 /50aubH4ghK3MMZ7KOwRs28SJk0JQtx3/FJd6FT1HiR7oC5uByJD70540lEoXBIj0MNSFd
 094Zng5uedSMlHp8YZ+sWnxwB9Ce0pckPZVcNMJTzC2J9TkPsALe4j/XPuOWSxEtEpMRzd
 VrxMebCWpbfb0/01ZRLv+OYSQR8dq6KKmejDZUEvu+GGc5mLTtxrBJxOL1vE2Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/13] mtd: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:31 +0100
Message-ID: <20241211073210.8087-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a2e8d8e5ddfea23a6cc
X-MBO-RS-META: x1tpxsebqs9i4x5t6s87wia1maytpjw1
X-Rspamd-Queue-Id: 4Y7S441pP3z9ssn
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
V2: No change
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

