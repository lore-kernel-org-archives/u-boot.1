Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C98AC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A18A8804C;
	Tue, 27 Feb 2024 17:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ewQgRK/b";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aocaiJTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D046D88059; Tue, 27 Feb 2024 17:10:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156C988002
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TkjBN5qfXz9ssG;
 Tue, 27 Feb 2024 17:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jgABRf0pHcho/Kjs8tZDBYAl+IOC1mjyoKw8LeV5zU=;
 b=ewQgRK/b+uUtPC9Iu69Of1VgfFd7fPDpdlrZw+gPFkNLqKNN5tYaZrFZTyWd/Zn+sp411A
 VvVMD2G9dl2ZsbpQ+zXkM8W9L7cEn155uu7kuWW8o54tMkT2jeF2BxNd1qI/RRBJ0+xfzJ
 W67zy6qhG2Opo0g92nfuw+C7/ukM9ufia20bfjFDC1uFv+fMxlJGQqDZ72Gw7nS4nzZYaj
 e35bwubZr6N5qsDLPg65nSs+xtOY5LtGv0GKbaE+kRPsvaTh3VtYf1bi0D1wgol8lRpyxR
 +Iy1883so2zRTExrugL/L8CQfh1v1bnZyRfh1Qz0e0CFUFrEqzBvJ589UJytpA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jgABRf0pHcho/Kjs8tZDBYAl+IOC1mjyoKw8LeV5zU=;
 b=aocaiJTvSKoTdCM60DnN9QW0MUPjGXxu4SDAcJfNBc2yNtPTu3qzFJZv7+g7Vo8Ba66+lM
 Wie4pD7kmCKDGKGiKTaYRmsaXLfPbuEknVsKmJvfGci8vOwn8FGnxozOO8kPtP1ZK2HxLM
 qHrGUiOfznHWf6eKIGNrTvkrrKD3/nLnzrSW2dEplLGzLJPGmiwBJPzoGbLhbdv7AAZM3n
 nSseIHejwInpvlwbSi3wSOp9ZwJIVLZkbP+n3u6JNCal35GDi3974Lyzmmfn1ZvfN8Z/sy
 BFxS1l5JKRUvb0E4OrEhp0v1o3SmUwjorM/0aTQwz7kg9lLv9DQJtnFjerh6tw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/19] ARM: renesas: Rename rmobile.h to renesas.h
Date: Tue, 27 Feb 2024 17:05:54 +0100
Message-ID: <20240227160912.412181-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qszhskaquysk3463w1jyuiro8md8skqn
X-MBO-RS-ID: b70d305b6515371a110
X-Rspamd-Queue-Id: 4TkjBN5qfXz9ssG
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

Rename rmobile.h to renesas.h because all the chips are made
by Renesas, while only a subset of them is from the R-Mobile
line.

Use the following command to perform the rename:

"
$ git grep -l 'include.*rmobile.h' | \
  xargs -I {} sed -i '/include.*rmobile.h/ s@rmobile.h@renesas.h@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info-rzg2l.c                      | 2 +-
 arch/arm/mach-rmobile/include/mach/{rmobile.h => renesas.h} | 0
 board/hoperun/hihope-rzg2/hihope-rzg2.c                     | 2 +-
 board/renesas/alt/alt.c                                     | 2 +-
 board/renesas/alt/alt_spl.c                                 | 2 +-
 board/renesas/alt/qos.c                                     | 2 +-
 board/renesas/blanche/blanche.c                             | 2 +-
 board/renesas/blanche/qos.c                                 | 2 +-
 board/renesas/draak/draak.c                                 | 2 +-
 board/renesas/falcon/falcon.c                               | 2 +-
 board/renesas/gose/gose.c                                   | 2 +-
 board/renesas/gose/gose_spl.c                               | 2 +-
 board/renesas/gose/qos.c                                    | 2 +-
 board/renesas/grayhawk/grayhawk.c                           | 2 +-
 board/renesas/koelsch/koelsch.c                             | 2 +-
 board/renesas/koelsch/koelsch_spl.c                         | 2 +-
 board/renesas/koelsch/qos.c                                 | 2 +-
 board/renesas/lager/lager.c                                 | 2 +-
 board/renesas/lager/lager_spl.c                             | 2 +-
 board/renesas/lager/qos.c                                   | 2 +-
 board/renesas/porter/porter.c                               | 2 +-
 board/renesas/porter/porter_spl.c                           | 2 +-
 board/renesas/porter/qos.c                                  | 2 +-
 board/renesas/rcar-common/common.c                          | 2 +-
 board/renesas/rcar-common/v3-common.c                       | 2 +-
 board/renesas/salvator-x/salvator-x.c                       | 2 +-
 board/renesas/silk/qos.c                                    | 2 +-
 board/renesas/silk/silk.c                                   | 2 +-
 board/renesas/silk/silk_spl.c                               | 2 +-
 board/renesas/spider/spider.c                               | 2 +-
 board/renesas/stout/qos.c                                   | 2 +-
 board/renesas/stout/stout.c                                 | 2 +-
 board/renesas/stout/stout_spl.c                             | 2 +-
 board/renesas/ulcb/ulcb.c                                   | 2 +-
 board/renesas/whitehawk/whitehawk.c                         | 2 +-
 drivers/spi/sh_qspi.c                                       | 2 +-
 include/configs/rcar-gen2-common.h                          | 2 +-
 include/configs/rcar-gen3-common.h                          | 2 +-
 include/configs/rcar-gen4-common.h                          | 2 +-
 include/configs/rzg2l-smarc.h                               | 2 +-
 40 files changed, 39 insertions(+), 39 deletions(-)
 rename arch/arm/mach-rmobile/include/mach/{rmobile.h => renesas.h} (100%)

diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index a1683a26e35..ab95ce76388 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -4,7 +4,7 @@
  *
  */
 
-#include <mach/rmobile.h>
+#include <mach/renesas.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
 
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/renesas.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/rmobile.h
rename to arch/arm/mach-rmobile/include/mach/renesas.h
diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hihope-rzg2/hihope-rzg2.c
index 3372290120b..68d3d300dc4 100644
--- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
+++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
@@ -10,7 +10,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/processor.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
diff --git a/board/renesas/alt/alt.c b/board/renesas/alt/alt.c
index c61273489a0..d4283202394 100644
--- a/board/renesas/alt/alt.c
+++ b/board/renesas/alt/alt.c
@@ -22,7 +22,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <netdev.h>
 #include <miiphy.h>
diff --git a/board/renesas/alt/alt_spl.c b/board/renesas/alt/alt_spl.c
index fc9dac55e6a..260863fd0e2 100644
--- a/board/renesas/alt/alt_spl.c
+++ b/board/renesas/alt/alt_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/alt/qos.c b/board/renesas/alt/qos.c
index f0cdad4a80f..b8edd5412aa 100644
--- a/board/renesas/alt/qos.c
+++ b/board/renesas/alt/qos.c
@@ -9,7 +9,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 /* QoS version 0.311 for ES1 and version 0.321 for ES2 */
diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/blanche.c
index 80faae62624..7f00d25a1ca 100644
--- a/board/renesas/blanche/blanche.c
+++ b/board/renesas/blanche/blanche.c
@@ -10,7 +10,7 @@
 #include <init.h>
 #include <net.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
diff --git a/board/renesas/blanche/qos.c b/board/renesas/blanche/qos.c
index d18877ee6db..f0bc7f7698b 100644
--- a/board/renesas/blanche/qos.c
+++ b/board/renesas/blanche/qos.c
@@ -8,7 +8,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 enum {
diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index 6242d2858dc..a51bf65674f 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -22,7 +22,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <i2c.h>
 #include <mmc.h>
diff --git a/board/renesas/falcon/falcon.c b/board/renesas/falcon/falcon.c
index cd86bb3108c..27fccacf6f8 100644
--- a/board/renesas/falcon/falcon.c
+++ b/board/renesas/falcon/falcon.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/renesas/gose/gose.c b/board/renesas/gose/gose.c
index 74e6bca7893..b4b70d3a5b2 100644
--- a/board/renesas/gose/gose.c
+++ b/board/renesas/gose/gose.c
@@ -23,7 +23,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <netdev.h>
 #include <miiphy.h>
diff --git a/board/renesas/gose/gose_spl.c b/board/renesas/gose/gose_spl.c
index 87126a0fc15..f6fc96f5cbd 100644
--- a/board/renesas/gose/gose_spl.c
+++ b/board/renesas/gose/gose_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/gose/qos.c b/board/renesas/gose/qos.c
index fca30185231..29817e1841e 100644
--- a/board/renesas/gose/qos.c
+++ b/board/renesas/gose/qos.c
@@ -9,7 +9,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 /* QoS version 0.311 */
diff --git a/board/renesas/grayhawk/grayhawk.c b/board/renesas/grayhawk/grayhawk.c
index 6f2e73f7d38..6c8fca89679 100644
--- a/board/renesas/grayhawk/grayhawk.c
+++ b/board/renesas/grayhawk/grayhawk.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2023 Renesas Electronics Corp.
  */
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/renesas/koelsch/koelsch.c b/board/renesas/koelsch/koelsch.c
index 4d59b82a8ad..78f3f90ae3b 100644
--- a/board/renesas/koelsch/koelsch.c
+++ b/board/renesas/koelsch/koelsch.c
@@ -24,7 +24,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <netdev.h>
 #include <miiphy.h>
diff --git a/board/renesas/koelsch/koelsch_spl.c b/board/renesas/koelsch/koelsch_spl.c
index 7581920f577..2950b8df1dc 100644
--- a/board/renesas/koelsch/koelsch_spl.c
+++ b/board/renesas/koelsch/koelsch_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/koelsch/qos.c b/board/renesas/koelsch/qos.c
index c947fff75c7..ee893510060 100644
--- a/board/renesas/koelsch/qos.c
+++ b/board/renesas/koelsch/qos.c
@@ -9,7 +9,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* QoS version 0.240 for ES1 and version 0.411 for ES2 */
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
index ab06078c511..0ec8e3da4c2 100644
--- a/board/renesas/lager/lager.c
+++ b/board/renesas/lager/lager.c
@@ -26,7 +26,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/lager/lager_spl.c b/board/renesas/lager/lager_spl.c
index df3e240599a..0799ba136d5 100644
--- a/board/renesas/lager/lager_spl.c
+++ b/board/renesas/lager/lager_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/lager/qos.c b/board/renesas/lager/qos.c
index d12fdf0f11f..80e57107a94 100644
--- a/board/renesas/lager/qos.c
+++ b/board/renesas/lager/qos.c
@@ -8,7 +8,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* QoS version 0.955 for ES1 and version 0.973 for ES2 */
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
diff --git a/board/renesas/porter/porter.c b/board/renesas/porter/porter.c
index c0f91c75627..f38263cd944 100644
--- a/board/renesas/porter/porter.c
+++ b/board/renesas/porter/porter.c
@@ -24,7 +24,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <netdev.h>
 #include <miiphy.h>
diff --git a/board/renesas/porter/porter_spl.c b/board/renesas/porter/porter_spl.c
index 039fc7b719e..1643446c763 100644
--- a/board/renesas/porter/porter_spl.c
+++ b/board/renesas/porter/porter_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/porter/qos.c b/board/renesas/porter/qos.c
index da6ae9ac559..87274eeb6d9 100644
--- a/board/renesas/porter/qos.c
+++ b/board/renesas/porter/qos.c
@@ -10,7 +10,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* QoS version 0.240 for ES1 and version 0.334 for ES2 */
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index 66eb6a2002c..499c31408f6 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -14,7 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/uclass-internal.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <linux/libfdt.h>
 
 #ifdef CONFIG_RCAR_64
diff --git a/board/renesas/rcar-common/v3-common.c b/board/renesas/rcar-common/v3-common.c
index 26c589d03e9..5d057edb0a6 100644
--- a/board/renesas/rcar-common/v3-common.c
+++ b/board/renesas/rcar-common/v3-common.c
@@ -4,7 +4,7 @@
  */
 
 #include <clock_legacy.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/io.h>
 
 #define CPGWPR  0xE6150900
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index ca05285a09b..8c47246ae8b 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -23,7 +23,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <i2c.h>
 #include <mmc.h>
diff --git a/board/renesas/silk/qos.c b/board/renesas/silk/qos.c
index c1d4c612df8..00e5e792e19 100644
--- a/board/renesas/silk/qos.c
+++ b/board/renesas/silk/qos.c
@@ -10,7 +10,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
 /* QoS version 0.11 */
diff --git a/board/renesas/silk/silk.c b/board/renesas/silk/silk.c
index 7dfbd412f6d..cc64e44c0f7 100644
--- a/board/renesas/silk/silk.c
+++ b/board/renesas/silk/silk.c
@@ -23,7 +23,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <netdev.h>
 #include <miiphy.h>
diff --git a/board/renesas/silk/silk_spl.c b/board/renesas/silk/silk_spl.c
index b899442c25a..19b2e5ff87c 100644
--- a/board/renesas/silk/silk_spl.c
+++ b/board/renesas/silk/silk_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/spider/spider.c b/board/renesas/spider/spider.c
index 1eb75a6397f..414948f1831 100644
--- a/board/renesas/spider/spider.c
+++ b/board/renesas/spider/spider.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/renesas/stout/qos.c b/board/renesas/stout/qos.c
index 10f99f340b8..a3e512c4423 100644
--- a/board/renesas/stout/qos.c
+++ b/board/renesas/stout/qos.c
@@ -10,7 +10,7 @@
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* QoS version 0.955 for ES1 and version 0.973 for ES2 */
 #if defined(CONFIG_RENESAS_EXTRAM_BOOT)
diff --git a/board/renesas/stout/stout.c b/board/renesas/stout/stout.c
index 109e19a292d..f1d84b5a446 100644
--- a/board/renesas/stout/stout.c
+++ b/board/renesas/stout/stout.c
@@ -25,7 +25,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/stout/stout_spl.c b/board/renesas/stout/stout_spl.c
index 8ec02168106..3c7cac809eb 100644
--- a/board/renesas/stout/stout_spl.c
+++ b/board/renesas/stout/stout_spl.c
@@ -16,7 +16,7 @@
 #include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 
 #include <spl.h>
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 6addf2bc8b4..8f5de216995 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -21,7 +21,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/rcar-mstp.h>
 #include <i2c.h>
 #include <mmc.h>
diff --git a/board/renesas/whitehawk/whitehawk.c b/board/renesas/whitehawk/whitehawk.c
index a72f5e0a7a5..3a10b0220d1 100644
--- a/board/renesas/whitehawk/whitehawk.c
+++ b/board/renesas/whitehawk/whitehawk.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/spi/sh_qspi.c b/drivers/spi/sh_qspi.c
index 7dd1fe75e04..72594993853 100644
--- a/drivers/spi/sh_qspi.c
+++ b/drivers/spi/sh_qspi.c
@@ -13,7 +13,7 @@
 #include <malloc.h>
 #include <spi.h>
 #include <wait_bit.h>
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 
diff --git a/include/configs/rcar-gen2-common.h b/include/configs/rcar-gen2-common.h
index 291c2a43d4d..67c9faeca57 100644
--- a/include/configs/rcar-gen2-common.h
+++ b/include/configs/rcar-gen2-common.h
@@ -8,7 +8,7 @@
 #ifndef __RCAR_GEN2_COMMON_H
 #define __RCAR_GEN2_COMMON_H
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* console */
 #define CFG_SYS_BAUDRATE_TABLE	{ 38400, 115200 }
diff --git a/include/configs/rcar-gen3-common.h b/include/configs/rcar-gen3-common.h
index 213caa75238..5f4d5ced78f 100644
--- a/include/configs/rcar-gen3-common.h
+++ b/include/configs/rcar-gen3-common.h
@@ -9,7 +9,7 @@
 #ifndef __RCAR_GEN3_COMMON_H
 #define __RCAR_GEN3_COMMON_H
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* boot option */
 
diff --git a/include/configs/rcar-gen4-common.h b/include/configs/rcar-gen4-common.h
index c4f506df62d..3465b4d1821 100644
--- a/include/configs/rcar-gen4-common.h
+++ b/include/configs/rcar-gen4-common.h
@@ -9,7 +9,7 @@
 #ifndef __RCAR_GEN4_COMMON_H
 #define __RCAR_GEN4_COMMON_H
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* Console */
 #define CFG_SYS_BAUDRATE_TABLE	{ 38400, 115200, 921600, 1843200 }
diff --git a/include/configs/rzg2l-smarc.h b/include/configs/rzg2l-smarc.h
index ea57d280cb8..580613068b1 100644
--- a/include/configs/rzg2l-smarc.h
+++ b/include/configs/rzg2l-smarc.h
@@ -6,7 +6,7 @@
 #ifndef __RENESAS_RZG2L_H
 #define __RENESAS_RZG2L_H
 
-#include <asm/arch/rmobile.h>
+#include <asm/arch/renesas.h>
 
 /* console */
 #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 38400 }
-- 
2.43.0

