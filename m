Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AEBC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 13:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DAD87640;
	Mon, 11 Dec 2023 14:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1CF87682; Mon, 11 Dec 2023 14:45:30 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F893871B2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 597DB2075D;
 Mon, 11 Dec 2023 14:45:27 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] configs: verdin-am62: Disable SPL FIT Overlay
Date: Mon, 11 Dec 2023 14:45:20 +0100
Message-Id: <20231211134520.162773-1-francesco@dolcini.it>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Disable CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY, this is not required nor used
on verdin am62, disable it to save precious binary size.

Update defconfig using savedefconfig, this adds CONFIG_OF_LIBFDT_OVERLAY
explicitly.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 configs/verdin-am62_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 780860180879..cdd6ba8baed4 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -17,6 +17,7 @@ CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am625-verdin-wifi-dev"
 CONFIG_SPL_TEXT_BASE=0x80080000
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -33,7 +34,6 @@ CONFIG_SYS_MEMTEST_END=0xB0000000
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
-- 
2.25.1

