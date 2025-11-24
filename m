Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAA0CFD31C
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 07:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9365083C7B;
	Mon, 24 Nov 2025 08:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mHJpNlRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F5083BF1; Mon, 24 Nov 2025 08:57:34 +0100 (CET)
Received: from mx-relay48-hz3.antispameurope.com
 (mx-relay48-hz3.antispameurope.com [94.100.134.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7550A83BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0416cdc3b4=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=PPa8xVTJC+o609HCUJOTtjrviz+buQNsJmWNFrThuK0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763971049;
 b=B7OHkfKNzgySskzzVKM1xLauiGobTzpNjPNuPbdP7LkUr0M4Pg+nQRqpp7bA8bcFdyw9PLjl
 q1OV7yIcGkYENsnruZ61BKW1ci8/DOkZUN5BEwNxqKUsbvPOmm7L7I2PeU42/Gsder65dagkIfF
 AfHEFD33EZgAGr27KiEfgqPfYmyrlaq+Qy1WKTAl/mR5K7XcLQRP1GrLbnO9NXqFjP8seoM8JMP
 5Hjy+Cdx85CN29y2fMTqovRZlfpgV/JhyZ5RrDuo0JtGbvmIfDsDvLWHOTeTbNnB8hmN8mfiTC7
 diyGSkYu1QYNpeJvMoX8X1psi+YSqMBcaqnEbl5CdYFLQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763971049;
 b=Mwg7ZbhdP+K4LIZ5DGlmagfWoe3gTa+drT6NGWqNuETL4jUL+sf3jJeX4qHXJGKkunpwCWc1
 nm1SDbEhQyZwgECsYFT/3y9m81SB4qCuo4e21MO4XHf0XadjboSo5cSGlz42p9rBm+65sYMDIiR
 7/at/MDWnI30AWGO6BkI6IGkQFG3fhijmFgOD5ip6lybx/8qe5aHKP7aoJz8KsJBiSJ0fBG69lv
 1XMfnkVY4kGSXK4pWyOEg9jEnIUW6z4ShB42XrskgSWHKwqZV1T61rqHjv16RkilK+xrDl/+42Y
 TOjq7tOUmdnyAY8KdrEgutgAGYu+dR1DnTskoSYZKHiNA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay48-hz3.antispameurope.com; Mon, 24 Nov 2025 08:57:29 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 A5C7CCC0CC1; Mon, 24 Nov 2025 08:57:16 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH v2 3/4] board: [cosmetic] tqma6: adjust SPDX tag
Date: Mon, 24 Nov 2025 08:55:25 +0100
Message-ID: <20251124075540.14930-4-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
References: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay48-hz3.antispameurope.com with 4dFJ7x0Ptfz1kPGJc
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: dd4b23e07cd474853fa466d61f7809ee
X-cloud-security: scantime:1.869
DKIM-Signature: a=rsa-sha256;
 bh=PPa8xVTJC+o609HCUJOTtjrviz+buQNsJmWNFrThuK0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763971049; v=1;
 b=mHJpNlRTrvZA5IbKPHNdBFBrQWsuSUyF7f5iXb6YvrTNrCSVMppDH0LPaWjAyI08SiLN8wiw
 saaQmFzw9PRQ+iSEIoSmEnE6jtBgJH3MfTqqb+dbFDuPd7MNpe74FudrwEf+LF8BwaLUL6inFT6
 nGWu9zr8veQAC+4C3S2bMCZFmTcen/F4FzhYo38g+aeAR2hUmbEcY+y59vzHvOS7Kzh4qJ+3dry
 VTQf6slKaiO5m35aHfv1iD/6m1MmY9o5ZE9GoDFpA05XxedQ7hN1p7tcqGhvsRaUJO8Sx0cM5z9
 79gzEG0oH+xY14/qt9jTw9H5NYaWvy6B5WsOeFNcc+1Kw==
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

While at it, adjust the TQ-Systems copyright info to include
consistent company information, the mail address to reach all
developers at TQ-Systems for questions regarding U-Boot support
for our SOM and remove author's company mail address not suitable
for plain text mail.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Makefile      | 7 +++++--
 board/tq/tqma6/clocks.cfg    | 7 +++++--
 board/tq/tqma6/tqma6.c       | 8 +++++---
 board/tq/tqma6/tqma6_bb.h    | 7 ++++---
 board/tq/tqma6/tqma6_mba6.c  | 8 +++++---
 board/tq/tqma6/tqma6_wru4.c  | 8 +++++---
 board/tq/tqma6/tqma6dl.cfg   | 6 ++++--
 board/tq/tqma6/tqma6q.cfg    | 6 ++++--
 board/tq/tqma6/tqma6s.cfg    | 6 ++++--
 include/configs/tqma6.h      | 6 ++++--
 include/configs/tqma6_mba6.h | 6 ++++--
 include/configs/tqma6_wru4.h | 2 +-
 12 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/board/tq/tqma6/Makefile b/board/tq/tqma6/Makefile
index 7271297c707..f1b39844ac6 100644
--- a/board/tq/tqma6/Makefile
+++ b/board/tq/tqma6/Makefile
@@ -1,6 +1,9 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Markus Niebel
 #
-# Copyright (C) 2014, Markus Niebel <Markus.Niebel@tq-group.com>
 
 obj-y  := tqma6.o
 
diff --git a/board/tq/tqma6/clocks.cfg b/board/tq/tqma6/clocks.cfg
index 1f2001c75f0..c2e6d12b924 100644
--- a/board/tq/tqma6/clocks.cfg
+++ b/board/tq/tqma6/clocks.cfg
@@ -1,7 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (C) 2013 Boundary Devices
- * Copyright (C) 2013, 2014 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 83db2d1ad38..75d36240a1e 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -1,10 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  *
- * Copyright (C) 2013, 2014 TQ-Systems (ported SabreSD to TQMa6x)
- * Author: Markus Niebel <markus.niebel@tq-group.com>
+ * ported SabreSD to TQMa6x
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <init.h>
diff --git a/board/tq/tqma6/tqma6_bb.h b/board/tq/tqma6/tqma6_bb.h
index a2f871af1f8..e17e6ad3f57 100644
--- a/board/tq/tqma6/tqma6_bb.h
+++ b/board/tq/tqma6/tqma6_bb.h
@@ -1,7 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014 TQ-Systems
- * Author: Markus Niebel <markus.niebel@tq-group.com>
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #ifndef __TQMA6_BB__
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 630ffdd63a9..46989102fec 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -1,10 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  *
- * Copyright (C) 2013, 2014 TQ-Systems (ported SabreSD to TQMa6x)
- * Author: Markus Niebel <markus.niebel@tq-group.com>
+ * ported SabreSD to TQMa6x
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <init.h>
diff --git a/board/tq/tqma6/tqma6_wru4.c b/board/tq/tqma6/tqma6_wru4.c
index aa53212e0e8..7acefc7b064 100644
--- a/board/tq/tqma6/tqma6_wru4.c
+++ b/board/tq/tqma6/tqma6_wru4.c
@@ -1,10 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
  *
- * Copyright (C) 2013, 2014 TQ-Systems (ported SabreSD to TQMa6x)
- * Author: Markus Niebel <markus.niebel@tq-group.com>
+ * ported SabreSD to TQMa6x
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
diff --git a/board/tq/tqma6/tqma6dl.cfg b/board/tq/tqma6/tqma6dl.cfg
index 8cd1885b43f..f7289adb40a 100644
--- a/board/tq/tqma6/tqma6dl.cfg
+++ b/board/tq/tqma6/tqma6dl.cfg
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2014 - 2015 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2014-2015 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
index a345c4de93d..ad862535c50 100644
--- a/board/tq/tqma6/tqma6q.cfg
+++ b/board/tq/tqma6/tqma6q.cfg
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/board/tq/tqma6/tqma6s.cfg b/board/tq/tqma6/tqma6s.cfg
index 02f7e109100..e50fe3f57d7 100644
--- a/board/tq/tqma6/tqma6s.cfg
+++ b/board/tq/tqma6/tqma6s.cfg
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 329fe3c86ed..43ff0ad17c4 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014, 2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2014, 2017 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Configuration settings for the TQ-Systems TQMa6<Q,D,DL,S> module.
  */
diff --git a/include/configs/tqma6_mba6.h b/include/configs/tqma6_mba6.h
index b5871424bc6..9b9f4150951 100644
--- a/include/configs/tqma6_mba6.h
+++ b/include/configs/tqma6_mba6.h
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013 - 2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2017 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Configuration settings for the TQ-Systems TQMa6<Q,D,DL,S> module on
  * MBa6 starter kit
diff --git a/include/configs/tqma6_wru4.h b/include/configs/tqma6_wru4.h
index 5e21463305a..110bd895a8a 100644
--- a/include/configs/tqma6_wru4.h
+++ b/include/configs/tqma6_wru4.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
-- 
2.43.0

