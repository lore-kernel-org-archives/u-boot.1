Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4345E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4272895A0;
	Sun,  8 Dec 2024 23:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gI21bsNU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GavhN2V3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B4C893AE; Sun,  8 Dec 2024 23:06:30 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A03F895A1
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y5zbm15BWz9smW;
 Sun,  8 Dec 2024 23:06:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9G1bsU28D1LfKeU6WF/vK6nDnsBfSaGkVCNrYUveRg=;
 b=gI21bsNURNAzXR0EMS3nPHCk89Lf8xmsUWXRLTgfy0k9BWLzvBj5t/vUGMFYNyFsMaNAnE
 /01nEQAi6gW+mujuPC9QNkQg+ik36ODP2tq/0IZjewTkRMhQuoVtz/h/4oCIHWfDhFzbQ1
 7/Lo3WVi0OM+t4cY6ksBg9hWSggp5cKzTD/1H9qjqziYCnNgDhHY5jTwNRwU+Or5vl9Zrb
 4ty0zr3tUtab4pP/tPflWTDCKe7mmSVoULfYTTBRQDE6B0y1aEGsNqUPeSettFGH/5cCqZ
 SX/kAS+hcUN0Fs/6uuAY0yPRbfHfhMkVglEJi0pp1twwhxw4M9NEy7o5mWbIEg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9G1bsU28D1LfKeU6WF/vK6nDnsBfSaGkVCNrYUveRg=;
 b=GavhN2V3MZDpfBtsKyebElt1CWSgAAOos03eKMLIB5jZ73S9hMAAF8OAD4vltJXkSW8rTa
 dFL8N9ymfC6+9Pv0XDZ2JaAzB8HT74Omi/A9masBY3u/AJPVUJghOyat6jH2b0iZnjveOY
 syxSLqfkQbsZmItKEm8eGpTf4T/fA7QCEBTbMldjJPvyV3o04g7H7jAaLHkqqXEsJa1QRX
 2NV/WAcr+YeY7euAffN7s3kmrfTh2/ePGKfumwQvMSzmZc2Efit62Q6FBIWVvAN7e6FYJM
 O4dx+LDe7jD54anVQEdbbKudCq4s66IEPUioUoIivqrjnf05LDGDrvaE4yUpog==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] spi: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:04:05 +0100
Message-ID: <20241208220551.204743-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c6a7c4ec182ac38f0b0
X-MBO-RS-META: drfcwwr7au4harizehpj4zy78jawxnuh
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
 drivers/spi/Kconfig           | 2 +-
 drivers/spi/renesas_rpc_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fd5cb3694f6..96ea033082b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -420,7 +420,7 @@ config RENESAS_RPC_SPI
 	imply SPI_FLASH_SFDP_SUPPORT
 	help
 	  Enable the Renesas RPC SPI driver, used to access SPI NOR flash
-	  on Renesas RCar Gen3 SoCs. This uses driver model and requires a
+	  on Renesas R-Car Gen3 SoCs. This uses driver model and requires a
 	  device tree binding to operate.
 
 config ROCKCHIP_SFC
diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index f1e6f9f4e01..7103d786c7e 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen3 RPC QSPI driver
+ * Renesas R-Car Gen3 RPC QSPI driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
-- 
2.45.2

