Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73273C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10245886B2;
	Fri, 19 Apr 2024 22:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="laZW7KEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E674A88553; Fri, 19 Apr 2024 22:58:02 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9424388629
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvjwN126628;
 Fri, 19 Apr 2024 15:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713560265;
 bh=40BarT9xttsOnNs49f4ssB1ksFa0JWVNSX24rBm59dk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=laZW7KEL5Az4IjwoD5P+5ZtkYjMNXQZO6qADXqUshxkNYRESfIi3HxHbr8VFfpfiA
 RRLCVwcw82k/cKbyMdpdtCPMSJmN50M4RH2iyfxDzMahJ4WcLMJLP/vPP+LTU8M6VT
 gm9xaw0ja6VSph32G8s65BHrc/sEeESSZc+UU1Is=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JKvjJL114381
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 15:57:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 15:57:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 15:57:45 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JKvjCE090918;
 Fri, 19 Apr 2024 15:57:45 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v3 07/19] doc: board: ti: j721e: document OSPI layout
Date: Fri, 19 Apr 2024 15:56:49 -0500
Message-ID: <20240419205701.163821-8-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419205701.163821-1-j-humphreys@ti.com>
References: <20240419205701.163821-1-j-humphreys@ti.com>
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

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/board/ti/j721e_evm.rst | 85 +++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index a422a9bf1a0..a0fc37ab6d7 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -150,6 +150,60 @@ Image formats:
 .. image:: img/sysfw.itb.svg
   :alt: sysfw.itb image format
 
+OSPI:
+-----
+ROM supports booting from OSPI from offset 0x0.
+
+Flashing images to OSPI:
+
+Below commands can be used to download tiboot3.bin, tispl.bin, u-boot.img,
+and sysfw.itb over tftp and then flash those to OSPI at their respective
+addresses.
+
+.. prompt:: bash =>
+
+  sf probe
+  tftp ${loadaddr} tiboot3.bin
+  sf update $loadaddr 0x0 $filesize
+  tftp ${loadaddr} tispl.bin
+  sf update $loadaddr 0x80000 $filesize
+  tftp ${loadaddr} u-boot.img
+  sf update $loadaddr 0x280000 $filesize
+  tftp ${loadaddr} sysfw.itb
+  sf update $loadaddr 0x6C0000 $filesize
+
+Flash layout for OSPI:
+
+    .. code-block:: console
+
+             0x0 +----------------------------+
+                 |     ospi.tiboot3(512K)     |
+                 |                            |
+         0x80000 +----------------------------+
+                 |     ospi.tispl(2M)         |
+                 |                            |
+        0x280000 +----------------------------+
+                 |     ospi.u-boot(4M)        |
+                 |                            |
+        0x680000 +----------------------------+
+                 |     ospi.env(128K)         |
+                 |                            |
+        0x6A0000 +----------------------------+
+                 |   ospi.env.backup (128K)   |
+                 |                            |
+        0x6C0000 +----------------------------+
+                 |      ospi.sysfw(1M)        |
+                 |                            |
+        0x7C0000 +----------------------------+
+                 |      padding (256k)        |
+        0x800000 +----------------------------+
+                 |     ospi.rootfs(UBIFS)     |
+                 |                            |
+       0x3FE0000 +----------------------------+
+                 |   ospi.phypattern (128k)   |
+                 |                            |
+                 +----------------------------+
+
 R5 Memory Map:
 --------------
 
@@ -193,35 +247,8 @@ R5 Memory Map:
      - 0x41cffbfc
      - 0x41cfffff
 
-OSPI:
------
-ROM supports booting from OSPI from offset 0x0.
-
-Flashing images to OSPI:
-
-Below commands can be used to download tiboot3.bin, tispl.bin, u-boot.img,
-and sysfw.itb over tftp and then flash those to OSPI at their respective
-addresses.
-
-.. prompt:: bash =>
-
-  sf probe
-  tftp ${loadaddr} tiboot3.bin
-  sf update $loadaddr 0x0 $filesize
-  tftp ${loadaddr} tispl.bin
-  sf update $loadaddr 0x80000 $filesize
-  tftp ${loadaddr} u-boot.img
-  sf update $loadaddr 0x280000 $filesize
-  tftp ${loadaddr} sysfw.itb
-  sf update $loadaddr 0x6C0000 $filesize
-
-Flash layout for OSPI:
-
-.. image:: img/ospi_sysfw.svg
-  :alt: OSPI flash partition layout
-
-Firmwares:
-----------
+Firmware:
+---------
 
 The J721e u-boot allows firmware to be loaded for the Cortex-R5 subsystem.
 The CPSW5G in J7200 and CPSW9G in J721E present in MAIN domain is configured
-- 
2.34.1

