Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01AC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 07:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4B488B5D;
	Fri, 19 Jul 2024 09:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h2YeZi8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDAB88B7A; Fri, 19 Jul 2024 09:05:26 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C7188B8C
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 09:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46J758oq033297;
 Fri, 19 Jul 2024 02:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721372708;
 bh=d1nk4VLLNAapRJfh98n/OdI1oTswA7ikl32dMDscEd0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=h2YeZi8TYvjl9/nvEczvQGD4KinMGJsh+QJKVr0VfhzmRgFrA/e8pIjQFH/tThqyR
 yeP0nK6uZRbkl3oyA5bs4ploGT4zgJ8EeXT9edH1Tl9zn+YXxdbx/pxe0GkoEvL+dv
 xEDuXUaUcvtXsKqwoNZtxvoHdB9oS1mD5zXXSMXs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46J758EP091528
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jul 2024 02:05:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jul 2024 02:05:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jul 2024 02:05:08 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46J74b4u094617;
 Fri, 19 Jul 2024 02:05:04 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V6 6/6] doc: beagle: am62x_beagleplay: Document the use of
 TIFS Stub
Date: Fri, 19 Jul 2024 12:33:13 +0530
Message-ID: <20240719070312.3771755-7-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719070312.3771755-1-d-gole@ti.com>
References: <20240719070312.3771755-1-d-gole@ti.com>
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

* Include the actual common documentation about the TIFS Stub and role
  it plays to enable Low Power Modes in the platform.
* Add the AM62x boot flow to show at which point the TIFS Stub actually
  gets loaded.
* Mention the TIFS Stub in the TISPL image format.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index 01f04beb55aa..8bd9e4001007 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -23,7 +23,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: ../ti/img/boot_diagram_k3_current.svg
+.. image:: ../ti/img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - On this platform, 'TI Foundational Security' (TIFS) functions as the
@@ -38,6 +38,10 @@ Sources:
     :start-after: .. k3_rst_include_start_boot_sources
     :end-before: .. k3_rst_include_end_boot_sources
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_lpm_firmware
+
 Build procedure:
 ----------------
 0. Setup the environment variables:
@@ -86,7 +90,7 @@ Image formats
 
 - tispl.bin
 
-.. image:: ../ti/img/dm_tispl.bin.svg
+.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Additional hardware for U-Boot development
-- 
2.34.1

