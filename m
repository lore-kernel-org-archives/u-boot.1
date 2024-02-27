Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0903FC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDE088072;
	Tue, 27 Feb 2024 17:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rnLnDbfI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="APCckuuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8DB88012; Tue, 27 Feb 2024 17:10:27 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D382F88022
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkjBR4Lfcz9sl6;
 Tue, 27 Feb 2024 17:10:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ls/ofI/6Fma5eKXKXB/M6zp0iuRmcQ0higCbG7Xz0fk=;
 b=rnLnDbfIjmfQlat9GU0m9KagooJYS6LINDNW5/RPYbD3lwferRbKMc0HGFDG7NwzW1m4tj
 u2KjK19WbdA9LvU9C+YAANiLrNAUqjgpqEUnI/DUfoE7MHJ4S7zcVy1YHaWMn3aKK77eo1
 SQXGQ8K1i3VaumaqMU/zwh0g8z5qUErGYprhHQsOGGQwiTRfDrVtuMHt+OkWO7ibKta5pB
 2xFmsAN/UEDZWnYUUX/R1hu+QPU3DykoOLmqZOVzZtXmTLTZO9iUhcaeguhAzzYXRUY9tE
 iAnAgbI6wSfpfxXDsDW0litqwEuFXopVwvNwR5/XEfCPL3M3AZcsgjceQu9moQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ls/ofI/6Fma5eKXKXB/M6zp0iuRmcQ0higCbG7Xz0fk=;
 b=APCckuuBtMKXYMgEmqxwJLWPYyE3+gQXg/Hc/enRzdn4g59wlUSRaenyw0sqEsHh3EFEj9
 XsHy19xGoOVR1MuQEaLtkUNfjjKY1YBHjiJ54QRVBQ23/NHK4cvUvXIy9QabYcMrN6KX5p
 C75UZKhTUiMxyvCxlSqD5vXD7fQi3P6CFRrKu+a9Z3c8l7q/PwJ6fWK9toAnPAzXuBQSiP
 qlNEKOXAxmCAhKOnE1y74PBTA7x6tXklg1un4acZJqrTtANGiOo9YqI0J+HdRy60uMno/7
 TO7ehhSJyy5ci9/FlQRMSnaNW3X/o7fqtI9Ht8La66MAnqkrFYKP2HXx5BOk9Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/19] ARM: renesas: Post rename fix ups
Date: Tue, 27 Feb 2024 17:05:57 +0100
Message-ID: <20240227160912.412181-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bkqub9sr6zr9fqdwey9eug9osxxsfksd
X-MBO-RS-ID: 595c3fe9358cea56827
X-Rspamd-Queue-Id: 4TkjBR4Lfcz9sl6
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

Fix up remains of rename from rmobile to renesas,
namely file paths and remaining RMOBILE strings.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-renesas/cpu_info-rcar.c      | 2 +-
 arch/arm/mach-renesas/emac.c               | 2 +-
 arch/arm/mach-renesas/lowlevel_init_ca15.S | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-renesas/cpu_info-rcar.c b/arch/arm/mach-renesas/cpu_info-rcar.c
index 94188362155..74140fd38ab 100644
--- a/arch/arm/mach-renesas/cpu_info-rcar.c
+++ b/arch/arm/mach-renesas/cpu_info-rcar.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * arch/arm/cpu/armv7/rmobile/cpu_info-rcar.c
+ * arch/arm/mach-renesas/cpu_info-rcar.c
  *
  * Copyright (C) 2013,2014 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-renesas/emac.c b/arch/arm/mach-renesas/emac.c
index 95651626da4..03bca8851ae 100644
--- a/arch/arm/mach-renesas/emac.c
+++ b/arch/arm/mach-renesas/emac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * RMOBILE EtherMAC initialization.
+ * Renesas EtherMAC initialization.
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
  * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
diff --git a/arch/arm/mach-renesas/lowlevel_init_ca15.S b/arch/arm/mach-renesas/lowlevel_init_ca15.S
index a52b761b25d..059cd738785 100644
--- a/arch/arm/mach-renesas/lowlevel_init_ca15.S
+++ b/arch/arm/mach-renesas/lowlevel_init_ca15.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/cpu/armv7/rmobile/lowlevel_init_ca15.S
+ * arch/arm/mach-renesas/lowlevel_init_ca15.S
  *     This file is lager low level initialize.
  *
  * Copyright (C) 2013, 2014 Renesas Electronics Corporation
-- 
2.43.0

