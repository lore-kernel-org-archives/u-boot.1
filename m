Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D25C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C579C80BA8;
	Wed, 29 Jan 2025 18:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lBPZAqHx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vNhzLyAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC1580BA9; Wed, 29 Jan 2025 18:05:40 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB8780A09
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YjpSd4yPwz9sWS;
 Wed, 29 Jan 2025 18:05:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4CCwEgs/UT/ndY0KtEN1ft+fXOyPuDOacCRWkn3LT2s=;
 b=lBPZAqHx31uKPLNpFOMAU5a05eZ1QszXOApDNFZxdPP+kv9XVrlUonatzpfhehOHv8fqsh
 aiW7YqhHgUmkH+aT6HXNL2sWp3KMnfDcp+c++3Av5y85ReUyebyyjkTIY0slBXkKz8SkEF
 AJe0uD43H83owMAPV5HvgdZtpbVBpJWxNPH5+jgGYNWy3eiavowrzjRL0ERYon7PzUqCoi
 rVJeK5YYeW9pBPCYYFx1Tpe7wkdw3iTCKM0b0IDXqK65hY4kPtqfEZ8fYquKnO0Yv+vRUT
 30JGsr2WmjsDDvtl5sa7sIfdUXaA3IUmql75sLKN5inxPQ748pCNy4Y/+DIJkw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4CCwEgs/UT/ndY0KtEN1ft+fXOyPuDOacCRWkn3LT2s=;
 b=vNhzLyAkU0QbbNc/oyX9n7WW0HtlvIGxYFj+Ev5RZMinxQBNQfoajpU9Mot5iSAy1WYvH2
 xP5YaUL3uwasdR8K0eRbo3/IKZ/8CZNz69Xgxn9vnZSHdZeDb3Kbx3EGidGqd0ytLpZbPc
 Z65G8Itm9G5iaylYHoPQTDCY16lqK06aa7CSHbaMGDoAlbQwgNt9p28wl/2ud8UQV9f0tZ
 D9CU8TGtZVW1EqQKGvz+Mfi/opRQUI4lKcCJHK8fHHwlUvEYn3BByOz80CmgxMfrsuocB9
 1U3CDRRkXE2nqaz1iq3/HAjcUgtSz1EHz59zNpXbGywDVIV9gc5vD/eE4s1ZOA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Adam Ford <aford173@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/9] ARM: renesas: Rename board/renesas/rcar-common to
 board/renesas/common
Date: Wed, 29 Jan 2025 18:04:26 +0100
Message-ID: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9973aa0f3fac94e2cca
X-MBO-RS-META: qkcgboojteyqf7edstp9bd4s3apo1us4
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
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
V2: - Create empty Makefile in board/renesas/common/Makefile
    - Update commit message
V3: - Add RB from Quentin
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

