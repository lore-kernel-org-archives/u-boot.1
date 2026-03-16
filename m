Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C868F3028A
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 00:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D4584485;
	Mon, 16 Mar 2026 01:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SIgvUPFm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GNnhy3Yi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A83A8448C; Mon, 16 Mar 2026 01:31:54 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF7E8447F
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 01:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fYwyJ04HBz9tRk;
 Mon, 16 Mar 2026 01:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773621112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tbr2bms9Rk860yiyKvvRmEMWnp0OZJuqG4deiSzbM6Q=;
 b=SIgvUPFmmdJC3h/LEBK2nVFTV5Z9ORt3KOuRF1UOMVVdITHLso5KL47lLWN2SnMXpK8j7L
 hdo+OVMSPYT1vHt08IBz7Diz3ZL9+T2YhgoXzr/zFt/jvQywtUcEAy3Tzp2Q1U7CGBx8am
 rK6WlIhqESJUF4HTy2OfZFnILgRAR+1TKRNTfKmzT9/cXtyoX74V1CKd0+hA8kobw2dWhR
 zyM4PCcJvvtTO6hwzdM1AFLdzZkAAAIv4w8ZBLZn52lgrezUlO/BJLIDGuJa5wxBoiKsjm
 WSRlYB8rWmUeLn+WzwdW4gzYraRuY8bzxciiFgh1k8SNJk8f0bSHza/OPuF9fA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773621110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tbr2bms9Rk860yiyKvvRmEMWnp0OZJuqG4deiSzbM6Q=;
 b=GNnhy3Yi9scaHb+ywrOQtqDkr2YgWtup5/DWmDS4xsdtDIdwMlhq8wMYLwV9dD+cN1d1oX
 PdXmTMqb5F2CNgXMfOaXujRQxav4/n/7A4n+y3l61zXNYCwzhRNxUTU2kGwqfJSQeacYQ0
 ypv90XMH8tQoiGz9uoxH+cSH8PuMmG5Luo0hQqkWZ87QTxwiXfFYmnBDQf+mAOO+XUzG6g
 ri1zmHIZRaU+tZtyUSACLnkCU1Af/ucfLH5eM5b+MZuqRAKcn8VqjIwdQp6mDuRSChHlq0
 ztfGO1eMgJlR5PCaAsA8Z6AOvnXTR5exWKHKaxjjUyObX7RQhcHm2OiE04/sZg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] remoteproc: renesas: apmu: Fix typo in Kconfig symbol help
 text
Date: Mon, 16 Mar 2026 01:31:33 +0100
Message-ID: <20260316003148.306056-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: swadwbwo7cpcw5757abkaax6u4aibbso
X-MBO-RS-ID: 147742875dbb0b17744
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

Fix typo in Kconfig symbol help text, change incorrect A52 to correct R52.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/remoteproc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index a819770b465..7f9e35283f9 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -45,7 +45,7 @@ config REMOTEPROC_RENESAS_APMU
 	select REMOTEPROC
 	depends on ARCH_RENESAS && RCAR_GEN4 && DM && OF_CONTROL
 	help
-	  Say 'y' here to add support for Renesas R-Car Gen4 Cortex-A52
+	  Say 'y' here to add support for Renesas R-Car Gen4 Cortex-R52
 	  processor via the remoteproc framework.
 
 config REMOTEPROC_RENESAS_RSIP
-- 
2.51.0

