Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97164E810A2
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 08:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F76686DAF;
	Wed, 27 Sep 2023 10:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZTikc7dT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BFC86D43; Wed, 27 Sep 2023 10:21:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFDC86D73
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 10:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R8LDI4046042;
 Wed, 27 Sep 2023 03:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695802873;
 bh=TeMqMFlvmDkqp+1MaH3oez8Vfk84656udxaeiX1nAzM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZTikc7dTDv6WDO+e2eDjx/zVIrrbbe6nrAk9kIHoz7Pt+RhS49875Ot2SfgbzCgoG
 R+zq2DHsidoPfUB7tNFBSiJOeSGEPfRaD/P5h/VPoT+spoTtbtl7nmY7fATEpmPtRn
 9waNJWfmBIEXv5jOkBXwmuiG58kJmMniD5uRYQyk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R8LDEH093965
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 03:21:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 03:21:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 03:21:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R8LCHa021323;
 Wed, 27 Sep 2023 03:21:13 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 4/4] board: ti: am62x: add am62x_lpsk_* defconfigs and env
 files
Date: Wed, 27 Sep 2023 13:51:05 +0530
Message-ID: <20230927082105.3729470-5-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927082105.3729470-1-n-yadav@ti.com>
References: <20230927082105.3729470-1-n-yadav@ti.com>
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

Add defconfig fragments for AM62x LP SK and corresponding
customized environment file for AM62x LP SK.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 board/ti/am62x/am62x_lpsk_a53.config |  5 +++++
 board/ti/am62x/am62x_lpsk_r5.config  |  5 +++++
 board/ti/am62x/am62xlpsk.env         | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
 create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
 create mode 100644 board/ti/am62x/am62xlpsk.env

diff --git a/board/ti/am62x/am62x_lpsk_a53.config b/board/ti/am62x/am62x_lpsk_a53.config
new file mode 100644
index 0000000000..a568324997
--- /dev/null
+++ b/board/ti/am62x/am62x_lpsk_a53.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-lp-sk"
+CONFIG_SPL_OF_LIST="k3-am62-lp-sk"
+CONFIG_OF_LIST="k3-am62-lp-sk"
diff --git a/board/ti/am62x/am62x_lpsk_r5.config b/board/ti/am62x/am62x_lpsk_r5.config
new file mode 100644
index 0000000000..1532f4e336
--- /dev/null
+++ b/board/ti/am62x/am62x_lpsk_r5.config
@@ -0,0 +1,5 @@
+# Defconfig fragment to apply on top of am62x_evm_r5_defconfig
+
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"
+CONFIG_SPL_OF_LIST="k3-am62-r5-lp-sk"
+CONFIG_OF_LIST="k3-am62-r5-lp-sk"
diff --git a/board/ti/am62x/am62xlpsk.env b/board/ti/am62x/am62xlpsk.env
new file mode 100644
index 0000000000..3b79ae1b3f
--- /dev/null
+++ b/board/ti/am62x/am62xlpsk.env
@@ -0,0 +1,21 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/default_findfdt.env>
+#include <env/ti/mmc.env>
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
+boot=mmc
+mmcdev=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
+
+splashfile=ti.gz
+splashimage=0x80200000
+splashpos=m,m
+splashsource=sf
-- 
2.25.1

