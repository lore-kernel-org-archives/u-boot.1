Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29F8C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5685388997;
	Mon,  5 Aug 2024 16:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TdIBq/M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D8F8895B; Mon,  5 Aug 2024 16:30:29 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34555889CA
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 475EUOnW109177;
 Mon, 5 Aug 2024 09:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722868224;
 bh=XosP9UeVo0s9nIqa1oQWpPcRPCyfTJrfHpEUoUVHu/o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TdIBq/M9HnyD7MLQc496qAWOmcTNNBhwWtB8q8yorlR9K12gG8vFu6LSjrYIZsmxf
 G/8txHuM7D09xnx7yBmX5I3kQFAzRttsMGxvN3/yBD3KyaYQFWTqzn0+gEPqq1njRS
 ZCf64zuZW8ZNwU7C5OSZyRErAcJjQSCYjTP70AIU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 475EUOQ9108232
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 5 Aug 2024 09:30:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 09:30:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 09:30:24 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 475ETiht084343;
 Mon, 5 Aug 2024 09:30:20 -0500
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
Subject: [PATCH V8 6/7] doc: beagle: am62x_beagleplay: Document the use of
 TIFS Stub
Date: Mon, 5 Aug 2024 19:59:36 +0530
Message-ID: <20240805142937.443737-7-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805142937.443737-1-d-gole@ti.com>
References: <20240805142937.443737-1-d-gole@ti.com>
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

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index 01f04beb55aa..bc71aabaac3e 100644
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
+    :end-before: .. k3_rst_include_end_tifsstub
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

