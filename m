Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6213EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA6B864D5;
	Tue, 22 Aug 2023 18:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S4X3hc38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02756864D1; Tue, 22 Aug 2023 18:41:23 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34FF864D0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBi7022202;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=ZYbECZh8o6oNu6uewM4TUWTXNTY9YZAodUouHAHOCtc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=S4X3hc38HG3Lo6cuZn8ZAJ2s5JbWV+hZwQ0As/AvE2+ei4TNndWP38Yo7EbYurY3N
 csSnfyI9Dl7KEGzmWVlDdmVf78S0qD7AQofhTQaHdobyL+ZjynXiwji1BrBz/Zd1nW
 6ldmfhHlcY1hSyeGjMysbsitgFYqz3Ei4nyfI5dk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfBdh071226
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfA9O020728;
 Tue, 22 Aug 2023 11:41:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 05/13] doc: board: ti: am65x: provide image alt text
Date: Tue, 22 Aug 2023 11:40:59 -0500
Message-ID: <20230822164107.2272231-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822164107.2272231-1-nm@ti.com>
References: <20230822164107.2272231-1-nm@ti.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Provide alternative text for image.

Fixes: fd358121bdb8 ("doc: board: ti: am65x: Update with boot flow diagram")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes:
* Added missing updates of alt tag
* Fixed up a few text info
* now based on next

V1: https://lore.kernel.org/r/20230819030531.31051-1-heinrich.schuchardt@canonical.com
 doc/board/ti/am65x_evm.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 5f3c46cf9f9e..10e30f45cfd9 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -46,6 +46,7 @@ applications. This should happen before running Linux.
 instead use Falcon boot flow to reduce boot time.
 
 .. image:: img/boot_diagram_am65.svg
+  :alt: Boot flow diagram
 
 - Here DMSC acts as master and provides all the critical services. R5/A53
   requests DMSC to get these services done as shown in the above diagram.
@@ -136,14 +137,17 @@ Image formats:
 - tiboot3.bin
 
 .. image:: img/no_multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
 
 - tispl.bin
 
 .. image:: img/nodm_tispl.bin.svg
+  :alt: tispl.bin image format
 
 - sysfw.itb
 
 .. image:: img/sysfw.itb.svg
+  :alt: sysfw.itb image format
 
 eMMC:
 -----
@@ -185,6 +189,7 @@ used:
 eMMC layout:
 
 .. image:: img/emmc_am65x_evm_boot0.svg
+  :alt: emmc boot partition layout
 
 Kernel image and DT are expected to be present in the /boot folder of rootfs.
 To boot kernel from eMMC, use the following commands:
@@ -220,6 +225,7 @@ addresses.
 Flash layout for OSPI:
 
 .. image:: img/ospi_sysfw.svg
+  :alt: OSPI flash partition layout
 
 Kernel Image and DT are expected to be present in the /boot folder of UBIFS
 ospi.rootfs just like in SD card case. U-Boot looks for UBI volume named
-- 
2.40.0

