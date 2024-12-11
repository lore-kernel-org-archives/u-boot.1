Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F401E77183
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C870802DF;
	Wed, 11 Dec 2024 08:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mYXpTJOx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vs3TuInh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3ED080209; Wed, 11 Dec 2024 08:32:42 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0E180235
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y7S473lrYz9sqZ;
 Wed, 11 Dec 2024 08:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw9Xlg2/UabAdMzNKYpEjvPhHnU8jXMUTY5gSJqg5wI=;
 b=mYXpTJOxvHQniAg5i1/fR+g5i9fZPlpUkUs4qHUozag2/pLCW0OxIg53/ZtCrwA9kg/27B
 9XVDwRclQnV0SYjHqDxGRQe5H+Btt1py0wLHgaLDQD8cfJUe/UyrpbNmm2F1oaJdrGja7E
 X8jflMwT9cwwgLaykKM+d7++zdhtYirqSe9Rf91PVtNkm+ud52yEuI16tJ612YAZITi/K/
 xAFSLbYXq0NPOoMcPDfZOxKCsShzO3SI8kG6inNg+vml5bPNh5L6eYl4vE7wx1TV20PTcV
 oCUNRgwHszQMKUpubvWcfGmBmuDVUNoSx/H1xuA/x9NVnQfL7hheINz1HKbZMQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw9Xlg2/UabAdMzNKYpEjvPhHnU8jXMUTY5gSJqg5wI=;
 b=Vs3TuInhzxsL6QuL4S2SlwsHDMnl1j5+54Xbw2vADlTjNExNIsD3WQoshX+Ve31y8B17U/
 vudoJ6/C8I19QA9YOfYqAuDV6F518Z1tCER84IFJStyVn5oD4DqU6E65Rlm89R6yM70Fw+
 9P4EaE8qvfD38+vdZXn8GJqAIf0bI9j0Y9GwPNf7/lffHVkzvor4hMvkm6aaC4Sx5xa+1J
 0GkWZ63bJroR9KzKgKfoolNUkrtl871M8fJME67e/9OvSKYWoXGAoOvds1U2xjwBvgzSNN
 iKKoocpPkmAh+/0y0tU10kB0yx7Dk1HRBr9SyPaOJUoRgv+72G3aDbApHcJI+A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/13] spi: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:36 +0100
Message-ID: <20241211073210.8087-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 94zb87hs6qndtarfoan51np1tthjioxo
X-MBO-RS-ID: a154a88d2ce72bac7e2
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

