Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B225C47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9034878F5;
	Sun, 21 Jan 2024 18:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C6Y4TN3R";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UOZNO92O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF138775F; Sun, 21 Jan 2024 18:32:37 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A2A8783B
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TJ0mL5J08z9sTR;
 Sun, 21 Jan 2024 18:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuB3fY0SNVzmx/NaGOzrkvcKejw0dZUHKlaTNTsNPsE=;
 b=C6Y4TN3RPNdHBD9Sh7rYDSIDOnLeMplUc1ttl3Ms3mDobi/aFnnRRLYiARqTbLf0khpsVX
 vB9xLtNAI2FH8ucb/Yc0am9wL6K7c2aKx9A00EHgSqiIgFC93J8noSruNQq3xSABeWe6Gs
 WhUQYbSWM1s3FnP20ykmGQguMkR3fzDgXyWhMIKnjUFLQpNtInaIWckJT7991iZ5A7S1sq
 TlLmFmRga7EIdqriDFh4JGh+GpeXLVgwPB7qnX46d0hKyZ/RRkSVZK+sxSI9CYbroC1sh/
 A02PZCNTKHBMOeVJkqx0PFmwT2lnf5g0A53OlRztjaJriQZqowua6u13ooLJPg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuB3fY0SNVzmx/NaGOzrkvcKejw0dZUHKlaTNTsNPsE=;
 b=UOZNO92OjE6TrfpdoGori/HR6eImlXK+nWncphoUA2OlMjB4kifP673il03tJ6exUdTt88
 /CTvgaKf0MrPaeiSrf9Gf79HCCSO0fsm9ezoFIqDSRbANC8Ff+TsEd3ydsHi2qeQhPfoIe
 absSsUq6LLxK0sKjVUvwstKunymntCwt0P+Zij2IGQkdo2K+hAdRwlHumrwIuR/nUU3ROV
 uqOVaU1c2QkluvVSjMsBLzNKBqa9GAL47m96MclrQNXBBcJuGYV/HvFgI4bVtJtSg33+e6
 NJmYqtQo9SfYrJMU1V3sd+z7EEPik3nCbYTqDtg/ePg5+XUVOmK6s/2fZxaXsA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 3/3] ARM: renesas: Drop include common.h
Date: Sun, 21 Jan 2024 18:31:23 +0100
Message-ID: <20240121173211.273726-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ybxnsuhtuur8a5fut89tmn84hdbqhg8o
X-MBO-RS-ID: 620b5ea5b66475286cc
X-Rspamd-Queue-Id: 4TJ0mL5J08z9sTR
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

The header file is not necessary in either of those files,
remove it as common.h is going away.

Include missing asm/arch/rmobile.h in board/renesas/rcar-common/v3-common.c
to prevent build failure of r8a77970_eagle r8a779a0_falcon r8a77980_v3hsk
and r8a77970_v3msk .

Include missing asm/u-boot.h in falcon.c and grpeach.c to fix build failure
due to missing definition of struct bd_info . Include errno.h in grpeach.c
to fix build error due to missing definition of EINVAL.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 board/renesas/alt/alt.c               | 1 -
 board/renesas/alt/alt_spl.c           | 1 -
 board/renesas/alt/qos.c               | 1 -
 board/renesas/blanche/blanche.c       | 1 -
 board/renesas/blanche/qos.c           | 1 -
 board/renesas/draak/draak.c           | 1 -
 board/renesas/falcon/falcon.c         | 2 +-
 board/renesas/gose/gose.c             | 1 -
 board/renesas/gose/gose_spl.c         | 1 -
 board/renesas/gose/qos.c              | 1 -
 board/renesas/grpeach/grpeach.c       | 3 ++-
 board/renesas/koelsch/koelsch.c       | 1 -
 board/renesas/koelsch/koelsch_spl.c   | 1 -
 board/renesas/koelsch/qos.c           | 1 -
 board/renesas/lager/lager.c           | 1 -
 board/renesas/lager/lager_spl.c       | 1 -
 board/renesas/lager/qos.c             | 1 -
 board/renesas/porter/porter.c         | 1 -
 board/renesas/porter/porter_spl.c     | 1 -
 board/renesas/porter/qos.c            | 1 -
 board/renesas/r2dplus/r2dplus.c       | 1 -
 board/renesas/rcar-common/common.c    | 1 -
 board/renesas/rcar-common/gen3-spl.c  | 1 -
 board/renesas/rcar-common/v3-common.c | 2 +-
 board/renesas/salvator-x/salvator-x.c | 1 -
 board/renesas/silk/qos.c              | 1 -
 board/renesas/silk/silk.c             | 1 -
 board/renesas/silk/silk_spl.c         | 1 -
 board/renesas/spider/spider.c         | 1 -
 board/renesas/stout/cpld.c            | 1 -
 board/renesas/stout/qos.c             | 1 -
 board/renesas/stout/stout.c           | 1 -
 board/renesas/stout/stout_spl.c       | 1 -
 board/renesas/ulcb/cpld.c             | 1 -
 board/renesas/ulcb/ulcb.c             | 1 -
 board/renesas/v3hsk/cpld.c            | 1 -
 board/renesas/v3msk/cpld.c            | 1 -
 board/renesas/whitehawk/whitehawk.c   | 1 -
 38 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/board/renesas/alt/alt.c b/board/renesas/alt/alt.c
index 85fbaf0b28b..be77cade01b 100644
--- a/board/renesas/alt/alt.c
+++ b/board/renesas/alt/alt.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2014, 2015 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <hang.h>
diff --git a/board/renesas/alt/alt_spl.c b/board/renesas/alt/alt_spl.c
index cdaa04e4f4c..fc9dac55e6a 100644
--- a/board/renesas/alt/alt_spl.c
+++ b/board/renesas/alt/alt_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/alt/qos.c b/board/renesas/alt/qos.c
index 2f657505ceb..38dfa647e81 100644
--- a/board/renesas/alt/qos.c
+++ b/board/renesas/alt/qos.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/blanche.c
index 8e1ae29e221..c6ecea2afcf 100644
--- a/board/renesas/blanche/blanche.c
+++ b/board/renesas/blanche/blanche.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2016 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/renesas/blanche/qos.c b/board/renesas/blanche/qos.c
index e3ad83ee0c2..3134b36a443 100644
--- a/board/renesas/blanche/qos.c
+++ b/board/renesas/blanche/qos.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2016 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index 1ed72d34a74..06a3a832984 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/renesas/falcon/falcon.c b/board/renesas/falcon/falcon.c
index 0aa0f1afcbf..cd86bb3108c 100644
--- a/board/renesas/falcon/falcon.c
+++ b/board/renesas/falcon/falcon.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
@@ -15,6 +14,7 @@
 #include <asm/processor.h>
 #include <linux/errno.h>
 #include <asm/system.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/renesas/gose/gose.c b/board/renesas/gose/gose.c
index 2d1435acff6..6edbdac3ded 100644
--- a/board/renesas/gose/gose.c
+++ b/board/renesas/gose/gose.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2014 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/board/renesas/gose/gose_spl.c b/board/renesas/gose/gose_spl.c
index c0bf7204439..87126a0fc15 100644
--- a/board/renesas/gose/gose_spl.c
+++ b/board/renesas/gose/gose_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/gose/qos.c b/board/renesas/gose/qos.c
index 1c4ebfc6a8a..9944df76759 100644
--- a/board/renesas/gose/qos.c
+++ b/board/renesas/gose/qos.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2014 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/grpeach/grpeach.c b/board/renesas/grpeach/grpeach.c
index f609e4f0728..c475c3f50ab 100644
--- a/board/renesas/grpeach/grpeach.c
+++ b/board/renesas/grpeach/grpeach.c
@@ -4,12 +4,13 @@
  * Copyright (C) Chris Brandt
  */
 
-#include <common.h>
 #include <cpu_func.h>
+#include <errno.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
+#include <asm/u-boot.h>
 
 #define RZA1_WDT_BASE	0xfcfe0000
 #define WTCSR		0x00
diff --git a/board/renesas/koelsch/koelsch.c b/board/renesas/koelsch/koelsch.c
index c3ebcd3e39f..ee5597ad3d9 100644
--- a/board/renesas/koelsch/koelsch.c
+++ b/board/renesas/koelsch/koelsch.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/board/renesas/koelsch/koelsch_spl.c b/board/renesas/koelsch/koelsch_spl.c
index b377f707158..7581920f577 100644
--- a/board/renesas/koelsch/koelsch_spl.c
+++ b/board/renesas/koelsch/koelsch_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/koelsch/qos.c b/board/renesas/koelsch/qos.c
index f884e5fe650..70cd117ba6b 100644
--- a/board/renesas/koelsch/qos.c
+++ b/board/renesas/koelsch/qos.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
index 1437875cfa7..0daad0b1e6d 100644
--- a/board/renesas/lager/lager.c
+++ b/board/renesas/lager/lager.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2013 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/board/renesas/lager/lager_spl.c b/board/renesas/lager/lager_spl.c
index d3d397e8f0a..df3e240599a 100644
--- a/board/renesas/lager/lager_spl.c
+++ b/board/renesas/lager/lager_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/lager/qos.c b/board/renesas/lager/qos.c
index f01ca2fac71..ddc831c0c21 100644
--- a/board/renesas/lager/qos.c
+++ b/board/renesas/lager/qos.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2013,2014 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/porter/porter.c b/board/renesas/porter/porter.c
index db1fb4b035f..2e6051addb1 100644
--- a/board/renesas/porter/porter.c
+++ b/board/renesas/porter/porter.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2015 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/board/renesas/porter/porter_spl.c b/board/renesas/porter/porter_spl.c
index 8595770c364..039fc7b719e 100644
--- a/board/renesas/porter/porter_spl.c
+++ b/board/renesas/porter/porter_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/porter/qos.c b/board/renesas/porter/qos.c
index bca54f7f74c..e4d8f3dfafe 100644
--- a/board/renesas/porter/qos.c
+++ b/board/renesas/porter/qos.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/r2dplus/r2dplus.c b/board/renesas/r2dplus/r2dplus.c
index 4b9959a4326..78b8cb4ac34 100644
--- a/board/renesas/r2dplus/r2dplus.c
+++ b/board/renesas/r2dplus/r2dplus.c
@@ -4,7 +4,6 @@
  * Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
 #include <ide.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-common/common.c
index ed3f093bf3c..66eb6a2002c 100644
--- a/board/renesas/rcar-common/common.c
+++ b/board/renesas/rcar-common/common.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <hang.h>
diff --git a/board/renesas/rcar-common/gen3-spl.c b/board/renesas/rcar-common/gen3-spl.c
index b02a946a21d..44a20cef2df 100644
--- a/board/renesas/rcar-common/gen3-spl.c
+++ b/board/renesas/rcar-common/gen3-spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/renesas/rcar-common/v3-common.c b/board/renesas/rcar-common/v3-common.c
index 7c6202ea499..26c589d03e9 100644
--- a/board/renesas/rcar-common/v3-common.c
+++ b/board/renesas/rcar-common/v3-common.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2017-2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
+#include <asm/arch/rmobile.h>
 #include <asm/io.h>
 
 #define CPGWPR  0xE6150900
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 939b48ee300..d8312ddb8a9 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <image.h>
 #include <init.h>
diff --git a/board/renesas/silk/qos.c b/board/renesas/silk/qos.c
index 43a29898657..bdd76461b6a 100644
--- a/board/renesas/silk/qos.c
+++ b/board/renesas/silk/qos.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/silk/silk.c b/board/renesas/silk/silk.c
index 6ecebfe814d..18ff7591228 100644
--- a/board/renesas/silk/silk.c
+++ b/board/renesas/silk/silk.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2015 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <hang.h>
diff --git a/board/renesas/silk/silk_spl.c b/board/renesas/silk/silk_spl.c
index afb9f85ffc2..b899442c25a 100644
--- a/board/renesas/silk/silk_spl.c
+++ b/board/renesas/silk/silk_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/spider/spider.c b/board/renesas/spider/spider.c
index fd83a72229e..1eb75a6397f 100644
--- a/board/renesas/spider/spider.c
+++ b/board/renesas/spider/spider.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
diff --git a/board/renesas/stout/cpld.c b/board/renesas/stout/cpld.c
index b7c75f5aa65..f5bb549b7c0 100644
--- a/board/renesas/stout/cpld.c
+++ b/board/renesas/stout/cpld.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2015 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <asm/io.h>
diff --git a/board/renesas/stout/qos.c b/board/renesas/stout/qos.c
index c2f0b853871..9030ba7f61f 100644
--- a/board/renesas/stout/qos.c
+++ b/board/renesas/stout/qos.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2015 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <asm/processor.h>
 #include <asm/mach-types.h>
 #include <asm/io.h>
diff --git a/board/renesas/stout/stout.c b/board/renesas/stout/stout.c
index f069eccde97..131deac1c7a 100644
--- a/board/renesas/stout/stout.c
+++ b/board/renesas/stout/stout.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2015 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/renesas/stout/stout_spl.c b/board/renesas/stout/stout_spl.c
index c37c0557132..8ec02168106 100644
--- a/board/renesas/stout/stout_spl.c
+++ b/board/renesas/stout/stout_spl.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/ulcb/cpld.c b/board/renesas/ulcb/cpld.c
index 0c060a5323d..e72e45e3fb4 100644
--- a/board/renesas/ulcb/cpld.c
+++ b/board/renesas/ulcb/cpld.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2017 Cogent Embedded, Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 1477750f921..b2a16b03513 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2017 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/board/renesas/v3hsk/cpld.c b/board/renesas/v3hsk/cpld.c
index 6016f6daef9..1272aec7302 100644
--- a/board/renesas/v3hsk/cpld.c
+++ b/board/renesas/v3hsk/cpld.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <i2c.h>
diff --git a/board/renesas/v3msk/cpld.c b/board/renesas/v3msk/cpld.c
index aed616ac859..260755ac746 100644
--- a/board/renesas/v3msk/cpld.c
+++ b/board/renesas/v3msk/cpld.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm.h>
diff --git a/board/renesas/whitehawk/whitehawk.c b/board/renesas/whitehawk/whitehawk.c
index 32284b2ecc0..3423ebd2995 100644
--- a/board/renesas/whitehawk/whitehawk.c
+++ b/board/renesas/whitehawk/whitehawk.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
-- 
2.43.0

