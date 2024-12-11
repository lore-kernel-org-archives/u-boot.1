Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB3AE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AE580212;
	Wed, 11 Dec 2024 08:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WRkWPmoU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dud9oNt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D251801FE; Wed, 11 Dec 2024 08:32:36 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3425180212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y7S41074nz9sv1;
 Wed, 11 Dec 2024 08:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmf1SE2t1xvavIVYrd9RAcXOH9VzHjkH9b6ozCAqH7Y=;
 b=WRkWPmoUJZpbpRDYn58k04hIsYvqx96+U7QwO7GfwIuw6z0FVmVUtN5nmUh2ntCOW9Chsl
 zmGOvm0Ltz5DHf3/CZD/8hm+LXf2cJI+NJc790Pdoj322zV/q631jmT8luGiFEeNTemQ77
 8NfIUi0jXFyLhxzyxLsYSQDsJGQyZnOG7K6thLlq8l2VhjvU/tCwqY2h/0Rt+8f1S1kE55
 O9C4xT9pLFoz3YkimDV1RFpdjTjhdjpAxJKz7+S57AlfuFkozQV8ME9b8+TWocD6fh1FHE
 UN7JvClHO3mdypd6c1zNAx1NLvt9LxOxP5/q73nmQNNFg1sssoV4Yc+KXTo1bA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmf1SE2t1xvavIVYrd9RAcXOH9VzHjkH9b6ozCAqH7Y=;
 b=dud9oNt84sstuJXVfHosU6gAkvTI4GHM6peyPXuXJA3ZTtkZa5xVuw2fdta9UHVCq6ozQc
 v8nHOks7MMZQ7SCeWjC8bTsWZ6SoHNbdGrU0K9IrSy4iEEcM8/MUbvLo3xcEr5myasHIDi
 vqyW/OJ121Ech5zNBm2b7GTri2Ekoo5EZOoLLq0yZk7c83TlJ6EOPqs+2RbHMzFl5zvZuM
 8FlGJavsxNtZRfpzmwdwtjw63h27hPN/oxC1AMVDSbRBLOUIb8OelRLCjcxNw34LSBDWRl
 4HehRjxTPhABJuipkbqQNF0s65a8p5P+oRRM2AnNQ4cHtQax4G/WMK71xIvjOw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/13] clk: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:27 +0100
Message-ID: <20241211073210.8087-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iu4sjguzdcozywa6zepp1z95nr7ic9s3
X-MBO-RS-ID: c1987644be05e099db8
X-Rspamd-Queue-Id: 4Y7S41074nz9sv1
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

