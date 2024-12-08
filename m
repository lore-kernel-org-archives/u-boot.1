Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00031E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B92893E6;
	Sun,  8 Dec 2024 23:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z5r/BQIT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TQf2KOPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8A7893E8; Sun,  8 Dec 2024 23:06:27 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A93089500
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y5zbg1gQ0z9sq0;
 Sun,  8 Dec 2024 23:06:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzJCFOh4V0wcj/akGQyRavd1F6sZykKnVPgZZfA0jMw=;
 b=Z5r/BQITcELhnFENI56N/uEvlAuqiKJ8qHXXhakQ5aE8JmCszohEit3T/ptZM4xJWPMoir
 sP83J6lMC9zHjWgq9Uz2HtuSbZQ1KhNee7ojuIMj4Be7QN0m8obTjY6h4/X8dDdev1XrgO
 I2+gWQe+/1PU9Rr13jkoan6JhqmHFjWeVkymf+4mWnqSD6VoQI1GrDKXYlm836TDalO1M4
 hfklAqBz8iXFViPJig9Iwhfx/GK84jGo1WhJ71PrBA8KDdASLLowchWriXyDaHSemL8eWw
 ecxyto4jYSNs/HZQSqxyaf2bbzUB3VFNzCdwRkcE5ChPLmf9oWSYqa1iZy+VOQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzJCFOh4V0wcj/akGQyRavd1F6sZykKnVPgZZfA0jMw=;
 b=TQf2KOPzWcUjQtsS2ApkcbH32DUeUMi2STkSgK4kDq4GknOxPCNIedeMS4Be9VErdJE8kj
 tuyGFtGbvijkQiyxl7Mkehf2s60fZawMrp8x9nCNyktZlvUk3WvqGW3s5z+RFRS5SQ7C9o
 fI64q8lpVNSSyHXZKojFeXUbIlPK7dn8TgeYOWjLcesAUFoeFZ2S7U8P2QOY+vD0NDkqWI
 8moyohdGNKLRYMn8kbt/7XDkEN6UGqpzWhoac6LHqYp63VQVFrx9M84kbTvLwJVgGkkWim
 NlPkWDldS18jaCq4SWjqz8RqoJoqMEdYMCL1h2RPYPCmAZN2td0gQY3BkkIRMg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/13] clk: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:03:56 +0100
Message-ID: <20241208220551.204743-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4hfqudxsmqwzskdbe4dh4hsm7r846r5y
X-MBO-RS-ID: 2424968f9da4799a3eb
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
 drivers/clk/renesas/Kconfig            | 12 ++++++------
 drivers/clk/renesas/clk-rcar-gen2.c    |  2 +-
 drivers/clk/renesas/clk-rcar-gen3.c    |  2 +-
 drivers/clk/renesas/rcar-cpg-lib.c     |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.h |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index a093027eb0e..12966d02a22 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -5,20 +5,20 @@ config CLK_RENESAS
 	  Enable support for clock present on Renesas SoCs.
 
 config CLK_RCAR
-	bool "Renesas RCar clock driver support"
+	bool "Renesas R-Car clock driver support"
 	help
-	  Enable common code for clocks on Renesas RCar SoCs.
+	  Enable common code for clocks on Renesas R-Car SoCs.
 
 config CLK_RCAR_CPG_LIB
 	bool "CPG/MSSR library functions"
 
 config CLK_RCAR_GEN2
-	bool "Renesas RCar Gen2 clock driver"
+	bool "Renesas R-Car Gen2 clock driver"
 	def_bool y if RCAR_32
 	depends on CLK_RENESAS
 	select CLK_RCAR
 	help
-	  Enable this to support the clocks on Renesas RCar Gen2 SoC.
+	  Enable this to support the clocks on Renesas R-Car Gen2 SoC.
 
 config CLK_R8A7790
 	bool "Renesas R8A7790 clock driver"
@@ -51,14 +51,14 @@ config CLK_R8A7794
 	  Enable this to support the clocks on Renesas R8A7794 SoC.
 
 config CLK_RCAR_GEN3
-	bool "Renesas RCar Gen3 and Gen4 clock driver"
+	bool "Renesas R-Car Gen3 and Gen4 clock driver"
 	def_bool y if RCAR_64
 	depends on CLK_RENESAS
 	select CLK_RCAR
 	select CLK_RCAR_CPG_LIB
 	select DM_RESET
 	help
-	  Enable this to support the clocks on Renesas RCar Gen3 and Gen4 SoCs.
+	  Enable this to support the clocks on Renesas R-Car Gen3 and Gen4 SoCs.
 
 config CLK_R8A774A1
         bool "Renesas R8A774A1 clock driver"
diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 89f2d966746..9b6fce4675c 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen2 CPG MSSR driver
+ * Renesas R-Car Gen2 CPG MSSR driver
  *
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  *
diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index aa38c0f7dd0..375cc4a4930 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen3 CPG MSSR driver
+ * Renesas R-Car Gen3 CPG MSSR driver
  *
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  *
diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index 8862fbc7579..ea33bfd3239 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen3 CPG MSSR driver
+ * Renesas R-Car Gen3 CPG MSSR driver
  *
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  *
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 35bad7f5f73..39ff4541c1e 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen3 CPG MSSR driver
+ * Renesas R-Car Gen3 CPG MSSR driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  *
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index 71e409f3eb0..d5db14baf06 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Renesas RCar Gen3 CPG MSSR driver
+ * Renesas R-Car Gen3 CPG MSSR driver
  *
  * Copyright (C) 2017-2018 Marek Vasut <marek.vasut@gmail.com>
  *
-- 
2.45.2

