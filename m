Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD43C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22B98070C;
	Sat, 18 Jan 2025 12:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dfbnAEWy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ciw47ycT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364658063E; Sat, 18 Jan 2025 12:16:56 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C84280312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZvFJ1Wt9z9sTd;
 Sat, 18 Jan 2025 12:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pKaWF+2Od1PF1u3oftLLfB8eniGo/To0rrsV3OYZr3M=;
 b=dfbnAEWyFoo+s+TonKzTxfCfB1j0OSgF4cBmp1Zt+ZG6oZ9EhLeq8mepwUigQzKyGLHpcS
 OSbXsnepNrmJX9hPMPJLphAVXbGQG1MgRiXzktaPirOhAHraYuwzN2kEFFLfSzbXOahHy2
 2xlQC+QWQl3zAbdQEgThse5HjLQeckNdMHq3YTSVlnfUsZeSuR2d/1S7aQXWHOFLhhGD4A
 5uNyspXDYlJfN4JHnWKDPyOLG7mvp0gGaJtl6IuErhK2XJwnkUD0bb9+UVBTU0qdLQ6H+c
 AHwW4dpzsOISgLMSrw9L2mk5XJqd9oZKKP6LtyAEGRg/TxHiOla+G1jm19Py/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pKaWF+2Od1PF1u3oftLLfB8eniGo/To0rrsV3OYZr3M=;
 b=ciw47ycTUFi/u/O7oEqvMgaVnFsx7Is7CWf/UKbA+2EB64OXBUIi2wTrbCSj3FMjPZznhR
 t4YmwJm9rRX8cl9iumXk9knDAnIzmufoK9Yuntc24Nk+HMbJe+wvsJon2QOXRrpT9XdnTO
 c4haavqLqRdy6JzDOLXcHGY5d7kqkifoAe8kPI2PwM8W3jcTspw5meIdUelizCfe0MzOvn
 LnUBrcwIvPzZN6IqT9SIlspAfu8NzpZ/HC2CtlVRhu2GJvWIepnI7EKdFXwF2456OjHXi2
 c+oDI9F1mc+cRYFDCLqcWabzFKzsQrpYldpZmhwrT28q3vnQFgTOmW7B4hvu8w==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] ARM: renesas: Rename board/renesas/rcar-common to
 board/renesas/common
Date: Sat, 18 Jan 2025 12:15:24 +0100
Message-ID: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hsnxdkq5rs1t8pfpmx4czxo57s6oub19
X-MBO-RS-ID: aac0d76da43587facd2
X-Rspamd-Queue-Id: 4YZvFJ1Wt9z9sTd
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

Rename directory board/renesas/rcar-common to board/renesas/common and
move files. This allows the build system to use HAVE_VENDOR_COMMON_LIB
which automatically includes board/$(VENDOR)/common/Makefile . Create
temporarily empty board/renesas/common/Makefile to be extended with
actual content later in this series. This is a preparatory patch for
board Makefile simplification. No functional change so far.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: Depends on https://patchwork.ozlabs.org/project/uboot/patch/20250112223252.179123-1-marek.vasut+renesas@mailbox.org/
---
V2: - Create empty Makefile in board/renesas/common/Makefile
    - Update commit message
---
 board/beacon/beacon-rzg2m/Makefile                  | 2 +-
 board/hoperun/hihope-rzg2/Makefile                  | 2 +-
 board/renesas/common/Makefile                       | 0
 board/renesas/{rcar-common => common}/common.c      | 2 +-
 board/renesas/{rcar-common => common}/gen3-common.c | 2 +-
 board/renesas/{rcar-common => common}/gen3-spl.c    | 0
 board/renesas/{rcar-common => common}/gen4-common.c | 2 +-
 board/renesas/{rcar-common => common}/gen4-spl.c    | 0
 board/renesas/{rcar-common => common}/v3-common.c   | 0
 board/renesas/condor/Makefile                       | 4 ++--
 board/renesas/draak/Makefile                        | 4 ++--
 board/renesas/eagle/Makefile                        | 4 ++--
 board/renesas/ebisu/Makefile                        | 4 ++--
 board/renesas/falcon/Makefile                       | 4 ++--
 board/renesas/grayhawk/Makefile                     | 2 +-
 board/renesas/salvator-x/Makefile                   | 4 ++--
 board/renesas/spider/Makefile                       | 2 +-
 board/renesas/ulcb/Makefile                         | 4 ++--
 board/renesas/v3hsk/Makefile                        | 4 ++--
 board/renesas/v3msk/Makefile                        | 4 ++--
 board/renesas/whitehawk/Makefile                    | 4 ++--
 board/silinux/ek874/Makefile                        | 4 ++--
 22 files changed, 29 insertions(+), 29 deletions(-)
 create mode 100644 board/renesas/common/Makefile
 rename board/renesas/{rcar-common => common}/common.c (97%)
 rename board/renesas/{rcar-common => common}/gen3-common.c (99%)
 rename board/renesas/{rcar-common => common}/gen3-spl.c (100%)
 rename board/renesas/{rcar-common => common}/gen4-common.c (97%)
 rename board/renesas/{rcar-common => common}/gen4-spl.c (100%)
 rename board/renesas/{rcar-common => common}/v3-common.c (100%)

diff --git a/board/beacon/beacon-rzg2m/Makefile b/board/beacon/beacon-rzg2m/Makefile
index 332b41f35c0..6a6ae94def8 100644
--- a/board/beacon/beacon-rzg2m/Makefile
+++ b/board/beacon/beacon-rzg2m/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= beacon-rzg2m.o ../../renesas/rcar-common/gen3-common.o ../../renesas/rcar-common/common.o
+obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
diff --git a/board/hoperun/hihope-rzg2/Makefile b/board/hoperun/hihope-rzg2/Makefile
index 700e26daa2b..a42c55b9d00 100644
--- a/board/hoperun/hihope-rzg2/Makefile
+++ b/board/hoperun/hihope-rzg2/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= hihope-rzg2.o ../../renesas/rcar-common/gen3-common.o ../../renesas/rcar-common/common.o
+obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/board/renesas/rcar-common/common.c b/board/renesas/common/common.c
similarity index 97%
rename from board/renesas/rcar-common/common.c
rename to board/renesas/common/common.c
index 90eb468e4c4..7fba8d10ff5 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/common/common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * board/renesas/rcar-common/common.c
+ * board/renesas/common/common.c
  *
  * Copyright (C) 2013 Renesas Electronics Corporation
  * Copyright (C) 2013 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
diff --git a/board/renesas/rcar-common/gen3-common.c b/board/renesas/common/gen3-common.c
similarity index 99%
rename from board/renesas/rcar-common/gen3-common.c
rename to board/renesas/common/gen3-common.c
index 004feca6180..05b01c846c6 100644
--- a/board/renesas/rcar-common/gen3-common.c
+++ b/board/renesas/common/gen3-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * board/renesas/rcar-common/gen3-common.c
+ * board/renesas/common/gen3-common.c
  *
  * Copyright (C) 2013 Renesas Electronics Corporation
  * Copyright (C) 2013 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
diff --git a/board/renesas/rcar-common/gen3-spl.c b/board/renesas/common/gen3-spl.c
similarity index 100%
rename from board/renesas/rcar-common/gen3-spl.c
rename to board/renesas/common/gen3-spl.c
diff --git a/board/renesas/rcar-common/gen4-common.c b/board/renesas/common/gen4-common.c
similarity index 97%
rename from board/renesas/rcar-common/gen4-common.c
rename to board/renesas/common/gen4-common.c
index 2abe9660cf8..52a0639073b 100644
--- a/board/renesas/rcar-common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * board/renesas/rcar-common/gen4-common.c
+ * board/renesas/common/gen4-common.c
  *
  * Copyright (C) 2021-2024 Renesas Electronics Corp.
  */
diff --git a/board/renesas/rcar-common/gen4-spl.c b/board/renesas/common/gen4-spl.c
similarity index 100%
rename from board/renesas/rcar-common/gen4-spl.c
rename to board/renesas/common/gen4-spl.c
diff --git a/board/renesas/rcar-common/v3-common.c b/board/renesas/common/v3-common.c
similarity index 100%
rename from board/renesas/rcar-common/v3-common.c
rename to board/renesas/common/v3-common.c
diff --git a/board/renesas/condor/Makefile b/board/renesas/condor/Makefile
index fe3a2fd3b7a..3b1756b44cd 100644
--- a/board/renesas/condor/Makefile
+++ b/board/renesas/condor/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= ../common/gen3-common.o ../common/common.o
 endif
diff --git a/board/renesas/draak/Makefile b/board/renesas/draak/Makefile
index 3ed7800b0e9..6ce05bcd649 100644
--- a/board/renesas/draak/Makefile
+++ b/board/renesas/draak/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= draak.o ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= draak.o ../common/gen3-common.o ../common/common.o
 endif
diff --git a/board/renesas/eagle/Makefile b/board/renesas/eagle/Makefile
index 3f5fdab1bc2..a5c18d81eef 100644
--- a/board/renesas/eagle/Makefile
+++ b/board/renesas/eagle/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/v3-common.o ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
 endif
diff --git a/board/renesas/ebisu/Makefile b/board/renesas/ebisu/Makefile
index 8139391029d..72130b76234 100644
--- a/board/renesas/ebisu/Makefile
+++ b/board/renesas/ebisu/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= ../common/gen3-common.o ../common/common.o
 endif
diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
index 48fcfac9105..949953f6981 100644
--- a/board/renesas/falcon/Makefile
+++ b/board/renesas/falcon/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
+obj-y	:= ../common/gen4-common.o ../common/common.o
 endif
diff --git a/board/renesas/grayhawk/Makefile b/board/renesas/grayhawk/Makefile
index 7414b773326..a70bd3739f1 100644
--- a/board/renesas/grayhawk/Makefile
+++ b/board/renesas/grayhawk/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
+obj-y	:= ../common/gen4-common.o ../common/common.o
diff --git a/board/renesas/salvator-x/Makefile b/board/renesas/salvator-x/Makefile
index fe7c78ef2ff..fe53366829c 100644
--- a/board/renesas/salvator-x/Makefile
+++ b/board/renesas/salvator-x/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= salvator-x.o ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= salvator-x.o ../common/gen3-common.o ../common/common.o
 endif
diff --git a/board/renesas/spider/Makefile b/board/renesas/spider/Makefile
index 9489917278c..e0f403d5fcc 100644
--- a/board/renesas/spider/Makefile
+++ b/board/renesas/spider/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
+obj-y	:= ../common/gen4-common.o ../common/common.o
diff --git a/board/renesas/ulcb/Makefile b/board/renesas/ulcb/Makefile
index c3c2f391e55..6b2aa8c29f6 100644
--- a/board/renesas/ulcb/Makefile
+++ b/board/renesas/ulcb/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ulcb.o cpld.o ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= ulcb.o cpld.o ../common/gen3-common.o ../common/common.o
 endif
diff --git a/board/renesas/v3hsk/Makefile b/board/renesas/v3hsk/Makefile
index ee04f67d986..936047cb3d5 100644
--- a/board/renesas/v3hsk/Makefile
+++ b/board/renesas/v3hsk/Makefile
@@ -8,8 +8,8 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/v3-common.o ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
 obj-$(CONFIG_SYSRESET)	+= cpld.o
 endif
diff --git a/board/renesas/v3msk/Makefile b/board/renesas/v3msk/Makefile
index 63e06a4b5fd..21eaddb6c28 100644
--- a/board/renesas/v3msk/Makefile
+++ b/board/renesas/v3msk/Makefile
@@ -8,8 +8,8 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../rcar-common/gen3-spl.o
+obj-y	:= ../common/gen3-spl.o
 else
-obj-y	:= ../rcar-common/v3-common.o ../rcar-common/gen3-common.o ../rcar-common/common.o
+obj-y	:= ../common/v3-common.o ../common/gen3-common.o ../common/common.o
 obj-$(CONFIG_SYSRESET)	+= cpld.o
 endif
diff --git a/board/renesas/whitehawk/Makefile b/board/renesas/whitehawk/Makefile
index 80f92e6b041..f10eb82d221 100644
--- a/board/renesas/whitehawk/Makefile
+++ b/board/renesas/whitehawk/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_SPL_BUILD
-obj-y	:= ../rcar-common/gen4-spl.o
+obj-y	:= ../common/gen4-spl.o
 else
-obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
+obj-y	:= ../common/gen4-common.o ../common/common.o
 endif
diff --git a/board/silinux/ek874/Makefile b/board/silinux/ek874/Makefile
index 879da9edacf..c1cab6fa788 100644
--- a/board/silinux/ek874/Makefile
+++ b/board/silinux/ek874/Makefile
@@ -7,7 +7,7 @@
 #
 
 ifdef CONFIG_XPL_BUILD
-obj-y	:= ../../renesas/rcar-common/gen3-spl.o
+obj-y	:= ../../renesas/common/gen3-spl.o
 else
-obj-y	:= ek874.o ../../renesas/rcar-common/gen3-common.o ../../renesas/rcar-common/common.o
+obj-y	:= ek874.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
 endif
-- 
2.45.2

