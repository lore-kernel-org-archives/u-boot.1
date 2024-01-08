Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0B4C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F2387B17;
	Mon,  8 Jan 2024 18:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YKURWd4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6157C87ACD; Mon,  8 Jan 2024 18:33:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E8787AE2
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408HX9Kw109418;
 Mon, 8 Jan 2024 11:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704735189;
 bh=lmGbwUxOm8WUbtUCjVKAbSQqbASi+186zfnn05vp7PE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YKURWd4lOPSKjkoYBQECfuvc+j5kUwUxODfEwy1x+RNUfChNmqMpufN9BENGtFcD+
 LcImfiapxIpvsV1oguIzXIDXZISgZKZBDFVPwaJn80QMB6pQ5XwI77LRA84vrgKXDc
 091cDLUBQqLOc8pp1QlUGPHjBYDjvtPMvbOu3o1s=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408HX9Vn072363
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 11:33:09 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 11:33:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 11:33:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408HX82l109322;
 Mon, 8 Jan 2024 11:33:08 -0600
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
Subject: [PATCH 05/10] board: ti: am65x: Set fdtfile from C code instead of
 findfdt script
Date: Mon, 8 Jan 2024 11:32:56 -0600
Message-ID: <20240108173301.2692332-6-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108173301.2692332-1-nm@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
MIME-Version: 1.0
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

Signed-off-by: Nishanth Menon <nm@ti.com>
---
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

