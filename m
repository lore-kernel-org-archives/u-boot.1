Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0B3C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 19:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD40F87EEA;
	Mon, 12 Feb 2024 20:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sRyY/2AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851F2875FC; Mon, 12 Feb 2024 20:47:52 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E8987CF0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 20:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CJlRZX127404;
 Mon, 12 Feb 2024 13:47:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707767247;
 bh=kqK7zV0ZzUhN+msx97f0YrXhrmx3aX1pzldnfR8+Gig=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=sRyY/2AVfh1d1NTPda2VacSuhgCaFeJ+YH7W6lbT1dYMp5vLxPKXM65SHpgECvCt9
 whbUJ5kfrOdracCLO6VNkxgF66u6G83N5PqMWOlydLBxY1oINOoiXJmzRoQm+uHfsU
 zb/k6PdFW+HpCajETPO1JudX02WzcHvwxB6w5ZZ4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CJlRgC010214
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Feb 2024 13:47:27 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 13:47:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 13:47:27 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CJlRIY005881;
 Mon, 12 Feb 2024 13:47:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/11] board: ti: am65x: Set fdtfile from C code instead of
 findfdt script
Date: Mon, 12 Feb 2024 13:47:21 -0600
Message-ID: <20240212194726.1093771-7-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212194726.1093771-1-nm@ti.com>
References: <20240212194726.1093771-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

We now can provide a map and have the standard fdtfile variable set from
code itself. This allows for bootstd to "just work".

While at this, replace findfdt in environment with a warning as it is no
longer needed.

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V3:
* No change

V3: https://lore.kernel.org/r/20240130130615.670783-7-nm@ti.com

 board/ti/am65x/am65x.env | 3 ---
 board/ti/am65x/evm.c     | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/ti/am65x/am65x.env b/board/ti/am65x/am65x.env
index 286b9c300c05..814374d68cf0 100644
--- a/board/ti/am65x/am65x.env
+++ b/board/ti/am65x/am65x.env
@@ -5,9 +5,6 @@
 #include <env/ti/k3_rproc.env>
 #endif
 
-findfdt=
-	setenv name_fdt ti/k3-am654-base-board.dtb;
-	setenv fdtfile ${name_fdt}
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index df209021c1b7..3109c9a2acac 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -22,6 +22,7 @@
 #include <linux/printk.h>
 
 #include "../common/board_detect.h"
+#include "../common/fdt_ops.h"
 
 #define board_is_am65x_base_board()	board_ti_is("AM6-COMPROCEVM")
 
@@ -141,6 +142,7 @@ static void setup_board_eeprom_env(void)
 
 invalid_eeprom:
 	set_board_info_env_am6(name);
+	ti_set_fdt_env(NULL, NULL);
 }
 
 static int init_daughtercard_det_gpio(char *gpio_name, struct gpio_desc *desc)
-- 
2.43.0

