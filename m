Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04451C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 08:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54275888F6;
	Thu,  4 Jul 2024 10:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x2x3WboN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E384C888D9; Thu,  4 Jul 2024 10:44:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE5A888CC
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 10:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4648hxfo041417;
 Thu, 4 Jul 2024 03:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720082639;
 bh=F7FAMIYTljuV34U6xUvibxHSrqZ8ZRpuYu6/ekVATjE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=x2x3WboNtqa/SfnsnXWSCmu7+EHeMeDXuTS8XukpULr69C7cV+uopyOaWFT6K1883
 g/wd283aoyh+2YaBppEYctohDEBmApx17N2pTaW6kTwZYiUnUtrmb8+hK5Pn0CXe0+
 ElkzOKQIXE3FF6bCUzF4lzultNPSHmvNi+xBb5Ko=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4648hxnZ038836
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 03:43:59 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 03:43:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 03:43:58 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4648hPV9010413;
 Thu, 4 Jul 2024 03:43:54 -0500
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
Subject: [PATCH V4 5/6] doc: ti: am62*: Mention TIFS Stub in img fmts and boot
 flow
Date: Thu, 4 Jul 2024 14:12:07 +0530
Message-ID: <20240704084207.2211801-6-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704084207.2211801-1-d-gole@ti.com>
References: <20240704084207.2211801-1-d-gole@ti.com>
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

Since AM62x, AM62P and AM62A all use similar boot flows and their low
power mode s/w ARCH is also similar in the way that they make use of the
TIFS Stub, update their documentation to show where TIFS Stub is.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/ti/am62ax_sk.rst | 4 ++--
 doc/board/ti/am62px_sk.rst | 4 ++--
 doc/board/ti/am62x_sk.rst  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 60726b6652ce..92da6f65f9d5 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -47,7 +47,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -144,7 +144,7 @@ Image formats:
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Switch Setting for Boot Mode
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index c80b50681176..3396aae471c6 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -55,7 +55,7 @@ Boot Flow:
 The bootflow is exactly the same as all SoCs in the am62xxx extended SoC
 family. Below is the pictorial representation:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -153,7 +153,7 @@ Image formats:
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index 2a25e84f6c97..68ddd2ac94ff 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -46,7 +46,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -161,7 +161,7 @@ Image formats:
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
-- 
2.34.1

