Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB8FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F008768B;
	Wed,  1 Nov 2023 21:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2454B876AF; Wed,  1 Nov 2023 21:06:44 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 3B99D86487
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,269,1694703600"; d="scan'208";a="185272688"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 02 Nov 2023 05:06:35 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.52])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 106EA400F50E;
 Thu,  2 Nov 2023 05:06:32 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 2/8] arm: mach-rmobile: Drop <common.h>
Date: Wed,  1 Nov 2023 20:05:53 +0000
Message-Id: <20231101200600.119507-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
References: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
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

For most source files we can just drop <common.h>. We need to add an
include for <asm/u-boot.h> in a couple of places. Also sort the include
list in memmap-gen3.c while we're here.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/mach-rmobile/board.c            | 2 +-
 arch/arm/mach-rmobile/cpu_info-r8a7740.c | 2 +-
 arch/arm/mach-rmobile/cpu_info-rcar.c    | 2 +-
 arch/arm/mach-rmobile/cpu_info-rzg.c     | 2 +-
 arch/arm/mach-rmobile/cpu_info-rzg2l.c   | 1 -
 arch/arm/mach-rmobile/cpu_info.c         | 2 +-
 arch/arm/mach-rmobile/emac.c             | 1 -
 arch/arm/mach-rmobile/memmap-gen3.c      | 4 ++--
 arch/arm/mach-rmobile/memmap-rzg2l.c     | 2 +-
 arch/arm/mach-rmobile/pfc-r8a7740.c      | 2 +-
 arch/arm/mach-rmobile/psci-r8a779a0.c    | 1 -
 11 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-rmobile/board.c b/arch/arm/mach-rmobile/board.c
index a10371f74e0c..79c7e02671f2 100644
--- a/arch/arm/mach-rmobile/board.c
+++ b/arch/arm/mach-rmobile/board.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  * (C) Copyright 2012 Renesas Solutions Corp.
  */
-#include <common.h>
+
 #include <init.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-rmobile/cpu_info-r8a7740.c b/arch/arm/mach-rmobile/cpu_info-r8a7740.c
index dcbe25f37ab9..5a94235c4b9e 100644
--- a/arch/arm/mach-rmobile/cpu_info-r8a7740.c
+++ b/arch/arm/mach-rmobile/cpu_info-r8a7740.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  * (C) Copyright 2012 Renesas Solutions Corp.
  */
-#include <common.h>
+
 #include <asm/io.h>
 
 u32 rmobile_get_cpu_type(void)
diff --git a/arch/arm/mach-rmobile/cpu_info-rcar.c b/arch/arm/mach-rmobile/cpu_info-rcar.c
index 8fc4cd7f9de8..b9d8b5e57b5a 100644
--- a/arch/arm/mach-rmobile/cpu_info-rcar.c
+++ b/arch/arm/mach-rmobile/cpu_info-rcar.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2013,2014 Renesas Electronics Corporation
  */
-#include <common.h>
+
 #include <asm/io.h>
 
 #define PRR_MASK		0x7fff
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg.c b/arch/arm/mach-rmobile/cpu_info-rzg.c
index 1c18fd06f0b6..4ade4bc02198 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  *
  */
-#include <common.h>
+
 #include <linux/libfdt.h>
 
 /* If the firmware passed a device tree, use it for soc identification. */
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index de4892ee901e..f69649dc7eaf 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
 
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 6804b1da2cda..895c0f5336b6 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  * (C) Copyright 2012-2021 Renesas Solutions Corp.
  */
-#include <common.h>
+
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <init.h>
diff --git a/arch/arm/mach-rmobile/emac.c b/arch/arm/mach-rmobile/emac.c
index cb9bce0cf23b..95651626da4a 100644
--- a/arch/arm/mach-rmobile/emac.c
+++ b/arch/arm/mach-rmobile/emac.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  */
 
-#include <common.h>
 #include <net.h>
 #include <linux/errno.h>
 #include <netdev.h>
diff --git a/arch/arm/mach-rmobile/memmap-gen3.c b/arch/arm/mach-rmobile/memmap-gen3.c
index a68eb806b353..4dff9e07629d 100644
--- a/arch/arm/mach-rmobile/memmap-gen3.c
+++ b/arch/arm/mach-rmobile/memmap-gen3.c
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
-#include <cpu_func.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
+#include <cpu_func.h>
 
 #define GEN3_NR_REGIONS 16
 
diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-rmobile/memmap-rzg2l.c
index a08d0ea08fc0..9934a775220b 100644
--- a/arch/arm/mach-rmobile/memmap-rzg2l.c
+++ b/arch/arm/mach-rmobile/memmap-rzg2l.c
@@ -6,9 +6,9 @@
  * Copyright (C) 2023 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <cpu_func.h>
 
 #define RZG2L_NR_REGIONS 16
diff --git a/arch/arm/mach-rmobile/pfc-r8a7740.c b/arch/arm/mach-rmobile/pfc-r8a7740.c
index 5d42a68266b1..4f4847699b07 100644
--- a/arch/arm/mach-rmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-rmobile/pfc-r8a7740.c
@@ -18,7 +18,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
-#include <common.h>
+
 #include <sh_pfc.h>
 #include <asm/gpio.h>
 #include <asm/arch/irqs.h>
diff --git a/arch/arm/mach-rmobile/psci-r8a779a0.c b/arch/arm/mach-rmobile/psci-r8a779a0.c
index 6a85eb22cac2..b6c49e731f9d 100644
--- a/arch/arm/mach-rmobile/psci-r8a779a0.c
+++ b/arch/arm/mach-rmobile/psci-r8a779a0.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/secure.h>
-- 
2.39.2

