Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B42CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3173888C01;
	Mon,  2 Sep 2024 15:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tqiyZ/JZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DyyRtwmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8AF188C1C; Mon,  2 Sep 2024 15:37:41 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAAF588C01
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wy8vR4Xftz9sSL;
 Mon,  2 Sep 2024 15:37:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725284259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l/Gpjl9UeWhfJsccFrnMrJIsWRdbsawNwAEqV5a3x88=;
 b=tqiyZ/JZoqs16mAKmEUQHBlCOEUVD4Zve2EJ/NrbThEJAKhQFr53EiDINtdo14Of1i0Hk7
 JaxT04ge+EXTv77LQgevxPx1F99DQaVC6NFPpYkquKSHYLgjjL6myCuT2njCu938vvrJDN
 Q2qYaT33KVcsf1uBV+r1Z+RtEfjtaYD7cdl8Ki+aoV8Vdd0p4Vkq0nL8lTIKY3IqeKhFVQ
 Q7jsJvEp31eB2Fzw4oWGuvR0pF9T3i/zVrKwWcSPbSiiAgjXszMOMsFiRHfJDoGklyH8dv
 3EqssmSTx64BpOj4s0NbSGz4/H7eisMAUVRVK6cKV9kVmfCydDnCmyljGtXtgA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725284257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l/Gpjl9UeWhfJsccFrnMrJIsWRdbsawNwAEqV5a3x88=;
 b=DyyRtwmugLaTX2dliD4LOBm3Z+1OAkTDBnuV7zfrcl8/lHo1SOcPRjKD1Hm+CifCV/jeBJ
 iSKf1nw2VShNG/FPg1sqDD6KG7b7KSY/HVnKibszxTS32VPg8CpFsm0nOSVj5KDSPSA9+G
 0DqanAf9zNV5iwAKSSVUu6udKDaxUKLP6DmcP8TOkb88e4OQuMNJK+uQi3WkyzLcduJWfF
 w+KAYXEdIlri0/hBBgRbN+E1DtKqDCt7vqw20mzrzFngnTN4/GSB8qlcwxpKfFbF+X/19k
 zBCAcwrSgs40uCbfziK3zlJAxMV/XrIGMxxrN4sxLwOwbgu73wyMwQUXkQmBww==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] mmc: Hide mmc speed command under mmc command
Date: Mon,  2 Sep 2024 15:37:09 +0200
Message-ID: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: eb94ef459c57daf928d
X-MBO-RS-META: 4zmos111ikf1ej5bei7u3qftxie4cuyz
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

The mmc speed command configuration option keeps showing up in
Kconfig directly in 'Command line interface'. Move MMC_SPEED_MODE_SET
under CMD_MMC to make it show up alongside the MMC command.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Rework the commit message
---
 cmd/Kconfig | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43f78a5aeb1..953e1f0ef2a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1406,6 +1406,15 @@ config CMD_MMC_SWRITE
 	  Enable support for the "mmc swrite" command to write Android sparse
 	  images to eMMC.
 
+config MMC_SPEED_MODE_SET
+	bool "set speed mode using mmc command"
+	help
+	  Enable setting speed mode using mmc rescan and mmc dev commands.
+	  The speed mode is provided as the last argument in these commands
+	  and is indicated using the index from enum bus_mode in
+	  include/mmc.h. A speed mode can be set only if it has already
+	  been enabled in the device tree.
+
 endif
 
 config CMD_CLONE
@@ -2971,16 +2980,6 @@ config CMD_UBIFS
 	help
 	  UBIFS is a file system for flash devices which works on top of UBI.
 
-config MMC_SPEED_MODE_SET
-	bool "set speed mode using mmc command"
-	depends on CMD_MMC
-	help
-	  Enable setting speed mode using mmc rescan and mmc dev commands.
-	  The speed mode is provided as the last argument in these commands
-	  and is indicated using the index from enum bus_mode in
-	  include/mmc.h. A speed mode can be set only if it has already
-	  been enabled in the device tree.
-
 config CMD_MESON
 	bool "Amlogic Meson commands"
 	depends on ARCH_MESON
-- 
2.45.2

