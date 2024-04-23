Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66281C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 15:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DB68863F;
	Tue, 23 Apr 2024 17:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ldb/CO3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94A888640; Tue, 23 Apr 2024 17:57:17 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACBD8863B
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 17:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id D2F251F91A;
 Tue, 23 Apr 2024 17:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1713887835;
 bh=X78aeR7zf7Mec/y0ztV4Ik1zswbfYq3w0ozp4au1at0=; h=From:To:Subject;
 b=ldb/CO3Pxhuk30DJqq6EkcHz1jw4A36sqqO1oLOZKK+yx/grSUeN+jVLcb/NMzEzv
 foKDsI7rd7hNYsPZnNHwoAVoPSk2mnBg5gpqP7KyWwrLFVIwV8gf3MpmJ+w0IunZCq
 GgdSF2ipe7ZKh3+kCLBNK5NtQxYqsCi7hJOkeHfDC845S/1xCZdqXz9vS1eIfvQIV0
 kiR6JMApWsFeREV9XpF8IcnOo5XNHeGIkc6/GEvVHV9tdOxQwqBD5P4reeC7V2A/xd
 y6zIP3h00jePKmOg1R8qbOFL5LOs5xkRBkdIWhw5GubS+DdoDEgVDjbVubX2HO4ByT
 y/2BtcW/8tU7Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: colibri-imx(6ull|imx7): Fix missing
 fdt_fixup boot error
Date: Tue, 23 Apr 2024 17:57:01 +0200
Message-Id: <20240423155701.33657-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
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

In commit 51aaaf5e7975 ("board: toradex: imx: Remove not needed env variables")
the empty definition of fdt_fixup variable was removed, however this was
still referenced from the boot command leading to boot failures:
 ## Error: \"fdt_fixup\" not defined`

Fix this by removing "run fdt_fixup" from the boot command and instead
enable CONFIG_OF_ENV_SETUP in the defconfig that would achieve the same
but in a more robust way (it works fine even if the variable is not
defined).

Fixes: 51aaaf5e7975 ("board: toradex: imx: Remove not needed env variables")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 configs/colibri-imx6ull_defconfig | 1 +
 configs/colibri_imx7_defconfig    | 1 +
 include/configs/colibri-imx6ull.h | 2 +-
 include/configs/colibri_imx7.h    | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index fc10d7f66a60..4a0ff029ac75 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -18,6 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot || run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 16f923b07c22..f2802b10fa8a 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -19,6 +19,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot ; echo ; echo ubiboot failed ; run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb "
diff --git a/include/configs/colibri-imx6ull.h b/include/configs/colibri-imx6ull.h
index 7c9d633b68d9..8860ceec1a0a 100644
--- a/include/configs/colibri-imx6ull.h
+++ b/include/configs/colibri-imx6ull.h
@@ -53,7 +53,7 @@
 		"ubi part ubi &&" \
 		"ubi read ${kernel_addr_r} kernel && " \
 		"ubi read ${fdt_addr_r} dtb && " \
-		"run fdt_fixup && bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
+		"bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
 
 #if defined(CONFIG_TARGET_COLIBRI_IMX6ULL_NAND)
 /* Run Distro Boot script if ubiboot fails */
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index c34f1f903df6..33133a0b96e1 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -94,7 +94,7 @@
 		"ubi part ubi && run m4boot && " \
 		"ubi read ${kernel_addr_r} kernel && " \
 		"ubi read ${fdt_addr_r} dtb && " \
-		"run fdt_fixup && bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
+		"bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
 
 #if defined(CONFIG_TARGET_COLIBRI_IMX7_NAND)
 #define MODULE_EXTRA_ENV_SETTINGS \
-- 
2.39.2

