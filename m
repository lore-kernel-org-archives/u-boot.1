Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D1C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 16:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612B1889D5;
	Fri,  5 Jul 2024 18:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uYl2GIdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C043188905; Fri,  5 Jul 2024 18:49:53 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2AF7889D0
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 18:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465GngiL062295;
 Fri, 5 Jul 2024 11:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720198182;
 bh=aurFAScMU217vUsKajocEDQGAXW75duGzLIdQ6WRjoc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uYl2GIdibByZrRxX4vcPFU30QaQwMvzNW4EaCvrg9sRUaaM6y/WUD74+eYmHkn8MF
 z9RzAGMuE4BK9/YrojeH7F5FuauvKDNTSwAz+8vIF397wgp0wDUmr2cVzvGQR8i1Qb
 RmsJfxAuACqrx921OpTVSNkGdIDpeG374ahFA7B8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465GngB5001356
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jul 2024 11:49:42 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 11:49:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 11:49:42 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465Gmhd3028675;
 Fri, 5 Jul 2024 11:49:38 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V5 4/6] doc: ti: k3: Add TIFS Stub documentation
Date: Fri, 5 Jul 2024 22:18:31 +0530
Message-ID: <20240705164833.2386549-5-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705164833.2386549-1-d-gole@ti.com>
References: <20240705164833.2386549-1-d-gole@ti.com>
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

Add documentation to briefly explain the role of TIFS Stub in relevant
K3 SoC's.
This also sheds light on why TIFS Stub isn't package with the DM firmware
itself.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/ti/k3.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 67b066a07d3a..c80060662074 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -193,6 +193,17 @@ online
     device resources such as power, clock, interrupts, dma etc. This firmware
     runs on a dedicated or multi-use microcontroller outside the security
     enclave.
+  * **TIFS Stub** - A small piece of code that helps restore the remaining
+    context and resume the TIFS firmware when resuming from Low Power Modes
+    like Suspend-to-RAM/ Deep Sleep. It is loaded into the ATCM (Tightly
+    Coupled Memory 'A' of the DM R5) during DM startup. The reason it isn't
+    merged with DM is because in HS devices we need to sign the tifs-stub with
+    customer key. The DM cannot have a component signed using a customer key
+    because a HS device customer owns the customer key and only customer
+    has the access for the customer key. Since TIFS Stub signing has to happen
+    from the customer side but DM is released by TI, we need to allow binman to
+    sign the TIFS Stub and only then package it alongside other firmwares.
+    This applies only to AM62x, AM62A and AM62P based devices.
 
  OR
 
-- 
2.34.1

