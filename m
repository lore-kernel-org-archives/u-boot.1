Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E64CFA468
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4489E83045;
	Fri, 21 Nov 2025 09:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kufidJny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657A9801CF; Fri, 21 Nov 2025 09:14:37 +0100 (CET)
Received: from mx-relay49-hz3.antispameurope.com
 (mx-relay49-hz3.antispameurope.com [94.100.134.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225598051F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=AR+Qd+zjlfaGm5pPUZ2hai0KuMw0nslJzlz/y/YIhiA=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763712874;
 b=OwCQfdjhi3SKGd9lgTV7jabo8Yc4bjMV8RfRJu+7oARyFEPRcVkDUn3YgbzejmJpSyW6LVQF
 q1GkS1c4ANOXVUGEDmZIFuWNyqGcG2OseLxz94buxNnv+YDtxyCXCrnsYQCjfD98b7/9uuL74+9
 En+MKdEdqW+5WK9jbSSdlqlDY8KB46gsdCfk77W8Xs2oqzX0TU7m04q76FPF4I3ebUWJWPkzjWr
 q41IdSkt0Dbn5cW44nfbnGai7ejYTxF99okdKLoEMYQoCZ46a5hIp5F0LvdKG6ZEPSro5dMVgOl
 R1vJuldjrniSGKTm6E/d7q19R+pwsqdu4UiPRYe6ISb/w==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763712874;
 b=gjaoKmW7aObzYZ+oabGup24IW2dwq2IvXXHRXoKG9Ryo6K0ZribtuGkpHAUCHhKblzeiI3ad
 6TAamEmugpZv2iMALwfe7VXWp05Pc7IyCNsETTTlOhsd3/bKSdGXlmSVb13xEAqqBUJlb7C5F5v
 VoWE4SROyeDTVOq7f4e0MHdv1Lou6V4O+0AwyHOP21ljQT3+VkIQjjgIuhO6dZ+FFnPEB2ZFt3h
 RZIS17ebzxiFDOo+HA2QBB1MzluXCnfXUczj1R4tpxojzWVrdDZerlS1Fx5TRFe1WadaxiBUe9O
 mSbOCOkTi1a/YYxAotulz5dB+0t9VwQvVE3IVxjgL6blw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay49-hz3.antispameurope.com; Fri, 21 Nov 2025 09:14:34 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 5DFB2220D7F; Fri, 21 Nov 2025 09:14:21 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH 3/4] board: [cosmetic] tqma6: adjust SPDX tag
Date: Fri, 21 Nov 2025 09:11:29 +0100
Message-ID: <20251121081138.73285-4-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
References: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay49-hz3.antispameurope.com with 4dCSg161PKz3ybJw
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: c599b951a958ede507347624dbb75845
X-cloud-security: scantime:1.963
DKIM-Signature: a=rsa-sha256;
 bh=AR+Qd+zjlfaGm5pPUZ2hai0KuMw0nslJzlz/y/YIhiA=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763712873; v=1;
 b=kufidJny5gUy1BuYJTcpTuRIuyLyIkv97uuFLV7X+MufOg9SqgRnmRzywjEVDdfEVUQ0syav
 wcrRJveAvzmC9htjOgABukh5d1V/7syqFdGVxCffsowPaIyWnio1XTGlOMRd+gruQ4oRGmnhSSt
 TLNaw4qWNASSqcd6PzXNKgfZjBUQcEuitYdk4VPYN/gRy/BEQwyifw5YxUMV/xVav7JDp1uUrrD
 4XHugYSNMKSGScIkK4kWm09VplVtWhEctLIMeMTwP6kgXkkN/aDBXgxK7Shl3JpP1TI4uKw8dlp
 ZyaAGrXZWXdnKK6rjFsawAyXITmTM28fwMkp8padqzqKQ==
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
 board/tq/tqma6/tqma6_mba6.c  | 8 +++++---
 board/tq/tqma6/tqma6_wru4.c  | 8 +++++---
 board/tq/tqma6/tqma6dl.cfg   | 6 ++++--
 board/tq/tqma6/tqma6q.cfg    | 6 ++++--
 board/tq/tqma6/tqma6s.cfg    | 6 ++++--
 include/configs/tqma6.h      | 6 ++++--
 include/configs/tqma6_mba6.h | 6 ++++--
 include/configs/tqma6_wru4.h | 2 +-
 11 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/board/tq/tqma6/Makefile b/board/tq/tqma6/Makefile
index 7271297c707..5fd05c07ecf 100644
--- a/board/tq/tqma6/Makefile
+++ b/board/tq/tqma6/Makefile
@@ -1,6 +1,9 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2014-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Markus Niebel
 #
-# Copyright (C) 2014, Markus Niebel <Markus.Niebel@tq-group.com>
 
 obj-y  := tqma6.o
 
diff --git a/board/tq/tqma6/clocks.cfg b/board/tq/tqma6/clocks.cfg
index 1f2001c75f0..3a094c36578 100644
--- a/board/tq/tqma6/clocks.cfg
+++ b/board/tq/tqma6/clocks.cfg
@@ -1,7 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (C) 2013 Boundary Devices
- * Copyright (C) 2013, 2014 Markus Niebel <Markus.Niebel@tq-group.com>
+ *
+ * Copyright (c) 2013-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 83db2d1ad38..4351ced39ec 100644
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
+ * Copyright (c) 2013-2023 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include <init.h>
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 630ffdd63a9..6d0ba43fa4a 100644
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
+ * Copyright (c) 2013-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
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
index 8cd1885b43f..eea4f1012ea 100644
--- a/board/tq/tqma6/tqma6dl.cfg
+++ b/board/tq/tqma6/tqma6dl.cfg
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2014 - 2015 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2014-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
index a345c4de93d..371035e6517 100644
--- a/board/tq/tqma6/tqma6q.cfg
+++ b/board/tq/tqma6/tqma6q.cfg
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/board/tq/tqma6/tqma6s.cfg b/board/tq/tqma6/tqma6s.cfg
index 02f7e109100..b1557b4638c 100644
--- a/board/tq/tqma6/tqma6s.cfg
+++ b/board/tq/tqma6/tqma6s.cfg
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
  * and create imximage boot image
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 329fe3c86ed..affc939abe0 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013, 2014, 2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  *
  * Configuration settings for the TQ-Systems TQMa6<Q,D,DL,S> module.
  */
diff --git a/include/configs/tqma6_mba6.h b/include/configs/tqma6_mba6.h
index b5871424bc6..9284e4669b5 100644
--- a/include/configs/tqma6_mba6.h
+++ b/include/configs/tqma6_mba6.h
@@ -1,6 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (C) 2013 - 2017 Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2013-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
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

