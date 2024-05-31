Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91AFC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CC6887F0;
	Fri, 31 May 2024 17:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dcD1iF0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8D58831F; Fri, 31 May 2024 17:11:01 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA07887DA
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 17:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717168253;
 bh=yIESH8zvTIa+Kegnpe4ViaHGTbyjFeN5gC6UFL+OlB4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dcD1iF0O5vTo4R4jTwQB2MFd3r+h9cqixSUeExvK0Bs+1HxaM1yKcWJob2wuvCrtV
 SjDbgA5eJuFQDEKqZE9GP3FBR2Q4nnI5yQuYHueGbS+2oc2WVUfQCP1mj7Aaac7EFK
 UF69fXM0sPCwE8GxtuhBVmNVJkW4IoD+TJCwZFtozKcTqsHJajF6fDxifNGg9uJVam
 rfJokO/oiXnGhrye1hGkiMFJ1gVix3cvMtl5HXnCEukKhiAd8tUSvcLQJB7QGKOIuQ
 ptw0JybH822J/EoXraCe+x6unZWoadlfgggFhC37E+GtXxy9wipxruzDhcsteEydra
 dHEJjo+EacL5A==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 666B837821DF;
 Fri, 31 May 2024 15:10:53 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id E61024800CF; Fri, 31 May 2024 17:10:52 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v1 4/5] board: rock5b-rk3588: enable USB-C in operating system
Date: Fri, 31 May 2024 17:08:16 +0200
Message-ID: <20240531151026.84846-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531151026.84846-1-sebastian.reichel@collabora.com>
References: <20240531151026.84846-1-sebastian.reichel@collabora.com>
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

Since older U-Boot releases do not negotiate USB PD, the kernel
DT may not enable the USB-C controller by default to avoid a
regression. The plan is to upstream it with 'status = "fail";'
instead. U-Boot should then mark it as 'status = "okay";' if
it negotiated USB PD.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
FWIW, I have not yet send the kernel patch, since I want the following
patch to be applied first:

https://lore.kernel.org/linux-usb/20240523171806.223727-1-sebastian.reichel@collabora.com/
---
 board/radxa/rock5b-rk3588/rock5b-rk3588.c | 11 +++++++++++
 configs/rock5b-rk3588_defconfig           |  1 +
 2 files changed, 12 insertions(+)

diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
index 75856ccb1288..d688ef20b79c 100644
--- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2023-2024 Collabora Ltd.
  */
 
+#include <fdtdec.h>
+#include <fdt_support.h>
 #include <usb/tcpm.h>
 
 #ifdef CONFIG_MISC_INIT_R
@@ -20,3 +22,12 @@ int misc_init_r(void)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	if (IS_ENABLED(CONFIG_MISC_INIT_R))
+		fdt_status_okay_by_compatible(blob, "fcs,fusb302");
+	return 0;
+}
+#endif
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index e368b0439d1d..f056728d338b 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -23,6 +23,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-- 
2.43.0

