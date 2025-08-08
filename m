Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0238BC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352C6846CE;
	Fri,  8 Aug 2025 13:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PKdG3PV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1305846D0; Fri,  8 Aug 2025 13:40:24 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC4C846CC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CB020104870; Fri,  8 Aug 2025 13:40:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1754653220; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=bv9c6fHjJoCKcdP+p681vKzQbI0jeWQSZ34oS249KqY=;
 b=PKdG3PV04Mxh2cnfi5Y/iD3hl0yK8u9gwZPxVRJTCRWlsq3U29wu03ZmDCA38zHKsSdsnS
 1BoRiAgvlGZCeP+4kxthEHSTiPn9jIwsdhcr870LBwtbDb0brK7FCVsSKlz/lkoAi36atP
 ISZ2kivTG0ZcRYk95xxwKpeIifbrK+4piAthLjciSAV4j5kKW8zXBtnLySi7xqYfbxiAR7
 KEhhKN/j/dfukDDb6GTzoFrDVYsK2uxJy2vdqhdEUk3XIHPuHWjCUMBpbDxUVNOPwCxKQ1
 YfjlqQAdvlDkOj5V70XTe6z63KuVbYk2xHyPD2QJyxijXoiabpfvkmU+qE0xiQ==
From: Heiko Schocher <hs@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Enrico Leto <enrico.leto@siemens.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 No generic patch CC mail please <noreply@example.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH] MAINTAINERS: update email address of Heiko Schocher
Date: Fri,  8 Aug 2025 13:40:14 +0200
Message-Id: <20250808114014.121402-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

use the new email address for community work.

While at it, cleanup git shortlog output, by adding
fixes in .mailmap

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=185&view=results

 .mailmap                            | 5 +++++
 MAINTAINERS                         | 6 +++---
 board/aristainetos/MAINTAINERS      | 2 +-
 board/bosch/shc/MAINTAINERS         | 2 +-
 board/keymile/km83xx/MAINTAINERS    | 2 +-
 board/siemens/capricorn/MAINTAINERS | 2 +-
 board/siemens/corvus/MAINTAINERS    | 2 +-
 board/siemens/smartweb/MAINTAINERS  | 2 +-
 board/siemens/taurus/MAINTAINERS    | 2 +-
 board/socrates/MAINTAINERS          | 2 +-
 doc/git-mailrc                      | 2 +-
 11 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/.mailmap b/.mailmap
index 67a42217cf8..f15697ca2df 100644
--- a/.mailmap
+++ b/.mailmap
@@ -48,6 +48,11 @@ Greg Malysa <malysagreg@gmail.com> <greg.malysa@timesys.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
 Harsha <harsha.harsha@amd.com> <harsha.harsha@xilinx.com>
 Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
+Heiko Schocher <hs@nabladev.com> <hs@denx.de>
+Heiko Schocher <hs@nabladev.com> <hs@pollux.denx.de>
+Heiko Schocher <hs@nabladev.com> <heiko.schocher@invitel.hu>
+Heiko Schocher <hs@nabladev.com> <[hs@denx.de]>
+Heiko Schocher <hs@nabladev.com> <hs@pollux.(none)>
 Heinrich Schuchardt <xypron.glpk@gmx.de> <heinrich.schuchardt@canonical.com>
 Heinrich Schuchardt <xypron.glpk@gmx.de> xypron.glpk@gmx.de <xypron.glpk@gmx.de>
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com> <ibai.erkiaga-elorza@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c4587bf86..05291ed1ad0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1244,7 +1244,7 @@ F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
 I2C
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
@@ -1498,7 +1498,7 @@ F:	drivers/pci_endpoint/
 F:  include/pci_ep.h
 
 PCI MPC85xx
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	drivers/pci/pci_mpc85xx.c
 
@@ -1795,7 +1795,7 @@ F:	lib/optee
 
 UBI
 M:	Kyungmin Park <kmpark@infradead.org>
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
diff --git a/board/aristainetos/MAINTAINERS b/board/aristainetos/MAINTAINERS
index c81bef9cb7c..77d7b1614c8 100644
--- a/board/aristainetos/MAINTAINERS
+++ b/board/aristainetos/MAINTAINERS
@@ -1,5 +1,5 @@
 ARISTAINETOS BOARD
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/aristainetos/
 F:	include/configs/aristainetos2.h
diff --git a/board/bosch/shc/MAINTAINERS b/board/bosch/shc/MAINTAINERS
index 58104cc1318..a30c672e1d6 100644
--- a/board/bosch/shc/MAINTAINERS
+++ b/board/bosch/shc/MAINTAINERS
@@ -1,5 +1,5 @@
 SHC BOARD
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/bosch/shc
 F:	include/configs/am335x_shc.h
diff --git a/board/keymile/km83xx/MAINTAINERS b/board/keymile/km83xx/MAINTAINERS
index 8822e5d9155..af0d6afb2b4 100644
--- a/board/keymile/km83xx/MAINTAINERS
+++ b/board/keymile/km83xx/MAINTAINERS
@@ -1,6 +1,6 @@
 KM83XX BOARD
 M:	Holger Brunck <holger.brunck@hitachienergy.com>
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/keymile/km83xx/
 F:	board/keymile/common/
diff --git a/board/siemens/capricorn/MAINTAINERS b/board/siemens/capricorn/MAINTAINERS
index 9c8c7a6ecdc..6c253983cf0 100644
--- a/board/siemens/capricorn/MAINTAINERS
+++ b/board/siemens/capricorn/MAINTAINERS
@@ -1,6 +1,6 @@
 CAPRICORN BOARD
 M:	Alexander Sverdlin <alexander.sverdlin@siemens.com>
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 M:	Walter Schweizer <walter.schweizer@siemens.com>
 S:	Maintained
 F:	arch/arm/dts/imx8-capricorn-cxg3.dts
diff --git a/board/siemens/corvus/MAINTAINERS b/board/siemens/corvus/MAINTAINERS
index 59176aae575..4471cf3ce3c 100644
--- a/board/siemens/corvus/MAINTAINERS
+++ b/board/siemens/corvus/MAINTAINERS
@@ -1,5 +1,5 @@
 CORVUS BOARD
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/siemens/corvus/
 F:	include/configs/corvus.h
diff --git a/board/siemens/smartweb/MAINTAINERS b/board/siemens/smartweb/MAINTAINERS
index 51298ffb5d6..09d7667241c 100644
--- a/board/siemens/smartweb/MAINTAINERS
+++ b/board/siemens/smartweb/MAINTAINERS
@@ -1,5 +1,5 @@
 SMARTWEB_HW BOARD
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/siemens/smartweb
 F:	include/configs/smartweb.h
diff --git a/board/siemens/taurus/MAINTAINERS b/board/siemens/taurus/MAINTAINERS
index 74e3518e0d9..c17bd51a0de 100644
--- a/board/siemens/taurus/MAINTAINERS
+++ b/board/siemens/taurus/MAINTAINERS
@@ -1,5 +1,5 @@
 TAURUS BOARD
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/siemens/taurus/
 F:	include/configs/taurus.h
diff --git a/board/socrates/MAINTAINERS b/board/socrates/MAINTAINERS
index 2b27a73c18c..d5571b0da4f 100644
--- a/board/socrates/MAINTAINERS
+++ b/board/socrates/MAINTAINERS
@@ -1,5 +1,5 @@
 SOCRATES BOARD
-M:	Heiko Schocher <hs@denx.de>
+M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	board/socrates/
 F:	include/configs/socrates.h
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 747ceda3307..65626d89eac 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -23,7 +23,7 @@ alias bmeng          Bin Meng <bmeng.cn@gmail.com>
 alias danielschwierzeck Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
 alias dinh           Dinh Nguyen <dinguyen@kernel.org>
 alias ehristev       Eugen Hristev <eugen.hristev@linaro.org>
-alias hs             Heiko Schocher <hs@denx.de>
+alias hs             Heiko Schocher <hs@nabladev.com>
 alias freenix        Peng Fan <peng.fan@nxp.com>
 alias iwamatsu       Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 alias jaehoon        Jaehoon Chung <jh80.chung@samsung.com>
-- 
2.20.1

base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
