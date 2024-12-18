Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F41E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 19:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC74980312;
	Wed, 18 Dec 2024 20:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A3D802B4; Wed, 18 Dec 2024 20:47:36 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824808022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 20:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1tO017-002gKQ-8U;
 Wed, 18 Dec 2024 19:47:33 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m*-venice: define suitable address for
 SPL_LOAD_FIT_ADDRESS
Date: Wed, 18 Dec 2024 11:47:31 -0800
Message-Id: <20241218194731.1867864-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

define a suitable default address for CONFIG_SPL_LOAD_FIT_ADDRESS
to make it easier on folks enabling HABv4.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 configs/imx8mm_venice_defconfig | 1 +
 configs/imx8mn_venice_defconfig | 1 +
 configs/imx8mp_venice_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index da248e4887e7..5f3c5be90ec6 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -31,6 +31,7 @@ CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 44af3e61d5d3..38fc7e7f8255 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -30,6 +30,7 @@ CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index bf296b13e2be..faf696fdbd1d 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-- 
2.25.1

