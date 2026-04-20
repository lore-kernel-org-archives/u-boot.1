Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D006EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D519D842B7;
	Mon, 20 Apr 2026 03:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EhdSK4w9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ul7FbUE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F81C842C9; Mon, 20 Apr 2026 03:23:01 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A11D680433
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fzSR72VVkz9trQ;
 Mon, 20 Apr 2026 03:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LRgeAYtGlhFVqvwJc/Myy5wuBK9KXAPz1nqsbEgp0k4=;
 b=EhdSK4w9G+v62sV/HQD5G0JHKD0rOsFkUK/DYcJr7sUWC4/ftV10fqIifSjTclr7z2xupe
 z6mumVeMiodS12p8bRsK645njCf5BilLeRT8XwJnKHOsSeZuqndqNtV7AkOD96ZjlvGp56
 XDQyyIvTEca4dRDKm0jVso9zHVd7K9tiLVYXtXpLPsqc6GhjkysAxrIOAIjLByjk/dacwe
 nM9OEcNzS5rfpq3KILBhY0sfa2Iu+WSILexwLK9MulU8iqYDlKEOkjq4lZ5Y0vQShgak6G
 KPVurs1lR1LArivJw+fC5dWVqEGqEvEuQ+4dlUoKGTKWpzdplg1IUqD3+5D/MA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="ul7FbUE/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LRgeAYtGlhFVqvwJc/Myy5wuBK9KXAPz1nqsbEgp0k4=;
 b=ul7FbUE/QxOmENTbklX7xC6kpkJ0iWqHNlX4dw9Kz5YUYnlYNBLckqQekXNR+X44CnnSrY
 8G1cK6ze/+IV6h9/f5tr95QHobk8Ter8GCRujwsR4Gv9Oqca+MB2QL9WnclOqd0FAgO6vT
 MW99vQKPGBQr7Xc5fmT57aCNYdMWYhQed9M4ner8TSIN5mG7byr3ztvwlbq45YYnQyXMCJ
 7ReZTc9zuDLZ7DFEH7wvAnWw9yYgXTcibJBQm8afxyYTyqLYcS4Fd91kd6iTZo+Wn+ho2S
 0YtO610wMHZCqur0LI/9dOHaC9z6+DC7z03/ykmC90i3TIW3MTqC+cmOXgb6QA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Fix Kconfig indent
Date: Mon, 20 Apr 2026 03:22:33 +0200
Message-ID: <20260420012255.400441-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 377d98a8a8b05a0edf6
X-MBO-RS-META: t4fdj8qumr8ygswqmqsf6qcyqutk1n69
X-Rspamd-Queue-Id: 4fzSR72VVkz9trQ
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

Indent using tabs and two spaces for help text. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Kconfig.32    |  6 +++---
 arch/arm/mach-renesas/Kconfig.rcar3 | 20 ++++++++++----------
 arch/arm/mach-renesas/Kconfig.rcar4 |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig.32 b/arch/arm/mach-renesas/Kconfig.32
index bbc61ccf480..3ee52c40da7 100644
--- a/arch/arm/mach-renesas/Kconfig.32
+++ b/arch/arm/mach-renesas/Kconfig.32
@@ -134,17 +134,17 @@ choice
 config QOS_PRI_NORMAL
 	bool "Non primary"
 	help
-	   Select normal mode for QoS setting.
+	  Select normal mode for QoS setting.
 
 config QOS_PRI_MEDIA
 	bool "Media primary"
 	help
-	   Select multimedia primary mode for QoS setting.
+	  Select multimedia primary mode for QoS setting.
 
 config QOS_PRI_GFX
 	bool "GFX primary"
 	help
-	   Select GFX(graphics) primary mode for QoS setting.
+	  Select GFX(graphics) primary mode for QoS setting.
 
 endchoice
 
diff --git a/arch/arm/mach-renesas/Kconfig.rcar3 b/arch/arm/mach-renesas/Kconfig.rcar3
index 0d5f7486218..8479875178d 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar3
+++ b/arch/arm/mach-renesas/Kconfig.rcar3
@@ -96,35 +96,35 @@ config TARGET_CONDOR
 	bool "Condor board"
 	imply R8A77980
 	help
-          Support for Renesas R-Car Gen3 Condor platform
+	  Support for Renesas R-Car Gen3 Condor platform
 
 config TARGET_V3HSK
 	bool "V3HSK board"
 	help
-          Support for Renesas R-Car Gen3 V3HSK platform
+	  Support for Renesas R-Car Gen3 V3HSK platform
 
 config TARGET_DRAAK
 	bool "Draak board"
 	imply R8A77995
 	help
-          Support for Renesas R-Car Gen3 Draak platform
+	  Support for Renesas R-Car Gen3 Draak platform
 
 config TARGET_EAGLE
 	bool "Eagle board"
 	imply R8A77970
 	help
-          Support for Renesas R-Car Gen3 Eagle platform
+	  Support for Renesas R-Car Gen3 Eagle platform
 
 config TARGET_V3MSK
 	bool "V3MSK board"
 	help
-          Support for Renesas R-Car Gen3 V3MSK platform
+	  Support for Renesas R-Car Gen3 V3MSK platform
 
 config TARGET_EBISU
 	bool "Ebisu board"
 	imply R8A77990
 	help
-          Support for Renesas R-Car Gen3 Ebisu platform
+	  Support for Renesas R-Car Gen3 Ebisu platform
 
 config TARGET_HIHOPE_RZG2
 	bool "HiHope RZ/G2 board"
@@ -135,14 +135,14 @@ config TARGET_HIHOPE_RZG2
 	imply RZ_G2
 	imply SYS_MALLOC_F
 	help
-          Support for RZG2 HiHope platform
+	  Support for RZG2 HiHope platform
 
 config TARGET_SILINUX_EK874
 	bool "Silicon Linux EK874 board"
 	imply R8A774C0
 	imply RZ_G2
 	help
-          Support for Silicon Linux EK874 platform
+	  Support for Silicon Linux EK874 platform
 
 config TARGET_SALVATOR_X
 	bool "Salvator-X board"
@@ -152,7 +152,7 @@ config TARGET_SALVATOR_X
 	imply R8A77965
 	imply SYS_MALLOC_F
 	help
-          Support for Renesas R-Car Gen3 platform
+	  Support for Renesas R-Car Gen3 platform
 
 config TARGET_ULCB
 	bool "ULCB board"
@@ -162,7 +162,7 @@ config TARGET_ULCB
 	imply R8A77965
 	imply SYS_MALLOC_F
 	help
-          Support for Renesas R-Car Gen3 ULCB platform
+	  Support for Renesas R-Car Gen3 ULCB platform
 
 endchoice
 
diff --git a/arch/arm/mach-renesas/Kconfig.rcar4 b/arch/arm/mach-renesas/Kconfig.rcar4
index 04418f7aa05..2439501d07e 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar4
+++ b/arch/arm/mach-renesas/Kconfig.rcar4
@@ -46,7 +46,7 @@ config TARGET_FALCON
 	bool "Falcon board"
 	imply R8A779A0
 	help
-          Support for Renesas R-Car Gen3 Falcon platform
+	  Support for Renesas R-Car Gen3 Falcon platform
 
 config TARGET_SPIDER
 	bool "Spider board"
-- 
2.53.0

