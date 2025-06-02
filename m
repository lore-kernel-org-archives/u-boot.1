Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B729FC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 10:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FEB82045;
	Mon,  2 Jun 2025 12:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hgrp72Dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F12E8212B; Mon,  2 Jun 2025 12:16:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4508E81FFC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 12:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AE49322B44;
 Mon,  2 Jun 2025 12:16:25 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQG7O2uN3qrh; Mon,  2 Jun 2025 12:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748859367; bh=QMEC4dU8+v4jyxIYzFbnDpYrP27K8EvCnKAMOxnOCh0=;
 h=From:To:Cc:Subject:Date;
 b=hgrp72DcSy0H0u+LBu7zADEC3I474IYrPtsDwwE3H1HHm8eIb96Y6n9Sbq/+BjXCJ
 ShHd6v7+WwioFTu68WNZU4m1v8Ybqv63T270tK+2/ZUb65O0MTmNXgLx7myJewKkBf
 83P6K4dc9SZtdceeq7n2niXfcw6VuxRyyfZwO35Bh70zqpVALt3AGrhXsCiU2OJ4Ty
 RHoYH9kIqrDQHeSqSxbYLaAT4ZxHgzs/niTOuF2LEj3ARn05XnHEYAsfRDTMuZDlh5
 u01XmKo/q1ImRo/bszhW/lgUZ3AZwpJPb5tPVxrkKMz1kZ7O2VDY5BX3sY/ZxjGYGo
 DgB3oFlF9gl5g==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] ram: Move Kconfig options into their own menu entry
Date: Mon,  2 Jun 2025 10:15:15 +0000
Message-ID: <20250602101515.37384-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

RAM drivers using Device Model currently lack of their own Kconfig menu
entry, which makes Kconfig put all options of the class in the top-level
menu of device drivers. These options are also incorrectly grouped with
pinctrl options in the generated .config, which is hard to read. Let's
create a menu entry for these drivers.

Fixes: 6c51df6859f ("dm: Add support for RAM drivers")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/ram/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 39d03e8d3d3..edb8e254d5b 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -1,3 +1,5 @@
+menu "RAM drivers using Driver Model"
+
 config RAM
 	bool "Enable RAM drivers using Driver Model"
 	depends on DM
@@ -136,3 +138,5 @@ source "drivers/ram/stm32mp1/Kconfig"
 source "drivers/ram/starfive/Kconfig"
 source "drivers/ram/sunxi/Kconfig"
 source "drivers/ram/thead/Kconfig"
+
+endmenu
-- 
2.49.0

