Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EF6CD8CA8
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 01:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4E98484C;
	Sun, 14 Jun 2026 03:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pjQ14kvk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZHyVskwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C558485F; Sun, 14 Jun 2026 03:52:40 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BEE58484F
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 03:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gdGTy0n1bz9tq0;
 Sun, 14 Jun 2026 03:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781401958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BjjP5WIHBvz7jCWCqRj0viCeYplByxEDOTszGbMfWnk=;
 b=pjQ14kvkoeZ4ZD3Qx3SGGNr2gwSpX7hTiZBtARNJecA0zPN/zmeuVz8bwIaU7UARVChlu1
 krNcBrBXIKb7KCyMj6aGn8tPr8uFlcLVfMpwjII3iU/RaVD0JhZLlDrXuSN6UWzDiYIJXa
 nMFvPKmqI6yhhPfu5B+zYsT8nJCy8J6q1qiynF8FhKXFTYmnStMdao4y4tdtXsNkB7gvxt
 2yUBt4jlPid0TZ5vvw1KL5B7B9DTT9WHqgTpEMsP9nKTKJxNP0AdfLfTmvpYH4e99EMgvS
 WS81XaWNjbi1X6qJyeoGYFsFqrTU/XXZ+k5cCkACcuLDAEYV/dvrEfgcb8oUoQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZHyVskwZ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781401956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BjjP5WIHBvz7jCWCqRj0viCeYplByxEDOTszGbMfWnk=;
 b=ZHyVskwZLdqHlIPoaTcUZYCddsCeKGXP6p0csONbTIqf0X2H7poDDuu9E3g3zlcoONSPZA
 dkt9f4FtI14f1HpYBL80XK4FTfjCdikTHSSRB0IaQ1/xzwtzcX7CaFZ6V0T23+FBsyH/IA
 s+njKHnoTIQ/zZRcEPa1FuvymZMd01D5p7JbJijjANhqLNPaK2HBlTkBxUtL6f3U+kAd2A
 Z+So1GTvgQ/w5He8jvvKa/cd+V23eapYx9qxmUJLXZ0qBMXUwo2tIfYPMG1OX351Vrm04x
 D/cTEV6J6RIAavCmlbOj4BTRyk4jpSHW2o4YSIcL4uaMbwg4dumCMnQXEAdj+w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Initialize GIC600 fully on R-Car S4/V4H/V4M
Date: Sun, 14 Jun 2026 03:52:21 +0200
Message-ID: <20260614015232.341753-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3j16yqqg17hgts6cu5oouycwq4iwqrbj
X-MBO-RS-ID: 122dbca5baaec941ade
X-Rspamd-Queue-Id: 4gdGTy0n1bz9tq0
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

ARM GIC-600 IP complies with ARM GICv3 architecture, but among others,
implements a power control register in the Redistributor frame. This
register must be programmed to mark the frame as powered on, before
accessing other registers in the frame.

Before the switch to generic lowlevel_init function, this did not pose
a problem as the previous custom lowlevel_init did not access the GICR
registers. The generic function does and that does lead to a hang early
in SPL. Enable the GIC600 initialization variant to mitigate the hang.

Fixes: 37997a214ed1 ("arm: renesas: Use stock lowlevel_init function and remove s_init")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Kconfig.rcar4 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-renesas/Kconfig.rcar4 b/arch/arm/mach-renesas/Kconfig.rcar4
index 2439501d07e..39814950b1a 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar4
+++ b/arch/arm/mach-renesas/Kconfig.rcar4
@@ -11,12 +11,14 @@ config R8A779A0
 config R8A779F0
 	bool "Renesas SoC R8A779F0"
 	select GICV3
+	select GICV3_SUPPORT_GIC600
 	imply CLK_R8A779F0
 	imply PINCTRL_PFC_R8A779F0
 
 config R8A779G0
 	bool "Renesas SoC R8A779G0"
 	select GICV3
+	select GICV3_SUPPORT_GIC600
 	select BINMAN
 	select SUPPORT_SPL
 	imply SPL
@@ -33,6 +35,7 @@ config R8A779G0
 config R8A779H0
 	bool "Renesas SoC R8A779H0"
 	select GICV3
+	select GICV3_SUPPORT_GIC600
 	imply CLK_R8A779H0
 	imply PINCTRL_PFC_R8A779H0
 
-- 
2.53.0

