Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39820C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6C980AE5;
	Wed, 29 Jan 2025 23:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KK/ROpW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567CE80C99; Wed, 29 Jan 2025 23:52:38 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51500807DC
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50TMqYjs1392299
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 16:52:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738191154;
 bh=LCw7q4gXTdFCD2HNglQ1gPO+bThsLt3xKsZ60o4r/WE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KK/ROpW8jl0qLw3FUGF4BuNiQ7sZlyeyNBvRY3qJ9UwKAkp5eHVKfTL9I744IQACd
 3kqX6snOb9b7cvygBkBFBhqmWQh/xo16e4vKoHvutfjn27XobQiIqwl412xB8NF2TV
 4jKev+48Csu37f8RM/xVMach03oyeWEf/eSchgb4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50TMqYV9021501
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Jan 2025 16:52:34 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Jan 2025 16:52:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Jan 2025 16:52:34 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50TMqXBJ125009;
 Wed, 29 Jan 2025 16:52:34 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Daniel Schultz
 <d.schultz@phytec.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH v2 3/4] env: ti: am64x: set rproc_fw_binaries
Date: Wed, 29 Jan 2025 16:52:32 -0600
Message-ID: <20250129225233.467139-4-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250129225233.467139-1-jm@ti.com>
References: <20250129225233.467139-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Hari Nagalla <hnagalla@ti.com>

Set remote proc FW binaries for u-boot loading of remote cores.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 board/ti/am64x/am64x.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
index 8ad805a613c..43e557b8ec7 100644
--- a/board/ti/am64x/am64x.env
+++ b/board/ti/am64x/am64x.env
@@ -2,6 +2,10 @@
 #include <env/ti/mmc.env>
 #include <env/ti/k3_dfu.env>
 
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
@@ -14,6 +18,8 @@ bootpart=1:2
 bootdir=/boot
 rd_spec=-
 
+rproc_fw_binaries= 0 /lib/firmware/am64-mcu-m4f0_0-fw 1 /lib/firmware/am64-main-r5f0_0-fw 2 /lib/firmware/am64-main-r5f0_1-fw 3 /lib/firmware/am64-main-r5f1_0-fw 4 /lib/firmware/am64-main-r5f1_1-fw
+
 args_usb=run finduuid;setenv bootargs console=${console}
 	${optargs}
 	root=PARTUUID=${uuid} rw
-- 
2.48.0

