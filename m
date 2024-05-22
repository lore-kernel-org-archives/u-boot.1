Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B41C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9563788414;
	Wed, 22 May 2024 10:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="lHtdLPt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205BB8845E; Wed, 22 May 2024 10:28:57 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE6C87FDD
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id B50421FB57;
 Wed, 22 May 2024 10:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716366534;
 bh=USfRVbzdPlm7BSUn7GUxmnY9KjXe1BxBMKUpLe1JOWs=; h=From:To:Subject;
 b=lHtdLPt7j2QGW5w5RN93NDEVUC/a6V/NhLrMs1Lhkz7hYs+G7qntLR9LhqaU1MO1r
 oxTiZQBJ3cbJpf3kJMpdm8Op616nPIeD728yPBNUDSip+OuW9NmWpu0s1aAhll0kDO
 t//Fed+ZxLOQyeFLFzZMzeLsoIzxR8X2SigHP8IZKFHI2G55K4nEIFGTBDC3aKuk7O
 BSGzpXnmoK6SPhQ5Yv/KwW9K79+pSNjBPD/sCL7u1mlpta2pjMEmXagwH5ym/dVQkt
 W1Q8AXMA3sV+kMLF5ZgmpPt7owVnKrLg0M3KnLgYzRDyLoUOmxIZq7tbEg+Zxdo1Mu
 AYFaNR+qQH8uQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marcel Ziswiler <marcel@ziswiler.com>
Subject: [PATCH] board: toradex: change maintainer to Francesco
Date: Wed, 22 May 2024 10:28:48 +0200
Message-Id: <20240522082848.21536-1-francesco@dolcini.it>
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

Marcel is leaving Toradex and the email will start bouncing in a few
weeks, move maintainership to myself.

Cc: Marcel Ziswiler <marcel@ziswiler.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis-imx8/MAINTAINERS     | 2 +-
 board/toradex/apalis-tk1/MAINTAINERS      | 2 +-
 board/toradex/apalis_imx6/MAINTAINERS     | 2 +-
 board/toradex/apalis_t30/MAINTAINERS      | 2 +-
 board/toradex/colibri-imx6ull/MAINTAINERS | 2 +-
 board/toradex/colibri-imx8x/MAINTAINERS   | 2 +-
 board/toradex/colibri_imx6/MAINTAINERS    | 2 +-
 board/toradex/colibri_imx7/MAINTAINERS    | 2 +-
 board/toradex/colibri_t20/MAINTAINERS     | 2 +-
 board/toradex/colibri_t30/MAINTAINERS     | 2 +-
 board/toradex/colibri_vf/MAINTAINERS      | 2 +-
 board/toradex/verdin-am62/MAINTAINERS     | 2 +-
 board/toradex/verdin-imx8mm/MAINTAINERS   | 2 +-
 board/toradex/verdin-imx8mp/MAINTAINERS   | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/board/toradex/apalis-imx8/MAINTAINERS b/board/toradex/apalis-imx8/MAINTAINERS
index 198399c879ac..761034a516aa 100644
--- a/board/toradex/apalis-imx8/MAINTAINERS
+++ b/board/toradex/apalis-imx8/MAINTAINERS
@@ -1,5 +1,5 @@
 Apalis iMX8
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 S:	Maintained
 F:	arch/arm/dts/fsl-imx8qm-apalis.dts
diff --git a/board/toradex/apalis-tk1/MAINTAINERS b/board/toradex/apalis-tk1/MAINTAINERS
index e2c6f63dcc7d..393c8dcf8016 100644
--- a/board/toradex/apalis-tk1/MAINTAINERS
+++ b/board/toradex/apalis-tk1/MAINTAINERS
@@ -1,5 +1,5 @@
 Apalis TK1
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/apalis-tk1/
 F:	board/toradex/common/
diff --git a/board/toradex/apalis_imx6/MAINTAINERS b/board/toradex/apalis_imx6/MAINTAINERS
index 0b2907bbe709..d84527c06783 100644
--- a/board/toradex/apalis_imx6/MAINTAINERS
+++ b/board/toradex/apalis_imx6/MAINTAINERS
@@ -1,5 +1,5 @@
 Apalis iMX6
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:      https://www.toradex.com/community
 S:	Maintained
diff --git a/board/toradex/apalis_t30/MAINTAINERS b/board/toradex/apalis_t30/MAINTAINERS
index 097db7deb08f..368decf66744 100644
--- a/board/toradex/apalis_t30/MAINTAINERS
+++ b/board/toradex/apalis_t30/MAINTAINERS
@@ -1,5 +1,5 @@
 Apalis T30
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/apalis_t30/
 F:	board/toradex/common/
diff --git a/board/toradex/colibri-imx6ull/MAINTAINERS b/board/toradex/colibri-imx6ull/MAINTAINERS
index ee6fe6c13ead..6c93e35cc65f 100644
--- a/board/toradex/colibri-imx6ull/MAINTAINERS
+++ b/board/toradex/colibri-imx6ull/MAINTAINERS
@@ -1,5 +1,5 @@
 Colibri iMX6ULL
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
diff --git a/board/toradex/colibri-imx8x/MAINTAINERS b/board/toradex/colibri-imx8x/MAINTAINERS
index 8c9bf1f63f43..938c2ca0ca01 100644
--- a/board/toradex/colibri-imx8x/MAINTAINERS
+++ b/board/toradex/colibri-imx8x/MAINTAINERS
@@ -1,5 +1,5 @@
 Colibri iMX8X
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 S:	Maintained
 F:	arch/arm/dts/fsl-imx8x-colibri.dts
diff --git a/board/toradex/colibri_imx6/MAINTAINERS b/board/toradex/colibri_imx6/MAINTAINERS
index 25d3a06a8523..c1067502c082 100644
--- a/board/toradex/colibri_imx6/MAINTAINERS
+++ b/board/toradex/colibri_imx6/MAINTAINERS
@@ -1,5 +1,5 @@
 Colibri iMX6
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:      https://www.toradex.com/community
 S:	Maintained
diff --git a/board/toradex/colibri_imx7/MAINTAINERS b/board/toradex/colibri_imx7/MAINTAINERS
index e4583d5a86a2..80770cc71a96 100644
--- a/board/toradex/colibri_imx7/MAINTAINERS
+++ b/board/toradex/colibri_imx7/MAINTAINERS
@@ -1,5 +1,5 @@
 Colibri iMX7
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
diff --git a/board/toradex/colibri_t20/MAINTAINERS b/board/toradex/colibri_t20/MAINTAINERS
index d0c5b1133313..58842434024f 100644
--- a/board/toradex/colibri_t20/MAINTAINERS
+++ b/board/toradex/colibri_t20/MAINTAINERS
@@ -1,5 +1,5 @@
 COLIBRI_T20
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t20/
 F:	board/toradex/common/
diff --git a/board/toradex/colibri_t30/MAINTAINERS b/board/toradex/colibri_t30/MAINTAINERS
index 006a0e55f113..73859fd25c2e 100644
--- a/board/toradex/colibri_t30/MAINTAINERS
+++ b/board/toradex/colibri_t30/MAINTAINERS
@@ -1,5 +1,5 @@
 Colibri T30
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 F:	board/toradex/colibri_t30/
 F:	board/toradex/common/
diff --git a/board/toradex/colibri_vf/MAINTAINERS b/board/toradex/colibri_vf/MAINTAINERS
index 2e1a74c2db75..a41bd165a7ca 100644
--- a/board/toradex/colibri_vf/MAINTAINERS
+++ b/board/toradex/colibri_vf/MAINTAINERS
@@ -1,5 +1,5 @@
 Colibri VFxx
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
diff --git a/board/toradex/verdin-am62/MAINTAINERS b/board/toradex/verdin-am62/MAINTAINERS
index 3e30d1d51121..3f69ea88c00e 100644
--- a/board/toradex/verdin-am62/MAINTAINERS
+++ b/board/toradex/verdin-am62/MAINTAINERS
@@ -8,6 +8,6 @@ F:	configs/verdin-am62_a53_defconfig
 F:	configs/verdin-am62_r5_defconfig
 F:	doc/board/toradex/verdin-am62.rst
 F:	include/configs/verdin-am62.h
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am-62
diff --git a/board/toradex/verdin-imx8mm/MAINTAINERS b/board/toradex/verdin-imx8mm/MAINTAINERS
index d567f0e1097d..0d58a73b9303 100644
--- a/board/toradex/verdin-imx8mm/MAINTAINERS
+++ b/board/toradex/verdin-imx8mm/MAINTAINERS
@@ -1,5 +1,5 @@
 Verdin iMX8M Mini
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-mini
 S:	Maintained
 F:	arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
diff --git a/board/toradex/verdin-imx8mp/MAINTAINERS b/board/toradex/verdin-imx8mp/MAINTAINERS
index 9fe76d8e42f5..a68344885395 100644
--- a/board/toradex/verdin-imx8mp/MAINTAINERS
+++ b/board/toradex/verdin-imx8mp/MAINTAINERS
@@ -5,6 +5,6 @@ F:	board/toradex/common/
 F:	configs/verdin-imx8mp_defconfig
 F:	doc/board/toradex/verdin-imx8mp.rst
 F:	include/configs/verdin-imx8mp.h
-M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
 W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-plus
-- 
2.39.2

